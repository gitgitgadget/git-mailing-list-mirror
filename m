Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731873;
	b=XqavXTGoG6IQwOa+01rtJC2AmcPcZ79fmrU5J7TcPGhXzfcy3Z2XSADRWYbbS/mg/lfw
	 lQ3JJhcGqya10ALOsgNRw9+dhTVqS+Pyu85pjVJyyr5xLqrXyWa+Vb6+gYgVIqZ+S8jLC
	 l996E1FP+S57bsfKjL6F/EaY/S2ZXJcBUDpCroXgAW9IEMhYmBBIreuMlYu/F4GFvpKwq
	 I87U/4dDQqFtNrgPnwGPv1qhhJBaLnYMQ9bd2Xf2UQc/TP9S+cT1LRW+HrWR3lPcd8ZCL
	 ANtyMTIdJwfHB66gSYWSSBEv/3+SIYhdD+wwhYfMGldZ8jPYyZUpGiIkyFCe+6B8k5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731873;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=V7ezuakHVRPhYwZWs4eXOKIGY0XlSNM9iSb/WifZsDc=;
	b=Duu+QXjJLRA5BRun/dEKvHGsd7NmwFSACLMZ7mIpXr+5piuz2yDr83B/f56AcNPeVg+E
	 QQWmzNpMfGZZEYuhXdruuJWnnKgD0Wn81T0Im1IXszKdLlyPGjJJ3JN/K6nb0oHzdMgVs
	 lhkY2GbFqhA9s7zd/1uyS7N/H9/r4q6fv1gX4t3YHyCBdqb9F9HLiovwISvJMQBhdSsbI
	 wr38FrtzpmbqbUZMYxRJiiUTOS0C5mJ4GcE8kz8zLEYN3XoofM7xEQjM+ucusFUNxjiGF
	 yELbnbes1tBS83TAO0PQDRQJhhyv4Nhcu1S3YZ47cscF3UzYZNSmd/iClSZX6f6JhFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HXXPOJ4C;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=axdwwHvj;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FDA606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 05:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3FDA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HXXPOJ4C;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=axdwwHvj
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA82E14000CC
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 01:04:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 01:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792731871; x=1792818271; bh=V7ezuakHVR
	PhYwZWs4eXOKIGY0XlSNM9iSb/WifZsDc=; b=HXXPOJ4C7kr4X18HXSfbhIee/p
	E/HyR9TsSFt/dQ+8zW/7uhzrP0w/srH2FGlkHCs6yrS+5Z5KjoPX9+1PQLy99rjx
	R6Hx+a56O3yo1mHQeAx+gW45ev7n+wko2pmhi7FMr8nDu0QVuUG6HFfOIr+MRGrz
	9rD/NvxLHjlB8dskYNesYmqF0y+i9SY/LVo73bO9wdG/U2aMHpGaR11acpBQRzcy
	FA2dbbO0XdgqVKtVbg15YKpsucZ4VPeKoTYsYeNKoUCyWm6/DB1m4BXANhQCpGf2
	XoU+fJnaPtTRAp2i0FdMplBaa2/I/gTajKnuXuE7sZg5OQkEHFahIY4liyaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792731871; x=1792818271; bh=V7ezuakHVRPhYwZWs4eXOKIGY0XlSNM9iSb
	/WifZsDc=; b=axdwwHvjAfrkFS7QTEuVa4CegZDNS5Q3DigxVy6H1siNu0umpWL
	5+wL5gm07ZioY7G4MSAkD6pSALMXJ2jWls2G+M70HOt7xPmZq6+Cl1hjJyzU95JT
	iqJIopCAdjjOI08hdb3fnHfQ9nWmfJyQSyPUHzZnEpOm0Dz1UjNEoFLSE5i/rrfU
	wUNJPwoO+iHizLINEEh0QVwj9vVLa5jC6t5irwfS0PgEfJU0lX3nJp2ZTbRcYqBI
	/CSu7jRjzBjyUNWtT1AOzSXNBC4tH0adkCNEEFr6elumN3jGJl6rEulTq88S99hC
	DtLAIEbKsmNwKaEBqeIuPvtREAO8Oehsdtw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792731871; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:QCGFzCZMoKeLSjoh45Yjkmf9wBD+AS1c9XhpdJ5kwLnHwbh
	LNYd11RzI5BYgw2EXikZq6kANcLoIOjA9DXNE6iVsoHhX2YYu3YHt50+U/xYhz/G
	wgb5oNuLDQPTbrD8Be6g60878R46NK6pMi5PK0Sbv5wVafXXPg+SyNetDFXK6qFl
	tmaNJZG2jDREAAk0qc758oQ12lciBj21pmjaEciXu0utjkdZRDo+OmEvhc5Jp7KN
	w0x5p6H0wiUNR+np4mLUJ/rH7401M4kREqjBrAmC40Dr9eQ/DEaSPfsYm4qQOqez
	vEFsaY2fuXcUizbHVBeHUB+QKDw/pzfuB7BDLUQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8r7F/fhHnVlv59rEvZa9TWkr2UcoUrIB4MPxlNKANqg=:zrHebjKeL6iWPNhbOfOOdxQFIXXUsK+TRzaXphFNZgY=;
