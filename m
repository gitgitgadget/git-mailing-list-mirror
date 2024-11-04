Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B391FC3
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759791; cv=none; b=mdMmrJ032s1IoHWt9OK5bw+s4dS3K+7Sz7Lo5QKwH0F6ABVQPT8OZBLcpMR22vZzg0N0kSKj/czoqw+soseuTVq2vCZYVYR3sdLZxgj74vjnOnmcB5ADlgRppy9gIhgNX84AYSri2pW4OWWv0e74zgvPLufNgbWRHEnGAaffn7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759791; c=relaxed/simple;
	bh=W8roL/lLXXGFO0A5JyXl30z5OH+xKrti2UUFLKuwzLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3O74NKsOYsyq4XqSEnuGsCbyU0X7XPSYIBHEsdY1whHrj+N3G1/86oWKHuaZKAFIeMW/idW+sr5mIHUdl3Vi1hkHirKe38T6ikQKGtEOF7us9OrFrF0bYKycWW/99jl6vbj22OOrl4HrgWRhDyLQNRg4/tplWXnUIYSwcdhtpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=a+uiIAfh; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="a+uiIAfh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730759782;
	bh=W8roL/lLXXGFO0A5JyXl30z5OH+xKrti2UUFLKuwzLU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=a+uiIAfhmnA5gT458nZZhzup8/qoarVlijA7701oEkM9DehOBEV219rbbjdy0Dq2c
	 T42114FnJuVXIPYR4Wg1Rg2jAUh9Uux/PFwba3KJNFGKowiWooW42AHPamnNnjZZkk
	 yeMFXCSX6UxYUK8eo0Fvrkqmv7Nlx/dA7pOIVvmea7HST7ENR69psFSf/+W++xcUnI
	 YKKQ2kVQbOHCTuE65uOm9kjN4L7fvDKquErO35CZhoRWnf9oeQtaXNIeS/n9skCkKF
	 FFXvynmWwWG2K0+3ltJR2egqH7I6imq35DW41/Mg/jSCAfTD+zFRGOECoKv67z5xEv
	 2h8Fu/1fSQ3JwEBAsJ9OJLe/XcGPMCq/ypnGaRhr0Q8dDY2d8fjgzIbHJ9GeNb5RsP
	 vjcowQdWajoDX94qfesSusLbbjzzondy2rWcckbq356uCVkgs/q0z/mXCEN2hhAyz5
	 SGadOSAEq9oqFJb6IwohpAo1ZrR9ES4ourfT6OyYZAolh+bur+n
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3B666200B7;
	Mon,  4 Nov 2024 22:36:22 +0000 (UTC)
Date: Mon, 4 Nov 2024 22:36:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Taylor R Campbell <git@campbell.mumble.net>
Cc: =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
Subject: Re: Synchronous replication on push
Message-ID: <ZylMZGLdwVDFcAwF@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor R Campbell <git@campbell.mumble.net>,
	=?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
References: <ZyY74N_NjmaJ2677@tapette.crustytoothpaste.net>
 <20241104133544.A04D760A95@jupiter.mumble.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gN+D0iRddr0UNiY+"
Content-Disposition: inline
In-Reply-To: <20241104133544.A04D760A95@jupiter.mumble.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--gN+D0iRddr0UNiY+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-04 at 13:35:44, Taylor R Campbell wrote:
> Thanks, can you expand on how this would work with the constraints I
> listed in my question?  Recapitulating:
>=20
>    One option, of course, is to use a replicated file system like
>    glusterfs, or replicated block store like DRBD.  But that
>=20
>    (a) likely requires a lot more round-trips than git push/send-pack,
>    (b) can't be used for replication to other git hosts like Github, and
>    (c) can't be used for other remote transports like git-cinnabar.
>=20
> It sounds like rsyncing over ssh is incompatible with (b) and (c), but
> perhaps I misunderstood what you're getting at.  I tried to see if
> there is some way that reference-transaction hooks help me here but
> there wasn't anything obvious to me.

It should be noted that you cannot do what GitHub does with the
three-phase commit with arbitrary remotes.  A three-phase commit
provides a prepared-to-commit stage where the backends agree that they
(or at least a majority of them) will make the change.  The Git protocol
doesn't offer such functionality, so you can't use arbitrary remotes for
this purpose.  You'll need to either replicate to only hosts you control
(as GitHub does), or you'll need to give up on having your three-phase
commit operation.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--gN+D0iRddr0UNiY+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZylMZAAKCRB8DEliiIei
gYEwAQDJpprTZSMwLjb01kSNqsYdTNJIukp+dFSVu6Y+dob7zgD/UlCkgf0WKkwb
8pqnHSkOazZkAi9eKT0aePjxD9HiYgE=
=NJ9/
-----END PGP SIGNATURE-----

--gN+D0iRddr0UNiY+--
