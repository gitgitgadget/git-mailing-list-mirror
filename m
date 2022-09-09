Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E587AECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 14:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiIIOeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiIIOds (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 10:33:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E129EF2954
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 07:33:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c11so3047208wrp.11
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=H5bS4TQm1mwv1bke+KKYSXNRXXVVOxARR0H18fuSdeU=;
        b=Qb6lEoXqCYFRtl9FvsFjV+sc88srpWHKKhteyFfjK8VB3qWiQUiGDuH8WiI2V5aH6e
         BOfyJOIgl0oerT5GHcOjoKtrLl0jxkiP8IvuN03DDjHDY7o+h+6gnUgU545TalZVH5X8
         7LCL3koEmV3I+qW5hSyc+AXXeg8Td513MV+/gcC9E6/r+t8l4adRcxn3oydNvsLIcEre
         4mw5BYDDnnMaf6n3IEqXJd3W+AeKusrgFlreSxsdATWJnOUZ0qXBVDVzPbDwO1vzEMg3
         +fcti9gbX3+/0rLrNM5/qqQfl35vVR+5yfpIPSu/SZ+z4IuChSUgFzbkeVlQMd+8QicV
         3Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H5bS4TQm1mwv1bke+KKYSXNRXXVVOxARR0H18fuSdeU=;
        b=yVvSLMqfBrP/FgBRvN9oLEAYzwAX+bkaQ65fY54iV7E3v1NZyxzlHjx2UvcxB/7H8m
         B69g+9uevMV4W04acwC4uUdAsoeHmeMCXbJKXtH+FwfFx4LCnpHq7J8IgT2WSHLHEKq7
         vfWbbtj5Y+mnE/z9gIYJGwBMMTH/P3u1VX12zCdVy6Knq3GbbwVD1li9mrf25PbF6b6+
         6O9p4tQOG7tdizbm8U5p/tlOkTgXLIWsEYkeLm3dvFdnq/FY9wnIbU2FawPsS+92Jm20
         vuys462AT6jjboZBR8z1NPu3jdSzjrb/v/ZCkrsSCw727pNqvcynfF9tnJ/pEoV48lNT
         c+SA==
X-Gm-Message-State: ACgBeo1B3wmZ+bxl1TqTxayE92KqD9SKaKORtQQ53DrMH0qTPg6C6Lo5
        snCW5ztbFvNAFgMg3SfdEwAAG8sqbvA=
X-Google-Smtp-Source: AA6agR73N+ib7gkV5uKgg3zp/cC9aJQly8rg/E5RHzIDPmlfEviqYsnuyIlSHMBOdYFilfqG2322Xw==
X-Received: by 2002:a05:6000:2ce:b0:226:d420:db7a with SMTP id o14-20020a05600002ce00b00226d420db7amr7757150wry.489.1662734025091;
        Fri, 09 Sep 2022 07:33:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a7bca43000000b003b341a2cfadsm859500wml.17.2022.09.09.07.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:33:44 -0700 (PDT)
Message-Id: <91c5b58f011ad711c301eddc2fecf79ab1ba726a.1662734015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 14:33:32 +0000
Subject: [PATCH v2 6/9] bundle-uri: unit test "key=value" parsing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
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
an input file as a list of lines. These are fed into
bundle_uri_parse_line() to test how we construct a 'struct bundle_list'
from that data. The list is then output to stdout as if the key-value
pairs were a Git config file.

We use an input file instead of stdin because of a future change to
parse in config-file format that works better as an input file.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Makefile                    |   1 +
 bundle-uri.c                |  33 ++++++++++
 bundle-uri.h                |   3 +
 t/helper/test-bundle-uri.c  |  70 +++++++++++++++++++++
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 t/t5750-bundle-uri-parse.sh | 121 ++++++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh     |  11 ++++
 8 files changed, 241 insertions(+)
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
index d4eb1ec7d4d..74d5695e99e 100644
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
+	fprintf(fp, "[bundle]\n");
+	fprintf(fp, "\tversion = %d\n", list->version);
+	fprintf(fp, "\tmode = %s\n", mode);
+
+	for_all_bundles_in_list(list, summarize_bundle, fp);
+}
+
 /**
  * Given a key-value pair, update the state of the given bundle list.
  * Returns 0 if the key-value pair is understood. Returns 1 if the key
diff --git a/bundle-uri.h b/bundle-uri.h
index 90583461929..0e56ab2ae5a 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -59,6 +59,9 @@ int for_all_bundles_in_list(struct bundle_list *list,
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
index 00000000000..0329c56544f
--- /dev/null
+++ b/t/helper/test-bundle-uri.c
@@ -0,0 +1,70 @@
+#include "test-tool.h"
+#include "parse-options.h"
+#include "bundle-uri.h"
+#include "strbuf.h"
+#include "string-list.h"
+
+static int cmd__bundle_uri_parse(int argc, const char **argv)
+{
+	const char *key_value_usage[] = {
+		"test-tool bundle-uri parse-key-values <input>",
+		NULL
+	};
+	const char **usage = key_value_usage;
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct strbuf sb = STRBUF_INIT;
+	struct bundle_list list;
+	int err = 0;
+	FILE *fp;
+
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	if (argc != 1)
+		goto usage;
+
+	init_bundle_list(&list);
+	fp = fopen(argv[0], "r");
+	if (!fp)
+		die("failed to open '%s'", argv[0]);
+
+	while (strbuf_getline(&sb, fp) != EOF) {
+		if (bundle_uri_parse_line(&list, sb.buf))
+			err = error("bad line: '%s'", sb.buf);
+	}
+	strbuf_release(&sb);
+	fclose(fp);
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
+		return cmd__bundle_uri_parse(argc - 1, argv + 1);
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
index 00000000000..fd142a66ad5
--- /dev/null
+++ b/t/t5750-bundle-uri-parse.sh
@@ -0,0 +1,121 @@
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
+	test-tool bundle-uri parse-key-values in >actual 2>err &&
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
+	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
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
+	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
+	test_cmp err.expect err &&
+	test_cmp_config_output expect actual
+'
+
+test_expect_success 'bundle_uri_parse_line() parsing edge cases: duplicate lines' '
+	cat >in <<-\EOF &&
+	bundle.one.uri=http://example.com/bundle.bdl
+	bundle.two.uri=https://example.com/bundle.bdl
+	bundle.one.uri=https://example.com/bundle-2.bdl
+	bundle.three.uri=file:///usr/share/git/bundle.bdl
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	error: bad line: '\''bundle.one.uri=https://example.com/bundle-2.bdl'\''
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
+	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
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

