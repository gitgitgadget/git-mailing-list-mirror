Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FE1D63FF
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740957755; cv=none; b=kRn7Hf645fNVIZ79XTC/RLGotdwtS6sw1EoJVK/ElKtAz4AcoO+qrt5HkCnjEV4B+NmkcwP+LHSYx6poGpgIYebDUNyFL/FeRt38IeIIdI6fx13yWlTAvoTXVO3sSXMlO+GN0rEQ+YkXSs7vmaV0E8KdCbSMgiDniG6MuLAQqJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740957755; c=relaxed/simple;
	bh=mq0ZCJ6Q57pYG9ZiZVue/n6A5eDqvZ4axArReJPL38A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MojBj9et54rheOEyfLQk1WJUGcFBfheIYDXhWz54cxuwV4VPcUSpmP4V6pkV3jbUembFg1WSVyKvJa0BzgybFYXlsRj+gdiG1i+vU5ypiYLwDzwnJzjn2PiYLmFnaijw8Vp31GIPvmJ4xqwVxB3UuLV7MGrl8D/s+Ug3qX90i5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxxmuyPP; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxxmuyPP"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb379so836561a12.3
        for <git@vger.kernel.org>; Sun, 02 Mar 2025 15:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740957752; x=1741562552; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zKhnxWE5UZLVz2HX9OonSFina7mzgjZzMdzWI5Kzp5s=;
        b=QxxmuyPPOTlkcnSGfW6/vxzQ3J9kopt4/aiv6c/t5gldyqKO/bGw77bEGdN4pG7P6H
         r1K71Yx2zNZiRvkAVKQIEJ0w16hhnkNgWoopshqyTdjKJ2pequNGrWUb2fIvmsmKGOyL
         +aoyQ9TWSDGUcAHheFOv330C4qaHD474E7opT2YZ2zQOiGCRizDFWAapdgma/Ug3u92C
         3YetJNN8VJeRQgqo40ViapOAREIY0EwYE1ORjDGgaOnXeMvvTSq8N2NhkLFDZhq3NwEl
         4Wykj9IDODmdaN0AlWAPYmqUoKZOwAM3fMQ4LsVF1+0avtKy2HO0ZYY14fObSSGjGBSV
         SaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740957752; x=1741562552;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKhnxWE5UZLVz2HX9OonSFina7mzgjZzMdzWI5Kzp5s=;
        b=TbT8mgFqEn/qCaa3Y6h3CEGxDVsE9/1AisjLL8krI47J4Y7/KOBKSteqTLP08/lV0Q
         v5yLevBGK9t4qiLsSino8VgOrMpZba4nPzE6/ROE6bvUcY6+zdd22ws6lOdx+1W6zte8
         /6/sjX7bcbHHUZcVSNUElVrq3eKESwe9ZJUP2GubHNypqElzWAdWF2wsmzt2mkZEEags
         N1WfZ92kN7TRhjcIp4eXOa4uejTrUiVdtQkulYdSJs1v8LZiriNFyNgXDM5fiYI4sWgQ
         XyCXFStNjdcT+jQ+mjEBZFkAAkJ8QvvBG5w5KSRFZQs/4Mb1yI0C94MYq9iARpyUee21
         Yj9A==
X-Gm-Message-State: AOJu0YzxaKNqhmIB9UAGnTqsPfxeiQzXu7db2MiON6E67p3PWNSngAr+
	IGDM2pri2h57mtoU6z2Xkz6OLu9eKkH1nYInU7hu3nx8cMHwU3cl68sumZFH0SQxDjIa1tmjXYH
	4R7t10ZjARqwPuxCRbdSc1bcXI5K97iKpVyM=
X-Gm-Gg: ASbGnctv46i9CjUjX5p3n4F25YW6VhMEx1gb/YlLtAHoe4ew7iVAHthTvGrzQQ8S5wc
	ZQ22KK2BntpZiCweSwAccFL1kzP4/MquDqc/iwFmF7BCeH7Ia1A4ktUPOKubI4ZkbwiCEQM3dU+
	PIaiia5mLav517SlqpnIy1EBv9/rk=
X-Google-Smtp-Source: AGHT+IHYbxYrlwJG4LajPryqlqZUoNQVnVRUbgs+Att2OHqndYol5jmYIKBvg5pzRQwn++6FcpGB5IKgaMmRTBMUyzs=
X-Received: by 2002:a05:6402:274a:b0:5de:dff7:7d8f with SMTP id
 4fb4d7f45d1cf-5e4d6afeb21mr12404726a12.18.1740957751693; Sun, 02 Mar 2025
 15:22:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Henry Reed <henrymicreed@gmail.com>
Date: Sun, 2 Mar 2025 15:21:55 -0800
X-Gm-Features: AQ5f1JrvqnHepObskivh9FPPOmyE8wWUk8tC7domVQPb1QngkBTKH1dRqE8KOdc
Message-ID: <CAKe9kabKXpPQVvJX9vryNi8btk9DeFjOaE=bqp9yDvA3oaiqEA@mail.gmail.com>
Subject: PKCS#11 authentication fails due to escaped URI
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I modified ~/.gitconfig to include my PKCS#11 URI for my YubiKey 5 smart
card. The contents of my ~/.gitconfig are:
[http "https://git.example.com"]
        sslCert =
"pkcs11:model=PKCS%2315%20emulated;manufacturer=piv_II;serial=0011223344556677;token=someUsername"
        sslKey =
"pkcs11:model=PKCS%2315%20emulated;manufacturer=piv_II;serial=0011223344556677;token=someUsername"
        sslbackend = openssl
        sslkeytype = ENG
        sslcerttype = ENG
        sslCertPasswordProtected = true

What did you expect to happen? (Expected behavior)
I expected the URI to be passed, as is, to OpenSSL, without escaping
special characters

What happened instead? (Actual behavior)
Git appears to escape special characters in the URI, like the equals sign,
colon and semicolon, causing OpenSSL to not recognize the URI. This is
the command line output is:
git clone https://git.example.com/org/repo.git
Cloning into 'repo'...
fatal: cannot exec '/usr/bin/ksshaskpass': No such file or directory
Password for 'cert:///pkcs11%3Amodel%3DPKCS%252315%2520emulated%3Bmanufacturer%3Dpiv_II%3Bserial%3D0011223344556677%3Btoken%3DsomeUsername':
fatal: Authentication failed for 'https://git.example.com/org/repo.git/'

What's different between what you expected and what actually happened?
The URI should never be escaped.

Anything else you want to add:
The version of Git in Rocky Linux 9 is 4.35.5. The URI is not escaped in
this version.

Separately, note that the serial, username and repo URL have been modified.
I am working on a non-Internet connected system with Fedora 41. I am unable
to disclose the YubiKey serial, username nor the repo URL.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.48.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.9.1
OpenSSL: OpenSSL 3.2.2 4 Jun 2024
zlib: 1.3.1.zlib-ng
uname: Linux 6.12.13-200.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Feb  8
20:05:26 UTC 2025 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
