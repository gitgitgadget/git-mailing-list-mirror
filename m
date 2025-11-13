Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198EF1A9F93
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057438; cv=none; b=KG+XAPimxTzirZN3Y9Kio2sXXzMRcT9PSV0Rndn7zVbPllUhhx2vj7iNjFGidY6n9lEdFJcEudC59rPdGbMm+vyLQ8FbDhZcwO/I2On/wHD8CeYuJOqCyfM+5HmdfiuTeEuNTPCbs+QtI90zOI+3iLNkYn+7SckEaLycib9YTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057438; c=relaxed/simple;
	bh=uSIi/+RuYChaDruMaa3vlYIGlr8ZjnXssjmN9TPcQ2Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mQGQWRmivGT5u5nOZIXg4IB/dmplJV9lYsOIKdwDP7xfGbUjD05X4V6TrugiMNqZPOGynrIS078AJ9ZgAFc164cRnTmdAMM8hG1DwzqWkXmYP7d+pDCy0KZtMNvfhx1xzVbCL7YJi9dm61Vev9Vmb7Ro2dldzQX9126ERkMfUUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG1kOgsU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG1kOgsU"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso1053132b3a.2
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763057436; x=1763662236; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCo6UP7ys4G9gfSw7fEynrjEwQtjCbf7RiaRizRsSts=;
        b=EG1kOgsUiVM9WmdCWvHkMBVEUSna5AmBLlW3u/sQlqDWAqv7rYKPya0q/Cf4Zz4T98
         ik4R7cJMKwG6EI5dlWcGOIfFHjWjaq8eCUcNAseOyPCoQyXV2XYlwHdBNfYzqBciGgdN
         f6NXe3QSlbJk2+WCDNaV3OlAWNE6TJ+BfInDkuqHn3qxhHwFsH1XZE/VLiHr8L9ZsiAZ
         1/TE+Km8nxMBjUo/WlW1H489G8lKv1bz0kXDVUK80AOkE0WLTEHLRMBxHh+4/go8WN+s
         9ronaLDXKStonJkdsr7MLxAhIfiwelgpmPGbYideIh9diXDmKzjCDHayYWy3p3H6CzZi
         5DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057436; x=1763662236;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CCo6UP7ys4G9gfSw7fEynrjEwQtjCbf7RiaRizRsSts=;
        b=c53H7FXG48w3qWgtUUEZrH5ynWLndF7/6uIEmpzUmFR/0HmY0GRx5leS61JHAm7mK2
         EFJ4ZgVLoS385dAnWFy11h0tXt1Gt9kc4HS3rmAETPYACQsLGYm5rWh6rWsxpcc64H+c
         +whynlL51y24LLBIzVXf2yKpad4Q3VFeOnZVjR8P0q4ZmXNnVVHdiQJVJ1YMprUpZhBB
         Y1MSkl1xfO6CQ6GV9XvgUYtXbziczOFJzYJS4NZ2gzLOEOti4H2/+ejAszZnCfhpIImT
         H/IUba5iqxOSbQbLmxe2ANYI8egK38EGEdGjU4UQbJwGWA5kKUklEycAAs4/zoCR0iaE
         JPIQ==
X-Gm-Message-State: AOJu0Yzz4iya9kZ8faojQJsNcV+7usLD+e/d4N+CN02g2I17OCKHuKj+
	8NYcfZP2LLFkNY1evWV1kWntn75x/Tq/2Cj6+7UQl0CFtbF3zZAtGZA4ZCsKbg==
X-Gm-Gg: ASbGncuyHFAlmOgN1HggLZcN0zGeNOoi/6eBNmVOjX1t/zEQt+Q4hkS9YJPOBO9t3AM
	mUTD6kQspfv6vhLFQDyTuZXbQbCpvuyORzjwi/IPqDHPWrw1mKGvKIQO/rfqGJRi//UxS9GWNno
	dd6anMyh7VwYkpLghDNN7LXomlP0OD5XHBVtpVk87f+lky0KQ26Welvt6+7mHetXV7srQNPYhWy
	998ru/swFFIxWJo1S/iaSTkiGNjbirPoLueiPGqj5z8wMS2jRG12MYy43mWt5DJRidWelQGnyNS
	/DxJsGIndRP6/KZ/OoqpUEvhmjrLKHWufymjvu9bdSIfOTo48G/cegMFeK/8xMHM3Jiq6fC/tG5
	ERnTBmnlPMx/7cqhgjaBqcYu1GcD3/yZ9QUeEj+iH8IMRV2478R4kWv6lJIWuNzMAa7DxL3pJtU
	PUOw==
X-Google-Smtp-Source: AGHT+IEobHWE54yxuBDEdbn2GvYelvwMhGPD+/bonUB/icegpqG7sHHBx6Uqhj/inIVqU4nLULYyhA==
X-Received: by 2002:a05:6a20:9155:b0:34f:c83b:b3ea with SMTP id adf61e73a8af0-35ba027de04mr587656637.18.1763057435888;
        Thu, 13 Nov 2025 10:10:35 -0800 (PST)
Received: from [127.0.0.1] ([104.209.7.211])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db21e76sm2809411a12.7.2025.11.13.10.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:10:35 -0800 (PST)
Message-Id: <5796009122c6ab573a2961db598bbd33727a6ac0.1763057433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
	<pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Nov 2025 18:10:29 +0000
Subject: [PATCH v2 1/5] read-cache: update add_files_to_cache take param
 include_ignored_submodules
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bmwill@google.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

