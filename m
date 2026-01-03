Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC551B7F4
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767438435; cv=none; b=lPJiGR5NcSVj+P3hbFNblC3x/E51F3cYD3bLAKKmzfspqT8sFJkgDGQjgByfAo5yIfSzaLfh/x/IF1SyBk9nkLnCgoiOpXUTIdeObFOZAskGw26c5AMH15KRbFLZuTEs/i2vp/oBCxHD5J2/PvcQ7+clOSRPwwgMeatgV5UqHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767438435; c=relaxed/simple;
	bh=sQAXGZrbh9r9BLuIT9rbSST4EVpGt8pEuU1re+aLHMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNWH+d9tCUzVFH+jCLS0IQTQQMmPBKoogAkMsDLqwM/6+t0hL3w2X5WqfQMSDXzylhpD62ZUlmcmy+jWQ3n+jAlzuk9qW1n8P2oQ2Vndpy8xSzrWCr97IqzNKRwasdmI9IPkWgNX8gn2yVgtToSuyOafv0HW/lna4MKEU311EvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZny0iFs; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZny0iFs"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fc7893c93so91167097b3.2
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 03:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767438432; x=1768043232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoTS7bpaIc+TVEiRpvPAcMoCub6T64PwNbO4ng7D5L0=;
        b=fZny0iFswr8/URHd0WILfOBmaqdKeeZdtvW9/f/XnaHfQuAqtfJf/i1IWxbD6/M6ES
         CeOvbHqhQiuXxuuqlh+9XgJ4s9DOO17MN4xgQlxA0O9EzIyawKs+yIWEM2T4lYonCdH7
         qLt7d+yPwjO5qbSqsrlfuxV3AiZC/8qVl9kVyjczc9VWgb1uQ0O/YXGyYiIl9z3QloFT
         ZCuarHSZVeLD3J4YtYGt8wgClHJYxp/lk5LihyJ/Ewkuy1YWOlPewmtR9+AZmxEiBJb7
         QC6GbkuHUxtrP5mochdmhmCtfkRNF3q2fWmf8rQks8feAq/moIZxYVhMonEsKOrKVsDp
         L2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767438432; x=1768043232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uoTS7bpaIc+TVEiRpvPAcMoCub6T64PwNbO4ng7D5L0=;
        b=ajuB9yK4QRo6FoaOvf1IokhfG7NFbXeqSEGMQeVZB9y9WwWgb8MUWCBK21xA4jllgA
         tomCIiyLwMivx5msv7T27yk05fZW7pL3y/8bxZ9mIgLzeZ9OkWJn8KfLzpOGt8z+qlUE
         XLvu3jzsTcFT6aUR/JrZp0xAb7hHQJnib900gB63O/RgEh4vcIz/2U8nKiVBi4+AyzzF
         nFRVHc3P4RperK7knYrDkCuMXTARDBGSGmdMT85/LRlewLREdmTc9ABzW62ZWAZG/pyo
         ejpFgjZDXH5fKxSN4F/Fv/1JplMnzYB3wtan+cM+mdvJDdHRwFztR5czpoAMHCnBrSis
         wVyA==
X-Gm-Message-State: AOJu0YxscBn0sH/vno2/W3XB2rG1tZY+URYEZAPp+4wTi5s2N0epQTzT
	T6q4N7C8vu4cdY7hh48hlQol0bNJHdj5c9Dn9RLLemFZHG979+41z6D/bZZvPeMxrt3QhXjnik+
	WB6lj+69SFDOYIx3ol77CsWEVO8B7KNMJkuwDzGXc6w==
X-Gm-Gg: AY/fxX4YNDZF60obxyxJx1oCOmJMZHJG6f/axluAxcvdVeG+SASTEC+66qKLYHl6ASX
	jk3+8I7bF+T3GbrcZzUXxtbFxYDPShi3gejE8quKVEtZZtrMQPOjqhnwUmrgls+SDwf/HNXoxUp
	0mBZhpp+dfGnjTXoindduZpz/6MytYlqLTENULNtC0rqAbwpLQlhR7eE3RzwNhhnd6wqToQ3JGV
	jE7fObBiSaN8How0dPJjYFcEmoPUcdgt8fs/qaBXdnVjzUS5HjY3ASYZGHO7P0+pBFHAn0=
