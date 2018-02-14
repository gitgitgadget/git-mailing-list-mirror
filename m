Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75EC1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162568AbeBNTB4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:56 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:49464 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162545AbeBNTBw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:52 -0500
Received: by mail-yw0-f202.google.com with SMTP id b11so27357833ywc.16
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=jsXLrXj5ifey0J8rtv5HfRyEl/pkSBBWwSoYHZ7p3eU=;
        b=UGdwoT+VeoH1fwmK69Czo/OvB5OBYgmX7F4OcfuFrJVef8uiF/Zet7wVAHu1sVYtot
         87YpeWQDEPSKYNOnvaymBe67GRgqyVq5qusItOwGB0flvIUaow7enWi87dFmdqsOSWX2
         Y/Gni+xpoI9hxPqNyx3jwrVXe+6/s7anga1n9AYgIUBVHZCwIalqrOjscjzs3Wpl/Rdc
         0AGpt3Pi/ScRAo0FyofquDhxxd8AgpAnlAffVUGG2O1tEgI83fB8IbVkwatigrfmovwi
         4PRFLelD4mVT0uK6a/lfPGqQ1m2OkvuGM9pvSjlGESIDTXH/7uXUgcN0ETVDD39pR0/Y
         9teA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=jsXLrXj5ifey0J8rtv5HfRyEl/pkSBBWwSoYHZ7p3eU=;
        b=fqXO66kCcQ49jv7lW+yrflCP6LUUqCN071/jl/7ah6xXHGp+azYhQX1/0JHrDa4L1z
         21DqP5KNGDrzsHijEiiBJpmphY8K0mAUMmspKjgEfSdcpFLE36MmJaHkO0cRDAdN9nMl
         lrJTtb4BEDgpnwH4c5nUIb1/zdh8WVzwGRa6AyiYrpIFrA47TH1yf9WRlxcJ8VsxNMaj
         H+/KZQnroCabYmCrr+2f5SRiRWpCV+7ZmSFTwrArWrYuay7wKgVcjkLVz907rWNeJdkI
         CwKfAI0X036rCzO9jHB8W5iDb0vVMh+ORA/r2HkP4qhAZJQuWKSRkxml8/zDQAaw/36B
         287g==
X-Gm-Message-State: APf1xPC1iK9oM0hwtDUF98gtU/XpXdvAM0TVp6mo53rt63Al0Bc7jvGE
        iAZeoJ1dnRDrNArHWRYemCnKOcCJQk1r6k3VOEouJ89fEiL7B8WFXZPD+a/Rxcq7bPTgM2IFF0/
        uENdzmO+0Np/UWuqDf9Vfhi9iWxEKTQDLps6hsxB2kaC4Lh3Ad0f7hbOZGQ==
X-Google-Smtp-Source: AH8x225q31RFWEaHb5dMS0nxIIxQoSKg4KH5m4nSa9kXhyNWfs+6QOhAbjaxnzYW8FS5EXg51eilqrNoQiM=
MIME-Version: 1.0
X-Received: by 10.37.189.199 with SMTP id g7mr3143390ybk.9.1518634912105; Wed,
 14 Feb 2018 11:01:52 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:48 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-27-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 26/37] split-index: rename 'new' variables
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
 split-index.c | 16 ++++++++--------
 split-index.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/split-index.c b/split-index.c
index 83e39ec8d..7be5f748a 100644
--- a/split-index.c
+++ b/split-index.c
@@ -303,17 +303,17 @@ void save_or_free_index_entry(struct index_state *istate, struct cache_entry *ce
 }
 
 void replace_index_entry_in_base(struct index_state *istate,
-				 struct cache_entry *old,
-				 struct cache_entry *new)
+				 struct cache_entry *old_entry,
+				 struct cache_entry *new_entry)
 {
-	if (old->index &&
+	if (old_entry->index &&
 	    istate->split_index &&
 	    istate->split_index->base &&
-	    old->index <= istate->split_index->base->cache_nr) {
-		new->index = old->index;
-		if (old != istate->split_index->base->cache[new->index - 1])
-			free(istate->split_index->base->cache[new->index - 1]);
-		istate->split_index->base->cache[new->index - 1] = new;
+	    old_entry->index <= istate->split_index->base->cache_nr) {
+		new_entry->index = old_entry->index;
+		if (old_entry != istate->split_index->base->cache[new_entry->index - 1])
+			free(istate->split_index->base->cache[new_entry->index - 1]);
+		istate->split_index->base->cache[new_entry->index - 1] = new_entry;
 	}
 }
 
diff --git a/split-index.h b/split-index.h
index df91c1bda..43d66826e 100644
--- a/split-index.h
+++ b/split-index.h
@@ -21,7 +21,7 @@ struct split_index *init_split_index(struct index_state *istate);
 void save_or_free_index_entry(struct index_state *istate, struct cache_entry *ce);
 void replace_index_entry_in_base(struct index_state *istate,
 				 struct cache_entry *old,
-				 struct cache_entry *new);
+				 struct cache_entry *new_entry);
 int read_link_extension(struct index_state *istate,
 			const void *data, unsigned long sz);
 int write_link_extension(struct strbuf *sb,
-- 
2.16.1.291.g4437f3f132-goog

