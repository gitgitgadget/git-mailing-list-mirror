Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D733A1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbfHOVll (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42064 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732991AbfHOVlf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id i30so1971927pfk.9
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knW+/MNFx0yQnE3xbC/qMmvWwOT1+0QBXlfhnbFsvvw=;
        b=BYq/uYyhl7e0iRIeNRUxfq+7JzALTRJMmkhDfaV2+2UK5Lf1DZZjgdxGBuQgsc7QCq
         RA0XAl59wDdfZKA9GjKFm2h76jALnHNAN13sMkab3OsceB8zeM4/7zML2650H/vyrPvh
         rAh7OehyMc+y6W1G1FfFR7NgWdmR85kay2dY68fqQQdOXGzHFwQaKjF5voMOsUgUc8rk
         4D7+NULfZ5ql0N4ZPY15YT0kbkD2f9CuukD7zUZ1SDEQc3+NeGItDzhXzhQBbU/N8UB7
         7whOGW4n+cMTWRW4pxLu4lpJ0OyCjGV19Mqp7DDmo+nELX8f3mWixBjq2fFyJyeWIQ2x
         txZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knW+/MNFx0yQnE3xbC/qMmvWwOT1+0QBXlfhnbFsvvw=;
        b=XZ2c9F0UPxVt98JRvbpJS/xuwRU+oUj6RQE3l6C+agsXRjGrJ29G4omMtni+TStFw+
         DfmR7mvEAEfa0ctGNtV06AOuaP0wYxhyfAmvluC6xC7MD65G1QdakzcfVlRFr35xzsbP
         4ORPZp4/6Yat3pYcMRrzCsXUA2lN5Vdp+wkI0QLQb1QPa3fmieweP8IOiy9Uw9mHaz2w
         Ua1F3tTXEo/qxaWTgXywFjg55x7xDbTNndX81LtEIgcMpAh000HCTzJOyBADvh/nHVYB
         Ed74EppQTqafnwekSTRUYPQFghDoDEzuNicHcO37W7Dg2j3LNTAunOYaweZPsd6hfLUv
         jfnA==
X-Gm-Message-State: APjAAAWnDTiL7ZcWfeKnfHyalh82ypFblqgogaM4B7sIzQBK9gbkihvl
        /qimAE8Dxy93ZOLPYDZTpi0f5Snu
X-Google-Smtp-Source: APXvYqyTn7s72ti2EOeWp2MLpWtyfDe1gWU7X2iC1v264/YNWF1VdmYUT2b8kL74kNWqEJhZJyiQIQ==
X-Received: by 2002:a63:b20f:: with SMTP id x15mr5186957pge.453.1565905294081;
        Thu, 15 Aug 2019 14:41:34 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:33 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 19/24] merge-recursive: comment and reorder the merge_options fields
Date:   Thu, 15 Aug 2019 14:40:48 -0700
Message-Id: <20190815214053.16594-20-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
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
 merge-recursive.h | 40 ++++++++++++++++++++++++++--------------
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b846acf931..db2c544d0b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3759,21 +3759,27 @@ void init_merge_options(struct merge_options *opt,
 {
 	const char *merge_verbosity;
 	memset(opt, 0, sizeof(struct merge_options));
+
 	opt->repo = repo;
+
+	opt->detect_renames = -1;
+	opt->detect_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
+	opt->rename_limit = -1;
+
 	opt->verbosity = 2;
 	opt->buffer_output = 1;
-	opt->rename_limit = -1;
+	strbuf_init(&opt->obuf, 0);
+
 	opt->renormalize = 0;
-	opt->detect_renames = -1;
-	opt->detect_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
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
index f4bdfbc897..9e040608fe 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -9,36 +9,48 @@ struct commit;
 struct repository;
 
 struct merge_options {
+	struct repository *repo;
+
+	/* ref names used in console messages and conflict markers */
 	const char *ancestor;
 	const char *branch1;
 	const char *branch2;
-	enum {
-		MERGE_RECURSIVE_NORMAL = 0,
-		MERGE_RECURSIVE_OURS,
-		MERGE_RECURSIVE_THEIRS
-	} recursive_variant;
-	const char *subtree_shift;
-	unsigned buffer_output; /* 1: output at end, 2: keep buffered */
-	unsigned renormalize : 1;
-	long xdl_opts;
-	int verbosity;
+
+	/* rename related options */
+	int detect_renames;
 	enum {
 		MERGE_DIRECTORY_RENAMES_NONE = 0,
 		MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
 		MERGE_DIRECTORY_RENAMES_TRUE = 2
 	} detect_directory_renames;
-	int detect_renames;
 	int rename_limit;
 	int rename_score;
-	int needed_rename_limit;
 	int show_rename_progress;
+
+	/* xdiff-related options (patience, ignore whitespace, ours/theirs) */
+	long xdl_opts;
+	enum {
+		MERGE_RECURSIVE_NORMAL = 0,
+		MERGE_RECURSIVE_OURS,
+		MERGE_RECURSIVE_THEIRS
+	} recursive_variant;
+
+	/* console output related options */
+	int verbosity;
+	unsigned buffer_output; /* 1: output at end, 2: keep buffered */
+	struct strbuf obuf;     /* output buffer */
+
+	/* miscellaneous control options */
+	const char *subtree_shift;
+	unsigned renormalize : 1;
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
2.23.0.rc2.32.g2123e9e4e4

