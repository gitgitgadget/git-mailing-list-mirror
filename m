Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D121C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFA261B66
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244078AbhKPD1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbhKPD0W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:26:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB1AC126D01
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:09 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o29so15383404wms.2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r4HSghyssrnnAl9X8BKAG/kF9JqVpxhpcwT8Bkye6Cs=;
        b=biRmsKmxEyb2PRnCJ8liRfvbXTZyDn+Wo4tQV64hkOGa7eesM8n7ewhaeA4KYRXAf9
         wc8kUXw0bkvCwIvAjHdBNruN/yUzRpx85pbunbcrm77/cWbzwsG/YszFFfF4xrQr1sAH
         xgdvuXibnNzuLWWpwqnWnD8Xm6kqlbPU3Tm2NcQJTxRZb/76zPv8832W9GxHafkH6ZbH
         prakK+kP2tDw9M12yc1Zke4CH5cPCiSQ10ym0RBgrlY+xHLsPtHtfP1FgEpgYIXqinTL
         SgtTEejL1z0HT2BwPtbwpcXWxrow7VtEl05Veor6w+G8AVz/HdthlD89LYHkfBbPB5GC
         aQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r4HSghyssrnnAl9X8BKAG/kF9JqVpxhpcwT8Bkye6Cs=;
        b=h9qLfnwga1Gw82WJVTLPS3yb0cbo44gYeo5pdV02u3Buy9DhDCKVByc6bNv0GgrkX6
         UsxGTflHIl0ja28iKKfddTojHomM9Znpb0wkhaME5I3clTxzq3ILRQuWBD5vFg9ngoaF
         bzLkjpyTQsE9+rPyUead0yGWKh15CTNBA77Ti/y8n4/q2nCbx3pi7t9UI84v8AQtDbVq
         OFJ9/Yclvm4oME/dHTN+NuJZJ0/1h0SkV7BD1bbpffhuwTJQkQ31I94JaDn7a6hEjbLL
         Xh3SwvzyeSy92LWiHxVpo/edftCiN+30hdgX/BDYvA04SjikHeCYq211TEL2xnFifSB7
         ka9w==
X-Gm-Message-State: AOAM5316V4+UAkjZMzlMHy3/w9RO2EfP0t/55Dvk5tBLMXKVkYI0KVUR
        jVQkDqBBHwrE7Hi0M5MQKI11ACPrdg0=
X-Google-Smtp-Source: ABdhPJz0oBM7DhJ3NedIdcKR7MGuuSL5nqK86Q23tjKVmKsNYr/ycpZ+ASkfvh19CsSTDn6pKdwfYg==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr62633534wmi.173.1637020267932;
        Mon, 15 Nov 2021 15:51:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm19475620wri.15.2021.11.15.15.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 15:51:07 -0800 (PST)
Message-Id: <e1747ce00af7ab3170a69955b07d995d5321d6f3.1637020263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
        <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Nov 2021 23:50:58 +0000
Subject: [PATCH v9 4/9] core.fsyncobjectfiles: batched disk flushes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

When adding many objects to a repo with core.fsyncObjectFiles set to
true, the cost of fsync'ing each object file can become prohibitive.

One major source of the cost of fsync is the implied flush of the
hardware writeback cache within the disk drive. Fortunately, Windows,
and macOS offer mechanisms to write data from the filesystem page cache
without initiating a hardware flush. Linux has the sync_file_range API,
which issues a pagecache writeback request reliably after version 5.2.

This patch introduces a new 'core.fsyncObjectFiles = batch' option that
batches up hardware flushes. It hooks into the bulk-checkin plugging and
unplugging functionality and takes advantage of tmp-objdir.

When the new mode is enabled do the following for each new object:
1. Create the object in a tmp-objdir.
2. Issue a pagecache writeback request and wait for it to complete.

At the end of the entire transaction when unplugging bulk checkin:
1. Issue an fsync against a dummy file to flush the hardware writeback
   cache, which should by now have processed the tmp-objdir writes.
2. Rename all of the tmp-objdir files to their final names.
3. When updating the index and/or refs, we assume that Git will issue
   another fsync internal to that operation. This is not the case today,
   but may be a good extension to those components.

