Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3261F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeCQHzf (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:55:35 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36923 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbeCQHzd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:33 -0400
Received: by mail-lf0-f67.google.com with SMTP id y19-v6so18545236lfd.4
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rC2M8vsUg8Ls5ljU+7qATr6Qn81pr5njhaZxkghmBcQ=;
        b=msrcRBFGNoO65H2birrZ1jYLJy1j4JZxEO4/rx8TcYpixwdRHr5fO1HHPtZTBbBrNQ
         Y+PR3xWOLlq44FCBje7tOLl7D6xtZpiMxHXFypJUvoongYg8ufrVl3FOqEbzfChjIGtx
         Iu4NwzISgvuVEqE66XWXY60/8/8nibdic7mbeoqhkJS8u75CjUi9LjVrUAqcxQwXQDnT
         CV8IitT2IRqongNUsMSWDyk992DfrPZP270C9tFaVPB6cMGsBE0KIruwtJJx4cfmb80f
         ylGTbTWQ/AA71NBc/DGUb/hEZKheEOTVQO+g/Y94m0nAjuQUWNLaEvnUkGXXoh4L4YKw
         Upow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rC2M8vsUg8Ls5ljU+7qATr6Qn81pr5njhaZxkghmBcQ=;
        b=mJzDYI9poDUNVcj2Elp1pvPp4/DVWUkDlCGHsJzlvsV7Diyctu3a9SmzUGJVJrbZMt
         fQKsTg60YIqEMsTn44uft26dEQVSAVu/Ju+VB3p3XjXZRtCWqjepaMm6M/mBVd5ObsKY
         3GZDM7H7LW1IooBSvoBsud3pYu+63zKBX7IB7yOmUgb8vwQp3OcUu31sQ30egUkXR/tV
         9ud1uKmE20/YUXXxShlQvxz85H1itrl0Kk72PnI6Ks03Cedyk43rCpg0fADNAP/oxJGi
         PWj00Iel+qGRyY4YA8ol0bRpyTKQyPudX7MPsL5d2BZzy2ZBwx24d+wVk97/6G2sdeR5
         wwQA==
X-Gm-Message-State: AElRT7GdsEXRz4MN5MG5J3p0NP2cP4LTLHP+nIh1iw5qpkT36sHZ9tOV
        ik2HF3xygBOBo8fPkrFwkj8rNg==
X-Google-Smtp-Source: AG47ELvdA34bgUY+PfQE8PSOkBqOnUpKOFpLlDtn1hjP+nSMmoIybe7YGo9xuq+V6cbwSPfz9MmJQQ==
X-Received: by 2002:a19:14d1:: with SMTP id 78-v6mr3438199lfu.37.1521273331750;
        Sat, 17 Mar 2018 00:55:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/36] t/helper: add an empty test-tool program
Date:   Sat, 17 Mar 2018 08:53:46 +0100
Message-Id: <20180317075421.22032-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180317075421.22032-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will become an umbrella program that absorbs most [1] t/helper
programs in. By having a single executable binary we reduce disk usage
(libgit.a is replicated by every t/helper program) and shorten link
time a bit.

Running "make --jobs=1; du -sh t/helper" with ccache fully populated,
it takes 27 seconds and 277MB at the beginning of this series, 17
seconds and 42MB at the end.

[1] There are a couple programs that will not become part of
    test-tool: test-line-buffer and test-svn-fe have extra
    dependencies and test-fake-ssh's program name has to be a single
    word for some ssh tests.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile             |  6 +++++-
 t/helper/test-tool.c | 27 +++++++++++++++++++++++++++
 t/helper/test-tool.h |  4 ++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-tool.c
 create mode 100644 t/helper/test-tool.h

diff --git a/Makefile b/Makefile
index a1d8775adb..2376646e98 100644
--- a/Makefile
+++ b/Makefile
@@ -546,6 +546,7 @@ SCRIPT_PERL =
 SCRIPT_PYTHON =
 SCRIPT_SH =
 SCRIPT_LIB =
+TEST_BUILTINS_OBJS =
 TEST_PROGRAMS_NEED_X =
 
 # Having this variable in your environment would break pipelines because
@@ -690,6 +691,7 @@ TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-submodule-config
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
+TEST_PROGRAMS_NEED_X += test-tool
 TEST_PROGRAMS_NEED_X += test-urlmatch-normalization
 TEST_PROGRAMS_NEED_X += test-wildmatch
 
@@ -2083,7 +2085,7 @@ VCSSVN_OBJS += vcs-svn/fast_export.o
 VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
 
-TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS))
+TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	$(XDIFF_OBJS) \
 	$(VCSSVN_OBJS) \
@@ -2494,6 +2496,8 @@ t/helper/test-svn-fe$X: $(VCSSVN_LIB)
 
 .PRECIOUS: $(TEST_OBJS)
 
+t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
+
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
new file mode 100644
index 0000000000..c730f718ca
--- /dev/null
+++ b/t/helper/test-tool.c
@@ -0,0 +1,27 @@
+#include "git-compat-util.h"
+#include "test-tool.h"
+
+struct test_cmd {
+	const char *name;
+	int (*main)(int argc, const char **argv);
+};
+
+static struct test_cmd cmds[] = {
+};
+
+int cmd_main(int argc, const char **argv)
+{
+	int i;
+
+	if (argc < 2)
+		die("I need a test name!");
+
+	for (i = 0; i < ARRAY_SIZE(cmds); i++) {
+		if (!strcmp(cmds[i].name, argv[1])) {
+			argv++;
+			argc--;
+			return cmds[i].main(argc, argv);
+		}
+	}
+	die("There is no test named '%s'", argv[1]);
+}
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
new file mode 100644
index 0000000000..6ce57ae0cc
--- /dev/null
+++ b/t/helper/test-tool.h
@@ -0,0 +1,4 @@
+#ifndef __TEST_TOOL_H__
+#define __TEST_TOOL_H__
+
+#endif
-- 
2.16.2.903.gd04caf5039

