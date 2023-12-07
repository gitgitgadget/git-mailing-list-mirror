Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T5us/jAE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v9hHm8hA"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8954E137
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:22:55 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id E37ED32009FA;
	Thu,  7 Dec 2023 02:22:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 07 Dec 2023 02:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701933774; x=1702020174; bh=6y
	jpx4FvZuIcuwTdZmULOqKG0AoVbiFf8pzuBHkJdvg=; b=T5us/jAEpGHZtpFYDz
	cL+/Ds3FfvsdIv1Byg3/m9KXtGHulLBejzpzwopuaOKYk2J3dUzBGsWLOiaRnhPa
	anTK34mSSH/02o1MvKbdZpWuz2ruhWsOU2GMhT+I/LgKD0lpClbCLkVIuXOINHcV
	r52FhE+cIAeKnViFEmLCRamtaCkET04DzCvpMkim7+MuCs5fOeI88hghMKY8XgDj
	ZycuOKGks0WwH8fqiAfnf1AwT1itLafNFyWP+oj0RuDi9xlz/SbBQNZSE974/ed3
	jloYRLRZ6uDpR0oXDDWCM/uXEHPsrFCrSGCA9704scft5TV1epRZnB+zyEgpmnCa
	zNZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701933774; x=1702020174; bh=6yjpx4FvZuIcu
	wTdZmULOqKG0AoVbiFf8pzuBHkJdvg=; b=v9hHm8hAa0TBJ+90npuVaVj22xkLG
	Awa0YEktoUsUq5uZN8aflbosAZW/DRnznOiPvsCO0QcANOBtVlQwQZeyFb/K0zPS
	f2W822nA7HJvCFp1h9RvbmmRRzedHhJJTbOPrB8BOG+p4v2DApUXSElwQ1JE0uSj
	wKFOFamjgxFK4xZ0i5A0MfUFZBIIU6H1/3ynvr/RP+YbHarkRZBxFd9LGWHG9TTf
	KtDjnDkXQDBPwkFJXpwuQHEGt1O9oUVxnMvKcDJv4lJK6Zh0lgNLtc1LEIhC/cBq
	lQ8K311c+zV/qthajBcBKnKurK2lfjSPIXhYO5ZAVYeoLacGK+A6SaDVg==
X-ME-Sender: <xms:znJxZX3ff7ll6Yjvkw-sF8QxJiZnlBJknVAFS_FRLgsCycLk8ntUug>
    <xme:znJxZWGSbpM3MeKAGP6Nd4e1NDXWimcULc0rKPy2NtGbSyjO7Kjxh9RINzPksnxFm
    _S1c4mXnjbYbV9jFg>
X-ME-Received: <xmr:znJxZX7RYyQKlsE0ezp_77VK5NKyltnzWtCAG8BJ8Ltt3LulJ2SmfpijgNqaDhqYhJFRJ3-DsGtY2AgX--v_eeJ_dbrwevMbmM5Z-3Fsxhs0gmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:znJxZc3SwtWv2v1toLC1liHycdC_pD_7Q8vn7CW8Va45r4F7uKP7Bg>
    <xmx:znJxZaGzl2Rf_6cpRNmLaajL6R_MXCIb7i2_npHW5FS-UUmRsyR_Bg>
    <xmx:znJxZd-9TNe1oUgH0r9651pFc5FeajQFm4a2xTHgPNz7n02M5W999A>
    <xmx:znJxZVNgfmFpwhhNiTgxTk3asHrGzuwqRidCtILlgz_KFfisPjNxGw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 02:22:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 562d2119 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 07:21:24 +0000 (UTC)
Date: Thu, 7 Dec 2023 08:22:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/7] builtin/clone: fix bundle URIs with mismatching
 object formats
Message-ID: <ZXFyylqzNgXwc4Lz@tanuki>
References: <cover.1701863960.git.ps@pks.im>
 <c7a9d6ef74ff39e660f80e2e104a96b7c875845d.1701863960.git.ps@pks.im>
 <CAOLa=ZQc=7Z3w9JAdzS23P=c=KSYZJR6gJSLOHdU-d92Y3kJ5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AAwM7rbJFAaEpnd+"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQc=7Z3w9JAdzS23P=c=KSYZJR6gJSLOHdU-d92Y3kJ5A@mail.gmail.com>


--AAwM7rbJFAaEpnd+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 10:13:43PM +0100, Karthik Nayak wrote:
> On Wed, Dec 6, 2023 at 1:40=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
> > The first Git step where we expect the repository to be fully initalized
> > is when we fetch bundles via bundle URIs. Funny enough, the comments
> > there also state that "the_repository must match the cloned repo", which
> > is indeed not necessarily the case for the hash algorithm right now. So
> > in practice it is the right thing to detect the remote's object format
> > before downloading bundle URIs anyway, and not doing so causes clones
> > with bundle URIS to fail when the local default object format does not
> > match the remote repository's format.
> >
>=20
> Nit: s/URIS/URIs

Thanks, fixed locally. Will wait with v2 though until there are more
review comments.

Patrick

--AAwM7rbJFAaEpnd+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxcskACgkQVbJhu7ck
PpQY5g//fYX1F+UgEkiBlx/OX8VgCB//0rn4tB2JQXNQfwbGHYQouvl1sKr8BWiC
l3ev0uzUe4UXxgehuaGJzLdz0kv0Jss0POfJZAW493bj/vocnJJcTxcFZG8IdXqb
Q+53QaBYkEhmasvetLovlQ6rbxeG7Viwr9x6Yxu1zjt1dLnnf1v4+S1PFPZH4GlG
hmE3UIHmpAo3EaGnIlcjmu2Y9tnjOsF47CWbhE+yQBf3s8nIStRC51YmQkuq9V/1
y95dUJZt84RXresu0eltlByAv/l0E1LZ3dRsYaVXJaKnJxDxrth4/ehDgnHLPE4M
6P0yO6ZrTidGOmGR8crOxIJyas/P6CGRp8/RbDNqo2XX0VTOlKNVAiTos4G4k8DF
9VVqYGLnV9jo0I73OK4u199+SRlQ1QrtPt2Hp6klffgnWq/FIV7ZFWIlJ5WgV+RU
mQI2u4EqNHLcLKT/tpASrIwBT9KZhGrVHch8mkGVvI+Uf/fByTRZ8PmqnR2Srypq
+cGE3xQZ06J2SMCdM/4Q35xdYRPZV8npi5PQwVgiE2SEErYQ8g23ZmmpDoTiWJdk
Ifa3mUxi4ynus74yapKjGa7LM6kXur6sK7CJX7JxsjPVe9RodhYDSHKlirjed15r
48Kpf0DTUbliDhtV1Al989txF8x88ewDvu4E8kKq2EGQlqJyXBc=
=rAI3
-----END PGP SIGNATURE-----

--AAwM7rbJFAaEpnd+--
