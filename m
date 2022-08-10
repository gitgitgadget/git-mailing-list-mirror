Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC7C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiHJPCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiHJPCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:02:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC0475FE3
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:02:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so18101546wrh.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Q3KJWsUHoyvk83fYpnqq1nuFuvSaE5HztSbDUOVTRRs=;
        b=k0QpzvfrxYwGBMOxnBdx+sMafIUTr+Mds1jCOMmdZ8soXVfrog4MLFnIdIn0HdqixB
         8WkDWf2cBKjIUN1JVkGi45MEfcGtUG3S9v0ALFR5xqZrfhdPFzTc3Wd+0xN4NUbMgpMY
         d9+rzO0GW4PTAr71a2x8ZeoHRI0awylkVS/nNRwpgzcdFoKJLRiCqA/EXdGxw6dcH798
         p0VmzFJo3IxW2zk9zsjmn4xU0PDXY1QYU0SakxbXCJ3+1W1MH3dTt9s7hD98G/VPNMhi
         WS6EjyrrT+5GoM+f3F2Gqgt15kfXuWOfQzW7WL5wGFrqa7n2rg1UGocDI60F7EQacCHO
         4Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Q3KJWsUHoyvk83fYpnqq1nuFuvSaE5HztSbDUOVTRRs=;
        b=XpgtwfXTVWTicKUnUhGrLcL7oKv6GepUXo1QWRjTXC/D23nSb2nqrr4EFuR0jFwOTW
         SLpIy9ycxqtDeIJlrUeljjKKqqTl6g2L/T9GrTa5S5pmyFqTNcqNFxmkDN/ye1Ryr1Wk
         uOwObk1+dfh4npFLvGZ0gn3Vl9oxOL/Pe3+s5u6BxyvKi5Q3pOtEjYYWNe/X41ZyHzcF
         o+/mouSyvSpU117HA1hTnbcjKAVOcMlef5UcETnMPlF2ONxU0qC3Et0wA8KT8wGXs0lN
         v9bNdNwjbqNfCWT6zKw8gNSUv1H8tyZvfgqjtRFoy5WIKldibdGvXZbyDRJ0+mkfBcud
         eS4A==
X-Gm-Message-State: ACgBeo2nWaMPzrig+6DxLKEcJZSr5+0hmNqZvL73sHEYnUIImftU0wTJ
        0BPY8JpDn7h2g+C4A3koTWiJV5JrVWo=
X-Google-Smtp-Source: AA6agR6ZGnzYy8YkoBKZ9rLqLgccezi2vVJ9jvTXRuHTHUh6NnBv1JkdDxRv6s75bSvNcVe587ZL+w==
X-Received: by 2002:adf:f384:0:b0:21f:1522:6b1a with SMTP id m4-20020adff384000000b0021f15226b1amr18481188wro.593.1660143754234;
        Wed, 10 Aug 2022 08:02:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d4b48000000b0021e4edba1e5sm16255058wrs.111.2022.08.10.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:02:33 -0700 (PDT)
Message-Id: <86ab58b65081601678a24f99eb4afa34cccaefba.1660143750.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 15:02:27 +0000
Subject: [PATCH 2/5] cmake: copy the merge tools for testing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Even when running the tests via CTest, t7609 and t7610 rely on more than
only a few mergetools to be copied to the build directory. Let's make it
so.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 4aee1e24342..fe606c179f7 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1078,7 +1078,8 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 	#misc copies
 	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
 	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
-	file(COPY ${CMAKE_SOURCE_DIR}/mergetools/tkdiff DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
+	file(GLOB mergetools "${CMAKE_SOURCE_DIR}/mergetools/*")
+	file(COPY ${mergetools} DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
 	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
 	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-completion.bash DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
 endif()
-- 
gitgitgadget

