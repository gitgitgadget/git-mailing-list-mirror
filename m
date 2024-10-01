Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2519DFB5
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777649; cv=none; b=XYKuEP3zppAbtaKMe73H+PmHMgGPh9NU4BobdnJdX8bDhAx45YjmLFhuxvDKEfqF9CzRwughoHItv3A7ddD7FkLl3VFmFv4YiJHTzIyriG4S0o0SkoRxWpVxInY9ohFQzf3wnFYcu2qQuTL/VbRkTkPIRFSzhTNQtYIZjyHUq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777649; c=relaxed/simple;
	bh=1XFADsvfC5T1vkewKUfXpTk1I/WfwdwlZpQldI5jqg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQz0D/z7qZHBWAyv99HJAgIc3b3ZznL/rnrbhhMZU+jNZq41PX37a7is8UobhQJ7z2qZSWfUWU012ICC6CfN9at3EnFgaFYxvaEuoO2RDvDtl8ydSsh2Cs9zlLw5Ip7ztpJYNShAbmltz8ib/paw7hvizo1P95pvbp0AyOTg0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lqC0dja1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d01VPq7D; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lqC0dja1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d01VPq7D"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E59591381D65;
	Tue,  1 Oct 2024 06:14:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 01 Oct 2024 06:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727777646; x=1727864046; bh=2QTD52ADpa
	L3RV19kUKGx/7b8YYydR4rp13C7w1UkVs=; b=lqC0dja1d0TsJyek+rzuU9d9EI
	aeD/QhwRWCK6GchNG5C96sCEtqiAEpJ8F3o4Jk3XF9RRHz+6MRiOBn1/o3bvZ0H+
	fp6BMPuyB1DtlvNM3eI0hta3MxP3jvpmUF1Ckow04eAofe4vWong9aDrt3NTYc5P
	H1GxvLHZN0Bd22iRJdgbsfC0SwgleTSIPMmjcYgjV7rtJGXihQn6Icjhwdq7N2Jv
	stFg07sxu2RWeDsHHyXNWmW+dY8Iny8+KtXpwh9OkePlfISgNpxqkdILPP/udtJi
	p9tAsPwWHEwc9jd+gx4X47851ZhLPNioAKTfI/XazS0IsgJtacUPF33V/Zqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727777646; x=1727864046; bh=2QTD52ADpaL3RV19kUKGx/7b8YYy
	dR4rp13C7w1UkVs=; b=d01VPq7DCvk5P2riUfeyUQ3HmPixDfXco6S/PJ89YeIt
	l0iBcEUUp9ugPg6P+TFGtcljVUgkA1UXsGKItSlVBYyi5IHSVWwwgwDD/TdyTGht
	yhCZtcLsnV54Lw7hge7QJl1B5HBBF7XjCLH4dsYx/srfkV64TRcLMPqSmvc8faHk
	Jpxy/xYjv4saTK3NJHv63WjmUFY5ZEdDTG/GvJgHioMzspcCl50dYMGUjBWN5BwA
	WheIB4NjjZOyrWBGFteCcKn9P6S6vn5S2KLC6Eo26PJgTitMobriCK48ztd2I1OQ
	nVXNC4L/f8yDWgHp+HuGvb37zRm5z7nCjHLpboJ8qQ==
X-ME-Sender: <xms:bsv7ZhHTCHCkUGYh5S6zvOFxNWeD0tiE88Ytm51M19wUj5A1X7gaCQ>
    <xme:bsv7ZmVABTvMc2EaACwKpKMrmzt5VGsrKRP-xXEndijlWlLFjnc2vP4Ap8PZ2YHEY
    WHPB52uwJgWZMqEiQ>
X-ME-Received: <xmr:bsv7ZjKBk8Pg60DjXc6IJXhohYlMZvrdNP9Tozj1wU9auY3GD0qCjRKCSiA9DV199pgtrC0FstSzIM7ANTD_OR95HdadR9z3n1C9-CYFZMeYBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhmihhtrdgvug
    hupdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bsv7ZnFa3IacD-iDGpwCD4ekR5kMpMC3ORXtOBCJrqoQJK-mKoYa8w>
    <xmx:bsv7ZnXMg_-NQ2iNFTFfNAS1ZXNzgJtEzkRNvFIww6wXTtXnjLXTzg>
    <xmx:bsv7ZiPIkaesNSp9r8U3V0YKW8uk5Hw5L2yixOq2CaHPnkKzeHQC1w>
    <xmx:bsv7Zm06w59RCktZNnFTokaYqXLXTzAANUTuMcsNtxEK49Xodgd7BQ>
    <xmx:bsv7ZjoazVFWBVFIGv2n2A57gn1ZOdB30zDunwKJNeqG4Fgn0keUub5i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 06:14:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 264b31bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 10:13:15 +0000 (UTC)
Date: Tue, 1 Oct 2024 12:13:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/4] Introduce a "promisor-remote" capability
Message-ID: <ZvvLZrAiPBQKwjx1@pks.im>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com>
 <xmqqikuijni0.fsf@gitster.g>
 <CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com>
 <xmqq34lkg1ck.fsf@gitster.g>
 <ZvpZv_fed_su4w2-@pks.im>
 <ZvsXlq7-28mdxNc_@tapette.crustytoothpaste.net>
 <xmqq4j5w4w1p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j5w4w1p.fsf@gitster.g>

On Mon, Sep 30, 2024 at 03:27:14PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > One idea I had about this was pluggable storage backends, which might be
> > a nice feature to add via a dynamically loaded shared library.  In
> > addition, this seems like the kind of feature that one might like to use
> > Rust for, since it probably will involve HTTP code, and generally people
> > like doing that less in C (I do, at least).
> 
> Yes, yes, and yes.

Indeed, I strongly agree with this. In fact, pluggable ODBs are the next
big topic I'll be working on now that the refdb is pluggable. Naturally
this is a huge undertaking that will likely take more on the order of
years to realize, but one has to start somewhen, I guess.

I'm also aligned with the idea of having something like dlopen-style
implementations of the backends. While the reftable-library is nice and
fixes some of the issues that we have at GitLab, the more important win
is that this demonstrates that the abstractions that we have hold. Which
also means that adding a new backend has gotten a ton easier now.

And yes, being able to implement self-contained features like a refdb
implementation or an ODB implementation in Rust would be a sensible
first step for adopting it. It doesn't interact with anything else and
initially we could continue to support platforms that do not have Rust
by simply not compiling such a backend.

Patrick
