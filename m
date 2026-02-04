Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51695335BA
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214809; cv=none; b=MYsFFRJ5N0d+DO8HmSypwQIcT7B61KPpB831iTnaEs/LUbl5lU2bjrbmsOZAFv31NIY7kdz/wkIZWVMDQLWbe2UPGcht7RvIy3kmyofnO+J+srZhmXJBoPlha1u5vWXJC8RI1n87Yra4poaV1SnS2EWWgvIulnQ4bJm1UKScgSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214809; c=relaxed/simple;
	bh=amG4UXjZUVvhmRW2ujDHO93tW2ouP4i5Myx/SozLAGY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NasizrI0gvlJUjIblymkbdvsk6WWgNoc6+lilOph2buw5A3BnaEY+cz6zSkAgrR/vEyTha+db71r1Zb011edqkr1In2waUsZohHKFTBgaBAwzycJQH4ChS1ybQLg8m4HoKvQ4rXHmVhxgkfZKfMP1Pxqthwq6WRUIpz09WKhhCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeCZOjhq; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeCZOjhq"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45c889aba0dso642425b6e.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214808; x=1770819608; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cViUdUwvahlcnv7ISIdpbU2mwrIvhV/WWbIL/l5OuSs=;
        b=NeCZOjhqFbo4TnWrXd26MM+ieqUkihdeTrifC+TIAjwBZggilh2BmM2zi08EcxJo9u
         7aEuoAUKFPgXBHzBQp+pk1PcGCs1Lx2d7mGrxJSsFjO6xH928dA5K37U2K2E27qDECnC
         Bkhta0ldePHzABpD96QQcBs5HiOG9bff/5zC0rvk9hcnouB5ActcC9SOWmlbLucvKBpZ
         8pQOzUmbOq1OtpW/XPAQFcopjs0UccGD8JY6+rdfOsIczJwevPWYQnCix+M5+6/Df8eu
         CJMLDADIOsLDiPSbP9NAh/uQ783y04eELyLc0gjkJFbWWxHXyRomffFyHVyQLJeE4G7B
         +Qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214808; x=1770819608;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cViUdUwvahlcnv7ISIdpbU2mwrIvhV/WWbIL/l5OuSs=;
        b=gavnmfpxpzCns4BBwCCK/R+T20OgcZSeEl0+5bC+wQMuayf21YD8tnwzXz2WaO4d6z
         cTXewPBQTPi7qmejua0hkXSk1Hbdo8SoVDtToex3FU1Ydd5ClHA0EgILPn9HjcqbSJ5t
         Ahka6UFfReSXYaAINFCjjQUjD51aINY5p8S9DOmDuhjTVmUZSMYy7myD1Lm2rvlce3mU
         +oxQPe5f4EULfuEJjKJA5PLE/g8Vx7ZrnMsfkdrr3XMxQzZmzEieXtGU3YcsQ/P84zBi
         YfIxXy5YNR2E2CacJgzgxXwRfA6c/w1UT5OIpijYc0mb9XLj2C72S0P23VrdwgTdbhth
         kOiQ==
X-Gm-Message-State: AOJu0YxmPISooUnCoVmy+PcDmixa2266Om9p5bxag969xGhyYvCP0C47
	E3PJzeeDySi0KLiDFVCvbDdQGH8lIFL1dhccjIY6dyN3SjN6mJ3ksOMKt24vXA==
X-Gm-Gg: AZuq6aKj/ejaSzvYOEwiOEJAzX9nvNXCwFdqlODdzyBxlnCSvIYGj5RNidFPYFejrZw
	JcyyWdjFz4Ev5EGIy+yrZ+R+DsVn3jfQ346TVCmdFzRvAramBkqIZ13THciECVt3IVa7NzoPVfF
	i3LkoyvOlYh3S17NIGqkpLHOKLWV+qEXbr3fKbFsQNRoi93pWTbDfYXb9GsAu4rnPuqVtIZ/8SX
	3xitTXAVqOgqBY505jI4WFv3IHxyXChKcyY2NBRhu0n1y1WPDjwzfs0Id3LjCnjzu1GXZJ11/b3
	udnlh9Mtxx3XhZZmXFCXuONXw+TaNWwqq/cRseGEEPwu4rcIAD2M52mkmGGMTIyG5QCgyykOOQV
	7fiTWAqSKPy+QCx7qz/f/P7vbyx7s9VkXhY23LW0pkHX0bSgrcUfcksj5EUQbDIvzBGHuvdFvCY
	aLQgBjZ102t/HTuGGvA+NdRxSz
