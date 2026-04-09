Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069E248886
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775694037; cv=none; b=AWZ0hvgRDQYXV4ONTHjr9DQFRb7vk1kipyaurPU4OlTcYKA21kRdHaH8nb2hLYjW30ysqEVdBD4msnTdBHwAJmQlikkzdRdBkXHL8L+5vil4shwU5kFi6r3ww/vuSPYxYm21OYhDeIGqt0ooVJCNJJvwh7t3O5bQt02mPb8Su1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775694037; c=relaxed/simple;
	bh=8V49ftfMz1U8EpmhbMpv8R0C6aJy0daktiTFqY0N3ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R46CT7bjeFEnoMMombr3FdDOFTOEZUgGuHtrx5KYFIzvx7s5BWIYC9XGJIhYVW52vCf61xsQNUmFH8OcguYe9d0kAF/QubdfvAUYsc8I+WfauD3bz6T9OBnQmw3sXTwUixO7LY5PYiShOgCzfkXdJQAZiDex1uKOf8gGi1conis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=otrHCJ/e; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="otrHCJ/e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775694028;
	bh=8V49ftfMz1U8EpmhbMpv8R0C6aJy0daktiTFqY0N3ec=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=otrHCJ/eCP7DZZ6bScAkSyCt7DaYEVJbXvn1GWlopqqpzhePyOMSznmZx14RErhtQ
	 GZwKKCAmryxHlAxriMgIDkDBq+Eb3YCm8i97VhL2Zq2dCFcbgW90Ak5Va3juhsw3hk
	 uE5QZ0CT6fehWdsLH6Ih1J8TcYn0wq4F/apiwsQR+4aNBPgyJ1wwTQriN/ZJYu/vrR
	 gz0Autqg5Wszvj7WsJoD7728paiMtS03jXWb8NaQ+3G+MNs5NOg1Ci+6wpfQhehQah
	 Jz8aa8A+S5LcMXDgZ/lXn0XGY8axLJRCrAo76MfPuzBcuPv2KTsr8Q1g/S4f5LyeqD
	 7t/cWXUwryuZcsHL312HCh0xpkCk2GK5++KZHdJuAlhkeVeoeB8d55MgfoipaVJmQs
	 6pRiWi5Jr6G5JVAhAHtsEeT2TiVF4ELT+xiUN+SVp0uK2TbdjDJk+5GdTw3B2zwwXE
	 sdAeUaJ0cok2+Lcb443I5lOFRgB6ZPw8f3+dYnu/gyrhTTnRcVI
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:6885:c74d:cabb:df61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1E38820143;
	Thu,  9 Apr 2026 00:20:28 +0000 (UTC)
Date: Thu, 9 Apr 2026 00:20:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Message-ID: <adbwyvQ-R2Ag1vox@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	rsbecker@nexbridge.com, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20260408041716.GA1324339@coredump.intra.peff.net>
 <011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
 <013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
 <20260408173949.GB2850002@coredump.intra.peff.net>
 <xmqq4illz5g9.fsf@gitster.g>
 <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
 <xmqqqzopxkxa.fsf@gitster.g>
 <016b01dcc79e$87472860$95d57920$@nexbridge.com>
 <xmqqcy09xh53.fsf@gitster.g>
 <20260408223233.GB2873736@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KqjIElnIc8V4JHfk"
Content-Disposition: inline
In-Reply-To: <20260408223233.GB2873736@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--KqjIElnIc8V4JHfk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-08 at 22:32:33, Jeff King wrote:
> I think writev() is buying us something when it works (it is hlving the
> number of writes for sideband packets). And it works when either:
>=20
>   1. the platform is OK with writing up to 64k in a single writev()
>=20
>   2. the platform has a limit that is small (like NonStop here), but
>      writes less than MAX_IO_SIZE work and will save a write() call
>=20
> If we just care about (1), then the right solution is to declare that
> writev() isn't fully functional for us on some platforms, and they
> should build with NO_WRITEV. And we should probably embed that in
> config.mak.uname.

Looking at POSIX, there doesn't seem to be any constraints on the size
of individual vectors other than that they must total to less than
SSIZE_MAX.  iovcnt can be limited to 16, but I don't think we're hitting
that here.  POSIX does say that SSIZE_MAX does not need to exceed 32767,
which may be what's going on here, although that does seem like an
unreasonable value for a real system.  Linux, FreeBSD, and NetBSD all
set SSIZE_MAX to either INT_MAX or LONG_MAX.

I also think that 64 KiB is more than reasonable in terms of the size
that people should be able to send.  I'd personally expect to be able to
send values much larger, at least 512 KiB, and I have code that expects
even larger (16 MiB).

So I'd simply say that for systems that have a constraint on the size
that is "too small", they should just use NO_WRITEV.

However, I don't have a strong opinion on this and if people want to do
the proposal for option 2, that's fine with me.

I will say that we may find ourselves in a pickle with Rust code in the
future if we use `write_vectored` since that will probably just use the
OS implementation, but we can worry about that when we get there.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--KqjIElnIc8V4JHfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnW8MkJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZw/3e4nc0EBjokKwjuOXHpThELINCHkRoHI5xNZI5Vk0
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAAgTAQD26fZl04mQHlJMghB6oOzOpBNL
kJvewcPH0MQdHSfNYAEAxNuIALARhuIcC7MZ1HT1y16noHrCVHKpxQ0j5vfjXQE=
=0SJq
-----END PGP SIGNATURE-----

--KqjIElnIc8V4JHfk--
