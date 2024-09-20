Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3E4AEF7
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726865019; cv=none; b=IcQAJfsDIaUHshTwH0uxWuXgaenfylmfWzmvRnLnC32pkI9gIQp/dHV7v2lheLoskpe83o8fJdzQH5fRg2sZNJtOOpVsAEa6Cck3sCSCkb2S6GgrJMue3ttbOS1a0+0WGN12ciP1YButNJ2br7sWRCdAjOVosPNbNnlYp5h6buA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726865019; c=relaxed/simple;
	bh=yCg4ACEVOEBnnL8Fn2C2uBP0uyp92jaYgdMkn7L+Mb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlwWuv3O2Cn3z1h1N5CqLRT8tcvV4GiLDQTHFQEvoxwg/ZAQFvior6BCITCiWEjF84FCPNu9jy8g4DRVRC28qIzabvIz2k8oysLQ6a6gZR5R/hwWj74X0Un2ujcewvENencKGoTyFKOUH9U6M95MWQXfsQAI1UczoIoMPe3cQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MoOungBN; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MoOungBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1726865015;
	bh=yCg4ACEVOEBnnL8Fn2C2uBP0uyp92jaYgdMkn7L+Mb4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MoOungBNgXTC6SRLZ3S4U9p44zo1R1Jvw6IGIZZVKqOG0bZ4Brlubkw26VVuj6LTQ
	 tiA/ed16Oeb8fLijjWr3jdNjp6zhtdDRIEYkWfIJqfkP/Wl/JxfwznhYKYS8LOWMjC
	 HVqeogZ483omeCFjApIcV76B+JtiwH70mfOZjERuO6GpsPPy5Pa0NteYslbv/HDMAF
	 1KPiRWyqTBEI2t1vTjMSfuxxDrIqEpeBoqVrjmkOCL/0Q/Htlvwwbr+AhCtzMSpbQT
	 ZaC7pmfPykPRYhWW/DSsH1k0praMp7uKr8zm8n4bxF3y3ViVeekmfIyqZC6XiwMIhm
	 3fHAOu5RIhf9AblooYv6Jpx770BEc1nYLBmzS4eL6yCgQPOtBdlcB1jsmozwWmd31M
	 UHgxqXDP7quPJ7Ze0IsGgygQs8bunh6XaNiWlMdB48gfJCnQb79tRlM2S2y/L/5IQN
	 U2wZ53Nwo53N24HdA/5XEBN++bwrQh+y8T+vD6jdcNJP0bbkZg2
Received: from tapette.crustytoothpaste.net (unknown [151.189.190.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CE5A520067;
	Fri, 20 Sep 2024 20:43:34 +0000 (UTC)
Date: Fri, 20 Sep 2024 20:43:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: Permission issue in Git in DrvFs-mounted network drives
Message-ID: <Zu3ec1mDj9JD1Bbj@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Marcos Del Sol Vives <marcos@orca.pet>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
References: <19205ebb4b9.c2a2da5a2387912.3559118454287459572@orca.pet>
 <Zu2aHdaw_oDv_dp7@tapette.crustytoothpaste.net>
 <xmqqsetugpip.fsf@gitster.g>
 <19210b887c6.f59622352625372.1022723129771458212@orca.pet>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awUbYKz7xwCQWkST"
Content-Disposition: inline
In-Reply-To: <19210b887c6.f59622352625372.1022723129771458212@orca.pet>
User-Agent: Mutt/2.2.13 (2024-03-09)


--awUbYKz7xwCQWkST
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-20 at 18:36:21, Marcos Del Sol Vives wrote:
> ---- El Fri, 20 Sep 2024 17:51:57 +0200,  brian m. carlson  escribi=C3=B3=
 ----
> > Other folks may feel differently about fixing this, but I would suggest
> > against it.
>=20
> I understand that it's a workaround required due to non-POSIX compliance,
> but considering it should have no impact on any other OS and will actually
> as you said make buggy NFS mount work, IMHO it'd be still nice to have
> the changes made.

Git could, in theory, accept a patch here.  However, you're also going
to have lots of other software that breaks in this case, not just Git.
So it's less useful to patch Git and hundreds of other packages on Linux
distributions that have relied on the POSIX standard and more useful to
fix your OS (or maybe switch to WSL2, if that doesn't have the problem).
Most Linux distros will generally not be interested in fixing this class
of problem, in my experience.

In addition, chmod doesn't always work under WSL.  I believe it _does_
work if the drive is mounted with metadata, but some people don't have
that enabled and I don't know if it works for all drives.  For those
people, the current code will work, since it doesn't call chmod or
fchmod, but it will fail with your patch.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--awUbYKz7xwCQWkST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZu3ecgAKCRB8DEliiIei
gbleAQDYT/lYcjmQV5Xc+s1/CHXkg5Ecy4asmPEnvCWb/P7LeQD/bFs9K47kXvgG
YJbf0qENKvcwqaC9geIdJ5YMHQnwDgM=
=wKXR
-----END PGP SIGNATURE-----

--awUbYKz7xwCQWkST--
