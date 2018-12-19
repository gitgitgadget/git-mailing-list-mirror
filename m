Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A38E1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 12:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeLSMPK (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 07:15:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41115 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSMPK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 07:15:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so18867326otk.8
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 04:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TJGD5QmNYu1OpS1aIBBiD1FUewDTMjO9/seo8dqUvlA=;
        b=sNjPNcTzqsvCRpvlhsyTe7RX1EyWqMWLWCr/9T917Wv6eiFW+gykIGjkfMcL2zZUeb
         M59JhALnfJv49MtEzurXeZQ3thfDeKrAoi2QfPSFcd1M/1ap7k7k+MPciwkOMwjsMx9e
         vSS5pbUur7Da+MhtbSCYPWeLoeqYULKq8JSEjqQCBaFVanxMbfRTG8c63kOvM0AdNHy5
         fNxJnebhNwvWHtAA6PxneBpoalWakeizpjVtt6Vi9Jbjfzx4lNvtgJKOE3RuyxDCNe9F
         VeE8uNZXHebda2ibwRXy1HGOisYEAEwxyINGMiSJvhQ4roPVaOpjdoysUb63fYP5tHUj
         vqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TJGD5QmNYu1OpS1aIBBiD1FUewDTMjO9/seo8dqUvlA=;
        b=bvpVZx6VpnWiRKoad8/T/5VO/Oadm2iT6vq9uv+jzknA01r7u4ct6kLo+8Jvzmfz1v
         S/IDSHELSPlcmsnaFJMaZBLhmcvaBITO8tzPtIhCF6hCAg0Nvz1peFAx2rUNs05tYlVO
         ExPRF+I3pqKLP001KXtxVBDSYCiwwNryNbhgTVUFfdrCXi72cSaYXAZYQrtWLH7e2/KF
         v9jgT3n7upORWLRtLYiFq5L3Fg2cpxK7cjXDmzqTJJ3IJqPh9VzbkrTgfSYF3XiIhnGe
         OzITOa0tdBv+OKivnOygTe6xHQcl8XCD+S3AHKDbdjjKdbeF4uJ7fUUIjouWeNcZ9eh7
         3cJg==
X-Gm-Message-State: AA+aEWZS/szhBiwLX1W4nORND1JW7c8pTakENPxC8TDxNHC59XuuFeMt
        ZsUPdSHYd5tYZTaxyXFvLWSbT0GIhrk=
X-Google-Smtp-Source: AFSGD/VZcLldeeM+vzZhPjwq6v4dqzAKgycPg6XvHFXft2Enq4S+fVtq4NfKKJplhCzyNm/54KzEbw==
X-Received: by 2002:a9d:2184:: with SMTP id s4mr5260046otb.46.1545221709421;
        Wed, 19 Dec 2018 04:15:09 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.9])
        by smtp.gmail.com with ESMTPSA id e128sm8826357oia.5.2018.12.19.04.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 04:15:08 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 3/3] pack-redundant: remove unused functions
Date:   Wed, 19 Dec 2018 20:14:51 +0800
Message-Id: <20181219121451.21697-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20181218095829.20092-2-worldhello.net@gmail.com>
References: <20181218095829.20092-2-worldhello.net@gmail.com>
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
 builtin/pack-redundant.c | 72 ----------------------------------------
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
2.20.0.3.gc45e608566

