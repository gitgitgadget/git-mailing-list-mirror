Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F188F255F2D
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776747851; cv=pass; b=nbBmfVq4IJCqUK9BjNEygqrFRl+zKLTnL4HtxB8D+UVAa0O8+yYoE8UvMXCcZvE7DuVxMdmsi4PoUuFaddH3gnq8mKGgBAsIPxcjmCm7/M1yAuH8/Ld3oCk4rughsWX8qqplPT8o3wjrq5ZIg/6XCwiGkpMctDmoOYMzesexGu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776747851; c=relaxed/simple;
	bh=2biN2FuGI3PbUTYmsGznjN36mWhspzJx9J4wDAWPnIE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Sa9W0cpi6M2oFCaetxLP9xC7WBfOwuDS4eVejJiecY4t4ug314jCJRmbdyVpp1rQexaKkAqJ5OsRVGqXKTvRCtMxtK9zYs/tn8ARggYfnLJouY625jfbqlBcr94meIPbFvxjT/VPRRQuKhJMlVxPmWo4tmsPQPYF76SFvoOMAgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU8xZIKu; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU8xZIKu"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a2b636b944so4649987e87.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 22:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776747848; cv=none;
        d=google.com; s=arc-20240605;
        b=CKSNjLCBT7gljtws2sLzzBrUpGxbatyKwuVoH4TF1aYh6arDEush3c6X7kXmov8/s+
         kgBEdU6hp/4Mg/4kDdSjGuiSAhZPUdopPx9FFzKx17axqAYDQCihsXRqnDb/FaYaaDPv
         Cch+Mn8ZJDC/w80B/B7MzT+Klf8RjMJN9s094j+L19NxG3jXVWBQqL1nhcHVoHaDDsFM
         flMGbrJrZZE6s7eiZTpHBxGxS5joJsrm0FqVvzy1jzFvC4jydCTK8ZZZeLivHwr7CI7D
         9KtmfHaMTZfFMVGyOG46YS/MZ26KG6AAdEVHYIgmpb/25sUrltjoC5gWWYNXP2g26M6b
         6pCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=EZRAJ54qC+4e+i2IoAmP3P9712H4lUWUwml4Q53bHe4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=A8UrC739w5KsWmBg+VzNR6Hbj+NCgDbJZs/T9XKIvD2BZhW2azTMFRYz1g8tJhzBZe
         VmupKd38zt1xu7WNP1n09TPnt9CeWDYX5+vnXXrq13K9VOHGP7whyJ10xxjeyMhgVxFG
         Sa0Ws2qlYdEb48j18lwSDO1FjI5S0Sth08YYBMoGakN/CeS/CQu+W+9ENOWv2bHR0T7T
         xGmqXNO2IhntuDOzAYN66TSjeQQslkuptoIegasD48agh+MYxxP3bLn6b0MVGOeFg1Hb
         d9U4Ig0x9mjTtLhq+2Hyq+Tizc3beNj6SeC4ekaQxreY6pYbfbEhZ9mjAPYNN3R9NGH8
         Hrqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776747848; x=1777352648; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EZRAJ54qC+4e+i2IoAmP3P9712H4lUWUwml4Q53bHe4=;
        b=UU8xZIKuuDZp++gxYkizRb+Zm36CBKMKI2tQwsnQZ5qLPj83/E6lqKBRjC7SvGNzmR
         /xC3VrHoZ0JhvKLDSiL+MvzK5DQNg3MI83IK0bbm1qqI55ORqMy6ihkwZB2qctBT77zd
         s21S2n7xDDVSDVlrCWZcnEogLg2E87oBP4KWHXBw6U1ATH7oswLyFqhScDVK1ScDv3kc
         boTO6fl6cBENsRM92cnVupg1TJaqPkfoXoyWRvRkbkzcPvx95BJwmiRtHBinN2cGBX8c
         S7BSANwu7P3xCEb5uwYjAwQO2acugedsm2Ua7HGiqFTnK5xw7yt6IlMAgHK0ZPyB6yBl
         sFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776747848; x=1777352648;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZRAJ54qC+4e+i2IoAmP3P9712H4lUWUwml4Q53bHe4=;
        b=jlQf5zesWT4hyfpmgiAB/eOhOcWk0D5w52JGRLza6v0xDK3LaDyOh18W7GIWGwOLAt
         c5PbJ68d7SED27HD1F6cy/yVsoL1HOhFqAyru9ge1Bbalh2mWzt4F3P8BDk9czPYlwr4
         kSKAcW5FDCal06CSekcwmoEpReiuzjDIXx38dXBAegu36LnQXSJ2rpObO0BF/Ke1TyZ/
         t15DlMs2p9WDn2+M/S1aTEyPLTMgPnzxSJgEgp5Pm1hodtFODtS+rtfE+rWK5gaDzSyI
         17S2Osi6IpVpmcUl2RYKYBxHH03M2CpHtmuD/TKuMCTJlA0mMP5jSXPk4u6hmp97Gzws
         3n4g==
X-Gm-Message-State: AOJu0YxyNbpcqjbCRgo4jnR919ZJDBxRdj/F+ZlCT/ZZJSnfIu2audR/
	j6lk9X/IH50jdc94WDGsVlwAUjYgYWN0Urf8p2U+0ZWH8U38uAnmemW+gkIFlVfGPKPdBwXJslK
	Rn5zPSZ8GxToiLcz3zqYk9+4lMfYu56ngYBXY
X-Gm-Gg: AeBDiesGFWKmXpgZc86yH8sdqYL+Hv/PQOAQ1Jfnr2J+XseSL9msqoImAXsyPa17XKr
	gMbO0CEek2BTYqslY+KYqFCrK0NZ3PdBxSTEYx0Byy+THFhI9sV1fQGk0gor0dhyKOMjZEe4rbC
	52EdHNhErF7cniWODj9bFtVnlqXLwIgZliQ4iz3/c1zCGX3HZzmjpKVip+WJ8fp5nMX5LJ9C2n5
	o1NBDBB0tA3bLGh3dfo13GVHSKMt0kdIPFihZWUkc5n6th97j1fQAJ8586CJmaXyUxHElsJi4al
	m2+iV4mZ9XjwI2cBxA==
X-Received: by 2002:a05:6512:3e18:b0:5a2:a525:511e with SMTP id
 2adb3069b0e04-5a4172ba628mr5405612e87.3.1776747847520; Mon, 20 Apr 2026
 22:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brandon Chinn <brandonchinn178@gmail.com>
Date: Mon, 20 Apr 2026 22:03:56 -0700
X-Gm-Features: AQROBzC4cCTFyVlGHViTjgGZlR2ygmZcAuly1Eq7Hfmcz7HCm254nmmgseC6ays
Message-ID: <CAGANf=dkRgFp+bEkB5f8QBeiR3m+3WE8sKqT9vKstkGHqbxA3A@mail.gmail.com>
Subject: git grep bug with --column and --only-matching
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm encountering a bug when using `git grep` with both `--column` and
`--only-matching`, is this a known limitation?

Repro:

```
$ echo 'x   x   x' > repro.txt

$ grep -bo x repro.txt
0:x
4:x
8:x

$ git grep --no-index -o -n --column x repro.txt
repro.txt:1:  1:x
repro.txt:1:  2:x
repro.txt:1:  6:x
```

[System Info]
git version:
git version 2.51.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Darwin 25.3.0 Darwin Kernel Version 25.3.0: Wed Jan 28 20:56:34
PST 2026; root:xnu-12377.91.3~2/RELEASE_ARM64_T8112 arm64
compiler info: clang: 17.0.0 (clang-1700.0.13.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh
