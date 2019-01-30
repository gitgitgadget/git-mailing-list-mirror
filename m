Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D918A1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 11:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfA3Lsy (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 06:48:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44221 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfA3Lsy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 06:48:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so10929121plt.11
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 03:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XrHEes6KZJRdNUPCap22vIVcFy/Ea3cfo8b8TIQY6qs=;
        b=jSR7nwZHbRhJcVZiz7fTZEsCHYWLvAdziayi+Dn7ZsxUD+yGpgwTu/SH7cFkMVcma4
         j/Zk3tRZvFLusVefTpeguqPT4+JOcuC9bcJlzjsoaAaZkkmycQbt8Xmr74n1naLokjNB
         7+FpFLyVcwWcR06FNzkmlgyjzhmdNRmOqeeU3qonu6K3yDvJLQRG14NUWaW82wQ9S1Ms
         CEFTFszM8rocS3mV8hARjgk5cZRtBr3/TeitlA7ppZVP83uyrgqe9n8pQireRevSohp4
         ReA/+x9Z8KLsWPF7io0/Rz8DWGk/eDIT8ZeG9fhXHKHtB3Vtw0XOVgYlMK5n7lhxgadI
         RKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XrHEes6KZJRdNUPCap22vIVcFy/Ea3cfo8b8TIQY6qs=;
        b=ho2bX4O/bSVUW0k7WqHt59z7m+5gf3a+lyy6I/yzmF+r8giEH9VWio4CslkZr9AiiF
         KYKp8O+0Xjkid6j/BybuWixKGo72odeEc2WO66ad528fULdMZDkpgksqy73MvFc6+5Ug
         Kag2HXnJdFsjKc3sz6mYyvT9uPyzlMaQlkcw2nEQaW4XobOUG4Sad7PQTdZoqlg30ZGa
         kvzloF1X12F6iZlF9guvayiij0Jcvn7kpJrk4kTqvjL0n+dBpJ7fwP2m/ZEpLTbUxF9b
         mzO/lxEpTHbH3i3YWm6DMRaqtoyA1MNhNvo7ktoItlJDJwvVAYn5aepun+u4Kls4mDNC
         vBkQ==
X-Gm-Message-State: AJcUukfKMXtuyJKThSSN/oAgPexcOB6L6kb7Fqf1Qz6AMx4YlY5Pz2U4
        yCUvUmPinlNCPHtvaiPwkPg=
X-Google-Smtp-Source: ALg8bN6C9Zbdhtn45qM0ccDNHKMBqXTE2dc348DYIl7zaaOfw/NltVdvWIwHbd0IAMMxEYLx0DTyzA==
X-Received: by 2002:a17:902:b112:: with SMTP id q18mr30125943plr.255.1548848933999;
        Wed, 30 Jan 2019 03:48:53 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:e2:afd3:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id v191sm2124473pgb.77.2019.01.30.03.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 03:48:53 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v7 4/6] pack-redundant: remove unused functions
Date:   Wed, 30 Jan 2019 19:47:34 +0800
Message-Id: <20190130114736.30357-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <20190112091754.30985-1-worldhello.net@gmail.com>
References: <20190112091754.30985-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

Remove unused functions to find `min` packs, such as `get_permutations`,
`pll_free`, etc.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c | 86 ----------------------------------------
 1 file changed, 86 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index b3f3bb5e09..b83d55031a 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -35,11 +35,6 @@ static struct pack_list {
 	struct llist *all_objects;
 } *local_packs = NULL, *altodb_packs = NULL;
 
-struct pll {
-	struct pll *next;
-	struct pack_list *pl;
-};
-
 static struct llist_item *free_nodes;
 
 static inline void llist_item_put(struct llist_item *item)
@@ -63,15 +58,6 @@ static inline struct llist_item *llist_item_get(void)
 	return new_item;
 }
 
-static void llist_free(struct llist *list)
-{
-	while ((list->back = list->front)) {
-		list->front = list->front->next;
-		llist_item_put(list->back);
-	}
-	free(list);
-}
-
 static inline void llist_init(struct llist **list)
 {
 	*list = xmalloc(sizeof(struct llist));
@@ -290,78 +276,6 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 	}
 }
 
-static void pll_free(struct pll *l)
-{
-	struct pll *old;
-	struct pack_list *opl;
-
-	while (l) {
-		old = l;
-		while (l->pl) {
-			opl = l->pl;
-			l->pl = opl->next;
-			free(opl);
-		}
-		l = l->next;
-		free(old);
-	}
-}
-
-/* all the permutations have to be free()d at the same time,
- * since they refer to each other
- */
-static struct pll * get_permutations(struct pack_list *list, int n)
-{
-	struct pll *subset, *ret = NULL, *new_pll = NULL;
-
-	if (list == NULL || pack_list_size(list) < n || n == 0)
-		return NULL;
-
-	if (n == 1) {
-		while (list) {
-			new_pll = xmalloc(sizeof(*new_pll));
-			new_pll->pl = NULL;
-			pack_list_insert(&new_pll->pl, list);
-			new_pll->next = ret;
-			ret = new_pll;
-			list = list->next;
-		}
-		return ret;
-	}
-
-	while (list->next) {
-		subset = get_permutations(list->next, n - 1);
-		while (subset) {
-			new_pll = xmalloc(sizeof(*new_pll));
-			new_pll->pl = subset->pl;
-			pack_list_insert(&new_pll->pl, list);
-			new_pll->next = ret;
-			ret = new_pll;
-			subset = subset->next;
-		}
-		list = list->next;
-	}
-	return ret;
-}
-
-static int is_superset(struct pack_list *pl, struct llist *list)
-{
-	struct llist *diff;
-
-	diff = llist_copy(list);
-
-	while (pl) {
-		llist_sorted_difference_inplace(diff, pl->all_objects);
-		if (diff->size == 0) { /* we're done */
-			llist_free(diff);
-			return 1;
-		}
-		pl = pl->next;
-	}
-	llist_free(diff);
-	return 0;
-}
-
 static size_t sizeof_union(struct packed_git *p1, struct packed_git *p2)
 {
 	size_t ret = 0;
-- 
2.20.1.103.ged0fc2ca7b

