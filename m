Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821BEAE7
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ckn7VX5i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJ2oDLKi"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 546AB5C012B;
	Mon, 15 Jan 2024 05:03:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jan 2024 05:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705313022; x=1705399422; bh=Io8XldKp4S
	UUWFX4VVvVQY5RNtj7LrD8o5PgM99/R9E=; b=Ckn7VX5igCOYb2xCtw+UljUjx5
	bxz21tBF5x9bjhCaAVONJ24syXGHi/lPiGJcqwtTL+FryrVB1ZqU+h2uqv7Wgu4s
	mv6XawV+mxV7BPlrYYnAWYY6dbDANip7WV2H1T+Gq2xmJ6eJOzTmaJiz3EuB6AOP
	Hxi/6hI32OpSqOFXVUr2nerCX81CrZUApHmtC+1acrMllWuJ9tAX5RvoTa9AeXQ3
	H6FikjIieimyP90ee+SmHdDILbql+PSWuKyJBpiWabWSapoVPxAlofFFAS9XSNXb
	Bn0WTgXgovmQDJfgnGOeddLJ2igyF5Ar3R3lmaaTE17B9vhDzay1fbC8BUcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705313022; x=1705399422; bh=Io8XldKp4SUUWFX4VVvVQY5RNtj7
	LrD8o5PgM99/R9E=; b=dJ2oDLKiD72IF+B1the+jg9nxYho9/PT9pK54ODA41ck
	AMB666Dpv4s2PbeGf1oIG5ngS93MNr5cCGcf9g50w6VlI540VS5L4R+cNZ+MfKT0
	bATmYA7nWwDrAsFz37bGbHiX7LUCSZt66aoAtd8QqX0LKMrU2RKrGwEPcJ1Ycasa
	x+/0e1VAA74EfsOQ3GbdmaWKWCOXxlcujS0gE6hvEp9+GXLGByD0D40NOabdt2Yv
	jlmE0h0PQa7UYCNnlbyt/hOZaFzqOavuFTvtbqm/kJObYRhydy8ZgFSRP5lDGPJT
	NteFKWs9WvUh3U//6xYc7BRjXUHppbB/gN9AWYhFtA==
X-ME-Sender: <xms:_gKlZRrZuk2XGKOdeUOgTlvs2_-PnxzKjNtJMOxHg_okt78KcHsRgw>
    <xme:_gKlZTroie_bL_bwmGQ-DWE99EkIg9EDVGKSULOQtZ8KSlnnNhJ-VCXDvYKvK6SW3
    ij0yOBsWJKcJkVSwQ>
X-ME-Received: <xmr:_gKlZeNUND2edELcUNZWzjUMgN-dSplweroMP-OMW2bIl7uUrqKRHpYubkWXPSW2Bn2k8lVlXN8w89qRbaeG-vvbKUQaFgjBdy3l8H-eVH-cZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_gKlZc6Cs3OkbPV4qJciseM2eRS1f8mN74PSsvJGYujRgFT1ooKpVQ>
    <xmx:_gKlZQ6KHwEEP9V1az7x3l1OGXfeMwZrBHnscwZN2sXKCeH-RGjSYg>
    <xmx:_gKlZUj4RLq_LcT8pj7b_VHJHvMR0UYjHsc1gw6FDhRuIacSW_gkkA>
    <xmx:_gKlZQGLoB7saOC430jDP7dt92BXtCXfdVL7ZlbFwOxp0pIyDpXn9A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 05:03:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fa6a9ba9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jan 2024 10:00:49 +0000 (UTC)
Date: Mon, 15 Jan 2024 11:03:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] reftable/stack: refactor reloading to use file
 descriptor
Message-ID: <ZaUC-WevQqOj31u9@tanuki>
References: <cover.1704714575.git.ps@pks.im>
 <cover.1704966670.git.ps@pks.im>
 <36b9f6b6240686cc5b0a761b889614fc31f01d34.1704966670.git.ps@pks.im>
 <20240114101424.GA1196682@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FMO/6R7AV8YL1C8P"
Content-Disposition: inline
In-Reply-To: <20240114101424.GA1196682@coredump.intra.peff.net>


