Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B759C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453D66108B
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348388AbhIXUNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345767AbhIXUNs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 16:13:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61637C061613
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t8so30869313wrq.4
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z8vxV+Rk/MjXh249xjj2CHwv3/SS9llPQuvzrGSKSlI=;
        b=naSHAaJEe2+PUkUV3W7FOm9PRjozVQYJ+tj026FZzb6DXVvDqKawt4XZbbJbYiyYP6
         cziebQzN10dQKQLFlAg/uH0245Dd7VA3wPDpv0QLzCrzkUJrNvQG11AbCrSgPQtu+U6s
         Tvyp5gp70wWRISeZWF6CvChd61WSKy5e/aPdvzoyXLtMtBPu/xigtJbNfpd7+sfshMWr
         3w81dmqPw84b91SpG+6AYUmJT8mvGv/ZhMhNcDSMc3ShujpWW65qoi69x3mLP338qAbK
         wlRvxjWeAkFdRe6JHhRgpcd/pV7/wlXkIW4n5e6JZN5VnrloQuyrI0zc4KBqEHrZ8GDH
         fP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z8vxV+Rk/MjXh249xjj2CHwv3/SS9llPQuvzrGSKSlI=;
        b=uhnmTPLYzYIl+P2lJLDKq/A/mE/DyEkLFUXqeawqxJIj9pL9S2x/+DHQAb+PqjYWzA
         xfV2FODTQIoceOV8DE/tmvA4uCua0yd0iffPkglAxsI9xPu4tMDNVPr9DMqFcTWHlYkn
         xeTr+laC3KMmZu/jXSPXEVT0OYjjugwoyH/S5UZwY7KXJKsc8IBKlIcFZRG1OvLNk4Wa
         OHXAULHkPP3GWWVrXGyeUUmT6t7E6pS6Vkf2c5XYxvuB34TqQiK3OQJASmWR1anuaIjQ
         EZS9mIw4jYD6Up/0pf4uc/YaoMyZaoxAqkYmC3Jeg/Idrhl3gsYCgO/Rc+yaj7sxQlFA
         GjNA==
X-Gm-Message-State: AOAM533ogG9Um5af91dIO4fmLEh7HdzU0K7JJbAlSGsjzrOCjga6Illm
        RtsCnSbY5MUBKjjzDsx2Bipe/iSjZgU=
X-Google-Smtp-Source: ABdhPJyZe7lXReKktz8CgRLVoYrLZpsVtx+9PPQvUCtbkc2YWHzr/7CekHioxDkZRZtL6t/TaWRKcQ==
X-Received: by 2002:adf:b348:: with SMTP id k8mr13529309wrd.123.1632514332469;
        Fri, 24 Sep 2021 13:12:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9sm118951wrv.82.2021.09.24.13.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:12:12 -0700 (PDT)
Message-Id: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
References: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 20:12:04 +0000
Subject: [PATCH v5 0/7] Implement a batched fsync option for core.fsyncObjectFiles
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
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to everyone for review so far! Changes since v4, all in response to
review feedback from Ævar Arnfjörð Bjarmason:

 * Update core.fsyncobjectfiles documentation to specify 'loose' objects and
   to add a statement about not fsyncing parent directories.
   
   * I still don't want to make any promises on behalf of the Linux FS developers
     in the documentation. However, according to [v4.1] and my understanding
     of how XFS journals are documented to work, it looks like recent versions
     of Linux running on XFS should be as safe as Windows or macOS in 'batch'
     mode. I don't know about ext4, since it's not clear to me when metadata
     updates are made visible to the journal.
   

 * Rewrite the core batched fsync change to use the tmp-objdir lib. As Ævar
   pointed out, this lets us access the added loose objects immediately,
   rather than only after unplugging the bulk checkin. This is a hard
   requirement in unpack-objects for resolving OBJ_REF_DELTA packed objects.
   
   * As a preparatory patch, the object-file code now doesn't do a rename if it's in a
     tmp objdir (as determined by the quarantine environment variable).
   
   * I added support to the tmp-objdir lib to replace the 'main' writable odb.
   
   * Instead of using a lockfile for the final full fsync, we now use a new dummy
     temp file. Doing that makes the below unpack-objects change easier.
   

 * Add bulk-checkin support to unpack-objects, which is used in fetch and
   push. In addition to making those operations faster, it allows us to
   directly compare performance of packfiles against loose objects. Please
   see [v4.2] for a measurement of 'git push' to a local upstream with
   different numbers of unique new files.

 * Rename FSYNC_OBJECT_FILES_MODE to fsync_object_files_mode.

 * Remove comment with link to NtFlushBuffersFileEx documentation.

 * Make t/lib-unique-files.sh a bit cleaner. We are still creating unique
   contents, but now this uses test_tick, so it should be deterministic from
   run to run.

 * Ensure there are tests for all of the modified commands. Make the
   unpack-objects tests validate that the unpacked objects are really
   available in the ODB.

