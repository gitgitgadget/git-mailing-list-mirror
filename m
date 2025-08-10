Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F61A314B
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754869580; cv=none; b=dnaIABjYEVQbrZKOn8GcntSiyQeKhPWR3tu4u62vWVXO0WSXnmtANpgEJnYI5kUPUfxu8vVdUZHpH8w0aD7AYsbIcpCtmsLnNy4QOlOtp3q7yNjf1xGnzeCRsDHiz1tSLrQAT1XTIch1A0UAb0udK8FbBUyQR6NOmY2prI/0wAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754869580; c=relaxed/simple;
	bh=/wCRl+4rsbLwxzPzUQG+wFL+16KaF81DFcd4c3zFC3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkOt+QpFm/eCTgBDfA/WLY4bFrcX9ydYKWRqTCWsfh3KiKKBP6q8JOIslzXMYF5/iYAesZPxtexMwmleH619bBSG8YyTZG4eDhbMRj/CATdFQaZpzDjYzyvRPiHU7Ps0wdGU14A51k3LPu7bMlhxjFgWAq6S6u71wMrV0J0k+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0f7pPl6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0f7pPl6"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74264d1832eso4510152b3a.0
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 16:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754869578; x=1755474378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqmccDNpWdMskMgBXA6dyL8uD4Pq1aGTLKzD8ilfCQc=;
        b=W0f7pPl6QQlXOO+Z2SMLSCSruJhHYB1J6/VNjnFgB32E+ajFSqvykLOggroEi3fhQ6
         b7qEqA3bCQ+Zs/Kucb62yATXui2gwl7LdkP3mLLebFQ8d3uqcubWc9V+Lt5iodKCuPd4
         4T96cIXjm56/9l348XiKAYiyRw56B1izLkbVA8omt8KLxV7xbLbUxVeocUdg3DxoOgAD
         h1Ub8iT1wNIoqLSC6ipYsLACk6orO5T0op3XqtX4o0oEmNs925iWiTaRHDlUM54DM2RR
         cCzZ0vKOMVQYVoq8pSUUjBZErcWsORoAfIIC/IRdIMwrUt3sexEylpprB4UGADSZl9n5
         B2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754869578; x=1755474378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqmccDNpWdMskMgBXA6dyL8uD4Pq1aGTLKzD8ilfCQc=;
        b=VX+CqMRi/WOdo2QJQu2GVVtR5PgN6aD5oiS6yIGSij7Qvnd97BQUif7/ekynXB1wuo
         8yfRGuVk1JAYfgSZJYDEJ+SaqMbyKDR2ACUjih1E6oYKRux7qgygVMX7y2z5qkJNdMdW
         eNFYI53Kb4aeZWREoPNKNQOx+SpRi4rvZ5ldfar5ujWMR9I/XI6Xnyrdn+RmoD8vQEXO
         iPR22FpXVcUoFI0dI8d+p7Sg9MW28okXDeGolfG9U9NO5HYLJb4OHuTksNJlhYIEG/Ly
         +dj/UTwLMdOmu6D98+Ky0bTLEPQSPdXtVmDZCEEtpGJM2BtkTMxuYA92qb0oN+R5HPsb
         t3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWIeuoiXrZA9jkTVAyRDCrIPCXGwNIHxgalo8sAZm1Jq3JcS4Yu59cyQLf7UesRxvuA07U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXutIbqqUOCMGUSuOrVyWB5y/zieS/5+nh5s73B5tYJukaslO
	mO4cQuQsA+gchKXrBqMirLjNkjVKrWCB+rxx4Q1nio7Jpla+l83J1nqDeuJVVqmu
X-Gm-Gg: ASbGncvp/7Th8Y2xZsRcQKPqZYYp3oP0lrheVh7+FVpuSUWU+HxChLg5eUA0719HjSw
	ypJptjhcXBG6kba22XRvAc08IbgKEr6rSMxco/Eh9V2yODp4wqVKzCx2brvqVtWvHbTRA/cfWzb
	8nbDM/rSSVM/cVnjyL7ESyhDntaxollVsuyGxxoNnPrFRpYq1olNsL8aSzYao/qg8NkslDUlDF6
	kas4LPjp1aXmy1x/C9dZ6PtkD2UMK1cPHJb1DSMmQTTON1IFDpPwvnJ9/y4FnYXLfAtTNDpc/ao
	qUaGIKpTYSJaHTkPEVC/RzUzO73Z4jcnzExYn9F/WsfqetJ0bArRNGrNfYmmVseekVsHlLv99wL
	IEF0iaV1p/ODcnEh6VIrMtno6COUOSlr6bsYPLD3MwvamgBro9KMvH8E=
