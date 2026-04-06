Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD327603F
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498103; cv=none; b=Lh11/42wViLeMpP30WeHPZAbKlmpZkoX9JTfGzxWXDXe0loP4FbiZtS8UTWPJnrubwKVsPoT2SSTt2U987W8kOM+MTzR1bsungcYaNbtC072VWJ2OLvBP7s33p5C/QEPY0RBVMl47TLE3krxRRLJynRUkbj/0HYP2E8f56oGjyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498103; c=relaxed/simple;
	bh=EPKE4we5f5l/58pN0aWwpVYMI4EytQsy9ShQlozWk4E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EUPr01y6UYZKBZSkbEzALBj0jMzmkCOmOkYsiZzfiFazfpBKMvy9Ld4D8wLIwu1QnrnCMcwsrAs9lFADrsBHvPgtWHXeKfiEPPXNKMWlmCPiASO9HnZ6MT6X+VDBHFVGJ4MpTYZKUFqjbW3pTn9FxnSmfRCxPZ33ijWy0fdKn2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoGXNFge; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoGXNFge"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2cfd69b564dso1824263eec.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498100; x=1776102900; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTYptSUrwJj0hAq/b7N5OSZ781KhBwt/tT5lw0l/r78=;
        b=QoGXNFgeoYajflTVpkhdA9FlVGZZLw+6swVwTOkKcCvHt5byzETW58qyIwsNQO5Y2B
         BTanP59i1SzrcBvq5ajLtdieEL27x2Zb1fNWh0M57hYHUvg17ADQQbnbTAmgh1WQo05D
         CqSSJOZ4ve0mIg2B6k659SSNaXbUswR94nsnXOPLEocy3Km1odrVoJ8FgBLEkxcjrGcV
         /WPy46ceWbDKSuqt+kBdTiYewaaiq/coX951Y9TtRrDwAZcJBWqbtUna8Ew5jW4yExoI
         B8nz9O7U44VW8kTHKRnVgpdm/zf1vpP0tYHHlfzcDBKpvPqWIsJ4fPkWfj6xktIOYPh1
         PGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498100; x=1776102900;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTYptSUrwJj0hAq/b7N5OSZ781KhBwt/tT5lw0l/r78=;
        b=OXzz7E0MeYqgxhRIKgRFBbw6eDarSQomSV6wr8R7RoLoYiPf4GadB6lqR4uURbdDtx
         ZK/XhqnysHybQHxy+dthAnxHCA7d0LKSSqD9ukdgQPdlCbwiQ+cWc5P6WJo0spEOd7T6
         pjJYgRMN1SjWb/H0jvu9Z2lWO/C9dQPFknRhonGJQXZuhwmOlzZH5NoNERC0haTcufZx
         8qdwRvhV+LI53Wp8zFBMuMR+VdaGnUK73mpYM1N0Cw7EOfSe+167CWL5kdI9d0r4bqcN
         atCq5JaD+Yfoztl4t71zen9h7ccZRkzNWPBOP3PKBRL7Y3lSw3k42jM2MK74nMMwmyWt
         OhqA==
X-Gm-Message-State: AOJu0YyoV+rcLkifd8OrBmrPlZ031qiSTdpyipvTjxEC/JFL4xxo6Glx
	E9fr6bqKWcYUi5Rke46Aj8zZ7pWeI29z3h5G3eqVySu3q82MgRXJTswPAPo6RQ==
