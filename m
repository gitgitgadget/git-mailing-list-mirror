Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F856FB2
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711867427; cv=none; b=qh9B0xA9P1FOYMlw7iRDuLze7/bf4qdu18mcgbp1fc4UVqA6RVcq9ioz+ZTCMslS3rK1ul6U061l9pTpINWcqUfHTdvufuRd9nJSEilGl0pL3dAmf/exjauD1Z12pXSXOoGdaubi0Pac8GUZdGtMe/trlFA59j2Q2DeG99PVXg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711867427; c=relaxed/simple;
	bh=CNddlyyZF0EclzMe2XgjW+PTc2beR7Y5PUnI0ex20Cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SNCUCrWhRZG2tLzgwiC8e3ueGgGEbKAq4temMCH4I/Vhxe8sPZizzaXuFRU9APgVebIRYO8gp0C/kyVutUsEmVua17Y0hZN2A90ot7ewAkr3WOUTx0Ffm8uriKwlDYcI56ajcKCAZ2gIm1MzCXNf89YVI03DP8I1Ln7yQzOWOcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rAcgSQtC; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rAcgSQtC"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A8D11A5A1;
	Sun, 31 Mar 2024 02:43:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CNddlyyZF0Ec
	lzMe2XgjW+PTc2beR7Y5PUnI0ex20Cw=; b=rAcgSQtCboxuZF94UjuQmldwbI71
	XzjRYTHOiTMqNNhfg+kJjcxQmLvvZnd+SV8DIPXe9qbs4kFgHsgnAqPDKs6puarf
	zu5t47SEGLBIL/HfR3hyn1AbZM7TNijs6zpaxmToBCpbm2a/uJqQtwvt9+4vsfKg
	9HFOyU9HjC+JB04=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 536E51A5A0;
	Sun, 31 Mar 2024 02:43:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D1DE31A59E;
	Sun, 31 Mar 2024 02:43:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] advice: omit trailing whitespace
In-Reply-To: <4c8da56e-974b-474e-aefe-1ced5ee69327@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 31 Mar 2024 08:17:30 +0200")
References: <xmqq4jcooddp.fsf@gitster.g>
	<fc002d62-6efe-42d4-b562-c10d3419fff6@gmail.com>
	<4c8da56e-974b-474e-aefe-1ced5ee69327@gmail.com>
Date: Sat, 30 Mar 2024 23:43:40 -0700
Message-ID: <xmqqcyraj3z7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 03570EE2-EF2A-11EE-96C3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> >  	for (cp =3D buf.buf; *cp; cp =3D np) {
>> >  		np =3D strchrnul(cp, '\n');
>> > -		fprintf(stderr,	_("%shint: %.*s%s\n"),
>> > +		fprintf(stderr,	_("%shint:%s%.*s%s\n"),
>> >  			advise_get_color(ADVICE_COLOR_HINT),
>> > +			(np =3D=3D cp) ? "" : " ",
>> >  			(int)(np - cp), cp,
>> >  			advise_get_color(ADVICE_COLOR_RESET));
>
> Thinking again on this I wonder, while we're here, if we could go furth=
er
> and move the "hint" literal to the args, to ease the translation work:
> -               fprintf(stderr, _("%shint:%s%.*s%s\n"),
> +               fprintf(stderr, "%s%s:%s%.*s%s\n",
>                         advise_get_color(ADVICE_COLOR_HINT),
> +                       _("hint"),
>                         (np =3D=3D cp) ? "" : " ",
>                         (int)(np - cp), cp,
>                         advise_get_color(ADVICE_COLOR_RESET));

It is not guaranteed that any and all languages want to use a colon
immediately after translation of "hint"; the current message string
with or without my patch allows translators adjust that part to the
target language, but your version will force them to always use only
a colon there.  Is that an improvement?  I somehow do not think so.

