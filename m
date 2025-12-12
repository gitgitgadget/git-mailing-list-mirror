Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D489311C13
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530975; cv=none; b=bBttPPapQYYltMJUYfB638xsF74nnu2QzGgzcfcWYliXxRbohku1szAQgm0Br+3UcLnn9i7Adb6zhJvksbT3haqnzayjZqgtzaR6N3z22zRIW5ULcKzu30xr2W4WB2MX958BIRUBt8su6/FYLISKDDMVFHr8QgIo93hHI6UroDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530975; c=relaxed/simple;
	bh=ppKzHcaFwHDagLSGf6zLj7t18DeF/dOdJK7FtZjDP18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srWXWXHNBPB0jl/r/VrqPVjYEn8NNP9tmfglj9G2dbWRvs7DwtA99eGDZO+5fSJT0999jbb+WY2nophPdSOtFRXCW+N0qDTFeTaheKayki8QgnB+nsmRcj9s7v90q/IDI1/gz2g0Ri8lYZpBdXTX31TSKoMCtUARvguoO1rDarc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Fcsuggxd; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Fcsuggxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765530963; x=1766135763; i=l.s.r@web.de;
	bh=PQrML0h8WXjd8cws5TdOSVZn6iQM2QqEX31q9xFHzA8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FcsuggxdVLh3QeEZHaVrGvxAXFJ+1EN0RjmGai8cBRrbUWH2JCiqhlb1WruXsGRM
	 Dv2IuMevkyuZGMxUeT59v48hV31dI1pORzHjTtz6MrrhPWvFvD2JNUOS+PphpdbJL
	 s3iS/nugKlgwZ7aeBI0TvaM/SZ+TNyqFtPg7+nv6ccVK2oF4o2/RgT1eepT64e/Vy
	 nOpYWvevn1IEg9H8Xok64m+JZc0z6aN3IM5obgFxTSk2/IUje7Ddq8PiVvDya9z5b
	 YyOed9moAoedZOzPgUT31WNUQ/VkcEE2qm3AF1AKl4CgxUAEpGxNmQuUj1DOs/HqF
	 JxcAtDpaTSioU2QebQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK52q-1vjr9J098w-00OU06; Fri, 12
 Dec 2025 10:16:03 +0100
Message-ID: <3ac57efd-a0c6-49da-b63d-825d97b3821c@web.de>
Date: Fri, 12 Dec 2025 10:16:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Git List <git@vger.kernel.org>, Koji Nakamaru <koji.nakamaru@gree.net>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
 <qnb77j3b5m6rfbzr3qhmwalo5lha4gqslvzqsfuq6zur74ze7j@wqriu4w7wbzw>
 <1b3509d7-e421-4136-a62c-de86213d65b2@web.de> <xmqq7buthgq4.fsf@gitster.g>
 <vxi7g67b322sre7ylkcfwujf3n34j3f5vtpl62zhrj4ds6f675@hyyh2rxhaib6>
 <xmqq7buse906.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq7buse906.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YLqJruq7owT6md8pA+v9acxXTv7/N1Cue630yVXta8y4OtJ9db+
 BHoor0DO9dg0uj/3R/ST6mxy2yLKAe6c0iECQ4gGQmolUh9ucI0O/OByMDFCRD2hXQ7gyHy
 C7ceJZpVAbr+MyGp5hYz1kdSkwaEDgEpt+IvXuroTMiMQK16RAGnEOfDWY8AJWSgpIw4Jbr
 zkRrHeWREXBIzufRrlv+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JL6ppiBnMNA=;jfk2x4yl2Pg8X635aBd70kFsimA
 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

On 12/12/25 3:20 AM, Junio C Hamano wrote:
> Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
>=20
>>> I am looking at relevant parts of Makefile
>>>
>>> # Define NO_FINK if you are building on Darwin/Mac OS X, have Fink
>>> # installed in /sw, but don't want GIT to link against any libraries
>>> # installed there.  If defined you may specify your own (or Fink's)
>>> # include directories and library directories by defining CFLAGS
>>> # and LDFLAGS appropriately.
>>> #
>>> # Define NO_DARWIN_PORTS if you are building on Darwin/Mac OS X,
>>> # have DarwinPorts installed in /opt/local, but don't want GIT to
>>> # link against any libraries installed there.  If defined you may
>>> # specify your own (or DarwinPort's) include directories and
>>> # library directories by defining CFLAGS and LDFLAGS appropriately.
>>>
>>> and notice that /opt/local/ is mentioned for DarwinPorts.  The patch
>>> that started this thread talks about defaulting ICONVDIR to that of
>>> Homebrew if available, but the new code checks /opt/homebrew and
>>> then /usr/local/ (and let it override it).  Should the log message
>>> be talking about DarwinPorts as well?
>>>
>>>     As a workaround, set the default libiconv location to
>>>     /opt/homebrew when the user has one from Homebrew, or
>>>     to /opt/local when the user has one from MacPorts.
>>>
>>> or something along the line?
>>
>> Since the original patch was only meant to help with Homebrew it
>> might not be worth mentioning the OTHER package managers IMHO.
>=20
> Meaing that the original patch should have included only
> /opt/homebrew and we should drop the part about /opt/local?
>=20
> Or do you mean Homebrew may use /opt/local instead of /opt/homebrew
> and both parts of the original patch are needed to give coverage to
> different Homebrew installations?
>=20
> If the latter, perhaps we can say something in the proposed commit
> log message to explain having both /opt/{homebrew,local}/ is
> necessary (and why)?

Homebrew uses /opt/homebrew for Apple Silicon and /usr/local for macOS
Intel (https://docs.brew.sh/Installation).

MacPorts n=C3=A9e DarwinPorts uses /opt/local
(https://trac.macports.org/wiki/FAQ#defaultprefix).

Fink uses /opt/sw
(https://www.finkproject.org/faq/general.php?phpLang=3Den#why-sw).

The patch tries both Homebrew directories, the newer Apple Silicon
one first.

Ren=C3=A9

