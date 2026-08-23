Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3313FEE
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505563; cv=none; b=SoZs1sX2YTzDV0TfLrtJ0bN9Uqj5/pfDNz5EWkB9gm2Jhpxbc11eboTaFnYIzK1UWc6R1PMjAnoxvIQHq/BK9yviJ+dwYK5upMjNVPTBx4qmaVEFjSTHBDStDwMhpNH02R/Lu98C23/aNw2SgjZNR7HAycCQ/DdaG4080IP3KRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505563; c=relaxed/simple;
	bh=KR1EL3WjR5ci71fns/+iaaHmMywHNNWV2tAaH54Mzms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EzTkGdDnRdH3c0LAW8O5KXFlDAdLwDqai40Mpsql5W1oEegLtA/8sfnAlUMP38YFowCXw3wBB9RX8SzuGRcMCRhLyiZLCgA1Fs28TJe16aE4orgJtVjHmwDBu42yPr9HFH6OVo4FUFb4d0Y7tR+yE7UXo/v8MOcCZo6j/sgK6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9Bg5ihR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9Bg5ihR"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2175128a91.0
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505557; x=1788110357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5917vaUpdvK2mocGeexhefzxhlBKS/jYDFg4LC//sRw=;
        b=F9Bg5ihRvlj6FOXzHD7fNf3faP8wRZuLlHmyTDHCEFdkUv27ELvz43zf50WMxUZJNu
         Wnz13ZZ0wa22zyWnAb9PZ2ta3xwlcBDJfQB4r4cnkPpvOTJByRccSbb+ltnyV8uzX1Di
         SanCMoOJfhEivBSziTPbFFiVSBmKgaFT8F4tX9+VEKzQyBYEPgdbHjCEmVEYPnoFwofZ
         CUeGPYNTdm7iNmaIvhDvAwcoFWViVpl57UMJkmpXtMJy75Iv9v7Xv1nhMd7finYx9+yG
         ZF7A2IOcIQCo/2ssBjb1kcyBSnHnKnkaq5qCiJq2mTZ+X0Hdkgtv1qVtcA7fl4+EAte8
         o1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505557; x=1788110357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5917vaUpdvK2mocGeexhefzxhlBKS/jYDFg4LC//sRw=;
        b=ox425T7Ni8Jo6NA2JaYB/bI+cubHvgVmBfPCTZ5AXnrlz69kdqhB1EmdjsqHRwzwUY
         83TeG7xnblWddd/OQNnys6iyUPXRrMkLNk2cMgbVxoaNVnHVMLHXh0CVwOID0XFspB99
         esxLqxy+7zraPEpX0aq55hCwGDauw5GP7nq7fW2Zmitz6w6DW+slZsUNataWPuQ+P6E6
         fiiOy1uaDY6S1K342aYiuR96xLVuz4YfO1uGvopyumqR4GyFyLDxRNAt3J/PM76gxqza
         47e48PzTy/+zYoN2Uwil0yupFvs8s2SABIJ/98uWo+PyVYyWwj71KoPVjY7TSQEfvRn4
         REyQ==
X-Gm-Message-State: AFuF++kta0/TfQIebfQITF5A1L82UBU4fjqixrJoSz8IayIvc6vi2tNW
	/eTquHHZONU33gDJb2PKP2z0kT+1bJ+7YgSdiDl8xxOMWkV5MeWKb+a8ksaH3Q==
X-Gm-Gg: AR+sD12LcpD5GSCxftLP8NAxwSDVxmtqPZrFNBNGlXwVGsbkWqallgeGRpZwGvWMtw9
	TnQEhW+9Fn+stlRVAVaHwFbRfe1lkromxURL4TfrZckPSIoQpffrJV1aFiH8CgfIJASWnXg7ypa
	TkGINhqoly54eYtpTYQv/O+cV6Jun0bawLj51L6kAJnsGNfjTpUV73p6jrKzvU2mFEpc1AKBUYB
	CM4fRmlPb7WGpt/58nb3ohc9aWFWeqZC3zCgsmN6Ragor6Bh+LdmbrvjnQAhzyCB7u0b3hq/pNg
	s/GLbMaR5FxIeMUp6qFFp191RXD6wygaFw63NS6y6VcNyfnVH83weTu1j8R79EpxAdQvZOEgN+Y
	dA+2XCYkUjPFqrUNju6KpPfF2zndGZWLeKk4kd0xbbb1Ov+QvBF6P8zSpUNsu1PkHbjtb6UiySb
	G0Av5HUcROdyqoAkaUR3mfa9AjHFj80svbuPegOOAxGAObFsfvUQGWof7VIBO5Ubuo0bsDBNVHG
	B1DnlGM+UespfkeL4nOhzrX7RrgZUhLkd5LoZQvUWibhyqJKz7q8lBy+P/KihMOHFfW21akBJs0
	pY+GRWqT4gZqhJWfgsgB2Wn8sl0TagJFmfwRDu9foxIshg==
X-Received: by 2002:a17:90b:580f:b0:380:f389:447b with SMTP id 98e67ed59e1d1-395c386d163mr40866874a91.11.1787505556735;
        Sun, 23 Aug 2026 10:19:16 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418617378bsm16580863c88.11.2026.08.23.10.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:15 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 00/14] git organize: record file placement and apply it
Date: Sun, 23 Aug 2026 10:18:44 -0700
Message-ID: <20260823171915.2662373-1-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds git organize, a command that records where a project's
files belong and moves the files that are not there yet. It is inspired
by the series to move the libgit.a sources under lib/ [1], and the
sub-thread there on grouping files by signals already present in the
tree [2]. That sub-thread asked which such signals identify a group of
files that could move into a subdirectory. This RFC attempts to provide
one answer, a tool that records such groups of files and applies the
appropriate moves.

git organize has two jobs. It records a project's file-placement
guideline in a tracked file, so the guideline travels with the
repository. And it moves a file to its recorded directory, repoints the
references to it, and stages the result; because a move can repoint the
moved file's own references, the change is a rename plus mechanical
reference repoints rather than an exact content-identical rename. The
tool holds no layout of its own: a project states the placement, and git
organize records it and performs the moves.

The guideline is .gitorganize. Its [scope] section lists the governed
files as pathspecs. Its [layout] section holds ordered "label:value =
directory" rules, where the first rule a file matches names its
directory. Its [labels] section records one line per recorded source,
holding its component and role; apply repoints a moved file's line to
its new path, and a file already inside a layout directory before it was
recorded has no line. Two configured commands supply the
project-specific parts: the labeler records a file's labels, and the
organizer returns the reference edits for a move and declines a move
whose references it cannot repoint. A line already in [labels] is kept
as recorded, so git organize apply --labels-only fills a file that has
no line and leaves the rest; a placement set by hand or in an earlier
run stands.

For Git's own tree, the reference labeler answers [2] from signals
already in the history. It reads the "area:" prefix a file's commits
carry most often, mined with git log --follow so a rename keeps the
file's past, and a committed map consolidates those prefixes into
components. A file whose prefix is too broad, unmapped, or absent falls
back to its filename, and a file that its prefix does not place but that
changes chiefly alongside one component is drawn into it. Each recorded
line also carries the prefix, the file's #include coupling, and its
co-change profile, so a reader sees the signals a placement rests on.
The advisory prefix= text is mildly git-version sensitive, because git
log --follow rename heuristics differ across git versions; the placed
component does not vary, because the map keys on both a file's old-name
token and its current-name token, which resolve to the same component.

