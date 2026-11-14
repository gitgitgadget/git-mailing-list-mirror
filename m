Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615372;
	b=lxgXhONjlvisGvJKWPEZxGZBg0zX3Lr6w+tiqc70LUj+/vXjMDY3aCxQ5B7U4x8lcl+v
	 RPJalIVfzJ7Hun4RiDJywy+ZNibEr9CYPfQuwIjeju3OBEz8K2UT18o4nxhWThrasp6uH
	 cV8F46mIQ12wITgwOVTbZIbi/6OR8fhy0WYgXI39bRpPtu1T0ffQRnnCMiHZ727sEUKNG
	 7aHMzGe+9QG03gkR0lNnjwUV0kQPJ/NVPZ9pj89U3gtxG/PLKmf3jAUTIvPbtiHohvsgS
	 pE372CO4NdfKd+WHcrDFkvk21emY125A1Th68Z0k9X1z1T5Hy/pdm2epYouHAbjY+2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615372;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Mh0i2eusvd4V3MdxsJvpVyqWfJMHAahNlMfLZh5gP4o=;
	b=voKLBKiPlB+UV6MiYFKWV84eBtHR13C4Ce6MXANaZhguoIsztcCFmzXj55kRAa+Ay9h3
	 5qyJrkN6f8rQshvYPbfsNPACarxSngdIu/Wq5ZUdVES/DQBAPN/KoQGURHBBqgttAAOoY
	 eD+gslGF49masABGFhUgOE8NC/qGev4PNVs2Et2B1jEJJAWJyQ811Xq33b+YHjlD+Fyeu
	 s0aFoAAerdFRIJkXgCbmI4bzRuu6G9dCyFgWpGWLNyraDm0GfWHHf+RXw1DVcCAJOTPYQ
	 dBb+XElw07m4ZCUSbsuHN03ZBwdyl0pf2qp6IgFIsaHam3HbaI+EDityLdldEj+lDNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fF7CjgFu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=scL5Kgwr;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E6B606A332
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 00:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45E6B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fF7CjgFu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=scL5Kgwr
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 851557A013E
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 19:16:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 13 Nov 2026 19:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794615370; x=1794701770; bh=Mh0i2eusvd
	4V3MdxsJvpVyqWfJMHAahNlMfLZh5gP4o=; b=fF7CjgFuTjo1IPfKmR1OEtCDgc
	sZFEAHjYIiJekG0mAgN/gmR7V/HZFFQuHRLY90ug20vQbhRMqydIhCQR1advUg07
	o2O4TJLNtsZaV8BeO90pCX2m+BJIykb+jP12Va/grYDkOdPlrtAa4S0hkdy/660X
	YfW2cTQLz1eC8EZM/20ZSzEh57Yc2HDlo0VJmEFwUdE8PzYdzK8RmBbhaKpefnOM
	Tnhv0QniQqsdB+G/Mn1UnyuDdhheylLSSQ3WEIG7sVipPLh3x4wWy/uV5X1NZwo9
	dMLTMyIsTDKtE+vee3nSdi72cFwGam7f26az0hTpV5vnlMj1/I9rcmmNwIHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794615370; x=1794701770; bh=Mh0i2eusvd4V3MdxsJvpVyqWfJMHAahNlMf
	LZh5gP4o=; b=scL5KgwrQKHWxF+mxZTVnK8RMR4fJqZmxqq/zF1G3guo/5BflvK
	KkJRMlLclOya6QojtiUnCt7L3CRQ7AHZx2ODkfhcmgDhnHeyT987jleWw0jogZEm
	nxCirOBQsPbqPub3rdN26GlPtdmjS1Pv10B++CwCG3af8pEZKtJB4fqtMbyK7Fj3
	HCGpjyN4X2+ntfvXhbi0SI5CHuI85UnLTDntvAeXfztdMXFJyOhLn5i5dfRL9Zhh
	9ZYSxdWY0B1xxUkOOPuLIlCgiiU2fXKwsRGVoQF8s+wiA8VWMR0wwXWyMidKg/4f
	b8uxt89oh3nf24NFk4v6rp4bAMP3w6Mn2nQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794615370; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mX5Yr+NVjGMyTAeqve2lqFfvnyEQFV/ToFUlBxOkAzOGjtl
	HBSuUm3cuuL/qs6v5KJjyPxntxfte569iDasGiJA3ZnJIMGTntFaJOZ8zIqj5MhW
	/CkZXTHWhbP9Bo5W4curRhRDtZQzJuP2gAXA/LBb/IZmgJzHgWXvsVJZWhmGpRTE
	zM8dLfgP0h+kC4/BSENJpTgCvLMCPaELtB1M91ABdbhiheNF2CJ0pfRDa0efyYGk
	HvYq7338sB6yHiw0/buOXgpP5NgYboT8Sjszge+tDZdG7mtpyaO2G57jSREV4Fk3
	Kr++rYErtDGuDGBII7dztCIhFlk63ozu4ZKnMOQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zByq3Xh0d4yWmcOAXP8uDk/qW73+ibR7SknHmbvRd4k=:EZsV9OHAqOBNx5sLYII8OCkNKvAeLg2uXi1pzaIGXLo=;