X-Google-Smtp-Source: AGHT+IEeBkYD/PLbEmeSJiy68gNiRE+sRXzav8bNBW03pm3A/32riFS6HDZ5UwKMvZPdth6bqHnbWKNBC/oV3IUom2g=
X-Received: by 2002:a05:690c:7409:b0:787:e9bc:fad5 with SMTP id
 00721157ae682-78fb40294e1mr355368087b3.33.1767438431878; Sat, 03 Jan 2026
 03:07:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALiS03_X4kA47-bimcovqAsTDXOM-KbKUAApM5xHdYzk9kqkbQ@mail.gmail.com>
In-Reply-To: <CALiS03_X4kA47-bimcovqAsTDXOM-KbKUAApM5xHdYzk9kqkbQ@mail.gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Sat, 3 Jan 2026 16:37:00 +0530
X-Gm-Features: AQt7F2qOInEC80YIP9AU0eQ3grgzzSOz1W33508UJc7x41z7w6Di2PodSlnccfc
Message-ID: <CALE2CrSwMoAd6CAYHsryfqWsfPYiYQ1jns_5HVHk0Ebu9sk-Bg@mail.gmail.com>
Subject: Re: bug report: git status -z doesn't respect status.relativePaths=true
To: Artur Pyrogovskyi <arp@letterty.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Artur,

Thanks for the report. I can reproduce this on my end.

The issue shows up when running `git status` from a subdirectory rather tha=
n
the repository root. With `status.relativePaths=3Dtrue`:

From inside `subdir/`:

    $ git -c status.relativePaths=3Dtrue status --porcelain=3D2
    ... test-file.txt

but with `-z`:

    $ git -c status.relativePaths=3Dtrue status --porcelain=3D2 -z
    ... subdir/test-file.txt

So `-z` appears to ignore `status.relativePaths` and forces paths relative
to the repo root, even though the documentation suggests it should only
affect record termination.

Tested with git 2.52.0 on Linux/WSL.

Thanks,
Pushkar

On Sat, Jan 3, 2026 at 4:17=E2=80=AFPM Artur Pyrogovskyi <arp@letterty.com>=
 wrote:
>
> According to the man page of git-status: "-z Terminate entries with
> NUL, instead of LF."
>
> However, it ignores status.relativePaths=3Dtrue and always shows absolute=
 paths.
>
> Repro steps:
> $ mkdir test-repo && cd test-repo && git init .
> $ mkdir subdir && touch subdir/test-file.txt && cd subdir && git add
> test-file.txt
> $ git -c status.relativePaths=3Dtrue status --porcelain=3D2
> 1 A. N... 000000 100644 100644
> 0000000000000000000000000000000000000000
> e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 test-file.txt
> $ git -c status.relativePaths=3Dtrue status --porcelain=3D2 -z
> 1 A. N... 000000 100644 100644
> 0000000000000000000000000000000000000000
> e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 subdir/test-file.txt%
>
> --porcelain=3D2 is for convenience here; the bug is present with or witho=
ut it.
>
> Here's the full bug report:
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> $ git -c status.relativePaths=3Dtrue status -z
>
> What did you expect to happen? (Expected behavior)
>
> I expect this to show relative paths, just as this shows relative paths:
>
> $ git -c status.relativePaths=3Dtrue status
>
> What happened instead? (Actual behavior)
>
> It shows absolute paths, not just terminating entries with NUL as manpage=
 says.
>
> What's different between what you expected and what actually happened?
>
> I expect that when I use -z option with status,
> the only thing that changes is the line separator.
>
> However, for some reason, -z also enforces absolute paths
> and ignores status.relativePaths option.
>
> [System Info]
> git version:
> git version 2.52.0
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> rust: disabled
> feature: fsmonitor--daemon
> libcurl: 8.7.1
> zlib: 1.2.12
> SHA-1: SHA1_DC
> SHA-256: SHA256_BLK
> default-ref-format: files
> default-hash: sha1
> uname: Darwin 24.6.0 Darwin Kernel Version 24.6.0: Wed Nov  5 21:33:58
> PST 2025; root:xnu-11417.140.69.705.2~1/RELEASE_ARM64_T6000 arm64
> compiler info: clang: 17.0.0 (clang-1700.4.4.1)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
> Artur
>
