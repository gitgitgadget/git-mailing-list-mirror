Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D24DC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E67613DB
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbhJDQ7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbhJDQ7k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:59:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1906FC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 09:57:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o20so13935145wro.3
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GxdzkoeGP3yo1XXP4GyZPO63ARBAEGhzZH4nee017+0=;
        b=CM1GuoWjiMQowdO1WooKl8q/pLLtDIo71otomO3+dzfAdtFmGNHnp0SnAkQ5pfMbIa
         OBxLwvefU3OErYItWPh55XWcH0zg5FkisbLJ5i0j7MbEineYiOYVqcEafmu++4YeBsCu
         +HQOQx7O5UcBSVeGjy0jEKvytALAYCuW60Wh+OusWFzZYWfbE8E3Kmhlm1o9SO9uiDlI
         tHAE5YG5sEMI1WYQS2RPRUKa+kaMOCCr/+9zye9Nz+rtO4XBrUJcbKQIxtMz9X2wYZQf
         uGUmXK5K22rODTzhpmjLZiIywv4exZXqiwGh7BZPAn/Sz1W9xF9YBzQuTuc6w9rUf1U0
         0p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GxdzkoeGP3yo1XXP4GyZPO63ARBAEGhzZH4nee017+0=;
        b=D5XWCVWQHpjZu8S4zLWnoZtiKrsD9946V8d8bFXmViLOcBLzXoANZJiV83lXv2qnvZ
         5Ph55R0Is2D5pkJ8DT5egCh0uXk1TJ7YFO9Bs55ziOx0QR6lTCoBgeWUFO/62HVMP6Df
         2J5zppfbAKr9n0xCxWfRGC1v/b7M1ezUoYU82mNQMKj62q70h0dHxjGW4DfuK5WXfvJS
         9DIhyWudvozO2u0o8FJnQ1Rp/kSIWLu7nqVWX1lqRoVMvvtbs5yuBumHlPa7RJ8z588C
         +6D6hn9xuNePkGGSDvAHjwgQgea4+FB0gvbj2zrS0bI9YDOo6q6X7lOD7b84QV+Lx+gD
         N/Kg==
X-Gm-Message-State: AOAM530wtzx5z8cguxL2I6fPJEhc2uyFD5O+ks30DoqEaRKjAf2TShfN
        l8H3jg/XVbjrYxbxCtLCf6IYIn6g2gk=
X-Google-Smtp-Source: ABdhPJzXiiKBC3ZsEtp6CcKSA+oD/cLxdkNt+dxre5ok753Xal0LMD5b9ox2XZcaIOdMTsuXinv+iw==
X-Received: by 2002:adf:f1c7:: with SMTP id z7mr15115881wro.425.1633366669359;
        Mon, 04 Oct 2021 09:57:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k22sm15319078wrd.59.2021.10.04.09.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:57:48 -0700 (PDT)
Message-Id: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
References: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Oct 2021 16:57:38 +0000
Subject: [PATCH v8 0/9] Implement a batched fsync option for core.fsyncObjectFiles
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
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to everyone for review so far!

This series shares the base tmp-objdir patches with my merged version of
Elijah Newren's remerge-diff series at:
https://github.com/neerajsi-msft/git/tree/neerajsi/remerge-diff.

