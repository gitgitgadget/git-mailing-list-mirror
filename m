Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6665E1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 12:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfAJMFX (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 07:05:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42553 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfAJMFW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 07:05:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so4740655pga.9
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 04:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ppb8OhGJpDYCo5Rzg+2JvZPBAKaZiAU2u5tjy5Rc/LE=;
        b=UZwzMlWpvKnGu3eafPRfkHPcKwCt5ZKNdAgrr+qLx//SWapvdsu2knsBVRoKwmcmeL
         A04j+VuqiuYlIH+bO2UcjCv5WwvXnrWLWJwqt/O6Su1tM834M1xscMTXopt6H+8abI5D
         D6iMAHc9rIsUtIgac35UmwjDdOczZo1FviedOJOPexJFT3As114T8xKcLFL97Nc9TO1d
         rgI9bIvHasQycdcizJ0DAJjM4+cTABd0H7Js1bjF3SdU6rkpNKoy3OHhGpnqsflx/AHo
         dC62fFwa9N5ViI9ujReM8ctww3a2Uv9G38evGZRB0CyaU7yu7hYtRJIdCDFdMsJLKNHj
         kH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ppb8OhGJpDYCo5Rzg+2JvZPBAKaZiAU2u5tjy5Rc/LE=;
        b=X79g07TJZtanxRD4RGaOmYKiWxXxNVa8XBgTRrgcFwma0htawK4Zuk1XWkMI6jD6x+
         ZKwvW+/CcMOQy1heoyu7vOFx30c14zaKaYvgPLLzPChINZIT9BGSmLCogrgWNVfXav5p
         W4hAIierD9Zl07JvqeG0ILsaJlc51mOtdYNGEXyzdRjc9Dmgzkof2CfzYL5OwjtQOgUY
         IfRagX+Rix9KBq4D6vD2hNuAhP7po0v9avvfwFCEFGOgP7d8GipollKSKWdDzo0hHsbe
         Qx20WzDbhvu/gQ2Fr8MfZWtZiMwx2mzl8f+lRZBAy9293OZbEmxdiQRZ6CqP3F+ShA4c
         tFxA==
X-Gm-Message-State: AJcUukdHYsnkivufp0Cb2ISicPjGhWI/W+9c5O5z84jcwa+eC6BdcHKm
        4nkT6+fPeJr9oKoEbvK46V4=
X-Google-Smtp-Source: ALg8bN7aMBIsr7SsiJPAk0OA8PfGDx4UlxHJzS6rIG6pO2y2HLwlvJqTQwMYKz7jBqZxIZEf6SHN6Q==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr9276227pgp.263.1547121921851;
        Thu, 10 Jan 2019 04:05:21 -0800 (PST)
Received: from GotGit.hz.ali.com ([106.11.34.204])
        by smtp.gmail.com with ESMTPSA id b2sm137189403pfm.3.2019.01.10.04.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 04:05:20 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 5/5] pack-redundant: remove unused functions
Date:   Thu, 10 Jan 2019 20:01:42 +0800
Message-Id: <20190110120142.22271-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.101.gc01fadde4e
In-Reply-To: <20190109164731.GJ4673@szeder.dev>
References: <20190109164731.GJ4673@szeder.dev>
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
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c | 86 ----------------------------------------
 1 file changed, 86 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index e9d2586e2e..dd71fdd435 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -36,11 +36,6 @@ static struct pack_list {
 	size_t all_objects_size;
 } *local_packs = NULL, *altodb_packs = NULL;
 
-struct pll {
-	struct pll *next;
-	struct pack_list *pl;
-};
-
 static struct llist_item *free_nodes;
 
 static inline void llist_item_put(struct llist_item *item)
@@ -64,15 +59,6 @@ static inline struct llist_item *llist_item_get(void)
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
@@ -286,78 +272,6 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
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
-		llist_sorted_difference_inplace(diff, pl->remaining_objects);
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
2.20.1.101.gc01fadde4e