References for v4: [v4.1]
https://lore.kernel.org/linux-fsdevel/20190419072938.31320-1-amir73il@gmail.com/#t

[v4.2]
https://docs.google.com/spreadsheets/d/1uxMBkEXFFnQ1Y3lXKqcKpw6Mq44BzhpCAcPex14T-QQ/edit#gid=1898936117

Changes since v3:

 * Fix core.fsyncobjectfiles option parsing as suggested by Junio: We now
   accept no value to mean "true" and we require 'batch' to be lowercase.

 * Leave the default fsync mode as 'false'. Git for windows can change its
   default when this series makes it over to that fork.

 * Use a switch statement in git_fsync, as suggested by Junio.

 * Add regression test cases for core.fsyncobjectfiles=batch. This should
   keep the batch functionality basically working in upstream git even if
   few users adopt batch mode initially. I expect git-for-windows will
   provide a good baking area for the new mode.

Neeraj Singh (7):
  object-file.c: do not rename in a temp odb
  bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  core.fsyncobjectfiles: batched disk flushes
  update-index: use the bulk-checkin infrastructure
  unpack-objects: use the bulk-checkin infrastructure
  core.fsyncobjectfiles: tests for batch mode
  core.fsyncobjectfiles: performance tests for add and stash

 Documentation/config/core.txt |  29 +++++++--
 Makefile                      |   6 ++
 builtin/add.c                 |   1 +
 builtin/unpack-objects.c      |   3 +
 builtin/update-index.c        |   6 ++
 bulk-checkin.c                |  92 +++++++++++++++++++++++---
 bulk-checkin.h                |   2 +
 cache.h                       |   8 ++-
 config.c                      |   7 +-
 config.mak.uname              |   1 +
 configure.ac                  |   8 +++
 environment.c                 |   6 +-
 git-compat-util.h             |   7 ++
 object-file.c                 | 118 +++++++++++++++++++++++++++++-----
 object-store.h                |  22 +++++++
 object.c                      |   2 +-
 repository.c                  |   2 +
 repository.h                  |   1 +
 t/lib-unique-files.sh         |  36 +++++++++++
 t/perf/p3700-add.sh           |  43 +++++++++++++
 t/perf/p3900-stash.sh         |  46 +++++++++++++
 t/t3700-add.sh                |  20 ++++++
 t/t3903-stash.sh              |  14 ++++
 t/t5300-pack-object.sh        |  30 +++++----
 tmp-objdir.c                  |  20 +++++-
 tmp-objdir.h                  |   6 ++
 wrapper.c                     |  44 +++++++++++++
 write-or-die.c                |   2 +-
 28 files changed, 532 insertions(+), 50 deletions(-)
 create mode 100644 t/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh


base-commit: 8b7c11b8668b4e774f81a9f0b4c30144b818f1d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1076%2Fneerajsi-msft%2Fneerajsi%2Fbulk-fsync-object-files-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1076/neerajsi-msft/neerajsi/bulk-fsync-object-files-v5
Pull-Request: https://github.com/git/git/pull/1076

