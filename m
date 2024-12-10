Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C67923DEBA
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832192; cv=none; b=dgoNU9WK1KCstEaBwotwQFv6RdGtgvCZ3556Z8hYvn/0UnCtCd5LZ6FfsKiD1vnj/FdI+rS7gvU1CAfS/TbspT9Lshh+fBGdXq1okjYFc0U13xCo/3mHXf07zetXhe0h4RGAOCaq64UnifTzOaFFDL23GjHFLgH45BRm9UU0Lro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832192; c=relaxed/simple;
	bh=ijpMv4TJjEKajzy1tQ6s+JPouZxfL9Pun0qToHQAI/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aX2kndgqna2o1Gn80TNmvJ8IlTflaVap4lXH3rox3tuJb15bujf1Zy5uESKAU4Wm00cYJld8Anon3S4nGtjEqUZthffsrV7Flyq+z3iBhnxRaPpVBVr+2a4ZY78RWzu25JDsq/GguqBopL+c2zuEzifeFrckhw35vBgv3E9sxZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I7EpAURf; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I7EpAURf"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B577E11401A9;
	Tue, 10 Dec 2024 07:03:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 10 Dec 2024 07:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733832188; x=1733918588; bh=LeXVxKNqRHgKjOsSqBWUSX/j7KNJZdhdM0I
	zMednFg8=; b=I7EpAURfSAHsywq8PG/FLoMxo7FcesAur+EOMmPE6ycSJ9VIwIM
	wyehes0vwshCmRg6LWoFnxe3EO6miCT+tb/zi61SntIeyRZFU/fYed4HIJl5UNXL
	r3neN2KDXGNiJdAr7Af8Yb4YTQvfXs3V/gEliwO37Xrbr2DqywoPifySBRrvXWSf
	ROIq+oYSjdLADIjd71S3L+VlXygbMS+rJSlXpvz8Y3CpcMn8P+51nrbBj/Fip95H
	s/pOb8h8lsUpNZn7rzcOi2J74g3fEebus6Elr59SyROt/O8iDVY2trb5NJio+sfi
	CmDMozs131mabS+quTuD6+6J0M1lIoC5YGQ==
X-ME-Sender: <xms:-y1YZ2tiq9Vv59ETX1mIcOltppDBRogZHBEWBQ0xkUI_qR_Qr7p3rA>
    <xme:-y1YZ7cl_8Cu1br2OXsZHWebrP_tlbfSXAICEU0ruwPoGHifiqf4_ku0cUicUHMTY
    t0mbXGJbjvDm_zGwA>
X-ME-Received: <xmr:-y1YZxzRmdYmyoFfBryQ6Hcp8godp-8bl9Qn2tozFtxKYfxFwQ7Inrl0-QD-v5jl78VHQ7HyyRe4WdxE1VTJTEMWm2si76mh1aPqnBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhi
    hjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:-y1YZxOdEOROmoruIVIjq_FpZjjLKMS5ZGPd6zi1pn03vMQLc9fTXA>
    <xmx:-y1YZ2-3-YuMMF1hj7BImc9TkNTdrxJtg0u_hTv1CUwwLX22YvLXBA>
    <xmx:-y1YZ5VwW9GHAe1zKn9gsQRMyKOYifGqeg3qPA9vp7NthRjzAvB4tQ>
    <xmx:-y1YZ_deDr3LbP9zRPGXO-XJBj17aPVLx6H-kVI2RFsar1nJEvTBFQ>
    <xmx:_C1YZxUL_Gu5b353W9nlcVjimSq-cqgq2627YkbYCFEUroGtCZ-r-1wv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 07:03:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Taylor Blau <me@ttaylorr.com>,  David Aguilar <davvid@gmail.com>,  Jeff
 King <peff@peff.net>,  Johannes Sixt <j6t@kdbg.org>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v11 25/26] meson: fix conflicts with in-flight topics
In-Reply-To: <Z1gj4M-qHQ2Qcq5a@pks.im> (Patrick Steinhardt's message of "Tue,
	10 Dec 2024 12:20:00 +0100")
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
	<20241206-pks-meson-v11-25-525ed4792b88@pks.im>
	<xmqqikruswtd.fsf@gitster.g> <Z1aLT-Hcq2iMWH11@pks.im>
	<xmqqplm1nv7g.fsf@gitster.g> <Z1gj4M-qHQ2Qcq5a@pks.im>
Date: Tue, 10 Dec 2024 21:03:05 +0900
Message-ID: <xmqq7c87lp8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> I also had to wonder if we can share the common list of files and
>> have both make and meson worlds include them from the same source,
>> but if the eventual goal is to migrate into a single system, it is
>> not all that great an idea.  After giving up on one of the systems,
>> we would not want to keep a system where we keep a list of source
>> files in a separate file (possibly in a separate syntax), which is
>> not how either world would normally work.
>
> That would be great indeed,

Well, what I wanted to say is that it is not a good idea, especially
if our eventual goal were to ditch either one of these systems, so
we are on the same page.

After ps/build~1 graduates to 'master', it may be sufficient to add
a Makefile target that runs the check script you sent earlier to
this thread as a part of "make test".  That way, those developers
who work primarily with "make" can minimally install "meson" and do
nothing else and we make sure that their changes in the "make" world
would not make "meson" (and possibly "cmake") world stale.

Those who do not have "meson" may skip the check during their "make
test" without any negative (perhaps other than a message to nag them
to install "meson") consequences, or even a hard failure may be
acceptable, if the necessary adjustment is trivial (like "I added a
command in builtin/ and listed it in Makefile---add it to this list
in meson.build file").  After all, we are talking about developers
who are willing to run "make test", so requiring them to have a
build system if they want to develop for this project may not be too
bad.  I dunno.

> I guess we'll see over time how much of a problem it is to keep build
> systems in sync. Proper tooling is a first step to make things a bit
> less tedious, but if this still proves to be too painful I'll have a
> look for how to further automate things.

With very small set of topics between 'next' and 'seen', we know
that we already needed 4 or 5 merge-fix changes.  The authors of
these topics would have wanted all the help making sure their
updates are good in both "make" and "meson" world, if they started
their topic in a not-so-distant future where ps/build~1 has
graduated to 'master'.

Thanks.

