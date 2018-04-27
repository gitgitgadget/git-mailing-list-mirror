Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A7201F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758768AbeD0RFb (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:05:31 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42492 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758565AbeD0RF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:05:26 -0400
Received: by mail-wr0-f194.google.com with SMTP id v5-v6so2427388wrf.9
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=B4hXo5YaDn5U1Ksa0qpcR1iow8jFE++N91lY8/P4xFo=;
        b=WXNBgYYaBJL4Y8jircs7t57XQRyU7Z1v9NCmrFCoIPlXbHNyrFuon/ZoDMzMhl7bgn
         fcd2PXjVfvuh4p+qltrpSnSz+f/1K8e/Km0Z4LVmxxaP/ZBPVxAGmPI8I+zsuIJqyAk9
         +YHbnE17tA5+lPJqZ7kMbume+3OgK57da9M5XEXXfTviud/MrlC/wIbljUHUH1NZaD4S
         2TjWtnA83Sg2sYro1ixF5aPQMQP5CPhKPfEyUwM1NGR4pWpvDtXfIrCmUKcqOsseIPs0
         uqEErUB4cxM4N5Kmg2KOZFO97ePFxoQAGGRLUBduMLuJI1ZxGJgKpeiLmhSO/CRBCcTI
         lGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=B4hXo5YaDn5U1Ksa0qpcR1iow8jFE++N91lY8/P4xFo=;
        b=Jz3hc7XZNt/uXUbZMi/tmrBsQ5+kfq8ARiXZT6TdzmKmSzI5U6lk1u+OHrAxQgs700
         ybYDe4shAL0qY+YdZIbk86P1fTP+qSGO5eBoA8YWj0Ye8EGOmfi1AaXknLLAlv8vEEi7
         BnE9+Jep9QIVAtnfYWlGWIxS7si5sHYSL9txzLviwGzwnFZNQbxSYZ+XasT35vcS2bjX
         ypKn6J+bLF6pRRDBz5uPh626/ytFRzwzvlcXMUNM9Wg5Zbj8D+Ie77eiEKd7wvu5kMfA
         2GdtfTHWQFII6v1cOxe5emyOogDTCJ5cBY07yDTPsjFKMDngN8CTxShtklTL023fZVrA
         llfQ==
X-Gm-Message-State: ALQs6tCdcV1Y/G0juPZO3NLrCh6VyNrs8CwTcO8OzrkYywZ6FY6V66g2
        4taHkNCdEfOeD+Elc5vFvjjwnQ3y
X-Google-Smtp-Source: AB8JxZq0CvbP23qGbb4ODj1fV+Us42X4ROBTAus5Fx5Svm3XV/olTHfBA0tj/OAW6EA2suz2gcKL1g==
X-Received: by 2002:adf:88a3:: with SMTP id f32-v6mr2359762wrf.199.1524848724884;
        Fri, 27 Apr 2018 10:05:24 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:dd1e:a7ac:6cfc:1274])
        by smtp.gmail.com with ESMTPSA id o10-v6sm1765745wrg.90.2018.04.27.10.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 10:05:24 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 3/6] doc: clarify ignore rules for git ls-files
Date:   Fri, 27 Apr 2018 19:04:37 +0200
Message-Id: <20180427170440.30418-4-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180427170440.30418-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explain that `git ls-files --ignored` requires at least one
of the `--exclude*` options to do its job.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-ls-files.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3ac3e3a77d..f3474b2ede 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -53,7 +53,8 @@ OPTIONS
 	Show only ignored files in the output. When showing files in the
 	index, print only those matched by an exclude pattern. When
 	showing "other" files, show only those matched by an exclude
-	pattern.
+	pattern. Standard ignore rules are not automatically activated,
+	therefore at least one of the `--exclude*` options is required.
 
 -s::
 --stage::
-- 
2.16.2

