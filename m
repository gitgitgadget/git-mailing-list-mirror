Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858553;
	b=pd4Y9mA+BcFtGL5QAkJyAt34/M5+Kp+9lDFsSfY8mfds/p30dBgYGLJ1yiarrc132YME
	 rgZikpxy06rEVQh1ZU1QbZxAsgqd2FQAQAI/0IRivFwoy9sSMakkWXQX6EWi/3Upwi5tW
	 sYDXGKnw4WTsvX7gvxyKfNqxT1zLcTpMAHIWZoEZOBxDtJOgS8Cqg9j70eyoSwkagRXE0
	 jHyiA8ujo1AxSWcID5acf75AvhMxLbovmjYoPiKQTgeU8YG9bVAo1xPSt1/zcrNcdJM7g
	 TPwFlshLxg5VxhmR471fiijtknRuhD9zcLw2UkS9O887nz2pXY0U5y5TPbs2OwaJfmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858553;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=tZVA51ErVr1F3vugGUMUud+nIRA0Rc9qzg54khVQJec=;
	b=KMmY60IZPA2N/S7X3XOzTz72jLZD8R6wGYm7Wtnr7hWnOMYjj6A/CkeUbOQjhsnV7fJa
	 5ELaZMJjpG7G0Ctc3bdqdxfGistm0aKa+E0WfX5Aqgu7Q9fisaROv8BW7RJlF1DpMjBKL
	 UJFrXkruNNyBrZlk5FsKg+J49M41EyLwZu1Jk5V6WJSomBxpbkq4SaBHe/MEXrTD/dBXa
	 MIXIvgv+7jWR7NDhSRzP2TyWyjDQ1pkoF6yeXy7ugqyI4XrhFGNleB+zPScdMbnuqWfJZ
	 jqVUmKvYvs4KJJQUKJe+BLEg92WTTDD1jXVc8F1yuQLWKOm6vJIfO027344/70x5LPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="eyo/eYQN";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yRh2m6HN;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB7606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 16:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FDB7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=eyo/eYQN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yRh2m6HN
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F266C1D00167
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 12:15:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 24 Oct 2026 12:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792858551; x=1792944951; bh=tZVA51ErVr
	1F3vugGUMUud+nIRA0Rc9qzg54khVQJec=; b=eyo/eYQNJBFZ7NdvWkXMpORB1r
	l5scflW9dvaJ9fp2S9AiVPkTVFnaBpYZLQ8lBPIrPZ0/5ACTi+u/kBQQK3quyNb7
	AQ46s09g5kewWyKY5m/uOcE8hMxSOA8iAdhxksCPyLhvDcbtSuYEfPsxoVp/9hbT
	TihVwqimfgnxYhYRMyU7oCgUkFfAsOQgwPlDikOprgCIvUpAB0pGv+V66qsCzFxw
	+C+duWm5FMb7Jj/364IsFhoFodZ8NEEzPJB8iRNIMYnnE//9M9FoYRu+Hm49nR1u
	MZaEfljdOLOnSGRcrEO4z1Rg0QvWyjX2R/L/zB69tZliNjbcEZIeT5aqaCzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792858551; x=1792944951; bh=tZVA51ErVr1F3vugGUMUud+nIRA0Rc9qzg5
	4khVQJec=; b=yRh2m6HNLyMQKaFAFYnruohf4dqjiUgvleNtJw7KY8ccygfLS63
	+UjvOitWnpSGn6qH98FakA5IULM5K01J46SwAf5NQx7K38q3iMeRp+nNbxBqj/A1
	dY1DCON/0+lUW4UyziBs7x1hgUt64DiE9mi7+NMOYrs5drAn4p/wFTnqE3WygXNb
	WqLmm5nRmSfqrPohFNEtPHHBAlO/MTmj9TbrrnaNib3eGq3uoHaDSDB8n8zCj3Qs
	d0bdKLBhluAGmjsyWkgRVfSvFAJn2/IFyYBUu0ujc2QQIe0M5YwYM7g7324+ccdp
	6vWpL9BVA4Ax5y5Moy1doitwtHqiBYLeD4Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792858551; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:f6Dvv5G/0UILN/xAUmsKoYGqBzdo/+PxpN/ItkBciIzUL9S
	+X4OiPg4veWGFDbrMS8OpGkFjBOlPBp6Xc+x6JvI0a7TRkwpLLl4FoaVh9r5grYF
	w9XNH3KJlVkl+ZZDVJNe20fH7m2fUpt69NhHLhMs6kYoW/11vnpN7cgy/b+B3/8T
	t1q8NnsiUrudnYN9bxeqX+yyoTnHQEfBbAGHcK2bgGkLbVSNjfrAATYl+o79K1aP
	tCSOjDY0w+BmU6RpwVrPy6mPKoDIlJsfAJnReUug3+m3gIuFYsWRNt2WVcKXIwiY
	YllmQo99hdBxfVrZ3b19G927CTWsgKmgoO8L0/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:qJHspBCkaZqxkdjcWfzj4sDB8K0ePgGQyrdwbWFNJ/U=:oao4MlTmlsTd6aHjfQ9nAO7CWBwsXwG3jP6W/cVAW0k=;