The patch is now at version 8: changes since v7:

 * Dropped the tmp-objdir patch to avoid renaming in a quarantine/temporary
   objdir, as suggested by Jeff King. This wasn't a good idea because we
   don't really know that there's only a single reader/writer. Avoiding the
   rename was a relatively minor perf optimization so it's okay to drop.

 * Added disable_ref_updates logic (as a flag on the odb) which is set when
   we're in a quarantine or when a tmp objdir is active. I believe this
   roughly follows the strategy suggested by Jeff King.

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
  tmp-objdir: new API for creating temporary writable databases
  tmp-objdir: disable ref updates when replacing the primary odb
  bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  core.fsyncobjectfiles: batched disk flushes
  core.fsyncobjectfiles: add windows support for batch mode
  update-index: use the bulk-checkin infrastructure
  unpack-objects: use the bulk-checkin infrastructure
  core.fsyncobjectfiles: tests for batch mode
  core.fsyncobjectfiles: performance tests for add and stash

 Documentation/config/core.txt       | 29 ++++++++--
 Makefile                            |  6 ++
 builtin/prune.c                     | 22 +++++--
 builtin/receive-pack.c              |  2 +-
 builtin/unpack-objects.c            |  3 +
 builtin/update-index.c              |  6 ++
 bulk-checkin.c                      | 90 +++++++++++++++++++++++++----
 bulk-checkin.h                      |  2 +
 cache.h                             |  8 ++-
 compat/mingw.h                      |  3 +
 compat/win32/flush.c                | 28 +++++++++
 config.c                            |  7 ++-
 config.mak.uname                    |  3 +
 configure.ac                        |  8 +++
 contrib/buildsystems/CMakeLists.txt |  3 +-
 environment.c                       |  6 +-
 git-compat-util.h                   |  7 +++
 object-file.c                       | 60 ++++++++++++++++++-
 object-store.h                      | 26 +++++++++
 object.c                            |  2 +-
 refs.c                              |  2 +-
 repository.c                        |  2 +
 repository.h                        |  1 +
 t/lib-unique-files.sh               | 36 ++++++++++++
 t/perf/p3700-add.sh                 | 43 ++++++++++++++
 t/perf/p3900-stash.sh               | 46 +++++++++++++++
 t/t3700-add.sh                      | 20 +++++++
 t/t3903-stash.sh                    | 14 +++++
 t/t5300-pack-object.sh              | 30 ++++++----
 tmp-objdir.c                        | 30 +++++++++-
 tmp-objdir.h                        | 14 ++++-
 wrapper.c                           | 48 +++++++++++++++
 write-or-die.c                      |  2 +-
 33 files changed, 562 insertions(+), 47 deletions(-)
 create mode 100644 compat/win32/flush.c
 create mode 100644 t/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh


base-commit: cefe983a320c03d7843ac78e73bd513a27806845
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1076%2Fneerajsi-msft%2Fneerajsi%2Fbulk-fsync-object-files-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1076/neerajsi-msft/neerajsi/bulk-fsync-object-files-v8
Pull-Request: https://github.com/git/git/pull/1076

