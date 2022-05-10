Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9446FC433FE
	for <git@archiver.kernel.org>; Tue, 10 May 2022 19:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbiEJT1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 15:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiEJT1S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 15:27:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9AB36156
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p189so10781014wmp.3
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jxReg2YKrDvXt32NQ6dPIJlwTPUNqg837mpQhjNd/pA=;
        b=GL9IEeloFMqMFqPop6S17AqM2k24Y2a67/4nBTLNk+6eyUCF7XHaRKruqo8fSIOYDb
         O/KU/Ozydh0rHUcLTXhZjwG4E7gwz5j+r2xiI6EFRf2CN29X5FT9I/p9aGPMlXXTrQaK
         AiJ3zl6J1Hf5NkkNn1XhQkJVLFa4ZFaKt19cDjovqXYSymXz3tpLNT523RSBZF5qBFev
         Wa1blIerf1lsOVYAG/RXSGZ04rgzgKKuDPm3ZJMSyFG8VRpVVzOHHFlwOaO9+phjBojp
         jwC54dgK4CbMxBbVWHztun9FdxZdZvLK0saQxR5xLnRRTDtq8zw25vTXtd9p+vpmTL/f
         LaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jxReg2YKrDvXt32NQ6dPIJlwTPUNqg837mpQhjNd/pA=;
        b=QLjg0svIPtVO4AnZEAsB9YL+BZeQ6z7PQk1TUBu/oziF2jBJSWa3aDZF5ZYE8s9PGI
         DAnk+kfq6YDG23PaJSTr9zS0GUEF1P+TzaYOGLst8D4KyQIsfIx4PtIuql4BU1/ZzZG8
         UtH4aa18TejxGEUoFzbSuBVBhhzHZWfau8VJaPznoC8DYywJi364pQfxtf75a9feqUXi
         fPpDoYYt2+9jIdXzmMmoPLlBoY4UQfqJN/bZLF82dxSbrdvELtK2AX68G1rOgHK/EIcf
         kS7D9Q/J12bxSROb5o7s4iE6Rbqu+0hy4UU55eFWAtwVEIq3S3dXw9Cq4ZRo77+Gj9g7
         aiFw==
X-Gm-Message-State: AOAM533OV5WG2HTnr9EInzXpliRhXkhlHIbKC5S0T2LAbUTetWIbqUhQ
        CjYsAG3JVjKK9p6sDNrQ73VBz+O6aGY=
X-Google-Smtp-Source: ABdhPJxTwLwO5TpmIAQ7qzBoDKdfBRwhWZsxNvZuBn7FWLdtEhe7S5jem68iKE58df8MePZ9ss8Ibg==
X-Received: by 2002:a1c:35c2:0:b0:38e:c75d:90a3 with SMTP id c185-20020a1c35c2000000b0038ec75d90a3mr1439679wma.98.1652210833023;
        Tue, 10 May 2022 12:27:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m189-20020a1ca3c6000000b003942a244ed7sm61506wme.28.2022.05.10.12.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:27:11 -0700 (PDT)
Message-Id: <87bdc22322b0f58bf153b963207cffe4f41c9ae9.1652210824.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 19:27:01 +0000
Subject: [PATCH v4 4/7] Implement `scalar diagnose`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Over the course of Scalar's development, it became obvious that there is
a need for a command that can gather all kinds of useful information
that can help identify the most typical problems with large
worktrees/repositories.

The `diagnose` command is the culmination of this hard-won knowledge: it
gathers the installed hooks, the config, a couple statistics describing
the data shape, among other pieces of information, and then wraps
everything up in a tidy, neat `.zip` archive.

Note: originally, Scalar was implemented in C# using the .NET API, where
we had the luxury of a comprehensive standard library that includes
basic functionality such as writing a `.zip` file. In the C version, we
lack such a commodity. Rather than introducing a dependency on, say,
libzip, we slightly abuse Git's `archive` machinery: we write out a
`.zip` of the empty try, augmented by a couple files that are added via
the `--add-file*` options. We are careful trying not to modify the
current repository in any way lest the very circumstances that required
`scalar diagnose` to be run are changed by the `diagnose` run itself.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 144 +++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        |  12 +++
 contrib/scalar/t/t9099-scalar.sh |  14 +++
 3 files changed, 170 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 00dcd4b50ef..367a2c50e25 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -11,6 +11,7 @@
 #include "dir.h"
 #include "packfile.h"
 #include "help.h"
+#include "archive.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -261,6 +262,47 @@ static int unregister_dir(void)
 	return res;
 }
 
+static int add_directory_to_archiver(struct strvec *archiver_args,
+					  const char *path, int recurse)
+{
+	int at_root = !*path;
+	DIR *dir = opendir(at_root ? "." : path);
+	struct dirent *e;
+	struct strbuf buf = STRBUF_INIT;
+	size_t len;
+	int res = 0;
+
+	if (!dir)
+		return error(_("could not open directory '%s'"), path);
+
+	if (!at_root)
+		strbuf_addf(&buf, "%s/", path);
+	len = buf.len;
+	strvec_pushf(archiver_args, "--prefix=%s", buf.buf);
+
+	while (!res && (e = readdir(dir))) {
+		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
+			continue;
+
+		strbuf_setlen(&buf, len);
+		strbuf_addstr(&buf, e->d_name);
+
+		if (e->d_type == DT_REG)
+			strvec_pushf(archiver_args, "--add-file=%s", buf.buf);
+		else if (e->d_type != DT_DIR)
+			warning(_("skipping '%s', which is neither file nor "
+				  "directory"), buf.buf);
+		else if (recurse &&
+			 add_directory_to_archiver(archiver_args,
+						   buf.buf, recurse) < 0)
+			res = -1;
+	}
+
+	closedir(dir);
+	strbuf_release(&buf);
+	return res;
+}
+
 /* printf-style interface, expects `<key>=<value>` argument */
 static int set_config(const char *fmt, ...)
 {
@@ -501,6 +543,107 @@ cleanup:
 	return res;
 }
 
