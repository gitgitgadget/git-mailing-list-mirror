Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDE3198E6F
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738012491; cv=none; b=I+gqmBC+4LGUF5fHL4bYeCgTGl0Jiz0awl81wunkLBrGdHb0Hc4lTzkmP5MBjjIlxEDGEVlSshkZlSMWFrWYbwdsUiR27gevTVWVjdP0LQtxZmWMqMdrlFa7qdfEE9yS5vlAF8M3KH0A88eLLtBshedosG1Bu2CQaXOnVyrGJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738012491; c=relaxed/simple;
	bh=YFsNpB2fEAl7OR3Mb+CSUuZXuP8NkIIMl5wAKXUwhhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RsHgymyxd1gTJLMjh86kQi9mrHd6OhpouSeP06I/ld7W+F5y+4Jw2HCTP80OoJJqssia2vJqKRoEEhdAqP7UOuk/f699D7duL6X2BoYeZSve0QogYDbqTkRd4B3VIBJcSFeFEipZz0o1r1ADEbwx5v/HoF26A5rlRqJjB1VurOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jxHZXSn+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EijnXKsL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jxHZXSn+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EijnXKsL"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E707254018C;
	Mon, 27 Jan 2025 16:14:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 27 Jan 2025 16:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738012487; x=1738098887; bh=4+w0UITRE9
	cJdb1NGtH2Yyw1DQw0IF4DVIEzH4A57q0=; b=jxHZXSn+s8SAvfRmG8awqlq1pQ
	Krb53Qi4xnUYWW6ithevGoT1fq4yVpx5uw7luNRk6w+IlF4/dk0xm9LrO5FThxGy
	rNsUfAD+qc5VWwrwOKEb4hO9tqyTkJ/O3ZEz9ebNWAZ5ik3m8I7BE9zwlvl8krLV
	JudIKcpJwsXp/z9WBkju0H59Vc7NxpQV8PydRHbrumn5MN+fz7jtfOXQ7wA2/kRa
	6nm0zQYNiOvChANeqM6XkSZO+cGOnDE36EQd5SVmxSVjPzKvxJm8H2WYhJC+2n67
	Tb9NMRWu6kfU5Ypjh3LevPRgwwW+F99IXsdVABvy86jsTpZXPBwSH4MHVGLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738012487; x=1738098887; bh=4+w0UITRE9cJdb1NGtH2Yyw1DQw0IF4DVIE
	zH4A57q0=; b=EijnXKsLaYZYlWoo4Up9sXnfTB8gjjzu9615tfPZWZeKKWzRJXU
	duyzbB6AxYXstTBSwzgMSkOB/pdqvt8fnl6FcQ16ysVSNecAd2dDR+thDfvGOkgZ
	Q45AIJwcLS901jJ8dmgbxG5BCFvKKjVHAZWZNlPnHp8+6+WUzO72YEq2E1oOiPG2
	0mFhBEuriy1QudQf3OHAkePw2MGqFgP6IAeflUG6r6PUYw1jW2MsNP/cDWgthxDR
	KBJM0+Lug8GDXcgUKR9SXME9TToodgSSajAy/6WTknF4E0xBXBrqcyPbXNjJO0qD
	CP6IisZWmNlUES14uQ0EFPDMGu2eYbJvzeA==
X-ME-Sender: <xms:RveXZwre3X2xW49ZmQMLnhLecJn8mI5-a1YnCBRUEDfjGQ447GuWOw>
    <xme:RveXZ2qiIpIZ-cSmotX9hQxdVUnODqnqhVuT04LS3ghRk0UlwwH53QNl8sFMT8vC9
    x9rPwtHjPOzBFNRFw>
X-ME-Received: <xmr:RveXZ1O7wvMG4mqoNhWFgZoaJBtU-DBz2kxymok0ldmqd3A6NwrewNl3RhXQ1OfqcNtRaEQRN6Kybo2SoDFH6QZA9nALvBOokntn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtph
    htthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgt
    phhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
