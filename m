Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B2F2AE6C
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 06:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727244160; cv=none; b=Oap/Au3iXy89cLyVl4doUHsamKN5Paw2g83kUNFkxkrYiv48Fo826F61DEF9KVLVr1zuLUsZ3u4SLxyfrSvPWkt1puPDbLqm5q+3luyKBId77bekNJr52gQajqBlvzGpqYYz3Txzz5uandTGWaYmSevsLop2ba30JkaMJ4ufPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727244160; c=relaxed/simple;
	bh=k54JcGLxUda+dYQDFlRo1ZOhr7QDPUlzIJNtp7Y7gfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TuR+/d8j+mqA8ZVPSVPo1HppLYmDhHIyRwNLDcP/zMwtfey7mW4aFJvCH0uoz2KBpb54jQlXvCdQJRKoaagXs23ndoUaGlv2NO6QJS76cvijOU9iPrXi6+oqy/j38rUKxUaDz0AaGAG0P+XaHGNChHjXWikEyi8Wqr1Bt625DRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
Date: Wed, 25 Sep 2024 02:02:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ./configure fails to link test program due to missing
 dependencies
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jonathan Nieder <jrnieder@gmail.com>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im>
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
In-Reply-To: <ZvOTL0cG8qRY8OXe@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fkaM0zeZ0rMssjRKqo8ktpaa"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fkaM0zeZ0rMssjRKqo8ktpaa
Content-Type: multipart/mixed; boundary="------------OOb7GE8Ms0BR5ZMGIHxf8hl0";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im>
In-Reply-To: <ZvOTL0cG8qRY8OXe@pks.im>

--------------OOb7GE8Ms0BR5ZMGIHxf8hl0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/25/24 12:36 AM, Patrick Steinhardt wrote:
> On Tue, Sep 24, 2024 at 09:59:52AM -0400, Eli Schwartz wrote:
>> On 9/24/24 8:10 AM, Patrick Steinhardt wrote:
>> Still I would prefer meson over autotools any day of the week. I'd als=
o
>> prefer autotools over cmake, mind you.
>=20
> Is that a typo or do you really prefer autotools over CMake? :)


POSIX sh (used by autotools) has a more powerful and capable type system
than CMakeLists.txt (this is not a typo either! compare CMake's
"semicolon;delimited;string" type to POSIX sh's "$@" type)


m4 is less painful to debug than successfully configuring, spending 4
hours compiling a ginormous project, then failing at the end with (this
is because of the type system again, since there is no type for
dependency-was-not-found they smuggle it along as a string value with
special meaning):
ld: cannot find -lCURL-NOTFOUND: No such file or directory


If you enable cmake's test system, but you do it inside a subdir e.g.
inside tests/CMakeLists.txt, you cannot run "ctest" (or make test)
except inside that subdir. ctest will exit 0, and no rules will be
generated to descend into the correct directory instead. This has bitten
me a *bunch* of times in Gentoo packaging and it always throws me for a
loop. I don't understand the point of such a design.


I have never had autotools refuse point-blank to detect that another
package is installed and usable for ***shared linkage*** because my
distro automatically removes static libraries when a corresponding
shared library exists, and

CMake Error at /usr/lib64/cmake/libssh2/Libssh2Config.cmake:92 (message):=

  The imported target "Libssh2::libssh2_static" references the file

     "/usr/lib64/libssh2.a"

  but this file does not exist.  Possible reasons include:

  * The file was deleted, renamed, or moved to another location.

  * An install or uninstall procedure did not complete successfully.

  * The installation package was faulty and contained

     "/usr/lib64/cmake/libssh2/Libssh2Config-relwithdebinfo.cmake"

  but not all the files it references.


autotools projects have never harmed me by running the square of my make
-j$(nproc) count due to recursively running cmake inside of generated
Makefiles -- perhaps that isn't strictly the fault of CMake but cmake
does very little to discourage it: https://bugs.gentoo.org/921309


autotools doesn't have much in the way of built-in tooling for detecting
"packages" instead of "libraries" for arbitrary system dependencies. It
allows you to use pkg-config or code your own (foo-config scripts were
popular once and in some circles still are). You might think this is a
negative, but it's actually a positive compared to cmake, which includes
builtin dependency finders for e.g. zlib that break on a simple version
update because they locate the header file, open it up and use regular
expressions to extract a #define for the package version instead of
asking the preprocessor... a very brittle regex, too:
https://gitlab.kitware.com/cmake/cmake/-/issues/25200


autotools projects don't automatically detect your end-to-end
integration test's dummy project, integrate its results into your build,
and install some of your project files twice, once with bad values, but
only when you run the project tests (this one was very fun):
https://github.com/nlohmann/json/issues/2907#issuecomment-890580081


=2E..


I'm probably biased, but some of these failure modes are *weird*. And
they basically never require the CMakeLists.txt to do something
considered non-idiomatic in order to trigger the issue.


--=20
Eli Schwartz


--------------OOb7GE8Ms0BR5ZMGIHxf8hl0--

--------------fkaM0zeZ0rMssjRKqo8ktpaa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZvOnegUDAAAAAAAKCRCEp9ErcA0vV185
AP4/1ivaPjcF8efnBrcu7j5ksc2STNlIOKTetsXT63PCUwEA4lt4xjtpbMRhanuTWuaQkl1apeHX
9SIONl+IxER7dww=
=w/9h
-----END PGP SIGNATURE-----

--------------fkaM0zeZ0rMssjRKqo8ktpaa--
