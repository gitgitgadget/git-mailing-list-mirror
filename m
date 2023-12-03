Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acBJ79Ro"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17195E6
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 22:41:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40838915cecso35156675e9.2
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 22:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701585685; x=1702190485; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KS0enFIR+OSZEWoFObZ3wTn17dNkIIzYFWW+JS8pCdE=;
        b=acBJ79RomDV0B0qjxb+NjyYZEOgFCqXPl2ppB8lxpwRZ1W6oscWSZSdyscxx30RZyK
         dI+8KL8zSfZ/hlnEDhNz+EHMlLcCVgE+1alx9xM6arXlDYoarl+6+5r4PpvIUAwxu+2p
         vgXHulZi0oLj1mmF2Ih36sRBDVmUFYGdJFeV+k08yKix4cg1XUV/oJG+CafMTP8hfqqh
         4wXFZTvb2qiXqrR2NuwhN7UY/bJN1AINmx13gti+b+YUPcn49lnyNsNHyW3GuuM6cWvN
         IU7Cj2G0iuUrxP9ZQ77kTChRF0TB0EFMi6+q9qTv8UhUWHSiERnkIQOSAwWwwG6UCX2s
         0LLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701585685; x=1702190485;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KS0enFIR+OSZEWoFObZ3wTn17dNkIIzYFWW+JS8pCdE=;
        b=uh5vm2ltH+A3YiofBwRV8NxQA062QP2gQr9nhguhal4OxTEM22QRTtXHicBv6rb30t
         eJA8PZKz8xb74CGECMRxf+Ys714V10wU++S6qcb6rXwAaJ0m8tJ3a3HWjvUOYLkeA3bo
         ZBFiUH0CSZ2PKhKdx2H6sOpNq1UD9GxUt1C1VmvdKapfzSpFYWq+JYjppQWDxcPS8n6J
         /yoMqEMKZDh3sD2poe/0mNErBiB64YWwSwtDDwjwVI2+H8dGUuCi9r4cD+E+iOgq/QNU
         ESKYrS9LvTrQNAxvAaaM6XIn5/1QPC8pj8/m/FsIfUSGX7kOQicpha0yKEY5406N/VgV
         dCiA==
X-Gm-Message-State: AOJu0YwhDdovgOSawxmnQWOQMm68Wf4exkqv9WtnJkVJEkuw/7yzulcu
	OWDLr+yCJcsJ7/C7AHNjGUyvzvj9bEI=
X-Google-Smtp-Source: AGHT+IFQM6IHRHp4eErdwij1F7AI85oF28cE1H99N+lGEVIwy54yrZL1Cab3qUlVYbUezOe9LAGvLg==
X-Received: by 2002:a05:600c:3795:b0:40b:5e59:da95 with SMTP id o21-20020a05600c379500b0040b5e59da95mr1485548wmr.168.1701585684743;
        Sat, 02 Dec 2023 22:41:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040b349c91acsm14389956wmq.16.2023.12.02.22.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:41:24 -0800 (PST)
Message-ID: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 06:41:09 +0000
Subject: [PATCH 00/12] Additional header cleanups (removing unnecessary includes)
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>

Several months ago, I sent in several series cleaning up headers, ultimately
removing cache.h. I had two other series ready to share, but...life
happened.

I've rebased and cleaned up these last two series, focusing on just reducing
unnecessary includes. Here's the first of the two.

