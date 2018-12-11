Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32FAD20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 21:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeLKVV4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 16:21:56 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:36402 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKVVz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 16:21:55 -0500
Received: by mail-wm1-f51.google.com with SMTP id a18so3825112wmj.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 13:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=up4tQ6C6BhUAlh9veD8Q6DDPw9YyLe3nDcHPdCzHdeI=;
        b=JgLvBPJqs6K/OTV4Vo2XVVb6sPG1uXHA+nm0JwDoe7d3v+Xnv9+GAdSH+rP0Khk1Fd
         /DcGpd+T4TwQ1vcLkPO1SlX/NOONMWJjm7uIZb398haNMPbMIfPOgBtBE91xnVdSVAn/
         ImvkomH6LS610caQg6ekusnHPInHJatR2c2FLNJTe8J4TkFYtMJPvw9m0O65/jumIxQ8
         tkjYGm105sCZ1FHMBJmnrboXVvnUrjoSf5IUyMVsC3CgMbwWXavgB+BsXkgeWF1AEFBp
         MOizV0ONWLGLOoYwDTP7EZC+GEf3FLkLmyXzj3cBoMXmmuLr2ARabFL7ZRwB2bi1pQMj
         YdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=up4tQ6C6BhUAlh9veD8Q6DDPw9YyLe3nDcHPdCzHdeI=;
        b=psPk/L3j+1fqtIR3urbpinCQgp/55Q7+wAAYTGF+FUi9YsfDoyBHDLec9nWySyyQd9
         ZKPOgzCc5BRqVWHVZMO5ISQYt/KCDzLrtwUTS/7wEzNwWE3qKiyGdKr+PXM8zr3zKTEC
         eYqHPPbD89uX12yn0n57InCqsgtyXVrD3ZdPJemqVm039NSIikDpVmBRC/U8fiNnozG+
         ZXfEW+75Wg1HK6bDMHfjmhnUSl57n8j8Rzh/4H0nf+EZM52h6a42M/u1M4SehgqxhnyB
         OkMMHGNUXAXog4eDpo/pbHUrPhE+6MTY6bk/69kb3LJQiEuHPWtI4uJU/VX9vvIPV75p
         CCiA==
X-Gm-Message-State: AA+aEWa0fqsIFL3+CEgJ3Wmab9ICZmiwn5+APobZooqehJGTzQeYXuy/
        96T6OOo3hamkqlINNx5ffLYUIUbhrzaETQ==
X-Google-Smtp-Source: AFSGD/VyiWDKdgi6pOBHwRu1iPNp3DljPrDDtpkIZ81pSwRUvtZTbbQ9GlacdrPAEIYIFtDzZ3+wrQ==
X-Received: by 2002:a1c:8c05:: with SMTP id o5mr3634885wmd.29.1544563312573;
        Tue, 11 Dec 2018 13:21:52 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g198sm1698118wmd.23.2018.12.11.13.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 13:21:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2
Date:   Tue, 11 Dec 2018 22:21:35 +0100
Message-Id: <20181211212135.21126-4-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181211135501.GA13731@sigill.intra.peff.net>
References: <20181211135501.GA13731@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark those tests that have behavior differences or bugs under
protocol.version=0.

Whether or not these tests should exhibit different behavior is
outside the scope of this change. Some (such as t5700-protocol-v1.sh)
clearly should, but others (such as t7406-submodule-update.sh) might
indicate bugs in the protocol v2 code.