X-ME-Sender: <xms:t9ncam9eKn6xZCl8l1N84sb7YD7PlGxyDPJdej_Fjk3xnDK-m7Bk2w>
    <xme:t9ncatnVYjQm6UEjnehV8UTX9jFWcbWcAqXMsAFHauC2Gt3Uu0wKJS-2G3f5AFqiw
    pqHtCNQU-n-cDdk0HWrKFU5x8lT1XPJS79twoXoaaROO-xxF08NioU>
X-ME-Received: <xmr:t9ncakWWVA9yRgzCDVJ0nhbhKozImccN0INtXmyGLbKLw7rW14ZMFEsC9He9dIKfrfpRSWVANS0iOKqV7GsUSbcPtj9hMDZ6NQrj>
X-ME-Proxy-Cause: dmFkZTEy6PIpVnTaFeKqM3NR+vqOpJs+Q2gVZvfn7hArGcLC12LD5ZlJB7/IPnlfNtPI2H
    +G796K51NvgnvE9Sol1VDiuKjWFYkGQO2tkTPg+LPkZyCy+BAC1T4u3Ny8NmV5tTLZ5xUB
    /dVNbN3G7dkWpMrx+bWLFLJud1Tzty5I0/rP30cdJlOtbHJWDW3o8YuUhVT1st7E+VWWe9
    DuDBeJzv8DJDGDysANQ+GWq9+iJ510FiO5Fx6ROlPztWq6+6297zDUI1V63/gNjE73ngDb
    wu2HwCa3Ss6XvG/Lbh7RFdGSYFnRIRkB+ID3bYD2kV0SIKVEsMHXNnOohjrZ5z77CxLJSC
    xr08lvTwhrOOcG+hIaormYFXNUHzPnMl8GcQQF8uXEZYjExru+2+ZR4oQZ0hJdxdM7Zdxb
    5pLQBk4XAo5WCigDO286DLpEVETT4n++dbwEjN/p2+ib4qEh0C6IJmiti7IhvDmlSlD1Hl
    kiU+jTczeEqZZUgzfUEn6J1Y26n7WReDUBbm0IZG5jz1YrWuY3FlFb/1Ulit6bAI/tfhdZ
    oZ3f+yy4zy4841B84bMLhZ/L3Ab7wz77NPTzyVeXGCHwDY/6l5EiNWBonUz21gXhmVEXQS
    ZYT1IkPMhPYweh2L0yzvwZbN/HZt15ORnzTZPCtAEPrH6Y2R9JDReV0gX0YA
X-ME-Proxy: <xmx:t9ncaqEjQ2lnm8b8X1nKhIHnkRtRlHgh1YYpoXbN62fP6cjfs2b4QQ>
    <xmx:t9ncaoeOGs9v8mR-wlOx35quGNL_oZSDXq5BE17QF9tF0slEVRVNhQ>
    <xmx:t9ncajJTzISnK_Q26ugleQvZcXbZCgY1K1-mqlhLuQ55OGfJXHTG7g>
    <xmx:t9ncalGgD4Kf9PnsTuvI6l_XqN4i4NrvGXKr1HqXjNpg7zhsbWzH4A>
    <xmx:t9ncahX5FCDC9iJPiC_1a80QdI4ucxRQemdYl335vLR-hGy4ERLhh5_s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Oct 2026 12:15:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Srujith
 A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v3] diff-delta: use safe integer arithmetic
In-Reply-To: <pull.2276.v3.git.1792813697888.gitgitgadget@gmail.com> (Srujith
	A. Poojary via GitGitGadget's message of "Sat, 24 Oct 2026 03:48:17
	+0000")
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
	<pull.2276.v3.git.1792813697888.gitgitgadget@gmail.com>
Date: Sat, 24 Oct 2026 09:15:49 -0700
Message-ID: <xmqqfqxv13d6.fsf@gitster.g>
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
> with safe integer helpers (st_mult, st_add, st_add3) to prevent potential
> overflows when computing memory allocation sizes.
>
> On 32-bit platforms, struct alignment padding could cause the total
> allocation size calculation to exceed 2^32, making safe integer arithmetic
> necessary.

I wonder if "X could cause Y" above skips a bit too many steps.  I
was expecting more along the lines of ...

    We will need to allocate N instances of A and M instances of B, N
    and M are capped to X and Y respectively by this code

        ... code snippet ...

    and size of an instance of A is 8 and size of B could be either W or
    Z.  When size of B is W, then the total allocation would be ...

And that analysis applies only on the first allocation.  I didn't
even look at the packed side of the allocation size, expecting that
you would know how to analyze after seeing my example on the other
allocation.

> Note that hsize + 1 inside st_add3() is safe from overflow
> because hsize is capped at 2^26 early in the function.

It is misleading to say hsize+1 is inside st_add3(), though.


> diff --git a/diff-delta.c b/diff-delta.c
> index 7cbedeb507..efebce3aca 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
>  	hmask = hsize - 1;
>  
>  	/* allocate lookup index */
> -	memsize = sizeof(*hash) * hsize +
> -		  sizeof(*entry) * entries;
> +	memsize = st_add(st_mult(sizeof(*hash), hsize),
> +			 st_mult(sizeof(*entry), entries));
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
> +			  st_mult(sizeof(*packed_hash), hsize + 1),
> +			  st_mult(sizeof(*packed_entry), entries));
>  	mem = malloc(memsize);
>  	if (!mem) {
>  		free(hash);
>
> base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
