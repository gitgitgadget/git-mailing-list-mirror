Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E56428F92E
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335629; cv=none; b=L8LW0dbqUmByET3ZI3yaKg1kiwbkLwp+qR9CyZ7cLmP8kOovNMzbfujMZbdRQCt42VTYHpK+9cd+BVDXG8b35DP5mAH7Jqdu0hClr/qw7kKnc7FrLrD+EMv/9tlGltxivK9kLnHIai9va1LqOB6+OGCazYb1QySDLRKUqtwvEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335629; c=relaxed/simple;
	bh=lrHXiWjQ6eoiaHncAP6BFAC/MD+4zkcz9IWimN7+/VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z66DCegqp5+wKtrWrzzBrRM4D6Co1pl/Q57y8RFeHNUsn8ZY1RFlQriOX8Xb6h9YJPVakwBRRxf5HXMP8bU0iMFJLh8gO9NR6BE0sf6d8C3jAVBoMDKR3O1sLXCoacAl5S52IazJ1c10rXnwV+eZ0HjUUfWv+W/ftCcEyJNn5tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 1760A342FDE;
	Tue, 22 Apr 2025 15:27:07 +0000 (UTC)
Message-ID: <aadfbd6b-ea1c-475e-b6a9-f1552afa06c8@gentoo.org>
Date: Tue, 22 Apr 2025 11:27:03 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] meson: only check for missing networking syms on
 non-Windows; add compat impls
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250421175247.240971-6-eschwartz@gentoo.org> <aAdF3eu1heCycaLJ@pks.im>
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
In-Reply-To: <aAdF3eu1heCycaLJ@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PsRHBvzPPoncVM7yznKkXzjC"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PsRHBvzPPoncVM7yznKkXzjC
Content-Type: multipart/mixed; boundary="------------x7jIzLG06fGohUV7tV4JRHfK";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
Message-ID: <aadfbd6b-ea1c-475e-b6a9-f1552afa06c8@gentoo.org>
Subject: Re: [PATCH 6/6] meson: only check for missing networking syms on
 non-Windows; add compat impls
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250421175247.240971-6-eschwartz@gentoo.org> <aAdF3eu1heCycaLJ@pks.im>
In-Reply-To: <aAdF3eu1heCycaLJ@pks.im>

--------------x7jIzLG06fGohUV7tV4JRHfK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/22/25 3:31 AM, Patrick Steinhardt wrote:
> On Mon, Apr 21, 2025 at 01:51:50PM -0400, Eli Schwartz wrote:
>> These are added in the Makefile, but not in meson. They probably won't=

>> work well on systems without them.
>>
>> CMake adds them, but only on non-Windows. Actually, it only performs
>> compiler checks for hstrerror, but excludes that check on Windows with=

>> the note that it is "incompatible with the Windows build". This seems =
to
>> be misleading -- it is not incompatible, it simply doesn't exist. Stil=
l,
>> the compat version should not be used.
>=20
> CMake only checks for `hstrerror()` though -- it doesn't check for the
> other functions at all.


Right, that's what I meant.

"cmake, like this patch, adds the compat/*.c when checking function
availability. Actually, it only performs compiler checks for hstrerror,
but does add the compat impl in that case".


>> I interpret this cmake logic to mean we shouldn't even be checking for=

>> symbol availability on Windows. In addition to making it simple to add=

>> compat definitions, this also probably shaves off a second or two of
>> configure time on Windows as no compiler check needs to be performed.
>=20
> I dunno. In this case I'd lean towards just using the check on Windows,=

> too. The less platform-specific configuration we do the easier the buil=
d
> system is to reason about.


Maybe, but the issue is that it appears on Windows it is not correct to
add the compat impl for hstrerror, which would still be a
platform-specific configuration. Do I check for hstrerror everywhere but
configure Windows to not add the compat impl, but do add it for
inet_ntop and inet_pton? That is more configuration than skipping the
checks on Windows...



>> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
>> ---
>>  meson.build | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 1b7e55756b..24b304fb57 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1088,11 +1088,14 @@ else
>>  endif
>>  libgit_dependencies +=3D networking_dependencies
>> =20
>> -foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
>> -  if not compiler.has_function(symbol, dependencies: networking_depen=
dencies)
>> -    libgit_c_args +=3D '-DNO_' + symbol.to_upper()
>> -  endif
>> -endforeach
>> +if host_machine.system() !=3D 'windows'
>> +  foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
>> +    if not compiler.has_function(symbol, dependencies: networking_dep=
endencies)
>> +      libgit_c_args +=3D '-DNO_' + symbol.to_upper()
>> +      libgit_sources +=3D 'compat/' + symbol + '.c'
>> +    endif
>> +  endforeach
>> +endif
>=20
> We do have compat sources for `inet_ntop()` and `inet_pton()` indeed, s=
o
> adding those makes sense. But we don't have a replacement for
> `hstrerror()`, so if that function wasn't found we would error out
> because "compat/hstrerror.c" wasn't found.


I don't really understand what you mean by this. Of course the file will
be found.

$ grep hstrerror compat/hstrerror.c
const char *githstrerror(int err)


File is there. (The function name is then #defined by compat/posix.h, no
comment.)



--=20
Eli Schwartz

--------------x7jIzLG06fGohUV7tV4JRHfK--

--------------PsRHBvzPPoncVM7yznKkXzjC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaAe1RwUDAAAAAAAKCRCEp9ErcA0vV7X7
AP9wvHYLj+HNAjWuWzUQYJNRv8yWN3lMmUhi7lLokvrgnwD/fd26glvZC/ce7vb5rLa744Xzmrnk
4DBIfDY/N6eaMws=
=fgkq
-----END PGP SIGNATURE-----

--------------PsRHBvzPPoncVM7yznKkXzjC--
