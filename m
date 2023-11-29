Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fNxe9dI4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O4G6ySN0"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8355D19BA
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 00:14:28 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id EB2CD5C019A;
	Wed, 29 Nov 2023 03:14:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 29 Nov 2023 03:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701245667; x=1701332067; bh=xK
	27o7VDe27hnbVqwWdMmD2PtEEFxQ3Fzpl8cSgo7wM=; b=fNxe9dI4qMjl6Xzl+V
	JM1j0kyoC3Ti0DwWZw0PN7p1qFP1iXeGXEm2cx6cdPaXUTgBSt0/PqRSmu2NIvEx
	9vr70pB0ANCGFIGN9fy41q+gUavQnYCI/lLbgvQHMBdbsnkNB9DBltpLR4hNA1Rd
	Pl4wE63IjOw2qeJJW7oX9qJ7W3GOLmkglJrf/RoKgbRSsgvKhM4QHVEGz81hMMj1
	MIOX88LnFx4T04fxnJH3BlWlFMYZFBBGhLC6x181fuHBq2OIUTjfwjvBoV55H0Gj
	HFySiJG7Y5jVWoY4N2a9HRmfD98KE0oKgUP4upF8Ouxth3mCUTCJSu6b+hDqi97d
	RkSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701245667; x=1701332067; bh=xK27o7VDe27hn
	bVqwWdMmD2PtEEFxQ3Fzpl8cSgo7wM=; b=O4G6ySN01JQJdO7Le6TKJglEUCVbh
	xA0YcLVWghguoaTD92qOg2Jm8KZM0Abe7NHkbeALFtai3ADOcix6/HRO60WBUuoI
	ahbna0159knqr59XLNAU2riwU0Mr0FxEfPXpiNN+4+FAZLdm7l/LsF9PXxjUNPhJ
	QrTtVHa3POv+8RyCaW0eIkUEzknvJ8kT/bpp2i5G3N5O62pL+8LcN/viCwHgGWHc
	Q8rtHR3OIeyAgFiq8WG+PmW2Egv0nfm2T0yAHVlAFMdOEyGW5r3fhSnM8JyCGx3U
	Y7sYU/HgvQO0NW++ACpWFbXfMUXl//pnF/RuLQwI6ujW4MYLa6mFW45Zw==
X-ME-Sender: <xms:4_JmZenSJrygLp6YGO_w5i6uBiI_OVMieMnoeEIJspjRyPp4OotZuQ>
    <xme:4_JmZV0_x8IIj-uWn8-Myo6Kte4hVDL0uKunFSrFbmIrjP4K72Onq6cXcoA7Nyw2g
    z1W6f4FqWPMcgSevw>
X-ME-Received: <xmr:4_JmZcrg3_iIOZ2_wkdcSCerBySAM0bOA-fe-gPP6mTveyMgtmiXf2AGd2--M6jpWqYLKwoA-vIdSde_hyfueLsEsRNbMU6311bZhFhdZ0iHCRph>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:4_JmZSmeY8YtzERQUdayBmbhJ3fQfWamotI79Oo2r4FTjr7E0IV83w>
    <xmx:4_JmZc3xkpBNFryY4V-oj3yfB7ocRoHpmTh0SGmexPiAhwuzvV1mPA>
    <xmx:4_JmZZu-scPYJhHMRg9rFz_RjESzTl1qBaSzleSzxiZp6NYsNArRHQ>
    <xmx:4_JmZR-N-DzXAQ9V7_myG1nC8inUQysaEbDeX7Bl1YFkvbRfdVx_eg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Nov 2023 03:14:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c18b7d75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 Nov 2023 08:13:16 +0000 (UTC)
Date: Wed, 29 Nov 2023 09:14:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: hanwenn@gmail.com
Subject: [PATCH 4/4] bisect: consistently write BISECT_EXPECTED_REV via the
 refdb
Message-ID: <c7ab26fb7e9e24b12b83dc26fbc17ff4d96e206c.1701243201.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lEo4YCPgV7HHHxyM"
Content-Disposition: inline
In-Reply-To: <cover.1701243201.git.ps@pks.im>


--lEo4YCPgV7HHHxyM
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
 refs.c                      |  2 +-
 t/t6030-bisect-porcelain.sh |  2 +-
 4 files changed, 8 insertions(+), 29 deletions(-)

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
index 2d39d3fe80..0290bb0c67 100644
--- a/refs.c
+++ b/refs.c
@@ -1845,6 +1845,7 @@ static int is_special_ref(const char *refname)
 	 * There are some exceptions that you might expect to see on this list
 	 * but which are handled exclusively via the reference backend:
 	 *
+	 * - BISECT_EXPECTED_REV
 	 * - CHERRY_PICK_HEAD
 	 * - HEAD
 	 * - ORIG_HEAD
@@ -1855,7 +1856,6 @@ static int is_special_ref(const char *refname)
 	 */
 	const char * const special_refs[] =3D {
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
2.43.0


--lEo4YCPgV7HHHxyM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm8uAACgkQVbJhu7ck
PpTjzQ/+OuTkCE2PyxIQb2a3bSQicsam+d0zqGAmMp/e1OfJ0W3LM6AD14kgQqt7
dEo6Cl1opL7kG3oEcmcbcGNW/jELqlarHV0jai/UH3p+jvnMMXRdEbVvbgIs/NLG
ObgKkQmHvDPlqN+rGbQquZ77i8su34ME9MsqZrq+wmyGpP9vPfMmK4PGNSCR+t+s
B/v0Ppet8dV8uk3GYJ0ySg8viu3jKQdZ8itYTdA+oPyGU1LNZD83JY/uTh1hEwNI
M0M5Yqe2JsyNF7w8S4W1dQ6g/QHmsjMLk4O7ShmameCI2tP9wya6qQCZ8W+Id+Zu
a4/ikcB0AUjwWKOX9YlMnhIlmaJ8Ibjzo5rX+KiQ6WbyyJBlOQf7c7JdeDTMh6iA
wZwu7XWYlUQ73j0H42/TefF6x7WRJmElEUnQGrzjxHxZBcH38gTqj9QFnYdLVhQ5
1oLvHvPY3EPFXG2C7z/0kID9waDmxGo5z4qnxSNDFMv8AtlWrGQMlW/pSFg90Svz
tiUPSaJMFtVJZDljUiK54si3zqeIbcZcitLebME20M+E1bvZObH9TWW0c5H0a8Zz
fmEXEqtH8yCD7De4DfrNNpdOmhB4+RnnkRU3Xs+RwJX3z8Pz230/t2ggLe6mmHhq
lAEP1bdMNni7IFBpJu0UGxnWnA8jhlH4P8MHrI6cyE9kANW7wJU=
=YwHI
-----END PGP SIGNATURE-----

--lEo4YCPgV7HHHxyM--
