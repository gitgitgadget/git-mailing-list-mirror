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
	by dcvr.yhbt.net (Postfix) with ESMTP id BDB781F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387757AbfGZPxP (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43472 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387588AbfGZPxO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so17927528pld.10
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDvG3V7NiVhTVVBozAoR4JYHAo/KmrUjMTjlxPdBknA=;
        b=HZt/2iIf4Fc1+1U4Sp/MNt1SUlY21JcF8yuG22W1Rt+rD5Byrer84fBpUn3pt7SVNe
         yCmKMaO/cKV/YpHCqD7bO4k0IuJPrrsH9vuLssKx++dxiY4haYmQL/Rh9ab4DEl0uOMU
         kSl5Zs1V+8p2DUeYw+FToQjrpQ8hVc5H73wX+fkY+F4D5YtgMqEthJAc6BJVDPVOYKS/
         8/b06eoFn1sMrQqMFf7XT7kvDs4UEjAgC2oWlzAmHdy/uqt+FDYsEkTLMuGbqDb8wlln
         gfe40G/IcbL1BRWE/u6vd9DeMipXIuwWjPY5vOs/QGSBhk5r6sA/kZGSaxwLxl8chUrI
         3E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDvG3V7NiVhTVVBozAoR4JYHAo/KmrUjMTjlxPdBknA=;
        b=Llk5rg0y1MzKpns5FEi7D/ojQ0iYMUuDKaQD8SaWOm9nCCBpf+BxkaeoVQjqXZTNcc
         qsvPM5H029olIwLmwImiHv+R2LuYWMpj0sqrEOsm15Ye4fhxmMbxCxi9jBQyroTcFTzG
         492mZjFG6WQe+LhbHvbwZo3N5xgNYC2IDWXDAEAHaZlR5dBDqZgSQn+Twp2Y5SiWkC+p
         ZQyZ55YD2lNsDvelzSUCPBP5ojsbBCCSUCJneLhIRkJvs3P0EZQxeYCztAmyOI9K6+9j
         CLAfPP7Fk7d1goWNiE7Am1lPxQYpsUhRm4A64hSvi8mWhN64znJK32MNkUyofo9J79ob
         9hAA==
X-Gm-Message-State: APjAAAU2pdFQsBPXQusIiXCv7FvcHOyQLkeV0I1g5lVOsynUWT6rynbc
        A1fqMAD6mgdXoeuxrq6ujEIcRXNx
X-Google-Smtp-Source: APXvYqzYBjJuWpHmmZwgwsTomeLB5Mk0uTCn7YUHQg7YZ4C1VaqfafJGxl1W8FRevEXEB3aCeGgxPw==
X-Received: by 2002:a17:902:8548:: with SMTP id d8mr97530426plo.100.1564156393546;
        Fri, 26 Jul 2019 08:53:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:12 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 08/20] merge-recursive: fix some overly long lines
Date:   Fri, 26 Jul 2019 08:52:46 -0700
Message-Id: <20190726155258.28561-9-newren@gmail.com>
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

No substantive code change, just add some line breaks to fix lines that
have grown in length due to various refactorings.  Most remaining lines
of excessive length in merge-recursive include error messages and it's
not clear that splitting those improves things.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6c38c02e3f..e81dec8f1f 100644
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
 
@@ -3505,7 +3509,8 @@ static int merge_recursive_internal(struct merge_options *opt,
 		struct tree *tree;
 
 		tree = lookup_tree(opt->repo, opt->repo->hash_algo->empty_tree);
-		merged_common_ancestors = make_virtual_commit(opt->repo, tree, "ancestor");
+		merged_common_ancestors = make_virtual_commit(opt->repo,
+							      tree, "ancestor");
 	}
 
 	for (iter = ca; iter; iter = iter->next) {
@@ -3617,7 +3622,8 @@ int merge_recursive(struct merge_options *opt,
 	return clean;
 }
 
-static struct commit *get_ref(struct repository *repo, const struct object_id *oid,
+static struct commit *get_ref(struct repository *repo,
+			      const struct object_id *oid,
 			      const char *name)
 {
 	struct object *object;
@@ -3652,7 +3658,8 @@ int merge_recursive_generic(struct merge_options *opt,
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
2.22.0.550.g71c37a0928.dirty

