Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B84207DF
	for <e@80x24.org>; Mon, 19 Sep 2016 13:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936372AbcISNJ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 09:09:27 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:57069 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1760574AbcISNJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 09:09:27 -0400
Received: (qmail 23396 invoked from network); 19 Sep 2016 13:09:25 -0000
Received: (qmail 32688 invoked from network); 19 Sep 2016 13:09:25 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 19 Sep 2016 13:09:20 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>
Subject: [PATCH 5/6] i18n: notes-merge: mark die messages for translation
Date:   Mon, 19 Sep 2016 13:08:20 +0000
Message-Id: <1474290501-2743-5-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
References: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update test to reflect changes.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 notes-merge.c                         | 8 ++++----
 t/t3310-notes-merge-manual-resolve.sh | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 97fc42f..3bbeb86 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -269,15 +269,15 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
 		if (file_exists(git_path(NOTES_MERGE_WORKTREE)) &&
 		    !is_empty_dir(git_path(NOTES_MERGE_WORKTREE))) {
 			if (advice_resolve_conflict)
-				die("You have not concluded your previous "
+				die(_("You have not concluded your previous "
 				    "notes merge (%s exists).\nPlease, use "
 				    "'git notes merge --commit' or 'git notes "
 				    "merge --abort' to commit/abort the "
 				    "previous merge before you start a new "
-				    "notes merge.", git_path("NOTES_MERGE_*"));
+				    "notes merge."), git_path("NOTES_MERGE_*"));
 			else
-				die("You have not concluded your notes merge "
-				    "(%s exists).", git_path("NOTES_MERGE_*"));
+				die(_("You have not concluded your notes merge "
+				    "(%s exists)."), git_path("NOTES_MERGE_*"));
 		}
 
 		if (safe_create_leading_directories_const(git_path(
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 6967436..baef2d6 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -225,7 +225,7 @@ test_expect_success 'cannot do merge w/conflicts when previous merge is unfinish
 	test -d .git/NOTES_MERGE_WORKTREE &&
 	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should indicate what is wrong
-	grep -q "\\.git/NOTES_MERGE_\\* exists" output
+	test_i18ngrep -q "\\.git/NOTES_MERGE_\\* exists" output
 '
 
 # Setup non-conflicting merge between x and new notes ref w
-- 
2.7.4

