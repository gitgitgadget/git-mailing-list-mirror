Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A8394479
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147633; cv=pass; b=D+LqyQ+L/Rmsuqz+6bXZsyKNPVFihSUAOH57QrvLfiZQFyg9ePQfUKlY3DbTNLD/cF0kCIl+jb4SuTOXnpRBS37T6zLjXDap4Rz7hhg+kUbxyIbGHkPgNE4ZWYDi+9IH+xN5I91+FAlDPcKQDeABlx8g2LxKAkDAYdAx0AjeJxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147633; c=relaxed/simple;
	bh=hTmm7QIPUcY9bMHKXGmZzjzPn3+LXg+T7M9OhV9opXg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PNqtW4xwNCs7A5bmsOySGuzl5byyaYrB6dcrjXYM7NBLWWrrM9aPIffBZUjnDofVN5GC+o/U4SKUkSkhkcHegLFyCQaY3jr48//ak4ibp1dpA4xAfMYcjiaZDHWCCQsCbAhenFrioJhSpxnJWMsPYua9vclIKM3nvgiQqEn2S14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWC7fU3M; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWC7fU3M"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad617d5b80so8913145ad.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 15:13:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772147632; cv=none;
        d=google.com; s=arc-20240605;
        b=T6gx4shLBwARowc/ehpXSYJmlpTu0JeSCQ7sXvgCOZCiFWxGQ4u5kp3lKxq4ke2qdu
         gz8xZlmIVEff0T3s2n5MwA6Z2zyKJY8YOxoic+4yVA2W4iHa4iARrcmVMIYsQaW2mICU
         YiJaCFCBNjhH4JHuxv4d8rqlywDN3H1G6pN6l2QUxbaVDBhmYzofTYwJVItU+fGQ9M6Q
         iyvRSKV+0EX3MyLRJ51TTZAeJ36t1wMRFJ5oDPIaFn4OnLX9DI1uZ7la1m2Y+7akUebP
         lZqE7qqP5lTxmj48vRKgJrSJalA/HmfhKgaWpJ2GQL/7MRqJUZRoZn1/RcWErnmgl5qe
         y67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=9QndS1VfpsbUJ6EzyhH2fWmwWWKfi38UGTQ4yQlxF1g=;
        fh=BuW9i8pcHqMLkQXv+ndvaIANn5EyFbPqLAWkY6rS8cQ=;
        b=V6t95ATUmWTQRmPhmk05i4yLfQfJWS9dBv9isRKdidinyYWStIKcwQaldXNdis7qB9
         3vXnIEnwSTAhIeiOhnACPPQaI3VR9W+frid1b1YVmrLYd3aDUmH7/c1EoRtd62DvILx+
         fEWmnSNQ93VDE6nzJB74SD/EfHOYlZRp/2uWfHQgZkaSHr7hLsI+2x+pk/mysD3B2+B8
         okUEt9IDcpSuhJI/3W8VB4YqmN16J/j1BoN85sD8Hpq/AegRmqH1j9nJmf6rEu8DYTr5
         +N1gHjFFkTlwtQ1An+ILL4hCaIzqo8xRx4I2JuEUY75mVlxgC/mQwZ76TgR9dmImeJVB
         3v1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772147632; x=1772752432; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9QndS1VfpsbUJ6EzyhH2fWmwWWKfi38UGTQ4yQlxF1g=;
        b=NWC7fU3MCwO/+k4mcyEnj0vicOiEpHnprRp8Kjp0Un6+LrP/ORK/oU0DdY2Dic4XpS
         OayU+flFcYCTOEuSKYctNFdZ1+ieB5NC+gLCsNb22AdDutqw6P5ROQaByJaOTbFkSmer
         EM8SwAyt5EtI3gIgycxeFNqLxN5riSYBYRSJE5RrGVE691YPrPcINLkenx4wMhrPDiFW
         HE0/tMaZ2HtGRqtoHbn2VaKnxDKZSh6IE2sQ/QvfbunRot+Z1N72cCsxZ0FHGddWCOG0
         8NdHJwTObAzqnWbV2SjrIAT6yjfEwLCS05/YSFbzcMKC4oD7+hCX6f1o/UuTUaX5EQIV
         +yLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772147632; x=1772752432;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QndS1VfpsbUJ6EzyhH2fWmwWWKfi38UGTQ4yQlxF1g=;
        b=VQ2PBSFwfW0HTU9i4FpY7U/IichNjKX0Tp821O+DmkE0yQn46AE/jrPgrLMYtT3LVa
         lwAUbnIuQwMvqzyccCUlMyOerW/qhU+KEWKwMxFglUlhK04nBbNhuRnxZqCGiRuI4GY9
         QsEciqxC2pBmHHWRYaGXeFPUV/ZbrCgEUQo3PGTqpJNvjKDGM8X1wiBdmLRgsL6jW1aN
         7ZNFe3XET6gbyeCzp/ua9vClY2J/4P3ndfGJOCuD1f48s8W/y+DUopR7rwaSevMmR27L
         9wE+zWLWTWsn/B1ye7eez6oDO2kg7/L2jeWqT6vd/pdM4Uo2HdBSK5iCumAXNN9bBo5x
         EhmA==
