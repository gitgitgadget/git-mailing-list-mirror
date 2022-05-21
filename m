Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FCBC433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347497AbiEUWTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347118AbiEUWTI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB9A4F462
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f2so15949280wrc.0
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IcC8TjxkAxolQXyBFCqHk/x+zhXALadYy+cGgGUwAt4=;
        b=qtwofsR1WSXI6OcrMGPsQO/UWeoFPLrZfEMaDW530Kazjas06l5gw/A0ZBI30JulPK
         GX7o2xwQBG39dXrJZnzJ4RCbj0mkFkNtkty2BV7EgHIiTqF4ePbopuvOvErh9WW22+8p
         wvWtzVNmOq6lY8ZwQgoofhErahXQutKKVXdJRpTjr/5bC16pxCHqpYhvtSQateXUbG6f
         xKYxauE06OTE8Kz/DgFtG5A43Zef5I25mR9WMOBd3XS+Q4tR8nc1XikYC71Wqm+NSwo8
         RGYVUYw8CYb5ky2in68Du75xD/7Tb9RKCBZOYU1HVf2fXbqHT4ecrlPRSdPsPCNl7vhN
         60GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IcC8TjxkAxolQXyBFCqHk/x+zhXALadYy+cGgGUwAt4=;
        b=yyXprmWZ9N1u6ewro+aciw7y/pm9U+AmkiP1HGIP11ZO6+CRPiKTUjR6pzcSKVt6h3
         tB1+m2ZQejcIzQ8LdE2Iz6q41jq8tXz5I/MSOeEAYVsBQGufO+PbvaifIqW6LdG2oZga
         YbFHkwmYHBB29VXFrVCaA3NX6VLv2J4FUzZoqJmILQKLch+8JQnLa4boJMqzbJf804uM
         xQNKw3khB1HZ1DziBrbiDLsgxbm3EFSWZVTiZDh68UIrKXeWDCBHON5TjNXC3yRGZTkx
         hDMpU8xgijKLj9DcT8C1YvXHuL7DSeI2RixVO4TBjPrpx1fPU89tj6AgX5by82DskV8K
         IL2w==
X-Gm-Message-State: AOAM531mNsNSH8WplCehwvdHpISE+g4DMjDa2az/XzyK797Mx/evlIFZ
        YY69FsEYpKhbp/yPl/II88Ukm6RGi6A=
X-Google-Smtp-Source: ABdhPJwQtCC62Fp//uzyBdT82eCRh0FysO6GHItCZknB4V9fHeMAEg7U0iLbYLO8axZdvJZUFDoJYA==
X-Received: by 2002:a5d:598a:0:b0:20e:7211:9681 with SMTP id n10-20020a5d598a000000b0020e72119681mr10949729wri.572.1653171545633;
        Sat, 21 May 2022 15:19:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5-20020adfb345000000b0020d09f0b766sm6056937wrd.71.2022.05.21.15.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:19:05 -0700 (PDT)
Message-Id: <98059b94a881485f763efc54346e8b19103ee64b.1653171536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:51 +0000
Subject: [PATCH v3 07/12] ci: optionally mark up output in the GitHub workflow
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
index 93c03380d44..af4831a54c6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -795,7 +795,7 @@ test_verify_prereq () {
 }
 
 test_expect_failure () {
-	test_start_
+	test_start_ "$@"
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	BUG "not 2 or 3 parameters to test-expect-failure"
@@ -815,7 +815,7 @@ test_expect_failure () {
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
index bdb11e28eea..29640d107ca 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -204,6 +204,9 @@ parse_option () {
 	--write-junit-xml)
 		. "$TEST_DIRECTORY/test-lib-junit.sh"
 		;;
+	--github-workflow-markup)
+		. "$TEST_DIRECTORY/test-lib-github-workflow-markup.sh"
+		;;
 	--stress)
 		stress=t ;;
 	--stress=*)
@@ -1082,7 +1085,7 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
-	start_test_case_output
+	start_test_case_output "$@"
 }
 
 test_finish_ () {
-- 
gitgitgadget

