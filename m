Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B235C433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5838C63212
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhKPD1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbhKPDZq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:25:46 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBE7C03AA1A
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s13so33952668wrb.3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FO0z2p1uiGRvrjWB/GsxwX7SGn9GcyNvwBkDrose68I=;
        b=ok8d58CwY708LZcPfKoIYC54f9ksVUbxVLRcLcL9T0ZBhH3FE4XYiSZ5tg7By9xR0q
         lDx+d5DW2nprCtCSOAVC8UGqDHW28qqjdHTOl2SQOdbCfcor4+taLK1scSTYTjBWRS7R
         ZDT+wYVcEEhpOVtqPL3koPol55BZoz5H8oFNzQkIVm5SaWawq0YojrzdqoAjcruLduCl
         N3R29nqFtOIqmgLw9ey6MLWOtj7TYgAOyJzEFqMM92ydtXpOrsF794BMO5sW2Ac8KxyB
         O17iuBupWfFlWphcBGowDdIrwkuM0qxYn+ua2zEZFd1oGzMNdlmIvnMitATCkEwDiYXS
         KvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FO0z2p1uiGRvrjWB/GsxwX7SGn9GcyNvwBkDrose68I=;
        b=ztzlyJb3wgAF4lAaH6fs/CbCaAFzwZru3j/4GxOB+CfrflGKHbjtNDPVUgozoOlCNy
         BjtF4223Rg9JBZGrheLzquU9qXTlBJTTDITV9bRzzcCLLoxkrxiUKhY7QZJLd4hh16wJ
         pnzyCF14zTQhvlh9DN2dd0kK8Swao0VpHZ0swuaU52j1ezoJtXZasEuxd9gVr/jyqXci
         ZZ7b+JVb1BoQ2Qs24wpvw+LOlAmI25DvL5BQHTnJ81aAJjKgkqBoUKJl9FGoYFzoVqpr
         UU8vY7+NQXYoz5CKrn4xb0Ad/vJ9dNxxyNJa2eSpomcD4WtghGWrU0wNvBvVN1vKh5oP
         hepg==
X-Gm-Message-State: AOAM533D1p6dCX97O2zwDah4DsX65HBkMPUdezhhUaoBGy9Kfw/CmEDe
        pcc2ABQ8E+c3Lf1iAq/vCLeEiahimiw=
X-Google-Smtp-Source: ABdhPJzpHU/tqFvmZRvx1UFTs1PUy94GOu/Dcpp9Qw9RWRDb43/STYfuW0wtfN+reipmtNdl5/m94w==
X-Received: by 2002:a5d:522e:: with SMTP id i14mr3818444wra.43.1637020264897;
        Mon, 15 Nov 2021 15:51:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm15800086wrs.48.2021.11.15.15.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 15:51:04 -0800 (PST)
Message-Id: <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Nov 2021 23:50:54 +0000
Subject: [PATCH v9 0/9] Implement a batched fsync option for core.fsyncObjectFiles
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

Changes between v8 and v9 [1]:

 * Rebased onto master at tag v2.34.0
 * Fixed git-prune bug when trying to clean up multiple cruft directories.
 * Preserve the tmp-objdir around update_relative_gitdir, which is called by
   setup_work_tree through the chdir_notify mechanism.
 * Per [2], I'm leaving the fsyncObjectFiles configuration as is with
   'true', 'false', and 'batch'. This makes using old and new versions of
   git with 'batch' mode a little trickier, but hopefully people will
   generally be moving forward in versions.

[1] See
https://lore.kernel.org/git/pull.1067.git.1635287730.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/xmqqh7cimuxt.fsf@gitster.g/

Changes between v7 and v8:

 * Dropped the tmp-objdir patch to avoid renaming in a quarantine/temporary
   objdir, as suggested by Jeff King. This wasn't a good idea because we
   don't really know that there's only a single reader/writer. Avoiding the
   rename was a relatively minor perf optimization so it's okay to drop.

 * Added disable_ref_updates logic (as a flag on the odb) which is set when
   we're in a quarantine or when a tmp objdir is active. I believe this
   roughly follows the strategy suggested by Jeff King.

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
 builtin/prune.c                     | 23 ++++++--
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
 environment.c                       | 11 +++-
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
 tmp-objdir.c                        | 55 +++++++++++++++++-
 tmp-objdir.h                        | 29 +++++++++-
 wrapper.c                           | 48 +++++++++++++++
 write-or-die.c                      |  2 +-
 33 files changed, 608 insertions(+), 47 deletions(-)
 create mode 100644 compat/win32/flush.c
 create mode 100644 t/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1076%2Fneerajsi-msft%2Fneerajsi%2Fbulk-fsync-object-files-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1076/neerajsi-msft/neerajsi/bulk-fsync-object-files-v9
Pull-Request: https://github.com/git/git/pull/1076

