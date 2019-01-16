Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E071F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 22:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbfAPWmj (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 17:42:39 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:50951 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbfAPWmi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 17:42:38 -0500
Received: by mail-yw1-f74.google.com with SMTP id b8so3888229ywb.17
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 14:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PYGLdWqh1LU7TNKWqYuvoASbCBilXhprZo+al8e4zj0=;
        b=Rb05+SSjk+28W4fEl4jH0m2Nk6UFwRRIj3I7M78lmeXBtgmnKeE5pjjFKNKQlQUIQ+
         l1adDz3qMGdqTdsdsA5BpD7faTeTkFNB7jNVfNs25eSzL07gVEUexVILlFQpgUltLIpu
         Fejs4cDpToypGLsiehMYtwFPzoYa4BMA8AxP9gmzNRm+V9nctzS3cSajQ8VRXdaIdrRw
         ruERB+u09ZWyvUglKgZR1zRpdnxuZfB2ise0B6AIHRgunYHDGH7EYcR0VNcVKReJ3Qr5
         WwqMVkWLGDErulrFs90AeOtWDLzZNu+2AeyUcLDus1kfQ9VBrd1ZNBtwWS7YcNKwHQ6V
         p3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PYGLdWqh1LU7TNKWqYuvoASbCBilXhprZo+al8e4zj0=;
        b=Knk3HDk5KgIH1+su1/vOny/3k75MPZMXFjvvgbWUXy5Bucsdy9tMWCLE1zvRXqpc3B
         cHGx0xucuIedUcHx9Iz7wWtFuaT1ZqpI9l1/JwhecRIP5KE5usuA/IlS9frwokZsW9Ae
         eu+XIMyQhq63rbtwuvg9PHKfIIMItpilzrt0hE8Wdr9Ny49ODvG9ubk2fJH3a94O2Zl8
         rwRKPWiaS8LMTY8Dg2+ntOkrk5zqOrfvJr0xMXL0TuLdElzVNHuGZRiPHoo9Rb5ZlKMY
         fj+sGYPCZnYNuit/UM21kyi6ttEkv+fLSMcDmr5LRUyIrW+iJqQkARc2HPchMlaCU5wp
         L96g==
X-Gm-Message-State: AJcUukcFDjAMt174dC0iHrCrQcyP4OdoJGx5q0wL4tmnMas/+pbH8jOM
        8yy7WPM0C6huMD3CbCFPxKDWPXUQ2mrchWHGaF5UJ2DQZ+S/7XZ2gPUEFyBgt2oozMkxKQvGRwg
        tvUn5IVhMWVyvfSwZdPVkxTfJhWX3WtqlT6IyIjQFWIk/Qn16THDPpvz6E4ASxl/JpjtUF2lrCM
        nW
X-Google-Smtp-Source: ALg8bN5P+82PBz4uZk1mbh5pBv/4W8/6dphRZJ5xCdtk7WQqXvs5byPaxT6Q/UpaTVo6bZksC9s3H+ixkUv6fBW9BjGw
X-Received: by 2002:a81:480f:: with SMTP id v15mr1330459ywa.0.1547678557600;
 Wed, 16 Jan 2019 14:42:37 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:42:14 -0800
In-Reply-To: <cover.1547677183.git.jonathantanmy@google.com>
Message-Id: <bc2ce6e43599af66561c610a4132e05eeaa0ecbe.1547677183.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547677183.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 6/8] tests: fix protocol version for overspecifications
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
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

