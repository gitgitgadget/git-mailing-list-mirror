Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09E38396
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575274; cv=none; b=JSN2oN9LcKNzfPAEovqUIAye2jpaARZsukhgKWVP4pYTRZdFx7b2XSpiMWDgTn/Hcx8imQqFQjbP4uHRWfLBRC+1EkJvRnDkKVJ4BN/pNTvUqRQtpBZCU5d3EP7REDulxdwwYXcdJa60kYyWVR97OTt3WgZWMnbHv9f/SEC5xT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575274; c=relaxed/simple;
	bh=LJDQTZ4fPeNcbC6YWU9bFU0KaWZpEFUm3GjVuVZ1Kjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAVcTzcy/n4+Tq5ib15pgTomjwzTtQFV5//SWotFQnNHzvNY88L/F5emSzpOHzqTzlSItAUlHtv+IjxoT30vQMYkcuEPpP84bbuFwKxwYnQF8Rjc10r8Sl6WxCzhUSFiem+2u9PGv1I9jbsgOnxzTvObFd4V8feUPTqoym8+diU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=dWIxqcK/; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dWIxqcK/"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E08575D40F;
	Wed, 27 Mar 2024 21:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711575271;
	bh=LJDQTZ4fPeNcbC6YWU9bFU0KaWZpEFUm3GjVuVZ1Kjo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=dWIxqcK/nDnCXG5iQeHF6WJK9ehvtYpmu6D2oCmsHE356m2epfCrig++rMUBTV90v
	 P2PdJ4OxuyV3NKCKguC5tyPO/g+wu/HIstHnEN65hFhp0HGhWbDpD1Fyg++VCh/RB4
	 N66FJ8i5rl6BYxYSwwQvSVCEa1Ux4u7ylFRxX+mJx2qVcBt1VNANYQ0sUkqgkX0XFn
	 EH+x2RsBiRZpE0Qwv7vA6YkPxItmg/2ByMEXU4LdQX7SigToSorwGtu46Ti/BIqv7+
	 MgrgVMu7XEelmhsdoYjVr3bcbIe1GUV3hVD23Z5FTJDrGW3cszDWqM1qlGCBeVQBJr
	 67cAWeiIviGyqZRbM8EUFiZXxfi/nwfdo4LuOR83sn/VRvSMq80hZDoS7FalDOKXiB
	 0VaMwFmaRY2c8lXewiHv/Rq3EssMgXWUYXJIFdNSyis0M5WsgRRJ5czc7Yilhys1DD
	 f3iFgHfuso7Fvtz6vnXYfrDcrnKGM5thZlGg7A+LiHnSQRi5Q1t
Date: Wed, 27 Mar 2024 21:34:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 12/13] strvec: implement swapping two strvecs
Message-ID: <ZgSQ5o_KyqDaxz1m@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-13-sandals@crustytoothpaste.net>
 <ZgPSpYVSSmQ9Muec@tanuki>
 <xmqqbk6z1iba.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VmV1jCQUJoT4/nVm"
Content-Disposition: inline
In-Reply-To: <xmqqbk6z1iba.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--VmV1jCQUJoT4/nVm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-27 at 21:22:17, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> +
> >> +void strvec_swap(struct strvec *a, struct strvec *b)
> >> +{
> >> +	struct strvec t =3D *a;
> >> +	*a =3D *b;
> >> +	*b =3D t;
> >> +}
> >
> > Isn't this equivalent to `SWAP(*a, *b)`?
>=20
> Yes.  "make coccicheck" does flag this one.
>=20
> Let's drop this step, and tweak the 13/13 patch to make its sole
> caller directly use SWAP() instead, perhaps like so:

Great, I'll include that in a reroll, likely this weekend.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--VmV1jCQUJoT4/nVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZgSQ5gAKCRB8DEliiIei
gTXYAQCfHOz0fZo6a3pVDdqV805jpsB5GNQ5T9UTuKHoqpyfQgD7BAXbBN8xK3IY
DftHir/Kg8cC6+5/+wJ5flXUSDmCYQ0=
=rCeY
-----END PGP SIGNATURE-----

--VmV1jCQUJoT4/nVm--
