Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6551945C
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RsNRw75l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XY61Az20"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07840D41
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 02:53:39 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 7A3DF5C033E;
	Thu,  9 Nov 2023 05:53:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 09 Nov 2023 05:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699527218; x=1699613618; bh=Y/
	h83g2cVK1cUfW3x3k+6tWSuUa/mZxQS58zZInx4WM=; b=RsNRw75lBrMiK6+19n
	zheswOFKhu/SDeZ+dPThCsT1Olzgl2xvQnLmuN8W72ajwZfAewM4eyqAkf5US5v0
	JHZm2Uoq8HLlFlJiUReAJn4WVlSVx6ofdBBf2CEJ00SiMfsND7tfBu+S6caZigYL
	D9k5rdnSZMYBf1bSHUEc9knr7nYTRVLXvF/a3XyRXoJrJbplbFNVFUuUclVGwIsh
	mpuC387IoBP+hZJBlKnrfH8wrtouB+OVnsjUWgaK7tt9OB8xFN/D+zD2zKV1jYHC
	+JXRkvP1X0kmbce5P3z76yj8wHhu5hhr8IoUimnyAWwEP95ZeaOScmaAU6mj42xh
	nRjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699527218; x=1699613618; bh=Y/h83g2cVK1cU
	fW3x3k+6tWSuUa/mZxQS58zZInx4WM=; b=XY61Az20jmbJrSHRZ9yeI9GYS30Bu
	g3y149zoW8yenvHydOP0HGbzA5lVAbmBpTTLLp/xxKaemLe1sNmpopYTWy55fLDY
	Ny1n2cT9XE+RpxYm9khNUe/iI14t6p41FSQMKJQStq1awF/PwSNN8tYZ34iHPkkh
	VsvtLDpVeH1bm3cB3MFsrIiig630aUuQBb7wSMdVgQ9xxI0pyv3O9DQOnPfYGcrq
	qKpwRyVQfPiSZnuDBgE+g49t1PBa4RIyGxtP5yaPY2DmgzdDVQ5owmNXO9utpupG
	qaPftk7DGn49GT9vNXWire7uJWNTBjKzoZbkmXaoCb8WzxUlEzE7wI/ZA==
X-ME-Sender: <xms:MrpMZT5FFbLLsS3GoaOom6XRXnYxBmne5Jz2zi7BkjVEeKcbpyjuxw>
    <xme:MrpMZY5LYtBdwkn12jb_tXZP08jZU2pDDvPG8PL29ys7RpDBvzWF3bW1du8LmL1S9
    9xBNi9MxQYmA0M2Vg>
X-ME-Received: <xmr:MrpMZacXBMwSWipzLnmYO90aD_WL9L5ZDMUU4M9io-RlY-Q7AwXY4lfTvxj9v_yo80kFo2U9MJAqnfzYtT2zRnJ1EI2n20Jn_gfJpurPBZD49jZl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MrpMZUKI1W_ygLw-_aOez2N1i6TpebPQkO7tqwqNr8N5rNNAR9GSaw>
    <xmx:MrpMZXIUcosvTViHb3bH4ciTdYKX-vOw04wkao4mC3Bx_LeGWPJaSQ>
    <xmx:MrpMZdy87xO4qLeS5vwXIbeZxbBDgKVR-nIskxtji7lEsfaiVd6t9g>
    <xmx:MrpMZdiZCNWFX7bpXr_F2UW_wa5KRfwssR67imT0WEghetT5aUsOVw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 05:53:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92ec5bee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 10:53:09 +0000 (UTC)
Date: Thu, 9 Nov 2023 11:53:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] contrib/subtree: stop using `-o` to test for number of
 args
Message-ID: <b1ea45b8a8884d09ab070bb0f099834447d28938.1699526999.git.ps@pks.im>
References: <cover.1699526999.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MkGdZN/R0pbaDV8u"
Content-Disposition: inline
In-Reply-To: <cover.1699526999.git.ps@pks.im>


--MkGdZN/R0pbaDV8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Functions in git-subtree.sh all assert that they are being passed the
correct number of arguments. In cases where we accept a variable number
of arguments we assert this via a single call to `test` with `-o`, which
is discouraged by our coding guidelines.