On a filesystem with a singular journal that is updated during name
operations (e.g. create, link, rename, etc), such as NTFS, HFS+, or XFS
we would expect the fsync to trigger a journal writeout so that this
sequence is enough to ensure that the user's data is durable by the time
the git command returns.

This change also updates the macOS code to trigger a real hardware flush
via fnctl(fd, F_FULLFSYNC) when fsync_or_die is called. Previously, on
macOS there was no guarantee of durability since a simple fsync(2) call
does not flush any hardware caches.

_Performance numbers_:

Linux - Hyper-V VM running Kernel 5.11 (Ubuntu 20.04) on a fast SSD.
Mac - macOS 11.5.1 running on a Mac mini on a 1TB Apple SSD.
Windows - Same host as Linux, a preview version of Windows 11.
	  This number is from a patch later in the series.

Adding 500 files to the repo with 'git add' Times reported in seconds.

core.fsyncObjectFiles | Linux | Mac   | Windows
----------------------|-------|-------|--------
                false | 0.06  |  0.35 | 0.61
                true  | 1.88  | 11.18 | 2.47
                batch | 0.15  |  0.41 | 1.53

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt | 29 +++++++++++----
 Makefile                      |  6 ++++
 bulk-checkin.c                | 68 +++++++++++++++++++++++++++++++++++
 bulk-checkin.h                |  2 ++
 cache.h                       |  8 ++++-
 config.c                      |  7 +++-
 config.mak.uname              |  1 +
 configure.ac                  |  8 +++++
 environment.c                 |  2 +-
 git-compat-util.h             |  7 ++++
 object-file.c                 | 12 ++++++-
 wrapper.c                     | 44 +++++++++++++++++++++++
 write-or-die.c                |  2 +-
 13 files changed, 185 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..200b4d9f06e 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -548,12 +548,29 @@ core.whitespace::
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
 core.fsyncObjectFiles::
-	This boolean will enable 'fsync()' when writing object files.
-+
-This is a total waste of time and effort on a filesystem that orders
-data writes properly, but can be useful for filesystems that do not use
-journalling (traditional UNIX filesystems) or that only journal metadata
-and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
+	A value indicating the level of effort Git will expend in
+	trying to make objects added to the repo durable in the event
+	of an unclean system shutdown. This setting currently only
+	controls loose objects in the object store, so updates to any
+	refs or the index may not be equally durable.
++
+* `false` allows data to remain in file system caches according to
+  operating system policy, whence it may be lost if the system loses power
+  or crashes.
+* `true` triggers a data integrity flush for each loose object added to the
+  object store. This is the safest setting that is likely to ensure durability
+  across all operating systems and file systems that honor the 'fsync' system
+  call. However, this setting comes with a significant performance cost on
+  common hardware. Git does not currently fsync parent directories for
+  newly-added files, so some filesystems may still allow data to be lost on
+  system crash.
+* `batch` enables an experimental mode that uses interfaces available in some
+  operating systems to write loose object data with a minimal set of FLUSH
+  CACHE (or equivalent) commands sent to the storage controller. If the
+  operating system interfaces are not available, this mode behaves the same as
+  `true`. This mode is expected to be as safe as `true` on macOS for repos
+  stored on HFS+ or APFS filesystems and on Windows for repos stored on NTFS or
+  ReFS.
 
 core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
diff --git a/Makefile b/Makefile
index 12be39ac497..241dc322c09 100644
--- a/Makefile
+++ b/Makefile
@@ -406,6 +406,8 @@ all::
 #
 # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
 #
+# Define HAVE_SYNC_FILE_RANGE if your platform has sync_file_range.
+#
 # Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
 # before 2.17) for clock_gettime and CLOCK_MONOTONIC.
 #
@@ -1884,6 +1886,10 @@ ifdef HAVE_CLOCK_MONOTONIC
 	BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
 endif
 
+ifdef HAVE_SYNC_FILE_RANGE
+	BASIC_CFLAGS += -DHAVE_SYNC_FILE_RANGE
+endif
+
 ifdef NEEDS_LIBRT
 	EXTLIBS += -lrt
 endif
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6ae18401e04..4deee1af46e 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -3,14 +3,20 @@
  */
 #include "cache.h"
 #include "bulk-checkin.h"
+#include "lockfile.h"
 #include "repository.h"
 #include "csum-file.h"
 #include "pack.h"
 #include "strbuf.h"
