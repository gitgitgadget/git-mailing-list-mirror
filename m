Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793253295;
	b=dXPNhku4q69PyjHOu2y/vqrYHrF2/AS1/QlmyRdpH3SaQeP8LGXz09p6CtvTe5Ll0EZb
	 XFjpqoOcQCdhYbIKuSFSXx3o2GsB3i+krOI3nse797LewNUJd82BMt5ygey2xqIu0ej0T
	 0OGNPOZTulqX9cGugdob7qRxOpSnoqIJvN+Q/wsx1QaI8F9+OGbeFIfQ3aazMUYFUH+G2
	 1CpzwOwWO8AKw4otmlAAmysrjuWq0v4oN5AU/2b/bHDrnE7tPTsF72s0bsGpoqnnjyO9r
	 7gyAO1/DJcNYkJLV/JPHli8C09rGWf2hq9lYeVMBB4aOq/RU5f2nbAtDRjNj+r2LFQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=42dlGTZpxSHdy/xfx/Zmq3djmE/GaICnX6NmoUbRf9s=;
	b=OjIEMuLgxkvYk5gistZ3H8LskQjZt86AhntT5aXqcdjCgr4Y3ZC8w5oc2VVa+yi8JD6Q
	 t0LRwPoSnTSchBqmZ8yNRGrCOb92jr2+TNSQgEaMwVgKyhi2uDbOM4eoCJia6DD85LJzg
	 J0hs3J9af7p0A8M5ZOmuFHu4ZuI4HmH1VlyAmANR5QfrgpWM3kKK0kbKInpV8HUpGqF0i
	 f5gHMfAqN/0DI3iDtCkcFvGuzQw5A3xwO5O2ilEIpHF1bdCR6ZniGrMsjakQ1RtOhECHl
	 qYjnYhrm61eBMHL47dpMs/WnvIjIO+aGMvBP/FxVwnq8RnIFgUdi5IQMd487yQOScLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C9SvFM4B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12267606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12267606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C9SvFM4B
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7cc81984fceso519058137.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 22:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793253294; cv=none;
        d=google.com; s=arc-20260327;
        b=Me6ZsTdoDB+QtU6UVIQ/txdPBxjwK5QWpxp0tMrpt6Xd77/I4F2QR7DP/LhCu0wGKP
         kHeHhsYa72Y5tK/2WLQOE6kozNHZCHj+1OeWTVKEiS4kGwLzHTpA5L95dZ3sV+lPECFP
         OOQ78yFynHAdsPyVJ6p0Y598RiLvoAlHCKiyYtxUE+AHrLPT6ZEoK8HwgDQnB7Zw5pKc
         dLsENoHc7Gmi2x4WbiJR0ILUxpvClDN5fPwAdrxleJlp74yeWpYWtB1rTgK4vbsBKeVk
         jgqHHhg6L5NXjnxOrr+onFUkcYU+NhHJHBb1yAv1w8/bokKr+zrIjF9iycKvckqAkSsV
         R8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=42dlGTZpxSHdy/xfx/Zmq3djmE/GaICnX6NmoUbRf9s=;
        fh=0v9AP56toc6RKP9VA5MNi9TKANdIaAISEDD/nEmSJSQ=;
        b=S2yPXQ4vBfs98a9IKX4/k2kFVKejgiF6nR3hWRKDL2yStoPqvNuryI8S1wAcuDHZc8
         MzEDo+bM4iPCwPyLgyMFfbRY6dW1qIkROJoNYFUv0mubT11K0XkuFQDDvG21sr0NxUPv
         hRCgkfM8XvjcvOkMlAcmflrmo825YZX86YvWxLvJe8xW+AGTC4fkTA+xZCSJUMOSCh4N
         2bxHsV0tE5wNRpOjn96NWJzYw1zobiLSU4tKYCXsdqezz/exXGZEV+8aHm8xEgLqGnjh
         iH2tcqSwZiF0MxbgxAUkvkuIxqdwnFAAPLDfxwLhrZQMYUbiikBq8HF/JrEN+oCZFH6I
         jkHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793253294; x=1793858094; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=42dlGTZpxSHdy/xfx/Zmq3djmE/GaICnX6NmoUbRf9s=;
        b=C9SvFM4BGuPGxXd98UgE/aYFhHXLZZGD+goEmPzLtkEfhoOqUUL/bTeiHuxIcMD2Ba
         xUN9AqUmHU6mr3l18Ba8wCwstDT7Cz30BnhiGLRKW9RfHiRZmDj+sXYqo0XAmoONxw2u
         93PYDMIysUYklgKq1zRLHJoVCH20680Hx84ibu9n7Vu+6MnP76wY2PvmmwN5+kHkaad2
         b5/K+HPi3xFSxllNIqSwJr6tQaaf8a1WNIrdib16E5N/AB1Ob3wQA0IqJFHL+wvN5zgL
         g33PslfwWbb+SNwRNJZJx3kotvs0Q2WPKxjV/nXTpdTPUv31V+wohDRmZ3rYAASSB/zV
         AK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793253294; x=1793858094;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=42dlGTZpxSHdy/xfx/Zmq3djmE/GaICnX6NmoUbRf9s=;
        b=AOXaYvdQqcLu/ODpthJ+BlpO0iNQWkSFP+/KRDBeXi+5PNfgjDnatA9OB/Tt38kA8C
         lSh7R5Xn9DRpN8IUD7YICmCoDij2wYeCz2bLBRPXCCkeSnLUK9Is+W4pqz+d+kDdA9qY
         ZfmPosgqtkacyfZ9ZR6Kh/t1qBWkIOnuAqe/D73wqoe/u/sgK0rmGHEwMBVlx1KjAJzx
         UKtBUYMdfFkPkpcjKSGjZlfBCH+bsHjwJ3abBFvXsw/z0fu1lDyYHOsB8YoRqdXw4wLv
         YtCCeBQbbNJwwduMkB5VtHxu7/qR2BjG/vGbOw0ML6PZLzOLiQ3vc6nc3PiQMdJA9n5W
         Db9A==
