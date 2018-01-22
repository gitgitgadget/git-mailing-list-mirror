Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91A541F576
	for <e@80x24.org>; Mon, 22 Jan 2018 04:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751101AbeAVEfM (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 23:35:12 -0500
Received: from ng2.cptxoffice.net ([208.74.121.106]:18632 "EHLO
        felipe64.dev.cpanel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750955AbeAVEfM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 23:35:12 -0500
X-Greylist: delayed 958 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2018 23:35:11 EST
Received: from root by felipe64.dev.cpanel.net with local (Exim 4.90)
        (envelope-from <felipe@felipegasper.com>)
        id 1edTZY-00029z-Fj
        for git@vger.kernel.org; Sun, 21 Jan 2018 22:19:04 -0600
Date:   Sun, 21 Jan 2018 22:19:04 -0600
From:   felipe@felipegasper.com
To:     git@vger.kernel.org
Subject: [PATCH] Fix comma splices
Message-ID: <5a656638.LthG4qGgtrvPcSKz%felipe@felipegasper.com>
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - felipe64.dev.cpanel.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - felipegasper.com
X-Get-Message-Sender-Via: felipe64.dev.cpanel.net: sender_ident via received_protocol == local: root/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: felipe64.dev.cpanel.net: root
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From b18bd6babc2d6a6f79177acfa2416bb5bf2b153f Mon Sep 17 00:00:00 2001
From: Felipe Gasper <felipe@felipegasper.com>
Date: Sun, 21 Jan 2018 23:01:47 -0500
Subject: [PATCH] Fix comma splices in remote.c

Signed-off-by: Felipe Gasper <felipe@felipegasper.com>
---
 remote.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 4e93753e1..e8ba808c5 100644
--- a/remote.c
+++ b/remote.c
@@ -2123,9 +2123,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
 		strbuf_addf(sb,
-			Q_("Your branch is behind '%s' by %d commit, "
+			Q_("Your branch is behind '%s' by %d commit "
 			       "and can be fast-forwarded.\n",
-			   "Your branch is behind '%s' by %d commits, "
+			   "Your branch is behind '%s' by %d commits "
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			base, theirs);
@@ -2134,11 +2134,11 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
 		strbuf_addf(sb,
-			Q_("Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commit each, "
+			Q_("Your branch and '%s' have diverged.\n"
+			       "They have %d and %d different commit each, "
 			       "respectively.\n",
-			   "Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commits each, "
+			   "Your branch and '%s' have diverged.\n"
+			       "They have %d and %d different commits each, "
 			       "respectively.\n",
 			   ours + theirs),
 			base, ours, theirs);
-- 
2.15.1

