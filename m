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
	by dcvr.yhbt.net (Postfix) with ESMTP id DF25B1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 21:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfFTVJd (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 17:09:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42516 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfFTVJc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 17:09:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so4410853wrl.9
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzX16v9M2i1C8HjX0FOLvoQL1tTde9sQ5Dqji8cxDvQ=;
        b=Odd1LwS6OG1NIfJEVJ2XShJfuTnUFrguMSjFDmEk81EaMdrWshzszb5NW4aSeuNXEY
         UeQVJ04YoUsJj4SqkPWjc5Ho99bvC3n7faR61oW8G/1oA8JIXo0WO46wAzn48nRqx/j/
         MvU4RD9eFkIQ1f9dIGdPmzMmGE0zilI7D44z0quolyGZ6qcUnqzNLNKJ1u6NZUKcFM5+
         xL06E+V9IFqQiC7t4SFK+RMAKzDNaABgWxG4fd+TxTm/r+hsQAv2KbF5E7b4gbvuafTx
         xRCFCgoFzk3cdOQGjgi1y7kuufQWT8wBwkPTSsXKpsfdbAMIEpuOSdd2wSeaNaxpvTpP
         l9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzX16v9M2i1C8HjX0FOLvoQL1tTde9sQ5Dqji8cxDvQ=;
        b=enc/26zuag/2jvw5hziuW8cgPS5+dJFh4k03BzHCSb4QCf+NmzvRX5xIdD66z4ar+l
         Y5lXE6U4sX4QzT0k8XCfc4DhoIrjuVUv7S0RllAbihtY4iiVcoIsBWrXUlTOe9vDN0ei
         935XFYxkdR1YiyyIk9a6bOFSdzJXDRt3Ue9bgSvUVwMjvYriqhEtlU39ZLM+QEBxTVnB
         cPPZ5PYQtBkAm4sAWbG1DY5WOE5aJceXk1LyWQbN4xwmOhn73txXk+QazRFYAEFwGBQg
         9x0wsFH2j2ua2az0XaYqJ9qzFCx/qaUg4Rtf+ugqUNRot6y47xql2SXvubyqe0NUxCcr
         48Gw==
X-Gm-Message-State: APjAAAXKJkIgPHp8H/i9wbJm6vtSAUUwa42iv2AMAQD+x61CJHZCUP0O
        daOfgkpA+3UjZikLGGjeqmTCmZM88/A=
X-Google-Smtp-Source: APXvYqxvK0mYGnPp/1YowowPbhe0C3Nqec+oQbfxU5P6faSB1VDi5xtsmhY5ishmztOdL9mOpz1xew==
X-Received: by 2002:adf:afd5:: with SMTP id y21mr91280655wrd.12.1561064969267;
        Thu, 20 Jun 2019 14:09:29 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm1295781wre.73.2019.06.20.14.09.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:09:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] env--helper: new undocumented builtin wrapping git_env_*()
Date:   Thu, 20 Jun 2019 23:09:09 +0200
Message-Id: <20190620210915.11297-3-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190619233046.27503-1-avarab@gmail.com>
References: <20190619233046.27503-1-avarab@gmail.com>
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

