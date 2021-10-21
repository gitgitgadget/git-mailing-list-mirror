Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5337BC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D2F61221
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhJUO1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhJUO1a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3668C0613B9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m22so1521152wrb.0
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LDTU64WFptNk/iCaHfjIEBqLqjrKE0oTr84qceM5FAQ=;
        b=LBBZk1yyk8W/OmNCQX58j6OFLPyU7pFzvktuRPnahv53XcJY/2k4/CooKNsaWuIZoE
         0EQveBjDY7SEFxXs8hkdrQ4l+x+MaQAnWoUphaAHQxC5kCSpQewoUD6jCQ+igt0KnycF
         aqLPWjqLwHIc6CUSShctYsfybR6ypvsHGI4gKMxW37Oxt533yS7kbSP12luhpMXEOidq
         XhSw38sx3CLoNW24SZ3z44bNrFQ+fgh5/QslstNSIB94TttQ0Ud3Sj0dc1eurREch3C0
         QUfX+yRLElJzFe3H+xvIc4YaJLA2BtDtzDAX6ODbS9UUpZ5YU9hogtEgaAgDh5nnnsd8
         ephg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LDTU64WFptNk/iCaHfjIEBqLqjrKE0oTr84qceM5FAQ=;
        b=CEBMDj7f7WfE/mblAmH6NDn82LE9nNuSnNFhbyHgQ69yQtsdhSAKNjbgsIFBc6H/3g
         RrEG530HBXlP0VFnQxigl7DZNk/u2yV55mi/LmqFWMLmtfN+6Pr7cUXHpHxKsVl9tikQ
         NHxtmZaoEunnBydnw29mpkZj+iojvHnPjaMmbVPQsKjDQDtiBoSmSILkSN9JVXfY/G9U
         AK3J86NYfHUCWRVP1cBa1AWlyj6XwtBaWJIE6078t5iHqEPRWoh5ISZfQPoYl0EbNXJB
         XxsNGPvhCvPzQMtps3TyHqUF2nItwGt1ABMKQ+Ia5xvTVNMZ5g+6F88/XOFXlCXj//CD
         DtRA==
X-Gm-Message-State: AOAM533M8FbKtmPMFJicNX5OV0Yzq5WbnYjgETzOP7XREU7WGygLt7hK
        Kr8wkX7BssjVFAfI/n2Zz8fZQvuUS3Q=
X-Google-Smtp-Source: ABdhPJwjWaUdKZ/qj/O/7JKu3bBcBFp6IGC0gua1/cTdZmcDdVZ2gE5PO1x8Z5EWZz5D818LNDQTZw==
X-Received: by 2002:a5d:5989:: with SMTP id n9mr4273917wri.8.1634826312529;
        Thu, 21 Oct 2021 07:25:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f24sm4992060wmb.33.2021.10.21.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:12 -0700 (PDT)
Message-Id: <82f176921282d13daee08bde7244df5d22e01ce6.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:24:42 +0000
Subject: [PATCH v4 02/29] fsmonitor-ipc: create client routines for
 git-fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create fsmonitor_ipc__*() client routines to spawn the built-in file
system monitor daemon and send it an IPC request using the `Simple
IPC` API.

Stub in empty fsmonitor_ipc__*() functions for unsupported platforms.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile        |   1 +
 fsmonitor-ipc.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++
 fsmonitor-ipc.h |  48 +++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h

