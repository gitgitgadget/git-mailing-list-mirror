Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09C2C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiEWUNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiEWUNB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F709BAF2
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:12:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t6so22907694wra.4
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KflqYF0+S7RB9kOFxgFWU4lLQFA5eX5O/Scn3B7vbzU=;
        b=IoeFwFBQwYwCeGh3lXvxRtWSsyhkeOkuKywGJh0znorRQJHprPLFwgpxTun1HqNEd8
         zBrhJrc1n9p0nDyXT5yaE9Xkvt+JUDhbeyu0gZC4f3JXxxa1//fye6F393trQ7SpxeAr
         i9Das/NGJZHLjbuRU4tuXMhh11OFl1bXuKCIxdGith1xMwM0cXzlFeJqqId+TzHvTohp
         0u8KUN6U9KBwx4q8X4UoKzB1AeIT1FoN1m/KYqquIe9ukOsmCYV7GdrcuCTmvYwSy7o/
         Yxls7qYLaZIUJnEbw62shGrKOfTSuJI7P5vfcfbwI7udaCvUVcpugzmWwAEdnuMZZN6I
         qiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KflqYF0+S7RB9kOFxgFWU4lLQFA5eX5O/Scn3B7vbzU=;
        b=DNAik5r6lcD9E3zQRf54jb0r28HYsquRdaheXJnlVciemPfRlKKO8SKlwh4G1/SrtQ
         7M2WnOzvjTEm00CM1S2/w4hUsz1twepbvKOlLVjA0rRguFbNyiucBWOqSCXdXc7Q+Fhl
         ltRqDwKvNgVMXs4nxXfm6RSHnxKt425xPNtYocgc15cB7fQkhti/sw1RjXFMZxBOMIGO
         ZCGA4+OuB5JclSD7ywnQoLCNyUGSwuo9cnQ29w/3KxGybyM2xenYnzAiHjKZDA5oB0st
         bX55jQeV/dYqgnKFVAgfQwWf+hx/2eoShppHo+eNaBHIhEQOTxo1b5LH6YvrNlG600ss
         Fx6A==
X-Gm-Message-State: AOAM530LQEeeoowbBxFcy9i6TBiBZfZ2liyPLzoegalKE/QjDYxSrHfL
        K24+QCWKvWjXkj0b7j/yuoY6AUWE4bE=
X-Google-Smtp-Source: ABdhPJx2xD9cdWQz+2eZMkovaRR3B9NHLMz79B/Z6SqqZIvC3n5st+Yspy8jxRRvutBELVjL+XBCMg==
X-Received: by 2002:a5d:6847:0:b0:20f:c0b6:d783 with SMTP id o7-20020a5d6847000000b0020fc0b6d783mr13675313wrw.101.1653336777958;
        Mon, 23 May 2022 13:12:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x5-20020adfbb45000000b0020d117a4e00sm10903469wrg.105.2022.05.23.13.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:12:57 -0700 (PDT)
Message-Id: <9774faddc45cd33362aeb1e3ea80125bc496cbc9.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:21 +0000
Subject: [PATCH v7 06/30] fsmonitor-settings: VFS for Git virtual repos are
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

