Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0DDC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351908AbiCXQxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352164AbiCXQxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB029F386
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t11so7487534wrm.5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ekJrkqFg1yJzdNh+egoYJeP3EUXrY0TIhPEKqSMHHf8=;
        b=d/xB9Ojxbo+jDTUQG0e1XDltStQNdNEM884iY6D8UMDmPMLq6DDlfFR9gpZOirvprR
         LQeNfrav1KGhjTFm8KwQ3PbZL+UJ4fHhXLa+lMkWv/SCVEtwoo4DB5/SJcgWhDvvacLl
         ggm2+CBrcznBPbmWY80q71llCPR6XYf1bABF2W5xpFrfhdZt4DbPrcCO66/8tkw7jOdQ
         dTbUwj3qXBKCLmyJ8K8nqpbA1VztLSQl+SCTzIg1i3pyNhu39ZkHL7EzW0RP7OUOT4So
         dDKWyc95/xEZVIVSgmotfqo4EHj8KAvTTrKi4z5bc+iJ9qWW2Tdk/CvE5Fr/kfyT21EX
         rPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ekJrkqFg1yJzdNh+egoYJeP3EUXrY0TIhPEKqSMHHf8=;
        b=C3fCgF1REdgETuN57iDGmOvgaaUEPJAnTZueokdcsSIdd/ARPIRQgOJBOyppVpwGI5
         Y+Gzfo6i6seuA0a4W1Lz5yeyFwzYeEpTPvjb400FOjTxD5hwp9T2k27WFYoInQD0iQ/d
         PsNU1PYZ8GSsQLXvisocEI4aICqBqMjfxjYs3mq0fcFiOHgA4ivrY9R1XNTcF3fb0wGF
         uwqYUp+pKHBHlS/0RVTTQR4PZWH3zjkQGlZzDGKyTmBMvBjX5rWSjJrrcR0pdX1aqO7t
         zzyUOQxIPC5GRe8J7jh7+3lMZ/V6NfDS9t/3dQQE9YS8+cNfbmVSKGORCGPUI4z5xuwo
         9r1Q==
X-Gm-Message-State: AOAM531hpdV02gQ/6d6lUplpgfz/u+aDXcp9aaE63DpYnlJ7Kr7UZ7HA
        Hp1eSr7R0WraJ+o52Vqr+UHQVywKGCE=
X-Google-Smtp-Source: ABdhPJyKvUnD1OmtqJbOiIdVNAvupaM98HGHxx8HKUdN+ugcbjusEbyvSC5Bh5GuWQlJ9fMCa2LsZw==
X-Received: by 2002:a5d:618c:0:b0:204:2f:2c1a with SMTP id j12-20020a5d618c000000b00204002f2c1amr5196632wru.709.1648140690146;
        Thu, 24 Mar 2022 09:51:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b0038a18068cf5sm6339137wmb.15.2022.03.24.09.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:29 -0700 (PDT)
Message-Id: <9ad6d87ccced1020181a80bc7ed92e30d1b23ff3.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:50:59 +0000
Subject: [PATCH v4 06/27] fsmonitor-settings: VFS for Git virtual repos are
 incompatible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

VFS for Git virtual repositories are incompatible with FSMonitor.

VFS for Git is a downstream fork of Git.  It contains its own custom
file system watcher that is aware of the virtualization.  If a working
directory is being managed by VFS for Git, we should not try to watch
it because we may get incomplete results.

We do not know anything about how VFS for Git works, but we do
know that VFS for Git working directories contain a well-defined
config setting.  If it is set, mark the working directory as
incompatible.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-win32.c | 26 ++++++++++++++++++++++++++
 fsmonitor-settings.c                  |  5 +++++
 fsmonitor-settings.h                  |  1 +
 t/t7519-status-fsmonitor.sh           |  9 +++++++++
 4 files changed, 41 insertions(+)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 7fce32a3c5b..ee78bba38e3 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -3,7 +3,33 @@
 #include "repository.h"
 #include "fsmonitor-settings.h"
 
+/*
+ * VFS for Git is incompatible with FSMonitor.
+ *
+ * Granted, core Git does not know anything about VFS for Git and we
+ * shouldn't make assumptions about a downstream feature, but users
+ * can install both versions.  And this can lead to incorrect results
+ * from core Git commands.  So, without bringing in any of the VFS for
+ * Git code, do a simple config test for a published config setting.
+ * (We do not look at the various *_TEST_* environment variables.)
+ */
+static enum fsmonitor_reason check_vfs4git(struct repository *r)
+{
+	const char *const_str;
+
+	if (!repo_config_get_value(r, "core.virtualfilesystem", &const_str))
+		return FSMONITOR_REASON_VFS4GIT;
+
+	return FSMONITOR_REASON_OK;
+}
+
 enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
+	enum fsmonitor_reason reason;
+
+	reason = check_vfs4git(r);
+	if (reason != FSMONITOR_REASON_OK)
+		return reason;
+
 	return FSMONITOR_REASON_OK;
 }
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 8ff55f8c3fd..1efb6e17a20 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -179,6 +179,11 @@ int fsm_settings__error_if_incompatible(struct repository *r)
 		error(_("bare repository '%s' is incompatible with fsmonitor"),
 		      xgetcwd());
 		return 1;
+
+	case FSMONITOR_REASON_VFS4GIT:
+		error(_("virtual repository '%s' is incompatible with fsmonitor"),
+		      r->worktree);
+		return 1;
 	}
 
 	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 4b35f051fb1..6361fcbf6b0 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -16,6 +16,7 @@ enum fsmonitor_mode {
 enum fsmonitor_reason {
 	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
 	FSMONITOR_REASON_BARE,
+	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
 };
 
 void fsm_settings__set_ipc(struct repository *r);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 9a8e21c5608..156895f9437 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -78,6 +78,15 @@ test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
 	grep "bare repository .* is incompatible with fsmonitor" actual
 '
 
+test_expect_success MINGW,FSMONITOR_DAEMON 'run fsmonitor-daemon in virtual repo' '
+	test_when_finished "rm -rf ./fake-virtual-clone actual" &&
+	git init fake-virtual-clone &&
+	test_must_fail git -C ./fake-virtual-clone \
+			   -c core.virtualfilesystem=true \
+			   fsmonitor--daemon run 2>actual &&
+	grep "virtual repository .* is incompatible with fsmonitor" actual
+'
+
 test_expect_success 'setup' '
 	mkdir -p .git/hooks &&
 	: >tracked &&
-- 
gitgitgadget

