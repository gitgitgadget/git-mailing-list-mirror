Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB26120C32
	for <e@80x24.org>; Thu,  7 Dec 2017 00:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbdLGAfV (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 19:35:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:5582 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbdLGAfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 19:35:20 -0500
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2017 16:35:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.45,370,1508828400"; 
   d="scan'208";a="561647"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.177.172])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2017 16:35:19 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] diff: add test showing regression to --relative
Date:   Wed,  6 Dec 2017 16:35:17 -0800
Message-Id: <20171207003517.11729-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.15.1.477.g3ed0a2a61da8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t4045-diff-relative.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 3950f5034d31..41e4f59b2ffb 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -70,4 +70,9 @@ for type in diff numstat stat raw; do
 	check_$type dir/file2 --relative=sub
 done
 
+cd subdir
+for type in diff numstat stat raw; do
+	check_$type file2 --relative
+done
+
 test_done
-- 
2.15.1.477.g3ed0a2a61da8

