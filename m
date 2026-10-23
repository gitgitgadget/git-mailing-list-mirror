Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756814;
	b=XupIGp2pMEfvhpEvIMcb+yX0r/X53h1076GIzVyF9khRxUFRd+6/rjwf7c3G8noYhbDJ
	 nLJ7OO4FLq9vqUM4DtTEqEoA7nwi0N15I3X1NIpWXTRl7iXNqfWk85fMEFKUIuAV91Oh4
	 NFCPc6HzSwJfWnmDzxFRd2fN9zrZUd7km+rmZ5SdXm1QPKrDwGQA0umNzB8Wg0ZVD/LTm
	 cSpIH69F/m9YdaZL1Guoxx3L6RA7KsjgTc9a1o8EB5wfI9vhI+qOmNX9kojD0I9mWH+xe
	 iDIiVfPZ0m2pE6CWA6t8ZaVCQeSETfvdORojMi/4d1pXB9Gtsulng5A9A7L/ujt6VNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756814;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Gdq4U/IMvFoMphqyyBVuzLS1hG3rMvurgLzdRA/Kbi0=;
	b=H2mpe7Ug9Zy4gLL67XKs7XvXY+VhZXcbJPnpDSJIzH1vTC+lcw1kxYnRfB9gt54X1x/z
	 bqF07dV2sJpVnsYmX2x0ZHx5cLm8UWcIZTz3QJ0eKGKZnoyzUN26xr72M+CjS96sVntiK
	 mUhwUcDcmQ+IWiaFt/foBUsSs04CmAOsVrQkvlJadr0PYc5BcInU0SawI5njd8m9rkKUB
	 yjg5mScqINM9+Ovm/9IRA8tkmiHt31zy8V6tQaheBjDs4Y2peU9R5/KjP1wLlN1DeBxX7
	 Mlp/DnfyHsGalDkkEUevwpr4Zd59aDywK+Pl2RxdzfI+4DBBQbYxlRpFbG8mQXJB8YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Ne2str6y;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MPBE25h3;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B11606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0B11606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Ne2str6y;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MPBE25h3
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F323A7A021E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:00:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 23 Oct 2026 08:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792756812; x=1792843212; bh=Gdq4U/IMvF
	oMphqyyBVuzLS1hG3rMvurgLzdRA/Kbi0=; b=Ne2str6yk7KCyRf1fENnHPOf+b
	cPh2UBXvcBb8IzvnVohMRiNwHRJWK7VfZCYYqIZpRjVXu1QXCQ2B+ewgJ6KE/ObG
	Q1WFL03zhHu60y/0o9NYCg85kzpVSmHCjO4QrqiUC76aXf7hwh6tHTMgOhCgw/QM
	0rYV67nLeGybCoPVK2W3PkmwR92ov7F8LZLPxv2XAUdAsFJAZnexVZ/qLogpmK0O
	Bv/qAJ0Yas0WUvfgQUJBQjiJOhim7hkdavOO6vYC/EjRj7Rwyo0NGDrXVTAIAzxW
	GfdUkyP8ZcyLhC8HXXmHZHsluYTJY8YRDRPtPsG7ZoXA5/yl45GUsfPT4wuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792756812; x=1792843212; bh=Gdq4U/IMvFoMphqyyBVuzLS1hG3rMvurgLz
	dRA/Kbi0=; b=MPBE25h3mMQeNpDFRMMYwqMXEaATmmA/1fxITOnlS6kLOb9Hi86
	1RLbKCIhCjoY3zK+Xy/XFdya1SveMXNWQcXX1bvpm5bbTmITwDE284PfDgWU5cT8
	Yb5bbnNFkv5LoRfuGMVGKt1FFqZJ5bd5+iuActHmQ6wgLDBI03YGvimMRFMrw6+y
	grW9oF7Luw1Jzs6ySZQxeOLq6T1ABsRnKUme3CTu9l5QOQmMkFelCcu7xVAIEPfq
	Ib0CWXX5r1AiCk/44T2VjxGIx5q2bRSZkWrTbLHqgYYpK6HXgnDKyhrTzeKoioLb
	vMaWIV29oCHGbr+3vMAloC7a4nT7QIl8seQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792756812; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iQQaUB/oLi7tW8x5BSHbgMJ8FkCx9y7vYt0xJN0qryRYdgY
	Yp+V7zxfXOPioDl57pCvxcC41oG/F5CMTH0rwlVRjXQIvmxQXMy2ZjOuwsbvhr13
	jgrw6GJ2uI1gImaIFFWuTEJJLLrbUxdQDQaQ8DpMYiw7OIu9GLlKDXyCOskSGsKR
	O5NxkgEbLiMEXMxCPhVPLwsrPOL7ATRxeel9vZRx8J4vXcUssGcNxfHEnrlZVvWi
	YeskZ427cU1g2gPYQ8MkhldGyEAXegFDaBK9G6OmAZ8byG/beGwnJvpqV0Gay6GG
	MMb5+oHkgOfSleEINgGle7Dv7UpoA16D0132Yag==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NoVqu680p9RBFvJiahtAzizL1zxrJI85hNVE3AU6tYU=:QcU/ozfoyW9N+XZYxHuP07Pi7VGBX5ScIdZSzn6Nqs0=;
