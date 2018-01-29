Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B1E1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeA2Wip (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:45 -0500
Received: from mail-qk0-f202.google.com ([209.85.220.202]:48558 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeA2Wim (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:42 -0500
Received: by mail-qk0-f202.google.com with SMTP id k27so5453732qkh.15
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=UtiZxT/QXXSjGeQL7RLO0ytacN4c6PNZn3DOg4lX0tI=;
        b=FkVZx/j2F1OPLFXYuMwcWgbw8XymydlKWLr3HQlvk+N/KMJZmXJ95qO+Il3sxpa8MT
         iMOrq1aatYAMdrFtuMhSI3MKbwj0QFvwdtSWfFH6+j7dxiFeIHVeOurvcpctUf0zUv+m
         DR8IMkz2he2T77BzxYdAShvyxfenPK6VGm8ClLOwa1D+umVZFl63WKHXs/mIiEGM/VMQ
         +WxwKQHVHDUKf51eZan9cEtSIFqHEyRcvbrz6nboP500wmwMkxkASOYj+dKrKj7Dd7Iw
         COmask4KHCtQIdfFm4iStfLad/XzxigDg6P0ET3fFd25Z7m35Ii2lfEWnKq2H54mTDx4
         /3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=UtiZxT/QXXSjGeQL7RLO0ytacN4c6PNZn3DOg4lX0tI=;
        b=qoVM0LcDlVZLz2CVNIE2JFMUWN5dO5uafEcCny4GsOjOoyWSHthhQNlTvIow0ccG3X
         DOqNKpVQTkboA+benT6PcukSwKkVL24QClC2WUQL+miGdj2U/u1qpBAteE5A7gEbu0DS
         QiPeYzcm75lw3YT4ez+JWQxTJFjPCUnC+EsgOMN8Gv7z4Op5+clBr3sk2nBUozHNu42D
         KHirsZUdIEhxbk+Coyqr8Xj5xwUBenxfh2r/3yGX9EkOs86I9SrmZzARfuR6541/eJkE
         QFOyz50yVKN75xAmc50tctDTLd41EKNb75bNSmHlE3f3ajcttvpP+Vgkbv/LskZodVub
         dfHw==
X-Gm-Message-State: AKwxytcFDqLiD6NmXhkqhBdT4D4mhKL9tUuiLgCCRtZz5VaoeczuSLJ4
        ttqA4Ma6pxG9JqlXxfa8uNzYMFBPuYutpzdwsHN1n/MVu/i5oi64W5YQ6jnEtrzaVb5tjA2/E7v
        35BOzkmtsftMMpG+y46wR+LaFKDBd3/63qmqXxNVGoa9XF8llHqTxCDDPpg==
X-Google-Smtp-Source: AH8x2251G6HZHWjsb51BJ0Hch2zR4xg6RfA0d610x/BXdgkqIECYMT/Zt9OOQD0L9RB0nruyyRindWQMALc=
MIME-Version: 1.0
X-Received: by 10.200.47.164 with SMTP id l33mr18050403qta.58.1517265521753;
 Mon, 29 Jan 2018 14:38:41 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:17 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-27-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 26/37] split-index: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 split-index.c | 10 +++++-----
 split-index.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/split-index.c b/split-index.c
index 83e39ec8d..8ae4bee89 100644
--- a/split-index.c
+++ b/split-index.c
@@ -304,16 +304,16 @@ void save_or_free_index_entry(struct index_state *istate, struct cache_entry *ce
 
 void replace_index_entry_in_base(struct index_state *istate,
 				 struct cache_entry *old,
-				 struct cache_entry *new)
+				 struct cache_entry *new_entry)
 {
 	if (old->index &&
 	    istate->split_index &&
 	    istate->split_index->base &&
 	    old->index <= istate->split_index->base->cache_nr) {
-		new->index = old->index;
-		if (old != istate->split_index->base->cache[new->index - 1])
-			free(istate->split_index->base->cache[new->index - 1]);
-		istate->split_index->base->cache[new->index - 1] = new;
+		new_entry->index = old->index;
+		if (old != istate->split_index->base->cache[new_entry->index - 1])
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
2.16.0.rc1.238.g530d649a79-goog