Convert these cases to stop doing so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/subtree/git-subtree.sh | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 43b5fec7320..8af0a81ba3f 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -373,7 +373,8 @@ try_remove_previous () {
=20
 # Usage: process_subtree_split_trailer SPLIT_HASH MAIN_HASH [REPOSITORY]
 process_subtree_split_trailer () {
-	assert test $# =3D 2 -o $# =3D 3
+	assert test $# -ge 2
+	assert test $# -le 3
 	b=3D"$1"
 	sq=3D"$2"
 	repository=3D""
@@ -402,7 +403,8 @@ process_subtree_split_trailer () {
=20
 # Usage: find_latest_squash DIR [REPOSITORY]
 find_latest_squash () {
-	assert test $# =3D 1 -o $# =3D 2
+	assert test $# -ge 1
+	assert test $# -le 2
 	dir=3D"$1"
 	repository=3D""
 	if test "$#" =3D 2
@@ -455,7 +457,8 @@ find_latest_squash () {
=20
 # Usage: find_existing_splits DIR REV [REPOSITORY]
 find_existing_splits () {
-	assert test $# =3D 2 -o $# =3D 3
+	assert test $# -ge 2
+	assert test $# -le 3
 	debug "Looking for prior splits..."
 	local indent=3D$(($indent + 1))
=20
@@ -916,7 +919,7 @@ cmd_split () {
 	if test $# -eq 0
 	then
 		rev=3D$(git rev-parse HEAD)
-	elif test $# -eq 1 -o $# -eq 2
+	elif test $# -eq 1 || test $# -eq 2
 	then
 		rev=3D$(git rev-parse -q --verify "$1^{commit}") ||
 			die "fatal: '$1' does not refer to a commit"
@@ -1006,8 +1009,11 @@ cmd_split () {
=20
 # Usage: cmd_merge REV [REPOSITORY]
 cmd_merge () {
-	test $# -eq 1 -o $# -eq 2 ||
+	if test $# -lt 1 || test $# -gt 2
+	then
 		die "fatal: you must provide exactly one revision, and optionally a repo=
sitory. Got: '$*'"
+	fi
+
 	rev=3D$(git rev-parse -q --verify "$1^{commit}") ||
 		die "fatal: '$1' does not refer to a commit"
 	repository=3D""
--=20
2.42.0


--MkGdZN/R0pbaDV8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMui4ACgkQVbJhu7ck
PpQ9Zg//btRdmAFuCyHa3RayVyoP1RpUQP7wdJrsqIFDrH57G7t4LVBObHChgSDy
UGbPlaCssbDOx78rnNZ1sWmw9uRHduBrfhyDX2zw6LRBp/vMncEhkg2Tnss5I/pc
tSvJlVlmKCEndSt+terI+CqDu3vtcIsWwPv6ycLCwIsuVwN1FUZfrysMlDYIw6Ih
gZIjgBnBz0tRuzFlL8qAlFUu6hBIJjfUhkcoXCmIYK+gK8dQuZdXiLK6Qmako70T
3Lor9MY8wUZzBOYls2h+KLgXt08koKYn/Pb5TWk52BU0TmEnG6TRv/rnnZZAWhcg
htrqA/WpPZYtxWTrrupC4YLLT7pDp7fwjEgo9RdxdDz85Zt057QXvuIcYz7D5jG5
uEOHDdbLQhqnT52oqq3YnGz9iWyYhRkE+0kso7WofD9w0m1a7ecC54LluW25ia6j
FvriG9pJYwivx0ejj2N7x2IWiLKiA1LY9YlLwigV5+EOtrdeiVINV55fvhXSgvgZ
Fm9ysVQ0iy+bUqizwwUOyk1SQ55CuCgTc2misoW7bPHMBgbkY8Q8WDF1Czz0pSPR
0p6Vhb3o8AeTfh3qKvNl3gGhAZawil+Tx29rfUKq55npRDNN6K6G0Cwvq5qDLbdQ
Bhb8SAJudVc7wQ9VIE0Q+fh+VivssIRTCHbIgdC1p7XGar02Gms=
=qWb7
-----END PGP SIGNATURE-----

--MkGdZN/R0pbaDV8u--
