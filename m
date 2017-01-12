Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18D791FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750803AbdALXSX (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:18:23 -0500
Received: from avasout06.plus.net ([212.159.14.18]:53694 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbdALXSW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:18:22 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id XbJJ1u0030srQBz01bJLBL; Thu, 12 Jan 2017 23:18:20 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=QoEu5R6d c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=091NnSid0Q1V57gPdzsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] worktree: fix an 'using plain integer as NULL pointer'
 warning
Message-ID: <7b28631d-77c1-b8a0-c671-307b9bef33ad@ramsayjones.plus.com>
Date:   Thu, 12 Jan 2017 23:18:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
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

If you need to re-roll your 'nd/worktree-move' branch, could you
please squash this into the relevant patch. (commit 62985f75c1
"worktree move: refuse to move worktrees with submodules", 08-01-2017).

[BTW, this is a sparse warning, just in case you were wondering!]

Thanks!

ATB,
Ramsay Jones

 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 339c622e2..a1c91f154 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -528,7 +528,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 
 static void validate_no_submodules(const struct worktree *wt)
 {
-	struct index_state istate = {0};
+	struct index_state istate = { NULL };
 	int i, found_submodules = 0;
 
 	if (read_index_from(&istate, worktree_git_path(wt, "index")) > 0) {
-- 
2.11.0
