Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB2C8211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 09:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbfALJT6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Jan 2019 04:19:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36689 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfALJT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jan 2019 04:19:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so8092545pfc.3
        for <git@vger.kernel.org>; Sat, 12 Jan 2019 01:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLaVh3cVN2QkKWE3TdQaGIHE4YWOjpUoPAz7U/eq/sI=;
        b=LfNLDL1rR/2GaKW0LKSvBZsy3HHtx9nhz3t02ps715Fd05ct8VQnNfarDW6XHCJbO9
         AfsUH73CbeqYbfM0WCLyuOdiLDD5ehHNJge7MLIVk80aMitu2jYiFd9kdaKNrpv9zSEi
         wsXVp4IRS1acuHiwzPzkWBxuQXpnan2zA22W+lJmnD3sSOxp3kP6sOhxKWcYfHHJeYoa
         upiyj/HrlWh5XGD0j0GUBDHzEFKWETfHU3Olvj1rC5+GzrpdUXa2ThifpAzKYDXVTQ1r
         zmG/x19hmn5X5v8y6XfIZXvZUHaiQnflAi2K97QQWrWatn6Toobhe6FPSi3LAJ2NiMN9
         AIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLaVh3cVN2QkKWE3TdQaGIHE4YWOjpUoPAz7U/eq/sI=;
        b=dwhfnmPi+DHoQcKTQejbdSnfyJIIfmqk7qansIUfoYbgpQ+v0YmMZM+Ol2nw/s2ftA
         nFQPfVs91Q7se7f2MI/cAvcswLYNTCMF7luZtAwE/klJ4BSO12blppbbyYH2bwVKdlc9
         S6pRSQb4aLK2cuPqWOxyzcEDzOntD3twSnk+h1iFaj+EREex509mhxedjNNseCjeZTbU
         GAy+//HT+zd3s+yiLqrh2kyd5raHhC3I1+GqIs5M8XvOTTkGIs1DiWxM2ETDiOI6kdVz
         stAwRCHpkn0Wl4utyOKEPQLeK648NXzW4lYhJbur+7Gp4Z0baz5+17tv4jbxvXoJbkpK
         l9JA==
X-Gm-Message-State: AJcUuke5lHDOckmoHlOLTDJezHBw7cVYfzY2bdDoIZHM4waOqxa9bVnv
        h0k0pKNpGP6lk9pwGdt6sGI=
X-Google-Smtp-Source: ALg8bN4P5EVEtaL39xu3Xv4jOIFDHvVDOWJcQv8fbm/ACuR/Z5qML+bevXcsuCr9+eRfNG4fFVoRWQ==
X-Received: by 2002:a62:d206:: with SMTP id c6mr1678966pfg.245.1547284796112;
        Sat, 12 Jan 2019 01:19:56 -0800 (PST)
Received: from localhost.localdomain ([221.222.155.87])
        by smtp.gmail.com with ESMTPSA id i5sm27685510pfg.34.2019.01.12.01.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 01:19:55 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 3/5] pack-redundant: remove unused functions
Date:   Sat, 12 Jan 2019 17:17:52 +0800
Message-Id: <20190112091754.30985-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20190110120142.22271-1-worldhello.net@gmail.com>
References: <20190110120142.22271-1-worldhello.net@gmail.com>
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
index 3655cc7dc6..eac23500ee 100644
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
@@ -285,78 +271,6 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
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
2.20.0.3.gc45e608566

