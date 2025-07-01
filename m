Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E71EC01D
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353817; cv=none; b=ZPPpsJUv5xeLNOTSo8nMeD39ZR0B7nxKTejCI/XtwFvfcqm1Jwxs89Isfqzu0SfpR7AxGZMF1cb8O/l8K/b2QaG5CyYVaIsnomAhfO14mYfCP9n95dA8t/kK0cmZAXnwv4pL0TlfEdrON8Mjn2f9R6KcZ2iCwcKWDR9OWeVX3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353817; c=relaxed/simple;
	bh=mD3jFbhVzVGzG+DDEM14Wivo+UFCHGaMMmSgrjq+Rk0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Whl2WvNb29OGMAwxhriem79c4QuzBlJLlBwnEH48mKP7DaTHBfGlxB5RtDBW7rSASRRKy4UV7r0jNwZvXpmamFqQsvYtlx/XgNUxVTeLmb088MKXOFrdgBABJyiPNBznVFzHeyZs9Q1lKJ6/Re4yeiWTCQn9IJqDJ6MlD/hdOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ryS1KyNN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5wcGgJ2; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ryS1KyNN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5wcGgJ2"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 84AE71D002A7;
	Tue,  1 Jul 2025 03:10:14 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 01 Jul 2025 03:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1751353814; x=1751440214; bh=mD3jFbhVzVGzG+DDEM14Wivo+UFCHGaM
	MmSgrjq+Rk0=; b=ryS1KyNNFFlfb0KGjbuvjXN3ZsZeTEQjP1DTi1RKRNlDw0cX
	hBw+LqchdqRScAJvkOIaDfYHgWbNxEA75ZdmNrIiW4Jdga8k0We1QoxI/vjJTOfI
	CAaUZBLm3iKU8Nyp12uRSbINLWR58gZJFEauOfEvA+GrDj2KOhUYEer0mM/s43hI
	7XZDKD+qtA5AkE9R0SmDpi7DxE7B4eSVDztbSL+O/fqvgiWmVzApM5ZJgW/T3Sxc
	oTOCmSVesXP8cZbauxzJ+cr3xbkrKUPhM64Ot/adj45beAuOwsaRlbq5Yn1SySkg
	7B/8RuD6bXyeX9dmVcO36d9hTeQIcNxweQ9Utg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751353814; x=
	1751440214; bh=mD3jFbhVzVGzG+DDEM14Wivo+UFCHGaMMmSgrjq+Rk0=; b=Z
	5wcGgJ2UtU8lX3dQS6UzgTfJmHa0yKTvYrY5zi5ReuOhLb3Q/XpCSnrfzpECVZ34
	JthxF+hZmxTDkFqdFHa8CTxRyPWg5B92oJMqSaaWhB6efERUCPnWstHyeudNCmXm
	C/HyjnQ2S3KaVD40377MXilQn2/yRtBKUiIrOSLGRBgG4mYS3Uq3hbbtk6vFQJi9
	7X3vK23Wb18fnMy0PsZOZPqTnqhohBVQldt7kRlX7Y3AETk9EeVTSdGNaLMzHBI9
	1uSoyq2rfr1a1GQwOkgFlHrVYtvD0NXegqxoV/uec++HL6H+zXEC3bRpdihOwz33
	Fsk32682WcLqUyL31Vd/w==
X-ME-Sender: <xms:1oljaHY1KWjMNgSKJg3ugOGbEWPIkKC8A7QmvSche_GaXsVdOV5FrLU>
    <xme:1oljaGbjUURqccXJPM4tELNXpTVlYEiFoWfYJh0-YKptFNN3ulzzB5Lp4Cf7IkNoi
    IIKaw2BDm-o3Qom3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefggfeuteekjedutefffedtgfetveelledtheff
    hfegueduieeuhfekheffueefhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehk
    hhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:1oljaJ_Ok7ZNsKBhIWVboI0ulL3udwzeiUll97ROrhD094RsEOWINw>
    <xmx:1oljaNo_CSqnjvlauWIbKZEbg_vR0g6cjPNnoAirjAe2kd83AVLu-Q>
    <xmx:1oljaCrQiVpwOPnf8dAhFiqz-NP__LAkohv5M3ViswCnJTi0UGJblw>
    <xmx:1oljaDT6UTHYDEje3V-_P143XDDkhsT1BaEd99_i8S9ugYfk5i2Y4g>
    <xmx:1oljaAvPERMk__R-rB4U1sCS6m-b2NhpHndG_kWtg4zxgJcq2pxwCwC5>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 272B91EA0066; Tue,  1 Jul 2025 03:10:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T33683a0cbfa21653
Date: Tue, 01 Jul 2025 09:09:42 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <47e5726c-a401-46a2-b975-ab6b311cbd4a@app.fastmail.com>
In-Reply-To: 
 <ac3257a934d4c59de03757c2471c7067a8186108.1751310455.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name>
 <ac3257a934d4c59de03757c2471c7067a8186108.1751310455.git.code@khaugsbakk.name>
Subject: Re: [PATCH 5/5] doc: config: mention --url in the synopsis
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025, at 21:10, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> 4e513890008 (builtin/config: introduce "get" subcommand, 2024-05-06)
> introduced `get` and `--url` but didn=E2=80=99t add `--url` to the syn=
opsis.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

This makes `t/t0450-txt-doc-vs-help.sh` fail

https://lore.kernel.org/git/xmqqwm8sltbc.fsf@gitster.g/T/#m0e3ad91ded146=
f9c13f4ee52e4c37b15330c62a9
