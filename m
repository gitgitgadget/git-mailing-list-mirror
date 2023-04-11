Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9B0C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 03:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjDKDBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 23:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjDKDBM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 23:01:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A67D1B1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 20:01:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e2so6012835wrc.10
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 20:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681182068;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQYoaJU2RWl1BpaJOT/LbazAVyUSkvceLb7pLbMmOfA=;
        b=DMSYqQ8N0IYEDNLvf/Th0ag7VgQDxvFoGyM1d1eDRSvZFSrfOxdjviboOQFXBxXs6p
         FlEiY/3oycLJmIi95rF7lZjfQMWtiadVokrOzmRnSNeaS7ylBiPPmTtIfUam48bQ7Jsh
         v8A0Lq382CIqaWjj0udG8XWnEj5LFi370jdZBOGxbNVmjts0yNoriqxwI9axryNdgCuB
         OWVZw4Y8JGlVJbSs8QvPeQlZq0mFq42MG6rT06P7e7LMwpcHDC4gbyCFxcd+RNFuvkSW
         Q8YrVX4vl3d1SITPIfAajyzH0jgGswm+kdFAbSCPh2gqvLBCyX2M+/jUq3xikltanGrO
         httA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681182068;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQYoaJU2RWl1BpaJOT/LbazAVyUSkvceLb7pLbMmOfA=;
        b=fRHU2hZoL5b3QkKbEkba5RJWQx5s11PKpMpDUhzR1WDlC325H//IWVXcqY7c/VzWjC
         4qE5bmKD7bGFLyT7qbzMk7F1WtmCkf7dtZtFnQElO4AjW/6PFm9e4zH8bS7eQzZIn+SP
         tDLfuYXu4swoyPbT6xvoD5/ejF3/kq3e0ZXmcrUmZpYvmOocTIfnneQtxhTsuv3mzUI6
         uMIyOZrOuEoXeupzNchnM6aKB33ZZ+V1K4u7M+aXP8tQMOMoDW5uRz6ynKc6vyyC0LHm
         r1DiAQ+zcIIzjYUO4O7LlM76fMtfUQALRA7+tpbNsEuvfKrJtEcCJXjnA3hRxKfLmX06
         x/kg==
X-Gm-Message-State: AAQBX9dKFDDu4ncErkeuCJ/z4F4drZSljtVPfyoZCmOLt6r89nODKsVe
        V26M3TnOxuukNkDdQQqcgeErTuN7ukc=
X-Google-Smtp-Source: AKy350YFm6HpqQKYlXzBfSRQz9eNz90iVX3sKXhXCikppXT30NoClcfG4kUl2aOLgFiGzDUtmlrnjA==
X-Received: by 2002:a05:6000:550:b0:2f0:583:44be with SMTP id b16-20020a056000055000b002f0058344bemr4934700wrf.0.1681182067378;
        Mon, 10 Apr 2023 20:01:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15-20020a5d4d4f000000b002cfe685bfd6sm13253394wru.108.2023.04.10.20.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 20:01:07 -0700 (PDT)
Message-Id: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Apr 2023 03:00:37 +0000
Subject: [PATCH v3 00/23] Header cleanups (splitting up cache.h)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 * Dropped patch 21 (Calvin is making more thorough changes to strbuf.[ch]
   in his series which will obsolete this patch and dropping it makes it
   easier to deconflict.)
 * Added Calvin's Acked-by to all the other patches.

Changes since v1:

 * Moved a few more things from cache.h to object.h, object-file.h, and
   object-name.h
 * Split the object.h changes into two patches to be more like all the other
   patches in 8-19
 * Squashed patches 22 & 23, since both were just manual replacements of
   cache.h inclusion with some other header
 * Removed a couple cases of duplicate inclusions of git-compat-util.h

Maintainer notes: (1) This series is based on a merge of
en/header-split-cleanup and ab/remove-implicit-use-of-the-repository (both
in next). (2) Although I've tweaked the series to minimize conflicts (and
this series merges syntactically cleanly with next and seen), there is a
semantic conflict with each of ja/worktree-orphan and
ab/tag-object-type-errors in seen; to correct, simply add an include of
advice.h in builtin/worktree.c and an include of gettext.h in tag.c,
respectively.

