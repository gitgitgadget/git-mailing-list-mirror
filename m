Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833EEEB8
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cENSMzug";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7UTGFSs9"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 13C8C5C0185;
	Fri, 29 Dec 2023 02:27:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 29 Dec 2023 02:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834832; x=1703921232; bh=UzL1HpHeUl
	9TAiLzlcTtISqaBaHmxfLnaZYPjHz6vHc=; b=cENSMzugIINdSUT5ZlC9kYQx8f
	1srOQZOsnaZ/h8SlOi0cTl2ySX8zTfizfsiklqae6HNEvEM7Uak9uotzohYtyeTg
	NfXZrTbCJWW+ASQOcwD6iwhRqzCx6otGX3lkSXX+E8soObkZk0BMDs9JRs8YzMGB
	H0KVEXVBPC1flnW0O/l0LnHv+W67+chTI2fIQTMZDkK0unC7hNIDbpkA+LOwa/G/
	8bZtGM5Pgd22yahLTLT7E/0G20d3e7e7a2XmUgn7unn6EjqetUl6vNjcSWX0oF/I
	AyN2+VIIdOaEgvs7SwzBqUjni8RXAGStSdchs3rzwA0aKc4Q1rroFnA2+dNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834832; x=1703921232; bh=UzL1HpHeUl9TAiLzlcTtISqaBaHm
	xfLnaZYPjHz6vHc=; b=7UTGFSs9hD5cI+u4P1TGweu8sc4OfAefbjz5DdrkTrLK
	fXBBv5BMiY0j7IdxhEa/tOTh3D4W9oHV1bAyF/KcT0+wkyPIV/m4rYrSCZt6lsTH
	ht1J4hEzodjEY36yg3I26gDBze2jIO7sGxSvrqgJ+AfsjHqvpImSsrUER7ysCKiW
	9UqpRHjoHqymLNwEM12ZDtrJGf27dbBxGmhFbzexBbbFUchJVSS9G7tuU2lV5oKt
	ywK4nA8fozNnbvRefT4ev69M8aa6XB+YLdFKgn0QYO8H18pAKMsVWwPXTH/miIgp
	mPVvfxOoKMrBZY2J3a/IB97W99xy56e24ThIIK71jw==
X-ME-Sender: <xms:z3SOZaAYiULSTOB9tshfWIYfBR6gdNepP1_rwy6u25ExYmxvCbIv6w>
    <xme:z3SOZUhY9TuyO_ajJZrHwbGs0ZmQuPQA1e78W-u14bPebV2Roo3b31Y-fslxEhMs8
    MrM_wo2TdM_tEAj-w>
X-ME-Received: <xmr:z3SOZdmeh76rzfeFXESuo0ck1nRrBF4aCk3XNEBFvNww0Ug4aoDKSyOkpjxPUBp9AkwSf6Xbc7P8-G_yYnUSG1l_CyEhhNsSeTaQiLfoUgPNR68O1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:0HSOZYwEZduxlptApkSKCCeTG1b7aSpWaIB_vi66zEQxNpDUpoGGZA>
    <xmx:0HSOZfR7bAFtXKb9Yb2LTFXvBGfQciohoFJX8aBaF1puSobjRjhtXw>
    <xmx:0HSOZTabZHDkg1709pRmIsWWYQGeTMZgUjbeqwjyPmHmWRKRhsUy9g>
    <xmx:0HSOZaeTB8NX4hCUJefS8uZ84bGaAeSc1gqU4AJg_EUA67PqI-uX-w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:27:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e2066dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:55 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:27:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 11/12] builtin/clone: introduce `--ref-format=` value flag
Message-ID: <3f1cb6b9e57f4e164d2070913dad2cd3dfc1f3f1.1703833819.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703833818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iLx4QtH+QdluPp7z"
Content-Disposition: inline
In-Reply-To: <cover.1703833818.git.ps@pks.im>


--iLx4QtH+QdluPp7z
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
index 0fb3816d0c..f1635e0e8c 100644
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
+	unsigned int ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
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


--iLx4QtH+QdluPp7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdMwACgkQVbJhu7ck
PpSAyQ/+MQNhRWicjvYRhcJh1k5tm/94VYVlxwhCogY/SSKLU5ppuMkAPvEUSvtn
4gx4NEKAnQK+Rjzzan9IbNbZTAJnCWgKpSmNCtWBMpL8iihjhuIDWlpW6BCNzqyu
BSLFHxLMLfz7fOaRmq7Nb3XZYIDQgOlXdBrCQU6EsTqhlu/6OLZXdPdr8jhTxNCC
n8aL7yOFLlh794p3qPN2PZlqJeIHNOD501Lneeqx2wHb4AQ9dY77Nvunjb+1A2V+
Qvq4q0/Nds30aoAmbQqrkgGnX8xFNQ+Avavo39ihwG/uVBYHGgteizUu+BQSZWT7
Ej2lHCq6LgbvBh9a+6h2L1sWnltzHCdvbJ+IPJlBEg4Lp+v4V/N0YpK7+yFlJemh
4NJANaJr+EHsk8vOFH4FsrT/ICHewN27kjq0TIcbMcEFYn6j/C2blROGtTuVhgk3
T0uYyXdL6n0L7bdG9XYTy2P3ax8HiCk7vjvLlxfBc/tBQm2pd8KqxorNsaJ62JC8
APjBzRQRc+K/1pKEy/iv9eh6RBVaXIkP8gQIN+OirpOUbPJFy2lj46B9Lr/TYIU+
EWKBgOPpHpdfikwq383Qlxk5Ib0YyTfq10lXyZzS7RXLASb36U2zEFxxrMvOaVD2
QV6bEFaiFVnJBquq9iidExfJ9OTAua08G6bwFWPeIENAwHZ8myI=
=pCSl
-----END PGP SIGNATURE-----

--iLx4QtH+QdluPp7z--
