Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA21EB5D8
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839901; cv=none; b=qNxw97+Yv1SVikRJzriPpdRO/NpBALw2TVOmaGg48sF1BqOeaH5Fn9euqCXpkvAMnonMp4F5PHtCEizOA6Ymys080+CM8yMcm4auRUMnMT/x/8Ewr2agHOHBBfw78BDWkn8ZobVlGY3uqrePeQxTUj3+Po5AexslFPvYPEG5Ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839901; c=relaxed/simple;
	bh=Shhv2UCFptOIuBWu6WeHELydpmJpEDmKo9mhntISf5Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LdOkePLKqAeAZDoO8RS9+pqpwfV8DR8VUeKbLvGRLW1gLCWbnjZi6W2eNkaditsGWb0VIMKasobSuHnK/oq/3Fzfqc9VfbyesemIpGt//OWEKgWdx72s8Trf/HQ2WsoqZ+nJOaZ4KPQ4Sz+FKbZ8fnOh9ChYJPKwjUr0+saqwC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=J/eHgHtJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EfsKf/ke; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="J/eHgHtJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EfsKf/ke"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A4E81138040A;
	Wed, 21 May 2025 11:04:58 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Wed, 21 May 2025 11:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1747839898; x=1747926298; bh=6TU0TpGwfWBSi5pUMlNS0uDYghHE0Yr6
	dUS4P6z31m0=; b=J/eHgHtJ40tknR9lVg0QE8af5kSHI9By6XihTy63/NwFn3vo
	pZxvlumDauyQnKC8HCo/04UfwCDHTjlomrQlAgS2neiDvbM8OcW6gv4DFUmU7rUt
	F2PL0bZfvBMDJyteypfrCSkQtYpBYRxv7UEJi632GEBINkHllpBVTTAvVvi8ekjB
	3sWmTVocmN1dD9vxi8QlTCyBWEZleQhsS+KWsISJOpg68xdCcP/6tX0Uiw2fBsOW
	lzPtMeOmnFdzCq2YJNzGKDTPS581Fqq0IYhBStnI9MO9j64E/M3t+sjp83vWTwi8
	SuDnVZSMOBGBScpJ5t+mgQ5wylXTGA4cOcBcnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747839898; x=
	1747926298; bh=6TU0TpGwfWBSi5pUMlNS0uDYghHE0Yr6dUS4P6z31m0=; b=E
	fsKf/kewc0n1VY1KVQmmRboT7WckcARby8swg6px0FJzQtqvr3pVxb+pJ+3Y4XHB
	WtigSilJOAhT7ideAJume4i91Pn5e7++Q4GcxEGqWo7DjpXEaWneqZI06oIzdL3X
	8zZvXaQ37NGfHFx6Lejh0spDvpb+zif1oXNxBsni4F1fT21K4EE0RzhjlcGHWoxx
	ZtMStueFhwODNuKbjvJF5fOz5bu+mzWj0zk+cXOe8iIXNO4AxROGr/I51HJJ3Q+n
	RrrUTM3cI7IBVwfRk7c6sXj+L6jaTzkREodWJs1eWuLXYobPzhS/9wIma3y8/m68
	uFO8HKhbNo1Hef2ECzWOg==
X-ME-Sender: <xms:mustaIUxVqjIXFsC4b3x8MkPqz5Upuvcjdc0auDNvfwA8T7jQFlXsTQ>
    <xme:mustaMmvwmFie5IY4zGX26XpP8dQMCv55yFLMoH29m29m8kc0yksMKiFEpUJpVhZ5
    xx1iCJgsCWR44dQXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffeelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhep
    fdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgsh
    gsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeet
    heeiveffudejlefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghm
    vgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepugihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mustaMbGf9zxvYsOIQoj-1SO8sQl9IBZ3vrSME_oM2TmbT4sslU8Og>
    <xmx:mustaHXyaObeK0qyLrPicYsu_eoUqnuRHufdrR2QItFSUbv2Uy9r5Q>
    <xmx:mustaCkepJqbN58_I6nAtgp3HudjwFKY4uADR7FqSXhPJk_AiCHoXA>
    <xmx:mustaMdJrCefMg-ZzI-OTa-RFHSb8dL13_73NGJMAfhWrbp2yx6IJQ>
    <xmx:mustaA_fuGcy6WgEOHEmJ_2myckdo7CPE4X6c6bT5sgu9FDAmnCJ5Emw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5AE233020061; Wed, 21 May 2025 11:04:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Te5a6727d38adc038
Date: Wed, 21 May 2025 17:04:37 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>,
 "Teng Long" <dyroneteng@gmail.com>
Message-Id: <817a28ae-b7dc-44ce-9ae4-2527081745da@app.fastmail.com>
In-Reply-To: <xmqqjz6bhzkm.fsf@gitster.g>
References: <cover.1747763769.git.code@khaugsbakk.name>
 <630ef019786bdb0c7538cc9794a7ba53a0ac77d8.1747763769.git.code@khaugsbakk.name>
 <xmqqjz6bhzkm.fsf@gitster.g>
Subject: Re: [PATCH 1/6] doc: stripspace: mention where the default comes from
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025, at 21:06, Junio C Hamano wrote:
>> diff --git a/Documentation/git-stripspace.adoc b/Documentation/git-st=
ripspace.adoc
>> index a293327581a..1132a4cf9a9 100644
>> --- a/Documentation/git-stripspace.adoc
>> +++ b/Documentation/git-stripspace.adoc
>> @@ -37,7 +37,8 @@ OPTIONS
>>  -------
>>  -s::
>>  --strip-comments::
>> -	Skip and remove all lines starting with a comment character (defaul=
t '#').
>> +	Skip and remove all lines starting with a comment character (defaul=
t `#`).
>> +	See `core.commentChar` in linkgit:git-config[1].
>
> I've seen this kind of thing treat the configuration as the first
> level default, with the hardcoded value as a fallback, i.e. spelling
> it more like this:
>
>     ... a comment character.  Defaults to `core.commentChar`, which
>     in turn defaults to `#`.
>
> The way you phrased is syntactically easier to parse, but to some
> readers, the readon why they are encouraged to learn about the
> `core.commentChar` configuration may not be immediately obvious, so
> I dunno.
>
> Thanks.

I=E2=80=99m fine with that too.  I ended up with this version because I =
tried to
avoid complex sentences.  But it=E2=80=99s best to avoid a new paragraph.

Another alternative:

    a comment character (`core.commentChar`, default `#`)

And the linkgit to git-config(1) is probably not needed on this kind
of doc.

--=20
Kristoffer
