Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EAF13C8FD
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354070; cv=none; b=bE7eVhXCLJBqR4DNmi6Ybi31FIzGlK1ZH4qdteLvdOS40HwbplKtfvWHX2+aDLDzjDY2R+1Y+ADUepqlBRceSvRqv3OwaTyY04ePLZX9h/ytuer0KFkXmiHu7sex/fAoh4kcb13a9TZT7K677JmVfcSI8ZsECTICjAjPzHAVMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354070; c=relaxed/simple;
	bh=87UlrDFUG8Nxhl+pyMj5BotaE89XczcxbCmw4zXoWR0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=XXv/dNNtYyKdSSMCaDa0Ap6xZW6u+TEsXRcMl2DQI75pwCD5Ey8m8KW3WhBsiYFNqMBLAe4FOWa9ji3m4U6KaPfebNbOYSz0ImQdr/mozPfhy0+HjY90vj2Ns8oZY0YRP5kWK2Bsb5dfb5h/nhMu7iG77/p5XgwqM952a6U+17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=mSmAWPpX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F89pHYwI; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="mSmAWPpX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F89pHYwI"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id A20EB138025E;
	Wed, 17 Apr 2024 07:41:06 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 17 Apr 2024 07:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1713354066; x=1713440466; bh=87UlrDFUG8Nxhl+pyMj5BotaE89Xczcx
	bCmw4zXoWR0=; b=mSmAWPpXpMiIXTpiuRiXlS6D0ZPv5cuJISSzT/AVdWo8ZdqY
	9Gr+vGdfI9Q9B3iZEKwuox0xv8zGj1+0oMBVLrxDz+XWNoDZ8iR/7DleIvoUv4T+
	ynjnF9RQDUUDXOGYqMX+RY4uQKg3LvBeTtEMdBNGAfCF6gk5D2gjkzWQp7WQA9WO
	qgXTvhGQf1mrD6iTSRjkbBllcbEKFNo87f6c1GQswe8ppTU4eiMJ8tZJ87Z2OR98
	UL2xMRJ7mI1vnWz5oAbv4N65RS/T4hNfVLxfO+0OGMgE/fKVj+jaXFZndAUXKquN
	M3DdvNXOM2ibaQJT4cqi5I8Z/Z4VIz9VwmZlYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713354066; x=
	1713440466; bh=87UlrDFUG8Nxhl+pyMj5BotaE89XczcxbCmw4zXoWR0=; b=F
	89pHYwIdpCku9UFF9BmmkFdBE49kL/u8P7n0IFRfBU2tBm5sgWtfd6JJjxmhsjff
	NwjDDmYInvxfH+8wkFMU6MQvMu2VNs7d1ZYi95ME0Tmf5w1xPzv1C0os7zLuy0aX
	vUq7shX3af9IgsZ4gunXg3LL2xAWf1Xg9GCyGNbdOfpkOQjx4135RgoKTZFw4QDy
	9Agf2acOa7HQTkEx/V9TY6pBm+SPNXCEpGnandbyUqaCp/zU2KFZO4Bp57WbTgRC
	MGp4fI+iUf+F3gv+vfLyectkyRBS32+de4aVBnrQf9FEbME6kiux1w6EX8q76Nav
	WscmdciOjYImszJzz4soA==
X-ME-Sender: <xms:UrUfZpGpp3M4pR8_RdcgrrUx-GfzksKd2N7poQ4BbK5Y-Pc1MXdpGR0>
    <xme:UrUfZuWUXTiTY0JBsr6m9ixzRxg9XaGbELSTjUPP9dCelWuc--BJfXCe0EGHbYpwx
    -S2HBAfeC2osBejSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:UrUfZrJ7GuT_S6dYJJuG-IrcmqeWWe6VOhJIlR4lvtVJFIOf8w0rTQ>
    <xmx:UrUfZvECZJNccBnCvGeDreZWVpJNLKmAZT66IbGIGY01vr0bOZpyEw>
    <xmx:UrUfZvWKqYzYMobx2lXgU_bNcnmyJ2Vo2_yakjqg6840sCeaUtQLaw>
    <xmx:UrUfZqPkykeQA5y4hIgRpwgVTXSPcbvI1J8NMNahxr6QAbLdGqOh4g>
    <xmx:UrUfZqQbYHM55HnPo59acVcKnei2yafIVosfkORbaRC3zSSiT7MZHlQL>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4321E15A0092; Wed, 17 Apr 2024 07:41:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eafb3b1a-59ad-4b51-b5fb-061b82e06c81@app.fastmail.com>
In-Reply-To: <e3caab896300a2da9fcde2e0b2efe3d2@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
 <1f31004bd8445e1e4717817638d5509a@manjaro.org>
 <d60e5ddd-643d-41f2-849d-6ab660df734c@app.fastmail.com>
 <e3caab896300a2da9fcde2e0b2efe3d2@manjaro.org>
Date: Wed, 17 Apr 2024 13:40:45 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: git@vger.kernel.org, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND" to patch
 subjects
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024, at 13:34, Dragan Simic wrote:
>> $ git log --oneline --fixed-strings --grep=3D'[RFC PATCH' | wc -l
>> 1181
>>
>> =E2=80=A0 1: According to http://lore.kernel.org/git/1
>
> I wonder what does it say for "RESEND" only?

```
$ git log --oneline --fixed-strings --grep=3D'[RESEND' | wc -l
27
$ git log --oneline --fixed-strings --grep=3D'RESEND' | wc -l
57
```