X-Gm-Message-State: AOJu0Yxd8tiRFiD0ls8RRHTRlSAFfixSPvhdTNs88D2f/w2OpTTEcYsB
	KjJjlq6VTqFhoDhs+5wkWG+qE3RGR6J+2V5aEn6mu8yEGtx1XHnOQzlOp/juwD+wWF5CKneaS/u
	d93sPt16bkJaFqIopRn12Lv5f3okTcxM1uFvL
X-Gm-Gg: ATEYQzyCjH2eY1kvjfmUtp0XITbXrK3hbyNFvAZmypqki3HXxBAOXhEli7zMQPTsXDU
	uxt38/6c6rTRJ5zTdgmbZds00/eqPFoY2QiMR8WOYsQdlEQi2GjXlYQ9j3vtm1j2IeFDB99+gdJ
	BUeu0lCrBh04mkoa5TAZyZGm6EfpuB4ybnNWJM3xqhgNZNSZp6C8PUfptVxCFiaKyPXa+26v0qU
	R+crbt4cnHWZUJ0Lv1fbG5mQEE6+8JcFRU8bm6Sw1CYbTUeAXWe63idFHI1KDNMyKMsUfi9wpR7
	FOi6J1CiVzLzLA7RrwR1UseWL5lFfU4clMMs3XmIXw==
X-Received: by 2002:a17:902:db04:b0:29e:76b8:41e5 with SMTP id
 d9443c01a7336-2ae2e496c4dmr4891075ad.30.1772147631579; Thu, 26 Feb 2026
 15:13:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mark Kharitonov <mark.kharitonov@gmail.com>
Date: Thu, 26 Feb 2026 18:13:40 -0500
X-Gm-Features: AaiRm50zrwWlncv6jp_ZkvELESqiljOpVW3xLZ3c1d8AU7cU_so1RDLzWnugvK8
Message-ID: <CAG2YSPzNUWpj4H15pvMuO0JraauWVQfoMU4TtzTVunZuPxAG=g@mail.gmail.com>
Subject: git pull with configured rebase is incorrectly rebasing
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened?
git pull

What did you expect to happen?
Nothing, because there are no new changes.

What happened instead?
git started rebasing my changes onto master

What's different between what you expected and what actually happened?
Rebase should not have happened

Anything else you want to add:
---
C:\xyz\tip2 [feature/dotnetupgrade =E2=86=91875 +2 ~0 -0 !]> git lg -6 --fi=
rst-parent
7d5c88a7305c |  (HEAD -> feature/dotnetupgrade, wip) Remove explicit
version spec from the package references (76 minutes ago) [Mark
Kharitonov] (2026-02-26 07:55:11 -0500)
fda62f506c75 |  Merge remote-tracking branch 'origin/master' into
feature/dotnetupgrade (79 minutes ago) [Mark Kharitonov] (2026-02-26
07:52:04 -0500)
c6bf5481ad79 |  Adjust binding redirects (80 minutes ago) [Mark
Kharitonov] (2026-02-26 07:51:12 -0500)
5ce2cdc4d4b9 |  Adjust the HR.Modules build (81 minutes ago) [Mark
Kharitonov] (2026-02-26 07:50:48 -0500)
68331ac06b93 |  Merge remote-tracking branch 'origin/master' into
feature/dotnetupgrade (13 hours ago) [Mark Kharitonov] (2026-02-25
20:22:03 -0500)
254eaee2eb36 |  (origin/feature/dotnetupgrade) Merge pull request
#96519 from DFTypedescriptorModelBinder (17 hours ago)
[prvalidation[bot]] (2026-02-25 16:40:39 -0500)
C:\xyz\tip2 [feature/dotnetupgrade =E2=86=91875 +2 ~0 -0 !]> git fetch orig=
in
feature/dotnetupgrade
From *** REPO URL ***
 * branch                      feature/dotnetupgrade -> FETCH_HEAD
