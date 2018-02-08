Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32721F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeBHQUR (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:17 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40406 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbeBHQUN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:13 -0500
Received: by mail-wm0-f65.google.com with SMTP id v123so11040711wmd.5
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KrjRaUiI1hv7or3sWjtzYGNa1x09mBLA+Ct7/dtEyp8=;
        b=RKc4zAd9Hn8rz1pJyU8mZEsdOb4cBpVwucrn0b+HpUyx8QzQXYzrpOQRd75jN1z9BO
         DmXzwh/ylwtT17/84OeQq2MEuKS2639qxowyJHa4lo/6v7ty8hIG7fbC0WeUwTXRNeA1
         euLInXEmSjR/7MdqJmmGDE9UxedRpGoXN57Hi0kpyduLk0G8suFx4s3awvL01vBt1Rln
         8tnRSLfLIdSkwOBVxVzgOSLQKTj4BFmx8W9ZkFfNjrw5SSReJ2IzEkPOrkrLZ3S37Nsn
         EPy05QJDEVI5jaGpnRm+XSU6RX2t8uo/4QDnQZPnnqqmkFlbjAvXHco+apPF3VRZGFs4
         NZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KrjRaUiI1hv7or3sWjtzYGNa1x09mBLA+Ct7/dtEyp8=;
        b=m3FjI1plyKfs+u3QMwWwhGL2Cp5D6rys176muH7hwdf2Rqv8aELJBc/eKiL/snPamZ
         DlA6t9txA9bLhnapgEkPmgXTWJovlYhRplhndojO+PoyeFZi32TtZivm8GgoxKkWT6cn
         W5cV2Dvuo0ZDPA0JZpvckHtDRakPg1XfYW91ojZIIKgdITQ3h9ROaacqzAAOePHLNDmv
         qS806CuvjKvs3cyN6Ae1uUGpVGaQocsNX9di1CvunajN5prc2MBRuhXKSpFuey/ueIPJ
         QA8pYnI7/+InBvpiWpj529ZhOTbfeIKLcQfdVi4+bF4ofL/QicSoU1nDn9IvSHiFYFsn
         11Qg==
X-Gm-Message-State: APf1xPCCWsBGzcOAyWZITPN2K2mvdZLMDAEdNQTqpOCFuGaKxT1Qhgtt
        u5AH1XCZDJsq7gzZdBBb5bmjmSgh
X-Google-Smtp-Source: AH8x2261ANsZjGQicWXl2V9EO4UFY2afrPuS86hrVCeVCsySP744LzAGfNdcczPzj+ulqivdy90THA==
X-Received: by 10.28.147.196 with SMTP id v187mr1671150wmd.128.1518106812314;
        Thu, 08 Feb 2018 08:20:12 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/17] fetch tests: re-arrange arguments for future readability
Date:   Thu,  8 Feb 2018 16:19:25 +0000
Message-Id: <20180208161936.8196-7-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-arrange the arguments to the test_configured_prune() function used
in this test to pass the arguments to --fetch last. A subsequent
change will test for more elaborate fetch arguments, including long
refspecs. It'll be more readable to be able to wrap those on a new
line of their own.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 82 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 11da97f9b7..ab8b25344d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -551,10 +551,10 @@ set_config_tristate () {
 test_configured_prune () {
 	fetch_prune=$1
 	remote_origin_prune=$2
-	cmdline=$3
-	expected_branch=$4
+	expected_branch=$3
+	cmdline=$4
 
-	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${3:+ $3}; branch:$4" '
+	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${4:+ $4}; branch:$3" '
 		# make sure a newbranch is there in . and also in one
 		git branch -f newbranch &&
 		(
@@ -587,41 +587,47 @@ test_configured_prune () {
 	'
 }
 
-test_configured_prune unset unset ""		kept
-test_configured_prune unset unset "--no-prune"	kept
-test_configured_prune unset unset "--prune"	pruned
-
-test_configured_prune false unset ""		kept
-test_configured_prune false unset "--no-prune"	kept
-test_configured_prune false unset "--prune"	pruned
-
-test_configured_prune true  unset ""		pruned
-test_configured_prune true  unset "--prune"	pruned
-test_configured_prune true  unset "--no-prune"	kept
-
-test_configured_prune unset false ""		kept
-test_configured_prune unset false "--no-prune"	kept
-test_configured_prune unset false "--prune"	pruned
-
-test_configured_prune false false ""		kept
-test_configured_prune false false "--no-prune"	kept
-test_configured_prune false false "--prune"	pruned
-
-test_configured_prune true  false ""		kept
-test_configured_prune true  false "--prune"	pruned
-test_configured_prune true  false "--no-prune"	kept
-
-test_configured_prune unset true  ""		pruned
-test_configured_prune unset true  "--no-prune"	kept
-test_configured_prune unset true  "--prune"	pruned
-
-test_configured_prune false true  ""		pruned
-test_configured_prune false true  "--no-prune"	kept
-test_configured_prune false true  "--prune"	pruned
-
-test_configured_prune true  true  ""		pruned
-test_configured_prune true  true  "--prune"	pruned
-test_configured_prune true  true  "--no-prune"	kept
+# $1 config: fetch.prune
+# $2 config: remote.<name>.prune
+# $3 expect: branch to be pruned?
+# $4 git-fetch $cmdline:
+#
+#                     $1    $2    $3     $4
+test_configured_prune unset unset kept   ""
+test_configured_prune unset unset kept   "--no-prune"
+test_configured_prune unset unset pruned "--prune"
+
+test_configured_prune false unset kept   ""
+test_configured_prune false unset kept   "--no-prune"
+test_configured_prune false unset pruned "--prune"
+
+test_configured_prune true  unset pruned ""
+test_configured_prune true  unset pruned "--prune"
+test_configured_prune true  unset kept   "--no-prune"
+
+test_configured_prune unset false kept   ""
+test_configured_prune unset false kept   "--no-prune"
+test_configured_prune unset false pruned "--prune"
+
+test_configured_prune false false kept   ""
+test_configured_prune false false kept   "--no-prune"
+test_configured_prune false false pruned "--prune"
+
+test_configured_prune true  false kept   ""
+test_configured_prune true  false pruned "--prune"
+test_configured_prune true  false kept   "--no-prune"
+
+test_configured_prune unset true  pruned ""
+test_configured_prune unset true  kept   "--no-prune"
+test_configured_prune unset true  pruned "--prune"
+
+test_configured_prune false true  pruned ""
+test_configured_prune false true  kept   "--no-prune"
+test_configured_prune false true  pruned "--prune"
+
+test_configured_prune true  true  pruned ""
+test_configured_prune true  true  pruned "--prune"
+test_configured_prune true  true  kept   "--no-prune"
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
2.15.1.424.g9478a66081

