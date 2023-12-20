Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7B21352
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IEoRCPyX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ilDsWIzP"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 1FC435C01E2
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 05:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703069723; x=1703156123; bh=HixgBLxdsV
	898Pii5+FbQehBBXSTcnVrARzUHdrlui8=; b=IEoRCPyXZfNVHLUkeJODzfFWv0
	e4hPKrYXJt+XPS/OTjAJZLwMfJ6yyMdLFtbBrOyhP1QqiS2XBwW8p1J0ibpwt8Ux
	kyX0eZrBJB9DXILjsSu2lVxwUO8E1CC8jNyL61RubjbKaBTRPmiC+UsoTKXoTSfL
	EHyg1AreZiCXXnkKtCHj/tuq/skyfQ/dsTR+bawiGF0qVauWsE4MAT8V9fuN8K/W
	hpJUfVlG1vV0+DsNXjzIZzo5WAP/S1BnOLuX/rcSauBgnbv9FqUPPL8tPy2DRaX3
	fIG+W6YJHjZD8hO2vEEAKfJKM2ENRum0ptoMOmmJ3xxmYkH5SStJ4EL0h1Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703069723; x=1703156123; bh=HixgBLxdsV898Pii5+FbQehBBXST
	cnVrARzUHdrlui8=; b=ilDsWIzPQbUT3fLImwFKRMFfpegsE/kRR77UeGakwGj9
	xH3OqGIarMAZB5dzaKVT1hyX+H4DSPGqvFij6ufQQ5PbVXZnsCEd7oond59iGkCW
	1S983UpizB9YmczmFoJ7P3dC8TVe9tyaslQNFjl/4XzdMMbkFBdunXZO2uDzv60j
	Oe71F2UhaG1EVFNt+ZXdTwNvDMg0cHclZbIoXUeq5y9rmBUNRpSJegrTVzT7T2Y8
	yXanz6set+WyAwDWMe9sfOFU+I5kBTPcT0V5N2xMn8k12OcD2ORfEWkudE/CjXMG
	2ERCq+EMi+tuWs3RL6p/w1YsxgkhTcFlOCjf5eBiwQ==
X-ME-Sender: <xms:GsiCZbBxZFtxyijiFN-t-VKn3J2edvifRow8HlCGWwcZmLo1yvG9iQ>
    <xme:GsiCZRikHt4qiKca_53gI8bVL5ibzYOsNBBlr969BU2908aUZYzyvVKV_QSY6ZPy_
    IdT40d2RSMMRsKmpQ>
X-ME-Received: <xmr:GsiCZWnG-SfZGGOzbo9sT4IlkUCvarlgJsdsBasfKSdl3CYaQ1pi29FoCDAXzq5KdWkXZbYSTNeFGAI4F-ahfC5qWn4VpbhDqTMm_SzmAZ4uKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:G8iCZdw8S6kVkctf62qWOKXYmaNZJOR6yyoHsalbGl6I9X8eAJ9tUg>
    <xmx:G8iCZQRWysyn-n-HsH2SW6iDNiV5lUMUtcKyPAU-H8yNp_91D0EmzA>
    <xmx:G8iCZQbUBEDSzLcc-jToDtXWmSCliyE02-fJi_YLa6AISrJq9769MQ>
    <xmx:G8iCZfNBGrk3kehueBXY-1jvjrvatCseQgFIxOwGHFHVKWNvedj7gQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6dbe610 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:53:26 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:55:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/12] setup: introduce GIT_DEFAULT_REF_FORMAT envvar
Message-ID: <dd91a75da49b167f983d11819c6f7330cdf4c11c.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mugjwAwN8wiUCU/u"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--mugjwAwN8wiUCU/u
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
index 4698d7a42b..0ab19eef3b 100644
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
index 7eb4ae8ea0..8913e30974 100644
--- a/setup.c
+++ b/setup.c
@@ -2160,12 +2160,19 @@ static void validate_hash_algorithm(struct reposito=
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


--mugjwAwN8wiUCU/u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCyBcACgkQVbJhu7ck
PpRO5RAAix5CxUguPIHLBt7qboHEozaZdBURul8Nnv7d+AU0eAjtSg4WaGdUPwQv
o5nZaZMF7jx3AmXuSPLYK9p3Oyxf3+HlndaEg2ejO7IGoNm7sAEgIaJ+csWRP2Gf
hrIJ96uRN0cUYxk2gU/FuPRdTrThfWdZzEGTDcQmG719+ZMBBloHESDtHjo2pb0w
8tqmnq5HirwaDQqnX9aRTEkpPPGceR+7ImYtqv7CsOPFKA2VLk83tQr9WGLwhudu
jrHeS4UhWKMNq9VjljutwT45MOqooxt5Mfy6rEoRzHJlR2VLNk5ksfLQL2oWNxQz
Sg2uptodkcMt/NS1jrxjnQ9gv3dteIA7J2/M2kPj+WfXfVcJuFRcztv7pm+SvTpR
o+HUGjtjVZn3DeSqL/EON1Af/Y86TS/zk4/l6F/27hLodK0U3hwaEUv0KlXgDmtb
0Wog12iuezBp9tVLihq1yPqDR4Z1q0pQRJSIOkITPNj6LFEIbQDJdcYxsMREP3+0
PHINcZ0tJ9uL8d8IYxfGKbM4CKm6mxonAfhTjEw5Rk5LnrTf+lFEe5TTLoqGBN6s
daefpdiYt5Al2kAOs8QL0QQBXxK0U0FgOKQSHI5PfFLUpjRvZNvrFnMhdHWXywN/
rFXzR+g/ImnpOROqS8A0WO/73ilIyfOiVnqYjeT9V+IDIgmNAWI=
=tP53
-----END PGP SIGNATURE-----

--mugjwAwN8wiUCU/u--
