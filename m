Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D79C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 17:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKYRiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 12:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiKYRiB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 12:38:01 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94D22019A
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 09:37:56 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
        t=1669397874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pE5WETpc+V55cEokMgR9Kt1Pj4Df6HDj1ifjkIbzKS4=;
        b=XCtFheKtJag+ngUi1LVfy6X83D3ea/NTSlN+OJgkYBWDKbzsL7vMv8jw+fNgHzrYINut19
        GTPqnJ3o35YZD3bDBidt0i3Fxd8soGbUvfj48sEEr0y7fp3yhNngbDsNPxamtj2w4/avBA
        vY4U0lhLqFoX6JOHTSRoMQPnQD+ohb76OZvTlWFKOgJudAARmBLfeDUFlC8brLanho8KTI
        VawH60gUFXcs0R4dvJK9zVzc/EShsI8dD8yM3ILwb74AFJhBv7H53WT5ajBqH1WQICowsM
        QKTiURRHIZyjnL0s3GeIBqi1Hkz6zCLjVkzhq5Hk8LA/mAB8MXkzF/UWhAbazw==
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] merge-recursive: fix variable typo in error message
Date:   Fri, 25 Nov 2022 12:37:45 -0500
Message-Id: <20221125173745.738643-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---

  Spotted when I was trying to grep for "unique" and entered the same
  typo.

 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4ddd3adea0..2fd0aa9687 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2100,7 +2100,7 @@ static char *handle_path_level_conflicts(struct merge_options *opt,
 	if (!new_path) {
 		/* This should only happen when entry->non_unique_new_dir set */
 		if (!entry->non_unique_new_dir)
-			BUG("entry->non_unqiue_dir not set and !new_path");
+			BUG("entry->non_unique_new_dir not set and !new_path");
 		output(opt, 1, _("CONFLICT (directory rename split): "
 			       "Unclear where to place %s because directory "
 			       "%s was renamed to multiple other directories, "

base-commit: e7e5c6f715b2de7bea0d39c7d2ba887335b40aa0
-- 
2.38.1

