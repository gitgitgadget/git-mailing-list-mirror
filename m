Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73FA61F461
	for <e@80x24.org>; Mon, 24 Jun 2019 21:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfFXVDC (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 17:03:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39505 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfFXVDC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 17:03:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so11049178lfo.6
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzznlBHVmqynWTZ+dtutYxZR1LRYi0bevNaOn9O/ENw=;
        b=OkQi7EauMBi39g0rYI0fXZyEapxNlIHQBaWuMiroMfDrwuUrLmLnp8N34Apxr4a2ce
         hg4hgPzh2zg/FMNk+sk3P5JB/vbrxVrbT6T2kqtBDduFO7pIu3ozNf1bmbTJ0zX39a5K
         CtOjser52cpu7urxhReUXKNm4p4EBLpvJura4STsI8bdrTZ/9/bZwKgskv/qcNi4I3mm
         qOI5ofmpR7gcwrzPinO0xFcX6aoN6ZWHNBr3FpOPIVtZyd1WokfDP+4Bs/+AGcLhM4XY
         rQ+mIDVQZ0iN9jZHjcTMbfYXURuuuukPkgNYiccgy8RZFAE6YZDwyEU56lbelR4HHFfB
         ieAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzznlBHVmqynWTZ+dtutYxZR1LRYi0bevNaOn9O/ENw=;
        b=KONfBRW/Q6bwdE/cUlIxFWCHVA/Sr3THTmobyPySgW9hnUWoCjhOicDjCJEYu7vsf3
         hWSzi0SRZ6NdJz3TnnoznRHN1hHY1K7ZyKC2oYKpM6BRqr8WI61ECHWgDRaAYzvqGEZh
         dbHDbvy22l9Jec7RGPuMoH99mMcQ3d4dB21qlwOgJqhrfjLoe8Ef+lDFmeoAx+qdu2tR
         o/VarlTnCsqUbMT/sxiXwZXrfSTwClfJMxq67SVqgjK2CIAx3c/glWH8JufqsPZkbrFu
         p1FV3te7I2vkejBzJz5yO5ubKfWWGS26ZRFNWGP6GGafZaIMnVDzkjeauLEd35PtZd53
         vbZg==
X-Gm-Message-State: APjAAAWj6aQbDsYHlO5fzKlLWUN4yMM9XJPVlI/YpnR/uMRf+9bIiNjh
        Gk1qhHoyiYKwQhx0jWz8WL4ZPzkqKCs=
X-Google-Smtp-Source: APXvYqwhBlf4d0wYz5x3sWuSP36bucLe7V17c1kpTEpwYmJblpL0CUvL/TF0yMyIOFU5Jp5NnyIiqw==
X-Received: by 2002:a19:4:: with SMTP id 4mr10979841lfa.162.1561410180026;
        Mon, 24 Jun 2019 14:03:00 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-214-150.pppoe.spdop.ru. [109.252.214.150])
        by smtp.gmail.com with ESMTPSA id p13sm1902143ljc.39.2019.06.24.14.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 14:02:59 -0700 (PDT)
From:   Andrew Yefanov <1134togo@gmail.com>
To:     git@vger.kernel.org
Cc:     Andrew Yefanov <1134togo@gmail.com>
Subject: [PATCH] Branch detection final listing simplified
Date:   Tue, 25 Jun 2019 00:02:47 +0300
Message-Id: <20190624210247.24001-1-1134togo@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Look at the listing:
----
git init depot
cd depot
git config git-p4.branchList main:branch1
git p4 clone --detect-branches //depot@all .
----
git p4 clone is used with the last dot. It is easy to miss the dot, so I offer to use git p4 sync instead. It has the same syntax, except does not need to point the directory, because works in the current one. The result would be like:
----
git init depot
cd depot
git config git-p4.branchList main:branch1
git p4 sync --detect-branches //depot@all
----

Signed-off-by: Andrew Yefanov <1134togo@gmail.com>
---
 Documentation/git-p4.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 7436c64a9..0044766bf 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -434,7 +434,7 @@ occur with:
 git init depot
 cd depot
 git config git-p4.branchList main:branch1
-git p4 clone --detect-branches //depot@all .
+git p4 sync --detect-branches //depot@all
 ----
 
 
-- 
2.20.1 (Apple Git-117)

