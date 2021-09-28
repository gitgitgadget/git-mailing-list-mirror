Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA416C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8F96136F
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243258AbhI1Xef (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243249AbhI1Xef (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:34:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9CAC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:32:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s24so350398wmh.4
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aJztsQYnpVJxaqyqj+9VfdgBd8+cqSgFs3WSfh8f/g4=;
        b=j2q2DGyWDisXMcjHGkY7b0uHfe5ZRQM1iJy4Ls5EfgvbiAIaiojtxqTtNnRRUm7+CP
         2qs9HPNzH5p9miZyhjFWKugrM1lo0hqIBWrPahn1No2VPtyrwyirzgdFwIljOKa+UMzV
         GauaYesXQqKXVRHfvDzlU9TAHz4H0sE/sDBBCWdCWwnAAGnZ0YE3C709AcfbORj0TwnH
         9to+YhWVDTtfLDPp5b6BDY9ucxRSldxdwFizAdAi26SU7CUqzdQaIi87EHmynGD6Th/f
         lLFECL7wFsSnVgVh12we38mZ7GrkIJEpaAHNERiO9LOMsUX62eefyXWoNfQqnq6J/Noo
         5Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aJztsQYnpVJxaqyqj+9VfdgBd8+cqSgFs3WSfh8f/g4=;
        b=tNg+Q6hw+WUYmQnyLG8+PfEkWpxBgytfpQTzOi9ztKHxkB/PudWZxj1ANicyQ24n5S
         xrej7IEKTctQOuZYbXBJ+Oh1z+/oc8cHaLmSxKeE1bKlYfRsNJVx4LOgkcotfnRCMiMr
         FXGpbOOxlBRdzdw2cwnlE7+FaaI/Af+edrUlmBUMb3Xn2n44aWzg05IWt5h3AxTgFeLE
         dVcugQnVOemKd73s4/Ogos/a56fSYj6fUjdy5JuLmXtZjFaSYXjMD90U1uqPMljOapfc
         gb5XX2nMwwXin90/eBI0oZYLyOZHloQQHrcAyreRNSeQ4CEqBWCRYg3orTvz8oHZGcvf
         iJdA==
X-Gm-Message-State: AOAM532ldLJBxuIQRPXFUtGAc/cgacz26ozW5eniFvqHZbhvVtuyzUy2
        3tF+33ZZDVozbkOtA/eLUZPzyqhlTM4=
X-Google-Smtp-Source: ABdhPJz8nB5wlWDYXwaulBz3XcD0zMBfSpNC0ePcgH59sYvVdFkmiZV+SXkewQzb1ftmOMQMPY174Q==
X-Received: by 2002:a05:600c:4f16:: with SMTP id l22mr7208422wmq.123.1632871972936;
        Tue, 28 Sep 2021 16:32:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g25sm441039wrc.88.2021.09.28.16.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:32:52 -0700 (PDT)
Message-Id: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
References: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 23:32:42 +0000
Subject: [PATCH v7 0/9] Implement a batched fsync option for core.fsyncObjectFiles
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

Thanks to everyone for review so far!

The patch is now at version 7: changes since v6:

 * Rebased onto current upstream master

 * Separate the tmp-objdir changes and move to the beginning of the series
   so that Elijah Newren's similar changes can be merged.

 * Use some of Elijah's implementation for replacing the primary ODB. I was
   doing some unnecessarily complex copying for no good reason.

 * Make the tmp objdir code use a name beginning with tmp_ and having a
   operation-specific prefix.

 * Add git-prune support for removing a stale object directory.

v5 was a bit of a dud, with some issues that I only noticed after
submitting. v6 changes:

 * re-add Windows support
 * fix minor formatting issues
 * reset git author and commit dates which got messed up

Changes since v4, all in response to review feedback from Ævar Arnfjörð
Bjarmason:

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

Neeraj Singh (9):
  object-file.c: do not rename in a temp odb
  tmp-objdir: new API for creating temporary writable databases
  bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  core.fsyncobjectfiles: batched disk flushes
  core.fsyncobjectfiles: add windows support for batch mode
  update-index: use the bulk-checkin infrastructure
  unpack-objects: use the bulk-checkin infrastructure
  core.fsyncobjectfiles: tests for batch mode
  core.fsyncobjectfiles: performance tests for add and stash

 Documentation/config/core.txt       |  29 ++++++--
 Makefile                            |   6 ++
 builtin/prune.c                     |  22 ++++--
 builtin/receive-pack.c              |   2 +-
 builtin/unpack-objects.c            |   3 +
 builtin/update-index.c              |   6 ++
 bulk-checkin.c                      |  92 +++++++++++++++++++++---
 bulk-checkin.h                      |   2 +
 cache.h                             |   8 ++-
 compat/mingw.h                      |   3 +
 compat/win32/flush.c                |  28 ++++++++
 config.c                            |   7 +-
 config.mak.uname                    |   3 +
 configure.ac                        |   8 +++
 contrib/buildsystems/CMakeLists.txt |   3 +-
 environment.c                       |   6 +-
 git-compat-util.h                   |   7 ++
 object-file.c                       | 106 +++++++++++++++++++++++-----
 object-store.h                      |  25 +++++++
 object.c                            |   2 +-
 repository.c                        |   2 +
 repository.h                        |   1 +
 t/lib-unique-files.sh               |  36 ++++++++++
 t/perf/p3700-add.sh                 |  43 +++++++++++
 t/perf/p3900-stash.sh               |  46 ++++++++++++
 t/t3700-add.sh                      |  20 ++++++
 t/t3903-stash.sh                    |  14 ++++
 t/t5300-pack-object.sh              |  30 +++++---
 tmp-objdir.c                        |  30 +++++++-
 tmp-objdir.h                        |  14 +++-
 wrapper.c                           |  48 +++++++++++++
 write-or-die.c                      |   2 +-
 32 files changed, 592 insertions(+), 62 deletions(-)
 create mode 100644 compat/win32/flush.c
 create mode 100644 t/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh


base-commit: cefe983a320c03d7843ac78e73bd513a27806845
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1076%2Fneerajsi-msft%2Fneerajsi%2Fbulk-fsync-object-files-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1076/neerajsi-msft/neerajsi/bulk-fsync-object-files-v7
Pull-Request: https://github.com/git/git/pull/1076

Range-diff vs v6:

  1:  e4081f81f6a =  1:  6e65f68fd6d object-file.c: do not rename in a temp odb
  -:  ----------- >  2:  6ce72a709a1 tmp-objdir: new API for creating temporary writable databases
  2:  ebba65e040c !  3:  c272f8776fa bulk-checkin: rename 'state' variable and separate 'plugged' boolean
     @@ bulk-checkin.c: static struct bulk_checkin_state {
      -} state;
      +} bulk_checkin_state;
       
     - static void finish_bulk_checkin(struct bulk_checkin_state *state)
     - {
     + static void finish_tmp_packfile(struct strbuf *basename,
     + 				const char *pack_tmp_name,
      @@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
       		       int fd, size_t size, enum object_type type,
       		       const char *path, unsigned flags)
  3:  543ea356934 !  4:  55556bb3e90 core.fsyncobjectfiles: batched disk flushes
     @@ Commit message
          batches up hardware flushes. It hooks into the bulk-checkin plugging and
          unplugging functionality and takes advantage of tmp-objdir.
      
     -    When the new mode is enabled we do the following for each new object:
     +    When the new mode is enabled do the following for each new object:
          1. Create the object in a tmp-objdir.
          2. Issue a pagecache writeback request and wait for it to complete.
      
     -    At the end of the entire transaction when unplugging bulk checkin we:
     +    At the end of the entire transaction when unplugging bulk checkin:
          1. Issue an fsync against a dummy file to flush the hardware writeback
             cache, which should by now have processed the tmp-objdir writes.
          2. Rename all of the tmp-objdir files to their final names.
     @@ Commit message
             but may be a good extension to those components.
      
          On a filesystem with a singular journal that is updated during name
     -    operations (e.g. create, link, rename, etc), such as NTFS, HFS+, or XFS we
     -    would expect the fsync to trigger a journal writeout so that this
     +    operations (e.g. create, link, rename, etc), such as NTFS, HFS+, or XFS
     +    we would expect the fsync to trigger a journal writeout so that this
          sequence is enough to ensure that the user's data is durable by the time
          the git command returns.
      
     @@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
      +	 */
      +	if (fsync_object_files == FSYNC_OBJECT_FILES_BATCH &&
      +	    !the_repository->objects->odb->is_temp) {
     -+		bulk_fsync_objdir = tmp_objdir_create();
     ++		bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
      +		if (!bulk_fsync_objdir)
      +			die(_("Could not create temporary object directory for core.fsyncobjectfiles=batch"));
      +
     -+		tmp_objdir_replace_main_odb(bulk_fsync_objdir);
     ++		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
      +	}
      +
       	bulk_checkin_plugged = 1;
     @@ configure.ac: AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
       GIT_CHECK_FUNC(setitimer,
      
       ## environment.c ##
     -@@ environment.c: const char *git_hooks_path;
     +@@ environment.c: const char *git_attributes_file;
     + const char *git_hooks_path;
       int zlib_compression_level = Z_BEST_SPEED;
     - int core_compression_level;
       int pack_compression_level = Z_DEFAULT_COMPRESSION;
      -int fsync_object_files;
      +enum fsync_object_files_mode fsync_object_files;
     @@ git-compat-util.h: __attribute__((format (printf, 1, 2))) NORETURN
        * Returns 0 on success, which includes trying to unlink an object that does
      
       ## object-file.c ##
     -@@ object-file.c: void add_to_alternates_memory(const char *reference)
     - 			     '\n', NULL, 0);
     - }
     - 
     -+struct object_directory *set_temporary_main_odb(const char *dir)
     -+{
     -+	struct object_directory *main_odb, *new_odb, *old_next;
     -+
     -+	/*
     -+	 * Make sure alternates are initialized, or else our entry may be
     -+	 * overwritten when they are.
     -+	 */
     -+	prepare_alt_odb(the_repository);
     -+
     -+	/* Copy the existing object directory and make it an alternate. */
     -+	main_odb = the_repository->objects->odb;
     -+	new_odb = xmalloc(sizeof(*new_odb));
     -+	*new_odb = *main_odb;
     -+	*the_repository->objects->odb_tail = new_odb;
     -+	the_repository->objects->odb_tail = &(new_odb->next);
     -+	new_odb->next = NULL;
     -+
     -+	/*
     -+	 * Reinitialize the main odb with the specified path, being careful
     -+	 * to keep the next pointer value.
     -+	 */
     -+	old_next = main_odb->next;
     -+	memset(main_odb, 0, sizeof(*main_odb));
     -+	main_odb->next = old_next;
     -+	main_odb->is_temp = 1;
     -+	main_odb->path = xstrdup(dir);
     -+	return new_odb;
     -+}
     -+
     -+void restore_main_odb(struct object_directory *odb)
     -+{
     -+	struct object_directory **prev, *main_odb;
     -+
     -+	/* Unlink the saved previous main ODB from the list. */
     -+	prev = &the_repository->objects->odb->next;
     -+	assert(*prev);
     -+	while (*prev != odb) {
     -+		prev = &(*prev)->next;
     -+	}
     -+	*prev = odb->next;
     -+	if (*prev == NULL)
     -+		the_repository->objects->odb_tail = prev;
     -+
     -+	/*
     -+	 * Restore the data from the old main odb, being careful to
     -+	 * keep the next pointer value
     -+	 */
     -+	main_odb = the_repository->objects->odb;
     -+	SWAP(*main_odb, *odb);
     -+	main_odb->next = odb->next;
     -+	free_object_directory(odb);
     -+}
     -+
     - /*
     -  * Compute the exact path an alternate is at and returns it. In case of
     -  * error NULL is returned and the human readable error is added to `err`
      @@ object-file.c: int hash_object_file(const struct git_hash_algo *algo, const void *buf,
     - /* Finalize a file on disk, and close it. */
       static void close_loose_object(int fd)
       {
     --	if (fsync_object_files)
     -+	switch (fsync_object_files) {
     -+	case FSYNC_OBJECT_FILES_OFF:
     -+		break;
     -+	case FSYNC_OBJECT_FILES_ON:
     - 		fsync_or_die(fd, "loose object file");
     -+		break;
     -+	case FSYNC_OBJECT_FILES_BATCH:
     -+		fsync_loose_object_bulk_checkin(fd);
     -+		break;
     -+	default:
     -+		BUG("Invalid fsync_object_files mode.");
     -+	}
     -+
     - 	if (close(fd) != 0)
     - 		die_errno(_("error when closing loose object file"));
     - }
     -
     - ## object-store.h ##
     -@@ object-store.h: void add_to_alternates_file(const char *dir);
     -  */
     - void add_to_alternates_memory(const char *dir);
     - 
     -+/*
     -+ * Replace the current main object directory with the specified temporary
     -+ * object directory. We make a copy of the former main object directory,
     -+ * add it as an in-memory alternate, and return the copy so that it can
     -+ * be restored via restore_main_odb.
     -+ */
     -+struct object_directory *set_temporary_main_odb(const char *dir);
     -+
     -+/*
     -+ * Restore a previous ODB replaced by set_temporary_main_odb.
     -+ */
     -+void restore_main_odb(struct object_directory *odb);
     -+
     - /*
     -  * Populate and return the loose object cache array corresponding to the
     -  * given object ID.
     -@@ object-store.h: struct oidtree *odb_loose_cache(struct object_directory *odb,
     - /* Empty the loose object cache for the specified object directory. */
     - void odb_clear_loose_cache(struct object_directory *odb);
     - 
     -+/* Clear and free the specified object directory */
     -+void free_object_directory(struct object_directory *odb);
     -+
     - struct packed_git {
     - 	struct hashmap_entry packmap_ent;
     - 	struct packed_git *next;
     -
     - ## object.c ##
     -@@ object.c: struct raw_object_store *raw_object_store_new(void)
     - 	return o;
     - }
     + 	if (!the_repository->objects->odb->will_destroy) {
     +-		if (fsync_object_files)
     ++		switch (fsync_object_files) {
     ++		case FSYNC_OBJECT_FILES_OFF:
     ++			break;
     ++		case FSYNC_OBJECT_FILES_ON:
     + 			fsync_or_die(fd, "loose object file");
     ++			break;
     ++		case FSYNC_OBJECT_FILES_BATCH:
     ++			fsync_loose_object_bulk_checkin(fd);
     ++			break;
     ++		default:
     ++			BUG("Invalid fsync_object_files mode.");
     ++		}
     + 	}
       
     --static void free_object_directory(struct object_directory *odb)
     -+void free_object_directory(struct object_directory *odb)
     - {
     - 	free(odb->path);
     - 	odb_clear_loose_cache(odb);
     + 	if (close(fd) != 0)
      
       ## tmp-objdir.c ##
     -@@
     - struct tmp_objdir {
     - 	struct strbuf path;
     - 	struct strvec env;
     -+	struct object_directory *prev_main_odb;
     - };
     - 
     - /*
     -@@ tmp-objdir.c: static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
     - 	 * freeing memory; it may cause a deadlock if the signal
     - 	 * arrived while libc's allocator lock is held.
     - 	 */
     --	if (!on_signal)
     -+	if (!on_signal) {
     -+		if (t->prev_main_odb)
     -+			restore_main_odb(t->prev_main_odb);
     - 		tmp_objdir_free(t);
     -+	}
     -+
     - 	return err;
     - }
     - 
     -@@ tmp-objdir.c: struct tmp_objdir *tmp_objdir_create(void)
     - 	t = xmalloc(sizeof(*t));
     - 	strbuf_init(&t->path, 0);
     - 	strvec_init(&t->env);
     -+	t->prev_main_odb = NULL;
     - 
     - 	strbuf_addf(&t->path, "%s/incoming-XXXXXX", get_object_directory());
     - 
      @@ tmp-objdir.c: int tmp_objdir_migrate(struct tmp_objdir *t)
       	if (!t)
       		return 0;
       
     -+	if (t->prev_main_odb) {
     -+		restore_main_odb(t->prev_main_odb);
     -+		t->prev_main_odb = NULL;
     -+	}
     -+
     - 	strbuf_addbuf(&src, &t->path);
     - 	strbuf_addstr(&dst, get_object_directory());
     - 
     -@@ tmp-objdir.c: void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
     - {
     - 	add_to_alternates_memory(t->path.buf);
     - }
     -+
     -+void tmp_objdir_replace_main_odb(struct tmp_objdir *t)
     -+{
     -+	if (t->prev_main_odb)
     -+		BUG("the main object database is already replaced");
     -+	t->prev_main_odb = set_temporary_main_odb(t->path.buf);
     -+}
     -
     - ## tmp-objdir.h ##
     -@@ tmp-objdir.h: int tmp_objdir_destroy(struct tmp_objdir *);
     -  */
     - void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
     - 
     -+/*
     -+ * Replaces the main object store in the current process with the temporary
     -+ * object directory and makes the former main object store an alternate.
     -+ */
     -+void tmp_objdir_replace_main_odb(struct tmp_objdir *);
     -+
     - #endif /* TMP_OBJDIR_H */
     +-
     +-
     + 	if (t->prev_odb) {
     + 		if (the_repository->objects->odb->will_destroy)
     + 			BUG("migrating and ODB that was marked for destruction");
      
       ## wrapper.c ##
      @@ wrapper.c: int xmkstemp_mode(char *filename_template, int mode)
  4:  bdb99822f8c =  5:  6c33e79d6f0 core.fsyncobjectfiles: add windows support for batch mode
  5:  92e18cedab0 =  6:  09dbff1004e update-index: use the bulk-checkin infrastructure
  6:  e3c5a11f225 =  7:  1eced9f9f9a unpack-objects: use the bulk-checkin infrastructure
  7:  385199354fa =  8:  7aaa08d5f5f core.fsyncobjectfiles: tests for batch mode
  8:  504bcc95c56 =  9:  ff286fb461a core.fsyncobjectfiles: performance tests for add and stash

-- 
gitgitgadget
