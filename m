Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C633A6B71
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911872; cv=none; b=vGIQerDQ34ovDUIeue7g/iXgm+KIu74beCW+66888bCB2XZzHNADEBcxEJ/UuC3oh1Lfdwt4XYwCw0mkuRTakM06iKMtj8AoqsO0daKvfNMWICruRLJ+YMs2d+n6UbIyCHjskEI70VYTn1yvVDNysQ25lND7GiIP/aeKdBKmAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911872; c=relaxed/simple;
	bh=New49Q02nik1EPhzUkJv5Qs1Na9h1PdSTtbIokH0M1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jgdxpjQbZoVXKuHuS71KS7cP037wMom8rmVNdx0SNvUZ99uH4HbuHA8vnOudYJhDm0Np4CFFt47/64IjcpobE2wjFvINiqY14y7ReV/LAX7XxB7ApdqtkKcjByaFDcLSMo3afc3jbyv1S6FnhQOeD8tk27OPx5MwjfuD9WFBESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ORGxGXoI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YqCnOkuU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ORGxGXoI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YqCnOkuU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C2FD51400268;
	Mon, 30 Mar 2026 19:04:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 30 Mar 2026 19:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774911870; x=1774998270; bh=EjhX9MzfPP
	mzxsYQdIrv3sKk3eVrTiOPX/c8jwRBA28=; b=ORGxGXoI0tldkO3N2+NebpJnma
	6S+hswfGrrghVSUPe8yrsB4Vjdk8/8PnlkrgnfRq47BMrVDr7BoqZm9zqPu/a78O
	rdzibgz8EVVi6hVQTBeoslvaGVb2X1qE46BAp+mOonRqDScFcpbl72rN29tf4FHN
	U0nXQwD5c7ZcX4j1Wh/ju2Sj06YzGhfVk4eYlnvsxJMcKROIbf8zct1Sy86mPtl1
	HVaZyU6EeZvb7PlYu1eHwIY3jONi/21Gfs7bA4b6Zze/vrjIKQQH2MJrJnASqbm5
	kD3ZIZwY8dV8XPl/iTfIdB6zbvLciMGwBCoPXkhYuoJ0F4iJCEKW6rBmnqAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774911870; x=1774998270; bh=EjhX9MzfPPmzxsYQdIrv3sKk3eVrTiOPX/c
	8jwRBA28=; b=YqCnOkuUQZMWZZE4w64ZB0JiVxeACESNPSFc5qAfGAEzHhfH0Xq
	f87umnpdXEzouxieDH8GiPmrzl5FZFt1beaQe8nxbsn/uWnlsCdnUa8Ur5zdp4x7
	qCYuWJKugyMmtpBhHn3CiyGEqoKG2gYnTmxNsM77qhI+zXRFFJ98w3lLF1ITfUwd
	ldyNhqFB+i5yc7HCwddfpH90SykXIVE38rJrBCU7P1VNiAPCxf0Vegh1cBQ7WDEf
	78K8MqoZJ3YBP/lXkekbpY7ZtjcwD3ZyX32e8FRgftYdEAe4wsVDHT6OWgeqn3Dm
	dvC+74O0NMkuWO/sRsEoTGabIl47jXKnFOA==
X-ME-Sender: <xms:fgHLae9RC1SA7ACrYY4KhjqMvKi9O6h31Bs_DQJKmLOmt2pWYhT8pg>
    <xme:fgHLaRR9dvEg5TmA5MkQfhf_vUgzN0TuRQ6NLPwsMRXuFTYmR5x7OT53UtI7LJkeP
    3B82OkL9g8hu8hC5gomIKB6DNFuvB5JXK3IczOTz8kN7f7ZQ0fkaQ>
X-ME-Received: <xmr:fgHLaXoOYXFVAjcaeuIy2Xcq7dU2crQLEKDWFOSsI5d2myKM6tZPlHBatFihi8TogfJy6-N-kfAT1wYRh-i9UDoT_qm2qWIUmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peihtghhihhnrdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:fgHLaWl7Wat377DHN89MsAlNx56QiQESd9VCV1pqhgKLxF5h_fFwrg>
    <xmx:fgHLaYcRRq5RwFRQT9vstY8mRUvg-JSjejFVhmDX_swtxCrC4I-ttg>
    <xmx:fgHLaap2qnPlhpfJ4X__cvnyaz69y7-L35Z3NgWCKYTEqfJB-inGQA>
    <xmx:fgHLaaM-8P82hPn-FhpjbcwKxtG_BabGzOrJ-e5l48j4ZSdMwx7KtA>
    <xmx:fgHLaflPI6ZUVjdddnWy1wwNJZ0_TP9kjiB-lFzaiZYq68gIufXjbKuo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 19:04:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Jeff King
 <peff@peff.net>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH v4 0/6] Xdiff cleanup part 3
In-Reply-To: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Mon, 30 Mar 2026 16:59:57
	+0000")
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 16:04:29 -0700
Message-ID: <xmqqtstw6hs2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes in v3:
>
>  * run make DEVELOPER=1 on each commit and fix all compiler issues

This round looks very good to me.  Let me mark it for 'next' unless
others bring up problems I failed to see in a few days.

Thanks.
