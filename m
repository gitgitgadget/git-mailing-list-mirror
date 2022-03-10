Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82852C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344440AbiCJWoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbiCJWog (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:44:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF45C683E
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:30 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so6457830wmj.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7qT6iN3HPqdeOMExLnyPYtO1Aq2eT+8v+9G7h6ywli8=;
        b=IxW7rEh4yROH2b4sVBkDMHICkeupOAOCrrWMsazkrJTBoI9SPCrgmeCRv4MH4GJqoU
         u0xn10FlFUWzlZHvWthECGkSoFVJ6Tez0aFIo9yrXJsoru8K8ntdEOK0bnTh++bSTthk
         lv+Q2oCn+sjcNekrELh8V7v7qxt+rliaWOfdir/pAzxhM0u5f0tqw+JK+GJAA2k0a8Oc
         /sunifTp6VjQ8Ex/QNoxRAgTVGO4gj+cRr+Q3SCAcRtuHFEmHuy0/bhE2ljq8GY7qsg/
         eYp0Vzy0pDqS3IyeFZAwSIMjIT33FdV58X+9ObEVW7P96eS2l9rKQg6mPz12QmPb9hU+
         8weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7qT6iN3HPqdeOMExLnyPYtO1Aq2eT+8v+9G7h6ywli8=;
        b=Kq4TwSWm3K8OqElVGaMubHL/WKs8hPpCXohepitQCPrn7orHTD/vcf3vK2Eg1XclgQ
         U+/Akswtcarb86WGdzsddILlrP51Of4FRK8aiD2hlw30eok1e21GP6YpX21utwkLiknr
         d3yQuGf3dWDauIbhCJun73okMklUnX+8jiKfa+cjnN3/t5RIzkllYHJ3BMIp9o+ko0Hh
         PDeOID0iHdS8hgl/9yodx71aJ0Ftu+k7JOOgkPrceK6csQ3FbeRIRp/nAMFTMTYPO9Ez
         oec2ZyLy9VhnlmNjtHi8olXAosboIT/RIX15dx5FBWgpz51s4440egPO/AvT9FHGZZoo
         VYKQ==
X-Gm-Message-State: AOAM5302+zIotOZLJFz92WF/7QD+p8B7mU64gbueU4qHFIgyj/o4RXDo
        y04FFLYdbYUoQ7QG0m1Db5X4YJm7xcY=
X-Google-Smtp-Source: ABdhPJwaiCIz7gal9GjcQcHC1uB4PZCgVwim2P0MbB5MOvouLrQc2iUgDAYpnZRTatgKtengBfBQMg==
X-Received: by 2002:a05:600c:4fc7:b0:389:ec8c:b544 with SMTP id o7-20020a05600c4fc700b00389ec8cb544mr353097wmq.202.1646952209206;
        Thu, 10 Mar 2022 14:43:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c068800b00389bdc8c8c2sm5293681wmn.12.2022.03.10.14.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:43:28 -0800 (PST)
Message-Id: <a41bd4a06afcf9878d5941841519bf35ece60eac.1646952205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 22:43:20 +0000
Subject: [PATCH v6 2/6] core.fsyncmethod: add writeout-only mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This commit introduces the `core.fsyncMethod` configuration
knob, which can currently be set to `fsync` or `writeout-only`.

The new writeout-only mode attempts to tell the operating system to
flush its in-memory page cache to the storage hardware without issuing a
CACHE_FLUSH command to the storage controller.

Writeout-only fsync is significantly faster than a vanilla fsync on
common hardware, since data is written to a disk-side cache rather than
all the way to a durable medium. Later changes in this patch series will
take advantage of this primitive to implement batching of hardware
flushes.

When git_fsync is called with FSYNC_WRITEOUT_ONLY, it may fail and the
caller is expected to do an ordinary fsync as needed.

On Apple platforms, the fsync system call does not issue a CACHE_FLUSH
directive to the storage controller. This change updates fsync to do
fcntl(F_FULLFSYNC) to make fsync actually durable. We maintain parity
with existing behavior on Apple platforms by setting the default value
of the new core.fsyncMethod option.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt       |  9 ++++
 Makefile                            |  6 +++
 cache.h                             |  7 ++++
 compat/mingw.h                      |  3 ++
 compat/win32/flush.c                | 28 +++++++++++++
 config.c                            | 12 ++++++
 config.mak.uname                    |  3 ++
 configure.ac                        |  8 ++++
 contrib/buildsystems/CMakeLists.txt | 16 ++++++--
 environment.c                       |  1 +
 git-compat-util.h                   | 24 +++++++++++
 wrapper.c                           | 64 +++++++++++++++++++++++++++++
 write-or-die.c                      | 11 +++--
 13 files changed, 184 insertions(+), 8 deletions(-)
 create mode 100644 compat/win32/flush.c

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..dbb134f7136 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -547,6 +547,15 @@ core.whitespace::
   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
+core.fsyncMethod::
+	A value indicating the strategy Git will use to harden repository data
+	using fsync and related primitives.
++
+* `fsync` uses the fsync() system call or platform equivalents.
+* `writeout-only` issues pagecache writeback requests, but depending on the
+  filesystem and storage hardware, data added to the repository may not be
+  durable in the event of a system crash. This is the default mode on macOS.
+
 core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
 +
diff --git a/Makefile b/Makefile
index 6f0b4b775fe..17fd9b023a4 100644
--- a/Makefile
+++ b/Makefile
@@ -411,6 +411,8 @@ all::
 #
 # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
 #
+# Define HAVE_SYNC_FILE_RANGE if your platform has sync_file_range.
+#
 # Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
 # before 2.17) for clock_gettime and CLOCK_MONOTONIC.
 #
@@ -1897,6 +1899,10 @@ ifdef HAVE_CLOCK_MONOTONIC
 	BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
 endif
 
+ifdef HAVE_SYNC_FILE_RANGE
+	BASIC_CFLAGS += -DHAVE_SYNC_FILE_RANGE
+endif
+
 ifdef NEEDS_LIBRT
 	EXTLIBS += -lrt
 endif
diff --git a/cache.h b/cache.h
index 04d4d2db25c..82f0194a3dd 100644
--- a/cache.h
+++ b/cache.h
@@ -995,6 +995,13 @@ extern char *git_replace_ref_base;
 
 extern int fsync_object_files;
 extern int use_fsync;
+
+enum fsync_method {
+	FSYNC_METHOD_FSYNC,
+	FSYNC_METHOD_WRITEOUT_ONLY
+};
+
+extern enum fsync_method fsync_method;
 extern int core_preload_index;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/compat/mingw.h b/compat/mingw.h
index c9a52ad64a6..6074a3d3ced 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -329,6 +329,9 @@ int mingw_getpagesize(void);
 #define getpagesize mingw_getpagesize
 #endif
 
+int win32_fsync_no_flush(int fd);
+#define fsync_no_flush win32_fsync_no_flush
+
 struct rlimit {
 	unsigned int rlim_cur;
 };
diff --git a/compat/win32/flush.c b/compat/win32/flush.c
new file mode 100644
index 00000000000..291f90ea940
--- /dev/null
+++ b/compat/win32/flush.c
@@ -0,0 +1,28 @@
+#include "git-compat-util.h"
+#include <winternl.h>
+#include "lazyload.h"
+
+int win32_fsync_no_flush(int fd)
+{
+       IO_STATUS_BLOCK io_status;
+
+#define FLUSH_FLAGS_FILE_DATA_ONLY 1
+
+       DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NTAPI, NtFlushBuffersFileEx,
+			 HANDLE FileHandle, ULONG Flags, PVOID Parameters, ULONG ParameterSize,
+			 PIO_STATUS_BLOCK IoStatusBlock);
+
+       if (!INIT_PROC_ADDR(NtFlushBuffersFileEx)) {
+		errno = ENOSYS;
+		return -1;
+       }
+
+       memset(&io_status, 0, sizeof(io_status));
+       if (NtFlushBuffersFileEx((HANDLE)_get_osfhandle(fd), FLUSH_FLAGS_FILE_DATA_ONLY,
+				NULL, 0, &io_status)) {
+		errno = EINVAL;
+		return -1;
+       }
+
+       return 0;
+}
diff --git a/config.c b/config.c
index 383b1a4885b..f3ff80b01c9 100644
--- a/config.c
+++ b/config.c
@@ -1600,6 +1600,18 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.fsyncmethod")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcmp(value, "fsync"))
+			fsync_method = FSYNC_METHOD_FSYNC;
+		else if (!strcmp(value, "writeout-only"))
+			fsync_method = FSYNC_METHOD_WRITEOUT_ONLY;
+		else
+			warning(_("ignoring unknown core.fsyncMethod value '%s'"), value);
+
+	}
+
 	if (!strcmp(var, "core.fsyncobjectfiles")) {
 		fsync_object_files = git_config_bool(var, value);
 		return 0;
diff --git a/config.mak.uname b/config.mak.uname
index 4352ea39e9b..404fff5dd04 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -57,6 +57,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_CLOCK_MONOTONIC = YesPlease
 	# -lrt is needed for clock_gettime on glibc <= 2.16
 	NEEDS_LIBRT = YesPlease
+	HAVE_SYNC_FILE_RANGE = YesPlease
 	HAVE_GETDELIM = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	BASIC_CFLAGS += -DHAVE_SYSINFO
@@ -463,6 +464,7 @@ endif
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
+		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/trace2_win32_process_info.o \
@@ -640,6 +642,7 @@ ifeq ($(uname_S),MINGW)
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/trace2_win32_process_info.o \
+		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
diff --git a/configure.ac b/configure.ac
index 5ee25ec95c8..6bd6bef1c44 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1082,6 +1082,14 @@ AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
 	[AC_MSG_RESULT([no])
 	HAVE_CLOCK_MONOTONIC=])
 GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])
