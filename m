Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 435B420248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfCUNSA (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:18:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38686 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfCUNSA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:18:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so4284743pfo.5
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6k7S4UsCQNX2UwDJ14CvFlAqWJ5Noo0hiCcYs4mkZ04=;
        b=FmbRvMlfLJ0J6i9aZruLPEyuPVEGqO0rJVYCF27S0REdOZKtxHXTHLxy+f2AJDK3nw
         /v+nr46+7RotdIsox7rbfe1tHZerARpt2OxcXQApPnbIKoMGGiiXm7CTAfw4X5VA4kNW
         PCxEAwpSJVmKoJZ3u3VMUQYAnxexKgGC4Z3/QcMStYXRwBMcCwpayX7TOu7FOrSgMiHT
         VWW8F8ItGq3BzC/Y4BErdTRA/eNJYt3t0f6Hlzsu+byh8WS9thlIu/d8l1Fx52hXrzE2
         k0OD1QqbPxD+wSq5emjF3XCCuiRG7dIqsyTzdtZq9+5fiJUtZ+9MDU45Tb8I5OiQVfxN
         t2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6k7S4UsCQNX2UwDJ14CvFlAqWJ5Noo0hiCcYs4mkZ04=;
        b=hje7PJ1NZjq77NJvV1+0v88/MxKMSDJqCCdGX3MyUu7d+9hwIWwyi2Xdks71BMBbaC
         O+i1QYNpdT11cInzDYtFJF1jnxi19ouMeVYGmYbNzw2fqm2ztACawT/7NeEwFO5M+Nj7
         SHcmXGoiVy+f2J3z1YCpko8aFDqr/zu9SOGH+KUseZ6STGhYdlDG0KVM8AiJxVNdFrD/
         OPW6WQv1TiSv1qX5N1UOky+ag/h1Ci1A41J2Ty6kxTW29/2AVFwlZeVHpRgOCf+yYuJC
         RI9Ob328ZjRqsTbWV+Ek3ehTSmilR6+32pQgmAq6fNPqw2l/eV6VQi0cGrDITUC1gFIM
         LAzg==
X-Gm-Message-State: APjAAAXn0HW1fN8hT9bBhlJOIeTr/ABXqsNm6d/nnDuQAna+1n9RYqDY
        rFcYhx9dJeluOy+gnmeueik=
X-Google-Smtp-Source: APXvYqygoKZgkPddIvcMMgB/uqZCBRXiIg4ow4es9kNGpPx9PNEh6hFO5jycHf9SsHlGO3rxELp0lg==
X-Received: by 2002:a17:902:76c1:: with SMTP id j1mr2125906plt.224.1553174279286;
        Thu, 21 Mar 2019 06:17:59 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 8sm14786104pfs.50.2019.03.21.06.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:17:58 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:17:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 07/26] checkout: keep most #include sorted
Date:   Thu, 21 Mar 2019 20:16:36 +0700
Message-Id: <20190321131655.15249-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The include list becomes very long and frankly a bit unorganized. With
the exception of builtin.h, cache.h or git-compat-util.h which have to
come first, keep the rest sorted.
---
 builtin/checkout.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e6037b296..f7801db2fb 100644
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
2.21.0.548.gd3c7d92dc2

