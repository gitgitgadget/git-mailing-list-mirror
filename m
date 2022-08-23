Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57400C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 19:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiHWTGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiHWTGG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 15:06:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB02B6557D
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 10:42:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k17so7572669wmr.2
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=McHBbqFFym4vtRCw+1GYkiwBpIs8HlufUxgcYf2Xnu8=;
        b=Jrbqr0j4LmhIXos4VBPvNSWFTrv7mxQlzTU0D7ptlZHeV0bs8Qr+41P/bVpIgD242B
         on5oToNoqEeSBaPtR6pj6w+o8bm/jMmSS5+ewTzRK2ooUCRqzBenQJt/SNZM8NuNP5s4
         xXXxPgqzIqqkG1chdufjnbjeQ+EMCVrpj1jch5HLkNYaZMEtnCzbQlSFMMVRSmsUtSZP
         Thp7NiPgSswEYheAaT3hQ63AFuKGC71v1tUQM0MV2gZOXAiqHGK/whdPewZQo7zyDF7N
         x3YK6CoPkJhMF8XyfY5LnaFtsVsg07qfPDvz2+ia3/0Ua7u8wtPx4uCstXi6hQq1lHPp
         rZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=McHBbqFFym4vtRCw+1GYkiwBpIs8HlufUxgcYf2Xnu8=;
        b=VpVA/lWXUpq6rynNJnYAvBMnXAUdvrt4EDXj+EmPjC8UspW6Sh9hpmHGJeoobVbFWx
         1KNdXPJJSo0qBXOUMd4Y9WZsKBUNuZI9LMyGdvIbuS0hDKN2BGUTdVRLrzhT5l4GSQw9
         8NGp3cIg4G1V9EBszuWj1z2Z59UzUQfHuAE/OJmShnrCrDXOkVUgwtse/wjpQ7hzLKoX
         y3AbpjL4eu5AVLdg3LD+Vzv6YDrYTPfzasbrLWCKZIMoQPuGWHVcSOqAjE5vJct01EZK
         bXQv/RI+ZEvAgXNVRp4cK6P6+ShjYd80CSfBfeFCkyHzH7LmYFWgHd8U05QYcpb96911
         PwcQ==
X-Gm-Message-State: ACgBeo2ZMWntsY8FP++HuIju0rHNKPI5jeXh8aZIvtIsz1G4bqfoWR6b
        OyEb8BbAjNmb72F9b8TCdSbsS0nMgpA=
X-Google-Smtp-Source: AA6agR4UV9h9o0S1zAX0Bz/6rOD3OGvIk7nl/niOXeYd44G4DFcuVyCnWAciUmvEd4oM+Cfc5sGXuQ==
X-Received: by 2002:a05:600c:8a7:b0:3a6:85b1:2275 with SMTP id l39-20020a05600c08a700b003a685b12275mr761131wmp.30.1661275692875;
        Tue, 23 Aug 2022 10:28:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6-20020a5d4386000000b0022159d92004sm8794622wrq.82.2022.08.23.10.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 10:28:12 -0700 (PDT)
Message-Id: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 17:28:11 +0000
Subject: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

GitHub Actions scheduled a brownout of Ubuntu 18.04, which canceled all
runs of the 'static-analysis' job in our CI runs. Update to 22.04 to
avoid this as the brownout later turns into a complete deprecation.

The use of 18.04 was set in d051ed77ee6 (.github/workflows/main.yml: run
static-analysis on bionic, 2021-02-08) due to the lack of Coccinelle
being available on 20.04 (which continues today).

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    ci: update 'static-analysis' to Ubuntu 20.04
    
    I noticed this while preparing my bundle URIs series. See an example
    cancellation at [1]
    
    [1]
    https://github.com/gitgitgadget/git/runs/7954913465?check_suite_focus=true
    
    I initially asked about this [2]. Thanks to Matthias Aßhauer for
    pointing out that 22.04 has Coccinelle available [3].
    
    [2]
    https://lore.kernel.org/git/eb8779bc-fc41-f601-05f2-024e6bf3f316@github.com/
    [3]
    https://github.com/gitgitgadget/git/pull/1334#issuecomment-1223597655
    
    Thanks,
    
     * Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1334%2Fderrickstolee%2Fstatic-analysis-ubuntu-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1334/derrickstolee/static-analysis-ubuntu-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1334

 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index cd1f52692a5..831f4df56c5 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -309,7 +309,7 @@ jobs:
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
       jobname: StaticAnalysis
-    runs-on: ubuntu-18.04
+    runs-on: ubuntu-22.04
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh

base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
-- 
gitgitgadget
