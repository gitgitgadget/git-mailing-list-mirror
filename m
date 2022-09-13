Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07851ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 20:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIMU2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 16:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiIMU17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 16:27:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF15659FB
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:27:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h8so15591238wrf.3
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=EHnpziIaNYWChUeJHuQFY8ynOoqWaRpiqtEdbVM+hiY=;
        b=YP1QeUGtRG6uasgrG1y3M8RIiiHnT2x8sbSRqREx5WFZNWbHB2mgh8d/uebJnzwEd6
         /hbRSUPvDZcOU3wUQtimDKLRur1uh5EyHXX9varcYWgp2puhrX9IVFk5F/34ZW7QK/Kr
         ZCCQ5JVXY/aBMF4tPk+0eufRm5tf+UeL34tmKaL6a0j4TTajJtCk9MlgNRk0AC4g92/4
         vu5a30PL4TpIRWmgl/ex9RyTFFAnuaWfcdvCB9Z4uBFn5mcfXUKZRk1i90xxXcrnR9cg
         RAonks//lCojVj23JbzWilpVthfo9GqLikz4UCUs6X1yAaRKW3UbbdC5V1YF/zveFbaa
         VxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EHnpziIaNYWChUeJHuQFY8ynOoqWaRpiqtEdbVM+hiY=;
        b=R1g6qdLJulZ0h/7/oTOzNjigfi9uYKGMrBed2w05et6lO94R0D2PWtrdmiJk/+TUcW
         QDSgXaA54fILrExwPMTaH3KFxzZa+NWTuPryInfFI7/CSJqLp/D9o2oA3dFfIQESPbpL
         nnSLL63tXrA13LmplO3XCvuP3gr39bVy2KEkP6VVsw+4TfhwXSkhVrU6BRc+1i3GPcz7
         ez1M1lF2Kg2IstovUQxe8rY0Rvb7Yln8l4hyEX0YhkepIGCYwP3fTEEw0/UjZPkNK9YN
         DG4fWTQNFX10JHvm4Zl4ArdfIKJ+XNBoh7gExdM3i9vvyfD+6owbdMSk4UVbNJMb63mb
         xQ2g==
X-Gm-Message-State: ACgBeo34erpTg4dNLqCXJfGMMZLzR/Ip4e9thMgHVfBarcL1Eln+xXiJ
        xlZUlvKxwMQBE0zPfHtST12P/w3B78o=
X-Google-Smtp-Source: AA6agR4oBHqDvy8XTuW9X/JyVmWLLq5iiI6aQuVrueYoXeHOc0cnfkIvaOk7idIdncw40y6yhfM5mw==
X-Received: by 2002:a05:6000:1563:b0:222:c70e:b2a5 with SMTP id 3-20020a056000156300b00222c70eb2a5mr19806954wrz.492.1663100865832;
        Tue, 13 Sep 2022 13:27:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b003b48dac344esm8286823wmb.43.2022.09.13.13.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 13:27:45 -0700 (PDT)
Message-Id: <9c1f408ae6dabaed26e57b6b1946dd2bb5d91bb8.1663100859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
References: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
        <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 20:27:37 +0000
Subject: [PATCH v6 5/6] fsmonitor: deal with synthetic firmlinks on macOS
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
 fsmonitor--daemon.h                      |  6 ++
 fsmonitor-path-utils.h                   | 36 ++++++++++
 6 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 2c109cf8b37..32475962c92 100644
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
index 2102a5c9ff5..98cbb430083 100644
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
@@ -167,5 +170,8 @@ void fsmonitor_publish(struct fsmonitor_daemon_state *state,
  */
 void fsmonitor_force_resync(struct fsmonitor_daemon_state *state);
 
+char *fsmonitor_resolve_alias(const char *path,
+	struct alias_info *alias);
+
 #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
 #endif /* FSMONITOR_DAEMON_H */
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

