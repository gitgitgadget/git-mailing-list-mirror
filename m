Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7272C08A1
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752544533; cv=none; b=NA8q2dnp6FzqTtGUibfxUMakdh70c3vDh1ja7romW2oeUpZ/M5EH2i0h0sZXjWMrQ2TFp2UbG2scIEJeoSUIZNd9wAwgw5mUVEl3A0nNUwRDFO0+nzVPxQHj+O2e3EBqGdAFcSKeT7rOUKT2B/fSIZH8PHELSBeJXURsVLX3dwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752544533; c=relaxed/simple;
	bh=JKiL5guze9KrNHqu0yYyG8TBkI4o3kdCsE/Tw5/qlvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJI+1tB2YxBI9xFOh9vOruRy2qInEwcySFDzlxS1+789JXiV1QkNIaRsoG3tpRVmS51B35MKnfE7Et8rwTYBa1KhvSFC5kqcoeNkIfHugNxlnplBUNFPnH7xez0vj+u8xDe0VBC0oAZhKHuc7RTuSSZwzSbq2f4D3cAXGLetFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9B7C3340CE7;
	Tue, 15 Jul 2025 01:55:30 +0000 (UTC)
Message-ID: <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org>
Date: Mon, 14 Jul 2025 21:55:27 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] meson: disable PCRE2 dependency by default in macOS
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, sandals@crustytoothpaste.net
References: <20250713122341.17976-1-carenas@gmail.com>
 <20250713174807.32444-1-carenas@gmail.com>
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
In-Reply-To: <20250713174807.32444-1-carenas@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------z8s0aQ0TrbkS1kOLzA0UR7Pb"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------z8s0aQ0TrbkS1kOLzA0UR7Pb
Content-Type: multipart/mixed; boundary="------------ixzsi1RPbcutmnojM5qGbXLS";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, sandals@crustytoothpaste.net
Message-ID: <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org>
Subject: Re: [PATCH v3] meson: disable PCRE2 dependency by default in macOS
References: <20250713122341.17976-1-carenas@gmail.com>
 <20250713174807.32444-1-carenas@gmail.com>
In-Reply-To: <20250713174807.32444-1-carenas@gmail.com>

--------------ixzsi1RPbcutmnojM5qGbXLS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/13/25 1:48 PM, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> Makefile requires the user to provide the USE_LIBPCRE2 flag to
> enable this dependency, but meson has it enabled by default,
> which can be problematic, at least in macOS.
>=20
> macOS provides a PCRE2 library in base that is not usable and not
> configured properly, as it installs a pkgconf module that
> points to a non existent pcre2.h header in /usr/local/include.
>=20
> Add an option that will need to be turned to true once an
> alternative PCRE2 library is installed (which hopefully provides
> its own pkgconf module earlier in PKG_CONFIG_PATH) or meson has
> been instructed to use its subproject as a suitable dependency
> by `--force-fallback-for=3Dpcre2`.


I cannot possibly agree with any part of this. Right bug report, wrong
patch.

Problem:

Meson supports three modes:

- require pcre2 and fail if missing

- automatically, optimistically use it if possible

- disable and reject it even if available


macOS has a problem:

- pcre2 (in modes 1 and 2) is detected as available via a system
  package, but upon successfully configuring a ninja file, the compile
  fails


Solution proposed here:

- v1: switch default mode from "enabled" to "disabled", leaving feature
  broken if anyone tries it out

- v2 / v3: switch default mode from "enabled" to "auto", then ignoring
  the config setting by default, and permitting users to use an ugly
  "are you sure" option to get... a failing build.



Nowhere are we checking what we got. Trying to build with pcre2 will
fail in confusingly awkward ways at the worst time: compile time. We
don't need a build option here to ask for this bad experience -- we
should just get it correct. :)

The goal should be, if the pcre2 feature is:

- enabled, meson should *fail early* if the demand cannot be met,
  providing a clear explanation of what is wrong

- auto, meson should *detect* it cannot work and build without it


> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  meson.build       | 3 ++-
>  meson_options.txt | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/meson.build b/meson.build
> index 7fea4a34d6..e1475be6c8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1055,7 +1055,8 @@ else
>    build_options_config.set('NO_ICONV', '1')
>  endif
> =20
> -pcre2 =3D dependency('libpcre2-8', required: get_option('pcre2'), defa=
ult_options: ['default_library=3Dstatic', 'test=3Dfalse'])
> +pcre2_feature =3D get_option('pcre2').disable_auto_if(host_machine.sys=
tem() =3D=3D 'darwin' and not get_option('macos_workaround_system_pcre2')=
)
> +pcre2 =3D dependency('libpcre2-8', required: pcre2_feature, default_op=
tions: ['default_library=3Dstatic', 'test=3Dfalse'])
>  if pcre2.found()
>    libgit_dependencies +=3D pcre2
>    libgit_c_args +=3D '-DUSE_LIBPCRE2'


Instead of disable_auto_if, we should simply verify a working install.

if pcre2.found() and pcre2.type_name() !=3D 'internal' and
host_machine.system() =3D=3D 'darwin'
    # macOS installs a broken system package, double check
    if not compiler.has_header('pcre2.h', dependencies: pcre2)
        if get_option('pcre2').enabled()
            error('broken pcre2 install found but pcre2 is required')
        endif
        # Replace with not-found-dependency
        pcre2 =3D dependency('', required: false)
        warning('broken pcre2 install found, disabling pcre2 feature')
    endif
endif

if pcre2.found()
    libgit_dependencies +=3D pcre2

[...]


Please double-check my work, that this compiler.has_header() is
sufficient on your reproducer system to detect and disable the
non-working feature.


> diff --git a/meson_options.txt b/meson_options.txt
> index e7f768df24..f63ff32556 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -45,7 +45,7 @@ option('gitweb', type: 'feature', value: 'auto',
>    description: 'Build Git web interface. Requires Perl.')
>  option('iconv', type: 'feature', value: 'auto',
>    description: 'Support reencoding strings with different encodings.')=

> -option('pcre2', type: 'feature', value: 'enabled',
> +option('pcre2', type: 'feature', value: 'auto',


This part is fine. We shouldn't default-fail if it isn't found, when we
can't expect it to be universally available.


>    description: 'Support Perl-compatible regular expressions in e.g. gi=
t-grep(1).')
>  option('perl', type: 'feature', value: 'auto',
>    description: 'Build tools written in Perl.')
> @@ -73,6 +73,8 @@ option('breaking_changes', type: 'boolean', value: fa=
lse,
>    description: 'Enable upcoming breaking changes.')
>  option('macos_use_homebrew_gettext', type: 'boolean', value: true,
>    description: 'Use gettext from Homebrew instead of the slightly-brok=
en system-provided one.')
> +option('macos_workaround_system_pcre2', type: 'boolean', value: false,=

> +  description: 'A working PCRE2 library is available or will be provid=
ed by a subproject.')
> =20
>  # gitweb configuration.
>  option('gitweb_config', type: 'string', value: 'gitweb_config.perl')


--=20
Eli Schwartz

--------------ixzsi1RPbcutmnojM5qGbXLS--

--------------z8s0aQ0TrbkS1kOLzA0UR7Pb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaHW1EAUDAAAAAAAKCRCEp9ErcA0vVyXt
AQDFJzqADHNUZq2jqhXD3zheHOE2NCx5eMOn8mV7Dkv9KwD/V01IQha2YydIsygZpax+7VkUnh7U
TVeBCgiWU/C5VQo=
=ywkx
-----END PGP SIGNATURE-----

--------------z8s0aQ0TrbkS1kOLzA0UR7Pb--
