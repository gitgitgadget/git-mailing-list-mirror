Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC9620A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbeLNVWV (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:22:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42528 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbeLNVWU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 16:22:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so3395814pfr.9
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 13:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=05texJMtO1OupiGcMjJdH/X39jUcBAzweJjdn8hsUGU=;
        b=fVgMy6rs8jBawUOIShHhvyBYzaRw+MRM0470BjOs8qQM8XiN40h5vhVVRUd44MgHLS
         nl8Z8D+92GLcvDPlyDi/DP4AQR2rj0ucq5E+5/lhDbDFSYgmlVvz3aTKvPj/mCv1H0w3
         I2LPgxeh677gsCLIGggKKJTrhRNLW3WrKTka65ScV/DPOmiSzaoP4OAr1qxuj1xKgQ8X
         zzv7PMrEz4FXU7YxoNzts+MiS6vjHd4KAr5tuU98ueUpL5kVlaqHoh+fh7sL+Lc1e8jj
         K2uFWN/p5v93CBvz5Pb8uL2h4xDMqsUOhXCYGzZ65sbSLGnGv6FRZI4+UixqXIYf9DDD
         iGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=05texJMtO1OupiGcMjJdH/X39jUcBAzweJjdn8hsUGU=;
        b=YENMoTez4d6raUayV22kgdQrC7JynBS3Ze0/qjYb9pCrnyKA8Y3Niz94/pODka/v3a
         lthARVIfhf22RJb+QGegGBveaPwu9+l8a1kNJqgxHpjjnYI4IBJHPypIRRaLOdqvvZRn
         6+wKdhFwo1Wq3UuUsPOFu8H92d2/CrTKm1PzkvohJZ/RngNwXGhPqp4c4lf25ZIQnJ/j
         R9OLjZ8UjWTmYpMxHsc8cZ4KolovEm0tai2CNS2Py6GRscocAT/OdcpMegKQe7x4aklL
         jXBZfP23uxtCioivVORSHfbpblF5l624Xfe6cbpmilm7aUDO+LO6FiOL0ZrKM4JzI3QO
         3O1w==
X-Gm-Message-State: AA+aEWZUHBXSRlu6N6Aa93L1OXdmmk3UJEiPjx/EoIpZXl+OOdT/ZKNp
        krm6A4q5bkVjU/q/A/Gqg/X1xoit
X-Google-Smtp-Source: AFSGD/UDWNYINisP/E0dWWqGO1yA3nRCQVMazu7VqyLgiJsb0QkROvJgm5F4WhgVothW500zkCtmqg==
X-Received: by 2002:a63:e247:: with SMTP id y7mr834921pgj.84.1544822538885;
        Fri, 14 Dec 2018 13:22:18 -0800 (PST)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id e86sm7790171pfb.6.2018.12.14.13.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 13:22:18 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:22:18 -0800 (PST)
X-Google-Original-Date: Fri, 14 Dec 2018 21:22:08 GMT
Message-Id: <39dc89beb91ac12c94d13f7931a4d9ebc602681f.1544822533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v4.git.gitgitgadget@gmail.com>
References: <pull.89.v3.git.gitgitgadget@gmail.com>
        <pull.89.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 2/6] list-objects: consume sparse tree walk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When creating a pack-file using 'git pack-objects --revs' we provide
a list of interesting and uninteresting commits. For example, a push
operation would make the local topic branch be interesting and the
known remote refs as uninteresting. We want to discover the set of
new objects to send to the server as a thin pack.

We walk these commits until we discover a frontier of commits such
that every commit walk starting at interesting commits ends in a root
commit or unintersting commit. We then need to discover which
non-commit objects are reachable from  uninteresting commits. This
commit walk is not changing during this series.

The mark_edges_uninteresting() method in list-objects.c iterates on
the commit list and does the following:

* If the commit is UNINTERSTING, then mark its root tree and every
  object it can reach as UNINTERESTING.

* If the commit is interesting, then mark the root tree of every
  UNINTERSTING parent (and all objects that tree can reach) as
  UNINTERSTING.

At the very end, we repeat the process on every commit directly
given to the revision walk from stdin. This helps ensure we properly
cover shallow commits that otherwise were not included in the
frontier.

The logic to recursively follow trees is in the
mark_tree_uninteresting() method in revision.c. The algorithm avoids
duplicate work by not recursing into trees that are already marked
UNINTERSTING.

Add a new 'sparse' option to the mark_edges_uninteresting() method
that performs this logic in a slightly new way. As we iterate over
the commits, we add all of the root trees to an oidset. Then, call
mark_trees_uninteresting_sparse() on that oidset. Note that we
include interesting trees in this process. The current implementation
of mark_trees_unintersting_sparse() will walk the same trees as
the old logic, but this will be replaced in a later change.

The sparse option is not used by any callers at the moment, but
will be wired to 'git pack-objects' in the next change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bisect.c               |  2 +-
 builtin/pack-objects.c |  2 +-
 builtin/rev-list.c     |  2 +-
 http-push.c            |  2 +-
 list-objects.c         | 70 +++++++++++++++++++++++++++++++++++-------
 list-objects.h         |  4 ++-
 6 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/bisect.c b/bisect.c
