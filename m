Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC93284B31
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295721; cv=none; b=T4C6/CjHB4NY2Xpehg7g3cu65d9LG4iK+orBpoMZlMKs95iwtFjlo0x9DtHTiW0FCVcKkIRtxXA5PrXO1sIIdC9hdgEnhgtPufv+UUDjPOsH++bpI8A4Fn9aW+ZrdYM4IC9yQ50ZgQmEVj43ZlG5Xkh7E7c4i3trN8mLV9BB57Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295721; c=relaxed/simple;
	bh=vfj2Fx+09BSe5WB2VezzKcJ96e+419lV+yOqve/ZFrg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dnEIvt5bHRjYKTrlaAyZ0gtTuI9DYlZHUTwWjDXCabSXJNuEG881D5k/uD72f4Ic587cdek8IyR6Lz6Fez2uzEcjsVWf+z/SnmuP/+h2cWV5cEinbjIfIZORGainBksFDPcv6Wscil7zXbcEiaywOLfDEsiz+6gyCG1R/70fdvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY6hy1rW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY6hy1rW"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so1449992a12.3
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744295718; x=1744900518; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbtMx/6n0g9/C878FnnEvN0vnD+xEJl0DWCZDGk+D2Y=;
        b=BY6hy1rW4PT8ePCFCdHT0ywg1ISETgP1dZEOol3MMwiWR3KGjePxoZSz8iQWyszCuC
         4KluzwzovB/WcdgD3fI+8YFQqwZ+a5gFrlbHM7cO0aLQdHkt19A5uKJK597dtFILputq
         oXsS6hfZQ9/4dFDCYjzXmNsQQ5DYZzQ1M7u7FtEuSrunPa5FPH5Ti0VGpYlGB7GFR57b
         EUczCo2GouwoM2H/BiDVdESQW567rXvmDGRADYUUenrC//CiYU9c6Y5VQRLNrBw8EGB+
         1aJEaJJvtzS1I5xOvgaUAysNq7T7VLdyKf6+X1RssJd06j4QCNcpBWLFNVenhnCbM2WF
         DCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744295718; x=1744900518;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EbtMx/6n0g9/C878FnnEvN0vnD+xEJl0DWCZDGk+D2Y=;
        b=THWFI0DX18nb0/xTrAIYuXer2/X+41JCEMyO1GbM1oEDIpkry0TJjxCOMFFL7r13WM
         r6G5pA5kber5F1K0WLG1m8EevK8DzXqPTDHsx30FSbM92+JfbA+y72KvIxfOC7k1ai3J
         Y+D3gN8su9RRnpD2o2AHTgm3GjCYekOjYtvozCW2rJ+arQNCaWYmgVWfTW0XJHtlMIdU
         U4Oxw7mgiTv1tjItt1bAbkK1Akts8jdeB1S0+OfUXMQZJE1Syt5Cm0pXWgqBGzawTfof
         VvzPW37JE+dzHBs57xtdahElkLZnWj2+dgnPEn58jlB+p/yk8dDgIDfCrXPnuSOvp3Il
         Z/og==
X-Gm-Message-State: AOJu0YyyqEkKDs68o3opChHm6Coi1miMP0rAzEFnpD0fKgz2avIAgXyR
	BQTZSd0ZopCdu8eykY00Svghwz0FELXtNX0KJtiKF3rkSckaaIABvRkxLQ==
X-Gm-Gg: ASbGncvOoCMq8ZfOut7BZ9/0hzksLWw1Z5lWa1Ibc1sUrowCMUWhERdZphafv5c1Hop
	a8iZgWtrrBggNrS1vPtIb1HKf3hDu2TcnzKWWWS0CgWozycvzDk5c1/tQfA/+LA+R3aHHI2+oQG
	3aHB6WZLKqYXvbctfIBjoz3AN+v+pUiS2xoIyEpRdS3Pz0UaPpDNauGhwdRPct69BX2RShVyaT7
	arSnd++kEY21e7xuOkLI8nDCKD76qOOdw92vYuEMph8LsuOFWr95DAtw3eNjfhOGSq5jUW9bn7d
	zujNGFGjU7Dt6GNsiwMLMATJUuOjUwQiAVOHvZ4FaXPlAV1s0YKb702Eg8L618ZSv8say2HqyOc
	gvlMtWiB12Nf/AtpIVsYifU6Lh55QqEBlcKc6O4KdcgHay0s6zvuC6tvz7w3cG3+aqKyOL3q6x5
	AHeAyz
X-Google-Smtp-Source: AGHT+IEbtFNcbdZwiMPha1J//oduc2c2P/eKw0zjA+DeYjEyGZdmPzSkonOL0RJj+yRUOoXtNBwthg==
X-Received: by 2002:a05:6402:2385:b0:5f3:4197:9538 with SMTP id 4fb4d7f45d1cf-5f3419795bemr371309a12.13.1744295718013;
        Thu, 10 Apr 2025 07:35:18 -0700 (PDT)
Received: from ?IPV6:2a02:a466:6765:0:d250:99ff:fe32:d95d? (2a02-a466-6765-0-d250-99ff-fe32-d95d.fixed6.kpn.net. [2a02:a466:6765:0:d250:99ff:fe32:d95d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f2fbc2d575sm2479932a12.46.2025.04.10.07.35.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 07:35:17 -0700 (PDT)
Message-ID: <76edd34d-3fd1-437e-b8d3-7e64e99644a2@gmail.com>
Date: Thu, 10 Apr 2025 16:35:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: nl, en-US
To: git@vger.kernel.org
From: Ludo Pulles <ludo.pulles@gmail.com>
Subject: Bug: being stuck in rebase mode when accidently typing `git am`
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. Run `git init` in an empty directory, and commit once.
2. Run `git am` and press Ctrl-C.
3. Run `git status`. It will say: 'You are currently rebasing. (all 
conflicts fixed: run "git rebase --continue")'.
4. Run `git rebase --continue`

What did you expect to happen? (Expected behavior)
I expected to go out of the rebase mode such that `git status` would 
say: "nothing to commit, working tree clean"

What happened instead? (Actual behavior)
It outputs: "warning: could not read '.git/rebase-apply/head-name': File 
does not exist."
Moreover, you are in rebase mode forever, and you cannot escape from it!

What's different between what you expected and what actually happened?
Instead of going out of rebase mode (expected), you are still in rebase 
mode and you cannot escape it (actual).

Anything else you want to add:
`rmdir .git/rebase-apply` fixes the issue

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.49.0
cpu: x86_64
built from commit: 683c54c999c301c2cd6f715c411407c413b1d84e
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.12.1
OpenSSL: OpenSSL 3.4.1 11 Feb 2025
zlib: 1.3.1
uname: Linux 6.12.22-1-lts #1 SMP PREEMPT_DYNAMIC Tue, 08 Apr 2025 
06:20:12 +0000 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.41
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

