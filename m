Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC798473
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cNb25k5t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zv93B+2a"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id EEBDB5C0082;
	Thu, 28 Dec 2023 04:58:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 28 Dec 2023 04:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757493; x=1703843893; bh=ES29+49hdb
	m6yk2kWvXFeQAmEQWIxEqHxkwPa+MxlwU=; b=cNb25k5tlWHgMYqpBnyiX9bLY7
	7sAvuIx8jJp9kvuzXg6BvwZvOLTvxHtZMIjChQhkxcGkjgGVPX+ayf22k8h+mKWE
	Zp1I9PKJ46PrIAChfS0f2sBp0iFYwkBwaY9O558U4+wAzIk5RatDEz4W27pYOuF0
	74apM1tGZZU2viW2s33Y58gGrqoV19C7itzp4tttrUU404tcDGpHM0jcxyJVTcO1
	/Wb429ddCeBM1msmkINH2tAwCsOWb4dZFYRF5e751fLvkWHFBeQ0ZffJ93SFBDAZ
	n3M0kR8S1RyuYofx7Qcsk0VuK+x2KihcoPYEFSYaoWJMYnz2xyOqs3gwkIqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757493; x=1703843893; bh=ES29+49hdbm6yk2kWvXFeQAmEQWI
	xEqHxkwPa+MxlwU=; b=zv93B+2aL7A3MUKI8vX2mga4huRve1ionFQNC74FdiUA
	Ux3lqjswagxCLwNNcJIis+Xk1+f0zWz6S1TNKpbznjd9SAxhb2RJN+6oa226Yjqd
	Q2EACi0WW2JTRmxG80l/uz+0EcJMD/Mpjeh5TSA7rJRpH7uFDwcmkELBhVo8XRhe
	7jZkHdIUdWi4WPpyba9DHIu5JCBd+nL4DCqRSSbFxcdp8OCMTiWckFwO5p2riLr3
	eh5Ghici4LHi+Jq/+NyuHIEZ2hxCC4T8HhCrBU3OcA8JXxLelt6t7Ha8M9wIzHHc
	l4Jz/2M6zHdu/CRz/UuGbyCyyeNueilwzmZZRkWVFg==
X-ME-Sender: <xms:tUaNZSG2Gp7HgMGIk1KgW9C03gS71dzc26WHu4nn0bxAExxsUQ0M_w>
    <xme:tUaNZTVOYx2SpdQ3VGKEJleKRVV0GcsXORCXpQ2ZGDp8kk94Nnqs9MbLzZmUrwHLb
    -JgXCUfpcKNuSglvg>
X-ME-Received: <xmr:tUaNZcJCyMGV7KcslOhjJclCLZqWkjpK_eUvwHusZkhaBVxyE7sCY0e5ZydvaI6xDfHTYgkvkdsjLUEOXxbb00G5fgU4eGRAFgVuJBfVOuJgZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:tUaNZcEk-nlJTj2JS4RqeiIi8ZpdkI3Lxcj-F2dEwVaaCQZEKEvQ7A>
    <xmx:tUaNZYXQtiiVCwf7Or_J8131KmncRlagvBvbLv3YFdxxU1jQd-yMEQ>
    <xmx:tUaNZfPisKap6hs4ruSmr8IZhwd0G0ql99hKfOK7PqCbDzj-WDM9vQ>
    <xmx:tUaNZTenTmAB4HFwFl4PJzM82yFZR63rlH2S1kElC9OcgQwQ_8tyrA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:58:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 888e4cad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:55:59 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:58:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/12] builtin/clone: introduce `--ref-format=` value flag
Message-ID: <257233658de252252f2493593f6af958947c2aa2.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l7Y+PczdZalVEeDS"
Content-Disposition: inline
In-Reply-To: <cover.1703753910.git.ps@pks.im>


--l7Y+PczdZalVEeDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new `--ref-format` value flag for git-clone(1) that allows
the user to specify the ref format that is to be used for a newly
initialized repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-clone.txt |  6 ++++++
 builtin/clone.c             | 12 +++++++++++-
 t/t5601-clone.sh            | 17 +++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index c37c4a37f7..6e43eb9c20 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -311,6 +311,12 @@ or `--mirror` is given)
 	The result is Git repository can be separated from working
 	tree.
=20
+--ref-format=3D<ref-format::
+
+Specify the given ref storage format for the repository. The valid values =
are:
++
+include::ref-storage-format.txt[]
+
 -j <n>::
 --jobs <n>::
 	The number of submodules fetched at the same time.
