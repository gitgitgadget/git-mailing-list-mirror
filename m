Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC233E3169
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269426; cv=none; b=egBvkmJjYwmFwB0adXFOmYyd3mO/3/toMAMkRRlMKXvo4t8qnKZNV7RJAL8BMQdVsq7XqAIodjkT5zwuBTwrUbgaltcV48qDmdqDoqD6ot15LuPB6ifupnBAyY1WlMZKZO55Z6LLOLNbsE0zzcMl8Xiq0auhicil/33tAmei7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269426; c=relaxed/simple;
	bh=Qlky7X/3IzChNkx4j+48JXXC3S8yGYBXYbQq7FWelI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bk0Q6ssqUW4H8LU+370vDnE7RkoMSCsJqou33g+sa0fY20n5pYFQnA6kB7spbhqYGSdbWO0iFqeqQeKOE2M7Lc6JiOhf1QQa4WPMtlydm6wxmfP3O9C1+SSr6Aml2egBV+eQMqMdxI+76npqpVIa3ImxELL9s5m0uBsGMAARW3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQna84jb; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQna84jb"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9156b74006aso62224085a.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781269423; x=1781874223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzLJktoMQmxdIgZXcbYJrF47qOVMreJ9de4KEQ43Tlo=;
        b=eQna84jbuakPNj4vuLOX5Jjh+XbbzOFpVVRV307Cwd3I5oS3vEIHGp7Y7X4VIIK3mr
         Fj8Vr17hDDH3VpjyCxH5yt79RHT+9AkOLZD95EcsQWCpuPO8MazmU0Uc6gSz6VQz3p/N
         LctiC1Lg1c6wKZhlDlZ2Ab2IrD7V143+3M6c/qUzw/Uu/xkxdeS6nJtjUidr3rdheBgv
         Y/A0tZgEBEO25wTVdkL2tfS/nrfhsunyV7FqyisthyPjhYH837zCXHouXZUawm9qVytU
         ALFBDl8qFcZ1BZeWtOpoFg6yLqqOUyClTC/ywfg4lxW5FQ0O9lEIjA+RdkwMSh2Glc/b
         5FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781269423; x=1781874223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzLJktoMQmxdIgZXcbYJrF47qOVMreJ9de4KEQ43Tlo=;
        b=UR/YIThv/zZOCf84C7foTS9SSBR0lBA+bwHp1KXJeFXfAtDma0x0XQceG7UhtHZV5d
         Y5h8gBRFwkyB547I0LDQyAoA9QEv4kYC09GNjj/0ajMZosUca5Awx3DI2MhORtdTE2qp
         AvUJzcaHEsW2+QBhV1DYK2UfxH5LZtvdu1ZdqYurvFCgXEwLhgBnLz5SgiQKazu9mWSI
         9Dt8jrIZeJ5+MKD/4u7mgfwss1TPDKspjmDazgxgT5svnK4OLc1+OsFCWc2QLzgi64x8
         MOWLRgYjpX+yRsltb13/QFjL+1pTa3m2KCH8uCv2YPXJJ6dose/mV6584SU7278w9Q67
         K69w==
X-Forwarded-Encrypted: i=1; AFNElJ8gULZnPBpTb2isBruVp+99LrhunKLbwJNJyxw+Pe6/LLDnplptpm7ggXD0va29p9fomGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqUS9Pq0H5Van8Ako04PVldcJnUVE/rsf0/cYshbK7x+5rCwd
	p92Zx95V0M2lfyAFHas2Qy3WfZZ5IT9dSFv0P1ChN35xcAMR8sd3Z7Hq
X-Gm-Gg: Acq92OFJIiIF3d8InYQOCPzV+JSOzoJg8wmQJLJt1WqBVESggrOlwoLjiQ3nH5LfkWl
	2yt13qOhaSsbv7PK+quX8/AD9W6zQtkZ6ktHIbBRxEHMEoLoMqn2bshXrMtoPnrl6HOGUJ9Q87w
	EvM0KcmCo+KffUJn4LA8G87Jj7RqkKURcU6hw3DSGfzu4ZF/MaQrk9xHJomVjiQujkkVyVqbQDG
	/H8q4JxuPgQzRlCzrzm257hdHTdZwsS8OXqZrfwHCH7wuckzIgQd7YMxKMllkK7w2jPJv96S8Yq
	jmcgAgdsZvnSQrbt/GvkAiIhe3OaypNDuuKgflHozRri83QsSJuChkq+CKijqzKXa1p+3uUqGgH
	BhIzAV5PXa9zKqFHOuoz/Il+SzmTVkPRdSNnbGjAWkR1r/kK/rxiyPG2qeZpDqef5PdCbl0hRFi
	pa3EVS5k+37+EiF1amFj+2zaCn5tIr50HaJr0sdTqexx2QAhFNJSvGTmayKrV4kQPXvnrE
X-Received: by 2002:a05:620a:460d:b0:915:f360:e974 with SMTP id af79cd13be357-9161baeb66fmr335825685a.13.1781269422659;
        Fri, 12 Jun 2026 06:03:42 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a035849sm199048385a.33.2026.06.12.06.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 06:03:42 -0700 (PDT)
