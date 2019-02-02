Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65741F453
	for <e@80x24.org>; Sat,  2 Feb 2019 13:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfBBNbf (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 08:31:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39531 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfBBNbf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 08:31:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so4297035pgp.6
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 05:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSVCwiQWd8gcQMurO3QRa8cQ0iI/hZYZS+PVm3bYTpY=;
        b=SiAXnamfveTrsjOe9VuNE0c2Jn7X9AAQH9DDm9nCSWZoV9S45gWR4HMJuZZDm+VT1G
         ceDfgLzB+QVtQXhMogkqhqDGHIqAYPBkcxQIpXkzlg/cg2wIW/1RyByZmUCPtYiVLY03
         IWvYYxWmrCPG//U/0QZmExbo0NUt8NpipI0nhn79nIJFleTi4Xsn0UuZaanoWMjAm/xf
         vrMpPO+uaoBvft4oSE1Aw1b0zQ5+wnOm8Q18ibIu4r5woNrb+xN1kSdbTubEQZGfUR8I
         +EUqj8tm3s4a6m6/q0hUqd2hmmNeM2cxFGW95XshnlNGp4foc460WT9SWuR35oTscVAb
         MnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSVCwiQWd8gcQMurO3QRa8cQ0iI/hZYZS+PVm3bYTpY=;
        b=TqTHAaSvgUDW5QoKUrMc5637iPAmNzEzWPMH+ZfI5aGmHjRCmFgGv9bPZPmsWzAAFP
         KXGrjVI0jDuYz7degSCFNNbck6xUx7SZ9Ztw33YBHtpmksW+Yg/1NLk66F9nbjVTA/fo
         1IbuP04Ivd0kVFhKFZogWSXsVkoljWtlHZ8cdA8QK/iJFGFcwlWCtBDtLyC/Qpqoyist
         DLiQdKlH2o47MoiW6uWY/HdYTicmY/qMJKODIAubBvK2o2YTaJmwgvuGm9QaNomM6fPk
         QnXIDJlL87ZSl7PdYXMZWwR7RkO2euFNlHjlW7FYapQKLurLPEqi73FV2F0Oczx9TvdC
         tlPQ==
X-Gm-Message-State: AHQUAubsLuruNlDeyk4VFG1VkL3EiRHpn2KIoq9YYdHW2p7wEJtGOr4H
        ww6FrzizlRxMtnEg9Ja9cdY=
X-Google-Smtp-Source: AHgI3IbzHipCWwTEJ+MoKcSQ0ri2lEbnvPrCI+qDwenFeUeikjMLYWiX0Jx2axOix3cAlCzlAO4+PA==
X-Received: by 2002:a63:104d:: with SMTP id 13mr6211580pgq.303.1549114294507;
        Sat, 02 Feb 2019 05:31:34 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:c5:f1ee:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id t21sm12580010pgg.24.2019.02.02.05.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 05:31:33 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Sun Chao <16657101987@163.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v10 6/6] pack-redundant: consistent sort method
Date:   Sat,  2 Feb 2019 21:30:17 +0800
Message-Id: <20190202133017.1039-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <CAPig+cQh5TDKVaDi0gg9LZTo1Og_Qw6S2sH9cPABR9q05gEUfg@mail.gmail.com>
References: <CAPig+cQh5TDKVaDi0gg9LZTo1Og_Qw6S2sH9cPABR9q05gEUfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

SZEDER reported that test case t5323 has different test result on MacOS.
This is because `cmp_pack_list_reverse` cannot give identical result
when two pack being sorted has the same size of remaining_objects.

Changes to the sorting function will make consistent test result for
t5323.

The new algorithm to find redundant packs is a trade-off to save memory
resources, and the result of it may be different with old one, and may
be not the best result sometimes.  Update t5323 for the new algorithm.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c  | 24 ++++++++++++++++--------
 t/t5323-pack-redundant.sh | 18 +++++++++---------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 15cdf233c4..29ff5e99cb 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -33,6 +33,7 @@ static struct pack_list {
 	struct packed_git *pack;
 	struct llist *unique_objects;
 	struct llist *remaining_objects;
+	size_t all_objects_size;
 } *local_packs = NULL, *altodb_packs = NULL;
 
 static struct llist_item *free_nodes;
@@ -340,19 +341,25 @@ static inline off_t pack_set_bytecount(struct pack_list *pl)
 	return ret;
 }
 
