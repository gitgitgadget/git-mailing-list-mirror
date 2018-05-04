Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E7D200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeEDPes (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:34:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:33979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751343AbeEDPep (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:34:45 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MbaS9-1ew7sF1hEz-00IzN2; Fri, 04 May 2018 17:34:36 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/18] Add a new builtin: branch-diff
Date:   Fri,  4 May 2018 17:34:32 +0200
Message-Id: <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SqQzQL05axMvQKhIB0vCA0uoFnoZma/ttL2dVr7reHasLvTAmD9
 /b5IJPttRdoskEf5NI7EhAShUsz4Z6pRw8lEK3hczdyiptDmis2erKld1dWsYIq1qeM8lHq
 yfRECXSM2eO6jDAi6y0qdP9IkwvkEC6SFd2xJkKjRMOxHgEi49xeG4pzmd61WlGkYurTRnd
 yDp8bz1qoU0hdtatdoPJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yuEQPXbpCVA=:1JCdD4BXt7ZuYkdk/9nQJm
 kAV29veY1U1YLdhUsPm/pFcZLZNjRBjo2W0mKWiKVMzEuTBaf/wQkEUCWoNn2i6UQ1TTnKSSD
 lfRh1jVYJBNGj0Hrc4sxAZSyQLeRz/sm66p0opw5Z8vUU46WbJClerdhd3JhHUgREzT1wS1Kk
 z4SbZYo5j0WOf3uqCBQG9GbyEblWsNQqEQ+P6Cnxzmn622FySK1I3StSqJ0Xn34Tl1DoVpCiQ
 9120jmNZR16pI6FGBaGbpO/tbuIuoohBR4yFjEJclOm+S0kY5qu4kE7yFg/bZ4m9h7fUKLWal
 x455xwdDecdIYmt83UQieBMfYyd75OX5dd0gb0lBt2f3GD8hFgNwPzv4LDn3iB30HNhhhLH/d
 9hePua7fKzgrYdaESWZRvlrZdbjcTHZGJ9o635KJzc8vBizchdHp0SGMh6Kp3bpfTfORxHOQc
 YwVv5VuesDfi23Xof1iuZQ3pxycA26KWQNx0Gw/Y2p//Py9KSGFuAmkjo/rg8Fzd13gl5aSWq
 qAIkA1n5t3GCWHhDMk1rP5w7/Ck3OrJqfRl4TnkL1Rq/VMZrQFuzb9K4x1jNVDfBPuz6IqDNf
 +bRooiIveCt4W+GY8T4Z/b2tNyMAmMjujKW1pqI77N4tZ1Psm9R3WImgQ6EnTuSOBnRvKduEQ
 oTNEgNyTk7+GyDKAVPuXgjD9q1ICuOoAbf/rZZ2RGfLNNo509v8yHOFFev9O07r/ZNw5RqP88
 8HG3xQEmTxQQhcQbydwlSvPeP7zcUR6HpWagruV7gFSju+qqF7FMDaN3Vy5sFdkyKoip0FNp7
 YLSuwmK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This builtin does not do a whole lot so far, apart from showing a usage
that is oddly similar to that of `git tbdiff`. And for a good reason:
the next commits will turn `branch-diff` into a full-blown replacement
for `tbdiff`.

At this point, we ignore tbdiff's color options as well as the
--no-patches option, as they will all be implemented later using
diff_options.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore            |  1 +
 Makefile              |  1 +
 builtin.h             |  1 +
 builtin/branch-diff.c | 38 ++++++++++++++++++++++++++++++++++++++
 command-list.txt      |  1 +
 git.c                 |  1 +
 6 files changed, 43 insertions(+)
 create mode 100644 builtin/branch-diff.c

diff --git a/.gitignore b/.gitignore
index 833ef3b0b78..1346a64492f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,6 +20,7 @@
 /git-bisect--helper
 /git-blame
 /git-branch
+/git-branch-diff
 /git-bundle
 /git-cat-file
 /git-check-attr
diff --git a/Makefile b/Makefile
index 96f2e76a904..9b1984776d8 100644
--- a/Makefile
+++ b/Makefile
@@ -953,6 +953,7 @@ BUILTIN_OBJS += builtin/archive.o
 BUILTIN_OBJS += builtin/bisect--helper.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
+BUILTIN_OBJS += builtin/branch-diff.o
 BUILTIN_OBJS += builtin/bundle.o
 BUILTIN_OBJS += builtin/cat-file.o
 BUILTIN_OBJS += builtin/check-attr.o
diff --git a/builtin.h b/builtin.h
index 42378f3aa47..e1c4d2a529a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -135,6 +135,7 @@ extern int cmd_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_blame(int argc, const char **argv, const char *prefix);
 extern int cmd_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_branch_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_bundle(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout(int argc, const char **argv, const char *prefix);
diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
new file mode 100644
index 00000000000..60a4b4fbe30
--- /dev/null
+++ b/builtin/branch-diff.c
@@ -0,0 +1,38 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+
+static const char * const builtin_branch_diff_usage[] = {
+N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
+N_("git branch-diff [<options>] <old-tip>...<new-tip>"),
+N_("git branch-diff [<options>] <base> <old-tip> <new-tip>"),
+NULL
+};
+
+static int parse_creation_weight(const struct option *opt, const char *arg,
+				 int unset)
+{
+	double *d = opt->value;
+	if (unset)
+		*d = 0.6;
+	else
+		*d = atof(arg);
+	return 0;
+}
+
+int cmd_branch_diff(int argc, const char **argv, const char *prefix)
+{
+	double creation_weight = 0.6;
+	struct option options[] = {
+		{ OPTION_CALLBACK,
+			0, "creation-weight", &creation_weight, N_("factor"),
+			N_("Fudge factor by which creation is weighted [0.6]"),
+			0, parse_creation_weight },
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			builtin_branch_diff_usage, 0);
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index a1fad28fd82..d01b9063e81 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -19,6 +19,7 @@ git-archive                             mainporcelain
 git-bisect                              mainporcelain           info
 git-blame                               ancillaryinterrogators
 git-branch                              mainporcelain           history
+git-branch-diff                         mainporcelain
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
diff --git a/git.c b/git.c
index f598fae7b7a..d2794fb6f5d 100644
--- a/git.c
+++ b/git.c
@@ -377,6 +377,7 @@ static struct cmd_struct commands[] = {
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
+	{ "branch-diff", cmd_branch_diff, RUN_SETUP | USE_PAGER },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
-- 
2.17.0.409.g71698f11835


