Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62CED1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 08:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965217AbeFSIE6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 04:04:58 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40803 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756442AbeFSIEX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 04:04:23 -0400
Received: by mail-wr0-f195.google.com with SMTP id l41-v6so19481601wre.7
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 01:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=daFxa9nOsRxSxTENQsjMVI9pXodBFi2cs8zM3Wj99gM=;
        b=YxuEDANHQ9NrXTEI4ehw8y9Og7r3o3veSOEFEj3zExonEObQqrDsXlXb4MkFfKOSeS
         UaZSlHTIckHk93+ejw9x1XPLdqRMtY8/jHp+ehote8TYryVweUesJi/Br5bhBihNBypK
         n3kWGe+x0nlPWq/BXRMdbnVs18lxPcr9kHz4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=daFxa9nOsRxSxTENQsjMVI9pXodBFi2cs8zM3Wj99gM=;
        b=k9CZA/87Mqaqywv3tZeCAZgg8IFADB+vrbU6Sjher6l6YKXttTdbd43JyKD1XpnTuE
         06+7kTkrUW1r3/7B19vyZ+nXGgbCIumJRCVAQl1LmgCKI2qnEMjw8WCud1g7neVY06MS
         jDJLIXoLtzwHGZ8AjXtWb833t/ybHZCCB7QyrW1+O7PPWzuRaM6xXl2QfLmq/nG7tulq
         i4LYNgRlmYs5tc+Z/XcHp8bmZSrfXWrwY3+gyBGeqRFrTJ7At5TYNf5rnhEvRD1IzFIV
         bE1nzdZQyRIcA7egmj3enC4Xk7SDZ7CUGeIMR9/CTyeQ5gLWw+r5/GNJuGOSz7JdKWyi
         Q/PA==
X-Gm-Message-State: APt69E0dImsylvx+BLvjiWm0rJ7oKIImi1MXigz442eQxjo/QqigsySY
        8nVa6FIQ66DpNoHTvc0ehORYRj60
X-Google-Smtp-Source: ADUXVKIFtgj3eRKLVDt0YVapEB9NBLyJyHUzVP4y7t7qXqTepvSMWkyTbGpj1VMlL6ywWxpvCPlBUw==
X-Received: by 2002:a5d:4a92:: with SMTP id o18-v6mr12010819wrq.132.1529395461841;
        Tue, 19 Jun 2018 01:04:21 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id r2-v6sm12757215wmb.39.2018.06.19.01.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 01:04:21 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Lex Spoon <lex@lexspoon.org>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 3/6] git-p4: python3: remove backticks
Date:   Tue, 19 Jun 2018 09:04:08 +0100
Message-Id: <20180619080411.6554-4-luke@diamand.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a
In-Reply-To: <20180619080411.6554-3-luke@diamand.org>
References: <20180619080411.6554-1-luke@diamand.org>
 <20180619080411.6554-2-luke@diamand.org>
 <20180619080411.6554-3-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Backticks around a variable are a deprecated alias for repr().
This has been removed in python3, so just use the string
representation instead, which is equivalent.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 6fcad35104..67865d14aa 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3089,7 +3089,7 @@ def getLabels(self):
 
         l = p4CmdList(["labels"] + ["%s..." % p for p in self.depotPaths])
         if len(l) > 0 and not self.silent:
-            print "Finding files belonging to labels in %s" % `self.depotPaths`
+            print("Finding files belonging to labels in %s" % self.depotPaths)
 
         for output in l:
             label = output["label"]
-- 
2.18.0.rc1.242.g61856ae69a

