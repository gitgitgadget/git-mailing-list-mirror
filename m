Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6A5C433FE
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382170AbiDTUqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382135AbiDTUqS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F0338BEB
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i20so3832523wrb.13
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ekJrkqFg1yJzdNh+egoYJeP3EUXrY0TIhPEKqSMHHf8=;
        b=cuBSG0PH5STso8lS0e4nGX3ySg9ch393hik1HyzAWyZmZHCMj+YEPyftwZGDaSWzPE
         rP7VxfvMn1XWttEwDQbiibuXfd2cMq2hFdpjnuLijvc/MeaZYKOgJNcXlmtciMmrFv6G
         2j2I9eZ8KKN/2rf+cOEBs3Np96hD6VGWaQwV4hFEYbmZPB01eCtfPhw64LjiyFkEISyd
         QJCWxVajnCK9dJlmLbRmOBGFitxJiWSgmKUMH73GXrlocChHIZ2etNytJZ94ogDxbvk7
         pUZDtng3+C0Oaku+SHchoVfQLjAqFEALCqhkTfjr9UAsotSYsoFTJQqoakDAB67LY9tf
         TehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ekJrkqFg1yJzdNh+egoYJeP3EUXrY0TIhPEKqSMHHf8=;
        b=5AyQj7EGqRRcXqapZJ2TXzFm+dtGlCWsiqVrUiNfoLbXaO0gxY8dShDyHwsRirtqaV
         04giuABt+n1tEJdR50qwk8diWT5GuoEm6DVdQ9p4pDOkLZO1bWjkpDQu8b3JmDxdyusG
         HjopUa/rvhqvqJdzVWcPppF0CrIFkKXMTiIj3OIcOyJ8WluZhD8c26xUWC8l8gpNL+K4
         cjdTBzaWT/sFejR74dDfNNoDPm+nzZjjfkadet/n7s2uRGCaZH1nOEGVOFYoSD2+SY+F
         H8qxojVyZ5UoRTnrmcXj672SANr8of6T83FSk1j6/Lt94lP92lJbEDOQmRQ9bKgg1C3x
         DG0Q==
X-Gm-Message-State: AOAM533leUxEmhirIUYQURVApKrCs2P1/0GaLCwXetyRUD4WxGUIkzWH
        ZhOEQPCmAxnLOGz3J86kMZLBZGdO9Ek=
X-Google-Smtp-Source: ABdhPJzexeC7oYhhZ489+IVP+htbwTFnZHBcqsNE9aF5F053h8TjgFIBJ/SqR5/Xga4s46xAIAsXuQ==
X-Received: by 2002:adf:fb48:0:b0:203:f986:874a with SMTP id c8-20020adffb48000000b00203f986874amr16815067wrs.614.1650487409412;
        Wed, 20 Apr 2022 13:43:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c320900b0038f0894d80csm329872wmp.7.2022.04.20.13.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:28 -0700 (PDT)
Message-Id: <2d68fc9a46ad66177d686e889f191dd252f1c964.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:42:56 +0000
Subject: [PATCH v5 06/28] fsmonitor-settings: VFS for Git virtual repos are
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

