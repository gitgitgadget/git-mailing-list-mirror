Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54829CA
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731998906; cv=none; b=H9GXJ4UPQrgaKLg6Wvhn4oJXKQ6+vwg/VyEDxmyLDond1avIgKApPBN3tpf26Q8BtTZkD8X6/QZmrSLELSd4O7pDjATs2lE4YhUS1hF+jfXNRttGLnHFrVJyCs0GhLPqDENSztV0HiwZ+dONAnK44WOD+jovpdjDoJjzB+GACSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731998906; c=relaxed/simple;
	bh=06Waa3HgQSNaTfPkntge9ei1uEwm0i7j0cwbNDRfKpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P9nlgJ5cUBoVUzWPdkk3mnr1arXp4HDq1efc+tQwncvmqsQn64HTuDnIyDQBxc2NTjswx3Coyqhivi1z79aNfVUNWPXve4PSoccJ5z2sPBoSpYvPtVl7RG/DsCi3itLnr0/6tAAvxqq06kV6cJ2cWPYoiBN2iDm17NHCON5OhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C4LQt7CH; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C4LQt7CH"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 14F0B11401D0;
	Tue, 19 Nov 2024 01:48:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 19 Nov 2024 01:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731998902; x=1732085302; bh=06Waa3HgQSNaTfPkntge9ei1uEwm0i7j0cw
	bNDRfKpc=; b=C4LQt7CHCl1q6o7J73Zq0tMYmqK57hoyF+7hpPEogA2LGPv9mWQ
	+3vbNNxSqNxQqJ0AxKQ5eioon8Y2lj72CTtt6OF77LAf0rPVCp4wQvcjzag9u6S1
	+ahpuznDN1tLvHcE9VHuXGF6Gndh4P4S3b/LOA+esNLyqxG3TOxnMzEZ780Pkvh3
	2Dnt8hTiLtQrY4ALyLeD5wwhED8rTW1CGQT9+xaQodnDtX/XKHF1tR8dCDaBL7an
	21TKi4zb2aXASxnUimXRl2WogmAN8Czy5srIzGMFbkd80L9DCm+6/BEdwkaFyocg
	5ovMtFO/7L8sM59mX5V+zMO1GpJTIUu5CIA==
X-ME-Sender: <xms:tjQ8ZxtPhgx4YMbW6AtIN6PGnZBhTBvlBalF8LFRDP5oloYn6nmgPg>
    <xme:tjQ8Z6cMHJ-qhRkMBsgJPgFVQzX7Ahz04OJKwob1UZHUPeF9WSb6pW7PSlaEo8fpP
    C72O_ILhC_EzUFclA>
X-ME-Received: <xmr:tjQ8Z0zFo2V0kdXyoBj4o1VP4e-nAy0YGvGQmGSc1YEmBhmBcvs6lViy8un_QcP1dqrsha_jMB3w_j7pRYu1-14SdRQVYskd_RGZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopegvrhhitgdrphgvihhjihgrnhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrlhhvih
    hnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhm
    hiesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrg
    hmihhlhidrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tjQ8Z4O18HgGr0mYi1B4J9k6mDlSVFSvPkoVrdSzZRgvxg0yDggeEA>
    <xmx:tjQ8Zx-_mOymEGhrU45Zax2B3RmIDJ0qhzvX4RG_lWB1WaD1WOBADg>
    <xmx:tjQ8Z4XWOYzT7p-6XHyUs87WAJQw4_HxBnKq9xsSYwFF8nhf1yykDA>
    <xmx:tjQ8ZydmlTa07VCLXGq81LcdoCYlgo74roCR5Q9V9bfcY1KMiGyBUQ>
    <xmx:tjQ8Zy1XuQ6_FKItd0Lwj7kJB0r-Gu_ZsO3WTmi0DZKDj4PmwpUZD5wF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 01:48:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Peijian Ju <eric.peijian@gmail.com>,  git@vger.kernel.org,
  calvinwan@google.com,  jonathantanmy@google.com,
  chriscool@tuxfamily.org,  karthik.188@gmail.com,  toon@iotcl.com,
  jltobler@gmail.com
Subject: Re: [PATCH v6 0/6] cat-file: add remote-object-info to batch-command
In-Reply-To: <ZzwwuU2MifISW5BJ@pks.im> (Patrick Steinhardt's message of "Tue,
	19 Nov 2024 07:31:27 +0100")
References: <20240628190503.67389-1-eric.peijian@gmail.com>
	<20241108162441.50736-1-eric.peijian@gmail.com>
	<xmqq4j4egza6.fsf@gitster.g>
	<CAN2LT1Cmsw3RB1kbRBvoeLs8WaQeZWqrG96EQfMkMe_jdKaO4g@mail.gmail.com>
	<xmqqplmshybx.fsf@gitster.g> <ZzwwuU2MifISW5BJ@pks.im>
Date: Tue, 19 Nov 2024 15:48:20 +0900
Message-ID: <xmqqy11fd8i3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> While having a quarantine directory would help with the case where you
> have differing end user behaviour depending on the protocol, it of
> course wouldn't help with the implied performance hit when using the
> fallback logic.
>
> So maybe not having the fallback is the best solution after all, and
> when users have a good use case for why they need it we could implement
> it in a future iteration.

And I would strongly suspect that we won't have to implement any
fallback---hopefully folks upgrade their server side to be capable
of whatever capability is needed fast enough ;-).

Thanks.
