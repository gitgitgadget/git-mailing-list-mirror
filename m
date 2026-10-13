Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C395275B7
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906504; cv=none; b=f8du8hvq4FrZnvsfqLwVdDjwY6ACJ2DwOCAwh3MF7Zl5P/5xBK6nW65TaCM6bnYeURKTHdWms4op58ZvfM4NpbQ6nNsnS24oc2AKkuDqTgBbH16NbqACGWG64JxLB/C0Vo88SWvmITiDXFKzzZz92PS+HatrHpj3sjaCXiKK7R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906504; c=relaxed/simple;
	bh=5RJsbO7joVTVn4XCbqaVaRM1Gy1yfXFDvKzsfOdZz88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRyycrgTGA3WE5+tonmQeNVERcZ3PJiD1tKBIx0hdmIIEg/QiJ5AkpSd6O7u7AATnw9iOLOyk+aCoNaTs1GH6+0pcOfGuJQLbiJeMRDOzwHI+WwgKrD9doAF8nggLdNLmzKXl1xRQWavaPNo2pO5/2JBN14URMleuHNJSwF8U8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE++2A+i; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE++2A+i"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso1859316f8f.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791906501; x=1792511301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3XPy1OFmeA1fF7RXxmyS4aXNJf7BHmHf8VPzDKSZZPY=;
        b=fE++2A+i8mFhhQkefjoOKjM0PsAuv2HhB0fxlNpbN2rfXrD9ZAcZH7PcbunRjAo8s2
         qZPeRNHXCD0Wmgs0g73sRiKsSqxWob9rKZjXGnCDs/6iUHSDkpGvmP9SfVkfMbGT485m
         NjPdtEXUz5idwx+o9UF/PTTjOhGTL64eVBpyFmv4465PWH4MqPRg3/qxIQY4ks+ubWok
         VHIM2nfKUBrFsjfPEwZf7OrmWNYp7b/K49YGWVWM9bQQRoVPjnokVSlrlo3AbqAWfuZj
         UrGOAqtrgV71VT3KaEQCXcQuk3nPQnWtHctJBVOVuX/sgo1k1hrpeFIjnwQhaAaO6yw7
         Shww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906501; x=1792511301;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3XPy1OFmeA1fF7RXxmyS4aXNJf7BHmHf8VPzDKSZZPY=;
        b=FAhk1mmjo2IquKljo6j/aMeP8NJ85II56Ce5/J9WTNniZfksmy5Pmgzu/LObGe4XUK
         oCrF+KmFPaHQKFvaoHjv98iTcJPds2uc4tvWlEvIBDg8a6yzEUeX7a92kBlJBzfaaLkJ
         xoKH9DnF9sp0vEphHtGCbkNNhII2yMVRwj6YacovwCnCfYg/p++WfKapxcTFjYxYN+wq
         GomLrD0ooNwXgcaFGKC4YWA64fdz2g/2wL31Pi9DjZEh/XTSsLd9lSPP1UC/5rK5TT45
         675OqSlBltoBLKJajuasfrn0y45wHswlmBdriU79q9f+0gU6lL7CuHJtawCHt4pBqctm
         Sgzg==
X-Gm-Message-State: AFq9FYLH2smZI8BrWYm7TP7MO+S0axGIPhOT0dV62fK+phT2C1cSQdY0
	rK4g74kr/rs8kSOxg2MU8FjrtVoTpvOVJ515iACpwUrIHiJ82h3cfAwApigpug==
X-Gm-Gg: AYBFou2YBlKzgCFE7OmVeWTMM70wuyit+lXhEJIaXdwu/1lNNuyhLvyc+/ILUDUHo6K
	MZzoA5XXo7j1lV8sKxx85WCJSu5YGWV1AXatl992CTTghP1muUj9g7PljjVDWovEk4P53N1Z0Ip
	RqpU6xQARITFZ6uVvKPGWFBYK2VVdQrpzvkvzHGk/RSpb28n2UK9NEGDe6/bKwNJMEi8+bogSTW
	XPa8QRDbQ03dfYqZ+UCZaTvLNi2Qu+UD3GK8vV0YPWMvgLnCFWgvf1II8lApuCQoHy9VyB0M3jJ
	czEKE/QJV47l79aS7ehGdnOibIiND91F3gkR/n0GZ3hLD+y1WGRZwFcxIBNTTGL7gTDuEHPqx2/
	1Es6nzvBUuXFwGT4HqSQOCMIavSa5J88irBkz75Sr4quryXrlrBXqkXYiFgk9ooHoQ7tOQPO94+
	4IvPLFXcNpLgkGNFEvF3vH5fQiyTpcBobERs9Q7kXz6h8nuZOYRC0uxlfiXRBvk1Kh0XPLM1Y7b
	g==
