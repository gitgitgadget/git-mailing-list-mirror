Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9612CDA5
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112810; cv=none; b=rRWYq0cK2ziws4dkHpX6nUK9rIzh7ZUtDd1vpDZz8Hf3eLD+/+OS+aLEf+/sH7JN52au6Zh8N8NXtTM5omwOJ9TZJIWyvFAUkCAfzyfhRYO9RTn1cp21Hta/UBCBOx+SQSNYEDm3qXZLa+39aT7V7QC6aTHrHyFwm6pLtIhOYX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112810; c=relaxed/simple;
	bh=TzElAG58Sr0XV0Nm3BNq56chJ7c7Ho4UIHfnZhjli74=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Y7pJwM9yfhr6EOez03JXgWxADsYimFkwohmqEjLJ6On21qS0sJd43fUnlJmB1IuEsyj9Id8bHb7Du6IdqL/elEr5msqmhySh86QwvZkr1s8pWaQF2VhchqDyUWatVq15x5irNJCIqT+xLd1Q6XUPSsgPepnRHIjIA3Allfi5k24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=SlWqvZj9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LDE7D0Gh; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="SlWqvZj9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDE7D0Gh"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 9BB105C0086;
	Fri, 16 Feb 2024 14:46:46 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 16 Feb 2024 14:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708112806; x=1708199206; bh=TzElAG58Sr0XV0Nm3BNq56chJ7c7Ho4U
	IHfnZhjli74=; b=SlWqvZj9IYSHJKiSFa/9wkxfpWpUpFYpF+8vHtqxVKTmu0ol
	pNoGlJEYdSBDibuY9wOJUMQiS8MhY/rZh1IvIzYJgVSzVTpvrUIvbv3a4/ypaD/+
	/AiVd7y99Hsh86xUJB8AHr3AydHw3iVGDYJeLm7W2Hz0LlnSLPXkr1puOAig/hHS
	LQTPKs7eO3criups7EiPZnI1OeABARAN7tlAMqWjUMGRpHnRUDN5llGvqE9Qsd7d
	E7NTjfr7eqQHEoLT5d6d6EXdB1n3Z5FFJyB0mwWKBZAUXEWGTJM3N/VTwrgWtA06
	E+9f2dEKstNp5aSUpoy0+C6p1KJ+BgKp94BBLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708112806; x=
	1708199206; bh=TzElAG58Sr0XV0Nm3BNq56chJ7c7Ho4UIHfnZhjli74=; b=L
	DE7D0GhWpOYwfRFX2fAVuqePcBkmiHCP7ZGL08849n4ufYTbdADpKg60jaiASZfu
	TU3jsPDMD6U/0uCgxiGOS+dHa6bzp5bTkKd6l/UDmfkklLg5Cfzu59psjeZG30Z2
	PUB+rVw2qFUcFaVqbexrHaZCSx0lrDazJAVMAxJqAnfT+Zz4LAjCC+XxUdP8D7wm
	LEZJNM9DaCSyt3wDHzXMOy4eH4ZxADR0kE3SH4mjmmPY8DXf8yjk3WUxC/g2TTmV
	ZBe3K5WRuA7TrhJxlzPMiXcOGPNBWRCG4mK2dZ9fqKHFH6bBJGc6s6GUxEH+H+L4
	uXKbaAoVG4aoB292Ce8SA==
X-ME-Sender: <xms:prvPZWe3cm2Lww8-KQJuyqjhb-B7cQDYqE9YybM0RDzRTSQeslO6cv0>
    <xme:prvPZQO9iFfiX24KtFN2eWLCBMhP-a4AyFBvnFsQ8vVDNWTLsqR9MNgBP9o7cJMhi
    jY74x7XqLcbUulIkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:prvPZXiELe-aPRRDZfrTLlUUs9WH5uQ6TBwk1cx6ZDBudbKaHbGLHg>
    <xmx:prvPZT-j6C5AbWNqHBjGUB8Xjj0c4zSCoD4IFbaNcEgWkt0zKSqn6w>
    <xmx:prvPZSvgD1jpKNuFTdajrS78wblNJ7RKghxMRemggjICg9rBbnMYog>
    <xmx:prvPZY24ye_BAz9sl3irmSWPQJQBXuupQMbyh7_xh0h425ftaCcnhw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5704815A0092; Fri, 16 Feb 2024 14:46:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6965c59e-8edd-4d91-81da-3600a61569a3@app.fastmail.com>
In-Reply-To: 
 <CAL=1hhwreG_W_Ch-B5DXioqjUsfkgjayNZbkCk7uOv3vc=TBSQ@mail.gmail.com>
References: 
 <CAL=1hhwreG_W_Ch-B5DXioqjUsfkgjayNZbkCk7uOv3vc=TBSQ@mail.gmail.com>
Date: Fri, 16 Feb 2024 20:46:11 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Gabor Urban" <urbangabo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Question about migrating a repository
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024, at 20:34, Gabor Urban wrote:
> Hi guys,
>
> I need a bit help.
>
> I have migrated my git repository from my old computer using a bundle.
> (The repo was local with no clones.) That computer will be dismantled
> and thrown away.
>
> I checked and verything is working fine till I get a git status
> report. The most relevant part is:
>
> On branch master
> Your branch is up to date with 'origin/master'.
>
> I would like to make THIS repository to be the "origin". (The other
> will be destroyed.) How could I do that?
>
> Thanks for any help in advance,

`origin/master` is a =E2=80=9Cremote-tracking branch=E2=80=9D. It points=
 to `master` on
the `origin` remote. Or to be precise: it points to a ref that you use
to track this branch from that remote. A remote is some other repository
that you have a link to, like a URL.

That ref (reference) was updated with a command like `git fetch`.

You can get the link to that remote with

```
git remote get-url origin
```

Your own local repository is never a remote like `origin`. You don=E2=80=
=99t
have to make your own repository into a remote.

Your repository is fine. There=E2=80=99s nothing that you need to do.

>
>
> --
> Urb=C3=A1n G=C3=A1bor
>
> Linux is like a wigwam: no Gates, no Windows and an Apache inside.

--=20
Kristoffer Haugsbakk
