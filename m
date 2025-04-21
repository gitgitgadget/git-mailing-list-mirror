Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258ECD530
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745265877; cv=none; b=e53WmHAnmRN8OWVSWuPYjPXtyG3AlHxCE3z2fLtM9dDc8ENSUo6vKnAkCbasB7dpb/JEz1676lItzp/nqAzbzGs/WdzBKpH2pKsBylCl7ZCmb2UfbqbBqOSa5xhqzPfGhERrof4B7AczFwyK8CX5eDEbH/jKCnI8CxsrtzYaT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745265877; c=relaxed/simple;
	bh=vkR4HZdXuGGXCQEdk0fKqoEK6vmzyznn/Q3K+nd+DN8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WDIRRi8bBj/iqAVjmaF5Zo8T8kVi5fW71C3WYtkB48qNp/aFi1KW6QhzMTr8/yvFNv/VGgGt6+DEZgRkdrQlITlcwvbjWTizI0Hq1JVeCfjJAcFzE38IGghwOkzPb5qEejAMVZXm8ICgT3H1WQRCUpDTVQ+5uMUgm5Mb7Zh3bjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6E654342FF3;
	Mon, 21 Apr 2025 20:04:33 +0000 (UTC)
Message-ID: <83d9fda5-8399-47fb-87b2-a8b376cf1625@gentoo.org>
Date: Mon, 21 Apr 2025 16:04:30 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] meson: simplify and parameterize various standard
 function checks
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>, Patrick Steinhardt <ps@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
Content-Language: en-US
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <20250421175247.240971-1-eschwartz@gentoo.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vNq8VCovP8gJ0Nm0lXAqCQ2F"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vNq8VCovP8gJ0Nm0lXAqCQ2F
Content-Type: multipart/mixed; boundary="------------3uMDl0jjTBfxIQjzkBCbpyHk";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>, Patrick Steinhardt <ps@pks.im>
Message-ID: <83d9fda5-8399-47fb-87b2-a8b376cf1625@gentoo.org>
Subject: Re: [PATCH 1/6] meson: simplify and parameterize various standard
 function checks
References: <20250421175247.240971-1-eschwartz@gentoo.org>
In-Reply-To: <20250421175247.240971-1-eschwartz@gentoo.org>

--------------3uMDl0jjTBfxIQjzkBCbpyHk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/21/25 1:51 PM, Eli Schwartz wrote:
> This is repetitive logic. We either want to use some -lc function, or i=
f
> it is not available we define it as -DNO_XXX and usually (but not
> always) provide some custom compatibility impl instead.
>=20
> Checking the intent of each block when reading through the file is slow=

> and not very DRY. Switch to taking an array of checkable functions
> instead.
>=20
> Not all functions are straightforward to move, since different macro
> prefixes are used.


By the way, when reviewing this I was having a slightly hard time
figuring out which stuff belonged here... specifically, because of the
differences in macro prefixes lead me to believe it's not always so
simple as "does it exist".



> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
> ---
>  meson.build | 73 ++++++++++++++++++++++-------------------------------=

