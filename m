Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A911B14FD
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642321; cv=none; b=Qyg/yDbNxlkOOh0wH4slWCpStGWayqQfLUDOH04WC6hTZb79LVp44/mWqWx1Lno9Zni9EfB+jguoMKopkdXzjaHz6oacB66wUqI3LTOHgRa6eqd+ownATIoxlfw2b3OqCq+ATqddcVjeiCPX8o9NCA9QO9soenVPRlVZDjJyu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642321; c=relaxed/simple;
	bh=GbjIKEEQNt1mUdsfTW/90rNpFtb1t0u+sCcx7Xma8/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3C4cLwnUMtepqocxiF3RAfkGBriYMZKTtSQkoHmlxul7jQGcNjKRAKTRLYbxH4im4lNTJYz2/XYu3uLQ5Jw9XM/HZihA/OR3qxrRa7QDYIiDn448Mi/yj6yyqK897pW4OOcyZd6BRxHp38x7NcL37RkTAWg9WqsLhERls4CaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EyhKUiKk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B9ayTA4J; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EyhKUiKk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B9ayTA4J"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id CEAEA1388271;
	Wed, 14 Aug 2024 09:31:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Aug 2024 09:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723642318; x=1723728718; bh=wYX7OLzm/3
	hExctCBPFv7fgp3Bfnf1FKicyWAp7Z9Eg=; b=EyhKUiKkyLBSv8yCqRog4E/sZJ
	S6I4xDdPNxS3sRrwIOEkZbAixKjRRAuleeCHr2y3Yfp7YW9x5mCnmjf2e4lXPA7d
	PI2yIQVe9xKB1eTL0xW3GxMafmb4oAGs6qTWATeJz+bQNye4Hxcr9pGAAIMuyOzg
	1tjkAJg+klXeEAlG5QKJURfRyzFqf2Vu3DUziH3KPvVoeaivG8d+1x5hVnhIENZG
	ZbQ8jFjDjd9NNDomrk6EgyXsFqdjKVOl2heXKLMNgDQaia8ELugeoafLc7L2nEgL
	8XCM+Z7xS57uhNMsPqQG8TPsCcjYgKORthxIeVJdVJSoAClaPnByorPV145w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723642318; x=1723728718; bh=wYX7OLzm/3hExctCBPFv7fgp3Bfn
	f1FKicyWAp7Z9Eg=; b=B9ayTA4JcedabxjLXrxReZToEBp5e8LaDQ0i95ggbL3V
	2agNbi+tbAiUX/cFIZr2+rRR3z7TCqXQJG6noQSYHF1vZwz9GLXWWEyJGNDgt3Vw
	3jMo87QtNzu1MSQOq0XytkYIAhS4irLAex9ECgOtnq+5wMA+SgulSofFkidv7SJ0
	iLWuYlSzTzvp1t2/Ma0yC9p5jD1XL6M9pCHPLZUM3DXPkwJKlPeWDJjQQ/hL/CBI
	pBo6F5dQNVRrpOoBcHCJluOFxwZvDvv2J6chYm0VWkhoeHZ6KPHzaIxBF8eo+V7W
	B9/BVSjau3zyqKlkMndC0MloWhGS7hoNI3F2G/Os2w==
X-ME-Sender: <xms:zrG8Zj1uTrB4K7DHtqxUNRzHwJ2REP_d0Hx-pSpJuc01pAaLKxGlKQ>
    <xme:zrG8ZiHaoVa_9cJtmjZ9nhN_p_LsRoFSCmcyeqgyV5N2lcK9CL2AQYqvovv_CYHDM
    8rGuGlOK156HRS8Hw>
X-ME-Received: <xmr:zrG8Zj7er_glUAgJPiwpprRHfab74e9jjK7v8CGyebeVwDO8wZal6R-EGkRBh1Qrluj7KCULN_sFTElu4q6QnL6mOeJJrILe6hW5g-6NXVhn_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zrG8Zo3AmM6TA2i-3NDd22VVKq8Ei7RY_DP6NSFD1vrUsqOFK4UgMw>
    <xmx:zrG8ZmFuSDgqCsIE6raBK8DIzVq8tmw8cq8ILnKb9qW6ihP-9MmiPw>
    <xmx:zrG8Zp_BVGrJ2tDuzhPLPkfkbwiyADPE2bjsN88o0MGKTjmRzo5-IQ>
    <xmx:zrG8ZjncPD81BFyAB4tV2V6KTHkqs5xhnUtrUPToX5O28pzjVXBC5Q>
    <xmx:zrG8ZrSGtC0B4UvOV5HMsMexSulEPjRZM1GYrUCjYzxAICyzy9EDXMNN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:31:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59e3fc5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:31:38 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:31:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/15] reftable: drop generic `reftable_table`
 interface
Message-ID: <Zryxwirh2z4gOltc@tanuki>
References: <cover.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723640107.git.ps@pks.im>

On Wed, Aug 14, 2024 at 03:22:36PM +0200, Patrick Steinhardt wrote:
> Hi,
> 
> this is the second version of my patch series that gets rid of the
> generic `reftable_table` interface. It made it way harder to understand
> the reftable code base and is not really required nowadays anymore where
> we have generic re-seekable reftable iterators.
> 
> Changes compared to v1:
> 
>   - Fix some commit message typos.
> 
>   - Remove some braces while at it.
> 
>   - Drop the "-c" switch from the test-tool's help output.
> 
>   - Restore printing-related functionality, but move all of it into the
>     test-helper. It has no reason to exist in the reftable library.
> 
> Thanks!

Oops, forgot to link this to v1, sorry! You can find it at [1].

Patrick

[1]: https://lore.kernel.org/git/cover.1723528765.git.ps@pks.im/
