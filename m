Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC1DECAAD5
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 13:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiIFNLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 09:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiIFNLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 09:11:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1332B9D
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 06:11:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t14so8107278wrx.8
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=xPA0XII9wOIePE3Ia78NfyaiVC0AALJ9ng2C7DBKJyw=;
        b=CM6EK5veknFAhZE1nFGnppiVzcDqxNey038DnsXxzv6KPs1U4tD1oV7a8Mg3qAMIZQ
         814Dp2whSNaC2+FDvWzOGFQ1T7M7sp4DkAyJ5rGrW8C+6EKq5/0EdoNwwCXeZB7XpC1z
         64LCx11KwBFQrT930vPjt9JfNjLx4nCSVqMLQMAuYMAjfqPioCqkP3ELmXhQZB8XcqKj
         pw7NZdZs8I8cHyG8CxgQuZidvzB0V7xBik1K0FnEZNfIkhbt1FC6wmDMKW6pzZAxbMn6
         xoVjEC59CxGemRQu0f3iclHRQ9LAdCyqbBkjDi7hrzZL1Wy+Yb7BJc2H54qqBevhNo1O
         2a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xPA0XII9wOIePE3Ia78NfyaiVC0AALJ9ng2C7DBKJyw=;
        b=6TcgEEvec66D7l4EXKGWJViD0ccVcl49SSiKTxPKRbyVWpI0V8Qp7Ty3KpDOWtyrKD
         PobC7rggtbU2JfbZ65Sut6q0UnpArgID93tb3kqQlmriwyF5aMtpO04dQFyUwHFDNILO
         ZqEKoqMYLzRHraGw3GrSamTfulS5BjeDEBdrsLgl1HPyE/wDHRpEyjv5LAqKB0BPSnzJ
         GAdGgu3sQhzvgeyG0bNQmtFGq/8Rg+mNmUOwG7ieOT+8Jr8g/Nt0tSgwPEZ09fth3CDD
         jHE+UYlmx8G3/L+8hk9h/fiVc4FVv8131oGmxGeliA3/iaf1RsIxnRJsNDp72q6Xq2tk
         xAiA==
X-Gm-Message-State: ACgBeo1vYvgp9zTErTw1RNkiqg/7bS6X1GkBsRRj4zEw+jdqymSl3BlI
        sJq7S9P8NQ4iyjvcnEVlhB5MWysAwAQ=
X-Google-Smtp-Source: AA6agR7Aj8pEMRGUDey6BJaQhn+UOuox9vkqOKlov2w4i0nsaeNmR3OSkU1QEV689zHtSNCRyCwD0Q==
X-Received: by 2002:a5d:64aa:0:b0:226:de65:810c with SMTP id m10-20020a5d64aa000000b00226de65810cmr23372414wrp.536.1662469861470;
        Tue, 06 Sep 2022 06:11:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c3acd00b003a643ac2b08sm13997637wms.8.2022.09.06.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:11:01 -0700 (PDT)
Message-Id: <1f5366f137967cbec30041b40eedd86ce5f6e953.1662469859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
        <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Sep 2022 13:10:58 +0000
Subject: [PATCH v2 2/2] tests: replace mingw_test_cmp with a helper in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This helper is more performant than running the `mingw_test_cmp` code
with MSYS2's Bash. And a lot more readable.

