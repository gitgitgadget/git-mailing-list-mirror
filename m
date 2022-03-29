Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7CAC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiC2Ao3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiC2AoX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE1E23B3C6
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j18so22580287wrd.6
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0FZmb8xpqwGRKdPb/QtLOYQHy803cgaUCogAov31nBg=;
        b=fxEkCir+tSmvlSdbik5xz1egi7RRt1Ln6FBscYrTPShtP5S1vV03d2V+TiA9L4XFsn
         S87PqAwNjx+FJxKcJeVI6RFSYUgV5WA2XUHQKeIVbppZzsWae5EPWKPtyrrs8XMM6v+B
         6mI27AOWCruZXYrH/H3qAEQPExm3RLRSFD/JeK/4IYioYdJMWfIYpuh3vwTIZCbHfqmu
         sAKW4rReqL8MLrq97cqg5vBlRBlBiWALP0uP4uxff0Zhyncl0KCcsL6J3GcRISlxqqRL
         hQzCQotpaM7FYKJ8fkxWbVMCHUY3POzJRPa2tA8XhwyTUNHKKEJ7tDioq6Lh+6NbxjY1
         YXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0FZmb8xpqwGRKdPb/QtLOYQHy803cgaUCogAov31nBg=;
        b=6LU7GxoLauz/tWkFny3s0kg/g7WaIfq+XIxXQ39RYorxxu/QYlbWtoaKNfn5jyQesX
         43W3XobB/BaqvxNHoXmcBTahgbNRZR19yJM3UWRgk2P+yup6NW1DuwwXPuReE8mBhOIN
         4/kSwEk+cGLC5fHknbxxUyM7PnQrat4It/a2OU8tIcNDTmYr/ph2ElHqtyu+x8xpBAyq
         PcAWiFF1CFDrQykPM27PJ4MNjkX3i2WivaAWthSbAI72zg+upk8/APfdsewNj3vvc7S6
         Iax5x6zrcb7S42A182ZWFk1emUh53k4OtM+cgTkJnVE3QwpX3cs/MPTdvlwTrZ8sNCtd
         TR0w==
X-Gm-Message-State: AOAM531s2YeqE4po6RzytKoaVELpz25ZaLR71lR/InCQJ/rnh14fXuHz
        Vc+Tl3Hw1722z6jqwygGnHOwWDB0a48=
X-Google-Smtp-Source: ABdhPJy++dWzE1oOXpZrQgWSEdGTzrfRzXPddmJYUq2xXiIDa5n409itXhI7xj3Yn3ctaIN5djnDZg==
X-Received: by 2002:a5d:6304:0:b0:205:c541:3eab with SMTP id i4-20020a5d6304000000b00205c5413eabmr8122322wru.469.1648514559283;
        Mon, 28 Mar 2022 17:42:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t4-20020adfe104000000b00205b50f04f0sm7261820wrz.86.2022.03.28.17.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:38 -0700 (PDT)
Message-Id: <83fa4a5f3a5c79fa814932c0705867ff16a584c7.1648514553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:22 +0000
Subject: [PATCH v4 05/13] cache-tree: use ODB transaction around writing a
 tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Take advantage of the odb transaction infrastructure around writing the
cached tree to the object database.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 cache-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 6752f69d515..8c5e8822716 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -3,6 +3,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
+#include "bulk-checkin.h"
 #include "object-store.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
@@ -474,8 +475,10 @@ int cache_tree_update(struct index_state *istate, int flags)
 
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", the_repository);
+	begin_odb_transaction();
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
+	end_odb_transaction();
 	trace2_region_leave("cache_tree", "update", the_repository);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
-- 
gitgitgadget

