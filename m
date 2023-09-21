Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE0BE7D0AE
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 21:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjIUVkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjIUVjz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 17:39:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C84659C
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:17:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81503de9c9so1830928276.3
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695331048; x=1695935848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xVuWW6EObRI/np9K8ufVTzo2sCqTpDUmXNFLbqi639U=;
        b=hrCDZ2I4Z/hcxO/rZy9oLRxYYj8mcfOmkqSiXA1+W6HVWGyMGwGW5jHrUYtGiWdMg1
         g41DnohNDB7sg444FrBgU4NNRzcVI4MBToz8xNpG/fXNdS3i/BCC8g/7c5zolgVEBRhx
         5UNmjlff9jJCU7j3QkfO8/6A/+XGy12Qqbncd53ObFE4+xwVnEMJcnoKuiByjFujkxUv
         2H2ue+2NnNtm9yTpLc1Cw850Ldb1zpbOTOCwXZwfdulB5uJCwJdkDd6b5h1li5Sre3gm
         3g1Prmpg7ZQQBPxwObc9zZy7ZlF8Je+Ay3lj0IR+W+A+/R171GyFShS/ytozt/+U6tJm
         7ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695331048; x=1695935848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVuWW6EObRI/np9K8ufVTzo2sCqTpDUmXNFLbqi639U=;
        b=Rl//qXj028G8+49qWrR7BAXMQGrQ2X8abbdOl19otbaIGaFfaM8Q4lASFvKAhE9amR
         BWLgiR+To5GcG6snZqUM+4vpgaZeBtAwuYjRxVlhQBm1wP0Sr1qDa/cPjRnMn3GExP6t
         ywyRvp2NmFH0nF9S3F+35e/lULPXbtx5DN9iE83tU2tVIxBreurlNhBg47DQLS6+h9RH
         osA80kCLHQM9mdVP8YTshFX9kMNCxuccPepJn/qrNuB+RI6vsV1ej5XpqBPtQIVKFBYo
         u401GJ6sNtmdsXG2tgPhvy0uHInapsKtQ8JJwGKPq2UXngYvCnlUcWHnMOPZNKcne1V3
         kZxg==
X-Gm-Message-State: AOJu0YzRB7E7BtFtpAN/hPoHaSzHrSyaM/Sp/Hby37OXu1odS0vPos/q
        I2sKMd3AlKrkfe5wvJHTpxRO0NIpLYTc2EsYN5Jo22GyeCTnNR8fGYuxDksz+3QHG8n6mBi4ylT
        iAZnQUsI/4DgrXrhS0JtyGej/fcd6qkNJCgwmBko1YG60eGmFxmJNX9JSFwKElcE=
X-Google-Smtp-Source: AGHT+IEqoheuVCbDmKUNBngwCGhYpNrlJKUJxn8N4qwsQ9a9mJ3u83xsFB34OJjEhPdQ1HT+SSN7ySlBaYkPoA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:828c:91e1:20c5:c8f])
 (user=steadmon job=sendgmr) by 2002:a25:5053:0:b0:d7f:8e0a:4b3f with SMTP id
 e80-20020a255053000000b00d7f8e0a4b3fmr86900ybb.3.1695331048677; Thu, 21 Sep
 2023 14:17:28 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:17:20 -0700
In-Reply-To: <cover.1695330852.git.steadmon@google.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com> <cover.1695330852.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <fa55b7836f112cb7c7ab9b80e745b9969421c768.1695330852.git.steadmon@google.com>
Subject: [PATCH v3 1/5] config: split out config_parse_options
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

"struct config_options" is a disjoint set of options used by the config
parser (e.g. event listeners) and options used by config_with_options()
(e.g. to handle includes, choose which config files to parse). Split
parser-only options into config_parse_options.

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
2.42.0.515.g380fc7ccd1-goog

