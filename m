Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885250;
	b=KOi25kSjgzp6SM6n2/Dyc7Raq/EPUDwTSXzYf87NHw8c1lq/6nW15TFfZSazRKR6N1cc
	 xuDg8F3GGYe4d7a/ILs4k7LsCkgYd35kmvrIdkntvVdfuWsyAoedUgXpGSEROBPTL/nvO
	 Q+xZJuCMkreaDiVzf6TzW84QdunM6bpzR71p3UE5u/hbAqtcxHraSXwEqXsdAFFMMxDAc
	 kvXCy0bLH18nyiyGMyv7ZQxhMmEQEAwUjwo3l4ud9zffPPtnQPMIsKIF9Yp9lRA+FYEH9
	 LGDKW+QRDiHA6eDMPLAa9uJV6ufyiIoUvQDxWSO3llipBVSi+KudFijSOTR/hH0CENw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885250;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RvvZNhZRuimYX+S9axEXYuzjePq42BQRFrsOkAazlWg=;
	b=cl8elhIRfkwsiJT/DTwG/1WFHtZ6Q6XuVjje5LVt7bJ/hvdkEh0y3bBxeJlUo8mAEGw+
	 DOH2X6//q76bO4QNeUPIUFtx8aXJTPrIYhovVStXaLk1Ydud1j+hqsjNk5LaMEovNJoXp
	 o+DdmCNZTWmB0knjRVurObptvmH4Xe+DEDrbo+E4bCHlZxCOYZbxC6k2FpOIG4L+0insw
	 yTvIhgg34usfQZKNebPf7Wi0IVuFVZW1JePq0mEVPg18A2Mkf3WTcjcL3L5M1CsNXwJva
	 uBgmAnYjahXwAccbSKkLdgNI6TWdzyBiLQFB3Z65QTbhRxLgAzS+xIzYXWKQhDWUTGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Wb7yg11h;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eb2Gk3qQ;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F215606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 13:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F215606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Wb7yg11h;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eb2Gk3qQ
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7071140010D
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 08:27:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 05 Nov 2026 08:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793885248; x=1793971648; bh=RvvZNhZRui
	mYX+S9axEXYuzjePq42BQRFrsOkAazlWg=; b=Wb7yg11hiiteC2s36mHvF275m8
	54H3osqZJ21VDK7gBPZDoVoC82zS8vRjkRd9/ikyap2DvlZJBAe3CqzSajP1+HxX
	L/FziHA+55LRp6rGp6jDE2dMHdoLyRleY8alAPPGlDWtAjdg6Jg8qJni1K4pljyr
	bMmlirdIM0dyZWwwGhghLl+k42msjmRVDh8LUR9Gql5fnI5xkDntmTTxvmQswFol
	WOn1JZJaW99LyyaGobCk+3Bird5FcQFOnIBH4fmhyy/8JsU/VNyU8talftWU21I0
	4GGfSsMLcDBMffdzRXcyumBnbNNT78fJiCIdD7iVg3qqQ4L8LFwW9v2vzoUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793885248; x=1793971648; bh=RvvZNhZRuimYX+S9axEXYuzjePq42BQRFrs
	OkAazlWg=; b=eb2Gk3qQ2iZSGpJq5eULUUzuAFcfGxfteTTJ4e9H9247liJ7a3b
	MVSbJkogo5iZGT5jdsdmg5C1Ld4rZam6Nqv7iWxJfRnIGIy1i9qGAogtINttuqSi
	JO98knAcQ/dAcPXXLjNneYnr9TnW9ZUWfYDjJn0vkTjJDsvx0A/98vozpYJIp/T7
	0Xk+7RbBTj7NGhr+9FqNTLM50kO10pxmsblQwieTPruqyG2i8NtLb5NJ85NfIpO1
	f5+3rmEUyT1v8Oujy7ueMi7JUSkaMpfnn8bS9p4364GU07s/krqW0+qK79Sb8xBs
	ZlPs1gnQ9udCh84DiDQwQjK2zWTXpdcK49A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793885248; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:QhKAiEEBabYP7d+d+10A62cj+qqHBlGg/+cesSQviLxuodP
	7mjZEgrh/6qF12exujoZgZUlcV7BnG6+TstzhY2q2jufEuhfFcskkVKWAsVepRHo
	2NrlOpnEEDYCACrs47cAB08QF6SkBBAXQwlz1ZzY4eNCRGyp8EnFHOinnErnzFNL
	sCoz0oT0USFa6gWH1t/QifaErXn1Uoo+MyDnPLecRr45cKQhgaJYmkRLOxNS/qNJ
	vUUKuWTSH/R26/AkYiPDqaRNnyYV6lsEYj6njbp4JIn4G1mGZM3dn3I2taB4VLJT
	at6KE29PrWj+OUrFy7qDsTGt4Nm5TXxLlbvUs4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vHE71ZiR+ullD3P9sG4rkoJtDe6LN21JHpPY1DhcP+Q=:yPPsMRUQBnnOVTfNhvksMiArIemMPVFNSA/auRkxAi8=;
