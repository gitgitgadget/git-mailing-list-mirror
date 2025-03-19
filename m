Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424B1DE899
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401389; cv=none; b=TzC1P65W5OpV/T2519T0Df2gq2YUARX5Xi4TquR3jqmqJHFbxsKLmAV0SIEOkPp+hoj5G0UYDxh6BJeOQjgfq7jcvAIFh5mS/U6Vm7Fl70knmZ6HEk0PjaEZ7lO9kmRn8Nd6++3Cw0QMfxGsMPx295lM7173C7TCC8IlUHLsz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401389; c=relaxed/simple;
	bh=YVZFzR3dKVWMqES2NpgKlbkEcmusLBVuETQIaOnDPRA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nJ5FBrPX4J8aK96YutgwoQV+U46H7W8tpSIMh39dl5mwRCzJS+pwmtBq9DGgCDvfc25vwO7PvVCm2099FxUXrFgR++xL2MW/RW2xzzEF4zQtDfWTlMST6UpG+py12UOUplSZHEMUNviPgcvKNP/zxmmahL1dPAl8uiBmCRItEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrlNN8n1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrlNN8n1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394036c0efso32678105e9.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742401385; x=1743006185; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+eWmg0Jz0GvTE1+SGJ310xtv9n2uZ+rCyE9T0C8NhU=;
        b=XrlNN8n1ZOWR0GbM1ZwNGuGlTHXRPIY3JJNHtmBM1qtmj+e4rVY0WVku7RK/5iXdkK
         lDMteX8n52nht+RutAqwtg5Rx+Ez1/1DXeIdQi1BkDox991DQa8l8uRfKzTUbPSuQt/Y
         s9JmeWv1qSBRfAj5v6fEHmau1xLzcHKNYRkCx8fgex9JvLY8YRML5jLKv+E61dRYAjli
         MYqqGJ/0JxM1t1rlctb1qTmnbdjYgJXkLzUFhXq7S1sI9sUa3JBLdVWgPdZu1rIgpTJD
         V9myBkb32KPxtRWiZCJIcwgxWB34zOWUUB5/RFU2ywiwaENDLP+df3NUwg25Squ7PKbL
         yzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401385; x=1743006185;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+eWmg0Jz0GvTE1+SGJ310xtv9n2uZ+rCyE9T0C8NhU=;
        b=o7/L0T/y7xaMER9+aYCu0SseFgO2P9/Rtt3Ml2qcp5vDcpBYRHxZasVzHnrssfogTX
         Fc78YVwsDc1ODaeJ+mpDvagrg885tFGQdP14ItREp5iQCtLuBlhM+Cx/WTT5+N+3DeWL
         K4ygkfcNzYMHWZBTuZ9m1Ez8dR+36cg44Bwqwsm5nnr7GZpWPS2se5yu7LypQkLUkEfI
         Xzs54ymg/PTXNq2xM3vwXj9BloBMFw1A7AWXPLN591wCwfv/15bnjBbQ+BCDL8kM9Vs3
         +3iaVYqTkwXuXtLNMTZHWq7V3ITVFmyOoY/efubi9XkPlII9i0dqJozii0VswF8+9BEd
         9bHw==
X-Gm-Message-State: AOJu0Ywe6MgXqj7644ugqCfOYodbXics9CqWHo0w0lKj5vSGnK+T14rT
	1bl8mzvq8cWUQ3THkOU1nndOi9RGDA9ZkCAm1fP3CE/6J6SLFTrQDXntLA==
X-Gm-Gg: ASbGncvLIN4X4T9VdVGdQpHx/dOHfXmwmEezoBit7G6H04cjfJWs/m3Vu5GVAx1muH8
	ibyES7f9rWgynbzan2krhP/Ms4lWvo0sLcYIPA+iTnNmt3rXooI4B+qgyCYSUkMeH4yf78yVeOv
	AqxEHoGi28DCQBiKQdQL3Pc/XJixlYqoT0lLIaHZyty0nqxr9FCW94/H10gJQyZw1tLHN+oCx51
	f0eiC886kZ8vmNqYs4feMvml7LblTWFKHV33ILSjcIT+Ka/aESO6zc1W3hoaWlclnTGIRCIdIb0
	t+hPox3tG9tqW7ThTKt8lxECBQa+dF6AlWXuz7+MPzlDcg==
X-Google-Smtp-Source: AGHT+IFW/I5E1/W7WlO93b7JVmQxVEGNdogwZQLCDkPF25kBi6JtkZWB/ZdWTvM6r0x7CX8xfQPVeA==
X-Received: by 2002:a05:600c:138c:b0:43d:db5:7af8 with SMTP id 5b1f17b1804b1-43d438052fdmr25023735e9.21.1742401384968;
        Wed, 19 Mar 2025 09:23:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f58a66sm23061205e9.20.2025.03.19.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:23:04 -0700 (PDT)
