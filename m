Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F4107B0
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LGuEuq1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sf4mYfWP"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 7B314320025E;
	Thu, 28 Dec 2023 15:11:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 28 Dec 2023 15:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703794294; x=1703880694; bh=6dX85sKtMv
	dY6L5APK0AfTo3W+71BbUrlEyGd4/7JyQ=; b=LGuEuq1uVrSPGKQpqs6TJ6ozhE
	YvSU8ETQ4GerXNdNCzrPrLOQ45TGkTT3yLTBVVT5v2c5MfNiY2aVdfSixVrgZ3nr
	eeAT0Mbi/zIoy0j5I6C1w1y4Tz7NeMs+UlhyXBtv+pz2cW6n2n+rjGnLIzaZ5iFz
	MSFVxFrDZijGStS24JeCGPxX0NX4J+gXvqAuxvtAGKWPAIatHXSpzTMpf6C3uXeu
	GUNhQUMurYNJ1KaZ/eaaAa+EQzRD1qLZDh3c6f3rccxZ8z5Dd6YbWjpRXXGPCOSH
	aQo2mn/t7FdZuW/2HkZvG3YfdyEhlzBLnbGg/21LL8Qrce2bBd2vQSPKw7ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703794294; x=1703880694; bh=6dX85sKtMvdY6L5APK0AfTo3W+71
	BbUrlEyGd4/7JyQ=; b=Sf4mYfWPzVMS+JaCu9Kdhj6up4L+5jsa/sMlmiaP8yNm
	cut8QQ1/Dck5Onor6CPiaZcL15/PGNfpYbWl7qH7Pm499Me/B6N3gphpgUqClUae
	7m3Om/Y8WJnSBNzzxHpFdZmzeNzPaf4rU42dpYyv/D8fXo54S9OTERsNkr2tDF3b
	VGwQ/fqlyqGpDAYxH1U388voMMT0ucnlt3HMS87MDZZwU60pg3asfgf4UhwK3NJs
	fBeJSqEOF1dweWrwlytF4VLErC0upUFVS2DVjcaVNpSb7noomVpEyE2yQtI/+iv3
	8mRJqjQIo6+tDQUP4837MWQ2MrFjVPbYoytsLWTnSw==
X-ME-Sender: <xms:dtaNZdrKQjdzQ-jkZjcLcB0_iOcVpALHYndATJwbJbVwoe_ftTkczg>
    <xme:dtaNZfpWnt78wfG6wO_XGWv50qoVzKnBZwd4Bp0Pxz8Z616JJXNd8zGpTbyStYl63
    zi_zZDe5jJ36zlH7w>
X-ME-Received: <xmr:dtaNZaP8Z_0NL0IGK3RhkOpGmjBeWoAqDM3E_JEYJl1IvxNUB74asSWUDVL_qgRxLxy6Ef_Ijbq-FcuqXOCRz16gvcSCvbowGagjWrx_MQHL0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:dtaNZY5vaNfDXGltt5KON8X1_SL3dZkTvQvggqRfyWeMiMgTt2uuKA>
    <xmx:dtaNZc7X3MKnM-BBqb9awyn-6UkhjcW3zSf5E3zVKjQWmzVVlHdtog>
    <xmx:dtaNZQiTuXjI2cg8-g5w-d9C7QZ5-55aVBrLsL438yUKQn-Z5SwMZA>
    <xmx:dtaNZaSenA6WyG_6nrCdEsVhOnQGTl3-STiy-DkDicvwH51oLGJVeg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 15:11:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 47bb0be8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 20:09:17 +0000 (UTC)
Date: Thu, 28 Dec 2023 21:11:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 03/12] refs: refactor logic to look up storage backends
Message-ID: <ZY3Wcua6dtzO2jG4@framework>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
 <12329b99b753f79fe93fe017e71b08227d213c1e.1703753910.git.ps@pks.im>
 <xmqqjzoygrx8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BzV/LSTOUlMLW411"
Content-Disposition: inline
In-Reply-To: <xmqqjzoygrx8.fsf@gitster.g>


