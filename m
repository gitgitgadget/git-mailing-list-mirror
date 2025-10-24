Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA6C1D79BE
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326577; cv=none; b=kaIA8gWRwznbqfi+G9Km0B3sscOqz7CAqux3nbCuyj68OcR8F4lHxlGSxKFSFyJIMvPlAt62fSR46xI91FqnJwBBOau1C326AHmUjwrRRPRlFVUruGtTRDu8U2hvoBNwuPuoZg0Zrf1NIL96bPVkXBP/1a3kpA0/1wfqIRccZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326577; c=relaxed/simple;
	bh=PtDwjt8c5GMUYHFQ+N9PKQZi6iQvGPBjdmrrKm/2ZRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TR+r99zDer+XYXDtW9L6hs2zgCxDeWU/TsJg6bh4bKmeKno+Y1ZxgZ7ne0n1t2VpIIF3jAWFcTzQzdsoqtd0aKu3AkeQruj7EVzSyhHvha7IqB6QrJGk831KQnZrnFScJYGPXCbrdh7InL25FW9rNAM/lezf5y0UJmAjiGdBZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G9DFM/3V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pa5rG8QB; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G9DFM/3V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pa5rG8QB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2C9F97A0127;
	Fri, 24 Oct 2025 13:22:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 24 Oct 2025 13:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761326574; x=1761412974; bh=PtDwjt8c5G
	MUYHFQ+N9PKQZi6iQvGPBjdmrrKm/2ZRU=; b=G9DFM/3VaoShR0mOgc57+MxNgw
	FLBzpG7VgteJzMdMDYAysHA0h8jhkIKkhZ0UXfKrCVc86qsAUDY31qclkKAbhHpP
	8Xl50Ze5oKwzbtrtyzV438gO4Fq1kffPT9Dq1cbET3k5OMGUsfewMIb5O+oh5oZ/
	wndKU/qafWriLqDPhmLmP3XbXpSx667KvrlLoID3BdP9sd40EeR1MJ2Q++CuOnJb
	OaSGDrq8MKbKEBR5eHV930Dbc5JBWl84E1FKQ+dyReG7JVtY61gDPbMXgwFovdty
	J7ij/HygiBu2kD1TiSmecUjpiaimFI0pVb4F5VMOgP/V1hDE1qiIc9A6vH1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761326574; x=1761412974; bh=PtDwjt8c5GMUYHFQ+N9PKQZi6iQvGPBjdmr
	rKm/2ZRU=; b=pa5rG8QBzJvXLX5M3BFQ+eNvAC1MGjGOviKgfM4IE38FjDojPGs
	GjAqlTHp+Iq1Twlotct9/3KQEqQ88Wr+/Ull/m9Vb/huag8jLTjuMZggXQ8KEVxs
	lzG2eKfzgQhp4rpepYiZcrwZMNeATEhDFcJ+SLFolyU1sMt8Wr4qJL4yKGC8GliF
	0Lf/UcpYahxPx2eKTJ0a8qRrjwnFT7h6ck2iV+iOqLfcoCwlTcLCBe4UJ5dkDNt/
	hsJCfp0qY/GWgQwcsvZbLGanwlgvVsqRQyMGUrFr7X30mgv/sO9NKNDREQg2BA8e
	vNjttH9DPqfk6DloPiDvHKmH5xO6WEcRj7A==
X-ME-Sender: <xms:7bX7aDz-YptCpFGSek4HyZHHJCgqUpt0bVyzauZfP5bg7saiGFk5uw>
    <xme:7bX7aCToDuTSSLEFGjWa4wgB_cFAxWH9B4IK3YCYKxeWL4UzZyXvzEPbc-Iqh2HrA
    Mtc4K48ZyBV6EpgbdHmMb25U5q5vaASJYJ5J_GDApOnoJ4kVN9d>
X-ME-Received: <xmr:7bX7aCU9AyYb4inZEODwTWFIjqfvuR3OF1PnhHxjFandPWADcpUP5GdH579RQIeTZZ4vjT3PzDo7mGpjwnQKEnXoHJY8hD-LlTH2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7bX7aMZUjGVsysmLabX5AvDY05yQ6UTMcc89062RrTdruXoaOD6Tmg>
    <xmx:7bX7aA0ys9jf9VRHRzqvx8zYcPe4BMXlelfLir_OLGo1I9d2u1s29g>
    <xmx:7bX7aGhL1vu6pyg58TjHSL-hhvyVS7K-SY6xYB-8DoBrwAnpJJpWHA>
    <xmx:7bX7aMaeyP3XUlLHuvaZQaeZaLv9zsp0Wza0lvXHmj5bTBbYP81MYg>
    <xmx:7rX7aETMPTX9b4qw8HjtLt_cw2_HrFoH_RRHKjnKVDCxrQkmvNYNCmwm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 13:22:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Lidong Yan <yldhome2d2@gmail.com>
Subject: Re: [PATCH 3/4] diff: replace diff_options.dry_run flag with NULL file
In-Reply-To: <20251024170853.GC2345184@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 24 Oct 2025 13:08:53 -0400")
References: <20251024170522.GA2344972@coredump.intra.peff.net>
	<20251024170853.GC2345184@coredump.intra.peff.net>
Date: Fri, 24 Oct 2025 10:22:52 -0700
Message-ID: <xmqqcy6cp637.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We introduced a dry_run flag to diff_options in b55e6d36eb (diff: ensure
> consistent diff behavior with ignore options, 2025-08-08), with the idea
> that the lower-level diff code could skip output when it is set.
>
> As we saw with the bugs fixed by 3ed5d8bd73 (diff: stop output garbled
> message in dry run mode, 2025-10-20), it is easy to miss spots. In the
> end, we located all of them by checking where diff_options.file is used.
>
> That suggests another possible approach: we can replace the dry_run
> boolean with a NULL pointer for "file", as we know that using "file" in
> dry_run mode would always be an error. This turns any missed spots from
> producing extra output[1] into a segfault. Which is less forgiving, but
> that is the point: this is indicative of a programming error, and
> complaining loudly and immediately is good.

Makes sense.