Elijah Newren (12):
  treewide: remove unnecessary includes from header files
  treewide: remove unnecessary includes in source files
  archive.h: remove unnecessary include
  blame.h: remove unnecessary includes
  fsmonitor--daemon.h: remove unnecessary includes
  http.h: remove unnecessary include
  line-log.h: remove unnecessary include
  pkt-line.h: remove unnecessary include
  submodule-config.h: remove unnecessary include
  trace2/tr2_tls.h: remove unnecessary include
  treewide: add direct includes currently only pulled in transitively
  treewide: remove unnecessary includes in source files

 add-patch.c                          | 1 -
 apply.c                              | 1 -
 archive-tar.c                        | 1 +
 archive-zip.c                        | 1 +
 archive.c                            | 2 +-
 archive.h                            | 1 -
 attr.c                               | 1 -
 bisect.c                             | 1 -
 blame.c                              | 2 ++
 blame.h                              | 3 ---
 blob.c                               | 1 -
 bloom.c                              | 1 -
 builtin/add.c                        | 3 ---
 builtin/am.c                         | 4 ----
 builtin/apply.c                      | 1 -
 builtin/archive.c                    | 1 -
 builtin/bisect.c                     | 1 -
 builtin/blame.c                      | 1 -
 builtin/branch.c                     | 3 ---
 builtin/cat-file.c                   | 1 -
 builtin/checkout-index.c             | 1 -
 builtin/checkout.c                   | 3 ---
 builtin/clone.c                      | 1 -
 builtin/commit-graph.c               | 3 +--
 builtin/commit-tree.c                | 3 ---
 builtin/commit.c                     | 8 --------
 builtin/credential-cache.c           | 2 --
 builtin/describe.c                   | 2 --
 builtin/diff-files.c                 | 1 -
 builtin/diff-index.c                 | 2 --
 builtin/diff-tree.c                  | 1 -
 builtin/diff.c                       | 2 --
 builtin/difftool.c                   | 1 -
 builtin/fast-export.c                | 1 -
 builtin/fetch.c                      | 2 --
 builtin/for-each-ref.c               | 3 +--
 builtin/fsck.c                       | 3 ---
 builtin/fsmonitor--daemon.c          | 5 +++--
 builtin/get-tar-commit-id.c          | 1 -
 builtin/grep.c                       | 4 ----
 builtin/hash-object.c                | 1 -
 builtin/hook.c                       | 1 -
 builtin/index-pack.c                 | 2 --
 builtin/init-db.c                    | 1 -
 builtin/log.c                        | 2 --
 builtin/ls-files.c                   | 4 ----
 builtin/ls-remote.c                  | 1 -
 builtin/ls-tree.c                    | 2 --
 builtin/mailinfo.c                   | 1 -
 builtin/merge-base.c                 | 3 ---
 builtin/merge-recursive.c            | 3 ---
 builtin/merge-tree.c                 | 1 -
 builtin/merge.c                      | 4 ----
 builtin/mktag.c                      | 1 -
 builtin/mv.c                         | 1 -
 builtin/notes.c                      | 2 --
 builtin/pack-objects.c               | 3 ---
 builtin/pull.c                       | 5 -----
 builtin/push.c                       | 1 -
 builtin/range-diff.c                 | 1 -
 builtin/read-tree.c                  | 2 --
 builtin/rebase.c                     | 4 ----
 builtin/receive-pack.c               | 1 -
 builtin/repack.c                     | 1 -
 builtin/rerere.c                     | 1 -
 builtin/reset.c                      | 3 ---
 builtin/rev-list.c                   | 2 --
 builtin/revert.c                     | 2 --
 builtin/rm.c                         | 1 -
 builtin/send-pack.c                  | 5 -----
 builtin/show-ref.c                   | 1 -
 builtin/sparse-checkout.c            | 4 ----
 builtin/stash.c                      | 1 -
 builtin/submodule--helper.c          | 1 -
 builtin/tag.c                        | 1 -
 builtin/unpack-objects.c             | 4 ----
 builtin/update-ref.c                 | 1 -
 builtin/verify-commit.c              | 2 --
 builtin/verify-tag.c                 | 1 -
 bulk-checkin.c                       | 1 -
 bundle-uri.c                         | 1 -
 cache-tree.c                         | 1 -
 combine-diff.c                       | 1 -
 commit-graph.c                       | 3 +--
 commit-reach.c                       | 1 -
 commit.c                             | 2 --
 compat/fsmonitor/fsm-health-win32.c  | 1 +
 compat/fsmonitor/fsm-listen-darwin.c | 1 +
 compat/fsmonitor/fsm-listen-win32.c  | 1 +
 compat/simple-ipc/ipc-shared.c       | 3 ---
 compat/simple-ipc/ipc-unix-socket.c  | 1 -
 config.c                             | 3 ---
 delta-islands.c                      | 5 -----
 diff-lib.c                           | 1 -
 diff-no-index.c                      | 3 ---
 diff.c                               | 2 --
 diffcore-break.c                     | 1 -
 diffcore-delta.c                     | 1 -
 dir.c                                | 1 -
 entry.c                              | 1 -
 exec-cmd.c                           | 1 -
 fetch-pack.c                         | 2 --
 fetch-pack.h                         | 1 -
 fsck.c                               | 1 -
 fsmonitor--daemon.h                  | 4 +---
 fsmonitor-ipc.c                      | 1 -
 gettext.c                            | 2 --
 gpg-interface.c                      | 1 -
 grep.c                               | 1 -
 http-fetch.c                         | 2 +-
 http-push.c                          | 3 +--
 http-walker.c                        | 1 -
 http.c                               | 2 --
 http.h                               | 1 -
 imap-send.c                          | 2 --
 line-log.c                           | 4 +---
 line-log.h                           | 2 --
 line-range.c                         | 1 -
 list-objects-filter-options.c        | 5 -----
 list-objects-filter.c                | 5 -----
 log-tree.c                           | 1 +
 ls-refs.c                            | 1 -
 merge-blobs.c                        | 2 --
 merge-ort.c                          | 3 ---
 merge-recursive.c                    | 5 -----
 merge.c                              | 3 ---
 midx.h                               | 1 -
 negotiator/noop.c                    | 1 -
 notes-utils.c                        | 1 -
 notes.c                              | 2 --
 object-file.c                        | 8 --------
 object-name.c                        | 2 --
 pack-bitmap-write.c                  | 3 ---
 pack-check.c                         | 1 -
 pack-write.c                         | 1 -
 packfile.c                           | 1 -
 parse-options.c                      | 2 --
 patch-ids.c                          | 1 -
 pkt-line.c                           | 1 +
 pkt-line.h                           | 1 -
 protocol-caps.c                      | 1 -
 reachable.c                          | 1 -
 read-cache.c                         | 2 --
 ref-filter.c                         | 3 ---
 ref-filter.h                         | 1 -
 reflog.c                             | 1 -
 refs/files-backend.c                 | 2 --
 refs/packed-backend.c                | 1 -
 refs/ref-cache.c                     | 1 -
 reftable/dump.c                      | 2 --
 reftable/generic.c                   | 1 -
 reftable/merged.c                    | 1 -
 reftable/merged_test.c               | 1 -
 reftable/reader.c                    | 1 -
 reftable/readwrite_test.c            | 1 -
 reftable/refname_test.c              | 1 -
 reftable/stack_test.c                | 1 -
 reftable/test_framework.c            | 1 -
 reftable/tree_test.c                 | 2 --
 remote-curl.c                        | 3 +--
 remote.c                             | 1 -
 repo-settings.c                      | 1 -
 rerere.c                             | 2 --
 reset.c                              | 1 -
 revision.c                           | 2 --
 run-command.c                        | 2 --
 send-pack.c                          | 2 --
 sequencer.c                          | 3 ---
 setup.c                              | 1 -
 shallow.c                            | 1 -
 shell.c                              | 1 -
 submodule-config.h                   | 2 --
 submodule.c                          | 3 ---
 t/helper/test-bundle-uri.c           | 2 --
 t/helper/test-fast-rebase.c          | 1 -
 t/helper/test-pkt-line.c             | 1 +
 t/helper/test-reach.c                | 2 --
 t/helper/test-repository.c           | 2 --
 t/helper/test-simple-ipc.c           | 1 -
 t/helper/test-submodule.c            | 1 +
 t/helper/test-trace2.c               | 1 -
 tmp-objdir.c                         | 1 -
 trace2.c                             | 4 ----
 trace2/tr2_ctr.c                     | 1 -
 trace2/tr2_tgt_normal.c              | 1 +
 trace2/tr2_tls.c                     | 1 +
 trace2/tr2_tls.h                     | 1 -
 trace2/tr2_tmr.c                     | 1 -
 transport-helper.c                   | 2 --
 transport.c                          | 3 ---
 tree.c                               | 3 ---
 upload-pack.c                        | 6 ------
 wrapper.c                            | 1 -
 xdiff-interface.c                    | 2 --
 194 files changed, 25 insertions(+), 339 deletions(-)


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1617%2Fnewren%2Fheader-cleanup-6-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1617/newren/header-cleanup-6-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1617
-- 
gitgitgadget
