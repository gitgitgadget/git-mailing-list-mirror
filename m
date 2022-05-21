Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570D0C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347544AbiEUWTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347217AbiEUWT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC554F458
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u27so15087571wru.8
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Zcmg8CXfDIdiDJgUpqdHIkQo6vuybaLwMqJMMB59IA=;
        b=J61ATOcdijkiAKtkiTAu/t2KF7arkrP+i3B+cdW/oN1P90Lp6+1pNu4ju6lYUwIRab
         JGin9an2Usk1FTkp6JGTfXpjKZ8k1yGeipChyOxgEzcqroj6xbs4Bxsqmo8GesE1FkAs
         7IlzGlW/Zl2vX+Wauoyp2kWGWvWqjoWxoCaN2SOof5GvB0IsBnExUeDVlogg30vMQgT5
         GqZmVc8NIwxjejf4gOu97FWZS3VrTsNjezHxPkvmgUBswON4v8q4Vu2c5ttW0PVXlXi3
         g0o4EiUbvWyV/rrFd0wlBVV7kfA273EyWVB0HupDc1p1xHWOFyB/MYOYyzU9B6FW9vAi
         ZPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Zcmg8CXfDIdiDJgUpqdHIkQo6vuybaLwMqJMMB59IA=;
        b=Z0ckIGts5/uM1zwBATxRUpyay/1wW17SVE0fQD7/x3/7jxNXrQvuVbO6te6p+xgMoc
         4V0yTyfP7yzoCtGC6UI9DwreDA1+37z6w3DED1elzL3inRQe+VgLKMr+JcJpzGkP2Prc
         UDgeVtCm4nyEwPbqtda7aOBqFpBtlnSFAnT9FtwT/D3OEoW1aUACpsaJYSyumEx5K+Qb
         QM6K9c4GaQOlma89DYZlyIN7LLlw+ubVdA2Mpn+SYPVAFlplCbOIgOXjJyHH914QD3/O
         M+vP2I8J45NRk2/RUHDpzQ4pgPBOna40gjB4dqIOFrkMoUcAt59NCqDkrADrps6cM5sW
         kZPQ==
X-Gm-Message-State: AOAM530muIbH7SA6rcjRzoRC/1hU4hB3MiZ/XRAM7BQdvCIp26HSTypq
        8z6GW7VxqMTpheMNjNS2kh8ZPO4lK8c=
X-Google-Smtp-Source: ABdhPJxwcuUZGKBwpQLPrZuO6shCJV7+0ggWi470VFc3T12aG9xZgswlPpEup7wPjkzQ7eBFdoLT7Q==
X-Received: by 2002:a5d:6286:0:b0:20d:9b5:6a97 with SMTP id k6-20020a5d6286000000b0020d09b56a97mr13458965wru.165.1653171548011;
        Sat, 21 May 2022 15:19:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g24-20020adfa498000000b0020c5253d90csm5984742wrb.88.2022.05.21.15.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:19:07 -0700 (PDT)
Message-Id: <51573ef6c540abe19544e978a0110a5b51d7227d.1653171536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:53 +0000
Subject: [PATCH v3 09/12] ci(github): avoid printing test case preamble twice
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
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

We want to mark up the test case preamble when presenting test output in
Git's GitHub workflow. Let's suppress the non-marked-up version in that
case. Any information it would contain is included in the marked-up
variant already.

Signed-off-by: Victoria Dye <vdye@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-functions.sh              | 2 ++
 t/test-lib-github-workflow-markup.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index af4831a54c6..89a5e146b7a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -803,6 +803,7 @@ test_expect_failure () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
+		test -n "$test_skip_test_preamble" ||
 		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $2"
 		if test_run_ "$2" expecting_failure
 		then
@@ -823,6 +824,7 @@ test_expect_success () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
+		test -n "$test_skip_test_preamble" ||
 		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
 		if test_run_ "$2"
 		then
diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index 1ef0fd5ba87..9c5339c577a 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -20,6 +20,8 @@
 # workflows; these functions will then override (empty) functions
 # that are are called at the appropriate times during the test runs.
 
+test_skip_test_preamble=t
+
 start_test_output () {
 	test -n "$GIT_TEST_TEE_OUTPUT_FILE" ||
 	die "--github-workflow-markup requires --verbose-log"
-- 
gitgitgadget

