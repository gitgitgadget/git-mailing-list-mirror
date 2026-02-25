Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B9306B21
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050653; cv=none; b=BOSAqCND4YeCFEXdi4DLwd+6n72JU9jEZjOAYS0h2xPVSiFUBJqbaqZLgK1Y/r5Kef5kI3x4OhFhZ74KXUUw2GmFTRda8QdnTlSZuLKg6sgFoB2a8PetOYTFWTGMYX9KA+kW5zuvHlJEykuxpO7PPKWSIQlIGawFykicbSGS02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050653; c=relaxed/simple;
	bh=utN86Gxbd8gHFWHmHAF1oA8qSVp5NwdkxfKg0UIiNi0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DwTD/1CoDCjKutbEtci45dp0A4y0GkDUQa6JTd6L8pC67YSEU0ORIaPrxl6RzEu3oGgZ/cQ1LNA9UxttAahhQuEmEpOOD/C9yJoGWGtHTIYV503jXEg1kw2UZnfQ+dIiniQ5nZRCF35hjflN3ofIF+29NK8RQoqhzPP252EpPVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAcRhsp6; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAcRhsp6"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-896f82e5961so2054866d6.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772050650; x=1772655450; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyly/ckCadeICdO+fFjRUMNnxT4MVariDzwJq95lXVQ=;
        b=WAcRhsp61+t8DxEh06olk7WokTtPIWAJd8ZI0pB7Im+8OaAC8zp4BeorEGdiQMw0D2
         wMenWUDvsDmYutWJw/uAJB8qStnxMd7Eid3Xa6QsFunWGvyZaUbMy0yEedeGtfLySTS8
         yDLD9M9MNjihJarFD3HN1me9D6D6SWVcsJyQxT66rKjhCuEX2hU3ew9PFXe+jYvqdj2m
         c0QmGLSI1hUp1DXA+JYsgriI33q6ABXczEDYm2yutpopq5obxAJsZLBqDL3S1kVTZu+V
         IoiR8NHEV5um6WFoV/JyOk1TGDaGbnT4e1KvUHP2aOhY2OWHmSaH5yWidmtviGwat8h9
         RNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050650; x=1772655450;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lyly/ckCadeICdO+fFjRUMNnxT4MVariDzwJq95lXVQ=;
        b=lJrUP6SL9zlf0BmHqEr/pe2VgBgKH5N6oScZwbq2l4ZzAnmD+NCwaV+8CCoQhri8nL
         L/uB4DPyuxdPpQcjx8UpnVGNjAdus9xSKa1/p46wyK3Flz1HK93XhXNPu0ZZW1tDT/vT
         yjCLhozNOoYYsd1EU01ro5oR8/dGiWCIGoATZW1Fpigu7UN/INWPPNY6DR57XomYC4BC
         Ug6tQGZY202MnyFmOFQfpmZa4LgZPnlBiLqtlAMyLyvFKHqqfG7ljHoJhReqKIjjej/B
         HQM+7aiAtZPcCl3hCePmeozDCJR6dQHy7h+xTrjnTro1ohSG5jGrgIalkmVTIfxBu2gr
         mgGA==
X-Gm-Message-State: AOJu0YwavoV3+4s1Xyl+AqLP+TE061imf8Fx0IydwNJ/MypSkJEeTCBb
	kfUY44pIWawa+m1DeV/6sZJJLbqUp5dX6X96vhfrDWg2fGW4Ew5tpArjIsw78Q==
X-Gm-Gg: ATEYQzyVuumLXSL5t/BCWv8llAthCO6+ttsUvvbirM+MqK/By3HTubLGgn+27HjawSj
	hmlKxPIsMFvl0/8duCFSoF4Va6l9zerBAAF+xU1SOH/RvwJEpRJtvuEwPKE2Ar1/TJEcPaoq1+V
	1csKO/XPgI4u6a0lkuQ6rxugOLWMQkOCvhjIvfn7wfn88EGIfsPPxvwz7TBnm6bAB7ASq4uiISm
	9CcMV2fIjJag7aK9U57d8B5uvXxfc6QpLByYPybawKH6OGcG85z1QmZ+UR+V2DGx/3qfUf1nVBF
	d3DfiCAqiUlcZ6cFFqkgnoKFUba6PT/+DY/djBoq+hH9sG4LUbX2wQP3GdRRujlFe6dwnrCPrnt
	zwvwOZK7n0rpDNVyEH972FlbgfWb4ortODd1zixy/9K+RqEAk6djURF2IU4BJ7hDcg1eDXXT7fo
	orNqJudyEftOjtKMm0cEJ6H+j68IbgQE7VA3Yv
X-Received: by 2002:a05:6214:2686:b0:896:f8dc:f6d4 with SMTP id 6a1803df08f44-899c13b94abmr24723516d6.5.1772050650225;
        Wed, 25 Feb 2026 12:17:30 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e76d635sm124974046d6.48.2026.02.25.12.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:17:29 -0800 (PST)
Message-Id: <bb438afbbe3e8bbc2ed048930ef11fb02eb4163c.1772050636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 20:17:16 +0000
Subject: [PATCH v6 10/10] fsmonitor: close inherited file descriptors and
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
index f6c406ff12..4ed848e79e 100644
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
