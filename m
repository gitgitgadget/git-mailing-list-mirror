Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC22472A6
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592114; cv=none; b=exwnEUHuJ2LYD1GlOX+v5L45CKR+XfJFHO91kpCJgISUfXwBjPVqyeku6X6Xk4QQbSadhTnRVcCLSy9fcRKOd1WgFUCJuruKieAi9CGLheVqgnxULWh2AAx53dmSTFGOjH4m6W7c1B3GgAOxikFzFiOtLDpr2+AW8GV4zL9DYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592114; c=relaxed/simple;
	bh=AjehKgr8xdNDL3gLBBRz8CpEVC/TdoFt9NAIz7bPBHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oFSC9eT9brr4WlblUvswFdSy6nnQ9tsFs3YHIFmgrby0D3C2HYZfjUqj9FKCqJMvyMINb1SgYeoccBqf6wLYMGS65BmhwvmAeOSadZz9aLCh3pfELkDu2X1jsofyGSICB4zxhqdTIdTe6NZYM/Z69pAvUXZjGDOuy4SM52tnkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SmXR3Tp7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gL/6CSRf; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SmXR3Tp7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gL/6CSRf"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3E8E625401DF;
	Fri, 25 Apr 2025 10:41:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 10:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745592111; x=1745678511; bh=c3Fk28B0Nb
	gTedc+pZtJ2huB28Xk1ZP/qlBY6UDc53s=; b=SmXR3Tp7P6db7uEIQe/dYTeHMi
	WQLIQS5oKgqSYq9HzkkqeODul862gCwq3nk1Uh4aC5ioL+p5IvnthfGJgl26/OcH
	6vG8G3PWVI+TxW/fBgzsbqdrJ5Aw+hw+6lFp00Zy8ZyVfatxyQVouy7UwXeLNj7y
	Q8OXPqou/burFMilyllpC4mFVS0pb/L9w/htKBDJg0+IDjLkY0BAMRv+sKRXqssE
	ewMLQ7SUYR4QNh902LSiea/nHczpOIfsJe4v3gecd5MWcGHv0s3o2PEeNYwoI2IZ
	oWLoD1hDxRc35N8LdKrAVQmvV003UbdTEEIiUouy55WrXF4Hje5xNLLq0c8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745592111; x=1745678511; bh=c3Fk28B0NbgTedc+pZtJ2huB28Xk1ZP/qlB
	Y6UDc53s=; b=gL/6CSRfx8gFMvcXNYfWZm5+JEsI9q68vaQsYBLvMudAMeS3DKA
	hMOryaL6oXb2Q2dux5xEWSLX9QN36Lpob9+JTMd0hX6/fjEMpopnd642tTVcpR0/
	JrLBictjKzdbP1yHjuUdCnO1F7OJctxuFvH4xEO833zXw0nJlEzjpjtvAaLmTsru
	kv+tDLyzLGTysdJC2ResY3yjdKzhs+7nHt8VLBchrym08uMy3ThsUZR2C+mquHFb
	i639bjxtTqsf2KuWDdQ/ni6uHQwYS/ZA61m215VAgIGAKDDmLTRzq+z7tRe0yztP
	wKtuVTIh6OzK34YDHtz8oMZ4MQFjStgFHXg==
X-ME-Sender: <xms:Lp8LaJl5nsZWMQOxiOddmrb5peO0KNO4aTcjOP03Gwo2k9KCXiHbpQ>
    <xme:Lp8LaE1YuwEMSKxizFafAahiPXzwLDhRgisVzQFD9UcfPYkwl_URdUfBBbJBthImh
    tDAPQlBXk3U5WCazw>
X-ME-Received: <xmr:Lp8LaPoedjJR55Vp5T8_XUv-m0d51HgTFA2Q9OUf5Qtzcvvds5Xnpk2y56xbK6me072PGXcJyvWOHBQv-wjvaL-Ws94T9FXeaduG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedviedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Lp8LaJk4ezvoMA8QzwsbnPMobtQBrvVFHK7X8mHbHVABpXB0N3blPg>
    <xmx:Lp8LaH1ToB_kPuQltTU50NvTvifVjbPlSQq3PitTR1JnfVFBhwWAQg>
    <xmx:Lp8LaIt2aGCD9I_blAR8BbMJm9f_ecsmBsCj3yOxtxX0-LUeCaIyKQ>
    <xmx:Lp8LaLXsvCtCYbSR6pgoWHj6EGOnAxr2dyoVPozx_hXUrEnvKdXepw>
    <xmx:L58LaIrIAA9pGX1g5_Z2yPuFwIiMghyCe08nTemcKsgpKdXznDqRGajm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 10:41:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] ci: skip unavailable external software
In-Reply-To: <a80a320b-80ca-3d61-a4a2-f2528e7ca053@gmx.de> (Johannes
	Schindelin's message of "Fri, 25 Apr 2025 14:01:20 +0200 (CEST)")
References: <xmqqfrhxtdg9.fsf@gitster.g> <xmqqmsc5rw94.fsf@gitster.g>
	<aAsNUYUKJZbrMCf2@pks.im>
	<a80a320b-80ca-3d61-a4a2-f2528e7ca053@gmx.de>
Date: Fri, 25 Apr 2025 07:41:49 -0700
Message-ID: <xmqqr01guwuq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That is true. It would probably also make sense to mark the message as a
> `::warning::` on GitHub (and the equivalent on GitLab), so that it is
> shown a bit more prominently in the CI summary.

::warning:: may be a good idea, but I actually think we should
remove the message when we say "ah wget && chmod failed, so let's
remove".  At the end of the same script, there already is "ah jgit
is not there, so let's warn" code exists (and it would falsely say
"jgit file exists but cannot be executed" and take the whole thing
down if we do not remove after a failed download).  The ::warning::
should belong there.

Thanks.