X-ME-Sender: <xms:3-raasLJi2840VdErmVkn9IwvoIX11uxGp2FgcN_XLJRccaQS8kWJg>
    <xme:3-raamtBi772tO4-PQaWceSkTbZZsKRKLtVK9I5u-IO0tQA2XW1E8IOt8PfLIJEXH
    fXhnoB2Zq-O6z9aoqYSnHit5XwPDojABdbzmWVmyDfJF8_m9vTggA>
X-ME-Received: <xmr:3-raapQK1S8OI_NT2H9Zs58Fa_ez0-t1PJY3iwcfiIAoCX3j6cM9IQy7ARtd0VDqzI96vF8G4-B7emFuj85QnJ3TIpjVDdpSBLSn>
X-ME-Proxy-Cause: dmFkZTFEOW7OKRDfcMqoOik0KaXm8oFrrzF8zQWRT950WKWZZ+a+CbIwx8JWqPM6IJkaHk
    TQ6UW6/YrvMqo1seBPX8AO0nYPJ+RFSmVwU9lV90gaRcITSIesUc/S4wrf+WxhU8eSYhQS
    yXmGs2khoavjTYk0p3npxC7pDdtr5T0QssPedd+09++Q0Kvx+Vbf4aqf1YQQ/X3dBijkOk
    +2bsTL04nb51xUJ6nt1Aw354gSjYBrNJb8DtxNED9hyymF56L8E2YqXfgUnA0ZvAaWYP69
    EOqCmUEdFCmptAMlPZdHGkwTsiwnexMSIAahnP/GJEsFe9mVg1f2p1qMAMMi5gkskF5wbW
    Q0NQ7lRSNiDSAokrpJ9Pg6MNyNkuAKKUM5zVhnYSksldlhyhDNRCn11bZ68gHqTiHbVuTs
    5LZvrzTXYAIDn/Ltv5e/IlKXXXUrfbrjF+EZzojOTnwAJYErS26XQnIqv10OLy8efJZK87
    /t7EXYd9SgiWzGIMKsmkMGxyHQfb8Nmf1jQfzsbY4fmt7PPbxo1YjkxF8fcDqi98LhNptS
    VqadF3MSPKovwei52pKDZomZP0ohNz9dp37UnpW4ERqd3/1+PkDqhvAC9gSAeOVmnu5mOC
    nf/MNGFIAbYWGpjzb0cwoSWFT6Qdng/VQ2K2M0U3RCZ4InjxskQEiNMLAc9Q
X-ME-Proxy: <xmx:3-raasOu54pJb5z8XlnY_b4C7YAF0OXsFq34nEJXMZAITaMNzC0thw>
    <xmx:3-raauboAtDdcIJ7hxMDSFG5r1raO9Asjql2Ox-XpHiF7_25l4iXuA>
    <xmx:3-raamzhbt79N3gB7ObSAI9j_-uLmzaB8mRj-Ihch5TJBxswd_MxPA>
    <xmx:3-raapLpeeZoEjVeWmu4_u3xsfY_XZ15hSM5sH0CDq9yBVYEuSxWzw>
    <xmx:3-raal65z4uaWjxvl0rBG4YMauHE4Vqt51qyCmOHmgwvcSwwPkjn_jom>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 01:04:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH] [Outreachy PATCH] diff-delta: use safe integer arithmetic
In-Reply-To: <pull.2276.git.1792727808109.gitgitgadget@gmail.com> (Srujith
	A. Poojary via GitGitGadget's message of "Fri, 23 Oct 2026 03:56:48
	+0000")
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 22:04:30 -0700
Message-ID: <xmqqld7paty9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Srujith A Poojary <poojarysrujith@gmail.com>
>
> Replace manual multiplication and addition in create_delta_index()
> with safe integer helpers (st_mult, st_add, st_add3) to prevent
> overflows while preserving NULL returns on failure.

I do not quite understand what the last part of this explanation
wants to say, i.e., "while preserving NULL returns on failure".  It
makes it sound as if the function would return NULL if the integer
helpers detect integer overflow, but I do not think that is what
actually the updated code does at all.  st_add() and friends will
simply die() when overflow happens, so you will not even reach
malloc(), let alone return NULL when the malloc fails.

And if you reply to this review message, please do not top-post.

Thanks.

>
> Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> ---
>     [Outreachy PATCH] diff-delta: use safe integer arithmetic
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2276%2Fpoojarysrujith%2Fc-refactor-target-name-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2276/poojarysrujith/c-refactor-target-name-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2276
>
>  diff-delta.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/diff-delta.c b/diff-delta.c
> index 7cbedeb507..45df070ab9 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
>  	hmask = hsize - 1;
>  
>  	/* allocate lookup index */
> -	memsize = sizeof(*hash) * hsize +
> -		  sizeof(*entry) * entries;
> +	memsize = st_add(st_mult(sizeof(*hash), hsize),
> +				st_mult(sizeof(*entry), entries));
>  	mem = malloc(memsize);
>  	if (!mem)
>  		return NULL;
> @@ -258,9 +258,9 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
>  	 * Now create the packed index in array form
>  	 * rather than linked lists.
>  	 */
> -	memsize = sizeof(*index)
> -		+ sizeof(*packed_hash) * (hsize+1)
> -		+ sizeof(*packed_entry) * entries;
> +	memsize = st_add3(sizeof(*index),
> +			st_mult(sizeof(*packed_hash), hsize + 1),
> +			st_mult(sizeof(*packed_entry), entries));
>  	mem = malloc(memsize);
>  	if (!mem) {
>  		free(hash);
>
> base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