C:\xyz\tip2 [feature/dotnetupgrade =E2=86=91875 +2 ~0 -0 !]> git lg -1 FETC=
H_HEAD
254eaee2eb36 |  (origin/feature/dotnetupgrade) Merge pull request
#96519 from DFTypedescriptorModelBinder (17 hours ago)
[prvalidation[bot]] (2026-02-25 16:40:39 -0500)
C:\xyz\tip2 [feature/dotnetupgrade =E2=86=91875 +2 ~0 -0 !]>
```
```
C:\xyz\tip2 [feature/dotnetupgrade =E2=86=91875]> git config rebase.forkPoi=
nt
08:55:01.960045 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/bin
08:55:01.962048 git.c:502               trace: built-in: git config
rebase.forkPoint
false
C:\xyz\tip2 [feature/dotnetupgrade =E2=86=91875]> git pull
08:55:09.493632 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/bin
08:55:09.513454 git.c:502               trace: built-in: git pull
08:55:09.571114 run-command.c:674       trace: run_command: git
merge-base --fork-point refs/remotes/origin/feature/dotnetupgrade
feature/dotnetupgrade
08:55:09.571114 run-command.c:935       trace: start_command: git
merge-base --fork-point refs/remotes/origin/feature/dotnetupgrade
feature/dotnetupgrade
08:55:09.705292 run-command.c:674       trace: run_command: git fetch
--update-head-ok
08:55:09.705292 run-command.c:935       trace: start_command: git
fetch --update-head-ok
08:55:09.753363 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
08:55:09.774963 git.c:502               trace: built-in: git fetch
--update-head-ok
08:55:09.784675 run-command.c:674       trace: run_command:
GIT_DIR=3D.git git remote-https origin *** REPO URL ***
08:55:09.784675 run-command.c:935       trace: start_command: git
remote-https origin *** REPO URL ***
08:55:09.832505 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
08:55:09.853334 git.c:807               trace: exec: git-remote-https
origin *** REPO URL ***
08:55:09.853334 run-command.c:674       trace: run_command:
git-remote-https origin *** REPO URL ***
08:55:09.854340 run-command.c:935       trace: start_command:
git-remote-https origin *** REPO URL ***
08:55:09.894203 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
08:55:10.166061 run-command.c:674       trace: run_command: 'git
credential-manager get'
08:55:10.166061 run-command.c:935       trace: start_command:
'C:/Program Files/Git/usr/bin/sh.exe' -c 'git credential-manager get'
'git credential-manager get'
08:55:10.300457 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
08:55:10.321300 git.c:807               trace: exec: git-credential-manager=
 get
