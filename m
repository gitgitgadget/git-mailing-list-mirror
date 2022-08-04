Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C584C19F29
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 01:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiHDBqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbiHDBqH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 21:46:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8495B7AB
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 18:45:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n185so9585024wmn.4
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 18:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CjbZSEp1zuEyMj3/y2A/5KsufqZ2DnZeH1asBxcerUc=;
        b=WmZbWxMRCjYmRWgBuZzyvM3XFfkydckZgCrU1rOZJVhDi+PznwFCY0VeZujdhGo9v9
         bGUTHxn02h9aQKZf1Kxu3bgvyITY7Ek0yWmdDzxvS1mDQOh4BquQodGgRZvSPEsuKuN/
         pNuE9SltYPHkMngdlM76Nj83JcMsNRxQo1UsQY5I0blHAI57wLwjKkIumbQ7cDs+I8wD
         /HEFUxnp73vCrDPYYRAiZMssCQr5Kdbr/0GIpAzeglmc+xSAgz9z4rewHlseJe5tJ8Yb
         oKmRMjkZpy1Jw0Jf/jsCrBheIEjB/DJErUI1RuDd1i1iuqHUSAOdQT0ZszT3vBbURVN1
         VRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CjbZSEp1zuEyMj3/y2A/5KsufqZ2DnZeH1asBxcerUc=;
        b=ezTqe008OzcpwR4mcyM88A6nqA98+n4AHL3LFT1+9kWP3OFQo5Vr9LBTEN5UH0ijn/
         MDsK6amZ/k32tSRakNtN6LeQCGyZQ/r2Ayb3Lcgwf5UZD699FPh5W4xMTj1diJJ/ICwu
         zm0nnaY8A84BN0ASqreX7ZTPOnlML6seNkH7DLYXtXxoDpyrfEC8T5bmYMBkuIfcAsKn
         4EC3/m6KAcYs8FI9CSLYQS9i2mgJovvuEmk3/JrAPPoRbao2GIAM29ZZuueZIKu5ePI3
         Nd6AI5T0RO2+m2sVwCCMhkv2ZM8wBZcQuFUIWYzSBTWhXHWUZ9JrcfnJKiWQt5lbsLVG
         Lyzg==
X-Gm-Message-State: ACgBeo28PEC5yRmw06Kv6rKVkDq3k1vNG9aksTV9Uun6snhQE6A3aIrh
        eWl1Hcq0vqQezRYQecOAu/S60r/wT3Y=
X-Google-Smtp-Source: AA6agR5A/MGXAKNaYdHSPhwKYwpPppVP1VCqMUzNFeEwsOedW8A7iarP5ZM3VZFLZ/lQ6GFxM9tjFw==
X-Received: by 2002:a7b:c2a9:0:b0:3a4:f2a8:e7e4 with SMTP id c9-20020a7bc2a9000000b003a4f2a8e7e4mr4367932wmk.55.1659577557704;
        Wed, 03 Aug 2022 18:45:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003a4c6e67f01sm4408810wmz.6.2022.08.03.18.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 18:45:57 -0700 (PDT)
Message-Id: <73e139ee377f9c50e671b0d94a28b93c1db28a69.1659577543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 01:45:39 +0000
Subject: [PATCH v2 06/10] builtin/diagnose.c: create 'git diagnose' builtin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Signed-off-by: Victoria Dye <vdye@github.com>
---
 .gitignore                     |  1 +
 Documentation/git-diagnose.txt | 52 ++++++++++++++++++++++++++++++
 Makefile                       |  1 +
 builtin.h                      |  1 +
 builtin/diagnose.c             | 58 ++++++++++++++++++++++++++++++++++
 git.c                          |  1 +
 t/t0092-diagnose.sh            | 28 ++++++++++++++++
 7 files changed, 142 insertions(+)
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
index 00000000000..b12ef98f013
--- /dev/null
+++ b/Documentation/git-diagnose.txt
@@ -0,0 +1,52 @@
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
+  * The contents of the `.git`, `.git/hooks`, `.git/info`, `.git/logs`, and
+    `.git/objects/info` directories
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
index ad27a0bd70c..9ceaf55582a 100644
--- a/Makefile
+++ b/Makefile
@@ -1154,6 +1154,7 @@ BUILTIN_OBJS += builtin/credential-cache.o
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
index 00000000000..c545c6bae1d
--- /dev/null
+++ b/builtin/diagnose.c
@@ -0,0 +1,58 @@
+#include "builtin.h"
+#include "parse-options.h"
+#include "diagnose.h"
+
+
+static const char * const diagnose_usage[] = {
+	N_("git diagnose [-o|--output-directory <file>] [-s|--suffix <format>]"),
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
+		die(_("could not create leading directories for '%s'"),
+		    zip_path.buf);
+	}
+
+	/* Prepare diagnostics */
+	if (create_diagnostics_archive(&zip_path))
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
index 00000000000..fa05bf6046f
--- /dev/null
+++ b/t/t0092-diagnose.sh
@@ -0,0 +1,28 @@
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
+
+	zip_path=report/git-diagnostics-test.zip &&
+	grep "Available space" out &&
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
+	grep "^Total: [0-9][0-9]*" out
+'
+
+test_done
-- 
gitgitgadget

