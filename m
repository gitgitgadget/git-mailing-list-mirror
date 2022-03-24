Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65240C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351885AbiCXQxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352160AbiCXQxF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80466B0A52
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a1so7478273wrh.10
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OdOAke1PbvIzBjHVOE+W3Y0Zz1uqSlskZrBguwt7v8k=;
        b=BvmRfmtgYAy8cLU8FJYuMNhNq6U4puC7tVoEqDJ88yaGcvtlH0+nz92AMchYfPrS4T
         KKDJjmk/nTTU23FbgJQHwwQGKObUPnui2CZQC1E4HDkZydrkWrPPwtLwsZFyp9smqOpk
         ki97MHmHdZVAWV8VpOt3Z3tky3VXGTo2sAGaokk4UNkSB/U0K2w4j5E/gE+p63nxC8wj
         5skKDgOa5gdWwP9dRtK4gISa4NB+fNadOPkha3sa6IpzottOSlY3WZ580qX/TklVxmP5
         wRqWZGUW2/Hl7C352jnl45yzIbSBV3aqsXN26Aci0N7ZEFGJ9rPfBO4cn/9ol+G0be4b
         V1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OdOAke1PbvIzBjHVOE+W3Y0Zz1uqSlskZrBguwt7v8k=;
        b=1qvuWrQZ7i2cwhE0UW7oJ20lFT+nMIDKW7mlkvcCAhKDRzJGZJbfQ9Gs1pHfKpwNst
         Pnv+dbj0FAa+AFZm6yVrRniDbR+ByEgTnNq26u8OToluduWtYfb/FmtoQ8EAhAm6zz+T
         ncNL+MzcGTdMAeDvShCgIrodySCiGDYekW5cgEWX3Mah/P0GtZR25qLuKtMTmehKwGVv
         YIGKqS4Nsi1krcq+t4tH/U9qJ+N8LkXx+gjVOk4hJ5YzEP2MQCDH9IiCRX05DVpsG+gW
         OJ3ukbfws0a/SX0zq6ndH8gpDgDZxdfUQtHqNncllAsttnsogXaUfEVWDeBnJR08XQlk
         yu6g==
X-Gm-Message-State: AOAM531aEjHKt+uLXZXHV4DFilEgIwW3cOxIiajZSAmWqOpkGptHGKN7
        j3LzgCLcsaY+eZlRelufxlxNmLCEKGA=
X-Google-Smtp-Source: ABdhPJx4C21AOmrYQ+QT8xevr9hBpeOBrVguEJ0o//0rQpKzgQWymmWQw2XERpbfuQ5UGqBWX/f5vQ==
X-Received: by 2002:adf:de81:0:b0:204:6a:9f3c with SMTP id w1-20020adfde81000000b00204006a9f3cmr5384745wrl.104.1648140683555;
        Thu, 24 Mar 2022 09:51:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b0038cbd8c41e9sm5306983wmq.12.2022.03.24.09.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:23 -0700 (PDT)
Message-Id: <23bfb8c5165ab3a2f9613533d120586c10cec191.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:50:54 +0000
Subject: [PATCH v4 01/27] fsm-listen-win32: handle shortnames
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

Teach FSMonitor daemon on Windows to recognize shortname paths as
aliases of normal longname paths.  FSMonitor clients, such as `git
status`, should receive the longname spelling of changed files (when
possible).

Sometimes we receive FS events using the shortname, such as when a CMD
shell runs "RENAME GIT~1 FOO" or "RMDIR GIT~1".  The FS notification
arrives using whatever combination of long and shortnames were used by
the other process.  (Shortnames do seem to be case normalized,
however.)

Use Windows GetLongPathNameW() to try to map the pathname spelling in
the notification event into the normalized longname spelling.  (This
can fail if the file/directory is deleted, moved, or renamed, because
we are asking the FS for the mapping in response to the event and
after it has already happened, but we try.)

Special case the shortname spelling of ".git" to avoid under-reporting
these events.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-win32.c | 363 +++++++++++++++++++++++-----
 t/t7527-builtin-fsmonitor.sh        |  65 +++++
 2 files changed, 374 insertions(+), 54 deletions(-)

diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 5b928ab66e5..3f1b68267bd 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -25,6 +25,9 @@ struct one_watch
 	DWORD count;
 
 	struct strbuf path;
+	wchar_t wpath_longname[MAX_PATH + 1];
+	DWORD wpath_longname_len;
+
 	HANDLE hDir;
 	HANDLE hEvent;
 	OVERLAPPED overlapped;
@@ -34,6 +37,21 @@ struct one_watch
 	 * need to later call GetOverlappedResult() and possibly CancelIoEx().
 	 */
 	BOOL is_active;
+
+	/*
+	 * Are shortnames enabled on the containing drive?  This is
+	 * always true for "C:/" drives and usually never true for
+	 * other drives.
+	 *
+	 * We only set this for the worktree because we only need to
+	 * convert shortname paths to longname paths for items we send
+	 * to clients.  (We don't care about shortname expansion for
+	 * paths inside a GITDIR because we never send them to
+	 * clients.)
+	 */
+	BOOL has_shortnames;
+	BOOL has_tilda;
+	wchar_t dotgit_shortname[16]; /* for 8.3 name */
 };
 
 struct fsmonitor_daemon_backend_data
@@ -51,17 +69,18 @@ struct fsmonitor_daemon_backend_data
 };
 
 /*
- * Convert the WCHAR path from the notification into UTF8 and
- * then normalize it.
+ * Convert the WCHAR path from the event into UTF8 and normalize it.
+ *
+ * `wpath_len` is in WCHARS not bytes.
  */