X-ME-Sender: <xms:TEzbatQn6ymyG3Gp6tyy4KQ8RqdQWTreyr_Qo72Adm3YE2yU6b2_0w>
    <xme:TEzbatpThcnx37lXvXrvuyWw9iSi3kHM9FFabhsmpaWMXEgp1N_XyHnDf48BnOfha
    fr2ki6mS0pQpE7PH5ZLt0FAM1wqfqT3K0mR95caCSNacbrAxlo7PX0>
X-ME-Received: <xmr:TEzbarIiJZPo1InjjdNEx0WbAF3_GnBsZHuLjhfK3Anii3IlRKzl2NsTi5NEGatfszMOoQ>
X-ME-Proxy-Cause: dmFkZTFSnClMX7EzQUruNx75fbBJJQsMDOoe1kIyZOze7EG0u0iegAwIiRHErD4s6Hnv+G
    41Fg4bUHSGFOt0txDUCbVZtT0Em6M07zij89MKTnSJGJn7Ospu1/B9A3oiOmnBxbuDD4hV
    gvYwBBEhbIgc+NLKD3RvVT49IZ0Fivvlo9uVycloH9kyjY6oxHNtg5apm7A0iDJrZbvLYz
    1JpAUyAWFJPlMcQzHEZ8x5k5PJ5Foap43lVZM9YOG3zJFLYin9QKd7/7f9ZedezoriKknO
    2hClox222vCRnG4k6LurAf+eGqN151nAaAiSjnCOp9LirK2Xq3LAEhqWjMhqGDli1zOtuI
    4iw6AmLVzVH8JYbhri3iK8qkvfnDKkMza9tBRFNl8kG/NeDnMznifOueBYscOKMx4WiBwy
    5vSzU7NXnghPR77joQbcrrFl1QYDKpTtslDwoDzTnGStjCcD4zq6I4WS8kAQWjAvHNB+vl
    pBBDM5VQzg63cyCyhEyDXyOsY1X6ckX81yzZQb5++21/CC7JUJbmQkZRQKpYCmCBHMu30L
    XrWEkXDEJFhItMy9DOdmc3wp2CrD4El7vFXrEwIjO8nMSkAYc27yqQ5miul67fQtIPDMIP
    iy/9GtU6wR98bVByU4OOiNQB/urUHKOd+eJC5XjwgDTtJ5yXPGqmPJByyRLw
X-ME-Proxy: <xmx:TEzbagrctOHejQUyPtCsQ3i1F7guGxpeAFuhrczVaNuEp7jJDyqJKQ>
    <xmx:TEzbajxpAFJFA2xbgbhEJ3dH7nO7n-SkNpNqCu2eKStIHIUuNlFZpQ>
    <xmx:TEzbakMQBVgLJLrM9-mlj0AwgmtHr_vus7xrxYMzCYtD4NMnyUxJaw>
    <xmx:TEzbao5mwXR5FqeHiWhqfTiDOoQlBdtr59mqV-p0X_q7Q39cU6AXHQ>
    <xmx:TEzbatJlz8AkMU18G-c9CXXNf6hRk7yggwqH3ivOAh0JsI37Z3TOZsmx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:00:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20021795 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 12:00:09 +0000 (UTC)
Date: Fri, 23 Oct 2026 14:00:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Mitja =?utf-8?B?QmV6ZW7FoWVr?= <mitja.bezensek@login5.org>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4] fetch: advertise fetched refs when backfilling tags
Message-ID: <attMR_XBdfkO3SHx@pks.im>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261022-799-shallow-fetch-with-tags-v4-1-8a1c9ef399ed@gmail.com>
 <atsBbPi_EuhRdNmo@pks.im>
 <CAOLa=ZTe6zeapUBwF2cS=w_gDQzm08RJkezD-jm9aV=7j1u6KA@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZTe6zeapUBwF2cS=w_gDQzm08RJkezD-jm9aV=7j1u6KA@mail.gmail.com>

On Fri, Oct 23, 2026 at 03:58:11AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > on thu, oct 22, 2026 at 11:00:16pm +0200, karthik nayak wrote:
> >> diff --git a/builtin/fetch.c b/builtin/fetch.c
> >> index b2decc6cfd..9867e8c2ef 100644
> >> --- a/builtin/fetch.c
> >> +++ b/builtin/fetch.c
> >> @@ -1697,9 +1699,30 @@ static int backfill_tags(struct display_state *display_state,
> >>  	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
> >>  	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
> >>  	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
> >> +
> >> +	/*
> >> +	 * References fetched before the tag backfill aren't yet committed
> >> +	 * to disk, so negotiation cannot discover them. Advertise them to
> >> +	 * the server, so that it does not re-send objects we already have.
> >> +	 */
> >> +	if (fetched_tips && fetched_tips->nr && transport->smart_options) {
> >> +		struct oid_array **include_tips =
> >> +			&transport->smart_options->negotiation_include_tips;
> >> +		if (!*include_tips)
> >> +			*include_tips = to_free = xcalloc(1, sizeof(**include_tips));
> >> +		for (size_t i = 0; i < fetched_tips->nr; i++)
> >> +			oid_array_append(*include_tips, &fetched_tips->oid[i]);
> >> +	}
> >
> > Curious. Why don't we have `struct oid_array` as a local variable and
> > then simply `transport->smart_options->negotiation_include_tips =
> > &extra_tips`?
> >
> 
> Because `transport->smart_options->negotiation_include_tips` may already
> be set when this function is called, so we only free it when we are the
> exclusive setters of the field.

Ah, okay. But if it was set already, what does it contain? And is it
okay that we essentially leak the fetched tips to our callers now if it
was set?

Patrick
