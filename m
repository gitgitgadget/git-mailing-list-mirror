Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF61755B
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720127334; cv=none; b=BvGYbEH8fPjdELFr4wc6eDhvMIiZWFeGbXSbert7pdfJZ1dguNyDYbXTGObNKtsX6GaDP/oWtr6/L7JLufA8d8AQBVUVlYU/4stEqjE6eRhV075+IYa11eXpsTChDXYK0dfd8xbHU56UsSz9uypqq4140DH2VWSnW97N6SRc/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720127334; c=relaxed/simple;
	bh=sc0imKM7lYzUwwhNirFkmYAZdokyXkMlLdkzBxne/70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emWpff2E08cz4MxR2mIQt/x+FWEMhXhkQwFSCm4RaEY1rMKZl37G/Sz0bPyQeyWiUknA+IJyFh+vb7tq+gH+7Wc0zC85hrlke0NV9a6KjOb38INTqE0xpFAAHu9Omy88n8qp9HDMUF+mWk7YPmuBIZxeOt+22qllRnbolhCeSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wIeOQ+xD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wIeOQ+xD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720127330;
	bh=sc0imKM7lYzUwwhNirFkmYAZdokyXkMlLdkzBxne/70=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wIeOQ+xDsFsscPjWwmjMQpcHMdZ0thkEx5H3Ecj7e5S9/pLeG50EvL+Axl3bmTKm4
	 cvGarS2LUMCENcOXcGwhKDeYBsfClgpsAHv39k9o/KtahjE2660ehUYZ7TKycOxxU0
	 8fUuJgimpe0rnAIV1e2sQXK0DVSTnKUe8b8Pb0ce1zjIyqBws4Ks6DgjHOWapKkZZb
	 nXsTGc/1arQ4v4Kcj56SZDlsgf21X3qFvt1UGDMarLnfUXmxrYRt1gzHI38llHitRl
	 avkceo8aaAmdVnx42QdEMCqIHu0eIIJIuwZpdNA6mUH4srqWbDC4PxIiBUjQwNfvlO
	 XcwljXBkTwwdqcaroK9w1qNGH+3JPA5lxYcYMdLPJ8BWsycIdbWyh5BLLvFkiX1zSM
	 Qr9+TUSu9qaclMHDClvps9UNKzcppn0PVTRfO6gdiGT9Irzy2RTtledUs8yV7SToA5
	 OXrtEoJaEGhQAxnJmEjF4X3WjK5kx+6p3iUcauyusgXbuXQ8x8U
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3E19C20992;
	Thu,  4 Jul 2024 21:08:50 +0000 (UTC)
Date: Thu, 4 Jul 2024 21:08:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] gitfaq: add entry about syncing working trees
Message-ID: <ZocPYKyVzSDIekTK@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
 <20240704003818.750223-4-sandals@crustytoothpaste.net>
 <xmqqjzi191fw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xFPJciQ0OaOzgSPk"
Content-Disposition: inline
In-Reply-To: <xmqqjzi191fw.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--xFPJciQ0OaOzgSPk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-04 at 05:21:55, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > -Credentials
> > ------------
> > +Credentials and Transfers
> > +-------------------------
>=20
> I can see (and appreciate) that you struggled to find a good section
> to piggyback on, instead of giving this topic its own section.  But
> do these two make a good mix?  They seem to be totally different
> topics.

I can try again.

> > +It is important not to use a cloud syncing service to sync any portion=
 of a Git
> > +repository, since this can cause corruption, such as missing objects, =
changed
> > +or added files, broken refs, and a wide variety of other corruption.  =
These
> > +services tend to sync file by file on a continuous basis and don't und=
erstand
> > +the structure of a Git repository.  This is especially bad if they syn=
c the
> > +repository in the middle of it being updated, since that is very likel=
y to
> > +cause incomplete or partial updates and therefore data loss.
>=20
> A na=C3=AFve reader may say "but isn't it the point of these cloud
> syncing service that they will eventually catch up???" and we may
> want to have a good story why it does not work.
>=20
>     You create many objects in one repository in loose form, cloud
>     syncing service kicks in to transfer them to the second
>     repository, and then in the original repository an auto-gc kicks
>     in so some of the loose objects fail to propagate.  The packfile
>     that is the result of auto-gc will eventually propagate to the
>     second repository, but before it completes, the second
>     repository would be in an inconsistent state, and especially if
>     the ref updates are propagated before objects, then the second
>     repository will be in a corrupt state.  It would be a disaster
>     if another auto-gc kicked in there.
>=20
> is one scenario I came up with.

The most common situation we see is that refs tend to be renamed to
things like "refs/heads/main 2", which is obviously not a valid refname
and doesn't work, or the ref gets rolled back to an older version.
Working trees also get stuck into weird states where files keep coming
back or getting deleted, or the index gets two differently named copies,
neither of which is "index".

It is _less_ likely that objects are renamed, but it could be that the
tool thinks they've been legitimately deleted if the loose objects get
packed and then they do get deleted elsewhere without another source of
those objects existing.  I'm not sure how object loss happens in the
real world with these services, but there have been users reporting it
on StackOverflow, so I'm confident it does occur.

If we have users who ask about this, I'm happy to answer them on the
list.  I don't want to explain the various and sundry scenarios in the
FAQ entry in order to keep it short, but I can find several examples of
problems if need be.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--xFPJciQ0OaOzgSPk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZocPXwAKCRB8DEliiIei
gcL6AP9WRSsu/8ZllYpuK0WeJpC8tBne7t2CMxlbxt2jYUGUGgEAn5LPmbhEUrbk
QExn/jPCdD2jJQfP2Aj1Hfya4/nhMwQ=
=2iny
-----END PGP SIGNATURE-----

--xFPJciQ0OaOzgSPk--
