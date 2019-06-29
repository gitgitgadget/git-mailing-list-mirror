Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712BC1F461
	for <e@80x24.org>; Sat, 29 Jun 2019 07:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfF2H6G (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 03:58:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55604 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfF2H6G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 03:58:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so11166002wmj.5
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 00:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kc8zMZN3bA2YxVhkJ8+muZH5APk9C5cMnlMclUJzX5Q=;
        b=UuFMIb+m4/IVffQbI3UUcJbiJ9wUOTfXrr4MuO9NU5qOkEl8T70inB/mUEUKJn7nRP
         s4TipyxsaQbKqK01dF6ZPvYoigf9S/a0CY9LGYVpou6CXl+AWLaEqRDA09XWE5/VqH54
         Cw7jLD6g8J+q2s2xTHlqgoqACzLS32s2iIGywtwOkTE6bAxehVxLW0A2dQ+IamuRkqbQ
         VME6VR3enOu3h6cDDJtPILa+uHjWKoRqjBVfOZyMWQ3ueVzwvsC47G4b7hr6JIGtNP4j
         5+7dMxCT/AF+unnUO+3clQB8c8JdmNyoPGkZ+uLKq+/MImdU6Y5dxQdhCDIhE+OWeLvQ
         xkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kc8zMZN3bA2YxVhkJ8+muZH5APk9C5cMnlMclUJzX5Q=;
        b=AHnlHkRucVomH3MaHw04DFs/2kyuR/3du2hY3udcYiJacr5kItBDc6530idA2WR7nP
         NVkldKg2px8RFa9J14+vEHRsl1PMUwhvI755JP6q7gEcYyUzrDHY/K4FAI/6A9txdqKn
         rgOS2LVJCgJMs0KXQoG3awpQj+PFxXw1jFeIJwUcnaxqi6DeDtYWlUuNuvf+ngFOJHFL
         9ifIMJ0+RZ+xQ3gQW0ZcppVrG1r114s1Jyl4kUXxQI4dCFWdHae+A5ZpRsJCcNMoAIyn
         3Vb4mJdcWrKEzsQsCsyLQNmdTgBv/tZ6Vqx/UlGhKm0UYsTnMsIBrsXlGP/MPoUYuT8m
         fZ1Q==
X-Gm-Message-State: APjAAAVhmNAmtWQWn+o3fstvLH8+tqpRlYCy5+acdwyyNdZA85/rh+PH
        5pkQWt5csdVrishBwftyZLCtAKjIIcQ=
X-Google-Smtp-Source: APXvYqwuCZQa2OWpA15hVka4qKdTvIU0bj5pHobkCcX+ws2ADeBAOiXVAe5h9LSMj2MQ8LmxvmQhIA==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr10283296wma.164.1561795083626;
        Sat, 29 Jun 2019 00:58:03 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10df:46ae:1d3b:9b5f:d57a:703b])
        by smtp.gmail.com with ESMTPSA id z5sm4155330wrh.16.2019.06.29.00.58.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 00:58:03 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] t0016: add 'remove' subcommand test
Date:   Sat, 29 Jun 2019 09:57:47 +0200
Message-Id: <20190629075747.32586-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.464.g81fc6c5d4a.dirty
In-Reply-To: <20190629075747.32586-1-chriscool@tuxfamily.org>
References: <20190629075747.32586-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Testing the 'remove' subcommand was forgotten when t0016
was created. Let's fix that.

Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0016-oidmap.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
index af17264ce3..bbe719e950 100755
--- a/t/t0016-oidmap.sh
+++ b/t/t0016-oidmap.sh
@@ -67,6 +67,24 @@ Unknown oid: invalidOid
 
 '
 
+test_expect_success 'remove' '
+
+test_oidmap "put one 1
+put two 2
+put three 3
+remove one
+remove two
+remove invalidOid
+remove four" "NULL
+NULL
+NULL
+1
+2
+Unknown oid: invalidOid
+NULL"
+
+'
+
 test_expect_success 'iterate' '
 
 test_oidmap "put one 1
-- 
2.22.0.464.g81fc6c5d4a.dirty

