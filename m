Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B883E5EF8
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898774; cv=none; b=PeEvz/YtL7QnA6UjsVHh8cFnSWFaoTJ2k4hmIrSftgTI246Ybtl/F4WM+DKUGyrPgRg0NU7f3Qf+iv46ppUz/w9xr10GNRrdv3U54a/HwiwtZpyBeui9X3R6seR06l7i3YE7yu/yfvJ+M4e4zlO5jZd4puUn03I2Rn0bLf8qUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898774; c=relaxed/simple;
	bh=EkIWdWettAvUmK2VkkIHcpplw7aVbfDm/53sQcq6q+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G/WCCXgtoA/2eXLPj3728lqYy8PRcFTi83WrFiOjLhBsksDTm5CjksgHORfyJlxngiUGJnfRSF3vgpctFlJ/sn651uRvOKlgQFsDhJsg0jCDO4uWxN1lyNvK1YU2n6aJPF9qw9Sqbp+M3M5mh/kMikmM8J+mIjyGphLKB+ePiSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWVIHnVb; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWVIHnVb"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a9a2cfe1d4so19489711fa.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 06:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791898771; x=1792503571; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72tUuuixKVoBlUzsN+yo/CAopuB/4oOYxR4D55xNhwM=;
        b=gWVIHnVbZKhElrVqJ+uch3AYU12J7I3bSwrpKUvOg2cVE+TQt2jQVpnfHXIaPXdV1n
         o4RCsVJc1UHcuvBHqPw0rDBIGKa6dZqkWf/+7QMFHr6wKZcWiHpJgBoIep3xxh1X4OKJ
         y694aiXNVt5lq777yA+UTy0q78pZizcS7aQgUa1rxXEQaCacNYCBhi5MVS4L0eQFM3k9
         ywZ1eez5GsRG/5FoBTxo6qyzk9x8+BqC22McoBNHTs8R5bUZgwbfLZimZEoNvl4JK+le
         /1ukfcQ7s5zp914ieqR3HARTwiFAx/ueXwdWu3myxVNSLl/Rz2bwZBGdSlkHKsbqIZUI
         SJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791898771; x=1792503571;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=72tUuuixKVoBlUzsN+yo/CAopuB/4oOYxR4D55xNhwM=;
        b=wyfN3TT+VPoiZUwtCFk9G6ASIIGG5Gk15F3zB5U8fqVWzkecgOdmdmBKb/2mmuuCGi
         SXwX3EB1rYMLQRlQrqh4THT9/I61YkKyRVipYToLxgfTJFyq1Ga6dG8An2Mb6SqXppXa
         Mj7/rYFUU9cVqv61TTxMed1sBjxCu8dTn0L/TlYaGsGbMPJK6nUR3wFEyuh3BnYcKlpY
         G+MtF6LVxV6O3/sj8YO2DduHhfEkKNXzI6ZgI/XPpUnB9R/LW3NLp72AE62mSLKNJ0S5
         7elnqzBVfnbbk/vydw2ligOPwad4W+xcp12q6PZk8a9mSpSMonRdZxIbtjHr7ZkhE5Po
         Zd+w==
X-Gm-Message-State: AFq9FYLvx5MaLdlz8x3ivJ/0XEE1BKDgU+KcVrBkbzQF3i8gTuSsRsPN
	ZcMjpL7RUFe/G84YkWn0TNsfMtJgkQ5pJB+PoGtY6aV8yU+wJdy6rwDhb3GhB8r2
X-Gm-Gg: AYBFou1po6fvj4Or0x1HwZBtHw4L9icOQoUb39CJfiCrpF2BdYZ5G8/xvUBXY95X2GP
	AwDBllr7yRj65Htbbp5Ozw4XbX7NtyLygvq3Kw0RWvr9SJrB4v41OhleZqX92ZWv+JvIY5+J5iV
	Rc6v7iq6TOLx7Fo9Ztyp8NNrOe6V2S7flOhr/f8WGuWifR3QeyJguHUQFR9Ya/xXEmFv3y4NUeO
	Rph6M36QIw8Y3pV1jQxBDMQ+NsLnr08kitWuUg0zpxAZ1MswPsCUpe2DIj20IN2NEjKErbHrjDz
	qZq7jr76nKsL59OMFMTzRYVtRH3Y/Y1k4ur9LT48VK5lX2O8sTgqGi2BQIkfsobcu0cVH0xWbcb
	pqDbwtt/KJnRusyDoXouN9n7BCqhIP3laCrd2SpKBs1IQXDjB1Oe6ru1seEylUcy90/0yrM4eb2
	R0jBjNloa/fcbuIC0wbQrMpD+4uOSDTI1zGUR7EbxGbIBvbWyOxy5jGDeo6tF6CA0OSyYF1tdVD
	wyx/jTQSPR44FNdexgjtRo4igEy2ZYVN3SYevGe6Hc8sMPG7F5Pml1okVQ15/YCyAjo4SpnlvNG
	LIDHDweixzS5Sg4qaL5wUJdav4A=
