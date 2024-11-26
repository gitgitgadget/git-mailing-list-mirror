Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35D1D5AC6
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651350; cv=none; b=ukNDruGM1FjMkDZ6FabVa+sJDxjgeGLAmtyoZx8jHHlxeOg38EHAn9tGp6D6Bfcs6gytl74dXvE+MlSDGyNbo1yF63BD5/dc0qZX/V6dbpVuvbHI4qHQMNGbEOWhA0Zb1olnLteh491aO2IxmH/VCe8gR2hJA00iIRROIcb7IDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651350; c=relaxed/simple;
	bh=qbT1qtBHZkrGl38WUgfP7aNlRVfIcVyYG0RJynI16lY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fKt/dZUbcYxQGOZ5cT/F7JoapJsUyJczrhnWxeSXjkbw2xzzsshpHeVKCryb7p7yxsnFwoM8u3Fn//K+uq+TBrELkA7bGjC2uJoDdIQRbgs0IYWhzvMdFT0FaRkSW9vvUHXOWErU0XA4kqgoWwps3bucMKPKQ7I3SJ8rkledmKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mwymYE8O; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mwymYE8O"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B0931140159;
	Tue, 26 Nov 2024 15:02:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 26 Nov 2024 15:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732651347; x=1732737747; bh=vpJCOQQdic6CUUXGsl5ihqm9f3LXt1/U3Yz
	ce+bNjA0=; b=mwymYE8OECKSG5FSklrEzqFoPSPvnwA8ljhQHW5sndFhvYT4UD3
	gbNNoEuUKF7/eoLB+ZlmyxwA8+OffzLeoN3hYyWAmaPa0yRcGq8pmgzDTua05AG8
	dj8bYbYDk4WrBfe8JHhWAJEJljrFmfBtQicRxgbbP4iHAfREBh8ZfxYs1d4xtmeC
	GGWChGUnpjMyfzYkwliqMZS8QKC0bXx4BnNidDDXVUPbTD5XjrPy7IkfAQKSOqyN
	0JiLI3kw4cmpJGUlBOt2vt7KEi+x/yxYj1GjQTdlye5WedavTktCJ0EQOh8hhXBk
	GliS6Al2srpMAyMeYymgPH6CRlEWdJdvknA==
X-ME-Sender: <xms:UilGZ76WAp3w4odpGiJ93hhE1A7MgDd4G7t811kMJ9bc3ldgDiCuGw>
    <xme:UilGZw7_pjAfysVyTSJyNGr__sE9cKNqSjA3WmRI3g-lX7f70TZFFj7xsVgPJ6VlD
    m3T3iMQIGp8KzJKyw>
X-ME-Received: <xmr:UilGZyeFifx8xhfmBtbe2yNrm-V5PpB6JfAA1h2ds1a42Fiwa_74HFNtIbXVmmJyoene91RG45nlPTgXNm3iMWmHAZtNcJXowZPaw80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhgu
    hidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghp
    thhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstg
    hhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:UilGZ8InButtGEOP9ERjd1OLTKEX4l-MIkxot0gCVUEASHrGpJIa4w>
    <xmx:UilGZ_L9crj_yZ3-Vz1oo_-02iQm-oAlNob1xvkwXUSIKnFSac3-2A>
    <xmx:UilGZ1woHFGvKkj7xKLWV2_wAuTwIpoGR8bn0vsAhlm-use1a2wT8A>
    <xmx:UilGZ7JorURgi3z51IoHtSjoyjTIE8C7zFiw1QW2Vbc2nM1yIdhJjw>
    <xmx:UylGZwW93Jm8QkSFljOJ5nzC_V_8ojcfFnc5PgxbKWwg-VbYO7QcXciZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 15:02:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v14 03/10] refs: standardize output of
 refs_read_symbolic_ref
In-Reply-To: <CAOLa=ZQ-ZeM4Lk0=ojx3f9RebRkVCX7w4KUKHphZoxUa5Cgfsg@mail.gmail.com>
	(karthik nayak's message of "Tue, 26 Nov 2024 08:53:01 -0800")
References: <20241118151755.756265-1-bence@ferdinandy.com>
	<20241121225757.3877852-1-bence@ferdinandy.com>
	<20241121225757.3877852-4-bence@ferdinandy.com>
	<CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
	<D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com>
	<CAOLa=ZS28xvpEBNO9AMamF00Yf8eHFGKyU5uHjBD7vOVF3_oEA@mail.gmail.com>
	<D5SPDJZAM5K1.24R4JYB0WNTSF@ferdinandy.com>
	<xmqqwmgs6mxk.fsf@gitster.g>
	<D5W75LQ6Z44H.3LKJ0OX40QKVQ@ferdinandy.com>
	<CAOLa=ZQ-ZeM4Lk0=ojx3f9RebRkVCX7w4KUKHphZoxUa5Cgfsg@mail.gmail.com>
Date: Wed, 27 Nov 2024 05:02:24 +0900
Message-ID: <xmqqh67twypb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

karthik nayak <karthik.188@gmail.com> writes:

> With v14, running `git log --check --pretty=format:"---% h% s" master..`
> gives me:
> ...
>   --- fed56bc6cc refs: standardize output of refs_read_symbolic_ref
>   refs/reftable-backend.c:833: indent with spaces.
>   +        if (ret)
>   refs/reftable-backend.c:834: indent with spaces.
>   +                ret = -1;
> ...

Thanks, the above matches what I saw in my message Bence responded
to (to which you are responding).  I was unsure if/how the status of
each "diff --check" is propagated up to the driving "git log", but
the job is reading from the output of the command and not using the
exit status of "git log --check", so even if "git log --check" did
not signal a check failure with its status, it did not matter ;-) A
quick local check says "git log --check" does exit with 2 if there
is an offending commit in the range, so we should be OK.

By the way, I appreciate the cuteness of "% s" but I do not see the
point of "% h", as I do not think of a situation where '%h' can ever
be empty.  It seems that this was carried from the first day when
GitHub CI learned the whitespace checks 32c83afc (ci: github action
- add check for whitespace errors, 2020-09-22).
