Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC25C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiCYTlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiCYTjk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:39:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7940234553
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:18:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r23so10356544edb.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a2Hil1sjIGQyOaFUifrlQ4ChPXW9UVOHP1tlrqtxbDE=;
        b=CXNBMUfY/X1SxkZtK98UYhRA6TeDpmYJbbQAEevPZ8VThN8wW1Y3HIXpPXgGM59ITv
         7logI/3S7WMpNOvgXG4jUPtbZQfOsWj0/cVR1qc44V+kQ9dwjLFYExEQ8qMzMwmXuBeH
         4uzdBS+V3Tm70pAOnJWPv0LRiWs2HCAFOLRelmSodSI1BXdFAQ7QRnkQ9NX/jyVzFbYd
         AGlpL9w2i74j8ncyM0YJ1YtDvwWPaVZ4+x3dtWKwYaEU9WGXgQAksCk4ptjZDt1acOq6
         cueCU8dNOO2hEgiQoSfw2XSHTxH3aDk0M7nFvPdzNyuAMqiC9Or0AUAFUSJshuX1xNGY
         riug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a2Hil1sjIGQyOaFUifrlQ4ChPXW9UVOHP1tlrqtxbDE=;
        b=S/x06VLwDNQlQDqt/9lXjNatDIf4vewFVVs7yfMBPIQZDQRrW8kkMSWTC6A/Pj3NN3
         lDNV0EhobaLps3pNGyd1m4N4JK4yRNtQr0hty9u+CAmM1fkZZzQTlmtHpP8JoYxFBD1G
         X2YjuJfQGMRxRbQRm1K2XOWM0Cs40z+Y0lBHcvapuc3u6/QwCw7vud7dhXhW9QN7Smd5
         beZcP9Kt8/tDXCmc7qhXmbxC0J46+fYqmBnaQL1gWRh6MggtqJNVuaVD5VI2TQpXbzpR
         r9H29wCErjf4YwpZCh144hTKv9G9+2dYS/MkTv/VhAGFMZWB9XqNk9ThKOy/KaGKRF90
         AyNw==
X-Gm-Message-State: AOAM5316yTp5hukc6PoZF/5JzTI9TIt1dUSaXPZEtV6Hgipz0kt5QVay
        QNfmSoZnEQNl67vXORR/cPes4nxkNfM=
X-Google-Smtp-Source: ABdhPJx9ag0Cf2viBMTlcQAp1uKaefdNlONRVvUqLdkQAw/Kvm7ZMjbhBluB07eSOQsQQqFy3MvqCQ==
X-Received: by 2002:adf:d214:0:b0:204:2a98:a166 with SMTP id j20-20020adfd214000000b002042a98a166mr10111635wrh.406.1648231425747;
        Fri, 25 Mar 2022 11:03:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020412ba45f6sm6686893wrb.8.2022.03.25.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:45 -0700 (PDT)
Message-Id: <597a7192f94dd9c5c5101f5f92495565efdfe34f.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:03:11 +0000
Subject: [PATCH v9 28/30] fsmonitor--daemon: use a cookie file to sync with
 file system
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
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fsmonitor--daemon client threads to create a cookie file
inside the .git directory and then wait until FS events for the
cookie are observed by the FS listener thread.

This helps address the racy nature of file system events by
blocking the client response until the kernel has drained any
event backlog.

This is especially important on MacOS where kernel events are
only issued with a limited frequency.  See the `latency` argument
of `FSeventStreamCreate()`.  The kernel only signals every `latency`
seconds, but does not guarantee that the kernel queue is completely
drained, so we may have to wait more than one interval.  If we
increase the latency, the system is more likely to drop events.
We avoid these issues by having each client thread create a unique
cookie file and then wait until it is seen in the event stream.

Co-authored-by: Kevin Willford <Kevin.Willford@microsoft.com>
Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsmonitor--daemon.c | 237 +++++++++++++++++++++++++++++++++++-
 fsmonitor--daemon.h         |   5 +
 2 files changed, 241 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index ab9cc09f7ce..46be55a4618 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -107,6 +107,162 @@ static int do_as_client__status(void)
 	}
 }
 
+enum fsmonitor_cookie_item_result {
+	FCIR_ERROR = -1, /* could not create cookie file ? */
+	FCIR_INIT,
+	FCIR_SEEN,
+	FCIR_ABORT,
+};
+
+struct fsmonitor_cookie_item {
+	struct hashmap_entry entry;
+	char *name;
+	enum fsmonitor_cookie_item_result result;
+};
+
+static int cookies_cmp(const void *data, const struct hashmap_entry *he1,
+		     const struct hashmap_entry *he2, const void *keydata)
+{
+	const struct fsmonitor_cookie_item *a =
+		container_of(he1, const struct fsmonitor_cookie_item, entry);
+	const struct fsmonitor_cookie_item *b =
+		container_of(he2, const struct fsmonitor_cookie_item, entry);
+
+	return strcmp(a->name, keydata ? keydata : b->name);
+}
+
+static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
+	struct fsmonitor_daemon_state *state)
+{
+	/* assert current thread holding state->main_lock */
+
+	int fd;
+	struct fsmonitor_cookie_item *cookie;
+	struct strbuf cookie_pathname = STRBUF_INIT;
+	struct strbuf cookie_filename = STRBUF_INIT;
+	enum fsmonitor_cookie_item_result result;
+	int my_cookie_seq;
+
+	CALLOC_ARRAY(cookie, 1);
+
+	my_cookie_seq = state->cookie_seq++;
+
+	strbuf_addf(&cookie_filename, "%i-%i", getpid(), my_cookie_seq);
+
+	strbuf_addbuf(&cookie_pathname, &state->path_cookie_prefix);
+	strbuf_addbuf(&cookie_pathname, &cookie_filename);
+
+	cookie->name = strbuf_detach(&cookie_filename, NULL);
+	cookie->result = FCIR_INIT;
+	hashmap_entry_init(&cookie->entry, strhash(cookie->name));
+
+	hashmap_add(&state->cookies, &cookie->entry);
+
+	trace_printf_key(&trace_fsmonitor, "cookie-wait: '%s' '%s'",
+			 cookie->name, cookie_pathname.buf);
+
+	/*
+	 * Create the cookie file on disk and then wait for a notification
+	 * that the listener thread has seen it.
+	 */
+	fd = open(cookie_pathname.buf, O_WRONLY | O_CREAT | O_EXCL, 0600);
+	if (fd < 0) {
+		error_errno(_("could not create fsmonitor cookie '%s'"),
+			    cookie->name);
+
+		cookie->result = FCIR_ERROR;
+		goto done;
+	}
+
+	/*
+	 * Technically, close() and unlink() can fail, but we don't
+	 * care here.  We only created the file to trigger a watch
+	 * event from the FS to know that when we're up to date.
+	 */
+	close(fd);
+	unlink(cookie_pathname.buf);
+
+	/*
+	 * Technically, this is an infinite wait (well, unless another
+	 * thread sends us an abort).  I'd like to change this to
+	 * use `pthread_cond_timedwait()` and return an error/timeout
+	 * and let the caller do the trivial response thing, but we
+	 * don't have that routine in our thread-utils.
+	 *
+	 * After extensive beta testing I'm not really worried about
+	 * this.  Also note that the above open() and unlink() calls
+	 * will cause at least two FS events on that path, so the odds
+	 * of getting stuck are pretty slim.
+	 */
+	while (cookie->result == FCIR_INIT)
+		pthread_cond_wait(&state->cookies_cond,
+				  &state->main_lock);
+
+done:
+	hashmap_remove(&state->cookies, &cookie->entry, NULL);
+
+	result = cookie->result;
+
+	free(cookie->name);
+	free(cookie);
+	strbuf_release(&cookie_pathname);
+
+	return result;
+}
+
+/*
+ * Mark these cookies as _SEEN and wake up the corresponding client threads.
+ */
+static void with_lock__mark_cookies_seen(struct fsmonitor_daemon_state *state,
+					 const struct string_list *cookie_names)
+{
+	/* assert current thread holding state->main_lock */
+
+	int k;
+	int nr_seen = 0;
+
+	for (k = 0; k < cookie_names->nr; k++) {
+		struct fsmonitor_cookie_item key;
+		struct fsmonitor_cookie_item *cookie;
+
+		key.name = cookie_names->items[k].string;
+		hashmap_entry_init(&key.entry, strhash(key.name));
+
+		cookie = hashmap_get_entry(&state->cookies, &key, entry, NULL);
+		if (cookie) {
+			trace_printf_key(&trace_fsmonitor, "cookie-seen: '%s'",
+					 cookie->name);
+			cookie->result = FCIR_SEEN;
+			nr_seen++;
+		}
+	}
+
+	if (nr_seen)
+		pthread_cond_broadcast(&state->cookies_cond);
+}
+
+/*
+ * Set _ABORT on all pending cookies and wake up all client threads.
+ */
+static void with_lock__abort_all_cookies(struct fsmonitor_daemon_state *state)
+{
+	/* assert current thread holding state->main_lock */
+
+	struct hashmap_iter iter;
+	struct fsmonitor_cookie_item *cookie;
+	int nr_aborted = 0;
+
+	hashmap_for_each_entry(&state->cookies, &iter, cookie, entry) {
+		trace_printf_key(&trace_fsmonitor, "cookie-abort: '%s'",
+				 cookie->name);
+		cookie->result = FCIR_ABORT;
+		nr_aborted++;
+	}
+
+	if (nr_aborted)
+		pthread_cond_broadcast(&state->cookies_cond);
+}
+
 /*
  * Requests to and from a FSMonitor Protocol V2 provider use an opaque
  * "token" as a virtual timestamp.  Clients can request a summary of all
@@ -404,6 +560,9 @@ static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
  *     We should create a new token and start fresh (as if we just
  *     booted up).
  *
+ * [2] Some of those lost events may have been for cookie files.  We
+ *     should assume the worst and abort them rather letting them starve.
+ *
  * If there are no concurrent threads reading the current token data
  * series, we can free it now.  Otherwise, let the last reader free
  * it.
@@ -425,6 +584,8 @@ static void with_lock__do_force_resync(struct fsmonitor_daemon_state *state)
 	state->current_token_data = new_one;
 
 	fsmonitor_free_token_data(free_me);
+
+	with_lock__abort_all_cookies(state);
 }
 
 void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
@@ -500,6 +661,8 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	int hash_ret;
 	int do_trivial = 0;
 	int do_flush = 0;
+	int do_cookie = 0;
+	enum fsmonitor_cookie_item_result cookie_result;
 
 	/*
 	 * We expect `command` to be of the form:
@@ -560,6 +723,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 			 * We have a V2 valid token:
 			 *     "builtin:<token_id>:<seq_nr>"
 			 */
