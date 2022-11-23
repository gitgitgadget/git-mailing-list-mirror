Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEBDC4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 19:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiKWTAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbiKWTAv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 14:00:51 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52CE91C26
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:00:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id g12so30793602wrs.10
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsP2VTFNE7ywAKYOQ/VT+mldhWLES67uQlxqgONwgL4=;
        b=Hrr+KMh6x4BduZvmUOn5ZtsWphy6M3RDmgHVTAdgzCHg7wOfh6RjsZlvENwlXRbvU2
         7H+w+ipmpU1DLx6sfs2DNFGdooaW9l+cfX0QZ92NflZct5g0oJ1yg7X/GOBACTzrRuCR
         rx6ckXI7jAAh1O5bfIQcpqud/feQOS+Rno+WHs4NRCTkipdmzXnNpwqaQ4T+LsmKtUVm
         NVOAMc6QPeqYvcdIMOItRBzE0Ky7tuAXoy1lVxf7Ym/YfAXpGttzs6DmVl4mBFPh267P
         sAAQVNZM8HtI9V14nhanluVh7qGu2NxuFKR+8yiKUqHpuZLfMlCf+HOQ95qCSh+rXotx
         zFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsP2VTFNE7ywAKYOQ/VT+mldhWLES67uQlxqgONwgL4=;
        b=C5jfKNUP45WQSyXOajpVmX/Ks4f3fj5krhkuuqlgtRU2HcbGLTv38FLnPR2SLqzkA/
         M60PTTa2bmmaDHsuoU69Yp2clZl93qvc6YrjZhWCGZNQ+jhFrqeVowKH6blHxtak/uql
         BsWO/VouHr8sC+2nqVVqt4lFiCYixW3IZxZr0OUVhFpsJ/2oJDz8ClBaWCfhVdMhNqzK
         RO4daEc5LLzd5NoAD7iicxLmILwOe52InmIxdwTSMwZw82tEgq6oR4tLw7x9bYdliDMx
         TP9nC9am/KTd30W1avwCV5vKFFUja2kuf6RUeVxc8lF+D0485P/evG7kbhbfJb0N4XsW
         Iu/A==
X-Gm-Message-State: ANoB5plpNA9sfL6HAaRBEwd58pfLpPoRC8bAa0Lt7iHbksN3e76F/Dhp
        ZW9Fo9l4sXGuCBb1X0t/zXeUaM3UBMA=
X-Google-Smtp-Source: AA0mqf5JNf73CXkeI8AVxkEGAGkaEpQ3rFEL2ir6ZnvFCWspwlduIkB6H9AkQCGM0wDFBXO+JPrF6g==
X-Received: by 2002:adf:db85:0:b0:241:bfd7:de7 with SMTP id u5-20020adfdb85000000b00241bfd70de7mr15670628wri.254.1669230048028;
        Wed, 23 Nov 2022 11:00:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c198d00b003cf54b77bfesm3794634wmq.28.2022.11.23.11.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:00:47 -0800 (PST)
Message-Id: <99d684c7bdfac9db9cbf74bae1d21f9dc20ac825.1669230044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
References: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
        <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Nov 2022 19:00:39 +0000
Subject: [PATCH v4 1/6] fsmonitor: prepare to share code between Mac OS and
 Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Linux and Mac OS can share some of the code originally developed for Mac OS.

Mac OS and Linux can share fsm-ipc-unix.c and fsm-settings-unix.c

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-health-linux.c    | 24 ++++++++++
 compat/fsmonitor/fsm-ipc-darwin.c      | 53 +---------------------
 compat/fsmonitor/fsm-ipc-linux.c       |  1 +
 compat/fsmonitor/fsm-ipc-unix.c        | 52 +++++++++++++++++++++
 compat/fsmonitor/fsm-settings-darwin.c | 63 +-------------------------
 compat/fsmonitor/fsm-settings-linux.c  |  1 +
 compat/fsmonitor/fsm-settings-unix.c   | 61 +++++++++++++++++++++++++
 7 files changed, 141 insertions(+), 114 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-unix.c
 create mode 100644 compat/fsmonitor/fsm-settings-linux.c
 create mode 100644 compat/fsmonitor/fsm-settings-unix.c

