Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB90518037
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tN48tv/T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OjkgE6LO"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E332A4
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 02:46:00 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id DD2AD5C00EF
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 05:45:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 06 Nov 2023 05:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699267559; x=1699353959; bh=kr
	a+Xlj7DEDE8/DG17hUnm+U2ONaaOlbeoLem+BlXmY=; b=tN48tv/ToIW3RdCl9S
	AHN5rL9Y9NukNWlswf1c/B14ggyHhrVfbBhOpSarg4oAWePmJvW0xP4mOE4ryPrW
	GLSAbDiTK0jyibKpTCDNWtkJcxnJI3uh5krsrTs3Ub9+nKrVgXXmKdJysJ7Z3ta9
	2Jhk2Dp04xWqL4kHTpduvnF2upnMLWQl8kG7lgi25VhAiGtiyDA4z3+mWqFUbzPy
	1mQHjXSJIVWMCXUlHXMP9o2/bf3SRogKOAcsRwOtaLedxwf6CeWG3yMuLIp2pB/m
	V4oVw4rdgw5IA+AHwhIg9ePP6TqTtVRbJKfbrONxoRsl8K24aKYQITt3JugwJl60
	rEgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699267559; x=1699353959; bh=kra+Xlj7DEDE8
	/DG17hUnm+U2ONaaOlbeoLem+BlXmY=; b=OjkgE6LO4lqySyGtwlc5cpAMWgj9h
	Fisq/+z87QMKKaEPH60Z+8kGfXN6t9USod7U8w5/BlGimIvD0CKsAHBYcptWf/JC
	ImgU4r3zcFNIJa0z/cVq1H7SdtKsXWefBOvWqsmi1B/+HoRlrW1Q7dGGIi1nGXRU
	D0whYuBpC8CKpL5HsKVoellxv/r7RntviHiIqgj49gQC5njq1e5jp8K4lnZCAAtn
	5fe02gZ0SvSIlj3+Vf20C5M3oekjC/Q2UQQbYf7i2t2Le8zH4r6roDJmnDEhxiFV
	mIPPbHbTBzob+eXpJph/uplshTO64ABe4+fHCeEbi1iFlB7MyL0mvJjZA==
X-ME-Sender: <xms:58NIZTvEcLIGFmLECJFAUuOSA6W5fgQak0gxmt-_OsVeW9SZzk5uZQ>
    <xme:58NIZUerqqIm0PTDw44dH-SXCV56SB1GlYsiGz_MOsEzrJwdwCxeWQIqwJsOPiPSZ
    naMXXF73GEbqjKVag>
X-ME-Received: <xmr:58NIZWwPYQf3Q8MY_ZX15MBTFszdJfXzhEboZO-N_KbRQoi7AuBmVYg33538ouPupAg-VJk3UlKBGYY_hthdVxhr50IY26La1B9SJahW2hh6v3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddugedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:58NIZSMFonz05gJMxRqqZXRZZjGi2ZQeiGq3jjCWELXNwO7kdJ9Bhg>
    <xmx:58NIZT9mIfQSDUdcl_hnfLmTGW4LTq_YI2krukDpinh89-SVPtpR0A>
    <xmx:58NIZSW_D1lcyL4l00XINClITKBj9NsLIvzztAHkblga4dP-LR5gog>
    <xmx:58NIZQJgaEIdAMkIKyDVlLWssrA0k-qdecv96Ft0Q0eHYNrJIBxRZQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 6 Nov 2023 05:45:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1e23c228 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 6 Nov 2023 10:45:38 +0000 (UTC)
Date: Mon, 6 Nov 2023 11:45:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/4] shallow: fix memory leak when registering shallow roots
Message-ID: <137c150e358a8248200e0c7174a79358adb92e45.1699267422.git.ps@pks.im>
References: <cover.1699267422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hi2yQoDib1vHVJPJ"
Content-Disposition: inline
In-Reply-To: <cover.1699267422.git.ps@pks.im>


--Hi2yQoDib1vHVJPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When registering shallow roots, we unset the list of parents of the
to-be-registered commit if it's already been parsed. This causes us to
leak memory though because we never free this list. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 shallow.c                       | 4 +++-
 t/t5311-pack-bitmaps-shallow.sh | 2 ++
 t/t5530-upload-pack-error.sh    | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/shallow.c b/shallow.c
index 5413719fd4e..ac728cdd778 100644
--- a/shallow.c
+++ b/shallow.c
@@ -38,8 +38,10 @@ int register_shallow(struct repository *r, const struct =
object_id *oid)
=20
 	oidcpy(&graft->oid, oid);
 	graft->nr_parent =3D -1;
-	if (commit && commit->object.parsed)
+	if (commit && commit->object.parsed) {
+		free_commit_list(commit->parents);
 		commit->parents =3D NULL;
+	}
 	return register_commit_graft(r, graft, 0);
 }
=20
diff --git a/t/t5311-pack-bitmaps-shallow.sh b/t/t5311-pack-bitmaps-shallow=
=2Esh
index 9dae60f73e3..4fe71fe8cd2 100755
--- a/t/t5311-pack-bitmaps-shallow.sh
+++ b/t/t5311-pack-bitmaps-shallow.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'check bitmap operation with shallow repositories'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # We want to create a situation where the shallow, grafted
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 7c1460eaa99..de6e14a6c24 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'errors in upload-pack'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 D=3D$(pwd)
--=20
2.42.0


--Hi2yQoDib1vHVJPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVIw+QACgkQVbJhu7ck
PpRebBAAklf5+yafwW0+ndQfZC9+Vjb7oBPUkvane5yu4qmc0QNUlcsF30qyJGWH
Uj9xTDmn12Tpi3dbVi4Q821oegDR+NuqO0Pyac/N4N0oUVPF9B1K/7+fHTevjV0S
MMfc96ekGSV2Tj0f+XVaxncAgnZu02eDNNUvBuG9Ay2xMk+y8guoYAqUdZqwkrbd
WCOciMkvGAox2mO8b4Rn6HUzQAaD5unGXDEPSt+7QKFb2JYzPTgFv4ISHP+EHCbz
zwbkcQYX7YHyZTehPu38Arz1jqWKJagRQn+PbG9/0W6eX9CW/qw/rqTlCZBy2q+p
71qLylX4HXnLBLeTIp8aUcJcswaoiuzFFJMlRpWJO0u2pIjvtPXlAFZoBYLN5E4u
+6uYOaylSSizoiz22QWf+aPnEtpSQ0gK1K7V9tVkSnou1eNha6vZnXFe5pCiEHpL
RZ4blhDpSyWT8jRheQ64o/ajCATHdOmt/86bBaM6GU+/LMam3IrrGj+iOnUiOMUm
L/4VzjhQjSdrK6tW1oCyq30+mXLOqAjgRmTX5rQZg3X0acHsy8NDlHREPtrO/hb8
S/f75bxC/7hrUKqVLpoYEKqblJ4P7bQgYw86jvmLkEEYNMlBTb/uMavj5oHfQhE4
dGOZwNFqUaZEd5G+EbqqWIbtwzPCdv3Ntt8+bq7MRxLczDdbsHQ=
=OTTS
-----END PGP SIGNATURE-----

--Hi2yQoDib1vHVJPJ--
