Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52572280CD2
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336172; cv=none; b=o1AAsB16INFDsuGbxvDbRaiY4RdW4sk9FSZXrIdVM/81rKIlHSQAvJtqcGJk7NNfY8iNVD2s2mO0dhBz2yGt6A1+QNH6je6QtEOuOFoydMXzObge5MgNBELuX5BR9G+n0EO3fsxdgPrqXGB1A/LMCyot53o410lcWbOeATmefPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336172; c=relaxed/simple;
	bh=WG4P1l16xQCj/xbZbH9XoVkv8unUvQ7fS3S0YCIl988=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjsAKfkGGpGepxuYh94qioRoVIvs+hU/vM/e7GPihfRcCKB72zHNKantZt807VCAcf5YKs1PmhtYx+Vns94QJ35YaNnJDkLqr6e5iP0vVJ1zVaph1QF9QR1YurKb82PkWlE4dua5mHvmMjyMQHV7tBCoo8VYWqDGcJEASo0+95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3DCE6340DF9;
	Tue, 22 Apr 2025 15:36:09 +0000 (UTC)
Message-ID: <590d0daa-59ac-44f3-b277-e3e83ad1add5@gentoo.org>
Date: Tue, 22 Apr 2025 11:36:06 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] meson: simplify and parameterize various standard
 function checks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>,
 Junio C Hamano <gitster@pobox.com>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <83d9fda5-8399-47fb-87b2-a8b376cf1625@gentoo.org> <aAdF4DzFCZ3uOJCx@pks.im>
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
In-Reply-To: <aAdF4DzFCZ3uOJCx@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0zUDZ4tT8jxw9tm4mb30S8E7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0zUDZ4tT8jxw9tm4mb30S8E7
Content-Type: multipart/mixed; boundary="------------JfbU0ZCusM1zACF98S3ix8GB";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>,
 Junio C Hamano <gitster@pobox.com>
Message-ID: <590d0daa-59ac-44f3-b277-e3e83ad1add5@gentoo.org>
Subject: Re: [PATCH 1/6] meson: simplify and parameterize various standard
 function checks
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <83d9fda5-8399-47fb-87b2-a8b376cf1625@gentoo.org> <aAdF4DzFCZ3uOJCx@pks.im>
In-Reply-To: <aAdF4DzFCZ3uOJCx@pks.im>

--------------JfbU0ZCusM1zACF98S3ix8GB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/22/25 3:31 AM, Patrick Steinhardt wrote:
> On Mon, Apr 21, 2025 at 04:04:30PM -0400, Eli Schwartz wrote:
>> On 4/21/25 1:51 PM, Eli Schwartz wrote:
>>> diff --git a/meson.build b/meson.build
>>> index c47cb79af0..6c147c22a4 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -1322,45 +1339,15 @@ if not compiler.has_function('strtoumax')
>>>    ]
>>>  endif
>>> =20
>>> -if not compiler.has_function('strtoull')
>>> -  libgit_c_args +=3D '-DNO_STRTOULL'
>>> -endif
>>> -
>>> -if not compiler.has_function('setenv')
>>> -  libgit_c_args +=3D '-DNO_SETENV'
>>> -  libgit_sources +=3D 'compat/setenv.c'
>>> -endif
>>> -
>>>  if not compiler.has_function('qsort')
>>>    libgit_c_args +=3D '-DINTERNAL_QSORT'
>>>  endif
>>>  libgit_sources +=3D 'compat/qsort_s.c'
>>
>>
>> ... for example, the Makefile says here:
>>
>>
>> # Define INTERNAL_QSORT to use Git's implementation of qsort(), which
>> # is a simplified version of the merge sort used in glibc. This is
>> # recommended if Git triggers O(n^2) behavior in your platform's
>> # qsort().
>>
>> cmake unconditionally defines it (???)
>=20
> Our CMake build instructions shouldn't be treated as canonical source o=
f
> truth. They're good enough for some usecases, but they are not as
> feature complete as any of Makefile/autoconf/Meson.


=2E.. yes, which is why I'm using it as a springboard to ask questions? :=
)

My working theory is it unconditionally defines it because this is the
correct behavior on Windows, and the cmake files were primarily written
to be used on Windows, which leads us to...


>> config.mak.uname says:
>>
>> - AIX:
>>   INTERNAL_QSORT =3D UnfortunatelyYes
>>
>>   Seems to date back to commit 377d9c409ffe0f0d994b929aeb94716139207b9=
d.
>>   "Unfortunate" indeed.
>>
>>
>> - MinGW:
>>   INTERNAL_QSORT =3D YesPlease
>>
>>   Windows claims to have a qsort but perhaps it is very slow and bes
>>   avoided?
>>
>> We should probably stop *checking* for qsort and simply encode the
>> platforms we know are slow and automatically skip it there. Can I get
>> confirmation regarding Windows? :)


=2E.. this. config.mak.uname's mingw case appears to agree with my theory=

about the motivations for the cmake file.


> I'd rather prefer to try and detect this generically instead of adding
> more platform-specific configuration. It is way simpler to maintain, an=
d
> if we ever see that things don't work well on a specific platform we ma=
y
> still reconsider at that point in time.


Okay but, how do we generically detect that a platform triggers the
Makefile advice "recommended if Git triggers O(n^2) behavior in your
platform's qsort()"? I'm not sure how to write a compile-time check for
this.

It's easy to write a compile-time check for whether a function exists,
but it seems to have been an error that meson assumes some platforms
will not provide the function, as that was never the intent of Git's
support for internal qsort.


--=20
Eli Schwartz

--------------JfbU0ZCusM1zACF98S3ix8GB--

--------------0zUDZ4tT8jxw9tm4mb30S8E7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaAe3ZgUDAAAAAAAKCRCEp9ErcA0vV6aM
AQC4TIM9QTc7jY19h5hLjo6rIT7yz/ahglSOsWJ7aMq87QD8D+kYAFqLrk0a4rgrF7rvKwHaZUZK
D1/ovgK9AD8H1Q8=
=9GLW
-----END PGP SIGNATURE-----

--------------0zUDZ4tT8jxw9tm4mb30S8E7--
