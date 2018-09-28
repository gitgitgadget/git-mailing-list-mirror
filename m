Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D4F1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 16:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbeI1Wt6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 18:49:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36766 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbeI1Wt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 18:49:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id n23-v6so2806765wmc.1
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZ74sbVMbbs/4wm6yqrs3zBlQsbEwGazIiQrHu1Oq+E=;
        b=ERDivVWU5aUa61+Fxzxxeb3xO3YEN1km1BJjrclR9bjXLllcVj8U8lsZr/BWpiJqnj
         NIDpDgXe9+1fkGY58Iz3rUkJEZeWq/LzR+jQXxkB7P50SUGx/Elip0Ki6HPL0ifllpiW
         Wnps/A9vMkFL8W3danV6saoTuDgyM1yZv6K+yFePwY1nFv9YgT/ZBMIrI3F3KRCOLdhU
         atasLDnTdEV7Jsr6eBkleX6CjsBO06EJwoht2CbWIy/ZHICH3ENHsl5+PlkWq+FaZ/zJ
         Y3Yjc8a5fM3Kjkpl0QEChEKbmy+kgPsdYnqRyq77crcKxWFdi8cQyvCtZU2eASb9XRR9
         u+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZ74sbVMbbs/4wm6yqrs3zBlQsbEwGazIiQrHu1Oq+E=;
        b=hTxU6gD2JP6DDmAez5TKPhz2M5zzcAOhIq89GDN4fjLZ+pDJFdyeTI4jk9P3RDii0O
         CqNGQkA2DotNEtE3gyna3xkhC9BM54ZKNJZ9eyM+uQaMIkJ9SF+du4RvQorIFemhzUef
         Ug/sBq5ISpnPofgWdT97pC8rKEQ5d49HM/v4vB0agWHNNusjAXdiE+kvf2CjGDvXTK2G
         kfryXubOz8PTjnCCkTvd/hrH+73kBm05rdCd9TChHYfFcB3fwMmTr5geil09dMu/rb7c
         T/aiz/AfNRDoa9EZBlMSufJJvDMlxCGwaz8V9sdCXcagpoW1VLoEuucyoYS3VN7nuIYu
         oUKA==
X-Gm-Message-State: ABuFfoiz7+QYGzV9T7hV32ae7bASIzqqaXD2wnESyrvZbQxNbuiV9+Ex
        WSvF67vboteO7bSI/hle4bU=
X-Google-Smtp-Source: ACcGV6261ILRiNoDxcv9xWpRj3QyrZkQT0DnZP4emEJ9Ubz4VV6bkpT8SokeSr5R/2bo279Deu1z3Q==
X-Received: by 2002:a1c:cb4d:: with SMTP id b74-v6mr2208641wmg.123.1538151925636;
        Fri, 28 Sep 2018 09:25:25 -0700 (PDT)
Received: from localhost.localdomain (x4db1ef73.dyn.telefonica.de. [77.177.239.115])
        by smtp.gmail.com with ESMTPSA id s24-v6sm1628247wmc.7.2018.09.28.09.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 09:25:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 4/6] split-index: count the number of deleted entries
Date:   Fri, 28 Sep 2018 18:24:57 +0200
Message-Id: <20180928162459.17138-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.361.gafc87ffe72
In-Reply-To: <20180928162459.17138-1-szeder.dev@gmail.com>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180928162459.17138-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'struct split_index' contains the field 'nr_deletions', whose name
with the 'nr_' prefix suggests that it contains the number of deleted
cache entries.  However, barring its initialization to 0, this field
is only ever set to 1, indicating that there is at least one deleted
entry, but not the number of deleted entries.  Luckily, this doesn't
cause any issues (other than confusing the reader, that is), because
the only place reading this field uses it in the same sense, i.e.: 'if
(si->nr_deletions)'.

To avoid confusion, we could either rename this field to something
like 'has_deletions' to make its name match its role, or make it a
counter of deleted cache entries to match its name.

Let's make it a counter, to keep it in sync with the related field
'nr_replacements', which does contain the number of replaced cache
entries.  This will also give developers debugging the split index
code easy access to the number of deleted cache entries.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 split-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/split-index.c b/split-index.c
index 84f067e10d..548272ec33 100644
--- a/split-index.c
+++ b/split-index.c
@@ -111,7 +111,7 @@ static void mark_entry_for_delete(size_t pos, void *data)
 		die("position for delete %d exceeds base index size %d",
 		    (int)pos, istate->cache_nr);
 	istate->cache[pos]->ce_flags |= CE_REMOVE;
-	istate->split_index->nr_deletions = 1;
+	istate->split_index->nr_deletions++;
 }
 
 static void replace_entry(size_t pos, void *data)
-- 
2.19.0.361.gafc87ffe72

