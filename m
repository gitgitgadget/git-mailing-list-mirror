Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF73BB22
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731646372; cv=none; b=sjCalxfYHZ+sy5ZEAa6OW222C2bA6FcjlD8OZ5Wd837+FkGxirqLxPt+3vR81SGu8sL5vaCyYElX4vOxQY/1SNwiAXJ+j2hISsi1xkpL6bkj87eztYxHlqx5ahhceShDLUg8yutQnMH+Z4th3cG6fYR24xgY/ks0W/21FLH2lYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731646372; c=relaxed/simple;
	bh=NgbbJx57P0N49qCUV317a5XS2YcGWRowK1qLiddeMUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h8g3FQ+Nab9tFJbPIlFgy4+G0/M8RZyF34Du1HlPMmkIMWemHZ/VUNjGtzCLA93YbnFzLonRf4rrOyToOwNmcLbBL2fHiKkMc8k0eP0t0YT3K9VU+vC0Yn+3MgSnV1Ak6V7dseVnrDNUnYSWKCwjSDmaRArauqdyw0aNII42QLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mu+IU2JK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mu+IU2JK"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 32CC413803AF;
	Thu, 14 Nov 2024 23:52:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 14 Nov 2024 23:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731646369; x=1731732769; bh=oEZfSCopoGlP7VMGe2Ybnspca8z5n/5xusL
	0JbdeavQ=; b=mu+IU2JKYWyUUGumi5x5ngv7at8GHbWEfTtfKYf96Qy154QXRXK
	YTRRIAHJsi7x+DtZ2MzXH6mbIxUAT0j2KniobafGFHQUg50pGd+RTsanLR2LD4sw
	l3IV69QZO8bGlhGs3u2M7V+deyp3JHCC+hg+5ywDPHn1fblyzqQIHXuB9c3rW57L
	zrhCyvw+7AHcICuoSJZsDl21Q+ykIdW923JJ8ac6b3kgt364UOAuY506czE0qhkN
	NRug0HptOdDojakKT8EDe1jha6ddrqpK400DnA2JtyifLgGvg8e7wj/B94XEPdQf
	WX+/lcWhNCKOLjkBpISevVeu/BCLUd2pPOA==
X-ME-Sender: <xms:oNM2Zxlou-oftWsESwngxdDWZ4b5ZB9wmbL3EgpNPK1YRFWtOcts3w>
    <xme:oNM2Z83kUz6njJDDJZExxTid1i22glQ6YW5ZTd1gnFaNqH8_ht_14qFwC4csbaBAh
    CwX47vZesmKakGWVg>
X-ME-Received: <xmr:oNM2Z3rxpJPo20L_RKr8gGAYrq581Zkawj4SqAqmVfeg9yhp1ESVZYwbvPEMbfZ63zeEDAsUhs9IeAeutUhiHR-pHHfPm4c55MGE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdejfecutefuodetggdotefrodftvf
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
    ohhmpdhrtghpthhtohepfhgvrhguihhnrghnugihrdgsvghntggvsehtthhkrdgvlhhtvg
    drhhhupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oNM2ZxnZibtscKXUBxSpDbXKxxGtJXMSRjkCZYybYwzZLA85rc6f-w>
    <xmx:oNM2Z_2pDcDUSiAWouOAzyw9XuZwwBZuRAcB5CvczkBvXtpULPDnnQ>
    <xmx:oNM2ZwtLrajBfg__7rtx9MGtgJhgA0vKgSY4UPGRkqyKxz3MxUO3Kw>
    <xmx:oNM2ZzVn9q0mMvN1IKBTJFnsleICTm9HD_0OiAfla388Cm7KuCrk4Q>
    <xmx:odM2ZxxyG458G2nyW7JKtr1YxulVW4ZxRQLHml_eVbJyJyHi-6Asssb6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 23:52:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>,
  ferdinandy.bence@ttk.elte.hu
Subject: Re: [PATCH v12 1/8] t/t5505-remote: set default branch to main
In-Reply-To: <20241023153736.257733-2-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Wed, 23 Oct 2024 17:36:35 +0200")
References: <20241022194710.3743691-1-bence@ferdinandy.com>
	<20241023153736.257733-1-bence@ferdinandy.com>
	<20241023153736.257733-2-bence@ferdinandy.com>
Date: Fri, 15 Nov 2024 13:52:46 +0900
Message-ID: <xmqqfrnt3xpd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> Consider the bare repository called "mirror" in the test.  Running `git
> remote add --mirror -f origin ../one` will not change HEAD, consequently
> if init.defaultBranch is not the same as what HEAD in the remote
> ("one"), HEAD in "mirror" will be pointing to a non-existent reference.
> Hence if "mirror" is used as a remote by yet another repository,
> ls-remote will not show HEAD. On the other hand, if init.defaultBranch
> happens to match HEAD in "one", then ls-remote will show HEAD.

Making sure that the hardcoded (in the Git binary) default branch
name would not affect the outcome of the test is a good thing to do.
I like the patch text, but ...

> Since the CI globally exports GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main,
> there's a drift between how the test repositories are set up in the CI
> and during local testing. This issue does not manifest currently, as the
> test does not do any remote HEAD manipulation where this would come up,
> but should such things be added, a locally passing test would break the
> CI vice-versa.

... this description may not quite be accurate.  Don't some jobs of
CI use 'main' while the rest use 'master'?