X-Received: by 2002:a5d:55c8:0:b0:48c:7d67:8ee5 with SMTP id ffacd0b85a97d-48dbaae35c2mr18981740f8f.43.1791906500362;
        Tue, 13 Oct 2026 08:48:20 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc85b1sm5603561f8f.54.2026.10.13.08.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:48:19 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 3/3] merge: remember conflict labels
Date: Tue, 13 Oct 2026 16:47:55 +0100
Message-ID: <eda10c2340bff76d99e511597434705795c6b04e.1791906474.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791906474.git.phillip.wood@dunelm.org.uk>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk> <cover.1791906474.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When recreating merge conflicts with "git checkout -m <path>" the
original conflict labels are lost. For commands like "git merge" and
"git cherry-pick" we could use the presence of the related root
ref (MERGE_HEAD and CHERRY_PICK_HEAD respectively) to recreate the
labels. However, if the conflicts are from "git stash pop" or "git
checkout -m <branch>", then there is no ref to deduce the labels from. To
ensure the labels are always available, the merge machinery is updated to
write ".git/MERGE_LABELS" when it updates the worktree and
there are conflicts. The labels are then read from that file by "git
checkout -m <path>" when recreating the conflicts.

As "git checkout -m <branch>" calls remove_branch_state() which
ordinarily removes the labels file, we need to pass a flag down
to optionally prevent that so that the labels are available for any
subsequent "git checkout -m <path>". Note that merge_switch_to_result()
we assign "result->priv" to "opt->priv" and later clear "opt->priv" in
order to get a pointer to the private struct as result->priv is void*.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 branch.c           | 11 ++++++--
 branch.h           |  1 +
 builtin/checkout.c | 32 +++++++++++++++++++---
 builtin/commit.c   |  1 +
 merge-ort.c        | 20 ++++++++++++++
 merge.c            | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 merge.h            |  3 +++
 path.c             |  1 +
 path.h             |  1 +
 repository.c       |  1 +
 repository.h       |  1 +
 sequencer.c        |  1 +
 t/t7201-co.sh      | 22 ++++++++++++++++
 13 files changed, 155 insertions(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index 8bc7a395a7..5bb1c28915 100644
--- a/branch.c
+++ b/branch.c
@@ -860,9 +860,11 @@ void create_branches_recursively(struct repository *r, const char *name,
 	free(branch_point);
 }
 
-void remove_merge_branch_state(struct repository *r)
+static void do_remove_merge_branch_state(struct repository *r, unsigned flags)
 {
 	unlink(git_path_merge_head(r));
+	if (!(flags & REMOVE_BRANCH_STATE_PRESERVE_CONFLICT_LABELS))
+		unlink(git_path_merge_labels(r));
 	unlink(git_path_merge_rr(r));
 	unlink(git_path_merge_msg(r));
 	unlink(git_path_merge_mode(r));
@@ -871,11 +873,16 @@ void remove_merge_branch_state(struct repository *r)
 	save_autostash_ref(r, "MERGE_AUTOSTASH");
 }
 
+void remove_merge_branch_state(struct repository *r)
+{
+	do_remove_merge_branch_state(r, 0);
+}
+
 void remove_branch_state(struct repository *r, unsigned flags)
 {
 	sequencer_post_commit_cleanup(r, flags & REMOVE_BRANCH_STATE_VERBOSE);
 	unlink(git_path_squash_msg(r));
-	remove_merge_branch_state(r);
+	do_remove_merge_branch_state(r, flags);
 }
 
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
diff --git a/branch.h b/branch.h
index 42d1b12918..95b2431f24 100644
--- a/branch.h
+++ b/branch.h
@@ -128,6 +128,7 @@ int validate_branchname(const char *name, struct strbuf *ref);
 int validate_new_branchname(const char *name, struct strbuf *ref, int force);
 
 #define REMOVE_BRANCH_STATE_VERBOSE (1u << 0)
+#define REMOVE_BRANCH_STATE_PRESERVE_CONFLICT_LABELS (1u << 1)
 /*
  * Remove information about the merge state on the current
  * branch. (E.g., MERGE_HEAD)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index ac66de23f9..53a7290fb3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -15,6 +15,7 @@
 #include "hex.h"
 #include "hook.h"
 #include "merge-ll.h"
+#include "merge.h"
 #include "lockfile.h"
 #include "mem-pool.h"
 #include "object-file.h"
@@ -313,14 +314,28 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 struct checkout_merged_data {
 	int conflict_style;
 	int renormalize;
+	char *base_label, *ours_label, *theirs_label;
 };
 
+static void checkout_merged_release(struct checkout_merged_data *data)
+{
+	free(data->base_label);
+	free(data->ours_label);
+	free(data->theirs_label);
+}
+
 static void checkout_merged_prepare(struct checkout_merged_data *data)
 {
 	int renormalize = 0;
 
 	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
 	data->renormalize = renormalize;
+	if (read_merge_labels(the_repository, &data->base_label, &data->ours_label,
+			      &data->theirs_label)) {
+		data->base_label = xstrdup("base");
+		data->ours_label = xstrdup("ours");
+		data->theirs_label = xstrdup("theirs");
+	}
 }
 
 static int checkout_merged(int pos, const struct checkout *state,
@@ -359,8 +374,8 @@ static int checkout_merged(int pos, const struct checkout *state,
 
 	ll_opts.renormalize = data->renormalize;
 	ll_opts.conflict_style = data->conflict_style;
-	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
-				&ours, "ours", &theirs, "theirs",
+	merge_status = ll_merge(&result_buf, path, &ancestor, data->base_label,
+				&ours, data->ours_label, &theirs, data->theirs_label,
 				state->istate, &ll_opts);
 	free(ancestor.ptr);
 	free(ours.ptr);
@@ -499,6 +514,10 @@ static int checkout_worktree(const struct checkout_opts *opts,
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
+
+	if (opts->merge)
+		checkout_merged_release(&checkout_merged_data);
+
 	if (pc_workers > 1)
 		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold,
 					      NULL, NULL);
@@ -962,7 +981,8 @@ static void report_tracking(struct branch_info *new_branch_info)
 
 static void update_refs_for_switch(const struct checkout_opts *opts,
 				   struct branch_info *old_branch_info,
-				   struct branch_info *new_branch_info)
+				   struct branch_info *new_branch_info,
+				   bool merge_conflicts)
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc, *reflog_msg;
@@ -1064,6 +1084,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	}
 	if (!opts->quiet)
 		flags |= REMOVE_BRANCH_STATE_VERBOSE;
+	if (merge_conflicts)
+		flags |= REMOVE_BRANCH_STATE_PRESERVE_CONFLICT_LABELS;
 	remove_branch_state(the_repository, flags);
 	strbuf_release(&msg);
 	if (!opts->quiet &&
@@ -1278,7 +1300,9 @@ static int switch_branches(const struct checkout_opts *opts,
 
 	if (autostash_res == STASH_APPLY_CONFLICT && !opts->quiet)
 		fputc('\n', stderr);
-	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
+
+	update_refs_for_switch(opts, &old_branch_info, new_branch_info,
+			       autostash_res == STASH_APPLY_CONFLICT);
 
 	if (created_autostash) {
 		discard_index(the_repository->index);
diff --git a/builtin/commit.c b/builtin/commit.c
index 205fbd57e3..c374d5e0d5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1977,6 +1977,7 @@ int cmd_commit(int argc,
 
 	sequencer_post_commit_cleanup(the_repository, 0);
 	unlink(git_path_merge_head(the_repository));
+	unlink(git_path_merge_labels(the_repository));
 	unlink(git_path_merge_msg(the_repository));
 	unlink(git_path_merge_mode(the_repository));
 	unlink(git_path_squash_msg(the_repository));
diff --git a/merge-ort.c b/merge-ort.c
index c410a5d353..8f720e0d12 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -35,6 +35,7 @@
 #include "hex.h"
 #include "entry.h"
 #include "merge-ll.h"
+#include "merge.h"
 #include "match-trees.h"
 #include "mem-pool.h"
 #include "object-file.h"
@@ -418,6 +419,9 @@ struct merge_options_internal {
 
 	/* field that holds submodule conflict information */
 	struct string_list conflicted_submodules;
+
+	/* Copies of the labels used for conflict markers */
+	const char *labels[3];
 };
 
 struct conflicted_submodule_item {
@@ -4969,6 +4973,14 @@ void merge_switch_to_result(struct merge_options *opt,
 			return;
 		}
 		trace2_region_leave("merge", "write_auto_merge", opt->repo);
+
+		if (!result->clean) {
+			struct merge_options_internal *priv = result->priv;
+
+			trace2_region_enter("merge", "write_merge_labels", opt->repo);
+			write_merge_labels(opt->repo, priv->labels);
+			trace2_region_leave("merge", "write_merge_labels", opt->repo);
+		}
 	}
 	if (display_update_msgs)
 		merge_display_update_messages(opt, /* detailed */ 0, result);
