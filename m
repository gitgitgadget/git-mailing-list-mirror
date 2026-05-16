Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122817B505
	for <git@vger.kernel.org>; Sat, 16 May 2026 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778939221; cv=none; b=gEyQTqJ1S6JdO7PLy3figxjrN7V63pij1ZzVUh86b0FIs/dQLOEPdpuwW7yW7mDVk9moN49M6dQi9kTe1dyuXDlcOPOAdD1ZZJLKoi4XnMwhBcLxLEP30k2ocfEmm7qKET+WlHt9y9ZHlAwaoHQvoenQOrLdzfjctunvva8SLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778939221; c=relaxed/simple;
	bh=Z6BDSZ5A+Fy+gx/kH9nrKRxNAPt8X/6uCTAx4XdnUgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Drf/vUniSIai6HwT2zGV/dAtSox+B5/bUq8Lvt4cQYIXAMzxkswyuJQChESzUxP0ZlvGKNOEPGOLBLiMst7lnKrRe0EunD/hZVg/quvE/If4NkAz82L7Jstv0WpkwhcnoYhN5kQZzLFjQkdf+lfezV8Iu/bNI5X1trQ+J4XpUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRP+U+sl; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRP+U+sl"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e5c5033f6so8945001cf.0
        for <git@vger.kernel.org>; Sat, 16 May 2026 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778939218; x=1779544018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTwRQMmLqCLrwJYufIBNwn7+FRAynzMwS6HVWH7n5Go=;
        b=IRP+U+slAJcI0EBvfAWf4AGl67yAeqzE8dkBmwaQ/9QphupZMlb/QZPBfA/g5je3bp
         TKGHFSYoy+qD5BkjxoZWOUsOtuClrYA0APOm62lRdfP9NkIwp5nQDh1pbjegrGESWYnJ
         ic8+bl19cVhXonhDPT55MyT5mcqMXVIUk29HXtaQZCRtIm7jDqrAdh/CNBG+UgNVZ6iZ
         fy/quNPlofcAJcm4iuyL46M8TWKZCUZD8p5HI6+Das4PJ07tVcBNHJPVVKUCKoZ3n4IS
         EmcUVnN2KNBM6cVH14HC0WXEMw0lxTWw0rcNd4X+tagMrvoO2XFZYAYKtzlu9b0FgxyE
         jwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778939218; x=1779544018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTwRQMmLqCLrwJYufIBNwn7+FRAynzMwS6HVWH7n5Go=;
        b=PLlvzGw84A3rdlzriJykK3Bgq/AunKJX2vHA2Z6MaOSqBfy3UUUEFZeJP2MKnGXhlX
         /PsMc2J3QTID9w8gj9oc+Mgh+5uva/LZHEfMCjak72TLJJK83kfYGXj05KGHgIkm6sWh
         V4bHR6hHhuyIf4bEehik6xa/E2jSHLF1vaeF7Wkp4pGnphnk34EXacerJWnFyLa+DQSe
         avqH/CQL2GN0YP2NSXGCVDX8gU+Iuf7gnPKD6mOjDtteZtgM/YF2ZTWA5YPEqF8Sz/f5
         8LeHjoYRAbQETCXRUHhAJj8D2Ginx4f+GXlRJYDulzm+O88A2Bv+M2vTXWFiJmqeXLN1
         cEuA==
X-Forwarded-Encrypted: i=1; AFNElJ/diO15j3J6h1OW8RSuxF00J78f4bdb97l0P1AoHgk+/YqzZ0t3CNEodsxaNzg6qh5GOf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXtBuxVGHIFQ1wAoeMcSfDe3nhhGuFBYgNz29aTyM51IujrOlJ
	CS/4KS0d2P93PcexSf4jNyFJP5ROcdzqb2NGy7qveiKmf1vSGPi4sjZm
