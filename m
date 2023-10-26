Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F928687
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BTk75FZn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xfr85dMC"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A139D191
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:48:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id BF41932009BC;
	Thu, 26 Oct 2023 05:48:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 26 Oct 2023 05:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698313735; x=1698400135; bh=7J
	kB0Xdv5aD4XX2JecGkA2RSYxxTJExtUv04OoK3lZE=; b=BTk75FZnrWMu5u89Bq
	f5D3jK9f+iYiaXkbLhJzqNrAb1+p4vQYPV7N4PjIDxYMg0BzYLUISSDXxboe5ZL2
	eXH1afHbvncSVnWHqv7j7NbddFUd1V0FenUO+cTjWISqHPqoziOkfFfIeN/VYPcE
	NdYXarUD4cduxi+MBSCkrAECkaxqxlWdF/JOWvWPDHX/uVhE/HmXzE1QuY6YXQkf
	hMqIpme4C/9LVhxc2SfBEt20+0eLhWURn9qVLKSD8BOr/BVdx72XqCf2VpeNqhnn
	gJ7sHPPHf9eK1pVzzI9Ox9iaiCDRc46GZJHcth5h1AEwYjLCOSLjZpYWKo9P7bb0
	0W9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698313735; x=1698400135; bh=7JkB0Xdv5aD4X
	X2JecGkA2RSYxxTJExtUv04OoK3lZE=; b=Xfr85dMCAjfWcAI5xQPeJU9LYVrkV
	z6+U4J7gSCQUej2pTBXigm5jSTxcFeIO+NFxRbIGB+ID+4lEiKw7pMWKXnb11cBW
	PBJANGi/lwL6fglTZFHAVzjkFbUOU2aWpCT/95Kpi/2TrD2W/MCtfess+m2o9DSS
	bUzUIm/eUXH8Wt5Cdz94kuSaJc7BSggs+XjeADTvaN/fql5YjWEFBuf6dJLAkjnI
	rCD5OndSvqj5zsx+kYLJQZU+XPFevXUzPwZoEDTEJ4RIKal+C3mSmRhWBGXIpjOs
	jyUAEzY8xzdBOaD8vfAeIYGUbU4LMBI1XmEQ34FAybVa/ilPHUszBBtnQ==
X-ME-Sender: <xms:BTY6ZQAxmlJPHGvtfEdZS3pqD9fvDE2XcLUsdFfNMIJUwOLZ8WY5Fg>
    <xme:BTY6ZSj5oid0eLc7NpY1LNcvfQUcbR2O-xGqcvp-kq2c_5vbp77FOlpd72o5mVBhk
    9pALyigYDcXGsE2qQ>
X-ME-Received: <xmr:BTY6ZTlefqQ3ni8W3OoZScqKmasWueSD-jiJjDp_5HrChxjUZmlDkJCaK-dhfh_FtHBmslHcsuq7vm4_mOHXp2TV3CTPxvG0CPrKz9cRZP-Ja3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:BTY6ZWzA5CFAUoVI8dOhz8oI9xh5C1oLDGGMENYR90lMWtixVMP8YA>
    <xmx:BTY6ZVS6GjvmIapoJ_zkXguas2FXEVvk5d3p5as23gBpoEdC1QOjRw>
    <xmx:BTY6ZRZqH0yJMzk-MRBioRFZLiGQd0IIP-8D03z03a51NRwummkamw>
    <xmx:BzY6ZXe8xjdI_6-svW0Hnazl3Ddn2fJnNLgWrxZK-5sRmrySh-SpYw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:48:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f22ca41e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:48:43 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:48:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/12] show-ref: introduce mode to check for ref existence
Message-ID: <ZTo2Aq2wAxx_6Laz@tanuki>
References: <cover.1698152926.git.ps@pks.im>
 <xmqqttqf3k5a.fsf@gitster.g>
 <CAFQ2z_PqNsz+zycSxz=q2cUVOpJS-AEjwHxEM-fiafxd3dxc9g@mail.gmail.com>
 <f87c95d6-b1e5-45c7-b380-bdc8b8143ab9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HO6DyAURNOGlg6TY"
