Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6C219FE
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BBjt3Rni";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PtmQQkRf"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 8E4D85C01DB
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 20 Dec 2023 05:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703069736; x=1703156136; bh=npQWbpvXPg
	I4wQK2+GGR5XPW2ePKYQP0jiZ/U+16mqk=; b=BBjt3RniD3/Fn4KrnK8wx0a+A6
	q4FPzr9qEFJ9U4+0Vzw1e9JZAbRTWp7YmpOFNhC3+fZJ3iQSUtv5goAPqKbBGQqk
	bEr0u8afvaPdfJdwL2N1xdBaDzz1kOinpU/N3AveY90WLDWLzRaBz0DhoJaxA9Mk
	2jf4AZjPTrJAu7+MVHOxnaJf77TnLj2RHim68oGCf2WGkR66bUCwiBauSSBE5gOF
	p0AAaeizcgw13xjvhTlBXJRqW3xhdN0BBaW1JHZhYIIQnOTtkARQGevv/lbtuaHy
	QweSCzOSj3ymdoSj77maqRp8Q+oW8ZzyHsXn7tpAnfhSjk5jdSspS7EE8Suw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703069736; x=1703156136; bh=npQWbpvXPgI4wQK2+GGR5XPW2ePK
	YQP0jiZ/U+16mqk=; b=PtmQQkRfzefdMKom48oylD8nCfSVhVcR8VSMiIvldv+q
	xv8l1jgUOok3rOmLzbkxGpQvgoNXaBgy7M9pNKxBtyGevvbpsOoXKipRQSf7tLe9
	4/FZENelVd51dpw6m+qassTXkC61f26Uu6GyQY+ONmFlQs8K5tVtgcWQ5Hs7Wnvo
	G2d8PBhmo6RZGzGmJSt/9LIvzowDqiSaGKv33h6jysbpiS16WPrL0afzL/LVinWW
	vNEItwFOzB/gYoyFK+Gpg2dAeAeYneaYpQ0O3XlliOWlBSUOfn62WdxMmhPVfTvt
	LAU+KxVAbR0FMDOQkpTrxVYpEAFetBLZbeI0gDHZ1A==
X-ME-Sender: <xms:KMiCZQ5zP9MwlBR62BqxeUn-ED6X7gKuOCbaP3vem5hL6OyCLNHeuQ>
    <xme:KMiCZR6tQHAc9Pxwor0BkilfbUfcKFD_RLzaCaJXkTkatD7yq9X4mqJxV597Xwkl0
    GRH8KpVPKVP4bkgGA>
X-ME-Received: <xmr:KMiCZfcBG3rOrc_eqoANuVHYkEBx_urc51ss9l4fizoKqla8isDiF9Rm6DnCVpt4-Z2X4DdQI9SVzls5uV9xi9uNX5TI8EwOc69h8pqKTx2Hdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:KMiCZVIs24d8EatxWHLbyvUpstFmFkLBTjOCysR3CmjOaAz9RiLuuA>
    <xmx:KMiCZUJP__WZx8YRczNhh0UJGQ3IyUcR5Hg56YFhY8Vgc1Vk8AWzhw>
    <xmx:KMiCZWynqOyjiEu9QPipcRnwLKpM8_DvVPbPSTyaRP662-4mp5YPOQ>
    <xmx:KMiCZbkl9rq5_xGg48iPXvinZMs9p2JBwCY5TLxKhX1_Bw9vVspX6w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d5042b5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:53:40 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:55:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/12] builtin/init: introduce `--ref-format=` value flag
Message-ID: <4d98b5355310448e6a95a3312bf46450247def89.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rpmRMToTtcQaWre6"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--rpmRMToTtcQaWre6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new `--ref-format` value flag for git-init(1) that allows
the user to specify the ref format that is to be used for a newly
initialized repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-init.txt |  7 +++++++
 builtin/init-db.c          | 13 ++++++++++++-
 t/t0001-init.sh            | 26 ++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 6f0d2973bf..e8dc645bb5 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git init' [-q | --quiet] [--bare] [--template=3D<template-directory>]
 	  [--separate-git-dir <git-dir>] [--object-format=3D<format>]
+	  [--ref-format=3D<format>]
 	  [-b <branch-name> | --initial-branch=3D<branch-name>]
 	  [--shared[=3D<permissions>]] [<directory>]
=20
@@ -57,6 +58,12 @@ values are 'sha1' and (if enabled) 'sha256'.  'sha1' is =
the default.
 +
 include::object-format-disclaimer.txt[]
=20
+--ref-format=3D<format>::
+
+Specify the given ref storage format for the repository. The valid values =
are:
++
+include::ref-storage-format.txt[]
+
 --template=3D<template-directory>::
