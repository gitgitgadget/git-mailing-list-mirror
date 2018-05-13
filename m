Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8BC1F42D
	for <e@80x24.org>; Sun, 13 May 2018 09:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeEMJSA (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 05:18:00 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40280 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeEMJR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 05:17:59 -0400
Received: by mail-lf0-f67.google.com with SMTP id p85-v6so13707607lfg.7
        for <git@vger.kernel.org>; Sun, 13 May 2018 02:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W9FPt+sIt0wMfBr3aPhd+5FkNlUaapmhCMKWX8VF/3M=;
        b=NZ78Gy+Z2OTEOwZ5dZdrFkKObzBszsA3cGpIcTcF8k7L6NIgOSHFK3a9kkCTY3Np6/
         +7GyUrymk077w6U60RcfsS0gcQQrVCXlX9A0KeTD6yOur+KtXrNMsVtnbJOFz792LObq
         n0LiUdTsIc9NXyo+x1HmEg4NW/5RwBlBjOsJjXRvAKPrvAOZ2xRCWnCYlk7GP7+5lJr9
         rE+5g5liuRCTRWDySYqvArJC3lkx4BrkDY9r2nAHQuyJD60uqfizVJkjb0Tne5Irq5EP
         cBBMeVyLK4mX1Z8LO7ZeuhyNwD2yebXpFlQdM3cu6XZA6tXkrSus7DibTH1RNZkCpEau
         2nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W9FPt+sIt0wMfBr3aPhd+5FkNlUaapmhCMKWX8VF/3M=;
        b=oXHj7hlogoV6x+oaLnVYZNsRaeQ62E2XDU9L9BxADh1P2J/8bV6HbuYOdaZ1ET/kRx
         gJnmmLbcTifyotLMtMzbjE16skBX1dA/4Jut9K18bZ1khtDrVU2bLMZ5iI7w8WGXtc4m
         +/X6yWcu+pgxqez9/xGP9MTHuB4bVbFjpHLrKQxl4Y4mbI81i0i2CUpdoyxQfBQmf80w
         xLh9mzq+XiqMSQiJV2LuiAKJrOdeDzELqpk82IdZvAiUQhPmF5U2RgJZUsLjZ7v9OIBy
         EJBIdrmd9enjsdNsDuOttSu90ZCTLa7fbCsM2hwBP/LuWCpaMr140QTdy1h2wrVAwX2+
         hEWA==
X-Gm-Message-State: ALKqPwc1WABgBdDQi9q6GgmlyO7HcCqgs1dHTsMk/AM2Ri9c1VHTzVvn
        rHS4KA9sqUCQW58lQbLu6A/kzw==
X-Google-Smtp-Source: AB8JxZok0Lo6YvTYK/146mgFCXn1OaDnBCAVMxRj8DYrekcvcfZ+fVuH7t1Q3dO90A7+OeA4d1/RMw==
X-Received: by 2002:a19:930f:: with SMTP id v15-v6mr5520950lfd.83.1526203077657;
        Sun, 13 May 2018 02:17:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f10-v6sm1372719ljg.2.2018.05.13.02.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 May 2018 02:17:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] travis-ci: run gcc-7 on linux-gcc jobs
Date:   Sun, 13 May 2018 11:17:51 +0200
Message-Id: <20180513091752.14003-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch from gcc-4.8 to gcc-7. Newer compilers come with more warning
checks (usually in -Wextra).  Since -Wextra is enabled in developer
mode (which is also enabled in travis), this lets travis report more
warnings before other people do it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 .travis.yml        | 3 +++
 ci/lib-travisci.sh | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 5f5ee4f3bd..a77f5f5bd5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -16,10 +16,13 @@ compiler:
 
 addons:
   apt:
+    sources:
+    - ubuntu-toolchain-r-test
     packages:
     - language-pack-is
     - git-svn
     - apache2
+    - gcc-7
 
 matrix:
   include:
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 109ef280da..ef2848fd45 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -99,6 +99,9 @@ export DEFAULT_TEST_TARGET=prove
 export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 export GIT_TEST_OPTS="--verbose-log -x"
 export GIT_TEST_CLONE_2GB=YesPlease
+if [ "$jobname" = linux-gcc ]; then
+	export CC=gcc-7
+fi
 
 case "$jobname" in
 linux-clang|linux-gcc)
-- 
2.17.0.705.g3525833791

