Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9955FECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 19:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiISTiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 15:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiISTiG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 15:38:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0996D1759A
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:38:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y5so783010wrh.3
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=RieE0QInLL2f3TtewJjo66wdOAFxsTbnPd6eR1ZyKCY=;
        b=GjJWdUDDLVxddEG3K9Bwo1q5ZS/36D3+VpssPvea1piEedZgXsXjSR90NzPQQJs6kr
         IZGH73z1/oRkTnpsKAAMUGKdKysHJoZQStaUKxm1gE7Otb0spcBzViLULW6T7tctmeCT
         KjF9bJ1DOGrNgDjUEMIaFMhPbUsVeK+zXKJ3wykx6fnv7yNuknQizkt2MQviYe/jFPXr
         xEZ6Uxwof3ri6aD2vM4kNRixyAujFyU5cUB1zl1d60rwBYVF8etgSpVlNSSznjQ9ZjrX
         YYIt0bqXlRHlYvilUzHHhIsqLaoy/FHrBhmDTrZ9P0AIbJeUaVnG61lNLwqJDMyZCb+e
         5DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RieE0QInLL2f3TtewJjo66wdOAFxsTbnPd6eR1ZyKCY=;
        b=O+H2HF9LKd3K01lzBxdie4/NPGK7JwSPUu1RzMUmsUFIa6DEdhPekwtdNoq+i0R7CD
         I80lmW73pYwufXjLOO5KdlsEV6YU1C6SCPwlNHPtzQDydAq6wTWv/oMpakv4iMk3D2rx
         4mhMXfpMrY4VpzEhR59Y2oT4mZukGAh8bNTJw8KkRTp0WkOkug3W9Amh8SJHLdL0FUkJ
         e3EJBxx+KUheNimVSLba2FP5lPpoyMkFx3wFwRejzSuYz8Z0rtsMET3KMp8cU65Cfs1X
         XzRZjDDR8uuYC1UblP7x26fJo5aAn4xwAjA8H9x2SilQ6IUXc9ViXotXnIsTxjSqCA+r
         KjjA==
X-Gm-Message-State: ACrzQf03XTuQrr9EyqC6wQ4WOdVMEMnTM1oRGXa7B33RfVowe9kOU9f/
        WsIJShsM+zIO94ZCHnWus8Ibafdxmzc=
X-Google-Smtp-Source: AMsMyM6IGE6Fab0XnlAADs+vTGm/Ff/obh9efDyXDPY2CCYhT6xdDzGO3LhyxjzHDPN9kN2mqILeGg==
X-Received: by 2002:a5d:6a07:0:b0:228:dba4:2138 with SMTP id m7-20020a5d6a07000000b00228dba42138mr11465121wru.346.1663616282273;
        Mon, 19 Sep 2022 12:38:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c128c00b003b4931eb435sm14265446wmd.26.2022.09.19.12.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:38:01 -0700 (PDT)
Message-Id: <73afd9f31229a50a7c23271a66e842647378628a.1663616277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
References: <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
        <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 19:37:55 +0000
Subject: [PATCH v9 4/6] fsmonitor: deal with synthetic firmlinks on macOS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Starting with macOS 10.15 (Catalina), Apple introduced a new feature
called 'firmlinks' in order to separate the boot volume into two
volumes, one read-only and one writable but still present them to the
user as a single volume. Along with this change, Apple removed the
ability to create symlinks in the root directory and replaced them with
'synthetic firmlinks'. See 'man synthetic.conf'

When FSEevents reports the path of changed files, if the path involves
a synthetic firmlink, the path is reported from the point of the
synthetic firmlink and not the real path. For example:

Real path:
/System/Volumes/Data/network/working/directory/foo.txt

Synthetic firmlink:
/network -> /System/Volumes/Data/network

FSEvents path:
/network/working/directory/foo.txt

This causes the FSEvents path to not match against the worktree
directory.

There are several ways in which synthetic firmlinks can be created:
they can be defined in /etc/synthetic.conf, the automounter can create
them, and there may be other means. Simply reading /etc/synthetic.conf
is insufficient. No matter what process creates synthetic firmlinks,
they all get created in the root directory.

