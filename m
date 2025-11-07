Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114B280A20
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762495594; cv=none; b=EsfG2XEBGL7yrlb0mOGd/E69CQfJgiDu04sqfeGbVCvOCk96DecO7DA1FjNO2uJuvYWynHdYr2OTL9edL2yWAnYERRjdjIIV9tbGYOMQhBFus+NbC67TjN11NuZPOdO+QzTFcyASRAtUmJYhaM8Jp44J8e0NBHYcbNnHJIviLIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762495594; c=relaxed/simple;
	bh=E265LySNq11FCSH9GjU5vzuA7yOqIXqYljirlfOukG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3jN+2WJ2Ptb6kQN5klmN4b97euw5fE6NAbF3JM9Ya9UkNvbUoeoKL5hWG0S14YxIbZjamdSzFKmUFV3Pw2kpCuqvbiL0lJwVTidwI4EFldgkjgktn29OZdn46kaWldsvw7Um9iexNeEkXkBWLVOESERZ/7FYfWMJFm4Ne8KXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PsShZLuD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lpCDCbQX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PsShZLuD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lpCDCbQX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E1CC4140012B;
	Fri,  7 Nov 2025 01:06:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 07 Nov 2025 01:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762495591; x=1762581991; bh=yIfrnQXIkP
	/oNioT2TkMxku0dh45i4dJm1Ogb3ZUXqc=; b=PsShZLuDnqST5ylBXja2MkNxmW
	ixssw88zn2npRId+j3Echa/8re3zMICq2rSUodQy+XmJ5Q4YhzbjbqznIKcKZkzf
	M2JsNvFpD1dk5sA5enBz26pZuepu07JuSBZ6bGI0UPTk1XxqZPxZGYs1lCU9Ivzj
	vtpJEMOCeYr3Uv9/0rVFxhWRBmUvOQAHIpQlreWpwAz8ieLNwm9zRnRYQe2mN3pk
	hKzc268e+5JvwWNMnCVQEW0fBHyC/woyMFNCc0xmLLcn3NT++pf/aoz9wV2mdezo
	hoQcdddM6vJ/T1sZJDTRFoNKgw2wQb/Zl1ROp4r9AU8S10FNAS6m2gn3Gevg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762495591; x=1762581991; bh=yIfrnQXIkP/oNioT2TkMxku0dh45i4dJm1O
	gb3ZUXqc=; b=lpCDCbQXeQd2gSMi6EvFFhKxgSrXI7SeK7FUzqIPRL0sQAkIYEN
	QvhKSy9hPprKuYziZ2NCMkNIRIlR0CIi/6dqLBXflmQFoNcXMI3Hl3NX8brir/ZD
	rQtSwlBHtZ34TGeoTg2/7vRSaEHSPrSg/KbdQDd6OgHZd+oTfTJCkMkN6MazyMYM
	GuXOIu4G6UCpm7u/f/ip3y64ncY0UoKxNqPWofH44f4j+6Q8YaNlnjZ+31ajD4Mw
	rVAXkh+87d7GSWvqBJr5ruw9YajIhSstewCq04KUyBodWynMMZdSIhQomvG0v0PL
	cfLMVxgCBT0wfEJO6cWXYpEGi8j9sWy0RnA==
X-ME-Sender: <xms:Z4wNaYZdu2RkQRSsZepfJm9nHE3pVlERubMhGhi3hDgPw_sjuwK6JA>
    <xme:Z4wNaab2gwjDy_NBVY8tTM0CUodaqoOlSCiR6OnfWdHlyq2YGn-W0I2VREOjuJor9
    mIpRu3FsSCPxrIZ712dWuCIhHPb9PR0_OFPzRMnutW1_bCvcdw>
X-ME-Received: <xmr:Z4wNaX82u_ITGavQPraIrBJm-CX7qrkDnPhVCjseyPOEwYuLl7imx3G5civ16_LNq5nFqQWnjlIRT6kT5_cEndbnauYoySOanNq5fJXMbRMaPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeekledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Z4wNaRhc4MRXSDseRHYqIN3biOtOY4SaPOdePxo5ITkPhA783FFFFA>
    <xmx:Z4wNaff7pckO_2MXFsVFXUhedDXC1PhmvbbKyYoXXT0KKFieStSAwg>
    <xmx:Z4wNaQqAVsQ7Nwq7te6uGP-6ICjIv2iNjo8iXXN9MEV4DE8BtOl3-A>
    <xmx:Z4wNacCTAI0lh_NVr4-vTwKmlyAkWO6LB-uwBgN7CejJwT0AOz5dTQ>
    <xmx:Z4wNaXfRNO_QX9FdZavpBR8b9hg89DiFXIO7jIhbp-bQwN4Ynz6GDC6v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 01:06:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7f882de (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 7 Nov 2025 06:06:29 +0000 (UTC)
Date: Fri, 7 Nov 2025 07:06:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	jltobler@gmail.com
Subject: Re: [PATCH v3 2/5] reftable/stack: add function to check if
 optimization is required
Message-ID: <aQ2MYbQKHUVoqDG1@pks.im>
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
 <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-2-d611a2a95cf5@gmail.com>
 <xmqq8qgjhvnm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qgjhvnm.fsf@gitster.g>

On Thu, Nov 06, 2025 at 10:18:37AM -0800, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index 49387f9344..826500abed 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -1647,19 +1647,51 @@ static int stack_segments_for_compaction(struct reftable_stack *st,
> >  	return 0;
> >  }
> >  
> > -int reftable_stack_auto_compact(struct reftable_stack *st)
> > +static int update_segment_if_compaction_required(struct reftable_stack *st,
> > +						 struct segment *seg,
> > +						 bool use_heuristics,
> > +						 bool *required)
> >  {
> 
> Am I correct to understand that "use_heuristics" is almost a synonym
> to "maintain geometric progression" in the context of this patch?
> Are we expecting other heuristics in the future, in which case, this
> may not be a single "bool" but a set of flag bits, and until then
> s/heuristics/geometric/ might make it a better name for the
> parameter?

I don't expect that this will change anytime soon. So renaming it
accordingly feels like the right direction to me indeed.

Patrick
