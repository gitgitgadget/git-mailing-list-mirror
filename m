Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qvux8dDI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pWH4gdOH"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EE2C9
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 23:25:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 2D1305C01BD
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 02:25:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 29 Nov 2023 02:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701242721; x=1701329121; bh=sc
	3/L+1ThrFBgHzQgfHSmwz3Oy722pUuGAUEge/Phoc=; b=Qvux8dDISMspegEwd7
	9QJE34DTTEVK5+qAj01uM5HhPNnpyYewnBVNTBqFLFuMr0Y1chDG3mxJQGmyrMAQ
	H5OdU+9b2PEstdHqWFLeXyi+FPSCBx0UAuV7MXtsn/6WErJyFAQ8V7Pf/fL0mRyD
	GNij3pj/pOeDctG9KAQrQPaihqGYC6ufhd50A4ib+NLwp1ayufTIZqeLa/Mxkpso
	VtxVuw2SzCCvhgk0fA807RRDTmNqQOEs0es1PZP1J6wG67yNzxguadJgpWI2RVba
	OW2CX0fW5gafRkr5LI/Z27LGTgPo7A9poFLYRObXS2nyuVzUnNE2NtbWE93bdJBV
	goYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701242721; x=1701329121; bh=sc3/L+1ThrFBg
	HzQgfHSmwz3Oy722pUuGAUEge/Phoc=; b=pWH4gdOHWwqHk3q79BVzf5ebX4aO7
	dWUKLthx19kE0pZoU5gPS3I5MYf4FqIQpMTD7NnKy1eJqNfmTNmrsAKLRbVq8gPM
	OmEbNEs9743Md65oGWvInVdNNoyN2dVEmU2e8YgovFzip7Xl0jvWcbOlgqsvghxR
	KVyBKRBbwbC/TLI4+Q/t5D9XmhU/yohC1PQlcTe+DRCFhHw75IiwLjxV6FN7HzBz
	3SADmNZcNqnr0V0Ftkthc9xLwb3n8fwW1oACoop2PM6UwLxpxBgBFBVVmiRGUO1l
	dLREl0RaRcZfni7ccc84d7exngFUcaZVJ/JN3Dgh3HibF4+cy2Bzegl2A==
X-ME-Sender: <xms:YOdmZeygDDjBQreG8GLDNmanlY9HD-2zdUm25SPBiyBX8W1BlZbRxA>
    <xme:YOdmZaSoen_ESC8tdgEhqEKrn5F-7Yq34IA9WxRYVJQabtl7V8HnOVH0p5ZjUTbQl
    fFB6QBmIrvwtC-4cA>
X-ME-Received: <xmr:YOdmZQV-TSEg7zpg7zoAP4fjtVhY8bYS7OIlUxpFyjV0DA3kqKEjh14dvWluwtyVVKsHkyG8vq8JovJ2ElmrhHe6oaQ4q6sqcufudmOoJ20uzl8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:YedmZUiStpQ2MW0cqjdkZUBlymAGk2e177lH5TZOksktGlRPCIBNYg>
    <xmx:YedmZQC9zN8KNdege9vwbOVK12LsrhTf83S3ntAkmuezmo5TNd2ZaQ>
    <xmx:YedmZVIV4fjW1RI5DDNTRhvvGml0eKAPLRJ-B7kAur7BvZgZgcibsA>
    <xmx:YedmZf_LBUnq7MKrglm9niHnoxD7Tc7ik_cKajnkdrC-rbwv6kMdig>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Nov 2023 02:25:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2b0e8051 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Nov 2023 07:24:09 +0000 (UTC)
Date: Wed, 29 Nov 2023 08:25:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/10] t6301: write invalid object ID via `test-tool
 ref-store`
Message-ID: <281d9a719d39c03572de53bce5388acc7236b274.1701242407.git.ps@pks.im>
References: <cover.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m3Y6ahgizBsQzZi4"
Content-Disposition: inline
In-Reply-To: <cover.1701242407.git.ps@pks.im>


--m3Y6ahgizBsQzZi4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One of the tests in t6301 verifies that the reference backend correctly
warns about the case where a reference points to a non-existent object.
This is done by writing the object ID into the loose reference directly,
which is quite intimate with how the files backend works.

