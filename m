Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9030A2877E2
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759358536; cv=none; b=uLW/XbzvaYZYIdwqHNl52AsFc6t+3fdPSMTUheQvZ/PgHUGrpvuG28h7nCN8T8ZJxV5jJcyQTWuQz68xzyXMXCVyrcDo1uAT1SJiVU0in5cPId1jeV7FMko/vOcHK8GMP2RIj6SvIqMcpSpOFzeocQV9vsXgirUsoUyXbLZt3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759358536; c=relaxed/simple;
	bh=veACstP6HT1my4v0CVUix/FCn6s4Hcb4p45nStVvob4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BS5RjB7LbcLxjeIy5SrTaXsHnt9wfdcn6Ijj2NQRHHrfzlVakW9xj9pLAOhdVexsG/hV9R99454nwPOR9U4bqoNH+e/WpOl4MALfQ9rrWbsETcG97WUI5E5FbtRReeh8lsw5AoomcPUj/R9+HMIghJqRrboWJo5KRUJ29EyzDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=C/Y8WAc3; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="C/Y8WAc3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759358533;
	bh=veACstP6HT1my4v0CVUix/FCn6s4Hcb4p45nStVvob4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=C/Y8WAc3m8VDmaViaCQFmfq18NDyTIvdQOymc2Y92IwMvy7LaewMjIqa8mop1LL8s
	 iVftjmep3TZxGtyhzr5/1UTsUh0wCrODV9/lxyMt2XKRD4VOW5YceV2Xr/jHeiNbRc
	 scbHcjJxzJnHeyOuwmn/+PJH2H2zdMzvbYSvdqLNmGww20Xzuw2HbQuX/tIX7U1PXq
	 DDk+upnfZx3CFgtYFWz3ERCHPlyvlPUHnU/wQGgsq8GFeA/e5WC3a6peCGJ3OlytBh
	 PxBUh3c3M+KGvqgTm0noQGpM3mJ2CaDaGn64Y/GGPEWgDjRK3ZU7STRrZ+M/2V9b3h
	 4FOhsWIrQueHKNlrQgVG7npOFbXkk6/EaxD2/OQvv+5P7Ma695tsFLyVvr5xRIpFck
	 Ak9rzWASVL+htsTsuBus3vcxMFffYMpvoz6v9ksiXasARrJzpdy52ZwWYmS0dyCgP4
	 PasgHcrvuQjeD6WEf6k6K+A+zbS1Op9YvTky6xzpDnTHrMYRM8Z
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb6:3c64:95b3:ebcf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 59BAB20113;
	Wed,  1 Oct 2025 22:42:13 +0000 (UTC)
Date: Wed, 1 Oct 2025 22:42:12 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aN2uRCbajBhZT08V@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <aN1QUDzYli0GsGy9@nand.local>
 <xmqqecrm1hs1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4F629Kp4NOMciJ/z"
Content-Disposition: inline
In-Reply-To: <xmqqecrm1hs1.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--4F629Kp4NOMciJ/z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-01 at 20:36:14, Junio C Hamano wrote:
> What is the recommended workflow if you have unpublished work,
> written back in your private SHA-1 clone of a project, meant to be
> submit someday to your project, that used to use SHA-1 but has
> migrated to SHA-256?  Convert locally your repository to SHA-256
> primary with SHA-1 compat and then push to them?

We don't have support to add an algorithm to an existing repository
(although that is a desired feature).  If that existed, you could add
SHA-256 as a compatibility algorithm to your SHA-1 repository and push,
or in any interoperability scenario, you could create a SHA-1 main
remote with SHA-256 compatibility, push your changes there, and then
push from there to the server.

The interoperability work requires that the client support the server's
main algorithm for pushes.  This is because with protocol v2, the client
gets a capability advertisement with supported algorithms and can choose
one for the operation.  With protocol v0, the server sends capabilities
as a read-only (GET) operation along with the refs and doesn't allow the
algorithm to be chosen, so it's impossible to get a ref advertisement in
anything but the main algorithm.  Since protocol v2 doesn't support
pushes, we can only push things in the server's main algorithm.

For the avoidance of doubt, I have no intention of adding support for
protocol v2 for pushes.  That would be a nice feature and it would allow
lifting that restriction, but I also have a responsibility to myself to
not explode the scope of this project more than it already has.

> Presumably the server side _has_ already done most of the conversion
> work so, provided if (and this is a huge if) we assume that the
> conversion done on the server side is trustable, we should be able
> to _clone_ from the server in SHA-256 primary SHA-1 compat mode, and
> push your unpublished changes from your SHA-1 private repository
> into this clone using SHA-1 protocol (i.e. no conversion to the
> original repository)?  And upon accepting such a push, the receiving
> repository (which is still a local clone of the project, but the one
> you recently made and is aware of SHA-256 world) would now have your
> unpublished work in SHA-256 (with SHA-1 compat) objects and everybody
> is happy?

We always use only one algorithm in the protocol except when we need to
map shallows, objects missing in a partial clone, or submodules, in
which case we offer a mapping of those objects only.  The mapping is
always otherwise done on the client side if the client supports both
algorithms.

You can create a SHA-256/SHA-1 clone from the server (right now via
initializing a SHA-256 repo, adding SHA-1 manually, and then fetching)
and _pull_ your changes from your SHA-1 repo, though.  (Pushing from
SHA-1 into a SHA-256/SHA-1 clone doesn't work as I mentioned above.) You
could then push to the SHA-256 server.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--4F629Kp4NOMciJ/z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaN2uQwAKCRB8DEliiIei
gRH3AP9H6+qJNzB3FjWu+4mXMk3TByA7u57NRRjgGcKYtEloNwEAsjGrJ9KqtLwl
0P/S1Lc7tr9c6WUyf0Co0rTb8LF/Ng4=
=0NUy
-----END PGP SIGNATURE-----

--4F629Kp4NOMciJ/z--
