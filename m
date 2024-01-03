Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454918C10
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu92oxQv"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-20475bf35a2so632113fac.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 02:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704278004; x=1704882804; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=mw4yLId3O8ZWQuY39AALLzM35PWnpzwAvB+oqAgMmbo=;
        b=mu92oxQv7vsmj/Y8uGZZPtU4ucsFwnpFaT53svKIpGcrx7EFGsR8wt/zpX3KBP+8fK
         fElCX39/hAyEDRWHxFLoncjNKOROOVX6lfyuElNPDD4t4++1M8HyOhf3G7JpqXAa1Z6q
         Fq5h2vRpzGWHPFCfjODnBxzdLUVdWtpcw0uCtYYeFFOP+GNvm6kvZVArDq+BazBFTjYk
         7VQ1HHdZKZ0Lp+5J7otcZmizO9SG4qA5MMRbj1fErtVCt1wJ9i5rjFe5e4ROJ9LnwqNa
         haSOYF7PiJYpMjmbCTKrSyRMX4DiCfrunub0VpKHmqZsGyQZ3iGksKXvMGynC4qS5LJA
         xz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704278004; x=1704882804;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mw4yLId3O8ZWQuY39AALLzM35PWnpzwAvB+oqAgMmbo=;
        b=F8As8Vj6bOB98v4nyIDoYlf9sf/1REi17Aoprnf0BUgh+38DNtSh2obe77lUKO538z
         DHDl4NcpfA3ijW5zMKT8bZl5YQD8GCXW0ydqnptQwbH8uTO1TW4MblQ7NOcd4KoL/pHw
         EZqc5m239Bh8wKRIoGpoXozFWPNgusAJpCgoOwREZnrsx3QNusmvml2SSZ6yudBhO/4a
         Tc5KHInuOkkEmDN7XoOnfhvE9Oc8aa12z/Uz2sgUwReiu0BYdOvXwLJ0bZL1dEMnTerS
         UzQFFjtTn0WWQGiETDIcqIccMizrw2W5R8O80YvNunmi6uyRTb0o0j8l4VuQkjFyuY/f
         sPxg==
X-Gm-Message-State: AOJu0YzQFXvlwO/xnq+AzxS307IsnwX9X5/WEBaZzqhNw/FW6XncgR2n
	bkgDx1Oic5GWxrlOvPR5ncrNJgkjuIs=
X-Google-Smtp-Source: AGHT+IGxAT/99LY/kExfCaFBwqvFbG1HduMHTyDFvkvDrWDyXBD3p+MCfa7DnoD9Xsyx9IkfMsPmUg==
X-Received: by 2002:a05:6870:1706:b0:204:1d62:9a8b with SMTP id h6-20020a056870170600b002041d629a8bmr35183508oae.5.1704278004188;
        Wed, 03 Jan 2024 02:33:24 -0800 (PST)
Received: from epic96565.epic.com ([2620:72:0:6480::1])
        by smtp.gmail.com with ESMTPSA id bi42-20020a05620a31aa00b00781ea9404dfsm140775qkb.90.2024.01.03.02.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 02:33:23 -0800 (PST)
References: <m0y1e7kkft.fsf@epic96565.epic.com> <xmqqcyvgz3ih.fsf@gitster.g>
 <m0sf43abw7.fsf@epic96565.epic.com> <xmqqa5qbmnrm.fsf@gitster.g>
 <35f24a01d15ce28932bb6be098d6a164a49cc542008f75673cd6221a9b24b578@mu.id>
 <m0frzeu89w.fsf@epic96565.epic.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's the recommendation for forgetting all rerere's records?
Date: Wed, 03 Jan 2024 03:27:51 -0600
In-reply-to: <m0frzeu89w.fsf@epic96565.epic.com>
Message-ID: <m05y0au2od.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


There was enough going on with that prior email that I gave it another
look and found some errors.

