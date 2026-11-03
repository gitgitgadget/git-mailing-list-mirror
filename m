Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690211;
	b=FqGNaslV4FYGvAGVpPn3yeKRQMWif7HJoeiGpHqIwHOcSPVD5o9Q8aY6ZtBzC1+tASpF
	 P/KwwqIlw828Pz8J3PSS+u9VIkYTY9OvlQLOcUTwRf7gViewi2FDWVytcxN4BK69uLjcV
	 sKG63ThMpXrvkEWaUYBL0KISnxNdVVoDIWkjIfoI/3W0tu22tyERQbtQrsbWGjaEMbt7Q
	 Frq9oRy3F1JqOgFw500wvmclAYCe7+gVEi8qrBYVyHLFHJiQ9428V8ZzTEQ3PMNX0bWkG
	 lsbHK1dXW3pcCsDGfEuYN3T0Crubnja4Ji9u4z3JyArKWADj7UBtAGnLSLXM1y9qaSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690211;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=l37IUT6aPrZ0MQOyjhrqbeVIWjErH9+S6h5sNYS/r18=;
	b=fkocK+y4fgPVGIULdxzC479HpHWtXARtJ8TP5zxQDjaiS/UfxiuztprawOY18uFwrdo7
	 75+8SSdIkKbA6IvqW+ZGtxCmLBPhcWcAdnZq4zG763J+pDRo5HWrvbgb7g4Jimzu2TVHv
	 IThfWmmwP7U0wtJ9rCw++UaLhe0bAOfcqpgW4+PIbzzN+ThItWijghmAPuabJeeT8arsd
	 65i8te5qODZmS0P+PVqHkiHb2IxrHwckvVpMdFezyWxGgA7O5fT9ZX3C79GQjaZUvAQ5x
	 CEQcgDxnzTOlkYkVO51iDErJpMw2vn8Wi7VPnk47THLP6d4t247NFk9PLBrBSBsB7FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=oTHfNUAX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Mt4GOQja;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10C606A32C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 07:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A10C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=oTHfNUAX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Mt4GOQja
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CF0D7A0019
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 02:16:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Nov 2026 02:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793690210; x=1793776610; bh=l37IUT6aPr
	Z0MQOyjhrqbeVIWjErH9+S6h5sNYS/r18=; b=oTHfNUAXwLiLLWKl8tvkB1yGax
	Pbu8uFUcTQrcE9pWru/NSBPI7fa9DRwKiHTxSLCG/9d2SoVD9RRBGDLQDnwdHDeU
	eQFOGYLYGwY7mGVutDeZuq7Ewydy/knS8dhQFWYaJtQtOFD1GMDTEunvupxcnL90
	WDJSRx8tGEEf4S6j3iIp8NMGbTGNsBwc4mNVA2Iz9+WgZHCDbNViSBBenjCOX2E6
	zjPsZ9HKEZhMAHYiqObRyFJQGZwk+9JVOn1ZIlw4FSpemYcCZuLMwU7s/QfCXAO1
	SjPvtvuj9DNsCmE2nlRrWOOiWqBHTB7sLrEWb+DLqyoTPIx6i9aNSilJHw7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793690210; x=1793776610; bh=l37IUT6aPrZ0MQOyjhrqbeVIWjErH9+S6h5
	sNYS/r18=; b=Mt4GOQjafIrI015DYkV43VOanfev6BAYWbtjZtBulO+TVYae6cN
	eln39hnDx7GS0bQIAqH6Iw6Z4bO2kDxmlKZnhskKKpSBisYsZHZaGD4N8WxZSkBE
	BHm/J3+gM8bTOPProQyGEyiRw5kJ/z4mCtNSlfCN4zauD4V1UECPsf1Lv4QGfly4
	yKL0ql+O2x1Bh0h6eAnH8KJkuBfS/TaLsW3fQEi2iMvzgsbQf1WCKlKK9AmbAik0
	FTDGK2UHCoYvmG+G0fa/7b+CUtDP/Zj4uVZT3ifZ3gMFeInpUodB8xW5EAJnFklW
	x5vkEGQkSXxyMZr9YNIfZJdqYydnYUETlCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793690210; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:TvOvk6F9Wb0xuBZi+1iZl62vz2bvxGtCBnSQ4S7JGp01elh
	O/yWI7el8Jy3tsj8qJXI7QvvxGMbM5GaNy6OCLjEn4SbJTM0SP74yyM94Dumw98F
	xBxtt7hUWMJ5rNs7fWDWKB+EJeBIlO1LRoH1oXadtnx7O0OGESkHSwl2JSm2LeNb
	pDEE6w0OD8tZ3ux5OJa+tEoZR8BbMgAEiyjhpPQrZbaq8fazcSMw9pADvxVKKuub
	vH1BXjCsPFXKpzKFSXajpAGNsUymI78k8xOiEVaEs0RjNc51WotT9CZDUsCNT883
	yIW6DT10mMyXuqrT+Ic7Akk7jT7zLH2YWNjI0TA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:75PLke7FEjv++EDUDcJgNR/huUv5/nnUTxKD5ukugmY=:5EOWxN9wueWNjl9rEmlUi7KlVEWi5Kn53vFltcwcSXQ=;
