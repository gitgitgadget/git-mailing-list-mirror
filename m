Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EDEC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346180AbiCXFAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346265AbiCXFAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 01:00:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC56B2B18D
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r13so4925102wrr.9
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f/ZbN5quD6ggV2+4j9lRbjM6zktg3vb1d35PK4/3tT4=;
        b=V+DDuV+a+prxUkTSHvXDayTX7LEsI92hd/ZeK/3jock+iJNZbdJjCdmpG4kZetD49E
         0DqxAgFct2PQc8RJ0qm12FxY3Nds0rO0VM/eTwPiibx0UZ3F7tSlyBrLt3d7XFDGfrXW
         wlR8g0Hq/OJkFa4BiPpO2Yac4oD+ejcS5j8suzY3+VuyktUw53GTl8N6WWG6M1kMuPkz
         ltWcb9a4iGtD+qkbdpHhrwL6mydgrXcViXK3Ks7z/nl2871agZa/Kehojyw0VF52p3gW
         tX48wr0xVAjk+a/ZL39HAc9UN0z51c3ukg8qdMV1ZKH0FYQNhceBLuqgPaCblxfH4sTb
         JqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f/ZbN5quD6ggV2+4j9lRbjM6zktg3vb1d35PK4/3tT4=;
        b=uKTTl3AFIV37rq/EDAl/hW4iXzmBl+3+n5f+MaZSgMfvn7+iyeyOt1Oj2gV5egQBFG
         qfHWP2RsY64BLsBjBrGKWbm79kolSwWhQepZHUFFNGeJfDZ6IYq1+lJIinvyArDlFoi8
         b6pCG4v6HToKUWMq/T+S1KTARyAZfDak3uiwUI9VM+KglAbyA2pmAbH2LaOxQTX7Ommr
         LTujGpUU3njxq/4BLN7fCQ6sl04E4Gs0r9XUHxcUcRNaq/Rg6LpOwqS4NZhtAlLq8kDv
         APquy5wjTqUM5gyYlnKL5Vh5FamoybSA8s77nkpZJAAGggs/daXXyAlEkHvXeEPbdxXG
         2R0w==
X-Gm-Message-State: AOAM532WmS079NFZMRS6pEmTBOqk7iUuiYyc88++eWmvvUiTs+4bZKwB
        R/cMa6S0q5FUvCMynE2fk9Ws/NA7np8=
X-Google-Smtp-Source: ABdhPJxJTzD97ZxwPrdT84gTJ6ncO+prUg6L+3wWt+NtgvfqQ/pD0cuAUUaFXK/B8s6FnaYG/M4Zgg==
X-Received: by 2002:adf:eb86:0:b0:1e6:8c92:af6b with SMTP id t6-20020adfeb86000000b001e68c92af6bmr2969735wrn.116.1648097920369;
        Wed, 23 Mar 2022 21:58:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600002ad00b00203d64c5289sm1697902wry.112.2022.03.23.21.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 21:58:39 -0700 (PDT)
Message-Id: <8f1b01c9ca0aff1412657d230f58fdcd7b3aeade.1648097906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 04:58:23 +0000
Subject: [PATCH v3 08/11] test-lib-functions: add parsing helpers for ls-files
 and ls-tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Several tests use awk to parse OIDs from the output of 'git ls-files
--stage' and 'git ls-tree'. Introduce helpers to centralize these uses
of awk.

Update t5317-pack-objects-filter-objects.sh to use the new ls-files
helper so that it has some usages to review. Other updates are left for
the future.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/t5317-pack-objects-filter-objects.sh | 91 +++++++++++++-------------
 t/test-lib-functions.sh                | 10 +++
 2 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 33b740ce628..bb633c9b099 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -10,9 +10,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 # Test blob:none filter.
 
 test_expect_success 'setup r1' '
-	echo "{print \$1}" >print_1.awk &&
-	echo "{print \$2}" >print_2.awk &&
-
 	git init r1 &&
 	for n in 1 2 3 4 5
 	do
