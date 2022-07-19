Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36C5C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiGSSc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240133AbiGSSc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:32:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A5557E15
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:32:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d8so2938897wrp.6
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WbE/1GCTboOCXyalN2u5t+holWP+PwGqsySSBLdAy9E=;
        b=qzRkfrOsCxyv/pJLNfuArcvAJb4g7xwHhvmejxneJrOeD1hA7W2QHbfzIpRRx5pi4k
         FeDBNNV9hkmKs4eOdBvoPaRWhfphONJpUKP6CXQlRB3wN3bl7M5tnhwYI0K+kwacbwsx
         QiFCY+Lg3uZw8zqOXc7Ajgn94Np3G+J3CERUie/jJDx3mzRVtiMnMl4/Z1HqnsZ6xpNf
         Sz1vWXkWXJjVv33YnHcVoBgXDYBLdbGlGAxIHuihTiJGiEXSnT4wgClODg5+jlMxZrs+
         Sa9mVlmztr1buAD0uevbopxOGBPgbWT36Y9ZTSw9tcJV8izgHDGMSc6qia6VhLwsaqc2
         ++zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WbE/1GCTboOCXyalN2u5t+holWP+PwGqsySSBLdAy9E=;
        b=jjWJIn/1u4e28L/fz05ZA0X4n66JbD0C/V2DYnVAfYbHPukmnkD4q7553reT+HoPlU
         IWnwIYx2icxJir21zb7irsSWIhVXEwlgDFVmT9FmCjXA47KTP6sf+hUH3Lk5AKmLmfG7
         83bqsFhIzbbbYmwpbD5qHp5arwe4NLia8sBxsbmzAnkFFAS7vLeUjZthf82rxlXVyx5v
         Dt6414tYLdiAmNV5dAvoP6D3bFvvOPkPacY1XBVk3SAkBHauPPs1aXPsmPdu8B0TpQXF
         7x8ShQLEekLeUpwvgYQDGp6hzGYEg9v+Bm31XYqSKgDS5LwO1Zov140O9zM0alExauk/
         Na1A==
X-Gm-Message-State: AJIora9tzDUQNKbUPNG82APfAEBDNSav6KjmWW8wTRjO94Vxx6qx2JHz
        Fz+OMcKRK+SynfKzNOA6Ud38FFneeGQ=
X-Google-Smtp-Source: AGRyM1sSOoXbnbNxJoV9QJKMM+h+EioaDHy87jloN6GpJCKwJtkjYNguP78m1JNjniBe13xWNGsS4g==
X-Received: by 2002:a5d:5143:0:b0:21d:61b6:5225 with SMTP id u3-20020a5d5143000000b0021d61b65225mr27148036wrt.164.1658255543680;
        Tue, 19 Jul 2022 11:32:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d6946000000b0021b91d1ddbfsm14090522wrw.21.2022.07.19.11.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:32:23 -0700 (PDT)
Message-Id: <e08342f07d2d5268208f637ce229210a1d99f83b.1658255537.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.v3.git.1658255537.gitgitgadget@gmail.com>
References: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
        <pull.1274.v3.git.1658255537.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:32:16 +0000
Subject: [PATCH v3 4/5] t: avoid "whitelist"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
 t/lib-proto-disable.sh        | 6 +++---
 t/t5812-proto-disable-http.sh | 2 +-
 t/t5815-submodule-protos.sh   | 4 ++--
 t/test-lib-functions.sh       | 3 +--
 4 files changed, 7 insertions(+), 8 deletions(-)

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
index af8772fadaa..d8da5f58d16 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -16,7 +16,7 @@ test_expect_success 'create git-accessible repo' '
 
 test_proto "smart http" http "$HTTPD_URL/smart/repo.git"
 
-test_expect_success 'curl redirects respect whitelist' '
+test_expect_success 'http(s) transport respects GIT_ALLOW_PROTOCOL' '
 	test_must_fail env GIT_ALLOW_PROTOCOL=http:https \
 			   GIT_SMART_HTTP=0 \
 		git clone "$HTTPD_URL/ftp-redir/repo.git" 2>stderr &&
diff --git a/t/t5815-submodule-protos.sh b/t/t5815-submodule-protos.sh
index 06f55a1b8a0..4d5956cc18f 100755
--- a/t/t5815-submodule-protos.sh
+++ b/t/t5815-submodule-protos.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test protocol whitelisting with submodules'
+test_description='test protocol filtering with submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-proto-disable.sh
 
@@ -36,7 +36,7 @@ test_expect_success 'update of ext not allowed' '
 	test_must_fail git -C dst submodule update ext-module
 '
 
-test_expect_success 'user can override whitelist' '
+test_expect_success 'user can filter protocols with GIT_ALLOW_PROTOCOL' '
 	GIT_ALLOW_PROTOCOL=ext git -C dst submodule update ext-module
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6da7273f1d5..8c44856eaec 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -651,8 +651,7 @@ test_set_prereq () {
 		# test_unset_prereq()
 		!*)
 			;;
-		# (Temporary?) whitelist of things we can't easily
-		# pretend not to support
+		# List of things we can't easily pretend to not support
 		SYMLINKS)
 			;;
 		# Inspecting whether GIT_TEST_FAIL_PREREQS is on
-- 
gitgitgadget