X-ME-Sender: <xms:YYrpar2kofr8mfnFpzViMGln-2_dPiIT6sxtm7mvPyJzeTKwX3gJ2g>
    <xme:YYrpahjq4mZDJycuGE55ZP6TkE8_8O9LeOPdmHvRhMV3OANSCEX2IcxgSICFN6ygJ
    Gp1C0V0FM6d6AEn9Bl0VSpQ5UKmqL_D62r9C-82WIuigUCmm8fhkBI>
X-ME-Received: <xmr:YYrpapREjX8rPEp8AIBGkauT-G2WwirnJmhQiVFYTzwm1WrZ9RroJg>
X-ME-Proxy-Cause: dmFkZTF6IJ3gRBnoiEiqtIjRjJvnWc/FDA3iplpbevw1nkhUpTgxtyfHJjB957Et8WYykm
    ZLuz6SnXgzT9ltDPUwDimUtG6qtUNE5ogy+4lHrMMQcxdqsX+fwEWEo0iCXdFT1A0v7Tn9
    nEhuhUODH328BspoUy/+zZ5MSepNL547pUSDUToWyexFPH1uXXbw79vihE5YIYH8U+Z6P2
    SqI57PiuTyDNgINcDdHkKxpyrxNGN6BlfSzJsNtjEwbZb/GtGi0VIY97aSNG53sS+dwDNL
    p6f2asDOZGs8youq/pJh9dlAECovk2HPNyoqq6bCbfPWEAszPemu28qRqGrEHq2nt0RobT
    SwbpdXxf6EYHHcNNbJy2iM1W2wJTRBEaxBKHakoTsGGm0KwX6prWVD55SrK7NBvl3u3YEx
    875Pl4WJHdJrH6p5UR/lTvsmRj6b8q7CYYTimEVp/lCcz+cGD9CmdUPd1knMz2HapT033s
    DRj4PB/NZ//q4OzQiyqAvgq2UcMHz5bSIp63PP50i8aeKJQlmC3ioy47hZkAZMEWWo56GL
    bbtbLqNPA3wCenMI6fl2O6wO35F/ebyJPnQuQkthkiaN8Mr+h+25nnfWlU0/fow1zR2YQ6
    HYC35ua3br32s7GbSxjap4m7WMpbtKKWyGcUdSwJEilyd1Oau5TtE2+qiipw
X-ME-Proxy: <xmx:Yorpaqiu_bNooZqjhJHy2CFraxMvHi4kGj0ZgwzdGurGu_ngtFotYA>
    <xmx:Yorpah7JL6u6Dlg9FYWnDeZID1VMLhrml9tCcaHN73ROb-CW4lFT6A>
    <xmx:YorpavAWQ0hRbhQsXLnVywvET9SVo1BDYWKjYndC0kPER4Jj6Qwxnw>
    <xmx:YorpagZuP75Y7eUUNnF13k5Tqqpu54Pw__qQoF4pnBogxj4XmHDQ1A>
    <xmx:Yorpalgi-TBQhyu1jjUKMmm4j_qtWF6a9JGk82ynJV2Pk9JTOtkMCau0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 02:16:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c895088 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 07:16:47 +0000 (UTC)
Date: Tue, 3 Nov 2026 08:16:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] describe: count the distance correctly when commit dates
 are skewed
Message-ID: <aumKXUS7_x0i7ZU1@pks.im>
References: <20261031065525.19883-2-torvalds@kernel.org>
 <auiGP4XhObUzC9vD@pks.im>
 <CAHk-=wijLfduoJyOM+AW6FS6c02cuEFRAuQWLE+uf7SGhj8jXA@mail.gmail.com>
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
In-Reply-To: <CAHk-=wijLfduoJyOM+AW6FS6c02cuEFRAuQWLE+uf7SGhj8jXA@mail.gmail.com>

On Mon, Nov 02, 2026 at 10:37:57AM -0800, Linus Torvalds wrote:
> On Mon, 2 Nov 2026 at 04:47, Patrick Steinhardt <ps@pks.im> wrote:
> > Hmm. The big downside of this particular change is that you may now get
> > different results depending on whether or not you have a recent commit
> > graph. So you may get different results based on when git-maintenance(1)
> > last decided to update it, and that would in turn result in highly
> > puzzling behaviour for the end user.
> 
> Well, honestly, no more puzzling than the odd existing behavior. But:
> 
> > ... I wonder whether we should also call `ensure_generations_valid()`
> > here.
> 
> I suspect that is just *way* too expensive in the bad case, but I
> would hope/assume that any big repo already has generation numbers in
> it, so maybe it doesn't matter.

We nowadays generate commit graphs by default, yes. So usually
repositories should have one, but there will of course be outliers where
they don't exist because of whatever reason.

> Maybe add a "--exact" flag ot something to force it, and just document
> that without it, you can get slightly odd numbers.
> 
> Becasue rigth now, the numbers may be consistent, but when they can be
> consistently *wrong*, I don't think that's a good thing either. It
> took me a week of annoyance to even start looking at *why* they were
> wrong.

I fully agree that being consistently wrong isn't great. I just wonder
whether being intermittently wrong is even worse because now the actual
result depends on timing. And consequently I'm a bit hesitant to
introduce an "--exact" flag and have people opt-in to a consistently
correct result, because they won't even know that git-describe(1) may by
default produce incorrect results.

An alternative that might be worth considering here is to instead make
users opt-out with "--no-exact", and then make that discoverable by
emitting a warning in the case where we don't have a commit graph in the
repository.

Patrick
