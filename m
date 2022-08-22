Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFC6C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 15:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiHVPT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbiHVPS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 11:18:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E62474D0
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:13:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a4so13639655wrq.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=oyXpLERDXU6eoC1bJQA+ATjlhkCK7YEgYwous2TIrs4=;
        b=bKn1BZ0fRWbAtXXuATVI5YEno1tkv6ZK6jiNIuLdGvfs4npNzBKrYexDZ+lLpKkXWu
         +Le5vN/OeA3mK+Sp9LuN0eP0P2z0DYDg/OtPdewL1ZhZ1GGFxPnmt5uclrklvseSIKUc
         j5ljzL6KdzWLRgsEbhdKZsjXntnJT63a6YT3ZtspocIKqeKpca+HI443QPxTUfoZIaMK
         D6tf0LP4OM6RjErdiJ7vaQ+n4uRY7kCIQ9NH4bGKJY4XXd6xm/7hQBwbXS9RIaARSlKA
         A4bOX8hyfsM15+AhjeHA9ORwdUpGxPlC2IW9L5c38nYMNOLTDYGDzOmk1UCM2k9iDgli
         20Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=oyXpLERDXU6eoC1bJQA+ATjlhkCK7YEgYwous2TIrs4=;
        b=y+EDmMULYLMrh4fq1gfsUFk3Pa+iO8CtAAPo7nlZexT+VBV8JVhObTzQ22UEnwnwey
         kLRo1klLFhk01WUZkDIcWe5DImj1ocLb++Aai0Ihh73tewkRwoRT5EDYIya8+EW6vOVM
         eJnApnQ9IikdNccgzxj4nsdqRFVo74zuqdv3psw7S5Ch2lP1Br7Evdt1V31FectFq/bj
         tewV1Nz68uGeUCi8OrwWDskHqQC90/MBG9q39z59es9zU9T1d2v/31ZK5QmwYwHabEhC
         XsQ2t9MxYEMefedN6f5EGcpS6HREMB/IAJe3SWOxz68GvbEfgQQku5Xfqdt01yS/YrHn
         2E+Q==
X-Gm-Message-State: ACgBeo2yh1UPMZZ21S1v/M8aaLjqe2XxKzGXuRz4eseWjr1wF5QNwca6
        OC9TTcUVzcF/Fzraf1uJWcvi8gQ6FVw=
X-Google-Smtp-Source: AA6agR5lR3tDGKv2qpC2F2GzZtQDTzKqIuOFg8RXf39LLMWO/vVOTRnbPvm2WB7TAkWoE3yrv6JceQ==
X-Received: by 2002:a5d:5343:0:b0:225:2ffe:77ba with SMTP id t3-20020a5d5343000000b002252ffe77bamr11149307wrv.453.1661181179729;
        Mon, 22 Aug 2022 08:12:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b003a5fa79007fsm15652495wmq.7.2022.08.22.08.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:12:59 -0700 (PDT)
Message-Id: <7580e1f09aff2acdf7a7cb86bf8dc7e294cffd33.1661181174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 15:12:51 +0000
Subject: [PATCH 4/7] bundle-uri: unit test "key=value" parsing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Create a new 'test-tool bundle-uri' test helper. This helper will assist
in testing logic deep in the bundle URI feature.

This change introduces the 'parse-key-values' subcommand, which parses
stdin as a list of lines. These are fed into bundle_uri_parse_line() to
test how we construct a 'struct bundle_list' from that data. The list is
then output to stdout as if the key-value pairs were a Git config file.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Makefile                    |  1 +
 bundle-uri.c                | 33 ++++++++++++++
 bundle-uri.h                |  3 ++
 t/helper/test-bundle-uri.c  | 63 +++++++++++++++++++++++++
 t/helper/test-tool.c        |  1 +
 t/helper/test-tool.h        |  1 +
 t/t5750-bundle-uri-parse.sh | 91 +++++++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh     | 11 +++++
 8 files changed, 204 insertions(+)
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100755 t/t5750-bundle-uri-parse.sh