X-Gm-Gg: AeBDiesT06B+M61PIuzrhZym9JEXQAPGFssQKMj7/jNJVHItbot41bB8M7HivY2K6sl
	bDczr2bKJlzqYSUrKVvOHjx3J1yez46GAsO/jwuYJ4YpMhnSPEaIppLnMWly62tUpUfWNr6hm9R
	MsOgV85nkTwILkw6ht5B7Ho5JLUZr2bNOOWvKdt3L8okMwybMdtRnfSUfEcR3mEkHR7n5lIsCNi
	MvJRA2QQ8Uh8bOF7OeigRNBbUst4gdJ/RsD/Ubco3nesqc0f0Lc6Os9k0IXuUE3ETSt+sMlSyBO
	URBfdT1P+GgaNTS6uE++P4+nltgjW7cNb7Sixyvp6Xz5uo1XfkGCbPqmZ4Z46vqv/u1yoi6JTaS
	aiyiGT0cXKxf51t59vKBkIgRT55nY3ohuFkm8t4FLVDmLKUnY9Dk6v4XWBdJE9URFh7f9cXvtd4
	9yafpMS5GWxjnTo86VYF3MNYg6deE=
X-Received: by 2002:a05:7300:a944:b0:2b8:64ad:ad4d with SMTP id 5a478bee46e88-2cbfc361a70mr7282422eec.26.1775498099780;
        Mon, 06 Apr 2026 10:54:59 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cf2be19f85sm5923662eec.30.2026.04.06.10.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:54:59 -0700 (PDT)
Message-Id: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 17:54:45 +0000
Subject: [PATCH v13 00/13] fsmonitor: implement filesystem change listener for Linux
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

Changes since v12:

 * Dropped both the fsmonitor.c workaround and the read-cache.c skipHash fix
   per Dscho's review: split-index and index.skipHash are fundamentally
   incompatible
 * Added sane_unset GIT_TEST_SPLIT_INDEX to scalar clone tests in t9210
   (patch 1/13), matching the existing workaround in test 16

Changes since v11:

 * Fix t9210 BUG assertion with GIT_TEST_SPLIT_INDEX=yes: guard
   fsmonitor_dirty bitmap access against split-index having fewer entries
   than the bitmap expects

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

Paul Tarjan (13):
  t9210: disable GIT_TEST_SPLIT_INDEX for scalar clone tests
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
 t/t9210-scalar.sh                             |   6 +
 19 files changed, 1268 insertions(+), 63 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (100%)
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (100%)


base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2147%2Fptarjan%2Fclaude%2Fupdate-pr-1352-current-85Gk8-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2147/ptarjan/claude/update-pr-1352-current-85Gk8-v13
Pull-Request: https://github.com/git/git/pull/2147

Range-diff vs v12:

  -:  ---------- >  1:  28c5aca413 t9210: disable GIT_TEST_SPLIT_INDEX for scalar clone tests
  1:  4d4dec8fa1 =  2:  9f666beea7 fsmonitor: fix khash memory leak in do_handle_client
  2:  cb270120f0 =  3:  a4a65a6dfa fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
  3:  44a063074d =  4:  427073fc38 compat/win32: add pthread_cond_timedwait
  4:  b1081d1e13 =  5:  71effc4d47 fsmonitor: use pthread_cond_timedwait for cookie wait
  5:  dec0fb144f =  6:  e897193b0e fsmonitor: rename fsm-ipc-darwin.c to fsm-ipc-unix.c
  6:  b2aaadb4ae =  7:  e13d938ddb fsmonitor: rename fsm-settings-darwin.c to fsm-settings-unix.c
  7:  03cf12d01b =  8:  3431eae60f fsmonitor: implement filesystem change listener for Linux
  8:  50f5b4676e =  9:  7ce0ab87fb run-command: add close_fd_above_stderr option
  9:  057b3098bc = 10:  2bf134a041 fsmonitor: close inherited file descriptors and detach in daemon
 10:  e6bc3bfcb2 = 11:  cb4d511f21 fsmonitor: add timeout to daemon stop command
 11:  81f8cd1599 = 12:  9a8647884e fsmonitor: add tests for Linux
 12:  8fa6a74e0d = 13:  a5fc9ad415 fsmonitor: convert shown khash to strset in do_handle_client
 13:  84ddbb30bb <  -:  ---------- fsmonitor: fix split-index bitmap bounds in tweak_fsmonitor()

-- 
gitgitgadget
