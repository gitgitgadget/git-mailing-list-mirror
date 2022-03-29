Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BA9C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiC2AoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiC2AoT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EEC237FD1
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 125-20020a1c0283000000b0038d043aac51so459640wmc.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pgxiOqtWOCFpjtb0OnBx1plw2g4hVVUJ3rl9fZy/Yts=;
        b=qFafCvEQbuPsvB+jlgA6L5aNnQDip/0aQClu+T6ScPiD/+fjCQmcuGV4yJUWHvp/77
         csn0TY+fHvBuc9GeD11XOTeF0pTR59x55OmAeIJJEJAndGDDW31goqKpd+Zsx4pDBvEk
         FDLa+8M9JONCrorFJOs5R/YPBdJfysgQTSXDur37bFtXe3W/aKMwwKhdqFIYOQ47K75f
         uP8sL24tJVCgAtCMGgfGzxol/xvq5Khw8jQe3A6Nd14VSW2RoVo6iDM8HDPD8XQPPfrr
         fUN6l+fRrV68mjq1ser5PiaC3QFSfVTP/6T+mNnaHcRAYy2SPuGPgjpHiPeSV3ppMqQl
         7MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pgxiOqtWOCFpjtb0OnBx1plw2g4hVVUJ3rl9fZy/Yts=;
        b=GKgBwoEn9C+83qqFzATKDrf+puqjMGGnaVnUv6rkoPMaqSZyboKQr0AbC56rRQUsm+
         J2k+UPiVZiQgBiw5cK0eWp7X1jGhrffUzNdUtsNZYfjxBiKcdcnhUWqSXb1WM1Tg94QB
         IkTjTrZZoU4GvRQEssvh9in7ErDuu29UHJR2MynnzSueQzw4F1xNxp+3AEKR5XGn6lwd
         CX9w7upRzLHg8XhoCLuwNzr9b8HyA2zSb5coDOnyaXOiW5gn/sXg14MFLl2weg5b5DuT
         L2OQp75uFZyOSWVJUJVphoxeTOtwcjiLDgYFiU6npWOtZCtVV70ZigJbttECeiPCLbdl
         lPyQ==
X-Gm-Message-State: AOAM532Y+ScotJsen8OjKHeZ41rTPjpx3lBA6qBg3jHTC9VBP1ukpkxG
        1Q4FBsGHAWmrpArclc6fwSUXecxY6Sk=
X-Google-Smtp-Source: ABdhPJy6GFwK9woJUKWCgdqV+c9xmhF1nrJV/ZVjKIqNj0tw4PsD3eL30MYOdYrNkd53N2OFwUqJxA==
X-Received: by 2002:a7b:c017:0:b0:38c:8a13:466d with SMTP id c23-20020a7bc017000000b0038c8a13466dmr2833167wmb.128.1648514554597;
        Mon, 28 Mar 2022 17:42:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t4-20020a05600001c400b00203fb5dcf29sm13191125wrx.40.2022.03.28.17.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:34 -0700 (PDT)
Message-Id: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:17 +0000
Subject: [PATCH v4 00/13] core.fsyncmethod: add 'batch' mode for faster fsyncing of multiple objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V4 changes:

 * Make ODB transactions nestable.
 * Add an ODB transaction around writing out the cached tree.
 * Change update-index to use a more straightforward way of managing ODB
   transactions.
 * Fix missing 'local's in lib-unique-files
 * Add a per-iteration setup mechanism to test_perf.
 * Fix camelCasing in warning message.

V3 changes:

 * Rebrand plug/unplug-bulk-checkin to "begin_odb_transaction" and
   "end_odb_transaction"
 * Add a patch to pass filenames to fsync_or_die, rather than the string
   "loose object"
 * Update the commit description for "core.fsyncmethod to explain why we do
   not directly expose objects until an fsync occurs.
 * Also explain in the commit description why we're using a dummy file for
   the fsync.
 * Create the bulk-fsync tmp-objdir lazily the first time a loose object is
   added. We now do fsync iff that objdir exists.
 * Do batch fsync if core.fsyncMethod=batch and core.fsync contains
   loose-object, regardless of the core.fsyncObjectFiles setting.
 * Mitigate the risk in update-index of an object not being visible due to
   bulk checkin.
 * Add a perf comment to justify the unpack-objects usage of bulk-checkin.
 * Add a new patch to create helpers for parsing OIDs from git commands.
 * Add a comment to the lib-unique-files.sh helper about uniqueness only
   within a repo.
 * Fix style and add '&&' chaining to test helpers.
 * Comment on some magic numbers in tests.
 * Take the object list as an argument in
   ./t5300-pack-object.sh:check_unpack ()
 * Drop accidental change to t/perf/perf-lib.sh

