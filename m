Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7E3F0778
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767181; cv=none; b=o29/YW09hpS4UZflEc8kj/KsHQMLWEU685llBQky/raKxWbBItTk4u3b733bcn9PNhN4WoPhu626JFDdhtZAJJynNs+JT0MpiNrFt1pKP9LcUHqXqK376rLg9qeEUqxfjcj8KVWWfjd7nDhGdIRJ481yaFtmv7PlhHaS0LN6N1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767181; c=relaxed/simple;
	bh=o04Ss+L9/BcOLkiWGTWSzyeC+p6f50Ae3JPlhnR4X8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWJsLNs0spKzgBgJ99zJulwwgdmkPpt2kGUcZiA4Brr0OV5PXFvQWe0mcEdLK7zilugvfY1h6ZXs1TyzqYkEZKHWb9+Inao5pqlP/I/O3ibW7vs0+Ni6pvS0KwvJ+nkvnmp7GnOz/nsGDtpcPi5vwlXpVrcGDmxlYTXE2ze8dVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hk57JZG6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CgSG0YMq; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hk57JZG6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CgSG0YMq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B10577A00CC;
	Tue, 17 Mar 2026 13:06:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 13:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773767179; x=1773853579; bh=ce4/bg5h8t
	l9R/Csx9F3q7WEs0u4qOiRgQ0zffdlTUs=; b=hk57JZG6DK7AT9D7XlOug/vnaH
	jZHDWL2QacVCa6bv655BAQRPXps+s/e0XMgjEmZxK2qZiy62rWpywE06X6xNvbg0
	wqjHsXpTzUxyufNYjr2+b0+vFl6St1YYulNhFaO8qP5rVJfwYR0J7rHrRg/WcJxU
	hjoaaSm2Rxvzgrw9BTXXVN40LR7CCmAeYUpNd6/oKa8CwgY2UYE9YyHleL070223
	9aRg1Q911u0dwYCnCKUTHsO3w2ohoTWmt8B4cNTh+C0Q4QgLB9Q2FKMsB9uY5rx5
	7jesCDzF5EPUq6xV62Cp6PhCMvEYDvbYr/WK+FIlA/VYFaxO4dPUuNEh2cZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773767179; x=1773853579; bh=ce4/bg5h8tl9R/Csx9F3q7WEs0u4qOiRgQ0
	zffdlTUs=; b=CgSG0YMqUQ17iB9z2rCYP2aeEHDc8ZmFMDAdBhNuVTGHfYZCaYY
	mrgu2WRSno1eYobSNlFMN320W1Jyo97GpRSWFIusKiHazO4gQQsAaQRJeiondnN5
	6SmIIwhLmEMZe+edZi44srBT3bQJftPYkORwETRvX9XVPsPI0kKm17Q59eGNBQhN
	YTc/ZbKs/5REXdZvfWWlLcgJcl+BfgTgM5IK4kNflVCCOEh2sh1NOm9ZbJandjqi
	Hii70Hs2pPceestlac7B7ndQZEDhNrn4bTj+E+IC+5hYzvoz/38WR25ykphpKUmm
	WiBOKxFfB/yofR0Mvcqg9whc/TXxAWHjyng==
X-ME-Sender: <xms:C4q5aR7MSyl9bXiC29QO_SnsDXsU30o_ZaIwbzCs0NPeh3k8RwfxwA>
    <xme:C4q5aV6df0EnhTseTjTutFYijmBEbPUtXF8gEZ2u0YFJE5ajZkJLHlnAcZl_xMsEy
    Z47l1KAIcg7rnZo3LX7XITrkKE4-E78W8LnvITUN4WUqwC51Jp4Dw>
X-ME-Received: <xmr:C4q5adeCSo_TBlCKXwBNC6c1qY5kC577B4fSnKlFSLSePADgCPYzjCjBvMAF6omMj1l_7fNjNbs74KHg0B8J8JoVOsAF6Pgqew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddukeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:C4q5aZDtmt2xCtXm6dAtcVn9QjnX6ykY_SCxParGfr8a-3GE7zvwCg>
    <xmx:C4q5aQ-8ZxoO8Yjj3JxwUowHcCXNIDzybhqQb7cvOmSpoofFpUvMmQ>
    <xmx:C4q5aULaih9zlRM5GeHKaw8QQPDohn5M2Zc30dCHjD-SfmeuOWtzvw>
    <xmx:C4q5aZhN-SYPn-6FoNPdT2rqPPuDOlcUBQQZJfKCxRwODNcFU4NgWw>
    <xmx:C4q5ae-vOLVKdAkqbUh4oowdqbqOIsZzWl-Pg6muvlae5gCawaWypdrD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 13:06:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH] rev-parse: have --parseopt callers exit 0 on --help
In-Reply-To: <20260317145543.GA1828@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 17 Mar 2026 10:55:43 -0400")
References: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
	<20260316220742.1286157-1-sandals@crustytoothpaste.net>
	<xmqqcy13mgdk.fsf@gitster.g>
	<ablCBkmOdoourCnO@fruit.crustytoothpaste.net>
	<20260317145543.GA1828@coredump.intra.peff.net>
Date: Tue, 17 Mar 2026 10:06:17 -0700
Message-ID: <xmqqv7eul71y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I agree with the general idea that "-h" usually should exit 0.

Yes.

> But this
> is not just a bug fix for --parseopt, but a change in overall intent. It
> might be worth digging in the commit history or list archive to see if
> there's any discussion on why we are using 129 in the first place.

And if it turns out that old discussion was convincing enough, I'd
prefer to see us moving to --help/-h exiting with 0 eventually.  I
do not mind doing so at the Git 3.0 boundary, if an excuse to make
a big change is needed ;-)
