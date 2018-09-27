Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9111F453
	for <e@80x24.org>; Thu, 27 Sep 2018 12:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeI0TDO (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 15:03:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34609 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeI0TDO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 15:03:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3-v6so3286502wma.1
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZ74sbVMbbs/4wm6yqrs3zBlQsbEwGazIiQrHu1Oq+E=;
        b=QOSUlzkXK74hcRxHLlyK+uZHY0SsfbpAWmbaACBycyE8VJxoYxYWzwe0L8E0cBwREd
         Mpx8NdfwwPNCvCvm1JVJCpWUJ/ZujD7hxCxdm8Z2HN2DpTqwKRiUrkWDVj3udrjmspBm
         HcCwqIovnr8WvNpdDXDeYiaCtHUm8mW9eClmiXPBpSH/6lmCna3RuaIrsJcr20uRwPX3
         3sIbyY8p898f4TDYVS4VqaIXkyCH4tD7vAKNJml1+zMmHkab8aw/3PDpsHmh8GEtVy8J
         BLqH2KsxsVrL17B95vDT3nVGq3WUfbG+27mfB8nM2ev+1+iUfgUysP/Z0VoQVQ+92Qeb
         jSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZ74sbVMbbs/4wm6yqrs3zBlQsbEwGazIiQrHu1Oq+E=;
        b=CB4B1smZ11JBsSn1qQQfBvHG2ArWd7Hx0FRmunNyJiQbc6pCWJuUwDyYFWVn1uOs4r
         cz9zL+gETqV/MiAtuvz7vheMa+rmkDjYQH1163RfZkvWQXzgiACMUBnKPF4wMxyqs0ci
         v2BppnrVqOc37Xz5HvtOn7+aAnzVKxAfDG6k9R1fSB7st8RlhKD2X2SfFOyNdKpwYKs1
         G3vfVpJshFo5T737GTV3fBCeM44cJDHhJcJ4HA9P2Fp0AM+Q8jr3h5mwu1NUl5iiNTu3
         0DjahSr1XUWoVMHuFj9q3haBdKSFrlcvl4oYTMOn8R1PZ+x6Amc/FMJGU5DN1nkc8GQM
         GYNg==
X-Gm-Message-State: ABuFfogznEy/eZ9diVssxs2nOWUmf+hAGBtPv+iuCIuLivnH1DrGThuL
        hQFwrLKepJ1GYJ4AXZhM7XV1Lq91
X-Google-Smtp-Source: ACcGV61G0F3nVUhI09xnNWaBQAQXFvoHC+rpggQcc6RLrUuwhUEytJUlk7bRsob27c4Uq8xMD6zL7Q==
X-Received: by 2002:a1c:be06:: with SMTP id o6-v6mr7377155wmf.65.1538052304717;
        Thu, 27 Sep 2018 05:45:04 -0700 (PDT)
Received: from localhost.localdomain (x4dbd8656.dyn.telefonica.de. [77.189.134.86])
        by smtp.gmail.com with ESMTPSA id c8-v6sm1938543wrn.43.2018.09.27.05.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 05:45:03 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 3/5] split-index: count the number of deleted entries
Date:   Thu, 27 Sep 2018 14:44:32 +0200
Message-Id: <20180927124434.30835-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.361.gafc87ffe72
In-Reply-To: <20180927124434.30835-1-szeder.dev@gmail.com>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
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

