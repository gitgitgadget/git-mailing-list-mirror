Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FA4C76
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278931; cv=none; b=Lq+gaJfxCMkB0ygt82cdd/bJmUiidzXjAwQcEBgQWHuc3/UpXEAGX+fJHkZKH+5YiOmUubdB+21luG7KUh9J6FzEhq/EI9PkqwA9RH68tj3cc6SecAXBmUJbI+PLO2D2+T98fKCFyqg7HCMM2BWu0kLJcda9y4ixuodWeJQKHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278931; c=relaxed/simple;
	bh=M/n2M9FfJkfZkFluA80xFC9tPL0ciJqQjoC0yGFFwuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cXx2SMMaKNzB5JWbvahJiO94HYGfEDF++T9/9IQt+OVnMYRz5+QJ4NEVRW09zy8tAlcKCG3SJU1TCrucfM59/pyHlXYEar/7zjgLa2Y0L4la7NfYxyFNbFzguiYSklR9eeYzPiZrKa6swuF06uzP9jbK9F1SMCbT1tyFBxK5pTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uum/1/ao; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uum/1/ao"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD9431140166;
	Tue,  3 Dec 2024 21:22:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 03 Dec 2024 21:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733278928; x=1733365328; bh=M/n2M9FfJkfZkFluA80xFC9tPL0ciJqQjoC
	0yGFFwuw=; b=Uum/1/aoMFXrURrfHQY/IRhsqxkwv2jLawh95cuc9lggpIfrsbF
	g7/A2dPFlYq9s4j4KRfdoGmaITuaUkPx7sysvOILyVXc9b9XxobDtxBEuFH0S0z3
	yeoM5GzLZkDUDOL6nnFZW8zgSGrfkjwHRVIpjyg2ixorCPQw42tPcgQrQZZdldDx
	w21fk2nVdvlBmriWebP6nYKAgoIjXaV4gPJ/raF30OekcHUl8Bi0RAHboZftQr56
	CmCNVpPIKn9Kt1/yL4gz8k+pY+cJqgNuERiIQsI/GvGtjPfze43uLfS4v64CXZvj
	OKm/1cb8vnpJykQuTUuuqnU4FhgADLOVubQ==
X-ME-Sender: <xms:0LxPZ7w_XcWpFnsRTpFSqtUgvHeqN1VvTWSqdDNKMx15WxrdTjEKEA>
    <xme:0LxPZzQnPeENRIyaZlBgZZBxugGws1AbVuRJgCkmHIIyojeVzR_F7ZxH54fFL-25c
    zY3C9yIgadyXXnPAw>
X-ME-Received: <xmr:0LxPZ1XBkgtMeDtpNascc7wqgQDfcFiXdTQan8oyCzZ21n6F1mqFobzdRXy7qoeiOnfGX3RuXTu8FFEpBuu438le_uLrP56jQF7tG28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdegfecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:0LxPZ1gbbvwl42WGwrrBM_pZgMZCs__PcKkfXQi24FQH-sdXScHr-g>
    <xmx:0LxPZ9B41ig4tQY-XW9OdRK8sgcAFxeK5NXNxdeRRxYsx-PugO5suQ>
    <xmx:0LxPZ-LsglTCM47VBbWnmLMASUHHXW1vTCyXMIA1yEYJMqhkQh-Z_w>
    <xmx:0LxPZ8B5h2uBHWCoFehql24YhuROnkjikY47DeS8i3h8K059yh98ow>
    <xmx:0LxPZxvCIHXSARIowsur409vu8Ct8xsRl4wREHaBhRAAHK47nCFYpRkv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 21:22:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>, 	Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH v1 2/2] remote set-head: set followRemoteHEAD to
 "warn" if "always"
In-Reply-To: <20241203215713.135068-3-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Tue, 3 Dec 2024 22:56:48 +0100")
References: <xmqqiks7oprx.fsf@gitster.g>
	<20241203215713.135068-1-bence@ferdinandy.com>
	<20241203215713.135068-3-bence@ferdinandy.com>
Date: Wed, 04 Dec 2024 11:22:06 +0900
Message-ID: <xmqqbjxs5gs1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> When running "remote set-head" manually it is unlikely, that the user
> would actually like to have "fetch" always update the remote/HEAD. On
> the contrary, it is more likely, that the user would expect remote/HEAD
> to stay the way they manually set it, and just forgot about having
> "followRemoteHEAD" set to "always".
>
> When "followRemoteHEAD" is set to "always" make running "remote
> set-head" change the config to "warn".

If we were to take [1/2] of this series, then another plausible
option is to set it to whatever their current value is, but that
would require an extra probing of the remote state, so "warn" is
probably a reasonable choice here.

Thanks.
