Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB91F1F770
	for <e@80x24.org>; Wed,  2 Jan 2019 04:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfABEhi (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 23:37:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38391 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbfABEhi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 23:37:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so14029215plb.5
        for <git@vger.kernel.org>; Tue, 01 Jan 2019 20:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFzUb8LWKOWbJhBDY0DKhZ+GGdCL59BJqLAGTSzVJ84=;
        b=pzFomctoNT/CVc36TwA7AgQLmH23OBLBWrPcv9yeCAtSBQImxgOvvFo1bs65jdqQJ0
         wrYOYMPK9YG0tGnXIX95B1pUcJKkhqAM5kgIuxJeyRhlW6e8+pJVOYCAI/wYu2o23R+I
         xKeemxGmCSmjHCquETBbKC0TSytqANeoKY+peBjCATpS8bsHOk68F4TXQYJVjBI8Vuxi
         tIYzGcG8GM7tMlWVZF5gFXP7UlrTe9Tmcba1NT64Y0sIFo9V8AYqJshXWDNQej4RJrHd
         G6KFDdOS8AnvpjAWEg53DNZ0IsaNTiSZDk9Axw3T3rq3fh8KMwIQL12HT08JwuJW/QNg
         SfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFzUb8LWKOWbJhBDY0DKhZ+GGdCL59BJqLAGTSzVJ84=;
        b=rRaKTKGOIrBI7ilBk3TcKik8mCYcFoTTJQ/JcIyFPSthpGjYslUhUm4f7CVHWxY4qo
         /gRo8jyto6FbNT4V266xLw6/NApHbcfQGT2OMfMphQZlEdqKz/jZjJVdNJCdHOUufTPl
         i/7T4aUXbpNLC5ps12bRrvK1U4Wh9w5nCT/C2EMw4I/NlTNu6auvCCBUFS5pNglb/KdU
         NUVNLLfcti9noQ+b1NUeP1+nQv7iVCG43sg09P9tTR5XU+vZbfQ3AocIJkM8P2jw9JoB
         WgIYwPOKXpzyvk1gwEu7TK9IF0Z/Oo4GpFig77nXOn2enr0W8JHkdVWZdZZgfyBXNIze
         Eq1Q==
X-Gm-Message-State: AJcUukd1xvjBB1t1P6Yiase9FDdfidww/86X+FSXOVpQxQ1dkVH+laPP
        KX5lzapYSGjZtKGjNUKZxKM=
X-Google-Smtp-Source: ALg8bN7rDIAO92gXsqEV3V7GQGlwdu12WxvFlUshBbRZACH+mDUucnmAldUs8XjKmcbaztPcpIC6Kw==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14mr42056899plo.133.1546403857677;
        Tue, 01 Jan 2019 20:37:37 -0800 (PST)
Received: from GotGit.hz.ali.com ([106.11.34.207])
        by smtp.gmail.com with ESMTPSA id b27sm75904397pfh.113.2019.01.01.20.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 20:37:36 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Sun Chao <sunchao9@huawei.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 3/3] pack-redundant: remove unused functions
Date:   Wed,  2 Jan 2019 12:34:56 +0800
Message-Id: <20190102043456.15652-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20181219121451.21697-1-worldhello.net@gmail.com>
References: <20181219121451.21697-1-worldhello.net@gmail.com>
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
 builtin/pack-redundant.c | 72 ------------------------------------------------
 1 file changed, 72 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 3655cc7dc6..9630117c90 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -285,78 +285,6 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
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
2.14.5.agit.2

