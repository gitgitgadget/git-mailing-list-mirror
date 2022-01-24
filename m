Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC4BC433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348954AbiAXTdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352690AbiAXTa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:30:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17906C02983F
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:59 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n8so23598402wmk.3
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TUCZrT0R8cpMEB18cBkDpHwmjdJOKsrx7vpHWxOMd7M=;
        b=Bah38H0CUreC1+kek28c1yeXF8E/18Qcjc4+6w3qUYDA4NGkjEh035a1fB9lTxf48b
         Xt23bSGOJ/q9G519omBYe7TWgap7Rd9jWPUgqBUlEX4iOUD/5c12jpgCXITQ1KQo79MH
         zMOkBoBwV+z91OGuBQDp8Lx0zHXkpk6B3hKQaM7bRGyefM/Dd+AKHS2zQpmSpZFmBeYA
         G3MFyAwQc8IBJHjqAjyRyA45FtlTxgpM+2fJCR1VBk3jZglABiOiw2qtDahlGTHvT8rQ
         vky2+cg6K9LfY3qFUkz/gSDwwK2SGDUHb8L3OT+LAjpcqXhs7kAkUT6WCJ2IixXoNMvf
         OZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TUCZrT0R8cpMEB18cBkDpHwmjdJOKsrx7vpHWxOMd7M=;
        b=P1zOWJ2ybto4RHxgbBiDDIYag6twYrNNiMICfVCipmwTKFo/DQqkkjibkX06bFs9CE
         Jmy0/VOwxUCrHZWQhPbZjsSmvRzdWu0SrNN9F3aho6UwiFv706ELMxZzvrKcuUUZuSC3
         9olNuSMCFG/4Cdm0AugOIjKAjtM8yW2tkxQwCXN9jfSkNZTyqvw1Aaltph0SUtkzewVQ
         wCjq8VQQ2jzt3b2PK4i3i9+wZWrjV74C/EzC0TBzFz+Vy/cqKImAyxpXTFwGwS7I3001
         IqdB+iJEfLjmY+SJD4Wp9wPp726sy1tEGV+/vQLYzSvIowcJhyIP5HP2Ga8bdsRVa4sL
         xPZQ==
X-Gm-Message-State: AOAM531tEJXEnXxpUQb3HPhEA8OahkVuAPEGeFVIVe7Gk6Hx5DfOuR4j
        VXiLjX6uH1ekZeYEOYUN0Qj2txHEOXOjBw==
X-Google-Smtp-Source: ABdhPJyeNokdloFAdvP09PmlJ2lDDj91FLPbN6FUl6mZMyP8+KcNEi5LOGUz7O+h+UfNqzg6KGtqkA==
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr3054065wmq.63.1643051637503;
        Mon, 24 Jan 2022 11:13:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm146911wmo.37.2022.01.24.11.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:57 -0800 (PST)
Message-Id: <7e23d14d1af8624067c0afd8f21e793ee551a78f.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:41 +0000
Subject: [PATCH v7 13/16] reftable: remove outdated file reftable.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This was renamed to generic.c, but the origin was never removed

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/reftable.c | 115 --------------------------------------------
 1 file changed, 115 deletions(-)
 delete mode 100644 reftable/reftable.c

diff --git a/reftable/reftable.c b/reftable/reftable.c
deleted file mode 100644
index 0e4607a7cd6..00000000000
--- a/reftable/reftable.c
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "basics.h"
-#include "record.h"
-#include "generic.h"
-#include "reftable-iterator.h"
-#include "reftable-generic.h"
-
-int reftable_table_seek_ref(struct reftable_table *tab,
-			    struct reftable_iterator *it, const char *name)
-{
-	struct reftable_ref_record ref = {
-		.refname = (char *)name,
-	};
-	struct reftable_record rec = { NULL };
-	reftable_record_from_ref(&rec, &ref);
-	return tab->ops->seek_record(tab->table_arg, it, &rec);
-}
-
-int reftable_table_read_ref(struct reftable_table *tab, const char *name,
-			    struct reftable_ref_record *ref)
-{
-	struct reftable_iterator it = { NULL };
-	int err = reftable_table_seek_ref(tab, &it, name);
-	if (err)
-		goto done;
-
-	err = reftable_iterator_next_ref(&it, ref);
-	if (err)
-		goto done;
-
-	if (strcmp(ref->refname, name) ||
-	    reftable_ref_record_is_deletion(ref)) {
-		reftable_ref_record_release(ref);
-		err = 1;
-		goto done;
-	}
-
-done:
-	reftable_iterator_destroy(&it);
-	return err;
-}
-
-uint64_t reftable_table_max_update_index(struct reftable_table *tab)
-{
-	return tab->ops->max_update_index(tab->table_arg);
-}
-
-uint64_t reftable_table_min_update_index(struct reftable_table *tab)
-{
-	return tab->ops->min_update_index(tab->table_arg);
-}
-
-uint32_t reftable_table_hash_id(struct reftable_table *tab)
-{
-	return tab->ops->hash_id(tab->table_arg);
-}
-
-void reftable_iterator_destroy(struct reftable_iterator *it)
-{
-	if (!it->ops) {
-		return;
-	}
-	it->ops->close(it->iter_arg);
-	it->ops = NULL;
-	FREE_AND_NULL(it->iter_arg);
-}
-
-int reftable_iterator_next_ref(struct reftable_iterator *it,
-			       struct reftable_ref_record *ref)
-{
-	struct reftable_record rec = { NULL };
-	reftable_record_from_ref(&rec, ref);
-	return iterator_next(it, &rec);
-}
-
-int reftable_iterator_next_log(struct reftable_iterator *it,
-			       struct reftable_log_record *log)
-{
-	struct reftable_record rec = { NULL };
-	reftable_record_from_log(&rec, log);
-	return iterator_next(it, &rec);
-}
-
-int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
-{
-	return it->ops->next(it->iter_arg, rec);
-}
-
-static int empty_iterator_next(void *arg, struct reftable_record *rec)
-{
-	return 1;
-}
-
-static void empty_iterator_close(void *arg)
-{
-}
-
-static struct reftable_iterator_vtable empty_vtable = {
-	.next = &empty_iterator_next,
-	.close = &empty_iterator_close,
-};
-
-void iterator_set_empty(struct reftable_iterator *it)
-{
-	assert(!it->ops);
-	it->iter_arg = NULL;
-	it->ops = &empty_vtable;
-}
-- 
gitgitgadget

