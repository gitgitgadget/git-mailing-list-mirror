Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D7409620
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792348053; cv=none; b=hKilu0BdsNvtudbnY/GIQ5jh2mPOdIIorciqywsih0DLR/qwRMSxfS5JnFBG6EeNlOkvWUctjTdErVlV/lOWAaU5I7bvWM1nANHhoE4luLPMmYT0CX+OFjkRANpbScuwVTb3z5AzSV/4563ugvmO/gc0/EjYEiFkpJRVmcG2CH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792348053; c=relaxed/simple;
	bh=4FvOndeZlbkZq4nPQt3WuDqOXvoet0jHo3SmjQQdR04=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H5XApzoec2QguadvHHvNOHuCuLE9DeJwj5Y0ngLpnTnF/BTQZyQcqR1q+wPklfyOhB3LRado6K/jZKc823pyy25Pb6PvjWSrjfyAtGO3GR5LGqSrXZOwzDC+Gy75e8nlOQXOT/1wS1YCha2Ddjq8tZVvrpbWSS0GrB0IFhJOaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMOzIaiJ; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMOzIaiJ"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so3449898eec.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792348044; x=1792952844; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8XgQ5eXHRaKhTcLSpIngWGk+o5E/1FzNMIIoZ63hG7w=;
        b=TMOzIaiJ5L3PfFgjwf6Dyu3pN0uFirSIeRiAJMYpI6AxpZ4kC3lX/9DTSWSdxWQujM
         xOoqgOy80hKVJFZoj3NJIIw03oDDXKNmJWYVmBvoI0fiRHaBr8lbz1wdf68xUEhupu0g
         QWyz1zbP2AKIA8Y88hPBMUOpNBuztxSBQ8Ml4u25zyv9iL/pG3bahDu5jTnArwk/Ik1D
         jYOninsxmn93mmfHsGnj7wQVuQesKdX5u0zbm6VymZe2gSMfwUDMekbhVqUOBp1qtRrs
         NND9m7KPEbxKvGHDDODcdpXoXuuAFh9W63bHQ18sNRox+fDF8L25mDbH8EuM8awLR/Re
         LGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792348044; x=1792952844;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8XgQ5eXHRaKhTcLSpIngWGk+o5E/1FzNMIIoZ63hG7w=;
        b=MiiSuVAd8tTkqjWwUqPMWuGwvan7aTet/H/XPad2EbNhzuJRJNnli5mVN2mUf4yr7c
         anhWtTOxlePGQYBA3wRP9JPpuBz18jiq0DOetLPqB2f57M4yo65lB4u2iHQ3lXrdvzQb
         2/g74EFE9zg7UzJRp1V1wnlb9awy4owVBpGPuLAa0TH7XqepicUgPmtqe8gYWSMt6V7R
         Bq3Z2JtVuBYk/LtGtBwFv7gKCOQIqt5z6pqPZJeoSiW1CYzD/pAemYIqyQDm5ccrmf8L
         6janGvj8GZ8oyUPON1r5Mc5CDho0p11teUnZxBdk2A/xW+LaIEB648AVMlTy2jJfXOXn
         Ro8Q==
X-Gm-Message-State: AFq9FYKowLLcDHMpvDZBjxmgKJmb1O7vvKk77yFGbK4h0WLrXdiPDIL+
	a/2Lt3cG3ZXkoTqHSCJawLgMTxoNGrUoHqKy9SxYrTtyae4cdf241VnZpXEHfTCo
X-Gm-Gg: AYBFou03YaseUkDa09fBRbQZvCTvD9DASwF1Ur2swGj/b5iS50V+FQexfmVxnJFPTk+
	fApdOWTK1CQ8sva3cImIu2+RffUIb97XAaoEu7G3rP+7Hoyq1Mz3qrfubSxggPvNYffD0KZ6YA7
	ApTxJx1W9tYgufvmHbHIerx122CL3MG8q1y/LM+OfgLrZyXJFzvbBP5Gn4wTU8/Qk+NkZ0Rjd+7
	IBLpXtfJDty7UyG6Fv8ErgRyHz/Ya4nVjbsxLnmTeInwKckj9uWd3fzvcYCMQCfMl5AQ4FexqE4
	C6XlG9YGVQ2PWz+S/45TIo3nMzAW6qUuXOzCD7zW7G44fS5RKX7hcUyO8fPwAsqLP+pFwDGXx2Z
	M4e0SbTrDPzNb3x0Hug6jXZFPB2AulTwDY+O7ASXkEvC4WO5wiUDA6KLP+h7bIJNzVf8cpQToEt
	aEWWiTkE1kt8MEfn3mTNAehhXmORgLAeaQ6N5tbSVV1dDkJ7Hvbcnu3joVrAQCWLJnomlzbubDu
	klFMso/zc5xsA==
