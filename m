Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A37BC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351960AbiCOVcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351284AbiCOVcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:32:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696735BE47
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so342223wmp.5
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7i75K7ijf+l6vkI2XlesvYMiiOUQOe4rl8kHX4/O63o=;
        b=KjRgSIpYY92/I9qGlZKCF8R6vfMclwmfnE0KTsvgx9I84xURrxTd0F0RK2vfLK9QzU
         4oxlbBnTqoz6lVrXmJWuO9O+fGvWIuxfrU93RrlBK7gTT74H+mWUiuy9e1uc3b7dJn5u
         38e66uKhcccLE63t7a2O3e/YxUGELn0TWYbe/3eqPUYbipoNNa93F4gqxz2jXpTA3eQq
         m6A96sn75283/c5Od96Sh0zQ5LMiH1nKlrmBgdpRHwIJLzrYW1SVwbZ26lynd9h2J8pj
         N/TMl/PoJstFkBx9XT9w6Z4m3aNpFQYjhfD+RZaQgSCOX/GjEITe511GZxW4EBOyN1/7
         BfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7i75K7ijf+l6vkI2XlesvYMiiOUQOe4rl8kHX4/O63o=;
        b=4vhCxCzI7speRTuHsSjQnOpKWZAOsIEGrkL6pvSQLZSVzTEE4sKeUIBo9XzATr3CSR
         D99VmdE7Y9x1aEqIHx9QYdeVRDgKqzg7a/65uph5SYVk8ScyNKEKzWGhgV7xMdU74K6F
         8sQKeFWBhpAklZ8ly8hZe1dF8iFaBl+QZhUe2hZstQfwXZiYHzvx4TSLYuD479c+Ch9p
         UApY3f2dg7c4V1N+B/UBOs5RpdUX0dcE/vY5pwxzLsnICdW8BTC++hWBkUvnku9fMMYr
         rNedyrOoMuPe9kBWQkcFR0K9MLvXmWghIv/tABLUxqfX/PPECpdXdmoCCkVxexrooyW+
         tx0A==
X-Gm-Message-State: AOAM532Mx5y1VLUfSOEvCVfTB6SlABzqJ6M+2UuHg0PzXRTvHAyn37GN
        hBLEH1EFgyNmah4kYQpZ8Tvj0Xre1Ho=
X-Google-Smtp-Source: ABdhPJyI7eHHVu78jtTjFgFh8DeW42yDHivbY1mvd5ARcl+OwUZV0Lhw+TcDYsZV1BGb2llWKs0GrA==
X-Received: by 2002:a7b:cd13:0:b0:38b:f39c:1181 with SMTP id f19-20020a7bcd13000000b0038bf39c1181mr3092707wmj.20.1647379862645;
        Tue, 15 Mar 2022 14:31:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4010000000b001f07772457csm68526wrp.101.2022.03.15.14.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 14:31:02 -0700 (PDT)
Message-Id: <d38f20b4430bada1d0dccc1e600e6f0b098f3767.1647379859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 21:30:54 +0000
Subject: [PATCH 2/7] core.fsyncmethod: batched disk flushes for loose-objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

When adding many objects to a repo with `core.fsync=loose-object`,
the cost of fsync'ing each object file can become prohibitive.

One major source of the cost of fsync is the implied flush of the
hardware writeback cache within the disk drive. This commit introduces
a new `core.fsyncMethod=batch` option that batches up hardware flushes.
It hooks into the bulk-checkin plugging and unplugging functionality,
takes advantage of tmp-objdir, and uses the writeout-only support code.

When the new mode is enabled, we do the following for each new object:
1. Create the object in a tmp-objdir.
2. Issue a pagecache writeback request and wait for it to complete.

At the end of the entire transaction when unplugging bulk checkin:
1. Issue an fsync against a dummy file to flush the hardware writeback
   cache, which should by now have seen the tmp-objdir writes.
2. Rename all of the tmp-objdir files to their final names.
3. When updating the index and/or refs, we assume that Git will issue
   another fsync internal to that operation. This is not the default
   today, but the user now has the option of syncing the index and there
   is a separate patch series to implement syncing of refs.

On a filesystem with a singular journal that is updated during name
operations (e.g. create, link, rename, etc), such as NTFS, HFS+, or XFS
we would expect the fsync to trigger a journal writeout so that this
sequence is enough to ensure that the user's data is durable by the time
the git command returns.

Batch mode is only enabled if core.fsyncObjectFiles is false or unset.

_Performance numbers_:

