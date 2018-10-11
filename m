Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630E41F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 09:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeJKRJy (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 13:09:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41597 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbeJKRJy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 13:09:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id x31-v6so7628330edd.8
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PgSnHPmvDcgGC3D5mJ/lyYZ+UynD+cy6sVm85rVUZQw=;
        b=c1LVKVcd0P8Wo5CyJoyw/ytd6XGEHYEzYESpZaNJ6EmrJ7f3x4iqcxhdgoZYs94i8y
         8DGKmWhx14LsOk1R4yHRzLOUrDr5ClkC1qFAsS+cBi3EmGCkCdb0lqkh7NqXNQit+ZFu
         sOwgcBrF/EMMbEFcBxO+n8M+9ry1pRyvN9i+2UYr7pOiBYGmySavl25R057FJNmG8JvP
         CI4wc97nt712DbKJsx5TWWZw9wxybiCuX50SZz+njbITh7Eu7HpHxxgK6EAsQTC5es2F
         HeBZYA4q2foLOXaair9eVM4mwO0QK5w9MljgHdJCM7zPOTj7ycNOeeBeulLR6pJNOyH+
         Szvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PgSnHPmvDcgGC3D5mJ/lyYZ+UynD+cy6sVm85rVUZQw=;
        b=I4rvZqJjfhseoutKJZcVc3YDTmgVVM9WdycQDzr+LZvlU1qCxHn9SA8RVWJN6K+5EF
         exoGBMcuwSYINisSD2WMJktP3ATChyiHrxEk0Ndbh6HVXW9k+CEQteTPqE2GvhKA72QU
         W1njgB710bIU5FKLbSu0U0LkoUdzJbHlKsICnTt52q6P3niNl+uZ5LOFmWV0++4XOjRc
         IPZf+LUeNvkG2+X39xJ35m/JfvB4y8CA1pnx9DSqMUNnAgeTOM4NCJ+wi1M7404cL9o3
         xYD0gWeKrRidPn8pGZ3uiP9zX6ttyIAX0jA1NOtgGFKf0ynHQW4CVW/Wmp3k7DGJJGFw
         UaTQ==
X-Gm-Message-State: ABuFfogi7Ul3CMEEqBm2nI4pOGqXE2kEfk55AnOGDLUNHuBP9xOioxY9
        xlZSv3DPA+h4b+SsaGj/efY=
X-Google-Smtp-Source: ACcGV62jqB5hr+5IonsqxmoIww4XjOVUxEZXDhibrHsCmYDPbKe8TZoandrBXeGRj4ttBFDa3edcaw==
X-Received: by 2002:a17:906:168b:: with SMTP id s11-v6mr1386656ejd.228.1539251002800;
        Thu, 11 Oct 2018 02:43:22 -0700 (PDT)
Received: from localhost.localdomain (x4dbd43b4.dyn.telefonica.de. [77.189.67.180])
        by smtp.gmail.com with ESMTPSA id q25-v6sm7034721eda.18.2018.10.11.02.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Oct 2018 02:43:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 5/6] split-index: don't compare cached data of entries already marked for split index
Date:   Thu, 11 Oct 2018 11:43:08 +0200
Message-Id: <20181011094309.18626-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.465.gaff195083f
In-Reply-To: <20181011094309.18626-1-szeder.dev@gmail.com>
References: <20180928162459.17138-1-szeder.dev@gmail.com>
 <20181011094309.18626-1-szeder.dev@gmail.com>
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
comparison of cached data if the flag is already set.  Those couple of
lines comparing the cached data would then have too many levels of
indentation, so extract them into a helper function.

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
 split-index.c | 89 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 17 deletions(-)

diff --git a/split-index.c b/split-index.c
index 548272ec33..187b910f5b 100644
--- a/split-index.c
+++ b/split-index.c
@@ -188,6 +188,30 @@ void merge_base_index(struct index_state *istate)
 	si->saved_cache_nr = 0;
 }
 
+/*
+ * Compare most of the fields in two cache entries, i.e. all except the
+ * hashmap_entry and the name.
+ */
+static int compare_ce_content(struct cache_entry *a, struct cache_entry *b)
+{
+	const unsigned int ondisk_flags = CE_STAGEMASK | CE_VALID |
+					  CE_EXTENDED_FLAGS;
+	unsigned int ce_flags = a->ce_flags;
+	unsigned int base_flags = b->ce_flags;
+	int ret;
+
+	/* only on-disk flags matter */
+	a->ce_flags &= ondisk_flags;
+	b->ce_flags &= ondisk_flags;
+	ret = memcmp(&a->ce_stat_data, &b->ce_stat_data,
+		     offsetof(struct cache_entry, name) -
+		     offsetof(struct cache_entry, ce_stat_data));
+	a->ce_flags = ce_flags;
+	b->ce_flags = base_flags;
+
+	return ret;
+}
+
 void prepare_to_write_split_index(struct index_state *istate)
 {
 	struct split_index *si = init_split_index(istate);
@@ -207,13 +231,28 @@ void prepare_to_write_split_index(struct index_state *istate)
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
@@ -227,18 +266,34 @@ void prepare_to_write_split_index(struct index_state *istate)
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
+				if (compare_ce_content(ce, base))
+					ce->ce_flags |= CE_UPDATE_IN_BASE;
+			}
 			discard_cache_entry(base);
 			si->base->cache[ce->index - 1] = ce;
 		}
-- 
2.19.1.465.gaff195083f

