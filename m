Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793691173;
	b=XJ5J43HE1+X0nnwRw10eMW8mLAp49/phy0sL4yMXkClaNl2uAm3nXwOEP8wXNTnIkluJ
	 vTJiR9jxvlxqfmGZ6/NYjGFwY1TnQ+4i4DtbshIZJhyHCNtK3dCw2HvF1D5F6slZhjT9x
	 gBtYXKZHnO57IlHDF6XMoB5jeq1QZ3h8xO8SmBslM37wCUt3eGTzYeqMDTEW1EPvM3Bgn
	 f1PARObaXJSY3A3Mu2iIeAhkzfDVvlnqlmIzY0kTjmPnIwcBQtB1t8Fh1JRbLTplxSdny
	 NCiwJW1+yvjJq4kazeVrWLlcFnzj+uQ4ehDCutb7ceJ6KNGDOW3wgckKzoExUXGCJ6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691173;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VDWnabgUEJcUEeQPiw6lFhSrKRvn55dkJFpGyvsv4vU=;
	b=v5FAP+lf+nmCDgMflJzzYOz8AK3aHvfV2DaJuKZL9WjiwUxYFHyaL3yPYZVqTebk5pLq
	 9HqjJ9mvgTGzPnf3Rgiw8JLxU/20vzNthQ5MhEtGanoxe5v1LwULj+SYYbQQxEACTd6gO
	 dOW45hEIKuEHs7hWLG//83FoJmGYPKyrFHy4dfeRfogxt7Y9kOS8jl2kft2yNSviC2zcx
	 G6FspYPzeUIBlewaWlA+Vrl7uipQiR3Ivav6j6Kix9bTmm+C5sjMKq1UPiJy6VKncfhZF
	 xuG9vjQlBI+gNSU01DIzcTmsFpM0fKO6F1yN3Juss6n6ViyckldmJ1T1e2yiPRgTZJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=mKYrFX1b;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FH5BFc1K;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC4606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 07:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4CC4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=mKYrFX1b;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FH5BFc1K
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 179F37A0156
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 02:32:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Nov 2026 02:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793691171; x=1793777571; bh=VDWnabgUEJ
	cUEeQPiw6lFhSrKRvn55dkJFpGyvsv4vU=; b=mKYrFX1bBOnw7lQCXApItXeEvW
	05AAig7rGpQaW0ok02/cZdH76xuUZloxO/7MGLpi3Ndc6gXMwXq6rwyrWLWc05UE
	BguUgk8+RzjbIHUoyOW4Hw197nh/uzDXT0cKNP3BG/gkc9lEyZKtmcRDhFMAdWcS
	+CDr3XP9tOY+yu39sK/BEGXauHkL92Ic+xexAeyEV2x17To9DUlLP6ddLL+om0dM
	lTYv2HYepgphb/TWH0wpJ8ujgOImBHekV5mLy4XE3KKXf/c17/zSd7Fu8xPtue2G
	tCCLJhwCicdIQSbAdpEHEppj1xhAZjUsMAaoRQv/MKw4RHm0ePUPF/DXfg0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793691171; x=1793777571; bh=VDWnabgUEJcUEeQPiw6lFhSrKRvn55dkJFp
	Gyvsv4vU=; b=FH5BFc1KUX9U3bmRH9dTO3iD7dMCfnhkFt2CwwwiOVjR3ydbEfr
	V0v4CYIr/FzKYjcuVueQvdCGiCxEdh+YLINYK5It8NCwSTDM87IGfuEBAgO5p5nE
	OV0AMy8waIemcj7gUcjiatRX1Skp33exMrIGp2bC1iCdEkBa50r1niLnhV5RVItj
	W9Wbrm8qgx/h3oIJ2ISMNAlqaZLIdeFlB7G79uhdGj31jbIkJjuz3DrCD6OUKCst
	kQW1PMRrWeUliMC9W8FKB+RcTN+hhezslZ5n23u5q8Jpo9x2Nyt4xHpX5U81HOOR
	bO56GcuW6YihoFYLdIygRrc3qFcIoZP5Y4w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793691171; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:iefYDmYyuXdeZ77J1L9lRV5HL7BHsO0nK63b3etv+WqiiDs
	zAC4YvA46cmQzJRpwqoT3jAZ3piEEE4a7MCLcpc2DojFdTT3+KeYm3/eglcqfJgf
	MRYUhQ/di4pi86h6Jj+G8hg3i+ApAx2Q456PyuvZe9Dje4txgzmHpREuRszqFA/u
	kWvYSkY1lh2eTpfi4Gz4NwW4SL0EQEFZiRH9S4f+YAZmjBy0oHr+zKLu7bTRlklV
	EyqiKaDAyVJ+Da3M1ailVUTmv/44UfbIadcwg0RpRYyTyQQ8bi+6sT1WEHZazx/l
	USILTxq+6d9Tdr9eFFiyOkFnCu8jFRHrq++ozSw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NUnZf+bk674ZP2U053tPby4PZRPiaaWgHOCEQ4jYeX0=:QJ+muzHRnOXx8Oly0flk3W95GVnn3YIr6Lcl7KBfaAc=;
