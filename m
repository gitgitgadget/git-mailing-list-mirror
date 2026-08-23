Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67286377A85
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505593; cv=none; b=lKWIim8asqT0+uIxZmi96FjvakRsGnBW+VRaehE7I8sRYTnxKpBhLb1TlL4B9fePy9eN6soWalzlEf0FDVHE2e6IDl+umz2pa4WBtodeTRPlHELUErWKxPjvhJEVWbIEHi1iEsDe6+BNjnoU94Ctd9MNPsLgeQQbx9y/AjhB634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505593; c=relaxed/simple;
	bh=x/h5YAsnRzUwoZdtZ+g5cPAA77tNJMgoC1B5CQlQZJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUyjLoibc6/TcujDt35RMIN77+lBwIORjwweuZRctDTDdohIy2o2IUv16hEIocU+KjAl2BuNouoPcoRMgUPnMj68IiD9w6kI4G7DwLnSX86xtyfot+yCrWHROuVd8esRdO7KSU+eTBAgVON1VbOf4Chp6VlrQFB1r9olTaCNCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnDr/jO0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnDr/jO0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381b831d535so3758735a91.0
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505579; x=1788110379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQZYvIoS0F3Dvz1zAQIjwIfpN9PbtmfxIq/nPIx3wVo=;
        b=EnDr/jO0gxLBwffK82UaGXIFjKBmNVhZ4a8w8b2wdeTvXDWPxV2ufxJIzbJ58BihMd
         Q7xb6sj9ZBREfL0bFIm0lt5AiYuoZgOLUl9ZmJRXjblqwCRqfz4tjBKjzzx91QmCovlI
         vRJDcI9N4iKGd9V/0oMrqlFjsk7+0HtowHo5INpFHK6aVKR4k0JffeYLzNOnGxBcXxZm
         i2B3K4TZsBZCHHl4Q+9OzCm70TD9KvLpFjp8JNsB/dGopanYY1N/kjvpxo+9tC85x/rL
         J5kmN6WGbuEoTbx7htIY6I2yK4XsOwkFZK80p8rPCllSQY+SWwQ9fmFKQnZ/zRgrKNPg
         UZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505579; x=1788110379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQZYvIoS0F3Dvz1zAQIjwIfpN9PbtmfxIq/nPIx3wVo=;
        b=A9BKQU0Wrnq1OVAZaDsweJibh3zu0+JMbB/ZQ/YwJ/t/zwireQS77diwxl8Qf3E3HY
         zpiGSfIYgrJ/JJ65+o1rpXmU3LVc9jsTarFDVp+o6ONA0GYgVQ8lWTESp2ECsHoXFLmw
         yQGX81XES7m+MOueggjApX0TjTuO+rPRROlKniwcMV3vfF43OsmnQYHbeRqrn2kGatgz
         qi58iS21th1Gl4/GCGWsX7kk4+6mYQExVeV7x4BRzzMtjMENUic5Om0+cD4j8GgyqCP2
         I7MsPPRMcYBib29RAxaTluwWFc7rJ1JH7lpGSUmvnKQiXNdbzq0GbeKbQXGuslc5yAMq
         6P2Q==
X-Gm-Message-State: AFuF++kOL1224PuwIa+HaAV12JpCTzk95jCHMhoEI2w5E9NCr9/l5eXB
	x1V797yMVzhjgikfieL8q3tUCh+xgWgDPC5lFOCkdpQuRbtcY7vbVRY0R2kxyg==
X-Gm-Gg: AR+sD12bozRG1U1n4aUSKOeCD4in2soo+f2vz1qmlC+MgOnrsr2KnZ04NF6LXFPbxHz
	ZVv9kIQbe68rsHCjS92Er1a4sp0V3I/rtcoASbNcLhWco6zSxLYdAuRHgh5DGx9282JBLmWcbjV
	RpdhpsVTyXsliJn8oEnEu/1fHXpn8iynt978KEXUzMo20gr1Wou+vJrg/Eqmvo29Out+0mtLOC8
	wB+UJieDydLdMSCsG6hq5XOdU1VxzrXUishSpKWGhUUymGKFT6RWVHvRmrOjU7KRVkzMquFF2l/
	l+CnaYL7I6iZzZUZ8xOAhsbCtdtryfObUQH3buR/glQT2ePF8MoQUnLL3TAJbUwA4xGKJQAiHmG
	T4mYRb3d71E92zU6w5Jmne0jnSasspWvFhtpiHKwaMq25y1NaNYW0O+p7BxeGPDnIXqr7VMnp4n
	hHVQCmRBnCJm/ec0BzGgjlvDIccxLMvY6jgmR0/mSwPa9Eufq8eNIFUlSvjkd9tmqdrQJoDbKgC
	D92BCjU0hR//GR6ChwL58OrMy5mIutvRtCGuNJn+Ly74QCnk7M9udTuQ9SpfwulZ2G3B5bcsVj6
	RpChXrkzNajEehRQhc/00/IrDFbT4ZCRuSXwzRboMIH5uA==
X-Received: by 2002:a17:90b:1d49:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-395c3566ba6mr41742525a91.6.1787505577376;
        Sun, 23 Aug 2026 10:19:37 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d36f9sm26292128eec.16.2026.08.23.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:36 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 12/14] index: gather the index sources under index/
Date: Sun, 23 Aug 2026 10:18:56 -0700
Message-ID: <20260823171915.2662373-13-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823171915.2662373-1-mmontalbo@gmail.com>
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the 20 index C sources and 24 headers into index/ as renames.
Repoint every reference to their old paths to the new ones: the #include
lines across the tree, the Makefile and meson.build build entries, and
the tutorial #include examples.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 .gitorganize                                  | 88 +++++++++----------
 Documentation/MyFirstContribution.adoc        |  2 +-
 Makefile                                      | 42 ++++-----
 add-interactive.c                             |  6 +-
 add-patch.c                                   |  4 +-
 apply.c                                       | 10 +--
 archive.c                                     |  2 +-
 archive.h                                     |  2 +-
 attr.c                                        |  4 +-
 builtin/add.c                                 |  8 +-
 builtin/am.c                                  |  8 +-
 builtin/backfill.c                            |  2 +-
 builtin/check-ignore.c                        |  4 +-
 builtin/checkout--worker.c                    |  6 +-
 builtin/checkout-index.c                      | 10 +--
 builtin/checkout.c                            | 24 ++---
 builtin/clean.c                               |  6 +-
 builtin/clone.c                               |  6 +-
 builtin/commit.c                              | 14 +--
 builtin/count-objects.c                       |  2 +-
 builtin/describe.c                            |  2 +-
 builtin/diff-files.c                          |  2 +-
 builtin/diff-index.c                          |  2 +-
 builtin/diff-tree.c                           |  2 +-
 builtin/diff.c                                |  4 +-
 builtin/difftool.c                            |  8 +-
 builtin/fast-import.c                         |  4 +-
 builtin/fsck.c                                |  8 +-
 builtin/fsmonitor--daemon.c                   | 10 +--
 builtin/gc.c                                  |  2 +-
 builtin/grep.c                                |  6 +-
 builtin/history.c                             |  8 +-
 builtin/ls-files.c                            | 10 +--
 builtin/ls-tree.c                             |  2 +-
 builtin/merge-index.c                         |  4 +-
 builtin/merge.c                               | 10 +--
 builtin/mv.c                                  | 12 +--
 builtin/pack-objects.c                        |  2 +-
 builtin/prune.c                               |  2 +-
 builtin/pull.c                                |  6 +-
 builtin/push.c                                |  2 +-
 builtin/read-tree.c                           |  8 +-
 builtin/rebase.c                              |  6 +-
 builtin/rerere.c                              |  2 +-
 builtin/reset.c                               |  8 +-
 builtin/rev-parse.c                           |  4 +-
 builtin/rm.c                                  |  8 +-
 builtin/show-branch.c                         |  2 +-
 builtin/sparse-checkout.c                     |  8 +-
 builtin/stash.c                               | 14 +--
 builtin/submodule--helper.c                   | 10 +--
 builtin/update-index.c                        | 18 ++--
 builtin/worktree.c                            |  6 +-
 builtin/write-tree.c                          |  2 +-
 compat/fsmonitor/fsm-health-darwin.c          |  4 +-
 compat/fsmonitor/fsm-health-linux.c           |  4 +-
 compat/fsmonitor/fsm-health-win32.c           |  4 +-
 compat/fsmonitor/fsm-ipc-unix.c               |  6 +-
 compat/fsmonitor/fsm-ipc-win32.c              |  2 +-
 compat/fsmonitor/fsm-listen-darwin.c          |  6 +-
 compat/fsmonitor/fsm-listen-linux.c           |  8 +-
 compat/fsmonitor/fsm-listen-win32.c           |  4 +-
 compat/fsmonitor/fsm-path-utils-darwin.c      |  4 +-
 compat/fsmonitor/fsm-path-utils-linux.c       |  4 +-
 compat/fsmonitor/fsm-path-utils-win32.c       |  4 +-
 compat/fsmonitor/fsm-settings-unix.c          |  8 +-
 compat/fsmonitor/fsm-settings-win32.c         |  6 +-
 compat/mingw.c                                |  4 +-
 config.c                                      |  2 +-
 convert.c                                     |  2 +-
 diagnose.c                                    |  2 +-
 diff/diff-lib.c                               | 12 +--
 diff/diff-no-index.c                          |  4 +-
 diff/diff.c                                   |  4 +-
 diff/diff.h                                   |  2 +-
 diff/tree-diff.c                              |  2 +-
 git.c                                         |  2 +-
 gpg-interface.c                               |  2 +-
 help.c                                        |  2 +-
 cache-tree.c => index/cache-tree.c            |  4 +-
 cache-tree.h => index/cache-tree.h            |  0
 checkout.c => index/checkout.c                |  2 +-
 checkout.h => index/checkout.h                |  0
 dir-iterator.c => index/dir-iterator.c        |  4 +-
 dir-iterator.h => index/dir-iterator.h        |  0
 dir.c => index/dir.c                          | 14 +--
 dir.h => index/dir.h                          |  4 +-
 entry.c => index/entry.c                      | 14 +--
 entry.h => index/entry.h                      |  0
 .../fsmonitor--daemon.h                       |  2 +-
 fsmonitor-ipc.c => index/fsmonitor-ipc.c      |  2 +-
 fsmonitor-ipc.h => index/fsmonitor-ipc.h      |  0
 fsmonitor-ll.h => index/fsmonitor-ll.h        |  0
 .../fsmonitor-path-utils.h                    |  0
 .../fsmonitor-settings.c                      |  6 +-
 .../fsmonitor-settings.h                      |  0
 fsmonitor.c => index/fsmonitor.c              |  8 +-
 fsmonitor.h => index/fsmonitor.h              |  8 +-
 name-hash.c => index/name-hash.c              |  6 +-
 name-hash.h => index/name-hash.h              |  0
 .../parallel-checkout.c                       |  8 +-
 .../parallel-checkout.h                       |  0
 pathspec.c => index/pathspec.c                |  8 +-
 pathspec.h => index/pathspec.h                |  0
 preload-index.c => index/preload-index.c      | 12 +--
 preload-index.h => index/preload-index.h      |  0
 read-cache-ll.h => index/read-cache-ll.h      |  2 +-
 read-cache.c => index/read-cache.c            | 20 ++---
 read-cache.h => index/read-cache.h            |  4 +-
 resolve-undo.c => index/resolve-undo.c        |  8 +-
 resolve-undo.h => index/resolve-undo.h        |  0
 sparse-index.c => index/sparse-index.c        | 14 +--
 sparse-index.h => index/sparse-index.h        |  0
 split-index.c => index/split-index.c          |  4 +-
 split-index.h => index/split-index.h          |  0
 statinfo.c => index/statinfo.c                |  2 +-
 statinfo.h => index/statinfo.h                |  0
 symlinks.c => index/symlinks.c                |  2 +-
 symlinks.h => index/symlinks.h                |  0
 unpack-trees.c => index/unpack-trees.c        | 22 ++---
 unpack-trees.h => index/unpack-trees.h        |  2 +-
 wt-status.c => index/wt-status.c              |  8 +-
 wt-status.h => index/wt-status.h              |  2 +-
 merge-ort-wrappers.c                          |  2 +-
 merge-ort.c                                   | 12 +--
 merge.c                                       |  4 +-
 meson.build                                   | 40 ++++-----
 notes-merge.c                                 |  2 +-
 odb/commit.c                                  |  2 +-
 odb/fsck.c                                    |  2 +-
 odb/hash-lookup.c                             |  2 +-
 odb/object-file.c                             |  4 +-
 odb/object-name.c                             |  4 +-
 odb/object.c                                  |  2 +-
 odb/odb.c                                     |  2 +-
 odb/source-packed.c                           |  2 +-
 odb/tmp-objdir.c                              |  2 +-
 odb/tree-walk.c                               |  6 +-
 organize/gitorganize-format.c                 |  2 +-
 organize/organize.c                           |  6 +-
 pack/midx.c                                   |  2 +-
 pack/packfile.c                               |  2 +-
 pack/reachable.c                              |  2 +-
 pack/repack.c                                 |  2 +-
 pack/server-info.c                            |  2 +-
 path-walk.c                                   |  2 +-
 path.c                                        |  2 +-
 rebase-interactive.c                          |  2 +-
 refs/files-backend.c                          |  4 +-
 refs/packed-backend.c                         |  4 +-
 refs/ref-filter.c                             |  2 +-
 refs/reftable-backend.c                       |  2 +-
 refs/worktree.c                               |  4 +-
 remote.c                                      |  2 +-
 repository.c                                  |  4 +-
 rerere.c                                      |  8 +-
 reset.c                                       |  4 +-
 revision/bisect.c                             |  2 +-
 revision/blame.c                              |  4 +-
 revision/list-objects-filter.c                |  2 +-
 revision/revision.c                           |  8 +-
 revision/shallow.c                            |  2 +-
 run-command.c                                 |  2 +-
 scalar.c                                      |  6 +-
 sequencer.c                                   | 10 +--
 sequencer.h                                   |  2 +-
 setup.c                                       |  2 +-
 submodule-config.c                            |  2 +-
 submodule.c                                   |  4 +-
 t/helper/test-cache-tree.c                    |  4 +-
 t/helper/test-dir-iterator.c                  |  2 +-
 t/helper/test-dump-cache-tree.c               |  4 +-
 t/helper/test-dump-fsmonitor.c                |  2 +-
 t/helper/test-dump-split-index.c              |  4 +-
 t/helper/test-dump-untracked-cache.c          |  4 +-
 t/helper/test-fsmonitor-client.c              |  4 +-
 t/helper/test-lazy-init-name-hash.c           |  4 +-
 t/helper/test-parse-pathspec-file.c           |  2 +-
 t/helper/test-path-utils.c                    |  2 +-
 t/helper/test-path-walk.c                     |  2 +-
 t/helper/test-read-cache.c                    |  2 +-
 t/helper/test-scrap-cache-tree.c              |  4 +-
 t/helper/test-write-cache.c                   |  2 +-
 t/unit-tests/test-lib.c                       |  2 +-
 t/unit-tests/u-dir.c                          |  2 +-
 t/unit-tests/u-reftable-stack.c               |  2 +-
 t/unit-tests/u-strcmp-offset.c                |  2 +-
 trace2/tr2_sysenv.c                           |  2 +-
 188 files changed, 497 insertions(+), 497 deletions(-)
 rename cache-tree.c => index/cache-tree.c (99%)
 rename cache-tree.h => index/cache-tree.h (100%)
 rename checkout.c => index/checkout.c (98%)
 rename checkout.h => index/checkout.h (100%)
 rename dir-iterator.c => index/dir-iterator.c (99%)
 rename dir-iterator.h => index/dir-iterator.h (100%)
 rename dir.c => index/dir.c (99%)
 rename dir.h => index/dir.h (99%)
 rename entry.c => index/entry.c (98%)
 rename entry.h => index/entry.h (100%)
 rename fsmonitor--daemon.h => index/fsmonitor--daemon.h (99%)
 rename fsmonitor-ipc.c => index/fsmonitor-ipc.c (99%)
 rename fsmonitor-ipc.h => index/fsmonitor-ipc.h (100%)
 rename fsmonitor-ll.h => index/fsmonitor-ll.h (100%)
 rename fsmonitor-path-utils.h => index/fsmonitor-path-utils.h (100%)
 rename fsmonitor-settings.c => index/fsmonitor-settings.c (98%)
 rename fsmonitor-settings.h => index/fsmonitor-settings.h (100%)
 rename fsmonitor.c => index/fsmonitor.c (99%)
 rename fsmonitor.h => index/fsmonitor.h (95%)
 rename name-hash.c => index/name-hash.c (99%)
 rename name-hash.h => index/name-hash.h (100%)
 rename parallel-checkout.c => index/parallel-checkout.c (99%)
 rename parallel-checkout.h => index/parallel-checkout.h (100%)
 rename pathspec.c => index/pathspec.c (99%)
 rename pathspec.h => index/pathspec.h (100%)
 rename preload-index.c => index/preload-index.c (96%)
 rename preload-index.h => index/preload-index.h (100%)
 rename read-cache-ll.h => index/read-cache-ll.h (99%)
 rename read-cache.c => index/read-cache.c (99%)
 rename read-cache.h => index/read-cache.h (95%)
 rename resolve-undo.c => index/resolve-undo.c (97%)
 rename resolve-undo.h => index/resolve-undo.h (100%)
 rename sparse-index.c => index/sparse-index.c (99%)
 rename sparse-index.h => index/sparse-index.h (100%)
 rename split-index.c => index/split-index.c (99%)
 rename split-index.h => index/split-index.h (100%)
 rename statinfo.c => index/statinfo.c (99%)
 rename statinfo.h => index/statinfo.h (100%)
 rename symlinks.c => index/symlinks.c (99%)
 rename symlinks.h => index/symlinks.h (100%)
 rename unpack-trees.c => index/unpack-trees.c (99%)
 rename unpack-trees.h => index/unpack-trees.h (99%)
 rename wt-status.c => index/wt-status.c (99%)
 rename wt-status.h => index/wt-status.h (99%)

