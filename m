Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794554441;
	b=rD/BvBKiuaFvk6scsO08uXHav+TDizNbDJxGZAgMQ4SITjdD7mlS5eKCUQvtZd27k31I
	 jpV3ijfBb/Nj3KOFSUV8VSciVTUCcI5bNaohPosDD9DC88VFcRJ97LMelo0aTXCoO4KNN
	 f3ryM60Yg2UWQK1iFzcF6SQun+65BnXYVGibgne+OZ8erEucGJrPc9L418H+d/5ruh6cw
	 Sw6+lXm5Te35CNbDUiVjMkZQ0hC9x1AI5RnttIKjiUSTyFgR0kjFjNCOslCiUEyKztWOs
	 6+Kp0qurGZ/Cvz6pZ6jgT836fkesen5vGPFckUzxsRygAoJ5NT8FPVVi3BJF6UjtaHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554441;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NQ/nP/tztY2Yn8vRip4m/y+Qfdhqk3w1irkTKa0mi3w=;
	b=CBYkIbMyrDDbSmIe5FV3QkeSYA2Gw7Qg/ps/OdvM+IBkpzBQDz+NnYpLCCqo6vajuJlh
	 22uY1gMOKwqchb1hy71NLGc32Ce+/SHdMkEpOTrIZXpkOQNOUNWMdKrfCENtC9xmz3fBD
	 Sa7imnVJh57NSnrFOG7iuaxR5aFxaLqVcRCMWR8Ny87mvN0wdYi4GZKptVBk0S9uj1o/v
	 BB86S/a1CcZQtQ/ZvaF1P75n3WxdUS5BgGuw2mQ2+I39ccRsCGwHLpBQiKBwXnZxcixMy
	 t65nflmltSJ2vRAric0Dss7/ZDdHig0OSuHokMjsPTLk/Mhv1T7xuZBzzvNKWQhZrAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=k09YTgFT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=en82TsRW;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B49606A321
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 07:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B49606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=k09YTgFT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=en82TsRW
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B10BF7A0390
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 02:20:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 13 Nov 2026 02:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794554440; x=1794640840; bh=NQ/nP/tztY
	2Yn8vRip4m/y+Qfdhqk3w1irkTKa0mi3w=; b=k09YTgFTVm7xf0+p2vEhwHTTB5
	Zi8jlq2URV+5OLQ86hJWfoc+eM44F0mz3zpQNEsGqXeHumsent5tKMUzbZcRcdHu
	5vyHvYFuo6R7Iev35mZf+WpcalHfG1czAbQQQ/6qemSICijgsKUAPy15ZJq30gKg
	d0vPSiOG4CO36Be7NpHOyFjnCTO+RFIB56HK7W9QrMWcqODxjCyWF5Qyk/y4T4l/
	RFlBYBUUNJzWEV8IkVCH8McR2K56+qeUY5pdpD/mCUArCYCe2KQKHMD3Ma3k/AGx
	wTajUuFO4XCrLWdSPgjHSaAAEun4tXY52XEIvmqO/By+zcAKOtzFBVqB69cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794554440; x=1794640840; bh=NQ/nP/tztY2Yn8vRip4m/y+Qfdhqk3w1irk
	TKa0mi3w=; b=en82TsRWDGApj3mlsIOy/lPwnouzu508qg2oMvU7DcNVdF8xyV6
	yQyoGf1DS8r5X/YZGdWF+33+fh2qnOcmpMTlhQigFgoMiMjP85J0tx6fsLN2/JwB
	lDE7lL5LY2d2Dq0kKdH3PgHhE/qXW+5gH/axtBMUjP3nZi3fvkmBmJHOcGJ6Xipk
	q+HttWWx09Yl14Omif+vF/xh+8Xh7k1/FRFw4Ptx+v85omXo8aDxGKxsSaIPnHTL
	rE2RLqFVUtP+932Jw/4h3oJUn1SfKXMYMJa1H20wQeRDDVN106LT9VAZET1mRtwk
	T8SrXAF4vKC1wTGz8Hra6wWdkkWCPu49wGQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794554440; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Au6Y/VB9BzREJU8TLVU5nl1KAlxdyKKuCuCNtKwITtVjlkZ
	ngCenoP7Ldp+ZcGMODVM/LbDwgew02gDd2+AndbEI94Xjm/XOMvXpnRFZKD+y5FR
	X0LieJcbGbLEu5CH1dNQAfF6F0g2rfXI/xGS073/fQNPBD7SG4MzQp9JK5+ZNH8E
	gZyAofXq8rIk63fmKy6aFFCMHLkn4jAwsFc6D/oeke0K0vHtonwnblCc2usYdo8w
	g/8Yi9znFhZiwIYshpSy/puHmSX1UhKjyKZ8vGqLr5OakYuTgUnODPFcSUEj+DP2
	EJSrLAqE/FsCoMO7GQ4PyIRn8fYodqwRGwiw/ww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Obt56q+cC5yTN2bGNAmEEoWe9rvLAvgdcct2Kf19p40=:09zHwKIYUyWYsmrbeYtlAVu93xe6W9QPVUn5berjHdU=;
X-ME-Sender: <xms:SLr2aignJYPfIFeyXI6rta8_SgIEH-d6wwHYwLKh4CC20DMA0PDfkw>
    <xme:SLr2aqBcDmSmcGz8AZxP9VoGFlEt_R8iTjyn0gp6WTSCUn5bdeWQ8Z208aPmaNIm1
    KZMs3H2uTdGijiczyGb-TRCqbjtmHkxIFO5zTt8DMiKamcGdTI_lw>