X-Received: by 2002:a2e:a7c1:0:b0:3a7:812b:cec with SMTP id 38308e7fff4ca-3a9c48533fcmr28457021fa.0.1791898770916;
        Tue, 13 Oct 2026 06:39:30 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:bd32:e7e3:cfbd:5b51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9c3cd7d6fsm35742201fa.33.2026.10.13.06.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:39:30 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
Date: Tue, 13 Oct 2026 15:39:28 +0200
From: Erik Cervin-Edin <erik@cervined.in>
To: git@vger.kernel.org
Cc: Paul Tarjan <github@paulisageek.com>, Patrick Steinhardt <ps@pks.im>
Subject: fsmonitor (Linux): edits in subdirectories of a renamed directory
 are missed
Message-ID: <as4z1SskiPyrSKIa@vader>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

What did you do before the bug happened? (Steps to reproduce your issue)

With the built-in fsmonitor daemon on Linux, I renamed a directory that
has a subdirectory, then edited a file in each:

    git init repro && cd repro
    git config core.fsmonitor true
    mkdir -p old/pkg/sub new
    echo a >old/pkg/top.txt
    echo a >old/pkg/sub/f.txt
    git add . && git commit -qm init
    git status --short          # starts the daemon
    git mv old/pkg new/pkg
    git commit -qm move
    echo b >>new/pkg/top.txt
    echo b >>new/pkg/sub/f.txt
    GIT_TRACE_FSMONITOR=1 git status --short

What did you expect to happen? (Expected behavior)

Both edited files listed as modified:

     M new/pkg/sub/f.txt
     M new/pkg/top.txt

What happened instead? (Actual behavior)

Only the file directly in the renamed directory is listed. The daemon
reports the edit in the subdirectory under its path from before the
rename:

    fsmonitor_refresh_callback 'new/pkg/top.txt' (pos 1)
    fsmonitor_refresh_callback INV: 'new/pkg/top.txt'
    fsmonitor_refresh_callback CNT: 1
    fsmonitor_refresh_callback 'old/pkg/sub/f.txt' (pos -3)
     M new/pkg/top.txt

`git -c core.fsmonitor=false status --short` lists both files.

What's different between what you expected and what actually happened?

Changes anywhere below a subdirectory of a renamed directory are
missing from status and diff, with no warning. It is not a
race: later edits in that subdirectory, made well after the rename, are
missed too. It persists until something invalidates the fsmonitor
state. I hit it moving a source package: 19 of 56 edited files were
missing from `git status`, all in subdirectories of the moved
directory, and a commit made from that status would have left them
out.

Anything else you want to add:

I believe the cause is in add_watch() in
compat/fsmonitor/fsm-listen-linux.c. An inotify watch follows the
directory's inode, so the subdirectories of a renamed directory are
still watched. When the rename is processed, they are registered again
under their new paths with IN_MASK_CREATE, inotify_add_watch() fails
with EEXIST, and add_watch() returns early without updating the
descriptor-to-path map. Only the renamed directory's own entry gets its
new path.

Patrick Steinhardt asked about exactly this in review of v5 of the
Linux listener:

  https://lore.kernel.org/git/aZ1bRQv9Cjke298f@pks.im/

  > In case the watch already exists, can't it be the case that we
  > have raced e.g. during a rename? [...] If we then see EEXIST we
  > wouldn't update the hash map and thus keep the old path intact.

As far as I can see that question was not answered on the list, and
v15 of the series still returns early on EEXIST. It turns out to be
deterministic rather than a race.


[System Info]
git version:
git version 2.56.0.rc2.275.gfcaf1f5383
cpu: x86_64
built from commit: fcaf1f5383f52c5ebd5e2df3ea023601e2084b10
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.18.0
OpenSSL: OpenSSL 3.5.8 25 Aug 2026
zlib-ng: 2.3.3
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-storage-format: files
default-hash: sha1
uname: Linux 7.2.9-200.fc44.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Oct  3 19:59:55 UTC 2026 x86_64
compiler info: gnuc: 16.2
libc info: glibc: 2.43
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
