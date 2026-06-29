Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E93B42D2
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769026; cv=pass; b=OHjCmNvR2e+DSE6mPqig2EzVs31sobvxtAK9mBa3CWTqnxzYmOztmzMlE/1KCT2E9iza+/coOdbskY2FQfMwo2Bw84riuFou4NDhOluIxeteKYkoPhsS96016lbSqvB+ZrgEOOD5oV0nNW9zAhvW8jLem1uBOz2VKzWlnTa0qTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769026; c=relaxed/simple;
	bh=JcDexbWjmHEr2wlwEtiUCVfRnLZdPCZDGLdigM8LGw0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=h+UgoiXzIydRICLrMOG6ZeGSKleaL6rPNe2+14+UaPQCKXi3VFyHDnIRLkamgu5Fmpj9CFZcCK2k/JQXEIkj0h8bXkWPaPoT8HuDfHsGXOBLrTn5xf/f4ZURUaQ85vFC/b4m2Td4EGd6HklpT21uQ7Vcc2gChk9ctD5GvimMMyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=fxbcUV2n; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="fxbcUV2n"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51bfb91795eso10629681cf.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 14:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782769024; cv=none;
        d=google.com; s=arc-20260327;
        b=Xif0efpZ4di5KnCF/yobD9gH3Q24qrq/PaowrfRi9o21IzrvnpetGbYSpKSN5+r3Gs
         K2c4ojdqUk6gpq5/6ARF7ktz/gCo9o3ZjBTbi7hE2Nftm72L6CQyXV43FYEkXjlhS9Jp
         AX64drdcFMCPsFTamY9Eoq8VsiF8Hs0oxiuwCYe0c55ywsermNUvtGQczbuO/pb5BZnh
         eG4lDWiv8hyJuDGmxK+GgES/JguHzGEdqe+xK7NWpcniSqDXBTFQnob0XbiV1WfLSzLy
         KykPu21Tl6SmHYo0uwPgXSqbNEW8PBmVxppr9bWtvBjwEP+vdjSaZDC7H7CeQFs8o+sG
         +MxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=JcDexbWjmHEr2wlwEtiUCVfRnLZdPCZDGLdigM8LGw0=;
        fh=6tZ82tJpiAuIHaEM/1xuTc+njHXLOUb6k/YwAlh3SrI=;
        b=s51jna/qDDVcHIIyxZMRftrLVw7DYEut3rsca4JGEeLvwmKbi9BMWFoBEHAUYfwmUQ
         hBa9ebr5eSFdEw+D4OLzU+T2TukZ0jMoHWaBgfT2rvGJKrkNaMyaA5rIR1iOXUE56LON
         p3NE6cMmpUI03gFnWcjMKPjEaZXA7w3a952BiGtMxIztlwckY1P6UwWlp4T3JGx/i3ng
         ZsCSTNfv8Oi0b/c3hgeawmIil5WXsaiTmgwppQSRd5Bv16raIO2x5gFVA8wdoTM7QcPU
         qqB9iMh9ye2N8g6H6ujmPsVS4A9gZ/ZjEdRoqHbJql0F8KGJBFGB1qnGWlayAgjgD2ZC
         T80Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782769024; x=1783373824; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JcDexbWjmHEr2wlwEtiUCVfRnLZdPCZDGLdigM8LGw0=;
        b=fxbcUV2nN4zD2iahXJwnFgkXykS64PEa395UZCGidFuhixrjLbtdOiBSikLE1dkYJQ
         cdiYczeCPilPJL/FbCzwjW+tMWDsL798y+lCR8y7qWbUyvDeIs+PsIxHc3JhLAfOzFSG
         jK8SFGcsmZXVIXvIG9p2WBQLWi9huK+DiLlLfYe+6Lb0mPg6T505ZA+kxVWJIRPktiVm
         HGQpXmyB2QHA0CEddcNAR3ykZJncp9g0eS0fpqrSiJfAnFY0ayczJFjFDcdPjqfRfwKn
         4Ns4kAo6zEA52K9Krl7c3JNxXjIGMf7dHvQTHGCbR/8xx12EUTRW8O5DJgop+XPDIGv5
         93Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782769024; x=1783373824;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcDexbWjmHEr2wlwEtiUCVfRnLZdPCZDGLdigM8LGw0=;
        b=oI/2PqD4pvLJ0rnoBHjEP+LcE7YCV8TbiqI7TitE3vNeCEGybjAlKSkDiwlzIZcNGA
         L0dVXPEHfvT5OJwRMra3vyIeOmnSjLt6ZmtQopm+qJHs2Rjz22feeGkWEab+7ke58dga
         8au5m3ySwYvqoIm42nHujjslVhh7wUPoo/TqLXKg21Jc1yHdOFinKBAc8viafhcW5ymk
         qKJ/sqi6WVCFnMIByCu7oYRRbGkbGkvOKBqGJ3bGkMollTkHIKgcZXgNCzpTOvdDR7OT
         nqnEF4KeGhvcDzzGdxLzizMTU9hsBni4+MTGxM31kH95ksKjhZwOsVR6/VTvc6nfqQf/
         tNyA==
