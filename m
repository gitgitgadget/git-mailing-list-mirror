Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q4sO2Ka4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kl5ZMuwq"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C667CD
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 19:44:44 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id EA8385C024D;
	Mon, 11 Dec 2023 22:44:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 22:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702352681; x=1702439081; bh=5Kf1ABB1bd
	p3uvzfgNp9xXIFN/qA1EYcuU+HivFiRgQ=; b=Q4sO2Ka4Sat8p9SMVwrQbqcZ70
	gA3ZVIRA1yhYWk6VpTA3Af/p63DJ97paXXpF3mw/6B8QjMb+9yApB8nmssT0xq9h
	5F/98B2DWv4Noaa5FM6SnQ4a+2zdoUbpOoNC9Hu1cIn52LYktqOej4qQcEg7FwEL
	0XfyZUv9eAr97YyTDr8HeWM3/SVhquNdHQ8N7E4vt5mfKgTopD5WXuySGGabaeSh
	Lplfxz155ny3xCLaI0kburGDq766OIi8+IKL1oI/DAHAFYyGNTW4BubNtChnFYAw
	VND6xj8bQnyAZubiQrzWGL3Lv3DdFYSL3QQhVHuB+n2DnPxHFNhPaHCuzH0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702352681; x=1702439081; bh=5Kf1ABB1bdp3uvzfgNp9xXIFN/qA
	1EYcuU+HivFiRgQ=; b=Kl5ZMuwqwQkZQpc9vkLPQ3s9lcyJSIpmtaOI8KURFkyX
	GQlOTmdRoZMeXdNE0/9fhEIFpy9I4t2Ihw2obEq7AsAr/iaUI+faaiZvweXULW43
	CvPKepcoYcwI41TQtq8TA65D5JSmSZumJDFo4r7ZVQBPt81p30+UAfYL52mVf87L
	HIWLyga6/vI60NB8YXZW+TvCHxB8mat58n76OUdoM9QkTv7trZbhAuL+e3SO+c7b
	55N4hOFkpCqcXC0Z7StdacOSV9s6z34zjGvrs1I1Nsp6k36TEsITJxd/lx692UeE
	a4L6FDod0WDpYbo1fp7k0G5fNFh5izJNaDn5uSBoGg==
X-ME-Sender: <xms:Kdd3ZYmip4EL0gKsLsrovA6gSbHKeaLMhecuo8kFhV3-veKaazWq_Q>
    <xme:Kdd3ZX1mqbwWWHdyRRtAwM9n5XX0BfBJqR5INauvlxiNwusdSTJzROnb3cv2oT1Oo
    _xVN97MnbrcqOSjYw>
X-ME-Received: <xmr:Kdd3ZWpJ0V6Ial-TQ9d_xXhX49-32t2eSY8SnlTqmmTXpbA3tc_CRt13bkvkDCc9BreVfBs-kqbUzzMY6auyUiN5VYVaKJlI9VjbVefkVnzRcgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Kdd3ZUnqrEXutHTPVqupfg_pS_jbiESZhv8cujSuyIDp_qY2mSc0Ww>
    <xmx:Kdd3ZW0brYrgc86S00TmdD8vMBr-iJOhkvOCrv0KIvSkzGdUBLyauA>
    <xmx:Kdd3Zbs3u-FgPL3U0gi4OnrVssxQb5_7LIaHVvbY5XmRMwyJs6Dh-w>
    <xmx:Kdd3Zby5bnk3sMVM0F-tt3qSQSwEy59d1_06SYbWnBmn0uIvhE0eCg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 22:44:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a046daaa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Dec 2023 03:43:00 +0000 (UTC)
Date: Tue, 12 Dec 2023 04:44:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 04/11] reftable/stack: verify that
 `reftable_stack_add()` uses auto-compaction
Message-ID: <ZXfXJaDTdEx8tohk@tanuki>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
 <5e27d0a5566d90969734e92984cfafe6048924f4.1702285387.git.ps@pks.im>
 <ZXdt17pN68tsmH1H@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZrTaNsGbPSn7bTSh"
Content-Disposition: inline
In-Reply-To: <ZXdt17pN68tsmH1H@nand.local>


