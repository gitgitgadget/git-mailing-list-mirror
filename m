Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC0261B6D
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989505; cv=none; b=aGpZpTSD6qBUD6rI4jyWJRsHkoBjw40YE+4MlydJQyyVg7xVkc8sQNZGiqusmBB1CS9i90M3BrEtUJpiZC4SDUOVsY/+aZPKhV52TovINnp+H7gRcq+epeXDGAKyaMmKihTE3TxxWdQFFV7xpQN18spce3eelB/ZblR4PzDiYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989505; c=relaxed/simple;
	bh=jwyZn3759JwNqBBMWLWU8lN2thGKaFh+cqW4Czu5AQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4bnCPTNZpVDBnlZQBWdXcv17/RQdjdUa5NkXlo4AkhRU2qInWZLEr38LUeqNshBEbil38sq6Frk34L4WnVUdoVmEOE+5IossSA8aUv4VbDzZGWTFgA5UoWstfi+sl60mMxWQJ62DOMSLBHOvH/7E9jC4ul9ysZ/Gj/wrPD5JdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=LzB1tqke; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LzB1tqke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1767989502;
	bh=jwyZn3759JwNqBBMWLWU8lN2thGKaFh+cqW4Czu5AQM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=LzB1tqkede3BajKmZRgLQdIi58w8uggQbO6Q4UjlxEruQIrvsjsIDX4hcHUFVXRgP
	 e6pUU7Lj/nJQ1okiY/1UzIpPNPX0buT4lZ36j7Lywo7/i4ywIUSIDcUSayhhnsc0OQ
	 qnMo28yPkHmeNwU1efESYYiRQEWujPANvGYtAPJ5tvZwUn/33Ylr/2eJ3BpGI9MRln
	 WVXX7PTZb9r19iOKRw1xJgq76CBFAs7yqA8IJlqfsCDCJi5UxQgBAyrv7FQVSV6QJs
	 VFSerJXV5Vn5XeefIdhvvwyM9YDLj3JdwUX6G6qx8tPknNwOZSe+LO8U5GMCH7/qmf
	 kQN08KLx5sP/fhwWpAEJuXyy8WJVKckKkcbtaphXgV3e8eg5gFFV0H+5lodNY3j8aw
	 hUpCfsSY/+1qTUH7Qjl6lhmznUvIZ3kZg1xT568v7AHQ07/yTyvJOANbHWR3GPaFmZ
	 R5Q6zcU6770muSHQzmEutieWWMY7PF8Z2y1rYHvEtUtUZWnkqKd
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8a11:cf76:28ff:b0fa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4E2D7200B5;
	Fri,  9 Jan 2026 20:11:42 +0000 (UTC)
Date: Fri, 9 Jan 2026 20:11:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitfaq: document using stash import/export to sync
 working tree
Message-ID: <aWFg_VUZH5_ZqTix@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20260109014608.42773-1-sandals@crustytoothpaste.net>
 <xmqqseceua9j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P5BS+IArb/CWmKH4"
Content-Disposition: inline
In-Reply-To: <xmqqseceua9j.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--P5BS+IArb/CWmKH4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-09 at 14:32:40, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Git 2.51 learned how to import and export stashes.  This is a
> > secure and robust way to transfer working tree states across machines
>=20
> Here "secure" in "secure and robust" triggered my "huh?" sensor.  It
> is a robust way, but is there something particularly "secure" about
> it, other than "it is less likely to break your repository" in the
> sense that is already covered by "robust".

We know that sharing a working tree with different users is not secure
because people can have things like hooks or config options that execute
arbitrary code.  Transferring stashes doesn't have that downside.

Considering that we used to explain that the only way to do this was to
rsync the working tree across machines, this option is more secure than
the previous option since it avoids any potential code execution.  It
also avoids syncing things like ignored `.env` files, which people often
use to store secrets, since `git stash` doesn't transfer ignored files
(but rsync often does).

But if you disagree and prefer to remove it, please feel free to edit
the commit message before you merge to next, or let me know and I can
send a v2 if you prefer.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--P5BS+IArb/CWmKH4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaWFg/AAKCRB8DEliiIei
geXzAQDGZKIQio1eJHTLcYE34J7nA+4CEznxE8JgCndJd8t43AD9HL2GgExQjZp4
fF6WuoGsdD0IzwkTAjJiDqVqRIyd+Qg=
=szbI
-----END PGP SIGNATURE-----

--P5BS+IArb/CWmKH4--
