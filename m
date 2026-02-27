Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1E36CE03
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183516; cv=none; b=KjPnJpfqDm3iFuiYLNBAFvcFJdaxEUPgvPU/ZJ6iknFlMER/dkylA0ZJvs/r2ivU7aOKR/h7zKlyWpzXarYj6MXkPwfn5BZaANa6HX65ffXeFUMzP494XgvPD52L6WCcF29XZe2KK0DwmVyIDRIOOQYfNa+C0XTcrt/B9zWDuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183516; c=relaxed/simple;
	bh=KKn2R21qnr2ifZLWZj+NLRcPmLT81nNADyzE2yeLR40=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UOEBbG5FFcgFDE+p2VYJGvstja7i+QWAa5SY39eWkOIGP6RSEEkt0pHdaqbH6hN4Ofc5caAMdkN22I1MGNPpgjte9aJcD/HYS1/baF/031SmdiksWX9LS67kOJbw7BbJe+cReC6atk4UCsjw7hQk1d9s6rQAFgss1sc86YgWvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU13UfBI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU13UfBI"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-436309f1ad7so1453907f8f.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 01:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772183513; x=1772788313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K7FF/8U5Qa2xhdH+pVBuQyYtF+/RQSX89EQ1cXdROc8=;
        b=ZU13UfBI5CLZHsYm267wQCehWHX8ui0EfSKN819jjzTMmlYa6cJAd7LiKby80DI3D8
         Mz0W2q6Mg6t1ls9tYjQYZrndE8qJFVnV0IhAOnWtupZ7SQFyg8ihmyc86J9nuXYLcqvK
         3qVKYENyRlcH3q6fHfJO9tdQwa4JzXhhdrL2shHbv5LKuusc0KuT9cW5fX2wRn0gy/EM
         Re95jO2/vn47H4E97TEkRGb1MPSg8Dm2+88psbthAl/Ixc3G3AMSnmbq4doUn9Yvcayf
         gUnx9hq/sXPRB7lOsCn6LMBW3PWSlC9Agj1f9OwRh/69Uh4TpJHPHLsoPAMTLVKIJAEw
         2dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772183513; x=1772788313;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7FF/8U5Qa2xhdH+pVBuQyYtF+/RQSX89EQ1cXdROc8=;
        b=rNW9MKAY6Df1G6wiS1azOFZAnh3MiKq3foIWL986prznBBrUkXGF5zOq21wh+14cMr
         9ei1wvmO3h/o2Ofy0dMh+jB2WS/WRWfXbfuTDQhcXk63moqyW9M1GxFSEEuueDyEqI+H
         lmDvBqIpGEQgtO4scy0hJZZBB63KxcqlQ15nAMOH9cG+31p7DtoWC9Xzqs672kub4DBD
         mBYofcsyEjfejwEsQ1eXicQ1W2mg4FxbMT3cO9V4vbT5fpFQB8TjnGgOP46fv4eNlzij
         pOMbI7F90mSPmG35ZNcmOA1Q4u7Z3LsXWRqhkY6ls1jph8co2vko3luh50dZqGDNysdF
         6o1w==
X-Forwarded-Encrypted: i=1; AJvYcCWqtLIm41POxEb0wtc0sSoInxIHcVGLEjYEu/Tmq7F986tgyJrs2ibhLL6i264WpCuv0CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQcbFgCx9lqvLO36f2LcLYmQsOrDt/cjp1lj93LGmsOEdSSXJ7
	WMaEnBPH7RUbLeRSAYrMyW6Hg6PjPXSlrodUkXLyguS4IItnfloHUP35
X-Gm-Gg: ATEYQzw0BJA86jnnLUX2LQafkZzitzX4gOZJRqKWo6kQ17zn2A8kwkzdYZlxCV2Ansr
	TkAj0go+tjPkoQTwaUaEDJZf1KwnDViHGhn4uVg8lBEIVdgM5NNFaefU++EkPqc6wXgNFN1EtwI
	TncmDWc84VwN1K34Eb+1YJl7VuVTvrzj9ZcRsK/i4b5swJwRpEbwNPQ0ty8gZHqdlUCBsGXUaW2
	w9xz4yc+OQfzZjt8SLlEYdSQEMlZRFTjiRULQhZqe6qlyllDhBrGmqt5ndO67QBdbJ80Xur6ya8
	bZVKANkK19l326IkdIHrEg69Qnhb+V/+DdJOh0KATMZhyW6kRsa4hYmb0V4GZ9Xa67lUbTcFsNY
	TekaM+1V+BJuw1tv/Tbrr1BKvRlEBWpBhdjihDI9sLuR7/d+Crdyyupffroa5OOSUuib6ttPHFV
	OehEj88Ku64bG2Q71dTYJ1yuNuw5MF06Iq+hWdfYendEvMX2AfloKahAgRZGVZP9SRnpzsaf1hg
	tVUQw==
