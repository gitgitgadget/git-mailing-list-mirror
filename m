Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B5F7461
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vbJ/g415";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tWJvxVz7"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id C52E65C0080;
	Thu, 28 Dec 2023 04:57:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 28 Dec 2023 04:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757476; x=1703843876; bh=ybRkzb8L6E
	XkTqL1/ZeC7B58CW7lrfDbf0t3HB5eELs=; b=vbJ/g415GzuWNmhiWZf/WkDbQN
	Rcy3XHgrZKk09PlSkXWq22cZc/dORTXnM8rXYUKPKwis8CNanZZiXScuYz9DTb+X
	65uBiKI9EHsQKkGrg9FYIqEHXapA+c77mK6p0lPNzglD0dPpMw/pfFk1OTDDhUrQ
	Znb4SECof0Ox+fBPG2kYjJthGYksaFLKfAGH03nPz5A5wSHovZZbsv84j1w19gFx
	8VrgOiHeDF44DbPaVxetA7plEP4iDlL7j+TiFEFDpYpYP2YI4J1YbXWMRPrQbdmU
	WC28wYa43KZgCtr2DPvnUPTgWmQCLlSLk+KL6vADZ9Ktpi2SsBxfIqb5KELA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757476; x=1703843876; bh=ybRkzb8L6EXkTqL1/ZeC7B58CW7l
	rfDbf0t3HB5eELs=; b=tWJvxVz7/l8OAwrvY0t7sGpXK8M2pkoAgicDH5UnKPaW
	RK6TkGun430gFFH6Hly4KWzAtT6cSa6zkwHTU+z4o4P20vQgnz2svDkOMne/YgcT
	hZz/e42kMrgSE69JXBwn9oAHDyaigEmZLfJe/+lo6dgm1xNj87YLMqNosVoELfVJ
	/TRWCSYlXGDszp4vMySs8DXpEDqPOYbtkIUMr62wS65WyVtX+VL4X8JdT43JDHFZ
	a17Nu0tZ2VXW39Af8QUv/L7pLQQqC5phWeIgpb47bH4u7/v+dgW1Hse6mbOuxibj
	YRs5k8dieF+Lx6Npa5vkfEiBgT7ZbhCC+wmbgMT67g==
X-ME-Sender: <xms:pEaNZfpHOze2_Q2hTNL_Y0nnA4bu6kCKdBWiR11JP36QRkosQZKx4Q>
    <xme:pEaNZZpdVjWJJ5RL4xFSpTlNLC0dLvFEFK-Z40HruumAJihHo-Ja1R7SbUqcrT90e
    lUdgkvqF0y4CZpVLA>
X-ME-Received: <xmr:pEaNZcOONhuxNnWMHtJhjFZuXMpYXxEs_tcEt-7p7jo6enLMfE9yWaq_B1XsswNp849gOgwxOxbPe0jBB22VCh1dT6xd2RkvGGzvIX9UKxlRMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:pEaNZS5nJZXkqndirOPx9p3JD3B3DfPWlPdFfVNomrDFJiIWzu5hFg>
    <xmx:pEaNZe4GTFrE9nK6Vqqe3p-oLGFTy8li6btQq4IPMNg8qpgXYH0GnA>
    <xmx:pEaNZahj5wjLEjdcxljfLmioth2PL9JOrqFyjp-9ZXRoIhNxLZDtBA>
    <xmx:pEaNZUTq5AsTlZz9Bc7IWuyRYmLWVzpQXIky4-SZvae2m2RwzVHcKw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:57:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf6404f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:55:41 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:57:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/12] setup: introduce GIT_DEFAULT_REF_FORMAT envvar
Message-ID: <6d8754f73af769d94a77474e6f4b7d5447be84a7.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6gIcd1JEsu8H95iu"
Content-Disposition: inline
In-Reply-To: <cover.1703753910.git.ps@pks.im>


--6gIcd1JEsu8H95iu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new GIT_DEFAULT_REF_FORMAT environment variable that lets
users control the default ref format used by both git-init(1) and
git-clone(1). This is modeled after GIT_DEFAULT_OBJECT_FORMAT, which
does the same thing for the repository's object format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git.txt |  5 +++++
 setup.c               |  7 +++++++
 t/t0001-init.sh       | 18 ++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index bf9e6af695..88e4ed4bd6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -556,6 +556,11 @@ double-quotes and respecting backslash escapes. E.g., =
