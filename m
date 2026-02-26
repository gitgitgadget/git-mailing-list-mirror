Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4443261B6D
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065665; cv=none; b=aEdFeezu3q1p8qO+LELxXPEooVp5VJ4q7pToYW0+XGLoNCfdOvtEI9y4RPpFzRu5ax0D2EQ1HyNq7Iyc6vD6wLOBAJspAv7o0RcEDtWqUDjofoveViW0jDB1ooWyws0+/RgihCKYp/W4nzDKURnSR4jIWifapUqI+kQ4k7bvHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065665; c=relaxed/simple;
	bh=j/IMQuHM/dhsZh+CNWO7PvE+0Gfx0rotCqPEYN5CGKc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ABRZMFfP6t/9QdlIZHHDLgp2eRXhVlo6ZhR41sikCKZkFmwCrro9pH45diDnUzj9a3oUbOEQVwBRAUJZrPmZ6oFfJSn00/DlmbNWOcsh5z+RGbxrKTb3L+nR6WKEju6be7cl2y2lQjn9TWwFEqzLZTNEsrWKBnhwuESVWzB1ycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYAWnLQd; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYAWnLQd"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bd3b0bc201so625533eec.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772065662; x=1772670462; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RkffA9HMVdGVvdeIm0kZ5vIs61dvQKk4X/0hONnb6A=;
        b=JYAWnLQd4vvEGuBGH+JVh3Gid9IOq0NjxnjIjJpqBUdllLoHbQnsLA45pOwv+/Ijyn
         MEEAAUzgcFrpnLo+FXbb5KcdjDit9KVZIpkza4x/PD+S+AdOdEWMCkyiNHw2ONQBIDod
         CjYdrXlJKBh04PanJ1jK+cMsTOhEqNYXFb7B25cd4XhlOvJY+9bOL14cirKQmZxjPSXa
         b70OXOt0Yxm8QadYboUa8mMbDRAlMvujTG/vtDh2qt+viqRh7c1nFQEcRxjpbuHHwjO4
         mURIvVipcW0Lpof2wJc8mwuqeTgCCHuy+eGOB48vw1OoNiEApr8WRVLeO2xsChh8SVcB
         741Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772065662; x=1772670462;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+RkffA9HMVdGVvdeIm0kZ5vIs61dvQKk4X/0hONnb6A=;
        b=ehGwpB7D03RXbwiff/aNCy1xfQ7dP4vK/8uvyoM2sA9nQXpz/XHzKSnN4vMkgJvv6o
         7gGD6BmPUhuMVuzoSKO/JgBrBuYqUV98rpJyXsAMh2tNNKZAJ7GFeH4pn2u4AUaBjom+
         v3f6yNnPpi4D1BAawV729HC3TEct5CU79sMunR+6D6QYjOi45vZsOwKO+CwN+vJjtNCH
         gCeTHAmv0quNNfsRJ7oO3bjLeWCrwqFZ2gdqii4h/itALN6Is6ii7fCFrrfj1elOqXPZ
         dOwDLFw1Nv3KWRD6zxXDAuU2Uzut3fel5Tk11IWtETL6GLZtPqmVjtlwLPJ9eD9fM9hD
         JovA==
X-Gm-Message-State: AOJu0Yx9yJ8CV0hzBgjSW7vpA5/gUVjQMFr9xxbT6RDbyJ+2xzNNyYzy
	xKSD/TbFTB43bj4EiRjBN8bnVoP/Z6C73e5DnmWFMTRo4pkKbf5pRA+HYuTk+nOe
X-Gm-Gg: ATEYQzw3en1j7OsaRmAOSODB2ydjH2fmkS4Jx1ul7P0vrmrSW5aaBBpV0lMFqbGWR/z
	zMSvlhbHQPK2OBtKnjhhmVgZm/GSL/aDXs7dazr8h5BQMX5BHhZ6wSrhDheSmcmzw9ORNghEdtD
	/Hu+2w5+6SnQecZKRLDe+n45FSXDHUy5PuoPZsEZYc7kCf2ZPI676VNqcM44RIWMJiQ7Xt+xgKh
	kvCN0H+GBp5eVzjZVkZuAHz+bqOk3oV7oQbofgMR/viRIV5R8wSoXoaALzzTuFBRSgbHxWtI39M
	xuKAY8QfwVMycRT2regSazbVcJgAimJFS1RdGFZhacxO23LDH2+amLqnax1RyIVnvL4l8rlQNqY
	xOkNBa+kclpBjiIhZqYKbLsvACg0HC1GdyQzn4b2ZvstMi/ALw5DRaIJ/fmTLwzzJBxqbfLTOxs
	kbJAEO/3uOVKSYBT1NRiuCAYgA/w==
X-Received: by 2002:a05:7300:b10b:b0:2b8:2910:dcae with SMTP id 5a478bee46e88-2bd7baed18amr8379032eec.13.1772065662489;
        Wed, 25 Feb 2026 16:27:42 -0800 (PST)
Received: from [127.0.0.1] ([52.159.229.150])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1cf0115sm469194eec.8.2026.02.25.16.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 16:27:41 -0800 (PST)
Message-Id: <4987a009a2e74a04aa1a8deb0508c971a3df0549.1772065643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 00:27:23 +0000
Subject: [PATCH v7 10/10] fsmonitor: close inherited file descriptors and
 detach in daemon
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

When the fsmonitor daemon is spawned as a background process, it may
inherit file descriptors from its parent that it does not need.  In
particular, when the test harness or a CI system captures output through
pipes, the daemon can inherit duplicated pipe endpoints.  If the daemon
holds these open, the parent process never sees EOF and may appear to
hang.

