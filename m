Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE3569D34
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992991; cv=none; b=MDQOUa+5zD7jevpONL5XTWpX1D24uQA3zqkuQTQ1CDFf+qOuITWU/ycAAaWzu+dsl8eCFnyp8DSCiMo77kcbTNStREQOuacad7C1Knj2uObvkLA1Q7JvJrJvCZWkG9OqyZMDBzkRPnL8w2nO8B8XI9g0jQds7cFhuyy1hXhU3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992991; c=relaxed/simple;
	bh=nXQ9VvGpqjK3Uc7GAGaSN5daE5jlPhL1iIQuhanR8Ew=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K8RXntmY681r3MkAQg+u8Vf4ugFaV/nUbOYZrPIlh96fNwOehlIyoaA+muEmSCnTQjfGyFQXw6POE+i7R4naTPZ7oopln8INrbUCga+p+6iHphaKuRIDKI8KBwTpuJiFmibkUWHd3WRQMI95llWtysAE7d71B32IY2LA2U0TD0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQJ6ekh0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQJ6ekh0"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so5867365e9.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 02:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707992987; x=1708597787; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpwII30pFsHq6LzWmfSIj9WqnFhvkGsh+DhS9dmzDIo=;
        b=JQJ6ekh02Vsn7wI3jkLnIvhzEZ1S7CyXQHyXyno9YU2hNJv3bZMErspQaxTB8bMmC3
         6PM8jpTfJ1PW5wc7+MgqBCSeQPV9xO2emDY21en8y/7PTbhrAxaThc9fLhgiBJN+/9H7
         0RgSysd7EmBiuFVgrfJ2qEFw1mHZfRhVyReexBu/i4owyKP0oq3FTjnj5uwPOm079LHK
         rk7URb7k+ixp+mkFwDM2Y4YiiNYZQjqZH3LsogAmtWlkxAcz6a6v4fgPDdHptHQpmkgk
         dMM5gbiGxIpHIVkiYSOpP+2qiMqvsmp5A5EkroMWCdCMe4Yz6FG/D6AQ4YeRWz5jwHbD
         2kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992987; x=1708597787;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpwII30pFsHq6LzWmfSIj9WqnFhvkGsh+DhS9dmzDIo=;
        b=LqtzWarx18yAupLdwzCtooQd3ugOinrNdD2SjFk5TCi3csAmq3CbSLbV4BqlOMcZ7v
         BtnKQNMTz6gQWJlkmuTHpwZBZbb26nClZBkg97T8zLbDVArk8k1VC66eWRc+lQY4cXkB
         gcVyQVjH5PFbXwAP50g9gQ8LyYwkgwGCzKJNt684aArsx6NeKNgqRn4m05erg0+5QErK
         myPBxk0MzshgyiIwfUTthPhg2DIGcpWH9ZIDJ+CLT9j3QfwVeUYcEEkm6bTQ2m9Fd3BB
         IErzoPdgzqQVcVvFC1wVO5VAxntVJVzyf/iZXVnm0ETH3O/1rzqtBDbf9T9qinWZ4rsV
         0cew==
X-Gm-Message-State: AOJu0YxLzFmXAktlY1HGL/axw5rtLN1ENQsgCigW+svH4jY+iImIeCiX
	s3xc2moW0oOGqVw7Hs3/G+TxyCvoi0ykdWOPnq+wSCfXYesweOuA1ZOMD3Yn
X-Google-Smtp-Source: AGHT+IGMb1uwR7YoQug9cvFmPZI6ud2g0TQRq5f9eFslPtfKnlAZ2mtEvVGY8LJhWMwq1whHs4o0+Q==
X-Received: by 2002:a05:600c:1d26:b0:411:da90:89c0 with SMTP id l38-20020a05600c1d2600b00411da9089c0mr1071537wms.10.1707992987226;
        Thu, 15 Feb 2024 02:29:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c3b8200b00410c449f25asm4938615wms.6.2024.02.15.02.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:29:47 -0800 (PST)
Message-ID: <74a4fa335a7c2014a35be8556887170169360b36.1707992978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
References: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
From: "marzi.esipreh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Feb 2024 10:29:38 +0000
Subject: [PATCH 7/7] fsmonitor: addressed comments for patch 1352
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
    "marzi.esipreh" <marzi.esipreh@uber.com>

From: "marzi.esipreh" <marzi.esipreh@uber.com>

addressed comments on 1352, rebased, resolved conflicts

