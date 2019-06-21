Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06DFA1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 10:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFUKSa (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 06:18:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44131 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFUKS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 06:18:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16so5982957wrl.11
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qcsQUaXDjsnX1TGtyFB06xg2DLy7AN2cnzGtGe5cMLE=;
        b=iTWxldm0PwItMsADtvRiyC8QtcfV0jpS2xzuKUOj9lxQcDofJcNMiVd2o7GPufl5/m
         Ze30VwFEfp27qLZGOj1YDErgdst2CURPlTDa7rTwInh96X/CoXA+cIgHF6F/blCbIhO6
         beJfcMCf5Vu1Rg9xVCQ2a5Y8n8kxa4TCm/NkkRbVeawygw9MrWnehXGpSCzTHq3+BSZf
         whgv2891XjCrLw6YLBHW2xaDDwAXjaBx/QWShg9i7lIba2r2gbuiPjRs+tee5y/yuJaX
         M93zluSShNvTrxyrWsYtkCtI0j/famert76oRgs0HXWi0g+U+IhpoUt/CQclLS70Qso/
         edug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcsQUaXDjsnX1TGtyFB06xg2DLy7AN2cnzGtGe5cMLE=;
        b=rnQ+/05ao9xFVjHJ07mZGIjJYHVKZnRGgxzZDak995isdJmQoHWKLhvDihiCauKTJd
         LvAacTZp/86Uj5Be4vj9/7XJ5hhqnwnpujr2IrAqkdl0OcsvY6S+cZO8FJ7stWcqCUKe
         ohDSIN/BbkJPaP500BR8V/EufhlovLpqNKHkTksDrYwMmuksY/N/xxf+0Kr/TvFXSw8t
         PP+VQkQao3H8O7k6bVgUW4pkroUG8Y/1nPPMgsKpNbnHURwfR5UrAU6lYW39sHMMEIsE
         0HSs4HHD4p3o44JM0q93fI72bka1Sea7wsGqMOCqDwOO2yHC195+NKOfykvkiERguPuO
         TUTw==
X-Gm-Message-State: APjAAAWLx/oUr5Px/9mRsvC/N7Z7JwV2KobgZbDsRiPTIPKYTLpSozG5
        SbP1QhyqnoQVm90ybFUxvuvrjtr4GC4=
X-Google-Smtp-Source: APXvYqwrO+3HuAp8F79t5ah0gk9zfAIZU8lL2bBGB32YAvXYYzUI8Te904Ge1Hsmn6trdhFydiQ0fg==
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr84664053wrn.122.1561112307139;
        Fri, 21 Jun 2019 03:18:27 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y184sm1878193wmg.14.2019.06.21.03.18.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 03:18:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/8] env--helper: new undocumented builtin wrapping git_env_*()
Date:   Fri, 21 Jun 2019 12:18:06 +0200
Message-Id: <20190621101812.27300-3-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190620210915.11297-1-avarab@gmail.com>
References: <20190620210915.11297-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have many GIT_TEST_* variables that accept a <boolean> because
they're implemented in C, and then some that take <non-empty?> because
they're implemented at least partially in shellscript.

Add a helper that wraps git_env_bool() and git_env_ulong() as the
first step in fixing this. This isn't being added as a test-tool mode
because some of these are used outside the test suite.

Part of what this tool does can be done via a trick with "git config"
added in 83d842dc8c ("tests: turn on network daemon tests by default",
2014-02-10) for test_tristate(), i.e.:

    git -c magic.variable="$1" config --bool magic.variable 2>/dev/null

But as subsequent changes will show being able to pass along the
default value makes all the difference, and we'll be able to replace
test_tristate() itself with that.

The --type=bool option will be used by subsequent patches, but not
--type=ulong. I figured it was easy enough to add it & test for it so
I left it in so we'd have wrappers for both git_env_*() functions, and
to have a template to make it obvious how we'd add --type=int etc. if
it's needed in the future.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore            |  1 +
 Makefile              |  1 +
 builtin.h             |  1 +
 builtin/env--helper.c | 95 +++++++++++++++++++++++++++++++++++++++++++
 git.c                 |  1 +
 t/t0017-env-helper.sh | 83 +++++++++++++++++++++++++++++++++++++
 6 files changed, 182 insertions(+)
 create mode 100644 builtin/env--helper.c
 create mode 100755 t/t0017-env-helper.sh

