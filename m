Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349314402
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dirqOoMN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BS91+l2k"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id BE67C3200A71;
	Thu, 28 Dec 2023 00:54:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 28 Dec 2023 00:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703742843; x=1703829243; bh=VSdmPHGdpY
	pzArKoscMIihURFU4A0Fp/3v10Olxgbqk=; b=dirqOoMNGpQHGK201sIW29Pb/T
	DW55ixJ8W80/PMROmKUr2lEeJdBiIBSnU5gRLTBHxBLKXm6xVeplzw/EJ/qJQkWM
	5MOaKP9ClGP/AwQjFM326/Z/HZ9+qy9I0TA2HGGh9L0avcjOb5QvVzynF10gGzNW
	HD++CMBhm1uff9VxBTFTo1wjPDZqguorwhIZDNo6e252ZfJt6LqpZvT7KTEk41OP
	DYM/h3cuWAlGDHnNN1D3ZY/qmNZvId/DtC4/vfuz+fywhoDevAUL4cI63/vJ5Joo
	bWUvmaRajosLEOCU2BlGAzX6aV+vkl3SKaXAg7u4RaZOIYPmHWZLvF0eK5Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703742843; x=1703829243; bh=VSdmPHGdpYpzArKoscMIihURFU4A
	0Fp/3v10Olxgbqk=; b=BS91+l2kAHNPnPmR61cn2yc8y23YTD1m1oz+FlaGSAdB
	S5QMa2UDcbx0VwfuzXvAkWkxVgiuA9K0TBd+6xu0RC493pHY/RDWJRXuBsjbWeSk
	7R4PRmpbXTtupo08w/rD/0WoUGJzL1xkuCMfc/K+ED8F2VWStcso7/2XNR4OB2U4
	vvFFSGdc7c19LOSEQ7OfyMFrM4CERlrkewnYGEMD8G1kq0PkjsxuJqy1auWORZKl
	zS2aABvSstsn9CyukCKBk3khw3FOcAAbF/FTxoQrpzbhkeTfOCIKjGB9y0Zrg4UW
	OJ3cUcpenJRgv7kcluSSyJzyaThTEM4z/YIVHRIDkA==
X-ME-Sender: <xms:ew2NZYol5VsHK39Z4gMpDMR4GOB7A8gJ8c8asdyY_Dnlb3elzBsiTQ>
    <xme:ew2NZeoTeY8UWayCwQrWaCzVTbFB94g9vN1a_ExeXA_AvZUc7sdio2C_CnFhpBHia
    6M_rsFVeUe8zYeg5A>
X-ME-Received: <xmr:ew2NZdMOih1rsHc5ZsJbgiLc1oRW-8u3S3NG2EAvVys_8UJHO27PlMpaetxKSfOsR1eaKyy7F3XOQyOQHLqutAOLoNwgA10dyFjlfEU1kLE6ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptefgkedthedvkeejtedttdehgeefheehtefgudetheduudefkefgtdfggeejgedt
    necuffhomhgrihhnpehpuhgslhhitgdqihhnsghogidrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ew2NZf5NgYasF4ZdD7j_WKVG0CsW4wH9v5d2IrzxKt7iYzE0dfWKIg>
    <xmx:ew2NZX4tjNedS8mHdZ6fYEWYgFCDANeTCZiHlGDjBBZi7i1VaCEuIA>
    <xmx:ew2NZfgunWzXgTGeof3ST8OTjt0wq0-NZ_i6a8HBFonlgnsMJ2pl_g>
    <xmx:ew2NZRTbKMnPyWl1mgbG1mCe1cRepkovFbn5FgOrWdJnEir6CEV58Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 00:54:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf1c17c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 05:51:47 +0000 (UTC)
Date: Thu, 28 Dec 2023 06:53:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 11/11] reftable/block: reuse buffer to compute record
 keys
Message-ID: <ZY0Ndkv2v7TXVskc@tanuki>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
 <02b11f3a80608ba8748a0d0e2294f432e02464e5.1702047081.git.ps@pks.im>
 <CAOw_e7bQ+jxO2zhj32mDksq9uBKQfNt=wMNP5K6Oy1DqievCdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E+gMiRw54j1JMbHe"
Content-Disposition: inline
In-Reply-To: <CAOw_e7bQ+jxO2zhj32mDksq9uBKQfNt=wMNP5K6Oy1DqievCdg@mail.gmail.com>


--E+gMiRw54j1JMbHe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:43:27AM +0100, Han-Wen Nienhuys wrote:
> On Fri, Dec 8, 2023 at 3:53=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>=20
> > @@ -84,10 +84,12 @@ struct block_iter {
> >
> >         /* key for last entry we read. */
> >         struct strbuf last_key;
> > +       struct strbuf key;
> >  };
>=20
> it's slightly more efficient, but the new field has no essential
> meaning. If I encountered this code with the change you make here, I
> would probably refactor it in the opposite direction to increase code
> clarity.
>=20
> I suspect that the gains are too small to be measurable, but if you
> are after small efficiency gains, you can have
> reftable_record_decode() consume the key to avoid copying overhead in
> record.c.

Fair enough. I've done a better job for these kinds of refactorings for
the reftable library in my second patch series [1] by including some
benchmarks via Valgrind. This should result in less handwavy and
actually measurable/significant performance improvements.

Patrick

[1]: https://public-inbox.org/git/xmqqr0jgsn9g.fsf@gitster.g/T/#t

--E+gMiRw54j1JMbHe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNDW0ACgkQVbJhu7ck
PpTfGg//ajytLrgLdxuWO2e5vn5GhaOVRzIggAV2B8uUR4R4I2G9GfIM0J1ScK3A
kdW5zGbI9TZWa0bf9TZ+4gRCYxLNO+eBe48Y87aO9uIsfuzEyePbkvYPOjV59YRx
+Thx4YK/0KOeq13t3WW+PsKlSZfOWIJU+xPo12MfAHhO2a9sgcsjIUuMZneMHJ6/
AOWriUV6HKexsVFOjVqg+Sc+C0fuqS1StYQajgxawLRFDBDzTqhAdXWdevFGdUA1
N7DtPuSN34VU1v7IyqnJ57FEV1XldREMWWU2xGdZ6LMThgqHfc5e5BJdRZGO4iSq
XDA3Oitz1gTFa7okRpYpvZD3fbrlM2slZ/RIC5lqIWY5DcGNclhk4/hchva0/t1Z
rKG0v1luHMMl8q1Z6dai8VxExoc5c7SyUCzLEN1dUCfRPKPKdJd2oXVphLi/EDVW
qeq7nXIKZEr4Jtw6YgKR9r/1ull3xYo/QY7os45MzLfHgo/SqjbsSksHG5v39X4w
qqF2S8Ycy4hx1A0Lb13Yum+emLqHJ1Gg1iQNDu28U1MtqLz96v/agWj1qP35oGb8
A8eRclJLgSUsNf3cp+Xl2gN+U+f4m6KnqkRJRsuMHOz3mBf3Mf/ulSdjbANPkn9U
NrDaySCxoI4CeT2Omzhm/PdYen2tsLVrW01LPBCGVbhfls9OT28=
=/n6C
-----END PGP SIGNATURE-----

--E+gMiRw54j1JMbHe--