-static int normalize_path_in_utf8(FILE_NOTIFY_INFORMATION *info,
+static int normalize_path_in_utf8(wchar_t *wpath, DWORD wpath_len,
 				  struct strbuf *normalized_path)
 {
 	int reserve;
 	int len = 0;
 
 	strbuf_reset(normalized_path);
-	if (!info->FileNameLength)
+	if (!wpath_len)
 		goto normalize;
 
 	/*
@@ -70,12 +89,12 @@ static int normalize_path_in_utf8(FILE_NOTIFY_INFORMATION *info,
 	 * sequence of 2 UTF8 characters.  That should let us
 	 * avoid ERROR_INSUFFICIENT_BUFFER 99.9+% of the time.
 	 */
-	reserve = info->FileNameLength + 1;
+	reserve = 2 * wpath_len + 1;
 	strbuf_grow(normalized_path, reserve);
 
 	for (;;) {
-		len = WideCharToMultiByte(CP_UTF8, 0, info->FileName,
-					  info->FileNameLength / sizeof(WCHAR),
+		len = WideCharToMultiByte(CP_UTF8, 0,
+					  wpath, wpath_len,
 					  normalized_path->buf,
 					  strbuf_avail(normalized_path) - 1,
 					  NULL, NULL);
@@ -83,9 +102,7 @@ static int normalize_path_in_utf8(FILE_NOTIFY_INFORMATION *info,
 			goto normalize;
 		if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
 			error(_("[GLE %ld] could not convert path to UTF-8: '%.*ls'"),
-			      GetLastError(),
-			      (int)(info->FileNameLength / sizeof(WCHAR)),
-			      info->FileName);
+			      GetLastError(), (int)wpath_len, wpath);
 			return -1;
 		}
 
@@ -98,6 +115,152 @@ normalize:
 	return strbuf_normalize_path(normalized_path);
 }
 
+/*
+ * See if the worktree root directory has shortnames enabled.
+ * This will help us decide if we need to do an expensive shortname
+ * to longname conversion on every notification event.
+ *
+ * We do not want to create a file to test this, so we assume that the
+ * root directory contains a ".git" file or directory.  (Our caller
+ * only calls us for the worktree root, so this should be fine.)
+ *
+ * Remember the spelling of the shortname for ".git" if it exists.
+ */
+static void check_for_shortnames(struct one_watch *watch)
+{
+	wchar_t buf_in[MAX_PATH + 1];
+	wchar_t buf_out[MAX_PATH + 1];
+	wchar_t *last_slash = NULL;
+	wchar_t *last_bslash = NULL;
+	wchar_t *last;
+
+	/* build L"<wt-root-path>/.git" */
+	wcscpy(buf_in, watch->wpath_longname);
+	wcscpy(buf_in + watch->wpath_longname_len, L".git");
+
+	if (!GetShortPathNameW(buf_in, buf_out, MAX_PATH))
+		return;
+
+	last_slash = wcsrchr(buf_out, L'/');
+	last_bslash = wcsrchr(buf_out, L'\\');
+	if (last_slash > last_bslash)
+		last = last_slash + 1;
+	else if (last_bslash)
+		last = last_bslash + 1;
+	else
+		last = buf_out;
+
+	if (!wcscmp(last, L".git"))
+		return;
+
+	watch->has_shortnames = 1;
+	wcsncpy(watch->dotgit_shortname, last,
+		ARRAY_SIZE(watch->dotgit_shortname));
+
+	/*
+	 * The shortname for ".git" is usually of the form "GIT~1", so
+	 * we should be able to avoid shortname to longname mapping on
+	 * every notification event if the source string does not
+	 * contain a "~".
+	 *
+	 * However, the documentation for GetLongPathNameW() says
+	 * that there are filesystems that don't follow that pattern
+	 * and warns against this optimization.
+	 *
+	 * Lets test this.
+	 */
+	if (wcschr(watch->dotgit_shortname, L'~'))
+		watch->has_tilda = 1;
+}
+
+enum get_relative_result {
+	GRR_NO_CONVERSION_NEEDED,
+	GRR_HAVE_CONVERSION,
+	GRR_SHUTDOWN,
+};
+
+/*
+ * Info notification paths are relative to the root of the watch.
+ * If our CWD is still at the root, then we can use relative paths
+ * to convert from shortnames to longnames.  If our process has a
+ * different CWD, then we need to construct an absolute path, do
+ * the conversion, and then return the root-relative portion.
+ *
+ * We use the longname form of the root as our basis and assume that
+ * it already has a trailing slash.
+ *
+ * `wpath_len` is in WCHARS not bytes.
+ */
+static enum get_relative_result get_relative_longname(
+	struct one_watch *watch,
+	const wchar_t *wpath, DWORD wpath_len,
+	wchar_t *wpath_longname)
+{
+	wchar_t buf_in[2 * MAX_PATH + 1];
+	wchar_t buf_out[MAX_PATH + 1];
+	DWORD root_len;
+
+	/* Build L"<wt-root-path>/<event-rel-path>" */
+	root_len = watch->wpath_longname_len;
+	wcsncpy(buf_in, watch->wpath_longname, root_len);
+	wcsncpy(buf_in + root_len, wpath, wpath_len);
+	buf_in[root_len + wpath_len] = 0;
+
+	/*
+	 * We don't actually know if the source pathname is a
+	 * shortname or a longname.  This routine allows either to be
+	 * given as input.
+	 */
+	if (!GetLongPathNameW(buf_in, buf_out, MAX_PATH)) {
+		/*
+		 * The shortname to longname conversion can fail for
+		 * various reasons, for example if the file has been
+		 * deleted.  (That is, if we just received a
+		 * delete-file notification event and the file is
+		 * already gone, we can't ask the file system to
+		 * lookup the longname for it.  Likewise, for moves
+		 * and renames where we are given the old name.)
+		 *
+		 * Since deleting or moving a file or directory by its
+		 * shortname is rather obscure, I'm going ignore the
+		 * failure and ask the caller to report the original
+		 * relative path.  This seems kinder than failing here
+		 * and forcing a resync.  Besides, forcing a resync on
+		 * every file/directory delete would effectively
+		 * cripple monitoring.
+		 *
+		 * We might revisit this in the future.
+		 */
+		return GRR_NO_CONVERSION_NEEDED;
+	}
+
+	if (!wcscmp(buf_in, buf_out)) {
+		/*
+		 * The path does not have a shortname alias.
+		 */
+		return GRR_NO_CONVERSION_NEEDED;
+	}
+
+	if (wcsncmp(buf_in, buf_out, root_len)) {
+		/*
+		 * The spelling of the root directory portion of the computed
+		 * longname has changed.  This should not happen.  Basically,
+		 * it means that we don't know where (without recomputing the
+		 * longname of just the root directory) to split out the
+		 * relative path.  Since this should not happen, I'm just
+		 * going to let this fail and force a shutdown (because all
+		 * subsequent events are probably going to see the same
+		 * mismatch).
+		 */
+		return GRR_SHUTDOWN;
+	}
+
+	/* Return the worktree root-relative portion of the longname. */
+
+	wcscpy(wpath_longname, buf_out + root_len);
+	return GRR_HAVE_CONVERSION;
+}
+
 void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 {
 	SetEvent(state->backend_data->hListener[LISTENER_SHUTDOWN]);
@@ -111,7 +274,9 @@ static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
 	DWORD share_mode =
 		FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE;
 	HANDLE hDir;
-	wchar_t wpath[MAX_PATH];
+	DWORD len_longname;
+	wchar_t wpath[MAX_PATH + 1];
+	wchar_t wpath_longname[MAX_PATH + 1];
 
 	if (xutftowcs_path(wpath, path) < 0) {
 		error(_("could not convert to wide characters: '%s'"), path);
@@ -128,6 +293,20 @@ static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
 		return NULL;
 	}
 
+	if (!GetLongPathNameW(wpath, wpath_longname, MAX_PATH)) {
+		error(_("[GLE %ld] could not get longname of '%s'"),
+		      GetLastError(), path);
+		CloseHandle(hDir);
+		return NULL;
+	}
+
+	len_longname = wcslen(wpath_longname);
+	if (wpath_longname[len_longname - 1] != L'/' &&
+	    wpath_longname[len_longname - 1] != L'\\') {
+		wpath_longname[len_longname++] = L'/';
+		wpath_longname[len_longname] = 0;
+	}
+
 	CALLOC_ARRAY(watch, 1);
 
 	watch->buf_len = sizeof(watch->buffer); /* assume full MAX_RDCW_BUF */
@@ -135,6 +314,9 @@ static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
 	strbuf_init(&watch->path, 0);
 	strbuf_addstr(&watch->path, path);
 
+	wcscpy(watch->wpath_longname, wpath_longname);
+	watch->wpath_longname_len = len_longname;
+
 	watch->hDir = hDir;
 	watch->hEvent = CreateEvent(NULL, TRUE, FALSE, NULL);
 
@@ -258,6 +440,62 @@ static void cancel_rdcw_watch(struct one_watch *watch)
 	watch->is_active = FALSE;
 }
 
+/*
+ * Process a single relative pathname event.
+ * Return 1 if we should shutdown.
+ */
+static int process_1_worktree_event(
+	struct string_list *cookie_list,
+	struct fsmonitor_batch **batch,
+	const struct strbuf *path,
+	enum fsmonitor_path_type t,
+	DWORD info_action)
+{
+	const char *slash;
+
+	switch (t) {
+	case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
+		/* special case cookie files within .git */
+
+		/* Use just the filename of the cookie file. */
+		slash = find_last_dir_sep(path->buf);
+		string_list_append(cookie_list,
+				   slash ? slash + 1 : path->buf);
+		break;
+
+	case IS_INSIDE_DOT_GIT:
+		/* ignore everything inside of "<worktree>/.git/" */
+		break;
+
+	case IS_DOT_GIT:
+		/* "<worktree>/.git" was deleted (or renamed away) */
+		if ((info_action == FILE_ACTION_REMOVED) ||
+		    (info_action == FILE_ACTION_RENAMED_OLD_NAME)) {
+			trace2_data_string("fsmonitor", NULL,
+					   "fsm-listen/dotgit",
+					   "removed");
+			return 1;
+		}
+		break;
+
+	case IS_WORKDIR_PATH:
+		/* queue normal pathname */
+		if (!*batch)
+			*batch = fsmonitor_batch__new();
+		fsmonitor_batch__add_path(*batch, path->buf);
+		break;
+
+	case IS_GITDIR:
+	case IS_INSIDE_GITDIR:
+	case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
+	default:
+		BUG("unexpected path classification '%d' for '%s'",
+		    t, path->buf);
+	}
+
+	return 0;
+}
+
 /*
  * Process filesystem events that happen anywhere (recursively) under the
  * <worktree> root directory.  For a normal working directory, this includes
@@ -274,6 +512,7 @@ static int process_worktree_events(struct fsmonitor_daemon_state *state)
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
 	struct fsmonitor_batch *batch = NULL;
 	const char *p = watch->buffer;
+	wchar_t wpath_longname[MAX_PATH + 1];
 
 	/*
 	 * If the kernel gets more events than will fit in the kernel
@@ -306,54 +545,63 @@ static int process_worktree_events(struct fsmonitor_daemon_state *state)
 	 */
 	for (;;) {
 		FILE_NOTIFY_INFORMATION *info = (void *)p;
-		const char *slash;
+		wchar_t *wpath = info->FileName;
+		DWORD wpath_len = info->FileNameLength / sizeof(WCHAR);
 		enum fsmonitor_path_type t;
+		enum get_relative_result grr;
+
+		if (watch->has_shortnames) {
+			if (!wcscmp(wpath, watch->dotgit_shortname)) {
+				/*
+				 * This event exactly matches the
+				 * spelling of the shortname of
+				 * ".git", so we can skip some steps.
+				 *
+				 * (This case is odd because the user
+				 * can "rm -rf GIT~1" and we cannot
+				 * use the filesystem to map it back
+				 * to ".git".)
+				 */
+				strbuf_reset(&path);
+				strbuf_addstr(&path, ".git");
+				t = IS_DOT_GIT;
+				goto process_it;
+			}
 
-		strbuf_reset(&path);
-		if (normalize_path_in_utf8(info, &path) == -1)
-			goto skip_this_path;
-
-		t = fsmonitor_classify_path_workdir_relative(path.buf);
-
-		switch (t) {
-		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
-			/* special case cookie files within .git */
-
-			/* Use just the filename of the cookie file. */
-			slash = find_last_dir_sep(path.buf);
-			string_list_append(&cookie_list,
-					   slash ? slash + 1 : path.buf);
-			break;
-
-		case IS_INSIDE_DOT_GIT:
-			/* ignore everything inside of "<worktree>/.git/" */
-			break;
+			if (watch->has_tilda && !wcschr(wpath, L'~')) {
+				/*
+				 * Shortnames on this filesystem have tildas
+				 * and the notification path does not have
+				 * one, so we assume that it is a longname.
+				 */
+				goto normalize_it;
+			}
 
-		case IS_DOT_GIT:
-			/* "<worktree>/.git" was deleted (or renamed away) */
-			if ((info->Action == FILE_ACTION_REMOVED) ||
-			    (info->Action == FILE_ACTION_RENAMED_OLD_NAME)) {
-				trace2_data_string("fsmonitor", NULL,
-						   "fsm-listen/dotgit",
-						   "removed");
+			grr = get_relative_longname(watch, wpath, wpath_len,
+						    wpath_longname);
+			switch (grr) {
+			case GRR_NO_CONVERSION_NEEDED: /* use info buffer as is */
+				break;
+			case GRR_HAVE_CONVERSION:
+				wpath = wpath_longname;
+				wpath_len = wcslen(wpath);
+				break;
+			default:
+			case GRR_SHUTDOWN:
 				goto force_shutdown;
 			}
-			break;
+		}
 
-		case IS_WORKDIR_PATH:
-			/* queue normal pathname */
-			if (!batch)
-				batch = fsmonitor_batch__new();
-			fsmonitor_batch__add_path(batch, path.buf);
-			break;
+normalize_it:
+		if (normalize_path_in_utf8(wpath, wpath_len, &path) == -1)
+			goto skip_this_path;
 
-		case IS_GITDIR:
-		case IS_INSIDE_GITDIR:
-		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
-		default:
-			BUG("unexpected path classification '%d' for '%s'",
-			    t, path.buf);
-		}
+		t = fsmonitor_classify_path_workdir_relative(path.buf);
+
+process_it:
+		if (process_1_worktree_event(&cookie_list, &batch, &path, t,
+					     info->Action))
+			goto force_shutdown;
 
 skip_this_path:
 		if (!info->NextEntryOffset)
@@ -382,6 +630,9 @@ force_shutdown:
  * Note that we DO NOT get filesystem events on the external <gitdir>
  * itself (it is not inside something that we are watching).  In particular,
  * we do not get an event if the external <gitdir> is deleted.
+ *
+ * Also, we do not care about shortnames within the external <gitdir>, since
+ * we never send these paths to clients.
  */
 static int process_gitdir_events(struct fsmonitor_daemon_state *state)
 {
@@ -403,8 +654,10 @@ static int process_gitdir_events(struct fsmonitor_daemon_state *state)
 		const char *slash;
 		enum fsmonitor_path_type t;
 
-		strbuf_reset(&path);
-		if (normalize_path_in_utf8(info, &path) == -1)
+		if (normalize_path_in_utf8(
+			    info->FileName,
+			    info->FileNameLength / sizeof(WCHAR),
+			    &path) == -1)
 			goto skip_this_path;
 
 		t = fsmonitor_classify_path_gitdir_relative(path.buf);
@@ -538,6 +791,8 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 	if (!data->watch_worktree)
 		goto failed;
 
+	check_for_shortnames(data->watch_worktree);
+
 	if (state->nr_paths_watching > 1) {
 		data->watch_gitdir = create_watch(state,
 						  state->path_gitdir_watch.buf);
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 1c40d8d2035..9004fbf2043 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -177,6 +177,71 @@ test_expect_success 'implicit daemon stop (rename .git)' '
 	test_must_fail git -C test_implicit_2 fsmonitor--daemon status
 '
 
+# File systems on Windows may or may not have shortnames.
+# This is a volume-specific setting on modern systems.
+# "C:/" drives are required to have them enabled.  Other
+# hard drives default to disabled.
+#
+# This is a crude test to see if shortnames are enabled
+# on the volume containing the test directory.  It is
+# crude, but it does not require elevation like `fsutil`.
+#
+test_lazy_prereq SHORTNAMES '
+	mkdir .foo &&
+	test -d "FOO~1"
+'
+
+# Here we assume that the shortname of ".git" is "GIT~1".
+test_expect_success MINGW,SHORTNAMES 'implicit daemon stop (rename GIT~1)' '
+	test_when_finished "stop_daemon_delete_repo test_implicit_1s" &&
+
+	git init test_implicit_1s &&
+
+	start_daemon -C test_implicit_1s &&
+
+	# renaming the .git directory will implicitly stop the daemon.
+	# this moves {.git, GIT~1} to {.gitxyz, GITXYZ~1}.
+	# the rename-from FS Event will contain the shortname.
+	#
+	mv test_implicit_1s/GIT~1 test_implicit_1s/.gitxyz &&
+
+	sleep 1 &&
+	# put it back so that our status will not crawl out to our
+	# parent directory.
+	# this moves {.gitxyz, GITXYZ~1} to {.git, GIT~1}.
+	mv test_implicit_1s/.gitxyz test_implicit_1s/.git &&
+
+	test_must_fail git -C test_implicit_1s fsmonitor--daemon status
+'
+
+# Here we first create a file with LONGNAME of "GIT~1" before
+# we create the repo.  This will cause the shortname of ".git"
+# to be "GIT~2".
+test_expect_success MINGW,SHORTNAMES 'implicit daemon stop (rename GIT~2)' '
+	test_when_finished "stop_daemon_delete_repo test_implicit_1s2" &&
+
+	mkdir test_implicit_1s2 &&
+	echo HELLO >test_implicit_1s2/GIT~1 &&
+	git init test_implicit_1s2 &&
+
+	test_path_is_file test_implicit_1s2/GIT~1 &&
+	test_path_is_dir  test_implicit_1s2/GIT~2 &&
+
+	start_daemon -C test_implicit_1s2 &&
+
+	# renaming the .git directory will implicitly stop the daemon.
+	# the rename-from FS Event will contain the shortname.
+	#
+	mv test_implicit_1s2/GIT~2 test_implicit_1s2/.gitxyz &&
+
+	sleep 1 &&
+	# put it back so that our status will not crawl out to our
+	# parent directory.
+	mv test_implicit_1s2/.gitxyz test_implicit_1s2/.git &&
+
+	test_must_fail git -C test_implicit_1s2 fsmonitor--daemon status
+'
+
 test_expect_success 'cannot start multiple daemons' '
 	test_when_finished "stop_daemon_delete_repo test_multiple" &&
 
-- 
gitgitgadget

