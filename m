Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22BD42AA1
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745371060; cv=none; b=SEB5xDhQomr/C1r88IguHGYdrLE/55+Ckx97mfL+UcQq6aoJL/vGItEJ+TP6ddco53H3Wk2dloRzszGXSLA5LeIUutLGLo1XBY/YjajPT+oXnf/LnYEJaCBN3lMSNo0pas8QpRFmmJnnVvIfNdClX4A+VWlAY5eMn3Gh6SEPGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745371060; c=relaxed/simple;
	bh=AXLEddTWcugbC3B06YFMD/5dUlImfKZPs5y3rZIoJ8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYc5Nfxmk6HeYw5QQk2hVl715/TvSMykO7Uagm4amOWQuycsKIHduK4+XZd1PzOeVLdCOuj+5U8fgANWF1KprlQ7mmnBvWg4Ei76MNRNr3lvvmo05zqVUmAwC3pD9TdcMmfLMrx9wmaf4GiVEehXETq5xMqRRUsOC6cXJ2CiIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2600:1009:b041:2ce8:4c68:2072:7aeb:a93e] (unknown [IPv6:2600:1009:b041:2ce8:4c68:2072:7aeb:a93e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6A682342FDF;
	Wed, 23 Apr 2025 01:17:37 +0000 (UTC)
Message-ID: <ddfbd943-73e0-4ca2-a458-26b05750ed9f@gentoo.org>
Date: Tue, 22 Apr 2025 21:17:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org, toon@iotcl.com, ps@pks.im
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g> <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
 <CAOLa=ZSR=7TEWLHa-wzBB4x+4+-BH3UC3G7s24Bc26JH63QKOA@mail.gmail.com>
 <17c2eb4f-e291-4189-9846-0f42bdead01d@gmail.com> <xmqqr01k42cx.fsf@gitster.g>
Content-Language: en-US
From: Eli Schwartz <eschwartz@gentoo.org>
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <xmqqr01k42cx.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cPADlOpdSMjaJQeW43Z253WN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cPADlOpdSMjaJQeW43Z253WN
Content-Type: multipart/mixed; boundary="------------WXkhW6v54JoHM800Y31uNTun";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org, toon@iotcl.com, ps@pks.im
Message-ID: <ddfbd943-73e0-4ca2-a458-26b05750ed9f@gentoo.org>
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g> <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
 <CAOLa=ZSR=7TEWLHa-wzBB4x+4+-BH3UC3G7s24Bc26JH63QKOA@mail.gmail.com>
 <17c2eb4f-e291-4189-9846-0f42bdead01d@gmail.com> <xmqqr01k42cx.fsf@gitster.g>
In-Reply-To: <xmqqr01k42cx.fsf@gitster.g>

--------------WXkhW6v54JoHM800Y31uNTun
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/22/25 11:55 AM, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>=20
>> I'd be tempted to check for which package manager to use by using
>> `command -v`. That way the only distribution specific knowledge we
>> need is the package manager and we don't have to worry about the names=

>> of the various release files in /etc.
>>
>> 	if command -v git
>> 	then
>> 		: nothing to do
>> 	elif command -v apk
>> 	then
>> 		apk add git
>> 	elif command -v dnf
>> 	then
>> 		dnf -y install git
>> 	else
>> 		apt-get -q -y install git
>> 	fi
>=20
> OK.  "command -v" should be portable enough these days (in the past
> people used "type" and yelled at by portability sherriff).=20


It (command -v) is available since POSIX 2008, yes. Optional before
that, and thus available in many (but not all) contexts.

Debian upgraded from POSIX 2001 to POSIX 2008, as of July 2018, see
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D864615

Quotable quote:

"""
This version of the standard is so outdated that it isn't even any
longer available on the opengroup web site. [...] Please consider
updating the policy.
"""


--=20
Eli Schwartz

--------------WXkhW6v54JoHM800Y31uNTun--

--------------cPADlOpdSMjaJQeW43Z253WN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaAg/rgUDAAAAAAAKCRCEp9ErcA0vV7OY
AQD4lNFAPDGb6UatN/01VvA1YNHx0XqW9wjUhUSirHKoVAEAyv5HhxcY36CllB/JO9Fb59YRc/kz
6JngPUcIZL5aaAc=
=M+wx
-----END PGP SIGNATURE-----

--------------cPADlOpdSMjaJQeW43Z253WN--
