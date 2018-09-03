Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408491F404
	for <e@80x24.org>; Mon,  3 Sep 2018 21:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeIDBcl (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 21:32:41 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:35039 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIDBcl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 21:32:41 -0400
Received: by mail-pg1-f176.google.com with SMTP id 7-v6so617004pgf.2
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pVB8E/lPFgp4v9tiqN/mcvaLyAweiUqEBhHKGeIKOPU=;
        b=RfXgeeznjLOCyjCrl+RNMYOl6FIyBiuiZWY1Xc5V9lklOaFVk05YMfDMaoTEP1pHdY
         PntrpT7em4LT9EY2+FBRpndVex6EJcSl8ssRTz09aN5HTIU5vDXc5EZpQg5kgM1dvGeF
         Y7auuvmaw9zLS9SdYMel1j3uQTYQyB3ae3BC5X0x3pjOoOfeqzp3G/Jm9phdbZCDPI39
         GuM+Fa21YEVezeDswJDG5tK4kgc+CTkyEod6OYE45TwtUWPEz161T8wuvQr0V8MllbBu
         z3zFGUJ9ALthO+LJtB24MtktL2DVFyYDfJ60wk8K0IT9jXlJClWSRbjuIyG6pkDI4Ki/
         bLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pVB8E/lPFgp4v9tiqN/mcvaLyAweiUqEBhHKGeIKOPU=;
        b=rVHPNoy8ARgdb8su9raCpG/bXIQcZnaw7eezJLDYrZ8AYJsvAAquhPprS3hmN7xOCy
         J+uHqHMqHRlDJ3zTUzgk8lgaXnA+Bj++ZBQtA0LzVgqAjh/HzDaNwgZNDzD+swKhzopm
         Qi1ckfGiwCs4H0rNje3MXTNVwS22AgElZwi9Ka9Fm7IAfTFW7ho8901GeWx2+koX8zZb
         Lna/SPe7BDbf5MaxOZkewCRfkYnfIKD4ZGkJ5SGfouQCksaVs1lVR+TRoBK78t1twgCE
         8rKBTcUrkDIO1EzgnP85T/6SntQOP0Q8WMzuDkYKB6T5Bn26eb9cWYG3njTJ8k/Pv7+f
         WPWw==
X-Gm-Message-State: APzg51DjIerMdnmsRR27Yj/OnI6D/LhXpxcmlbhN3X2PthlHjcj+SL9w
        McOL3QsAfpfWtWPxVLzY7uD+m8un
X-Google-Smtp-Source: ANB0VdY8t+B1Ser9PR/GDVbWFmludHX3OeDd2AN2Dy6XEqJ+GQAmvvuCm04LiZ8MU4Gicx2+7TMh9A==
X-Received: by 2002:a63:91c2:: with SMTP id l185-v6mr28694723pge.321.1536009040838;
        Mon, 03 Sep 2018 14:10:40 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id 143-v6sm26695192pfy.156.2018.09.03.14.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 14:10:40 -0700 (PDT)
Date:   Mon, 03 Sep 2018 14:10:40 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Sep 2018 21:10:25 GMT
Message-Id: <3e83c6409068cf920d0c0a60e0e9a98b9bd6841a.1536009027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 8/9] tests: record more stderr with --write-junit-xml in case
 of failure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Sometimes, failures in a test case are actually caused by issues in
earlier test cases.

To make it easier to see those issues, let's attach the output from
before the failing test case (i.e. stdout/stderr since the previous
failing test case, or the start of the test script). This will be
visible in the "Attachments" of the details of the failed test.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ea4ed250cc..6fc03d5a3b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -484,6 +484,9 @@ test_failure_ () {
 			"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")"
 		>"$GIT_TEST_TEE_OUTPUT_FILE"
 		junit_insert="$junit_insert</failure>"
+		junit_insert="$junit_insert<system-err>$(xml_attr_encode \
+			"$(cat "$GIT_TEST_TEE_OUTPUT_FILE.err")")</system-err>"
+		>"$GIT_TEST_TEE_OUTPUT_FILE.err"
 		write_junit_xml_testcase "$1" "      $junit_insert"
 	fi
 	test_failure=$(($test_failure + 1))
@@ -768,9 +771,12 @@ test_start_ () {
 	then
 		junit_start=$(test-tool date getnanos)
 
-		# truncate output
-		test -z "$GIT_TEST_TEE_OUTPUT_FILE" ||
-		>"$GIT_TEST_TEE_OUTPUT_FILE"
+		# append to future <system-err>; truncate output
+		test -z "$GIT_TEST_TEE_OUTPUT_FILE" || {
+			cat "$GIT_TEST_TEE_OUTPUT_FILE" \
+				>>"$GIT_TEST_TEE_OUTPUT_FILE.err"
+			>"$GIT_TEST_TEE_OUTPUT_FILE"
+		}
 	fi
 }
 
-- 
gitgitgadget

