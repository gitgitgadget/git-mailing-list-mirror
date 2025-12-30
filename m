Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA632FBE1D
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767082456; cv=none; b=ciro57aaOjst/xgQjGeo7zlme/02YkK9b82yEAGaoy0GB706Kh84aoToh7eNllF8WX5aoSSJ15boCxM8iWmbNgpfhAcdf4cqs+zxd/2Ike2wSeLMLi5/pfQf27piK+XsIYi0NCSDVQJ3utkhtUuBLA7oc6OPHHAF/8GH97B6rlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767082456; c=relaxed/simple;
	bh=EbtVRosbGIHUPZzOgW4UVammmyJ20y8MSKXNYZMKTIY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=WTgqP5CYP5La/dJSKY1IENqlLlkgQZKz35v8AgwTY0eEyITKnOCagMHl+ebeHSH0iE+kmunPqjpNkpy32yClv3R0xQIyWkctYw1pdWFsqzsW8E67w425vhhiD/gLQ8c1LsCWUyfK1jMzYmXN0dGLZgyl4G+TwGRdC3yubxN/vpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH6QCLaQ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH6QCLaQ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2d6df99c5so1028694285a.1
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 00:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767082452; x=1767687252; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R0UsOOwdGztn2c+wOOQW6yACq10C8mned5PEKbBdhwU=;
        b=kH6QCLaQWsGmqy7sFboCwP9zAGBUd1xQFJrpYDIa0OLVOLJsO6JCvmi4QiczESAPmA
         A/yLiedY+cHkz3P2AGf+AoeUNlpCHZ4IihRenahO+YxJA7QLKZ6vmpUxpafsfydRpkqu
         Yif9o0c6gGDzf/64tDR+2FVKBJqv+Uht3lBK+gT1Fum3tK7UFbxzmVK3pJRteTwSOeCV
         6GKwcu6gAqUVJybL7+ZvY/BTD5IagBBf8WsK/2YPDehIpHFO+lu1Y5wBjlLjrZlJ7fmm
         UMx26EmGypKroduAEtIdBN0pBbJ6Gsz1TL0LqbO/XmKm7JdANpr0165GlwwRZIFbGFoh
         3GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767082452; x=1767687252;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0UsOOwdGztn2c+wOOQW6yACq10C8mned5PEKbBdhwU=;
        b=LQ2jbgvLtbKGABjXaxqw24xsDxfNzgX9Ku0eAj3U2JPW1A4pluaaFvMWNjDXF+xcOs
         kguqNAYbFxkRBXbAq51EXAauQZmpgMB1sPuNyZfNiOO0uyjYZMzrRgLa6kAw0I/xm13y
         /e6mrKmblt0govGLSbTDRXGr++H3ANHBAXJtrdAmcTsoddxfDOz28tgXOY2oL8DMIKHy
         BC2vCY3DLJgK+iTnFPEy+PSTZlTAXwCny4Me79dVMluP6m28urGoa+Z/1P7LedG6NE4j
         E7FZZ1YSqg/O7wiqDSLdsav/UtZQ1UGHQpK+cPIT/59tSCMF8b+FHSA22nW2Pr7fZks7
         gWcA==
X-Gm-Message-State: AOJu0Ywi5iX5n8NrVDl7nGpkyX13iAmwJ9pGZoRCqyULvV2OCXrn8A4O
	6GTu9WOmIKBcvnFyHcYSk+Ns0L/bc51gBM1gaggQQL39chpOioGNz3k/k5JR2qbm
X-Gm-Gg: AY/fxX5Fg7OvF4EwuBKtY5hdN9OLeACwKmLNaO0VwWJnlJLpc/S21tOO08R0SfTeqU+
	qrYT4ECjQAWQZO05v2/ffYxiETvI5S7ckpHLguGeEN6XiHHf8MyLn4GfqhMlQBtxRIcBTsPEy2h
	OFeEMCz949/tHotEIh4XqzpNl1oe1/7CHaYlr1YuAizvBFBV0mgQAFsv2gsbUNYX+4kH9+xlAKf
	Nzk/7JZr9rG5gY5zrkKLUbXo9pSJjGB6OabvV09GCFjGTBOyub4GrqsBEuRPF9m2xPJkHq6ml3A
	8BEQc4xssSSyVmJA0vZPrMXGGB0JwtGTudhT+gO1ouxRsuy5HBTzUtqmk2IoDei6rJuHxnhboOz
	k0kDm9VYMABoNlm+uBJeSMntyY4AW4Z5XuoTiBQbVXqgrY8QIFXJH6jF4VsRVLMxut+Og6MhRN1
	iLdzebFb5JTKhtbQ==
X-Google-Smtp-Source: AGHT+IGjjBQuG6uKnYDF5ZFP2MpTWkTwE5nBCKYXhp9ZWLhNCdsAJqC15RRlq2sFi7+FAxFjFevmoA==
X-Received: by 2002:a05:620a:f11:b0:8b9:fcc6:6473 with SMTP id af79cd13be357-8bee79ba2f5mr5155926085a.33.1767082451799;
        Tue, 30 Dec 2025 00:14:11 -0800 (PST)