Signed-off-by: Marzieh Esipreh <m.ispare63@gmail.com>
---
 compat/fsmonitor/fsm-health-linux.c     |   2 +-
 compat/fsmonitor/fsm-ipc-unix.c         |   6 +-
 compat/fsmonitor/fsm-listen-linux.c     | 170 ++++++++++++------------
 compat/fsmonitor/fsm-path-utils-linux.c |   1 +
 compat/fsmonitor/fsm-settings-unix.c    |   3 +
 5 files changed, 95 insertions(+), 87 deletions(-)

diff --git a/compat/fsmonitor/fsm-health-linux.c b/compat/fsmonitor/fsm-health-linux.c
index b9f709e8548..4c291f8a066 100644
--- a/compat/fsmonitor/fsm-health-linux.c
+++ b/compat/fsmonitor/fsm-health-linux.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "fsmonitor.h"
 #include "fsm-health.h"
diff --git a/compat/fsmonitor/fsm-ipc-unix.c b/compat/fsmonitor/fsm-ipc-unix.c
index eb25123fa12..70afddfd298 100644
--- a/compat/fsmonitor/fsm-ipc-unix.c
+++ b/compat/fsmonitor/fsm-ipc-unix.c
@@ -1,10 +1,12 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "hex.h"
 #include "strbuf.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
 #include "fsmonitor-path-utils.h"
+#include "gettext.h"
+#include "path.h"
 
 static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
 
@@ -17,7 +19,7 @@ const char *fsmonitor_ipc__get_path(struct repository *r)
 	unsigned char hash[GIT_MAX_RAWSZ];
 
 	if (!r)
-		BUG("No repository passed into fsmonitor_ipc__get_path");
+		BUG("no repository passed into fsmonitor_ipc__get_path");
 
 	if (ipc_path)
 		return ipc_path;
diff --git a/compat/fsmonitor/fsm-listen-linux.c b/compat/fsmonitor/fsm-listen-linux.c
index e8548e4e009..84d8fb28d5d 100644
--- a/compat/fsmonitor/fsm-listen-linux.c
+++ b/compat/fsmonitor/fsm-listen-linux.c
@@ -1,7 +1,10 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "config.h"
 #include "fsmonitor.h"
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
+#include "gettext.h"
+#include "simple-ipc.h"
 #include <dirent.h>
 #include <fcntl.h>
 #include <sys/inotify.h>
@@ -129,15 +132,15 @@ static void remove_watch(struct watch_entry *w,
 	hashmap_entry_init(&k1.ent, memhash(&w->wd, sizeof(int)));
 	w1 = hashmap_remove_entry(&data->watches, &k1, ent, NULL);
 	if (!w1)
-		BUG("Double remove of watch for '%s'", w->dir);
+		BUG("double remove of watch for '%s'", w->dir);
 
 	if (w1->cookie)
-		BUG("Removing watch for '%s' which has a pending rename", w1->dir);
+		BUG("removing watch for '%s' which has a pending rename", w1->dir);
 
 	hashmap_entry_init(&k2.ent, memhash(w->dir, strlen(w->dir)));
 	w2 = hashmap_remove_entry(&data->revwatches, &k2, ent, NULL);
 	if (!w2)
-		BUG("Double remove of reverse watch for '%s'", w->dir);
+		BUG("double remove of reverse watch for '%s'", w->dir);
 
 	/* w1->dir and w2->dir are interned strings, we don't own them */
 	free(w1);
@@ -187,7 +190,7 @@ static void add_dir_rename(uint32_t cookie, const char *path,
 	hashmap_entry_init(&k.ent, memhash(path, strlen(path)));
 	w = hashmap_get_entry(&data->revwatches, &k, ent, NULL);
 	if (!w) /* should never happen */
-		BUG("No watch for '%s'", path);
+		BUG("no watch for '%s'", path);
 	w->cookie = cookie;
 
 	/* add the pending rename to match against later */
@@ -224,10 +227,10 @@ static void rename_dir(uint32_t cookie, const char *path,
 			remove_watch(w, data);
 			add_watch(path, data);
 		} else {
-			BUG("No matching watch");
+			BUG("no matching watch");
 		}
 	} else {
-		BUG("No matching cookie");
+		BUG("no matching cookie");
 	}
 }
 