>  1 file changed, 30 insertions(+), 43 deletions(-)
>=20
> diff --git a/meson.build b/meson.build
> index c47cb79af0..6c147c22a4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1290,23 +1290,40 @@ if not compiler.has_member('struct passwd', 'pw=
_gecos', prefix: '#include <pwd.h
>    libgit_c_args +=3D '-DNO_GECOS_IN_PWENT'
>  endif
> =20
> -if compiler.has_function('sync_file_range')
> -  libgit_c_args +=3D '-DHAVE_SYNC_FILE_RANGE'
> -endif
> +checkfuncs =3D [
> +  'strcasestr',
> +  'memmem',
> +  'strlcpy',
> +  # no compat
> +  'strtoull',
> +  'setenv',
> +  'mkdtemp',
> +  # no compat
> +  'initgroups',
> +]
> =20
> -if not compiler.has_function('strcasestr')
> -  libgit_c_args +=3D '-DNO_STRCASESTR'
> -  libgit_sources +=3D 'compat/strcasestr.c'
> +if host_machine.system() =3D=3D 'windows'
> +  libgit_c_args +=3D '-DUSE_WIN32_MMAP'
> +else
> +  checkfuncs +=3D [
> +    'mmap',
> +    # unsetenv is provided by compat/mingw.c.
> +    'unsetenv',
> +  ]
>  endif
> =20
> -if not compiler.has_function('memmem')
> -  libgit_c_args +=3D '-DNO_MEMMEM'
> -  libgit_sources +=3D 'compat/memmem.c'
> -endif
> +foreach func: checkfuncs
> +  if not compiler.has_function(func)
> +    libgit_c_args +=3D '-DNO_' + func.to_upper()
> +    impl =3D 'compat/' + func + '.c'
> +    if fs.exists(impl)
> +      libgit_sources +=3D impl
> +    endif
> +  endif
> +endforeach
> =20
> -if not compiler.has_function('strlcpy')
> -  libgit_c_args +=3D '-DNO_STRLCPY'
> -  libgit_sources +=3D 'compat/strlcpy.c'
> +if compiler.has_function('sync_file_range')
> +  libgit_c_args +=3D '-DHAVE_SYNC_FILE_RANGE'
>  endif
> =20
>  if not compiler.has_function('strdup')
> @@ -1322,45 +1339,15 @@ if not compiler.has_function('strtoumax')
>    ]
>  endif
> =20
> -if not compiler.has_function('strtoull')
> -  libgit_c_args +=3D '-DNO_STRTOULL'
> -endif
> -
> -if not compiler.has_function('setenv')
> -  libgit_c_args +=3D '-DNO_SETENV'
> -  libgit_sources +=3D 'compat/setenv.c'
> -endif
> -
>  if not compiler.has_function('qsort')
>    libgit_c_args +=3D '-DINTERNAL_QSORT'
>  endif
>  libgit_sources +=3D 'compat/qsort_s.c'


=2E.. for example, the Makefile says here:


# Define INTERNAL_QSORT to use Git's implementation of qsort(), which
# is a simplified version of the merge sort used in glibc. This is
# recommended if Git triggers O(n^2) behavior in your platform's
# qsort().

cmake unconditionally defines it (???)

config.mak.uname says:

- AIX:
  INTERNAL_QSORT =3D UnfortunatelyYes

  Seems to date back to commit 377d9c409ffe0f0d994b929aeb94716139207b9d.
  "Unfortunate" indeed.


- MinGW:
  INTERNAL_QSORT =3D YesPlease

  Windows claims to have a qsort but perhaps it is very slow and bes
  avoided?

We should probably stop *checking* for qsort and simply encode the
platforms we know are slow and automatically skip it there. Can I get
confirmation regarding Windows? :)


> -# unsetenv is provided by compat/mingw.c.
> -if host_machine.system() !=3D 'windows' and not compiler.has_function(=
'unsetenv')
> -  libgit_c_args +=3D '-DNO_UNSETENV'
> -  libgit_sources +=3D 'compat/unsetenv.c'
> -endif
> -
> -if not compiler.has_function('mkdtemp')
> -  libgit_c_args +=3D '-DNO_MKDTEMP'
> -  libgit_sources +=3D 'compat/mkdtemp.c'
> -endif
> -
> -if not compiler.has_function('initgroups')
> -  libgit_c_args +=3D '-DNO_INITGROUPS'
> -endif
> -
>  if compiler.has_function('getdelim')
>    libgit_c_args +=3D '-DHAVE_GETDELIM'
>  endif


But stuff like this, why isn't it consistent with the other functions?
What's the difference between HAVE_XXX and NO_XXX?


> -if host_machine.system() =3D=3D 'windows'
> -  libgit_c_args +=3D '-DUSE_WIN32_MMAP'
> -elif not compiler.has_function('mmap')
> -  libgit_c_args +=3D '-DNO_MMAP'
> -  libgit_sources +=3D 'compat/mmap.c'
> -endif
> =20
>  if compiler.has_function('clock_gettime')
>    libgit_c_args +=3D '-DHAVE_CLOCK_GETTIME'



--=20
Eli Schwartz

--------------3uMDl0jjTBfxIQjzkBCbpyHk--

--------------vNq8VCovP8gJ0Nm0lXAqCQ2F
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaAakzgUDAAAAAAAKCRCEp9ErcA0vV6F5
AQCKQBczqln8tRAVWv+mlsYWABwAOh991SrFU3ZxH75F0wD8CralAD6CYkqrcdvFaVLnJwtMagNa
sGMWqHgzowbfDQU=
=CzSW
-----END PGP SIGNATURE-----

--------------vNq8VCovP8gJ0Nm0lXAqCQ2F--
