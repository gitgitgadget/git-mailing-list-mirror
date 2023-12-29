Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFFBA46
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w73znwN/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RdUQkY4c"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 37E945C017E;
	Fri, 29 Dec 2023 02:26:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 29 Dec 2023 02:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834819; x=1703921219; bh=6Dy5s1J3jF
	/5HelEJJfgOAWKV8o/Ta8qzTvMohDKKSU=; b=w73znwN/9QPAUGTM0riVOQi+DQ
	nWMidLOo2jeRl8gPYz0ShVLCv22aNQakZLzu/NTIiiQujnk1+0CCBjpaAfzdDC6O
	4oSypW/DFF37AteDWBtLjee9paTIyiEmmU/TqJFUI6HOKI1653+cDBaYf/46ZKuP
	quZrVAvX8SDFIH9CQT7ZcFYLghRuZSWnraowUb+Cc7uP/CbWFGgxq+Aw938Z9R8f
	AZ5nU9peVH5HuTBvJosGnZcJJgfP0LHDvXBMwDzUvtzX+PQEYuYDoOQSR+lLZGzz
	rbBY1hCOtV+T3bOugYWLPBMlSFvSRkb5D2xoVwTn65H4cVVzQzrruNhGLUVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834819; x=1703921219; bh=6Dy5s1J3jF/5HelEJJfgOAWKV8o/
	Ta8qzTvMohDKKSU=; b=RdUQkY4cKq/wTGVNdSAEYvcb5MtTqhrKH5CAGHkKn69B
	QztGRPeJlhHqeIZgh1KAUbV6okRMgbtrEJMXG6jxEE6sNxk1ne8yzghLIsVoMYtq
	z0bYjrIBLiGTUzNXNpq5d00Hupa4LSSsMZXb1kbrSU2EThgXVRmal6rocxZcHtf0
	45T1E63Gqo5dozICtRX3pf+5wbHDX/taeDdGGUJEkKQDyDB/3amrg7UcTA/TQedS
	vxgfEP6IG9R44wpmKQRhdmlIWbqgjwaIdflHeaSV9D7m8jUvCTE9HXdDUVQuSRdZ
	AHQ/2imXpEhwM/Y6ARDvkw/GuOpLpAMSIN5Lk5jUYg==
X-ME-Sender: <xms:w3SOZaSU4rSxgNd_zNeYcw3-YHEQn3qi08-R0Jby2ZA57b14aL6BiQ>
    <xme:w3SOZfy9Kh3-Fb65zR0u2sXR_7SbKSK-WGkNIBycarOAUNlHircdu9GlnKxqbM0tL
    fJYi1r26xvoIybV9A>
X-ME-Received: <xmr:w3SOZX2kk3X1VtNWRoVpnwWycXqfbjdtRADDdEMElmmU3unvnmJl8riveRaRZrWLFvEJ5Tja58G7U4OyIwpTbF5V0K1lrxixkDm9j6GRnH03HpbPEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:w3SOZWDDxAN9rmA5-jpzIt--4ofFQLWigeLA9Dc3hSIyKCNHkjyajA>
    <xmx:w3SOZTg0E_uL4W43epsgaXilN8GMnmA-9Hk7_-G6h-3dz-SsUA6GLw>
    <xmx:w3SOZSoonlxX0i_6SAYSmYtNAHfhMHIn-aX80SJHb85p3xj9Bji60w>
    <xmx:w3SOZWuQy1uY4IscbrN4djhc7M_rGSJow8bsfRtf51utcDgLw-suOw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:26:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bda80372 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:42 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:26:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 08/12] t: introduce GIT_TEST_DEFAULT_REF_FORMAT envvar
Message-ID: <13c074acdfbb4699d99b5d20a1620153b4a5c87d.1703833819.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703833818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i/Tx4Hn9yIrsBKkV"
Content-Disposition: inline
In-Reply-To: <cover.1703833818.git.ps@pks.im>


--i/Tx4Hn9yIrsBKkV
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


--i/Tx4Hn9yIrsBKkV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdL8ACgkQVbJhu7ck
PpRGjA/+NkeHMFQ6l55w4ers6VZUUUG8liH1l0l20WfoTQN0B9ZfcdnsCGSF5IWi
L6Osc5fdaIb1IUZ9xJ08hb7julS0YwJps17vBDS2kLoUIis8w6MzekZv/9T+ARAM
87iHRUawq6NymVrE/q4h4bjsxBw6op8B1MB0UrOBNnY1qwKHa3a5CSlSVtvXjNsX
FQW3ZMN0s2+YuLvP4GglfQ1Xyl6BhSttPH83VnC3RT4HL2Ua4YtfDSmo9vapwM3F
0+RbPQCqR5JYx8p4PB/DFwqNG0XAbVmbxSvsnrJ4j0PBAf8lBenopjTBp2YBrZxM
Joh+TxLfMYEYY6SHh5PlBXSLyO6nKFabVgGt2yfiWKoI17aXAFkdvHxOwkybF9MZ
wSF0QFgjxQw5BYFZLkyBA7mDmygKVRF1qC/cQqjaBEDITbKZEVOcTcB6sN3lWatX
2uE6iWIdceHZZtw5p9r94W9EO3HGoqHkIQia3hzMwm7rj94xITTugHQ4OcH5J88L
6m4EKTEXwSZv04vVgKEqsvBkMlE4XnlEMwaHJBjx/lUBZfEx722uqj74GcnjAreC
tDwo4h0pyVMUD3wdiTrd3/wis8uDPIC9k3V0wnroUSHUDAlfIjtXoXDDz6p6VUVu
Dza7jiEpx1bnwk/JiqEiFpo7UEZNAaHuRIvOPlpPT9rHUQpoUdc=
=Rug7
-----END PGP SIGNATURE-----

--i/Tx4Hn9yIrsBKkV--
