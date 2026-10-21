Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581890;
	b=wgdKTkG77ph4qIICMiVFfs/D+3yaveeNltPBlY4/HaYp1CZs8oT5xjEKT7lpoEKxf0Ui
	 n5krwEGZmJWNNpm1B6EAN7UadJm4m8TKss1CNdzXLep+3Ak82qqsa9pYssIOhMg+WSWjg
	 qr2L+6DPlH6sXiLxrKvFAX+W61VQEhGDtFrSmt6wDnoe/KmrOPGio+xKxaaJk+eJ11xjs
	 EXUjMzCdk23t1KVRnuPka3LiCA+UQfwyoPjIPmJhgX2nrsJb33bU05b0CCK1jeJ59fXeO
	 dX3tAKLNH1kwfDDcGnF8/gOwny8JyWCxutXyIncnCUu1oG5PotEzB6n80Em6gVpQE0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581890;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mDqwLVpMpe0v+827D3JxU4tVN0SdOZtfe4LuB76KdDE=;
	b=tkyGSUSgyhFhEF9utP/JwNoJz3bHiXcQzaBWZGYrovgkMZVcAVPiCaovvDurad6/9VCj
	 EdeWqK6x6d0E3hemQgYAJe7Y9eer7u6UdR9DpG02ybXGucOkd22uThB2B/RtcyrP4Co+d
	 F2NVkWwrxWRl9xZmfz890BU+U6+tkxNoycfDULEmVVTLfXn/bmyYm7j4Do4dILPmpxnId
	 m9USqGypSZpwf5FW9dnFBuSGbaSioSE15xb5/iwVx5oN44N1nqQdCbxY+yYWdxFdqvtxV
	 Z0EiRGAYIhf9WRKKdlroBAF+/f8p9V1TBVEwKFZAWM26b4+UI085BW6p92sYUEgu2PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=rnEr4diV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=b191QcXn;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7317606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7317606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=rnEr4diV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=b191QcXn
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A54E1D00136
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:24:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 21 Oct 2026 07:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792581888; x=1792668288; bh=mDqwLVpMpe
	0v+827D3JxU4tVN0SdOZtfe4LuB76KdDE=; b=rnEr4diVYEAi0piGLlrpjgaBPI
	TpHyyomrf27cKOtuhk/eGeLYXzQXqgpWwfZfrCmsp3Ezu+18/ikjkJYVlyEVoW+Q
	1Fwh14h2ZwmVQyE50lNjPohCtMuodS3LbmUlYWHZiG5jFExfiC/FDDQS6zK/mIhJ
	1RiTCkw6i3Rm6qwcGQOn5svATn/nAgXlU8CH46aulzZPZI3aa/Zuifutcw+W11hv
	lDjhEzUqQoqPcyn58XOidDDj2lymkecTeHg4mpCHt6NKy2Et0Dd1MkwcP2WmcKg+
	HQ0ifsyjUM91bqGhFU3lVbHVB9WrdqtoLiyRvVcgyMRoZqfb/sl90sgGI06Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792581888; x=1792668288; bh=mDqwLVpMpe0v+827D3JxU4tVN0SdOZtfe4L
	uB76KdDE=; b=b191QcXnSbrG9rt9fuJ22mO66RM+GvIIAFzv2SkqgU57NdJexhG
	jDBSBHKtARWsQmcRvZrW8M5ZwbcoWoEC9DvLUPO59GGNgBOPuJxgLzzNEvWW9+m0
	JY+swRcV1qUlvR0WqQOuI1SlKr8gXAlRsHsZWZk9Im+s1S/2TTommTs2YJ4b2kXv
	/U5wHjplipCJG3WO4uSM7rxe0p6u4bdrEr/qvF7WBBg/kohj2wy1gjg4CBAYMLwr
	Fclc3D/fkMgOw5y8czOgwmvWpg9Rul6J5XRsYsxaUZwfBrbwLXSL0SLAN0NVYDGY
	P4AEG1x0pEfQJDozcrXXY+uhHCDeWfakM+w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792581888; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kLggcE/u8zzXyflejdt7hm7YQhDrOqxboG/xMkvHh4G1w6I
	x6wyrjdgeiThdNws6W8E34M166ouQLoS4B5wM5ywDc4p2gXWkqS3SQAJlLMiTVUD
	acTSysgHd74IkMut3ORFhEJHs4DBa15sdYtV6qSNTwqw4DNhT/B64AHb1INI8P2o
	pd2LppQXFPD6fLN4slzToEIiE2QgG4YfJuImDmo5V4KK7VUcNbTZO4sUx11hSRaF
	cCY6qL7dLMqmGYmkTOYYAIM1kZnw1H4nGfdonJTo6ybmd7ledrFlLarBi9bycr82
	0NI9On4s1As8jSHKpEfGvEX0kGewaxPcs03WS9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AHeoBMaB/AOeQ43+KWY4nyKPim1obsHmNhwo9YYPyv8=:rduGtOJAuSne2ACzLgx7rp/O3ijRtLq8mWITtAJyvTM=;
