Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442491F453
	for <e@80x24.org>; Fri, 28 Sep 2018 16:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbeI1WuC (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 18:50:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52533 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbeI1WuC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 18:50:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so2506293wmw.2
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BGtjCijamzGPp+pKVJZdJiHOQWc8BeG/U6T17Ory8TQ=;
        b=dPHcdo/qJtZJgj6rqLSd0MFvAxb+xeFLyEiZuCefYNy4/j6rfrJ/GtBb4k69KBpcLo
         Hqx8jZqrhwMaD0n8apo3FaZvAy5l6JQA0ifceecIepuv2QSxFn367zb/EGa0xSkOn/k5
         o6kICm8xV1o2ofw8hylir4JvlmyAuV3Q/Sh5WsvfvefA+zbgAzA9ALC9ofvINSOffFkI
         QSiw7Hy4Kik9fD18W/AQSlBKoO+uobfrDVdQyg6v0udwB0c/NaxHfroLxwdLEJFK1F23
         SKV4onT9T3sxkBbZIML4TKcMvRQeJmIQzQMLHPGJChkcTVP4fazSXbL87SekYdldo53C
         ++fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGtjCijamzGPp+pKVJZdJiHOQWc8BeG/U6T17Ory8TQ=;
        b=lFYPJgrXZmePon5hAUk4fqsNRGS59GBdlPwtAhiLH9Z8oomitxzHfw4GqkkxtNyBFF
         HZ5AUNBaeB10eXN2RH06idI6+qHZExzc5ihO/CkeDP1m3AKlBwkdLAr6IzoNRQTOAaCU
         Lsp+oOolN9K9BQn/G8sh0onKwGprIcviUpPs+bPkz1mtPdL1hDNwrGuqZJMAcgUJP3Vt
         WvcP+oeLz1ym728PqduKAXnD03YRlYyJxcV9+nz/2BcThAioUhs/+lCZhu4YI6c03arv
         qx5tsckc5INe0g9OY2d9RNqSEQ7TQwLph0zSsV5l/wkfGwhvXzbuIwZ+4xxF698p7ApU
         H9UQ==
X-Gm-Message-State: ABuFfohLkR4GS7Dmev0tznNQkBRIeEJBLLH657ncCTJ8MlR1Q7rYXzJ7
        e1HLMZPZQc0nQ9EUFxAgXbc=
X-Google-Smtp-Source: ACcGV62V6jwrlQRciFd09sfQCohO3o6gYCIuQ8EDGn0lG+At/NcNs1jiOeK61c8C8N1msUm+Qb92fg==
X-Received: by 2002:a1c:9d43:: with SMTP id g64-v6mr2223668wme.26.1538151927840;
        Fri, 28 Sep 2018 09:25:27 -0700 (PDT)
Received: from localhost.localdomain (x4db1ef73.dyn.telefonica.de. [77.177.239.115])
        by smtp.gmail.com with ESMTPSA id s24-v6sm1628247wmc.7.2018.09.28.09.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 09:25:26 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 5/6] split-index: don't compare stat data of entries already marked for split index
Date:   Fri, 28 Sep 2018 18:24:58 +0200
Message-Id: <20180928162459.17138-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.361.gafc87ffe72
In-Reply-To: <20180928162459.17138-1-szeder.dev@gmail.com>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180928162459.17138-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When unpack_trees() constructs a new index, it copies cache entries
from the original index [1].  prepare_to_write_split_index() has to
deal with this, and it has a dedicated code path for copied entries
that are present in the shared index, where it compares the cached
data in the corresponding copied and original entries.  If the cached
data matches, then they are considered the same; if it differs, then
the copied entry will be marked for inclusion as a replacement entry
in the just about to be written split index by setting the
CE_UPDATE_IN_BASE flag.

However, a cache entry already has its CE_UPDATE_IN_BASE flag set upon
reading the split index, if the entry already has a replacement entry
there, or upon refreshing the cached stat data, if the corresponding
file was modified.  The state of this flag is then preserved when
unpack_trees() copies a cache entry from the shared index.

So modify prepare_to_write_split_index() to check the copied cache
entries' CE_UPDATE_IN_BASE flag first, and skip the thorough
comparison of cached data if the flag is already set.

Note that comparing the cached data in copied and original entries in
the shared index might actually be entirely unnecessary.  In theory
all code paths refreshing the cached stat data of an entry in the
shared index should set the CE_UPDATE_IN_BASE flag in that entry, and
unpack_trees() should preserve this flag when copying cache entries.
This means that the cached data is only ever changed if the
CE_UPDATE_IN_BASE flag is set as well.  Our test suite seems to
confirm this: instrumenting the conditions in question and running the
test suite repeatedly with 'GIT_TEST_SPLIT_INDEX=yes' showed that the
cached data in a copied entry differs from the data in the shared
entry only if its CE_UPDATE_IN_BASE flag is indeed set.

