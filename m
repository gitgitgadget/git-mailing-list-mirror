Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505891FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 20:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbcLBU4w (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 15:56:52 -0500
Received: from avasout05.plus.net ([84.93.230.250]:55115 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753981AbcLBU4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 15:56:51 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout05 with smtp
        id F8vS1u0050srQBz018vT4J; Fri, 02 Dec 2016 20:55:27 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Qskc5h6d c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=lvzirCMbqF21AA6VKuwA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] worktree: mark a file-local symbol with static
Message-ID: <0be15cd5-4ecb-3d87-93ee-d34d2be2d4c6@ramsayjones.plus.com>
Date:   Fri, 2 Dec 2016 20:55:25 +0000
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

Hi Stefan,

If you need to re-roll your 'sb/submodule-intern-gitdir'
branch, could you please squash something similar to this
into the relevant patch (commit 2529715dc, "worktree: get
worktrees from submodules", 01-12-2016).

[This is based on pu; ie. on top of merge 86c7f863a, where
Junio as added the 'flags' parameter.]

Thanks!

ATB,
Ramsay Jones

 worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index d5c71095e..ba393fe5c 100644
--- a/worktree.c
+++ b/worktree.c
@@ -168,7 +168,7 @@ static int compare_worktree(const void *a_, const void *b_)
 	return fspathcmp((*a)->path, (*b)->path);
 }
 
-struct worktree **get_worktrees_internal(const char *git_common_dir, unsigned flags)
+static struct worktree **get_worktrees_internal(const char *git_common_dir, unsigned flags)
 {
 	struct worktree **list = NULL;
 	struct strbuf path = STRBUF_INIT;
-- 
2.11.0