diff --git a/Makefile b/Makefile
index 381bed2c1d2..d51fd8b33ce 100644
--- a/Makefile
+++ b/Makefile
@@ -897,6 +897,7 @@ LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
+LIB_OBJS += fsmonitor-ipc.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
new file mode 100644
index 00000000000..ccc32d2a17e
--- /dev/null
+++ b/fsmonitor-ipc.c
@@ -0,0 +1,176 @@
+#include "cache.h"
+#include "fsmonitor.h"
+#include "simple-ipc.h"
+#include "fsmonitor-ipc.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "trace2.h"
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+int fsmonitor_ipc__is_supported(void)
+{
+	return 1;
+}
+
+GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
+
+enum ipc_active_state fsmonitor_ipc__get_state(void)
+{
+	return ipc_get_active_state(fsmonitor_ipc__get_path());
+}
+
+static int spawn_daemon(void)
+{
+	const char *args[] = { "fsmonitor--daemon", "start", NULL };
+
+	return run_command_v_opt_tr2(args, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
+				    "fsmonitor");
+}
+
+int fsmonitor_ipc__send_query(const char *since_token,
+			      struct strbuf *answer)
+{
+	int ret = -1;
+	int tried_to_spawn = 0;
+	enum ipc_active_state state = IPC_STATE__OTHER_ERROR;
+	struct ipc_client_connection *connection = NULL;
+	struct ipc_client_connect_options options
+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
+	const char *tok = since_token ? since_token : "";
+	size_t tok_len = since_token ? strlen(since_token) : 0;
+
+	options.wait_if_busy = 1;
+	options.wait_if_not_found = 0;
+
+	trace2_region_enter("fsm_client", "query", NULL);
+	trace2_data_string("fsm_client", NULL, "query/command", tok);
+
+try_again:
+	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
+				       &connection);
+
+	switch (state) {
+	case IPC_STATE__LISTENING:
+		ret = ipc_client_send_command_to_connection(
+			connection, tok, tok_len, answer);
+		ipc_client_close_connection(connection);
+
+		trace2_data_intmax("fsm_client", NULL,
+				   "query/response-length", answer->len);
+
+		if (fsmonitor_is_trivial_response(answer))
+			trace2_data_intmax("fsm_client", NULL,
+					   "query/trivial-response", 1);
+
+		goto done;
+
+	case IPC_STATE__NOT_LISTENING:
+	case IPC_STATE__PATH_NOT_FOUND:
+		if (tried_to_spawn)
+			goto done;
+
+		tried_to_spawn++;
+		if (spawn_daemon())
+			goto done;
+
+		/*
+		 * Try again, but this time give the daemon a chance to
+		 * actually create the pipe/socket.
+		 *
+		 * Granted, the daemon just started so it can't possibly have
+		 * any FS cached yet, so we'll always get a trivial answer.
+		 * BUT the answer should include a new token that can serve
+		 * as the basis for subsequent requests.
+		 */
+		options.wait_if_not_found = 1;
+		goto try_again;
+
+	case IPC_STATE__INVALID_PATH:
+		ret = error(_("fsmonitor_ipc__send_query: invalid path '%s'"),
+			    fsmonitor_ipc__get_path());
+		goto done;
+
+	case IPC_STATE__OTHER_ERROR:
+	default:
+		ret = error(_("fsmonitor_ipc__send_query: unspecified error on '%s'"),
+			    fsmonitor_ipc__get_path());
+		goto done;
+	}
+
+done:
+	trace2_region_leave("fsm_client", "query", NULL);
+
+	return ret;
+}
+
+int fsmonitor_ipc__send_command(const char *command,
+				struct strbuf *answer)
+{
+	struct ipc_client_connection *connection = NULL;
+	struct ipc_client_connect_options options
+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
+	int ret;
+	enum ipc_active_state state;
+	const char *c = command ? command : "";
+	size_t c_len = command ? strlen(command) : 0;
+
+	strbuf_reset(answer);
+
+	options.wait_if_busy = 1;
+	options.wait_if_not_found = 0;
+
+	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
+				       &connection);
+	if (state != IPC_STATE__LISTENING) {
+		die("fsmonitor--daemon is not running");
+		return -1;
+	}
+
+	ret = ipc_client_send_command_to_connection(connection, c, c_len,
+						    answer);
+	ipc_client_close_connection(connection);
+
+	if (ret == -1) {
+		die("could not send '%s' command to fsmonitor--daemon", c);
+		return -1;
+	}
+
+	return 0;
+}
+
+#else
+
+/*
+ * A trivial implementation of the fsmonitor_ipc__ API for unsupported
+ * platforms.
+ */
+
+int fsmonitor_ipc__is_supported(void)
+{
+	return 0;
+}
+
+const char *fsmonitor_ipc__get_path(void)
+{
+	return NULL;
+}
+
+enum ipc_active_state fsmonitor_ipc__get_state(void)
+{
+	return IPC_STATE__OTHER_ERROR;
+}
+
+int fsmonitor_ipc__send_query(const char *since_token,
+			      struct strbuf *answer)
+{
+	return -1;
+}
+
+int fsmonitor_ipc__send_command(const char *command,
+				struct strbuf *answer)
+{
+	return -1;
+}
+
+#endif
diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
new file mode 100644
index 00000000000..b6a7067c3af
--- /dev/null
+++ b/fsmonitor-ipc.h
@@ -0,0 +1,48 @@
+#ifndef FSMONITOR_IPC_H
+#define FSMONITOR_IPC_H
+
+#include "simple-ipc.h"
+
+/*
+ * Returns true if built-in file system monitor daemon is defined
+ * for this platform.
+ */
+int fsmonitor_ipc__is_supported(void);
+
+/*
+ * Returns the pathname to the IPC named pipe or Unix domain socket
+ * where a `git-fsmonitor--daemon` process will listen.  This is a
+ * per-worktree value.
+ *
+ * Returns NULL if the daemon is not supported on this platform.
+ */
+const char *fsmonitor_ipc__get_path(void);
+
+/*
+ * Try to determine whether there is a `git-fsmonitor--daemon` process
+ * listening on the IPC pipe/socket.
+ */
+enum ipc_active_state fsmonitor_ipc__get_state(void);
+
+/*
+ * Connect to a `git-fsmonitor--daemon` process via simple-ipc
+ * and ask for the set of changed files since the given token.
+ *
+ * Spawn a daemon process in the background if necessary.
+ *
+ * Returns -1 on error; 0 on success.
+ */
+int fsmonitor_ipc__send_query(const char *since_token,
+			      struct strbuf *answer);
+
+/*
+ * Connect to a `git-fsmonitor--daemon` process via simple-ipc and
+ * send a command verb.  If no daemon is available, we DO NOT try to
+ * start one.
+ *
+ * Returns -1 on error; 0 on success.
+ */
+int fsmonitor_ipc__send_command(const char *command,
+				struct strbuf *answer);
+
+#endif /* FSMONITOR_IPC_H */
-- 
gitgitgadget

