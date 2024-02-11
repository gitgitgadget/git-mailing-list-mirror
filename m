Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE45CDC2
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707675545; cv=none; b=CjbFIgIeE0JCJ9hXQLWMLfl4YT5tfi7on4ZrYZeZGdSV6oFP4cmSC7N3cQt5rI148LFZbt1MHiieu1YPwaW2fiNiJ1iEVompqwgam/AH+VQUIyEYK56LLgpD3DOKYGVtSM1xwgITpgDjFEVjNSLHfdOBXOuqhp9jiEKyS1fNqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707675545; c=relaxed/simple;
	bh=ApYNczzP8WsBa4XH1CocyiUk4ikWCrzR4GVWr6XelG8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=U0PdU1VEhjccus3KzdKMJoaywU/ZrT7VK1nkv7QjROkpu4GsNujQbgBvDXsMWy4/Bz6bqpNtBCTfaXkhOcsK06zrPrwCEqbo2+lTEnS3MkmNTFd9ut+JNq5cXYdq+2m3as9ii9mHitxli5w3IcWGF8juJVhdkRhbSDiNIpb+2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ShJsYZBy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s87kS9w4; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ShJsYZBy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s87kS9w4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id E7244138008B;
	Sun, 11 Feb 2024 13:19:01 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sun, 11 Feb 2024 13:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707675541; x=1707761941; bh=8Zydl+xBU5px36zqTLvTAIB+COCkSVFl
	IbfLpfwVm+4=; b=ShJsYZByU4KmNVq2MdoFDCMZ6Mt7bn/oRnknBlsFQ1OYAb3r
	aKY2bhLelYrCJi+9cAb4ofzFzHYwDWRCf/6Jq4UHOnz7V2ccQEp6G602Rtw9hXTZ
	om72pxgmLNzWB5/O+6RI/pQp9orurJTvYmmLp5T5n3JG32KZKYXNr3N/+T6mR0DE
	eC0lbgmtll19Uk0OI3RJa8ysDpf109ww5++O1tGIzguYbS1NEI9IZ7ZFTheLk5+V
	JqAdBCQV1hiKBElo77gcizrP1m840ZLcyVxrbqfVXh2mOjxCdojtdA9v2je0fUh3
	ZyZFFtfBr9fZ/TinNwiacNtVWq22fYbJv8Jj4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707675541; x=
	1707761941; bh=8Zydl+xBU5px36zqTLvTAIB+COCkSVFlIbfLpfwVm+4=; b=s
	87kS9w41SkQv2ewrtchtAf62wD6awahdlmf3Va+9VlFbur6k1pZCk97sWb57lFqX
	x7zXwOc3MW+Z/oZTYAogZ8bgqG/mbLfOUDheduaXGT0nGaNgEhi+PfzNIlPdCSwt
	AwlL6hD/6+Kl6Tzj2f0YgmxdqGULK+2idZA8WhOSoOxP0E7VQqkbayb5pRuYnHpY
	AakSdL9zh1NRtMr4Me6osYuzazY07NrhgeVevtpd6crZwjcB2M+rxTj1EcRCNtsn
	mJ43mcmYrCVAHS4nkeIaaymJNL45N5m8dr4nvdU+65A53Klgjxo4F+U8E5iMmg1I
	PjMPqYGlwtm2mFoD+HCcw==
X-ME-Sender: <xms:lQ_JZWh4m2YCXSu9mQ9SCwOSds2_uVUBKk6GJL0hBSWFmgtwjv8A7-Y>
    <xme:lQ_JZXDQNda-H7pSy66tK2CFOsiEnzOH1iXT8a16NKEv3RuQfh0BEVBjM-hLYQdjh
    092kiHRBxNNNJ0PYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:lQ_JZeG3zsyJfvYZOkWaD2131icfL2zgE2hK7HO9NLpH1F6kXjxpTw>
    <xmx:lQ_JZfTch9Nx4uUFstLmUT6bdUtWW6QFlfkpBA412QV0LqefiTmdAQ>
    <xmx:lQ_JZTwQkKbAZL2-d8Tex0hSBM0ovMv7i_q2sIrFIssVbVoyNnsJbA>
    <xmx:lQ_JZT9xjMj9cdAt7UD-XspOa8_klUqU_YNMAjPC5iRZfMOgokn5kQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A949A15A0092; Sun, 11 Feb 2024 13:19:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <34c18fd0-1fa3-4226-b5a1-b019fcb05548@app.fastmail.com>
In-Reply-To: <xmqqle7q997e.fsf@gitster.g>
References: 
 <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
 <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
 <19119aa6-9a8c-44c6-af79-0ea6a8bcb181@app.fastmail.com>
 <CAPx1GvdDvmBmvoktd7onB4mSzikKf4eWVWnrzrn8c8Y1RcRgsA@mail.gmail.com>
 <9c00311d-e31c-428b-9c66-fef7ac8bfc76@app.fastmail.com>
 <xmqqle7q997e.fsf@gitster.g>
Date: Sun, 11 Feb 2024 19:18:41 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Chris Torek" <chris.torek@gmail.com>, git@vger.kernel.org,
 "Tiago Pascoal" <tiago@pascoal.net>
Subject: Re: [PATCH] column: disallow negative padding
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024, at 18:55, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>> Yeah, thanks. You probably saved me a v3. :)
>>
>> Although I failed to notice that the string I stole was just a plain
>> string, not a translation string. And apparently there are no generic
>> =E2=80=9Cnon-negative=E2=80=9D translation strings. So I=E2=80=99ll j=
ust make a new one.
>
> The last time I took a look, I thought there were more than just the
> single entry point you patched that can feed negative padding into
> the machinery?  Don't you need to cover them as well?
>
> Thanks.

I=E2=80=99ve incorporated the `column.c` patch you posted in my
not-yet-published v2. Hopefully that was it.(? :) ) I=E2=80=99ll take an=
other
look.

v2 is finished now so maybe I=E2=80=99ll send it out soon.

--=20
Kristoffer Haugsbakk
