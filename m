Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A4341F954
	for <e@80x24.org>; Thu, 23 Aug 2018 15:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeHWSzX (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 14:55:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56082 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeHWSzX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 14:55:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so5617396wmc.5
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+y0uhG9YWLfZqK4cR5fRzn0T0/3rad/XxMJlAITyL8=;
        b=JFD5xLey8ogy6xoZt8ABz+VlIP5KJl5LblMdKqcXxKC1IiG33B2mIkiXLHLpgg3wzd
         +66LuD/rTIgyptzmLJafyDWImnzEYj7qQXLYNM1Df+4mgIsOI0xFZJxaXrDBDvLofjyw
         JmsGZybydrpGY3pjrSuQOxR70oBcQ+LHR1Ze5SkEFk+2dH0GKYG2/TVublLivUY6tg27
         xezdonezfAbkwkfDt5+ozfiCffOg0HIb2rLD6+dY0lysrZFcGZwYdGdTH3La5iENL9Td
         JlUVAtqXGOfe888AjUFfDUV2HXlLABceQVTI+EwiFzpulzuMOHk1W8hZryF1aHKtHpQW
         DSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+y0uhG9YWLfZqK4cR5fRzn0T0/3rad/XxMJlAITyL8=;
        b=f/xH3dQ7X+9ni39RqCnUCG2NtuOdt16f20OxyKCHU4ASFK6WYUjlbFNyGA3fwk003X
         bLcd+JeqJGaObG0dDZ5pIFL/qqlm7mzuIk9Q41fbuDEWGMUaWjQo89jLnqV6Btb6C+2J
         0fZrQapZcug+zH7hMs4T8tG/lZMQyVCboOX0QRoXEMRw90enJyM15GOGH30+T7UZyMrv
         l2dYlfd+z9SNYIEFPKuOR0UDePcriaW+d2lmO60RStmajO981jMO8ZLs9/jOuEJwXMXB
         0WLtzowXLpYJgx6fERUSPAdajohOnGQcZH/b3NWiEqrQvBn5+6dIY+0oel341Kwi9Oan
         h/Aw==
X-Gm-Message-State: APzg51ArzK/nor9Osuoh86OkdSvloiIkDDVIV8HtfUTqqReGQsqJ9vbF
        8tEzv3iOpMSXomnmBTEIu1QLJV0DtO0=
X-Google-Smtp-Source: ANB0VdYGBUn3pYKrdCMF7HpLoEgJI9xzlujmAjiKWqaOFGU+3EiX3LACy1TBgfK6lQIoidBP6xyDOA==
X-Received: by 2002:a1c:3f08:: with SMTP id m8-v6mr5878729wma.88.1535037912883;
        Thu, 23 Aug 2018 08:25:12 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id u40-v6sm6391208wrc.43.2018.08.23.08.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 08:25:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] tests: fix and add lint for non-portable seq
Date:   Thu, 23 Aug 2018 15:25:02 +0000
Message-Id: <20180823152502.3886-2-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <20180823091427.1756-1-avarab@gmail.com>
References: <20180823091427.1756-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GNU seq is not a POSIX command, and doesn't exist on
e.g. OpenBSD. We've had the test_seq wrapper since d17cf5f3a3 ("tests:
Introduce test_seq", 2012-08-04), but use of it keeps coming back,
e.g. in the recently added "fetch negotiator" tests being added here.

So let's also add a check to "make test-lint". The regex is aiming to
capture the likes of $(seq ..) and "seq" as a stand-alone command,
without capturing some existing cases where we e.g. have files called
"seq".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Now with a fix & check in v2 for the seq issue mentioned in
https://public-inbox.org/git/87a7pdfltp.fsf@evledraar.gmail.com/

 t/check-non-portable-shell.pl        |  1 +
 t/t5552-skipping-fetch-negotiator.sh | 12 ++++++------
 t/t5703-upload-pack-ref-in-want.sh   |  4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index c8f10d40a1..75f38298d7 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -42,6 +42,7 @@ sub err {
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (use =)';
 	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
 	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
+	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 5ad5bece55..30857b84a8 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -46,7 +46,7 @@ test_expect_success 'commits with no parents are sent regardless of skip distanc
 	test_commit -C server to_fetch &&
 
 	git init client &&
-	for i in $(seq 7)
+	for i in $(test_seq 7)
 	do
 		test_commit -C client c$i
 	done &&
@@ -89,7 +89,7 @@ test_expect_success 'when two skips collide, favor the larger one' '
 	test_commit -C server to_fetch &&
 
 	git init client &&
-	for i in $(seq 11)
+	for i in $(test_seq 11)
 	do
 		test_commit -C client c$i
 	done &&
@@ -168,14 +168,14 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 	test_commit -C server to_fetch &&
 
 	git init client &&
-	for i in $(seq 8)
+	for i in $(test_seq 8)
 	do
 		git -C client checkout --orphan b$i &&
 		test_commit -C client b$i.c0
 	done &&
-	for j in $(seq 19)
+	for j in $(test_seq 19)
 	do
-		for i in $(seq 8)
+		for i in $(test_seq 8)
 		do
 			git -C client checkout b$i &&
 			test_commit -C client b$i.c$j
@@ -205,7 +205,7 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 
 	# fetch-pack should thus not send any more commits in the b1 branch, but
 	# should still send the others (in this test, just check b2).
-	for i in $(seq 0 8)
+	for i in $(test_seq 0 8)
 	do
 		have_not_sent b1.c$i
 	done &&
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index a73c55a47e..d1ccc22331 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -176,7 +176,7 @@ test_expect_success 'setup repos for change-while-negotiating test' '
 		git clone "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" "$LOCAL_PRISTINE" &&
 		cd "$LOCAL_PRISTINE" &&
 		git checkout -b side &&
-		for i in $(seq 1 33); do test_commit s$i; done &&
+		for i in $(test_seq 1 33); do test_commit s$i; done &&
 
 		# Add novel commits to upstream
 		git checkout master &&
@@ -289,7 +289,7 @@ test_expect_success 'setup repos for fetching with ref-in-want tests' '
 		git clone "file://$REPO" "$LOCAL_PRISTINE" &&
 		cd "$LOCAL_PRISTINE" &&
 		git checkout -b side &&
-		for i in $(seq 1 33); do test_commit s$i; done &&
+		for i in $(test_seq 1 33); do test_commit s$i; done &&
 
 		# Add novel commits to upstream
 		git checkout master &&
-- 
2.18.0.865.gffc8e1a3cd6

