Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219162ED171
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703808; cv=none; b=gZSygFfwB4jXGfan27NbN4uNmA4lsVu+B0CHD8L5bTLdVV+M/Lfw1AaX6Bx9Pim+htdzEKho76KziBqDoXvjfMUH0QYmX9p+kQQRZmtrKzB7ffryEYNgkOskXJ+HtiA9eU6rBnOow0AGZHUg6lo5CqQ0Myka4VWrli1Ipx/vXh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703808; c=relaxed/simple;
	bh=Y0YYR+cGKCQzF7lvZnRdZqfd2g8fpOblZwzTlPAiMFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv8/jHCudRFLnK3uOOSq9W4dE8JJ9j3MtCCn7dmdfmlKUvAJAOGavWpYRHY7MvJVAZq+ggclzfhqQ1YJMk6UtumwmO/AwA92I2c5PeUxzzepPAYrpyXiMUbJHncajazh1Lr4lj0FhZoLNiIcxmNZ31p7LCF6AAtRUT/ivvuikWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id F0F28340200;
	Wed, 16 Jul 2025 22:10:05 +0000 (UTC)
Message-ID: <629a1c11-fceb-4f25-a917-319a99bfed57@gentoo.org>
Date: Wed, 16 Jul 2025 18:10:01 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] meson: work around broken system PCRE2 dependency in
 macOS
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, sandals@crustytoothpaste.net,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20250715114407.37955-1-carenas@gmail.com>
 <20250716193000.44673-1-carenas@gmail.com>
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
In-Reply-To: <20250716193000.44673-1-carenas@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------b0aVQNUySAE309eMcAHkMC3A"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------b0aVQNUySAE309eMcAHkMC3A
Content-Type: multipart/mixed; boundary="------------Mwd9ikY0Wr97bvFX0JagIb04";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, sandals@crustytoothpaste.net,
 Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <629a1c11-fceb-4f25-a917-319a99bfed57@gentoo.org>
Subject: Re: [PATCH v5] meson: work around broken system PCRE2 dependency in
 macOS
References: <20250715114407.37955-1-carenas@gmail.com>
 <20250716193000.44673-1-carenas@gmail.com>
In-Reply-To: <20250716193000.44673-1-carenas@gmail.com>

--------------Mwd9ikY0Wr97bvFX0JagIb04
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/16/25 3:30 PM, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> +if pcre2.found() and pcre2.type_name() !=3D 'internal' and host_machin=
e.system() =3D=3D 'darwin'
> +  # macOS installs a broken system package, double check
> +  if not compiler.has_header('pcre2.h', dependencies: pcre2)
> +    if pcre2_feature.enabled()
> +      # Attempt to fallback, method can't be pkg-config=20
> +      pcre2 =3D dependency('libpcre2-8', method: 'builtin', default_op=
tions: ['default_library=3Dstatic', 'test=3Dfalse'])
> +      if not pcre2.found()
> +        error('only a broken pcre2 install found and pcre2 is required=
')


If you want to override the message from a specific dependency() call,
"required" defaults to true and aborts on the line before
"if not pcre2.found()"


You could do:
https://mesonbuild.com/Reference-manual_functions.html#dependency_not_fou=
nd_message


not_found_message: 'only a broken pcre2 install found and pcre2 is requir=
ed'

Alternatively, required: false followed by if not pcre2.found() -->
error(). But you will need "allow_fallback: true" as I responded in a
previous message.


--=20
Eli Schwartz

--------------Mwd9ikY0Wr97bvFX0JagIb04--

--------------b0aVQNUySAE309eMcAHkMC3A
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaHgjOQUDAAAAAAAKCRCEp9ErcA0vV28x
APsEZn0T1x1EIILcV7gM3M1pbD1OK3SbI22rUbKpwhgtEAD7Bd28DE0qJbPojZ0ovND0XxaaeKKm
DyStb9nrj+RDJA8=
=P3qN
-----END PGP SIGNATURE-----

--------------b0aVQNUySAE309eMcAHkMC3A--
