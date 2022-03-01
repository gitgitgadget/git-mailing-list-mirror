Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09974C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiCAKZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiCAKZj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:25:39 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2898EB4D
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:24:57 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n14so19673614wrq.7
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 02:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0cTVlvy3koO8kIFX46QMstD+ERk03HMw6aT8GNBxMTM=;
        b=Um4TPbXWSzH3YXre4rKc6ly2/HI4nHUe0J9GgeYudGyZI3awy8HZL/TCS87y3qjgPf
         jDImtZVQArsFNXFCqRq7Q/Ej6dQ8rsgrOEBDiSBj5fJQitnDnZ6MF8DGDcs22hy8ybNz
         p23D4Z0GmO5owBB8ipaZCOjxMVGQ59a5JGGlhH2L6dk37scfX1ZQz3RbEIbrKxt3EhEM
         1AP6T43lB+mfLrggKbiA3JD70YaqqaY0HTvdFUyHbELHdJjRPpx6fOSG5lJlTGVw+/hx
         9VoIDzxBOE7vfdlr52OzmuD/PZ0VuLyb/sD2qGtPKp3m6nvm36dkiX2eZpAG7Gcon0VE
         HvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0cTVlvy3koO8kIFX46QMstD+ERk03HMw6aT8GNBxMTM=;
        b=AHfpdZc/cPZX8n8thldt06u5SC0ergaeY/u6MFLu+NIP6qcwcoWepDlnqVX5Jz/qZq
         9rZn/VrrSi0FUqoJM+pBEnavWRcK4ySp3Sne/OIPVJaCZNPNwvWnvCq4szZHhJOh4f57
         isAgZOjpS9kf5zfGg3UsYAt69bHoYuXyddYCjc1PYPtDcuM0B1QOib1OedHh8cl+iza0
         gyxe+FzKVYYwBBNG68Rt7/yZ66nq91kww77D7td9ojQliCHtMSC2qmOw78hlY0xbx1pK
         XpToM3EoEHE4QNGLhjGRFLBRY6eq+bQihU+DBRFlWoe0Ov7XISlWDQqZY18eAJzdTK4S
         Ctvw==
X-Gm-Message-State: AOAM533Abc78qUtqeVFOA7yVPvnJZ/bpEnhbfYU15BBnXKv0r+ocSDo0
        /IIc4m28mIRAQLzNWheoVDSgVISQl38=
X-Google-Smtp-Source: ABdhPJwzLw10xEc8uruzPwhrIZ8efYeos9wSXF3v7igwCGs6zy5Jc2NNJt+HCx99WFwSrXtF0/16cA==
X-Received: by 2002:a5d:588a:0:b0:1e8:b478:e74f with SMTP id n10-20020a5d588a000000b001e8b478e74fmr19349870wrf.210.1646130295765;
        Tue, 01 Mar 2022 02:24:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c241100b0037c01ad7152sm2915196wmp.14.2022.03.01.02.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:24:55 -0800 (PST)
Message-Id: <15f199e810e08701b0c3bb84f1e9737672c100d9.1646130289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 10:24:47 +0000
Subject: [PATCH v2 7/9] ci: optionally mark up output in the GitHub workflow
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

A couple of commands exist to spruce up the output in GitHub workflows:
https://docs.github.com/en/actions/learn-github-actions/workflow-commands-for-github-actions

In addition to the `::group::<label>`/`::endgroup::` commands (which we
already use to structure the output of the build step better), we also
use `::error::`/`::notice::` to draw the attention to test failures and
to test cases that were expected to fail but didn't.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-functions.sh              |  4 +--
 t/test-lib-github-workflow-markup.sh | 50 ++++++++++++++++++++++++++++
 t/test-lib.sh                        |  5 ++-
 3 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100644 t/test-lib-github-workflow-markup.sh

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c3d38aaccbd..b5fe5f66085 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -719,7 +719,7 @@ test_verify_prereq () {
 }
 
 test_expect_failure () {
-	test_start_
+	test_start_ "$@"
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	BUG "not 2 or 3 parameters to test-expect-failure"
@@ -739,7 +739,7 @@ test_expect_failure () {
 }
 
 test_expect_success () {
-	test_start_
+	test_start_ "$@"
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	BUG "not 2 or 3 parameters to test-expect-success"
diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
new file mode 100644
index 00000000000..d8dc969df4a
--- /dev/null
+++ b/t/test-lib-github-workflow-markup.sh
@@ -0,0 +1,50 @@
+# Library of functions to mark up test scripts' output suitable for
+# pretty-printing it in GitHub workflows.
+#
+# Copyright (c) 2022 Johannes Schindelin
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see http://www.gnu.org/licenses/ .
+#
+# The idea is for `test-lib.sh` to source this file when run in GitHub
+# workflows; these functions will then override (empty) functions
+# that are are called at the appropriate times during the test runs.
+
+start_test_output () {
+	test -n "$GIT_TEST_TEE_OUTPUT_FILE" ||
+	die "--github-workflow-markup requires --verbose-log"
+	github_markup_output="${GIT_TEST_TEE_OUTPUT_FILE%.out}.markup"
+	>$github_markup_output
+	GIT_TEST_TEE_OFFSET=0
+}
+
+# No need to override start_test_case_output
+
+finalize_test_case_output () {
+	test_case_result=$1
+	shift
+	case "$test_case_result" in
+	failure)
+		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
+		;;
+	fixed)
+		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
+		;;
+	esac
+	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
+	test-tool >>$github_markup_output path-utils skip-n-bytes \
+		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
+	echo >>$github_markup_output "::endgroup::"
+}
+
+# No need to override finalize_test_output
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e13e1cb9124..076bee58c19 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -174,6 +174,9 @@ parse_option () {
 	--write-junit-xml)
 		. "$TEST_DIRECTORY/test-lib-junit.sh"
 		;;
+	--github-workflow-markup)
+		. "$TEST_DIRECTORY/test-lib-github-workflow-markup.sh"
+		;;
 	--stress)
 		stress=t ;;
 	--stress=*)
@@ -1027,7 +1030,7 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
-	start_test_case_output
+	start_test_case_output "$@"
 }
 
 test_finish_ () {
-- 
gitgitgadget

