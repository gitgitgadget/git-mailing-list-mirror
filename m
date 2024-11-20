Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F812B93
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732074420; cv=none; b=Qt46ey9WMoBdwd11h/OAR/XeumbcWarEYeKuqOotKSW5rZp+xLW76WfiBTNBbgPZ4+Yn1WTG1Hw6yutg2QG079NQp0/0CW5qwAW6HHIXbVR9/URd5fgo9Lx7pDWd7/bXwwHDLDvTbhOx3LEkdJg0tc+BZcpaRRarDCqlLGuo9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732074420; c=relaxed/simple;
	bh=JOTj7r3mVTFhQqKn7AXjopU7RevuspAXfxHfwvhDefQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BQuBMaK/T1PDPHn6eHCMfHZk7hNwHphe1Pz+G3CWBoSO6vphfuej7mtywbUQOYubZ4GxYZVf/Sm/IYGWPpJeFdbeoR1RAtvFFn+5LDGzQMwDoh1U53epdBrwvAIWM0gJyZJkzntavq+SIX75aNyM+9UvGMeRi1PirfhIATQw4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e6ygsfXc; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e6ygsfXc"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D3B725401B0;
	Tue, 19 Nov 2024 22:46:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 19 Nov 2024 22:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732074416; x=1732160816; bh=x9+btVCHXgBgqWCclehH2zelKbEyhTOVnmw
	hlaL+lyE=; b=e6ygsfXci+GwZdzsdo820yWHsk9vsCg1Og22EFdl4h/UiGqx/eU
	pe3/fOtpWkvYKeO26iy5FWzj+Pb20ayWI4op/5u9Y3cajX1spTnArCSxf1V1PlNE
	ThfDlpKfjxMxMpZtYoIivx2QCDY4dL/oV/EYn3D+KDNbov/98s+iUPWOZENlXuFM
	pKoRm3F4uqdRbDPU0Jn6kqHzucTqItMPdWoP4yanlgG+2spFKqI/QoKVFnJ4u24b
	rP2AFNlGlwFOVrJRn48PbCj499k5PNXL1RFVC0EG7+9yF9zUIdUfQQm207acr3fn
	rHSfDz5EXOkO0d/CKEGGiGTFPw0rq4mlYZg==
X-ME-Sender: <xms:r1s9Z4_Xjo_JyoeOEM_Fx2UV7Jz3LnPRNs-gJETTtv0aJMSVxQaqjQ>
    <xme:r1s9ZwteRncLshtB1bn8bLYc68qLeTIfVo9PkXV01CsEDkkSekb4mxuLPGgwiB1zd
    3e7yzDtZUcKPdUfSQ>
X-ME-Received: <xmr:r1s9Z-BE-DSoB95iUHMm0o-JTq5XUkJ2hriFpVRhYxS_-HEmIjSrySzGGHBuIpTezwPnivrJ5x70Eds6QGdlpRR7wwrBQCrygsv1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:r1s9Z4f_-Z6ScT-EXm5grRk0d_TJn5lpKrDHMYFtUtOCa8KGJNNF8w>
    <xmx:r1s9Z9PavCq0uGnuL_N8FSv7Uig6bTl-0Y6a4IHeDPf_NcWf3ANPrg>
    <xmx:r1s9ZylabRSASqGgiWDlanlsJkHZGS5oVLIIEfWla2SktW5t32cQ9w>
    <xmx:r1s9Z_vK-Q9F3hzgbXVZW-PwfCr_gWubjrouCS5epNsoR6YKSTtZFg>
    <xmx:sFs9ZwoQutenfbejLhtUtj2pC9yGHbL6kx-F5bnGdjYy-e4Ojf8FqhGX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 22:46:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>, 	Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v13 1/9] t/t5505-remote: set default branch to main
In-Reply-To: <20241118151755.756265-2-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Mon, 18 Nov 2024 16:09:20 +0100")
References: <20241023153736.257733-1-bence@ferdinandy.com>
	<20241118151755.756265-1-bence@ferdinandy.com>
	<20241118151755.756265-2-bence@ferdinandy.com>
Date: Wed, 20 Nov 2024 12:46:53 +0900
Message-ID: <xmqqr0767ej6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> Consider the bare repository called "mirror" in the test. Running `git
> remote add --mirror -f origin ../one` will not change HEAD, consequently
> if init.defaultBranch is not the same as what HEAD in the remote
> ("one"), HEAD in "mirror" will be pointing to a non-existent reference.
> Hence if "mirror" is used as a remote by yet another repository,
> ls-remote will not show HEAD. On the other hand, if init.defaultBranch
> happens to match HEAD in "one", then ls-remote will show HEAD.
>
> Since the "ci/run-build-and-tests.sh" script globally exports
> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main, there may be a drift in some

"main," -> "main for some (but not all) jobs," or something.  IOW,
the point of that forced export is to test both.

> tests between how the test repositories are set up in the CI and during
> local testing, if the test itself uses "master" as default instead of
> "main".
