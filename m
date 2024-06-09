Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89363AE
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717915914; cv=none; b=ZrTItik2kGEqaMPlPh2H1BRbK/LkdkV1seniTVqtJ4WMWtYiLqLkYxibrRKDKKGqQ31wVlxzrD/Uq84hpqeXtrzofLzAxAXkz9PPc/zKNt2lXthIYsxq73NAfX7dgdUQ2XRVcnDQWjMy2JhLQ0ILHkohyi8aixghJ0G5Nqh9wNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717915914; c=relaxed/simple;
	bh=Fj6gTlTn5+CW73nFhLhwW3SPwKO5ZPWzHlawYw218mg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=cuMIagZtcYsIzVLWFupVVAIecbQHswRFdELcVtBEXPvAoPAymUSxeZp86mXFn0dANT5HP1+qMzHTXRjgWHe1vn9V3qGuDtDtE7sM38uc82M8qA8jDg0HVbJwSBy4SoPYDxZnI5bGU/QI0hOKAT+uQ4u08E4Mg/+kfhKF4rG7sDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpyomKA/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpyomKA/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f658800344so27511375ad.0
        for <git@vger.kernel.org>; Sat, 08 Jun 2024 23:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717915912; x=1718520712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=02kCars3P1UfGSVasszAKnMUrRQts1KTTAh52OIF0Vo=;
        b=EpyomKA/ppnwokfZ/Cf7jqrvnj/ZVR3ImHTjpB72n/Q5J0P3KWvuby9vbPd9mli+Sb
         rIY4QkuIRkc8jk+SPOLKso9jHSW4gWD/VxircyxZJfARg/8WtGYHt1+cHflJ8UnIPpVQ
         /vvwoImH099rt6k1rvGRrHNDZVy5lRo9hXXfbUlq1zCZXe1G7TO8VerEaei5b1yfhntM
         0sim9PNNeWj9/xMPZ7mqe0/XNW0aOiHGoWk6Mv3XBi+TLRMnetXg70eSYpYlHalUxpMw
         D/497X4xcIJ8w6VMyT9zaRyCy3s7yMnJF7be2qe5tkYz5PSlRJOtayXqPzr8KYnKSaUJ
         +o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717915912; x=1718520712;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02kCars3P1UfGSVasszAKnMUrRQts1KTTAh52OIF0Vo=;
        b=SfSjZJH25KxT0uReN0A4hM8cgqF8YzaQxN3Q2vqppTtRzFrqvMyYDM1tAW3CiZ61sa
         Y40lZKsC34G1Fh2cyT40MBpjqepAaduc2gRAODPAifBN5HFAZtcpiwLQEkgIU6NaW9p3
         0qYMquWcx7GDtlTcOWIsnv0osI6PmVS/ETNiTOQp78XtehGyjDxdCTT5hV7c7CB0Xvfs
         w19vwru3myybCIPnWz1J9/N0qoKhdQvFz3zu5FdB2vPKDbR1A9uzhBr1GkLLe4CSvWx3
         IYgPdyx5MU9LKSrHJu/PCMjQodeYoUoZ+l7LYftR7N0232F1MFBdEl7A9tU6uhWijmi5
         F1ug==
X-Gm-Message-State: AOJu0Yz22tMxfp4dQPuwiMX87wh1TmC2VFEro6bNa8eOLTJcF32GocTD
	9lCeEEJW979giNqM1iB5GqleQPBsAerXVhmTF5aBBonpXRbH5HQ4ZMyjuQ==
X-Google-Smtp-Source: AGHT+IGp1FvF6/TYnffIzyZkpm79x4wJrJhUEl8UfXixX91Ui/nhBTn5n2SU1AFzkCE0kgq+nn5XKQ==
X-Received: by 2002:a17:902:e887:b0:1f6:a8d2:4ab3 with SMTP id d9443c01a7336-1f6d02dd157mr92738035ad.19.1717915911648;
        Sat, 08 Jun 2024 23:51:51 -0700 (PDT)
Received: from ?IPv6:::1? ([2401:4900:330a:9be4:10a2:99d3:a699:eea9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6d8cc0496sm39729925ad.6.2024.06.08.23.51.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 23:51:51 -0700 (PDT)
Date: Sun, 09 Jun 2024 12:21:47 +0530
From: Mathew George <mathewegeorge@gmail.com>
To: git@vger.kernel.org
Subject: Cannot override `remote.origin.url` with `-c` option
User-Agent: K-9 Mail for Android
Message-ID: <83D801A8-3878-43C1-B7A7-78B3B7315FD8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue=
=2E

> What did you do before the bug happened? (Steps to reproduce your issue)

```
# Create a test repo to pull into
git init test
cd $_
git remote add origin wrong-url
# Create a test repo to pull from
git init =2E=2E/test2
cd $_
touch a
git add =2E
git commit -m 'commit to pull'
# Attempt to pull, setting remote=2Eorigin=2Eurl
# The following git commands will fail:
cd =2E=2E/test
git -c remote=2Eorigin=2Eurl=3D=2E=2E/test2 pull
git -c remote=2Eorigin=2Eurl=3D=2E=2E/test2 fetch
# However, this succeeds:
git pull =2E=2E/test2
```


> What did you expect to happen? (Expected behavior)

The '-c' option should allow me to override the remote URL,
which, as a result of running `git remote add`, is configured as
follows in test/=2Egit/config:

```
[remote "origin"]
	url =3D wrong-url
```

From=20git(1):=20
```
-c <name>=3D<value>
    Pass a configuration parameter to the command=2E The
    value given will override values from configuration
    files=2E
```


> What happened instead? (Actual behavior)

The following errors are produced for both 'fetch' and 'pull'
operations:

```
fatal: 'wrong-url' does not appear to be a git repository
fatal: Could not read from remote repository=2E

Please make sure you have the correct access rights
and the repository exists=2E
```

Regardless of the -c option, the commands above use the url
'wrong-url' from =2Egit/config=2E


> What's different between what you expected and what actually
> happened?

The -c option is not respected=2E


> Anything else you want to add:

It may be that this is not supported, but if that's the case, I
missed any documentation saying so=2E


> Please review the rest of the bug report below=2E
> You can delete any lines you don't wish to share=2E


[System Info]
git version:
git version 2=2E45=2E2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /usr/bin/sh
compiler info: clang: 17=2E0=2E2 (https://android=2Egooglesource=2Ecom/too=
lchain/llvm-project d9f89f4d16663d5012e5c09495f3b30ece3d2362)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
