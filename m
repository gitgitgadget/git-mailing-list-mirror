Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF6971F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 19:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeJJCxv (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 22:53:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44063 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJJCxv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 22:53:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id 63-v6so3082036wra.11
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVJcHum4GPzV9FkwKAa60v7gfpwY9N/vdrhDr9mbPvc=;
        b=KBGRxWFQYtm24UFNhliHT+k930BR35rbQsA2sj7YFU/io0VBRtQoO9/EFEglNNF7TX
         MfKQTCE6QbRvYSyo4uAhMuhvSTWacM7SO30afeOxtCI40ph32ky7xMR96kfVB9EiRkn7
         ufGgA3fzUW8Ns1RpOrOH8UBO3KXgsum+mJs4ggeTXkX9hajqzZblEAQnpcehX0XhnDtL
         phoIIyuF2Ao0hVHE0qEkkcvpEFHQ9vilCdAN38mdf2g9Cco3HaXhPW5h4c510hQOb6QU
         9Topg20NSDkEhpx+BxvusoVmJvbLiw7B8ZM7UwsC98CYrNfXrWG0D+JR9UwwrWiD4B57
         +TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVJcHum4GPzV9FkwKAa60v7gfpwY9N/vdrhDr9mbPvc=;
        b=kel6WnZstVAqGRwbOMLKZ5duh0Ay5w0+4VTv75tpHCwPtCk7oPpev1BGWK285dvPqX
         FQSWf8ut5OfIch6v9MyhKD/C0iN3yA3cQyfJWAMwoxQAbEtRfmZJy2VjQ+YOGXNnxV71
         KOYdfNq1mQM28a7z7rjLvgd7lKjxzsDry2hwPNO5FVY4HrB/OwZcgzI1UjxCGzJvDHv6
         SIOooceHvzLS+Nn9IoUGxxkqfcBKaeGlHywgv9j8s0dbS01VZhQSdsxiKkobAhPa0UyL
         YTPSV3/1r7DJudHNNCK+GGhgt5UxHTUiu47kuSpDEclPgU3F4PJYEgYqK4+2/lfZhLw0
         D/hQ==
X-Gm-Message-State: ABuFfojwtxvSaqtcDVMlIQP7KHj5taTvEIseTrIMuXyBIjtP7sbQfzcT
        FA5IiSeJtYv0OkFu6wgavmg+kFJQ
X-Google-Smtp-Source: ACcGV60If2eYURwZSlPDiFvGO2IqidUYEpufWS0uzwSU/1BAx2FefKs188FQdKcXnT9juyeNantnNA==
X-Received: by 2002:adf:c594:: with SMTP id m20-v6mr21120970wrg.30.1539113718690;
        Tue, 09 Oct 2018 12:35:18 -0700 (PDT)
Received: from localhost.localdomain (x4dbd5132.dyn.telefonica.de. [77.189.81.50])
        by smtp.gmail.com with ESMTPSA id e6-v6sm18823117wrc.70.2018.10.09.12.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 12:35:17 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/4] revision.c: add GIT_TRACE_BLOOM_FILTER for a bit of statistics
Date:   Tue,  9 Oct 2018 21:34:45 +0200
Message-Id: <20181009193445.21908-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.409.g0a0ee5eb6b
In-Reply-To: <20181009193445.21908-1-szeder.dev@gmail.com>
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181009193445.21908-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It will output something like this:

  $ GIT_TRACE_BLOOM_FILTER=2 GIT_USE_POC_BLOOM_FILTER=y git rev-list --count --full-history HEAD -- t/valgrind/valgrind.sh
  886
  17:24:42.915053 revision.c:484          bloom filter total queries: 66095 definitely not: 64953 maybe: 1142 false positives: 256 fp ratio: 0.003873
---
 revision.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 3565785ca6..2f3f73b4dd 100644
--- a/revision.c
+++ b/revision.c
@@ -467,6 +467,25 @@ static void file_change(struct diff_options *options,
 /* Another static... */
 static struct bloom_filter bf;
 
+static struct trace_key trace_bloom_filter = TRACE_KEY_INIT(BLOOM_FILTER);
+static int trace_bloom_filter_atexit_registered;
+static unsigned int bloom_filter_count_maybe;
+static unsigned int bloom_filter_count_definitely_not;
+static unsigned int bloom_filter_count_false_positive;
+
+static void print_bloom_filter_stats_atexit(void)
+{
+	unsigned int total = bloom_filter_count_maybe +
+			     bloom_filter_count_definitely_not;
+	trace_printf_key(&trace_bloom_filter,
+			 "bloom filter total queries: %d definitely not: %d maybe: %d false positives: %d fp ratio: %f\n",
+			 total,
+			 bloom_filter_count_definitely_not,
+			 bloom_filter_count_maybe,
+			 bloom_filter_count_false_positive,
+			 (1.0 * bloom_filter_count_false_positive) / total);
+}
+
 static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 						 struct commit *parent,
 						 struct commit *commit)
@@ -513,10 +532,12 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 			 * at those paths that the Bloom filter have found
 			 * unchanged.
 			 */
+			bloom_filter_count_maybe++;
 			return 1;
 		}
 	}
 
+	bloom_filter_count_definitely_not++;
 	return 0;
 }
 
@@ -525,6 +546,7 @@ static int rev_compare_tree(struct rev_info *revs,
 {
 	struct tree *t1 = get_commit_tree(parent);
 	struct tree *t2 = get_commit_tree(commit);
+	int bloom_ret;
 
 	if (!t1)
 		return REV_TREE_NEW;
@@ -549,7 +571,8 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
-	if (!check_maybe_different_in_bloom_filter(revs, parent, commit))
+	bloom_ret = check_maybe_different_in_bloom_filter(revs, parent, commit);
+	if (bloom_ret == 0)
 		return REV_TREE_SAME;
 
 	tree_difference = REV_TREE_SAME;
@@ -557,6 +580,8 @@ static int rev_compare_tree(struct rev_info *revs,
 	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
+	if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
+		bloom_filter_count_false_positive++;
 	return tree_difference;
 }
 
@@ -3198,6 +3223,13 @@ void prepare_to_use_bloom_filter(struct rev_info *revs)
 		warning("you wanted to use the Bloom filter, but it couldn't be loaded");
 		return;
 	}
+
+	if (trace_want(&trace_bloom_filter)) {
+		if (!trace_bloom_filter_atexit_registered) {
+			atexit(print_bloom_filter_stats_atexit);
+			trace_bloom_filter_atexit_registered = 1;
+		}
+	}
 }
 
 int prepare_revision_walk(struct rev_info *revs)
-- 
2.19.1.409.g0a0ee5eb6b

