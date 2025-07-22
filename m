Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BA28135D
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206318; cv=none; b=QnhNOY9CsmzYVmYEiRESJ/Z3N33pUKfVFtEQbol6F5eoX/Wyw9Nb8+j2VqgyAhdTViOyJ/6UPBSirciMgj/Q+lNOqWVvR6U4vN/bVXcXbpkUx8ciYSCwyeMKp7ESpcKO4Yo8NTYjBMlKNTkVmJYJAgBW5DsgHdFx+6AgTqHkXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206318; c=relaxed/simple;
	bh=3L0KZxCdqPy/1CVdnCjVPttrxat/HBzjjuWbGyTgArA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pdyxG9m9glr4Rbk7UhVVaRIbi21+tJwF1sDlLWJekjIG3OvG+CZ55ySv96t0c70EcKH7u9kIzgTqG70li+HcaRvX5jwyU+v2XisL2I928WyHN6Tg3kgyq9mhiYwH2NqI7e/YkXWUDNFrYylcS0WJTWoCfYDyC+OKjlp7bHVHG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220187.atnat0029.highway.webapn.at [89.144.220.187])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4bml5v2RyCzRpKh;
	Tue, 22 Jul 2025 19:45:07 +0200 (CEST)
Message-ID: <abac5aa8-210e-4b86-b0de-2fcd082c93df@kdbg.org>
Date: Tue, 22 Jul 2025 19:45:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] git-gui: Sync with 2.50.1, Tcl >= 8.6, git >= 2.36
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqsekgn4gk.fsf@gitster.g>
 <007a01dbd4d7$89ebf100$9dc3d300$@nexbridge.com>
 <007d01dbd4d9$356ded70$a049c850$@nexbridge.com>
 <aEBPdFXpIca7lMls@teonanacatl.net> <xmqqjz5rcz90.fsf@gitster.g>
 <44fe8627-5680-443d-bf02-a6e85afd46b4@kdbg.org>
 <010b01dbd5f1$3c26ec20$b474c460$@nexbridge.com> <aEFb0Sjj0Xuu-t7l@pks.im>
 <014201dbd658$4da75680$e8f60380$@nexbridge.com>
 <f2ed8920-347d-45d3-a0bb-df94ece0d9df@kdbg.org> <xmqqikl97u1l.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqikl97u1l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Many of the commits listed below are already in git.git via v2.50.1.
Additionally, with this version, we require more modern Tcl/Tk and Git.
Other changes are:
- Bulgarian translation.
- Fix for a redundant trailing empty line in commit messages.
- SHA256 repositories are supported

The following changes since commit 765f1db2b5a890c0fa01f8976f197a8483357afe:

  git-gui: don't delete source files when auto_mkindex fails (2025-06-06 07:43:37 +0200)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to 436dad00c5a717d56bf4feb8a1f5d39126579fe6:

  Merge branch 'ml/abandon-old-versions' (2025-07-22 17:37:33 +0200)

----------------------------------------------------------------
Alexander Shopov (1):
      git-gui i18n: Updated Bulgarian translation (578t)

Johannes Sixt (21):
      git-gui: do not end the commit message with an empty line
      Merge branch 'ml/git-gui-exec-path-fix'
      git-gui: remove special treatment of Windows from open_cmd_pipe
      git-gui: remove git config --list handling for git < 1.5.3
      git-gui: treat file names beginning with "|" as relative paths
      git-gui: sanitize 'exec' arguments: simple cases
      git-gui: sanitize 'exec' arguments: background
      git-gui: remove option --stderr from git_read
      git-gui: break out a separate function git_read_nice
      git-gui: use git_read in githook_read
      git-gui: convert git_read*, git_write to be non-variadic
      git-gui: pass redirections as separate argument to _open_stdout_stderr
      git-gui: pass redirections as separate argument to git_read
      git-gui: introduce function git_redir for git calls with redirections
      git-gui: do not mistake command arguments as redirection operators
      git-gui: sanitize 'exec' arguments: convert new 'cygpath' calls
      Merge branch 'ob/strip-comments-on-commit'
      Merge branch 'ml/replace-auto-execok'
      Merge branch 'js/fix-open-exec-git'
      Merge branch 'ml/tcl86'
      Merge branch 'ml/abandon-old-versions'

