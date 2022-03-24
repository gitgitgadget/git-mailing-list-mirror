Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FDEC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351997AbiCXQyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352168AbiCXQxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B4CB0A74
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j18so7481819wrd.6
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XEOJPlnBxdyHowBZdh3y4jZnw2C/J1d1GlvxDT+qV1c=;
        b=EIxVEFiOj875aHhz1/bBDQv2gh6LKaVXxCehnOSRnwKhnbS++FoivgNjNRDuqJg+Vw
         TXobtVnF1Z7w/R8oPFHQj70MUytpupdWkkymLELLqwfh/pt0oxsUA2MPiR/Bcvixx1Lu
         ECxtYsatawLiWCrv+eXP86hsc2OMY56NWgAVffYWP2+6FjUj8hkmDpbYYMAQB+VKMClt
         xDtbyIK+W0DTa+lQrJRxMZqbDK/j/GBmWb3fnvlOInqc5Az9OSVidc11AMXoPM/cRkKl
         545mNNbrdGD5J/bX9w5ADVygmi1jtJoayj4+WMrWl/46w3gb429NydWJLmiMv+eY7MKx
         ePUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XEOJPlnBxdyHowBZdh3y4jZnw2C/J1d1GlvxDT+qV1c=;
        b=ikQxebkgv5Stox2bl+1ZNFkeq4IMS8DxkdXqm/9wnCyaDPJPS9d7Hr0cG5wc0yByle
         iHIlSKuwaWkc0CV3LFypAZsVurZ1p0qJFN4VBryK7rt7WEQLvYCEONy6YPS0JupxY39H
         rdkvJQcXTCrsLraqrgk9UGJL+wLHv/xr8nM7MnE9C2PBWg/V4USjkFcjBJW1dy0DvKb7
         a8NQOWvnk30yhXBlQ/3foHF6YLMprKRaOq6QShP9kD5Vris7pIvfN1Xhj8CF4mxty/Y0
         pRDNth2vEbrjzZEvTB5YTONkvhDZ1UvbAJ0C+keRNjyzdKFTWbeQZHV/VcvaLW4Bt1IG
         HT7w==
X-Gm-Message-State: AOAM531CLvVNm1NWGPjZ/TzcFk9BMe2nVQdFdaeorjXwN5EYWjlXr4+X
        wpeVmb0jMDc0XMClEkvaPjbguJhPGcY=
X-Google-Smtp-Source: ABdhPJwJz+gBLdzDuzm6gH9xeKumrD7DxT6OJWQ+Xm91QEDXsFZkj+w3Eh69YrsWLVqc7k4LJnYd+w==
X-Received: by 2002:a05:6000:1c1e:b0:205:9497:935a with SMTP id ba30-20020a0560001c1e00b002059497935amr3759194wrb.533.1648140687410;
        Thu, 24 Mar 2022 09:51:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c4f9400b0038cbd13e06esm5332341wmq.2.2022.03.24.09.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:26 -0700 (PDT)
Message-Id: <f2c0569c9012a86f252562a9a906f6de37d0a236.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:50:57 +0000
Subject: [PATCH v4 04/27] fsmonitor-settings: bare repos are incompatible with
 FSMonitor
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

Bare repos do not have a worktree, so there is nothing for the
daemon watch.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c |  6 ++++
 builtin/update-index.c      |  4 +++
 fsmonitor-settings.c        | 60 +++++++++++++++++++++++++++++++++++++
 fsmonitor-settings.h        | 12 ++++++++
 t/t7519-status-fsmonitor.sh | 23 ++++++++++++++
 5 files changed, 105 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 46be55a4618..50ae3cca575 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1449,6 +1449,12 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		die(_("invalid 'ipc-threads' value (%d)"),
 		    fsmonitor__ipc_threads);
 
