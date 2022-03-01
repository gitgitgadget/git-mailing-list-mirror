Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE61C433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiCAKZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiCAKZj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:25:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059FA8EB6F
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:24:58 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v21so19689485wrv.5
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 02:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j6UNosA7rDWBCRSEyRyJD//8oJNvmRDXP+YqXB45j08=;
        b=PFTQxvBaSCX5JanWKnFV5mI6DqFE3jsJcc3X5iw1qM25zQ5ElusAETqRY+Y17kQGWz
         xAX1C2tQzKSQmtCPa2fLV+QpWkRFi8WH4yhORhdW0Mj+D5XvepV5oPSFVHjmcd2osEYD
         hc9iM+23DpEHKk5Hz8pRRyV99ezSV8tzefE+WqGo3f4mk/UMO0dG4nMdJzORWV50wiNV
         WXLA1bNjFVL302V7V2UgFSVw+4e5Cr19c/hCnKlm4E4H2utTldFsgHRw5qUx/Dr0P088
         4BaOMYrX2aguYGEskSjktPbOVVLbXiBhtZQeFe+DZ2izFFVH5Y3a9ctPyp2aGw8eQuS6
         80dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j6UNosA7rDWBCRSEyRyJD//8oJNvmRDXP+YqXB45j08=;
        b=k2wquopmDkbeZpN+BZ43ooFemriuNxCWFZ6Q21Ea2s4ga/YVfr1o1EaoPAZW6YJSzP
         s9LkCi8kkftPv5BpVWQz9xXfVsL+OweijwOztHnsE3wen5a7ih7DO93Qq6uYRZz+/bPm
         pFUeboz37o4DtMhEnW/F2ciCE+BHy8n7dAoYii37vtRRp2xBqr4R6kYoOT1O5xzGFLzN
         0L4QyNi0GxMhkC1y7xNg9yk6fqT6IcafQI+q4PgKz1fu9owm9Fex0aEgr4jHiy0xvP+l
         Gd/lMawnvXpD1A237vXDPIReuhn9YJMHpWdrByTdfRbWgv/iwacEoiBx9qWAwRxkephs
         vZgQ==
X-Gm-Message-State: AOAM530AcMGpnehmpW9tzQYHNGGcR3qQN3sD2IXF6c3nkmmLqTezLUI9
        kna8muKtKlyaf4PX94Ug3u57qAdWlPY=
X-Google-Smtp-Source: ABdhPJz7Z/iPULe0ZNFZ4lN9ALYFWeflUB6zmS0Fd2h1BorEd/oYCZ3V5qWc0J8sF7N5cvgg2rvWeA==
X-Received: by 2002:a5d:6f14:0:b0:1ef:7e83:6eeb with SMTP id ay20-20020a5d6f14000000b001ef7e836eebmr12246980wrb.554.1646130296486;
        Tue, 01 Mar 2022 02:24:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d65c3000000b001e4b3ba1423sm13365584wrw.60.2022.03.01.02.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:24:56 -0800 (PST)
Message-Id: <91ea54f36c5724f08cd784b50519d628fd73f1a4.1646130289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 10:24:48 +0000
Subject: [PATCH v2 8/9] ci: use `--github-workflow-markup` in the GitHub
 workflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This makes the output easier to digest.

Note: since workflow output currently cannot contain any nested groups
(see https://github.com/actions/runner/issues/802 for details), we need
to remove the explicit grouping that would span the entirety of each
failed test script.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2a1b22db12a..7cc000e075c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -177,7 +177,7 @@ then
 			test_name="${test_exit%.exit}"
 			test_name="${test_name##*/}"
 			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
-			group "Failed test: $test_name" cat "t/test-results/$test_name.out"
+			cat "t/test-results/$test_name.markup"
 
 			trash_dir="t/trash directory.$test_name"
 			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
@@ -189,7 +189,7 @@ then
 	cache_dir="$HOME/none"
 
 	export GIT_PROVE_OPTS="--timer --jobs 10"
-	export GIT_TEST_OPTS="--verbose-log -x"
+	export GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test windows != "$CI_OS_NAME" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
-- 
gitgitgadget

