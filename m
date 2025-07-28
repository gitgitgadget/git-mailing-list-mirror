Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA621D59B
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753732592; cv=none; b=Iu33o5x3Zg5KpdgqHDGL8PpY4Pkfm8TocfAK3CnwoCey/mVy8mc2XaON+dd7on0dfc3DhI5hHTQF3HlMlOF0jP3j1DUDZY3VbGI+A54+69UWq5wBwum0MA3hJ8haN680jRzgvoEEV13YhPyHxxFJoBu/7MlJTL6Grn9d9VT9MVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753732592; c=relaxed/simple;
	bh=ARxOn3VPp3WVvxWQCNrNYuQLPtRRWRZCbqqhxKbjHsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIeIrmsOVrdl/agEvOWVx9uiHKWqMl4vnH0xj+pulEtwU91JyA2e7q15xUVjGrP4gnMtFEbEPGfTGuwvs/jNZaczIcVnp717sv09jOgr/DMFi2cKBhKZlai+hgTDe/FxrpBYglvpkMwbT95UU4PcK9a8nkoSBlquku/3nnhSD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:cf90::12ac] (unknown [IPv6:2603:6011:3f0:cf90::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 1FE6233FE7D;
	Mon, 28 Jul 2025 19:56:27 +0000 (UTC)
Message-ID: <2e70fce9-1779-4d35-ae65-42792e710054@gentoo.org>
Date: Mon, 28 Jul 2025 15:56:21 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] optimize string hashing in xdiff
To: Junio C Hamano <gitster@pobox.com>, Alexander Monakov <amonakov@ispras.ru>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20250728190520.10962-1-amonakov@ispras.ru>
 <xmqqa54oun5w.fsf@gitster.g>
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
In-Reply-To: <xmqqa54oun5w.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cOQa8Re0QHmDmYpTXiL0ndt0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cOQa8Re0QHmDmYpTXiL0ndt0
Content-Type: multipart/mixed; boundary="------------dpghZWbqynE3iqWKkr3OppXC";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>, Alexander Monakov <amonakov@ispras.ru>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <2e70fce9-1779-4d35-ae65-42792e710054@gentoo.org>
Subject: Re: [PATCH 0/2] optimize string hashing in xdiff
References: <20250728190520.10962-1-amonakov@ispras.ru>
 <xmqqa54oun5w.fsf@gitster.g>
In-Reply-To: <xmqqa54oun5w.fsf@gitster.g>

--------------dpghZWbqynE3iqWKkr3OppXC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/28/25 3:32 PM, Junio C Hamano wrote:

>> The additive variant of the djb2 hash is used in ELF symbol lookup, an=
d
>> Noah Goldstein contributed a well-optimized implementation to Glibc.
>=20
> What is the licensing terms for that code you are proposing us to
> borrow?  If it is anything recent in GNU, I'd expect that it would
> be GPLv3, which would be incompatible with our code base?


That feels like a quite surprising assessment. Many GNU projects make
specific calculations here. See:

https://www.gnu.org/licenses/gpl-faq.html#DoesAllGNUSoftwareUseTheGNUGPLA=
sItsLicense

https://www.gnu.org/licenses/why-not-lgpl.html


At any rate, quite untrue. Glibc's wikipedia page -- and also its source
code, luckily -- documents "LGPL-2.1-or-later", which is more permissive
than git (and equally as permissive as xdiff).

Reason is documented in the second link. :)


--=20
Eli Schwartz

--------------dpghZWbqynE3iqWKkr3OppXC--

--------------cOQa8Re0QHmDmYpTXiL0ndt0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaIfV5QUDAAAAAAAKCRCEp9ErcA0vV8rh
AP9Lwp/8b2V9B3s/3ulbpMTSSaz/4SAWAb7uH+JiWfxlOQEApHQK0K4Yf+MkZ+8D3QgqBZGZ3ZUT
5/9Vuj8ThzvYbAU=
=Nz5k
-----END PGP SIGNATURE-----

--------------cOQa8Re0QHmDmYpTXiL0ndt0--
