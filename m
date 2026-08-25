Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B9944063D
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694254; cv=none; b=RnWlsLM3TBx3cHNXKjNfumuk2JN5b7wmfzwM/sDiZvc1OgoqWlQcAsBYhGqwWRNtqe/sXWglH7rqWVCkmAkGx1IiMuuhmnZyAlLKeVsXqRbOjAB4m+shcxPgMJ5oE3g2FjsGopeST2gyK7q75QrYb4fOUCh3T6UqHBWrf6gGWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694254; c=relaxed/simple;
	bh=ttAta7CC6r9GCzxXEdnQD49nuNqyvVC833q2y2At/AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDVyJQ/+y4l6iQkMQPJhCzq5KaPcinbatKNvxVcBQlSRYLunducuxuVq8kchNfhjtpDzOmflAQ+PynSzRzZiw5jKRLsUDG7ZNlHumfsgTtA5+NvqJqWv2oIPiWGi1c4hlf3b1gOayFlfp+MQP24zLfA8Sv54ihOgXcBjX6Sagrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NcxF3T0T; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NcxF3T0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1787694252;
	bh=ttAta7CC6r9GCzxXEdnQD49nuNqyvVC833q2y2At/AE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=NcxF3T0TGLR8yMEKjfIK965ho1zIkvap7e6q1abaiky9kp7CajYO6Wm4lnGCpYUuz
	 riKzumerYZoitML13WnP7Ce3S4/pJTEHl2UZoja4i8KzsmweGulGZuZv9I8FTvpE/O
	 41+UBQr+43klPq2JmpVL3CKYLqliDWmruXv7B64ACqydz5tePBq1rdx9Sjd7aVhsTl
	 0byY9mCu/wnoFCtLp/IAF/G0on/+v2DTXANHDYEbLC3ntYUfiGmmG2+fhXjKyFzlF4
	 wqQs1UVZgafDDk9evPR9rlUwKsR6QLSCGxLt7DGyQ3qlCtpaCcwHUmyTq4WxBAVSci
	 bSFULMUe9OG64bJ3/JglxC6LidiXfxwKCjQLTTpgo/MGntEjGQG9EeC2b/gFsL9iAx
	 Sv+sdgw/GY3aT+ESglRXSkt44nFXkSCqMX6aYcfDAjO0h5GbaO1r/9nj8A0uSwBKzK
	 +tV9uzCh7Zo8yIyL7wv2ac95r7UvsS5B17JxwoDhQj80wyzxUGL
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:23b3:441d:199e:9561])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 36ADA20101;
	Tue, 25 Aug 2026 21:44:12 +0000 (UTC)
Date: Tue, 25 Aug 2026 21:44:11 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] hex: add functionality for lowercase-only hex
Message-ID: <ao4MqtDxZJaMEBBI@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260729233215.398654-2-sandals@crustytoothpaste.net>
 <xmqq5x0yp5ts.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8Dq/LkQkujsRTtp3"
Content-Disposition: inline
In-Reply-To: <xmqq5x0yp5ts.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--8Dq/LkQkujsRTtp3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-25 at 15:39:43, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > We currently allow both upper and lower case for all hex values in Git.
> > However, in a future commit, we'll want to change that to allow only
> > lowercase values in some cases.  To prepare for that case, provide a
> > table to convert hex values using lowercase only and an enum to let us
> > choose which we want, wiring it up to the hexval function.
> >
> > For now, keep things completely the same by specifying only the
> > variant that accepts both lowercase and uppercase to avoid changing
> > behavior.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  color.c    |  2 +-
> >  hex-ll.c   | 37 ++++++++++++++++++++++++++++++++++++-
> >  hex-ll.h   | 14 ++++++++++----
> >  pkt-line.c |  8 ++++----
> >  4 files changed, 51 insertions(+), 10 deletions(-)
>=20
>=20
> Now this is an embarrassingly late review.  I hope this is not a
> sign that nobody is paying attention on the list these days X-<.
>=20
> > +const signed char hexval_lc_table[256] =3D {
> > +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
> > +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
> > +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
> > +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 18-1f */
> > +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 20-27 */
> > +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 28-2f */
> > +	  0,  1,  2,  3,  4,  5,  6,  7,		/* 30-37 */
> > +	  8,  9, -1, -1, -1, -1, -1, -1,		/* 38-3f */
> > +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 40-47 */
> > +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 48-4f */
> > +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 50-57 */
> > +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 58-5f */
> > +	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 60-67 */
> > +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 68-67 */
>=20
> That's 68-6f if I am not mistaken ;-).

So it is.  Will fix in v2.

I think I accidentally included the uppercase but not lowercase variants
when creating the original array and then copied and pasted the line,
but messed up the comment.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--8Dq/LkQkujsRTtp3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqODKsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZxcHBWVFUdLd3BqeqH5JHgK5vPCg31hNLLDPO9BRyC2G
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOTuAP9Car1uFCM9f1lzTOI/xRnxxk0C
RvSK5R0sav8I2fBmBwEArkd3WutdcrTgqfUYxrLyC2pbwlr7j5NrVvtny9R8/Ac=
=qc2w
-----END PGP SIGNATURE-----

--8Dq/LkQkujsRTtp3--
