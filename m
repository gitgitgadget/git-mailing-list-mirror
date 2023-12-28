Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD6279D0
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BeawUD0J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJ53jaGo"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D234C5C008F;
	Thu, 28 Dec 2023 04:58:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 28 Dec 2023 04:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757480; x=1703843880; bh=Z/hQyBWp18
	Rw5GU6COfpuWkmHZYhqGfO2j/JNdLBOs0=; b=BeawUD0J3abt8hLZYxt1aaWN3v
	lMI5JFW8bSSxUB4MsfasMlxUqwrKEXogVxcwaqmLlr+mxC0DA+xKNDnudBK4+OeL
	XY9fjYErkQa3acaYcCBtesNKxuLxLQeNqUQZ47MrlzPxYVVyyqQYOLwOPw+5gxn7
	7mxDxqkHwOsM2GOEu27WIooqFseXzdvqh1xb5jCUcspKU44D2cBYIPCkQZTSkW/7
	fVnPuPKPY/pSeDLTucz2oqCVi8n3eUkGQY1JGN6Ad9eq8NQMMVqmS5LkeK6EWVD7
	vU65ujoMM5uZy0UbIZ8jTppRVuzv5jKrS1moLznpG122q55THCNsSrkX7Q6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757480; x=1703843880; bh=Z/hQyBWp18Rw5GU6COfpuWkmHZYh
	qGfO2j/JNdLBOs0=; b=GJ53jaGozkbBPUzkxPx89fpCHJwnIGx94aafr2wtHAmz
	Ry7zNECmqu8oZQjq/FnyQGLNewJ+WB3N9+e2EpAqa7BWfXWG1B4fGWtioaqODg8x
	kDrpDeS+7YA74enPtFv/JD4Ar9uA7avOKmqyWTaHeUQwMwJ++j8btjZIdGKesmap
	BjnsaUycbtyIjDW/2ybDNUwatZuXX/W++A9BODIgdf3+fn+I3hlCGn5EQOKFu7KH
	qteh7LUWfb36w3odEPupXbtvw+S53tUiuQMGaONGuWGCTTfF52il5iTyUygh1paf
	iX8X+hReXhJxW8OqCZAbR56mJvtL+B27pznXJhO+Gw==
X-ME-Sender: <xms:qEaNZUI7VajJCCT16624MPJbtXRjpbH2QgkqOuVyQdwq3yDqofx8-g>
    <xme:qEaNZUKjVWTHCAdWsbGmgM1YYQ7_M-IZRYXRwyE4STPqZljfp_Dpoo-C4eaqo6_tF
    emGTOT0C3eWc3Rr1A>
X-ME-Received: <xmr:qEaNZUsnXF2Z25OEoJMRnuvFcQIROVAK5mINkQFFG-vY7mTD_Mv2eFuoHxrm6fTn50Q2s73YAxYupe4wXr02OPFZ-Yro178ddhoJuQ-L6ZJTkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:qEaNZRaJkRNKOqhtZnJqAAgv84KpSg5-cEwKijm01ubgWsUs33U6wg>
    <xmx:qEaNZbbmrMbiV-Hvj2zt_Kip3Y8QIkWt6FaKi4XRpcc6TIm8D0CdSg>
    <xmx:qEaNZdBblPMo2Yc4dSgRuPT4knsxqYMcZ5wcLgHyhO11hRbDUA4bDA>
    <xmx:qEaNZSxhbH9Vtq3Y95yqXuqT1zY06kJrJHshQlo1P2KXU55bS3dihQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:57:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f38d50e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:55:46 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:57:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/12] t: introduce GIT_TEST_DEFAULT_REF_FORMAT envvar
Message-ID: <c645932f3da2395b7fdb3c8cdb28a341f8a6ae47.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hyNII+1tt3i+OgB7"
Content-Disposition: inline
In-Reply-To: <cover.1703753910.git.ps@pks.im>


--hyNII+1tt3i+OgB7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new GIT_TEST_DEFAULT_REF_FORMAT environment variable that
lets developers run the test suite with a different default ref format
without impacting the ref format used by non-test Git invocations. This
is modeled after GIT_TEST_DEFAULT_OBJECT_FORMAT, which does the same
thing for the repository's object format.

