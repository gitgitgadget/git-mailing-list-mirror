Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973461ABED9
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153476; cv=none; b=hJg2PfAJ/PvhlWkTPV9bVAVVRpw4mNPOIfUN6vOc7WLMdIgTgLFg5FotAdUWdJomB/Ter6QTNowLsU/A5TYkl/2YwVPU1mWyJvx7rtUPSamGT4Znao0k/mUDP2VGDAzkNDtf+t6rr+RdMEjfS1qoXCTjyr6E927eUZKrdHKbaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153476; c=relaxed/simple;
	bh=8twGq9y+sRgJr0/Q6qpVNN1iZr1OAK8NpZ+iauBuQ6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tt5xVRx9pr9ZByKhsEVdFhA+tz3tptleYx91PIxevA07gSb7JLq/VcosxzIKjs4ii/TJu35DAkhvHXWBT6Rp4xDLuWVfzEuSeDkKUAe5OGLBKObeIoM/aBj7NZ+e5C1JBtj7zlS8AUzfUMnKTzX3v49kRHI4IL0ehVwG3ouOQ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bTVwwLpp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rehW4aVh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bTVwwLpp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rehW4aVh"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A376A1140227;
	Fri, 17 Jan 2025 17:37:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 17 Jan 2025 17:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737153473; x=1737239873; bh=x0ZQKfCThH
	gP7eVBBo+b8+lJZkYpAjxSsLTzwT94ml0=; b=bTVwwLppUUgQk69gjimFqOyip0
	g0PrILk1xdAYdTSzPdvcelre+38hdrYOfQPyJCAPfW3OJeDg8EAIZsGTpiTf7w76
	SSEpXMaeF/BicSdEHwEWvHu9ImgoN6uMhCFeKeyyutMiYnOPPmxExIs77rYdJFGV
	Gl3QjnQlTNy7muC6ZxU1QE0SL3KZCpeSipyVXRUHM7WcICz9T1RhAx11r2wa8wfI
	4G8DMf/WUqNeAJAwbkmlpX/lATiKEgwY2f+YoktBfSww2byJeokDVyr3BnHuhe3f
	sjq5VUCKdtvoTaCK0beYl2hxNuB9h6XN6ieWdloM4ei8GnzlKvxI5nuWe7+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737153473; x=1737239873; bh=x0ZQKfCThHgP7eVBBo+b8+lJZkYpAjxSsLT
	zwT94ml0=; b=rehW4aVhgQWaH/UJMOot7uFx2HYDvdrW0V/jeIIm801SBTrvLg7
	LzEROJnSDuYY/+1QPEEIu9kUULYImS3pGvBLRhr5nRjV8002FSVNfe1JJhIqYrYN
	Xub5usXAN0rOnOs8KgCP6J7mtdneraugowmJY2IZol3rmeWMJaIDgxtHsXhe+/DD
	k30XarUDwvv3prxPD+xcuN8ZcEWitJ2yjp5jD+AOg8uTbuwcZJDc/wuke3u1JTXV
	Zcz1TGNiaLLbEsA/HVOBVxm/KBd2BKkaVTjXvz0a5KeFqdrkEHPD42WKEm9Fte/z
	qfR7n41sZBm+kVHQG7sb6+vvcyus1hjMUuA==
X-ME-Sender: <xms:wduKZ9g_eAlv2_GOVh4gqS8jAEiRa08SW0hmT5ZL05NLFzrR8qR5Lg>
    <xme:wduKZyBbpYTBNqUHP00BzXoJqsqOTUHH1--3gPb2BD60aYKoGSfDOAqDaX-BdkSwO
    o4HcT_IgwSdgT59iw>
X-ME-Received: <xmr:wduKZ9HkJsPmZdu9p_28xdBG8iEDBBRh_6A1A2Geau1eIjbL07z6ql3WCG0r4SMXsbKKlixoj4SLXUeh3UvyIMoSq_7YkXsCX7b0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhr
    ohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueff
    teeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthho
    pedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhes
    ghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:wduKZySfsnxptgBj7pEcb6EoNXgAUFZHqLOuduMkK1nzftupj_LkYg>
    <xmx:wduKZ6zee7zI8pXgmAtWw1KMuV5BdU7NR8OAd0CU9xeRRBdrQj_a8g>
    <xmx:wduKZ47zQnoV3zcJHMvNdKfneJc7qk1Y_mNFRvV0wIsOrBsVmIfDHw>
    <xmx:wduKZ_zY2FLIdk7d5-aQgMOEu3u0YURU8uuTTMTzwHtl1MV5RYTqcg>
    <xmx:wduKZ_IcM6UvFjgjJMr9QnCI1YUNpuByvwzFk7D460SM7BEZ1bBrITZb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 17:37:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  christian.couder@gmail.com,  kristofferhaugsbakk@fastmail.com,
  jonathantanmy@google.com,  karthik.188@gmail.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 0/5] PATH WALK III: Add 'git backfill' command
In-Reply-To: <Z4jY2Bj-e8i9Zuig@pks.im> (Patrick Steinhardt's message of "Thu,
	16 Jan 2025 11:00:56 +0100")
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
	<pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
	<Z4jY2Bj-e8i9Zuig@pks.im>
Date: Fri, 17 Jan 2025 14:37:51 -0800
Message-ID: <xmqqsephhxs0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I was wondering whether we might want to mark the new command as
> experimental at first to allow us to iterate, but the last set of
> commands where we have done so are still experimental many years after
> they have been introduced. So... probably not a good idea.

I am not sure if I agree.  Anybody who wants any of these commands
that are marked as experimental to be declared stable can propose
to do so with a reasonable timeline attached.
