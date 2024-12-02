Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7010A4A29
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 00:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101106; cv=none; b=nlD1JSODmwvuQBaS4xaIwmwF6zFsJ/Sg7Esqzhq0m17FEulVbuRG1GKIO/tXXFeG3ixcm5OLoj24KID4Qqw8aFMrY80ZfWGhucFyOqpFOiUMeyBKo+NniStkuajKj8wq35LCaFKxpDDn73lfzwoZPTi0WqOIqIMxKdOPYI53NNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101106; c=relaxed/simple;
	bh=rzKGyy0y6f2ZiU0SLUgptlUEm5dMBoqJqZvlqWIC++I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rp8tCJbNAofelU+cbzGu6hKaOorD12inSPuLUDPeHvQpMB2o2pSdRRdrc0+2i6ki4VU8BWECk6hqk7f+T0MZ1Eg5wLXD1E4CvUhuqearj7vYRLNnQFtUUTmHcgQ4+zyKdNMIsQWf8X6B6eoM1yxJ1IuVUb5NUr2tOro+//bUz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i/HdZ3Ln; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i/HdZ3Ln"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4904B25400EC;
	Sun,  1 Dec 2024 19:58:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 01 Dec 2024 19:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733101103; x=1733187503; bh=NVevN/gp4LfrOxP8Q2cRjSqsjGy4m6MHlhK
	2VPM4hvo=; b=i/HdZ3LnW3ETNJzF+PT36HpwaqPWTvVBOkRo0/xynmlPQGXAtve
	TZ0CURr3A/JvT6RQuS/FPi62ykzqWEyyzMQMEmWxZf5xC7GAZ8Bmo3ymiBssgg5V
	C0H8eA8VMDnEj39FvNA9BcXP3D3Zn97YDdikhGpJDw/8CnTeVoPqR6oQ2e0992h2
	KNy3WKsWao3FNuwiJkj9HEL+TKQcdpehqtvaiwKBaODP3vGJHICzWKZgXbkKG6lK
	abyXbrTCWCN8ZWsNf3675V38hZu00//Wvxay+SR25kgKZmm+jCEmSGrjLAXU5H1P
	dk0DYSttbR06PohbQXiDLzEzT7zwbuX1qYg==
X-ME-Sender: <xms:LQZNZ0xqEybETJkqh9rpTSfVQ4suk1HFMoeA1Aggi2IonxAvfAoc9Q>
    <xme:LQZNZ4SmytW2-08_oYHjSd9aQc3PcvmXaD5z82nK39ruT50lepSp1z83WVq12G8wW
    DKgBblU-Bz7ou67ww>
X-ME-Received: <xmr:LQZNZ2XW8wlwjWsGfwoQZwpm9bgyXSa09CaG5QznBAhvo6eTpvTNB96ytjUNWMU_gHa_1gIgqU83ghc9QFZqtCj7JMaGzzitJo_TIgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LQZNZyhzcM_fGBehsS8A6LQFQBE0Q8GE1T38nFthJ2oJq8tmT6J5eA>
    <xmx:LQZNZ2C8em_x_ES5cbKv4xZ_oMboY_tCoq-96deeof0qtCNKyC0FIw>
    <xmx:LQZNZzIR5yVpX81_x46fVc3CR1nKuQJtIKADNMIHtswbGdrxq_k1Lg>
    <xmx:LQZNZ9DPimVnjO7qT-tOZLTMsKCbhrwpixMDuQg8cD1FRE9cfVBqhw>
    <xmx:LwZNZ-utqNedjx_4MsZZ72z29XP-fb-zYqYMnFp8u48_0yh7wWVXJIKb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Dec 2024 19:58:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>, 	Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3] fetch: add configuration for set_head behaviour
In-Reply-To: <20241128230806.2058962-1-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Fri, 29 Nov 2024 00:06:46 +0100")
References: <20241128111946.366584-1-bence@ferdinandy.com>
	<20241128230806.2058962-1-bence@ferdinandy.com>
Date: Mon, 02 Dec 2024 09:58:20 +0900
Message-ID: <xmqqfrn6lx3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

>     v2:
>         - magic numbers converted to enum
>         - since the enum is descriptive (well, along with the documentation)
>           I felt there is no need for the comment explaining the values
>     
>     v3: missed a magic number in v2

Both changes look quite good.  Will queue.

Let me mark the topic for 'next'.

Thanks.
