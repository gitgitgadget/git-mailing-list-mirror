Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777E18623
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="g50CbUZ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dbfcYjwJ"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B7719A8
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 00:33:47 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id D42EB3200A8E;
	Wed, 25 Oct 2023 03:33:44 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 25 Oct 2023 03:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1698219224; x=
	1698305624; bh=CD5aYtjRO2vJ+NJo0ZaG+uiDxB+xwg9b0ztaAa8bZmU=; b=g
	50CbUZ7ScYnbn5baJG2gqMBdYwP5mR7lVRriciELmj+eQGQ79ZULL88xH8MkE36I
	KhglhUTrV1CfaiJjqcDW8ySUuz7Fnb3bPsl8FyYWVCjBDm8uYpxzqx8PIh7P9yOB
	Sb/jUW70MpnFnARmG3yUFXH9CAVP6MXP1OrMYIr22izyITc9yuk3qyI/LwdYSE0/
	pMvWAwJN9w/EipabkEC3lZOk7r0Le5Zp2KG+Sy35ua93CFVmzb1XeauyvBBJGkbl
	rOukESeEGZcHHkiWzauNcITNLYdPbRQE1iyFT8WU6KtE1RVf5ez86dBXQ2ZUg+N2
	lnt52IeQRMkncH7NX1Qhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698219224; x=1698305624; bh=CD5aYtjRO2vJ+
	NJo0ZaG+uiDxB+xwg9b0ztaAa8bZmU=; b=dbfcYjwJtTvA42dotyo56y5Wkt+oA
	OXOkyEUG//cvk3U7wVLyKP87jCkV8y2EBb5R8owtYr4dkAajok1o1YtLv0q8lBbF
	UidEy00n89EYi9r6dOpdPBTLuZgFk3pU27Td9/PLSzmCimxHYwT26E1AUPWZTICk
	oWA2eGRaII/iAPkiqabvjJUyKqJUH1EiLCELkmMAJigpCEiCrhiaY6JpfLFBM4uG
	O1ud1T2YoDDKvV+7cSAWZCCoLPRa/tO/hBDL8FcVZ+z1SqwrzKqkS0h0ulPYj3ub
	XXDxKYMBXlJDQqr0gttawkh+0+hYeiAlE8z88upZgDnPid/VOMJ1JSiTw==
X-ME-Sender: <xms:2MQ4ZXUGBSYK61C-BP47TE_9xbhwOdgfxWS2Uu1s85WvE_wwWWsuk5Y>
    <xme:2MQ4Zfn5wmXPUgJFB2c9Th7-3SfsTnq8sNSv5Pidj-uDaMMsWLUHf6Ge1DPq59neK
    YcegOFi13vCEUx8Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeelgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:2MQ4ZTZ9htdsAz5wqgguqAi2S0TXsBdqJOUPmbv93eRYtZkSCnvZpA>
    <xmx:2MQ4ZSVAbR8AudBxA6iTz8zv7-kWh5LpaFGZL1blX4-FVcXfOW9BEw>
    <xmx:2MQ4ZRlShf3ryA3oRmphKX0MPovyTj-hykt4vSC11Nx-vL6aNJH4gQ>
    <xmx:2MQ4ZRtLnENXde_EDogd5t9sw1NsqQbomVjwMQjIZnos1SInocHzoA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 150CB15A0091; Wed, 25 Oct 2023 03:33:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2b764f52-d3ae-467f-a915-fb73beb247bb@app.fastmail.com>
In-Reply-To: <ZTip7JWm-WRWTImU@tanuki>
References: <cover.1697660181.git.code@khaugsbakk.name>
 <147c767443c35b3b4a5516bf40557f41bb201078.1697660181.git.code@khaugsbakk.name>
 <ZTZDqToqcsDiS5AP@tanuki> <ZTav2u1JWmLexEHL@nand.local>
 <87badbe0-de18-4f8a-9589-314cea46065e@app.fastmail.com>
 <ZTip7JWm-WRWTImU@tanuki>
Date: Wed, 25 Oct 2023 09:33:23 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Patrick Steinhardt" <ps@pks.im>, "Taylor Blau" <me@ttaylorr.com>
Cc: git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v1 3/4] config: factor out global config file retrievalync-mailbox>
Content-Type: text/plain

On Wed, Oct 25, 2023, at 07:38, Patrick Steinhardt wrote:
>> What do you guys think the signature of `git_global_config` should be?
>
> Either of the following:
>
>     - `int git_global_config(char **out_pat)`
>     - `char **git_global_config(void)`
>
> In the first case you'd signal error via a non-zero return value,
> whereas in the second case you would signal it via a `NULL` return
> value.
>
> To decide which one to go with I'd recommend to check whether there is
> any similar precedent in "config.h" and what style that precedent uses.

Okay thanks. So no parameter for determining whether one is writing or
just reading the file.

Cheers

-- 
Kristoffer Haugsbakk
