Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5059CC433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C82A60F58
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbhJGLBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240998AbhJGLBX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE911C061768
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v17so17761960wrv.9
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7S8PwvTeu58NSKErU1b7kjsFSTnWwK1jeDD6xKAb9Ck=;
        b=Z3v3QkPZp7UF5K/hzGnzc+7hjMkqxjjbSPeKWtECwb4qasDiBAB6ER/NyL80RjtkYi
         RzvzEnvnZm3F3U2NnTXFmhJbMJt+8yIIhjNGoWT4BGQmMa9v1ZVU0sRziGGvZjDju7hh
         4uK+n7Nj5hKRmd9bmLj+bvqHGaYl5iqr/zZol0I5VeoAkq9huvAyP8eYnJSxjO75rCLZ
         o16U5Kroox7OOumc2ealRpa148AL8+QABZmhtcqxwfMinc8MhYBN/W0Y3pEHQLvcCfOn
         EWOi6/NCGMsAuK7VZqTa3ip4Tztfy0xvrPvHaC1MKeVulQryRPhYfrz6hkWSbnE9EQ0f
         PDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7S8PwvTeu58NSKErU1b7kjsFSTnWwK1jeDD6xKAb9Ck=;
        b=yKo8WPNOqY751WVZsXtffPygxz1cBmMiION/hiqgvbaFzmal1Srq+xUhCGiXXsQrol
         rPqW71nPaBXwAR9Vn7R8Fcyl7ohCkxCL524vwhAvoR6OQ5rbeIqYBrM+NsB7HIs98vcy
         i3IIxdk8uspI63feVU1+PlJ8C1Lqjg0WuI3atVlnPeZ9MrydkmLeNp7hiy7D+PG0EcvL
         U4eHWvlWbKlYHSTqfJl5tD2ZEH7vbmZt77ipup1T09SNZi8awX9U4oZLcsoMgaanGIpa
         BWaUuuVzFRyGIu/ahwTAKhgf80vro74KoG+A2doO6F174MfVvpChJTbQ3VrkVK2C0n9F
         F9rA==
X-Gm-Message-State: AOAM533vmPnN+k0xb8WK9rszfRkA5IjW1J6WmFZsqfJ9G6JIxE81queK
        EhL18WeteX+XJ8Vsg6nPo3ID7BafypQ=
X-Google-Smtp-Source: ABdhPJwhxmcGH+iqwgsEKbAAq4KnAxN33KO1a20QCOqAx0CCTvakPtjZ0r7+0CMC/gEltSRZP4Gc7Q==
X-Received: by 2002:a05:600c:1c9e:: with SMTP id k30mr3795617wms.74.1633604356204;
        Thu, 07 Oct 2021 03:59:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm9654656wrw.85.2021.10.07.03.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:15 -0700 (PDT)
Message-Id: <670891d14cca3cd3ec01a61a1cb4726cfdcdc0a0.1633604349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:59:02 +0000
Subject: [PATCH v5 08/15] scalar: implement the `clone` subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This implements Scalar's opinionated `clone` command: it tries to use a
partial clone and sets up a sparse checkout by default. In contrast to
`git clone`, `scalar clone` sets up the worktree in the `src/`
subdirectory, to encourage a separation between the source files and the
build output (which helps Git tremendously because it avoids untracked
files that have to be specifically ignored when refreshing the index).

Also, it registers the repository for regular, scheduled maintenance,
and configures a flurry of configuration settings based on the
experience and experiments of the Microsoft Windows and the Microsoft
Office development teams.

Note: since the `scalar clone` command is by far the most commonly
called `scalar` subcommand, we document it at the top of the manual
page.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 201 +++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        |  31 ++++-
 contrib/scalar/t/t9099-scalar.sh |  32 +++++
 3 files changed, 261 insertions(+), 3 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index d13eb951c3d..0401462b9b3 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -7,6 +7,7 @@
 #include "parse-options.h"
 #include "config.h"
 #include "run-command.h"
+#include "refs.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -250,6 +251,205 @@ static int unregister_dir(void)
 	return res;
 }
 