To accommodate t1050, which wants to compare files weighing in with 3MB
(falling outside of t1050's malloc limit of 1.5MB), we simply lift the
allocation limit by setting the environment variable GIT_ALLOC_LIMIT to
zero when calling the helper.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                 |  1 +
 t/helper/test-text-cmp.c | 78 ++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 t/test-lib-functions.sh  | 68 +----------------------------------
 t/test-lib.sh            |  2 +-
 6 files changed, 83 insertions(+), 68 deletions(-)
 create mode 100644 t/helper/test-text-cmp.c

diff --git a/Makefile b/Makefile
index 1624471badc..73db55bba0f 100644
--- a/Makefile
+++ b/Makefile
@@ -786,6 +786,7 @@ TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
+TEST_BUILTINS_OBJS += test-text-cmp.o
 TEST_BUILTINS_OBJS += test-trace2.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-userdiff.o
diff --git a/t/helper/test-text-cmp.c b/t/helper/test-text-cmp.c
new file mode 100644
index 00000000000..7c26d925086
--- /dev/null
+++ b/t/helper/test-text-cmp.c
@@ -0,0 +1,78 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "gettext.h"
+#include "parse-options.h"
+#include "run-command.h"
+
+#ifdef WIN32
+#define NO_SUCH_DIR "\\\\.\\GLOBALROOT\\invalid"
+#else
+#define NO_SUCH_DIR "/dev/null"
+#endif
+
+static int run_diff(const char *path1, const char *path2)
+{
+	const char *argv[] = {
+		"diff", "--no-index", "--", NULL, NULL, NULL
+	};
+	const char *env[] = {
+		"GIT_PAGER=cat",
+		"GIT_DIR=" NO_SUCH_DIR,
+		"HOME=" NO_SUCH_DIR,
+		NULL
+	};
+
+	argv[3] = path1;
+	argv[4] = path2;
+	return run_command_v_opt_cd_env(argv,
+					RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
+					NULL, env);
+}
+
+int cmd__text_cmp(int argc, const char **argv)
+{
+	FILE *f0, *f1;
+	struct strbuf b0 = STRBUF_INIT, b1 = STRBUF_INIT;
+
+	if (argc != 3)
+		die("Require exactly 2 arguments, got %d", argc);
+
+	if (!strcmp(argv[1], "-") && !strcmp(argv[2], "-"))
+		die("only one parameter can refer to `stdin` but not both");
+
+	if (!(f0 = !strcmp(argv[1], "-") ? stdin : fopen(argv[1], "r")))
+		return error_errno("could not open '%s'", argv[1]);
+	if (!(f1 = !strcmp(argv[2], "-") ? stdin : fopen(argv[2], "r"))) {
+		fclose(f0);
+		return error_errno("could not open '%s'", argv[2]);
+	}
+
+	for (;;) {
+		int r0 = strbuf_getline(&b0, f0);
+		int r1 = strbuf_getline(&b1, f1);
+
+		if (r0 == EOF) {
+			fclose(f0);
+			fclose(f1);
+			strbuf_release(&b0);
+			strbuf_release(&b1);
+			if (r1 == EOF)
+				return 0;
+cmp_failed:
+			if (!strcmp(argv[1], "-") || !strcmp(argv[2], "-"))
+				warning("cannot show diff because `stdin` was already consumed");
+			else if (!run_diff(argv[1], argv[2]))
+				die("Huh? 'diff --no-index %s %s' succeeded",
+				    argv[1], argv[2]);
+			return 1;
+		}
+		if (r1 == EOF || strbuf_cmp(&b0, &b1)) {
+			fclose(f0);
+			fclose(f1);
+			strbuf_release(&b0);
+			strbuf_release(&b1);
+			goto cmp_failed;
+		}
+	}
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 318fdbab0c3..c6654ebc48b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -81,6 +81,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-config", cmd__submodule_config },
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
+	{ "text-cmp", cmd__text_cmp },
 	{ "trace2", cmd__trace2 },
 	{ "userdiff", cmd__userdiff },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index bb799271631..2acfd2bcabc 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -71,6 +71,7 @@ int cmd__string_list(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
+int cmd__text_cmp(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
 int cmd__userdiff(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8c44856eaec..28eddbc8e36 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1240,7 +1240,7 @@ test_expect_code () {
 
 test_cmp () {
 	test "$#" -ne 2 && BUG "2 param"
-	eval "$GIT_TEST_CMP" '"$@"'
+	GIT_ALLOC_LIMIT=0 eval "$GIT_TEST_CMP" '"$@"'
 }
 
 # Check that the given config key has the expected value.
@@ -1541,72 +1541,6 @@ test_skip_or_die () {
 	error "$2"
 }
 
-# The following mingw_* functions obey POSIX shell syntax, but are actually
-# bash scripts, and are meant to be used only with bash on Windows.
-
-# A test_cmp function that treats LF and CRLF equal and avoids to fork
-# diff when possible.
-mingw_test_cmp () {
-	# Read text into shell variables and compare them. If the results
-	# are different, use regular diff to report the difference.
-	local test_cmp_a= test_cmp_b=
-
-	# When text came from stdin (one argument is '-') we must feed it
-	# to diff.
-	local stdin_for_diff=
-
-	# Since it is difficult to detect the difference between an
-	# empty input file and a failure to read the files, we go straight
-	# to diff if one of the inputs is empty.
-	if test -s "$1" && test -s "$2"
-	then
-		# regular case: both files non-empty
-		mingw_read_file_strip_cr_ test_cmp_a <"$1"
-		mingw_read_file_strip_cr_ test_cmp_b <"$2"
-	elif test -s "$1" && test "$2" = -
-	then
-		# read 2nd file from stdin
-		mingw_read_file_strip_cr_ test_cmp_a <"$1"
-		mingw_read_file_strip_cr_ test_cmp_b
-		stdin_for_diff='<<<"$test_cmp_b"'
-	elif test "$1" = - && test -s "$2"
-	then
-		# read 1st file from stdin
-		mingw_read_file_strip_cr_ test_cmp_a
-		mingw_read_file_strip_cr_ test_cmp_b <"$2"
-		stdin_for_diff='<<<"$test_cmp_a"'
-	fi
-	test -n "$test_cmp_a" &&
-	test -n "$test_cmp_b" &&
-	test "$test_cmp_a" = "$test_cmp_b" ||
-	eval "diff -u \"\$@\" $stdin_for_diff"
-}
-
-# $1 is the name of the shell variable to fill in
-mingw_read_file_strip_cr_ () {
-	# Read line-wise using LF as the line separator
-	# and use IFS to strip CR.
-	local line
-	while :
-	do
-		if IFS=$'\r' read -r -d $'\n' line
-		then
-			# good
-			line=$line$'\n'
-		else
-			# we get here at EOF, but also if the last line
-			# was not terminated by LF; in the latter case,
-			# some text was read
-			if test -z "$line"
-			then
-				# EOF, really
-				break
-			fi
-		fi
-		eval "$1=\$$1\$line"
-	done
-}
-
 # Like "env FOO=BAR some-program", but run inside a subshell, which means
 # it also works for shell functions (though those functions cannot impact
 # the environment outside of the test_env invocation).
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7726d1da88a..0be25ecbd59 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1546,7 +1546,7 @@ case $uname_s in
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
 	test_set_prereq WINDOWS
-	GIT_TEST_CMP=mingw_test_cmp
+	GIT_TEST_CMP="test-tool text-cmp"
 	;;
 *CYGWIN*)
 	test_set_prereq POSIXPERM
-- 
gitgitgadget