--BzV/LSTOUlMLW411
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 09:25:55AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > In order to look up ref storage backends, we're currently using a linked
> > list of backends, where each backend is expected to set up its `next`
> > pointer to the next ref storage backend. This is kind of a weird setup
> > as backends need to be aware of other backends without much of a reason.
> >
> > Refactor the code so that the array of backends is centrally defined in
> > "refs.c", where each backend is now identified by an integer constant.
> > Expose functions to translate from those integer constants to the name
> > and vice versa, which will be required by subsequent patches.
>=20
> A small question.  Does this have to be "int", or is "unsigned" (or
> even an enum, rewrittenfrom the "REF_STORAGE_FORMAT_*" family of CPP
> macro constants) good enough?  I am only wondering what happens when
> you clal find_ref_storage_backend() with a negative index.

No, it does not have to be an `int`, and handling a negative index would
be a bug. I tried to stick to what we have with `GIT_HASH_UNKNOWN`,
`GIT_HASH_SHA1` etc, which is exactly similar in spirit. Whether it's
the perfect way to handle this... probably not. Without the context I
would've used an `enum`, but instead I opted for consistency.

> For that matter, how REF_STORAGE_FORMAT_UNKNOWN (whose value is 0)
> is handled by the function also gets curious.  The caller may have
> to find that the backend hasn't been specified by receiving an
> element in the refs_backends[] array that corresponds to it, but the
> error behaviour of this function is also to return NULL, so it has
> to be prepared to handle both cases?

Yeah, we do not really discern those two cases for now and instead just
return `NULL` both for any unknown ref storage format. All callers know
to handle `NULL`, but the error handling will only report a generic
"unknown" backend error.

The easiest way to discern those cases would be to `BUG()` when being
passed an invalid ref storage format smaller than 0 or larger than the
number of known backends. Because ultimately it is just that, a bug that
shouldn't ever occur.

Not sure whether this is worth a reroll?

Patrick

> > +static const struct ref_storage_be *refs_backends[] =3D {
> > +	[REF_STORAGE_FORMAT_FILES] =3D &refs_be_files,
> > +};
> > ...
> > +static const struct ref_storage_be *find_ref_storage_backend(int ref_s=
torage_format)
> >  {
> > +	if (ref_storage_format < ARRAY_SIZE(refs_backends))
> > +		return refs_backends[ref_storage_format];
> >  	return NULL;
> >  }

--BzV/LSTOUlMLW411
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWN1nEACgkQVbJhu7ck
PpSmVw//RMc4IHSnIwRhVmhKXDcrbMsEi3Y/kR+/SPxeEPkrY1R4geTxrHM/EnYd
TlvSCa3Zqb9huQjtNlE3ncTBFbSDCh5+VY+JVsiZrRvsLfZOIYhRQN7+gO2oV0+D
PQfD67+8WRpz3eu/zqT23m+i8giARH4ImLgcOhWaG8GPIe4dEB8OlgDwsHaXpVZf
9N5xEkx0F5+l4RMpRL+Us2+I6pLCRGKcnHDSrYIScg+Q3iEqomODHClYnOcTlURb
0nOHm2px085hk4krg9AOx4J22q5+vKq7X5X/6sjsuCGUlO6tp13yei6sRZ8VYu4k
SnbZoKQKg5XShuvr6nr3yUesKy16xW3QMfM54HAQQz/k+90rMK5x8+QbxhDsR2WH
Y+6yCnyv7EyJs3lmdYA+B8ZGAyePUkfImitwbabhEmcaV8C9yYVfuFuhCZhI58qq
7NUe5EsuU0sL64Ov6Ii06x4f0BRfD3sLXAm1KOHRn+OmhQ9Kzfbbr5zhgHTeJTtC
5z3aVKBUOL+Ff0LNPmliBh0Ec0CdHi+OQHhpbznai4xD1mPtTttNBZjkAYe5ysJs
qkt9yF1hKD4PUMuE/eNGtmclmITgr11AMLDxLKd+6St/ADUtmiP3Mb8LGsxXIV+g
hr4pLiiOKx1vydf01s6gu6kgqb23H7/8INX1X/aSbrAqrFIfyck=
=bigS
-----END PGP SIGNATURE-----

--BzV/LSTOUlMLW411--
