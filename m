Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065B1C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCAE963212
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbhKQOXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbhKQOW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 09:22:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B1FC06120F
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u1so4984896wru.13
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YGW/Iv+hj4Jo4PNf8rajEZsMbDt9HNnlI+ygkUeyL4U=;
        b=hr1csCwjQngNhgvXeHZpBPuZ8JXrB67HJ4Fkahqg+ZOTeAKRPH0CYhE55LVYx5FlqD
         gM+kzoM3mIcrOfe5ZFQAwcZvo8goFsreWyBeLhX0j8ypXndwffOFlxgHzK27u/+TBuTa
         M8XL6VctRbvrnPNITOArgEK3qaE3NbZe8WvB9dhBBtSD95OJj1+8DvDvzpRWrRVtXOp7
         AjL/1I5q/xoFAD9x32A4LHLqjdMEAG98Sad0OodfboiJLe7g1O115sS3yfXgPXzkgoZA
         R3P7lWjUZUKaQ7I85r+iEX8ACqV2p4rUjLcWg17qk/WvwbZziFAK1CAp/NQR440m+mVg
         mnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YGW/Iv+hj4Jo4PNf8rajEZsMbDt9HNnlI+ygkUeyL4U=;
        b=bkqTuxMVrTwfwB0MSOFvZ2H9amgGDmZQzvVwpWo+XZd/mLuQPfcvUmS28hJh2SXzYX
         loiCf1n2qWwYVxTD6bVUG3FWyjE+KcQHkT9cMFCUXojtSNf2/0z+N0ET7oS7Y3XR9vSE
         hz2tXwnaKr40tywLDyJv4Zx2pX+f6UkePUJl8G0FnaS2wPaL40FFhru8u31AcRYSGo/y
         MnVP8b0qhLUkHXfW3PBwE+n6gnO5qlAn3oIobszzoAxYQnN5cPeoYMq7gCAUB/Lqq879
         s/GKg+hNqZKhhYGBX0SJbEXRc34DtdbqycNXZ9WrbLeHNeI4t7rRkKFjAl2zVQN9M+s7
         M1hw==
X-Gm-Message-State: AOAM533kcKLiFQVQ3KlVFROwOlDG/t91hFjoJLb46NTZGS79BqZKysc7
        J7qClwcRtJTUrlN3OcudpnNTmKhJnro=
X-Google-Smtp-Source: ABdhPJwSx+hShqtsTku4xtPhbZgjn7pZpZ7vrca10L/nNK3ZPYwrLFcWYuiJ9dqqsvOKWDhkKc+Qdw==
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr19859513wrx.86.1637158774467;
        Wed, 17 Nov 2021 06:19:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o63sm5941046wme.2.2021.11.17.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:19:34 -0800 (PST)
Message-Id: <1b0328fa236a35c2427b82f53c32944e513580d3.1637158762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
        <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 14:19:11 +0000
Subject: [PATCH v7 06/17] ci: also run the `scalar` tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since Scalar depends on `libgit.a`, it makes sense to ensure in the CI
and the PR builds that it does not get broken in case of industrious
refactorings of the core Git code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 15 +++++++++++++++
 ci/run-build-and-tests.sh  |  1 +
 ci/run-test-slice.sh       |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6ed6a9e8076..6eda6be895d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -89,6 +89,13 @@ jobs:
         HOME: ${{runner.workspace}}
         NO_PERL: 1
       run: . /etc/profile && ci/make-test-artifacts.sh artifacts
+    - name: build Scalar
+      shell: bash
+      run: |
+        make -C contrib/scalar &&
+        mkdir -p artifacts/bin-wrappers artifacts/contrib/scalar &&
+        cp contrib/scalar/scalar.exe artifacts/contrib/scalar/ &&
+        cp bin-wrappers/scalar artifacts/bin-wrappers/
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
@@ -157,6 +164,8 @@ jobs:
       run: compat\vcbuild\vcpkg_copy_dlls.bat release
     - name: generate Visual Studio solution
       shell: bash
+      env:
+        INCLUDE_SCALAR: YesPlease
       run: |
         cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
         -DNO_GETTEXT=YesPlease -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
@@ -170,6 +179,12 @@ jobs:
       run: |
         mkdir -p artifacts &&
         eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts NO_GETTEXT=YesPlease 2>&1 | grep ^tar)"
+    - name: copy Scalar
+      shell: bash
+      run: |
+        mkdir -p artifacts/bin-wrappers artifacts/contrib/scalar &&
+        cp contrib/scalar/scalar.exe artifacts/contrib/scalar/ &&
+        cp bin-wrappers/scalar artifacts/bin-wrappers/
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cc62616d806..07cedd25ff1 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -49,6 +49,7 @@ linux-gcc-4.8|pedantic)
 	make test
 	;;
 esac
+make -C contrib/scalar test
 
 check_unignored_build_artifacts
 
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index f8c2c3106a2..b741fd8f361 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -14,4 +14,9 @@ make --quiet -C t T="$(cd t &&
 	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
 	tr '\n' ' ')"
 
+if test 0 = "$1"
+then
+	make -C contrib/scalar test
+fi
+
 check_unignored_build_artifacts
-- 
gitgitgadget

