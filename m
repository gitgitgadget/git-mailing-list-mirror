Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9744C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiCYTe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiCYTde (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:33:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E0228D2D
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:08:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 5so14938116lfp.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qHwl1k+mT7kL/vCpcTSTxB1s0NWzJtpH1afNGYRMp+8=;
        b=ga6Gcxxfj/lJznBqbyVFgb81z7t8ZrWzwRBh1qZZqBBtklJapiLxdcpXFfiIpY4H9U
         04BwrcZvdFbO4pYkXP/2uwrcInWJlxCX7scIWMcXA40ssCMZSSppVSgH15a91qzk6s64
         /CJ+Y1cWml7s79uv/YLnPV+tvNasmOprs3II5B2ndqGu4zZ3GHnTcBmit7q4ZWTzEQr7
         Xx8kxOE1wDRYjVTMLPMK5ZDuPMOFnxW2x4nBps//VZ/q1pSdP28AHf1GFQLySG3ogeAZ
         D3S6OAmpTi+yWJvt1s3ceSJF7PtsrzLSGGODocUanx/SvU3n50KzQuI/XqauMGMHkPvC
         +zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qHwl1k+mT7kL/vCpcTSTxB1s0NWzJtpH1afNGYRMp+8=;
        b=VJXgsdxkxmbPc+zaaGrpH/3ifY87JvKHK67APDE7CixfiCmY9czo/lOTssL5W5kciJ
         R8vmg/phI7Z+r1y8Mld4loeKiseBxMleqtqh6GSHWWGb0Bv3XtmAPyk6rADVaicOCQmX
         JqU56JD7Nt7Oskjnwjxo1f2ToprajD1vo+4Y/BWL/yYptS7fZK7fAPvjkZ5W+pP4A42/
         3UGpGzGquXQczQC7N5ArVFm8cmBpp0SGIO5dXFTA+m36EWxXv87DGzVm6OaMdyzcmpE9
         igQgnLs4w7z0hFsFPvi+RbZBcT7Vc3zMMnSFgpAR0HTo6nZEWusP9KFnfwfAKBpVgMPr
         bTgQ==
X-Gm-Message-State: AOAM53216GGAqhOTDTJKvM6K3IonMSRmAqUF3fpz2G3BFu5r8Hs4emrL
        pPOeGWB4vsUhLrSNYeONPQjuEmojXDo=
X-Google-Smtp-Source: ABdhPJwFw9hjKPw+v935NCRsy6mb0oWQ0vu/0rXhs7sFH1ft/hYAgng8W18u2xKhPsmTF/N/64A5Qw==
X-Received: by 2002:a05:6000:1888:b0:204:1a8b:2999 with SMTP id a8-20020a056000188800b002041a8b2999mr10288723wri.221.1648231402234;
        Fri, 25 Mar 2022 11:03:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000188b00b00204109f7826sm6472903wri.28.2022.03.25.11.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:21 -0700 (PDT)
Message-Id: <0ce8ae3f2cf07bfffdb1cb14454768d2b6d84bf2.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:02:49 +0000
Subject: [PATCH v9 06/30] fsmonitor--daemon: add a built-in fsmonitor daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a built-in file system monitoring daemon that can be used by
the existing `fsmonitor` feature (protocol API and index extension)
to improve the performance of various Git commands, such as `status`.

The `fsmonitor--daemon` feature builds upon the `Simple IPC` API and
provides an alternative to hook access to existing fsmonitors such
as `watchman`.

This commit merely adds the new command without any functionality.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                  |  1 +
 Makefile                    |  1 +
 builtin.h                   |  1 +
 builtin/fsmonitor--daemon.c | 46 +++++++++++++++++++++++++++++++++++++
 git.c                       |  1 +
 5 files changed, 50 insertions(+)
 create mode 100644 builtin/fsmonitor--daemon.c

diff --git a/.gitignore b/.gitignore
index f817c509ec0..e81de1063a4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -72,6 +72,7 @@
 /git-format-patch
 /git-fsck
 /git-fsck-objects
+/git-fsmonitor--daemon
 /git-gc
 /git-get-tar-commit-id
 /git-grep
diff --git a/Makefile b/Makefile
index 707a56d4c11..5af1d5b112e 100644
--- a/Makefile
+++ b/Makefile
@@ -1114,6 +1114,7 @@ BUILTIN_OBJS += builtin/fmt-merge-msg.o
 BUILTIN_OBJS += builtin/for-each-ref.o
 BUILTIN_OBJS += builtin/for-each-repo.o
 BUILTIN_OBJS += builtin/fsck.o
+BUILTIN_OBJS += builtin/fsmonitor--daemon.o
 BUILTIN_OBJS += builtin/gc.o
 BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
diff --git a/builtin.h b/builtin.h
index 83379f3832c..40e9ecc8485 100644
--- a/builtin.h
+++ b/builtin.h
@@ -159,6 +159,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
 int cmd_for_each_repo(int argc, const char **argv, const char *prefix);
 int cmd_format_patch(int argc, const char **argv, const char *prefix);
 int cmd_fsck(int argc, const char **argv, const char *prefix);
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix);
 int cmd_gc(int argc, const char **argv, const char *prefix);
 int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 int cmd_grep(int argc, const char **argv, const char *prefix);
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
new file mode 100644
index 00000000000..f0498793379
--- /dev/null
+++ b/builtin/fsmonitor--daemon.c
@@ -0,0 +1,46 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "simple-ipc.h"
+#include "khash.h"
+
+static const char * const builtin_fsmonitor__daemon_usage[] = {
+	NULL
+};
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
+{
+	const char *subcmd;
+
+	struct option options[] = {
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_fsmonitor__daemon_usage, 0);
+	if (argc != 1)
+		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+	subcmd = argv[0];
+
+	die(_("Unhandled subcommand '%s'"), subcmd);
+}
+
+#else
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+
+	die(_("fsmonitor--daemon not supported on this platform"));
+}
+#endif
diff --git a/git.c b/git.c
index a25940d72e8..3d8e48cf555 100644
--- a/git.c
+++ b/git.c
@@ -537,6 +537,7 @@ static struct cmd_struct commands[] = {
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
 	{ "fsck", cmd_fsck, RUN_SETUP },
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
+	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
-- 
gitgitgadget

