Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA82D044
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l9vfg1Cr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NNCOF3cy"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2BF1A2
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:57:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 5E1EA320098F;
	Thu, 26 Oct 2023 05:57:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 26 Oct 2023 05:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314232; x=1698400632; bh=Uf
	1911WsHOmDtsRt3akYNgUmbHiyQeFp6FwE3Yq4SEg=; b=l9vfg1CruotSvATk9/
	oIIAT90WLOHDNlQI+r9yVflL+arpNXcq9hHagTzdXuWaYQILI/0ws1eGuqbQbG3C
	pcKHx0gJv5jfPW5OH4Mz8W4YABf2Cmn+i2FaseMomlUFRP/ScovkLLOIHV4o6K1U
	52GOHuJLJHoJwZqCEmUajvFyTTsisswCJgtkthJQepenlUMlR8hFQAF/fLI/Z2Ne
	fJBKyBxsZuzLqvfbuPGbLDPqRcgPcEjcxgux/WDA6ywVznSxkbEu25dAruyCfPXV
	LoJA1nheZKzOfwmggl1yFEFovdGCnn0ujfS6gh49sn03Czt4pl6A8GWND45SezZQ
	k4qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314232; x=1698400632; bh=Uf1911WsHOmDt
	sRt3akYNgUmbHiyQeFp6FwE3Yq4SEg=; b=NNCOF3cyISJ+B1muMLii7N5wCkEoz
	PzoAeSmf9fRAd2nd6Y2Y/37kogImXrR9owzs5XYRh8m0Ha08qZ7JyoWQm2JajUB7
	S3Yn+j+I2yGOfTDGSTxVtmePdZqRHwZcbJ/4arsjBpr5FZ2O2q81Di5u2j3HT9/4
	RJtY/lE3G+4/otLUgwu+KQCUh4SeRr9y4KoHgK+NE5R2DcBBn99yQG6QGXDFN7sU
	AC+4oeD0/jiVaG/25H2+85soPfAnBoDW9lznNDFUMkXOwX345wbw7gC3gg/zq9+X
	vE6plv9ZCGWg6axlQKFjBrQVJX3l6kBAIOBPMkYO9a/JUYeHGSR8XOypQ==
X-ME-Sender: <xms:-Dc6ZVr0EElgEnw7GIvQv9EEzIayFTKvivga9VPiVBXnfXI9Kk024w>
    <xme:-Dc6ZXoCr-523v43k9vvisxuHH02siFYL95IQdPRF_IhwAUwA8xFs0phuCQCe9gxO
    3thOJ5cXCjW-vJjAA>
X-ME-Received: <xmr:-Dc6ZSMClujJuj9TUg22RQBfD00QqPtGF9Tu_N_GSN36TcfRPtXCLbDj2hA-txSH6xPTieTYOzfCrYixp8ErbujzbyG4oyrMaKiHuvWZr2XxNFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:-Dc6ZQ7H8WRo8FUf5S2y3ERxfZL0l8wLooAbCBqh4Bwv-slTZe_NpQ>
    <xmx:-Dc6ZU4Z9BQyfy2KT94FdT_YseYUrmbo89wqkv-5LYoRUrDwlu_nmg>
    <xmx:-Dc6ZYh2ebPye_k_H3_32Gp0NhmHLxHu5TLECe6OFKEwMUxsN-FKpg>
    <xmx:-Dc6ZUHCPyZx9GoJYtcOLKIuurEr09wHr8rBfJDh97jYsFYXkpeHGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:57:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f96a3f05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:57:03 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:57:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 12/12] t: use git-show-ref(1) to check for ref existence
Message-ID: <226731c5f18abbbff8fd23cc0f1263b3970ff5eb.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+M/Qv7UYMg2OPSPb"
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>


--+M/Qv7UYMg2OPSPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert tests that use `test_path_is_file` and `test_path_is_missing` to
instead use a set of helpers `test_ref_exists` and `test_ref_missing`.
These helpers are implemented via the newly introduced `git show-ref
--exists` command. Thus, we can avoid intimate knowledge of how the ref
backend stores references on disk.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1430-bad-ref-name.sh | 27 +++++++++++++-------
 t/t3200-branch.sh       | 33 ++++++++++++++-----------
 t/t5521-pull-options.sh |  4 +--
 t/t5605-clone-local.sh  |  2 +-
 t/test-lib-functions.sh | 55 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 27 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index ff1c967d550..7b7d6953c62 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -205,8 +205,9 @@ test_expect_success 'update-ref --no-deref -d can delet=
e symref to broken name'
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...ref" &&
 	test-tool ref-store main create-symref refs/heads/badname refs/heads/brok=