--ZrTaNsGbPSn7bTSh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 03:15:19PM -0500, Taylor Blau wrote:
> On Mon, Dec 11, 2023 at 10:07:42AM +0100, Patrick Steinhardt wrote:
> > While we have several tests that check whether we correctly perform
> > auto-compaction when manually calling `reftable_stack_auto_compact()`,
> > we don't have any tests that verify whether `reftable_stack_add()` does
> > call it automatically. Add one.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/stack_test.c | 49 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> > index 0644c8ad2e..52b4dc3b14 100644
> > --- a/reftable/stack_test.c
> > +++ b/reftable/stack_test.c
> > @@ -850,6 +850,54 @@ static void test_reftable_stack_auto_compaction(vo=
id)
> >  	clear_dir(dir);
> >  }
> >
> > +static void test_reftable_stack_add_performs_auto_compaction(void)
> > +{
> > +	struct reftable_write_options cfg =3D { 0 };
> > +	struct reftable_stack *st =3D NULL;
> > +	struct strbuf refname =3D STRBUF_INIT;
> > +	char *dir =3D get_tmp_dir(__LINE__);
> > +	int err, i, n =3D 20;
> > +
> > +	err =3D reftable_new_stack(&st, dir, cfg);
> > +	EXPECT_ERR(err);
> > +
> > +	for (i =3D 0; i <=3D n; i++) {
> > +		struct reftable_ref_record ref =3D {
> > +			.update_index =3D reftable_stack_next_update_index(st),
> > +			.value_type =3D REFTABLE_REF_SYMREF,
> > +			.value.symref =3D "master",
> > +		};
> > +
> > +		/*
> > +		 * Disable auto-compaction for all but the last runs. Like this
> > +		 * we can ensure that we indeed honor this setting and have
> > +		 * better control over when exactly auto compaction runs.
> > +		 */
> > +		st->disable_auto_compact =3D i !=3D n;
> > +
> > +		strbuf_reset(&refname);
> > +		strbuf_addf(&refname, "branch-%04d", i);
> > +		ref.refname =3D refname.buf;
>=20
> Does the reftable backend take ownership of the "refname" field? If so,
> then I think we'd want to use strbuf_detach() here to avoid a
> double-free() when you call strbuf_release() below.

No it doesn't. `reftable_stack_add()` will lock the stack and commit the
new table immediately, so there's no need to transfer ownership of
memory here.

Patrick

--ZrTaNsGbPSn7bTSh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV31x8ACgkQVbJhu7ck
PpQvQg/+MJxO/+gb3tYI/R/saRs5eaVSx4/x37F2koIQR36ebWOjb7KlO1GP9w4J
Y77RK4FGSfqkNkz2hFc8C4tlOZefgMrJsN7xKYIHwK3/m2BcN22hdqtQz5NaZuHf
J0bM2dyuuzdB7TWhJrl+1SxAXy+0DO5xlfbem9T1m7qzWQz+mpeTNmXgZZh5Sdip
4kxp4QG9ncoTcxEF4hLLVYr8eb20GKxcpg78lAobtaXz1p3NdyGIidQXSMdQyOmd
IW7kuwiiIwhQARRKUSyx+v1M3VNTu20jyQ8ZCUnQNLid4u1yCz8/mLIjxXh6+afZ
Cytz8VeNH0kFC73AAOaN9XB6Nx0rrSZTJiuIKEaeQZVla5w0PpA7YLM9T/YFRPjA
ZwoGXMDvs0+uq5nSf15bw+AA/6qAdLhUEUeGXZugwbnzt1MLV8gMaEJSGjOkHPp2
cz2agcdEBdMxeg1td0ZQGvH7Izxj/qVC/xV7Km4b/ThLSL3lgmi2z5e1TUrYU9aM
BjeCJOOBq8LafeMWTxJZKN2tvyJTTeFLPzj4C1qq48wKv+xjBSmEq6BYAs/Ta/W8
zDC/KlopLB2e2QMcpci7LfAt14eLjXOu4inZPJnMt0JLZ86OmCpzJpXyQ8ZEfau+
xJYecP0J0MOh3zR8dBFP9CjtDmvvOUD5lucQSgbkljgGfRpjJ+s=
=2AYE
-----END PGP SIGNATURE-----

--ZrTaNsGbPSn7bTSh--
