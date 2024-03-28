Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1324713A3F3
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662801; cv=none; b=gSmbBicX3VyILdfueUev2DnEwOu4ZlfMxR/3iB4pTk864fjN9KTFU4A58hPwHjUWx/IUfiAcmi5SPJBVXqW2sqSLA+I/0XYD+uSLQUCNpC+LCKXp4XIvNDDgIMzzHCf1JPGdufmHDG+f/Q9yBP+HU1zjC7MupS9k8Kf6tBXbZOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662801; c=relaxed/simple;
	bh=IawzalKvJXVx2HpUxrkPF3hBsd3fEbX5UGRmCWPEuYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmWDDkRNNkT+u7Byvu9ZxyLLQAnmPUq0DNWGMhfbwQou6t7Mj46g5kCZGwf9XmDzR7MAKcrc1xx5ZFOZKCNVsCVPrN/DirnUjQwM6Bh18aqANfCMXnmPydxI6n3iTKZDkWgKQCUCNZsumDnNQvbkYQudP2lF63Oh/IUNohFf8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=B96o0vXa; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="B96o0vXa"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id DCC005D49D;
	Thu, 28 Mar 2024 21:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711662791;
	bh=IawzalKvJXVx2HpUxrkPF3hBsd3fEbX5UGRmCWPEuYU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=B96o0vXaZP1vIGC2ZYVaNK8wvDyDlIIcIrGLfmNY6TMDVkmFmiXSXX+Lg63bLvVYB
	 b1xaz8lFQvD8R2r/RY857coib7lGs6l3CgSAAHwiO2YelBQj0+ks5ZkB0EI2dMM8wi
	 JLN2lheXfTpWiZDej/fW/fZbls+tymCG5T/W9DQSnUr0RWHUHRis6ROPBNvlP/RZGN
	 YAQnSpRS8S/e2tpVh3GgJQ271KYhZhPsSc/2S8eMHOzTptxU3BT8KoPIP8rtK2TZUV
	 caIp+WBCin7CamrhhmO+R2ZKjUijJApWLCR9poa1eKLVlwH4nYSZH6JGFywBUEZY8A
	 I2tZpFcxxvzZqWTgwt0ZToXNLa7WwqZVfh+u6946DciLxgdiReHsD+pS64xdwGLmIw
	 MGZT58pC0uU4fHrGEm0NxXNX0dv/a5lfRyU0n5/J+AscQ25S9ND4cf+dADLs5PGLv1
	 RNSBGto3+n9p0VZk33TEoVkzCesoLdq2qNZq7roRPKFB1XNKns2
Date: Thu, 28 Mar 2024 21:53:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford <mirth.hickford@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 13/13] credential: add support for multistage credential
 rounds
Message-ID: <ZgXmxvRv0rNBKk5K@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-14-sandals@crustytoothpaste.net>
 <CAGJzqsn4Lz1T=q8NHi7kHHRdYVXKCMPGVBGzkkvZA=P1O9HtUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VfNf2F4w3Sw43mdO"
Content-Disposition: inline
In-Reply-To: <CAGJzqsn4Lz1T=q8NHi7kHHRdYVXKCMPGVBGzkkvZA=P1O9HtUw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--VfNf2F4w3Sw43mdO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-28 at 08:00:00, M Hickford wrote:
> Is this design sufficiently flexible for OAuth DPoP (RFC 9449), or at
> least to make it work in future?
>=20
> OAuth 2.0 Demonstrating Proof of Possession describes "a mechanism for
> sender-constraining OAuth 2.0 tokens via a proof-of-possession
> mechanism on the application level. This mechanism allows for the
> detection of replay attacks with access and refresh tokens."
> https://www.rfc-editor.org/rfc/rfc9449.html
>=20
> Popular hosts GitHub, GitLab, Bitbucket and Gitea already support
> OAuth. OAuth DPoP "provides a general defense in depth against the
> impact of unanticipated token leakage". Motivated by a 2022 GitHub
> attack involving stolen tokens
> (https://github.blog/2022-04-15-security-alert-stolen-oauth-user-tokens/),
> some hosts are already experimenting with it.
> https://lore.kernel.org/git/20230128142827.17397-1-mirth.hickford@gmail.c=
om/
>=20
> In particular, the http request has to include both Authorization and
> DPoP headers https://www.rfc-editor.org/rfc/rfc9449.html#name-the-dpop-au=
thentication-sch.
> The latter depends on timestamp and a server-optional challenge in a
> DPoP-Nonce header.
> https://www.rfc-editor.org/rfc/rfc9449.html#name-resource-server-provided=
-no.

It will likely be sufficient with further extensions.  Right now, we
don't have a way to provide DPoP headers or send nonces to the client.
However, there's no reason we cannot provide that functionality in the
future via additional key/value pairs, in which case this design should
be fine.

This would have been sufficient if the OAuth working group had not added
extra additional headers that other authentication mechanisms would have
simply put (and, honestly, should have been put) in the WWW-Authenticate
and Authorization headers, but alas, we can't change it now.

Since I think this gets us at least part of the way where we need to be,
I think we should be able to keep it for now and implement the extra
support for DPoP later.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--VfNf2F4w3Sw43mdO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZgXmxQAKCRB8DEliiIei
gZMBAP9Gtf06DQErcDgc1Ri8avthR1Qki8mYtqIDpdp3cPT+WQD/fFbkBkssTP6V
RuWf3Jc9txhoEWGAVSZ+2UqzN6HN7AM=
=fqHa
-----END PGP SIGNATURE-----

--VfNf2F4w3Sw43mdO--
