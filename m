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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E90E1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfHQSmY (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35759 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHQSmR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id d85so4828227pfd.2
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UKPxK25y+eu7hDqNSk9jPOQDjCr6wx6XuXJ7Tm4Uw/E=;
        b=LCsUnBcxNobjbELxOS4hHxlF7LhX11K3aXZVuMAmqqu1br4Hn/n5s2chzo5GBcLyaP
         C5Qwv32n84OjY1/STcE1FzCiuzlIbQ0fyoCNaj9NJrCNyy4O6Nc9fxHCaaU6Rim/xU2G
         UjDI5Z81b4gBmKTJbGZBJLGoFdnX6LrJHpnhYWBMEVaXan6x3hQRlmy60liTTgzqAlym
         aPntTTdfQPBs5vtg1KPq1ak+jaowZb1hVAp5UoqK0lhzNrNqinYdK3wwf7fHtnFlnRVB
         o5+A55Aa31t4gkDt6D2RoUmS0hR/xfJKFuRmIYK7nggU7kO0Wk4lvpCezPRnUKp2P/Gv
         jZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKPxK25y+eu7hDqNSk9jPOQDjCr6wx6XuXJ7Tm4Uw/E=;
        b=JwUr5j2IE/X1hRqqo6SG4yJ37YD33igOglqfTwBhE1pYQ+iDJlIe+bB1z/+wqndsts
         w20TP9aEVErDymUm76f+6pV8DUaE//1evXCvLjQTnvYYj/UVs+2RfXvSTjM7VgepwCMI
         nRwCbdf1SmivNyjZZ0kwwASWyJtKy0Yc7+CVkomXtdZmpoOr5Cz26+G4w5P6p+Ao/djY
         m790UbelC90NJYLoSnMuRSMN56tON2eYat+78C+3kSAKLk1sD8G3JmynfB3s32ciI+dY
         cn1dIs7SGMUm8cjKQgvlwqIQgDM5IB3pf3WjUpeYaE9UyBZS4WTDcCIn/wR5F8TkR1FK
         wQwg==
X-Gm-Message-State: APjAAAUpxpznPMF2D2BT5W39lQ4wdAXwJMZweMJTOildTL16TGt5kQk9
        q/cTcWt4C6lDgSaw+r2He1MgSbzv
X-Google-Smtp-Source: APXvYqxo/xuUbCNQqnEbY1BoLpkdh3iK0YFKUcgCTK/UJfqD07nALOP3MUGsSqUpDz0BJn8TUfhJeA==
X-Received: by 2002:a17:90a:b395:: with SMTP id e21mr13057606pjr.76.1566067336442;
        Sat, 17 Aug 2019 11:42:16 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:15 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 16/24] merge-recursive: rename merge_options argument to opt in header
Date:   Sat, 17 Aug 2019 11:41:36 -0700
Message-Id: <20190817184144.32179-17-newren@gmail.com>
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

In commit 259ccb6cc324 ("merge-recursive: rename merge_options argument
from 'o' to 'opt'", 2019-04-05), I renamed a bunch of function
arguments in merge-recursive.c, but forgot to make that same change to
merge-recursive.h.  Make the two match.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.h b/merge-recursive.h
index 6f351098a5..2cb3844ad9 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -68,10 +68,10 @@ struct collision_entry {
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
@@ -85,7 +85,7 @@ static inline int merge_detect_rename(struct merge_options *o)
  *       commit.  Also, merge_bases will be consumed (emptied) so make a
  *       copy if you need it.
  */
-int merge_recursive(struct merge_options *o,
+int merge_recursive(struct merge_options *opt,
 		    struct commit *h1,
 		    struct commit *h2,
 		    struct commit_list *merge_bases,
@@ -95,7 +95,7 @@ int merge_recursive(struct merge_options *o,
  * rename-detecting three-way merge, no recursion; result of merge is written
  * to opt->repo->index.
  */
-int merge_trees(struct merge_options *o,
+int merge_trees(struct merge_options *opt,
 		struct tree *head,
 		struct tree *merge,
 		struct tree *merge_base);
@@ -104,16 +104,16 @@ int merge_trees(struct merge_options *o,
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
2.23.0.rc2.28.g5f89f15d7b.dirty