X-ME-Sender: <xms:QITsaq0wlSKgAzHRYyswoH5z96jnePOBEWuz8uq2tG2MPt6kQXhuKQ>
    <xme:QITsajHHUIHTp2ry1EiL8C_E6bOVsAwQ97OGcWObjqpYaQPsIejzrnuUjjKeHTbE9
    L_j-EvnBQwM8HO8yDMc1IhXJpc_Z1TugQYHB9jBNlglyv4sNOH6PQ>
X-ME-Received: <xmr:QITsagjMz_XsBIssRZxeRaoJT9gFw9I4USM9I2NTFSWf1WHqWUCuAA>
X-ME-Proxy-Cause: dmFkZTGPwQ0rMusrw8BddULA0SJWNRiKWgB0S1VeCgVMsg+AwrP8cR4QePrDpYDheVUOUg
    ay8HvM0osGEEcGjHv6itn/ky/UuLiMifX+h4v7cNTrw1+Im0FI//pdXXQ9nHZr12YdWq+j
    i6Cx3ZmEZtJSj4lQsHbfbjAb9aaoLNJC72/BqC2TCIfQijiMSOX6x2x9F+SX+qvxVXfD/u
    lzlHWMVK6pGdPWhfxhI/J/fiQhYz6ygw8/sErFrlxDsl+O1Gd8PgeXAakxyKxKlt9uRD5v
    X2gDkeZ3G4FbGUoyd7OGWB1vm6kQvzZFDtr1WafN+JXJUNCnleqMiD3ibzev6mg5RFlbfx
    GYciA6ILIEG1q291xeOq7gjeLDvAKP/v38r09zLMod3OsaCqOznRlvCXpQ+zBkyGwXbzdM
    BhJ1z1S+VsW1r9AKaL4ZlKksIdMwcP5Lkb3vV2ecQQzTpbtmEk+/dqgQ5u4BIQW8IJajN6
    wMGyDkbb0m94HnGXXkzzLp440GfbSuTiK1WqxEgKnQPe2ndtA3lTmLw/FIQAO6XUsIYTNf
    iBGDkpHHmGU3Ea2+Ckt74BS7IIZ1um8TsRDLxjNLX6sTD0GQni1gBfWFoN1LL1Un6DLkLg
    iGLUJlo3lULxYfvyq1fclH+/Ob/kFP7WCjnY3xJnFdc696b0HO93lBhFcltg
X-ME-Proxy: <xmx:QITsam9YA4r-cSulBX2_PTBBvcNNWnSkXEWppSHjLz2FbzlB4dopgw>
    <xmx:QITsavre-na2jajNpMwYsPLlTb_CMStpWjCTQAbq2Aq0gdqyyeX7EA>
    <xmx:QITsat93NQUMc6oOgoIspkmk6EMIyj7W7K8bAtCsILTePENmtY03jw>
    <xmx:QITsarUWnwCzcQYu13dszXpyZmM0xmyeZnzqDgq9wgtpwC0I1otzyg>
    <xmx:QITsamMZeU1DD99sDj1jI6U2HTQru25vdqqyyvLBTEhti_xk97iDec4m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 08:27:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b59a5290 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Nov 2026 13:27:26 +0000 (UTC)
Date: Thu, 5 Nov 2026 14:27:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] config: honor file permission bits
Message-ID: <auyEPBEDUziv4w8u@pks.im>
References: <xmqqbj8p7okv.fsf@gitster.g>
 <xmqqa4o0v76o.fsf@gitster.g>
 <aum4pZp5P0ZRC-cf@pks.im>
 <xmqqld797msp.fsf@gitster.g>
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
In-Reply-To: <xmqqld797msp.fsf@gitster.g>

On Tue, Nov 03, 2026 at 11:11:18AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Nit: a curious reader might wonder why such in-tree files don't need
> > such protection.
> 
> But isn't it self evident that repository contents are supposed to
> be mutable, and you are not even supposed to muck with filesystem
> level tools like chmod or mv to begin with?

Maybe? I guess. In any case, no user has ever asked about this, so it's
probably okay. Not that any user has asked about the proposed new
behaviour either, as far as I know.

> >> +		error_errno(_("file %s unwritable"), config_filename);
> >
> > Should we quote '%s' here? The function is quite inconsistent, where it
> > sometimes quotes and sometimes doesn't. I'd say that quoting is the
> > better choice though.
> 
> While it probably makes sense, many of the existing messages in the
> same function also lack the quote.  I would rather leave it for
> others to clean up the subsystem as a whole, as I expect there would
> probably be a huge fallout in expected test output ;-).

I don't think the other messages would need to be adapted. We already
have a mixture of both styles in this files, so I'd prefer to at least
not make the status quo worse by adding more instances that we know to
be suboptimal.

In any case, these are just nits and I don't feel strongly about any of
them.

Patrick