+static int cmd_diagnose(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar diagnose [<enlistment>]"),
+		NULL
+	};
+	struct strbuf zip_path = STRBUF_INIT;
+	struct strvec archiver_args = STRVEC_INIT;
+	char **argv_copy = NULL;
+	int stdout_fd = -1, archiver_fd = -1;
+	time_t now = time(NULL);
+	struct tm tm;
+	struct strbuf path = STRBUF_INIT, buf = STRBUF_INIT;
+	int res = 0;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	setup_enlistment_directory(argc, argv, usage, options, &zip_path);
+
+	strbuf_addstr(&zip_path, "/.scalarDiagnostics/scalar_");
+	strbuf_addftime(&zip_path,
+			"%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
+	strbuf_addstr(&zip_path, ".zip");
+	switch (safe_create_leading_directories(zip_path.buf)) {
+	case SCLD_EXISTS:
+	case SCLD_OK:
+		break;
+	default:
+		error_errno(_("could not create directory for '%s'"),
+			    zip_path.buf);
+		goto diagnose_cleanup;
+	}
+	stdout_fd = dup(1);
+	if (stdout_fd < 0) {
+		res = error_errno(_("could not duplicate stdout"));
+		goto diagnose_cleanup;
+	}
+
+	archiver_fd = xopen(zip_path.buf, O_CREAT | O_WRONLY | O_TRUNC, 0666);
+	if (archiver_fd < 0 || dup2(archiver_fd, 1) < 0) {
+		res = error_errno(_("could not redirect output"));
+		goto diagnose_cleanup;
+	}
+
+	init_zip_archiver();
+	strvec_pushl(&archiver_args, "scalar-diagnose", "--format=zip", NULL);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "Collecting diagnostic info\n\n");
+	get_version_info(&buf, 1);
+
+	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
+	write_or_die(stdout_fd, buf.buf, buf.len);
+	strvec_pushf(&archiver_args,
+		     "--add-file-with-content=diagnostics.log:%.*s",
+		     (int)buf.len, buf.buf);
+
+	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
+		goto diagnose_cleanup;
+
+	strvec_pushl(&archiver_args, "--prefix=",
+		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
+
+	/* `write_archive()` modifies the `argv` passed to it. Let it. */
+	argv_copy = xmemdupz(archiver_args.v,
+			     sizeof(char *) * archiver_args.nr);
+	res = write_archive(archiver_args.nr, (const char **)argv_copy, NULL,
+			    the_repository, NULL, 0);
+	if (res) {
+		error(_("failed to write archive"));
+		goto diagnose_cleanup;
+	}
+
+	if (!res)
+		fprintf(stderr, "\n"
+		       "Diagnostics complete.\n"
+		       "All of the gathered info is captured in '%s'\n",
+		       zip_path.buf);
+
+diagnose_cleanup:
+	if (archiver_fd >= 0) {
+		close(1);
+		dup2(stdout_fd, 1);
+	}
+	free(argv_copy);
+	strvec_clear(&archiver_args);
+	strbuf_release(&zip_path);
+	strbuf_release(&path);
+	strbuf_release(&buf);
+
+	return res;
+}
+
 static int cmd_list(int argc, const char **argv)
 {
 	if (argc != 1)
@@ -802,6 +945,7 @@ static struct {
 	{ "reconfigure", cmd_reconfigure },
 	{ "delete", cmd_delete },
 	{ "version", cmd_version },
+	{ "diagnose", cmd_diagnose },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index f416d637289..22583fe046e 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -14,6 +14,7 @@ scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 scalar reconfigure [ --all | <enlistment> ]
+scalar diagnose [<enlistment>]
 scalar delete <enlistment>
 
 DESCRIPTION
@@ -129,6 +130,17 @@ reconfigure the enlistment.
 With the `--all` option, all enlistments currently registered with Scalar
 will be reconfigured. Use this option after each Scalar upgrade.
 
+Diagnose
+~~~~~~~~
+
+diagnose [<enlistment>]::
+    When reporting issues with Scalar, it is often helpful to provide the
+    information gathered by this command, including logs and certain
+    statistics describing the data shape of the current enlistment.
++
+The output of this command is a `.zip` file that is written into
+a directory adjacent to the worktree in the `src` directory.
+
 Delete
 ~~~~~~
 
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 9d83fdf25e8..6802d317258 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -90,4 +90,18 @@ test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
 	grep "cloned. does not exist" err
 '
 
+SQ="'"
+test_expect_success UNZIP 'scalar diagnose' '
+	scalar clone "file://$(pwd)" cloned --single-branch &&
+	scalar diagnose cloned >out 2>err &&
+	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
+	zip_path=$(cat zip_path) &&
+	test -n "$zip_path" &&
+	unzip -v "$zip_path" &&
+	folder=${zip_path%.zip} &&
+	test_path_is_missing "$folder" &&
+	unzip -p "$zip_path" diagnostics.log >out &&
+	test_file_not_empty out
+'
+
 test_done
-- 
gitgitgadget