Mark Levedahl (35):
      git-gui: _which, only add .exe suffix if not present
      git-gui: use [is_Windows], not bad _shellpath
      git-gui: make _shellpath usable on startup
      git-gui: remove Tcl 8.4 workaround on 2>@1 redirection
      git-gui: use only the configured shell
      git-gui: remove HEAD detachment implementation for git < 1.5.3
      git-gui: remove unused proc is_shellscript
      git-gui: avoid auto_execok for git-bash menu item
      git-gui: avoid auto_execok in do_windows_shortcut
      git-gui: cleanup git-bash menu item
      git-gui: assure PATH has only absolute elements.
      git-gui: sanitize $PATH on all platforms
      git-gui: override exec and open only on Windows
      git-gui: require git >= 2.36
      git-gui: Make TclTk 8.6 the minimum, allow 8.7
      git-gui: git ls-files knows --exclude-standard
      git-gui: git-diff-index always knows submodules
      git-gui: use git-branch --show-current
      git-gui: git rev-parse knows show_toplevel
      git-gui: git-blame understands -w and textconv
      git-gui: git-diff knows submodules and textconv
      git-gui: git merge understands --strategy=recursive
      git-gui: git-remote is always available
      git-gui: use git_init to create new repository dir
      git-gui: remove unused git-version
      git-gui: remove unreachable Tk 8.4 code
      git-gui: remove redundant check for Tk >= 8.5
      git-gui: always use themed widgets from ttk
      git-gui: remove ${NS} indirection for ttk
      git-gui: remove non-ttk code
      git-gui: use git-clone
      git-gui: default to full copy for linked worktrees
      git-gui: use dashless 'git cmd' form for read/write
      git-gui: remove procs gitexec and _git_cmd
      git-gui: eliminate _search_exe

Takashi Iwai (2):
      git-gui: Replace null_sha1 with nullid
      git-gui: Add support of SHA256 repo

Taylor Blau (1):
      Merge branch 'ml/replace-auto-execok' into js/fix-open-exec

 git-gui.sh                   |  877 ++++------
 lib/about.tcl                |   10 +-
 lib/blame.tcl                |   49 +-
 lib/branch.tcl               |    6 +-
 lib/branch_checkout.tcl      |   15 +-
 lib/branch_create.tcl        |   36 +-
 lib/branch_delete.tcl        |   12 +-
 lib/branch_rename.tcl        |   26 +-
 lib/browser.tcl              |   25 +-
 lib/checkout_op.tcl          |   29 +-
 lib/choose_font.tcl          |   25 +-
 lib/choose_repository.tcl    |  565 +------
 lib/choose_rev.tcl           |   52 +-
 lib/class.tcl                |    1 -
 lib/commit.tcl               |   23 +-
 lib/console.tcl              |   20 +-
 lib/database.tcl             |   15 +-
 lib/diff.tcl                 |   39 +-
 lib/error.tcl                |   11 +-
 lib/index.tcl                |   16 +-
 lib/line.tcl                 |    7 +-
 lib/merge.tcl                |   27 +-
 lib/mergetool.tcl            |    8 +-
 lib/option.tcl               |   72 +-
 lib/remote.tcl               |   10 +-
 lib/remote_add.tcl           |   28 +-
 lib/remote_branch_delete.tcl |   46 +-
 lib/search.tcl               |   13 +-
 lib/shortcut.tcl             |   14 +-
 lib/sshkey.tcl               |   28 +-
 lib/status_bar.tcl           |   13 +-
 lib/themed.tcl               |  110 +-
 lib/tools.tcl                |    7 +-
 lib/tools_dlg.tcl            |   66 +-
 lib/transport.tcl            |   40 +-
 lib/win32.tcl                |    9 +-
 po/bg.po                     | 3608 +++++++++++++++++++++---------------------
 37 files changed, 2592 insertions(+), 3366 deletions(-)
