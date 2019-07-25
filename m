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
	by dcvr.yhbt.net (Postfix) with ESMTP id 58AB21F97E
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403820AbfGYRqa (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34860 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403796AbfGYRq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so17091210pgr.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgp1yiDgI6yl2lnk1XzKMpvkuGBiL1uzgjJ2bGNou3A=;
        b=Ymts4YdmTolmf3s1H6ikPpVnMiZcX2AOlVvWDYBBKigHjPhJdvHBBV5GHOrSrW4aKA
         N05ScZyDQ8qBYC3nBeqnlOwv3i6dMmIKt7leVO3zvSfmWJf0P+XRvaIRR6HzE0kYDr48
         SAZ16OQrSZZ5RHXUnzkVgmyKazIsA/fZ2WaBDQkzD5hY9HlFJ3X86nrAt1tVlpQa/yug
         QS1KxAUjiPzLnR5zgafskRQpL4xFQRvK9D5wr5IwKWIULj4PKPFr6PXudlMMtUztyy2h
         znbFSs7fMC4ZClVAyFZcUE8FZzIyXTcTPJ21V9+eIGdR90FUT6jXEkIHSKMvM5yH8fIC
         zyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgp1yiDgI6yl2lnk1XzKMpvkuGBiL1uzgjJ2bGNou3A=;
        b=VMgGuixyMAknke5CCMeAG4DGxx3DRdM7zp5KEkADnvIRLlMh3Lv4xzBu8gkQv4NR4F
         ILMLP+p94i+BhhNIZw1yZFvzre8RJJXdPN4tRqDthtTNJLKxZkvliNuxWfK/RNzYrrnz
         6AN7YhX0r1UjoMYrcx4V9VJ9Ajp90lQ/ObfO0Yj+jeAphAaR+ZCgnWXi/Sg+PCm8CyZA
         ikOxYpkBdJyGs/u6cLx8O94Oyb2dIfOpukd1Y1JbFSFBNlibrqqYkxOD7xXwMrfL1jym
         tKwPbrYf1eCkSajL8sEY/y33SScM7bY1/LytO1EUWSxguaQibc0F6CQnsy9csnTVfovn
         XuFA==
X-Gm-Message-State: APjAAAVC6XFN6j+onH2Ig41ZExMutQyeSyoZj7NsDgGmWx5Sst9Z2hLN
        JTnE0HklBknmC+7PrqJrIOg/lWz2
X-Google-Smtp-Source: APXvYqzUeKDUgwSLGTTBECCMmzNK1I+vlMxyXQog2i9GbDq900tWCNdJGTpx/fzj18XjNVpddUih6A==
X-Received: by 2002:a63:1020:: with SMTP id f32mr57905913pgl.203.1564076787312;
        Thu, 25 Jul 2019 10:46:27 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:26 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 11/19] merge-recursive: rename merge_options argument to opt in header
Date:   Thu, 25 Jul 2019 10:46:03 -0700
Message-Id: <20190725174611.14802-12-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 259ccb6cc324 ("merge-recursive: rename merge_options argument
from 'o' to 'opt'", 2019-04-05), I renamed a bunch of function
arguments in merge-recursive.c, but forgot to make that same change to
merge-recursive.h.  Make the two match.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.h b/merge-recursive.h
index a96c8ad50f..e27c2a05bb 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -64,21 +64,21 @@ struct collision_entry {
 	unsigned reported_already:1;
 };
 
-static inline int merge_detect_rename(struct merge_options *o)
+static inline int merge_detect_rename(struct merge_options *opt)
 {
-	return o->merge_detect_rename >= 0 ? o->merge_detect_rename :
-		o->diff_detect_rename >= 0 ? o->diff_detect_rename : 1;
+	return opt->merge_detect_rename >= 0 ? opt->merge_detect_rename :
+		opt->diff_detect_rename >= 0 ? opt->diff_detect_rename : 1;
 }
 
 /* merge_trees() but with recursive ancestor consolidation */
-int merge_recursive(struct merge_options *o,
+int merge_recursive(struct merge_options *opt,
 		    struct commit *h1,
 		    struct commit *h2,
 		    struct commit_list *merge_bases,
 		    struct commit **result);
 
 /* rename-detecting three-way merge, no recursion */
-int merge_trees(struct merge_options *o,
+int merge_trees(struct merge_options *opt,
 		struct tree *head,
 		struct tree *merge,
 		struct tree *merge_base,
@@ -88,16 +88,16 @@ int merge_trees(struct merge_options *o,
  * "git-merge-recursive" can be fed trees; wrap them into
  * virtual commits and call merge_recursive() proper.
  */
-int merge_recursive_generic(struct merge_options *o,
+int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
 			    const struct object_id *merge,
 			    int num_merge_bases,
 			    const struct object_id **merge_bases,
 			    struct commit **result);
 
-void init_merge_options(struct merge_options *o,
+void init_merge_options(struct merge_options *opt,
 			struct repository *repo);
 
-int parse_merge_opt(struct merge_options *out, const char *s);
+int parse_merge_opt(struct merge_options *opt, const char *s);
 
 #endif
-- 
2.22.0.559.g28a8880890.dirty

