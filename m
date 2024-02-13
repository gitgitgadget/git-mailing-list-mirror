Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50F225DA
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813721; cv=none; b=T4CU87qEoccFkP4N7XXG6aurWmQdwqFdvWrZTQw/cStTDM4P08iJuE/2EU2rrndEqQRKnPzAPTm1SitXYn17lRDeZFIB3TqA/KY53qPVMV6sLK9Zm8i9kHD8a7Ih2h3Paei3XHMb3Qux1mYk3EwzSM4MTWu6YMVULd/LYEuOdBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813721; c=relaxed/simple;
	bh=O6WbFAlBEad2plwIzBn2HkrOpyOVgRH7tgVtFnIUY8g=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XtEhFwOfNjKvxq+uhjdprug7lo/soxuD5m/uoysUF5u/lqBCcs3fiay19xwcvjt3cYf7KGcOi1VIo24c0Lklyq3NA6B6g3ZyPQQlUEq1a/TpLmnwvzF1+Yur0Nlk+328b8ObpdNHBxDGaPpW1repcCFYkYNoliJyobMnBFadCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXyJsP4h; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXyJsP4h"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so1919738f8f.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813717; x=1708418517; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0YPV023e17Vg3xNyIe0N/Q6qOxZ7eBWuxiV2ENQ/YQ=;
        b=NXyJsP4hFo/W+/gRhUohH2mATgSG2g5BGx9wvUbRP2R8rYvPDTvhxp0Fr1Av5K+pBz
         42Uq/8V+Kz1cRREojUNtzyg1BrJpjGsTxdpJ1/cWdzWpIQKlSb4NmQqviZ61f2P4Qeji
         2cbGHEwl0cpmhC3ClNRsilEd9Icxdb9misjWpEYiVe7qFe6ry7Z4sPM93qkP8fy2spFW
         vTaHbyqFuFRdsUXHOhE3vV8wB5CJJNIKcRFY8PxS64L88gEOeCNyQFX81RqBi9tYi09F
         RVWyefgdvuFzux62GhoH1nlP8MyeNprW8+5slYQR1qF1VMcSD05bNL2uynQfvvhdaM9y
         /yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813717; x=1708418517;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0YPV023e17Vg3xNyIe0N/Q6qOxZ7eBWuxiV2ENQ/YQ=;
        b=wDJbrA6Tc68rzj3ub7UGwt4CbDMVndFZW/MiE1jiuKfBonlVMMg9Kknmj8kgQXmZR3
         yDJ83pud+IHHml3rLcjZR5hCRIEuCB+3AiyIbw9ov1ENvlxua5uxw7ci/Rmp5xXa6kQv
         Ymn67DmrHjRyBeiKEnQyDOKS9Fpw+k6hKML9HGmw5/wxa9ySmI7P/e5eQP0Yw/wZdP8y
         ut1tQCBY0Hlp5Rm0U2rKrTLfgu3ow73bGav8pB4vhXRugm8XLCKKhVl6ON9qorccWrqG
         p+ETP9vJef1NHEw4//hsT6Rd0xPWrWre01jENY37/OF9G2HlTZ65SIxdw/DePx82ve+n
         JsTA==
X-Gm-Message-State: AOJu0YzM2vC7m625vQR2LzZVz1lZAt1bE+qGyC261CtuRpeQi/V8sI6c
	/VHYub3zRhNh+BWe1FQkhyaaqtqR+cm8C8v9ut2t7hXfOSqza+CYx7tgRQgg
X-Google-Smtp-Source: AGHT+IGsi3LdykkaOUMMmlRsDCtq7rWz5UnSz+0ayyFjG+KgA1tsJSgMVJHYkXIKP+FbKPY+9sKrhg==
X-Received: by 2002:a05:6000:8b:b0:33a:ead3:6438 with SMTP id m11-20020a056000008b00b0033aead36438mr1726665wrx.33.1707813716833;
        Tue, 13 Feb 2024 00:41:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c14-20020adfe70e000000b0033afe6968bfsm8880523wrm.64.2024.02.13.00.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:41:56 -0800 (PST)
Message-ID: <43c33e2eac4e5addc039ede6e3943de4cab4faee.1707813709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 08:41:44 +0000
Subject: [PATCH 08/12] repo_get_merge_bases(): pass on errors from
 `merge_bases_many()`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `merge_bases_many()` function was just taught to indicate parsing
errors, and now the `repo_get_merge_bases()` function (which is also
surfaced via the `repo_get_merge_bases()` macro) is aware of that, too.

Naturally, there are a lot of callers that need to be adjusted now, too.

Next step: adjust the callers of `get_octopus_merge_bases()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/log.c                    | 10 +++++-----
 builtin/merge-tree.c             |  5 +++--
 builtin/merge.c                  | 20 ++++++++++++--------
 builtin/rebase.c                 |  8 +++++---
 builtin/rev-parse.c              |  5 +++--
 commit-reach.c                   | 23 +++++++++++------------
 commit-reach.h                   |  7 ++++---
 diff-lib.c                       |  5 +++--
 log-tree.c                       |  5 +++--
 merge-ort.c                      |  6 +++++-
 merge-recursive.c                |  4 +++-
 notes-merge.c                    |  3 ++-
 object-name.c                    |  5 +++--
 revision.c                       | 10 ++++++----
 sequencer.c                      |  8 ++++++--
 submodule.c                      |  7 ++++++-
 t/t4301-merge-tree-write-tree.sh | 12 ++++++++++++
 17 files changed, 92 insertions(+), 51 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 1705da71aca..befafd6ae04 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1702,11 +1702,11 @@ static struct commit *get_base_commit(const char *base_commit,
 	 */
 	while (rev_nr > 1) {
 		for (i = 0; i < rev_nr / 2; i++) {
-			struct commit_list *merge_base;
-			merge_base = repo_get_merge_bases(the_repository,
-							  rev[2 * i],
-							  rev[2 * i + 1]);
-			if (!merge_base || merge_base->next) {
+			struct commit_list *merge_base = NULL;
+			if (repo_get_merge_bases(the_repository,
+						 rev[2 * i],
+						 rev[2 * i + 1], &merge_base) < 0 ||
+			    !merge_base || merge_base->next) {
 				if (die_on_failure) {
 					die(_("failed to find exact merge base"));
 				} else {
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index a35e0452d66..76200250629 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -463,8 +463,9 @@ static int real_merge(struct merge_tree_options *o,
 		 * Get the merge bases, in reverse order; see comment above
 		 * merge_incore_recursive in merge-ort.h
 		 */
-		merge_bases = repo_get_merge_bases(the_repository, parent1,
-						   parent2);
+		if (repo_get_merge_bases(the_repository, parent1,
+					 parent2, &merge_bases) < 0)
+			exit(128);
 		if (!merge_bases && !o->allow_unrelated_histories)
 			die(_("refusing to merge unrelated histories"));
 		merge_bases = reverse_commit_list(merge_bases);
diff --git a/builtin/merge.c b/builtin/merge.c
index d748d46e135..ac9d58adc29 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1517,10 +1517,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (!remoteheads)
 		; /* already up-to-date */
-	else if (!remoteheads->next)
-		common = repo_get_merge_bases(the_repository, head_commit,
-					      remoteheads->item);
-	else {
+	else if (!remoteheads->next) {
+		if (repo_get_merge_bases(the_repository, head_commit,
+					 remoteheads->item, &common) < 0) {
+			ret = 2;
+			goto done;
+		}
+	} else {
 		struct commit_list *list = remoteheads;
 		commit_list_insert(head_commit, &list);
 		common = get_octopus_merge_bases(list);
@@ -1631,7 +1634,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		struct commit_list *j;
 
 		for (j = remoteheads; j; j = j->next) {
-			struct commit_list *common_one;
+			struct commit_list *common_one = NULL;
 			struct commit *common_item;
 
 			/*
@@ -1639,9 +1642,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			 * merge_bases again, otherwise "git merge HEAD^
 			 * HEAD^^" would be missed.
 			 */
-			common_one = repo_get_merge_bases(the_repository,
-							  head_commit,
-							  j->item);
+			if (repo_get_merge_bases(the_repository, head_commit,
+						 j->item, &common_one) < 0)
+				exit(128);
+
 			common_item = common_one->item;
 			free_commit_list(common_one);
 			if (!oideq(&common_item->object.oid, &j->item->object.oid)) {
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 043c65dccd9..06a55fc7325 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -879,7 +879,8 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	if (!upstream)
 		goto done;
 
-	merge_bases = repo_get_merge_bases(the_repository, upstream, head);
+	if (repo_get_merge_bases(the_repository, upstream, head, &merge_bases) < 0)
+		exit(128);
 	if (!merge_bases || merge_bases->next)
 		goto done;
 
@@ -898,8 +899,9 @@ static void fill_branch_base(struct rebase_options *options,
 {
 	struct commit_list *merge_bases = NULL;
 
-	merge_bases = repo_get_merge_bases(the_repository, options->onto,
-					   options->orig_head);
+	if (repo_get_merge_bases(the_repository, options->onto,
+				 options->orig_head, &merge_bases) < 0)
+		exit(128);
 	if (!merge_bases || merge_bases->next)
 		oidcpy(branch_base, null_oid());
 	else
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index fde8861ca4e..c97d0f6144c 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -297,7 +297,7 @@ static int try_difference(const char *arg)
 		show_rev(NORMAL, &end_oid, end);
 		show_rev(symmetric ? NORMAL : REVERSED, &start_oid, start);
 		if (symmetric) {
-			struct commit_list *exclude;
+			struct commit_list *exclude = NULL;
 			struct commit *a, *b;
 			a = lookup_commit_reference(the_repository, &start_oid);
 			b = lookup_commit_reference(the_repository, &end_oid);
@@ -305,7 +305,8 @@ static int try_difference(const char *arg)
 				*dotdot = '.';
 				return 0;
 			}
-			exclude = repo_get_merge_bases(the_repository, a, b);
+			if (repo_get_merge_bases(the_repository, a, b, &exclude) < 0)
+				exit(128);
 			while (exclude) {
 				struct commit *commit = pop_commit(&exclude);
 				show_rev(REVERSED, &commit->object.oid, NULL);
diff --git a/commit-reach.c b/commit-reach.c
index 359853275a9..3471c933f6c 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -185,9 +185,12 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 		struct commit_list *new_commits = NULL, *end = NULL;
 
 		for (j = ret; j; j = j->next) {
-			struct commit_list *bases;
-			bases = repo_get_merge_bases(the_repository, i->item,
-						     j->item);
+			struct commit_list *bases = NULL;
+			if (repo_get_merge_bases(the_repository, i->item,
+						 j->item, &bases) < 0) {
+				free_commit_list(bases);
+				return NULL;
+			}
 			if (!new_commits)
 				new_commits = bases;
 			else
@@ -472,16 +475,12 @@ struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 	return result;
 }
 
-struct commit_list *repo_get_merge_bases(struct repository *r,
-					 struct commit *one,
-					 struct commit *two)
+int repo_get_merge_bases(struct repository *r,
+			 struct commit *one,
+			 struct commit *two,
+			 struct commit_list **result)
 {
-	struct commit_list *result = NULL;
-	if (get_merge_bases_many_0(r, one, 1, &two, 1, &result) < 0) {
-		free_commit_list(result);
-		return NULL;
-	}
-	return result;
+	return get_merge_bases_many_0(r, one, 1, &two, 1, result);
 }
 
 /*
diff --git a/commit-reach.h b/commit-reach.h
index 68f81549a44..2c6fcdd34f6 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -9,9 +9,10 @@ struct ref_filter;
 struct object_id;
 struct object_array;
 
-struct commit_list *repo_get_merge_bases(struct repository *r,
-					 struct commit *rev1,
-					 struct commit *rev2);
+int repo_get_merge_bases(struct repository *r,
+			 struct commit *rev1,
+			 struct commit *rev2,
+			 struct commit_list **result);
 struct commit_list *repo_get_merge_bases_many(struct repository *r,
 					      struct commit *one, int n,
 					      struct commit **twos);
diff --git a/diff-lib.c b/diff-lib.c
index 0e9ec4f68af..498224ccce2 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -565,7 +565,7 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
 {
 	int i;
 	struct commit *mb_child[2] = {0};
-	struct commit_list *merge_bases;
+	struct commit_list *merge_bases = NULL;
 
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object *obj = revs->pending.objects[i].item;
@@ -592,7 +592,8 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
 		mb_child[1] = lookup_commit_reference(the_repository, &oid);
 	}
 
-	merge_bases = repo_get_merge_bases(the_repository, mb_child[0], mb_child[1]);
+	if (repo_get_merge_bases(the_repository, mb_child[0], mb_child[1], &merge_bases) < 0)
+		exit(128);
 	if (!merge_bases)
 		die(_("no merge base found"));
 	if (merge_bases->next)
diff --git a/log-tree.c b/log-tree.c
index 504da6b519e..4f337766a39 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1010,7 +1010,7 @@ static int do_remerge_diff(struct rev_info *opt,
 			   struct object_id *oid)
 {
 	struct merge_options o;
-	struct commit_list *bases;
+	struct commit_list *bases = NULL;
 	struct merge_result res = {0};
 	struct pretty_print_context ctx = {0};
 	struct commit *parent1 = parents->item;
@@ -1035,7 +1035,8 @@ static int do_remerge_diff(struct rev_info *opt,
 	/* Parse the relevant commits and get the merge bases */
 	parse_commit_or_die(parent1);
 	parse_commit_or_die(parent2);
-	bases = repo_get_merge_bases(the_repository, parent1, parent2);
+	if (repo_get_merge_bases(the_repository, parent1, parent2, &bases) < 0)
+		exit(128);
 
 	/* Re-merge the parents */
 	merge_incore_recursive(&o, bases, parent1, parent2, &res);
diff --git a/merge-ort.c b/merge-ort.c
index 64e76afe89f..88f23a37f5a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5060,7 +5060,11 @@ static void merge_ort_internal(struct merge_options *opt,
 	struct strbuf merge_base_abbrev = STRBUF_INIT;
 
 	if (!merge_bases) {
-		merge_bases = repo_get_merge_bases(the_repository, h1, h2);
+		if (repo_get_merge_bases(the_repository, h1, h2,
+					 &merge_bases) < 0) {
+			result->clean = -1;
+			return;
+		}
 		/* See merge-ort.h:merge_incore_recursive() declaration NOTE */
 		merge_bases = reverse_commit_list(merge_bases);
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index e3fe7803cbe..0bed0b97424 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3632,7 +3632,9 @@ static int merge_recursive_internal(struct merge_options *opt,
 	}
 
 	if (!merge_bases) {
-		merge_bases = repo_get_merge_bases(the_repository, h1, h2);
+		if (repo_get_merge_bases(the_repository, h1, h2,
+					 &merge_bases) < 0)
+			return -1;
 		merge_bases = reverse_commit_list(merge_bases);
 	}
 
diff --git a/notes-merge.c b/notes-merge.c
index 8799b522a55..51282934ae6 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -607,7 +607,8 @@ int notes_merge(struct notes_merge_options *o,
 	assert(local && remote);
 
 	/* Find merge bases */
-	bases = repo_get_merge_bases(the_repository, local, remote);
+	if (repo_get_merge_bases(the_repository, local, remote, &bases) < 0)
+		exit(128);
 	if (!bases) {
 		base_oid = null_oid();
 		base_tree_oid = the_hash_algo->empty_tree;
diff --git a/object-name.c b/object-name.c
index 0bfa29dbbfe..89c34f9b49e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1481,7 +1481,7 @@ int repo_get_oid_mb(struct repository *r,
 		    struct object_id *oid)
 {
 	struct commit *one, *two;
-	struct commit_list *mbs;
+	struct commit_list *mbs = NULL;
 	struct object_id oid_tmp;
 	const char *dots;
 	int st;
@@ -1509,7 +1509,8 @@ int repo_get_oid_mb(struct repository *r,
 	two = lookup_commit_reference_gently(r, &oid_tmp, 0);
 	if (!two)
 		return -1;
-	mbs = repo_get_merge_bases(r, one, two);
+	if (repo_get_merge_bases(r, one, two, &mbs) < 0)
+		return -1;
 	if (!mbs || mbs->next)
 		st = -1;
 	else {
diff --git a/revision.c b/revision.c
index 00d5c29bfce..3492cc95159 100644
--- a/revision.c
+++ b/revision.c
@@ -1965,7 +1965,7 @@ static void add_pending_commit_list(struct rev_info *revs,
 
 static void prepare_show_merge(struct rev_info *revs)
 {
-	struct commit_list *bases;
+	struct commit_list *bases = NULL;
 	struct commit *head, *other;
 	struct object_id oid;
 	const char **prune = NULL;
@@ -1980,7 +1980,8 @@ static void prepare_show_merge(struct rev_info *revs)
 	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
-	bases = repo_get_merge_bases(the_repository, head, other);
+	if (repo_get_merge_bases(the_repository, head, other, &bases) < 0)
+		exit(128);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
 	free_commit_list(bases);
@@ -2068,14 +2069,15 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 	} else {
 		/* A...B -- find merge bases between the two */
 		struct commit *a, *b;
-		struct commit_list *exclude;
+		struct commit_list *exclude = NULL;
 
 		a = lookup_commit_reference(revs->repo, &a_obj->oid);
 		b = lookup_commit_reference(revs->repo, &b_obj->oid);
 		if (!a || !b)
 			return dotdot_missing(arg, dotdot, revs, symmetric);
 
-		exclude = repo_get_merge_bases(the_repository, a, b);
+		if (repo_get_merge_bases(the_repository, a, b, &exclude) < 0)
+			return -1;
 		add_rev_cmdline_list(revs, exclude, REV_CMD_MERGE_BASE,
 				     flags_exclude);
 		add_pending_commit_list(revs, exclude, flags_exclude);
diff --git a/sequencer.c b/sequencer.c
index d584cac8ed9..4417f2f1956 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3913,7 +3913,7 @@ static int do_merge(struct repository *r,
 	int run_commit_flags = 0;
 	struct strbuf ref_name = STRBUF_INIT;
 	struct commit *head_commit, *merge_commit, *i;
-	struct commit_list *bases, *j;
+	struct commit_list *bases = NULL, *j;
 	struct commit_list *to_merge = NULL, **tail = &to_merge;
 	const char *strategy = !opts->xopts.nr &&
 		(!opts->strategy ||
@@ -4139,7 +4139,11 @@ static int do_merge(struct repository *r,
 	}
 
 	merge_commit = to_merge->item;
-	bases = repo_get_merge_bases(r, head_commit, merge_commit);
+	if (repo_get_merge_bases(r, head_commit, merge_commit, &bases) < 0) {
+		ret = -1;
+		goto leave_merge;
+	}
+
 	if (bases && oideq(&merge_commit->object.oid,
 			   &bases->item->object.oid)) {
 		ret = 0;
diff --git a/submodule.c b/submodule.c
index e603a19a876..04931a5474b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -595,7 +595,12 @@ static void show_submodule_header(struct diff_options *o,
 	     (!is_null_oid(two) && !*right))
 		message = "(commits not present)";
 
-	*merge_bases = repo_get_merge_bases(sub, *left, *right);
+	*merge_bases = NULL;
+	if (repo_get_merge_bases(sub, *left, *right, merge_bases) < 0) {
+		message = "(corrupt repository)";
+		goto output_header;
+	}
+
 	if (*merge_bases) {
 		if ((*merge_bases)->item == *left)
 			fast_forward = 1;
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index b2c8a43fce3..5d1e7aca4c8 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -945,4 +945,16 @@ test_expect_success 'check the input format when --stdin is passed' '
 	test_cmp expect actual
 '
 
+test_expect_success 'error out on missing commits as well' '
+	git init --bare missing-commit.git &&
+	git rev-list --objects side1 side3 >list-including-initial &&
+	grep -v ^$(git rev-parse side1^) <list-including-initial >list &&
+	git pack-objects missing-commit.git/objects/pack/missing-initial <list &&
+	side1=$(git rev-parse side1) &&
+	side3=$(git rev-parse side3) &&
+	test_must_fail git --git-dir=missing-commit.git \
+		merge-tree --allow-unrelated-histories $side1 $side3 >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

