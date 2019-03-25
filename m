Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381BB20248
	for <e@80x24.org>; Mon, 25 Mar 2019 18:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfCYSOb (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 14:14:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35071 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfCYSO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 14:14:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id s39so2903984edb.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JyFzcaTYQSB9GuPQKaxTDKm9YHvpcpHbe30toDYdzN8=;
        b=uzNzXCRAYvOoXGIbRqvS4Lj5zxGeVJ/aofTcI+D8mm4IbIAhvNBlsMFidywLU7Myw6
         pg+thv/jszfFKpZ5pKK46PE4n7jXLVlII6zJTI8Y4kj0+XAUu2lqn0X4dgUHhBmdtqIE
         9rCAygZPNwARh4KZ0hxf+qlHAGQz77SSeMK4W4e+xUlj7xAlGN/i35Ps44wN5tMit0xz
         36dghw+puGqDTIb/ZQbYxw4rZ7Sddj2PnEFpGxGNEIuTP0Xskp9QNSep2tPw1M8Y9wek
         dBJ9aCJ5cJ6bb2gITUAL2Q2gaM2/K611t7y7bLtm1fMTp8I/ZuLwzUyJKNHG0KnNQwGd
         alPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JyFzcaTYQSB9GuPQKaxTDKm9YHvpcpHbe30toDYdzN8=;
        b=PYqDsLmVLvBripGRW2a191lLJfrqxEmy8awwzdAnq4k+JbxSPmGzEtNZuroFCcIp+A
         LvHLIpQFPRmS41WRG+pEFbhsVphoWMgtvIuE++VV8SChN4bcI/ITm/9N28E90rbYAd07
         uJBpIKVWCijLfgu7cmz4CvCTVzkgW0f9Ki9eEqWsVtI+r+PgicJ4985CTeh6JnfHK558
         BQKfptMFCK53ozC9UwoRjZG6j5ZPSaa7BhN/HPtX3PdEx2dlogdMXyiayNRCvQ8HY0jJ
         OvoQoc9SnDXyv7oO3aKWetDa9smV5vEmmGvXHeG5INnJZL/eoyfS6zXxRVk7U2WMmp4z
         vBHA==
X-Gm-Message-State: APjAAAV2sXMTuLJ7+wEgR1+GbBuAGMg5hjFd57ll7yPaOSAcJpb4bJCF
        MDMZDsowRYWB+ltFfi0UOhjDlO4m
X-Google-Smtp-Source: APXvYqxFEexpN5A9fTbs9wvQ7rWbhWFK9fuZu8+bul6dLTmEvGcXqdVTOGy3HntBZ3AePUot1dquCw==
X-Received: by 2002:a17:906:289b:: with SMTP id o27mr14684386ejd.161.1553537663498;
        Mon, 25 Mar 2019 11:14:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm6073662edd.33.2019.03.25.11.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:14:23 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:14:23 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 18:14:15 GMT
Message-Id: <a722a065d2c3249bddd987cca9a37779a81bb378.1553537656.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 7/8] tests (pack-objects): use the full, unabbreviated
 `--revs` option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To use the singular form of a word, when the option wants the plural
form (and quietly expands it because it thinks it was abbreviated), is
an easy mistake to make, and t5317 contains almost two dozen of them.

However, using abbreviated options in tests is a bit fragile, so we will
disallow use of abbreviated options in our test suite.

In preparation for this change, let's fix
`t5317-pack-objects-filter-objects.sh`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5317-pack-objects-filter-objects.sh | 44 +++++++++++++-------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 24541ea137..4c0201c34b 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -25,7 +25,7 @@ test_expect_success 'verify blob count in normal packfile' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r1 pack-objects --rev --stdout >all.pack <<-EOF &&
+	git -C r1 pack-objects --revs --stdout >all.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r1 index-pack ../all.pack &&
@@ -39,7 +39,7 @@ test_expect_success 'verify blob count in normal packfile' '
 '
 
 test_expect_success 'verify blob:none packfile has no blobs' '
-	git -C r1 pack-objects --rev --stdout --filter=blob:none >filter.pack <<-EOF &&
+	git -C r1 pack-objects --revs --stdout --filter=blob:none >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r1 index-pack ../filter.pack &&
@@ -74,7 +74,7 @@ test_expect_success 'get an error for missing tree object' '
 	git -C r5 commit -m "foo" &&
 	del=$(git -C r5 rev-parse HEAD^{tree} | sed "s|..|&/|") &&
 	rm r5/.git/objects/$del &&
-	test_must_fail git -C r5 pack-objects --rev --stdout 2>bad_tree <<-EOF &&
+	test_must_fail git -C r5 pack-objects --revs --stdout 2>bad_tree <<-EOF &&
 	HEAD
 	EOF
 	grep "bad tree object" bad_tree
