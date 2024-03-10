Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536FE16FF29
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710076341; cv=none; b=d2adiFST7Sn+Lqd63accRVgpvaqYb+U4mvOJ942d674RFo6LIHB3+RZrGL38q/Vd6yGdrhnBZjHMV6GWe/Z+a7y78CzjD5geXdusGyS24A+GMnihwEwAsnGie35qwV3Kv/I9NPZAQE36hd6u3WoOdBLj4OH55Nk+JRh9bgMwfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710076341; c=relaxed/simple;
	bh=pXTTYvG+5GMJ09ruU1LCf8Wn6efQsKMqcjdU0RII4fw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CNHW8OR2tcH1v3snBdmfpekN5FOsIAtf4KIk+LxCCNN39vyxXsqWePh7deGowjNr55rHoppibXvLhh8YnB6zP+Lr5M28e4cujbsqTiItYJWmSjYMKyWBG3KnCd+a5bq9QGCwURvuYEDXW++pwAm10+V8y4FCytJ4nPu7kIYAmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jasc@gmx.net header.b=UZ5KpbYd; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jasc@gmx.net header.b="UZ5KpbYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1710076337; x=1710681137; i=jasc@gmx.net;
	bh=pXTTYvG+5GMJ09ruU1LCf8Wn6efQsKMqcjdU0RII4fw=;
	h=X-UI-Sender-Class:From:Date:Subject:To;
	b=UZ5KpbYdL4NqW3Wo12D0qGORlEGuSKCTM9JRqrRNXdq7C/PqL2hrau3nSgAWuaFg
	 oq4o5EGWdq4FHMv+72mlOKI9kTD5fOcYUzCDOIPL8aiEnlh5pjIs6jB9t7Hn8q3wQ
	 4laGN7alYP0JODWaSOKKJ93BhCJd3J31+sTWhmc00wcVgVjB2yxOWd8dcVVMaJwDU
	 CKueIkHMYbYwmik09KfHIYB07OFONMxO/Lqm1nr4PxH5rZm8X5bnakMugVUPUiRPE
	 sVmE9aznru27FkdOJvYgLvhhGoZ42XPuF5JZqF4dtNVicxja4+X0VH6IhnRH/mFBw
	 btvp+H1O5wOfsyCBYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mail-il1-f178.google.com ([209.85.166.178]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MeU4s-1r8sE90uVY-00aSRk for <git@vger.kernel.org>; Sun, 10 Mar 2024 14:12:17
 +0100
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36642b33351so7664865ab.3
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 06:12:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YzcLZZNa9JMOewk1YUpYKqdRBij++F5u+8Xn/L6XVCTlKGE3mQ4
	3nEgPbLva+8+nHe/SltUxS8cesII6Th7afjvv/uT21IlEx197rQO1dMGuo3jmF/ep6UqSQ15Eny
	JhQNVCVkIhdSGJwAFaIC0WJi42MU=
X-Google-Smtp-Source: AGHT+IESmb9Zsl6mwoNLiKPPAq9Rm3UDD4nTNvbyLFwjWBkIS/3vNeM4xFg5MpcMHDFml4BKG20N6chS1QZllv6w3OI=
X-Received: by 2002:a92:cd84:0:b0:366:35a7:bb3d with SMTP id
 r4-20020a92cd84000000b0036635a7bb3dmr7598710ilb.25.1710076335783; Sun, 10 Mar
 2024 06:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jan Katins <jasc@gmx.net>
Date: Sun, 10 Mar 2024 14:12:05 +0100
X-Gmail-Original-Message-ID: <CAP+2wOWvb8Xy5Q_u26FhZrVHazBG0ZCoKnzR8LUKo51f-NXndA@mail.gmail.com>
Message-ID: <CAP+2wOWvb8Xy5Q_u26FhZrVHazBG0ZCoKnzR8LUKo51f-NXndA@mail.gmail.com>
Subject: "git maintenance start" adds entry to the main config file, not to
 already existing maintenance section in included file
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+C4XEbfB7bkrPRsrEMdeID9S0TAvDtld7/54Fp05Tx+lPZGV7Vl
 0uxAGhPyhn6MbW4U1RFTzql5VMDoMTEz9PpakmZvxC5bKNBLkRKL43nW9ZEwvJEyGsLDB8m
 Otz3glSXhdh+sXkrt9iqf0KjcgWWAkRgwuMpSzh9wRkJUCEHlfPn+vnHl8Q+wKJEv3ydgoZ
 znCYc198w3Y6YoYAx0L5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mLrk4vm68tc=;BS7Mpg1tOHcDCe+utN9cjEe5+S6
 q7z0PkxD37AJJLLN2xu0vdmxzwd1Z0U8WeyvvFUQZ6KRiK1RKPc+LfNSWTFkHwWk80qt0VeIf
 AmhjrNdwfrk5TEWA3XmOWee9lySvXhWFB6UqnCSQE0QyA3eVrORL/w3TvC8W9eFT6+6qGThfM
 3e2STW+6Z/S04yYBa8s+lw4o6TM7ukvsv3w4s34lgIzMMOjebLznBPKF+7G9DfnLxiXmpu3z/
 myP6QvR8/f+owufyOPaKT/rwAnqPyXsGzMZ9o0zhw40kDvuVfncso1kYOgA0m0jm8vVcRZXCE
 +4CR4TLoKMfke7OEcMO86CQwQEiRSSDXsWMLWirmeHwM2Hg1gwl+2QP9cBFS6j4MvpYdN+vi/
 wFY3DSJFPOhm4MqXP57PwnuoTqGy8cHGky5EdD1hZ+A4GwfDwfKdo3kYjkMN4L4jaYsHxSZk0
 oEDWib7tNWfcZSRepbw8imu16lEN88IiJol/esTRtd/zYmvJ8MOBj0ziov70i/ivfAqIbcF2+
 QFEV9ytCo7Y34YaSXuZxiQvQR9f/6r5H9ApXQAbV5uASQBG2x4qO1A0vPKoIO0QQ8cJdtcYZd
 j6KMwoJqIYFBfY4o3VOxo4Hfgs0twnfIyjWTmeus65vFRWHHlj6ntbfIEYnlC5MQJP058xRuj
 oT27kRgNju1inMNZ0hh/G11O3it99ixriw1GitLcJhZm9+4m7chWx8SblrwitsLiUSu17eqnC
 Qyn1zzG76Gi6oCQqoB86+Sr9P7Gof9GchfsouxtVpM5jxQe/PjuZxH3RRk3BGMvw3ifDLI8Ei
 Qwg8W1wxOJ6V81Vdhf8NipSPGF0Zldw9e+ZBTrQz/Y+OA=
Content-Transfer-Encoding: quoted-printable

Hello!

What did you do before the bug happened? (Steps to reproduce your issue)

I've a git config (in ~/.config/git/config) which reads:

```ini
...
[include]
    path =3D git_config_local_maintenance
....
```

In ~/.config/git/git_config_local_maintenance I have:

```ini
[maintenance]
    repo =3D/User/jankatins/projects/whatever
```

ran `git maintenance start` in a new repo.

What did you expect to happen? (Expected behavior)

That the new repo gets appended in
~/.config/git/git_config_local_maintenance to the already existing
maintenance section.

What happened instead? (Actual behavior)

An additional maintenance section was added in the main config file
with the repo key added there.

What's different between what you expected and what actually happened?

The additional maintenance section in the main config file instead of
appending the repo in the already existing section in the included
file.

This is "undesired", as I have my main git config file in a dotfile
manager, but don't want to have the (much more frequently changing and
laptop specific) maintenance entries in the dotfile repo.

```
[System Info]
git version: git version 2.44.0
cpu: x86_64
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.4.0 Darwin Kernel Version 23.4.0: Wed Feb 21 21:44:31
PST 2024; root:xnu-10063.101.15~2/RELEASE_X86_64 x86_64
compiler info: clang: 15.0.0 (clang-1500.1.0.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/zsh
```

Kind regards

Jan
=2D-
jasc@gmx.net