diff --git a/.gitorganize b/.gitorganize
index d62d0a2240..fe81c40f09 100644
--- a/.gitorganize
+++ b/.gitorganize
@@ -48,12 +48,8 @@ bundle-uri.c component=transport role=lib prefix=bundle-uri includes=transport:5
 bundle-uri.h component=transport role=header prefix=bundle-uri cochange=transport:14
 bundle.c component=transport role=lib prefix=bundle includes=odb:3,revision:3,setup:2,transport:2,diff:1 cochange=transport:63,odb:24,revision:21,refs:17,pack:10
 bundle.h component=transport role=header prefix=bundle includes=revision:1 cochange=transport:37,revision:5
-cache-tree.c component=index role=lib prefix=cache-tree includes=odb:5,index:2,setup:1,transport:1 cochange=index:94,odb:69,revision:27,transport:21,diff:20
-cache-tree.h component=index role=header prefix=cache-tree includes=odb:2 cochange=index:42,diff:4,revision:4,odb:3,refs:1
 chdir-notify.c component=? role=lib prefix=chdir-notify includes=revision:1 cochange=index:2,archive:1,merge:1,revision:1
 chdir-notify.h component=? role=public prefix=chdir-notify
-checkout.c component=index role=lib prefix=checkout includes=setup:2,index:1,odb:1,refs:1,transport:1 cochange=transport:16,refs:6,setup:5,index:3,odb:2
-checkout.h component=index role=header prefix=checkout includes=odb:1 cochange=index:4,diff:1,odb:1,refs:1,revision:1
 color.c component=? role=lib prefix=color includes=setup:1 cochange=diff:21,index:14,revision:13,setup:7,transport:7
 color.h component=? role=public prefix=color cochange=diff:18,index:12,revision:12,transport:2,odb:1
 column.c component=? role=lib prefix=column includes=setup:1 cochange=transport:6,setup:5,diff:4,revision:3,index:2
@@ -105,14 +101,8 @@ diff/userdiff.c component=diff role=lib prefix=userdiff includes=setup:2,convert
 diff/userdiff.h component=diff role=header prefix=diff includes=notes:1 cochange=diff:40,notes:2,archive:1,merge:1,revision:1
 diff/xdiff-interface.c component=diff role=lib prefix=xdiff-interface includes=setup:2,diff:1,odb:1 cochange=diff:73,index:5,merge:3,notes:3,refs:3
 diff/xdiff-interface.h component=diff role=header prefix=xdiff-interface includes=odb:1 cochange=diff:62,index:2,notes:2,merge:1,odb:1
-dir-iterator.c component=index role=lib prefix=dir-iterator includes=index:2 cochange=index:7,refs:1
-dir-iterator.h component=index role=header prefix=dir-iterator cochange=index:7,refs:1
-dir.c component=index role=lib prefix=dir includes=index:7,setup:4,odb:2,convert:1,refs:1 cochange=index:343,diff:61,setup:49,odb:37,convert:29
-dir.h component=index role=header prefix=dir includes=index:2,odb:1 cochange=index:236,odb:13,setup:12,submodule:11,convert:10
 editor.c component=? role=lib prefix=editor includes=setup:2 cochange=transport:20,setup:12,index:8,odb:4,submodule:4
 editor.h component=? role=public prefix=editor cochange=transport:1
-entry.c component=index role=lib prefix=entry includes=index:7,odb:1,setup:1,submodule:1 cochange=index:96,diff:28,convert:20,setup:17,odb:10
-entry.h component=index role=header prefix=entry includes=convert:1 cochange=index:18,submodule:4,revision:3,transport:2,convert:1
 environment.c component=setup role=lib prefix=environment includes=setup:5,convert:3,odb:2,merge:1,refs:1 cochange=setup:281,index:77,odb:48,refs:36,transport:28
 environment.h component=setup role=header prefix=environment includes=setup:1 cochange=setup:135,index:37,odb:15,refs:11,pack:9
 exec-cmd.c component=? role=lib prefix=strvec includes=setup:1
@@ -126,15 +116,6 @@ fetch-pack.h component=transport role=header prefix=fetch-pack includes=odb:1,re
 fmt-merge-msg.c component=merge role=lib prefix=fmt-merge-msg includes=odb:3,diff:2,revision:2,setup:2,merge:1 cochange=revision:10,odb:7,index:6,diff:4,setup:4
 fmt-merge-msg.h component=merge role=header prefix=fmt-merge-msg cochange=merge:3,setup:2
 for-each-ref.h component=? role=public prefix=?
-fsmonitor--daemon.h component=index role=header prefix=fsmonitor--daemon includes=index:1 cochange=index:1
-fsmonitor-ipc.c component=index role=lib prefix=fsmonitor includes=index:1,setup:1 cochange=index:6,transport:2,merge:1,notes:1,pack:1
-fsmonitor-ipc.h component=index role=header prefix=fsmonitor cochange=index:2
-fsmonitor-ll.h component=index role=header prefix=fsmonitor-ll cochange=index:4
-fsmonitor-path-utils.h component=index role=header prefix=fsmonitor cochange=index:2
-fsmonitor-settings.c component=index role=lib prefix=fsmonitor includes=index:3,setup:2 cochange=index:17,setup:10,transport:2,diff:1,odb:1
-fsmonitor-settings.h component=index role=header prefix=fsmonitor-settings cochange=index:11,setup:4
-fsmonitor.c component=index role=lib prefix=fsmonitor includes=index:4,setup:3 cochange=index:37,setup:16,transport:4,merge:2,refs:2
-fsmonitor.h component=index role=header prefix=fsmonitor includes=index:4,odb:1 cochange=index:24,setup:7,diff:3,submodule:1
 gettext.c component=? role=lib prefix=gettext includes=setup:1 cochange=pack:5,refs:3,setup:2,transport:2,merge:1
 gettext.h component=? role=public prefix=i18n cochange=transport:2,setup:1
 git-compat-util.h component=? role=public prefix=git-compat-util cochange=setup:48,index:35,odb:22,pack:21,diff:17
@@ -165,6 +146,50 @@ http.h component=transport role=header prefix=http includes=transport:1 cochange
 ident.c component=setup role=lib prefix=ident includes=setup:2 cochange=setup:19,revision:10,odb:6,refs:6,pack:4
 ident.h component=setup role=header prefix=ident cochange=setup:3,revision:1
 imap-send.c component=? role=program prefix=imap-send includes=setup:3,transport:1 cochange=transport:47,diff:16,index:16,refs:9,odb:8
+index/cache-tree.c component=index role=lib prefix=cache-tree includes=odb:5,index:2,setup:1,transport:1 cochange=index:94,odb:69,revision:27,transport:21,diff:20
+index/cache-tree.h component=index role=header prefix=cache-tree includes=odb:2 cochange=index:42,diff:4,revision:4,odb:3,refs:1
+index/checkout.c component=index role=lib prefix=checkout includes=setup:2,index:1,odb:1,refs:1,transport:1 cochange=transport:16,refs:6,setup:5,index:3,odb:2
+index/checkout.h component=index role=header prefix=checkout includes=odb:1 cochange=index:4,diff:1,odb:1,refs:1,revision:1
+index/dir-iterator.c component=index role=lib prefix=dir-iterator includes=index:2 cochange=index:7,refs:1
+index/dir-iterator.h component=index role=header prefix=dir-iterator cochange=index:7,refs:1
+index/dir.c component=index role=lib prefix=dir includes=index:7,setup:4,odb:2,convert:1,refs:1 cochange=index:343,diff:61,setup:49,odb:37,convert:29
+index/dir.h component=index role=header prefix=dir includes=index:2,odb:1 cochange=index:236,odb:13,setup:12,submodule:11,convert:10
+index/entry.c component=index role=lib prefix=entry includes=index:7,odb:1,setup:1,submodule:1 cochange=index:96,diff:28,convert:20,setup:17,odb:10
+index/entry.h component=index role=header prefix=entry includes=convert:1 cochange=index:18,submodule:4,revision:3,transport:2,convert:1
+index/fsmonitor--daemon.h component=index role=header prefix=fsmonitor--daemon includes=index:1 cochange=index:1
+index/fsmonitor-ipc.c component=index role=lib prefix=fsmonitor includes=index:1,setup:1 cochange=index:6,transport:2,merge:1,notes:1,pack:1
+index/fsmonitor-ipc.h component=index role=header prefix=fsmonitor cochange=index:2
+index/fsmonitor-ll.h component=index role=header prefix=fsmonitor-ll cochange=index:4
+index/fsmonitor-path-utils.h component=index role=header prefix=fsmonitor cochange=index:2
+index/fsmonitor-settings.c component=index role=lib prefix=fsmonitor includes=index:3,setup:2 cochange=index:17,setup:10,transport:2,diff:1,odb:1
+index/fsmonitor-settings.h component=index role=header prefix=fsmonitor-settings cochange=index:11,setup:4
+index/fsmonitor.c component=index role=lib prefix=fsmonitor includes=index:4,setup:3 cochange=index:37,setup:16,transport:4,merge:2,refs:2
+index/fsmonitor.h component=index role=header prefix=fsmonitor includes=index:4,odb:1 cochange=index:24,setup:7,diff:3,submodule:1
+index/name-hash.c component=index role=lib prefix=name-hash includes=index:3,odb:1,setup:1 cochange=diff:43,index:39,revision:18,setup:14,refs:12
+index/name-hash.h component=index role=header prefix=name-hash cochange=index:7
+index/parallel-checkout.c component=index role=lib prefix=parallel-checkout includes=index:4,odb:1,setup:1,transport:1 cochange=index:26,transport:7,odb:6,diff:3,merge:3
+index/parallel-checkout.h component=index role=header prefix=parallel-checkout includes=convert:1 cochange=index:12,convert:1
+index/pathspec.c component=index role=lib prefix=pathspec includes=index:4,setup:3,convert:1 cochange=index:89,setup:23,convert:16,diff:16,revision:9
+index/pathspec.h component=index role=header prefix=pathspec cochange=index:67,diff:11,odb:9,convert:6,submodule:4
+index/preload-index.c component=index role=lib prefix=preload-index includes=index:6,setup:3 cochange=index:52,setup:15,diff:12,revision:5,merge:3
+index/preload-index.h component=index role=header prefix=preload-index cochange=index:2,setup:1
+index/read-cache-ll.h component=index role=header prefix=read-cache includes=index:1,odb:1 cochange=index:8,diff:1,odb:1,revision:1
+index/read-cache.c component=index role=lib prefix=read-cache includes=index:10,odb:6,setup:4,diff:2,submodule:2 cochange=index:240,odb:81,setup:79,diff:67,pack:46
+index/read-cache.h component=index role=header prefix=read-cache includes=index:2,odb:1,setup:1 cochange=index:4,setup:4,diff:2
+index/resolve-undo.c component=index role=lib prefix=resolve-undo includes=index:4,odb:1 cochange=index:33,merge:5,revision:4,diff:3,notes:2
+index/resolve-undo.h component=index role=header prefix=resolve-undo includes=odb:1 cochange=index:12,merge:3,archive:1,revision:1
+index/sparse-index.c component=index role=lib prefix=sparse-index includes=index:7,setup:3,odb:1 cochange=index:42,setup:17,diff:2,odb:2,revision:1
+index/sparse-index.h component=index role=header prefix=sparse-index cochange=index:16,setup:4,merge:1,revision:1
+index/split-index.c component=index role=lib prefix=split-index includes=index:2,odb:1,setup:1 cochange=index:46,odb:5,revision:4,pack:3,merge:2
+index/split-index.h component=index role=header prefix=split-index includes=odb:1 cochange=index:21,archive:1,merge:1,revision:1
+index/statinfo.c component=index role=lib prefix=environment includes=setup:2,index:1 cochange=index:9,setup:6,diff:2,odb:1,revision:1
+index/statinfo.h component=index role=header prefix=statinfo cochange=index:8,odb:1,revision:1
+index/symlinks.c component=index role=lib prefix=symlinks includes=index:1,setup:1 cochange=index:23,diff:3,archive:2,convert:1,revision:1
+index/symlinks.h component=index role=header prefix=symlinks cochange=index:9,diff:1
+index/unpack-trees.c component=index role=lib prefix=unpack-trees includes=index:11,odb:3,setup:3,submodule:2,convert:1 cochange=index:262,odb:49,diff:41,transport:19,revision:18
+index/unpack-trees.h component=index role=header prefix=unpack-trees includes=convert:1,index:1,odb:1 cochange=index:75,diff:9,odb:6,setup:5,merge:4
+index/wt-status.c component=index role=lib prefix=wt-status includes=odb:5,index:4,setup:3,diff:2,refs:2 cochange=index:149,diff:83,transport:55,refs:45,revision:45
+index/wt-status.h component=index role=header prefix=wt-status includes=index:1,transport:1 cochange=index:89,diff:10,refs:9,revision:4,transport:4
 iterator.h component=? role=public prefix=refs cochange=index:2,refs:2
 json-writer.c component=? role=lib prefix=json-writer
 json-writer.h component=? role=public prefix=json-writer cochange=transport:1
@@ -194,8 +219,6 @@ merge-ort.h component=merge role=header prefix=merge-ort includes=odb:1 cochange
 merge.c component=merge role=lib prefix=merge includes=odb:4,index:2,merge:1,setup:1 cochange=index:22,merge:6,setup:4,diff:2,odb:2
 merge.h component=merge role=header prefix=merge cochange=merge:1
 mergesort.h component=? role=public prefix=mergesort cochange=odb:1
-name-hash.c component=index role=lib prefix=name-hash includes=index:3,odb:1,setup:1 cochange=diff:43,index:39,revision:18,setup:14,refs:12
-name-hash.h component=index role=header prefix=name-hash cochange=index:7
 notes-cache.c component=notes role=lib prefix=notes includes=odb:3,notes:1,refs:1,revision:1,setup:1 cochange=notes:37,odb:29,diff:10,index:10,revision:9
 notes-cache.h component=notes role=header prefix=notes-cache includes=notes:1 cochange=diff:7,notes:3
 notes-merge.c component=notes role=lib prefix=notes-merge includes=odb:4,diff:3,notes:3,index:1,merge:1 cochange=diff:54,revision:41,odb:37,notes:36,index:30
@@ -300,8 +323,6 @@ pack/server-info.c component=pack role=lib prefix=server-info includes=odb:5,pac
 pack/server-info.h component=pack role=header prefix=server-info cochange=pack:2
 pager.c component=? role=lib prefix=pager includes=setup:4 cochange=setup:23,diff:9,transport:7,revision:3,submodule:3
 pager.h component=? role=public prefix=pager cochange=diff:3,setup:2,revision:1