@@ -88,7 +88,7 @@ test_expect_success 'setup for tests of tree:0' '
 '
 
 test_expect_success 'verify tree:0 packfile has no blobs or trees' '
-	git -C r1 pack-objects --rev --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
+	git -C r1 pack-objects --revs --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r1 index-pack ../commitsonly.pack &&
@@ -98,7 +98,7 @@ test_expect_success 'verify tree:0 packfile has no blobs or trees' '
 
 test_expect_success 'grab tree directly when using tree:0' '
 	# We should get the tree specified directly but not its blobs or subtrees.
-	git -C r1 pack-objects --rev --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
+	git -C r1 pack-objects --revs --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
 	HEAD:
 	EOF
 	git -C r1 index-pack ../commitsonly.pack &&
@@ -128,7 +128,7 @@ test_expect_success 'verify blob count in normal packfile' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --rev --stdout >all.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout >all.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../all.pack &&
@@ -142,7 +142,7 @@ test_expect_success 'verify blob count in normal packfile' '
 '
 
 test_expect_success 'verify blob:limit=500 omits all blobs' '
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=500 >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=500 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
@@ -157,7 +157,7 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 '
 
 test_expect_success 'verify blob:limit=1000' '
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1000 >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1000 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
@@ -176,7 +176,7 @@ test_expect_success 'verify blob:limit=1001' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1001 >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1001 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
@@ -194,7 +194,7 @@ test_expect_success 'verify blob:limit=10001' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=10001 >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=10001 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
@@ -212,7 +212,7 @@ test_expect_success 'verify blob:limit=1k' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
@@ -230,7 +230,7 @@ test_expect_success 'verify explicitly specifying oversized blob in input' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
 	HEAD
 	$(git -C r2 rev-parse HEAD:large.10000)
 	EOF
@@ -249,7 +249,7 @@ test_expect_success 'verify blob:limit=1m' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1m >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1m >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
@@ -302,7 +302,7 @@ test_expect_success 'verify blob count in normal packfile' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r3 pack-objects --rev --stdout >all.pack <<-EOF &&
+	git -C r3 pack-objects --revs --stdout >all.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r3 index-pack ../all.pack &&
@@ -320,7 +320,7 @@ test_expect_success 'verify sparse:path=pattern1' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r3 pack-objects --rev --stdout --filter=sparse:path=../pattern1 >filter.pack <<-EOF &&
+	git -C r3 pack-objects --revs --stdout --filter=sparse:path=../pattern1 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r3 index-pack ../filter.pack &&
@@ -352,7 +352,7 @@ test_expect_success 'verify sparse:path=pattern2' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r3 pack-objects --rev --stdout --filter=sparse:path=../pattern2 >filter.pack <<-EOF &&
+	git -C r3 pack-objects --revs --stdout --filter=sparse:path=../pattern2 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r3 index-pack ../filter.pack &&
@@ -404,7 +404,7 @@ test_expect_success 'verify blob count in normal packfile' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r4 pack-objects --rev --stdout >all.pack <<-EOF &&
+	git -C r4 pack-objects --revs --stdout >all.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r4 index-pack ../all.pack &&
@@ -423,7 +423,7 @@ test_expect_success 'verify sparse:oid=OID' '
 	sort >expected &&
 
 	oid=$(git -C r4 ls-files -s pattern | awk -f print_2.awk) &&
-	git -C r4 pack-objects --rev --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
+	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r4 index-pack ../filter.pack &&
@@ -441,7 +441,7 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r4 pack-objects --rev --stdout --filter=sparse:oid=master:pattern >filter.pack <<-EOF &&
+	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=master:pattern >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r4 index-pack ../filter.pack &&
@@ -470,19 +470,19 @@ test_expect_success 'setup r1 - delete loose blobs' '
 '
 
 test_expect_success 'verify pack-objects fails w/ missing objects' '
-	test_must_fail git -C r1 pack-objects --rev --stdout >miss.pack <<-EOF
+	test_must_fail git -C r1 pack-objects --revs --stdout >miss.pack <<-EOF
 	HEAD
 	EOF
 '
 
 test_expect_success 'verify pack-objects fails w/ --missing=error' '
-	test_must_fail git -C r1 pack-objects --rev --stdout --missing=error >miss.pack <<-EOF
+	test_must_fail git -C r1 pack-objects --revs --stdout --missing=error >miss.pack <<-EOF
 	HEAD
 	EOF
 '
 
 test_expect_success 'verify pack-objects w/ --missing=allow-any' '
-	git -C r1 pack-objects --rev --stdout --missing=allow-any >miss.pack <<-EOF
+	git -C r1 pack-objects --revs --stdout --missing=allow-any >miss.pack <<-EOF
 	HEAD
 	EOF
 '
-- 
gitgitgadget

