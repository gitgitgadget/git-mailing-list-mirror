Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FBC31F404
	for <e@80x24.org>; Sat, 25 Aug 2018 13:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbeHYQl2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 12:41:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43976 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHYQl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 12:41:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id m84-v6so8858755lje.10
        for <git@vger.kernel.org>; Sat, 25 Aug 2018 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RFx1JOc0tbpbaOnpGGx4m5Guu20gZVImewwO4zAeB5A=;
        b=ctfEuJgn+SZ5U537qJvjvgbF57fuYQTOSTudgllfu9jrq8N55b4gSPcaxFwYqofIMP
         tmebje3CMGYznun0KGbkvkyGXUgajGWU8cvDVpX9oV1CDoPPLUftG9OHEa8q9wsnEUcC
         x0xUcTT7qhpINY0MFMQn5tekbFE2jFU18O/sCcGWV8D0jAWBTqYTGtysT9OceHJLNjmT
         WKJOSryecjBJtPnUgmvOgpaEekos+5DwOf2hVPZOS0o76cfPv9Z0uhQ5isb0RH+WKM0h
         6Hwmb3hrvyJQdv20+UZIOTW8on4ehDZnd2iGQ6+NcI/reDlkiGLQbbHnst0QxK/G7Fg8
         HiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFx1JOc0tbpbaOnpGGx4m5Guu20gZVImewwO4zAeB5A=;
        b=O9EKnRLqEFttwHJ5+9Yc0bs6SSNEZFqPLpRkOcSNBjJO6uRTIP37aMOhw/NAAROwBJ
         oNb8FoO352kVIBc0U4x85NAayUTnvW7yi1bZodAa5Gz0os+TPVOEnfL8C8gCnBiCektH
         UStNEsZnDp/cYYwJa1euZY8eJoMfevMmOrxYaqKl4dogUVUihYAWL7H5Bd4cHNQX9QSi
         jCJ9gEL7WdU7b0PmftOtIf3gd0UyfCdWT95ahdwVhhGdicIhAvqZWz5JBnNIbOPX/BZI
         EmtuKZdTGA2Vkgp5k5pnjboS1UNd35XsAxPMhzVOHRQuIl77pTwHrdP7zBn/CAy2eN7g
         g7gQ==
X-Gm-Message-State: APzg51CPD/c2HTj8gPYSWYaLTDkIuhEQtjgiUXxEGF+VHyGDuJB9hJIO
        5Z5lvYOvtP9lcCtuo1tl42I=
X-Google-Smtp-Source: ANB0VdY4ORwR/+VyFtgE8cUTJOi4WMPdhIJHlu4/h3wqYhDfMF2PRugs33dgYT/yaD7Spq7i5ZuXDw==
X-Received: by 2002:a2e:9e17:: with SMTP id e23-v6mr3869970ljk.14.1535202151389;
        Sat, 25 Aug 2018 06:02:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id m187-v6sm1803145lfe.45.2018.08.25.06.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Aug 2018 06:02:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, peartben@gmail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2] Document update for nd/unpack-trees-with-cache-tree
Date:   Sat, 25 Aug 2018 15:02:09 +0200
Message-Id: <20180825130209.31231-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180825121848.11606-1-pclouds@gmail.com>
References: <20180825121848.11606-1-pclouds@gmail.com>
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
 Some more typo fix, found by Martin.

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
index 3394540842..515c374373 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -676,8 +676,8 @@ static int index_pos_by_traverse_info(struct name_entry *names,
 
 /*
  * Fast path if we detect that all trees are the same as cache-tree at this
- * path. We'll walk these trees recursively using cache-tree/index instead of
- * ODB since already know what these trees contain.
+ * path. We'll walk these trees in an iterative loop using cache-tree/index
+ * instead of ODB since we already know what these trees contain.
  */
 static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 				  struct name_entry *names,
-- 
2.19.0.rc0.337.ge906d732e7

