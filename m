Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F372D1F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeJ0PFK (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45266 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeJ0PFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id c24-v6so2470577lfi.12
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikwnYpmqg6wGRvpDTILCxxT5F28ii2BQ+np5ZeUQIuc=;
        b=HUguo97hBhllBTK5Qi/ppmTtW5NJ/aDxHD6FE+F7k2mNhJM4iMbXSIDUj68WQREDN7
         1Amc94oecXOsdDK6teNQKHjQxeTimrfcKhfnNhrx9iIfOknxTmyfcHS07xN3H8ZpXC7U
         iLKB+zDmkxmsTBQ4UVsN9N0GiZiWPnTX39OMjjIebE2WOuIL/+hsZbqcS8yKDPiMM/a3
         x3OnvBK/O5SC28CdTAmvvIz6atjfJl54sUmOvrFrPkXnlk3qvKqCi6UIO16JI7kx3vDU
         4mKxZJ551oVXt/vWfVZJ/mZwR50ugXW2dQ7GwN0kDIadGH+0x1ntzHtBAP/H9gxu/L2z
         Mj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikwnYpmqg6wGRvpDTILCxxT5F28ii2BQ+np5ZeUQIuc=;
        b=e2pYJ24xYdPQejRfdHUpK1U9WktOn4pZe1PEo526Gqsc8A9fyBxjDZVL7RQhnGAbkK
         QmQ9aLrSBCLbChH4DYe57pwG90sPbYaHBtXhQlLQfW4NAESEtQFFHhWjDAdChiSIgflL
         oQD/ujG9tPF6aNwi12JsNBg6Nb2YhdNeMhv9SzwhhtF/qQ5T50wmc46Ht8aONkLxR7ve
         MqiRjVw/JdMjZn94UZ9aqahBS5fdvYfWEoV3peB6uIhx8WHE3zrES5cL7w1KKYUck2fD
         hOqFAkHvAWMczEpPid9JVzHHwyYTNY0nHFsq0R7WmHPPrkkIV87vSPU3WrygiEe1dMje
         SM1Q==
X-Gm-Message-State: AGRZ1gLUtaMTiwEkHRIaZ3i7Sa1wZZ3hYRogXyStlfMQMG87VdDQQw6u
        bEhSu3Ec+g+LqELZWLQe0xGip3n9
X-Google-Smtp-Source: AJdET5cZmWIqjty6uNC2BaA6THA7J9mkAMqJ1HnTjRbPdJf/Afi5cdlDay5GEMFT/jRcJgzrkZlUbA==
X-Received: by 2002:a19:4287:: with SMTP id p129mr2884318lfa.135.1540621514391;
        Fri, 26 Oct 2018 23:25:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 68/78] config.txt: move submodule.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:41 +0200
Message-Id: <20181027062351.30446-69-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt                                     | 2 +-
 Documentation/{submodule-config.txt => config/submodule.txt} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{submodule-config.txt => config/submodule.txt} (100%)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index aedc73f4eb..966e82e851 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -417,7 +417,7 @@ include::config/status.txt[]
 
 include::config/stash.txt[]
 
-include::submodule-config.txt[]
+include::config/submodule.txt[]
 
 tag.forceSignAnnotated::
 	A boolean to specify whether annotated tags created should be GPG signed.
diff --git a/Documentation/submodule-config.txt b/Documentation/config/submodule.txt
similarity index 100%
rename from Documentation/submodule-config.txt
rename to Documentation/config/submodule.txt
-- 
2.19.1.647.g708186aaf9