+/* printf-style interface, expects `<key>=<value>` argument */
+static int set_config(const char *fmt, ...)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char *value;
+	int res;
+	va_list args;
+
+	va_start(args, fmt);
+	strbuf_vaddf(&buf, fmt, args);
+	va_end(args);
+
+	value = strchr(buf.buf, '=');
+	if (value)
+		*(value++) = '\0';
+	res = git_config_set_gently(buf.buf, value);
+	strbuf_release(&buf);
+
+	return res;
+}
+
+static char *remote_default_branch(const char *url)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+
+	cp.git_cmd = 1;
+	strvec_pushl(&cp.args, "ls-remote", "--symref", url, "HEAD", NULL);
+	if (!pipe_command(&cp, NULL, 0, &out, 0, NULL, 0)) {
+		const char *line = out.buf;
+
+		while (*line) {
+			const char *eol = strchrnul(line, '\n'), *p;
+			size_t len = eol - line;
+			char *branch;
+
+			if (!skip_prefix(line, "ref: ", &p) ||
+			    !strip_suffix_mem(line, &len, "\tHEAD")) {
+				line = eol + (*eol == '\n');
+				continue;
+			}
+
+			eol = line + len;
+			if (skip_prefix(p, "refs/heads/", &p)) {
+				branch = xstrndup(p, eol - p);
+				strbuf_release(&out);
+				return branch;
+			}
+
+			error(_("remote HEAD is not a branch: '%.*s'"),
+			      (int)(eol - p), p);
+			strbuf_release(&out);
+			return NULL;
+		}
+	}
+	warning(_("failed to get default branch name from remote; "
+		  "using local default"));
+	strbuf_reset(&out);
+
+	child_process_init(&cp);
+	cp.git_cmd = 1;
+	strvec_pushl(&cp.args, "symbolic-ref", "--short", "HEAD", NULL);
+	if (!pipe_command(&cp, NULL, 0, &out, 0, NULL, 0)) {
+		strbuf_trim(&out);
+		return strbuf_detach(&out, NULL);
+	}
+
+	strbuf_release(&out);
+	error(_("failed to get default branch name"));
+	return NULL;
+}
+
+static int cmd_clone(int argc, const char **argv)
+{
+	const char *branch = NULL;
+	int full_clone = 0;
+	struct option clone_options[] = {
+		OPT_STRING('b', "branch", &branch, N_("<branch>"),
+			   N_("branch to checkout after clone")),
+		OPT_BOOL(0, "full-clone", &full_clone,
+			 N_("when cloning, create full working directory")),
+		OPT_END(),
+	};
+	const char * const clone_usage[] = {
+		N_("scalar clone [<options>] [--] <repo> [<dir>]"),
+		NULL
+	};
+	const char *url;
+	char *enlistment = NULL, *dir = NULL;
+	struct strbuf buf = STRBUF_INIT;
+	int res;
+
+	argc = parse_options(argc, argv, NULL, clone_options, clone_usage, 0);
+
+	if (argc == 2) {
+		url = argv[0];
+		enlistment = xstrdup(argv[1]);
+	} else if (argc == 1) {
+		url = argv[0];
+
+		strbuf_addstr(&buf, url);
+		/* Strip trailing slashes, if any */
+		while (buf.len > 0 && is_dir_sep(buf.buf[buf.len - 1]))
+			strbuf_setlen(&buf, buf.len - 1);
+		/* Strip suffix `.git`, if any */
+		strbuf_strip_suffix(&buf, ".git");
+
+		enlistment = find_last_dir_sep(buf.buf);
+		if (!enlistment) {
+			die(_("cannot deduce worktree name from '%s'"), url);
+		}
+		enlistment = xstrdup(enlistment + 1);
+	} else {
+		usage_msg_opt(_("You must specify a repository to clone."),
+			      clone_usage, clone_options);
+	}
+
+	if (is_directory(enlistment))
+		die(_("directory '%s' exists already"), enlistment);
+
+	dir = xstrfmt("%s/src", enlistment);
+
+	strbuf_reset(&buf);
+	if (branch)
+		strbuf_addf(&buf, "init.defaultBranch=%s", branch);
+	else {
+		char *b = repo_default_branch_name(the_repository, 1);
+		strbuf_addf(&buf, "init.defaultBranch=%s", b);
+		free(b);
+	}
+
+	if ((res = run_git("-c", buf.buf, "init", "--", dir, NULL)))
+		goto cleanup;
+
+	if (chdir(dir) < 0) {
+		res = error_errno(_("could not switch to '%s'"), dir);
+		goto cleanup;
+	}
+
+	setup_git_directory();
+
+	/* common-main already logs `argv` */
+	trace2_def_repo(the_repository);
+
+	if (!branch && !(branch = remote_default_branch(url))) {
+		res = error(_("failed to get default branch for '%s'"), url);
+		goto cleanup;
+	}
+
+	if (set_config("remote.origin.url=%s", url) ||
+	    set_config("remote.origin.fetch="
+		       "+refs/heads/*:refs/remotes/origin/*") ||
+	    set_config("remote.origin.promisor=true") ||
+	    set_config("remote.origin.partialCloneFilter=blob:none")) {
+		res = error(_("could not configure remote in '%s'"), dir);
+		goto cleanup;
+	}
+
+	if (!full_clone &&
+	    (res = run_git("sparse-checkout", "init", "--cone", NULL)))
+		goto cleanup;
+
+	if (set_recommended_config())
+		return error(_("could not configure '%s'"), dir);
+
+	if ((res = run_git("fetch", "--quiet", "origin", NULL))) {
+		warning(_("partial clone failed; attempting full clone"));
+
+		if (set_config("remote.origin.promisor") ||
+		    set_config("remote.origin.partialCloneFilter")) {
+			res = error(_("could not configure for full clone"));
+			goto cleanup;
+		}
+
+		if ((res = run_git("fetch", "--quiet", "origin", NULL)))
+			goto cleanup;
+	}
+
+	if ((res = set_config("branch.%s.remote=origin", branch)))
+		goto cleanup;
+	if ((res = set_config("branch.%s.merge=refs/heads/%s",
+			      branch, branch)))
+		goto cleanup;
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "origin/%s", branch);
+	res = run_git("checkout", "-f", "-t", buf.buf, NULL);
+	if (res)
+		goto cleanup;
+
+	res = register_dir();
+
+cleanup:
+	free(enlistment);
+	free(dir);
+	strbuf_release(&buf);
+	return res;
+}
+
 static int cmd_list(int argc, const char **argv)
 {
 	if (argc != 1)
@@ -346,6 +546,7 @@ static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
+	{ "clone", cmd_clone },
 	{ "list", cmd_list },
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index f93e3d00efd..d65fb5f1491 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -8,6 +8,7 @@ scalar - an opinionated repository management tool
 SYNOPSIS
 --------
 [verse]
+scalar clone [--branch <main-branch>] [--full-clone] <url> [<enlistment>]
 scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
@@ -29,12 +30,36 @@ an existing Git worktree with Scalar whose name is not `src`, the enlistment
 will be identical to the worktree.
 
 The `scalar` command implements various subcommands, and different options
-depending on the subcommand. With the exception of `list`, all subcommands
-expect to be run in an enlistment.
+depending on the subcommand. With the exception of `clone` and `list`, all
+subcommands expect to be run in an enlistment.
 
 COMMANDS
 --------
 
+Clone
+~~~~~
+
+clone [<options>] <url> [<enlistment>]::
+	Clones the specified repository, similar to linkgit:git-clone[1]. By
+	default, only commit and tree objects are cloned. Once finished, the
+	worktree is located at `<enlistment>/src`.
++
+The sparse-checkout feature is enabled (except when run with `--full-clone`)
+and the only files present are those in the top-level directory. Use
+`git sparse-checkout set` to expand the set of directories you want to see,
+or `git sparse-checkout disable` to expand to all files (see
+linkgit:git-sparse-checkout[1] for more details). You can explore the
+subdirectories outside your sparse-checkout by using `git ls-tree HEAD`.
+
+-b <name>::
+--branch <name>::
+	Instead of checking out the branch pointed to by the cloned
+	repository's HEAD, check out the `<name>` branch instead.
+
+--[no-]full-clone::
+	A sparse-checkout is initialized by default. This behavior can be
+	turned off via `--full-clone`.
+
 List
 ~~~~
 
@@ -64,7 +89,7 @@ unregister [<enlistment>]::
 
 SEE ALSO
 --------
-linkgit:git-maintenance[1].
+linkgit:git-clone[1], linkgit:git-maintenance[1].
 
 Scalar
 ---
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index ef0e8d680d5..295398f62cc 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -10,6 +10,9 @@ PATH=$PWD/..:$PATH
 
 . ../../../t/test-lib.sh
 
+GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt"
+export GIT_TEST_MAINT_SCHEDULER
+
 test_expect_success 'scalar shows a usage' '
 	test_expect_code 129 scalar -h
 '
@@ -29,4 +32,33 @@ test_expect_success 'scalar unregister' '
 	! grep -F "$(pwd)/vanish/src" scalar.repos
 '
 
+test_expect_success 'set up repository to clone' '
+	test_commit first &&
+	test_commit second &&
+	test_commit third &&
+	git switch -c parallel first &&
+	mkdir -p 1/2 &&
+	test_commit 1/2/3 &&
+	git config uploadPack.allowFilter true &&
+	git config uploadPack.allowAnySHA1InWant true
+'
+
+test_expect_success 'scalar clone' '
+	second=$(git rev-parse --verify second:second.t) &&
+	scalar clone "file://$(pwd)" cloned &&
+	(
+		cd cloned/src &&
+
+		git config --get --global --fixed-value maintenance.repo \
+			"$(pwd)" &&
+
+		test_path_is_missing 1/2 &&
+		test_must_fail git rev-list --missing=print $second &&
+		git rev-list $second &&
+		git cat-file blob $second >actual &&
+		echo "second" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget

