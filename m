Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE618C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB54061038
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348404AbhIXUOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344407AbhIXUNu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 16:13:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB839C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i24so14867623wrc.9
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s58h2yRCtzX2y/fLvrOOSPav3rMBGL4p/lrwppDnCzI=;
        b=hp2OCD7o0jHk/IcMonc2LN6WkMmUPIa9BgIOffOjo/66dBU3U46moe6DC2z/KKlzMy
         R8KEoXBiJitq/Sm3GHTY6FyovbjlS8sWC36mYet+Xy7EJyRahUZFtlnCwEGmakmInUR2
         RzWMjq09iO1VEz5mlZlYJJQ45EvuY88sx3XwAJqN0WuFLCzl2r8FYjI3wmxbAWQpeRJM
         azCO8/CHhsSVzornwiu23kRpTFbcAyS7D6UCRU85AM4+rIqbl0D2/0ExVmljeRqrUJgj
         2USTlqI8g8qDyHbQYW+fshcxwmJME5+6CWFosBWaKNNVrOwI5kNGfKWXBas25bSnr5Hv
         sm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s58h2yRCtzX2y/fLvrOOSPav3rMBGL4p/lrwppDnCzI=;
        b=AbzhjRrJoVu5rPjT+KlHKOJu9KJjQvqbfMyULzfS9+a1QYfpjM4VbieNG4H7gkAd5b
         xcjVU145QcArXuXESavLEI8AQE2C7F6cMbdJPCW+jQwNlJJryTjkztFgaccw+EXsnrt+
         MMhc4Gn7e3mM484WWE4rjG20wwmbayQ1fqw3crs9/6AMbKXzOi/Z0bIUFDxu1Ib3Kpmr
         c0M22WzUgmgP3wpPBqXrs4+Bye2LEEwwVTBy7P+FcVMoV9lHonL4dTEItdNVzUsT8soD
         XIk9bGTCbBtCayOxsYunXcNF4kyEnlWEbdCZf6MKQ2HMN7KUw4YGkiKgYX5JShse0nwQ
         NxHA==
X-Gm-Message-State: AOAM530cYRXZ+pe8i7RGDoc9dJy/lxrSID/Hc1cwkhrERq3fOZ6NnqEb
        U+oOS1rqbDfKxjQEMQ8pcw1rwRFXipQ=
X-Google-Smtp-Source: ABdhPJxZi1MLDnhA6yobqStHuEmrTXq8vroJsSGTlIIW7GNBbVe12Poa3HHWpga51c9lfv7weRFB5A==
X-Received: by 2002:a1c:ed13:: with SMTP id l19mr3934508wmh.48.1632514335144;
        Fri, 24 Sep 2021 13:12:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r25sm9223333wra.76.2021.09.24.13.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:12:14 -0700 (PDT)
Message-Id: <fe19cdfc9305a54b40b9979842d0d1d7c7dfb828.1632514331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
References: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
        <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 20:12:07 +0000
Subject: [PATCH v5 3/7] core.fsyncobjectfiles: batched disk flushes
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

When the new mode is enabled we do the following for each new object:
1. Create the object in a tmp-objdir.
2. Issue a pagecache writeback request and wait for it to complete.

At the end of the entire transaction when unplugging bulk checkin we:
1. Issue an fsync against a dummy file to flush the hardware writeback
   cache, which should by now have processed the tmp-objdir writes.
2. Rename all of the tmp-objdir files to their final names.
3. When updating the index and/or refs, we assume that Git will issue
   another fsync internal to that operation. This is not the case today,
   but may be a good extension to those components.

On a filesystem with a singular journal that is updated during name
operations (e.g. create, link, rename, etc), such as NTFS, HFS+, or XFS we
would expect the fsync to trigger a journal writeout so that this
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
 Documentation/config/core.txt | 29 ++++++++++++---
 Makefile                      |  6 +++
 builtin/add.c                 |  1 +
 bulk-checkin.c                | 70 +++++++++++++++++++++++++++++++++++
 bulk-checkin.h                |  2 +
 cache.h                       |  8 +++-
 config.c                      |  7 +++-
 config.mak.uname              |  1 +
 configure.ac                  |  8 ++++
 environment.c                 |  2 +-
 git-compat-util.h             |  7 ++++
 object-file.c                 | 67 ++++++++++++++++++++++++++++++++-
 object-store.h                | 16 ++++++++
 object.c                      |  2 +-
 tmp-objdir.c                  | 20 +++++++++-
 tmp-objdir.h                  |  6 +++
 wrapper.c                     | 44 ++++++++++++++++++++++
 write-or-die.c                |  2 +-
 18 files changed, 285 insertions(+), 13 deletions(-)

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
index 429c276058d..326c7607e0f 100644
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
@@ -1896,6 +1898,10 @@ ifdef HAVE_CLOCK_MONOTONIC
 	BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
 endif
 
