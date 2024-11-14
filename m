Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FB1B2196
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625928; cv=none; b=oao5ea/hlxEhhargHchgfY+h+TIDTbMOpyFgbxQrego3rELQgJmljx4h/7xkyv/faoXg5uhFeaSidE8cdRDP0as8rx9FiVaJeP3ZhHV1m55rkPGCzbxLbNXWmd0879yKg5eQmX99gxmsx/BBTjIWm4wr9wNlh51CLAynr1aQbrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625928; c=relaxed/simple;
	bh=B8TeJcGCrGAoYBCKCMs4OKsxKBSZdGNWNnDNdaOHiIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BrmbtmFydbzy4rs3yjK7VdmnWTXZHBclvu6iuDHQK7P+MyaBNUxcaXcsiw0stDWQfCpjfvB38g8l/r/lxJSJ6XxrJYmmnD0g/wFH9L9S8uVsbgJJzEQdBnhtyXo24y3UbHEZi0S+uxus5LLSi7bzj2OvMvoaZLy6KD1WYJw86JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aHRGy6vF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aHRGy6vF"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C0C2C11400C4;
	Thu, 14 Nov 2024 18:12:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 14 Nov 2024 18:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731625925; x=1731712325; bh=B8TeJcGCrGAoYBCKCMs4OKsxKBSZdGNWNnD
	NdaOHiIU=; b=aHRGy6vFUg/Ajv/ScFmzm8q/E0IwaHOGMMHY0eyrTqTC5dVg8aR
	I3bzP0T7IPt7jtSt8HOG7qY6+iy8nGIKtMWqKid6gXa/VfNdZ05wnKwRilU9HuZl
	aANj3eKQihHrY3kMomgukVeCdTWzzJRi/nOdEC6PeEhmEXjlJXYkzxNtuzIlByfp
	dJKnkrOE/UBYFulZdrAjcFbpcfagVZCh4543NroYYU9/KfXpSYf00GQXOsLWjGpf
	dA60OwMkw1L1dXP5SvfNtwfRVeM/OMhwNcjzIklTRxw2JpCM90UksO1SyCvPhun+
	+CtTBAxyv0iz7McLg5CEdRCpFP3kWjC6LOg==
X-ME-Sender: <xms:xIM2ZxWlxHak6oePZpYmd_UW32GPdWQMLEzHEGSCQw6KfvjhCzsz4g>
    <xme:xIM2ZxlEXetMHepiMd8NIOHLiFcLiWXFGtnQXWrJkfjgm-CsO30QQUC75rSMiAHM-
    xlNXDOsdbRPqj1ALA>
X-ME-Received: <xmr:xIM2Z9bMUG7L100XsYs71Qo-nbI_Ur8SmRnw57RaRVx37L90UxYOwS7QbjeadD6zXALkx9wjkkfGgm4YwhGsBM3Tw3x8faSSSF3F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvg
    hstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrg
    ihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:xIM2Z0Xnmj5V_Mcn7H1a-mhtEl4mba_hLVDYjnjx8Z9BtepRcipA5g>
    <xmx:xIM2Z7k6nBkRd8CqjaPfg3QBmg4fIJJQ9SOWA6YiPq1RQF80timQeA>
    <xmx:xIM2ZxfTuVXlJULH831GF9daaSilvckciikYezyzEtjLib6pyrKcug>
    <xmx:xIM2Z1Ecl3GaLTa9J8NFVk-vIdu4qzRr7wJfygO7-RQOqnfccSS9Gw>
    <xmx:xYM2Z0ftWkWPCg1w1m1bhn1Xc3tAumkUss2J24GwwdWNUKSr9etEZ67n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 18:12:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  Eli Schwartz
 <eschwartz@gentoo.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Ramsay
 Jones <ramsay@ramsayjones.plus.com>,  Taylor Blau <me@ttaylorr.com>,
  David Aguilar <davvid@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC v6 08/19] Makefile: refactor GIT-VERSION-GEN to be
 reusable
In-Reply-To: <ZzW-h-g5CiLgCsCo@pks.im> (Patrick Steinhardt's message of "Thu,
	14 Nov 2024 10:10:31 +0100")
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
	<20241112-pks-meson-v6-8-648b30996827@pks.im>
	<c0474637-3923-4e4c-a90b-e86d5f37a366@gmail.com>
	<ZzW-h-g5CiLgCsCo@pks.im>
Date: Fri, 15 Nov 2024 08:12:02 +0900
Message-ID: <xmqqy11l5s1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Yes, I fully agree that using a version header would make more sense. I
> had the intent to do this as a follow-up, but I'll have a look at your
> patch and maybe do it now already.

Yeah, I like the direction myself, too.

Some folks (including me) may need to adjust build wrappers they
have around our Makefile when we change behaviour of GIT-VERSION-GEN
and friends, but these files are meant to be "implementation
details" that server our build, and anybody who have been depending
on their behaviour are responsible for adjusting to changes to them.
