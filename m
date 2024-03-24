Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90FD179BE
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711293668; cv=none; b=aauNduizXjcBLC2gFoCTKJ+WTj/MtWIkeYNW1I1zD0KwYiX7jqyduZMvKKVWk8O3UAV7CZyAuFuAg8FUqE3c8bdHZQvMuzIqcr8tApPhq8o4vghhL3bLkACfQaDS5rUwX9rqjMxflAcBaruViKqYbsC6QwF+XLhcfbMbvzmHp+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711293668; c=relaxed/simple;
	bh=9nLQj9xKm6fEvCauKh8ldQXOAvsa1evltRjCR5udwzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2xB6k5ntB3Wmqw3vPpGEolbbTZlbaY8+khI+2Ht92381e08xqaLyYxveEsbdwSL7PQtkPYxO2RPb7dp+Zuhc5kF5VIT9n2tszI7EqP4irnA7qwUD/biH8pwAwoYXE3M7+ih3FyX08+h8X7d68Z04YU1hVt0U++14og2KLKeJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=lHlXXktV; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lHlXXktV"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8A2AD5B41A;
	Sun, 24 Mar 2024 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711293664;
	bh=9nLQj9xKm6fEvCauKh8ldQXOAvsa1evltRjCR5udwzM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=lHlXXktVHa6QWjhi9Dbl+/QMcy0PbowQuWTSUJ53BAuKU4EtCJq7GSr7AGVUPsMcN
	 r7E7owN9Lbw1qdAsrzKllQg9KmrD68NNW16uvv6oF1cYYqPQBgzim/nsLysbqE5rY7
	 GkSkscfTQR5MBTAFvRQ4lnFIhkSGsKCvamRPrZmtTL8yAtUVcI4Co0f7/zLgi4tuqA
	 WCKL1Yd89BceMRx6aeGmfgMmgQ/BVVNNSS0A/VEXHOg8uvc3wbm3xgDmna83wzBiyj
	 3kjlOQGeGYlshyXTbb2yKPB8hD5Zj0/LqTGSOkdINc6iKv2HqtmNiQZT74RyDxtOok
	 dgmrEAtqgocC3Wy/gmK3fXqqxHdCnTmgSigOxlEbKLt2yLYbSFmzGnUIAUjuZdTjoR
	 5q/ntI69IswSLBTE+RllCCB0FMFQojWSrfCzRp0iYpSY75aXJNzUpv1d1kqW8zRw/+
	 ficv7pEg7k3Lq8VFbAsMAyhEPT2KXwRkcUTSLfcOaob8o4ikP/i
Date: Sun, 24 Mar 2024 15:21:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 00/13] Support for arbitrary schemes in credentials
Message-ID: <ZgBE37Xs3TQEF2c-@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <xmqqedc0v029.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uxd7PzaOO6YsejW3"
Content-Disposition: inline
In-Reply-To: <xmqqedc0v029.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--uxd7PzaOO6YsejW3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-24 at 02:24:46, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > ... and because of this difficulty and the fact that NTLM uses cryptogr=
aphy
> > known to be insecure since 1995, there is often little interest in
> > implementing this support outside of libcurl. However, it would be
> > helpful if people who want to use it can still use it.
>=20
> This position was a bit surprising to me to come from you, but
> perhaps I am mixing up my recollection of your past work on this
> project with somebody else's?  I somehow expected to hear something
> more like "if a less secure thing is cumbersome to implement, let it
> be, as that is better for the world".  But I am OK to add less secure
> thing as long as it is an opt-in "easy way out".
>=20
> Everything else I read in the cover letter made sense to me.  I just
> wanted to say that the above part was a bit surprising.

I do firmly feel that NTLM should go gentle into that good night.

However, we've seen a lot of user questions on Git LFS from users who
want to use NTLM or Digest, which we don't support and probably will not
for security and maintainability reasons, but which their corporate
environment imprudently requires. Thus, my goal is to make it _possible_
for people to implement this, but it to make it their responsibility (or
that of a suitable open source project) to do so instead of asking me to
maintain it.  That, I think, is a fair and equitable tradeoff for this
situation.

Also, right now, Windows users sometimes choose to use the older v2.13.3
version of Git LFS which, due to a Go standard library bug, has an
arbitrary code execution vulnerability, but which did support NTLM.
Thus, it would also be better for security to have people on a suitably
patched version of Git LFS with an external NTLM helper.

This series would also, in an approach that's better for security, allow
people to use better Kerberos mechanisms than what Windows supports
natively, or to use an AWS HMAC-v4-style request signing (using
HMAC-SHA-256) if they want to do so, both of which would be a win for
security.

I could have put all of this into the cover letter, but I felt it was
pretty long and didn't want to sell this as an advantage only for Git
LFS when I think it provides general benefit for Git users.  I know
the policy of the project is not to prioritize any one external
project, and I try to be sensitive to that here.

I don't think this constitutes a marked change in my historical
"let's-remove-all-the-obsolete-cryptography-and-obsolete-operating-systems"
approach, but I see how it might look that way at first glance.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--uxd7PzaOO6YsejW3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZgBE3gAKCRB8DEliiIei
gWw+APwOpbt8jraQTwZmjI9F+GgEPd5rBZ9S+UbuUW8m6I1cBwD9F69YfN3oI3KQ
CvyxjASr0WWlAWzBfOUfAQ0jyhgr5AI=
=ylmp
-----END PGP SIGNATURE-----

--uxd7PzaOO6YsejW3--