@@ -5234,6 +5246,14 @@ static void move_opt_priv_to_result_priv(struct merge_options *opt,
 	 * to move it.
 	 */
 	assert(opt->priv && !result->priv);
+	if (!result->clean) {
+		opt->priv->labels[0] =
+			mem_pool_strdup(&opt->priv->pool, opt->ancestor);
+		opt->priv->labels[1] =
+			mem_pool_strdup(&opt->priv->pool, opt->branch1);
+		opt->priv->labels[2] =
+			mem_pool_strdup(&opt->priv->pool, opt->branch2);
+	}
 	result->priv = opt->priv;
 	result->_properly_initialized = RESULT_INITIALIZED;
 	opt->priv = NULL;
diff --git a/merge.c b/merge.c
index 0f5e823e63..6a557d11ac 100644
--- a/merge.c
+++ b/merge.c
@@ -8,6 +8,7 @@
 #include "merge.h"
 #include "commit.h"
 #include "repository.h"
+#include "path.h"
 #include "run-command.h"
 #include "resolve-undo.h"
 #include "tree.h"
@@ -111,3 +112,68 @@ int checkout_fast_forward(struct repository *r,
 		return error(_("unable to write new index file"));
 	return 0;
 }
+
+int write_merge_labels(struct repository *r, const char *labels[3])
+{
+	FILE *f = fopen_or_warn(git_path_merge_labels(r), "w");
+
+	if (!f)
+		return -1;
+
+	fprintf(f, "%s\n%s\n%s\n", labels[0], labels[1], labels[2]);
+	if (fclose(f))
+		return error_errno("could not write '%s'",
+				   git_path_merge_labels(r));
+
+	return 0;
+}
+
+static char *parse_merge_label_line(FILE *fp)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (strbuf_getline(&buf, fp) == EOF) {
+		strbuf_release(&buf);
+		return NULL;
+	}
+
+	return strbuf_detach(&buf, NULL);
+}
+
+int read_merge_labels(struct repository *r,
+		      char **pbase, char **pours, char **ptheirs)
+{
+	char *base = NULL, *ours = NULL, *theirs = NULL;
+	int ret = -1;
+	FILE *fp = fopen(git_path_merge_labels(r), "r");
+
+	if (!fp)
+		return -1;
+
+	base = parse_merge_label_line(fp);
+	if (!base)
+		goto out;
+
+	ours = parse_merge_label_line(fp);
+	if (!ours)
+		goto out;
+
+	theirs = parse_merge_label_line(fp);
+	if (!theirs)
+		goto out;
+	/* We ignore any trailing lines */
+
+	ret = 0;
+	*pbase = base;
+	*pours = ours;
+	*ptheirs = theirs;
+out:
+	if (ret) {
+		free(base);
+		free(ours);
+		free(theirs);
+	}
+	fclose(fp);
+
+	return ret;
+}
diff --git a/merge.h b/merge.h
index 21ac7ef2f1..3d936d6988 100644
--- a/merge.h
+++ b/merge.h
@@ -13,5 +13,8 @@ int checkout_fast_forward(struct repository *r,
 			  const struct object_id *from,
 			  const struct object_id *to,
 			  int overwrite_ignore);
