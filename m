Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ADC2905
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757377766; cv=none; b=JKqZ2n/Mg7LmIcIlwroljC/0KK4jQwHc5Juo5xFliXvVA8GSr3u6EJNtnRyz1vKghUAtB/KIMv3dzMRdi3niouGkYfqtJPt8XEu5vlufr7ph+0zOXNRvA/SfEj6oDmZCd6pTLF7DctezFghwNOU5mkXsi8FgwHsobfmTqvUh0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757377766; c=relaxed/simple;
	bh=z/lp+dIsmAdbmzpZ8WpJaFN7HX2wW86jsFivaJ0hMV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIeYp19eI3u1eE33rMY0xd7q4JKtA/07dreb9PgpkPGIVfO+rLU6ZyCDfXJVDWySmw2Tze1Cu9cN8ZBI+5U9l24aYqtLApVx9Cl0JZ2u81nDEnkyY1QDFh9ex1dQkUl6hyqzw2k3so4+NXqOuM55fxe4pVJ1uevy7fr4C2Hzdpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cn6jwAn4; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cn6jwAn4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757377762;
	bh=z/lp+dIsmAdbmzpZ8WpJaFN7HX2wW86jsFivaJ0hMV4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=cn6jwAn49+4hX56+JSmlwe4KnFd3iobl9e7nrl9Jl+CjH5b9wqylqFD7zfhJDkZ7z
	 HgeSXROd9wuwk6uMCSIlBeV2w/iIQTulDv+p3aBmYqAdT8Lz5MOPXuIKAZwFPPL65r
	 41aAmzuODmRy218OZ2IaQIajgvDx+P1OCODHOGnm+zYBOjgS7HviILbzVHuwxrA9+0
	 kwKELDUQjYjrFrN/TkgmcPxnv7HrFzI7P7mvc5HJbn7uzTzeJ19t0JZ+Lmat7x4kL2
	 Wu4GRyaIROK5ycyQTPTloBNSmXUbeO0vWMjnI5jdjSCBlxfxE1gpmGtqlfFRR/GZh0
	 z1hJXxQbP3V9nQqr5t9m8ZlzKehXzoTea7icGmL7xV4BuPRPb8paSKxLspp8kZreuK
	 cNOHamUeMAz52KsAz7w95PR+LTdKywXKfsm9vqPzecx/IpBcyNiwNBRlVm4/zCo6MM
	 bKvuN48c5VIc5wZB6Asw8k1NBVpoghxMS83+aQwCUtDaGFDHgJO
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:91aa:86f1:d85a:ac64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C9C1A20106;
	Tue,  9 Sep 2025 00:29:22 +0000 (UTC)
Date: Tue, 9 Sep 2025 00:29:21 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Running out of inodes on an NFS which stores repos
Message-ID: <aL904XGUmXmnyXGl@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
References: <20250906141711.64419-1-five231003@gmail.com>
 <aLxUkTzuVaZrWDs2@fruit.crustytoothpaste.net>
 <DCN87S14V9G8.3BAV5XX1BDHKM@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2RuobakBZgzl5K/H"
Content-Disposition: inline
In-Reply-To: <DCN87S14V9G8.3BAV5XX1BDHKM@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--2RuobakBZgzl5K/H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-08 at 07:05:08, Kousik Sanagavarapu wrote:
> Yes, I have now set the following config surrounding gc
>=20
> 	[receive]
> 		autogc =3D true
> 	[gc]
> 		auto =3D 1
> 		autopacklimit =3D 1
>=20
> Curious to know if this will have any noticable performance impact
> though. As I mentioned in my previous msg, these are small repos but the
> number of repos being created and the operations performed on them are
> large - mostly pushes,

The `transfer.unpackLimit` will not have any impact; it's in use at at
least some major forges.  Packed objects can use things like bitmaps and
other functionality, which forges like for performance.

The gc settings you have will cause everything to repacked after every
push, and repacking data can be quite expensive.  At work, we repack
after about every 40 pushes or so.  You may wish to use a different
value.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--2RuobakBZgzl5K/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaL904AAKCRB8DEliiIei
gQ7KAP42RQrURLlnobJJ6kAoAQ9u6whOx+IJYeXH5+0Sdm9JBgD9GJgas2yJqQ3z
/mPzOGqAX76qY2FhuGge5PJO9LjHsws=
=PHuH
-----END PGP SIGNATURE-----

--2RuobakBZgzl5K/H--
