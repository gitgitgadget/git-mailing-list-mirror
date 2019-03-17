Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187CE20248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfCQMuW (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:50:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40710 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMuW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:50:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so9495465pgo.7
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRw4e9Z49Srn4PA5kic4hUSUB7KP+A4aAL1T9mkWKWE=;
        b=HsDdYaRkShGggjA1lIPOnnu2jf9L6v3d8aPQeJbTMUPwH4mf41HxGU1yG+YdZJf4iN
         SeFHAk0F102nyIHjsKBRtRpO5WoIH2sDNSPz8Trvii0QPLx3UmKC98Rn3nWtoj5Ps+I5
         UYAbYWzkiNKMQWWcFFUiPoBUu2yJ1EucBqYMXjuPIPOzJ/f5wlPG16zarHFp6os7rUBs
         5Kq0CF7Vu7LcXe7qxL03aD7x2ysVySR9P04LXDfSPtvAa31DURgYGF3h8z17JNIgP3WL
         yI6Gj5xnVzrvkI4LpJmlBQbjN6IKhcfvKDe0ydNoBCrTdY8TsX89z1La+7yHXjARRwv1
         abxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRw4e9Z49Srn4PA5kic4hUSUB7KP+A4aAL1T9mkWKWE=;
        b=AjqqKlg/FmYtKE5ZnAdH32b72aFFtcRMuOm+bN8STM2u8vZvH/XEreRts6rGzzjME8
         yjmGzZF/O1VyP8sbks7qTj++Az/Opu8R3kJmIz+PM/TbfkGEkG0qDMq1Kcd2LXoWe+FF
         lvbS3X8JEr5agdBTeHwWxAR8U9mpl0KpHtFqFR5sRwr8r5keF6ZVWk//+By9EhakHRLX
         SoJCEBvcxqzUW72HAiDV3X5w8BcKzMegiQOtSkBkqP4RvT1cLj88gdUWC96x4Gj/nbRi
         Z0eIjMjAq9kPMsaMwecXgiG+lCaKpJRaEEYVazSpGBhWyzupDipg68vBCGkUvn8H+7UM
         w0Vw==
X-Gm-Message-State: APjAAAXB/QWuk7uYuXEb0lf122BVH8Ums3VlkrMOmpk8xTexmKTfNXt2
        Huw5vAH3I4Iqv8M5IS2rnTIcNzxn
X-Google-Smtp-Source: APXvYqyqP4e3TyhJUktVkv9xSJZ4LnTVZftmI+i5kCxGMXISdn7FpOeHl44RgvnnWiicVNxM3JA3MQ==
X-Received: by 2002:a63:e113:: with SMTP id z19mr432414pgh.87.1552827021744;
        Sun, 17 Mar 2019 05:50:21 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id b8sm9642093pgq.33.2019.03.17.05.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:50:21 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:50:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 07/26] checkout: keep most #include sorted
Date:   Sun, 17 Mar 2019 19:49:07 +0700
Message-Id: <20190317124926.17137-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
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

