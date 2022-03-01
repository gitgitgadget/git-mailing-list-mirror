Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634D8C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbiCASo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiCASo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DAE2B26E
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bk29so4649655wrb.4
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3PLwCteJ9y2IKK4YgyfW1TpJLAFrB0rwJ1mFNfWqUuM=;
        b=ZWVf0P6Faq+EExttFjy3gJ8sB+/PIYdgQkJerRYu3zFi4IRYr0NY8Y2uCog9knVZA+
         x1Nj9xLAb+lBHY2IkYhqtf8FFp6Tvg1tKZUGYHtMZA1H4cFEBQzpdCnT++8uOwF3SbK4
         xdqs1kouJCuI6oIT2QsQslAEUlYL/+jpbRPNX56rXQSQzK9ql118Apilq5VrYV7er3XM
         f3ijycmLKeMcBccV3GBiXUs9VnjWcOTU+xlLaVaDHAhc05b8W9FZkJrwaROWEzGa4g0k
         dzlnL1/LFAt4f5WTsh4zJbqf8qPBs32AQ/Cyo8k2tYE3s+jgiTWY6CC1+JLR/Ic6VxCm
         1OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3PLwCteJ9y2IKK4YgyfW1TpJLAFrB0rwJ1mFNfWqUuM=;
        b=xwkw5g7VCf+08JvyeuxOrli2SAKd4Zq+SYbiRXzJiG1WJmPcM147ihSiWzSFKn/R9i
         knLJI+tuKen/GfqAbuAA93B0gWr3XDWQChwckbG8r5inkJrk0y5AKsoV0vwOFDNomh1H
         Qgs5vtDfQ07OmVXHcoofc5OtFABsx8jAzP8T/Mkhj0tB3ZOoQID0aMh7rikrSh/oh+3B
         rE3hssbGwio4bacPtgEbVB2B6rnVFS/k1s7uOXfngNsn0r1RhNTthB9pZwvyAfLOlhvq
         RTiiyunMN2L1BrQgVl6cjXvo4BAaOj1scwhZurCSVqSztkxAGGWq+yOf9v5u9VdNW8bO
         saMQ==
X-Gm-Message-State: AOAM532guq5BLWbGRHN78tAvfL9JqEIb/8YU5TTMDvtMAMPXwAB3MjwD
        z3QI3dOPCEfmpdbGpYGuHdpGrxGYXy4=
X-Google-Smtp-Source: ABdhPJzakQmAnyZg+CqsZNN9Bycu5XsTygCbnVrD9wWxugyEm1rGSe/4r6Kcueyqbusasmpu8Hu7bg==
X-Received: by 2002:a5d:64c1:0:b0:1e4:987a:51b with SMTP id f1-20020a5d64c1000000b001e4987a051bmr21037059wri.471.1646160220753;
        Tue, 01 Mar 2022 10:43:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600011cf00b001edc2966dd4sm14165452wrx.47.2022.03.01.10.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:40 -0800 (PST)
Message-Id: <3bd7e6a051e7fca1ac2a78e038587de10fd9401a.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:09 +0000
Subject: [PATCH v6 07/30] fsmonitor--daemon: implement 'stop' and 'status'
 commands
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

Implement `stop` and `status` client commands to control and query the
status of a `fsmonitor--daemon` server process (and implicitly start a
server process if necessary).

Later commits will implement the actual server and monitor the file
system.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsmonitor--daemon.c | 51 +++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index f0498793379..5e3178b8bdd 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -7,10 +7,55 @@
 #include "khash.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
+	N_("git fsmonitor--daemon stop"),
+	N_("git fsmonitor--daemon status"),
 	NULL
 };
 
 #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+/*
+ * Acting as a CLIENT.
+ *
+ * Send a "quit" command to the `git-fsmonitor--daemon` (if running)
+ * and wait for it to shutdown.
+ */
+static int do_as_client__send_stop(void)
+{
+	struct strbuf answer = STRBUF_INIT;
+	int ret;
+
+	ret = fsmonitor_ipc__send_command("quit", &answer);
+
+	/* The quit command does not return any response data. */
+	strbuf_release(&answer);
+
+	if (ret)
+		return ret;
+
+	trace2_region_enter("fsm_client", "polling-for-daemon-exit", NULL);
+	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+		sleep_millisec(50);
+	trace2_region_leave("fsm_client", "polling-for-daemon-exit", NULL);
+
+	return 0;
+}
+
+static int do_as_client__status(void)
+{
+	enum ipc_active_state state = fsmonitor_ipc__get_state();
+
+	switch (state) {
+	case IPC_STATE__LISTENING:
+		printf(_("fsmonitor-daemon is watching '%s'\n"),
+		       the_repository->worktree);
+		return 0;
+
+	default:
+		printf(_("fsmonitor-daemon is not watching '%s'\n"),
+		       the_repository->worktree);
+		return 1;
+	}
+}
 
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
@@ -28,6 +73,12 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_fsmonitor__daemon_usage, options);
 	subcmd = argv[0];
 
+	if (!strcmp(subcmd, "stop"))
+		return !!do_as_client__send_stop();
+
+	if (!strcmp(subcmd, "status"))
+		return !!do_as_client__status();
+
 	die(_("Unhandled subcommand '%s'"), subcmd);
 }
 
-- 
gitgitgadget

