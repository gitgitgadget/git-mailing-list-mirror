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
	by dcvr.yhbt.net (Postfix) with ESMTP id 153A61F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403859AbfGYRql (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41164 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403819AbfGYRqa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so13052607pgg.8
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G10c1w06uQnqmylTjKG3KM9E0KPRforP1yuDiNluXYg=;
        b=Xm0Pu0vFbPGhuaP1p2yIa1KjyVzLQUPKYJHqnTdRmpWJxEoiS5pJTxDFQrrJRALpev
         hYcrxoHM7G8zC/1hMI7PCsymhxFqZRe4ym5doaRnJhVz6BNYphdpAp3UoJN8QYYaqJH7
         3gRpYP4Dwvx6T26AwNkw4zB+v0FgPmYxD2FqqCS/KWJzjY/4QykpUkH/dhubaMG+az0t
         sejlqqLR74FTsnxIt5hruq262/b39MPj/e6MX8ppZa3Da8ZAsHqSUbWQI9CrUhQYKcjd
         vll6i09id8MsS1XMILb4fW1ICKXQro8duz3ol45rxjA7pzI3eJf332fpn6HWDTUeW+OH
         gyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G10c1w06uQnqmylTjKG3KM9E0KPRforP1yuDiNluXYg=;
        b=O4jWWU7kb/9061UwHFxBV9o5QF8l8XtUjNkJNaPObP0REzrt2e/FcCru7L47sMoM3D
         HhVgbIpAURZqtxSuEtqavv+WKDk7fm1x+bfAXe2SCILrqyFe9aCJTNKPABYatrQ7iCTz
         gG8ZrBOWJZwoh0245XDHRUJ+p82QUiJKoicjoEdI3LdYxmiepDAOhV0X2LtnMQh64wDy
         HHE3mxmgmlpc7c0FyCGniErY/+MI+/C0T0hWsS+Wlt3AUebgipY+ptwz3YAmwZTbsqex
         AowL1GhOvCoZXZChksRfvJulMUPVggO+6ig7j4n6jZ0ZE7DCIPgZebg/5S/oKS5Xm4/5
         /xUA==
X-Gm-Message-State: APjAAAX9NESZp5lAM37MwKw3Q/IqC42rTvi9TzbHEc8Yk4uHQvWnhL+X
        bkScobcOc4qrre7O1jL2CHausvHj
X-Google-Smtp-Source: APXvYqyNconFJ4pdvHAfcCCEwmUdVot/LPhe46DpIF0dRuxjQGeG212fjPW8/PfoqK/j2Kj+rrSIrA==
X-Received: by 2002:a65:534c:: with SMTP id w12mr87608794pgr.51.1564076789787;
        Thu, 25 Jul 2019 10:46:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 14/19] merge-recursive: comment and reorder the merge_options fields
Date:   Thu, 25 Jul 2019 10:46:06 -0700
Message-Id: <20190725174611.14802-15-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
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
index 0f8d451f2e..a5049b06a3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3735,21 +3735,27 @@ void init_merge_options(struct merge_options *opt,
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
index e63483b8db..d57fce0daa 100644
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
2.22.0.559.g28a8880890.dirty

