Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828554C6D
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315464; cv=none; b=K2YUdEHjk+RxJdO17AsW+sOQpO54oMqF4ujy/XmHovqT2cl84lmTd4m/cgW1eG3QfhqeR+Fw0R3QNP2V/nvsBkB8993j+9CQgJ8UFvwI8AAYXye/dk09qDdVcE0M0aHbE9T6m17TRFDfyL7YpMcnXDSU8brJwYGgdopF4BYVGxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315464; c=relaxed/simple;
	bh=ZdqNSQku5ZFlyjJ9Sgx3K+7JPnsBmmL88JKV8icSrBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCf+aG8syVjbMW7bn+GhaTE95NpPL+VN02H32sRTeZ/m1rhrJptT21hj/uUCFr0hXUpGaHsIBQZy1HaOHJMappXvJPLuKWU3/N0SkNGaQBszgHyizJ57e4uw3TlabMcUpS313q2TjQ1lVOeWUuS4nrFOXbWOMaLFKBhTwJWVCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jqqGQ3DG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wglr5utf; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jqqGQ3DG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wglr5utf"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A16B25400F4;
	Thu, 15 May 2025 09:24:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 15 May 2025 09:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747315461; x=1747401861; bh=U1g986DyrG
	NTdahgBGpPolhI3vq7KbV4bRp5N3aImHg=; b=jqqGQ3DGB/r3q3suftJtiT1Ehy
	sEAzhXCNmuex2poiRxN66rYoKJvBPrJkKZOdl3C8eDCTF5IFdq67lK7LNMkFy0bm
	/hm+IfK7MAUyXcny6v7hLL7HyxumKaxBB1IcaINmrjMd1zvpAFXhm7iVyYhmJzzN
	OiKoK4aMaYDOK8nGaygxCyAAG3TyCWwnnXyL42iPe7hRyC9sq08ZuWqMGGnroitG
	fzr1dRhyAy/fc2C8zB+9DFGsWkicCGo9PUMfllK5Imuc3DqnCKEO3sc4U+E2t4T6
	zPIGNvRHmLCRzr4I8kIVqFIpCelElpmyvbgNtOx9mEuBh3oesCbhQZJBYisw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747315461; x=1747401861; bh=U1g986DyrGNTdahgBGpPolhI3vq7KbV4bRp
	5N3aImHg=; b=Wglr5utfwiDvYPWFBHYz6dx/bvzgmL8iN7nwGIpgO3z56yDveeg
	e5qwmY5NwAI07WRA6Jacd5zlLEc0nZG7ntc/M0Yp+2vFA0QiR5JlMSDKsaR6S9Ih
	vB19rWKGb7MBI75Z59+DSrb2IQVI/csTpU+T9ITUH5CIete21iKBq0ZHmpE05sK3
	XWtIbrGWnRMDmChgpgLFSu1WeiET3rGTP2DlIthOOA5Max6m+J6jkGlt0TDkBRR3
	WMzY5gokrU4d9sIqq6Gig30tyQC/tapOO8VSVIvq5nI+5L/gFBkSwvGoLRqzhv0K
	sb4z5YUl2CFvjLiVx/uEP6Jxvs1C5HTSvsg==
X-ME-Sender: <xms:BeslaMAFpdJF-_hggzm6Z_1hdiB0_oOEEX-wHKr14kmf79lGiJqX6Q>
    <xme:BeslaOgOZAhIe0czuA_v8CNZPatgGbGVa5yy3zF6dRC9xep3TTLNnCGEFuleZRP2L
    xqBskICtFjhmUxucA>
X-ME-Received: <xmr:BeslaPkgP13D-HD-xDNzieDDy9GElWyyBurYsDuZYvVYRFuFr3VlirkQxGEa0reMy-MQmWM0GH23vgrVtCo71u6C41F27w2FmruPCMrIXbk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BeslaCws8ANRUoIJxLPYlEEEkP3qAzkiYQpjKdq5VVo9yufYF2wYqg>
    <xmx:BeslaBQbxpHbtbZeBkIriLMjWlDAc16qutSxbSb6U6eXw9NT89Ur1g>
    <xmx:BeslaNYbBN0lVLYXnW3WRImupK1yEE8xUi7H1Up_qAtL-Ykkgq16Ng>
    <xmx:BeslaKSvp3uSlZb8nclRCqCCEYLVWArzpUVTMn7r6y9ANlsla_qTJQ>
    <xmx:BeslaHDOTRlXzR45Lj3w_VpQooN3Q_i_ztF97tEYT6YpCt8f50_aAgBB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 09:24:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c31fbf77 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 15 May 2025 13:24:18 +0000 (UTC)
Date: Thu, 15 May 2025 15:24:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: Re: [PATCH] replay: replace the_repository with repo parameter
 passed to cmd_replay()
Message-ID: <aCXq_ck96l0AjScp@pks.im>
References: <pull.1921.git.1747254806067.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1921.git.1747254806067.gitgitgadget@gmail.com>

On Wed, May 14, 2025 at 08:33:25PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Replace the_repository everywhere with repo, feed repo from cmd_replay()
> to all the other functions in the file that need it, and remove the
> UNUSED annotation on repo.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     replay: replace the_repository with repo parameter passed to cmd_replay
>     
>     The point of this patch is not to remove USE_THE_REPOSITORY_VARIABLE; I
>     can't yet because DEFAULT_ABBREV and get_commit_output_encoding() both
>     require it and have no current alternatives. However, I still think it's
>     worthwhile to stop using the_repository everywhere while ignoring the
>     repo parameter explicitly passed in. That looks kinda ugly, and since
>     I'm poking around in replay right now, I don't want to push
>     the_repository in even more places when we have the appropriate value
>     available -- especially since that might make my local work conflict
>     should someone else come along and try to clean this up.

Makes sense. Especially the first one is something I have encountered as
a frequent blocker for removing `USE_THE_REPOSITORY_VARIABLE`. I guess
it would be nice to tackle it sooner rather than later.

Cc'd Ayush, as he will be working on the global state reduction project
as part of GSoC.

Patrick