Message-ID: <6e4a8764-3c56-42c8-a87e-40a94c6c34e9@gmail.com>
Date: Fri, 12 Jun 2026 09:03:41 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
 <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/2026 6:21 PM, Taylor Blau wrote:

> As a result, we can see significantly reduced pack sizes from p5311
> before this commit:

I mentioned this before, but the pack _sizes_ aren't changing in this
example. We are computing them more quickly, though. 
>     Test                                      HEAD^             HEAD
>     ----------------------------------------------------------------------------------
>     5311.38: server (1 days, --path-walk)     2.56(2.52+0.03)   0.01(0.01+0.00) -99.6%
>     5311.39: size   (1 days, --path-walk)              123.9K            123.9K +0.0%
>     5311.40: client (1 days, --path-walk)     0.00(0.01+0.00)   0.00(0.00+0.00) =
>     5311.42: server (2 days, --path-walk)     2.57(2.52+0.05)   0.01(0.01+0.00) -99.6%
>     5311.43: size   (2 days, --path-walk)              123.9K            123.9K +0.0%
>     5311.44: client (2 days, --path-walk)     0.00(0.00+0.00)   0.00(0.00+0.00) =
>     5311.46: server (4 days, --path-walk)     2.58(2.51+0.07)   0.01(0.01+0.00) -99.6%
>     5311.47: size   (4 days, --path-walk)              123.9K            123.9K +0.0%
>     5311.48: client (4 days, --path-walk)     0.00(0.00+0.00)   0.00(0.00+0.00) =
>     5311.50: server (8 days, --path-walk)     2.58(2.53+0.04)   0.02(0.02+0.00) -99.2%
>     5311.51: size   (8 days, --path-walk)              152.4K            152.4K +0.0%
>     5311.52: client (8 days, --path-walk)     0.00(0.01+0.00)   0.00(0.01+0.00) =
>     5311.54: server (16 days, --path-walk)    2.58(2.52+0.05)   0.03(0.02+0.00) -98.8%
>     5311.55: size   (16 days, --path-walk)             205.3K            205.3K +0.0%
>     5311.56: client (16 days, --path-walk)    0.01(0.01+0.00)   0.01(0.01+0.00) +0.0%
>     5311.58: server (32 days, --path-walk)    2.59(2.53+0.06)   0.03(0.03+0.00) -98.8%
>     5311.59: size   (32 days, --path-walk)             209.3K            209.3K +0.0%
>     5311.60: client (32 days, --path-walk)    0.01(0.02+0.00)   0.01(0.02+0.00) +0.0%
>     5311.62: server (64 days, --path-walk)    2.70(2.76+0.06)   0.16(0.24+0.04) -94.1%
>     5311.63: size   (64 days, --path-walk)               4.1M              4.1M +0.0%
>     5311.64: client (64 days, --path-walk)    0.44(0.50+0.02)   0.44(0.51+0.02) +0.0%
>     5311.66: server (128 days, --path-walk)   2.88(3.20+0.05)   0.34(0.65+0.05) -88.2%
>     5311.67: size   (128 days, --path-walk)              9.0M              9.0M -0.0%
>     5311.68: client (128 days, --path-walk)   0.93(1.22+0.07)   0.93(1.20+0.08) +0.0%

Since we are testing --path-walk on both sides, the change across this
commit is that we are using the bitmaps for the "counting objects" phase
and then potentially using the --path-walk algorithm to construct the
packfile.

The fact that the packfile sizes are _identical_ is suspicious to me. I'd
expect some amount of difference here due to the change in algorithm. It's
possible that this could be explained by the repository shape not getting
any benefit from --path-walk because there are no name-hash collisions to
worry about.

The one thing that might be hinting towards _some_ difference is that the
relative sizes are showing as both "+0.0%" and "-0.0%", so perhaps the
exact sizes do have differences that are hidden behind the human-readable
sizes: 4.1M -> 4.1M is +0.0% but 9.0M -> 9.0M is -0.0%.

> We get the same size of output pack, but this commit allows us to do so
> in a significantly shorter amount of time.

Ok, you have the correct interpretation here, just a lingering typo in
the earlier sentence before the table.

> Intuitively, we're generating
> the same pack (hence the unchanged 'test_size' output from run to run),
> but varying how we get there. Before this commit, pack-objects prefers
> '--path-walk' to '--use-bitmap-index', so we generate the output pack by
> performing a normal '--path-walk' traversal. With this commit, we are
> operating over a *repacked* state (that itself was done with a
> '--path-walk' traversal), but are able to perform pack-reuse on that
> repacked state via bitmaps.

And I wonder if the test setup creates a situation where we are always
reusing deltas from the underlying packfile, so the --path-walk algorithm
isn't doing anything to help with delta compression at this point and the
difference in this patch is that we are replacing the object reachability
calculation entirely with bitmaps.

I suppose what I'm really worried about is that I'm hoping to see some
evidence from a large-scale test that demonstrates that the two algorithms
are working in tandem in a non-trivial way. I haven't seen it yet, but I
also don't have evidence that they _aren't_ working together.

Thanks,
-Stolee