+
+#
+# Define HAVE_SYNC_FILE_RANGE=YesPlease if sync_file_range is available.
+GIT_CHECK_FUNC(sync_file_range,
+	[HAVE_SYNC_FILE_RANGE=YesPlease],
+	[HAVE_SYNC_FILE_RANGE])
+GIT_CONF_SUBST([HAVE_SYNC_FILE_RANGE])
+
 #
 # Define NO_SETITIMER if you don't have setitimer.
 GIT_CHECK_FUNC(setitimer,
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index e44232f85d3..3a9e6241660 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -261,10 +261,18 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
 				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
 				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
-	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
-		compat/win32/pthread.c compat/win32mmap.c compat/win32/syslog.c
-		compat/win32/trace2_win32_process_info.c compat/win32/dirent.c
-		compat/nedmalloc/nedmalloc.c compat/strdup.c)
+	list(APPEND compat_SOURCES
+		compat/mingw.c
+		compat/winansi.c
+		compat/win32/flush.c
+		compat/win32/path-utils.c
+		compat/win32/pthread.c
+		compat/win32mmap.c
+		compat/win32/syslog.c
+		compat/win32/trace2_win32_process_info.c
+		compat/win32/dirent.c
+		compat/nedmalloc/nedmalloc.c
+		compat/strdup.c)
 	set(NO_UNIX_SOCKETS 1)
 
 elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
