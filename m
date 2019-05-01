Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 942D41F453
	for <e@80x24.org>; Wed,  1 May 2019 13:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfEANMG (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 09:12:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39200 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfEANMG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 09:12:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so4706807pfg.6
        for <git@vger.kernel.org>; Wed, 01 May 2019 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6QQqG96I/vuxysDJ/ikR8DpfmKzcXBv+IkmOY6ylQOQ=;
        b=c1ijCDOYxk/g7XwHAXRI/x0rG1yV7JUlg0k5PoDp7JaT4uSebRyrQT9rhFr+7PFsLt
         eCrkZmJEtNqbqvDRUKgQlQYql6IUnXdelWzh1eNGP2jdrBTMg01y+gAh53fUU+nF/bN7
         FalEnHjIyGVcGuGnIwKmeLeL43gJ5Ndy9wc0GhZsVzXlGSQzgi9QfEu24HobIKHRNRpD
         SkljzqWh1vE67scRXMKbG4RQJTLFqSurJrrMVzVi2pITWN7F6BzTkMnpKoMh+ny6PEB9
         MSSy3/20xk+EybfJ2KERZTyE6qxZgsswkiNixLYVFc9CdAgzIaTSwfO4+XjepG8T9l84
         LHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6QQqG96I/vuxysDJ/ikR8DpfmKzcXBv+IkmOY6ylQOQ=;
        b=fFGEM2TnD9NLAq4/ERrWnQK8vZfml9LNUil8mlxcZJbprN0t/uKWYhvWSCceZh4WFB
         puxRl/Hy0fkkbGZrUIVNUKHYYvmTxd49kyymeTHg9NbNRjTQZZxQhFub4rlZJI8+AukA
         dOpB1k5qYny/YAXvID2MVaYTlWaXClbo3ohj599nN6AiuSK10ppG0ETbHbfaFlvj8eIS
         hJpIWhZsFdfRT2X/mPcxTwy87uqzXlPfS70kCF/oklBUEx1nSX4YpBkrUqOIAw45g6Y3
         VKLoCpe9isY8KLlElHLQ8yDewXWfjG8CnrKmVacrjuJkBljYjHBB5npqvRa5x581BUwG
         iOrQ==
X-Gm-Message-State: APjAAAXIskaphY6r35nJAOz5K3Ig75snDozL6pGPKsPW1BNLlbZ0A6yi
        som+F+oS2Oa2gh6jLBfaTRsCC9pS
X-Google-Smtp-Source: APXvYqxJ/K1Jf4+pgYEEeTYSiD/3zc+R3TDKgw9rf3kVG72hhsxgw3OI+dbNiOTHysam/T0lLuuANw==
X-Received: by 2002:a62:e201:: with SMTP id a1mr9493247pfi.67.1556716325236;
        Wed, 01 May 2019 06:12:05 -0700 (PDT)
Received: from ash ([171.226.41.84])
        by smtp.gmail.com with ESMTPSA id g3sm28709572pfm.167.2019.05.01.06.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 06:12:04 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 01 May 2019 20:12:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] merge: remove drop_save() in favor of remove_merge_branch_state()
Date:   Wed,  1 May 2019 20:11:51 +0700
Message-Id: <20190501131152.314-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1110.g9614c01b33
In-Reply-To: <20190501131152.314-1-pclouds@gmail.com>
References: <20190501131152.314-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both remove_branch_state() and drop_save() delete almost the same set of
files about the current merge state. The only difference is MERGE_RR but
it should also be cleaned up after a successful merge, which is what
drop_save() is for.

Make a new function that deletes all merge-related state files and use
it instead of drop_save(). This function will also be used in the next
patch that introduces --quit.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 branch.c        | 11 ++++++++---
 branch.h        |  6 ++++++
 builtin/merge.c | 17 +++++------------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/branch.c b/branch.c
index 28b81a7e02..1db0601a11 100644
--- a/branch.c
+++ b/branch.c
@@ -337,15 +337,20 @@ void create_branch(struct repository *r,
 	free(real_ref);
 }
 
-void remove_branch_state(struct repository *r)
+void remove_merge_branch_state(struct repository *r)
 {
-	unlink(git_path_cherry_pick_head(r));
-	unlink(git_path_revert_head(r));
 	unlink(git_path_merge_head(r));
 	unlink(git_path_merge_rr(r));
 	unlink(git_path_merge_msg(r));
 	unlink(git_path_merge_mode(r));
+}
+
+void remove_branch_state(struct repository *r)
+{
+	unlink(git_path_cherry_pick_head(r));
+	unlink(git_path_revert_head(r));
 	unlink(git_path_squash_msg(r));
+	remove_merge_branch_state(r);
 }
 
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
diff --git a/branch.h b/branch.h
index 29c1afa4d0..c90ba9d7bf 100644
--- a/branch.h
+++ b/branch.h
@@ -60,6 +60,12 @@ extern int validate_branchname(const char *name, struct strbuf *ref);
  */
 extern int validate_new_branchname(const char *name, struct strbuf *ref, int force);
 
+/*
+ * Remove information about the merge state on the current
+ * branch. (E.g., MERGE_HEAD)
+ */
+void remove_merge_branch_state(struct repository *r);
+
 /*
  * Remove information about the state of working on the current
  * branch. (E.g., MERGE_HEAD)
diff --git a/builtin/merge.c b/builtin/merge.c
index 5ce8946d39..0fd448b403 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -37,6 +37,7 @@
 #include "packfile.h"
 #include "tag.h"
 #include "alias.h"
+#include "branch.h"
 #include "commit-reach.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
@@ -282,14 +283,6 @@ static struct option builtin_merge_options[] = {
 	OPT_END()
 };
 
-/* Cleans up metadata that is uninteresting after a succeeded merge. */
-static void drop_save(void)
-{
-	unlink(git_path_merge_head(the_repository));
-	unlink(git_path_merge_msg(the_repository));
-	unlink(git_path_merge_mode(the_repository));
-}
-
 static int save_state(struct object_id *stash)
 {
 	int len;
@@ -383,7 +376,7 @@ static void finish_up_to_date(const char *msg)
 {
 	if (verbosity >= 0)
 		printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
-	drop_save();
+	remove_merge_branch_state(the_repository);
 }
 
 static void squash_message(struct commit *commit, struct commit_list *remoteheads)
@@ -861,7 +854,7 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 			&result_commit, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	finish(head, remoteheads, &result_commit, "In-index merge");
-	drop_save();
+	remove_merge_branch_state(the_repository);
 	return 0;
 }
 
@@ -888,7 +881,7 @@ static int finish_automerge(struct commit *head,
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(head, remoteheads, &result_commit, buf.buf);
 	strbuf_release(&buf);
-	drop_save();
+	remove_merge_branch_state(the_repository);
 	return 0;
 }
 
@@ -1466,7 +1459,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 
 		finish(head_commit, remoteheads, &commit->object.oid, msg.buf);
-		drop_save();
+		remove_merge_branch_state(the_repository);
 		goto done;
 	} else if (!remoteheads->next && common->next)
 		;
-- 
2.21.0.1110.g9614c01b33

