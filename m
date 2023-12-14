Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GdvpayY9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KBcAqtDi"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51FD118
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 05:37:18 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 191C15C01B7;
	Thu, 14 Dec 2023 08:37:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 14 Dec 2023 08:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702561038; x=1702647438; bh=izuZYshyx+
	gHoMxy+8YwIOYTB9TabCJeQTAjhEfklnk=; b=GdvpayY9NbLGkYRX7SwyMnnbB+
	X7hBEpoHiVDO40eq4sssIqyS+VNCuEjtPnAr1OB2hTpiUsGHLLENahToShxI3apq
	0Rr3sPBXeYwhlNU4bhXNHgidXG6gl+sMOzIw5g1Ibmfb1dEzXgurQvhqYaaNo8q7
	WS8GdydAwsMK9H5HSerTu9potOA+mqiTV+5k4bRj8AgbHGQq80kcEmQuAhu4qsyb
	HUbVGSOqj+raxirIoHiE3H89vjEeixy1XDkvkQ31wqh2qUWaZ1rS4VrhYU35/XdA
	YrkPTvH/i7r24BOekpw1K2fqNYEoqU89AOaHjzt7YMwWDZmq9pz5V2dnJmdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702561038; x=1702647438; bh=izuZYshyx+gHoMxy+8YwIOYTB9Ta
	bCJeQTAjhEfklnk=; b=KBcAqtDiP/ad3V5JZeK2Et2SKe13iHsIsgi8jc0ZkE30
	42FG5B8dMhpYb2EK+e9thEEdKDTuDd6A+vaHPD743whvwF+bztkJAraxcGrh5xeY
	nw5+ZEd8YNaL4E6Xu+F0mjzt7TqkwMwwINIz6YCjs461JgxVgRUL54pPpmMABsTm
	nKWQht6THoWZbKzJmtJw7IhqiD6zYe6HbuiMr7WA66/hsHOChfhJoOswCTDhkq0d
	1e3/G2V6VsSwsGDkUqVpA1RArnV4SCRWVbXpNe7wKy3/nN6OP0sMbSH0Y+ayd/uv
	Te/coCIMdLwaiyww7KtzdTIcRp3gAqWKbsnSCiSi2A==
X-ME-Sender: <xms:DQV7ZdwyVX_RC1FmkoXgden_vOKQFccvbCAU3SbAtJDGZ87lzr8VTg>
    <xme:DQV7ZdRrvrUNoP-4jDN2HTMTVnh1FjqrbZtzO1vTh8XVppWXBDXkuZ6N5wq4Blzbp
    pdKqrEqHrr60zuVTg>
X-ME-Received: <xmr:DQV7ZXW5xK0GZlGNvuUwD3FHgwMsL74piL2fFraGTzlYY3jU-kQoHC2TbsF5aC9l9JSaoV5_9iQze31hkigfjPOm58p1DR7Fd6pUPiiN4BI8sc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:DQV7ZfiAIW4IMyMJC4PTbiEAOM9WXUkmyzLdzAa38cdoNwYkhQftPQ>
    <xmx:DQV7ZfB9Bi9zPhR6l-6-_edNK9FErkV8BqSVPgIRRPGGbd_raAZdzQ>
    <xmx:DQV7ZYLbD5X_nAN7d4ciM7JMSV0vQGsY_h-eaggcMLhzh91IoRpkbA>
    <xmx:DgV7ZSNZiRjK2lltj-b_zMvoRJGQifcixf6P1AV_HAF0wL7M9S8WRg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 08:37:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 95bca8e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Dec 2023 13:35:33 +0000 (UTC)
Date: Thu, 14 Dec 2023 14:37:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 4/4] bisect: consistently write BISECT_EXPECTED_REV via
 the refdb
Message-ID: <324467816187a8d29407f03006c936b5938f811c.1702560829.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702560829.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KsUGRoWdhMrbnBZ0"
Content-Disposition: inline
In-Reply-To: <cover.1702560829.git.ps@pks.im>


