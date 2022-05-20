Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FA9C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352833AbiETSlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352979AbiETSlF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B0635872
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t6so12633814wra.4
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=8RtlOfK8u+AL3mF0/rtepOdeXhUeFMS0/QQdsyIUVHA=;
        b=k/5ckUkz+ryWPMHHY2ZygX+T1kS0jTYhIxv5fAHHf11Id1nesuqPePLrA0RDc7xzIA
         bLQ3uNzGjOgm6NtjkxLAB1mTOfHnkyDuZ95UiCUbEGBG9pvxCX54JbPyl0+Lk39JSRej
         iHtwWmiUAAeUo6telrFDioXgS/y4R59VcZgk0ZqvWc57Lamd2WX5L66ImTxW58c61PqW
         jYsdM5HEfYLblCqCYnIadY0/CiZVWlT/Rez3ZaK84LVFeBMkbG72G/YWsAtAvUkwm4Eh
         rU+joXiiz8rvigTIhgK4QmRQAUX6DcWxJfEC57jORmTqedtxfjlh3z99chTpLT/6pUVw
         Z8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=8RtlOfK8u+AL3mF0/rtepOdeXhUeFMS0/QQdsyIUVHA=;
        b=kUbr/jBut+UixAfcugWXY1/XEw/KteVi4Yi7bdrp0A5oFfeoQ6y60EKyS4fc1oPmng
         OWRaQkdg72n6CsvHgI+QI1UBjbyjt9k3eF5iWHHDnbCiHQZP0fz3/twA2tluEyQI4ywY
         n7L5Nzwxj81Y7tr52WpVP8Mcnl1fls4uFCjjKJFBAIqm/L9Nyr+KYbnriqPHssL3VC8a
         abAKP9ed50UebplVinWhCYZZg13Px6dSUt8bF40xW7tknVTWfHdP4waRUQoMme1DWMYD
         vm3lvDXDVyKN+Ck607hdbxcFlPnpsLEn0w97Lw62wzUeFRu7siTGywiZ3aVogakAi4GH
         zCqQ==
X-Gm-Message-State: AOAM533bQqCPNKDeIWmYAa2q2BWtbHyEYPZFWud9DRbyMPaOt9WK8joW
        1/ycDv7q6PSUSJbmq1VtCllVcbRE+/c=
X-Google-Smtp-Source: ABdhPJx2tvo5D9+TkNS6th23oFQwTRYCK1UyzU/NxSWYGYOTT/ZBRLXpX+Fcpztrvi07LdcA1+sEFg==
X-Received: by 2002:a5d:588a:0:b0:20c:5ddf:2491 with SMTP id n10-20020a5d588a000000b0020c5ddf2491mr9282002wrf.197.1653072058004;
        Fri, 20 May 2022 11:40:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c379000b003945781b725sm2699535wmr.37.2022.05.20.11.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:57 -0700 (PDT)
Message-Id: <8653864ec468a354f7d78f5902e47e787a10208e.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:30 +0000
Subject: [PATCH 12/24] bundle-uri: unit test "key=value" parsing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
 bundle-uri.c                | 34 ++++++++++++++
 bundle-uri.h                |  3 ++
 t/helper/test-bundle-uri.c  | 63 +++++++++++++++++++++++++
 t/helper/test-tool.c        |  1 +
 t/helper/test-tool.h        |  1 +
 t/t5750-bundle-uri-parse.sh | 91 +++++++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh     | 11 +++++
 8 files changed, 205 insertions(+)
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100755 t/t5750-bundle-uri-parse.sh

diff --git a/Makefile b/Makefile
index 8f27310836d..c8a14793005 100644
--- a/Makefile
+++ b/Makefile
@@ -706,6 +706,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-bitmap.o
 TEST_BUILTINS_OBJS += test-bloom.o
+TEST_BUILTINS_OBJS += test-bundle-uri.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
diff --git a/bundle-uri.c b/bundle-uri.c
index 948f974c478..ff215422888 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -67,6 +67,40 @@ int for_all_bundles_in_list(struct bundle_list *list,
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
+	printf("[bundle \"list\"]\n");
+	printf("\tversion = %d\n", list->version);
+	printf("\tmode = %s\n", mode);
+
+	for_all_bundles_in_list(list, summarize_bundle, fp);
+}
+
+
 /**
  * Given a key-value pair, update the state of the given bundle list.
  * Returns 0 if the key-value pair is understood. Returns 1 if the key
diff --git a/bundle-uri.h b/bundle-uri.h
index 344d5943922..4a12a90bf42 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -70,6 +70,9 @@ int for_all_bundles_in_list(struct bundle_list *list,
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
index 0424f7adf5d..bff823fbd3e 100644
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
index c876e8246fb..eb747e07dd1 100644
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
index 00000000000..ebb80596125
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
+	[bundle "list"]
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
+	[bundle "list"]
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
+	[bundle "list"]
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
index 93c03380d44..747739f81b7 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1944,3 +1944,14 @@ test_is_magic_mtime () {
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