+			do_cookie = 1;
 		}
 	}
 
@@ -568,6 +732,30 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	if (!state->current_token_data)
 		BUG("fsmonitor state does not have a current token");
 
+	/*
+	 * Write a cookie file inside the directory being watched in
+	 * an effort to flush out existing filesystem events that we
+	 * actually care about.  Suspend this client thread until we
+	 * see the filesystem events for this cookie file.
+	 *
+	 * Creating the cookie lets us guarantee that our FS listener
+	 * thread has drained the kernel queue and we are caught up
+	 * with the kernel.
+	 *
+	 * If we cannot create the cookie (or otherwise guarantee that
+	 * we are caught up), we send a trivial response.  We have to
+	 * assume that there might be some very, very recent activity
+	 * on the FS still in flight.
+	 */
+	if (do_cookie) {
+		cookie_result = with_lock__wait_for_cookie(state);
+		if (cookie_result != FCIR_SEEN) {
+			error(_("fsmonitor: cookie_result '%d' != SEEN"),
+			      cookie_result);
+			do_trivial = 1;
+		}
+	}
+
 	if (do_flush)
 		with_lock__do_force_resync(state);
 
@@ -787,7 +975,9 @@ static int handle_client(void *data,
 	return result;
 }
 
-#define FSMONITOR_COOKIE_PREFIX ".fsmonitor-daemon-"
+#define FSMONITOR_DIR           "fsmonitor--daemon"
+#define FSMONITOR_COOKIE_DIR    "cookies"
+#define FSMONITOR_COOKIE_PREFIX (FSMONITOR_DIR "/" FSMONITOR_COOKIE_DIR "/")
 
 enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
 	const char *rel)
