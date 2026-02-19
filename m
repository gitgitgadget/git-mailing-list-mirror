Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47930125B2
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771459920; cv=pass; b=jB4LOvCp27BqblZx8x46ONn3TrBkjGtjKeo+wuEJsJiDeWogxLcqM9MOqb/xOAh4VwxGsxE96iiz+flxMF59wv6zFNhmcvx3EKGTcDdxFLOuA1svyQXlURIpzmjMc8ia4pSiT5uShKQqNszjyxEKToHtfgnGAMfRVwGq9D3Fb5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771459920; c=relaxed/simple;
	bh=cgLmny09Zh/nPRWuAx13UBrFmLzI3qFcY7AMeGBLM24=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GMpgvDS/CdMXKEmbH3C8qcgGzFnWcVrt6PEWzXKRmwKLijzmc316r95tR2LQ41nWersgenQbBgrxyU82XJI4ZeTpA/nzHnjHJZxZPWaMZHwRQZpm5dAGUTIXpzFU+DsCvwYslIRPTgjpY8Lte2ZXk1RGHHD3vaLw9AbDjEmo0YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/NCXc3v; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/NCXc3v"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so181421fac.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 16:11:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771459918; cv=none;
        d=google.com; s=arc-20240605;
        b=BJdilQcEmgVcbwfiO1pfrNdiR93PkT0zW3O9r3zJ6JZ2VASz/Jk6QcoKpyCjyZWmWO
         yVw0zFX10dgBOjYPT4ELhvTkbqd1OUnv/hoP+viJ6KLAWvZUCMmrJJA3h2Jv/jbMscJd
         FxfsC2A1yBFo+rxxCtGiWgQy2yE5Is2r/4o/nE5QMVptB8ywTmCB+jE4JcrBMjTidycK
         XfpR7dr38N1AQIC4p/BpjsFqm1NyRTDGvGx3J2tNRuxhfCvPBGLgSg053MeXW8bmg9ZD
         0bH0gUkS07uC0TUCac8KxxLBJFmQL3mf6PcTs5EfBkvgrOxOOcK90dzgpWzqISjyW1tl
         Af0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=cgLmny09Zh/nPRWuAx13UBrFmLzI3qFcY7AMeGBLM24=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=RypBYjcwl+rav5MOiP9syLYeqk6NMV0QgsIc3CkDr0pnU4QWE+nRonFXnR7QLzwGMj
         v0KZcMud4Oz0Z0Jc7oRB6/WF9QtsLNP7geUJsGjE8sX5p30kNoMNf4R66g302yX205o6
         DQ23RELw1ZTshNIQgm9jPKLRHcU23Xq9GuwW61NQs6HHEYhCjB43ZYZ1tXpWXnIUyQVo
         o4C1D0fAtw6sdPexU1ykDkC6MsZR4NmrxYQKuSdGK1mDF0hgv0egoyGH6uAG/YGrBa1H
         U2JP2DDgXeljF5EiKoY2eAY3KJ1rDO7GyCdjLZYEdulMKtPnSUL+Ri0SZkT8uq4yQi1O
         JHXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771459918; x=1772064718; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cgLmny09Zh/nPRWuAx13UBrFmLzI3qFcY7AMeGBLM24=;
        b=I/NCXc3vZ7h2RsDbKy2135t27YrfthVr390zAGXQzod3fDwAx9wn+vSOKJGc/UBsgr
         dr29WHaqwQGm9wexv6T9DSGYBOBInn1Cdpu0gx3mWZ3A+Ngp3DE84ABiwToadmaB9ZbH
         bmKbPs7L616yQjC8mRNTjeUwRUQPYUwrsSUOpIoI61hav+7aTBhrFUzMwR2y56nCH0xy
         KXAMqBKL2uLC6A3dMecXISZXfZcHlAdCydEiKwEfXEOT/3WWEaxOigkgRTo8JeDnRksd
         NfRvNqW3+NpBQCIqjDxGzUpiY5ndAuQo3tUkEBoOcUgWAJFKbnPJJuZc1MqY84yqzp0z
         6SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771459918; x=1772064718;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgLmny09Zh/nPRWuAx13UBrFmLzI3qFcY7AMeGBLM24=;
        b=BHXekTqFP4TluhZoIitvokhkH95XbzqPi+maEu+RFujQFO3d4DbsmSh2aklZsUjRBF
         SOIJJfQ6foCNShg69RI2N96RPNCihcKlXrju9tliv4VOAP3qfktkntqVzBZ+3CA+24zP
         sLZwj1xPsBMmsP0/isur9dIWIdBnKKVKYQbAM6ZdTXJnzn1bAyZCptP43X7SgNgH84AL
         OftWIPCiK/hsOJfTFT4aHuRQlddAShoGn4IbebycgunEjuOl2rzX331mL8ZJGrnXSHa3
         SgYKx3w8W6j1IPaaD1qz/8knNAUDKMvj3hN2s7mPt1kvh+bkx0+vzpZbYk6+dTqTURZ+
         1olw==
