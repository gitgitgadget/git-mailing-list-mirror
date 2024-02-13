Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF8D8480
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856376; cv=none; b=iJeCCdRHzccXUkuRH7F+K84bULc3A4YgXSSQdEFhTrCtgxWHXS51bcw+YrnF2RCezJid+FR+hA326EMXnoSZT5HCd/y0ElKgfSxGmMKNfbT48oNTF533axpJyvZPbklNy13eoEkjX4cbhhsZFECHWZS+1FtzjmZtlfLDxCGWTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856376; c=relaxed/simple;
	bh=L86TMMhc3LB7ssptCDhPswfTwVzX2rYw1P+Lt4DroPI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=JlhjddCqqTZ6Uy8lSBayJJ3jN9EvmLijNhbCxHJgZ57jv65c8mM5IP8FT2Jn4EFB9EgE0m1nt2rgoSNhecKzcrXxQbX9e0yRxnXbkluVSuZozu0dNVVtOIzDdPmHudefQavHcPQGZtD2epUBAxghvrLpxM6MzwKzMMx+kf1YeDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=JM1Y3qm+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NwPBuzXN; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="JM1Y3qm+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NwPBuzXN"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 39CD41C000B5;
	Tue, 13 Feb 2024 15:32:53 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 13 Feb 2024 15:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707856372; x=1707942772; bh=QAGinqWAHkL2Pg/4yue2zyFPMn5eVY6h
	VZ6g1+zXnIU=; b=JM1Y3qm+EdIvfwxXifH1S21cLRvN5q++3FAGwN/kVvzU46MF
	+SnbZXy8+fde6dkk6Tqsfy4xtj6JrI/WlsP4PKeMm6NHm87qb6BPhkm4H3Y6ZPcp
	j8PU9K3kFPCN/7UlwiVmURW7ITxOgtcAfI3IWdS7j9OmeHWTc3Zq+4b5jJVc/5z9
	qOBOsb9s6C609kGwiahts+pQN7cj7w+8wxqiASyKcEbAq4Fxv3YgNpIPNM+6tmFA
	fRRBbJphLaIVj2c6tW3ag9dP37/+zQk2yeVkcb+MjmqD7/0zeXCosRHYNsRGwZnl
	+FVXv+tz4RBS71jF0dF/fclw1sTgL/N//+u7JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707856372; x=
	1707942772; bh=QAGinqWAHkL2Pg/4yue2zyFPMn5eVY6hVZ6g1+zXnIU=; b=N
	wPBuzXNtYPFmgzlmmwsARxI65vC9EbhoC2b2eUVyB/HXDeaDpqZGFj2Y5KAhB8J+
	IVutm6qgwgAISYRRVdex7HMzj4oSxrLCuQdhE5sppkqr0+zru+351ifEQEbLxjLW
	fmBc0ntdoXza5ZzBiVRoAoDcSs61m1CJFGoMVR+p4Y4NbIN73A/dAPPjwZ+N/8DB
	Nkevfm2AUZEhyBmqjbtLoKVvcYzalfG9xd/8nQYO9SfwaXutE7rbBMAec6DNO6d2
	+nyWbmtWb/+oWiGvCJyN/DoVnpI61lutlS9QhSxrBoE7QL9wJCKmNip6gqxOb/XT
	9IbvKxJIA07MO3CMxt+vg==
X-ME-Sender: <xms:9NHLZVN0z9RWf9Twe30nUNtO798qKAs7aEPa1YSSDMij01Ord7OSvhA>
    <xme:9NHLZX81UX1VpuKljfDuue-BqAoe-guprGrx0in0Th5A9dNMd_AGDi7xW7JDMnCqu
    x_LPQ2k1ufKRwanSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:9NHLZUQ5GLxIohn25ThC6y9nNtrkiXTCqXYP9pPX9r4xyfTfa6cyag>
    <xmx:9NHLZRvmVuGJkt8AWCUgfrB7ZF719IDezt9RvJV_HzosrUDMaXryDQ>
    <xmx:9NHLZdf_48s8N7n1JkQwaRUIrHHDvuk2MHdDOaSgFSEydZXx8VFWsQ>
    <xmx:9NHLZU6lDO7W_go9kvnY2ExkF5UHFcX2I6bIkxVB0mPq_bFA-yEHSousCMY>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6804615A0092; Tue, 13 Feb 2024 15:32:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc1be818-e793-44f6-98dd-b159e043da28@app.fastmail.com>
In-Reply-To: <48b96426-9231-4e80-b55d-628dd8847337@gmail.com>
References: 
 <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
 <cover.1707839454.git.code@khaugsbakk.name>
 <48b96426-9231-4e80-b55d-628dd8847337@gmail.com>
Date: Tue, 13 Feb 2024 21:32:32 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: "Tiago Pascoal" <tiago@pascoal.net>,
 "Chris Torek" <chris.torek@gmail.com>, "Junio C Hamano" <gitster@pobox.com>,
 git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] column: disallow negative padding
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024, at 20:27, Rub=C3=A9n Justo wrote:
>     * P.D. *
>
>     Thinking about this in a more general way, I've found that this ki=
nd
>     of error has hit us several times:
>
>       - 953aa54e1a (pack-objects: clamp negative window size to 0, 202=
1-05-01)
>       - 6d52b6a5df (pack-objects: clamp negative depth to 0, 2021-05-0=
1)
>
>     Maybe the source of this error is how easy is to forget that
>     OPT_INTEGER can accept negative values (after all, that's what an
>     integer is).
>
>     There are not many users of OPT_INTEGER, and a quick check gives me
>     the impression (maybe wrong...) that many of them do not expect
>     negative values.
>
>     Maybe we should consider having an OPT_INTEGER that fails if the
>     value supplied is negative.  Ideally, some kind of opt-in machinery
>     could be desirable, I think, for example to include/exclude:
>
>     	- negative values
>     	- "0"  ( may not be a desired value )
>     	- "-1" ( may have some special meaning )
>     	- ...
>
>     I'll leave the idea here, just in case it inspires someone.  Thank
>     you.

Thanks to both for providing a wider perspective on guarding against
such bugs.

And this is an excellent point. I don=E2=80=99t know anything about the =
opt-args
implementation but it would be great to guard against user-supplied
values through the option parsing library.

Cheers

--=20
Kristoffer Haugsbakk

