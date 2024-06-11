Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C6757E5
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718148275; cv=none; b=SmJ+1GDJ5KWGjFB7gbR9TyK6mcTOwgokAVC4oTASV8Nuf4Y+yiG4iTIEewC8xauftgqP9SDDzVNLaqGOKKnDO7eCw/uyxAc1xba8tPJ+yTQplOzJb/rJgjScL5J6s01lIS5fQo0xvXoc/0ZTVelsI6jRhUb2GFj2CNLMX8oZ4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718148275; c=relaxed/simple;
	bh=+Ueb4C54b7nn7sMGyXRUV68lhJ/dEo0MrYWOFTVT4Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy5A5joJxkrdcnRSQejO6kk8stkICAhYP7Gv7T5F8HdvrpIKQPzYUH4cO/Ms0VlophScJvD0mBnidc25Xt2Go9ymwWWD1fmdGsIGbhVPc8Rc5EgZ6Q+v0C4Pco+qBcCqLpDET5xRqK8yvm8WPbDQ8eBnBIWZN8lVPQFyjTLvoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=J3dJFfSq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="J3dJFfSq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1718148272;
	bh=+Ueb4C54b7nn7sMGyXRUV68lhJ/dEo0MrYWOFTVT4Ek=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=J3dJFfSqCiCnq93E8/jsf+Yt0wyy44y/sDXmjdfVDSZk1Oo/7ELtRbgH6g35U3hxm
	 KfWIubg9gYhkXmQwEKoptbknMY7FJqZJx1GqZLW4/wPezRnS/R58hPYeLZLo/ky07w
	 l7YRKjW+mtepRPCHd6djwq+EEsc4AZs4JQF3YGHrfUyr+712iDhZEgX3r43l1Dh+aH
	 BDN0Ff2SEV0mCwJbahxj4Eyh4UR6oQx44pgZEcQek6TmNJcRCoyHcx57EpxkytONfn
	 Qek6iLoA7wZ2YhInQogi8CMKdSVRH4GQJMF55tQ5qGWH1hLLR5EfpH2k62j3qYbjOm
	 G6tFo3JulHdXOTbSWpSIWfzAXs+6v0nGCj/6o7MI5kezW8RzSo55UP/hFji7LN2iLI
	 oJA+6PcDWuNpOknxkyBjr59oQmKE+Q3cXOW7ohUfM0vWQyca3Jt/RFWoWhbqZ11FP8
	 TsnZIydV13l8MkKwvvA+sDJmcRcHas8eLj8fTFcwZ1J8JGFuvO4
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 731532639C;
	Tue, 11 Jun 2024 23:24:32 +0000 (UTC)
Date: Tue, 11 Jun 2024 23:24:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/21] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
Message-ID: <ZmjcrqnDnHAZjr6V@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zXXx4X9Y6eFQvhUA"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>
User-Agent: Mutt/2.2.12 (2023-09-09)


--zXXx4X9Y6eFQvhUA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-11 at 11:57:33, Patrick Steinhardt wrote:
> Hi,
>=20
> use of the `the_repository` variable is nowadays considered to be
> deprecated, and over time we want to convert our codebase to stop using
> it in favor of explicitly passing down the repository to functions via
> parameters. This effort faces some important problems though.
>=20
>   - It is hard to prove that a certain code unit does not use
>     `the_repository` anymore when sending patch series. The reviewer has
>     no way to verify that it's not used anymore without reading through
>     the code itself.
>=20
>   - It is easy to sneak in new usages of `the_repository` by accident
>     into a code unit that is already `the_repository`-clean.
>=20
>   - There are many functions which implicitly use `the_repository`,
>     which is really hard to spot.
>=20
> This patch series aims to address those problems by introducing a new
> `USE_THE_REPOSITORY_VARIABLE` macro. When unset, then the declarations
> of `the_repository`, `the_hash_algo` and some functions that implicitly
> depend on them will be hidden away. This makes it trivial to demonstrate
> that a code unit is `the_repository`-free by removing the definition of
> any such macro.

Overall, I left a few comments, but I think this definitely moves us in
the right direction and I'm glad to see it.  This obviously improves the
experience with libification and unit testing in a lot of ways, which is
good.

My only caution is that using the *_any functions will cause us a world
of pain if we ever adopt another 256-bit hash function, since it will be
ambiguous which algorithm is to be used.  That's why, traditionally, we
haven't assumed a hash algorithm based on the object ID length.  I don't
think the amount of uses we have is excessive, even with your changes,
but we'll need to be mindful of that going forward.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--zXXx4X9Y6eFQvhUA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZmjcrgAKCRB8DEliiIei
gTU5AQDGxV3jzcNhG/qWIpizAA/Cx77QakZjTe13T3eaOnhdxgEA+fEVg1IHDukP
1dkKPaHuRqh9UdhWqdKiG8MsRZsDSwU=
=7+nC
-----END PGP SIGNATURE-----

--zXXx4X9Y6eFQvhUA--
