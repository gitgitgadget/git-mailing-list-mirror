Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051B51CA69B
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374344; cv=none; b=NFTshMpMLoThXtpT6NAQCaZMxncky2FNLUG82Z5BD7jig3iE54euv8AHGeKiOs3JgbsytYEPPuZDWTwM1On7MEoQDzIAx17NILYK4CeG6dAqqrzRMXiXd8p29YqKfmIzwncRN6lWO06wpFxnOF0HllV7W2CCKIUdeazaCrMVquE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374344; c=relaxed/simple;
	bh=1GSs1NhL4GHUqOeFA111vu1hAXo7J00w/JuU/EBtrOc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=R9oFPJ8ib9je2rpM0g8LaN/7thPGDE5/c/w0zSYx9aDrq7qmuQD2W+7eK5GnaGl7+Ms++bBe/39/0T5K3Vbd0+cXBegEfWHrAHp0l4qklgoAqSa37iG+awI99FQcekbOOGkv3E2loX67+7O3lCzYHeW0JwjDuW8l+qtiroA2MOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=friendbuy.com; spf=pass smtp.mailfrom=friendbuy.com; dkim=pass (2048-bit key) header.d=friendbuy.com header.i=@friendbuy.com header.b=ffehbNyd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=friendbuy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=friendbuy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=friendbuy.com header.i=@friendbuy.com header.b="ffehbNyd"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cb3db0932cso4071385a12.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendbuy.com; s=gmail; t=1725374342; x=1725979142; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aEHkGP8Fkz8UschsHKZnbajfDf6ShJbAoYjP6y63SDY=;
        b=ffehbNydHUduhryUay2Mqcq2IuylX1JV3BFeyODE6sS5S+nq7IyhGo5wH11/EHXU54
         8jp5DnYYky0dofBL/f+fj5eZzkArE0cbrhpkKQ02i1brzoj3DjmiJgjnsjS67nBBMtqV
         NrjqMQtzxYMPXKPJPXhaiFCy9zHaAquU+1MB7LxHLMQZaG5h1gqumYes8HuWOcVrYUa7
         N9EM7eVcuAjmqCf9DX6Nz46a9Q6qFjKQ6hF58mFeeKLhnyMV2M7DUz5sQOd80zAGk5Dj
         CukN6TuOSyfV+7vcHUJZ0hwfanvTmA3KxcDdanQ9cY4MjqtDH+78J84Xso+tPhrpc0yC
         vijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725374342; x=1725979142;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEHkGP8Fkz8UschsHKZnbajfDf6ShJbAoYjP6y63SDY=;
        b=XV7OOBo6lggHp07qcc2iwVxBJU5qd5hTcXcZzDbWeq7UOh0S+QV3Ft5kSG8qIcbALk
         MzM4Sst1qGu3GXR6vSQjiH1EbwRgUGJtLa5Z6ZlgvwcumouE0xlQ5jcuLr047fha3qe5
         SSaP1qrB4eSjoyGcEPA7hgvEhOKrJcO3JQIcGxThlN7WoFFAyLjF4K+aQWYhcxYKyNrG
         MNBiaOHgK/i+kSi/9nxbfwxaVDkUE40PLvFQAStgmCogGtodhmSzXUu95QZMvJDjB18q
         dBDxHt0Fow21DQ0K9dcKk+mb18k5wOTjEYuvNvroYcLtjOdM46J3Pcf0Kdr9m0DzKnFC
         HeWw==
X-Gm-Message-State: AOJu0YxXzpEBQyXJYPIhtpj0r5G7JBiXPgqssgNVMoqYigLfH+68lJ5Y
	RH22qjIN/LpiKLTPOJZZBu0W0sz01/yqJrTQMTAPyfh6bG7UsogTbEjEa7jvrQoxYQMroJym3I6
	fSiMSUoXn6VdMu6/j52qGlt3FViqo1M/w8XJXkgRVJE268bU+qdw=
X-Google-Smtp-Source: AGHT+IFap8GOnOdQ+PodkfarnXlIpcLeOhzfvRy71YccKT+KDrhEIzmGcUBLVhsAjCPjpEr3SUI+VBZ+CmUVKhyqg9k=
X-Received: by 2002:a17:90b:1108:b0:2d8:92c7:d336 with SMTP id
 98e67ed59e1d1-2d892c7d377mr10840001a91.22.1725374341822; Tue, 03 Sep 2024
 07:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Hull <david.hull@friendbuy.com>
Date: Tue, 3 Sep 2024 09:38:51 -0500
Message-ID: <CALpyDwE12kHV--NkbcSgxLacsYw_w1wdBhzM21-JO1yYKW2PwA@mail.gmail.com>
Subject: Bug in "git diff" exit code with submodule and `--submodule=log`
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

Create a git repository that has a submodule.  The git repository
itself should be clean but the submodule should have changes that have
been staged in the main repository.  Then run:
`git diff --exit-code --cached --submodule=log --; echo $?`

This shell script will reproduce the bug:

```shell
#! /bin/sh

set -x

(mkdir sm; cd sm; git init .; git commit --allow-empty -m 'initial')
mkdir test
cd test
git init .
git commit --allow-empty -m 'initial'
git submodule init
git -c protocol.file.allow=always submodule add ../sm
git add .gitmodules sm
git commit -m 'add submodule sm'
(cd sm; echo "hello" >greeting; git add greeting; git commit -m 'add greeting')
git add sm
# This exit code is correct:
git diff --quiet --cached --submodule=short --; echo $?
# This exit code is wrong:
git diff --quiet --cached --submodule=log --; echo $?
```

What did you expect to happen? (Expected behavior)

The output of this "git diff" command should be `1`:
```
git diff --quiet --cached --submodule=log --; echo $?
```

What happened instead? (Actual behavior)

The output is `0`.  The output is correct if the `--submodule=log`
option is omitted.

```
% git diff --quiet --cached --submodule=log --; echo $?
0
% git diff --quiet --cached --submodule=short --; echo $?
1
```

Anything else you want to add:

I believe this bug was introduced in git 2.46.0 or shortly before.

[System Info]
git version:
git version 2.46.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.4.0
zlib: 1.2.12
uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Mon Jul 29 21:13:00
PDT 2024; root:xnu-10063.141.2~1/RELEASE_X86_64 x86_64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
