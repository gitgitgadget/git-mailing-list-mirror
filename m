Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1EFC433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347194AbiEUWTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347080AbiEUWTG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7214EF60
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s28so15780943wrb.7
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ganxqkS9kK8VPMrpMbSNTO8ET3r2m3OId4BMtNcMrsg=;
        b=YmhQYkfkVFq5YIbWw3S8n8kkavBojkXZUQ1jdGtwQVfo/ILrKg8MM3XyToL0gz7zdb
         rDA+o+0i31v3Uz9GN0EiCox6np+tPbdIo9fLoVXkiHxwGKot5t/TuzeQvZ29t4MYvw0M
         TW+uBwtAFdU83bXrRO2SVgTIWABjDerptr/XKjNxCXl8IycD0Rfb2fRgT/PE4tdojTdR
         bnlMDmYt6jUhtFKMDP/t0pzSfpseu/inqxgeQtMYyucx/x1+pXLDvLOHrY8QLbRWzEbg
         yqw442de1eBUXqD4pheufnGb7izF9Gu9j87Xi4fPM1AvtAi0vygyacLKF+Xud4VoeGqd
         amrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ganxqkS9kK8VPMrpMbSNTO8ET3r2m3OId4BMtNcMrsg=;
        b=mnCdqRo8zaYe0nC8CKpNU40OgFGljm4oXnKtpNC/WutVp35sMI78Y42Ra8++Fb9LzK
         YB6COVMCdJPcy82wlqbKLMsG4dg7OqrepFfRzj/xvdMvplXf9Icib5jFp8ZNmlrzUfpB
         8U07p0dzt/ItMr7GFcAo5RknriUM14sLC3fCnaIQLY2Mewwn/MHioGzvCOUPpW6swYVb
         Qpg2BDxHfiG/s67zQKCMfpPGzhkx28CpBgJbp6G7MTadcqBNnhrt+URxNXR8qqOmApQu
         MD78GJ8iAuOYmZT/hpNAQI+NxMfJNrCQ6P20gFN+8pSsYmlqzYggwq0CHf/WRS0erUWs
         EZmg==
X-Gm-Message-State: AOAM530g1pukY0DeG4i+CoOkyuPtR7Myc8rsu5cZtxnhXxHPFjmh7NLA
        Aj2ulJYdWOqW49F0yNL1pwYDoINJxxM=
X-Google-Smtp-Source: ABdhPJxXtz4cUakv5VWLIJ34Pqc4UM69e1QQOLDyS8vKTrGIW8csogcwpxxmkXcuk9IlY7CHgRrCrA==
X-Received: by 2002:adf:f90f:0:b0:20e:5fd4:5d06 with SMTP id b15-20020adff90f000000b0020e5fd45d06mr13826147wrr.371.1653171543350;
        Sat, 21 May 2022 15:19:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6-20020adfc646000000b0020d0c48d135sm6243854wrg.15.2022.05.21.15.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:19:02 -0700 (PDT)
Message-Id: <417f702a2454316f0bdc5b66eb16751272ff2989.1653171536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:49 +0000
Subject: [PATCH v3 05/12] ci: make it easier to find failed tests' logs in the
 GitHub workflow
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

When investigating a test failure, the time that matters most is the
time it takes from getting aware of the failure to displaying the output
of the failing test case.

You currently have to know a lot of implementation details when
investigating test failures in the CI runs. The first step is easy: the
failed job is marked quite clearly, but when opening it, the failed step
is expanded, which in our case is the one running
`ci/run-build-and-tests.sh`. This step, most notably, only offers a
high-level view of what went wrong: it prints the output of `prove`
which merely tells the reader which test script failed.

The actually interesting part is in the detailed log of said failed
test script. But that log is shown in the CI run's step that runs
`ci/print-test-failures.sh`. And that step is _not_ expanded in the web
UI by default. It is even marked as "successful", which makes it very
easy to miss that there is useful information hidden in there.

Let's help the reader by showing the failed tests' detailed logs in the
step that is expanded automatically, i.e. directly after the test suite
failed.

This also helps the situation where the _build_ failed and the
`print-test-failures` step was executed under the assumption that the
_test suite_ failed, and consequently failed to find any failed tests.

An alternative way to implement this patch would be to source
`ci/print-test-failures.sh` in the `handle_test_failures` function to
show these logs. However, over the course of the next few commits, we
want to introduce some grouping which would be harder to achieve that
way (for example, we do want a leaner, and colored, preamble for each
failed test script, and it would be trickier to accommodate the lack of
nested groupings in GitHub workflows' output).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 12 ------------
 ci/lib.sh                  | 23 +++++++++++++++++++++++
 ci/run-build-and-tests.sh  |  3 ++-
 ci/run-test-slice.sh       |  3 ++-
 4 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c35200defb9..3fa88b78b6d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -119,10 +119,6 @@ jobs:
     - name: test
       shell: bash
       run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
-    - name: ci/print-test-failures.sh
-      if: failure()
-      shell: bash
-      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -204,10 +200,6 @@ jobs:
       env:
         NO_SVN_TESTS: 1
       run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
-    - name: ci/print-test-failures.sh
-      if: failure()
-      shell: bash
-      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -261,8 +253,6 @@ jobs:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
-    - run: ci/print-test-failures.sh
-      if: failure()
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -292,8 +282,6 @@ jobs:
     - uses: actions/checkout@v1
     - run: ci/install-docker-dependencies.sh
     - run: ci/run-build-and-tests.sh
-    - run: ci/print-test-failures.sh
-      if: failure()
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v1
diff --git a/ci/lib.sh b/ci/lib.sh
index d718f4e386d..65f5188a550 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -78,6 +78,10 @@ check_unignored_build_artifacts () {
 	}
 }
 
+handle_failed_tests () {
+	return 1
+}
+
 # GitHub Action doesn't set TERM, which is required by tput
 export TERM=${TERM:-dumb}
 
@@ -123,6 +127,25 @@ then
 	CI_JOB_ID="$GITHUB_RUN_ID"
 	CC="${CC_PACKAGE:-${CC:-gcc}}"
 	DONT_SKIP_TAGS=t
+	handle_failed_tests () {
+		mkdir -p t/failed-test-artifacts
+		echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
+
+		for test_exit in t/test-results/*.exit
+		do
+			test 0 != "$(cat "$test_exit")" || continue
+
+			test_name="${test_exit%.exit}"
+			test_name="${test_name##*/}"
+			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
+			cat "t/test-results/$test_name.out"
+
+			trash_dir="t/trash directory.$test_name"
+			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
+			tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
+		done
+		return 1
+	}
 
 	cache_dir="$HOME/none"
 
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2818b3046ae..1ede75e5556 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -48,7 +48,8 @@ esac
 make
 if test -n "$run_tests"
 then
-	make test
+	make test ||
+	handle_failed_tests
 fi
 check_unignored_build_artifacts
 
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index f8c2c3106a2..63358c23e11 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -12,6 +12,7 @@ esac
 
 make --quiet -C t T="$(cd t &&
 	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
-	tr '\n' ' ')"
+	tr '\n' ' ')" ||
+handle_failed_tests
 
 check_unignored_build_artifacts
-- 
gitgitgadget

