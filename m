Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39EEB2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934342AbcKOXG7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:06:59 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36132 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbcKOXG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:06:57 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so38563886pfz.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OD7TfS7D6gLEpWaGjHTfMkzBZw47ZjlUSoPWL68QFp0=;
        b=LT2jOb/zz/Vs8Ojg8rlswfJgIXJqNvB0cFZ5jYv2zYfC1djYEJc2WYWRb/3+/dQMXB
         t4fPdy6Wz6ffVRKfW0KsPwkuGEzky0bv1/vN3le9twtUCtQC0h+kEqE9cpBzX1i4eaXW
         kwG/a4Q+Ugkb9xSLFoPDTcetYUrqcKmFw2XdUbchZEkUNORGz/6sj4FQ7FqhRp/UGBcK
         t7Ylia52LsrDTwqzCO5DVJfezFFQ+W0U5IUZHSqn4BbLZA3s/HDRJu2mvQOEyO2PNHnE
         /3KBM9sdvNMGKnPxxzfqeBK4iXYiiWAUV28rGd02veXTjtAUtEA+QiKhIsn408cxs7hI
         lHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OD7TfS7D6gLEpWaGjHTfMkzBZw47ZjlUSoPWL68QFp0=;
        b=RLEeYthFct+jQ2Fdn7eCeYP3E2wyJNvltWyJIOGp+uEQP8qDytBlNGeolYy1FTVdq1
         Vr+WOyJqrydopRySleF3BhZAhXGeGPgPsFveugfokYJmahbgD+by5vdlzztIltaitqPy
         VLnq2hcCXA/8k0kOS6vUTNf2G+o+bcQvj17TpAbfhaf9XbnDwCX4WhtX4r0nphNwPHMs
         /QU17tn1ufzBgW+gYF3gpSlPi2Irnc9kKt4J6dI8P/jQaMaNu5oG2qvhTIQsZzlwDwcE
         T/p2Vq+Zcr2e4EzHbkDId4GIJU8P0WQ0rE+pXcR6dHHENDj1c8a/EsFwPVwMeLB6P3ne
         BNXw==
X-Gm-Message-State: ABUngvfpkjNJGbsG372hz5GaeufivrBzxphQQ7iHrkTgAGKsBKgNWpdlOSW73P+95cacGp6h
X-Received: by 10.99.146.76 with SMTP id s12mr1142168pgn.8.1479251216522;
        Tue, 15 Nov 2016 15:06:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id y89sm25244209pfk.83.2016.11.15.15.06.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:06:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/16] submodule.h: add extern keyword to functions, break line before 80
Date:   Tue, 15 Nov 2016 15:06:36 -0800
Message-Id: <20161115230651.23953-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the upcoming series will add a lot of functions to the submodule
header, it's good to start of a sane base. So format the header to
not exceed 80 characters a line and mark all functions to be extern.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.h | 60 ++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/submodule.h b/submodule.h
index d9e197a..afc58d0 100644
--- a/submodule.h
+++ b/submodule.h
@@ -29,50 +29,58 @@ struct submodule_update_strategy {
 };
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
-int is_staging_gitmodules_ok(void);
-int update_path_in_gitmodules(const char *oldpath, const char *newpath);
-int remove_path_from_gitmodules(const char *path);
-void stage_updated_gitmodules(void);
-void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
+extern int is_staging_gitmodules_ok(void);
+extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
+extern int remove_path_from_gitmodules(const char *path);
+extern void stage_updated_gitmodules(void);
+extern void set_diffopt_flags_from_submodule_config(
+		struct diff_options *diffopt,
 		const char *path);
-int submodule_config(const char *var, const char *value, void *cb);
-void gitmodules_config(void);
-int parse_submodule_update_strategy(const char *value,
+extern int submodule_config(const char *var, const char *value, void *cb);
+extern void gitmodules_config(void);
+extern int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
-const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
-void show_submodule_summary(FILE *f, const char *path,
+extern const char *submodule_strategy_to_string(
+		const struct submodule_update_strategy *s);
+extern void handle_ignore_submodules_arg(struct diff_options *diffopt,
+					 const char *);
+extern void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
-void show_submodule_inline_diff(FILE *f, const char *path,
+extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *line_prefix,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *opt);
-void set_config_fetch_recurse_submodules(int value);
-void check_for_new_submodule_commits(unsigned char new_sha1[20]);
-int fetch_populated_submodules(const struct argv_array *options,
+extern void set_config_fetch_recurse_submodules(int value);
+extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
+extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet, int max_parallel_jobs);
-unsigned is_submodule_modified(const char *path, int ignore_untracked);
-int submodule_uses_gitfile(const char *path);
-int ok_to_remove_submodule(const char *path);
-int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
-		    const unsigned char a[20], const unsigned char b[20], int search);
-int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
-		struct string_list *needs_pushing);
-int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
-void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
-int parallel_submodules(void);
+extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
+extern int submodule_uses_gitfile(const char *path);
+extern int ok_to_remove_submodule(const char *path);
+extern int merge_submodule(unsigned char result[20], const char *path,
+			   const unsigned char base[20],
+			   const unsigned char a[20],
+			   const unsigned char b[20], int search);
+extern int find_unpushed_submodules(unsigned char new_sha1[20],
+				    const char *remotes_name,
+				    struct string_list *needs_pushing);
+extern int push_unpushed_submodules(unsigned char new_sha1[20],
+				    const char *remotes_name);
+extern void connect_work_tree_and_git_dir(const char *work_tree,
+					  const char *git_dir);
+extern int parallel_submodules(void);
 
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific envirionment variables, but
  * retaining any config in the environment.
  */
-void prepare_submodule_repo_env(struct argv_array *out);
+extern void prepare_submodule_repo_env(struct argv_array *out);
 
 #endif
-- 
2.10.1.469.g00a8914