index 487675c672..842f8b4b8f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -656,7 +656,7 @@ static void bisect_common(struct rev_info *revs)
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 	if (revs->tree_objects)
-		mark_edges_uninteresting(revs, NULL);
+		mark_edges_uninteresting(revs, NULL, 0);
 }
 
 static void exit_if_skipped_commits(struct commit_list *tried,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 411aefd687..5f70d840a7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3135,7 +3135,7 @@ static void get_object_list(int ac, const char **av)
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
-	mark_edges_uninteresting(&revs, show_edge);
+	mark_edges_uninteresting(&revs, show_edge, 0);
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 2880ed37e3..9663cbfae0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -543,7 +543,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	if (revs.tree_objects)
-		mark_edges_uninteresting(&revs, show_edge);
+		mark_edges_uninteresting(&revs, show_edge, 0);
 
 	if (bisect_list) {
 		int reaches, all;
diff --git a/http-push.c b/http-push.c
index cd48590912..ea52d6f9f6 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1933,7 +1933,7 @@ int cmd_main(int argc, const char **argv)
 		pushing = 0;
 		if (prepare_revision_walk(&revs))
 			die("revision walk setup failed");
-		mark_edges_uninteresting(&revs, NULL);
+		mark_edges_uninteresting(&revs, NULL, 0);
 		objects_to_send = get_delta(&revs, ref_lock);
 		finish_all_active_slots();
 
diff --git a/list-objects.c b/list-objects.c
index c41cc80db5..fb728f7842 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -222,25 +222,73 @@ static void mark_edge_parents_uninteresting(struct commit *commit,
 	}
 }
 
-void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
+static void add_edge_parents(struct commit *commit,
+			     struct rev_info *revs,
+			     show_edge_fn show_edge,
+			     struct oidset *set)
+{
+	struct commit_list *parents;
+
+	for (parents = commit->parents; parents; parents = parents->next) {
+		struct commit *parent = parents->item;
+		struct tree *tree = get_commit_tree(parent);
+
+		if (!tree)
+			continue;
+
+		oidset_insert(set, &tree->object.oid);
+
+		if (!(parent->object.flags & UNINTERESTING))
+			continue;
+		tree->object.flags |= UNINTERESTING;
+
+		if (revs->edge_hint && !(parent->object.flags & SHOWN)) {
+			parent->object.flags |= SHOWN;
+			show_edge(parent);
+		}
+	}
+}
+
+void mark_edges_uninteresting(struct rev_info *revs,
+			      show_edge_fn show_edge,
+			      int sparse)
 {
 	struct commit_list *list;
 	int i;
 
-	for (list = revs->commits; list; list = list->next) {
-		struct commit *commit = list->item;
+	if (sparse) {
+		struct oidset set;
+		oidset_init(&set, 16);
 
-		if (commit->object.flags & UNINTERESTING) {
-			mark_tree_uninteresting(revs->repo,
-						get_commit_tree(commit));
-			if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
-				commit->object.flags |= SHOWN;
-				show_edge(commit);
+		for (list = revs->commits; list; list = list->next) {
+			struct commit *commit = list->item;
+			struct tree *tree = get_commit_tree(commit);
+
+			if (commit->object.flags & UNINTERESTING)
+				tree->object.flags |= UNINTERESTING;
+
+			oidset_insert(&set, &tree->object.oid);
+			add_edge_parents(commit, revs, show_edge, &set);
+		}
+
+		mark_trees_uninteresting_sparse(revs->repo, &set);
+		oidset_clear(&set);
+	} else {
+		for (list = revs->commits; list; list = list->next) {
+			struct commit *commit = list->item;
+			if (commit->object.flags & UNINTERESTING) {
+				mark_tree_uninteresting(revs->repo,
+							get_commit_tree(commit));
+				if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
+					commit->object.flags |= SHOWN;
+					show_edge(commit);
+				}
+				continue;
 			}
-			continue;
+			mark_edge_parents_uninteresting(commit, revs, show_edge);
 		}
-		mark_edge_parents_uninteresting(commit, revs, show_edge);
 	}
+
 	if (revs->edge_hint_aggressive) {
 		for (i = 0; i < revs->cmdline.nr; i++) {
 			struct object *obj = revs->cmdline.rev[i].item;
diff --git a/list-objects.h b/list-objects.h
index ad40762926..a952680e46 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -10,7 +10,9 @@ typedef void (*show_object_fn)(struct object *, const char *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
 
 typedef void (*show_edge_fn)(struct commit *);
-void mark_edges_uninteresting(struct rev_info *, show_edge_fn);
+void mark_edges_uninteresting(struct rev_info *revs,
+			      show_edge_fn show_edge,
+			      int sparse);
 
 struct oidset;
 struct list_objects_filter_options;
-- 
gitgitgadget

