Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA926AEC
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624342; cv=none; b=nqK41/hfL89ZO/e/Bvfb4OlcgGQ4COlogQ8ouf/VPQoo9h8httY0o7d32RsOvc1lrTl3dAI1VNd5hKjJPTFe7yAajvBxMXhCG91W5rxSduf1sRf+D3ucWMo8/Mo2BXWYTuvAxvpV9IudlB5FvLcy3InPJUS7ff3wXfOTdgDxmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624342; c=relaxed/simple;
	bh=gdwC2YDRjWEjVlbK6zR9u+eMkl9NrNEHo8R7xAwvW8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TahWFtlKn9YJQEe75vaj6/OxU7+Q7TqDTossSmwCF318e+Zao9YPzSWcVXJJk8ccMVxJ3RNEeo//QdCwjXjvKykNnV5OuTTs4wXIXmZwNS8FKDomov9f8LediNIM9Qie9jaohgL6sEz4gw3RShEQswV92bBf/CRiuoyutOtSNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3eObKAy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3eObKAy"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f454c57dbso1360034b3a.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758624340; x=1759229140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh7s9kOOesB3/yY5nXinnrAROXkWbfCUmKQlVDMhx+g=;
        b=k3eObKAyKu6kphGxBEZ7xtV7ZWUNNN12/tCfAvIbnrr09aABnRdyZoAV15xlrQetHw
         veNxk7nsQDbBiq5fzYl1KQxCcOid7Hm1yUfNLY0qw+YvH0B6CioM24peUHIfmcJSOwUn
         fuBilv6vqOTi1vf0sPQEyrjrZHhnk51Avlz3pva10Lgslp9mpi6/eQB2smh3e3sfpOa8
         sCBqM3LTLDeO+MvEvou2gh9D57blZHogAura3CnfYDyb2KeiJQ7SyVLwCg87CBMa7/k2
         nA8g94d9ECXBgrTEhClIp3FVXV0GqCue84k5efKVNoCIgNjzt0BclSttlOQrv8J33Rco
         xUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758624340; x=1759229140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dh7s9kOOesB3/yY5nXinnrAROXkWbfCUmKQlVDMhx+g=;
        b=VvwJS0oIXOChoQ/UT4mKgAQOeU09Kg3OUGDrDJalSuEaGN7Tc46FIjS82uHk0QU061
         SGsmY6fzGzeGbfObCC9IQC9Txku/hpuixfh2zr/1En0Y0J70Sz9LHRRsSn0YZfexEHpY
         fYMRTWEzah68Ou7HGrDKIacit4kfv2Cob4joL1BmnyL3ekx95TD/8mjrnU1p2iVZJ+E0
         7+i0Bjvra2XBajRgZuQdMzCO8Na6RMWBzXcHjhw9RXzhY2sUuonCG+nGJ6AKqcr5FdMl
         dzCOWN40lvAqrPLEkzygvhBC6a2KMBdl3VDaFNMN+X3qKIkZEAOixksQ7E9b3UdunCxW
         P1xA==
X-Gm-Message-State: AOJu0YzR6FsmwLrcHbVf75acFEjzAJHvukg2q06C6vi7STALuze1Gvo5
	qEEPN7zDeoiNZoJuAqF0eHf+Ndo62haV5LN6IKTlep4zVFM8/cyk7bR13jR8TA==
X-Gm-Gg: ASbGnctEgMm7MG9fJRfxTKlhoDIp93KofofKzMEDBI1oKAnQa/ZWWO2EvRhLvtS9U1M
	+YC+4jxl9I5+Dk3JdFE4Hp65aXsZVdCQxQIieQ3s9wVgdLT7vxKGs9nIlyIaoQqg4bPeUTtpP09
	HF+Z/4oE35XSoSUOG18HM9u5RHky81nJI1HbBPZ/djcMHXjk/Xnolf0TGD3fiSwcXpMjbROhbCY
	E1hSIPrF6B7ru4TVUhQVM0kioBKveNXXnijTaJ9o8Z7aiUYLrE+Jp/AsPndvnBMe7XSxBp93g5+
	7lQ7ED1FmetjNy0NDUdH5u2FZxpWXhvWryNm2lILnmIvMwDEFoffMTz6ilLq3g0KmDJ5g0O1xyQ
	FL3vt6lyDID3+nwbrfpM=
X-Google-Smtp-Source: AGHT+IHnGRT5Ke0fCGlrYa7AEcX61Rm/vD4qyG+6e77tqGZsAa6cdhRUB8NKpi8Zh7EWtW1+2DtBfA==
X-Received: by 2002:a05:6a20:72a4:b0:251:2a11:e61 with SMTP id adf61e73a8af0-2cfe7274da5mr3277466637.17.1758624339664;
        Tue, 23 Sep 2025 03:45:39 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1979547fsm9488662b3a.31.2025.09.23.03.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:45:39 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH] builtin/refs: add 'get' subcommand
Date: Tue, 23 Sep 2025 16:15:33 +0530
Message-Id: <20250923104533.21165-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While `git-rev-parse(1)` and `git-show-ref(1)` can be used to read
reference values, they have drawbacks for scripting and discoverability.
`rev-parse` performs DWIM expansion which is unpredictable for scripts,
and `show-ref --verify` is difficult to discover and cannot read the
direct target of a symbolic reference.

