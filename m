Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86463A8
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gJGXpvwG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3XB+yTBu"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 0CD695C010F;
	Thu, 28 Dec 2023 03:56:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 03:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703753773; x=1703840173; bh=rfi6lNTjbb
	s18aCsyEwWjb+w976h/8xhQ06dZan7nKg=; b=gJGXpvwGmrLENqEoVTrTI63xr0
	cFkB3YGRXwCdQb0rLj7SJizkAhl2O3r2NxqnAXCaCaGyQMZvmpWMXYtmuv8xF4Vs
	yJbuUZh3Wdn1DddCdM3Hnyolfmm5APDU/j6ty1+icLMeW4j3NEl4TJN7dkuF9TgK
	xZVS5DWgJlbN1lWkTnsDEblACDRx0VHVKNOwKB9G86rWRSfCv78GNap8Id+42Eev
	EFSBzBK+JKBfwrCJXHBYi9p2dkid7MnDvwi7kNehv2Yod66qXvOlYtrtvGO9QED1
	K7wMQkCyuBjJeHJTedspcusiyGPE2N+2OeqbPlYI2J/s222X9TjVBdYyUEpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703753773; x=1703840173; bh=rfi6lNTjbbs18aCsyEwWjb+w976h
	/8xhQ06dZan7nKg=; b=3XB+yTBuL1FV9ZhHYJt2h9xbzduSJG5wVG76/4pxO7rR
	lomCkBe7CU3ajYb1HyObOucRiftaYPIcf2q5HPewY8J/X/eYnTDOZyKllihqnTSp
	/E9C8MisT5JHXOYD1Z334Urm3gasfZUX05yTUzNxmz01c2yxCtGl+c9Xqs/GR/Tc
	ApdMP4wuEw9ZOFSdV2vZVjkg6/DtiyT/QQbFgWQn+O9ccAEAQwdNVwLmRnDOnykd
	b+kjBICcj5/MBnBhkUCNpqSZrFyclkUuDGYqxSaI1eFZHYyPtxC9sJhSIOzE1zvv
	g/6sIooi7XcMBln2R4Jrld2eVQbQtpeKs2rP2Ex5eg==
X-ME-Sender: <xms:LDiNZT2T6ywg_bITw85qRLYEbCYdpu1z-5gkJhJMlhK1estpWotSYA>
    <xme:LDiNZSGbyLD75mlIanNwhLy67n5O8hKW_2D2G2Nx_LXbqwrrpjPJvY-Cz7bngUFpF
    J2zTJLH_5RuCllBzg>
X-ME-Received: <xmr:LDiNZT4LlhhSDjyByJG_9HlKwjlP3U19sOzFUCWkSLUNGWN9smebAig6J2UrgdYIFVpPtvx6hn2sdrgGKCFTYYaBZLFC8XfbFOyefL88Jw09cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:LDiNZY3pB6zHGx9VoRgi3bU50dlXqY_UUH38kRwhTZEsTNXU8R8CCA>
    <xmx:LDiNZWHjcitiyo6iGu7-wrwz7XFx3IcXx_ZvwamyR7uFU5UbaTJDmg>
    <xmx:LDiNZZ-ShvSftnTnhDt5OzucWXKm-x53fHYunSk1H2K4seMSw3rvwA>
    <xmx:LTiNZRMSlqYTu6K1ZeOhbydzM16e3bpA8am62pt6UR-Ka_zVK5eW1g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 03:56:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8492ebaa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 08:53:57 +0000 (UTC)
Date: Thu, 28 Dec 2023 09:56:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/12] refs: refactor logic to look up storage backends
Message-ID: <ZY04KePUMJEv_QQM@tanuki>
References: <cover.1703067989.git.ps@pks.im>
 <f712d5ef5bc5bed423cf50a0d0489095ba103df7.1703067989.git.ps@pks.im>
 <CAOLa=ZR1Bc+Acwjma9OM0SvyLg4-HB-S3Pxr66VCKTb0d_tdnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wdC9T7Ef8Y2HHids"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR1Bc+Acwjma9OM0SvyLg4-HB-S3Pxr66VCKTb0d_tdnw@mail.gmail.com>


