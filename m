Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A77C27C40
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbjHWVy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 17:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbjHWVx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 17:53:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AF010D2
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:53:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d630af4038fso7473773276.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692827635; x=1693432435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzIHnW3LwN1kbMJx76zgwCo1YtzUxZWHUl0Yzf0SPyI=;
        b=xpriQj7i0V7xxAzun9Ts5XJ3Dg1/HpC8vffVUy5BPvracHkPZdLq/QHmfyh4XHy2Ep
         e8dlsqS+jpKZHYThTmcesQIIlPRTZz5J51weuGeBnTVHFAh0O5KjgrfwtBJ8EQMaKvtf
         R3gbEwDv3oGxdAwFBbwkvqK2fSQ3rvUbrW2nsdAt5LGQQIoFIwhRBPXXwnkS2XIhy4n7
         xIPuKh6/h4RRNazSI3FCQ+rCf+d7rSV1VX0Z+aitAzar8d1YVIaz+jZLZNbsb9z6pcNE
         9Mr3KhltfyEwpY931kEu/cQlbF3YAIJ5Z8/WJ7CFR0dHkguGlNaMTyWfosCp0dpkccKh
         1gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692827635; x=1693432435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzIHnW3LwN1kbMJx76zgwCo1YtzUxZWHUl0Yzf0SPyI=;
        b=EjCJ5W4+d1BF2dTg5qQYE58qEyXpM8Of8X2TOzPtQ2S0bR0dR6mCpTzx+c+MgTyK5w
         YmYd9dzzaR523pW+tvQQs73DZOhK1Eisbiyu58E12E4HcC3/gO7Uk6YBKQZq/uiCYV5N
         EBzD/SaO3GE952eoYbnd21gt3It1gbzCwVjbMUKaoqPvuVXd7iFZ5/oy0vAxFnAw13QG
         5QQ8oy1Y1C0Q1MZ3vEIqb9rmgzLC12Rn35tOWS6IpADk//MwXYnHMvnLTKbI2e9B/7Gm
         arfolpPaYNZ77yovRpmDRvp6E5cps7htvUEIVk9HIOeX7BmPlMEF86FBKNZ6jDDt6/5v
         daWQ==
X-Gm-Message-State: AOJu0YzLvOgR/3pCpiSr4QXdZF93522Riw3HV/PQ2PHUdRVgRjNcN8XV
        zWNI3u5a9j0nGYsYzGYi5IOPlrsrz++Ff09jagNzO5gnoV/drPYdSJce14qxDG9O08bpjw8tiNh
        OZlWLEaT7cFoOEZwsLtqiRPo9PIAF+Ez3mfkFOWl9kd+jQS8JzWhCWT8SCrjT/eQ=
X-Google-Smtp-Source: AGHT+IEQCmA1l44zSfI1FO3PKaW9oNv9624L4yGVlETaoKN4OqBDADUt4tF93dkCstHUQJWP+G6gOvCHHJUARQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:83ba:288:9608:d4be])
 (user=steadmon job=sendgmr) by 2002:a5b:a11:0:b0:d77:e848:2afe with SMTP id
 k17-20020a5b0a11000000b00d77e8482afemr39276ybq.13.1692827635487; Wed, 23 Aug
 2023 14:53:55 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:53:48 -0700
In-Reply-To: <cover.1692827403.git.steadmon@google.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com> <cover.1692827403.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <5c676fbac370a2ba9d499ae2ef003e75b1d70081.1692827403.git.steadmon@google.com>
Subject: [PATCH v2 1/4] config: split out config_parse_options
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

