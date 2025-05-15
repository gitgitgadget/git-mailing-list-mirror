Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BDF29B766
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340285; cv=none; b=FW+qk0lC5v65z59kxUhNzLeE+kT00n7KjnOLJgEMHAqvkl2g2+u3mp8QZUGSmppYsdrTBMZyGwYRCOQ6tY7smpyMlJeLvdmfXOuT3bP37ZM0r1LdwoVY8EjL6QQJPPz8KoLcjJgsE0FmUrtEm+QpnegXd72kbWn27ZsczjgrA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340285; c=relaxed/simple;
	bh=RUalCDstgRN76U6GhPYl7vRVy9ifnJ8+iFgglmP7wAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkqMCO7wPOQnDWWCJsuIZKAfkcRre3LDrjKdmoy6GHm6Npi4lTiQpmY7rQGHlh+jI9XXSg+H+XfLbt2d7trCxDuk07Mf9oY0SW+ZpPv9GC+3iMtpJaGXYktGpxEnL5GQLKS0oIR97YclkWRkipcAzDXizNfEE6q87U+30Qmukvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E4B26343839;
	Thu, 15 May 2025 20:18:01 +0000 (UTC)
Message-ID: <44f2741b-a77d-4bac-b4ba-63e23cbc1901@gentoo.org>
Date: Thu, 15 May 2025 16:17:59 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] configure.ac: upgrade to a compilation check for
 sysinfo
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
 GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-5-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-6-ramsay@ramsayjones.plus.com>
 <9baad29d-a5bf-443d-98a1-36d7020e5835@gentoo.org>
 <56706ad8-93c6-48cd-ad16-9d8b00a669c9@ramsayjones.plus.com>
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
In-Reply-To: <56706ad8-93c6-48cd-ad16-9d8b00a669c9@ramsayjones.plus.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------65yeUprQpdZbyJtMY7FuPfUi"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------65yeUprQpdZbyJtMY7FuPfUi
Content-Type: multipart/mixed; boundary="------------p4MgkAH0Z1T00ivg8vYDvT7E";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
 GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Message-ID: <44f2741b-a77d-4bac-b4ba-63e23cbc1901@gentoo.org>
Subject: Re: [PATCH 5/5] configure.ac: upgrade to a compilation check for
 sysinfo
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-5-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-6-ramsay@ramsayjones.plus.com>
 <9baad29d-a5bf-443d-98a1-36d7020e5835@gentoo.org>
 <56706ad8-93c6-48cd-ad16-9d8b00a669c9@ramsayjones.plus.com>
In-Reply-To: <56706ad8-93c6-48cd-ad16-9d8b00a669c9@ramsayjones.plus.com>

--------------p4MgkAH0Z1T00ivg8vYDvT7E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5/8/25 7:01 PM, Ramsay Jones wrote:
>> So you are indeed teaching autoconf to check for this function, but
>> should we also ask whether it's worth continued maintenance of autocon=
f?
>> It was/is not clear to me who the stakeholders are for the autoconf su=
pport.
>=20
> Hmm, someone posted a list of people using autoconf somewhat recently
> to the mailing-list ... I don't have it to hand, but cygwin was one
> of the projects using it.


Thanks for the correction. This solves my major concern...


>> On the other hand, it sounds like this patch (and commit 50dec7c566
>> "config.mak.uname: add sysinfo() configuration for cygwin") only modif=
y
>> autoconf out of a sense of duty, rather than finding autoconf useful.
>=20
> Hmm, I am not convinced (yet) that meson is all that useful either. ;)
> =20
>> What does it say about the autoconf support if the people finding bugs=

>> in it don't even use it, but only discovered the bug while working on =
a
>> different build system they do use and depend on (config.mak.uname, or=

>> meson.build, both count here).
>=20
> I am trying very hard not to express a view on this debate. :)
>=20
> [well, except that I find CMake to be absolutely awful!]



=2E.. because to my way of thinking, the ultimate proof of usefulness is
that people, well, *use* it. Gentoo uses Meson, ipso facto it is useful. =
:)

=46rom my experience with the ./configure script it wasn't clear to *me*
that anyone did use it (and I did a non-exhaustive check of other
distributors). If cygwin uses it, it is useful and the question becomes
*whether* to (properly) deprecate it after evaluating the existing
options and balancing use cases with maintenance burden, rather than
"just let it rot until we finish discussing its likely deletion".


I'm still not volunteering to do the actual fixing of ./configure :D but
testing is easy if someone else wrote the fix...


--=20
Eli Schwartz

--------------p4MgkAH0Z1T00ivg8vYDvT7E--

--------------65yeUprQpdZbyJtMY7FuPfUi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaCZL9wUDAAAAAAAKCRCEp9ErcA0vV9OX
AQCfyBYVZu+B9J8XLVkLSVEhB2WLG3bc/Vpfcth8XrjQWQEAk4zaRSKGvidXBPQsbyI01rAfcU/d
H5uHjRFhqFUKzAg=
=ArjJ
-----END PGP SIGNATURE-----

--------------65yeUprQpdZbyJtMY7FuPfUi--
