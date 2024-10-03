Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFFB629
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914433; cv=none; b=uUAugW7kWpahcYDATa8yGdKK5kVtBdJnTGuIW/L68lu/72qSN9QMR27r7FUAn8EGEUMHXz8N3X/ZDwviE5vDI0XmIhsGf67EkYXufpB9Gt+4PDC9PqPHF+aq3SNAxtsK8DUyzqWcJRNKBqCtevhQiZ8AEqBkhjfBykT6VTDTzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914433; c=relaxed/simple;
	bh=dY8NXck9lghhVmhB0I0yDj6Z7xM3nBCE6OzBxiBJ5zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKBXjxItt9swrg7USw8zeGe9D8GtDMxWUWVr2X47ioCv4Squcmy3MWuydnLpmU2KwqwRGes+Ovq9RRxMUmzP7N0NLUTzEWAldtHSBBLlzupqqEaVuBWkjKWz4sXPAlx1kj877WgkDir6qLMayA4hH3wuc6hzie9csioUdsK9Nl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fT2b6rqo; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fT2b6rqo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727914429;
	bh=dY8NXck9lghhVmhB0I0yDj6Z7xM3nBCE6OzBxiBJ5zs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fT2b6rqoTw1iXpBttdTuT21EtZVsDx7gzCFYyyQ3PjxsnktS3CZQzWnZWaWjYCUGU
	 d3/3+h/KfCSBT9r2LFYTIY9NKn6jCv0sDN8tnqRUK+BpfdfCtGlqAjb8HMgfZaFic4
	 Qdam7XydGrkOvgdDeaqD+eiGGyB3yDa+aeCqUw+nG51g7eAo0SnWbuRQqzyT+hWLJg
	 UiAn/cPd87V53Q+t7HZ3jE7zzmba3cL+O8c15Kq5uajoBzeyli8yeuA6G3N4/Qk4yX
	 w5VtPh3cn+J2s4nAo4SkpWDjCAYFwXfl6utn0mWY36OSskmV3RgwmT1Oz6oKyJPyNw
	 gjjV4v9JZfZZYKytkTzrYaFdvxKYgnlCjnaB3cqS+brk4F6CcZy8eQS3XwTLfCor9P
	 pUzf1J8MNz6IIVHKzU3huN6JDHdw+zaxVbfeYEAX4d2xCoDouCV2w0y5twll1aIdLY
	 MOpGjY8a2XMr8JbRYAzQ6v0gbAGvQB7R3SAUfIBzgJcAd4hmRQf
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1C7082007A;
	Thu,  3 Oct 2024 00:13:49 +0000 (UTC)
Date: Thu, 3 Oct 2024 00:13:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (v2.47 regression)] hash.h: set NEEDS_CLONE_HELPER_UNSAFE
 in fallback mode
Message-ID: <Zv3huwCNuqi5C8Wm@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
References: <20241002232618.GA3442753@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ztW+xSd96b+2bAAc"
Content-Disposition: inline
In-Reply-To: <20241002232618.GA3442753@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ztW+xSd96b+2bAAc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-02 at 23:26:18, Jeff King wrote:
> This is a regression in v2.47.0-rc0. As mentioned above, I kind of doubt
> anybody will hit it in practice (I only did because I was trying to do
> some timing tests between the fast and dc variants). And it is almost
> tempting to leave it as a wake-up call for anybody who is still not
> using a collision-detecting sha1. ;)

I think this is a fine fix for 2.47.  I have a branch on my remote
(sha1-dc-only), which I'll send out after it passes CI (probably later
this week), that removes support for the everything but SHA-1-DC (except
for the unsafe code).

I don't think there's a reasonable configuration where people can use
Git with other SHA-1 code except in extremely limited circumstances we
shouldn't have to maintain code for.  The code is open source, so people
who really must have maximum performance with all of the vulnerabilities
can patch it back in themselves.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--ztW+xSd96b+2bAAc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZv3huwAKCRB8DEliiIei
gaCTAP926U118VHqznLqFvFLsPf0aB38vgNvFx2ziyc1XiM0cgEApLIuxBw005ZB
fivzqd1IGLZSAOGCwGMMta9+GAam2ww=
=plfB
-----END PGP SIGNATURE-----

--ztW+xSd96b+2bAAc--
