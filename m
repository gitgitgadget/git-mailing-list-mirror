Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C83C207EB
	for <e@80x24.org>; Thu, 27 Apr 2017 20:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422957AbdD0U7d (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 16:59:33 -0400
Received: from [192.252.130.194] ([192.252.130.194]:34586 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S968933AbdD0U7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 16:59:30 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Apr 2017 16:59:30 EDT
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id 4FE8061813;
        Thu, 27 Apr 2017 16:50:37 -0400 (EDT)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>
Subject: [PATCH 1/2] Make the indent heuristic part of diff's basic configuration.
Date:   Thu, 27 Apr 2017 16:50:36 -0400
Message-Id: <20170427205037.1787-2-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.13.0.rc1.15.g7dbea34e1.dirty
In-Reply-To: <20170427205037.1787-1-marcnarc@xiplink.com>
References: <20170427205037.1787-1-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 11eef1c85..da96577ea 100644
--- a/diff.c
+++ b/diff.c
@@ -290,9 +290,6 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (git_diff_heuristic_config(var, value, cb) < 0)
-		return -1;
-
 	if (!strcmp(var, "diff.wserrorhighlight")) {
 		int val = parse_ws_error_highlight(value);
 		if (val < 0)
@@ -351,6 +348,9 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	if (starts_with(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
+	if (git_diff_heuristic_config(var, value, cb) < 0)
+		return -1;
+
 	return git_default_config(var, value, cb);
 }
 
-- 
2.13.0.rc1.15.g7dbea34e1.dirty