X-Gm-Gg: Acq92OFeozabZelQZg35mj9+NpsQK4P0ILT4f/6nko4WX5syV6Y6X5ueI/+PyJjHtZP
	weTh5Rzrn06y2iTvqe1O6ZiElGAoQVgzx4kJQZ1Zdcr1Kk2ziJ00Rm6u9TymLbG2nnmd3SUPy6O
	3r+gWXT+TE+JMz3bDTru7LTTiEtnDJdTnrE+tUm28/gpC/g/HQk04kc16zFGY+NVf2hJQ2ysFVs
	5NvRv0cJrfFtNQQ+NdXCEyQG4+KmtDnQ97GFy+5irzVMIlRB5dGC7WVErPIt076/uGhBrcSxXbc
	vEt87Wl/s7ritRfqkjlSFKrWaqJSZ6xHVsw1RP3vEBfFxOGJvfc6WN2J1+jm/H9I+p3OamdY/Gc
	w+M9dFM7psC8ocffwtopjmRNlIRdAGKq37W9ghx3Tc6kQLGaGmozSFW4pUAnp9ROzxdmmmKntVL
	0YQpo0xudiaoUDOp2DaQ61mULl3VtWeJsxghR9QrRxnuZKE29hNqt3XgMvqIASTkqYR4urflcaz
	RRgHK5U/1oK6mPU3bIZjARaycHTe/X/mSjGaBtlH/bwBzCk12o=
X-Received: by 2002:a05:622a:4112:b0:50d:8049:2f22 with SMTP id d75a77b69052e-5165a0072ddmr110855401cf.3.1778939218645;
        Sat, 16 May 2026 06:46:58 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c? ([2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm78474051cf.3.2026.05.16.06.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 06:46:57 -0700 (PDT)
Message-ID: <5a783514-9d20-429b-8c07-200cf821a35d@gmail.com>
Date: Sat, 16 May 2026 09:46:56 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit-reach: use the decoration hash for
 tips_reachable_from_bases()
To: Kristofer Karlsson <krka@spotify.com>, Jeff King <peff@peff.net>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2116.git.1778868463992.gitgitgadget@gmail.com>
 <20260515211459.GA158762@coredump.intra.peff.net>
 <CAL71e4NoKiRMGngCc-FYNX9PH5fTd6xpzMsfONefp+JwJ1-3BA@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4NoKiRMGngCc-FYNX9PH5fTd6xpzMsfONefp+JwJ1-3BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/16/26 4:23 AM, Kristofer Karlsson wrote:
> Thanks for testing this, Jeff! You're right, the patch as posted
> regresses on your synthetic test case.
> 
> The issue is that when multiple refs point to the same commit,
> add_decoration overwrites earlier entries,
> so only one index gets stored. The marking itself is correct (the flag
> is on the shared commit object,
> so all duplicates get marked), but the j == min_generation_index check
> never fires for the minimum tip,
> so early termination breaks. The DFS walks the entire graph instead of
> stopping when all tips are found.
> 
> I have a fix for the early-termination bug (checking the flag at
> min_generation_index instead of comparing indices),
> but your suggestions about the API are well taken, I don't think the
> decoration hash is the right tool here.
> Since we only need set membership ("is this commit a tip?"), not a
> mapping, an object-flags bit or commit-slab would
> indeed be simpler and avoid the (void *)(i + 1) hack entirely.
> 
> I fixed it locally now for the linux test case and got a 4x speedup
> there too - the problem was failing the early termination.
> Some numbers when running against the linux repo on my machine:
> 
> Command          │ Baseline │     V1 (broken)     │     V2 (fixed)      │
> --no-merged HEAD │ 1.33s    │ 2.01s (1.5x slower) │ 0.31s (4.3x faster) │
> --merged HEAD    │ 1.35s    │ 1.96s (1.5x slower) │ 0.31s (4.3x faster) │
> 
> However, I'll still need to rethink the decoration map - I will come
> back with a better patch shortly.

This is indeed an interesting case (multiple decorations) that we should
make sure is covered by a test case so we don't fall into this mistake
again.

Thanks,
-Stolee

