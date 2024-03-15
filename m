Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A4F47A67
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527207; cv=none; b=rpDJl3zYK3sHqm7M0xCD7UoKThDsgHZbxjJtXIArO7z42tiMdRs+Nl0tX0XJ9dj7kqg/GpgUCPxuQc3ULQuUEp8jDjYE6WWvuFWa37ijeVAFb0PbgmKuGpIfV144QJG+dMMEDyNhTerwLy0pUskMnvo69EIwWTFAA6uSgeEV5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527207; c=relaxed/simple;
	bh=vJiNyk0v+Dvd6GvUimpCf0QphedJ6gJR7sq1EMWBpwc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=gTw9erqam0ga8bFQyNjImKBcH/oeTc3nHRIFPmZkT82AKAUAxFcVMaEAMfokZw5Xcygq1RoCKc2xbY8+kMTMwV9GTUme0XmHWuRT+KGq3cfpIZMmjuU+5vPKoL5LMAjGRFE9OCFK05K/il+7BYHUEglCHWZwdRWifqfcGsUCWHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ZaW7Rksy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BH5kRE3u; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ZaW7Rksy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BH5kRE3u"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 73A591140114;
	Fri, 15 Mar 2024 14:26:44 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 15 Mar 2024 14:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1710527204; x=1710613604; bh=r/dJtIT6PbFqA49JjWHZyc3QtoVyTpMt
	ukPcM0qNpuI=; b=ZaW7Rksyqgabko35HYFmc/CXjINmWNrEGG4ikazbnsac2hxS
	SmpFJQTgW3diKB9eDLwqxVDKkM6WvRVz41N5l4vNtLcTzWv/tM06E/hFoNTv8Ndy
	Dtu2VmQ0ZrNjTCbWSY1BaXC61Xslx7fRzilILThea+wISd1Jv7oZWdvTO42A8KL7
	0BYFbn6tKz95KB57r97+QBOvleTJRbevV9+P3lAFD+UJc+v1FyBWd7xAjGYvgJ4X
	uTt5UEqBd32Zjl6ONmWcYe3lRQdbAyOIUG7iXIBwc13yfnAhvQoItItrkDRGhO7P
	l2XTjKaiWqIrx/dqzXzPXNZQhXF0i8MUsfJd4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710527204; x=
	1710613604; bh=r/dJtIT6PbFqA49JjWHZyc3QtoVyTpMtukPcM0qNpuI=; b=B
	H5kRE3uQVvf+187fpStwaIiI6hqvY4wU8aWEO4GP0zKkcwQmTozs0pgrecJNnuGV
	iBaaJs7ZrxUEfA7G43ZysyZFaiJNP+KDH31tOd2nmzkKZnGl8OlEBnPNKtJusXr/
	oRj2OHw3RPpfp05b3Dwa9QM5spMT3npDwT1vHjqnzy0TgJN7PVnz5hJKNU1FPzmG
	SfAtOUIJlxnJBi5jNQBJjQ2T3rpgM1wtIbepNHyjNpVFUHyuLFrQDCCVImZNUpIG
	uH67DepcpcdKnIfyMLwtO6HYCGytQTygJyt1MccrT4ozNPvRKHUR5/xgDWPtbtf/
	qzjOfsWozqD/aZGRGcvsA==
X-ME-Sender: <xms:45L0ZUP4F-9kb5HwJK36OlDlnkOEo__ZWg8t5A21vGIqZIPU_x5L9_s>
    <xme:45L0Za8C-5X9AYO5nu0N9LZQBHG79Y1takVmBYP2mXSqL9B9tArT2tR6ZRxEyECAy
    zGC_UkwAuXqPyck1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:45L0ZbS2_ZLW0Zfc3PZDvw2strX1N0_Uu_FNWvHVnUpMpj_4JhY83Q>
    <xmx:45L0Zcvu_1LfMENx7tyAwtxoQECVBFDQWFsZrnlG8hb3d2k1U84wLQ>
    <xmx:45L0ZcfS6rAgetIUWuVaQjBHYx0pyaRB7qjtFXhfLv62SO7xJUtTtA>
    <xmx:45L0ZQ0lta_Y8j1xArb9EfsQGXwm4HyALFHHZAso0OBYSwlZLzxMpA>
    <xmx:5JL0ZU5Y6oMSPk21O_U0Xu4Z5fE8QcSAq8MYEQbBg8gdoATTqcd_jg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A7CB815A0094; Fri, 15 Mar 2024 14:26:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <75ff994e-f086-4490-a442-dcaa6e2230df@app.fastmail.com>
In-Reply-To: <xmqqjzm3qumx.fsf@gitster.g>
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
 <xmqqjzm3qumx.fsf@gitster.g>
Date: Fri, 15 Mar 2024 19:26:13 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Christian Couder" <chriscool@tuxfamily.org>,
 "Emily Shaffer" <nasamuffin@google.com>,
 "Josh Steadmon" <steadmon@google.com>, rsbecker <rsbecker@nexbridge.com>,
 "Christian Couder" <christian.couder@gmail.com>,
 "Linus Arver" <linusa@google.com>, "Josh Soref" <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/5] Unify trailer formatting functions
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024, at 18:20, Junio C Hamano wrote:
> Not about the series, but about the way it was sent.
>
> The messages in this series have exactly the same kind of breakages
> in the recipient names/addresses we recently saw:
>
>     https://lore.kernel.org/git/xmqqh6hkxox6.fsf@gitster.g/
>
> Human-readable names with a SP inside [square bracket] pair
> appended, and one of the addresses had that square bracket applied
> inside <angle bracket> pair and breaking MTAs (I manually fixed
> khaugsbakk's address before sending this response, so replying to
> this messages should be OK).
>
> What are you and Aryan's pull.1675.v3 did differently from other
> series sent via GGG to trigger this, I have to wonder?  Without
> knowing it, it would be hard to avoid seeing these broken addresses
> again.
>
> Thanks.

I=E2=80=99m the only common CC on these two. Maybe dropping me for the p=
ossible
next round would fix it. Would be interesting to see.

Cheers

--=20
Kristoffer Haugsbakk

