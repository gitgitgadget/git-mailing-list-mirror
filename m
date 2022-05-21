Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A47C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 15:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355359AbiEUPIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354713AbiEUPI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 11:08:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC8993447
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j25so14970451wrc.9
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KOhCLOG4xQM7GXYpo7HgIfpmlRXN1CU5iK5b1yz4gpM=;
        b=Dzk46A83RKFroY6wfPCYrtvlQzBSbZkajbctJSxB3+8m7Ribdw6IHEHVLEYHizNZNd
         OwEc/6CIWhSLcy3rZxOc6awzp09Ym0foZuDdeVeS9m6Txckh0OdQ4WRtFONPOF7/3gJV
         vxFb3yQE/3W1OR5QmNdyKBSGw9n6S0p/OATqSH5V54dkAQjGi+pJyPRGKDo71Dn0PwAT
         hf7Lhs+98z64Gp1ducIUk6wUCE5tdjRhHIyGOzczd7aYRNHQtfFeplotzZaaUcGZ3/pC
         nD1UFBUEnXTQFvJp7SBRL/TmASgFfYXthBSZclnEEGjyYvMLzLcu/+EVR8nYGP6u36hF
         zv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KOhCLOG4xQM7GXYpo7HgIfpmlRXN1CU5iK5b1yz4gpM=;
        b=a1/mEntAoYihlH4wKPFL8BC1RQalSH7r8mcWuxVlw2G1p/Jw3ZFJ5xJbuO203zzbZP
         vEzrbxK8AqLZM5ycO343KcG70SHjCXuElZF+kCRIPv5NbXxA1SqIZzKf+pu1jC0KbUKK
         B3Y8jBO0AHL+2tL/CCk5GJyQ9p3lv2nEh7X7HoslPyScDRfkXzK3PXh/OsiJcaB3HqJn
         J5Yj31fQcs+1lJYCuZBJKGTaME7O81n5dlrOF2W2s83SSGsrxjEkY53z03jmEWIDwlQ1
         Ky+7aZ5Gr63K5LxhyXOyHuoOd3GoOMZcQVAevNGIO6G6tLDbXqXY6qbt+hXeZqoHEpUy
         B2aA==
X-Gm-Message-State: AOAM530DjOCsZmALwvXumZ728n/iT30VPn+oBYy1Boei1w0RduEsUoxs
        0IXu3d3wgqYai9yF3Kuie9sKtkkG3Nk=
X-Google-Smtp-Source: ABdhPJwJAXzBL+NawjNWWrC4yVEf7O7kreDcwx83brtFxuzdNTMY09dk3YvNHLMqXNytmHzn/VQ+7A==
X-Received: by 2002:a05:6000:1867:b0:20f:ca21:7813 with SMTP id d7-20020a056000186700b0020fca217813mr2449829wri.100.1653145702606;
        Sat, 21 May 2022 08:08:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2-20020adfbb42000000b0020d0e7379casm5388758wrg.95.2022.05.21.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 08:08:22 -0700 (PDT)
Message-Id: <89c13a45e00deb1df45113a9249d3a125c7b4fee.1653145696.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 15:08:13 +0000
Subject: [PATCH v6 4/7] Implement `scalar diagnose`
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

