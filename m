Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A789200B9
	for <e@80x24.org>; Thu,  3 May 2018 00:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeECAyV (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 20:54:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32773 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeECAyS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 20:54:18 -0400
Received: by mail-pf0-f196.google.com with SMTP id f20so4447206pfn.0
        for <git@vger.kernel.org>; Wed, 02 May 2018 17:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qjjl506o9wg3kaDXWY05jaEYdvYyyl9ZYQgR/eOIiBU=;
        b=FV5srO8SJcZw5YXVmCFosFd/HMtPRNf48ZJVaG23i5hocwf7736RyJhrDgU8Ol8x/c
         SahSue32e1lwZrS931TKfOFfHxJRf+zSF3wsHcNbjB6Kw8j3QeZxVr+jEcUilnzq4dAg
         yA1efmYjyf87qRwn5bCzvvCCKXbUkEdhLwPRo6Ipoxg726vS4Vjgddsyab84extLYVCW
         /yeV8pahmzD+5N42CfdtV3Qiwt9iQKIQu8+iW93+OUhqPDZdDb04RXetWKvxGUWRHXNP
         I6FUNnoMSr9zd7LVt5zALfVsq4jauOWWPSU7iVnk6t9qvPhIvuqZDyP60bu4nOWuK9aS
         QnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qjjl506o9wg3kaDXWY05jaEYdvYyyl9ZYQgR/eOIiBU=;
        b=uhJLVUv7Q2FtSjQWv/N0VW/GGm7DJEjlPrxZTn2fg3J7W0VLRDqmctWxwcRu/I1dMV
         u+JN2D+RQbYor0xIhGOLk9zI9RPMLvflTJbGi+vepx7qIPyPS5PG2DR8BhqQVgX1EgyK
         RBIr2GO1oKoCH25oO3fwfj5Mi0mKyGBHQSrMKCyIht37Djk+S3akjkFO6xxT4BP1aMw4
         FY4i8mCN4tgi17DdpxtEWdUcdYqV2j4NPGawviK+jWo0hk8mCtf6tOB0MfNi5dAsKJix
         gTQTJ8LADLAVVdlnwjh5Jxtkg3Cg9D1ULAoewd9vPruTjQkDa5ECXnzzD41J/RSaIU0H
         Nqvg==
X-Gm-Message-State: ALQs6tCKCTHFDJT2JqGg36A6JKFyIDnZA+tb82u0MfiL6KKnHxtfSWvc
        uOS6SqqaaiZijwb6HN0swZuJDe2UJeU=
X-Google-Smtp-Source: AB8JxZrsHssxgT5CLbw1bOJUCz8JVyxjEd0gPPFbjmTAUY9/lMpEpmBFWIQcxnzGv/y+cshIpQo2VQ==
X-Received: by 2002:a17:902:aa03:: with SMTP id be3-v6mr21319890plb.215.1525308857932;
        Wed, 02 May 2018 17:54:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id t69sm811074pfi.177.2018.05.02.17.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 17:54:17 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        christian.couder@gmail.com, pc44800@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] submodule foreach: clarify the '$toplevel' variable documentation
Date:   Wed,  2 May 2018 17:53:56 -0700
Message-Id: <20180503005358.89082-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180503005358.89082-1-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh Chavan <pc44800@gmail.com>

It does not contain the topmost superproject as the author assumed,
but the direct superproject, such that $toplevel/$sm_path is the
actual absolute path of the submodule.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 755ed695f08..408d5a0387f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -188,7 +188,8 @@ foreach [--recursive] <command>::
 	$name is the name of the relevant submodule section in `.gitmodules`,
 	$sm_path is the path of the submodule as recorded in the superproject,
 	$sha1 is the commit as recorded in the superproject, and
-	$toplevel is the absolute path to the top-level of the superproject.
+	$toplevel is the absolute path to its direct superproject, such that
+	$toplevel/$sm_path is the absolute path of the submodule.
 	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
 	variable is now a deprecated synonym of '$sm_path' variable.
 	Any submodules defined in the superproject but not checked out are
-- 
2.17.0.441.gb46fe60e1d-goog

