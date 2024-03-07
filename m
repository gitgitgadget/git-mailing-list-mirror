Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C413AA52
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846137; cv=none; b=MuFC6k4DPS/NbhNcuEaFoTKFO5BgVmhgMNHCuTlx5RgZu2sJyA+W2+vkqR3BHoZoOB1h7WLwSH5ekaF5XsiMS06NuFhvKY/+i3grgA9RuBqNn8TjYz3tLoeVJ4WardT9d1Voy1L0214K0JAY7zLiCT9buEM6NtqXecSoB9QvxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846137; c=relaxed/simple;
	bh=Ba+0faYpBzSEEVRozTCN1Qww7CfJ9DfngAuuVs4ZDps=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Qv878o2jPsWoUlugJbh27t3t8TxDL7ikaCVWvX7fKq/T5wq9zbC4UHsDTCFk2DNCEYKGUSizqdLTUNbCrEYe67V/Sc3VrqxuL18dUkiHCag48xIWHje13Zi+Iv6pdJKyG4Gg1RBEfPKjkV4CcsA0f7JC49a7Nj63lvNXXSl3Hac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=x15+6Puo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q+jtIRtW; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="x15+6Puo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+jtIRtW"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 600C55C0050;
	Thu,  7 Mar 2024 16:15:34 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 07 Mar 2024 16:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1709846134; x=
	1709932534; bh=fL4Oun+DHBmfhiEdLl1U1QOdF2h9vpxkWGHhApOkvE8=; b=x
	15+6PuouBHPlYjFEbf45btWuizpokPjn/cqVnqXKBgMa0oneUZJbOB1I2yRiSM3L
	rGbA8a4puO72WaR7gNrqDPG42qkMtarHVGtel06eO2sHDZkUJaKrITrfZI9PyySN
	ER6mWnRV0ESfAr5qgLUVZkweoYDCLQ+voX1Qiie7pzAlbB1WnfrFlubqmzsecVtG
	pG+L4Pahri1liQqID2nfrZs56nehDTiWGw0vqaqDuHFJyiBJ5RMxONex5z9sYAhz
	pCgjWJMEQaaOcXZgdZZTcuzf5YE8FPnvhUbrPKhXSbvXpX9wtNq/aHS9LJUJKjau
	3GtOJJDFchGMnFjBM5BBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709846134; x=1709932534; bh=fL4Oun+DHBmfhiEdLl1U1QOdF2h9
	vpxkWGHhApOkvE8=; b=Q+jtIRtW0PjDM0pTawfU6Gb5cHVj5ygptKbdJfuZZSj4
	ckroWuzDdMM3RqacCv1hC/8Z0ajDr7H9VuZJ23rqNo5YEOb3R6ejCiGdHE/22iCi
	s+yHFr+om0Poq7TtLf+LGawA3T36I/u1K70nkfT3cvT7szE9n3eXxUi8IJQtNWov
	DO7lpgr8c4l6BSR/ouccVfOPhmpwVErFT2FcEuRtT40Dn3nGdBkt4Dxh3zwNwxlT
	OWmSTmyUu7OfcgQIzqz32sCujryJqfIuez7LUylqCuIGbru6w9qr4o5zbNrOFujo
	gW9tXYt+MifEgYzUW4n24g3dMVT4sBUInvhOz4sRTA==
X-ME-Sender: <xms:dS7qZeNl5jS70TpgPeTqF4fryhzw2e526pHEn4ncawjrX6O37PVgwC4>
    <xme:dS7qZc9v3ZQYHrBkcOQwm19tXsaL4tTrpT9IysSyKtuF29EgIVR7c9CsIjN2ESRiu
    w4vcK7LHNNuqLdY0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:dS7qZVTt8OBuvwpwFsF8TKScLUEy5pranWFCidgn0FO1Ey16ZNCxTw>
    <xmx:dS7qZevwISJ6zpR_gXaOxXPApyDDG_VbyZcd7OOEcCRlN9kk0t3OCw>
    <xmx:dS7qZWd6ziXuzwJwvVgTm_L6VJp4ZoB_c6JUTWTePC8XZVA6PzkB5g>
    <xmx:di7qZTF-PTFy-DvzMjOHOnh4JysH4d2ui7kAgRD3S303JevfWIVqHQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 86F2D15A0094; Thu,  7 Mar 2024 16:15:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8de2b3a-9e12-49fe-a7d9-481317f10c4d@app.fastmail.com>
In-Reply-To: <xmqq7cidlqg5.fsf@gitster.g>
References: <20240307183743.219951-1-flosch@nutanix.com>
 <xmqq34t1n91w.fsf@gitster.g> <xmqq7cidlqg5.fsf@gitster.g>
Date: Thu, 07 Mar 2024 22:15:12 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Jonathan Davies" <jonathan.davies@nutanix.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Denton Liu" <liu.denton@gmail.com>, "Linus Arver" <linusa@google.com>,
 "Florian Schmidt" <flosch@nutanix.com>
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
Content-Type: text/plain

On Thu, Mar 7, 2024, at 21:47, Junio C Hamano wrote:
> Signed-off-by: Florian Schmidt <flosch@nutanix.com>
> Reviewed-by: Jonathan Davies <jonathan.davies@nutanix.com>
> [jc: tweaked the commit log message and the implementation a bit]

Just a question. Given the imperative mood principle/rule, why are these
bracket changelog lines always written in the past tense?

Cheers

-- 
Kristoffer Haugsbakk