+#include "string-list.h"
+#include "tmp-objdir.h"
 #include "packfile.h"
 #include "object-store.h"
 
 static int bulk_checkin_plugged;
+static int needs_batch_fsync;
+
+static struct tmp_objdir *bulk_fsync_objdir;
 
 static struct bulk_checkin_state {
 	char *pack_tmp_name;
@@ -79,6 +85,34 @@ clear_exit:
 	reprepare_packed_git(the_repository);
 }
 
+/*
+ * Cleanup after batch-mode fsync_object_files.
+ */
+static void do_batch_fsync(void)
+{
+	/*
+	 * Issue a full hardware flush against a temporary file to ensure
+	 * that all objects are durable before any renames occur.  The code in
+	 * fsync_loose_object_bulk_checkin has already issued a writeout
+	 * request, but it has not flushed any writeback cache in the storage
+	 * hardware.
+	 */
+
+	if (needs_batch_fsync) {
+		struct strbuf temp_path = STRBUF_INIT;
+		struct tempfile *temp;
+
+		strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_directory());
+		temp = xmks_tempfile(temp_path.buf);
+		fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
+		delete_tempfile(&temp);
+		strbuf_release(&temp_path);
+	}
+
+	if (bulk_fsync_objdir)
+		tmp_objdir_migrate(bulk_fsync_objdir);
+}
+
 static int already_written(struct bulk_checkin_state *state, struct object_id *oid)
 {
 	int i;
@@ -273,6 +307,25 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	return 0;
 }
 
+void fsync_loose_object_bulk_checkin(int fd)
+{
+	assert(fsync_object_files == FSYNC_OBJECT_FILES_BATCH);
+
+	/*
+	 * If we have a plugged bulk checkin, we issue a call that
+	 * cleans the filesystem page cache but avoids a hardware flush
+	 * command. Later on we will issue a single hardware flush
+	 * before as part of do_batch_fsync.
+	 */
+	if (bulk_checkin_plugged &&
+	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
+		if (!needs_batch_fsync)
+			needs_batch_fsync = 1;
+	} else {
+		fsync_or_die(fd, "loose object file");
+	}
+}
+
 int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags)
@@ -287,6 +340,19 @@ int index_bulk_checkin(struct object_id *oid,
 void plug_bulk_checkin(void)
 {
 	assert(!bulk_checkin_plugged);
+
+	/*
+	 * A temporary object directory is used to hold the files
+	 * while they are not fsynced.
+	 */
+	if (fsync_object_files == FSYNC_OBJECT_FILES_BATCH) {
+		bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
+		if (!bulk_fsync_objdir)
+			die(_("Could not create temporary object directory for core.fsyncobjectfiles=batch"));
+
+		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
+	}
+
 	bulk_checkin_plugged = 1;
 }
 
@@ -296,4 +362,6 @@ void unplug_bulk_checkin(void)
 	bulk_checkin_plugged = 0;
 	if (bulk_checkin_state.f)
 		finish_bulk_checkin(&bulk_checkin_state);
+
+	do_batch_fsync();
 }
diff --git a/bulk-checkin.h b/bulk-checkin.h
index b26f3dc3b74..08f292379b6 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -6,6 +6,8 @@
 
 #include "cache.h"
 
+void fsync_loose_object_bulk_checkin(int fd);
+
 int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags);
diff --git a/cache.h b/cache.h
index eba12487b99..6d6e6770ecc 100644
--- a/cache.h
+++ b/cache.h
@@ -985,7 +985,13 @@ void reset_shared_repository(void);
 extern int read_replace_refs;
 extern char *git_replace_ref_base;
 
-extern int fsync_object_files;
+enum fsync_object_files_mode {
+    FSYNC_OBJECT_FILES_OFF,
+    FSYNC_OBJECT_FILES_ON,
+    FSYNC_OBJECT_FILES_BATCH
+};
+
+extern enum fsync_object_files_mode fsync_object_files;
 extern int core_preload_index;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index c5873f3a706..5eb36ecd77a 100644
--- a/config.c
+++ b/config.c
@@ -1491,7 +1491,12 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "core.fsyncobjectfiles")) {
-		fsync_object_files = git_config_bool(var, value);
+		if (value && !strcmp(value, "batch"))
+			fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
+		else if (git_config_bool(var, value))
+			fsync_object_files = FSYNC_OBJECT_FILES_ON;
+		else
+			fsync_object_files = FSYNC_OBJECT_FILES_OFF;
 		return 0;
 	}
 
