Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581882;
	b=sTDubVZoZNUAmrYDvhvByFKNZlmnOwACLdJF6aU369K80Jv3JQZKnqBBrQHDQ17VfbHB
	 d0PZLnIJEKxOAX74g2qsJlDSePZ8Pw2Cb9mHpsBojTkC05Oj0FbIXE/ZChRvFxsdlJTRT
	 U3m+bmMZLsqxpQhOkKuOoqTEiCfzK32RoV8iNJIDK0/Wz6IMy0eTitPB0V/X5gkXJ2vIv
	 f3Srf59G8zwo8DJRNiFjQ8O9tcmB/obtyFF6ibItA+Fao5q+4Nzcbe5jEtQViciLw+E5B
	 iJR3KFnSZYhB49VIbKYBsNu/4JguMGzBOEMZrri5ByJoPRF+ttCoWzmdI4v2sy5Y+7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581882;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uxXa50w7qYXBw54b0U/Qav8kbOTE4eXJucgB5nCCNIA=;
	b=TchG9Aq471gQgAjdUsIl/OrM8Djxc06sNtIgkK6DJnWg7oHDHBozqbEs8OjvHxyfeoiM
	 jCjoDAZbit/bnW2ScsWqNq/Un9fYwVEagNQbwa8BI3Tc99q/DqlE68HW7MI7vZGJbDgCo
	 lbWkp9ILsVOkBbXvxrs+jCGaZhxaI6XeQSGBPINRGOufcoSTgyCzWHmOmxUu5pA4+6eo5
	 G6lTfxGaDWcD5k7d6E+e2jWQ0Kvg4FKa8KhtM2PZricw5cHzOtm6ThX+S1cbiJUXZlTa1
	 XsWtb97HUe9s2IfYQpNFRzFJxKiqsVwpOWdh+D4xgQwLFE1qklZrh+HIiQ6ZYR6aIXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=EuZ5lMdc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DBgF8Cmh;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221C606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F221C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=EuZ5lMdc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DBgF8Cmh
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 42B2E7A00AE
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:24:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 21 Oct 2026 07:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792581880; x=1792668280; bh=uxXa50w7qY
	XBw54b0U/Qav8kbOTE4eXJucgB5nCCNIA=; b=EuZ5lMdcbxeXDwxnD6dXmqIYvj
	ygIwMTw3naK8sWWKzY1H6gwkt0kDRf9Jeyz+NNhXRLhEZk5lQ3KjwXR5cmlv1OOw
	hgUGmWfohptR43Q9u+wF2wmtD6ysU+/MUy1ni3t76gtH69DO9lcyfbJMHZHyb9gq
	pTkY/nWt4SlUeQBT+YkqLesp3wlejq2XlHiCbsrzbCHezYf198SwOaSafiFJUNmm
	S4P7NuF9R9yT/THkiGi+lTrU55SL2qsEtTXP7PBuzFd6AO0w1qkwB4j2LjT3pH4t
	67sULGkvzwVpxeyRqphlSyQa7R8W4SEIIrCHmvMOod7TmvUm0wLx5F5l40Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792581880; x=1792668280; bh=uxXa50w7qYXBw54b0U/Qav8kbOTE4eXJucg
	B5nCCNIA=; b=DBgF8CmhjnzJBxo7P5fUDgXOJXzKB6V9BI/w0TwMPGpJLC8pMUY
	Li0R4jS8MZynt9ZuHPauM+3ILBip+XYtknMTSUsM7yG94HpyTrWCQuhL6mqVsu2S
	JocJhSJT9pVDRsUdESfUL2UPzhS8q4BvX6AwETQm+cglv3E7PczX3skUXKida2xo
	O0IaU4OenHL+4OUpn7U2mdcKVb1jEYEAJf3lT31xiZrLCHa4iswZGBJIsZYRkjQL
	s4i8CWicjT/kJx4cBMzwEVnSE9slef8gNG2StcbgHjHShUENcyFKI4m27Zfqsw37
	JeT39gyH1uL7S94ioA2t+RaaqBF7BlxGRUQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792581880; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RKAwpIFI/MlisgPLOQL/ivIg1LlcFkIeauWDK7TIcZFN7mD
	iTSW2hDJDxkCD3BBH0/Hd3tHcCzOmd7Jux2E1sRDAcJFySI9YXII6ZpEFWt697eL
	t0j3NeRRnmi+4aL8UAX9ZMus5GJ+flOL+BSbW0tzs8s5iD6yc4zNwG9ZQt8gol94
	a0bsZ0lsqEJqGWsW2rz6P9zm4opjmjk/rCMDw2PtuRuue6+1Pd5kFckFgWv+J8ny
	5A0TbrHyMRW0ybBWCIHw4AgvaBNqdfzjk0edxKEwB8CJAZaRwTbsZgjxwBh7n838
	zUW3FiGfgoOXYMzE8Fd2NFbQsyk13JIsCP47NOg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+lWJ9DAXs7p853qtO7TRkEW2+p2z7azu50Nac8sVXwY=:s+RvXP3Pg97sZamoLxK1+zguKORH5pEV0IfT7FSvlok=;
