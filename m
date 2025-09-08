Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69E421FF39
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366854; cv=none; b=fftPhRFlhoW1ZbiqFiR18Kd73LK9Aug2fhNs+OYgviGOsJ5ENEum3GEL8gjdYwVJfB6oBnCkIIizjvjzA28Xm7k4f3ovmEGp6t7+5TBNdOkqq3U5zrTQeguGx9ggWnObThKgqLHuE7WEhDDEDAARA+YhMHuJFf682edBB7LEfzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366854; c=relaxed/simple;
	bh=QnmCPpiF90rk5wBkAcTtYFKwVjOVGPiydUhlUT6YZK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqL0dyuVmGWUmrfyNfwIur1hzL3cLxF1CZPPyZRbIkQZbH0A+q+0zLeDZKEHFyS/TSAzgdBAzrZGOG2eJsCIlG4+w60y3o7DBFweReonZmwJq7mOBoaB8TI0i5KtjCYrgZHChcl7PoHPPgs0sth8DWYMOFU0xevGOo/KqFEgOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=TgKg4O2Z; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TgKg4O2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757366844;
	bh=QnmCPpiF90rk5wBkAcTtYFKwVjOVGPiydUhlUT6YZK4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=TgKg4O2Zi9/7ZRz84a7f47X9WdO4ApRHzQaHFQ40BxtDTanyK1Xc7+4KY8Q5s19mE
	 0eKhoh7t5AnhirMalukl8g88wXc5u3cKVnIEzTNA/2tRtSsd7O4YTFFoTWpJ4U57Bv
	 s6a8zefNMHf+9PjMbUKGBBj0nl3RiyRESvlopI63EmrWZ43MQ7R3s4mGPJvV80mBW0
	 R36QK1swErSxAcTrX4xfW770NToZS86B7tlwvXIazoPZgqNLMdxlEJWaB8UYfbg6tL
	 MjSx6pwgh0PVX+83ucDDsS95uXF+TT3hSCMi3NGP4MnFgL2mTyGLg65A7DawTiwZ1J
	 F7Srrf6zM7hdpyK0GmfSiQb/BXijVrb3O9QDs3oK0YVLtAn3gyBA+K/b8HYehxUfK6
	 6zeIhOzOBm5wmWTs6clSmgfY0X/Ipj/G6i38o7EZjabg90B/wUCeyQVc1pxAzhK1A1
	 wT4PX14nfe19Yr9G3QBnGBmGtP2kIyoWO9K8TfciFqyMs+a853g
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:91aa:86f1:d85a:ac64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7428F200C9;
	Mon,  8 Sep 2025 21:27:24 +0000 (UTC)
Date: Mon, 8 Sep 2025 21:27:23 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Milan Hauth <milahu@gmail.com>, git@vger.kernel.org
Subject: Re: Git dumb HTTP protocol should work without update-server-info
Message-ID: <aL9KOyR0eb7zAg2R@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Milan Hauth <milahu@gmail.com>,
	git@vger.kernel.org
References: <CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com>
 <20250908000543.GB1281511@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gCu5cBGXecv6odV5"
Content-Disposition: inline
In-Reply-To: <20250908000543.GB1281511@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--gCu5cBGXecv6odV5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-08 at 00:05:43, Jeff King wrote:
> Possibly dumb-http could learn to do the same scraping that httpdirfs
> does to get the refs and pack listings (though this might be quite slow
> for unpacked refs, if the ref tree is deep). But I doubt you will find
> anybody that enthused about working on or reviewing dumb-http patches
> these days. The code is not very well maintained, IMO.

That kind of scraping is really not a good idea.

It's the equivalent of trying to parse the FTP LIST output, which is
customarily the equivalent of `ls -l`, but doesn't have to be, and often
isn't on Windows.  I can tell you from experience how painful doing that
is and how many bug reports come in when you try to use that (because
the FTP server also doesn't support either variant of the
machine-readable format that solves this problem).

It's also prone to breaking things because some HTTP servers have weird
redirect loops due to sorting entries in the index pages that you have
to be careful not to trigger.  And, of course, that depends on the
server having index pages turned on, which many do not.

And then you have to do all of this in C with pointer arithmetic, with
all of the terrifying security properties that has, especially because
you can't actually use an XML parser to do it (unlike in DAV) since many
servers have index pages that are (possibly invalid) autogenerated HTML
3.2 or something.

I've seen exactly one piece of software (lftp) that hasn't done a
terribly awful implementation of this and that happens to have worked
every time I've tried it (which is extremely infrequently, so I probably
just haven't found a server which breaks it yet).  Every other piece of
software I've used that's done this kind of thing has just been broken
and I anticipate Git would be no different.

I do want to be very clear that this is a bad idea and I hope never to
see such patches come into Git.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--gCu5cBGXecv6odV5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaL9KOgAKCRB8DEliiIei
gYUxAQCQG2tzVHhbei7zQN51OJsRUYpqmF+XkZGd/FWDae41FAD7BFOLkkpNZ9lY
P/c/kMvz6KoggrdKKIxp3C3Qeqqduwc=
=cPiT
-----END PGP SIGNATURE-----

--gCu5cBGXecv6odV5--
