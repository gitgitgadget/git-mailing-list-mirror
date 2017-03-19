Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A646D20323
	for <e@80x24.org>; Sun, 19 Mar 2017 21:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbdCSVNH (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 17:13:07 -0400
Received: from avasout01.plus.net ([84.93.230.227]:55648 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbdCSVNG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 17:13:06 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id xxBr1u00522aPyA01xBsLr; Sun, 19 Mar 2017 21:11:52 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=M_uVpbLzLlhKW9DM_F0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] revision.c: fix an 'Using integer as NULL pointer' warning
Message-ID: <b465515a-5868-a614-ff99-490f4c86aa69@ramsayjones.plus.com>
Date:   Sun, 19 Mar 2017 21:11:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Duy,

If you need to re-roll your 'nd/prune-in-worktree' branch, could you please
squash this into the relevant patch (commit 0a30ae48bb, "revision.c:
--indexed-objects add objects from all worktrees", 18-03-2017).

Thanks!

ATB,
Ramsay Jones

 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index e01e2f99c..a06b150f7 100644
--- a/revision.c
+++ b/revision.c
@@ -1336,7 +1336,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	worktrees = get_worktrees(0);
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
-		struct index_state istate = {0};
+		struct index_state istate = { NULL };
 
 		if (wt->is_current)
 			continue; /* current index already taken care of */
-- 
2.12.0
