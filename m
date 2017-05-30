Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93E4B2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbdE3RcR (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:17 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35535 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdE3Rb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:59 -0400
Received: by mail-pf0-f176.google.com with SMTP id n23so78343448pfb.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vXsuW5FUby9yajx4t4QGovl2Js6zS/lMWRb2aXi/sOA=;
        b=b/cjX8HHjW5BjDo1ObDaSuEkNbZCZT7YyGjREeESZ7pxTtJT4++EZRVW6sVTXnbwIx
         zqW2a098xdT+9ul9GJHK56UlaT+VjVsZc1N062S5MzZoQ312TmxTUQCZcmo9nKFAZRIu
         RBCFNX7fpdFeLljqW1JB5tNDkJM3o8Wxsri6368s9K1CiUE2JlewGfCUzsAlXbeVxO4j
         S931SNSmdk0F+VJrV0UmkotAIwq2tOV/ckHG/hxptg8EsGFoK3uBznbXBjU4GZmd5ZSa
         f/Z1Hiy9TZEwFZdiVtTFvpd32aJah3o4nqMliVUVRzFnhV8WZQWHMZ2+nq6HcuZLHoVD
         ameg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vXsuW5FUby9yajx4t4QGovl2Js6zS/lMWRb2aXi/sOA=;
        b=nOH7ovU/ms4KBqy4AfMAWmI/4nc7ePvfdeyavBetv5EkazDAP1QtsEDJBOpF3Bi3jO
         6fx5giKFUtArbk7gWpNDYCuOE7c8fCLoISOCOw7BIFdG7MpJf36MjyW+nkEE/RDX76z4
         /oQGP3UQg7x5eNrDmyxiBEzejBr3isOFy4QszjpGTPQQwBY4VMstPqFc/uj42RJVevi1
         fySOyZC0IGS7IjzavE2l/X/E2aJjmzZB0ZZbFDDn/0S1dQ1GBB4XgetirqZGVAb/dljg
         rD2BWSJXQ04upXIszH0TY5DkWShxkNC3gA9mY7Jzmi2jRPnrcEBXwrVn3jhWehDWuwXS
         /HVQ==
X-Gm-Message-State: AODbwcCC9JYRtnQwc9dd82JDkRL1J2Tmf9liVFmJL1BOqlX2zSi5KW3y
        rfj17UydnzLkOqfv
X-Received: by 10.84.212.137 with SMTP id e9mr85448122pli.115.1496165519170;
        Tue, 30 May 2017 10:31:59 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:57 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 28/33] builtin/diff-tree: cleanup references to sha1
Date:   Tue, 30 May 2017 10:31:04 -0700
Message-Id: <20170530173109.54904-29-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/diff-tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index aef167619..8b26a66a9 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -7,7 +7,7 @@
 
 static struct rev_info log_tree_opt;
 
-static int diff_tree_commit_sha1(const struct object_id *oid)
+static int diff_tree_commit_oid(const struct object_id *oid)
 {
 	struct commit *commit = lookup_commit_reference(oid);
 	if (!commit)
@@ -98,7 +98,6 @@ static void diff_tree_tweak_rev(struct rev_info *rev, struct setup_revision_opt
 
 int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 {
-	int nr_sha1;
 	char line[1000];
 	struct object *tree1, *tree2;
 	static struct rev_info *opt = &log_tree_opt;
@@ -132,15 +131,14 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	 * reverse the order of the objects if the second one
 	 * is marked UNINTERESTING.
 	 */
-	nr_sha1 = opt->pending.nr;
-	switch (nr_sha1) {
+	switch (opt->pending.nr) {
 	case 0:
 		if (!read_stdin)
 			usage(diff_tree_usage);
 		break;
 	case 1:
 		tree1 = opt->pending.objects[0].item;
-		diff_tree_commit_sha1(&tree1->oid);
+		diff_tree_commit_oid(&tree1->oid);
 		break;
 	case 2:
 		tree1 = opt->pending.objects[0].item;
-- 
2.13.0.219.gdb65acc882-goog

