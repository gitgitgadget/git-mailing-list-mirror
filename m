Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37373CCA479
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiGMNVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbiGMNU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:20:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F7D38AA
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:20:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so1172058wmb.5
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GKWEyZMhshUZoup8C3AwSREjftqP6Zj/BYI98BTcQks=;
        b=iv30s0Y7SFtAlYOwtK/q20NKn2PqUX2Qd0BBus3DYv+qx3YMe32piFLyykSq8OM6Tu
         X6H7vHydQ2CCgrlTHve7vpQiA+FSh3WwpafVkaHnelO4squ+IPy5auKiXi/0oFT0lg34
         MB2WhNXdLvmPUHGwC4R4ilrMoSYDzT3TJpFxZvSsQWQETvA/MXU/DEb1cTkzmD1Gl3lb
         4kV1Y0/as246/ckRC3C5EB/OK2Oklhw2974MSk/M4Q7ooM93eCoAXy5rVrOFC0ZMrEwM
         jtues5H1BWedfJtWaJu1TdtoLCVX9x6Wx/+FD1y216mLrABVxWUlxgAHJw+kNFRMaEbR
         /w+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GKWEyZMhshUZoup8C3AwSREjftqP6Zj/BYI98BTcQks=;
        b=l11U0su+4JvD6zpP+RKZXEzjHqmLEdcGAVSNtBqilVtCa/2i8UKfl/bGEJduEoUdOo
         Mqx1HIVMIHB79g2+DqONwXfEBLEDzdexRhbcjeqOfKAmFhgZzrryOgvv/uEMQhNTCCCF
         xTleGTXqZyTUp24TMPNkzh6ZyrVZOJRgQN731UPEaAgNpoDd9xfLYnCgvTRY/aOATSXh
         PToK02bIHr/DizJ760CcTAW/O/CXwYr1IU/d3TWjZKyr+IRLhh5h5wddFSB9nFVBZzcU
         Qxq+g6sjuIvrIP9noU74NbPaYlcaxu++SReVOnVrkgjYUUq++h32guPNx5CYdpCALsLU
         PZpg==
X-Gm-Message-State: AJIora+u3Eamlc+1p+BrrPJMr+dUmbGFj+r47tGXPmMQhPNB6J5tnVkq
        quxYnpSvCSdAHTtCrloHSuUvKV1tLag=
X-Google-Smtp-Source: AGRyM1ucjbUMLJ6dEJ4RYWivR8gUwffIbx8mmeDRCrmcNWMylRnHU+xZAiQQFnSMZCl7HmGj+OcaMw==
X-Received: by 2002:a05:600c:3845:b0:3a2:c04d:5ff9 with SMTP id s5-20020a05600c384500b003a2c04d5ff9mr9807828wmr.74.1657718454725;
        Wed, 13 Jul 2022 06:20:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b003a2e2ba94ecsm2146998wmq.40.2022.07.13.06.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:20:54 -0700 (PDT)
Message-Id: <0d82c2a09c5e6a8e63b5294d738f51fc5b82af42.1657718450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 13:20:49 +0000
Subject: [PATCH 2/3] t/*: use allowlist
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Using "allowlist" is a more precise definition of the functionality
provided. The previous color-based word assume cultural interpretation
to provide the meaning.

Focus on changes in the test scripts, since most of the changes are in
comments and test names. The one exception is the renamed test_allowlist
helper.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/README                        | 4 ++--
 t/lib-proto-disable.sh          | 6 +++---
 t/t5812-proto-disable-http.sh   | 2 +-
 t/t5815-submodule-protos.sh     | 4 ++--
 t/t9400-git-cvsserver-server.sh | 2 +-
 t/test-lib-functions.sh         | 2 +-
 t/test-lib.sh                   | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/README b/t/README
index 309a31133c6..0c388a952f9 100644
--- a/t/README
+++ b/t/README
@@ -367,8 +367,8 @@ GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
 GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
-SANITIZE=leak will run only those tests that have whitelisted
-themselves as passing with no memory leaks. Tests can be whitelisted
+SANITIZE=leak will run only those tests that have allowlisted
+themselves as passing with no memory leaks. Tests can be allowlisted
 by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
 "test-lib.sh" itself at the top of the test script. This test mode is
 used by the "linux-leaks" CI target.
diff --git a/t/lib-proto-disable.sh b/t/lib-proto-disable.sh
index 83babe57d95..6f2de57ef29 100644
--- a/t/lib-proto-disable.sh
+++ b/t/lib-proto-disable.sh
@@ -1,7 +1,7 @@
 # Test routines for checking protocol disabling.
 
-# Test clone/fetch/push with GIT_ALLOW_PROTOCOL whitelist
-test_whitelist () {
+# Test clone/fetch/push with GIT_ALLOW_PROTOCOL allowlist
+test_allowlist () {
 	desc=$1
 	proto=$2
 	url=$3
@@ -183,7 +183,7 @@ test_config () {
 #   $2 - machine-readable name of the protocol
 #   $3 - the URL to try cloning
 test_proto () {
-	test_whitelist "$@"
+	test_allowlist "$@"
 
 	test_config "$@"
 }
diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index af8772fadaa..d6f9cd67588 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -16,7 +16,7 @@ test_expect_success 'create git-accessible repo' '
 
 test_proto "smart http" http "$HTTPD_URL/smart/repo.git"
 
-test_expect_success 'curl redirects respect whitelist' '
+test_expect_success 'curl redirects respect allowlist' '
 	test_must_fail env GIT_ALLOW_PROTOCOL=http:https \
 			   GIT_SMART_HTTP=0 \
 		git clone "$HTTPD_URL/ftp-redir/repo.git" 2>stderr &&
diff --git a/t/t5815-submodule-protos.sh b/t/t5815-submodule-protos.sh
index 06f55a1b8a0..eecc401831f 100755
--- a/t/t5815-submodule-protos.sh
+++ b/t/t5815-submodule-protos.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test protocol whitelisting with submodules'
+test_description='test protocol allowlisting with submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-proto-disable.sh
 
@@ -36,7 +36,7 @@ test_expect_success 'update of ext not allowed' '
 	test_must_fail git -C dst submodule update ext-module
 '
 
-test_expect_success 'user can override whitelist' '
+test_expect_success 'user can override allowlist' '
 	GIT_ALLOW_PROTOCOL=ext git -C dst submodule update ext-module
 '
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 210ddf09e30..03962d598f5 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -221,7 +221,7 @@ test_expect_success 'req_Root (export-all)' \
   'cat request-anonymous | git-cvsserver --export-all pserver "$WORKDIR" >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU\$"'
 
-test_expect_success 'req_Root failure (export-all w/o whitelist)' \
+test_expect_success 'req_Root failure (export-all w/o allowlist)' \
   '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
 
 test_expect_success 'req_Root (everything together)' \
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6da7273f1d5..5351bbd83b9 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -651,7 +651,7 @@ test_set_prereq () {
 		# test_unset_prereq()
 		!*)
 			;;
-		# (Temporary?) whitelist of things we can't easily
+		# (Temporary?) allowlist of things we can't easily
 		# pretend not to support
 		SYMLINKS)
 			;;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 55857af601b..6f5fccccb75 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1408,7 +1408,7 @@ then
 	test_done
 fi
 
-# skip non-whitelisted tests when compiled with SANITIZE=leak
+# skip non-allowlisted tests when compiled with SANITIZE=leak
 if test -n "$SANITIZE_LEAK"
 then
 	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
-- 
gitgitgadget

