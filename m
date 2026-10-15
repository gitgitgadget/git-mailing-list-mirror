Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5517A515894
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070054; cv=none; b=okNH98IJMoSaxnhNdMO8G2A9cJwcDwIB/Uulcg2DldFdaU80hV2aFFpzZcVl+A8KztO8sQV/wfluo+9USEajzXjG3LqbuRL6OTDsjnDg3/IZqKSeXLAqEXfte5pHmRRMXLsF2XH6ahVC3iTlvjQWj3DYCRh0fm98+7PXExhxzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070054; c=relaxed/simple;
	bh=RcLAsX4Xbw4GaxSDnh9xuS/KLvC/T+vvr0KgZDN7Meg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CB4roMrd6VGL3ijmWDQFyaA9mEtK1HQ2F4ckWUhzT1MLIXGDRGvTjMwBjBVTYnKKf8shlr2MKxfFomj5IcDwGrZubTx9WwkUcWWGNE/pUvarqlZnqjO6isToX+6mJK04LaAGllSNiJrClFGhOk57woRlx+FYML5/S1bYLQ/rW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esh00hah; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esh00hah"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e96502e447so4284225ad.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792070051; x=1792674851; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5+JaR9oVGL1Wa63Iqjj9euxjCJ9/0IvZF75/kzz5q58=;
        b=esh00hahBsFbzXNawc6nnUvv1aXXfWX5zZrY1eeHPv7pj8gzeA9t9GXz6UIFNDskbv
         epBNbnMdX7x1O4ufqhaGO0r0AXMJdpQkfcyP3sHhxXvBGeP+5KJcYncCLxoGuSwydkME
         8mPgtvQRBpfFc63zswo8Oh2BZjp6PHX88oMHD9CrKRbqd26NsM6FBKFOzgne3k1QNOkm
         RFfNmM1Gw0Ix3cNJjxzl46B+attrstP0D9sjM0i+qlW7wBbJbjcb5UizLBx9L3ILlUch
         0hh4+JvjnYFRNO0M0uwXuLuYeppLv9NU60giOZSgSlx7OtCD79HFgXivKd/V43busLFa
         fn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070051; x=1792674851;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+JaR9oVGL1Wa63Iqjj9euxjCJ9/0IvZF75/kzz5q58=;
        b=D8GM0cdpwGJFIgV602lW8LWVS8T+3HvuiHzwYsyc4Afat1+OYegtW9wYaUaYpfu5SK
         v1UC8LISi/dR7xQVmMvb676gBhW4RKnR0JhxzRszn9/+7urOxfrMwwcTPob4z7Gpsh8r
         LTvdT1uXy/poFF6JDqR/3lGvAhR/UCx920xyjU13oF6WnHk4yvGehOWGElrGxnhHlSgE
         V1vesvbEp0S7F46fvFO69jqR/V7XjRXIf8QTkl3q6Xl4oajV4ea9O9jrl1YU/noke1HP
         MmtZJs2RSKJaOpeB4ibxn9ET/94Hybu88fhlc3MMI8R78ByqA2emj/A46brcmbcRBj4W
         3BvQ==
X-Gm-Message-State: AFq9FYInB1fRxpRWD7juzsDMHTVAdJ0+05iJ3UY4mmvgffk55qzuYuV2
	lMjHzw5TY2o6tooni7DZPpcLcwESBHz+5670GpsuuOf88vSmVUM4WViNJPNB61xmAOs=
X-Gm-Gg: AYBFou1jRVWD92nXBgqlquRdsE4NXJq7dzZ+m+nTMhD3TRpxzaZOS8N5Zs0CteqSJkQ
	sGXMrZCkVZNPtSD4TMCVm+FgVk+Y24CBUK/9/wEblwV0ydGyuUmEd+JsvPdLIWDNyzrvx3Kn/hQ
	hCkpqLbq3Otp91sxd4zdBo9Zi1ixyX60//f2Rf5LLKbwFWjeE9B9qkdyjhJcaUBkFI/CMNrLZhb
	cZi4zWyYW9mK4KOYHoK9VdcSKMJ6clz2oJWLAhpxrR4sWrU0a1ufIoPj008NfWdOYHxjvxnqx4k
	N1iVkffbOGkZ68Ad69LAe1ZFGug4vpDxMI1DManNaYfbQuTpQroLYKmBLll1hfCcPl1cc6viKWZ
	UtiIYPN84sIJWWb6TfaWWPzdsxeqX82j2AU/UOHUtyOg+onC/6oke13HCn7r5YoYZVTUzHqLe6Y
	lDyFPDXmzmnlG24ZKQ058tyoVVrQwKddC8bo1bCSTugZT4ykCdnJOk10TPFN6PVGUr0HJhCXGjd
	Q==
