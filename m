Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66352C433FE
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 19:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiBYTbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 14:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiBYTbb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 14:31:31 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827501EE9E9
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:30:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so2336589wme.0
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=KpOjNOAFZg7ax3GBpPfoZjk+pxLki7xXiG3ZQ4bgPKM=;
        b=cK831KvREt1hvEJBq9AJEHnfvwWFc3evw3Dd3DN+raKp1N79c5fZDev9p7K0atbBvP
         idrG1A7NHgho4uPh8D9gMDXhvDCFV04uz2st3niyprS45W/6ZlyRAipT3gLB2zRBr9x0
         j+LBalKMpsmt/JZ1CyiApjICT+HDFbODt9fuR4+PXGpV7SuBzaK3n76uJhvTFc/w4fLf
         awdwcbyTbtGghm7xxGOY0HZ5RIvR7xgwRPs0Y/uGW5Hcws3OPLsC5ml6NjFjpTy+3OGp
         oAxo0dAdkbPNlRxAYUiaUrFtfvscAK+412VJTUFj41zPMcR9n4XNDaLSWRiAjCe36OCB
         lfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=KpOjNOAFZg7ax3GBpPfoZjk+pxLki7xXiG3ZQ4bgPKM=;
        b=UQdqKDdnI60Y3rbIR7fPyrRj5CrtoAmpatJ4CGHgnFOPPsS+XGXyQRW1ErDJSoFDye
         OTIeoVNRbuwNG08h94aDgqIPDJKr7KWOQ04vHWmglzSQdoJvrV3EqEfoTVPFed6jzEws
         xxzuQB13zoaM24j+rsM2NQTYCnT045q4Cewk/dOCdoUno8PAfgiXj8pT8JXP98EmNdSh
         9oVkOgb6TKfxaaRlkDsMYIUOrgHkGGtO5gwrf1qs5GxGpd8mhBEBV4a/HFXfFTb8nC+s
         ygQcrSVGEvyuKYaVHkwWBjkM+/luysu7ujdbphcquvtwxqS6PRaxpptXFpcIz9CaTrM7
         pRdw==
X-Gm-Message-State: AOAM532qOTw+k27isrfzzwKPCLzqHdRFhSsKwhFVtnzvwUmOr/7NbhsK
        5/uzb+g7gr/wNLJScVKr330seA+LG3Y=
X-Google-Smtp-Source: ABdhPJwnDHdjccH8Nyz+spi4nKs+MduWiLihdnvyngbXD9BGFwZ4DnJcBSSAcn2O3JQSdgvN/u1kxg==
X-Received: by 2002:a05:600c:34c6:b0:380:cfca:e338 with SMTP id d6-20020a05600c34c600b00380cfcae338mr4031527wmq.187.1645817455473;
        Fri, 25 Feb 2022 11:30:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m62-20020a1c2641000000b00380d0cff5f3sm6977263wmm.8.2022.02.25.11.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:30:55 -0800 (PST)
Message-Id: <33adfee4ca6af1dd5ae396b8ba2ad46bbdafa865.1645817452.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
References: <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
        <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 19:30:51 +0000
Subject: [PATCH v3 2/3] reflog: libify delete reflog function and helpers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Currently stash shells out to reflog in order to delete refs. In an
effort to reduce how much we shell out to a subprocess, libify the
functionality that stash needs into reflog.c.

Add a reflog_delete function that is pretty much the logic in the while
loop in builtin/reflog.c cmd_reflog_delete(). This is a function that
builtin/reflog.c and builtin/stash.c can both call.

Also move functions needed by reflog_delete and export them.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 Makefile         |   1 +
 builtin/reflog.c | 455 +----------------------------------------------
 object.h         |   2 +-
 reflog.c         | 432 ++++++++++++++++++++++++++++++++++++++++++++
 reflog.h         |  43 +++++
 5 files changed, 481 insertions(+), 452 deletions(-)
 create mode 100644 reflog.c
 create mode 100644 reflog.h

diff --git a/Makefile b/Makefile
index 6f0b4b775fe..876d4dfd6cb 100644
--- a/Makefile
+++ b/Makefile
@@ -989,6 +989,7 @@ LIB_OBJS += rebase-interactive.o
 LIB_OBJS += rebase.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += reflog-walk.o
+LIB_OBJS += reflog.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/debug.o
 LIB_OBJS += refs/files-backend.o
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 85b838720c3..940db196f62 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,16 +1,9 @@
 #include "builtin.h"
 #include "config.h"