To address this, introduce a new plumbing command, `git refs get <ref>`.
This new command provides three key advantages:

  - It requires an exact refname and does not perform expansion, making
    it safer and more predictable for scripting.

  - Its name clearly states its purpose and it lives in the logical `git
    refs` namespace, unlike the `--verify` flag which lives in
    `git-show-ref`.

  - It provides a clean, dedicated way to read the direct target of a
    symbolic reference (e.g., `HEAD`) without recursively dereferencing
    it to an object ID.

Add documentation for the new subcommand to the `git-refs(1)` man page
and a comprehensive test suite to verify its behavior.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-refs.adoc |  7 ++++
 builtin/refs.c              | 43 ++++++++++++++++++++++++
 t/meson.build               |  1 +
 t/t1464-refs-get.sh         | 66 +++++++++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100755 t/t1464-refs-get.sh

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index bfa9b3ea2d..f07fe8c864 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -19,6 +19,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--exclude=<pattern>)...] [--start-after=<marker>]
 		   [ --stdin | (<pattern>...)]
 git refs exists <ref>
+git refs get <ref>
 
 DESCRIPTION
 -----------
@@ -45,6 +46,12 @@ exists::
 	failed with an error other than the reference being missing. This does
 	not verify whether the reference resolves to an actual object.
 
+get::
+	Reads the raw value of a single, exact reference. Instead of
+	recursively dereferencing symbolic references, this command prints the
+	direct target of the symref (e.g., ref: refs/heads/main). For regular
+	references, it prints the object ID (SHA-1) they point to.
+
 OPTIONS
 -------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 91548783b7..b473a78e18 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "fsck.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "strbuf.h"
@@ -18,6 +19,9 @@
 #define REFS_EXISTS_USAGE \
 	N_("git refs exists <ref>")
 
+#define REFS_GET_USAGE \
+	N_("git refs get <ref>")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo UNUSED)
 {
@@ -159,6 +163,43 @@ static int cmd_refs_exists(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int cmd_refs_get(int argc, const char **argv, const char *prefix,
+			struct repository *repo UNUSED)
+{
+	const char *refname;
+	struct object_id oid;
+	unsigned int type;
+	int failure_errno = 0;
+	struct strbuf referent = STRBUF_INIT;
+
+	const char * const exists_usage[] = {
+		REFS_EXISTS_USAGE,
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, exists_usage, 0);
+	if (argc != 1)
+		die("refs get requires exactly one reference");
+
+	refname = *argv++;
+	if (refs_read_raw_ref(get_main_ref_store(the_repository), refname,
+			      &oid, &referent, &type, &failure_errno)) {
+		die("'%s' - not a valid ref", refname);
+	}
+
+	if (type & REF_ISSYMREF) {
+		printf("ref: %s\n", referent.buf);
+	} else {
+		printf("%s\n", oid_to_hex(&oid));
+	}
+
+	strbuf_release(&referent);
+	return 0;
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -169,6 +210,7 @@ int cmd_refs(int argc,
 		REFS_VERIFY_USAGE,
 		"git refs list " COMMON_USAGE_FOR_EACH_REF,
 		REFS_EXISTS_USAGE,
+		REFS_GET_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -177,6 +219,7 @@ int cmd_refs(int argc,
 		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
 		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
 		OPT_SUBCOMMAND("exists", &fn, cmd_refs_exists),
+		OPT_SUBCOMMAND("get", &fn, cmd_refs_get),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 7974795fe4..0c8067c69d 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -213,6 +213,7 @@ integration_tests = [
   't1460-refs-migrate.sh',
   't1461-refs-list.sh',
   't1462-refs-exists.sh',
+  't1464-refs-get.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1464-refs-get.sh b/t/t1464-refs-get.sh
new file mode 100755
index 0000000000..166176c881
--- /dev/null
+++ b/t/t1464-refs-get.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description='git refs get'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup repository' '
+	test_commit one &&
+	git tag -a -m "tagging one" my-tag one &&
+	git symbolic-ref refs/my-symref refs/heads/main &&
+	git symbolic-ref refs/dangling-symref refs/heads/no-such-branch
+'
+
+test_expect_success 'fails with no arguments' '
+	test_must_fail git refs get >out 2>err &&
+	test_grep "refs get requires exactly one reference" err
+'
+
+test_expect_success 'fails with too many arguments' '
+	test_must_fail git refs get HEAD HEAD >out 2>err &&
+	test_grep "refs get requires exactly one reference" err
+'
+
+test_expect_success 'get a branch head' '
+	git rev-parse main >expect &&
+	git refs get refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get an annotated tag' '
+	git rev-parse my-tag >expect &&
+	git refs get refs/tags/my-tag >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get HEAD (a symbolic ref)' '
+	echo "ref: refs/heads/main" >expect &&
+	git refs get HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get a custom symbolic ref' '
+	echo "ref: refs/heads/main" >expect &&
+	git refs get refs/my-symref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get a dangling symbolic ref' '
+	echo "ref: refs/heads/no-such-branch" >expect &&
+	git refs get refs/dangling-symref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get a non-existent ref' '
+	test_must_fail git refs get refs/heads/no-such-branch 2>err &&
+	test_grep "not a valid ref" err
+'
+
+test_expect_success 'get does not perform DWIM' '
+	test_must_fail git refs get main 2>err &&
+	test_grep "not a valid ref" err
+'
+
+test_done

base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
-- 
2.34.1

