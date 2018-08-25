Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917B11F404
	for <e@80x24.org>; Sat, 25 Aug 2018 12:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeHYP5m (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 11:57:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36343 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeHYP5l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 11:57:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id v26-v6so5044918ljj.3
        for <git@vger.kernel.org>; Sat, 25 Aug 2018 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MXQDQZUORyRYidj9Z6xbK/eQ2XoLOxmTVRNkxm+RGto=;
        b=Orr1FhW5/RRxs5Yh2zyzfn/Ito++q3j+0MfjBVz7yf3WyuFP61iSQBc3Gba5J/jLnF
         cPz/Jp4/oriIZlFQTXoCHG+//BU+w41BwSlYBLE2A8+QrhihkvywrkmdcDmiv0Mn5dss
         g/8VzQE43IN8OslUNZiqFsD0lpmM9sLN4OuBiajMnAER3MPW35GIxzibBmprIA+JPHYF
         qNRiaefwjQdlRsUi/bqCZbbHGO4+7jowy8lN0AE6CPWsbNd4+hdOuW6Nl5OJy0JvP1ZX
         1RnU8WhlStmabKFIZF2LO2oEFTSHdEnc3mWDs0kuJkvrNAF/SntYAPTQqiBKRnhEIlq2
         xcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXQDQZUORyRYidj9Z6xbK/eQ2XoLOxmTVRNkxm+RGto=;
        b=WmY/fQvqcfd0a0dGYrT038FtukXLZAJz50os2Sd/s7TZJkL8zAiEcyHzMOcgVRdX/s
         wl9jCc73mxKcFYxQpI038/JB2kwAara3E/3CdeAtIFfa25xhVDkvVQ9b3Ohk5yPBt/ue
         tUzqrvTHTVuv7yzi6Y2DfVEBTc4w5Z2hzTYynzxRRP4Mi//fvdERp70T8lkfCCcR+Gok
         9iJa1mTqWKllI29EaqCzrF9qkfVNDLznFu5fNOdwvHCY/U+5+w9LMJeLDeWL8hlnotBz
         +S6A+xfiIK3xbPpgzjUyE4Nu1BZY3ye+9Xb9LV7D0Ier0YInAU7GncOyHF5p/hW+WxzV
         WjOQ==
X-Gm-Message-State: APzg51Agq4UTL9Anm+y0ZuAUibCkvcCIGWrmTF1QkpS0AOzl9qcMRuwk
        hXZTP2utzah/gtPy61cB3U0Rq5SC
X-Google-Smtp-Source: ANB0VdZCIQQz+PfrjJh3D9GqsZQ9HNuQA3OtPCsCEIsn2Wy+dgtytWmE5916ow2l5KwZll8pu/TgNA==
X-Received: by 2002:a2e:9d0c:: with SMTP id t12-v6mr3929006lji.75.1535199532118;
        Sat, 25 Aug 2018 05:18:52 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v63-v6sm1669800lje.20.2018.08.25.05.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Aug 2018 05:18:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, peartben@gmail.com
Subject: [PATCH] Document update for nd/unpack-trees-with-cache-tree
Date:   Sat, 25 Aug 2018 14:18:48 +0200
Message-Id: <20180825121848.11606-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180818144128.19361-1-pclouds@gmail.com>
References: <20180818144128.19361-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an incorrect comment in the new code added in b4da37380b
(unpack-trees: optimize walking same trees with cache-tree -
2018-08-18) and document about the new test variable that is enabled
by default in test-lib.sh in 4592e6080f (cache-tree: verify valid
cache-tree in the test suite - 2018-08-18)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 On top of nd/unpack-trees-with-cache-tree. Incremental update since
 this topic has entered 'next'

 t/README       | 4 ++++
 unpack-trees.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/README b/t/README
index 8373a27fea..0e7cc23734 100644
--- a/t/README
+++ b/t/README
@@ -315,6 +315,10 @@ packs on demand. This normally only happens when the object size is
 over 2GB. This variable forces the code path on any object larger than
 <n> bytes.
 
+GIT_TEST_VALIDATE_INDEX_CACHE_ENTRIES=<boolean> checks that cache-tree
+records are valid when the index is written out or after a merge. This
+is mostly to catch missing invalidation. Default is true.
+
 Naming Tests
 ------------
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 3394540842..5a18f36143 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -676,8 +676,8 @@ static int index_pos_by_traverse_info(struct name_entry *names,
 
 /*
  * Fast path if we detect that all trees are the same as cache-tree at this
- * path. We'll walk these trees recursively using cache-tree/index instead of
- * ODB since already know what these trees contain.
+ * path. We'll walk these trees in an iteractive loop using cache-tree/index
+ * instead of ODB since already know what these trees contain.
  */
 static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 				  struct name_entry *names,
-- 
2.19.0.rc0.337.ge906d732e7

