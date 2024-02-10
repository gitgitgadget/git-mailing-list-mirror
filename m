Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911625B69C
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707593596; cv=none; b=tFPDZnth4mWsLcs1u7QLqlgdY7LKMZTFGZ7REL3cbrR2Xv/l+xUpt9GcXARkm0/MUxTS6KxyosAu2cOskUkoBOLOUoOWgJrxhM5gPMh/9BakjMi794JzZ1x+I/znaUMFDKf0sWiEs/0666jgD0h0snMzGz/FxmE9LkB6TqPvHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707593596; c=relaxed/simple;
	bh=STex98/RX2iOxDmdRd1GhYUHT4xQ1mYZPc4UEOnu1i8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=lD69YdVyVNT7De0OKALii4kN8P5KvMo1eteKqFesdilXhbCe7mJ2KODORoo3LefWHz6c67f0PcDVKjo9tEhlUQdmnJwlw3p9TG1fw0rdQiPSyISLSE+MBZYi1LybSiWHtGI/11P80XFUwDCtjt15V4eUvyVgyQ+kA0onD31bxwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBtmH45O; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBtmH45O"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bc21303a35so761284b6e.0
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 11:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707593593; x=1708198393; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=2ggigQAOIPdCpuas9vNZfINzAJ+02uXNm/l/nxiDcOI=;
        b=CBtmH45Optm/MEAU/gyTShfAF23CTYqD9BzSWWl3UUK3AuaQk9ybidqkEuDvc1T94N
         JSmLawzDw1nFayWcfgpLzBWtktqEXKbs4GVLIhvEYLYT4zcQJ9hqJXU6084cwA5Ncg0B
         gtJuCYoMtG32rPxYUSFZhYI5JxhuSemHuYkEMP+hl5vD1nYCDWngbiyAZiNLR770lOym
         2j/Y7WeOni34X1EF/Q0PInIz/pPdFVnoeb5aQAtJSAuywdtJo4dOKls9cEu9V6mGivcJ
         W72Tsu85XMLd6RXq9QS2oIEt+vrhRXTOJWJdhiuKZNlbxaFC/cy1dzH3cG93dHfxjzIo
         Qr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707593593; x=1708198393;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ggigQAOIPdCpuas9vNZfINzAJ+02uXNm/l/nxiDcOI=;
        b=I4F2OczZFGfkphea13N5vPliFGbD1LoIShBOYNGn74f6An/CxnBNy/i4IAgzylKUUF
         jxbb51X9tvYKqw/a4bRbYcITNnt6mGDzxJEBJ7ejMYlrAOSen7D6liQKwd4JzqYh/u1X
         B2eo7JJstNFfxLchvgmX73Low6BBgrwHam7Mg6j3LGuBd0FnqZrxeVR2+DvlGcDKB/E+
         SqiQT/rQtkFUsTk1NsIQwJufGhH7yWXTnjiNIxu0x2XHUY1VPu6zTVXEH8wFER/gQy/T
         MxiogBiv7K7ZXJ1W71Ex4Do74/x0MYnFn5ewzFD/hv9bjUzZ6eFXgZwXjAEMl9Azr534
         j76g==
X-Forwarded-Encrypted: i=1; AJvYcCVt8wsUCg/GIFIMKKye3yiZy9Y+WxMPG1PAkDjFmlqt1hQHMql5M+dEeFVRNgkAoaIH1tM78HuceaFXY6bdl3sIRgy/
X-Gm-Message-State: AOJu0Yy9RWkabCmDjzlcxZINrIZ6inUPyhBTu6Qr37ZUy8oRsbkkd1DI
	mUAhBF30ko2KKWNwHrGqCh3x+/s/6mFNSqGMeIBBYpJECuL1Ua9lvjl4KypM
X-Google-Smtp-Source: AGHT+IEutMcXPWH/banmMArHQBju+ZIyIT5hb/fh8barfbdni/IOOzi3MbffHpW94M/zGHQVxCwYZg==
X-Received: by 2002:a05:6871:5c48:b0:21a:1183:d772 with SMTP id os8-20020a0568715c4800b0021a1183d772mr2771811oac.4.1707593593107;
        Sat, 10 Feb 2024 11:33:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuDySeBiDJgJu1/ryLzx6srC4Pg8ulDxHVh9y1hAanSDxedjI2a/frGBPNTxQCOxbRNIjkVA64wJqhmfKJv3xuxbG+
