Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353260;
	b=pax/pIvy4fhJToFml1wsNBBSOsLAQGQAWeLBNehIHQtviSB5fcq2QFRoxQRnV+sj46XP
	 d2gRFcJgPh8icO87W0imIFWDZ4eA1qKaNIRvSQwfTUs/HEDbFX+15b+A/5duS9DVXMIO4
	 b1Dc+CM16Cv+AXUAdMqny2nODOyVkaS4Qo9FY0faFysw0AE6i5eUhUKM53d+8u7OPW3As
	 xrJr1di8/K2l92tLaYyVxDKBP7q1ryOl6fN0n3mIz/PNnilM+nVuGVFqWWyXnLbOptqXY
	 VfYzKZXcYmDnxpkx36Vr//h+ILny9TTkxkNylW20SYLrw11k1pcpNTtVGUO1P/PpR5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353260;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=myZBWK3Pmo2ZFJNJnq5hbUgkUToXE62ZnccRo1HnLvk=;
	b=5Z/Xrlosb+P+zBp3OKTpm4Wb3h6QfZ5cmWjR06LKCf/GvNWo16AviilfDmAT8N4HPulU
	 Ob3EAHeJMkiaUj7FxHoTGIPkjR7lnpMfDcm3Rw30foeJSfglP167xzTOA0T48EAkdrrrk
	 r+qh1fbgc0r6SEJrtogxlERxxBPAYy4IoEsjM+VzE3NMSfWwrBMDsnl0WjAXF0BQraNbv
	 Nh9d5UCfAwJwbEu3qRY/Bneul3jBao41CNJzW98/IoftwqPXge57Y8GCDgy7FRCrNd7sr
	 goEnqDPo7+Nc7G8+can4ukO/4AAHhkBG8TOrVwNbhz1uzaPe6yYK5LIZ6aeGqUz1Z2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=X8JOFweg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WgzGwcLR;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34923606A31D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34923606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=X8JOFweg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WgzGwcLR
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3A1CA1D00197
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 05:40:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 30 Oct 2026 05:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793353259; x=1793439659; bh=myZBWK3Pmo
	2ZFJNJnq5hbUgkUToXE62ZnccRo1HnLvk=; b=X8JOFweg0RFMeThRbUHlW52SQW
	1LC5suHM5NtcCiND0PI6DRys5JDqYoAXG0pDuGeEjzeKAGSXxLCYpKjDZnQwKeSJ
	Iwg4q3SdtwX36MPRHar3BpyGbrPuQ6dpW9/+r3bfUF8kVwX1psq/JqvejxCqfifF
	RIItspP1J3kD4KHVSOxUCYq0nzGvApks9jWlog6UBcDIvKozfkKwOUarcevALNAC
	m1iD+PsqpG85IguPhlaxynG/X5mxhYExiIsC/2Ytq3ZY/F4XkPCkeIclCGgQ0fVN
	CVYiHuNMZYAhYM8ExDMcUhhdXye63/y6UxQbw0WeDdPlWzfTkFH0GbqgzSLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793353259; x=1793439659; bh=myZBWK3Pmo2ZFJNJnq5hbUgkUToXE62Zncc
	Ro1HnLvk=; b=WgzGwcLReKYZ6YZIbsouvITPQFikp43K58AB5sAO6ASh+E2OM2s
	/VIx92CvIISZEeniHP7pxZ/z/0iE6kG68ILxyBsETqv2aywVxMfiEYXlfL9jzn83
	eMJZF+RzDOraONB6K5sIfpzsls99RuxlQebzZtGRljhOUh+jC2FlHXkSbDXKFpv6
	C6c5QkGopqi/dgI/HssFrpLpvulxaPrqBEm0dE74KWYwZ8FRQP39Si5th6VklCA7
	z360gNBkKw4QcezG4HDert5gNPvj5si1BpMLC/7s2SyOm4VSYcrnAiISKM1K9lgJ
	M1jEeorCnIlnMOOUa2LT3rTA6GfXWZmLCLA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793353259; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bY7Vvg3K8RX7vHfn40tbXu2cnB6m19PvSueiI6W44dXwVWv
	E5Ubt1yrNnx/U7Vp/yWeV8ocZUmA8b/oYKZH0UMgGaoXPsiehsC01WXYizanUqNH
	Mn2xHNkYjzSYAZkoL40VJRZKF18q1uQaciXufFj6fJPWEUKRs3coh+wPUgCoVrW7
	jvb6HzhxlYrJ6X5akdJo2RpAT4UlyrT+CgyOz2R4J65mstFbTCjZpPcE6HGQ8Fmn
	PTUMsM0aVoNowVsjSY+X8m0F6zjW+oGr6aF3QDo9OdkYV7133zFi/ebeWtHoQZxb
	AgZe1wEC7OQIy153mqcith71jS0G/ts84/AjDfg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:13XLHWkg8ANEaL8+Lm47Jn7spTNi2ndMCC//rAeLzH0=:uzzJ+xtDauAjaQ6g4N6dg0LMjwjH9sp1K1BruDoWB/U=;
