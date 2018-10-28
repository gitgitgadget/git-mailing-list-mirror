Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28CCF1F453
	for <e@80x24.org>; Sun, 28 Oct 2018 22:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeJ2Hgi (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 03:36:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39698 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJ2Hgi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 03:36:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id r10-v6so6677708wrv.6
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 15:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuJaPqlaSiBOvqsxEy+t1tSZ742NJrBj1E0VmPYMCCU=;
        b=mjDjO9cOjSOLnw3akHNXx2CIMfeZ5NNokE/QVh6lFQ0CkH/nk+a+0BLNXw5ruHeaQn
         v8hV+S8B5v0JZMTkrNDC49oLmL7ONUtNmV6ajzYs5g+UQiAB09ObirUbOsgRQhT4lIfN
         i/5Xo7YH/KgdR1Ys6X7fT9cFhBqb8rYLwETsUQywoVI3kR0ZStJOHIorpao+j99SuUOu
         gBZS+E55T+xO69ytPsiqF1TMN+xMmZgg+YwzJ2W0qjpD/aokFqn6C5TaSSxLmvVJ8nHx
         O0iYrJ80To4CBYeX2dc4knuBc3pgK1i3wt/ZKG4c3QNm7VsqUXe4GVBn3908IvJTwt7q
         RBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuJaPqlaSiBOvqsxEy+t1tSZ742NJrBj1E0VmPYMCCU=;
        b=F3zY/BIl45MZkAKfTSPMEFxKA6qBwpLBj5CE146LzLsMNkQunfTs0Uj0uICJBUWzZp
         qdzZojDcOX5N3qdQKfWrN7jW3xo1eua7H6lT8MIklJKKwMGYebnDpPGSgL4jNGhQz1Ux
         v4lSVgzYTNjaWKuZDXzGUnc/A+50oufv0hUqqT4d0l0hCLM2AsNXEJ8sla8q3DP8iAw4
         lOVc+ROiZZ0bpRAhng5jbLpvQ4gTRydMpUqAS/WsliQYde2R/d79IV09Z64ZRKpTYimc
         FVKdDIaWvsccn4DlfKE5/XHYTjavnDgyl1WUCvxoCUm7YimNkoVxV4D6EzcNcse4lARo
         LpHw==
X-Gm-Message-State: AGRZ1gL225EHCjcRNYtk4NIpIxC2sIAcZh1FN20EcGVZpn0aYZ6LqdA9
        YQaOIbsZNu99CrIOKJs7o20B7C4P6PI=
X-Google-Smtp-Source: AJdET5fyfvmiFruXbFbf2Byf2MdTYuz1XJBEEO+e1Gv/DTFgs5xbMt0Nasvus9Y7YBFBMs9Hzf08GQ==
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr12620690wrx.271.1540767033148;
        Sun, 28 Oct 2018 15:50:33 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p3-v6sm2709681wre.47.2018.10.28.15.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 15:50:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Geert Jansen <gerardu@amazon.com>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Baudis <pasky@ucw.cz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] pack-objects tests: don't leave test .git corrupt at end
Date:   Sun, 28 Oct 2018 22:50:21 +0000
Message-Id: <20181028225023.26427-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <87lg6jljmf.fsf@evledraar.gmail.com>
References: <87lg6jljmf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the pack-objects tests to not leave their .git directory
corrupt and the end.

In 2fca19fbb5 ("fix multiple issues with t5300", 2010-02-03) a comment
was added warning against adding any subsequent tests, but since
4614043c8f ("index-pack: use streaming interface for collision test on
large blobs", 2012-05-24) the comment has drifted away from the code,
mentioning two test, when we actually have three.

Instead of having this warning let's just create a new .git directory
specifically for these tests.

As an aside, it would be interesting to instrument the test suite to
run a "git fsck" at the very end (in "test_done"). That would have
errored before this change, and may find other issues #leftoverbits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5300-pack-object.sh | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index a0309e4bab..410a09b0dd 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -468,29 +468,32 @@ test_expect_success 'pack-objects in too-many-packs mode' '
 	git fsck
 '
 
-#
-# WARNING!
-#
-# The following test is destructive.  Please keep the next
-# two tests at the end of this file.
-#
-
-test_expect_success 'fake a SHA1 hash collision' '
-	long_a=$(git hash-object a | sed -e "s!^..!&/!") &&
-	long_b=$(git hash-object b | sed -e "s!^..!&/!") &&
-	test -f	.git/objects/$long_b &&
-	cp -f	.git/objects/$long_a \
-		.git/objects/$long_b
+test_expect_success 'setup: fake a SHA1 hash collision' '
+	git init corrupt &&
+	(
+		cd corrupt &&
+		long_a=$(git hash-object -w ../a | sed -e "s!^..!&/!") &&
+		long_b=$(git hash-object -w ../b | sed -e "s!^..!&/!") &&
+		test -f	.git/objects/$long_b &&
+		cp -f	.git/objects/$long_a \
+			.git/objects/$long_b
+	)
 '
 
 test_expect_success 'make sure index-pack detects the SHA1 collision' '
-	test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
-	test_i18ngrep "SHA1 COLLISION FOUND" msg
+	(
+		cd corrupt &&
+		test_must_fail git index-pack -o ../bad.idx ../test-3.pack 2>msg &&
+		test_i18ngrep "SHA1 COLLISION FOUND" msg
+	)
 '
 
 test_expect_success 'make sure index-pack detects the SHA1 collision (large blobs)' '
-	test_must_fail git -c core.bigfilethreshold=1 index-pack -o bad.idx test-3.pack 2>msg &&
-	test_i18ngrep "SHA1 COLLISION FOUND" msg
+	(
+		cd corrupt &&
+		test_must_fail git -c core.bigfilethreshold=1 index-pack -o ../bad.idx ../test-3.pack 2>msg &&
+		test_i18ngrep "SHA1 COLLISION FOUND" msg
+	)
 '
 
 test_done
-- 
2.19.1.759.g500967bb5e

