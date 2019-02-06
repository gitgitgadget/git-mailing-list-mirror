Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060F61F453
	for <e@80x24.org>; Wed,  6 Feb 2019 00:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfBFAVo (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 19:21:44 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41442 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbfBFAVm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 19:21:42 -0500
Received: by mail-pl1-f202.google.com with SMTP id y2so3613656plr.8
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 16:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PYGLdWqh1LU7TNKWqYuvoASbCBilXhprZo+al8e4zj0=;
        b=hdLkwtZBNVsBJPrGvWe0vHBfBE1DRES18XadNW3bNxoIK4Tzfr2zpGvf0AMJSZHKTu
         Zsv2UiB6m7mlJa9i8dwPmKV9QzpdJhWder4OK/yaS0/aVtfU6eT+SOO0aUW5nUF83Q09
         h6qEVVcB4BlNYDg0ssV+Lx3fojyTNpbhdkOjhBbBrAqY27SyCq1LxauUGkZCzbwy2+V7
         DnjKpL/uX04DKvtWAQ9VU4DR4BHKX22m+VUzCR0DbmWdwEjEjHIum4atUYwus3ljpjrd
         o56uRAul6al2KfsyC2ljjKYhBfzc8AYruefzhZCXc0lYmomAMtGI26g6q3/dbxLt4ow5
         s/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PYGLdWqh1LU7TNKWqYuvoASbCBilXhprZo+al8e4zj0=;
        b=FGiC0fhDc1/H1ec1/vyzfOKDO8ar2zSObqYUqq/uzAD31Cq/cY5mgWxAqY8w5Iya24
         SG53TI1pmJIl8B4smzZqwMG1RbNKiFzxSWKb4Tl+9CUIWYAzMTJ/KvOwBC3fqj/7QUCS
         sb8MCpvXi0jGaGY3wI8PX3ld3G+yu2NbwAxObsKotf3u01J+3HHFbfVMH15cdLIyigOU
         X1ZvWjURpZ1ByUbdhHFT/F5NgW8k4eYxoHnnCrOXPWZ0AH7OjCJoOWYd84yMYVN5Ko1l
         R3Nl+yr9WkJnVa0Bqb8sKt2Kw07amUSHRvrkDrFZbHJgWHRq7euaMf3SPLhCT7Nw3M8Q
         LUrA==
X-Gm-Message-State: AHQUAubwG8CwjjzmUHgBRdu/hBJzsiGxoTs7WyqkOAde7Hd3mMw25TKX
        bsRtCBtE1zWNbZ8tUBKEScYWEU2z2kw+xMssaN/d4HX7MoOBtz46uBa9oH2OyAFCPWLivz+EcQk
        YU+sOfx0ezk6OBFIdNKw0FDuYuPePNLstp8ajVGnbKjV1aP7sLXCksuUsCE4XkXsHjrFVQcM6sr
        4V
X-Google-Smtp-Source: AHgI3IZctfacIx9R85qLEzZYv3WjUwSt6AtkhK+P5gthFMlcxSHjqJk2qSmelMExvdH95W66t4GshMUs1rWHLuQrqqdw
X-Received: by 2002:a63:780d:: with SMTP id t13mr2808470pgc.39.1549412501417;
 Tue, 05 Feb 2019 16:21:41 -0800 (PST)
Date:   Tue,  5 Feb 2019 16:21:20 -0800
In-Reply-To: <cover.1549411880.git.jonathantanmy@google.com>
Message-Id: <8569ae986ee99ec92c2d844b6092664a8b47ad06.1549411880.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1549411880.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 6/8] tests: fix protocol version for overspecifications
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests are also marked with a NEEDSWORK comment.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5515-fetch-merge-logic.sh  |  4 ++++
 t/t5539-fetch-http-shallow.sh |  5 ++++-
 t/t5541-http-push-smart.sh    | 14 ++++++++++++--
 t/t5551-http-fetch-smart.sh   | 34 ++++++++++++++++++++++++++--------
 4 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 36b0dbc01c..e55d8474ef 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -6,6 +6,10 @@
 
 test_description='Merge logic in fetch'
 