=20
 Specify the directory from which templates will be used.  (See the "TEMPLA=
TE
diff --git a/builtin/init-db.c b/builtin/init-db.c
index b6e80feab6..770b2822fe 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -58,6 +58,7 @@ static int shared_callback(const struct option *opt, cons=
t char *arg, int unset)
 static const char *const init_db_usage[] =3D {
 	N_("git init [-q | --quiet] [--bare] [--template=3D<template-directory>]\=
n"
 	   "         [--separate-git-dir <git-dir>] [--object-format=3D<format>]\=
n"
+	   "         [--ref-format=3D<format>]\n"
 	   "         [-b <branch-name> | --initial-branch=3D<branch-name>]\n"
 	   "         [--shared[=3D<permissions>]] [<directory>]"),
 	NULL
@@ -77,8 +78,10 @@ int cmd_init_db(int argc, const char **argv, const char =
*prefix)
 	const char *template_dir =3D NULL;
 	unsigned int flags =3D 0;
 	const char *object_format =3D NULL;
+	const char *ref_format =3D NULL;
 	const char *initial_branch =3D NULL;
 	int hash_algo =3D GIT_HASH_UNKNOWN;
+	int ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
 	int init_shared_repository =3D -1;
 	const struct option init_db_options[] =3D {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
@@ -96,6 +99,8 @@ int cmd_init_db(int argc, const char **argv, const char *=
prefix)
 			   N_("override the name of the initial branch")),
 		OPT_STRING(0, "object-format", &object_format, N_("hash"),
 			   N_("specify the hash algorithm to use")),
+		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
+			   N_("specify the reference format to use")),
 		OPT_END()
 	};
=20
@@ -159,6 +164,12 @@ int cmd_init_db(int argc, const char **argv, const cha=
r *prefix)
 			die(_("unknown hash algorithm '%s'"), object_format);
 	}
=20
+	if (ref_format) {
+		ref_storage_format =3D ref_storage_format_by_name(ref_format);
+		if (ref_storage_format =3D=3D REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format '%s'"), ref_format);
+	}
+
 	if (init_shared_repository !=3D -1)
 		set_shared_repository(init_shared_repository);
=20
@@ -237,6 +248,6 @@ int cmd_init_db(int argc, const char **argv, const char=
 *prefix)
=20
 	flags |=3D INIT_DB_EXIST_OK;
 	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
-		       REF_STORAGE_FORMAT_UNKNOWN, initial_branch,
+		       ref_storage_format, initial_branch,
 		       init_shared_repository, flags);
 }
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 30ce752cc1..b131d665db 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -576,6 +576,32 @@ test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=
=3Dgarbage' '
 	test_cmp expect err
 '
=20
+test_expect_success 'init with --ref-format=3Dfiles' '
+	test_when_finished "rm -rf refformat" &&
+	git init --ref-format=3Dfiles refformat &&
+	echo files >expect &&
+	git -C refformat rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 're-init with same format' '
+	test_when_finished "rm -rf refformat" &&
+	git init --ref-format=3Dfiles refformat &&
+	git init --ref-format=3Dfiles refformat &&
+	echo files >expect &&
+	git -C refformat rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init with --ref-format=3Dgarbage' '
+	test_when_finished "rm -rf refformat" &&
+	cat >expect <<-EOF &&
+	fatal: unknown ref storage format ${SQ}garbage${SQ}
+	EOF
+	test_must_fail git init --ref-format=3Dgarbage refformat 2>err &&
+	test_cmp expect err
+'
+
 test_expect_success MINGW 'core.hidedotfiles =3D false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&
--=20
2.43.GIT


--rpmRMToTtcQaWre6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCyCQACgkQVbJhu7ck
PpRHlA/+J5OLA2Mg2hGDndnJ6pYxFXC0EXz2yoBWH9hLWNpuBY3UoXmox9CSyFVH
op+tTwYqQWO4bMH3LTHDfd13xQ8Kdlx+pKd5ydEGQgLRCU5P4BL6A1XKZCGeJKA6
in1DJi5YeGA5d5bFISabLvBwu/NY+JtEwtd1iws2Z7ppG3gnNt30WCnug01EfAwV
lz8s0veW44jK+JglVqNTuzfxoxi/PQqQ6NJBw1IeHV7wJ44A7BXnA6bj+R6+zes4
FqZ5ENNjD/PgEbZvH96B0e/ZIbPqtZJsLqTtbBPJjOnrulCyV6SAbRM4AQjyKv6K
PgNFKSiJyOs9pFb8rTufHiJ4ISwMUu88xW+0edTE0k82i9aix/tt1MyQ26vvHUUZ
U7oGe7LZczY1uRuZy8dN6sqq1ciTTqM4mb6Fc21NRNKjk96D2d/5d5A0brH/G7vA
2plsCqVI0nfXPuMafui5UjY87reXkj+KfQrZsW0t7g6SDQYZ75OyknhrC4ck197i
2WEXrmetmqVB5lIHjC5QmlUag5OAbO1QHtMDkCnui6IzYQS56r0nh8/Fib51ZmbR
7PQqruoSxO4WonBwbv2J2XsyYQRVApuA5idnkBksrbQhKNm8ueDs1D5qzzRdL+To
ZgZJghZkP2cK0EZp5pQeWqy+wfDO3A8cbjlGJ5zRuUA9QN4kHII=
=KoTN
-----END PGP SIGNATURE-----

--rpmRMToTtcQaWre6--
