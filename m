Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C960ED5
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855933; cv=none; b=tMNsRE4RRSK13EfaPftMaI88pYzRlYnd7ayrZKVSIzz1JX0yTKG8opl7ejp7dMxAAqsk3RhutR/4QyDdnTMvTffVceyc6xl2wmjKOsTGQrvqgoKMVWsuj7BKOScsRFfp4VsDG0rAnfIG8oqyyJz7sdMJyuokbGIlXZWVDB+TlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855933; c=relaxed/simple;
	bh=KBWSJLn19F5PsGvk1Xbf0UgbiKkXXUxbbmMmigLK6uY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Cgv8I6i8YQdezR3KnjPJgfJdlCbztviSz12yIsXGUL4yP5SWERWOfVItjvL/H8If7snJBl9aGo0uk3iTVRTa8SNbzVmQGpqHnQU4v2cs1WrSR/yQQtJYAssP9oXzmL3EcmcAaXJIlxsyToEGTXmoh+ROa6lfiQp2XhI3uCV0wvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=iJTkMjYv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sVs1aF5Y; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="iJTkMjYv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sVs1aF5Y"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 279471C000CC;
	Tue, 13 Feb 2024 15:25:29 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 13 Feb 2024 15:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707855928; x=1707942328; bh=iQZEatSoM42p56Dxa2fnF5J96soEqOnr
	nxV8wACVCq8=; b=iJTkMjYvFyxU/dVLKOT5p+u1pNrjB6IzzS9O+g0QrHt7v5fz
	B9b1N+Gdr/25JnW/IpPf/YiwBNZiYiBG3TzbfQb/+WoL0ixpK99Ii8BbmSwAiio3
	l18DCAHsj0HYn38KV70D/Hm1CfIE506O3MRuSAt0As4+fTEyVitUHPLeiwvbeJ0k
	SI+7zdQTsnqxQVSot+2BrGZ1cbXNbbuoDqYqhod6bQIldH7ZDGTxtyUrs7nRvSMv
	uf2aYgX1xrI+U9+JBQW/ajUUfsaohUxU4T084C31E/wWY4zCKpshtVQLl0wlFfNU
	KSk2SEa5cNktLt3vdvQjEDF+R2P6yEWPK7l+hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707855928; x=
	1707942328; bh=iQZEatSoM42p56Dxa2fnF5J96soEqOnrnxV8wACVCq8=; b=s
	Vs1aF5YvKCw5tmG0LfCl9UWeeTcMzR4OiOYXXKIBMz4W47ViZ+kgM+1+cVvMS+2U
	dInKq0tEf+sAmDiWWd6tgz0zZk+IoPHvwhfkv+3liPgPGVvqCjb7O0bIKRjWtQvm
	2TzObD3u3gTLVSFte6N2p7ExYY3sJbkbW3fhfbayqwQq9f9FJZ2sIkEU52D3mTCt
	HaQeQPlfL96aOnVGkl3JaUPLgmK4BkiGi4Ywu2nqwtcflq+XroR1oJENsXdGfbTO
	YHYldxVBwb/1mDIxrA5H90v6ys7K9JIFoeh0yqz/MGx6KitYP2Qj4xKG4cTqqPt3
	t8nu8caYvUlvH058N8XFA==
X-ME-Sender: <xms:ONDLZUghw2k01uwTrPdwEojJOpEDnfjyWYoBsfYEOAmngptVdYObos4>
    <xme:ONDLZdD3Ub5TpX9qrXwtX5JeDkt4VUE9jZ0BSusR8bU_sDnLoaphhyLPmnvc8x3wF
    xxE28koVnYlazAI0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:ONDLZcG7q3jmjsQjfbFgZa4AbzwIjiKil4V64MHfzeK-FaxbHfdjmQ>
    <xmx:ONDLZVTDnWS0gGTwf979txbv4Noxq7_i19VuiwiHY7BdB7h-_0yyQA>
    <xmx:ONDLZRxnXbq73gdJiT4WFLtLzjH7pmu1vRt-UB0bMRDAQInp6jKM_Q>
    <xmx:ONDLZYkWNabkbfRrHYIqSLb9DnBj1L1gGIC5EPWEP9cEHT0NdUJwXkULzn8>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4960A15A0092; Tue, 13 Feb 2024 15:25:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <23805a85-4b11-45fd-a41a-67ecb5a1e407@app.fastmail.com>
In-Reply-To: <xmqq5xys5e98.fsf@gitster.g>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
 <CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
 <owlywmr89ms9.fsf@fine.c.googlers.com> <xmqq5xys5e98.fsf@gitster.g>
Date: Tue, 13 Feb 2024 21:25:08 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Christian Couder" <christian.couder@gmail.com>,
 "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Christian Couder" <chriscool@tuxfamily.org>,
 "Emily Shaffer" <nasamuffin@google.com>,
 "Josh Steadmon" <steadmon@google.com>, rsbecker <rsbecker@nexbridge.com>,
 "Linus Arver" <linusa@google.com>
Subject: Re: [PATCH v4 00/28] Enrich Trailer API
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024, at 20:57, Junio C Hamano wrote:
> Linus Arver <linusa@google.com> writes:
>
>> This sounds fine to me. IIRC this means for the 2nd, 3rd+ series I ha=
ve
>> to remember to say "this series builds on top of the other topic
>> branches '...'" in the cover letter. Now that I've written this out I
>> will hopefully not forget to do this...
>>
>> Or, I suppose I could just introduce the 1st sub-series, wait for that
>> to get queued to next, then (re)introduce the 2nd sub-series, etc, in
>> order. Hmm. I think this will be simpler.
>
> FWIW, which was how the recent flurry of topics related to the
> reftable backend were done by Patrick, which was quite nice.  People
> certainly need the feel of larger picture to get motivated to review
> an earlier part of the series, but now that they saw the projected
> end-game, splitting these into 4 series, each with materials in 7 or
> so patches in v4, and presenting in not-so-quick succession one by
> one, would make it less distracting and less daunting.

I feel like I=E2=80=99m learning some things about how version control p=
rograms
(and accompanying review software (here email)) can be vital=E2=80=94not=
 just
helpful, not just a nice-to-have=E2=80=94for structuring reviews of large
changes from observing these conversations. Thanks to both/all.

--=20
Kristoffer Haugsbakk

