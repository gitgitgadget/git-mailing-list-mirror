Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBABC32771
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 22:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiIUWTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiIUWSw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 18:18:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2882EA6C4D
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:18:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t7so12411009wrm.10
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=kXvDL18WzpuRcJMAjFp+DYG2ZaA0KG1/4xUiYPF5qqI=;
        b=A8MDhQ+n0rkvw1fF38z2+Pdrq6/Ak8DilvLZvknqJP55/wNMWZNJWMhAfplPsF7dSA
         sbQ/V9EEarRBsmdEZVI0dSSgILxLCT10HWoGQVYoCpM/pe3vmwemQ6OGrea9DScURbdh
         NJx5yIyTlqV4PKbqzBdiGkFpFlNM6G1Z/2cfJ0x6wTcKYcjANUKYN5xIM3NDG+HoRGQ9
         viubjYIlFs7DE4QIOgsWYnC5PRB3I03vYgx/lMcWWAWIQmtds+86qWFcJJwGS1WURU7M
         gI662Hv15JOHg95obaKUZun7/JUow04NofaBB58jycvHga4a5xR1qN0m4jerLxglc681
         xwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kXvDL18WzpuRcJMAjFp+DYG2ZaA0KG1/4xUiYPF5qqI=;
        b=EzO2lqJfgsB7NM+b1ym6Mi3l13N3UfoIy/rr4zhjuDXRE+77H8lk+rUVdWYJ6pTYEU
         pJZp1jiOSXR86/Sx5aIoVom4IX0bfd5M/GkOFCM5tUpB+kibHDVQ+pQNV7E3T/B4dttJ
         5dShwE0wv3Pht6atj49GSmOxHxdfIFr0k+StrIkkjjjIZSQRGeMrtqn70ANCQ4ZH5mL6
         Eok07SBBbGSs/EAFcVLSUxuxu4wqeRM1bX64bAOJNywlWqyGbPzq9WBoKUNQJ/B3Kmfx
         lejNKl2juXIHVYcU4jVsJnFl8jgyUkqSKlQ4/VNppF1D2VzM/4CC+ElTRFd5GFjclBw4
         JJoQ==
X-Gm-Message-State: ACrzQf1xUgrBt9PDmqQdizlZeOrziG4QWsgeYvyKEGHG2+y0MCvn/LUR
        dN6yfRa+kBVxcpkdcoIc8I00tcpYSsk=
X-Google-Smtp-Source: AMsMyM4VkZ7Zy6FF4DQmCiOjcZMePoEFeSEiNsr92L3+6ATtxmIUOIktjnZx3yyt+bsb+yq/nNtzpg==
X-Received: by 2002:adf:dd8f:0:b0:22a:84ab:4be3 with SMTP id x15-20020adfdd8f000000b0022a84ab4be3mr166766wrl.40.1663798729284;
        Wed, 21 Sep 2022 15:18:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15-20020a1cc90f000000b003b2878b9e0dsm4023508wmb.20.2022.09.21.15.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:18:48 -0700 (PDT)
Message-Id: <1a516fd9214492c95c6159695b989c724314bdb9.1663798722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
References: <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
        <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Sep 2022 22:18:40 +0000
Subject: [PATCH v11 4/6] fsmonitor: deal with synthetic firmlinks on macOS
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
 compat/fsmonitor/fsm-listen-darwin.c     | 14 +++-
 compat/fsmonitor/fsm-path-utils-darwin.c | 92 ++++++++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-win32.c  | 17 +++++
 fsmonitor--daemon.h                      |  3 +
 fsmonitor-path-utils.h                   | 36 ++++++++++
 6 files changed, 168 insertions(+), 2 deletions(-)

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
index 8e208e8289e..daeee4e465c 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -26,6 +26,7 @@
 #include "fsmonitor.h"
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
+#include "fsmonitor-path-utils.h"
 
 struct fsm_listen_data
 {
@@ -198,8 +199,9 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
 	const char *path_k;
 	const char *slash;
-	int k;
+	char *resolved = NULL;
 	struct strbuf tmp = STRBUF_INIT;
+	int k;
 
 	/*
 	 * Build a list of all filesystem changes into a private/local
@@ -209,7 +211,12 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 		/*
 		 * On Mac, we receive an array of absolute paths.
 		 */
-		path_k = paths[k];
+		free(resolved);
+		resolved = fsmonitor__resolve_alias(paths[k], &state->alias);
+		if (resolved)
+			path_k = resolved;
+		else
+			path_k = paths[k];
 
 		/*
 		 * If you want to debug FSEvents, log them to GIT_TRACE_FSMONITOR.
@@ -238,6 +245,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			fsmonitor_force_resync(state);
 			fsmonitor_batch__free_list(batch);
 			string_list_clear(&cookie_list, 0);
+			batch = NULL;
 
 			/*
 			 * We assume that any events that we received
@@ -360,12 +368,14 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 		}
 	}
 
+	free(resolved);
 	fsmonitor_publish(state, batch, &cookie_list);
 	string_list_clear(&cookie_list, 0);
 	strbuf_release(&tmp);
 	return;
 
 force_shutdown:
+	free(resolved);
 	fsmonitor_batch__free_list(batch);
 	string_list_clear(&cookie_list, 0);
 
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