--FMO/6R7AV8YL1C8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 05:14:24AM -0500, Jeff King wrote:
> On Thu, Jan 11, 2024 at 11:06:43AM +0100, Patrick Steinhardt wrote:
>=20
> > We're about to introduce a stat(3P)-based caching mechanism to reload
> > the list of stacks only when it has changed. In order to avoid race
> > conditions this requires us to have a file descriptor available that we
> > can use to call fstat(3P) on.
> >=20
> > Prepare for this by converting the code to use `fd_read_lines()` so that
> > we have the file descriptor readily available.
>=20
> Coverity noted a case with this series where we might feed a negative
> value to fstat(). I'm not sure if it's a bug or not.
>=20
> The issue is that here:
>=20
> > @@ -329,9 +330,19 @@ static int reftable_stack_reload_maybe_reuse(struc=
t reftable_stack *st,
> >  		if (tries > 3 && tv_cmp(&now, &deadline) >=3D 0)
> >  			goto out;
> > =20
> > -		err =3D read_lines(st->list_file, &names);
> > -		if (err < 0)
> > -			goto out;
> > +		fd =3D open(st->list_file, O_RDONLY);
> > +		if (fd < 0) {
> > +			if (errno !=3D ENOENT) {
> > +				err =3D REFTABLE_IO_ERROR;
> > +				goto out;
> > +			}
> > +
> > +			names =3D reftable_calloc(sizeof(char *));
> > +		} else {
> > +			err =3D fd_read_lines(fd, &names);
> > +			if (err < 0)
> > +				goto out;
> > +		}
>=20
> ...we might end up with fd as "-1" after calling open() on the list
> file. For most errors we'll jump to "out", which makes sense. But if we
> get ENOENT, we keep going with an empty file-list, which makes sense.
>=20
> But we then do other stuff with "fd". I think this case is OK:
>=20
> > @@ -356,12 +367,16 @@ static int reftable_stack_reload_maybe_reuse(stru=
ct reftable_stack *st,
> >  		names =3D NULL;
> >  		free_names(names_after);
> >  		names_after =3D NULL;
> > +		close(fd);
> > +		fd =3D -1;
>=20
> We only get here if reftable_stack_reload_once() returned an error,
> which it won't do since we feed it a blank set of names (and anyway,
> close(-1) is a harmless noop).
>=20
> But if we actually get to the end of the function, it's more
> questionable. As of this patch, it's OK:
>=20
> >  		delay =3D delay + (delay * rand()) / RAND_MAX + 1;
> >  		sleep_millisec(delay);
> >  	}
> > =20
> >  out:
> > +	if (fd >=3D 0)
> > +		close(fd);
> >  	free_names(names);
> >  	free_names(names_after);
> >  	return err;
>=20
> But in the next patch we have this hunk:
>=20
> > @@ -374,7 +375,11 @@ static int reftable_stack_reload_maybe_reuse(struc=
t reftable_stack *st,
> >                 sleep_millisec(delay);
> >         }
> >=20
> > +       stat_validity_update(&st->list_validity, fd);
> > +
> >  out:
> > +       if (err)
> > +               stat_validity_clear(&st->list_validity);
> >         if (fd >=3D 0)
> >                 close(fd);
> >         free_names(names);
>=20
> which means we'll feed a negative value to stat_validity_update(). I
> think this may be OK, because I'd imagine the only sensible thing to do
> is call stat_validity_clear() instead. And using a negative fd means
> fstat() will fail, which will cause stat_validity_update() to clear the
> validity struct anyway. But I thought it was worth double-checking.

Good catch, and thanks a lot for double-checking. I was briefly
wondering whether this behaviour is actually specified by POSIX. In any
case, fstat(3P) explicitly documents `EBADF` as:

  The fildes argument is not a valid file descriptor.

That makes me think that this code is indeed POSIX-compliant, as
implementations are expected to handle invalid file descriptors via this
error code.

So overall this works as intended, even though I would not consider it
to be the cleanest way to handle this. Unless you or others think that
this should be refactored I'll leave it as-is for now though.

Patrick

--FMO/6R7AV8YL1C8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWlAvgACgkQVbJhu7ck
PpTcew//Rmrm4PDebrfvils2Of3gvR9yhjTkdiZwBquyrnmuev4NJN5JjgHpHtKx
EkASmF1wKUq6M6yjBBBg6jx8DDtophXWUZPaQj0SRJt6Ir86NAbX2SVyWwX3OGs/
NDswyfv1uYxVEgOGatbXpFUuMVcdPKggBzNI3nlqu6JfFStGA9sU6s6Tu8A4LMww
R+SBBN4uL0WvmIfv8wC4HPSNcc4d6h0EeiHmqe5M7DlJU+syfoAQ9DCutHzmUSpH
04Vi36Sxck62btydiaSeeJiDLXB17e9mUrpijKV7yt49XNczY5fP8Y5HpM7qMaE0
gmWoO99jW23m+MwuoY4fuFRcBs8a6cyfeurI2enaMf+Ws3XwTD1vrC0LyOt/1YZ8
dy9tlVDSJZpE3m4QA76havhltwe17YsDbT5ifXImjJJswMhpGVxxGUGrtFIwd1LV
e+gL29P2iWkM7zuRgVuEJM4nHovmiHAUj1XYx71RyhYSvwIWFIS72UecJ8xNG3M8
AwKCn3ZoCAU3P220IvOg6ByMtTC8A1n2tgc9PxfNZmt3Qz98CEOdcrOmdeq9y0E0
yaIleTEdrBtg9BxFramCN/gNIkhT7bdf7wzRBbwBW8uRtGtGUbX8O6C/3E5q+5c1
+K1bMRDxDIjpoOxVuAMA23VBIcPOgTyU03eoUTzLbyzbzngFhJA=
=fEBI
-----END PGP SIGNATURE-----

--FMO/6R7AV8YL1C8P--
