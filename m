Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0621F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeHXAHt (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:07:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38163 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeHXAHt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:07:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so5680967wrc.5
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5X5fdXgfXjvyPJPazIdjujL6MdancbFiMVm8m467qk=;
        b=ri4Es1Nrwcb9mRo8/fKKMJtUTInJ+3iVf/DnZWb5+pDUae+wU1CoHzj8RcFmwGGXfO
         sGXknywq9gs+MTCDwc9Ux54H248Pzzaw44w7JDRO/ZvKgNacRveR971KS6UO2roAzcSj
         bgiV4d9PkgchYhuasZfun3vTSvEIwLIGqJdIyjt97YptqUglnqBqUJeyc6SX4waixpyy
         CQIdi1hvck5P5U3y4SA58/z0V5aGN/K/gPNu6FXc3EcUsKzAQIKTaj/fEYUcFEEeMEVg
         LI3kqMJC3hO1V3n3JqN8N6u7FzJfbHReNZX5qd86k+/oB1sT9DafmjKMfv/eEb2MFBUz
         hUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5X5fdXgfXjvyPJPazIdjujL6MdancbFiMVm8m467qk=;
        b=aBV24ULpPRUm6HDpqjUP+MoI+OzG81LjSAC1zmuVBiW5JehqPS5zyihiq75RnmPve6
         OBZzWE0Dw0Wk+ggefvTX+LZ5AKYnO7HSwS39YhgqnEoyW383BvjT+Pqjw3GrLVJ2Bn11
         SliEve+0LbYbTdXo5GluOgS8NxTFP+nOLWKBcP273EkQNAoC7mCL0c+Y/qPgs2loGuat
         ZCXC/T/IP9Ec2SlTl0g056oRGE6uoDnW3LFGm8WspHunCXcCDI0PCtFBnEOh4rFhT+4t
         zuEs7PbksJAySdv0Svi3FfFLESqwBwJ6ZvFB5uyPzV4KRXz3pb103ow9VLw8TMwwGtib
         t/vA==
X-Gm-Message-State: APzg51CEK0/8XErlpIx0Ybg8iBSrpJoeUbWbkZ9B7u7IOKLTt3FlHwmb
        dP0WWGRARHHZzXDVeDRPDWqaNJ8M95U=
X-Google-Smtp-Source: ANB0VdZDds7fdPyZJAWs98yJ8gITj/pQm7nJckQnSY9pyuDWYsiMKkIQWiqxG/zjVEz2S2ArNTZBZQ==
X-Received: by 2002:adf:facf:: with SMTP id a15-v6mr10123439wrs.74.1535056586273;
        Thu, 23 Aug 2018 13:36:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q16-v6sm3641898wrn.41.2018.08.23.13.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:36:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/5] tests: fix and add lint for non-portable seq
Date:   Thu, 23 Aug 2018 20:36:01 +0000
Message-Id: <20180823203604.5564-3-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <20180823152502.3886-2-avarab@gmail.com>
References: <20180823152502.3886-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The seq command is not in POSIX, and doesn't exist on
e.g. OpenBSD. We've had the test_seq wrapper since d17cf5f3a3 ("tests:
Introduce test_seq", 2012-08-04), but use of it keeps coming back,
e.g. in the recently added "fetch negotiator" tests being added here.

So let's also add a check to "make test-lint". The regex is aiming to
capture the likes of $(seq ..) and "seq" as a stand-alone command,
without capturing some existing cases where we e.g. have files called
"seq", as \bseq\b would do.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
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

