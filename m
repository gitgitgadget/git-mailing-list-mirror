Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9175C207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 22:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999731AbdD1WdY (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 18:33:24 -0400
Received: from [192.252.130.194] ([192.252.130.194]:34829 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1035941AbdD1WdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 18:33:16 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id 18024618FD;
        Fri, 28 Apr 2017 18:33:14 -0400 (EDT)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] diff: enable indent heuristic by default
Date:   Fri, 28 Apr 2017 18:33:15 -0400
Message-Id: <20170428223315.17140-4-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.13.0.rc1.15.gf67d331ad
In-Reply-To: <20170428223315.17140-1-marcnarc@xiplink.com>
References: <20170427205037.1787-1-marcnarc@xiplink.com>
 <20170428223315.17140-1-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

The feature was included in v2.11 (released 2016-11-29) and we got no
negative feedback. Quite the opposite, all feedback we got was positive.

Turn it on by default. Users who dislike the feature can turn it off
by setting diff.compactionHeuristic (which includes plumbing commands,
see prior patches).

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index da96577ea..2c47ccb4a 100644
--- a/diff.c
+++ b/diff.c
@@ -27,7 +27,7 @@
 #endif
 
 static int diff_detect_rename_default;
-static int diff_indent_heuristic; /* experimental */
+static int diff_indent_heuristic = 1;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
-- 
2.13.0.rc1.15.gf67d331ad

