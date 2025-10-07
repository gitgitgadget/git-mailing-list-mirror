Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47562494D8
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876941; cv=none; b=K6BTfBmZyTbRUK6tA1eDlNoU1fGDGz3Ah6njX9LFbwDBFVXkncoyxUWfJxeo+ebJEtYSgKah47ratYvfwMj+SkSS6KoBKMUCfeftJZ0V93xgVNVM5qWPHc0LzBUNjRd6RIwzcAd/mIUXTlCHQN0IKJ1hjUtGGt5f0zTdDh72zAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876941; c=relaxed/simple;
	bh=8ay7g7GJprZ2pF3jTj05HPGYttHDIObOJ3+23p93OIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bcd/5oVi0F7rMRlhL2x4z+fwhEVJIVPvhJ1wa26zfUS+qWIW7HRxkDDtG3rp+7fS4wKvyUIwT3ygrxLwuJFZBZdz+Dv5mfbgcFS/+VkbpnPAP4+KXJdLXbSdtegMdAdFa35pc/OKSmpJm01lMt6AkifQgC0YooCFy+3/M8RsmZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=VRop8S3U; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VRop8S3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759876937;
	bh=8ay7g7GJprZ2pF3jTj05HPGYttHDIObOJ3+23p93OIo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=VRop8S3UaBTQ5dTT/XVML7KBOmLnVIlPBOKxyc07/qU7al04pzdCOnrpoPDYNqK0u
	 JHqz31orn+k0tW5ZwtT2/0ErB0GIe8KmX0NgrE+fmAOBOUcGS3hME/V6IlASVwcAO+
	 9Zwip2PWkkDjRLXILgudWpOQlG4D7KsKLZQmKfHf+mvB/qhqzGfYt/ZpViB8ac7a6H
	 HrG24PqIbdJdDqzicE/NBZgr6FKaXQMElmyruV6jfN8KQirnaKAsusU9NXHc34IPBg
	 rHxLu8tbK1TkeZTl/PlYZQI51fQTss1gj+CtEGllk3rR+OMES57TOX2ssRr2WKtcTv
	 6Zk2CkrV/ejyoUAkjpWgRKLbw+cGcGoCef0kceo/bnpjesBH0BmVae5wK/SA/tTG2H
	 WWDaF7vd+FijgjqcgRIvJWp6A7Wbm1/b8dDZ+1TSgIu6kkJm/k8U4GwuVzUkAriHHt
	 2fThP2uIEyFQjaP54Z+4CSPc54YVL7Qb0MZVyJGf51ARjbYozGQ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:225c:7da:a6d4:350c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6C42A200C6;
	Tue,  7 Oct 2025 22:42:17 +0000 (UTC)
Date: Tue, 7 Oct 2025 22:42:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Sunshine <ericsunshine@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
Message-ID: <aOWXSO5GInJI8-NZ@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
 <CAPig+cQ7xJky+F=g=NMrN6BQfP+ZV2KF4RF2eLqtULKgMTR5_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TdVzmXpE6PIrM69V"
Content-Disposition: inline
In-Reply-To: <CAPig+cQ7xJky+F=g=NMrN6BQfP+ZV2KF4RF2eLqtULKgMTR5_g@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--TdVzmXpE6PIrM69V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-07 at 17:13:18, Eric Sunshine wrote:
> Later in the same thread, I wrote[2]:
>=20
>     Project guidelines have long suggested 80 columns as a desirable
>     maximum not only for C code, but for pretty much all other
>     resources, including shell code, Perl code, and documentation
>     files. This suggested maximum works well for adherents of
>     80-columns and (presumably) hasn't been too onerous for developers
>     who use wider windows; at least we haven't heard people clamoring
>     to increase the suggested maximum column limit. As such, it does
>     not seem far-fetched to expect that the project guidelines
>     should/could/would also apply to Rust code.

My preference is actually that we stick with the default.  I use (and
for a long time have used) a 132-character editor window and I find it
quite useful to have the extra space.  The DEC VT100 did 132 columns
(available on your local Linux system as `vt100-w`), so I think there's
plenty of precedent for that being an acceptable width[0].

I did previously use 80-column terminals when I had a tiny laptop
screen, but modern display resolutions over the past decade, even on
smaller laptops, have made it entirely possible to get several wider
terminal windows (or in my case, tmux panes) on one screen.  One of my
current tmux panes is now 213=C3=9754 and I really enjoy the extra space.

The default Rust behaviour is 100 characters[1], which I think is a fine
default.  I won't be enormously angsty if we say we still absolutely
must stick to 80-character lines, but I also think we should take this
opportunity to choose the Rust defaults for Rust.  C, Perl, and text
formats like AsciiDoc do not have rigid defaults about indentation
style, tabs vs. spaces, and line length; Rust does.  We wouldn't use
tabs in Rust (the default is four spaces) because we use it everywhere
else, so I think we should take the opportunity to use the Rust defaults
here as well.

Whatever we ultimately decide, I plan to send an update to our
`.editorconfig` file.  I think that's less useful in general for Rust,
where we have an automatic tidy tool and CI to check for it, but there
are some people for whom it will be useful and we might as well keep it
correct.

[0] For what it's worth, Linus also thinks longer lines and 132-column
terminals are useful.  I don't agree with him about everything,
certainly, but I think we see eye to eye here:
https://lkml.org/lkml/2020/5/29/1038.
[1] % rustfmt --print-config=3Ddefault /dev/stdout | grep '^max_width'
max_width =3D 100
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--TdVzmXpE6PIrM69V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaOWXRwAKCRB8DEliiIei
gY93AQCvLIq5L1ebpLO9d01FmPuVypXBfV0yVbcsG6spJUa6RQD+IRgyeeY2Er2L
1xwHERN52gNn6p3Xon8pk5b7G2GikAk=
=4MXx
-----END PGP SIGNATURE-----

--TdVzmXpE6PIrM69V--
