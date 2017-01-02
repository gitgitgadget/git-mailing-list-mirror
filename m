Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D924205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 16:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932653AbdABQWt (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 11:22:49 -0500
Received: from mout.gmx.net ([212.227.17.22]:57290 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751483AbdABQWt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 11:22:49 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfzEP-1cCAjj2cuz-00NRgU; Mon, 02
 Jan 2017 17:22:38 +0100
Date:   Mon, 2 Jan 2017 17:22:37 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: [PATCH v4 2/4] difftool: add a skeleton for the upcoming builtin
In-Reply-To: <cover.1483373635.git.johannes.schindelin@gmx.de>
Message-ID: <9b72680e69429a037879fdab6b8fb2501f1d9c81.1483373635.git.johannes.schindelin@gmx.de>
References: <cover.1480019834.git.johannes.schindelin@gmx.de> <cover.1483373635.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:v0DUUOSQsJBvs8zK8cO7KsyBSF5QRQZA0EFprUtA/42zg7obAIo
 JCD4M7E7mxDts9gjsANFZjf7jhNgH0RtsGGPn3vEiOYZO8stRDcWVfvLlWWwRxYF+JTWAK+
 1AoM46wG58M+PqDxC/d9CssrZgCqWh1h4CI0u+XQy91MvPjOl5VxdeTj4pybph9URHhHMZn
 2rZEd7JMTzzSPxa02F1MQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ucc8DPe5kCU=:WDxlwZ3vcmTNQIdqi3HIWK
 +Y/wzlefpnajZeob0n2mGeZKW+mORopn5fJAwOQ4wbxkSFoTvGZ11HYRzjfkXM0DJK70mlxQE
 QlmKI2JiOk4OUrZVmkwPZLbwrol24r3p5ZIqlq6Zh0uTHk54MM1SWftfwnHH1wlToLPEk169z
 76Ok/kiS+h5XBgEH4vS9uNc0VeIIu4SnNxLHoRLZAy3WnAXcK4j5PN7rIRw8GlPAoekpkM9F1
 mlNXxWRb1V2tMnFDbQcYuqUA6199xVfSnkQvdqEkwJshGGGcU+FdVF6qoKGKVtPpCGUCdOvKs
 pDZsCoOCyUiF/w6jgPyyaLD8nIwl8lZl10ajKz8yLqnP6Uu9nwMCbC8EGwjt+kJrFBr7JdGDY
 Z0BxXEtQLmNxsnCA5rIsveLADFhOsjDKMchfpBiVuujTOXngqNV/P4qYjLruwvjhjLkn6qFNs
 y7UnHPYNmKXeDT8u20mNpFzR1hp6NrQkcDoqs5lv4zrXv+FkJHRgVPWiUHJXIdLSo8yHu4gsm
 ll70g69EyMC90ZX9dhMEDo982M2Fl6eOcdcxDJpSBeqgJUhG+cTukBmczFqxyTPNS7WVegu/A
 YpJI+X6v4N+VrqJoy3LDuJTSkmrySp0R7F8T2b2QIY3lZchEGpZwXAfnihR/bVUWxU1pYYGqM
 tgbXNIarXlDOdz3mFH0taTjbpAN7e/LqRRxq7wuWxegj2HERIO5ijauuB0BgMCgH4Tj1HYFB+
 i/sjDiHpDBeMp50pQKix5ZNMTTxWNZNH5D6ZlGeTvK6EtxTDE7Frr/8UH44oQAZ+YIZZhszgM
 ydmBh5R93pvbawqTS3snN7iLPQvwg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a builtin difftool that still falls back to the legacy Perl
version, which has been renamed to `legacy-difftool`.

The idea is that the new, experimental, builtin difftool immediately hands
off to the legacy difftool for now, unless the config variable
difftool.useBuiltin is set to true.

This feature flag will be used in the upcoming Git for Windows v2.11.0
release, to allow early testers to opt-in to use the builtin difftool and
flesh out any bugs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                                    |  1 +
 Makefile                                      |  3 +-
 builtin.h                                     |  1 +
 builtin/difftool.c                            | 63 +++++++++++++++++++++++++++
 git-difftool.perl => git-legacy-difftool.perl |  0
 git.c                                         |  6 +++
 t/t7800-difftool.sh                           |  2 +
 7 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 builtin/difftool.c
 rename git-difftool.perl => git-legacy-difftool.perl (100%)

diff --git a/.gitignore b/.gitignore
index 6722f78f9a..5555ae025b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -76,6 +76,7 @@
 /git-init-db
 /git-interpret-trailers
 /git-instaweb
+/git-legacy-difftool
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Makefile b/Makefile
index d861bd9985..8cf5bef034 100644
--- a/Makefile
+++ b/Makefile
@@ -522,7 +522,7 @@ SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
 
 SCRIPT_PERL += git-add--interactive.perl
-SCRIPT_PERL += git-difftool.perl
+SCRIPT_PERL += git-legacy-difftool.perl
 SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
 SCRIPT_PERL += git-cvsimport.perl
@@ -883,6 +883,7 @@ BUILTIN_OBJS += builtin/diff-files.o
 BUILTIN_OBJS += builtin/diff-index.o
 BUILTIN_OBJS += builtin/diff-tree.o
 BUILTIN_OBJS += builtin/diff.o
+BUILTIN_OBJS += builtin/difftool.o
 BUILTIN_OBJS += builtin/fast-export.o
 BUILTIN_OBJS += builtin/fetch-pack.o
 BUILTIN_OBJS += builtin/fetch.o
diff --git a/builtin.h b/builtin.h
index b9122bc5f4..67f80519da 100644
--- a/builtin.h
+++ b/builtin.h
@@ -60,6 +60,7 @@ extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
 extern int cmd_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_difftool(int argc, const char **argv, const char *prefix);
 extern int cmd_fast_export(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
diff --git a/builtin/difftool.c b/builtin/difftool.c
new file mode 100644
index 0000000000..53870bbaf7
--- /dev/null
+++ b/builtin/difftool.c
@@ -0,0 +1,63 @@
+/*
+ * "git difftool" builtin command
+ *
+ * This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
+ * git-difftool--helper script.
+ *
+ * This script exports GIT_EXTERNAL_DIFF and GIT_PAGER for use by git.
+ * The GIT_DIFF* variables are exported for use by git-difftool--helper.
+ *
+ * Any arguments that are unknown to this script are forwarded to 'git diff'.
+ *
+ * Copyright (C) 2016 Johannes Schindelin
+ */
+#include "builtin.h"
+#include "run-command.h"
+#include "exec_cmd.h"
+
+/*
+ * NEEDSWORK: this function can go once the legacy-difftool Perl script is
+ * retired.
+ *
+ * We intentionally avoid reading the config directly here, to avoid messing up
+ * the GIT_* environment variables when we need to fall back to exec()ing the
+ * Perl script.
+ */
+static int use_builtin_difftool(void) {
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	int ret;
+
+	argv_array_pushl(&cp.args,
+			 "config", "--bool", "difftool.usebuiltin", NULL);
+	cp.git_cmd = 1;
+	if (capture_command(&cp, &out, 6))
+		return 0;
+	strbuf_trim(&out);
+	ret = !strcmp("true", out.buf);
+	strbuf_release(&out);
+	return ret;
+}
+
+int cmd_difftool(int argc, const char **argv, const char *prefix)
+{
+	/*
+	 * NEEDSWORK: Once the builtin difftool has been tested enough
+	 * and git-legacy-difftool.perl is retired to contrib/, this preamble
+	 * can be removed.
+	 */
+	if (!use_builtin_difftool()) {
+		const char *path = mkpath("%s/git-legacy-difftool",
+					  git_exec_path());
+
+		if (sane_execvp(path, (char **)argv) < 0)
+			die_errno("could not exec %s", path);
+
+		return 0;
+	}
+	prefix = setup_git_directory();
+	trace_repo_setup(prefix);
+	setup_work_tree();
+
+	die("TODO");
+}
diff --git a/git-difftool.perl b/git-legacy-difftool.perl
similarity index 100%
rename from git-difftool.perl
rename to git-legacy-difftool.perl
diff --git a/git.c b/git.c
index dce529fcbf..044958a780 100644
--- a/git.c
+++ b/git.c
@@ -424,6 +424,12 @@ static struct cmd_struct commands[] = {
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
 	{ "diff-index", cmd_diff_index, RUN_SETUP },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
+	/*
+	 * NEEDSWORK: Once the redirection to git-legacy-difftool.perl in
+	 * builtin/difftool.c has been removed, this entry should be changed to
+	 * RUN_SETUP | NEED_WORK_TREE
+	 */
+	{ "difftool", cmd_difftool },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 99d4123461..e94910c563 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -23,6 +23,8 @@ prompt_given ()
 	test "$prompt" = "Launch 'test-tool' [Y/n]? branch"
 }
 
+# NEEDSWORK: lose all the PERL prereqs once legacy-difftool is retired.
+
 # Create a file on master and change it on branch
 test_expect_success PERL 'setup' '
 	echo master >file &&
-- 
2.11.0.rc3.windows.1


