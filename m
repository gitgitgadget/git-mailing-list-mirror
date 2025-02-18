Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59926AABB
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889738; cv=none; b=rOb3yZDcfwffUmUo+Jr05rFP/CcHAj54n/vGr7EIV4MYBfYEjAPLjNyY3aQTJlTpLbulwe/PA7Jb53I+R31yJMagOOyP44meyBeHJeCzRZ/eTadjTCNvBo8sZaMdmwLoj8uH0ZcglEu4xYrx85TtX00UCDXrDfVQ/ilJmPVerug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889738; c=relaxed/simple;
	bh=HRJxWsOQ7hYnWzEgkTqI8aRL6T8B1EoMwf67qbGhKcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IR2q2xw3dH4CHZAhufoc9c8y810EmBRBnY2YZIdRooXD7CCzz6sLRP6CT7tLcrifQXhJfwxxB9fNCGJQyjhEtE9uFt2bJ9J6vFIqz5YWJUaXl8K6fg+FmzkUlInIySRExV3b0I1BR5tg7wKbOmobXfNLfOrqf2u7JFSrqqlyAak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6E220343537;
	Tue, 18 Feb 2025 14:41:26 +0000 (UTC)
Message-ID: <24df8aa2-760f-4da3-88b0-ab97796373fd@gentoo.org>
Date: Tue, 18 Feb 2025 09:41:23 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Meson build leaks host 'sh' path to target build when
 cross-compiled
To: Patrick Steinhardt <ps@pks.im>, Peter Seiderer <ps.report@gmx.net>,
 Sam James <sam@gentoo.org>
Cc: git@vger.kernel.org
References: <20250209133027.64a865aa@gmx.net> <Z6mtnmvKMsIOEVz5@pks.im>
 <20250210122603.5130e309@gmx.net> <Z7RzPkiBfbYPhKp_@pks.im>
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
In-Reply-To: <Z7RzPkiBfbYPhKp_@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0OaaRAojH00oI6Xido1hUr9w"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0OaaRAojH00oI6Xido1hUr9w
Content-Type: multipart/mixed; boundary="------------9mRIHdyM1OZ7hKFSQSestAVx";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>, Peter Seiderer <ps.report@gmx.net>,
 Sam James <sam@gentoo.org>
Cc: git@vger.kernel.org
Message-ID: <24df8aa2-760f-4da3-88b0-ab97796373fd@gentoo.org>
Subject: Re: Meson build leaks host 'sh' path to target build when
 cross-compiled
References: <20250209133027.64a865aa@gmx.net> <Z6mtnmvKMsIOEVz5@pks.im>
 <20250210122603.5130e309@gmx.net> <Z7RzPkiBfbYPhKp_@pks.im>
In-Reply-To: <Z7RzPkiBfbYPhKp_@pks.im>

--------------9mRIHdyM1OZ7hKFSQSestAVx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/18/25 6:47 AM, Patrick Steinhardt wrote:
> On Mon, Feb 10, 2025 at 12:26:03PM +0100, Peter Seiderer wrote:
>> On Mon, 10 Feb 2025 08:41:18 +0100, Patrick Steinhardt <ps@pks.im> wro=
te:
>>> On Sun, Feb 09, 2025 at 01:30:27PM +0100, Peter Seiderer wrote:
>>> [snip]
>>>>   The meson build tries to execute the non-existent '/usr/bin/sh' (i=
nstead of
>>>>   '/bin/sh' as the autoconf build), 'which sh' on the host returns
>>>>   '/usr/bin/sh'...
>>>>
>>>>   From meson.build
>>>>
>>>>    [...]
>>>>    186 shell =3D find_program('sh', dirs: program_path)
>>>>    [...]
>>>>    685   '-DSHELL_PATH=3D"' + fs.as_posix(shell.full_path()) + '"',
>>>>
>>>>   Do not use the result of 'find_program('sh',...)' for '-DSHELL_PAT=
H=3D'
>>>>   (at least not for cross-compile), use fix '/bin/sh' instead or mak=
e it
>>>>   configurable via a meson option?
>>>
>>> Hm, very true. We're mixing up concerns here by treating the build
>>> environment and the target environment the same.
>>>
>>> I guess the proper fix is to wire up the "native:" parameter when we
>>> call `find_program()`, which allows us to tell Meson whether it shoul=
d
>>> find an executable for the build or the target host. And then, for th=
ose
>>> binaries where we actually need to know about both the build and targ=
et
>>> host's locations, we'd end up calling `find_program()` twice.
>>>
>>> For executables that are supposed to be used on the target host Meson=

