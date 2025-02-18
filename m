Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBEB26FA5C
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898633; cv=none; b=dBsaNn3k5b5WHjZrg/285ifCA4lpAFcWC5WeA5P1bWzz0GebRmaVs16A2WdZLxjR01ZzT3lgG0FBQlE1PTpo3+M/J97ZlxCCZ/hl7De2G+YS41XloiXALMB25W8FiUtfHnYvlED2WLfKLJsF0jC8SuBBRAkvz3zME3yjkBBVY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898633; c=relaxed/simple;
	bh=vjFxmu4AenWkGqULICzTJXAde+vgoY6Y9cu5gYY2BnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7g28EvoNrxbsUt3tO6VpOmOD1S1/nVgQ4SYYzxYrdO9HjE8RIO5hM4Mta65LWMYFE/zNHHhorb2VEsrISfTbRvbF4wjCkjMppHCDSjrPZLAZ0kTBCs6PNk5O4kElnGMSo0Hkj/cRk3lm/LuTlc0c09w4j/xar2GEH7PqkwZufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Eq1MIism; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Eq1MIism"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739898623;
	bh=vjFxmu4AenWkGqULICzTJXAde+vgoY6Y9cu5gYY2BnM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Eq1MIism8cWN0lEBmLegnn6D7RvaV0NJlsAXTiqZsUpKWhCi5Cyc4qd5gtYmdFfIu
	 KsSsQQUblsFsB9lCPOfEdtISwJ7ucw6WHjHdQXfFExp9LCqh0boJydUBqtPNf/85BB
	 Yq9ZyDwM3yd1u8W5Rys3U7WQFsIcE6SqR9VnYQC65UuahEswJLyAgfmg7czt0claK/
	 434092pQZm8gjbi61/9Pp+RVdF6vh3HfiQYC1hoERv5EXo8GYKAk+UVDSF+bne03xX
	 /wXzjEFAjLuaKahmcbFID6RLMo5+nw0vlsAlQUB3iCvPp9bFbAlsSc/HW+Lg8TX9gQ
	 2MDfKrG9eGKDsaMw3nXgsWT5wZ/EElNQIpeqSGauual6ljjhJRvwhvJV/PUzGjScuD
	 VC8n4nP5REkxdQ0Hj9Dj+LEwk4lIgRdHuTn89YIcGg2boOXBGNfIQ+CvGWnZxDH8ZY
	 +hPlR4IVGR+lRH5ZFFJJl5bmiB9KQVT5JSP924wGir5tMayT+xc
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A8E852007A;
	Tue, 18 Feb 2025 17:10:23 +0000 (UTC)
Date: Tue, 18 Feb 2025 17:10:22 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 00/14] refs: batch refname availability checks
Message-ID: <Z7S-_iA73twblpvP@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JAe2Qw6WR83dKv/B"
Content-Disposition: inline
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--JAe2Qw6WR83dKv/B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-17 at 15:50:14, Patrick Steinhardt wrote:
> But more importantly, this refactoring also has a positive effect when
> updating references in a repository with preexisting refs, which I
> consider to be the more realistic scenario. The following benchmark
> creates 10k refs with 100k preexisting refs.
>=20
> With the "files" backend we see a modest improvement:
>=20
>     Benchmark 1: update-ref: create many refs (refformat =3D files, preex=
isting =3D 100000, new =3D 10000, revision =3D master)
>       Time (mean =C2=B1 =CF=83):     470.1 ms =C2=B1   5.4 ms    [User: 1=
04.5 ms, System: 363.1 ms]
>       Range (min =E2=80=A6 max):   465.7 ms =E2=80=A6 484.3 ms    10 runs
>=20
>     Benchmark 2: update-ref: create many refs (refformat =3D files, preex=
isting =3D 100000, new =3D 10000, revision =3D HEAD)
>       Time (mean =C2=B1 =CF=83):     407.8 ms =C2=B1   5.4 ms    [User: 6=
6.0 ms, System: 340.0 ms]
>       Range (min =E2=80=A6 max):   399.9 ms =E2=80=A6 417.6 ms    10 runs
>=20
>     Summary
>       update-ref: create many refs (refformat =3D files, preexisting =3D =
100000, new =3D 10000, revision =3D HEAD) ran
>         1.15 =C2=B1 0.02 times faster than update-ref: create many refs (=
refformat =3D files, preexisting =3D 100000, new =3D 10000, revision =3D ma=
ster)
>=20
> But with the "reftable" backend we see an almost 5x improvement, where
> it's now ~15x faster than the "files" backend:
>=20
>     Benchmark 1: update-ref: create many refs (refformat =3D reftable, pr=
eexisting =3D 100000, new =3D 10000, revision =3D master)
>       Time (mean =C2=B1 =CF=83):     153.9 ms =C2=B1   2.0 ms    [User: 9=
6.5 ms, System: 56.6 ms]
>       Range (min =E2=80=A6 max):   150.5 ms =E2=80=A6 158.4 ms    18 runs
>=20
>     Benchmark 2: update-ref: create many refs (refformat =3D reftable, pr=
eexisting =3D 100000, new =3D 10000, revision =3D HEAD)
>       Time (mean =C2=B1 =CF=83):      32.2 ms =C2=B1   1.2 ms    [User: 2=
7.6 ms, System: 4.3 ms]
>       Range (min =E2=80=A6 max):    29.8 ms =E2=80=A6  38.6 ms    71 runs
>=20
>     Summary
>       update-ref: create many refs (refformat =3D reftable, preexisting =
=3D 100000, new =3D 10000, revision =3D HEAD) ran
>         4.78 =C2=B1 0.19 times faster than update-ref: create many refs (=
refformat =3D reftable, preexisting =3D 100000, new =3D 10000, revision =3D=
 master)

I'm glad to see this performance speedup.  That's a really nice
improvement.

> The series is structured as follows:
>=20
>   - Patches 1 to 4 implement the logic to skip ambiguity checks in
>     git-update-ref(1).
>=20
>   - Patch 5 and 6 introduce batched checks.
>=20
>   - Patch 7 deduplicates the ref prefix checks.
>=20
>   - Patch 8 to 14 implement the infrastructure to reseek iterators.
>=20
>   - Patch 15 starts to reuse iterators for nested ref checks.

I took a look at this series and I didn't find anything that stood out
to me as a problem.  I will say that the reftable code isn't my forte,
so please don't take this as a formal review, but I am definitely
positive on the series in the general sense.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--JAe2Qw6WR83dKv/B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ7S+/gAKCRB8DEliiIei
gTzPAQCqisukkTt1VD33wA6QlQ4dvJzfbbwwKql8VrXaW+0y6wD+IzGFsVW0qqms
by6v6hpe0mzLZy/PkG25te8GUjTJ7gE=
=07fu
-----END PGP SIGNATURE-----

--JAe2Qw6WR83dKv/B--
