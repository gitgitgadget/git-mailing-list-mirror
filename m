Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B258DDDA
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SKO8/8Y1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L2pBAYWa"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1E6272C
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:09:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 533175C0358;
	Thu,  9 Nov 2023 02:09:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 09 Nov 2023 02:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699513795; x=1699600195; bh=M8
	h8czmMrVFMQ+BEdP4XFAN/x98Aex9MteY03N0xlvM=; b=SKO8/8Y1mqwmORR/ti
	9LjkKS9L6Obto43pD34pOy/lssE6rjdCclxQBfucemF6Ha9Q7LmL+tcVNoJk76yg
	5hIGISWeYP2Wo/8qj5fLq6cCPK8HTLsR0RI9jhTJ8u3dAHi3SPTyTVMF6uDjnXrs
	xGYvCkgAcchYsTM3Wcss3F1fakiHUUWTm1BSoDM/j2o292C9a+UE+aUfsDGbeYmb
	VOUVfe89vfk2OZrEKWmv/IrVzLPT2Ir8E88oHSSBwLpJjmdWl9uNRSvq33tM6FPr
	I6U8gffs9n4YJVah6pe3oL0qVN65l2nbGalZxRz8FcxplAFPPqfJgPVOzK55Ai48
	s75g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699513795; x=1699600195; bh=M8h8czmMrVFMQ
	+BEdP4XFAN/x98Aex9MteY03N0xlvM=; b=L2pBAYWavY4K7penhOuH5gSiVtY/l
	A0AkyibndCgVk9kwrn4ms0M/c49vGgvKdR2mx8XQk23HImTyqTVZ3/WeBC74eLTU
	zoHiuLiU+lMFpU9/CcAYt3s7/OdYOCSoRzk+CaNvF6OYcUKol7dl2FwkmS3tmUt3
	VEVqFdbzAhAQnpRpUfvKQ7dUtqkKq4O/rUnVqsR4kG35/Yrpm77zwBn+wJbJX3Mj
	92Rf8PCJ40x2iOCcXWXjF8euEbFwVgdTFQ/78nsj7zuMOzaMxOj2lnrShA5WkyBz
	5tBwLDTx1SLcDgzpHElVEUoGJZjwr+zfD1NPC88D+oe6YHSuzRXnrADXw==
X-ME-Sender: <xms:w4VMZQUBZIV51LiCz1eeOpd6caO9_ESNhgW1aneYdnTBRVm_GFjSEg>
    <xme:w4VMZUkJETNladt-oByTxl-K0MQX2Psu1hiiw4CzXOStcDOQyB-b89hJw5E4E8RGz
    G8YEMMc3G6eQTDUkw>
X-ME-Received: <xmr:w4VMZUbiROEInTVYZXgvjXUjyZsXGNE8YAxBMC9zD52_-VTtfmq7gOZP08n33Whb8r31neYaqwyv1svxR7lvQI0whcfrHTRbJa7ZxquwtpQaKXKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdehteeggfevueevhedtleelveeigf
    efieduiefgvdfffeegvdeitefgteevveeunecuffhomhgrihhnpehhthhtphgurdhshhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:w4VMZfWnCl-Jc4Hv6XhHtoKFf9DYDzPAawCVWk4EPjIr6efnac7xAQ>
    <xmx:w4VMZallj5JGWGQvS6frwSuNWDKSjiuwrHozKf1T2pLXDySWZq3y6w>
    <xmx:w4VMZUe7FgPjrqnsRueAysap1ugg1CYr_TnHMPYFQvem1DMoYzyxMQ>
    <xmx:w4VMZevccGskq18FayuMfpewTqCGu3pmU7qiqGWp26qEvoNHa1D1Uw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 02:09:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ef8046f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 07:09:27 +0000 (UTC)
Date: Thu, 9 Nov 2023 08:09:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/3] t/lib-httpd: dynamically detect httpd and modules path
Message-ID: <e4c75c492dd89fd7464db2b3028b2bb9e6addbf8.1699513524.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699513524.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vyQneD+SwPOvcMc3"
Content-Disposition: inline
In-Reply-To: <cover.1699513524.git.ps@pks.im>


