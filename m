Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72A1372
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 00:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732494146; cv=none; b=B0BZv3wAYxm2rWHa7Oh9VsYl+xV7zT9bdNtRJXEhL9wvc45bhzCr4iFgSxWU++oLfOESsawtSzDzCsRWuLQ4os2jyYZlnIjYr9IEjLcsqQr2KgnmV0VlRe+ZLIOlqghAbrD3KukL/HGUAPStF1cQFoBRr8bA+iE7tX2uDTfCUEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732494146; c=relaxed/simple;
	bh=kntaMy8CKStBwO8Uete5nt0yo0x8fb1/E7Q8yC8kmFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e5LQdoOfNkwMWxi9fqlpizJKLX5pRVKgh7eBMNlCBmW6jxqFYnzvksWh95bx9RpKh9Ow3RWY3e4+ShEi5P2FYx+sLb2XeQ76m3I55sX1jl00t1qM3tKRCChTBiQ1feXg2YQp0DmyOxYyioEE4/aLympVoMOrAASZOhaJspCem3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jKHqS3vr; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jKHqS3vr"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4522254016E;
	Sun, 24 Nov 2024 19:22:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 24 Nov 2024 19:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732494142; x=1732580542; bh=XtUREsY3HGiYXRCEMORKKIfHH5DuKUqY9vE
	xga47VjU=; b=jKHqS3vrr56B1S4vlX1e8xC5ZvFJmYBcsM+pIqnBB5bHDL2nEpF
	ya1dpAB0lYlxONSwEdNFQWe1ssifM1Is3T96QIJOw0GqnUinI76pP3R+YPL8pJds
	CSD7G5IZOtqSDitkPjq38kSY9yJbjUvFM0xoFRuLtqEo54fC14668qer5g5Qfk5Q
	m2+OTC5k2LHAK+lajLBvAmazdx7H40jJK9IEM81cs2w9RBdQwDH5iNyg0iIYlvT3
	NEWxJLbFxM1PqTTAF/QpZBxCmB5XC29WVFuPOAOr9Wofas9eXR3w9CQuF6Asug4M
	OFcA80eYwcDf43+bdUYfjohXuFSEYx25c8Q==
X-ME-Sender: <xms:PsNDZ_b7IGmERxix1CDt3ra6xHS2trQE5_7jPKMmyrwg_cw_1r5CTw>
    <xme:PsNDZ-ZnKEgfwTnuHbSXjPUafHSU53bUIijOFJDfonHOoFaIBTGfZv3wqMnItST73
    Vmll1w9jwvSeUUokg>
X-ME-Received: <xmr:PsNDZx859Tk74iQrLBp7zse1WKGHAzjLpSvKJbt_WgiFad9eUlp_HQcQLAapP6PzWpi3KZvkUR_v5ds1_75SnUVggBIQD3fz07Y8VAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghthhgrnhhtrg
    hnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehshhhusghhrghmrdhkrghnohgu
    ihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrnhihrghnghdrthhonhihse
    gshihtvggurghntggvrdgtohhmpdhrtghpthhtohepsghurhhkvgdrlhhisggsvgihsehs
    hhhophhifhihrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PsNDZ1qYMs6PaDn-BQmdbPR8uFvMJDOdirvEvZPcNL10CsbOLYQEZA>
    <xmx:PsNDZ6p-p_vNgs5NcVrULf5vSN329iVDf7dcIx8v4aVCXw8DTm2NxQ>
    <xmx:PsNDZ7RGvFP6ki21UR7JVz-GGfkPw5Y6FxUizFhIWDqx5PCKQwpEtw>
    <xmx:PsNDZypkPYeep-EeoYOOZ0wcJ-tfiWksAPjarKFkGexWbkhbT7fHgA>
    <xmx:PsNDZ7dKPQpvbutKotnAIadXWQAkdwATluvNdj8Z8qKZWH2umFcr4n5T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 19:22:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>,  Han Young
 <hanyang.tony@bytedance.com>,  Burke Libbey <burke.libbey@shopify.com>,
  git@vger.kernel.org
Subject: Re: [External] Re: git-blame extremely slow in partial clones due
 to serial object fetching
In-Reply-To: <20241122175536.510952-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Fri, 22 Nov 2024 09:55:35 -0800")
References: <20241122175536.510952-1-jonathantanmy@google.com>
Date: Mon, 25 Nov 2024 09:22:20 +0900
Message-ID: <xmqq4j3w9n7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> number of blobs fetched as the blame is being run. My biggest concern
> is that there is no good limit - I suspect that for a file that is
> extensively changed, 10 blobs is too few and you'll need something like
> 50 blobs. But 50 blobs means 50 RTTs, which also might be too much for
> an end user.

Depending on the project, size of a typical change to a blob may be
different, so "10 commits that touched this blob" may touch 20% of
the contents in one project, but in another that tends to prefer
finer-grained commits, it may take 50 commits to make the same
amount of change.

I agree with you that there is no good default that fits all
projects.

Do 50 blobs have to mean 50 RTTs?  I wonder if there is a good way
to say "please give me all necessary tree and blob objects to
complete the blobs at path $F for the past 50 commits" to the lazy
fetch machinery and receive a single pack that contain all the
objects that are listed in "git rev-list --objects HEAD~50.. -- $F"?

I am not sure what should happen in the commit in that range where
the path $F appears (meaning: the path did not exist, and its
contents came from a different path in the parent of that commit).
You'd need (a subset of) objects in "git rev-list --objects C^!" for
that commit to find out where it came from, but what subset should
we use?  Fully hydrating the trees of these commits at the rename
boundary would ensure you'd catch the same rename in a non-lazy
repository, but that is way too much more than what the user can
afford (otherwise, you wouldn't be using a narrow clone in the first
place).  So, I dunno.

