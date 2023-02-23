Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2737C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjBWIF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjBWIF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F7F2CFE2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h14so1246171wru.4
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FKFuKOw785PtQFFY/uBeNFk09xSF+xdA9Ie/xZMG3F4=;
        b=NTcT42Wf7uwmmc/Oj/2ukPnk6OzZ+8mkdGllaYt7eCqvQS77Cb+9o8c20D9EaFiDWr
         hp70U9PZFP9jsYZ9SF0DY3+tj1Ar0RUzILe5yDii85RuOoNCFCJN+jaRfxTiO8RUPm43
         g83DRV8fBm/9/VcSuxB8tn7AHlcs+wTfa9sBZDiTwl4q/VpFC4zqoZ2cIchjHbe8Z55o
         Ruyfja3nf3EBXbt/Wz75DX41U/KPJ6iCE+4OWmv0YBxYhpJA8mOL2sU87o2lusknaLfa
         ubcsxMBxX/hoFnElijy0THMi/qrnIBET6RShEIpEpBSMm1vX4vVieixiIerWMfpYxbMP
         g3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKFuKOw785PtQFFY/uBeNFk09xSF+xdA9Ie/xZMG3F4=;
        b=vsow0hyqbUBvpYZBu/PBhSWlKfXbPkxjpLmd4/Mpg2dvimu9bN3Wcw9E796k00G/p8
         W/8KgT/1cmIFpPCqxf/S4/BQ5BAXKLQ+zfNI6pZtRIb/IuPS6ECdviV+JD1Sx5TdrKIV
         +DdrPlhWUpdwfVGNg+OfwXUDcWfb01nDCV5pdeevwd4Q7BAcr3or3kpCM9oJmE7cFQQk
         FgZ1exXad0BELhDhef2HaBtrdScWhzpYBhpT7tldoAOZcTbH+J3Rhqx2ewSgf92NGOK9
         AfwaAZWyS00rO8EPQedY/YPIJP+AmSOGLylN9CVJ8lRIrMg2z657ukk8Yswb6Ok1d6vk
         4Nkw==
X-Gm-Message-State: AO0yUKXTj57SvnTPsc0uDlTUQLhkFea6FCgFSms+9FIeEUKDCIzA1Y38
        77rnynhaeFjskyyxeLHyel+MvowmbWk=
X-Google-Smtp-Source: AK7set9ELYKoMZbEYg28ely+0ZldjF1ZloV0MNX546oHzWNriCTzpTt6yhykkNN1Ouk+glJuMeFLiw==
X-Received: by 2002:a5d:55c7:0:b0:2c5:81a4:1f63 with SMTP id i7-20020a5d55c7000000b002c581a41f63mr9842054wrw.40.1677139523620;
        Thu, 23 Feb 2023 00:05:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8-20020adfdd88000000b002c58ca558b6sm8880163wrl.88.2023.02.23.00.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:23 -0800 (PST)
Message-Id: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:05 +0000
Subject: [PATCH 00/16] Header cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maintainer note: This series cleanly merges with next, but has a minor
conflict with ed/fsmonitor-inotify. The correct resolution is to take
ed/fsmonitor-inotify's copy of compat/fsmonitor/fsm-settings-darwin.c, but
to add a #include "git-compat-util.h" line at the top of
compat/fsmonitor/fsm-settings-unix.c.

This series cleans up headers a bit, trying to remove excessive dependency
on "cache.h". I created this series a while ago, but decided to clean it up
and submit it due to Emily's recent thread and suggestion that this might be
helpful to their efforts[1].

There are many more cleanups I could do in this area, but the series is
already a good size.

Notes:

 * Big props to Dscho for gitgitgadget; being able to test on a bunch of
   platforms with a variety of configurations easily is a big win in general
   but especially for series like this one.
 * I used the scripts at
   https://github.com/newren/git/commit/db81c8d7fb554b3edf04320e218bddeb98bb6194,
   and some tweaks thereof, repeatedly while making this series (though they
   are prone to produce both false positive and false negatives, so if you
   use them, only use them to generate hints about which files to look at).

[1] Search for "Extremely yes" in
https://lore.kernel.org/git/CAJoAoZm+TkCL0Jpg_qFgKottxbtiG2QOiY0qGrz3-uQy+=waPg@mail.gmail.com/