-static int cmp_pack_list_reverse(const void *a, const void *b)
+static int cmp_remaining_objects(const void *a, const void *b)
 {
 	struct pack_list *pl_a = *((struct pack_list **)a);
 	struct pack_list *pl_b = *((struct pack_list **)b);
-	size_t sz_a = pl_a->remaining_objects->size;
-	size_t sz_b = pl_b->remaining_objects->size;
 
-	if (sz_a == sz_b)
-		return 0;
-	else if (sz_a < sz_b)
+	if (pl_a->remaining_objects->size == pl_b->remaining_objects->size) {
+		/* have the same remaining_objects, big pack first */
+		if (pl_a->all_objects_size == pl_b->all_objects_size)
+			return 0;
+		else if (pl_a->all_objects_size < pl_b->all_objects_size)
+			return 1;
+		else
+			return -1;
+	} else if (pl_a->remaining_objects->size < pl_b->remaining_objects->size) {
+		/* sort by remaining objects, more objects first */
 		return 1;
-	else
+	} else {
 		return -1;
+	}
 }
 
 /* Sort pack_list, greater size of remaining_objects first */
@@ -370,7 +377,7 @@ static void sort_pack_list(struct pack_list **pl)
 	for (n = 0, p = *pl; p; p = p->next)
 		ary[n++] = p;
 
-	QSORT(ary, n, cmp_pack_list_reverse);
+	QSORT(ary, n, cmp_remaining_objects);
 
 	/* link them back again */
 	for (i = 0; i < n - 1; i++)
@@ -511,6 +518,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		llist_insert_back(l.remaining_objects, (const struct object_id *)(base + off));
 		off += step;
 	}
+	l.all_objects_size = l.remaining_objects->size;
 	l.unique_objects = NULL;
 	if (p->pack_local)
 		return pack_list_insert(&local_packs, &l);
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 3e62e8663f..384b244314 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -165,15 +165,15 @@ test_expect_success 'master: no redundant for pack 1, 2, 3' '
 #         | T A B C D E F G H I J K L M N O P Q R
 #     ----+--------------------------------------
 #     P1  | x x x x x x x                       x
-#     P2* |     ! ! ! !   ! ! !
-#     P3  |             x     x x x x x
+#     P2  |     x x x x   x x x
+#     P3* |             !     ! ! ! ! !
 #     P4  |                     x x x x     x
 #     P5  |               x x           x x
 #     ----+--------------------------------------
 #     ALL | x x x x x x x x x x x x x x x x x   x
 #
 #############################################################################
-test_expect_failure 'master: one of pack-2/pack-3 is redundant (failed on Mac)' '
+test_expect_success 'master: one of pack-2/pack-3 is redundant' '
 	create_pack_in "$master_repo" P4 <<-EOF &&
 		$J
 		$K
@@ -190,7 +190,7 @@ test_expect_failure 'master: one of pack-2/pack-3 is redundant (failed on Mac)'
 	(
 		cd "$master_repo" &&
 		cat >expect <<-EOF &&
-			P2:$P2
+			P3:$P3
 			EOF
 		git pack-redundant --all >out &&
 		format_packfiles <out >actual &&
@@ -214,7 +214,7 @@ test_expect_failure 'master: one of pack-2/pack-3 is redundant (failed on Mac)'
 #     ALL | x x x x x x x x x x x x x x x x x x x
 #
 #############################################################################
-test_expect_failure 'master: pack 2, 4, and 6 are redundant (failed on Mac)' '
+test_expect_success 'master: pack 2, 4, and 6 are redundant' '
 	create_pack_in "$master_repo" P6 <<-EOF &&
 		$N
 		$O
@@ -254,7 +254,7 @@ test_expect_failure 'master: pack 2, 4, and 6 are redundant (failed on Mac)' '
 #     ALL | x x x x x x x x x x x x x x x x x x x
 #
 #############################################################################
-test_expect_failure 'master: pack-8 (subset of pack-1) is also redundant (failed on Mac)' '
+test_expect_success 'master: pack-8 (subset of pack-1) is also redundant' '
 	create_pack_in "$master_repo" P8 <<-EOF &&
 		$A
 		EOF
@@ -281,7 +281,7 @@ test_expect_success 'master: clean loose objects' '
 	)
 '
 
-test_expect_failure 'master: remove redundant packs and pass fsck (failed on Mac)' '
+test_expect_success 'master: remove redundant packs and pass fsck' '
 	(
 		cd "$master_repo" &&
 		git pack-redundant --all | xargs rm &&
@@ -301,7 +301,7 @@ test_expect_success 'setup shared.git' '
 	)
 '
 
-test_expect_failure 'shared: all packs are redundant, but no output without --alt-odb (failed on Mac)' '
+test_expect_success 'shared: all packs are redundant, but no output without --alt-odb' '
 	(
 		cd "$shared_repo" &&
 		git pack-redundant --all >out &&
@@ -334,7 +334,7 @@ test_expect_failure 'shared: all packs are redundant, but no output without --al
 #     ALL | x x x x x x x x x x x x x x x x x x x
 #
 #############################################################################
-test_expect_failure 'shared: show redundant packs in stderr for verbose mode (failed on Mac)' '
+test_expect_success 'shared: show redundant packs in stderr for verbose mode' '
 	(
 		cd "$shared_repo" &&
 		cat >expect <<-EOF &&
-- 
2.20.1.103.ged0fc2ca7b