Set close_fd_above_stderr on the child process at daemon startup so
that file descriptors 3 and above are closed before any daemon work
begins.  This ensures the daemon does not inadvertently hold open
descriptors from its launching environment.

Additionally, call setsid() when the daemon starts with --detach to
create a new session and process group.  Without this, shells that
enable job control (e.g. bash with "set -m") treat the daemon as part
of the spawning command's job.  Their "wait" builtin then blocks until
the daemon exits, which it never does.  This specifically affects
systems where /bin/sh is bash (e.g. Fedora), since dash only waits for
the specific PID rather than the full process group.

Add a 30-second timeout to "fsmonitor--daemon stop" so it does
not block indefinitely if the daemon fails to shut down.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c  | 28 +++++++++++++++++++++++++---
 fsmonitor-ipc.c              |  3 +++
 t/meson.build                |  8 +-------
 t/t7527-builtin-fsmonitor.sh | 12 +++++++++++-
 4 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 110fe5fb55..be8f3fee1a 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -86,6 +86,8 @@ static int do_as_client__send_stop(void)
 {
 	struct strbuf answer = STRBUF_INIT;
 	int ret;
+	int max_wait_ms = 30000;
+	int elapsed_ms = 0;
 
 	ret = fsmonitor_ipc__send_command("quit", &answer);
 
@@ -96,8 +98,16 @@ static int do_as_client__send_stop(void)
 		return ret;
 
 	trace2_region_enter("fsm_client", "polling-for-daemon-exit", NULL);
-	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING) {
+		if (elapsed_ms >= max_wait_ms) {
+			trace2_region_leave("fsm_client",
+					    "polling-for-daemon-exit", NULL);
+			return error(_("daemon did not stop within %d seconds"),
+				     max_wait_ms / 1000);
+		}
 		sleep_millisec(50);
+		elapsed_ms += 50;
+	}
 	trace2_region_leave("fsm_client", "polling-for-daemon-exit", NULL);
 
 	return 0;
@@ -1431,7 +1441,7 @@ done:
 	return err;
 }
 
-static int try_to_run_foreground_daemon(int detach_console MAYBE_UNUSED)
+static int try_to_run_foreground_daemon(int detach_console)
 {
 	/*
 	 * Technically, we don't need to probe for an existing daemon
@@ -1451,10 +1461,21 @@ static int try_to_run_foreground_daemon(int detach_console MAYBE_UNUSED)
 		fflush(stderr);
 	}
 
+	if (detach_console) {
 #ifdef GIT_WINDOWS_NATIVE
-	if (detach_console)
 		FreeConsole();
+#else
+		/*
+		 * Create a new session so that the daemon is detached
+		 * from the parent's process group.  This prevents
+		 * shells with job control (e.g. bash with "set -m")
+		 * from waiting on the daemon when they wait for a
+		 * foreground command that implicitly spawned it.
+		 */
+		if (setsid() == -1)
+			warning_errno(_("setsid failed"));
 #endif
+	}
 
 	return !!fsmonitor_run_daemon();
 }
@@ -1517,6 +1538,7 @@ static int try_to_start_background_daemon(void)
 	cp.no_stdin = 1;
 	cp.no_stdout = 1;
 	cp.no_stderr = 1;
+	cp.close_fd_above_stderr = 1;
 
 	sbgr = start_bg_command(&cp, bg_wait_cb, NULL,
 				fsmonitor__start_timeout_sec);
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index f1b1631111..6112d13064 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -61,6 +61,9 @@ static int spawn_daemon(void)
 
 	cmd.git_cmd = 1;
 	cmd.no_stdin = 1;
+	cmd.no_stdout = 1;
+	cmd.no_stderr = 1;
+	cmd.close_fd_above_stderr = 1;
 	cmd.trace2_child_class = "fsmonitor";
 	strvec_pushl(&cmd.args, "fsmonitor--daemon", "start", NULL);
 
diff --git a/t/meson.build b/t/meson.build
index 85ef2ae2fa..19e8306298 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1210,18 +1210,12 @@ test_environment = script_environment
 test_environment.set('GIT_BUILD_DIR', git_build_dir)
 
 foreach integration_test : integration_tests
-  per_test_kwargs = test_kwargs
-  # The fsmonitor tests start daemon processes that in some environments
-  # can hang.  Set a generous timeout to prevent CI from blocking.
-  if fs.stem(integration_test) == 't7527-builtin-fsmonitor'
-    per_test_kwargs += {'timeout': 1800}
-  endif
   test(fs.stem(integration_test), shell,
     args: [ integration_test ],
     workdir: meson.current_source_dir(),
     env: test_environment,
     depends: test_dependencies + bin_wrappers,
-    kwargs: per_test_kwargs,
+    kwargs: test_kwargs,
   )
 endforeach
 
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 774da5ac60..d7e64bcb7a 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -766,7 +766,7 @@ do
 		else
 			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] enable fsmonitor" '
 				git config core.fsmonitor true &&
-				git fsmonitor--daemon start &&
+				git fsmonitor--daemon start --start-timeout=10 &&
 				git update-index --fsmonitor
 			'
 		fi
@@ -997,7 +997,17 @@ start_git_in_background () {
 		nr_tries_left=$(($nr_tries_left - 1))
 	done >/dev/null 2>&1 3>&- 4>&- 5>&- 6>&- 7>&- &
 	watchdog_pid=$!
+
+	# Disable job control before wait.  With "set -m", bash treats
+	# "wait $pid" as waiting for the entire job (process group),
+	# which blocks indefinitely if the fsmonitor daemon was spawned
+	# into the same process group and is still running.  Turning off
+	# job control makes "wait" only wait for the specific PID.
+	set +m &&
 	wait $git_pid
+	wait_status=$?
+	set -m
+	return $wait_status
 }
 
 stop_git () {
-- 
gitgitgadget
