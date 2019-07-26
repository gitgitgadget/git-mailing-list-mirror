Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D231F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfGZPxW (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44413 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfGZPxV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so24976153pgl.11
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9QDbpvUfuAhsWqLbhNwyCSuBsrdxh9u9ZMASRXxN/vY=;
        b=OdFTyDRu/ACy/nFR8E23rKI3VsQkaxK7S5FIFAM/ug7Q0YDiP5SjS5ViblfFb8R+wL
         ftX3fWFlRHwfx+Lrq3CNNpiPJYCaNCSfdh+EiUWL522hFtKOdlXjqOdSU9VVBa4qf0SA
         OKvaAl+7vb3rleAmvOotwHyXM5H6/3MjUFqIUP81czSxScFaZOuddmB8dhrN9BIWWlYW
         Xztv+HODfnhCAOPn3RuAOW9iWODtTo8kV4l9vzjeIG+yefPQ+ANFSnTj725w9DkBnr+b
         tCc84WuRkzTAEMuusS6PK5VbOJftntZYAvudOiVApkfWV4WBFonFQv817bD3aR5L9sPR
         YRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9QDbpvUfuAhsWqLbhNwyCSuBsrdxh9u9ZMASRXxN/vY=;
        b=oLpmjaxKmOWFjWXAjJAvNQXw+L/U8rCF9oO9Vg9OU47s5maZj/kPzvbaMDzhMTZPub
         /U1zPcCeRZdefVKdz5sHiazQFb39ioV/HLic23vAjlQ4T/plG1aZry8aS5juFmad7s6n
         5vIzOR0k9obhpUq0ex10YrydNq9wvAP60yDz3D6nzLP2pbQ9ngPvjbDDafZ57zYMAKvR
         9gHpCaPXcV8GwatvaOjQe927JCMjj7UxT9sDaA3zEaCccqJBOp9Y0kNLfq94+2Ys4gez
         36Y4MiW4CgWGiPZmVJrsD8QkRi0wlNUxPHuq1BSwwsGsGrm1zj3+GPJwCJJQCSAD4wjw
         Ggcg==
X-Gm-Message-State: APjAAAU/n0wXbH8qh+tm3gxpMTVyk/9vzQ7ZkoSuZDdco0xT7+dPtd5a
        7wW9cI7R37oX+FH3b3D7X0IBhz0J
X-Google-Smtp-Source: APXvYqzAIBKkxAoJQiCiUGOEOpefhAv4yiq9qI7jRcdnYIi3fggfgkmB+nB1WmV/5DqPekmGNcUQbg==
X-Received: by 2002:aa7:9819:: with SMTP id e25mr22221934pfl.47.1564156400668;
        Fri, 26 Jul 2019 08:53:20 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:19 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 14/20] merge-recursive: comment and reorder the merge_options fields
Date:   Fri, 26 Jul 2019 08:52:52 -0700
Message-Id: <20190726155258.28561-15-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The merge_options struct had lots of fields, making it a little
imposing, but the options naturally fall into multiple different groups.
Grouping similar options and adding a comment or two makes it easier to
read, easier for new folks to figure out which options are related, and
thus easier for them to find the options they need.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 16 +++++++++++-----
 merge-recursive.h | 34 +++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index bafac63c45..a8e4a6a531 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3743,21 +3743,27 @@ void init_merge_options(struct merge_options *opt,
 {
 	const char *merge_verbosity;
 	memset(opt, 0, sizeof(struct merge_options));
+
 	opt->repo = repo;
+
+	opt->detect_renames = -1;
+	opt->detect_directory_renames = 1;
+	opt->rename_limit = -1;
+
 	opt->verbosity = 2;
 	opt->buffer_output = 1;
-	opt->rename_limit = -1;
+	strbuf_init(&opt->obuf, 0);
+
 	opt->renormalize = 0;
-	opt->detect_renames = -1;
-	opt->detect_directory_renames = 1;
+
+	string_list_init(&opt->df_conflict_file_set, 1);
+
 	merge_recursive_config(opt);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
 		opt->verbosity = strtol(merge_verbosity, NULL, 10);
 	if (opt->verbosity >= 5)
 		opt->buffer_output = 0;
-	strbuf_init(&opt->obuf, 0);
-	string_list_init(&opt->df_conflict_file_set, 1);
 }
 
 int parse_merge_opt(struct merge_options *opt, const char *s)
diff --git a/merge-recursive.h b/merge-recursive.h
index b92a9ebce7..b6d420960b 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -9,32 +9,44 @@ struct commit;
 struct repository;
 
 struct merge_options {
+	struct repository *repo;
+
+	/* ref names used in console messages and conflict markers */
 	const char *ancestor;
 	const char *branch1;
 	const char *branch2;
+
+	/* rename related options */
+	int detect_renames;
+	int detect_directory_renames;
+	int rename_limit;
+	int rename_score;
+	int show_rename_progress;
+
+	/* xdiff-related options (patience, ignore whitespace, ours/theirs) */
+	long xdl_opts;
 	enum {
 		MERGE_RECURSIVE_NORMAL = 0,
 		MERGE_RECURSIVE_OURS,
 		MERGE_RECURSIVE_THEIRS
 	} recursive_variant;
-	const char *subtree_shift;
+
+	/* console output related options */
+	int verbosity;
 	unsigned buffer_output; /* 1: output at end, 2: keep buffered */
+	struct strbuf obuf;     /* output buffer */
+
+	/* miscellaneous control options */
+	const char *subtree_shift;
 	unsigned renormalize : 1;
-	long xdl_opts;
-	int verbosity;
-	int detect_directory_renames;
-	int detect_renames;
-	int rename_limit;
-	int rename_score;
-	int needed_rename_limit;
-	int show_rename_progress;
+
+	/* internal fields used by the implementation (do NOT set these) */
 	int call_depth;
-	struct strbuf obuf;
+	int needed_rename_limit;
 	struct hashmap current_file_dir_set;
 	struct string_list df_conflict_file_set;
 	struct unpack_trees_options unpack_opts;
 	struct index_state orig_index;
-	struct repository *repo;
 };
 
 void init_merge_options(struct merge_options *opt, struct repository *repo);
-- 
2.22.0.550.g71c37a0928.dirty