+int write_merge_labels(struct repository *r, const char *labels[3]);
+int read_merge_labels(struct repository *r,
+		      char **base, char **ours, char **theirs);
 
 #endif /* MERGE_H */
diff --git a/path.c b/path.c
index c3a709a928..7965762602 100644
--- a/path.c
+++ b/path.c
@@ -1655,3 +1655,4 @@ REPO_GIT_PATH_FUNC(merge_mode, "MERGE_MODE")
 REPO_GIT_PATH_FUNC(merge_head, "MERGE_HEAD")
 REPO_GIT_PATH_FUNC(fetch_head, "FETCH_HEAD")
 REPO_GIT_PATH_FUNC(shallow, "shallow")
+REPO_GIT_PATH_FUNC(merge_labels, "MERGE_LABELS")
diff --git a/path.h b/path.h
index 7e7408dd05..8cd12ccfde 100644
--- a/path.h
+++ b/path.h
@@ -142,6 +142,7 @@ const char *git_path_merge_mode(struct repository *r);
 const char *git_path_merge_head(struct repository *r);
 const char *git_path_fetch_head(struct repository *r);
 const char *git_path_shallow(struct repository *r);
+const char *git_path_merge_labels(struct repository *r);
 
 int ends_with_path_components(const char *path, const char *components);
 
