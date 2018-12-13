Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_MIXED_ES shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720BE20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 15:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeLMP6q (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 10:58:46 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:51936 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbeLMP6o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 10:58:44 -0500
Received: by mail-wm1-f49.google.com with SMTP id s14so2891521wmh.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 07:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gQ2mv/zEkDBYk974b7TxPaXjUo+AkxMZ6OkiN36Iu8=;
        b=pjrfLPrJLk87SRrGesR8CLkHkFY2IlWaFucBU38CihK/CBx2F1My42uhxtxv6ROGud
         1bpMHIX7p14ph0APE3h5d3cFs2QjNU3+ZjYa8ZyoZc5ixjNp9Ne4C18O3t8DPZBVfRHO
         6mIFZMsix6kdghzPA/obYysxXcP5gMA6idA40I9FqCQOXHPvkB33zR8HTdzudNMPzXGw
         IjRUDKwfEFEbybPIgaFkKJ+Gx01+GK+JJx+XKHJuActGK1dn8w8X4y5UvYzSqgZ8/G7s
         t2/Vgn/qj9YF2i35uGHHym81ZXYchQAiLcEylyKJHfj1vSbO5I84vrRPAM7byL722X/V
         dg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gQ2mv/zEkDBYk974b7TxPaXjUo+AkxMZ6OkiN36Iu8=;
        b=aXEd6Z6rOmpzdgWUdoP0+eL4F0M4vTduu2y9+LevOdI0OAczyh9Ujdr1ZeRRVeS6Fr
         zEbo64J4IVd3tl93FkpIsLjA5RX9Rd8Wsj938/DWD92ZQNkfcBRp09V1OxFvyUHYrhya
         8jRwPGpCWsMYxuwJgB0KXlgFUbUBmW7YdjKnMQDBcif6juk4M4cZU2E10RI1wJVtQKJM
         b+hhE+LcCta4/6nPe3gu1oDdP3P963SxIA8BOIlWyLVwamLjklIs3JXctW5o9GQpuI9I
         uZH7yjn0gZS+vCa/IuktVOeQe5t2okzrZ7hh60PUnXOaJaLraoDccb406F3cyf/CAbgs
         BuUA==
X-Gm-Message-State: AA+aEWbehOEK40ovKro+hU3Hx6+yBQwRifnCs/qUHNbUmUew6PQEaK6w
        SxkkDQDOAkdvBLp/n39eKfy4CxKdqo4=
X-Google-Smtp-Source: AFSGD/XK2zdF367iB7GJChzv7AnsVFynZiACgekyyAuP4mC+Hn7tn0yv2vTOYI3DaSozF9XViCFQjg==
X-Received: by 2002:a1c:d1cd:: with SMTP id i196mr9027779wmg.107.1544716720952;
        Thu, 13 Dec 2018 07:58:40 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r69sm4047821wmd.4.2018.12.13.07.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:58:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/8] tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2
Date:   Thu, 13 Dec 2018 16:58:17 +0100
Message-Id: <20181213155817.27666-9-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark those tests that have behavior differences or bugs under
protocol.version=2.

Whether or not these tests should exhibit different behavior is
outside the scope of this change. Some (such as t5500-fetch-pack.sh)
are intentionally different, but others (such as
t7406-submodule-update.sh and t5515-fetch-merge-logic.sh) might
indicate bugs in the protocol v2 code.

