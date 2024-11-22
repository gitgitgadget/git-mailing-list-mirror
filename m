Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777717B428
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307844; cv=none; b=ATdHOgqdJkRCnEXYqTeZxmt0dO6pe1fwgzl6m+DujAUDCz2cFX9j7BAV+qdKV6qqjr5GZLjaDgr/gZCMxzi4/eSDbw6JyEGo3KECOyhlDH9yq39Hs0K+GczphukmGuCf9PustfVK3PWMPPvsnnqv2a1kgvu+YbRJHkolelTzYD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307844; c=relaxed/simple;
	bh=NbFNoo7Y5TWbcBoGlM/73xdXrFRzExIsN/7uyyQVkQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUmtPkhtDWBI1zRE7x0wNaDmbdnAuxY4mLHJCAUbRt0ry4DIvD/jq+Bxa2alHfW/EfUahF0zTQRctls23JzsfjznX6T0SEwfrlkc9ZLdb9niJZ21A/MwmW64u7Q31wU2IgL6DS/vl0Esml4SJJpJzA262huuLHvQUpsR+XEmYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=LKNqTs+S; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LKNqTs+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1732307839;
	bh=NbFNoo7Y5TWbcBoGlM/73xdXrFRzExIsN/7uyyQVkQg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=LKNqTs+SVUQrf0u8fc29PcqB69L3X6Kib/s2hIZNZEs9hST+bgzqQoj/+hLOluGCy
	 4i55tUEEWVK1kNHHQgkITivi4qfmo5qg2ZyVXaaWFzyJTQjkf4X2ZDqGtcjoYpqoI+
	 uu3upK+RCTW4N9kglLp2D/RdKjxDoEzgiCfh8HSRSZdlvgOMNIJtwBMoXL8mcDthDy
	 uSy4Gq7Az8swGjGgxyu0335nsDWHJTgeFUf1kv6JVvzrlv9EVzYPn6QMqMJBeiyxAT
	 PySqzjwS+opzIeSfOh7k04CxolJvvmZKrgh+YT0SDHcjPLRNp06mmhY4nyM0/TzKBg
	 0QlaTkDNwn7lhaCgPMJk9EzkLUf3gXTdsRH0DSh0Khc0NzSbkyhm8sGWAsfgTecK8v
	 MEYE1mvKGpY/gUk2uodRshAt9uxop1eECpqEzT31FuxiVu+K0W1smRR04jSBeSn6t6
	 OZi2bm1iQb0syHoUglpe219VRLg9+L8pgVlGQmo/xuDLlQGU1Qr
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C58E520994;
	Fri, 22 Nov 2024 20:37:19 +0000 (UTC)
Date: Fri, 22 Nov 2024 20:37:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] hash.h: introduce `unsafe_hash_algo()`
Message-ID: <Z0DrfjZ_ktEwwE1w@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <17f92dba34bee235177c8100daab49068fe37254.1732130001.git.me@ttaylorr.com>
 <20241121093731.GD602681@coredump.intra.peff.net>
 <Zz_SwuEw-KYM9xJl@tapette.crustytoothpaste.net>
 <20241122082523.GB1179306@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hmt22vupeh7oQotK"
Content-Disposition: inline
In-Reply-To: <20241122082523.GB1179306@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Hmt22vupeh7oQotK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-22 at 08:25:23, Jeff King wrote:
> OK, here's a quick and dirty conversion that applies on top of Taylor's
> patches 1 and 2 (and then patches 3 and on would need to adjust to the
> new world order).
>=20
> There are quite a lot of spots that needed to be adjusted, but the most
> part it was just s/->\([a-z]\)_fn/->fn.\1/.  (I'll leave adjusting the
> unsafe_ variants as an exercise for the reader).

Yeah, I saw that there were about 50 callers of the hash functions,
which on one hand isn't too many to change, but on the other hand also
surprised me.  I don't remember there being that many callers when I did
the SHA-256 work, but it could be that I'm remembering poorly.

> The naming convention was just what I made up, but one nice effect is
> that it replaces "_fn" with "fn.", so the line lengths remain the same.
> :) It does mean there's a function called "final", which is a keyword in
> C++. I don't know if that matters to us or not (I feel like we were
> trying to avoid those, but it appears as a function elsewhere, too).

It doesn't.  I think we had one contributor trying to make the code
compile as C++ at one point, but it definitely doesn't now.  A quick
`git grep` show that we have lots of variables named `new` as well.  (In
addition, the implicit cast of `void *`, such as from `malloc`, to a
pointer of any type is not allowed without a cast in C++, so that would
need to be handled, too.)

> So I dunno. It is a one-time pain, but I think the result harmonizes the
> type system with the concept better.

Yeah, I agree.  It definitely looks like it could mostly be done with a
Perl or Ruby script, even if slightly inconvenient.  And if there is a
conflict, it should be easy to fix up.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Hmt22vupeh7oQotK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ0DrfQAKCRB8DEliiIei
gY6uAQCrr/vb3VY4i+RccCxa60s0+8FXdr4J3BiAplwM7YyrSQD/XHHAUhl6dkie
5qYKVM0KG3Wjdj6CcQdQ7sElQEG1dQU=
=RCAC
-----END PGP SIGNATURE-----

--Hmt22vupeh7oQotK--
