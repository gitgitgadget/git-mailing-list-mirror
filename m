Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C642582
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 03:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732247167; cv=none; b=gnnX5gP9FYAxnvdp5hEmfw8dAe2dYVsO1YYhMyHhh80h9LKZVvovc9oI41A99dm2sL67CwmmrKY2kSV9Lac6k1Yh1/5ftgtEa3t8+xgmZMn7/0bRx3MSx0/y2oo3qwAbXX+k1jQd6dikZcsVVW5X8rOwwm/ldbh0uPEnCrVixSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732247167; c=relaxed/simple;
	bh=30cmJvLhpCM5AZmud3/zu1xo7/oDswvcjmMkvCEMsug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tfk4U2hWHOkifYrjhX0VVDU0yDKJLna7jsTMg/vzaWILsSsnQhv2oJnvOMUr+32t2jFPGMPgrJ/iMyF0Imc+oPWPMkZv/HgFaEicD1esGMg60yxcQPx+OGMUvBTuts+muQ7FYueHfHjOZv8gnRkhS1aW2B3ctNjlNcJj88uKBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x86a+Rt6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x86a+Rt6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4812B1140156;
	Thu, 21 Nov 2024 22:46:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 21 Nov 2024 22:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732247163; x=1732333563; bh=3/Bg1jqCWES0HAZw2ixoS5Do/FEpX2JPzIG
	VTOD71nI=; b=x86a+Rt64DyLcC8CCjNeAlnPwwDPmsmX9zbIAiDvU6F0qCiuu5H
	mhZ974Z8OyjwB4+lF5dcvjoOX+1cCM8gZoJY0KC69ybzix9x7DJo0AV2kmbDWAnM
	p9pKQYTQPAER+rwdxB9DpLh5wE/1D7CLBGNQHWi9JbeMOg7KVTVxKAAAsyCH4xUq
	NtippoiYKKXqWz+oYjuH+8ZzJv40D3mzTjK26HNa4/cdwiMKr/P0mSHM006oJhwA
	h9zuVFP0UXaxi8hsevGgREl6EX7s84PyzlD+Qygb8JWUdVNvINT5owWeTXRHrmfM
	FUbVDKTgegcrQJhvWv4NoL+WkT9CBoWOoRg==
X-ME-Sender: <xms:e_4_Z6ZqEd88YLTnTwZI8kdzJZkfKdZALkFnF0GYEtCKVE-CPTnlMg>
    <xme:e_4_Z9aoOS3wKtkjpx8MDBqvZs_nQywPL_kMkD6jXdnVjXp9Y8GBjpQd9bZYuv_6u
    Syoxpo034jEAu_WuQ>
X-ME-Received: <xmr:e_4_Z09_5T_C1qWA3EavVKIALlTNEWlD_fBtJXPWuBpYjEY1KX1SuwFLEEF_W80lLwvwBTNw5_w_ENNFM8dL6VmaR6ppYm9cCyPd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:e_4_Z8qaz4g30tfVo024ctKdlnvmxRmWUhAH0sM8Qu0RNcGmreRk_w>
    <xmx:e_4_Z1oo8t8VtJI__s9RNy4sAoApaVXDxAXAhHooKceGoQsWFWKsMQ>
    <xmx:e_4_Z6SmOqo7joeTCBwrY3ZgzgbnEmRfGxFx5dx4WBC_RH5rNiV9-A>
    <xmx:e_4_Z1rdfXa0jzkUf77azkwHgP2Ld8DpOxdv9VxpwEWLzGosh0dyRA>
    <xmx:e_4_Z8W8azZsTq5rReEYnV8k5Lmh5wXQHCOERUG6s0CR7K8ix7q2z046>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 22:46:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] fetch-pack: introduce `fetch_pack_options`
In-Reply-To: <xmqqjzcwca74.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	22 Nov 2024 10:46:07 +0900")
References: <20241121204119.1440773-1-jltobler@gmail.com>
	<20241121204119.1440773-4-jltobler@gmail.com>
	<xmqqjzcwca74.fsf@gitster.g>
Date: Fri, 22 Nov 2024 12:46:01 +0900
Message-ID: <xmqq5xogaq2u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Assuming that the shell structure is necessary around it, the code
> changes in this patch looks sensible to me.

Ah, another thing.  It would make more sense to do

    good_example(args, struct foo *opt)
    {
	struct foo opt_fallback = { ... init ... };

	if (!opt)
		opt = &opt_fallback;
	...
	use opt->foo and opt->bar
    }

instead of what the patch did with structure assignment, i.e.

    bad_example(args, struct foo *opt_)
    {
	struct foo opt = { ... init ... };

	if (opt_)
		opt = *opt_;
	...
	use opt.foo and opt.bar
    }

because the latter, via structure assignment, always raises "who
owns this piece of data?" question once you start adding more
complex things in the "struct foo", like a strbuf that holds the
fsck configuration data.
