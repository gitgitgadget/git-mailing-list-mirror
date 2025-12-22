Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DDD2472A2
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766423522; cv=none; b=qQPTPK9B8jp2Jsq/6tMHuGn8wktL8RmMWD84tjbopNYnKvGx7Mz3yUbyQh8Rban7Gj5Z2PURmN9gCSzfO6WEb95XSuJqHM/3+LO/NF6wWHeIF5dvcqP3AbFfyHPkdx43kiy649frXkwOf4pTfoJFgaUoOYVqnVNcS/ouxNnFT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766423522; c=relaxed/simple;
	bh=HnBCN2WokQ1kPz2vTC/OTgddEaZORe1sLmxZ3z6IgK0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R/aDknOA0KjbaonPTz7PJqrP4ITUxW3IgQQ4VpJ+tuU9P8xbWjG5WgCvL+N0IOo7nl7+KUnyWpuu0E+q64TSz4GGnRgmjlwUB03F82g/qjkI4gs9LHWxI5AfE9MuXtnDeIEafYyaW/tW3PAWzQrPfz0DYEppo8tJ9qeAw17IB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FjXMxh50; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xbZxZsbf; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FjXMxh50";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xbZxZsbf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 75B357A00F4;
	Mon, 22 Dec 2025 12:11:59 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 22 Dec 2025 12:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766423519;
	 x=1766509919; bh=HnBCN2WokQ1kPz2vTC/OTgddEaZORe1sLmxZ3z6IgK0=; b=
	FjXMxh50tDIa7zfK94OmWPZTUVMxME1i2B5VdgElh8NOygoLmrimiVXVXlSrENXa
	NERNj5z1XolNlPY/DmrXZNg1pLYEveJ02Q9OwKPCiK60ci5LyAq2ra7uozbmiMUc
	1N8otJqwTUQUoRtrQMNkE+8x7Cmp4hlW/3Ke3uCCIyN5jwLCgwd4XJuu/XD8YqCP
	idB4Drp3LON6JRueORAHS+ZiKYdrew2Mf15+6lLQn3Bc9CngF5QwftzRmRIfVw6y
	1yV1om5Hecod8RS1NVMIWhPbxoWFZRJMrfwBWWUnp6DXu+gm3qVh72tYo8jGCQrc
	t3ck5Ll+Odd6KoCAEy8iRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766423519; x=
	1766509919; bh=HnBCN2WokQ1kPz2vTC/OTgddEaZORe1sLmxZ3z6IgK0=; b=x
	bZxZsbflxz3MdJxXx8GDbcG78c35FTxEUDc3oZ90dXveVC2KZaN9cVAdFVI9sDQK
	g5TK2KBLLzim8EpRBsipg92KlB3bkucOm2vtrJOsmN59CqbbWJHZgj2tlsblfRpu
	Jc9lXtpqUSHzAPdUZ8TaF7afL15JemN40+kNVfD63Yn9bDoQny1/issWoQZG8rE4
	Jn+o1xRtGOyt7TsFIQoMhS/qQ58WWXbogLfUoGLOvnQm9uC2yrJk3pCsIed7wgoO
	6KwD5KtNFZ/VStgVS8Iflm8+NOKmWRSizolLxhwGRG1IK+XMA9noyYV5gdLr/ZIH
	7/7dPa6zzXQ9faD0nI9JQ==
X-ME-Sender: <xms:3ntJaewCviXCICYQ94O4HaVwgKkXlSs6K3q06cy5PoDfWjLccWVL7qY>
    <xme:3ntJaVEapv2t9SQjH0maqcIVvkWig9C4UyidcXgo3LBBULweBVeyCmpPrzcFf6VFN
    kfUse0X0JFFjkx3mqV7GRgPQ46Zb7hmdZ-9BPhpqnVC_Fi1MQBfJKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehjeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepledpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhv
    ohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3ntJaUutvm10Qy3rlUmSHZ9TkCz84yziJhaY0Iexn8Kqd5LV-11FOQ>
    <xmx:3ntJaWbgkeKEsVSSgPue-IAvsMR05gsHNrPRzh0UiXoaxlKKh6vhLQ>
    <xmx:3ntJaUBfQFsTXDfDDt96PffZyqOtTOSjCuX6DYVdLPs5_dcLNNnW4Q>
    <xmx:3ntJaW_EnRBzMzYo-8jd7Y1RK3nsyfI1IFE0oO3g-HEUvDGV02EKrA>
    <xmx:33tJaaOPbayw-NXiUtPeGk7n3a3qQaNN9Xi3GonbCqBCTgE5AIj0thyo>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D659C1EA0066; Mon, 22 Dec 2025 12:11:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AT4NW61V90Wk
Date: Mon, 22 Dec 2025 18:11:38 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Sergey Organov" <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Martin von Zweigbergk" <martinvonz@gmail.com>,
 "Elijah Newren" <newren@gmail.com>, "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <247aa9d7-07f4-4163-bb20-0dad2852ce86@app.fastmail.com>
In-Reply-To: <20251203-b4-pks-history-builtin-v7-4-9e9f849bfd0e@pks.im>
References: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
 <20251203-b4-pks-history-builtin-v7-4-9e9f849bfd0e@pks.im>
Subject: Re: [PATCH v7 04/12] builtin: add new "history" command
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 3, 2025, at 11:48, Patrick Steinhardt wrote:
> When rewriting history via git-rebase(1) there are a few very common use
> cases:
>[snip]
> +CONFIGURATION
> +-------------
> +
> +include::includes/cmd-config-section-all.adoc[]

Now there are no config variables listed after
`include::config/sequencer.adoc[]` was removed.

> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
>[snip]
