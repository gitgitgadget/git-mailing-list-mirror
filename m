Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6D9313272
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857694; cv=none; b=asw1+wfPtx3RgozRc5+OYlGkKuGZQ2H/Zy+8nUSDtRYcEU1/jC0dYHIWYZvT7C1yTOC2q99pEAYzvGmh0e4GVtNEsVm5l0zlDZBbRkp8wxYt1VEndwcKtLkm9HJs8gCvgFU85GH2DHpYGcghFoUZb1xSLVCt+9YVuZano383DEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857694; c=relaxed/simple;
	bh=WwmOTan0yrUoyRqx7mCe/56yHlyfhkERsrlPM2d6oFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFvcRpTIHcCi2ioU+5J40KvX4d76RPufFhabisTNIK/WfJpD4vjIulSx3bePTAlPnbcUUSCspxjFpjO2XiDwr3kfhmuRlfKG7YP2r1O/xKLvpiug9/1OIS380zELq22K3EuseAXBkzgE9Fb7V/LvZ8Jm1EZg+qC5Xs2crp6TRQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XKjkV58o; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XKjkV58o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775857691;
	bh=WwmOTan0yrUoyRqx7mCe/56yHlyfhkERsrlPM2d6oFY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=XKjkV58oMLfU4xZq3xtiAuReb3Sfk26B8NpBjPgKuBt+/g6YxyUtqVX2wAVctDAmb
	 S9xRG0cS4PXBGyZLEC0TV3IA0DliIHOuQ3iFyyYUCVPW/eX9bRBEoiTbzOK/bOtsWG
	 eiNIRq9UI3PjWq2eDFchvsCo+mrgsXgU0ecBytNfUL/WaUt2cOeHqbwGDr1ezhovnu
	 5MzQ2PCTwji9+yI8gsnMVOkOO5arCWgwa+0k/QlSMGKINrepfRPP4VwTfsmhrgyLDG
	 b2vIu5U+p6tYZW+rTFpWgPc0bBprf+/7+AXe02/1G1d4kFUQyWM/neO3AXFwTU0F6W
	 aemaklGQ6rbPYXcDLm3ImO927pqWTYTDtRWFPZ/XrpBjscuBraSD32iZB2ubV2U4go
	 RhOrKiDTdR4AHE075ZcqQQVeFiI0J8aH3s0nZ+iXN9cC2flkYwqPR/o3mIyVk4HSgq
	 mBvR3EMKtVrwJNcYT+kM447cuYede+9OUizfKuHuqFctAYD+Efi
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:690:ed17:613c:3cb7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2F49220039;
	Fri, 10 Apr 2026 21:48:11 +0000 (UTC)
Date: Fri, 10 Apr 2026 21:48:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 0/4] Enable Rust by default
Message-ID: <adlwGv8LPdfwP8Yv@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
 <4efc4133-3726-4b9d-8f06-03c07d48af99@gmail.com>
 <adlXscAv57Xd7p01@fruit.crustytoothpaste.net>
 <xmqq4ilio6wp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sZVgnsykj7+rf5Mi"
Content-Disposition: inline
In-Reply-To: <xmqq4ilio6wp.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--sZVgnsykj7+rf5Mi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-10 at 21:13:42, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > This was actually sent out just before rc0, but Patrick requested some
> > changes in v1.  (I forgot to thread it to the previous version,
> > unfortunately.)
>=20
> Proudly saying "It was sent before rc0", as if that gave community
> plenty of time to adjust, is not something I was expecting to hear.
>=20
> "This is expected to be a big impact change, so I am sending it
> before -rc0 of this cycle, so that it can be in the first batch that
> graduates to 'master' for the next cycle" would have been a lot more
> understandable, though.

This change was announced on the list and in the documentation, so its
appearance should not be a surprise.

I didn't realize that I was sending it directly before -rc0 because I'm
not usually very attuned to the timeframe in between releases, to be
honest.  I usually send patches as my schedule allows and I try to fix
anything I've broken relatively quickly and even faster in the -rc
period, and I generally let you decide how and when to merge them.

In this particular case, I merely remembered that it was something we
committed to because I actually was looking at the BreakingChanges
document for other reasons, so I sent a patch as soon as possible.  That
just happened to be right before -rc0.  Had I remembered earlier, I
would of course have sent the patch earlier.  It appears, however, that
we all had a memory lapse in this case and I do apologize for my part in
that.

I don't have a strong opinion here and if you prefer, we can defer to
2.55.  I agree that would be less risky at this point in the release
cycle and, of course, you are the maintainer.

I have been operating under the assumption that Git 3.0 is destined for
September 2026 based on the discussions we had at the September 2024
Contributors' Summit in Berlin where we said 1=E2=80=932 years, as well as =
other
discussions on the list, and that is the message I have been
communicating to other people and projects[0].  I am fully aware that
that date might slip due to various reasons[1], but I do very much want
to get as many things set up as possible so people can test and there
will be fewer surprises, which was of course the reason for sending in
this series.  I imagine, for instance, that Debian might ship a
WITH_BREAKING_CHANGES version in experimental for testing to find all
the exciting things that will break (of which I am aware of quite a
few).  (I will suggest that to them shortly.)

[0] This is true in both my personal and professional roles.
[1] Although I am unable to be more specific, let us just say that I am
endeavouring to do everything I can such that the date does not slip for
any reasons within my control.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--sZVgnsykj7+rf5Mi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnZcBkJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZwSrrOQ3CX1h5ojKS9jfuMQL/1h9+nZ0fqp+F+ikg7QD
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAFVcAP4mDWzs2i+V/r5ioUrgBv8aZfMj
Q/FowuDRd1vd2onmRAEA3jZ0qHH4quv2lEQWL885IiXUpn3poL1DNkXgTUlxewA=
=RESM
-----END PGP SIGNATURE-----

--sZVgnsykj7+rf5Mi--