X-Gm-Message-State: AOJu0Yysx/Ud4OsZvZ4ENUv1tPw2+fMoM/feivL49PMztvr6ujyDqFEr
	a/BhW6/NNMUXzh2g6ocIyTYaXZu5WWuITHSeJlDUw1rpTEXzGFlsv1jwJxQ/ZEOFedPcaJ05EJ0
	6ypbs6yYw+5VKMerz8le8lU2R5bRh0S9PqmGWuBxJ6Fv17K2wzTjFZJe+tg==
X-Gm-Gg: AfdE7cn/VlWV5rL0edDYINFs5LM94A2Z0bdvSYL/9m/frB2mKkhzo2ozDvGasyTEaVR
	Kx7njU5tVhsfiqYjlSVFWli+ejomYn54rBcIFsLWM0P4RVG/ArS4pfZCxtcvJbnewv/BF06z95E
	lVQBF377eeG/yF2BGXThYIBb3lHcXVViSyGELTXL00ZIGYhH3/24QIq3yYKfJfKbRk96ReJgzQi
	SKDyFmnhflAMxN4O0Mn1hxkq+0jmB0Ku0emjG6d2tykjHsmIhZeotkBGFq9QRgvVFOVdjzUhE8y
	zm4RZMhp1uILKOdOKmlZz457z3Dq6T2xJEXrdwqeAdGKN0FVCEokXlOwFRP+Vj/h3dT4+k7Esw9
	D17Mhq1pFNgAqMPvw
X-Received: by 2002:a05:622a:50f:b0:51b:fe47:b3a4 with SMTP id
 d75a77b69052e-51c1081f88bmr15344451cf.46.1782769024037; Mon, 29 Jun 2026
 14:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Taylor Blau <me@ttaylorr.com>
Date: Mon, 29 Jun 2026 16:36:53 -0500
X-Gm-Features: AVVi8CeESUnrom_HqceY7ghfUXWVOTHxp3gzFmK1aPPjJCDajS34SYbSRvcjrq4
Message-ID: <CABvF+3b-C8Py0PjMqv1jub=eS2xpyNhLnarrENb9XkhumS2jfA@mail.gmail.com>
Subject: [ANNOUNCE] Git Merge 2026 CFP deadline extended
To: Git Mailing List <git@vger.kernel.org>
Cc: Scott Chacon <schacon@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

[GMail web client, please excuse any formatting errors.]

Hi,

In [1], the dates and deadlines for Git Merge 2026 were announced, and
the CFP deadline was set for June 30, 2026.

**The deadline has been extended to July 14, 2026 at 11:59 PM (UTC-7).**

The primary reason for extending the deadline is to collect more
submissions from folks who have not yet submitted a talk, but indicated
that they plan on doing so. (A number of folks I'm thinking of are
currently out of office, and I want to make sure that they have a chance
to submit their talk proposals.)

If you have any questions about the talk submission process, or about
Git Merge in general, please feel free to reach out to me on- or
off-list. See you at Git Merge!

Thanks,
Taylor

[1]: https://lore.kernel.org/git/agJVZhTbA%2FhFUKG%2F@nand.local/
