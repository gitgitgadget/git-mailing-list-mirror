Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270ED1F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfEIVcQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:32:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:53726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726219AbfEIVcP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:32:15 -0400
Received: (qmail 10121 invoked by uid 109); 9 May 2019 21:32:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:32:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6609 invoked by uid 111); 9 May 2019 21:32:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:32:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:32:14 -0400
Date:   Thu, 9 May 2019 17:32:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 13/14] show-branch: drop unused parameter from
 show_independent()
Message-ID: <20190509213213.GM15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ref_name parameter was never used since the inception of
show_independent() in 1f8af483df (show-branch: --list and --independent,
2005-09-09). Let's drop it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/show-branch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 082daeac32..35d7f51c23 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -514,7 +514,6 @@ static int show_merge_base(struct commit_list *seen, int num_rev)
 
 static int show_independent(struct commit **rev,
 			    int num_rev,
-			    char **ref_name,
 			    unsigned int *rev_mask)
 {
 	int i;
@@ -862,7 +861,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		return show_merge_base(seen, num_rev);
 
 	if (independent)
-		return show_independent(rev, num_rev, ref_name, rev_mask);
+		return show_independent(rev, num_rev, rev_mask);
 
 	/* Show list; --more=-1 means list-only */
 	if (1 < num_rev || extra < 0) {
-- 
2.21.0.1382.g4c6032d436