X-Google-Smtp-Source: AGHT+IHLFl6QfvV5ZCX/GJzJT/eLFiSiLZLAsS8KmPxgdSYvQjeqGolIAtybRCAd8x1ACrupgrWjnw==
X-Received: by 2002:a05:6a20:12c4:b0:23d:6a77:78c9 with SMTP id adf61e73a8af0-24055029961mr18685014637.7.1754869578009;
        Sun, 10 Aug 2025 16:46:18 -0700 (PDT)
Received: from thinku.tailbd49c4.ts.net ([103.37.200.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102b9022fsm12349173a91.4.2025.08.10.16.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 16:46:17 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com
Subject: [GSOC PATCH v2 1/2] environment: remove the global variable 'merge_log_config'
Date: Mon, 11 Aug 2025 05:15:45 +0530
Message-ID: <3aa014ed46d14e31ea0c2f6b7631e7e4cbbd3943.1754868681.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754868681.git.ayu.chandekar@gmail.com>
References: <cover.1754868681.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable 'merge_log_config', set via the "merge.log" or
"merge.summary" settings, is only used in 'cmd_fmt_merge_msg()' and
'cmd_merge()' to adjust the 'shortlog_len' variable.

Remove 'merge_log_config' globally and localize it in
'cmd_fmt_merge_msg()' and 'cmd_merge()'. Set its value by passing it in
'fmt_merge_msg_config()' by passing its pointer to the function via the
callback parameter.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/fmt-merge-msg.c |  3 ++-
 builtin/merge.c         |  3 ++-
 environment.c           |  1 -
 fmt-merge-msg.c         | 10 ++++++----
 fmt-merge-msg.h         |  1 -
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3b6aac2cf7..4b24de32fb 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -19,6 +19,7 @@ int cmd_fmt_merge_msg(int argc,
 	const char *message = NULL;
 	char *into_name = NULL;
 	int shortlog_len = -1;
+	int merge_log_config = -1;
 	struct option options[] = {
 		{
 			.type = OPTION_INTEGER,
@@ -53,7 +54,7 @@ int cmd_fmt_merge_msg(int argc,
 	int ret;
 	struct fmt_merge_msg_opts opts;
 
-	git_config(fmt_merge_msg_config, NULL);
+	git_config(fmt_merge_msg_config, &merge_log_config);
 	argc = parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
 			     0);
 	if (argc > 0)
diff --git a/builtin/merge.c b/builtin/merge.c
index 18b22c0a26..c2089b5e6f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1374,6 +1374,7 @@ int cmd_merge(int argc,
 	struct commit_list *remoteheads = NULL, *p;
 	void *branch_to_free;
 	int orig_argc = argc;
+	int merge_log_config = -1;
 
 	show_usage_with_options_if_asked(argc, argv,
 					 builtin_merge_usage, builtin_merge_options);
@@ -1392,7 +1393,7 @@ int cmd_merge(int argc,
 		skip_prefix(branch, "refs/heads/", &branch);
 
 	init_diff_ui_defaults();
-	git_config(git_merge_config, NULL);
+	git_config(git_merge_config, &merge_log_config);
 
 	if (!branch || is_null_oid(&head_oid))
 		head_commit = NULL;
diff --git a/environment.c b/environment.c
index 7c2480b22e..6751aa5683 100644
--- a/environment.c
+++ b/environment.c
@@ -66,7 +66,6 @@ int grafts_keep_true_parents;
 int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
-int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
 int max_allowed_tree_depth =
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 40174efa3d..c9085edc40 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -26,13 +26,15 @@ static struct string_list suppress_dest_patterns = STRING_LIST_INIT_DUP;
 int fmt_merge_msg_config(const char *key, const char *value,
 			 const struct config_context *ctx, void *cb)
 {
+	int *merge_log_config = cb;
+
 	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
 		int is_bool;
-		merge_log_config = git_config_bool_or_int(key, value, ctx->kvi, &is_bool);
-		if (!is_bool && merge_log_config < 0)
+		*merge_log_config = git_config_bool_or_int(key, value, ctx->kvi, &is_bool);
+		if (!is_bool && *merge_log_config < 0)
 			return error("%s: negative length %s", key, value);
-		if (is_bool && merge_log_config)
-			merge_log_config = DEFAULT_MERGE_LOG_LEN;
+		if (is_bool && *merge_log_config)
+			*merge_log_config = DEFAULT_MERGE_LOG_LEN;
 	} else if (!strcmp(key, "merge.branchdesc")) {
 		use_branch_desc = git_config_bool(key, value);
 	} else if (!strcmp(key, "merge.suppressdest")) {
diff --git a/fmt-merge-msg.h b/fmt-merge-msg.h
index 73ca3e4465..c066d83761 100644
--- a/fmt-merge-msg.h
+++ b/fmt-merge-msg.h
@@ -12,7 +12,6 @@ struct fmt_merge_msg_opts {
 	const char *into_name;
 };
 
-extern int merge_log_config;
 int fmt_merge_msg_config(const char *key, const char *value,
 			 const struct config_context *ctx, void *cb);
 int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
-- 
2.49.0

