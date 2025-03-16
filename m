Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F73187FFA
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742107330; cv=none; b=LPu/C/ho6t2Ki2MxCc5GaZxAt+k3uY+2KudYkxBf2NYSRt4rpwOLBVI3pecqFZkS6qlLZHKEYXbNWmybxNy+IlZagRfrVZ1XM655l+tono5ZDel+VcCdQh8ZjX3Z/hMsX+dHTLcPI+pIhMxLrbrEZ/M+5SkojIMMmQTotZoMlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742107330; c=relaxed/simple;
	bh=wRQMfDQaX62xU9Sa5VNd1pS6SPdoVx6yFQicuRK5kr8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ESbdNLPIjwNJqr/JeAad/65UtI/S249aHirS4U2ltR7g6irQA76/6MlFjG0JcBs/UyQ2dbGp4yTInoopTGaZk9ca5GLSHB616aX61O4RoJ+EV+vaq7UXJlX8rRzEavr3Sf2o63/tQIifWapoOLzbGc+8jqgZr6AW9C100y5TS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/dactuT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/dactuT"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so7168815e9.0
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742107327; x=1742712127; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXA3TRQ/r5/vvweHdjLi9mt0grtT7hlGaEAEogCoozw=;
        b=l/dactuTxaenl9RhIQz28+rmiuVgpp2YUI+adaQyFU+SDEQZ9j5SzTNCFNKxkh+3wD
         WGLtpKdOhf0q3a4DGvaBhiZn7xDLEA3CjjVvrlRItZmpNIASRyejft6PRpG5827TgbDP
         ZpN4vYk3VIBT6Lk9X5KWzk93+C0ZYh/UlO7YAApfLAc9yR1j2Z9w6ZNW5NWtLSGNSfH7
         AnyYt9kXIY6UrJ6tSbcydU3oNa4aI49MrpPu284JFv6Wg9dt622tlyVfQBkO5+RauSPt
         OAzvni+1TyKVr9Xw6k62Lw1+jUwSES7MelUNhV7i40M4cSpH6z36gBVzJNQm+CyUg1xt
         FQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742107327; x=1742712127;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXA3TRQ/r5/vvweHdjLi9mt0grtT7hlGaEAEogCoozw=;
        b=LzB9gU9oFdhwl/XoBLbQ0FtgIkY+yS8F268Pey4k0YdWoSfV2kgfDkiGrKfIojXfQ8
         hAFFnhCwTMjYsTZ7/wjB2BvF4g7kSpY66TAVk7rm+XQEBKbMIeaE2I2VfAPBV3LaXvn3
         U25PJNY7ILDcGwzCjbReeKcaq9NpKvvQVN8pUVueKK4YeWVGiJMM2uRXpzJ9qz0Iw+tk
         XMEwLKa5XXVbEvqRF72l5siX9na1tbYcIC8nVrJGZt3EGNmbfQHBqmhdXnek42yiz6uf
         mij2crQvyL6goY5cq8m9dBQTf5NgFjkWUYy2Rj5SL/07E56bo0Lr+ZR8PpVfpvWg+OXi
         Zcdg==
X-Gm-Message-State: AOJu0YwXCjbzUrAObSYjHMDt9nEj4rpcrNFyXbqztyxi3eKCTzJKAJPf
	IflkYenDvBV0sB2JCAgQkrfdI1sGkIniUB8iBExZMeako2WYhJLJpbnb9A==
X-Gm-Gg: ASbGncu+8nPwIe8t3Et7zbS5XwDFFjurKHTV24n+Vr628+JXjK8W5Ako0VLbYpO+FrN
	rvMYystDJCrx+nXOdg5NVZuz1I4khZqifUHzCFuLCswVAlhvVZTMYS0agjmz9w93JA/EN2wKR8S
	rLl+sAVQb6OY4iw/MBriy5xswtCw+qmcJ/PnHtL9qw5HYTKe4DkkNeLvVQ7h7SZaZtruISiJVkf
	9Fi10vo4UnDpIYaFOKGjHumnlwLdJgVlYjUJdfaLOE5oWFmyGH4dPa9T3KcDUHH9gv7bxWgCjGr
	yPdaOhYJE3/YSd6e/uVIfwEKXnYshh7UuFH1UYMJpMP1SsHFp292DcDD
X-Google-Smtp-Source: AGHT+IGIe4AfQA/zzZeAVJ7FHPmVcLrGjlfLJuuBIW+6oeAsmdbSVfB9CI//hYK/kTNK7bmYWNiT0A==
X-Received: by 2002:a05:600c:548e:b0:43d:683:8ca3 with SMTP id 5b1f17b1804b1-43d1ec62c5fmr102497635e9.5.1742107326857;
        Sat, 15 Mar 2025 23:42:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc49adsm69623995e9.24.2025.03.15.23.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:42:05 -0700 (PDT)
Message-Id: <20c763f295105bda9a701b9bf5b9aa47af5bf1e1.1742107322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
	<pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Mar 2025 06:42:02 +0000