--KsUGRoWdhMrbnBZ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're inconsistently writing BISECT_EXPECTED_REV both via the filesystem
and via the refdb, which violates the newly established rules for how
special refs must be treated. This works alright in practice with the
reffiles reference backend, but will cause bugs once we gain additional
backends.

Fix this issue and consistently write BISECT_EXPECTED_REV via the refdb
so that it is no longer a special ref.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c                    | 25 ++++---------------------
 builtin/bisect.c            |  8 ++------
 refs.c                      |  3 ++-
 t/t6030-bisect-porcelain.sh |  2 +-
 4 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/bisect.c b/bisect.c
index 1be8e0a271..985b96ed13 100644
--- a/bisect.c
+++ b/bisect.c
@@ -471,7 +471,6 @@ static int read_bisect_refs(void)
 }
=20
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
-static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
@@ -707,26 +706,10 @@ static enum bisect_error error_if_skipped_commits(str=
uct commit_list *tried,
=20
 static int is_expected_rev(const struct object_id *oid)
 {
-	const char *filename =3D git_path_bisect_expected_rev();
-	struct stat st;
-	struct strbuf str =3D STRBUF_INIT;
-	FILE *fp;
-	int res =3D 0;
-
-	if (stat(filename, &st) || !S_ISREG(st.st_mode))
+	struct object_id expected_oid;
+	if (read_ref("BISECT_EXPECTED_REV", &expected_oid))
 		return 0;
-
-	fp =3D fopen_or_warn(filename, "r");
-	if (!fp)
-		return 0;
-
-	if (strbuf_getline_lf(&str, fp) !=3D EOF)
-		res =3D !strcmp(str.buf, oid_to_hex(oid));
-
-	strbuf_release(&str);
-	fclose(fp);
-
-	return res;
+	return oideq(oid, &expected_oid);
 }
=20
 enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
@@ -1185,10 +1168,10 @@ int bisect_clean_state(void)
 	struct string_list refs_for_removal =3D STRING_LIST_INIT_NODUP;
 	for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_remov=
al);
 	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
+	string_list_append(&refs_for_removal, xstrdup("BISECT_EXPECTED_REV"));
 	result =3D delete_refs("bisect: remove", &refs_for_removal, REF_NO_DEREF);
 	refs_for_removal.strdup_strings =3D 1;
 	string_list_clear(&refs_for_removal, 0);
-	unlink_or_warn(git_path_bisect_expected_rev());
 	unlink_or_warn(git_path_bisect_ancestors_ok());
 	unlink_or_warn(git_path_bisect_log());
 	unlink_or_warn(git_path_bisect_names());
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 35938b05fd..4e2c43daf5 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -17,7 +17,6 @@
 #include "revision.h"
