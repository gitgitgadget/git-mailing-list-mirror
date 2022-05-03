Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF32C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 10:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiECKao (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 06:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiECKah (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 06:30:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ED26559
        for <git@vger.kernel.org>; Tue,  3 May 2022 03:27:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w4so22702143wrg.12
        for <git@vger.kernel.org>; Tue, 03 May 2022 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ezlkLv8fxnncOlJvMOA+dK5y6vHQPHrwwECYfys/UMk=;
        b=IipmY6PBKqEg6IYKK+uvoxAIIIq0rSajqD0M5deGBLAW/d7bhx3DZKJhwEioZrT38C
         k+xm7fh+NAzlFcW6Yr7OByumX8hmL8UWSDye1CWDnokLnCP1VDvj/afI8kItH/rnK5yc
         743xMok518mhXR/q6tSVt0oqFuOOAicQMXySK8NL0crdoXsBXVbf1hcelmaxtGaZOtbG
         X18hv5G08CYZ96frSC9X1Kb8HZuGXpAS67XqTAIWHr0I0HY3QWSkW3iRnliyX0RD5Bp+
         GBwyN1RAr0UbFnZ5e8z2AYeivMR2l0oyi+nkt1qvEpWj1Xi+21N6DvFzu40PaBGiepYh
         uiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ezlkLv8fxnncOlJvMOA+dK5y6vHQPHrwwECYfys/UMk=;
        b=OUPzwi0OvR1c2NzT4D9GMAmxsJC2aPsz/5XbdD9g4PMIjiplD/BI66gk9/RjWwgaPn
         e8e/YY0kKhQkjcubvQZzyqNdHMAHFtaJu5I/3ybdLgVQvteWFkDbc3R7OknMQhm3blxK
         WgYielMheCIdJdwVY55/nLYGvT/1cR0c2cqLLeWLsyi4Q/CSoc4BemH9DsbFR2nZKEib
         buKYoDKeK9+9n0W0h3k7Z0ksiPUE86QfrGcdQ3ZhMbzmtwXhQ+MxunWVZ/zv0XKiuA9Q
         w3ZtRFAKtVLvvL+QGZK9MEP1WYvRku+0ASDSBahiVAkCCqBinctrL5BJXOC1RV9Ts36h
         F/wg==
X-Gm-Message-State: AOAM533P5LMxo3I8OQhQe4+WkAi099f7gVicXjurQKDC7K3Ek9yqpb4o
        zE3CgXA5C2vAgvmWbBhZHBIuRkClOvM=
X-Google-Smtp-Source: ABdhPJzzBaKwWcXzdumE3KwIXGoIYAvUbPe4OK3xQ+nGfWnbgkO6rQ6TP2/09z9Lx85bdkxLOu0g1w==
X-Received: by 2002:a5d:6489:0:b0:20c:6b7d:1bab with SMTP id o9-20020a5d6489000000b0020c6b7d1babmr4657960wri.449.1651573619661;
        Tue, 03 May 2022 03:26:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c03ce00b003942a244edfsm1284512wmd.36.2022.05.03.03.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:26:58 -0700 (PDT)
Message-Id: <e1a94b0d1ae6032036c26ae96bec37718eaab752.1651573607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
        <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 May 2022 10:26:47 +0000
Subject: [PATCH v2 6/6] trace2 docs: add missing full stop
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-trace2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 05fa38cf651..f4a8a690878 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -533,7 +533,7 @@ these special values are used:
 ------------
 
 `"cmd_mode"`::
-	This event, when present, describes the command variant This
+	This event, when present, describes the command variant. This
 	event may be emitted more than once.
 +
 ------------
-- 
gitgitgadget
