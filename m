Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFCB18C00B
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731669451; cv=none; b=clxfe4/2Fe+txf6kdRGQsrU/rZP/LmT674fXkTbjgMcY97PCfZcopXGeiAKNCGty0MYC2PaL7JnYEWE3k1Nps2vl03kVgIBgHoCevaTp2m/tCuyWEhvKYikRLRFuSK9GmourvhzbxCubMDVbnJsKjuLv157ysc/opTvT+BNc/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731669451; c=relaxed/simple;
	bh=Eae/Uy4hDxzQhy4xrLo32ygY8wuTcqk3Vji5cg1yl+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUtDTMKG6xPfrnXouZ/afuND+iCvuUsBExF1kRKTIzCRJZ06G42n/G9GrMBcHcLtPluBy0RdLrJnqc0WzDNl7NvPH2vQvj9SryK25NPQ/gY1+Xuze9qEDU+yaKezYDwUK0ZX+P88NMaxZrSXG8OW+Ckyavhw9yhiLbguMNYIJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ae96g6Wv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ShgZoDjo; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ae96g6Wv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ShgZoDjo"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BAD4D1380255;
	Fri, 15 Nov 2024 06:17:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 15 Nov 2024 06:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731669447; x=1731755847; bh=qC6t00mN8t
	1yXOFgO7MwS78sKitkJhxzfGc+hpKMDNA=; b=Ae96g6WvvvJd3xSxWHjVfqcS77
	J4KhQWSMXO6hnEA7aSEkl6BGNZKH5ARnC7ZWBvBQ44ZnCr8md+Rs7xCTnttNWlSs
	i6cyO1+9KkaMPcE9o7I+5PQVlzDOqixar+x6mmqN3fF2EDZzUqjuFE/R795rozmV
	Wr3ZTMRft56Pk+F5m7p9GEYyLHeqId/gMqedv6f+XB3lp+nf+juiqk33+muWhtNY
	Dh1INcXuMfjAa5aXSHcwUgSjU+JwshgDPafFLzMJ/1rOpqF0Yww6GFNSnbMVSYMI
	n56i8eG+gKD12dgtxL+d+CakGjWWZ0zY8YUGHnSLOMCZHRLtaCpqezYUkUOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731669447; x=1731755847; bh=qC6t00mN8t1yXOFgO7MwS78sKitkJhxzfGc
	+hpKMDNA=; b=ShgZoDjorDfpHvReBbYhW4RLMxDOZiS7DxbjJiVQ+HDVDAm5QwN
	p8arkaDi8dQWVf/S1iJ7bncGhanS1Kb819oZfeiV3ubN2fUfB58r72d4pKBiXiIm
	Ha7p57UNzhhd3seEwUlKCWhU2eEPxD07XUTz++l5ita+fqMMHN39q/4K5X7SAC2l
	XcX/sPdzZvop8CO3W1trxi14DdIhffXLjv3yAu7E1QV8OWod7JlZTO28JNP1vbpG
	oEAzXsH5OMSMryqpUgAcKsw3NOCdJwI49tc2pUHt+q7vvNBhjnUzdmyb+KY4+wkn
	EMk02EINj1WN0ZQlfpog1VhHSdV8Ze93ZtA==
X-ME-Sender: <xms:xi03Z7Nr782SoP3YeGvKRFoVAs_8Zpwz5hSu3Jh87zqT-ZaFw_21bA>
    <xme:xi03Z1_JrZTVEraC9EscqFTTYFQydkPPSfX_ODnLZVsa08B5_gCcvHaycmBqt2NzM
    ltze4tNe4FCOz54qg>
X-ME-Received: <xmr:xi03Z6Rv3m3uJgu4vUyzPUebslNsW6yOj5LYws9AmCd4s-6AgfmuMOQlSBXMuOrTeRa2o8Z37q4Zng1eTWGxb1lO0agger6xr4MG0t7TvT_LFkfo6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeggddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstg
    hoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepuggrvhhvihgusehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepvghstghhfigrrhht
    iiesghgvnhhtohhordhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjoh
    hnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:xi03Z_tMFgitUBToW-8UPPprDZaSzGXqKcEEXH-QOIFyStt_-oG7DA>
    <xmx:xi03ZzcNUFiuRHRE9mFZRsh-Msnt0qeTZp8W9gQq2urgVVeQkDybtA>
    <xmx:xi03Z72mj-cN3Zp3ubOe5pvILarD4BOAYXgcYEBErL_oEoZn57R27A>
    <xmx:xi03Z_9d0bZhgp6w4Mp0LfARW_cBf7zr24H9fVtrphKIqNxyDZu_qQ>
    <xmx:xy03Z0VbwDmYy2gGcFI-Ddj78K4NEyRSGYXkt_tvpaNBozjLuifrDXGd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 06:17:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 414887be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 11:16:39 +0000 (UTC)
Date: Fri, 15 Nov 2024 12:17:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RFC v7 00/22] Modernize the build system
Message-ID: <ZzctsGvnJvaHe23z@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>

On Fri, Nov 15, 2024 at 08:21:12AM +0100, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series modernizes our build infrasturcture. It refactors
> various parts of it to make it possible to perform out-of-tree builds in
> theory.

I noticed that building documentation is broken in this version. I've
corrected that up locally, so this will be fixed in the next reroll.

Patrick
