Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E9478F43
	for <git@vger.kernel.org>; Mon, 12 May 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065967; cv=none; b=Nn6Ht7286q9lojmJXAQMV8vNSudFb2j8RFOTpieNj+tjL/El+0WdPbILlI+4xJH97BtNYEA2wYdPTaxn5suSwcs+4KQ+H+2AnhSgBbXruRa1Rteuf4enrUjGL188VMAX9lsxZq/9aMkkYdanISzajKNpOL47lt7o4SIJNnN1DsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065967; c=relaxed/simple;
	bh=1X6KZHc1l4KpenoMxh2c/IP6wvWb0o7r3ZxZCogib8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IrINfqmz+nN1Td5rzEIkaBVbN090YRWqTEHt2yaapTd/RvgwYmnoQd7YT3g8LBvbnJp3eXbw8MLSmSsXszCNFCLOuKkxpucUjZngZMk4EPNRCPxFcqRBRMoZ87NU25YHqMKpLIuttfRern0PrfoDXYsLmK0VGhcaNVzeBhAuJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jxe1F0lT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dn7QJMYE; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jxe1F0lT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dn7QJMYE"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 80D2025400AF;
	Mon, 12 May 2025 12:06:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 12 May 2025 12:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747065960; x=1747152360; bh=dtdqFvDOMJ
	eL5Q2/+k7Lj4PXaL9hOyJS0Nt8uHqhWFI=; b=Jxe1F0lTlu3aF74VislMng4U/h
	5NQ1jrKn7jhHHHZYsuIqfRHGviEGmEHem+7QJUzI3tpxaoPXeef3AQl5BOmZ1Ni5
	FFmrrhZeQOUfFLFWf0tmAH7z23yau9qP+JXZJqKCwIwPQWxEEycQyRtcKTzEFZq2
	w7bf5I0xxyorRtu22utRBprN9kTZN6LImklsLr71hjeD1d5pdzhnnSfF0bsvy+Bp
	LMqDKOWZsto7Z75OufAER71II0d+sxJU9mkuVD6iORcE4JH2QmjA+KuJU216LfAk
	m/XUra9Bjm4D6blxGZp3FTQD4TgWFLAJz729qcRBY6S13kZp0NR4QK1KqeTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747065960; x=1747152360; bh=dtdqFvDOMJeL5Q2/+k7Lj4PXaL9hOyJS0Nt
	8uHqhWFI=; b=dn7QJMYEu5dq3Zp12ndYwZywft8bdvWdWZPA7oS1SlYG6+jYcC2
	fVdmHwKVD5JqCTH+dUhUPc+JldrCRNkt6agsYb68nqiiEyFjhxt7OxUK5nQhpC5G
	EdHmOLwkr3ZcsNhsr0/lYPjpQoUQM2Ln81ZQIDlahM05vLG+z36DxfWhJhbYhy9c
	px1YORoSb350lSBzjcEbIDZRfpXPBMaUUQj1TIbW8U4lqraSjRI03J2+JJT55pNj
	x7nLXheFOZpFqB6P5rDt/1FmTpvsZIdT3s7hO1FWjH3Jx4dG3k5uH8UMDe7Pr+e/
	rLNBE9tDp3wvZPT0yUep2xzkpCd9YMidRng==
X-ME-Sender: <xms:aBwiaEk42o94tayjqSRUmx0IVThTquo323_6w4X9-R3a4yFKzLjmiA>
    <xme:aBwiaD2pvcf2L6_bL34EIMr1dFtTh6_5J-AR1B2xL-83-hdlfYeWs_crKH2Is6gN6
    stzI3PlqY3nhAfTAQ>
X-ME-Received: <xmr:aBwiaCo1alNNBajHb-m5UP-4BcGBhzdpsNdkgfZXILlRhE5RT2E-jt4DMFuXYIwqLIzB_l4sWqrwly9j4CJtljGZr_czhv2bCh12AAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aBwiaAnLl6P6rWHslYj6hB_2XuaECzw-WvbgBS6-x7g5eL2KocFwHg>
    <xmx:aBwiaC1Nmz6cLpGezZKlH9cVXCg0rLA305jtrD9d52_yFHXfr4QzhQ>
    <xmx:aBwiaHvm2NvL8txanYdADVhKVCifd0I1COQCNjE9oFQjO_PyhNcFQw>
    <xmx:aBwiaOU1bhDuR-JVZKjAwYOH-oO2yHyYCK_4r6_Fs3_mtg_IrOw1iw>
    <xmx:aBwiaAWyN53hHn6XDM4vYXsAny-hu1VLDIGYhdFXhc9BwQWGG6j4OhdY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 12:05:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 4/4] builtin/stash: provide a way to import stashes
 from a ref
In-Reply-To: <20250512125825.GA1191360@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 12 May 2025 08:58:25 -0400")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250508234458.3665894-5-sandals@crustytoothpaste.net>
	<20250510172107.GA601540@coredump.intra.peff.net>
	<xmqq5xi6xaov.fsf@gitster.g>
	<20250512125825.GA1191360@coredump.intra.peff.net>
Date: Mon, 12 May 2025 09:05:58 -0700
Message-ID: <xmqqldr1vmop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, May 12, 2025 at 05:42:08AM -0700, Junio C Hamano wrote:
>
>> > I noticed because I have a patch series from last summer tightening
>> > these rules (it got derailed by some conflicting work, and I've been
>> > meaning to pick it back up). I can certainly adjust these tests as part
>> > of that series, but if you're re-rolling anyway, it might be nice to do
>> > it now.
>> 
>> True, and exported one is a sort-of-normal-looking isolated history,
>> so it does not have any strong reason to be at the top level.  But I
>> am curious what your plans are to deal with .git/refs/stash itself?
>
> My series is only about the absolute top-level, outside of refs/. So
> "refs/stash" is OK, but "stash" is not.

Ah, OK.  It would be good to forbid things outside refs/, and
tightly control the top level, so $GIT_DIR/config and
$GIT_DIR/objects/[0-9a-f]{2}/[0-9a-f]{38} won't be clobbered.

refs/stash is probably fine.  Creating refs/head to nuke all local
branches might also be something we want to protect against, though.

Thanks.
