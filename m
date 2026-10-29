Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261238;
	b=iWG/f1ChxsQcPeoyKkKf0giTrSd8MMBsepQADvNbtTwn5fEM6QyHza8Rf634N+TrxrNy
	 VTZzzk1uvtczOQrM0pTjlC0WfNXHlC/Dryxc7H2cr9lDNGLJTbh1XoqraULWs6xpg19IA
	 egxoMNpWUJtPz3w0B+1JNGv5YB7a0DGvvC8PbViljmUn5Oblaz+ZQurhIobhK/aPvVCob
	 M4Ok6VDOK15m+DMwTKJ1+HtMcQRKd7OGG6GaJJKStD1gtlw/ypEnmA8mYDOag8EZ8iGCM
	 Oh8Z0EYHLVxeCKZN32oNDPGIaP4sVG5W6MXlZB98FVc3qZBHf6wGtGXftl0LPeXjzLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261238;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=l0cKj6l4NFYdh81LhWMft+G1ThlXiehKe5cfgcnPKfE=;
	b=RNNuvLcESfBMicAJgFKH4fHtrPyd5jn0NQQXnBtx/4TiziOqkUyF/EcYbJOclFOOlPPn
	 gJXAxOrWhA0g/zU6MrC1KamKHZuP8GpD+IJNrfJVF0PpBCRS4zeIg/u0bJ2tvoaIBkUv/
	 fAhBT/OxpRYkJUZtSHooBBlkyjTlhwm8Qo0JiepyEt6eseMuPBuEhX6y8lnTN3//zeP+e
	 +ao3/34/YYBomMlupYJ9zY1rduZnHdXNtHsYvj6zt/BtqQCtkO3hhzSggmV+ZF5qrcf4R
	 92taDpXMP3Gug7SzIqqM5YRSTLgHSC55tEX73nP+NJQTacGtkOFfwyjYoH2dd3Xku7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=H51HLr0i;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wHoeQAKX;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA3606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ACA3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=H51HLr0i;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wHoeQAKX
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 735DE7A00E2
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 04:07:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 04:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793261236; x=1793347636; bh=l0cKj6l4NF
	Ydh81LhWMft+G1ThlXiehKe5cfgcnPKfE=; b=H51HLr0i8W3L3ymfSPo9w5LZGT
	sattAwQ8FW6wzW333DLjTdsCi5FP3VFRUbHW+DP1LktDblV1cvjrYwx3jQp6rKCh
	vKsIk3j2bSjDIWHedUuKjwiwIM4loF0UOIpwNTZ5a0e5W65Jig0do7yZbTr4f1om
	ws6n8MFeRntu+xZTFuT9HFS50ZM/7Zcy7CnZ8Zag6Bgluhe2zxYf/WY3eLWhHssN
	5n9Sj/XtdqE74Lh5gR3rYfR+ymxx2kL8f5ZKvsKUVxxPGr7JDkftYzbuwCn5ilkG
	iIpTaIg8augvakQkSrZVSshPetw+nypIzfmjb/SyrQCQJzKz/57eCh/JlMFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793261236; x=1793347636; bh=l0cKj6l4NFYdh81LhWMft+G1ThlXiehKe5c
	fgcnPKfE=; b=wHoeQAKXwiAJiqdOkMz8e5cz7heJ8J6IAQ+xNRFE2fyooERZGXq
	x2SZM7EvWm+7HOXso+NuvpMcudDcR+ce5kc5QLcAeXeG0TaAgqcnGL/holNUM2uR
	xDIdYVtrBFU5PTc//ZkgTtU/Rl5xUsEPNy4U1cbD/cDDp1bys4TvmKbVJykjEk5n
	vFzdFiCjQnuN+WKj7Dok4t7DsxuGg5jIcNwl7VHh4eBYq9TIkTJ35isI5zQ0OFAW
	y9HbuIZyLcR+WSDAJrT5ZqIt9b+dpCOz4tz2hh3p8oZifB4AqpL2Yf27fxmyY8rx
	WLRHucLtaygnjaAbthNc7NrKsocIIf6DKwQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793261236; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YVx0T7MHX6x6wF+a4FZ5qnkPQgjdAWVTycLQ7dpXmvixiMz
	aZ+78LkI7JxgTG0/FJU2sqaz1Hxp95cipqCsa8uOreZDRzdD+JMh8do5RgZ5pUhT
	rrydGtfYmDhOti1/UVwKURWg+nbSNI0PR/l2BSGd4JRpaEi6r6RljL1IsEfSEhjV
	lbh02anrs4jS4kasE3y96kjuBhdtMeOisEcRJjd3ubwUq+06osILabsMwV12I11K
	EZgpovSCIXRtzc34ZyKcg9CXQ3MWrZJ90oHTNrvxYZzlMpnxR2Ui5oWSrAlylidP
	wgh6q6dzIFMKU7uIXsDJwxNRCySnfK1NU06nTCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6lTGBm+OTcEUC1H2kLjOVsTt0YkEj/xcc9yQP/o52Ao=:ohvVwDM113qcXjVgdvusBShkCdPLNX3l+sKKU3GnV6I=;
