Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44715575D
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732485515; cv=none; b=lDkdxcaDq6VR/X4NZyq2s7t0jO+JVJvl0gZmCPW8z/N56t9yPjKv8KEc5lNtxXc19yohR6kWtuqIK08DZ+sGxf03Crl2dtX+JibfCKE5Lm9oeQ0mf9AQ5+KSiaMqoWuJ3CRxyzCsGa4pFjcCOBnFZ7nLn5p02mFoq4sCs/SgraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732485515; c=relaxed/simple;
	bh=cQFfJCJ3bq97FhIsNYCV0K5twQ/ys8OfZn6r+3H1EZo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YfusGNQeM7MueyEvhzH8mT5fs2XEuNYOEIUW+tBS4AsFNiMHvtreICBRj8sgxu0xYdFpcU0/KUN5u7jeBHzOcBfFPT0nKdyNJwWNrUWK8ypXVnVRrL5J2r7inJxgw7Os7tVXjRozlac8yyE7rrqhKBaVf03gULUQrIvXvc3DHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ez2ofORu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jr2cuxZR; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ez2ofORu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jr2cuxZR"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C345254010D;
	Sun, 24 Nov 2024 16:58:32 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 24 Nov 2024 16:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732485512;
	 x=1732571912; bh=MBgCgUtvX7f+bkXZLGQaMBnsp/CbjZdSRyruEu+W4gI=; b=
	ez2ofORu0webC+7912xPvufnJZcaBPz+VHw1c1Yh6RnLlXg8vRUEDKvMFTUicVqi
	JamWzM6FvF1nRGMhi7UP8qSGBNVbZebqmQtMqA8fSogbl/m67XhDm0RQRY3S5a9S
	g0cbkb5K6xTkec+pPgaLXL3KlBmLvPP9vNxCwgDs+ARNcSELd4oudjU91XSY+zsa
	aOOxre5cJBdVzyMW1oRJ2lRur32gE1As0gGCIZklNeJRwSpF3UEYZwLjRWLmbWPh
	hHPk32t2abL83a7RRnHXi9YIAiPwYArHY6fzJX1elrvlD2NLL3JCqf8v8L35cDHX
	E27YuSXKq2WYVrFlOTbevg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1732485512; x=1732571912; bh=M
	BgCgUtvX7f+bkXZLGQaMBnsp/CbjZdSRyruEu+W4gI=; b=jr2cuxZRFETX6hNFN
	pTZRguwheTCthCzm8mdBhJANmaL5KhM7Zi031sJdIGgk9Lnicn0Xh+Ebmw8jPziV
	nFn0e4FKYSKixdkB1XcmcU4xyl1kL2hv6H/0Tc7461GfHvilSIIwrNnnk6IE2KZR
	oCSM7Dd9YKNWBRCFR8MPu9prApZXU4EmkqEQTYphDWdTeL1WPiW9rjWRriPWlSnI
	K0rtHvo6MRF7XjxAGjb6veeQXEuK5z6ltJtU8Mafas8+9+3Nc3hL7hvKwPjw2/T7
	+vWDqFTQeS6AevcVaeVZc/0jIf6n8m/Iqegg4LTgv+sYVzU1xY2HFUJKeRPPqMxz
	9oOWQ==
X-ME-Sender: <xms:h6FDZ8QN0ZXAyvJm1GL3X1p-WfKfeavoaY0oTdjsV0hIul_gWB9aa1A>
    <xme:h6FDZ5wQB437A9gosS4VX6aRLoOCQK46nbilCsBfy4fZjEFCnWqP-dmzOIVghMo1Y
    qtf0XzjHdJaPc_gDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeefgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeffieeftefgheekgeeitedujefgveehvdevieelfeeiiedttedtgfduhfejie
    fggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:h6FDZ52SHvSms6jp1cck_3CAuD2cdK7aDi4naKoEyonXAkjwD0KfzA>
    <xmx:h6FDZwDnXPxtZ_PpKrFtX4435LM8PBr6xHU6iLI8fvPJHEe53udCnw>
    <xmx:h6FDZ1gfXBtITIUyc31GqKNsKJDa83dbOGwkm-lreIt9W8h0vGjdiw>
    <xmx:h6FDZ8oEaSB4t5hO85_tH2ke7-PHMTLVv6MwEOUfK9lhmy82F9GTGw>
    <xmx:iKFDZ4u_2qqHqWhwzolq-QdPaAc9vUYoiT-5aE5sn_0jjTWrqPVskO4i>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B6EC4780068; Sun, 24 Nov 2024 16:58:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 24 Nov 2024 22:58:11 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>,
 "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <89b1b39c-a6d2-4f63-9cc5-722772bddd8a@app.fastmail.com>
In-Reply-To: <D5UQHS9IV5N1.3IO1848Q1730B@ferdinandy.com>
References: <xmqqbjy5bc6m.fsf@gitster.g>
 <D5UQHS9IV5N1.3IO1848Q1730B@ferdinandy.com>
Subject: Re: Extending whitespace checks
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024, at 22:41, Bence Ferdinandy wrote:
> This might be a tangent, but since enhancing whitespace checking was m=
entioned,
> I'd thought I note here:  `git log --check` running in the CI did not =
catch the
> white space errors in this patch (see the last hunk):
>
> https://lore.kernel.org/git/20241121225757.3877852-4-bence@ferdinandy.=
com/
>
> although it would have been certainly nice. I'm not sure if --check co=
uld
> already catch this actually, or if it would be easy/possible to have s=
omething
> general enough that does catch it.

It looks like you indented some lines with spaces instead of tabs. It
doesn=E2=80=99t look like a =E2=80=9Cwhitespace error=E2=80=9D in the `-=
-check` sense as I
understand it.