-parallel-checkout.c component=index role=lib prefix=parallel-checkout includes=index:4,odb:1,setup:1,transport:1 cochange=index:26,transport:7,odb:6,diff:3,merge:3
-parallel-checkout.h component=index role=header prefix=parallel-checkout includes=convert:1 cochange=index:12,convert:1
 parse-options-cb.c component=? role=lib prefix=parse-options includes=odb:3,setup:2 cochange=revision:10,transport:10,diff:7,odb:4,refs:3
 parse-options.c component=? role=lib prefix=parse-options cochange=index:14,diff:12,setup:10,transport:10,odb:6
 parse-options.h component=? role=public prefix=parse-options cochange=diff:7,merge:4,archive:3,index:3,refs:3
@@ -311,12 +332,8 @@ path-walk.c component=? role=lib prefix=path-walk includes=odb:9,revision:3,inde
 path-walk.h component=? role=public prefix=path-walk includes=odb:1 cochange=index:2
 path.c component=? role=lib prefix=path includes=setup:2,index:1,odb:1,pack:1,refs:1 cochange=setup:78,refs:29,index:26,transport:15,odb:12
 path.h component=? role=public prefix=path includes=setup:1 cochange=setup:23,refs:13,odb:11,index:10,pack:8
-pathspec.c component=index role=lib prefix=pathspec includes=index:4,setup:3,convert:1 cochange=index:89,setup:23,convert:16,diff:16,revision:9
-pathspec.h component=index role=header prefix=pathspec cochange=index:67,diff:11,odb:9,convert:6,submodule:4
 pkt-line.c component=transport role=lib prefix=pkt-line includes=transport:2 cochange=transport:102,pack:6,convert:5,diff:5,odb:3
 pkt-line.h component=transport role=header prefix=pkt-line cochange=transport:94,pack:5,convert:4,odb:2,diff:1
-preload-index.c component=index role=lib prefix=preload-index includes=index:6,setup:3 cochange=index:52,setup:15,diff:12,revision:5,merge:3
-preload-index.h component=index role=header prefix=preload-index cochange=index:2,setup:1
 prio-queue.c component=? role=lib prefix=prio-queue cochange=odb:5,revision:5,diff:2,pack:2,transport:2
 prio-queue.h component=? role=public prefix=prio-queue cochange=odb:3,revision:2,transport:2,pack:1
 progress.c component=? role=lib prefix=progress includes=setup:1 cochange=index:11,diff:6,setup:6,pack:4,revision:2
@@ -331,9 +348,6 @@ protocol.c component=transport role=lib prefix=protocol includes=setup:2,transpo
 protocol.h component=transport role=header prefix=protocol cochange=transport:5
 quote.c component=? role=lib prefix=quote cochange=index:15,diff:12,transport:7,odb:6,revision:6
 quote.h component=? role=public prefix=quote cochange=diff:8,transport:6,index:5,odb:5,refs:5
-read-cache-ll.h component=index role=header prefix=read-cache includes=index:1,odb:1 cochange=index:8,diff:1,odb:1,revision:1
-read-cache.c component=index role=lib prefix=read-cache includes=index:10,odb:6,setup:4,diff:2,submodule:2 cochange=index:240,odb:81,setup:79,diff:67,pack:46
-read-cache.h component=index role=header prefix=read-cache includes=index:2,odb:1,setup:1 cochange=index:4,setup:4,diff:2
 rebase-interactive.c component=? role=lib prefix=rebase-interactive includes=odb:3,setup:3,index:1 cochange=revision:4,transport:4,index:3,odb:3,merge:2
 rebase-interactive.h component=? role=public prefix=rebase-interactive
 rebase.c component=? role=lib prefix=rebase cochange=index:3,pack:3,setup:2,convert:1,diff:1
@@ -367,8 +381,6 @@ rerere.c component=merge role=lib prefix=rerere includes=index:4,merge:2,odb:2,s
 rerere.h component=merge role=header prefix=rerere cochange=merge:16,odb:1
 reset.c component=? role=lib prefix=reset includes=odb:3,index:2,refs:1,setup:1 cochange=index:9,merge:5,odb:3,notes:2,revision:2
 reset.h component=? role=public prefix=reset includes=odb:1,setup:1
-resolve-undo.c component=index role=lib prefix=resolve-undo includes=index:4,odb:1 cochange=index:33,merge:5,revision:4,diff:3,notes:2
-resolve-undo.h component=index role=header prefix=resolve-undo includes=odb:1 cochange=index:12,merge:3,archive:1,revision:1
 revision/bisect.c component=revision role=lib prefix=bisect includes=odb:5,revision:5,setup:2,diff:1,index:1 cochange=revision:61,odb:32,transport:31,refs:13,diff:9
 revision/bisect.h component=revision role=header prefix=bisect cochange=revision:29,odb:2
 revision/blame.c component=revision role=lib prefix=blame includes=odb:5,diff:2,index:2,pack:2,revision:2 cochange=diff:68,revision:66,odb:56,index:29,pack:22
@@ -420,13 +432,7 @@ sideband.h component=transport role=header prefix=sideband cochange=transport:23
 sigchain.c component=? role=lib prefix=sigchain cochange=diff:2,transport:1
 sigchain.h component=? role=public prefix=sigchain cochange=diff:2
 simple-ipc.h component=? role=public prefix=simple-ipc includes=transport:1 cochange=submodule:1
-sparse-index.c component=index role=lib prefix=sparse-index includes=index:7,setup:3,odb:1 cochange=index:42,setup:17,diff:2,odb:2,revision:1
-sparse-index.h component=index role=header prefix=sparse-index cochange=index:16,setup:4,merge:1,revision:1
-split-index.c component=index role=lib prefix=split-index includes=index:2,odb:1,setup:1 cochange=index:46,odb:5,revision:4,pack:3,merge:2
-split-index.h component=index role=header prefix=split-index includes=odb:1 cochange=index:21,archive:1,merge:1,revision:1
 stable-qsort.c component=? role=lib prefix=stable-qsort
-statinfo.c component=index role=lib prefix=environment includes=setup:2,index:1 cochange=index:9,setup:6,diff:2,odb:1,revision:1
-statinfo.h component=index role=header prefix=statinfo cochange=index:8,odb:1,revision:1
 strbuf.c component=? role=lib prefix=strbuf cochange=index:16,odb:12,setup:11,revision:10,transport:10
 strbuf.h component=? role=public prefix=strbuf cochange=revision:15,index:14,odb:14,diff:7,setup:7
 string-list.c component=? role=lib prefix=string-list cochange=transport:14,index:8,notes:7,refs:7,diff:5
@@ -441,8 +447,6 @@ submodule-config.c component=submodule role=lib prefix=submodule-config includes
 submodule-config.h component=submodule role=header prefix=submodule-config includes=odb:1,setup:1,submodule:1 cochange=submodule:54,setup:9,odb:3,diff:2,index:2
 submodule.c component=submodule role=lib prefix=submodule includes=odb:5,setup:4,diff:2,index:2,refs:2 cochange=submodule:134,diff:83,setup:66,index:60,revision:49
 submodule.h component=submodule role=header prefix=submodule cochange=submodule:128,index:22,diff:21,transport:17,setup:6
-symlinks.c component=index role=lib prefix=symlinks includes=index:1,setup:1 cochange=index:23,diff:3,archive:2,convert:1,revision:1
-symlinks.h component=index role=header prefix=symlinks cochange=index:9,diff:1
 tar.h component=? role=public prefix=tar-tree
 tempfile.c component=? role=lib prefix=tempfile cochange=pack:5,setup:4,index:3,odb:3,revision:3
 tempfile.h component=? role=public prefix=tempfile includes=revision:1 cochange=revision:3,diff:2,index:2,setup:2
@@ -463,8 +467,6 @@ unix-socket.c component=? role=lib prefix=unix-socket cochange=diff:3,revision:2
 unix-socket.h component=? role=public prefix=unix-socket
 unix-stream-server.c component=? role=lib prefix=unix-stream-server
 unix-stream-server.h component=? role=public prefix=unix-stream-server
-unpack-trees.c component=index role=lib prefix=unpack-trees includes=index:11,odb:3,setup:3,submodule:2,convert:1 cochange=index:262,odb:49,diff:41,transport:19,revision:18
-unpack-trees.h component=index role=header prefix=unpack-trees includes=convert:1,index:1,odb:1 cochange=index:75,diff:9,odb:6,setup:5,merge:4
 upload-pack.c component=transport role=lib prefix=upload-pack includes=transport:6,odb:4,revision:4,setup:4,diff:1 cochange=transport:198,odb:88,revision:80,refs:55,pack:34
 upload-pack.h component=transport role=header prefix=upload-pack cochange=transport:18,refs:5,submodule:1
 url.c component=? role=lib prefix=url cochange=transport:12,revision:8,diff:6,index:2,refs:2
@@ -490,5 +492,3 @@ write-or-die.c component=? role=lib prefix=write-or-die cochange=pack:6,setup:6,
 write-or-die.h component=? role=public prefix=write-or-die
 ws.c component=convert role=lib prefix=whitespace includes=convert:2 cochange=convert:24,diff:18,archive:9,index:5,setup:5
 ws.h component=convert role=header prefix=whitespace cochange=diff:5,convert:2,setup:2
-wt-status.c component=index role=lib prefix=wt-status includes=odb:5,index:4,setup:3,diff:2,refs:2 cochange=index:149,diff:83,transport:55,refs:45,revision:45
-wt-status.h component=index role=header prefix=wt-status includes=index:1,transport:1 cochange=index:89,diff:10,refs:9,revision:4,transport:4
diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 2da56ca8fc..63468494c1 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -390,7 +390,7 @@ to `repo_config()`. Let's modify the code we wrote in the previous commit.
 Be sure to include the header to allow you to use `struct wt_status`:
 
 ----
-#include "wt-status.h"
+#include "index/wt-status.h"
 ----
 
 Then modify your `cmd_psuh` implementation to declare your `struct wt_status`,
diff --git a/Makefile b/Makefile
index 74013e8380..5e404ffa5e 100644
--- a/Makefile
+++ b/Makefile
@@ -1117,10 +1117,10 @@ LIB_OBJS += pack/bloom.o
 LIB_OBJS += branch.o
 LIB_OBJS += bundle-uri.o
 LIB_OBJS += bundle.o
-LIB_OBJS += cache-tree.o
+LIB_OBJS += index/cache-tree.o
 LIB_OBJS += odb/cbtree.o
 LIB_OBJS += chdir-notify.o
-LIB_OBJS += checkout.o
+LIB_OBJS += index/checkout.o
 LIB_OBJS += pack/chunk-format.o
 LIB_OBJS += color.o
 LIB_OBJS += column.o
@@ -1158,10 +1158,10 @@ LIB_OBJS += diff/diffcore-order.o
 LIB_OBJS += diff/diffcore-pickaxe.o
 LIB_OBJS += diff/diffcore-rename.o
 LIB_OBJS += diff/diffcore-rotate.o
-LIB_OBJS += dir-iterator.o
-LIB_OBJS += dir.o
+LIB_OBJS += index/dir-iterator.o
+LIB_OBJS += index/dir.o
 LIB_OBJS += editor.o
-LIB_OBJS += entry.o
+LIB_OBJS += index/entry.o
 LIB_OBJS += environment.o
 LIB_OBJS += ewah/bitmap.o
 LIB_OBJS += ewah/ewah_bitmap.o
@@ -1173,9 +1173,9 @@ LIB_OBJS += fetch-object-info.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += odb/fsck.o
-LIB_OBJS += fsmonitor.o
-LIB_OBJS += fsmonitor-ipc.o
-LIB_OBJS += fsmonitor-settings.o
+LIB_OBJS += index/fsmonitor.o
+LIB_OBJS += index/fsmonitor-ipc.o
+LIB_OBJS += index/fsmonitor-settings.o
 LIB_OBJS += gettext.o
 LIB_OBJS += git-zlib.o
 LIB_OBJS += gpg-interface.o
@@ -1213,7 +1213,7 @@ LIB_OBJS += merge-ort-wrappers.o
 LIB_OBJS += merge.o
 LIB_OBJS += pack/midx.o
 LIB_OBJS += pack/midx-write.o
-LIB_OBJS += name-hash.o
+LIB_OBJS += index/name-hash.o
 LIB_OBJS += negotiator/default.o
 LIB_OBJS += negotiator/noop.o
 LIB_OBJS += negotiator/skipping.o
@@ -1252,7 +1252,7 @@ LIB_OBJS += pack/pack-write.o
 LIB_OBJS += pack/packfile.o
 LIB_OBJS += pack/packfile-list.o
 LIB_OBJS += pager.o
-LIB_OBJS += parallel-checkout.o
+LIB_OBJS += index/parallel-checkout.o
 LIB_OBJS += parse.o
 LIB_OBJS += parse-options-cb.o
 LIB_OBJS += parse-options.o
@@ -1260,9 +1260,9 @@ LIB_OBJS += pack/patch-delta.o
 LIB_OBJS += diff/patch-ids.o
 LIB_OBJS += path.o
 LIB_OBJS += path-walk.o
-LIB_OBJS += pathspec.o
+LIB_OBJS += index/pathspec.o
 LIB_OBJS += pkt-line.o
-LIB_OBJS += preload-index.o
+LIB_OBJS += index/preload-index.o
 LIB_OBJS += revision/pretty.o
 LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
@@ -1275,7 +1275,7 @@ LIB_OBJS += pack/pseudo-merge.o
 LIB_OBJS += quote.o
 LIB_OBJS += diff/range-diff.o
 LIB_OBJS += pack/reachable.o
-LIB_OBJS += read-cache.o
+LIB_OBJS += index/read-cache.o
 LIB_OBJS += rebase-interactive.o
 LIB_OBJS += rebase.o
 LIB_OBJS += refs/ref-filter.o
@@ -1316,7 +1316,7 @@ LIB_OBJS += repo-settings.o
 LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
 LIB_OBJS += reset.o
-LIB_OBJS += resolve-undo.o
+LIB_OBJS += index/resolve-undo.o
 LIB_OBJS += revision/revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += send-pack.o
@@ -1327,10 +1327,10 @@ LIB_OBJS += setup.o
 LIB_OBJS += revision/shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
-LIB_OBJS += sparse-index.o
-LIB_OBJS += split-index.o
+LIB_OBJS += index/sparse-index.o
+LIB_OBJS += index/split-index.o
 LIB_OBJS += stable-qsort.o
-LIB_OBJS += statinfo.o
+LIB_OBJS += index/statinfo.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += string-list.o
 LIB_OBJS += strmap.o
@@ -1338,7 +1338,7 @@ LIB_OBJS += strvec.o
 LIB_OBJS += sub-process.o
 LIB_OBJS += submodule-config.o
 LIB_OBJS += submodule.o
-LIB_OBJS += symlinks.o
+LIB_OBJS += index/symlinks.o
 LIB_OBJS += odb/tag.o
 LIB_OBJS += tempfile.o
 LIB_OBJS += thread-utils.o
@@ -1363,7 +1363,7 @@ LIB_OBJS += transport.o
 LIB_OBJS += diff/tree-diff.o
 LIB_OBJS += odb/tree-walk.o
 LIB_OBJS += odb/tree.o
-LIB_OBJS += unpack-trees.o
+LIB_OBJS += index/unpack-trees.o
 LIB_OBJS += upload-pack.o
 LIB_OBJS += url.o
 LIB_OBJS += urlmatch.o
@@ -1381,7 +1381,7 @@ LIB_OBJS += refs/worktree.o
 LIB_OBJS += wrapper.o
 LIB_OBJS += write-or-die.o
 LIB_OBJS += ws.o
-LIB_OBJS += wt-status.o
+LIB_OBJS += index/wt-status.o
 LIB_OBJS += diff/xdiff-interface.o
 LIB_OBJS += xdiff/xdiffi.o
 LIB_OBJS += xdiff/xemit.o
@@ -3219,7 +3219,7 @@ LOCALIZED_C_CORE += builtin/index-pack.c
 LOCALIZED_C_CORE += builtin/push.c
 LOCALIZED_C_CORE += builtin/reset.c
 LOCALIZED_C_CORE += remote.c