@@ -249,7 +252,7 @@ static int register_inotify(const char *path,
 	if (!dir)
 		return error_errno("opendir('%s') failed", path);
 
-	while ((de = readdir_skip_dot_and_dotdot(dir)) != NULL) {
+	while ((de = readdir_skip_dot_and_dotdot(dir))) {
 		strbuf_reset(&current);
 		strbuf_addf(&current, "%s/%s", path, de->d_name);
 		if (lstat(current.buf, &fs)) {
@@ -353,7 +356,7 @@ static void log_mask_set(const char *path, u_int32_t mask)
 	if (mask & IN_IGNORED)
 		strbuf_addstr(&msg, "IN_IGNORED|");
 	if (mask & IN_ISDIR)
-		strbuf_addstr(&msg, "IN_ISDIR|");
+		strbuf_addstr(&msg, "IN_ISDIR");
 
 	trace_printf_key(&trace_fsmonitor, "inotify_event: '%s', mask=%#8.8x %s",
 				path, mask, msg.buf);
@@ -373,8 +376,10 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 	data->shutdown = SHUTDOWN_ERROR;
 
 	fd = inotify_init1(O_NONBLOCK);
-	if (fd < 0)
+	if (fd < 0) {
+		FREE_AND_NULL(data);
 		return error_errno("inotify_init1() failed");
+	}
 
 	data->fd_inotify = fd;
 
@@ -386,12 +391,10 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 		ret = -1;
 	else if (register_inotify(state->path_worktree_watch.buf, state, NULL))
 		ret = -1;
-	else if (state->nr_paths_watching > 1) {
-		if (add_watch(state->path_gitdir_watch.buf, data))
-			ret = -1;
-		else if (register_inotify(state->path_gitdir_watch.buf, state, NULL))
-			ret = -1;
-	}
+	else if (state->nr_paths_watching > 1 &&
+		 (add_watch(state->path_gitdir_watch.buf, data) ||
+		  register_inotify(state->path_gitdir_watch.buf, state, NULL)))
+		ret = -1;
 
 	if (!ret) {
 		state->listen_error_code = 0;
@@ -449,80 +452,80 @@ static int process_event(const char *path,
 	const char *last_sep;
 
 	switch (fsmonitor_classify_path_absolute(state, path)) {
-		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
-		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
-			/* Use just the filename of the cookie file. */
-			last_sep = find_last_dir_sep(path);
-			string_list_append(cookie_list,
-					last_sep ? last_sep + 1 : path);
-			break;
-		case IS_INSIDE_DOT_GIT:
-		case IS_INSIDE_GITDIR:
-			break;
-		case IS_DOT_GIT:
-		case IS_GITDIR:
-			/*
-			* If .git directory is deleted or renamed away,
-			* we have to quit.
-			*/
-			if (em_dir_deleted(event->mask)) {
-				trace_printf_key(&trace_fsmonitor,
-						"event: gitdir removed");
-				state->listen_data->shutdown = SHUTDOWN_FORCE;
-				goto done;
-			}
+	case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
+	case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
+		/* Use just the filename of the cookie file. */
+		last_sep = find_last_dir_sep(path);
+		string_list_append(cookie_list,
+				last_sep ? last_sep + 1 : path);
+		break;
+	case IS_INSIDE_DOT_GIT:
+	case IS_INSIDE_GITDIR:
+		break;
+	case IS_DOT_GIT:
+	case IS_GITDIR:
+		/*
+		* If .git directory is deleted or renamed away,
+		* we have to quit.
+		*/
+		if (em_dir_deleted(event->mask)) {
+			trace_printf_key(&trace_fsmonitor,
+					"event: gitdir removed");
+			state->listen_data->shutdown = SHUTDOWN_FORCE;
+			goto done;
+		}
 
-			if (em_dir_renamed(event->mask)) {
-				trace_printf_key(&trace_fsmonitor,
-						"event: gitdir renamed");
-				state->listen_data->shutdown = SHUTDOWN_FORCE;
-				goto done;
-			}
-			break;
-		case IS_WORKDIR_PATH:
-			/* normal events in the working directory */
-			if (trace_pass_fl(&trace_fsmonitor))
-				log_mask_set(path, event->mask);
+		if (em_dir_renamed(event->mask)) {
+			trace_printf_key(&trace_fsmonitor,
+					"event: gitdir renamed");
+			state->listen_data->shutdown = SHUTDOWN_FORCE;
+			goto done;
+		}
+		break;
+	case IS_WORKDIR_PATH:
+		/* normal events in the working directory */
+		if (trace_pass_fl(&trace_fsmonitor))
+			log_mask_set(path, event->mask);
 
-			rel = path + state->path_worktree_watch.len + 1;
-			fsmonitor_batch__add_path(batch, rel);
+		rel = path + state->path_worktree_watch.len + 1;
+		fsmonitor_batch__add_path(batch, rel);
 
-			if (em_dir_deleted(event->mask))
-				break;
+		if (em_dir_deleted(event->mask))
+			break;
 
-			/* received IN_MOVE_FROM, add tracking for expected IN_MOVE_TO */
-			if (em_rename_dir_from(event->mask))
-				add_dir_rename(event->cookie, path, state->listen_data);
+		/* received IN_MOVE_FROM, add tracking for expected IN_MOVE_TO */
+		if (em_rename_dir_from(event->mask))
+			add_dir_rename(event->cookie, path, state->listen_data);
 
-			/* received IN_MOVE_TO, update watch to reflect new path */
-			if (em_rename_dir_to(event->mask)) {
-				rename_dir(event->cookie, path, state->listen_data);
-				if (register_inotify(path, state, batch)) {
-					state->listen_data->shutdown = SHUTDOWN_ERROR;
-					goto done;
-				}
+		/* received IN_MOVE_TO, update watch to reflect new path */
+		if (em_rename_dir_to(event->mask)) {
+			rename_dir(event->cookie, path, state->listen_data);
+			if (register_inotify(path, state, batch)) {
+				state->listen_data->shutdown = SHUTDOWN_ERROR;
+				goto done;
 			}
+		}
 
-			if (em_dir_created(event->mask)) {
-				if (add_watch(path, state->listen_data)) {
-					state->listen_data->shutdown = SHUTDOWN_ERROR;
-					goto done;
-				}
-				if (register_inotify(path, state, batch)) {
-					state->listen_data->shutdown = SHUTDOWN_ERROR;
-					goto done;
-				}
+		if (em_dir_created(event->mask)) {
+			if (add_watch(path, state->listen_data)) {
+				state->listen_data->shutdown = SHUTDOWN_ERROR;
+				goto done;
 			}
-			break;
-		case IS_OUTSIDE_CONE:
-		default:
-			trace_printf_key(&trace_fsmonitor,
-					"ignoring '%s'", path);
-			break;
+			if (register_inotify(path, state, batch)) {
+				state->listen_data->shutdown = SHUTDOWN_ERROR;
+				goto done;
+			}
+		}
+		break;
+	case IS_OUTSIDE_CONE:
+	default:
+		trace_printf_key(&trace_fsmonitor,
+				"ignoring '%s'", path);
+		break;
 	}
 	return 0;
-done:
-	return -1;
+	done:
+		return -1;
 }
 
 /*
@@ -531,7 +534,7 @@ static int process_event(const char *path,
  */
 static void handle_events(struct fsmonitor_daemon_state *state)
 {
-	 /* See https://man7.org/linux/man-pages/man7/inotify.7.html */
+	/* See https://man7.org/linux/man-pages/man7/inotify.7.html */
 	char buf[4096]
 		__attribute__ ((aligned(__alignof__(struct inotify_event))));
 
@@ -539,13 +542,12 @@ static void handle_events(struct fsmonitor_daemon_state *state)
 	struct fsmonitor_batch *batch = NULL;
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
 	struct watch_entry k, *w;
-	struct strbuf path;
 	const struct inotify_event *event;
 	int fd = state->listen_data->fd_inotify;
 	ssize_t len;
 	char *ptr, *p;
 
-	strbuf_init(&path, PATH_MAX);
+	struct strbuf path = STRBUF_INIT;
 
 	for(;;) {
 		len = read(fd, buf, sizeof(buf));
@@ -581,7 +583,7 @@ static void handle_events(struct fsmonitor_daemon_state *state)
 
 			w = hashmap_get_entry(&watches, &k, ent, NULL);
 			if (!w) /* should never happen */
-				BUG("No watch for '%s'", event->name);
+				BUG("no watch for '%s'", event->name);
 
 			/* directory watch was removed */
 			if (em_remove_watch(event->mask)) {
diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
index c21d1349532..0e3b33ffa48 100644
--- a/compat/fsmonitor/fsm-path-utils-linux.c
+++ b/compat/fsmonitor/fsm-path-utils-linux.c
@@ -3,6 +3,7 @@
 #include "fsmonitor.h"
 #include "fsmonitor-path-utils.h"
 #include "fsm-path-utils-linux.h"
+#include "gettext.h"
 #include <errno.h>
 #include <mntent.h>
 #include <sys/mount.h>
diff --git a/compat/fsmonitor/fsm-settings-unix.c b/compat/fsmonitor/fsm-settings-unix.c
index d16dca89416..c9b75aa44fe 100644
--- a/compat/fsmonitor/fsm-settings-unix.c
+++ b/compat/fsmonitor/fsm-settings-unix.c
@@ -1,6 +1,9 @@
+#include "git-compat-util.h"
+#include "config.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
 #include "fsmonitor-path-utils.h"
+#include <stdint.h>
 
  /*
  * For the builtin FSMonitor, we create the Unix domain socket for the
-- 
gitgitgadget
