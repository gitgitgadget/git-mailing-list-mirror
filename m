Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEAA820248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfC2Kkf (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:40:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40615 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbfC2Kkf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:40:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id b11so848614plr.7
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=svOkbNdDOrggytNmnIrVFal2C5hGkIl4fnfkuQpwpf0=;
        b=Tj9vf6N/9Fx5UK3n7Z3vizmF+1ut72KvIU3gnPH5ysQlnAZpXYe+mJ+9UMPBLA4eeE
         knUxzrFuWXavg1Rw39xwfKAHp7oxjSlcDhxSELxSkjLJHkkbFkUlVO3tmMYc84wwRz57
         aWOfxryIZwWV3i5K7VIe4gsNVyjTCiYUnEvKtWMQc+s4FDGrOFEAeYpIWGRHbRgAEUDt
         V8qVgW3cwU6FxlIqXpt2NA44pFsgEBbZP60SjruO6DXaE9q7sh3Iv7IgYoY9jsnVaNls
         V9Ns8aJMYiOycs6r//QBUm/9byDIs81RFesqX1h8ikbu7708toQM0YzevQ7xChJb3gDW
         KHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svOkbNdDOrggytNmnIrVFal2C5hGkIl4fnfkuQpwpf0=;
        b=QIDgsWYTUBqYTbCePppf8SUFLHYYyvIMSaMwYQzoSAOfVCFgyjQ/Pq5t+lHNe85GyC
         XaCY8NBg3rHYthsBXpZqb2qw8sfRlkW+QnI18UF6+flaPIuG8Z9VIA+MkFzNISKcv+8D
         rqDCd6D28VFsfB/mFEEjYQmxRImdPY9S6R+9tmo3oAPZOugKH0R69KUNSB4jPf/XiJ53
         X/qvHy+1kvyYrhmDqqHblkUb9iCRrp3qiZW0FRAjAl1oDH2beIgzzFs7zXJI/AbQC4KV
         FXNixnoUaz0nIVkQrOoG72PK8EYIrkaxKWIXSPZiwTjc9qOik5Vvxmj6d0/18AO48nPc
         HKfQ==
X-Gm-Message-State: APjAAAW0Dg5f0CqRrHqYOgjsndaGJZC+Tdbq7N9GMIfzWgW+RbIBGEel
        qpuJG2t88Em3N/DQbnq7WpA=
X-Google-Smtp-Source: APXvYqzlIjjAjEpY9EysQqYpekbxJRGzXBuF8fDX9FrPvttOAbbbVDooCUszUbqdkXJnM3HUpiATAA==
X-Received: by 2002:a17:902:bf07:: with SMTP id bi7mr25660007plb.87.1553856034972;
        Fri, 29 Mar 2019 03:40:34 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id v189sm6008117pgd.77.2019.03.29.03.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:40:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:40:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 08/27] checkout: keep most #include sorted
Date:   Fri, 29 Mar 2019 17:39:00 +0700
Message-Id: <20190329103919.15642-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The include list becomes very long and frankly a bit unorganized. With
the exception of builtin.h, cache.h or git-compat-util.h which have to
come first, keep the rest sorted.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f66bd2f56d..15ee5181eb 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,30 +1,30 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
-#include "config.h"
+#include "advice.h"
+#include "blob.h"
+#include "branch.h"
+#include "cache-tree.h"
 #include "checkout.h"
+#include "commit.h"
+#include "config.h"
+#include "diff.h"
+#include "dir.h"
+#include "ll-merge.h"
 #include "lockfile.h"
+#include "merge-recursive.h"
+#include "object-store.h"
 #include "parse-options.h"
 #include "refs.h"
-#include "object-store.h"
-#include "commit.h"
+#include "remote.h"
+#include "resolve-undo.h"
+#include "revision.h"
+#include "run-command.h"
+#include "submodule.h"
+#include "submodule-config.h"
 #include "tree.h"
 #include "tree-walk.h"
-#include "cache-tree.h"
 #include "unpack-trees.h"
-#include "dir.h"
-#include "run-command.h"
-#include "merge-recursive.h"
-#include "branch.h"
-#include "diff.h"
-#include "revision.h"
-#include "remote.h"
-#include "blob.h"
 #include "xdiff-interface.h"
-#include "ll-merge.h"
-#include "resolve-undo.h"
-#include "submodule-config.h"
-#include "submodule.h"
-#include "advice.h"
 
 static int checkout_optimize_new_branch;
 
-- 
2.21.0.479.g47ac719cd3