-LOCALIZED_C_CORE += wt-status.c
+LOCALIZED_C_CORE += index/wt-status.c
 
 LOCALIZED_C_CORE_GEN_PO = $(LOCALIZED_C_CORE:%=.build/pot/po/%.po)
 
diff --git a/add-interactive.c b/add-interactive.c
index 7bfc410361..5f4d379910 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -7,14 +7,14 @@
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
-#include "preload-index.h"
-#include "read-cache-ll.h"
+#include "index/preload-index.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "revision/revision.h"
 #include "refs/refs.h"
 #include "string-list.h"
 #include "lockfile.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "run-command.h"
 #include "prompt.h"
 #include "odb/tree.h"
diff --git a/add-patch.c b/add-patch.c
index c6860310c1..0499152dbc 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -13,13 +13,13 @@
 #include "hex.h"
 #include "odb/object-name.h"
 #include "pager.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "strbuf.h"
 #include "sigchain.h"
 #include "run-command.h"
 #include "strvec.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "color.h"
 #include "compat/terminal.h"
 #include "prompt.h"
diff --git a/apply.c b/apply.c
index b8d97d140d..70d5461fbe 100644
--- a/apply.c
+++ b/apply.c
@@ -17,26 +17,26 @@
 #include "odb/odb.h"
 #include "pack/delta.h"
 #include "diff/diff.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "diff/xdiff-interface.h"
 #include "merge-ll.h"
 #include "lockfile.h"
-#include "name-hash.h"
+#include "index/name-hash.h"
 #include "odb/object-name.h"
 #include "odb/object-file.h"
 #include "parse-options.h"
 #include "path.h"
 #include "quote.h"
-#include "read-cache.h"
+#include "index/read-cache.h"
 #include "repository.h"
 #include "rerere.h"
 #include "apply.h"
-#include "entry.h"
+#include "index/entry.h"
 #include "setup.h"
-#include "symlinks.h"
+#include "index/symlinks.h"
 #include "wildmatch.h"
 #include "ws.h"
 
diff --git a/archive.c b/archive.c
index a2402fb7e6..e6fdd2ea8f 100644
--- a/archive.c
+++ b/archive.c
@@ -21,7 +21,7 @@
 #include "attr.h"
 #include "archive.h"
 #include "parse-options.h"