en...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/badname" &&
+	test_ref_exists refs/heads/badname &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
-	test_path_is_missing .git/refs/heads/badname &&
+	test_ref_missing refs/heads/badname &&
 	test_must_be_empty output &&
 	test_must_be_empty error
 '
@@ -216,8 +217,9 @@ test_expect_success 'branch -d can delete symref to bro=
ken name' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...ref" &&
 	test-tool ref-store main create-symref refs/heads/badname refs/heads/brok=
en...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/badname" &&
+	test_ref_exists refs/heads/badname &&
 	git branch -d badname >output 2>error &&
-	test_path_is_missing .git/refs/heads/badname &&
+	test_ref_missing refs/heads/badname &&
 	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" o=
utput &&
 	test_must_be_empty error
 '
@@ -225,8 +227,9 @@ test_expect_success 'branch -d can delete symref to bro=
ken name' '
 test_expect_success 'update-ref --no-deref -d can delete dangling symref t=
o broken name' '
 	test-tool ref-store main create-symref refs/heads/badname refs/heads/brok=
en...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/badname" &&
+	test_ref_exists refs/heads/badname &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
-	test_path_is_missing .git/refs/heads/badname &&
+	test_ref_missing refs/heads/badname &&
 	test_must_be_empty output &&
 	test_must_be_empty error
 '
@@ -234,8 +237,9 @@ test_expect_success 'update-ref --no-deref -d can delet=
e dangling symref to brok
 test_expect_success 'branch -d can delete dangling symref to broken name' '
 	test-tool ref-store main create-symref refs/heads/badname refs/heads/brok=
en...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/badname" &&
+	test_ref_exists refs/heads/badname &&
 	git branch -d badname >output 2>error &&
-	test_path_is_missing .git/refs/heads/badname &&
+	test_ref_missing refs/heads/badname &&
 	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" o=
utput &&
 	test_must_be_empty error
 '
@@ -245,8 +249,9 @@ test_expect_success 'update-ref -d can delete broken na=
me through symref' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...ref" &&
 	test-tool ref-store main create-symref refs/heads/badname refs/heads/brok=
en...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/badname" &&
+	test_ref_exists refs/heads/broken...ref &&
 	git update-ref -d refs/heads/badname >output 2>error &&
-	test_path_is_missing .git/refs/heads/broken...ref &&
+	test_ref_missing refs/heads/broken...ref &&
 	test_must_be_empty output &&
 	test_must_be_empty error
 '
@@ -254,8 +259,9 @@ test_expect_success 'update-ref -d can delete broken na=
me through symref' '
 test_expect_success 'update-ref --no-deref -d can delete symref with broke=
n name' '
 	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
+	test_ref_exists refs/heads/broken...symref &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
-	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_ref_missing refs/heads/broken...symref &&
 	test_must_be_empty output &&
 	test_must_be_empty error
 '
@@ -263,8 +269,9 @@ test_expect_success 'update-ref --no-deref -d can delet=
e symref with broken name
 test_expect_success 'branch -d can delete symref with broken name' '
 	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
+	test_ref_exists refs/heads/broken...symref &&
 	git branch -d broken...symref >output 2>error &&
-	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_ref_missing refs/heads/broken...symref &&
 	test_i18ngrep "Deleted branch broken...symref (was refs/heads/main)" outp=
ut &&
 	test_must_be_empty error
 '
@@ -272,8 +279,9 @@ test_expect_success 'branch -d can delete symref with b=
roken name' '
 test_expect_success 'update-ref --no-deref -d can delete dangling symref w=
ith broken name' '
 	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
+	test_ref_exists refs/heads/broken...symref &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
-	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_ref_missing refs/heads/broken...symref &&
 	test_must_be_empty output &&
 	test_must_be_empty error
 '
@@ -281,8 +289,9 @@ test_expect_success 'update-ref --no-deref -d can delet=
e dangling symref with br
 test_expect_success 'branch -d can delete dangling symref with broken name=
' '
 	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
+	test_ref_exists refs/heads/broken...symref &&
 	git branch -d broken...symref >output 2>error &&
-	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_ref_missing refs/heads/broken...symref &&
 	test_i18ngrep "Deleted branch broken...symref (was refs/heads/idonotexist=
)" output &&
 	test_must_be_empty error
 '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 080e4f24a6e..bde4f1485b7 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -25,7 +25,7 @@ test_expect_success 'prepare a trivial repository' '
=20
 test_expect_success 'git branch --help should not have created a bogus bra=
nch' '
 	test_might_fail git branch --man --help </dev/null >/dev/null 2>&1 &&
-	test_path_is_missing .git/refs/heads/--help
+	test_ref_missing refs/heads/--help
 '
=20
 test_expect_success 'branch -h in broken repository' '
