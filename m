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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2871F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbfHOVln (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44801 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733033AbfHOVlk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id c81so1963280pfc.11
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQ/sokOrLCWhBiO+DHNODkNVnegRHu3WrqDW3BgGqNE=;
        b=oYeBpnVH6kT/BMvkbwD8XcDdbfYinrMvYBBv7nEkThd02/UNpa05P468Hn8S0bC/J/
         skqawqqfNrRxFCbXOv6Io7V4FldjjHfF2o0m01WHyPRAsOI3/KHGtJooT/R2TemuqZ7a
         a/IA5jDHBzrXYQosYx9JufOE0zD/f/6DyBafXI79m3PEh0pCkfupo7ayj0I870BISzHr
         imlyh7GPrfX/ZXH81Kxfx/nwcmTV+gOC9peuLbxIBW7Uz2PTP+8a1JSyb4V2wUxkZzL9
         ARaU2a1aV4ekJOse2Gb8ln8TkhwOyu4z1hqH+FB+hdjW2XAlqeJXFTrVknBJmFXN63D/
         KVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQ/sokOrLCWhBiO+DHNODkNVnegRHu3WrqDW3BgGqNE=;
        b=djsuMYXE1t70S9Ym4tRz+YS4fJnljuT1JhyRg6YvKmsuD8pMq9twtoRfhrLZB0m0lu
         AtBjhsPcwgS2xmoNlDySwHI5cV4IMagVpzJWO6Yp2FERUzGnKyMEJODxC8eugrreXEkA
         dptwcKh/i6wfnHa+V8ypXsyX+ZuPzd95ayxSlu4Qv1aIkUulahFqhvQsPOptxgKUD/Ky
         4dBzBw27Y6IT4omdnFvAuEXpB2/eUD97V2YDAcmnGqqj4fkqLifXIUfhJc2UO8hTLETh
         6kWHvTNDyRmnR36KZeQiHYBGE/580l+ZXmBQg8y1Y83VY5Xl0ryTmym36z6BNOZK7iDU
         73rA==
X-Gm-Message-State: APjAAAU8Emg1DwRrd1bpRWh54QclEWZF9C/+ZNUWMFh6guAl0Ykv3byv
        0TS6v+TbNlD2izAffkbbD4S5Eyad
X-Google-Smtp-Source: APXvYqxirNKFfIKHkpbvlRUidd7Nmp9TvyLDRDIAsuGLrx0iO0qzSd9GQbSApPVk8nW3ZHhGApSfpA==
X-Received: by 2002:a17:90a:32a3:: with SMTP id l32mr4205748pjb.14.1565905298931;
        Thu, 15 Aug 2019 14:41:38 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:38 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 24/24] merge-recursive: alphabetize include list
Date:   Thu, 15 Aug 2019 14:40:53 -0700
Message-Id: <20190815214053.16594-25-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
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
index bc0da608c4..d3dc3d8a49 100644
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
2.23.0.rc2.32.g2123e9e4e4

