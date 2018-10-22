Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AEDF1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 15:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJVXYT (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 19:24:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36963 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeJVXYT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 19:24:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id d14-v6so46644280qto.4
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ntY0X6gkuAwwUnHOso+jRq99fKHpaCrK4hW01UuO+f4=;
        b=c5UY1TO9pXV35WZddXx1RgCeo3uS/YBs3ZMRSiZeAOo/Dr4mPx72ubymS4HI9GzJK3
         0KTiJ/55znldzEKgfiNSDHXoBQ/TppB8s/2pPAEb6nKl4NkLtWDTOKmxWHs8wZsCfDRa
         AsF3xSxAy0PzULdODY4Kfb/Ln2rdKU43HGKTnISbMMja91EzUHq+DDVky2PTmg2EHcYv
         ocRow8rx4wirk5CRgRxwklbya/IfYjPZZsinBz/clXJ+ALDeVwZbQo5/FPINrWkkaRQf
         J4Ss5Q3mmDsWgjyIeGsULA+VxLcJOk4hnEPRPJgQjVvLx0q1wnhmyKDebb5fT/39g1fC
         H1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ntY0X6gkuAwwUnHOso+jRq99fKHpaCrK4hW01UuO+f4=;
        b=AnnYTYwqqtuSznnlxC78z+5ZDgVNaPJX0CDGbggUR2BPIOZL+ZMr35Pzrv87dqI872
         cIpyUbH1hBSu5GmVy8B64aciux0SLhdO+BPG0sB6cuR46DXRp2eVGeD61IC+ihdV1ZWo
         iRjL3hE88/k5d7SMzC6eD7SPVsZrJJisVUPsHgvm2aEDPnc77nsl96QltHNtuPtpgnaj
         iUH1lSc+UgVPQptxxYZLK9bRVEZ4gBpsbVk4qtMn69t/5m6LMzeo1wdDfJu5LNr6hA04
         gGGtXLkD+rUJnRQW8R6YrPu4HcYDzV14eKQngq1Z4y+fg0HyjUyNWr4w5Nvr/lzoxPHq
         WW8A==
X-Gm-Message-State: ABuFfogS9DErRO8VD+0DWKo3mIMsOUDntwlZR8cEaZ0Kllx5D3Ptm6CA
        QKAO4ep2XwJWPBHIaRbAQD2ay37Fm1w=
X-Google-Smtp-Source: ACcGV61Gp+RN6Sk/PLxsXO4c/m3lVM6PeBub964aFmIEi5Owr5J/vCZyjAZZjBdHaWyg5sZxrr4jEg==
X-Received: by 2002:a0c:959a:: with SMTP id s26mr44957058qvs.199.1540220722913;
        Mon, 22 Oct 2018 08:05:22 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id h25-v6sm5581288qta.89.2018.10.22.08.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 08:05:22 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1] load_cache_entries_threaded: remove unused src_offset parameter
Date:   Mon, 22 Oct 2018 11:05:13 -0400
Message-Id: <20181022150513.18028-1-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Remove the src_offset parameter which is unused as a result of switching
to the IEOT table of offsets.  Also stop incrementing src_offset in the
multi-threaded codepath as it is no longer used and could cause confusion.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref:
    Web-Diff: https://github.com/benpeart/git/commit/7360721408
    Checkout: git fetch https://github.com/benpeart/git read-index-multithread-no-src-offset-v1 && git checkout 7360721408

 read-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f9fa6a7979..6db6f0f220 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2037,7 +2037,7 @@ static void *load_cache_entries_thread(void *_data)
 }
 
 static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
-			unsigned long src_offset, int nr_threads, struct index_entry_offset_table *ieot)
+			int nr_threads, struct index_entry_offset_table *ieot)
 {
 	int i, offset, ieot_blocks, ieot_start, err;
 	struct load_cache_entries_thread_data *data;
@@ -2198,7 +2198,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		ieot = read_ieot_extension(mmap, mmap_size, extension_offset);
 
 	if (ieot) {
-		src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, src_offset, nr_threads, ieot);
+		load_cache_entries_threaded(istate, mmap, mmap_size, nr_threads, ieot);
 		free(ieot);
 	} else {
 		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);

base-commit: f58b85df6937e3f3d9ef26bb52a513c8ada17ffc
-- 
2.18.0.windows.1