Received: from epic96565.epic.com (pat-verona-l.epic.com. [199.204.56.217])
        by smtp.gmail.com with ESMTPSA id qj12-20020a056214320c00b0068c6a8256b4sm2048973qvb.71.2024.02.10.11.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 11:33:12 -0800 (PST)
References: <CAK7MZG1MeeS5QNPog9oS+MbdKpkDXu61eVOszsC20Q=ik+Ng=g@mail.gmail.com>
 <m05xyw9r92.fsf@epic96565.epic.com>
 <CAK7MZG29+Cy-7SJnWayro_5GGEe3iZLysQqVaATLz8GLtEtA5A@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: Vijay Raghavan Aravamudhan <avijayr@gmail.com>
Cc: Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Subject: Re: git status became very slow after upgrading git
Date: Sat, 10 Feb 2024 13:06:29 -0600
In-reply-to: <CAK7MZG29+Cy-7SJnWayro_5GGEe3iZLysQqVaATLz8GLtEtA5A@mail.gmail.com>
Message-ID: <m0o7co8688.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Vijay Raghavan Aravamudhan <avijayr@gmail.com> writes:

> Thanks for responding. I have run the command that you gave on an open
> source repo so that its easy for you to replicate. The remote url is:
> https://github.com/vraravam/ferdium-app
>
> The output is:
>
>         [[ I took the liberty of cleaning this up; ]]
>         [[ let's hope formatting is preserved now. ]]
>
> ferdium-app.git:develop$ GIT_TRACE=1 GIT_TRACE_SETUP=1 GIT_TRACE_PERFORMANCE=1 git status
> 00:08:15.548976 trace.c:314             setup: git_dir: .git
> 00:08:15.550590 trace.c:315             setup: git_common_dir: .git
> 00:08:15.550600 trace.c:316             setup: worktree: /Users/vijay/dev/oss/ferdium
> 00:08:15.550604 trace.c:317             setup: cwd: /Users/vijay/dev/oss/ferdium
> 00:08:15.550611 trace.c:318             setup: prefix: (null)
> 00:08:15.550707 chdir-notify.c:70       setup: chdir from '/Users/vijay/dev/oss/ferdium' to '/Users/vijay/dev/oss/ferdium'
> 00:08:15.550723 git.c:463               trace: built-in: git status
> 00:08:15.552184 read-cache.c:2386       performance: 0.000183000 s: read cache .git/index
> 00:08:15.555964 read-cache.c:1629       performance: 0.003696000 s: refresh index
> 00:08:15.556442 diff-lib.c:273          performance: 0.000132000 s:  diff-files
> 00:08:15.558558 unpack-trees.c:2004     performance: 0.000019000 s: traverse_trees
> 00:08:15.558801 unpack-trees.c:438      performance: 0.000003000 s: check_updates
> 00:08:15.558813 unpack-trees.c:2096     performance: 0.000394000 s: unpack_trees
> 00:08:15.558819 diff-lib.c:638          performance: 0.000524000 s:  diff-index
> 00:08:15.559166 name-hash.c:613         performance: 0.000148000 s: initialize name hash
> On branch develop
> Your branch is up to date with 'origin/develop'.
>
> 00:08:15.567249 run-command.c:657       trace: run_command: GIT_INDEX_FILE=.git/index git submodule summary --cached --for-status --summary-limit -1 HEAD
> 00:08:15.833334 git.c:749               trace: exec: git-submodule summary --cached --for-status --summary-limit -1 HEAD
> 00:08:15.834114 run-command.c:657       trace: run_command: git-submodule summary --cached --for-status --summary-limit -1 HEAD
> 00:08:16.880778 trace.c:414             performance: 0.000013000 s: git command: git --exec-path
> 00:08:18.216639 git.c:463               trace: built-in: git rev-parse --git-dir
> 00:08:18.218740 trace.c:414             performance: 0.002132000 s: git command: git rev-parse --git-dir
> 00:08:18.489025 git.c:463               trace: built-in: git rev-parse --git-path objects
> 00:08:18.490677 trace.c:414             performance: 0.001675000 s: git command: git rev-parse --git-path objects
> 00:08:19.031080 git.c:463               trace: built-in: git rev-parse --show-prefix
> 00:08:19.032882 trace.c:414             performance: 0.001827000 s: git command: git rev-parse --show-prefix
> 00:08:19.296074 git.c:463               trace: built-in: git rev-parse --show-toplevel
> 00:08:19.297559 trace.c:414             performance: 0.001504000 s: git command: git rev-parse --show-toplevel
> 00:08:19.830285 trace.c:314             setup: git_dir: .git
> 00:08:19.830972 trace.c:315             setup: git_common_dir: .git
> 00:08:19.830981 trace.c:316             setup: worktree: /Users/vijay/dev/oss/ferdium
> 00:08:19.830984 trace.c:317             setup: cwd: /Users/vijay/dev/oss/ferdium
> 00:08:19.830990 trace.c:318             setup: prefix: (null)
> 00:08:19.830994 git.c:463               trace: built-in: git submodule--helper summary --cached --for-status -n -1 -- HEAD
> 00:08:19.834629 read-cache.c:2386       performance: 0.000164000 s: read cache .git/index
> 00:08:19.834914 unpack-trees.c:2004     performance: 0.000024000 s: traverse_trees
> 00:08:19.834932 unpack-trees.c:438      performance: 0.000003000 s: check_updates
> 00:08:19.834940 unpack-trees.c:2096     performance: 0.000157000 s: unpack_trees
> 00:08:19.834958 diff-lib.c:638          performance: 0.000307000 s:  diff-index
> 00:08:19.834975 trace.c:414             performance: 0.005922000 s: git command: git submodule--helper summary --cached --for-status -n -1 -- HEAD
> 00:08:19.836137 trace.c:414             performance: 4.003693000 s: git command: /opt/homebrew/opt/git/libexec/git-core/git submodule summary --cached --for-status --summary-limit -1 HEAD
> 00:08:19.836842 run-command.c:657       trace: run_command: GIT_INDEX_FILE=.git/index git submodule summary --files --for-status --summary-limit -1
> 00:08:20.106802 git.c:749               trace: exec: git-submodule summary --files --for-status --summary-limit -1
> 00:08:20.107638 run-command.c:657       trace: run_command: git-submodule summary --files --for-status --summary-limit -1
> 00:08:21.162243 trace.c:414             performance: 0.000006000 s: git command: git --exec-path
> 00:08:22.496146 git.c:463               trace: built-in: git rev-parse --git-dir
> 00:08:22.497722 trace.c:414             performance: 0.001589000 s: git command: git rev-parse --git-dir
> 00:08:22.764795 git.c:463               trace: built-in: git rev-parse --git-path objects
> 00:08:22.766763 trace.c:414             performance: 0.001991000 s: git command: git rev-parse --git-path objects
> 00:08:23.304626 git.c:463               trace: built-in: git rev-parse --show-prefix
> 00:08:23.306436 trace.c:414             performance: 0.001833000 s: git command: git rev-parse --show-prefix
> 00:08:23.575506 git.c:463               trace: built-in: git rev-parse --show-toplevel
> 00:08:23.577138 trace.c:414             performance: 0.001656000 s: git command: git rev-parse --show-toplevel
> 00:08:24.111335 trace.c:314             setup: git_dir: .git
> 00:08:24.112123 trace.c:315             setup: git_common_dir: .git
> 00:08:24.112138 trace.c:316             setup: worktree: /Users/vijay/dev/oss/ferdium
> 00:08:24.112142 trace.c:317             setup: cwd: /Users/vijay/dev/oss/ferdium
> 00:08:24.112149 trace.c:318             setup: prefix: (null)
> 00:08:24.112154 git.c:463               trace: built-in: git submodule--helper summary --files --for-status -n -1 --
> 00:08:24.113679 read-cache.c:2386       performance: 0.000216000 s: read cache .git/index
> 00:08:24.117811 diff-lib.c:273          performance: 0.004115000 s:  diff-files
> 00:08:24.117838 trace.c:414             performance: 0.007389000 s: git command: git submodule--helper summary --files --for-status -n -1 --
> 00:08:24.118895 trace.c:414             performance: 4.013083000 s: git command: /opt/homebrew/opt/git/libexec/git-core/git submodule summary --files --for-status --summary-limit -1
> nothing to commit, working tree clean
> 00:08:24.119646 trace.c:414             performance: 8.571954000 s: git command: git status
>
> Hope this helps. Also, I noticed that the same repo, same versions of
> all tools, etc - this issue only occurs on my M2 mac, but works
> without any slowness on the intel mac.

Thanks, that info does help. It at least narrows it down to these two
subprocesses:

    git submodule--helper summary --cached --for-status -n -1 -- HEAD
    git submodule--helper summary --files --for-status -n -1 --

Unfortunately, I'm still not able to reproduce on my M2 (even with that
config set globally), so I wonder if there's something else at play.
I've probably reached the end of my usefulness (since the problem does
appear to be specific to submodules and cmd_submodule__helper seems to
be lacking documentation), but you might consider replying with your
output of

    git config --list --show-scope

