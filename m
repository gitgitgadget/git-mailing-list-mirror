Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926611C8A
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQrXQPyq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40b5155e154so34912045e9.3
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351704; x=1703956504; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAiJ5n3VndRvgchBSOexgz+0ElfmXA/tF7/FOCAbmtM=;
        b=CQrXQPyqCxCaGWkprMrNyXgWp5P1qqoBRY7vtsrjoq6humfSwfjmSeoxeP7480Wdqo
         DNgBLlHezB7j8pnYEanHTc7wius2XNxKxG172XdsaTNWIpvYNv7NFIcQogadj951vFQ5
         +RohnWBeUrV7giX06QLouqH0UUP88qQSXqumxr6qJns6CUVf2GFol5YDNjpNIemyAfLV
         Z4uvzKTOtXbz1mcGMF7bh/hhlDC7BtpBWB+s7bWIPbsiWy8OcC9CPgiMPxv9bvFITPAu
         mc1l3HYQg6Pul0GuxXDeP7kT0wEx6T/1SeA08mXfjJ1KZARpQcafGsTCNbtSisOiWfuV
         HC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351704; x=1703956504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAiJ5n3VndRvgchBSOexgz+0ElfmXA/tF7/FOCAbmtM=;
        b=ZYhBA4gIYV8ODkCWVc0osn7fJ104tmZCYDB2Fa+nJMclTIfBfiWMNQ14QBcXSpIOQk
         L7av5EmUgwMXuKdfPFRYG5hosq9rU2JZnSN4hSkA8m9ocAsBkZCrUBmUj5zY7HaevjOV
         3j57Bb+OCRjNT/u6nrmBfEL+JRv6cNUhM6RzRtsmI008pfxDugHyZdPRGb6ox/j9WvlD
         iGWIkaq/zfSRpYZAXWVXnXE8uZKaCoKWh0/tLOCOmTgZ1g+O8Wstx5pb4mb/2whomMCa
         DafQAhcFl2nZCIS3shnB/OBjTvqwsuaQm4lq+DrB74tViYsCcWaGPXY1xDL0hAVmw++T
         EAmg==
X-Gm-Message-State: AOJu0YxCAdTJPSinsxC47DFlbdCwsv0fYjKN0aIPEgR5ktYB/I4P4+HF
	ncwaaK/u++6RWbc6XJsRja1wfk+RwcM=
X-Google-Smtp-Source: AGHT+IFwoDJBtnt/L96uN3vZfOgiiAjhHsMapnu4rSCOnLt2cMrv9tRu7e3nG4/2dmy9elQ0Z25M+A==
X-Received: by 2002:a05:600c:234a:b0:40d:190d:f36e with SMTP id 10-20020a05600c234a00b0040d190df36emr1714636wmq.161.1703351704145;
        Sat, 23 Dec 2023 09:15:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b0040c411da99csm18983594wmq.48.2023.12.23.09.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:03 -0800 (PST)
Message-ID: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:14:48 +0000
Subject: [PATCH v2 00/12] Additional header cleanups (removing unnecessary includes)
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

Here are a number of header cleanups, to remove unnecessary includes.

(Sorry for the multiple day delay from when I said I'd send in an update;
COVID sucks and knocked me out for multiple days and has me running on near
empty.)

Changes since v1:

 * Dropped three changes that conflicted with changes in next & seen (in
   attr.c, trace2.c, and test-trace2.c). After topics in next & seen merge
   down, I can submit a future patch that still does the relevant part of
   the cleanups that I'm dropping for now.

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
 t/helper/test-pkt-line.c             | 1 +
 t/helper/test-reach.c                | 2 --
 t/helper/test-repository.c           | 2 --
 t/helper/test-simple-ipc.c           | 1 -
 t/helper/test-submodule.c            | 1 +
 tmp-objdir.c                         | 1 -
 trace2.c                             | 3 ---
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
 191 files changed, 25 insertions(+), 335 deletions(-)


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1617%2Fnewren%2Fheader-cleanup-6-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1617/newren/header-cleanup-6-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1617

Range-diff vs v1:

  1:  2f8ff69314e =  1:  2f8ff69314e treewide: remove unnecessary includes from header files
  2:  dbfb108214d !  2:  4dcd52b117e treewide: remove unnecessary includes in source files
     @@ archive.c
       
       static char const * const archive_usage[] = {
      
     - ## attr.c ##
     -@@
     - #include "utf8.h"
     - #include "quote.h"
     - #include "read-cache-ll.h"
     --#include "revision.h"
     - #include "object-store-ll.h"
     - #include "setup.h"
     - #include "thread-utils.h"
     -
       ## bisect.c ##
      @@
       #include "refs.h"
     @@ t/helper/test-bundle-uri.c
       enum input_mode {
       	KEY_VALUE_PAIRS,
      
     - ## t/helper/test-fast-rebase.c ##
     -@@
     - #include "read-cache-ll.h"
     - #include "refs.h"
     - #include "revision.h"
     --#include "sequencer.h"
     - #include "setup.h"
     - #include "strvec.h"
     - #include "tree.h"
     -
       ## t/helper/test-reach.c ##
      @@
       #include "test-tool.h"
     @@ t/helper/test-simple-ipc.c
       #include "parse-options.h"
       #include "thread-utils.h"
      
     - ## t/helper/test-trace2.c ##
     -@@
     - #include "strvec.h"
     - #include "run-command.h"
     - #include "exec-cmd.h"
     --#include "config.h"
     - #include "repository.h"
     - #include "trace2.h"
     - 
     -
       ## tmp-objdir.c ##
      @@
       #include "environment.h"
     @@ tmp-objdir.c
       ## trace2.c ##
      @@
       #include "git-compat-util.h"
     --#include "config.h"
     + #include "config.h"
      -#include "json-writer.h"
      -#include "quote.h"
       #include "repository.h"
  3:  43222a4dac4 =  3:  6211270d678 archive.h: remove unnecessary include
  4:  bd69a954e9a =  4:  e5ba799753d blame.h: remove unnecessary includes
  5:  a2e4bcc56fb =  5:  8ae3696197b fsmonitor--daemon.h: remove unnecessary includes
  6:  393c5ca3a1d =  6:  29b7d47718c http.h: remove unnecessary include
  7:  5f8014882e0 =  7:  7270441cd64 line-log.h: remove unnecessary include
  8:  bc1fe09e996 =  8:  ab91f88a560 pkt-line.h: remove unnecessary include
  9:  6d25811965c =  9:  95688443246 submodule-config.h: remove unnecessary include
 10:  72fd5e2941f = 10:  d9062fb11be trace2/tr2_tls.h: remove unnecessary include
 11:  c11b94bfc7c = 11:  0639ba03d50 treewide: add direct includes currently only pulled in transitively
 12:  57f9da7bba0 = 12:  45f893e8e12 treewide: remove unnecessary includes in source files

-- 
gitgitgadget