The --mode-bool option will be used by subsequent patches, but not
--mode-ulong. I figured it was easy enough to add it & test for it so
I left it in so we'd have wrappers for both git_env_*() functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore            |  1 +
 Makefile              |  1 +
 builtin.h             |  1 +
 builtin/env--helper.c | 74 +++++++++++++++++++++++++++++++++++++++++++
 git.c                 |  1 +
 t/t0017-env-helper.sh | 70 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 148 insertions(+)
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
index 0000000000..2bb65ecf3f
--- /dev/null
+++ b/builtin/env--helper.c
@@ -0,0 +1,74 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+
+static char const * const env__helper_usage[] = {
+	N_("git env--helper [--mode-bool | --mode-ulong] --env-variable=<VAR> --env-default=<DEF> [<options>]"),
+	NULL
+};
+
+int cmd_env__helper(int argc, const char **argv, const char *prefix)
+{
+	enum {
+		ENV_HELPER_BOOL = 1,
+		ENV_HELPER_ULONG,
+	} cmdmode = 0;
+	int exit_code = 0;
+	int quiet = 0;
+	const char *env_variable = NULL;
+	const char *env_default = NULL;
+	int ret;
+	int ret_int, tmp_int;
+	unsigned long ret_ulong, tmp_ulong;
+	struct option opts[] = {
+		OPT_CMDMODE(0, "mode-bool", &cmdmode,
+			    N_("invoke git_env_bool(...)"), ENV_HELPER_BOOL),
+		OPT_CMDMODE(0, "mode-ulong", &cmdmode,
+			    N_("invoke git_env_ulong(...)"), ENV_HELPER_ULONG),
+		OPT_STRING(0, "variable", &env_variable, N_("name"),
+			   N_("which environment variable to ask git_env_*(...) about")),
+		OPT_STRING(0, "default", &env_default, N_("value"),
+			   N_("what default value does git_env_*(...) fall back on?")),
+		OPT_BOOL(0, "exit-code", &exit_code,
+			 N_("exit code determined by truth of the git_env_*() function")),
+		OPT_BOOL(0, "quiet", &quiet,
+			 N_("don't print the git_env_*() return value")),
+		OPT_END(),
+	};
+
+	if (parse_options(argc, argv, prefix, opts, env__helper_usage, 0))
+		usage_with_options(env__helper_usage, opts);
+	if (!env_variable || !env_default ||
+	    !*env_variable || !*env_default)
+		usage_with_options(env__helper_usage, opts);
+
+	switch (cmdmode) {
+	case ENV_HELPER_BOOL:
+		tmp_int = strtol(env_default, (char **)&env_default, 10);
+		if (*env_default) {
+			error(_("option `--default' expects a numerical value with `--mode-bool`"));
+			usage_with_options(env__helper_usage, opts);
+		}
+		ret_int = git_env_bool(env_variable, tmp_int);
+		if (!quiet)
+			printf("%d\n", ret_int);
+		ret = ret_int;
+		break;
+	case ENV_HELPER_ULONG:
+		tmp_ulong = strtoll(env_default, (char **)&env_default, 10);
+		if (*env_default) {
+			error(_("option `--default' expects a numerical value with `--mode-ulong`"));
+			usage_with_options(env__helper_usage, opts);
+		}
+		ret_ulong = git_env_ulong(env_variable, tmp_ulong);
+		if (!quiet)
+			printf("%lu\n", ret_ulong);
+		ret = ret_ulong;
+		break;
+	}
+
+	if (exit_code)
+		return !ret;
+
+	return 0;
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
index 0000000000..4dc4ab35e5
--- /dev/null
+++ b/t/t0017-env-helper.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='test env--helper'
+
+. ./test-lib.sh
+
+
+test_expect_success 'env--helper usage' '
+	test_must_fail git env--helper &&
+	test_must_fail git env--helper --mode-bool &&
+	test_must_fail git env--helper --mode-ulong &&
+	test_must_fail git env--helper --mode-bool --variable &&
+	test_must_fail git env--helper --mode-bool --variable --default &&
+	test_must_fail git env--helper --mode-bool --variable= --default=
+'
+
+test_expect_success 'env--helper bad default values' '
+	test_must_fail git env--helper --mode-bool --variable=MISSING --default=1xyz &&
+	test_must_fail git env--helper --mode-ulong --variable=MISSING --default=1xyz
+'
+
+test_expect_success 'env--helper --mode-bool' '
+	echo 1 >expected &&
+	git env--helper --mode-bool --variable=MISSING --default=1 --exit-code >actual &&
+	test_cmp expected actual &&
+
+	echo 0 >expected &&
+	test_must_fail git env--helper --mode-bool --variable=MISSING --default=0 --exit-code >actual &&
+	test_cmp expected actual &&
+
+	git env--helper --mode-bool --variable=MISSING --default=0 >actual &&
+	test_cmp expected actual &&
+
+	>expected &&
+	git env--helper --mode-bool --variable=MISSING --default=1 --exit-code --quiet >actual &&
+	test_cmp expected actual &&
+
+	EXISTS=true git env--helper --mode-bool --variable=EXISTS --default=0 --exit-code --quiet >actual &&
+	test_cmp expected actual &&
+
+	echo 1 >expected &&
+	EXISTS=true git env--helper --mode-bool --variable=EXISTS --default=0 --exit-code >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'env--helper --mode-ulong' '
+	echo 1234567890 >expected &&
+	git env--helper --mode-ulong --variable=MISSING --default=1234567890 --exit-code >actual &&
+	test_cmp expected actual &&
+
+	echo 0 >expected &&
+	test_must_fail git env--helper --mode-ulong --variable=MISSING --default=0 --exit-code >actual &&
+	test_cmp expected actual &&
+
+	git env--helper --mode-ulong --variable=MISSING --default=0 >actual &&
+	test_cmp expected actual &&
+
+	>expected &&
+	git env--helper --mode-ulong --variable=MISSING --default=1234567890 --exit-code --quiet >actual &&
+	test_cmp expected actual &&
+
+	EXISTS=1234567890 git env--helper --mode-ulong --variable=EXISTS --default=0 --exit-code --quiet >actual &&
+	test_cmp expected actual &&
+
+	echo 1234567890 >expected &&
+	EXISTS=1234567890 git env--helper --mode-ulong --variable=EXISTS --default=0 --exit-code >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
2.22.0.455.g172b71a6c5