X-Received: by 2002:a05:600c:3b99:b0:483:71f7:2796 with SMTP id 5b1f17b1804b1-483c9b9d99cmr31262935e9.10.1772183512418;
        Fri, 27 Feb 2026 01:11:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60e40fsm5449741f8f.7.2026.02.27.01.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 01:11:52 -0800 (PST)
Message-ID: <9e8005bf-8429-41ef-8904-885e44470cb4@gmail.com>
Date: Fri, 27 Feb 2026 09:11:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git pull with configured rebase is incorrectly rebasing
To: Mark Kharitonov <mark.kharitonov@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
References: <CAG2YSPzNUWpj4H15pvMuO0JraauWVQfoMU4TtzTVunZuPxAG=g@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAG2YSPzNUWpj4H15pvMuO0JraauWVQfoMU4TtzTVunZuPxAG=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mark

On 26/02/2026 23:13, Mark Kharitonov wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened?
> git pull
> 
> What did you expect to happen?
> Nothing, because there are no new changes.
> 
> What happened instead?
> git started rebasing my changes onto master

Assuming the upstream branch is origin/master then looking at the output 
of "git log" below that seems to be expected as you have commits in your 
local branch that are not in the upstream branch. I can see that you've 
merged origin/master into your branch which means you have the changes 
from upstream, however your branch is not based on top of the commits 
that introduce those changes and so "git pull --rebase" it will still 
see local commits that are not upstream and try to rebase.

Thanks

Phillip