"struct config_options" is a disjoint set of options options used by the
config parser (e.g. event listners) and options used by
config_with_options() (e.g. to handle includes, choose which config
files to parse). Split parser-only options into config_parse_options.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 bundle-uri.c |  2 +-
 config.c     | 14 +++++++-------
 config.h     | 37 ++++++++++++++++++++-----------------
 fsck.c       |  2 +-
 4 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 4b5c49b93d..f93ca6a486 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -237,7 +237,7 @@ int bundle_uri_parse_config_format(const char *uri,
 				   struct bundle_list *list)
 {
 	int result;
-	struct config_options opts = {
+	struct config_parse_options opts = {
 		.error_action = CONFIG_ERROR_ERROR,
 	};
 
diff --git a/config.c b/config.c
index 85c5f35132..1518f70fc2 100644
--- a/config.c
+++ b/config.c
@@ -982,7 +982,7 @@ static int get_base_var(struct config_source *cs, struct strbuf *name)
 struct parse_event_data {
 	enum config_event_t previous_type;
 	size_t previous_offset;
-	const struct config_options *opts;
+	const struct config_parse_options *opts;
 };
 
 static int do_event(struct config_source *cs, enum config_event_t type,
@@ -1030,7 +1030,7 @@ static void kvi_from_source(struct config_source *cs,
 
 static int git_parse_source(struct config_source *cs, config_fn_t fn,
 			    struct key_value_info *kvi, void *data,
-			    const struct config_options *opts)
+			    const struct config_parse_options *opts)
 {
 	int comment = 0;
 	size_t baselen = 0;
@@ -1967,7 +1967,7 @@ int git_default_config(const char *var, const char *value,
  */
 static int do_config_from(struct config_source *top, config_fn_t fn,
 			  void *data, enum config_scope scope,
-			  const struct config_options *opts)
+			  const struct config_parse_options *opts)
 {
 	struct key_value_info kvi = KVI_INIT;
 	int ret;
@@ -1992,7 +1992,7 @@ static int do_config_from_file(config_fn_t fn,
 			       const enum config_origin_type origin_type,
 			       const char *name, const char *path, FILE *f,
 			       void *data, enum config_scope scope,
-			       const struct config_options *opts)
+			       const struct config_parse_options *opts)
 {
 	struct config_source top = CONFIG_SOURCE_INIT;
 	int ret;
@@ -2021,7 +2021,7 @@ static int git_config_from_stdin(config_fn_t fn, void *data,
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 				      void *data, enum config_scope scope,
-				      const struct config_options *opts)
+				      const struct config_parse_options *opts)
 {
 	int ret = -1;
 	FILE *f;
@@ -2047,7 +2047,7 @@ int git_config_from_mem(config_fn_t fn,
 			const enum config_origin_type origin_type,
 			const char *name, const char *buf, size_t len,
 			void *data, enum config_scope scope,
-			const struct config_options *opts)
+			const struct config_parse_options *opts)
 {
 	struct config_source top = CONFIG_SOURCE_INIT;
 
@@ -3380,7 +3380,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		struct stat st;
 		size_t copy_begin, copy_end;
 		int i, new_line = 0;
-		struct config_options opts;
+		struct config_parse_options opts;
 
 		if (!value_pattern)
 			store.value_pattern = NULL;
diff --git a/config.h b/config.h
index 6332d74904..2537516446 100644
--- a/config.h
+++ b/config.h
@@ -85,6 +85,21 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 					struct config_source *cs,
 					void *event_fn_data);
 
+struct config_parse_options {
+	enum config_error_action {
+		CONFIG_ERROR_UNSET = 0, /* use source-specific default */
+		CONFIG_ERROR_DIE, /* die() on error */
+		CONFIG_ERROR_ERROR, /* error() on error, return -1 */
+		CONFIG_ERROR_SILENT, /* return -1 */
+	} error_action;
+	/*
+	 * event_fn and event_fn_data are for internal use only. Handles events
+	 * emitted by the config parser.
+	 */
+	config_parser_event_fn_t event_fn;
+	void *event_fn_data;
+};
+
 struct config_options {
 	unsigned int respect_includes : 1;
 	unsigned int ignore_repo : 1;
@@ -92,6 +107,9 @@ struct config_options {
 	unsigned int ignore_cmdline : 1;
 	unsigned int system_gently : 1;
 
+	const char *commondir;
+	const char *git_dir;
+	struct config_parse_options parse_options;
 	/*
 	 * For internal use. Include all includeif.hasremoteurl paths without
 	 * checking if the repo has that remote URL, and when doing so, verify
@@ -99,21 +117,6 @@ struct config_options {
 	 * themselves.
 	 */
 	unsigned int unconditional_remote_url : 1;
-
-	const char *commondir;
-	const char *git_dir;
-	/*
-	 * event_fn and event_fn_data are for internal use only. Handles events
-	 * emitted by the config parser.
-	 */
-	config_parser_event_fn_t event_fn;
-	void *event_fn_data;
-	enum config_error_action {
-		CONFIG_ERROR_UNSET = 0, /* use source-specific default */
-		CONFIG_ERROR_DIE, /* die() on error */
-		CONFIG_ERROR_ERROR, /* error() on error, return -1 */
-		CONFIG_ERROR_SILENT, /* return -1 */
-	} error_action;
 };
 
 /* Config source metadata for a given config key-value pair */
@@ -178,13 +181,13 @@ int git_config_from_file(config_fn_t fn, const char *, void *);
 
 int git_config_from_file_with_options(config_fn_t fn, const char *,
 				      void *, enum config_scope,
-				      const struct config_options *);
+				      const struct config_parse_options *);
 int git_config_from_mem(config_fn_t fn,
 			const enum config_origin_type,
 			const char *name,
 			const char *buf, size_t len,
 			void *data, enum config_scope scope,
-			const struct config_options *opts);
+			const struct config_parse_options *opts);
 int git_config_from_blob_oid(config_fn_t fn, const char *name,
 			     struct repository *repo,
 			     const struct object_id *oid, void *data,
diff --git a/fsck.c b/fsck.c
index 3be86616c5..522ee1c18a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1219,7 +1219,7 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		return 0;
 
 	if (oidset_contains(&options->gitmodules_found, oid)) {
-		struct config_options config_opts = { 0 };
+		struct config_parse_options config_opts = { 0 };
 		struct fsck_gitmodules_data data;
 
 		oidset_insert(&options->gitmodules_done, oid);
-- 
2.42.0.rc1.204.g551eb34607-goog