X-ME-Sender: <xms:I47parmqDIbSbQnOXSsOuliuzU0AXwDUHfSgw0SZWYZZ_AnrZDlo9Q>
    <xme:I47pahHrIESrAQ_UHz-2WlBO47kuqj03Kyxyxkw_J3v4jrI-nokrc0tCpTZA4WG1B
    g8peOICh2kmAKeNH-tnbtaN3i0cEqX3QVrUK4LzJ4JOkDB6f5P8Edw>
X-ME-Received: <xmr:I47paj44JfIyGLIXmGCSifOii2FzR5mHy-2hAzaM1KC7sUqA7znPXA>
X-ME-Proxy-Cause: dmFkZTEUhpd6mlVXGXdnEyyeoo1L4TRMKpJor8Tpsr7spNSa3RJ25VYRgK/paYQXBiAZVO
    poPyL7twXl/IXkbRLCjB4Wqs1kGd681Ba7hpYYf2zyGXr5a1MPpFSRknmCP42mlN87x3mC
    VYTN7UMJyI4mNXVQkFEOjkBnf/RWn4JM5G316+BLhhHMHKG6Ar8PEQ8pNY4v9+ZOCvM8lN
    Y8kEwUxERy1Kk1AalMY+k6yq13aFqg0TMw3EZp27zDSsSm/jXAVjpC1HLXotifinCI/7AN
    +8p9XT0TMomEeHPs4e5HkUwX37kAG1R6cnDZsAydQuX0xez839o2Pw9/NBXzEVlvgrGPA9
    OHg34Ugq0RjeSozowbYNIB3COyDPHzZj0qNlEBvT9dxrQpJTlFnBcYGu6O7QGk5iO3AFzQ
    N8kBqGWwki565AiThnY00OiwZuLyIFjdl9WK2eUFRdHQe0Qsq8bm8BIS9dpI5HcRU1kR4k
    Tl31i73q6Lsklur2V3TeGWiZze1fs3uytp8VYuPWF2S9o4r1TAIcjHY1cSyxPqtyYBcvPP
    wESEVaI4J+vo3bwjaV7DvsW0zc4Hm3nlMIZmlbpbo3yj7D/9QgMWaq95yCJ/VTIPVBlnvs
    0obhZDQugcx7XQu81VtbzJ+OMGWe+yKjdFfRgiqAN0gh7kc0e4KClradYQ3A
X-ME-Proxy: <xmx:I47papkUOLaUnN2I88HTfO_rVbNYh3lE8k4BsvS-tCh4Y574ToB9PA>
    <xmx:I47paooPI-vHZEu4lVZX2EbNp7SDkYCXwY5rMIO97oZ-GK3qpPRi4Q>
    <xmx:I47paov5aO-oicypPLlO5KfjtdpetdFf2YJbJJIgBM6O13lad9-prA>
    <xmx:I47patF940lyANj58tuRkHJqnVifmgz8CxEkCg8h5pHPgxcziW-7oQ>
    <xmx:I47parQnuoo9BEs60F6VZLfErYG2ViDWAZuhBWazLOinvnUnYfzqAS9m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 02:32:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 56570ba7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 07:32:49 +0000 (UTC)
Date: Tue, 3 Nov 2026 08:32:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Aniket Gupta <aniketgupta3001@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com, cat@malon.dev, belkid98@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH 0/4] environment: move line ending config variables into
 repo_config_values
Message-ID: <aumOHhbTVW0bT3We@pks.im>
References: <20261024220012.486-1-aniketgupta3001@gmail.com>
 <at9HOXZhVcl53CGX@pks.im>
 <xmqq4ie8tq3u.fsf@gitster.g>
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
In-Reply-To: <xmqq4ie8tq3u.fsf@gitster.g>

On Mon, Oct 26, 2026 at 08:53:57AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > While these patches _look_ like they libify Git more, they actually do
> > the exact opposite right now and tie us more and more to
> > `the_repository`. So I'm inclined to say that we should hold off merging
> > these patches until we fix that issue, or otherwise we paint ourselves
> > into a corner.
> 
> Could you please volunteer to add a quick patch to add a comment
> next to the problematic structure to tell people stop moving things
> there (for now) and point at the message I am responding to?

Sorry, I planned to do that but haven't yet gotten around to it. But I
see that you've sent it by now via [1]. Thanks!

Patrick

[1]: <xmqqh5hzjdwr.fsf_-_@gitster.g> 
