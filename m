Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE71F5413
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737962781; cv=none; b=DPaG+08s6eqw8Qb8PwjYE/nY3qfnCHwFB0P1VNdjj+Fw3+ZAGfeoQvUg24sOBNSdJo93ln0JQw+ydmuAsydH5Am0iDSq6jopaAhaxBtUY3yGUlhqvquRrEYPf+o+0pXDIBdrRTUjcPi33wVEtsjNRxi/Nh50W8QY/bHWABSIFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737962781; c=relaxed/simple;
	bh=p5gfJOmx8q9epqGBvTosCfZFC9FOo6aOlD+v4P24CzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmHc/swfDJWU88QA6TeGxTUmHZV6FY5814t/OjJKBrFBMgMhHLe+8mT+Tr67DizYtJ40CVE8EFZG/+6C1Y9MWwA8Ed2Sd2P94BJazqE+9LQsAmLoM3nIwE523GI/+DodrWiY536UAtDon58SeXA4SDq5yd2Qd5DRnBFMhsKMlpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cuubI3sC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lYBezBKH; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cuubI3sC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lYBezBKH"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 96496254010A;
	Mon, 27 Jan 2025 02:26:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jan 2025 02:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737962778;
	 x=1738049178; bh=rAFEjlAQ8XQpUxR8y1KtHdPI9ql6ID3g3HVxUaxvfeE=; b=
	cuubI3sCI4m38mB4/j2dUQ42VwYPgW8r3cTXGxhnHQq6EhMAaYCntdpb9tF/kkcT
	JgV2ucYFJ4OWUhYbxecK/QOG4QaCRTE+S2ul70lKCifBG70Dnuu7TqjXLQfxTvJA
	zfxUanUGhRM4fq7LZ3w7F0jqH1P7PGDe069kv2mZj3fa78iPWA4w6qvPvmTaj9GL
	c3u+IlaScu7FUFohrNiLt4Mq4eQYQL7Nuco5c/5oQZn2XeCsJPkFRlZFeyk+pSfY
	c0G28x8wY5jRpw14EUAfoAeaq4n33DV/Z0PpvzWeVAcu+VZQHTQnoQPyFkSMwIEa
	Hcga4UPoNJfUM5GdXCZrxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737962778; x=
	1738049178; bh=rAFEjlAQ8XQpUxR8y1KtHdPI9ql6ID3g3HVxUaxvfeE=; b=l
	YBezBKHJnZIO38Iv3r8gzhOa6C8S4oO0nOQJy92zIK3x6wWxdp/DRHj2tltdlbnw
	BEA385D8ZRqILUn0S1PlAhdK/2XQFwnRztNIu72+N1CNr2/vpG/nMNSmphwDN2JV
	q/KS1uObYzgaeAzG9OCQA1MIGrlc/2pdlpwqxczuVo4hGuiAvJJ/ZM0Lkeewz66H
	HlFpVlmYPYk6sqwmjmz66mBys6LM0Z5F39qBSbWEC72iQ065L4fuam6siSAtidJ1
	jDiWXaJq2zpCmrEKfcFKEDCBx6R24k+FkoGodITt7pDztzrBLcK+wTwnwyxD0vOB
	JVbFTQryAsIWduVbANtfA==
X-ME-Sender: <xms:GjWXZwQNPM7hFGUFYY-DSwJKFCAcTNdMuWAQnN532zcWz58saA4Gcg>
    <xme:GjWXZ9w-6YLV-II1ghpsOE0DNcWdRkHj6LZKraoUWtuQHhCX2LvX0OduU7i3V3nwU
    zM-sqAPoNT7kUvjFg>
X-ME-Received: <xmr:GjWXZ93D-f0JOOcnKwrTa50XGHRap_xMkaJSc18yFIEvffnMCM6FnerKAKqnCfvhynazCGmo0za7J528WS6fC09Qs44La5UXI9VIO7lebXOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefje
    eitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvddtvdehtdduvdei
    uddvheeifeekrdeftdekledquddqshhovghkkhhlvgesfhhrvggvnhgvthdruggvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhovghkkhhlvgesfhhrvggvnh
    gvthdruggv
X-ME-Proxy: <xmx:GjWXZ0Bf8AMMjLpaS0sz_Pz8LfG0H8q1pJ2XCpAH6LzoVXDoa2VDtQ>
    <xmx:GjWXZ5jSLy4GTNksDdgIIP2upoYW8Enjn1R9w1IBtwD0nhd6rjY3jQ>
    <xmx:GjWXZwrXlxZE9b73AIqdKxc9ZyVgFcS0CCfTok91C4cpqXXAK6axsw>
    <xmx:GjWXZ8gcr2XKzJulBeObyQ1QAPFjsVIYyQqZu6ijv8kiMquX9B-fMA>
    <xmx:GjWXZ0W7luYm3ORVh254TXV3RoAQbdECaVGeBkL7t5fFSknq2_5FdB9r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 02:26:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ea5ec3f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 07:26:16 +0000 (UTC)
Date: Mon, 27 Jan 2025 08:26:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: 20250126125638.3089-1-soekkle@freenet.de
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	=?utf-8?B?U8O2cmVu?= Krecker <soekkle@freenet.de>
Subject: Re: [PATCH v3 2/4] date.c: Fix type conversation warnings from msvc
Message-ID: <Z5c1F7oqsaPrHRiT@pks.im>
References: <20250126125850.3195-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126125850.3195-1-soekkle@freenet.de>

On Sun, Jan 26, 2025 at 01:58:50PM +0100, Sören Krecker wrote:
> Fix compiler warnings from msvc in date.c for value truncation from 64
> bit to 32 bit integers.
> 
> Also switch from int to size_t for all variables with result of strlen()
> which cannot become negative.

As far as I can see this patch only does the latter and doesn't do the
former, so the commit message seems inaccurate to me.

> diff --git a/date.c b/date.c
> index a1b26a8dce..0a3fafc8a4 100644
> --- a/date.c
> +++ b/date.c
> @@ -1270,8 +1270,8 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
>  
>  	tl = typelen;
>  	while (tl->type) {
> -		int len = strlen(tl->type);
> -		if (match_string(date, tl->type) >= len-1) {
> +		size_t len = strlen(tl->type);
> +		if (match_string(date, tl->type)+1 >= len) {

Formatting is off here, there should be spaces around `+`, even though
you simply followed previous style. It would be nice to point out why
this change is makde in the commit message.

Patrick
