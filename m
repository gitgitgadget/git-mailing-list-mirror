Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E207DC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 18:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243836AbiESSSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 14:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243784AbiESSSR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 14:18:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBE0EBA89
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so5516709wmj.1
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KOhCLOG4xQM7GXYpo7HgIfpmlRXN1CU5iK5b1yz4gpM=;
        b=duV1wzheyCYMYBqMxb6ZX5IZdTrjS6x+pGlbxcPbJoZzq/3irka7V5d3hyAcPx3345
         DeC/WlO4aXPlNIAOo4GrztNAtjYXzXS5pb+C/smz4LW/ZztptZFbCMoC9H6kRRhdqRrO
         Bkg5IAuIUYYwPoTyuCyFsZvSPzPz9anHw4UxMC3jRzLuUq0hfgylRGG2/bGs1vj+WUPC
         EjH+GuJWbBSrWPtRdmRHCVkJCZUvao8Br75IjubJsHQ8KW7VV/5dqRq4HBUHbwf6+3Bs
         K5SdOLa/oBSFLyHmW0yPFOLMa1MesH/Zcd9bSS/JvoRy5EiegiKMcMb910RwNatAHi6K
         B9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KOhCLOG4xQM7GXYpo7HgIfpmlRXN1CU5iK5b1yz4gpM=;
        b=agVEmCqES+M4ndaZDP8G+Anmdzq7PsY0eAWngUQ5gksehpDW2YpulC9KCy7Pe2qmyM
         chivwOAGQroaLV+Bv9KqqzIO/udQ2ssktLVM3REoUri2x6sYAgHUT2XUcFkVFlpDsXIv
         P3zuIowACYeqIFMFHRvuLvXSCFKmFTU71YH3X/qBkC5J4V7NHuKlXEVYdR5aYNU0zocC
         OI3y/1MtTfCAz3ffcIwhlCv1W3gppXiuFMj1LqVCxpnQeUX/WIiv5uv3JWo80Ro45LVM
         8kL/iHzwGxTbpfikCSi4Fed8cuOJzB9FMwKB3rDXolgA/I+swKuQj22CoQ5fO4V2atEO
         FN4g==
X-Gm-Message-State: AOAM53250REfluADJtsFrdFkTeznoDBmhN7o6bIyrvZEF/CeVhr9yy+8
        5hxP/9ZTGX8rQzF/Z553qhvLCDU/T6U=
X-Google-Smtp-Source: ABdhPJxHQI0VkPJcMDbKGTx0HcY28gjtox2lliupieUyWKjcoBqUtVrcgXlEKafACuLV290LcqvuaA==
X-Received: by 2002:a05:600c:19cf:b0:394:96c4:8959 with SMTP id u15-20020a05600c19cf00b0039496c48959mr5612694wmq.9.1652984289845;
        Thu, 19 May 2022 11:18:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b0039466988f6csm179228wmb.31.2022.05.19.11.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:18:09 -0700 (PDT)
Message-Id: <3fb90194744998e5dd8f2e5b46610a7cc773a09b.1652984283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
References: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 18:18:00 +0000
Subject: [PATCH v5 4/7] Implement `scalar diagnose`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
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
index 00dcd4b50ef..53213f9a3b9 100644
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
+		return error_errno(_("could not open directory '%s'"), path);
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
+		     "--add-virtual-file=diagnostics.log:%.*s",
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

