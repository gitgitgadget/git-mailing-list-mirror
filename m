Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF427470
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774227716; cv=none; b=m2xVrU/uxdWr/MSlXZcyq3JGyJ9jkE6Nlu0d4m5RRh3mSU4OvqgfSfpdwmfYGwHagzDZUMWd62KeA5Ct7rds+iGc3khIl/WkMa+92gWSdS6DZfDVM3I3gOBBn1uUR+DSJ9/lcAprTJog3sNAiUqJoMt4s5zSYk9HNsB/nYxmPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774227716; c=relaxed/simple;
	bh=Bl7A0IrkegssZOqwkzM3nEiIS2ucD//66/eUkEPFIs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RswI+kRN3ggXkNb66AXBhuKgIXjm1CbG3XCoV2h6ykbNMqK1c1csZ5fA7F8XKYvCrqUacHMddt44faLL5yM/plWpUzYUPMnBr8CKAJnSgDmlvIBj5J4YYB3bvWYrg53skLXJb4hCwJU9AYQCRE2QFTUYRpVYjxk8OqeEQcMasSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wb5MpZQM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hep1dSP4; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wb5MpZQM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hep1dSP4"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D0377A01D9;
	Sun, 22 Mar 2026 21:01:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Sun, 22 Mar 2026 21:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774227713; x=1774314113; bh=yaAU3jv8vy
	oGJVcjAqgy+NpCdtlBh+VNJFdpR1hMFSM=; b=Wb5MpZQMr0LHVQ91J4f277GJa/
	aW5eqUsf/Xc5qphVfSKM9UVerQM4lX24Rd+ARZI/W29NXueG9qxuOQxxA6+ZPRyr
	NHRKMoN6ZYUiYTDyfIziaIqCMyPHep6TwIlkL/DZmXcJJO5on7QFfO4vG+JjthIK
	JXeXYemGbOE0JbNqhFkF8kkoNYwHaUSBhTaYbKbNc1nCDeIAZiNYs2ZMw/z80YXk
	9dA0ce5heEJRMLIF8RNd+VKdlteKdJodJsicdiH3j+nlM1inV26CTmcsJzzy5GML
	+/91iYaRTeF6GMTvztUWjUQWNFRQkZrJ3NYj1yubzigFmNmWjtG7YtIcNbDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774227713; x=1774314113; bh=yaAU3jv8vyoGJVcjAqgy+NpCdtlBh+VNJFd
	pR1hMFSM=; b=hep1dSP43rIqaW1DODExM/trzytRh6k+yIgXSwLH5b0S2jUMEbc
	K03cn+/zMJs1cpy0bqwsXu3E83Z+LEgdl0zFD0MNVGC3+4e3uhvdxa6CPvQmAabw
	xe3yRpz4XrVM8MLHMP/9i736+XprXkXJdeJUtx4hZZUqAPr3Wcy2D+QHW6Trs//P
	/rulBgmpflxQp20MRJQhJaPJS8uTdU4WA0TQD/ytOtvNmDKzwoun4gI92eMEpJ7A
	J/hGtJKNner0Wi0X5/Q3Y8OVGOcKT+HybE5vzX8uv3zU14QqC/eRtJ5MABr7vJU2
	qFHz5kiq2XPWl4CiBh2FqwpvsOek+VQGLPg==
X-ME-Sender: <xms:AZHAaZ8tiGgKYd0ksDtbNsK7xIGjgon-yphuik6F8ibnav7Wt8GdjA>
    <xme:AZHAaUktueZK9VlsBFBcYd3Dh9cdxxkEoVi6cNTNcEAundKk3EOlZuyJ7qpCF2eh9
    vk3At4U5p3Hyz44NLQqnfjw1Dtf9BL06MPQslbGC0BPdz5awnp-0w>
X-ME-Received: <xmr:AZHAafVw5kvVrZWiEfHKGjmQSZFQ5alOcCMuU6Czz_eed9f1Rp6QHx3T8pFtUwOQBEnf5jqrpmNRdwqIJTUyM0VTxy5qzchXrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehrrdhsihguughhrghrthhhrdhs
    hhhrihhmrghlihesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AZHAaZFgF3jCGaabE3vUEopxeGZm0YR58BBbEDM_FMk7yBaJkFvIuA>
    <xmx:AZHAabcgeBv98OAEb3fcYuIIp4VjAxSF1lxUQbAInIG_Uto5ZUxlKQ>
    <xmx:AZHAaaKxOn71wHn-qg4VvWPyUkyli1osWWgITy6fYZejc3ejz8UKkA>
    <xmx:AZHAaQF2Jg5PrQNYN_Fm-RjqZybe3i2BcZv37aNjflD94U62z0tICw>
    <xmx:AZHAaQXCzDgabFtblA5hhet61XNUj9v7uWVOgAYJHwrXBQDilhQy72lM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 21:01:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>,
  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3] backfill: handle unexpected arguments
In-Reply-To: <d8e6f854-e838-439f-bc5a-27cbb4091e4f@gmail.com> (Derrick
	Stolee's message of "Sun, 22 Mar 2026 19:01:33 -0400")
References: <xmqqfr5sacps.fsf@gitster.g>
	<20260322053207.60992-1-r.siddharth.shrimali@gmail.com>
	<d8e6f854-e838-439f-bc5a-27cbb4091e4f@gmail.com>
Date: Sun, 22 Mar 2026 18:01:51 -0700
Message-ID: <xmqqa4vz7400.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>> +	if (argc) {
>> +		error(_("unknown argument '%s'"), argv[0]);
>> +		usage(builtin_backfill_usage[0]);
>> +	}
>
> Before we get too far into this: How does this interact with
> the ongoing change to introduce revision arguments to 'git
> backfill' [1]?

Ahh, that one completely slipped my mind.

Thanks for a doze of sanity.  This patch becomes completely
irrelevant if we are taking command line arguments.

It will become the responsibility of the other topic to detect and
complain about excess command line parameters (unless the feature it
adds absorbs all of them, which may be the case).

> [1] https://lore.kernel.org/git/pull.2070.git.1773707361.gitgitgadget@gmail.com/
