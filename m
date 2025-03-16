Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD710A1F
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742169131; cv=none; b=kwXFDMsrGIgzUAup5YpCSlzLPi8Suzbkw/eIRbBsHf4jpYU/RSV2tbcY8EQeYzyHEFRku6+EbNnnZGS/Uqdk9ngEpPSm0bDRBggJ/V9Q2hjOOgPqd/0mAy0CBxSVqE+tZ4PoLEJYhHqryoP0K01W7gqLZ8BJMvtflm/p5ikuTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742169131; c=relaxed/simple;
	bh=zoiy1I9ZIESaYoG7hCT56156O8cjNtJLkx9rJ/gD8qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afagv69LUxnrD1OrWGS9clSJpL4XXC176WJFlXLYlSB53FxS6BKERHaGYkZDO7gA+eCHj/ELZ4z5EtsTVBWfUR//JfuoxTEpi3ZnBsdeoyzweK4mMccEMcZ5NmOGHFvRAFP6z25M3pQ//0651Y3IwjGbWtHy5Vi697Ia+ZxQcNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=N4bv5z8l; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="N4bv5z8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1742169127;
	bh=zoiy1I9ZIESaYoG7hCT56156O8cjNtJLkx9rJ/gD8qo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=N4bv5z8lG8EuWOC/ATMocKRc5mk0CgMZjIQ43sjvS+g+gENEb95d0rC3kjvm0ypsF
	 gs0ODWlW2pAakYZIVibEicS5h2gYm0IGvaFL6VFCVhITHpMR5GagC+1mdSIwghXhk6
	 n4J1eChfwUPKy831NyITVhA3HbhSKa7kcB8EhxYPJUwIpvAmIm6pFPaQzTTNImAn5f
	 v11avnBhlEj9F2KdpGYuHG9gqHibWWZiA/M2j+2/MN/U9TcD305xfLZkOvoc5bzLwk
	 JK1/vuVAUNpat1ov51iK4hdQLehtmEPs+h8nvJ5x+2QFGHHHhLOUyeuEa9zSiC7D/C
	 nib1yUuvXU3PVLlnNmYH01A1Z1sAvxDkQuW1wVHFNyfHcVvkZAaFs2Z2qRINSrTGr8
	 NOaNihgRRIByj3YPv+1wqiTSWfCpX0RhUoaiKSqQVb+Ch3ADBZ4wbhyjm8Q0L2Zltt
	 ugV8AP3kYQgXpE+DIoV7lmdhkc1/Nls+RP/VoVZGnTY8cKY/0t7
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 49ADA200B7;
	Sun, 16 Mar 2025 23:52:07 +0000 (UTC)
Date: Sun, 16 Mar 2025 23:52:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Patrick Steinhardt <ps@pks.im>, Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH 12/12] config.mak.uname: add a note about CSPRNG_METHOD
 for Linux
Message-ID: <Z9dkJb-HOIQmsEqs@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Patrick Steinhardt <ps@pks.im>, Adam Dinwoodie <git@dinwoodie.org>
References: <8c8e16ae-87a2-44bf-a87b-7422eb04fec2@ramsayjones.plus.com>
 <Z9YbJFJjtXNYnTzk@tapette.crustytoothpaste.net>
 <654de230-07cb-4ffe-bfc4-ca0e1d6d3572@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QidtjR9nx087DF+Q"
Content-Disposition: inline
In-Reply-To: <654de230-07cb-4ffe-bfc4-ca0e1d6d3572@ramsayjones.plus.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--QidtjR9nx087DF+Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-16 at 21:51:45, Ramsay Jones wrote:
> Ah, OK, thanks! While researching this I was only concerned about when
> On cygwin, the arc4random_buf() implementation seems to have been imported
> from OpenBSD, and uses a chacha_encrypt_bytes() function call during the
> process of creating the random bytes (see newlib/libc/stdlib/arc4random.c
> in the cygwin repo [0]). Also, the getrandom() and getentropy() functions
> are simple wrappers around an RtlGenRandom() call (see winsup/cygwin/libc=
/\
> getentropy.cc in [0]).

Yeah, that's similar to what I'd expect to see on the BSDs, except that
`getrandom` or `getentropy` is the actual system call.

> The glibc implementation of arc4random_buf() (see [1]), as you say, is ju=
st
> a simple wrapper around the Linux 'getrandom syscall'. In addition, we can
> also confirm that getrandom() (see [2]) and getentropy() (see [3]) are al=
so
> simple wrappers around the 'getrandom syscall'. However, I don't see the
> 'extra function call' you refer to above. (Yes, all the layers of macros =
does
> obscure things somewhat, but I don't see that extra function call).

There's a call to `__getrandom_nocancel` in a loop, which I believe is the
function wrapping the system call.  It's probably inlined, so it's not
that big a deal, though.

> As you say, arc4random() is less available on Linux, so getrandom() makes
> for a better default.
>=20
> Anyway, I guess that means the meson build needs to be modified, since it
> currently selects arc4random() on Linux (this is OK on cygwin, see above).

It's not the end of the world if the meson build system automatically
prefers `arc4random` over `getrandom`.  That's a sensible default in the
general case, and I believe that the use case is generating temporary
files, which will always incur the cost of a context switch and a disk
access, so in general the performance difference would be negligible
anyway.  It's not a hot path, since nobody expects us to write millions
of loose objects, pack files, or other temporary files in the typical
case.

I _do_ think that if we're specifying a default in `config.mak` on
Linux, `getrandom` is the right choice, and I think we can probably just
hard-code that now and let people override it if they're using a system
older than our supported environments that needs `/dev/urandom`.

POSIX 1003.1-2024 specifies `getentropy`, so my guess is that we'll see
that on more and more systems as we go on, and the other choices will be
less and less necessary, but we're not there yet.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--QidtjR9nx087DF+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ9dkJQAKCRB8DEliiIei
gVhjAP95grKEoE2iAsL5ViGRTG4xr0X0VnkGFuZ3Xq4t3G8kyQEAtjVnyRICLU9f
oh1cbsRH6k4fh5e2b6tpWB177AuocQM=
=PkWU
-----END PGP SIGNATURE-----

--QidtjR9nx087DF+Q--