diff --git a/environment.c b/environment.c
index fd0501e77a5..3e3620d759f 100644
--- a/environment.c
+++ b/environment.c
@@ -44,6 +44,7 @@ int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files;
 int use_fsync = -1;
+enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
diff --git a/git-compat-util.h b/git-compat-util.h
index d210cff058c..00356476a9d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1271,6 +1271,30 @@ __attribute__((format (printf, 1, 2))) NORETURN
 void BUG(const char *fmt, ...);
 #endif
 
+#ifdef __APPLE__
+#define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
+#else
+#define FSYNC_METHOD_DEFAULT FSYNC_METHOD_FSYNC
+#endif
+
+enum fsync_action {
+	FSYNC_WRITEOUT_ONLY,
+	FSYNC_HARDWARE_FLUSH
+};
+
+/*
+ * Issues an fsync against the specified file according to the specified mode.
+ *
+ * FSYNC_WRITEOUT_ONLY attempts to use interfaces available on some operating
+ * systems to flush the OS cache without issuing a flush command to the storage
+ * controller. If those interfaces are unavailable, the function fails with
+ * ENOSYS.
+ *
+ * FSYNC_HARDWARE_FLUSH does an OS writeout and hardware flush to ensure that
+ * changes are durable. It is not expected to fail.
+ */
+int git_fsync(int fd, enum fsync_action action);
+
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Returns 0 on success, which includes trying to unlink an object that does
diff --git a/wrapper.c b/wrapper.c
index 1108e4840a4..354d784c034 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -546,6 +546,70 @@ int xmkstemp_mode(char *filename_template, int mode)
 	return fd;
 }
 
