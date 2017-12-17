Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 265641F404
	for <e@80x24.org>; Sun, 17 Dec 2017 22:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757587AbdLQWto (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Dec 2017 17:49:44 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33704 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbdLQWtl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Dec 2017 17:49:41 -0500
Received: by mail-wm0-f65.google.com with SMTP id g130so5276088wme.0
        for <git@vger.kernel.org>; Sun, 17 Dec 2017 14:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l1phUwiQzz1pafnDeS8FaRtqNMeBKLZcXkSY20B8grk=;
        b=nX9KT3POEiyrRI79y2n6REzZX3VocXOito7RlX68ScFCBtM/pjp7pAdkUDEe8+MVf2
         dJa/mYUtAk+7d/LEp+fyNBW/EP+oxp3FOdh0zOQe+v3pU6hiAdtDSK2edlAcvJHeSJFh
         qLrM4BW9cYyBc/0dgr1X4/287LbM2pDVQRPnNKjYhDbOlXkKjQ8vk4QsFPMuj+zkZ3Es
         /JTluhhigqlnPIhVPINF8BjqgoCvaGIMNMLwuS+TbK3h6OnaghsQEs71+gUo1gLPC9DT
         sc397+wTeSLnXC6C6sjP1u4ZVc6xYjvjJxkfzOI5cIiAcQ8iK+eUIdQsGQYlbNmfzwSx
         SyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l1phUwiQzz1pafnDeS8FaRtqNMeBKLZcXkSY20B8grk=;
        b=ZOS3tijwGgk76aCe6STCYSEvS2vDgSUDKXkOi+f+NmJ4vFXnWYjJmDbpRamYeXGks3
         LfbWO/snCy5z50FSN1oC2kntLHDOETtW5ss//FBLU9XJ8nWztachXGK7stlXfOt/oeS5
         4X2vToSLnH7Qy2eCUHo0z7APPP5wM5VH8DgXKZrUsc0Ytcb+mNIp0Est+lQHmRSd1hAC
         kJCXL0MLn/tQ6/ZkF3ROx3mkW5EQhtVIxMJzy5FCuBx9/mCygqbzYIpoAXgCrRuO4rnd
         t8RTpLKcgrwONfZUrhftFTXd8kovFSTskWFaHCLRKAtj2MstCQiq2HhFDH6LAASAv0EO
         D2pA==
X-Gm-Message-State: AKGB3mL3qCsJRoehxeKqYW2SxMo66CNTodFWANK/YfPkmGALCZYyxq/+
        aUW2OK9h0zYVFD8Agv8yEtSwT/8a
X-Google-Smtp-Source: ACJfBovVVUzkrHCmrRGwFRXcD1Y02mtYZksNnFKOWA45yCaorG52scrbafrrngNo/2Bi7xCMI676Mg==
X-Received: by 10.28.211.67 with SMTP id k64mr10239599wmg.55.1513550980545;
        Sun, 17 Dec 2017 14:49:40 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r15sm9892187wrc.36.2017.12.17.14.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Dec 2017 14:49:39 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/3] prune: fix pruning with multiple worktrees and split index
Date:   Sun, 17 Dec 2017 22:51:21 +0000
Message-Id: <20171217225122.28941-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670
In-Reply-To: <20171217225122.28941-1-t.gummerer@gmail.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171217225122.28941-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

be489d02d2 ("revision.c: --indexed-objects add objects from all
worktrees", 2017-08-23) made sure that pruning takes objects from all
worktrees into account.

It did that by reading the index of every worktree and adding the
necessary index objects to the set of pending objects.  The index is
read by read_index_from.  As mentioned in the previous commit,
read_index_from depends on the CWD for the location of the split index,
and add_index_objects_to_pending doesn't set that before using
read_index_from.

Instead of using read_index_from, use repo_read_index, which is aware of
the proper paths for the worktree.

This fixes t5304-prune when ran with GIT_TEST_SPLIT_INDEX set.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 repository.c | 11 +++++++++++
 repository.h |  2 ++
 revision.c   | 14 +++++++++-----
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/repository.c b/repository.c
index 928b1f553d..3c9bfbd1b8 100644
--- a/repository.c
+++ b/repository.c
@@ -2,6 +2,7 @@
 #include "repository.h"
 #include "config.h"
 #include "submodule-config.h"
+#include "worktree.h"
 
 /* The main repository */
 static struct repository the_repo = {
@@ -146,6 +147,16 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 	return -1;
 }
 
+/*
+ * Initialize 'repo' based on the provided worktree
+ * Return 0 upon success and a non-zero value upon failure.
+ */
+int repo_worktree_init(struct repository *repo, struct worktree *worktree)
+{
+	return repo_init(repo, get_worktree_git_dir(worktree),
+			 worktree->path);
+}
+
 /*
  * Initialize 'submodule' as the submodule given by 'path' in parent repository
  * 'superproject'.
diff --git a/repository.h b/repository.h
index 7f5e24a0a2..2adeb05bf4 100644
--- a/repository.h
+++ b/repository.h
@@ -4,6 +4,7 @@
 struct config_set;
 struct index_state;
 struct submodule_cache;
+struct worktree;
 
 struct repository {
 	/* Environment */
@@ -87,6 +88,7 @@ extern struct repository *the_repository;
 extern void repo_set_gitdir(struct repository *repo, const char *path);
 extern void repo_set_worktree(struct repository *repo, const char *path);
 extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
+extern int repo_worktree_init(struct repository *repo, struct worktree *worktree);
 extern int repo_submodule_init(struct repository *submodule,
 			       struct repository *superproject,
 			       const char *path);
diff --git a/revision.c b/revision.c
index e2e691dd5a..34e1e4b799 100644
--- a/revision.c
+++ b/revision.c
@@ -22,6 +22,7 @@
 #include "packfile.h"
 #include "worktree.h"
 #include "argv-array.h"
+#include "repository.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1346,15 +1347,18 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	worktrees = get_worktrees(0);
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
-		struct index_state istate = { NULL };
+		struct repository *repo;
 
+		repo = xmalloc(sizeof(struct repository));
 		if (wt->is_current)
 			continue; /* current index already taken care of */
+		if (repo_worktree_init(repo, wt))
+			BUG("couldn't initialize repository object from worktree");
 
-		if (read_index_from(&istate,
-				    worktree_git_path(wt, "index")) > 0)
-			do_add_index_objects_to_pending(revs, &istate);
-		discard_index(&istate);
+		if (repo_read_index(repo) > 0)
+			do_add_index_objects_to_pending(revs, repo->index);
+		discard_index(repo->index);
+		free(repo);
 	}
 	free_worktrees(worktrees);
 }
-- 
2.15.1.620.gb9897f4670