=20
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
-static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
@@ -921,7 +920,6 @@ static enum bisect_error bisect_state(struct bisect_ter=
ms *terms, int argc,
 	const char *state;
 	int i, verify_expected =3D 1;
 	struct object_id oid, expected;
-	struct strbuf buf =3D STRBUF_INIT;
 	struct oid_array revs =3D OID_ARRAY_INIT;
=20
 	if (!argc)
@@ -976,10 +974,8 @@ static enum bisect_error bisect_state(struct bisect_te=
rms *terms, int argc,
 		oid_array_append(&revs, &commit->object.oid);
 	}
=20
-	if (strbuf_read_file(&buf, git_path_bisect_expected_rev(), 0) < the_hash_=
algo->hexsz ||
-	    get_oid_hex(buf.buf, &expected) < 0)
+	if (read_ref("BISECT_EXPECTED_REV", &expected))
 		verify_expected =3D 0; /* Ignore invalid file contents */
-	strbuf_release(&buf);
=20
 	for (i =3D 0; i < revs.nr; i++) {
 		if (bisect_write(state, oid_to_hex(&revs.oid[i]), terms, 0)) {
@@ -988,7 +984,7 @@ static enum bisect_error bisect_state(struct bisect_ter=
ms *terms, int argc,
 		}
 		if (verify_expected && !oideq(&revs.oid[i], &expected)) {
 			unlink_or_warn(git_path_bisect_ancestors_ok());
-			unlink_or_warn(git_path_bisect_expected_rev());
+			delete_ref(NULL, "BISECT_EXPECTED_REV", NULL, REF_NO_DEREF);
 			verify_expected =3D 0;
 		}
 	}
diff --git a/refs.c b/refs.c
index 8fe34d51e4..c76ce86bef 100644
--- a/refs.c
+++ b/refs.c
@@ -1840,6 +1840,8 @@ static int is_special_ref(const char *refname)
 	 * There are some exceptions that you might expect to see on this list
 	 * but which are handled exclusively via the reference backend:
 	 *
+	 * - BISECT_EXPECTED_REV
+	 *
 	 * - CHERRY_PICK_HEAD
 	 *
 	 * - HEAD
@@ -1857,7 +1859,6 @@ static int is_special_ref(const char *refname)
 	 */
 	static const char * const special_refs[] =3D {
 		"AUTO_MERGE",
-		"BISECT_EXPECTED_REV",
 		"FETCH_HEAD",
 		"MERGE_AUTOSTASH",
 		"MERGE_HEAD",
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 2a5b7d8379..792c1504bc 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1176,7 +1176,7 @@ test_expect_success 'git bisect reset cleans bisectio=
n state properly' '
 	git bisect bad $HASH4 &&
 	git bisect reset &&
 	test -z "$(git for-each-ref "refs/bisect/*")" &&
-	test_path_is_missing ".git/BISECT_EXPECTED_REV" &&
+	test_ref_missing BISECT_EXPECTED_REV &&
 	test_path_is_missing ".git/BISECT_ANCESTORS_OK" &&
 	test_path_is_missing ".git/BISECT_LOG" &&
 	test_path_is_missing ".git/BISECT_RUN" &&
--=20
2.43.GIT


--KsUGRoWdhMrbnBZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV7BQgACgkQVbJhu7ck
PpTRyRAAlb9EANSBlXvD14S7LNdAclFrzrNBDbJhoI6xmZOZUxDFr1Zl/WMkocM6
235izPxbUZR+dq/7vnM4dRkBivzk9XxWmUXZMK+j3jiMWMvjjsvXeS8SMl/d0Lki
BChH+OyTOPRNbXoWA3lgCIr6Q7Lr1i2o12rE/cHQqoflrPnw9G2GsTNqFJlJazIr
LPKld+GiXYncdAuA5ocjIfMKTptdr6mQEnuDbwQKfI8mej+DZMFnfVbGM9wx8kF3
1/uTlLc/65MbX3VFUsxnxs2lU/tQwVdhQgNERaFLw0paHTU0nJX/QC3x+TGoup8a
cYY3BhsGPBCLXzaC88SW/t9Lg4dGQVF5sm0RBIX5Lac5SHCBuisYDFR86kG3fGcm
pGeu+rKIj/p217cKkSG32qUNuSBmM3Amd/nQAD9ZCzx8CyOV/VC2TaOA3Uy23rfj
nSlk0xGlg3zBw0XKVYJcAe+1o/xJjBAw4/lv1cMrCtrDRtRUQutJyG9VmLTJ7r0i
7MH1dhCOmcUXQZZZYzwQNJplHa6lGZ/PLnKyqn2vTp+nJMx2uLH31+almplJMpAS
70jbdoXk2URLr26tn0kCshx1Xu3As5eMl2kdt5oZPvpmagzJLHHTbT0VU3xcTQgn
xUJphGIqvkiWiue2GKVnmOGK7hkx5XHFRoi39+9D5aw8UX0nEuI=
=YLQy
-----END PGP SIGNATURE-----

--KsUGRoWdhMrbnBZ0--
