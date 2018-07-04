Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 446F71F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 12:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934473AbeGDMZ4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 08:25:56 -0400
Received: from sym2.noone.org ([178.63.92.236]:33739 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933269AbeGDMZz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 08:25:55 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 08:25:55 EDT
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 41LKkW2cWfzvjcX; Wed,  4 Jul 2018 14:17:38 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] git-rebase--{interactive,preserve-merges}: fix formatting of todo help message
Date:   Wed,  4 Jul 2018 14:17:38 +0200
Message-Id: <1530706658-20519-1-git-send-email-tklauser@distanz.ch>
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Part of the todo help message in git-rebase--interactive.sh and
git-rebase--preserve-merges.sh is unnecessarily indented, making the
message look weird:

  # These lines can be re-ordered; they are executed from top to bottom.
  #
  # If you remove a line here THAT COMMIT WILL BE LOST.
  #
  #       However, if you remove everything, the rebase will be aborted.
  #
  #
  # Note that empty commits are commented out

Remove the extra lines and trailing indent to make it look as follows:

  # These lines can be re-ordered; they are executed from top to bottom.
  #
  # If you remove a line here THAT COMMIT WILL BE LOST.
  #
  # However, if you remove everything, the rebase will be aborted.
  #
  # Note that empty commits are commented out

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 git-rebase--interactive.sh     | 4 ++--
 git-rebase--preserve-merges.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 299ded21375e..a31af6d4c419 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -222,9 +222,9 @@ $comment_char $(eval_ngettext \
 EOF
 	append_todo_help
 	gettext "
-	However, if you remove everything, the rebase will be aborted.
+However, if you remove everything, the rebase will be aborted.
 
-	" | git stripspace --comment-lines >>"$todo"
+" | git stripspace --comment-lines >>"$todo"
 
 	if test -z "$keep_empty"
 	then
diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
index c51c7828e7b3..c214c5e4d6ce 100644
--- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--preserve-merges.sh
@@ -891,9 +891,9 @@ $comment_char $(eval_ngettext \
 EOF
 	append_todo_help
 	gettext "
-	However, if you remove everything, the rebase will be aborted.
+However, if you remove everything, the rebase will be aborted.
 
-	" | git stripspace --comment-lines >>"$todo"
+" | git stripspace --comment-lines >>"$todo"
 
 	if test -z "$keep_empty"
 	then
-- 
2.18.0.130.g98da2f6b3e4a

