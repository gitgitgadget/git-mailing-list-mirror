Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3A71A2C0B
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016205; cv=none; b=NGn1Oa5nuPqtJrn+tBrvhF9wZZVsLfQiB/xiYXiCII3LCc3xmouuSt8V+/ijKxEX1skdr8FfV19NNZXrGTsEMTvPa36yMv3YZ0HhDycjdmJozlPd5L4Tf1DB5oJ1gYoUVX1hhtgLJ7thhxnoOdz+3ybXyBiwE7qcPTipU1upRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016205; c=relaxed/simple;
	bh=XDVoJ2+2M4Ikfo+NeHsRUMxAvPvlPJsyYrBL1LOEMeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F4jpxVVcGIXhaVbWDxFznpl1EQyLk/FxWgrkaycN/B172DLJnzfj63QpqR7LOywlx393VMSSWDGgCu3KXybBcDKm9OxEKrvKI3oP7GhGlPYzXGuIoFQxONdG65zPqTASsoDXRtGSUiCKif+memNrLdd+cHCKKuYIWrTt3z/95wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QmKF94p0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bip+c+hD; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QmKF94p0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bip+c+hD"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87A401400081;
	Wed, 21 Jan 2026 12:23:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 21 Jan 2026 12:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769016202; x=1769102602; bh=Gjfi/5r5WK
	PwAZPqL+aRrwxf1pjoGp6Sa16iit/tVzo=; b=QmKF94p0u8vKG/ronLDGhhovD2
	4PQIqkh87t5AAI+4ehRJHPSzZb6ax8RYwoJ3NcMVLDfXhwBXntibdftPOvYrGm2r
	N+K4rJPAUhFeeB6nrg+u+m0sYL/YLbhq7DrLH2tFQqNXCwuG1OBIcTj4dl5c0DHz
	xumZef3gpaerNAKmo5dhjadEcgbmfXO0R2QVktVbzRuN+bRuvhW6uFJPE6V/B3Y6
	MGK+SZp0NonunBsg+5aBPMTZphyMQad6AykH/wZOSUkdh9D5HT0nVFIkMCMGU+F8
	C0kpg4jjQIhYyIvLUKIbs4qddUuzcShr/DdRHSVS70/wZBap8ZgViR2QtEoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769016202; x=1769102602; bh=Gjfi/5r5WKPwAZPqL+aRrwxf1pjoGp6Sa16
	iit/tVzo=; b=bip+c+hDjlM3i3zlJDd2H4W2jxVQ8quVuQpMWllkS73RmeQrtjq
	cw+4F4dM96dnxgQNNDDhttH4UWF5cjlSkjSqQGSGMwMXXIFkSD7uMOx1yEc9QDRl
	YH2D8s0QbANX6EF2azLzF5GcRCaCrt7daYqG6vXyxlG/+CiJ67GeGwnTRLUPqEWO
	ALafo6XNvQG3+sS0D2bYXvdX8u644Z4RpFwgNPwc7MT5DTUCwA00I0NCIg9KdKBt
	BVIETptrGswqzZwtH3iJWUc25D6Hg7y/Mgg8V8iWCY977dasI90m42osc8XiiJyr
	7yTULRV57hq8kYzBcF1HVQE3z8L7S8sWKKw==
X-ME-Sender: <xms:igtxabaC6yuLF7Tg8qmnFpE5LVPrrZdxXJiAjeez4dSC1dgp7MITrA>
    <xme:igtxaRbsrAEYyeecofaaUk2sFxLAFj2mphtYxuvzhLlBG8Hv20ZeMC_szPdAldTMy
    lyCW2DU5zY1elWb_CYezz2RJTyrRY_RMUl9dGjCmur8mueH4ouhdg>
X-ME-Received: <xmr:igtxaS9X7jg56-UWwJO6zOvBiwjZ_x2fXD5rtm4yl2PwVWzb05aKf_1yJGILBY54hyz8PfgOqPlSHOh5YqsAkGX-DpCJRXLk_OrKc5k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehshhhrvgihrghnshhhphgrlhhifigrlhgtmhhsmhhnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:igtxaQhnQ1r0RqCXOI4nYZGPrbFjU2dVen7Ey5HgwcDSbO2XS1bm0g>
    <xmx:igtxaSdE5ZXTy2PltAcKyQSbM8t8w3uCeEVfipXpakmsZ_EZ2HwwJQ>
    <xmx:igtxaXpcY8LZl56y8FRPWezp9fgx8zi0WYfxz6LKYwuvO1iUKQ3vNA>
    <xmx:igtxaXAPx53gvaPTKLbPkTaX2rt9wUT6RyXwwWV_hMJFUoLubJY8kg>
    <xmx:igtxaSeupdnQ04Xyi5OBpPIcHbSmWVGKCuJwwl1O578XHamlHLIKTTW5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 12:23:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/3] show-index: remove global state variables
In-Reply-To: <7b5dd0c4-0ca0-458e-89db-621a70dac9ae@gmail.com> (Phillip Wood's
	message of "Wed, 21 Jan 2026 10:39:57 +0000")
References: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260120140901.517928-4-shreyanshpaliwalcmsmn@gmail.com>
	<7b5dd0c4-0ca0-458e-89db-621a70dac9ae@gmail.com>
Date: Wed, 21 Jan 2026 09:23:20 -0800
Message-ID: <xmqq4ioevq0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm increasingly of the opinion that adding a repository argument to the 
> builtin commands was a mistake as they all just use a single repository 
> so using "the_repository" seems perfectly reasonable. It leads to 
> problems like the segfault in this patch and takes attention away from 
> the much more useful task of moving our library code away from using 
> "the_repository".

Very well said ;-)
