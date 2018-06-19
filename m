Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60E321F403
	for <e@80x24.org>; Tue, 19 Jun 2018 08:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937309AbeFSIEg (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 04:04:36 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:41513 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756430AbeFSIEV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 04:04:21 -0400
Received: by mail-wr0-f169.google.com with SMTP id h10-v6so19477578wrq.8
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 01:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IcjErNIld2MjMZXSmpv9eKCLEousChavO843ucrW44g=;
        b=c7VXAxVbjfIB00DM4EH4W6Z2P8KCtkEwdAeNqCOAOSAFdDrVaw8mLwu+K0o6AXx6ks
         6lyA+3WMdDCEDw8lfJ5X9PqcSpDDDBOkGkEOZyFIrv3WKOdQe8sXZTMdmwbT8XNU2IeR
         jhuI6d2CxgPTEpD6p3Cy57xAdAiAawQxlrptc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IcjErNIld2MjMZXSmpv9eKCLEousChavO843ucrW44g=;
        b=Nc2/Ud5rCOHN1/n5V5DW+E3Z/K91gIaEmVx8JEyhGFJxibTv9wdj5/+H69QyAzaxrH
         NrG08NEOr3ZAzcOHoj2jZvojVGfpclDNQvlPa9AuGcH2mhip96ndv6ZLzEoV38am/rHN
         mk/p0PzHpOc60IA7yRqXh3gJkDbtrOnOTiCuhrXXc3qw/NH0N/7s4bcdgHaU4aJp0vV4
         XnVyAigvRxXLrQZbV7lBCspmt9Y8DBnq8Ruu9jCe0spBiGssKNQRbsO1UonsDtLjf4I7
         K5yWaZhAN+36ARjNK4T4XQCpdz221YVeJp29k9U3VLiWfKz4PFgG2jj06xQFLQh3GJJd
         HK6g==
X-Gm-Message-State: APt69E2Fkbs+FDaJK3J2+GuXNsClIcCOqgvaDLlFFPzCb8iW5s7Z9+FP
        O30lSCMLfVihxMklZJ16cvP5J5WA
X-Google-Smtp-Source: ADUXVKIGUBea2Hih208ry6tZRtqO1DG7cROIV1NY20uxlxCZ8XI+cIQo33A2/Ifve9Tr/HZNDwXGhg==
X-Received: by 2002:adf:dd03:: with SMTP id a3-v6mr13834489wrm.2.1529395459614;
        Tue, 19 Jun 2018 01:04:19 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id r2-v6sm12757215wmb.39.2018.06.19.01.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 01:04:19 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Lex Spoon <lex@lexspoon.org>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/6] git-p4: python3: replace <> with !=
Date:   Tue, 19 Jun 2018 09:04:06 +0100
Message-Id: <20180619080411.6554-2-luke@diamand.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a
In-Reply-To: <20180619080411.6554-1-luke@diamand.org>
References: <20180619080411.6554-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The <> string inequality operator (which doesn't seem to be even
documented) no longer exists in python3. Replace with !=.

This still works with python2.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 0354d4df5c..51e9e64a73 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3590,7 +3590,7 @@ def run(self, args):
                             prev_list = prev.split("/")
                             cur_list = cur.split("/")
                             for i in range(0, min(len(cur_list), len(prev_list))):
-                                if cur_list[i] <> prev_list[i]:
+                                if cur_list[i] != prev_list[i]:
                                     i = i - 1
                                     break
 
-- 
2.18.0.rc1.242.g61856ae69a

