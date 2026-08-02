Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A977E2931E0
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785708596; cv=none; b=gpNUJ6oDGSQaX9tCY8bh3oeVlkox71ZooWzgQyDQulmAVvje6annfrMqRmBqvVT7mLmm1vFQaWZhMsjPokpZICl2jjeSJrRgJxVpslvOAYMo9QZHmJ9+rmGIFCKbOJfd8hkokDaU1IwDiuRsyo+S4g8MOQk9ihyaMXdlOHXCq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785708596; c=relaxed/simple;
	bh=+Smi5VwxGCkADimzWDcrKb1cdTWToWbgTev13TEQbws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTPPGzO80lQuFNNsWcn1lfY0YrTi622cEp+FL2U+bnSrlUWLAfAtENUiZEOlXSu5dSrwLM0oS674BTaxZJnDfePu6eAjBKO750bwUzD6b/ecxHEgPQ+BrpJ7Dbj4LGCnz6zWy3cUt55HA1YYypCvDhmlmlZLO0dNKYnG3z3Mohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=R6zqCb6W; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="R6zqCb6W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785708593;
	bh=+Smi5VwxGCkADimzWDcrKb1cdTWToWbgTev13TEQbws=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=R6zqCb6WeECwBHY6xB8HHsR9Pn9idVvTR+clhDL6BSsNgAbUQWlRSE7Qlp987TwE6
	 AgYdbNI1U7Gjqr5OpnYRdxFZdk0CRy5FlnTdoTj8+k+HkG6GN11moiXkMYYYlQ0pp0
	 7ZA0GZvYpKZQDkR9kO1j5gQZAHvB59b45zU+cfoTjaoq3b+VKfExCagvnvaorbLeF2
	 n6qXHFKVbjgId8GZDWlZUVMB+rq33ddkMAmFw7fVcKIdDcm6QJocDoZJ/3BqATtC7e
	 2STymQwOj7ItnHxhdDxomNXqhC2w+23lxzqTo2TW2NZUNRW2+lmMe6f49qdrABwLdZ
	 NT3NowZYFmHZhCUK23PCNJ5ctMamTj8WdQB9e6vX8RJdUk1HM6M2DLzN/sezuvU42i
	 IJU2xoKDCCIBCYiea63/YMyGy7GwCBzfD2HxWlxmc3Z2K/0vlD43+/6A6aGiOzgFXt
	 lyUNEuA8XnVAHJwgZQOy9bQRYtkIJca+MJO8YMacyqmluQn1HTV
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:117f:c26e:50ca:6746])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9986F200C4;
	Sun,  2 Aug 2026 22:09:53 +0000 (UTC)
Date: Sun, 2 Aug 2026 22:09:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] hex: allow only lowercase object IDs in breaking
 changes mode
Message-ID: <am_AL9dymrkidizF@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260729233215.398654-7-sandals@crustytoothpaste.net>
 <xmqqv79vha69.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WH+Sa9E1M4r9gjFg"
Content-Disposition: inline
In-Reply-To: <xmqqv79vha69.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--WH+Sa9E1M4r9gjFg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-31 at 07:48:14, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Git has historically allowed either lowercase or uppercase hex for
> > object IDs, but it has always emitted only lowercase.  This has caused
> > people to expect only lowercase and not handle uppercase.
>=20
> It is violation of Postel's Law by other people.  We do not
> necessarily have to follow suit.

Postel's Law was a great idea on the early Internet, but it is
unfortunately no longer a good idea.  The problem is that being liberal
in what you accept these days usually has security implications.

TLS cannot be liberal in what it accepts because that means potentially
allowing attacker-controlled data.  Even HTTP cannot do that because
we've seen where refusing to reject requests with both Content-Length
and Transfer-Encoding: chunked means that two parts of a backend can
disagree on the content, allowing request smuggling.

We've seen these problems in our code where not caring about CR comes
back to bite us on Windows in a security-sensitive way.

Modern development effectively requires being clear and definitive about
what data is accepted and what is not, as well as what meaning is given
to the data that is accepted.

> Even though I said throwing object names in a single category makes
> sense, it may make sense to treat the object names that we locally
> use to access our own object database and those that we use when
> talking with _other_ people on the net separately for the Robustness
> principle, we keep being strict in what we produce and stick to
> lowercase, while accepting uppercase produced by those third-party
> reimplementations of Git.

Unfortunately, that also doesn't fix most of the security problems I've
seen, which involve object IDs that get passed on the command line when
tools invoke Git.  It does fix the problem with round-tripping objects
between hash algorithms, though, but I don't really want to audit every
use of oid_to_hex in our codebase to half-fix this situation.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--WH+Sa9E1M4r9gjFg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpvwC8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZxW2zu1XLiKuC98LSRXkftSgylUmsqCmpHVrck3cfe2D
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOfZAQClcDhyWV2IkgVewqQlt8db25wt
RntVxVPKR1ihZjASJwD/ZmObOV9daqNj/Y73QI8p57p8rM1fh9pg5xGwVHq/VQk=
=GvKK
-----END PGP SIGNATURE-----

--WH+Sa9E1M4r9gjFg--