V2 changes:

 * Change doc to indicate that only some repo updates are batched
 * Null and zero out control variables in do_batch_fsync under
   unplug_bulk_checkin
 * Make batch mode default on Windows.
 * Update the description for the initial patch that cleans up the
   bulk-checkin infrastructure.
 * Rebase onto 'seen' at 0cac37f38f9.

--Original definition-- When core.fsync includes loose-object, we issue an
fsync after every written object. For a 'git-add' or similar command that
adds a lot of files to the repo, the costs of these fsyncs adds up. One
major factor in this cost is the time it takes for the physical storage
controller to flush its caches to durable media.

This series takes advantage of the writeout-only mode of git_fsync to issue
OS cache writebacks for all of the objects being added to the repository
followed by a single fsync to a dummy file, which should trigger a
filesystem log flush and storage controller cache flush. This mechanism is
known to be safe on common Windows filesystems and expected to be safe on
macOS. Some linux filesystems, such as XFS, will probably do the right thing
as well. See [1] for previous discussion on the predecessor of this patch
series.

This series is important on Windows, where loose-objects are included in the
fsync set by default in Git-For-Windows. In this series, I'm also setting
the default mode for Windows to turn on loose object fsyncing with batch
mode, so that we can get CI coverage of the actual git-for-windows
configuration upstream. We still don't actually issue fsyncs for the test
suite since GIT_TEST_FSYNC is set to 0, but we exercise all of the
surrounding batch mode code.

This work is based on 'next' at c54b8eb302. It's dependent on
ns/core-fsyncmethod.

[1]
https://lore.kernel.org/git/2c1ddef6057157d85da74a7274e03eacf0374e45.1629856293.git.gitgitgadget@gmail.com/

Neeraj Singh (13):
  bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
  object-file: pass filename to fsync_or_die
  core.fsyncmethod: batched disk flushes for loose-objects
  cache-tree: use ODB transaction around writing a tree
  update-index: use the bulk-checkin infrastructure
  unpack-objects: use the bulk-checkin infrastructure
  core.fsync: use batch mode and sync loose objects by default on
    Windows
  test-lib-functions: add parsing helpers for ls-files and ls-tree
  core.fsyncmethod: tests for batch mode
  t/perf: add iteration setup mechanism to perf-lib
  core.fsyncmethod: performance tests for add and stash
  core.fsyncmethod: correctly camel-case warning message

 Documentation/config/core.txt          |   8 ++
 builtin/add.c                          |   4 +-
 builtin/unpack-objects.c               |   3 +
 builtin/update-index.c                 |  24 ++++++
 bulk-checkin.c                         | 101 ++++++++++++++++++++++---
 bulk-checkin.h                         |  17 ++++-
 cache-tree.c                           |   3 +
 cache.h                                |  12 ++-
 compat/mingw.h                         |   3 +
 config.c                               |   6 +-
 git-compat-util.h                      |   2 +
 object-file.c                          |  15 ++--
 t/lib-unique-files.sh                  |  34 +++++++++
 t/perf/p3700-add.sh                    |  59 +++++++++++++++
 t/perf/p4220-log-grep-engines.sh       |   3 +-
 t/perf/p4221-log-grep-engines-fixed.sh |   3 +-
 t/perf/p5302-pack-index.sh             |  15 ++--
 t/perf/p7519-fsmonitor.sh              |  18 +----
 t/perf/p7820-grep-engines.sh           |   6 +-
 t/perf/perf-lib.sh                     |  62 +++++++++++++--
 t/t3700-add.sh                         |  28 +++++++
 t/t3903-stash.sh                       |  20 +++++
 t/t5300-pack-object.sh                 |  41 ++++++----
 t/t5317-pack-objects-filter-objects.sh |  91 +++++++++++-----------
 t/test-lib-functions.sh                |  10 +++
 25 files changed, 469 insertions(+), 119 deletions(-)
 create mode 100644 t/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh


base-commit: c54b8eb302ffb72f31e73a26044c8a864e2cb307
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1134%2Fneerajsi-msft%2Fns%2Fbatched-fsync-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1134/neerajsi-msft/ns/batched-fsync-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1134

