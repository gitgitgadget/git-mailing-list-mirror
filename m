Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795558765;
	b=Q+KVRBU5GzKI4ZNgzIDJ5lSIOnS2tbB6eWnmdp/1rWIo9zPpSfOkMei+F25kDcLCZRTu
	 TDTFPtXlu029/uXNz5HC4IdLEGNJLutTGs7rydFAtgvpzzYPMhX3YwX+otTkPSJPHPrW1
	 hrCS4ti4js1WWfYG4YeFVDkv3EvcXm/lgEmhwcCz1ouXjOrmlF/xBYoaeu9AXId3CnCV2
	 Jk53DOH37Mg5oa5uNRs/28pNGMEtM0fRDuE9zOzu+IkqK02j2C5zQ+yRyB+yuNMNhXw3u
	 zxuZ3TYfxVgz1nlBpO2aGMK5iOHeVJNtf+XN80JhMsV/IScy/xKVZvWZorcyIJAxUQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795558765;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=+a1JxxdkjEjjJnnjTCCyxiBrh/LJP4una4Mvbs8QF2s=;
	b=yA3oysKQcOtDV9Rz5ul9l1BJ9QJemDKg3WReOmREO9HKmEyVnwCphIgmyIRWqO1IYHRT
	 YhES+5BVmcGUvxXMIpMu2xVCIEJAvJOn3dytHymXei/PrY4MVXAlSfXsqQpO3YfuIF8zv
	 bA+GBCPIfdshkUBUyiBO9MmQ7iJ4aaTMOJiZYqgJZdGlN37Q6v4ohQzQREohesNI1Q1Rr
	 APBR22gv6RCddFbkjmkC5sQ/JHnL4/TCe0IytAgX6VnUm9faftmQvCsezZoLpeGMJab9e
	 dJ7tlToqXPD+aQwI/YDVawTbwSgx2FuTc1CauIT6WJ0OKvcpAH23lUBg03pqzpMEchw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=bFxSfiD3;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54C9606BA30
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A54C9606BA30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=bFxSfiD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1795558758;
	bh=Eoh0bjpalicnfpWHQ2O0+/RhbeNTD1/N842O7oj3u9Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bFxSfiD3JPKuF9j3bt4facQNvM44DSpsIOiP4GQfbCH2ycTjc434Gkbs/bYJjrVSF
	 5d5EdS1kpqi8Ea5b76Unw+nfnsjSol3xdTvbYa6ByW1tyMm+fWEr8PhHD0+i2AASQb
	 fnTlBWpZq4wipdhgYqyoLTuOU1SeojwT8TlRLBoqUt/JE5soXwR0acsv0RmgAuzwlB
	 4dxnYyjE9vyoLb8t14W0OQB32cge8o0+eIbVHnFEF3cs/l9UUk+NPfxLM+jKCp2sCK
	 zBpdyvH+GTo15RpW603asttBVv7GomC+ztMjaT67sXLVjU81K4fbf2Z/y2cBlisH89
	 Cug5mNP8PvbQEAFUjO/aqtn+GVWzW8rKPn0LLhmk51cnwJsgHqB5I/QRPU4dFtHi6s
	 7JyHz+6r1Oc2C481L/Lto1SUM7xQTnyeaDbOy1iXy5HVE/Fi9xod4kycZGMsnRdyNL
	 jrK3QQVjlGSYarrtKPWR9nyiwloF5vkTbwABkxESjlyUYF6C52y
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:52b3:5d58:319:ece6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1889E200B1;
	Tue, 24 Nov 2026 22:19:18 +0000 (UTC)
Date: Tue, 24 Nov 2026 22:19:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] builtin/fast-import: stop reporting packfile
 statistics
Message-ID: <awYNZF7ORvwI00-4@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
 <20261120-pks-packfile-global-statistics-v1-1-19beb83b145f@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FqBvoPFqicEBwBsy"
Content-Disposition: inline
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-1-19beb83b145f@pks.im>
User-Agent: Mutt/2.4.1 (2026-07-04)

--FqBvoPFqicEBwBsy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-20 at 12:02:28, Patrick Steinhardt wrote:
> By default, git-fast-import(1) prints a bunch of statistics about all
> kinds of internal details of Git. This includes for example how many
> objects have been allocated, the number of refs processed, or the amount
> of memory that was allocated.
>=20
> Reporting this kind information is highly questionable, doubly so as it
> is done by default, as a user really shoudln't have to worry about such
> internal implementation details. For some of the above metrics it could
> be argued though that it's indeed interesting to learn about the number
> of objects processed to get a rough sense of what git-fast-import(1) has
> done. But for other kind of information that's not the case, as it is
> without a doubt purely internal implementation details.
>=20
> One of these reported implementation details is our packfile statistics.
> These include information on the system's page size, the number of packs
> that were opened, the number of calls to mmap(3) and how many pack
> windows were created. Reporting that kind of information, and that even
> by default, is just completely uncalled for. This information may be
> useful to a developer, but a user really shouldn't have to care about
> any of this.
>=20
> More importantly though, with pluggable object databases we shouldn't
> assume that we're using packfiles in the first place anymore. The
> current implementation of git-fast-import(1) still does, but we will
> convert it to use transactions sooner rather than later.
>=20
> Let's just unceremoniously drop reporting packfile information to the
> user. If anyone complains (which I highly doubt), then we may consider
> reintroducing this as trace2 data. The same is arguably true for many of
> the other reported statistics. But for now I care about the packfile
> subsystem, only, and hence those are left as-is.

I would definitely say that in a future series, I'd like to see this
disabled by default altogether.  My particular use case is that I have
some tests which convert repositories from SHA-1 to SHA-256 and I care
about errors if any should happen, so I do care about standard error.
However, I don't care about the stats, so I need to be careful to pass
`--quiet` or my testsuite output will just be one giant stream of
fast-import junk.

I think this would be more in line with the Unix philosophy of saying
nothing on success, and `--stats` exists for those who do want those
details.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--FqBvoPFqicEBwBsy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmsGDWQJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ0pnCxnSh+ddNmcaO1X7BqpobdoGxQIdcqUWSPBDahCs
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAB7TAQCU0Wfcz3FZigwufO5UNh+HYoLC
jUpB6pCb6sJBGLtNUAD/ZwgWqRX8VIxh2tjJh4Hc3/5tOG9SiU1ZBGAdZWg/+wE=
=K7Zk
-----END PGP SIGNATURE-----

--FqBvoPFqicEBwBsy--
