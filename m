Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3DFC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbiCVSCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbiCVSB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:01:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C966202
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so3770342wmb.4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3PLwCteJ9y2IKK4YgyfW1TpJLAFrB0rwJ1mFNfWqUuM=;
        b=QVU7wX+890yPqvZgp1BbmNU6Mukb0z+LXQ8uYo+uSafvVy3mREUX4LEUA+6TnW6Zme
         RRHTQjD6OrbED7s3z7czumWvZh8UxUFVEy8AMqRxsUo8Lv2yvHTak0172dHEQKSw8kRg
         wLXxXg0IKFsGpfYrGq3Wbw2bfUbO3XVmAr3CKDJH7gwO8a/ip3lW0lZmcBIguilpHPau
         mcpWlylgrSSfMN9PyDudglq9WXtPmOnF3S6eX1XGYMuMtVjgIYPuMdBfhdP9C3iECX0X
         CX5Qq5eokZWBqgBVTxrYcT4XjZqCWlQwha/2oMAlGqjJCLq4ER4buybeZVhi3TnExkUK
         ICsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3PLwCteJ9y2IKK4YgyfW1TpJLAFrB0rwJ1mFNfWqUuM=;
        b=Is0SWH4gOAnilqWDhpSJo/781/jd2WgPHd3rtZMxyYZW439oTfqfIzWLJFTgppAU0H
         U4J3Nie6GORCp4neAI9zrMX9sSVwNOv5IY+72jSHKYMG97i2Y/Z6JlEhe06a9q5Ag4Z4
         h4kfqir3acsgZfWUY/6SRQKMsAHXdHGhAPizPeHPgqJAFfS3PTh/2TBHUwWN/PIjNfxR
         j0iicB5yjNnlUcVbDUePuJpT5kQLdgmx5IIybS/99FotIrT0fLK7/8r5o2Mx6MUXJres
         oax5imPW0qRZtOSla7RYe6eRRZDgXodgMDcyGTNsazWJOQ4YX9Rg2C8gbvO1RM5MvhL5
         jpnA==
X-Gm-Message-State: AOAM532e3svw/XIqqW4bcn+4eLsql5h+E8Bq4aIO/7GRPw77VQRDl1jY
        Fc/436UvoII9FDd0KJL4z/KDfbB4VcU=
X-Google-Smtp-Source: ABdhPJzgQCjkaA3p5UbHpPEb4vaIwb0vpmn9/GMM28Uadj4Xst1MtJjhs6f21WZ16Zxj0OL0/o+iYw==
X-Received: by 2002:a1c:2c2:0:b0:38c:835a:10fd with SMTP id 185-20020a1c02c2000000b0038c835a10fdmr4908714wmc.73.1647972027423;
        Tue, 22 Mar 2022 11:00:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b0038cc1acc02fsm11029wmg.24.2022.03.22.11.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:26 -0700 (PDT)
Message-Id: <4624ce2fa471b3ebb3a08baf0de2609447eb9fe3.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:48 +0000
Subject: [PATCH v7 07/29] fsmonitor--daemon: implement 'stop' and 'status'
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

