Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B167E8B
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992985; cv=none; b=rb1AUkcG2wsgs1hTEYL+qmnECu79bchKiBRDkuV2UxLHTz6x0vyz6Ta8ctURw48UEN+5wlU+5pYqOV6f4ugF3qAOppJXkoEXaIUaUdMiJbZaN3/iwNKBfNKhPI88CigTRZOHshzQDGK24LP1ks66IukbWRXJ2kZZqv+l7uidemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992985; c=relaxed/simple;
	bh=t8KWApBpQqCyUO351NTSTy0SVWndYeQKS63dUZxx9Oc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X5IdMPhDrymsNDoF2RoEb7Jnk0z2AJ7pZukD9y0FNxXuC9t6cTOxxfvQGG0wIEuZdx8naD/u81c9cwVksxop/b08VWG8LEinww+7UZzQ1TnY7UGt3hIrzsAUH9mUSZe67F+YlawmKN9iJoVctIM0d7WKvAaAnkEQALCCKRRiNbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfRGFwu4; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfRGFwu4"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511ac32fe38so1097822e87.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 02:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707992981; x=1708597781; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WOZYu1ABQvI0PZXp/i2IDZ9BkIUgU3t3A1/nH+ofTY=;
        b=hfRGFwu4ns1E+52wLLT/M4jtWvg2Rhd+Ah7oQmCqn8rluAjRN35xg+0DyDCF8oNmsu
         RxNzoBTRgMpVb5H54UD3wT67zLB/nitDFTJMDhluUkSfPvkoYqGZfwJbAZiBaE2ZaePQ
         vtC+ivt+XIfLtMU7K9jjrRzncGHNk6sGEPn5D5COnYTOnPnBiblsCPGPyt6JLS2oBeaP
         WtfZqVA/UgdBFZzd3qqTDv7ItZr4iCVpHLvKIBQMV7SeT5jpUwNHuswWMhs187ojlaf0
         OTJYhvwnLL450ZUYEdtjgTABSLENJGLJdMvSJcj0ffPNATKCKxQQE7JVliML5goYlyg2
         FhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992981; x=1708597781;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WOZYu1ABQvI0PZXp/i2IDZ9BkIUgU3t3A1/nH+ofTY=;
        b=OlPwq5lsLOzEOOyiGwWeFuQQprIIncysf++HTolcVdOl72j6O+qMiRdlK1cuUZVJVg
         u1oHrH++m79+yc6tp2BGhFyyPoRMGYDGiB0IIIBf2gNHeFO1CWzefbRu0PqD2kgw5bnk
         sPxMKwnS2xRwBENrT8eccE3V3fLqj++DLCeveIgU8RneUoWk+fLeV1/kzBQNKdcoNe54
         LFr2LScXUcpWK8Xp83JCmtw9LeMsiUdfARQYsMUEVgGpkaCZwnF6+VBKHA+rfuR9TId+
         WMgQdvh+s40qspnHsyRS9tZe5OxUcj7yWbLZCbNvpgZqcdgW5Ry+3U/tgKBUfSiIWkUc
         UMtA==
X-Gm-Message-State: AOJu0YzuQEVtpAjoxoUpP3vGdkEnM4bhiRlEM5A7Mhvyo9/dH1AWK96D
	tvlekbWYiRcaWMddX/neUEKNmcKJAIKIknOcUzbwHDEIBaNWHN8gs0aB/+Ez
X-Google-Smtp-Source: AGHT+IGASUNnChhOj+iYzErwY/2RD2EFBRWppn1M4D9gZt1g71tQM+VozLAGDCLUYRqvJy8//3HEFg==
X-Received: by 2002:a05:6512:312c:b0:511:ab37:b2ae with SMTP id p12-20020a056512312c00b00511ab37b2aemr1109909lfd.20.1707992980588;
        Thu, 15 Feb 2024 02:29:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b20-20020a05600c4e1400b00411a595d56bsm1596966wmq.14.2024.02.15.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:29:40 -0800 (PST)
Message-ID: <5973bbe18aeecf486d8256cc402285665c45e66a.1707992978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
References: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
From: "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Feb 2024 10:29:32 +0000
Subject: [PATCH 1/7] fsmonitor: rebase with master
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
    "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason [ ]" <avarab@gmail.com>,
    "Glen Choo [ ]" <chooglen@google.com>,
    "Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
    "Taylor Blau [ ]" <me@ttaylorr.com>,
    marzi <m.ispare63@gmail.com>,
    Eric DeCosta <edecosta@mathworks.com>

From: Eric DeCosta <edecosta@mathworks.com>

rebased with master, and resolved conflicts
Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-health-linux.c    | 24 ++++++++++
 compat/fsmonitor/fsm-ipc-darwin.c      | 57 +----------------------
 compat/fsmonitor/fsm-ipc-linux.c       |  1 +
 compat/fsmonitor/fsm-ipc-unix.c        | 53 +++++++++++++++++++++
 compat/fsmonitor/fsm-settings-darwin.c | 64 +-------------------------
 compat/fsmonitor/fsm-settings-linux.c  |  1 +
 compat/fsmonitor/fsm-settings-unix.c   | 61 ++++++++++++++++++++++++
 7 files changed, 142 insertions(+), 119 deletions(-)
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
index 6f3a95410cc..4c3c92081ee 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -1,56 +1 @@
-#include "git-compat-util.h"
-#include "config.h"
-#include "gettext.h"
-#include "hex.h"
-#include "path.h"
-#include "repository.h"
-#include "strbuf.h"
-#include "fsmonitor-ll.h"
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
index 00000000000..eb25123fa12
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-unix.c
@@ -0,0 +1,53 @@
+#include "cache.h"
+#include "config.h"
+#include "hex.h"
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
index a3825906351..14baf9f0603 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -1,63 +1 @@
-#include "git-compat-util.h"
-#include "config.h"
-#include "fsmonitor-ll.h"
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
index 00000000000..d16dca89416
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-unix.c
@@ -0,0 +1,61 @@
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
+		free(fs.typename);
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

