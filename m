Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635414;
	b=Jk/4niui/TuMorBKMtgkbf3JykLg8NB7KH6vO+/+Kk4EVjR9wAPHj3vYlLvAEw4NvMGC
	 L3kpr+tXJbtdMKa/2kuNXfF39MPLnkLKv1yncdpnOcvHd+qDvq6GB0m5vNZJFGZKEeoA+
	 2Vn0G0fKD8smFFuq2SUDIkzyA2qYM4P+vinyvvKELbEZJ+LryzgkONIsxW1FfTx3q/vMA
	 iy7qFL54s8Bv3kmCeAKPGV9FbLsDF44nCISqghznCVkOU2BiDVeGJpSiiGoaXMqCmSSdi
	 hq7UsKIkZzh1S/W3VMVhJGfUwJldRJkO5dTx75ho+NEUSHFFch6FWoWX2+a31YEhZbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ErINzw72vPV3j2EU0sbVvT+E831n5uc5A3LHW+kJg7Y=;
	b=hq9FC2zmnLx8296MB5D82zBPjE4rTWeLjGt/S8rCVE5KZXhJtPqPqLVyIgiTegKMOlbE
	 NRpSH86vMV7tzoMR2jzAXul17+zU6k6FzvCcbRHpYArKran4hvdmLR71n1u9lyLpMuxs3
	 4o04eAodk/sw/dWRtR1x+C592Km1ubgyILDR7akCBI3O8teNkXR8hlX6BA+V/Ojy+Llir
	 3PGpNaI1LFgC5Y+9ehD/Ny2AArhnLHkAvh+Ku5OVsUXrQhGKd2dY0WhpLcY799gXAp6jj
	 PILN5F4YvkN5gsJd6IuvxKC8tszbI/p6SYm36wJphGZ9riFqtNimAqCvW7J4WF1uo+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GX39WGfH;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F6606C55A
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 16:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 872F6606C55A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GX39WGfH
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so25899905e9.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 08:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793635412; x=1794240212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ErINzw72vPV3j2EU0sbVvT+E831n5uc5A3LHW+kJg7Y=;
        b=GX39WGfHe0lBH33j8EX6tq4bNsXsVemc6/QQS5aitmzL0Em3NdvVe2uYlaxTRZURki
         sWKrxW13OHhPX/1+nbOUaOkPlomiTUbBRhKYVxECYPASRHvSZbZ3eVm4ZtJK4OnD0Vr3
         8i3H+KmEoRIME0OSYR7/GDrS3UAL70Fjq2UX7EWcfEyHHa8zXg01uM30EwaIFA10BJwI
         UZQbB9RYrULEpy0+MTcUifzOGjMMLM4zz7ZDte3IbrPcVpZXwBqJX8Zzhqbzm+bBbUlE
         kVorFRkJtFBXFMz7EdCjIph9OpIg99KMiEex49FHpHSBOnOHj5eRwoJt3zcYqjvcsfMM
         c+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635412; x=1794240212;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ErINzw72vPV3j2EU0sbVvT+E831n5uc5A3LHW+kJg7Y=;
        b=s+GvqrZQRRBGtDsiQcqGdtkGKShy8/B9gwy2TuZYm0KG1FAlzEZuzpGECdANehTrAA
         VzhvMa+qjJbJ1H6KhUASHKNHYGZ7x0I7+1wxZQXIp+nh9Lrm0ePSFbILEAEYEoFyqEou
         n4phE3tbXer686YsyFJKMb/KaG2HFWxfR/F+K3Dh70m0OdltI1VxiWszssiHVxc2H1dr
         6Zg9IcH1BLLeio/SH61FREp411OMjwWN+l4Yh9ywf0dvxrNx9OOfe+IZB+5jjriE8Hdg
         T/WYOJotI34mD3I177BX9yv3fPZKu39i2c75+IPLH6m+G+9OMEEntoJ4wqZzi5G3udOu
         vswg==
X-Forwarded-Encrypted: i=1; AKwUvByKcFz68B1Ix79ke8k3VgkgQcFIyAWUoWH8HZp8i/sxBBHztt6pBiKwFiP0B7WlFK6SA2Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8t0lH4r3JDVqxlojjbd/+S8NoDyqaruhnULSWtiDTdDvfxR3b
	jPzB0K4lbNZhofmK1FjZXVv9tfC0iliTqxyZ559QNatuJzdLiV5ADxMh2hWNrw==
