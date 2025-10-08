Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DE1799F
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897641; cv=none; b=F/XIEmxcGXaBtjTtrkcai9Rw3zaOcbIoqIyyVJMvMW7ni5T8MrIjYat1Dy9K0MHYF+nXcdTtHLnD8YEDigymZLPnAd/U40gBYN8ubxna+SyVT2E6pIs3Zs3GKu28B5ndnMuJuEuMpgLDO/XdynDBY8RbQLib0Qab3tZ4rNtQNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897641; c=relaxed/simple;
	bh=qO9/N3zETLl/sMy3pfGM6HUvy6wm1VsZ6Tm5X3nHsJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZEnQStobVFeVVKHdYHn11SN9reg3WmDGdAqQLDGQ6EbfMDve+EzcnJOQQTIIS/mLlAUZ+jPZMXO3kiioZueH8hdV7U671lJkrG5rjNmKU6Kr6HqU7htetqho10a2pN4s0hj8E+cIrabUjwJX6ZH1S/1/eI/pw2tSy10D6VmGco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XTGC78jc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b5GULJAQ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XTGC78jc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5GULJAQ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E4631D00219;
	Wed,  8 Oct 2025 00:27:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 08 Oct 2025 00:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759897639; x=1759984039; bh=9jhlizAzbV
	Khnzb/RPg14sEBlIKjV2bOVfkd1HaEZ+Q=; b=XTGC78jcHULTNNFj1TJUrimjIQ
	1mmGMZmmeGgO51ouA2fwVa/7eQreKmui8KsuQOt4z2fpAkgAYNBy7nj/TV6cw6NG
	RroZQOComCJisKXFum9ap7jTPfryIa2K4xN7RcF3HGhsixk8x1v+Xv3CE9zXD2oJ
	7DURpDanqbwOZFzwXYblYU0gKS0KxYZ4FUQqABnF3WfkCU8nAkyQKcuX0b4ZPApk
	ZXxAAuL2bNXdQKJrVNyZuU8t+Hqacbjmz4i0efIJYZ1LU81olQFRVNs998HtEQ/5
	EnZDFDhqY6f/WuFLObzfNh/Y21r/bKjx/ZyRxE3EHej0ecxfEds+K5GFTpwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759897639; x=1759984039; bh=9jhlizAzbVKhnzb/RPg14sEBlIKjV2bOVfk
	d1HaEZ+Q=; b=b5GULJAQG/8fB1RXlb8xTsBfgMDNOq4fyX92glQiJp5F4LuQNpo
	YCFxTsvVo5Gg2CTdfJdsmXclCII9FbFSAdMUQwQtez8wa6Olaw6LoAzckfGFR5dK
	BTzCT7ZSpe2T5ZWSvt8VZBMJgoP95VZ0oGi9AZ8jmpYY/frexlJFLgnaR6EiSzTV
	+NdNtXw7LDNCbHgzfHEhCdxA4HeLSyIhFCA1VQjEfTLXsyDeDI87Px9VxCt4CvD/
	u1hnP118M5gg6MpiZbODgIdICn1V3YBNiGsabMJllulonRdAccDSINW4N6EIHDkW
	nR5bAFdxTgHZ7kdngeFkY/OCQj0O1bFeqGQ==
X-ME-Sender: <xms:JujlaO6y2KBIPlbtJu4kk9E52DWdaSte--sTCFsj6MBUVstZidY_0g>
    <xme:JujlaLlE33tcK9lLNpsfDbYS0yT8i1bWNb1fNF1A65AVMmR-W0ukrVGsbHbz9n0rz
    5_pbZd8AML8HIDRoDjEY35llPZftNuq3CISBJWynJUbbBWG0OscUQ>
X-ME-Received: <xmr:JujlaHTTHWeFDRNkX3FfFCAQTnaRv97tI6bVl6ProMLql4UKKBgyYjuhY03AUUnjE_FdErtQ0GDWIE59Htmk3_msmMYPqrJvAvAwO3a0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:JujlaCGwih7n_S7rgLd78jEeBH1p5SYNCPXaXHDmt9kJgWCkalPJfw>
    <xmx:JujlaEFzLP5nUY4D_XQ5SBLItE5M1jke5s_GdloaD4jh3r3xidXPIQ>
    <xmx:JujlaISXlVW7gjcpk3sddmCcX3gD21tIo8Ro6knADO3lUNxDjLeIWw>
    <xmx:JujlaNKRigp7tE0cAUyikMG39_s024ENPBV3-H35eVnZ7FQTh_cW4w>
    <xmx:J-jlaCWPZfNDb5JZKiWIYPVgXRk-if_vUg_pBXEI70wJGDcfWER6DiZn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 00:27:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad531a23 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 04:27:16 +0000 (UTC)
Date: Wed, 8 Oct 2025 06:27:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 22/49] builtin/repack.c: pass "packtmp" to
 `generated_pack_populate()`
Message-ID: <aOXoIfG4FyHL03GG@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <ab0dc6668339f24787dc80d2dc05f0d31cfadae6.1759097191.git.me@ttaylorr.com>
 <aNsUkenrDY8YHgBn@pks.im>
 <aOV4QBV8J+71Ikk4@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOV4QBV8J+71Ikk4@nand.local>

On Tue, Oct 07, 2025 at 04:29:52PM -0400, Taylor Blau wrote:
> On Tue, Sep 30, 2025 at 01:21:53AM +0200, Patrick Steinhardt wrote:
> > On Sun, Sep 28, 2025 at 06:08:35PM -0400, Taylor Blau wrote:
> > > In a similar spirit as previous commits, this function needs to know the
> > > temporary pack prefix, which it currently accesses through the static
> >
> > s/accesses/accessed/
> 
> I think that the original is correct here. "it currently accesses" as
> opposed to "it currently accessed". I have read it back a couple of
> times, but it is entirely possible that I'm missing something ;-). LMK.

Huh, yeah, no idea what I was thinking here.

Patrick