diff --git a/config.mak.uname b/config.mak.uname
index 3236a4918a3..5ead1377667 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -57,6 +57,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_CLOCK_MONOTONIC = YesPlease
 	# -lrt is needed for clock_gettime on glibc <= 2.16
 	NEEDS_LIBRT = YesPlease
+	HAVE_SYNC_FILE_RANGE = YesPlease
 	HAVE_GETDELIM = YesPlease
 	SANE_TEXT_GREP=-a
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
diff --git a/configure.ac b/configure.ac
index 031e8d3fee8..c711037d625 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1090,6 +1090,14 @@ AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
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
diff --git a/environment.c b/environment.c
index 2701dfeeec8..aeafe80235e 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,7 @@ const char *git_attributes_file;
 const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
-int fsync_object_files;
+enum fsync_object_files_mode fsync_object_files;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
diff --git a/git-compat-util.h b/git-compat-util.h
index d70ce142861..4defd4ab200 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1214,6 +1214,13 @@ __attribute__((format (printf, 1, 2))) NORETURN
 void BUG(const char *fmt, ...);
 #endif
 
+enum fsync_action {
+    FSYNC_WRITEOUT_ONLY,
+    FSYNC_HARDWARE_FLUSH
+};
+
+int git_fsync(int fd, enum fsync_action action);
+
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Returns 0 on success, which includes trying to unlink an object that does
diff --git a/object-file.c b/object-file.c
index 659ef7623ff..9d0aac792ae 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1853,8 +1853,18 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 static void close_loose_object(int fd)
 {
 	if (!the_repository->objects->odb->will_destroy) {
-		if (fsync_object_files)
+		switch (fsync_object_files) {
+		case FSYNC_OBJECT_FILES_OFF:
+			break;
+		case FSYNC_OBJECT_FILES_ON:
 			fsync_or_die(fd, "loose object file");
+			break;
+		case FSYNC_OBJECT_FILES_BATCH:
+			fsync_loose_object_bulk_checkin(fd);
+			break;
+		default:
+			BUG("Invalid fsync_object_files mode.");
+		}
 	}
 
 	if (close(fd) != 0)
diff --git a/wrapper.c b/wrapper.c
index 36e12119d76..689288d2e31 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -546,6 +546,50 @@ int xmkstemp_mode(char *filename_template, int mode)
 	return fd;
 }
 
+int git_fsync(int fd, enum fsync_action action)
+{
+	switch (action) {
+	case FSYNC_WRITEOUT_ONLY:
+
+#ifdef __APPLE__
+		/*
+		 * on macOS, fsync just causes filesystem cache writeback but does not
+		 * flush hardware caches.
+		 */
+		return fsync(fd);
+#endif
+
+#ifdef HAVE_SYNC_FILE_RANGE
+		/*
+		 * On linux 2.6.17 and above, sync_file_range is the way to issue
+		 * a writeback without a hardware flush. An offset of 0 and size of 0
+		 * indicates writeout of the entire file and the wait flags ensure that all
+		 * dirty data is written to the disk (potentially in a disk-side cache)
+		 * before we continue.
+		 */
+
+		return sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
+						 SYNC_FILE_RANGE_WRITE |
+						 SYNC_FILE_RANGE_WAIT_AFTER);
+#endif
+
+		errno = ENOSYS;
+		return -1;
+
+	case FSYNC_HARDWARE_FLUSH:
+
+#ifdef __APPLE__
+		return fcntl(fd, F_FULLFSYNC);
+#else
+		return fsync(fd);
+#endif
+
+	default:
+		BUG("unexpected git_fsync(%d) call", action);
+	}
+
+}
+
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
 	int err;
diff --git a/write-or-die.c b/write-or-die.c
index 0b1ec8190b6..cc8291d9794 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -57,7 +57,7 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
 
 void fsync_or_die(int fd, const char *msg)
 {
-	while (fsync(fd) < 0) {
+	while (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0) {
 		if (errno != EINTR)
 			die_errno("fsync error on '%s'", msg);
 	}
-- 
gitgitgadget

