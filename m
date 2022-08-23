Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FBFC32789
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 19:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiHWTwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiHWTv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 15:51:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A081B6051B
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:55:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u5so10272322wrt.11
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=/zzF2jGn0GacHZ51T7NWmhYhY7TMlOeRLghvEMcULuM=;
        b=JBmnWRo8txjSPTib5AxolNuKma5qOnxby6kkEvxn/rwhuhwgRHDODutPs9n2oU5tLL
         exGEnNtICNfX4UW9JqMb5JvgxQeUdXmiOHERgTKFbSw39pZUUUBPjOrxubJsjaeVHYoS
         OmI+uUcMmLaEqQt5ZBavTRQmXT1JztqV07/euw0OA3GmwBSHz8ZghCJzXyWwHci/NTqr
         dftnoDg880DbYjIgv/WNLMXzSqLFCCiwWRb4PyghyVdFHGWpguiAAzxaBYji5ejnYflj
         JetNdQbriHvOBotPq7UOffp3bshd5XlYOpPpd9hj8cGwLXIcyHUD82JUVNzrsTlUpVZO
         jrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=/zzF2jGn0GacHZ51T7NWmhYhY7TMlOeRLghvEMcULuM=;
        b=c2xFo7pFvoAtZf3385kdCuHOdcYHvvuiZdVe1CYH6g72iCH5XUDP59m6Nmy3ZjT61P
         ld6j4JXgqYiygc7GDfe7TMAcKLR1PdkTgC3YRTcBATXVrljA/9olH/Y4X2Mh7ICkRKRo
         09vrMRgdyFp9zd5IhfGaWqR0zqyP/veRuO1SjmIdad6ySrEpP0v4V6hGA+qaKyMhy0GX
         O7oQ0p1rPLlgd67mzg2iX60Md/mWhHQUkF4KMtSseQV2vB+ze/HfkuWWcmidagCWyu47
         RLvIBpwr6V6MNDQTCb6XSwXA7F3/CQjOnrXiQ0sM3kAnpu+YZ5RolomF8wlksZurBUOo
         RZcA==
X-Gm-Message-State: ACgBeo0vREXal9x3eCOD570snBXz1W+RChBYCqlTEgbfZGspiH0u511b
        PsHjcCFqyTkqpemFg38w4o8YmUtx4k0=
X-Google-Smtp-Source: AA6agR5LqmhKlSUKYyOQsNXZgWvcEeaV6VyUKuMMMV6oHuzqnBcNWeHN8gxsXbrn4pLRFrV7QtS8yg==
X-Received: by 2002:adf:ea09:0:b0:225:559a:b662 with SMTP id q9-20020adfea09000000b00225559ab662mr7075758wrm.396.1661280943278;
        Tue, 23 Aug 2022 11:55:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4-20020a05600c300400b003a601a1c2f7sm20334319wmh.19.2022.08.23.11.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:55:42 -0700 (PDT)
Message-Id: <cd16d8bb3d6a653ebe771d10821dd789ad87f90d.1661280941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
References: <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
        <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 18:55:40 +0000
Subject: [PATCH v3 1/2] fsmonitor: macOS: allow fsmonitor to run against
 network-mounted repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Follow-on to the work done to allow Windows to work against
network-mounted repos. Have macOS take advantage of the same
configuration option, 'fsmonitor.allowRemote' that was introduced for
Windows. Setting this option to true will override the default behavior
(erroring-out) when a network-mounted repo is detected by fsmonitor.

The added wrinkle being that the Unix domain socket (UDS) file used for
IPC cannot be created in a network location; instead $HOME is used if
'fsmonitor.allowRemote' is true.

If $HOME is in a network location, allow the user to override this via
the 'fsmonitor.socketDir' configuration option. There the user can
specify any local directory for the location of the UDS file.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 fsmonitor-ipc.c      | 40 ++++++++++++++++++++++++--
 fsmonitor-ipc.h      |  6 ++++
 fsmonitor-settings.c | 67 ++++++++++++++++++++++++++++++++++++++++++--
 fsmonitor-settings.h |  4 +++
 4 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 789e7397baa..1e3f0a6cf48 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -1,7 +1,6 @@
 #include "cache.h"
-#include "fsmonitor.h"
-#include "simple-ipc.h"
 #include "fsmonitor-ipc.h"
+#include "fsmonitor-settings.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "trace2.h"
@@ -47,7 +46,42 @@ int fsmonitor_ipc__is_supported(void)
 	return 1;
 }
 
-GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
+GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
+
+const char *fsmonitor_ipc__get_path(void)
+{
+#ifdef WIN32
+	return fsmonitor_ipc__get_default_path();
+#else
+	char *retval;
+	SHA_CTX sha1ctx;
+	const char *git_dir;
+	const char *sock_dir;
+	struct strbuf ipc_file = STRBUF_INIT;
+	unsigned char hash[SHA_DIGEST_LENGTH];
+
+	if (fsm_settings__get_allow_remote(the_repository) < 1)
+		return fsmonitor_ipc__get_default_path();
+
+	git_dir = get_git_dir();
+	sock_dir = fsm_settings__get_socket_dir(the_repository);
+
+	SHA1_Init(&sha1ctx);
+	SHA1_Update(&sha1ctx, git_dir, strlen(git_dir));
+	SHA1_Final(hash, &sha1ctx);
+
+	if (sock_dir && *sock_dir)
+		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
+					sock_dir, hash_to_hex(hash));
+	else
+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
+	retval = interpolate_path(ipc_file.buf, 1);
+	if (!retval)
+		die(_("Invalid path: %s"), ipc_file.buf);
+	strbuf_release(&ipc_file);
+	return retval;
+#endif
+}
 
 enum ipc_active_state fsmonitor_ipc__get_state(void)
 {
diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
index b6a7067c3af..4d27223c2a6 100644
--- a/fsmonitor-ipc.h
+++ b/fsmonitor-ipc.h
@@ -18,6 +18,12 @@ int fsmonitor_ipc__is_supported(void);
  */
 const char *fsmonitor_ipc__get_path(void);
 
+/*
+ * Returns the pathname to the default IPC named pipe or Unix domain
+ * socket.
+ */
+const char *fsmonitor_ipc__get_default_path(void);
+
 /*
  * Try to determine whether there is a `git-fsmonitor--daemon` process
  * listening on the IPC pipe/socket.
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 464424a1e92..a15eeecebf4 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -10,7 +10,9 @@
 struct fsmonitor_settings {
 	enum fsmonitor_mode mode;
 	enum fsmonitor_reason reason;
+	int allow_remote;
 	char *hook_path;
+	char *sock_dir;
 };
 
 static enum fsmonitor_reason check_for_incompatible(struct repository *r)
@@ -43,6 +45,7 @@ static struct fsmonitor_settings *alloc_settings(void)
 	CALLOC_ARRAY(s, 1);
 	s->mode = FSMONITOR_MODE_DISABLED;
 	s->reason = FSMONITOR_REASON_UNTESTED;
+	s->allow_remote = -1;
 
 	return s;
 }
@@ -90,6 +93,26 @@ static void lookup_fsmonitor_settings(struct repository *r)
 		fsm_settings__set_disabled(r);
 }
 
+int fsm_settings__get_allow_remote(struct repository *r)
+{
+	if (!r)
+		r = the_repository;
+	if (!r->settings.fsmonitor)
+		lookup_fsmonitor_settings(r);
+
+	return r->settings.fsmonitor->allow_remote;
+}
+
+const char *fsm_settings__get_socket_dir(struct repository *r)
+{
+	if (!r)
+		r = the_repository;
+	if (!r->settings.fsmonitor)
+		lookup_fsmonitor_settings(r);
+
+	return r->settings.fsmonitor->sock_dir;
+}
+
 enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
 {
 	if (!r)
@@ -100,6 +123,7 @@ enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
 	return r->settings.fsmonitor->mode;
 }
 
+
 const char *fsm_settings__get_hook_path(struct repository *r)
 {
 	if (!r)
@@ -110,9 +134,44 @@ const char *fsm_settings__get_hook_path(struct repository *r)
 	return r->settings.fsmonitor->hook_path;
 }
 
+void fsm_settings__set_allow_remote(struct repository *r)
+{
+	int allow;
+
+	if (!r)
+		r = the_repository;
+	if (!r->settings.fsmonitor)
+		r->settings.fsmonitor = alloc_settings();
+	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
+		r->settings.fsmonitor->allow_remote = allow;
+
+	return;
+}
+
+void fsm_settings__set_socket_dir(struct repository *r)
+{
+	const char *path;
+
+	if (!r)
+		r = the_repository;
+	if (!r->settings.fsmonitor)
+		r->settings.fsmonitor = alloc_settings();
+
+	if (!repo_config_get_pathname(r, "fsmonitor.socketdir", &path)) {
+		FREE_AND_NULL(r->settings.fsmonitor->sock_dir);
+		r->settings.fsmonitor->sock_dir = strdup(path);
+	}
+
+	return;
+}
+
 void fsm_settings__set_ipc(struct repository *r)
 {
-	enum fsmonitor_reason reason = check_for_incompatible(r);
+	enum fsmonitor_reason reason;
+
+	fsm_settings__set_allow_remote(r);
+	fsm_settings__set_socket_dir(r);
+	reason = check_for_incompatible(r);
 
 	if (reason != FSMONITOR_REASON_OK) {
 		fsm_settings__set_incompatible(r, reason);
@@ -135,7 +194,11 @@ void fsm_settings__set_ipc(struct repository *r)
 
 void fsm_settings__set_hook(struct repository *r, const char *path)
 {
-	enum fsmonitor_reason reason = check_for_incompatible(r);
+	enum fsmonitor_reason reason;
+
+	fsm_settings__set_allow_remote(r);
+	fsm_settings__set_socket_dir(r);
+	reason = check_for_incompatible(r);
 
 	if (reason != FSMONITOR_REASON_OK) {
 		fsm_settings__set_incompatible(r, reason);
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index d9c2605197f..2de54c85e94 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -23,12 +23,16 @@ enum fsmonitor_reason {
 	FSMONITOR_REASON_NOSOCKETS, /* NTFS,FAT32 do not support Unix sockets */
 };
 
+void fsm_settings__set_allow_remote(struct repository *r);
+void fsm_settings__set_socket_dir(struct repository *r);
 void fsm_settings__set_ipc(struct repository *r);
 void fsm_settings__set_hook(struct repository *r, const char *path);
 void fsm_settings__set_disabled(struct repository *r);
 void fsm_settings__set_incompatible(struct repository *r,
 				    enum fsmonitor_reason reason);
 
+int fsm_settings__get_allow_remote(struct repository *r);
+const char *fsm_settings__get_socket_dir(struct repository *r);
 enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
 const char *fsm_settings__get_hook_path(struct repository *r);
 
-- 
gitgitgadget

