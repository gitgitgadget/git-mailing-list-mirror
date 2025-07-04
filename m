Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3EF54723
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751657261; cv=none; b=qRDZUzPD3rspaqGY+Pf4ZxzFbxG9LnWXUKNoWN8icYXZGiNj5aupMaVeh3CZwgw5EO6yOn32hK6XlTeJUbktJkuEc3zbhLBxnLpKSNE4K5PlYh0ecCwB2JBGqhvrW7mmnd6TrmGqzqFTN8TpFrZIXwYarzwlNBbSr7wWU+t8NB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751657261; c=relaxed/simple;
	bh=SZqm2o51TX0ehIqwcwJyxUvlgAqaV/N71rFv0ZR1cTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awqru/Dis/gI26RSmsXcMVb71GLihzXrBDndnpRQk+8NMrS1xKTOhbCBkcgJQhAdjMWlJlDPN7W2tJH+yd3rK94VOMo17HG31XyEljG/A7jEGvT7m5zEwVFB3llpRqjVniE+GbmjgqejuGomJOUmJmOrFPzJhQbmV3crUx1YBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Ft3oCO0L; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ft3oCO0L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751657251;
	bh=SZqm2o51TX0ehIqwcwJyxUvlgAqaV/N71rFv0ZR1cTY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Ft3oCO0LLhHx504uhlYgumjuxJKirxsIJhG/3xqv5VbBanaOpzG52721AsKnDA1jv
	 9xPF8W8o7F09Cl0oeNLd+HQai7rD98RQUJRwSw9dfRiK7X5+CGHt6aDCMtqGQjO3UH
	 IIsrwCebKvBJgh5La9vSDF9ErD2Hrp30DNRSIEQJK928XUm6UDRDTrnzwJwg6YZFw7
	 JFTPQA3n7Gq+GyY1OtKw/7RmwoUurKawvTRATVFIgKPLT6mypaRIML8RDZg9/Lntsm
	 XELcTO09QecPrqvDbP0XABaroBc+SyKncDq0adGUPovy/4nflLCdIC+dAC8wp9Imn0
	 eFLUvyoqUIQ2y1uXgKGw/JtszuzCauG7aUzWsfDpbP6HWNgiDfUbzm3ssQOyNk1oHe
	 t40gM0FLw1TERXrVkLk3YoiC9JTG2zCoQrPAg+9WPHBKAZzp/9APg3ASNIoNawH2Wp
	 18nIY9jPmhrwvPmW6/31Ppjz7EtzBHWB3w32TUKwWvpl5Iiym4q
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5878:520e:9384:2dc2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3C1BE2006F;
	Fri,  4 Jul 2025 19:27:31 +0000 (UTC)
Date: Fri, 4 Jul 2025 19:27:29 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question: how will sha256sum be implemented in git
Message-ID: <aGgrIWSitF1NsN2L@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Aditya Garg <gargaditya08@live.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <PN3PR01MB9597524FAEAA3B26B15804B9B842A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ShcI8uNvcHB5fRy2"
Content-Disposition: inline
In-Reply-To: <PN3PR01MB9597524FAEAA3B26B15804B9B842A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ShcI8uNvcHB5fRy2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-04 at 11:18:12, Aditya Garg wrote:
> Hi all
>=20
> I just read that git aims to transition to SHA256 by default, and convers=
ion from SHA1 to SHA256 is needed for old
> repos. I was just curious how will that be achieved.
>=20
> Dumb idea, but maybe we can just encode the existing SHA1 sums' string to=
 SHA256?
>=20
> Eg:=20
>=20
> $ echo -n 8994f255af5451b6cd1db01ee16d8cf15b9df81e | sha256sum
> bf8d6d915848377db81ee47e883c0a683b3d86a49ab120191ea1c3d76a30c33f *-
>=20
> so bf8d6d915848377db81ee47e883c0a683b3d86a49ab120191ea1c3d76a30c33f will =
be our new commit hash.

This would unfortunately still be vulnerable to collisions in SHA-1,
which is the problem we're trying to avoid.  For instance, if I can
create two blobs with that SHA-1 hash, then I can also create two blobs
with the corresponding SHA-256 value, since the input in this case is
just the SHA-1 value.

The way we do the transition is pretty simple.  Blobs don't change; we
just hash them with either SHA-1 or SHA-256.  For trees, we re-write all
of the entries to use the SHA-256 object IDs instead of the SHA-1 object
IDs and then we hash the result with SHA-256.  And for commits and tags,
the headers that represent objects (tree, parent, and object) are
converted in a similar manner and then, again, hashed with SHA-256.

You can actually see how the conversion operates in
`object-file-convert.c`.  `repo_oid_to_algop` converts an object from
one format to another based on the loose object map outlined in
`Documentation/technical/hash-function-transition.adoc`, or the v3 pack
index functionality which is not yet upstream but is available in my
`sha256-interop` branch.  In general, the hash function transition
document explains a lot of the decision behind why we're doing what
we're doing and how it works.  I have to give credit to Jonathan Nieder
for writing the document and to many people on the list for helping to
contribute to it, and I encourage you to read it: it's not too complex.

So with this approach, the SHA-256 object ID is computed totally
independently of the SHA-1 object ID but in the exact same way, just
with SHA-256 object IDs inside.  We already have support for
SHA-256-only repositories right now: you can do `git init
--object-format=3Dsha256` and create one, although not all forges and
tools currently support them.

The process of the conversion when we're in interoperability mode means
that we can take a repository that's in SHA-1, convert it to SHA-256,
continue to interoperate with the old SHA-1 version if we like, and
then, when we no longer want to use SHA-1, simply stick with the SHA-256
version and avoid using SHA-1 at all.  That's part of what I'm working
on right now, and I'm pleased to report that I'm making a good amount of
progress.  If you're able to attend Git Merge this year, either in
person or remotely, I'll be giving a talk on this topic.

I'm also planning to open a discussion on the list within the next
couple days or weeks about some protocol extensions that will be
necessary to let us fetch, clone, and push all repositories in
interoperability mode, so please feel free to follow along for that.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ShcI8uNvcHB5fRy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGgrIQAKCRB8DEliiIei
gZ0OAQCdcTB1w6ru7Gf7588NbVw6bYMsUu3YkoPqIuFLBGgjBAD/f7Dx7wbBrAT/
DTWLd81jWIJwlUlnplbpsee9Gq6g7QE=
=Hn2Y
-----END PGP SIGNATURE-----

--ShcI8uNvcHB5fRy2--