diff --git a/builtin/clone.c b/builtin/clone.c
index 0fb3816d0c..18093d5d16 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -72,6 +72,7 @@ static char *remote_name =3D NULL;
 static char *option_branch =3D NULL;
 static struct string_list option_not =3D STRING_LIST_INIT_NODUP;
 static const char *real_git_dir;
+static const char *ref_format;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbosity;
 static int option_progress =3D -1;
@@ -157,6 +158,8 @@ static struct option builtin_clone_options[] =3D {
 		    N_("any cloned submodules will be shallow")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 		   N_("separate git dir from working tree")),
+	OPT_STRING(0, "ref-format", &ref_format, N_("format"),
+		   N_("specify the reference format to use")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=3Dvalue"),
 			N_("set config inside the new repository")),
 	OPT_STRING_LIST(0, "server-option", &server_options,
@@ -932,6 +935,7 @@ int cmd_clone(int argc, const char **argv, const char *=
prefix)
 	int submodule_progress;
 	int filter_submodules =3D 0;
 	int hash_algo;
+	int ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
 	const int do_not_override_repo_unix_permissions =3D -1;
=20
 	struct transport_ls_refs_options transport_ls_refs_options =3D
@@ -957,6 +961,12 @@ int cmd_clone(int argc, const char **argv, const char =
*prefix)
 	if (option_single_branch =3D=3D -1)
 		option_single_branch =3D deepen ? 1 : 0;
=20
+	if (ref_format) {
+		ref_storage_format =3D ref_storage_format_by_name(ref_format);
+		if (ref_storage_format =3D=3D REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format '%s'"), ref_format);
+	}
+
 	if (option_mirror)
 		option_bare =3D 1;
=20
@@ -1108,7 +1118,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	 * their on-disk data structures.
 	 */
 	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
-		REF_STORAGE_FORMAT_UNKNOWN, NULL,
+		ref_storage_format, NULL,
 		do_not_override_repo_unix_permissions, INIT_DB_QUIET | INIT_DB_SKIP_REFD=
B);
=20
 	if (real_git_dir) {
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 47eae641f0..fb1b9c686d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -157,6 +157,23 @@ test_expect_success 'clone --mirror does not repeat ta=
gs' '
=20
 '
=20
+test_expect_success 'clone with files ref format' '
+	test_when_finished "rm -rf ref-storage" &&
+	git clone --ref-format=3Dfiles --mirror src ref-storage &&
+	echo files >expect &&
+	git -C ref-storage rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with garbage ref format' '
+	cat >expect <<-EOF &&
+	fatal: unknown ref storage format ${SQ}garbage${SQ}
+	EOF
+	test_must_fail git clone --ref-format=3Dgarbage --mirror src ref-storage =
2>err &&
+	test_cmp expect err &&
+	test_path_is_missing ref-storage
+'
+
 test_expect_success 'clone to destination with trailing /' '
=20
 	git clone src target-1/ &&
--=20
2.43.GIT


--l7Y+PczdZalVEeDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRrIACgkQVbJhu7ck
PpSAlQ//RMhkeE7EAtBxi40iVgs7IDKi+hQVPbe9hilLpRoH5FheO0SUi5XzTsPz
nX7ONeou2svLUw6xP+glf/ZoxMs90AO0QiQNyZ54ZmPC6HR5gP+HCyTbf3bsabDq
zmvQd+j40nnE24pxv6o6T4bZy6GHpx+KK6Nc0HropAt+nUyDXtGfVAAqrA6kWxFT
a5prgnMGSHlMAgXmrR3xhmmvDvjYR4g3gAsRVZ8QiYPP86HsfN/V0Z2916iyeD0a
enmJ2C6GkzZhoZhU2Iu6v4EOfBT7hVspeW+Tmvbw+gbliaglJGSzHiWJJ1EL+Q08
Kcd8zveTNzSd5tq7AZboPxD6gnqU5Pgf0eItee525ZE6y7NO52tGzhQOwVVOFzye
inVzZuVO9nua137+UFlbkt4na9wHNsGILKqQm9X8RtIhQm30W3eJOmgUOUl0cjmL
sNkCQ8WYEMxRjKnuA9sAz4LM0TnKYwg8KF86UU/FjGKqH5UCY9ZgK/YtWvLUuTNy
1FDeFBOdmM0I7gAs14YkdjrnN5hDOHskI9Zo7oO/UjAQqfW1C1/2kJvuI6idMXgO
3+ypgAqAGTB9Izt42vrSmiQzX51bccOpMcwejhvCpaSJvMfqikPUWyp6VwKly+9z
a4qfKi4Qc9gltdWvCCnWO4PU5KLTBXoAGabwbpBNpNKFEbP0zBY=
=Aruu
-----END PGP SIGNATURE-----

--l7Y+PczdZalVEeDS--