Range-diff vs v3:

  2:  b2d9766a662 !  1:  c7a2a7efe6d bulk-checkin: rename 'state' variable and separate 'plugged' boolean
     @@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
       	return status;
       }
       
     - void begin_odb_transaction(void)
     + void plug_bulk_checkin(void)
       {
      -	state.plugged = 1;
      +	assert(!bulk_checkin_plugged);
      +	bulk_checkin_plugged = 1;
       }
       
     - void end_odb_transaction(void)
     + void unplug_bulk_checkin(void)
       {
      -	state.plugged = 0;
      -	if (state.f)
  1:  53261f0099d !  2:  d045b13795b bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
     @@ Commit message
      
          Make it clearer in the naming and documentation of the plug_bulk_checkin
          and unplug_bulk_checkin APIs that they can be thought of as
     -    a "transaction" to optimize operations on the object database.
     +    a "transaction" to optimize operations on the object database. These
     +    transactions may be nested so that subsystems like the cache-tree
     +    writing code can optimize their operations without caring whether the
     +    top-level code has a transaction active.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
       	if (write_locked_index(&the_index, &lock_file,
      
       ## bulk-checkin.c ##
     +@@
     + #include "packfile.h"
     + #include "object-store.h"
     + 
     +-static int bulk_checkin_plugged;
     ++static int odb_transaction_nesting;
     + 
     + static struct bulk_checkin_state {
     + 	char *pack_tmp_name;
      @@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
     + {
     + 	int status = deflate_to_pack(&bulk_checkin_state, oid, fd, size, type,
     + 				     path, flags);
     +-	if (!bulk_checkin_plugged)
     ++	if (!odb_transaction_nesting)
     + 		finish_bulk_checkin(&bulk_checkin_state);
       	return status;
       }
       
      -void plug_bulk_checkin(void)
      +void begin_odb_transaction(void)
       {
     - 	state.plugged = 1;
     +-	assert(!bulk_checkin_plugged);
     +-	bulk_checkin_plugged = 1;
     ++	odb_transaction_nesting += 1;
       }
       
      -void unplug_bulk_checkin(void)
      +void end_odb_transaction(void)
       {
     - 	state.plugged = 0;
     - 	if (state.f)
     +-	assert(bulk_checkin_plugged);
     +-	bulk_checkin_plugged = 0;
     ++	odb_transaction_nesting -= 1;
     ++	if (odb_transaction_nesting < 0)
     ++		BUG("Unbalanced ODB transaction nesting");
     ++
     ++	if (odb_transaction_nesting)
     ++		return;
     ++
     + 	if (bulk_checkin_state.f)
     + 		finish_bulk_checkin(&bulk_checkin_state);
     + }
      
       ## bulk-checkin.h ##
      @@ bulk-checkin.h: int index_bulk_checkin(struct object_id *oid,
  3:  26ce5b8fdda =  3:  2d1bc4568ac object-file: pass filename to fsync_or_die
  4:  52638326790 !  4:  9e7ae22fa4a core.fsyncmethod: batched disk flushes for loose-objects
     @@ bulk-checkin.c
       #include "packfile.h"
       #include "object-store.h"
       
     - static int bulk_checkin_plugged;
     + static int odb_transaction_nesting;
       
      +static struct tmp_objdir *bulk_fsync_objdir;
      +
     @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
      +	 * callers may not know whether any objects will be
      +	 * added at the time they call begin_odb_transaction.
      +	 */
     -+	if (!bulk_checkin_plugged || bulk_fsync_objdir)
     ++	if (!odb_transaction_nesting || bulk_fsync_objdir)
      +		return;
      +
      +	bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
     @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
      +void fsync_loose_object_bulk_checkin(int fd, const char *filename)
      +{
      +	/*
     -+	 * If we have a plugged bulk checkin, we issue a call that
     ++	 * If we have an active ODB transaction, we issue a call that
      +	 * cleans the filesystem page cache but avoids a hardware flush
      +	 * command. Later on we will issue a single hardware flush
      +	 * before as part of do_batch_fsync.
     @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
       		       int fd, size_t size, enum object_type type,
       		       const char *path, unsigned flags)
      @@ bulk-checkin.c: void end_odb_transaction(void)
     - 	bulk_checkin_plugged = 0;
     + 
       	if (bulk_checkin_state.f)
       		finish_bulk_checkin(&bulk_checkin_state);
      +
  -:  ----------- >  5:  83fa4a5f3a5 cache-tree: use ODB transaction around writing a tree
  5:  913ce1b3df9 !  6:  f03ebee695a update-index: use the bulk-checkin infrastructure
     @@ Commit message
          There is some risk with this change, since under batch fsync, the object
          files will be in a tmp-objdir until update-index is complete, so callers
          using the --stdin option will not see them until update-index is done.
     -    This risk is mitigated by unplugging the batch when reporting verbose
     -    output, which is the only way a --stdin caller might synchronize with
     -    the addition of an object.
     +    This risk is mitigated by not keeping an ODB transaction open around
     +    --stdin processing if in --verbose mode. Without --verbose mode,
     +    a caller feeding update-index via --stdin wouldn't know when
     +    update-index adds an object, event without an ODB transaction.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     @@ builtin/update-index.c
       #include "config.h"
       #include "lockfile.h"
       #include "quote.h"
     -@@ builtin/update-index.c: static int allow_replace;
     - static int info_only;
     - static int force_remove;
     - static int verbose;
     -+static int odb_transaction_active;
     - static int mark_valid_only;
     - static int mark_skip_worktree_only;
     - static int mark_fsmonitor_only;
     -@@ builtin/update-index.c: enum uc_mode {
     - 	UC_FORCE
     - };
     - 
     -+static void end_odb_transaction_if_active(void)
     -+{
     -+	if (!odb_transaction_active)
     -+		return;
     -+
     -+	end_odb_transaction();
     -+	odb_transaction_active = 0;
     -+}
     -+
     - __attribute__((format (printf, 1, 2)))
     - static void report(const char *fmt, ...)
     - {
     -@@ builtin/update-index.c: static void report(const char *fmt, ...)
     - 	if (!verbose)
     - 		return;
     - 
     -+	/*
     -+	 * It is possible, though unlikely, that a caller
     -+	 * could use the verbose output to synchronize with
     -+	 * addition of objects to the object database, so
     -+	 * unplug bulk checkin to make sure that future objects
     -+	 * are immediately visible.
     -+	 */
     -+
     -+	end_odb_transaction_if_active();
     -+
     - 	va_start(vp, fmt);
     - 	vprintf(fmt, vp);
     - 	putchar('\n');
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
       	 */
       	parse_options_start(&ctx, argc, argv, prefix,
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
      +	 * a batch.
      +	 */
      +	begin_odb_transaction();
     -+	odb_transaction_active = 1;
       	while (ctx.argc) {
       		if (parseopt_state != PARSE_OPT_DONE)
       			parseopt_state = parse_options_step(&ctx, options,
     +@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     + 		the_index.version = preferred_index_format;
     + 	}
     + 
     ++	/*
     ++	 * It is possible, though unlikely, that a caller could use the verbose
     ++	 * output to synchronize with addition of objects to the object
     ++	 * database. The current implementation of ODB transactions leaves
     ++	 * objects invisible while a transaction is active, so end the
     ++	 * transaction here if verbose output is enabled.
     ++	 */
     ++
     ++	if (verbose)
     ++		end_odb_transaction();
     ++
     + 	if (read_from_stdin) {
     + 		struct strbuf buf = STRBUF_INIT;
     + 		struct strbuf unquoted = STRBUF_INIT;
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
       		strbuf_release(&buf);
       	}
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
      +	/*
      +	 * By now we have added all of the new objects
      +	 */
     -+	end_odb_transaction_if_active();
     ++	if (!verbose)
     ++		end_odb_transaction();
      +
       	if (split_index > 0) {
       		if (git_config_get_split_index() == 0)
  6:  84fd144ef18 =  7:  d85013f7d2c unpack-objects: use the bulk-checkin infrastructure
  7:  447263e8ef1 =  8:  73e54f94c20 core.fsync: use batch mode and sync loose objects by default on Windows
  8:  8f1b01c9ca0 =  9:  124450c86d9 test-lib-functions: add parsing helpers for ls-files and ls-tree
  9:  b5f371e97fe ! 10:  282fbdef792 core.fsyncmethod: tests for batch mode
     @@ t/lib-unique-files.sh (new)
      +	local files="$2" &&
      +	local basedir="$3" &&
      +	local counter=0 &&
     ++	local i &&
     ++	local j &&
      +	test_tick &&
      +	local basedata=$basedir$test_tick &&
      +	rm -rf "$basedir" &&
  -:  ----------- > 11:  ee7ecf4cabe t/perf: add iteration setup mechanism to perf-lib
 10:  b99b32a469c ! 12:  fdf90d45f52 core.fsyncmethod: performance tests for add and stash
     @@ t/perf/p3700-add.sh (new)
      +# core.fsyncMethod=batch mode, which is why we are testing different values
      +# of that setting explicitly and creating a lot of unique objects.
      +
     -+test_description="Tests performance of add"
     ++test_description="Tests performance of adding things to the object database"
      +
      +# Fsync is normally turned off for the test suite.
      +GIT_TEST_FSYNC=1
     @@ t/perf/p3700-add.sh (new)
      +
      +. $TEST_DIRECTORY/lib-unique-files.sh
      +
     -+test_perf_default_repo
     ++test_perf_fresh_repo
      +test_checkout_worktree
      +
      +dir_count=10
      +files_per_dir=50
      +total_files=$((dir_count * files_per_dir))
      +
     -+# We need to create the files each time we run the perf test, but
     -+# we do not want to measure the cost of creating the files, so run
     -+# the test once.
     -+if test "${GIT_PERF_REPEAT_COUNT-1}" -ne 1
     -+then
     -+	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
     -+	GIT_PERF_REPEAT_COUNT=1
     -+fi
     -+
     -+for m in false true batch
     ++for mode in false true batch
      +do
     -+	test_expect_success "create the files for object_fsyncing=$m" '
     -+		git reset --hard &&
     -+		# create files across directories
     -+		test_create_unique_files $dir_count $files_per_dir files
     -+	'
     -+
     -+	case $m in
     ++	case $mode in
      +	false)
      +		FSYNC_CONFIG='-c core.fsync=-loose-object -c core.fsyncmethod=fsync'
      +		;;
     @@ t/perf/p3700-add.sh (new)
      +		;;
      +	esac
      +
     -+	test_perf "add $total_files files (object_fsyncing=$m)" "
     -+		git $FSYNC_CONFIG add files
     ++	test_perf "add $total_files files (object_fsyncing=$mode)" \
     ++		--setup "
     ++		(rm -rf .git || 1) &&
     ++		git init &&
     ++		test_create_unique_files $dir_count $files_per_dir files_$mode
     ++	" "
     ++		git $FSYNC_CONFIG add files_$mode
      +	"
     -+done
     -+
     -+test_done
     -
     - ## t/perf/p3900-stash.sh (new) ##
     -@@
     -+#!/bin/sh
     -+#
     -+# This test measures the performance of adding new files to the object database
     -+# and index. The test was originally added to measure the effect of the
     -+# core.fsyncMethod=batch mode, which is why we are testing different values
     -+# of that setting explicitly and creating a lot of unique objects.
     -+
     -+test_description="Tests performance of stash"
     -+
     -+# Fsync is normally turned off for the test suite.
     -+GIT_TEST_FSYNC=1
     -+export GIT_TEST_FSYNC
     -+
     -+. ./perf-lib.sh
     -+
     -+. $TEST_DIRECTORY/lib-unique-files.sh
     -+
     -+test_perf_default_repo
     -+test_checkout_worktree
     -+
     -+dir_count=10
     -+files_per_dir=50
     -+total_files=$((dir_count * files_per_dir))
     -+
     -+# We need to create the files each time we run the perf test, but
     -+# we do not want to measure the cost of creating the files, so run
     -+# the test once.
     -+if test "${GIT_PERF_REPEAT_COUNT-1}" -ne 1
     -+then
     -+	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
     -+	GIT_PERF_REPEAT_COUNT=1
     -+fi
     -+
     -+for m in false true batch
     -+do
     -+	test_expect_success "create the files for object_fsyncing=$m" '
     -+		git reset --hard &&
     -+		# create files across directories
     -+		test_create_unique_files $dir_count $files_per_dir files
     -+	'
     -+
     -+	case $m in
     -+	false)
     -+		FSYNC_CONFIG='-c core.fsync=-loose-object -c core.fsyncmethod=fsync'
     -+		;;
     -+	true)
     -+		FSYNC_CONFIG='-c core.fsync=loose-object -c core.fsyncmethod=fsync'
     -+		;;
     -+	batch)
     -+		FSYNC_CONFIG='-c core.fsync=loose-object -c core.fsyncmethod=batch'
     -+		;;
     -+	esac
      +
     -+	# We only stash files in the 'files' subdirectory since
     -+	# the perf test infrastructure creates files in the
     -+	# current working directory that need to be preserved
     -+	test_perf "stash $total_files files (object_fsyncing=$m)" "
     -+		git $FSYNC_CONFIG stash push -u -- files
     ++	test_perf "stash $total_files files (object_fsyncing=$mode)" \
     ++		--setup "
     ++		(rm -rf .git || 1) &&
     ++		git init &&
     ++		test_commit first &&
     ++		test_create_unique_files $dir_count $files_per_dir stash_files_$mode
     ++	" "
     ++		git $FSYNC_CONFIG stash push -u -- stash_files_$mode
      +	"
      +done
      +
 11:  6b832e89bc4 = 13:  fb30bd02c8d core.fsyncmethod: correctly camel-case warning message

-- 
gitgitgadget
