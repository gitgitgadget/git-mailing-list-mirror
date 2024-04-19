Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57177F13
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713553425; cv=none; b=h1zlKX8vL7+uyCcqvxHoLd4ayn598dcnexT0ShW988SlbqcjiH6ggyzoAOts96nzmS0pE7FENmKm6gksNWUZX22Ss5jlOJFzYSKe8KNRJHCKldra2HnGsrEsvDKG0/6G5b/ZG6iIL4gLh2RYOyr7Tzs9acV/ZOcFq5IvlToifpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713553425; c=relaxed/simple;
	bh=6UelBTuSmd4T8t4A6K7TLm5q67xyIwAvTHmK7YFnZs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBuvozHv8KFCm+YfMQLRpO5mGwm/hHXvfmQYbmq4/VnnH3Lw2nfo+43qJVjhzJ7Yn7RQQOLAoA/HdCxtdaaxKCk3gPw+V0e3KNOKGZidGRiWrcDIQ+P1yzzglFA+5AfcJZHwP12E2I8u52fXnm8MUDKdtGYr33kepNWASs8QCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uetfPMlj; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uetfPMlj"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A10955D4E4;
	Fri, 19 Apr 2024 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713553415;
	bh=6UelBTuSmd4T8t4A6K7TLm5q67xyIwAvTHmK7YFnZs8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uetfPMljit2Ep2EDFUyeChsZ7Nn9U4MqNvT3zkd9ESmZWAwquXp216Xvocet7J1P/
	 3rx1FXiUDdQeMhJCl9zfrhLr7xwD1z6gny/NLki6DnKMtpfSWsElBU5xBEUZPHxLd3
	 Fco3j7TEnGT2TlQT6N3hMxn7ZiICtfc1gPOytYlKDzRuRPLDTUD3tXyievKGahpyU2
	 wBq1/0ggU8JufOzB0RzEhv2hQ5sCkvsiJBy1wCRyrx3zZBvGGC+3zZxOurL3FAd1DK
	 zSjxcgA1NXkYkUaIO52Evd+uPT9Cc7YY7ns4EwZ6IrEm5/KlGDtPyHIt689bTEVivG
	 hJR8+32yMb80DlMQ9toriMINspqaqrLzVFKzrsrv7NZwQFZB2W6x+jN6HBIP8cJUGh
	 3eucYtzZbgs2HLsHKgMv6DNwx9bj33MRyfqbofFzYSduJWGIRohNMgljaoJpNtOQ5q
	 hl1yGu/01k7e2EameD/J1AOZEuK5KieHdTtuq4h2+CKWFs+aQuy
Date: Fri, 19 Apr 2024 19:03:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] path: harden validation of HEAD with non-standard
 hashes
Message-ID: <ZiLABRgJPlNnm-uY@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1713519789.git.ps@pks.im>
 <aa4d6f508b4af3923813e19ff82a4e8484d5ff11.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dDbyhsMyfFxY72vr"
Content-Disposition: inline
In-Reply-To: <aa4d6f508b4af3923813e19ff82a4e8484d5ff11.1713519789.git.ps@pks.im>
User-Agent: Mutt/2.2.12 (2023-09-09)


--dDbyhsMyfFxY72vr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-19 at 09:51:10, Patrick Steinhardt wrote:
> It follows that we could just leave the current code intact, as in
> practice the code change doesn't have any user visible impact. But it
> also prepares us for `the_hash_algo` being unset when there is no
> repositroy.

The patch looks fine and is well explained, but you have a typo
("repositroy").
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--dDbyhsMyfFxY72vr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZiLABQAKCRB8DEliiIei
gTlvAQC5CdHBFpk9k3W+Oyq97y424JqpwRaThgC4lwdE9JL2tQEAtN0bTflHopBy
xXIkV+T+0oyUD5RLty+Fc6JDwTmkmQw=
=zM5A
-----END PGP SIGNATURE-----

--dDbyhsMyfFxY72vr--
