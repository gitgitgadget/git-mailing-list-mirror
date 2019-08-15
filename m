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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1890B1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbfHOVlh (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33108 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732950AbfHOVlc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so2003308pfq.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hk1ZEjjlSXgRwhPYbmok4M/L3yINz25PnHhsSx9tslc=;
        b=c/jB/sJsIM13LM9o/LqGiNKro9Zu92F14PQF4+jqU7S6eAbiXjZR0i6ItRturrXFIP
         EJvcBUWcATxK7sWP0X8ATJpNB7ET9hnnjodYD/4GfEUT1MXI87gxNs7tnwswwQZrdvHR
         fcAt3qza/KNKAd0w7QITXCMaxKDZJurV3NJFTyuVeV8fkvtSJVQspJY+YPP3qrkvvOEO
         ManS4S4wiv1VuEdyHAVhTJRIhmlIu6XigR9Y2vxkS4m8Rge6HvGinDVUFWvN78WsPnIw
         3BNHM4nnRVcqKv5i//NNo14McoiIUTPi6PqM/JdxCs1LmNkoAPYSECWTiRNPB/C9NDRB
         saPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hk1ZEjjlSXgRwhPYbmok4M/L3yINz25PnHhsSx9tslc=;
        b=HR3jVqd2So7rYFqor+OxZEOHEVEoiPnbAZ8Fqh5SdTFaWf6Fb5+Np2eFKwSycI9gQQ
         4RuaZvZpu7iuvCWVM5Zz1f/zqIRdVvzdmFzpkYor9B1Dfxo/s4zr9eUPJMbpdGSP8Vyw
         69yPLLhCXuW330k0V/6qA1XOVllDImblaxqFPfCJ4P4MCFLRzm4cl5Il5DQj38CoetlL
         jyUpoismJql5h0CL6EvUSh/igzUcW4ovCcgRtK2uFHqmfpTHYwYCjtVQFSGQqPQfuMx5
         lTaYfoCTniJO1VtsGAsk5E6u3A9GB603Zrgv7SP6C1+FMWcCrBuqBOjvyzfh16LE0cdT
         r+Jw==
X-Gm-Message-State: APjAAAUnG1n9Y2MKdx2dyHkx0AcR20v02vQnnWm5eoq1PA9Viz8IvFyq
        oX54dSlzeRQsCqWrN0ueGUgCHVA7
X-Google-Smtp-Source: APXvYqyMs0PXsE7auLtT3I7n5yfZuR5pFgOOKDYxx1xGfN69DcicVsBopZDkgrigD8221SKRYRZk2g==
X-Received: by 2002:a62:ac06:: with SMTP id v6mr7145242pfe.79.1565905290958;
        Thu, 15 Aug 2019 14:41:30 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:30 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 16/24] merge-recursive: rename merge_options argument to opt in header
Date:   Thu, 15 Aug 2019 14:40:45 -0700
Message-Id: <20190815214053.16594-17-newren@gmail.com>
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
2.23.0.rc2.32.g2123e9e4e4

