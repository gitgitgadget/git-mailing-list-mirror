Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD37F2E4987
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481167; cv=none; b=kmchMp6ca6/q42XOPm8lzB/474voZcl7oOH3aNKT7awtpONX+i6J45L2lNJ1x84VqTFHo6/A6vgDr9VUCP/R05XZd2CcJLmYjzqz8sUqBINs8XxwXrSuX1DIwHEq4Q3kZTP6+KA/HsMp6hu0VlMAVK8pnT59roRl8AcwbqfhJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481167; c=relaxed/simple;
	bh=oRCul9O/pml4bMIERGxaoRhpf5v3SiKH451lTOFx0VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qqx3e5N2rL3SiBqrM2jQfX8LFFEGZvsMMV8TnEUAZ0EE4tu9DMrRq5Vl/BCnvpVnU1aQaGZf/CGoQFPYwoQbADpAUIPdU9qyEeaOgUKyC8NCWfjBbk8eNziYpkvTvSE5vxG+mYX6lq6desi8PxdXZimvJf1JaP+8BMLorgYruQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id A6099340D30;
	Wed, 02 Jul 2025 18:32:44 +0000 (UTC)
Message-ID: <b57b1418-2179-480c-92a3-a107388d71f2@gentoo.org>
Date: Wed, 2 Jul 2025 14:32:40 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Renato Botelho <garga@FreeBSD.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 GIT Mailing-list <git@vger.kernel.org>
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
 <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
 <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
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
In-Reply-To: <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------teeaNQwVJBNCTDqr5tFUZunx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------teeaNQwVJBNCTDqr5tFUZunx
Content-Type: multipart/mixed; boundary="------------R3r804bScMyGEiEHkI1R1wN7";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Renato Botelho <garga@FreeBSD.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 GIT Mailing-list <git@vger.kernel.org>
Message-ID: <b57b1418-2179-480c-92a3-a107388d71f2@gentoo.org>
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
 <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
 <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
In-Reply-To: <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>

--------------R3r804bScMyGEiEHkI1R1wN7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/1/25 4:03 PM, Ramsay Jones wrote:

> The patch is below. (I didn't write a commit message ;) ).
>=20
> Does this work for you?
>=20
> ATB,
> Ramsay Jones
>=20
> ---- >8 ----
> From: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Date: Tue, 1 Jul 2025 20:33:44 +0100
> Subject: [PATCH] build: fix FreeBSD sysinfo build failure
>=20
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  configure.ac | 61 ++++++++++++++++++++++++++++++----------------------=

>  meson.build  | 10 +++++----
>  2 files changed, 41 insertions(+), 30 deletions(-)

> diff --git a/meson.build b/meson.build
> index 7fea4a34d6..355cad730c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1331,10 +1331,6 @@ if host_machine.system() !=3D 'windows'
>    endif
>  endif
> =20
> -if compiler.has_member('struct sysinfo', 'totalram', prefix: '#include=
 <sys/sysinfo.h>')
> -  libgit_c_args +=3D '-DHAVE_SYSINFO'
> -endif
> -
>  if compiler.has_member('struct stat', 'st_mtimespec.tv_nsec', prefix: =
'#include <sys/stat.h>')
>    libgit_c_args +=3D '-DUSE_ST_TIMESPEC'
>  elif not compiler.has_member('struct stat', 'st_mtim.tv_nsec', prefix:=
 '#include <sys/stat.h>')
> @@ -1449,6 +1445,12 @@ if compiler.has_header('sys/sysctl.h')
>    endif
>  endif
> =20
> +if not has_bsd_sysctl
> +  if compiler.has_member('struct sysinfo', 'totalram', prefix: '#inclu=
de <sys/sysinfo.h>')
> +    libgit_c_args +=3D '-DHAVE_SYSINFO'
> +  endif
> +endif
> +
>  if not meson.is_cross_build() and compiler.run('''
>    #include <stdio.h>


This seems reasonable to me. has_member only does a compile-check, not
linkage, so we can't know if it's a BSD port. Only using it when a
previously checked interface can't be found, lets us avoid doing
extraneous work though.


--=20
Eli Schwartz

--------------R3r804bScMyGEiEHkI1R1wN7--

--------------teeaNQwVJBNCTDqr5tFUZunx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaGV7SQUDAAAAAAAKCRCEp9ErcA0vV25W
AQDWwtRVULL1hvEr1cyFCNPp1B3tzHsdxf6xOvS791GNfgD/TKSuP9Fq5FCRRm0Ihnf79OX/te5C
MndpPbteWhX57gM=
=VRis
-----END PGP SIGNATURE-----

--------------teeaNQwVJBNCTDqr5tFUZunx--
