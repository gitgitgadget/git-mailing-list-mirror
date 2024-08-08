Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF513CA8A
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104434; cv=none; b=dtybPIDTGerH8XhJOaGhQIW2aGVVOnj7CKQgYZ891nhMS6vai9GQzLqeqg3F/S1KSvsoAV1/iu6hDyZPXpax6Zq9VX1WOH2/uPQanapNyvyApnr6SIKZxpVy53djPp69UAprHZiWeEFhFu9J+XgRK6wUmm7kLDGGyR+7HdBUA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104434; c=relaxed/simple;
	bh=dGyrp5I/5AbROPdl857InrG4/kKhdByw0KJ+SzWUgB8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FkGlybAXcw84KNR/4iScFyxvLFfT2XRoV2qjdtViJGsLGdmva2ryU198A0Wk4nl8ZkRndwk55DqkZjUGxk0PFRZZYpcxg4G98WMIf9WgX5e5R9CBTLaTynFdF10e/mr0m5d7Sym6CtMEcaPq/7NPo/JwFf7gdPBeE+EQ3iGYTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=bX4ojmuh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pNP0+HMB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="bX4ojmuh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pNP0+HMB"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 436481151B27;
	Thu,  8 Aug 2024 04:07:11 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 04:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1723104431; x=1723190831; bh=dGyrp5I/5AbROPdl857InrG4/kKhdByw
	0KJ+SzWUgB8=; b=bX4ojmuht74fbvIuksLJwXc32BfUIPuMniWg+9wgFTu4F6Ga
	a4wdsiXlsUm7RNybSCdfB8ioTMt1IiN0zNwHE7TyXYL3ovDrycgcevllcwOst8uz
	wUuy1/vpsYUaYEZKwDvGsh30P2EEjC6yMHYo2e7fZOskFZZHIJQ/XHEYrs+Sdp5P
	3N0J9PxZjH/Iqfhcno70nGEAyv8wdVzM/XpYIzUGNLWjse7gf5HDk6eCN5QJ+TbE
	AAeRCYHpKP9Bv+ve48D2WBj9iErsuYsDCCFvIVzC9JPMbXSSFx2abQcjKoWypiJD
	6hu/Klc39wdZnD3xaU5P5gI0Ydu8tq7XjqFmKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723104431; x=
	1723190831; bh=dGyrp5I/5AbROPdl857InrG4/kKhdByw0KJ+SzWUgB8=; b=p
	NP0+HMBdSia4I70A9vG9QGJppTTPl/qBro3lFXteVnRHfDU7Mxq0TFPIdFZ+CLXr
	2aOCP9lgYG/ao1h52yLU7++HgrNSSb5G6AykmNTNZfWsExXSKUTwM2CvLn3Zc740
	NriXmh84Y1QapwSNUEOpLq7wxwK+fCnHeiSEySl3M3A7QLerROZpyyb+dSMtkMly
	VqY79ESWmmW2GtY2ipvWP8sGvs6lwh6EGxRp2Mx+np9EmfsnbX0qylHvr6KmirAp
	KQMa15/L4XBruIN1hqW8WQHBw368qqFi3zGQLj3PFVA9fff/PDLNDsUJ2Id2sOhX
	YvmUJEkf5MPbRsOmk4JWg==
X-ME-Sender: <xms:r3y0ZoQ50BQ3T5ViiF1kTggvl3iCacJqcEDsb8GjBuZnP5wgk4vXCwc>
    <xme:r3y0Zlwx-7Xtx9J7oMG6j285FMEMq4a6EgJRyrP1AfCwrKuW-Hs7SQjv2lLQGPUkx
    Z0KoF-YQU7qCal8jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculd
    dquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhr
    ohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeefveelgedu
    vdekteehieevffdujeelgfduffffjeelffffledukeejnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehjohhlrghnugesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r3y0Zl0EfWpYjcQtcUjAIzT3m1ALt1zuAfu82BFB9TVyqFhuIYgT1Q>
    <xmx:r3y0ZsDVxZkMQEfmebOU5b4FXOLvRPIiODQ96p6mkHOZLCtqlcKRVg>
    <xmx:r3y0ZhhHigDrcutdlIoUHcu33xWgMBm0TnUu8jL6bLiNA6AQqjNWyQ>
    <xmx:r3y0ZopxxlFCgEpy7S7guvh56g0VRI294gb0dEgqJ_3QwJyovD0bUA>
    <xmx:r3y0ZhfV0xlwV_hPW0zwDZW6y9QeOc8sLj5-6Y1Z2y_JMjeVOXNe_8ai>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 14D3115A0092; Thu,  8 Aug 2024 04:07:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Aug 2024 10:03:57 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Eric Sunshine" <sunshine@sunshineco.com>,
 =?UTF-8?Q?Jeppe_=C3=98land?= <joland@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <24dad55d-584f-4a38-b6c0-dbedf91fdfc6@app.fastmail.com>
In-Reply-To: 
 <ed314f533355dc38bf8acbf7a69651e47eb8f0f7.1723102259.git.ps@pks.im>
References: 
 <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723102259.git.ps@pks.im>
 <ed314f533355dc38bf8acbf7a69651e47eb8f0f7.1723102259.git.ps@pks.im>
Subject: Re: [PATCH v2 3/8] builtin/clone: propagate ref storage format to submodules
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Morning

On Thu, Aug 8, 2024, at 09:35, Patrick Steinhardt wrote:
> When recursively cloning a repository with a non-default ref storage
> format, e.g. by passing the `--ref-format=3D` option, then only the
> top-level repository will end up will end up

Double =E2=80=9Cwill end up=E2=80=9D.

--=20
Kristoffer Haugsbakk