--wdC9T7Ef8Y2HHids
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 04:38:30AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +
> > +const char *ref_storage_format_to_name(int ref_storage_format)
> > +{
> > +	const struct ref_storage_be *be =3D find_ref_storage_backend(ref_stor=
age_format);
> > +	if (!be)
> > +		return "unknown";
> > +	return be->name;
> > +}
> >
>=20
> Would it make more sense to return NULL here?

The only purpose of this function will be to print error messages, so
"unknown" seems like the better choice.

> >  /*
> >   * How to handle various characters in refnames:
> >   * 0: An acceptable character for refs
> > @@ -2029,12 +2045,12 @@ static struct ref_store *ref_store_init(struct =
repository *repo,
> >  					const char *gitdir,
> >  					unsigned int flags)
> >  {
> > -	const char *be_name =3D "files";
> > -	struct ref_storage_be *be =3D find_ref_storage_backend(be_name);
> > +	int format =3D REF_STORAGE_FORMAT_FILES;
> > +	const struct ref_storage_be *be =3D find_ref_storage_backend(format);
> >  	struct ref_store *refs;
> >
> >  	if (!be)
> > -		BUG("reference backend %s is unknown", be_name);
> > +		BUG("reference backend %s is unknown", ref_storage_format_to_name(fo=
rmat));
> >
>=20
> This doesn't really get us more information, since be =3D=3D NULL, calling
> `ref_storage_format_to_name` will again call `find_ref_storage_backend`,
> which will be NULL. I wonder if its better to:
>=20
> @@ -2029,12 +2045,12 @@ static struct ref_store *ref_store_init(struct
> repository *repo,
>                      const char *gitdir,
>                      unsigned int flags)
>   {
>  -	const char *be_name =3D "files";
>  -	struct ref_storage_be *be =3D find_ref_storage_backend(be_name);
>  +	int format =3D REF_STORAGE_FORMAT_FILES;
>  +	const struct ref_storage_be *be =3D find_ref_storage_backend(format);
>      struct ref_store *refs;
>=20
>      if (!be)
>  -		BUG("reference backend %s is unknown", be_name);
>  +		BUG("reference backend is unknown");

Good point, will change.

Patrick

--wdC9T7Ef8Y2HHids
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNOCgACgkQVbJhu7ck
PpTNUQ//ZXbuXMrtovWjl4mazw0SvZoEvrpSm8HX6WNe+T3BsnYTqFZ8E1yeSnfC
ccabpnep2kBXeI+yN8Z8wnWUKB+swzCLGwzEDVjSSxZDxBOWjUVHmuy2IgZEpi9V
1Sr3HCNWh3XaWSMuVbFhU3YUbUNxYgnSsKAMRemA8mxGQ88WsHepx838AVU7l2g9
6GWwMJzAk7fXTykMM0wwzumC20h7Gq6nIq7kn5LJ0+QMri1bLUKcp7Z28A2bfuc4
tdgewe0DKoKnD8JArF1SvE/ts1PAdy6LWFJIlSVV0hnmxEjQg2Xi3jbq/NuxhNfm
GNGOd/EXe4Ahfn0ImTwIIQbK6Zcuyp0Caz3KNlZx7aWDtt6nPvC81P0l6ZUtMDDF
4C/eXd4KU1VY/GxKZymabFibF/Zl7f3IeNi9cP46kLzQxldsNhOYQVWTcoTABSE0
R9czcBNVC4wxsyRm6q8XchuCVc+VXQ8PJ0hhXFAzlWoS9OPP/z14MldLyPQY4kH9
G1lnZQ5SyMZySKtce2knCMGfaxXMJziSU4nFsyS/BYOVrK/r7f3jfh2Ic5WncTlo
Nfxwq1ahb9ZL7Nsgp2IeG9bJ0czDg3u/PP4p5l98GHkC+Z1svoSBHhsHPqnVV1bH
RQjazs7Q9skRw1yPCgPqScUy+TQ2I5j8K+0VvEUosOU/UkcZ52o=
=dTIc
-----END PGP SIGNATURE-----

--wdC9T7Ef8Y2HHids--
