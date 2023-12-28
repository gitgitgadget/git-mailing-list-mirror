Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8368473
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D85QN7Z8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZAmpxrcE"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id DC4405C0082;
	Thu, 28 Dec 2023 04:58:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 28 Dec 2023 04:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757489; x=1703843889; bh=CFBX5RLq38
	hd/uUyhw+oIQXABSbvSjjoviIa1E6z/Mg=; b=D85QN7Z8+iszCcUEkQX5KrfgLU
	OestKHuQQDkHkQlpT/e9cYZIWeelOVMx8aV4i5rKd908s4+/pecpf+/nXnX+LOsT
	Zgz8BkrPrqrwo4nBHL16xBSV8lFZIJwiBrYTziaJlwjsGgKPYGBL2zX/4lkpB+ab
	jcYI4MyOcwy//ILOhNSZyVYNgC8fRTc5g9hEP/u11NNYNDBlpFAgiDZO6XQThkoG
	EhfpDptGBYeS8IxDP4RCjOvYCy3+T5HFXdou82qTqSlRgkrpTB9p70fHt3K9JgJc
	QoSm+/pckDpKDO2cl93VkklG3Q85tpUnO8LIgGIg2KPkeRPG507ovCENkugw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757489; x=1703843889; bh=CFBX5RLq38hd/uUyhw+oIQXABSbv
	SjjoviIa1E6z/Mg=; b=ZAmpxrcEH0A5bikRjbiQnD6b2Dq67fsmO6zbV/JnWDmY
	Dezet6kZa9XpHMGi7GEILiMI/OO16UT1Ww4bVboOX1jLFl7AX//rd2AYu5ie7Q6T
	NkVOwkukrTInLLwFiV6cR+hcq2w9XJbc4Vu+kLfHnjANrUXRdVLchRpP27hw6ICq
	YJVqXNdizvhAa9SnIF4jGQZUpAYkaDqV+kbFrDeTGgtsWajeDe00gUKBsNzpTfWC
	PHFQlEXLLSbvUZ3wZsYDmStu/WjDD6+R9+RfYtCnY3dYgYN4aObvWqoU+xzEt+In
	OVT5c+7dnTSBIqT6f3zvEOwge/wJnALMN429QrZktg==
X-ME-Sender: <xms:sUaNZQM5LsOy5N4XUqi7n3j1kG1ltwgtwFRsMVaet-23hRwGAY4C-g>
    <xme:sUaNZW8UoRIEChiQULVAhyXHxlzO4SmGexSuGcaMHx4Km0wGTiOBAZWPwJyZQdgXo
    8sRKKtabCSydpm-0w>
X-ME-Received: <xmr:sUaNZXTFpbYQM41uD0VQUXSaRKa5otEDUHZkBmK-VnBmxT7PtP505GbPvjlZSTy15szb9CFHuvJ5yZd8Vba0hX4B0Y4u9o8O_rfFHJTYcq6xCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:sUaNZYu2zpfsyrBa1hkUNjfz53_sPmeabiixtI3TqGz2o8t9uq7Uzg>
    <xmx:sUaNZYdfbGnAbqBjuOozLkrAc7rKieOJAlX1aMEH6wZVAk5bMPG6tQ>
    <xmx:sUaNZc2SUuT3wBzbyaS_fK1FAaTd73vWuISZ9F83JrW8WR32JJ1qDg>
    <xmx:sUaNZUHoc8e5SSU2zY6rgiKOE5bMMUCWkah6UH5_fTEYWfVFv7clyQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:58:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4d390357 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:55:54 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:58:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/12] builtin/init: introduce `--ref-format=` value flag
Message-ID: <e382b5bf0853726169ade0f657bd70ad9cf57710.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1d80q5OYhxFvWcrR"
Content-Disposition: inline
In-Reply-To: <cover.1703753910.git.ps@pks.im>


--1d80q5OYhxFvWcrR
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


--1d80q5OYhxFvWcrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRq0ACgkQVbJhu7ck
PpRaUA/9G6mZCUawX3Ae1/Uxk7bDirPO5YaDMca+A5Cb62p36PgDUmQi6Zmf8Q3J
LJyR158SI0LlX5AbOKp6LddmNjkxiPL6ViWaxsaSfr1DkVkM/1Dqhl9kpuRRSvgN
xldWB+y+mN09n5+fHkaEQw4S/wL00kwul/Kteh2RzxiZb/W1gOUk2mjm6oCYOO7d
8GwHtKMqBTzYZ1Oi5oHXaYa5c23eVVUyI1folqvZ/GDkeYt0UdrVJZvdzh/o0XFW
l20dT/Mz5GMLsc6QWUMO/krsXXaiuxJPJW6gp0iNuc1/2DrEE5Sfqwe7I8YyeFCp
vvGi9CH4Q+kiqvUnSNEOqlY4Y1I6QGgzxghlWz+NWMUOVzymuCELngOq4vZYcoN+
8vtyntJqug43fX0gV515sXn0P3cXWRs2D9bfGBB4JhTwoMseOZJREcixM9ZQmlgR
8Wy6CI7Cu2CW276sRFs9JTr8na8klJtQjgN4+SBL8WsFljQT78i8pyOtH8nYDqQG
bYXG1tbhXmLsM5rdk3TLJkUBybVlbwJkXi7BepNiyyAMeeN50lhmsE7k4sGLKvf6
ZB8CgUPoP8f71tsohGAEi6Jtaernp7Dl0rh2xfEtRQBLDteKuMztTrDFg4KUGj3u
j0A9Whpr7aefc109jCWt765HSCi+wsBeCV4m2n+DhASeruLmiwY=
=ZmGK
-----END PGP SIGNATURE-----

--1d80q5OYhxFvWcrR--