diff --git a/.gitignore b/.gitignore
index 4470d7cfc0..1f7a83fb3c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -58,6 +58,7 @@
 /git-difftool
 /git-difftool--helper
 /git-describe
+/git-env--helper
 /git-fast-export
 /git-fast-import
 /git-fetch
diff --git a/Makefile b/Makefile
index f58bf14c7b..f2cfc8d812 100644
--- a/Makefile
+++ b/Makefile
@@ -1059,6 +1059,7 @@ BUILTIN_OBJS += builtin/diff-index.o
 BUILTIN_OBJS += builtin/diff-tree.o
 BUILTIN_OBJS += builtin/diff.o
 BUILTIN_OBJS += builtin/difftool.o
+BUILTIN_OBJS += builtin/env--helper.o
 BUILTIN_OBJS += builtin/fast-export.o
 BUILTIN_OBJS += builtin/fetch-pack.o
 BUILTIN_OBJS += builtin/fetch.o
diff --git a/builtin.h b/builtin.h
index ec7e0954c4..93bd49fe4f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -160,6 +160,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix);
 int cmd_diff(int argc, const char **argv, const char *prefix);
 int cmd_diff_tree(int argc, const char **argv, const char *prefix);
 int cmd_difftool(int argc, const char **argv, const char *prefix);
