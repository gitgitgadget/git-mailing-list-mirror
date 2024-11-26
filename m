Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644019CC32
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732608517; cv=none; b=jG00i9v6qjlDKqjm9pdQBS9ZSGnSkmBRGBHS/X4TYz1UULBkuL4wlpOrEEWc6CsEBMDE4Tx6SqZtVQq4RkXTpfN3QuDCqqhcUoz5t8EsWennsxGXrULJAt9x/TpqZD16oXoJ/REdG62OkMqBPzxgYd+XRfp6CIl0O4FoNSQaGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732608517; c=relaxed/simple;
	bh=O8UdfG8goZ9SuoIp14RJwnMXTR5Nzg2ESx+RcC5GI7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IbDoefes9vqEUMhmQNV2GLmSi/duPsCK0OFmF948z39BID9E8P15WnoyUd+wgrhfxXbDBKdKSJA1Lm8jDka/yzYivIFSsgfEW4KBmP+JprM3ZPr6R/kXizUkgnda9O7DwYL/NFF2Ox6edSFuFDHQrD0z4tmj2P604L+Rqg8ykZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W9vFCwSK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9vFCwSK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75D1E1140216;
	Tue, 26 Nov 2024 03:08:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 26 Nov 2024 03:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732608514; x=1732694914; bh=f3M7YGg0GUJ2mHqya9whGPIeAL0+2ybUMF/
	pH8y6tZ4=; b=W9vFCwSKwqHiGyvzV4M2V7RYnQfhFzQm1EwSGhRy+oUPHLjd2cL
	lXOQUHqB3DPUkpGFUVfG9pLL4ZfJ4TjIoX83Oa7Tc3kQhE85mMoIDEwl35tGxZUb
	IThFVHH90nBy6EXZl02Hbz1vwCrHNqvysPaB6fk4XdN5NufHZas+i+Cs/mMjZkHs
	XMiH7gu5x+Q5tAXl/VN5q2T4zFYhtHJQ7vu4NEkBJ1UqFY4tF6dBSZTgeA+5HKEG
	WNiE3XIjP0I056N/461jUYOSvE+k1DhUyExJcDFZo9aRjTuJHtU0Yhhn2U55J8s4
	I+1GNspRtt2J+kqUcfxV3dSrIGUtv8iV//g==
X-ME-Sender: <xms:AoJFZ87Yn7ZHhIYSXPqIsW51mNi6HKHZoJiB0TAUVeAyh5YyeOxy2A>
    <xme:AoJFZ95_tihYReCO6VVBSBojsOxXUfsdsIsRS2l6jLwAn8vaY8MCNIIau7gkl5iCs
    Q20EVHvPr0SMWJDGA>
X-ME-Received: <xmr:AoJFZ7c9nqgIFOAVDkMhSSAAB10JeB5aiAOw_zgn7Qj0GeR5uQeHYh6FTF7GQCoKOyVz-JrwwC0cAS-gFkX3d26SkgM06YSp6P91f5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AoJFZxIdatIwXFI-i9l8IgW3alg7HF2BFCFJ58ALd-rAzdTJfK-yyg>
    <xmx:AoJFZwJRKJIt7dEy4T1zN_Q4r7Yu0o09dyK67HqLCRWTF30ot3sv2w>
    <xmx:AoJFZyzmsF4d5it6SqJsJwfNWjjR_4gkkNxp-VqU_apaKN9aJYSaxg>
    <xmx:AoJFZ0IaSwvXxZ4uaor_FciddwypLty7X1YiNKPadbQALi61GKNZIg>
    <xmx:AoJFZ1HveDgQW5Aq254Z0qocPpv8K-APjRkNrQJt06buKlEFOXjaF-v->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 03:08:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 0/3] Remove is_bare_repository_cfg global state
In-Reply-To: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com> (John Cai
	via GitGitGadget's message of "Wed, 06 Nov 2024 20:47:59 +0000")
References: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
Date: Tue, 26 Nov 2024 17:08:32 +0900
Message-ID: <xmqqy116xvr3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series removes the global state introduced by the
> is_bare_repository_cfg variable by moving it into the repository struct.
> Most of the refactor is done by patch 1. Patch 2 initializes the member in
> places that left it unInitialized, while patch 3 adds a safety measure by
> BUG()ing when the variable has not been properly initialized.

I think these patches go in the right direction in general, but the
topic hasn't seen much activity for a few weeks since they received
review messages.  Is a new revision being worked on, or is the topic
being backburnered?

Thanks.
