Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB845025
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 06:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356032; cv=none; b=unImYt38ESsOKATy/nNG/b/as5VmzPTcCjemZRm0yVh7Nm10BMY8GFF3qUEqBQUSphb9Nj11mFOKcE/DXqDKRf0/PLziGA3a0dXxPZwSkCpIemBDxLseCOYFEk1i0l51ROIOapKqHsnGlfqWqZkKEkl7ULHKpGw5SX1QE/0wi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356032; c=relaxed/simple;
	bh=6PsPMsy7d8BWm00lacKWXNFRU89h4lOmbj/VhyenEH8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WiOvLzByqGS97SnUfSrKTrUL7TGM6IG2yrEkL5/c3ello8tXXm7+fgPN8MB0foy6XPtQLTQ9kPTn/w3HqRdDI+zDMsdqBhQq/OcOJwgGNv9x+wGnUG+xGgEEakYASVWQC4Vtwy2R6W2L6VgSM/EnacAHwdglMMzthMBVL1u44pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDWdNvLM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDWdNvLM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so5047265e9.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730356028; x=1730960828; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ahrl6XhyAxEKYBchWBFhcB07Erb/7TVEk/ye0lr0r/Y=;
        b=HDWdNvLM/AAR4NeZARqsS/ciz8+nq3CPCDfO/CBcS+cjNEKjEGrNZzr/VPTSESGubV
         vn56kw2L+R34I5Af1tlwxcB9N+ZSejPmWyd4wgakGqMhpsd1Q9oKenQ1DVx/1SlBztd7
         jl546rACevbrM2xBK+HE/Xg13KfdroisXknXlrOvJv2f/0zKxeA0cLMPE8efpwpE9MUt
         QjbrTCUd2MxG3oxQ0fa5va80n46t6QOimqI/DK/UmSwIo+8Hi43dgnkZvIH0he0f1bOM
         xLJt+J4RyPwHbmaalBrioqg0jv81/Zyn+Wi36uoWrMalEURPqQW50Js9SwYgnJm0iHnX
         RP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730356028; x=1730960828;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ahrl6XhyAxEKYBchWBFhcB07Erb/7TVEk/ye0lr0r/Y=;
        b=oETB3zCfNDoPzyjJ2CBSG1vgVddBr26sRfAPxkff6ysXEK4de6aGfP6bQUtrbsn8Qx
         a3AALtmjlf+xszWHoS1n98bvpC+wS75609AfhAzckmXAXKCQDFXpE6Mg70SvpHpXeFZ1
         x73vuA53+rA4RNLgFU9ShFyEc27OjpAl6AVLGtYWZxK9RRW3C40GAawKlhlsASryerFH
         7sEGfOT6t4rDkm8iVho51F4Y6BoeLsTr44/AK3tlIAF1RBp7gGjqDjvprUPl5xG1dTjV
         wowXh02jUfcz35pgH5E+KQpa8JExVN5z5/LzapKl6shUjiWiZ1JZO1VMrfv60PG0lbRn
         qQow==
X-Gm-Message-State: AOJu0YwMc7GrpY/FNUwcd8s2pbUvWwuwja/K86+wE+LCwekbAH0fH1uN
	/5lyQACvKkwIlgSMMaLmXoetoIpa+kL0Z5mg0/oFES10zenpG2VPd9X6Sw==
X-Google-Smtp-Source: AGHT+IHN5IIUWZUJfIF+4hKS8AXcTEffbgROdcf7BAE10Zr9a0ShP47m0uqj7CTpC0Qw5O/SNasinQ==
X-Received: by 2002:a05:600c:4ec7:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-4319acad2e4mr166359825e9.14.1730356027884;
        Wed, 30 Oct 2024 23:27:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a9984sm43066045e9.32.2024.10.30.23.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:27:07 -0700 (PDT)
Message-Id: <6f93dff88e7cf81800c8f2c8d39175d962a0576f.1730356023.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 31 Oct 2024 06:27:00 +0000
Subject: [PATCH 3/6] t6601: add helper for testing path-walk API
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add some tests based on the current behavior, doing interesting checks
for different sets of branches, ranges, and the --boundary option. This
sets a baseline for the behavior and we can extend it as new options are
introduced.

