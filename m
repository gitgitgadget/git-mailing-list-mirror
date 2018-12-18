Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EAA11F405
	for <e@80x24.org>; Tue, 18 Dec 2018 09:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeLRJ6m (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 04:58:42 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45792 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLRJ6l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 04:58:41 -0500
Received: by mail-oi1-f196.google.com with SMTP id y1so1438537oie.12
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 01:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ltE38Xl6F0chMB7g0whiZ5sxRzIIMc3i2givG/sSEA=;
        b=cHMUp9J5t1j0k1Xb7DYQtQSkuZrxtTfbyV/TqSxoIlVYue1OCrRUgTPeIpYNWdoCmj
         vXlN20wsCT1qty9iiFOYYLJP7AfencWCK/2ctWbmcP58IJnqXX3DfZpYqeltwn+f4Jm4
         tRdMzhXsxmdSyy1/qf6WJVKTFX5cy9LBqb49JAa7u8BhSn5HiMIfvfGespH3CaOJUTvK
         cnBkeVKe3jQnF5aFlHXq1whPHf0qLUqmDdPJ043RnpndYeulUvvzQ8pm1ZO4AZb8BbO7
         iu6wB1rrPb9fZ6Q9xwJG3WYPvhqH2Buu5d/jThD0A6RHKdIfK/xOtLCK6KExHo3YJ+jR
         NOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ltE38Xl6F0chMB7g0whiZ5sxRzIIMc3i2givG/sSEA=;
        b=JYYQp+lb8pWcOGdGq89mRVb3p6iSFuzsw58aEGgI2Bt7gJYfyfsQloGJ0obGAeog8p
         nSB+Qq4eVaB3I/6jK/BkFQMHG33JbS2PeJCgrU9GdGlxYZZi6hAp3pXWlw4/AOlxnhYG
         RrHELbRSudOAMIoGsv41ER1o+St/R+YyYl0xDOcRcRob7q9fyM3NCZ5RjgD0n6M8uQz6
         QLDgbFr+ZIsKybegbNdBIIWvzPZudkWZxcWvTp1eNNuV7/nruq+uP7nDW8cDlnAefyC+
         gWQKsw/uQPavPlY+f6P+cXAhONoGOS5XgKCfgSwWrKf50nOaP/kP6b7lcVDGQEim4wmm
         22WQ==
X-Gm-Message-State: AA+aEWZci0VmJL/+N6+0pt+A3n7GjkX8acpboDwdIuh7G3vVaMnqkyOy
        wsk54eS/TyWDK42QDCx6Ls34RrIY
X-Google-Smtp-Source: AFSGD/XIxYlCFZM9OT1B0HhYqIGb9uMPQJlIsD5y+ugT3QQxumnyON4/lZ4kkrTkD22fSU9623gJAA==
X-Received: by 2002:a54:4114:: with SMTP id l20mr991194oic.110.1545127120662;
        Tue, 18 Dec 2018 01:58:40 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.9])
        by smtp.gmail.com with ESMTPSA id p203sm11286075oic.49.2018.12.18.01.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 01:58:39 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Sun Chao <sunchao9@huawei.com>,
        =?UTF-8?q?Lukas=20Sandstr=C3=B6m?= <lukass@etek.chalmers.se>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 2/2] pack-redundant: remove unused functions
Date:   Tue, 18 Dec 2018 17:58:29 +0800
Message-Id: <20181218095829.20092-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.2.g660e9286fc
In-Reply-To: <20181218095829.20092-1-worldhello.net@gmail.com>
References: <20181218095829.20092-1-worldhello.net@gmail.com>
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
---
 builtin/pack-redundant.c | 81 ----------------------------------------
 1 file changed, 81 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 19dcf74750..d0ff2377f3 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -63,15 +63,6 @@ static inline struct llist_item *llist_item_get(void)
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
@@ -285,78 +276,6 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
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
2.20.0.2.g660e9286fc

