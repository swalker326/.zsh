# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ -d ${ZDOTDIR:-~}/.zplugins/zsh-safe-rm ]] || \
  git clone --recursive --depth 1 https://github.com/mattmc3/zsh-safe-rm ${ZDOTDIR:-~}/.zplugins/zsh-safe-rm
source ${ZDOTDIR:-~}/.zplugins/zsh-safe-rm/zsh-safe-rm.plugin.zsh

# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
alias weather="curl wttr.in"
alias scripts="jq '.scripts' package.json"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

gwth() {
  echo "Git Worktree ZSH Commands:"
  echo "-------------------------"
  echo "gwtl       - List all worktrees"
  echo "gwtadd     - Add a worktree (usage: gwtadd ../path branch-name)"
  echo "gwtrm      - Remove a worktree (usage: gwtrm path-to-worktree)"
  echo "gwtmv      - Move a worktree (usage: gwtmv path-to-worktree new-path)"
  echo "gwtp       - Prune worktree information"
  echo "gwtnew     - Create a new branch and worktree (usage: gwtnew branch-name [start-point])"
  echo "gwth       - Display this help message"
}
# Git worktree aliases
alias gwtpr='git worktree prune'
alias gwtl='git worktree list'  # List all worktrees
alias gwtadd='git worktree add'  # Add a worktree (use: gwtadd ../path branch-name)
alias gwtrm='git worktree remove'  # Remove a worktree (use: gwtrm path-to-worktree)
alias gwtmv='git worktree move'  # Move a worktree (use: gwtmv path-to-worktree new-path)
alias gwtp='git worktree prune'  # Prune worktree information

# More advanced worktree function
  gwtnew() {
    if [ "$#" -lt 2 ]; then
      echo "Usage: gwtnew BRANCH_NAME PATH [START_POINT]"
      return 1
    fi

    # Get the directory path and basename
    dir_path=$(dirname "$2")
    base_name=$(basename "$2")

    # Add "WT-" prefix to the directory name
    new_path="${dir_path}/WT-${base_name}"

    git worktree add -b "$1" "$new_path" "${3:-HEAD}"
  }

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

alias nzc='rm -rf ~/.zephyr'
plugins=(
  git
  zsh-autosuggestions
  )

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# ---- Eza (better ls) -----

alias ls="eza --icons=always"

# bun completions
[ -s "/Users/shanewalker/.bun/_bun" ] && source "/Users/shanewalker/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Setup Compiler paths for readline and openssl
local READLINE_PATH=$(brew --prefix readline)
local OPENSSL_PATH=$(brew --prefix openssl)
export LDFLAGS="-L$READLINE_PATH/lib -L$OPENSSL_PATH/lib"
export CPPFLAGS="-I$READLINE_PATH/include -I$OPENSSL_PATH/include"
export PKG_CONFIG_PATH="$READLINE_PATH/lib/pkgconfig:$OPENSSL_PATH/lib/pkgconfig"

# Use the OpenSSL from Homebrew instead of ruby-build
# Note: the Homebrew version gets updated, the ruby-build version doesn't
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$OPENSSL_PATH"

# Place openssl@1.1 at the beginning of your PATH (preempt system libs)
export PATH=$OPENSSL_PATH/bin:$PATH
export PATH="$PATH:$HOME/depot_tools"
. "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/Users/shanewalker/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
