Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BD9C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347522AbiEUWTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347202AbiEUWT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC09F4F9D6
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f2so15949280wrc.0
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y2TVXfMwlfHc1TCkqIbbvSRjy83Gr/7B7EoPIFiQezE=;
        b=UudplfDFe49RBPWu+WzlFa5HYfFZAYUhrKfyL5ZKRXKwTgKWK+uBEQv36FOiqIJYeg
         hPZT58bF6q+wbqy42nrndyEn2UGett09PJQvd6cxQE2rU/n4TrlG5M5qhhpgi/IbYtPv
         qaFbnsOypa2RFx7+zbgfL5XJnYM4vmL+RT3VxGWLOqdj/iU+rPSSE9roGOYtWPMS0CKL
         EdIECA3Yqd/6blVQ5VQAb8DOw0bPRrZKXluugObxeP31UMjgyv2ij1kIA+q06EvAs9uA
         0XaAO+MNRyrmmA8M0L73Pe60N1lrPaIYltnffBzrvKit02tITDOr0wlYGOpi/KHO0aBT
         K1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y2TVXfMwlfHc1TCkqIbbvSRjy83Gr/7B7EoPIFiQezE=;
        b=j4z7Urtjy0ngJufqIz39ztm71DsU+4Lz96iGBiEqh2FQ0xKA/EMGJZxE/rJVEGtCQl
         1/oCDOfCaouq4A1fpkR2Tz1YtIj/XimN+oGc+F5UQXgojQ1NndvU2QmtT8jTEDFQ8Fh5
         zFUhgms07lk4smp6EcaR2o+IfK+2wSqvtJo1RlPib2jRpWD4/UnbOvt1HGgw2oD2VVWs
         dmg9NKPc5w9JQSfB6EMOAmkmDGY4jDG3xN1iAUGVHI2XUpZFdjIIDVDRmMFZ2Y2snZKg
         0Le73fH+xmS7HadoMeBqsqlyCACzQZ5g9f24X0K60+VJyYWJsLbQAReBQqWJKYBCFSRj
         E+Cw==
X-Gm-Message-State: AOAM533ihSxCwYIvZjDhJmh/L78ksu5RGZxKmWcoYnQKAB4VWvQbJe8o
        jvytcDPpPaoZuvY92+bB2IWNKDQesIY=
X-Google-Smtp-Source: ABdhPJwDAzI1CMkJtc5IzKcEgOmJ5m6FoqR2yh4jeGmJfaB7roLacgsvhr95cEuC+m8+ydFy39M+rw==
X-Received: by 2002:a5d:6b88:0:b0:20d:e3c:1d25 with SMTP id n8-20020a5d6b88000000b0020d0e3c1d25mr13250256wrx.304.1653171549141;
        Sat, 21 May 2022 15:19:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n128-20020a1c2786000000b003942a244f50sm5516380wmn.41.2022.05.21.15.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:19:08 -0700 (PDT)
Message-Id: <7f921ffef1205775125699d0dff4ad8c39c3ea3d.1653171536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:54 +0000
Subject: [PATCH v3 10/12] ci: use `--github-workflow-markup` in the GitHub
 workflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
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
index f8cb79e44f0..de6532ee8cd 100755
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