@@ -40,7 +40,8 @@ test_expect_success 'branch -h in broken repository' '
 '
=20
 test_expect_success 'git branch abc should create a branch' '
-	git branch abc && test_path_is_file .git/refs/heads/abc
+	git branch abc &&
+	test_ref_exists refs/heads/abc
 '
=20
 test_expect_success 'git branch abc should fail when abc exists' '
@@ -61,11 +62,13 @@ test_expect_success 'git branch --force abc should succ=
eed when abc exists' '
 '
=20
 test_expect_success 'git branch a/b/c should create a branch' '
-	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
+	git branch a/b/c &&
+	test_ref_exists refs/heads/a/b/c
 '
=20
 test_expect_success 'git branch mb main... should create a branch' '
-	git branch mb main... && test_path_is_file .git/refs/heads/mb
+	git branch mb main... &&
+	test_ref_exists refs/heads/mb
 '
=20
 test_expect_success 'git branch HEAD should fail' '
@@ -78,14 +81,14 @@ EOF
 test_expect_success 'git branch --create-reflog d/e/f should create a bran=
ch and a log' '
 	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
 	git -c core.logallrefupdates=3Dfalse branch --create-reflog d/e/f &&
-	test_path_is_file .git/refs/heads/d/e/f &&
+	test_ref_exists refs/heads/d/e/f &&
 	test_path_is_file .git/logs/refs/heads/d/e/f &&
 	test_cmp expect .git/logs/refs/heads/d/e/f
 '
=20
 test_expect_success 'git branch -d d/e/f should delete a branch and a log'=
 '
 	git branch -d d/e/f &&
-	test_path_is_missing .git/refs/heads/d/e/f &&
+	test_ref_missing refs/heads/d/e/f &&
 	test_must_fail git reflog exists refs/heads/d/e/f
 '
=20
@@ -213,7 +216,7 @@ test_expect_success 'git branch -M should leave orphane=
d HEAD alone' '
 		test_commit initial &&
 		git checkout --orphan lonely &&
 		grep lonely .git/HEAD &&
-		test_path_is_missing .git/refs/head/lonely &&
+		test_ref_missing refs/head/lonely &&
 		git branch -M main mistress &&
 		grep lonely .git/HEAD
 	)
@@ -799,8 +802,8 @@ test_expect_success 'deleting a symref' '
 	git symbolic-ref refs/heads/symref refs/heads/target &&
 	echo "Deleted branch symref (was refs/heads/target)." >expect &&
 	git branch -d symref >actual &&
-	test_path_is_file .git/refs/heads/target &&
-	test_path_is_missing .git/refs/heads/symref &&
+	test_ref_exists refs/heads/target &&
+	test_ref_missing refs/heads/symref &&
 	test_cmp expect actual
 '
=20
@@ -809,16 +812,16 @@ test_expect_success 'deleting a dangling symref' '
 	test_path_is_file .git/refs/heads/dangling-symref &&
 	echo "Deleted branch dangling-symref (was nowhere)." >expect &&
 	git branch -d dangling-symref >actual &&
-	test_path_is_missing .git/refs/heads/dangling-symref &&
+	test_ref_missing refs/heads/dangling-symref &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'deleting a self-referential symref' '
 	git symbolic-ref refs/heads/self-reference refs/heads/self-reference &&
-	test_path_is_file .git/refs/heads/self-reference &&
+	test_ref_exists refs/heads/self-reference &&
 	echo "Deleted branch self-reference (was refs/heads/self-reference)." >ex=
pect &&
 	git branch -d self-reference >actual &&
-	test_path_is_missing .git/refs/heads/self-reference &&
+	test_ref_missing refs/heads/self-reference &&
 	test_cmp expect actual
 '
=20
@@ -826,8 +829,8 @@ test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/topic refs/heads/main &&
 	test_must_fail git branch -m topic new-topic &&
 	git symbolic-ref refs/heads/topic &&
-	test_path_is_file .git/refs/heads/main &&
-	test_path_is_missing .git/refs/heads/new-topic
+	test_ref_exists refs/heads/main &&
+	test_ref_missing refs/heads/new-topic
 '
=20
 test_expect_success SYMLINKS 'git branch -m u v should fail when the reflo=
g for u is a symlink' '
@@ -1142,7 +1145,7 @@ EOF
 test_expect_success 'git checkout -b g/h/i -l should create a branch and a=
 log' '
 	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
 	git checkout -b g/h/i -l main &&
-	test_path_is_file .git/refs/heads/g/h/i &&
+	test_ref_exists refs/heads/g/h/i &&
 	test_path_is_file .git/logs/refs/heads/g/h/i &&
 	test_cmp expect .git/logs/refs/heads/g/h/i
 '
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 079b2f2536e..3681859f983 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -143,7 +143,7 @@ test_expect_success 'git pull --dry-run' '
 		cd clonedry &&
 		git pull --dry-run ../parent &&
 		test_path_is_missing .git/FETCH_HEAD &&
