Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0921A9B46
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693719; cv=none; b=hf3QjHinr9lXQYs3aWlhuYPdJpI7AZ5h0xyo+QSLWkZ3fC9mHHTmqMKLhApUpUhw5Wnlrr9hWANbshGn7Kmy0zuvtf2jjgI15jFdtmAijbJx8MEp0TusGY1mWE/RlOv3VICGTk3A7SliK3//beIAsZhzvUFOy0BFRhFzf8wMZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693719; c=relaxed/simple;
	bh=R/M1pSiulYkI3MaBc7JCCHLDnz1qZ5vOGNxlUFz7CA4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HTBJ2v+kgEGuOrUSvw9/aaZTRAE5pZurjFdlj+swMMvGfhiOihEjBss8B2XkvewmG6oY6It4LxUEXAcP/qLUx7EqqbbgGuzjfvzxVjhcUjFMCi90VzgRnQK+inNDl1NI4Zb9iJUrt5L7QDZuCNp9jl3QLM/R6PF9rjNzvHd+osQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+fNxZN0; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+fNxZN0"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2be1ab1fa7dso4880458eec.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772693717; x=1773298517; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SL61giWc4uack8bLc6ASt6Yc4SM4oGvLc1hcQdFhu8=;
        b=h+fNxZN0vrXa94uJryZMjWH9GCNz0sQohyesuebTNmKIUFUfItFKpPa1hahQg2BtOl
         JF45c80fRyJOzgN3XSUhWwETBi3NrCr6thrVW9a8wuA7W0nzxiG6OD4XqUYcInfFjlKE
         9xQmCRNxSZN/h5JPKhhUlb77pfnkWrip6TuRsWLg8W3U7JSzg+SWrvalaS4795lMknza
         VEGW/RTCAtQmjCD1Q1AmqwRVV/mXM2k+AMC+7kj6QL1nkwnUg5SVmkq1qvFNfwXhM4n/
         WtJbLp1JLWofOdRBUonJ6yDpu7ECO8DMt4lawfitO2zDa5onEmNeTrp/Cu20oiHvXQmY
         Tm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693717; x=1773298517;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2SL61giWc4uack8bLc6ASt6Yc4SM4oGvLc1hcQdFhu8=;
        b=BSiOYGq3K8rx+X1EtVMMq/6sIG4Vhx6vzLaLbizdWsbuti6buBU7KfkPkvUXMg3kub
         UzNdZsPZlmytV4MRzumCit7vhObWunnLitgomegezUuIZ5l/80stnWc1kwASM/JtmW2e
         hsOyEBqy0nVYhxeLJ7C2wPTWEbQAfrk83MpdDUQeQYQg8bC+8BxnqS3C7Bav0/7Xz/Pi
         VIt9Wi2pyD+SkDh6GSULlJtouq4t6SdLsjq7jY0C/hmCFMwgMOTOxII2lYYRgpj16Y1e
         Oun30JAjMSZHDLPmm0UcucSrjcsxYtq+ysJbusIXSLal46jMu0Y9UTNR42i1v7BhIx8K
         Tzmw==
X-Gm-Message-State: AOJu0YwKyXW5OEPABI2AqbqYUCO61RA3itZBfgbVWzwmdb5d6mX6q56J
	s8hzbz8dmoaz+tpuBw9tnSL+aEBj4IOaCx1cwhKaFd3aUlh1/u+r5xWH0d4Sog==
X-Gm-Gg: ATEYQzzDOBp8EojsENWaAvo2OLvgtOKawow7jALcFoQEp6C5UiX2r/uIVo80IcVBfBh
	yxDtMOcvNEdv4wNifTWq3l+Z2Cxds2iP2BBDZiSU5UU8jYBOOMeUNP+JdLWopF89taDbQj7/TMd
	vwC646HnXXjyi9fYKRT4mvJOC1r1pFEf448g1D4FUEbY7tmXHG3/JwGGi9fHFbUE4V4R/4gFnc8
	bi++wlgSjh+bnGC+Vkpzoh9guCCwKJa+jr5g29iBMzVApKBynliDBM9DYZ2V21R22VTwvZ+BApn
	O/ndjTZYL9/AXDQ9xv8uhJyhDmAAngMpTYIqRLWkU+Ydk3rzHXrGmLV2NjAY//KJAMeMCAxN2Hl
	W3Z5MSSSGGrpFFs918SVDGZaMuzAIP89urIP6Uh5wPV2bL6heHUzbtzR8T6cscFdvLmyIEenSoJ
	Kch3mFtIteJIYkNOCzyuW3rBfOuQ==
