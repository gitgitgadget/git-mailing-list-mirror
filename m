Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F0C8CE
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p9odUuDu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gU1aEkHZ"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D2F475C0184;
	Fri, 29 Dec 2023 02:27:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 29 Dec 2023 02:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834827; x=1703921227; bh=/JPSnppaKi
	ZO3nXm9DEN+3Gc4HZEN8toGs9DO/HBAR4=; b=p9odUuDuUdLEsrDoyjuP1TC9xo
	366G/D9QMapd3mP6ToTU15j9J7b32mNMQWe0K/L3pHNw/Fvrl+RYISgzKqcFbMZy
	IgemGF6ZZ9siHDI/ddt8DDxn0y3vH+TbKforiz6WbvPL886l36dHANhaaxUYTi/u
	W9mmDBGbLqohMFVpGg+AK4y/QhVgGPfxLA/Kqe9xrvYGQXxZ1nCcceNQrNW7K/Xi
	PfcSxcShOx2Fdq4+X8cKKSwIwalYkAf8V1NOtmFBu84OYON/Q283olKbNq4U0zgM
	oksaN4Tg+cAVG1fIy+pPa6XfI43jSUl1fkjuNhxyV86SNC/GLZbTl64+Vb+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834827; x=1703921227; bh=/JPSnppaKiZO3nXm9DEN+3Gc4HZE
	N8toGs9DO/HBAR4=; b=gU1aEkHZMkQNnehU6TGE3HgKmFTVgcTh9FQbADm+If62
	JrkCeMy/xMmmC4zlfftJsWHVmUDkHuac0Myd3hGfhcKrrTthSR9zgvgLfth0HXRa
	P1nGD9OHfjs4fpeBJTsV+1npndW0IGlvDnn3e8/I1665RKFV6TVtu/tS0mBmwLFo
	8KB1uGVixrVen4Bo2HWjPAMhj4xf4Unq+zrWiB22KUE6Q+fza01FPZ9dfrqDkrok
	M/GjKOmQzT/xXG+7d5mlGKkF62Xb4IvzEk0JGOXPqTBlMU1lEf5wN+Yo2JwZtkf+
	CONMG553Ok1WZvOIMk9+fIZ4wYhMTyBrSzaPOxGwKw==
X-ME-Sender: <xms:y3SOZQa6d6Xlja_YKxbtEpMeyjSZj09IvqTlGWNt-vDbd3pJKeydVQ>
    <xme:y3SOZba0mf6qs1ark5KIFMbevCdhYbX4ZMYiwSWeR6lCVeFlqjhCe0TQ-HrhRR15X
    5PBsWHIkG2p4br9gw>
X-ME-Received: <xmr:y3SOZa_N9eJJpI91aqdB-VeJVXXZG92IBGXVt_PcW8FmsMOSFRq4EVdYcEnfqmM9JWLGmgCg7Aug2JEGSXBA-TZ4h-qPTOjuxiD9hiRARKNp5NpTNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:y3SOZao5qx14UG270aUTxrLpRrN9N8v5xwz54VZp_fYXPyXVgKYg-g>
    <xmx:y3SOZboNskgBCWPCjnicN4infpxmcmzwOTVPfVOcllN7ovzbf7vpWw>
    <xmx:y3SOZYSQg2Biq53jTptYo810BpHImjZPb5kV2SSqjAWJCG5vKpx0ow>
    <xmx:y3SOZS1YJzSFN8bqdQ1qpNWkOzpJR33A70UDIl2TDKS5C71nGhWozQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:27:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 02b14237 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:50 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:27:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 10/12] builtin/init: introduce `--ref-format=` value flag
Message-ID: <25773e356063e5c109c238105c148b1112cc9672.1703833819.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703833818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UldrM6uUYgBoZTz5"
Content-Disposition: inline
In-Reply-To: <cover.1703833818.git.ps@pks.im>


--UldrM6uUYgBoZTz5
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
index b6e80feab6..a4f81e2af5 100644
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
+	unsigned int ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
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


--UldrM6uUYgBoZTz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdMgACgkQVbJhu7ck
PpSlBw//dZK98tNoMIA4ncpIq/oq1yPZrbtBA4uzHstOfhng+QN4ihZZ5t9x8e0s
6LXuuKDh1p1jbSyKbLqzutSUEvMhec30znQPOuDqWgzkKRnrKme40+UJswGjmMuQ
/lDP5bXgPY8sXnc/P+KJCDjba/77sEcFTh4+LpZp4Fz8fok2lRw8+kURGnWVzAKQ
Eg4pzF7psVD1TfXLUSzf2GWB8Pl9oAUDaHeyDuB1pFzOb4/+bcC9wysS8jZFQJZp
zv4ngqgk9tUZ9KOPcd8DdIc7ypnSaLgO2ghMHJ66kRQ5XAFuRogUu1wUADHfVxyN
7Mt7FldBMKjmNJxlf1Ewf+Z+9kpEzJuVrxRH/etanQBpKGt/hf48CLI85ha4Y6l7
2yddKotcI9SDj6vUAktOhcy2AAAXhktkPcyO9BFsR5g/lR/U55QOmB3o+67Z9/jl
WhaX5vIQyPJrS2rVodpG6gGW8eod5/QFMCk2bmxxrHvlRzbzyt1PQCAeIOPsuqb6
qNyTbuh4kVIlG14KkqLONkNkc8c71N+Qoj8YEMzK7BbfrRuaU/dyKzIifjJEqnYT
BL/gKkF3ucU5C2XHUXn9wvAtYIxtH3IvfVm6Unrs92UvrBMqxfCucXSrB9Id6n0j
sxalV18FTp5gX4kog3b3tQVWb9Xq3/sD7g6jioe5sHbeIj5fT7Y=
=ZKkF
-----END PGP SIGNATURE-----

--UldrM6uUYgBoZTz5--
