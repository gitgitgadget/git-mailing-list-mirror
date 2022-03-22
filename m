Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5709C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbiCVSCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbiCVSB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:01:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F67D65D14
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j18so14918009wrd.6
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qHwl1k+mT7kL/vCpcTSTxB1s0NWzJtpH1afNGYRMp+8=;
        b=BkdW+XeWu5vN5dDYZ9p7wTDLH+ybe+kd/A41r4rtLi/2Ds6BeSS1uXNZIYz0p9qHdQ
         ABTYs3deHWAPizmy5tR/NIBkXLO/zH6zzZd3fSIRczwKwbpdc1o5P2bPnVtjwccIjMz4
         mrnFZAnux/5rVFXxpgv6T0INNOVFS3SPLCIIPO4TXxU8TRjembmYlBAP+mn2WZhAZ1Im
         pN7+QHp/TyMf/UFJkd3/WmWdEJEeHVTMLaBYrUeYrPHls9Hy4EpgrqpCYb7oYAtEybHG
         WFNgEyoRxQONdQ4eqmyKFRYMJXOhKa8qq1U6lqQqJbXci+877d2Zo/HKaR8OVrnyO+EX
         Vh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qHwl1k+mT7kL/vCpcTSTxB1s0NWzJtpH1afNGYRMp+8=;
        b=JerGWnb18MXHK3UUaUStEp8nmOq5DSa/Tpgmx1t6D3chPnZVdugVcrGE87ZhUdbMEu
         L3Fixo/yiHqPLjH5BCSvEfSMNHEhZYN45u/5GgBuS6YpJ+gnE3WKVRGC/72jnFX5BI4g
         IF5nDSv9iDu/VHaDC49I0lZSo0ifEzsjfavpfg6NTEOp2CtlvYr72KvQyeeeScY6Sj5O
         CLDlsleeFhFvDS6AYtQacJWSY8NYmimpLWYKu8SMeBjDOUHzgVVJd9suHo7kkkfOcLTy
         vf1b22dtRqo9zay9JPltHKuou1xnB1UVcGrDX/63Y40C0STWpfcgIJ83M4Nzeb0QRbKP
         48+w==
X-Gm-Message-State: AOAM530oZvPj6GiyiM9gH5CTTlN4vuJnewrb8aAv5gDkqo32VRxHbUne
        TAgbcSzbKV8f6r8iDero5h/Os9x6Z2c=
X-Google-Smtp-Source: ABdhPJwaCbIqeKc14HsuIs40+UPEmlWG83hQMkbCAhqLE/K+hXLjxiMFu+W2d4tnDMQu7O5B/UgyCQ==
X-Received: by 2002:adf:da50:0:b0:204:7d8:b654 with SMTP id r16-20020adfda50000000b0020407d8b654mr11869803wrl.607.1647972025682;
        Tue, 22 Mar 2022 11:00:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6b43000000b001e317fb86ecsm16720210wrw.57.2022.03.22.11.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:25 -0700 (PDT)
Message-Id: <0ce8ae3f2cf07bfffdb1cb14454768d2b6d84bf2.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:47 +0000
Subject: [PATCH v7 06/29] fsmonitor--daemon: add a built-in fsmonitor daemon
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
        Tao Klerks <tao@klerks.biz>,
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

