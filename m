Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D71DFCF
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671314; cv=none; b=MEuCVGB7DvjbcKHSt8tLpBd+5/El7xFpifskgEtwEEPk7IVqTAdYg7afMfg7KrXr1AX6QOCTDEKb25IrmVsX2+fZ2guZaLemuDv6P/wn5+dMsZ1iXDYYmcAW5ypmbKgMtyOu+ehc7Gat5aGngeEx9P9jzrU5Le4Vyq1gSOahG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671314; c=relaxed/simple;
	bh=KAAJgQl/Eil8BLWJShvIJZigpDVHRMO1EYdqe0Eh72U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ILop73H9XQbbYTncYE1OhfClqVOQH3M1UmCo7RMDDJ3C8URLoQbo6ejywvsZauHOGrtNjb8+UE48WOkurD2EU+DTn0hWMNhSkdTZzfbOAnXPb5+wshNmYexGLUpX2Iz3KEo8gg+ugOFpS0Dy87h3QRss2kpyCfWst9A54+4U9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=DdCrEPT9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sskiz4Pe; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="DdCrEPT9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sskiz4Pe"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id DD7D55C0066;
	Sun, 11 Feb 2024 12:08:30 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sun, 11 Feb 2024 12:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707671310; x=1707757710; bh=GMQkQwfPvmV76b2aeyFULH0qNJMrMLem
	ytIgCW61hpI=; b=DdCrEPT9l/iwGafo8HTx6RxtKglhDHTSu+B+2o0OOSZyExhn
	cJlf/8h1/fwEX7wWAc8/stt6LuH2IUo2XDpiogriRiG6fFVQe8gHGUL7Yv3JQ1rL
	+S2X7Fz7KOMLYBtlquIwhtgJSLcb5LbBvfIP1tLg+L09EQ+9liAj8zwERkj1u31f
	3sMBapbfIlKGdZ4Aylz8y9D23XDLVKJqYP3v6apfqvzWiSrjbvKMbHxDrjh77hgM
	AqFFrHpU3YSEtVxcoZKztnANNfWgQG3UYfoMLE13W6QsCWD8zAGZX6zOMsECdZwg
	sw+zhuod1T6AdBJmLTJrNFSTh+GdcSOsDb3g8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707671310; x=
	1707757710; bh=GMQkQwfPvmV76b2aeyFULH0qNJMrMLemytIgCW61hpI=; b=s
	skiz4PegHXvCA5tJEOoKU8twv6M3PLa2eqRkLuRDMRCitlkZiUZSg1Z3CD4qffTX
	6yCC/ntxK8Tr/AuZxJGLA23Zqo72jOGA+LWXkzVzN+YkYZE/5QrFSzwH2IxEntDB
	QoJkSBMWz6q0i3TsVPFOk2bFJhCClYh4lZbkQD4vNbSaDjwkyIPc4rqu2eWhdjT/
	hpxMvoCX1ozcbHk6QswOdZUKHX/gEYa0o3jXY40vDgzduUqk7nkrbwGZ3KRDaczq
	YNCwJai1JsOqFIFxarlWIxEOSzdv9/OyhAdkZ2+25mOlONinYR41+tzxr5Mt0eOa
	WP7rDNqhBbbWzMOr2DEqQ==
X-ME-Sender: <xms:Dv_IZRDp1xhH4ZJWmwB2mlcCXF9N4blWppcg4BwsHwBpQAZYhIQnVpw>
    <xme:Dv_IZfi3CJLv_kulxWOYMFGHmxJHx-OoI3D-VVoJO5IK0FmqGHPXfZRSB75p4IWZ0
    GozSqMaTqIXcM2HEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeehgeffhfevhedvleeuhfeukedugefh
    tdegudejtdfffffhlefghfejhfffudejhfenucffohhmrghinheptgholhhumhhnrdgtfi
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:Dv_IZcl8_6K2YhYzhgcgETCkwwjg0zIDzkYPDEEl9tNBvDGqei2giw>
    <xmx:Dv_IZbwjFI0OBNLMA7ZdQGcKwmCfgxz6_k5_Vv6Ce780plilY7DC5A>
    <xmx:Dv_IZWTjQV8PaBwEr5MYfocxP-EBZ2Rx4CvaWLmML3quF5pupj1-Pw>
    <xmx:Dv_IZZJqTbvi5rviQ5vWgUx6vTNm0Pv1yDi3S6K_hunSAIlCqWI4TA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8BAD715A0092; Sun, 11 Feb 2024 12:08:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3380df68-83fb-417b-a490-71614edc342f@app.fastmail.com>
In-Reply-To: <xmqqttmhfrko.fsf@gitster.g>
References: 
 <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
 <571fb353-af1d-4cc9-a2c2-197296685623@app.fastmail.com>
 <xmqqttmhfrko.fsf@gitster.g>
Date: Sun, 11 Feb 2024 18:08:10 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Tiago Pascoal" <tiago@pascoal.net>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git column fails (or crashes) if padding is negative
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024, at 18:57, Junio C Hamano wrote:
>  builtin/column.c | 2 ++
>  column.c         | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> [=E2=80=A6]
> diff --git c/column.c w/column.c
> index ff2f0abf39..9cc703832a 100644
> --- c/column.c
> +++ w/column.c
> @@ -189,7 +189,7 @@ void print_columns(const struct string_list *list,
> unsigned int colopts,
>  	memset(&nopts, 0, sizeof(nopts));
>  	nopts.indent =3D opts && opts->indent ? opts->indent : "";
>  	nopts.nl =3D opts && opts->nl ? opts->nl : "\n";
> -	nopts.padding =3D opts ? opts->padding : 1;
> +	nopts.padding =3D (opts && 0 < opts->padding) ? opts->padding : 1;

If these two are meant to check the same condition as in
`builtin/column.c`, shouldn=E2=80=99t it be `0 <=3D opts->padding`?

>  	nopts.width =3D opts && opts->width ? opts->width : term_columns() -=
 1;
>  	if (!column_active(colopts)) {
>  		display_plain(list, "", "\n");
> @@ -373,7 +373,7 @@ int run_column_filter(int colopts, const struct
> column_options *opts)
>  		strvec_pushf(argv, "--width=3D%d", opts->width);
>  	if (opts && opts->indent)
>  		strvec_pushf(argv, "--indent=3D%s", opts->indent);
> -	if (opts && opts->padding)
> +	if (opts && 0 < opts->padding)
>  		strvec_pushf(argv, "--padding=3D%d", opts->padding);
>
>  	fflush(stdout);

--=20
Kristoffer Haugsbakk

