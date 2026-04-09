Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C698220F49
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710780; cv=none; b=FqkUsaw7Z8RJNa3lVMT1p4D9rdHNbZ71XTy7Wzb+SWeJEP6t8AlHFAKPTRdOmjOtWZNdsPt3l99u7Wf4TW4jqkyHVpTFpskaLO7BgmvRE3ZmArk3/8EFw2fZM0gHwF4G9P8WkBtFiy3ioBrzvW/+HmS20Y8vStspMi1qhAwWMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710780; c=relaxed/simple;
	bh=1gYaXqWSQT4OsBsd3HHbBUv35f37qmlnkAjpTY0Uo6Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Un8Jraea1EuZFCH8kgdj8pM0kU9aMkx0qNwG/wCl5fKiKjFCWLOHVXf7WiejQVp5GDb5HckrOLg9pB9VeK95tiUrpuBn6IUUQ1/FQPQ37uSgz6cFdKV/o3cdv+WbifpZMvhTY9ZJ/G4Uhssy/AxFC7kIDgVQ+rokrRToR3A4QQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcFZxtCp; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcFZxtCp"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d7e7f48499so43815485a.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710777; x=1776315577; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz18ieed7PXTTQh7TRpLIuDi3zNDRnZyvm1IUoq9jpg=;
        b=CcFZxtCpMepV0XqcSP/hjEfJ872+NWJnEoDqfv/wVM72RsylvY9JHX2mGShXm7JfGg
         ojrFOFXPmW2x+VbtpAzO0Y0h82qhViu7OZs0Uh1kNiDHy0UgOFMqIkEtgAWvvhbdS4ED
         6f0GrH9lgtF1zxj6SLgtX8IrEZVv7NmP4j9Ew5IjuRDSQ0spCtjt0egDT0go9ajq/Jqz
         jp0IYZsNyZ+f27PqGd/tQUHqeNcdQoG+1RH0rN9GZWcSib7jO7xLi3eVZiYCp6jtsYFk
         ODmBa9fQtfvjkimJ3LaRALJqevzjtoIbWw8nqELSs7UQRlUxnE72WEvofHYVEUG34wZW
         pEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710777; x=1776315577;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tz18ieed7PXTTQh7TRpLIuDi3zNDRnZyvm1IUoq9jpg=;
        b=H0SVdlXc8CznoJ+imzhaxeCv0gzW0wMir/dRUkcMcwBGBt2mSSqj1gKKOHHhQGlkzY
         F3kKpnPb61CuiefXRQai3i3ZMdccqkz/iMLDNWZd35pPePRaer5W1v1gRl675MbbSQyf
         6VPfGfAcNqL7entKdh6JaiFHqhV9nGSL+WPLAYVvEPtpU5MVBwzy6UgbjHfV/8wyOfhp
         XRQSznZlELqqgT2ccG9i+MW4zRd8Y/o7b41UA5fF67bkRbY3gHBxuoO09MGLGu5LuG+a
         CyjbcYH19Ht7qTrRCHpsv6t3Gf5W18UPALib5VMxUE8Ruk6WgDtIfHcHqbV1vAVkZZDM
         6cWQ==
X-Gm-Message-State: AOJu0Yyd20seWL3b12uGCPNXl5MD4RJ057pTKQeFOsb1WtPMq6lCMuma
	VA8+ZbrNXeG+vFueijjfcLmV+E208N17XuYwbfc4vneSrsse6lgW4n3aFLiMEg==
X-Gm-Gg: AeBDiesORrmXKM6IBwHRdSWIC9sFbHG4wBaSXHeFjd9BgSoYFEyPMM18QTOgmOmRqJK
	mejKBsXXQc94YOhcops4pOpI8w0xXA09Y8zXmk4J13AM8zDcBN4vNivYesfg0fQbXJNUmWYZCy+
	jjw+4WVpMSvQ7B1fD7G4OHpoV0zsHLXXvafzTb5IsrQhzNH3jB48PLoPwczh8u77YJe+5SO3ZM/
	qzDumKmz2m1rRwiTwMA6WjotyhxZKtRNfjbWT1dgBDE7koayXv9oOPi5ibh1TbkyrCzqNyXELcr
	wiXqcAR+sx7qG17FjP3mpxtyvMlDDcUY9oAjvFxA1A5ymNH/NPs/UFvB2KlseiPCEQfVr55XpJX
	Y2JcXB5OIRHyFfPOUEjqCcxInMYtgEnOs+ilIr6KkA0udbffF631w0eB8e0jvN/Sr3p3qk/O3vr
	+C36NBpRTfoE2kjgTFzANs5hbuk9I=
