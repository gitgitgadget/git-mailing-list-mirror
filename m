Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87AB21F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeJaDi0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:38:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52081 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaDi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:38:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id w7-v6so1792025wmc.1
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ZjycPVEw74N8NeUIVpDca3HMb4KtMHTePlUKZLocR0=;
        b=Mu5phKnaos7ij0IDisVOAeZMmQ0Lyw5hiswGvGy2+kBdsT/eWZJj6AihaTkZ3xImhy
         o7l1GzaGSXS6VDmaHgjNxJQE5pe6f/jFQlMXZPSbDPWRATK2fJsGMSW0MUDi8vLu8pJa
         uDewKBkJYXWZQCaqnpAree7LuMe/+erck4r3LJcazU89MMTSpHLqdZGVE3XvK9janoq8
         3rgmuue1ModdDOFtJYDLgfamXBejuZ2c7+M6av89sVH1yd3i25iO00oevpMLLNn+RmUl
         U9omCNPO+nF3a6idjefLHGv5y/07oP/pK+WOdHesQnuYZX8keFe0P0Jh0ApmKEgtnH4J
         tGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZjycPVEw74N8NeUIVpDca3HMb4KtMHTePlUKZLocR0=;
        b=ff9l/Wpc4+PjB50GGBfhsiQC54Bp6rWvjf5qHs9X6QPa3AA6Qx9ksUQgIUA6A9TCor
         U+RrazdGtcLJcYgmR1lAaprMQUbBlwJzmU3e4hEbAXZqeTcVaAKWzN00AJcrnd+R/GC3
         c7JSIVEW1gj9BDL/k/YbCboKvLJBXcWSUoROPUNNONPyhBbugL/YvelnhnWnC4PO5joS
         f5ZPZngutubx2Iz/2/unPosKct2jY0lYyo2Y3NcmrDby7PdHW4+r9DB/ch67WsuBc3AR
         fjUkAzkX7MC0SRLJHleCqK4mL3feMbdWc134mxBUmvytQtPwWMVENu97Sqt0jirZ4jKP
         HQog==
X-Gm-Message-State: AGRZ1gJvQo8jJuTWYDP+YNMwXaB1zdM6IMDA7hQfSbc/t57vFZWoVOtw
        0WIpNXawNrD3h2ZMIssx8DJ10cAy
X-Google-Smtp-Source: AJdET5dAHq5Z5mMRyPc8E0ZM3BbgPTgO5y7JI/Y6G8jhTk/0LjB3h0xvRGsCFrlXGtFfuA3sFV+NmQ==
X-Received: by 2002:a1c:5f42:: with SMTP id t63-v6mr20050wmb.59.1540925026266;
        Tue, 30 Oct 2018 11:43:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k66-v6sm9999825wmd.47.2018.10.30.11.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:43:45 -0700 (PDT)
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
Subject: [PATCH v2 2/3] pack-objects tests: don't leave test .git corrupt at end
Date:   Tue, 30 Oct 2018 18:43:30 +0000
Message-Id: <20181030184331.27264-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.899.g0250525e69
In-Reply-To: <20181028225023.26427-1-avarab@gmail.com>
References: <20181028225023.26427-1-avarab@gmail.com>
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
2.19.1.899.g0250525e69