>     $ echo 'bad merge' >file
>     $ git add file
>
>     $ EDITOR=: git rebase --continue
>     file: needs merge
>     You must edit all merge conflicts and then
>     mark them as resolved using git add
>
>     $ git rebase --abort
>
>     $ git rebase main
>     Auto-merging file
>     CONFLICT (content): Merge conflict in file
>     error: could not apply b4d7aeb... local
>     hint: Resolve all conflicts manually, mark them as resolved with
>     hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
>     hint: You can instead skip this commit: run "git rebase --skip".
>     hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
>     Recorded preimage for 'file'
>     Could not apply b4d7aeb... local
>
>     $ git checkout --merge .
>     Recreated 1 merge conflict
>
>     $ git rerere forget .
>     error: no remembered resolution for 'file'
>
>     $ echo 'good merge' >file
>
>     $ EDITOR=: git rebase --continue
>     file: needs merge
>     You must edit all merge conflicts and then
>     mark them as resolved using git add

This section should have read:

    $ echo 'bad merge' >file
    $ git add file

    $ EDITOR=: git rebase --continue
    Recorded resolution for 'file'.
    [detached HEAD 5e3c431] local
     1 file changed, 1 insertion(+), 1 deletion(-)
    Successfully rebased and updated refs/heads/feature.

    $ git reset --hard @{1}
    HEAD is now at b4d7aeb local

    $ git rebase main
    Auto-merging file
    CONFLICT (content): Merge conflict in file
    error: could not apply b4d7aeb... local
    hint: Resolve all conflicts manually, mark them as resolved with
    hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
    hint: You can instead skip this commit: run "git rebase --skip".
    hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
    Resolved 'file' using previous resolution.
    Could not apply b4d7aeb... local

    $ git checkout --merge .
    Recreated 1 merge conflict

    $ git rerere forget .
    error: no remembered resolution for 'file'

I've driven myself a little nuts trying to reproduce it this morning,
but in doing so I've come to an important discovery: this bug presents
if `core.autocrlf=true` but does *not* present if `core.autocrlf=input`.

For completeness and future reference, the following script reproduces
the issue on Windows:

    git init
    echo aaa >file
    git add file
    git commit -ambase
    git branch feature
    echo bbb >file
    git commit -amremote
    git switch feature
    echo ccc >file
    git commit -amlocal
    git config rerere.enabled true
    git config core.autocrlf true     # <--

    # setup complete; let's rebase!
    git rebase main
    echo 'bad merge' >file
    git add file
    EDITOR=: git rebase --continue

    # uh oh; that was a bad resolution; let's try again
    git reset --hard @{1}
    git rebase main
    git checkout --merge .
    git rerere forget .               # fails
    echo 'good merge' >file
    git add file
    EDITOR=: git rebase --continue

At the end of this script, the 'bad merge' is still the recorded
resolution and no rerere record exists for the 'good merge'.

Just in case there's another piece of config somehow relevant, here's a
dump of the system that reproduced this:

    $ git config --list --show-scope | sort
    global	user.email=[clip]
    global	user.name=[clip]
    local	core.autocrlf=true
    local	core.bare=false
    local	core.filemode=false
    local	core.ignorecase=true
    local	core.logallrefupdates=true
    local	core.repositoryformatversion=0
    local	core.symlinks=false
    local	rerere.enabled=true
    system	core.autocrlf=input
    system	core.fscache=true
    system	core.fsmonitor=true
    system	core.symlinks=false
    system	credential.helper=manager
    system	credential.https://dev.azure.com.usehttppath=true
    system	diff.astextplain.textconv=astextplain
    system	filter.lfs.clean=git-lfs clean -- %f
    system	filter.lfs.process=git-lfs filter-process
    system	filter.lfs.required=true
    system	filter.lfs.smudge=git-lfs smudge -- %f
    system	http.sslbackend=schannel
    system	http.sslcainfo=C:/Program Files/Git/mingw64/etc/ssl/certs/ca-bundle.crt
    system	init.defaultbranch=main
    system	pull.rebase=true

    $ git --version
    git version 2.43.0.windows.1

It's worth noting at this point that while I believe I reproduced on
macOS last week, that doesn't jive with the available evidence (and I
can't reproduce it on macOS this morning, though I suspect that has more
to do with native use of LF over CRLF than anything else).

--
Sean Allred
