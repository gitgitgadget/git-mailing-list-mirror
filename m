Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB6A1F829
	for <e@80x24.org>; Wed,  3 May 2017 16:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbdECQaS (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 12:30:18 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:42806 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753544AbdECQaP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 12:30:15 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 41C822003F5;
        Wed,  3 May 2017 18:30:12 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH 2/4] usability: fix am and checkout for nevermind questions
Date:   Wed,  3 May 2017 18:29:29 +0200
Message-Id: <20170503162931.30721-2-jn.avila@free.fr>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170503162931.30721-1-jn.avila@free.fr>
References: <20170503162931.30721-1-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 builtin/am.c       | 4 ++--
 builtin/checkout.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index a95dd8b4e..f5afa438d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1312,7 +1312,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	}
 
 	if (is_empty_file(am_path(state, "patch"))) {
-		printf_ln(_("Patch is empty. Was it split wrong?"));
+		printf_ln(_("Patch is empty. It may have been split wrong."));
 		die_user_resolve(state);
 	}
 
@@ -1940,7 +1940,7 @@ static void am_resolve(struct am_state *state)
 
 	if (unmerged_cache()) {
 		printf_ln(_("You still have unmerged paths in your index.\n"
-			"Did you forget to use 'git add'?"));
+			"You might want to use 'git add' on them."));
 		die_user_resolve(state);
 	}
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f3..05037b9b6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1287,7 +1287,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		 */
 		if (opts.new_branch && argc == 1)
 			die(_("Cannot update paths and switch to branch '%s' at the same time.\n"
-			      "Did you intend to checkout '%s' which can not be resolved as commit?"),
+			      "'%s' can not be resolved as commit, but it should."),
 			    opts.new_branch, argv[0]);
 
 		if (opts.force_detach)
-- 
2.12.0

