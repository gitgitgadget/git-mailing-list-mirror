Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701EDC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346990AbiCXQvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351834AbiCXQvj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:51:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E988AF1EE
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:49:59 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r7so3102225wmq.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3PLwCteJ9y2IKK4YgyfW1TpJLAFrB0rwJ1mFNfWqUuM=;
        b=AAa/gttOYajwriiaB51BORwLY+gXgovKiCnavmQREhuoOBK9STSmEzIUjVYQTXbPGa
         capsGNPNMGpDKLH5oNwjQT8ctNpqMrvUy5K9NHmxeQvZx0qcLUD5aksqaSMsi/CWO6I5
         C+dMnIqHJn28NHUtkZNMvy6TlXGd8AtiDsR8mV7r6jpF9nm7w0IdazKDKNrvbgw7WSb2
         p+yzsyrqdciCrWurXj/6KrXi9xmbJIH04YOKhwe9YQOP/04vhGy7Ugj9oXtBvxWZOCOG
         1fEAWlO+W7EBi4y5hVtN1SdQ0qi3+M6o69QG6MZr2JxOQZMFwD6QfKXKnjIoLecrf1PO
         iBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3PLwCteJ9y2IKK4YgyfW1TpJLAFrB0rwJ1mFNfWqUuM=;
        b=QE26uj7XDSbc6WaTg81J0iOGK0lt+3PbFk8iEFUT+NF0GGgL892E8STPFXOayGD7+S
         mp2t2vZZ/SqZfjrVyYF6apnT5d8qDthW7NwSTqEwgfSj6yU/RhX9HSLM84KpMvRq9Ttd
         x5tQlCt/BuP9QUgG5Z6LLEnhNzQ6Hz6wXwsVMWeT+WyIsDJAa2VLPtQ8NmLRlGNOmzkj
         1xXaGNqfGf/pGvlOM8/62wRS/hffB2/OYKziQDMjiC+QJzcroalg83juic4+k9aEjCEH
         JiQStslAc13nVvQTe8VQmPLmZYUVqNqxR30hsGcoYtPd+sz8u7uyLFbra5A88v8AE60z
         OOcQ==
X-Gm-Message-State: AOAM530iZEe6ejuKaVYc/II8n26vuFiO8kkwJucGbnlCK8BLCLzQFRcE
        614fMIMVWNg1qm51uSNAOI47ca3knhU=
X-Google-Smtp-Source: ABdhPJwbUCrumuoLTd38Roy1gn1VN7YEo6rsA26zrQnxEG69mj4eSmdEoUVouYvWeKtgkh+0TVi14Q==
X-Received: by 2002:a1c:f312:0:b0:387:8bf:bd3 with SMTP id q18-20020a1cf312000000b0038708bf0bd3mr5571374wmq.112.1648140597707;
        Thu, 24 Mar 2022 09:49:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10-20020adfe94a000000b002059e530da1sm393552wrn.1.2022.03.24.09.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:49:57 -0700 (PDT)
Message-Id: <4624ce2fa471b3ebb3a08baf0de2609447eb9fe3.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:23 +0000
Subject: [PATCH v8 07/30] fsmonitor--daemon: implement 'stop' and 'status'
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

