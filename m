Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0470C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiHLUKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiHLUKb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:10:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A4B9594
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso4249737wmh.5
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=3DtPvUJ+3SPdT6od1QbO+EADYby4QM2OS5TX2k4hwJY=;
        b=aoM7+JcNyutYtcacEjpFDOblJhAkysbiNrc7kIwjlgw37vP5YP3U3JF+/LDoaQoKl0
         0my5/nbV1VgtNaJhmuoQWlOtPlhByOMHaBSYWKqkMCDzkoD21AjrwOXbfxWG+4/YWhAs
         7W3ev7MzwbvcF2oX7FVCFAtVPDflTQJRDmAcMSVcF0gu0ycVNb1cX5ja9QhUZzH0lXGC
         mKIq5m5OvBrA7MtGMd0QlZN+GnwD1r6um1GDvosWvLcvW68QR1lNwP5ZDnuHPu/umyEv
         0/m+zkSB1VasyQ+6qdcIFWUk/yiigqykhMlR+avgzlnDt6Zh+xSWs97dXtpXZ4Ht/XL6
         JhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=3DtPvUJ+3SPdT6od1QbO+EADYby4QM2OS5TX2k4hwJY=;
        b=UuHx2aSuwT51O/DpGr+wICi7DoompUPtXn7257eswAEUgixOpxP2+B7oOsXqg/EK00
         Rz6Iv3RaYBYPgaaOO75wP9a0X5bwSFHha98DTVQMVZIldN0qmQaNswD3pq70s8Crmzg7
         HCqMjGz5ufemqwcJzDmHSq8GR9y+1zH4KpfEmB5HvcNVIBkQR2VEsEL2f7Rn1AldTwvv
         CdG1PHF4xEy+7I8gCtQ6ebK7yoATjhgTXxIre/ifrYR3kkWiBzWlW6ksFljbVePanyiR
         Wl/NWAFyu4L9hetWyjiL7wnAveDI9UnK+DDbQaEfHe9gv73PuTBqa5amFhjNqt7Yzqg4
         kABg==
X-Gm-Message-State: ACgBeo3NTyR6ZXCcFfSh55/k3JaPMn3/ShDYifiga+LGDj3pzcOPzHhE
        l0cUAI2ESg9UJ85fjYux7qOnFoXmZd0=
X-Google-Smtp-Source: AA6agR79EB2GXQ2xD5BEh/+KaHp/H9XF/Egd0dg5L9dasDQqkQqENpKy3dPMA81mK1jGRS2Co3OaZg==
X-Received: by 2002:a7b:c354:0:b0:39c:6753:21f8 with SMTP id l20-20020a7bc354000000b0039c675321f8mr3663214wmj.113.1660335028135;
        Fri, 12 Aug 2022 13:10:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c154d00b003a52969e89csm673452wmg.4.2022.08.12.13.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:10:27 -0700 (PDT)
Message-Id: <b58d13325b2eaef32fac89fb2be8e29004560c45.1660335019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 20:10:15 +0000
Subject: [PATCH v4 07/11] builtin/diagnose.c: create 'git diagnose' builtin
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Create a 'git diagnose' builtin to generate a standalone zip archive of
repository diagnostics.

The "diagnose" functionality was originally implemented for Scalar in
aa5c79a331 (scalar: implement `scalar diagnose`, 2022-05-28). However, the
diagnostics gathered are not specific to Scalar-cloned repositories and
can be useful when diagnosing issues in any Git repository.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 .gitignore                     |  1 +
 Documentation/git-diagnose.txt | 50 +++++++++++++++++++++++++++++
 Makefile                       |  1 +
 builtin.h                      |  1 +
 builtin/diagnose.c             | 57 ++++++++++++++++++++++++++++++++++
 git.c                          |  1 +
 t/t0092-diagnose.sh            | 32 +++++++++++++++++++
 7 files changed, 143 insertions(+)
 create mode 100644 Documentation/git-diagnose.txt
 create mode 100644 builtin/diagnose.c
 create mode 100755 t/t0092-diagnose.sh

diff --git a/.gitignore b/.gitignore
index 42fd7253b44..80b530bbed2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -53,6 +53,7 @@
 /git-cvsimport
 /git-cvsserver
 /git-daemon
+/git-diagnose
 /git-diff
 /git-diff-files
 /git-diff-index
diff --git a/Documentation/git-diagnose.txt b/Documentation/git-diagnose.txt
new file mode 100644
index 00000000000..ce07dd0725d
--- /dev/null
+++ b/Documentation/git-diagnose.txt
@@ -0,0 +1,50 @@
+git-diagnose(1)
+================
+
+NAME
+----
+git-diagnose - Generate a zip archive of diagnostic information
+
+SYNOPSIS
+--------
+[verse]
+'git diagnose' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
+
+DESCRIPTION
+-----------
+Collects detailed information about the user's machine, Git client, and
+repository state and packages that information into a zip archive. The
+generated archive can then, for example, be shared with the Git mailing list to
+help debug an issue or serve as a reference for independent debugging.
+
+The following information is captured in the archive:
+
+  * 'git version --build-options'
+  * The path to the repository root
+  * The available disk space on the filesystem
+  * The name and size of each packfile, including those in alternate object
+    stores
+  * The total count of loose objects, as well as counts broken down by
+    `.git/objects` subdirectory
+
+This tool differs from linkgit:git-bugreport[1] in that it collects much more
+detailed information with a greater focus on reporting the size and data shape
+of repository contents.
+
+OPTIONS
+-------
+-o <path>::
+--output-directory <path>::
+	Place the resulting diagnostics archive in `<path>` instead of the
+	current directory.
+
+-s <format>::
+--suffix <format>::
+	Specify an alternate suffix for the diagnostics archive name, to create
+	a file named 'git-diagnostics-<formatted suffix>'. This should take the
+	form of a strftime(3) format string; the current local time will be
+	used.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index ed66cb70e5a..d34f680c065 100644
--- a/Makefile
+++ b/Makefile
@@ -1153,6 +1153,7 @@ BUILTIN_OBJS += builtin/credential-cache.o
 BUILTIN_OBJS += builtin/credential-store.o
 BUILTIN_OBJS += builtin/credential.o
 BUILTIN_OBJS += builtin/describe.o
