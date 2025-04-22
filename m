Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13EF28FFD0
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337366; cv=none; b=KepX3jIw0t38rtNnZet09guV3kOQz4OLcqfsQF6AIzakISoJFBGNOTGdt5U/WAy42nXeR75fNABTyj0w+mUH9xpFcAMORRjaE4CIOxrNWfXLJg/n1PnvyTtcvclvqn4JpxUXQXFXZJOcr/PrfWw2/2daaYTOdB9y2eOiWYWVnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337366; c=relaxed/simple;
	bh=8rrr1zIZhnHoP/6nAVS6H/1za0cgv/RjTg4BIxx9oI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DHsDrQCu3jLZXUXFJKsPSzvi78NYSs5l/YlniJRTpfDH1NWU2T2KRuzYB+Elt8AR1OYTS7yGwjFdz73ZWdiiZEi9VnIKLkRKz+8s8EkC8pjp25bIrArK3MqdbwQe7DL/RKiH1fqJZzwRFJI8nVxjON+Wx1v+gh/zCG216PK5FdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VjMUBLLW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WTS2OrrX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VjMUBLLW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WTS2OrrX"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A1C7E13801D0;
	Tue, 22 Apr 2025 11:56:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 22 Apr 2025 11:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745337360; x=1745423760; bh=DCX1dB99g8
	UISQKko0Fv93Ea8Z7tN7sz7hkJWtIBRwQ=; b=VjMUBLLWU/U/WtrRilo3iimoBZ
	tsosdseDhg5DW7IJXA38HuxH0RCtALFWM7cVlHmafcRj/xYk5VUwqEMWdFnShjPr
	m7+3VHIE9cT92fxO+SO4AfzgJj3I5AUCSHWTDfNzyW8gcXGzQ9lwmIzlLygWi9UF
	B6gzLMvV4GN+CxnjCH2OIA00Mh1YH28TqcWGyZ6P2kuHs2uMWYJEjYucBHQ7Ae6A
	zkvakaNP+aVsYOyQmp/65WeT3uxmN/z6DRBYgQUzRO3P9u/7eLSWSb+dFFIZqkwD
	Jbft75kDA96YmD3JRyalL2rAiyCE7jp71rCPRv46hdEzO5fOlFlxcBx/q/XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745337360; x=1745423760; bh=DCX1dB99g8UISQKko0Fv93Ea8Z7tN7sz7hk
	JWtIBRwQ=; b=WTS2OrrXTfKYXhgT5Txp6IDGHk9RTztBqEvdbf0y+MzcAmXFwVG
	I9WFbRuKDQqhLhscTvqtXcd2rdU51QdaAXOJX+BbUQHVwWBLcWZxuTXp6gB81/VO
	ReL2Y9b993FYcbqlWlUGQ9B2h4AsfiuKZ01g7bAhk/iQyR/FlVCU9ZdxFx9CoyzF
	s4Znfp/vvrQ+yzvYDtQVlhamb8ablPsEtaahz4uuVIsp/4KXnrGqk0LEXDAeZHYd
	YHpC4KEPlKdgV3CPK7DiJMLygIBaR0xny3R4l14j9t95qv6NV6gd2Mt79c24iqfU
	j1bTF+yXdQSIokXx/w+A+rZ5M/h4FuZpdJw==
X-ME-Sender: <xms:ELwHaIY_jRT33aGQYaJou9XEHe8vDFr13fOxvezzpdXdtKXDiOooSw>
    <xme:ELwHaDaMtLIGQf3g0f-ZC7RFXFEOKXjkA8JW5ALbtBdFsZ6nUQLatOVzAZG65DDm6
    P9WWHcD0g7TC-Gf4Q>
X-ME-Received: <xmr:ELwHaC-PAFqWXhJQU2cKP73lxv9-DM4xhpPa4ANadaBnvMViU3U_IR04Li7KMUdqMUrDtHFxI9b-DLvB0J-AScoHhk1xucYVj0NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuh
    hnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ELwHaCqdGNk-koCNR4zWzqsWtwujRpTUdyJFqcfpORUZ_dqUV2gCBw>
    <xmx:ELwHaDprqhfhBhdbdPvIrPfYwIIoZbw7E4AC41EHC-F9KdIoMm_kuQ>
    <xmx:ELwHaARgRNYRD33CPVeiJGlrpx-FraOWaPZHgVCbWEFBq8EOqc4ndg>
    <xmx:ELwHaDoLrhciUPKxG3Vww6aYihuFTYPMJc9HOhCpHNzZXhpmUyOJ_g>
    <xmx:ELwHaGJQh1uCadP2-FpfJiLe82k7mvRIkyShmMxlXPkAMDFdUvyD0ozO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 11:55:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  toon@iotcl.com,  ps@pks.im
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
In-Reply-To: <17c2eb4f-e291-4189-9846-0f42bdead01d@gmail.com> (Phillip Wood's
	message of "Tue, 22 Apr 2025 14:24:18 +0100")
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
	<20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
	<xmqqh62i6jli.fsf@gitster.g>
	<8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
	<CAOLa=ZSR=7TEWLHa-wzBB4x+4+-BH3UC3G7s24Bc26JH63QKOA@mail.gmail.com>
	<17c2eb4f-e291-4189-9846-0f42bdead01d@gmail.com>
Date: Tue, 22 Apr 2025 08:55:58 -0700
Message-ID: <xmqqr01k42cx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'd be tempted to check for which package manager to use by using
> `command -v`. That way the only distribution specific knowledge we
> need is the package manager and we don't have to worry about the names
> of the various release files in /etc.
>
> 	if command -v git
> 	then
> 		: nothing to do
> 	elif command -v apk
> 	then
> 		apk add git
> 	elif command -v dnf
> 	then
> 		dnf -y install git
> 	else
> 		apt-get -q -y install git
> 	fi

OK.  "command -v" should be portable enough these days (in the past
people used "type" and yelled at by portability sherriff).  And
having one command line per package manager should be simpler than
having one command line per distro, provided if two distros that
share the same package manager name the "git" package the same way.
We had trouble with "awk" recently ;-)

Curious that we do not check the availability of apt-get here (or
just "apt").

> The commands above omit anything that updates the package cache as we
> do that anyway in install-dependencies.sh and we only really care
> about getting some version of git installed here. It also uses apt-get
> to match what we do in install-dependencies.sh

OK.