In practice, however, our test suite doesn't have 100% coverage,
GIT_TEST_SPLIT_INDEX is inherently random, and I certainly can't claim
to possess complete understanding of what goes on in unpack_trees()...
Therefore I kept the comparison of the cached data when
CE_UPDATE_IN_BASE is not set, just in case that an unnoticed or future
code path were to accidentally miss setting this flag upon refreshing
the cached stat data or unpack_trees() were to drop this flag while
copying a cache entry.

[1] Note that when unpack_trees() constructs the new index and decides
    that a cache entry should now refer to different content than what
    was recorded in the original index (e.g. 'git read-tree -m
    HEAD^'), then that can't really be considered a copy of the
    original, but rather the creation of a new entry.  Notably and
    pertinent to the split index feature, such a new entry doesn't
    have a reference to the original's shared index entry anymore,
    i.e. its 'index' field is set to 0.  Consequently, such an entry
    is treated by prepare_to_write_split_index() as an entry not
    present in the shared index and it will be added to the new split
    index, while the original entry will be marked as deleted, and
    neither the above discussion nor the changes in this patch apply
    to them.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 split-index.c | 79 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 17 deletions(-)

diff --git a/split-index.c b/split-index.c
index 548272ec33..7d8799f6b7 100644
--- a/split-index.c
+++ b/split-index.c
@@ -207,13 +207,28 @@ void prepare_to_write_split_index(struct index_state *istate)
 		 */
 		for (i = 0; i < istate->cache_nr; i++) {
 			struct cache_entry *base;
-			/* namelen is checked separately */
-			const unsigned int ondisk_flags =
-				CE_STAGEMASK | CE_VALID | CE_EXTENDED_FLAGS;
-			unsigned int ce_flags, base_flags, ret;
 			ce = istate->cache[i];
-			if (!ce->index)
+			if (!ce->index) {
+				/*
+				 * During simple update index operations this
+				 * is a cache entry that is not present in
+				 * the shared index.  It will be added to the
+				 * split index.
+				 *
+				 * However, it might also represent a file
+				 * that already has a cache entry in the
+				 * shared index, but a new index has just
+				 * been constructed by unpack_trees(), and
+				 * this entry now refers to different content
+				 * than what was recorded in the original
+				 * index, e.g. during 'read-tree -m HEAD^' or
+				 * 'checkout HEAD^'.  In this case the
+				 * original entry in the shared index will be
+				 * marked as deleted, and this entry will be
+				 * added to the split index.
+				 */
 				continue;
+			}
 			if (ce->index > si->base->cache_nr) {
 				ce->index = 0;
 				continue;
@@ -227,18 +242,48 @@ void prepare_to_write_split_index(struct index_state *istate)
 				ce->index = 0;
 				continue;
 			}
-			ce_flags = ce->ce_flags;
-			base_flags = base->ce_flags;
-			/* only on-disk flags matter */
-			ce->ce_flags   &= ondisk_flags;
-			base->ce_flags &= ondisk_flags;
-			ret = memcmp(&ce->ce_stat_data, &base->ce_stat_data,
-				     offsetof(struct cache_entry, name) -
-				     offsetof(struct cache_entry, ce_stat_data));
-			ce->ce_flags = ce_flags;
-			base->ce_flags = base_flags;
-			if (ret)
-				ce->ce_flags |= CE_UPDATE_IN_BASE;
+			/*
+			 * This is the copy of a cache entry that is present
+			 * in the shared index, created by unpack_trees()
+			 * while it constructed a new index.
+			 */
+			if (ce->ce_flags & CE_UPDATE_IN_BASE) {
+				/*
+				 * Already marked for inclusion in the split
+				 * index, either because the corresponding
+				 * file was modified and the cached stat data
+				 * was refreshed, or because the original
+				 * entry already had a replacement entry in
+				 * the split index.
+				 * Nothing to do.
+				 */
+			} else {
+				/*
+				 * Thoroughly compare the cached data to see
+				 * whether it should be marked for inclusion
+				 * in the split index.
+				 *
+				 * This comparison might be unnecessary, as
+				 * code paths modifying the cached data do
+				 * set CE_UPDATE_IN_BASE as well.
+				 */
+				const unsigned int ondisk_flags =
+					CE_STAGEMASK | CE_VALID |
+					CE_EXTENDED_FLAGS;
+				unsigned int ce_flags, base_flags, ret;
+				ce_flags = ce->ce_flags;
+				base_flags = base->ce_flags;
+				/* only on-disk flags matter */
+				ce->ce_flags   &= ondisk_flags;
+				base->ce_flags &= ondisk_flags;
+				ret = memcmp(&ce->ce_stat_data, &base->ce_stat_data,
+					     offsetof(struct cache_entry, name) -
+					     offsetof(struct cache_entry, ce_stat_data));
+				ce->ce_flags = ce_flags;
+				base->ce_flags = base_flags;
+				if (ret)
+					ce->ce_flags |= CE_UPDATE_IN_BASE;
+			}
 			discard_cache_entry(base);
 			si->base->cache[ce->index - 1] = ce;
 		}
-- 
2.19.0.361.gafc87ffe72

