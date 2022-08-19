Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F2FC32796
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 20:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351857AbiHSUtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351630AbiHSUtS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98DDBE4FD
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 13:49:13 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay12so2773174wmb.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=W98woZsVBRUf4WUkYII3h78zU2867jibfQa4Bp4yKiQ=;
        b=k2JSMWwjzUyP6pJ8UCtwHt+ZYsnhPxChpUTSEMrz6Plj6plZEXaFwFi0Xt89ayIjs3
         miOplL6pge/BsxyUUA6C1wJs/avCS1eMQqsbBO35kSM6iwLiBB/yPZPuVWa5LhTq3AiP
         csrCCzGl50KE+btJOSzYGIdm5/CWwlcvmlfZjqjVNZt6eN2CraTcvud1JO5WhAA5G2xJ
         5oL1qoQQyP50aEphitVyF/lUV+a4UjFn+KMcsxnge1J6VlFpRmHjZFN2OduTnE4f3Rlr
         dhCX8Z+NKVfq29jRU9tKQADrE0wGSFrOubgxWbxoeAWZOhkp9WfX+CZxY+HU+tHviu6C
         cnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=W98woZsVBRUf4WUkYII3h78zU2867jibfQa4Bp4yKiQ=;
        b=e3EoGaMxItIsFkX+wER1WPQqA6Qk5W5eKi0JtwlyAqyTUTIu/BI/45RB7/zz3mPLr1
         EQLzGZgLacvXf3+DAOsPnaPNBJoWxHtGKgkKGiuExhFu2g9UfGDGFzOM4fLWZlcPeL5U
         E3GIk404Yj2fpqIzg9lQ6lMVcpyfAkPR2Ken2YfssflyYKqbHmkMTtpVirge9bN6Z5dI
         Ti0UMECrL8Ha69eYKiqZVbuMUaRumRsygygFoVdbs8P5iKkle1N9sujuOHeQySd/4+Lu
         9sqdjUOrO4Krd2iZ4C5XADjM1ceG3S2c8XcFaYTfkzBnDBYR0o4LaAbJSg/ZSPa4bUzK
         cphg==
X-Gm-Message-State: ACgBeo1EotVMvGP10xn2k+lvvdlMFROqtHlzXlupBFJlrjZ5Kg38K+6f
        DBK/94r68Zv7yvDb4WSD4oGj/YNizX0=
X-Google-Smtp-Source: AA6agR68Wpv35zkcWcz52t5/TEBd7uCt//kxBMerwLajKuFH5eGNuzLjMzs1sjvXJqUjHnG86xLJFw==
X-Received: by 2002:a05:600c:4e11:b0:3a5:bfd3:a899 with SMTP id b17-20020a05600c4e1100b003a5bfd3a899mr8900309wmq.185.1660942151714;
        Fri, 19 Aug 2022 13:49:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d5387000000b002235eb9d200sm5210390wrv.10.2022.08.19.13.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:11 -0700 (PDT)
Message-Id: <0e71792a718512089b94c0d5985db7fd8093c6a5.1660942149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1330.git.1660942149.gitgitgadget@gmail.com>
References: <pull.1330.git.1660942149.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 20:49:08 +0000
Subject: [PATCH 1/2] p0004: fix prereq declaration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Fix multi-threaded 'p0004' test's use of the 'REPO_BIG_ENOUGH_FOR_MULTI'
prerequisite. Unlike normal 't/' tests, 't/perf/' tests need to have their
prerequisites declared with the '--prereq' flag.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p0004-lazy-init-name-hash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
index 1afc08fe7f1..85be14e4ddb 100755
--- a/t/perf/p0004-lazy-init-name-hash.sh
+++ b/t/perf/p0004-lazy-init-name-hash.sh
@@ -49,7 +49,7 @@ test_perf "single-threaded, $desc" "
 	test-tool lazy-init-name-hash --single --count=$count
 "
 
-test_perf REPO_BIG_ENOUGH_FOR_MULTI "multi-threaded, $desc" "
+test_perf "multi-threaded, $desc" --prereq REPO_BIG_ENOUGH_FOR_MULTI "
 	test-tool lazy-init-name-hash --multi --count=$count
 "
 
-- 
gitgitgadget

