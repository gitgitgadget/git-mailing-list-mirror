Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E722D4E9
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767437271; cv=none; b=bgxy/CVFFiC7/PLkk7rMXdbLgBmxmYX+CgNHiOTxmwLFTnLIhR0/hRVN1HusobzUH6PGFS8AuuKFZ6wnudISa2leHY82+GLn3cKGlv75BsdLdpr3JvxxBPg4VDOKxvoRrinkOOLKdj8RtKhh2//94l7A6eloxhXpJnTCKIwY2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767437271; c=relaxed/simple;
	bh=GEVlwcrUGJX6esyt3GT3uuJxMSQGuPCkfe7s/oJF2Gc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ijt7K+3ritF+3vuG8QD4sPnzQ4SDtqDRLKkNkKtGAKOIiGBKHSzvtxvYkqDyZ4s4VHwfUA+xdJ2kOTCTRJnt3d8i9YbYFS0ZsxTb/KxSdL2XM8X8C8Wj4rA7SlDetftSd4s8u9beaHq7WlU23Ph538Jgp1hJgw8ib0PgN4RDM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=letterty.com; spf=pass smtp.mailfrom=letterty.com; dkim=pass (2048-bit key) header.d=letterty.com header.i=@letterty.com header.b=kz0sMQdu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=letterty.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=letterty.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=letterty.com header.i=@letterty.com header.b="kz0sMQdu"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a2f2e5445so164893806d6.1
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 02:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=letterty.com; s=google; t=1767437268; x=1768042068; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zwJLJRWImEaGX8kIPesE0yva/f+qt2Gs55sOPEAtjdU=;
        b=kz0sMQduXLIiDTicphiIYQqjElbS1pMCWPyvBKcTzI58w9E4DR1b4bdsj124aspDrK
         +EgCmhnT7XkPjkoBeQ2cGVNkiIgXvellW4L+5DeOnMZqTBTBY6AwP5p1okx/zbdXhS/4
         Ihr7Ho2KnV5X/o0TfuqsxYB54ZoQk946jZHRtoxEOAs2lnF/321jpmkXg3IE6XepLBYY
         cbFo4TccnYqpmy+gedI+sD9NrxwicpjwdQEeK6CLk3VAlJvovNeqFwHxVuBGNdzK5nzG
         DfJJw0+53/TllwGCuELmZZH8YorMoyelbiaI/xY5cqJ6OvBEs6UkFO5kOXvX4mNuPixn
         h+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767437268; x=1768042068;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwJLJRWImEaGX8kIPesE0yva/f+qt2Gs55sOPEAtjdU=;
        b=b/WfS+WPosnI8cZbDNp73xfHiFAdoFsG5SWl75mPiNPKkxAB4VlPzS5FkqO90MXt1g
         SQst2t6udVgxX6aftEr/+PuLT2jCOwBOg/3C6yPcTlZraGB6MJpkT+0tHGw+4wcEzgEH
         bGdaKxbC4/f+W7gQrSUmLhBlk+IeCzV6UAzLJ5L47TQKXknGUTeH4hP5QaXuD2ba63ar
         42lqfg7Ca8jhAf2FIsbO6RYE/VBXJL05ldQuV6FY33jTAutoDCcQxSH7O7+GPrreWdXq
         hbY0jaLGAfbXBV0Xqn0yKMAO9ydWe06KtpMmJEkyavsz0Q2ZrHfrPTEUGYLdD/jpLaVR
         bnjA==
X-Gm-Message-State: AOJu0Yzltq24lGZyxAe0CKt2avvpocuX50R6qBnrF3D56JewczE27OID
	1cywykm967sd5As0xXUtRWFz4ejLQ1WEh/STFTQudgp+UArIvZPHHxqG3kTtQb+DccpMQg7qPPl
	/d/z2G4oE1Ipm4SPz/PswIXTwsJKrgHJ+dUnshmZk5jVQZ+45OE68m6Y=
X-Gm-Gg: AY/fxX7x4b9ie76Y6oGpJPI/WNKKSAb1YxMbz2CS6y/Y6s2qTh2xeqk/rFTLfmelCmh
	rCeFxRAa5Fn+HcwMSlgV49nkZsxyOEeVnuYWf75YG6CltfWecM6RN9qef25a1ngFNJIffN/eysm
	NljSEp4ai/p7jOb1cJUBoq5myJv3MuR/Z10TLD7OEnWhgRe284JTDQ+n0MtfN/exrfKDVqR3G3z
	te/GMONlp2xghe2VvSme2wcZsy56+yZDJVOSfs6brBGJ7OcrZfSxEXZztgWzU6v5UJZ+b8=
X-Google-Smtp-Source: AGHT+IEYjfpyuTzKfMRAqMSWxGv5Gm1OrXT2rOmfIE61C+4Z/g+L3iTq20QTEWuBKzsUmcQQaqjwG1U5AZy1DQHjkAw=
X-Received: by 2002:a05:6214:401b:b0:87c:2c0d:309e with SMTP id
 6a1803df08f44-88d8369e76emr852248566d6.37.1767437267592; Sat, 03 Jan 2026
 02:47:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Artur Pyrogovskyi <arp@letterty.com>
Date: Sat, 3 Jan 2026 02:47:36 -0800
X-Gm-Features: AQt7F2rtmKBZ__m6S2r0gg9urfzuE3YRywMHDLYVXuebTkSdpjA3XrtMRFkY7DM
Message-ID: <CALiS03_X4kA47-bimcovqAsTDXOM-KbKUAApM5xHdYzk9kqkbQ@mail.gmail.com>
Subject: bug report: git status -z doesn't respect status.relativePaths=true
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

According to the man page of git-status: "-z Terminate entries with
NUL, instead of LF."

However, it ignores status.relativePaths=true and always shows absolute paths.

Repro steps:
$ mkdir test-repo && cd test-repo && git init .
$ mkdir subdir && touch subdir/test-file.txt && cd subdir && git add
test-file.txt
$ git -c status.relativePaths=true status --porcelain=2
1 A. N... 000000 100644 100644
0000000000000000000000000000000000000000
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 test-file.txt
$ git -c status.relativePaths=true status --porcelain=2 -z
1 A. N... 000000 100644 100644
0000000000000000000000000000000000000000
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 subdir/test-file.txt%

--porcelain=2 is for convenience here; the bug is present with or without it.

Here's the full bug report:

What did you do before the bug happened? (Steps to reproduce your issue)

$ git -c status.relativePaths=true status -z

What did you expect to happen? (Expected behavior)

I expect this to show relative paths, just as this shows relative paths:

$ git -c status.relativePaths=true status

What happened instead? (Actual behavior)

It shows absolute paths, not just terminating entries with NUL as manpage says.

What's different between what you expected and what actually happened?

I expect that when I use -z option with status,
the only thing that changes is the line separator.

However, for some reason, -z also enforces absolute paths
and ignores status.relativePaths option.

[System Info]
git version:
git version 2.52.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Darwin 24.6.0 Darwin Kernel Version 24.6.0: Wed Nov  5 21:33:58
PST 2025; root:xnu-11417.140.69.705.2~1/RELEASE_ARM64_T6000 arm64
compiler info: clang: 17.0.0 (clang-1700.4.4.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh

Artur