X-Received: by 2002:a05:7301:6785:b0:2be:9d3:c8c5 with SMTP id 5a478bee46e88-2be311d0c31mr2080194eec.34.1772693716480;
        Wed, 04 Mar 2026 22:55:16 -0800 (PST)
Received: from [127.0.0.1] ([52.190.182.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be09bc9ec4sm9897835eec.24.2026.03.04.22.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:55:14 -0800 (PST)
Message-Id: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 06:55:00 +0000
Subject: [PATCH v11 00/12] fsmonitor: implement filesystem change listener for Linux
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
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>

This series implements the built-in fsmonitor daemon for Linux using the
inotify API, bringing it to feature parity with the existing Windows and
macOS implementations. It also fixes two memory leaks in the
platform-independent daemon code and deduplicates the IPC and settings logic
that is now shared between macOS and Linux.

The implementation uses inotify rather than fanotify because fanotify
requires either CAP_SYS_ADMIN or CAP_PERFMON capabilities, making it
unsuitable for an unprivileged user-space daemon. While inotify has the
limitation of requiring a separate watch on every directory (unlike macOS
FSEvents, which can monitor an entire directory tree with a single watch),
it operates without elevated privileges and provides the per-file event
granularity needed for fsmonitor.

The listener uses inotify_init1(O_NONBLOCK) with a poll loop that checks for
events with a 50-millisecond timeout, keeping the inotify queue well-drained
to minimize the risk of overflows. Bidirectional hashmaps map between watch
descriptors and directory paths for efficient event resolution. Directory
renames are tracked using inotify cookie mechanism to correlate
IN_MOVED_FROM and IN_MOVED_TO event pairs; a periodic check detects stale
renames where the matching IN_MOVED_TO never arrived, forcing a resync.

New directory creation triggers recursive watch registration to ensure all
subdirectories are monitored. The IN_MASK_CREATE flag is used where
available to prevent modifying existing watches, with a fallback for older
kernels. When IN_MASK_CREATE is available and inotify_add_watch returns
EEXIST, it means another thread or recursive scan has already registered the
watch, so it is safe to ignore.

Remote filesystem detection uses statfs() to identify network-mounted
filesystems (NFS, CIFS, SMB, FUSE, etc.) via their magic numbers. Mount
point information is read from /proc/mounts and matched against the statfs
f_fsid to get accurate, human-readable filesystem type names for logging.
When the .git directory is on a remote filesystem, the IPC socket falls back
to $HOME or a user-configured directory via the fsmonitor.socketDir setting.

This series builds on work from https://github.com/git/git/pull/1352 by Eric
DeCosta and https://github.com/git/git/pull/1667 by Marziyeh Esipreh,
updated to work with the current codebase and address all review feedback.

Changes since v10:

 * Reverted pre_exec_cb callback back to simple close_fd_above_stderr flag
   per Junio's clarification (same as v8)

Changes since v9:

 * Fixed Windows build: close_fd_above_stderr() compiles as a no-op on
   Windows since there is no fork/exec

Changes since v8:

 * Replaced close_fd_above_stderr flag with generic pre_exec_cb callback in
   struct child_process per Junio's review, with close_fd_above_stderr() as
   a ready-made callback

Changes since v7:

 * Added patch 12: convert khash to strset in do_handle_client (Patrick's
   #leftoverbit suggestion)
 * Fixed "Forcing shutdown" trace message to start with lowercase
 * Fixed redundant statfs() call in find_mount() (caller already had the
   result)
 * Fixed CMakeLists.txt GIT-BUILD-OPTIONS: was hardcoded to "win32" for
   FSMONITOR_DAEMON_BACKEND and FSMONITOR_OS_SETTINGS, now uses the CMake
   variables
 * Fixed uninitialized strset on trivial response path (STRSET_INIT)
 * Removed V9FS_MAGIC from get_fs_typename() to match is_remote_fs() (9p is
   local VM mounts)
 * Split 30-second stop timeout into its own commit per review request
 * Fixed misleading indentation on shutdown assignment in handle_events()
 * Updated commit messages to describe all changes (test hardening,
   fsmonitor-ipc.c spawn changes)
 * Updated Makefile comment for FSMONITOR_OS_SETTINGS to mention fsm-ipc

Changes since v6:

 * Introduced FSMONITOR_OS_SETTINGS build variable (set to "unix" for macOS
   and Linux, "win32" for Windows) to eliminate if/else conditionals in
   Makefile, meson.build, and CMakeLists.txt per Junio's review
 * Moved fsm-path-utils from FSMONITOR_OS_SETTINGS to
   FSMONITOR_DAEMON_BACKEND since path-utils files are platform-specific
 * Removed V9FS_MAGIC from remote filesystem detection (9p is used for local
   VM/container host mounts where fsmonitor works fine)
 * Removed redundant #include <libgen.h> (already provided by
   compat/posix.h)
 * Fixed cookie wait comment wording ("see" to "observe")
 * Rewrote commit messages for IPC and settings dedup patches

Changes since v5:

 * Split monolithic commit into 10-patch series per Patrick's review
 * Deduplicated fsm-ipc and fsm-settings into shared Unix implementations
 * Rewrote commit message with prose paragraphs, explain inotify vs
   fanotify, removed "Issues addressed" sections, added Based-on-patch-by
   trailers
 * Removed redundant includes already provided by compat/posix.h
 * Fixed error/trace message capitalization per coding guidelines
 * Fixed stale rename check interval from 1000 seconds to 1 second
 * Changed poll timeout from 1ms to 50ms to reduce idle CPU wake-ups
 * Replaced infinite pthread_cond_wait cookie loop with one-second
   pthread_cond_timedwait (prevents daemon hangs on overlay filesystems
   where events are never delivered)
 * Added pthread_cond_timedwait to Windows pthread compatibility layer
 * Separated test into its own commit with smoke test that skips when
   inotify events are not delivered (e.g., overlayfs with older kernels)
 * Fixed test hang on Fedora CI: stop_git() looped forever when ps was
   unavailable because bash in POSIX/sh mode returns exit 0 from kill with
   an empty process group argument. Fixed by falling back to /proc/$pid/stat
   for process group ID and guarding stop_git against empty pgid.
 * Redirect spawn_daemon() stdout/stderr to /dev/null and close inherited
   file descriptors to prevent the intermediate process from holding test
   pipe file descriptors
 * Call setsid() on daemon detach to prevent shells with job control from
   waiting on the daemon process group
 * Close inherited file descriptors 3-7 in the test watchdog subprocess
 * Added 30-second timeout to "fsmonitor--daemon stop" to prevent indefinite
   blocking
 * Added helpful error message when inotify watch limit (max_user_watches)
   is reached
 * Initialize fd_inotify to -1 and use fd >= 0 check for correct fd 0
   handling
 * Use sysconf(_SC_OPEN_MAX) instead of hardcoded 1024 for fd close limit
 * Check setsid() return value

Changes since v4:

 * Added Meson build support

Changes since v3:

 * Fix crash on rapid nested directory creation (EEXIST from
   inotify_add_watch with IN_MASK_CREATE)
 * Extensive stress testing

Changes since v2:

 * Fix khash memory leak in do_handle_client

Changes since v1:

 * Fix hashmap memory leak in fsmonitor_run_daemon()

Paul Tarjan (12):
  fsmonitor: fix khash memory leak in do_handle_client
  fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
  compat/win32: add pthread_cond_timedwait
  fsmonitor: use pthread_cond_timedwait for cookie wait
  fsmonitor: rename fsm-ipc-darwin.c to fsm-ipc-unix.c
  fsmonitor: rename fsm-settings-darwin.c to fsm-settings-unix.c
  fsmonitor: implement filesystem change listener for Linux
  run-command: add close_fd_above_stderr option
  fsmonitor: close inherited file descriptors and detach in daemon
  fsmonitor: add timeout to daemon stop command
  fsmonitor: add tests for Linux
  fsmonitor: convert shown khash to strset in do_handle_client

 Documentation/config/fsmonitor--daemon.adoc   |   4 +-
 Documentation/git-fsmonitor--daemon.adoc      |  28 +-
 Makefile                                      |   6 +-
 builtin/fsmonitor--daemon.c                   |  92 ++-
 compat/fsmonitor/fsm-health-linux.c           |  33 +
 .../{fsm-ipc-darwin.c => fsm-ipc-unix.c}      |   0
 compat/fsmonitor/fsm-listen-linux.c           | 746 ++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-linux.c       | 217 +++++
 ...-settings-darwin.c => fsm-settings-unix.c} |   0
 compat/win32/pthread.c                        |  26 +
 compat/win32/pthread.h                        |   2 +
 config.mak.uname                              |  12 +-
 contrib/buildsystems/CMakeLists.txt           |  33 +-
 fsmonitor-ipc.c                               |   3 +
 meson.build                                   |  13 +-
 run-command.c                                 |  12 +
 run-command.h                                 |   9 +
 t/t7527-builtin-fsmonitor.sh                  |  89 ++-
 18 files changed, 1262 insertions(+), 63 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (100%)
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (100%)


base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2147%2Fptarjan%2Fclaude%2Fupdate-pr-1352-current-85Gk8-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2147/ptarjan/claude/update-pr-1352-current-85Gk8-v11
Pull-Request: https://github.com/git/git/pull/2147

Range-diff vs v10:

  1:  4d4dec8fa1 =  1:  4d4dec8fa1 fsmonitor: fix khash memory leak in do_handle_client
  2:  cb270120f0 =  2:  cb270120f0 fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
  3:  44a063074d =  3:  44a063074d compat/win32: add pthread_cond_timedwait
  4:  b1081d1e13 =  4:  b1081d1e13 fsmonitor: use pthread_cond_timedwait for cookie wait
  5:  dec0fb144f =  5:  dec0fb144f fsmonitor: rename fsm-ipc-darwin.c to fsm-ipc-unix.c
  6:  b2aaadb4ae =  6:  b2aaadb4ae fsmonitor: rename fsm-settings-darwin.c to fsm-settings-unix.c
  7:  03cf12d01b =  7:  03cf12d01b fsmonitor: implement filesystem change listener for Linux
  8:  39dcfbb7c8 !  8:  50f5b4676e run-command: add pre-exec callback for child processes
     @@ Metadata
      Author: Paul Tarjan <github@paulisageek.com>
      
       ## Commit message ##
     -    run-command: add pre-exec callback for child processes
     +    run-command: add close_fd_above_stderr option
      
     -    Add a pre_exec_cb function pointer to struct child_process that is
     -    invoked in the child between fork and exec.  This gives callers a
     -    place to perform setup that must happen in the child's context,
     -    such as closing inherited file descriptors.
     -
     -    Provide close_fd_above_stderr() as a ready-made callback that
     -    closes file descriptors 3 and above (skipping the child-notifier
     -    pipe), capped at sysconf(_SC_OPEN_MAX) or 4096, whichever is
     -    smaller.
     +    Add a close_fd_above_stderr flag to struct child_process.  When set,
     +    the child closes file descriptors 3 and above between fork and exec
     +    (skipping the child-notifier pipe), capped at sysconf(_SC_OPEN_MAX)
     +    or 4096, whichever is smaller.  This prevents the child from
     +    inheriting pipe endpoints or other descriptors from the parent
     +    environment (e.g., the test harness).
      
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
     @@ run-command.c: static void atfork_parent(struct atfork_state *as)
      +
       #endif /* GIT_WINDOWS_NATIVE */
       
     -+void close_fd_above_stderr(void)
     -+{
     -+#ifndef GIT_WINDOWS_NATIVE
     -+	long max_fd = sysconf(_SC_OPEN_MAX);
     -+	int fd;
     -+	if (max_fd < 0 || max_fd > 4096)
     -+		max_fd = 4096;
     -+	for (fd = 3; fd < max_fd; fd++) {
     -+		if (fd != child_notifier)
     -+			close(fd);
     -+	}
     -+#endif
     -+}
     -+
       static inline void set_cloexec(int fd)
     - {
     - 	int flags = fcntl(fd, F_GETFD);
      @@ run-command.c: fail_pipe:
       			child_close(cmd->out);
       		}
       
     -+		if (cmd->pre_exec_cb)
     -+			cmd->pre_exec_cb();
     ++		if (cmd->close_fd_above_stderr) {
     ++			long max_fd = sysconf(_SC_OPEN_MAX);
     ++			int fd;
     ++			if (max_fd < 0 || max_fd > 4096)
     ++				max_fd = 4096;
     ++			for (fd = 3; fd < max_fd; fd++) {
     ++				if (fd != child_notifier)
     ++					close(fd);
     ++			}
     ++		}
      +
       		if (cmd->dir && chdir(cmd->dir))
       			child_die(CHILD_ERR_CHDIR);
     @@ run-command.h: struct child_process {
       	unsigned wait_after_clean:1;
      +
      +	/**
     -+	 * If set, the callback is invoked in the child between fork and
     -+	 * exec.  It can be used, for example, to close inherited file
     -+	 * descriptors that the child should not keep open.
     ++	 * Close file descriptors 3 and above in the child after forking
     ++	 * but before exec.  This prevents the child from inheriting
     ++	 * pipe endpoints or other descriptors from the parent
     ++	 * environment (e.g., the test harness).
      +	 */
     -+	void (*pre_exec_cb)(void);
     ++	unsigned close_fd_above_stderr:1;
      +
       	void (*clean_on_exit_handler)(struct child_process *process);
       };
       
     -@@ run-command.h: struct child_process {
     - 	.env = STRVEC_INIT, \
     - }
     - 
     -+/**
     -+ * Close file descriptors 3 and above.  Suitable for use as a
     -+ * pre_exec_cb to prevent the child from inheriting pipe endpoints
     -+ * or other descriptors from the parent environment.  On Windows
     -+ * this is a no-op since there is no fork/exec.
     -+ */
     -+void close_fd_above_stderr(void);
     -+
     - /**
     -  * The functions: start_command, finish_command, run_command do the following:
     -  *
  9:  5db0591c15 !  9:  057b3098bc fsmonitor: close inherited file descriptors and detach in daemon
     @@ builtin/fsmonitor--daemon.c: static int try_to_start_background_daemon(void)
       	cp.no_stdin = 1;
       	cp.no_stdout = 1;
       	cp.no_stderr = 1;
     -+	cp.pre_exec_cb = close_fd_above_stderr;
     ++	cp.close_fd_above_stderr = 1;
       
       	sbgr = start_bg_command(&cp, bg_wait_cb, NULL,
       				fsmonitor__start_timeout_sec);
     @@ fsmonitor-ipc.c: static int spawn_daemon(void)
       	cmd.no_stdin = 1;
      +	cmd.no_stdout = 1;
      +	cmd.no_stderr = 1;
     -+	cmd.pre_exec_cb = close_fd_above_stderr;
     ++	cmd.close_fd_above_stderr = 1;
       	cmd.trace2_child_class = "fsmonitor";
       	strvec_pushl(&cmd.args, "fsmonitor--daemon", "start", NULL);
       
 10:  8a9a6ba4fa = 10:  e6bc3bfcb2 fsmonitor: add timeout to daemon stop command
 11:  27d5560007 = 11:  81f8cd1599 fsmonitor: add tests for Linux
 12:  8ea20aab4c = 12:  8fa6a74e0d fsmonitor: convert shown khash to strset in do_handle_client

-- 
gitgitgadget
