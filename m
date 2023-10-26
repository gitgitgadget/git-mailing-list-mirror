Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4DE256C
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="x8FhRiaq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ku49wPZx"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBE4B8
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 01:16:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id D500332009EA;
	Thu, 26 Oct 2023 04:16:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 26 Oct 2023 04:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698308172; x=1698394572; bh=R0
	C0bLbRXtU0RGrOOsc5GMdfDJ/yyf50un/XiWU5ZC4=; b=x8FhRiaqvsDP60OgSn
	sC14b0CQ8qHQmcsmRzDQd0z3NxIJR75C0i7O3H6KtB7mAjNOylR4NDgLUxRV+KE/
	11SohBpgHsSoR/+9D7TDVwNEuNzmSs/XrBN63JmjCJWGFOvSJETqQN0OtxUlqpVY
	7bn35DmEGEEF+TXYuDbKUXs+WDltV1NRkOuuS86mHFQMsPWrDM4B2r47UuyBYJ8L
	6HXFCaShvEP6QpRxLKcMXNfRkGCUtE/3sQ+IsPCs8+sI4pcdB23Hj7TDFz6ewT5q
	grNiAli9+O5Lx2aiZw8VbDCfeKQVQkZZ5UXvqXbOnFYDsg9O4bsY5TjjoDjAQA9n
	1hBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698308172; x=1698394572; bh=R0C0bLbRXtU0R
	GrOOsc5GMdfDJ/yyf50un/XiWU5ZC4=; b=ku49wPZxQy0k2OCoOr+0YfskvZjJB
	eq7lX+nHRBe8gahNUc4O4fCWyaVURqsl9s3A0xiNSGSnxc8INo1PCh4KLDYRHRGe
	iGJs3mPdlOZdsqfvkaY+zaN5JyRqY5dr/NuoMmhaSf9LcweBcQlUCyWEv3mxE3yA
	Le2voZY9E6Tei7/MZuL1aNhVJxDBm7hE4DOoYvundWSJSSCpAzLxLbi/AvfSiw08
	1pGnkAHOCNhl6KiPt0pP811PdXnZ1s+42A93coJj7s3zzh6mMfGGsHbAq1C13lZF
	xHNFpRfk5XBF5XL8C1Yv/pzc5xWuiioC3c+7ptrLXq4HfdF+i+CaSEGoQ==
X-ME-Sender: <xms:TCA6ZSuCyWP8fNqys3xsGX30dOJlrqrGB9wcz4Z1yNGoIt4fn2jh_A>
    <xme:TCA6ZXcqWRlm3_QoIMLaMkvGZzDK0nHioEAQDYE69JL4wOy9jiveHkr3bvpLaAZ-H
    cxF1-DTNkdMTzKWlA>
X-ME-Received: <xmr:TCA6ZdxWMjaB0hBrj79CT1obI6GsoZ-IVnoOzZIaF5kEmVgYgcVU8cMiiE2VogBq4046Y3GFydN6axD-fZQyyeSia_uAUVtOD1-4jM7yMu4qb1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:TCA6ZdMPLG0qL59GFRrCGjwIgR31R255WSz0c2zYibINHLzuiE53tw>
    <xmx:TCA6ZS8Twt7cnrhtNnG-c5pZitJcA5qdKiESVk5E2G7JME1NOiO5Vw>
    <xmx:TCA6ZVUBGSjOpFOjMv74XOsDPyNwL2a7ms0rO3TIiLm8uBj4vWe5Yg>
    <xmx:TCA6ZZnoCUqiULvJobgtCuPbfwYRajDGDhoGPw4LFzUhHxbdAGoHZQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 04:16:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a5e44912 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 08:16:00 +0000 (UTC)
Date: Thu, 26 Oct 2023 10:16:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/5] bulk-checkin: introduce
 `index_blob_bulk_checkin_incore()`
Message-ID: <ZTogPThYhQbSQ-NI@tanuki>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <d8cf8e4395375f88fe4e1ade2b79a3be6ce5fb12.1698101088.git.me@ttaylorr.com>
 <ZTjKjkRMkmCuxDU1@tanuki>
 <ZTk3zoncT6nvV3aQ@nand.local>
 <CAPig+cTjQe6FWo98LxvDS=s3dOs33SUUJa=x-bkyWHNBMx+XFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h8eLT472T7Q+e109"
Content-Disposition: inline
In-Reply-To: <CAPig+cTjQe6FWo98LxvDS=s3dOs33SUUJa=x-bkyWHNBMx+XFw@mail.gmail.com>


--h8eLT472T7Q+e109
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 01:21:50PM -0400, Eric Sunshine wrote:
> On Wed, Oct 25, 2023 at 11:44=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wr=
ote:
> > On Wed, Oct 25, 2023 at 09:58:06AM +0200, Patrick Steinhardt wrote:
> > > On Mon, Oct 23, 2023 at 06:45:01PM -0400, Taylor Blau wrote:
> > > > In order to support streaming from a location in memory, we must
> > > > implement a new kind of bulk_checkin_source that does just that. Th=
ese
> > > > implementation in spread out across:
> > >
> > > Nit: the commit message is a bit off here. Probably not worth a reroll
> > > though.
> >
> > Your eyes are definitely mine, because I'm not seeing where the commit
> > message is off! But hopefully since you already don't think it's worth a
> > reroll, and I'm not even sure what the issue is that we can just leave
> > it ;-).
>=20
> Perhaps:
>=20
>     s/implementation in/implementations are/

Yeah, that's what I referred to. Sorry for not pointing it out
explicitly :)

In any case, as stated before: I don't think any of my comments warrant
a reroll, and overall this patch series looks good to me.

Patrick

--h8eLT472T7Q+e109
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6IEYACgkQVbJhu7ck
PpQ/cxAAlfrQiPkr0CPrZep1cuzR20x+CiimbKIHpc7NQ0Gbs12F+XYnSgWk09N9
hjmCZtAszr4UbEG1a1FRks1AMCyG2d7h8DptwakWvr9WfP3BZPnMnWtxVMah2LOY
1yeuKubG5O94Hr33my/TfPX3IHDcKu/Cc9B3Z2WQb2dHphWxIT3oiLGidKHITi1+
ZLpC2FXQCvRHiVGtN0b2OnQS/SGKWFlL90wxqGzXMXPhlmkocPX3IGhasEWK8tLx
loEiPapDbpFEncMbTafdrJw48rd+zHvRViU/mwo4FrsuNWBonD0R7skOrhBx3+sB
6byT4F8jMqVVk5JvQr4Gsw3rrRq8ZzDVWcFyrWKThAdp0MkGx1B4E/WykXIEXq5G
wydZ1fxmTHD7Boub3hlV9/Dr42gajk8Bm1bt3eMgxSPzFUOCGjutmKBIpc5N1PpY
XTfdRqzAJO9H06Eu19kvmV3aUqoHS91LnDsHf5m3E6y9fWiSSc3ilUVD153i800x
BtejaQglnEjQRylMWXRejOedak8WvsN0GN3PGUqeQ1uoLSLTa43VD5WVqe6oV7OD
3e217eeHYfs247/WTjJgoAZd8en6Uuz6OBwSTlSlfCDkj56za1OTWOMcIlNsFZtB
x6RC+BWxuw0INVBe0fJC6J6i1wNe97c5db4Ku+N3xlCJPTYjw+Y=
=jY0I
-----END PGP SIGNATURE-----

--h8eLT472T7Q+e109--
