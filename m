Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B43B8D40
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527689; cv=none; b=FCbctGNOxoQzoEvmFVbw+ccBDvPtdKwi9CSbgTyL06LIOZYlkZLL8ISDXxMlYOjqaUdrxCpT4hmjIDuVmuZ+zg7NJeyO47ZE0eSA/3fMBFSm47doZRMUCu7qLYOp7Jz4+2ISmQZ7gUBvq3K0gRtlBIxUYXCTXvWv4XXQBd18EIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527689; c=relaxed/simple;
	bh=lqDwvMk8gdn/IrrVs3mqVCkUUppUbctAEgkwpF9HESw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0TIfYZ8SP9jWqp39+W5SNiC5yo1t1PnYUElvrZmAwIO9vevc3qakTeUyGPVQSI0oSXipWMXztXy+sprT/Ng0IFEWokX5bYBK/ottBWzarIfWnWhqgQ3POF2uCsu/fRHvJD3bRRaz1sRdYbCe6ta9IhZ/MsQIpLe5siz0S4vZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kgI/zLTw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p+yu/Yxr; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kgI/zLTw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p+yu/Yxr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 93EFD1D001CC;
	Thu, 26 Mar 2026 08:21:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 26 Mar 2026 08:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527687; x=1774614087; bh=GvR0LnkAGx
	vsTAT5wBczsiKDQLkpPTuK/Q3Did7fuNY=; b=kgI/zLTw0Yfrf9iYdemuLxWBBf
	65ooz6JMIssyiR33vHixc6ItDCkIwgZfCVo4QVQ5+5cYC7SUab1iIyxJ3AHDBCCd
	52Sagex06bMe4kQqEtgAcQ45B5iE9ON/Vy0foEQa3Sm3tKK1z4qYPqPyKtuz3zq6
	tDRtmOyr6v8fxv/xBl8oS2iFkKuh+Lvj5d2qeJfo87y7aWxFELCVHcZYAYl5Q7WL
	b3QJulZUE4sAoaHBzE6icTBr/4oH3f8pMSFGexQW/Mc0aVoRib4JUmx2SnomftjQ
	6uyiRpLLYamVTA/2wVn7QQTA4ebJJkESkmCj9IpoGtj062ATa8/5zMLPvHWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527687; x=1774614087; bh=GvR0LnkAGxvsTAT5wBczsiKDQLkpPTuK/Q3
	Did7fuNY=; b=p+yu/Yxr9YxYDuGFgSVZSceqLikYO5kHNTOvJgXSBYPt/vbHCsJ
	nPo01ZO7f9C4tWCMMlN9eWzAzeJYNuF5DBPYhNYZcPlXs0O2sIJWmNZ7EGlssPkf
	LBlC3tY5/nOZED98ejO0Vr0+uy0cy8b721d3ugm/ZFV3HOPgnvaVHGGXtstCOv+p
	yMf+23ojFyvEUBKgoZ239clp36CT8FpMFB6nfWzoUroE9P1czEXd5j5sQp1mOTPS
	RkUUZgwYMbTA1OeKep1vwi4xaXrPd7qsz/wm5RHc4QyrE9JnwoGtnDgTDD77Q/1I
	f8de1ow6K1Lq2DiDSNMHubKLqbvZJONRO4A==
X-ME-Sender: <xms:xyTFabgcQjEGtMTZbLmhNmrmIoYiEuv91GAhGCYRVThyfD0n6LMBKA>
    <xme:xyTFaaSOYWfGw2pNDGeaEw2BPiojFnrqu1kHyip4T6MSxhvuNuuzLMZ7rzk6AME2I
    aQWAXR69AJ1x0y6Heek6GrKyCubP2n1dF7Se5-zYX9cgtNkJZFq3Q>
X-ME-Received: <xmr:xyTFadXvJE28FoDsmrNbmStSznXCdsaZ86ZcGTCASr8PhCI5jVCmQdmS2fyyIr7YPirBQHJIgbrzmdf_wVBqq_jQAVUF3e_BYwHYh5mFm7Ek3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrih
    hsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmih
    hlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xyTFaeTpPmVEl03uxTT3CFEW9-ZQhJSssVER5rtErkhzXGF5-uMkSw>
    <xmx:xyTFaXlC0T82uNp5hCiA0AFmiHIFI7u16WU3RHcOWFF_sgdShe-CYQ>
    <xmx:xyTFaU5jq7W3bnFE_fELUMxBxWjGfsvnfXrPMLcMKszwfa8dlM3qcw>
    <xmx:xyTFadi38_h2tjbK8iTSWr7mBRMq537h388dBhw3eO9q31hEmc9z0Q>
    <xmx:xyTFaTCX_-gxgVGCZfQyACfcK_srev3qQBk9igaUUp0W8NkGhVhqhvXM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:21:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8450e793 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:21:25 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:21:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 11/16] promisor-remote: refactor should_accept_remote()
 control flow
Message-ID: <acUkwrm1rN4l4qgP@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-12-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-12-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:14AM +0100, Christian Couder wrote:
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 8f2c1280c3..c2f0eb7223 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -665,6 +665,12 @@ static int should_accept_remote(enum accept_promisor accept,
>  	const char *remote_name = advertised->name;
>  	const char *remote_url = advertised->url;
>  
> +	if (!remote_url || !*remote_url) {
> +		warning(_("no or empty URL advertised for remote '%s', "
> +			  "ignoring this remote"), remote_name);
> +		return 0;
> +	}
> +
>  	if (accept == ACCEPT_ALL)
>  		return all_fields_match(advertised, config_info, NULL);
>  

You mention that it shouldn't change behaviour in well-defined cases
where the remote sends non-empty URLs. But does it change behaviour in
ill-defined cases where the remote sends empty ones?

In other words, does this fix a bug that can be hit in the real world?

Patrick
