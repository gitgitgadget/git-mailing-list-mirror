Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8787C135
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e86fc3f1e2so4635737b3.0
        for <git@vger.kernel.org>; Sat, 06 Jan 2024 08:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704560226; x=1705165026;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixa4iwWGo1U4f/etORVWvBj2I72794xJcG2W8/THZzY=;
        b=O5sIfxyubZk0YSLzAc4CvH0yconkc7nWVOIB/rlEU8WhDEX14J4U8o4bKeO7ssaB07
         k5rmZiOlouaiHuYNs9AIsyFU2eU0d6Rzb7toI+lB/kukAPoIZR169y2uxD9chJQgspFe
         uBSlbt1iFJUf2Jbrkeo5rSnBAGzl7Bqs+D7pU04UhQQDkA5/MAd6xofsHKCHrd2CaKds
         qMtcfJ8uQjwgjCKm45bYMczIIQwyskZVkIHVXHmdnxjcQqmUimJLuMJp3Lq7RKVdQwQl
         DrN0y6BPYLrDyoREl/XNhXSnjRL9F9Uy3skKP64OyNG6yUx4Aek1uysJZ781dmEP6dGZ
         61ig==
X-Gm-Message-State: AOJu0YyyfiHrSab3qe7waG2+AKaGYAczhi1IbFIoUohpwtYcnedu85jm
	XVhqw+4cOsPHVr5y0fl0Cex4pio+rIQL195XJjA7yzN9RQ8=
X-Google-Smtp-Source: AGHT+IEbP3TKTDmhsp4sGw9Z9qjd3A/l4w+MlrsKocDfxOB35OfG+cC+ysFWnxFSl/aktymXVj05O+qKG+OLajA3DMU=
X-Received: by 2002:a81:8a44:0:b0:5ea:eb5c:a797 with SMTP id
 a65-20020a818a44000000b005eaeb5ca797mr792862ywg.10.1704560225559; Sat, 06 Jan
 2024 08:57:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maxim Iorsh <iorsh@users.sourceforge.net>
Date: Sat, 6 Jan 2024 18:56:29 +0200
Message-ID: <CADQ_TR56X_iMitPEiaOyR_h=1dp9ThUQMu_Vqjest1i8xbh9Tw@mail.gmail.com>
Subject: Bug: git log with log.showSignature enabled
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

iorsh-linux:~/devel/fontforge/build> git log -n 1 --oneline
2aa98f6a5 (HEAD -> master) Dummy signed commit
iorsh-linux:~/devel/fontforge/build> git config log.showSignature true
iorsh-linux:~/devel/fontforge/build> git log -n 1 --oneline
2aa98f6a5 (HEAD -> master) gpg: Signature made 17:47:50 2024 =D7=99=D7=A0=
=D7=95 06 =D7=A9' IST
gpg:                using RSA key XXXXXXXXXX
gpg:                issuer "iorsh@users.sourceforge.net"
gpg: Good signature from "Maxim Iorsh <iorsh@users.sourceforge.net>" [ultim=
ate]
Dummy signed commit

What did you expect to happen? (Expected behavior)

When asked for oneliner or any specific format, `git log` shouldn't
show signature event when configured.

What happened instead? (Actual behavior)

`git log` always show signatures with log.showSignature enabled, even
for explicit formatting requests.

What's different between what you expected and what actually happened?

Anything else you want to add:

This behavior obviously breaks any script which relies on git log to
produce preformatted info about commits. It's also quite rare, becaus
e probably very few users set log.showSignature config option.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.0-91-generic #101-Ubuntu SMP Tue Nov 14 13:30:08 UTC
2023 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/tcsh


[Enabled Hooks]