git organize status reports the governed files in groups: in place, to
move, backlog (a file recorded with no directory), and a recorded path
that no longer exists. With --exit-code it fails when a file is out of
place. Before any carve it reports

    $ git organize status
    organize: 495 in scope (113 in place, 303 to move, 79 backlog)

This series carves the subsystems whose files reference each other: odb,
refs, pack, diff, revision, index, setup, and transport. Measured
intra-component #include coupling puts odb as the most tightly coupled,
so it is carved first; the remaining subsystems are all internally
cohesive, without a strict coupling rank among them. Each carve is one
commit that moves the subsystem's sources and headers into its directory
and repoints every reference: the #include lines, the Makefile and
meson.build entries, the contrib CMake build, and the #include examples
in the tutorials. Because apply --label selects a single subsystem, the
moves arrive one commit at a time, each self-contained and reviewable on
its own, rather than as one sweeping rename. After these eight carves
status reports

    $ git organize status
    organize: 495 in scope (380 in place, 36 to move, 79 backlog)

A carve is a rename plus mechanical reference repoints, including the
moved file's own #include lines, so git blame and git log --follow still
track it; it changes where a file lives, not what it depends on. Where
each file belongs is the project's judgment, recorded in the layout and
offered here to be argued and replaced: bisect.c sits under revision/
because it uses the revision machinery, but whether it should instead
stand on its own, as rev-list and log do, is exactly the kind of call
the labeler makes and the series invites reviewers to correct. A relabel
and a re-run follow any such decision.

Two groups remain: 36 files the layout places but leaves uncarved here
(archive, convert, merge, notes, and submodule), and 79 in backlog with
no directory yet. The same labeler and organizer produce those patches.
Each carve also updates .gitorganize, the tool's own record, so a carve
taken upstream drops that line and stands on its own as ordinary renames
and repoints; the tool need not be merged for a carve to be useful.

The target directories are not built into the tool: changing only the
[layout] entries (component:odb = lib/odb, and so on) yields a layout
nested under lib/, which builds. That is how this pairs with the series
moving the libgit.a sources under lib/ [1]: the directory can be
lib/<component>, so the same tool groups those sources further under
lib/ rather than proposing an alternate top-level layout.

[1] https://lore.kernel.org/git/20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im/T/#m39669398367d8b79af9a40080996d475193a6d2b
[2] https://lore.kernel.org/git/20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im/T/#mfd455931a236cca8d669fdfcc0ef1d7127237cd6

