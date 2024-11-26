Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F213CF82
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609352; cv=none; b=OPICW2jV78rvmSCesxiE5zgGTkA7ahWesx2ZUzjS4G0caBtMBI3i6WzQ1DMC4CPNJ+sZPx6M0qGscLNzbyprOiZQB1I7lZOlZJRqAhsxHWLu2gw5bkBkbcJXl4QSoNEzOT3A6ZW8TxL+HpyBQAsFb9CCx41Ev6GpUrH5sYiiy10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609352; c=relaxed/simple;
	bh=ne/d3jgbnN7rB2WoHtXc70SukN+oAZnJdPIwVMgp+Lw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bHF0c4xZsragyYVY08phuAZ4DdHJ/0roMOE8Nd76eCABf3tlZYQeFL/OwxMiOpOM+//LVT57Sh+Ugjl5ZNRasSV2kvBQAme3mYcxH01cNDDNkEj1Y6I7xxzlRt2Hqts6iYxrXKqA/qeLUMZvnCW2OT8cizPVuQPeudJr4T9651E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KUeVcvMf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KUeVcvMf"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F0BA4138074C;
	Tue, 26 Nov 2024 03:22:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 26 Nov 2024 03:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732609348; x=1732695748; bh=BhCtAlSKdxdFoWKcn9kLLB1H7k1ffrdAMG1
	rTU+RKRY=; b=KUeVcvMfOmYR/WBkfTef9l7yJx5prgsKQugChtBLMfAZjFWld5q
	itguV3p0suvrMOCUT6tQLaz/Cfo0qW/GzCK7hU2uGAqhaO05N9o0HVQZpppDur4q
	QB6suGP1zHnL7Saay6+4MwMk6oe4Y9Sa8wTowGrTG9aZH2tR6pz+rl7jQfpZ1JxD
	FCnuyAAXYW7T2yuU2dIULoonhZkh6UXqmDvwe1XqoWU0u8hd+W0l4Gehr9J7BFk2
	S6yU+q7CiZVI/QnfkkBmvuX85MYclVrmcnDJLnPnPXmd4ALOufUIOZue4tsYZvKC
	rGMJExxrRCK9i2zDFK03U8Ph/u1sift+upg==
X-ME-Sender: <xms:RIVFZwxf5Alhs-71gE0g1YyTjm0BCAH91aIgrkgSFo9psTarjDzmJA>
    <xme:RIVFZ0Rcp7LIH0ujvOcZWoBYbklg0KyrqXo-1sm_z-3QnW88dMSo3tcT4Dpf_NRjO
    xe6R2f5_JFuMhxKSg>
X-ME-Received: <xmr:RIVFZyW5N2w_UoXUykWQMjTrYXYKM5BNPHzxIOa3teFOmbEy9ml8ozU9OOdqTmW42CA0gumCju_-MddcrrLyLYFmsIkCJ5Et_w_DoPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RIVFZ-h-EC1GN15FuTeEcj9lB148qfUg7u7rDD0hv-6oGatMPjIu3w>
    <xmx:RIVFZyA9LmzsuPDZ98h7vfjGyoAuk8HI_a_xOQlwSSvGPX8UfWHmMA>
    <xmx:RIVFZ_JiATVvoMIFvPc6XgEPrVqPD0DjZe6F9AJ33PKeETTL5dZDkg>
    <xmx:RIVFZ5AeMlbFwCgFHB5N4CCNjk_I8gPZKvE3NNDykXP0sTVqwA4mIA>
    <xmx:RIVFZ1_vMm0KAw6Dq8Ghwu7A03mvQUXubOYawZIvWp4VAOprrE6TMzsB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 03:22:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] refs: adapt `initial_transaction` flag to be unsigned
In-Reply-To: <20241125-pks-refs-migration-optimization-followup-v1-1-0e1b4a2af384@pks.im>
	(Patrick Steinhardt's message of "Mon, 25 Nov 2024 08:34:42 +0100")
References: <20241125-pks-refs-migration-optimization-followup-v1-0-0e1b4a2af384@pks.im>
	<20241125-pks-refs-migration-optimization-followup-v1-1-0e1b4a2af384@pks.im>
Date: Tue, 26 Nov 2024 17:22:26 +0900
Message-ID: <xmqqjzcqxv3x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The `initial_transaction` flag is tracked as a signed integer, but we
> typically pass around flags via unsigned integers. Adapt the type
> accordingly.

It would not matter while the information in the variable is 1 bit
and the check is "is the whole variable 0?", which is what the
current code does on this parameter.  But when we'd start using the
parameter as a flag word to stuff more bits, this starts to matter.

Good future-proofing.  Thanks.