X-Gm-Gg: AYBFou1C9JXkuV7glC/WgTeT0SA03us0x+TjwvBK1XQ7w5y5JdhW/KPqKgg1cxWl/L2
	Ee41WJqgt+6pQkU7hTEcMIXLNvO9byEQUCCSkFwpGOxtLLGSIBncl3RBBpIIZzB03cNwY+yM6qm
	l30VZwvIqGUcIDIANSlR9cH7/LZj4IciAe9C+1xPSrDW45cB0/5ihX2gazdqNIg3IHBnQHAaNxd
	rvWXZztELK/IiakFTGU3LOizopezQ/1KlWI/6obGIED0W/gb4OCPbftxd89zgpYzVrTFYiuU2XD
	IvU+RDrA+J6+TieKG+89fcixgqB340djaIluKOGyjQAWiuYOaPrJMM4I/+MNEMjgxI6sSEGR/wI
	ULhTNPCma+hWTD8pQ5ZXPl/3LTpZF/cFBSGM+7PAL0Kq8wCrNcFc/WQKzDuhdE0ohOw3Pk6jYBx
	tBkc6sUDOkpJwuEHk878/a8F8U5f6gjbTwTcndq4AATp+9YtvnbAMHKMI2GPlcyF/qKKRJgNBKg
	mdB9Xl2zXKrMgYSVRZCj44SZmSsTnHYXzojFa8ygXmPL9d/we1voMneZsF4zdDIOk/Iz2Nool36
	q3EIpoA7vFM6WXklnc2atKHQ7KyXuSYm8s2Lbc6pajWAS5aPphYr0iMVm4v9jHhntINHs6vkfow
	ElGZTMYvJ3GTLPy882fg9UfZSYSw=
X-Received: by 2002:a05:600c:a49:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4ac17ffb2ffmr246144295e9.9.1793635412359;
        Mon, 02 Nov 2026 08:03:32 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09cc3e9asm122656485e9.3.2026.11.02.08.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:03:31 -0800 (PST)
Message-ID: <0b0a3de3-b758-4a1b-b8a0-9804b362b261@gmail.com>
Date: Mon, 2 Nov 2026 16:03:29 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/7] ci: consolidate test variables
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Toon Claes <toon@iotcl.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
 <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 02/11/2026 11:17, Patrick Steinhardt wrote:
> 
> The series is built on top of 37b3475fb53 (The 9th batch, 2026-10-25).
> 
> Changes in v2:
>    - Drop the last patch, as the reviewers seemed to favor an approach
>      that's not compatible with my own use case for this change. We can
>      still discuss this separately.

Fair enough, this is ready for next as far as I concerned

Thanks

Phillip

>    - Link to v1: https://patch.msgid.link/20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im
> 
> Thanks!
> 
> Patrick
> 
> [1]: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
> 
> ---
> Patrick Steinhardt (7):
>        ci: consolidate setup of test environment
>        ci/lib: always set GIT_TEST_USE_SET_E on Linux jobs
>        ci/lib: deduplicate test variables by pattern matching
>        ci/lib: merge switches for specific job names
>        t: honor default ref storage format
>        ci/lib: add another NO_RUST build using glibc
>        ci: don't override initial branch name in testbed job
> 
>   .github/workflows/main.yml |  3 ---
>   .gitlab-ci.yml             |  3 ---
>   ci/lib.sh                  | 44 ++++++++++++++++++++++++++++++++++++++++++--
>   ci/run-build-and-tests.sh  | 44 --------------------------------------------
>   t/test-lib-functions.sh    |  2 +-
>   t/test-lib.sh              |  4 +++-
>   6 files changed, 46 insertions(+), 54 deletions(-)
> 
> Range-diff versus v1:
> 
> 1:  a8727388da8 = 1:  3ba3d58ea4d ci: consolidate setup of test environment
> 2:  ea243343552 = 2:  52c9d8d575b ci/lib: always set GIT_TEST_USE_SET_E on Linux jobs
> 3:  1751b336cbd = 3:  139a855e36b ci/lib: deduplicate test variables by pattern matching
> 4:  b3ffcf0d81f = 4:  5c82ad5c76f ci/lib: merge switches for specific job names
> 5:  db5d05f0743 = 5:  8329586dbb6 t: honor default ref storage format
> 6:  0683eba847c = 6:  1f62c2fa8a4 ci/lib: add another NO_RUST build using glibc
> 7:  8c2e6754773 = 7:  2f656a16971 ci: don't override initial branch name in testbed job
> 8:  ea39ba888b8 < -:  ----------- t/test-lib: make feature-testbed job more accessible
> 
> ---
> base-commit: 37b3475fb530c14109211faca33716a173db61ed
> change-id: 20261016-b4-pks-ci-test-vars-consolidation-8d0c6a53ca28