X-Forwarded-Encrypted: i=1; AKwUvBxSsSZOXZaFWb83wXh6Z2+ULBvRAIErLUzfpknN5SFt4yGn7B1HdXzUaDmsU8S+ExBkW8g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoZyRV+yeQuFFxutaCch06IToPAHEIssf4oS5MKUQFcrkcGSed
	7N7U3mG9vQwmHKahHbXvy1FLjyxRuuBLUXVIQM1I1tzeWaA+l26hk4O/0PqtfxOx1/X09dcVKkX
	m44NgwqwIRjTqtF4vKQypjRRhSe/gYQQ=
X-Gm-Gg: AYBFou36xgjUBHKB37mTJC6VqmPduz7JDnbQ7ZVUp4HWkZ8aFJIA1Q1Jqi6/sIlELwW
	wy5gV+6zdfxWT39zYp+m7G+lXQBmU93DfEjAAblpraHpOglgvQfRjvHESdVWKThWJkx34NRI2Ms
	ke8pXgFLdZrmmNUvTCeCPzLVIp7zoJC1KN+rAkjj5gyYDHYl4QBXEhHRkV31rTZ+W2qdH+51RU5
	SUbMe0WVvZo+6fxVio3kuAlFu2cep8T4GzSFE/QsrB2q4FNzwb0op2FQ3dRTFTEDV6zg4S1iDRr
	rHoOeyg3m8OCn+X9TPMJqs2QOGUzda/aPpSiw6ZrsVcEvAtkc3sl3cb0IwafyBtepz4py6cG6kM
	tB/52z+0xI3Ok21y4iwcddFSWrYAGXpYGD+jq80vxVh6x5YN1vLAefk1XAYaz6tRpBaRju1qBBm
	Cc8WFkDhSkIw1sUadcYGn2Ct0A
X-Received: by 2002:a05:6102:6883:b0:7cc:232b:f5a9 with SMTP id
 ada2fe7eead31-7d03a5d1946mr1498663137.24.1793253293881; Wed, 28 Oct 2026
 22:54:53 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2280.git.1793099688076.gitgitgadget@gmail.com> <xmqqv76nj7ys.fsf@gitster.g>
In-Reply-To: <xmqqv76nj7ys.fsf@gitster.g>
From: Shashank S <shashu8660@gmail.com>
Date: Thu, 29 Oct 2026 11:24:42 +0530
X-Gm-Features: AclHuK-yRdY_xDaCa1HQ0N_Y3Mte1ivYCxBXIKmRPYGRscADO6F_j6wJKAFz-tU
Message-ID: <CANHmUQRO1z1hL-L-To3_5n77P9V=GQAhN5cJ8BdDewP9sNqEYA@mail.gmail.com>
Subject: Re: [PATCH] test-chmtime: use parse_options() to parse command-line flags
To: Junio C Hamano <gitster@pobox.com>
Cc: Shashank S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 00:18, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Shashank S via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >
> >  t/helper/test-chmtime.c | 46 +++++++++++++++++++----------------------
> >  1 file changed, 21 insertions(+), 25 deletions(-)
>
> Forgot to mention one thing.  Do we have any tests to cover the
> behaviour of this test helper?  If not, should we add some (not a
> rhetorical question)?
>
> Also, one thing I missed is that the original ignored --verbose
> when --get was given, since they contradict with each other.
> Shouldn't we make them explicitly incompatible with each other,
> perhaps before where we call timespec_arg()?
>
This is a great catch. While `test-chmtime` is heavily utilized in
scripts like `t5304-prune.sh`, there are no tests covering the
helper's actual argument parsing.

In my v2, I will add `die_for_incompatible_opt2()` immediately after
`parse_options()`, and I will include a second patch in the series
that adds a dedicated `t/t00xx-test-chmtime.sh` script to explicitly
test the `--get`/`--verbose` incompatibility and the standard usage.

Thanks again for the excellent guidance

Shashank s mogaveera
