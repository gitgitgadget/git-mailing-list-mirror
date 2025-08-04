Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A523A9BB
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293111; cv=none; b=apWfYSp72NKeFNDy7ZNsir1yg6DCEAnVfqgfX4JHQWXbpf+xo7zHUyligqTyJuTD9uU1Oy3sV67aShvMvhc/dHQlIWpJAfxtvtmawafqb+WLhTlfZV3WEcp4VkiCZ2k6Er27sJhN8r2qzWPSdLBm7gXmVC9PahscLRIaa1Dj2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293111; c=relaxed/simple;
	bh=KHAxgHIW2sL5ku9l3KnXPHMQDp2GAVr8FyWElnSSFYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2tE16Ushx/IC/9RR6T20oOnOCbQYh9wAxscBF6Ei4qUJi1tOFun7UCBwhgg6wc3Ryqg/veffgV+xc3MKT6EGsGSvH47Wp0gFcw+IS1b4sg30hsDkEs6HQjtF0nVTkO7/D6ATkxVPggXAvOnUN2bHa6ioumnNyi6eFq8EPFrJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H1aWq25f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+4EGnDr; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H1aWq25f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+4EGnDr"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C983E1D00131;
	Mon,  4 Aug 2025 03:38:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 04 Aug 2025 03:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754293107; x=1754379507; bh=3m0bp3F46k
	o2cFG6+8jnaIJNSiikoKa41hgD8QRsY4U=; b=H1aWq25fyPO3wZY2D/VIZqrLQJ
	Hxxqq+TJD15V2eahZZDDxoR1+aJ0K7+UiQMRBsokJMICge+K0f3LzEMmqRIqNyNI
	oKkeTaBrhZTCF4AdiZpVC6kGl2NRaXo/sNu4OdfAJbHqwK/w2W9Ycxo42uhAC3xj
	etaRbcTPSO2juv3EtW+uQMg/9FGEXIvGWWdnd7bas06QcfUoCgk+xn/31GoduNb8
	qBTHak6Stz2Tk1ccRl/yUWZMEoSN87xvhKoCCR7cASVtV1qa/DzS0sAiaLWxrYh9
	lZyrTh3rEoxkIVLPM1moQmc2IBQb4/DQZfQMVinBVzb1ZinFWjW1EKYKWSnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754293107; x=1754379507; bh=3m0bp3F46ko2cFG6+8jnaIJNSiikoKa41hg
	D8QRsY4U=; b=e+4EGnDrVk3uyhruGt6X/MQDrKiHLtLI91wmGrvwxAUk8RmhvMB
	UjMNhab24Tw4q5sQDROHBRDmvD+n+DuHp6/RAfzeYDFzDSMsvTNO52mYj95m0WJd
	czvRyhF3W+c/JwqP1qXwMsDT1a1m3DvRFjsUpc4y8aQpdy5SYURVkvMxfnrHrMU5
	JUQTkNLCOi2hzG0K2OlW2n+KYZEefirOcg97GqcCropYoNHAAOLrmkHQdISWT8yn
	8UyXfssI68hvTktAXSpTWFgQWJnxle+upRnMRN1vcu6akR5iShRnBSAMX/3Wu7IK
	mnGk7FlVojF6o3r0sJyY4EBRydoJbZestbA==
X-ME-Sender: <xms:c2OQaMJpxTF3gAVwv-d5myrhYn9lJ558F5kPtNjbX3t-IF-QKoBuQw>
    <xme:c2OQaJAoCNCQHKxijtP_O0mOiI5xnikFGo03il-SinSZROjb6Lh8E3Wk9JTVP-HtI
    He8h7wmplWiwU9aXQ>
X-ME-Received: <xmr:c2OQaMdaNzphH680jj3sRsCvd4kwQ-G3Jn3c4jnW30asP24RUnyiouhcvIPPtU1Rq92ETlw0EseLDH_FbgK7vRo9Wr10L3o1jDVA0ZZUtwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdr
    udekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:c2OQaI2gFEg7bfqV6xLZ6ezfJAvusuUvE7ssrfVAk8WwByBMWzhxGw>
    <xmx:c2OQaDjApJLiv7ugivEDBtTbXue6nxtDudengmAQo2_ybTYBjGBGhQ>
    <xmx:c2OQaBkkfwElymHUWhUCLnxgm2W-yoII5vFVsD9tEQX_uKSB7TU82w>
    <xmx:c2OQaJa7aErE9to38vxmbt0c_8_cajfx8y6pc6AYfW-whCEYPwLQ4g>
    <xmx:c2OQaL8KhjTjL_s4VOWuHnuadLallAcxuyFtFoVdObW91yYhziemoKgv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 03:38:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7602b804 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 07:38:24 +0000 (UTC)
Date: Mon, 4 Aug 2025 09:38:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Jeff King <peff@peff.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 4/9] builtin/reflog: implement subcommand to write new
 entries
Message-ID: <aJBjbZqW-GuVkFzo@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
 <20250729-pks-reflog-append-v3-4-9614d310f073@pks.im>
 <87wm7nuvaz.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wm7nuvaz.fsf@iotcl.com>

On Fri, Aug 01, 2025 at 01:37:40PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +test_expect_success 'abbreviated object IDs' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_must_fail git reflog write refs/heads/something 12345 $ZERO_OID old-object-id 2>err &&
> 
> Is the object id rejected because it's short, or because there simply
> doesn't exist an object that starts with `12345`? You're not really
> testing the former, which you claim in the test name.

Good point, let me use an existing-but-abbreviated object instead.

Patrick
