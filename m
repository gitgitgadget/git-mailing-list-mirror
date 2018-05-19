Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56A1E1F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750832AbeESF2i (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:28:38 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41963 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeESF2h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:37 -0400
Received: by mail-lf0-f66.google.com with SMTP id m17-v6so16869538lfj.8
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u6PHYbj0CVtLzCKN1wAhjvgFpSUd3SVNeen7jrS87C0=;
        b=faBuJVuCeGDPZJ4TI8y/HkGEv+ZWEjEzjHy8Owx1QizhZBQR/JFU5T0GBV5H9RPwzs
         T1V/wc+nkMax5FAxRvQGINDZE/Gau5N1DveWUMTrWmGbYCCHZpZisxHamX6UfS5RlON9
         +4Ulg1yOSq/yKIaM6tCRCogZrYiPbqHgtxIHg/0INFh7C9Nz7YmrilSotnVzrAXbhT/r
         1WLUTIitI3x6RQHHdYC409jW4bROsv3M4mVoAdaYQx9lZsotfIDUPaEX2o3OiTCcu7ma
         WvX8+nqA7TyYmz1oPqZv+BXn7Ex5l12t1AHrPbOIoajoTdMdS6Attn5ruIL42lT5My51
         B/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6PHYbj0CVtLzCKN1wAhjvgFpSUd3SVNeen7jrS87C0=;
        b=cnyGbXYb/VjMh/vXDzkaaax7RQMCgb6dhbW5zDSM6832O5B2FADyqH0yspZ5TKmQOb
         7WYLjiv155fSA7cOe+IprIllSbxeMMjyLkRPSjc1ujwkV1Ie5j3jUOZGax3TRfpYgpNk
         wj3rt+wK4AgpzT+tla/vQbiu9osJyXC8gDOE6Hr0YAwehLDfq1gi4F/0ivHlsEVgg8ps
         gVsPpuVzEernNc1xnTQ/ygIZVr0PBMMVQq5fuWhtbH1d65+sEEJ+yLY/iWqOoa8XZaqa
         vTC0ceO5TQpYfeF5IfFZMZ3vygc+DPKBHyT/F5BnUNbsYrpTIuF5HQtXzPSA42r4ETDK
         5M2A==
X-Gm-Message-State: ALKqPwcf6ofabZrGCU5J4pDS0zfJyAz6V0QyyoYQ+afoxpOs+XsaQljs
        XqPRvLElwPErU1bxDJDIWto=
X-Google-Smtp-Source: AB8JxZrTI0c1UQW32nXde4E7wfy8MI2+sikRo2CC349Ka/DEnHzSIcmwxJj4WMNPqXNk6MWM5lRoZA==
X-Received: by 2002:a2e:760a:: with SMTP id r10-v6mr7114673ljc.144.1526707715403;
        Fri, 18 May 2018 22:28:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 00/15] Die commit->util, die!
Date:   Sat, 19 May 2018 07:28:16 +0200
Message-Id: <20180519052831.12603-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513055208.17952-1-pclouds@gmail.com>
References: <20180513055208.17952-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 fixes Junio's comments on v2:

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b08e5ea0e3..5aaf5c8e59 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -592,7 +592,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
 			export_blob(&diff_queued_diff.queue[i]->two->oid);
 