-		test_path_is_missing .git/refs/heads/main &&
+		test_ref_missing refs/heads/main &&
 		test_path_is_missing .git/index &&
 		test_path_is_missing file
 	)
@@ -157,7 +157,7 @@ test_expect_success 'git pull --all --dry-run' '
 		git remote add origin ../parent &&
 		git pull --all --dry-run &&
 		test_path_is_missing .git/FETCH_HEAD &&
-		test_path_is_missing .git/refs/remotes/origin/main &&
+		test_ref_missing refs/remotes/origin/main &&
 		test_path_is_missing .git/index &&
 		test_path_is_missing file
 	)
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 1d7b1abda1a..946c5751885 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -69,7 +69,7 @@ test_expect_success 'local clone of repo with nonexistent=
 ref in HEAD' '
 	git clone a d &&
 	(cd d &&
 	git fetch &&
-	test ! -e .git/refs/remotes/origin/HEAD)
+	test_ref_missing refs/remotes/origin/HEAD)
 '
=20
 test_expect_success 'bundle clone without .bundle suffix' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2f8868caa17..56b33536ed1 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -251,6 +251,61 @@ debug () {
 	done
 }
=20
+# Usage: test_ref_exists [options] <ref>
+#
+#   -C <dir>:
+#      Run all git commands in directory <dir>
+#
+# This helper function checks whether a reference exists. Symrefs or objec=
t IDs
+# will not be resolved. Can be used to check references with bad names.
+test_ref_exists () {
+	local indir=3D
+
+	while test $# !=3D 0
+	do
+		case "$1" in
+		-C)
+			indir=3D"$2"
+			shift
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done &&
+
+	indir=3D${indir:+"$indir"/} &&
+
+	if test "$#" !=3D 1
+	then
+		BUG "expected exactly one reference"
+	fi &&
+
+	git ${indir:+ -C "$indir"} show-ref --exists "$1"
+}
+
+# Behaves the same as test_ref_exists, except that it checks for the absen=
ce of
+# a reference. This is preferable to `! test_ref_exists` as this function =
is
+# able to distinguish actually-missing references from other, generic erro=
rs.
+test_ref_missing () {
+	test_ref_exists "$@"
+	case "$?" in
+	2)
+		# This is the good case.
+		return 0
+		;;
+	0)
+		echo >&4 "test_ref_missing: reference exists"
+		return 1
+		;;
+	*)
+		echo >&4 "test_ref_missing: generic error"
+		return 1
+		;;
+	esac
+}
+
 # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]
 #   -C <dir>:
 #	Run all git commands in directory <dir>
--=20
2.42.0


--+M/Qv7UYMg2OPSPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N/UACgkQVbJhu7ck
PpQlVA/9Gz1X3rCeRgxlxqcR4rVkEl06/IRhVYEwpv9GU73MkyXR0JHYCOIxn5gn
4aY6Baqgf0ptTCPj62l7vTm5ax07mev9ivyEvNsf5Fiz3FuHiczcE0TU9gEE7dUQ
wMAvXA77JOsxjqTTlnYJyTV5/O1tXUbJnVezmBnC82Z6xULCmvIhQOYCGw6XSmTF
+wE5WL8RzCIiuwI8Vwcny5BSkBvu+L0rhnPmlzd8h6WeSA0V93tV+O8QOZ39DU3w
fvsQsstrmnMdTv9sAyt+AcAXbtMfgRwS7P/j3FqdeIxdy3wLSi2ZlBp9P70oVefP
Yi+z+DpUdvx8oomjrEEoFytN+D7MYVwmVFdD9RcdTTi8NHDwq/ZcKkQKZZFnqSkv
wv/OQCt3ZjHurOBe2Yw10NhTy3Agnro3o8lRbRs5KXJBeBX824s4c1ruRmuYdKnw
o2GcfazJkik89jVKS7Z2tQ6dEjYEWq//r4IUcYOTA5qIbIxTdE+zVS0/35uaSGfv
crpPFSqd9eo62LK5MYF6yQl6r+81XwxJBzHPPSnhysXRMawHMxaDcZdG4F3c02fp
hJFX0+hRmBGfX8C4ry4Mf9yddi8PVU3jD22U2rvxs41WST9fMlLzilg4CcW46lx6
HE3w/LwHe8jNFbKLAtcaarBXn2mlNG9fQ+yDoFuM3M3i2dDwqJk=
=f+ur
-----END PGP SIGNATURE-----

--+M/Qv7UYMg2OPSPb--