Tracking down which is which is outside the scope of this
change. Let's first exhaustively annotate where the differences are,
so that we can spot future behavior differences or regressions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5500-fetch-pack.sh                |  9 ++++++---
 t/t5503-tagfollow.sh                 |  8 ++++----
 t/t5512-ls-remote.sh                 |  8 ++++----
 t/t5515-fetch-merge-logic.sh         |  2 +-
 t/t5516-fetch-push.sh                | 17 +++++++++++------
 t/t5537-fetch-shallow.sh             |  3 ++-
 t/t5539-fetch-http-shallow.sh        |  9 +++++----
 t/t5541-http-push-smart.sh           |  9 +++++++--
 t/t5551-http-fetch-smart.sh          | 19 +++++++++++--------
 t/t5552-skipping-fetch-negotiator.sh |  4 ++--
 t/t5570-git-daemon.sh                |  2 +-
 t/t7406-submodule-update.sh          |  3 ++-
 12 files changed, 56 insertions(+), 37 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 086f2c40f6..8b1217ea26 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -628,7 +628,10 @@ test_expect_success 'fetch-pack cannot fetch a raw sha1 that is not advertised a
 	test_commit -C server 6 &&
 
 	git init client &&
-	test_must_fail git -C client fetch-pack ../server \
+
+	# Other protocol versions (e.g. 2) allow fetching an unadvertised
+	# object, so run this test with the default protocol version (0).
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION= git -C client fetch-pack ../server \
 		$(git -C server rev-parse refs/heads/master^) 2>err &&
 	test_i18ngrep "Server does not allow request for unadvertised object" err
 '
@@ -788,7 +791,7 @@ test_expect_success 'shallow clone exclude tag two' '
 '
 
 test_expect_success 'fetch exclude tag one' '
-	git -C shallow12 fetch --shallow-exclude one origin &&
+	GIT_TEST_PROTOCOL_VERSION= git -C shallow12 fetch --shallow-exclude one origin &&
 	git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
 	test_write_lines three two >expected &&
 	test_cmp expected actual
@@ -806,7 +809,7 @@ test_expect_success 'fetching deepen' '
 	git -C deepen log --pretty=tformat:%s master >actual &&
 	echo three >expected &&
 	test_cmp expected actual &&
-	git -C deepen fetch --deepen=1 &&
+	GIT_TEST_PROTOCOL_VERSION= git -C deepen fetch --deepen=1 &&
 	git -C deepen log --pretty=tformat:%s origin/master >actual &&
 	cat >expected <<-\EOF &&
 	four
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 4ca48f0276..0e90a90294 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -56,7 +56,7 @@ test_expect_success 'fetch A (new commit : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_TRACE_PACKET=$UPATH git fetch &&
+		GIT_TRACE_PACKET=$UPATH GIT_TEST_PROTOCOL_VERSION= git fetch &&
 		test $A = $(git rev-parse --verify origin/master)
 	) &&
 	get_needs $U >actual &&
@@ -86,7 +86,7 @@ test_expect_success 'fetch C, T (new branch, tag : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_TRACE_PACKET=$UPATH git fetch &&
+		GIT_TRACE_PACKET=$UPATH GIT_TEST_PROTOCOL_VERSION= git fetch &&
 		test $C = $(git rev-parse --verify origin/cat) &&
 		test $T = $(git rev-parse --verify tag1) &&
 		test $A = $(git rev-parse --verify tag1^0)
@@ -122,7 +122,7 @@ test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_TRACE_PACKET=$UPATH git fetch &&
+		GIT_TRACE_PACKET=$UPATH GIT_TEST_PROTOCOL_VERSION= git fetch &&
 		test $B = $(git rev-parse --verify origin/master) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
 		test $S = $(git rev-parse --verify tag2)
@@ -146,7 +146,7 @@ test_expect_success 'new clone fetch master and tags' '
 		cd clone2 &&
 		git init &&
 		git remote add origin .. &&
-		GIT_TRACE_PACKET=$UPATH git fetch &&
+		GIT_TRACE_PACKET=$UPATH GIT_TEST_PROTOCOL_VERSION= git fetch &&
 		test $B = $(git rev-parse --verify origin/master) &&
 		test $S = $(git rev-parse --verify tag2) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index ca69636fd5..7b480587c9 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -223,7 +223,7 @@ test_expect_success 'ls-remote --symref' '
 	$(git rev-parse refs/tags/mark1.10)	refs/tags/mark1.10
 	$(git rev-parse refs/tags/mark1.2)	refs/tags/mark1.2
 	EOF