Adapt the setup of the `REFFILES` test prerequisite to be conditionally
set based on the default ref format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/README                |  3 +++
 t/test-lib-functions.sh |  5 +++++
 t/test-lib.sh           | 11 ++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 36463d0742..621d3b8c09 100644
--- a/t/README
+++ b/t/README
@@ -479,6 +479,9 @@ GIT_TEST_DEFAULT_HASH=3D<hash-algo> specifies which has=
h algorithm to
 use in the test scripts. Recognized values for <hash-algo> are "sha1"
 and "sha256".
=20
+GIT_TEST_DEFAULT_REF_FORMAT=3D<format> specifies which ref storage format
+to use in the test scripts. Recognized values for <format> are "files".
+
 GIT_TEST_NO_WRITE_REV_INDEX=3D<boolean>, when true disables the
 'pack.writeReverseIndex' setting.
=20
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 5eb57914ab..a3a51ea9e8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1659,6 +1659,11 @@ test_detect_hash () {
 	test_hash_algo=3D"${GIT_TEST_DEFAULT_HASH:-sha1}"
 }
=20
+# Detect the hash algorithm in use.
+test_detect_ref_format () {
+	echo "${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
+}
+
 # Load common hash metadata and common placeholder object IDs for use with
 # test_oid.
 test_oid_init () {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4685cc3d48..fc93aa57e6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -542,6 +542,8 @@ export EDITOR
=20
 GIT_DEFAULT_HASH=3D"${GIT_TEST_DEFAULT_HASH:-sha1}"
 export GIT_DEFAULT_HASH
+GIT_DEFAULT_REF_FORMAT=3D"${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
+export GIT_DEFAULT_REF_FORMAT
 GIT_TEST_MERGE_ALGORITHM=3D"${GIT_TEST_MERGE_ALGORITHM:-ort}"
 export GIT_TEST_MERGE_ALGORITHM
=20
@@ -1745,7 +1747,14 @@ parisc* | hppa*)
 	;;
 esac
=20
-test_set_prereq REFFILES
+case "$GIT_DEFAULT_REF_FORMAT" in
+files)
+	test_set_prereq REFFILES;;
+*)
+	echo 2>&1 "error: unknown ref format $GIT_DEFAULT_REF_FORMAT"
+	exit 1
+	;;
+esac
=20
 ( COLUMNS=3D1 && test $COLUMNS =3D 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_CURL" && test_set_prereq LIBCURL
--=20
2.43.GIT


--hyNII+1tt3i+OgB7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRqUACgkQVbJhu7ck
PpR0kxAAkJOxb1gOJ1Q3mGB4HuYO5udb8fjkc9wgR88sfg078rgb3fxBeuh6Xtlp
6xyDSlXeD9OLLIX9yMHpsf9UItzoCL2ufpLSyvtPO3tVNoZRR0NWkGBHTrIv4LLB
IcET3ZF5Jf4teuSCEyJ4yzKH93LrUY0wocvsQ4MmER0l/9zBwFvBRJF4tS0TgZqv
cRb2FlChobY4oPKeT8DutXMvBNEuAkTLk3QQi9+xbAMCzY5Av5yTWIrCGRZzTbY/
28eyDQoeQV+OrR8es3+xQv8x6G/XPTmF107ElfL9popSTWGX8Ex6VtleD9tmF8fw
6bZTDkl5G+aCutU548rGM0e7ba50tsfoDO0eTs+baO1kRKMVcQt/+heukrJXMNmy
VWItar5Lp6hZ7JFv9+36eNyBrW9xqKXKL/0Kq/zyO9ztHjuPsLaoiJ2PM1sYfcki
hzz/LIXmiiJ1QG2+K1zwLm2z7zQJUzMmko7oRPm0Pr5fU7bCrInlDb4vqmpe2Utp
qU2VbiuHFbhaiyE52bMBKPcM/3gufld+WO43eUvbKiCS/fZep660qHG8Kgwsn2Eo
5udID7lbVXuexGfgjI5U+HkKOob1fajGtnr5vm+8VWfh3s6K839YDPyBBOtrlyEn
7fXuSP1a3+jY/yHUDrI44uTK5mwpSn9MaAS/H2tkZ79cQV7D8I0=
=XUS/
-----END PGP SIGNATURE-----

--hyNII+1tt3i+OgB7--
