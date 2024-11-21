Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759EA23099C
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732155596; cv=none; b=oRlRg8j8aYsBweNEw2n+Ky0hnhEVzhOojzbhGTjR2ymjVf1YmFbjLazWFf36ZFMjs9+1imSYFvDZvupe5j1qgGt2e/poKbtNY2zNQVa3c2T4GqxE89UrrHuM8QKa9a7G4xjQHTJk2F12XLZ+2FsjOvnshHrc1GrFyCRdCOWSJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732155596; c=relaxed/simple;
	bh=kMOc3PZZR4gS+FNxqwK6Y0RRQh4BJbdnRU4GuGvXd7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mc1iQaifKfT1gHaG3kdOKnbey2zg2+Q93iN/KeupFCjg3m0qeVLWLATsqfA5IQqrP06bYEj4dqGW5WPGd1rjGWgFpLH+BG7cJYKvyh2oChAKbLYnHJGY5lOYNWyFQ7vHMhvdpppkJn5jBcmNsLgms5g35+Hpv2Jw97ZYKKruXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UvjnzDhe; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UvjnzDhe"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E712D2540144;
	Wed, 20 Nov 2024 21:19:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 20 Nov 2024 21:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732155591; x=1732241991; bh=BwiYcOievP7BLY8rCF4Bm2mufehCyoEC661
	7NaNnYN8=; b=UvjnzDhe2IqryXV4jMu1o2Ep2k4zdnDHQwq0t8BBzPOlXq4fiGK
	1lyKCqmuyFen1V5FfSlKAdZM/1v1wLjaY0OBDb9hRhkEsDFcCqrOXpoUNj7OXtOl
	Ql0mLKe9UbBnhdithuz+hVjVlBqjQMb23AE/ptGlP4qof6s/4CHSGEqMo9GIHuqT
	ccbyI8ASn0zGCc22onvF3QonAdmm58E73rfQeL4j4AAerkCkh7mrDvtH26yboh9h
	UH7XPFtq5WUtn9wBYvoNScIxN2ysw0oO2RrOfUMqOMncInO9GYfKCxd9CEetobbr
	QwnXs03BVuqCY/Umpsj7VEJgHAFhICQ455w==
X-ME-Sender: <xms:x5g-Z-18smfkpgDMi91ZzlZP2an4T0L3Kyy-44IGSeFcJ39Ol1ioSQ>
    <xme:x5g-ZxE7rnuzXWhW-GphM4A51dwnFmTbuDsdgSBpvZSV5THPiv6oH9Kx_ZbEQvShG
    Myq40g29-c-nbifwA>
X-ME-Received: <xmr:x5g-Z27ETFvYJvF1uV8fusM2ryu8pnB2wmugoqJ-KtPpKL8OnpgqeJLgTnaSkimHLon0jzN_r56gdTCqStTmYa71afKzVFx3otCC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeefhfdt
    vdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:x5g-Z_3idZYx8xSqbkSdP1OScpJ8r6irRrQhqW39oocxKRckS8QQvg>
    <xmx:x5g-ZxG4oN1adfd3ono9kDFScDL9NmKp6i2m8sQ0d-IyFliML0vx4g>
    <xmx:x5g-Z49BYLHDQmASBfsOu9xbCwu8uKejkKjvo37fzLFyxva2XcM5_g>
    <xmx:x5g-Z2n1U-WRZz2EvDvhUl2p6qIMk3IoEUctahzpBMDhr6rYbX_Cww>
    <xmx:x5g-Z273HOAGyijIMSzKUpQ43lfT2J7TxglQkVIPFSTFpR7XZNtJuOCc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 21:19:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com, Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2 00/10] Change midx.c and midx-write.c to not use
 global variables
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
	(Karthik Nayak's message of "Tue, 19 Nov 2024 16:36:39 +0100")
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
	<20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
Date: Thu, 21 Nov 2024 11:19:49 +0900
Message-ID: <xmqqh681fhve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Since the `packfile.c` cleanup is still in flight, this series is based
> on top of master: b31fb630c0 (Merge https://github.com/j6t/git-gui,
> 2024-11-11) with those patches merged in. This applies cleanly on top 
> of next, but conflicts with `bf/set-head-symref` in seen, the conflict
> is mostly straight forward. I'll merge the topic in if it is merged into
> next soon.

I think set_head() part is fairly trivial.  But there seems to be a
much bigger conflicts with the incremental midx topic.

I actually do not understand offhand why doing anything to the midx
layer needs to change the calling convention of set_head() or many
other things that are unrelated to what midx layer does, and that do
*not* use the new parameter *anyway*.  Shouldn't the "subsubcommand
can inherit the repository from the builtin subcommand
implementation" be split out as a separate topic, which the midx
thing later builds on?

Thanks.
