Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5F78C91
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752041797; cv=none; b=V3kceX+J/oT6aKJ2cH7TBvJT84GDsfzHmKvuveCWhwS2YLtAQz+6TooBGU9DwAYR50Dft39tJoLD3MYCCBRrGrqaspSsFdxDZ0iN5Jv6vhl/ePp7dm0ga5QZyTazG2SwO5Qk7nX5iDjaZsasUCGZRSQE1SXj5Th8u4iO9mXGGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752041797; c=relaxed/simple;
	bh=WNmi7FNn/YpEIs/2f7NNwVb7zb47bFhgVQKepOj8Cxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA/7ic1mRc9o/4j0uWzaAt6eRZBULhXzJKPApXRFVx03QgnnCAdEQ2rePlP3QFWrbyD+wvtZctoH4EnIWAIAW1W4me3RO9i/l7/CT2U3E0TiX/K/qMMFhQttgUbKMIg9L/oZFn2Ipr0X/2VFI6B7YG71eosloilUMxeaUYPAwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HHALLdz/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lrlPywut; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HHALLdz/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lrlPywut"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 853CA140021E;
	Wed,  9 Jul 2025 02:16:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 09 Jul 2025 02:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752041793; x=1752128193; bh=ILDTsX7M5U
	ymOuwcn3ouU1EODJnpwxEBKGovqKMnIBI=; b=HHALLdz/S6RfY0Wj/sXH1H1DPD
	xTybRdyoCFXHGhLj91T74iW6/bSUWzNHZa5E++MSDDMGwbTzsE4R7DcCQqVfv+AF
	GrSZoxEhPIJa6Bek/Oa17liKdOHv/sUEXlOKUfkeGaRsWt/hSK1unQWA5kbmLu6P
	iuQzdjRNtSL260Qeqn7K5FzjXjzAewZpdklzSlnoSnkWsEJsum6DKeZ+RewQSPBv
	eFVR+/KDA91ZmdvxsVEJX1YGyXvgkBsQCFm4t0m0daJlexJ4e5/yN+H8u7Z0rFk7
	F/dghC5crvJDQrfBo/lsD6HwpacRh/S3D6hVr3828wE9huecVNwdCxvP+cwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752041793; x=1752128193; bh=ILDTsX7M5UymOuwcn3ouU1EODJnpwxEBKGo
	vqKMnIBI=; b=lrlPywutLTV30InGMm0nUhv4WNf0hDILLGwEQMT9tUb3WF4hmGr
	9yG/L68mpM0RjZf5REAj1AfsEIC38Q4E+oR1p7WFRrffnXOhXAd57/KogAr3xDKL
	F/fmpKxwD0gRDsa/boxfJikHNEbPubSKY8e8IsmETplvnnoztSPClJi2WDVkRAMM
	80IZY2PkreBpEPs80Fy2zdSHexRIL+Vwg9gHDb4Q+mP/JRcZM0x8XD5uNiVFfQso
	jAO4ABRQF9ws37cKHcVF7kIk42biTUfhxjhoHyC3Garp/XjeQIPNK43QtjjBGzZR
	FHy24Bfe6p/znZWzuiRCIZxOXVocl2+2j4g==
X-ME-Sender: <xms:QAluaPkjf2DnSGX_WIdE3Swf_3fv1l3Z9xyXrGGpJ5ii88YV-0kuew>
    <xme:QAluaP_DFZ0WkynvAzfAt5Jft5RmxCTbxHOg_9NwZLs1NRSJ4h6N6Lwyea2eVRZHj
    X-X1vEzNFs-sep8qQ>
X-ME-Received: <xmr:QAluaErna0UEEeagRo95DqIj5WkHphS6FxR3INY5LgCd-o0T-pgf-7LqUnCBvQa1X08Nr2UHJ3aj2FCnH0taW1J7QKqoxXI1Iih0w3TU57loSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrghmshgrhi
    esrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepihhrvggttggr
    rdhkuhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QQluaIk-LzuwV28OvY-HP7er4JjHT6aW_85u_isvQ4e8TtRwz3mvuQ>
    <xmx:QQluaLj3CRHPiE-abyuvupParepSrhfyMeJzj88KwXGW7R5AB3Hpow>
    <xmx:QQluaAckMWxFJq4zI4lm_7pkcSRbBvl3lgVrCdNm5fWySKVoVTKMNw>
    <xmx:QQluaLgQrGPXIUgvXawFkwIbiGnjMDIf5yuTP6mGDdVYDh3yE4-ymw>
    <xmx:QQluaBZTowbmv3D6zzdhED5le-e19PZpiq4simMEyq8xCjHZa4jBsl2H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 02:16:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4bafb324 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 06:16:30 +0000 (UTC)
Date: Wed, 9 Jul 2025 08:16:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	irecca.kun@gmail.com, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 1/8] meson: stop discovering native version of Python
Message-ID: <aG4JNtURJpMOTls7@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
 <20250703-b4-pks-meson-cleanups-v1-1-2804c2932abe@pks.im>
 <4ql5wzqvcoxrcbi6cznavtnfzwmh72tevixwgotvsx4kzkbljv@a55yhjqqqnym>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ql5wzqvcoxrcbi6cznavtnfzwmh72tevixwgotvsx4kzkbljv@a55yhjqqqnym>

On Tue, Jul 08, 2025 at 02:38:49PM -0500, Justin Tobler wrote:
> On 25/07/03 11:28AM, Patrick Steinhardt wrote:
> > diff --git a/meson.build b/meson.build
> > index 7fea4a34d68..21fdff0f496 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -866,9 +866,8 @@ if host_machine.system() == 'cygwin' or host_machine.system() == 'windows'
> >  endif
> >  build_options_config.set_quoted('X', executable_suffix)
> >  
> > -python = import('python').find_installation('python3', required: get_option('python'))
> > -target_python = find_program('python3', native: false, required: python.found())
> > -if python.found()
> > +target_python = find_program('python3', native: false, required: get_option('python'))
> > +if target_python.found()
> 
> Ok, so here we are not actually using python to build, but instead need
> to know whether to include this build configuration which is dependent
> on the target host having python. Makes sense.
> 
> It might be nice to leave a comment here to explain this. The changes in
> this patch look good though.

Makes sense, will do.

Patrick
