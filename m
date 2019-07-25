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
	by dcvr.yhbt.net (Postfix) with ESMTP id BE7211F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403804AbfGYRq1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39470 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403796AbfGYRqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so19126080pfn.6
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8HX9z/mA/McxOcB0ITfELPS/JX8fRksAzz4LbAfnomg=;
        b=bkz11VId/ucqYnrwsfzJDYGhQZc6/8eZcsnOSPEWpYx3WrRnUaz7e8QXHOpOW8YKyA
         qfubZfPeQWgGEzh9DKUsQe+t5+Fu9X+xPiW1Mlgqs//hS5/RihRYQATNoapaUCBCzeZg
         FQGex7ppnUD9Tb4cf0MvV2jctKdPqEQj9JvDWSAnXXJH3cjlKO4/8fmWuyvvDYc23Qe0
         Wou1ek5Ulk7berbFEhjgPvbd8aGrvNzd1VEbpR85Ki4wAmtp9MYz5z1uH88Ccbi12tef
         mRkW+FyVXgDB8XGxgeAfAKHEVm3cs1ujHGX7jX6g5CZX/etwb/pipxqQXW0uCjOFPqLd
         ygqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8HX9z/mA/McxOcB0ITfELPS/JX8fRksAzz4LbAfnomg=;
        b=GRFL2SH6fTRU5I0ggbJGkJuKQNJ6Cz34xpjHwnmya8IeVAB4I/8j91Jqw8HQ3rW4GZ
         GiNAgUQ1lI7TBIXzn/POAD6fS3hrC/ISvJkX6O8rJa6UvWb5gXuHlqMR0k0R6fjUqsPe
         xpzf0YI1jKgh/0nweBwGulcU4PoDKBZP+ujz160nseaVIPQrfQJPM6+i8jtaVH53OsxD
         RtZSkN8TdfQY0rTBpOPlubFZHipHcOamCpRQhKqigqVcXODsUvFUAo82bWgv1mXpDwH3
         zMeipuKr/e9GgMRRlY/8eL+sWhmNz0EFjwIMbiwK5nC1i59mpFgdOfAnETn16EwtVu4G
         DsAA==
X-Gm-Message-State: APjAAAUt4yXdkao+2A0zKaRiolahx3htHUCJz560docBRSjy+8MmvsLK
        Ct4saV9OkDYvLDKnGYHZpz8LQKp+
X-Google-Smtp-Source: APXvYqwLhBlX4Xhr7Mozg01RQK7GI+5J8x8pP/TlnmsrR7QijonlqCDtVTOFVanYAIy6MJB04y222A==
X-Received: by 2002:a63:9e56:: with SMTP id r22mr30462579pgo.221.1564076784808;
        Thu, 25 Jul 2019 10:46:24 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:24 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 08/19] merge-recursive: fix some overly long lines
Date:   Thu, 25 Jul 2019 10:46:00 -0700
Message-Id: <20190725174611.14802-9-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
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
index 937a816288..104c70b787 100644
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
@@ -3392,7 +3395,8 @@ static int merge_trees_internal(struct merge_options *opt,
 		 * opposed to decaring a local hashmap is for convenience
 		 * so that we don't have to pass it to around.
 		 */
-		hashmap_init(&opt->current_file_dir_set, path_hashmap_cmp, NULL, 512);
+		hashmap_init(&opt->current_file_dir_set, path_hashmap_cmp,
+			     NULL, 512);
 		get_files_dirs(opt, head);
 		get_files_dirs(opt, merge);
 
@@ -3498,7 +3502,8 @@ static int merge_recursive_internal(struct merge_options *opt,
 		struct tree *tree;
 
 		tree = lookup_tree(opt->repo, opt->repo->hash_algo->empty_tree);
-		merged_common_ancestors = make_virtual_commit(opt->repo, tree, "ancestor");
+		merged_common_ancestors = make_virtual_commit(opt->repo,
+							      tree, "ancestor");
 	}
 
 	for (iter = ca; iter; iter = iter->next) {
@@ -3609,7 +3614,8 @@ int merge_recursive(struct merge_options *opt,
 	return ret;
 }
 
-static struct commit *get_ref(struct repository *repo, const struct object_id *oid,
+static struct commit *get_ref(struct repository *repo,
+			      const struct object_id *oid,
 			      const char *name)
 {
 	struct object *object;
@@ -3644,7 +3650,8 @@ int merge_recursive_generic(struct merge_options *opt,
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
2.22.0.559.g28a8880890.dirty

