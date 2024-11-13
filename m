Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13401C147
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459791; cv=none; b=JhdD4mrbJ4GR/ucKbDrlAaEvvbwpdAkC+IXPoKsFepLFFZHjWQMV83DPVYyYUJEVoK8KA73uRxy+irAIjHcK/pUyGcw3Dtg0pR7q2c0hflEtptWu7GTQF9p2A5VCKek9Waz2ehHK7pC6t5z+Dm8A0FRKF7NyYVERyZU5nap/4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459791; c=relaxed/simple;
	bh=BCNtEyS4zdOGGqen+FnEFYMp5aKnSfUDb6xX0eSuz6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OagPRsGAgRnVJdB+PqAI5SNIdvSMtVeXzwRHx4ZtDxVkznh1OkUe7pUYd2kd36hUiXbfu3XSVyk1uF/1Ho8793R4RBGLNfFnwhuQQu8vWPT3GanT1KvJ3k8FrcJcI344NL87WrM9r9FcBWa001h5KfnvffQ9uCzWMPVXKIPLhYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M4zmkduI; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4zmkduI"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 00C162540140;
	Tue, 12 Nov 2024 20:03:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 12 Nov 2024 20:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731459787; x=1731546187; bh=oBGMpYd+d1ndyHaEwsqGuhL2xWIQys/nq+K
	emzfzGrk=; b=M4zmkduIqwtZPP2qRrtl6RO3YS3T5KtUBqLu6+nxgA//owetS1d
	qXsSsmiCX0LCuqXaaNF8XQMK9fGQ3TVrPO3GHGaemlo0yYemK7RiLco1Pwa7R/hh
	0idbPwkqkfHI/RIxy8BEhkqfrzz+W5/dVBRwFoftPBnGpLOWQs5LF7qndQi0o/AF
	nEfD35+rX/3pFizYCc1R6WgpaI11Nlc+ZjkGId/0OyGaTzywJIlofwPIExm1j2dg
	gmGMPma6YJoI+QEY4fJ+wn62hLgCqbC5ECNoBjosRPfNlT2LVLTdZkHpw9tuGJEN
	PTWh8jsS4ZC6VHrohDiUYiXmsq/wteH7sFg==
X-ME-Sender: <xms:yvozZyampAsg1yWcKDzHRVPKF9x20kvMerhpzURN-hg0s_8ArBWbag>
    <xme:yvozZ1b-XkmX5vJrlDsLhDKDE_TCkpxs7g37ulSz48xlLW4bvg4NFSHjOTOGnAQ81
    LouUMcLQmWUivbSAA>
X-ME-Received: <xmr:yvozZ8_mm5jfgcfjIHXAQj3cwna6RHG4WeEZGLCyH8adfWc24-xPpU2aMa0JNS1YOf2AeRxQUbJW6-XnXbIjngzy3A6QYXlFa2us>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:yvozZ0qsdpk-o3BwpVeBARRy2eB6arxsj-tB_GYlr7vAMzIvGBRT5Q>
    <xmx:yvozZ9qbzTLrbbI27U3ZF103MU_Bt170Z_8bT7ZfsVWAmYzmehxd0w>
    <xmx:yvozZyTUb5WUjbbkYeCeacPqhI7KWsvCcSYP3uhjiLqXzjYdeBtHkQ>
    <xmx:yvozZ9o8A1WyXuJOWmAPlsrtio4yo7aBRkOxQuESLbSbJyEJgIzd-w>
    <xmx:y_ozZxch3mQmgNm7WxffwDYEGm8awdSpEowdDWozfdE9yv-r4jxl7ayq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 20:03:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  stolee@gmail.com,  phillip.wood123@gmail.com,  me@ttaylorr.com,  Phillip
 Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 3/3] sequencer: comment commit messages properly
In-Reply-To: <86b4b485e0b3ef023a5d559f437eae22f2fd458f.1731406513.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 12 Nov 2024
	11:20:13 +0100")
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
	<cover.1731406513.git.code@khaugsbakk.name>
	<86b4b485e0b3ef023a5d559f437eae22f2fd458f.1731406513.git.code@khaugsbakk.name>
Date: Wed, 13 Nov 2024 10:03:05 +0900
Message-ID: <xmqqpln02bee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>

Describe what happens when a custom comment string is used without
the fixed code in this space.

> Co-authored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---

> +test_expect_success 'conflicting fixup -C after fixup with custom comment string' '
> +	test_config core.commentString COMMENT &&
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	git checkout --detach A3 &&
> +	test_must_fail env FAKE_LINES="1 fixup 2 fixup_-C 4" git rebase -i A &&
> +	echo resolved >A &&
> +	git add A &&
> +	FAKE_COMMIT_AMEND=edited git rebase --continue &&
> +	test_commit_message HEAD <<-\EOF
> +	A3
> +
> +	edited
> +	EOF
> +'

Doing so would allow readers to imagine more easily how this test
would catch breakages when the code is not fixed (or broken again).

Thanks.
