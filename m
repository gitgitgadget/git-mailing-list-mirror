Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D81DF736
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146814; cv=none; b=nhilJpl9henwmp+zveIDUmIStR0BsqTvb65McqStqyzm3mqhk4AT4Prk+8T7mSfxUerrE3299EHiSigNbCcqQ/rwWCzikGldgRyuRq2ZAlIUZN7IUHSWfp/JTB447qRR/IcgnTWi+aaV/l/v9Ic22t1jgQkUcYd70XEgvmV9Fng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146814; c=relaxed/simple;
	bh=x6GXOpaTdRWFVjjOMih/1u2yppOSEdaaKLDFl6QlhTE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nlkTVN62QwRrnK0OrRoykjruG9hOaxVAIJLBXL3/2NGK6+QbAEqsWJwN3vQL1ulDNzWJ55OItVKtHz70M8m817+oUgFZ7B9sbsudh337/upx1HcugmQ09Iwl+417QgW8a+oir864WKUgJIP5OeQUin0RSkZiSgvFss7RSpHBKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqfpezvC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqfpezvC"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a16b310f5so737220366b.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730146810; x=1730751610; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K93hEJEJV8aH5ZY2oy4haNvdAUAyQe/OCxHiaMQbKls=;
        b=EqfpezvC2TiCfZPYM2HRIDsgeSSqE5L2w9WynSTWGpeHvXS2HGjdWZRNzJk+LrG8De
         K9erCJ4UZH1/gONku+f/jOF+IFfiOGqh4/loPAMgR0/aMbEqQppqTC86cw6wgHhIzr1o
         Wp+6YpDOywKZT3aEvzHug0zmqveqj5zlpQEATV6c9m76MZkDvqhZfqTxRIs0bMkWofOa
         s4mlC16pmq0EbZhwsSzEXRYt+56n3tCY83U8apARLQDWDz3CkYTgxM5WhI7EMLQFioPk
         tSXBXwUkGDQQp9xnuuNmrOwO5mbvOu12uPdm9NajFT7rNY0RfkviJHgfOj6zQPRIvxAP
         Feng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730146810; x=1730751610;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K93hEJEJV8aH5ZY2oy4haNvdAUAyQe/OCxHiaMQbKls=;
        b=nps6wAPcer95rsaLSucT8L59QFMCzTGSxXzfHX/1cSaWWGC8D0SBdaXN0Ioi2MhHvV
         smqeYoQW8NKqSdlMAgWSPi124QuUciPiCnt4LS0Nbw+Z2R+u3gmuNoWc6TulETUgqenY
         Y72UL2DWeOC0PWG2dDsq4crIo5AzHdWF5/dNkwUjvLh74rV8fZlsHX/LLka2Q2PeUTpr
         QArcSwqeFmAEjB5ZxxvgPhh/Pa6n9qX9rtY1zuX275SlB6zv6F1M4alX0zVOdrrKPHiR
         2rKH0RKl4ryulVqG+n85OyPp/Owdh0rNkfoejbYNyne3yr15Kcj2XgHgQTzpLG2ziIAm
         0Hlg==
X-Gm-Message-State: AOJu0Yy80cCswhfjIHrzIfGCsqqlL2cGGCSFLTMDZYLqBBmsU05vE7qo
	gApZIXaIryGmrZIDRhXBqv1wzCGQ2d+Uhy2RS9o68/oDMo51vWIHZZFZXkN7QJhu+tm075lvcuW
	qasN35qihCHALMW4mcw2HORAtJK9GhkJ/8Dc=
X-Google-Smtp-Source: AGHT+IGEQEokC7Yhu0cpstrsTgHm+7idCUd9jaVEvpUEw7pxtsBXoEIV+oU/IrF5aTOeYsKvAbDCwgRfTXZZuX6Wg+4=
X-Received: by 2002:a17:907:3f04:b0:a9d:e1d6:41fc with SMTP id
 a640c23a62f3a-a9de61ddf1fmr929088966b.53.1730146808868; Mon, 28 Oct 2024
 13:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kevin Navero <knavero@gmail.com>
Date: Mon, 28 Oct 2024 13:19:57 -0700
Message-ID: <CACRG6_ApLKqnVrvQziUtF4nkquk_HPiXTMR-NDdx85BSN1ng4g@mail.gmail.com>
Subject: Opening git-bash from git-gui and cd'ing to the root of the
 filesystem results in git-bash thinking it is at the top-level of the repo
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Generated this bug report using git-bugreport:

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

    Note: Was redirected from
[here](https://github.com/git-for-windows/git/issues/5234), on the
speculation that the bug report might not be Windows-specific.

    1. Open git-gui from the Windows start menu (or whatever the
equivalent on Linux is)
    2. Select an existing repo, either through `Open Existing
Repository` or one of the paths below `Open Recent Repository`
    3. From the top menu, click `Repository`, click `Git Bash`
    4. In git-bash, `cd /` (expecting `/` to *not* to be a git repo),
then `git status`

What did you expect to happen? (Expected behavior)

    fatal: not a git repository (or any of the parent directories): .git

What happened instead? (Actual behavior)

    On branch foo
    Your branch is up to date with 'origin/foo'.

    nothing to commit, working tree clean

What's different between what you expected and what actually happened?

    The output messages. The expected behavior is to fatal. The actual
behavior did *not* fatal. In both cases, the current working directory
is at the filesystem root, which is expected to not be a git repo.

Anything else you want to add:

    It seems that what is affecting this is that opening up git-gui
sets the `GIT_DIR` env var automatically. The resulting behavior seems
somewhat non-intuitive and confused myself and a colleague. The
resulting behavior I expected was the behavior one would get if
git-gui spawned a git-bash shell with the current working directory
set to the repo's path, but *without* setting `GIT_DIR`.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

    [System Info]
    git version:
    git version 2.45.0.windows.1
    cpu: x86_64
    built from commit: b5d0511969ccd9ab86395c37e5a7619d8b4e7c32
    sizeof-long: 4
    sizeof-size_t: 8
    shell-path: /bin/sh
    feature: fsmonitor--daemon
    uname: Windows 10.0 19045
    compiler info: gnuc: 13.2
    libc info: no libc information available
    $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


    [Enabled Hooks]
    post-checkout
    post-commit
    post-merge
    pre-push

- Kevin Navero
