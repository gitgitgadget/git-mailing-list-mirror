Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 597961F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbfFMPUb (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:20:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32851 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732105AbfFMMxy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 08:53:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so3099404edq.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WKBAyx9ooKtEby5Ubwc5Bo0LpmufvxpxDF3P5rxfzbM=;
        b=N4dt35VqoSTeryW9jKn4meentpjOJBpMT8jMww9dcV0jiMsqxpTAPAFsFKBBm77IwX
         QVKExl7PZIJzlhInwZVqzPRHESe7Gs6qHHJyRGt8bVzwd1/IPpo3EQrwgOiuk7GXDfLY
         hP/UX7Fd7o7dI3rMaBgRvOhpaPxDkp1sXjiAG4/UHheTlA9Z+X3Y9OFWBzYMCjbETlSV
         lv9ibm7RiuI7so90XPuMW2PtoXIbSWPsn1Zh+yW0nwY1xZlowcZBdf222JRYgdNLU7Ex
         EOkOg7UciUJOxQmkci0fmSomPI/6MtxCjx4WnNyG14x7T8wdsvWXFX/mzw6/gRLo9Peq
         HyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WKBAyx9ooKtEby5Ubwc5Bo0LpmufvxpxDF3P5rxfzbM=;
        b=XCwgkUUmSC03fFhS1b1ukgwOYf1NKDvchQ6vM6MWopi02aUWuq3PanjRBLqBxnYXdT
         thnrwAjDy6niJ8d9VXMrSFYL3A3iVULx7RdJM2cz4/3HM012Xz8elqGsV2tOelnsBd3h
         h9rvd5HThs9ZoBzxzN++Jq4Vk410L13KIgYwOjEFQ0LnBiKcvWDmfnkon7sXc04z03Lt
         tk8IqE9g4d9TQmJqcqILMNYJ7ZIklfVI5batcAa5l7E0uDbHnimJLrLa3qlV/Ecr0iAX
         0EosUREO+aX/j6GhxYyFe95lTSrcNC2auf4UM2gIl10dVEAQevozQ16sBr7vsRyTg67S
         UWDw==
X-Gm-Message-State: APjAAAWtYdVX3vy5+71C35dH9pa1YDdsqMWes4y9TGfxAJSBPb9C+BbA
        UC3w78xGRaBKlZHoTwCAb+s1clkf
X-Google-Smtp-Source: APXvYqzrln6oFcj40mEbESHV6zLGhdWakIPMEa+Xl/gKTpCFm4Z4JukvpEF3ocyROJ64GuepfPuXCQ==
X-Received: by 2002:a50:a5ec:: with SMTP id b41mr66220308edc.52.1560430432137;
        Thu, 13 Jun 2019 05:53:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l45sm881146edc.93.2019.06.13.05.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 05:53:51 -0700 (PDT)
Date:   Thu, 13 Jun 2019 05:53:51 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Jun 2019 12:53:50 GMT
Message-Id: <ac102169ec6f47b8be1fe69b4798de385f102af8.1560430430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.266.git.gitgitgadget@gmail.com>
References: <pull.266.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] ci: split the `linux-gcc` job into two jobs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This job was abused to not only run the test suite in a regular way but
also with all kinds of `GIT_TEST_*` options set to non-default values.

Let's split this into two, with the `linux-gcc` job running the default
test suite, and the newly-introduced `linux-gcc-extra` job running the
test suite in the "special" ways.

Technically, we would have to build Git only once, but it would not be
obvious how to teach Travis to transport build artifacts, so we keep it
simple and just build Git in both jobs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .travis.yml                |  4 ++++
 azure-pipelines.yml        | 39 ++++++++++++++++++++++++++++++++++++++
 ci/install-dependencies.sh |  4 ++--
 ci/lib.sh                  |  4 ++--
 ci/run-build-and-tests.sh  |  5 ++---
 5 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index ffb1bc46f2..a6444ee3ab 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -16,6 +16,10 @@ compiler:
 
 matrix:
   include:
+    - env: jobname=linux-gcc-extra
+      os: linux
+      compiler: gcc
+      addons:
     - env: jobname=GIT_TEST_GETTEXT_POISON
       os: linux
       compiler:
diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index c329b7218b..4080aa3c45 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -206,6 +206,45 @@ jobs:
       PathtoPublish: t/failed-test-artifacts
       ArtifactName: failed-test-artifacts
 
+- job: linux_gcc_extra
+  displayName: linux-gcc-extra
+  condition: succeeded()
+  pool: Hosted Ubuntu 1604
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       sudo add-apt-repository ppa:ubuntu-toolchain-r/test &&
+       sudo apt-get update &&
+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2 language-pack-is git-svn gcc-8 || exit 1
+
+       export jobname=linux-gcc-extra &&
+
+       ci/install-dependencies.sh || exit 1
+       ci/run-build-and-tests.sh || {
+           ci/print-test-failures.sh
+           exit 1
+       }
+
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
+    displayName: 'ci/run-build-and-tests.sh'
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+  - task: PublishTestResults@2
+    displayName: 'Publish Test Results **/TEST-*.xml'
+    inputs:
+      mergeTestResults: true
+      testRunTitle: 'linux-gcc-extra'
+      platform: Linux
+      publishRunAttachments: false
+    condition: succeededOrFailed()
+  - task: PublishBuildArtifacts@1
+    displayName: 'Publish trash directories of failed tests'
+    condition: failed()
+    inputs:
+      PathtoPublish: t/failed-test-artifacts
+      ArtifactName: failed-test-artifacts
+
 - job: osx_clang
   displayName: osx-clang
   condition: succeeded()
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 7f6acdd803..c25bdcdf66 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -9,12 +9,12 @@ P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 
 case "$jobname" in
-linux-clang|linux-gcc)
+linux-clang|linux-gcc|linux-gcc-extra)
 	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2
 	case "$jobname" in
-	linux-gcc)
+	linux-gcc|linux-gcc-extra)
 		sudo apt-get -q -y install gcc-8
 		;;
 	esac
diff --git a/ci/lib.sh b/ci/lib.sh
index 288a5b3884..b16a1454f1 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -154,8 +154,8 @@ export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=YesPlease
 
 case "$jobname" in
-linux-clang|linux-gcc)
-	if [ "$jobname" = linux-gcc ]
+linux-clang|linux-gcc|linux-gcc-extra)
+	if [ "$jobname" = linux-gcc -o "$jobname" = linux-gcc-extra ]
 	then
 		export CC=gcc-8
 	fi
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cdd2913440..b252ff859d 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -11,8 +11,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 esac
 
 make
-make test
-if test "$jobname" = "linux-gcc"
+if test "$jobname" = "linux-gcc-extra"
 then
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
@@ -20,8 +19,8 @@ then
 	export GIT_TEST_OE_DELTA_SIZE=5
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
-	make test
 fi
+make test
 
 check_unignored_build_artifacts
 
-- 
gitgitgadget
