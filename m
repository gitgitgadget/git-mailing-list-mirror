Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063981CD0C
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101492; cv=none; b=A+vpTABaGHZN4gx6cb14hWnGw37/kO2NcYQOO8fZOy1P7biKlXmmuZaIkmm9KjJgJ+zf/yeqeDqaCvpj+CAb5yYuDJWrhLPUWJSirQcKJZp6RNEj7phABfkg0FqxCmy1DN/iaIjrGbpHSInmnzLS06p5A+ApoU5Kztw8UcUAgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101492; c=relaxed/simple;
	bh=9CmEH6+BPjINDb3y09OitqYQQUpueNOF46YwsCpzLjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p8HcTygiEm9g/tigZf0b+7+m4LGd+BEJGCOZeYijS0mk2IOkLKp3oUIzDCFBNf+C2SqA4TriTj8YXZUrPutZaIWAi8vDz72ojdmGqGl/4JgKGod/0w6EqdywVS5nfp41BQTxMMeELqChRNg03om2p60dvsRrbOoKvn7fe+5PBws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TnhZqxy0; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TnhZqxy0"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E1FFC2540067;
	Sun,  1 Dec 2024 20:04:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 01 Dec 2024 20:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733101488; x=1733187888; bh=d3Wbzls8MEvViJVjOgtsKeWV/3tk9+12/Uw
	Z5fDC3RU=; b=TnhZqxy0J8CbJP0MTXQOzxmCf1mCiFZ8GX5Rq7BfYuxINdRSUvR
	X5uAZ5LUQCdCMUfP9IY4vNeuLpl0rSpzJcePToOL/IbM5H4rZPP9bNXimx3zprGb
	J4w3J8xChZT15T6ZGGwDZYh1kK20sKw+MH0fHxYZhcSjdn/IT0k49c7SpwVCDIaE
	E49BDUxf+v1zVWneiO4vcwLKwiHPtpRyJyZnHBuLkSeFtSeg69/Hmlimi1Pglds6
	dyjOsjaPDUr03uZZ+3NzYy2k+qa23H/uCHB1S9IsQkq9fCJAJ8fUTufG7jP19maS
	5P9+ABFSeYR1lfjDv15wThUJ+11MQQ+n/OA==
X-ME-Sender: <xms:sAdNZ5XjCXKcrNqXSZCZZHt5geEcgB3pFRbuBapGkOPaKGWwYIfpVA>
    <xme:sAdNZ5ng_7sX6R9ayQu9oh9h5cEivDaFKyDQryv8fDodtvYOxzT0WudIOi9n8kKDo
    vEcfgpPixDTl7pXIw>
X-ME-Received: <xmr:sAdNZ1ZvKKI9_4HywJvdZhY5whs1m3H9vM0sPJbF_RAaT5dEfDnGkXHYzmzsXhQ4ogTFZM0PVy1Lsy-pRQsKqT3wwz0VoKr2ENDPL3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteev
    veeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:sAdNZ8UXatvt-v4MlYMICfEZvWymoCgiMCU_zJ7ve1mjIimXVqicEg>
    <xmx:sAdNZznhZrk355WR-MUIkp3qBF-ZsI9Xxc5tkZNsIO6u51AtpUITIw>
    <xmx:sAdNZ5e3me5EMWBFXcFqpvBCEt18ectRdlIpKBkPcpqYyN930K2UTQ>
    <xmx:sAdNZ9FmNlbUugENizXPC5HaBEc7bNld7woeK5YnpWPVgOFZ4gWAWA>
    <xmx:sAdNZ17ZyWc9TcZ3w_urVj6S26zFfaPtx3_lW_AdRgIy7WhuHDNIGWc7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Dec 2024 20:04:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Jeff King <peff@peff.net>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH v2] fast-import: disallow more path components
In-Reply-To: <pull.1832.v2.git.1732928970059.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Sat, 30 Nov 2024 01:09:29
	+0000")
References: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
	<pull.1832.v2.git.1732928970059.gitgitgadget@gmail.com>
Date: Mon, 02 Dec 2024 10:04:46 +0900
Message-ID: <xmqqa5delwsx.fsf@gitster.g>
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
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     Disallow verify_path() failures from fast-import
>     
>     Since en/fast-import-path-sanitize has already made it to next, this
>     commit is based on that. (See
>     https://lore.kernel.org/git/pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com/
>     for discussion of that series.)

Ah, sorry and thanks.

Will queue.
