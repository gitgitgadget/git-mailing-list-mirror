Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB11FFC7E
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750452192; cv=none; b=LsHiTutqUK7X+bprh3jDUf8OG3drCxMv/3QWW4TWyRDX+ivixQYBRZ/pnEPssCe/dQ1X7vjVeZE2E7PrFAttQZZhDNdo6C8mMk3kX6HWDqt/fPBDYCoidvR6mF9Qhp7gkOFY4zpjR+LZBEPVGpnTEncB6O+qsCWDo0H7OXQEgVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750452192; c=relaxed/simple;
	bh=jc3jaEwb3cyvciWS6D6EGxcJAwOBRzWOv7Pfv9Qf68Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgX9Wrf9qNcxre72Y6yZ0KQAWeWD+vO1e2BzuWUSGSL3vTmPIU7iL2FGksiT+dv21Ai8Uo7P1V5M1jWUEWfdvuVfR35EJnfWRV04NIFbn+9a6dRRkB/yd/g7HoSucW43yqV/q28xwweyO7Ob/+EsHeDXEXWzM2aXxfQ5TX54lYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vzkxUFUB; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vzkxUFUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750452188;
	bh=jc3jaEwb3cyvciWS6D6EGxcJAwOBRzWOv7Pfv9Qf68Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=vzkxUFUBOVsxI/LCmSlgus9akSJGonKrqct0ISA9zJFRg8GNH7ZXHNQtWGb9C/9MC
	 viP8rHxWXt6aBzHyrJ9m1TogriFfDZXACxOscoeavI6F3O8x1Dlyst6kpM28dzn0EH
	 F6mezQJ37EGrRlXV1WcuqafV7thhbIuKj4F86kF17OaCEek2CnDe9VkoH2dOX/3ua7
	 KJu6F5727MDtcHF1GYlFEQAAxjvQwKYf7kGpFyeaHUFLoRgGDIOiU5m16zH63kXG6R
	 E8oC7iLWjZjcajtB5iGkOWfSVnBv+aTh+2/w5Qqo1/CpaEOC7ypkFHz0j3amwFkrfb
	 SAfNoWFRCpm505er2V6rL65d8ctFQpoXdgcMu/WEW6pwA8B3KAv1+hUAUvaMZPrXQ1
	 glVL7F3D05Q3eQWVD6j7e5ucdasaiiLFBbt4m8jUKRDNbaVdAO+6BhB/YZjTe/FlXx
	 gIKauNZ6feDPhOnHpaxSGKBxvwVBXV4n4QvIjI5pDK1g7MwhnHj
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D949320069;
	Fri, 20 Jun 2025 20:43:08 +0000 (UTC)
Date: Fri, 20 Jun 2025 20:43:07 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 02/10] hash: add a constant for the original hash
 algorithm
Message-ID: <aFXH2_PpZrJxJRCs@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250620011943.586596-3-sandals@crustytoothpaste.net>
 <xmqq1prf89cd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rMDFfusEp2C9oyPB"
Content-Disposition: inline
In-Reply-To: <xmqq1prf89cd.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--rMDFfusEp2C9oyPB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-20 at 01:56:02, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > We have a a variety of uses of GIT_HASH_SHA1 littered throughout our
> > code.  Some of these really mean to represent specifically SHA-1, but
> > some actually represent the original hash algorithm used in Git which is
> > implied by older formats and protocols which do not contain hash
> > information.  For instance, the bundle v1 and v2 formats do not contain
> > hash algorithm information, and thus SHA-1 is implied by the use of
> > these formats.
>=20
> Does that mean use of _ORIGINAL is a sign that these places should
> keep using SHA-1 and should not change?

Yes.

> I am having a hard time guessing/assessing the value of having _ORIGINAL
> that is a synonym for _SHA1; with redirection, it pretends as if the
> underlying value can be updated from SHA-1 to SHA-256 (and that is
> the very intention behind GIT_HASH_DEFAULT symbol that gives us a
> level of indirection), but it is hard to imagine we would ever want
> to change what _ORIGINAL means, as that word talks about a historical
> fact that will never change over time.

I agree.  _ORIGINAL indicates that this is a use of SHA-1 which is a
historical fact and is a legacy decision as opposed to one specified
explicitly.

For instance, if we're setting the algorithm for bundle v1 and v2, then
we'd use _ORIGINAL because those formats did not specify a hash value
when they were designed and, for legacy reasons, we cannot change that
fact.  However, if with bundle v3, a user specified @object-format=3Dsha1,
then we'd use _SHA1, since that was an explicit decision documented.
Similarly, _SHA1 represents extensions.objectFormat=3Dsha1, which is an
intentional decision to use the older algorithm.

> > Add a constant for documentary purposes which indicates this value.  It
> > will always be the same as SHA-1, since this is an essential part of
> > these formats, but its use indicates this particular reason and not any
> > other reason why SHA-1 might be used.
>=20
> I am not sure what this means.  If we use GIT_HASH_SHA1 in such
> places explicitly (as opposed to GIT_HASH_DEFAULT), isn't it a sign
> enough that with different versions of Git, that particular code
> path should keep using SHA-1 no matter what the default is?

If we have a test helper that computes hashes and someone specified
"sha1" on the command line, that's GIT_HASH_SHA1.  Someone said, "I'd
like to use SHA-1."  Similarly, in the reftable code, we can read the
byte value indicating that the reftable is in SHA-1 and that's an
explicit decision.

If we default to SHA-1 because nobody specified extensions.objectformat,
then that's GIT_HASH_ORIGINAL.  Nobody made a decision or opted into an
algorithm; we just didn't think hard enough about cryptographic agility
in the original Git and we assumed SHA-1.

They're both the same numeric constant here and always will be (even if,
in a future version of Git, we get rid of SHA-1 altogether and we
otherwise die on that code).  But there's a difference in intention: one
explicitly stated SHA-1 as opposed to a different algorithm and one just
got a default because that's the compatible legacy behaviour.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--rMDFfusEp2C9oyPB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFXH2wAKCRB8DEliiIei
gbHRAQC24hGlhuHUHvaeNMzVehfNs1TCHBXBaZWfA+EU/pjzDgD+KnQKoJZDFBYr
9lXd9fylAqABEAJFKo/ZhhROkBwH+AI=
=gCfL
-----END PGP SIGNATURE-----

--rMDFfusEp2C9oyPB--
