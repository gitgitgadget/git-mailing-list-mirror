Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462F41F407
	for <e@80x24.org>; Sun, 10 Dec 2017 21:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbdLJVUk (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 16:20:40 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43233 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752405AbdLJVUg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 16:20:36 -0500
Received: by mail-wr0-f194.google.com with SMTP id z34so15598089wrz.10
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 13:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Y8/j9o+dN3WIu3RJJgtVZDUCCGoE60sLfZxUHTUn3c=;
        b=ZJhXzrAglbyuljovYVSQZjIiuKGlBWSNNtniz2Bj493dQ5Wp+xDehSHH6r88v+u23B
         Ld7kipy0mgz+ZnRGHDiGLDj/Uwj71rXXgIFbPI+5Qj2idiGxSHFaVxhELrHPy4FWPbu3
         GvCWijTZolUHEoEbw/vi34rZ4L8RBvU/TghDiBen5w7APxXLCuIQR1DchBzf0hrER9ip
         aDTwAJVU4WyrNHG6Wj0lOP5EZ46bRmYoKHS0O2KFKcStG2vYLlNEVOa25BmXlNcKu2oH
         +Cznf4kRjJYytKydtV7PdWkbLPidxIHupoaxEpkf6FogqIfXEKG8zCyadG/h95y5u3SL
         XMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Y8/j9o+dN3WIu3RJJgtVZDUCCGoE60sLfZxUHTUn3c=;
        b=hInpaTcPJNPMw6niIzRcHFjTlJro9YwO26g9AM6ekLyxJX4ml478xdPBL3lk6b6S8v
         XdnWBrQE/T5K0k8CGGUHHBDo+JvXOZnAndmSZbx3uP20ZYVk01VhW3iQdqC7cPnKw6iC
         P2WlmlvsFZehtcdF7FsdyVOM8cqzzRhWiG+p6nHPJTCd69edTOKfrWYlIeIVhLBjflW3
         4jQ+qpSQ9afNjg57v72IFWzJbv6lUEzwCyzHXNjqGWvvAPa4Fa81tLuiEZZBjJYB+yfI
         uXegm4aisQHx3ucoIIw7hMqzxwyKjITqLXHNsuuNFbsSfaqE2n8xxwW3ElbedtxxiXz2
         Mktg==
X-Gm-Message-State: AJaThX44/pnm9Hwl9EicY8PmmGXq/NtDRouL9zKgyQ8YLtcTAS5iROwy
        Jreqyp+oFIP8S6Hx7EIgqgmAbnX8
X-Google-Smtp-Source: AGs4zMaTuQ7Bq/FKuVzMThTv/K4QgoHX4jSVc8+DRKlu+EivwngYtIPneU8oifgGXinzKwYQ4p4Eag==
X-Received: by 10.223.175.100 with SMTP id z91mr36813498wrc.138.1512940835307;
        Sun, 10 Dec 2017 13:20:35 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id k19sm15295833wrk.88.2017.12.10.13.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Dec 2017 13:20:34 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/3] prune: fix pruning with multiple worktrees and split index
Date:   Sun, 10 Dec 2017 21:22:01 +0000
Message-Id: <20171210212202.28231-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103
In-Reply-To: <20171210212202.28231-1-t.gummerer@gmail.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
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

This also fixes t7009 when ran with GIT_TEST_SPLIT_INDEX.  I'm not
quite sure why it is fixed by this.  Either way I tracked the failure
down to f767178a5a ("Merge branch 'jk/no-null-sha1-in-cache-tree'",
2017-05-16).  Maybe Peff has an idea why this fixes that test?

 repository.c | 11 +++++++++++
 repository.h |  2 ++
 revision.c   | 13 ++++++++-----
 3 files changed, 21 insertions(+), 5 deletions(-)

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
index e2e691dd5a..9d8d9b96d1 100644
--- a/revision.c
+++ b/revision.c
@@ -22,6 +22,7 @@
 #include "packfile.h"
 #include "worktree.h"
 #include "argv-array.h"
+#include "repository.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1346,15 +1347,17 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
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
 	}
 	free_worktrees(worktrees);
 }
-- 
2.15.1.504.g5279b80103