@@ -22,10 +19,13 @@ test_expect_success 'setup r1' '
 	done
 '
 
+parse_verify_pack_blob_oid () {
+	awk '{print $1}' -
+}
+
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
-		>ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r1 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -35,7 +35,7 @@ test_expect_success 'verify blob count in normal packfile' '
 
 	git -C r1 verify-pack -v ../all.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -54,12 +54,12 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
 	git -C r1 verify-pack -v ../all.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >expected &&
 
 	git -C r1 verify-pack -v ../filter.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -123,8 +123,8 @@ test_expect_success 'setup r2' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 large.10000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -134,7 +134,7 @@ test_expect_success 'verify blob count in normal packfile' '
 
 	git -C r2 verify-pack -v ../all.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -161,8 +161,8 @@ test_expect_success 'verify blob:limit=1000' '
 '
 
 test_expect_success 'verify blob:limit=1001' '
-	git -C r2 ls-files -s large.1000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1001 >filter.pack <<-EOF &&
@@ -172,15 +172,15 @@ test_expect_success 'verify blob:limit=1001' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=10001' '
-	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 large.10000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout --filter=blob:limit=10001 >filter.pack <<-EOF &&
@@ -190,15 +190,15 @@ test_expect_success 'verify blob:limit=10001' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=1k' '
-	git -C r2 ls-files -s large.1000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
@@ -208,15 +208,15 @@ test_expect_success 'verify blob:limit=1k' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify explicitly specifying oversized blob in input' '
-	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 large.10000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	echo HEAD >objects &&
@@ -226,15 +226,15 @@ test_expect_success 'verify explicitly specifying oversized blob in input' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=1m' '
-	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 large.10000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1m >filter.pack <<-EOF &&
@@ -244,7 +244,7 @@ test_expect_success 'verify blob:limit=1m' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -253,12 +253,12 @@ test_expect_success 'verify blob:limit=1m' '
 test_expect_success 'verify normal and blob:limit packfiles have same commits/trees' '
 	git -C r2 verify-pack -v ../all.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >expected &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -289,9 +289,8 @@ test_expect_success 'setup r3' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
-		>ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r3 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -301,7 +300,7 @@ test_expect_success 'verify blob count in normal packfile' '
 
 	git -C r3 verify-pack -v ../all.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -342,9 +341,8 @@ test_expect_success 'setup r4' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
-		>ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r4 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -354,19 +352,19 @@ test_expect_success 'verify blob count in normal packfile' '
 
 	git -C r4 verify-pack -v ../all.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify sparse:oid=OID' '
-	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r4 ls-files -s pattern >staged &&
-	oid=$(awk -f print_2.awk staged) &&
+	oid=$(test_parse_ls_files_stage_oids <staged) &&
 	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
 	HEAD
 	EOF
@@ -374,15 +372,15 @@ test_expect_success 'verify sparse:oid=OID' '
 
 	git -C r4 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify sparse:oid=oid-ish' '
-	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=main:pattern >filter.pack <<-EOF &&
@@ -392,7 +390,7 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 
 	git -C r4 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -402,9 +400,8 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 # This models previously omitted objects that we did not receive.
 
 test_expect_success 'setup r1 - delete loose blobs' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
-		>ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	for id in `cat expected | sed "s|..|&/|"`
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index a027f0c409e..e6011409e2f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1782,6 +1782,16 @@ test_oid_to_path () {
 	echo "${1%$basename}/$basename"
 }
 
+# Parse oids from git ls-files --staged output
+test_parse_ls_files_stage_oids () {
+	awk '{print $2}' -
+}
+
+# Parse oids from git ls-tree output
+test_parse_ls_tree_oids () {
+	awk '{print $3}' -
+}
+
 # Choose a port number based on the test script's number and store it in
 # the given variable name, unless that variable already contains a number.
 test_set_port () {
-- 
gitgitgadget

