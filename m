Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315D2E3702
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754892882; cv=none; b=gryzYxbg7xsGZB7MlR7b5TValCZASR45rpkGnzGnAppoX9P7xEGIPRW956OfY0MZ3Pt4nhNTxjD6AGQGIJXy71HyLj5xP0rcEhjmjFfSI2qGefujiiTM2U8uBtgYKS5RjGnSA7GRVRem55/eUNlBHkuPz+uqkh7ckp5kGT50nXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754892882; c=relaxed/simple;
	bh=wV7kX7h4R31tx8DP4nKp+G3hND5QmR/54HynC4uR+MI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N7A939htGF35+s6izEoFy+5w8FJlJhID/AcYkgJ8ABf+UKXcwaPulRhx0OM6yNRDAs13v8N3iMlHniT4GDllbU/TvQblakMnDAhvz1ncsMMemS3PZaFXn1WgVcFK4OXOzZ5S9I34OOQsXRj9WlKH49AcA7hmgw3P7CB/2Bbs3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=e/n3o5aQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HE+ECIyb; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="e/n3o5aQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HE+ECIyb"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 475017A0068;
	Mon, 11 Aug 2025 02:14:39 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 11 Aug 2025 02:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1754892879; x=1754979279; bh=MAR7VXHKMrUnVc8vxk5Oin+CgTSi2RtG
	85gLP5rj06A=; b=e/n3o5aQhokJ8zgMurXRL2azfcyf47CdG+FMSjDOOStClDBJ
	9VVd5QVGBqxgganrd9vnqZYHp5s2iT0KI9i6ZXvYj/SKK1d+wZoPVpQPSkoYtLIj
	2BcxScK5EeUUrOQAOZWJRDZKJEqNMd5iJEx3g0XTiJwZ8hoWhTq8WxHsCM1EdI08
	6nyagZX6GWo1hSQPsKyd4CPk3jzBJZjxugz7at6EGASYr+8Jkt20dUwMFFKflI43
	TEf1n1CeezRrWiWv3choVW3CyuqWSMiK2kRhWj5JadBmJxJDyiivzRQdCGuUL55G
	nvS3ROSjO1zwLxXF1feFiB28ipzxrJTIkcOmxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754892879; x=
	1754979279; bh=MAR7VXHKMrUnVc8vxk5Oin+CgTSi2RtG85gLP5rj06A=; b=H
	E+ECIybs34SjxO9GmmcWpYbfl8Kxi5oQ2jYGkKMTw6tujCUau0N1J/XIku+x+8fV
	gf1qxoJqMqsh3Xd1T8aWT3pwHXw0U4bj9LC0g0vegS+Dhi9CjVk6QzlS3WNhsK/e
	7LSCrTOHCiaNT6lbBHAmxF+dApnskXCospcWmyrxmoFek4CgzyJVsCzSGvYMh4EA
	IKvXGFNSiTBzFE5NhYC+Z/nzXEt3AnJZba3YT3SC26K9+WbPtsLIEmwP7hS3sxT+
	gyYWHjw6QGP1DpA9U285zcUtUsADQRGgBv2Q+HwPOy3jwoZMlZCTTLPKycw/Pfg1
	r8h+O9suuCNXk7kenhxtg==
X-ME-Sender: <xms:ToqZaO41l65Md1IcaVjNCWHRS2iEuxYwJHCQkTTflq3AQ4Eq40HmnPE>
    <xme:ToqZaH7mM5RdN1RYIsxLpkjiTusmMaOTQgwQfkskDxp2EDLoafCm0tkkQDq98PB0F
    fPhIQbwSDrRBqu-QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtgf
    ektedvtdfgtdegueeiueeljeekuddvhedtvddvveeitddvhfeijeduveejkeenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopegvqdhkqdhnuhhtsehhohht
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ToqZaEDrGCzrpUi3EWygL5fk9QG6vuf73__NkkPVIlF0E8IlmKfI6A>
    <xmx:ToqZaNYlWfO1Nd5htMHzUmr2GWD6xUww6hbYs627dcZFMslL5IqQ9Q>
    <xmx:ToqZaEjhzDRBddtvHomxsUkB5AF0l_1aBIKYlyyziGBu3pp2t5S-Tw>
    <xmx:ToqZaH6l1Rlht06hADeqOUFmFqReUJl7PyAYXRSBoVQxAZ8R0cIvGg>
    <xmx:T4qZaH2HS6cK7YF5W7LDp_4hPVdO_cV-Yu9zb2cIAPFP64TY79htth3O>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CFB471EA0066; Mon, 11 Aug 2025 02:14:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tfe48c4bf7bdc011a
Date: Mon, 11 Aug 2025 08:14:06 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Knut Harald Ryager" <e-k-nut@hotmail.com>
Message-Id: <a065e0cb-75e6-4836-9897-05089089367c@app.fastmail.com>
In-Reply-To: <pull.2023.v2.git.git.1754861423787.gitgitgadget@gmail.com>
References: <pull.2023.git.git.1753973177262.gitgitgadget@gmail.com>
 <pull.2023.v2.git.git.1754861423787.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] Remove the extra and incorrect closing bracket, so that the
 line reads:
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025, at 23:30, Knut Harald Ryager via GitGitGadget wrot=
e:
> From: Knut Harald Ryager <e-k-nut@hotmail.com>
>
>     [--filter=3D<filter> [--also-filter-submodules]]
>
> instead of
>
>     [--filter=3D<filter>] [--also-filter-submodules]]
>
> Signed-off-by: Knut Harald Ryager <e-k-nut@hotmail.com>
> ---
>     Remove excess right bracket from git-clone docs
>
> Published-As:
> https://github.com/gitgitgadget/git/releases/tag/pr-git-2023%2FKnutRya=
ger%2Fmaster-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
> pr-git-2023/KnutRyager/master-v2
> Pull-Request: https://github.com/git/git/pull/2023
>
> Range-diff vs v1:
>
>  1:  6bb5c653356 ! 1:  bb158425b8a docs: remove stray bracket from
> git-clone synopsis
>      @@
>        ## Metadata ##
>      -Author: E-K-n <e-k-nut@hotmail.com>
>      +Author: Knut Harald Ryager <e-k-nut@hotmail.com>
>
>        ## Commit message ##
>      -    docs: remove stray bracket from git-clone synopsis
>      +    Remove the extra and incorrect closing bracket, so that the =
line reads:

It looks like you accidentally deleted the nice subject line

    docs: remove stray bracket from git-clone synopsis

When rewriting the commit message with Junio=E2=80=99s suggestion.  Whic=
h made
what was supposed to be the first line of the first paragraph into the
subject line.

I think you want this:

    docs: remove stray bracket from git-clone synopsis

    Remove the extra and incorrect closing bracket, so that the line
    reads:

        [--filter=3D<filter> [--also-filter-submodules]]

    instead of

        [--filter=3D<filter>] [--also-filter-submodules]]

>
>      -    The git-clone documentation contained an extra =E2=80=98]=E2=
=80=99 after
>      -    `--also-filter-submodules]`.
>      +        [--filter=3D<filter> [--also-filter-submodules]]
> ...

--=20
Kristoffer

