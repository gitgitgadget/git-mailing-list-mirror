Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28A71F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389509AbeLTTpY (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:24 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39000 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389493AbeLTTpO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:14 -0500
Received: by mail-wr1-f47.google.com with SMTP id t27so2980102wra.6
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XMjaE3CL0jfklZ2FToojJDguSHp8O+KmwDd0a6+4ak=;
        b=PuzC9ixEqpCuh2vedTiEyw3D8WIS3WpPpYltW3X9MPzaEzVlH1YavjE3jGs7firAah
         +JwFZS/CNuTOUH+A8VLSirx/twHEonLtpaq3J30jha3AfYrnviTyArJZYcHRBqkEE2ww
         drQohFcLvEJPHqjreYpleOuGz/itM2b1JZ6EBFKlCiTpEPe8ZT0WnwfTDi6Jt23EiTMg
         dTR6hPxmCuTmD+pZay34ogeWdPe6Dr0Qvq0V6+hQmaV21snoFu0+ip10QXcjIZ8Q3Cgv
         RBkCtL1FqYWpYrgO+TRQzm5KVqHVC72lLrQ6BMQc8NHDN3R++kpyA1OxBQNUrM2Y6AY6
         oqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XMjaE3CL0jfklZ2FToojJDguSHp8O+KmwDd0a6+4ak=;
        b=JaezntZUOUYkanbKVAJ1eDwuUmOB2N7fib1qIaviYlGX0iNq2imnPCM4gx/IwaWici
         PdMNziTpfBariuiZe5xsO4RRH2pCnwZBK0HPsqpOKnc6lqNZBNRz83uywTb2Xla+NHf8
         ZfkK+tLMV/LyJkrEnVsVXgXO0Iw9bjT4SvZbxcm5oCgC2Bj1taZOT4/rQ+6YG1y7mFCo
         Ft1QiB3+2gu2U+gxCggijYow4NeDwMOmj0iK+pTKBQWNQXHc2qU9dl5vzLfysVbooqQC
         hH596nWuHzJ37qX3F8LaS4mYUjV+ykn1K9tz8w1br/lX9Fb9Uau/QmUP9VkYtJVxXLcP
         ibnw==
X-Gm-Message-State: AA+aEWaFtoz9gbNtccWJMeamujzG20aIARDjN6w5N7FB5vajHZP0AoGE
        sn+VUclFb/atj9sqoPPI1fJUkpEawwU=
X-Google-Smtp-Source: AFSGD/UrW8q6bJ+jndczMJDP3TZYR+w0OZaOj18wm1laFgJKaZBDNq9RESKEO/J8tm3frZMAM0hbfw==
X-Received: by 2002:adf:e64d:: with SMTP id b13mr24616062wrn.276.1545335112907;
        Thu, 20 Dec 2018 11:45:12 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:45:12 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 25/26] stash: optionally use the scripted version again
Date:   Thu, 20 Dec 2018 21:44:41 +0200
Message-Id: <c05bb05e6eb40af1921e02711ff96350c8165cf2.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We recently converted the `git stash` command from Unix shell scripts
to builtins.

Let's end users a way out when they discover a bug in the
builtin command: `stash.useBuiltin`.

As the file name `git-stash` is already in use, let's rename the
scripted backend to `git-legacy-stash`.

To make the test suite pass with `stash.useBuiltin=false`, this commit
also backports rudimentary support for `-q` (but only *just* enough
to appease the test suite), and adds a super-ugly hack to force exit
code 129 for `git stash -h`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                          |  1 +
 Makefile                            |  1 +
 builtin/stash.c                     | 35 +++++++++++++++++++++++++++++
 git-stash.sh => git-legacy-stash.sh | 34 +++++++++++++++++++++++++---
 git-sh-setup.sh                     |  1 +
 git.c                               |  7 +++++-
 6 files changed, 75 insertions(+), 4 deletions(-)
 rename git-stash.sh => git-legacy-stash.sh (97%)

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..7b0164675e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -82,6 +82,7 @@
 /git-interpret-trailers
 /git-instaweb
 /git-legacy-rebase
+/git-legacy-stash
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Makefile b/Makefile
index 8cee2731aa..810231a0b5 100644
--- a/Makefile
+++ b/Makefile
@@ -617,6 +617,7 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-legacy-rebase.sh
+SCRIPT_SH += git-legacy-stash.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-submodule.sh
diff --git a/builtin/stash.c b/builtin/stash.c
index fe32ff42fd..346c9d2bb1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -13,6 +13,7 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "diffcore.h"
+#include "exec-cmd.h"
 
 #define INCLUDE_ALL_FILES 2
 