>>> would then know to first consult the cross file, which could look lik=
e
>>> this:
>>>
>>>     [binaries]
>>>     sh =3D '/target/path/to/sh'
>>>     perl =3D '/target/path/to/perl'
>>>
>>> Meson would then pick up that file via `meson setup --cross-file
>>> <CROSSFILE_PATH> <BUILDDIR>`.
>>
>> Sorry, I believe this will not work..., the description of the native
>> parameter in find_program ([2]) on the first sight sounds like doing t=
he
>> right thing, but as far as I read the 'Cross compilation' page ([3], [=
4]) the
>> tools under the '[binaries]' section are the tools used while cross-co=
mpiling
>> (running on the build machine) and not the paths/tools on the target
>> (or as meson nomenclature host/target)...
>=20
> Quoting the documentation of `find_program()`'s `native` parameter [1]:=

>=20
>     Defines how this executable should be searched. By default it is se=
t to
>     false, which causes Meson to first look for the executable in the c=
ross
>     file (when cross building) and if it is not defined there, then fro=
m the
>     system. If set to true, the cross file is ignored and the program i=
s
>     only searched from the system.
>=20
> So I think this should work as expected when passing the file via
> `--cross-file`, shouldn't it? If we are cross-compiling we'd find the
> target binaries via the cross file when `native: false`, which is
> exactly what we want.
>=20
> But I see what you're saying. The _intent_ is to specify the environmen=
t
> of the cross-compiling environment, and not to describe the target
> environment.
>=20
> I can think of two alternatives:
>=20
>   - We can introduce build options for this. If unset, we continue to
>     use the result of `find_program()`. Otherwise, we use the value
>     specified by the user.
>=20
>   - We can introduce properties into the cross file that allow the user=

>     to specify those parameters. We can then retrieve them by calling
>     `meson.get_external_property()`, but only when cross-compiling.
>=20
> Let me also Cc Eli, he might have an opinion on how to do this.


For the specific case of detecting sh, the portable "API filename" is
exactly /bin/sh and nothing else. It should always exist on pretty much
any unix system ever... except for the ones where it exists but is a
pre-POSIX shell and the actual POSIX one isn't always on PATH at all. Hi
there, Solaris /usr/xpg4/bin/sh ! :)

Overriding it via the cross file would be fine -- if your goal is to
only ever find_program(..., native: false) in order to detect a path and
embed it, then it doesn't matter whether cross files are for running
cross tools on the build machine or for looking up cross tools to detect
a path and embed it, since the two goals would never *come into
conflict*. And that's what actually matters -- if you are concerned that
cross files will be wrong as they specify the cross-compile environment
not the install environment, then you shouldn't be using find_program()
either, you should be exclusively using build options.



But again -- that's the general case, and for the specific case you
should be defaulting to /bin/sh

This does have a highly practical application to it. Gentoo supports
split-usr systems, and binary package support needs to consistently use
paths that are present on both merged- and split-usr systems. There is
no /usr/bin/sh on a split-usr system, but on a merged-usr system they
are the same directory, so it will exist "anyway".

Note that this is NOT a cross compile environment. I'm compiling for the
current x86-64 environment, but also tarring it up for installation on
other x86-64 environments that happen to use a different filesystem
partition scheme.


Cc Sam as we will need to fix this in our Gentoo packaging one way or
another:

$ ebuild git-2.48.1.ebuild clean install
[...]
$ ag usr/bin /var/tmp/portage/dev-vcs/git-2.48.1/image

It is finding and embedding various hits for /usr/bin/sh because I
happened to build on a merged-usr profile.



--=20
Eli Schwartz

--------------9mRIHdyM1OZ7hKFSQSestAVx--

--------------0OaaRAojH00oI6Xido1hUr9w
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZ7ScEwUDAAAAAAAKCRCEp9ErcA0vV8L3
AQDaXw6GDp4P3KGWd/PXff3Qiw3RiyngCDSqQCRDkVXy3wEA3d0rUW3X12b/VpRJDAF9LPMcl4eQ
U7xBaBNqtfTdSAk=
=hS7k
-----END PGP SIGNATURE-----

--------------0OaaRAojH00oI6Xido1hUr9w--