Range-diff vs v8:

  1:  f03797fd80d !  1:  6b27afa60e0 tmp-objdir: new API for creating temporary writable databases
     @@ Commit message
          Based-on-patch-by: Elijah Newren <newren@gmail.com>
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/prune.c ##
      @@ builtin/prune.c: static int show_only;
     @@ builtin/prune.c: static int prune_tmp_file(const char *fullpath)
      +		if (show_only || verbose)
      +			printf("Removing stale temporary directory %s\n", fullpath);
      +		if (!show_only) {
     ++			strbuf_reset(&remove_dir_buf);
      +			strbuf_addstr(&remove_dir_buf, fullpath);
      +			remove_dir_recursively(&remove_dir_buf, 0);
      +		}
     @@ builtin/receive-pack.c: static const char *unpack(int err_fd, struct shallow_inf
       		if (err_fd > 0)
       			close(err_fd);
      
     + ## environment.c ##
     +@@
     + #include "commit.h"
     + #include "strvec.h"
     + #include "object-store.h"
     ++#include "tmp-objdir.h"
     + #include "chdir-notify.h"
     + #include "shallow.h"
     + 
     +@@ environment.c: static void update_relative_gitdir(const char *name,
     + 				   void *data)
     + {
     + 	char *path = reparent_relative_path(old_cwd, new_cwd, get_git_dir());
     ++	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
     + 	trace_printf_key(&trace_setup_key,
     + 			 "setup: move $GIT_DIR to '%s'",
     + 			 path);
     ++
     + 	set_git_dir_1(path);
     ++	if (tmp_objdir)
     ++		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
     + 	free(path);
     + }
     + 
     +
       ## object-file.c ##
      @@ object-file.c: void add_to_alternates_memory(const char *reference)
       			     '\n', NULL, 0);
     @@ object.c: struct raw_object_store *raw_object_store_new(void)
       	odb_clear_loose_cache(odb);
      
       ## tmp-objdir.c ##
     +@@
     + #include "cache.h"
     + #include "tmp-objdir.h"
     ++#include "chdir-notify.h"
     + #include "dir.h"
     + #include "sigchain.h"
     + #include "string-list.h"
      @@
       struct tmp_objdir {
       	struct strbuf path;
       	struct strvec env;
      +	struct object_directory *prev_odb;
     ++	int will_destroy;
       };
       
       /*
     @@ tmp-objdir.c: void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
      +	if (t->prev_odb)
      +		BUG("the primary object database is already replaced");
      +	t->prev_odb = set_temporary_primary_odb(t->path.buf, will_destroy);
     ++	t->will_destroy = will_destroy;
     ++}
     ++
     ++struct tmp_objdir *tmp_objdir_unapply_primary_odb(void)
     ++{
     ++	if (!the_tmp_objdir || !the_tmp_objdir->prev_odb)
     ++		return NULL;
     ++
     ++	restore_primary_odb(the_tmp_objdir->prev_odb, the_tmp_objdir->path.buf);
     ++	the_tmp_objdir->prev_odb = NULL;
     ++	return the_tmp_objdir;
     ++}
     ++
     ++void tmp_objdir_reapply_primary_odb(struct tmp_objdir *t, const char *old_cwd,
     ++		const char *new_cwd)
     ++{
     ++	char *path;
     ++
     ++	path = reparent_relative_path(old_cwd, new_cwd, t->path.buf);
     ++	strbuf_reset(&t->path);
     ++	strbuf_addstr(&t->path, path);
     ++	free(path);
     ++	tmp_objdir_replace_primary_odb(t, t->will_destroy);
      +}
      
       ## tmp-objdir.h ##
     @@ tmp-objdir.h: int tmp_objdir_destroy(struct tmp_objdir *);
      + * If will_destroy is nonzero, the object directory may not be migrated.
      + */
      +void tmp_objdir_replace_primary_odb(struct tmp_objdir *, int will_destroy);
     ++
     ++/*
     ++ * If the primary object database was replaced by a temporary object directory,
     ++ * restore it to its original value while keeping the directory contents around.
     ++ * Returns NULL if the primary object database was not replaced.
     ++ */
     ++struct tmp_objdir *tmp_objdir_unapply_primary_odb(void);
     ++
     ++/*
     ++ * Reapplies the former primary temporary object database, after protentially
     ++ * changing its relative path.
     ++ */
     ++void tmp_objdir_reapply_primary_odb(struct tmp_objdir *, const char *old_cwd,
     ++		const char *new_cwd);
     ++
      +
       #endif /* TMP_OBJDIR_H */
  2:  bc085137340 !  2:  71817cccfb9 tmp-objdir: disable ref updates when replacing the primary odb
     @@ Commit message
          Reported-by: Jeff King <peff@peff.net>
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## environment.c ##
      @@ environment.c: void setup_git_env(const char *git_dir)
  3:  9335646ed91 =  3:  8fd1ca4c00a bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  4:  b9d3d874432 =  4:  e1747ce00af core.fsyncobjectfiles: batched disk flushes
  5:  8df32eaaa9a !  5:  951a559874e core.fsyncobjectfiles: add windows support for batch mode
     @@ config.mak.uname: endif
       		compat/win32/path-utils.o \
       		compat/win32/pthread.o compat/win32/syslog.o \
       		compat/win32/trace2_win32_process_info.o \
     -@@ config.mak.uname: ifneq (,$(findstring MINGW,$(uname_S)))
     +@@ config.mak.uname: ifeq ($(uname_S),MINGW)
       	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
       	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
       		compat/win32/trace2_win32_process_info.o \
  6:  15767270984 =  6:  4a40fd4a29a update-index: use the bulk-checkin infrastructure
  7:  e88bab809a2 =  7:  cfc6a347d08 unpack-objects: use the bulk-checkin infrastructure
  8:  811d6d31509 !  8:  270c24827d0 core.fsyncobjectfiles: tests for batch mode
     @@ t/lib-unique-files.sh (new)
      
       ## t/t3700-add.sh ##
      @@ t/t3700-add.sh: test_description='Test of git add, including the -- option.'
     - 
     + TEST_PASSES_SANITIZE_LEAK=true
       . ./test-lib.sh
       
      +. $TEST_DIRECTORY/lib-unique-files.sh
  9:  f4fa20f591e =  9:  12d99641f4c core.fsyncobjectfiles: performance tests for add and stash

-- 
gitgitgadget
