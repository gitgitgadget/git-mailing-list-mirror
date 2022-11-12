Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85116C433FE
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 22:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiKLWHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 17:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiKLWHq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 17:07:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A8013CF7
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 14:07:45 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id t1so4920598wmi.4
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 14:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ROjAqMAGCrVyj956mV2OvOEQYC1qLnM5UWAA5HIl2Y=;
        b=HQVLIlx04YSrRbFG8WMrmhyhcoxLgacHsCP3QQkha/j9LpT75plZRuf+AMkHzkNWoD
         2X5mV8S4pWwHjQI8sxyQunIA/XRBXlUwEJfSdQlxvM/HuTpcm+Dq6f1rJ8KwsbVgVnl5
         1PuKXsZnL0ptzNYyRX/XMr8DWBJTrvvVFOB38HmNLdIx0kOxYjP5VQE/i0b3rln5HFch
         GZbeWcvIrE0FaB4WaND+t5XoEIVb921pv+8lB5FhkFifUs1koyjGuAoL1m7zTdaVwau8
         n8fklaikEmiER5dPmm+288ZcbVFYxdUkMbD74csleAoMNuIUXOlHHo6qmyI125NVytPs
         bGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ROjAqMAGCrVyj956mV2OvOEQYC1qLnM5UWAA5HIl2Y=;
        b=wjXw2bUJry7rKOJFJPcUqK+wZ05Q8CbX/utegWeYRsobUR68O08O9TvaXqezfwU0xW
         sozbc7A6DbkBuTVtBBRshi9WyMOX8ng9Wit8LoSFtBSXuPADf8AJXENl0pQtA9TsRwdA
         YovkijJ9l7sdpzC4zz/IggydruaJDHnUkpJ5LX9Dy9chX+f65GTPCHLiavsEYNmx/Jnr
         l5r9vW5JniageSRRnL8aHZS7vkp+R/3KLYhVgkfMUQHxhJu0ovZSkiA1F5wYZsppRxMv
         oJi9zjfR5q29WyQndSfbLvVjXjZRK6mxFDVScRIv3Uei2jfTICKlvIvzSeCyM58rNzup
         NWbQ==
X-Gm-Message-State: ANoB5pkptRs4uyfqIyl58BIO9aQINAlpESlyh22JNkJ4GcVae40EoyH+
        mrEfHEJRTdd3KYVTadZj15oBzkGmGGo=
X-Google-Smtp-Source: AA0mqf7zYdd4USIxQn4q35CMy8A7e36xDqeAzp832P5MUMx7ML6ndZe0OM9NkfwK9cZTYKARytPBBg==
X-Received: by 2002:a05:600c:2e48:b0:3cf:b091:e5a1 with SMTP id q8-20020a05600c2e4800b003cfb091e5a1mr4621775wmf.44.1668290863452;
        Sat, 12 Nov 2022 14:07:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c199100b003b4fdbb6319sm13618490wmq.21.2022.11.12.14.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 14:07:40 -0800 (PST)
