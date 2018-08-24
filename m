Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55A91F404
	for <e@80x24.org>; Fri, 24 Aug 2018 15:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeHXSzj (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 14:55:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44475 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeHXSzi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 14:55:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so7781958wro.11
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5X5fdXgfXjvyPJPazIdjujL6MdancbFiMVm8m467qk=;
        b=feibsHUERYqVrQnc6nZA2fx1bsyXDWCtN70r642cej33VcNvnQY5SWNInBfonDNo+a
         oHTALugU/TiV3hPm21DI19kAaooe3CGv+xYNJ+tw0zb6hCNcfsuV/H4GommMi1iDG+92
         LItiEQbxBIJyzj98CWoc1tz1ADINsbD6ymfTDtVKvzRzpA0WwwXOPeB9IAgO9mY7qgyN
         aFQvXpLl5v+BMJ1UVvI7XlDuWx83pZFyNsz17SXK37O8U9aoOOH+8oi8x8As4E8qSM8v
         zXC8ic4lTCFpAqcbAAVOqX9Wf9HBM0tQyjC3ZbhZchtVtiqrwuEgB66Ohv6QlZQPbNT1
         /b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5X5fdXgfXjvyPJPazIdjujL6MdancbFiMVm8m467qk=;
        b=qvdjSG/z5sL5Y351D1bcCziTVXTB0S6iMrOaBoli7MVypkmESxyyPZUkE0gnFpn71E
         LkiSRDxsffbU66jvQ3nzmkA2eb1whz//1upItsAp+vm/VxdbPisK185Pp55U3G4IPjJr
         v+NSDvbpNByZYDvhhY90HYxuKYyYk+58eMVUZAZsN+VaviWojEq7dbO5hFyU7zxOlAyp
         bPpNKtvDZLmw1cI+CdAVYZPS7L+TYddt8OAEaER9KJnw12D8FdTV/qD5Qa2GTOiWeCSQ
         w/jkD5x0G316N3JV3BMq5XblmFNhETsivNcXeobjLvWV3K391zvYUwcUTnnUNEIBVXam
         sN/g==
X-Gm-Message-State: APzg51DxSNyUHbxFagWo4tOPykbls2JIwHdEwY19OPIQruOjDuM3+Ht9
        Efg31wjYAu3bg328n5Kvuy/OIhZWio4=
X-Google-Smtp-Source: ANB0VdaFj1nFu/5c8wYeaRaiN5zJbEVIxq9DNIZvYSKNsbOjQNtrRBoF777axYstlaMP7Qj/OmRFCw==
X-Received: by 2002:adf:e711:: with SMTP id c17-v6mr1469528wrm.143.1535124030788;
        Fri, 24 Aug 2018 08:20:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id z16-v6sm6689485wrq.78.2018.08.24.08.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 08:20:30 -0700 (PDT)
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
Subject: [PATCH v4 2/6] tests: fix and add lint for non-portable seq
Date:   Fri, 24 Aug 2018 15:20:12 +0000
Message-Id: <20180824152016.20286-3-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
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