+/*
+ * Some platforms return EINTR from fsync. Since fsync is invoked in some
+ * cases by a wrapper that dies on failure, do not expose EINTR to callers.
+ */
+static int fsync_loop(int fd)
+{
+	int err;
+
+	do {
+		err = fsync(fd);
+	} while (err < 0 && errno == EINTR);
+	return err;
+}
+
+int git_fsync(int fd, enum fsync_action action)
+{
+	switch (action) {
+	case FSYNC_WRITEOUT_ONLY:
+
+#ifdef __APPLE__
+		/*
+		 * On macOS, fsync just causes filesystem cache writeback but
+		 * does not flush hardware caches.
+		 */
+		return fsync_loop(fd);
+#endif
+
+#ifdef HAVE_SYNC_FILE_RANGE
+		/*
+		 * On linux 2.6.17 and above, sync_file_range is the way to
+		 * issue a writeback without a hardware flush. An offset of
+		 * 0 and size of 0 indicates writeout of the entire file and the
+		 * wait flags ensure that all dirty data is written to the disk
+		 * (potentially in a disk-side cache) before we continue.
+		 */
+
+		return sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
+						 SYNC_FILE_RANGE_WRITE |
+						 SYNC_FILE_RANGE_WAIT_AFTER);
+#endif
+
+#ifdef fsync_no_flush
+		return fsync_no_flush(fd);
+#endif
+
+		errno = ENOSYS;
+		return -1;
+
+	case FSYNC_HARDWARE_FLUSH:
+		/*
+		 * On macOS, a special fcntl is required to really flush the
+		 * caches within the storage controller. As of this writing,
+		 * this is a very expensive operation on Apple SSDs.
+		 */
+#ifdef __APPLE__
+		return fcntl(fd, F_FULLFSYNC);
+#else
+		return fsync_loop(fd);
+#endif
+	default:
+		BUG("unexpected git_fsync(%d) call", action);
+	}
+}
+
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
 	int err;
diff --git a/write-or-die.c b/write-or-die.c
index a3d5784cec9..9faa5f9f563 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -62,10 +62,13 @@ void fsync_or_die(int fd, const char *msg)
 		use_fsync = git_env_bool("GIT_TEST_FSYNC", 1);
 	if (!use_fsync)
 		return;
-	while (fsync(fd) < 0) {
-		if (errno != EINTR)
-			die_errno("fsync error on '%s'", msg);
-	}
+
+	if (fsync_method == FSYNC_METHOD_WRITEOUT_ONLY &&
+	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0)
+		return;
+
+	if (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0)
+		die_errno("fsync error on '%s'", msg);
 }
 
 void write_or_die(int fd, const void *buf, size_t count)
-- 
gitgitgadget