X-ME-Received: <xmr:SLr2avE9vxIU12Dqk3rxX_tEE6vN3ACEv6tyk61quIvvnQdRxoJTPQ>
X-ME-Proxy-Cause: dmFkZTEZt4STwgh9ytLNvFNQk+8e4w4lgD+RL3+R7XAwH1NpQC0LSclUFN9xtA3w1rvf72
    omr5STRopdjBHw/KVqVx1btCfdBHOg81Aa3BFda3HNsjC5+bL7Vm/2bFux2Fu+ZWtGjgXY
    EJIeQmRCGu6fXnyMe7XPzTLeSJqv2t8mRp55irqd+ubWgcvx5YhDnrKYk+3bD9aNQ9QkaK
    Jxj8y9T/DyvUlHYkmdo2hcRbWk6Ds0a5oCNxFCRGHcKMj9bxhi32P4++sqSqn02jf97Msl
    3K0rJmzaOPRpuOEddDz4/Zg2bx5ziPxeqlkey+YlSBU9LYcEoQ9X7NSW4Na5Ob3GI4Mtsq
    B+dxMJiapHvO84eEjrc4Ab9E3EO4eapM+oNNdfUDAxw3NDARIM1Bw1z8dqwGHw7NhkvqEO
    +bkB0wbuJFdV/GYInKcNr4suydWbjIXTEwcNFaXNE9OhMhkNoV9OmobUg3t6oohUxd1Cln
    s/A17otloRa2D6LDhqr5L5Bev1QMJeLndl8vQTT0rPocGVgEGb2zQgEtwEsyQ1UL+sms6K
    7n0MrA3i2tPrXvjFLs+Sf2j5SZ/IpT4ygTZdXZqSOa/8mQB+oW2EkGTInPA0n80r/BrMlv
    +RSVx7aZtKEh+vPFdELKNQ6ISLNjL1/so0O9vIZVbO8jwQSnWU1sKbUmFq/Q
X-ME-Proxy: <xmx:SLr2aqLzX74bGgoDdXxb9mVxKiIkkdY2QQv3SEVb9gjOLYh8hLw2uA>
    <xmx:SLr2arl9VwZTrcAIlYDzKQ-eCAUlcqDt0tHwO-eJHhkir_tlpFb1Dg>
    <xmx:SLr2aqQLV_EJknQmxmfvCoTbVrl2qfDgTucTL7uGUQNuXxi_AWNtYg>
    <xmx:SLr2alJgoHGdJc-OImaH_lMDl4Rc4xXCc-zWw2UAwtwLTUnFcuyvdQ>
    <xmx:SLr2amnbD2dG78SegZLqL0O1dSaJ_iG4eyODXN95V9ja0cNKxu6YGdL0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 02:20:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42191628 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Nov 2026 07:20:38 +0000 (UTC)
Date: Fri, 13 Nov 2026 08:20:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
Message-ID: <ava6Q1u65ASVeth5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
 <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
 <CAOLa=ZTAYtq0K4YfcSBocf-fxadTiaJp+AV5-_6_pbNMBwYQXA@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZTAYtq0K4YfcSBocf-fxadTiaJp+AV5-_6_pbNMBwYQXA@mail.gmail.com>

On Thu, Nov 12, 2026 at 05:41:29AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > Range-diff versus v3:
> >
> >  1:  e9237465706 =  1:  f669dc6eddf rerere: rename `repo_rerere()`
> >  2:  94d91a0620d !  2:  4fd3f6aa650 rerere: convert flags into an enum
> >     @@ Commit message
> >          around as enums so that it becomes trivial to see what kind of flags are
> >          expected. Adapt the rerere flags accordingly and document them.
> >
> >     +    While at it, detect the case where both `RERERE_AUTOUPDATE` and
> >     +    `RERERE_NOAUTOUPDATE` are passed. This combination does not make a lot
> >     +    of sense, and it's not obvious which of those flags takes precedence
> >     +    (it's `RERERE_AUTOUPDATE`). All current callers know to only pass one of
> >     +    those flags, but let's be safe rather than sorry and `BUG()` in case
> >     +    both are passed.
> >     +
> >          Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >
> >       ## rerere.c ##
> >     @@ rerere.c: static int is_rerere_enabled(struct repository *r)
> >       {
> >       	int lock_timeout_ms = 1000;
> >       	int fd;
> >     +@@ rerere.c: int rerere_cache_setup(struct rerere_cache *cache,
> >     + 	repo_config_get_bool(r, "rerere.autoupdate", &cache->autoupdate);
> >     + 	repo_config_get_int(r, "rerere.locktimeout", &lock_timeout_ms);
> >     +
> >     ++	if ((flags & RERERE_AUTOUPDATE) && (flags & RERERE_NOAUTOUPDATE))
> >     ++		BUG("RERERE_AUTOUPDATE cannot be used with RERERE_NOAUTOUPDATE");
> >     + 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
> >     + 		cache->autoupdate = !!(flags & RERERE_AUTOUPDATE);
> >     + 	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
> >      @@ rerere.c: int rerere_cache_setup(struct rerere_cache *cache,
> >       	return fd;
> >       }
> >     @@ rerere.h: struct rerere_id {
> >      +	RERERE_AUTOUPDATE = (1 << 0),
> >      +
> >      +	/*
> >     -+	 * Reverse of RERERE_AUTOUPDATE. That is, update the file in the
> >     -+	 * working tree but don't touch the index.
> >     ++	 * update the file in the working tree but don't touch the index. This
> 
> Nit: s/update/Update

Oops, good catch. I'll refrain from sending out another version just to
fix this one fix though. Junio, I'd appreciate it if you could fix this
up in your tree. Thanks!

Patrick
