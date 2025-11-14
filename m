Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D232306D52
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763162786; cv=none; b=lXRiK5+NPkyszDg5pu1C2WcrxQASMeON3I9TWbolUhm1HaaqGAq3BbHJXX+L44ElgZTEWxbNZJuhfEOVHOufLCt3voFxGcL0/16EPi/JwRkGq7F6CFJW0jsjvLovaU/OFAPlBgcb/12DUMfDCtT8P9k2Nnvq6L1Ng6SFOWPt+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763162786; c=relaxed/simple;
	bh=q9izFLn2fWXxPdRWdwFWeByZQ6HUkcIs6KKSC0uCqiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdzSZUH1CL/4flBT8Mq2bMAwHRlJmQmE4Zg8TD/J6zhRAeqsmiTm835xnTTdzeTCYV5KxBNhUXb4to7SvIjhXsf+7Rf7lxB5olfIVmpUEYlt1I2L6C58kJ18fsE4kNcuwDrcOvUepUxYHXqHwttn1zOORpmnWYMO33H7VaOQZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uldNKpon; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uldNKpon"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763162776;
	bh=q9izFLn2fWXxPdRWdwFWeByZQ6HUkcIs6KKSC0uCqiQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uldNKponKxMfrhLj5NgReRPnASSAt0V7MYlAo88qOKEvOr3jG31esnyXt1pasZPin
	 GE/vqSBJsMi/gop/STb9K9woORAEB9LQYD6EZLdXG5Ma+PVFsbvBRKwQ3nqekHORZa
	 zZN/tF67ba/JNtiaPtvyOYsrZBSKNKIkwwM02chu0PTdpeHKXPtQ/8bXmQm4u+2O0A
	 /yMRmF2KB7IQYJeCC4rg46eqyA5noxe+ZsIIG2sOqxrBldRpxJEhUfCI7F+hdPVhx0
	 5P6TRnRFq0m1VIEnDcJhj87/yH9fBCZBG7I3iBDo4SrLitEJWd7fmdwimGfb22bvpu
	 aQYbN6LbNQuPtmTNx0KnGfRHf2JYKcLJ06wWTDnTi2nvLpjfJHEXheSbGfsDJkVghV
	 TlRxUTtGSHVWQtLBobGrMRFqWno0NZbWFgoZd/dJ2y05nX0l9Mt734rEDjVCv86nyN
	 /1rz/N08EreFBupXXn6/JayOdOwi5tEOZJEFHXh6fje7YyidvTh
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d3f4:1fda:d3d6:71fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 965FB20065;
	Fri, 14 Nov 2025 23:26:16 +0000 (UTC)
Date: Fri, 14 Nov 2025 23:26:15 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Martin Wilck <mwilck@suse.com>, Adrian Schroeter <adrian@suse.com>
Subject: Re: [PATCH] object-file: disallow adding submodules of different
 hash algo
Message-ID: <aRe6l5YRCzLAxeuB@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
	Adrian Schroeter <adrian@suse.com>
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
 <20251112235434.1499699-1-sandals@crustytoothpaste.net>
 <20251113032619.GA1739649@coredump.intra.peff.net>
 <20251113035614.GA1758009@coredump.intra.peff.net>
 <xmqqjyztq4kz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PxusSwWfkRbBOvnN"
Content-Disposition: inline
In-Reply-To: <xmqqjyztq4kz.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--PxusSwWfkRbBOvnN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-13 at 16:29:00, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > So this is what I'd propose on top of your patch. I can hold onto it for
> > later if we don't want to muddy up what you're trying to do.
>=20
> I do agree with both of the above.  The patch below makes perfect
> sense to me, and it is more about the quality of implementation of
> this codepath in general, than the primary theme of Brian's changes,
> so there is no strong reason they have to come in a single series.

That's certainly true, but it still applies cleanly on top of my revised
patch and I'll just include it in v2.  I'm running tests now and should
send out the series later tonight.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--PxusSwWfkRbBOvnN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaRe6lwAKCRB8DEliiIei
geeeAP0dOfThm8RQfMZ58Fk4iGpAy+PARLSe2+uFQgKUEo3GxgEAoiZU+Fbo+8u8
I2SSs1VnjB5J4FJQCJWqJyKf3q3n7QA=
=dSU8
-----END PGP SIGNATURE-----

--PxusSwWfkRbBOvnN--