X-ME-Proxy: <xmx:RveXZ37Ana0uKBS15IwbZcNIYme8fHpHCGJhJCKmA02I2mN80EKWBg>
    <xmx:R_eXZ_7th5tXU5bs8CzeU6Ad0rdcEXiphzPCe-uIESWOW8nWDyF34g>
    <xmx:R_eXZ3glwYP4dQixgQiFkK-4UjwD7fJkGLD7JLEY5sJ-pv8Qun0n9g>
    <xmx:R_eXZ55VJK6Gm5KMaqpzlpsNLN8q33PIhheRTfTdF_-hcau_VL2dKA>
    <xmx:R_eXZ8z73TQF3UQ8By0GuGFb3LCyRSj2vVYBAEEgzAEDYAskvWpkpMGv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 16:14:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Karthik
 Nayak <karthik.188@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 0/6] Introduce a "promisor-remote" capability
In-Reply-To: <20250127151701.2321341-1-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 27 Jan 2025 16:16:55 +0100")
References: <20241206124248.160494-1-christian.couder@gmail.com>
	<20250127151701.2321341-1-christian.couder@gmail.com>
Date: Mon, 27 Jan 2025 13:14:44 -0800
Message-ID: <xmqq4j1kq7qz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> This work is part of some effort to better handle large files/blobs in
> a client-server context using promisor remotes dedicated to storing
> large blobs. To help understand this effort, this series now contains
> a patch (patch 6/6) that adds design documentation about this effort.
>
> Last year, I sent 3 versions of a patch series with the goal of
> allowing a client C to clone from a server S while using the same
> promisor remote X that S already use. See:
>
> https://lore.kernel.org/git/20240418184043.2900955-1-christian.couder@gmail.com/
>
> Junio suggested to implement that feature using:
>
> "a protocol extension that lets S tell C that S wants C to fetch
> missing objects from X (which means that if C knows about X in its
> ".git/config" then there is no need for end-user interaction at all),
> or a protocol extension that C tells S that C is willing to see
> objects available from X omitted when S does not have them (again,
> this could be done by looking at ".git/config" at C, but there may be
> security implications???)"
>
> This patch series implements that protocol extension called
> "promisor-remote" (that name is open to change or simplification)
> which allows S and C to agree on C using X directly or not.
>
> I have tried to implement it in a quite generic way that could allow S
> and C to share more information about promisor remotes and how to use
> them.
>
> For now, C doesn't use the information it gets from S when cloning.
> That information is only used to decide if C is OK to use the promisor
> remotes advertised by S. But this could change in the future which
> could make it much simpler for clients than using the current way of
> passing information about X with the `-c` option of `git clone` many
> times on the command line.
>
> Another improvement could be to not require GIT_NO_LAZY_FETCH=0 when S
> and C have agreed on using S.
>
> Changes compared to version 3
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>   - Patches 1/6 and 2/6 are new in this series. They come from the
>     patch series Usman Akinyemi is working on
>     (https://lore.kernel.org/git/20250124122217.250925-1-usmanakinyemi202@gmail.com/).
>     We need a similar redact_non_printables() function as the one he
>     has been working on in his patch series, so it's just simpler to
>     reuse his patches related to this function, and to build on top of
>     them.

Two topics in flight, neither of which hit 'next', sharing a handful
of patches is cumbersome to keep track of.  Typically our strategy
dealing with such a situation has been for these topics to halt and
have the authors work together to help the common part solidify a
bit better before continuing.  Otherwise, every time any one of the
topics that share the same early parts of the series needs to change
them even a bit, it would result in a huge rebase chaos, and worse
yet, even if the two (or more) topics share the need for these two
early parts, they may have different dependency requirements (e.g.
this may be OK with these two early patches directly applied on
'maint', while the other topic may need to have these two early
patches on 'master').

I think [3/6] falls into the same category as [1/6] and [2/6], that
is, to lay foundation of the remainder?

>   - In patch 4/6, the commit message has been improved:
>   - In patch 4/6, there are also some code changes:
>   - In patch 4/6, there is also a small change in the tests.

All good changes.

Will queue, but we should find a better way to manage the "an
earlier part is shared across multiple topics" situation.

Thanks.
