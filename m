Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF8199DC
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OAwsq2Y3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gaH+tfax"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED88C9
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:17:03 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 1406732007E8;
	Tue, 31 Oct 2023 04:17:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 31 Oct 2023 04:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740222; x=1698826622; bh=4T
	W7BSEpfmYO0ABNtA839AM6M2SkjOnsi6HJ4/11Xq0=; b=OAwsq2Y3eOMn9xWOWQ
	EThe4akzhek5y65xI7Ojgz/QD21rs9iCCIu9SaI/uz4CsYq6qE3gCjkGua3QhTwS
	o05QsZRf9LVQc+MUIN7Iy/zBqhYOC5rOHj6mBBvt290i4Nz3W+Qnr6hXk623s6KQ
	lumd2cI4KBz43xyAakFfpdmYdjYG6yTDC0vhAyykkKSQAhOT1jr4wUFmsNxPrEDy
	dp9YnOWMdhbP8B/k3Q8cSNLph1/V0LVJb+W4wOZrWyQCGTtt3vYTIA56EyIHUdIq
	ycWxZE8ObaxB+w4FSGNcwxUnFnYoPjMxp4GRxK49GUSRL34T6F4uIQbXcR+s5KQR
	Fi0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740222; x=1698826622; bh=4TW7BSEpfmYO0
	ABNtA839AM6M2SkjOnsi6HJ4/11Xq0=; b=gaH+tfax1ix89Xeu5gpJPv9bnaSBG
	POeG84DWd/fcqQXk9HoyAnflSHGBc889KXRcH71QZ4zEg4G15/GZkUiCgnLKxPci
	bDojkp2T9fLnzwtH33NYqTiacAjB4+AEU+lyVP3Ie8tCn42wOmgjD7VbhUM3fzr9
	9XCbFewGHT2LLWE/tecdUWvwmcGuyoN54MrikcFw7TVYIFfePbGC+cgJnpeUKwTJ
	9xjwkPTLWdpY9AM4rOZa9wK3bjXzFxGzeifx1MRSY1wjI7/QddJiZo09/5aAqdhJ
	WoK1y24VqP4BetMt9ftWFUVhCsMtXYQw2LiT8bWacHJFfKqJzkNH0dwng==
X-ME-Sender: <xms:_rdAZSZO2zA-N29reSz1aGHBQk3GT3vbx7zWmrrTRiCRep0SZ_yvNQ>
    <xme:_rdAZVaGlBysPfNwqWltNG_0QfsW1ewBPjvr16T-WGxvpPjyWhzDMrrqZUDH3-6j_
    ZoL_upcXML6ejN5cw>
X-ME-Received: <xmr:_rdAZc_Olv6Qzv2dsQn-iA3IcT378n9Q8fP6YcLPXPlN7SkUNpdNA9V_Fp-oxFZbG21IiuNtobzq6KoWcjNiqq-FJqxOSX8hD6HjJSViS3bShOIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:_rdAZUp0u1HIcSAmPs0e_I0jm3U9oSskTgKo99VM4OSZ9ZTH27jeQg>
    <xmx:_rdAZdrDxtOJ1Tf8VzWfsmhKkmuHPL_E6xCza08sTwMUwvksIHpMHQ>
    <xmx:_rdAZSTcddlHnuc9WqXQatIuZyOZfDeVEVLk0DDQ-gd8IdaWGge0qA>
    <xmx:_rdAZUUiyE6iIjWn_XQw-u6sHsgk75GYnK-h_LDazBSkeKZi7UXGjg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:17:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5adf938b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:53 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 12/12] t: use git-show-ref(1) to check for ref existence
Message-ID: <ea9919fe8991676788e37d07e8e25c475f13ed6f.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hI2SCa0IBH51N4pW"
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>


--hI2SCa0IBH51N4pW
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


--hI2SCa0IBH51N4pW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt/oACgkQVbJhu7ck
PpS9Tg//U6XP/fFzmLH81HlEC31iviMVz0azD0aQaFKXFkx3QmGSbNu2Afk/AsCH
EoSXBU4uVoWohJFkdyZGqQi8RxdVz/uP34gU7S6MUL15Lajqo1xlMb7BteF5vg5A
tDuZApLqOAWHI7KFnhC8wCzltyxWIpkKQS97AGsZjwgAmNGcA+BKr8MoE6U6Tr6J
ui+Jtr3kh7N67gGYrjdUGg+PsGsa3YaCBiOaNGVqDDmUnixg2pjGPENvHlie+bzW
T0KkfRfUtXkHMGMm4tt4C5l/cmqlTGW4kmtxuIhu7T0RN18g01W8+38XbGbbsqXo
Clws+RRqfsEj79JoAE2aGRCPKexZsuCtQ3SIrM8VBfwuqnuhYCPrRkgpDcQDVrUr
6d3rAflmU9NUoC4lXNrx4n0DW/WLnUgezdWMq4wlWtQ6cBG0nMStWvJ5+UjvEIiT
0sg0HNQD4/Lg/U9JSf6kIRuBFoyZwvmnkAEMn0oSjYOCjm3W8KzUkrWWLnjjrogY
OicMXFR7hTlMO+cKnbeLd5G3uIPcVgXbIHWlc6QlTWw7nlVi6hIdH+PtnJCVwdVo
CU/k2T2CkYfHyKksChAqJ6shPDnu98SplhAQfpcXGucMJlelv6YudjuWiBcoshto
nJD8vZVVA8wTMLwS7bK4IVX5Pmd1HSHfFUEzOxnwD1kfpGMwQB8=
=Ew41
-----END PGP SIGNATURE-----

--hI2SCa0IBH51N4pW--