X-Received: by 2002:a17:902:e80a:b0:2dd:c053:a6f1 with SMTP id d9443c01a7336-2e842bd0c18mr176605325ad.35.1792070051061;
        Thu, 15 Oct 2026 06:14:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.112.122.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e956a632a4sm11557195ad.39.2026.10.15.06.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:14:09 -0700 (PDT)
Message-Id: <4efe74b04e3c69b78caa4acd24c95a8cb64d0c57.1792070038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 13:13:58 +0000
Subject: [PATCH 3/3] reflog: add --historical-branch to name the branch of
 each entry
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git reflog" does not say which branch HEAD was on when an entry was
recorded. After switching between a few branches, telling which
commits and rebases belong to which branch means reading back to the
last "checkout: moving from" entry for each of them. Commit
decorations do not help either, since they only name branches that
still point at that commit, and a rebased or amended commit has none.

Teach "git reflog" and "git log -g" a "--historical-branch" option
that decorates each entry with the branch it was made on, in place of
the refs that point at the commit now. The name is colored like a
branch decoration:

  $ git reflog --historical-branch
  4e5f6a7 (topic) HEAD@{0}: commit: add tests
  1a2b3c4 (topic) HEAD@{1}: checkout: moving from main to topic
  8c9d0e1 (main) HEAD@{2}: commit: fix typo

