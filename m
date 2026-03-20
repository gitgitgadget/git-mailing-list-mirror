Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFCC38D6BE
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045848; cv=none; b=m1nea9u5l2ezTOowRoVcMrDM8V4gDdFETnmP7snydcPQMlhQGf52b7dr2MmG60+ASNbdqldN6KMKEtwde32uSSlrd6niss+TsfwoqiW5km9LpCTvL8NJUeI+NZKoEAd5MjIwqG/fZcKBPuvE7Jd3sT7EgFBHjbS0IdhrJhAbw/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045848; c=relaxed/simple;
	bh=8EFqE8FPBz4lU1e6fs6w4zW9kqaB+e5fe/vfWhk0Wmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXBVY/NDzwahijR/Oc3q0J0kWsa2nbBFlcp3eVybuCZmveW6aBkkq/PlpKS471G0HJ79J1eo0wY0vjIEorYX2TrJsCOIV+rMKxn1lItQmWHtiiTcos8LCDeJ+SrCHjbYwNNHClmKc91DjHOi0TRfJWO7kKaYpTBKQmg3qtYTU2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ByuTpNkA; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ByuTpNkA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1774045838;
	bh=8EFqE8FPBz4lU1e6fs6w4zW9kqaB+e5fe/vfWhk0Wmk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ByuTpNkA2gtxqCN59UJoslhragvQn12rE84rHWsWhVCt+dapd+HFGPBsx2UOl2spX
	 jicImXT33MbmSqZthf+wA75e4N+nzyDOCqALHZK/KN8XLSNlaQ0kVMXtBXW0NmV/El
	 b108BcqvOM1wIXvhGCn+wXfuSwR47kT7q2w5PIyimL/7MYTPTw67PDM6yq1K207f34
	 LB5UEp9QGtMhAsA8c9Q//Q8+km/J/u/KuibyimvUSvDm00hT1xfOttxyzm3WHh4bvq
	 qApgsrBhuYnkNS1YcUqp8tK1KcL5I2PJdxrpTsZ0h0Bp6xszXViqpkxX/8lGck9hFS
	 CUjeyO8E67SbRoQDN87SajZNeHAOw0rCkhSZBO3cKs+ToaNS8Z50VR5bJUqkt8fk5m
	 5eOBwkUbqKFryShp3uHKW7jc6ygCSCqhcUCcHixrQ8bsQm0g/Jv3AZbWhgKC6EIpi7
	 jOv2vuUmcrnYq3c8cgf84q8JaJ1Uqp1i7IDSajvDfCfvx4vlSUu
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:6371:81c9:4930:85a2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4E5C020113;
	Fri, 20 Mar 2026 22:30:38 +0000 (UTC)
Date: Fri, 20 Mar 2026 22:30:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/14] oidtree: modernize the code a bit
Message-ID: <ab3KjF_1WW7hQBaA@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
 <20260319-b4-pks-odb-source-abbrev-v1-1-5ddebad292b0@pks.im>
 <xmqqeclfn6nn.fsf@gitster.g>
 <abzryk0qjlbvy8OL@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qi3kMs+94jG9powz"
Content-Disposition: inline
In-Reply-To: <abzryk0qjlbvy8OL@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Qi3kMs+94jG9powz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-20 at 06:40:10, Patrick Steinhardt wrote:
> On Thu, Mar 19, 2026 at 09:08:44AM -0700, Junio C Hamano wrote:
> > I know the original also used GIT_MAX_HEXSZ to clamp the length for
> > sanity, but because we know what algorithm is in use, I wonder if we
> > want to use the limit more specific to it.
>=20
> That assumes that the passed prefix OID actually has an algorithm
> attached to it, and that may not be the case. We could initialize the
> overall oidtree with a hash algorithm in `oidtree_init()`, and if so we
> can then become a bit more thorough with our asserts.
>
> But I feel like that would go beyond the smallish cleanups that I'm
> doing in this patch.

We should stop assuming that a zero `algo` field in `struct object_id`
means `the_hash_algo` because that makes libification hard and our Rust
code doesn't support it (because accessing mutable globals without a
lock is unsafe)[0].  So in general, I would be fine with forcing callers
to set an algorithm per OID, both here and elsewhere in our code.

However, I am also fine with doing that in a different series for the
sake of minimalism in this one.  I will probably get to that at some
point if nobody else does.

[0] Rust also typically initializes all fields explicitly (and
zero-initialization is also unsafe), so there's no urge to be lazy and
do `memset(p, 0, sizeof(*p))`, which is the usual source of the zero
`algo` fields in our codebase.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Qi3kMs+94jG9powz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCab3KjAAKCRB8DEliiIei
gWHeAP9vMBMY8f3FCFx2xHo82qERxwpL902sHOvYp3xC8EKzOQEA+4HpNrDjDN4n
AR8pJO2Bocnz+61ne5AZL7k346LATAg=
=yg2T
-----END PGP SIGNATURE-----

--Qi3kMs+94jG9powz--
