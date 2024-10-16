Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DDC208D6C
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084069; cv=none; b=Wm70S34kU93eYCLjTZBe/J7QGeCk6LUjRBUP371aKWna2oio3sjcN/UiufJpAoUmZdcWshZ/1Qrs61zNW8z5VK2jAM19fG6WKLBojJk8e6B1F1tpDv+fPobPYRQo1MGFy6g9VvLFc4R9FZZAft2iRH52uOYdWC8UYHSLMaYJcUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084069; c=relaxed/simple;
	bh=+e6IioSrz8feugdT++V4/HvCUfzt0H6Owvv5yNwUDwQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eudaV8j98iPUxnWW3R08N8W5J+YDHTExCS3jPyNr+Si48kKiQJxpwdyAVyOTHXl5f2mLX7CfgnqB4M57ce3sGJ8TB6tFW0Yba4JqBjbNlVogwt4mUrG4oZF3r3Q90mm6DcoEosgvbhq6XWhm9ovynj6hXeX5V7LXRo/qMSp9dxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xz47Jou3; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz47Jou3"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e7ff0d4681so2393213eaf.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729084067; x=1729688867; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+e6IioSrz8feugdT++V4/HvCUfzt0H6Owvv5yNwUDwQ=;
        b=Xz47Jou3z2qjkC0hEw5HhffQU3uyhg4h5UzpaDJ1VROF+rPMhHLghoZ4MgCKfQ5cVP
         YOL+Y+/4Q0PxY+7u3A1PxOvjFGnDwt3u+NS1wcKW+mkxjyk0LVxaFCU0zmjronwNdKHq
         AsR4lDkls4s5SKtSUSWGvlNeSrVV/AQUmabE+CCcpa/QcMCLo3fVPQ463E1/HUQetKyV
         9nol1uQALJsW0MQ0nmt3shpBe+Mh1/eTpp6BO6xFEAtcjYXA/ZYEos5l1qC4rrtKIEtD
         AygmdR160Rur1J6n5XOytlzaDmIYLbo+JmiVaZ/tiWm5Z9diG9IMMP8ShYx/XrLIcPaW
         V6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729084067; x=1729688867;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+e6IioSrz8feugdT++V4/HvCUfzt0H6Owvv5yNwUDwQ=;
        b=Pu1kcxiA8SuRIr3UXdm1GFPeCXM3m/2HmHCdIdJWenD8fKZnQnycWM0pu/CJyK3/fa
         DplXacJygJyXmxqap+zBkSOrvbqZ13WRIIitdp7BaNrA+Utl340MBStEhDfNmJ9kjufD
         SXuC4/vNA4pEtPVL5rogil4Apr0ZQEmWjTpLfeU5empoCQ7Ax8/w10gFm0ouw4a9QN9o
         fDKAyUUBTjI+rGBWlpNwTwQD5HrkbWon1oXQRF5+xYTWFtnmN7HqrkFrblfi2cGJSu2s
         33pjcFQE4xJpnRXxDu8chUdepfG6UXklrzD0weGezsptObGJblWyetcDe5BQjqYqj/wL
         R15w==
X-Gm-Message-State: AOJu0YxyA2zsSEF9xh/m7wDWV2KzXRgw7WyGxpj0mXV6zOxIV3gMDhNY
	mok8+25MVgiIhofYjrYBTG/slqkekIF/Chg5ynNzZU1ov5LmL1m9biQ26Et/bjyPq7Dh2s4XXgh
	aoz4FMK0A6vdGhU5jfVeH+gSEvsuIp3plGjw=
X-Google-Smtp-Source: AGHT+IEy0JBdPFI8F/u+FvUYWt4a/0ecFNzRQ98jGamF3MYze3BLrYl7dTRhNLC+sJoL7M9qVcAdVp44VspniuW8dvg=
X-Received: by 2002:a05:6358:3a0f:b0:1bc:7c1c:9fbd with SMTP id
 e5c5f4694b2df-1c340cae2e1mr314759355d.2.1729084067341; Wed, 16 Oct 2024
 06:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Germ=C3=A1n_Ferrero?= <ferrero.gf@gmail.com>
Date: Wed, 16 Oct 2024 10:07:36 -0300
Message-ID: <CAH08wShkp6Mnz5itcbT=GyCY7_dW5eQWLy0yBFS8njUHumpQZw@mail.gmail.com>
Subject: git submodule update --init breaks if run twice in parallel
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git submodule update --init & git submodule update --init

What did you expect to happen? (Expected behavior)
Something like:
[1] 334031
[1]+ Done git submodule update --init

What happened instead? (Actual behavior)
[1] 333889
error: could not lock config file
/path/to/my/repo/.git/modules/path/to/my/module/config: File exists
fatal: could not set 'core.worktree' to '../../../../modules/path/to/my/mod=
ule'

What's different between what you expected and what actually happened?
The difference is that in the expected behavior (working up to git
2.44.1 at least),
I got no error by running in parallel git submodules update --init.

Anything else you want to add:
In our scenario git submodules update --init is command run by tasks
that are schedulled
potentially in parallel.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /nix/store/izpf49b74i15pcr9708s3xdwyqs4jxwl-bash-5.2p32/bin/bas=
h
libcurl: 8.9.1
OpenSSL: OpenSSL 3.0.14 4 Jun 2024
zlib: 1.3.1
uname: Linux 6.8.4-2-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.4-2
(2024-04-10T17:36Z) x86_64
compiler info: gnuc: 13.3
libc info: glibc: 2.39
$SHELL (typically, interactive shell):
/nix/store/izpf49b74i15pcr9708s3xdwyqs4jxwl-bash-5.2p32/bin/bash


[Enabled Hooks]


--=20
Germ=C3=A1n Francisco Ferrero.
