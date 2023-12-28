Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1445687
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w8AYTsDL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4Wx66dwI"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 0BA335C011A;
	Thu, 28 Dec 2023 03:56:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 28 Dec 2023 03:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703753760; x=1703840160; bh=wxOsII8PVL
	G7i/523eXFiTqToRayGcgJYREHMGpk08A=; b=w8AYTsDL1j8SGxRNJQ4lCDnMun
	D3hOfKSoyS7/qQkHGwufBGRamNuifu0avMwFItrdSpLn0k7SXBeG+Dms2BRtbvNy
	SXEeIWb92fRJf17BtsN477+IMUjzWSUfs7aD4nFbWyvMJBg1wUXmXi4aQVcuCqTs
	FmbWNn5RKbxHQdrc8WouObWGt60/T9Z/ePv/LMmcimdJT57l7UklLfjubG/ybn9Q
	xjPpjgcfAmko5nWi8J2IUGWMTUEPkHGmcUTu05ED/oEhYp7UcAnFNpacR1rzXwmm
	1xItHPkfnhBgpsQDc8IgWI4Fncxec03swp7QeJG3iGtrft+lQMP3CKu70jMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703753760; x=1703840160; bh=wxOsII8PVLG7i/523eXFiTqToRay
	GcgJYREHMGpk08A=; b=4Wx66dwIrr5nKZhErkRFTjdl22TNrn5BUdN6XKzq7IRb
	tEbFnMOgScqsA3XR6GtgmGtxRQaoTN2Npl3NUeWIUasUJ+0ge8g8mxJWuYMwN3qP
	D/4JjLPVsMrxTlAJIkJHLOqXF1e77tm2icQUX1kXtE7OFNK5vPAUekh52pTXMvVR
	sVlUYr+tbxH5k4FqlS9r+qUJPNkGxmbX1HjGT3PVo5SIHyOE2wslVIij+lbeOfBv
	xQHvm7AGb3VR4Zej9cnMQZNHIN/m2OaXZFn7bq1YgA795ZmViDMd0ou9sBWiQGrQ
	U63R6ugFh2Q8JxTUAbGrDPTU2GehP5a2WHnasDFADw==
X-ME-Sender: <xms:HziNZdMPO1ZccDafI5tt0EjNL_mvGllBNXCKilARrosv6Rw1yZeueg>
    <xme:HziNZf9q15817qrC5prqprm39A_lnxo4worn2i7Zs8MjK063LoK7KZyt1FFO8-QkT
    GPu4Bgv7zFnRg0CzA>
X-ME-Received: <xmr:HziNZcQATlX8JVHQZ73ArDfZUQmTdNsVyzGTCJVnPh1SHcUscjnXHPl6rXVOA20vJJVE6cRAgf1k1RWxf1KdLNwgVY5psShOu9pAYaLDc90CMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:HziNZZvXeVhfmg94DV3U4kk_BVjJGbuDtsb19pTaH0eKiINtx88erA>
    <xmx:HziNZVfTvYx2m8d5BBeBcm-IhWHKZF0A4lIPt0LHojuA6eE5JDA9Jw>
    <xmx:HziNZV3CzT98ItV2XQF_JhhMsgtHIUTDexLb71Q160kw09ANlucozw>
    <xmx:IDiNZVnyKHIroetSB0vb-kI5VTLGW4yZNbu9VIjRJgq8NTZsibzXXw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 03:55:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d3cf5557 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 08:53:44 +0000 (UTC)
Date: Thu, 28 Dec 2023 09:55:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/12] t: introduce DEFAULT_REPO_FORMAT prereq
Message-ID: <ZY04G_p1W_4EDeSX@tanuki>
References: <cover.1703067989.git.ps@pks.im>
 <239ca38efdbe3195e6319be4423b17d2b42e0b9f.1703067989.git.ps@pks.im>
 <CAOLa=ZSY-FBUMOx9SHkJqf7XteQC=hVoYxo73q=E1wL3QOBYtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I1OnQri8HzaJGnrs"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSY-FBUMOx9SHkJqf7XteQC=hVoYxo73q=E1wL3QOBYtA@mail.gmail.com>


--I1OnQri8HzaJGnrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 03:41:10AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > -test_expect_success SHA1 'git branch -m q q2 without config should suc=
ceed' '
> > +test_expect_success DEFAULT_REPO_FORMAT 'git branch -m q q2 without co=
nfig should succeed' '
> >  	git branch -m q q2 &&
> >  	git branch -m q2 q
> >  '
>=20
> My only concern is whether we'll end up blindly adding
> DEFAULT_REPO_FORMAT for tests where only SHA1 is a prereq or only where
> the new format extension is a prereq.

Yeah, this is of course a possibility with this new prereq. I don't
really know what to do about it though, and think that it does serve a
sensible purpose. So... dunno.

Patrick

--I1OnQri8HzaJGnrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNOBoACgkQVbJhu7ck
PpQBAg//WifSarC9Qugl/3tuKrU4IyuS0365tbML35Hvb4MkuL3uNY2CIku16hyF
v7yztlRyfav+mQ5RiRBJ487s9KzHT4Dfm3LJzUdVvWlyFvAswHxompDO42LdpUfR
XtfuKIXZbmVjsqG/dHFIazSymZW+DGjk/2aYTlewbVsJxuzULFTpaZ9g1VO0y9mQ
e2d+VV3960nL76NjTi0ghinufS55RJVyq/KZVxCwCmFPaTGUKTHOq4WUG2er+seU
1TE4Kmauamp2zcoM/tGZoVTtwQIyiU49Bw0W5ks+NOC3Vq8x7omcV9vTuXTcurTO
wAXgI8P+vvNK5tDoWoqTKTHpRltQpPdj2mhV7EsOOZiHTnvpZyf7w+pVM7ykORMl
E9MM81cb7powIm7L/hq64g8yrDDkdTORS0d3acsmFn1MK8n5vY0xIpD32zO+XWfS
0GJxZk2TqkmOTqGEVicBOGLe7zNwgEs6XyV8qHP7sgRtFn8byUThAlPiTtY4Avuq
bFxBc8CXcFpgFwfxRBQjNsyziJTCUjJcFCjmK3obyw/u14AlFRBdxzclzL8CwFVJ
CP8Oxiw5wJz2pc1OepsDAUw6ZZcDDOvpYQQaH8fe2r20m0pW35Xu4fnoFH/U6m8G
vCWfXIzjpgYdRPyb0rVd/2mGaAOtYv/tmAZ7Lg9KW0lhQYr1zpM=
=SC/D
-----END PGP SIGNATURE-----

--I1OnQri8HzaJGnrs--
