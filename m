Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB041CFA9
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041940; cv=none; b=JcXfEASZRJgeiD5845g1MMpvsFgT7G+J7O3xDcxZVZ7Bf3iK3tZsp8r/szyHmeo4MHPJsKbsWa8xsw5ilXWeDBzoVdLOW8IDJ+bPKqw5/klaeqfIUGi/jxoP7UgrTVEqYdRnfgXOoKE2cbGiXBLEMVcJqWbkEaZmgwvY606oAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041940; c=relaxed/simple;
	bh=k2mrz0c7o9J/te4rZ039vFKgUVtKyG8cNAp4Dgp7Sq4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=N/77Adxg7TeGtOeu8UaoHtld4t3wNJRu2X02zAGPvtC5//NHPxPl/q2sSS/jn/8FCHSaD0fd6I+2r6GQNhIbznIMgSTFNPlgSQxgx+pgS/HoC3WGlClSpoJ1B0d90s0aRDNFeANjUNJjHApZVkcCq4VIelgt+plVIiltjPYzznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=mXyhHZIc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OccOJXbX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="mXyhHZIc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OccOJXbX"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 856711380234;
	Thu, 25 Apr 2024 06:45:37 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 25 Apr 2024 06:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1714041937; x=1714128337; bh=BCPFTnx8niG5GyVk1DSSEprWmcdt024+
	HqXOBPg7pJk=; b=mXyhHZIc/2Y54tbGJmjkXUaOh9pybJjkr9STn8HaafJDCUL1
	+27601WABUPpiR5L9sDCDagr3w7qzQbr9cAAaMoocoPYa3Pw+AwTmbxiosZ8nt+u
	ktkt8vMWWUdM2WJd9Xuk8Wm/32NQoWWbv261wY+gSvemKHrFn0XIe7zBf9LKJUal
	jp9sFU/Wy8HIlDNVs265n8o0Upxr8U4WNh9UqkcZcp6MQ0BXjqRLvlWtAls3kEwN
	uplPCmckS8Til+lRBrEeJeiV+5BCankXjVPhBFCiEBJkXeZSsvdq8FdlnoYRIzex
	gbQMa0JP6UfaSFRKxEnn5r8CFdVfxK9xQjkjKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714041937; x=
	1714128337; bh=BCPFTnx8niG5GyVk1DSSEprWmcdt024+HqXOBPg7pJk=; b=O
	ccOJXbXFY679qUbgKNKxLWcjgEowzMI3uwMS5vfGajR9U7o1+Vj9Q9Ci/Wl6ZhXw
	ye7LMMAlI7CaOw0YyeYvDrh09dTlyShkQHQSBZAQn2+IbOrJY9MMJFgNSKQW3SD/
	rdcb2LAgXXsyuJ2nK7uL2OiDU25YEMI+epnTyMqpjXPPX+Vd/zVBlPWqQOclmztV
	AGY+K0FEtnBx3BOeCQT66C8/oID8rTL0pYr58/aDlOXNMZhp2QCJoM9grTcPsvYl
	8PNMIV64CVsPd6QaYW5lZpWzXbp0gP4tI6Qi3XRkid+zLi8/0gXOo/N6/bq8xYzx
	j2VqHztABuVF3M5WRvqtw==
X-ME-Sender: <xms:UTQqZpm31kmDxC3IB1oi7LITq8r8AbDe0gbh0p1N-JOs24gjCvgop5g>
    <xme:UTQqZk2-YZAZcoBRoSLaMeFCp6QntRDbTqzRoWxVN3rcyC0ant3sQCmhCBBN0q1Us
    sWvNqYlIV8HilGmiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:UTQqZvqM83ZdY8ePRxgbRsKCvFDQ6qo2a9AGacmqd3fKCStdsxP5Cw>
    <xmx:UTQqZpkOt30xlEbq_wdNeIPaMOFK9MKhJXkbALcKxcqIPazmQ2u5UA>
    <xmx:UTQqZn1xXl1u-WJqFdJ-Qs7XdyWNF6ZHZFT9gW9sAXExtuOZcKwBtw>
    <xmx:UTQqZos8TyE7D5SIg1UO2gZzh3YltJUSk0RGHV-JxhOrG8v7YoDqeQ>
    <xmx:UTQqZoyIkHyxnhvqLvX59jPqONDUInaDcw3d8PgGPgUB8NcmfObxMOdB>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 342A715A0092; Thu, 25 Apr 2024 06:45:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4ea09a34-bd62-434e-b893-8e3780aa915f@app.fastmail.com>
In-Reply-To: <20240425101845.708554-1-rhi@pengutronix.de>
References: <20240425101845.708554-1-rhi@pengutronix.de>
Date: Thu, 25 Apr 2024 12:45:16 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Roland Hieber" <rhi@pengutronix.de>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Denton Liu" <liu.denton@gmail.com>,
 git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] completion: add 'symbolic-ref'
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024, at 12:18, Roland Hieber wrote:
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>
> ---
> PATCH v3:
>  - make use of __gitcomp_builtin instead of hard-coded options, and add
>    a test for it (thanks to Patrick Steinhardt)
>  - add empty line between test cases (thanks to Patrick Steinhardt)
>
> PATCH v2: https://lore.kernel.org/git/20240424215019.268208-1-rhi@peng=
utronix.de
>  - no changes
>
> PATCH v1:
> https://lore.kernel.org/git/20240424210549.256256-1-rhi@pengutronix.de/

You can use `git format-patch
--in-reply-to=3D'20240424215019.268208-1-rhi@pengutronix.de'` in order to
link v3 to v2 (or rather: you can use that for a possible v4 (points to
v3)).

(I was going to link to SubmittingPatches here but I didn=E2=80=99t find=
 a
mention of it there. Apparently I misremembered.)
