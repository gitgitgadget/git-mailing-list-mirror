Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C801BC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 02:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbiGOCiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiGOCit (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 22:38:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5F5186FB
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:38:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v14so4920944wra.5
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=512TSv1BhDBum5ZjAB6WdIvoruLPU2lnwxcXGckw5xo=;
        b=PwzMuHvNTjL0M3vATT0w00OYJVgscU9FcZnfMO9k1RVRBz/AECX7yioDcFOw/BGwKB
         vhqcUuAh10wx9jd54S0WlUka6z8UHEGJu3b0/y1BU7P6ZqzE5bSAt+5AF9RhojbGWiZD
         zwKgwr3Bn0JeK/KnwwYwDRMnDeKQb1NnnZBLvKw0gngJzyJ/w5w2OyR9sA7dB8ehQyCg
         OjxSQh8An/vJda2pnQzl5EfwmECbB2x7pVljEYVeSz28Mr1nLr0AHkP3Kvp/iuiID28y
         8aY7A8XcuaeeSvwUHyQCcE+BMAAnBHp6d31NBrcD3cGLKoIgcTHjezIOgqdUOUYw9d9r
         l58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=512TSv1BhDBum5ZjAB6WdIvoruLPU2lnwxcXGckw5xo=;
        b=Azj//BRzHqT+nhdVWI8NuRv+HzC5Lp5+F13BGrhsjoWi1/zGn/AIAk/VbaweI3h2xF
         FJEg6r92Cub1TU1mCG/hl6elV2fjFiraQhzsX9v86HSdyo86akw8/aKygo71emCnYAqL
         MlhFNjeEsZco9Ha36ok0rXrZWznrvTwGw7wUkdz+Aa8PbGH3r7hgnsARdIGuTNYPuoPl
         48r82Er61UhkmCMMv5AutfIuzlVOJueQf4sB1kUXYos/g1Sm+cjlj0Z8Kvp2MQPoHB5Y
         HvRU2GNyOZK3dKRToi73zho53MxcKRkvCM0gUQtxTB6JPDTywcxadnw/lascvkJd1uHq
         6mRw==
X-Gm-Message-State: AJIora9TJBL9IbVAJhxmr1zCtwM7kR0c5rnajih63gJySxIu8I5t/4Ws
        ZIP2zuR7KG4KOPYZ8xyB7Yfvs7XnWlY=
X-Google-Smtp-Source: AGRyM1vloxXeWns8vkADaOQi06ueUgrZd+vXors2WoPr++Dtk0c87aF5wWyerrvGS0ZvVIsvA8VUlw==
X-Received: by 2002:adf:e503:0:b0:21d:6d98:a92a with SMTP id j3-20020adfe503000000b0021d6d98a92amr10520566wrm.62.1657852726372;
        Thu, 14 Jul 2022 19:38:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8-20020adff4c8000000b0021d887f9468sm2683124wrp.25.2022.07.14.19.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 19:38:45 -0700 (PDT)
Message-Id: <3c3c8c20bcb4e570d25a676ad1f29877762adb82.1657852722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
        <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Jul 2022 02:38:41 +0000
Subject: [PATCH v2 2/3] t/*: avoid "whitelist"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The word "whitelist" has cultural implications that are not inclusive.
Thankfully, it is not difficult to reword and avoid its use.

Focus on changes in the test scripts, since most of the changes are in
comments and test names. The renamed test_allow_var helper is only used
once inside the widely-used test_proto helper.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/README                        | 9 ++++-----
 t/lib-proto-disable.sh          | 6 +++---
 t/t5812-proto-disable-http.sh   | 2 +-
 t/t5815-submodule-protos.sh     | 4 ++--
 t/t9400-git-cvsserver-server.sh | 2 +-
 t/test-lib-functions.sh         | 2 +-
 t/test-lib.sh                   | 2 +-
 7 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/t/README b/t/README
index 309a31133c6..56d5ebb5798 100644
--- a/t/README
+++ b/t/README
@@ -367,11 +367,10 @@ GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
 GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
-SANITIZE=leak will run only those tests that have whitelisted
-themselves as passing with no memory leaks. Tests can be whitelisted
-by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
-"test-lib.sh" itself at the top of the test script. This test mode is
-used by the "linux-leaks" CI target.
+SANITIZE=leak will run only those tests that have marked themselves as
+passing with no memory leaks by setting "TEST_PASSES_SANITIZE_LEAK=true"
+before sourcing "test-lib.sh" itself at the top of the test script. This
+test mode is used by the "linux-leaks" CI target.
 
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
diff --git a/t/lib-proto-disable.sh b/t/lib-proto-disable.sh
index 83babe57d95..890622be816 100644
--- a/t/lib-proto-disable.sh
+++ b/t/lib-proto-disable.sh
@@ -1,7 +1,7 @@
 # Test routines for checking protocol disabling.
 
-# Test clone/fetch/push with GIT_ALLOW_PROTOCOL whitelist
-test_whitelist () {
+# Test clone/fetch/push with GIT_ALLOW_PROTOCOL environment variable
+test_allow_var () {
 	desc=$1
 	proto=$2
 	url=$3
@@ -183,7 +183,7 @@ test_config () {
 #   $2 - machine-readable name of the protocol
 #   $3 - the URL to try cloning
 test_proto () {
-	test_whitelist "$@"
+	test_allow_var "$@"
 
 	test_config "$@"
 }
diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index af8772fadaa..bbeebee02f1 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -16,7 +16,7 @@ test_expect_success 'create git-accessible repo' '
 
 test_proto "smart http" http "$HTTPD_URL/smart/repo.git"
 
-test_expect_success 'curl redirects respect whitelist' '
+test_expect_success 'curl redirects respect allowed protocols' '
 	test_must_fail env GIT_ALLOW_PROTOCOL=http:https \
 			   GIT_SMART_HTTP=0 \
 		git clone "$HTTPD_URL/ftp-redir/repo.git" 2>stderr &&
diff --git a/t/t5815-submodule-protos.sh b/t/t5815-submodule-protos.sh
index 06f55a1b8a0..990f034149d 100755
--- a/t/t5815-submodule-protos.sh
+++ b/t/t5815-submodule-protos.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test protocol whitelisting with submodules'
+test_description='test protocol restrictions with submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-proto-disable.sh
 
@@ -36,7 +36,7 @@ test_expect_success 'update of ext not allowed' '
 	test_must_fail git -C dst submodule update ext-module
 '
 
-test_expect_success 'user can override whitelist' '
+test_expect_success 'user can override with environment variable' '
 	GIT_ALLOW_PROTOCOL=ext git -C dst submodule update ext-module
 '
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 210ddf09e30..51b798cb493 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -221,7 +221,7 @@ test_expect_success 'req_Root (export-all)' \
   'cat request-anonymous | git-cvsserver --export-all pserver "$WORKDIR" >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU\$"'
 
-test_expect_success 'req_Root failure (export-all w/o whitelist)' \
+test_expect_success 'req_Root failure (export-all w/o directory)' \
   '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
 
 test_expect_success 'req_Root (everything together)' \
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6da7273f1d5..6fe62329d8b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -651,7 +651,7 @@ test_set_prereq () {
 		# test_unset_prereq()
 		!*)
 			;;
-		# (Temporary?) whitelist of things we can't easily
+		# (Temporary?) list of things we can't easily
 		# pretend not to support
 		SYMLINKS)
 			;;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 55857af601b..fff85f4b425 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1408,7 +1408,7 @@ then
 	test_done
 fi
 
-# skip non-whitelisted tests when compiled with SANITIZE=leak
+# skip unmarked tests when compiled with SANITIZE=leak
 if test -n "$SANITIZE_LEAK"
 then
 	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
-- 
gitgitgadget