-	refname = *revision_sources_peek(&revision_sources, commit);
+	refname = *revision_sources_at(&revision_sources, commit);
 	if (anonymize) {
 		refname = anonymize_refname(refname);
 		anonymize_ident_line(&committer, &committer_end);
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 29d15d16d2..f2e985c00a 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -22,6 +22,11 @@ static int showbranch_use_color = -1;
 
 static struct argv_array default_args = ARGV_ARRAY_INIT;
 
+/*
+ * TODO: convert this use of commit->object.flags to commit-slab
+ * instead to store a pointer to ref name directly. Then use the same
+ * UNINTERESTING definition from revision.h here.
+ */
 #define UNINTERESTING	01
 
 #define REV_SHIFT	 2
diff --git a/commit-slab-hdr.h b/commit-slab-decl.h
similarity index 100%
rename from commit-slab-hdr.h
rename to commit-slab-decl.h
diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index 19a88d7d8f..87a9cadfcc 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -87,7 +87,7 @@ struct slabname
  * to allow a terminating semicolon, which makes instantiations look
  * like function declarations.  I.e., the expansion of
  *
- *    implement_commit_slab(indegree, int);
+ *    implement_commit_slab(indegree, int, static);
  *
  * ends in 'struct indegree;'.  This would otherwise
  * be a syntax error according (at least) to ISO C.  It's hard to
diff --git a/commit-slab.h b/commit-slab.h
index dc029acc66..69bf0c807c 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -1,7 +1,7 @@
 #ifndef COMMIT_SLAB_H
 #define COMMIT_SLAB_H
 
-#include "commit-slab-hdr.h"
+#include "commit-slab-decl.h"
 #include "commit-slab-impl.h"
 
 /*
diff --git a/commit.c b/commit.c
index 8202067cd5..e63a8dfeaa 100644
--- a/commit.c
+++ b/commit.c
@@ -1575,7 +1575,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 }
 
 define_commit_slab(merge_desc_slab, struct merge_remote_desc *);
-struct merge_desc_slab merge_desc_slab = COMMIT_SLAB_INIT(1, merge_desc_slab);
+static struct merge_desc_slab merge_desc_slab = COMMIT_SLAB_INIT(1, merge_desc_slab);
 
 struct merge_remote_desc *merge_remote_util(struct commit *commit)
 {
diff --git a/commit.h b/commit.h
index 70371e111e..4432458367 100644
--- a/commit.h
+++ b/commit.h
@@ -16,6 +16,11 @@ struct commit_list {
 	struct commit_list *next;
 };
 
+/*
+ * The size of this struct matters in full repo walk operations like
+ * 'git clone' or 'git gc'. Consider using commit-slab to attach data
+ * to a commit instead of adding new fields here.
+ */
 struct commit {
 	struct object object;
 	unsigned int index;
@@ -23,11 +28,6 @@ struct commit {
 	struct commit_list *parents;
 	struct tree *tree;
 	uint32_t graph_pos;
-	/*
-	 * Do not add more fields here unless it's _very_ often
-	 * used. Use commit-slab to associate more data with a commit
-	 * instead.
-	 */
 };
 
 extern int save_commit_buffer;
diff --git a/object.h b/object.h
index b8e70e5519..caf36529f3 100644
--- a/object.h
+++ b/object.h
@@ -43,6 +43,7 @@ struct object_array {
  * builtin/index-pack.c:                                     2021
  * builtin/pack-objects.c:                                   20
  * builtin/reflog.c:                   10--12
+ * builtin/show-branch.c:    0-------------------------------------------26
  * builtin/unpack-objects.c:                                 2021
  */
 #define FLAG_BITS  27
diff --git a/revision.h b/revision.h
index f3dc5f9740..bf2239f876 100644
--- a/revision.h
+++ b/revision.h
@@ -6,7 +6,7 @@
 #include "notes.h"
 #include "pretty.h"
 #include "diff.h"
-#include "commit-slab-hdr.h"
+#include "commit-slab-decl.h"
 
 /* Remember to update object flag allocation in object.h */
 #define SEEN		(1u<<0)
diff --git a/sequencer.c b/sequencer.c
index dd4993fd99..3b6d56d085 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3161,7 +3161,7 @@ static enum check_level get_missing_commit_check_level(void)
 	return CHECK_IGNORE;
 }
 
-define_commit_slab(commit_seen, uint8_t);
+define_commit_slab(commit_seen, unsigned char);
 /*
  * Check if the user dropped some commits by mistake
  * Behaviour determined by rebase.missingCommitsCheck.
diff --git a/shallow.c b/shallow.c
index daf60a9391..0301049781 100644
--- a/shallow.c
+++ b/shallow.c
@@ -110,7 +110,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 			} else {
 				commit = (struct commit *)
 					object_array_pop(&stack);
-				cur_depth = **commit_depth_peek(&depths, commit);
+				cur_depth = **commit_depth_at(&depths, commit);
 			}
 		}
 		parse_commit_or_die(commit);
@@ -140,8 +140,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 						NULL, &stack);
 			else {
 				commit = p->item;
-				depth_slot = commit_depth_peek(&depths, commit);
-				cur_depth = **depth_slot;
+				cur_depth = **commit_depth_at(&depths, commit);
 			}
 		}
 	}


Nguyễn Thái Ngọc Duy (15):
  commit-slab.h: code split
  commit-slab: support shared commit-slab
  blame: use commit-slab for blame suspects instead of commit->util
  describe: use commit-slab for commit names instead of commit->util
  shallow.c: use commit-slab for commit depth instead of commit->util
  sequencer.c: use commit-slab to mark seen commits
  sequencer.c: use commit-slab to associate todo items to commits
  revision.c: use commit-slab for show_source
  bisect.c: use commit-slab for commit weight instead of commit->util
  name-rev: use commit-slab for rev-name instead of commit->util
  show-branch: use commit-slab for commit-name instead of commit->util
  show-branch: note about its object flags usage
  log: use commit-slab in prepare_bases() instead of commit->util
  merge: use commit-slab in merge remote desc instead of commit->util
  commit.h: delete 'util' field in struct commit

 bisect.c              |  12 +++--
 blame.c               |  42 +++++++++++----
 blame.h               |   2 +
 builtin/blame.c       |   2 +-
 builtin/describe.c    |  16 ++++--
 builtin/fast-export.c |  14 +++--
 builtin/log.c         |  17 +++++--
 builtin/merge.c       |  25 ++++-----
 builtin/name-rev.c    |  23 +++++++--
 builtin/show-branch.c |  44 +++++++++++-----
 commit-slab-decl.h    |  43 ++++++++++++++++
 commit-slab-impl.h    |  97 +++++++++++++++++++++++++++++++++++
 commit-slab.h         | 115 +++---------------------------------------
 commit.c              |  12 ++++-
 commit.h              |   8 ++-
 log-tree.c            |   8 ++-
 merge-recursive.c     |   8 +--
 object.h              |   1 +
 revision.c            |  19 +++++--
 revision.h            |   5 +-
 sequencer.c           |  24 ++++++---
 shallow.c             |  40 ++++++++++-----
 22 files changed, 382 insertions(+), 195 deletions(-)
 create mode 100644 commit-slab-decl.h
 create mode 100644 commit-slab-impl.h

-- 
2.17.0.705.g3525833791