The include_ignored_submodules parameter is added to the function
add_files_to_cache for usage of explicit updating the index for the updated
submodule using the explicit patchspec to the submodule.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 builtin/add.c      |  4 +++-
 builtin/checkout.c |  2 +-
 builtin/commit.c   |  2 +-
 read-cache-ll.h    |  2 +-
 read-cache.c       | 51 ++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0235854f80..6d11382f33 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -233,6 +233,7 @@ N_("The following paths are ignored by one of your .gitignore files:\n");
 static int verbose, show_only, ignored_too, refresh_only;
 static int ignore_add_errors, intent_to_add, ignore_missing;
 static int warn_on_embedded_repo = 1;
+static int include_ignored_submodules;
 
 #define ADDREMOVE_DEFAULT 1
 static int addremove = ADDREMOVE_DEFAULT;
@@ -271,6 +272,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
 	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
+    OPT_BOOL(0, "include-ignored-submodules", &include_ignored_submodules, N_("add submodules even if they has configuration ignore=all")),
 	OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
 		   N_("override the executable bit of the listed files")),
 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
@@ -582,7 +584,7 @@ int cmd_add(int argc,
 	else
 		exit_status |= add_files_to_cache(repo, prefix,
 						  &pathspec, ps_matched,
-						  include_sparse, flags);
+						  include_sparse, flags, include_ignored_submodules);
 
 	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
 	    report_path_error(ps_matched, &pathspec))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9453473fe..b2a404051d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -899,7 +899,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 */
 
 			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
-					   0);
+					   0, 0 );
 			init_ui_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_in_core_index_as_tree(the_repository);
diff --git a/builtin/commit.c b/builtin/commit.c
index b5b9608813..5bf7ae5fc1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -455,7 +455,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
-				   &pathspec, ps_matched, 0, 0);
+				   &pathspec, ps_matched, 0, 0, 0 );
 		if (!all && report_path_error(ps_matched, &pathspec))
 			exit(128);
 
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 71b49d9af4..2c8b4b21b1 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -481,7 +481,7 @@ int cmp_cache_name_compare(const void *a_, const void *b_);
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
-		       int include_sparse, int flags);
+		       int include_sparse, int flags, int ignored_too );
 
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
diff --git a/read-cache.c b/read-cache.c
index 06ad74db22..32f32bdb4c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3880,9 +3880,12 @@ void overlay_tree_on_index(struct index_state *istate,
 
 struct update_callback_data {
 	struct index_state *index;
+	struct repository *repo;
+	struct pathspec *pathspec;
 	int include_sparse;
 	int flags;
 	int add_errors;
+	int include_ignored_submodules;
 };
 
 static int fix_unmerged_status(struct diff_filepair *p,
@@ -3924,7 +3927,48 @@ static void update_callback(struct diff_queue_struct *q,
 		default:
 			die(_("unexpected diff status %c"), p->status);
 		case DIFF_STATUS_MODIFIED:
-		case DIFF_STATUS_TYPE_CHANGED:
+		case DIFF_STATUS_TYPE_CHANGED: {
+			struct stat st;
+			if (!lstat(path, &st) && S_ISDIR(st.st_mode)) { // only consider submodule if it is a directory
+				const struct submodule *sub = submodule_from_path(data->repo, null_oid(the_hash_algo), path);
+				if (sub && sub->name && sub->ignore && !strcmp(sub->ignore, "all")) {
+					int pathspec_matches = 0;
+					char *norm_pathspec = NULL;
+					int ps_i;
+					trace_printf("ignore=all %s\n", path);
+					trace_printf("pathspec %s\n",
+							(data->pathspec && data->pathspec->nr) ? "has pathspec" : "no pathspec");
+					/* Safely scan all pathspec items (q->nr may exceed pathspec->nr). */
+					if (data->pathspec) {
+						for (ps_i = 0; ps_i < data->pathspec->nr; ps_i++) {
+							const char *m = data->pathspec->items[ps_i].match;
+							if (!m)
+								continue;
+							norm_pathspec = xstrdup(m);
+							strip_dir_trailing_slashes(norm_pathspec);
+							if (!strcmp(path, norm_pathspec)) {
+								pathspec_matches = 1;
+								FREE_AND_NULL(norm_pathspec);
+								break;
+							}
+							FREE_AND_NULL(norm_pathspec);
+						}
+					}
+					if (pathspec_matches) {
+						if (data->include_ignored_submodules && data->include_ignored_submodules > 0) {
+							trace_printf("Add ignored=all submodule due to --include_ignored_submodules: %s\n", path);
+						} else {
+							printf(_("Skipping submodule due to ignore=all: %s"), path);
+							printf(_("Use --include_ignored_submodules, if you really want to add them.") );
+							continue;
+						}
+					} else {
+						/* No explicit pathspec match -> skip silently (or with trace). */
+						trace_printf("pathspec does not match %s\n", path);
+						continue;
+					}
+				}
+			}
 			if (add_file_to_index(data->index, path, data->flags)) {
 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
 					die(_("updating files failed"));
@@ -3945,7 +3989,7 @@ static void update_callback(struct diff_queue_struct *q,
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
-		       int include_sparse, int flags)
+		       int include_sparse, int flags, int include_ignored_submodules )
 {
 	struct update_callback_data data;
 	struct rev_info rev;
@@ -3954,6 +3998,9 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	data.index = repo->index;
 	data.include_sparse = include_sparse;
 	data.flags = flags;
+	data.repo = repo;
+	data.include_ignored_submodules = include_ignored_submodules;
+	data.pathspec = (struct pathspec *)pathspec;
 
 	repo_init_revisions(repo, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
-- 
gitgitgadget