X-ME-Sender: <xms:tP7iatrFDD9pxVOJ9UZTpGEv78hA5st2EcrzS41WVzbRkDLampljbw>
    <xme:tP7iamgAV95HNOZvMKtgshuBa6Dy4rAhx1tdWyJ6slKE4GvqKNUtEajYyCjPsjL4U
    ziDLaO8F-IrOrknzGBc6bVHuKwcegm0u0JNniTBnp4nPA7-50IK0A>
X-ME-Received: <xmr:tP7iaigvWwibnMkSQhM-nSppmFSD0AfGHE1KoNd8hn15HiVX3gkuHg>
X-ME-Proxy-Cause: dmFkZTGqBlAqV5NiPaa2IyQGyoZVMr4ZL4JDnXi0nb5q6x4M6k+yOgLMgSRaUvsjw29tp9
    6ybOws7DWbWyzf+luHdxEbKGlJStYsAD7oLLBZc7ETC4zlMdss5nr/U5hmYznZA5qCPNcd
    f1Zk9M21/LWK5YT0/36Th83QHawa8BLLwkRULWf1K7tkeNPMShhLWuBDOosOk/9mArOgAL
    MqDWHvMXDQ+gZ+QHj2OuQ7G+xzSer8Hn+FWYikzYA9WrsW5fVqjAZUlfoVA5DWnrru6EZg
    BXpAeuJ3F85zRuP3bLgfmvjr0OCs+Sa4n4EBJOY/g7dVLuhEMuEHDhUbUorG2QPwyy2KgV
    Ga0l4N11BYNA6VbKmXzmQlm+J6gPPzeFbv4Fgj/B/GTuaX3fYcHimfRzoNlFXN786bkDZP
    REOl0WMVgUC6x/vck1vISJYVOiNzH6bLoJ/Fqzw05wJ+2RypQaOFHVnI1hfv6nFO9jku/h
    J9YO3Ylal5gIq5BPKuP4VWoA38wtAaFINLPfx1h+Rx0dOZlBYUesRZTv0X217pRRnkJqTV
    /poFb42x0Ixcu7LFqicSXL/pPI8cerTU2qNTDBgQO5TO6455ZsPECRBMWUU+GJxCM6fBPM
    Y425oQ+iIMCyrE8PDBEoX853C+AvYey2f5k49r0jR//4+s02zN0y5nh5Zstw
X-ME-Proxy: <xmx:tP7iakgusinOUu6XiSk5YnUy-41evFKMcCT2O_Kx11YSCGtbA4zLEg>
    <xmx:tP7iaqIh6CVqRsrzrNnyjyYBZnh3UKLuGIBIl27NYuQaOsvyFHsg2w>
    <xmx:tP7iarE3YjOkipG3qDRum2GCvA-ztJcqOSiHCpgHjEeO1htZE0X5wg>
    <xmx:tP7iamQEQEpNjiize3GZa-sTUObFvDaaUUDXApZAaSkbKY8l9PiRRQ>
    <xmx:tP7iahCUacPnTlIrT3ZH-dluLMpoLesqj_JqEZ2ZUz4tSdEr-VlCLrRe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 04:07:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e0a0938a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 08:07:14 +0000 (UTC)
Date: Thu, 29 Oct 2026 09:07:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Mitja =?utf-8?B?QmV6ZW7FoWVr?= <mitja.bezensek@login5.org>,
	gitster@pobox.com
Subject: Re: [PATCH v5 1/3] transport: add `transport_options_release()`
Message-ID: <auL-r__SD8m3it5h@pks.im>
References: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
 <20261028-799-shallow-fetch-with-tags-v5-1-7c43cc9ae810@gmail.com>
 <auHfmzP3aXyonp3C@pks.im>
 <CAOLa=ZTCwvUJNj6c1G8dU778ejwO5WvVL9F5C-Db=P4Au5=mQA@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZTCwvUJNj6c1G8dU778ejwO5WvVL9F5C-Db=P4Au5=mQA@mail.gmail.com>

On Wed, Oct 28, 2026 at 04:18:11PM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Wed, Oct 28, 2026 at 10:47:59AM +0100, Karthik Nayak wrote:
> >> The `git_transport_options` structure is used both in 'transport.c' and
> >> 'transport-helper.c'. But while the former specifically clears any
> >> associated data in the structure during the cleanup of the transport,
> >> the latter misses this.
> >>
> >> This means when using remote-helpers, data allocated for the structure
> >> leaks. Introduce a new `transport_options_release()`, which acts as a
> >
> > Nit: "a new transport_options_release" reads a bit weird. I'd either add
> > "function", or drop "a new".
> >
> 
> Fair enough, I'll drop the 'a new'.
> 
> >> common path to release memory allocated with the structure and use it in
> >> both files.
> >
> > Why didn't our CI detect this leak? Don't we have tests exercising this?
> >
> > The patch itself looks obviously good to me, thanks.
> >
> > Patrick
> 
> We don't have any tests which exercise this it seems. The tests in the
> next patch do, which is why it hit the bug!

That would have been great to point out in the commit message :) Thanks
for clarifying!

Patrick