diff --git a/compat/fsmonitor/fsm-health-linux.c b/compat/fsmonitor/fsm-health-linux.c
new file mode 100644
index 00000000000..b9f709e8548
--- /dev/null
+++ b/compat/fsmonitor/fsm-health-linux.c
@@ -0,0 +1,24 @@
+#include "cache.h"
+#include "config.h"
+#include "fsmonitor.h"
+#include "fsm-health.h"
+#include "fsmonitor--daemon.h"
+
+int fsm_health__ctor(struct fsmonitor_daemon_state *state)
+{
+	return 0;
+}
+
+void fsm_health__dtor(struct fsmonitor_daemon_state *state)
+{
+	return;
+}
+
+void fsm_health__loop(struct fsmonitor_daemon_state *state)
+{
+	return;
+}
+
+void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
+{
+}
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
index d67b0ee50d3..4c3c92081ee 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -1,52 +1 @@
-#include "cache.h"
-#include "config.h"
-#include "strbuf.h"
-#include "fsmonitor.h"
-#include "fsmonitor-ipc.h"
-#include "fsmonitor-path-utils.h"
-
-static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
-
-const char *fsmonitor_ipc__get_path(struct repository *r)
-{
-	static const char *ipc_path = NULL;
-	git_SHA_CTX sha1ctx;
-	char *sock_dir = NULL;
-	struct strbuf ipc_file = STRBUF_INIT;
-	unsigned char hash[GIT_MAX_RAWSZ];
-
-	if (!r)
-		BUG("No repository passed into fsmonitor_ipc__get_path");
-
-	if (ipc_path)
-		return ipc_path;
-
-
-	/* By default the socket file is created in the .git directory */
-	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
-		ipc_path = fsmonitor_ipc__get_default_path();
-		return ipc_path;
-	}
-
-	git_SHA1_Init(&sha1ctx);
-	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
-	git_SHA1_Final(hash, &sha1ctx);
-
-	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
-
-	/* Create the socket file in either socketDir or $HOME */
-	if (sock_dir && *sock_dir) {
-		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
-					sock_dir, hash_to_hex(hash));
-	} else {
-		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
-	}
-	free(sock_dir);
-
-	ipc_path = interpolate_path(ipc_file.buf, 1);
-	if (!ipc_path)
-		die(_("Invalid path: %s"), ipc_file.buf);
-
-	strbuf_release(&ipc_file);
-	return ipc_path;
-}
+#include "fsm-ipc-unix.c"
diff --git a/compat/fsmonitor/fsm-ipc-linux.c b/compat/fsmonitor/fsm-ipc-linux.c
new file mode 100644
index 00000000000..4c3c92081ee
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-linux.c
@@ -0,0 +1 @@
+#include "fsm-ipc-unix.c"
diff --git a/compat/fsmonitor/fsm-ipc-unix.c b/compat/fsmonitor/fsm-ipc-unix.c
new file mode 100644
index 00000000000..d67b0ee50d3
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-unix.c
@@ -0,0 +1,52 @@
+#include "cache.h"
+#include "config.h"
+#include "strbuf.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-path-utils.h"
+
+static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
+
+const char *fsmonitor_ipc__get_path(struct repository *r)
+{
+	static const char *ipc_path = NULL;
+	git_SHA_CTX sha1ctx;
+	char *sock_dir = NULL;
+	struct strbuf ipc_file = STRBUF_INIT;
+	unsigned char hash[GIT_MAX_RAWSZ];
+
+	if (!r)
+		BUG("No repository passed into fsmonitor_ipc__get_path");
+
+	if (ipc_path)
+		return ipc_path;
+
+
+	/* By default the socket file is created in the .git directory */
+	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
+		ipc_path = fsmonitor_ipc__get_default_path();
+		return ipc_path;
+	}
+
+	git_SHA1_Init(&sha1ctx);
+	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
+	git_SHA1_Final(hash, &sha1ctx);
+
+	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
+
+	/* Create the socket file in either socketDir or $HOME */
+	if (sock_dir && *sock_dir) {
+		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
+					sock_dir, hash_to_hex(hash));
+	} else {
+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
+	}
+	free(sock_dir);
+
+	ipc_path = interpolate_path(ipc_file.buf, 1);
+	if (!ipc_path)
+		die(_("Invalid path: %s"), ipc_file.buf);
+
+	strbuf_release(&ipc_file);
+	return ipc_path;
+}
diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 6abbc7af3ab..14baf9f0603 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -1,62 +1 @@
-#include "config.h"
-#include "fsmonitor.h"
-#include "fsmonitor-ipc.h"
-#include "fsmonitor-settings.h"
-#include "fsmonitor-path-utils.h"
-
- /*
- * For the builtin FSMonitor, we create the Unix domain socket for the
- * IPC in the .git directory.  If the working directory is remote,
- * then the socket will be created on the remote file system.  This
- * can fail if the remote file system does not support UDS file types
- * (e.g. smbfs to a Windows server) or if the remote kernel does not
- * allow a non-local process to bind() the socket.  (These problems
- * could be fixed by moving the UDS out of the .git directory and to a
- * well-known local directory on the client machine, but care should
- * be taken to ensure that $HOME is actually local and not a managed
- * file share.)
- *
- * FAT32 and NTFS working directories are problematic too.
- *
- * The builtin FSMonitor uses a Unix domain socket in the .git
- * directory for IPC.  These Windows drive formats do not support
- * Unix domain sockets, so mark them as incompatible for the daemon.
- *
- */
-static enum fsmonitor_reason check_uds_volume(struct repository *r)
-{
-	struct fs_info fs;
-	const char *ipc_path = fsmonitor_ipc__get_path(r);
-	struct strbuf path = STRBUF_INIT;
-	strbuf_add(&path, ipc_path, strlen(ipc_path));
-
-	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
-		strbuf_release(&path);
-		return FSMONITOR_REASON_ERROR;
-	}
-
-	strbuf_release(&path);
-
-	if (fs.is_remote ||
-		!strcmp(fs.typename, "msdos") ||
-		!strcmp(fs.typename, "ntfs")) {
-		free(fs.typename);
-		return FSMONITOR_REASON_NOSOCKETS;
-	}
-
-	free(fs.typename);
-	return FSMONITOR_REASON_OK;
-}
-
-enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
-{
-	enum fsmonitor_reason reason;
-
-	if (ipc) {
-		reason = check_uds_volume(r);
-		if (reason != FSMONITOR_REASON_OK)
-			return reason;
-	}
-
-	return FSMONITOR_REASON_OK;
-}
+#include "fsm-settings-unix.c"
diff --git a/compat/fsmonitor/fsm-settings-linux.c b/compat/fsmonitor/fsm-settings-linux.c
new file mode 100644
index 00000000000..14baf9f0603
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-linux.c
@@ -0,0 +1 @@
+#include "fsm-settings-unix.c"
diff --git a/compat/fsmonitor/fsm-settings-unix.c b/compat/fsmonitor/fsm-settings-unix.c
new file mode 100644
index 00000000000..a6ed32575a9
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-unix.c
@@ -0,0 +1,61 @@
+#include "config.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-path-utils.h"
+
+ /*
+ * For the builtin FSMonitor, we create the Unix domain socket for the
+ * IPC in the .git directory.  If the working directory is remote,
+ * then the socket will be created on the remote file system.  This
+ * can fail if the remote file system does not support UDS file types
+ * (e.g. smbfs to a Windows server) or if the remote kernel does not
+ * allow a non-local process to bind() the socket.  (These problems
+ * could be fixed by moving the UDS out of the .git directory and to a
+ * well-known local directory on the client machine, but care should
+ * be taken to ensure that $HOME is actually local and not a managed
+ * file share.)
+ *
+ * FAT32 and NTFS working directories are problematic too.
+ *
+ * The builtin FSMonitor uses a Unix domain socket in the .git
+ * directory for IPC.  These Windows drive formats do not support
+ * Unix domain sockets, so mark them as incompatible for the daemon.
+ *
+ */
+static enum fsmonitor_reason check_uds_volume(struct repository *r)
+{
+	struct fs_info fs;
+	const char *ipc_path = fsmonitor_ipc__get_path(r);
+	struct strbuf path = STRBUF_INIT;
+	strbuf_addstr(&path, ipc_path);
+
+	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
+		strbuf_release(&path);
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	strbuf_release(&path);
+
+	if (fs.is_remote ||
+		!strcmp(fs.typename, "msdos") ||
+		!strcmp(fs.typename, "ntfs")) {
+		free(fs.typename);
+		return FSMONITOR_REASON_NOSOCKETS;
+	}
+
+	free(fs.typename);
+	return FSMONITOR_REASON_OK;
+}
+
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
+{
+	enum fsmonitor_reason reason;
+
+	if (ipc) {
+		reason = check_uds_volume(r);
+		if (reason != FSMONITOR_REASON_OK)
+			return reason;
+	}
+
+	return FSMONITOR_REASON_OK;
+}
-- 
gitgitgadget

