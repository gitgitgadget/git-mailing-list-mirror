Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F599161310
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744756381; cv=none; b=gL+xl7popsBfq6dhq2djMU4E2KNiSeM/0+eBfRkr8jthEErXoN4KE5gzHu1UW98vSnKrhjsVqvQOW8gmTP+a76XPBebi9icc8+pvQjZ6Gr7dErtdhhpeGQxQgI1qEaoNOR8lh2KStCHYm2cMNwMkTSsMDrJ+ICT3Ucvn377qSgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744756381; c=relaxed/simple;
	bh=GkvKGKg1dfAMVnKBSxGS3wmY+3p45TteTsvMDUf0Bv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iweFwyawMGrObfUGqXp8NYH8uzUOiDdK3efz/dkk7IuXbPSWnIFgOu8WVZmqn0udy3CIb2anSwn+hctf1NXyJkhJHqxrFZHZv90UWHt5FFV19vHXu2vCWw7U8IiUemGpq6xJj4O51OcogvQIdT+PtRUCckLiLuH28MaHrUxgVxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=QuFSvd2Y; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QuFSvd2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1744756371;
	bh=GkvKGKg1dfAMVnKBSxGS3wmY+3p45TteTsvMDUf0Bv0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=QuFSvd2YE2Pgwol7hIqC0c3WvtO6aPiBoc0SaUNZUu0yN0OclaLakxnlFN64Qm8bX
	 t9/su+0hRX1ZthUT6T+UklmdFAX0NZ2uhCV2wfUJTM021pXePFZLVR2wrhquATpBfn
	 l3sxungS6rlXpS78Muq+ykUpSMJ49SB0Nbm7kEddEcRV2JXaBPAWSnGuRGktOx/mR1
	 fcpN9fG5a4L0/Fv/wE0JUEoqP1OgEbeP8Qd4MPdCMPN3H1cM4ihFwilZlwy3vOByiU
	 T1RCFuc6ncvO+I3ogqh9CnF0yQD7/Z0bfJySrST4ZrzGVt/6Cbru9j61TtiE+fOD/j
	 SShtAaaDIFhZkdBHKW0VgMd+UEZfAWHl+Dur+o00MvCL4CX1kb0cAU255tDTXaATd2
	 2Qyd7OFS1m4o4gnOdpZGHuj9DuZOr6mt+CoCTX6neFq4TuPhqkAI4JfX98t3cnAv0M
	 Gike3JPbO8022GHr+PtAbG4kyojvxtfb+hWiKwGr3BqgwLX+/xc
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 936E32010E;
	Tue, 15 Apr 2025 22:32:51 +0000 (UTC)
Date: Tue, 15 Apr 2025 22:32:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net, piotrsiupa@gmail.com
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
Message-ID: <Z_7ekhsBzXK6LKuV@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
	git@vger.kernel.org, peff@peff.net, piotrsiupa@gmail.com
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
 <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R+SX+yGGkNRHOB+x"
Content-Disposition: inline
In-Reply-To: <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--R+SX+yGGkNRHOB+x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-12 at 17:40:51, K Jayatheerth wrote:
> +test_expect_success 'recreate files to test add behavior' '
> +    mkdir testdir &&
> +    >testdir/f\* &&
> +    >testdir/f\*\* &&

I just want to point out that creating files with asterisks may not be
possible on Windows due to limitations in the file system.  I'm not a
Windows expert, so unfortunately I can't provide more details than that,
but you may end up needing to add a prerequisite here to skip this on
our Windows platforms if necessary.  Hopefully CI and a suitable search
can help you figure it out.

> +test_done
> \ No newline at end of file

We do want to keep newlines at the end of a file.  POSIX mandates one on
text files and some systems are less tolerant of missing newlines than
others.  Usually Linux and the BSDs handle this just fine, but some
proprietary Unix systems, which unfortunately we don't have CI for, tend
to be the ones that are less happy about this.

I haven't given this a full review, since others have done that instead,
but just pointed out one or two things that got my attention.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--R+SX+yGGkNRHOB+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmf+3pIJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZzZ7JzDP0MXWg3KZ4auH2Ujjv6IOy6s/OuE+1WHf/ncm
FiEECCzmip28ZfuD0cORfAxJYoiHooEAABScAQDBHpQphxUuQHTeYz6zziFNjOGG
e4bN9j3b+SOZZ20hoQEA+Zq3SUk+QyaK/q6yrvTl0f8ESt9Ewa433Wn90eSoQQk=
=QeIA
-----END PGP SIGNATURE-----

--R+SX+yGGkNRHOB+x--
