Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23CC29B0
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713116659; cv=none; b=EjzwVP/vRepURdQnwqMToDX+fVOOQDPdwk49zWXy4EGuNAXlQeIuNAhcxzAIICJnPmhHC0irUlvjkNN+ZmNM1npxbnx8zzMczZapLSX8/7Es7rMeC5cEwqASIP81UB0Vkncu/BMYpH+hUHdPrYxMQJ1iOkyya30VCMWNfJHa+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713116659; c=relaxed/simple;
	bh=jq+NyhHAs0mFqJs/UKiOSN2cdLkpuoyRWW5HC+T6Er0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu5v3xdrwz4yxWI+bD/3how0qCzwh1mDtMDBhMjk5ZPxoFY2F5D1KJ99sNlG9F7ZsjVv+Cocy7HJgMbCy9GlR1pEptg8hAk0IVHOCZgfcXgh7pwnILWEycs/ByxUW+m/RwMD93VMlRV63Z7cx3vKkjImnQq/RObXNKCq2Qz0ZzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0zlLQE6r; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0zlLQE6r"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 29E385D4D9;
	Sun, 14 Apr 2024 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713116650;
	bh=jq+NyhHAs0mFqJs/UKiOSN2cdLkpuoyRWW5HC+T6Er0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0zlLQE6rqImxLBsd5dGFz3cecwPMGeOInPDfRYZvJdLKjToeaMJ4PBCJB0NmPzFtl
	 53Q+p3ORWD/xyQmqe0REJs0dq7hud1cVN52d8bfOgUMWx3Tnj5M9cUdzO3yTxskB3B
	 BFGVdatvtxX97/2QwMRejpA/tF0cYh+kd26snnzwplb/hvKVo+cmk+pWVosWoBbDQf
	 IMA27BgTKwAhPMR2qR95FzMQVYEPd28FWy4wm7cMZQufjeDsIeof/ruXWMHAFKL4Hm
	 XofM1TU4vsmCVdNevCEMUJ7enaH8/7wUobsc1jb0lSLYLlgcc9RzYl18kCpWXuBokW
	 97u7pdJf+RKmcsjb/lepv+zEFmkxzBOHdyU1ZNHeC0JrB9mHlNLwbkm8M/U8KLmc89
	 734R957oSU9nsK1/FhkM8pcQhsORZOwquYJiQ/i116xCgBB/I+iUxqQLtyxwTX5Xpi
	 SHmTqODp+tYkumyppM1Dmr6X+DpscJrI5J+tspO5w1FjsOsv0fT
Date: Sun, 14 Apr 2024 17:44:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] imap-send: increase command size limit
Message-ID: <ZhwV6CmcC8zeSJ-7@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <7026075c-db4e-4d43-bbd1-d2edb52da9b7@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="avYaioHjZqwCi4gR"
Content-Disposition: inline
In-Reply-To: <7026075c-db4e-4d43-bbd1-d2edb52da9b7@web.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--avYaioHjZqwCi4gR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-14 at 16:47:52, Ren=C3=A9 Scharfe wrote:
> nfvasprintf() has a 8KB limit, but it's not relevant, as its result is
> combined with other strings and added to a 1KB buffer by its caller.
> That 1KB limit is not mentioned in RFC 9051, which specifies IMAP.
>=20
> While 1KB is plenty for user names, passwords and mailbox names,
> there's no point in limiting our commands like that.  Call xstrvfmt()
> instead of open-coding it and use strbuf to format the command to
> send, as we need its length.  Fail hard if it exceeds INT_MAX, because
> socket_write() can't take more than that.
>=20
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> This time I compiled with NO_CURL=3D1 and NO_APPLE_COMMON_CRYPTO=3D1 and
> verified with a silly printf that the changed code was actually used
> and wrote the present message to an IMAP folder whose name is 1006
> characters log, which required a 1026 bytes long APPEND command.  Yay,
> freedom!

I'm curious, is there a particular problem that you (or someone else)
ran into that caused you to make this change?  I agree it seems prudent
in general, but if there's a particular real-world broken case that this
hits (e.g., mailbox names in a given language), I think the commit
message would be a great place to mention this real-world impact, which
would lend support to your argument that this is a valuable change to
make.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--avYaioHjZqwCi4gR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZhwV5wAKCRB8DEliiIei
gUmDAP4vIVCT6/opdsJGrCLYFya60lRtIVOOTUnqY0pMauCgHAD/SGCFvKZNFtGc
tYSedwPi5zzFa2WxOTuIQNF+fIxEnAg=
=Xj4B
-----END PGP SIGNATURE-----

--avYaioHjZqwCi4gR--