Linux - Hyper-V VM running Kernel 5.11 (Ubuntu 20.04) on a fast SSD.
Mac - macOS 11.5.1 running on a Mac mini on a 1TB Apple SSD.
Windows - Same host as Linux, a preview version of Windows 11.

Adding 500 files to the repo with 'git add' Times reported in seconds.

object file syncing | Linux | Mac   | Windows
--------------------|-------|-------|--------
           disabled | 0.06  |  0.35 | 0.61
              fsync | 1.88  | 11.18 | 2.47
              batch | 0.15  |  0.41 | 1.53

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt |  5 +++
 bulk-checkin.c                | 67 +++++++++++++++++++++++++++++++++++
 bulk-checkin.h                |  2 ++
 cache.h                       |  8 ++++-
 config.c                      |  2 ++
 object-file.c                 |  2 ++
 6 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 062e5259905..c041ed33801 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -628,6 +628,11 @@ core.fsyncMethod::
 * `writeout-only` issues pagecache writeback requests, but depending on the
   filesystem and storage hardware, data added to the repository may not be
   durable in the event of a system crash. This is the default mode on macOS.
+* `batch` enables a mode that uses writeout-only flushes to stage multiple
+  updates in the disk writeback cache and then a single full fsync to trigger
+  the disk cache flush at the end of the operation. This mode is expected to
+  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
+  and on Windows for repos stored on NTFS or ReFS filesystems.
 
 core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 93b1dc5138a..5c13fe17802 100644
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
@@ -80,6 +86,34 @@ clear_exit:
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
@@ -274,6 +308,24 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	return 0;
 }
 
+void fsync_loose_object_bulk_checkin(int fd)
+{
+	/*
+	 * If we have a plugged bulk checkin, we issue a call that
+	 * cleans the filesystem page cache but avoids a hardware flush
+	 * command. Later on we will issue a single hardware flush
+	 * before as part of do_batch_fsync.
+	 */
+	if (bulk_checkin_plugged &&
+	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
+		assert(bulk_fsync_objdir);
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
@@ -288,6 +340,19 @@ int index_bulk_checkin(struct object_id *oid,
 void plug_bulk_checkin(void)
 {
 	assert(!bulk_checkin_plugged);
+
+	/*
+	 * A temporary object directory is used to hold the files
+	 * while they are not fsynced.
+	 */
+	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT)) {
+		bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
+		if (!bulk_fsync_objdir)
+			die(_("Could not create temporary object directory for core.fsyncobjectfiles=batch"));
+
+		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
+	}
+
 	bulk_checkin_plugged = 1;
 }
 
@@ -297,4 +362,6 @@ void unplug_bulk_checkin(void)
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
index d347d0757f7..4d07691e791 100644
--- a/cache.h
+++ b/cache.h
@@ -1040,7 +1040,8 @@ extern int use_fsync;
 
 enum fsync_method {
 	FSYNC_METHOD_FSYNC,
-	FSYNC_METHOD_WRITEOUT_ONLY
+	FSYNC_METHOD_WRITEOUT_ONLY,
+	FSYNC_METHOD_BATCH
 };
 
 extern enum fsync_method fsync_method;
@@ -1766,6 +1767,11 @@ void fsync_or_die(int fd, const char *);
 int fsync_component(enum fsync_component component, int fd);
 void fsync_component_or_die(enum fsync_component component, int fd, const char *msg);
 
+static inline int batch_fsync_enabled(enum fsync_component component)
+{
+	return (fsync_components & component) && (fsync_method == FSYNC_METHOD_BATCH);
+}
+
 ssize_t read_in_full(int fd, void *buf, size_t count);
 ssize_t write_in_full(int fd, const void *buf, size_t count);
 ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
diff --git a/config.c b/config.c
index 261ee7436e0..0b28f90de8b 100644
--- a/config.c
+++ b/config.c
@@ -1688,6 +1688,8 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 			fsync_method = FSYNC_METHOD_FSYNC;
 		else if (!strcmp(value, "writeout-only"))
 			fsync_method = FSYNC_METHOD_WRITEOUT_ONLY;
+		else if (!strcmp(value, "batch"))
+			fsync_method = FSYNC_METHOD_BATCH;
 		else
 			warning(_("ignoring unknown core.fsyncMethod value '%s'"), value);
 
diff --git a/object-file.c b/object-file.c
index 295cb899e22..ef6621ffe56 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1894,6 +1894,8 @@ static void close_loose_object(int fd)
 
 	if (fsync_object_files > 0)
 		fsync_or_die(fd, "loose object file");
+	else if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
+		fsync_loose_object_bulk_checkin(fd);
 	else
 		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
 				       "loose object file");
-- 
gitgitgadget