@@ -940,6 +1130,9 @@ void fsmonitor_publish(struct fsmonitor_daemon_state *state,
 		}
 	}
 
+	if (cookie_names->nr)
+		with_lock__mark_cookies_seen(state, cookie_names);
+
 	pthread_mutex_unlock(&state->main_lock);
 }
 
@@ -1031,7 +1224,9 @@ static int fsmonitor_run_daemon(void)
 
 	memset(&state, 0, sizeof(state));
 
+	hashmap_init(&state.cookies, cookies_cmp, NULL, 0);
 	pthread_mutex_init(&state.main_lock, NULL);
+	pthread_cond_init(&state.cookies_cond, NULL);
 	state.error_code = 0;
 	state.current_token_data = fsmonitor_new_token_data();
 
@@ -1056,6 +1251,44 @@ static int fsmonitor_run_daemon(void)
 		state.nr_paths_watching = 2;
 	}
 
+	/*
+	 * We will write filesystem syncing cookie files into
+	 * <gitdir>/<fsmonitor-dir>/<cookie-dir>/<pid>-<seq>.
+	 *
+	 * The extra layers of subdirectories here keep us from
+	 * changing the mtime on ".git/" or ".git/foo/" when we create
+	 * or delete cookie files.
+	 *
+	 * There have been problems with some IDEs that do a
+	 * non-recursive watch of the ".git/" directory and run a
+	 * series of commands any time something happens.
+	 *
+	 * For example, if we place our cookie files directly in
+	 * ".git/" or ".git/foo/" then a `git status` (or similar
+	 * command) from the IDE will cause a cookie file to be
+	 * created in one of those dirs.  This causes the mtime of
+	 * those dirs to change.  This triggers the IDE's watch
+	 * notification.  This triggers the IDE to run those commands
+	 * again.  And the process repeats and the machine never goes
+	 * idle.
+	 *
+	 * Adding the extra layers of subdirectories prevents the
+	 * mtime of ".git/" and ".git/foo" from changing when a
+	 * cookie file is created.
+	 */
+	strbuf_init(&state.path_cookie_prefix, 0);
+	strbuf_addbuf(&state.path_cookie_prefix, &state.path_gitdir_watch);
+
+	strbuf_addch(&state.path_cookie_prefix, '/');
+	strbuf_addstr(&state.path_cookie_prefix, FSMONITOR_DIR);
+	mkdir(state.path_cookie_prefix.buf, 0777);
+
+	strbuf_addch(&state.path_cookie_prefix, '/');
+	strbuf_addstr(&state.path_cookie_prefix, FSMONITOR_COOKIE_DIR);
+	mkdir(state.path_cookie_prefix.buf, 0777);
+
+	strbuf_addch(&state.path_cookie_prefix, '/');
+
 	/*
 	 * Confirm that we can create platform-specific resources for the
 	 * filesystem listener before we bother starting all the threads.
@@ -1068,6 +1301,7 @@ static int fsmonitor_run_daemon(void)
 	err = fsmonitor_run_daemon_1(&state);
 
 done:
+	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
 	fsm_listen__dtor(&state);
 
@@ -1075,6 +1309,7 @@ done:
 
 	strbuf_release(&state.path_worktree_watch);
 	strbuf_release(&state.path_gitdir_watch);
+	strbuf_release(&state.path_cookie_prefix);
 
 	return err;
 }
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 010fbfe60e9..bd09fffc176 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -45,6 +45,11 @@ struct fsmonitor_daemon_state {
 
 	struct fsmonitor_token_data *current_token_data;
 
+	struct strbuf path_cookie_prefix;
+	pthread_cond_t cookies_cond;
+	int cookie_seq;
+	struct hashmap cookies;
+
 	int error_code;
 	struct fsmonitor_daemon_backend_data *backend_data;
 
-- 
gitgitgadget

