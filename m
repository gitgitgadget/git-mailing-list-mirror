Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70581F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeJaDiY (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:38:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37611 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaDiY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:38:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so12299517wmc.2
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHry/YG7PJ0Glpu3k7swpFA+AN8nTdbMq+qdj/QUM0o=;
        b=XCGuLX+re3cEKV2Mlj0f1+5WqynJRfqFFqB2bV1nk1JSDOiWcyDAmGrl4Pyt81jyy+
         LNuEA0ljCl8bHcjBsfhh+W/OOj2NJAwTMURYOgLU31ASAxp8a/rE8g7pcTCz64r4EYNF
         KQpGx+tcdLpahOarzykETzYr1uFtZLrJCj3a9COowbrZaCim1jxABLrD3mUtZAQwpDTO
         +MX/6saBiDgVjUJgInQireQiZVnw2EpRY2mjFRoXY6qx59GS7EiIvJWERd99n1Mu6WQb
         G6pfNZV2w+W1/6jh8Vo5hBC9gBpkmpJa36AAEiITRxFsGuF/DM6YzFHC9u68mCpLpc1L
         7Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHry/YG7PJ0Glpu3k7swpFA+AN8nTdbMq+qdj/QUM0o=;
        b=mIiphrb+q1fwjBvotOVvpY0K3NEnOBOh/E2A/DYyLgC2MMVOYoceMNxYY0KOG9//Ek
         0mGVL2IupZXFG8ubkByZSgxDIQiywtWNBKo11yS7FmBiFwRd3weAfBTBJWGXrdMCJKWJ
         s0kg8tlr6CHH2ZH0e5ncD7uNJP8ZS5poDKXZa09NXwL0EszDu2RrEveBfKG4F+30oppC
         5UPgZFo6psb3zXiYvChPJALGcPd1KmK9ERSfzWpurPU2HZCcYFKAuzKLwhFnjXNBw0yY
         HDYP/SrGYgqiKW+YIj2PlbEwhRkj8rgOSUS3uB9gWqf93bXqaWZUGsdsNbMeBgZWxwfg
         8ncg==
X-Gm-Message-State: AGRZ1gJf6T5nclY+AdA7F4gOT1Nja9orLz/dqHcoKhJ5ekuDTzPmL8EK
        4XJ2n07gCtiyV5iwVFTBd9Yn8HA8
X-Google-Smtp-Source: AJdET5diaCsWzBGRh/2q031gf8W/FFihA910w40g4pgi5wQ1fYidmU1ySFRxSopM9pK+RXOUcQ8iEA==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12-v6mr26094wmh.39.1540925024587;
        Tue, 30 Oct 2018 11:43:44 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k66-v6sm9999825wmd.47.2018.10.30.11.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:43:43 -0700 (PDT)
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
Subject: [PATCH v2 1/3] pack-objects test: modernize style
Date:   Tue, 30 Oct 2018 18:43:29 +0000
Message-Id: <20181030184331.27264-2-avarab@gmail.com>
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

Modernize the quoting and indentation style of two tests added in
8685da4256 ("don't ever allow SHA1 collisions to exist by fetching a
pack", 2007-03-20), and of a subsequent one added in
4614043c8f ("index-pack: use streaming interface for collision test on
large blobs", 2012-05-24) which had copied the style of the first two.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5300-pack-object.sh | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 6c620cd540..a0309e4bab 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -475,22 +475,22 @@ test_expect_success 'pack-objects in too-many-packs mode' '
 # two tests at the end of this file.
 #
 
-test_expect_success \
-    'fake a SHA1 hash collision' \
-    'long_a=$(git hash-object a | sed -e "s!^..!&/!") &&
-     long_b=$(git hash-object b | sed -e "s!^..!&/!") &&
-     test -f	.git/objects/$long_b &&
-     cp -f	.git/objects/$long_a \
-		.git/objects/$long_b'
+test_expect_success 'fake a SHA1 hash collision' '
+	long_a=$(git hash-object a | sed -e "s!^..!&/!") &&
+	long_b=$(git hash-object b | sed -e "s!^..!&/!") &&
+	test -f	.git/objects/$long_b &&
+	cp -f	.git/objects/$long_a \
+		.git/objects/$long_b
+'
 
-test_expect_success \
-    'make sure index-pack detects the SHA1 collision' \
-    'test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
-     test_i18ngrep "SHA1 COLLISION FOUND" msg'
+test_expect_success 'make sure index-pack detects the SHA1 collision' '
+	test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
+	test_i18ngrep "SHA1 COLLISION FOUND" msg
+'
 
-test_expect_success \
-    'make sure index-pack detects the SHA1 collision (large blobs)' \
-    'test_must_fail git -c core.bigfilethreshold=1 index-pack -o bad.idx test-3.pack 2>msg &&
-     test_i18ngrep "SHA1 COLLISION FOUND" msg'
+test_expect_success 'make sure index-pack detects the SHA1 collision (large blobs)' '
+	test_must_fail git -c core.bigfilethreshold=1 index-pack -o bad.idx test-3.pack 2>msg &&
+	test_i18ngrep "SHA1 COLLISION FOUND" msg
+'
 
 test_done
-- 
2.19.1.899.g0250525e69

