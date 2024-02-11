Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1F5A102
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671451; cv=none; b=jmTmyNmcISGMheFuPLZXOmjkcEuQKLelAB0WDOmbAqjqpH0rnpb34GyNEZzGtq6XkXg6tJKyQ8k0YD9HStfC5Kwa41BYdqaAfx2OWXgSCWa19DEp+QHHw2mPWiz8sQnMglFN5S+M3A7ce0L9MPQRJZqCOe9lVapEewu4fNBDmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671451; c=relaxed/simple;
	bh=A0jWtUfuEsoIudncw0T/La3ZzYoxvDPRMNnuo/96e7Q=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=P1OBUhtqRdrvw4fJH7oy2nZuLo/NKvAHsTjN7tveu/EQht7a5J0IN/xe9lE6EfR9j2RcAIjLTQ2QJMdTYvhfCxaQ9U27QkSqWBBGsysds74WtbGyx8+OKrP+BhM29zRoYbplNw6xwiAfCu5XGc7ssLuYN5vEi0EB04QxhDI1AqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=SEnQo7g9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aIdrMEB1; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="SEnQo7g9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aIdrMEB1"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B3D995C0066;
	Sun, 11 Feb 2024 12:10:48 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sun, 11 Feb 2024 12:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707671448; x=1707757848; bh=nXwfEtiLA8Wyx3XqZJp1YOWC9Xnyzx45
	aLVyQB70BB8=; b=SEnQo7g94BALVAzz4zyTJZ7COsMfDnNBseOPigdyJ99oV/AG
	Aqu1DT/8bYycXC1pihSKFnxfaGHFZiEP/3O7SNd3oL4m/aBpEgteyvNebMypmU6M
	MdN27FfndpUa0/eP6Eu5gE6PKV8qzmBFfh+m4m6jTf6rZeR7mxWqVoCrPkoXpLGm
	BHg7EwTZXZytM3jpk0Qn2hIt6ApwNY6/gGSqqAFCzXAFAoKnCupd7pLTrK3U/02W
	EU+heVWY4xxw4tR5uMwjG1ZW9F+dsphtfnNLSq5DIyD3tKeW8uy0Q4Jw89FTPLnz
	VaWWyFTSJ3+srdE4Jvq0rgFbGBPQa/pnQnaSqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707671448; x=
	1707757848; bh=nXwfEtiLA8Wyx3XqZJp1YOWC9Xnyzx45aLVyQB70BB8=; b=a
	IdrMEB1kOPi+4wO6ykRzFYODuKRwQL4gde+rAUEMWQePP27z/CI2XWxFjpVBC+NK
	LcxI9iVcEf8hmIGizk315Yp2bYZUvqFXk+mKQOE+wJ3e3QvClDC40AY+hyo6JBZY
	IMR6jdTYYjVezU3zpNN5Brv6Jz3HT3cCdcL6QPBewgG8GggxBpVrI/EqY335NyI2
	oQqi1krBLWdqm14W54RXuqK5P4ekgxxP0DcNZwiFIqJl9gWKNrXc6J5k8ZG72ezz
	DimCSNeAdteo6wwiNSvATYGlYvqcac+n58/p+3wzGH8dFiZSqYVLZrLx9sh/f2V6
	kLeYR0z2laP0IINBJZO2A==
X-ME-Sender: <xms:mP_IZTq8esi9sbtSPkLUDLAhHQcLmMwVhcO5cPAA2MoRQ-kaqEJqx_8>
    <xme:mP_IZdpczLqoXUUuQF0AJljonrSDYiLoirwDE3Z3IpiQiQ8i2jZG-QuYqNpV19oJm
    FwvHCHUZpo9_nR7Jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:mP_IZQO9x8DYmtES-mSDf0SDEzHxMRYD25owJQ6tScipHrir1w121w>
    <xmx:mP_IZW6Yg6aI6kP8US4vjcns4ea5PPmo8gbPrUiJ6RCggBO7u3OjDg>
    <xmx:mP_IZS5_pkYyc2BM9mcN_Sn9O8WPAZ8O89hWjQx3khCK9dTGzmAAbA>
    <xmx:mP_IZSEE5TSMXiDTEQBwqkR6KAzwj7spg5ClQG7Z50LajSEq2LQLRg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 77D5D15A0093; Sun, 11 Feb 2024 12:10:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9c00311d-e31c-428b-9c66-fef7ac8bfc76@app.fastmail.com>
In-Reply-To: 
 <CAPx1GvdDvmBmvoktd7onB4mSzikKf4eWVWnrzrn8c8Y1RcRgsA@mail.gmail.com>
References: 
 <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
 <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
 <19119aa6-9a8c-44c6-af79-0ea6a8bcb181@app.fastmail.com>
 <CAPx1GvdDvmBmvoktd7onB4mSzikKf4eWVWnrzrn8c8Y1RcRgsA@mail.gmail.com>
Date: Sun, 11 Feb 2024 18:10:26 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Chris Torek" <chris.torek@gmail.com>
Cc: git@vger.kernel.org, "Tiago Pascoal" <tiago@pascoal.net>,
 "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH] column: disallow negative padding
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024, at 10:48, Chris Torek wrote:
> On Sat, Feb 10, 2024 at 1:46=E2=80=AFAM Kristoffer Haugsbakk
> <code@khaugsbakk.name> wrote:
>> I forgot tests.
>
> You presumably also wanted the `_` here for gettext-ing:
>
>> +               die("%s: argument must be a non-negative integer", "p=
adding");
>
> Chris

Yeah, thanks. You probably saved me a v3. :)

Although I failed to notice that the string I stole was just a plain
string, not a translation string. And apparently there are no generic
=E2=80=9Cnon-negative=E2=80=9D translation strings. So I=E2=80=99ll just=
 make a new one.

Cheers

--=20
Kristoffer Haugsbakk
