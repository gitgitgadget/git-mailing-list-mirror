Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366E2745E
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626782; cv=none; b=dr5gNH3NwIOROS1RAAgPJ/jMv9K6M1//xQhENQec6LtjnxkTBDp4Gm65SbAeNw3PvRrEYi+a3AoyGaP89OshmskavWYNTQu6G1V5ndrOZFXcumqmgkC5pEw+p6gAWGd9d5Zy6DgJ33hM9WlaPkK+IzpSDrbnLsC+Xp5pjCzV3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626782; c=relaxed/simple;
	bh=Ae4fR5INqgDnVva1FDtokf0IZFY+/EMCSKBnXc4Om/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XwGJqOnxx45z1kMD0+REBWl4bHVbXgJ6wiR+mHl9ZV/fyEmxSOYsuaKaBWnpQODQNyy9xZH/pBFanookvMQX9S+jxW9t8XDTrSaguY6JTdaRAEwWprPQ9k3GBGuaFgbEj2baPB3EzgEya3NpqCuGEEjRxcJ654m6eTR2jG1xoq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MKBet+33; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4TEd0nDm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MKBet+33";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4TEd0nDm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 05AB57A01C4;
	Fri, 27 Mar 2026 11:52:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 27 Mar 2026 11:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774626778; x=1774713178; bh=Ae4fR5INqg
	DnVva1FDtokf0IZFY+/EMCSKBnXc4Om/4=; b=MKBet+33tCU4++gBcIT6kFiTHS
	Uw+P46rpYZ2SH5gxCKL6AAVwHpuFrmbPrOXj+krTz3lycazeJv6kpptKCUZWhL9m
	UcSSVL1FrSkXREqeRGn2GC4cqMkxfcDkj03ogbSEd8eSe+AqM91W6y/05WqkmCpT
	ShYEHyNWRaTnD+QairMmFfjyUxDKmOrvw+I18NPco2C/CMDUFjDVntOdUGt+gxNJ
	Tp3iEqlimG+ARvl110Yd9sKtu7wktM+qCUR6Ghb6T4WqJDW8ODHesTM8eX8X7rE2
	IhU6p23vq698E0OrlRMq8JdxWsgOknR8B2/WWXZ1WW7d66dIr6iAvXtnbJ2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774626778; x=1774713178; bh=Ae4fR5INqgDnVva1FDtokf0IZFY+/EMCSKB
	nXc4Om/4=; b=4TEd0nDmmU2Ht3WZF7s8IbxPmWjgyF9tt6ha5DCC3hWf9PJs5kk
	SN5ZZHi65ta4fMR2ZYFaj2G4BCgcpmA5y8Tquwce/2VSkioFznIaLqDoFgFxOP6a
	fEGwVORRgFx+U6YyQuQ2vYA68ycUOspH+Q9nEojqvijgUMymxReVDx6L3NeDE/+A
	/jDUQdY90XuVI1+gD9nNcAOvQBonAKHfb3jZQWtyaE+dWhTRWC430tNqpV4k2X/b
	jbntHiIGVN0mi2uJmbuppcweo1pmr5AgD4NJpgkQxQeDD/PlmBNR9zKOOE18uQnv
	SIUcpJmgTLxFBAv3rczO2OKQTiJSSqRQELg==
X-ME-Sender: <xms:2qfGaXzGAj9I5vQgDnZRXfrl3y152muuwcGX_luKmY81mqFu02EgNg>
    <xme:2qfGaRjvn9O7lVbjVacDLIFYSl_fe4RgvcP20Jw7LzUtfEdaPgfHmEg5qpVkUhBfJ
    4St1qoxpZfZybtvuxPHPk_ctqPSJCRDDhUkzvb6UDJaNbbW-x5jQFc>
X-ME-Received: <xmr:2qfGaTk5TPH1_9arUOqpVOh_dmqBCwmLv_mtkDH1-U5AUC16DCPzAfNl4ilahfsfN0ekGpnxQmCsQWWYqrnbRyGexaGIwNr15g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2qfGaXgBGfandxfXHqNcv1aUVx8TGoSo8ehp15HS0oCh7BnQNvPyqw>
    <xmx:2qfGaX1ETPLjOKVs6c49wwwBQZXf0xxQywub6ZWg0ba-mdwXJG7mdg>
    <xmx:2qfGaQLXioso3Ww9gOmassk9RjsqUiCdM7uIsA2x_rJpD17M1d-InQ>
    <xmx:2qfGaXyz-4yJSxOQwpRFdkuWAwqjfO5LsPjm9zX4JXorGmnhU6vJQQ>
    <xmx:2qfGaejJqIgQzG4vG9SiGg0OswMEb5Tf-7v_-ba4lt39Gs1ExnHkxrQH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 11:52:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Elijah Newren <newren@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 2/5] pack-objects: refactor
 `read_packs_list_from_stdin()` to use `strmap`
In-Reply-To: <acWz48NfB+dlbHAz@nand.local> (Taylor Blau's message of "Thu, 26
	Mar 2026 18:32:03 -0400")
References: <cover.1773959041.git.me@ttaylorr.com>
	<cover.1774482700.git.me@ttaylorr.com>
	<d5cb793f0eb0028f1f521fec4723ad2b00592638.1774482701.git.me@ttaylorr.com>
	<9e320604-7367-4f48-a943-f7d22feb2672@gmail.com>
	<acWoqXUwVUB2/65T@nand.local> <xmqq8qbensw5.fsf@gitster.g>
	<acWz48NfB+dlbHAz@nand.local>
Date: Fri, 27 Mar 2026 08:52:56 -0700
Message-ID: <xmqqzf3tmfqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

>> If these STDIN_PACK_* constants would ever appear _only_ within the
>> context of talking about the .kind member of the stdin_pack_info
>> struct and cannot possibly appear anywhere else, then there is no
>> point naming the enum.
>
> Yup, I agree. I'm inclined to leave the enum anonymous for now, since
> the only place we would need a name for it is the suggestion Stolee made
> above, which I think does not correctly handle an edge case where packs
> are specified multiple times.
>
> As it is currently, the enum is only used in the context of the .kind
> member of the stdin_pack_info struct, and we don't ever declare a
> int/unsigned variable to hold the kind outside of that context (which
> would be gross ;-)).

"As it is currently" is vastly different from "cannot possibly
appear", though ;-)
