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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8F11F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbfGZPxS (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36852 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbfGZPxS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so24719401pfl.3
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Oxwr0MkMxRcCbtTQYEQqKXqfQREqfqITvoyKi8Jut4=;
        b=OjH1zS13pcr+DdadLkspj/O5ukV5ihw8nRptt/4ISanUeyiQxuOeUfMLpn3dox8sb5
         9FThFoU/nz8vaiOcwmHJVkYpJypLbtk60GldxotH107JgmnjrZ3TGTykWRx+Jj/sTlqq
         ZILTyHN1wRU2FVUuy9pZln5rDTkkRzYgkQJzd3VyWcBUSZ6EeDCjldWQLpaH9xTN7zKw
         fXV5EhQ2Jn5ooPPgBaTFnkGKCUaJnaDBU2le8KUC2XXYEhLYTQsTVuGfYl9NoVhw9+hQ
         o0U/2iSL0LX2bCoQD/dIuDRf6XOJGgZoyl5Ld3sBa2baOoj4+v7lvNX2SyssQQ5rIVJP
         UWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Oxwr0MkMxRcCbtTQYEQqKXqfQREqfqITvoyKi8Jut4=;
        b=RWWJJYPUHemH13UjcUSZ/n6PSzkkTRKEs0TfDvNF3g3H+u3YlKUjejLTfug3FJdA1X
         M+BbHyJZJmHx2Q1QXIelReHYUi6OKHqcIoZTFdF9tZOMPAA8wd1WDPoQYxTQmpMcaWeH
         GKbnTOZrWm62vCtl8HN9Pof7ES1vORsXETJzYjLuLJ30HLPm/xttgjbl0IHgKWiNh9Jl
         kELX0oMA0hsP7WAReVWjhtcn10FQ3+83pO5yB5tP3CKiY694u26Lq4LMy3rr1x4Vgyax
         fkErnhM5hFqAlROL+889/IDNJqEIvGwGSZPlytJCTkgxbe1v6EOg11CG7tuRJ+X44u4h
         gNxQ==
X-Gm-Message-State: APjAAAVaercgwG/PzCwQAVcbl4kxmzp343gKgM1/QAvSLzPKsWS+LzhO
        1dzBTLj8cJsppEevd8+dqtnecp3z
X-Google-Smtp-Source: APXvYqzp13uMI9cJCnHyH/d+dWVNWsNYjgdmwqSUwD3S4R97PfUtgMqNcQ9ICOzibQyXQY8PsgFwkA==
X-Received: by 2002:a63:c751:: with SMTP id v17mr76853836pgg.264.1564156397207;
        Fri, 26 Jul 2019 08:53:17 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:16 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 11/20] merge-recursive: rename merge_options argument to opt in header
Date:   Fri, 26 Jul 2019 08:52:49 -0700
Message-Id: <20190726155258.28561-12-newren@gmail.com>
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

In commit 259ccb6cc324 ("merge-recursive: rename merge_options argument
from 'o' to 'opt'", 2019-04-05), I renamed a bunch of function
arguments in merge-recursive.c, but forgot to make that same change to
merge-recursive.h.  Make the two match.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.h b/merge-recursive.h
index c7ba8d0a71..c201de0fc3 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -64,10 +64,10 @@ struct collision_entry {
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
 
 /*
@@ -81,7 +81,7 @@ static inline int merge_detect_rename(struct merge_options *o)
  *       commit.  Also, merge_bases will be consumed (emptied) so make a
  *       copy if you need it.
  */
-int merge_recursive(struct merge_options *o,
+int merge_recursive(struct merge_options *opt,
 		    struct commit *h1,
 		    struct commit *h2,
 		    struct commit_list *merge_bases,
@@ -91,7 +91,7 @@ int merge_recursive(struct merge_options *o,
  * rename-detecting three-way merge, no recursion; result of merge is written
  * to opt->repo->index.
  */
-int merge_trees(struct merge_options *o,
+int merge_trees(struct merge_options *opt,
 		struct tree *head,
 		struct tree *merge,
 		struct tree *merge_base);
@@ -100,16 +100,16 @@ int merge_trees(struct merge_options *o,
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
2.22.0.550.g71c37a0928.dirty