X-ME-Sender: <xms:K2bkan0_Tuwp7ll9VkBhflFnJ1q-m9fFbHpb_HtTOoHTPmrkR95sIA>
    <xme:K2bkatEWxjpKDblGiml1ClBlRArbiqIvvwVJNnzdQ0ZMioHDRNT8H5A5WRUk9AYlc
    yYORIvtMKUUF4KbAtrwmr8ZEAgvLuI3h6oKCGlNf0KJHB4FQ7PQmSA>
X-ME-Received: <xmr:K2bkas6KbbOSSBc10rDS7Ccc_RawGsUpuK26kZmgNAoI9DYwQ8h6zlNfThftydWvWlLrTw>
X-ME-Proxy-Cause: dmFkZTGZS6QFozm2BgEKD8MDQ+PSZ9+tqMrCzJd/7348+rX0R/QD4apCK14zb5FUL7BDE1
    1QMl9/AFuAESnkDB+7q8AELVtACnWNauoEA3XyQHfoBZsw4Dheunhs6+40OrjTmcxyYyB4
    XH+vkdP0qSExHoSlkhoYU6a1lhkNy1+hihwzbxg3XL0CFTBmE384JG8q5Bdq/9DxmEa6LX
    QYONrMn4qSAtZiCCKzFvWG2F3bchapvbVfrASDSF79rAZZCwwkVD9s9tz1d1qIaLwnjTDP
    HbalDQOpftoqzJMvi45WWX5EfzWk2Uc2SUXyr4Q2YqfSO5QPaS2Li5xoq0NBM5pQsbTwhR
    YeHV1Qi3b99YqU80pXziGzMnVmmAjRjH1j3CVqHPKdG+pFTfEZskTihPJ5/OMUV4aYqb5d
    CcRhvA9mrnpQvEWfM6jCq2OQ0raWZ/bYF/GPQPrGC9JbOD53zYG51bEAQl1smPbEXhXeih
    50VPdHIz0HUIzsgib1pG4G1Nea3BF12LiwKjwMccSbOAUHq3ubjI7rSRnr9plhrDNHC4TK
    znstK+KQh/XOce080BwXHYh/tzRrtg98RRhTme9lTEAElydhw57lZd6OhG6rPdYVbW2ch3
    rpChhO1tFvVlK7uLM4AzDDkQiYu8q/P5oLU7OAz3MEKk9keVMh7SJThBp+TA
X-ME-Proxy: <xmx:K2bkars7YUPGyHQawAZTFh1yNyQYWJDQFLL4h9apjT5iboy-Cne_9g>
    <xmx:K2bkal6mtfP6mpSR3DypZwsPgzOIUuz-XiV3PYtWaJbmHIJdrAPCMQ>
    <xmx:K2bkauWXDikchw6or7Xyw0SFhAyuSXyP3ZL_kw9U1LPgMaZsuxmM4g>
    <xmx:K2bkav99tbzwppgSlSLemziF6PkNKsHvcQEZQikKFC9EvIbti7E3BA>
    <xmx:K2bkaob-zmL3n4gM1JUOOhBgMYIJ-6azIbjuqEAs7N31x0aRuJofahUm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 05:40:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d9d975d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 09:40:56 +0000 (UTC)
Date: Fri, 30 Oct 2026 10:40:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] notes: do not drop notes written by a concurrent process
Message-ID: <auRmJRKUU-C4mVm6@pks.im>
References: <20261028-fz-notes-concurrent-write-v1-1-3d513e1fdbb7@gmail.com>
 <3c4f3793-07d4-47c7-b503-13a6ae567147@app.fastmail.com>
 <xmqqbj8c2wk8.fsf@gitster.g>
 <DMHMEOZ1ZXRI.TDMEKTJ9W325@gmail.com>
 <xmqqzevwyyi1.fsf@gitster.g>
 <DMHO3TPL4QDJ.2G50G0W2R3ZGB@gmail.com>
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
In-Reply-To: <DMHO3TPL4QDJ.2G50G0W2R3ZGB@gmail.com>

On Thu, Oct 29, 2026 at 03:16:01PM -0700, Farid Zakaria wrote:
> On Thu Oct 29, 2026 at 2:42 PM PDT, Junio C Hamano wrote:
> > "Farid Zakaria" <farid.m.zakaria@gmail.com> writes:
> >
> >> I felt confident reviewing the current patch at it's current state
> >> (AI-assisted) and I do concur that it's a net-positive change in the
> >> interim.
> >
> > Sorry, but I find the above very confusing, and I cannot figure out
> > who is reviewing whose patch, and who is concuring whose statement
> > that said what.
> 
> It's because I bottom-posted; I thought it might be easier to read that
> way -- I guess not.
> 
> I was just trying to say that I felt confident in my comprehension of
> this current patch, and agreed with Kristoffer that it's a positive
> change as it stands, although the algorithm could be improved to handle
> cases with different branches as mentioned.
> 
> (hopefully that's a little more concise and clear)

Are we talking to a meat proxy here?

Patrick
