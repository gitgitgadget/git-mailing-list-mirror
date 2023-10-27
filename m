Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A821113FF5
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zmCMJhpP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eH4+ryFy"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241DC111
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 01:17:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8A4545C0105;
	Fri, 27 Oct 2023 04:17:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 04:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698394645; x=1698481045; bh=XY
	CVSNrBSCzBgDuTMkCRKktDcYS7ugovdPE9h8bJwEw=; b=zmCMJhpP/SOtbUQu6J
	+M8nMRHF2sRA4tBpXfAyDuEcEZU61bXzHew3xfa6NbTq+WKKD/mpMOr+nbHD0xDt
	C1FGWTRPYYj7DY+nNzm90UUFb+SJBKJL45Z5aXQmPfUeG7mc50mda7M2cWb/FDKM
	X89WZBcpVvcISylmjw5MQ++NAfLuqZmLxLrsASivyKJNqLqBVCsXIGt7rPcxxY1E
	d0BQE6URq8npasGTUUQIDpkjEr8sfNgMorAuDJ4eo3EB08mwS/Za1eCxjpDPf06c
	s6oPI5N9V00AAXhwq2Ipq298KQHkPiOdlQ2c+QxyJFvP1ua+d+HeTQEaB1SE08tZ
	Psjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698394645; x=1698481045; bh=XYCVSNrBSCzBg
	DuTMkCRKktDcYS7ugovdPE9h8bJwEw=; b=eH4+ryFyEusXjEm7DshGPlbGLgb4x
	NPDVwnnSLAkR1MktJRaanPao98mnKkGvtgEaODaQEKpmAaPLp5wWBek6vW7ntqca
	oCBBkdbpOf4XyuupC8PgfA7cJPatjMzhfhXyaFr72iZ9ytPI7n5Dsf2Mi3pGayPv
	ca6kwMdnKA9LzgmQg+abv0Hg+i5tnNVs2eHSwirDLtvjvgmZ5qnenmo2i5Tyzw5a
	FVetCTBI21hyqpHjdVs9dLbBrc/wUl8VQL9YKFV25E2rVHDwJd+1Bml/Z5GpLIwH
	83WX1jFx/5J4RxcoSo27sBLFVBx8CLUYVDSIOxotGhkPw5oYRW9MgZI0g==
X-ME-Sender: <xms:FXI7ZdZyRypKQGv4zyc6Yx0P_pDXnCNw0Ur1oalsrop2Ua-xPvLRgw>
    <xme:FXI7ZUZF1urJEphsFD_T2tp4Sl3s8zqxVt1lXdaVFW6gX4FE0o_vMt7OwSbqZcwZ6
    wBkEC2ceoTpoXBjFw>
X-ME-Received: <xmr:FXI7Zf-6YAdfc9cTONssAhOo2pSIkXf2hCZcNITxrH102ZcOGzei-fsqmGsSH1s1kUQDkTjpbjy5O381Otj8kte8Z4o1edUgWo0Q8FDtzkifxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:FXI7ZbokKNYeSO30LRAaZtj_0sn9jjNz90BlaJSzhAzQtbLcZuGl2Q>
    <xmx:FXI7ZYqD0qP2Msgk4gVm1zApLcMY0TUmafoWqfGAccCUjVaUUVoUog>
    <xmx:FXI7ZRSa7lLpY_5ixoQgTJ190whnDM_JIPGHCUw3LlucnTr4Ddt2ig>
    <xmx:FXI7ZfSYxJfchDglOWiujPMUhSQLWirTTu8ypEwfvHXAHAWgsKjOeA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 04:17:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4929913f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 08:17:12 +0000 (UTC)
Date: Fri, 27 Oct 2023 10:17:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] ci: reorder definitions for grouping functions
Message-ID: <ZTtyB0hgXN8gO-Tn@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <586a8d1003b6559177d238ceda2c6ef2f16cfb8d.1698305961.git.ps@pks.im>
 <ZToin/fQiZrmUJTS@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yJGwtMUQnRdz9oLy"
Content-Disposition: inline
In-Reply-To: <ZToin/fQiZrmUJTS@ugly>


--yJGwtMUQnRdz9oLy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:26:07AM +0200, Oswald Buddenhagen wrote:
> On Thu, Oct 26, 2023 at 10:00:03AM +0200, Patrick Steinhardt wrote:
> > [...]
> > _not_ being GitLab Actions, where we define the non-stub logic in the
> >=20
> you meant GitHub here.
>=20
> > else branch.
> >=20
> > Reorder the definitions such that we explicitly handle GitHub Actions.
> >=20
> i'd say something like "the conditional branches". imo that makes it clea=
rer
> that you're actually talking about code, not some markup or whatever.
> for that matter, this is my overall impression of the commit message - it
> seems way too detached from the near-trivial fact that you're just slight=
ly
> adjusting the code structure to make it easier to implement a cascade (ak=
a a
> switch).
>=20
> regards

The change is trivial indeed, but even a trivial change needs a reason
why it should be done. Maybe it's too long, maybe it isn't... I'm happy
to take suggestions.

But anyway, I've adopted both of the other two suggestions you made,
thanks.

Patrick

--yJGwtMUQnRdz9oLy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7chAACgkQVbJhu7ck
PpS/2w/+MWObHqnLO2OaZ3LqiYXNiDjElXBRsz51H3AiZftr4vavdHbJy1lZx9pN
YzsoZuNkxUnD89lAu/Oo6Gegk/+CfVbyGB9/HNwGSjcuKk0Akdkv14O8qiTPvOsU
r4cutQOCXyNOYar8gAPAxos6dl80pvdCNaGER1zLdiObYWrj6JDh2DEEosAHRtSj
dbR83bjeRt6ULFTObISzBJJ/dufXrPIjPgQUXGTACuTES1YsuOLcVuSql9+NOqHu
nTpJrb0YdWOCbpgp5oct8Y1h19JP+DPO7DNjhnX7J/lvN22M5Kb1TEQX5lYoeHpt
VRebNes0X8BCJ1WgaF3fMWhbZg7LdSW0InSRe05pwKeqVtEhRJTT0gh6cxVSGMte
v7XShYMDHyASpj6bX60Q/zcBEOHI4+yjU92lLoaEKDk3yCcyEExf/WTEMTL3Sbyq
g9L3LbKCpez+/ZH1oDlFqhKJf9xC46sUm9RL4L7Mk+K4o/orLp807I703ZAXo6jU
zLyR1r4PLZc1JSD2VcMuOwL/iGnaL7KR/TRlXETogmKgjNI/3hYWi+ntBE+6u5v7
7lyGMm55qXlPWbkeaEQz5uVXQgeWAH/FejenQJPAYJitMqh/596qPcDiBq1eBfxm
BfmsnCWXOGcdkfQxvvcWp3LQpZmfYNd0tpgms36TaWpRYAU2a+I=
=X0yT
-----END PGP SIGNATURE-----

--yJGwtMUQnRdz9oLy--