X-ME-Sender: <xms:-KDYalXoXOZeCBkxfODmCIBBu5xxnBNz7wvdHEQNI6-beaBirwVmTA>
    <xme:-KDYascw1I0GIMEQ_ympumpfwIWvET-QA7Se1LxBkXtdk371iUdYyWHF_htl6W_F8
    PIOFbt58Ros1Ozz4r6jsC-F5sqOXAeK6c2vGSrQ2hwW0-y4pGmZ>
X-ME-Received: <xmr:-KDYapshsjNCPIMhDaFRYYwMPJ1G9kvbOT_pJ1dguTi0bVwZdgpgjg>
X-ME-Proxy-Cause: dmFkZTEfCUuF4Qb+27eZhqIByhoUfnIMgRkQWxXGPIEnbuO59Aa9xjSv97tTMVF1y3GNrW
    dEm1GCoBnz3WnCriv7it1Tb9I/aJfAQ/GJYIzCpvn3CYSsxfop2zY2UEjCYGIIWa5RZ/af
    +bIuZeR56QSe9PuFsUmxZWgMVpatZP4NngpNJH7nM0TSAR2zOtjFvzs16pEZtkRGcArdA7
    dJ4j6Pz7gTkAWQbdkhBxa1N2sJZ6MJnI3G05A6YUMeoXT0VsW1HMt1PGGIZxPLEKy59Pq0
    d+sxmLjmJzq/1h4hCm8HaVX3kppZcfj/0JMvmQjL36btzxaghEfAdo7PtVisDFIkSHXJO3
    /eYwI0biSHemzUYRcXROc+JZWr+iTf5OlfTz6sjYljAWuYX5cjKi3W62FeGk3sfjduAnse
    mMJ0eTT8mvea70gGEZDHJ72Fd9lzAiV0oqPnS8HgJNs49ybG4HlxG9HJM9qUDBWM4aUr0h
    WQGKfADzIoPdlipFfDAHTw9oFFNDs0NLJDryMwPdJPvmQI8O15WGlBSgcyz1ffyp5AOTeX
    BgEueRqAO6EtV9nlXbc1GT6/EtaxVLWsRHAWwN7Sd0UtZjMU8Y/2AfHN6+Ekg55iXwmpKy
    C3H1+DeSeHi8T+3PLpbMiajDdu6c+uXzeekNINMygiErMr6zRQi1sGPHN64A
X-ME-Proxy: <xmx:-KDYaj-7jvf2_kHMkZJqHS9TndbjGKSbqZ9cjOphXSaRn39aqEwP1g>
    <xmx:-KDYas0QKhknrW0115HJnMC1FYwX0GvLSo13N2OEP1IGbybmZF8Fbg>
    <xmx:-KDYagCv-cjdLBTeY67zZ7tKiCS074WjV3DXUsayakTOQzMEtWaS7w>
    <xmx:-KDYagfLwo8vZQlaAty7boG1I0XdEhdK71G_G2HwEm_oVTMbEgMYwA>
    <xmx:-KDYalZT6vf2K02W6mafln_8Ddc3JlRdWANOJLXEaVcJkCjybvCO6BUX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 07:24:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 644a7495 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 11:24:39 +0000 (UTC)
Date: Wed, 21 Oct 2026 13:24:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff: use size_t for the allocation size of
 word-diff buffers
Message-ID: <atig9JAm_d-1CE0p@pks.im>
References: <20261021101640.329990-1-gitter.spiros@gmail.com>
 <20261021101640.329990-3-gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021101640.329990-3-gitter.spiros@gmail.com>

On Wed, Oct 21, 2026 at 12:16:38PM +0200, Elia Pinto wrote:
> diff --git a/diff.c b/diff.c
> index b4ac17f8ef..9483931c05 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1959,7 +1959,7 @@ static void emit_rewrite_diff(const char *name_a,
>  
>  struct diff_words_buffer {
>  	mmfile_t text;
> -	unsigned long alloc;
> +	size_t alloc;
>  	struct diff_words_orig {
>  		const char *begin, *end;
>  	} *orig;
> @@ -2192,7 +2192,7 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
>  		regex_t *word_regex)
>  {
>  	int i, j;
> -	long alloc = 0;
> +	size_t alloc = 0;

This is especially offending. I double checked that we really don't make
use of a potential negative value, but all this is ever used for is
`ALLOC_GROW()`.

Patrick