Refactor the code to instead use `test-tool ref-store` to write the
reference, which is backend-agnostic.

There are two more tests in this file which write loose files directly,
as well. But both of them are indeed quite specific to the loose files
backend and cannot be easily ported to other backends. We thus mark them
as requiring the REFFILES prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t6301-for-each-ref-errors.sh | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 2667dd13fe..83b8a19d94 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -15,7 +15,7 @@ test_expect_success setup '
 	git for-each-ref --format=3D"%(objectname) %(refname)" >brief-list
 '
=20
-test_expect_success 'Broken refs are reported correctly' '
+test_expect_success REFFILES 'Broken refs are reported correctly' '
 	r=3Drefs/heads/bogus &&
 	: >.git/$r &&
 	test_when_finished "rm -f .git/$r" &&
@@ -25,7 +25,7 @@ test_expect_success 'Broken refs are reported correctly' '
 	test_cmp broken-err err
 '
=20
-test_expect_success 'NULL_SHA1 refs are reported correctly' '
+test_expect_success REFFILES 'NULL_SHA1 refs are reported correctly' '
 	r=3Drefs/heads/zeros &&
 	echo $ZEROS >.git/$r &&
 	test_when_finished "rm -f .git/$r" &&
@@ -39,15 +39,14 @@ test_expect_success 'NULL_SHA1 refs are reported correc=
tly' '
 '
=20
 test_expect_success 'Missing objects are reported correctly' '
-	r=3Drefs/heads/missing &&
-	echo $MISSING >.git/$r &&
-	test_when_finished "rm -f .git/$r" &&
-	echo "fatal: missing object $MISSING for $r" >missing-err &&
+	test_when_finished "git update-ref -d refs/heads/missing" &&
+	test-tool ref-store main update-ref msg refs/heads/missing "$MISSING" "$Z=
ERO_OID" REF_SKIP_OID_VERIFICATION &&
+	echo "fatal: missing object $MISSING for refs/heads/missing" >missing-err=
 &&
 	test_must_fail git for-each-ref 2>err &&
 	test_cmp missing-err err &&
 	(
 		cat brief-list &&
-		echo "$MISSING $r"
+		echo "$MISSING refs/heads/missing"
 	) | sort -k 2 >missing-brief-expected &&
 	git for-each-ref --format=3D"%(objectname) %(refname)" >brief-out 2>brief=
-err &&
 	test_cmp missing-brief-expected brief-out &&
--=20
2.43.0


--m3Y6ahgizBsQzZi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm510ACgkQVbJhu7ck
PpRSCRAAj4A5tFdc102vqHEyVgmgOnqa3ivIvxzXDLGwnsgXh2urrNHCWmOgQvtq
Vcn1rfc7qRFb8S7cUV3FbrzjCPPug4t2pnpRxeT/L5Tj9mb49eQ9GpmYiwg3/zI5
CGG1cHjBqaMz1fxbDi2A2BsmTlJDlccGDnf027uA7QkQOuBpLO6E/zuv0azyTsDh
0MRHzkjH/ChfbNIY0c1ScE2BXT8MABVIkKRRccB1VFIqEgDT+fyku7FptdX9wbH4
GlKVTexeSd9V9gclyHbgvdTmKjP91vMwclKJZsJfooXMvpaPeUgcgs+oOs3OFV9K
uiCmrSKkJSkfnv2xI5efEsAyaGTgBHaaskTBeKrVqQhrs1rV+hJMhQzxGNcIDrfc
qw6oTvsJmnOoQ62KHpfjfnauyt0LXDMArCXrka2eHn8460hQA6qS9p6pCWDN6l1e
0y8WPmUw6gih+aB4RdmyUSdccLaBQEoHte97eVvDYWWEEywI4pTyVjyViu5TmD7Y
OsLi7GQtGWFDmjn/Cwo3cXZI5hYl0RKecGqR5hLLolWSJ4OJEjwzfy3Kvxn1jQEC
Vl3adm9+BBZcLA5LQHMcwJzEgAP1fep/4A7oE4nB9Jx3bdDstEz0WQhxG8M1eKiv
CcEMQ0R33OtSliMmhczl38xuL+tzQ7JNsJGlTHhD5g697L+17/U=
=xYOo
-----END PGP SIGNATURE-----

--m3Y6ahgizBsQzZi4--