Therefore, in order to deal with synthetic firmlinks, the root directory
is scanned and the first possible synthetic firmink that, when resolved,
is a prefix of the worktree is used to map FSEvents paths to worktree
paths.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 builtin/fsmonitor--daemon.c              |  8 +++
 compat/fsmonitor/fsm-listen-darwin.c     |  6 +-
 compat/fsmonitor/fsm-path-utils-darwin.c | 92 ++++++++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-win32.c  | 17 +++++
 fsmonitor--daemon.h                      |  3 +
 fsmonitor-path-utils.h                   | 36 ++++++++++
 6 files changed, 161 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 0123fc33ed2..56fcd1c2baa 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -3,6 +3,7 @@
 #include "parse-options.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
+#include "fsmonitor-path-utils.h"
 #include "compat/fsmonitor/fsm-health.h"
 #include "compat/fsmonitor/fsm-listen.h"
 #include "fsmonitor--daemon.h"
@@ -1282,6 +1283,13 @@ static int fsmonitor_run_daemon(void)
 	strbuf_addstr(&state.path_worktree_watch, absolute_path(get_git_work_tree()));
 	state.nr_paths_watching = 1;
 
+	state.alias.alias = NULL;
+	state.alias.points_to = NULL;
+	if (fsmonitor__get_alias(state.path_worktree_watch.buf, &state.alias)) {
+		err = error(_("could not get worktree alias"));
+		goto done;
+	}
+
 	/*
 	 * We create and delete cookie files somewhere inside the .git
 	 * directory to help us keep sync with the file system.  If
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 8e208e8289e..179886bc15b 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -26,6 +26,7 @@
 #include "fsmonitor.h"
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
+#include "fsmonitor-path-utils.h"
 
 struct fsm_listen_data
 {
@@ -209,7 +210,9 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 		/*
 		 * On Mac, we receive an array of absolute paths.
 		 */
-		path_k = paths[k];
+		path_k = fsmonitor__resolve_alias(paths[k], &state->alias);
+		if (!path_k)
+			path_k = paths[k];
 
 		/*
 		 * If you want to debug FSEvents, log them to GIT_TRACE_FSMONITOR.
@@ -238,6 +241,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			fsmonitor_force_resync(state);
 			fsmonitor_batch__free_list(batch);
 			string_list_clear(&cookie_list, 0);
+			batch = NULL;
 
 			/*
 			 * We assume that any events that we received
diff --git a/compat/fsmonitor/fsm-path-utils-darwin.c b/compat/fsmonitor/fsm-path-utils-darwin.c
index 067cbe6990a..13807f58e95 100644
--- a/compat/fsmonitor/fsm-path-utils-darwin.c
+++ b/compat/fsmonitor/fsm-path-utils-darwin.c
@@ -1,5 +1,8 @@
 #include "fsmonitor.h"
 #include "fsmonitor-path-utils.h"
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
 #include <sys/param.h>
 #include <sys/mount.h>
 
@@ -38,3 +41,92 @@ int fsmonitor__is_fs_remote(const char *path)
 		return -1;
 	return fs.is_remote;
 }
+
+/*
+ * Scan the root directory for synthetic firmlinks that when resolved
+ * are a prefix of the path, stopping at the first one found.
+ *
+ * Some information about firmlinks and synthetic firmlinks:
+ * https://eclecticlight.co/2020/01/23/catalina-boot-volumes/
+ *
+ * macOS no longer allows symlinks in the root directory; any link found
+ * there is therefore a synthetic firmlink.
+ *
+ * If this function gets called often, will want to cache all the firmlink
+ * information, but for now there is only one caller of this function.
+ *
+ * If there is more than one alias for the path, that is another
+ * matter altogether.
+ */
+int fsmonitor__get_alias(const char *path, struct alias_info *info)
+{
+	DIR * dir;
+	int read;
+	int retval;
+	struct dirent *de;
+	struct strbuf alias;
+	struct strbuf points_to;
+
+	retval = 0;
+	dir = opendir("/");
+	if (!dir)
+		return -1;
+
+	strbuf_init(&alias, 256);
+	strbuf_init(&points_to, MAXPATHLEN);
+
+	while ((de = readdir(dir)) != NULL) {
+		strbuf_reset(&alias);
+		strbuf_addch(&alias, '/');
+		strbuf_add(&alias, de->d_name, strlen(de->d_name));
+
+		read = readlink(alias.buf, points_to.buf, MAXPATHLEN);
+		if (read > 0) {
+			strbuf_setlen(&points_to, read);
+			if ((strncmp(points_to.buf, path, points_to.len) == 0)
+				&& path[points_to.len] == '/') {
+				info->alias = strbuf_detach(&alias, NULL);
+				info->points_to = strbuf_detach(&points_to, NULL);
+				trace_printf_key(&trace_fsmonitor,
+					"Found alias for '%s' : '%s' -> '%s'",
+					path, info->alias, info->points_to);
+				retval = 0;
+				goto done;
+			}
+		} else if (errno != EINVAL) { /* Something other than not a link */
+			trace_printf_key(&trace_fsmonitor, "Error %s", strerror(errno));
+			retval = -1;
+			goto done;
+		}
+	}
+
+	done:
+	closedir(dir);
+	strbuf_release(&alias);
+	strbuf_release(&points_to);
+	return retval;
+}
+
+char *fsmonitor__resolve_alias(const char *path,
+	const struct alias_info *info)
+{
+	int len = info->alias ? strlen(info->alias) : 0;
+
+	if (!len)
+		return NULL;
+
+	if ((strncmp(info->alias, path, len) == 0)
+		&& path[len] == '/') {
+		struct strbuf tmp;
+		const char *remainder = path + len;
+		int ptr_len = strlen(info->points_to);
+		int rem_len = strlen(remainder);
+
+		strbuf_init(&tmp, ptr_len + rem_len);
+		strbuf_add(&tmp, info->points_to, ptr_len);
+		strbuf_add(&tmp, remainder, rem_len);
+		return strbuf_detach(&tmp, NULL);
+	}
+
+	return NULL;
+}
diff --git a/compat/fsmonitor/fsm-path-utils-win32.c b/compat/fsmonitor/fsm-path-utils-win32.c
index a90b8f7925b..0d95bbb416f 100644
--- a/compat/fsmonitor/fsm-path-utils-win32.c
+++ b/compat/fsmonitor/fsm-path-utils-win32.c
@@ -126,3 +126,20 @@ int fsmonitor__is_fs_remote(const char *path)
 		return -1;
 	return fs.is_remote;
 }
