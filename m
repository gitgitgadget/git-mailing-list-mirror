Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74BC1925BB
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100636; cv=none; b=obHZs+6P7+oKFzepn+DHdAGiCg/2gpHxTMq6UAPslCsvShxvLeXyIXse7qB3r1/a51vTtKaAY7IxkcNv7gYAcGpXeG4idFQj0fxT+K426V8NdSKSDFIArJPWaTJAfX9UkQglifZeKJIJC6g8nTQcItcDXj+fQVZXvV7RvCYiOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100636; c=relaxed/simple;
	bh=Y4A4HxlnIR8Ced78NLMNI9oQ6SgmnjXQT48j08w3MiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKNO3dcTJvFGhJ3VWw+rHHDhPmA23WbTvU7HpNVgs9th+ww/wBROgTbMA/6kROguhWXbqkuRBmJoPv1GsO8gNgQUKr8Ruq/BJGwEIwcTWTVRWK3HlstKRPEz/XQGSg1xqR0tGVw2TmpRah0NF/bdftjcqGqHNR9AqWIOo/Pp2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YKwEQNl/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SVhaOWVD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YKwEQNl/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SVhaOWVD"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AEF9B25400FA;
	Mon, 28 Oct 2024 03:30:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 28 Oct 2024 03:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730100632;
	 x=1730187032; bh=hb+yjRBJuT1IgB8OMQWHedpI5Amf0EIw/4fpbhhSnQo=; b=
	YKwEQNl/KGfoUxbQ+ry14pA05t8ZDFxeDLqewQdurX1rH4wypfci4Flt1zl9PXOd
	w2p5Nyg026fVeYqc1Jdrmi0GKjGKGHvYYj7Wv95RN7c3383KheHfvMyo7F7HnloJ
	oumCZQbOtU7bij5Nicd4pFJVK/ToAPNodl9tr2hYeaalIXtdaYPoRVyFHVv/tQkg
	6c65aOAYx1MjoGf0ue5uOxBc3LP8DaXiKe5Eh0NuP1XcwHgCfIs2yMIrapYR7Nag
	SLo2pvXKoaNlUdyW0XLWd6LLVFytfXX5wxgBL+IdBJ1IHuTggks3cUPETQZ51zdc
	B9rUHGV+w6WBn2DBkhPCVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730100632; x=
	1730187032; bh=hb+yjRBJuT1IgB8OMQWHedpI5Amf0EIw/4fpbhhSnQo=; b=S
	VhaOWVDX81Rd1wyOxAf2X3dxPluptsPlDjb4RnOVaKCan/mUGcHQWrAAJK+di3sy
	zFNZ8MXmAI+0qRHh8ZnJg1hPABJ7v6AbMaXYehAcu2K8Euze/lBn7SiLzW52eZxF
	Acwu6/V/SZzeUqLyG7c4m/Y+Uxby4b5eMjJwk1k0fEM4YuF121N9a13FCJ2ZcUS0
	kUOEwe31VMkfin1qycU8wqLdLrBzjvBsGdR/Vsf0Y5EBBi/RPOEs3X2CXSY56mRU
	kcy9Deql/5Do9Y52KOD/gYAJeoTPIZpLicscxtlP40GmJHZj1x4abKW6t1NY48Hg
	QRp7JpLUgBU+kXKhjU5nQ==
X-ME-Sender: <xms:mD0fZzhzVx7zqCCSFuW2Oz-ltkGbmf4HfOywkJlBdAc5IPgc-wNLeg>
    <xme:mD0fZwB7VoyluHvIGTFhl7RAArCon0wKS7POO9BJUnT2e_ErDj7p44M2UL9rkSdNy
    T5GBpfMI6G6SAkkiA>
X-ME-Received: <xmr:mD0fZzG3tM4QxzFTV8LNoV9OgbOX6xSzLkx9_aBK3nU1ReeuH2yAxI4MgkNEzyKqsvvRnLVAdOgJdLlNpaL9puZ46LFvDa9I4LJrCWevb4CNTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdr
    ohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mD0fZwRylwMtTAC4ECaIGMLqEmDRI7-1QoMbWxy13JG_RewT514r_w>
    <xmx:mD0fZwzo3mdXNMdM1PGYg9QJsSYmFrLtn98ZZlAhIeNHS4Wh31Glhw>
    <xmx:mD0fZ24xWlJYI9phAI1dcFxCVfEqnx95rX6-bp3p56D3o6o8rPnhDw>
    <xmx:mD0fZ1xx1YBtLZE8OnF-Jb0bzUmGoKbxHhuvA0Zb9JocAY8thxiFDw>
    <xmx:mD0fZ3kW6EPuOiC0RcuVgQlkssF6jR4CjEt6tbUYnqf1WMq8-wS3OIPr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 03:30:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a89a1e10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 07:30:25 +0000 (UTC)
Date: Mon, 28 Oct 2024 08:30:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>,
	Christian Couder <christian.couder@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, gitster@pobox.com
Subject: Re: [Outreachy][proposal]: Finish adding a 'os-version' capability
 to Git protocol v2
Message-ID: <Zx89jzejV3lMxWr8@pks.im>
References: <CAPSxiM-4okXfiWZtSNArMjfXzja9wBrMaEayhqt1hvJpu-PHkQ@mail.gmail.com>
 <CAPSxiM-YAAMwOvH8KYO+qKahCBHgw-NDb-eHJKNCZyk8xtpeGQ@mail.gmail.com>
 <Zx8q7jnDIS3_omBm@pks.im>
 <CAPSxiM92YO8askO7h=1jOy5PfOdrAfaKiSFv7aRL0iCT4BcTzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM92YO8askO7h=1jOy5PfOdrAfaKiSFv7aRL0iCT4BcTzg@mail.gmail.com>

On Mon, Oct 28, 2024 at 06:20:21AM +0000, Usman Akinyemi wrote:
> On Mon, Oct 28, 2024 at 6:11 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > ---- December 23 - February 10: Incremental Conversions & Feedback
> > > Integration -----
> > >
> > > - File Renaming: Rename test files from t-<name>.c to <name>.c
> > > following the structure outlined by prior contributions.
> > > - Clar Suite Integration: Add the module name to CLAR_TEST_SUITE in
> > > the Makefile to include the file in the Clar testing suite.
> > > - Conversion of Test Assertions: Replace the test assertions with
> > > Clar’s built-in functions (cl_assert, cl_assert_equal_s,
> > > cl_assert_equal_i, etc.), enhancing readability and functionality.
> > > -  Patch Submission: Submit each converted test as an incremental
> > > patch to Git's mailing list following the Git contribution guidelines.
> > > This phased approach enables targeted feedback from the community.
> >
> > One thing missing here is the work with upstream in case we want to
> > implement any functionality that doesn't yet exist in clar. You mention
> > it in "Additional Goals and Extensions" though, so that might be good
> > enough.
> >
> > Other than that this looks good to me, thanks! Please don't forget to
> > upload your applications to Outreachy if you haven't done so already.
> >
> Hi, Patrick
> Thanks for your review.
> Will it be better to include *work with upstream* as part of the whole
> timeline instead of adding it as an Additional Goals and Extensions?

I don't mind it too much, and as mentioned elsewhere I think that it's
perfectly fine if the timeline is rough. It's more about demonstrating
that you're aware of the steps, which you seem to be.

Patrick
