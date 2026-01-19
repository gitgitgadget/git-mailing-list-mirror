Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5D2ED16D
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807249; cv=none; b=QLqgpdxEn7UBGClgkuX1t9EbU3U/Pml6nyughRQAsSgEoY/LkdFrgmeDvUEaIHGpuCGpyxQQEcTGB+TO+JBdc2no2hDLgpS3AKsYV9lr8/EUxkWSaPTo1Ry+sw7VcRljyvrWT5V3QG1BNbYqPzrYasWs9oEJOk1et0fjH/KMtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807249; c=relaxed/simple;
	bh=ZOUiVTFidWDCZCG0eDXwroyLigelqa1ZpKebF4clTzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/QtdQyKVzVyBvGhoeDScY8hu+/XGgmsMkTMkBHYbZgEd5pUcVWU1QKxxpvOebrP6ksKqk9jxiBGqPU0mJlo2PUjbV/NZwjSWC+O7d/PB/pEBqZ0sJvkrGlgYztVQfyxMP+W9vej8YPweYPcnp00P8uoROoALg7ay0GRczbpuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eYjaeaHn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qz9+Ba7L; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eYjaeaHn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qz9+Ba7L"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 92BD114007A7;
	Mon, 19 Jan 2026 02:20:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 19 Jan 2026 02:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768807247; x=1768893647; bh=3/5i/bMy/g
	HTZ3WpDLBYbdHZqTw5AwkA8dpAYXe/8BE=; b=eYjaeaHnB/Y6WX9k+M/vyXRAH+
	lSKK693Nn+k2/vFZ7xzEs7lV1LV5H6atIui7ZMIzS+6ri3/0ODtJ6d+nNFn7y7EJ
	3o2VqGcodneW2mhM1QIYB9M8ELkBLprUQnp0QwmZan1Te44eqw5YD5UQmPErNeQ1
	OPzIf8+88dEGytdI2U/OM7R+D3vhdTPpXB3YRoh8NrlvOnBmpHWgwUofvKM8h+nZ
	EusTeygh0XC4g2MMBazlPs1zTTddLieGegMUXVL2dlSjAZjJHwoOBzl82ML09k3t
	xqroZHpWunyGIHoKAduiMAYfeSj+TQ0QDC60WUFDpWyazJ0V44vnbd4E+owA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768807247; x=1768893647; bh=3/5i/bMy/gHTZ3WpDLBYbdHZqTw5AwkA8dp
	AYXe/8BE=; b=qz9+Ba7LJ8KdQTfX6uYgqNjsV+WU+vjWzWI2itGWasU5gMSip9u
	xvvgqjJRQHYMzmuFDtPlx25S7ghJ7IbITGYEPCXL5osOLZypWqqrqCOg2yJ7tIQt
	wUwI+puXj/CVhoU5zbM6/N/YmGjU67n6urPPuY/1G2bTEBft2ldfdU6zaoXgMrFt
	kBLvw8SMC1BCDmCtz71zQjYkSfg1+5o1OfxxX8bgZqdV9JvPLEBTrkdxdH3a4VHh
	m3P94oc8KNx47oJLlPMtGQwq2x9QU4PmbEVWx4x/RRB79WRwTEYzQtlDvHXVHID3
	ZWHGy1y2ZLSZBIlKtP/kvoqhWoyGwaSPwQQ==
X-ME-Sender: <xms:T9ttaQdJO3Jon9xF6s5tRYNk6jYO51g4efW9nQPPAxOtCw6hCf4q_Q>
    <xme:T9ttaUxCAn4Spk_x9-X6ut4yLlcUQVD4zm_YgtR5eA5wtr7Twts57MVpeGTgDaT_i
    Z0JDsgZE8BX5LEopPCfbJ6bb7InczTx4X5_BRR-YyeD6lZ1OWryvw>
X-ME-Received: <xmr:T9ttaVJXtDufiZc5jRLYvZvpPfpbOmF8HDt7TIp6BGHL8PepzuIVvFFsazSm3W12OnydcZGWZz8C5Zcnuhdnz-cTIfVKPmrXA9fq1TUaVDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeileehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgthh
    ifrggssehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhpohhhohhrvghlsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:T9ttaWGPYRtVcMB_fOVly3BdAPHTxSpXMZszSsoq9wDdcHWZXV6_Yw>
    <xmx:T9ttaR9iRxxw6Qomuka7gPKb0Uz0F3MCO8holZlpjox13V2KXzvX0A>
    <xmx:T9ttaWJXwpRkD5XtKtlarGPxQG6KAgVospIg_4TWbRnJVTA6o0F8Rw>
    <xmx:T9ttafs8oES95fxVsV3AZYHEFuuni2ya0ttKqejuuRBtZqeNecU6AQ>
    <xmx:T9ttaTED-eCdJjRo2DyxVV0x58JW4xHk0v-NILxzcKKTYQBasSnDbnTb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 02:20:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1ffeba8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Jan 2026 07:20:44 +0000 (UTC)
Date: Mon, 19 Jan 2026 08:20:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
Message-ID: <aW3bSYCIPMhJT1mf@pks.im>
References: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
 <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
 <aWD2x154F5f-c3pL@pks.im>
 <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
 <20260115211448.GF1053259@coredump.intra.peff.net>
 <xmqqa4yeblsx.fsf@gitster.g>
 <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
 <aWnekt4ESo0bKpOT@pks.im>
 <CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com>
 <xmqq3445bn33.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq3445bn33.fsf@gitster.g>

On Fri, Jan 16, 2026 at 07:21:04AM -0800, Junio C Hamano wrote:
> Ondrej Pohorelsky <opohorel@redhat.com> writes:
> 
> > Hi, I just want to weight in from the downstream maintainer POV.
> > We've been carrying the patches Johannes has created in Fedora, CentOS
> > and RHEL for at least half a year now.
> > The only change I did is to make the new behavior opt-in by default
> > and give the RHEL customers a release note explaining it.
> 
> Thanks for your great input.  FWIW, I do not think anybody around
> here is against "opt-in with a note" approach at all.
> 
> > I think the patches proposed are making sense, and they should be
> > merged. Even having them as opt-in is better than not having them
> > merged at all.
> 
> I do not think anybody disagrees with this sentiment.  Back when the
> patches originally was discussed on the public list here, nobody was
> against adding it as an _optional_ feature to filter some byte
> sequences out of the end-user's data stream, and the review comments
> that led to the topic marked to be "expecting a reroll", if I recall
> correctly, were all about "why would we make this on by default?"
> Peff's message that reignited the topic this time around is also
> about the same.
> 
> We are still hearing from Dscho that he cannot think of a scenario
> where making this mandatory with opt-out would break existing
> legitimate setup people may have (I am paraphrasing [*]), but I
> think that is aiming in the wrong direction.  It does not matter if
> you consider the approach your users take is "broken by design"; as
> long as it works for them in their (limited) settings, it is a valid
> arrangement to send arbitrary byte sequence over the sideband even
> it happens to include ANSI escapes and other "curiosities".  We have
> in no position to unilaterally break them, telling them that we left
> a way open for them to disable.  That is not how to deliver features.

I think what I strongly disagree with is that this is considered to be a
feature. I myself don't consider this to be a feature though, but rather
a security fix for a bug that can lead to arbitrary code execution on
the client-side, for example via title bar injection.

It's not the first time that we change existing behaviour in a backwards
incompatible way because of a newly discovered attack vector. So I have
to wonder what's so different about this particular case here.

Patrick