after stripping any private information, of course.

I'll provide my info down below in the hopes that it's useful for
comparison by someone who knows more about this subsystem. It's worth
noting that I'm running the same submodule--helper command and it's
completing in a reasonable timeframe for me.

Configuration:

    ferdium-app.git:develop$ git --no-pager config --list --show-scope
    system	credential.helper=osxkeychain
    system	filter.lfs.clean=git-lfs clean -- %f
    system	filter.lfs.smudge=git-lfs smudge -- %f
    system	filter.lfs.process=git-lfs filter-process
    system	filter.lfs.required=true
    global	user.signingkey=/Users/sallred/.ssh/id_ed25519.pub
    global	pull.rebase=true
    global	push.default=current
    global	core.editor=mg
    global	core.excludesfile=/Users/sallred/.gitignore
    global	core.fsmonitor=true
    global	core.whitespace=trailing-space
    global	init.defaultbranch=main
    global	remote.pushdefault=origin
    global	branch.autosetupmerge=true
    global	rerere.enabled=true
    global	gpg.format=ssh
    global	maintenance.repo=/Users/sallred/a
    global	maintenance.repo=/Users/sallred/b
    global	maintenance.repo=/Users/sallred/c
    global	maintenance.repo=/Users/sallred/d
    global	commit.gpgsign=true
    global	diff.wserrorhighlight=old,new
    global	gpg.ssh.allowedsignersfile=/Users/sallred/.ssh/allowed_signers
    global	remote.origin.fetch=+refs/notes/*:refs/notes/*
    global	status.submodulesummary=true
    local	core.repositoryformatversion=0
    local	core.filemode=true
    local	core.bare=false
    local	core.logallrefupdates=true
    local	core.ignorecase=true
    local	core.precomposeunicode=true
    local	remote.origin.url=git@github.com:vraravam/ferdium-app
    local	remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
    local	branch.develop.remote=origin
    local	branch.develop.merge=refs/heads/develop

Performance data:

    ferdium-app.git:develop$ GIT_TRACE=1 GIT_TRACE_SETUP=1 GIT_TRACE_PERFORMANCE=1 git status
    13:29:32.879597 trace.c:314             setup: git_dir: .git
    13:29:32.880020 trace.c:315             setup: git_common_dir: .git
    13:29:32.880026 trace.c:316             setup: worktree: /Users/sallred/tmp/ferdium-app
    13:29:32.880029 trace.c:317             setup: cwd: /Users/sallred/tmp/ferdium-app
    13:29:32.880033 trace.c:318             setup: prefix: (null)
    13:29:32.880071 chdir-notify.c:70       setup: chdir from '/Users/sallred/tmp/ferdium-app' to '/Users/sallred/tmp/ferdium-app'
    13:29:32.880078 git.c:463               trace: built-in: git status
    13:29:32.880606 read-cache.c:2386       performance: 0.000118000 s:  read cache .git/index
    13:29:32.904888 read-cache.c:1629       performance: 0.000082000 s:  refresh index
    13:29:32.905983 diff-lib.c:273          performance: 0.000287000 s:  diff-files
    13:29:32.907393 unpack-trees.c:2004     performance: 0.000014000 s:    traverse_trees
    13:29:32.907403 unpack-trees.c:438      performance: 0.000002000 s:    check_updates
    13:29:32.907407 unpack-trees.c:2096     performance: 0.000109000 s:   unpack_trees
    13:29:32.907410 diff-lib.c:638          performance: 0.000163000 s:  diff-index
    13:29:32.907681 name-hash.c:613         performance: 0.000107000 s:  initialize name hash
    13:29:32.922245 run-command.c:657       trace: run_command: GIT_INDEX_FILE=.git/index git submodule summary --cached --for-status --summary-limit -1 HEAD
    On branch develop
    Your branch is up to date with 'origin/develop'.

    13:29:32.928117 git.c:749               trace: exec: git-submodule summary --cached --for-status --summary-limit -1 HEAD
    13:29:32.928715 run-command.c:657       trace: run_command: git-submodule summary --cached --for-status --summary-limit -1 HEAD
    13:29:32.941067 trace.c:414             performance: 0.000002000 s: git command: git --exec-path
    13:29:32.961582 git.c:463               trace: built-in: git rev-parse --git-dir
    13:29:32.962376 trace.c:414             performance: 0.000802000 s: git command: git rev-parse --git-dir
    13:29:32.966772 git.c:463               trace: built-in: git rev-parse --git-path objects
    13:29:32.967437 trace.c:414             performance: 0.000673000 s: git command: git rev-parse --git-path objects
    13:29:32.976243 git.c:463               trace: built-in: git rev-parse --show-prefix
    13:29:32.976902 trace.c:414             performance: 0.000667000 s: git command: git rev-parse --show-prefix
    13:29:32.981157 git.c:463               trace: built-in: git rev-parse --show-toplevel
    13:29:32.981835 trace.c:414             performance: 0.000690000 s: git command: git rev-parse --show-toplevel
    13:29:32.989790 trace.c:314             setup: git_dir: .git
    13:29:32.990234 trace.c:315             setup: git_common_dir: .git
    13:29:32.990238 trace.c:316             setup: worktree: /Users/sallred/tmp/ferdium-app
    13:29:32.990242 trace.c:317             setup: cwd: /Users/sallred/tmp/ferdium-app
    13:29:32.990245 trace.c:318             setup: prefix: (null)
    13:29:32.990246 git.c:463               trace: built-in: git submodule--helper summary --cached --for-status -n -1 -- HEAD
    13:29:32.991301 read-cache.c:2386       performance: 0.000062000 s:  read cache .git/index
    13:29:33.002570 unpack-trees.c:2004     performance: 0.000009000 s:    traverse_trees
    13:29:33.002577 unpack-trees.c:438      performance: 0.000001000 s:    check_updates
    13:29:33.002580 unpack-trees.c:2096     performance: 0.000074000 s:   unpack_trees
    13:29:33.002585 diff-lib.c:638          performance: 0.000117000 s:  diff-index
    13:29:33.002591 trace.c:414             performance: 0.013037000 s: git command: git submodule--helper summary --cached --for-status -n -1 -- HEAD
    13:29:33.003099 trace.c:414             performance: 0.075293000 s: git command: /opt/homebrew/opt/git/libexec/git-core/git submodule summary --cached --for-status --summary-limit -1 HEAD
    13:29:33.003446 run-command.c:657       trace: run_command: GIT_INDEX_FILE=.git/index git submodule summary --files --for-status --summary-limit -1
    13:29:33.007530 git.c:749               trace: exec: git-submodule summary --files --for-status --summary-limit -1
    13:29:33.007926 run-command.c:657       trace: run_command: git-submodule summary --files --for-status --summary-limit -1
    13:29:33.017316 trace.c:414             performance: 0.000002000 s: git command: git --exec-path
    13:29:33.036544 git.c:463               trace: built-in: git rev-parse --git-dir
    13:29:33.037494 trace.c:414             performance: 0.000959000 s: git command: git rev-parse --git-dir
    13:29:33.041936 git.c:463               trace: built-in: git rev-parse --git-path objects
    13:29:33.042731 trace.c:414             performance: 0.000803000 s: git command: git rev-parse --git-path objects
    13:29:33.051651 git.c:463               trace: built-in: git rev-parse --show-prefix
    13:29:33.052320 trace.c:414             performance: 0.000678000 s: git command: git rev-parse --show-prefix
    13:29:33.056260 git.c:463               trace: built-in: git rev-parse --show-toplevel
    13:29:33.057043 trace.c:414             performance: 0.000793000 s: git command: git rev-parse --show-toplevel
    13:29:33.064488 trace.c:314             setup: git_dir: .git
    13:29:33.064860 trace.c:315             setup: git_common_dir: .git
    13:29:33.064862 trace.c:316             setup: worktree: /Users/sallred/tmp/ferdium-app
    13:29:33.064863 trace.c:317             setup: cwd: /Users/sallred/tmp/ferdium-app
    13:29:33.064866 trace.c:318             setup: prefix: (null)
    13:29:33.064867 git.c:463               trace: built-in: git submodule--helper summary --files --for-status -n -1 --
    13:29:33.065421 read-cache.c:2386       performance: 0.000085000 s:  read cache .git/index
    13:29:33.079310 diff-lib.c:273          performance: 0.000026000 s:  diff-files
    13:29:33.079330 trace.c:414             performance: 0.015094000 s: git command: git submodule--helper summary --files --for-status -n -1 --
    13:29:33.079947 trace.c:414             performance: 0.072649000 s: git command: /opt/homebrew/opt/git/libexec/git-core/git submodule summary --files --for-status --summary-limit -1
    13:29:33.080290 trace.c:414             performance: 0.201218000 s: git command: git status
    nothing to commit, working tree clean

--
Sean Allred