+
+/*
+ * No-op for now.
+ */
+int fsmonitor__get_alias(const char *path, struct alias_info *info)
+{
+	return 0;
+}
+
+/*
+ * No-op for now.
+ */
+char *fsmonitor__resolve_alias(const char *path,
+	const struct alias_info *info)
+{
+	return NULL;
+}
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 2102a5c9ff5..e24838f9a86 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -8,6 +8,7 @@
 #include "run-command.h"
 #include "simple-ipc.h"
 #include "thread-utils.h"
+#include "fsmonitor-path-utils.h"
 
 struct fsmonitor_batch;
 struct fsmonitor_token_data;
@@ -43,6 +44,7 @@ struct fsmonitor_daemon_state {
 
 	struct strbuf path_worktree_watch;
 	struct strbuf path_gitdir_watch;
+	struct alias_info alias;
 	int nr_paths_watching;
 
 	struct fsmonitor_token_data *current_token_data;
@@ -59,6 +61,7 @@ struct fsmonitor_daemon_state {
 
 	struct ipc_server_data *ipc_server_data;
 	struct strbuf path_ipc;
+
 };
 
 /*
diff --git a/fsmonitor-path-utils.h b/fsmonitor-path-utils.h
index e48592887e7..50ef37e57bb 100644
--- a/fsmonitor-path-utils.h
+++ b/fsmonitor-path-utils.h
@@ -1,6 +1,14 @@
 #ifndef FSM_PATH_UTILS_H
 #define FSM_PATH_UTILS_H
 
+#include "strbuf.h"
+
+struct alias_info
+{
+	char *alias;
+	char *points_to;
+};
+
 struct fs_info {
 	int is_remote;
 	char *typename;
@@ -20,4 +28,32 @@ int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info);
  */
 int fsmonitor__is_fs_remote(const char *path);
 
+/*
+ * Get the alias in given path, if any.
+ *
+ * Sets alias to the first alias that matches any part of the path.
+ *
+ * If an alias is found, info.alias and info.points_to are set to the
+ * found mapping.
+ *
+ * Returns -1 on error, 0 otherwise.
+ *
+ * The caller owns the storage that is occupied by set info.alias and
+ * info.points_to and is responsible for releasing it with `free(3)`
+ * when done.
+ */
+int fsmonitor__get_alias(const char *path, struct alias_info *info);
+
+/*
+ * Resolve the path against the given alias.
+ *
+ * Returns the resolved path if there is one, NULL otherwise.
+ *
+ * The caller owns the storage that the returned string occupies and
+ * is responsible for releasing it with `free(3)` when done.
+ */
+char *fsmonitor__resolve_alias(const char *path,
+	const struct alias_info *info);
+
+
 #endif
-- 
gitgitgadget

