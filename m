Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7E61C84A1
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752269395; cv=none; b=Vcn4ofnMFtvE9HIM9MNYVewVBP6PuUxwYJYfpahv0W5oQ8bi/E9lQ8s3uh88ZUuPH3bmcRuwRcOVHiYh2Ecgt0hFoO0eyh3a0O4XC5As3M9hitii0k4J7UQq4J0vE9QdeZ/oMhvIwnQHcXZT7dpFT5trX+T+d0nXIpLdtZFOVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752269395; c=relaxed/simple;
	bh=iSjWRoO8236DgL910wMEAuuqh1elKd14oYQjYZijXKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujcbhpWIeTHaIiFzi6sOigZ2FsEV/1pBGgVwsmoUmm2C/FErDv5Y83m9JTUCGWCJp9fYMawW+oPDPUVEY+Opjul51O/uz5VJ06msmZWcexiKBgTZ3VHb93F+xj3dEZ738VdItblzTMlz/t8QUT0veH+aGz1xHOYQZlufmI9CCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ZGOmMXjo; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZGOmMXjo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752269381;
	bh=iSjWRoO8236DgL910wMEAuuqh1elKd14oYQjYZijXKw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ZGOmMXjofZxUUv65ti0jSfO+y0CyVk2mhKtl6pdszUHq48zd3UAf9go3GQOcGIi92
	 tySlC3aGgbbyD7TEmMSkVwAgZL88yp/l2VCPTSKSsxk/B/9ejh5zxpEZz9R5RM0PjW
	 mQN8gB+bgSZK6sflZ0Lb7+eBiGBadqXDcHa8ohOeh/WQmWgQ+idurfoVDyk4/VZS7m
	 m6vy/ejZs6JdhZCTDci9qIbLQYUniVYxHt4r+1Xg2Laf53bo0WZIuT/9u/tSkauWBd
	 vcSFNlOId/DpRPYdcBLpCPn6cLFw6fwpLG5IMAzfzuySd6ZtuULJLmgAQl70pX22zJ
	 4+CP82dd3RbU02DTC2IIYTyoDVKYHyiqMtQIRI3xOozfzcs2MmfIE6LNIZsSxCPCd4
	 uqBj3Vb9tJB12nQKtqyKwGgAWU5ZTVLI38wR749l8ryl6cpuUMrOxYuGOiMrO5lTsq
	 k9+xYoivMbYxRXPohSUWP56wKL4EsXbFgxhOeg+t8ZOZ/78Vyxb
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A47192006F;
	Fri, 11 Jul 2025 21:29:41 +0000 (UTC)
Date: Fri, 11 Jul 2025 21:29:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc: Collin Funk <collin.funk1@gmail.com>,
	Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Yi EungJun <eungjun.yi@navercorp.com>
Subject: Re: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
Message-ID: <aHGCRLGHEB0m_cXZ@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Yi EungJun <eungjun.yi@navercorp.com>
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
 <20250710221641.857081-2-sandals@crustytoothpaste.net>
 <r34i7fhxwbxhppc4ia7lpyr3xqj4tgusaeikaaonpwtywlywxw@ygfmv3f3q67u>
 <875xfypsom.fsf@gmail.com>
 <idgdx2au3zgpowozspvu6ttvehybtwwuqf5kwqga4yok7uo2uj@wno7evyjg6pq>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i6DnStEBSlKDsUWu"
Content-Disposition: inline
In-Reply-To: <idgdx2au3zgpowozspvu6ttvehybtwwuqf5kwqga4yok7uo2uj@wno7evyjg6pq>
User-Agent: Mutt/2.2.13 (2024-03-09)


--i6DnStEBSlKDsUWu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-11 at 20:57:03, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> except that it would be incorrect, as language tags are defined in RFC5646
> and are larger than that.
>=20
> most importantly, deriving language tags from locales provides some very
> useful tags when including the characters after the _, because zh_CN and
> zh_HK use completely different scripts, for example.

Yes, that's true.  You have some private use and some irregular tags and
you also have some tags that include scripts or country codes.

For instance, Swahili can be written in Latin or Arabic script.  As I
understand it, the Arabic script form is older and less common these
days, so if I learned Swahili (which I would like to), then I might only
learn the Latin script variant in a course.  I would need to specify
that script in the language code to be sure that I was presented with
content in a form that I could read and understand.  Similar concerns
exist with the variants of Serbo-Croatian: some are written in Latin
scripts, some in Cyrillic, and some in both, and it's not guaranteed
that all speakers understand all forms.

And then there's pt-PT and pt-BR, which are not always mutually
intelligible.  Most free software I've seen ships these as separate
translations.

I don't want to implement language tag parsing here since we don't need
to do that.  I would like to do the simple thing to prevent commonly
used locales that don't represent actual language tags from being
included and not overengineer this design.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--i6DnStEBSlKDsUWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHGCQwAKCRB8DEliiIei
gRLEAP0ZQyLyyhE1yoEj2SygcvWxk5JN4vsoFkK5NDxIFd55HAD/WpFL+Ia+w+n/
hTAzJaqt53k0x+96wh3dbkKNpKShSww=
=Xt4n
-----END PGP SIGNATURE-----

--i6DnStEBSlKDsUWu--
