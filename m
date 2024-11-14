Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A266E198E96
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731559600; cv=none; b=q8iNqwv8D+NvfAclBj8FbuMJgZBvqizZw0o9leLdWSeE13uxq08zHbPyDNSsFZp8JJ54jHFRRamcxevvP027rt1iZDWn0hi+DKyjOxhNRRAXAWlXfy5By65JY82aUf+zzYOxqGLYIG3BMXhXXC0/LCr27mzJTZisPwuG5xVPmKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731559600; c=relaxed/simple;
	bh=gTwwtdUrP+6AaTjMjuL4BlzbNKKSjiTWV85cOJEB4jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7JNbaMzVwGdiGcAyGGPV5io/EKlcB0hnOQlL7+2NYACECVxoIWn+mjIrA+tPdF9sjNzmlwZaQCCrvbyBK7WMr6wlUFY4zxN95HlWhUBIbJUekftr4TnVhufA8fi1bgx+a9id2BgQvN9Vg1FCUVgjSTYoHYnWr5d7iamsafRC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <a2b5e007-776f-4c70-bd8b-38f1ec9808e3@gentoo.org>
Date: Wed, 13 Nov 2024 23:46:32 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: David Aguilar <davvid@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Jeff King <peff@peff.net>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im> <ZzRvsOeLsq3dJbGw@gmail.com>
 <ZzSprTl5Z3uIx0_d@pks.im> <xmqqo72i788q.fsf@gitster.g>
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
In-Reply-To: <xmqqo72i788q.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tjFd4bEjf01hyAPP0I23sJKX"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tjFd4bEjf01hyAPP0I23sJKX
Content-Type: multipart/mixed; boundary="------------hwArb6r4dH0K36Z3MJN03oOv";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: David Aguilar <davvid@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Jeff King <peff@peff.net>
Message-ID: <a2b5e007-776f-4c70-bd8b-38f1ec9808e3@gentoo.org>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im> <ZzRvsOeLsq3dJbGw@gmail.com>
 <ZzSprTl5Z3uIx0_d@pks.im> <xmqqo72i788q.fsf@gitster.g>
In-Reply-To: <xmqqo72i788q.fsf@gitster.g>

--------------hwArb6r4dH0K36Z3MJN03oOv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/13/24 11:24 PM, Junio C Hamano wrote:
> Is there a way to disable that?  These symbolic-links pretending to
> be installed files are quite annoying---when the target file is lost,
> the links become useless.


INSTALL_SYMLINKS=3D1 in the existing Makefile is of course the one true
way... (and really, why would you expect the target file to be lost for
any reason).

That being said, it doesn't appear the patch series implements any of
the other multiplicity of choice in what kind of filesystem object gets
used for multiple copies of the same file. No hardlink or copy support
has been rigged up.

(Meson doesn't have a builtin function for performing hardlinks, by the
way. I don't really think I've seen people desire to do this outside of
one project being discussed right here right now. hardlinks are mainly
good at fooling people who look at them into not understanding the
association between the two, and at breaking across multiple
filesystems. It's definitely impossible to get it right automatically,
and asking users to make an informed choice here is just not something
that projects other than git seem to find valuable, for whatever reason.
So basically, it's fairly understandable that meson hasn't previously
added hardlink support.)


--=20
Eli Schwartz

--------------hwArb6r4dH0K36Z3MJN03oOv--

--------------tjFd4bEjf01hyAPP0I23sJKX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZzWAqAUDAAAAAAAKCRCEp9ErcA0vVyFc
AQClKuf5vLj+Zi0PcJagU+Xd3/0qdzz0ZkTGt/etVp3dtwD+L7cx/gvLBxlTjDW895K9bpEXEDHG
ZHhVc7zslFp0mgY=
=joGB
-----END PGP SIGNATURE-----

--------------tjFd4bEjf01hyAPP0I23sJKX--
