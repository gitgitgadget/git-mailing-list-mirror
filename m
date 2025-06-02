Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA22C3254
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748902643; cv=none; b=EUtRLVqDzPbjrLtyNVeDt5p/nNRMcAcHYtmxpiaFJaSMzZ5o5Tr/yvRpllnjfk387YudvCBXWrDbCQqMTORJogHgIczbDvoFgmdW3icMHs17R1pQ6Ev7lDcnDZyhCGdpxAszD5X4xAfUNcty+GLDJmMl+q5RHqGXVdQEAUEu6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748902643; c=relaxed/simple;
	bh=JkN242yqoExViUrWKQvPZRTpiRBo5A7w0EA2K+O0Qjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saTOfND2pnxIeWLqko+VDdjGdpzjGTT8L0M3FFXLmRnCJFCJXbqKE1iPNSbDWUkHjgwx4REaN34q3vjZ8hD57FawdJDfANS0Dk7aAAG8JXCqYacuM3NWGyP4ktY7+vho2vaN4wkJL8t4t9BZOZEgEb65b8e92OMDGbrz+yxLXvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=nw3Xh/ZF; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nw3Xh/ZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1748902639;
	bh=JkN242yqoExViUrWKQvPZRTpiRBo5A7w0EA2K+O0Qjw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=nw3Xh/ZFfS5BMZtuwKXQLFjfMtnQUvns8uwvTMq1lou6hSIZHdj/IPdQfWRf+bjot
	 uV0cas/PE5pYx6jhNZzcvW0SYpksQ7fjbDe4jIuYQN2iDx7Sg26OBVrdFXZ7AHRsvH
	 /IpTBreMXxLAGyGHcFGBOIFsKJ9SFgoQ6X5PPGTYgbgYlXwmITwa+D7kxQTyAEXDHI
	 v4tCiHs90TRYScmW1QX8/PzKhJpQDnocqA/86Rji3tdvhhLr4usXVu2is2OhuLkN6g
	 iNhnlgiQxjdjjmXbsMrQIUgD6XzJT4mHzQSFAyOHm9RC/FQI0jKalb7QIBbZcVe3+S
	 zt/DdfgUqFy89RIJ02r1A9rDDYMOJTJeJgi9wVG38Gxcnt/Z9vU4onOOr4vcih+Ccg
	 sbQgLcWqKcXpBqzJQifSR04tFfgq2F3La9BfuI7gCAAFpyxCGQslbwMdqJdsEdsIeb
	 8W4hjHPbOd0x5EWXLpdPihhop7Rc24x7Fvq4Fj0Q+45INRaf0I+
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2BEA220037;
	Mon,  2 Jun 2025 22:17:19 +0000 (UTC)
Date: Mon, 2 Jun 2025 22:17:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] extract algo information from signatures
Message-ID: <aD4i7YhUnT5Kgew-@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <20250526103314.1542316-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c+Nw9So5Fq4vDAgQ"
Content-Disposition: inline
In-Reply-To: <20250526103314.1542316-1-christian.couder@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--c+Nw9So5Fq4vDAgQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-26 at 10:33:08, Christian Couder wrote:
> Around one month ago, I sent a patch that tried to improve on how `git
> fast-export` handled SSH and X.509 commit signatures:
>=20
> https://lore.kernel.org/git/20250424203904.909777-1-christian.couder@gmai=
l.com/
>=20
> This patch was showing a single string for the hash algorithm with the
> following possible values:
>=20
> * "openpgp" for SHA-1 OpenPGP signatures,
>=20
> * "sha256" for SHA-256 OpenPGP signatures,
>=20
> * "x509" for X.509 (GPGSM) signatures,
>=20
> * "ssh", for SSH signatures,
>=20
> * "unknown" for signatures that can't be identified (a warning is
>   emitted).
>=20
> brian m. carlson however replied that it would be better to show two
> pieces of information instead of one: one for the hash algorithm and
> one for the protocol.

Actually, what I was saying is that we should have one for the hash
algorithm that is used in the Git object.  I don't care about the hash
algorithm used in OpenPGP, X.509, or OpenSSH (that is, whether it's
signed with SHA-512 or SHA-256), but we can have multiple signatures in
a single commit such that there's both a SHA-1 signature and a SHA-256
signature.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--c+Nw9So5Fq4vDAgQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmg+Iu0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZyWSYYdZHhflLGhHfvLEKBh7vkRIAHO3L13mTG5lT75I
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJkDAQCk3WQTlzMRHj39lX8JBEmYbMse
Mf12+de7rNPj8dIggAEAoaO+LNZo0sx8JAh/Kz0CDeteKbqTI61y9I1n9HYPFAQ=
=3mCg
-----END PGP SIGNATURE-----

--c+Nw9So5Fq4vDAgQ--