Message-Id: <82b7344e96683efdac5dfc559a023d81ea0084d0.1742401378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1881.v3.git.1742401378.gitgitgadget@gmail.com>
References: <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
	<pull.1881.v3.git.1742401378.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Mar 2025 16:22:58 +0000
Subject: [PATCH v3 3/3] treewide: replace assert() with ASSERT() in special
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Elijah Newren <newren@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When the compiler/linker cannot verify that an assert() invocation is
free of side effects for us (e.g. because the assertion includes some
kind of function call), replace the use of assert() with ASSERT().

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
index 91b77993c78..624304f0416 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1406,7 +1406,7 @@ void diffcore_rename_extended(struct diff_options *options,
 
 	trace2_region_enter("diff", "setup", options->repo);
 	info.setup = 0;
-	assert(!dir_rename_count || strmap_empty(dir_rename_count));
+	ASSERT(!dir_rename_count || strmap_empty(dir_rename_count));
 	want_copies = (detect_rename == DIFF_DETECT_COPY);
 	if (dirs_removed && (break_idx || want_copies))
 		BUG("dirs_removed incompatible with break/copy detection");
diff --git a/merge-ort.c b/merge-ort.c
index 46e78c3ffa6..d484f16cf2b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -791,7 +791,7 @@ static void path_msg(struct merge_options *opt,
 	struct strbuf tmp = STRBUF_INIT;
 
 	/* Sanity checks */
-	assert(omittable_hint ==
+	ASSERT(omittable_hint ==
 	       (!starts_with(type_short_descriptions[type], "CONFLICT") &&
 		!starts_with(type_short_descriptions[type], "ERROR")) ||
 	       type == CONFLICT_DIR_RENAME_SUGGESTED);
@@ -1642,7 +1642,7 @@ static int handle_deferred_entries(struct merge_options *opt,
 			ci = strmap_get(&opt->priv->paths, path);
 			VERIFY_CI(ci);
 
-			assert(renames->deferred[side].trivial_merges_okay &&
+			ASSERT(renames->deferred[side].trivial_merges_okay &&
 			       !strset_contains(&renames->deferred[side].target_dirs,
 						path));
 			resolve_trivial_directory_merge(ci, side);
diff --git a/merge-recursive.c b/merge-recursive.c
index 884ccf99a58..4fbbece922c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1197,7 +1197,7 @@ static void print_commit(struct repository *repo, struct commit *commit)
 	struct pretty_print_context ctx = {0};
 	ctx.date_mode.type = DATE_NORMAL;
 	/* FIXME: Merge this with output_commit_title() */
-	assert(!merge_remote_util(commit));
+	ASSERT(!merge_remote_util(commit));
 	repo_format_commit_message(repo, commit, " %h: %m %s", &sb, &ctx);
 	fprintf(stderr, "%s\n", sb.buf);
 	strbuf_release(&sb);
diff --git a/object-file.c b/object-file.c
index 726e41a0475..4fb3cd9dcb9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2706,7 +2706,7 @@ static int index_stream_convert_blob(struct index_state *istate,
 	struct strbuf sbuf = STRBUF_INIT;
 
 	assert(path);
-	assert(would_convert_to_git_filter_fd(istate, path));
+	ASSERT(would_convert_to_git_filter_fd(istate, path));
 
 	convert_to_git_filter_fd(istate, path, fd, &sbuf,
 				 get_conv_flags(flags));
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 7cc6b305281..57c2dcaa8f6 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -277,7 +277,7 @@ static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
 	ssize_t wrote;
 
 	/* Sanity check */
-	assert(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
+	ASSERT(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
 
 	filter = get_stream_filter_ca(&pc_item->ca, &pc_item->ce->oid);
 	if (filter) {
diff --git a/scalar.c b/scalar.c
index da42b4be0cc..d359f08bb8e 100644
--- a/scalar.c
+++ b/scalar.c
@@ -241,7 +241,7 @@ static int add_or_remove_enlistment(int add)
 
 static int start_fsmonitor_daemon(void)
 {
-	assert(have_fsmonitor_support());
+	ASSERT(have_fsmonitor_support());
 
 	if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
 		return run_git("fsmonitor--daemon", "start", NULL);
@@ -251,7 +251,7 @@ static int start_fsmonitor_daemon(void)
 
 static int stop_fsmonitor_daemon(void)
 {
-	assert(have_fsmonitor_support());
+	ASSERT(have_fsmonitor_support());
 
 	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
 		return run_git("fsmonitor--daemon", "stop", NULL);
diff --git a/sequencer.c b/sequencer.c
index ad0ab75c8d4..c625a39111e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4965,7 +4965,7 @@ static int pick_commits(struct repository *r,
 
 	ctx->reflog_message = sequencer_reflog_action(opts);
 	if (opts->allow_ff)
-		assert(!(opts->signoff || opts->no_commit ||
+		ASSERT(!(opts->signoff || opts->no_commit ||
 			 opts->record_origin || should_edit(opts) ||
 			 opts->committer_date_is_author_date ||
 			 opts->ignore_date));
-- 
gitgitgadget