-#include "lockfile.h"
-#include "object-store.h"
-#include "repository.h"
-#include "commit.h"
-#include "refs.h"
-#include "dir.h"
-#include "tree-walk.h"
-#include "diff.h"
 #include "revision.h"
 #include "reachable.h"
 #include "worktree.h"
+#include "reflog.h"
 
 static const char reflog_exists_usage[] =
 N_("git reflog exists <ref>");
@@ -18,404 +11,11 @@ N_("git reflog exists <ref>");
 static timestamp_t default_reflog_expire;
 static timestamp_t default_reflog_expire_unreachable;
 
-struct cmd_reflog_expire_cb {
-	int stalefix;
-	int explicit_expiry;
-	timestamp_t expire_total;
-	timestamp_t expire_unreachable;
-	int recno;
-};
-
-struct expire_reflog_policy_cb {
-	enum {
-		UE_NORMAL,
-		UE_ALWAYS,
-		UE_HEAD
-	} unreachable_expire_kind;
-	struct commit_list *mark_list;
-	unsigned long mark_limit;
-	struct cmd_reflog_expire_cb cmd;
-	struct commit *tip_commit;
-	struct commit_list *tips;
-	unsigned int dry_run:1;
-};
-
 struct worktree_reflogs {
 	struct worktree *worktree;
 	struct string_list reflogs;
 };
 
