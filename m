Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B55C433FE
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbiCVSC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240079AbiCVSCS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:02:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F144366F84
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a1so23179531wrh.10
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=27EYsw0sQz+mI4HvJWY1VfC1P39Tg+tZZLnW70cporg=;
        b=h0VRZ5BtEhviO7HkSDWT49Kxewxzj9dGEC8GtPJbMW13KrDp+JwstIqO6LgDF8aPRP
         oSMV7A3I91cz8dmpRg6eAPcGNiaFbEsraV3gcpN0kydz5xrzlnXTIeT9l66js+NJTwG5
         O7gg0sicLPE/VUgJgDezwzK+VMKQPbmU8uaHMKHb+r8YB7gq/9HtVtbzJ1uhCHbS5vd/
         fFLAnfMFO1+BRVgu2t5bBMWS5EX061Q6ljD6xHNYHB8N0AH1x38CuFtctpjZWo9Jg0XN
         kdRbFqViLyvyyNiwm01g4qo8A01SdSuv1HwhqZqYFcpJ1mrzI/a7JQ4nwv4DMcc35eks
         2IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=27EYsw0sQz+mI4HvJWY1VfC1P39Tg+tZZLnW70cporg=;
        b=M/mzBOYrtayKJuoDBzimp7B6u6jIKqvV/3SAJDcNHmnFN/M0neZMVqGpxif065vtPz
         7ecrfcopRBvKQ70hVvc7oc19gKruEjH9oBHvWsrj4BsTft6KMfMi2j+b4aHIWlcZ8paG
         uTBv8YoVzW2HHXzaERiqCJWAFv2Ok1jCXBssr/NoFpiwu4y32I8zAYqeFmV30v/I7A13
         L3UyXhiaWaZnR13BO8g0N4Ie1Ies9kjDRNtnD46aoM1uX0pF4kIb19MjyEo/9+qlupdD
         WFOOAJ1bJDF9aoJZ10NQxIAvf0JzvQ6qNMnBaN6v+4EdpSUzWw6rnutpiOcxsoHTXK15
         VlDg==
X-Gm-Message-State: AOAM532ey3x6qhPID6ueMX0jdwJNGaVn5sGzhZjjHqoGTAqj2pSe9VGe
        umrcGBeoOW1pAzosh34Vp3shA8nL0hI=
X-Google-Smtp-Source: ABdhPJwaUDBjyJs9CkKklQ5iSl0KYXNeAEQxEXAdAy7lafEZTWPz//Nuhker/DVZribjxoZ1X6bc3g==
X-Received: by 2002:a5d:6511:0:b0:204:62a:20fc with SMTP id x17-20020a5d6511000000b00204062a20fcmr11922370wru.352.1647972038111;
        Tue, 22 Mar 2022 11:00:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm9903865wrz.29.2022.03.22.11.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:37 -0700 (PDT)
Message-Id: <239558e34ffea4240de8699707cd3b404b682488.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:56 +0000
Subject: [PATCH v7 15/29] compat/fsmonitor/fsm-listen-win32: implement
 FSMonitor backend on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach the win32 backend to register a watch on the working tree
root directory (recursively).  Also watch the <gitdir> if it is
not inside the working tree.  And to collect path change notifications
into batches and publish.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/fsmonitor/fsm-listen-win32.c | 565 ++++++++++++++++++++++++++++
 1 file changed, 565 insertions(+)

diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 916cbea254f..5b928ab66e5 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -2,20 +2,585 @@
 #include "config.h"
 #include "fsmonitor.h"
 #include "fsm-listen.h"
+#include "fsmonitor--daemon.h"
+
+/*
+ * The documentation of ReadDirectoryChangesW() states that the maximum
+ * buffer size is 64K when the monitored directory is remote.
+ *
+ * Larger buffers may be used when the monitored directory is local and
+ * will help us receive events faster from the kernel and avoid dropped
+ * events.
+ *
+ * So we try to use a very large buffer and silently fallback to 64K if
+ * we get an error.
+ */
+#define MAX_RDCW_BUF_FALLBACK (65536)
+#define MAX_RDCW_BUF          (65536 * 8)
+
+struct one_watch
+{
+	char buffer[MAX_RDCW_BUF];
+	DWORD buf_len;
+	DWORD count;
+
+	struct strbuf path;
+	HANDLE hDir;
+	HANDLE hEvent;
+	OVERLAPPED overlapped;
+
+	/*
+	 * Is there an active ReadDirectoryChangesW() call pending.  If so, we
+	 * need to later call GetOverlappedResult() and possibly CancelIoEx().
+	 */
+	BOOL is_active;
+};
+
+struct fsmonitor_daemon_backend_data
+{
+	struct one_watch *watch_worktree;
+	struct one_watch *watch_gitdir;
+
+	HANDLE hEventShutdown;
+
+	HANDLE hListener[3]; /* we don't own these handles */
+#define LISTENER_SHUTDOWN 0
+#define LISTENER_HAVE_DATA_WORKTREE 1
+#define LISTENER_HAVE_DATA_GITDIR 2
+	int nr_listener_handles;
+};
+
+/*
+ * Convert the WCHAR path from the notification into UTF8 and
+ * then normalize it.
+ */
+static int normalize_path_in_utf8(FILE_NOTIFY_INFORMATION *info,
+				  struct strbuf *normalized_path)
+{
+	int reserve;
+	int len = 0;
+
+	strbuf_reset(normalized_path);
+	if (!info->FileNameLength)
+		goto normalize;
+
+	/*
+	 * Pre-reserve enough space in the UTF8 buffer for
+	 * each Unicode WCHAR character to be mapped into a
+	 * sequence of 2 UTF8 characters.  That should let us
+	 * avoid ERROR_INSUFFICIENT_BUFFER 99.9+% of the time.
+	 */
+	reserve = info->FileNameLength + 1;
+	strbuf_grow(normalized_path, reserve);
+
+	for (;;) {
+		len = WideCharToMultiByte(CP_UTF8, 0, info->FileName,
+					  info->FileNameLength / sizeof(WCHAR),
+					  normalized_path->buf,
+					  strbuf_avail(normalized_path) - 1,
+					  NULL, NULL);
+		if (len > 0)
+			goto normalize;
+		if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
+			error(_("[GLE %ld] could not convert path to UTF-8: '%.*ls'"),
+			      GetLastError(),
+			      (int)(info->FileNameLength / sizeof(WCHAR)),
+			      info->FileName);
+			return -1;
+		}
+
+		strbuf_grow(normalized_path,
+			    strbuf_avail(normalized_path) + reserve);
+	}
+
+normalize:
+	strbuf_setlen(normalized_path, len);
+	return strbuf_normalize_path(normalized_path);
+}
 
 void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 {
+	SetEvent(state->backend_data->hListener[LISTENER_SHUTDOWN]);
+}
+
+static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
+				      const char *path)
+{
+	struct one_watch *watch = NULL;
+	DWORD desired_access = FILE_LIST_DIRECTORY;
+	DWORD share_mode =
+		FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE;
+	HANDLE hDir;
+	wchar_t wpath[MAX_PATH];
+
+	if (xutftowcs_path(wpath, path) < 0) {
+		error(_("could not convert to wide characters: '%s'"), path);
+		return NULL;
+	}
+
+	hDir = CreateFileW(wpath,
+			   desired_access, share_mode, NULL, OPEN_EXISTING,
+			   FILE_FLAG_BACKUP_SEMANTICS | FILE_FLAG_OVERLAPPED,
+			   NULL);
+	if (hDir == INVALID_HANDLE_VALUE) {
+		error(_("[GLE %ld] could not watch '%s'"),
+		      GetLastError(), path);
+		return NULL;
+	}
+
+	CALLOC_ARRAY(watch, 1);
+
+	watch->buf_len = sizeof(watch->buffer); /* assume full MAX_RDCW_BUF */
+
+	strbuf_init(&watch->path, 0);
+	strbuf_addstr(&watch->path, path);
+
+	watch->hDir = hDir;
+	watch->hEvent = CreateEvent(NULL, TRUE, FALSE, NULL);
+
+	return watch;
+}
+
+static void destroy_watch(struct one_watch *watch)
+{
+	if (!watch)
+		return;
+
+	strbuf_release(&watch->path);
+	if (watch->hDir != INVALID_HANDLE_VALUE)
+		CloseHandle(watch->hDir);
+	if (watch->hEvent != INVALID_HANDLE_VALUE)
+		CloseHandle(watch->hEvent);
+
+	free(watch);
+}
+
+static int start_rdcw_watch(struct fsmonitor_daemon_backend_data *data,
+			    struct one_watch *watch)
+{
+	DWORD dwNotifyFilter =
+		FILE_NOTIFY_CHANGE_FILE_NAME |
+		FILE_NOTIFY_CHANGE_DIR_NAME |
+		FILE_NOTIFY_CHANGE_ATTRIBUTES |
+		FILE_NOTIFY_CHANGE_SIZE |
+		FILE_NOTIFY_CHANGE_LAST_WRITE |
+		FILE_NOTIFY_CHANGE_CREATION;
+
+	ResetEvent(watch->hEvent);
+
+	memset(&watch->overlapped, 0, sizeof(watch->overlapped));
+	watch->overlapped.hEvent = watch->hEvent;
+
+	/*
+	 * Queue an async call using Overlapped IO.  This returns immediately.
+	 * Our event handle will be signalled when the real result is available.
+	 *
+	 * The return value here just means that we successfully queued it.
+	 * We won't know if the Read...() actually produces data until later.
+	 */
+	watch->is_active = ReadDirectoryChangesW(
+		watch->hDir, watch->buffer, watch->buf_len, TRUE,
+		dwNotifyFilter, &watch->count, &watch->overlapped, NULL);
+
+	if (watch->is_active)
+		return 0;
+
+	error(_("ReadDirectoryChangedW failed on '%s' [GLE %ld]"),
+	      watch->path.buf, GetLastError());
+	return -1;
+}
+
+static int recv_rdcw_watch(struct one_watch *watch)
+{
+	DWORD gle;
+
+	watch->is_active = FALSE;
+
+	/*
+	 * The overlapped result is ready.  If the Read...() was successful
+	 * we finally receive the actual result into our buffer.
+	 */
+	if (GetOverlappedResult(watch->hDir, &watch->overlapped, &watch->count,
+				TRUE))
+		return 0;
+
+	gle = GetLastError();
+	if (gle == ERROR_INVALID_PARAMETER &&
+	    /*
+	     * The kernel throws an invalid parameter error when our
+	     * buffer is too big and we are pointed at a remote
+	     * directory (and possibly for other reasons).  Quietly
+	     * set it down and try again.
+	     *
+	     * See note about MAX_RDCW_BUF at the top.
+	     */
+	    watch->buf_len > MAX_RDCW_BUF_FALLBACK) {
+		watch->buf_len = MAX_RDCW_BUF_FALLBACK;
+		return -2;
+	}
+
+	/*
+	 * NEEDSWORK: If an external <gitdir> is deleted, the above
+	 * returns an error.  I'm not sure that there's anything that
+	 * we can do here other than failing -- the <worktree>/.git
+	 * link file would be broken anyway.  We might try to check
+	 * for that and return a better error message, but I'm not
+	 * sure it is worth it.
+	 */
+
+	error(_("GetOverlappedResult failed on '%s' [GLE %ld]"),
+	      watch->path.buf, gle);
+	return -1;
+}
+
+static void cancel_rdcw_watch(struct one_watch *watch)
+{
+	DWORD count;
+
+	if (!watch || !watch->is_active)
+		return;
+
+	/*
+	 * The calls to ReadDirectoryChangesW() and GetOverlappedResult()
+	 * form a "pair" (my term) where we queue an IO and promise to
+	 * hang around and wait for the kernel to give us the result.
+	 *
+	 * If for some reason after we queue the IO, we have to quit
+	 * or otherwise not stick around for the second half, we must
+	 * tell the kernel to abort the IO.  This prevents the kernel
+	 * from writing to our buffer and/or signalling our event
+	 * after we free them.
+	 *
+	 * (Ask me how much fun it was to track that one down).
+	 */
+	CancelIoEx(watch->hDir, &watch->overlapped);
+	GetOverlappedResult(watch->hDir, &watch->overlapped, &count, TRUE);
+	watch->is_active = FALSE;
+}
+
+/*
+ * Process filesystem events that happen anywhere (recursively) under the
+ * <worktree> root directory.  For a normal working directory, this includes
+ * both version controlled files and the contents of the .git/ directory.
+ *
+ * If <worktree>/.git is a file, then we only see events for the file
+ * itself.
+ */
+static int process_worktree_events(struct fsmonitor_daemon_state *state)
+{
+	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct one_watch *watch = data->watch_worktree;
+	struct strbuf path = STRBUF_INIT;
+	struct string_list cookie_list = STRING_LIST_INIT_DUP;
+	struct fsmonitor_batch *batch = NULL;
+	const char *p = watch->buffer;
+
+	/*
+	 * If the kernel gets more events than will fit in the kernel
+	 * buffer associated with our RDCW handle, it drops them and
+	 * returns a count of zero.
+	 *
+	 * Yes, the call returns WITHOUT error and with length zero.
+	 * This is the documented behavior.  (My testing has confirmed
+	 * that it also sets the last error to ERROR_NOTIFY_ENUM_DIR,
+	 * but we do not rely on that since the function did not
+	 * return an error and it is not documented.)
+	 *
+	 * (The "overflow" case is not ambiguous with the "no data" case
+	 * because we did an INFINITE wait.)
+	 *
+	 * This means we have a gap in coverage.  Tell the daemon layer
+	 * to resync.
+	 */
+	if (!watch->count) {
+		trace2_data_string("fsmonitor", NULL, "fsm-listen/kernel",
+				   "overflow");
+		fsmonitor_force_resync(state);
+		return LISTENER_HAVE_DATA_WORKTREE;
+	}
+
+	/*
+	 * On Windows, `info` contains an "array" of paths that are
+	 * relative to the root of whichever directory handle received
+	 * the event.
+	 */
+	for (;;) {
+		FILE_NOTIFY_INFORMATION *info = (void *)p;
+		const char *slash;
+		enum fsmonitor_path_type t;
+
+		strbuf_reset(&path);
+		if (normalize_path_in_utf8(info, &path) == -1)
+			goto skip_this_path;
+
+		t = fsmonitor_classify_path_workdir_relative(path.buf);
+
+		switch (t) {
+		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
+			/* special case cookie files within .git */
+
+			/* Use just the filename of the cookie file. */
+			slash = find_last_dir_sep(path.buf);
+			string_list_append(&cookie_list,
+					   slash ? slash + 1 : path.buf);
+			break;
+
+		case IS_INSIDE_DOT_GIT:
+			/* ignore everything inside of "<worktree>/.git/" */
+			break;
+
+		case IS_DOT_GIT:
+			/* "<worktree>/.git" was deleted (or renamed away) */
+			if ((info->Action == FILE_ACTION_REMOVED) ||
+			    (info->Action == FILE_ACTION_RENAMED_OLD_NAME)) {
+				trace2_data_string("fsmonitor", NULL,
+						   "fsm-listen/dotgit",
+						   "removed");
+				goto force_shutdown;
+			}
+			break;
+
+		case IS_WORKDIR_PATH:
+			/* queue normal pathname */
+			if (!batch)
+				batch = fsmonitor_batch__new();
+			fsmonitor_batch__add_path(batch, path.buf);
+			break;
+
+		case IS_GITDIR:
+		case IS_INSIDE_GITDIR:
+		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
+		default:
+			BUG("unexpected path classification '%d' for '%s'",
+			    t, path.buf);
+		}
+
+skip_this_path:
+		if (!info->NextEntryOffset)
+			break;
+		p += info->NextEntryOffset;
+	}
+
+	fsmonitor_publish(state, batch, &cookie_list);
+	batch = NULL;
+	string_list_clear(&cookie_list, 0);
+	strbuf_release(&path);
+	return LISTENER_HAVE_DATA_WORKTREE;
+
+force_shutdown:
+	fsmonitor_batch__free_list(batch);
+	string_list_clear(&cookie_list, 0);
+	strbuf_release(&path);
+	return LISTENER_SHUTDOWN;
+}
+
+/*
+ * Process filesystem events that happened anywhere (recursively) under the
+ * external <gitdir> (such as non-primary worktrees or submodules).
+ * We only care about cookie files that our client threads created here.
+ *
+ * Note that we DO NOT get filesystem events on the external <gitdir>
+ * itself (it is not inside something that we are watching).  In particular,
+ * we do not get an event if the external <gitdir> is deleted.
+ */
+static int process_gitdir_events(struct fsmonitor_daemon_state *state)
+{
+	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct one_watch *watch = data->watch_gitdir;
+	struct strbuf path = STRBUF_INIT;
+	struct string_list cookie_list = STRING_LIST_INIT_DUP;
+	const char *p = watch->buffer;
+
+	if (!watch->count) {
+		trace2_data_string("fsmonitor", NULL, "fsm-listen/kernel",
+				   "overflow");
+		fsmonitor_force_resync(state);
+		return LISTENER_HAVE_DATA_GITDIR;
+	}
+
+	for (;;) {
+		FILE_NOTIFY_INFORMATION *info = (void *)p;
+		const char *slash;
+		enum fsmonitor_path_type t;
+
+		strbuf_reset(&path);
+		if (normalize_path_in_utf8(info, &path) == -1)
+			goto skip_this_path;
+
+		t = fsmonitor_classify_path_gitdir_relative(path.buf);
+
+		switch (t) {
+		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
+			/* special case cookie files within gitdir */
+
+			/* Use just the filename of the cookie file. */
+			slash = find_last_dir_sep(path.buf);
+			string_list_append(&cookie_list,
+					   slash ? slash + 1 : path.buf);
+			break;
+
+		case IS_INSIDE_GITDIR:
+			goto skip_this_path;
+
+		default:
+			BUG("unexpected path classification '%d' for '%s'",
+			    t, path.buf);
+		}
+
+skip_this_path:
+		if (!info->NextEntryOffset)
+			break;
+		p += info->NextEntryOffset;
+	}
+
+	fsmonitor_publish(state, NULL, &cookie_list);
+	string_list_clear(&cookie_list, 0);
+	strbuf_release(&path);
+	return LISTENER_HAVE_DATA_GITDIR;
 }
 
 void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	DWORD dwWait;
+	int result;
+
+	state->error_code = 0;
+
+	if (start_rdcw_watch(data, data->watch_worktree) == -1)
+		goto force_error_stop;
+
+	if (data->watch_gitdir &&
+	    start_rdcw_watch(data, data->watch_gitdir) == -1)
+		goto force_error_stop;
+
+	for (;;) {
+		dwWait = WaitForMultipleObjects(data->nr_listener_handles,
+						data->hListener,
+						FALSE, INFINITE);
+
+		if (dwWait == WAIT_OBJECT_0 + LISTENER_HAVE_DATA_WORKTREE) {
+			result = recv_rdcw_watch(data->watch_worktree);
+			if (result == -1) {
+				/* hard error */
+				goto force_error_stop;
+			}
+			if (result == -2) {
+				/* retryable error */
+				if (start_rdcw_watch(data, data->watch_worktree) == -1)
+					goto force_error_stop;
+				continue;
+			}
+
+			/* have data */
+			if (process_worktree_events(state) == LISTENER_SHUTDOWN)
+				goto force_shutdown;
+			if (start_rdcw_watch(data, data->watch_worktree) == -1)
+				goto force_error_stop;
+			continue;
+		}
+
+		if (dwWait == WAIT_OBJECT_0 + LISTENER_HAVE_DATA_GITDIR) {
+			result = recv_rdcw_watch(data->watch_gitdir);
+			if (result == -1) {
+				/* hard error */
+				goto force_error_stop;
+			}
+			if (result == -2) {
+				/* retryable error */
+				if (start_rdcw_watch(data, data->watch_gitdir) == -1)
+					goto force_error_stop;
+				continue;
+			}
+
+			/* have data */
+			if (process_gitdir_events(state) == LISTENER_SHUTDOWN)
+				goto force_shutdown;
+			if (start_rdcw_watch(data, data->watch_gitdir) == -1)
+				goto force_error_stop;
+			continue;
+		}
+
+		if (dwWait == WAIT_OBJECT_0 + LISTENER_SHUTDOWN)
+			goto clean_shutdown;
+
+		error(_("could not read directory changes [GLE %ld]"),
+		      GetLastError());
+		goto force_error_stop;
+	}
+
+force_error_stop:
+	state->error_code = -1;
+
+force_shutdown:
+	/*
+	 * Tell the IPC thead pool to stop (which completes the await
+	 * in the main thread (which will also signal this thread (if
+	 * we are still alive))).
+	 */
+	ipc_server_stop_async(state->ipc_server_data);
+
+clean_shutdown:
+	cancel_rdcw_watch(data->watch_worktree);
+	cancel_rdcw_watch(data->watch_gitdir);
 }
 
 int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data;
