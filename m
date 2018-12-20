Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 647A41F405
	for <e@80x24.org>; Thu, 20 Dec 2018 12:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbeLTMJX (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 07:09:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46118 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeLTMJW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 07:09:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so786530pgp.13
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 04:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6Y2WvcczK8cknroo/M285WWWCxDBVS1J4gBLizPfG74=;
        b=vdJjRzHn4cqlhWOxxR/PXTrpjrZTMHjSDUqMZ70sGHMF2De93KpOnQEVD16D3/cn4z
         dW7onxaEE0OS/AHIw88olLexaYJeMqDImmf3O8GWExm+BH2fFF8YQV3dk5IWDE5cUGqs
         o6IVPnaKb0102muaFu3i0X48FTQBfzBEr8eZuL+JtX4QYHuLSZ+u+v8aCc2TCfDHq8by
         7cyRBI9CmFbyo+rLKqvLnQ8gvkY3jZy4C8u8LL/ItgBo6Hw+SrZNG7X6oh93pgkVaDwY
         aJuY1YW/90M+jx4qsUEarzbNAo+0PXFckBaLJ1oI8c31i6i4Uoz+IHy1v/lXEhR5VG9K
         P1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6Y2WvcczK8cknroo/M285WWWCxDBVS1J4gBLizPfG74=;
        b=F/Z1RRiq/25O1fjYDSplXCzjJkRmRI7VCex/F/IFo24bfEeKSr2OSquvC1bN66lJC5
         gbvK3SPAsP+Ahath8TsnbhYb3LYxbw/o8pOBvCxWDVAh2yEyDqPaQ9a8InlDYRbP1QgQ
         BC9s6mCQQdE8InQABjmuAj3ON7+Oe6VseSCLVMbi1frJBeRtkJYo1QF1Xlc8TBmxkxUZ
         pJ0DNH5GuIZixJClFUHX0y2X23vYJNA7flIW80gQDCImx5P93VDSZjHrcaxdehF1MLig
         qVSYsUFvmrJuQARj4T5pHOxfA5GlX+udiwJS+6defCnrXHkJY5u4tcZItRTrXxVOaeo1
         wKrw==
X-Gm-Message-State: AA+aEWbnJ1GoP9KCJZH0w7255P11ZsXID1uBRlH+Uda5bsaY3rs2KwlJ
        7+C1kxR86cceX0R2/rYABYHr0oV0
X-Google-Smtp-Source: AFSGD/UKJzqpBpvgCUjSDNwEyNtG09nTf2PiW4WA/IYc/U/blKbM6eJcKRVbMgTEKX2b4Ln1GLXG3w==
X-Received: by 2002:a63:9e19:: with SMTP id s25mr22940603pgd.203.1545307761466;
        Thu, 20 Dec 2018 04:09:21 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id p67sm36029104pfg.44.2018.12.20.04.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:09:20 -0800 (PST)
Date:   Thu, 20 Dec 2018 04:09:20 -0800 (PST)
X-Google-Original-Date: Thu, 20 Dec 2018 12:09:09 GMT
Message-Id: <91b1963125f7dfdd46fe5166125ee59ef2557b13.1545307756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/7] add--helper: create builtin helper for interactive add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

Create a builtin helper for git-add--interactive, which right now is not
able to do anything.

This is the first step in an effort to convert git-add--interactive.perl
to a C builtin, in search for better portability, expressibility and
performance (specially on non-POSIX systems like Windows).

Additionally, an eventual complete port of git-add--interactive would
remove the last "big" Git script to have Perl as a dependency, allowing
most Git users to have a NOPERL build running without big losses.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 .gitignore            | 1 +
 Makefile              | 1 +
 builtin.h             | 1 +
 builtin/add--helper.c | 6 ++++++
 git.c                 | 1 +
 5 files changed, 10 insertions(+)
 create mode 100644 builtin/add--helper.c

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..2ee71ed217 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,6 +15,7 @@
 /git
 /git-add
 /git-add--interactive
+/git-add--helper
 /git-am
 /git-annotate
 /git-apply
diff --git a/Makefile b/Makefile
index 1a44c811aa..9c84b80739 100644
--- a/Makefile
+++ b/Makefile
@@ -1023,6 +1023,7 @@ LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
+BUILTIN_OBJS += builtin/add--helper.o
 BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
diff --git a/builtin.h b/builtin.h
index 6538932e99..dd811ef7d5 100644
--- a/builtin.h
+++ b/builtin.h
@@ -128,6 +128,7 @@ extern void setup_auto_pager(const char *cmd, int def);
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
+extern int cmd_add__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_am(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
diff --git a/builtin/add--helper.c b/builtin/add--helper.c
new file mode 100644
index 0000000000..6a97f0e191
--- /dev/null
+++ b/builtin/add--helper.c
@@ -0,0 +1,6 @@
+#include "builtin.h"
+
+int cmd_add__helper(int argc, const char **argv, const char *prefix)
+{
+	return 0;
+}
diff --git a/git.c b/git.c
index 2f604a41ea..5507591f2e 100644
--- a/git.c
+++ b/git.c
@@ -443,6 +443,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "add--helper", cmd_add__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
 	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
-- 
gitgitgadget