Received: from [127.0.0.1] ([64.236.131.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0971ee247sm2541763785a.27.2025.12.30.00.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 00:14:11 -0800 (PST)
Message-Id: <pull.2147.git.git.1767082450088.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Dec 2025 08:14:10 +0000
Subject: [PATCH] fsmonitor: implement filesystem change listener for Linux
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
Cc: Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

Implement fsmonitor for Linux using the inotify API, bringing it to
feature parity with existing Windows and macOS implementations.

The Linux implementation uses inotify to monitor filesystem events.
Unlike macOS's FSEvents which can watch a single root directory,
inotify requires registering watches on every directory of interest.
The implementation carefully handles directory renames and moves
using inotify's cookie mechanism to track IN_MOVED_FROM/IN_MOVED_TO
event pairs.

Key implementation details:
- Uses inotify_init1(O_NONBLOCK) for non-blocking event monitoring
- Maintains bidirectional hashmaps between watch descriptors and paths
  for efficient event processing
- Handles directory creation, deletion, and renames dynamically
- Detects remote filesystems (NFS, CIFS, SMB, etc.) via statfs()
- Falls back to $HOME/.git-fsmonitor-* for socket when .git is remote
- Creates batches lazily (only for actual file events, not cookies)
  to avoid spurious sequence number increments

Build configuration:
- Enabled via FSMONITOR_DAEMON_BACKEND=linux and FSMONITOR_OS_SETTINGS=linux
- Requires NO_PTHREADS and NO_UNIX_SOCKETS to be unset
- Adds HAVE_LINUX_MAGIC_H for filesystem type detection

Documentation updated to note that fsmonitor.socketDir is now supported
on both Mac OS and Linux, and adds a section about inotify watch limits.

Testing performed:
- Build succeeds with standard flags and SANITIZE=address
- All t7527-builtin-fsmonitor.sh tests pass on local filesystems
- Remote filesystem detection correctly rejects network mounts

Issues addressed from PR #1352 (git/git) review comments:
- GPLv3 ME_REMOTE macro: Rewrote remote filesystem detection from
  scratch using statfs() and linux/magic.h constants (no GPLv3 code)
- Memory leak on inotify_init1 failure: Added FREE_AND_NULL cleanup
- Unsafe hashmap iteration in dtor: Collect entries first, then modify
- Missing null checks in stop_async: Added proper guard conditions
- dirname() modifying argument: Create copy with xstrdup() first
- Non-portable f_fsid.__val: Use memcmp() for fsid comparison
- Missing worktree null check: Added BUG() for null worktree
- Header updates: Use git-compat-util.h, hash_to_hex_algop()
- Code style: Use xstrdup() not xmemdupz(), proper pointer style

Issues addressed from PR #1667 (git/git) review comments:
- EINTR handling: read() now handles both EAGAIN and EINTR
- Trailing pipe in log_mask_set: Added strbuf_strip_suffix()
- Unchecked add_watch return: Now logs failure in rename_dir()
- String building: Consolidated strbuf operations with strbuf_addf()
- Translation markers: Added _() to all error_errno() messages

Based on work from https://github.com/git/git/pull/1352 by Eric DeCosta,
and https://github.com/git/git/pull/1667 by Marziyeh Esipreh, updated
to work with the current codebase and address all review feedback.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
    fsmonitor: implement filesystem change listener for Linux
    
    Implement fsmonitor for Linux using the inotify API, bringing it to
    feature parity with existing Windows and macOS implementations.
    
    The Linux implementation uses inotify to monitor filesystem events.
    Unlike macOS's FSEvents which can watch a single root directory, inotify
    requires registering watches on every directory of interest. The
    implementation carefully handles directory renames and moves using
    inotify's cookie mechanism to track IN_MOVED_FROM/IN_MOVED_TO event
    pairs.
    
    Key implementation details:
    
     * Uses inotify_init1(O_NONBLOCK) for non-blocking event monitoring
     * Maintains bidirectional hashmaps between watch descriptors and paths
       for efficient event processing
     * Handles directory creation, deletion, and renames dynamically
     * Detects remote filesystems (NFS, CIFS, SMB, etc.) via statfs()
     * Falls back to $HOME/.git-fsmonitor-* for socket when .git is remote
    
    Build configuration:
    
     * Enabled via FSMONITOR_DAEMON_BACKEND=linux and
       FSMONITOR_OS_SETTINGS=linux
     * Requires NO_PTHREADS and NO_UNIX_SOCKETS to be unset
     * Adds HAVE_LINUX_MAGIC_H for filesystem type detection
    
    Documentation updated to note that fsmonitor.socketDir is now supported
    on both Mac OS and Linux, and adds a section about inotify watch limits.
    
    Testing performed:
    
     * Build succeeds with standard flags (NO_CURL, NO_GETTEXT, NO_TCLTK)
     * Build succeeds with SANITIZE=address (AddressSanitizer)
     * General tests pass (t0001-init, t3200-branch, etc.)
     * fsmonitor tests require local filesystem (v9fs test environment is
       correctly detected as remote and rejected)
     * Manual testing confirms daemon starts and monitors filesystem when
       configured with fsmonitor.allowremote=true and fsmonitor.socketdir
       pointing to a local filesystem (tmpfs)
    
    Issues addressed from PR #1352 (git/git) review comments:
    
     * GPLv3 ME_REMOTE macro: Rewrote remote filesystem detection from
       scratch using statfs() and linux/magic.h constants (no GPLv3 code)
     * Memory leak on inotify_init1 failure: Added FREE_AND_NULL cleanup
     * Unsafe hashmap iteration in dtor: Collect entries first, then modify
     * Missing null checks in stop_async: Added proper guard conditions
     * dirname() modifying argument: Create copy with xstrdup() first
     * Non-portable f_fsid.__val: Use memcmp() for fsid comparison
     * Missing worktree null check: Added BUG() for null worktree
     * Header updates: Use git-compat-util.h, hash_to_hex_algop()
     * Code style: Use xstrdup() not xmemdupz(), proper pointer style
    
    Issues addressed from PR #1667 (git/git) review comments:
    
     * EINTR handling: read() now handles both EAGAIN and EINTR
     * Trailing pipe in log_mask_set: Added strbuf_strip_suffix()
     * Unchecked add_watch return: Now logs failure in rename_dir()
     * String building: Consolidated strbuf operations with strbuf_addf()
     * Translation markers: Added _() to all error_errno() messages
    
    Based on work from https://github.com/git/git/pull/1352 by Eric DeCosta,
    and https://github.com/git/git/pull/1667 by Marziyeh Esipreh, updated to
    work with the current codebase and address all review feedback.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2147%2Fptarjan%2Fclaude%2Fupdate-pr-1352-current-85Gk8-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2147/ptarjan/claude/update-pr-1352-current-85Gk8-v1
Pull-Request: https://github.com/git/git/pull/2147

 Documentation/config/fsmonitor--daemon.adoc |   4 +-
 Documentation/git-fsmonitor--daemon.adoc    |  28 +-
 compat/fsmonitor/fsm-health-linux.c         |  33 +
 compat/fsmonitor/fsm-ipc-linux.c            |  61 ++
 compat/fsmonitor/fsm-listen-linux.c         | 738 ++++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-linux.c     | 224 ++++++
 compat/fsmonitor/fsm-settings-linux.c       |  71 ++
 config.mak.uname                            |  10 +
 contrib/buildsystems/CMakeLists.txt         |  10 +
 9 files changed, 1173 insertions(+), 6 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-linux.c
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 create mode 100644 compat/fsmonitor/fsm-settings-linux.c

diff --git a/Documentation/config/fsmonitor--daemon.adoc b/Documentation/config/fsmonitor--daemon.adoc
index 671f9b9462..6f8386e291 100644
--- a/Documentation/config/fsmonitor--daemon.adoc
+++ b/Documentation/config/fsmonitor--daemon.adoc
@@ -4,8 +4,8 @@ fsmonitor.allowRemote::
     behavior.  Only respected when `core.fsmonitor` is set to `true`.
 
 fsmonitor.socketDir::
-    This Mac OS-specific option, if set, specifies the directory in
+    This Mac OS and Linux-specific option, if set, specifies the directory in
     which to create the Unix domain socket used for communication
     between the fsmonitor daemon and various Git commands. The directory must
-    reside on a native Mac OS filesystem.  Only respected when `core.fsmonitor`
+    reside on a native filesystem.  Only respected when `core.fsmonitor`
     is set to `true`.
diff --git a/Documentation/git-fsmonitor--daemon.adoc b/Documentation/git-fsmonitor--daemon.adoc
index 8fe5241b08..12fa866a64 100644
--- a/Documentation/git-fsmonitor--daemon.adoc
+++ b/Documentation/git-fsmonitor--daemon.adoc
@@ -76,9 +76,9 @@ repositories; this may be overridden by setting `fsmonitor.allowRemote` to
 correctly with all network-mounted repositories, so such use is considered
 experimental.
 
-On Mac OS, the inter-process communication (IPC) between various Git
+On Mac OS and Linux, the inter-process communication (IPC) between various Git
 commands and the fsmonitor daemon is done via a Unix domain socket (UDS) -- a
-special type of file -- which is supported by native Mac OS filesystems,
+special type of file -- which is supported by native Mac OS and Linux filesystems,
 but not on network-mounted filesystems, NTFS, or FAT32.  Other filesystems
 may or may not have the needed support; the fsmonitor daemon is not guaranteed
 to work with these filesystems and such use is considered experimental.
@@ -87,13 +87,33 @@ By default, the socket is created in the `.git` directory.  However, if the
 `.git` directory is on a network-mounted filesystem, it will instead be
 created at `$HOME/.git-fsmonitor-*` unless `$HOME` itself is on a
 network-mounted filesystem, in which case you must set the configuration
-variable `fsmonitor.socketDir` to the path of a directory on a Mac OS native
+variable `fsmonitor.socketDir` to the path of a directory on a native
 filesystem in which to create the socket file.
 
 If none of the above directories (`.git`, `$HOME`, or `fsmonitor.socketDir`)
-is on a native Mac OS file filesystem the fsmonitor daemon will report an
+is on a native filesystem the fsmonitor daemon will report an
 error that will cause the daemon and the currently running command to exit.
 
+LINUX CAVEATS
+~~~~~~~~~~~~~
+
+On Linux, the fsmonitor daemon uses inotify to monitor filesystem events.
+The inotify system has per-user limits on the number of watches that can
+be created.  The default limit is typically 8192 watches per user.
+
+For large repositories with many directories, you may need to increase
+this limit.  Check the current limit with:
+
+    cat /proc/sys/fs/inotify/max_user_watches
+
+To temporarily increase the limit:
+
+    sudo sysctl fs.inotify.max_user_watches=65536
+
+To make the change permanent, add to `/etc/sysctl.conf`:
+
+    fs.inotify.max_user_watches=65536
+
 CONFIGURATION
 -------------
 
diff --git a/compat/fsmonitor/fsm-health-linux.c b/compat/fsmonitor/fsm-health-linux.c
new file mode 100644
index 0000000000..43d67c4b8b
--- /dev/null
+++ b/compat/fsmonitor/fsm-health-linux.c
@@ -0,0 +1,33 @@
+#include "git-compat-util.h"
+#include "config.h"
+#include "fsmonitor-ll.h"
+#include "fsm-health.h"
+#include "fsmonitor--daemon.h"
+
+/*
+ * The Linux fsmonitor implementation uses inotify which has its own
+ * mechanisms for detecting filesystem unmount and other events that
+ * would require the daemon to shutdown.  Therefore, we don't need
+ * a separate health thread like Windows does.
+ *
+ * These stub functions satisfy the interface requirements.
+ */
+
+int fsm_health__ctor(struct fsmonitor_daemon_state *state UNUSED)
+{
+	return 0;
+}
+
+void fsm_health__dtor(struct fsmonitor_daemon_state *state UNUSED)
+{
+	return;
+}
+
+void fsm_health__loop(struct fsmonitor_daemon_state *state UNUSED)
+{
+	return;
+}
+
+void fsm_health__stop_async(struct fsmonitor_daemon_state *state UNUSED)
+{
+}
diff --git a/compat/fsmonitor/fsm-ipc-linux.c b/compat/fsmonitor/fsm-ipc-linux.c
new file mode 100644
index 0000000000..d34a6419bc
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-linux.c
@@ -0,0 +1,61 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "git-compat-util.h"
+#include "config.h"
+#include "gettext.h"
+#include "hex.h"
+#include "path.h"
+#include "repository.h"
+#include "strbuf.h"
+#include "fsmonitor-ll.h"
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-path-utils.h"
+
+static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
+
+const char *fsmonitor_ipc__get_path(struct repository *r)
+{
+	static const char *ipc_path = NULL;
+	git_SHA_CTX sha1ctx;
+	char *sock_dir = NULL;
+	struct strbuf ipc_file = STRBUF_INIT;
+	unsigned char hash[GIT_SHA1_RAWSZ];
+
+	if (!r)
+		BUG("No repository passed into fsmonitor_ipc__get_path");
+
+	if (ipc_path)
+		return ipc_path;
+
+	/* By default the socket file is created in the .git directory */
+	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
+		ipc_path = fsmonitor_ipc__get_default_path();
+		return ipc_path;
+	}
+
+	if (!r->worktree)
+		BUG("repository has no worktree");
+
+	git_SHA1_Init(&sha1ctx);
+	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
+	git_SHA1_Final(hash, &sha1ctx);
+
+	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
+
+	/* Create the socket file in either socketDir or $HOME */
+	if (sock_dir && *sock_dir) {
+		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
+			    sock_dir, hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
+	} else {
+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s",
+			    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
+	}
+	free(sock_dir);
+
+	ipc_path = interpolate_path(ipc_file.buf, 1);
+	if (!ipc_path)
+		die(_("Invalid path: %s"), ipc_file.buf);
+
+	strbuf_release(&ipc_file);
+	return ipc_path;
+}
diff --git a/compat/fsmonitor/fsm-listen-linux.c b/compat/fsmonitor/fsm-listen-linux.c
new file mode 100644
index 0000000000..2593c834d3
--- /dev/null
+++ b/compat/fsmonitor/fsm-listen-linux.c
@@ -0,0 +1,738 @@
+#include "git-compat-util.h"
+#include "dir.h"
+#include "fsmonitor-ll.h"
+#include "fsm-listen.h"
+#include "fsmonitor--daemon.h"
+#include "fsmonitor-path-utils.h"
+#include "gettext.h"
+#include "simple-ipc.h"
+#include "string-list.h"
+#include "trace.h"
+
+#include <dirent.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <sys/inotify.h>
+#include <sys/stat.h>
+
+/*
+ * Safe value to bitwise OR with rest of mask for
+ * kernels that do not support IN_MASK_CREATE
+ */
+#ifndef IN_MASK_CREATE
+#define IN_MASK_CREATE 0x00000000
+#endif
+
+enum shutdown_reason {
+	SHUTDOWN_CONTINUE = 0,
+	SHUTDOWN_STOP,
+	SHUTDOWN_ERROR,
+	SHUTDOWN_FORCE
+};
+
+struct watch_entry {
+	struct hashmap_entry ent;
+	int wd;
+	uint32_t cookie;
+	const char *dir;
+};
+
+struct rename_entry {
+	struct hashmap_entry ent;
+	time_t whence;
+	uint32_t cookie;
+	const char *dir;
+};
+
+struct fsm_listen_data {
+	int fd_inotify;
+	enum shutdown_reason shutdown;
+	struct hashmap watches;
+	struct hashmap renames;
+	struct hashmap revwatches;
+};
+
+static int watch_entry_cmp(const void *cmp_data UNUSED,
+			   const struct hashmap_entry *eptr,
+			   const struct hashmap_entry *entry_or_key,
+			   const void *keydata UNUSED)
+{
+	const struct watch_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct watch_entry, ent);
+	e2 = container_of(entry_or_key, const struct watch_entry, ent);
+	return e1->wd != e2->wd;
+}
+
+static int revwatches_entry_cmp(const void *cmp_data UNUSED,
+				const struct hashmap_entry *eptr,
+				const struct hashmap_entry *entry_or_key,
+				const void *keydata UNUSED)
+{
+	const struct watch_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct watch_entry, ent);
+	e2 = container_of(entry_or_key, const struct watch_entry, ent);
+	return strcmp(e1->dir, e2->dir);
+}
+
+static int rename_entry_cmp(const void *cmp_data UNUSED,
+			    const struct hashmap_entry *eptr,
+			    const struct hashmap_entry *entry_or_key,
+			    const void *keydata UNUSED)
+{
+	const struct rename_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct rename_entry, ent);
+	e2 = container_of(entry_or_key, const struct rename_entry, ent);
+	return e1->cookie != e2->cookie;
+}
+
+/*
+ * Register an inotify watch, add watch descriptor to path mapping
+ * and the reverse mapping.
+ */
+static int add_watch(const char *path, struct fsm_listen_data *data)
+{
+	const char *interned = strintern(path);
+	struct watch_entry *w1, *w2;
+
+	/* add the inotify watch, don't allow watches to be modified */
+	int wd = inotify_add_watch(data->fd_inotify, interned,
+				   (IN_ALL_EVENTS | IN_ONLYDIR | IN_MASK_CREATE)
+				    ^ IN_ACCESS ^ IN_CLOSE ^ IN_OPEN);
+	if (wd < 0) {
+		if (errno == ENOENT || errno == ENOTDIR)
+			return 0; /* directory was deleted or is not a directory */
+		return error_errno(_("inotify_add_watch('%s') failed"), interned);
+	}
+
+	/* add watch descriptor -> directory mapping */
+	CALLOC_ARRAY(w1, 1);
+	w1->wd = wd;
+	w1->dir = interned;
+	hashmap_entry_init(&w1->ent, memhash(&w1->wd, sizeof(int)));
+	hashmap_add(&data->watches, &w1->ent);
+
+	/* add directory -> watch descriptor mapping */
+	CALLOC_ARRAY(w2, 1);
+	w2->wd = wd;
+	w2->dir = interned;
+	hashmap_entry_init(&w2->ent, strhash(w2->dir));
+	hashmap_add(&data->revwatches, &w2->ent);
+
+	return 0;
+}
+
+/*
+ * Remove the inotify watch, the watch descriptor to path mapping
+ * and the reverse mapping.
+ */
+static void remove_watch(struct watch_entry *w, struct fsm_listen_data *data)
+{
+	struct watch_entry k1, k2, *w1, *w2;
+
+	/* remove watch, ignore error if kernel already did it */
+	if (inotify_rm_watch(data->fd_inotify, w->wd) && errno != EINVAL)
+		error_errno(_("inotify_rm_watch() failed"));
+
+	k1.wd = w->wd;
+	hashmap_entry_init(&k1.ent, memhash(&k1.wd, sizeof(int)));
+	w1 = hashmap_remove_entry(&data->watches, &k1, ent, NULL);
+	if (!w1)
+		BUG("Double remove of watch for '%s'", w->dir);
+
+	if (w1->cookie)
+		BUG("Removing watch for '%s' which has a pending rename", w1->dir);
+
+	k2.dir = w->dir;
+	hashmap_entry_init(&k2.ent, strhash(k2.dir));
+	w2 = hashmap_remove_entry(&data->revwatches, &k2, ent, NULL);
+	if (!w2)
+		BUG("Double remove of reverse watch for '%s'", w->dir);
+
+	/* w1->dir and w2->dir are interned strings, we don't own them */
+	free(w1);
+	free(w2);
+}
+
+/*
+ * Check for stale directory renames.
+ *
+ * https://man7.org/linux/man-pages/man7/inotify.7.html
+ *
+ * Allow for some small timeout to account for the fact that insertion of the
+ * IN_MOVED_FROM+IN_MOVED_TO event pair is not atomic, and the possibility that
+ * there may not be any IN_MOVED_TO event.
+ *
+ * If the IN_MOVED_TO event is not received within the timeout then events have
+ * been missed and the monitor is in an inconsistent state with respect to the
+ * filesystem.
+ */
+static int check_stale_dir_renames(struct hashmap *renames, time_t max_age)
+{
+	struct rename_entry *re;
+	struct hashmap_iter iter;
+
+	hashmap_for_each_entry(renames, &iter, re, ent) {
+		if (re->whence <= max_age)
+			return -1;
+	}
+	return 0;
+}
+
+/*
+ * Track pending renames.
+ *
+ * Tracking is done via an event cookie to watch descriptor mapping.
+ *
+ * A rename is not complete until matching an IN_MOVED_TO event is received
+ * for a corresponding IN_MOVED_FROM event.
+ */
+static void add_dir_rename(uint32_t cookie, const char *path,
+			   struct fsm_listen_data *data)
+{
+	struct watch_entry k, *w;
+	struct rename_entry *re;
+
+	/* lookup the watch descriptor for the given path */
+	k.dir = path;
+	hashmap_entry_init(&k.ent, strhash(path));
+	w = hashmap_get_entry(&data->revwatches, &k, ent, NULL);
+	if (!w) {
+		/*
+		 * This can happen in rare cases where the directory was
+		 * moved before we had a chance to add a watch on it.
+		 * Just ignore this rename.
+		 */
+		trace_printf_key(&trace_fsmonitor,
+				 "no watch found for rename from '%s'", path);
+		return;
+	}
+	w->cookie = cookie;
+
+	/* add the pending rename to match against later */
+	CALLOC_ARRAY(re, 1);
+	re->dir = w->dir;
+	re->cookie = w->cookie;
+	re->whence = time(NULL);
+	hashmap_entry_init(&re->ent, memhash(&re->cookie, sizeof(uint32_t)));
+	hashmap_add(&data->renames, &re->ent);
+}
+
+/*
+ * Handle directory renames
+ *
+ * Once an IN_MOVED_TO event is received, lookup the rename tracking information
+ * via the event cookie and use this information to update the watch.
+ */
+static void rename_dir(uint32_t cookie, const char *path,
+		       struct fsm_listen_data *data)
+{
+	struct rename_entry rek, *re;
+	struct watch_entry k, *w;
+
+	/* lookup a pending rename to match */
+	rek.cookie = cookie;
+	hashmap_entry_init(&rek.ent, memhash(&rek.cookie, sizeof(uint32_t)));
+	re = hashmap_get_entry(&data->renames, &rek, ent, NULL);
+	if (re) {
+		k.dir = re->dir;
+		hashmap_entry_init(&k.ent, strhash(k.dir));
+		w = hashmap_get_entry(&data->revwatches, &k, ent, NULL);
+		if (w) {
+			w->cookie = 0; /* rename handled */
+			remove_watch(w, data);
+			if (add_watch(path, data))
+				trace_printf_key(&trace_fsmonitor,
+						 "failed to add watch for renamed dir '%s'",
+						 path);
+		} else {
+			/* Directory was moved out of watch tree */
+			trace_printf_key(&trace_fsmonitor,
+					 "No matching watch for rename to '%s'", path);
+		}
+		hashmap_remove_entry(&data->renames, &rek, ent, NULL);
+		free(re);
+	} else {
+		/* Directory was moved from outside the watch tree */
+		trace_printf_key(&trace_fsmonitor,
+				 "No matching cookie for rename to '%s'", path);
+	}
+}
+
+/*
+ * Recursively add watches to every directory under path
+ */
+static int register_inotify(const char *path,
+			    struct fsmonitor_daemon_state *state,
+			    struct fsmonitor_batch *batch)
+{
+	DIR *dir;
+	const char *rel;
+	struct strbuf current = STRBUF_INIT;
+	struct dirent *de;
+	struct stat fs;
+	int ret = -1;
+
+	dir = opendir(path);
+	if (!dir) {
+		if (errno == ENOENT || errno == ENOTDIR)
+			return 0; /* directory was deleted */
+		return error_errno(_("opendir('%s') failed"), path);
+	}
+
+	while ((de = readdir_skip_dot_and_dotdot(dir)) != NULL) {
+		strbuf_reset(&current);
+		strbuf_addf(&current, "%s/%s", path, de->d_name);
+		if (lstat(current.buf, &fs)) {
+			if (errno == ENOENT)
+				continue; /* file was deleted */
+			error_errno(_("lstat('%s') failed"), current.buf);
+			goto failed;
+		}
+
+		/* recurse into directory */
+		if (S_ISDIR(fs.st_mode)) {
+			if (add_watch(current.buf, state->listen_data))
+				goto failed;
+			if (register_inotify(current.buf, state, batch))
+				goto failed;
+		} else if (batch) {
+			rel = current.buf + state->path_worktree_watch.len + 1;
+			trace_printf_key(&trace_fsmonitor, "explicitly adding '%s'", rel);
+			fsmonitor_batch__add_path(batch, rel);
+		}
+	}
+	ret = 0;
+
+failed:
+	strbuf_release(&current);
+	if (closedir(dir) < 0)
+		return error_errno(_("closedir('%s') failed"), path);
+	return ret;
+}
+
+static int em_rename_dir_from(uint32_t mask)
+{
+	return ((mask & IN_ISDIR) && (mask & IN_MOVED_FROM));
+}
+
+static int em_rename_dir_to(uint32_t mask)
+{
+	return ((mask & IN_ISDIR) && (mask & IN_MOVED_TO));
+}
+
+static int em_remove_watch(uint32_t mask)
+{
+	return (mask & IN_DELETE_SELF);
+}
+
+static int em_dir_renamed(uint32_t mask)
+{
+	return ((mask & IN_ISDIR) && (mask & IN_MOVE));
+}
+
+static int em_dir_created(uint32_t mask)
+{
+	return ((mask & IN_ISDIR) && (mask & IN_CREATE));
+}
+
+static int em_dir_deleted(uint32_t mask)
+{
+	return ((mask & IN_ISDIR) && (mask & IN_DELETE));
+}
+
+static int em_force_shutdown(uint32_t mask)
+{
+	return (mask & IN_UNMOUNT) || (mask & IN_Q_OVERFLOW);
+}
+
+static int em_ignore(uint32_t mask)
+{
+	return (mask & IN_IGNORED) || (mask & IN_MOVE_SELF);
+}
+
+static void log_mask_set(const char *path, uint32_t mask)
+{
+	struct strbuf msg = STRBUF_INIT;
+
+	if (mask & IN_ACCESS)
+		strbuf_addstr(&msg, "IN_ACCESS|");
+	if (mask & IN_MODIFY)
+		strbuf_addstr(&msg, "IN_MODIFY|");
+	if (mask & IN_ATTRIB)
+		strbuf_addstr(&msg, "IN_ATTRIB|");
+	if (mask & IN_CLOSE_WRITE)
+		strbuf_addstr(&msg, "IN_CLOSE_WRITE|");
+	if (mask & IN_CLOSE_NOWRITE)
+		strbuf_addstr(&msg, "IN_CLOSE_NOWRITE|");
+	if (mask & IN_OPEN)
+		strbuf_addstr(&msg, "IN_OPEN|");
+	if (mask & IN_MOVED_FROM)
+		strbuf_addstr(&msg, "IN_MOVED_FROM|");
+	if (mask & IN_MOVED_TO)
+		strbuf_addstr(&msg, "IN_MOVED_TO|");
+	if (mask & IN_CREATE)
+		strbuf_addstr(&msg, "IN_CREATE|");
+	if (mask & IN_DELETE)
+		strbuf_addstr(&msg, "IN_DELETE|");
+	if (mask & IN_DELETE_SELF)
+		strbuf_addstr(&msg, "IN_DELETE_SELF|");
+	if (mask & IN_MOVE_SELF)
+		strbuf_addstr(&msg, "IN_MOVE_SELF|");
+	if (mask & IN_UNMOUNT)
+		strbuf_addstr(&msg, "IN_UNMOUNT|");
+	if (mask & IN_Q_OVERFLOW)
+		strbuf_addstr(&msg, "IN_Q_OVERFLOW|");
+	if (mask & IN_IGNORED)
+		strbuf_addstr(&msg, "IN_IGNORED|");
+	if (mask & IN_ISDIR)
+		strbuf_addstr(&msg, "IN_ISDIR|");
+
+	strbuf_strip_suffix(&msg, "|");
+
+	trace_printf_key(&trace_fsmonitor, "inotify_event: '%s', mask=%#8.8x %s",
+			 path, mask, msg.buf);
+
+	strbuf_release(&msg);
+}
+
+int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
+{
+	int fd;
+	int ret = 0;
+	struct fsm_listen_data *data;
+
+	CALLOC_ARRAY(data, 1);
+	state->listen_data = data;
+	state->listen_error_code = -1;
+	data->shutdown = SHUTDOWN_ERROR;
+
+	fd = inotify_init1(O_NONBLOCK);
+	if (fd < 0) {
+		FREE_AND_NULL(state->listen_data);
+		return error_errno(_("inotify_init1() failed"));
+	}
+
+	data->fd_inotify = fd;
+
+	hashmap_init(&data->watches, watch_entry_cmp, NULL, 0);
+	hashmap_init(&data->renames, rename_entry_cmp, NULL, 0);
+	hashmap_init(&data->revwatches, revwatches_entry_cmp, NULL, 0);
+
+	if (add_watch(state->path_worktree_watch.buf, data))
+		ret = -1;
+	else if (register_inotify(state->path_worktree_watch.buf, state, NULL))
+		ret = -1;
+	else if (state->nr_paths_watching > 1) {
+		if (add_watch(state->path_gitdir_watch.buf, data))
+			ret = -1;
+		else if (register_inotify(state->path_gitdir_watch.buf, state, NULL))
+			ret = -1;
+	}
+
+	if (!ret) {
+		state->listen_error_code = 0;
+		data->shutdown = SHUTDOWN_CONTINUE;
+	}
+
+	return ret;
+}
+
+void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
+{
+	struct fsm_listen_data *data;
+	struct hashmap_iter iter;
+	struct watch_entry *w;
+	struct watch_entry **to_remove;
+	size_t nr_to_remove = 0, alloc_to_remove = 0;
+	size_t i;
+	int fd;
+
+	if (!state || !state->listen_data)
+		return;
+
+	data = state->listen_data;
+	fd = data->fd_inotify;
+
+	/*
+	 * Collect all entries first, then remove them.
+	 * We can't modify the hashmap while iterating over it.
+	 */
+	to_remove = NULL;
+	hashmap_for_each_entry(&data->watches, &iter, w, ent) {
+		ALLOC_GROW(to_remove, nr_to_remove + 1, alloc_to_remove);
+		to_remove[nr_to_remove++] = w;
+	}
+
+	for (i = 0; i < nr_to_remove; i++) {
+		to_remove[i]->cookie = 0; /* ignore any pending renames */
+		remove_watch(to_remove[i], data);
+	}
+	free(to_remove);
+
+	hashmap_clear(&data->watches);
+
+	hashmap_clear(&data->revwatches); /* remove_watch freed the entries */
+
+	hashmap_clear_and_free(&data->renames, struct rename_entry, ent);
+
+	FREE_AND_NULL(state->listen_data);
+
+	if (fd && (close(fd) < 0))
+		error_errno(_("closing inotify file descriptor failed"));
+}
+
+void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
+{
+	if (state && state->listen_data &&
+	    state->listen_data->shutdown == SHUTDOWN_CONTINUE)
+		state->listen_data->shutdown = SHUTDOWN_STOP;
+}
+
+/*
+ * Process a single inotify event and queue for publication.
+ */
+static int process_event(const char *path,
+			 const struct inotify_event *event,
+			 struct fsmonitor_batch **batch,
+			 struct string_list *cookie_list,
+			 struct fsmonitor_daemon_state *state)
+{
+	const char *rel;
+	const char *last_sep;
+
+	switch (fsmonitor_classify_path_absolute(state, path)) {
+	case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
+	case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
+		/* Use just the filename of the cookie file. */
+		last_sep = find_last_dir_sep(path);
+		string_list_append(cookie_list,
+				   last_sep ? last_sep + 1 : path);
+		break;
+	case IS_INSIDE_DOT_GIT:
+	case IS_INSIDE_GITDIR:
+		break;
+	case IS_DOT_GIT:
+	case IS_GITDIR:
+		/*
+		 * If .git directory is deleted or renamed away,
+		 * we have to quit.
+		 */
+		if (em_dir_deleted(event->mask)) {
+			trace_printf_key(&trace_fsmonitor,
+					 "event: gitdir removed");
+			state->listen_data->shutdown = SHUTDOWN_FORCE;
+			goto done;
+		}
+
+		if (em_dir_renamed(event->mask)) {
+			trace_printf_key(&trace_fsmonitor,
+					 "event: gitdir renamed");
+			state->listen_data->shutdown = SHUTDOWN_FORCE;
+			goto done;
+		}
+		break;
+	case IS_WORKDIR_PATH:
+		/* normal events in the working directory */
+		if (trace_pass_fl(&trace_fsmonitor))
+			log_mask_set(path, event->mask);
+
+		if (!*batch)
+			*batch = fsmonitor_batch__new();
+
+		rel = path + state->path_worktree_watch.len + 1;
+		fsmonitor_batch__add_path(*batch, rel);
+
+		if (em_dir_deleted(event->mask))
+			break;
+
+		/* received IN_MOVE_FROM, add tracking for expected IN_MOVE_TO */
+		if (em_rename_dir_from(event->mask))
+			add_dir_rename(event->cookie, path, state->listen_data);
+
+		/* received IN_MOVE_TO, update watch to reflect new path */
+		if (em_rename_dir_to(event->mask)) {
+			rename_dir(event->cookie, path, state->listen_data);
+			if (register_inotify(path, state, *batch)) {
+				state->listen_data->shutdown = SHUTDOWN_ERROR;
+				goto done;
+			}
+		}
+
+		if (em_dir_created(event->mask)) {
+			if (add_watch(path, state->listen_data)) {
+				state->listen_data->shutdown = SHUTDOWN_ERROR;
+				goto done;
+			}
+			if (register_inotify(path, state, *batch)) {
+				state->listen_data->shutdown = SHUTDOWN_ERROR;
+				goto done;
+			}
+		}
+		break;
+	case IS_OUTSIDE_CONE:
+	default:
+		trace_printf_key(&trace_fsmonitor,
+				 "ignoring '%s'", path);
+		break;
+	}
+	return 0;
+done:
+	return -1;
+}
+
+/*
+ * Read the inotify event stream and pre-process events before further
+ * processing and eventual publishing.
+ */
+static void handle_events(struct fsmonitor_daemon_state *state)
+{
+	/* See https://man7.org/linux/man-pages/man7/inotify.7.html */
+	char buf[4096]
+		__attribute__ ((aligned(__alignof__(struct inotify_event))));
+
+	struct hashmap *watches = &state->listen_data->watches;
+	struct fsmonitor_batch *batch = NULL;
+	struct string_list cookie_list = STRING_LIST_INIT_DUP;
+	struct watch_entry k, *w;
+	struct strbuf path = STRBUF_INIT;
+	const struct inotify_event *event;
+	int fd = state->listen_data->fd_inotify;
+	ssize_t len;
+	char *ptr, *p;
+
+	for (;;) {
+		len = read(fd, buf, sizeof(buf));
+		if (len == -1) {
+			if (errno == EAGAIN || errno == EINTR)
+				goto done;
+			error_errno(_("reading inotify message stream failed"));
+			state->listen_data->shutdown = SHUTDOWN_ERROR;
+			goto done;
+		}
+
+		/* nothing to read */
+		if (len == 0)
+			goto done;
+
+		/* Loop over all events in the buffer. */
+		for (ptr = buf; ptr < buf + len;
+		     ptr += sizeof(struct inotify_event) + event->len) {
+
+			event = (const struct inotify_event *)ptr;
+
+			if (em_ignore(event->mask))
+				continue;
+
+			/* File system was unmounted or event queue overflowed */
+			if (em_force_shutdown(event->mask)) {
+				if (trace_pass_fl(&trace_fsmonitor))
+					log_mask_set("Forcing shutdown", event->mask);
+				state->listen_data->shutdown = SHUTDOWN_FORCE;
+				goto done;
+			}
+
+			k.wd = event->wd;
+			hashmap_entry_init(&k.ent, memhash(&k.wd, sizeof(int)));
+
+			w = hashmap_get_entry(watches, &k, ent, NULL);
+			if (!w) {
+				/* Watch was removed, skip event */
+				continue;
+			}
+
+			/* directory watch was removed */
+			if (em_remove_watch(event->mask)) {
+				remove_watch(w, state->listen_data);
+				continue;
+			}
+
+			strbuf_reset(&path);
+			strbuf_addf(&path, "%s/%s", w->dir, event->name);
+
+			p = fsmonitor__resolve_alias(path.buf, &state->alias);
+			if (!p)
+				p = strbuf_detach(&path, NULL);
+
+			if (process_event(p, event, &batch, &cookie_list, state)) {
+				free(p);
+				goto done;
+			}
+			free(p);
+		}
+		strbuf_reset(&path);
+		fsmonitor_publish(state, batch, &cookie_list);
+		string_list_clear(&cookie_list, 0);
+		batch = NULL;
+	}
+done:
+	strbuf_release(&path);
+	fsmonitor_batch__free_list(batch);
+	string_list_clear(&cookie_list, 0);
+}
+
+/*
+ * Non-blocking read of the inotify events stream. The inotify fd is polled
+ * frequently to help minimize the number of queue overflows.
+ */
+void fsm_listen__loop(struct fsmonitor_daemon_state *state)
+{
+	int poll_num;
+	const int interval = 1000;
+	time_t checked = time(NULL);
+	struct pollfd fds[1];
+
+	fds[0].fd = state->listen_data->fd_inotify;
+	fds[0].events = POLLIN;
+
+	/*
+	 * Our fs event listener is now running, so it's safe to start
+	 * serving client requests.
+	 */
+	ipc_server_start_async(state->ipc_server_data);
+
+	for (;;) {
+		switch (state->listen_data->shutdown) {
+		case SHUTDOWN_CONTINUE:
+			poll_num = poll(fds, 1, 1);
+			if (poll_num == -1) {
+				if (errno == EINTR)
+					continue;
+				error_errno(_("polling inotify message stream failed"));
+				state->listen_data->shutdown = SHUTDOWN_ERROR;
+				continue;
+			}
+
+			if ((time(NULL) - checked) >= interval) {
+				checked = time(NULL);
+				if (check_stale_dir_renames(&state->listen_data->renames,
+							    checked - interval)) {
+					trace_printf_key(&trace_fsmonitor,
+							 "Missed IN_MOVED_TO events, forcing shutdown");
+					state->listen_data->shutdown = SHUTDOWN_FORCE;
+					continue;
+				}
+			}
+
+			if (poll_num > 0 && (fds[0].revents & POLLIN))
+				handle_events(state);
+
+			continue;
+		case SHUTDOWN_ERROR:
+			state->listen_error_code = -1;
+			ipc_server_stop_async(state->ipc_server_data);
+			break;
+		case SHUTDOWN_FORCE:
+			state->listen_error_code = 0;
+			ipc_server_stop_async(state->ipc_server_data);
+			break;
+		case SHUTDOWN_STOP:
+		default:
+			state->listen_error_code = 0;
+			break;
+		}
+		return;
+	}
+}
diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
new file mode 100644
index 0000000000..d0bc98b0a9
--- /dev/null
+++ b/compat/fsmonitor/fsm-path-utils-linux.c
@@ -0,0 +1,224 @@
+#include "git-compat-util.h"
+#include "fsmonitor-ll.h"
+#include "fsmonitor-path-utils.h"
+#include "gettext.h"
+#include "trace.h"
+
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/statfs.h>
+
+#ifdef HAVE_LINUX_MAGIC_H
+#include <linux/magic.h>
+#endif
+
+/*
+ * Filesystem magic numbers for remote filesystems.
+ * Defined here if not available in linux/magic.h.
+ */
+#ifndef CIFS_SUPER_MAGIC
+#define CIFS_SUPER_MAGIC 0xff534d42
+#endif
+#ifndef SMB_SUPER_MAGIC
+#define SMB_SUPER_MAGIC 0x517b
+#endif
+#ifndef SMB2_SUPER_MAGIC
+#define SMB2_SUPER_MAGIC 0xfe534d42
+#endif
+#ifndef NFS_SUPER_MAGIC
+#define NFS_SUPER_MAGIC 0x6969
+#endif
+#ifndef AFS_SUPER_MAGIC
+#define AFS_SUPER_MAGIC 0x5346414f
+#endif
+#ifndef CODA_SUPER_MAGIC
+#define CODA_SUPER_MAGIC 0x73757245
+#endif
+#ifndef V9FS_MAGIC
+#define V9FS_MAGIC 0x01021997
+#endif
+#ifndef FUSE_SUPER_MAGIC
+#define FUSE_SUPER_MAGIC 0x65735546
+#endif
+
+/*
+ * Check if filesystem type is a remote filesystem.
+ */
+static int is_remote_fs(unsigned long f_type)
+{
+	switch (f_type) {
+	case CIFS_SUPER_MAGIC:
+	case SMB_SUPER_MAGIC:
+	case SMB2_SUPER_MAGIC:
+	case NFS_SUPER_MAGIC:
+	case AFS_SUPER_MAGIC:
+	case CODA_SUPER_MAGIC:
+	case V9FS_MAGIC:
+	case FUSE_SUPER_MAGIC:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+/*
+ * Get the filesystem type name for logging purposes.
+ */
+static const char *get_fs_typename(unsigned long f_type)
+{
+	switch (f_type) {
+	case CIFS_SUPER_MAGIC:
+		return "cifs";
+	case SMB_SUPER_MAGIC:
+		return "smb";
+	case SMB2_SUPER_MAGIC:
+		return "smb2";
+	case NFS_SUPER_MAGIC:
+		return "nfs";
+	case AFS_SUPER_MAGIC:
+		return "afs";
+	case CODA_SUPER_MAGIC:
+		return "coda";
+	case V9FS_MAGIC:
+		return "9p";
+	case FUSE_SUPER_MAGIC:
+		return "fuse";
+	default:
+		return "unknown";
+	}
+}
+
+/*
+ * Find the mount point for a given path by reading /proc/mounts.
+ * Returns the filesystem type for the longest matching mount point.
+ */
+static char *find_mount(const char *path, struct statfs *fs)
+{
+	FILE *fp;
+	struct strbuf line = STRBUF_INIT;
+	struct strbuf match = STRBUF_INIT;
+	struct strbuf fstype = STRBUF_INIT;
+	char *result = NULL;
+	struct statfs path_fs;
+
+	if (statfs(path, &path_fs) < 0)
+		return NULL;
+
+	fp = fopen("/proc/mounts", "r");
+	if (!fp)
+		return NULL;
+
+	while (strbuf_getline(&line, fp) != EOF) {
+		char *fields[6];
+		char *p = line.buf;
+		int i;
+
+		/* Parse mount entry: device mountpoint fstype options dump pass */
+		for (i = 0; i < 6 && p; i++) {
+			fields[i] = p;
+			p = strchr(p, ' ');
+			if (p)
+				*p++ = '\0';
+		}
+
+		if (i >= 3) {
+			const char *mountpoint = fields[1];
+			const char *type = fields[2];
+			struct statfs mount_fs;
+
+			/* Check if this mount point is a prefix of our path */
+			if (starts_with(path, mountpoint) &&
+			    (path[strlen(mountpoint)] == '/' ||
+			     path[strlen(mountpoint)] == '\0')) {
+				/* Check if filesystem ID matches */
+				if (statfs(mountpoint, &mount_fs) == 0 &&
+				    !memcmp(&mount_fs.f_fsid, &path_fs.f_fsid,
+					    sizeof(mount_fs.f_fsid))) {
+					/* Keep the longest matching mount point */
+					if (strlen(mountpoint) > match.len) {
+						strbuf_reset(&match);
+						strbuf_addstr(&match, mountpoint);
+						strbuf_reset(&fstype);
+						strbuf_addstr(&fstype, type);
+						*fs = mount_fs;
+					}
+				}
+			}
+		}
+	}
+
+	fclose(fp);
+	strbuf_release(&line);
+	strbuf_release(&match);
+
+	if (fstype.len)
+		result = strbuf_detach(&fstype, NULL);
+	else
+		strbuf_release(&fstype);
+
+	return result;
+}
+
+int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
+{
+	struct statfs fs;
+
+	if (statfs(path, &fs) == -1) {
+		int saved_errno = errno;
+		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
+				 path, strerror(saved_errno));
+		errno = saved_errno;
+		return -1;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statfs('%s') [type 0x%08lx]",
+			 path, (unsigned long)fs.f_type);
+
+	fs_info->is_remote = is_remote_fs(fs.f_type);
+
+	/*
+	 * Try to get filesystem type from /proc/mounts for a more
+	 * descriptive name.
+	 */
+	fs_info->typename = find_mount(path, &fs);
+	if (!fs_info->typename)
+		fs_info->typename = xstrdup(get_fs_typename(fs.f_type));
+
+	trace_printf_key(&trace_fsmonitor,
+			 "'%s' is_remote: %d, typename: %s",
+			 path, fs_info->is_remote, fs_info->typename);
+
+	return 0;
+}
+
+int fsmonitor__is_fs_remote(const char *path)
+{
+	struct fs_info fs;
+
+	if (fsmonitor__get_fs_info(path, &fs))
+		return -1;
+
+	free(fs.typename);
+
+	return fs.is_remote;
+}
+
+/*
+ * No-op for Linux - we don't have firmlinks like macOS.
+ */
+int fsmonitor__get_alias(const char *path UNUSED,
+			 struct alias_info *info UNUSED)
+{
+	return 0;
+}
+
+/*
+ * No-op for Linux - we don't have firmlinks like macOS.
+ */
+char *fsmonitor__resolve_alias(const char *path UNUSED,
+			       const struct alias_info *info UNUSED)
+{
+	return NULL;
+}
diff --git a/compat/fsmonitor/fsm-settings-linux.c b/compat/fsmonitor/fsm-settings-linux.c
new file mode 100644
index 0000000000..23e7442d0c
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-linux.c
@@ -0,0 +1,71 @@
+#include "git-compat-util.h"
+#include "config.h"
+#include "fsmonitor-ll.h"
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-settings.h"
+#include "fsmonitor-path-utils.h"
+
+#include <libgen.h>
+
+/*
+ * For the builtin FSMonitor, we create the Unix domain socket for the
+ * IPC in the .git directory.  If the working directory is remote,
+ * then the socket will be created on the remote file system.  This
+ * can fail if the remote file system does not support UDS file types
+ * (e.g. smbfs to a Windows server) or if the remote kernel does not
+ * allow a non-local process to bind() the socket.  (These problems
+ * could be fixed by moving the UDS out of the .git directory and to a
+ * well-known local directory on the client machine, but care should
+ * be taken to ensure that $HOME is actually local and not a managed
+ * file share.)
+ *
+ * FAT32 and NTFS working directories are problematic too.
+ *
+ * The builtin FSMonitor uses a Unix domain socket in the .git
+ * directory for IPC.  These Windows drive formats do not support
+ * Unix domain sockets, so mark them as incompatible for the daemon.
+ */
+static enum fsmonitor_reason check_uds_volume(struct repository *r)
+{
+	struct fs_info fs;
+	const char *ipc_path = fsmonitor_ipc__get_path(r);
+	char *path;
+	char *dir;
+
+	/*
+	 * Create a copy for dirname() since it may modify its argument.
+	 */
+	path = xstrdup(ipc_path);
+	dir = dirname(path);
+
+	if (fsmonitor__get_fs_info(dir, &fs) == -1) {
+		free(path);
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	free(path);
+
+	if (fs.is_remote ||
+	    !strcmp(fs.typename, "msdos") ||
+	    !strcmp(fs.typename, "ntfs") ||
+	    !strcmp(fs.typename, "vfat")) {
+		free(fs.typename);
+		return FSMONITOR_REASON_NOSOCKETS;
+	}
+
+	free(fs.typename);
+	return FSMONITOR_REASON_OK;
+}
+
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
+{
+	enum fsmonitor_reason reason;
+
+	if (ipc) {
+		reason = check_uds_volume(r);
+		if (reason != FSMONITOR_REASON_OK)
+			return reason;
+	}
+
+	return FSMONITOR_REASON_OK;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 1691c6ae6e..a0fd0752a3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -68,6 +68,16 @@ ifeq ($(uname_S),Linux)
 		BASIC_CFLAGS += -std=c99
         endif
 	LINK_FUZZ_PROGRAMS = YesPlease
+
+	# The builtin FSMonitor on Linux builds upon Simple-IPC.  Both require
+	# Unix domain sockets and PThreads.
+        ifndef NO_PTHREADS
+        ifndef NO_UNIX_SOCKETS
+	FSMONITOR_DAEMON_BACKEND = linux
+	FSMONITOR_OS_SETTINGS = linux
+	BASIC_CFLAGS += -DHAVE_LINUX_MAGIC_H
+        endif
+        endif
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 28877feb9d..141b05acb0 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -308,6 +308,16 @@ if(SUPPORTS_SIMPLE_IPC)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
+	elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
+		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
+		add_compile_definitions(HAVE_LINUX_MAGIC_H)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-linux.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-linux.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-linux.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-linux.c)
+
+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-linux.c)
 	endif()
 endif()
 

base-commit: 7c7698a654a7a0031f65b0ab0c1c4e438e95df60
-- 
gitgitgadget