08:55:10.321300 run-command.c:674       trace: run_command:
git-credential-manager get
08:55:10.321300 run-command.c:935       trace: start_command:
git-credential-manager get
08:55:10.500967 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
08:55:10.518302 git.c:502               trace: built-in: git config
--null --list
08:55:10.764217 run-command.c:674       trace: run_command: 'git
credential-manager store'
08:55:10.779970 run-command.c:935       trace: start_command:
'C:/Program Files/Git/usr/bin/sh.exe' -c 'git credential-manager
store' 'git credential-manager store'
08:55:10.907451 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
08:55:10.936422 git.c:807               trace: exec:
git-credential-manager store
08:55:10.936422 run-command.c:674       trace: run_command:
git-credential-manager store
08:55:10.936422 run-command.c:935       trace: start_command:
git-credential-manager store
08:55:11.119491 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
08:55:11.141470 git.c:502               trace: built-in: git config
--null --list
08:55:11.301265 run-command.c:674       trace: run_command: 'git
credential-manager store'
08:55:11.301265 run-command.c:935       trace: start_command:
'C:/Program Files/Git/usr/bin/sh.exe' -c 'git credential-manager
store' 'git credential-manager store'
08:55:11.540731 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
08:55:11.594252 git.c:807               trace: exec:
git-credential-manager store
08:55:11.595252 run-command.c:674       trace: run_command:
git-credential-manager store
08:55:11.595252 run-command.c:935       trace: start_command:
git-credential-manager store
08:55:11.956275 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
08:55:12.008964 git.c:502               trace: built-in: git config
--null --list
08:55:12.947796 run-command.c:674       trace: run_command: git
rev-list --objects --stdin --not --exclude-hidden=3Dfetch --all --quiet
--alternate-refs
08:55:12.947796 run-command.c:935       trace: start_command: git
rev-list --objects --stdin --not --exclude-hidden=3Dfetch --all --quiet
--alternate-refs
08:55:13.782656 run-command.c:1541      run_processes_parallel:
preparing to run up to 1 tasks
08:55:13.785656 run-command.c:1569      run_processes_parallel: done
08:55:13.785656 run-command.c:674       trace: run_command: git
maintenance run --auto --no-quiet --detach
08:55:13.788083 run-command.c:935       trace: start_command: git
maintenance run --auto --no-quiet --detach
08:55:13.835482 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
08:55:13.860648 git.c:502               trace: built-in: git
maintenance run --auto --no-quiet --detach
08:55:13.927319 run-command.c:674       trace: run_command: git rebase
--autostash --onto 254eaee2eb363e2771517fd41e5ac8149b93c8ef
254eaee2eb363e2771517fd41e5ac8149b93c8ef
08:55:13.927319 run-command.c:935       trace: start_command: git
rebase --autostash --onto 254eaee2eb363e2771517fd41e5ac8149b93c8ef
254eaee2eb363e2771517fd41e5ac8149b93c8ef
08:55:13.975412 exec-cmd.c:266          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
08:55:14.006868 git.c:502               trace: built-in: git rebase
--autostash --onto 254eaee2eb363e2771517fd41e5ac8149b93c8ef
254eaee2eb363e2771517fd41e5ac8149b93c8ef
08:55:17.002819 run-command.c:674       trace: run_command: 'git-lfs
filter-process'
08:55:17.009494 run-command.c:935       trace: start_command:
'C:/Program Files/Git/usr/bin/sh.exe' -c 'git-lfs filter-process'
'git-lfs filter-process'
08:55:17.473743 trace git-lfs: exec: git '-c' 'filter.lfs.smudge=3D'
'-c' 'filter.lfs.clean=3D' '-c' 'filter.lfs.process=3D' '-c'
'filter.lfs.required=3Dfalse' 'rev-parse' '--git-dir' '--show-toplevel'
08:55:17.548287 trace git-lfs: exec: git 'rev-parse' '--is-bare-repository'
08:55:17.617373 trace git-lfs: exec: git 'config' '--includes'
'--local' 'lfs.repositoryformatversion'
08:55:17.690074 trace git-lfs: exec: git 'config' '--includes' '-l'
08:55:17.767180 trace git-lfs: exec: git 'rev-parse' '--is-bare-repository'
08:55:17.836677 trace git-lfs: exec: git 'config' '--includes' '-l'
'--blob' ':.lfsconfig'
08:55:17.956280 trace git-lfs: exec: git 'config' '--includes' '-l'
'--blob' 'HEAD:.lfsconfig'
08:55:18.037584 trace git-lfs: Install hook: pre-push, force=3Dfalse,
path=3DC:\xyz\tip2\.git\hooks\pre-push, upgrading...
08:55:18.038605 trace git-lfs: Install hook: post-checkout,
force=3Dfalse, path=3DC:\xyz\tip2\.git\hooks\post-checkout, upgrading...
08:55:18.039123 trace git-lfs: Install hook: post-commit, force=3Dfalse,
path=3DC:\xyz\tip2\.git\hooks\post-commit, upgrading...
08:55:18.039638 trace git-lfs: Install hook: post-merge, force=3Dfalse,
path=3DC:\xyz\tip2\.git\hooks\post-merge, upgrading...
08:55:18.040215 trace git-lfs: Initialize filter-process
08:55:18.040734 trace git-lfs: exec: git '-c' 'filter.lfs.smudge=3D'
'-c' 'filter.lfs.clean=3D' '-c' 'filter.lfs.process=3D' '-c'
'filter.lfs.required=3Dfalse' 'rev-parse' 'HEAD' '--symbolic-full-name'
'HEAD'
08:55:18.117987 trace git-lfs: exec: git '-c' 'filter.lfs.smudge=3D'
'-c' 'filter.lfs.clean=3D' '-c' 'filter.lfs.process=3D' '-c'
'filter.lfs.required=3Dfalse' 'rev-parse' '--git-dir'
08:55:18.189954 trace git-lfs: exec: git '-c' 'filter.lfs.smudge=3D'
'-c' 'filter.lfs.clean=3D' '-c' 'filter.lfs.process=3D' '-c'
'filter.lfs.required=3Dfalse' 'remote'
08:55:18.261413 trace git-lfs: tq: running as batched queue, batch size of =
100
08:55:18.261924 trace git-lfs: filepathfilter: accepting
"ImportExportSpecifications/Imports/HRImport/xyz HR Import
Specification.docx"
08:55:18.269411 trace git-lfs: filepathfilter: accepting
"ImportExportSpecifications/Imports/HRImport/xyz HR Import
Specification.pdf"
08:55:21.914397 trace git-lfs: filepathfilter: creating pattern ".git"
of type gitignore
08:55:21.914397 trace git-lfs: filepathfilter: creating pattern
"**/.git" of type gitignore
08:55:21.914921 trace git-lfs: filepathfilter: accepting "tmp"

Exiting because of "interrupt" signal.
C:\xyz\tip2 [feature/dotnetupgrade|REBASE-i =E2=86=91875 +98 ~964 -395 !]>
---

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.51.1.windows.1
cpu: x86_64
built from commit: 1454f0a9c4a3a22fb3fd7cc33f76f88cd65ced41
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.16.0
OpenSSL: OpenSSL 3.5.4 30 Sep 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26200
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
post-checkout
post-commit
post-merge
pre-push