X-Gm-Message-State: AOJu0YxSv6H0nU6ETeWlfiXmn+ghRA3JpG8vXuUdiI3CHaZ8CJAwSGP6
	HEjhzblPRuuvuzIgzngC9kaqOdV1ESZNhpZlevdoYpSaUBElqHyRbLghmlC3GOYlEIL/ymD7Jqd
	eBJzikqln/1m04joOeDdwwqloj0eSlV+zOJJD
X-Gm-Gg: AZuq6aLP8nbGBbj57woePCwsHXg56Kl4ivgCi2dUkQMtndDv69c8qe8wV7TIz08BlDN
	w8Mg53x/rGLbtJ0X/N2Rghu+59oiJ6y89Wsxx2SVG3SA4KYQcLOA5nhtae1UN9KNtgP3K9sbzCf
	MZZBfLbBgEUyyFFFTLy15CsdgPxxT5Ln74sxMBogeKKyf5/2nTDZwP75qRU+HhKyiund5pIXyOA
	hJbo20g7t7Vu6BgYvegB7kgHNXm8IddVGhjkf18IOCCZvTAxFUEBs6N3vRfgSH4wzyGJQuFyVzB
	VswJWgjCWkvMTB+2tovGxfhEHEFeyrfjM0D2RML7Ag8eh4yQyXLeieBrUMi8d9dZo5eeI0dr
X-Received: by 2002:a05:6870:8713:b0:409:68f6:569b with SMTP id
 586e51a60fabf-41528f777a1mr1841216fac.12.1771459917948; Wed, 18 Feb 2026
 16:11:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yuxuan Liao <homins2307@gmail.com>
Date: Wed, 18 Feb 2026 19:11:47 -0500
X-Gm-Features: AaiRm53SOBDbI1yjGE7TYRjwZRSjatpKX8ot-mNXyhRfTiMnIsNpyCri_DThu6w
Message-ID: <CAN3BLoV20U7HBXpSM=9aze-Pj_1y_Um6d1LodSeyPXDAp=sPPQ@mail.gmail.com>
Subject: [BUG REPORT] Git Bash for Windows Freezes When Receiving User Input
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Git Community,

I encountered a Git Bash problem where it freezes when receiving user
input. Below is the detailed bug report. Thank you so much for your
time reading this.


Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
1. Right click in a directory (e.g. "D:\") and select "Git Bash here"
to boot the git bash installation.
2. Switch my keyboard (Chinese(Simplified) Keyboard included in
Window's Chinese language package) to English mode by pressing Ctrl +
Space.
3. type english letters (e.g."git") in git bash. The program freezes.
It does not display the typed in letters. It cannot be shut down by
clicking the "X" at the top right of the git bash window. It cannot be
shut down by Task Manager as well.

What did you expect to happen? (Expected behavior)
Git Bash responds to my keyboard and displays what I type.

What happened instead? (Actual behavior)
Git Bash freezes. Does not show what I type (e.g. "git"). It cannot be
shut down by clicking the "X" at the top right of the git bash window.
It cannot be shut down by Task Manager as well.

What's different between what you expected and what actually happened?
Expected to show what the user types in. Actually user input freezes
the program.

Anything else you want to add:
1. I can reproduce this problem on multiple machines.
2. The problem also occur if launched from Start Menu.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.53.0.windows.1
cpu: x86_64
built from commit: a5512bdee37ed7142c233d21e2d347ffc4860ff3
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
rust: disabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.18.0
OpenSSL: OpenSSL 3.5.5 27 Jan 2026
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26200
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
