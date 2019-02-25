Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3AC20248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfBYVyi (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:54:38 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:49431 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbfBYVyg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:54:36 -0500
Received: by mail-qt1-f201.google.com with SMTP id q11so10461768qtj.16
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eUnQqs898tMQR0DBFUV33IK8BdRkgyzOL1avYQsVMiE=;
        b=ZSY6SzgHu+XF672ZmwPsZjC+O01ZxBb5s0B01oMtzeSnY3bWwxQkfFP2PTc1EaTi5f
         FLsFk2Z/d7Z5akg+BP5ZBbb2BGS+YtDgFxhnrligwIUjnVLv8YGymnXCWGV41E1Tunoy
         j1MVa1sZoE4Awn2EAVdoLMxufoDNmnrS1FPqCNsp/qKPiE/jOF74gmmVYbnvqIVndsMX
         Wn/N5XPJhQq7Scw2vmJ7u209Q1BK/YHTjR6NweVTV6WML/17sVCWQ9AJxldZZJ0vKqES
         SJhMf6QxNZVUACD5Ae/uYTRH/D0/AyHqHUjkRvXbRbpFCsY8lHjH9TMzuAcB1aoilGR4
         eNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eUnQqs898tMQR0DBFUV33IK8BdRkgyzOL1avYQsVMiE=;
        b=ng6qM0glJv28eMeW3/Emt21kXIwUAgBzjnjGFdQO6wf3xcDklA/mkXP1vCDZQpX5in
         zmDWZNys3q7VlYznvQGdQo/bd8LCUTpmFZT4pp9tTZDrdQUkGK+6D54uu5ZzPREE95Jb
         g3cd25KAZnA1eAPJqc8cTrRkL5ORcBHBAlimmtDW5sR8j81oEuwoUw83lLyd4IJ3kpzb
         FszrwPbLZU7rdTfBIH/UJNSRPeYZPdm0E0ue+B2W5AUft6lZ2srXYobDF8YfRU3kiHpJ
         nXVOf1SPWbt0LGb+5/Ro6aPQ3Ctn45xQgeHz5XMKxtw5YSeP2xOoEfmUcNs6PiDa4hp+
         4ArQ==
X-Gm-Message-State: AHQUAuZJCGURszzS0mFhMnCiR3nH6zUAI+yBvz9CGxrc5onXDMeaVIPg
        UZiNZ/811M5OxuLmiECELxKGKCdMfkt1CBzhld+iqnXoodJnWEq+i0YEoSnektYuvH1uZhEXg7E
        ML/l9nrr3NhCx6FCgOA7JIRTQt4wEKDMY01Q2cd0RudSBfClFv8cL+AbXGyhnPuur2YxebpT+GT
        oB
X-Google-Smtp-Source: AHgI3IYH4jigTl0U0+dpuoPvKZEtv6v2wH/rjZmaRcHVCyE9zRBGDPlObM3lL3Oq+DqT4L5cL3niNTV7/h0TC/Ejw6Y2
X-Received: by 2002:a37:444:: with SMTP id 65mr12181954qke.51.1551131675565;
 Mon, 25 Feb 2019 13:54:35 -0800 (PST)
Date:   Mon, 25 Feb 2019 13:54:12 -0800
In-Reply-To: <cover.1551131153.git.jonathantanmy@google.com>
Message-Id: <d4638e94183fb5d6b5e84c60196c1f3866128295.1551131153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1551131153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 7/8] tests: fix protocol version for overspecifications
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests are also marked with a NEEDSWORK comment.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index f02ae3b797..a685d3edb6 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -81,12 +81,18 @@ test_expect_success 'clone http repository' '
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
@@ -104,7 +110,13 @@ test_expect_success 'used upload-pack service' '
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
@@ -216,8 +228,14 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
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