diff --git a/Makefile b/Makefile
index 7d5f48069ea..7dee0329c49 100644
--- a/Makefile
+++ b/Makefile
@@ -722,6 +722,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-bitmap.o
 TEST_BUILTINS_OBJS += test-bloom.o
+TEST_BUILTINS_OBJS += test-bundle-uri.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
diff --git a/bundle-uri.c b/bundle-uri.c
index 9a7d09349fe..d56c5e33d5f 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -66,6 +66,39 @@ int for_all_bundles_in_list(struct bundle_list *list,
 	return 0;
 }
 
+static int summarize_bundle(struct remote_bundle_info *info, void *data)
+{
+	FILE *fp = data;
+	fprintf(fp, "[bundle \"%s\"]\n", info->id);
+	fprintf(fp, "\turi = %s\n", info->uri);
+	return 0;
+}
+
+void print_bundle_list(FILE *fp, struct bundle_list *list)
+{
+	const char *mode;
+
+	switch (list->mode) {
+	case BUNDLE_MODE_ALL:
+		mode = "all";
+		break;
+
+	case BUNDLE_MODE_ANY:
+		mode = "any";
+		break;
+
+	case BUNDLE_MODE_NONE:
+	default:
+		mode = "<unknown>";
+	}
+
+	printf("[bundle]\n");
+	printf("\tversion = %d\n", list->version);
+	printf("\tmode = %s\n", mode);
+
+	for_all_bundles_in_list(list, summarize_bundle, fp);
+}
+
 /**
  * Given a key-value pair, update the state of the given bundle list.
  * Returns 0 if the key-value pair is understood. Returns 1 if the key
diff --git a/bundle-uri.h b/bundle-uri.h
index f725c9796f7..41a1510a4ac 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -68,6 +68,9 @@ int for_all_bundles_in_list(struct bundle_list *list,
 			    bundle_iterator iter,
 			    void *data);
 
+struct FILE;
+void print_bundle_list(FILE *fp, struct bundle_list *list);
+
 /**
  * Fetch data from the given 'uri' and unbundle the bundle data found
  * based on that information.
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
new file mode 100644
index 00000000000..5cb0c9196fa
--- /dev/null
+++ b/t/helper/test-bundle-uri.c
@@ -0,0 +1,63 @@
+#include "test-tool.h"
+#include "parse-options.h"
+#include "bundle-uri.h"
+#include "strbuf.h"
+#include "string-list.h"
+
+static int cmd__bundle_uri_parse_key_values(int argc, const char **argv)
+{
+	const char *usage[] = {
+		"test-tool bundle-uri parse-key-values <in",
+		NULL
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct strbuf sb = STRBUF_INIT;
+	struct bundle_list list;
+	int err = 0;
+
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	if (argc)
+		goto usage;
+
+	init_bundle_list(&list);
+	while (strbuf_getline(&sb, stdin) != EOF) {
+		if (bundle_uri_parse_line(&list, sb.buf) < 0)
+			err = error("bad line: '%s'", sb.buf);
+	}
+	strbuf_release(&sb);
+
+	print_bundle_list(stdout, &list);
+
+	clear_bundle_list(&list);
+
+	return !!err;
+
+usage:
+	usage_with_options(usage, options);
+}
+
+int cmd__bundle_uri(int argc, const char **argv)
+{
+	const char *usage[] = {
+		"test-tool bundle-uri <subcommand> [<options>]",
+		NULL
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL, options, usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION |
+			     PARSE_OPT_KEEP_ARGV0);
+	if (argc == 1)
+		goto usage;
+
+	if (!strcmp(argv[1], "parse-key-values"))
+		return cmd__bundle_uri_parse_key_values(argc - 1, argv + 1);
+	error("there is no test-tool bundle-uri tool '%s'", argv[1]);
+
+usage:
+	usage_with_options(usage, options);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 318fdbab0c3..fbe2d9d8108 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -17,6 +17,7 @@ static struct test_cmd cmds[] = {
 	{ "advise", cmd__advise_if_enabled },
 	{ "bitmap", cmd__bitmap },
 	{ "bloom", cmd__bloom },
+	{ "bundle-uri", cmd__bundle_uri },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
 	{ "crontab", cmd__crontab },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index bb799271631..b2aa1f39a8f 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -7,6 +7,7 @@
 int cmd__advise_if_enabled(int argc, const char **argv);
 int cmd__bitmap(int argc, const char **argv);
 int cmd__bloom(int argc, const char **argv);
+int cmd__bundle_uri(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__crontab(int argc, const char **argv);
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
new file mode 100755
index 00000000000..675c1f1d2f4
--- /dev/null
+++ b/t/t5750-bundle-uri-parse.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description="Test bundle-uri bundle_uri_parse_line()"
+
+TEST_NO_CREATE_REPO=1
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'bundle_uri_parse_line() just URIs' '
+	cat >in <<-\EOF &&
+	bundle.one.uri=http://example.com/bundle.bdl
+	bundle.two.uri=https://example.com/bundle.bdl
+	bundle.three.uri=file:///usr/share/git/bundle.bdl
+	EOF
+
+	cat >expect <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "one"]
+		uri = http://example.com/bundle.bdl
+	[bundle "two"]
+		uri = https://example.com/bundle.bdl
+	[bundle "three"]
+		uri = file:///usr/share/git/bundle.bdl
+	EOF
+
+	test-tool bundle-uri parse-key-values <in >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp_config_output expect actual
+'
+
+test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty key or value' '
+	cat >in <<-\EOF &&
+	=bogus-value
+	bogus-key=
+	EOF
+
+	cat >err.expect <<-EOF &&
+	error: bundle-uri: line has empty key or value
+	error: bad line: '\''=bogus-value'\''
+	error: bundle-uri: line has empty key or value
+	error: bad line: '\''bogus-key='\''
+	EOF
+
+	cat >expect <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	EOF
+
+	test_must_fail test-tool bundle-uri parse-key-values <in >actual 2>err &&
+	test_cmp err.expect err &&
+	test_cmp_config_output expect actual
+'
+
+test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty lines' '
+	cat >in <<-\EOF &&
+	bundle.one.uri=http://example.com/bundle.bdl
+
+	bundle.two.uri=https://example.com/bundle.bdl
+
+	bundle.three.uri=file:///usr/share/git/bundle.bdl
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	error: bundle-uri: got an empty line
+	error: bad line: '\'''\''
+	error: bundle-uri: got an empty line
+	error: bad line: '\'''\''
+	EOF
+
+	# We fail, but try to continue parsing regardless
+	cat >expect <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "one"]
+		uri = http://example.com/bundle.bdl
+	[bundle "two"]
+		uri = https://example.com/bundle.bdl
+	[bundle "three"]
+		uri = file:///usr/share/git/bundle.bdl
+	EOF
+
+	test_must_fail test-tool bundle-uri parse-key-values <in >actual 2>err &&
+	test_cmp err.expect err &&
+	test_cmp_config_output expect actual
+'
+
+test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6da7273f1d5..3175d665add 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1956,3 +1956,14 @@ test_is_magic_mtime () {
 	rm -f .git/test-mtime-actual
 	return $ret
 }
+
+# Given two filenames, parse both using 'git config --list --file'
+# and compare the sorted output of those commands. Useful when
+# wanting to ignore whitespace differences and sorting concerns.
+test_cmp_config_output () {
+	git config --list --file="$1" >config-expect &&
+	git config --list --file="$2" >config-actual &&
+	sort config-expect >sorted-expect &&
+	sort config-actual >sorted-actual &&
+	test_cmp sorted-expect sorted-actual
+}
-- 
gitgitgadget

