Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327E6C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199F76120F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhJUO1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhJUO1f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED846C061226
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k7so1322610wrd.13
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6enTMMANNAxK1CGL3Ldk/yaPqbhSNHnwYfXVeNCe1iY=;
        b=S+9lHhW3QTLdn14jQhSTcc5fYGXv95LozS/NwauVUGZVxwh4GzojSQp6/OOU+DlIEj
         yWSZpUEvMhiHTFwQUITHVAHucAmuEBD4Ieg6s+nXSnCK0oPAWMWcm32YDIL/ppNUvte6
         kwkLdTYYqOD0618dbfs3p8Fg2d3FgVVhUOOZOBYHDIUiCp9d1sNL7kQh4UHuSiIFZvmI
         zM5KIa/Fs3wuf3TY/2MWEeFLG1OC6zUNLXzynij/fHbVnZ6P2lClgOvU0XdtpsoMARBL
         7zhgagM3+oQj+VEO52Pb6NDTjd3REiZbX+drwjro8UCwfVpe0W5XbVs/HLC8ZgCIma88
         VThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6enTMMANNAxK1CGL3Ldk/yaPqbhSNHnwYfXVeNCe1iY=;
        b=Zygb9+xJcj4ei4TecbSS16tXvjY7JFPjs1x6Q8n9uRmh6IXCt/r8rFqVDP+8l+sTZg
         ZDTZBncuf2mBlwoVv9mn4aM9Ue0If3YK6UiF6CscS5sK1iQV6bLw+jr9GPwXQMv8qDKw
         Qqg+gCAUDFHcPMEb4qLpcAQCqM3KPrF788n5CTTXBmTjr/L0t/7+zazIh5qRa8tvM1tO
         M2K2wGZM140mJZSurLpKtW791PGgIf4Zv82n32lpIu1dHRg8ZPVoaifcLr9ZmVg/7PSV
         Hz1/dJjmn9hkQ8HSZP5hJK17nhD2Q2Xo29xanjWmIc0g+kgCXCNHBtcO64s8TD8t0vNC
         2XFg==
X-Gm-Message-State: AOAM533Fh90kLCdV03BFzDpCxTe/Z5NrMFu7vl7fn8xMCH4C3V3bkGsG
        bBpZXMNgOzTZsx4F/c/TdRP0XQgeZRU=
X-Google-Smtp-Source: ABdhPJyVhwVnapjnvft2Qe3M/OtGb4iPU2N+nNnJKTt6HLrYKk29MheemDF6uXcB23ZKagoUm8NVmg==
X-Received: by 2002:adf:aad4:: with SMTP id i20mr7774231wrc.402.1634826315650;
        Thu, 21 Oct 2021 07:25:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16sm5753314wms.16.2021.10.21.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:15 -0700 (PDT)
Message-Id: <ea64b5c9753ebba0d0f7b4e3d4a2475597f207fa.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:24:47 +0000
Subject: [PATCH v4 07/29] fsmonitor--daemon: implement 'stop' and 'status'
 commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
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

