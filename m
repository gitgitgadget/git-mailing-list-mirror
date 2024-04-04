Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928DE4A33
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712191211; cv=none; b=V3JC8ptzrKYTaWSwMs/SGTLghinSU0jm1YwOCl2TDs5jxVQsMLslrbmaiMuvJ10+dFL5NOPlZZ80+V117wWAekkOikw9Zzh2TTTKK88Oa+SEeuNpPuGuHuDTeAW131vGyoGSQuHG25PAHmijTVAiCs8JIEcYu0QnFRVOI9ElUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712191211; c=relaxed/simple;
	bh=E/kXfmCbZGzKQUo9JJrVU+Juw7hHPwOaIDnx9eiT3ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4DozRlXuIpVvhFr7kfLacFhRnMITaFuhZCvrZMdzD0kp755nCIdoKfevg+kt+K1ukPiFVlh38Ffv5atI3VT/Yuz0h7jxoLPRzCQYdwrAtS89V0++iGxFSsS9wIAxKEJg+iA9leRJZapXYJYhQjFRhqkR0rTnawB0yOuFcmy0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=r0l5sZjr; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="r0l5sZjr"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A00D45D4B7;
	Thu,  4 Apr 2024 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1712191200;
	bh=E/kXfmCbZGzKQUo9JJrVU+Juw7hHPwOaIDnx9eiT3ng=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=r0l5sZjrRC853msBbsDfCYvxcc3lsSLJ63IKdoKTcP0oN3R5CQbdoiCOlgjLvH9Ox
	 +753T/XDHlahYy9cqivE3+5xHNBTKPN3nyxiLqXObjQ8UKaPK9r80UNHke9aLDvzX7
	 qr4EGl+XV/Z/Cc88SOmaJFpKc/vFTqAV+1Xf/fPVrJFneJtcHfYLlOXTQa5O11bRFy
	 KghKp4fgh1KC3RfQyyL+orTIFFf/d7IkZa04xRWryAjUs6snPejZQoUa4RsDM+nkGx
	 JiYFFMuUFPGxXYLuIK/VHTJKsE9PekPq2GlU7HJ/gAuCC1EXjORgWzbNxpi2IxOa0a
	 AcYguC4Q8E9rXpbGjiNMMPAkNt0xiKqbwPv4XAjLKmq1WUVd+xT1VThIreWgU7Pfk7
	 /ilbvtIhrrgOMIzDndpE53Lqkg8gC1T3oqGUz7ubPUzYq2LlsexNsl56lyk2vdr9OV
	 wKbZ97G566EtS5yEAUV1rpooJZ22CgwjatAdGSrVcEAR6YkW9in
Date: Thu, 4 Apr 2024 00:39:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 05/13] credential: gate new fields on capability
Message-ID: <Zg323pR6UYthTakT@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-6-sandals@crustytoothpaste.net>
 <ZgPSn_D8luXQyZGf@tanuki>
 <ZgSQr7uQdIA8oVNn@tapette.crustytoothpaste.net>
 <ZgvYLxfNwBcOB_s1@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vIdrIaPF22/fceml"
Content-Disposition: inline
In-Reply-To: <ZgvYLxfNwBcOB_s1@tanuki>
User-Agent: Mutt/2.2.12 (2023-09-09)


--vIdrIaPF22/fceml
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-02 at 10:04:31, Patrick Steinhardt wrote:
> The intent of this is quite clear to me, but thanks for re-explaining
> the bigger picture :)

Sorry I misunderstood what you were getting it.

> I think you misunderstood my confusion. I didn't meant to say that there
> should be non-boolean capabilities. I was rather missing the picture of
> how exactly you can advertise multiple capabilities with the infra that
> currently exists, and why the infra supports per-phase capabilities.
>=20
> Basically, what I would have expected is a protocol where both Git and
> the credential helper initially did a single "handshake" that also
> announces capabilities. So something like:
>=20
>     HELPER: capability foobar
>     HELPER: capability barfoo
>        GIT: capability foobar
>=20
> Git would only acknowledge capabilities that it both understands and
> that have been announced by the helper. So at the end of this both have
> agreed on a single capability "foobar".
>=20
> This is roughly how the remote helper capability subsystem works. What
> this patch is introducing seems quite a bit more complicated than that
> though because we have "staged" capabilities. I assume there is good
> reason for this complexity, but I didn't yet manage to figure out the
> reasoning behind it.
>=20
> To ask more specifically: why would one side ever announce a capability
> in phase 1, but not in phase 2? Is the reason that capabilities are in
> fact tied to credentials?

More that they're tied to the credential helper.  For example, say we
have helpers A and B, in that order.  B is incapable, but both A and Git
understand the new authtype capability.  If we announce the capability
as in this series, we can get a new credential using the authtype
capability if A is willing to provide something to us, but we can't if A
has no credentials for us and B wants to provide them for us.

This would also be true if we used your proposal of negotiation, but
because we have external callers (e.g., Git LFS) who may invoke `git
credential fill`, which would be a separate process from `git credential
capability`, we'd still have to have some way to tell `git credential
fill` what capabilities the external caller supported.

The per-phase capabilities are such that we don't request functionality
that our callers can't use.  For example, if our external caller (phase
1) doesn't support the `authtype` credential, then we don't pass it to
the helper (phase 2), since the external caller might not be able to use
the result if we do.  If the external caller (phase 1) _does_ support
it, but the helper does not (phase 2), then we won't return the
capability as the result of `git credential fill` (phase 3), so our
external caller will know that this isn't supported.  As a practical
matter, that doesn't provide a great deal of useful information to the
caller at the moment, but it definitely could in the future (say, if we
had a capability for a certain form of data encoding).

All of this is also true for internal (e.g., git-http-backend) callers,
except that phase 1 has all the capabilities we know about automatically
set, and phase 3 stores the data in the internal structure we'll use for
the `store` and `erase` calls.

I do, however, think some way to query capabilities more generically
would be helpful, so I'll see if I can add such changes into a v2.  I
think we still need the current approach to make the use case I
mentioned work, though.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--vIdrIaPF22/fceml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZg323gAKCRB8DEliiIei
gXSZAQCugxQy7CkfslFCW3rjHvUPoKwHckhCvqwnGr/HYBlcBwD+K9sDTj2qnQjX
eMd9u5J2cKHBiDGm+6pPtr0yvKn82Ao=
=aAvn
-----END PGP SIGNATURE-----

--vIdrIaPF22/fceml--
