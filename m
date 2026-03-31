Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEAF1B81CA
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980727; cv=none; b=Pr5GNndgMF1vH92NZu74v5JiPPXmsQwalVUxS8zZFt7LN1Wo1V2A9sizk7bgXJmusKJS32gXBrt288mOsy/h5+OUU+ye+CBMk5OgIy/1c7Ga+pU8535xMPpjhbgiMcYgUWvP7dHJMZbkwwXwYGzhi7/yG79lB9FBpKdRW5eAHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980727; c=relaxed/simple;
	bh=p7L+DTdqGfP1r8gAYFCFShh5mfs0VvdtttmT2cCbZlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TVUKVIUuQHQXFmv0v5mE+fFQHzUlBaGRDg2Zz/EryPcdPe+sL8MMAyNYG5E7VkkEPRrqFhV6QxPHsHfJ8VRVrGXZHsNpC4975RC31f1/a4rwZk+cPZrD0UsNDOjTpHzcyjfJPLxwThGDNlR/tM/hPcGKAjBbbHXg17YV9RWAY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n2drDajL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j3wMQMNO; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n2drDajL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j3wMQMNO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B05F1D00060;
	Tue, 31 Mar 2026 14:12:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 14:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774980723; x=1775067123; bh=YM8QPJ98uA
	UgJwrLIjKCkgqwlREu0W3wdyQQofH8f0o=; b=n2drDajL7sDP6/V4K+dKPbgwG0
	rqyR+A/FKKQkhR4f33GgKXU3jSyksU5TrX86d5MWeLlVzPMswITEBGC3iuWM/GTH
	mXRGZ71rs/bTk2xzkTWhLnkwn8L09O4mb9hg4HjphbcOCRP7vyy9MRJ2+w7c6KzM
	QXwifaKl1YWjKqmECCQqnR8hZ6du3yd1PrMT6kiWoRiaMERpgBlnvUK3pmcZEpuQ
	gRSYY329vafJcMo406UeQzhanHucISy7AU8sB/9pfIUnnOCRAsuob0ZRqjfAAzfH
	w2Fogwq4UHRLQKl7dwjIVzOZ5JKmW704Iu6UiR2Sv4TtHOOa20gRhpDFYGWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774980723; x=1775067123; bh=YM8QPJ98uAUgJwrLIjKCkgqwlREu0W3wdyQ
	QofH8f0o=; b=j3wMQMNOJWxx8RGayDwSv+3+9M3uOpKFPF+J0mY2dDIiyyPIkpN
	F0Z2zj3Pdy1vdhxkVxTfIXZiWPGgzA+ukU4wxyUk6uegnf2WsqG+Kjssyzh052HC
	g1gzKuCskr5ir2J6Y7uX2uUGOQSYmfDru8EDK75ENsw9QEoz+V8SKbC0HHujpDJ0
	12gV3LY5nS8I1mPsRa+ipLl3XNcSp1yiAlJblcs4RYDbcD+cRxQ7olP+1UIuOw2S
	E5msV4+DAPa/YkgMv33kPXVTrfJkQVraTnKHc9czIeLW/r66cjDQSJ6Cl6q+qa0O
	A/H5xvGKWPJnArZMSZyb8t4j8/t/qvk56DQ==
X-ME-Sender: <xms:cw7MaZiwAndQ63dCD3RKYjxAnwcrcegm73X9Awqe5SItwPKpV1ZM3w>
    <xme:cw7MaVe4v2QYeVB9GJt8i5tGPokKatVO5VQb7CP2iFIBypTs1Q4bnH-JPyqXxVSf4
    zxcjdLAmo6sXnBnLmW2Z4YbYqohS1UwkvsxPKubOCVBhlHlVnVy7g>
X-ME-Received: <xmr:cw7MaWev8buuqE6nYkdx69P5WT5ll41nLX6agQ6-DDXqAd6PHtdc36xy1dSRRHQeVL2TPtjXwheCUI18quRRVTAKthM1JZqgww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:cw7MaX-8PBcZbfjEC2rA3Izd65YdjrymnOMvV9GsEUCNUxhljQUxvg>
    <xmx:cw7MaanXq8f7WaKdqOgT3vfkr31YFv9nUhecgokzir9NUY8bwsOsyA>
    <xmx:cw7MaR8qStD80WdSKiUhGN6aKPmu_RtYJ8Uqts1RmpE3TmiFBeR2UQ>
    <xmx:cw7MaQnT0nUAzxRZ5XPwIHNs4hNYk--Gw2TZP3kQqwCix8gD1ivDww>
    <xmx:cw7MadkdybHjd3MpegTr7zrQl7gZ_CkYT5ZdZlCuyN7wqUzFmc6P8uoe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 14:12:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] reftable/fsck: use REFTABLE_UNUSED instead of UNUSED
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-3-46bfae55c68c@pks.im>
	(Patrick Steinhardt's message of "Tue, 31 Mar 2026 13:26:49 +0200")
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
	<20260331-pks-reftable-portability-fixes-v1-3-46bfae55c68c@pks.im>
Date: Tue, 31 Mar 2026 11:12:00 -0700
Message-ID: <xmqq1pgz27in.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

Patrick Steinhardt <ps@pks.im> writes:

> While we have the reftable-specific `REFTABLE_UNUSED` header, we
> accidentally introduced a new usage of the Git-specific `UNUSED` header
> into the reftable library in 9051638519 (reftable: add code to
> facilitate consistency checks, 2025-10-07).
>
> Convert the site to use `REFTABLE_UNUSED`.

Good eyes.  Being self-contained is good.