Subject: [PATCH v2 3/3] treewide: replace assert() with BUG_IF_NOT() in
 special cases
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When the compiler/linker cannot verify that an assert() invocation is
free of side effects for us (e.g. because the assertion includes some
kind of function call), replace the use of assert() with BUG_IF_NOT().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c   | 2 +-
 merge-ort.c         | 4 ++--
 merge-recursive.c   | 2 +-
 object-file.c       | 2 +-
 parallel-checkout.c | 2 +-
 scalar.c            | 4 ++--
 sequencer.c         | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 91b77993c78..1a945945fab 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1406,7 +1406,7 @@ void diffcore_rename_extended(struct diff_options *options,
 
 	trace2_region_enter("diff", "setup", options->repo);
 	info.setup = 0;
-	assert(!dir_rename_count || strmap_empty(dir_rename_count));
+	BUG_IF_NOT(!dir_rename_count || strmap_empty(dir_rename_count));
 	want_copies = (detect_rename == DIFF_DETECT_COPY);
 	if (dirs_removed && (break_idx || want_copies))
 		BUG("dirs_removed incompatible with break/copy detection");
diff --git a/merge-ort.c b/merge-ort.c
index 46e78c3ffa6..3db7a911f81 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -791,7 +791,7 @@ static void path_msg(struct merge_options *opt,
 	struct strbuf tmp = STRBUF_INIT;
 
 	/* Sanity checks */
-	assert(omittable_hint ==
+	BUG_IF_NOT(omittable_hint ==
 	       (!starts_with(type_short_descriptions[type], "CONFLICT") &&
 		!starts_with(type_short_descriptions[type], "ERROR")) ||
 	       type == CONFLICT_DIR_RENAME_SUGGESTED);
@@ -1642,7 +1642,7 @@ static int handle_deferred_entries(struct merge_options *opt,
 			ci = strmap_get(&opt->priv->paths, path);
 			VERIFY_CI(ci);
 
-			assert(renames->deferred[side].trivial_merges_okay &&
+			BUG_IF_NOT(renames->deferred[side].trivial_merges_okay &&
 			       !strset_contains(&renames->deferred[side].target_dirs,
 						path));
 			resolve_trivial_directory_merge(ci, side);
diff --git a/merge-recursive.c b/merge-recursive.c
index 884ccf99a58..ab888689ae4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1197,7 +1197,7 @@ static void print_commit(struct repository *repo, struct commit *commit)
 	struct pretty_print_context ctx = {0};
 	ctx.date_mode.type = DATE_NORMAL;
 	/* FIXME: Merge this with output_commit_title() */
-	assert(!merge_remote_util(commit));
+	BUG_IF_NOT(!merge_remote_util(commit));
 	repo_format_commit_message(repo, commit, " %h: %m %s", &sb, &ctx);
 	fprintf(stderr, "%s\n", sb.buf);
 	strbuf_release(&sb);
diff --git a/object-file.c b/object-file.c
index 726e41a0475..8ef4813eb63 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2706,7 +2706,7 @@ static int index_stream_convert_blob(struct index_state *istate,
 	struct strbuf sbuf = STRBUF_INIT;
 
 	assert(path);
-	assert(would_convert_to_git_filter_fd(istate, path));
+	BUG_IF_NOT(would_convert_to_git_filter_fd(istate, path));
 
 	convert_to_git_filter_fd(istate, path, fd, &sbuf,
 				 get_conv_flags(flags));
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 7cc6b305281..4d2fa6d7374 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -277,7 +277,7 @@ static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
 	ssize_t wrote;
 
 	/* Sanity check */
-	assert(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
+	BUG_IF_NOT(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
 
 	filter = get_stream_filter_ca(&pc_item->ca, &pc_item->ce->oid);
 	if (filter) {
diff --git a/scalar.c b/scalar.c
index da42b4be0cc..173286110ea 100644
--- a/scalar.c
+++ b/scalar.c
@@ -241,7 +241,7 @@ static int add_or_remove_enlistment(int add)
 
 static int start_fsmonitor_daemon(void)
 {
-	assert(have_fsmonitor_support());
+	BUG_IF_NOT(have_fsmonitor_support());
 
 	if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
 		return run_git("fsmonitor--daemon", "start", NULL);
@@ -251,7 +251,7 @@ static int start_fsmonitor_daemon(void)
 
 static int stop_fsmonitor_daemon(void)
 {
-	assert(have_fsmonitor_support());
+	BUG_IF_NOT(have_fsmonitor_support());
 
 	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
 		return run_git("fsmonitor--daemon", "stop", NULL);
diff --git a/sequencer.c b/sequencer.c
index ad0ab75c8d4..98a7657b398 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4965,7 +4965,7 @@ static int pick_commits(struct repository *r,
 
 	ctx->reflog_message = sequencer_reflog_action(opts);
 	if (opts->allow_ff)
-		assert(!(opts->signoff || opts->no_commit ||
+		BUG_IF_NOT(!(opts->signoff || opts->no_commit ||
 			 opts->record_origin || should_edit(opts) ||
 			 opts->committer_date_is_author_date ||
 			 opts->ignore_date));
-- 
gitgitgadget
