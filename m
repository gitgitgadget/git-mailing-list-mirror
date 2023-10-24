Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4D2AB34
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ep0nTznG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hlf1vd0k"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5737CC
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:10:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 165523200A22;
	Tue, 24 Oct 2023 09:10:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 24 Oct 2023 09:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698153051; x=1698239451; bh=VT
	enEgeHwZu7nfoC1A+Tfn0b5SAeBiTRnXl01bRmPVY=; b=ep0nTznGH5ATQRjTt1
	FwwlAS8iTuGmBFk3tXApRiRQhXVPfSnD7ECCGrCGUkTK0ho+R/DNSY6m4qgf9Kr1
	Kq9aTCWFbPur7uArxB6/gCe+zk6IpGXIwDt99b7tuZcAREDhZIBS1WqX3S5x6Gmp
	79NufUZz2OK7fvXFmuEMim8OXTpLpXcCqKmWnoLUx6+T9bEmF/duexCT9h/gEYdf
	jzoURZ5W2X+MLCC3GJ+vW6Xc3CrROrKAAMZWak/H1mxYcGuTqc7rvGwnXf5LEw3j
	VRCAhNZgf6qhc0DDjZ5yN2ABYJ8I9e9dDRFoL+VXqKhuPpJ3+aFid3pbLqwTe08x
	aroQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153051; x=1698239451; bh=VTenEgeHwZu7n
	foC1A+Tfn0b5SAeBiTRnXl01bRmPVY=; b=Hlf1vd0kpj298dFcWp1nhkVpaMk6n
	JfqJtl3Hup142yOF6FP1n6x2tWYX0vPVSuBbP5SQsMuOwwoWHJvHurY0AZKzIEaZ
	FnDddaoEk00P8fgWVGHeTzNfED7KEhq1uSUJiaf2/lRKfY+Y3daCanbDy45jlJbX
	sog8GMHW8C3nxEG1DKdGzN6zmV4+tLUMYMvIFYKmDunuuv7bTSVeOdKiSx3GKirs
	oPUmsZUC/gTIqK5C4hfj/uE94kwPDGkw9gixQI0C9hwq3oJWLZz9kb9IR6/k3wG+
	cuOHBowoM8s8DvfOX3j6pk5FPGdqia2Ld6ADpSJhUV321pJMac0onLswA==
X-ME-Sender: <xms:W8I3ZfkBkntRAMfyAJPjh0XgS6U1Glu4gnByZXyEFl4F_N0vFxbcFQ>
    <xme:W8I3ZS2pctL8hgEvIR8UXacMNIDl0NlwRcNaMm4gFWhsfMd5gJwfm7QO1WFBpUFvR
    cOxvvq6qFCY0r5kPg>
X-ME-Received: <xmr:W8I3ZVrOrJEHEg4IgwFoTC3xeX0TvvGEDNT8yLWv6_qmv5d32Pgu_WUiflOv-zZkWdaFjurWiAIHlHp7Dmfi230sO0HQxHbUm5I-JF6az04XeaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:W8I3ZXkk1NNVqfp7ioO0hovvIyWqx3rhX_0kvhrAzlQkEQMOAUYRLQ>
    <xmx:W8I3Zd0B6JM8bTU4OST7jvQhZrwEoSZFoYMYbyAwP8--9S9fB2Y0fw>
    <xmx:W8I3ZWv1F0qa00Z7gPlM3gXVYiRNrYEsdC0WgKjr2JPQ4ouUOcwd_g>
    <xmx:W8I3ZbCNzG6IQznOoX7lYREqAnx1hEPXOZsenULZdowQGxULmMaVIA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:10:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9ea4d88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:10:45 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:10:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 03/12] builtin/show-ref: fix leaking string buffer
Message-ID: <ae2e401fbd86500381ca9e579d40ebc4fd683f89.1698152926.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0wXBVZNL1t/Ks1Vr"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--0wXBVZNL1t/Ks1Vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix a leaking string buffer in `git show-ref --exclude-existing`. While
the buffer is technically not leaking because its variable is declared
as static, there is no inherent reason why it should be.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 56ee3250c5f..761669d28de 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -106,7 +106,7 @@ static int add_existing(const char *refname,
  */
 static int cmd_show_ref__exclude_existing(const char *match)
 {
-	static struct string_list existing_refs =3D STRING_LIST_INIT_DUP;
+	struct string_list existing_refs =3D STRING_LIST_INIT_DUP;
 	char buf[1024];
 	int matchlen =3D match ? strlen(match) : 0;
=20
@@ -139,6 +139,8 @@ static int cmd_show_ref__exclude_existing(const char *m=
atch)
 			printf("%s\n", buf);
 		}
 	}
+
+	string_list_clear(&existing_refs, 0);
 	return 0;
 }
=20
--=20
2.42.0


--0wXBVZNL1t/Ks1Vr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3wlcACgkQVbJhu7ck
PpRfcA//ae7DumzrCRAxzvyihYj/vg6IzNCdvS3LMuxAjZCKNyvGWxAkPumsq3tm
ZUNW3MGUlyEwexWc5hpprylji97gFfbZEXZK06Jf2t4hmJJBkkYAGbG4lmCvReSP
26Q6JE/OJfnUW3aRwI4k1s65N2Aa5PIDX1NxHlpXXGsjK44kmCCkp2mDN36rOzus
YeZRLzZY1/+OK2Z2UBnhXH8hSx6bKNMmevJpppwdr+KNSp/lkHvXW8aOvCsM0Gwr
FQgfBDe9gKTL/HexzwUexiRGiq9kGH/Eidjscn4fnNe/FE9DGDxCbe7Kx/HmG7C3
qy/RPHFGRbdwyciaSPde4FYw0JkJsyJffmx3ar3qew2eP/hFlg0Ukb/Ok02YJISk
Fph/2G0cCziieocvurPOEeDns3L8I5Vk8JGe79U9YXldk9ZIH7u/FX1I87TP+veN
rziV4wtl8M9ToK5YoA+2zNSaPWKgPoJc6HnKFo5Af/YG2fBxrU5FfnqPVR+THk6l
IUXwihshET54WfGtyId3UpNmsP/jP/PBiKJNxIiv95XqkEd7GNbOvc1uUn3hD91/
0ePdD8nitewiGMCoB641f8xuhhxVyK+xAEDxA7F5cnxdv8PA0JkLA8QqEL6/rbsB
1NpL09cJp34piYs7KV5lknB/E9dTCghl8dnIHSG92c2EVlrTfl4=
=eyPN
-----END PGP SIGNATURE-----

--0wXBVZNL1t/Ks1Vr--
