Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1156C433FE
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348489AbiEZVtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345234AbiEZVtN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72AEC6E77
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k30so3652931wrd.5
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KflqYF0+S7RB9kOFxgFWU4lLQFA5eX5O/Scn3B7vbzU=;
        b=UWTRRnaq/r+aMTsvWk1GIWezlUK/Kt44rMdMhR7sfWGqJsQvLX3o1R7Cx2B/dblTMD
         7bp0zLjCe5786ZMXIHuuU1cjyq1wkL67gHbtQBDmfZqvthHPG/zLaCeF7Tee0xpxrw1J
         UY0MobqQy57V3ks0CZRsLWZT9ONV8s9GHHxq9I32Rv1W/ysimgLUJ6cQJ1msh2SaT7u/
         5H5uH8bWzqS9EV8mutf6Q5JzGGsoOHK0tCibWzem8m3oMpua9B7VEc2qcqMcdm+/UCfv
         Rtk8d49t5VRPrIIP+3pSpO+0HE/rjZsDVtof/FMJ95D8zskfiIXbWx6HXWKKVQXbtQOf
         1ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KflqYF0+S7RB9kOFxgFWU4lLQFA5eX5O/Scn3B7vbzU=;
        b=O5cTUkBlypBb6hgxS4QfbEITWpFRlLb/X5yaW2iigvXt+sXvp5+0Zn3jqYqi9MQDf0
         zoerlIXwx7LuglOc3Aj0/knif6WeDq2C8nvYYPWEjZIStv3Gk9E9AmJrx5IFwNtz57Wb
         zJ3Pz9l4jK9VMIbGAxqiqWagsQ6BdBp5ybP73u6eXHUju0beBBcHyGxwZMuALdCovWcU
         jAGQ/l5rkytqLeThLSE3yd7luLVD2g23Iax9idSB6mD+HKU85A4y+4vUswoNXTSQ4vns
         5GSH5hdGPMwgXRxTy1N+4eg1Ww67uwjv1cFHsPzwYiKA4d1Zu1mOK6qLcqW9WJaMCqKK
         BrTw==
X-Gm-Message-State: AOAM532hkDov3w5OfvQnVo2WOOOPURbrWlIBTXokvtwCY64TFqNA8R5u
        pJ8VvS8bPSQlivyLFRxFUW9hMqDweXE=
X-Google-Smtp-Source: ABdhPJzGV1EkmBV06OSyTIeEEKXiOCwXaTqMxH8lUaQa4/CwGBRdlZb7+uj4KcubGAWfs22rZxt7Mg==
X-Received: by 2002:adf:f885:0:b0:210:a70:b233 with SMTP id u5-20020adff885000000b002100a70b233mr4239030wrp.103.1653601751098;
        Thu, 26 May 2022 14:49:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b0039456fb80b3sm223121wmq.43.2022.05.26.14.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:10 -0700 (PDT)
Message-Id: <06d49b0f230a72f4759a13e5ff213917c4fe7e00.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:00 +0000
Subject: [PATCH v9 06/30] fsmonitor-settings: VFS for Git virtual repos are
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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
 fsmonitor-settings.c                  |  6 ++++++
 fsmonitor-settings.h                  |  1 +
 t/t7519-status-fsmonitor.sh           |  9 +++++++++
 4 files changed, 42 insertions(+)

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
index f67db913f57..600ae165ab1 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -207,6 +207,12 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
 			    _("bare repository '%s' is incompatible with fsmonitor"),
 			    xgetcwd());
 		goto done;
+
+	case FSMONITOR_REASON_VFS4GIT:
+		strbuf_addf(&msg,
+			    _("virtual repository '%s' is incompatible with fsmonitor"),
+			    r->worktree);
+		goto done;
 	}
 
 	BUG("Unhandled case in fsm_settings__get_incompatible_msg: '%d'",
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 6cb0d8e7d9f..a48802cde9c 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -17,6 +17,7 @@ enum fsmonitor_reason {
 	FSMONITOR_REASON_UNTESTED = 0,
 	FSMONITOR_REASON_OK, /* no incompatibility or when disabled */
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

