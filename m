Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2A81F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162544AbeBNTBe (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:34 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:40501 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162515AbeBNTBb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:31 -0500
Received: by mail-ot0-f201.google.com with SMTP id w4so13189772ote.7
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=XHLjYwAdW+gWjfP3qHupSoSP+/W/VD7wj1ksK52yEVw=;
        b=EkdHH4XVs5aCovZW7T9oygY+LDk+cBvDYXmt+bxX8gsoEPSl1MDNlcF77msdqDS953
         Uqo1z2PEMKhIH4qICPaJusgYYzv0W7kevVmwbe9E7vNPXJIDN1H9+mHKZvDapd8sJmZk
         Z732CERrPumOoWD1jy9+36NbBvZ5/2vsSce45muRi6U8i6ynt+CErevEig2ezmseJZDy
         jNvhST8v0kGATjYAoTYNrRG5byvTelE1JAQVjAyICjMXFW90rkjLpOyenzXwUZkupyGG
         +YJNQtWEm4DN2A00TPy4itVruVObOCp7D4WIC9cbkJxlXObj1xxUw0YMkuQQ/kzhn9M7
         Knew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=XHLjYwAdW+gWjfP3qHupSoSP+/W/VD7wj1ksK52yEVw=;
        b=VZIYFScMsCqkVz3zbRS3LtM2EdRN7BisQCFrzuCL0OQwThvZ3bABunRLC+HeBktDzh
         /GW23Eviy3BGI2q5LVSHjrlTT0xg44bZQuZMKA76UxPGt+4rHFsqtu0DmKTR2nx5KMLP
         oj92kGlIMmzu/6WnExX91+OxFjFXVDx/qjDsAxjd8GYDpYGBuOR3nxhfrQMmTIxdN4FD
         l3f4SA2CmOmotCtSvjM4ZyN/0BtDVHKm7qU7mtDQbX4jhNZPkiMZLgb6xW2mzIz6AzVk
         XeMCMxD0rzFtW2LeLYjYJDzVOjp7TQiIyWh1VWDTPvWNA4UkUClc+HVq7zt63IKLaTyj
         FTbg==
X-Gm-Message-State: APf1xPCP0UdBuYy8LrXaGdj3mMBoHMjshlk0D/JqU4GmN3wya9VsEnil
        JhE8YHlEpuMLjIE7rOwk2Tgsa3gjCB5ewW9KcYNO0fpYc1sOPP0NomKIuCHakmx3trV2+ccN1Yc
        O8/sR9tbm9kCQrRPltKeSkh+SPVkGiLbEkW98Fga7a5pAKPeIuWOIT/SspA==
X-Google-Smtp-Source: AH8x2243DC5C/kGMRg1b4cuBuFYxZ9yM56jctatULr8eItBtfODLWcfTlUO/gd+0nm39HM4hj5qsJpDtz80=
MIME-Version: 1.0
X-Received: by 10.202.104.15 with SMTP id d15mr49518oic.4.1518634890787; Wed,
 14 Feb 2018 11:01:30 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:40 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-19-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 18/37] diffcore-delta: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diffcore-delta.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index ebe70fb06..c83d45a04 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -48,16 +48,16 @@ struct spanhash_top {
 
 static struct spanhash_top *spanhash_rehash(struct spanhash_top *orig)
 {
-	struct spanhash_top *new;
+	struct spanhash_top *new_spanhash;
 	int i;
 	int osz = 1 << orig->alloc_log2;
 	int sz = osz << 1;
 
-	new = xmalloc(st_add(sizeof(*orig),
+	new_spanhash = xmalloc(st_add(sizeof(*orig),
 			     st_mult(sizeof(struct spanhash), sz)));
-	new->alloc_log2 = orig->alloc_log2 + 1;
-	new->free = INITIAL_FREE(new->alloc_log2);
-	memset(new->data, 0, sizeof(struct spanhash) * sz);
+	new_spanhash->alloc_log2 = orig->alloc_log2 + 1;
+	new_spanhash->free = INITIAL_FREE(new_spanhash->alloc_log2);
+	memset(new_spanhash->data, 0, sizeof(struct spanhash) * sz);
 	for (i = 0; i < osz; i++) {
 		struct spanhash *o = &(orig->data[i]);
 		int bucket;
@@ -65,11 +65,11 @@ static struct spanhash_top *spanhash_rehash(struct spanhash_top *orig)
 			continue;
 		bucket = o->hashval & (sz - 1);
 		while (1) {
-			struct spanhash *h = &(new->data[bucket++]);
+			struct spanhash *h = &(new_spanhash->data[bucket++]);
 			if (!h->cnt) {
 				h->hashval = o->hashval;
 				h->cnt = o->cnt;
-				new->free--;
+				new_spanhash->free--;
 				break;
 			}
 			if (sz <= bucket)
@@ -77,7 +77,7 @@ static struct spanhash_top *spanhash_rehash(struct spanhash_top *orig)
 		}
 	}
 	free(orig);
-	return new;
+	return new_spanhash;
 }
 
 static struct spanhash_top *add_spanhash(struct spanhash_top *top,
-- 
2.16.1.291.g4437f3f132-goog