X-Received: by 2002:a05:620a:bc9:b0:8cf:c272:971c with SMTP id af79cd13be357-8d41bbdaeffmr3118357585a.9.1775710776504;
        Wed, 08 Apr 2026 21:59:36 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5a6c530sm1722684185a.14.2026.04.08.21.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:35 -0700 (PDT)
Message-Id: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:22 +0000
Subject: [PATCH v14 00/13] fsmonitor: implement filesystem change listener for Linux
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

Changes since v13:

 * Also disable GIT_TEST_SPLIT_INDEX in t9211 per Junio's feedback (every
   test does scalar clone)

Changes since v12:

 * Dropped both the fsmonitor.c workaround and the read-cache.c skipHash fix
   per Dscho's review: split-index and index.skipHash are fundamentally
   incompatible
 * Added sane_unset GIT_TEST_SPLIT_INDEX to scalar clone tests in t9210
   (patch 1/13)

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
  t9210, t9211: disable GIT_TEST_SPLIT_INDEX for scalar clone tests
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
 t/t9211-scalar-clone.sh                       |   5 +
 20 files changed, 1273 insertions(+), 63 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (100%)
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (100%)


base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2147%2Fptarjan%2Fclaude%2Fupdate-pr-1352-current-85Gk8-v14
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2147/ptarjan/claude/update-pr-1352-current-85Gk8-v14
Pull-Request: https://github.com/git/git/pull/2147

Range-diff vs v13:

  1:  28c5aca413 !  1:  721a951423 t9210: disable GIT_TEST_SPLIT_INDEX for scalar clone tests
     @@ Metadata
      Author: Paul Tarjan <github@paulisageek.com>
      
       ## Commit message ##
     -    t9210: disable GIT_TEST_SPLIT_INDEX for scalar clone tests
     +    t9210, t9211: disable GIT_TEST_SPLIT_INDEX for scalar clone tests
      
          index.skipHash (Scalar default) and split-index are incompatible:
          the shared index gets a null OID when skipHash skips computing the
     @@ Commit message
          index has.
      
          Disable GIT_TEST_SPLIT_INDEX in the scalar clone tests that hit
     -    this, matching the existing workaround in test 16.
     +    this: tests 12, 13, and 22 in t9210 (matching the existing
     +    workaround in test 16), and all of t9211 (every test does scalar
     +    clone).
      
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
     @@ t/t9210-scalar.sh: test_expect_success '`scalar [...] <dir>` errors out when dir
       	scalar clone "file://$(pwd)" cloned --single-branch &&
       	git repack &&
       	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
     +
     + ## t/t9211-scalar-clone.sh ##
     +@@ t/t9211-scalar-clone.sh: test_description='test the `scalar clone` subcommand'
     + GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
     + export GIT_TEST_MAINT_SCHEDULER
     + 
     ++# index.skipHash (Scalar default) and GIT_TEST_SPLIT_INDEX are
     ++# incompatible: the shared index gets a null OID and fails to
     ++# load on re-read.  Every test here uses scalar clone.
     ++sane_unset GIT_TEST_SPLIT_INDEX
     ++
     + test_expect_success 'set up repository to clone' '
     + 	rm -rf .git &&
     + 	git init to-clone &&
  2:  9f666beea7 =  2:  1283d25968 fsmonitor: fix khash memory leak in do_handle_client
  3:  a4a65a6dfa =  3:  11ba6ca9ac fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
  4:  427073fc38 =  4:  a0d430c2f4 compat/win32: add pthread_cond_timedwait
  5:  71effc4d47 =  5:  7b62c95c44 fsmonitor: use pthread_cond_timedwait for cookie wait
  6:  e897193b0e =  6:  7086cd4530 fsmonitor: rename fsm-ipc-darwin.c to fsm-ipc-unix.c
  7:  e13d938ddb =  7:  46e8c2b74f fsmonitor: rename fsm-settings-darwin.c to fsm-settings-unix.c
  8:  3431eae60f =  8:  b3f40a497b fsmonitor: implement filesystem change listener for Linux
  9:  7ce0ab87fb =  9:  5791edbef2 run-command: add close_fd_above_stderr option
 10:  2bf134a041 = 10:  22d425ebeb fsmonitor: close inherited file descriptors and detach in daemon
 11:  cb4d511f21 = 11:  fd6bdc8c55 fsmonitor: add timeout to daemon stop command
 12:  9a8647884e = 12:  f85983ca93 fsmonitor: add tests for Linux
 13:  a5fc9ad415 = 13:  2085b21e23 fsmonitor: convert shown khash to strset in do_handle_client

-- 
gitgitgadget
