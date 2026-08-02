Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42803DBD5E
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707714; cv=none; b=QY+FABOZw+MRWOh5kdeUIE0zE9JhiG3DMuhJoMIWNC8lNixjnS58Wk3XxNRpqT6Pob7uJ1X78r1Vfg1bWXcvV+OzC3icziuws5HIVzStnO7LzoL4JoJDzAcTaY0VQ3hAyG/YIHXJRCSDztUvUrgaxD22ArZnxceK9rS4l5V2KJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707714; c=relaxed/simple;
	bh=e/fXP+tCRxnc28meqrKwp+eH9DvIRFapLdlEId+L5a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB0Zy7tvnXvOFdC+T20+e6JhYDga7Tk0fYVao0n6TxsDLHGChYIJukw8p0OY2yiQJBc7Zl4OHqFz4frT2fC3eodE7R+NVnXngmZoufpjYKXHdgrGizbArmkY8TE/PefHCRoyVmedw4gj3j/HRC68yLPYDGp9fiq+7MOhoQGqcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Yowpjq6b; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Yowpjq6b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785707711;
	bh=e/fXP+tCRxnc28meqrKwp+eH9DvIRFapLdlEId+L5a8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Yowpjq6bMrFbTk0ncsNSE6BHZPMJPyM2XbIMfuzy1UNJCDUIJjsXZPEckjT556gGs
	 vvU1yuBwPAZLGiH8mOEHg1m+uWg3729uB67xuVHd3FVDXii+bnxAtgKpTrphRUH09m
	 9jHL9Uybe3PNwuhutQZGxGefCkd7absc7fwC83cEvrZ1ab49WUVAUvb88R2sj181Jk
	 wdUgREwX2D11NIKAMYwt0Tn24sWLeTFe4Qq8flT0tneAaSU+jxQzql8g1LQi+QIoKv
	 damjV3sWrnjFtLoASRIqHf3GX8xKZmGhxQlE8u5zQfZKJOr4U5NEwYWXt4KRJDkTtO
	 HSdZ8HLvWZ7OmKiXdC9v49FadHQ1GRxW7yeQk+K7FLmRxUz5wIXpzVlpOavgKochtA
	 zFHQ+ShbYK0Y02sSXIeO25GD75TbFfCYWuqMD71ih9tcaKOVWWjIeDvVIjxB+DWj6u
	 alXo6ZVg2MHQ1D7Av3pG2cKNYhQtonhJWptQrVxCTxoJDJASuCv
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:117f:c26e:50ca:6746])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BF924200C4;
	Sun,  2 Aug 2026 21:55:11 +0000 (UTC)
Date: Sun, 2 Aug 2026 21:55:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Git 3.0: restrict hex object IDs to lowercase
 only
Message-ID: <am-8vm5QwLQhiXaO@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <xmqqjyqclwf9.fsf@gitster.g>
 <amu_rzanuYc_2lww@fruit.crustytoothpaste.net>
 <20260801144527.GF2041176@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jTRfy0c7VV0awmXZ"
Content-Disposition: inline
In-Reply-To: <20260801144527.GF2041176@coredump.intra.peff.net>
User-Agent: Mutt/2.4.1 (2026-07-04)

--jTRfy0c7VV0awmXZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-01 at 14:45:27, Jeff King wrote:
> Another interesting case is upper-case hex within objects:
>=20
>   $ git rev-parse HEAD
>   b85b9595a8136c79551340c3d73443a62eddd893
>=20
>   $ git cat-file commit HEAD |
>     perl -lpe '
>         if (/^parent (.*)/) {
> 		$_ =3D "parent " . uc($1);
> 	}
>     ' |
>     git hash-object -w -t commit --stdin
>   5a08c6b3f06d91c4a09c8d7ea6e9c8ce200b7698
>=20
> Now there's a parallel history of otherwise identical commits. I think
> this is mostly "if it hurts don't do it", but we generally try to avoid
> multiple representations of the same data within the object model.
>=20
> I think only commits and tags are subject to this (because the tree
> hashes are binary). I don't know if you'd be able to stumble into this
> accidentally with most Git commands. We don't intentionally normalize
> case anywhere, but I think most code will round-trip through a binary
> hash at some point (so "git commit-tree 1234ABCD" would incidentally
> normalize the case).

Yes, this is true.  I agree that multiple representations is a problem,
and although that can be an issue with signatures, we shouldn't make it
worse.

In addition, those objects cannot be round-tripped through the
interoperability code (which only writes lowercase object IDs), so
they're effectively locked to SHA-1 only.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--jTRfy0c7VV0awmXZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpvvL4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4MpjOkVEl6BWlDhOQqoq8xIsIhi3us9m3kFn6GfVHVI
FiEECCzmip28ZfuD0cORfAxJYoiHooEAABI4AP0RfOUb46eu+soNM2FmrOJQVQfg
usXdutMKGWR2AuofhwD9HxRA+lAC1fpxld709ezJO0tSO8LDWHNDTJGiF4kQqwI=
=chKs
-----END PGP SIGNATURE-----

--jTRfy0c7VV0awmXZ--
