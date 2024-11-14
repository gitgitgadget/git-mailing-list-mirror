Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CFC1AD3F5
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625584; cv=none; b=LQ+E+ZKJtPrR9QcvpNaWyWxUut/yvfXizCiTlfbPdqCSsjbXL9iTwDrjkMaXkrVxTfZtYk/E+PgbHgpbJxCxZSMlwY9WY+RLd63MReHy/Y8IiGQwGajjSPzRttVy+GgeM1Re/NjiFBIF79yoVieIlX5m+qMV0qgWAMvwBfQpu9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625584; c=relaxed/simple;
	bh=3E7PjOG95xX0G9WGjv9nW7PjUnIaKSATv1Z69fZp274=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nYLnKgZHJfn2RyHtJgc7FaXVRUnQKRppQegFgnQSnuJwm/zbpt9Smi1CfXHvTVGAx9CGqUJ3SZCvE0H5up+G/kOsHSFsmn4ADAgAkJXSzW4vMRt3k1lvAyd8fKJ8JKms8velIAdtfIzVmIYlRjqYsB/LXZHHKQnQ61ZXtBHpVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cx+LQbhW; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cx+LQbhW"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id CE7EC1380648;
	Thu, 14 Nov 2024 18:06:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 14 Nov 2024 18:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731625580; x=1731711980; bh=3E7PjOG95xX0G9WGjv9nW7PjUnIaKSATv1Z
	69fZp274=; b=Cx+LQbhWwFe17d2Z0kGggJEm+uZGOIqSmHaGT9c/5SQ4whHHDqI
	cLWUnWqRI7Pp5I32nfTD1mPF3fvqPWiqqpj9pb8uHupSWEpTCkqTy4gipYh+c9Dp
	fCFB5vZUjW/bRxYS3Jqo/vt/yYhEXEwWYvhnvM4GyrpIR+RTo38Ybz/vDSlVtMTa
	hybpPHgPlBps4DcAAHUxUB5t8l66NACX34vYmwld6+OJ1dELM/3TzJppELFIIxmH
	cuaopMGy7W9GDYhjyyXTpa94tk3zhnHTx9OG+iVsJYBFPmcZaJ/qpEkvA+xR2s85
	FKxbdICttB/1YjhC6V/Ap17SnH6SpXiL48A==
X-ME-Sender: <xms:a4I2Z_EeRTqg22VHks2YiF9RC6qBskphPmDSx0u4tv1b0RsY40tL-w>
    <xme:a4I2Z8XOXLUpFThFNY2_5NuSe2tGxigF-EiaS_WLucLdfkiXdqkFIFqkbWMU7-HQH
    OmfoltJG7K3VU-58w>
X-ME-Received: <xmr:a4I2ZxJgRQXtAuj5NyCaWXxYtUtKaAuFr1amx9JejsWHXLgrLY_ToNOalo8goO--UmCeY_nAvtZ8MS0DqnDd3LJVBjjJhMJrIuWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthho
    pegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehr
    rghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:a4I2Z9F_VQRecLuquqAkIitu9NQiRG58OCoRRRPfeWdtI9wMX27z4Q>
    <xmx:a4I2Z1X2LPhO80UkHywrAOB0uBRpuAAaXWV4gyIcTYmmo_9ogZAyBg>
    <xmx:a4I2Z4Pct12s6y6DAECZDujQyap0mTJid53jvWaRxq34_inCc0dByg>
    <xmx:a4I2Z00nyGz9ihTAWuH4asbPSMEUqTp8bDAlJYWwdJyuxJLNwGIXHQ>
    <xmx:bII2Z-PHQWw3Q2pIuALJ7LX3Zl4RSy_yzCoF_0nvObBnyNJOFuM5MpIq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 18:06:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eli Schwartz <eschwartz@gentoo.org>,  David Aguilar <davvid@gmail.com>,
  Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Ramsay Jones <ramsay@ramsayjones.plus.com>,  Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
In-Reply-To: <ZzWxvnn3Vu0rW7_A@pks.im> (Patrick Steinhardt's message of "Thu,
	14 Nov 2024 09:15:58 +0100")
References: <cover.1729771605.git.ps@pks.im> <Zxv4osnjmuiGzy94@nand.local>
	<Zyi7PA2m2YX9MpBu@pks.im> <ZyjlvNJ4peffmGZ1@nand.local>
	<Zy9ckDezMSKVA5Qi@gmail.com> <ZzHeMjqUjzWpdX-Y@pks.im>
	<ZzRvsOeLsq3dJbGw@gmail.com> <ZzSprTl5Z3uIx0_d@pks.im>
	<xmqqo72i788q.fsf@gitster.g>
	<a2b5e007-776f-4c70-bd8b-38f1ec9808e3@gentoo.org>
	<ZzWxvnn3Vu0rW7_A@pks.im>
Date: Fri, 15 Nov 2024 08:06:18 +0900
Message-ID: <xmqq34jt76vp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> If this is a requirement I can adapt though. While Meson does not
> support hardlinks natively, we can of of course manually wire up them
> if required.

Nah, there must be bigger fish to fry in the new build system
integration, and I have a feeling that by the time we are done, we
may have lost the largest need for hardlinks.

I have a feeling that in _some_ future, we may not be installing
"git-add" and friends for the built-in commands anywhere on disk,
which is historically the primary thing we use hardlinks for to
conserve both disk space and inodes.

Thanks.
