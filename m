Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB718B479
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 22:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970134; cv=none; b=BNFShELZFPFHoSDHJ6YbiOHtmcx8gSr+tErdmjPsdfwgj7XmxqXwZCKBErVIbb8sXLgv8a+JRFgdFya49O+SvDf1YC42BZHsAAK5d/6vsk2+VkVjjc1w2IEy5RYAib2m8ynbkmrCGV50xi63c3khVZDefX242I+9pPBeojDveFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970134; c=relaxed/simple;
	bh=531sT2jr8NmsN4JFXH9c6Ckr3/jPk/X9fQNJMRHaMpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJowT449cQ6TJ777CmcPKdljNPS0niC+bB3EhSVlSpAzBfE712HigDbB8rEoOfAjNitswzZgWomRrr3jNkJEGE6Xp1Z/zrpFdH+hPBwY3g9T/kQw/BH7cMo3zsii/FCks9L26xgmKNvOT3EscMBp8X7k684APFqMzfZnFZwqPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=pau1j8/0; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pau1j8/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1724970129;
	bh=531sT2jr8NmsN4JFXH9c6Ckr3/jPk/X9fQNJMRHaMpo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=pau1j8/0k8oBuZFE54k8FyFgpcsuKfFJOpY6oXdkDl6A7e2psJ0UBWATU9UUqGU55
	 KSG6vnHHLgXqIHWw+jrSzaPpZ17i1qMC7gdLQd/Q2ODGWN4QELq8FyFqfD0bWaCScM
	 rvAd3tCIOQPX6iQ9LnR72yeh+ZsAowpHDj8YaRon1xCy4256DdXWt6+o98fJdPEySO
	 gf1WQt3njW3nqdv3q18DLLTgJLNH2K5gGqmF/d4D9eh99nOQkd6whYEXclrQW1mMxT
	 XK14EwAA+Zn2xxN6nMW2/n01esrfdMd8CbiFQhWwT4cjoaZEE3PSEnX94f5LItnGoX
	 vT8VzrjxF++OmUUWJfRK5AhkyseUdtV9gCxwwHfHe+tfmDQsJFQ8lL9FMEDXAUVcrb
	 l3qD1yrnciZo+DnLk4borxI7l/dx6HiRm3utpy1vnOcIJmCWdxAe63tyPKwBqsbQgq
	 5iDsMqON+33GQeJOIecNJVwXRu+Lp1ZOaaeFJcQhdkMOTmTiUzL
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C6F9324429;
	Thu, 29 Aug 2024 22:22:09 +0000 (UTC)
Date: Thu, 29 Aug 2024 22:22:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Yukai Chou <muzimuzhi@gmail.com>, git@vger.kernel.org
Subject: Re: Tags auto fetched by "git fetch origin" but not "git fetch
 origin main"
Message-ID: <ZtD0kJU_OdBBktZ2@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Yukai Chou <muzimuzhi@gmail.com>, git@vger.kernel.org
References: <CAEg0tHRbGBBq7i78bTSfws_WZO=2W7xuDwiT2qFA5iOza8qDDA@mail.gmail.com>
 <ZtDo--AY43-bPTHG@tapette.crustytoothpaste.net>
 <xmqqy14ft36l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cD2PdMP9e4OyK0eq"
Content-Disposition: inline
In-Reply-To: <xmqqy14ft36l.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--cD2PdMP9e4OyK0eq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-29 at 21:44:02, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > If you want tags nonetheless, you can use the `--tags` option, which
> > should fetch tags in addition to the refspec provided.
>=20
> But doesn't that grab _all_ tags, not only the relevant tags that
> point into the history leading to the commits being fetched?

It's not clear to me.  The description says this:

  By default, any tag that points into the histories being fetched is
  also fetched; the effect is to fetch tags that point at branches that
  you are interested in. This default behavior can be changed by using
  the --tags or --no-tags options or by configuring
  remote.<name>.tagOpt. By using a refspec that fetches tags explicitly,
  you can fetch tags that do not point into branches you are interested
  in as well.

That implies that `--tags` or `--no-tags` simply changes whether that
limited set of tags is fetched.

But the `--tags` option says this:

  Fetch all tags from the remote (i.e., fetch remote tags refs/tags/* into
  local tags with the same name), in addition to whatever else would
  otherwise be fetched. Using this option alone does not subject tags to
  pruning, even if --prune is used (though tags may be pruned anyway if
  they are also the destination of an explicit refspec; see --prune).

That implies that all tags are fetched.

I think we need somebody to test things and clarify the documentation.
(I'm not volunteering because I have a lot of things on my plate right
now.)

In addition, it might be useful to add a `--relevant-tags` option or
some such that simply fetches the relevant tags when arbitrary refspecs
are specified.  If someone felt super interested, they could even make
an additional generic option over other refspecs (I can imagine
something like GitHub's refs/pull might be interesting for users).
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--cD2PdMP9e4OyK0eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZtD0jwAKCRB8DEliiIei
gZM0AQDKScvC8vEApgaN6fSo+NWKP1RNY/29AxjngP+B3fVOtgD+LK9SwL1sRNbB
SIHW3z3nvRGJuJ9zW3IugWvf9rdGtw4=
=4s4P
-----END PGP SIGNATURE-----

--cD2PdMP9e4OyK0eq--