Tracking down which is which is outside the scope of this
change. Let's first exhaustively annotate where the differences are,
so that we can spot future behavior differences or regressions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5500-fetch-pack.sh                | 4 +++-
 t/t5503-tagfollow.sh                 | 8 ++++----
 t/t5512-ls-remote.sh                 | 8 ++++----
 t/t5515-fetch-merge-logic.sh         | 1 +
 t/t5516-fetch-push.sh                | 3 ++-
 t/t5537-fetch-shallow.sh             | 3 ++-
 t/t5552-skipping-fetch-negotiator.sh | 1 +
 t/t5616-partial-clone.sh             | 3 ++-
 t/t5700-protocol-v1.sh               | 1 +
 t/t7406-submodule-update.sh          | 3 ++-
 10 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 086f2c40f6..9c18875c9c 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -41,7 +41,8 @@ pull_to_client () {
 	test_expect_success "$number pull" '
 		(
 			cd client &&
-			git fetch-pack -k -v .. $heads &&
+			GIT_TEST_PROTOCOL_VERSION=0 \
+				git fetch-pack -k -v .. $heads &&
 
 			case "$heads" in
 			    *A*)
@@ -440,6 +441,7 @@ test_expect_success 'setup tests for the --stdin parameter' '
 '
 
 test_expect_success 'fetch refs from cmdline' '
+	sane_unset GIT_TEST_PROTOCOL_VERSION &&
 	(
 		cd client &&
 		git fetch-pack --no-progress .. $(cat ../input)
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 4ca48f0276..220c677f24 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -56,7 +56,7 @@ test_expect_success 'fetch A (new commit : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_TRACE_PACKET=$UPATH git fetch &&
+		GIT_TRACE_PACKET=$UPATH GIT_TEST_PROTOCOL_VERSION=0 git fetch &&
 		test $A = $(git rev-parse --verify origin/master)
 	) &&
 	get_needs $U >actual &&
@@ -86,7 +86,7 @@ test_expect_success 'fetch C, T (new branch, tag : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_TRACE_PACKET=$UPATH git fetch &&
+		GIT_TRACE_PACKET=$UPATH GIT_TEST_PROTOCOL_VERSION=0 git fetch &&
 		test $C = $(git rev-parse --verify origin/cat) &&
 		test $T = $(git rev-parse --verify tag1) &&
 		test $A = $(git rev-parse --verify tag1^0)
@@ -122,7 +122,7 @@ test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_TRACE_PACKET=$UPATH git fetch &&
+		GIT_TRACE_PACKET=$UPATH GIT_TEST_PROTOCOL_VERSION=0 git fetch &&
 		test $B = $(git rev-parse --verify origin/master) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
 		test $S = $(git rev-parse --verify tag2)
@@ -146,7 +146,7 @@ test_expect_success 'new clone fetch master and tags' '
 		cd clone2 &&
 		git init &&
 		git remote add origin .. &&
-		GIT_TRACE_PACKET=$UPATH git fetch &&
+		GIT_TRACE_PACKET=$UPATH GIT_TEST_PROTOCOL_VERSION=0 git fetch &&
 		test $B = $(git rev-parse --verify origin/master) &&
 		test $S = $(git rev-parse --verify tag2) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index ca69636fd5..28420c4f77 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -223,7 +223,7 @@ test_expect_success 'ls-remote --symref' '
 	$(git rev-parse refs/tags/mark1.10)	refs/tags/mark1.10
 	$(git rev-parse refs/tags/mark1.2)	refs/tags/mark1.2
 	EOF
-	git ls-remote --symref >actual &&
+	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref >actual &&
 	test_cmp expect actual
 '
 
@@ -243,7 +243,7 @@ test_expect_failure 'ls-remote with filtered symref (--heads)' '
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
 	EOF
-	git ls-remote --symref --heads . >actual &&
+	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref --heads . >actual &&
 	test_cmp expect actual
 '
 
@@ -252,9 +252,9 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
 	EOF
-	git ls-remote --symref --heads . >actual &&
+	GIT_TEST_PROTOCOL_VERSION=0  git ls-remote --symref --heads . >actual &&
 	test_cmp expect actual &&
-	git ls-remote --symref . "refs/heads/*" >actual &&
+	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref . "refs/heads/*" >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 36b0dbc01c..2a3d1d84d6 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -7,6 +7,7 @@
 test_description='Merge logic in fetch'
 
 . ./test-lib.sh
+sane_unset GIT_TEST_PROTOCOL_VERSION
 
 LF='
 '
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 49e5d305e5..0722d288cd 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1129,7 +1129,8 @@ do
 	'
 done
 
-test_expect_success 'fetch exact SHA1' '
+test_expect_success 'fetch exact SHA1 in protocol v0' '
+	sane_unset GIT_TEST_PROTOCOL_VERSION &&
 	mk_test testrepo heads/master hidden/one &&
 	git push testrepo master:refs/hidden/one &&
 	(
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 6faf17e17a..f8f14c0ca2 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -127,7 +127,8 @@ test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
 	git init notshallow &&
 	(
 	cd notshallow &&
-	git fetch ../shallow/.git refs/heads/*:refs/remotes/shallow/*&&
+	GIT_TEST_PROTOCOL_VERSION=0 \
+		git fetch ../shallow/.git refs/heads/*:refs/remotes/shallow/* &&
 	git for-each-ref --format="%(refname)" >actual.refs &&
 	cat <<EOF >expect.refs &&
 refs/remotes/shallow/no-shallow
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 30857b84a8..c5b39b8248 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -127,6 +127,7 @@ test_expect_success 'use ref advertisement to filter out commits' '
 	# not need to send any ancestors of "c3", but we still need to send "c3"
 	# itself.
 	test_config -C client fetch.negotiationalgorithm skipping &&
+	sane_unset GIT_TEST_PROTOCOL_VERSION &&
 	trace_fetch client origin to_fetch &&
 	have_sent c5 c4^ c2side &&
 	have_not_sent c4 c4^^ c4^^^
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 336f02a41a..feedf84ce1 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -144,7 +144,8 @@ test_expect_success 'manual prefetch of missing objects' '
 	sort >observed.oids &&
 
 	test_line_count = 6 observed.oids &&
-	git -C pc1 fetch-pack --stdin "file://$(pwd)/srv.bare" <observed.oids &&
+	GIT_TEST_PROTOCOL_VERSION=0 \
+		git -C pc1 fetch-pack --stdin "file://$(pwd)/srv.bare" <observed.oids &&
 
 	git -C pc1 rev-list --quiet --objects --missing=print \
 		master..origin/master >revs &&
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index ba86a44eb1..244ff6879d 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -5,6 +5,7 @@ test_description='test git wire-protocol transition'
 TEST_NO_CREATE_REPO=1
 
 . ./test-lib.sh
+sane_unset GIT_TEST_PROTOCOL_VERSION
 
 # Test protocol v1 with 'git://' transport
 #
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index e87164aa8f..dd41a96c20 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -943,7 +943,8 @@ test_expect_success 'submodule update clone shallow submodule outside of depth'
 		cd super3 &&
 		sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
 		mv -f .gitmodules.tmp .gitmodules &&
-		test_must_fail git submodule update --init --depth=1 2>actual &&
+		test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
+			git submodule update --init --depth=1 2>actual &&
 		test_i18ngrep "Direct fetching of that commit failed." actual &&
 		git -C ../submodule config uploadpack.allowReachableSHA1InWant true &&
 		git submodule update --init --depth=1 >actual &&
-- 
2.20.0.405.gbc1bbc6f85

