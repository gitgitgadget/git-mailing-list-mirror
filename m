Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16518FDB9
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745619930; cv=none; b=LvtoaKuVfgQH6ritsCJ1ceAIaVaPWLJOUjDV9HUMAD5WPysagW5SZImcz6836/T5DxcSuULNSndSXH+VnW/1/8lTPIR/KmNr2hfbu71h7I9AIs+Gbb/b96Q4Cb99U+yWf5Xi6oADZs8IPDDxLsNUB7GJFzQIqOgZwuW0XJSeCaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745619930; c=relaxed/simple;
	bh=oCZiVrDiMelG8fAOUTS+dQTAzWOzGfngwuvaGtWqFDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qeZB89vdp0KNzPPFIAHE8YDu+HEdOOEIx9fuh4RjlHmEK2JANcpLYYGziqVgz2zsdqny5gPkXwoVnHDl/XWD8ADy/uyx1s/eeoc1lSaRSvJI0b4yf8rKeHvYm3gdD9ewp4BIQftrGuZYGTrUbKcCYCTlbUjR7AV4Kor8ebAc1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id CDCF5340754;
	Fri, 25 Apr 2025 22:25:27 +0000 (UTC)
Message-ID: <9182bbb9-fdfa-4abe-abae-4ecfd5c0f449@gentoo.org>
Date: Fri, 25 Apr 2025 18:25:25 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] meson: prefer shell at "/bin/sh"
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>,
 Justin Tobler <jltobler@gmail.com>
References: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
 <20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
 <xmqqy0votbns.fsf@gitster.g>
 <06e57780-9f59-4166-81d3-9cd0c1c66b7e@gentoo.org>
 <aAvsT1o6wIGGCEui@tapette.crustytoothpaste.net>
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
In-Reply-To: <aAvsT1o6wIGGCEui@tapette.crustytoothpaste.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------I5H7gHqvGMOZ1vqIAOVWYv4G"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------I5H7gHqvGMOZ1vqIAOVWYv4G
Content-Type: multipart/mixed; boundary="------------GbQhQYb7sGAbmQ7rtXOV1orS";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>,
 Justin Tobler <jltobler@gmail.com>
Message-ID: <9182bbb9-fdfa-4abe-abae-4ecfd5c0f449@gentoo.org>
Subject: Re: [PATCH v3 2/2] meson: prefer shell at "/bin/sh"
References: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
 <20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
 <xmqqy0votbns.fsf@gitster.g>
 <06e57780-9f59-4166-81d3-9cd0c1c66b7e@gentoo.org>
 <aAvsT1o6wIGGCEui@tapette.crustytoothpaste.net>
In-Reply-To: <aAvsT1o6wIGGCEui@tapette.crustytoothpaste.net>

--------------GbQhQYb7sGAbmQ7rtXOV1orS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/25/25 4:10 PM, brian m. carlson wrote:
> All of what you said here is true, but I will point out that AT&T ksh
> (ksh93 and also ksh88) doesn't support `local`.  All of the others do,
> as do other pdksh derivatives (like OpenBSD's sh and ksh[0]).


Right, though I seem to recall e.g. all the BSDs use a pdksh variant at
least.


> I believe on NonStop that `sh` is AT&T ksh, so there is no program or
> symlink named `sh` on the system which meets our needs.  The customary
> option there is to use bash instead.


Aha. :(


> Additionally, Debian allows zsh as `/bin/sh`, since it meets their
> requirements, but older versions do not run all elements of a pipeline
> in a subshell, which, while allowed by POSIX as an extension,
> practically breaks our code (and lots of other code as well).  (New
> versions contain a patch I sent that fixes this behaviour when in `sh`
> mode.)  As a result, a user compiling their own Git might need to
> specify something that is not `sh` on such a system.


Nobody should be using zsh as /bin/sh at all, since it is not a POSIX
shell to begin with. e.g. Gentoo does not permit it. I think Debian
should treat this as a conformance bug and fix it by removing zsh
support for /bin/sh until upstream zsh makes a serious effort to conform
to POSIX (i.e. never)...


> And Junio points out correctly that some systems have Perl as `perl5`,
> not `perl`.  (Mostly in environments that once had or still have Perl
> 4.)


Yup. Same applies for overriding via a machine specification file as I
replied regarding "sh".



> So all that to say that we do need to be able to specify an arbitrary
> path to a binary in order for things to work on some systems.
>=20
> [0] Which are the same thing.


--=20
Eli Schwartz

--------------GbQhQYb7sGAbmQ7rtXOV1orS--

--------------I5H7gHqvGMOZ1vqIAOVWYv4G
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaAwL1QUDAAAAAAAKCRCEp9ErcA0vV2g9
AQDTWKwOtPgZUTh1UEixvuulKvPmMpINscQdFxPJfX9fNwEAlQe2Ez/Fo3QNjQ1B/Rc+BUXAlGgs
QMBezqfP9T7QnAc=
=tiYT
-----END PGP SIGNATURE-----

--------------I5H7gHqvGMOZ1vqIAOVWYv4G--
