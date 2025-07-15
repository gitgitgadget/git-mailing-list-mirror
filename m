Received: from a9-23.smtp-out.amazonses.com (a9-23.smtp-out.amazonses.com [54.240.9.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133446FBF
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550010; cv=none; b=k3IH2dsd0ZtMrKZp5XDoLDEvxWRAi+z+1kT5zC0/CPIox4RLkAJ5i3RBXMhRDuxB2o/Y/YqOtizbPPFAc6dTsnsdiRRcxV3GemfMCGxhf+sCavuwJw20Uyi1QC1UUhrWxcCBIAiI0ZwuS1FcQccCuawkJrtZ3S9iKVuW8/Nn8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550010; c=relaxed/simple;
	bh=qoRvTszXFxF5olXabYPZC0/U6B0yC39FfUNHVh/Ayos=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=LdfxRdwC9zwgwudOP/F3nbMVnvaxpicc/nV+HwEpNnNfFMTIJzOQm0jbi5O59RZwZgBEX8B9VqnB0ewMkD3gI0PVgKDQr2a9GkvZxkMIIVLCuhioARUxrvysyFCKn0WWScq88YtN5lfdGHEofmeDvtNmZF6Te3NnZw35bAqc4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=looping.me; spf=pass smtp.mailfrom=send.looping.me; dkim=pass (1024-bit key) header.d=looping.me header.i=@looping.me header.b=0PIJRiuX; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=V77WC44y; arc=none smtp.client-ip=54.240.9.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=looping.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.looping.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=looping.me header.i=@looping.me header.b="0PIJRiuX";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="V77WC44y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=looping.me; t=1752550006;
	h=From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=qoRvTszXFxF5olXabYPZC0/U6B0yC39FfUNHVh/Ayos=;
	b=0PIJRiuXAOutGdEuoniWJyUB95C40F/6KX7pykXSJtvmeqypvYHEBeKu0PENzqeo
	t9maHiqYnGKSvRQc9McocP4vkdSUV9qgmebIFFibbWo+U/OjZK9ph953zPEnrcbROO5
	1DlqkRbuBKC5mb6YdTrgsAQJ/5RhT+oVT2DXmVZ8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1752550006;
	h=From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=qoRvTszXFxF5olXabYPZC0/U6B0yC39FfUNHVh/Ayos=;
	b=V77WC44y20GY4DS2HzsLnjERQufKuiJGHzU3i9ZOOqhu+vE53iebF4fmRyV6b0WH
	En1PtmQ0TWHPhwuEDwOxNWnpIboxg9U5A3lJ53M+iJMMtG+xWfFq7g4G1pZp/+ceal7
	2f9PNfJi4USQZzo0O2rU9HlX61FV42I79Hek282E=
X-Gm-Message-State:
 AOJu0Yym3l0BNWJfMKuV5R50IbmIbBXg2Eh9/mqBCeNrgUO63m0a0JNt
 Zb+qoBTaOequugHFYeViEsbdH5MyoLteDJvJzcu/WCOrzihsmUrw1VJ9v6C6/ZK5S/919zitLj6
 CNL/y61Si1UkWpBE0XUp+bFnWtjXlTCo=
X-Google-Smtp-Source:
 AGHT+IFkfgtB9RlpRrYcKa7pxn2i2QOdSDQKA8fA5VhpbJT0K7cE7044dJR8XC9sh29/2T/eAxWpo+QpCQGAYHXsRYY=
X-Received: by 2002:a05:651c:2120:b0:32b:7389:57c with SMTP id
 38308e7fff4ca-3308748a72fmr54681fa.12.1752550005142; Mon, 14 Jul 2025
 20:26:45 -0700 (PDT)
X-Gmail-Original-Message-ID:
 <CAL_3E041vyA_K36ptx1z2vxo-MQJ4Qx4vpiZ3U_GWaDi7f6XtQ@mail.gmail.com>
X-Gm-Features:
 Ac12FXy7zGekD6_VBE6AjlaWar5uP9m1ZtypRfK5ANXrakPrXDW-znaCK5fjbNI
From: Bryan Lee <hi@looping.me>
To: git@vger.kernel.org
Subject: [BUG] git pull ignores pull.autostash=true configuration when used
 with --git-dir and --work-tree flags on a bare repository
Message-ID: <010001980c1ee007-2797fc86-fdf3-46e9-bec9-f8da2c9ebb8d-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jul 2025 03:26:46 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: ::1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2025.07.15-54.240.9.23

What did you do before the bug happened? (Steps to reproduce your issue)

I am using a bare Git repository to manage my dotfiles, following a
common pattern where the Git directory is separate from the work tree.
Here are the exact steps to reproduce the issue:

1. Create a bare =
repository and set up the alias:
   $ git init --bare $HOME/.dotfiles
   Initialized empty Git repository in /Users/bryan/.dotfiles/

   $ alias dot=3D'git --git-dir=3D$HOME/.dotfiles/ --work-tree=3D$HOME'

2. Add a remote and create initial tracked file:
   $ dot remote add origin=
 git@github.com:username/dotfiles.git

   $ echo "# My dotfiles" > =
$HOME/README.md
   $ dot add $HOME/README.md
   $ dot commit -m "Initial =
commit"
   [main (root-commit) abc1234] Initial commit
    1 file changed, 1 insertion(+)
    create mode 100644 README.md

   $ dot push -u origin main
   Branch 'main' set up to track remote branch=
 'main' from 'origin'.

3. Set global Git configuration for automatic =
rebasing and stashing:
   $ git config --global pull.rebase true
   $ git config --global pull.autostash true

   Verify the configuration =
is set:
   $ git config --global pull.rebase
   true
   $ git config --global pull.autostash
   true

4. Simulate a remote =
change (on another machine or via GitHub web interface):
   - Edit README.md on remote to add a line: "Updated from remote"
   - This creates a divergence between local and remote

5. Make local unstaged changes:
   $ echo "Local change" >> $HOME/.zshrc

   Verify there are unstaged changes:
   $ dot status
   On branch main
   Changes not staged for commit:
     (use "git add <file>..." to update =
what will be committed)
     (use "git restore <file>..." to discard =
changes in working directory)
    modified:   .zshrc

   no changes added to commit (use "git add" and/or "git commit -a")

6. Attempt to pull the remote changes:
   $ dot pull
   error: cannot pull with rebase: You have unstaged changes.
   error: Please commit or stash them.

What did you expect to happen? =
(Expected behavior)

Since I have configured pull.autostash=3Dtrue globally=
, I expected Git to:

1. Automatically create a stash of my unstaged =
changes (the modified
.zshrc file)
2. Pull the remote changes with rebase =
(as configured by pull.rebase=3Dtrue)
3. Apply the stash after the pull =
completes successfully
4. Show output similar to:
   Created autostash: =
abc2345
   First, rewinding head to replay your work on top of it...
   Fast-forwarded main to origin/main.
   Applied autostash.

This is the behavior I get when using Git in a regular (non-bare)
repository with the same configuration.

What happened instead? (Actual =
behavior)

Git immediately fails with an error message:
error: cannot pull with rebase: You have unstaged changes.
error: Please commit or stash them.

The command exits with status code 1 =
and does not perform any stashing
or pulling.

What's different between =
what you expected and what actually happened?

The difference is that Git =
is not honoring the pull.autostash=3Dtrue
configuration when the repository=
 is accessed using --git-dir and
--work-tree flags. The autostash feature =
is completely ignored, and
Git behaves as if pull.autostash=3Dfalse.

To confirm this is specific to the --git-dir/--work-tree usage
pattern, I tested the following workarounds:

1. Explicit --autostash flag =
works:
   $ dot pull --rebase --autostash
   Created autostash: def3456
   Current branch main is up to date.
   Applied autostash.

2. The same configuration works in a regular repository:
   $ cd /tmp/test-repo
   $ git init
   $ git config pull.rebase true
   $ git config pull.autostash true
   $ echo "test" > file.txt
   $ git add file.txt
   $ git commit -m "test"
   $ echo "change" >> file.=
txt
   $ git pull origin main  # This would autostash as expected

Additional diagnostic information:

1. The configuration is properly loaded=
 by Git:
   $ dot config --show-origin pull.autostash
   file:/Users/bryan/.config/git/config true

   $ dot config --show-origin=
 pull.rebase
   file:/Users/bryan/.config/git/config true

2. Even setting the configuration directly in the bare repository doesn't =
help:
   $ dot config pull.autostash true
   $ dot config pull.rebase true
   $ cat $HOME/.dotfiles/config | grep -A2 "\[pull\]"
   [pull]
    rebase =3D true
    autostash =3D true

   $ dot pull
   error: cannot pull with rebase: You have unstaged changes.
   error: Please commit or stash them.

3. Using -c flag to override =
configuration inline also fails:
   $ git --git-dir=3D$HOME/.dotfiles/ =
--work-tree=3D$HOME -c
pull.autostash=3Dtrue pull
   error: cannot pull =
with rebase: You have unstaged changes.
   error: Please commit or stash =
them.

4. GIT_TRACE output shows the pull command is executed but autostash
is not attempted:
   $ GIT_TRACE=3D1 dot pull 2>&1 | head -5
   11:09:57.474770 git.c:476               trace: built-in: git pull
   error: cannot pull with rebase: You have unstaged changes.
   error: Please commit or stash them.

This appears to be a bug where the =
autostash functionality is bypassed
when Git is invoked with --git-dir and =
--work-tree flags, possibly
because the work tree context is not properly =
established when the
autostash check occurs.

[System Info]
git version:
git version 2.50.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
uname: Darwin 24.5.0 Darwin Kernel Version 24.5.0: Tue =
Apr 22 19:54:29
PDT 2025; root:xnu-11417.121.6~2/RELEASE_ARM64_T6030 arm64
compiler info: clang: 17.0.0 (clang-1700.0.13.3)
libc info: no libc =
information available
$SHELL (typically, interactive shell): /bin/zsh
