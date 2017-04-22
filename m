Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1999E207D6
	for <e@80x24.org>; Sat, 22 Apr 2017 00:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162914AbdDVAzN (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 20:55:13 -0400
Received: from avasout07.plus.net ([84.93.230.235]:38510 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162027AbdDVAzM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 20:55:12 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id BCv81v0031keHif01Cv93y; Sat, 22 Apr 2017 01:55:10 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Y8KIilWN c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=kEAT2GeZLIsztotGbiEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] worktree: fix an 'Using integer as a NULL pointer' warning
Message-ID: <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>
Date:   Sat, 22 Apr 2017 01:55:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
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

If you need to re-roll your 'nd/worktree-move' branch could you please
squash this into the relevant patch (commit 8a1dc92e91 ("worktree move:
refuse to move worktrees with submodules", 20-04-2017)).

Thanks!

ATB,
Ramsay Jones

 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index ff9ccb57f..c54abd5b8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -534,7 +534,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 
 static void validate_no_submodules(const struct worktree *wt)
 {
-	struct index_state istate = {0};
+	struct index_state istate = { NULL };
 	int i, found_submodules = 0;
 
 	if (read_index_from(&istate, worktree_git_path(wt, "index")) > 0) {
-- 
2.12.0
