Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502DC51C49
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364317; cv=none; b=m8hogiDM5KUw6syZkWS4UcI70aBoFrmo3SEHlvkHvVgPq58FZIgCSdZM7pdq5dfb07JsNmIrH6CIzWwmYDUBbVkpFLSH6yiLoTHU12/pf+AVKZzG+aDkBIiOm3WF5oj1WXfzTaOzKmlQn/DvmNXJr+GZpvsoEg3ZGbjDvKqDeE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364317; c=relaxed/simple;
	bh=RMmtOOxD9fipiKrg0jAosQLLh+A25Eavw9zyuXatd5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xy51jfjM0Z2+APQ3thyIss9NWyvWm7TDIheM4hgEzhfpOkrqzNLUb1+B5JaGHHwRzXHHnBzaHDPEaTQLk1IdhgAdfe8QBoN0MMB5FXs5bxYVKTrcGFmUjx4TgyGU7eowFgW+Uk/FQkoabRl8/DXi5uU6hB1hOM32lGyHsrDX28M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=LuklUS9f; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LuklUS9f"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1B9D65B3D4;
	Wed, 13 Mar 2024 21:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1710364307;
	bh=RMmtOOxD9fipiKrg0jAosQLLh+A25Eavw9zyuXatd5o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=LuklUS9foZWwxwZ2T5E9Tx4czpPpTdKC3ZKLhJEi4gKrV6cZG8lWbQsvJoy12Celx
	 Tee/4VCmZrusncJs7h6mssqb7R+uVFZip3RgHdxD4s2H0jT0qZN4J6bXC3rg6RpQPS
	 MXx6sjyK7eSTp3pc5BvcCWqMke2+FeyVipFr/I1wCKaET4bYhDFq8DhxA+GxWM4XFC
	 PCVRxj4eIMWcJi2b77hrnb7n4lgE+Znq+WZO8uvshXDd3a4UE4wI+zyFlUmdKDTIp9
	 ac8NtoR4VLbnykVTA84o6TSJgblvRoHD0UAdc3bRk3na+aQ0IYToeTZxF+fFMxbTSo
	 iDy4Ma2FdL3DtiuPaF7ul28hOhTr5rkukT08dVdEurKLU8NTsgbuXhYiB4xv+EnX+Y
	 SRS0FX5n7LXTL6R8GbNRGq+ANa0HqSDjwhDMBTi9479HqzyV9mpEoPa2NgDdy4alA6
	 OXJzVN+M2ICbMsoHHO/pxoh6P7ioeI/Arw93W3pqh0R/sgH0qZk
Date: Wed, 13 Mar 2024 21:11:44 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "Eric W. Biederman" <ebiederm@gmail.com>
Subject: Re: [PATCH 2/2] doc/gitremote-helpers: match object-format option
 docs to code
Message-ID: <ZfIWkJieqcPv5jA8@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@gmail.com>
References: <20240307084735.GA2072130@coredump.intra.peff.net>
 <20240307085632.GB2072294@coredump.intra.peff.net>
 <Zeo9oAkL6kxZRugN@tapette.crustytoothpaste.net>
 <20240312074513.GA47852@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NaffBdlI/P8VOUX3"
Content-Disposition: inline
In-Reply-To: <20240312074513.GA47852@coredump.intra.peff.net>
User-Agent: Mutt/2.2.12 (2023-09-09)


--NaffBdlI/P8VOUX3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-12 at 07:45:13, Jeff King wrote:
> So I guess my question was more of: are we thinking this explicit
> algorithm thing is coming very soon? If so, it might be worth keeping it
> in the docs. But if not, and it's just a hypothetical future, it may be
> better to clean things up now. And I ask you as the person who mostly
> juggles possible future algorithm plans in his head. ;) Of course if the
> answer is some combination of "I don't really remember what the plan
> was" and "I don't have time to work on it anytime soon" that's OK, too.

The answer is that I'm not planning on doing the SHA-1/SHA-256 interop
work except as part of my employment, since I'm kinda out of energy in
that area and it's a lot of work, and I don't believe that my employer
is planning to have me do that anytime soon.  Thus, if nobody else is
planning on doing it in short order, it probably won't be getting done.

I know Eric was working on some of the interop work, so perhaps he can
speak to whether he's planning on working in this area soonish.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--NaffBdlI/P8VOUX3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZfIWkAAKCRB8DEliiIei
gYPtAQDN7miuj71zxztdAe8w8RSTXEifaeANN20+VCur4F0E1gEAk9URNGokhhK1
7smmwAWyK6lKxNMnUkev+D4wN8v54Aw=
=DBcR
-----END PGP SIGNATURE-----

--NaffBdlI/P8VOUX3--