+ifdef HAVE_SYNC_FILE_RANGE
+	BASIC_CFLAGS += -DHAVE_SYNC_FILE_RANGE
+endif
+
 ifdef NEEDS_LIBRT
 	EXTLIBS += -lrt
 endif
diff --git a/builtin/add.c b/builtin/add.c
index 2244311d485..9d9897cf037 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -678,6 +678,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (chmod_arg && pathspec.nr)
 		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
+
 	unplug_bulk_checkin();
 
 finish:
diff --git a/bulk-checkin.c b/bulk-checkin.c
index f117d62c908..957a6238684 100644
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
@@ -62,6 +68,34 @@ clear_exit:
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
@@ -256,6 +290,26 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
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
+		assert(the_repository->objects->odb->is_temp);
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
@@ -270,6 +324,20 @@ int index_bulk_checkin(struct object_id *oid,
 void plug_bulk_checkin(void)
 {
 	assert(!bulk_checkin_plugged);
+
+	/*
+	 * Create a temporary object directory if the current
+	 * object directory is not already temporary.
+	 */
+	if (fsync_object_files == FSYNC_OBJECT_FILES_BATCH &&
+	    !the_repository->objects->odb->is_temp) {
+		bulk_fsync_objdir = tmp_objdir_create();
+		if (!bulk_fsync_objdir)
+			die(_("Could not create temporary object directory for core.fsyncobjectfiles=batch"));
+
+		tmp_objdir_replace_main_odb(bulk_fsync_objdir);
+	}
+
 	bulk_checkin_plugged = 1;
 }
 
@@ -279,4 +347,6 @@ void unplug_bulk_checkin(void)
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
index d23de693680..d1897fe9d92 100644
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
index cb4a8058bff..1b403e00241 100644
--- a/config.c
+++ b/config.c
@@ -1509,7 +1509,12 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
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
index 76516aaa9a5..e6d482fbcc6 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -53,6 +53,7 @@ ifeq ($(uname_S),Linux)
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
index d9ba68402e9..f318d59e585 100644
--- a/environment.c
+++ b/environment.c
@@ -43,7 +43,7 @@ const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
-int fsync_object_files;
+enum fsync_object_files_mode fsync_object_files;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
diff --git a/git-compat-util.h b/git-compat-util.h
index b46605300ab..d14e2436276 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1210,6 +1210,13 @@ __attribute__((format (printf, 1, 2))) NORETURN
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
index ab593515cec..ec22560dd66 100644
--- a/object-file.c
+++ b/object-file.c
@@ -750,6 +750,60 @@ void add_to_alternates_memory(const char *reference)
 			     '\n', NULL, 0);
 }
 
+struct object_directory *set_temporary_main_odb(const char *dir)
+{
+	struct object_directory *main_odb, *new_odb, *old_next;
+
+	/*
+	 * Make sure alternates are initialized, or else our entry may be
+	 * overwritten when they are.
+	 */
+	prepare_alt_odb(the_repository);
+
+	/* Copy the existing object directory and make it an alternate. */
+	main_odb = the_repository->objects->odb;
+	new_odb = xmalloc(sizeof(*new_odb));
+	*new_odb = *main_odb;
+	*the_repository->objects->odb_tail = new_odb;
+	the_repository->objects->odb_tail = &(new_odb->next);
+	new_odb->next = NULL;
+
+	/*
+	 * Reinitialize the main odb with the specified path, being careful
+	 * to keep the next pointer value.
+	 */
+	old_next = main_odb->next;
+	memset(main_odb, 0, sizeof(*main_odb));
+	main_odb->next = old_next;
+	main_odb->is_temp = 1;
+	main_odb->path = xstrdup(dir);
+	return new_odb;
+}
+
+void restore_main_odb(struct object_directory *odb)
+{
+	struct object_directory **prev, *main_odb;
+
+	/* Unlink the saved previous main ODB from the list. */
+	prev = &the_repository->objects->odb->next;
+	assert(*prev);
+	while (*prev != odb) {
+		prev = &(*prev)->next;
+	}
+	*prev = odb->next;
+	if (*prev == NULL)
+		the_repository->objects->odb_tail = prev;
+
+	/*
+	 * Restore the data from the old main odb, being careful to
+	 * keep the next pointer value
+	 */
+	main_odb = the_repository->objects->odb;
+	SWAP(*main_odb, *odb);
+	main_odb->next = odb->next;
+	free_object_directory(odb);
+}
+
 /*
  * Compute the exact path an alternate is at and returns it. In case of
  * error NULL is returned and the human readable error is added to `err`
@@ -1867,8 +1921,19 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(int fd)
 {
-	if (fsync_object_files)
+	switch (fsync_object_files) {
+	case FSYNC_OBJECT_FILES_OFF:
+		break;
+	case FSYNC_OBJECT_FILES_ON:
 		fsync_or_die(fd, "loose object file");
+		break;
+	case FSYNC_OBJECT_FILES_BATCH:
+		fsync_loose_object_bulk_checkin(fd);
+		break;
+	default:
+		BUG("Invalid fsync_object_files mode.");
+	}
+
 	if (close(fd) != 0)
 		die_errno(_("error when closing loose object file"));
 }
diff --git a/object-store.h b/object-store.h
index f8c883a5730..9bea14e7f3b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -62,6 +62,19 @@ void add_to_alternates_file(const char *dir);
  */
 void add_to_alternates_memory(const char *dir);
 