Elijah Newren (16):
  treewide: ensure one of the appropriate headers is sourced first
  treewide: remove unnecessary git-compat-util.h includes in headers
  treewide: remove unnecessary cache.h includes
  treewide: remove unnecessary cache.h includes in source files
  alloc.h: move ALLOC_GROW() functions from cache.h
  hash.h: move some oid-related declarations from cache.h
  hex.h: move some hex-related declarations from cache.h
  pretty.h: move has_non_ascii() declaration from commit.h
  ident.h: move ident-related declarations out of cache.h
  object.h: stop depending on cache.h; make cache.h depend on object.h
  dir.h: refactor to no longer need to include cache.h
  object-store.h: move struct object_info from cache.h
  replace-object.h: move read_replace_refs declaration from cache.h to
    here
  treewide: replace cache.h with more direct headers, where possible
  Remove unnecessary includes of builtin.h
  diff.h: remove unnecessary include of object.h

 Documentation/CodingGuidelines               |   8 +-
 add-patch.c                                  |   2 +
 advice.c                                     |   4 +-
 advice.h                                     |   2 -
 alias.c                                      |   4 +-
 alloc.c                                      |   2 +-
 alloc.h                                      |  75 +++++
 apply.c                                      |   1 +
 archive-tar.c                                |   3 +-
 archive.c                                    |   3 +-
 attr.c                                       |   1 +
 blame.h                                      |   1 -
 blob.c                                       |   2 +-
 builtin/blame.c                              |   3 +-
 builtin/cat-file.c                           |   3 +
 builtin/check-mailmap.c                      |   1 +
 builtin/checkout--worker.c                   |   1 +
 builtin/commit-graph.c                       |   1 +
 builtin/config.c                             |   3 +-
 builtin/credential-cache--daemon.c           |   1 +
 builtin/fetch-pack.c                         |   1 +
 builtin/fsck.c                               |   1 +
 builtin/fsmonitor--daemon.c                  |   1 +
 builtin/grep.c                               |   1 +
 builtin/index-pack.c                         |   2 +
 builtin/log.c                                |   3 +-
 builtin/merge.c                              |   1 +
 builtin/mktree.c                             |   1 +
 builtin/mv.c                                 |   1 +
 builtin/name-rev.c                           |   2 +-
 builtin/pack-objects.c                       |   3 +-
 builtin/prune.c                              |   1 +
 builtin/repack.c                             |   2 +-
 builtin/replace.c                            |   1 +
 builtin/rev-parse.c                          |   1 +
 builtin/revert.c                             |   3 +-
 builtin/rm.c                                 |   1 +
 builtin/submodule--helper.c                  |   1 +
 builtin/unpack-objects.c                     |   1 +
 builtin/upload-pack.c                        |   1 +
 builtin/var.c                                |   1 +
 bulk-checkin.c                               |   3 +-
 cache-tree.c                                 |   3 +-
 cache-tree.h                                 |   1 -
 cache.h                                      | 306 +------------------
 cbtree.c                                     |   1 +
 cbtree.h                                     |   2 -
 checkout.h                                   |   2 +-
 chunk-format.c                               |   3 +-
 chunk-format.h                               |   1 -
 commit-graph.h                               |   1 -
 commit-reach.c                               |   3 +-
 commit-slab-impl.h                           |   2 -
 commit.h                                     |   1 -
 compat/fsmonitor/fsm-ipc-win32.c             |   1 +
 compat/fsmonitor/fsm-settings-darwin.c       |   1 +
 compat/mingw.c                               |   1 +
 config.c                                     |   5 +-
 daemon.c                                     |   1 +
 decorate.c                                   |   3 +-
 delta-islands.c                              |   3 +-
 diff-merges.c                                |   2 +
 diff-no-index.c                              |   1 -
 diff.c                                       |   1 +
 diff.h                                       |   3 +-
 diffcore-delta.c                             |   2 +-
 diffcore-order.c                             |   3 +-
 diffcore-pickaxe.c                           |   4 +-
 diffcore-rename.c                            |   7 +-
 diffcore-rotate.c                            |   3 +-
 diffcore.h                                   |   4 +-
 dir-iterator.c                               |   3 +-
 dir.c                                        |   3 +-
 dir.h                                        |  16 +-
 entry.h                                      |   4 +-
 environment.c                                |   1 +
 ewah/bitmap.c                                |   3 +-
 ewah/ewah_bitmap.c                           |   2 +-
 fetch-pack.c                                 |   3 +-
 fmt-merge-msg.c                              |   2 +
 fsck.c                                       |   3 +-
 fsck.h                                       |   1 +
 fsmonitor-settings.c                         |   3 +-
 git-compat-util.h                            |   1 +
 git.c                                        |   1 +
 gpg-interface.c                              |   1 +
 graph.c                                      |   3 +-
 hash.h                                       |  35 ++-
 hashmap.c                                    |   2 +-
 help.c                                       |   4 +-
 hex.c                                        |   3 +-
 hex.h                                        |  84 +++++
 hook.c                                       |   5 +-
 http-backend.c                               |   3 +-
 ident.c                                      |   5 +-
 ident.h                                      |  67 ++++
 imap-send.c                                  |   2 +-
 json-writer.c                                |   2 +-
 khash.h                                      |   1 -
 kwset.c                                      |   2 +-
 levenshtein.c                                |   2 +-
 line-log.c                                   |   1 +
 line-log.h                                   |   1 +
 linear-assignment.c                          |   2 +-
 list-objects-filter-options.c                |   4 +-
 list-objects-filter-options.h                |   3 +-
 list-objects-filter.c                        |   1 +
 log-tree.c                                   |   1 +
 mailinfo.c                                   |   4 +-
 mem-pool.c                                   |   2 +-
 merge-blobs.c                                |   2 +-
 merge-recursive.c                            |   1 -
 midx.c                                       |   3 +-
 negotiator/noop.c                            |   2 +-
 object-file.c                                |   3 +-
 object-store.h                               | 128 ++++----
 object.h                                     |  22 +-
 oid-array.c                                  |   3 +-
 oidmap.c                                     |   2 +-
 oidmap.h                                     |   1 -
 oidset.c                                     |   4 +-
 oidtree.c                                    |   1 +
 oss-fuzz/fuzz-commit-graph.c                 |   1 +
 oss-fuzz/fuzz-pack-headers.c                 |   1 +
 oss-fuzz/fuzz-pack-idx.c                     |   1 +
 pack-bitmap-write.c                          |   3 +-
 pack-bitmap.c                                |   3 +-
 pack-mtimes.h                                |   2 -
 pack-objects.c                               |   3 +-
 packfile.c                                   |   3 +-
 parallel-checkout.c                          |   1 +
 pathspec.h                                   |   5 +
 pkt-line.h                                   |   1 -
 pretty.c                                     |   1 +
 pretty.h                                     |   4 +-
 prio-queue.c                                 |   3 +-
 protocol-caps.c                              |   1 +
 prune-packed.c                               |   1 +
 quote.c                                      |   2 +
 read-cache.c                                 |   1 +
 rebase.c                                     |   1 +
 ref-filter.c                                 |   5 +-
 reflog-walk.c                                |   3 +-
 reflog-walk.h                                |   2 -
 refs.c                                       |   3 +-
 refs/debug.c                                 |   2 +-
 refs/files-backend.c                         |   1 +
 refs/packed-backend.c                        |   3 +-
 refs/ref-cache.c                             |   3 +-
 refs/refs-internal.h                         |   1 -
 refspec.c                                    |   3 +-
 remote-curl.c                                |   3 +-
 remote.c                                     |   3 +-
 remote.h                                     |   1 -
 replace-object.h                             |   8 +
 repo-settings.c                              |   2 +-
 repository.h                                 |   1 -
 rerere.c                                     |   3 +-
 revision.c                                   |   3 +-
 revision.h                                   |   1 +
 send-pack.c                                  |   2 +-
 sequencer.c                                  |   1 +
 sequencer.h                                  |   2 +-
 serve.c                                      |   3 +-
 server-info.c                                |   3 +-
 sha1dc_git.c                                 |   4 +-
 shallow.c                                    |   3 +-
 shallow.h                                    |   2 +
 shell.c                                      |   2 +-
 sigchain.c                                   |   3 +-
 sparse-index.c                               |   1 +
 split-index.c                                |   1 +
 statinfo.h                                   |  24 ++
 strbuf.c                                     |   3 +-
 string-list.c                                |   3 +-
 strvec.c                                     |   3 +-
 sub-process.c                                |   1 +
 sub-process.h                                |   1 -
 submodule-config.c                           |   1 +
 submodule-config.h                           |   1 -
 submodule.c                                  |   4 +-
 t/helper/test-bloom.c                        |   2 +-
 t/helper/test-crontab.c                      |   1 -
 t/helper/test-ctype.c                        |   1 -
 t/helper/test-example-decorate.c             |   2 +-
 t/helper/test-json-writer.c                  |   1 -
 t/helper/test-pcre2-config.c                 |   1 -
 t/helper/test-prio-queue.c                   |   1 -
 t/helper/test-reach.c                        |   2 +-
 t/helper/test-run-command.c                  |   2 -
 t/helper/test-sigchain.c                     |   1 -
 t/helper/test-simple-ipc.c                   |   3 +-
 t/helper/test-submodule-nested-repo-config.c |   1 +
 t/helper/test-wildmatch.c                    |   1 -
 thread-utils.c                               |   2 +-
 trace.h                                      |   1 -
 trace2.c                                     |   3 +-
 trace2/tr2_ctr.c                             |   2 +-
 trace2/tr2_sysenv.c                          |   2 +-
 trace2/tr2_tbuf.c                            |   2 +-
 trace2/tr2_tgt_event.c                       |   2 +-
 trace2/tr2_tgt_normal.c                      |   2 +-
 trace2/tr2_tgt_perf.c                        |   2 +-
 trace2/tr2_tls.c                             |   4 +-
 trace2/tr2_tmr.c                             |   3 +-
 trailer.c                                    |   1 +
 transport.c                                  |   4 +-
 tree-walk.c                                  |   1 +
 tree-walk.h                                  |   4 +-
 unix-socket.c                                |   3 +-
 unix-stream-server.c                         |   2 +-
 url.c                                        |   4 +-
 urlmatch.c                                   |   5 +-
 userdiff.c                                   |   4 +-
 wildmatch.c                                  |   2 +-
 worktree.c                                   |   3 +-
 worktree.h                                   |   1 -
 xdiff-interface.h                            |   2 +-
 218 files changed, 691 insertions(+), 529 deletions(-)
 create mode 100644 hex.h
 create mode 100644 ident.h
 create mode 100644 statinfo.h


base-commit: 06dd2baa8da4a73421b959ec026a43711b9d77f9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1485%2Fnewren%2Fheader-cleanups-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1485/newren/header-cleanups-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1485
-- 
gitgitgadget
