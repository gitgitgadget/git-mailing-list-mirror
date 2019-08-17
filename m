Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213041F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfHQSmb (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41495 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfHQSm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so4805246pfz.8
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DstNdmycUb2JZhQmaD3K5ZRDoDByrjearqLDurh0Clo=;
        b=FWCmXHO6W3on1BxzPm3Yrg4NvH8Fgbqvd4WtJS1OVklWSmnR2DXRrSh0eGmeOixVdy
         8fRww+Mr7VOkwQ3OoglxToDEu0ZAp/0hsxAkUnFPOD+l+zFgBA0HsHWrYzOanNI8U4GZ
         nZ1kI02z7k784/mIBduj5VqEuphFq/pZ2jMYhnvNZASl+yxvDG6j+1WEel2zhLbVBB+d
         GClASAbHfOuBDd7WXV46MnwyaNVoaVP6irWX1q36XNKCL1CV1Z2jhUjDovkDpSlNhZdS
         jCykI6J17XvW5laa9JOi3uW2u3UZrH71/o454II/taWI0KRf4RNSu+EctEKV80OTH1eN
         giMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DstNdmycUb2JZhQmaD3K5ZRDoDByrjearqLDurh0Clo=;
        b=Xbe7k5rARCoVU3I6psvTYYaPlCtjuK7oDqjZbCr2TkZrbfh7UuAzg3yt85bb5lNNVV
         E4zYlnGwirqslVeVXGTSnVxNIbyrf3HsP5TZr2Z5tn77377R4yDViRUVTePmadDr1yiO
         IeWCfiZh1wa+8UPKIcLmgx3pf37iVzXKP7efSRv3IS2xe02fKAqIwTS9W8Cwg6Y+IWlG
         D3a2j8xPDwRRnaY3oRbg32qDiuyXAM/TuTSvG0wCR9YIGW+NRHCJEo+EdefUD/RQZh5u
         GfMgGiP/OTzoMXt5m4DFYh/sfav8DeeaXiTu39W4e5HAe2MVp4BW6GG24ged21G7mtr9
         J3ag==
X-Gm-Message-State: APjAAAUV5GBdKHSjZVnKu80wtoLAq1XpjJlA9dOdBk3lXj6kNqEX3LQ/
        Z6Bj9BU35C9l4OuxVStx9F09oNvR
X-Google-Smtp-Source: APXvYqzxZn9DeuHe6OYal8n4KUFtVnpgoiYS5aXbZDo6a9r8xb9mfaMGQ+2oZGdftznpWma+2b93/w==
X-Received: by 2002:a17:90a:fd8c:: with SMTP id cx12mr13173170pjb.95.1566067345156;
        Sat, 17 Aug 2019 11:42:25 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:24 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 24/24] merge-recursive: alphabetize include list
Date:   Sat, 17 Aug 2019 11:41:44 -0700
Message-Id: <20190817184144.32179-25-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Other than cache.h which needs to appear first, and merge-recursive.h
which I want to be second so that we are more likely to notice if
merge-recursive.h has any missing includes, the rest of the list is
long and easier to look through if it's alphabetical.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0231d7b049..b058741f00 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -4,30 +4,31 @@
  * The thieves were Alex Riesen and Johannes Schindelin, in June/July 2006
  */
 #include "cache.h"
-#include "config.h"
+#include "merge-recursive.h"
+
 #include "advice.h"
-#include "lockfile.h"
-#include "cache-tree.h"
-#include "object-store.h"
-#include "repository.h"
-#include "commit.h"
+#include "alloc.h"
+#include "attr.h"
 #include "blob.h"
 #include "builtin.h"
-#include "tree-walk.h"
+#include "cache-tree.h"
+#include "commit.h"
+#include "commit-reach.h"
+#include "config.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "dir.h"
+#include "ll-merge.h"
+#include "lockfile.h"
+#include "object-store.h"
+#include "repository.h"
+#include "revision.h"
+#include "string-list.h"
+#include "submodule.h"
 #include "tag.h"
-#include "alloc.h"
+#include "tree-walk.h"
 #include "unpack-trees.h"
-#include "string-list.h"
 #include "xdiff-interface.h"
-#include "ll-merge.h"
-#include "attr.h"
-#include "merge-recursive.h"
-#include "dir.h"
-#include "submodule.h"
-#include "revision.h"
-#include "commit-reach.h"
 
 struct merge_options_internal {
 	int call_depth;
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