X-Received: by 2002:a05:7300:768c:b0:35e:a117:8fd8 with SMTP id 5a478bee46e88-361a18603d7mr11964558eec.17.1792348043911;
        Sun, 18 Oct 2026 11:27:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.179.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cc23sm30241702eec.2.2026.10.18.11.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 11:27:23 -0700 (PDT)
Message-Id: <aa5a98b80d2682cc0fa321c091c76e483fb6810f.1792348037.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
	<pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 18:27:17 +0000
Subject: [PATCH v2 3/3] reflog: add --historical-branch to name the branch of
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git reflog" does not say which branch HEAD was on when an entry was
recorded. After switching between a few branches, telling which
commits and rebases belong to which branch means reading back to the
last "checkout: moving from" entry for each of them. Commit
decorations do not help either, since they only name branches that
still point at that commit, and a rebased or amended commit has none.

Teach "git reflog" and "git log -g" a "--historical-branch" option
that shows the branch each entry was made on before its message, in
place of the refs that point at the commit now. The hashes and
selectors stay lined up in their columns, and the name is colored like
a branch decoration:

  $ git reflog --historical-branch
  4e5f6a7 HEAD@{0}: (topic) commit: add tests
  1a2b3c4 HEAD@{1}: (topic) checkout: moving from main to topic
  8c9d0e1 HEAD@{2}: (main) commit: fix typo