-/* Remember to update object flag allocation in object.h */
-#define INCOMPLETE	(1u<<10)
-#define STUDYING	(1u<<11)
-#define REACHABLE	(1u<<12)
-
-static int tree_is_complete(const struct object_id *oid)
-{
-	struct tree_desc desc;
-	struct name_entry entry;
-	int complete;
-	struct tree *tree;
-
-	tree = lookup_tree(the_repository, oid);
-	if (!tree)
-		return 0;
-	if (tree->object.flags & SEEN)
-		return 1;
-	if (tree->object.flags & INCOMPLETE)
-		return 0;
-
-	if (!tree->buffer) {
-		enum object_type type;
-		unsigned long size;
-		void *data = read_object_file(oid, &type, &size);
-		if (!data) {
-			tree->object.flags |= INCOMPLETE;
-			return 0;
-		}
-		tree->buffer = data;
-		tree->size = size;
-	}
-	init_tree_desc(&desc, tree->buffer, tree->size);
-	complete = 1;
-	while (tree_entry(&desc, &entry)) {
-		if (!has_object_file(&entry.oid) ||
-		    (S_ISDIR(entry.mode) && !tree_is_complete(&entry.oid))) {
-			tree->object.flags |= INCOMPLETE;
-			complete = 0;
-		}
-	}
-	free_tree_buffer(tree);
-
-	if (complete)
-		tree->object.flags |= SEEN;
-	return complete;
-}
-
-static int commit_is_complete(struct commit *commit)
-{
-	struct object_array study;
-	struct object_array found;
-	int is_incomplete = 0;
-	int i;
-
-	/* early return */
-	if (commit->object.flags & SEEN)
-		return 1;
-	if (commit->object.flags & INCOMPLETE)
-		return 0;
-	/*
-	 * Find all commits that are reachable and are not marked as
-	 * SEEN.  Then make sure the trees and blobs contained are
-	 * complete.  After that, mark these commits also as SEEN.
-	 * If some of the objects that are needed to complete this
-	 * commit are missing, mark this commit as INCOMPLETE.
-	 */
-	memset(&study, 0, sizeof(study));
-	memset(&found, 0, sizeof(found));
-	add_object_array(&commit->object, NULL, &study);
-	add_object_array(&commit->object, NULL, &found);
-	commit->object.flags |= STUDYING;
-	while (study.nr) {
-		struct commit *c;
-		struct commit_list *parent;
-
-		c = (struct commit *)object_array_pop(&study);
-		if (!c->object.parsed && !parse_object(the_repository, &c->object.oid))
-			c->object.flags |= INCOMPLETE;
-
-		if (c->object.flags & INCOMPLETE) {
-			is_incomplete = 1;
-			break;
-		}
-		else if (c->object.flags & SEEN)
-			continue;
-		for (parent = c->parents; parent; parent = parent->next) {
-			struct commit *p = parent->item;
-			if (p->object.flags & STUDYING)
-				continue;
-			p->object.flags |= STUDYING;
-			add_object_array(&p->object, NULL, &study);
-			add_object_array(&p->object, NULL, &found);
-		}
-	}
-	if (!is_incomplete) {
-		/*
-		 * make sure all commits in "found" array have all the
-		 * necessary objects.
-		 */
-		for (i = 0; i < found.nr; i++) {
-			struct commit *c =
-				(struct commit *)found.objects[i].item;
-			if (!tree_is_complete(get_commit_tree_oid(c))) {
-				is_incomplete = 1;
-				c->object.flags |= INCOMPLETE;
-			}
-		}
-		if (!is_incomplete) {
-			/* mark all found commits as complete, iow SEEN */
-			for (i = 0; i < found.nr; i++)
-				found.objects[i].item->flags |= SEEN;
-		}
-	}
-	/* clear flags from the objects we traversed */
-	for (i = 0; i < found.nr; i++)
-		found.objects[i].item->flags &= ~STUDYING;
-	if (is_incomplete)
-		commit->object.flags |= INCOMPLETE;
-	else {
-		/*
-		 * If we come here, we have (1) traversed the ancestry chain
-		 * from the "commit" until we reach SEEN commits (which are
-		 * known to be complete), and (2) made sure that the commits
-		 * encountered during the above traversal refer to trees that
-		 * are complete.  Which means that we know *all* the commits
-		 * we have seen during this process are complete.
-		 */
-		for (i = 0; i < found.nr; i++)
-			found.objects[i].item->flags |= SEEN;
-	}
-	/* free object arrays */
-	object_array_clear(&study);
-	object_array_clear(&found);
-	return !is_incomplete;
-}
-
-static int keep_entry(struct commit **it, struct object_id *oid)
-{
-	struct commit *commit;
-
-	if (is_null_oid(oid))
-		return 1;
-	commit = lookup_commit_reference_gently(the_repository, oid, 1);
-	if (!commit)
-		return 0;
-
-	/*
-	 * Make sure everything in this commit exists.
-	 *
-	 * We have walked all the objects reachable from the refs
-	 * and cache earlier.  The commits reachable by this commit
-	 * must meet SEEN commits -- and then we should mark them as
-	 * SEEN as well.
-	 */
-	if (!commit_is_complete(commit))
-		return 0;
-	*it = commit;
-	return 1;
-}
-
-/*
- * Starting from commits in the cb->mark_list, mark commits that are
- * reachable from them.  Stop the traversal at commits older than
- * the expire_limit and queue them back, so that the caller can call
- * us again to restart the traversal with longer expire_limit.
- */
-static void mark_reachable(struct expire_reflog_policy_cb *cb)
-{
-	struct commit_list *pending;
-	timestamp_t expire_limit = cb->mark_limit;
-	struct commit_list *leftover = NULL;
-
-	for (pending = cb->mark_list; pending; pending = pending->next)
-		pending->item->object.flags &= ~REACHABLE;
-
-	pending = cb->mark_list;
-	while (pending) {
-		struct commit_list *parent;
-		struct commit *commit = pop_commit(&pending);
-		if (commit->object.flags & REACHABLE)
-			continue;
-		if (parse_commit(commit))
-			continue;
-		commit->object.flags |= REACHABLE;
-		if (commit->date < expire_limit) {
-			commit_list_insert(commit, &leftover);
-			continue;
-		}
-		commit->object.flags |= REACHABLE;
-		parent = commit->parents;
-		while (parent) {
-			commit = parent->item;
-			parent = parent->next;
-			if (commit->object.flags & REACHABLE)
-				continue;
-			commit_list_insert(commit, &pending);
-		}
-	}
-	cb->mark_list = leftover;
-}
-
-static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, struct object_id *oid)
-{
-	/*
-	 * We may or may not have the commit yet - if not, look it
-	 * up using the supplied sha1.
-	 */
-	if (!commit) {
-		if (is_null_oid(oid))
-			return 0;
-
-		commit = lookup_commit_reference_gently(the_repository, oid,
-							1);
-
-		/* Not a commit -- keep it */
-		if (!commit)
-			return 0;
-	}
-
-	/* Reachable from the current ref?  Don't prune. */
-	if (commit->object.flags & REACHABLE)
-		return 0;
-
-	if (cb->mark_list && cb->mark_limit) {
-		cb->mark_limit = 0; /* dig down to the root */
-		mark_reachable(cb);
-	}
-
-	return !(commit->object.flags & REACHABLE);
-}
-
-/*
- * Return true iff the specified reflog entry should be expired.
- */
-static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
-				    const char *email, timestamp_t timestamp, int tz,
-				    const char *message, void *cb_data)
-{
-	struct expire_reflog_policy_cb *cb = cb_data;
-	struct commit *old_commit, *new_commit;
-
-	if (timestamp < cb->cmd.expire_total)
-		return 1;
-
-	old_commit = new_commit = NULL;
-	if (cb->cmd.stalefix &&
-	    (!keep_entry(&old_commit, ooid) || !keep_entry(&new_commit, noid)))
-		return 1;
-
-	if (timestamp < cb->cmd.expire_unreachable) {
-		switch (cb->unreachable_expire_kind) {
-		case UE_ALWAYS:
-			return 1;
-		case UE_NORMAL:
-		case UE_HEAD:
-			if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
-				return 1;
-			break;
-		}
-	}
-
-	if (cb->cmd.recno && --(cb->cmd.recno) == 0)
-		return 1;
-
-	return 0;
-}
-
-static int should_expire_reflog_ent_verbose(struct object_id *ooid,
-					    struct object_id *noid,
-					    const char *email,
-					    timestamp_t timestamp, int tz,
-					    const char *message, void *cb_data)
-{
-	struct expire_reflog_policy_cb *cb = cb_data;
-	int expire;
-
-	expire = should_expire_reflog_ent(ooid, noid, email, timestamp, tz,
-					  message, cb);
-
-	if (!expire)
-		printf("keep %s", message);
-	else if (cb->dry_run)
-		printf("would prune %s", message);
-	else
-		printf("prune %s", message);
-
-	return expire;
-}
-
-static int push_tip_to_list(const char *refname, const struct object_id *oid,
-			    int flags, void *cb_data)
-{
-	struct commit_list **list = cb_data;
-	struct commit *tip_commit;
-	if (flags & REF_ISSYMREF)
-		return 0;
-	tip_commit = lookup_commit_reference_gently(the_repository, oid, 1);
-	if (!tip_commit)
-		return 0;
-	commit_list_insert(tip_commit, list);
-	return 0;
-}
-
-static int is_head(const char *refname)
-{
-	switch (ref_type(refname)) {
-	case REF_TYPE_OTHER_PSEUDOREF:
-	case REF_TYPE_MAIN_PSEUDOREF:
-		if (parse_worktree_ref(refname, NULL, NULL, &refname))
-			BUG("not a worktree ref: %s", refname);
-		break;
-	default:
-		break;
-	}
-	return !strcmp(refname, "HEAD");
-}
-
-static void reflog_expiry_prepare(const char *refname,
-				  const struct object_id *oid,
-				  void *cb_data)
-{
-	struct expire_reflog_policy_cb *cb = cb_data;
-	struct commit_list *elem;
-	struct commit *commit = NULL;
-
-	if (!cb->cmd.expire_unreachable || is_head(refname)) {
-		cb->unreachable_expire_kind = UE_HEAD;
-	} else {
-		commit = lookup_commit(the_repository, oid);
-		cb->unreachable_expire_kind = commit ? UE_NORMAL : UE_ALWAYS;
-	}
-
-	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
-		cb->unreachable_expire_kind = UE_ALWAYS;
-
-	switch (cb->unreachable_expire_kind) {
-	case UE_ALWAYS:
-		return;
-	case UE_HEAD:
-		for_each_ref(push_tip_to_list, &cb->tips);
-		for (elem = cb->tips; elem; elem = elem->next)
-			commit_list_insert(elem->item, &cb->mark_list);
-		break;
-	case UE_NORMAL:
-		commit_list_insert(commit, &cb->mark_list);
-		/* For reflog_expiry_cleanup() below */
-		cb->tip_commit = commit;
-	}
-	cb->mark_limit = cb->cmd.expire_total;
-	mark_reachable(cb);
-}
-
-static void reflog_expiry_cleanup(void *cb_data)
-{
-	struct expire_reflog_policy_cb *cb = cb_data;
-	struct commit_list *elem;
-
-	switch (cb->unreachable_expire_kind) {
-	case UE_ALWAYS:
-		return;
-	case UE_HEAD:
-		for (elem = cb->tips; elem; elem = elem->next)
-			clear_commit_marks(elem->item, REACHABLE);
-		free_commit_list(cb->tips);
-		break;
-	case UE_NORMAL:
-		clear_commit_marks(cb->tip_commit, REACHABLE);
-		break;
-	}
-}
-
 static int collect_reflog(const char *ref, const struct object_id *oid, int unused, void *cb_data)
 {
 	struct worktree_reflogs *cb = cb_data;
@@ -704,16 +304,6 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
-static int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, timestamp_t timestamp, int tz,
-		const char *message, void *cb_data)
-{
-	struct cmd_reflog_expire_cb *cb = cb_data;
-	if (!cb->expire_total || timestamp < cb->expire_total)
-		cb->recno++;
-	return 0;
-}
-
 static const char * reflog_delete_usage[] = {
 	N_("git reflog delete [--rewrite] [--updateref] "
 	   "[--dry-run | -n] [--verbose] <refs>..."),
@@ -722,11 +312,10 @@ static const char * reflog_delete_usage[] = {
 
 static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 {
-	struct cmd_reflog_expire_cb cmd = { 0 };
 	int i, status = 0;
 	unsigned int flags = 0;
 	int verbose = 0;
-	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
+
 	const struct option options[] = {
 		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
 			EXPIRE_REFLOGS_DRY_RUN),
@@ -742,48 +331,12 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, reflog_delete_usage, 0);
 
-	if (verbose)
-		should_prune_fn = should_expire_reflog_ent_verbose;
-
 	if (argc < 1)
 		return error(_("no reflog specified to delete"));
 
-	for (i = 0; i < argc; i++) {
-		const char *spec = strstr(argv[i], "@{");
-		char *ep, *ref;
-		int recno;
-		struct expire_reflog_policy_cb cb = {
-			.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
-		};
-
-		if (!spec) {
-			status |= error(_("not a reflog: %s"), argv[i]);
-			continue;
-		}
+	for (i = 0; i < argc; i++)
+		status |= reflog_delete(argv[i], flags, verbose);
 
-		if (!dwim_log(argv[i], spec - argv[i], NULL, &ref)) {
-			status |= error(_("no reflog for '%s'"), argv[i]);
-			continue;
-		}
-
-		recno = strtoul(spec + 2, &ep, 10);
-		if (*ep == '}') {
-			cmd.recno = -recno;
-			for_each_reflog_ent(ref, count_reflog_ent, &cmd);
-		} else {
-			cmd.expire_total = approxidate(spec + 2);
-			for_each_reflog_ent(ref, count_reflog_ent, &cmd);
-			cmd.expire_total = 0;
-		}
-
-		cb.cmd = cmd;
-		status |= reflog_expire(ref, flags,
-					reflog_expiry_prepare,
-					should_prune_fn,
-					reflog_expiry_cleanup,
-					&cb);
-		free(ref);
-	}
 	return status;
 }
 
diff --git a/object.h b/object.h
index cb556ab7753..a2219464c2b 100644
--- a/object.h
+++ b/object.h
@@ -75,7 +75,7 @@ struct object_array {
  * builtin/fsck.c:           0--3
  * builtin/gc.c:             0
  * builtin/index-pack.c:                                     2021
- * builtin/reflog.c:                   10--12
+ * reflog.c:                           10--12
  * builtin/show-branch.c:    0-------------------------------------------26
  * builtin/unpack-objects.c:                                 2021
  */
diff --git a/reflog.c b/reflog.c
new file mode 100644
index 00000000000..333fd8708fe
--- /dev/null
+++ b/reflog.c
@@ -0,0 +1,432 @@
+#include "cache.h"
+#include "object-store.h"
+#include "reflog.h"
+#include "refs.h"
+#include "revision.h"
+#include "worktree.h"
+
+/* Remember to update object flag allocation in object.h */
+#define INCOMPLETE	(1u<<10)
+#define STUDYING	(1u<<11)
+#define REACHABLE	(1u<<12)
+
+static int tree_is_complete(const struct object_id *oid)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	int complete;
+	struct tree *tree;
+
+	tree = lookup_tree(the_repository, oid);
+	if (!tree)
+		return 0;
+	if (tree->object.flags & SEEN)
+		return 1;
+	if (tree->object.flags & INCOMPLETE)
+		return 0;
+
+	if (!tree->buffer) {
+		enum object_type type;
+		unsigned long size;
+		void *data = read_object_file(oid, &type, &size);
+		if (!data) {
+			tree->object.flags |= INCOMPLETE;
+			return 0;
+		}
+		tree->buffer = data;
+		tree->size = size;
+	}
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	complete = 1;
+	while (tree_entry(&desc, &entry)) {
+		if (!has_object_file(&entry.oid) ||
+		    (S_ISDIR(entry.mode) && !tree_is_complete(&entry.oid))) {
+			tree->object.flags |= INCOMPLETE;
+			complete = 0;
+		}
+	}
+	free_tree_buffer(tree);
+
+	if (complete)
+		tree->object.flags |= SEEN;
+	return complete;
+}
+
+static int commit_is_complete(struct commit *commit)
+{
+	struct object_array study;
+	struct object_array found;
+	int is_incomplete = 0;
+	int i;
+
+	/* early return */
+	if (commit->object.flags & SEEN)
+		return 1;
+	if (commit->object.flags & INCOMPLETE)
+		return 0;
+	/*
+	 * Find all commits that are reachable and are not marked as
+	 * SEEN.  Then make sure the trees and blobs contained are
+	 * complete.  After that, mark these commits also as SEEN.
+	 * If some of the objects that are needed to complete this
+	 * commit are missing, mark this commit as INCOMPLETE.
+	 */
+	memset(&study, 0, sizeof(study));
+	memset(&found, 0, sizeof(found));
+	add_object_array(&commit->object, NULL, &study);
+	add_object_array(&commit->object, NULL, &found);
+	commit->object.flags |= STUDYING;
+	while (study.nr) {
+		struct commit *c;
+		struct commit_list *parent;
+
+		c = (struct commit *)object_array_pop(&study);
+		if (!c->object.parsed && !parse_object(the_repository, &c->object.oid))
+			c->object.flags |= INCOMPLETE;
+
+		if (c->object.flags & INCOMPLETE) {
+			is_incomplete = 1;
+			break;
+		}
+		else if (c->object.flags & SEEN)
+			continue;
+		for (parent = c->parents; parent; parent = parent->next) {
+			struct commit *p = parent->item;
+			if (p->object.flags & STUDYING)
+				continue;
+			p->object.flags |= STUDYING;
+			add_object_array(&p->object, NULL, &study);
+			add_object_array(&p->object, NULL, &found);
+		}
+	}
+	if (!is_incomplete) {
+		/*
+		 * make sure all commits in "found" array have all the
+		 * necessary objects.
+		 */
+		for (i = 0; i < found.nr; i++) {
+			struct commit *c =
+				(struct commit *)found.objects[i].item;
+			if (!tree_is_complete(get_commit_tree_oid(c))) {
+				is_incomplete = 1;
+				c->object.flags |= INCOMPLETE;
+			}
+		}
+		if (!is_incomplete) {
+			/* mark all found commits as complete, iow SEEN */
+			for (i = 0; i < found.nr; i++)
+				found.objects[i].item->flags |= SEEN;
+		}
+	}
+	/* clear flags from the objects we traversed */
+	for (i = 0; i < found.nr; i++)
+		found.objects[i].item->flags &= ~STUDYING;
+	if (is_incomplete)
+		commit->object.flags |= INCOMPLETE;
+	else {
+		/*
+		 * If we come here, we have (1) traversed the ancestry chain
+		 * from the "commit" until we reach SEEN commits (which are
+		 * known to be complete), and (2) made sure that the commits
+		 * encountered during the above traversal refer to trees that
+		 * are complete.  Which means that we know *all* the commits
+		 * we have seen during this process are complete.
+		 */
+		for (i = 0; i < found.nr; i++)
+			found.objects[i].item->flags |= SEEN;
+	}
+	/* free object arrays */
+	object_array_clear(&study);
+	object_array_clear(&found);
+	return !is_incomplete;
+}
+
+static int keep_entry(struct commit **it, struct object_id *oid)
+{
+	struct commit *commit;
+
+	if (is_null_oid(oid))
+		return 1;
+	commit = lookup_commit_reference_gently(the_repository, oid, 1);
+	if (!commit)
+		return 0;
+
+	/*
+	 * Make sure everything in this commit exists.
+	 *
+	 * We have walked all the objects reachable from the refs
+	 * and cache earlier.  The commits reachable by this commit
+	 * must meet SEEN commits -- and then we should mark them as
+	 * SEEN as well.
+	 */
+	if (!commit_is_complete(commit))
+		return 0;
+	*it = commit;
+	return 1;
+}
+
+/*
+ * Starting from commits in the cb->mark_list, mark commits that are
+ * reachable from them.  Stop the traversal at commits older than
+ * the expire_limit and queue them back, so that the caller can call
+ * us again to restart the traversal with longer expire_limit.
+ */
+static void mark_reachable(struct expire_reflog_policy_cb *cb)
+{
+	struct commit_list *pending;
+	timestamp_t expire_limit = cb->mark_limit;
+	struct commit_list *leftover = NULL;
+
+	for (pending = cb->mark_list; pending; pending = pending->next)
+		pending->item->object.flags &= ~REACHABLE;
+
+	pending = cb->mark_list;
+	while (pending) {
+		struct commit_list *parent;
+		struct commit *commit = pop_commit(&pending);
+		if (commit->object.flags & REACHABLE)
+			continue;
+		if (parse_commit(commit))
+			continue;
+		commit->object.flags |= REACHABLE;
+		if (commit->date < expire_limit) {
+			commit_list_insert(commit, &leftover);
+			continue;
+		}
+		commit->object.flags |= REACHABLE;
+		parent = commit->parents;
+		while (parent) {
+			commit = parent->item;
+			parent = parent->next;
+			if (commit->object.flags & REACHABLE)
+				continue;
+			commit_list_insert(commit, &pending);
+		}
+	}
+	cb->mark_list = leftover;
+}
+
+static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, struct object_id *oid)
+{
+	/*
+	 * We may or may not have the commit yet - if not, look it
+	 * up using the supplied sha1.
+	 */
+	if (!commit) {
+		if (is_null_oid(oid))
+			return 0;
+
+		commit = lookup_commit_reference_gently(the_repository, oid,
+							1);
+
+		/* Not a commit -- keep it */
+		if (!commit)
+			return 0;
+	}
+
+	/* Reachable from the current ref?  Don't prune. */
+	if (commit->object.flags & REACHABLE)
+		return 0;
+
+	if (cb->mark_list && cb->mark_limit) {
+		cb->mark_limit = 0; /* dig down to the root */
+		mark_reachable(cb);
+	}
+
+	return !(commit->object.flags & REACHABLE);
+}
+
+/*
+ * Return true iff the specified reflog entry should be expired.
+ */
+int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
+				    const char *email, timestamp_t timestamp, int tz,
+				    const char *message, void *cb_data)
+{
+	struct expire_reflog_policy_cb *cb = cb_data;
+	struct commit *old_commit, *new_commit;
+
+	if (timestamp < cb->cmd.expire_total)
+		return 1;
+
+	old_commit = new_commit = NULL;
+	if (cb->cmd.stalefix &&
+	    (!keep_entry(&old_commit, ooid) || !keep_entry(&new_commit, noid)))
+		return 1;
+
+	if (timestamp < cb->cmd.expire_unreachable) {
+		switch (cb->unreachable_expire_kind) {
+		case UE_ALWAYS:
+			return 1;
+		case UE_NORMAL:
+		case UE_HEAD:
+			if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
+				return 1;
+			break;
+		}
+	}
+
+	if (cb->cmd.recno && --(cb->cmd.recno) == 0)
+		return 1;
+
+	return 0;
+}
+
+int should_expire_reflog_ent_verbose(struct object_id *ooid,
+					    struct object_id *noid,
+					    const char *email,
+					    timestamp_t timestamp, int tz,
+					    const char *message, void *cb_data)
+{
+	struct expire_reflog_policy_cb *cb = cb_data;
+	int expire;
+
+	expire = should_expire_reflog_ent(ooid, noid, email, timestamp, tz,
+					  message, cb);
+
+	if (!expire)
+		printf("keep %s", message);
+	else if (cb->dry_run)
+		printf("would prune %s", message);
+	else
+		printf("prune %s", message);
+
+	return expire;
+}
+
+static int push_tip_to_list(const char *refname, const struct object_id *oid,
+			    int flags, void *cb_data)
+{
+	struct commit_list **list = cb_data;
+	struct commit *tip_commit;
+	if (flags & REF_ISSYMREF)
+		return 0;
+	tip_commit = lookup_commit_reference_gently(the_repository, oid, 1);
+	if (!tip_commit)
+		return 0;
+	commit_list_insert(tip_commit, list);
+	return 0;
+}
+
+static int is_head(const char *refname)
+{
+	switch (ref_type(refname)) {
+	case REF_TYPE_OTHER_PSEUDOREF:
+	case REF_TYPE_MAIN_PSEUDOREF:
+		if (parse_worktree_ref(refname, NULL, NULL, &refname))
+			BUG("not a worktree ref: %s", refname);
+		break;
+	default:
+		break;
+	}
+	return !strcmp(refname, "HEAD");
+}
+
+void reflog_expiry_prepare(const char *refname,
+				  const struct object_id *oid,
+				  void *cb_data)
+{
+	struct expire_reflog_policy_cb *cb = cb_data;
+	struct commit_list *elem;
+	struct commit *commit = NULL;
+
+	if (!cb->cmd.expire_unreachable || is_head(refname)) {
+		cb->unreachable_expire_kind = UE_HEAD;
+	} else {
+		commit = lookup_commit(the_repository, oid);
+		cb->unreachable_expire_kind = commit ? UE_NORMAL : UE_ALWAYS;
+	}
+
+	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
+		cb->unreachable_expire_kind = UE_ALWAYS;
+
+	switch (cb->unreachable_expire_kind) {
+	case UE_ALWAYS:
+		return;
+	case UE_HEAD:
+		for_each_ref(push_tip_to_list, &cb->tips);
+		for (elem = cb->tips; elem; elem = elem->next)
+			commit_list_insert(elem->item, &cb->mark_list);
+		break;
+	case UE_NORMAL:
+		commit_list_insert(commit, &cb->mark_list);
+		/* For reflog_expiry_cleanup() below */
+		cb->tip_commit = commit;
+	}
+	cb->mark_limit = cb->cmd.expire_total;
+	mark_reachable(cb);
+}
+
+void reflog_expiry_cleanup(void *cb_data)
+{
+	struct expire_reflog_policy_cb *cb = cb_data;
+	struct commit_list *elem;
+
+	switch (cb->unreachable_expire_kind) {
+	case UE_ALWAYS:
+		return;
+	case UE_HEAD:
+		for (elem = cb->tips; elem; elem = elem->next)
+			clear_commit_marks(elem->item, REACHABLE);
+		free_commit_list(cb->tips);
+		break;
+	case UE_NORMAL:
+		clear_commit_marks(cb->tip_commit, REACHABLE);
+		break;
+	}
+}
+
+int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
+		const char *email, timestamp_t timestamp, int tz,
+		const char *message, void *cb_data)
+{
+	struct cmd_reflog_expire_cb *cb = cb_data;
+	if (!cb->expire_total || timestamp < cb->expire_total)
+		cb->recno++;
+	return 0;
+}
+
+int reflog_delete(const char *rev, enum expire_reflog_flags flags, int verbose)
+{
+	struct cmd_reflog_expire_cb cmd = { 0 };
+	int status = 0;
+	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
+	const char *spec = strstr(rev, "@{");
+	char *ep, *ref;
+	int recno;
+	struct expire_reflog_policy_cb cb = {
+		.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
+	};
+
+	if (verbose)
+		should_prune_fn = should_expire_reflog_ent_verbose;
+
+	if (!spec)
+		return error(_("not a reflog: %s"), rev);
+
+	if (!dwim_log(rev, spec - rev, NULL, &ref)) {
+		status |= error(_("no reflog for '%s'"), rev);
+		goto cleanup;
+	}
+
+	recno = strtoul(spec + 2, &ep, 10);
+	if (*ep == '}') {
+		cmd.recno = -recno;
+		for_each_reflog_ent(ref, count_reflog_ent, &cmd);
+	} else {
+		cmd.expire_total = approxidate(spec + 2);
+		for_each_reflog_ent(ref, count_reflog_ent, &cmd);
+		cmd.expire_total = 0;
+	}
+
+	cb.cmd = cmd;
+	status |= reflog_expire(ref, flags,
+				reflog_expiry_prepare,
+				should_prune_fn,
+				reflog_expiry_cleanup,
+				&cb);
+
+ cleanup:
+	free(ref);
+	return status;
+}
diff --git a/reflog.h b/reflog.h
new file mode 100644
index 00000000000..d2906fb9f8d
--- /dev/null
+++ b/reflog.h
@@ -0,0 +1,43 @@
+#ifndef REFLOG_H
+#define REFLOG_H
+#include "refs.h"
+
+struct cmd_reflog_expire_cb {
+	int stalefix;
+	int explicit_expiry;
+	timestamp_t expire_total;
+	timestamp_t expire_unreachable;
+	int recno;
+};
+
+struct expire_reflog_policy_cb {
+	enum {
+		UE_NORMAL,
+		UE_ALWAYS,
+		UE_HEAD
+	} unreachable_expire_kind;
+	struct commit_list *mark_list;
+	unsigned long mark_limit;
+	struct cmd_reflog_expire_cb cmd;
+	struct commit *tip_commit;
+	struct commit_list *tips;
+	unsigned int dry_run:1;
+};
+
+int reflog_delete(const char *rev, enum expire_reflog_flags flags,
+		  int verbose);
+void reflog_expiry_cleanup(void *cb_data);
+void reflog_expiry_prepare(const char *refname, const struct object_id *oid,
+			   void *cb_data);
+int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
+			     const char *email, timestamp_t timestamp, int tz,
+			     const char *message, void *cb_data);
+int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
+		     const char *email, timestamp_t timestamp, int tz,
+		     const char *message, void *cb_data);
+int should_expire_reflog_ent_verbose(struct object_id *ooid,
+				     struct object_id *noid,
+				     const char *email,
+				     timestamp_t timestamp, int tz,
+				     const char *message, void *cb_data);
+#endif /* REFLOG_H */
-- 
gitgitgadget

