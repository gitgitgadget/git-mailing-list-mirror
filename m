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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8294F1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbfHOVlf (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44834 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732930AbfHOVl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so1856715pgl.11
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ozm1XC3FXAOoIQPNsnb2JGbK2K9dd81NER8goIB21Q=;
        b=QHrPeVeJT6LihcoSXzf/ZFqPxi3oiiVUVhW5ulp7Szd4Nxd/T63HbN8b9YY8702PcD
         tGwtRiQok5iU5wMGEVzEWOpKLjfUjjY4ii6QW5+Dz2qMkjo07MBEaikFCtwqESLHVVfT
         14oHARkQm+K2EbUzDYEi/ODzHcclL5dYZIxEd27B73nxTQWEKKs8XrAu+IF/qEVjkctn
         IHif40n4Kn7X1Wq4J+haJ/mPPPxTgAjJmb0rDHVy4dV6iagvi10ZQLOK/M5uHLTDyKL0
         37jIq1aDmTRx1UnIPMZPHeeZV0aFC5WaOlQiL8pogD3g2hKtvAUKQwoPW6ymaufN6ay+
         Q+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ozm1XC3FXAOoIQPNsnb2JGbK2K9dd81NER8goIB21Q=;
        b=OuIQE2bR9PwN0TGhxRHi58XmRCWVMkk6jZQmBhSK7t0ifHxk3nZUmrFZx8c8NTBtv7
         2Nyz+XdxVJjc03ZARcCsgZeodJ2epqo+MAKSdU9r1ULCqZKn1BB+VtdOPcoAGobQODja
         sU4zU3el5J5j2Nd6YFxdDywCTdFwYbzq333ZnfS65mlmIgX1gyTE9H5QtPc9WBPQ+LkW
         75BqMvKwlR6rWjDQt+RFNe0Mn17JAI5p8UzZp2nlNjs6vTEccUWmgV9RZ1BwwIabqpy3
         D+QJakIjIkS+N3n08/fAiSZPHiWhLmU6gQxHhF38/GUw2jbyHU57Yf+8FK4RrCny97ng
         necg==
X-Gm-Message-State: APjAAAVaF6w12LKRbGfjucBCaoJ5ycrRSYAKBaERNh0IqnWtDbvcFe/E
        JgY+3jEDZncuRrY3z2JThLMPoSeq
X-Google-Smtp-Source: APXvYqxSjIOAsikvI5HgVbCBqKrmMWbWHOkAoYqOMG8YuRbbjbuP9n1BZ8Xi+ZUJ8SkOPMy4vEU8EA==
X-Received: by 2002:a63:2b0c:: with SMTP id r12mr5054200pgr.206.1565905287435;
        Thu, 15 Aug 2019 14:41:27 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:26 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 13/24] merge-recursive: fix some overly long lines
Date:   Thu, 15 Aug 2019 14:40:42 -0700
Message-Id: <20190815214053.16594-14-newren@gmail.com>
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

No substantive code change, just add some line breaks to fix lines that
have grown in length due to various refactorings.  Most remaining lines
of excessive length in merge-recursive include error messages and it's
not clear that splitting those improves things.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1fbae52402..40f2c6ad55 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -681,7 +681,9 @@ static void add_flattened_path(struct strbuf *out, const char *s)
 			out->buf[i] = '_';
 }
 
-static char *unique_path(struct merge_options *opt, const char *path, const char *branch)
+static char *unique_path(struct merge_options *opt,
+			 const char *path,
+			 const char *branch)
 {
 	struct path_hashmap_entry *entry;
 	struct strbuf newpath = STRBUF_INIT;
@@ -915,7 +917,8 @@ static int update_file_flags(struct merge_options *opt,
 		}
 		if (S_ISREG(contents->mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
-			if (convert_to_working_tree(opt->repo->index, path, buf, size, &strbuf)) {
+			if (convert_to_working_tree(opt->repo->index,
+						    path, buf, size, &strbuf)) {
 				free(buf);
 				size = strbuf.len;
 				buf = strbuf_detach(&strbuf, NULL);
@@ -3393,7 +3396,8 @@ static int merge_trees_internal(struct merge_options *opt,
 		 * opposed to decaring a local hashmap is for convenience
 		 * so that we don't have to pass it to around.
 		 */
-		hashmap_init(&opt->current_file_dir_set, path_hashmap_cmp, NULL, 512);
+		hashmap_init(&opt->current_file_dir_set, path_hashmap_cmp,
+			     NULL, 512);
 		get_files_dirs(opt, head);
 		get_files_dirs(opt, merge);
 
@@ -3503,7 +3507,8 @@ static int merge_recursive_internal(struct merge_options *opt,
 		struct tree *tree;
 
 		tree = lookup_tree(opt->repo, opt->repo->hash_algo->empty_tree);
-		merged_common_ancestors = make_virtual_commit(opt->repo, tree, "ancestor");
+		merged_common_ancestors = make_virtual_commit(opt->repo,
+							      tree, "ancestor");
 	}
 
 	for (iter = ca; iter; iter = iter->next) {
@@ -3630,7 +3635,8 @@ int merge_recursive(struct merge_options *opt,
 	return clean;
 }
 
-static struct commit *get_ref(struct repository *repo, const struct object_id *oid,
+static struct commit *get_ref(struct repository *repo,
+			      const struct object_id *oid,
 			      const char *name)
 {
 	struct object *object;
@@ -3665,7 +3671,8 @@ int merge_recursive_generic(struct merge_options *opt,
 		int i;
 		for (i = 0; i < num_base_list; ++i) {
 			struct commit *base;
-			if (!(base = get_ref(opt->repo, base_list[i], oid_to_hex(base_list[i]))))
+			if (!(base = get_ref(opt->repo, base_list[i],
+					     oid_to_hex(base_list[i]))))
 				return err(opt, _("Could not parse object '%s'"),
 					   oid_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
-- 
2.23.0.rc2.32.g2123e9e4e4