Every entry gets a name, including ones whose commits are no longer on
any branch. Entries from before a branch was renamed show its old name,
and entries made on a detached HEAD show "detached at <commit>".
Combined with "--operations", which leaves out the branch switches
themselves, it lists what was done to each branch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-reflog.adoc       |   3 +-
 Documentation/rev-list-options.adoc |  10 +++
 log-tree.c                          |  28 ++++++-
 reflog-walk.c                       | 124 +++++++++++++++++++++++++---
 reflog-walk.h                       |   7 +-
 revision.c                          |   8 +-
 revision.h                          |   1 +
 t/t1414-reflog-walk.sh              |  95 ++++++++++++++++++++-
 8 files changed, 258 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index 672b9ea72e..04ed7849c2 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -43,7 +43,8 @@ actions, and in addition the `HEAD` reflog records branch switching.
 --pretty=oneline`; see linkgit:git-log[1] for more information.
 With `--operations`, branch switches and other entries that change no
 branch are left out, and a rebase is shown as a single entry instead
-of one entry for each commit it replayed.
+of one entry for each commit it replayed. With `--historical-branch`,
+each entry shows the branch it was made on before its message.
 
 The "list" subcommand lists all refs which have a corresponding reflog.
 
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index a40ba2641b..8c0010695b 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -359,6 +359,16 @@ Under `--pretty=reference`, this information will not be shown at all.
 	rebase started. It is an error to use this option unless
 	`--walk-reflogs` is in use.
 
+ifndef::git-rev-list[]
+`--historical-branch`::
+	Show the branch `HEAD` was on when each reflog entry was
+	recorded, such as `(topic)`, before the reflog message, in
+	place of the refs that point at the commit now. When `HEAD` was
+	detached, the entry shows `(detached at <commit>)`. For the
+	reflog of any other ref, the name of that ref is shown. It is
+	an error to use this option unless `--walk-reflogs` is in use.
+endif::git-rev-list[]
+
 `--merge`::
 	Show commits touching conflicted paths in the range `HEAD...<other>`,
 	where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
diff --git a/log-tree.c b/log-tree.c
index 83a3c4bf9b..b2d9a954e7 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -421,6 +421,24 @@ void format_decorations(struct strbuf *sb,
 	}
 }
 
+static void format_historical_branch(struct strbuf *sb,
+				     struct rev_info *opt)
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
+	strbuf_addf(sb, "%s(%s%s%s%s%s)%s ",
+		    color_commit, color_reset,
+		    decorate_get_color(use_color, DECORATION_REF_LOCAL),
+		    branch, color_reset, color_commit, color_reset);
+}
+
 void show_decorations(struct rev_info *opt, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -431,7 +449,7 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 		if (slot && *slot)
 			fprintf(opt->diffopt.file, "\t%s", *slot);
 	}
-	if (!opt->show_decorations)
+	if (!opt->show_decorations || opt->historical_branch)
 		return;
 	format_decorations(&sb, commit, opt->diffopt.use_color, NULL);
 	fputs(sb.buf, opt->diffopt.file);
@@ -834,16 +852,22 @@ void show_log(struct rev_info *opt)
 			graph_show_oneline(opt->graph);
 		}
 		if (opt->reflog_info) {
+			struct strbuf branch = STRBUF_INIT;
+
 			/*
 			 * setup_revisions() ensures that opt->reflog_info
 			 * and opt->graph cannot both be set,
 			 * so we don't need to worry about printing the
 			 * graph info here.
 			 */
+			if (opt->historical_branch)
+				format_historical_branch(&branch, opt);
 			show_reflog_message(opt->reflog_info,
 					    opt->commit_format == CMIT_FMT_ONELINE,
 					    opt->date_mode,
-					    opt->date_mode_explicit);
+					    opt->date_mode_explicit,
+					    branch.buf);
+			strbuf_release(&branch);
 			if (opt->commit_format == CMIT_FMT_ONELINE)
 				return;
 		}
diff --git a/reflog-walk.c b/reflog-walk.c
index 82528f5b66..0cdca76efd 100644
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
@@ -365,7 +464,8 @@ timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info)
 }
 
 void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
-			 struct date_mode dmode, int force_date)
+			 struct date_mode dmode, int force_date,
+			 const char *branch)
 {
 	if (reflog_info && reflog_info->last_commit_reflog) {
 		struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
@@ -375,11 +475,13 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
 		if (oneline) {
-			printf("%s: %s", selector.buf, info->message);
+			printf("%s: %s%s", selector.buf, branch,
+			       info->message);
 		}
 		else {
-			printf("Reflog: %s (%s)\nReflog message: %s",
-			       selector.buf, info->email, info->message);
+			printf("Reflog: %s (%s)\nReflog message: %s%s",
+			       selector.buf, info->email, branch,
+			       info->message);
 		}
 
 		strbuf_release(&selector);
diff --git a/reflog-walk.h b/reflog-walk.h
index 1d86795f84..8951251f8a 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -7,13 +7,16 @@ struct date_mode;
 
 void init_reflog_walk(struct reflog_walk_info **info);
 void reflog_walk_info_release(struct reflog_walk_info *info);
-void reflog_walk_mark(struct reflog_walk_info *info, bool operations);
+void reflog_walk_mark(struct reflog_walk_info *info, bool operations,
+		      bool historical_branch);
 int add_reflog_for_walk(struct reflog_walk_info *info,
 			struct commit *commit, const char *name);
 void show_reflog_message(struct reflog_walk_info *info, int,
-			 struct date_mode, int force_date);
+			 struct date_mode, int force_date,
+			 const char *branch);
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
index e15f6f2381..6d5272aacf 100755
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
+		HEAD@{0}: (topic) rebase (finish): returning to refs/heads/topic
+		HEAD@{1}: (topic) rebase (pick): C
+		HEAD@{2}: (topic) rebase (pick): B
+		HEAD@{3}: (topic) rebase (pick): A
+		HEAD@{4}: (topic) rebase (start): checkout main
+		HEAD@{5}: (topic) checkout: moving from main to topic
+		HEAD@{6}: (main) commit: upstream
+		HEAD@{7}: (main) checkout: moving from topic to main
+		HEAD@{8}: (topic) commit: C
+		HEAD@{9}: (topic) commit: B
+		HEAD@{10}: (topic) commit: A
+		HEAD@{11}: (topic) checkout: moving from main to topic
+		HEAD@{12}: (main) commit (initial): base
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
+		echo "<YELLOW>$hash<RESET> HEAD@{0}: <YELLOW>(<RESET><BOLD;GREEN>topic<RESET><YELLOW>)<RESET> rebase (finish): returning to refs/heads/topic" >expect &&
+		git reflog --historical-branch --decorate --color -1 >out &&
+		test_decode_color <out >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--historical-branch names the ref of other reflogs' '
+	(
+		cd operations &&
+		echo "main@{0}: (main) commit: upstream" >expect &&
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
+		cut -d " " -f 3 out | sort -u >actual &&
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
+		HEAD@{0}: (renamed) commit: E
+		HEAD@{1}: (renamed) Branch: renamed refs/heads/topic to refs/heads/renamed
+		HEAD@{3}: (topic) commit: D
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
+		HEAD@{0}: (renamed) checkout: moving from $(git rev-parse F) to renamed
+		HEAD@{1}: (detached at $(git rev-parse --short F)) commit: F
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