--vyQneD+SwPOvcMc3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to set up the Apache httpd server, we need to locate both the
httpd binary and its default module path. This is done with a hardcoded
list of locations that we scan. While this works okayish with distros
that more-or-less follow the Filesystem Hierarchy Standard, it falls
apart on others like NixOS that don't.

While it is possible to specify these paths via `LIB_HTTPD_PATH` and
`LIB_HTTPD_MODULE_PATH`, it is not a nice experience for the developer
to figure out how to set those up. And in fact we can do better by
dynamically detecting both httpd and its module path at runtime:

    - The httpd binary can be located via PATH.

    - The module directory can (in many cases) be derived via the
      `HTTPD_ROOT` compile-time variable.

Amend the code to do so. The new runtime-detected paths will only be
used in case none of the hardcoded paths are usable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-httpd.sh | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 5fe3c8ab69d..6ab8f273a3a 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -55,21 +55,30 @@ fi
=20
 HTTPD_PARA=3D""
=20
-for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
+for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' \
+			  '/usr/sbin/apache2' \
+			  "$(command -v httpd)" \
+			  "$(command -v apache2)"
 do
-	if test -x "$DEFAULT_HTTPD_PATH"
+	if test -n "$DEFAULT_HTTPD_PATH" -a -x "$DEFAULT_HTTPD_PATH"
 	then
 		break
 	fi
 done
=20
+if test -x "$DEFAULT_HTTPD_PATH"
+then
+	DETECTED_HTTPD_ROOT=3D"$("$DEFAULT_HTTPD_PATH" -V | sed -n 's/^ -D HTTPD_=
ROOT=3D"\(.*\)"$/\1/p')"
+fi
+
 for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
 				 '/usr/lib/apache2/modules' \
 				 '/usr/lib64/httpd/modules' \
 				 '/usr/lib/httpd/modules' \
-				 '/usr/libexec/httpd'
+				 '/usr/libexec/httpd' \
+				 "${DETECTED_HTTPD_ROOT:+${DETECTED_HTTPD_ROOT}/modules}"
 do
-	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
+	if test -n "$DEFAULT_HTTPD_MODULE_PATH" -a -d "$DEFAULT_HTTPD_MODULE_PATH"
 	then
 		break
 	fi
--=20
2.42.0


--vyQneD+SwPOvcMc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMhb8ACgkQVbJhu7ck
PpRwuA//QLBOHvZx3fZcTWBgEwmK2Brv6SIWpg7WISrTAjmzmRcM5PmUXmXVZmG1
Tq0lGg/4KEl1cigZSzSehWCrAQJWSm+IV3psU/F7psbfwQSa/wmCKjIfurEZpti2
2mbpKZ3dlJZR//Vh/Kkgm9MEatcQU5nkAF2wDfTPfnP7AAQetZvx1rubIdygM+CG
vdTi2yyasfqq1JiTBEJ89Zz2fz1c/it2A4o3l2rVoyZrBV3wsxjtQGaA5VhlO4M5
Tby9GeGCPIDRBGqV8RoBrspujMPrAP3/eOh+FrKArwlkvcrDu5eD/EKMSdZRAISs
CfvLuoUwD1qhd7TnSo8+7l5z3URDLLw1Cy0JBNiidQpg5avDOlixy4qwztm3g6zn
AhZQj2qVcqPmoVtXctaHdJ3Li31uqq7KZhlwgCRlAyZwRmakSeDa5BqYpgCo6kHO
bY1gtiyi3FYyzW5BV+4q5oSwxXrgvC9g55JtYVogB7thVp/ehz+tC5kS5fz77pPw
RpUbKuyO8mywTFbKHAeF994MY9ViPlmKejvNxW/RsRJmi8bZ/4ngVHaTfTOZXn4Z
YlNo9Rzfohg1fjjgrOmbkrqK9XtI8HQI9RIKmcr5rsceNGJSk69U2IvlbHfjTDAQ
kzI+zXZg7CaWARIkVnLwnQknyqUg58PnFICu/r9yw/DQclezUGY=
=nxF1
-----END PGP SIGNATURE-----

--vyQneD+SwPOvcMc3--
