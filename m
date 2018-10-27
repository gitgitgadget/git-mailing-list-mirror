Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 420BD1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeJ0PuO (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:50:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43534 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbeJ0PuO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:50:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id u18so2517021lff.10
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ElWD/L0AMYKRyntyrlVCHl2EzE6d7g0uBaIj7GWAy84=;
        b=HD7yKadnutXGrUUEP/9dIchJvjQrufbpCAzPEvvyrFN5jWvCfKqi/7S4TDa0vtx9gj
         BfOKu+bjiofjUZH4dDmFoKdgDsnLW70h8rCHSCLYdBIo0oYLJDJcu0tmAVe/8pFeOYfu
         V+vn3e9Rct+Sq4OYdC7WGSdxcKll8qorAJgj/qzPnxHwPDXWll37y9DmtLLefnN51bUt
         cehbOX0UQZZGR3sD4+lhAetSc46SO6dxjwoRbCXSmL9DcgDWkewrUTNbYEiEQg7aCpHI
         CyELpJcLgdXJjalTI57KD53B5c1DfK8Q2/bxB78sLSvAjP3DlQ9eP3XuKOs+cjJVO3+t
         zF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ElWD/L0AMYKRyntyrlVCHl2EzE6d7g0uBaIj7GWAy84=;
        b=IkCO0Rm8XpL8C45CwHg1lgGAAXlpXb0qO8YlMw7eCv2hcEs0YtFR2VWAUne+3eei4+
         RYdjPCQ4UBToQyuFftUPsqn+gr2kORdpiMhp4+0hDw01LKYS+sO8gddBfEuJlzsHfQIA
         0uKFHY9GZV5vQaofPud3JQG4L7rVxrxNjDBNFHFXE///tKRdj+H44QHkUgLjQbNt46gN
         A2RuzzPFieQAPpKbyzdS3sj9WNGwrYFfwa9AZSD1j7gwEvsBsXV24C/vLmNegzOF/ZOk
         0IMpFfX0PDi3R3jFRsjjluBiNlN8fOAul8DK0WRrVRZj8AbUZ+6x1mDsAiykt7NVObDx
         cDXQ==
X-Gm-Message-State: AGRZ1gJJ9IFfR3mNE1g+JlDUGOZLW84tRpXTPcUyuFKEJf/T8h6TeniB
        947aVqW2tu1qpTdKeBwC2l5xFnwh
X-Google-Smtp-Source: AJdET5cD9tm4ejVjSmG9WmoICP9b6jJkUxEn7Y52i6Qph6uflT2gSrvJMe74kGt0KSz5lr+toSXzpQ==
X-Received: by 2002:a19:d58e:: with SMTP id m136mr4238219lfg.70.1540624213051;
        Sat, 27 Oct 2018 00:10:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1534899ljr.21.2018.10.27.00.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 00:10:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/10] name-hash.c: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 09:09:56 +0200
Message-Id: <20181027071003.1347-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027071003.1347-1-pclouds@gmail.com>
References: <20181027071003.1347-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 name-hash.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 1fcda73cb3..b3c9ac791d 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -7,6 +7,7 @@
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "thread-utils.h"
 
 struct dir_entry {
 	struct hashmap_entry ent;
@@ -131,22 +132,6 @@ static int cache_entry_cmp(const void *unused_cmp_data,
 static int lazy_try_threaded = 1;
 static int lazy_nr_dir_threads;
 
-#ifdef NO_PTHREADS
-
-static inline int lookup_lazy_params(struct index_state *istate)
-{
-	return 0;
-}
-
-static inline void threaded_lazy_init_name_hash(
-	struct index_state *istate)
-{
-}
-
-#else
-
-#include "thread-utils.h"
-
 /*
  * Set a minimum number of cache_entries that we will handle per
  * thread and use that to decide how many threads to run (upto
@@ -516,6 +501,9 @@ static void threaded_lazy_init_name_hash(
 	struct lazy_dir_thread_data *td_dir;
 	struct lazy_name_thread_data *td_name;
 
+	if (!HAVE_THREADS)
+		return;
+
 	k_start = 0;
 	nr_each = DIV_ROUND_UP(istate->cache_nr, lazy_nr_dir_threads);
 
@@ -574,8 +562,6 @@ static void threaded_lazy_init_name_hash(
 	free(lazy_entries);
 }
 
-#endif
-
 static void lazy_init_name_hash(struct index_state *istate)
 {
 
-- 
2.19.1.647.g708186aaf9