It is important to mention that the behavior of the API will change soon as
we start to handle UNINTERESTING objects differently, but these tests will
demonstrate the change in behavior.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.txt |   3 +-
 Makefile                                  |   1 +
 t/helper/test-path-walk.c                 |  86 ++++++++++++++++
 t/helper/test-tool.c                      |   1 +
 t/helper/test-tool.h                      |   1 +
 t/t6601-path-walk.sh                      | 118 ++++++++++++++++++++++
 6 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-path-walk.c
 create mode 100755 t/t6601-path-walk.sh

diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index c550c77ca30..662162ec70b 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -42,4 +42,5 @@ commits.
 Examples
 --------
 
-See example usages in future changes.
+See example usages in:
+	`t/helper/test-path-walk.c`
diff --git a/Makefile b/Makefile
index d0d8d6888e3..50413d96492 100644
--- a/Makefile
+++ b/Makefile
@@ -818,6 +818,7 @@ TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-partial-clone.o
 TEST_BUILTINS_OBJS += test-path-utils.o
+TEST_BUILTINS_OBJS += test-path-walk.o
 TEST_BUILTINS_OBJS += test-pcre2-config.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-proc-receive.o
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
new file mode 100644
index 00000000000..3c48f017fa0
--- /dev/null
+++ b/t/helper/test-path-walk.c
@@ -0,0 +1,86 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-tool.h"
+#include "environment.h"
+#include "hex.h"
+#include "object-name.h"
+#include "object.h"
+#include "pretty.h"
+#include "revision.h"
+#include "setup.h"
+#include "parse-options.h"
+#include "path-walk.h"
+#include "oid-array.h"
+
+static const char * const path_walk_usage[] = {
+	N_("test-tool path-walk <options> -- <revision-options>"),
+	NULL
+};
+
+struct path_walk_test_data {
+	uintmax_t tree_nr;
+	uintmax_t blob_nr;
+};
+
+static int emit_block(const char *path, struct oid_array *oids,
+		      enum object_type type, void *data)
+{
+	struct path_walk_test_data *tdata = data;
+	const char *typestr;
+
+	switch (type) {
+	case OBJ_TREE:
+		typestr = "TREE";
+		tdata->tree_nr += oids->nr;
+		break;
+
+	case OBJ_BLOB:
+		typestr = "BLOB";
+		tdata->blob_nr += oids->nr;
+		break;
+
+	default:
+		BUG("we do not understand this type");
+	}
+
+	for (size_t i = 0; i < oids->nr; i++)
+		printf("%s:%s:%s\n", typestr, path, oid_to_hex(&oids->oid[i]));
+
+	return 0;
+}
+
+int cmd__path_walk(int argc, const char **argv)
+{
+	int res;
+	struct rev_info revs = REV_INFO_INIT;
+	struct path_walk_info info = PATH_WALK_INFO_INIT;
+	struct path_walk_test_data data = { 0 };
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	initialize_repository(the_repository);
+	setup_git_directory();
+	revs.repo = the_repository;
+
+	argc = parse_options(argc, argv, NULL,
+			     options, path_walk_usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
+
+	if (argc > 1)
+		setup_revisions(argc, argv, &revs, NULL);
+	else
+		usage(path_walk_usage[0]);
+
+	info.revs = &revs;
+	info.path_fn = emit_block;
+	info.path_fn_data = &data;
+
+	res = walk_objects_by_path(&info);
+
+	printf("trees:%" PRIuMAX "\n"
+	       "blobs:%" PRIuMAX "\n",
+	       data.tree_nr, data.blob_nr);
+
+	return res;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 1ebb69a5dc4..43676e7b93a 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -52,6 +52,7 @@ static struct test_cmd cmds[] = {
 	{ "parse-subcommand", cmd__parse_subcommand },
 	{ "partial-clone", cmd__partial_clone },
 	{ "path-utils", cmd__path_utils },
+	{ "path-walk", cmd__path_walk },
 	{ "pcre2-config", cmd__pcre2_config },
 	{ "pkt-line", cmd__pkt_line },
 	{ "proc-receive", cmd__proc_receive },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 21802ac27da..9cfc5da6e57 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -45,6 +45,7 @@ int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__parse_subcommand(int argc, const char **argv);
 int cmd__partial_clone(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
+int cmd__path_walk(int argc, const char **argv);
 int cmd__pcre2_config(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
 int cmd__proc_receive(int argc, const char **argv);
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
new file mode 100755
index 00000000000..1f277b88291
--- /dev/null
+++ b/t/t6601-path-walk.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+
+test_description='direct path-walk API tests'
+
+. ./test-lib.sh
+
+test_expect_success 'setup test repository' '
+	git checkout -b base &&
+
+	mkdir left &&
+	mkdir right &&
+	echo a >a &&
+	echo b >left/b &&
+	echo c >right/c &&
+	git add . &&
+	git commit -m "first" &&
+
+	echo d >right/d &&
+	git add right &&
+	git commit -m "second" &&
+
+	echo bb >left/b &&
+	git commit -a -m "third" &&
+
+	git checkout -b topic HEAD~1 &&
+	echo cc >right/c &&
+	git commit -a -m "topic"
+'
+
+test_expect_success 'all' '
+	test-tool path-walk -- --all >out &&
+
+	cat >expect <<-EOF &&
+	TREE::$(git rev-parse topic^{tree})
+	TREE::$(git rev-parse base^{tree})
+	TREE::$(git rev-parse base~1^{tree})
+	TREE::$(git rev-parse base~2^{tree})
+	TREE:left/:$(git rev-parse base:left)
+	TREE:left/:$(git rev-parse base~2:left)
+	TREE:right/:$(git rev-parse topic:right)
+	TREE:right/:$(git rev-parse base~1:right)
+	TREE:right/:$(git rev-parse base~2:right)
+	trees:9
+	BLOB:a:$(git rev-parse base~2:a)
+	BLOB:left/b:$(git rev-parse base~2:left/b)
+	BLOB:left/b:$(git rev-parse base:left/b)
+	BLOB:right/c:$(git rev-parse base~2:right/c)
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	BLOB:right/d:$(git rev-parse base~1:right/d)
+	blobs:6
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic only' '
+	test-tool path-walk -- topic >out &&
+
+	cat >expect <<-EOF &&
+	TREE::$(git rev-parse topic^{tree})
+	TREE::$(git rev-parse base~1^{tree})
+	TREE::$(git rev-parse base~2^{tree})
+	TREE:left/:$(git rev-parse base~2:left)
+	TREE:right/:$(git rev-parse topic:right)
+	TREE:right/:$(git rev-parse base~1:right)
+	TREE:right/:$(git rev-parse base~2:right)
+	trees:7
+	BLOB:a:$(git rev-parse base~2:a)
+	BLOB:left/b:$(git rev-parse base~2:left/b)
+	BLOB:right/c:$(git rev-parse base~2:right/c)
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	BLOB:right/d:$(git rev-parse base~1:right/d)
+	blobs:5
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic, not base' '
+	test-tool path-walk -- topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	TREE::$(git rev-parse topic^{tree})
+	TREE:left/:$(git rev-parse topic:left)
+	TREE:right/:$(git rev-parse topic:right)
+	trees:3
+	BLOB:a:$(git rev-parse topic:a)
+	BLOB:left/b:$(git rev-parse topic:left/b)
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	BLOB:right/d:$(git rev-parse topic:right/d)
+	blobs:4
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic, not base, boundary' '
+	test-tool path-walk -- --boundary topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	TREE::$(git rev-parse topic^{tree})
+	TREE::$(git rev-parse base~1^{tree})
+	TREE:left/:$(git rev-parse base~1:left)
+	TREE:right/:$(git rev-parse topic:right)
+	TREE:right/:$(git rev-parse base~1:right)
+	trees:5
+	BLOB:a:$(git rev-parse base~1:a)
+	BLOB:left/b:$(git rev-parse base~1:left/b)
+	BLOB:right/c:$(git rev-parse base~1:right/c)
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	BLOB:right/d:$(git rev-parse base~1:right/d)
+	blobs:5
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_done
-- 
gitgitgadget

