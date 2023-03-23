Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE7C77B60
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjCWQrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjCWQrA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:00 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC4DB453
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:29 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 0806C241F7
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhy-AyO-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:34 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] Capitalization and punctuation fixes to some user visible messages
Date:   Thu, 23 Mar 2023 17:22:32 +0100
Message-Id: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These messages are used in multi-line context, where not sticking to
proper grammar makes things hard to read and has questionable looks.
Therefore, these changes go against the usual rules for error messages.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 builtin/pull.c | 2 +-
 sequencer.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 56f679d94a..bb2ddc93ab 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1044,7 +1044,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (!opt_autostash)
 			require_clean_work_tree(the_repository,
 				N_("pull with rebase"),
-				_("please commit or stash them."), 1, 0);
+				_("Please commit or stash them."), 1, 0);
 
 		if (get_rebase_fork_point(&rebase_fork_point, repo, *refspecs))
 			oidclr(&rebase_fork_point);
diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca2..fda68cd33d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3629,13 +3629,13 @@ static int do_exec(struct repository *r, const char *command_line)
 			  "\n"),
 			command_line,
 			dirty ? N_("and made changes to the index and/or the "
-				"working tree\n") : "");
+				"working tree.\n") : "");
 		if (status == 127)
 			/* command not found */
 			status = 1;
 	} else if (dirty) {
 		warning(_("execution succeeded: %s\nbut "
-			  "left changes to the index and/or the working tree\n"
+			  "left changes to the index and/or the working tree.\n"
 			  "Commit or stash your changes, and then run\n"
 			  "\n"
 			  "  git rebase --continue\n"
-- 
2.40.0.152.g15d061e6df