X-ME-Sender: <xms:Saj3apO2wZH2D7nhM19dljVaSxl7uxIzP6bTgazT-kihORW67n8JtQ>
    <xme:Saj3ai21M_4ibfXqzYTGHojEGFNB3ArdQ5zu42pb_znZfK8x59GSDruBgMFAvR4rG
    prXRZKUz26tVMFqcCAbbuoSpdUZVO27KHHGzcfEcTvVgin4F1hwKeQ>
X-ME-Received: <xmr:Saj3agklWV9v9t2LuujmiFqGNHcen3z_RWVG9acGzjGtx2_3hY2d0arjRskUjeAFB3Ktn5FBNsPkzWM7rODjI7nyEUzeJNxxhzzX>
X-ME-Proxy-Cause: dmFkZTE/iPNAeIB6dvpDC++ZcF9Gm0BM4So08RRBAa9inZ852M3vPaO/yV2sYLh0nvw/kf
    qAO780SNcFy2EKmZvTMfOlpYRpPkC0hAFMWpM+Eh0yptsZXAoj1fdpWZocn80DMDllY6YF
    hDN5UaRMWvGUu5yHlvx068KBmwoUhDkYEzopaKC94s4V3dmTM4UmPIDGC/5EDtbwj+y+Dr
    xN7RmKxuYgU02y5JZ9cVeO1Kjsij76TCAZUYncnr/fEi0M4w4aPQsJdVlcKFABfQeCH3cv
    T4bYx9K8FlpURcnfjYaTKcEIvznTD+m4GroflPFnie4KPXrRffWBAImt+ppQ8fTo23SfbM
    wRi4zA8fx95LHSIQOTihbqZxsfIJEpxPJDMalOts3zX6BMiLr6jitcbCRt2uvHX2SG5Upn
    aGwzohOSdXwQUWRtbe+yNkdnspH0C00r97MqF087qYo+wQvDHPuJp9QrVoOw4TTFpUwwWN
    0Iy9xrmd9zi6iddLOsYnpkkeCU+8BJpt19IHO8V3enTCjVoGKirUP7RIIAxhuwCqqIX2AE
    GglR9xnTJ8bMe+coXEPlb1iXWzrZw0vImXUR3KkkqlatoyyMZV403v7xPTtQBKRluI2j7C
    vokBgD3TQGv4jeWGJB1/8lVJdPcCO6O7hC75WMApBWwHYGrVudymroFWIPMA
X-ME-Proxy: <xmx:Saj3ahUFKCh69DrefxWpXookU3XY4HVd7r6cDvZQA7zS6QGCHmmXMg>
    <xmx:Saj3auvEDChPLBbwUh9QOHfxKgC9ZaMnAlS4RPUReZJy-X0RlY_eqw>
    <xmx:Saj3asZT-9xMsxMmPS9H59zBSdqifdKfu5NSchX1FNGRf6ALPmIONg>
    <xmx:Saj3alXXByn9NdJS_MoDb_VXgILjcZjRtgpwzXCzsSOW3h7C9gvx1w>
    <xmx:Sqj3akE2LTnzL1k0MSG3cU8p8jtkui7HVlu0ITppNOU7CQ8l39-LIcrp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 19:16:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Adam Dinwoodie
 <adam@dinwoodie.org>
Subject: Re: [PATCH v2] setup: fix hash algorithm detection
In-Reply-To: <20261113221753.3408862-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 13 Nov 2026 22:17:53 +0000")
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
	<20261113221753.3408862-1-sandals@crustytoothpaste.net>
Date: Fri, 13 Nov 2026 16:16:08 -0800
Message-ID: <xmqqh5hk8dyv.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Our current hash algorithm selection code has a few different problems.
> First, we do not actually default to GIT_HASH_DEFAULT.  Second, if we
> have an algorithm chosen by init.defaultObjectFormat and we re-init a
> repository, we will change the hash algorithm, which is very much not
> desired.
>
> Let's restructure this code slightly.  First, if an algorithm was
> selected on the command line, assume that's what the user wanted.
> Otherwise, the other options should only be chosen if our repository
> doesn't exist (that is, repo_fmt->version is -1) or it's specifically
> detected as having no hash algorithm.  In that case, first use the
> environment, then the config, and finally, the default algorithm.
>
> Then, if the algorithm does not match the repository, complain loudly
> and refuse to reinitialize the repository with a different hash
> algorithm.
>
> With this change, we will choose SHA-256 in breaking changes mode and in
> Git 3.0, which is what we want.  Add several tests to cover this case
> and several others discovered along the way.
>
> Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  setup.c         | 22 +++++++++++--------
>  t/t0001-init.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 9 deletions(-)

I was somehow expecting a patch that would apply cleanly both to the
maintenance track and to the 2.98 but that is totally unnecessary,
as it does not make any sense to build and use the maintenance track
with the WITH_BREAKING_CHANGES option ;-) The point of the
WITH_BREAKING_CHANGES option is to make sure we have a test vehicle
to try out something that is close enough to "Git 3.0" long before
we release one.

And the updated code structure looks much simpler and more
straightforward.

Will replace.

Thanks.
