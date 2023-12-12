Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UN9qxQbV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iSf+xFYS"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940DAA1
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:19:04 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id D97893200AB3;
	Tue, 12 Dec 2023 02:19:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Dec 2023 02:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702365543; x=1702451943; bh=ZwCofbSKxS
	i8NrVBA2eoxfdHO4uFsNIYjPn75hm1VRw=; b=UN9qxQbVvNAqRkVcN7EMb68BEa
	xEkH2aZkOiT5vLByIcTut9YLiDU22yhRg+ybrkkMztUvVlonp8goXsmcoas9hFB3
	Fr6WISiulHE6ANAnG2XseIZjgSuQbjprrX8Lt4k2kIjOFLp+1UyiZYGVe0iKSmfE
	p2TlJ7ALztvpqkqX2SM3mGq/fzJRq6/TcBfvHc09tpl6Zp1S13AdHsEY3TLV/ChB
	DaV3ePMo/9P5jLpHTS7M9zSxfOyjUg0xhczXkNNpp5cxvsRsu/EuVmEMAekh25K4
	fiEKBs18hFMJhb9SPG1i6cQLOoUTbtdHt5uqkv74GpUS+zPXuDKcwCfpa0MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702365543; x=1702451943; bh=ZwCofbSKxSi8NrVBA2eoxfdHO4uF
	sNIYjPn75hm1VRw=; b=iSf+xFYSxdaXS+S7CEoOQ+9Sg9n56cz6GYs5qiOJ7XIO
	xthar8IRLtKpxRmXivyuRapKYIxiv+0ExC0lYvx0A2qVQEu7Fu811wcn2SFy4SD8
	pmdQRctLcXPnx6upnkHpx+rIMjj5sJLj5q9J/zBpA699JoWZVSXNgL4tNMkiS9W7
	CXdID2QiOZXfYlvrIONQ6ZO1Fy7z/E12S568Wkv/mh6HZG1cjlNAuEEh+dlhn21v
	J9/tbcIiSFJQfAN6hvtqTiBJY7ScOLKqgzgvT4CRlnXd18IHq/OD3dpMZxgY45T6
	9+z+ZDs2nsPIVebKF3wZYwbUV/mXMuLQBC6yjvanRQ==
X-ME-Sender: <xms:Zwl4ZUQaiEmEO4P0aJlfHxWiZIUVGuYw1qJZPSQARSYN5hJcEH7weA>
    <xme:Zwl4ZRxjMg3m0lNck98mtX9W3EscY998X6wzkRR_FgqHoytignqxsJGQ4jLyCljUI
    fABuz7ECQNcAjSIsw>
X-ME-Received: <xmr:Zwl4ZR2zr4B1dqCtoLfLMNJXrViU8-y7vl5da6VhTJlst8m6Mtwmi4sl5KUMqimxldURh_yGgKx_3GEPdTubk6drqUhmIjfmqGjB20B4X_WXL9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Zwl4ZYC9Wi86zL11R3G9NpD9Hlje0iJ4R143lDCNbRcZT1-vqzMzoQ>
    <xmx:Zwl4ZdhzJ55o_o5xzR_ZdG9BuVstQZbxkmhVTf2PRFc1n3kLcJn4sQ>
    <xmx:Zwl4ZUr_5mSsnhJpAufnVfEqLjZj3pToGwWPGdgH2VNKc2wrugnGJw>
    <xmx:Zwl4Zdb4O3UByD6rbahE0gozKLkd77x3_8NpKUqtkOP5pVw6af1p0g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 02:19:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9b9ee6fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Dec 2023 07:17:24 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:19:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 4/4] bisect: consistently write BISECT_EXPECTED_REV via
 the refdb
Message-ID: <4a4447a3f5ba9ddef1c81703ef9231ee597c2946.1702365291.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702365291.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dMSRJQzq6TPuI51J"
Content-Disposition: inline
In-Reply-To: <cover.1702365291.git.ps@pks.im>


--dMSRJQzq6TPuI51J
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


--dMSRJQzq6TPuI51J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4CWQACgkQVbJhu7ck
PpQy/xAAiVxjRzdxqxhhiybmP7RjX40pdvXfhwdEDrs2PzyAzFSFCdw57fYt8N9b
CgqBklraT4wUWbfXZVdFf4aV/vnIIJpaDGbddkCNdVeZimf9kkoyGXY5THE4xjOT
6fcnFSBl2+r1d7075gtmAmcCXjMIHFnGapqeGRxnQ8p5F/+B6l2aPnwQG2nQvC8H
U9K5IkOBJ3Nm1s5ly/DJe73rt5FKxGrCudNV52+yjGeHuf09aWTGH/Qm+7iZxmzu
wFp7Qa4f3+qu/OpsgNORVWfK09J4pl38j5ECjs1t3jlxY1KVYx/uVzevxUuUgYt7
ybZIpm5WWP8WsF5HTglXH5Bovw2QL2WuEyCc20T18EnZbhyWmQ9umgvbKtljRsZe
YgozkLb7728XexIs4G1N8ywkjgKNjIIuKrawKhg4KIkkcMttGrTe+1TrCqdfeH3g
P7fK1UX6Qy1I6O/DHwwgNGGZf70Fwae01Q+/xX6KsmCzXbNmLnT0dTSShsgxHDXz
isHTsZ7bMdRcCf9LOJGvBDv9HqhQHz+SAdC3Gom80R2qJk/H6txateYS5ZwXPRUa
W7xi+ogYXb3Ogjth2w4Y6DdW2umaRKmEjKjw80JYZjSjYk1G9LBVXC9j9aupo/nz
vb0W7nTD/sju5lx42G7MIlDVRGlGjodvjQiUcA7IXTNunDX7Zyg=
=HCtg
-----END PGP SIGNATURE-----

--dMSRJQzq6TPuI51J--
