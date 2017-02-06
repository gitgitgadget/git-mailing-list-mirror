Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E866E1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 13:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbdBFNOF (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 08:14:05 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:58771 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbdBFNOE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 08:14:04 -0500
Received: from localhost (x55b3a851.dyn.telefonica.de [85.179.168.81])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 393B616C833;
        Mon,  6 Feb 2017 14:14:02 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <patrick.steinhardt@elego.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, ps@pks.im
Subject: [PATCH] worktree: fix option descriptions for `prune`
Date:   Mon,  6 Feb 2017 14:13:59 +0100
Message-Id: <c2af75361b7b357fa905ab072bfdc45ad055ca49.1486386803.git.patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `verbose` and `expire` options of the `git worktree prune`
subcommand have wrong descriptions in that they pretend to relate to
objects. But as the git-worktree(1) correctly states, these options have
nothing to do with objects but only with worktrees. Fix the description
accordingly.

Signed-off-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
---
 builtin/worktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9a97e37a3..831fe058a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -125,9 +125,9 @@ static int prune(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
-		OPT__VERBOSE(&verbose, N_("report pruned objects")),
+		OPT__VERBOSE(&verbose, N_("report pruned working trees")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
-				N_("expire objects older than <time>")),
+				N_("expire working trees older than <time>")),
 		OPT_END()
 	};
 
-- 
2.11.1