+int cmd_env__helper(int argc, const char **argv, const char *prefix);
 int cmd_fast_export(int argc, const char **argv, const char *prefix);
 int cmd_fetch(int argc, const char **argv, const char *prefix);
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
diff --git a/builtin/env--helper.c b/builtin/env--helper.c
new file mode 100644
index 0000000000..1083c0f707
--- /dev/null
+++ b/builtin/env--helper.c
@@ -0,0 +1,95 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+
+static char const * const env__helper_usage[] = {
+	N_("git env--helper --type=[bool|ulong] <options> <env-var>"),
+	NULL
+};
+
+enum {
+	ENV_HELPER_TYPE_BOOL = 1,
+	ENV_HELPER_TYPE_ULONG
+} cmdmode = 0;
+
+static int option_parse_type(const struct option *opt, const char *arg,
+			     int unset)
+{
+	if (!strcmp(arg, "bool"))
+		cmdmode = ENV_HELPER_TYPE_BOOL;
+	else if (!strcmp(arg, "ulong"))
+		cmdmode = ENV_HELPER_TYPE_ULONG;
+	else
+		die(_("unrecognized --type argument, %s"), arg);
+
+	return 0;
+}
+
+int cmd_env__helper(int argc, const char **argv, const char *prefix)
+{
+	int exit_code = 0;
+	const char *env_variable = NULL;
+	const char *env_default = NULL;
+	int ret;
+	int ret_int, default_int;
+	unsigned long ret_ulong, default_ulong;
+	struct option opts[] = {
+		OPT_CALLBACK_F(0, "type", &cmdmode, N_("type"),
+			       N_("value is given this type"), PARSE_OPT_NONEG,
+			       option_parse_type),
+		OPT_STRING(0, "default", &env_default, N_("value"),
+			   N_("default for git_env_*(...) to fall back on")),
+		OPT_BOOL(0, "exit-code", &exit_code,
+			 N_("be quiet only use git_env_*() value as exit code")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, opts, env__helper_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+	if (env_default && !*env_default)
+		usage_with_options(env__helper_usage, opts);
+	if (!cmdmode)
+		usage_with_options(env__helper_usage, opts);
+	if (argc != 1)
+		usage_with_options(env__helper_usage, opts);
+	env_variable = argv[0];
+
+	switch (cmdmode) {
+	case ENV_HELPER_TYPE_BOOL:
+		if (env_default) {
+			default_int = git_parse_maybe_bool(env_default);
+			if (default_int == -1) {
+				error(_("option `--default' expects a boolean value with `--type=bool`, not `%s`"),
+				      env_default);
+				usage_with_options(env__helper_usage, opts);
+			}
+		} else {
+			default_int = 0;
+		}
+		ret_int = git_env_bool(env_variable, default_int);
+		if (!exit_code)
+			puts(ret_int ? "true" : "false");
+		ret = ret_int;
+		break;
+	case ENV_HELPER_TYPE_ULONG:
+		if (env_default) {
+			if (!git_parse_ulong(env_default, &default_ulong)) {
+				error(_("option `--default' expects an unsigned long value with `--type=ulong`, not `%s`"),
+				      env_default);
+				usage_with_options(env__helper_usage, opts);
+			}
+		} else {
+			default_ulong = 0;
+		}
+		ret_ulong = git_env_ulong(env_variable, default_ulong);
+		if (!exit_code)
+			printf("%lu\n", ret_ulong);
+		ret = ret_ulong;
+		break;
+	default:
+		BUG("unknown <type> value");
+		break;
+	}
+
+	return !ret;
+}
diff --git a/git.c b/git.c
index c2eec470c9..a43e1dd98e 100644
--- a/git.c
+++ b/git.c
@@ -500,6 +500,7 @@ static struct cmd_struct commands[] = {
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
+	{ "env--helper", cmd_env__helper },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
new file mode 100755
index 0000000000..709bbbd275
--- /dev/null
+++ b/t/t0017-env-helper.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description='test env--helper'
+
+. ./test-lib.sh
+
+
+test_expect_success 'env--helper usage' '
+	test_must_fail git env--helper &&
+	test_must_fail git env--helper --type=bool &&
+	test_must_fail git env--helper --type=ulong &&
+	test_must_fail git env--helper --type=bool &&
+	test_must_fail git env--helper --type=bool --default &&
+	test_must_fail git env--helper --type=bool --default= &&
+	test_must_fail git env--helper --defaultxyz
+'
+
+test_expect_success 'env--helper bad default values' '
+	test_must_fail git env--helper --type=bool --default=1xyz MISSING &&
+	test_must_fail git env--helper --type=ulong --default=1xyz MISSING
+'
+
+test_expect_success 'env--helper --type=bool' '
+	# Test various --default bool values
+	echo true >expected &&
+	git env--helper --type=bool --default=1 MISSING >actual &&
+	test_cmp expected actual &&
+	git env--helper --type=bool --default=yes MISSING >actual &&
+	test_cmp expected actual &&
+	git env--helper --type=bool --default=true MISSING >actual &&
+	test_cmp expected actual &&
+	echo false >expected &&
+	test_must_fail git env--helper --type=bool --default=0 MISSING >actual &&
+	test_cmp expected actual &&
+	test_must_fail git env--helper --type=bool --default=no MISSING >actual &&
+	test_cmp expected actual &&
+	test_must_fail git env--helper --type=bool --default=false MISSING >actual &&
+	test_cmp expected actual &&
+
+	# No output with --exit-code
+	git env--helper --type=bool --default=true --exit-code MISSING >actual.out 2>actual.err &&
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err &&
+	test_must_fail git env--helper --type=bool --default=false --exit-code MISSING >actual.out 2>actual.err &&
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err &&
+
+	# Existing variable
+	EXISTS=true git env--helper --type=bool --default=false --exit-code EXISTS >actual.out 2>actual.err &&
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err &&
+	test_must_fail \
+		env EXISTS=false \
+		git env--helper --type=bool --default=true --exit-code EXISTS >actual.out 2>actual.err &&
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err
+'
+
+test_expect_success 'env--helper --type=ulong' '
+	echo 1234567890 >expected &&
+	git env--helper --type=ulong --default=1234567890 MISSING >actual.out 2>actual.err &&
+	test_cmp expected actual.out &&
+	test_must_be_empty actual.err &&
+
+	echo 0 >expected &&
+	test_must_fail git env--helper --type=ulong --default=0 MISSING >actual &&
+	test_cmp expected actual &&
+
+	git env--helper --type=ulong --default=1234567890 --exit-code MISSING >actual.out 2>actual.err &&
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err &&
+
+	EXISTS=1234567890 git env--helper --type=ulong --default=0 EXISTS --exit-code >actual.out 2>actual.err &&
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err &&
+
+	echo 1234567890 >expected &&
+	EXISTS=1234567890 git env--helper --type=ulong --default=0 EXISTS >actual.out 2>actual.err &&
+	test_cmp expected actual.out &&
+	test_must_be_empty actual.err
+'
+
+test_done
-- 
2.22.0.455.g172b71a6c5