Content-Disposition: inline
In-Reply-To: <f87c95d6-b1e5-45c7-b380-bdc8b8143ab9@gmail.com>


--HO6DyAURNOGlg6TY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 03:44:33PM +0100, Phillip Wood wrote:
> On 25/10/2023 15:26, Han-Wen Nienhuys wrote:
> > On Tue, Oct 24, 2023 at 9:17=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
> > >=20
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >=20
> > > > this patch series introduces a new `--exists` mode to git-show-ref(=
1) to
> > > > explicitly check for the existence of a reference, only.
> > >=20
> > > I agree that show-ref would be the best place for this feature (not
> > > rev-parse, which is already a kitchen sink).  After all, the command
> > > was designed for validating refs in 358ddb62 (Add "git show-ref"
> > > builtin command, 2006-09-15).
> > >=20
> > > Thanks.  Hopefully I can take a look before I go offline.
> >=20
> > The series description doesn't say why users would care about this.
> >=20
> > If this is just to ease testing, I suggest adding functionality to a
> > suitable test helper. Anything you add to git-show-ref is a publicly
> > visible API that needs documentation and comes with a stability
> > guarantee that is more expensive to maintain than test helper
> > functionality.
>=20
> Does the new functionality provide a way for scripts to see if a branch is
> unborn (i.e. has not commits yet)? I don't think we have a way to
> distinguish between a ref that points to a missing object and an unborn
> branch at the moment.

You could do it with two commands:

```
target=3D$(git symbolic-ref HEAD)
git show-ref --exists "$target"
case "$?" in
2)
    echo "unborn branch";;
0)
    echo "branch exists";;
*)
    echo "could be anything, dunno";;
esac
```

While you could use git-rev-parse(1) instead of git-show-ref(1), you
wouldn't be able to easily distinguish the case of a missing target
reference and any other kind of error.

Patrick

--HO6DyAURNOGlg6TY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6NgEACgkQVbJhu7ck
PpTnCw//YygRox2M05fHY70X8mF4M8w/0c1Ddf8YGvkJxi9PqpCsNgKQQaBj8srl
DFFIE/8XmsAeqgpcOKEnU7+RnQhwQdleFdz4+4ozN/Qc+awzZQgocTI6w2HieIhU
Lu5ij/c7tiLowZ+tKliS8UcQu/tlvNqXLQU1472rarpv6G1Qo5ytpNzuhzKlnbRM
LALmbkggVLaerUi3TSs1nMmuZj9xCsuczaFnvo71fbLPx//PUs9I8VDk5DFhtAIs
vAdshYjuo+myy+I4D5LO1SX5seUj8agfx9GdYosLRdSK4Z02x/ISyzPHulLz3xfv
XK7n8XZtX1Sl+vxF4LWvNGzZTH71A2VnConLge6bR9rxX4UymVMyXYxkMhowm0pQ
TIa+/3KGCPfE9VaBd4uOjqX7Z9x4PBy4WVUUIa/LML+bsoZmtqdro33ObVZu+9PF
hb/2P7zThzXbfu2ng2Q1vS74nSDMvUQ0vf5M6FHuBVxvQ62ZA6rtlhmnL7g4FJFO
Px9MnWWkUfBT6rck22gdOTlz2JKKC1MiWgGxCbhddVo457/nikLGVH3OqV8Z7JBP
56MMGa7XfsENqi1ZRNi2hlngfz46Hn+lylqJgLO8jyrEhJAhuOpoOxMKIW5mo0mF
iefq+YEnVL/N8v+HtIxG0ZMYxkqnFdjWl0eFA+vq2e5OV7A6kf8=
=81yG
-----END PGP SIGNATURE-----

--HO6DyAURNOGlg6TY--
