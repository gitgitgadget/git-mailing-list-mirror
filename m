Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB372AB35
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FvHxRJcd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zv1Otd3p"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67DED7D
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:11:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id D43D032009F6;
	Tue, 24 Oct 2023 09:11:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 24 Oct 2023 09:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698153083; x=1698239483; bh=3a
	PQPejqIhi+4oQbY3rbLJ+Z4+YNu+SSxjN3/d6f7/4=; b=FvHxRJcdBpiRh9rl8z
	QSiteKZa/jxaktxBxGQKOzQ5ov50ehkhmQRmEyCnr1v7u2ICgwqSAPB8CNEFhcfe
	bsOmdikjbQ5o0Ru5Hr4jC59Rk4gJ7chr3ZSao8Ol4D3PjG+3W7Dv01It4NiiTI7H
	kuEiLYsj3M3jGf32RyPByl0nWVHLgbDeaX4LK1BW44EYbCFeKqGyETl5nbC/UNKT
	V2wyzdHRWZ/T4R/SVJmExZAcV0KDfm2j0MM+cjDCCGAHlY8yrgmod8xU/Jf0A3Uo
	MWiH6Je2L5eD0lIQLnlFNHU7VcpFP+nRTig2V9O7eI2CeTKp8NOFYIPco9qLeMna
	OIqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153083; x=1698239483; bh=3aPQPejqIhi+4
	oQbY3rbLJ+Z4+YNu+SSxjN3/d6f7/4=; b=Zv1Otd3pnoF9Mmz+ZdgsG2ja7PuJ/
	3PqRo3Hn1wEdye8Z6esKoPUiR1rDmJQK2TFnI6WE73XciQCAsypaJgXJJYBKec/q
	aUB6W/nWQex6ORMDe4PpAujkdNuPbEHXlTXcrWH9XUtYkrHFvNvDY0jBLwbPLlJ9
	Tb7drJUBvOttkfwbuRlkWebWlTCdYUwGrlAA3mmcZ7EUT52KQWSswx8OyaoPg5Dc
	rxXCbyUwiG74ghTMBD51KK/u+DkMVDWAJ0JoIhP7Tmr3rM/HQH2XsT7FovYZsguf
	6Qx0ZidF3skHMZHKcycySR2bJj3d5BwZDr13vvp2tBZZDNOwg2taR/IIA==
X-ME-Sender: <xms:e8I3ZWX_AsQ-QjbB-yFTIh467Q8_od1_PzsuxHziAjI3PoVIAwdSyg>
    <xme:e8I3ZSmYzXVGSc-bXdbXa8_spl2DoKs8pY5JolbVVFYixSQsXbZW_IJ4geOoh-Rif
    vHWMskat2XM0E7GEQ>
X-ME-Received: <xmr:e8I3Zab3aqqfpo-PNKX6RxCbiDebYysh3dNPeEuREgaWHfHIXBhr1JcbK-_DqzhcAo638lxaI6KzekZwBqXtzh5Yb4NXmrTYiEkdjjmjAzGCwNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:e8I3ZdUB9i9TSWWwUyiuFDf6mY88RMXXQPMgjErpz4mRSP5fn3RS7g>
    <xmx:e8I3ZQnqAxTLdUgYPkTEcVauS2xvx7q_AvqVLQW1HzZDuj4OgY3MDw>
    <xmx:e8I3ZSdYIRmxr-tXiQ-Z0oUJS0pmotwyzonWkfSs4xlk48hvB5dY_A>
    <xmx:e8I3ZVzP9Ckfif0Hi8k7J_9rR_p9KFLfNu91oVmkMI4X7WdP71wDXQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:11:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 232ddd98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:11:17 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:11:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 10/12] builtin/show-ref: explicitly spell out different modes
 in synopsis
Message-ID: <adcfa7a6a9d8fb6f915faf77df52362544cd590e.1698152926.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bdoShf7nd9kvEz5H"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--bdoShf7nd9kvEz5H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The synopsis treats the `--verify` and the implicit mode the same. They
are slightly different though:

    - They accept different sets of flags.

    - The implicit mode accepts patterns while the `--verify` mode
      accepts references.

Split up the synopsis for these two modes such that we can disambiguate
those differences.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-show-ref.txt | 5 ++++-
 builtin/show-ref.c             | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2fe274b8faa..ab23e0b62e1 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -8,9 +8,12 @@ git-show-ref - List references in a local repository
 SYNOPSIS
 --------
 [verse]
-'git show-ref' [-q | --quiet] [--verify] [--head] [-d | --dereference]
+'git show-ref' [-q | --quiet] [--head] [-d | --dereference]
 	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
 	     [--heads] [--] [<pattern>...]
+'git show-ref' --verify [-q | --quiet] [-d | --dereference]
+	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]
+	     [--] [<ref>...]
 'git show-ref' --exclude-existing[=3D<pattern>]
=20
 DESCRIPTION
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 10d0213e687..d0a32d07404 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -11,9 +11,12 @@
 #include "parse-options.h"
=20
 static const char * const show_ref_usage[] =3D {
-	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference]\=
n"
+	N_("git show-ref [-q | --quiet] [--head] [-d | --dereference]\n"
 	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]\n"
 	   "             [--heads] [--] [<pattern>...]"),
+	N_("git show-ref --verify [-q | --quiet] [-d | --dereference]\n"
+	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]\n"
+	   "             [--] [<ref>...]"),
 	N_("git show-ref --exclude-existing[=3D<pattern>]"),
 	NULL
 };
--=20
2.42.0


--bdoShf7nd9kvEz5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3wncACgkQVbJhu7ck
PpQNTQ/9HWRUAV8oZy0dXnOgYgF6SI40wvWDFJNwaUfbgaHRF7YaXb4Zfbnk/fKk
XsIwhmxaGPZVMIxmeKFjPG71L51V2Mx0+liZb1wW385plJtltJRWixHgldDQ7Sq5
rgj9+UnapaB8caRXjrOGUZUnELbpHFIojs3HVWhA81vqwGJLhIiGLCOK4MoGY6FZ
j3TGh7vgMdSyTL+Kg5yDhzScRmxge9dUPFu1Wp/HP0QBvW+pVZzvxzaFjx5dfES7
+9JRBShLGlxfmh0ZHObN2qSALpLP5vjokkWCorHJYIiXzVZf9Ooc3MZEyi/1LbFG
aW8uGAtIBQhPAYqbZIPBrddJRD0omsXJU6p0v3hbbE2zZBQ8Rnsi4eMHZyZw4K4O
WD+tIvQHsaUS0YOohhJX3jb97mQ7riTWvjeKSZsULS+UVC/inSX0hhPxpjHPS6dC
dgn+QVpr6/e5jFedCz8VC4wWNfbKT7q2XtcdpenXuIBN/8Gd4GobsJ0M5iL5ZaHd
rJ1RRoZRK1buiGerPazH/xq+HWb9J9SlaOZK9rMQmpScI+tUXLTKUqZbce2LOLQj
gkD3ASAEBIRZpibu7vNZgmuLYQ6445DKDpNM4O5M0CYyfxBG9XQ4SH7TIXsDZs1y
+p/GeSW5kMqWBdPQ0Y+I/vyv0U0GtygWpFgVai6nZF0nRojy6S0=
=pYmQ
-----END PGP SIGNATURE-----

--bdoShf7nd9kvEz5H--
