Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF524A35
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732753357; cv=none; b=LDTPaWeb9yJikwQHc1n5kJOevohuj3As22LvUWuy/3SzbRTeFGefl26upQ6FG6wWchqAZXxkV31oLmOQU1oxJkO+Hzasm3PSC7vu4uhr7ZaqIpqIXzwu9DO7JkyE/2ukjba9OXsdL4LfhE8Ske/oCKByqt68ev7K4JWwNd8ryDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732753357; c=relaxed/simple;
	bh=xTp2bf9K8OaiU1g3a5Zx+/VS4cLBVYfZ63Zi6lfufIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mLfhizbth25Gkt6C7G97FZsRXzNlvrX2il64rxHXoQG7AhQbQYgxpBMvrgpgIKpFcu8UMp9XqF9sx5l6+wUVj3/CPCCDiV3sHfpVFotcBr22jksTmwemeelHAtM+/8QEnfOyvKjob1cycBW9eXWWzMFyS1Gqw6Gpri0ow/Ajhaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XN0TSuy3; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XN0TSuy3"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 846972540157;
	Wed, 27 Nov 2024 19:22:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 27 Nov 2024 19:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732753354; x=1732839754; bh=kNPX3GBmyiRh43HgaQCro8f+M+c1w2KAG8A
	SFYzp/PE=; b=XN0TSuy37EL2BBHOKbQK6O3kzCo5e+IzvR2B/4eruECDzBgM+Ro
	dqB1lcJZ8MJn6uJE2Yz++jwLTxzooedvsxnDGw7gE+/5xx07QR78BoxaAXgTfXlP
	3lyfgj2JHBP5QcLCeQhsPapbZGt3SYFlwmVMQz96RVru7mAzvXejeW/2LdaXi+9r
	HfaM16z330bV8KQETv2124uDsbBzqbB5Vn4cVSWs/0uTApjp/g29Lz8PwJBx1es5
	0Wl17UqErR9MDi92Lhx8kwIzoLoTp6202H6qOJ6PeREKdUCxFvrMcmPbX4N/Wrhy
	c1QfdgFxQhxGPYr40RTjI7iOrkQm3m/HcFg==
X-ME-Sender: <xms:ybdHZyBvbl3qB1ubjR4E4XqjVqLZZPid7O6eRooaFCJYAK4iwJZoZg>
    <xme:ybdHZ8gsUnk0DqLIpY3cUOsgrKOkLZyHqQraHnOctoTT8pzrW7JdC34sCuwSOHEyp
    HipO2ip_npB23Bi3A>
X-ME-Received: <xmr:ybdHZ1kZ-SsMlAp7nrewvzY_njiNG_or52nBseRQZVLD6SkJlFKR8T8AXHBqjw8t39K5rXzuJhKuUx-HmDtTFmitknRyMp7wxP5DrY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeevleelhffgudfgtefgueetgedvffevgfevtefg
    teehgeekhfefueeviefghfegueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ybdHZwwtxVZt-8jtNW9YodwOQAPXJphZPZRIyTRZdyL5DIARBkyQXA>
    <xmx:ybdHZ3S6wEPaoGupJJNFAKMC0ypE_tFoPDty-KZaGtl3WfiYADh8yg>
    <xmx:ybdHZ7Y3avwTkvSsykGIh7-jP3jO5Bq7DBTMRkJzjgPBEnYD0viTWQ>
    <xmx:ybdHZwTOrImZUfI-Ov-AuFPqo4bHeVT-mvMvGjG3L0Vecgq4lnvzsA>
    <xmx:yrdHZyEKdTCMyun-1yxaqrAg4hLwkn0U6t3C7FmNCUBZcLaa3P2LXChK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 19:22:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Jeff King <peff@peff.net>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH] fast-import: disallow more path components
In-Reply-To: <pull.1832.git.1732740464398.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Wed, 27 Nov 2024 20:47:44
	+0000")
References: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
Date: Thu, 28 Nov 2024 09:22:32 +0900
Message-ID: <xmqqldx4qkaf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Instead of just disallowing '.' and '..', make use of verify_path() to
> ensure that fast-import will disallow anything we wouldn't allow into
> the index, such as anything under .git/, .gitmodules as a symlink, or
> a dos drive prefix on Windows.
>
> Since a few fast-export and fast-import tests that tried to stress-test
> the correct handling of quoting relied on filenames that fail
> is_valid_win32_path(), such as spaces or periods at the end of filenames
> or backslashes within the filename, turn off core.protectNTFS for those
> tests to ensure they keep passing.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     Disallow verify_path() failures from fast-import
>     
>     Since en/fast-import-path-sanitize has already made it to next, this
>     commit is based on that. (See
>     https://lore.kernel.org/git/pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com/
>     for discussion of that series.)
>     
>     Changes relative to that commit: this fixes up the error message as
>     suggested by Kristoffer, and makes the checks more encompassing as
>     suggested by Patrick and Peff -- in particular, using verify_path() as
>     suggested by Peff.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1832%2Fnewren%2Fdisallow-verify-path-fast-import-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1832/newren/disallow-verify-path-fast-import-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1832

Thanks, all.  Looking good to me.

Will queue.
