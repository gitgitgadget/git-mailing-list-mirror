Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FB8C433EF
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 07:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244962AbiCTHRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 03:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244949AbiCTHR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 03:17:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA86C3375
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q8so5537322wrc.0
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=16fGogxRiNpspSikcOkYASZA8LjPVjdCiOcmMw+Ogr4=;
        b=KdXV9UrIMY2vDQUVEaIa95H6/cdYypWQofyq/IV8WHZx9WeQSKYQZb+V3aVidtzdZC
         mcqmP8DpCzNc1NDqjjTWcslRNqix4oBCHHD2ShfbguzBYoFh6bQnJL1cv/0Zb0zpPgtV
         14y15gvx3ICoSFgSsVDQcS2quYLzV8f+VzrJl44zEbIQMD2+x1afDROj7YtHWpJjbJnH
         jahiPIsu8BNj5q0INBX7D1IlSUKIhuvF6NmswFB6ApzjFAMF3vSMrTMUMokkHELG9rOP
         O/UnBoVGKyl8FnR2IL593LqFIMTwtlJ4PhmutlzWAgjITo4T1pKvORpNuJ9VzWKLHa+D
         7Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=16fGogxRiNpspSikcOkYASZA8LjPVjdCiOcmMw+Ogr4=;
        b=2VV1MlBDidgt0DrV2C7wksz9WWI3yWqEi/7vLf7IUccrI01nF0tHvrULVfdJMx20oJ
         Zr83T98vphJCLrnp2DygFDeBINK4GUaLp0lWn4P5YSeke5tKIYpgzj+gEO58H3YaueVn
         Ihi7fo9hlBH9FtNa51PDQU6rZX0VD+gtuX1sLh30eSxKCWiShjKEx+8HafEIAeO+n3xu
         pyEuEKq9LavaHMsBjnAIdJA8PNdc7hnlNFr+6wYCbuT6Mnb81TqfllZsu127CPNa99+c
         +NQPp/pwBrDun6k3LWbiaKqUVB+1z4+caSVM4XDUoMCNFQDifAQCa7JMxLD8+Sf+LYrN
         +2xQ==
X-Gm-Message-State: AOAM532mXXs1zdEROLNhjTaykqr3FOAgKqMfTXoErsPzbVje3mGyTuZZ
        nlVTkN/BzivrobDy5Tr/9VXqri4ZD+U=
X-Google-Smtp-Source: ABdhPJy+VMPLOXsaCckQzjaKadvxSz7juFZT3M3TjpHB5ND5KFBpYeb0HEob+C0BW9EvBMwl4lm+xg==
X-Received: by 2002:a05:6000:144c:b0:1f1:f24b:a70b with SMTP id v12-20020a056000144c00b001f1f24ba70bmr14185151wrx.541.1647760564731;
        Sun, 20 Mar 2022 00:16:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d628c000000b00203e2fbb2absm9311683wru.113.2022.03.20.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 00:16:04 -0700 (PDT)
Message-Id: <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 07:15:55 +0000
Subject: [PATCH v2 2/7] core.fsyncmethod: batched disk flushes for
 loose-objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
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
 Documentation/config/core.txt |  7 ++++
 bulk-checkin.c                | 70 +++++++++++++++++++++++++++++++++++
 bulk-checkin.h                |  2 +
 cache.h                       |  8 +++-
 config.c                      |  2 +
 object-file.c                 |  2 +
 6 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 889522956e4..a3798dfc334 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -628,6 +628,13 @@ core.fsyncMethod::
 * `writeout-only` issues pagecache writeback requests, but depending on the
   filesystem and storage hardware, data added to the repository may not be
   durable in the event of a system crash. This is the default mode on macOS.
+* `batch` enables a mode that uses writeout-only flushes to stage multiple
+  updates in the disk writeback cache and then does a single full fsync of
+  a dummy file to trigger the disk cache flush at the end of the operation.
+  Currently `batch` mode only applies to loose-object files. Other repository
+  data is made durable as if `fsync` was specified. This mode is expected to
+  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
+  and on Windows for repos stored on NTFS or ReFS filesystems.
 
 core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 93b1dc5138a..a702e0ff203 100644
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
@@ -80,6 +86,37 @@ clear_exit:
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
+		needs_batch_fsync = 0;
+	}
+
+	if (bulk_fsync_objdir) {
+		tmp_objdir_migrate(bulk_fsync_objdir);
+		bulk_fsync_objdir = NULL;
+	}
+}
+
 static int already_written(struct bulk_checkin_state *state, struct object_id *oid)
 {
 	int i;
@@ -274,6 +311,24 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
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
@@ -288,6 +343,19 @@ int index_bulk_checkin(struct object_id *oid,
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
 
@@ -297,4 +365,6 @@ void unplug_bulk_checkin(void)
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
index 3160bc1e489..d1ae51388c9 100644
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
@@ -1767,6 +1768,11 @@ void fsync_or_die(int fd, const char *);
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
index 5258d9ed827..bdb0a38328f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1895,6 +1895,8 @@ static void close_loose_object(int fd)
 
 	if (fsync_object_files > 0)
 		fsync_or_die(fd, "loose object file");
+	else if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
+		fsync_loose_object_bulk_checkin(fd);
 	else
 		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
 				       "loose object file");
-- 
gitgitgadget