Range-diff vs v7:

  2:  6ce72a709a1 !  1:  f03797fd80d tmp-objdir: new API for creating temporary writable databases
     @@ Metadata
       ## Commit message ##
          tmp-objdir: new API for creating temporary writable databases
      
     -    This patch is based on work by Elijah Newren. Any bugs however are my
     -    own.
     -
          The tmp_objdir API provides the ability to create temporary object
          directories, but was designed with the goal of having subprocesses
          access these object stores, followed by the main process migrating
     @@ Commit message
          make sure that they have a name starting with tmp_ and containing an
          operation-specific name.
      
     +    Based-on-patch-by: Elijah Newren <newren@gmail.com>
     +
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
       ## builtin/prune.c ##
     @@ object-file.c: void add_to_alternates_memory(const char *reference)
      +	 */
      +	new_odb = xcalloc(1, sizeof(*new_odb));
      +	new_odb->path = xstrdup(dir);
     -+	new_odb->is_temp = 1;
      +	new_odb->will_destroy = will_destroy;
      +	new_odb->next = the_repository->objects->odb;
      +	the_repository->objects->odb = new_odb;
     @@ object-file.c: int hash_object_file(const struct git_hash_algo *algo, const void
      
       ## object-store.h ##
      @@ object-store.h: struct object_directory {
     - 	 * This is a temporary object store, so there is no need to
     - 	 * create new objects via rename.
     - 	 */
     --	int is_temp;
     -+	int is_temp : 8;
     -+
     + 	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
     + 	struct oidtree *loose_objects_cache;
     + 
      +	/*
      +	 * This object store is ephemeral, so there is no need to fsync.
      +	 */
     -+	int will_destroy : 8;
     - 
     ++	int will_destroy;
     ++
       	/*
       	 * Path to the alternative object store. If this is a relative path,
     + 	 * it is relative to the current working directory.
      @@ object-store.h: void add_to_alternates_file(const char *dir);
        */
       void add_to_alternates_memory(const char *dir);
     @@ tmp-objdir.c: int tmp_objdir_migrate(struct tmp_objdir *t)
       	if (!t)
       		return 0;
       
     -+
     -+
      +	if (t->prev_odb) {
      +		if (the_repository->objects->odb->will_destroy)
     -+			BUG("migrating and ODB that was marked for destruction");
     ++			BUG("migrating an ODB that was marked for destruction");
      +		restore_primary_odb(t->prev_odb, t->path.buf);
      +		t->prev_odb = NULL;
      +	}
  1:  6e65f68fd6d !  2:  bc085137340 object-file.c: do not rename in a temp odb
     @@ Metadata
      Author: Neeraj Singh <neerajsi@microsoft.com>
      
       ## Commit message ##
     -    object-file.c: do not rename in a temp odb
     +    tmp-objdir: disable ref updates when replacing the primary odb
      
     -    If a temporary ODB is active, as determined by GIT_QUARANTINE_PATH
     -    being set, create object files with their final names. This avoids
     -    an extra rename beyond what is needed to merge the temporary ODB in
     -    tmp_objdir_migrate.
     +    When creating a subprocess with a temporary ODB, we set the
     +    GIT_QUARANTINE_ENVIRONMENT env var to tell child Git processes not
     +    to update refs, since the tmp-objdir may go away.
      
     -    Creating an object file with the expected final name should be okay
     -    since the git process writing to the temporary object store is the
     -    only writer, and it only invokes write_loose_object/create_object_file
     -    after checking that the object doesn't exist.
     +    Introduce a similar mechanism for in-process temporary ODBs when
     +    we call tmp_objdir_replace_primary_odb. Now both mechanisms set
     +    the disable_ref_updates flag on the odb, which is queried by
     +    the ref_transaction_prepare function.
     +
     +    Note: This change adds an assumption that the state of
     +    the_repository is relevant for any ref transaction that might
     +    be initiated. Unwinding this assumption should be straightforward
     +    by saving the relevant repository to query in the transaction or
     +    the ref_store.
     +
     +    Peff's test case was invoking ref updates via the cachetextconv
     +    setting. That particular code silently does nothing when a ref
     +    update is forbidden. See the call to notes_cache_put in
     +    fill_textconv where errors are ignored.
     +
     +    Reported-by: Jeff King <peff@peff.net>
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     @@ environment.c: void setup_git_env(const char *git_dir)
       	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
       	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
      +	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
     -+		args.object_dir_is_temp = 1;
     ++		args.disable_ref_updates = 1;
      +	}
      +
       	repo_set_gitdir(the_repository, git_dir, &args);
     @@ environment.c: void setup_git_env(const char *git_dir)
       
      
       ## object-file.c ##
     -@@ object-file.c: static void write_object_file_prepare(const struct git_hash_algo *algo,
     - }
     - 
     - /*
     -- * Move the just written object into its final resting place.
     -+ * Move the just written object into its final resting place,
     -+ * unless it is already there, as indicated by an empty string for
     -+ * tmpfile.
     -  */
     - int finalize_object_file(const char *tmpfile, const char *filename)
     - {
     - 	int ret = 0;
     - 
     -+	if (!*tmpfile)
     -+		goto out;
     +@@ object-file.c: struct object_directory *set_temporary_primary_odb(const char *dir, int will_des
     + 	 */
     + 	new_odb = xcalloc(1, sizeof(*new_odb));
     + 	new_odb->path = xstrdup(dir);
      +
     - 	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
     - 		goto try_rename;
     - 	else if (link(tmpfile, filename))
     -@@ object-file.c: static inline int directory_size(const char *filename)
     - }
     - 
     - /*
     -- * This creates a temporary file in the same directory as the final
     -- * 'filename'
     -+ * This creates a loose object file for the specified object id.
     -+ * If we're working in a temporary object directory, the file is
     -+ * created with its final filename, otherwise it is created with
     -+ * a temporary name and renamed by finalize_object_file.
     -+ * If no rename is required, an empty string is returned in tmp.
     -  *
     -  * We want to avoid cross-directory filename renames, because those
     -  * can have problems on various filesystems (FAT, NFS, Coda).
     -  */
     --static int create_tmpfile(struct strbuf *tmp, const char *filename)
     -+static int create_objfile(const struct object_id *oid, struct strbuf *tmp,
     -+			  struct strbuf *filename)
     - {
     --	int fd, dirlen = directory_size(filename);
     -+	int fd, dirlen, is_retrying = 0;
     -+	const char *object_name;
     -+	static const int object_mode = 0444;
     - 
     -+	loose_object_path(the_repository, filename, oid);
     -+	dirlen = directory_size(filename->buf);
     -+
     -+retry_create:
     - 	strbuf_reset(tmp);
     --	strbuf_add(tmp, filename, dirlen);
     --	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
     --	fd = git_mkstemp_mode(tmp->buf, 0444);
     --	if (fd < 0 && dirlen && errno == ENOENT) {
     -+	if (!the_repository->objects->odb->is_temp) {
     -+		strbuf_add(tmp, filename->buf, dirlen);
     -+		object_name = "tmp_obj_XXXXXX";
     -+		strbuf_addstr(tmp, object_name);
     -+		fd = git_mkstemp_mode(tmp->buf, object_mode);
     -+	} else {
     -+		fd = open(filename->buf, O_CREAT | O_EXCL | O_RDWR, object_mode);
     -+	}
     -+
     -+	if (fd < 0 && dirlen && errno == ENOENT && !is_retrying) {
     - 		/*
     - 		 * Make sure the directory exists; note that the contents
     - 		 * of the buffer are undefined after mkstemp returns an
     -@@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const char *filename)
     - 		 * scratch.
     - 		 */
     - 		strbuf_reset(tmp);
     --		strbuf_add(tmp, filename, dirlen - 1);
     -+		strbuf_add(tmp, filename->buf, dirlen - 1);
     - 		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
     - 			return -1;
     - 		if (adjust_shared_perm(tmp->buf))
     - 			return -1;
     - 
     - 		/* Try again */
     --		strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
     --		fd = git_mkstemp_mode(tmp->buf, 0444);
     -+		is_retrying = 1;
     -+		goto retry_create;
     - 	}
     - 	return fd;
     - }
     -@@ object-file.c: static int write_loose_object(const struct object_id *oid, char *hdr,
     - 	static struct strbuf tmp_file = STRBUF_INIT;
     - 	static struct strbuf filename = STRBUF_INIT;
     - 
     --	loose_object_path(the_repository, &filename, oid);
     --
     --	fd = create_tmpfile(&tmp_file, filename.buf);
     -+	fd = create_objfile(oid, &tmp_file, &filename);
     - 	if (fd < 0) {
     - 		if (errno == EACCES)
     - 			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
     - 		else
     --			return error_errno(_("unable to create temporary file"));
     -+			return error_errno(_("unable to create object file"));
     - 	}
     - 
     - 	/* Set it up */
     ++	/*
     ++	 * Disable ref updates while a temporary odb is active, since
     ++	 * the objects in the database may roll back.
     ++	 */
     ++	new_odb->disable_ref_updates = 1;
     + 	new_odb->will_destroy = will_destroy;
     + 	new_odb->next = the_repository->objects->odb;
     + 	the_repository->objects->odb = new_odb;
      
       ## object-store.h ##
      @@ object-store.h: struct object_directory {
     @@ object-store.h: struct object_directory {
       	struct oidtree *loose_objects_cache;
       
      +	/*
     -+	 * This is a temporary object store, so there is no need to
     -+	 * create new objects via rename.
     ++	 * This is a temporary object store created by the tmp_objdir
     ++	 * facility. Disable ref updates since the objects in the store
     ++	 * might be discarded on rollback.
      +	 */
     -+	int is_temp;
     ++	unsigned int disable_ref_updates : 1;
      +
     + 	/*
     + 	 * This object store is ephemeral, so there is no need to fsync.
     + 	 */
     +-	int will_destroy;
     ++	unsigned int will_destroy : 1;
     + 
       	/*
       	 * Path to the alternative object store. If this is a relative path,
     - 	 * it is relative to the current working directory.
     +
     + ## refs.c ##
     +@@ refs.c: int ref_transaction_prepare(struct ref_transaction *transaction,
     + 		break;
     + 	}
     + 
     +-	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
     ++	if (the_repository->objects->odb->disable_ref_updates) {
     + 		strbuf_addstr(err,
     + 			      _("ref updates forbidden inside quarantine environment"));
     + 		return -1;
      
       ## repository.c ##
      @@ repository.c: void repo_set_gitdir(struct repository *repo,
       	expand_base_dir(&repo->objects->odb->path, o->object_dir,
       			repo->commondir, "objects");
       
     -+	repo->objects->odb->is_temp = o->object_dir_is_temp;
     ++	repo->objects->odb->disable_ref_updates = o->disable_ref_updates;
      +
       	free(repo->objects->alternate_db);
       	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
     @@ repository.h: struct set_gitdir_args {
       	const char *graft_file;
       	const char *index_file;
       	const char *alternate_db;
     -+	int object_dir_is_temp;
     ++	int disable_ref_updates;
       };
       
       void repo_set_gitdir(struct repository *repo, const char *root,
  3:  c272f8776fa =  3:  9335646ed91 bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  4:  55556bb3e90 !  4:  b9d3d874432 core.fsyncobjectfiles: batched disk flushes
     @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
      +	 */
      +	if (bulk_checkin_plugged &&
      +	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
     -+		assert(the_repository->objects->odb->is_temp);
      +		if (!needs_batch_fsync)
      +			needs_batch_fsync = 1;
      +	} else {
     @@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
       	assert(!bulk_checkin_plugged);
      +
      +	/*
     -+	 * Create a temporary object directory if the current
     -+	 * object directory is not already temporary.
     ++	 * A temporary object directory is used to hold the files
     ++	 * while they are not fsynced.
      +	 */
     -+	if (fsync_object_files == FSYNC_OBJECT_FILES_BATCH &&
     -+	    !the_repository->objects->odb->is_temp) {
     ++	if (fsync_object_files == FSYNC_OBJECT_FILES_BATCH) {
      +		bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
      +		if (!bulk_fsync_objdir)
      +			die(_("Could not create temporary object directory for core.fsyncobjectfiles=batch"));
     @@ object-file.c: int hash_object_file(const struct git_hash_algo *algo, const void
       
       	if (close(fd) != 0)
      
     - ## tmp-objdir.c ##
     -@@ tmp-objdir.c: int tmp_objdir_migrate(struct tmp_objdir *t)
     - 	if (!t)
     - 		return 0;
     - 
     --
     --
     - 	if (t->prev_odb) {
     - 		if (the_repository->objects->odb->will_destroy)
     - 			BUG("migrating and ODB that was marked for destruction");
     -
       ## wrapper.c ##
      @@ wrapper.c: int xmkstemp_mode(char *filename_template, int mode)
       	return fd;
  5:  6c33e79d6f0 =  5:  8df32eaaa9a core.fsyncobjectfiles: add windows support for batch mode
  6:  09dbff1004e =  6:  15767270984 update-index: use the bulk-checkin infrastructure
  7:  1eced9f9f9a =  7:  e88bab809a2 unpack-objects: use the bulk-checkin infrastructure
  8:  7aaa08d5f5f =  8:  811d6d31509 core.fsyncobjectfiles: tests for batch mode
  9:  ff286fb461a =  9:  f4fa20f591e core.fsyncobjectfiles: performance tests for add and stash

-- 
gitgitgadget
