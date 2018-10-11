Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59F01F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 09:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeJKRJw (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 13:09:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45783 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeJKRJv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 13:09:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id v18-v6so7615440edq.12
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iI3ONfwKO/q4cufdB/EfqPEqef0V8CWWEci9eF1WVas=;
        b=o07fasBanUHcrfsYbcnFRiqgKf0d96qaSbnLWxNi+b9eZT62to+rUZlfQlPvu4xauA
         aKMh/HLIaeW1crB2xqHrYgb/jg3LYs3HznPbVivSJcRwQ6xBHHyqAqoFxuLDyRFHo9FH
         JuYStUVCV0mQ3uw3aPFaqliz2Zkr7iihtteik4S3uPwGAhAKjPzCQ4YsUmGOH/RgsN0Z
         E/W+2hJYWQ11QHFuXbXV8xcE+wsoPXriUPGGAxt92F7w6N/cK+9Znf8M1WYJWpq5G8ty
         mgoNbGcX+ZPfK72qzMKF/GSlsNYNfIFU/1vwfQmhp2W9pXGbzeq2vxLxauul2NyCRbp+
         s7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iI3ONfwKO/q4cufdB/EfqPEqef0V8CWWEci9eF1WVas=;
        b=oFLCFyxr0P1fb24zvBEblHw0aUfAU1RogbHsUKu98CjwQYelKW/FUOWid7ncwAT3YZ
         ARXlEL4Wwq5Jk/Hcb+3ezKfvhI1UIiDJ2gRmCr2/Yi5aq8M0LPkbp3OwqAr290yCFst9
         iuVDXBiNchcPoJ5ROsVC97WzbG9Sbr+YoHlBxZdSxCQTL4dnKWymklA59hpa9iFHlTOs
         6R8eNbAZuKHLYn0IdX0u1Cj7i606S8w91cQ9KOkz1LbQKSXPjfJGYizJ+6YIXCxBVKoX
         9T4U81uWIv2L3px5fzsJfrtFPt0i9u+owZ/NU5rOqBSfQFtm7YxAaAMsRKcJIVklPWO6
         Z3Ww==
X-Gm-Message-State: ABuFfojyY6jrwzOi+sQEZNLjDh5cqF0Ro53ddX/z6oZ/U45xUb8Ltdxh
        yhzn2IZzUzKgH4eRtlklzm0=
X-Google-Smtp-Source: ACcGV61G6xtwxurRHUNUUTz1SFA3EtfNq5pYwtli/24uqmLETEowcvIDav3kJ1jzZH/xiZhj6CrbMg==
X-Received: by 2002:a17:906:3f4e:: with SMTP id f14-v6mr1342880ejj.62.1539251001047;
        Thu, 11 Oct 2018 02:43:21 -0700 (PDT)
Received: from localhost.localdomain (x4dbd43b4.dyn.telefonica.de. [77.189.67.180])
        by smtp.gmail.com with ESMTPSA id q25-v6sm7034721eda.18.2018.10.11.02.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Oct 2018 02:43:19 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 4/6] split-index: count the number of deleted entries
Date:   Thu, 11 Oct 2018 11:43:07 +0200
Message-Id: <20181011094309.18626-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.465.gaff195083f
In-Reply-To: <20181011094309.18626-1-szeder.dev@gmail.com>
References: <20180928162459.17138-1-szeder.dev@gmail.com>
 <20181011094309.18626-1-szeder.dev@gmail.com>
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
2.19.1.465.gaff195083f