+# NEEDSWORK: If the overspecification of the expected result is reduced, we
+# might be able to run this test in all protocol versions.
+GIT_TEST_PROTOCOL_VERSION=
+
 . ./test-lib.sh
 
 LF='
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 5fbf67c446..cdb687b93a 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -67,7 +67,10 @@ test_expect_success 'no shallow lines after receiving ACK ready' '
 		cd clone &&
 		git checkout --orphan newnew &&
 		test_commit new-too &&
-		GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" git fetch --depth=2 &&
+		# NEEDSWORK: If the overspecification of the expected result is reduced, we
+		# might be able to run this test in all protocol versions.
+		GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" GIT_TEST_PROTOCOL_VERSION= \
+			git fetch --depth=2 &&
 		grep "fetch-pack< ACK .* ready" ../trace &&
 		! grep "fetch-pack> done" ../trace
 	)
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 5475afc052..0e3055ab98 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -47,7 +47,12 @@ test_expect_success 'no empty path components' '
 	cd "$ROOT_PATH" &&
 	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
 
-	check_access_log exp
+	# NEEDSWORK: If the overspecification of the expected result is reduced, we
+	# might be able to run this test in all protocol versions.
+	if test -z "$GIT_TEST_PROTOCOL_VERSION"
+	then
+		check_access_log exp
+	fi
 '
 
 test_expect_success 'clone remote repository' '
@@ -128,7 +133,12 @@ GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
 EOF
 test_expect_success 'used receive-pack service' '
-	check_access_log exp
+	# NEEDSWORK: If the overspecification of the expected result is reduced, we
+	# might be able to run this test in all protocol versions.
+	if test -z "$GIT_TEST_PROTOCOL_VERSION"
+	then
+		check_access_log exp
+	fi
 '
 
 test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index d2661eb338..e8ed185b33 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -82,12 +82,18 @@ test_expect_success 'clone http repository' '
 		/^< Content-Length: /d
 		/^< Transfer-Encoding: /d
 	" >actual &&
-	sed -e "s/^> Accept-Encoding: .*/> Accept-Encoding: ENCODINGS/" \
-			actual >actual.smudged &&
-	test_cmp exp actual.smudged &&
 
-	grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
-	test_line_count = 2 actual.gzip
+	# NEEDSWORK: If the overspecification of the expected result is reduced, we
+	# might be able to run this test in all protocol versions.
+	if test -z "$GIT_TEST_PROTOCOL_VERSION"
+	then
+		sed -e "s/^> Accept-Encoding: .*/> Accept-Encoding: ENCODINGS/" \
+				actual >actual.smudged &&
+		test_cmp exp actual.smudged &&
+
+		grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
+		test_line_count = 2 actual.gzip
+	fi
 '
 
 test_expect_success 'fetch changes via http' '
@@ -105,7 +111,13 @@ test_expect_success 'used upload-pack service' '
 	GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 	POST /smart/repo.git/git-upload-pack HTTP/1.1 200
 	EOF
-	check_access_log exp
+
+	# NEEDSWORK: If the overspecification of the expected result is reduced, we
+	# might be able to run this test in all protocol versions.
+	if test -z "$GIT_TEST_PROTOCOL_VERSION"
+	then
+		check_access_log exp
+	fi
 '
 
 test_expect_success 'follow redirects (301)' '
@@ -217,8 +229,14 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	git config http.cookiefile cookies.txt &&
 	git config http.savecookies true &&
 	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
-	tail -3 cookies.txt | sort >cookies_tail.txt &&
-	test_cmp expect_cookies.txt cookies_tail.txt
+
+	# NEEDSWORK: If the overspecification of the expected result is reduced, we
+	# might be able to run this test in all protocol versions.
+	if test -z "$GIT_TEST_PROTOCOL_VERSION"
+	then
+		tail -3 cookies.txt | sort >cookies_tail.txt &&
+		test_cmp expect_cookies.txt cookies_tail.txt
+	fi
 '
 
 test_expect_success 'transfer.hiderefs works over smart-http' '
-- 
2.19.0.271.gfe8321ec05.dirty

