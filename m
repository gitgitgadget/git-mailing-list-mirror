Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EC741F609
	for <e@80x24.org>; Wed, 28 Nov 2018 21:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeK2Izs (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 03:55:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43943 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2Izr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 03:55:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so10080410pgk.10
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 13:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aLCmeJILac5nyqonbwT1acf2FFSAn5nVl5CRTaaC4tQ=;
        b=h5X47+4ZnzmK8MG28dtzYwNQ1aJ9OQnnTTfCD+W+7zuwycqE7sw2rRlQ+s7Fmdl22h
         Ad9i5/ZMe1f0DyZQ5UuveBznYoj0jFbVTPSYggCxEPfHwi3GLhWZIKOVOHeyubqE47jV
         pYRi1yO2y5lPvVX+XunyInCTXcWHLYHl6N/tbsfW24SV2g7Ocx3mt17T7+xJM2259And
         SndyS4gO8GcT94FrqbyY4Zger1eryy/5h9NsAST+5f7vVO2F6vslNIN298dH6g3cmYxO
         H+nomvY9mxPL/YVqd+BHSfAtWv/Uw2xeAq795REMc2VC0xJp28RfM3zxP4uCnQQBQP9c
         86pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aLCmeJILac5nyqonbwT1acf2FFSAn5nVl5CRTaaC4tQ=;
        b=n01tIhFb4pvjVZtHyRmZiX4wPAD77YjMPozPtwqX5J9uK1SN/C+240Mz6EzCrYh3hD
         MW1UnFHJXogrq2IS//MLUkZ1R8SLYC8NTGsawSKdWMn90eN7svszUm1MtF2QVP0t13iH
         qnB1Zsykj/nMbBb8WIDL7v2o62SHZbAor7ZfzaB33b8R4U/V/15+6Sjees6EDfZyINzx
         /zKWpx2YHbCZFvTpe5YL0AkmZR95BKLMJBWxHPO2xF9ZXWtZm+Ju0T3Pe19l7jVt5cYh
         OJd1hxsRskWPUyKSMklIQUGrCja1TlWCMOXj6B0Umxze64X+1w7ypdddUWOZzzLWJYEw
         4cAw==
X-Gm-Message-State: AGRZ1gIyFXp4GDADXXJNCUSV/5Dj+cS8EGAUwpf0/6PvLUAy48wEX3gj
        m/C2e1YmAU20Bjdh4nGLlbTuwUlw
X-Google-Smtp-Source: AJdET5cJC9YC+c/2cMWftp0xkbN+VQbGeUXPK7i4I35QXHsRJNIAKbdaEJBCBfdKjhAi5ip/Q7KRcQ==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr39229675pfd.246.1543441963656;
        Wed, 28 Nov 2018 13:52:43 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 125sm11580861pfx.159.2018.11.28.13.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 13:52:43 -0800 (PST)
Date:   Wed, 28 Nov 2018 13:52:43 -0800 (PST)
X-Google-Original-Date: Wed, 28 Nov 2018 21:52:35 GMT
Message-Id: <b73b8de98c9c69a0396b435cb093ee522632796d.1543441959.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.git.gitgitgadget@gmail.com>
References: <pull.89.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/5] revision: add mark_tree_uninteresting_sparse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In preparation for a new algorithm that walks fewer trees when
creating a pack from a set of revisions, create a method that
takes an oidset of tree oids and marks reachable objects as
UNINTERESTING.

The current implementation uses the existing
mark_tree_uninteresting to recursively walk the trees and blobs.
This will walk the same number of trees as the old mechanism.

There is one new assumption in this approach: we are also given
the oids of the interesting trees. This implementation does not
use those trees at the moment, but we will use them in a later
rewrite of this method.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 22 ++++++++++++++++++++++
 revision.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/revision.c b/revision.c
index 13e0519c02..3a62c7c187 100644
--- a/revision.c
+++ b/revision.c
@@ -99,6 +99,28 @@ void mark_tree_uninteresting(struct repository *r, struct tree *tree)
 	mark_tree_contents_uninteresting(r, tree);
 }
 
+void mark_trees_uninteresting_sparse(struct repository *r,
+				     struct oidset *set)
+{
+	struct object_id *oid;
+	struct oidset_iter iter;
+
+	oidset_iter_init(set, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct tree *tree = lookup_tree(r, oid);
+
+		if (tree->object.flags & UNINTERESTING) {
+			/*
+			 * Remove the flag so the next call
+			 * is not a no-op. The flag is added
+			 * in mark_tree_unintersting().
+			 */
+			tree->object.flags ^= UNINTERESTING;
+			mark_tree_uninteresting(r, tree);
+		}
+	}
+}
+
 struct commit_stack {
 	struct commit **items;
 	size_t nr, alloc;
diff --git a/revision.h b/revision.h
index 7987bfcd2e..f828e91ae9 100644
--- a/revision.h
+++ b/revision.h
@@ -67,6 +67,7 @@ struct rev_cmdline_info {
 #define REVISION_WALK_NO_WALK_SORTED 1
 #define REVISION_WALK_NO_WALK_UNSORTED 2
 
+struct oidset;
 struct topo_walk_info;
 
 struct rev_info {
@@ -327,6 +328,7 @@ void put_revision_mark(const struct rev_info *revs,
 
 void mark_parents_uninteresting(struct commit *commit);
 void mark_tree_uninteresting(struct repository *r, struct tree *tree);
+void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *set);
 
 void show_object_with_name(FILE *, struct object *, const char *);
 
-- 
gitgitgadget