-	git ls-remote --symref >actual &&
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref >actual &&
 	test_cmp expect actual
 '
 
@@ -243,7 +243,7 @@ test_expect_failure 'ls-remote with filtered symref (--heads)' '
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
 	EOF
-	git ls-remote --symref --heads . >actual &&
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref --heads . >actual &&
 	test_cmp expect actual
 '
 
@@ -252,9 +252,9 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
 	EOF
-	git ls-remote --symref --heads . >actual &&
+	GIT_TEST_PROTOCOL_VERSION=  git ls-remote --symref --heads . >actual &&
 	test_cmp expect actual &&
-	git ls-remote --symref . "refs/heads/*" >actual &&
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref . "refs/heads/*" >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 36b0dbc01c..f095555c3e 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -147,7 +147,7 @@ do
 			do
 				git update-ref -d "$refname" "$val"
 			done
-			git fetch "$@" >/dev/null
+			GIT_TEST_PROTOCOL_VERSION= git fetch "$@" >/dev/null
 			cat .git/FETCH_HEAD
 		} >"$actual_f" &&
 		git show-ref >"$actual_r" &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 08cdee0b95..1d1b717cd5 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1129,7 +1129,7 @@ do
 	'
 done
 
-test_expect_success 'fetch exact SHA1' '
+test_expect_success 'fetch exact SHA1 in protocol v0' '
 	mk_test testrepo heads/master hidden/one &&
 	git push testrepo master:refs/hidden/one &&
 	(
@@ -1148,7 +1148,8 @@ test_expect_success 'fetch exact SHA1' '
 		test_must_fail git cat-file -t $the_commit &&
 
 		# fetching the hidden object should fail by default
-		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
+		test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+			git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
 		test_i18ngrep "Server does not allow request for unadvertised object" err &&
 		test_must_fail git rev-parse --verify refs/heads/copy &&
 
@@ -1205,7 +1206,8 @@ do
 		mk_empty shallow &&
 		(
 			cd shallow &&
-			test_must_fail git fetch --depth=1 ../testrepo/.git $SHA1 &&
+			test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+				git fetch --depth=1 ../testrepo/.git $SHA1 &&
 			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
 			git fetch --depth=1 ../testrepo/.git $SHA1 &&
 			git cat-file commit $SHA1
@@ -1233,15 +1235,18 @@ do
 		mk_empty shallow &&
 		(
 			cd shallow &&
-			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_3 &&
-			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_1 &&
+			test_must_fail ok=sigpipe env GIT_TEST_PROTOCOL_VERSION= \
+				git fetch ../testrepo/.git $SHA1_3 &&
+			test_must_fail ok=sigpipe env GIT_TEST_PROTOCOL_VERSION= \
+				git fetch ../testrepo/.git $SHA1_1 &&
 			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
 			git fetch ../testrepo/.git $SHA1_1 &&
 			git cat-file commit $SHA1_1 &&
 			test_must_fail git cat-file commit $SHA1_2 &&
 			git fetch ../testrepo/.git $SHA1_2 &&
 			git cat-file commit $SHA1_2 &&
-			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_3
+			test_must_fail ok=sigpipe env GIT_TEST_PROTOCOL_VERSION= \
+				git fetch ../testrepo/.git $SHA1_3
 		)
 	'
 done
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 6faf17e17a..85b3022ce6 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -127,7 +127,8 @@ test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
 	git init notshallow &&
 	(
 	cd notshallow &&
-	git fetch ../shallow/.git refs/heads/*:refs/remotes/shallow/*&&
+	GIT_TEST_PROTOCOL_VERSION= \
+		git fetch ../shallow/.git refs/heads/*:refs/remotes/shallow/* &&
 	git for-each-ref --format="%(refname)" >actual.refs &&
 	cat <<EOF >expect.refs &&
 refs/remotes/shallow/no-shallow
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 5fbf67c446..a121e19bc7 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -67,7 +67,8 @@ test_expect_success 'no shallow lines after receiving ACK ready' '
 		cd clone &&
 		git checkout --orphan newnew &&
 		test_commit new-too &&
-		GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" git fetch --depth=2 &&
+		GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" GIT_TEST_PROTOCOL_VERSION= \
+			git fetch --depth=2 &&
 		grep "fetch-pack< ACK .* ready" ../trace &&
 		! grep "fetch-pack> done" ../trace
 	)
@@ -114,7 +115,7 @@ test_expect_success 'shallow clone exclude tag two' '
 '
 
 test_expect_success 'fetch exclude tag one' '
-	git -C shallow12 fetch --shallow-exclude one origin &&
+	GIT_TEST_PROTOCOL_VERSION= git -C shallow12 fetch --shallow-exclude one origin &&
 	git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
 	test_write_lines three two >expected &&
 	test_cmp expected actual
@@ -128,14 +129,14 @@ test_expect_success 'fetching deepen' '
 	test_commit two &&
 	test_commit three &&
 	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-deepen.git" &&
-	git clone --depth 1 $HTTPD_URL/smart/shallow-deepen.git deepen &&
+	GIT_TEST_PROTOCOL_VERSION= git clone --depth 1 $HTTPD_URL/smart/shallow-deepen.git deepen &&
 	mv "$HTTPD_DOCUMENT_ROOT_PATH/shallow-deepen.git" .git &&
 	test_commit four &&
 	git -C deepen log --pretty=tformat:%s master >actual &&
 	echo three >expected &&
 	test_cmp expected actual &&
 	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-deepen.git" &&
-	git -C deepen fetch --deepen=1 &&
+	GIT_TEST_PROTOCOL_VERSION= git -C deepen fetch --deepen=1 &&
 	git -C deepen log --pretty=tformat:%s origin/master >actual &&
 	cat >expected <<-\EOF &&
 	four
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 5475afc052..180c9005b7 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -45,14 +45,19 @@ test_expect_success 'no empty path components' '
 	# In the URL, add a trailing slash, and see if git appends yet another
 	# slash.
 	cd "$ROOT_PATH" &&
-	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
+	# Other protocol versions may make different requests, so perform this
+	# clone with the default protocol.
+	GIT_TEST_PROTOCOL_VERSION= git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
 
 	check_access_log exp
 '
 
 test_expect_success 'clone remote repository' '
 	rm -rf test_repo_clone &&
-	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone &&
+	# Other protocol versions may make different requests, so perform this
+	# clone with the default protocol.
+	GIT_TEST_PROTOCOL_VERSION= git clone $HTTPD_URL/smart/test_repo.git test_repo_clone &&
+
 	(
 		cd test_repo_clone && git config push.default matching
 	)
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 8630b0cc39..a51993f35a 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -43,7 +43,8 @@ test_expect_success 'clone http repository' '
 	< Cache-Control: no-cache, max-age=0, must-revalidate
 	< Content-Type: application/x-git-upload-pack-result
 	EOF
-	GIT_TRACE_CURL=true git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
+	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION= \
+		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
 	sed -e "
@@ -92,7 +93,7 @@ test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&
 	git push public &&
-	(cd clone && git pull) &&
+	(cd clone && GIT_TEST_PROTOCOL_VERSION= git pull) &&
 	test_cmp file clone/file
 '
 
@@ -143,7 +144,7 @@ test_expect_success 'clone from auth-only-for-push repository' '
 test_expect_success 'clone from auth-only-for-objects repository' '
 	echo two >expect &&
 	set_askpass user@host pass@host &&
-	git clone --bare "$HTTPD_URL/auth-fetch/smart/repo.git" half-auth &&
+	GIT_TEST_PROTOCOL_VERSION= git clone --bare "$HTTPD_URL/auth-fetch/smart/repo.git" half-auth &&
 	expect_askpass both user@host &&
 	git --git-dir=half-auth log -1 --format=%s >actual &&
 	test_cmp expect actual
@@ -151,7 +152,7 @@ test_expect_success 'clone from auth-only-for-objects repository' '
 
 test_expect_success 'no-op half-auth fetch does not require a password' '
 	set_askpass wrong &&
-	git --git-dir=half-auth fetch &&
+	GIT_TEST_PROTOCOL_VERSION= git --git-dir=half-auth fetch &&
 	expect_askpass none
 '
 
@@ -187,7 +188,7 @@ test_expect_success 'create namespaced refs' '
 '
 
 test_expect_success 'smart clone respects namespace' '
-	git clone "$HTTPD_URL/smart_namespace/repo.git" ns-smart &&
+	GIT_TEST_PROTOCOL_VERSION= git clone "$HTTPD_URL/smart_namespace/repo.git" ns-smart &&
 	echo namespaced >expect &&
 	git --git-dir=ns-smart/.git log -1 --format=%s >actual &&
 	test_cmp expect actual
@@ -214,7 +215,7 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	EOF
 	git config http.cookiefile cookies.txt &&
 	git config http.savecookies true &&
-	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
 	tail -3 cookies.txt | sort >cookies_tail.txt &&
 	test_cmp expect_cookies.txt cookies_tail.txt
 '
@@ -306,7 +307,8 @@ test_expect_success 'test allowreachablesha1inwant with unreachable' '
 
 	git init --bare test_reachable.git &&
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
-	test_must_fail git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+		git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
 '
 
 test_expect_success 'test allowanysha1inwant with unreachable' '
@@ -325,7 +327,8 @@ test_expect_success 'test allowanysha1inwant with unreachable' '
 
 	git init --bare test_reachable.git &&
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
-	test_must_fail git -C test_reachable.git fetch origin "$(git rev-parse HEAD)" &&
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+		git -C test_reachable.git fetch origin "$(git rev-parse HEAD)" &&
 
 	git -C "$server" config uploadpack.allowanysha1inwant 1 &&
 	git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 30857b84a8..979e6583d4 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -127,7 +127,7 @@ test_expect_success 'use ref advertisement to filter out commits' '
 	# not need to send any ancestors of "c3", but we still need to send "c3"
 	# itself.
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	trace_fetch client origin to_fetch &&
+	GIT_TEST_PROTOCOL_VERSION= trace_fetch client origin to_fetch &&
 	have_sent c5 c4^ c2side &&
 	have_not_sent c4 c4^^ c4^^^
 '
@@ -189,7 +189,7 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 	test_commit -C server commit-on-b1 &&
 
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	trace_fetch client "$(pwd)/server" to_fetch &&
+	GIT_TEST_PROTOCOL_VERSION= trace_fetch client "$(pwd)/server" to_fetch &&
 	grep "  fetch" trace &&
 
 	# fetch-pack sends 2 requests each containing 16 "have" lines before
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 7466aad111..c42ee245cd 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -190,7 +190,7 @@ test_expect_success 'daemon log records all attributes' '
 	EOF
 	>daemon.log &&
 	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
-		git -c protocol.version=1 \
+		GIT_TEST_PROTOCOL_VERSION= git -c protocol.version=1 \
 			ls-remote "$GIT_DAEMON_URL/interp.git" &&
 	grep -i extended.attribute daemon.log | cut -d" " -f2- >actual &&
 	test_cmp expect actual
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index e87164aa8f..a555e38845 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -943,7 +943,8 @@ test_expect_success 'submodule update clone shallow submodule outside of depth'
 		cd super3 &&
 		sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
 		mv -f .gitmodules.tmp .gitmodules &&
-		test_must_fail git submodule update --init --depth=1 2>actual &&
+		test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+			git submodule update --init --depth=1 2>actual &&
 		test_i18ngrep "Direct fetching of that commit failed." actual &&
 		git -C ../submodule config uploadpack.allowReachableSHA1InWant true &&
 		git submodule update --init --depth=1 >actual &&
-- 
2.20.0.405.gbc1bbc6f85