Message-Id: <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Nov 2022 22:07:32 +0000
Subject: [PATCH v3 0/2] tests: replace mingw_test_cmp with a helper in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few months ago, directly after sending a patch to fix a performance
regression due to a mis-use of test_cmp
[https://lore.kernel.org/git/b9203ea247776332e4b6f519aa27d541207adc2f.1659097724.git.gitgitgadget@gmail.com/],
I got curious to see whether Git for Windows had the same issue. And it did
not: it passes t5351 in 22 seconds, even while using test_cmp to compare
pack files
[https://github.com/git-for-windows/git/blob/3922f62f0d5991e9fe0a0817ebf89a91339c7705/t/t5351-unpack-large-objects.sh#L90].

The explanation is of course that Git for Windows uses a test helper for
test_cmp that is written in C, instead of the Bash function. And C is much
faster than a Bash function, especially on Windows. This is especially sad
when said Bash code is only used on Windows. So I originally had pulled out
this helper from the years-long effort to let Git for Windows use BusyBox'
ash to run the test suite. The result is this patch, which has been in Git
for Windows since June 2018.

Unfortunately, this tried-and-tested code was rejected by the Git
maintainer.

Let's fall back to the next-best solution: git diff --no-index, which the
Git maintainer seems to like. The downside is that the diff machinery does a
lot more than a simple cmp clone, and therefore a lot more things can go
wrong that might make it look like a test case is failing when the fault is
somewhere else entirely. There is one way to find out whether this is a
valid concern.

Changes since v2:

 * Dropped the test helper, using diff --no-index instead.

Changes since v1:

 * Fixed double "with" in the commit message.
 * Renamed the test helper to text-cmp.
 * Made the diff --no-index call more robust by using a double-dash
   separator.

Johannes Schindelin (2):
  t0021: use Windows-friendly `pwd`
  tests(mingw): avoid very slow `mingw_test_cmp`

 t/t0021-conversion.sh   |  4 +--
 t/test-lib-functions.sh | 66 -----------------------------------------
 t/test-lib.sh           |  2 +-
 3 files changed, 3 insertions(+), 69 deletions(-)


base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1309%2Fdscho%2Fmingw-test-cmp-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1309/dscho/mingw-test-cmp-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1309

Range-diff vs v2:

 1:  ad7c41401ee ! 1:  b38b8fb5a85 t0021: use Windows-friendly `pwd`
     @@ Commit message
          absolute path, the MSYS2 runtime specifically exempts arguments
          containing a `=` character from that conversion.
      
     -    We are about to change `test_cmp` to use a test helper, which is such a
     -    Win32 process.
     +    We are about to change `test_cmp` to use `git diff --no-index`, which
     +    involves spawning precisely such a Win32 process.
      
          In combination, this would cause a failure in `t0021-conversion.sh`
          where we pass an absolute path containing an equal character to the
 2:  1f5366f1379 ! 2:  a7f4265ceb2 tests: replace mingw_test_cmp with a helper in C
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    tests: replace mingw_test_cmp with a helper in C
     +    tests(mingw): avoid very slow `mingw_test_cmp`
      
     -    This helper is more performant than running the `mingw_test_cmp` code
     -    with MSYS2's Bash. And a lot more readable.
     +    It is more performant to run `git diff --no-index` than running the
     +    `mingw_test_cmp` code with MSYS2's Bash, i.e. the Bash that Git for
     +    Windows uses. And a lot more readable.
      
     -    To accommodate t1050, which wants to compare files weighing in with 3MB
     -    (falling outside of t1050's malloc limit of 1.5MB), we simply lift the
     -    allocation limit by setting the environment variable GIT_ALLOC_LIMIT to
     -    zero when calling the helper.
     +    Note: Earlier attempts at fixing this involved a test helper that avoids
     +    the overhead of the diff machinery, in favor of implementing a behavior
     +    that is more in line with what `mingw_test_cmp` does now, but that
     +    attempt saw a lot of backlash and distractions during review and was
     +    therefore abandoned.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## Makefile ##
     -@@ Makefile: TEST_BUILTINS_OBJS += test-string-list.o
     - TEST_BUILTINS_OBJS += test-submodule-config.o
     - TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
     - TEST_BUILTINS_OBJS += test-subprocess.o
     -+TEST_BUILTINS_OBJS += test-text-cmp.o
     - TEST_BUILTINS_OBJS += test-trace2.o
     - TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
     - TEST_BUILTINS_OBJS += test-userdiff.o
     -
     - ## t/helper/test-text-cmp.c (new) ##
     -@@
     -+#include "test-tool.h"
     -+#include "git-compat-util.h"
     -+#include "strbuf.h"
     -+#include "gettext.h"
     -+#include "parse-options.h"
     -+#include "run-command.h"
     -+
     -+#ifdef WIN32
     -+#define NO_SUCH_DIR "\\\\.\\GLOBALROOT\\invalid"
     -+#else
     -+#define NO_SUCH_DIR "/dev/null"
     -+#endif
     -+
     -+static int run_diff(const char *path1, const char *path2)
     -+{
     -+	const char *argv[] = {
     -+		"diff", "--no-index", "--", NULL, NULL, NULL
     -+	};
     -+	const char *env[] = {
     -+		"GIT_PAGER=cat",
     -+		"GIT_DIR=" NO_SUCH_DIR,
     -+		"HOME=" NO_SUCH_DIR,
     -+		NULL
     -+	};
     -+
     -+	argv[3] = path1;
     -+	argv[4] = path2;
     -+	return run_command_v_opt_cd_env(argv,
     -+					RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
     -+					NULL, env);
     -+}
     -+
     -+int cmd__text_cmp(int argc, const char **argv)
     -+{
     -+	FILE *f0, *f1;
     -+	struct strbuf b0 = STRBUF_INIT, b1 = STRBUF_INIT;
     -+
     -+	if (argc != 3)
     -+		die("Require exactly 2 arguments, got %d", argc);
     -+
     -+	if (!strcmp(argv[1], "-") && !strcmp(argv[2], "-"))
     -+		die("only one parameter can refer to `stdin` but not both");
     -+
     -+	if (!(f0 = !strcmp(argv[1], "-") ? stdin : fopen(argv[1], "r")))
     -+		return error_errno("could not open '%s'", argv[1]);
     -+	if (!(f1 = !strcmp(argv[2], "-") ? stdin : fopen(argv[2], "r"))) {
     -+		fclose(f0);
     -+		return error_errno("could not open '%s'", argv[2]);
     -+	}
     -+
     -+	for (;;) {
     -+		int r0 = strbuf_getline(&b0, f0);
     -+		int r1 = strbuf_getline(&b1, f1);
     -+
     -+		if (r0 == EOF) {
     -+			fclose(f0);
     -+			fclose(f1);
     -+			strbuf_release(&b0);
     -+			strbuf_release(&b1);
     -+			if (r1 == EOF)
     -+				return 0;
     -+cmp_failed:
     -+			if (!strcmp(argv[1], "-") || !strcmp(argv[2], "-"))
     -+				warning("cannot show diff because `stdin` was already consumed");
     -+			else if (!run_diff(argv[1], argv[2]))
     -+				die("Huh? 'diff --no-index %s %s' succeeded",
     -+				    argv[1], argv[2]);
     -+			return 1;
     -+		}
     -+		if (r1 == EOF || strbuf_cmp(&b0, &b1)) {
     -+			fclose(f0);
     -+			fclose(f1);
     -+			strbuf_release(&b0);
     -+			strbuf_release(&b1);
     -+			goto cmp_failed;
     -+		}
     -+	}
     -+}
     -
     - ## t/helper/test-tool.c ##
     -@@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
     - 	{ "submodule-config", cmd__submodule_config },
     - 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
     - 	{ "subprocess", cmd__subprocess },
     -+	{ "text-cmp", cmd__text_cmp },
     - 	{ "trace2", cmd__trace2 },
     - 	{ "userdiff", cmd__userdiff },
     - 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
     -
     - ## t/helper/test-tool.h ##
     -@@ t/helper/test-tool.h: int cmd__string_list(int argc, const char **argv);
     - int cmd__submodule_config(int argc, const char **argv);
     - int cmd__submodule_nested_repo_config(int argc, const char **argv);
     - int cmd__subprocess(int argc, const char **argv);
     -+int cmd__text_cmp(int argc, const char **argv);
     - int cmd__trace2(int argc, const char **argv);
     - int cmd__userdiff(int argc, const char **argv);
     - int cmd__urlmatch_normalization(int argc, const char **argv);
     -
       ## t/test-lib-functions.sh ##
     -@@ t/test-lib-functions.sh: test_expect_code () {
     - 
     - test_cmp () {
     - 	test "$#" -ne 2 && BUG "2 param"
     --	eval "$GIT_TEST_CMP" '"$@"'
     -+	GIT_ALLOC_LIMIT=0 eval "$GIT_TEST_CMP" '"$@"'
     - }
     - 
     - # Check that the given config key has the expected value.
      @@ t/test-lib-functions.sh: test_skip_or_die () {
       	error "$2"
       }
     @@ t/test-lib.sh: case $uname_s in
       	test_set_prereq GREP_STRIPS_CR
       	test_set_prereq WINDOWS
      -	GIT_TEST_CMP=mingw_test_cmp
     -+	GIT_TEST_CMP="test-tool text-cmp"
     ++	GIT_TEST_CMP="GIT_DIR=/dev/null git diff --no-index --ignore-cr-at-eol --"
       	;;
       *CYGWIN*)
       	test_set_prereq POSIXPERM

-- 
gitgitgadget