+BUILTIN_OBJS += builtin/diagnose.o
 BUILTIN_OBJS += builtin/diff-files.o
 BUILTIN_OBJS += builtin/diff-index.o
 BUILTIN_OBJS += builtin/diff-tree.o
diff --git a/builtin.h b/builtin.h
index 40e9ecc8485..8901a34d6bf 100644
--- a/builtin.h
+++ b/builtin.h
@@ -144,6 +144,7 @@ int cmd_credential_cache(int argc, const char **argv, const char *prefix);
 int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix);
 int cmd_credential_store(int argc, const char **argv, const char *prefix);
 int cmd_describe(int argc, const char **argv, const char *prefix);
+int cmd_diagnose(int argc, const char **argv, const char *prefix);
 int cmd_diff_files(int argc, const char **argv, const char *prefix);
 int cmd_diff_index(int argc, const char **argv, const char *prefix);
 int cmd_diff(int argc, const char **argv, const char *prefix);
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
new file mode 100644
index 00000000000..832493bba65
--- /dev/null
+++ b/builtin/diagnose.c
@@ -0,0 +1,57 @@
+#include "builtin.h"
+#include "parse-options.h"
+#include "diagnose.h"
+
+static const char * const diagnose_usage[] = {
+	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]"),
+	NULL
+};
+
+int cmd_diagnose(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf zip_path = STRBUF_INIT;
+	time_t now = time(NULL);
+	struct tm tm;
+	char *option_output = NULL;
+	char *option_suffix = "%Y-%m-%d-%H%M";
+	char *prefixed_filename;
+
+	const struct option diagnose_options[] = {
+		OPT_STRING('o', "output-directory", &option_output, N_("path"),
+			   N_("specify a destination for the diagnostics archive")),
+		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
+			   N_("specify a strftime format suffix for the filename")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, diagnose_options,
+			     diagnose_usage, 0);
+
+	/* Prepare the path to put the result */
+	prefixed_filename = prefix_filename(prefix,
+					    option_output ? option_output : "");
+	strbuf_addstr(&zip_path, prefixed_filename);
+	strbuf_complete(&zip_path, '/');
+
+	strbuf_addstr(&zip_path, "git-diagnostics-");
+	strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+	strbuf_addstr(&zip_path, ".zip");
+
+	switch (safe_create_leading_directories(zip_path.buf)) {
+	case SCLD_OK:
+	case SCLD_EXISTS:
+		break;
+	default:
+		die_errno(_("could not create leading directories for '%s'"),
+			  zip_path.buf);
+	}
+
+	/* Prepare diagnostics */
+	if (create_diagnostics_archive(&zip_path, DIAGNOSE_STATS))
+		die_errno(_("unable to create diagnostics archive %s"),
+			  zip_path.buf);
+
+	free(prefixed_filename);
+	strbuf_release(&zip_path);
+	return 0;
+}
diff --git a/git.c b/git.c
index e5d62fa5a92..0b9d8ef7677 100644
--- a/git.c
+++ b/git.c
@@ -522,6 +522,7 @@ static struct cmd_struct commands[] = {
 	{ "credential-cache--daemon", cmd_credential_cache_daemon },
 	{ "credential-store", cmd_credential_store },
 	{ "describe", cmd_describe, RUN_SETUP },
+	{ "diagnose", cmd_diagnose, RUN_SETUP_GENTLY },
 	{ "diff", cmd_diff, NO_PARSEOPT },
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
diff --git a/t/t0092-diagnose.sh b/t/t0092-diagnose.sh
new file mode 100755
index 00000000000..b6923726fd7
--- /dev/null
+++ b/t/t0092-diagnose.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='git diagnose'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success UNZIP 'creates diagnostics zip archive' '
+	test_when_finished rm -rf report &&
+
+	git diagnose -o report -s test >out &&
+	grep "Available space" out &&
+
+	zip_path=report/git-diagnostics-test.zip &&
+	test_path_is_file "$zip_path" &&
+
+	# Check zipped archive content
+	"$GIT_UNZIP" -p "$zip_path" diagnostics.log >out &&
+	test_file_not_empty out &&
+
+	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
+	grep ".git/objects" out &&
+
+	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
+	grep "^Total: [0-9][0-9]*" out &&
+
+	# Should not include .git directory contents by default
+	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
+	grep "^Total: [0-9][0-9]*" out
+'
+
+test_done
-- 
gitgitgadget