Michael Montalbo (14):
  organize: add the git organize builtin
  organize: add the labeler, organizer, and apply --labels-only
  organize: add status --exit-code
  organize: add the --label selector
  organize: declare Git's scope and layout
  organize: record a label for every source in scope
  odb: gather the odb sources under odb/
  refs: gather the refs sources under refs/
  pack: gather the pack sources under pack/
  diff: gather the diff sources under diff/
  revision: gather the revision sources under revision/
  index: gather the index sources under index/
  setup: gather the setup sources under setup/
  transport: gather the transport sources under transport/

 .gitignore                                    |   1 +
 .gitorganize                                  | 494 ++++++++++++
 Documentation/Makefile                        |   4 +-
 Documentation/MyFirstContribution.adoc        |  10 +-
 Documentation/MyFirstObjectWalk.adoc          |  10 +-
 Documentation/git-organize.adoc               | 199 +++++
 Documentation/meson.build                     |   1 +
 Makefile                                      | 309 ++++----
 add-interactive.c                             |  18 +-
 add-patch.c                                   |  16 +-
 advice.c                                      |   4 +-
 apply.c                                       |  30 +-
 apply.h                                       |   2 +-
 archive-tar.c                                 |   4 +-
 archive-zip.c                                 |   8 +-
 archive.c                                     |  22 +-
 archive.h                                     |   2 +-
 attr.c                                        |  20 +-
 branch.c                                      |  18 +-
 builtin.h                                     |   3 +-
 builtin/add.c                                 |  20 +-
 builtin/am.c                                  |  28 +-
 builtin/apply.c                               |   2 +-
 builtin/archive.c                             |   4 +-
 builtin/backfill.c                            |  28 +-
 builtin/bisect.c                              |  12 +-
 builtin/blame.c                               |  28 +-
 builtin/branch.c                              |  18 +-
 builtin/bugreport.c                           |   6 +-
 builtin/bundle.c                              |   6 +-
 builtin/cat-file.c                            |  32 +-
 builtin/check-attr.c                          |   8 +-
 builtin/check-ignore.c                        |   8 +-
 builtin/check-mailmap.c                       |   6 +-
 builtin/check-ref-format.c                    |   4 +-
 builtin/checkout--worker.c                    |  12 +-
 builtin/checkout-index.c                      |  16 +-
 builtin/checkout.c                            |  56 +-
 builtin/clean.c                               |  12 +-
 builtin/clone.c                               |  42 +-
 builtin/column.c                              |   2 +-
 builtin/commit-graph.c                        |  14 +-
 builtin/commit-tree.c                         |  10 +-
 builtin/commit.c                              |  34 +-
 builtin/config.c                              |  10 +-
 builtin/count-objects.c                       |  10 +-
 builtin/credential-cache--daemon.c            |   2 +-
 builtin/credential-store.c                    |   2 +-
 builtin/credential.c                          |   4 +-
 builtin/describe.c                            |  28 +-
 builtin/diff-files.c                          |  12 +-
 builtin/diff-index.c                          |  14 +-
 builtin/diff-pairs.c                          |  12 +-
 builtin/diff-tree.c                           |  16 +-
 builtin/diff.c                                |  26 +-
 builtin/difftool.c                            |  20 +-
 builtin/fast-export.c                         |  32 +-
 builtin/fast-import.c                         |  32 +-
 builtin/fetch-pack.c                          |  14 +-
 builtin/fetch.c                               |  38 +-
 builtin/fmt-merge-msg.c                       |   2 +-
 builtin/for-each-ref.c                        |  10 +-
 builtin/for-each-repo.c                       |   4 +-
 builtin/fsck.c                                |  40 +-
 builtin/fsmonitor--daemon.c                   |  14 +-
 builtin/gc.c                                  |  30 +-
 builtin/get-tar-commit-id.c                   |   2 +-
 builtin/grep.c                                |  26 +-
 builtin/hash-object.c                         |  12 +-
 builtin/help.c                                |   8 +-
 builtin/history.c                             |  26 +-
 builtin/hook.c                                |   6 +-
 builtin/index-pack.c                          |  38 +-
 builtin/init-db.c                             |   6 +-
 builtin/interpret-trailers.c                  |   4 +-
 builtin/last-modified.c                       |  24 +-
 builtin/log.c                                 |  52 +-
 builtin/ls-files.c                            |  20 +-
 builtin/ls-remote.c                           |   8 +-
 builtin/ls-tree.c                             |  12 +-
 builtin/mailinfo.c                            |   2 +-
 builtin/merge-base.c                          |  10 +-
 builtin/merge-file.c                          |  14 +-
 builtin/merge-index.c                         |   4 +-
 builtin/merge-ours.c                          |   6 +-
 builtin/merge-recursive.c                     |   4 +-
 builtin/merge-tree.c                          |  20 +-
 builtin/merge.c                               |  44 +-
 builtin/mktag.c                               |  10 +-
 builtin/mktree.c                              |   6 +-
 builtin/multi-pack-index.c                    |  12 +-
 builtin/mv.c                                  |  20 +-
 builtin/name-rev.c                            |  22 +-
 builtin/notes.c                               |  16 +-
 builtin/organize.c                            | 153 ++++
 builtin/pack-objects.c                        |  66 +-
 builtin/pack-redundant.c                      |   4 +-
 builtin/pack-refs.c                           |   2 +-
 builtin/patch-id.c                            |  10 +-
 builtin/prune-packed.c                        |   2 +-
 builtin/prune.c                               |  24 +-
 builtin/pull.c                                |  22 +-
 builtin/push.c                                |  16 +-
 builtin/range-diff.c                          |   6 +-
 builtin/read-tree.c                           |  22 +-
 builtin/rebase.c                              |  26 +-
 builtin/receive-pack.c                        |  52 +-
 builtin/reflog.c                              |  14 +-
 builtin/refs.c                                |  10 +-
 builtin/remote-ext.c                          |   4 +-
 builtin/remote-fd.c                           |   2 +-
 builtin/remote.c                              |  16 +-
 builtin/repack.c                              |  18 +-
 builtin/replace.c                             |  16 +-
 builtin/replay.c                              |   8 +-
 builtin/repo.c                                |  22 +-
 builtin/rerere.c                              |   6 +-
 builtin/reset.c                               |  32 +-
 builtin/rev-list.c                            |  40 +-
 builtin/rev-parse.c                           |  34 +-
 builtin/revert.c                              |   6 +-
 builtin/rm.c                                  |  20 +-
 builtin/send-pack.c                           |  18 +-
 builtin/shortlog.c                            |  12 +-
 builtin/show-branch.c                         |  16 +-
 builtin/show-index.c                          |   4 +-
 builtin/show-ref.c                            |  10 +-
 builtin/sparse-checkout.c                     |  20 +-
 builtin/stash.c                               |  42 +-
 builtin/stripspace.c                          |   6 +-
 builtin/submodule--helper.c                   |  36 +-
 builtin/symbolic-ref.c                        |   6 +-
 builtin/tag.c                                 |  24 +-
 builtin/unpack-file.c                         |  10 +-
 builtin/unpack-objects.c                      |  24 +-
 builtin/update-index.c                        |  34 +-
 builtin/update-ref.c                          |  10 +-
 builtin/update-server-info.c                  |   6 +-
 builtin/upload-archive.c                      |   6 +-
 builtin/upload-pack.c                         |  16 +-
 builtin/var.c                                 |   8 +-
 builtin/verify-commit.c                       |   8 +-
 builtin/verify-pack.c                         |   4 +-
 builtin/verify-tag.c                          |  10 +-
 builtin/worktree.c                            |  22 +-
 builtin/write-tree.c                          |   8 +-
 chdir-notify.c                                |   2 +-
 color.c                                       |   2 +-
 column.c                                      |   2 +-
 command-list.txt                              |   1 +
 common-init.c                                 |   8 +-
 compat/fsmonitor/fsm-health-darwin.c          |   6 +-
 compat/fsmonitor/fsm-health-linux.c           |   6 +-
 compat/fsmonitor/fsm-health-win32.c           |   6 +-
 compat/fsmonitor/fsm-ipc-unix.c               |  10 +-
 compat/fsmonitor/fsm-ipc-win32.c              |   4 +-
 compat/fsmonitor/fsm-listen-darwin.c          |   6 +-
 compat/fsmonitor/fsm-listen-linux.c           |   8 +-
 compat/fsmonitor/fsm-listen-win32.c           |   6 +-
 compat/fsmonitor/fsm-path-utils-darwin.c      |   4 +-
 compat/fsmonitor/fsm-path-utils-linux.c       |   4 +-
 compat/fsmonitor/fsm-path-utils-win32.c       |   4 +-
 compat/fsmonitor/fsm-settings-unix.c          |  10 +-
 compat/fsmonitor/fsm-settings-win32.c         |  10 +-
 compat/mingw.c                                |  12 +-
 compat/precompose_utf8.c                      |   4 +-
 compat/regex/regex.c                          |   2 +-
 compat/sha1-chunked.c                         |   2 +-
 compat/simple-ipc/ipc-win32.c                 |   2 +-
 compat/win32/path-utils.c                     |   4 +-
 compat/win32/trace2_win32_process_info.c      |   2 +-
 contrib/buildsystems/CMakeLists.txt           |   6 +-
 contrib/libgit-sys/public_symbol_export.c     |   4 +-
 contrib/organize/git-layout.map               |  41 +
 contrib/organize/labeler                      | 333 ++++++++
 contrib/organize/organizer                    | 334 ++++++++
 convert.c                                     |   8 +-
 convert.h                                     |   2 +-
 credential.c                                  |   6 +-
 csum-file.c                                   |   2 +-
 csum-file.h                                   |   2 +-
 daemon.c                                      |  10 +-
 diagnose.c                                    |   8 +-
 combine-diff.c => diff/combine-diff.c         |  26 +-
 diff-lib.c => diff/diff-lib.c                 |  30 +-
 diff-merges.c => diff/diff-merges.c           |   4 +-
 diff-merges.h => diff/diff-merges.h           |   0
 diff-no-index.c => diff/diff-no-index.c       |  12 +-
 diff.c => diff/diff.c                         |  38 +-
 diff.h => diff/diff.h                         |   4 +-
 diffcore-break.c => diff/diffcore-break.c     |   8 +-
 diffcore-delta.c => diff/diffcore-delta.c     |   2 +-
 diffcore-order.c => diff/diffcore-order.c     |   4 +-
 diffcore-pickaxe.c => diff/diffcore-pickaxe.c |  10 +-
 diffcore-rename.c => diff/diffcore-rename.c   |  10 +-
 diffcore-rotate.c => diff/diffcore-rotate.c   |   4 +-
 diffcore.h => diff/diffcore.h                 |   2 +-
 patch-ids.c => diff/patch-ids.c               |   8 +-
 patch-ids.h => diff/patch-ids.h               |   2 +-
 range-diff.c => diff/range-diff.c             |  20 +-
 range-diff.h => diff/range-diff.h             |   2 +-
 tree-diff.c => diff/tree-diff.c               |  14 +-
 userdiff.c => diff/userdiff.c                 |   6 +-
 userdiff.h => diff/userdiff.h                 |   0
 xdiff-interface.c => diff/xdiff-interface.c   |   8 +-
 xdiff-interface.h => diff/xdiff-interface.h   |   2 +-
 editor.c                                      |   4 +-
 exec-cmd.c                                    |   2 +-
 fmt-merge-msg.c                               |  20 +-
 gettext.c                                     |   2 +-
 git.c                                         |  17 +-
 gpg-interface.c                               |  10 +-
 grep.c                                        |  14 +-
 grep.h                                        |   2 +-
 help.c                                        |  16 +-
 hex.c                                         |   2 +-
 hex.h                                         |   2 +-
 http-backend.c                                |  22 +-
 http-fetch.c                                  |  10 +-
 http-push.c                                   |  34 +-
 imap-send.c                                   |   8 +-
 cache-tree.c => index/cache-tree.c            |  18 +-
 cache-tree.h => index/cache-tree.h            |   4 +-
 checkout.c => index/checkout.c                |  12 +-
 checkout.h => index/checkout.h                |   2 +-
 dir-iterator.c => index/dir-iterator.c        |   4 +-
 dir-iterator.h => index/dir-iterator.h        |   0
 dir.c => index/dir.c                          |  28 +-
 dir.h => index/dir.h                          |   6 +-
 entry.c => index/entry.c                      |  18 +-
 entry.h => index/entry.h                      |   0
 .../fsmonitor--daemon.h                       |   2 +-
 fsmonitor-ipc.c => index/fsmonitor-ipc.c      |   4 +-
 fsmonitor-ipc.h => index/fsmonitor-ipc.h      |   0
 fsmonitor-ll.h => index/fsmonitor-ll.h        |   0
 .../fsmonitor-path-utils.h                    |   0
 .../fsmonitor-settings.c                      |  10 +-
 .../fsmonitor-settings.h                      |   0
 fsmonitor.c => index/fsmonitor.c              |  14 +-
 fsmonitor.h => index/fsmonitor.h              |  10 +-
 name-hash.c => index/name-hash.c              |  10 +-
 name-hash.h => index/name-hash.h              |   0
 .../parallel-checkout.c                       |  14 +-
 .../parallel-checkout.h                       |   0
 pathspec.c => index/pathspec.c                |  14 +-
 pathspec.h => index/pathspec.h                |   0
 preload-index.c => index/preload-index.c      |  18 +-
 preload-index.h => index/preload-index.h      |   0
 read-cache-ll.h => index/read-cache-ll.h      |   4 +-
 read-cache.c => index/read-cache.c            |  50 +-
 read-cache.h => index/read-cache.h            |   8 +-
 resolve-undo.c => index/resolve-undo.c        |  10 +-
 resolve-undo.h => index/resolve-undo.h        |   2 +-
 sparse-index.c => index/sparse-index.c        |  22 +-
 sparse-index.h => index/sparse-index.h        |   0
 split-index.c => index/split-index.c          |   8 +-
 split-index.h => index/split-index.h          |   2 +-
 statinfo.c => index/statinfo.c                |   6 +-
 statinfo.h => index/statinfo.h                |   0
 symlinks.c => index/symlinks.c                |   4 +-
 symlinks.h => index/symlinks.h                |   0
 unpack-trees.c => index/unpack-trees.c        |  38 +-
 unpack-trees.h => index/unpack-trees.h        |   4 +-
 wt-status.c => index/wt-status.c              |  36 +-
 wt-status.h => index/wt-status.h              |   4 +-
 khash.h                                       |   2 +-
 lockfile.c                                    |   2 +-
 mailinfo.c                                    |   4 +-
 mailmap.c                                     |  10 +-
 merge-blobs.c                                 |   4 +-
 merge-ll.c                                    |   4 +-
 merge-ort-wrappers.c                          |  12 +-
 merge-ort.c                                   |  46 +-
 merge-ort.h                                   |   2 +-
 merge.c                                       |  14 +-
 meson.build                                   | 285 +++----
 negotiator/default.c                          |  10 +-
 negotiator/noop.c                             |   2 +-
 negotiator/skipping.c                         |  10 +-
 notes-cache.c                                 |  12 +-
 notes-merge.c                                 |  22 +-
 notes-utils.c                                 |   8 +-
 notes.c                                       |  14 +-
 alloc.c => odb/alloc.c                        |  14 +-
 alloc.h => odb/alloc.h                        |   0
 blob.c => odb/blob.c                          |   4 +-
 blob.h => odb/blob.h                          |   2 +-
 cbtree.c => odb/cbtree.c                      |   2 +-
 cbtree.h => odb/cbtree.h                      |   0
 commit-slab-decl.h => odb/commit-slab-decl.h  |   0
 commit-slab-impl.h => odb/commit-slab-impl.h  |   0
 commit-slab.h => odb/commit-slab.h            |   4 +-
 commit.c => odb/commit.c                      |  42 +-
 commit.h => odb/commit.h                      |   2 +-
 fsck.c => odb/fsck.c                          |  30 +-
 fsck.h => odb/fsck.h                          |   4 +-
 hash-lookup.c => odb/hash-lookup.c            |   6 +-
 hash-lookup.h => odb/hash-lookup.h            |   0
 hash.c => odb/hash.c                          |   2 +-
 hash.h => odb/hash.h                          |   2 +-
 loose.c => odb/loose.c                        |  12 +-
 loose.h => odb/loose.h                        |   0
 match-trees.c => odb/match-trees.c            |  12 +-
 match-trees.h => odb/match-trees.h            |   0
 .../object-file-convert.c                     |  12 +-
 .../object-file-convert.h                     |   2 +-
 object-file.c => odb/object-file.c            |  24 +-
 object-file.h => odb/object-file.h            |   4 +-
 object-name.c => odb/object-name.c            |  40 +-
 object-name.h => odb/object-name.h            |   2 +-
 object.c => odb/object.c                      |  20 +-
 object.h => odb/object.h                      |   2 +-
 odb.c => odb/odb.c                            |  30 +-
 odb.h => odb/odb.h                            |   6 +-
 oid-array.c => odb/oid-array.c                |   4 +-
 oid-array.h => odb/oid-array.h                |   2 +-
 oidmap.c => odb/oidmap.c                      |   4 +-
 oidmap.h => odb/oidmap.h                      |   2 +-
 oidset.c => odb/oidset.c                      |   2 +-
 oidset.h => odb/oidset.h                      |   0
 oidtree.c => odb/oidtree.c                    |   4 +-
 oidtree.h => odb/oidtree.h                    |   4 +-
 replace-object.c => odb/replace-object.c      |  12 +-
 replace-object.h => odb/replace-object.h      |   6 +-
 odb/source-files.c                            |  18 +-
 odb/source-inmemory.c                         |   8 +-
 odb/source-loose.c                            |  12 +-
 odb/source-packed.c                           |  10 +-
 odb/source-packed.h                           |   2 +-
 odb/source.c                                  |   4 +-
 odb/source.h                                  |   4 +-
 odb/streaming.c                               |   8 +-
 odb/streaming.h                               |   4 +-
 tag.c => odb/tag.c                            |  20 +-
 tag.h => odb/tag.h                            |   2 +-
 tmp-objdir.c => odb/tmp-objdir.c              |  12 +-
 tmp-objdir.h => odb/tmp-objdir.h              |   0
 odb/transaction.h                             |   2 +-
 tree-walk.c => odb/tree-walk.c                |  16 +-
 tree-walk.h => odb/tree-walk.h                |   2 +-
 tree.c => odb/tree.c                          |  16 +-
 tree.h => odb/tree.h                          |   2 +-
 organize/gitorganize-format.c                 | 266 +++++++
 organize/gitorganize-format.h                 |  38 +
 organize/labeler-protocol.c                   |  52 ++
 organize/labeler-protocol.h                   |  15 +
 organize/organize.c                           | 487 ++++++++++++
 organize/organize.h                           | 102 +++
 organize/organizer-protocol.c                 | 254 ++++++
 organize/organizer-protocol.h                 |  18 +
 oss-fuzz/fuzz-commit-graph.c                  |   4 +-
 oss-fuzz/fuzz-config.c                        |   2 +-
 oss-fuzz/fuzz-pack-headers.c                  |   2 +-
 oss-fuzz/fuzz-pack-idx.c                      |   4 +-
 bloom.c => pack/bloom.c                       |  20 +-
 bloom.h => pack/bloom.h                       |   0
 chunk-format.c => pack/chunk-format.c         |   4 +-
 chunk-format.h => pack/chunk-format.h         |   2 +-
 commit-graph.c => pack/commit-graph.c         |  34 +-
 commit-graph.h => pack/commit-graph.h         |   4 +-
 delta-islands.c => pack/delta-islands.c       |  26 +-
 delta-islands.h => pack/delta-islands.h       |   0
 delta.h => pack/delta.h                       |   0
 diff-delta.c => pack/diff-delta.c             |   2 +-
 midx-write.c => pack/midx-write.c             |  22 +-
 midx.c => pack/midx.c                         |  16 +-
 midx.h => pack/midx.h                         |   0
 .../pack-bitmap-write.c                       |  38 +-
 pack-bitmap.c => pack/pack-bitmap.c           |  32 +-
 pack-bitmap.h => pack/pack-bitmap.h           |   6 +-
 pack-check.c => pack/pack-check.c             |  12 +-
 pack-mtimes.c => pack/pack-mtimes.c           |   6 +-
 pack-mtimes.h => pack/pack-mtimes.h           |   0
 pack-objects.c => pack/pack-objects.c         |  10 +-
 pack-objects.h => pack/pack-objects.h         |   6 +-
 pack-revindex.c => pack/pack-revindex.c       |  10 +-
 pack-revindex.h => pack/pack-revindex.h       |   0
 pack-write.c => pack/pack-write.c             |  18 +-
 pack.h => pack/pack.h                         |   2 +-
 packfile-list.c => pack/packfile-list.c       |   4 +-
 packfile-list.h => pack/packfile-list.h       |   0
 packfile.c => pack/packfile.c                 |  40 +-
 packfile.h => pack/packfile.h                 |  12 +-
 patch-delta.c => pack/patch-delta.c           |   2 +-
 prune-packed.c => pack/prune-packed.c         |   8 +-
 prune-packed.h => pack/prune-packed.h         |   0
 pseudo-merge.c => pack/pseudo-merge.c         |  14 +-
 pseudo-merge.h => pack/pseudo-merge.h         |   0
 reachable.c => pack/reachable.c               |  28 +-
 reachable.h => pack/reachable.h               |   0
 repack-cruft.c => pack/repack-cruft.c         |   6 +-
 repack-filtered.c => pack/repack-filtered.c   |   4 +-
 repack-geometry.c => pack/repack-geometry.c   |   8 +-
 repack-midx.c => pack/repack-midx.c           |  14 +-
 repack-promisor.c => pack/repack-promisor.c   |   8 +-
 repack.c => pack/repack.c                     |  12 +-
 repack.h => pack/repack.h                     |   2 +-
 server-info.c => pack/server-info.c           |  20 +-
 server-info.h => pack/server-info.h           |   0
 pager.c                                       |   8 +-
 parse-options-cb.c                            |  10 +-
 path-walk.c                                   |  28 +-
 path-walk.h                                   |   2 +-
 path.c                                        |  12 +-
 path.h                                        |   2 +-
 progress.c                                    |   2 +-
 prompt.c                                      |   4 +-
 rebase-interactive.c                          |  14 +-
 refs/files-backend.c                          |  24 +-
 refs/iterator.c                               |   2 +-
 ls-refs.c => refs/ls-refs.c                   |  14 +-
 ls-refs.h => refs/ls-refs.h                   |   0
 pack-refs.c => refs/pack-refs.c               |  10 +-
 pack-refs.h => refs/pack-refs.h               |   0
 refs/packed-backend.c                         |  14 +-
 refs/ref-cache.c                              |   6 +-
 refs/ref-cache.h                              |   2 +-
 ref-filter.c => refs/ref-filter.c             |  36 +-
 ref-filter.h => refs/ref-filter.h             |   6 +-
 reflog-walk.c => refs/reflog-walk.c           |  12 +-
 reflog-walk.h => refs/reflog-walk.h           |   0
 reflog.c => refs/reflog.c                     |  16 +-
 reflog.h => refs/reflog.h                     |   2 +-
 refs/refs-internal.h                          |   2 +-
 refs.c => refs/refs.c                         |  26 +-
 refs.h => refs/refs.h                         |   8 +-
 refspec.c => refs/refspec.c                   |   8 +-
 refspec.h => refs/refspec.h                   |   0
 refs/reftable-backend.c                       |  20 +-
 worktree.c => refs/worktree.c                 |  16 +-
 worktree.h => refs/worktree.h                 |   2 +-
 replay.c                                      |  10 +-
 replay.h                                      |   2 +-
 rerere.c                                      |  18 +-
 reset.c                                       |  14 +-
 reset.h                                       |   4 +-
 bisect.c => revision/bisect.c                 |  30 +-
 bisect.h => revision/bisect.h                 |   0
 blame.c => revision/blame.c                   |  30 +-
 blame.h => revision/blame.h                   |   4 +-
 commit-reach.c => revision/commit-reach.c     |  14 +-
 commit-reach.h => revision/commit-reach.h     |   4 +-
 decorate.c => revision/decorate.c             |   4 +-
 decorate.h => revision/decorate.h             |   0
 graph.c => revision/graph.c                   |   8 +-
 graph.h => revision/graph.h                   |   2 +-
 line-log.c => revision/line-log.c             |  28 +-
 line-log.h => revision/line-log.h             |   2 +-
 line-range.c => revision/line-range.c         |   6 +-
 line-range.h => revision/line-range.h         |   0
 .../list-objects-filter-options.c             |   6 +-
 .../list-objects-filter-options.h             |   2 +-
 .../list-objects-filter.c                     |  20 +-
 .../list-objects-filter.h                     |   0
 list-objects.c => revision/list-objects.c     |  26 +-
 list-objects.h => revision/list-objects.h     |   0
 list.h => revision/list.h                     |   0
 log-tree.c => revision/log-tree.c             |  42 +-
 log-tree.h => revision/log-tree.h             |   0
 pretty.c => revision/pretty.c                 |  18 +-
 pretty.h => revision/pretty.h                 |   0
 revision.c => revision/revision.c             |  68 +-
 revision.h => revision/revision.h             |  18 +-
 shallow.c => revision/shallow.c               |  28 +-
 shallow.h => revision/shallow.h               |   6 +-
 run-command.c                                 |   8 +-
 scalar.c                                      |  14 +-
 sequencer.c                                   |  44 +-
 sequencer.h                                   |   2 +-
 alias.c => setup/alias.c                      |   4 +-
 alias.h => setup/alias.h                      |   0
 config.c => setup/config.c                    |  16 +-
 config.h => setup/config.h                    |   2 +-
 environment.c => setup/environment.c          |  16 +-
 environment.h => setup/environment.h          |   2 +-
 hook.c => setup/hook.c                        |   8 +-
 hook.h => setup/hook.h                        |   2 +-
 ident.c => setup/ident.c                      |   4 +-
 ident.h => setup/ident.h                      |   0
 repo-settings.c => setup/repo-settings.c      |  12 +-
 repo-settings.h => setup/repo-settings.h      |   0
 repository.c => setup/repository.c            |  24 +-
 repository.h => setup/repository.h            |   4 +-
 setup.c => setup/setup.c                      |  20 +-
 setup.h => setup/setup.h                      |   2 +-
 version.c => setup/version.c                  |   2 +-
 version.h => setup/version.h                  |   0
 shell.c                                       |   2 +-
 simple-ipc.h                                  |   2 +-
 sub-process.c                                 |   2 +-
 submodule-config.c                            |  14 +-
 submodule-config.h                            |   4 +-
 submodule.c                                   |  36 +-
 t/helper/test-advise.c                        |   6 +-
 t/helper/test-bitmap.c                        |   8 +-
 t/helper/test-bloom.c                         |   8 +-
 t/helper/test-bundle-uri.c                    |   6 +-
 t/helper/test-cache-tree.c                    |  10 +-
 t/helper/test-config.c                        |   4 +-
 t/helper/test-delta.c                         |   2 +-
 t/helper/test-dir-iterator.c                  |   2 +-
 t/helper/test-dump-cache-tree.c               |  12 +-
 t/helper/test-dump-fsmonitor.c                |   6 +-
 t/helper/test-dump-split-index.c              |   8 +-
 t/helper/test-dump-untracked-cache.c          |   8 +-
 t/helper/test-find-pack.c                     |   8 +-
 t/helper/test-fsmonitor-client.c              |   8 +-
 t/helper/test-hash-speed.c                    |   2 +-
 t/helper/test-lazy-init-name-hash.c           |  10 +-
 t/helper/test-match-trees.c                   |  10 +-
 t/helper/test-name-hash.c                     |   2 +-
 t/helper/test-pack-deltas.c                   |  10 +-
 t/helper/test-pack-mtimes.c                   |   8 +-
 t/helper/test-parse-pathspec-file.c           |   2 +-
 t/helper/test-partial-clone.c                 |   6 +-
 t/helper/test-path-utils.c                    |   6 +-
 t/helper/test-path-walk.c                     |  18 +-
 t/helper/test-pkt-line.c                      |   4 +-
 t/helper/test-proc-receive.c                  |   4 +-
 t/helper/test-progress.c                      |   2 +-
 t/helper/test-reach.c                         |  12 +-
 t/helper/test-read-cache.c                    |  10 +-
 t/helper/test-read-graph.c                    |  10 +-
 t/helper/test-read-midx.c                     |  14 +-
 t/helper/test-ref-store.c                     |  12 +-
 t/helper/test-reftable.c                      |   2 +-
 t/helper/test-repository.c                    |  14 +-
 t/helper/test-revision-walking.c              |  14 +-
 t/helper/test-rot13-filter.c                  |   2 +-
 t/helper/test-scrap-cache-tree.c              |  10 +-
 t/helper/test-serve-v2.c                      |   6 +-
 t/helper/test-sha1.c                          |   2 +-
 t/helper/test-sha256.c                        |   2 +-
 t/helper/test-submodule-config.c              |  10 +-
 t/helper/test-submodule-nested-repo-config.c  |   4 +-
 t/helper/test-submodule.c                     |   6 +-
 t/helper/test-subprocess.c                    |   2 +-
 t/helper/test-synthesize.c                    |  12 +-
 t/helper/test-trace2.c                        |   4 +-
 t/helper/test-userdiff.c                      |   6 +-
 t/helper/test-write-cache.c                   |   6 +-
 t/meson.build                                 |   1 +
 t/t0096-organize.sh                           | 739 ++++++++++++++++++
 t/unit-tests/lib-oid.h                        |   2 +-
 t/unit-tests/test-lib.c                       |   2 +-
 t/unit-tests/u-dir.c                          |   2 +-
 t/unit-tests/u-example-decorate.c             |   6 +-
 t/unit-tests/u-list-objects-filter-options.c  |   2 +-
 t/unit-tests/u-odb-inmemory.c                 |   6 +-
 t/unit-tests/u-oid-array.c                    |   2 +-
 t/unit-tests/u-oidmap.c                       |   4 +-
 t/unit-tests/u-oidtree.c                      |   4 +-
 t/unit-tests/u-reftable-stack.c               |   2 +-
 t/unit-tests/u-strcmp-offset.c                |   2 +-
 tempfile.h                                    |   2 +-
 trace.c                                       |   4 +-
 trace2.c                                      |   4 +-
 trace2/tr2_cfg.c                              |   2 +-
 trace2/tr2_sysenv.c                           |   4 +-
 trace2/tr2_tgt_event.c                        |   6 +-
 trace2/tr2_tgt_normal.c                       |   6 +-
 trace2/tr2_tgt_perf.c                         |   6 +-
 trailer.c                                     |   8 +-
 trailer.h                                     |   2 +-
 bundle-uri.c => transport/bundle-uri.c        |  16 +-
 bundle-uri.h => transport/bundle-uri.h        |   0
 bundle.c => transport/bundle.c                |  24 +-
 bundle.h => transport/bundle.h                |   2 +-
 connect.c => transport/connect.c              |  26 +-
 connect.h => transport/connect.h              |   2 +-
 connected.c => transport/connected.c          |  10 +-
 connected.h => transport/connected.h          |   0
 .../fetch-negotiator.c                        |   4 +-
 .../fetch-negotiator.h                        |   0
 .../fetch-object-info.c                       |  10 +-
 .../fetch-object-info.h                       |   4 +-
 fetch-pack.c => transport/fetch-pack.c        |  50 +-
 fetch-pack.h => transport/fetch-pack.h        |   6 +-
 .../git-curl-compat.h                         |   0
 http-walker.c => transport/http-walker.c      |  16 +-
 http.c => transport/http.c                    |  22 +-
 http.h => transport/http.h                    |   2 +-
 pkt-line.c => transport/pkt-line.c            |   4 +-
 pkt-line.h => transport/pkt-line.h            |   0
 .../promisor-remote.c                         |  14 +-
 .../promisor-remote.h                         |   2 +-
 protocol-caps.c => transport/protocol-caps.c  |  12 +-
 protocol-caps.h => transport/protocol-caps.h  |   0
 protocol.c => transport/protocol.c            |   6 +-
 protocol.h => transport/protocol.h            |   0
 remote-curl.c => transport/remote-curl.c      |  26 +-
 remote.c => transport/remote.c                |  30 +-
 remote.h => transport/remote.h                |   4 +-
 send-pack.c => transport/send-pack.c          |  24 +-
 send-pack.h => transport/send-pack.h          |   0
 serve.c => transport/serve.c                  |  22 +-
 serve.h => transport/serve.h                  |   0
 sideband.c => transport/sideband.c            |   6 +-
 sideband.h => transport/sideband.h            |   0
 .../transport-helper.c                        |  22 +-
 .../transport-internal.h                      |   2 +-
 transport.c => transport/transport.c          |  38 +-
 transport.h => transport/transport.h          |   6 +-
 upload-pack.c => transport/upload-pack.c      |  42 +-
 upload-pack.h => transport/upload-pack.h      |   0
 walker.c => transport/walker.c                |  18 +-
 walker.h => transport/walker.h                |   2 +-
 urlmatch.h                                    |   2 +-
 versioncmp.c                                  |   2 +-
 609 files changed, 6909 insertions(+), 3368 deletions(-)
 create mode 100644 .gitorganize
 create mode 100644 Documentation/git-organize.adoc
 create mode 100644 builtin/organize.c
 create mode 100644 contrib/organize/git-layout.map
 create mode 100755 contrib/organize/labeler
 create mode 100755 contrib/organize/organizer
 rename combine-diff.c => diff/combine-diff.c (99%)
 rename diff-lib.c => diff/diff-lib.c (98%)
 rename diff-merges.c => diff/diff-merges.c (98%)
 rename diff-merges.h => diff/diff-merges.h (100%)
 rename diff-no-index.c => diff/diff-no-index.c (98%)
 rename diff.c => diff/diff.c (99%)
 rename diff.h => diff/diff.h (99%)
 rename diffcore-break.c => diff/diffcore-break.c (98%)
 rename diffcore-delta.c => diff/diffcore-delta.c (99%)
 rename diffcore-order.c => diff/diffcore-order.c (97%)
 rename diffcore-pickaxe.c => diff/diffcore-pickaxe.c (98%)
 rename diffcore-rename.c => diff/diffcore-rename.c (99%)
 rename diffcore-rotate.c => diff/diffcore-rotate.c (95%)
 rename diffcore.h => diff/diffcore.h (99%)
 rename patch-ids.c => diff/patch-ids.c (97%)
 rename patch-ids.h => diff/patch-ids.h (98%)
 rename range-diff.c => diff/range-diff.c (98%)
 rename range-diff.h => diff/range-diff.h (98%)
 rename tree-diff.c => diff/tree-diff.c (99%)
 rename userdiff.c => diff/userdiff.c (99%)
 rename userdiff.h => diff/userdiff.h (100%)
 rename xdiff-interface.c => diff/xdiff-interface.c (98%)
 rename xdiff-interface.h => diff/xdiff-interface.h (99%)
 rename cache-tree.c => index/cache-tree.c (99%)
 rename cache-tree.h => index/cache-tree.h (97%)
 rename checkout.c => index/checkout.c (91%)
 rename checkout.h => index/checkout.h (94%)
 rename dir-iterator.c => index/dir-iterator.c (99%)
 rename dir-iterator.h => index/dir-iterator.h (100%)
 rename dir.c => index/dir.c (99%)
 rename dir.h => index/dir.h (99%)
 rename entry.c => index/entry.c (98%)
 rename entry.h => index/entry.h (100%)
 rename fsmonitor--daemon.h => index/fsmonitor--daemon.h (99%)
 rename fsmonitor-ipc.c => index/fsmonitor-ipc.c (98%)
 rename fsmonitor-ipc.h => index/fsmonitor-ipc.h (100%)
 rename fsmonitor-ll.h => index/fsmonitor-ll.h (100%)
 rename fsmonitor-path-utils.h => index/fsmonitor-path-utils.h (100%)
 rename fsmonitor-settings.c => index/fsmonitor-settings.c (97%)
 rename fsmonitor-settings.h => index/fsmonitor-settings.h (100%)
 rename fsmonitor.c => index/fsmonitor.c (99%)
 rename fsmonitor.h => index/fsmonitor.h (94%)
 rename name-hash.c => index/name-hash.c (99%)
 rename name-hash.h => index/name-hash.h (100%)
 rename parallel-checkout.c => index/parallel-checkout.c (98%)
 rename parallel-checkout.h => index/parallel-checkout.h (100%)
 rename pathspec.c => index/pathspec.c (99%)
 rename pathspec.h => index/pathspec.h (100%)
 rename preload-index.c => index/preload-index.c (94%)
 rename preload-index.h => index/preload-index.h (100%)
 rename read-cache-ll.h => index/read-cache-ll.h (99%)
 rename read-cache.c => index/read-cache.c (99%)
 rename read-cache.h => index/read-cache.h (91%)
 rename resolve-undo.c => index/resolve-undo.c (96%)
 rename resolve-undo.h => index/resolve-undo.h (97%)
 rename sparse-index.c => index/sparse-index.c (98%)
 rename sparse-index.h => index/sparse-index.h (100%)
 rename split-index.c => index/split-index.c (99%)
 rename split-index.h => index/split-index.h (98%)
 rename statinfo.c => index/statinfo.c (97%)
 rename statinfo.h => index/statinfo.h (100%)
 rename symlinks.c => index/symlinks.c (99%)
 rename symlinks.h => index/symlinks.h (100%)
 rename unpack-trees.c => index/unpack-trees.c (99%)
 rename unpack-trees.h => index/unpack-trees.h (98%)
 rename wt-status.c => index/wt-status.c (99%)
 rename wt-status.h => index/wt-status.h (98%)
 rename alloc.c => odb/alloc.c (94%)
 rename alloc.h => odb/alloc.h (100%)
 rename blob.c => odb/blob.c (89%)
 rename blob.h => odb/blob.h (96%)
 rename cbtree.c => odb/cbtree.c (99%)
 rename cbtree.h => odb/cbtree.h (100%)
 rename commit-slab-decl.h => odb/commit-slab-decl.h (100%)
 rename commit-slab-impl.h => odb/commit-slab-impl.h (100%)
 rename commit-slab.h => odb/commit-slab.h (97%)
 rename commit.c => odb/commit.c (98%)
 rename commit.h => odb/commit.h (99%)
 rename fsck.c => odb/fsck.c (99%)
 rename fsck.h => odb/fsck.h (99%)
 rename hash-lookup.c => odb/hash-lookup.c (97%)
 rename hash-lookup.h => odb/hash-lookup.h (100%)
 rename hash.c => odb/hash.c (99%)
 rename hash.h => odb/hash.h (99%)
 rename loose.c => odb/loose.c (97%)
 rename loose.h => odb/loose.h (100%)
 rename match-trees.c => odb/match-trees.c (98%)
 rename match-trees.h => odb/match-trees.h (100%)
 rename object-file-convert.c => odb/object-file-convert.c (98%)
 rename object-file-convert.h => odb/object-file-convert.h (96%)
 rename object-file.c => odb/object-file.c (99%)
 rename object-file.h => odb/object-file.h (99%)
 rename object-name.c => odb/object-name.c (98%)
 rename object-name.h => odb/object-name.h (99%)
 rename object.c => odb/object.c (98%)
 rename object.h => odb/object.h (99%)
 rename odb.c => odb/odb.c (98%)
 rename odb.h => odb/odb.h (99%)
 rename oid-array.c => odb/oid-array.c (97%)
 rename oid-array.h => odb/oid-array.h (99%)
 rename oidmap.c => odb/oidmap.c (97%)
 rename oidmap.h => odb/oidmap.h (99%)
 rename oidset.c => odb/oidset.c (99%)
 rename oidset.h => odb/oidset.h (100%)
 rename oidtree.c => odb/oidtree.c (98%)
 rename oidtree.h => odb/oidtree.h (97%)
 rename replace-object.c => odb/replace-object.c (94%)
 rename replace-object.h => odb/replace-object.h (96%)
 rename tag.c => odb/tag.c (95%)
 rename tag.h => odb/tag.h (96%)
 rename tmp-objdir.c => odb/tmp-objdir.c (97%)
 rename tmp-objdir.h => odb/tmp-objdir.h (100%)
 rename tree-walk.c => odb/tree-walk.c (99%)
 rename tree-walk.h => odb/tree-walk.h (99%)
 rename tree.c => odb/tree.c (96%)
 rename tree.h => odb/tree.h (98%)
 create mode 100644 organize/gitorganize-format.c
 create mode 100644 organize/gitorganize-format.h
 create mode 100644 organize/labeler-protocol.c
 create mode 100644 organize/labeler-protocol.h
 create mode 100644 organize/organize.c
 create mode 100644 organize/organize.h
 create mode 100644 organize/organizer-protocol.c
 create mode 100644 organize/organizer-protocol.h
 rename bloom.c => pack/bloom.c (98%)
 rename bloom.h => pack/bloom.h (100%)
 rename chunk-format.c => pack/chunk-format.c (98%)
 rename chunk-format.h => pack/chunk-format.h (98%)
 rename commit-graph.c => pack/commit-graph.c (99%)
 rename commit-graph.h => pack/commit-graph.h (99%)
 rename delta-islands.c => pack/delta-islands.c (97%)
 rename delta-islands.h => pack/delta-islands.h (100%)
 rename delta.h => pack/delta.h (100%)
 rename diff-delta.c => pack/diff-delta.c (99%)
 rename midx-write.c => pack/midx-write.c (99%)
 rename midx.c => pack/midx.c (99%)
 rename midx.h => pack/midx.h (100%)
 rename pack-bitmap-write.c => pack/pack-bitmap-write.c (98%)
 rename pack-bitmap.c => pack/pack-bitmap.c (99%)
 rename pack-bitmap.h => pack/pack-bitmap.h (98%)
 rename pack-check.c => pack/pack-check.c (97%)
 rename pack-mtimes.c => pack/pack-mtimes.c (97%)
 rename pack-mtimes.h => pack/pack-mtimes.h (100%)
 rename pack-objects.c => pack/pack-objects.c (97%)
 rename pack-objects.h => pack/pack-objects.h (99%)
 rename pack-revindex.c => pack/pack-revindex.c (99%)
 rename pack-revindex.h => pack/pack-revindex.h (100%)
 rename pack-write.c => pack/pack-write.c (98%)
 rename pack.h => pack/pack.h (99%)
 rename packfile-list.c => pack/packfile-list.c (96%)
 rename packfile-list.h => pack/packfile-list.h (100%)
 rename packfile.c => pack/packfile.c (99%)
 rename packfile.h => pack/packfile.h (98%)
 rename patch-delta.c => pack/patch-delta.c (98%)
 rename prune-packed.c => pack/prune-packed.c (89%)
 rename prune-packed.h => pack/prune-packed.h (100%)
 rename pseudo-merge.c => pack/pseudo-merge.c (99%)
 rename pseudo-merge.h => pack/pseudo-merge.h (100%)
 rename reachable.c => pack/reachable.c (95%)
 rename reachable.h => pack/reachable.h (100%)
 rename repack-cruft.c => pack/repack-cruft.c (97%)
 rename repack-filtered.c => pack/repack-filtered.c (96%)
 rename repack-geometry.c => pack/repack-geometry.c (98%)
 rename repack-midx.c => pack/repack-midx.c (99%)
 rename repack-promisor.c => pack/repack-promisor.c (97%)
 rename repack.c => pack/repack.c (98%)
 rename repack.h => pack/repack.h (99%)
 rename server-info.c => pack/server-info.c (96%)
 rename server-info.h => pack/server-info.h (100%)
 rename ls-refs.c => refs/ls-refs.c (96%)
 rename ls-refs.h => refs/ls-refs.h (100%)
 rename pack-refs.c => refs/pack-refs.c (92%)
 rename pack-refs.h => refs/pack-refs.h (100%)
 rename ref-filter.c => refs/ref-filter.c (99%)
 rename ref-filter.h => refs/ref-filter.h (98%)
 rename reflog-walk.c => refs/reflog-walk.c (98%)
 rename reflog-walk.h => refs/reflog-walk.h (100%)
 rename reflog.c => refs/reflog.c (98%)
 rename reflog.h => refs/reflog.h (99%)
 rename refs.c => refs/refs.c (99%)
 rename refs.h => refs/refs.h (99%)
 rename refspec.c => refs/refspec.c (99%)
 rename refspec.h => refs/refspec.h (100%)
 rename worktree.c => refs/worktree.c (99%)
 rename worktree.h => refs/worktree.h (99%)
 rename bisect.c => revision/bisect.c (98%)
 rename bisect.h => revision/bisect.h (100%)
 rename blame.c => revision/blame.c (99%)
 rename blame.h => revision/blame.h (98%)
 rename commit-reach.c => revision/commit-reach.c (99%)
 rename commit-reach.h => revision/commit-reach.h (99%)
 rename decorate.c => revision/decorate.c (97%)
 rename decorate.h => revision/decorate.h (100%)
 rename graph.c => revision/graph.c (99%)
 rename graph.h => revision/graph.h (99%)
 rename line-log.c => revision/line-log.c (98%)
 rename line-log.h => revision/line-log.h (96%)
 rename line-range.c => revision/line-range.c (98%)
 rename line-range.h => revision/line-range.h (100%)
 rename list-objects-filter-options.c => revision/list-objects-filter-options.c (99%)
 rename list-objects-filter-options.h => revision/list-objects-filter-options.h (99%)
 rename list-objects-filter.c => revision/list-objects-filter.c (98%)
 rename list-objects-filter.h => revision/list-objects-filter.h (100%)
 rename list-objects.c => revision/list-objects.c (96%)
 rename list-objects.h => revision/list-objects.h (100%)
 rename list.h => revision/list.h (100%)
 rename log-tree.c => revision/log-tree.c (98%)
 rename log-tree.h => revision/log-tree.h (100%)
 rename pretty.c => revision/pretty.c (99%)
 rename pretty.h => revision/pretty.h (100%)
 rename revision.c => revision/revision.c (99%)
 rename revision.h => revision/revision.h (98%)
 rename shallow.c => revision/shallow.c (98%)
 rename shallow.h => revision/shallow.h (97%)
 rename alias.c => setup/alias.c (98%)
 rename alias.h => setup/alias.h (100%)
 rename config.c => setup/config.c (99%)
 rename config.h => setup/config.h (99%)
 rename environment.c => setup/environment.c (98%)
 rename environment.h => setup/environment.h (99%)
 rename hook.c => setup/hook.c (99%)
 rename hook.h => setup/hook.h (99%)
 rename ident.c => setup/ident.c (99%)
 rename ident.h => setup/ident.h (100%)
 rename repo-settings.c => setup/repo-settings.c (97%)
 rename repo-settings.h => setup/repo-settings.h (100%)
 rename repository.c => setup/repository.c (97%)
 rename repository.h => setup/repository.h (99%)
 rename setup.c => setup/setup.c (99%)
 rename setup.h => setup/setup.h (99%)
 rename version.c => setup/version.c (98%)
 rename version.h => setup/version.h (100%)
 create mode 100755 t/t0096-organize.sh
 rename bundle-uri.c => transport/bundle-uri.c (99%)
 rename bundle-uri.h => transport/bundle-uri.h (100%)
 rename bundle.c => transport/bundle.c (97%)
 rename bundle.h => transport/bundle.h (97%)
 rename connect.c => transport/connect.c (99%)
 rename connect.h => transport/connect.h (98%)
 rename connected.c => transport/connected.c (97%)
 rename connected.h => transport/connected.h (100%)
 rename fetch-negotiator.c => transport/fetch-negotiator.c (90%)
 rename fetch-negotiator.h => transport/fetch-negotiator.h (100%)
 rename fetch-object-info.c => transport/fetch-object-info.c (96%)
 rename fetch-object-info.h => transport/fetch-object-info.h (91%)
 rename fetch-pack.c => transport/fetch-pack.c (98%)
 rename fetch-pack.h => transport/fetch-pack.h (97%)
 rename git-curl-compat.h => transport/git-curl-compat.h (100%)
 rename http-walker.c => transport/http-walker.c (98%)
 rename http.c => transport/http.c (99%)
 rename http.h => transport/http.h (99%)
 rename pkt-line.c => transport/pkt-line.c (99%)
 rename pkt-line.h => transport/pkt-line.h (100%)
 rename promisor-remote.c => transport/promisor-remote.c (99%)
 rename promisor-remote.h => transport/promisor-remote.h (99%)
 rename protocol-caps.c => transport/protocol-caps.c (95%)
 rename protocol-caps.h => transport/protocol-caps.h (100%)
 rename protocol.c => transport/protocol.c (96%)
 rename protocol.h => transport/protocol.h (100%)
 rename remote-curl.c => transport/remote-curl.c (99%)
 rename remote.c => transport/remote.c (99%)
 rename remote.h => transport/remote.h (99%)
 rename send-pack.c => transport/send-pack.c (98%)
 rename send-pack.h => transport/send-pack.h (100%)
 rename serve.c => transport/serve.c (96%)
 rename serve.h => transport/serve.h (100%)
 rename sideband.c => transport/sideband.c (99%)
 rename sideband.h => transport/sideband.h (100%)
 rename transport-helper.c => transport/transport-helper.c (99%)
 rename transport-internal.h => transport/transport-internal.h (98%)
 rename transport.c => transport/transport.c (98%)
 rename transport.h => transport/transport.h (98%)
 rename upload-pack.c => transport/upload-pack.c (98%)
 rename upload-pack.h => transport/upload-pack.h (100%)
 rename walker.c => transport/walker.c (97%)
 rename walker.h => transport/walker.h (97%)


base-commit: 1a3e64c6c4a623626ff0687008732a8e007e2a1c
-- 
2.54.0

