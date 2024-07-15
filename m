Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F841CA9E
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721079972; cv=none; b=IWM4CMNqScGqh6YZMOvZMUsBHXqgeB5xFNciHiEahNu7dWQRAzj9zE7BW3yRlEP+zwVnuyVlEVAocn0MYDM/70uwgxa9tBTWIELozWs4UsGcRKh9zSqD/EepgiAAxkVJL58RxKioA/zvd3I0k9DHpA2Gf2uP7omklQ9QiQt9fTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721079972; c=relaxed/simple;
	bh=/ZxF2AVFMaf9VhTFU5mL9wDY0pTKUzciWaWRgMwh84A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOuQXK9T5wO5LJ0SyrK8yo572ULd1ywV8vSkNxxLIuiThAoYPe00Lwm+1JgYDXpBWYeklHMvLXyze1tkocP2R1VtgSovwU3nt4+sVZUB6uvy9Nl5hjGjUtYN/ob+YiUXvOxXkt1u4RpbplPRRjYPW/7hpX8CpNUYc7XcArj8MQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qz004y+s; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qz004y+s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1721079962;
	bh=/ZxF2AVFMaf9VhTFU5mL9wDY0pTKUzciWaWRgMwh84A=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qz004y+s1RlWnG2NP8C3Rcibs+35wxKZz0RyMI/FWgKICsJLVEkY+G5FCbT0utZbi
	 w6L8L2W89WihT5XxR+KhxSKT0eCtf3yCYLrfA0MY4sRzMlZ48EYvb+MLufg2HWI/no
	 Zf6XULaYDIez2AEJLorP6RvRf1b5Ynk9booP4NpaZMB8jfm84KVfUO5LYgtr5+eM9L
	 cvLrfK83UCcH4amvCQ1gz9nuUhqwPLc6XXoX78yf7wblni65aCPIvA7xFRO/bKcFpN
	 gONhVPUR/fVUwXeK3GEsmP0CYUHYZ+8QaZP6bW54QVbDofmk3SZC1XA0JmfsB++QRO
	 zCusUHmIG8ruy6dbHCMTRuq5lYUws6uTvZYmpvIAw9tIWOduFW6Fi1akKSuwcUBecw
	 9YgNMOUMYtm8wzboramyuPbN/szhVuIIuUVSMgqaVQhju92r5WC4ZsIJycsoFHZPla
	 TTaItwgaIrbBlqVSSPxbvVrBGjf2T+BvVg0NdeVYkHhTRbfkpFn
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C74EA20991;
	Mon, 15 Jul 2024 21:46:02 +0000 (UTC)
Date: Mon, 15 Jul 2024 21:46:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Scott Moser <scott.moser@chainguard.dev>, git@vger.kernel.org
Subject: Re: Can dependency on /bin/sh be removed?
Message-ID: <ZpWYmZwcfZMeKpfe@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Moser <scott.moser@chainguard.dev>, git@vger.kernel.org
References: <CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
 <xmqq8qy21k9f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H/adcVY4lBYXxjiv"
Content-Disposition: inline
In-Reply-To: <xmqq8qy21k9f.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--H/adcVY4lBYXxjiv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-15 at 20:18:52, Junio C Hamano wrote:
> Having said that, I do not think you can avoid /bin/sh if your goal
> is "minimal image *to run git*", as there are many things we run,
> starting from the editor and the pager and end-user hooks.  The
> credential helper is probably the least of your problems.  What's a
> minimum /bin/dash image cost these days?

Debian provides busybox-static, a statically linked, multi-call busybox
binary including sh, other POSIX utilities, and quite a lot of other
features, all in a 1.9 MiB binary.  If you don't need, say, httpd or
dpkg emulation, you can build a much more stripped down version for less
disk usage.  Alpine Linux is based off of busybox (dynamically linked at
808 KiB), so we can assume that that configuration works just fine.

We know that Git for Windows also ships a configuration using busybox
successfully (although with a much larger size).

I am very interested to know what kind of restricted environment needs
Git (especially with a credential helper) but doesn't ship with a POSIX
sh.  I suppose a restricted Windows environment could qualify.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--H/adcVY4lBYXxjiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZpWYmAAKCRB8DEliiIei
gfBSAQCC8ygXv8ZJn0qU3WFlLa8Q9z0AmCa5y8neXpxfiPjpwgEA/W5NapZu/0tl
Vgfxas1W4LklwuTeTN7PjwlPB6SQNQ0=
=Eq/7
-----END PGP SIGNATURE-----

--H/adcVY4lBYXxjiv--