+
+	CALLOC_ARRAY(data, 1);
+
+	data->hEventShutdown = CreateEvent(NULL, TRUE, FALSE, NULL);
+
+	data->watch_worktree = create_watch(state,
+					    state->path_worktree_watch.buf);
+	if (!data->watch_worktree)
+		goto failed;
+
+	if (state->nr_paths_watching > 1) {
+		data->watch_gitdir = create_watch(state,
+						  state->path_gitdir_watch.buf);
+		if (!data->watch_gitdir)
+			goto failed;
+	}
+
+	data->hListener[LISTENER_SHUTDOWN] = data->hEventShutdown;
+	data->nr_listener_handles++;
+
+	data->hListener[LISTENER_HAVE_DATA_WORKTREE] =
+		data->watch_worktree->hEvent;
+	data->nr_listener_handles++;
+
+	if (data->watch_gitdir) {
+		data->hListener[LISTENER_HAVE_DATA_GITDIR] =
+			data->watch_gitdir->hEvent;
+		data->nr_listener_handles++;
+	}
+
+	state->backend_data = data;
+	return 0;
+
+failed:
+	CloseHandle(data->hEventShutdown);
+	destroy_watch(data->watch_worktree);
+	destroy_watch(data->watch_gitdir);
+
 	return -1;
 }
 
 void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data;
+
+	if (!state || !state->backend_data)
+		return;
+
+	data = state->backend_data;
+
+	CloseHandle(data->hEventShutdown);
+	destroy_watch(data->watch_worktree);
+	destroy_watch(data->watch_gitdir);
+
+	FREE_AND_NULL(state->backend_data);
 }
-- 
gitgitgadget