> What's different between what you expected and what actually happened?
> Rebase should not have happened
> 
> Anything else you want to add:
> ---
> C:\xyz\tip2 [feature/dotnetupgrade ↑875 +2 ~0 -0 !]> git lg -6 --first-parent
> 7d5c88a7305c |  (HEAD -> feature/dotnetupgrade, wip) Remove explicit
> version spec from the package references (76 minutes ago) [Mark
> Kharitonov] (2026-02-26 07:55:11 -0500)
> fda62f506c75 |  Merge remote-tracking branch 'origin/master' into
> feature/dotnetupgrade (79 minutes ago) [Mark Kharitonov] (2026-02-26
> 07:52:04 -0500)
> c6bf5481ad79 |  Adjust binding redirects (80 minutes ago) [Mark
> Kharitonov] (2026-02-26 07:51:12 -0500)
> 5ce2cdc4d4b9 |  Adjust the HR.Modules build (81 minutes ago) [Mark
> Kharitonov] (2026-02-26 07:50:48 -0500)
> 68331ac06b93 |  Merge remote-tracking branch 'origin/master' into
> feature/dotnetupgrade (13 hours ago) [Mark Kharitonov] (2026-02-25
> 20:22:03 -0500)
> 254eaee2eb36 |  (origin/feature/dotnetupgrade) Merge pull request
> #96519 from DFTypedescriptorModelBinder (17 hours ago)
> [prvalidation[bot]] (2026-02-25 16:40:39 -0500)
> C:\xyz\tip2 [feature/dotnetupgrade ↑875 +2 ~0 -0 !]> git fetch origin
> feature/dotnetupgrade
>  From *** REPO URL ***
>   * branch                      feature/dotnetupgrade -> FETCH_HEAD
> C:\xyz\tip2 [feature/dotnetupgrade ↑875 +2 ~0 -0 !]> git lg -1 FETCH_HEAD
> 254eaee2eb36 |  (origin/feature/dotnetupgrade) Merge pull request
> #96519 from DFTypedescriptorModelBinder (17 hours ago)
> [prvalidation[bot]] (2026-02-25 16:40:39 -0500)
> C:\xyz\tip2 [feature/dotnetupgrade ↑875 +2 ~0 -0 !]>
> ```
> ```
> C:\xyz\tip2 [feature/dotnetupgrade ↑875]> git config rebase.forkPoint
> 08:55:01.960045 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/bin
> 08:55:01.962048 git.c:502               trace: built-in: git config
> rebase.forkPoint
> false
> C:\xyz\tip2 [feature/dotnetupgrade ↑875]> git pull
> 08:55:09.493632 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/bin
> 08:55:09.513454 git.c:502               trace: built-in: git pull
> 08:55:09.571114 run-command.c:674       trace: run_command: git
> merge-base --fork-point refs/remotes/origin/feature/dotnetupgrade
> feature/dotnetupgrade
> 08:55:09.571114 run-command.c:935       trace: start_command: git
> merge-base --fork-point refs/remotes/origin/feature/dotnetupgrade
> feature/dotnetupgrade
> 08:55:09.705292 run-command.c:674       trace: run_command: git fetch
> --update-head-ok
> 08:55:09.705292 run-command.c:935       trace: start_command: git
> fetch --update-head-ok
> 08:55:09.753363 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 08:55:09.774963 git.c:502               trace: built-in: git fetch
> --update-head-ok
> 08:55:09.784675 run-command.c:674       trace: run_command:
> GIT_DIR=.git git remote-https origin *** REPO URL ***
> 08:55:09.784675 run-command.c:935       trace: start_command: git
> remote-https origin *** REPO URL ***
> 08:55:09.832505 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 08:55:09.853334 git.c:807               trace: exec: git-remote-https
> origin *** REPO URL ***
> 08:55:09.853334 run-command.c:674       trace: run_command:
> git-remote-https origin *** REPO URL ***
> 08:55:09.854340 run-command.c:935       trace: start_command:
> git-remote-https origin *** REPO URL ***
> 08:55:09.894203 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 08:55:10.166061 run-command.c:674       trace: run_command: 'git
> credential-manager get'
> 08:55:10.166061 run-command.c:935       trace: start_command:
> 'C:/Program Files/Git/usr/bin/sh.exe' -c 'git credential-manager get'
> 'git credential-manager get'
> 08:55:10.300457 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 08:55:10.321300 git.c:807               trace: exec: git-credential-manager get
> 08:55:10.321300 run-command.c:674       trace: run_command:
> git-credential-manager get
> 08:55:10.321300 run-command.c:935       trace: start_command:
> git-credential-manager get
> 08:55:10.500967 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 08:55:10.518302 git.c:502               trace: built-in: git config
> --null --list
> 08:55:10.764217 run-command.c:674       trace: run_command: 'git
> credential-manager store'
> 08:55:10.779970 run-command.c:935       trace: start_command:
> 'C:/Program Files/Git/usr/bin/sh.exe' -c 'git credential-manager
> store' 'git credential-manager store'
> 08:55:10.907451 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 08:55:10.936422 git.c:807               trace: exec:
> git-credential-manager store
> 08:55:10.936422 run-command.c:674       trace: run_command:
> git-credential-manager store
> 08:55:10.936422 run-command.c:935       trace: start_command:
> git-credential-manager store
> 08:55:11.119491 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 08:55:11.141470 git.c:502               trace: built-in: git config
> --null --list
> 08:55:11.301265 run-command.c:674       trace: run_command: 'git
> credential-manager store'
> 08:55:11.301265 run-command.c:935       trace: start_command:
> 'C:/Program Files/Git/usr/bin/sh.exe' -c 'git credential-manager
> store' 'git credential-manager store'
> 08:55:11.540731 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 08:55:11.594252 git.c:807               trace: exec:
> git-credential-manager store
> 08:55:11.595252 run-command.c:674       trace: run_command:
> git-credential-manager store
> 08:55:11.595252 run-command.c:935       trace: start_command:
> git-credential-manager store
> 08:55:11.956275 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 08:55:12.008964 git.c:502               trace: built-in: git config
> --null --list
> 08:55:12.947796 run-command.c:674       trace: run_command: git
> rev-list --objects --stdin --not --exclude-hidden=fetch --all --quiet
> --alternate-refs
> 08:55:12.947796 run-command.c:935       trace: start_command: git
> rev-list --objects --stdin --not --exclude-hidden=fetch --all --quiet
> --alternate-refs
> 08:55:13.782656 run-command.c:1541      run_processes_parallel:
> preparing to run up to 1 tasks
> 08:55:13.785656 run-command.c:1569      run_processes_parallel: done
> 08:55:13.785656 run-command.c:674       trace: run_command: git
> maintenance run --auto --no-quiet --detach
> 08:55:13.788083 run-command.c:935       trace: start_command: git
> maintenance run --auto --no-quiet --detach
> 08:55:13.835482 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 08:55:13.860648 git.c:502               trace: built-in: git
> maintenance run --auto --no-quiet --detach
> 08:55:13.927319 run-command.c:674       trace: run_command: git rebase
> --autostash --onto 254eaee2eb363e2771517fd41e5ac8149b93c8ef
> 254eaee2eb363e2771517fd41e5ac8149b93c8ef
> 08:55:13.927319 run-command.c:935       trace: start_command: git
> rebase --autostash --onto 254eaee2eb363e2771517fd41e5ac8149b93c8ef
> 254eaee2eb363e2771517fd41e5ac8149b93c8ef
> 08:55:13.975412 exec-cmd.c:266          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 08:55:14.006868 git.c:502               trace: built-in: git rebase
> --autostash --onto 254eaee2eb363e2771517fd41e5ac8149b93c8ef
> 254eaee2eb363e2771517fd41e5ac8149b93c8ef
> 08:55:17.002819 run-command.c:674       trace: run_command: 'git-lfs
> filter-process'
> 08:55:17.009494 run-command.c:935       trace: start_command:
> 'C:/Program Files/Git/usr/bin/sh.exe' -c 'git-lfs filter-process'
> 'git-lfs filter-process'
> 08:55:17.473743 trace git-lfs: exec: git '-c' 'filter.lfs.smudge='
> '-c' 'filter.lfs.clean=' '-c' 'filter.lfs.process=' '-c'
> 'filter.lfs.required=false' 'rev-parse' '--git-dir' '--show-toplevel'
> 08:55:17.548287 trace git-lfs: exec: git 'rev-parse' '--is-bare-repository'
> 08:55:17.617373 trace git-lfs: exec: git 'config' '--includes'
> '--local' 'lfs.repositoryformatversion'
> 08:55:17.690074 trace git-lfs: exec: git 'config' '--includes' '-l'
> 08:55:17.767180 trace git-lfs: exec: git 'rev-parse' '--is-bare-repository'
> 08:55:17.836677 trace git-lfs: exec: git 'config' '--includes' '-l'
> '--blob' ':.lfsconfig'
> 08:55:17.956280 trace git-lfs: exec: git 'config' '--includes' '-l'
> '--blob' 'HEAD:.lfsconfig'
> 08:55:18.037584 trace git-lfs: Install hook: pre-push, force=false,
> path=C:\xyz\tip2\.git\hooks\pre-push, upgrading...
> 08:55:18.038605 trace git-lfs: Install hook: post-checkout,
> force=false, path=C:\xyz\tip2\.git\hooks\post-checkout, upgrading...
> 08:55:18.039123 trace git-lfs: Install hook: post-commit, force=false,
> path=C:\xyz\tip2\.git\hooks\post-commit, upgrading...
> 08:55:18.039638 trace git-lfs: Install hook: post-merge, force=false,
> path=C:\xyz\tip2\.git\hooks\post-merge, upgrading...
> 08:55:18.040215 trace git-lfs: Initialize filter-process
> 08:55:18.040734 trace git-lfs: exec: git '-c' 'filter.lfs.smudge='
> '-c' 'filter.lfs.clean=' '-c' 'filter.lfs.process=' '-c'
> 'filter.lfs.required=false' 'rev-parse' 'HEAD' '--symbolic-full-name'
> 'HEAD'
> 08:55:18.117987 trace git-lfs: exec: git '-c' 'filter.lfs.smudge='
> '-c' 'filter.lfs.clean=' '-c' 'filter.lfs.process=' '-c'
> 'filter.lfs.required=false' 'rev-parse' '--git-dir'
> 08:55:18.189954 trace git-lfs: exec: git '-c' 'filter.lfs.smudge='
> '-c' 'filter.lfs.clean=' '-c' 'filter.lfs.process=' '-c'
> 'filter.lfs.required=false' 'remote'
> 08:55:18.261413 trace git-lfs: tq: running as batched queue, batch size of 100
> 08:55:18.261924 trace git-lfs: filepathfilter: accepting
> "ImportExportSpecifications/Imports/HRImport/xyz HR Import
> Specification.docx"
> 08:55:18.269411 trace git-lfs: filepathfilter: accepting
> "ImportExportSpecifications/Imports/HRImport/xyz HR Import
> Specification.pdf"
> 08:55:21.914397 trace git-lfs: filepathfilter: creating pattern ".git"
> of type gitignore
> 08:55:21.914397 trace git-lfs: filepathfilter: creating pattern
> "**/.git" of type gitignore
> 08:55:21.914921 trace git-lfs: filepathfilter: accepting "tmp"
> 
> Exiting because of "interrupt" signal.
> C:\xyz\tip2 [feature/dotnetupgrade|REBASE-i ↑875 +98 ~964 -395 !]>
> ---
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.51.1.windows.1
> cpu: x86_64
> built from commit: 1454f0a9c4a3a22fb3fd7cc33f76f88cd65ced41
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.16.0
> OpenSSL: OpenSSL 3.5.4 30 Sep 2025
> zlib: 1.3.1
> SHA-1: SHA1_DC
> SHA-256: SHA256_BLK
> default-ref-format: files
> default-hash: sha1
> uname: Windows 10.0 26200
> compiler info: gnuc: 15.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
> 
> 
> [Enabled Hooks]
> post-checkout
> post-commit
> post-merge
> pre-push
> 

