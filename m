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
	by dcvr.yhbt.net (Postfix) with ESMTP id 637F41F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHQSm1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41491 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfHQSmU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id 196so4805179pfz.8
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jcv0PXbPMTi5vCUZzskmH3oSjqL1OIJiC1N5z1hG800=;
        b=Ty2vEYrZ+aVc8YSjwILvZQGb+R9hue+x3GFbAkaWi/CQIzr9D6aH3eosbGFKYJgG8w
         kfMeyccxBtPaQNZR7KFmVPPkLYhPwI5XwhL9oADj4GLGqB5MyWk0ueUdoHXR2Tzohk7U
         zf1vZRjeamr6oLdYoHNgQo8iO2aUZXxgp+jAXEYuiY4r4BK2UjOtLj8e6/CZG+Ix8j8+
         lLgQUhb3JZCmz3gUrq1PP/FspVdHu7O/hkdXbxwzhGI5t3sHwz//7/0zb091IlmXTYTJ
         WmGFRc6G73qraPEqaVKrwehWwiRkZ5AYF/CwUWmEHEO8CJ1bK/xlkV31AbT55a7lfCW9
         iyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jcv0PXbPMTi5vCUZzskmH3oSjqL1OIJiC1N5z1hG800=;
        b=fXd10PC9T/Uckj83noxM1yJ16xXG9J511BAP0EOOalKIrOWhhqF/NP9Sqa29ZjLWth
         BVuMSjyX7JacOUSDefPiWr7s4pJZU3uDm346GOrS07DPL9qcNFpYDteKlr7qKnXENPAW
         oXRtzZLNE6QFK5M0j8GECJXBOKj0go88oo7WWyAX0Y5g7n+4mSLJSVpaMGqadMNJ1qSL
         SUvmD/Y+s2pwRUattPKxMGoBjLBShKyvY365opSdfoReimjM39VCQGTePmWheXUZz8Vo
         JJWlT+XRHDUAc/2VtBZ0dNAdfev/wBBlI0Ry5qAMibTYhBZ4yj2uaBligzDVVj+EVqWT
         vNRQ==
X-Gm-Message-State: APjAAAUulgAwRZZ85Sv45tu7vcRrR4N52Ffb9ZLVg/VdscY+IFW53han
        KPEhGsbS+zK0mLGO9XFQdyxfVkQX
X-Google-Smtp-Source: APXvYqwuBJVAdUT6ac0ThinHHwyTUFOVss1dKZNENa4IHPdLNqDE0bMu2X6I3sykR2uG8lPOedGzDg==
X-Received: by 2002:a65:68c9:: with SMTP id k9mr12709073pgt.17.1566067339671;
        Sat, 17 Aug 2019 11:42:19 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:19 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 19/24] merge-recursive: comment and reorder the merge_options fields
Date:   Sat, 17 Aug 2019 11:41:39 -0700
Message-Id: <20190817184144.32179-20-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
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
index 0f0b952c04..43dec3307e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3754,21 +3754,27 @@ void init_merge_options(struct merge_options *opt,
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
2.23.0.rc2.28.g5f89f15d7b.dirty