diff --git a/repository.c b/repository.c
index b857e1c580..210fb819b0 100644
--- a/repository.c
+++ b/repository.c
@@ -367,6 +367,7 @@ static void repo_clear_path_cache(struct repo_path_cache *cache)
 	FREE_AND_NULL(cache->merge_head);
 	FREE_AND_NULL(cache->fetch_head);
 	FREE_AND_NULL(cache->shallow);
+	FREE_AND_NULL(cache->merge_labels);
 }
 
 void repo_clear(struct repository *repo)
diff --git a/repository.h b/repository.h
index 11f5c2ed10..91b1f57db7 100644
--- a/repository.h
+++ b/repository.h
@@ -36,6 +36,7 @@ struct repo_path_cache {
 	char *merge_head;
 	char *fetch_head;
 	char *shallow;
+	char *merge_labels;
 };
 
 struct repository {
diff --git a/sequencer.c b/sequencer.c
index e25ef5eb61..0710aa6400 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5145,6 +5145,7 @@ static int pick_commits(struct repository *r,
 	unlink(rebase_path_stopped_sha());
 	unlink(rebase_path_amend());
 	unlink(rebase_path_patch());
+	unlink(git_path_merge_labels(r));
 
 	while (todo_list->current < todo_list->nr) {
 		struct todo_item *item = todo_list->items + todo_list->current;
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 9ea9462914..3e9e04738a 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -99,6 +99,7 @@ test_expect_success 'checkout -m with dirty tree' '
 
 	fill 0 1 2 3 4 5 6 7 8 >one &&
 	git checkout -m side >messages &&
+	test_path_is_missing .git/MERGE_LABELS &&
 
 	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
 
@@ -183,6 +184,27 @@ test_expect_success 'format of merge conflict from checkout -m' '
 	d
 	>>>>>>> local
 	EOF
+	test_cmp expect two &&
+
+	test_path_is_file .git/MERGE_LABELS &&
+
+	git checkout --conflict=diff3 two &&
+	cat >expect <<-\EOF &&
+	<<<<<<< simple
+	a
+	c
+	e
+	||||||| main
+	a
+	b
+	c
+	d
+	e
+	=======
+	b
+	d
+	>>>>>>> local
+	EOF
 	test_cmp expect two
 '
 
-- 
2.56.0.134.g299a3c16181

