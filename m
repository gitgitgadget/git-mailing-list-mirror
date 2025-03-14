Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD66125
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741911661; cv=none; b=aS7B/EYEpdhlYXswf/rJJuxgyyOEVT41aiMP8gcWyDyn7cAxvKu88T1h5dLinW14pFS5300UXH5mnv65hQUH+2RU3jgzjV6NO4PYi9beYbd/JO3TJZWU1DSnXHU9Cjwliy8cydqfDw3564v9sbVX+eZFjd7FDqiYu6A9KdhskRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741911661; c=relaxed/simple;
	bh=wRQMfDQaX62xU9Sa5VNd1pS6SPdoVx6yFQicuRK5kr8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LOVZ4JMIenRQjx6/2uNWDHQAlVDIEsiA4rP9PbAHV+UgwNIK38DmpzAnn/gkzLoNS392SJXHu+9G0xUTqqwWpyWiYtNS9L5vk+WQzXFjIw/sbSKOlhyxUE6CdBaJEQZBf4aeFN1vJLam5i1uP1OtfKH2q0vEDJzgZR8RxoxBZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U73TQEt5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U73TQEt5"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390fdaf2897so1358384f8f.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741911657; x=1742516457; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXA3TRQ/r5/vvweHdjLi9mt0grtT7hlGaEAEogCoozw=;
        b=U73TQEt58m4Vjl6OYZhwD6Nzg7n8t0lcN/ndo2bWp0WeZ5475mkSUSfcZWuLH+M95M
         kDDf6QyuZNvygOkndwqJg/Uvxs142n6gUQjkhAiFUqC25NGw0gSS5tjnc6k0+X6QSnuS
         cSql3MnHwoOmduJUiX1ya27k7bLwURaLe5zCKRzi/xvqJ1/yD2G2kHXzDF6h/T+vqs/d
         OunpSf/Cd/UIGgHtN5vSfzhLO0VTbo8wmNJnsbV+0NVE1ZA5UxYwV3oy271sLIeM2pEp
         Dcwb7FaxNP2zJlPvV42odCg5Bsz7KLCV7m0ssvZcSgBAr6yq3pLBaTGsSxDeFGHlqwah
         3QVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741911657; x=1742516457;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXA3TRQ/r5/vvweHdjLi9mt0grtT7hlGaEAEogCoozw=;
        b=r5jUih1mpp8Lm9+7MIMUfUs+nA06IwllmO3S0eTuUYX7gyn7NwwvyEDpI/ObbuBL2z
         W8FmTXgRcZNntCGLzecgygyG1sO5rZy5T+8jaw2Dr7BxYZjUC3y0hV7xCKG0xMyYxxIP
         C1lyGwTUQYjfkkRUbn189kCGEMpTn+locpT3xTi1ZFoUCpPa9YiYqg8FkjlhmQgywcNx
         MnGjCOHIsjViLC2KM8Rqon6Ugij6INSkBqdiHmgx/6xL4Y7hT7sdh9eA0+MlRqSi4mFa
         qinXazlBdM4U5vhZO2c0EWzee/d6V8faTfQhrFX1HK3xI2vTto7ji6o4KggDS1ARpKu3
         7i6A==
X-Gm-Message-State: AOJu0YwpJV+aplGfk8rKI9UNoFaK2vkEbz41qyO+PN0pGrVL8VEe3aCO
	8KjllmPc8doRgu5ZkZgtM2a3rrVUzQ/kUdm424btF4HyDWrXjbXsw5bXKw==
X-Gm-Gg: ASbGnctusS8iemZJUdXzjYU5Xi4T3rICp1jaosX9Ja0Z/1iewLdah9q4Fqc70tZpnEH
	NpZ3xUVqvgUf4hl6ipncfvvKa+xAyZHCpv6ehlc76kCB3qv1kOzfBDtFEfIiuWh+mliTkf+PFXf
	6lOBaDaEqCqkt6+qP1d1UfAY2G/8zt2RrE5yvaTCx1d4LNtquoLF7XMzGO6h39KLnf3NEQ9pOx6
	AwQzlnWsdo8h6l6mBJkXV2fft7rh41WnufqYCWD1ayo3P/zLGcqHprx3uFy0fysuUOOXaP+Z9rw
	AfTCi+3PflH5CIueBkI5I3fSfIlgT4f5PiO97sdZEPCh4w==
X-Google-Smtp-Source: AGHT+IH3kzH56eBuivmpXhqdBlx2CUCQDViDkN25M7tVYgTaVLF+Xp9vX2jlV/RHIVxTp00jBImIBw==
X-Received: by 2002:adf:a3c2:0:b0:390:e9e0:5cb3 with SMTP id ffacd0b85a97d-3971e2ad27dmr324114f8f.12.1741911657486;
        Thu, 13 Mar 2025 17:20:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb9c0sm3754939f8f.97.2025.03.13.17.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:20:56 -0700 (PDT)
Message-Id: <4c668039bb72e7e86ce08dc7b8e6c7f09673cee4.1741911652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Mar 2025 00:20:52 +0000
Subject: [PATCH 3/3] treewide: replace assert() with BUG_IF_NOT() in special
 cases
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
Cc: Elijah Newren <newren@gmail.com>,
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