Range-diff vs v4:

 -:  ----------- > 1:  95315f35a28 object-file.c: do not rename in a temp odb
 1:  d5893e28df1 = 2:  df6fab94d67 bulk-checkin: rename 'state' variable and separate 'plugged' boolean
 2:  12cad737635 ! 3:  fe19cdfc930 core.fsyncobjectfiles: batched disk flushes
     @@ Commit message
      
          One major source of the cost of fsync is the implied flush of the
          hardware writeback cache within the disk drive. Fortunately, Windows,
     -    macOS, and Linux each offer mechanisms to write data from the filesystem
     -    page cache without initiating a hardware flush.
     +    and macOS offer mechanisms to write data from the filesystem page cache
     +    without initiating a hardware flush. Linux has the sync_file_range API,
     +    which issues a pagecache writeback request reliably after version 5.2.
      
          This patch introduces a new 'core.fsyncObjectFiles = batch' option that
     -    takes advantage of the bulk-checkin infrastructure to batch up hardware
     -    flushes.
     +    batches up hardware flushes. It hooks into the bulk-checkin plugging and
     +    unplugging functionality and takes advantage of tmp-objdir.
      
     -    When the new mode is enabled we do the following for new objects:
     -
     -    1. Create a tmp_obj_XXXX file and write the object data to it.
     +    When the new mode is enabled we do the following for each new object:
     +    1. Create the object in a tmp-objdir.
          2. Issue a pagecache writeback request and wait for it to complete.
     -    3. Record the tmp name and the final name in the bulk-checkin state for
     -       later rename.
      
     -    At the end of the entire transaction we:
     -    1. Issue a fsync against the lock file to flush the hardware writeback
     -       cache, which should by now have processed the tmp file writes.
     -    2. Rename all of the temp files to their final names.
     +    At the end of the entire transaction when unplugging bulk checkin we:
     +    1. Issue an fsync against a dummy file to flush the hardware writeback
     +       cache, which should by now have processed the tmp-objdir writes.
     +    2. Rename all of the tmp-objdir files to their final names.
          3. When updating the index and/or refs, we assume that Git will issue
     -       another fsync internal to that operation.
     +       another fsync internal to that operation. This is not the case today,
     +       but may be a good extension to those components.
      
          On a filesystem with a singular journal that is updated during name
     -    operations (e.g. create, link, rename, etc), such as NTFS and HFS+, we
     +    operations (e.g. create, link, rename, etc), such as NTFS, HFS+, or XFS we
          would expect the fsync to trigger a journal writeout so that this
          sequence is enough to ensure that the user's data is durable by the time
          the git command returns.
     @@ Documentation/config/core.txt: core.whitespace::
      +	A value indicating the level of effort Git will expend in
      +	trying to make objects added to the repo durable in the event
      +	of an unclean system shutdown. This setting currently only
     -+	controls the object store, so updates to any refs or the
     -+	index may not be equally durable.
     ++	controls loose objects in the object store, so updates to any
     ++	refs or the index may not be equally durable.
      ++
      +* `false` allows data to remain in file system caches according to
      +  operating system policy, whence it may be lost if the system loses power
      +  or crashes.
     -+* `true` triggers a data integrity flush for each object added to the
     ++* `true` triggers a data integrity flush for each loose object added to the
      +  object store. This is the safest setting that is likely to ensure durability
      +  across all operating systems and file systems that honor the 'fsync' system
      +  call. However, this setting comes with a significant performance cost on
     -+  common hardware.
     ++  common hardware. Git does not currently fsync parent directories for
     ++  newly-added files, so some filesystems may still allow data to be lost on
     ++  system crash.
      +* `batch` enables an experimental mode that uses interfaces available in some
     -+  operating systems to write object data with a minimal set of FLUSH CACHE
     -+  (or equivalent) commands sent to the storage controller. If the operating
     -+  system interfaces are not available, this mode behaves the same as `true`.
     -+  This mode is expected to be safe on macOS for repos stored on HFS+ or APFS
     -+  filesystems and on Windows for repos stored on NTFS or ReFS.
     ++  operating systems to write loose object data with a minimal set of FLUSH
     ++  CACHE (or equivalent) commands sent to the storage controller. If the
     ++  operating system interfaces are not available, this mode behaves the same as
     ++  `true`. This mode is expected to be as safe as `true` on macOS for repos
     ++  stored on HFS+ or APFS filesystems and on Windows for repos stored on NTFS or
     ++  ReFS.
       
       core.preloadIndex::
       	Enable parallel index preload for operations like 'git diff'
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
       
       	if (chmod_arg && pathspec.nr)
       		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
     --	unplug_bulk_checkin();
      +
     -+	unplug_bulk_checkin(&lock_file);
     + 	unplug_bulk_checkin();
       
       finish:
     - 	if (write_locked_index(&the_index, &lock_file,
      
       ## bulk-checkin.c ##
      @@
     @@ bulk-checkin.c
       #include "pack.h"
       #include "strbuf.h"
      +#include "string-list.h"
     ++#include "tmp-objdir.h"
       #include "packfile.h"
       #include "object-store.h"
       
       static int bulk_checkin_plugged;
     - 
     -+static struct string_list bulk_fsync_state = STRING_LIST_INIT_DUP;
     ++static int needs_batch_fsync;
      +
     ++static struct tmp_objdir *bulk_fsync_objdir;
     + 
       static struct bulk_checkin_state {
       	char *pack_tmp_name;
     - 	struct hashfile *f;
      @@ bulk-checkin.c: clear_exit:
       	reprepare_packed_git(the_repository);
       }
       
     -+static void do_sync_and_rename(struct string_list *fsync_state, struct lock_file *lock_file)
     ++/*
     ++ * Cleanup after batch-mode fsync_object_files.
     ++ */
     ++static void do_batch_fsync(void)
      +{
     -+	if (fsync_state->nr) {
     -+		struct string_list_item *rename;
     -+
     -+		/*
     -+		 * Issue a full hardware flush against the lock file to ensure
     -+		 * that all objects are durable before any renames occur.
     -+		 * The code in fsync_and_close_loose_object_bulk_checkin has
     -+		 * already ensured that writeout has occurred, but it has not
     -+		 * flushed any writeback cache in the storage hardware.
     -+		 */
     -+		fsync_or_die(get_lock_file_fd(lock_file), get_lock_file_path(lock_file));
     -+
     -+		for_each_string_list_item(rename, fsync_state) {
     -+			const char *src = rename->string;
     -+			const char *dst = rename->util;
     -+
     -+			if (finalize_object_file(src, dst))
     -+				die_errno(_("could not rename '%s' to '%s'"), src, dst);
     -+		}
     -+
     -+		string_list_clear(fsync_state, 1);
     ++	/*
     ++	 * Issue a full hardware flush against a temporary file to ensure
     ++	 * that all objects are durable before any renames occur.  The code in
     ++	 * fsync_loose_object_bulk_checkin has already issued a writeout
     ++	 * request, but it has not flushed any writeback cache in the storage
     ++	 * hardware.
     ++	 */
     ++
     ++	if (needs_batch_fsync) {
     ++		struct strbuf temp_path = STRBUF_INIT;
     ++		struct tempfile *temp;
     ++
     ++		strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_directory());
     ++		temp = xmks_tempfile(temp_path.buf);
     ++		fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
     ++		delete_tempfile(&temp);
     ++		strbuf_release(&temp_path);
      +	}
     ++
     ++	if (bulk_fsync_objdir)
     ++		tmp_objdir_migrate(bulk_fsync_objdir);
      +}
      +
       static int already_written(struct bulk_checkin_state *state, struct object_id *oid)
     @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
       	return 0;
       }
       
     -+static void add_rename_bulk_checkin(struct string_list *fsync_state,
     -+				    const char *src, const char *dst)
     ++void fsync_loose_object_bulk_checkin(int fd)
      +{
     -+	string_list_insert(fsync_state, src)->util = xstrdup(dst);
     -+}
     -+
     -+int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpfile,
     -+					      const char *filename, time_t mtime)
     -+{
     -+	int do_finalize = 1;
     -+	int ret = 0;
     -+
     -+	if (fsync_object_files != FSYNC_OBJECT_FILES_OFF) {
     -+		/*
     -+		 * If we have a plugged bulk checkin, we issue a call that
     -+		 * cleans the filesystem page cache but avoids a hardware flush
     -+		 * command. Later on we will issue a single hardware flush
     -+		 * before renaming files as part of do_sync_and_rename.
     -+		 */
     -+		if (bulk_checkin_plugged &&
     -+		    fsync_object_files == FSYNC_OBJECT_FILES_BATCH &&
     -+		    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
     -+			add_rename_bulk_checkin(&bulk_fsync_state, tmpfile, filename);
     -+			do_finalize = 0;
     -+
     -+		} else {
     -+			fsync_or_die(fd, "loose object file");
     -+		}
     -+	}
     -+
     -+	if (close(fd))
     -+		die_errno(_("error when closing loose object file"));
     -+
     -+	if (mtime) {
     -+		struct utimbuf utb;
     -+		utb.actime = mtime;
     -+		utb.modtime = mtime;
     -+		if (utime(tmpfile, &utb) < 0)
     -+			warning_errno(_("failed utime() on %s"), tmpfile);
     ++	assert(fsync_object_files == FSYNC_OBJECT_FILES_BATCH);
     ++
     ++	/*
     ++	 * If we have a plugged bulk checkin, we issue a call that
     ++	 * cleans the filesystem page cache but avoids a hardware flush
     ++	 * command. Later on we will issue a single hardware flush
     ++	 * before as part of do_batch_fsync.
     ++	 */
     ++	if (bulk_checkin_plugged &&
     ++	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
     ++		assert(the_repository->objects->odb->is_temp);
     ++		if (!needs_batch_fsync)
     ++			needs_batch_fsync = 1;
     ++	} else {
     ++		fsync_or_die(fd, "loose object file");
      +	}
     -+
     -+	if (do_finalize)
     -+		ret = finalize_object_file(tmpfile, filename);
     -+
     -+	return ret;
      +}
      +
       int index_bulk_checkin(struct object_id *oid,
       		       int fd, size_t size, enum object_type type,
       		       const char *path, unsigned flags)
     -@@ bulk-checkin.c: void plug_bulk_checkin(void)
     +@@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
     + void plug_bulk_checkin(void)
     + {
     + 	assert(!bulk_checkin_plugged);
     ++
     ++	/*
     ++	 * Create a temporary object directory if the current
     ++	 * object directory is not already temporary.
     ++	 */
     ++	if (fsync_object_files == FSYNC_OBJECT_FILES_BATCH &&
     ++	    !the_repository->objects->odb->is_temp) {
     ++		bulk_fsync_objdir = tmp_objdir_create();
     ++		if (!bulk_fsync_objdir)
     ++			die(_("Could not create temporary object directory for core.fsyncobjectfiles=batch"));
     ++
     ++		tmp_objdir_replace_main_odb(bulk_fsync_objdir);
     ++	}
     ++
       	bulk_checkin_plugged = 1;
       }
       
     --void unplug_bulk_checkin(void)
     -+void unplug_bulk_checkin(struct lock_file *lock_file)
     - {
     - 	assert(bulk_checkin_plugged);
     +@@ bulk-checkin.c: void unplug_bulk_checkin(void)
       	bulk_checkin_plugged = 0;
       	if (bulk_checkin_state.f)
       		finish_bulk_checkin(&bulk_checkin_state);
      +
     -+	do_sync_and_rename(&bulk_fsync_state, lock_file);
     ++	do_batch_fsync();
       }
      
       ## bulk-checkin.h ##
     @@ bulk-checkin.h
       
       #include "cache.h"
       
     -+int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpfile,
     -+					      const char *filename, time_t mtime);
     ++void fsync_loose_object_bulk_checkin(int fd);
      +
       int index_bulk_checkin(struct object_id *oid,
       		       int fd, size_t size, enum object_type type,
       		       const char *path, unsigned flags);
     - 
     - void plug_bulk_checkin(void);
     --void unplug_bulk_checkin(void);
     -+void unplug_bulk_checkin(struct lock_file *);
     - 
     - #endif
      
       ## cache.h ##
      @@ cache.h: void reset_shared_repository(void);
     @@ cache.h: void reset_shared_repository(void);
       extern char *git_replace_ref_base;
       
      -extern int fsync_object_files;
     -+enum FSYNC_OBJECT_FILES_MODE {
     ++enum fsync_object_files_mode {
      +    FSYNC_OBJECT_FILES_OFF,
      +    FSYNC_OBJECT_FILES_ON,
      +    FSYNC_OBJECT_FILES_BATCH
      +};
      +
     -+extern enum FSYNC_OBJECT_FILES_MODE fsync_object_files;
     ++extern enum fsync_object_files_mode fsync_object_files;
       extern int core_preload_index;
       extern int precomposed_unicode;
       extern int protect_hfs;
     @@ environment.c: const char *git_hooks_path;
       int core_compression_level;
       int pack_compression_level = Z_DEFAULT_COMPRESSION;
      -int fsync_object_files;
     -+enum FSYNC_OBJECT_FILES_MODE fsync_object_files;
     ++enum fsync_object_files_mode fsync_object_files;
       size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
       size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
       size_t delta_base_cache_limit = 96 * 1024 * 1024;
     @@ git-compat-util.h: __attribute__((format (printf, 1, 2))) NORETURN
        * Returns 0 on success, which includes trying to unlink an object that does
      
       ## object-file.c ##
     -@@ object-file.c: int hash_object_file(const struct git_hash_algo *algo, const void *buf,
     - 	return 0;
     +@@ object-file.c: void add_to_alternates_memory(const char *reference)
     + 			     '\n', NULL, 0);
       }
       
     --/* Finalize a file on disk, and close it. */
     --static void close_loose_object(int fd)
     --{
     ++struct object_directory *set_temporary_main_odb(const char *dir)
     ++{
     ++	struct object_directory *main_odb, *new_odb, *old_next;
     ++
     ++	/*
     ++	 * Make sure alternates are initialized, or else our entry may be
     ++	 * overwritten when they are.
     ++	 */
     ++	prepare_alt_odb(the_repository);
     ++
     ++	/* Copy the existing object directory and make it an alternate. */
     ++	main_odb = the_repository->objects->odb;
     ++	new_odb = xmalloc(sizeof(*new_odb));
     ++	*new_odb = *main_odb;
     ++	*the_repository->objects->odb_tail = new_odb;
     ++	the_repository->objects->odb_tail = &(new_odb->next);
     ++	new_odb->next = NULL;
     ++
     ++	/*
     ++	 * Reinitialize the main odb with the specified path, being careful
     ++	 * to keep the next pointer value.
     ++	 */
     ++	old_next = main_odb->next;
     ++	memset(main_odb, 0, sizeof(*main_odb));
     ++	main_odb->next = old_next;
     ++	main_odb->is_temp = 1;
     ++	main_odb->path = xstrdup(dir);
     ++	return new_odb;
     ++}
     ++
     ++void restore_main_odb(struct object_directory *odb)
     ++{
     ++	struct object_directory **prev, *main_odb;
     ++
     ++	/* Unlink the saved previous main ODB from the list. */
     ++	prev = &the_repository->objects->odb->next;
     ++	assert(*prev);
     ++	while (*prev != odb) {
     ++		prev = &(*prev)->next;
     ++	}
     ++	*prev = odb->next;
     ++	if (*prev == NULL)
     ++		the_repository->objects->odb_tail = prev;
     ++
     ++	/*
     ++	 * Restore the data from the old main odb, being careful to
     ++	 * keep the next pointer value
     ++	 */
     ++	main_odb = the_repository->objects->odb;
     ++	SWAP(*main_odb, *odb);
     ++	main_odb->next = odb->next;
     ++	free_object_directory(odb);
     ++}
     ++
     + /*
     +  * Compute the exact path an alternate is at and returns it. In case of
     +  * error NULL is returned and the human readable error is added to `err`
     +@@ object-file.c: int hash_object_file(const struct git_hash_algo *algo, const void *buf,
     + /* Finalize a file on disk, and close it. */
     + static void close_loose_object(int fd)
     + {
      -	if (fsync_object_files)
     --		fsync_or_die(fd, "loose object file");
     --	if (close(fd) != 0)
     --		die_errno(_("error when closing loose object file"));
     --}
     --
     - /* Size of directory component, including the ending '/' */
     - static inline int directory_size(const char *filename)
     ++	switch (fsync_object_files) {
     ++	case FSYNC_OBJECT_FILES_OFF:
     ++		break;
     ++	case FSYNC_OBJECT_FILES_ON:
     + 		fsync_or_die(fd, "loose object file");
     ++		break;
     ++	case FSYNC_OBJECT_FILES_BATCH:
     ++		fsync_loose_object_bulk_checkin(fd);
     ++		break;
     ++	default:
     ++		BUG("Invalid fsync_object_files mode.");
     ++	}
     ++
     + 	if (close(fd) != 0)
     + 		die_errno(_("error when closing loose object file"));
     + }
     +
     + ## object-store.h ##
     +@@ object-store.h: void add_to_alternates_file(const char *dir);
     +  */
     + void add_to_alternates_memory(const char *dir);
     + 
     ++/*
     ++ * Replace the current main object directory with the specified temporary
     ++ * object directory. We make a copy of the former main object directory,
     ++ * add it as an in-memory alternate, and return the copy so that it can
     ++ * be restored via restore_main_odb.
     ++ */
     ++struct object_directory *set_temporary_main_odb(const char *dir);
     ++
     ++/*
     ++ * Restore a previous ODB replaced by set_temporary_main_odb.
     ++ */
     ++void restore_main_odb(struct object_directory *odb);
     ++
     + /*
     +  * Populate and return the loose object cache array corresponding to the
     +  * given object ID.
     +@@ object-store.h: struct oidtree *odb_loose_cache(struct object_directory *odb,
     + /* Empty the loose object cache for the specified object directory. */
     + void odb_clear_loose_cache(struct object_directory *odb);
     + 
     ++/* Clear and free the specified object directory */
     ++void free_object_directory(struct object_directory *odb);
     ++
     + struct packed_git {
     + 	struct hashmap_entry packmap_ent;
     + 	struct packed_git *next;
     +
     + ## object.c ##
     +@@ object.c: struct raw_object_store *raw_object_store_new(void)
     + 	return o;
     + }
     + 
     +-static void free_object_directory(struct object_directory *odb)
     ++void free_object_directory(struct object_directory *odb)
       {
     -@@ object-file.c: static int write_loose_object(const struct object_id *oid, char *hdr,
     - 		die(_("confused by unstable object source data for %s"),
     - 		    oid_to_hex(oid));
     + 	free(odb->path);
     + 	odb_clear_loose_cache(odb);
     +
     + ## tmp-objdir.c ##
     +@@
     + struct tmp_objdir {
     + 	struct strbuf path;
     + 	struct strvec env;
     ++	struct object_directory *prev_main_odb;
     + };
       
     --	close_loose_object(fd);
     --
     --	if (mtime) {
     --		struct utimbuf utb;
     --		utb.actime = mtime;
     --		utb.modtime = mtime;
     --		if (utime(tmp_file.buf, &utb) < 0)
     --			warning_errno(_("failed utime() on %s"), tmp_file.buf);
     --	}
     --
     --	return finalize_object_file(tmp_file.buf, filename.buf);
     -+	return fsync_and_close_loose_object_bulk_checkin(fd, tmp_file.buf,
     -+							 filename.buf, mtime);
     + /*
     +@@ tmp-objdir.c: static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
     + 	 * freeing memory; it may cause a deadlock if the signal
     + 	 * arrived while libc's allocator lock is held.
     + 	 */
     +-	if (!on_signal)
     ++	if (!on_signal) {
     ++		if (t->prev_main_odb)
     ++			restore_main_odb(t->prev_main_odb);
     + 		tmp_objdir_free(t);
     ++	}
     ++
     + 	return err;
       }
       
     - static int freshen_loose_object(const struct object_id *oid)
     +@@ tmp-objdir.c: struct tmp_objdir *tmp_objdir_create(void)
     + 	t = xmalloc(sizeof(*t));
     + 	strbuf_init(&t->path, 0);
     + 	strvec_init(&t->env);
     ++	t->prev_main_odb = NULL;
     + 
     + 	strbuf_addf(&t->path, "%s/incoming-XXXXXX", get_object_directory());
     + 
     +@@ tmp-objdir.c: int tmp_objdir_migrate(struct tmp_objdir *t)
     + 	if (!t)
     + 		return 0;
     + 
     ++	if (t->prev_main_odb) {
     ++		restore_main_odb(t->prev_main_odb);
     ++		t->prev_main_odb = NULL;
     ++	}
     ++
     + 	strbuf_addbuf(&src, &t->path);
     + 	strbuf_addstr(&dst, get_object_directory());
     + 
     +@@ tmp-objdir.c: void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
     + {
     + 	add_to_alternates_memory(t->path.buf);
     + }
     ++
     ++void tmp_objdir_replace_main_odb(struct tmp_objdir *t)
     ++{
     ++	if (t->prev_main_odb)
     ++		BUG("the main object database is already replaced");
     ++	t->prev_main_odb = set_temporary_main_odb(t->path.buf);
     ++}
     +
     + ## tmp-objdir.h ##
     +@@ tmp-objdir.h: int tmp_objdir_destroy(struct tmp_objdir *);
     +  */
     + void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
     + 
     ++/*
     ++ * Replaces the main object store in the current process with the temporary
     ++ * object directory and makes the former main object store an alternate.
     ++ */
     ++void tmp_objdir_replace_main_odb(struct tmp_objdir *);
     ++
     + #endif /* TMP_OBJDIR_H */
      
       ## wrapper.c ##
      @@ wrapper.c: int xmkstemp_mode(char *filename_template, int mode)
 3:  a5b3e21b762 < -:  ----------- core.fsyncobjectfiles: add windows support for batch mode
 4:  f7f756f3932 ! 4:  485b4a767df update-index: use the bulk-checkin infrastructure
     @@ Commit message
          There is some risk with this change, since under batch fsync, the object
          files will not be available until the update-index is entirely complete.
          This usage is unlikely, since any tool invoking update-index and
     -    expecting to see objects would have to snoop the output of --verbose to
     -    find out when update-index has actually processed a given path.
     -    Additionally the index is locked for the duration of the update.
     +    expecting to see objects would have to synchronize with the update-index
     +    process after passing it a file path.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     @@ builtin/update-index.c
       #include "lockfile.h"
       #include "quote.h"
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     - 		struct strbuf unquoted = STRBUF_INIT;
       
     - 		setup_work_tree();
     -+		plug_bulk_checkin();
     - 		while (getline_fn(&buf, stdin) != EOF) {
     - 			char *p;
     - 			if (!nul_term_line && buf.buf[0] == '"') {
     + 	the_index.updated_skipworktree = 1;
     + 
     ++	/* we might be adding many objects to the object database */
     ++	plug_bulk_checkin();
     ++
     + 	/*
     + 	 * Custom copy of parse_options() because we want to handle
     + 	 * filename arguments as they come.
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     - 				chmod_path(set_executable_bit, p);
     - 			free(p);
     - 		}
     -+		unplug_bulk_checkin(&lock_file);
     - 		strbuf_release(&unquoted);
       		strbuf_release(&buf);
       	}
     + 
     ++	/* by now we must have added all of the new objects */
     ++	unplug_bulk_checkin();
     + 	if (split_index > 0) {
     + 		if (git_config_get_split_index() == 0)
     + 			warning(_("core.splitIndex is set to false; "
 -:  ----------- > 5:  889e7668760 unpack-objects: use the bulk-checkin infrastructure
 5:  afb0028e796 ! 6:  0f2e3b25759 core.fsyncobjectfiles: tests for batch mode
     @@ Metadata
       ## Commit message ##
          core.fsyncobjectfiles: tests for batch mode
      
     -    Add test cases to exercise batch mode for 'git add'
     -    and 'git stash'. These tests ensure that the added
     -    data winds up in the object database.
     +    Add test cases to exercise batch mode for:
     +     * 'git add'
     +     * 'git stash'
     +     * 'git update-index'
     +     * 'git unpack-objects'
      
     -    I verified the tests by introducing an incorrect rename
     -    in do_sync_and_rename.
     +    These tests ensure that the added data winds up in the object database.
     +
     +    In this change we introduce a new test helper lib-unique-files.sh. The
     +    goal of this library is to create a tree of files that have different
     +    oids from any other files that may have been created in the current test
     +    repo. This helps us avoid missing validation of an object being added due
     +    to it already being in the repo.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     @@ t/lib-unique-files.sh (new)
      @@
      +# Helper to create files with unique contents
      +
     -+test_create_unique_files_base__=$(date -u)
     -+test_create_unique_files_counter__=0
      +
      +# Create multiple files with unique contents. Takes the number of
      +# directories, the number of files in each directory, and the base
      +# directory.
      +#
     -+# test_create_unique_files 2 3 . -- Creates 2 directories with 3 files
     -+#				    each in the specified directory, all
     -+#				    with unique contents.
     ++# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3 files
     ++#					 each in my_dir, all with unique
     ++#					 contents.
      +
      +test_create_unique_files() {
      +	test "$#" -ne 3 && BUG "3 param"
     @@ t/lib-unique-files.sh (new)
      +	local dirs=$1
      +	local files=$2
      +	local basedir=$3
     ++	local counter=0
     ++	test_tick
     ++	local basedata=$test_tick
     ++
      +
     -+	rm -rf $basedir >/dev/null
     ++	rm -rf $basedir
      +
      +	for i in $(test_seq $dirs)
      +	do
      +		local dir=$basedir/dir$i
      +
     -+		mkdir -p "$dir" > /dev/null
     ++		mkdir -p "$dir"
      +		for j in $(test_seq $files)
      +		do
     -+			test_create_unique_files_counter__=$((test_create_unique_files_counter__ + 1))
     -+			echo "$test_create_unique_files_base__.$test_create_unique_files_counter__"  >"$dir/file$j.txt"
     ++			counter=$((counter + 1))
     ++			echo "$basedata.$counter"  >"$dir/file$j.txt"
      +		done
      +	done
      +}
     @@ t/t3700-add.sh: test_expect_success \
      +	rm -f fsynced_files &&
      +	git ls-files --stage fsync-files/ > fsynced_files &&
      +	test_line_count = 8 fsynced_files &&
     -+	cat fsynced_files | awk '{print \$2}' | xargs -n1 git cat-file -e
     ++	awk -- '{print \$2}' fsynced_files | xargs -n1 git cat-file -e
     ++"
     ++
     ++test_expect_success 'git update-index: core.fsyncobjectfiles=batch' "
     ++	test_create_unique_files 2 4 fsync-files2 &&
     ++	find fsync-files2 ! -type d -print | xargs git -c core.fsyncobjectfiles=batch update-index --add -- &&
     ++	rm -f fsynced_files2 &&
     ++	git ls-files --stage fsync-files2/ > fsynced_files2 &&
     ++	test_line_count = 8 fsynced_files2 &&
     ++	awk -- '{print \$2}' fsynced_files2 | xargs -n1 git cat-file -e
      +"
      +
       test_expect_success \
     @@ t/t3903-stash.sh: test_expect_success 'stash handles skip-worktree entries nicel
      +	# which contains the untracked files
      +	git ls-tree -r stash^3 -- ./fsync-files/ > fsynced_files &&
      +	test_line_count = 8 fsynced_files &&
     -+	cat fsynced_files | awk '{print \$3}' | xargs -n1 git cat-file -e
     ++	awk -- '{print \$3}' fsynced_files | xargs -n1 git cat-file -e
      +"
      +
      +
       test_expect_success 'stash -c stash.useBuiltin=false warning ' '
       	expected="stash.useBuiltin support has been removed" &&
       
     +
     + ## t/t5300-pack-object.sh ##
     +@@ t/t5300-pack-object.sh: test_expect_success 'pack-objects with bogus arguments' '
     + 
     + check_unpack () {
     + 	test_when_finished "rm -rf git2" &&
     +-	git init --bare git2 &&
     +-	git -C git2 unpack-objects -n <"$1".pack &&
     +-	git -C git2 unpack-objects <"$1".pack &&
     +-	(cd .git && find objects -type f -print) |
     +-	while read path
     +-	do
     +-		cmp git2/$path .git/$path || {
     +-			echo $path differs.
     +-			return 1
     +-		}
     +-	done
     ++	git $2 init --bare git2 &&
     ++	(
     ++		git $2 -C git2 unpack-objects -n <"$1".pack &&
     ++		git $2 -C git2 unpack-objects <"$1".pack &&
     ++		git $2 -C git2 cat-file --batch-check="%(objectname)"
     ++	) <obj-list >current &&
     ++	cmp obj-list current
     + }
     + 
     + test_expect_success 'unpack without delta' '
     + 	check_unpack test-1-${packname_1}
     + '
     + 
     ++test_expect_success 'unpack without delta (core.fsyncobjectfiles=batch)' '
     ++	check_unpack test-1-${packname_1} "-c core.fsyncobjectfiles=batch"
     ++'
     ++
     + test_expect_success 'pack with REF_DELTA' '
     + 	packname_2=$(git pack-objects --progress test-2 <obj-list 2>stderr) &&
     + 	check_deltas stderr -gt 0
     +@@ t/t5300-pack-object.sh: test_expect_success 'unpack with REF_DELTA' '
     + 	check_unpack test-2-${packname_2}
     + '
     + 
     ++test_expect_success 'unpack with REF_DELTA (core.fsyncobjectfiles=batch)' '
     ++       check_unpack test-2-${packname_2} "-c core.fsyncobjectfiles=batch"
     ++'
     ++
     + test_expect_success 'pack with OFS_DELTA' '
     + 	packname_3=$(git pack-objects --progress --delta-base-offset test-3 \
     + 			<obj-list 2>stderr) &&
     +@@ t/t5300-pack-object.sh: test_expect_success 'unpack with OFS_DELTA' '
     + 	check_unpack test-3-${packname_3}
     + '
     + 
     ++test_expect_success 'unpack with OFS_DELTA (core.fsyncobjectfiles=batch)' '
     ++       check_unpack test-3-${packname_3} "-c core.fsyncobjectfiles=batch"
     ++'
     ++
     + test_expect_success 'compare delta flavors' '
     + 	perl -e '\''
     + 		defined($_ = -s $_) or die for @ARGV;
 6:  3e6b80b5fa2 = 7:  6543564376a core.fsyncobjectfiles: performance tests for add and stash

-- 
gitgitgadget