the value
 	is always used. The default is "sha1".
 	See `--object-format` in linkgit:git-init[1].
=20
+`GIT_DEFAULT_REF_FORMAT`::
+	If this variable is set, the default reference backend format for new
+	repositories will be set to this value. The default is "files".
+	See `--ref-format` in linkgit:git-init[1].
+
 Git Commits
 ~~~~~~~~~~~
 `GIT_AUTHOR_NAME`::
diff --git a/setup.c b/setup.c
index 3aac8c01cd..4712bba6f8 100644
--- a/setup.c
+++ b/setup.c
@@ -2162,12 +2162,19 @@ static void validate_hash_algorithm(struct reposito=
ry_format *repo_fmt, int hash
=20
 static void validate_ref_storage_format(struct repository_format *repo_fmt=
, int format)
 {
+	const char *name =3D getenv("GIT_DEFAULT_REF_FORMAT");
+
 	if (repo_fmt->version >=3D 0 &&
 	    format !=3D REF_STORAGE_FORMAT_UNKNOWN &&
 	    format !=3D repo_fmt->ref_storage_format) {
 		die(_("attempt to reinitialize repository with different reference stora=
ge format"));
 	} else if (format !=3D REF_STORAGE_FORMAT_UNKNOWN) {
 		repo_fmt->ref_storage_format =3D format;
+	} else if (name) {
+		format =3D ref_storage_format_by_name(name);
+		if (format =3D=3D REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format '%s'"), name);
+		repo_fmt->ref_storage_format =3D format;
 	}
 }
=20
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 38b3e4c39e..30ce752cc1 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -558,6 +558,24 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.re=
fStorage with unknown back
 	grep "invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}garbage${SQ=
}" err
 '
=20
+test_expect_success DEFAULT_REPO_FORMAT 'init with GIT_DEFAULT_REF_FORMAT=
=3Dfiles' '
+	test_when_finished "rm -rf refformat" &&
+	GIT_DEFAULT_REF_FORMAT=3Dfiles git init refformat &&
+	echo 0 >expect &&
+	git -C refformat config core.repositoryformatversion >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C refformat config extensions.refstorage
+'
+
+test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=3Dgarbage' '
+	test_when_finished "rm -rf refformat" &&
+	cat >expect <<-EOF &&
+	fatal: unknown ref storage format ${SQ}garbage${SQ}
+	EOF
+	test_must_fail env GIT_DEFAULT_REF_FORMAT=3Dgarbage git init refformat 2>=
err &&
+	test_cmp expect err
+'
+
 test_expect_success MINGW 'core.hidedotfiles =3D false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&
--=20
2.43.GIT


--6gIcd1JEsu8H95iu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRqAACgkQVbJhu7ck
PpTQPQ//ad4cRSMGz1TtK+cUTkieyaRhjd0iWBYwMEIIyXN2/AYIoc7vSPtCNoBf
cmBrhGu0WDoR4juKTXY83Gp6244vpTksmFf+cBSW88BqR7+y9D4PQAjwieEOb/U3
4hYB+SdC91z8YVqlUYyW11lEOoO9fJQaBd05frLSmwevRLBjNqHkqQO9J+9robIZ
q2y2RxWw+CBkw3r4cDCXuy4l/K/UkJTrIWUO/1bKG/Rh15Oe1sZZFvcYymbG3STU
zyLNDTdOQXgAPDX2NorbSJt2MrLl1ZzT4RnCWADjEF/NadDi12SL9Q8w0WOEb0bq
K1kjV3DHH2B6nXliGZqHN/FGuof2QWOB0CaqIcXfxofbXJByFzgtgDvTUtPW1Gk8
72Zm4JlX2G55rBbxNB2P6zRZAAgext7fqFS93VCjUODQehbTgmC/Kp+71ht/xOhK
4EIDqdEVzVM8aL/MPTyQnJHbdNDZRyJeEFX4yBV0j9AidPGIjounrWimpf0JIsF/
maKdVBqz3WZBaFK0b5pVXtlme5Z7jftOVd/OicHDKxktOTCFx71qFLgAExxa90M1
MJOpo00NH0gGDzQ3r2WIj0B+nciLtoDisGKYdNo+M8gd8B8amXqNGHXfXcMKYUV/
IuyythAFvodo/HHxuHjNv7qL9eGf1B0R2PrOW/jcU9hBAm+/DCU=
=OQeC
-----END PGP SIGNATURE-----

--6gIcd1JEsu8H95iu--
