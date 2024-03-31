Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D9014532A
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711923627; cv=none; b=gMhFfrrdcd1T3InFSEB9H0LMHFGceYAXFRofhtMoHiVT8qxtgjigDHsFB+BYwnhkSZ8H+JRV+HG3MvYMu7qHCHs5HFmW/z3S1yAO6RRV5kMLpTQEIu/6/3ykFEabfPMWSeFNGtbTsDUw0x4l6zQideAg7/IsaPglDeng2ThrdUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711923627; c=relaxed/simple;
	bh=7ab8qFj4Xm2hvBC6XMnXqgubJswLS1dlT+yGHD31GmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j1RW1Bn/LY/2hN0FFXraTRrI+32nt1Uzx2xKhegiMHLE9hyti1rc+WlY7+HSj0K8xVYhodZLVpk+ZGw6maQW5pY/5+LkDniqVizXnVBmSaPNHJIA2wQqbdOayWPdHEJPMQdo1FicWBGQZt3xiWm+bqvSzecTMw1ZjZvcKge2YlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SlxFjlzi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SlxFjlzi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B86A1E01C4;
	Sun, 31 Mar 2024 18:20:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7ab8qFj4Xm2h
	vBC6XMnXqgubJswLS1dlT+yGHD31GmU=; b=SlxFjlziSuyGRNF+OTyga1jM3Ndo
	tcUffdG/JM+RU+kYABXADcmQnBK1a2p25YdA1lzatSsrZyZEhOeaGu8QuQ6RTlfh
	nVFA1x9sqMEOyMJgKJsCIUQmMw0ISB6GF9OPE0l5lQTvBLlytfdvlEpfzXuBvdq3
	AZzb0BfpZCtGaks=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42F7B1E01C1;
	Sun, 31 Mar 2024 18:20:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 973921E01C0;
	Sun, 31 Mar 2024 18:20:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] advice: omit trailing whitespace
In-Reply-To: <3e35b731-333e-4b46-9c0c-089b5c47fe99@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 31 Mar 2024 10:11:08 +0200")
References: <xmqq4jcooddp.fsf@gitster.g>
	<fc002d62-6efe-42d4-b562-c10d3419fff6@gmail.com>
	<4c8da56e-974b-474e-aefe-1ced5ee69327@gmail.com>
	<xmqqcyraj3z7.fsf@gitster.g>
	<0f43cd7b-a366-4ec2-9577-93708e21f2ff@gmail.com>
	<3e35b731-333e-4b46-9c0c-089b5c47fe99@gmail.com>
Date: Sun, 31 Mar 2024 15:20:22 -0700
Message-ID: <xmqqo7auf3h5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 DE329270-EFAC-11EE-B519-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> > > and move the "hint" literal to the args, to ease the translation w=
ork:
>> > > -               fprintf(stderr, _("%shint:%s%.*s%s\n"),
>> > > +               fprintf(stderr, "%s%s:%s%.*s%s\n",
>> > >                         advise_get_color(ADVICE_COLOR_HINT),
>> > > +                       _("hint"),
>> > >                         (np =3D=3D cp) ? "" : " ",
>> > >                         (int)(np - cp), cp,
>> > >                         advise_get_color(ADVICE_COLOR_RESET));
>> >=20
>> > It is not guaranteed that any and all languages want to use a colon
>> > immediately after translation of "hint"; the current message string
>> > with or without my patch allows translators adjust that part to the
>> > target language, but your version will force them to always use only
>> > a colon there.  Is that an improvement?  I somehow do not think so.
>>=20
>> I was just thinking if leaving the format open to the translation is a
>> sane option.  Maybe we can move the colon to the literal in the args,
>> too.
>
> Just for the record, zh_CN (Chinese) and zh_TW (Traditional Chinese)
> do not use ':' on its translation, but '=EF=BC=9A'
>
> So, if we go the way I proposed we'll need to move the ':' too.  I
> still think it's an improvement.  But, optional to this series.

It is making it even worse.

Giving larger unit to work with to translators is usually a better
for i18n than chopping a single logical message into multiple pieces
and paste them together in the code, as your untranslated
format-string (e.g., "%s%s:%s%.*s%s\n" we see above) will force the
word order in the final output.

I think the patch at the beginning of the thread is more than
serviceable, but if we wanted to improve on it, we should go in the
opposite direction, e.g.

	if (np =3D=3D cp)
		fprintf(stderr, _("%shint:%s\n"),
			advise_get_color(ADVICE_COLOR_HINT),
			advise_get_color(ADVICE_COLOR_RESET));
	else
		fprintf(stderr, _("%shint: %.*s%s\n"),
			advise_get_color(ADVICE_COLOR_HINT),
			(int)(np - cp), cp,
			advise_get_color(ADVICE_COLOR_RESET));

to give translators flexibility to choose what kind of space to use
(including "none") after "hint:".

I am not going to do that, though, until/unless somebody complains
and says "there is no inter-word spaces and it is more customary not
to have a space after the translation of 'hint:' in my language".
