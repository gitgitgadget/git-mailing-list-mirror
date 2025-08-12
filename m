Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F952F068B
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033375; cv=none; b=TM/SV85UeMcyC/U7vQhHcu0r3YL6dqEggAS2BdQiERW3B0YH8Dx7X0OCcnbmeEwZCsjKmULniV7uXf5bElmmnAQBA+R6kx1W5qD0dbykY2aKjOXcLsjiBff/zwsjZ6QvMxPOhyq0ra1UDkN52KOzctdOTfthrMtLrG4XePMSTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033375; c=relaxed/simple;
	bh=a9134ResrZWG+j2l4m2+Pb3xKU1SKXYxy5GssGJbIrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brVzrELZhe+4ZnpG1+AMFl+DRmJt6DJBGXMy+exwtsPGtMhn5byU0uDfDd+G4dGiS6VZR31mlEmwiOjQXhidqbJstXzccvkyq8w9qePpAXK4y+40asXxN3ryVA1iGfVtKMyFjB5RplWtyC5OIP+8ts8HRsJ/m/xRAQacdiQJ3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ZU1Ij19p; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZU1Ij19p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1755033371;
	bh=a9134ResrZWG+j2l4m2+Pb3xKU1SKXYxy5GssGJbIrA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ZU1Ij19pDyvVuu7eI/YbsC7MX+Lj9qL7yd+CzxOMcJxySgpwvKBc9o5zNOOPLv5BF
	 rvV2k7OtD+RZaf39kL+3Y0jO6NyYeQvsv2ii+ZuHJiDaQDA7lPXOwIUzECagDCylMr
	 BwznsrF3u0t8hjPAbHD6pPKGv7jyOQeDICaCCwoEIb/QpeD7EIS/UQ+VSK5810w8vr
	 aF7mlgSbdJ30ofjOhGE5NsKSVuAKLjSRi+CjoqY7segpkQkmhBtbPAbz1dQXMq/pIF
	 /fKi0O5s0DMB4gbGEX3b9tUf3ZF968IDqV0a8UBitw+Uo97a7UlCXhhIm0b0tjAR7v
	 1gqYqEtJyArPvG08vId8IR6PA9r5777NE/jqhDu1rZtkKEwSixpZuOseZldHbOSdoh
	 8CeGR14vwEpHh5LZdBeTI88u26flfCIZMgdQCTTi/bZsr4DbHjNOhLWyYfEfGuOb6S
	 5JMbi43xm+sJ0zn/nI7dGnA9LepIFcW7NL36OuJ55HN/OHPzUw5
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7bdb:5a3:7014:f6fa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8D409200B4;
	Tue, 12 Aug 2025 21:16:11 +0000 (UTC)
Date: Tue, 12 Aug 2025 21:16:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Andrea Pappacoda <tachi@debian.org>
Cc: git@vger.kernel.org
Subject: Re: Signing commits and tags differently
Message-ID: <aJuvGtiZ8ll_SeIv@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andrea Pappacoda <tachi@debian.org>, git@vger.kernel.org
References: <DC0JSOC14W8U.3UCX8TG6X7W5O@debian.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wqA9ZF2iwFVcBAxM"
Content-Disposition: inline
In-Reply-To: <DC0JSOC14W8U.3UCX8TG6X7W5O@debian.org>
User-Agent: Mutt/2.2.13 (2024-03-09)


--wqA9ZF2iwFVcBAxM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-12 at 15:18:19, Andrea Pappacoda wrote:
> Hi all!

Hi,

> I would like to configure Git to automatically sign commits using SSH key=
s,
> while using OpenPGP when creating signed tags. As far as I can tell, this
> isn't currently possible.

I agree this isn't possible with the default commands, although you
could solve with with an alias (such as `alias.signed-tag=3D"!f() { git -c
gpg.format=3Dopenpgp tag "$@"; };f"`).

I'm interested to hear more about your use case for this split, since
it's the first time I've heard about someone wanting to do this.

> What I was thinking about were a couple of options like commit.gpg.format
> and tag.gpg.format, as we already have commit.gpgSign and tag.gpgSign. Of
> course, differently namespaced options like gpg.tag.format would work too.
>=20
> What do you think? Does this make any sense to you? Let me know!

I don't have a strong opinion about adding this feature or not
(especially since I don't know about your use case), but I think if this
feature were implemented we'd need to have the format options default to
the current config option to not regress functionality for existing
users.

There's also the issue that this makes verification more difficult.
After all, you sign the data once, but presumably the data is verified
many times by many different users (or software acting on their behalf,
such as a forge).  That means that we'd either need to autodetect the
signature and invoke the right tool (which we may already do) or every
individual user would need to have the appropriate configuration set up
for both.

Again, no strong opinions here, just thoughts about what an
implementation might look like.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--wqA9ZF2iwFVcBAxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaJuvGQAKCRB8DEliiIei
gYajAQCCxsT58gV3GmoPS9H7DybWCeoWo1YsuraPE/i3ijF+VAD7BOQ2zs7fRy+j
oMuqCGhRkDXwWII2MtRDOb8F3IjChAg=
=HYVE
-----END PGP SIGNATURE-----

--wqA9ZF2iwFVcBAxM--
