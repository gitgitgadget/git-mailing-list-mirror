Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B95C9A
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707721570; cv=none; b=FKi9PS2c70o7etrsLiCSwXIUmEK7GhnkPh7KpuX9j4uU0DvA2AyOoQGtvl9dLBqm8XV5ujr/i0IjjLnmDj07ejpdWU4T4QQ47noPRnUBQuugam+H6MfyuO/RSIUw6PSjCx/cExLfl7UY3rq4sZ29UDwLFEUKjiv/1JasDtpaZgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707721570; c=relaxed/simple;
	bh=NK7mmiv7q0H80pG74oCVRHB/HLB8ElYn1a4qI7uFot8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=S7p2jBKNezKMiygpvqbt1JevwlBit5WdVvqgevWeZFC9l1TXLHfeZkiBxuLwnMVX/VN2cA8w8QRW7iAk2etEEP5oYJMddMid0r4QIASFOqptqvYBH+pBtOgceCb3sy9wT1mETQG/o8CWblOg6icGrG0MeTRyg4uTyr8Xv5uklL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=XBNUL+6S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eDdRV8zI; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="XBNUL+6S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eDdRV8zI"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id DB6EE5C0054;
	Mon, 12 Feb 2024 02:06:02 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Mon, 12 Feb 2024 02:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707721562; x=1707807962; bh=bhEWxg7vGGSv2/5yJ6KCI0vJZMIO/Ktd
	yLQ6vcjZRRE=; b=XBNUL+6SnC4L97+Z7VaBXB0rZ3i2Mk6cdClzMPOVr2eeHcxf
	QlhwQBKLxldujlcM4pdXZPWxUx4KXnNN8GS/OBdXxr+UIlT6Z8yZ+o1jhrMW56gr
	v5yohNqL0HMyCBsVpMnq1bXHovJ8tTXMaCONDaKIuB31aliuacH3TpiT6TjhbT35
	o7gKwyeCkU83GY8xCCNezGlEEeVlCNnVwZ+KM5Br0zrpSZSDmAV8kWKhaayJmRCM
	IJDZCLL++FhQwuw7H9s80X2NPL3BESpgKL9yEzDnR/+8fqZsDDja6jlZ7Ljf+DRW
	pCiodxlToPugEOON4ldZg/7BoMu2BUa2dsUhww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707721562; x=
	1707807962; bh=bhEWxg7vGGSv2/5yJ6KCI0vJZMIO/KtdyLQ6vcjZRRE=; b=e
	DdRV8zIbbrsoB2RQJsnjNpOEijeXsLWx2HVEqwUhuYD9UOR2AEIFFQB6GI3GFV1h
	KbHsDzw9+Ydawi6Jy/qgFGQNspis5OSC/Z/p/ct4AypNDRQESuWv226eJdYzx7HT
	0t/8p7YG3sjv1DSEs5xA8GjXGlseMY+QVcyfubljpPDv6mMFKEgGydRClkB9wmVB
	LOPQZjMh0pn7RJBbndglRaL9PTYstq6fqZODbH/jnfcdznwAnp7uvIwM3HUnU7DA
	bRTjbEypIBqUZhIa9k9T7qW9pGu29hjOWXF6X/DnLEH+8Ue6dFLuDh7iGzbVGhMx
	138wFD66LKit/leGU6v1A==
X-ME-Sender: <xms:WsPJZTMcYX7vwKc9mpVkDbtApPAvG9zrBPSJ5b3L61RnvpWeHLZEKyk>
    <xme:WsPJZd_vqI-GGw_vQki-foIYFtFNsRsCjr4HXGfldfjxpy7oZjmJ26KxtdAHxLr0v
    vXkwJZeG3VKva-5qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:WsPJZSTUZG1wEiIt1q7YqNLeI242jqEPvIPP0ajhKgJaHIzpoZ3qGQ>
    <xmx:WsPJZXsXmjgYFX6Q5-bWvflh7j7W9scRnyV-TJi2X6W9YGgsvsDLiQ>
    <xmx:WsPJZbdFXBZh8QEehPcYE3g6CwYGb9g7rEudTb_YlNFCols9Rze9FA>
    <xmx:WsPJZX6lZ_k5qxVVUDSVKulS7fRLu-Ne-nOywPCDLwTanBHtIglfbQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9AA4715A0092; Mon, 12 Feb 2024 02:06:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9582509b-9569-4321-a2b0-e5b33c2d550c@app.fastmail.com>
In-Reply-To: <89d32a5f-b5ab-4773-bd9f-d33b4e348e15@gmail.com>
References: 
 <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
 <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
 <89d32a5f-b5ab-4773-bd9f-d33b4e348e15@gmail.com>
Date: Mon, 12 Feb 2024 08:05:40 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: "Tiago Pascoal" <tiago@pascoal.net>,
 "Chris Torek" <chris.torek@gmail.com>, "Junio C Hamano" <gitster@pobox.com>,
 git@vger.kernel.org
Subject: Re: [PATCH v2] column: disallow negative padding
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey, thanks for the review

On Sun, Feb 11, 2024, at 23:47, Rub=C3=A9n Justo wrote:
>>  	if (argc)
>>  		usage_with_options(builtin_column_usage, options);
>>  	if (real_command || command) {
>> diff --git a/column.c b/column.c
>> index ff2f0abf399..c723428bc70 100644
>> --- a/column.c
>> +++ b/column.c
>> @@ -189,7 +189,7 @@ void print_columns(const struct string_list *list=
, unsigned int colopts,
>>  	memset(&nopts, 0, sizeof(nopts));
>>  	nopts.indent =3D opts && opts->indent ? opts->indent : "";
>>  	nopts.nl =3D opts && opts->nl ? opts->nl : "\n";
>> -	nopts.padding =3D opts ? opts->padding : 1;
>> +	nopts.padding =3D (opts && 0 <=3D opts->padding) ? opts->padding : =
1;
>
> This changes what Junio proposed.  Is this on purpose?

Yes https://lore.kernel.org/git/3380df68-83fb-417b-a490-71614edc342f@app=
.fastmail.com/T/#m63ca728414def19b7a0c83ec76a8c1f2de68ffbb

--=20
Kristoffer Haugsbakk

