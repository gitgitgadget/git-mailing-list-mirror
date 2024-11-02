Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2546A82890
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730558956; cv=none; b=c1wmtpueTtRMuvQau+Si+z8DLbh6T13NSGiuAXmZlFOOhy7j63G6l8r+uaFWUjJznce7CGIsd+EiaorHN8a0sE3RbjF6f9FgBpNf23Y0UDHxBTFl00fU1aZv1MywgyJQs6Ai50dSIPCh7wGxBrO5ID0R8gT7vyFZEzqWRcAZCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730558956; c=relaxed/simple;
	bh=hOt4UCzqY4BRhxWyMEiBDV2S/kgRk9pAcNsalNpW2/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea4kQs27WzyOyEPzLKaikXMYH/yCoVjk9Xnzc/OzGaMyJfbBNoC0F1UkrPD+e73tKK8JeH82cKJI4JErFuZB9di3Uoy2tLwkiStYVZvjDreIIeiQrd3NcMuQ7u31/UlW46gm6qpCT7oNXYmcMWPEg9k5MkZJc6z0WpjfsiLIOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=rDOvf28+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rDOvf28+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730558946;
	bh=hOt4UCzqY4BRhxWyMEiBDV2S/kgRk9pAcNsalNpW2/E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=rDOvf28+95E6Mw5i4rQ5Z9HRacvlGmo4IuXNdg5LFiyX2drlMxbViHl96yuQ+ZFMD
	 I05vzVsKUST10cQBb00nt+oLbXyFkBEQ/MKqjmDLPrexLjuVefPo7WwCIzjjym9xA9
	 XNvR0ogByrK9EN5LPPrS1a0BIFbUSCruuxNHCKxA5G3+MAQSixMRX2em6CZUuouqo2
	 5xOtsxVesRby9E1dwjS+aJ7K/5GCMNzyZB2TfUfvvVCzcK+P26E0C+Jkf/gvKpmbgT
	 wGonXXLjbWUh7vzzF8iXv9gfvj/5rbF5EUqkPp41ijjFdSYwOazEdrqkU7G4MulbJW
	 rHS5S/8k6qEBP0qwfr7V+PjrQCK/r8k7GH6QG+BW/65uLRqE7huJykPpTcq3TnYB4y
	 jQmoSrgzJ0nbO4u+nzwb0Gknl2yz0RhaQL4FAlyMBt2OQl/bbsFjEKBv9COrx/eTJU
	 y0lwc9OhIjorAwWuk/gh5NeCyRmi73u9ixSwk7SUASQy625B5dD
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4F8AA200B8;
	Sat,  2 Nov 2024 14:49:06 +0000 (UTC)
Date: Sat, 2 Nov 2024 14:49:04 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Taylor R Campbell <git@campbell.mumble.net>
Cc: =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
Subject: Re: Synchronous replication on push
Message-ID: <ZyY74N_NjmaJ2677@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor R Campbell <git@campbell.mumble.net>,
	=?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
References: <D5BM0CBSPT9I.97E2CAX9DE17@cepl.eu>
 <20241102133511.6375B609AC@jupiter.mumble.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jL2+SebKo9IlEHTU"
Content-Disposition: inline
In-Reply-To: <20241102133511.6375B609AC@jupiter.mumble.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--jL2+SebKo9IlEHTU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-02 at 13:35:11, Taylor R Campbell wrote:
> I'm asking about how to configure a _single_ frontend remote, from the
> perspective of developers who are pushing from their development
> workstations, so that it replicates to one or many backend stores.
> This is, for example, the usage model of Github's proprietary
> implementation.

I don't think there's built-in functionality for this and I'm not sure
that it can be done without additional software.

If you really wanted to try to do this with out of the box Git, you
could create a `pre-receive` hook that did policy controls and then on
success, took all of the objects from the quarantine and rsynced them
(without overwriting) to the remote store, and then use the
`reference-transaction` hook to replicate the reference transaction to
the remote side via SSH or something.  I haven't tested this, so it
might or might not work, but you could try it.

Note that GitHub has a separate service that does the replication and
intercepts the ref update to send it through the three-phase commit, so
they don't rely on features of core Git to implement this functionality.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--jL2+SebKo9IlEHTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZyY74AAKCRB8DEliiIei
gR3jAQCBeMICTDnRLLTEykEfJ4ekfxMTxbGk3+0JaQx92j1SOQD+ISiSD5zGPphd
AQT+NLTQV1dFPmEihYRclhOYXoGRKQM=
=y/Jv
-----END PGP SIGNATURE-----

--jL2+SebKo9IlEHTU--
