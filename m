Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58FE1F938
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782693042; cv=none; b=TJnPkLxfO+syFDvxnT9kSgVBV0rWw69T7I1Mt+XxMzhv6hgUaUee4nFQ3YIMdjDoO2p0bCFNpLbAvnoiRk9ofp1MejK2yNgwLCCO0aqoaSwppen5IV30x7d/UVEJ356KxWJrBPZBPbygbSBDw+nGDwww7Rubzi9TkUJa6EPxfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782693042; c=relaxed/simple;
	bh=OfxtSDSho7aiGgQWWF8wmm/FTUw4KjfuFcAFsFQPZZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBIBQJfUb3GgHW9tmkfX9iIhH8HYanEkKqWaLoG4JrFUt7IltvppBvoTWDoNVteESuQJm5bbxwpIeO0NkBLvlFgxuLXFza96R3HlkPCJ3vjCD/5a+UsG0X/+g/rf7RRqatNtXnYDkwk6HxY4IcZ9C23/Aco/zQfzCtobyIk5YH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=EEY27PX2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EEY27PX2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1782692609;
	bh=OfxtSDSho7aiGgQWWF8wmm/FTUw4KjfuFcAFsFQPZZA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=EEY27PX2iDqUeYOmHJeEo/KYQM3fYIrQ5B6zt2rRa4aK93oxplV9D9DpwtKd1HoBw
	 4SRyofT9kN8np+ROHqYvAgYoOYFyxfX5ZZgx/yXAIglMgUUYeVZnlPLXyk2QKHjsrM
	 rbh10F7p3IFYBbi6WYoL4oL9rrbAU/ELyDK8+7nM4U81gF+00i+aLJgPGbda1yvcVE
	 e/GyvEW8+CtUvwchjnrP70Jenmhx2jKX3M+4aKsPojHU6Z+IffUCZ7NctDekSA+s4K
	 j/9lRPX4Dt72dpwxohe5MsFBHXa+PD/4j/nFV8xyTIwQ7kpincYX3YCVkl2+jfkVSf
	 z9YgxGQdI7pi3r2IyfHBShUUHBP5OKPWMTwTsRjHiAKalJrWH604RXEqcjKXOUHe+Z
	 IMVxNaohp0/9D7DjISUES8RuWiwK6AOu7NsaZpLWlr2SzhMlUz5Vh0CHkmYRDttj80
	 STZd+H+HbZ+y99FNx/AmfHCrnFh7iG7aOMiSZisxuPYhhUL+T5D
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:555a:46ce:5f47:1487])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A51D8200BB;
	Mon, 29 Jun 2026 00:23:29 +0000 (UTC)
Date: Mon, 29 Jun 2026 00:23:28 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
Message-ID: <akG7AJxeiWc8KUYN@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <20260621174934.GC2206349@coredump.intra.peff.net>
 <ajjuoS5Qc3K0nCRl@pks.im>
 <20260628081806.GA3594700@coredump.intra.peff.net>
 <20260628084815.GA111587@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3zvKzDmdUSAgtE3a"
Content-Disposition: inline
In-Reply-To: <20260628084815.GA111587@coredump.intra.peff.net>
User-Agent: Mutt/2.3.2 (2026-04-26)


--3zvKzDmdUSAgtE3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-06-28 at 08:48:15, Jeff King wrote:
> Oh, I also ran across this old thread:
>=20
>   https://public-inbox.org/git/5605D88A.20104%40gmail.com/
>=20
> that implies similar:
>=20
>   * In-core file times may not be properly rounded to on-disk
>     precision, causing spurious file time changes when the cache is
>     refreshed from disk. This was fixed for typical Unix file systems
>     in kernel 2.6.11. The fix for CEPH, CIFS, NTFS, UFS and FUSE will
>     be in kernel 4.3. There's no fix for FAT-based file systems yet.
>=20
> I also tested with CIFS on my system and it is fine. It looks like FAT
> systems were fixed since 2015. ;)
>=20
> But there is another interesting question raised there, which is how
> different implementations may interact (e.g., two versions of Git
> without and without USE_NSEC, or JGit which may have to use
> millisecond-resolution APIs, etc). It should all work correctly as long
> as each implementation consistently uses its own resolution (so JGit
> would have to compare in millisecond-space and treat ties as racy). And
> I think that is _probably_ what is happening now, since we already store
> nanoseconds unconditionally (and only use them with USE_NSEC).
>=20
> Though the opposite case is a performance problem but not a correctness
> one: if JGit writes out an index with milliseconds and USE_NSEC Git
> tries to read it, we will consider everything stat-dirty and re-read the
> contents.
>=20
> I don't know if these would be a problem in practice or not, but it's an
> interesting potential gotcha. And one that nobody may have noticed,
> because probably hardly anybody bothers to build with USE_NSEC now.

I would suggest that we provide a config knob and then build with
USE_NSEC by default.  Most people are using Linux with typical Unix file
systems, NTFS, CIFS, or FUSE (e.g., sshfs).  In the event someone
detects a problem, there's an easy solution=E2=80=94adjust the knob=E2=80=
=94and we can
then add a Linux-specific statfs call to determine if the file system is
a safe one in a future version.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--3zvKzDmdUSAgtE3a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpBuv8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4E8oqzMR9Uay/5kWGe1syvsu1ON9Q9Z0xydjBOO2qWS
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAAFoAQCFJHjIn0Qb0GcYFeEyH8ZAqBBB
OpfrnWj+7+5O9od99AEArUvLfhxyMS95zp0qa/c6AH57CDIjNvHrVSZykBCmNQE=
=VFEW
-----END PGP SIGNATURE-----

--3zvKzDmdUSAgtE3a--
