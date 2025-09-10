Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013DC30CD8E
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535855; cv=none; b=NKvEvMTJsmmhh+QGLaZYsS81KbST5yt6FJseeHmNahc8XhuMP1VmcUmjApwuApy0Eij85gMyBhhuIA/Ifa897+WalQGQ6Aun/ka098Tge9RskizIU0/SaT9v3RUbv4tYlCdykMYT2MM0wYH7Mo9I/mWZqPjicOe6nMIXqlhhkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535855; c=relaxed/simple;
	bh=twNF2YwN3DAo9cR/32mOr+P4Wu7WNrdArY+SevRaTD4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HXVThhe2jLyXTZAZs449j2ktEhMwHWQrO1K5ydpxtNJkRJP4+e6g7YjoFDBgDOK1cRk2q1hGOqY78/qjsg5bFzkQ0RuS9te9uJfWdyqXBn/YOMnt1A9WypuK96i3A7voy8Yhs3AWpbyLtlDju8LcKbjveODeu2NrN4nO//jd3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=gLlONXv3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IO6H46Wn; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="gLlONXv3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IO6H46Wn"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5A297A017E;
	Wed, 10 Sep 2025 16:24:11 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 10 Sep 2025 16:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1757535851; x=1757622251; bh=jEepLlTbS/8QLxlnaEmasgplQa6nU8bf
	iC2fWqg0Emg=; b=gLlONXv3Ie+x2Wf3SCdiCt0HANJItBxMfLWPCDnRyOqCHX9Z
	LDhPijs8DD0jomd69yDQj1i0D0ROPZFH8zxPHwrWpdRp2cOtOVrUvYCZqbarYp8Y
	v94JaMQJWlM0AX3tKcGA5sqXZwA8AEP4OJGgKLTA1eyvur0f22XeUL68wMRmaUMm
	4+HGQwXdrx4H4KyiovDBUUkAW0wXzX8pIXBwvdh3yFRvclBqTu43c5U2qqAbH7a1
	shhnh0A9lYc3pV5XHSzDmdh8ka2XL6HooR/g86U13cUk39FJU/Kauvl+2hwXpHzm
	NL+7xn/iukhV1O0kyyT+CxcGBfUEK/K6DGoJzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757535851; x=
	1757622251; bh=jEepLlTbS/8QLxlnaEmasgplQa6nU8bfiC2fWqg0Emg=; b=I
	O6H46Wn0CUnf4IRvt9cYXCbKcfeXKvTEAZJS8NxaKOYbTEzTziqyXd55OBFHTDZ+
	0r+b3vFoznXvi7Mj+rvHPhMXFHRax5kRvMqlFsu+cehrJIV8h5uLP6y9WQkzQCki
	i8tDbyUU9FIOvXuGbuiZO5EEamm2kas0Dr0s9mXsV9yd+HGGWuhmeZTeFwBiBkdi
	3NnhCLtj8bV3CBtFPIn/8MFaa3XucIXlpSMD360iXTJZmxZYaYg4DbypiNEUYlFc
	P7nJ79XERJca1v/HEX0w+gLx+2CYHllA6tGlfOWdAeh0QMvYDpUduZPa2uqZo6vD
	kZ28suqTqImtliOkh4vxw==
X-ME-Sender: <xms:a97BaAr6hbvVasIV23ribz5BHksC9zbLNT1r7t-0XrXZ2pFkEjRpQng>
    <xme:a97BaGqO3qvgf6WXPWovWyxJ-1I7fYOfjDmbk4AZUU0P8ePdi4jxoLh2UDDHuYlbs
    FkOkRb18xnEXMnSqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:a97BaLH7TwtPZxXuf4vJoqibW6X54UsiH_gdKsJqAU86X0OpRSHwOQ>
    <xmx:a97BaJH_0Jjq6_uzw2qe_Dzumd6panu-JyMcwAW1_s6VUXAqKd-ISA>
    <xmx:a97BaJQ1db3a98MpnU3z_0s8gooTYzNcwzuciFH3B0l7eOLwW6nqPQ>
    <xmx:a97BaKI-g8NAFS3ykqP2g9cdDH2LNkJWfW5wWAlsN__W0WrbOAAVWQ>
    <xmx:a97BaIUuiN8FgcigJOybL3YCv_yzGi6v-FymRRS-JaYKzHmYD2LwN0Ti>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 22E9B1EA0068; Wed, 10 Sep 2025 16:24:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAEK-xvrxHXR
Date: Wed, 10 Sep 2025 22:23:50 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>,
 "Jeff King" <peff@peff.net>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <20fd7486-5f65-490c-866e-d07a19d2b75a@app.fastmail.com>
In-Reply-To: <xmqqjz27ti6i.fsf@gitster.g>
References: <cover.1757345711.git.code@khaugsbakk.name>
 <cover.1757446619.git.code@khaugsbakk.name>
 <66e6a9554b16b2079e5613a415a2d27a601d146b.1757446619.git.code@khaugsbakk.name>
 <xmqqjz27ti6i.fsf@gitster.g>
Subject: Re: [PATCH v4 1/7] git: add `deprecated` category to --list-cmds
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025, at 23:44, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>>     Incorporate Patrick=E2=80=99s suggestions about the for-loop refa=
ctor and
>>     formatting the overlong lines.  Now drop the function doc since it
>>     doesn=E2=80=99t apply anymore.
>
> So, if "include" is specified, a command that does not match any of
> criteria given by those flags is not included, and if "exclude" is
> specified, a command that matches any of the criteria given is not
> included.  Which probably makes sense.

On second thought I want to add back the =E2=80=9Cmutually exclusive=E2=80=
=9D check
since using both still doesn=E2=80=99t make sense.  (Dunno why I thought
otherwise.  Patrick=E2=80=99s change was strictly a refactoring.)

> The only user of "include" uses the DEPRECATED flag bit without any
> exclude option, so it is yet to be seen which one between the previous
> and the current design gives an easier-to-use behaviour, but I have no
> objection to the updated design presented here.

I=E2=80=99m happy with it.  :) But people can suggest an alternative if =
they
would like only one of the include/exclude.

Us Java app. programmers are only permitted to practice bitfields in our
spare time.

--=20
Kristoffer
