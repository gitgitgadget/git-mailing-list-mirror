Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2733D1F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750769AbeESEck (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:32:40 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45921 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeESEcj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:32:39 -0400
Received: by mail-lf0-f67.google.com with SMTP id w202-v6so16739206lff.12
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NrUB47XND1icWZh29mMRLmvlqyuFCp3ojdkfSr0R8hQ=;
        b=AAijfQ91J7GeTc9AbujjBEAs6vzIjGvEAImXktcgh8jjQezP2U9WaGJibt0fiezWyh
         P49dlgz/x/fn6OA3MCm8mXmJb9O86/BrXAFoLII6lEYAQOBMe7FeTpfrADYxgJcsxZ0/
         Djh3yWxWETvWo/FsKpfncEBeiw7Mc/Sg5Xy4D+f77smC9WL+CXXzQcP6w+SR+DX0Ztju
         jTD17wQSvA7H44ESTmNWUbkJ6YiUqEuuCbzGlEuclylwg2EoDCQktGiToU9vlelXfXJY
         qIAkQqIxZbc9hrhPCYQn7qR5v0QTmY7S5ImwyyvpkxQFXEzDrbSQlbcsqcWmI05vkpPv
         WgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NrUB47XND1icWZh29mMRLmvlqyuFCp3ojdkfSr0R8hQ=;
        b=XFNiSROSjr3lsF9BBX74AyaFBgpd4pMEvpd5NBuRAjaT6ZObnBFr5z3ltn9K0dm9S9
         DT5swjoxWBhSvqLxm/mJ5VQEpIkFVjPKiDTJ85sTbtvnpd4ksbAGKTwi3skL6i195H+W
         2hshga1xm/jnf9OWcsY4QwLZ51hqJIFW0/hRvDXVqw2D10SdGXKr75tYYokigiNDxXMh
         aci0uVwe1w+abmESWUm4JapOZ1EwegryMKl6A5E0oxERKMV0xevkiI7iBwWxepOx6Kpp
         xm7qEqnv9rvnqmgF2fypVHOXJM+WDO7yFCRQiA4yZjXbyTFNw8tegCFXxk/GrYewCjYH
         tLeA==
X-Gm-Message-State: ALKqPwcNFkWAcsJs1Tz7mNssg0eURjUKTtG9b6HaPn3iHonUQDnKNCZC
        Wh51nSEX3DfV850uX+Rt8dHhwg==
X-Google-Smtp-Source: AB8JxZr7hiyDwXvpv9G4YiuLX/MKPVoxE8DmF89NV/Is7BqDZjchT/78/YE3SiQrLLfoUEnrm86Pyg==
X-Received: by 2002:a19:a692:: with SMTP id p140-v6mr10646672lfe.121.1526704357735;
        Fri, 18 May 2018 21:32:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v3-v6sm1487661ljj.71.2018.05.18.21.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 21:32:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] travis-ci: run gcc-8 on linux-gcc jobs
Date:   Sat, 19 May 2018 06:32:34 +0200
Message-Id: <20180519043234.9260-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513091752.14003-1-pclouds@gmail.com>
References: <20180513091752.14003-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch from gcc-4.8 to gcc-8. Newer compilers come with more warning
checks (usually in -Wextra).  Since -Wextra is enabled in developer
mode (which is also enabled in travis), this lets travis report more
warnings before other people do it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 switches from gcc-7 to gcc-8. I initially ignored gcc 8 because it
 was too new. But it built 'pu' ok and 8.1 was already out so the
 first wave of bugs should have been gone by now.

 .travis.yml        | 3 +++
 ci/lib-travisci.sh | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 5f5ee4f3bd..4d4e26c9df 100644
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
+    - gcc-8
 
 matrix:
   include:
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 109ef280da..ceecc889ca 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -99,6 +99,9 @@ export DEFAULT_TEST_TARGET=prove
 export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 export GIT_TEST_OPTS="--verbose-log -x"
 export GIT_TEST_CLONE_2GB=YesPlease
+if [ "$jobname" = linux-gcc ]; then
+	export CC=gcc-8
+fi
 
 case "$jobname" in
 linux-clang|linux-gcc)
-- 
2.17.0.705.g3525833791

