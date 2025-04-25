Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80959A29
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745539600; cv=none; b=JnBlQwhQLy+XHruQ075r9SJJI8uRa+0EpwlfA2VgZ+09tNdc69UqBu/k+qg8A6kobT4jZ4r8aFNvCjsO33FMgF1FwSiaaGn+9xohRXuv/cqNy4LMnI5eb4zHGzLbFIeeu/aUFIDRBFky8E3BiCytljHgNB5opz5oJvaY0Ca9w2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745539600; c=relaxed/simple;
	bh=+iL8LEzAGfjsQ50R1qq06zeFjxgM8uDJnLAHKyHhdGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YP8bPqKjkHn5GNK1GivmRYUsiH0cYohcLZD7v4osGAkxQgbWEIYP2mfk7Pu4XSsxj3/9ihLTio4wcUITaMbDiIAhQAvsCZmDR4qNM85OPTu6EufyE9Adi/Ukfh7E9vFrvvcY1GOQuIl1gpGP0IYWsLT/lY3DhZSVNi/dyeR2zB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 61B8B340CBB;
	Fri, 25 Apr 2025 00:06:38 +0000 (UTC)
Message-ID: <83897914-0b97-4a1d-b2aa-714d42043e63@gentoo.org>
Date: Thu, 24 Apr 2025 20:06:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] meson: check for getpagesize before using it
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>,
 Patrick Steinhardt <ps@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250421175247.240971-2-eschwartz@gentoo.org> <xmqqecxhruin.fsf@gitster.g>
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
In-Reply-To: <xmqqecxhruin.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SyDkVuP2ksHO7GMgfmIf7LhN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------SyDkVuP2ksHO7GMgfmIf7LhN
Content-Type: multipart/mixed; boundary="------------y2d4ujJwhde8PHCy8SWEW94m";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>,
 Patrick Steinhardt <ps@pks.im>
Message-ID: <83897914-0b97-4a1d-b2aa-714d42043e63@gentoo.org>
Subject: Re: [PATCH 2/6] meson: check for getpagesize before using it
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250421175247.240971-2-eschwartz@gentoo.org> <xmqqecxhruin.fsf@gitster.g>
In-Reply-To: <xmqqecxhruin.fsf@gitster.g>

--------------y2d4ujJwhde8PHCy8SWEW94m
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/24/25 7:48 PM, Junio C Hamano wrote:
> Eli Schwartz <eschwartz@gentoo.org> writes:
>=20
>> It is deprecated and removed in SUS v3 / POSIX 2001, so various system=
s
>> may not include it. Solaris, in particular, carefully refrains from
>> defining it except inside of a maze of `#ifdef` to make sure you have
>> kept your nose clean and only used it in code that *targets* SUS v2 or=

>> earlier.
>>
>> config.mak.uname defines this automatically, though only for QNX.
>>
>> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
>> ---
>>  meson.build | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 6c147c22a4..f5d9ffcd7f 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1300,6 +1300,8 @@ checkfuncs =3D [
>>    'mkdtemp',
>>    # no compat
>>    'initgroups',
>> +  # no compat
>> +  'getpagesize',
>>  ]
>> =20
>>  if host_machine.system() =3D=3D 'windows'
>=20
> Is this related to this breakge we started seeing for 'seen'
> recently?
>=20
> https://github.com/git/git/actions/runs/14653573748/job/41124519642


Yes.

compat/mingw.c defines mingw_getpagesize, and posix.h defines -- when
the function is detected as missing:

#define getpagesize()  sysconf(_SC_PAGESIZE)


That means we can't check for it on mingw or we end up with two
definitions. I will move it to the else block in:

if host_machine.system() =3D=3D 'windows'
  libgit_c_args +=3D '-DUSE_WIN32_MMAP'
else



--=20
Eli Schwartz

--------------y2d4ujJwhde8PHCy8SWEW94m--

--------------SyDkVuP2ksHO7GMgfmIf7LhN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaArSCwUDAAAAAAAKCRCEp9ErcA0vV8mx
AP48X/DA1GqhZtnCf+5VNdCOc7qBupW2fbsyS9fm5mpFUAEAov3ykYAg5JbNajBPtXEaPSdx13nr
GA2s0niLzwXoFQU=
=L9v9
-----END PGP SIGNATURE-----

--------------SyDkVuP2ksHO7GMgfmIf7LhN--
