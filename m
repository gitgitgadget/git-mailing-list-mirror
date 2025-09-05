Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185753705B5
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083101; cv=none; b=pnYLLbfZ6AXp18fzE5uxM0Hcn1CFcZ5FurDzJC1jh20eKigL4vbnLJ+0blQu9ZrUSKwwVD2KhnK9YF0sK2cTkiwI7MUBA7PJ2Fb4h74jiX+yDQ1md1Y0iyZPaSYaicN9SisLSWduh8L2Q7z6GjEIa4MVC0twpU5FaE6qXpjk+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083101; c=relaxed/simple;
	bh=qwSMfPyRCjFvnk6RPb72aUpp6ho4Z2syTbBozACUAWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oh15X108ESUm4O7G8tE+UrFQH2+kvOScp+e2vKjLPmkvIX4wUS11HeVNwvel+vH0kxuxO8Hh2Gr38LzrS2JhAGYVAKyn+zJO+Lh18n1z+DFSdUx6YOSFuyK0yBouf6rpXF/UPqp4kyu78Iow8b40aSAnCeCrVJf04glFCvBM4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:cf90::12ac] (unknown [IPv6:2603:6011:3f0:cf90::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 0BAB23408F0;
	Fri, 05 Sep 2025 14:38:17 +0000 (UTC)
Message-ID: <9fcda14f-d4d4-4db4-ae77-d9408bfae035@gentoo.org>
Date: Fri, 5 Sep 2025 10:38:16 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming
 mandatory
To: Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Matthias_A=C3=9Fhauer?=
 <mha1993@live.de>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
 <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
 <aLrnwOGKaAjLj0Bo@pks.im>
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
In-Reply-To: <aLrnwOGKaAjLj0Bo@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zTPbH7zvzf5uq7f1pVGPDzjN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zTPbH7zvzf5uq7f1pVGPDzjN
Content-Type: multipart/mixed; boundary="------------yt7OLIwUy7zUAHo2NcgKh8a1";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Matthias_A=C3=9Fhauer?=
 <mha1993@live.de>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Message-ID: <9fcda14f-d4d4-4db4-ae77-d9408bfae035@gentoo.org>
Subject: Re: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming
 mandatory
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
 <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
 <aLrnwOGKaAjLj0Bo@pks.im>
In-Reply-To: <aLrnwOGKaAjLj0Bo@pks.im>

--------------yt7OLIwUy7zUAHo2NcgKh8a1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/5/25 9:38 AM, Patrick Steinhardt wrote:

>> Do we want to commit to promising support until gccrs is ready? What i=
f
>> gccrs ends up abandoned? Or takes an unexpectedly long time to reach a=
 stage
>> where it can build Git? It might make sense to give this LTS release a=
 time
>> limit instead, or in addidtion.
>=20
> Yeah, I wasn't quite clear on that one, either. An alternative:
>=20
>   - We will maintain the LTS release for 8 release cycles, which equate=
s
>     to roughly two years. It sounds like a lot, but recent security
>     releases have stretched quite far into the past.
>=20
>   - If there are still dependents after these two years we will hand
>     over maintainership of the LTS branch to dependents. So they will b=
e
>     responsible for the backporting.
>=20
> This really only is a suggestion though. I'm especially waiting for
> Junio's feedback here to see whether he thinks that this is a reasonabl=
e
> thing to do.


This seems reasonable to me -- people who still need that LTS should be
allowed to ensure it still works, and be expected to commit to the bit
-- but with the emphasis that I would consider it absolutely mandatory
that the git project accepts to host that branch, and it won't just
exist in some other shadowy corner of the internet.


--=20
Eli Schwartz

--------------yt7OLIwUy7zUAHo2NcgKh8a1--

--------------zTPbH7zvzf5uq7f1pVGPDzjN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaLr12AUDAAAAAAAKCRCEp9ErcA0vVwK7
AP47MKfCbzfueMpvLIKRn2F6MuM1kCEW1BpgYtDt9kZfKAD8Dr+7l2pjMHKMcGlVnwXr+eH1QIsc
m9WZWVhd9OsdUQA=
=CP6u
-----END PGP SIGNATURE-----

--------------zTPbH7zvzf5uq7f1pVGPDzjN--