@@ -1513,6 +1514,26 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int use_builtin_stash(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	int ret;
+
+	argv_array_pushl(&cp.args,
+			 "config", "--bool", "stash.usebuiltin", NULL);
+	cp.git_cmd = 1;
+	if (capture_command(&cp, &out, 6)) {
+		strbuf_release(&out);
+		return 1;
+	}
+
+	strbuf_trim(&out);
+	ret = !strcmp("true", out.buf);
+	strbuf_release(&out);
+	return ret;
+}
+
 int cmd_stash(int argc, const char **argv, const char *prefix)
 {
 	int i = -1;
@@ -1524,6 +1545,20 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	if (!use_builtin_stash()) {
+		const char *path = mkpath("%s/git-legacy-stash",
+					  git_exec_path());
+
+		if (sane_execvp(path, (char **)argv) < 0)
+			die_errno(_("could not exec %s"), path);
+		else
+			BUG("sane_execvp() returned???");
+	}
+
+	prefix = setup_git_directory();
+	trace_repo_setup(prefix);
+	setup_work_tree();
+
 	git_config(git_diff_basic_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
diff --git a/git-stash.sh b/git-legacy-stash.sh
similarity index 97%
rename from git-stash.sh
rename to git-legacy-stash.sh
index 789ce2f41d..8a8c4a9270 100755
--- a/git-stash.sh
+++ b/git-legacy-stash.sh
@@ -80,6 +80,28 @@ clear_stash () {
 	fi
 }
 
+maybe_quiet () {
+	case "$1" in
+	--keep-stdout)
+		shift
+		if test -n "$GIT_QUIET"
+		then
+			eval "$@" 2>/dev/null
+		else
+			eval "$@"
+		fi
+		;;
+	*)
+		if test -n "$GIT_QUIET"
+		then
+			eval "$@" >/dev/null 2>&1
+		else
+			eval "$@"
+		fi
+		;;
+	esac
+}
+
 create_stash () {
 
 	prepare_fallback_ident
@@ -112,15 +134,18 @@ create_stash () {
 	done
 
 	git update-index -q --refresh
-	if no_changes "$@"
+	if maybe_quiet no_changes "$@"
 	then
 		exit 0
 	fi
 
 	# state of the base commit
-	if b_commit=$(git rev-parse --verify HEAD)
+	if b_commit=$(maybe_quiet --keep-stdout git rev-parse --verify HEAD)
 	then
 		head=$(git rev-list --oneline -n 1 HEAD --)
+	elif test -n "$GIT_QUIET"
+	then
+		exit 1
 	else
 		die "$(gettext "You do not have the initial commit yet")"
 	fi
@@ -315,7 +340,7 @@ push_stash () {
 	test -n "$untracked" || git ls-files --error-unmatch -- "$@" >/dev/null || exit 1
 
 	git update-index -q --refresh
-	if no_changes "$@"
+	if maybe_quiet no_changes "$@"
 	then
 		say "$(gettext "No local changes to save")"
 		exit 0
@@ -370,6 +395,9 @@ save_stash () {
 	while test $# != 0
 	do
 		case "$1" in
+		-q|--quiet)
+			GIT_QUIET=t
+			;;
 		--)
 			shift
 			break
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 378928518b..10d9764185 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -101,6 +101,7 @@ $LONG_USAGE")"
 	case "$1" in
 		-h)
 		echo "$LONG_USAGE"
+		case "$0" in *git-legacy-stash) exit 129;; esac
 		exit
 	esac
 fi
diff --git a/git.c b/git.c
index 8a20909eae..591ebe9409 100644
--- a/git.c
+++ b/git.c
@@ -554,7 +554,12 @@ static struct cmd_struct commands[] = {
 	{ "show-index", cmd_show_index },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
+	/*
+	 * NEEDSWORK: Until the builtin stash is thoroughly robust and no
+	 * longer needs redirection to the stash shell script this is kept as
+	 * is, then should be changed to RUN_SETUP | NEED_WORK_TREE
+	 */
+	{ "stash", cmd_stash },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
-- 
2.20.1.441.g764a526393