Every entry gets a name, including ones whose commits are no longer on
any branch. Entries from before a branch was renamed show its old name,
and entries made on a detached HEAD show "detached at <commit>".
Combined with "--operations", which leaves out the branch switches
themselves, it lists what was done to each branch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-reflog.adoc       |   3 +-
 Documentation/rev-list-options.adoc |   8 ++
 log-tree.c                          |  21 ++++++
 reflog-walk.c                       | 113 ++++++++++++++++++++++++++--
 reflog-walk.h                       |   4 +-
 revision.c                          |   8 +-
 revision.h                          |   1 +
 t/t1414-reflog-walk.sh              |  95 ++++++++++++++++++++++-
 8 files changed, 242 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index 672b9ea72e..cd988f438b 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -43,7 +43,8 @@ actions, and in addition the `HEAD` reflog records branch switching.
 --pretty=oneline`; see linkgit:git-log[1] for more information.
 With `--operations`, branch switches and other entries that change no
 branch are left out, and a rebase is shown as a single entry instead
-of one entry for each commit it replayed.
+of one entry for each commit it replayed. With `--historical-branch`,
+each entry is decorated with the branch it was made on.
 
 The "list" subcommand lists all refs which have a corresponding reflog.
 
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index a40ba2641b..d2a0a9b3bc 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -359,6 +359,14 @@ Under `--pretty=reference`, this information will not be shown at all.
 	rebase started. It is an error to use this option unless
 	`--walk-reflogs` is in use.
 
+`--historical-branch`::
+	Decorate each reflog entry with the branch `HEAD` was on when
+	the entry was recorded, such as `(topic)`, in place of the refs
+	that point at the commit now. When `HEAD` was detached, the
+	entry shows `(detached at <commit>)`. For the reflog of any
+	other ref, the name of that ref is shown. It is an error to use
+	this option unless `--walk-reflogs` is in use.
+
 `--merge`::
 	Show commits touching conflicted paths in the range `HEAD...<other>`,
 	where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
diff --git a/log-tree.c b/log-tree.c
index 83a3c4bf9b..d457f0451a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -421,6 +421,23 @@ void format_decorations(struct strbuf *sb,
 	}
 }
 
+static void show_historical_branch(struct rev_info *opt)
+{
+	const char *branch = get_reflog_branch(opt->reflog_info);
+	enum git_colorbool use_color = opt->diffopt.use_color;
+	const char *color_commit, *color_reset;
+
+	if (!branch)
+		return;
+
+	color_commit = diff_get_color(use_color, DIFF_COMMIT);
+	color_reset = decorate_get_color(use_color, DECORATION_NONE);
+	fprintf(opt->diffopt.file, "%s (%s%s%s%s%s)%s",
+		color_commit, color_reset,
+		decorate_get_color(use_color, DECORATION_REF_LOCAL),
+		branch, color_reset, color_commit, color_reset);
+}
+
 void show_decorations(struct rev_info *opt, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -431,6 +448,10 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 		if (slot && *slot)
 			fprintf(opt->diffopt.file, "\t%s", *slot);
 	}
+	if (opt->historical_branch) {
+		show_historical_branch(opt);
+		return;
+	}
 	if (!opt->show_decorations)
 		return;
 	format_decorations(&sb, commit, opt->diffopt.use_color, NULL);
diff --git a/reflog-walk.c b/reflog-walk.c
index 82528f5b66..cc42fcd7d8 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -5,6 +5,8 @@
 #include "refs.h"
 #include "reflog.h"
 #include "diff.h"
+#include "hex.h"
+#include "object-name.h"
 #include "repository.h"
 #include "revision.h"
 #include "string-list.h"
@@ -19,6 +21,7 @@ struct complete_reflogs {
 		timestamp_t timestamp;
 		int tz;
 		char *message;
+		char *branch;
 		bool user_operation;
 	} *items;
 	int nr, alloc;
@@ -40,6 +43,7 @@ static int read_one_reflog(const char *refname UNUSED,
 	item->timestamp = timestamp;
 	item->tz = tz;
 	item->message = xstrdup(message);
+	item->branch = NULL;
 	item->user_operation = true;
 	array->nr++;
 	return 0;
@@ -55,6 +59,7 @@ static void free_complete_reflog(struct complete_reflogs *array)
 	for (i = 0; i < array->nr; i++) {
 		free(array->items[i].email);
 		free(array->items[i].message);
+		free(array->items[i].branch);
 	}
 	free(array->items);
 	free(array->ref);
@@ -108,6 +113,80 @@ static void mark_operations(struct complete_reflogs *array)
 	}
 }
 
+static char *branch_label(const char *name, size_t len)
+{
+	struct object_id oid;
+	const char *short_name;
+
+	if (len == the_hash_algo->hexsz && !get_oid_hex(name, &oid))
+		return xstrfmt("detached at %s",
+			       repo_find_unique_abbrev(the_repository, &oid,
+						       DEFAULT_ABBREV));
+	if (skip_prefix(name, "refs/heads/", &short_name))
+		len -= short_name - name;
+	else
+		short_name = name;
+	return xmemdupz(short_name, len);
+}
+
+struct branch_move {
+	const char *from, *to;
+	size_t from_len, to_len;
+};
+
+static bool parse_branch_move(const char *message, struct branch_move *move)
+{
+	const char *to;
+
+	if (!skip_prefix(message, REFLOG_SWITCH_PREFIX, &move->from) &&
+	    !skip_prefix(message, REFLOG_RENAME_PREFIX, &move->from))
+		return false;
+	to = strstr(move->from, " to ");
+	if (!to)
+		return false;
+	move->from_len = to - move->from;
+	move->to = to + strlen(" to ");
+	move->to_len = strcspn(move->to, "\n");
+	return true;
+}
+
+static void mark_branches(struct complete_reflogs *array)
+{
+	char *branch = NULL;
+
+	if (strcmp(array->ref, "HEAD"))
+		return;
+
+	for (int i = array->nr - 1; i >= 0; i--) {
+		struct reflog_info *item = &array->items[i];
+		struct branch_move move;
+
+		if (!parse_branch_move(item->message, &move)) {
+			item->branch = xstrdup_or_null(branch);
+			continue;
+		}
+
+		if (!branch)
+			for (int j = i + 1; j < array->nr; j++)
+				array->items[j].branch =
+					branch_label(move.to, move.to_len);
+		item->branch = branch_label(move.to, move.to_len);
+		free(branch);
+		branch = branch_label(move.from, move.from_len);
+	}
+
+	if (!branch) {
+		struct ref_store *refs = get_main_ref_store(the_repository);
+		const char *head = refs_resolve_ref_unsafe(refs, "HEAD", 0,
+							   NULL, NULL);
+
+		if (head && skip_prefix(head, "refs/heads/", &head))
+			for (int i = 0; i < array->nr; i++)
+				array->items[i].branch = xstrdup(head);
+	}
+	free(branch);
+}
+
 static struct complete_reflogs *read_complete_reflog(const char *ref)
 {
 	struct complete_reflogs *reflogs =
@@ -178,13 +257,16 @@ void init_reflog_walk(struct reflog_walk_info **info)
 	(*info)->complete_reflogs.strdup_strings = 1;
 }
 
-void reflog_walk_mark(struct reflog_walk_info *info, bool operations)
+void reflog_walk_mark(struct reflog_walk_info *info, bool operations,
+		      bool historical_branch)
 {
 	struct string_list_item *item;
 
 	for_each_string_list_item(item, &info->complete_reflogs) {
 		if (operations)
 			mark_operations(item->util);
+		if (historical_branch)
+			mark_branches(item->util);
 	}
 }
 
@@ -287,6 +369,16 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	return 0;
 }
 
+static const char *short_ref(struct complete_reflogs *reflogs)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+
+	if (!reflogs->short_ref)
+		reflogs->short_ref =
+			refs_shorten_unambiguous_ref(refs, reflogs->ref, 0);
+	return reflogs->short_ref;
+}
+
 void get_reflog_selector(struct strbuf *sb,
 			 struct reflog_walk_info *reflog_info,
 			 struct date_mode dmode, int force_date,
@@ -300,12 +392,7 @@ void get_reflog_selector(struct strbuf *sb,
 		return;
 
 	if (shorten) {
-		if (!commit_reflog->reflogs->short_ref)
-			commit_reflog->reflogs->short_ref
-				= refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
-							       commit_reflog->reflogs->ref,
-							       0);
-		printed_ref = commit_reflog->reflogs->short_ref;
+		printed_ref = short_ref(commit_reflog->reflogs);
 	} else {
 		printed_ref = commit_reflog->reflogs->ref;
 	}
@@ -340,6 +427,18 @@ void get_reflog_message(struct strbuf *sb,
 	strbuf_add(sb, info->message, len);
 }
 
+const char *get_reflog_branch(struct reflog_walk_info *reflog_info)
+{
+	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
+
+	if (!commit_reflog)
+		return NULL;
+
+	if (strcmp(commit_reflog->reflogs->ref, "HEAD"))
+		return short_ref(commit_reflog->reflogs);
+	return commit_reflog->reflogs->items[commit_reflog->recno+1].branch;
+}
+
 const char *get_reflog_ident(struct reflog_walk_info *reflog_info)
 {
 	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
diff --git a/reflog-walk.h b/reflog-walk.h
index 1d86795f84..223f4a0dd3 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -7,13 +7,15 @@ struct date_mode;
 
 void init_reflog_walk(struct reflog_walk_info **info);
 void reflog_walk_info_release(struct reflog_walk_info *info);
-void reflog_walk_mark(struct reflog_walk_info *info, bool operations);
+void reflog_walk_mark(struct reflog_walk_info *info, bool operations,
+		      bool historical_branch);
 int add_reflog_for_walk(struct reflog_walk_info *info,
 			struct commit *commit, const char *name);
 void show_reflog_message(struct reflog_walk_info *info, int,
 			 struct date_mode, int force_date);
 void get_reflog_message(struct strbuf *sb,
 			struct reflog_walk_info *reflog_info);
+const char *get_reflog_branch(struct reflog_walk_info *reflog_info);
 const char *get_reflog_ident(struct reflog_walk_info *reflog_info);
 timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info);
 void get_reflog_selector(struct strbuf *sb,
diff --git a/revision.c b/revision.c
index 88785651fe..0367ad9b5e 100644
--- a/revision.c
+++ b/revision.c
@@ -2622,6 +2622,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_signature = 1;
 	} else if (!strcmp(arg, "--no-show-signature")) {
 		revs->show_signature = 0;
+	} else if (!strcmp(arg, "--historical-branch")) {
+		revs->historical_branch = 1;
 	} else if (!strcmp(arg, "--show-linear-break")) {
 		revs->break_bar = "                    ..........";
 		revs->track_linear = 1;
@@ -3249,11 +3251,15 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
+	if (!revs->reflog_info && revs->historical_branch)
+		die(_("the option '%s' requires '%s'"), "--historical-branch", "--walk-reflogs");
+
 	if (!revs->reflog_info && revs->reflog_operations)
 		die(_("the option '%s' requires '%s'"), "--operations", "--walk-reflogs");
 
 	if (revs->reflog_info)
-		reflog_walk_mark(revs->reflog_info, revs->reflog_operations);
+		reflog_walk_mark(revs->reflog_info, revs->reflog_operations,
+				 revs->historical_branch);
 
 	if (revs->line_level_traverse &&
 	    (revs->full_diff ||
diff --git a/revision.h b/revision.h
index c4f5e06698..6a0fd120e5 100644
--- a/revision.h
+++ b/revision.h
@@ -269,6 +269,7 @@ struct rev_info {
 			show_notes_given:1,
 			show_notes_by_default:1,
 			show_signature:1,
+			historical_branch:1,
 			pretty_given:1,
 			abbrev_commit:1,
 			abbrev_commit_given:1,
diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index e15f6f2381..eaf8187ba7 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -159,6 +159,52 @@ test_expect_success '--operations shows a rebase as one entry' '
 	)
 '
 
+test_expect_success '--historical-branch names the branch of each entry' '
+	(
+		cd operations &&
+
+		cat >expect <<-\EOF &&
+		(topic) HEAD@{0}: rebase (finish): returning to refs/heads/topic
+		(topic) HEAD@{1}: rebase (pick): C
+		(topic) HEAD@{2}: rebase (pick): B
+		(topic) HEAD@{3}: rebase (pick): A
+		(topic) HEAD@{4}: rebase (start): checkout main
+		(topic) HEAD@{5}: checkout: moving from main to topic
+		(main) HEAD@{6}: commit: upstream
+		(main) HEAD@{7}: checkout: moving from topic to main
+		(topic) HEAD@{8}: commit: C
+		(topic) HEAD@{9}: commit: B
+		(topic) HEAD@{10}: commit: A
+		(topic) HEAD@{11}: checkout: moving from main to topic
+		(main) HEAD@{12}: commit (initial): base
+		EOF
+		git reflog --historical-branch >out &&
+		cut -d " " -f 2- out >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--historical-branch takes the place of decorations' '
+	(
+		cd operations &&
+		hash=$(git rev-parse --short HEAD) &&
+		echo "<YELLOW>$hash<RESET><YELLOW> (<RESET><BOLD;GREEN>topic<RESET><YELLOW>)<RESET>" >expect &&
+		git reflog --historical-branch --decorate --color -1 >out &&
+		test_decode_color <out | sed "s/ HEAD@.*//" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--historical-branch names the ref of other reflogs' '
+	(
+		cd operations &&
+		echo "(main) main@{0}: commit: upstream" >expect &&
+		git reflog -1 main --historical-branch >out &&
+		cut -d " " -f 2- out >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success '--operations shows a stopped rebase as one entry once it finishes' '
 	set_fake_editor &&
 	(
@@ -231,8 +277,55 @@ test_expect_success '--operations shows a pull --rebase as one entry' '
 	)
 '
 
-test_expect_success '--operations requires --walk-reflogs' '
+test_expect_success '--historical-branch names the current branch when HEAD never switched' '
+	(
+		cd downstream &&
+		echo "(topic)" >expect &&
+		git reflog --historical-branch >out &&
+		cut -d " " -f 2 out | sort -u >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--historical-branch follows a renamed branch' '
+	(
+		cd operations &&
+		test_commit D &&
+		git branch -m topic renamed &&
+		test_commit E &&
+
+		cat >expect <<-\EOF &&
+		(renamed) HEAD@{0}: commit: E
+		(renamed) HEAD@{1}: Branch: renamed refs/heads/topic to refs/heads/renamed
+		(topic) HEAD@{3}: commit: D
+		EOF
+		git reflog --historical-branch -3 >out &&
+		cut -d " " -f 2- out >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--historical-branch shows where HEAD was detached' '
+	(
+		cd operations &&
+		git checkout --detach &&
+		test_commit F &&
+		git checkout renamed &&
+
+		cat >expect <<-EOF &&
+		(renamed) HEAD@{0}: checkout: moving from $(git rev-parse F) to renamed
+		(detached at $(git rev-parse --short F)) HEAD@{1}: commit: F
+		EOF
+		git reflog --historical-branch -2 >out &&
+		cut -d " " -f 2- out >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--operations and --historical-branch require --walk-reflogs' '
 	test_must_fail git log --operations 2>err &&
+	test_grep "requires .--walk-reflogs." err &&
+	test_must_fail git log --historical-branch 2>err &&
 	test_grep "requires .--walk-reflogs." err
 '
 
-- 
gitgitgadget