-#include "unpack-trees.h"
+#include "index/unpack-trees.h"
 #include "quote.h"
 
 static char const * const archive_usage[] = {
diff --git a/archive.h b/archive.h
index bbe65ba0f9..d1496a485b 100644
--- a/archive.h
+++ b/archive.h
@@ -1,7 +1,7 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
 
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "string-list.h"
 
 struct repository;
diff --git a/attr.c b/attr.c
index e7d364d490..841d2f23ae 100644
--- a/attr.c
+++ b/attr.c
@@ -14,12 +14,12 @@
 #include "environment.h"
 #include "exec-cmd.h"
 #include "attr.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "gettext.h"
 #include "path.h"
 #include "utf8.h"
 #include "quote.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "refs/refs.h"
 #include "revision/revision.h"
 #include "odb/odb.h"
diff --git a/builtin/add.c b/builtin/add.c
index 4dbdccd928..e544220eb2 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -10,18 +10,18 @@
 #include "environment.h"
 #include "lockfile.h"
 #include "editor.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "gettext.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "run-command.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "odb/transaction.h"
 #include "parse-options.h"
 #include "path.h"
-#include "preload-index.h"
+#include "index/preload-index.h"
 #include "diff/diff.h"
-#include "read-cache.h"
+#include "index/read-cache.h"
 #include "revision/revision.h"
 #include "strvec.h"
 #include "submodule.h"
diff --git a/builtin/am.c b/builtin/am.c
index 5dbe1f171b..0b6d77004f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -15,20 +15,20 @@
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "run-command.h"
 #include "hook.h"
 #include "quote.h"
 #include "tempfile.h"
 #include "lockfile.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "refs/refs.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "unpack-trees.h"
+#include "index/unpack-trees.h"
 #include "branch.h"
 #include "odb/object-name.h"
-#include "preload-index.h"
+#include "index/preload-index.h"
 #include "sequencer.h"
 #include "revision/revision.h"
 #include "merge-ort-wrappers.h"
diff --git a/builtin/backfill.c b/builtin/backfill.c
index d2ef39bc58..b8e21c844c 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -7,7 +7,7 @@
 #include "parse-options.h"
 #include "repository.h"
 #include "odb/commit.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "hex.h"
 #include "odb/tree.h"
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 644c9a414f..1d2c3cb8db 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -1,11 +1,11 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "quote.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "parse-options.h"
 #include "submodule.h"
 #include "write-or-die.h"
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index e0772b718b..9c49474753 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -3,13 +3,13 @@
 
 #include "builtin.h"
 #include "config.h"
-#include "entry.h"
+#include "index/entry.h"
 #include "environment.h"
 #include "gettext.h"
-#include "parallel-checkout.h"
+#include "index/parallel-checkout.h"
 #include "parse-options.h"
 #include "pkt-line.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 
 static void packet_to_pc_item(const char *buffer, int len,
 			      struct parallel_checkout_item *pc_item)
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 311b94ff31..c659e5c764 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -13,13 +13,13 @@
 #include "gettext.h"
 #include "lockfile.h"
 #include "quote.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "parse-options.h"
-#include "entry.h"
-#include "parallel-checkout.h"
-#include "read-cache-ll.h"
+#include "index/entry.h"
+#include "index/parallel-checkout.h"
+#include "index/read-cache-ll.h"
 #include "setup.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 
 #define CHECKOUT_ALL 4
 static int nul_term_line;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 286fcdc1ba..48882b0f8e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -4,12 +4,12 @@
 #include "builtin.h"
 #include "advice.h"
 #include "branch.h"
-#include "cache-tree.h"
-#include "checkout.h"
+#include "index/cache-tree.h"
+#include "index/checkout.h"
 #include "odb/commit.h"
 #include "config.h"
 #include "diff/diff.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
@@ -22,27 +22,27 @@
 #include "odb/odb.h"
 #include "parse-options.h"
 #include "path.h"
-#include "preload-index.h"
-#include "read-cache.h"
+#include "index/preload-index.h"
+#include "index/read-cache.h"
 #include "refs/refs.h"
 #include "remote.h"
 #include "repo-settings.h"
-#include "resolve-undo.h"
+#include "index/resolve-undo.h"
 #include "revision/revision.h"
 #include "sequencer.h"
 #include "setup.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "strvec.h"
 #include "submodule.h"
-#include "symlinks.h"
+#include "index/symlinks.h"
 #include "trace2.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
-#include "unpack-trees.h"
-#include "wt-status.h"
+#include "index/unpack-trees.h"
+#include "index/wt-status.h"
 #include "diff/xdiff-interface.h"
-#include "entry.h"
-#include "parallel-checkout.h"
+#include "index/entry.h"
+#include "index/parallel-checkout.h"
 #include "add-interactive.h"
 
 struct checkout_opts {
diff --git a/builtin/clean.c b/builtin/clean.c
index 1d5e7e5366..81b3b86491 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -12,18 +12,18 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "setup.h"
 #include "string-list.h"
 #include "quote.h"
 #include "column.h"
 #include "color.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "help.h"
 #include "prompt.h"
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 8ed07e1a15..58cf9761a0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -28,11 +28,11 @@
 #include "odb/odb.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
-#include "unpack-trees.h"
+#include "index/unpack-trees.h"
 #include "transport.h"
 #include "strbuf.h"
-#include "dir.h"
-#include "dir-iterator.h"
+#include "index/dir.h"
+#include "index/dir-iterator.h"
 #include "iterator.h"
 #include "sigchain.h"
 #include "branch.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index aa89e0dc52..85ab748ff0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -12,9 +12,9 @@
 #include "advice.h"
 #include "config.h"
 #include "lockfile.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "color.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "editor.h"
 #include "environment.h"
 #include "diff/diff.h"
@@ -22,21 +22,21 @@
 #include "add-interactive.h"
 #include "gettext.h"
 #include "revision/revision.h"
-#include "wt-status.h"
+#include "index/wt-status.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
 #include "path.h"
-#include "preload-index.h"
-#include "read-cache.h"
+#include "index/preload-index.h"
+#include "index/read-cache.h"
 #include "repository.h"
 #include "string-list.h"
 #include "rerere.h"
-#include "unpack-trees.h"
+#include "index/unpack-trees.h"
 #include "column.h"
 #include "sequencer.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "mailmap.h"
 #include "help.h"
 #include "revision/commit-reach.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 45a7a61cd3..cf10ddcae1 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -6,7 +6,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "path.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index bbeba1e465..c22158d157 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -12,7 +12,7 @@
 #include "refs/refs.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "revision/revision.h"
 #include "diff/diff.h"
 #include "hashmap.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index d1e8d2b462..1f67480362 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -12,7 +12,7 @@
 #include "diff/diff.h"
 #include "diff/diff-merges.h"
 #include "odb/commit.h"
-#include "preload-index.h"
+#include "index/preload-index.h"
 #include "revision/revision.h"
 
 static const char diff_files_usage[] =
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index f3b2eadda0..dac8099081 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -6,7 +6,7 @@
 #include "diff/diff.h"
 #include "diff/diff-merges.h"
 #include "odb/commit.h"
-#include "preload-index.h"
+#include "index/preload-index.h"
 #include "revision/revision.h"
 #include "setup.h"
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 2bd5ed4004..8f7f48ac67 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -7,7 +7,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "revision/log-tree.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "revision/revision.h"
 #include "odb/tmp-objdir.h"
 #include "odb/tree.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index e4487901d3..0e8c488408 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -18,8 +18,8 @@
 #include "diff/diff.h"
 #include "diff/diff-merges.h"
 #include "diff/diffcore.h"
-#include "preload-index.h"
-#include "read-cache-ll.h"
+#include "index/preload-index.h"
+#include "index/read-cache-ll.h"
 #include "revision/revision.h"
 #include "revision/log-tree.h"
 #include "setup.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 075112d344..1d3fae8793 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -23,16 +23,16 @@
 #include "hex.h"
 #include "parse-options.h"
 #include "path.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "strvec.h"
 #include "strbuf.h"
 #include "lockfile.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
-#include "dir.h"
-#include "entry.h"
+#include "index/dir.h"
+#include "index/entry.h"
 #include "setup.h"
 
 static const char *const builtin_difftool_usage[] = {
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index f3af94307f..da586c7c63 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -15,11 +15,11 @@
 #include "pack/delta.h"
 #include "pack/pack.h"
 #include "path.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "refs/refs.h"
 #include "csum-file.h"
 #include "quote.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "run-command.h"
 #include "pack/packfile.h"
 #include "odb/object-file.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index a00ca35703..6e8fd0e828 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -8,7 +8,7 @@
 #include "odb/tag.h"
 #include "refs/refs.h"
 #include "pack/pack.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "odb/fsck.h"
 #include "parse-options.h"
 #include "progress.h"
@@ -18,11 +18,11 @@
 #include "odb/odb.h"
 #include "odb/streaming.h"
 #include "path.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "odb/replace-object.h"
-#include "resolve-undo.h"
+#include "index/resolve-undo.h"
 #include "run-command.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "refs/worktree.h"
 #include "pack/pack-revindex.h"
 #include "pack/pack-bitmap.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 4161dd8282..49b492fba0 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -4,16 +4,16 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "fsmonitor-ll.h"
-#include "fsmonitor-ipc.h"
-#include "fsmonitor-settings.h"
+#include "index/fsmonitor-ll.h"
+#include "index/fsmonitor-ipc.h"
+#include "index/fsmonitor-settings.h"
 #include "compat/fsmonitor/fsm-health.h"
 #include "compat/fsmonitor/fsm-listen.h"
-#include "fsmonitor--daemon.h"
+#include "index/fsmonitor--daemon.h"
 
 #include "simple-ipc.h"
 #include "strmap.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index c340489c64..0243b34e3e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -16,7 +16,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "date.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "hex.h"
 #include "config.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index d13858caec..20cd821af7 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -20,8 +20,8 @@
 #include "run-command.h"
 #include "grep.h"
 #include "quote.h"
-#include "dir.h"
-#include "pathspec.h"
+#include "index/dir.h"
+#include "index/pathspec.h"
 #include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
@@ -33,7 +33,7 @@
 #include "pager.h"
 #include "path.h"
 #include "promisor-remote.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "write-or-die.h"
 
 static const char *grep_prefix;
diff --git a/builtin/history.c b/builtin/history.c
index 73a31ce152..c817745f30 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "odb/commit.h"
 #include "revision/commit-reach.h"
 #include "config.h"
@@ -14,7 +14,7 @@
 #include "odb/oidmap.h"
 #include "parse-options.h"
 #include "path.h"
-#include "read-cache.h"
+#include "index/read-cache.h"
 #include "refs/refs.h"
 #include "replay.h"
 #include "reset.h"
@@ -23,8 +23,8 @@
 #include "strvec.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
-#include "unpack-trees.h"
-#include "wt-status.h"
+#include "index/unpack-trees.h"
+#include "index/wt-status.h"
 
 #define GIT_HISTORY_DROP_USAGE \
 	N_("git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)]")
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index fc3f8f4a72..49e8a685e3 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -13,18 +13,18 @@
 #include "convert.h"
 #include "environment.h"
 #include "quote.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "gettext.h"
 #include "odb/object-name.h"
 #include "strbuf.h"
 #include "parse-options.h"
-#include "resolve-undo.h"
+#include "index/resolve-undo.h"
 #include "string-list.h"
 #include "path.h"
-#include "pathspec.h"
-#include "read-cache.h"
+#include "index/pathspec.h"
+#include "index/read-cache.h"
 #include "setup.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "submodule.h"
 #include "odb/odb.h"
 #include "hex.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 4f7d1d2b6d..b59c186a21 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -16,7 +16,7 @@
 #include "path.h"
 #include "quote.h"
 #include "parse-options.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 
 static const char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 3314fb1336..a0dafe16dc 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -3,9 +3,9 @@
 
 #include "builtin.h"
 #include "hex.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "run-command.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 
 static const char *pgm;
 static int one_shot, quiet;
diff --git a/builtin/merge.c b/builtin/merge.c
index 268ffc4855..da37fb11eb 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -32,15 +32,15 @@
 #include "diff/diffcore.h"
 #include "path.h"
 #include "revision/revision.h"
-#include "unpack-trees.h"
-#include "cache-tree.h"
-#include "dir.h"
+#include "index/unpack-trees.h"
+#include "index/cache-tree.h"
+#include "index/dir.h"
 #include "color.h"
 #include "rerere.h"
 #include "help.h"
 #include "merge.h"
 #include "merge-ort-wrappers.h"
-#include "resolve-undo.h"
+#include "index/resolve-undo.h"
 #include "remote.h"
 #include "fmt-merge-msg.h"
 #include "sequencer.h"
@@ -49,7 +49,7 @@
 #include "alias.h"
 #include "branch.h"
 #include "revision/commit-reach.h"
-#include "wt-status.h"
+#include "index/wt-status.h"
 #include "pack/commit-graph.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
diff --git a/builtin/mv.c b/builtin/mv.c
index e347c100c0..f49eec035e 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -13,21 +13,21 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-#include "name-hash.h"
+#include "index/name-hash.h"
 #include "odb/object-file.h"
 #include "path.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "lockfile.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "string-list.h"
 #include "parse-options.h"
-#include "read-cache-ll.h"
-#include "symlinks.h"
+#include "index/read-cache-ll.h"
+#include "index/symlinks.h"
 
 #include "setup.h"
 #include "strvec.h"
 #include "submodule.h"
-#include "entry.h"
+#include "index/entry.h"
 
 static const char * const builtin_mv_usage[] = {
 	N_("git mv [-v] [-f] [-n] [-k] <source> <destination>"),
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3b025a08e9..b611b27573 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -36,7 +36,7 @@
 #include "odb/odb.h"
 #include "odb/streaming.h"
 #include "odb/replace-object.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "pack/midx.h"
 #include "trace2.h"
 #include "revision/shallow.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index ba7b1303b3..d2d5bd2619 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -3,7 +3,7 @@
 #include "builtin.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index af120a7e1b..818ddbf956 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -20,15 +20,15 @@
 #include "run-command.h"
 #include "odb/oid-array.h"
 #include "remote.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "path.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "rebase.h"
 #include "refs/refs.h"
 #include "refs/refspec.h"
 #include "submodule.h"
 #include "submodule-config.h"
-#include "wt-status.h"
+#include "index/wt-status.h"
 #include "revision/commit-reach.h"
 #include "sequencer.h"
 
diff --git a/builtin/push.c b/builtin/push.c
index 39b6ff4b8b..280cfd289f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -8,7 +8,7 @@
 #include "advice.h"
 #include "branch.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 8898354baa..2bc2f43729 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -14,12 +14,12 @@
 #include "odb/object-name.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
-#include "cache-tree.h"
-#include "unpack-trees.h"
+#include "index/cache-tree.h"
+#include "index/unpack-trees.h"
 #include "parse-options.h"
-#include "resolve-undo.h"
+#include "index/resolve-undo.h"
 #include "setup.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "submodule.h"
 
 static int nr_trees;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index a14a31d60e..62b58da192 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -15,10 +15,10 @@
 #include "hex.h"
 #include "run-command.h"
 #include "strvec.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "refs/refs.h"
 #include "config.h"
-#include "unpack-trees.h"
+#include "index/unpack-trees.h"
 #include "lockfile.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
@@ -26,7 +26,7 @@
 #include "path.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "wt-status.h"
+#include "index/wt-status.h"
 #include "revision/revision.h"
 #include "revision/commit-reach.h"
 #include "rerere.h"
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 545ffe2715..4b1b7d49ce 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -9,7 +9,7 @@
 #include "string-list.h"
 #include "xdiff/xdiff.h"
 #include "diff/xdiff-interface.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 
 static const char * const rerere_usage[] = {
 	N_("git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]"),
diff --git a/builtin/reset.c b/builtin/reset.c
index eed0d0ea0b..96c7bf9cf1 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -29,14 +29,14 @@
 #include "parse-options.h"
 #include "path.h"
 #include "repository.h"
-#include "unpack-trees.h"
-#include "cache-tree.h"
+#include "index/unpack-trees.h"
+#include "index/cache-tree.h"
 #include "setup.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "submodule.h"
 #include "trace.h"
 #include "trace2.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "add-interactive.h"
 
 #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ef4b6795dd..1d97c4869b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -23,12 +23,12 @@
 #include "parse-options.h"
 #include "path.h"
 #include "diff/diff.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repo-settings.h"
 #include "repository.h"
 #include "revision/revision.h"
 #include "setup.h"
-#include "split-index.h"
+#include "index/split-index.h"
 #include "submodule.h"
 #include "revision/commit-reach.h"
 #include "revision/shallow.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index c856b88d09..4f7194f541 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -11,19 +11,19 @@
 #include "config.h"
 #include "environment.h"
 #include "lockfile.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "odb/tree-walk.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
-#include "read-cache.h"
+#include "index/read-cache.h"
 
 #include "string-list.h"
 #include "setup.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "submodule.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 
 static const char * const builtin_rm_usage[] = {
 	N_("git rm [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]\n"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 8db11f6e4c..e0e912439c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -14,7 +14,7 @@
 #include "odb/object-name.h"
 #include "parse-options.h"
 
-#include "dir.h"
+#include "index/dir.h"
 #include "odb/commit-slab.h"
 #include "date.h"
 #include "wildmatch.h"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 9b4cad87a5..efe6f7897e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -4,21 +4,21 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
 #include "path.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "lockfile.h"
-#include "unpack-trees.h"
+#include "index/unpack-trees.h"
 #include "quote.h"
 #include "setup.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "refs/worktree.h"
 
 static const char *empty_base = "";
diff --git a/builtin/stash.c b/builtin/stash.c
index 6458e3a2d6..a8337ffdc4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -11,20 +11,20 @@
 #include "parse-options.h"
 #include "refs/refs.h"
 #include "lockfile.h"
-#include "cache-tree.h"
-#include "unpack-trees.h"
+#include "index/cache-tree.h"
+#include "index/unpack-trees.h"
 #include "merge-ort-wrappers.h"
 #include "strvec.h"
 #include "run-command.h"
-#include "dir.h"
-#include "entry.h"
-#include "preload-index.h"
-#include "read-cache.h"
+#include "index/dir.h"
+#include "index/entry.h"
+#include "index/preload-index.h"
+#include "index/read-cache.h"
 #include "repository.h"
 #include "rerere.h"
 #include "revision/revision.h"
 #include "setup.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "revision/log-tree.h"
 #include "diff/diffcore.h"
 #include "refs/reflog.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0e061827f9..5226a5f331 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -10,12 +10,12 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "path.h"
-#include "pathspec.h"
-#include "preload-index.h"
-#include "dir.h"
-#include "read-cache.h"
+#include "index/pathspec.h"
+#include "index/preload-index.h"
+#include "index/dir.h"
+#include "index/read-cache.h"
 #include "setup.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "string-list.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 54741c3241..b5c8fae02c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -15,22 +15,22 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "quote.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "odb/tree-walk.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "odb/transaction.h"
 #include "refs/refs.h"
-#include "resolve-undo.h"
+#include "index/resolve-undo.h"
 #include "parse-options.h"
-#include "pathspec.h"
-#include "dir.h"
-#include "read-cache.h"
+#include "index/pathspec.h"
+#include "index/dir.h"
+#include "index/read-cache.h"
 #include "setup.h"
-#include "sparse-index.h"
-#include "split-index.h"
-#include "symlinks.h"
-#include "fsmonitor.h"
+#include "index/sparse-index.h"
+#include "index/split-index.h"
+#include "index/symlinks.h"
+#include "index/fsmonitor.h"
 #include "write-or-die.h"
 
 /*
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 90af2193c1..c4068b45d6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -4,10 +4,10 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
-#include "checkout.h"
+#include "index/checkout.h"
 #include "config.h"
 #include "copy.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
@@ -17,7 +17,7 @@
 #include "path.h"
 #include "strvec.h"
 #include "branch.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "refs/refs.h"
 #include "remote.h"
 #include "run-command.h"
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 2e463ab394..4a2b1ceb58 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -10,7 +10,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "odb/tree.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "parse-options.h"
 
 static const char * const write_tree_usage[] = {
diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-darwin.c
index c2afcbe6c8..f24d56b3d2 100644
--- a/compat/fsmonitor/fsm-health-darwin.c
+++ b/compat/fsmonitor/fsm-health-darwin.c
@@ -1,8 +1,8 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "fsmonitor-ll.h"
+#include "index/fsmonitor-ll.h"
 #include "fsm-health.h"
-#include "fsmonitor--daemon.h"
+#include "index/fsmonitor--daemon.h"
 
 int fsm_health__ctor(struct fsmonitor_daemon_state *state UNUSED)
 {
diff --git a/compat/fsmonitor/fsm-health-linux.c b/compat/fsmonitor/fsm-health-linux.c
index 43d67c4b8b..7be822fb1c 100644
--- a/compat/fsmonitor/fsm-health-linux.c
+++ b/compat/fsmonitor/fsm-health-linux.c
@@ -1,8 +1,8 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "fsmonitor-ll.h"
+#include "index/fsmonitor-ll.h"
 #include "fsm-health.h"
-#include "fsmonitor--daemon.h"
+#include "index/fsmonitor--daemon.h"
 
 /*
  * The Linux fsmonitor implementation uses inotify which has its own
diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 2aa8c219ac..09dee50777 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -1,8 +1,8 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "fsmonitor-ll.h"
+#include "index/fsmonitor-ll.h"
 #include "fsm-health.h"
-#include "fsmonitor--daemon.h"
+#include "index/fsmonitor--daemon.h"
 #include "gettext.h"
 #include "simple-ipc.h"
 
diff --git a/compat/fsmonitor/fsm-ipc-unix.c b/compat/fsmonitor/fsm-ipc-unix.c
index fe149a1b37..ffd864ae92 100644
--- a/compat/fsmonitor/fsm-ipc-unix.c
+++ b/compat/fsmonitor/fsm-ipc-unix.c
@@ -7,9 +7,9 @@
 #include "path.h"
 #include "repository.h"
 #include "strbuf.h"
-#include "fsmonitor-ll.h"
-#include "fsmonitor-ipc.h"
-#include "fsmonitor-path-utils.h"
+#include "index/fsmonitor-ll.h"
+#include "index/fsmonitor-ipc.h"
+#include "index/fsmonitor-path-utils.h"
 
 static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
 
diff --git a/compat/fsmonitor/fsm-ipc-win32.c b/compat/fsmonitor/fsm-ipc-win32.c
index 41984ea48e..bc92e1fd20 100644
--- a/compat/fsmonitor/fsm-ipc-win32.c
+++ b/compat/fsmonitor/fsm-ipc-win32.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "fsmonitor-ipc.h"
+#include "index/fsmonitor-ipc.h"
 #include "path.h"
 
 const char *fsmonitor_ipc__get_path(struct repository *r) {
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 43c3a915a0..fac5256a74 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -24,10 +24,10 @@
 #endif
 
 #include "git-compat-util.h"
-#include "fsmonitor-ll.h"
+#include "index/fsmonitor-ll.h"
 #include "fsm-listen.h"
-#include "fsmonitor--daemon.h"
-#include "fsmonitor-path-utils.h"
+#include "index/fsmonitor--daemon.h"
+#include "index/fsmonitor-path-utils.h"
 #include "gettext.h"
 #include "simple-ipc.h"
 #include "string-list.h"
diff --git a/compat/fsmonitor/fsm-listen-linux.c b/compat/fsmonitor/fsm-listen-linux.c
index e3dca14b62..0208a6d942 100644
--- a/compat/fsmonitor/fsm-listen-linux.c
+++ b/compat/fsmonitor/fsm-listen-linux.c
@@ -1,9 +1,9 @@
 #include "git-compat-util.h"
-#include "dir.h"
-#include "fsmonitor-ll.h"
+#include "index/dir.h"
+#include "index/fsmonitor-ll.h"
 #include "fsm-listen.h"
-#include "fsmonitor--daemon.h"
-#include "fsmonitor-path-utils.h"
+#include "index/fsmonitor--daemon.h"
+#include "index/fsmonitor-path-utils.h"
 #include "gettext.h"
 #include "simple-ipc.h"
 #include "string-list.h"
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 9a6efc9bea..c8cbdf4a97 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -1,8 +1,8 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "fsmonitor-ll.h"
+#include "index/fsmonitor-ll.h"
 #include "fsm-listen.h"
-#include "fsmonitor--daemon.h"
+#include "index/fsmonitor--daemon.h"
 #include "gettext.h"
 #include "simple-ipc.h"
 #include "trace2.h"
diff --git a/compat/fsmonitor/fsm-path-utils-darwin.c b/compat/fsmonitor/fsm-path-utils-darwin.c
index 049f97eaaf..b67b1262c0 100644
--- a/compat/fsmonitor/fsm-path-utils-darwin.c
+++ b/compat/fsmonitor/fsm-path-utils-darwin.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
-#include "fsmonitor-ll.h"
-#include "fsmonitor-path-utils.h"
+#include "index/fsmonitor-ll.h"
+#include "index/fsmonitor-path-utils.h"
 #include "gettext.h"
 #include "trace.h"
 #include <dirent.h>
diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
index c9866b1b24..da62f0b167 100644
--- a/compat/fsmonitor/fsm-path-utils-linux.c
+++ b/compat/fsmonitor/fsm-path-utils-linux.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
-#include "fsmonitor-ll.h"
-#include "fsmonitor-path-utils.h"
+#include "index/fsmonitor-ll.h"
+#include "index/fsmonitor-path-utils.h"
 #include "gettext.h"
 #include "trace.h"
 
diff --git a/compat/fsmonitor/fsm-path-utils-win32.c b/compat/fsmonitor/fsm-path-utils-win32.c
index f4f9cc1f33..112149cf81 100644
--- a/compat/fsmonitor/fsm-path-utils-win32.c
+++ b/compat/fsmonitor/fsm-path-utils-win32.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
-#include "fsmonitor-ll.h"
-#include "fsmonitor-path-utils.h"
+#include "index/fsmonitor-ll.h"
+#include "index/fsmonitor-path-utils.h"
 #include "gettext.h"
 #include "trace.h"
 
diff --git a/compat/fsmonitor/fsm-settings-unix.c b/compat/fsmonitor/fsm-settings-unix.c
index a382590635..41106355b1 100644
--- a/compat/fsmonitor/fsm-settings-unix.c
+++ b/compat/fsmonitor/fsm-settings-unix.c
@@ -1,9 +1,9 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "fsmonitor-ll.h"
-#include "fsmonitor-ipc.h"
-#include "fsmonitor-settings.h"
-#include "fsmonitor-path-utils.h"
+#include "index/fsmonitor-ll.h"
+#include "index/fsmonitor-ipc.h"
+#include "index/fsmonitor-settings.h"
+#include "index/fsmonitor-path-utils.h"
 
  /*
  * For the builtin FSMonitor, we create the Unix domain socket for the
diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 0f2aa321f6..5b2872a4f1 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -1,9 +1,9 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "repository.h"
-#include "fsmonitor-ll.h"
-#include "fsmonitor-settings.h"
-#include "fsmonitor-path-utils.h"
+#include "index/fsmonitor-ll.h"
+#include "index/fsmonitor-settings.h"
+#include "index/fsmonitor-path-utils.h"
 
 /*
  * VFS for Git is incompatible with FSMonitor.
diff --git a/compat/mingw.c b/compat/mingw.c
index 785de5beb7..64814ac35d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -5,13 +5,13 @@
 #include "abspath.h"
 #include "odb/alloc.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "repository.h"
 #include "gettext.h"
 #include "run-command.h"
 #include "strbuf.h"
-#include "symlinks.h"
+#include "index/symlinks.h"
 #include "trace2.h"
 #include "win32.h"
 #include "win32/exit-process.h"
diff --git a/config.c b/config.c
index 3f335dbec1..59c6029654 100644
--- a/config.c
+++ b/config.c
@@ -12,7 +12,7 @@
 #include "date.h"
 #include "branch.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "parse.h"
 #include "convert.h"
 #include "environment.h"
diff --git a/convert.c b/convert.c
index 25c800eea2..f71d6dcefd 100644
--- a/convert.c
+++ b/convert.c
@@ -12,7 +12,7 @@
 #include "attr.h"
 #include "run-command.h"
 #include "quote.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "sigchain.h"
 #include "pkt-line.h"
 #include "sub-process.h"
diff --git a/diagnose.c b/diagnose.c
index 716dabf05c..0bac203282 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -2,7 +2,7 @@
 #include "diagnose.h"
 #include "compat/disk.h"
 #include "archive.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "help.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/diff/diff-lib.c b/diff/diff-lib.c
index d48196f7c7..4a932f9067 100644
--- a/diff/diff-lib.c
+++ b/diff/diff-lib.c
@@ -13,17 +13,17 @@
 #include "odb/hash.h"
 #include "hex.h"
 #include "odb/object-name.h"
-#include "read-cache.h"
+#include "index/read-cache.h"
 #include "revision/revision.h"
-#include "cache-tree.h"
-#include "unpack-trees.h"
+#include "index/cache-tree.h"
+#include "index/unpack-trees.h"
 #include "refs/refs.h"
 #include "repository.h"
 #include "submodule.h"
-#include "symlinks.h"
+#include "index/symlinks.h"
 #include "trace.h"
-#include "dir.h"
-#include "fsmonitor.h"
+#include "index/dir.h"
+#include "index/fsmonitor.h"
 #include "revision/commit-reach.h"
 
 /*
diff --git a/diff/diff-no-index.c b/diff/diff-no-index.c
index 19cb90d121..12a793096b 100644
--- a/diff/diff-no-index.c
+++ b/diff/diff-no-index.c
@@ -15,9 +15,9 @@
 #include "gettext.h"
 #include "revision/revision.h"
 #include "parse-options.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "string-list.h"
-#include "dir.h"
+#include "index/dir.h"
 
 static int read_directory_contents(const char *path, struct string_list *list,
 				   const struct pathspec *pathspec,
diff --git a/diff/diff.c b/diff/diff.c
index 2b87f27238..c00b87cca2 100644
--- a/diff/diff.c
+++ b/diff/diff.c
@@ -39,10 +39,10 @@
 #include "parse-options.h"
 #include "help.h"
 #include "promisor-remote.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "setup.h"
 #include "strmap.h"
 #include "ws.h"
diff --git a/diff/diff.h b/diff/diff.h
index 502bf24432..2ef74733b9 100644
--- a/diff/diff.h
+++ b/diff/diff.h
@@ -5,7 +5,7 @@
 #define DIFF_H
 
 #include "odb/hash.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "strbuf.h"
 #include "color.h"
 
diff --git a/diff/tree-diff.c b/diff/tree-diff.c
index 4b7c90f6db..a34559daa5 100644
--- a/diff/tree-diff.c
+++ b/diff/tree-diff.c
@@ -11,7 +11,7 @@
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
 #include "repository.h"
-#include "dir.h"
+#include "index/dir.h"
 
 /*
  * Some mode bits are also used internally for computations.
diff --git a/git.c b/git.c
index 9dace05858..f01a80867b 100644
--- a/git.c
+++ b/git.c
@@ -8,7 +8,7 @@
 #include "help.h"
 #include "odb/object-file.h"
 #include "pager.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "run-command.h"
 #include "alias.h"
 #include "odb/replace-object.h"
diff --git a/gpg-interface.c b/gpg-interface.c
index 034bed7aaa..45a922496b 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -7,7 +7,7 @@
 #include "gettext.h"
 #include "run-command.h"
 #include "strbuf.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "ident.h"
 #include "gpg-interface.h"
 #include "path.h"
diff --git a/help.c b/help.c
index 96f98ec621..f7a0950f6c 100644
--- a/help.c
+++ b/help.c
@@ -18,7 +18,7 @@
 #include "refs/refs.h"
 #include "parse-options.h"
 #include "prompt.h"
-#include "fsmonitor-ipc.h"
+#include "index/fsmonitor-ipc.h"
 #include "repository.h"
 #include "alias.h"
 #include "utf8.h"
diff --git a/cache-tree.c b/index/cache-tree.c
similarity index 99%
rename from cache-tree.c
rename to index/cache-tree.c
index 1c4295761a..e7c4bfe45c 100644
--- a/cache-tree.c
+++ b/index/cache-tree.c
@@ -7,11 +7,11 @@
 #include "lockfile.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "odb/transaction.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "odb/replace-object.h"
 #include "repository.h"
 #include "promisor-remote.h"
diff --git a/cache-tree.h b/index/cache-tree.h
similarity index 100%
rename from cache-tree.h
rename to index/cache-tree.h
diff --git a/checkout.c b/index/checkout.c
similarity index 98%
rename from checkout.c
rename to index/checkout.c
index e3b4d341da..13d8895032 100644
--- a/checkout.c
+++ b/index/checkout.c
@@ -5,7 +5,7 @@
 #include "remote.h"
 #include "refs/refspec.h"
 #include "repository.h"
-#include "checkout.h"
+#include "index/checkout.h"
 #include "config.h"
 #include "strbuf.h"
 
diff --git a/checkout.h b/index/checkout.h
similarity index 100%
rename from checkout.h
rename to index/checkout.h
diff --git a/dir-iterator.c b/index/dir-iterator.c
similarity index 99%
rename from dir-iterator.c
rename to index/dir-iterator.c
index 857e1d9bda..382bd4325c 100644
--- a/dir-iterator.c
+++ b/index/dir-iterator.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "iterator.h"
-#include "dir-iterator.h"
+#include "index/dir-iterator.h"
 #include "string-list.h"
 
 struct dir_iterator_level {
diff --git a/dir-iterator.h b/index/dir-iterator.h
similarity index 100%
rename from dir-iterator.h
rename to index/dir-iterator.h
diff --git a/dir.c b/index/dir.c
similarity index 99%
rename from dir.c
rename to index/dir.c
index d230ecdec1..6f74a3e87c 100644
--- a/dir.c
+++ b/index/dir.c
@@ -13,26 +13,26 @@
 #include "abspath.h"
 #include "config.h"
 #include "convert.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
-#include "name-hash.h"
+#include "index/name-hash.h"
 #include "odb/object-file.h"
 #include "path.h"
 #include "refs/refs.h"
 #include "repository.h"
 #include "wildmatch.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "utf8.h"
 #include "varint.h"
 #include "ewah/ewok.h"
-#include "fsmonitor-ll.h"
-#include "read-cache-ll.h"
+#include "index/fsmonitor-ll.h"
+#include "index/read-cache-ll.h"
 #include "setup.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "strbuf.h"
 #include "submodule-config.h"
-#include "symlinks.h"
+#include "index/symlinks.h"
 #include "trace2.h"
 #include "odb/tree.h"
 #include "hex.h"
diff --git a/dir.h b/index/dir.h
similarity index 99%
rename from dir.h
rename to index/dir.h
index 239c7efb1e..c44cff5bdd 100644
--- a/dir.h
+++ b/index/dir.h
@@ -3,8 +3,8 @@
 
 #include "odb/hash.h"
 #include "hashmap.h"
-#include "pathspec.h"
-#include "statinfo.h"
+#include "index/pathspec.h"
+#include "index/statinfo.h"
 #include "strbuf.h"
 
 struct repository;
diff --git a/entry.c b/index/entry.c
similarity index 98%
rename from entry.c
rename to index/entry.c
index 823a433539..5b89ad2294 100644
--- a/entry.c
+++ b/index/entry.c
@@ -3,18 +3,18 @@
 #include "git-compat-util.h"
 #include "odb/odb.h"
 #include "odb/streaming.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "name-hash.h"
-#include "sparse-index.h"
+#include "index/name-hash.h"
+#include "index/sparse-index.h"
 #include "submodule.h"
-#include "symlinks.h"
+#include "index/symlinks.h"
 #include "progress.h"
-#include "fsmonitor.h"
-#include "entry.h"
-#include "parallel-checkout.h"
+#include "index/fsmonitor.h"
+#include "index/entry.h"
+#include "index/parallel-checkout.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
diff --git a/entry.h b/index/entry.h
similarity index 100%
rename from entry.h
rename to index/entry.h
diff --git a/fsmonitor--daemon.h b/index/fsmonitor--daemon.h
similarity index 99%
rename from fsmonitor--daemon.h
rename to index/fsmonitor--daemon.h
index 5cbbec8d94..9a542198cd 100644
--- a/fsmonitor--daemon.h
+++ b/index/fsmonitor--daemon.h
@@ -5,7 +5,7 @@
 
 #include "hashmap.h"
 #include "thread-utils.h"
-#include "fsmonitor-path-utils.h"
+#include "index/fsmonitor-path-utils.h"
 
 struct fsmonitor_batch;
 struct fsmonitor_token_data;
diff --git a/fsmonitor-ipc.c b/index/fsmonitor-ipc.c
similarity index 99%
rename from fsmonitor-ipc.c
rename to index/fsmonitor-ipc.c
index 6112d13064..7c213245a1 100644
--- a/fsmonitor-ipc.c
+++ b/index/fsmonitor-ipc.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "simple-ipc.h"
-#include "fsmonitor-ipc.h"
+#include "index/fsmonitor-ipc.h"
 #include "repository.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/fsmonitor-ipc.h b/index/fsmonitor-ipc.h
similarity index 100%
rename from fsmonitor-ipc.h
rename to index/fsmonitor-ipc.h
diff --git a/fsmonitor-ll.h b/index/fsmonitor-ll.h
similarity index 100%
rename from fsmonitor-ll.h
rename to index/fsmonitor-ll.h
diff --git a/fsmonitor-path-utils.h b/index/fsmonitor-path-utils.h
similarity index 100%
rename from fsmonitor-path-utils.h
rename to index/fsmonitor-path-utils.h
diff --git a/fsmonitor-settings.c b/index/fsmonitor-settings.c
similarity index 98%
rename from fsmonitor-settings.c
rename to index/fsmonitor-settings.c
index a6587a8972..883b5902a9 100644
--- a/fsmonitor-settings.c
+++ b/index/fsmonitor-settings.c
@@ -2,9 +2,9 @@
 #include "config.h"
 #include "gettext.h"
 #include "repository.h"
-#include "fsmonitor-ipc.h"
-#include "fsmonitor-settings.h"
-#include "fsmonitor-path-utils.h"
+#include "index/fsmonitor-ipc.h"
+#include "index/fsmonitor-settings.h"
+#include "index/fsmonitor-path-utils.h"
 
 /*
  * We keep this structure definition private and have getters
diff --git a/fsmonitor-settings.h b/index/fsmonitor-settings.h
similarity index 100%
rename from fsmonitor-settings.h
rename to index/fsmonitor-settings.h
diff --git a/fsmonitor.c b/index/fsmonitor.c
similarity index 99%
rename from fsmonitor.c
rename to index/fsmonitor.c
index 107767527e..606a59d36d 100644
--- a/fsmonitor.c
+++ b/index/fsmonitor.c
@@ -3,12 +3,12 @@
 
 #include "git-compat-util.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "ewah/ewok.h"
-#include "fsmonitor.h"
-#include "fsmonitor-ipc.h"
-#include "name-hash.h"
+#include "index/fsmonitor.h"
+#include "index/fsmonitor-ipc.h"
+#include "index/name-hash.h"
 #include "repository.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/fsmonitor.h b/index/fsmonitor.h
similarity index 95%
rename from fsmonitor.h
rename to index/fsmonitor.h
index 59591ee49e..95f4eaefa4 100644
--- a/fsmonitor.h
+++ b/index/fsmonitor.h
@@ -1,11 +1,11 @@
 #ifndef FSMONITOR_H
 #define FSMONITOR_H
 
-#include "fsmonitor-ll.h"
-#include "dir.h"
-#include "fsmonitor-settings.h"
+#include "index/fsmonitor-ll.h"
+#include "index/dir.h"
+#include "index/fsmonitor-settings.h"
 #include "odb/object.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "trace.h"
 
 /*
diff --git a/name-hash.c b/index/name-hash.c
similarity index 99%
rename from name-hash.c
rename to index/name-hash.c
index 1464b6d066..5d126bc1a3 100644
--- a/name-hash.c
+++ b/index/name-hash.c
@@ -12,13 +12,13 @@
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
-#include "name-hash.h"
+#include "index/name-hash.h"
 #include "odb/object.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "thread-utils.h"
 #include "trace.h"
 #include "trace2.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 
 struct dir_entry {
 	struct hashmap_entry ent;
diff --git a/name-hash.h b/index/name-hash.h
similarity index 100%
rename from name-hash.h
rename to index/name-hash.h
diff --git a/parallel-checkout.c b/index/parallel-checkout.c
similarity index 99%
rename from parallel-checkout.c
rename to index/parallel-checkout.c
index 85d1c25a81..971c4b33fa 100644
--- a/parallel-checkout.c
+++ b/index/parallel-checkout.c
@@ -3,18 +3,18 @@
 
 #include "git-compat-util.h"
 #include "config.h"
-#include "entry.h"
+#include "index/entry.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
-#include "parallel-checkout.h"
+#include "index/parallel-checkout.h"
 #include "pkt-line.h"
 #include "progress.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "odb/streaming.h"
-#include "symlinks.h"
+#include "index/symlinks.h"
 #include "thread-utils.h"
 #include "trace2.h"
 
diff --git a/parallel-checkout.h b/index/parallel-checkout.h
similarity index 100%
rename from parallel-checkout.h
rename to index/parallel-checkout.h
diff --git a/pathspec.c b/index/pathspec.c
similarity index 99%
rename from pathspec.c
rename to index/pathspec.c
index 281858f21f..7a0c152fb9 100644
--- a/pathspec.c
+++ b/index/pathspec.c
@@ -3,16 +3,16 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "parse.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "attr.h"
-#include "read-cache.h"
+#include "index/read-cache.h"
 #include "repository.h"
 #include "setup.h"
 #include "strvec.h"
-#include "symlinks.h"
+#include "index/symlinks.h"
 #include "quote.h"
 #include "wildmatch.h"
 
diff --git a/pathspec.h b/index/pathspec.h
similarity index 100%
rename from pathspec.h
rename to index/pathspec.h
diff --git a/preload-index.c b/index/preload-index.c
similarity index 96%
rename from preload-index.c
rename to index/preload-index.c
index b222821b44..eab3bfc602 100644
--- a/preload-index.c
+++ b/index/preload-index.c
@@ -5,18 +5,18 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "pathspec.h"
-#include "dir.h"
+#include "index/pathspec.h"
+#include "index/dir.h"
 #include "environment.h"
-#include "fsmonitor.h"
+#include "index/fsmonitor.h"
 #include "gettext.h"
 #include "parse.h"
-#include "preload-index.h"
+#include "index/preload-index.h"
 #include "progress.h"
-#include "read-cache.h"
+#include "index/read-cache.h"
 #include "thread-utils.h"
 #include "repository.h"
-#include "symlinks.h"
+#include "index/symlinks.h"
 #include "trace2.h"
 #include "config.h"
 
diff --git a/preload-index.h b/index/preload-index.h
similarity index 100%
rename from preload-index.h
rename to index/preload-index.h
diff --git a/read-cache-ll.h b/index/read-cache-ll.h
similarity index 99%
rename from read-cache-ll.h
rename to index/read-cache-ll.h
index 312e65ff3c..450de019b4 100644
--- a/read-cache-ll.h
+++ b/index/read-cache-ll.h
@@ -3,7 +3,7 @@
 
 #include "odb/hash.h"
 #include "hashmap.h"
-#include "statinfo.h"
+#include "index/statinfo.h"
 
 /*
  * Basic data structures for the directory cache
diff --git a/read-cache.c b/index/read-cache.c
similarity index 99%
rename from read-cache.c
rename to index/read-cache.c
index a970eb1b6a..9c62ae5ee8 100644
--- a/read-cache.c
+++ b/index/read-cache.c
@@ -15,9 +15,9 @@
 #include "hex.h"
 #include "tempfile.h"
 #include "lockfile.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "refs/refs.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "odb/transaction.h"
@@ -27,24 +27,24 @@
 #include "environment.h"
 #include "gettext.h"
 #include "mem-pool.h"
-#include "name-hash.h"
+#include "index/name-hash.h"
 #include "odb/object-name.h"
 #include "path.h"
-#include "preload-index.h"
-#include "read-cache.h"
+#include "index/preload-index.h"
+#include "index/read-cache.h"
 #include "repository.h"
-#include "resolve-undo.h"
+#include "index/resolve-undo.h"
 #include "revision/revision.h"
 #include "strbuf.h"
 #include "trace2.h"
 #include "varint.h"
-#include "split-index.h"
-#include "symlinks.h"
+#include "index/split-index.h"
+#include "index/symlinks.h"
 #include "utf8.h"
-#include "fsmonitor.h"
+#include "index/fsmonitor.h"
 #include "thread-utils.h"
 #include "progress.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "csum-file.h"
 #include "promisor-remote.h"
 #include "hook.h"
diff --git a/read-cache.h b/index/read-cache.h
similarity index 95%
rename from read-cache.h
rename to index/read-cache.h
index 69a7118a66..d8519c7b36 100644
--- a/read-cache.h
+++ b/index/read-cache.h
@@ -1,9 +1,9 @@
 #ifndef READ_CACHE_H
 #define READ_CACHE_H
 
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "odb/object.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "environment.h"
 
 /*
diff --git a/resolve-undo.c b/index/resolve-undo.c
similarity index 97%
rename from resolve-undo.c
rename to index/resolve-undo.c
index a54b6c0f79..b94d8b403c 100644
--- a/resolve-undo.c
+++ b/index/resolve-undo.c
@@ -1,11 +1,11 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "odb/hash.h"
-#include "read-cache.h"
-#include "resolve-undo.h"
-#include "sparse-index.h"
+#include "index/read-cache.h"
+#include "index/resolve-undo.h"
+#include "index/sparse-index.h"
 #include "string-list.h"
 
 /* The only error case is to run out of memory in string-list */
diff --git a/resolve-undo.h b/index/resolve-undo.h
similarity index 100%
rename from resolve-undo.h
rename to index/resolve-undo.h
diff --git a/sparse-index.c b/index/sparse-index.c
similarity index 99%
rename from sparse-index.c
rename to index/sparse-index.c
index 8e00862442..0a061a7658 100644
--- a/sparse-index.c
+++ b/index/sparse-index.c
@@ -5,17 +5,17 @@
 #include "environment.h"
 #include "ewah/ewok.h"
 #include "gettext.h"
-#include "name-hash.h"
-#include "read-cache-ll.h"
+#include "index/name-hash.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "odb/tree.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "trace2.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "config.h"
-#include "dir.h"
-#include "fsmonitor-ll.h"
+#include "index/dir.h"
+#include "index/fsmonitor-ll.h"
 #include "advice.h"
 
 /**
diff --git a/sparse-index.h b/index/sparse-index.h
similarity index 100%
rename from sparse-index.h
rename to index/sparse-index.h
diff --git a/split-index.c b/index/split-index.c
similarity index 99%
rename from split-index.c
rename to index/split-index.c
index 2737cc6118..02a5b011c5 100644
--- a/split-index.c
+++ b/index/split-index.c
@@ -4,9 +4,9 @@
 #include "gettext.h"
 #include "odb/hash.h"
 #include "mem-pool.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
-#include "split-index.h"
+#include "index/split-index.h"
 #include "strbuf.h"
 #include "ewah/ewok.h"
 
diff --git a/split-index.h b/index/split-index.h
similarity index 100%
rename from split-index.h
rename to index/split-index.h
diff --git a/statinfo.c b/index/statinfo.c
similarity index 99%
rename from statinfo.c
rename to index/statinfo.c
index 5e00af127d..4a22923009 100644
--- a/statinfo.c
+++ b/index/statinfo.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "environment.h"
-#include "statinfo.h"
+#include "index/statinfo.h"
 #include "repository.h"
 
 /*
diff --git a/statinfo.h b/index/statinfo.h
similarity index 100%
rename from statinfo.h
rename to index/statinfo.h
diff --git a/symlinks.c b/index/symlinks.c
similarity index 99%
rename from symlinks.c
rename to index/symlinks.c
index 9e01ab3bc8..18fadf3f75 100644
--- a/symlinks.c
+++ b/index/symlinks.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "setup.h"
-#include "symlinks.h"
+#include "index/symlinks.h"
 
 static int threaded_check_leading_path(struct cache_def *cache, const char *name,
 				       int len, int warn_on_lstat_err);
diff --git a/symlinks.h b/index/symlinks.h
similarity index 100%
rename from symlinks.h
rename to index/symlinks.h
diff --git a/unpack-trees.c b/index/unpack-trees.c
similarity index 99%
rename from unpack-trees.c
rename to index/unpack-trees.c
index b911700d74..68d85f622e 100644
--- a/unpack-trees.c
+++ b/index/unpack-trees.c
@@ -6,30 +6,30 @@
 #include "strvec.h"
 #include "repository.h"
 #include "parse.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "name-hash.h"
+#include "index/name-hash.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
-#include "cache-tree.h"
-#include "unpack-trees.h"
+#include "index/cache-tree.h"
+#include "index/unpack-trees.h"
 #include "progress.h"
 #include "refs/refs.h"
 #include "attr.h"
-#include "read-cache.h"
-#include "split-index.h"
-#include "sparse-index.h"
+#include "index/read-cache.h"
+#include "index/split-index.h"
+#include "index/sparse-index.h"
 #include "submodule.h"
 #include "submodule-config.h"
-#include "symlinks.h"
+#include "index/symlinks.h"
 #include "trace2.h"
-#include "fsmonitor.h"
+#include "index/fsmonitor.h"
 #include "odb/odb.h"
 #include "promisor-remote.h"
-#include "entry.h"
-#include "parallel-checkout.h"
+#include "index/entry.h"
+#include "index/parallel-checkout.h"
 #include "setup.h"
 
 /*
diff --git a/unpack-trees.h b/index/unpack-trees.h
similarity index 99%
rename from unpack-trees.h
rename to index/unpack-trees.h
index d9d3ce09fd..f652a43f11 100644
--- a/unpack-trees.h
+++ b/index/unpack-trees.h
@@ -2,7 +2,7 @@
 #define UNPACK_TREES_H
 
 #include "convert.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "strvec.h"
 #include "string-list.h"
 #include "odb/tree-walk.h"
diff --git a/wt-status.c b/index/wt-status.c
similarity index 99%
rename from wt-status.c
rename to index/wt-status.c
index 83fdf5334f..3381a40e75 100644
--- a/wt-status.c
+++ b/index/wt-status.c
@@ -3,9 +3,9 @@
 
 #include "git-compat-util.h"
 #include "advice.h"
-#include "wt-status.h"
+#include "index/wt-status.h"
 #include "odb/object.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
 #include "environment.h"
@@ -24,7 +24,7 @@
 #include "refs/refs.h"
 #include "submodule.h"
 #include "column.h"
-#include "read-cache.h"
+#include "index/read-cache.h"
 #include "setup.h"
 #include "strbuf.h"
 #include "trace.h"
@@ -34,7 +34,7 @@
 #include "refs/worktree.h"
 #include "lockfile.h"
 #include "sequencer.h"
-#include "fsmonitor-settings.h"
+#include "index/fsmonitor-settings.h"
 
 #define AB_DELAY_WARNING_IN_MS (2 * 1000)
 #define UF_DELAY_WARNING_IN_MS (2 * 1000)
diff --git a/wt-status.h b/index/wt-status.h
similarity index 99%
rename from wt-status.h
rename to index/wt-status.h
index e9fe32e98c..b7a508186d 100644
--- a/wt-status.h
+++ b/index/wt-status.h
@@ -3,7 +3,7 @@
 
 #include "string-list.h"
 #include "color.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "remote.h"
 
 struct repository;
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index 846753abdf..c31ed7028d 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -5,7 +5,7 @@
 #include "lockfile.h"
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "odb/tag.h"
 #include "odb/tree.h"
diff --git a/merge-ort.c b/merge-ort.c
index 71274c24bf..516cd265c5 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -23,17 +23,17 @@
 #include "odb/alloc.h"
 #include "advice.h"
 #include "attr.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "odb/commit.h"
 #include "revision/commit-reach.h"
 #include "config.h"
 #include "diff/diff.h"
 #include "diff/diffcore.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "entry.h"
+#include "index/entry.h"
 #include "merge-ll.h"
 #include "odb/match-trees.h"
 #include "mem-pool.h"
@@ -43,14 +43,14 @@
 #include "odb/oid-array.h"
 #include "path.h"
 #include "promisor-remote.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "refs/refs.h"
 #include "revision/revision.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "strmap.h"
 #include "trace2.h"
 #include "odb/tree.h"
-#include "unpack-trees.h"
+#include "index/unpack-trees.h"
 #include "diff/xdiff-interface.h"
 
 /*
diff --git a/merge.c b/merge.c
index f46d968b70..0fcfc1460f 100644
--- a/merge.c
+++ b/merge.c
@@ -9,10 +9,10 @@
 #include "odb/commit.h"
 #include "repository.h"
 #include "run-command.h"
-#include "resolve-undo.h"
+#include "index/resolve-undo.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
-#include "unpack-trees.h"
+#include "index/unpack-trees.h"
 
 static const char *merge_argument(struct commit *commit)
 {
diff --git a/meson.build b/meson.build
index 65be53078d..c61ebc35a6 100644
--- a/meson.build
+++ b/meson.build
@@ -326,10 +326,10 @@ libgit_sources = [
   'branch.c',
   'bundle-uri.c',
   'bundle.c',
-  'cache-tree.c',
+  'index/cache-tree.c',
   'odb/cbtree.c',
   'chdir-notify.c',
-  'checkout.c',
+  'index/checkout.c',
   'pack/chunk-format.c',
   'color.c',
   'column.c',
@@ -363,10 +363,10 @@ libgit_sources = [
   'diff/diffcore-pickaxe.c',
   'diff/diffcore-rename.c',
   'diff/diffcore-rotate.c',
-  'dir-iterator.c',
-  'dir.c',
+  'index/dir-iterator.c',
+  'index/dir.c',
   'editor.c',
-  'entry.c',
+  'index/entry.c',
   'environment.c',
   'ewah/bitmap.c',
   'ewah/ewah_bitmap.c',
@@ -378,9 +378,9 @@ libgit_sources = [
   'fetch-pack.c',
   'fmt-merge-msg.c',
   'odb/fsck.c',
-  'fsmonitor.c',
-  'fsmonitor-ipc.c',
-  'fsmonitor-settings.c',
+  'index/fsmonitor.c',
+  'index/fsmonitor-ipc.c',
+  'index/fsmonitor-settings.c',
   'gettext.c',
   'git-zlib.c',
   'gpg-interface.c',
@@ -418,7 +418,7 @@ libgit_sources = [
   'merge.c',
   'pack/midx.c',
   'pack/midx-write.c',
-  'name-hash.c',
+  'index/name-hash.c',
   'negotiator/default.c',
   'negotiator/noop.c',
   'negotiator/skipping.c',
@@ -457,7 +457,7 @@ libgit_sources = [
   'pack/packfile.c',
   'pack/packfile-list.c',
   'pager.c',
-  'parallel-checkout.c',
+  'index/parallel-checkout.c',
   'parse.c',
   'parse-options-cb.c',
   'parse-options.c',
@@ -465,9 +465,9 @@ libgit_sources = [
   'diff/patch-ids.c',
   'path.c',
   'path-walk.c',
-  'pathspec.c',
+  'index/pathspec.c',
   'pkt-line.c',
-  'preload-index.c',
+  'index/preload-index.c',
   'revision/pretty.c',
   'prio-queue.c',
   'progress.c',
@@ -480,7 +480,7 @@ libgit_sources = [
   'quote.c',
   'diff/range-diff.c',
   'pack/reachable.c',
-  'read-cache.c',
+  'index/read-cache.c',
   'rebase-interactive.c',
   'rebase.c',
   'refs/ref-filter.c',
@@ -521,7 +521,7 @@ libgit_sources = [
   'repository.c',
   'rerere.c',
   'reset.c',
-  'resolve-undo.c',
+  'index/resolve-undo.c',
   'revision/revision.c',
   'run-command.c',
   'send-pack.c',
@@ -532,10 +532,10 @@ libgit_sources = [
   'revision/shallow.c',
   'sideband.c',
   'sigchain.c',
-  'sparse-index.c',
-  'split-index.c',
+  'index/sparse-index.c',
+  'index/split-index.c',
   'stable-qsort.c',
-  'statinfo.c',
+  'index/statinfo.c',
   'strbuf.c',
   'string-list.c',
   'strmap.c',
@@ -543,7 +543,7 @@ libgit_sources = [
   'sub-process.c',
   'submodule-config.c',
   'submodule.c',
-  'symlinks.c',
+  'index/symlinks.c',
   'odb/tag.c',
   'tempfile.c',
   'thread-utils.c',
@@ -568,7 +568,7 @@ libgit_sources = [
   'diff/tree-diff.c',
   'odb/tree-walk.c',
   'odb/tree.c',
-  'unpack-trees.c',
+  'index/unpack-trees.c',
   'upload-pack.c',
   'url.c',
   'urlmatch.c',
@@ -583,7 +583,7 @@ libgit_sources = [
   'wrapper.c',
   'write-or-die.c',
   'ws.c',
-  'wt-status.c',
+  'index/wt-status.c',
   'diff/xdiff-interface.c',
   'xdiff/xdiffi.c',
   'xdiff/xemit.c',
diff --git a/notes-merge.c b/notes-merge.c
index 53f42ba863..2bb6ad735e 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -16,7 +16,7 @@
 #include "hex.h"
 #include "diff/xdiff-interface.h"
 #include "merge-ll.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "notes.h"
 #include "notes-merge.h"
 #include "strbuf.h"
diff --git a/odb/commit.c b/odb/commit.c
index 1b0703a9ef..3b490c760c 100644
--- a/odb/commit.c
+++ b/odb/commit.c
@@ -20,7 +20,7 @@
 #include "odb/commit-slab.h"
 #include "prio-queue.h"
 #include "odb/hash-lookup.h"
-#include "wt-status.h"
+#include "index/wt-status.h"
 #include "advice.h"
 #include "refs/refs.h"
 #include "revision/commit-reach.h"
diff --git a/odb/fsck.c b/odb/fsck.c
index 8c953f61a4..e889268b48 100644
--- a/odb/fsck.c
+++ b/odb/fsck.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "date.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "hex.h"
 #include "odb/odb.h"
diff --git a/odb/hash-lookup.c b/odb/hash-lookup.c
index cf2d4a0245..9e8e5efb4f 100644
--- a/odb/hash-lookup.c
+++ b/odb/hash-lookup.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "odb/hash.h"
 #include "odb/hash-lookup.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 
 static uint32_t take2(const struct object_id *oid, size_t ofs)
 {
diff --git a/odb/object-file.c b/odb/object-file.c
index 41ee67abb6..847b78e5c7 100644
--- a/odb/object-file.c
+++ b/odb/object-file.c
@@ -11,7 +11,7 @@
 
 #include "git-compat-util.h"
 #include "convert.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "odb/fsck.h"
 #include "gettext.h"
@@ -25,7 +25,7 @@
 #include "pack/pack.h"
 #include "pack/packfile.h"
 #include "path.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "setup.h"
 #include "strvec.h"
 #include "tempfile.h"
diff --git a/odb/object-name.c b/odb/object-name.c
index 825fc717bf..95a63c7f64 100644
--- a/odb/object-name.c
+++ b/odb/object-name.c
@@ -14,11 +14,11 @@
 #include "odb/tree-walk.h"
 #include "refs/refs.h"
 #include "remote.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "odb/odb.h"
 #include "odb/oid-array.h"
 #include "revision/pretty.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repo-settings.h"
 #include "repository.h"
 #include "setup.h"
diff --git a/odb/object.c b/odb/object.c
index 7c2f920d3f..cd93a7b47b 100644
--- a/odb/object.c
+++ b/odb/object.c
@@ -8,7 +8,7 @@
 #include "odb/object-file.h"
 #include "odb/streaming.h"
 #include "odb/blob.h"
-#include "statinfo.h"
+#include "index/statinfo.h"
 #include "odb/tree.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
diff --git a/odb/odb.c b/odb/odb.c
index e942149d91..4e408501e8 100644
--- a/odb/odb.c
+++ b/odb/odb.c
@@ -2,7 +2,7 @@
 #include "abspath.h"
 #include "pack/commit-graph.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/odb/source-packed.c b/odb/source-packed.c
index c1e2756471..d3def038c6 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "git-zlib.h"
 #include "revision/list-objects-filter-options.h"
 #include "mergesort.h"
diff --git a/odb/tmp-objdir.c b/odb/tmp-objdir.c
index b9ba5c4cd3..21219e8797 100644
--- a/odb/tmp-objdir.c
+++ b/odb/tmp-objdir.c
@@ -2,7 +2,7 @@
 #include "odb/tmp-objdir.h"
 #include "abspath.h"
 #include "chdir-notify.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "odb/object-file.h"
 #include "path.h"
diff --git a/odb/tree-walk.c b/odb/tree-walk.c
index 51e8037ef5..e3e22e1a32 100644
--- a/odb/tree-walk.c
+++ b/odb/tree-walk.c
@@ -2,17 +2,17 @@
 
 #include "git-compat-util.h"
 #include "odb/tree-walk.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "trace2.h"
 #include "odb/tree.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "json-writer.h"
 #include "environment.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 
 static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size, struct strbuf *err)
 {
diff --git a/organize/gitorganize-format.c b/organize/gitorganize-format.c
index 541dd373aa..8edf1659e0 100644
--- a/organize/gitorganize-format.c
+++ b/organize/gitorganize-format.c
@@ -2,7 +2,7 @@
 #include "gitorganize-format.h"
 #include "gettext.h"
 #include "quote.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "wrapper.h"
diff --git a/organize/organize.c b/organize/organize.c
index 298557a3da..f1f0aec6ea 100644
--- a/organize/organize.c
+++ b/organize/organize.c
@@ -5,16 +5,16 @@
 #include "organizer-protocol.h"
 #include "config.h"
 #include "gettext.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "quote.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "wrapper.h"
-#include "wt-status.h"
+#include "index/wt-status.h"
 
 /* The configured command organize.<key> (labeler or organizer), or NULL. */
 static const char *organize_command(struct repository *repo, const char *key)
diff --git a/pack/midx.c b/pack/midx.c
index 2608e99468..76e77d0dd2 100644
--- a/pack/midx.c
+++ b/pack/midx.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "hex.h"
 #include "pack/packfile.h"
 #include "odb/hash-lookup.h"
diff --git a/pack/packfile.c b/pack/packfile.c
index 72252faffe..77de6bb821 100644
--- a/pack/packfile.c
+++ b/pack/packfile.c
@@ -7,7 +7,7 @@
 #include "revision/list.h"
 #include "pack/pack.h"
 #include "repository.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "pack/packfile.h"
 #include "pack/delta.h"
 #include "odb/hash-lookup.h"
diff --git a/pack/reachable.c b/pack/reachable.c
index f61525308e..5b8a2a4f79 100644
--- a/pack/reachable.c
+++ b/pack/reachable.c
@@ -9,7 +9,7 @@
 #include "diff/diff.h"
 #include "revision/revision.h"
 #include "pack/reachable.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "progress.h"
 #include "revision/list-objects.h"
 #include "pack/packfile.h"
diff --git a/pack/repack.c b/pack/repack.c
index 91dde13b29..52e7779a44 100644
--- a/pack/repack.c
+++ b/pack/repack.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "pack/midx.h"
 #include "odb/odb.h"
 #include "pack/packfile.h"
diff --git a/pack/server-info.c b/pack/server-info.c
index 627d2e3c98..dbd86d6fd2 100644
--- a/pack/server-info.c
+++ b/pack/server-info.c
@@ -1,7 +1,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "hex.h"
 #include "repository.h"
 #include "refs/refs.h"
diff --git a/path-walk.c b/path-walk.c
index 4b8ddb2a28..00686d3dbf 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -5,7 +5,7 @@
 #include "path-walk.h"
 #include "odb/blob.h"
 #include "odb/commit.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "hashmap.h"
 #include "hex.h"
 #include "revision/list-objects.h"
diff --git a/path.c b/path.c
index 516abb3f82..e4d489e10a 100644
--- a/path.c
+++ b/path.c
@@ -8,7 +8,7 @@
 #include "repository.h"
 #include "strbuf.h"
 #include "string-list.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "refs/worktree.h"
 #include "setup.h"
 #include "submodule-config.h"
diff --git a/rebase-interactive.c b/rebase-interactive.c
index df9c2d1275..ee2ef8b535 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -11,7 +11,7 @@
 #include "strbuf.h"
 #include "odb/commit-slab.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "odb/object-name.h"
 
 static const char edit_todo_list_advice[] =
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a792297d8f..e6e07938a3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -16,10 +16,10 @@
 #include "packed-backend.h"
 #include "../ident.h"
 #include "../iterator.h"
-#include "../dir-iterator.h"
+#include "index/dir-iterator.h"
 #include "../lockfile.h"
 #include "../path.h"
-#include "../dir.h"
+#include "index/dir.h"
 #include "../chdir-notify.h"
 #include "../setup.h"
 #include "refs/worktree.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index afcb800a5f..97f76c1d76 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2,7 +2,7 @@
 
 #include "../git-compat-util.h"
 #include "../config.h"
-#include "../dir.h"
+#include "index/dir.h"
 #include "odb/fsck.h"
 #include "../gettext.h"
 #include "odb/hash.h"
@@ -13,7 +13,7 @@
 #include "../iterator.h"
 #include "../lockfile.h"
 #include "../chdir-notify.h"
-#include "../statinfo.h"
+#include "index/statinfo.h"
 #include "refs/worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
diff --git a/refs/ref-filter.c b/refs/ref-filter.c
index 7635e13f88..32027789a8 100644
--- a/refs/ref-filter.c
+++ b/refs/ref-filter.c
@@ -28,7 +28,7 @@
 #include "utf8.h"
 #include "versioncmp.h"
 #include "trailer.h"
-#include "wt-status.h"
+#include "index/wt-status.h"
 #include "odb/commit-slab.h"
 #include "revision/commit-reach.h"
 #include "refs/worktree.h"
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 120f9c947f..0c02b2d287 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2,7 +2,7 @@
 #include "../abspath.h"
 #include "../chdir-notify.h"
 #include "../config.h"
-#include "../dir.h"
+#include "index/dir.h"
 #include "../environment.h"
 #include "odb/fsck.h"
 #include "../gettext.h"
diff --git a/refs/worktree.c b/refs/worktree.c
index 3578229534..0f1fe6a7d2 100644
--- a/refs/worktree.c
+++ b/refs/worktree.c
@@ -10,8 +10,8 @@
 #include "setup.h"
 #include "strbuf.h"
 #include "refs/worktree.h"
-#include "dir.h"
-#include "wt-status.h"
+#include "index/dir.h"
+#include "index/wt-status.h"
 #include "config.h"
 
 void free_worktree(struct worktree *worktree)
diff --git a/remote.c b/remote.c
index 8a65967fb0..2b376893b3 100644
--- a/remote.c
+++ b/remote.c
@@ -18,7 +18,7 @@
 #include "odb/commit.h"
 #include "diff/diff.h"
 #include "revision/revision.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "setup.h"
 #include "string-list.h"
 #include "strvec.h"
diff --git a/repository.c b/repository.c
index b5e442f9f3..8771145515 100644
--- a/repository.c
+++ b/repository.c
@@ -9,12 +9,12 @@
 #include "odb/object.h"
 #include "lockfile.h"
 #include "path.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "remote.h"
 #include "setup.h"
 #include "odb/loose.h"
 #include "submodule-config.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "trace2.h"
 #include "promisor-remote.h"
 #include "refs/refs.h"
diff --git a/rerere.c b/rerere.c
index 3055989a41..df30ebbe93 100644
--- a/rerere.c
+++ b/rerere.c
@@ -10,14 +10,14 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "string-list.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "rerere.h"
 #include "diff/xdiff-interface.h"
-#include "dir.h"
-#include "resolve-undo.h"
+#include "index/dir.h"
+#include "index/resolve-undo.h"
 #include "merge-ll.h"
 #include "path.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "strmap.h"
diff --git a/reset.c b/reset.c
index 29bbeaa9d4..0eddc94d8c 100644
--- a/reset.c
+++ b/reset.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -8,7 +8,7 @@
 #include "reset.h"
 #include "odb/tree-walk.h"
 #include "odb/tree.h"
-#include "unpack-trees.h"
+#include "index/unpack-trees.h"
 #include "hook.h"
 
 static int update_refs(struct repository *repo,
diff --git a/revision/bisect.c b/revision/bisect.c
index 696e365310..7805872c3e 100644
--- a/revision/bisect.c
+++ b/revision/bisect.c
@@ -22,7 +22,7 @@
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "path.h"
-#include "dir.h"
+#include "index/dir.h"
 
 static struct oid_array good_revs;
 static struct oid_array skipped_revs;
diff --git a/revision/blame.c b/revision/blame.c
index 54284ed8da..a75bf22193 100644
--- a/revision/blame.c
+++ b/revision/blame.c
@@ -4,7 +4,7 @@
 #include "git-compat-util.h"
 #include "refs/refs.h"
 #include "odb/odb.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "mergesort.h"
 #include "odb/commit.h"
 #include "convert.h"
@@ -13,7 +13,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "path.h"
-#include "read-cache.h"
+#include "index/read-cache.h"
 #include "revision/revision.h"
 #include "setup.h"
 #include "odb/tag.h"
diff --git a/revision/list-objects-filter.c b/revision/list-objects-filter.c
index 0ea4cb826e..da88781aef 100644
--- a/revision/list-objects-filter.c
+++ b/revision/list-objects-filter.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/commit.h"
diff --git a/revision/revision.c b/revision/revision.c
index 9a19a5654a..97c6fa6fef 100644
--- a/revision/revision.c
+++ b/revision/revision.c
@@ -29,14 +29,14 @@
 #include "revision/log-tree.h"
 #include "mailmap.h"
 #include "odb/commit-slab.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "revision/bisect.h"
 #include "pack/packfile.h"
 #include "refs/worktree.h"
 #include "path.h"
-#include "read-cache.h"
+#include "index/read-cache.h"
 #include "setup.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "strvec.h"
 #include "trace2.h"
 #include "revision/commit-reach.h"
@@ -47,7 +47,7 @@
 #include "pack/bloom.h"
 #include "json-writer.h"
 #include "revision/list-objects-filter-options.h"
-#include "resolve-undo.h"
+#include "index/resolve-undo.h"
 #include "parse-options.h"
 #include "wildmatch.h"
 
diff --git a/revision/shallow.c b/revision/shallow.c
index 51ba602971..f4ce207278 100644
--- a/revision/shallow.c
+++ b/revision/shallow.c
@@ -18,7 +18,7 @@
 #include "revision/list-objects.h"
 #include "revision/commit-reach.h"
 #include "revision/shallow.h"
-#include "statinfo.h"
+#include "index/statinfo.h"
 #include "trace.h"
 
 void set_alternate_shallow_file(struct repository *r, const char *path)
diff --git a/run-command.c b/run-command.c
index e0c4325900..80382354dc 100644
--- a/run-command.c
+++ b/run-command.c
@@ -7,7 +7,7 @@
 #include "gettext.h"
 #include "sigchain.h"
 #include "strvec.h"
-#include "symlinks.h"
+#include "index/symlinks.h"
 #include "thread-utils.h"
 #include "strbuf.h"
 #include "string-list.h"
diff --git a/scalar.c b/scalar.c
index 2cb09af1a5..d1e397ef50 100644
--- a/scalar.c
+++ b/scalar.c
@@ -11,10 +11,10 @@
 #include "config.h"
 #include "run-command.h"
 #include "simple-ipc.h"
-#include "fsmonitor-ipc.h"
-#include "fsmonitor-settings.h"
+#include "index/fsmonitor-ipc.h"
+#include "index/fsmonitor-settings.h"
 #include "refs/refs.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "pack/packfile.h"
 #include "help.h"
 #include "setup.h"
diff --git a/sequencer.c b/sequencer.c
index d5b1eb9719..f4a0f77eaf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -10,7 +10,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
@@ -21,7 +21,7 @@
 #include "run-command.h"
 #include "hook.h"
 #include "utf8.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "diff/diff.h"
 #include "path.h"
 #include "revision/revision.h"
@@ -30,16 +30,16 @@
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
 #include "refs/refs.h"
-#include "sparse-index.h"
+#include "index/sparse-index.h"
 #include "strvec.h"
 #include "quote.h"
 #include "trailer.h"
 #include "revision/log-tree.h"
-#include "wt-status.h"
+#include "index/wt-status.h"
 #include "hashmap.h"
 #include "notes-utils.h"
 #include "sigchain.h"
-#include "unpack-trees.h"
+#include "index/unpack-trees.h"
 #include "odb/oidmap.h"
 #include "odb/oidset.h"
 #include "odb/commit-slab.h"
diff --git a/sequencer.h b/sequencer.h
index 64a9c7fb1b..0906cc127d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -3,7 +3,7 @@
 
 #include "strbuf.h"
 #include "strvec.h"
-#include "wt-status.h"
+#include "index/wt-status.h"
 
 struct commit;
 struct index_state;
diff --git a/setup.c b/setup.c
index 62fbda948d..e4e9ca83fe 100644
--- a/setup.c
+++ b/setup.c
@@ -12,7 +12,7 @@
 #include "refs/refs.h"
 #include "repository.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "setup.h"
 #include "revision/shallow.h"
 #include "string-list.h"
diff --git a/submodule-config.c b/submodule-config.c
index 094e64d8fd..c8be0acbb1 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -2,7 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/submodule.c b/submodule.c
index 16f4d30b82..e14b53d3c8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -7,7 +7,7 @@
 #include "config.h"
 #include "submodule-config.h"
 #include "submodule.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "diff/diff.h"
 #include "odb/commit.h"
 #include "environment.h"
@@ -29,7 +29,7 @@
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "revision/commit-reach.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "setup.h"
 #include "advice.h"
 #include "url.h"
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index 9f613d2911..cf7e7efc5d 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -5,9 +5,9 @@
 #include "gettext.h"
 #include "hex.h"
 #include "odb/tree.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 #include "parse-options.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index 8d46e8ba40..f2734c5f88 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -2,7 +2,7 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "iterator.h"
-#include "dir-iterator.h"
+#include "index/dir-iterator.h"
 
 static const char *error_name(int error_number)
 {
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 849727d69b..599b316ac1 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -4,8 +4,8 @@
 #include "odb/hash.h"
 #include "hex.h"
 #include "odb/tree.h"
-#include "cache-tree.h"
-#include "read-cache-ll.h"
+#include "index/cache-tree.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index c991cbbb8a..1dbdb28fbf 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index aae0a40a74..79c8628005 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -2,10 +2,10 @@
 
 #include "test-tool.h"
 #include "hex.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
-#include "split-index.h"
+#include "index/split-index.h"
 #include "ewah/ewok.h"
 
 static void show_bit(size_t pos, void *data UNUSED)
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index 24308bd371..c31d01f3b5 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -1,9 +1,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "hex.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index dc1dff23fb..845c1db493 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -7,8 +7,8 @@
 
 #include "test-tool.h"
 #include "parse-options.h"
-#include "fsmonitor-ipc.h"
-#include "read-cache-ll.h"
+#include "index/fsmonitor-ipc.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 #include "thread-utils.h"
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 43cead6d7d..6f16fcf7e8 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -2,9 +2,9 @@
 
 #include "test-tool.h"
 #include "environment.h"
-#include "name-hash.h"
+#include "index/name-hash.h"
 #include "parse-options.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 #include "trace.h"
diff --git a/t/helper/test-parse-pathspec-file.c b/t/helper/test-parse-pathspec-file.c
index 89ecefd1cd..1b21e919db 100644
--- a/t/helper/test-parse-pathspec-file.c
+++ b/t/helper/test-parse-pathspec-file.c
@@ -1,6 +1,6 @@
 #include "test-tool.h"
 #include "parse-options.h"
-#include "pathspec.h"
+#include "index/pathspec.h"
 
 int cmd__parse_pathspec_file(int argc, const char **argv)
 {
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index f77b3f9d70..fd98a5bfd9 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -5,7 +5,7 @@
 #include "abspath.h"
 #include "environment.h"
 #include "path.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "setup.h"
 #include "string-list.h"
 #include "trace.h"
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index 71d052d504..f689ff3c53 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "environment.h"
 #include "hex.h"
 #include "revision/list-objects-filter-options.h"
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 6b08ba8f07..dad40b8ad7 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "config.h"
 #include "environment.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index f4f7df067d..8e40a08436 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -2,11 +2,11 @@
 
 #include "test-tool.h"
 #include "lockfile.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 #include "odb/tree.h"
-#include "cache-tree.h"
+#include "index/cache-tree.h"
 
 int cmd__scrap_cache_tree(int ac UNUSED, const char **av UNUSED)
 {
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index 98e1477c98..ffe468b445 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -2,7 +2,7 @@
 
 #include "test-tool.h"
 #include "lockfile.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 72ee20a06f..4d4e37019e 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -31,7 +31,7 @@ static struct {
  * There are other compilers that do the same, and are not for
  * Windows.
  */
-#include "dir.h"
+#include "index/dir.h"
 
 static const char *make_relative(const char *location)
 {
diff --git a/t/unit-tests/u-dir.c b/t/unit-tests/u-dir.c
index 2d0adaa39e..72de0b0299 100644
--- a/t/unit-tests/u-dir.c
+++ b/t/unit-tests/u-dir.c
@@ -1,5 +1,5 @@
 #include "unit-test.h"
-#include "dir.h"
+#include "index/dir.h"
 
 #define TEST_WITHIN_DEPTH(path, depth, max_depth, expect) do { \
 		int actual = within_depth(path, strlen(path), \
diff --git a/t/unit-tests/u-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
index e6c1635940..4c53301154 100644
--- a/t/unit-tests/u-reftable-stack.c
+++ b/t/unit-tests/u-reftable-stack.c
@@ -9,7 +9,7 @@ license that can be found in the LICENSE file or at
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "unit-test.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "lib-reftable.h"
 #include "reftable/merged.h"
 #include "reftable/reftable-error.h"
diff --git a/t/unit-tests/u-strcmp-offset.c b/t/unit-tests/u-strcmp-offset.c
index 7e8e9acf3c..8b65c5555c 100644
--- a/t/unit-tests/u-strcmp-offset.c
+++ b/t/unit-tests/u-strcmp-offset.c
@@ -1,5 +1,5 @@
 #include "unit-test.h"
-#include "read-cache-ll.h"
+#include "index/read-cache-ll.h"
 
 static void check_strcmp_offset(const char *string1, const char *string2,
 				int expect_result, uintmax_t expect_offset)
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index 4abc218514..c63aebbec5 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "config.h"
-#include "dir.h"
+#include "index/dir.h"
 #include "tr2_sysenv.h"
 
 /*
-- 
2.54.0