+/*
+ * Replace the current main object directory with the specified temporary
+ * object directory. We make a copy of the former main object directory,
+ * add it as an in-memory alternate, and return the copy so that it can
+ * be restored via restore_main_odb.
+ */
+struct object_directory *set_temporary_main_odb(const char *dir);
+
+/*
+ * Restore a previous ODB replaced by set_temporary_main_odb.
+ */
+void restore_main_odb(struct object_directory *odb);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -72,6 +85,9 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 /* Empty the loose object cache for the specified object directory. */
 void odb_clear_loose_cache(struct object_directory *odb);
 
+/* Clear and free the specified object directory */
+void free_object_directory(struct object_directory *odb);
+
 struct packed_git {
 	struct hashmap_entry packmap_ent;
 	struct packed_git *next;
diff --git a/object.c b/object.c
index 4e85955a941..98635bc4043 100644
--- a/object.c
+++ b/object.c
@@ -513,7 +513,7 @@ struct raw_object_store *raw_object_store_new(void)
 	return o;
 }
 
-static void free_object_directory(struct object_directory *odb)
+void free_object_directory(struct object_directory *odb)
 {
 	free(odb->path);
 	odb_clear_loose_cache(odb);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index b8d880e3626..f027c49db4c 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -11,6 +11,7 @@
 struct tmp_objdir {
 	struct strbuf path;
 	struct strvec env;
+	struct object_directory *prev_main_odb;
 };
 
 /*
@@ -50,8 +51,12 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
 	 * freeing memory; it may cause a deadlock if the signal
 	 * arrived while libc's allocator lock is held.
 	 */
-	if (!on_signal)
+	if (!on_signal) {
+		if (t->prev_main_odb)
+			restore_main_odb(t->prev_main_odb);
 		tmp_objdir_free(t);
+	}
+
 	return err;
 }
 
@@ -132,6 +137,7 @@ struct tmp_objdir *tmp_objdir_create(void)
 	t = xmalloc(sizeof(*t));
 	strbuf_init(&t->path, 0);
 	strvec_init(&t->env);
+	t->prev_main_odb = NULL;
 
 	strbuf_addf(&t->path, "%s/incoming-XXXXXX", get_object_directory());
 
@@ -269,6 +275,11 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	if (!t)
 		return 0;
 
+	if (t->prev_main_odb) {
+		restore_main_odb(t->prev_main_odb);
+		t->prev_main_odb = NULL;
+	}
+
 	strbuf_addbuf(&src, &t->path);
 	strbuf_addstr(&dst, get_object_directory());
 
@@ -292,3 +303,10 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
 {
 	add_to_alternates_memory(t->path.buf);
 }
+
+void tmp_objdir_replace_main_odb(struct tmp_objdir *t)
+{
+	if (t->prev_main_odb)
+		BUG("the main object database is already replaced");
+	t->prev_main_odb = set_temporary_main_odb(t->path.buf);
+}
diff --git a/tmp-objdir.h b/tmp-objdir.h
index b1e45b4c75d..4b898add05b 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -51,4 +51,10 @@ int tmp_objdir_destroy(struct tmp_objdir *);
  */
 void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
 
+/*
+ * Replaces the main object store in the current process with the temporary
+ * object directory and makes the former main object store an alternate.
+ */
+void tmp_objdir_replace_main_odb(struct tmp_objdir *);
+
 #endif /* TMP_OBJDIR_H */
diff --git a/wrapper.c b/wrapper.c
index 7c6586af321..bb4f9f043ce 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -540,6 +540,50 @@ int xmkstemp_mode(char *filename_template, int mode)
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
index d33e68f6abb..8f53953d4ab 100644
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