X-ME-Sender: <xms:AKHYaqG88p8hlK_MsHWHIlQ7AmgpeONP5YhJOoxtn4UoFfr_fSqGrw>
    <xme:AKHYaqbxp0DeqIxoUdFOpDH4ifvdi1dL-uYebCs-Yo_5eyx-tUaC6xu1ChKWo8pf4
    1Napkw7S-PkOMzSo3_IcCmnASIT6Nyeq1LxG3G3nEa2fMa-YWXCWRE>
X-ME-Received: <xmr:AKHYaqXFMbcgKEG6BkiKen4SZMH5USl1Tt_nOiO4p-7iYiy3xumYxQ>
X-ME-Proxy-Cause: dmFkZTEfCUuF4Qb+27eZhqIByhoUfnIMgRkQWxXGPIEnbuO59Aa9xjSv97tTMVF1y3GNrW
    dEm1GCoBnz3WnCriv7it1Tb9I/aJfAQ/GJYIzCpvn3CYSsxfop2zY2UEjCYGIIWa5RZ/af
    +bIuZeR56QSe9PuFsUmxZWgMVpatZP4NngpNJH7nM0TSAR2zOtjFvzs16pEZtkRGcArdA7
    dJ4j6Pz7gTkAWQbdkhBxa1N2sJZ6MJnI3G05A6YUMeoXT0VsW1HMt1PGGIZxPLEKy59Pq0
    d+sxmLjmJzq/1h4hCm8HaVX3kppZcfj/0JMvmQjL36btzxaghEfAdo7PtVisDFIkSHXJep
    D79v0FsfwQGqdVAKoyghrNvrJZ24hV8UJCNkKGhFnornj2FzGoTMP5RDbIqzwtIpFFwgIg
    /SPq8KtGsdbKYttAtphIxcVcclD2h9DcUp/FEsbmQMTtoKs0eC1IzOZxZRv2kXCpGREv/H
    n2w/yLTBnxrm0zVT4vJzyA8du7hibpHuHKBNbjmmFFoIPyuJw7FSqHhvgGwhqqdJa81rrs
    3VZCpkx8hztZz2IvyPNkI1RI2ZDKDXJVLBlrpc+ncF6szt5cjdt6vUC9k9dgadkAQuOuI8
    ukmg1yBKkg7em1EZYYkZsc93OMpyzorCD+8xFl+hp0F1O7rvKKOmDtTWtCHg
X-ME-Proxy: <xmx:AKHYagmDyHbqRdMnL_rmb_ZFpo3lAExnvrEtrtlAp3B1Q6jtvVen-w>
    <xmx:AKHYalBvpHtbYpe1Ba6xVNfeRIW4itYZwUstugE_fxMdKJoR9Kl6ww>
    <xmx:AKHYavhCfT8YfAzcy5dcJDhtSQzYi2s-e-1MxswzSjiwnEuw0qTa5w>
    <xmx:AKHYaiyk4-EGII0FLfZbzEbqqWEEe9Wr-wtKAqBOZoOEyEvDkN62XA>
    <xmx:AKHYasAWBiwOrXjYLCRTVc4HgyErMZvH8k6OmucoYFW1ks3XbK-alb2E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 07:24:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5bb21eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 11:24:46 +0000 (UTC)
Date: Wed, 21 Oct 2026 13:24:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Shuqi Liang <cheskaqiqi@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH 3/3] convert: use size_t for buffer sizes
Message-ID: <atig-5kJzKHZS4jj@pks.im>
References: <20261021101640.329990-1-gitter.spiros@gmail.com>
 <20261021101640.329990-4-gitter.spiros@gmail.com>
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
In-Reply-To: <20261021101640.329990-4-gitter.spiros@gmail.com>

On Wed, Oct 21, 2026 at 12:16:39PM +0200, Elia Pinto wrote:
> diff --git a/convert.c b/convert.c
> index 036506842c..ca5594cab0 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -42,9 +42,9 @@ struct text_stat {
>  	unsigned printable, nonprintable;
>  };
>  
> -static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
> +static void gather_stats(const char *buf, size_t size, struct text_stat *stats)
>  {
> -	unsigned long i;
> +	size_t i;
>  
>  	memset(stats, 0, sizeof(*stats));
>  

One thing to note here is that `struct text_stat` still uses `unsigned`
counters. Is this something we should fix, as well?

> @@ -1077,7 +1077,7 @@ static int read_convert_config(const char *var, const char *value,
>  	return 0;
>  }
>  
> -static int count_ident(const char *cp, unsigned long size)
> +static int count_ident(const char *cp, size_t size)
>  {
>  	/*
>  	 * "$Id: 0000000000000000000000000000000000000000 $" <=> "$Id$"

This function is counting `$Id$` markers, so it's rather unlikely that
it ever overflows. Theoretically it's possible though.

Patrick
