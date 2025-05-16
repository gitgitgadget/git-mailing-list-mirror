Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18F1A704B
	for <git@vger.kernel.org>; Fri, 16 May 2025 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427595; cv=none; b=C7Z5sA4oKIqhu4E4aZflahVUDTQCXqgi2Eg0OV+liUxydE6/7mwH2gCan6IZ9z5oMlx+lBhhlGvH/4xyc8/I1uHPScO+KISFjU6+Mrjx0vpJalU2LvY2bGVOkpVSQPa4Pl24Uln29VPDQs49vv1npcphQC89HBtOmmRLUUP+dsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427595; c=relaxed/simple;
	bh=DOmOQVsb143dkDJVcgdxAuPCc0gIVBwyh+zAnW3uIH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L77M76zduH93akD/dLP6SxzD/T/42v8VPb6QWhY2XBni2dNyeomNqm9RiwUFx3tD0feFEkBJyaXCQXVnoWJfcZSp1y7YOY6OA6Zlgm6SJJGBJ0tsXxa6LF+gXVGHJSXDJX+PzruTPE6gU6VkbWF/eHTK1jPW6Joe7Noo1msCTmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=n1JXViYv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="n1JXViYv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747427584;
	bh=DOmOQVsb143dkDJVcgdxAuPCc0gIVBwyh+zAnW3uIH4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=n1JXViYvWWwAhomVsycpZ0pA99C001YkLzSU8SWMfGkM2orvK17rKDcRMJybPxSyg
	 wJpRJKZdyhBSxoxEsMf0o8rSDWTJdjdHJwh5lLWWwvUNY7P34S+QV06N5db16nQpzk
	 6iZD+XgtOZKjfkXZ2N8MXNG8XiparTyxa9Eq/jHe6nEEjRsoTUuoSvyhpqj//O5eGY
	 Xyb8NtoJTwx6ObBjRl0LEOOCMS8Wy4qxDsHOiW0cqtQVkfsnVLL98gYtarA+8tJMyV
	 sOIfbcZYHGJac8pT6SMEqhvLafnZ7ONmxlj+mHafRJyXpimX39Vjqb5hTxJSjAnNyd
	 VOvKiQ6/7e3n0j+qoXEYH4UGh6xvwk86vamt85IRjCmgDC8W8s6AA6Lytjjsq5UrGo
	 OfzF6bA9JQyJMHiU16aQzAriBQYq0ig/xIxYdzknTqwwgUYkJPhDvyqVOpWN3fon/c
	 T7EIkv8hKZWieuroSu5TmPOsXF8NiP/BxMyZCsoiqVRZR5YA6GC
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8B59E20124;
	Fri, 16 May 2025 20:33:04 +0000 (UTC)
Date: Fri, 16 May 2025 20:33:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Muhammad Nuzaihan <zaihan@unrealasia.net>
Cc: git@vger.kernel.org
Subject: Re: Small patch to add support for MPTCP on Linux
Message-ID: <aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Muhammad Nuzaihan <zaihan@unrealasia.net>, git@vger.kernel.org
References: <JH8DWS.72DKHPTI873H3@unrealasia.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kri3vNeYESN6xZVF"
Content-Disposition: inline
In-Reply-To: <JH8DWS.72DKHPTI873H3@unrealasia.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Kri3vNeYESN6xZVF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-16 at 17:56:07, Muhammad Nuzaihan wrote:
>=20
> Patch to enable the use of MPTCP on Linux (when available)
>=20
> IPPROTO_MPTCP v1 (not the old v0) has been improved to go about the
> limitations of middleboxes.
>=20
> MPTCP protocol is an extension of vanilla TCP which enables multiple
> IP to aggregate bandwidth at layer 4 of the OSI stack across
> as said IP(s).
>=20
> Similar to link aggregation which works at layer 2. MPTCP works on top
> of IP layer.
>=20
> Other than aggregating bandwidth, MPTCP also allows seamless failover
> when one network path (not just link) is down (or having high latency)
> by reinjecting the packets to a path that is available.
>=20
> This patch enables IPPROTO_MPTCP if IPPROTO_MPTCP is available and
> uses plain TCP if the Linux system does not support it.

What happens here if I compile this on a system that has a kernel that
supports MPTCP but then switch to one that does not?  The reason I ask
is that I have worked at places where we shipped binaries, including
Git, based on a standard CentOS or RHEL system, but then some people
used our software on a system with a very stripped down kernel (in some
cases, where IPv6 was not even compiled in) because doing so meant that
they could make about $5 more per server per month.

Do the operating systems which support MPTCP make it a compulsory part
of the TCP stack, or could we end up with cases where we're unable to
connect here?

In addition, Wikipedia mentions that FreeBSD has only IPv4 support, but
I don't know if that's up to date.  What happens if we run on a system
where MPTCP is used, but it doesn't work with IPv6 and the only remote
IP is IPv6?  Do we fall back properly, or do things fail?

I ask these questions not because I'm opposed to this feature but
because I want to be sure we don't accidentally break things for users.
I know that for instance Go 1.24 enabled MPTCP and that ended up causing
problems in some environments, so I would recommend that we make this a
configurable option instead.  We can definitely default to MPTCP, but we
probably need an option to fall back.

Of course, this code path is only used by the unauthenticated Git
protocol usually run on port 9418, which practically nobody uses anymore
(because it lacks the privacy, integrity, and authentication which are
necessary and prudent on the modern Internet), so maybe nobody cares
about edge cases there.  My guess, though, is that the people most
likely to be using something that isn't HTTPS or SSH are also the people
most likely to be using odd or unusual configurations, so we may very
well want to add an option for them.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Kri3vNeYESN6xZVF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgnoP4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZxm+eMLLzCWdUhieHWQyHSsTtMrbS9MUN/kE5LmOzW+H
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAISwAQD2grIrLfLWA5EGaqgQX9gbKB9/
Id2/19bWDc7mpkASPAEArbKpa/CFvVDe2rsGbIPu8B/mz0HMriNEwHBjHpuLygI=
=vuAV
-----END PGP SIGNATURE-----

--Kri3vNeYESN6xZVF--
