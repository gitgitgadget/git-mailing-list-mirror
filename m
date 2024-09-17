Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8BD37B
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566910; cv=none; b=pDKsgWIKbYmjfk6EgVDMcfgQEhzMNN0i/TgUYbFQ0OqQYZEhq6mxb7cvh4aP0+wXTFBbrjX2quVUWqUy8gK8eI9w+cLdkP3MWSorbYtSRVVpgFLKNeakpI/3gLCGRrtAFZSe5GZWhBvQz/o79mREICI5eCZ7meIIgi2uKpTbu2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566910; c=relaxed/simple;
	bh=6G2w5f4ZMfjcp4SWpU7hUbj7RJVylQ6WorUEWPhuPpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwa12Sa21vCjuHkrPMMXRtO6gXwcSAtI1OFHOlimOmsBNQIXfw1rdiN1doiQuWXWstGycPakaiXQjd2p0r1wGFYbgqSa1en1ZGD9KErfl8HuWKIu+qc0Zur1iMzrG+6T1a3hH6x9MbBh1/L4cEpif9oAEYDibOzX9EizQaAz3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=thKQ+KVg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HnyFYsgP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="thKQ+KVg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HnyFYsgP"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 09D49138047F;
	Tue, 17 Sep 2024 05:55:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 17 Sep 2024 05:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726566908; x=1726653308; bh=BmD2NQgPoo
	NwT9b2FwL4OR0AvHAf6ba/4qUzvDgsop4=; b=thKQ+KVgp6tU7TPqJWySAfFw0C
	tFx22vTe7Yi3TNu7m45VsR8ZFdashKa/3nGoQwXxIedm8bpd1oDkGEi4WTnWEvck
	gdFr6IWHa22MjbHL15CugHIRLS5i2WDtd6jzLDT2iXZrmPQJYQwPFmbyQKCGI2sM
	RUdwUkm1jfsqUI0OYa1HNTa0PhTuPwXqY7CQiKHO8p4/LhVDsfrUciVqQz5C7t1+
	+kQXwXcvrCnr1vHkLE18clT2vU689xhpGv4TF+bMeTWpQh94soqFJ+dlt+sBH+cx
	4G+wjo6u2kC1A3xk+Y7rmAkwDC+R0/SJFPX3Y0UEsquGVUIxF8vii7hm8ACw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726566908; x=1726653308; bh=BmD2NQgPooNwT9b2FwL4OR0AvHAf
	6ba/4qUzvDgsop4=; b=HnyFYsgPL863leHQYBUCbp7mM3sB5DB4TJpvhsML3Sjx
	u1JC0EoY0D6z9WM7ihNvLOWe84In2IyyCL6qXyncDRuhB16o/biP5XQIZ3dSuACb
	pi7M/YXyyd5Ejw3NXdUFRIcJlE1ZMv5pmeFF3hg3CxdRARtTwdZouN9AhSio1ooK
	0GKC38qMVwqLnoMThQv9xDwp96fV3tUYvBuQ4eXwkKm2kJ3eu1VsOLl0ZNJv8ick
	JRVNozjI+33xZSikp0Vk6wm9IGmHVTSJWMasCEZ+LplX1rqrmfcPtDg/Tu/djbhI
	Q0SRIriakJNGJRQipzI3b6/LMEghediPZfWOUjmvsQ==
X-ME-Sender: <xms:-1HpZq1Ys9oHb8a5pJIUTRr03xndAyA1Zk3_aw6zf3MnjjktgMeKHg>
    <xme:-1HpZtFLek0pCmvvEIX7FU2guOhwcusejsM9V9mRK3r__fd8Auuc7Y-wwm0vO8ljj
    zYsKD5UV_Pq2zL_Iw>
X-ME-Received: <xmr:-1HpZi5mPPdQ7K-qzZW3a9AS8EQAtq7TKTAtcKVWLvC7Y1dt22WUOzrz0_yxhfgYD2cUC0ijJ4EeOmMOQ8ihk9apXMIzQAQSfA2UOD-qetDD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-1HpZr1B0OM6PB9-NM5Hz5cxfizSu76bDSp4ss26AYLykX4Fi4IaMw>
    <xmx:-1HpZtGPO9ek-h8OkY2kt2cHSwLjBFp3aAp-pLT-ktDFFRp0rZkB4g>
    <xmx:-1HpZk-eJHv6PR5WppUTqVHveChn17E8Eu7twdqaz-wRaGa9MAFZng>
    <xmx:-1HpZinzQzrc84MAwXsg3Lm_a2ZX90jIpbV_B7ESwEAffFQwSUHdiA>
    <xmx:_FHpZtDeHnZNwz2PBsFym-DsOFawZ7-jT7T8uPqBGOgjUv9lX4U_1d9S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 05:55:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 43b5e496 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 09:54:47 +0000 (UTC)
Date: Tue, 17 Sep 2024 11:55:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/6] refs: properly apply exclude patterns to
 namespaced refs
Message-ID: <ZulR-G5nOpMsepLA@pks.im>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
 <7497166422ea702aabdf4159b0d7780f1422ba13.1726476401.git.ps@pks.im>
 <ZulIB7k18+4CzwZb@nand.local>
 <ZulM4BU7zSn_NHMl@pks.im>
 <ZulOK5GAWYbPlYeO@nand.local>
 <ZulPhat5pavpiuXT@pks.im>
 <ZulRYg98ehjPLr2c@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZulRYg98ehjPLr2c@nand.local>

On Tue, Sep 17, 2024 at 05:52:34AM -0400, Taylor Blau wrote:
> On Tue, Sep 17, 2024 at 11:44:44AM +0200, Patrick Steinhardt wrote:
> > I think the important thing to realize is that we're talking about two
> > different things:
> 
> Wow, I'm sorry -- I completely misunderstood what was going on in this
> diff.
> 
> I have to say, that is quite embarrassing having written this feature
> only a little over a year ago. Sorry for the confusion, this patch LGTM.

No worries! If at all it points out that the patch message could've been
clearer.

Patrick