This series builds on en/header-cleanup
(https://lore.kernel.org/git/pull.1485.v2.git.1677197376.gitgitgadget@gmail.com/)
and en/header-split-cleanup
(https://lore.kernel.org/git/pull.1493.v2.git.1679379968.gitgitgadget@gmail.com/),
and continues to focus on splitting declarations from cache.h to separate
headers. This series continues dropping the number of cache.h includes; in
this series we go from 254 such includes to 190.

The series may appear to be long at first glance, but is repetitive and
simple. It should be relatively easy to review, and falls into roughly 3
categories. An overview:

 * Patches 1-6, 7: Being more explicit about dependencies. This was
   motivated by the fact that trying to find unnecessary dependencies on
   cache.h were being made harder by implicit dependencies on trace.h,
   trace2.h, and advice.h that were included via cache.h. (Similar to
   gettext.h handling in the previous series.) So I simply try to make
   dependencies more explicit, for both these headers and a few others. To
   make review easy, I split it into half a dozen patches, one header per
   patch (well, except that I handle trace.h and trace2.h together). Patch 7
   then removes several includes of cache.h that are no longer needed due to
   patches 1-6.
 * Patches 8-19: For several choices of FOO, move declarations of functions
   for FOO.c from cache.h to FOO.h. To simplify reviewing, each case is
   split into two patches, with the second patch cleaning up unnecessary
   includes of cache.h in other source files.
 * Patches 20-24: Other small manual cleanups noticed while doing above work

Since patches 1-15 & 17-19 are just more of the same types of patches
already reviewed in the last two series, it probably makes more sense for
reviewers to focus on the other patches: 16 + 20-24 (which also happen to be
smaller). I would particularly most like review of patches 16, 22, & 24
since they are the least like any previously reviewed patches.

There are more changes I plan to make after this series graduates (still
focused around splitting up cache.h), but this series was long enough.

And thanks once again to Dscho for gitgitgadget. Getting multiple platform
testing + all the special tests (sparse, cocci, hdr-check, etc.) really
helps clean out all the issues that would otherwise hit a series like this.

Elijah Newren (23):
  treewide: be explicit about dependence on trace.h & trace2.h
  treewide: be explicit about dependence on advice.h
  treewide: be explicit about dependence on convert.h
  treewide: be explicit about dependence on pack-revindex.h
  treewide: be explicit about dependence on oid-array.h
  treewide: be explicit about dependence on mem-pool.h
  treewide: remove unnecessary cache.h inclusion
  object-name.h: move declarations for object-name.c functions from
    cache.h
  treewide: remove cache.h inclusion due to object-name.h changes
  git-zlib: move declarations for git-zlib functions from cache.h
  treewide: remove cache.h inclusion due to git-zlib changes
  object-file.h: move declarations for object-file.c functions from
    cache.h
  treewide: remove cache.h inclusion due to object-file.h changes
  object.h: move some inline functions and defines from cache.h
  treewide: remove cache.h inclusion due to object.h changes
  editor: move editor-related functions and declarations into common
    file
  treewide: remove cache.h inclusion due to editor.h changes
  pager.h: move declarations for pager.c functions from cache.h
  treewide: remove cache.h inclusion due to pager.h changes
  cache.h: remove unnecessary includes
  treewide: remove double forward declaration of read_in_full
  treewide: reduce includes of cache.h in other headers
  mailmap, quote: move declarations of global vars to correct unit

 Makefile                                 |   2 +-
 add-patch.c                              |   3 +
 apply.c                                  |   2 +
 archive-tar.c                            |   1 +
 archive-zip.c                            |   1 +
 archive.c                                |   1 +
 archive.h                                |   3 +-
 bisect.c                                 |   3 +-
 blame.c                                  |   2 +
 branch.c                                 |   3 +-
 builtin/add.c                            |   2 +
 builtin/am.c                             |   4 +
 builtin/bisect.c                         |   2 +
 builtin/blame.c                          |   2 +
 builtin/branch.c                         |   2 +
 builtin/bugreport.c                      |   2 +
 builtin/cat-file.c                       |   3 +
 builtin/check-attr.c                     |   1 +
 builtin/checkout.c                       |   3 +
 builtin/clone.c                          |   3 +
 builtin/commit-graph.c                   |   1 +
 builtin/commit-tree.c                    |   1 +
 builtin/commit.c                         |   3 +
 builtin/config.c                         |   1 +
 builtin/credential-cache--daemon.c       |   1 +
 builtin/describe.c                       |   1 +
 builtin/diagnose.c                       |   1 +
 builtin/difftool.c                       |   1 +
 builtin/fast-export.c                    |   1 +
 builtin/fast-import.c                    |   2 +
 builtin/fetch-pack.c                     |   1 +
 builtin/fetch.c                          |   6 +
 builtin/fsck.c                           |   2 +
 builtin/fsmonitor--daemon.c              |   1 +
 builtin/gc.c                             |   2 +
 builtin/grep.c                           |   3 +
 builtin/hash-object.c                    |   1 +
 builtin/help.c                           |   1 +
 builtin/index-pack.c                     |   3 +
 builtin/init-db.c                        |   1 +
 builtin/log.c                            |   4 +
 builtin/ls-files.c                       |   2 +
 builtin/ls-tree.c                        |   1 +
 builtin/merge-base.c                     |   1 +
 builtin/merge-recursive.c                |   2 +
 builtin/merge-tree.c                     |   1 +
 builtin/merge.c                          |   3 +
 builtin/mktag.c                          |   1 +
 builtin/mv.c                             |   2 +
 builtin/name-rev.c                       |   2 +
 builtin/notes.c                          |   2 +
 builtin/pack-objects.c                   |   1 +
 builtin/prune.c                          |   2 +
 builtin/pull.c                           |   2 +
 builtin/push.c                           |   2 +
 builtin/range-diff.c                     |   1 +
 builtin/read-tree.c                      |   1 +
 builtin/rebase.c                         |   3 +
 builtin/receive-pack.c                   |   3 +
 builtin/replace.c                        |   3 +
 builtin/reset.c                          |   4 +
 builtin/rev-list.c                       |   2 +
 builtin/rev-parse.c                      |   1 +
 builtin/rm.c                             |   1 +
 builtin/show-branch.c                    |   1 +
 builtin/show-ref.c                       |   1 +
 builtin/sparse-checkout.c                |   2 +
 builtin/stash.c                          |   1 +
 builtin/submodule--helper.c              |   2 +
 builtin/tag.c                            |   3 +
 builtin/unpack-file.c                    |   1 +
 builtin/unpack-objects.c                 |   1 +
 builtin/update-index.c                   |   1 +
 builtin/update-ref.c                     |   1 +
 builtin/var.c                            |   2 +
 builtin/verify-commit.c                  |   1 +
 builtin/verify-tag.c                     |   1 +
 builtin/worktree.c                       |   2 +
 bulk-checkin.c                           |   4 +-
 bundle.c                                 |   2 +-
 cache-tree.c                             |   3 +
 cache.h                                  | 330 -----------------------
 chdir-notify.c                           |   4 +-
 checkout.c                               |   4 +-
 color.c                                  |   2 +
 column.c                                 |   3 +-
 combine-diff.c                           |   3 +
 commit-graph.c                           |   4 +-
 commit.c                                 |   3 +-
 common-main.c                            |   1 +
 compat/fsmonitor/fsm-listen-win32.c      |   1 +
 compat/mingw.c                           |   1 +
 compat/pread.c                           |   1 +
 compat/simple-ipc/ipc-unix-socket.c      |   3 +-
 compat/simple-ipc/ipc-win32.c            |   2 +
 compat/win32/trace2_win32_process_info.c |   1 +
 config.c                                 |   6 +
 connect.c                                |   2 +-
 convert.c                                |   3 +
 date.c                                   |   1 +
 delta-islands.c                          |   2 +-
 diff-lib.c                               |   2 +
 diff-no-index.c                          |   2 +-
 diff.c                                   |   5 +
 dir.c                                    |   3 +
 editor.c                                 |  34 ++-
 editor.h                                 |  34 +++
 environment.c                            |   4 +-
 exec-cmd.c                               |   2 +
 fetch-pack.c                             |   3 +-
 fmt-merge-msg.c                          |   3 +-
 fsck.c                                   |   2 +-
 fsmonitor.c                              |   1 +
 fsmonitor.h                              |   1 +
 git-compat-util.h                        |   6 -
 zlib.c => git-zlib.c                     |   3 +-
 git-zlib.h                               |  28 ++
 git.c                                    |   3 +
 grep.c                                   |   1 +
 http-backend.c                           |   3 +-
 http-fetch.c                             |   2 +-
 http-push.c                              |   2 +-
 http-walker.c                            |   2 +-
 http.c                                   |   2 +
 http.h                                   |   4 +-
 list-objects-filter.c                    |   3 +-
 list-objects.c                           |   2 +-
 ll-merge.c                               |   1 +
 log-tree.c                               |   3 +-
 mailmap.c                                |   3 +-
 mailmap.h                                |   3 +
 merge-ort.c                              |   4 +
 merge-recursive.c                        |   2 +
 midx.c                                   |   1 +
 name-hash.c                              |   1 +
 notes-merge.c                            |   6 +-
 notes.c                                  |   3 +-
 object-file.c                            |   2 +
 object-file.h                            | 129 +++++++++
 object-name.c                            |   2 +
 object-name.h                            | 121 +++++++++
 object.c                                 |   1 +
 object.h                                 |  44 +++
 pack-bitmap-write.c                      |   2 +-
 pack-bitmap.c                            |   4 +-
 pack-check.c                             |   3 +-
 pack-mtimes.c                            |   3 +-
 pack-revindex.c                          |   4 +-
 pack-write.c                             |   4 +-
 packfile.c                               |   3 +
 pager.c                                  |   6 +-
 pager.h                                  |  17 ++
 parse-options-cb.c                       |   2 +-
 path.c                                   |   1 +
 pkt-line.c                               |   1 +
 preload-index.c                          |   1 +
 pretty.c                                 |   3 +-
 progress.c                               |   4 +-
 promisor-remote.c                        |   3 +-
 protocol.c                               |   3 +-
 quote.c                                  |   3 +-
 quote.h                                  |   2 +
 range-diff.c                             |   2 +
 read-cache.c                             |   5 +
 rebase-interactive.c                     |   4 +-
 ref-filter.c                             |   2 +
 refs.c                                   |   4 +-
 refs/files-backend.c                     |   1 +
 refs/packed-backend.c                    |   1 +
 refs/ref-cache.h                         |   2 +-
 remote-curl.c                            |   1 +
 remote.c                                 |   3 +-
 repository.c                             |   1 +
 rerere.c                                 |   3 +-
 reset.c                                  |   1 +
 resolve-undo.h                           |   7 +-
 revision.c                               |   5 +-
 run-command.c                            |   2 +
 scalar.c                                 |   3 +-
 send-pack.c                              |   1 +
 sequencer.c                              |   4 +
 server-info.c                            |   1 +
 setup.c                                  |   5 +-
 shallow.c                                |   1 +
 sideband.c                               |   3 +-
 split-index.c                            |   1 +
 split-index.h                            |   2 +-
 strbuf.c                                 |  31 +--
 strbuf.h                                 |  24 --
 streaming.c                              |   4 +-
 submodule-config.c                       |   3 +-
 submodule.c                              |   3 +
 t/helper/test-date.c                     |   2 +-
 t/helper/test-fast-rebase.c              |   1 +
 t/helper/test-lazy-init-name-hash.c      |   1 +
 t/helper/test-match-trees.c              |   1 +
 t/helper/test-mergesort.c                |   1 +
 t/helper/test-oidmap.c                   |   2 +-
 t/helper/test-path-utils.c               |   1 +
 t/helper/test-reach.c                    |   2 +-
 t/helper/test-submodule-config.c         |   2 +-
 tag.c                                    |   3 +-
 tmp-objdir.c                             |   3 +-
 trace.c                                  |   3 +-
 trace2.c                                 |   1 +
 transport-helper.c                       |   3 +-
 transport.c                              |   5 +-
 tree-walk.c                              |   2 +
 tree.c                                   |   1 +
 unpack-trees.c                           |   2 +
 unpack-trees.h                           |   1 +
 upload-pack.c                            |   5 +-
 walker.c                                 |   2 +-
 wrapper.c                                |   1 +
 wt-status.c                              |   4 +
 215 files changed, 805 insertions(+), 458 deletions(-)
 create mode 100644 editor.h
 rename zlib.c => git-zlib.c (99%)
 create mode 100644 git-zlib.h
 create mode 100644 object-file.h
 create mode 100644 object-name.h
 create mode 100644 pager.h


base-commit: dc1c48a4a2bce29542f330137106c01daa728f9e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1509%2Fnewren%2Fheader-cleanup-3-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1509/newren/header-cleanup-3-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1509

Range-diff vs v2:

  1:  6acf4eb2c77 !  1:  eb90e25c53e treewide: be explicit about dependence on trace.h & trace2.h
     @@ Commit message
          explicitly include trace.h or trace2.h if they are using them.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## blame.c ##
      @@
  2:  e163bed61ff !  2:  af2c81883f2 treewide: be explicit about dependence on advice.h
     @@ Commit message
          advice.h if they are using it.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## add-patch.c ##
      @@
  3:  4ef4ee9daf3 !  3:  146aaef8e6a treewide: be explicit about dependence on convert.h
     @@ Commit message
          treewide: be explicit about dependence on convert.h
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## archive.c ##
      @@
  4:  86b47be1776 !  4:  bcc35c33728 treewide: be explicit about dependence on pack-revindex.h
     @@ Commit message
          treewide: be explicit about dependence on pack-revindex.h
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## builtin/index-pack.c ##
      @@
  5:  81a9378be43 !  5:  f3c5ad2a2be treewide: be explicit about dependence on oid-array.h
     @@ Commit message
          treewide: be explicit about dependence on oid-array.h
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## builtin/bisect.c ##
      @@
  6:  c6a561cf433 !  6:  063298fec2d treewide: be explicit about dependence on mem-pool.h
     @@ Commit message
          treewide: be explicit about dependence on mem-pool.h
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## builtin/checkout.c ##
      @@
  7:  3c12d5ba6c3 !  7:  c80b25eed80 treewide: remove unnecessary cache.h inclusion
     @@ Commit message
          is no longer needed in several cases.  Remove it.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## compat/simple-ipc/ipc-unix-socket.c ##
      @@
  8:  1e2e60bffc7 !  8:  3559fbd7b7e object-name.h: move declarations for object-name.c functions from cache.h
     @@ Commit message
          object-name.h: move declarations for object-name.c functions from cache.h
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## add-patch.c ##
      @@
  9:  62f61514e2f !  9:  c930f9b2cad treewide: remove cache.h inclusion due to object-name.h changes
     @@ Commit message
          treewide: remove cache.h inclusion due to object-name.h changes
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## branch.c ##
      @@
 10:  54545bbb02c ! 10:  5e6f971d43f git-zlib: move declarations for git-zlib functions from cache.h
     @@ Commit message
          to git-zlib.c while we are at it.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## Makefile ##
      @@ Makefile: LIB_OBJS += fsmonitor.o
 11:  dbfe03129e3 ! 11:  74848b59f84 treewide: remove cache.h inclusion due to git-zlib changes
     @@ Commit message
          will help with several more files.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## http-backend.c ##
      @@
 12:  5efd49df148 ! 12:  78fd01017ee object-file.h: move declarations for object-file.c functions from cache.h
     @@ Commit message
          object-file.h: move declarations for object-file.c functions from cache.h
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## apply.c ##
      @@
 13:  1827ecb4d1d ! 13:  81313a5c304 treewide: remove cache.h inclusion due to object-file.h changes
     @@ Commit message
          treewide: remove cache.h inclusion due to object-file.h changes
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## bulk-checkin.c ##
      @@
 14:  8937f6d5ac5 ! 14:  2a43afb7951 object.h: move some inline functions and defines from cache.h
     @@ Commit message
          object.h.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## cache.h ##
      @@
 15:  c85f9baed8c ! 15:  29cf21b52d3 treewide: remove cache.h inclusion due to object.h changes
     @@ Commit message
          treewide: remove cache.h inclusion due to object.h changes
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## bisect.c ##
      @@
 16:  0ac095731a7 ! 16:  3b25f2880e5 editor: move editor-related functions and declarations into common file
     @@ Commit message
          editor.[ch].
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## add-patch.c ##
      @@
 17:  9550d976141 ! 17:  515eed36f3d treewide: remove cache.h inclusion due to editor.h changes
     @@ Commit message
          that will be applied.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## sideband.c ##
      @@
 18:  d658ee210d9 ! 18:  775332fdf12 pager.h: move declarations for pager.c functions from cache.h
     @@ Commit message
          pager.h: move declarations for pager.c functions from cache.h
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## builtin/am.c ##
      @@
 19:  07d1a65a0ec ! 19:  7fd8079a2ea treewide: remove cache.h inclusion due to pager.h changes
     @@ Commit message
          treewide: remove cache.h inclusion due to pager.h changes
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## column.c ##
      @@
 20:  23e0a81e788 ! 20:  8be1673ba37 cache.h: remove unnecessary includes
     @@ Commit message
          upon cache.h needed them either.  Simply expunge these includes.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## cache.h ##
      @@
 21:  47afc6a6c87 <  -:  ----------- strbuf: move forward declarations to beginning of file
 22:  6079c470cd1 ! 21:  6a853d51522 treewide: remove double forward declaration of read_in_full
     @@ Commit message
          declaration and just have compat/pread.c include wrapper.h.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## builtin/clone.c ##
      @@
 23:  538d95833a2 ! 22:  8c9260bc7b8 treewide: reduce includes of cache.h in other headers
     @@ Commit message
          defined in it.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## archive.h ##
      @@
 24:  30e37a37c12 ! 23:  4b09ea7d413 mailmap, quote: move declarations of global vars to correct unit
     @@ Commit message
          from cache.h to mailmap.c and quote.c.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Calvin Wan <calvinwan@google.com>
      
       ## cache.h ##
      @@ cache.h: void set_alternate_index_output(const char *);

-- 
gitgitgadget
