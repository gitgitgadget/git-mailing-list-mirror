Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A1D35CBD4
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843694; cv=none; b=boiUSyzdRQWODs4cfMet13XIqORMrTKGSaQaHMVtJ3zUGwmomX9zQj64+pmmjGvnsr2czNl3BeIPEGKv+sAWgsF99X7T1Yhmdp89zlx8/blLZeeJ3avuq0tQQiADL6XPCHCulb6vf+n8NuyP13D3UbRryE2rK2F4Jgd4rFZlnKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843694; c=relaxed/simple;
	bh=Cu2VKp28o2kOQWASu8+jOq0SD7OZO93Meaogt0lLs/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev81ib5lyrg/2KWfkOz8qkqAf+7j4BWUGM+Wg/bam7K2iq75r/rcIRrjc/YuLa6NHm4PQRO1tT5tp75se5qY/I+8iTzA/KyyaJpgLbuj0YJKwmRD9T/rgQDVuKz/f1DxSXfOccdMaHewHnKPhQP+sX4zW9pUSwT6JeDZeLf/DQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lFcXv4yh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wOgVn+4L; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lFcXv4yh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wOgVn+4L"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F0AC914001D1;
	Mon, 23 Feb 2026 05:48:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 05:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771843692; x=1771930092; bh=jgTX0gbxy4
	hRk3HKxQEqVUjNez8RNnyCVLv9F/5QZdw=; b=lFcXv4yhr/n/NSnzrvApAiAqLo
	kAykQ3mR3KwSOe+RFJL1srcAJXTkE+Ik74eFI0hF94OvmkNxTvrSMdijMNzQjmdj
	4mtUsNbZbMIdaYkEyuii/PBKvXLc/Z34jeOr0IhxqXUA3FbgOUUHUCGuC0nlUzk1
	qes4hMgfSDVWZ2UybegIlGRMTDomGSomkc17hm6KisGx2KEySMlZzi4mym8senog
	uoXobpVFDqA8Teeg2X9wuG/0kHY2bb4dFFgU43rpSSS6QXh2eRB28eKX69hcKijD
	9Ud3K6ZgSVwI9D6JO+YOdNNHvxj33+7TaZNijLUItUXBTrTBjJnISPR9j1BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771843692; x=1771930092; bh=jgTX0gbxy4hRk3HKxQEqVUjNez8RNnyCVLv
	9F/5QZdw=; b=wOgVn+4LJroWG3Hrd91ppjhm9dasoYELtyYx318a01VjrEENGDM
	uLwIYSJxTmMmu3zOkBMCN+jnUEHJmDSox+yEAZZfWabeL4N3ExMdDj76tLyoSFCU
	Zi/3egE3YynLCYMonU11oodGpL3uXWrVW0sSUVHA6RboPgXZG1CthwqSMiXVfSkH
	AifG0T/t21THYlMI4ZK/CEClr9p+ORSfdcGrDlsDNxti4jFf1Jp5+qV09rbhRV4F
	ijdZvuMU4Krr942uavQUZjA8J5jLk2YAkmLtsnuMUpqtXbPVAxOCAGSxZ62XxC9/
	dDCHd1xC2G9XOb1rh7uXTbOoXGHrE5iidAw==
X-ME-Sender: <xms:bDCcaXg_jLYJw3BsWNOMZbKMglrxUNbmab7YbnWg0hguYf1eAPdOcg>
    <xme:bDCcaaB18CWZNranRfxvCVwwmhiJxOE8coGl5zXRFN6hLW-ufY0zX1iVXncdUWt03
    XucdwtzSSfmkv6Tjnml0DIgY5ShmFsU_TG1OTJAx1yLnsGw7gTSiSU>
X-ME-Received: <xmr:bDCcaUvL2JSDp95eUbrxbAw5UGSKV3sNZM2-FrzoTchjVIXXU-rOk-4Vt4DSYYhaJab3yIVb2Xvaz9PjU1b_sWneNwmm1Ke3NIfaS5xt_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bDCcafY58sFxnLMSHY76_uGNy4urkV7aOHkN0DWxv0qQ6028kbi_YQ>
    <xmx:bDCcaXUvxODBxYAvR0P_DhjuHe5obkpapjkKBE_Py8dyfTh9ZNtVfQ>
    <xmx:bDCcaT4-n8kDFJHtKCg8XiD6XLheLVXmfCRig1J7gH1ovTV4-4c0VA>
    <xmx:bDCcaSjndevlX9OIsunbhRq34trgVuAO0POKF7RC7DJOtHGTrRZt_g>
    <xmx:bDCcafRx-BdhQ61lg_N5SAfjwaILsknnWMM8ZKm0dgUMhJz70GwAoI9H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 05:48:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 275a6e88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 10:48:11 +0000 (UTC)
Date: Mon, 23 Feb 2026 11:48:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/17] refs: generalize `refs_for_each_namespaced_ref()`
Message-ID: <aZwwaVr3sObAgley@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
 <20260220-pks-refs-for-each-unification-v1-8-17170bd99de1@pks.im>
 <CAOLa=ZQjZ-YLedF=Cqn=Tb8-rhX8=+Lnd2VKv0fn_ryrO563_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQjZ-YLedF=Cqn=Tb8-rhX8=+Lnd2VKv0fn_ryrO563_g@mail.gmail.com>

On Mon, Feb 23, 2026 at 01:02:56AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/refs.h b/refs.h
> > index a66dbf3865..2bde60aa0e 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -468,6 +468,12 @@ struct refs_for_each_ref_options {
> >  	 */
> >  	const char *pattern;
> >
> > +	/*
> > +	 * If set, only yield refs part of the configured namespace. Exclude
> > +	 * patterns will be rewritten to apply to the namespace.
> > +	 */
> > +	const char *namespace;
> 
> Nit: should we also mention how prefix is appended to namespace?

Yeah, makes sense, will do.

Patrick
