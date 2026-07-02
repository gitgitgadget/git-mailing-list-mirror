Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A05837A83C
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003684; cv=none; b=nw6doLhaufVzqB5fK8VrBZIoAL3W1IqK4lHx80Qca15ykOljHHUTLsRSqVllAw0maDmYCttz61U8c72B9csDuX3hnIh/582kVmVn2zc+p5sAUe64noEKIXC+ajoiwpdyYphNFcnRdbvZLMS6Lr2maGQju7r3TQgCSFIXMxAP71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003684; c=relaxed/simple;
	bh=JXiuh1srrf2Qh6EbyqyVepr7Y3QOXRGOVUK/8EM9v/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCGrK1e9XONBUgLCla4eDWoCnWej+99xtzBcmIG86XK9HrEpTrdTdpvU3FbkaGTLcd5ycxxun0qZwxjmfiMXoyj/17S3yRhhpipy2TBMTgMPUL/U9jR2+0J7dmW68PmlijN8RKyYN7cn5CLk5L2QHOq5fdSiMEgYV9Cnotr2dYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=TkUt/4ak; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TkUt/4ak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1783003681;
	bh=JXiuh1srrf2Qh6EbyqyVepr7Y3QOXRGOVUK/8EM9v/8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=TkUt/4akTsE/FbGK0XEaB2RoNvCde828SYRku7S8GzPqrfqRd2kHMG3ZwFWo1fibk
	 764NsnCu3XpM8ztT7J0faAg8yv3KkL5vCd6qlgnWoyLZMqhaOQghqZxtz+8diLyKOW
	 C0yFuFGx4bPwuWS8AD8JQKMzvgEDT9vTW+k8yW6B+Z08O5vcFBMFjlnn/J0ZTg0vQY
	 /z0aj0dLkv7jhq6Sz7REGeQF3mhtI/OfiaYNb8UgG/qVg4lVwSynkunBUwBtnzgtWh
	 auwqFtdku4k299yeeZyGHN7jL6u4vodtCss4SypMWrOB8ZeEOl5vqjcNkTMM+5wqby
	 GSPiU82OH/c3ilr3OK2MbQP7Mj1vKpJlyAA7ihlWS7wU6xIvNIUu8LacrAApgK8X1D
	 vOUlFyKqL6DzGlvT4uaD928czNEWlNO4EW53IAYxZWCVWd+kFbOaxkRhj0gqYEYPiJ
	 Gr/bCNLq2Z6U0GkyQ4pJYackXOuk/AgL+qJKpUHtUEX4g7nefrZ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:cd97:af94:901e:255d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 54A1320074;
	Thu,  2 Jul 2026 14:48:01 +0000 (UTC)
Date: Thu, 2 Jul 2026 14:47:59 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] t1517: skip svn tests if svn is not installed2sy
Message-ID: <akZ6H84Tzzgu8L5W@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <20260701212442.1430084-1-sandals@crustytoothpaste.net>
 <20260701212442.1430084-2-sandals@crustytoothpaste.net>
 <xmqqzf0al51j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cxqup8/J+cArcrAQ"
Content-Disposition: inline
In-Reply-To: <xmqqzf0al51j.fsf@gitster.g>
User-Agent: Mutt/2.4.0 (2026-06-19)

--cxqup8/J+cArcrAQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-01 at 22:27:04, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +test_lazy_prereq SVN '
> > +	test_have_prereq PERL && test -n "$NO_SVN_TESTS" && perl -w -e "
> > +		use SVN::Core;
> > +		use SVN::Repos;
> > +		\$SVN::Core::VERSION gt '1.1.0' or exit(42);
> > +	"
> > +'
>=20
> If "have_prereq PERL" is not satisfied, SVN is not satisfied.

Correct.

> If NO_SVN_TESTS is an empty string (or unset), "test -n" fails, and
> SVN is not satisfied.  Questionable---am I misreading this part of
> the logic???

I think that's reversed, yes.

> The perl script would not barf only if use SVN::* succeed and then
> SVN::Core::VERSION is strictly better than '1.1.0'.  If not, i.e.,
> libsvn-perl is not available, or its version is older, then we fail
> with exit(42), and SVN is not satisfied.

Correct.  And yes, this came in from `t/lib-git-svn.sh`.  I'll probably
just simplify this to omit the version check since it's very unlikely
that anybody is using SVN 1.0 any more and, as Peff pointed out, this
doesn't actually work using a string comparison.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--cxqup8/J+cArcrAQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpGeh8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ2esVso72BTGMQZe9y0oQoqeHChI30lCwpXDwo+2DEjQ
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJvUAQCh/YFr4FPoKReh8goaMJThNcsh
g1IF1cWjdFjS6YVyuQEAxmbxjHfWb6jdDV/1wEdV2tfbqXhS2abaI5E+bg4IqAI=
=tR2O
-----END PGP SIGNATURE-----

--cxqup8/J+cArcrAQ--