X-Received: by 2002:a05:6808:1313:b0:453:58dc:c006 with SMTP id 5614622812f47-462d579e09bmr1547298b6e.3.1770214807645;
        Wed, 04 Feb 2026 06:20:07 -0800 (PST)
Received: from [127.0.0.1] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d66590c3sm1440746b6e.9.2026.02.04.06.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:20:06 -0800 (PST)
Message-Id: <c4dab0609613bc5d43bce705dca2f057674a5d5b.1770214803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 14:19:53 +0000
Subject: [PATCH 01/11] config-batch: basic boilerplate of new builtin
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Later changes will document, implement, and test this new builtin. For now,
this serves as the latest example of the minimum boilerplate to introduce a
new builtin.

Recently, we updated the comment in builtin.h about how to create a new
builtin, but failed to mention the required change to meson.build files for
some CI builds to pass. Fix that oversight.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 .gitignore                          |  1 +
 Documentation/git-config-batch.adoc | 24 +++++++++++++++++++++++
 Documentation/meson.build           |  1 +
 Makefile                            |  1 +
 builtin.h                           |  7 +++++++
 builtin/config-batch.c              | 30 +++++++++++++++++++++++++++++
 command-list.txt                    |  1 +
 git.c                               |  1 +
 meson.build                         |  1 +
 t/meson.build                       |  1 +
 t/t1312-config-batch.sh             | 12 ++++++++++++
 11 files changed, 80 insertions(+)
 create mode 100644 Documentation/git-config-batch.adoc
 create mode 100644 builtin/config-batch.c
 create mode 100755 t/t1312-config-batch.sh

diff --git a/.gitignore b/.gitignore
index 78a45cb5be..42640b5e24 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,6 +44,7 @@
 /git-commit-graph
 /git-commit-tree
 /git-config
+/git-config-batch
 /git-count-objects
 /git-credential
 /git-credential-cache
diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
new file mode 100644
index 0000000000..dfa0bd83e2
--- /dev/null
+++ b/Documentation/git-config-batch.adoc
@@ -0,0 +1,24 @@
+git-config-batch(1)
+===================
+
+NAME
+----
+git-config-batch - Get and set options using machine-parseable interface
+
+
+SYNOPSIS
+--------
+[verse]
+'git config-batch' <options>
+
+DESCRIPTION
+-----------
+TODO
+
+SEE ALSO
+--------
+linkgit:git-config[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f02dbc20cb..f5ad117921 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -29,6 +29,7 @@ manpages = {
   'git-commit-tree.adoc' : 1,
   'git-commit.adoc' : 1,
   'git-config.adoc' : 1,
+  'git-config-batch.adoc' : 1,
   'git-count-objects.adoc' : 1,
   'git-credential-cache--daemon.adoc' : 1,
   'git-credential-cache.adoc' : 1,
diff --git a/Makefile b/Makefile
index 8aa489f3b6..aa3868e513 100644
--- a/Makefile
+++ b/Makefile
@@ -1390,6 +1390,7 @@ BUILTIN_OBJS += builtin/commit-graph.o
 BUILTIN_OBJS += builtin/commit-tree.o
 BUILTIN_OBJS += builtin/commit.o
 BUILTIN_OBJS += builtin/config.o
+BUILTIN_OBJS += builtin/config-batch.o
 BUILTIN_OBJS += builtin/count-objects.o
 BUILTIN_OBJS += builtin/credential-cache--daemon.o
 BUILTIN_OBJS += builtin/credential-cache.o
diff --git a/builtin.h b/builtin.h
index e5e16ecaa6..5f5a19635e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -68,12 +68,18 @@
  *
  * . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
  *
+ * . Add 'builtin/foo.c' to the 'builtin_sources' array in 'meson.build'.
+ *
  * Additionally, if `foo` is a new command, there are 4 more things to do:
  *
  * . Add tests to `t/` directory.
  *
+ * . Add the test script to 'integration_tests' in  't/meson.build'.
+ *
  * . Write documentation in `Documentation/git-foo.adoc`.
  *
+ * . Add 'git-foo.adoc' to the manpages list in 'Documentation/meson.build'.
+ *
  * . Add an entry for `git-foo` to `command-list.txt`.
  *
  * . Add an entry for `/git-foo` to `.gitignore`.
@@ -167,6 +173,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix, struct repositor
 int cmd_commit_graph(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_commit_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_config(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_config_batch(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_count_objects(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_credential(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_credential_cache(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/config-batch.c b/builtin/config-batch.c
new file mode 100644
index 0000000000..ea4f408ecb
--- /dev/null
+++ b/builtin/config-batch.c
@@ -0,0 +1,30 @@
+#define USE_THE_REPOSITORY_VARIABLE
+#include "builtin.h"
+#include "config.h"
+#include "environment.h"
+#include "parse-options.h"
+
+static const char *const builtin_config_batch_usage[] = {
+	N_("git config-batch <options>"),
+	NULL
+};
+
+int cmd_config_batch(int argc,
+		     const char **argv,
+		     const char *prefix,
+		     struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	show_usage_with_options_if_asked(argc, argv,
+					 builtin_config_batch_usage, options);
+
+	argc = parse_options(argc, argv, prefix, options, builtin_config_batch_usage,
+			     0);
+
+	repo_config(repo, git_default_config, NULL);
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index accd3d0c4b..57c7c7458d 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -83,6 +83,7 @@ git-commit                              mainporcelain           history
 git-commit-graph                        plumbingmanipulators
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators           complete
+git-config-batch                        plumbinginterrogators
 git-count-objects                       ancillaryinterrogators
 git-credential                          purehelpers
 git-credential-cache                    purehelpers
diff --git a/git.c b/git.c
index c5fad56813..6b55a867dd 100644
--- a/git.c
+++ b/git.c
@@ -557,6 +557,7 @@ static struct cmd_struct commands[] = {
 	{ "commit-graph", cmd_commit_graph, RUN_SETUP },
 	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
+	{ "config-batch", cmd_config_batch, RUN_SETUP_GENTLY },
 	{ "count-objects", cmd_count_objects, RUN_SETUP },
 	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "credential-cache", cmd_credential_cache },
diff --git a/meson.build b/meson.build
index dd52efd1c8..040bc32c2d 100644
--- a/meson.build
+++ b/meson.build
@@ -582,6 +582,7 @@ builtin_sources = [
   'builtin/commit-tree.c',
   'builtin/commit.c',
   'builtin/config.c',
+  'builtin/config-batch.c',
   'builtin/count-objects.c',
   'builtin/credential-cache--daemon.c',
   'builtin/credential-cache.c',
diff --git a/t/meson.build b/t/meson.build
index 459c52a489..0e9f1826f8 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -186,6 +186,7 @@ integration_tests = [
   't1309-early-config.sh',
   't1310-config-default.sh',
   't1311-config-optional.sh',
+  't1312-config-batch.sh',
   't1350-config-hooks-path.sh',
   't1400-update-ref.sh',
   't1401-symbolic-ref.sh',
diff --git a/t/t1312-config-batch.sh b/t/t1312-config-batch.sh
new file mode 100755
index 0000000000..f59ba4a0f3
--- /dev/null
+++ b/t/t1312-config-batch.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+test_description='Test git config-batch'
+
+. ./test-lib.sh
+
+test_expect_success 'help text' '
+	test_must_fail git config-batch -h >out &&
+	grep usage out
+'
+
+test_done
-- 
gitgitgadget

