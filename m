Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BF1BC3C
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732711213; cv=none; b=DKQBfJvhrUCoyFLZRhInzioBmlgS8ljNyPYkIqiu6vFOYNBKv35PIXLezHhyE+avjDSTM0kkQ8TUXOIs8luG4ouLT9YVJxuAx/OAzMBtqMNutygC5PfkawCc+e+4XMdkeQyDhHDtEDrFj446u0TUoVkU4E1VrHAZAshYeE3D0JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732711213; c=relaxed/simple;
	bh=2wFS9/tagyb6TUK9yVVYuyuPIkle4arvEXXbeV2YLOE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BTORBxvm9idxgQ0LrqTGxjx7JxraT92FHPNhG7RSJgDXvHVNRblNe41RX/mUKcRHlvZNmeTgFAzk5QJ8uG2SicfIpvloOUWpY3NC8dYjqcLYaeZqQ0T12zlFw58vH6ia47yoUE1G8DbkNtteC73Fp0nbkMTwMvV94j+R0fWnfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ZRVOPzlz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3hyr8YXd; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ZRVOPzlz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3hyr8YXd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 43EFA114010F;
	Wed, 27 Nov 2024 07:40:10 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 27 Nov 2024 07:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1732711210; x=1732797610; bh=elh5fbourfrlzFoXLb+iuDfzE9jDMGDj
	IaG+NkwAkdQ=; b=ZRVOPzlzCIU/6POIS9KqlgFjlIEXV4cNfFf3x5Vw0PpIn0Fk
	WTiy4No1dbwO4noVW6t84O8/W5GfyctrbIlujMCPesWjIaa2sSO+Yi/eTTtoiIlQ
	I6GyFU4cFj0EPqgGIsYE5NUUi8lTz6WYWiAGYU5IFNC+JMlc7Pxs04q/0AIz8mXQ
	b8IQpj5rkcc93NBH5AsbYCWovYGNDLU25BldS71+LkvcJ0S/L6Vcj3Igfn2OM1Zj
	s7ZNJiAM7bo9SDTfQygLteNBDHwho/z75kFHBka6fAggZX0B9wRzckrEtIR3XAb3
	I9GPziOnnrwHgqi+ssaJDr8CUeJt0qWNGpnyBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732711210; x=
	1732797610; bh=elh5fbourfrlzFoXLb+iuDfzE9jDMGDjIaG+NkwAkdQ=; b=3
	hyr8YXdIMNI+aGzqgDXhCfqEi3ksAPhu/aYRmsTEpTkOGg4Ojv6EqbNEf/K/uuJA
	nA3l+Nlh80E28K9NzBdB4fM88tdn39MKS/0agVVuQ3+5stNblt960Zt/u1rS5uY5
	LMeIFypowOdM26sgNO1+r9TmOvrHH99dIjbP6vo3xci3x3i7dhQyZX2CXCYkxZFh
	Hef+GUxMl8oL96YNtB01fpkLh+W1vrljF+B1GGkUlTGX1oOqPBhYQ4FrB1ZIlOi5
	cQtF86A8BYxhxs5wtOc3upOgUpRrasGfFZ25RCOA977FJg4nsF5DNSQfYdQOodeQ
	y0h2fFYJsmR+V1/6G+uuA==
X-ME-Sender: <xms:KRNHZ_AG2SaKJ3ScLG_B3452kQFk8Vih7FMD8-Xlc9s0ygWqiHtz2qI>
    <xme:KRNHZ1iw2VOymymuJIR3tei4UhMH4ZwSoJgOUjGM7FoSB3nW-dangoxpKo3tWpbIx
    jEZ2k4zC3U0M4Q7mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeev
    leeguddvkeetheeiveffudejlefgudffffejleffffeludekjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggr
    khhkrdhnrghmvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KRNHZ6l9nyDNXVBXxVqSPt7bBsiwJ5uBItSyxUJCt44jISXm5g4RdA>
    <xmx:KRNHZxzDfdmQIPkXIV6_slEKeVLKEu_v0ZjCp8BmUXy3iwutiDi8og>
    <xmx:KRNHZ0T_6vk_w5jkXeMviSGaSg95HxcFSnDSAP4nVjE5MV0StV1dyg>
    <xmx:KRNHZ0Zk_FVBP6MqDCc0_bvLE-OI0nSUXfvWX92uqZigJlCbmZUmZg>
    <xmx:KhNHZ5KJUJd6SRizgGXsIndwhlQOdeXsuye7Van-PI0J10Fo472rWmpk>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C6231780068; Wed, 27 Nov 2024 07:40:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Nov 2024 13:39:49 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Phillip Wood" <phillip.wood123@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Derrick Stolee" <stolee@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
Message-Id: <fa5d351c-627f-43e2-b001-ac12ea92a54b@app.fastmail.com>
In-Reply-To: <da8e283d-e749-4faa-b18b-fed9c51b0fbb@gmail.com>
References: <cover.1732481200.git.code@khaugsbakk.name>
 <cover.1732565412.git.code@khaugsbakk.name> <xmqqy1163ijv.fsf@gitster.g>
 <da8e283d-e749-4faa-b18b-fed9c51b0fbb@gmail.com>
Subject: Re: [PATCH v4 0/3] sequencer: comment out properly in todo list
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024, at 12:24, Phillip Wood wrote:
> On 26/11/2024 01:11, Junio C Hamano wrote:
>> kristofferhaugsbakk@fastmail.com writes:
>>
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>
>>> Fix three places where the comment char/string is hardcoded (#) in t=
he
>>> todo list.
>>>
>>> =C2=A7 Changes in v4
>>>
>>> =E2=80=A2 Use `test_grep`
>>> =E2=80=A2 Fix commit message (`)
>>> =E2=80=A2 Don=E2=80=99t need to cat(1)
>>>    =E2=80=A2 Also use `-n4` in case `-4` is not widely supported
>>
>> All changes make sense.  Will queue.
>
> This version looks good to me too, thanks for working on it Kristoffer

Thanks for the reviews and for finishing the last test coverage in this
series (fixup -c/-C). I was not familiar with that code as a user so I
didn=E2=80=99t know what was expected.

Cheers

--=20
Kristoffer
