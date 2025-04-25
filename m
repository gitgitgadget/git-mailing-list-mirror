Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25F1A2545
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604445; cv=none; b=OJi1ZibG2ijxjjSNz0SIOjXt1KEgXsSYhYQfTAPBWoEQ/eLYGLkHylE4MPgqTJIgnVVqMbdEt+x2+ewxt2IJvSGQCY4uZD/kJPTuc28sjgPvn3k2tRUvO+dAGv/rPBtD+yYPsblasIY4vlJ6rAEFEZt0sLw2r82N6xUN4dcJT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604445; c=relaxed/simple;
	bh=S2bxWgctTQfzxKtRSFemxdOkHNYRkK5XCDeQ2vwkgqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7T7G1D0RBVxrEL77k5yHI65odb+91FFACgvch5e2bHWxH9VQVllxhmK12qDZgTvD1P9+fqi3e4eHlicd2MPxo4e06kkWKsbygbMpoUlhO8qciGAQEWLOXZ45+XWF1VIhOUeqxzsRM7XpxatUJeZdZiod2Z+Uh6it49sslZAZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C62EF3417BD;
	Fri, 25 Apr 2025 18:07:22 +0000 (UTC)
Message-ID: <06e57780-9f59-4166-81d3-9cd0c1c66b7e@gentoo.org>
Date: Fri, 25 Apr 2025 14:07:18 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] meson: prefer shell at "/bin/sh"
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>,
 Justin Tobler <jltobler@gmail.com>
References: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
 <20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
 <xmqqy0votbns.fsf@gitster.g>
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
In-Reply-To: <xmqqy0votbns.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RN14eCtd1OsFFD1xTvor75Z0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RN14eCtd1OsFFD1xTvor75Z0
Content-Type: multipart/mixed; boundary="------------g7U14vnXlozfV88ODpC5Tsti";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>,
 Justin Tobler <jltobler@gmail.com>
Message-ID: <06e57780-9f59-4166-81d3-9cd0c1c66b7e@gentoo.org>
Subject: Re: [PATCH v3 2/2] meson: prefer shell at "/bin/sh"
References: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
 <20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
 <xmqqy0votbns.fsf@gitster.g>
In-Reply-To: <xmqqy0votbns.fsf@gitster.g>

--------------g7U14vnXlozfV88ODpC5Tsti
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/25/25 1:04 PM, Junio C Hamano wrote:
> Now I am showing my ignorance, but does this support folks whose
> shell are not spelled "sh" (like "/usr/local/bin/dash"), and more
> importantly, if it does not, shouldn't we be using a mechanism that
> does?  I think -Dsane_tool_path=3D/usr/local/bin would help with the
> leading directory path, but I suspect that find_program() does not
> help specifying "dash" to be used as our target_shell (or host
> shell), or "perl5" as our perl.
>=20
> Of course, this "my sh is called dash" can be left totally outside
> of the topic of these two patches.


POSIX does not require a specific absolute file path for "sh", but it
does mandate that you have a shell and its name is "sh", whichever
directory it may be found in.

There is (most of the time) not actually a program called "sh". Various
different programs may provide a symlink "sh", pointing to their own shel=
l:

- GNU Bash (bash)
- Korn Shell (ksh93)
- Policy-compliant Ordinary Shell (Debian `posh`)
- Almquist Shell (ash)
- Debian Almquist Shell (dash)
- busybox
- MirBSD Korn Shell (mksh)

(Commercial Unixes will tend to have a unique "sh" program without an
actual name, just called "$UNIX sh".)

You can call them by either name, but the general rule is that when
running an interactive command prompt you probably have your specific
favorite whereas when running a script you just need something that
complies with the POSIX spec. It's common to install dash as the /bin/sh
because it is faster than GNU Bash due to supporting much less.

There cannot be anyone who has a sh that is not spelled "sh", there are
only people who have multiple options, one of which has been assigned to
the name "sh".

If it is desirable for Git to allow people to experiment with different
shells for the git internal scripts, that is one thing (though I don't
think it's particularly useful). But there's no need to worry about
people that don't have an "sh". They have to.

Even on Solaris where /bin/sh is a non-POSIX shell that cannot run our
scripts, that is a backwards compatibility requirement and they expect
you to add /usr/xpg4/bin to the front of $PATH for applications that use
POSIX, while leaving the "broken forever" version in /bin to be used by
legacy pre-1990s applications that may still exist and haven't been
updated in well over 30 years and counting. The "sh" in $PATH at
/usr/xpg4/bin/sh is a POSIX-compliant shell. It even has the `local`
vendor extension.


--=20
Eli Schwartz

--------------g7U14vnXlozfV88ODpC5Tsti--

--------------RN14eCtd1OsFFD1xTvor75Z0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaAvPVwUDAAAAAAAKCRCEp9ErcA0vV322
AP9lqc1L7SeC8NFs+T97kUwRbruOYscvftz3t+KO/9tyIQD+JMy14/Hqc0p7iJg414tMCm7ewHvZ
2yknweqQt7sqqg8=
=aKKW
-----END PGP SIGNATURE-----

--------------RN14eCtd1OsFFD1xTvor75Z0--