+	prepare_repo_settings(the_repository);
+	fsm_settings__set_ipc(the_repository);
+
+	if (fsm_settings__error_if_incompatible(the_repository))
+		return 1;
+
 	if (!strcmp(subcmd, "start"))
 		return !!try_to_start_background_daemon();
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 876112abb21..d29048f16f2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1237,6 +1237,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	if (fsmonitor > 0) {
 		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+
+		if (fsm_settings__error_if_incompatible(the_repository))
+			return 1;
+
 		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
 			warning(_("core.fsmonitor is unset; "
 				"set it if you really want to "
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 757d230d538..86c09bd35fe 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -9,9 +9,33 @@
  */
 struct fsmonitor_settings {
 	enum fsmonitor_mode mode;
+	enum fsmonitor_reason reason;
 	char *hook_path;
 };
 
+static void set_incompatible(struct repository *r,
+			     enum fsmonitor_reason reason)
+{
+	struct fsmonitor_settings *s = r->settings.fsmonitor;
+
+	s->mode = FSMONITOR_MODE_INCOMPATIBLE;
+	s->reason = reason;
+}
+
+static int check_for_incompatible(struct repository *r)
+{
+	if (!r->worktree) {
+		/*
+		 * Bare repositories don't have a working directory and
+		 * therefore have nothing to watch.
+		 */
+		set_incompatible(r, FSMONITOR_REASON_BARE);
+		return 1;
+	}
+
+	return 0;
+}
+
 static void lookup_fsmonitor_settings(struct repository *r)
 {
 	struct fsmonitor_settings *s;
@@ -23,6 +47,7 @@ static void lookup_fsmonitor_settings(struct repository *r)
 
 	CALLOC_ARRAY(s, 1);
 	s->mode = FSMONITOR_MODE_DISABLED;
+	s->reason = FSMONITOR_REASON_OK;
 
 	r->settings.fsmonitor = s;
 
@@ -86,6 +111,9 @@ void fsm_settings__set_ipc(struct repository *r)
 
 	lookup_fsmonitor_settings(r);
 
+	if (check_for_incompatible(r))
+		return;
+
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_IPC;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 }
@@ -97,6 +125,9 @@ void fsm_settings__set_hook(struct repository *r, const char *path)
 
 	lookup_fsmonitor_settings(r);
 
+	if (check_for_incompatible(r))
+		return;
+
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_HOOK;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 	r->settings.fsmonitor->hook_path = strdup(path);
@@ -110,5 +141,34 @@ void fsm_settings__set_disabled(struct repository *r)
 	lookup_fsmonitor_settings(r);
 
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_DISABLED;
+	r->settings.fsmonitor->reason = FSMONITOR_REASON_OK;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 }
+
+enum fsmonitor_reason fsm_settings__get_reason(struct repository *r)
+{
+	if (!r)
+		r = the_repository;
+
+	lookup_fsmonitor_settings(r);
+
+	return r->settings.fsmonitor->reason;
+}
+
+int fsm_settings__error_if_incompatible(struct repository *r)
+{
+	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
+
+	switch (reason) {
+	case FSMONITOR_REASON_OK:
+		return 0;
+
+	case FSMONITOR_REASON_BARE:
+		error(_("bare repository '%s' is incompatible with fsmonitor"),
+		      xgetcwd());
+		return 1;
+	}
+
+	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
+	    reason);
+}
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index a4c5d7b4889..8654edf33d8 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -4,11 +4,20 @@
 struct repository;
 
 enum fsmonitor_mode {
+	FSMONITOR_MODE_INCOMPATIBLE = -1, /* see _reason */
 	FSMONITOR_MODE_DISABLED = 0,
 	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor=<hook_path> */
 	FSMONITOR_MODE_IPC = 2,  /* core.fsmonitor=<true> */
 };
 
+/*
+ * Incompatibility reasons.
+ */
+enum fsmonitor_reason {
+	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
+	FSMONITOR_REASON_BARE,
+};
+
 void fsm_settings__set_ipc(struct repository *r);
 void fsm_settings__set_hook(struct repository *r, const char *path);
 void fsm_settings__set_disabled(struct repository *r);
@@ -16,6 +25,9 @@ void fsm_settings__set_disabled(struct repository *r);
 enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
 const char *fsm_settings__get_hook_path(struct repository *r);
 
+enum fsmonitor_reason fsm_settings__get_reason(struct repository *r);
+int fsm_settings__error_if_incompatible(struct repository *r);
+
 struct fsmonitor_settings;
 
 #endif /* FSMONITOR_SETTINGS_H */
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index a6308acf006..9a8e21c5608 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -55,6 +55,29 @@ test_lazy_prereq UNTRACKED_CACHE '
 	test $ret -ne 1
 '
 
+# Test that we detect and disallow repos that are incompatible with FSMonitor.
+test_expect_success 'incompatible bare repo' '
+	test_when_finished "rm -rf ./bare-clone actual expect" &&
+	git init --bare bare-clone &&
+
+	test_must_fail \
+		git -C ./bare-clone -c core.fsmonitor=foo \
+			update-index --fsmonitor 2>actual &&
+	grep "bare repository .* is incompatible with fsmonitor" actual &&
+
+	test_must_fail \
+		git -C ./bare-clone -c core.fsmonitor=true \
+			update-index --fsmonitor 2>actual &&
+	grep "bare repository .* is incompatible with fsmonitor" actual
+'
+
+test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
+	test_when_finished "rm -rf ./bare-clone actual" &&
+	git init --bare bare-clone &&
+	test_must_fail git -C ./bare-clone fsmonitor--daemon run 2>actual &&
+	grep "bare repository .* is incompatible with fsmonitor" actual
+'
+
 test_expect_success 'setup' '
 	mkdir -p .git/hooks &&
 	: >tracked &&
-- 
gitgitgadget

