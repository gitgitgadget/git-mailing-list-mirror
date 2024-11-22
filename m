Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE2A155392
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296087; cv=none; b=Q6T6n9k/pqjphXrNbj62Q8LmMbYRrfy/JuByZlP92Q4OiCNFpTy2uASgEhvAIfxZMqEUiBnIVFMSYfkh4Oz/OVm3xFvQI2TuH9rOj8uOWm2Eg1pOJp3DtJO3D6/w57XrX/UXAmwZEyTlyASb+VIRVJUauVqrEORV1eVtrmgQaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296087; c=relaxed/simple;
	bh=uJCb/6hYV5ulIG4u8s1PuvNGdUAnEhUs0N0bKmsT/9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NEo95CCd5EZwEi2IefmSP4HWqA/jnufQWgpxBosUm8L0y/cQ8qqHXl6H84Yvs8tBUOtbVU0x9AaGA4kzKP2ebBdsTTt6qepD2sWmwB/lp2OnaoymyFGR2fI65JUm2E8ODfP2GXwkYz/+urLRbY647mqZNeSTi0c3NK1tLVA5Rn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OnHS+Qic; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OnHS+Qic"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E9D1A2540122;
	Fri, 22 Nov 2024 12:21:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 22 Nov 2024 12:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732296083; x=
	1732382483; bh=HbfFXzmTjay2YytxMp3Z11nFhKBvTvfNQk+Axjidl7M=; b=O
	nHS+Qic/uTe1BSKOyPbUSnlf35SUeYpjvtoDrjMLRrif2O2V/00jx8NPWuU7yBm4
	s3DIkcJ3VhKnyWFZBvOgxj3aqq8aqa5X3m9YkYRUVHttdBCpY8p5crYt8xisZywc
	NR8MBmf9FaISrzFxDoFHcwGAVJ6jwH1Fm+iuwEboNbG/6IL8jr55be432ix2E104
	U+0R4wqK0JToyNKtpZDTRxveVNX6gAlN2RV3Og8vfJjdRiSfu8b1HB0Fb4diqrJp
	rQQEMX6JJU/lFkuKZ0LBwJ2+SzittqAgGdPpNJTLunP7D4bH48KDsh9k1bCFm941
	0Hefrz9DwLbixYpt94HmA==
X-ME-Sender: <xms:k71AZ5__ervUwc1kTbMpK4GLD9MkekxyvVBySnrxk_sXnoKjfOWKmQ>
    <xme:k71AZ9vMkSXMMTLgWbEGLF9401zsQicv_qhldCp-qXXMdJsP3gZ41EjvuzStkPsbV
    lqeN4V60BWwKp5zHQ>
X-ME-Received: <xmr:k71AZ3BTZbgr00ExCMTyrOs0GY52xWmGI2xuov4v4l9bxC0ouHjUa5lu9dUdGc1Dado296jlrsxMmUDgI_CIdCJlAVUwPbgJ5Q5_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeelgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffg
    kefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinhdrrg
    hgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopeguvghvrdhmsghsthhrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlvghsshhlvgihuggvnhhnihhnghhtohhnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehmtghsmhdvvdegsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhgshgrlhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:k71AZ9eSPtzg_EnkWmp8Q91tMSogdpSKBhci8KlweOsmKuAAMkOwXg>
    <xmx:k71AZ-NzCQv3iHgmpn_680unUoo0hVdU9WkACAO3UiXyQGaQeYw7cw>
    <xmx:k71AZ_nlTmHat2g_KibqNWhxOlng7-MDc9vD6fzAXd7xSiyf8Rea8g>
    <xmx:k71AZ4syX7PcaH5GynPNX8RdLre6fro2-bXMNNBhar1DP5OSoehc0w>
    <xmx:k71AZ_HEkBO5Su-_IoRsvmp83oszDawA71vht1bLonRUX9gE1frc9PH2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Nov 2024 12:21:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: Matthew Bystrin <dev.mbstr@gmail.com>,  git@vger.kernel.org,  Lessley
 Dennington <lessleydennington@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?=
 =?utf-8?B?w7A=?= Bjarmason
 <avarab@gmail.com>,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  idriss fekir <mcsm224@gmail.com>,  Joey
 Salazar <jgsal@protonmail.com>
Subject: Re: [PATCH] git: fix paginate handling for commands with
 DELAY_PAGER_CONFIG
In-Reply-To: <CAN0heSoryo-DO6WXKqqASJ5nDLqb3PNNiZv1TP=Pq11wsiSM6A@mail.gmail.com>
	("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 21 Nov 2024 22:50:59
 +0100")
References: <20241120101741.8225-1-dev.mbstr@gmail.com>
	<CAN0heSoryo-DO6WXKqqASJ5nDLqb3PNNiZv1TP=Pq11wsiSM6A@mail.gmail.com>
Date: Sat, 23 Nov 2024 02:21:21 +0900
Message-ID: <xmqqmshrrxpq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Martin Ågren <martin.agren@gmail.com> writes:

> Hi Matthew,
> ...
> Actually, no, it's not so much ignoring as *forcing*. Since you force it
> to 0, doesn't that mean that `--paginate` ends up basically being
> `--no-pager`? So `git --paginate branch` is now `git --no-pager branch`?
> That doesn't seem right. An optionless `git branch` would have
> paginated, so adding `--paginate` shouldn't change anything.
>
> But even if we force it to -1 instead (for "maybe"), I'm not sure I
> understand why such an undoing of user intention is wanted. If I run
> `git --paginate tag -a ...`, maybe that's just self-inflicted harm, but
> are we certain that for all the `git foo --bar` which won't respect
> `pager.foo`, that it's also completely crazy to provide `--paginate`?

The whole thing started with

    Calling commands using editor in terminal with `--paginate`
    option will break things. For example `git --paginate config
    --edit`.

which many of us may respond with "it hurts? do not do it then", so
I agree with you that a fallout would be worse than the problem the
change is trying to "fix".


