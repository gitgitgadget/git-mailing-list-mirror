Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF762DE6F5
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947356; cv=none; b=aWs7CWdtOjA7c9LX4YSCz3CKhydCg9nowI54q2Ri0bIquLhrbGuWr+fPotP2SKN5TpJmvgFZf/fFCy1D7O954QLsLsG8YpGx35LV79bzc+Ztjr25JXLtY7gLH9dzEcVMH1Lszy+wRw06hJveAErX3cOUK6YsMl0y2v6rtaPZfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947356; c=relaxed/simple;
	bh=rYnFXX9YmVLkZLeppszt6hPHuBMYwdjniJUZfY4oIHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3RfHRgTiNifSY6AuGstUL4XfN6l040rbclWjc+PNG+7FF7AyClTIIfKUmVKYRlR8BX3GoDyMfQg80ebIsaJfFSM9fVM73NORsIIcgpD169UxWZ/IThzo+mR6/EnmeNb4rYJuRWjHvuwiJutA5xy/hyuXjPtgSHgPq7Mc2INiS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=GuXWenNP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GuXWenNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1754947034;
	bh=rYnFXX9YmVLkZLeppszt6hPHuBMYwdjniJUZfY4oIHM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=GuXWenNPl3FUzqKstSw+8nbivDp3U6wY2w3ZtfhzZeh0snmKe16xFL5EvcjDk7tcy
	 kQT5ykbKNfnMoNuOeipzz1fOFXxJRKfi9N60lVtb9gdMo1gavwC3bQs1MmlkXEydJp
	 ecI+MLB5ZpYvCaC67lRxFJQ0SZcgAg/8K1b0FBXMpvJiizEO1dkwWcpswXxBOoq66Y
	 v9WFYX5H0UMW5M4WkDhTHycVIPektrZJ+m3yBCzfvvpS8mKXDbVNKoKck18l5rpZkk
	 AJUKW/73XgqKqtN7nlTjxc2RgpmhRBHKDHqQC4RSkvDT1o4j8ChSZvaxnyMkQPP1Zw
	 gS2a2GLRzcLLKu9PVDjk4THptNaXIrba0vilYjGbUUy5CXATgv4h4TbsPUKxxp9vMf
	 8hKYHrhiBzqKC+btUPrBV5wIwzb+8G22xKJj9ySEaAQCaI/gFcPVBrjM+eUrStfMiw
	 1sAaYxK3qm8TtrbbfekebN0pD/JYSSJNzzZz0QaoLiO78LAG9j3
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bbea:a384:d97f:8068])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 32AF4200B4;
	Mon, 11 Aug 2025 21:17:14 +0000 (UTC)
Date: Mon, 11 Aug 2025 21:17:12 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jon Forrest <nobozo@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] abbrev: allow extending beyond 20 chars to disambiguate
Message-ID: <aJpd2MYMWgEoxQWi@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jon Forrest <nobozo@gmail.com>, Derrick Stolee <stolee@gmail.com>
References: <xmqqfrdx517b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="woOy3f9rrfSXHsw1"
Content-Disposition: inline
In-Reply-To: <xmqqfrdx517b.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--woOy3f9rrfSXHsw1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-11 at 15:26:32, Junio C Hamano wrote:
> When you have two or more objects with object names that share more
> than half the length of the hash algorithm in use (e.g. 10 bytes for
> SHA-1 that produces 20-byte/160-bit hash), find_unique_abbrev()
> fails to show disambiguation.

Is this really the case?  If the restriction is due to using
GIT_MAX_RAWSZ instead of GIT_MAX_HEXSZ, then that's 32 vs. 64 in our
modern codebase.

> To see how many leading letters of a given full object name is
> sufficiently unambiguous, the algorithm starts from a initial
> length, guessed based on the estimated number of objects in the
> repository, and see if another object that shares the prefix, and
> keeps extending the abbreviation.  The loop stops at GIT_MAX_RAWSZ,
> which is counted as the number of bytes, since 5b20ace6 (sha1_name:
> unroll len loop in find_unique_abbrev_r(), 2017-10-08); before that
> change, it extended up to GIT_MAX_HEXSZ, which is the correct limit
> because the loop is adding one output letter per iteration.

Nicely explained.

>  * No tests added, since I do not think I want to find two valid
>    objects with their object names sharing the same prefix that is
>    more than 20 letters long.  The current abbreviation code happens
>    to ignore validity of the object and takes invalid objects into
>    account when disambiguating, but I do not want to see a test rely
>    on that.

Yes, even if we could efficiently create such a collision with SHA-1
using the best known attacks on it, that would still be 2^63.5, which
was estimated to cost about USD 10,000 in 2025.  I don't think doing
that just to produce a test would be a good use of the project's (or
really, anyone else's) funds.  Using SHA-256, of course, would require
at least 2^80 work.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--woOy3f9rrfSXHsw1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaJpd2AAKCRB8DEliiIei
gSlCAQCHHV76tdVuJEQ7Rk2qzJTCoeyMtXjPqUrEpJoTx3vzUgD+PHngGX2a6rcS
qMmK7trcgaUR7C8oUSwUMBxBBGmOAQU=
=OPbB
-----END PGP SIGNATURE-----

--woOy3f9rrfSXHsw1--
