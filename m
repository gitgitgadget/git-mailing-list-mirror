Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72836C0AC
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505599; cv=none; b=eAKPUkqXVKJm7UJiPUJGRbPCpWkRMPz3lZZicDR/5yVEUQ+6xVPRVjRxcap4lXFSM3eVVtH6HPSuwqcRvp6SMq6wpxqXNYAsoR3iacrfKq/dkoR932sGT1ZbIrdY4oArKmSIFpiDi0MfmTU4oYJM1DdRMFQvQxRQFIJMWoHwCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505599; c=relaxed/simple;
	bh=uZZXRdzJ4rq5w/a6Rdf8R5d+G7JYMi59+kTR0JpRC30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7FSdxoV4mJ+9h9NuE3cP/8If4T19VkBEnROFA+PyBLzR/5DEUN+171euY4mdzmbOBb5dyrONts5j8i/ZSXU2Hd4jQZdzXThhEchHp7bTPB2CI9mwa1oKD98pooZSQW72tj02TJnApsY4KSNB7yp6ioPXk7XXudKL/7TTM+UJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePeBubGl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePeBubGl"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3900e39d935so2639169a91.0
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505581; x=1788110381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7meNWlp12OY4CAleM8DfKqF9f2S0HDjwVIyK3nTaH0w=;
        b=ePeBubGlwILMQgokFHptrk3BwjOyuoRFZf5Cop0QniEUXG0UHgq0aKHGi3+3tSwczx
         CF9e8iToWMFDPMgEwxaAQu3Pc2CmIA32Hkt6QGfDk34QbqzWoqLpjbjI/TZf8s5GJAt2
         7t1uzK9gBqj8eYyZyTROBuQwzo80gToTFj3DYsqCy/n2FHWfGKxpiFCvP4FOJn8SHAa8
         zvzHJHa0KjRYj55g5lhuk7Ic3jRoaef1GZi/qACv7l4CxoaVNRL7yd31sd/l4vVmb4B9
         hbbJV3vhh0DGxeJ6qsLWPrZ+UeY1uUYwgByMPOxc2FhOVnV4KxUSWvqE+5UVWWW4wCa8
         l5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505581; x=1788110381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7meNWlp12OY4CAleM8DfKqF9f2S0HDjwVIyK3nTaH0w=;
        b=eoNdXpFuErvDwNJJJ+0Kvob2FiSVobsxiAmBysBTQ2pZVpyW3R1R5tLhpCBHLh1Qlv
         8hWIjPiD1b32tkXm3WNK1DigTVLwQLqAH9IVsqIXNHJz//B2oy4NPcWwjsldl24ey8Ke
         H0jBsuZa4M11YCqL28veZNzIy8V/QD+qJLPH/wbveUlg36SZPc4TQxpW6GFzsFjZz3Q9
         WOH6fN1MxFT2dyrQc9D4eQnwcM2rHcqG2o3T3um3TSbZVkc8PUjBxo+fYka8kK9HaXp+
         GJ7WjDtJ9d0sT8C22CqB4Bx69G/PAQ/2jxdT/vsI+IPVIS/mPr1yJc46DVS/0ZR4AxQX
         VyDw==
X-Gm-Message-State: AFuF++nN3UIjvCunPEWqzhmxSLWuGB/88qdPjljHjgRMJ9mxNUtSrMKW
	g641Nq1iqvXmivhBYu2tphxsf9sNGZ+qUnjNVdbHM2wc3dwDp83jQsj3dTTZKw==
X-Gm-Gg: AR+sD128PKIxU36vRxk2vFGq/NucjFdbfgA1ZZsj1imET1yCaRp7TZFlkG0Wmpvo/ev
	alOrDzhgsnbUlncmaNC8Irna3cZeQhMdsUT1pryl3Huss1LAZG75Mk4cIYCUnqQ8RjJHEbIFvC9
	DxHJNKF6C29zGwhmOn8QQWdO4Fri7uHBvsimseFGJEhcdOYieLCU/t6434FAUIxV8eDNojIQtnc
	bsG8mwkmJurMHNYkSRNXRzfjnfUt5X94hzSrfy+SjZAwa3xZSNryHA5BZPspWeiE23i+WoKMWzF
	QQghGYPr5QLOjSIMmVK6/9QD3DjQ1Oyyt8oD/qFfXWVHdbnLgLPUdO/wa2ZpNhRyPy/fI92CulE
	xBfrNSJC20fYpuQaTiTJ7IDxoZe7omdEyyz0UWH7iKufLyaE0BoGrLib7Fw8nI8NpbM4fxZ15eK
	OJzHXEHG+XKg+w2mjXZ1KNwDhTRaz919bOoVfQZTnHUfJ48OVme7Vz8uNDZFrWLrEaEKZkRtIh2
	Svt9d+Zn05Uy+Ov3z0znYYDOxZtwKtVJ/iKobfS+D97ZZu0wuG6xBAlgiJNuRrHEdYlAo+L7EVM
	02eYWp+FM1K14mjUQi+cJR9TZ7ze5MXIAv5iI3Uw0g4flw==
X-Received: by 2002:a17:90b:4b89:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-395deeae6e3mr21358545a91.6.1787505579076;
        Sun, 23 Aug 2026 10:19:39 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d33dcsm22781189eec.18.2026.08.23.10.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:38 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 13/14] setup: gather the setup sources under setup/
Date: Sun, 23 Aug 2026 10:18:57 -0700
Message-ID: <20260823171915.2662373-14-mmontalbo@gmail.com>
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

Move the 9 setup C sources and 9 headers into setup/ as renames. Repoint
every reference to their old paths to the new ones: the #include lines
across the tree, the Makefile and meson.build build entries, and the
tutorial #include examples.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 .gitorganize                                 | 36 ++++++++++----------
 Documentation/MyFirstContribution.adoc       |  4 +--
 Documentation/MyFirstObjectWalk.adoc         |  2 +-
 Makefile                                     | 30 ++++++++--------
 add-interactive.c                            |  2 +-
 add-patch.c                                  |  6 ++--
 advice.c                                     |  4 +--
 apply.c                                      |  8 ++---
 archive-tar.c                                |  2 +-
 archive-zip.c                                |  2 +-
 archive.c                                    |  6 ++--
 attr.c                                       |  6 ++--
 branch.c                                     |  6 ++--
 builtin.h                                    |  2 +-
 builtin/add.c                                |  4 +--
 builtin/am.c                                 |  6 ++--
 builtin/backfill.c                           |  6 ++--
 builtin/bisect.c                             |  2 +-
 builtin/blame.c                              |  6 ++--
 builtin/branch.c                             |  4 +--
 builtin/bugreport.c                          |  6 ++--
 builtin/bundle.c                             |  2 +-
 builtin/cat-file.c                           |  8 ++---
 builtin/check-attr.c                         |  6 ++--
 builtin/check-ignore.c                       |  4 +--
 builtin/check-mailmap.c                      |  6 ++--
 builtin/check-ref-format.c                   |  2 +-
 builtin/checkout--worker.c                   |  4 +--
 builtin/checkout-index.c                     |  6 ++--
 builtin/checkout.c                           | 10 +++---
 builtin/clean.c                              |  6 ++--
 builtin/clone.c                              |  8 ++---
 builtin/column.c                             |  2 +-
 builtin/commit-graph.c                       |  4 +--
 builtin/commit-tree.c                        |  4 +--
 builtin/commit.c                             |  6 ++--
 builtin/config.c                             |  8 ++---
 builtin/count-objects.c                      |  4 +--
 builtin/credential-cache--daemon.c           |  2 +-
 builtin/credential-store.c                   |  2 +-
 builtin/credential.c                         |  4 +--
 builtin/describe.c                           |  6 ++--
 builtin/diff-files.c                         |  2 +-
 builtin/diff-index.c                         |  4 +--
 builtin/diff-pairs.c                         |  2 +-
 builtin/diff-tree.c                          |  2 +-
 builtin/diff.c                               |  4 +--
 builtin/difftool.c                           |  8 ++---
 builtin/fast-export.c                        |  4 +--
 builtin/fast-import.c                        |  4 +--
 builtin/fetch.c                              |  4 +--
 builtin/fmt-merge-msg.c                      |  2 +-
 builtin/for-each-ref.c                       |  4 +--
 builtin/for-each-repo.c                      |  4 +--
 builtin/fsck.c                               |  2 +-
 builtin/fsmonitor--daemon.c                  |  4 +--
 builtin/gc.c                                 |  8 ++---
 builtin/grep.c                               |  6 ++--
 builtin/hash-object.c                        |  6 ++--
 builtin/help.c                               |  8 ++---
 builtin/history.c                            |  4 +--
 builtin/hook.c                               |  6 ++--
 builtin/index-pack.c                         |  6 ++--
 builtin/init-db.c                            |  4 +--
 builtin/interpret-trailers.c                 |  4 +--
 builtin/last-modified.c                      |  6 ++--
 builtin/log.c                                |  6 ++--
 builtin/ls-files.c                           |  6 ++--
 builtin/ls-tree.c                            |  4 +--
 builtin/mailinfo.c                           |  2 +-
 builtin/merge-base.c                         |  4 +--
 builtin/merge-file.c                         |  4 +--
 builtin/merge-ours.c                         |  4 +--
 builtin/merge-tree.c                         |  4 +--
 builtin/merge.c                              | 10 +++---
 builtin/mktag.c                              |  2 +-
 builtin/multi-pack-index.c                   |  6 ++--
 builtin/mv.c                                 |  6 ++--
 builtin/name-rev.c                           |  4 +--
 builtin/notes.c                              |  4 +--
 builtin/organize.c                           |  2 +-
 builtin/pack-objects.c                       |  4 +--
 builtin/patch-id.c                           |  6 ++--
 builtin/prune.c                              |  2 +-
 builtin/pull.c                               |  4 +--
 builtin/push.c                               |  4 +--
 builtin/range-diff.c                         |  2 +-
 builtin/read-tree.c                          |  6 ++--
 builtin/rebase.c                             |  6 ++--
 builtin/receive-pack.c                       | 10 +++---
 builtin/reflog.c                             |  2 +-
 builtin/refs.c                               |  2 +-
 builtin/remote.c                             |  4 +--
 builtin/repack.c                             |  4 +--
 builtin/replace.c                            |  4 +--
 builtin/replay.c                             |  2 +-
 builtin/repo.c                               |  4 +--
 builtin/rerere.c                             |  2 +-
 builtin/reset.c                              |  8 ++---
 builtin/rev-list.c                           |  4 +--
 builtin/rev-parse.c                          | 10 +++---
 builtin/revert.c                             |  2 +-
 builtin/rm.c                                 |  6 ++--
 builtin/send-pack.c                          |  4 +--
 builtin/shortlog.c                           |  6 ++--
 builtin/show-branch.c                        |  4 +--
 builtin/show-ref.c                           |  4 +--
 builtin/sparse-checkout.c                    |  6 ++--
 builtin/stash.c                              |  8 ++---
 builtin/stripspace.c                         |  6 ++--
 builtin/submodule--helper.c                  |  6 ++--
 builtin/symbolic-ref.c                       |  4 +--
 builtin/tag.c                                |  4 +--
 builtin/unpack-file.c                        |  4 +--
 builtin/unpack-objects.c                     |  4 +--
 builtin/update-index.c                       |  6 ++--
 builtin/update-ref.c                         |  4 +--
 builtin/update-server-info.c                 |  4 +--
 builtin/upload-archive.c                     |  2 +-
 builtin/upload-pack.c                        |  4 +--
 builtin/var.c                                |  6 ++--
 builtin/verify-commit.c                      |  4 +--
 builtin/verify-pack.c                        |  4 +--
 builtin/verify-tag.c                         |  4 +--
 builtin/worktree.c                           |  6 ++--
 builtin/write-tree.c                         |  4 +--
 bundle-uri.c                                 |  2 +-
 bundle.c                                     |  4 +--
 color.c                                      |  2 +-
 column.c                                     |  2 +-
 common-init.c                                |  4 +--
 compat/fsmonitor/fsm-health-darwin.c         |  2 +-
 compat/fsmonitor/fsm-health-linux.c          |  2 +-
 compat/fsmonitor/fsm-health-win32.c          |  2 +-
 compat/fsmonitor/fsm-ipc-unix.c              |  4 +--
 compat/fsmonitor/fsm-ipc-win32.c             |  2 +-
 compat/fsmonitor/fsm-listen-win32.c          |  2 +-
 compat/fsmonitor/fsm-settings-unix.c         |  2 +-
 compat/fsmonitor/fsm-settings-win32.c        |  4 +--
 compat/mingw.c                               |  6 ++--
 compat/precompose_utf8.c                     |  4 +--
 compat/regex/regex.c                         |  2 +-
 compat/win32/path-utils.c                    |  4 +--
 compat/win32/trace2_win32_process_info.c     |  2 +-
 connect.c                                    |  8 ++---
 contrib/libgit-sys/public_symbol_export.c    |  4 +--
 convert.c                                    |  2 +-
 credential.c                                 |  6 ++--
 daemon.c                                     |  6 ++--
 diagnose.c                                   |  2 +-
 diff/combine-diff.c                          |  2 +-
 diff/diff-lib.c                              |  2 +-
 diff/diff.c                                  |  6 ++--
 diff/range-diff.c                            |  4 +--
 diff/tree-diff.c                             |  2 +-
 diff/userdiff.c                              |  4 +--
 diff/xdiff-interface.c                       |  4 +--
 editor.c                                     |  4 +--
 exec-cmd.c                                   |  2 +-
 fetch-negotiator.c                           |  2 +-
 fetch-pack.c                                 |  8 ++---
 fmt-merge-msg.c                              |  4 +--
 gettext.c                                    |  2 +-
 git.c                                        |  8 ++---
 gpg-interface.c                              |  6 ++--
 grep.c                                       |  2 +-
 help.c                                       |  8 ++---
 http-backend.c                               |  8 ++---
 http-fetch.c                                 |  6 ++--
 http-push.c                                  |  6 ++--
 http-walker.c                                |  2 +-
 http.c                                       |  6 ++--
 imap-send.c                                  |  6 ++--
 index/cache-tree.c                           |  2 +-
 index/checkout.c                             |  4 +--
 index/dir.c                                  |  8 ++---
 index/entry.c                                |  2 +-
 index/fsmonitor-ipc.c                        |  2 +-
 index/fsmonitor-settings.c                   |  4 +--
 index/fsmonitor.c                            |  6 ++--
 index/name-hash.c                            |  2 +-
 index/parallel-checkout.c                    |  2 +-
 index/pathspec.c                             |  6 ++--
 index/preload-index.c                        |  6 ++--
 index/read-cache.c                           |  8 ++---
 index/read-cache.h                           |  2 +-
 index/sparse-index.c                         |  6 ++--
 index/split-index.c                          |  2 +-
 index/statinfo.c                             |  4 +--
 index/symlinks.c                             |  2 +-
 index/unpack-trees.c                         |  6 ++--
 index/wt-status.c                            |  6 ++--
 lockfile.c                                   |  2 +-
 mailinfo.c                                   |  4 +--
 mailmap.c                                    |  6 ++--
 merge-ll.c                                   |  2 +-
 merge-ort-wrappers.c                         |  2 +-
 merge-ort.c                                  |  4 +--
 merge.c                                      |  2 +-
 meson.build                                  | 18 +++++-----
 negotiator/default.c                         |  2 +-
 negotiator/skipping.c                        |  2 +-
 notes-cache.c                                |  2 +-
 notes-merge.c                                |  2 +-
 notes-utils.c                                |  4 +--
 notes.c                                      |  4 +--
 odb/alloc.c                                  |  2 +-
 odb/commit.c                                 |  8 ++---
 odb/fsck.c                                   |  6 ++--
 odb/hash.h                                   |  2 +-
 odb/loose.c                                  |  2 +-
 odb/match-trees.c                            |  2 +-
 odb/object-file-convert.c                    |  2 +-
 odb/object-file.c                            |  4 +--
 odb/object-name.c                            | 10 +++---
 odb/odb.c                                    |  6 ++--
 odb/replace-object.c                         |  2 +-
 odb/replace-object.h                         |  2 +-
 odb/source-files.c                           |  2 +-
 odb/source-inmemory.c                        |  2 +-
 odb/source-loose.c                           |  2 +-
 odb/streaming.c                              |  4 +--
 odb/tag.c                                    |  4 +--
 odb/tmp-objdir.c                             |  4 +--
 odb/tree-walk.c                              |  2 +-
 odb/tree.c                                   |  4 +--
 organize/organize.c                          |  4 +--
 oss-fuzz/fuzz-commit-graph.c                 |  2 +-
 oss-fuzz/fuzz-config.c                       |  2 +-
 pack/bloom.c                                 |  4 +--
 pack/commit-graph.c                          |  4 +--
 pack/delta-islands.c                         |  2 +-
 pack/midx-write.c                            |  2 +-
 pack/midx.c                                  |  2 +-
 pack/pack-bitmap-write.c                     |  4 +--
 pack/pack-bitmap.c                           |  4 +--
 pack/pack-check.c                            |  4 +--
 pack/pack-objects.c                          |  2 +-
 pack/pack-revindex.c                         |  2 +-
 pack/pack-write.c                            |  4 +--
 pack/packfile.c                              |  4 +--
 pack/packfile.h                              |  2 +-
 pack/prune-packed.c                          |  2 +-
 pack/pseudo-merge.c                          |  2 +-
 pack/reachable.c                             |  2 +-
 pack/repack-cruft.c                          |  2 +-
 pack/repack-filtered.c                       |  2 +-
 pack/repack-geometry.c                       |  2 +-
 pack/repack-promisor.c                       |  2 +-
 pack/repack.c                                |  2 +-
 pack/server-info.c                           |  2 +-
 pager.c                                      |  8 ++---
 parse-options-cb.c                           |  4 +--
 path-walk.c                                  |  2 +-
 path.c                                       |  4 +--
 path.h                                       |  2 +-
 progress.c                                   |  2 +-
 promisor-remote.c                            |  6 ++--
 promisor-remote.h                            |  2 +-
 prompt.c                                     |  4 +--
 protocol-caps.c                              |  2 +-
 protocol.c                                   |  4 +--
 rebase-interactive.c                         |  6 ++--
 refs/files-backend.c                         | 10 +++---
 refs/ls-refs.c                               |  6 ++--
 refs/pack-refs.c                             |  4 +--
 refs/packed-backend.c                        |  2 +-
 refs/ref-cache.c                             |  2 +-
 refs/ref-filter.c                            | 10 +++---
 refs/reflog-walk.c                           |  2 +-
 refs/reflog.c                                |  4 +--
 refs/refs.c                                  | 12 +++----
 refs/refs.h                                  |  4 +--
 refs/reftable-backend.c                      | 10 +++---
 refs/worktree.c                              |  8 ++---
 remote-curl.c                                |  6 ++--
 remote.c                                     |  6 ++--
 replay.c                                     |  2 +-
 rerere.c                                     |  4 +--
 reset.c                                      |  2 +-
 reset.h                                      |  2 +-
 revision/bisect.c                            |  4 +--
 revision/blame.c                             |  2 +-
 revision/graph.c                             |  2 +-
 revision/line-log.c                          |  4 +--
 revision/list-objects-filter-options.c       |  2 +-
 revision/list-objects.c                      |  2 +-
 revision/log-tree.c                          |  6 ++--
 revision/pretty.c                            |  4 +--
 revision/revision.c                          |  8 ++---
 revision/revision.h                          |  2 +-
 revision/shallow.c                           |  2 +-
 revision/shallow.h                           |  2 +-
 run-command.c                                |  4 +--
 scalar.c                                     |  4 +--
 send-pack.c                                  |  4 +--
 sequencer.c                                  |  8 ++---
 serve.c                                      |  6 ++--
 alias.c => setup/alias.c                     |  4 +--
 alias.h => setup/alias.h                     |  0
 config.c => setup/config.c                   |  8 ++---
 config.h => setup/config.h                   |  2 +-
 environment.c => setup/environment.c         | 10 +++---
 environment.h => setup/environment.h         |  2 +-
 hook.c => setup/hook.c                       |  8 ++---
 hook.h => setup/hook.h                       |  2 +-
 ident.c => setup/ident.c                     |  4 +--
 ident.h => setup/ident.h                     |  0
 repo-settings.c => setup/repo-settings.c     |  8 ++---
 repo-settings.h => setup/repo-settings.h     |  0
 repository.c => setup/repository.c           |  8 ++---
 repository.h => setup/repository.h           |  4 +--
 setup.c => setup/setup.c                     |  8 ++---
 setup.h => setup/setup.h                     |  0
 version.c => setup/version.c                 |  2 +-
 version.h => setup/version.h                 |  0
 shell.c                                      |  2 +-
 sideband.c                                   |  2 +-
 submodule-config.c                           |  6 ++--
 submodule-config.h                           |  2 +-
 submodule.c                                  |  8 ++---
 t/helper/test-advise.c                       |  6 ++--
 t/helper/test-bitmap.c                       |  2 +-
 t/helper/test-bloom.c                        |  4 +--
 t/helper/test-cache-tree.c                   |  4 +--
 t/helper/test-config.c                       |  4 +--
 t/helper/test-dump-cache-tree.c              |  4 +--
 t/helper/test-dump-fsmonitor.c               |  4 +--
 t/helper/test-dump-split-index.c             |  4 +--
 t/helper/test-dump-untracked-cache.c         |  4 +--
 t/helper/test-find-pack.c                    |  2 +-
 t/helper/test-fsmonitor-client.c             |  4 +--
 t/helper/test-lazy-init-name-hash.c          |  6 ++--
 t/helper/test-match-trees.c                  |  4 +--
 t/helper/test-pack-deltas.c                  |  2 +-
 t/helper/test-pack-mtimes.c                  |  2 +-
 t/helper/test-partial-clone.c                |  4 +--
 t/helper/test-path-utils.c                   |  4 +--
 t/helper/test-path-walk.c                    |  4 +--
 t/helper/test-progress.c                     |  2 +-
 t/helper/test-reach.c                        |  2 +-
 t/helper/test-read-cache.c                   |  8 ++---
 t/helper/test-read-graph.c                   |  4 +--
 t/helper/test-read-midx.c                    |  4 +--
 t/helper/test-ref-store.c                    |  4 +--
 t/helper/test-repository.c                   |  6 ++--
 t/helper/test-revision-walking.c             |  4 +--
 t/helper/test-scrap-cache-tree.c             |  4 +--
 t/helper/test-serve-v2.c                     |  4 +--
 t/helper/test-submodule-config.c             |  6 ++--
 t/helper/test-submodule-nested-repo-config.c |  4 +--
 t/helper/test-submodule.c                    |  4 +--
 t/helper/test-subprocess.c                   |  2 +-
 t/helper/test-synthesize.c                   |  4 +--
 t/helper/test-trace2.c                       |  4 +--
 t/helper/test-userdiff.c                     |  4 +--
 t/helper/test-write-cache.c                  |  4 +--
 t/unit-tests/u-example-decorate.c            |  2 +-
 t/unit-tests/u-odb-inmemory.c                |  2 +-
 trace.c                                      |  4 +--
 trace2.c                                     |  4 +--
 trace2/tr2_cfg.c                             |  2 +-
 trace2/tr2_sysenv.c                          |  2 +-
 trace2/tr2_tgt_event.c                       |  6 ++--
 trace2/tr2_tgt_normal.c                      |  6 ++--
 trace2/tr2_tgt_perf.c                        |  6 ++--
 trailer.c                                    |  4 +--
 transport-helper.c                           |  4 +--
 transport.c                                  |  6 ++--
 upload-pack.c                                |  8 ++---
 urlmatch.h                                   |  2 +-
 versioncmp.c                                 |  2 +-
 walker.c                                     |  2 +-
 373 files changed, 798 insertions(+), 798 deletions(-)
 rename alias.c => setup/alias.c (98%)
 rename alias.h => setup/alias.h (100%)
 rename config.c => setup/config.c (99%)
 rename config.h => setup/config.h (99%)
 rename environment.c => setup/environment.c (99%)
 rename environment.h => setup/environment.h (99%)
 rename hook.c => setup/hook.c (99%)
 rename hook.h => setup/hook.h (99%)
 rename ident.c => setup/ident.c (99%)
 rename ident.h => setup/ident.h (100%)
 rename repo-settings.c => setup/repo-settings.c (98%)
 rename repo-settings.h => setup/repo-settings.h (100%)
 rename repository.c => setup/repository.c (99%)
 rename repository.h => setup/repository.h (99%)
 rename setup.c => setup/setup.c (99%)
 rename setup.h => setup/setup.h (100%)
 rename version.c => setup/version.c (98%)
 rename version.h => setup/version.h (100%)

diff --git a/.gitorganize b/.gitorganize
index fe81c40f09..cb6416bfc3 100644
--- a/.gitorganize
+++ b/.gitorganize
@@ -28,8 +28,6 @@ add-patch.c component=? role=lib prefix=add-patch includes=setup:3,index:2,odb:2
 add-patch.h component=? role=public prefix=add-patch cochange=odb:1
 advice.c component=? role=lib prefix=advice includes=setup:2 cochange=transport:18,index:12,odb:9,diff:8,revision:8
 advice.h component=? role=public prefix=advice cochange=transport:14,index:9,odb:6,submodule:4,pack:3
-alias.c component=setup role=lib prefix=alias includes=setup:2 cochange=setup:8,diff:4,transport:3,convert:2,index:2
-alias.h component=setup role=header prefix=completion cochange=setup:3,transport:2,pack:1,revision:1
 apply.c component=? role=lib prefix=apply includes=index:5,setup:4,odb:3,diff:2,merge:2 cochange=index:93,setup:43,diff:41,odb:26,merge:24
 apply.h component=? role=public prefix=apply includes=odb:1 cochange=diff:2
 archive-tar.c component=archive role=lib prefix=archive-tar includes=archive:1,odb:1,setup:1 cochange=archive:59,index:12,diff:9,odb:9,transport:8
@@ -58,8 +56,6 @@ common-exit.c component=? role=lib prefix=common-main
 common-init.c component=? role=lib prefix=common-main includes=odb:2,setup:2,convert:1 cochange=setup:1
 common-init.h component=? role=public prefix=common-main
 common-main.c component=? role=lib prefix=common-main cochange=setup:5,transport:4,convert:3,index:1
-config.c component=setup role=lib prefix=config includes=setup:4,odb:2,convert:1,index:1,refs:1 cochange=setup:274,index:93,diff:75,refs:48,revision:46
-config.h component=setup role=header prefix=config includes=setup:1 cochange=setup:100,index:30,transport:23,submodule:21,merge:6
 connect.c component=transport role=lib prefix=connect includes=transport:7,setup:4,odb:1,refs:1 cochange=transport:238,setup:19,diff:13,index:10,refs:10
 connect.h component=transport role=header prefix=connect includes=transport:1 cochange=transport:58,refs:1
 connected.c component=transport role=lib prefix=connected includes=transport:3,odb:1,pack:1 cochange=transport:39,pack:31,odb:7,diff:6,index:5
@@ -103,8 +99,6 @@ diff/xdiff-interface.c component=diff role=lib prefix=xdiff-interface includes=s
 diff/xdiff-interface.h component=diff role=header prefix=xdiff-interface includes=odb:1 cochange=diff:62,index:2,notes:2,merge:1,odb:1
 editor.c component=? role=lib prefix=editor includes=setup:2 cochange=transport:20,setup:12,index:8,odb:4,submodule:4
 editor.h component=? role=public prefix=editor cochange=transport:1
-environment.c component=setup role=lib prefix=environment includes=setup:5,convert:3,odb:2,merge:1,refs:1 cochange=setup:281,index:77,odb:48,refs:36,transport:28
-environment.h component=setup role=header prefix=environment includes=setup:1 cochange=setup:135,index:37,odb:15,refs:11,pack:9
 exec-cmd.c component=? role=lib prefix=strvec includes=setup:1
 exec-cmd.h component=? role=public prefix=argv-array cochange=refs:4,transport:4,odb:1,setup:1,submodule:1
 fetch-negotiator.c component=transport role=lib prefix=repo-settings includes=setup:1,transport:1 cochange=setup:8,transport:7,index:2,odb:1
@@ -135,16 +129,12 @@ hex-ll.c component=? role=lib prefix=hex-ll
 hex-ll.h component=? role=public prefix=hex-ll
 hex.c component=? role=lib prefix=hex includes=odb:1 cochange=odb:7,revision:5,notes:3,transport:3,refs:2
 hex.h component=? role=public prefix=hex includes=odb:1 cochange=revision:3,odb:2,convert:1,merge:1,pack:1
-hook.c component=setup role=lib prefix=hook includes=setup:4 cochange=setup:37,transport:10,odb:8,refs:5,diff:3
-hook.h component=setup role=header prefix=hook includes=setup:1 cochange=setup:34,transport:6,odb:5,refs:5,pack:3
 http-backend.c component=? role=program prefix=http-backend includes=setup:4,odb:3,transport:2,pack:1,refs:1 cochange=transport:57,pack:41,setup:19,refs:14,revision:13
 http-fetch.c component=? role=program prefix=http-fetch includes=setup:3,transport:2 cochange=transport:46,setup:10,pack:9,index:7,refs:7
 http-push.c component=? role=program prefix=http-push includes=odb:7,revision:3,setup:3,transport:2,diff:1 cochange=transport:272,odb:134,revision:82,pack:60,diff:34
 http-walker.c component=transport role=lib prefix=http includes=transport:3,odb:2,pack:1,revision:1,setup:1 cochange=transport:73,pack:40,odb:17,index:11,refs:7
 http.c component=transport role=lib prefix=http includes=transport:4,setup:3,odb:2,pack:2 cochange=transport:195,pack:71,odb:27,diff:8,setup:8
 http.h component=transport role=header prefix=http includes=transport:1 cochange=transport:149,pack:15,diff:6,odb:4,archive:3
-ident.c component=setup role=lib prefix=ident includes=setup:2 cochange=setup:19,revision:10,odb:6,refs:6,pack:4
-ident.h component=setup role=header prefix=ident cochange=setup:3,revision:1
 imap-send.c component=? role=program prefix=imap-send includes=setup:3,transport:1 cochange=transport:47,diff:16,index:16,refs:9,odb:8
 index/cache-tree.c component=index role=lib prefix=cache-tree includes=odb:5,index:2,setup:1,transport:1 cochange=index:94,odb:69,revision:27,transport:21,diff:20
 index/cache-tree.h component=index role=header prefix=cache-tree includes=odb:2 cochange=index:42,diff:4,revision:4,odb:3,refs:1
@@ -373,10 +363,6 @@ remote.c component=transport role=lib prefix=remote includes=odb:3,setup:3,trans
 remote.h component=transport role=header prefix=remote includes=odb:1,refs:1 cochange=transport:245,refs:24,index:12,revision:6,setup:2
 replay.c component=? role=lib prefix=replay includes=odb:2,merge:1,refs:1,revision:1,setup:1 cochange=transport:1
 replay.h component=? role=public prefix=replay includes=odb:1
-repo-settings.c component=setup role=lib prefix=repo-settings includes=setup:4,pack:2 cochange=setup:65,pack:17,index:8,transport:8,odb:6
-repo-settings.h component=setup role=header prefix=environment cochange=setup:40,pack:7,refs:6,odb:4,diff:2
-repository.c component=setup role=lib prefix=repository includes=setup:4,odb:3,index:2,transport:2,refs:1 cochange=setup:141,odb:39,index:27,refs:18,submodule:17
-repository.h component=setup role=header prefix=repository includes=setup:2 cochange=setup:157,index:31,refs:25,pack:22,odb:19
 rerere.c component=merge role=lib prefix=rerere includes=index:4,merge:2,odb:2,setup:2,diff:1 cochange=index:54,merge:29,pack:26,odb:25,transport:25
 rerere.h component=merge role=header prefix=rerere cochange=merge:16,odb:1
 reset.c component=? role=lib prefix=reset includes=odb:3,index:2,refs:1,setup:1 cochange=index:9,merge:5,odb:3,notes:2,revision:2
@@ -420,8 +406,24 @@ sequencer.c component=? role=lib prefix=sequencer includes=odb:8,index:5,merge:4
 sequencer.h component=? role=public prefix=sequencer includes=index:1 cochange=revision:5,index:4,notes:3,odb:3,transport:3
 serve.c component=transport role=lib prefix=serve includes=transport:6,setup:3,odb:1,refs:1 cochange=transport:53,refs:7,odb:4,setup:3,index:1
 serve.h component=transport role=header prefix=serve cochange=transport:9,refs:3,submodule:1
-setup.c component=setup role=lib prefix=setup includes=setup:4,odb:2,refs:2,index:1,revision:1 cochange=setup:177,refs:47,transport:44,index:39,odb:24
-setup.h component=setup role=header prefix=setup includes=refs:1 cochange=setup:70,refs:8,index:5,revision:4,submodule:4
+setup/alias.c component=setup role=lib prefix=alias includes=setup:2 cochange=setup:8,diff:4,transport:3,convert:2,index:2
+setup/alias.h component=setup role=header prefix=completion cochange=setup:3,transport:2,pack:1,revision:1
+setup/config.c component=setup role=lib prefix=config includes=setup:4,odb:2,convert:1,index:1,refs:1 cochange=setup:274,index:93,diff:75,refs:48,revision:46
+setup/config.h component=setup role=header prefix=config includes=setup:1 cochange=setup:100,index:30,transport:23,submodule:21,merge:6
+setup/environment.c component=setup role=lib prefix=environment includes=setup:5,convert:3,odb:2,merge:1,refs:1 cochange=setup:281,index:77,odb:48,refs:36,transport:28
+setup/environment.h component=setup role=header prefix=environment includes=setup:1 cochange=setup:135,index:37,odb:15,refs:11,pack:9
+setup/hook.c component=setup role=lib prefix=hook includes=setup:4 cochange=setup:37,transport:10,odb:8,refs:5,diff:3
+setup/hook.h component=setup role=header prefix=hook includes=setup:1 cochange=setup:34,transport:6,odb:5,refs:5,pack:3
+setup/ident.c component=setup role=lib prefix=ident includes=setup:2 cochange=setup:19,revision:10,odb:6,refs:6,pack:4
+setup/ident.h component=setup role=header prefix=ident cochange=setup:3,revision:1
+setup/repo-settings.c component=setup role=lib prefix=repo-settings includes=setup:4,pack:2 cochange=setup:65,pack:17,index:8,transport:8,odb:6
+setup/repo-settings.h component=setup role=header prefix=environment cochange=setup:40,pack:7,refs:6,odb:4,diff:2
+setup/repository.c component=setup role=lib prefix=repository includes=setup:4,odb:3,index:2,transport:2,refs:1 cochange=setup:141,odb:39,index:27,refs:18,submodule:17
+setup/repository.h component=setup role=header prefix=repository includes=setup:2 cochange=setup:157,index:31,refs:25,pack:22,odb:19
+setup/setup.c component=setup role=lib prefix=setup includes=setup:4,odb:2,refs:2,index:1,revision:1 cochange=setup:177,refs:47,transport:44,index:39,odb:24
+setup/setup.h component=setup role=header prefix=setup includes=refs:1 cochange=setup:70,refs:8,index:5,revision:4,submodule:4
+setup/version.c component=setup role=lib prefix=version includes=setup:1 cochange=setup:8,transport:2
+setup/version.h component=setup role=header prefix=version cochange=setup:8,transport:2
 sh-i18n--envsubst.c component=? role=program prefix=sh-i18n--envsubst cochange=index:3,diff:1,transport:1
 sha1dc_git.c component=? role=lib prefix=sha1dc cochange=diff:3,odb:2,revision:2,setup:1
 sha1dc_git.h component=? role=public prefix=sha1dc cochange=odb:2
@@ -478,8 +480,6 @@ utf8.c component=? role=lib prefix=utf8 cochange=revision:6,index:3,setup:3,tran
 utf8.h component=? role=public prefix=utf8 cochange=revision:6,index:2,setup:2,transport:2,convert:1
 varint.c component=? role=lib prefix=varint cochange=index:2,transport:1
 varint.h component=? role=public prefix=varint cochange=index:2,transport:1
-version.c component=setup role=lib prefix=version includes=setup:1 cochange=setup:8,transport:2
-version.h component=setup role=header prefix=version cochange=setup:8,transport:2
 versioncmp.c component=? role=lib prefix=versioncmp includes=setup:1 cochange=setup:5,pack:3,transport:3,index:2,refs:2
 versioncmp.h component=? role=public prefix=versioncmp cochange=refs:1
 walker.c component=transport role=lib prefix=refs includes=odb:6,refs:1,setup:1,transport:1 cochange=odb:70,transport:55,revision:42,refs:24,pack:17
diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 63468494c1..9d899efb36 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -331,8 +331,8 @@ on the command line, including the name of our command. (If `prefix` is empty
 for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
 helpful. So what other context can we get?
 
-Add a line to `#include "config.h"`, `#include "repository.h"` and
-`#include "environment.h"`.
+Add a line to `#include "setup/config.h"`, `#include "setup/repository.h"` and
+`#include "setup/environment.h"`.
 Then, add the following bits to the function body:
 function body:
 
diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
index 7fb63e6861..6e3715bad7 100644
--- a/Documentation/MyFirstObjectWalk.adoc
+++ b/Documentation/MyFirstObjectWalk.adoc
@@ -219,7 +219,7 @@ Add a new function to `builtin/walken.c`.
 We'll also need to include the `config.h` header:
 
 ----
-#include "config.h"
+#include "setup/config.h"
 
 ...
 
diff --git a/Makefile b/Makefile
index 5e404ffa5e..cec75e834a 100644
--- a/Makefile
+++ b/Makefile
@@ -1102,7 +1102,7 @@ LIB_OBJS += abspath.o
 LIB_OBJS += add-interactive.o
 LIB_OBJS += add-patch.o
 LIB_OBJS += advice.o
-LIB_OBJS += alias.o
+LIB_OBJS += setup/alias.o
 LIB_OBJS += odb/alloc.o
 LIB_OBJS += apply.o
 LIB_OBJS += archive-tar.o
@@ -1135,7 +1135,7 @@ LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/open.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += compiler-tricks/not-constant.o
-LIB_OBJS += config.o
+LIB_OBJS += setup/config.o
 LIB_OBJS += connect.o
 LIB_OBJS += connected.o
 LIB_OBJS += convert.o
@@ -1162,7 +1162,7 @@ LIB_OBJS += index/dir-iterator.o
 LIB_OBJS += index/dir.o
 LIB_OBJS += editor.o
 LIB_OBJS += index/entry.o
-LIB_OBJS += environment.o
+LIB_OBJS += setup/environment.o
 LIB_OBJS += ewah/bitmap.o
 LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
@@ -1187,8 +1187,8 @@ LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += hex-ll.o
-LIB_OBJS += hook.o
-LIB_OBJS += ident.o
+LIB_OBJS += setup/hook.o
+LIB_OBJS += setup/ident.o
 LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
@@ -1312,8 +1312,8 @@ LIB_OBJS += pack/repack-midx.o
 LIB_OBJS += pack/repack-promisor.o
 LIB_OBJS += odb/replace-object.o
 LIB_OBJS += replay.o
-LIB_OBJS += repo-settings.o
-LIB_OBJS += repository.o
+LIB_OBJS += setup/repo-settings.o
+LIB_OBJS += setup/repository.o
 LIB_OBJS += rerere.o
 LIB_OBJS += reset.o
 LIB_OBJS += index/resolve-undo.o
@@ -1323,7 +1323,7 @@ LIB_OBJS += send-pack.o
 LIB_OBJS += sequencer.o
 LIB_OBJS += serve.o
 LIB_OBJS += pack/server-info.o
-LIB_OBJS += setup.o
+LIB_OBJS += setup/setup.o
 LIB_OBJS += revision/shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
@@ -1373,7 +1373,7 @@ LIB_OBJS += utf8.o
 ifdef NO_RUST
 LIB_OBJS += varint.o
 endif
-LIB_OBJS += version.o
+LIB_OBJS += setup/version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
 LIB_OBJS += wildmatch.o
@@ -2691,7 +2691,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
-hook.sp hook.s hook.o: hook-list.h
+setup/hook.sp setup/hook.s setup/hook.o: hook-list.h
 
 builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
@@ -2708,7 +2708,7 @@ pager.sp pager.s pager.o: EXTRA_CPPFLAGS = \
 version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
 	$(QUIET_GEN)$(call version_gen,"$(shell pwd)",$<,$@)
 
-version.sp version.s version.o: version-def.h
+setup/version.sp setup/version.s setup/version.o: version-def.h
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
@@ -2973,12 +2973,12 @@ exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"'
 
-setup.sp setup.s setup.o: GIT-PREFIX
-setup.sp setup.s setup.o: EXTRA_CPPFLAGS = \
+setup/setup.sp setup/setup.s setup/setup.o: GIT-PREFIX
+setup/setup.sp setup/setup.s setup/setup.o: EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
-config.sp config.s config.o: GIT-PREFIX
-config.sp config.s config.o: EXTRA_CPPFLAGS = \
+setup/config.sp setup/config.s setup/config.o: GIT-PREFIX
+setup/config.sp setup/config.s setup/config.o: EXTRA_CPPFLAGS = \
 	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
 attr.sp attr.s attr.o: GIT-PREFIX
diff --git a/add-interactive.c b/add-interactive.c
index 5f4d379910..e14a2c98f3 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -9,7 +9,7 @@
 #include "hex.h"
 #include "index/preload-index.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "revision/revision.h"
 #include "refs/refs.h"
 #include "string-list.h"
diff --git a/add-patch.c b/add-patch.c
index 0499152dbc..f1f4b0c4c6 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -5,16 +5,16 @@
 #include "add-patch.h"
 #include "advice.h"
 #include "odb/commit.h"
-#include "config.h"
+#include "setup/config.h"
 #include "diff/diff.h"
 #include "editor.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-name.h"
 #include "pager.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strbuf.h"
 #include "sigchain.h"
 #include "run-command.h"
diff --git a/advice.c b/advice.c
index 63bf8b0c5f..3139ac5e87 100644
--- a/advice.c
+++ b/advice.c
@@ -1,8 +1,8 @@
 #include "git-compat-util.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "color.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "help.h"
 #include "string-list.h"
diff --git a/apply.c b/apply.c
index 70d5461fbe..75f81b1444 100644
--- a/apply.c
+++ b/apply.c
@@ -13,12 +13,12 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "base85.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/odb.h"
 #include "pack/delta.h"
 #include "diff/diff.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "diff/xdiff-interface.h"
@@ -31,11 +31,11 @@
 #include "path.h"
 #include "quote.h"
 #include "index/read-cache.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "rerere.h"
 #include "apply.h"
 #include "index/entry.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/symlinks.h"
 #include "wildmatch.h"
 #include "ws.h"
diff --git a/archive-tar.c b/archive-tar.c
index 318b9bcc24..525b517749 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -5,7 +5,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
 #include "git-zlib.h"
 #include "hex.h"
diff --git a/archive-zip.c b/archive-zip.c
index df1edadd33..1e8baf3205 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -5,7 +5,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "archive.h"
 #include "gettext.h"
 #include "git-zlib.h"
diff --git a/archive.c b/archive.c
index e6fdd2ea8f..3f3922c3e6 100644
--- a/archive.c
+++ b/archive.c
@@ -3,16 +3,16 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "config.h"
+#include "setup/config.h"
 #include "convert.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "git-zlib.h"
 #include "hex.h"
 #include "odb/object-name.h"
 #include "path.h"
 #include "revision/pretty.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "refs/refs.h"
 #include "odb/odb.h"
 #include "odb/commit.h"
diff --git a/attr.c b/attr.c
index 841d2f23ae..9180683faa 100644
--- a/attr.c
+++ b/attr.c
@@ -10,8 +10,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "exec-cmd.h"
 #include "attr.h"
 #include "index/dir.h"
@@ -23,7 +23,7 @@
 #include "refs/refs.h"
 #include "revision/revision.h"
 #include "odb/odb.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "thread-utils.h"
 #include "odb/tree-walk.h"
 #include "odb/object-name.h"
diff --git a/branch.c b/branch.c
index d752e55b88..14483c1402 100644
--- a/branch.c
+++ b/branch.c
@@ -2,9 +2,9 @@
 
 #include "git-compat-util.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "branch.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-name.h"
@@ -12,7 +12,7 @@
 #include "refs/refs.h"
 #include "refs/refspec.h"
 #include "remote.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "sequencer.h"
 #include "odb/commit.h"
 #include "refs/worktree.h"
diff --git a/builtin.h b/builtin.h
index 0ac855e534..7c48a8e29f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -2,7 +2,7 @@
 #define BUILTIN_H
 
 #include "git-compat-util.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 /*
  * builtin API
diff --git a/builtin/add.c b/builtin/add.c
index e544220eb2..69b6d7e7ca 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -6,8 +6,8 @@
 
 #include "builtin.h"
 #include "advice.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "lockfile.h"
 #include "editor.h"
 #include "index/dir.h"
diff --git a/builtin/am.c b/builtin/am.c
index 0b6d77004f..053043e477 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -9,15 +9,15 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "editor.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "index/dir.h"
 #include "run-command.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "quote.h"
 #include "tempfile.h"
 #include "lockfile.h"
diff --git a/builtin/backfill.c b/builtin/backfill.c
index b8e21c844c..f30addad55 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -3,12 +3,12 @@
 
 #include "builtin.h"
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "parse-options.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/commit.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
diff --git a/builtin/bisect.c b/builtin/bisect.c
index cfb0741d22..61205f13b6 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -3,7 +3,7 @@
 
 #include "builtin.h"
 #include "copy.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-name.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 9e5776e31b..23e6f77d42 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -8,9 +8,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "color.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/commit.h"
@@ -31,7 +31,7 @@
 #include "pager.h"
 #include "revision/blame.h"
 #include "refs/refs.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "odb/tag.h"
 #include "write-or-die.h"
 
diff --git a/builtin/branch.c b/builtin/branch.c
index c80df76d36..eeab13a4b6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -8,10 +8,10 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "color.h"
 #include "editor.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "refs/refs.h"
 #include "odb/commit.h"
 #include "gettext.h"
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index f78c3f2aed..dffed32db6 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -8,11 +8,11 @@
 #include "strbuf.h"
 #include "help.h"
 #include "compat/compiler.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "hook-list.h"
 #include "diagnose.h"
-#include "setup.h"
-#include "version.h"
+#include "setup/setup.h"
+#include "setup/version.h"
 
 static void get_system_info(struct strbuf *sys_info)
 {
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 1e170e9278..6dbe478bcb 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -2,7 +2,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strvec.h"
 #include "parse-options.h"
 #include "pkt-line.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 94979a2683..4a5c73720d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -8,13 +8,13 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "convert.h"
 #include "diff/diff.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "ident.h"
+#include "setup/ident.h"
 #include "revision/list-objects-filter-options.h"
 #include "parse-options.h"
 #include "diff/userdiff.h"
@@ -28,7 +28,7 @@
 #include "promisor-remote.h"
 #include "mailmap.h"
 #include "write-or-die.h"
-#include "alias.h"
+#include "setup/alias.h"
 #include "remote.h"
 #include "transport.h"
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 02ff3b4eb5..8eb5d4e748 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -1,12 +1,12 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "attr.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/object-name.h"
 #include "quote.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "parse-options.h"
 #include "write-or-die.h"
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 1d2c3cb8db..00a04404bd 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "quote.h"
 #include "index/pathspec.h"
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 3f2a39cae0..4c3fc0de7a 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -1,9 +1,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
-#include "ident.h"
+#include "setup/ident.h"
 #include "mailmap.h"
 #include "parse-options.h"
 #include "strbuf.h"
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 5de8c0e6f5..cb8f539b02 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -6,7 +6,7 @@
 
 #include "builtin.h"
 #include "refs/refs.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 
 static const char builtin_check_ref_format_usage[] =
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index 9c49474753..aa1ca1ed14 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -2,9 +2,9 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/entry.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "index/parallel-checkout.h"
 #include "parse-options.h"
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index c659e5c764..139f4f9441 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -8,8 +8,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -18,7 +18,7 @@
 #include "index/entry.h"
 #include "index/parallel-checkout.h"
 #include "index/read-cache-ll.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/sparse-index.h"
 
 #define CHECKOUT_ALL 4
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 48882b0f8e..3dedddc61a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -7,13 +7,13 @@
 #include "index/cache-tree.h"
 #include "index/checkout.h"
 #include "odb/commit.h"
-#include "config.h"
+#include "setup/config.h"
 #include "diff/diff.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "merge-ll.h"
 #include "lockfile.h"
 #include "mem-pool.h"
@@ -26,11 +26,11 @@
 #include "index/read-cache.h"
 #include "refs/refs.h"
 #include "remote.h"
-#include "repo-settings.h"
+#include "setup/repo-settings.h"
 #include "index/resolve-undo.h"
 #include "revision/revision.h"
 #include "sequencer.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/sparse-index.h"
 #include "strvec.h"
 #include "submodule.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index 81b3b86491..35a5c1465d 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -11,14 +11,14 @@
 
 #include "builtin.h"
 #include "abspath.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
 #include "index/read-cache-ll.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "string-list.h"
 #include "quote.h"
 #include "column.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 58cf9761a0..a8f7e1b6f3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -15,9 +15,9 @@
 
 #include "abspath.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "copy.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -38,13 +38,13 @@
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "connected.h"
 #include "pack/packfile.h"
 #include "path.h"
 #include "pkt-line.h"
 #include "revision/list-objects-filter-options.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "bundle.h"
 #include "bundle-uri.h"
 
diff --git a/builtin/column.c b/builtin/column.c
index 87dce3c6e5..8603d23d1f 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -1,6 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
 #include "strbuf.h"
 #include "parse-options.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 2de897402e..d4dc4985d3 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "odb/commit.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 598ef30372..eb6fa99d14 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -5,8 +5,8 @@
  */
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-name.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index 85ab748ff0..3bf6f012c0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -10,13 +10,13 @@
 
 #include "builtin.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "lockfile.h"
 #include "index/cache-tree.h"
 #include "color.h"
 #include "index/dir.h"
 #include "editor.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "diff/diff.h"
 #include "odb/commit.h"
 #include "add-interactive.h"
@@ -30,7 +30,7 @@
 #include "path.h"
 #include "index/preload-index.h"
 #include "index/read-cache.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "string-list.h"
 #include "rerere.h"
 #include "index/unpack-trees.h"
diff --git a/builtin/config.c b/builtin/config.c
index 15782dfe64..3c56c7380d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -2,18 +2,18 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "color.h"
 #include "date.h"
 #include "editor.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
-#include "ident.h"
+#include "setup/ident.h"
 #include "parse-options.h"
 #include "urlmatch.h"
 #include "path.h"
 #include "quote.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "refs/worktree.h"
 
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index cf10ddcae1..0a28c0a552 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -5,9 +5,9 @@
  */
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "path.h"
 #include "parse-options.h"
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 65cc619bec..313f4c58e8 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -7,7 +7,7 @@
 
 #ifndef NO_UNIX_SOCKETS
 
-#include "config.h"
+#include "setup/config.h"
 #include "tempfile.h"
 #include "credential.h"
 #include "unix-socket.h"
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index bc1453c6b2..91004b6188 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -1,6 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
 #include "lockfile.h"
 #include "credential.h"
diff --git a/builtin/credential.c b/builtin/credential.c
index a295c80b36..1917982734 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -3,8 +3,8 @@
 #include "git-compat-util.h"
 #include "credential.h"
 #include "builtin.h"
-#include "environment.h"
-#include "config.h"
+#include "setup/environment.h"
+#include "setup/config.h"
 
 static const char usage_msg[] =
 	"git credential (fill|approve|reject)";
diff --git a/builtin/describe.c b/builtin/describe.c
index c22158d157..0c840c84ad 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -2,8 +2,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -16,7 +16,7 @@
 #include "revision/revision.h"
 #include "diff/diff.h"
 #include "hashmap.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "odb/odb.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 1f67480362..d536ce8475 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -8,7 +8,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "diff/diff.h"
 #include "diff/diff-merges.h"
 #include "odb/commit.h"
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index dac8099081..dac7eac2d8 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -2,13 +2,13 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "diff/diff.h"
 #include "diff/diff-merges.h"
 #include "odb/commit.h"
 #include "index/preload-index.h"
 #include "revision/revision.h"
-#include "setup.h"
+#include "setup/setup.h"
 
 static const char diff_cache_usage[] =
 "git diff-index [-m] [--cached] [--merge-base] "
diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
index df5630be47..6400caf0a6 100644
--- a/builtin/diff-pairs.c
+++ b/builtin/diff-pairs.c
@@ -1,5 +1,5 @@
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "diff/diff.h"
 #include "diff/diffcore.h"
 #include "gettext.h"
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 8f7f48ac67..010a996ab6 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "diff/diff.h"
 #include "odb/commit.h"
 #include "gettext.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index 0e8c488408..badef1411b 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -8,7 +8,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "ewah/ewok.h"
 #include "lockfile.h"
 #include "color.h"
@@ -22,7 +22,7 @@
 #include "index/read-cache-ll.h"
 #include "revision/revision.h"
 #include "revision/log-tree.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "odb/oid-array.h"
 #include "odb/tree.h"
 
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 1d3fae8793..425f3ddf83 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -15,16 +15,16 @@
 #include "builtin.h"
 
 #include "abspath.h"
-#include "config.h"
+#include "setup/config.h"
 #include "copy.h"
 #include "run-command.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "path.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "index/sparse-index.h"
 #include "strvec.h"
 #include "strbuf.h"
@@ -33,7 +33,7 @@
 #include "odb/odb.h"
 #include "index/dir.h"
 #include "index/entry.h"
-#include "setup.h"
+#include "setup/setup.h"
 
 static const char *const builtin_difftool_usage[] = {
 	N_("git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]"),
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 565cdccb40..5e5e100884 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -8,8 +8,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs/refs.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index da586c7c63..16353c1d71 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3,10 +3,10 @@
 
 #include "builtin.h"
 #include "abspath.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "config.h"
+#include "setup/config.h"
 #include "lockfile.h"
 #include "odb/object.h"
 #include "odb/blob.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2f744ac8b8..60be51f079 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -7,9 +7,9 @@
 
 #include "builtin.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "refs/refs.h"
 #include "refs/refspec.h"
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index cf4273a52c..a7e681afdf 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -1,5 +1,5 @@
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "fmt-merge-msg.h"
 #include "gettext.h"
 #include "parse-options.h"
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 9b3f277cb8..6a39f52698 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,7 +1,7 @@
 #include "builtin.h"
 #include "odb/commit.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "for-each-ref.h"
 #include "gettext.h"
 #include "odb/object.h"
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 927d3d92da..0ee86283cd 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 6e8fd0e828..049f32e13a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,7 +1,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/commit.h"
 #include "odb/tree.h"
 #include "odb/blob.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 49b492fba0..8d82f210cc 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -3,9 +3,9 @@
 
 #include "builtin.h"
 #include "abspath.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "index/fsmonitor-ll.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index 0243b34e3e..e4c482c243 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -17,9 +17,9 @@
 #include "abspath.h"
 #include "date.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "hex.h"
-#include "config.h"
+#include "setup/config.h"
 #include "tempfile.h"
 #include "lockfile.h"
 #include "parse-options.h"
@@ -39,8 +39,8 @@
 #include "remote.h"
 #include "exec-cmd.h"
 #include "gettext.h"
-#include "hook.h"
-#include "setup.h"
+#include "setup/hook.h"
+#include "setup/setup.h"
 #include "trace2.h"
 #include "refs/worktree.h"
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 20cd821af7..10df2dacef 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -9,10 +9,10 @@
 
 #include "builtin.h"
 #include "abspath.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/tag.h"
 #include "odb/tree-walk.h"
 #include "parse-options.h"
@@ -22,7 +22,7 @@
 #include "quote.h"
 #include "index/dir.h"
 #include "index/pathspec.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "odb/object-name.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 335575862c..95a5105c2a 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -7,8 +7,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-file.h"
@@ -16,7 +16,7 @@
 #include "odb/blob.h"
 #include "quote.h"
 #include "parse-options.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "write-or-die.h"
 
diff --git a/builtin/help.c b/builtin/help.c
index a140339999..4d1c5e18bd 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -5,8 +5,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "pager.h"
@@ -15,8 +15,8 @@
 #include "run-command.h"
 #include "config-list.h"
 #include "help.h"
-#include "alias.h"
-#include "setup.h"
+#include "setup/alias.h"
+#include "setup/setup.h"
 
 #ifndef DEFAULT_HELP_FORMAT
 #define DEFAULT_HELP_FORMAT "man"
diff --git a/builtin/history.c b/builtin/history.c
index c817745f30..9c38be5b38 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -4,9 +4,9 @@
 #include "index/cache-tree.h"
 #include "odb/commit.h"
 #include "revision/commit-reach.h"
-#include "config.h"
+#include "setup/config.h"
 #include "editor.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/builtin/hook.c b/builtin/hook.c
index cceeb3586e..6cff5b0889 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -1,9 +1,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "parse-options.h"
 #include "thread-utils.h"
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 23d7e68020..167a6df9e7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2,9 +2,9 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "pack/delta.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "pack/pack.h"
@@ -29,7 +29,7 @@
 #include "odb/tree-walk.h"
 #include "promisor-remote.h"
 #include "run-command.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strvec.h"
 
 static const char index_pack_usage[] =
diff --git a/builtin/init-db.c b/builtin/init-db.c
index f459635129..bc8496b585 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -6,12 +6,12 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
 #include "refs/refs.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 
 static int guess_repository_type(const char *git_dir)
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index e7e86e9523..2462307a98 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -6,13 +6,13 @@
  */
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "string-list.h"
 #include "tempfile.h"
 #include "trailer.h"
-#include "config.h"
+#include "setup/config.h"
 
 static const char * const git_interpret_trailers_usage[] = {
 	N_("git interpret-trailers [--in-place] [--trim-empty]\n"
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 88e122db9b..763d0f93a7 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -4,10 +4,10 @@
 #include "pack/commit-graph.h"
 #include "odb/commit-slab.h"
 #include "odb/commit.h"
-#include "config.h"
+#include "setup/config.h"
 #include "diff/diff.h"
 #include "diff/diffcore.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "ewah/ewok.h"
 #include "hashmap.h"
 #include "hex.h"
@@ -16,7 +16,7 @@
 #include "parse-options.h"
 #include "prio-queue.h"
 #include "quote.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "revision/revision.h"
 
 /* Remember to update object flag allocation in object.h */
diff --git a/builtin/log.c b/builtin/log.c
index 82144cf2b6..5b79637af3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -9,8 +9,8 @@
 
 #include "builtin.h"
 #include "abspath.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs/refs.h"
@@ -37,7 +37,7 @@
 #include "parse-options.h"
 #include "revision/line-log.h"
 #include "branch.h"
-#include "version.h"
+#include "setup/version.h"
 #include "mailmap.h"
 #include "progress.h"
 #include "odb/commit-slab.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 49e8a685e3..3ef55beb89 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -9,9 +9,9 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "convert.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "quote.h"
 #include "index/dir.h"
 #include "gettext.h"
@@ -23,7 +23,7 @@
 #include "path.h"
 #include "index/pathspec.h"
 #include "index/read-cache.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/sparse-index.h"
 #include "submodule.h"
 #include "odb/odb.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index b59c186a21..70ca5dca69 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -6,8 +6,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-name.h"
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 8de7ba7de1..943757ebcf 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -5,7 +5,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "strbuf.h"
 #include "mailinfo.h"
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 7eec05ae7b..fa9c4945d4 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/commit.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-name.h"
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 12701b1d81..7075fce70d 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -8,9 +8,9 @@
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "xdiff/xdiff.h"
 #include "diff/xdiff-interface.h"
 #include "parse-options.h"
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index c33e176c65..3900f64b5d 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -10,8 +10,8 @@
 
 #include "git-compat-util.h"
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "diff/diff.h"
 
 static const char builtin_merge_ours_usage[] =
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 41d8bbcbc1..7a73454060 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "odb/tree-walk.h"
 #include "diff/xdiff-interface.h"
 #include "help.h"
@@ -17,7 +17,7 @@
 #include "merge-blobs.h"
 #include "quote.h"
 #include "odb/tree.h"
-#include "config.h"
+#include "setup/config.h"
 #include "strvec.h"
 #include "write-or-die.h"
 
diff --git a/builtin/merge.c b/builtin/merge.c
index da37fb11eb..090e2a8fb1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -13,17 +13,17 @@
 
 #include "abspath.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "editor.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
 #include "lockfile.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "run-command.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "diff/diff.h"
 #include "diff/diff-merges.h"
 #include "refs/refs.h"
@@ -46,7 +46,7 @@
 #include "sequencer.h"
 #include "string-list.h"
 #include "odb/tag.h"
-#include "alias.h"
+#include "setup/alias.h"
 #include "branch.h"
 #include "revision/commit-reach.h"
 #include "index/wt-status.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index eb25acc4a5..f7ed512639 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -8,7 +8,7 @@
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "odb/fsck.h"
-#include "config.h"
+#include "setup/config.h"
 
 static char const * const builtin_mktag_usage[] = {
 	"git mktag",
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 81401e37d5..2d78a08326 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "pack/midx.h"
@@ -12,7 +12,7 @@
 #include "odb/source.h"
 #include "odb/source-files.h"
 #include "odb/replace-object.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
diff --git a/builtin/mv.c b/builtin/mv.c
index f49eec035e..bc51d64c95 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -10,8 +10,8 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "index/name-hash.h"
 #include "odb/object-file.h"
@@ -24,7 +24,7 @@
 #include "index/read-cache-ll.h"
 #include "index/symlinks.h"
 
-#include "setup.h"
+#include "setup/setup.h"
 #include "strvec.h"
 #include "submodule.h"
 #include "index/entry.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 31bc960b34..5cccf689f5 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -2,10 +2,10 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
 #include "refs/refs.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 61087b0fa5..5a1201b315 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -8,9 +8,9 @@
  */
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "editor.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "notes.h"
diff --git a/builtin/organize.c b/builtin/organize.c
index 925ef17128..35bf5cf90d 100644
--- a/builtin/organize.c
+++ b/builtin/organize.c
@@ -13,7 +13,7 @@
 #include "gettext.h"
 #include "organize/organize.h"
 #include "parse-options.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strvec.h"
 
 static const char *const organize_usage[] = {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b611b27573..cc97d7e814 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2,10 +2,10 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "config.h"
+#include "setup/config.h"
 #include "attr.h"
 #include "odb/object.h"
 #include "odb/commit.h"
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 7207279cef..22196195d2 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,14 +1,14 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "diff/diff.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
 #include "parse-options.h"
-#include "setup.h"
+#include "setup/setup.h"
 
 static void flush_current_id(size_t patchlen, struct object_id *id, struct object_id *result)
 {
diff --git a/builtin/prune.c b/builtin/prune.c
index d2d5bd2619..fc70161992 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -4,7 +4,7 @@
 #include "odb/commit.h"
 #include "diff/diff.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision/revision.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index 818ddbf956..cca98abb65 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -10,8 +10,8 @@
 
 #include "builtin.h"
 #include "advice.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "merge.h"
diff --git a/builtin/push.c b/builtin/push.c
index 280cfd289f..b4556466d7 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -7,9 +7,9 @@
 #include "builtin.h"
 #include "advice.h"
 #include "branch.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs/refspec.h"
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 323046c696..ffb36c6086 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -5,7 +5,7 @@
 #include "odb/object-name.h"
 #include "parse-options.h"
 #include "diff/range-diff.h"
-#include "config.h"
+#include "setup/config.h"
 #include "parse.h"
 #include "color.h"
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 2bc2f43729..6c2ea503f7 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -5,8 +5,8 @@
  */
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -18,7 +18,7 @@
 #include "index/unpack-trees.h"
 #include "parse-options.h"
 #include "index/resolve-undo.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/sparse-index.h"
 #include "submodule.h"
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 62b58da192..03bc28aba9 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -10,14 +10,14 @@
 #include "builtin.h"
 
 #include "abspath.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "run-command.h"
 #include "strvec.h"
 #include "index/dir.h"
 #include "refs/refs.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/unpack-trees.h"
 #include "lockfile.h"
 #include "odb/object-file.h"
@@ -35,7 +35,7 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "trace2.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "trailer.h"
 
 static char const * const builtin_rebase_usage[] = {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9a816f1e86..718073653c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -5,16 +5,16 @@
 #include "abspath.h"
 #include "odb/commit.h"
 #include "revision/commit-reach.h"
-#include "config.h"
+#include "setup/config.h"
 #include "connect.h"
 #include "connected.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "exec-cmd.h"
 #include "odb/fsck.h"
 #include "gettext.h"
 #include "gpg-interface.h"
 #include "hex.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "lockfile.h"
 #include "odb/object.h"
 #include "odb/object-file.h"
@@ -31,7 +31,7 @@
 #include "remote.h"
 #include "run-command.h"
 #include "pack/server-info.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "revision/shallow.h"
 #include "sideband.h"
 #include "sigchain.h"
@@ -39,7 +39,7 @@
 #include "strvec.h"
 #include "trace.h"
 #include "trace2.h"
-#include "version.h"
+#include "setup/version.h"
 #include "refs/worktree.h"
 
 static const char * const receive_pack_usage[] = {
diff --git a/builtin/reflog.c b/builtin/reflog.c
index d8d1cb2c6a..83e40a0194 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/odb.h"
diff --git a/builtin/refs.c b/builtin/refs.c
index abfc0acdd2..d6e28a6043 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -1,5 +1,5 @@
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/fsck.h"
 #include "refs/pack-refs.h"
 #include "parse-options.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index 3f6cee14ff..5a4fa6de8b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -2,10 +2,10 @@
 
 #include "builtin.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "date.h"
 #include "gettext.h"
-#include "ident.h"
+#include "setup/ident.h"
 #include "parse-options.h"
 #include "path.h"
 #include "transport.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index aa74f2161a..1d861c6062 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1,8 +1,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "parse-options.h"
 #include "path.h"
 #include "run-command.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index 83497cd974..37f3dbd537 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -9,9 +9,9 @@
  */
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "editor.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs/refs.h"
diff --git a/builtin/replay.c b/builtin/replay.c
index 4f5515a314..f2f8c16343 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -5,7 +5,7 @@
 #include "git-compat-util.h"
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "hex.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
diff --git a/builtin/repo.c b/builtin/repo.c
index b296e2cda7..e736c97e9a 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -2,7 +2,7 @@
 
 #include "builtin.h"
 #include "odb/commit.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "odb/hash.h"
 #include "hex.h"
 #include "odb/odb.h"
@@ -14,7 +14,7 @@
 #include "refs/ref-filter.h"
 #include "refs/refs.h"
 #include "revision/revision.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "revision/shallow.h"
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 4b1b7d49ce..f7d406168c 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "rerere.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 96c7bf9cf1..2202e0006d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -12,8 +12,8 @@
 
 #include "builtin.h"
 #include "advice.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
@@ -28,10 +28,10 @@
 #include "odb/object-name.h"
 #include "parse-options.h"
 #include "path.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "index/unpack-trees.h"
 #include "index/cache-tree.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/sparse-index.h"
 #include "submodule.h"
 #include "trace.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 21d7b8aa81..54aabd084f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -2,10 +2,10 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision/revision.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 1d97c4869b..6f394db8d2 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -11,9 +11,9 @@
 
 #include "abspath.h"
 #include "revision/bisect.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/commit.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
@@ -24,10 +24,10 @@
 #include "path.h"
 #include "diff/diff.h"
 #include "index/read-cache-ll.h"
-#include "repo-settings.h"
-#include "repository.h"
+#include "setup/repo-settings.h"
+#include "setup/repository.h"
 #include "revision/revision.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/split-index.h"
 #include "submodule.h"
 #include "revision/commit-reach.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index ae3f186f12..f220268baa 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -4,7 +4,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "diff/diff.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "revision/revision.h"
 #include "rerere.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 4f7194f541..cf59a9895d 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -8,8 +8,8 @@
 
 #include "builtin.h"
 #include "advice.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "lockfile.h"
 #include "index/dir.h"
 #include "gettext.h"
@@ -20,7 +20,7 @@
 #include "index/read-cache.h"
 
 #include "string-list.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/sparse-index.h"
 #include "submodule.h"
 #include "index/pathspec.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 2597a47bde..1e358bc0b0 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,6 +1,6 @@
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "pkt-line.h"
 #include "run-command.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 2fe86d6f46..fe98e4f21b 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -1,16 +1,16 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "string-list.h"
 #include "revision/revision.h"
 #include "utf8.h"
 #include "mailmap.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "shortlog.h"
 #include "parse-options.h"
 #include "trailer.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e0e912439c..31008f6d51 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -2,8 +2,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index e4b186b930..77362ae6c7 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs/refs-internal.h"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index efe6f7897e..8f2daa10ac 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -3,9 +3,9 @@
 
 #include "builtin.h"
 #include "abspath.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
@@ -17,7 +17,7 @@
 #include "lockfile.h"
 #include "index/unpack-trees.h"
 #include "quote.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/sparse-index.h"
 #include "refs/worktree.h"
 
diff --git a/builtin/stash.c b/builtin/stash.c
index a8337ffdc4..81b3506598 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -2,8 +2,8 @@
 
 #include "builtin.h"
 #include "abspath.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
@@ -20,10 +20,10 @@
 #include "index/entry.h"
 #include "index/preload-index.h"
 #include "index/read-cache.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "rerere.h"
 #include "revision/revision.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/sparse-index.h"
 #include "revision/log-tree.h"
 #include "diff/diffcore.h"
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 18705f1a5b..9547c474e3 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -1,10 +1,10 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "write-or-die.h"
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5226a5f331..5a97263743 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2,11 +2,11 @@
 
 #include "builtin.h"
 #include "abspath.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 
-#include "config.h"
+#include "setup/config.h"
 #include "parse-options.h"
 #include "quote.h"
 #include "path.h"
@@ -14,7 +14,7 @@
 #include "index/preload-index.h"
 #include "index/dir.h"
 #include "index/read-cache.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/sparse-index.h"
 #include "submodule.h"
 #include "submodule-config.h"
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 9ea9ca6500..d5461ac52c 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "refs/refs.h"
 #include "parse-options.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 46df0f7c27..08a50c3c43 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -11,9 +11,9 @@
 
 #include "builtin.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "editor.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs/refs.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 47f43f5a87..600da7fd06 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index fb724e46ea..9081e618b3 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -2,8 +2,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "git-zlib.h"
 #include "hex.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index b5c8fae02c..1824c9590e 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -8,8 +8,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
@@ -26,7 +26,7 @@
 #include "index/pathspec.h"
 #include "index/dir.h"
 #include "index/read-cache.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/sparse-index.h"
 #include "index/split-index.h"
 #include "index/symlinks.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 5bcd100e52..57090fffae 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -2,8 +2,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index 41bbd0114f..ca087aa41f 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -1,6 +1,6 @@
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "pack/server-info.h"
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 718e74b3ac..7b63b0185b 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -5,7 +5,7 @@
 #include "builtin.h"
 #include "archive.h"
 #include "pkt-line.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "sideband.h"
 #include "run-command.h"
 #include "strvec.h"
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index dc37ffb70c..7131fb6689 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -9,9 +9,9 @@
 #include "odb/replace-object.h"
 #include "upload-pack.h"
 #include "serve.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "odb/commit.h"
-#include "environment.h"
+#include "setup/environment.h"
 
 static const char * const upload_pack_usage[] = {
 	N_("git-upload-pack [--[no-]strict] [--timeout=<n>] [--stateless-rpc]\n"
diff --git a/builtin/var.c b/builtin/var.c
index d01c87dfa2..0d48bd81a8 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -9,10 +9,10 @@
 #include "builtin.h"
 
 #include "attr.h"
-#include "config.h"
+#include "setup/config.h"
 #include "editor.h"
-#include "environment.h"
-#include "ident.h"
+#include "setup/environment.h"
+#include "setup/ident.h"
 #include "pager.h"
 #include "refs/refs.h"
 #include "path.h"
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 3ec03f016c..529b2d2573 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -6,8 +6,8 @@
  * Based on git-verify-tag
  */
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/object-name.h"
 #include "odb/commit.h"
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 65fd6629a0..1b282e6bb9 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "run-command.h"
 #include "parse-options.h"
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 460244f25b..82edf73980 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -6,8 +6,8 @@
  * Based on git-verify-tag.sh
  */
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/tag.h"
 #include "odb/object-name.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index c4068b45d6..1d808800cc 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -5,10 +5,10 @@
 #include "abspath.h"
 #include "advice.h"
 #include "index/checkout.h"
-#include "config.h"
+#include "setup/config.h"
 #include "copy.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-file.h"
@@ -21,7 +21,7 @@
 #include "refs/refs.h"
 #include "remote.h"
 #include "run-command.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "sigchain.h"
 #include "submodule.h"
 #include "utf8.h"
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 4a2b1ceb58..7d21f64007 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -5,8 +5,8 @@
  */
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/tree.h"
diff --git a/bundle-uri.c b/bundle-uri.c
index 96ddf92347..cd26d38249 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -10,7 +10,7 @@
 #include "run-command.h"
 #include "hashmap.h"
 #include "pkt-line.h"
-#include "config.h"
+#include "setup/config.h"
 #include "fetch-pack.h"
 #include "remote.h"
 #include "trace2.h"
diff --git a/bundle.c b/bundle.c
index dc50661bdd..1e01ab38d4 100644
--- a/bundle.c
+++ b/bundle.c
@@ -4,11 +4,11 @@
 #include "git-compat-util.h"
 #include "lockfile.h"
 #include "bundle.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/odb.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/object.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
diff --git a/color.c b/color.c
index 00b53f97ac..06a0b92958 100644
--- a/color.c
+++ b/color.c
@@ -1,7 +1,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "color.h"
 #include "editor.h"
 #include "gettext.h"
diff --git a/column.c b/column.c
index 93fae316b4..505abf2bfb 100644
--- a/column.c
+++ b/column.c
@@ -1,7 +1,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "column.h"
 #include "string-list.h"
 #include "pager.h"
diff --git a/common-init.c b/common-init.c
index 7e6b392800..aacfc85db6 100644
--- a/common-init.c
+++ b/common-init.c
@@ -7,9 +7,9 @@
 #include "attr.h"
 #include "odb/odb.h"
 #include "parse.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/replace-object.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "trace2.h"
 
diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-darwin.c
index f24d56b3d2..dfa07f4b7b 100644
--- a/compat/fsmonitor/fsm-health-darwin.c
+++ b/compat/fsmonitor/fsm-health-darwin.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/fsmonitor-ll.h"
 #include "fsm-health.h"
 #include "index/fsmonitor--daemon.h"
diff --git a/compat/fsmonitor/fsm-health-linux.c b/compat/fsmonitor/fsm-health-linux.c
index 7be822fb1c..60f878b55e 100644
--- a/compat/fsmonitor/fsm-health-linux.c
+++ b/compat/fsmonitor/fsm-health-linux.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/fsmonitor-ll.h"
 #include "fsm-health.h"
 #include "index/fsmonitor--daemon.h"
diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 09dee50777..c4574f1eb0 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/fsmonitor-ll.h"
 #include "fsm-health.h"
 #include "index/fsmonitor--daemon.h"
diff --git a/compat/fsmonitor/fsm-ipc-unix.c b/compat/fsmonitor/fsm-ipc-unix.c
index ffd864ae92..bb1bed15fb 100644
--- a/compat/fsmonitor/fsm-ipc-unix.c
+++ b/compat/fsmonitor/fsm-ipc-unix.c
@@ -1,11 +1,11 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
 #include "hex.h"
 #include "path.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strbuf.h"
 #include "index/fsmonitor-ll.h"
 #include "index/fsmonitor-ipc.h"
diff --git a/compat/fsmonitor/fsm-ipc-win32.c b/compat/fsmonitor/fsm-ipc-win32.c
index bc92e1fd20..d3febb8dbd 100644
--- a/compat/fsmonitor/fsm-ipc-win32.c
+++ b/compat/fsmonitor/fsm-ipc-win32.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/fsmonitor-ipc.h"
 #include "path.h"
 
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index c8cbdf4a97..4c49b04a7b 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/fsmonitor-ll.h"
 #include "fsm-listen.h"
 #include "index/fsmonitor--daemon.h"
diff --git a/compat/fsmonitor/fsm-settings-unix.c b/compat/fsmonitor/fsm-settings-unix.c
index 41106355b1..67c49d0ca7 100644
--- a/compat/fsmonitor/fsm-settings-unix.c
+++ b/compat/fsmonitor/fsm-settings-unix.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/fsmonitor-ll.h"
 #include "index/fsmonitor-ipc.h"
 #include "index/fsmonitor-settings.h"
diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 5b2872a4f1..4c822e01ed 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
-#include "config.h"
-#include "repository.h"
+#include "setup/config.h"
+#include "setup/repository.h"
 #include "index/fsmonitor-ll.h"
 #include "index/fsmonitor-settings.h"
 #include "index/fsmonitor-path-utils.h"
diff --git a/compat/mingw.c b/compat/mingw.c
index 64814ac35d..9fce208dde 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -4,10 +4,10 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "odb/alloc.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
-#include "environment.h"
-#include "repository.h"
+#include "setup/environment.h"
+#include "setup/repository.h"
 #include "gettext.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 8077f6235b..c047c17675 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -7,8 +7,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "path.h"
 #include "strbuf.h"
diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 4b09cc4e14..25f7e13d9e 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -20,7 +20,7 @@
 #pragma GCC diagnostic ignored "-Wsign-compare"
 
 #ifdef HAVE_CONFIG_H
-#include "config.h"
+#include "setup/config.h"
 #endif
 
 /* Make sure no one compiles this code with a C++ compiler.  */
diff --git a/compat/win32/path-utils.c b/compat/win32/path-utils.c
index f779f367cf..043b077d67 100644
--- a/compat/win32/path-utils.c
+++ b/compat/win32/path-utils.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "../../git-compat-util.h"
-#include "../../environment.h"
-#include "../../repository.h"
+#include "setup/environment.h"
+#include "setup/repository.h"
 
 int win32_has_dos_drive_prefix(const char *path)
 {
diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index 6a6a396078..6fe122e637 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -2,7 +2,7 @@
 
 #include "../../git-compat-util.h"
 #include "../../json-writer.h"
-#include "../../repository.h"
+#include "setup/repository.h"
 #include "../../strvec.h"
 #include "../../trace2.h"
 #include "lazyload.h"
diff --git a/connect.c b/connect.c
index a24b019b2c..2a1b177490 100644
--- a/connect.c
+++ b/connect.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "pkt-line.h"
@@ -18,9 +18,9 @@
 #include "transport.h"
 #include "trace2.h"
 #include "strbuf.h"
-#include "version.h"
+#include "setup/version.h"
 #include "protocol.h"
-#include "alias.h"
+#include "setup/alias.h"
 #include "bundle-uri.h"
 #include "promisor-remote.h"
 
diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgit-sys/public_symbol_export.c
index dfbb257115..02765ba5a9 100644
--- a/contrib/libgit-sys/public_symbol_export.c
+++ b/contrib/libgit-sys/public_symbol_export.c
@@ -5,9 +5,9 @@
  */
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "contrib/libgit-sys/public_symbol_export.h"
-#include "version.h"
+#include "setup/version.h"
 
 #pragma GCC visibility push(default)
 
diff --git a/convert.c b/convert.c
index f71d6dcefd..5490c4a558 100644
--- a/convert.c
+++ b/convert.c
@@ -3,7 +3,7 @@
 
 #include "git-compat-util.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "convert.h"
 #include "copy.h"
 #include "gettext.h"
diff --git a/credential.c b/credential.c
index 2594c0c422..dfbd1e9f74 100644
--- a/credential.c
+++ b/credential.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "config.h"
+#include "setup/config.h"
 #include "credential.h"
 #include "gettext.h"
 #include "string-list.h"
@@ -12,9 +12,9 @@
 #include "sigchain.h"
 #include "strbuf.h"
 #include "urlmatch.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "trace2.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 void credential_init(struct credential *c)
 {
diff --git a/daemon.c b/daemon.c
index 5d7978211c..219eeab179 100644
--- a/daemon.c
+++ b/daemon.c
@@ -2,14 +2,14 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "path.h"
 #include "pkt-line.h"
 #include "protocol.h"
 #include "run-command.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "string-list.h"
 
diff --git a/diagnose.c b/diagnose.c
index 0bac203282..341354ee6d 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -10,7 +10,7 @@
 #include "odb/odb.h"
 #include "pack/packfile.h"
 #include "parse-options.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "write-or-die.h"
 
 struct archive_dir {
diff --git a/diff/combine-diff.c b/diff/combine-diff.c
index 8e03062f39..4446183707 100644
--- a/diff/combine-diff.c
+++ b/diff/combine-diff.c
@@ -7,7 +7,7 @@
 #include "convert.h"
 #include "diff/diff.h"
 #include "diff/diffcore.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "odb/object-name.h"
 #include "quote.h"
diff --git a/diff/diff-lib.c b/diff/diff-lib.c
index 4a932f9067..fa3ca39389 100644
--- a/diff/diff-lib.c
+++ b/diff/diff-lib.c
@@ -18,7 +18,7 @@
 #include "index/cache-tree.h"
 #include "index/unpack-trees.h"
 #include "refs/refs.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "submodule.h"
 #include "index/symlinks.h"
 #include "trace.h"
diff --git a/diff/diff.c b/diff/diff.c
index c00b87cca2..4603493a36 100644
--- a/diff/diff.c
+++ b/diff/diff.c
@@ -8,9 +8,9 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "base85.h"
-#include "config.h"
+#include "setup/config.h"
 #include "convert.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "tempfile.h"
 #include "revision/revision.h"
@@ -43,7 +43,7 @@
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "index/read-cache-ll.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strmap.h"
 #include "ws.h"
 
diff --git a/diff/range-diff.c b/diff/range-diff.c
index 281c043480..80ebfe1114 100644
--- a/diff/range-diff.c
+++ b/diff/range-diff.c
@@ -2,7 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "diff/range-diff.h"
 #include "odb/object-name.h"
@@ -16,7 +16,7 @@
 #include "odb/commit.h"
 #include "pager.h"
 #include "revision/pretty.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "diff/userdiff.h"
 #include "apply.h"
 #include "revision/revision.h"
diff --git a/diff/tree-diff.c b/diff/tree-diff.c
index a34559daa5..30fc2725e7 100644
--- a/diff/tree-diff.c
+++ b/diff/tree-diff.c
@@ -10,7 +10,7 @@
 #include "odb/hash.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "index/dir.h"
 
 /*
diff --git a/diff/userdiff.c b/diff/userdiff.c
index 8993b622c1..63d195e7d7 100644
--- a/diff/userdiff.c
+++ b/diff/userdiff.c
@@ -2,11 +2,11 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "diff/userdiff.h"
 #include "attr.h"
 #include "strbuf.h"
-#include "environment.h"
+#include "setup/environment.h"
 
 static struct userdiff_driver *drivers;
 static int ndrivers;
diff --git a/diff/xdiff-interface.c b/diff/xdiff-interface.c
index 2c87316caa..8b016b327c 100644
--- a/diff/xdiff-interface.c
+++ b/diff/xdiff-interface.c
@@ -1,9 +1,9 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
-#include "config.h"
+#include "setup/config.h"
 #include "hex.h"
 #include "odb/odb.h"
 #include "strbuf.h"
diff --git a/editor.c b/editor.c
index 0d1cb8768d..5c0238eb80 100644
--- a/editor.c
+++ b/editor.c
@@ -3,9 +3,9 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "editor.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "pager.h"
 #include "path.h"
diff --git a/exec-cmd.c b/exec-cmd.c
index 507e67d528..5e0e00fb79 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "path.h"
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index be383367f5..90fee42b50 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -3,7 +3,7 @@
 #include "negotiator/default.h"
 #include "negotiator/skipping.h"
 #include "negotiator/noop.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 void fetch_negotiator_init(struct repository *r,
 			   struct fetch_negotiator *negotiator)
diff --git a/fetch-pack.c b/fetch-pack.c
index d27a28502f..5bc72eb370 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -2,10 +2,10 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "repository.h"
-#include "config.h"
+#include "setup/repository.h"
+#include "setup/config.h"
 #include "date.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -20,7 +20,7 @@
 #include "run-command.h"
 #include "connect.h"
 #include "trace2.h"
-#include "version.h"
+#include "setup/version.h"
 #include "odb/oid-array.h"
 #include "odb/oidset.h"
 #include "pack/packfile.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 4993cc4a02..d38b2b5c8c 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -2,8 +2,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "refs/refs.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
diff --git a/gettext.c b/gettext.c
index 8d08a61f84..7bb4305ad6 100644
--- a/gettext.c
+++ b/gettext.c
@@ -6,7 +6,7 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "utf8.h"
diff --git a/git.c b/git.c
index f01a80867b..693604a598 100644
--- a/git.c
+++ b/git.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "help.h"
@@ -10,9 +10,9 @@
 #include "pager.h"
 #include "index/read-cache-ll.h"
 #include "run-command.h"
-#include "alias.h"
+#include "setup/alias.h"
 #include "odb/replace-object.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "attr.h"
 #include "revision/shallow.h"
 #include "trace.h"
diff --git a/gpg-interface.c b/gpg-interface.c
index 45a922496b..69e99d56c0 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -2,18 +2,18 @@
 
 #include "git-compat-util.h"
 #include "odb/commit.h"
-#include "config.h"
+#include "setup/config.h"
 #include "date.h"
 #include "gettext.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "index/dir.h"
-#include "ident.h"
+#include "setup/ident.h"
 #include "gpg-interface.h"
 #include "path.h"
 #include "sigchain.h"
 #include "tempfile.h"
-#include "alias.h"
+#include "setup/alias.h"
 
 static int git_gpg_config(const char *, const char *,
 			  const struct config_context *, void *);
diff --git a/grep.c b/grep.c
index c4eb18ccd7..9eda692529 100644
--- a/grep.c
+++ b/grep.c
@@ -1,7 +1,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
 #include "grep.h"
 #include "hex.h"
diff --git a/help.c b/help.c
index f7a0950f6c..34ab22ade5 100644
--- a/help.c
+++ b/help.c
@@ -3,7 +3,7 @@
 
 #include "git-compat-util.h"
 #include "git-zlib.h"
-#include "config.h"
+#include "setup/config.h"
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "run-command.h"
@@ -14,13 +14,13 @@
 #include "command-list.h"
 #include "string-list.h"
 #include "column.h"
-#include "version.h"
+#include "setup/version.h"
 #include "refs/refs.h"
 #include "parse-options.h"
 #include "prompt.h"
 #include "index/fsmonitor-ipc.h"
-#include "repository.h"
-#include "alias.h"
+#include "setup/repository.h"
+#include "setup/alias.h"
 #include "utf8.h"
 
 #ifndef NO_CURL
diff --git a/http-backend.c b/http-backend.c
index 57589cc127..dcf8506c1e 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -2,12 +2,12 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "git-zlib.h"
 #include "hex.h"
 #include "path.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "refs/refs.h"
 #include "pkt-line.h"
 #include "odb/object.h"
@@ -16,7 +16,7 @@
 #include "run-command.h"
 #include "string-list.h"
 #include "url.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strvec.h"
 #include "pack/packfile.h"
 #include "odb/odb.h"
diff --git a/http-fetch.c b/http-fetch.c
index 05f68f306a..ad2447ce72 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,13 +1,13 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "http.h"
 #include "walker.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strvec.h"
 #include "url.h"
 #include "urlmatch.h"
diff --git a/http-push.c b/http-push.c
index d45daee9e0..fb18e8756f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,9 +1,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "hex.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
 #include "odb/blob.h"
@@ -12,7 +12,7 @@
 #include "revision/revision.h"
 #include "remote.h"
 #include "revision/list-objects.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "sigchain.h"
 #include "strvec.h"
 #include "odb/tree.h"
diff --git a/http-walker.c b/http-walker.c
index 8df0c5329b..b5bba74da4 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -2,7 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "hex.h"
 #include "walker.h"
 #include "http.h"
diff --git a/http.c b/http.c
index 24a6b30ab3..5b3b2b24d6 100644
--- a/http.c
+++ b/http.c
@@ -3,16 +3,16 @@
 
 #include "git-compat-util.h"
 #include "git-curl-compat.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "http.h"
-#include "config.h"
+#include "setup/config.h"
 #include "pack/pack.h"
 #include "run-command.h"
 #include "url.h"
 #include "urlmatch.h"
 #include "credential.h"
-#include "version.h"
+#include "setup/version.h"
 #include "pkt-line.h"
 #include "gettext.h"
 #include "trace.h"
diff --git a/imap-send.c b/imap-send.c
index 0d16d02029..de244d8011 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -26,13 +26,13 @@
 
 #include "git-compat-util.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "credential.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "run-command.h"
 #include "parse-options.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #ifdef USE_CURL_FOR_IMAP_SEND
 #include "http.h"
diff --git a/index/cache-tree.c b/index/cache-tree.c
index e7c4bfe45c..bb813bd840 100644
--- a/index/cache-tree.c
+++ b/index/cache-tree.c
@@ -13,7 +13,7 @@
 #include "odb/transaction.h"
 #include "index/read-cache-ll.h"
 #include "odb/replace-object.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "promisor-remote.h"
 #include "trace.h"
 #include "trace2.h"
diff --git a/index/checkout.c b/index/checkout.c
index 13d8895032..b262ada8c7 100644
--- a/index/checkout.c
+++ b/index/checkout.c
@@ -4,9 +4,9 @@
 #include "odb/object-name.h"
 #include "remote.h"
 #include "refs/refspec.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "index/checkout.h"
-#include "config.h"
+#include "setup/config.h"
 #include "strbuf.h"
 
 struct tracking_name_data {
diff --git a/index/dir.c b/index/dir.c
index 6f74a3e87c..8eb684c005 100644
--- a/index/dir.c
+++ b/index/dir.c
@@ -11,16 +11,16 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "config.h"
+#include "setup/config.h"
 #include "convert.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "index/name-hash.h"
 #include "odb/object-file.h"
 #include "path.h"
 #include "refs/refs.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "wildmatch.h"
 #include "index/pathspec.h"
 #include "utf8.h"
@@ -28,7 +28,7 @@
 #include "ewah/ewok.h"
 #include "index/fsmonitor-ll.h"
 #include "index/read-cache-ll.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/sparse-index.h"
 #include "strbuf.h"
 #include "submodule-config.h"
diff --git a/index/entry.c b/index/entry.c
index 5b89ad2294..b37c53198f 100644
--- a/index/entry.c
+++ b/index/entry.c
@@ -4,7 +4,7 @@
 #include "odb/odb.h"
 #include "odb/streaming.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "index/name-hash.h"
diff --git a/index/fsmonitor-ipc.c b/index/fsmonitor-ipc.c
index 7c213245a1..68c0148de6 100644
--- a/index/fsmonitor-ipc.c
+++ b/index/fsmonitor-ipc.c
@@ -4,7 +4,7 @@
 #include "gettext.h"
 #include "simple-ipc.h"
 #include "index/fsmonitor-ipc.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "trace2.h"
diff --git a/index/fsmonitor-settings.c b/index/fsmonitor-settings.c
index 883b5902a9..4668dd424e 100644
--- a/index/fsmonitor-settings.c
+++ b/index/fsmonitor-settings.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "index/fsmonitor-ipc.h"
 #include "index/fsmonitor-settings.h"
 #include "index/fsmonitor-path-utils.h"
diff --git a/index/fsmonitor.c b/index/fsmonitor.c
index 606a59d36d..32bc60e44a 100644
--- a/index/fsmonitor.c
+++ b/index/fsmonitor.c
@@ -2,14 +2,14 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "ewah/ewok.h"
 #include "index/fsmonitor.h"
 #include "index/fsmonitor-ipc.h"
 #include "index/name-hash.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "trace2.h"
diff --git a/index/name-hash.c b/index/name-hash.c
index 5d126bc1a3..49c0dd5775 100644
--- a/index/name-hash.c
+++ b/index/name-hash.c
@@ -10,7 +10,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "index/name-hash.h"
 #include "odb/object.h"
diff --git a/index/parallel-checkout.c b/index/parallel-checkout.c
index 971c4b33fa..0905a7ff1e 100644
--- a/index/parallel-checkout.c
+++ b/index/parallel-checkout.c
@@ -2,7 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/entry.h"
 #include "gettext.h"
 #include "odb/hash.h"
diff --git a/index/pathspec.c b/index/pathspec.c
index 7a0c152fb9..fe80ab49d1 100644
--- a/index/pathspec.c
+++ b/index/pathspec.c
@@ -4,13 +4,13 @@
 #include "abspath.h"
 #include "parse.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "index/pathspec.h"
 #include "attr.h"
 #include "index/read-cache.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 #include "strvec.h"
 #include "index/symlinks.h"
 #include "quote.h"
diff --git a/index/preload-index.c b/index/preload-index.c
index eab3bfc602..d2d01ae72d 100644
--- a/index/preload-index.c
+++ b/index/preload-index.c
@@ -7,7 +7,7 @@
 #include "git-compat-util.h"
 #include "index/pathspec.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "index/fsmonitor.h"
 #include "gettext.h"
 #include "parse.h"
@@ -15,10 +15,10 @@
 #include "progress.h"
 #include "index/read-cache.h"
 #include "thread-utils.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "index/symlinks.h"
 #include "trace2.h"
-#include "config.h"
+#include "setup/config.h"
 
 /*
  * Mostly randomly chosen maximum thread counts: we
diff --git a/index/read-cache.c b/index/read-cache.c
index 9c62ae5ee8..20a5e191a4 100644
--- a/index/read-cache.c
+++ b/index/read-cache.c
@@ -8,7 +8,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "date.h"
 #include "diff/diff.h"
 #include "diff/diffcore.h"
@@ -24,7 +24,7 @@
 #include "odb/oid-array.h"
 #include "odb/tree.h"
 #include "odb/commit.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "mem-pool.h"
 #include "index/name-hash.h"
@@ -32,7 +32,7 @@
 #include "path.h"
 #include "index/preload-index.h"
 #include "index/read-cache.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "index/resolve-undo.h"
 #include "revision/revision.h"
 #include "strbuf.h"
@@ -47,7 +47,7 @@
 #include "index/sparse-index.h"
 #include "csum-file.h"
 #include "promisor-remote.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "advice.h"
diff --git a/index/read-cache.h b/index/read-cache.h
index d8519c7b36..69d04e93be 100644
--- a/index/read-cache.h
+++ b/index/read-cache.h
@@ -4,7 +4,7 @@
 #include "index/read-cache-ll.h"
 #include "odb/object.h"
 #include "index/pathspec.h"
-#include "environment.h"
+#include "setup/environment.h"
 
 /*
  * Determine the appropriate index mode for a file based on its stat()
diff --git a/index/sparse-index.c b/index/sparse-index.c
index 0a061a7658..7ac6142023 100644
--- a/index/sparse-index.c
+++ b/index/sparse-index.c
@@ -2,18 +2,18 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "ewah/ewok.h"
 #include "gettext.h"
 #include "index/name-hash.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "index/sparse-index.h"
 #include "odb/tree.h"
 #include "index/pathspec.h"
 #include "trace2.h"
 #include "index/cache-tree.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
 #include "index/fsmonitor-ll.h"
 #include "advice.h"
diff --git a/index/split-index.c b/index/split-index.c
index 02a5b011c5..9835b71f21 100644
--- a/index/split-index.c
+++ b/index/split-index.c
@@ -5,7 +5,7 @@
 #include "odb/hash.h"
 #include "mem-pool.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "index/split-index.h"
 #include "strbuf.h"
 #include "ewah/ewok.h"
diff --git a/index/statinfo.c b/index/statinfo.c
index 4a22923009..5f4d710795 100644
--- a/index/statinfo.c
+++ b/index/statinfo.c
@@ -1,9 +1,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "index/statinfo.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 /*
  * Munge st_size into an unsigned int.
diff --git a/index/symlinks.c b/index/symlinks.c
index 18fadf3f75..ab894f2e05 100644
--- a/index/symlinks.c
+++ b/index/symlinks.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/symlinks.h"
 
 static int threaded_check_leading_path(struct cache_def *cache, const char *name,
diff --git a/index/unpack-trees.c b/index/unpack-trees.c
index 68d85f622e..2eecede699 100644
--- a/index/unpack-trees.c
+++ b/index/unpack-trees.c
@@ -4,10 +4,10 @@
 #include "git-compat-util.h"
 #include "advice.h"
 #include "strvec.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "parse.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "index/name-hash.h"
@@ -30,7 +30,7 @@
 #include "promisor-remote.h"
 #include "index/entry.h"
 #include "index/parallel-checkout.h"
-#include "setup.h"
+#include "setup/setup.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
diff --git a/index/wt-status.c b/index/wt-status.c
index 3381a40e75..847438f121 100644
--- a/index/wt-status.c
+++ b/index/wt-status.c
@@ -8,7 +8,7 @@
 #include "index/dir.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
@@ -17,7 +17,7 @@
 #include "revision/revision.h"
 #include "diff/diffcore.h"
 #include "quote.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "run-command.h"
 #include "strvec.h"
 #include "remote.h"
@@ -25,7 +25,7 @@
 #include "submodule.h"
 #include "column.h"
 #include "index/read-cache.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "trace.h"
 #include "trace2.h"
diff --git a/lockfile.c b/lockfile.c
index 100f603771..942b919941 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -9,7 +9,7 @@
 #include "gettext.h"
 #include "lockfile.h"
 #include "parse.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strbuf.h"
 #include "wrapper.h"
 
diff --git a/mailinfo.c b/mailinfo.c
index 13949ff31e..6c44a6c6c6 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1,8 +1,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex-ll.h"
 #include "utf8.h"
diff --git a/mailmap.c b/mailmap.c
index 558b1972f8..670fb01403 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,11 +1,11 @@
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "string-list.h"
 #include "mailmap.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
-#include "setup.h"
-#include "config.h"
+#include "setup/setup.h"
+#include "setup/config.h"
 
 struct mailmap_info {
 	char *name;
diff --git a/merge-ll.c b/merge-ll.c
index 2aa45bfa90..9cb5119aa2 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -8,7 +8,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "convert.h"
 #include "attr.h"
 #include "diff/xdiff-interface.h"
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index c31ed7028d..227181d105 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -6,7 +6,7 @@
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/tag.h"
 #include "odb/tree.h"
 
diff --git a/merge-ort.c b/merge-ort.c
index 516cd265c5..f101b5e0c4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -26,11 +26,11 @@
 #include "index/cache-tree.h"
 #include "odb/commit.h"
 #include "revision/commit-reach.h"
-#include "config.h"
+#include "setup/config.h"
 #include "diff/diff.h"
 #include "diff/diffcore.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "index/entry.h"
diff --git a/merge.c b/merge.c
index 0fcfc1460f..95a943c477 100644
--- a/merge.c
+++ b/merge.c
@@ -7,7 +7,7 @@
 #include "lockfile.h"
 #include "merge.h"
 #include "odb/commit.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "run-command.h"
 #include "index/resolve-undo.h"
 #include "odb/tree.h"
diff --git a/meson.build b/meson.build
index c61ebc35a6..bad597d8ff 100644
--- a/meson.build
+++ b/meson.build
@@ -311,7 +311,7 @@ libgit_sources = [
   'add-interactive.c',
   'add-patch.c',
   'advice.c',
-  'alias.c',
+  'setup/alias.c',
   'odb/alloc.c',
   'apply.c',
   'archive-tar.c',
@@ -340,7 +340,7 @@ libgit_sources = [
   'common-exit.c',
   'common-init.c',
   'compiler-tricks/not-constant.c',
-  'config.c',
+  'setup/config.c',
   'connect.c',
   'connected.c',
   'convert.c',
@@ -367,7 +367,7 @@ libgit_sources = [
   'index/dir.c',
   'editor.c',
   'index/entry.c',
-  'environment.c',
+  'setup/environment.c',
   'ewah/bitmap.c',
   'ewah/ewah_bitmap.c',
   'ewah/ewah_io.c',
@@ -392,8 +392,8 @@ libgit_sources = [
   'help.c',
   'hex.c',
   'hex-ll.c',
-  'hook.c',
-  'ident.c',
+  'setup/hook.c',
+  'setup/ident.c',
   'json-writer.c',
   'kwset.c',
   'levenshtein.c',
@@ -517,8 +517,8 @@ libgit_sources = [
   'pack/repack-promisor.c',
   'odb/replace-object.c',
   'replay.c',
-  'repo-settings.c',
-  'repository.c',
+  'setup/repo-settings.c',
+  'setup/repository.c',
   'rerere.c',
   'reset.c',
   'index/resolve-undo.c',
@@ -528,7 +528,7 @@ libgit_sources = [
   'sequencer.c',
   'serve.c',
   'pack/server-info.c',
-  'setup.c',
+  'setup/setup.c',
   'revision/shallow.c',
   'sideband.c',
   'sigchain.c',
@@ -575,7 +575,7 @@ libgit_sources = [
   'usage.c',
   'diff/userdiff.c',
   'utf8.c',
-  'version.c',
+  'setup/version.c',
   'versioncmp.c',
   'walker.c',
   'wildmatch.c',
diff --git a/negotiator/default.c b/negotiator/default.c
index 7d67933e06..3211453743 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -6,7 +6,7 @@
 #include "../fetch-negotiator.h"
 #include "../prio-queue.h"
 #include "refs/refs.h"
-#include "../repository.h"
+#include "setup/repository.h"
 #include "odb/tag.h"
 
 /* Remember to update object flag allocation in object.h */
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 9e685f54a1..eabfac6edd 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -7,7 +7,7 @@
 #include "../hex.h"
 #include "../prio-queue.h"
 #include "refs/refs.h"
-#include "../repository.h"
+#include "setup/repository.h"
 #include "odb/tag.h"
 
 /* Remember to update object flag allocation in object.h */
diff --git a/notes-cache.c b/notes-cache.c
index 1e734c5c19..3963f3bf08 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -5,7 +5,7 @@
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "revision/pretty.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/commit.h"
 #include "refs/refs.h"
 #include "strbuf.h"
diff --git a/notes-merge.c b/notes-merge.c
index 2bb6ad735e..67e6da2ebd 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -10,7 +10,7 @@
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "path.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "diff/diff.h"
 #include "diff/diffcore.h"
 #include "hex.h"
diff --git a/notes-utils.c b/notes-utils.c
index 491de7a7ce..62a99fdd4b 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -1,9 +1,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/commit.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "refs/refs.h"
 #include "notes-utils.h"
diff --git a/notes.c b/notes.c
index 5842226c68..87a1cdf542 100644
--- a/notes.c
+++ b/notes.c
@@ -2,8 +2,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "notes.h"
 #include "odb/object-file.h"
diff --git a/odb/alloc.c b/odb/alloc.c
index e0f0146bf8..f261262b6f 100644
--- a/odb/alloc.c
+++ b/odb/alloc.c
@@ -13,7 +13,7 @@
 #include "odb/blob.h"
 #include "odb/tree.h"
 #include "odb/commit.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/tag.h"
 #include "odb/alloc.h"
 
diff --git a/odb/commit.c b/odb/commit.c
index 3b490c760c..83c14e7dc4 100644
--- a/odb/commit.c
+++ b/odb/commit.c
@@ -4,10 +4,10 @@
 #include "odb/tag.h"
 #include "odb/commit.h"
 #include "pack/commit-graph.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "utf8.h"
@@ -24,10 +24,10 @@
 #include "advice.h"
 #include "refs/refs.h"
 #include "revision/commit-reach.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "revision/shallow.h"
 #include "odb/tree.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "parse.h"
 #include "odb/object-file.h"
 #include "odb/object-file-convert.h"
diff --git a/odb/fsck.c b/odb/fsck.c
index e889268b48..ec6c57ef06 100644
--- a/odb/fsck.c
+++ b/odb/fsck.c
@@ -1,11 +1,11 @@
 #include "git-compat-util.h"
 #include "date.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "odb/odb.h"
 #include "path.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/object.h"
 #include "attr.h"
 #include "odb/blob.h"
@@ -20,7 +20,7 @@
 #include "odb/oidset.h"
 #include "pack/packfile.h"
 #include "submodule-config.h"
-#include "config.h"
+#include "setup/config.h"
 #include "help.h"
 
 static ssize_t max_tree_entry_len = 4096;
diff --git a/odb/hash.h b/odb/hash.h
index cf94ad5700..602ca12f28 100644
--- a/odb/hash.h
+++ b/odb/hash.h
@@ -269,7 +269,7 @@ enum get_oid_result {
 };
 
 #ifdef USE_THE_REPOSITORY_VARIABLE
-# include "repository.h"
+# include "setup/repository.h"
 # define the_hash_algo the_repository->hash_algo
 #endif
 
diff --git a/odb/loose.c b/odb/loose.c
index 58af1f7910..d9866de7c7 100644
--- a/odb/loose.c
+++ b/odb/loose.c
@@ -5,7 +5,7 @@
 #include "odb/odb.h"
 #include "odb/source-files.h"
 #include "hex.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "wrapper.h"
 #include "gettext.h"
 #include "odb/loose.h"
diff --git a/odb/match-trees.c b/odb/match-trees.c
index 4062373e11..9672d3d84c 100644
--- a/odb/match-trees.c
+++ b/odb/match-trees.c
@@ -8,7 +8,7 @@
 #include "odb/tree-walk.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 static int score_missing(unsigned mode)
 {
diff --git a/odb/object-file-convert.c b/odb/object-file-convert.c
index cad75963f7..b17574202d 100644
--- a/odb/object-file-convert.c
+++ b/odb/object-file-convert.c
@@ -4,7 +4,7 @@
 #include "gettext.h"
 #include "strbuf.h"
 #include "hex.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/hash.h"
 #include "odb/object.h"
 #include "odb/loose.h"
diff --git a/odb/object-file.c b/odb/object-file.c
index 847b78e5c7..762fedcc8e 100644
--- a/odb/object-file.c
+++ b/odb/object-file.c
@@ -12,7 +12,7 @@
 #include "git-compat-util.h"
 #include "convert.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "odb/fsck.h"
 #include "gettext.h"
 #include "hex.h"
@@ -26,7 +26,7 @@
 #include "pack/packfile.h"
 #include "path.h"
 #include "index/read-cache-ll.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strvec.h"
 #include "tempfile.h"
 #include "odb/tmp-objdir.h"
diff --git a/odb/object-name.c b/odb/object-name.c
index 95a63c7f64..af03d8d0e5 100644
--- a/odb/object-name.c
+++ b/odb/object-name.c
@@ -4,8 +4,8 @@
 #include "git-compat-util.h"
 #include "odb/object-name.h"
 #include "advice.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/tag.h"
@@ -19,9 +19,9 @@
 #include "odb/oid-array.h"
 #include "revision/pretty.h"
 #include "index/read-cache-ll.h"
-#include "repo-settings.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repo-settings.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 #include "pack/midx.h"
 #include "revision/commit-reach.h"
 #include "date.h"
diff --git a/odb/odb.c b/odb/odb.c
index 4e408501e8..f326dbb284 100644
--- a/odb/odb.c
+++ b/odb/odb.c
@@ -1,9 +1,9 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "pack/commit-graph.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "khash.h"
@@ -21,7 +21,7 @@
 #include "quote.h"
 #include "odb/replace-object.h"
 #include "run-command.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "strvec.h"
 #include "submodule.h"
diff --git a/odb/replace-object.c b/odb/replace-object.c
index c69c5aa200..a5b33d27a6 100644
--- a/odb/replace-object.c
+++ b/odb/replace-object.c
@@ -5,7 +5,7 @@
 #include "odb/odb.h"
 #include "odb/replace-object.h"
 #include "refs/refs.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/commit.h"
 
 static int register_replace_ref(const struct reference *ref, void *cb_data)
diff --git a/odb/replace-object.h b/odb/replace-object.h
index d7139028a3..8473817292 100644
--- a/odb/replace-object.h
+++ b/odb/replace-object.h
@@ -2,7 +2,7 @@
 #define REPLACE_OBJECT_H
 
 #include "odb/oidmap.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/odb.h"
 
 struct replace_object {
diff --git a/odb/source-files.c b/odb/source-files.c
index b526e5c219..7b8a21d137 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -2,7 +2,7 @@
 #include "abspath.h"
 #include "odb/blob.h"
 #include "chdir-notify.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
 #include "lockfile.h"
 #include "odb/object-file.h"
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 288b51848e..6c3ada4640 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -4,7 +4,7 @@
 #include "odb/source-inmemory.h"
 #include "odb/streaming.h"
 #include "odb/oidtree.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 struct inmemory_object {
 	enum object_type type;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 2b073d2a22..acf5a15b89 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -12,7 +12,7 @@
 #include "odb/streaming.h"
 #include "odb/oidtree.h"
 #include "path.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strbuf.h"
 #include "tempfile.h"
 #include "write-or-die.h"
diff --git a/odb/streaming.c b/odb/streaming.c
index c3a06f5622..dd33584a64 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -4,8 +4,8 @@
 
 #include "git-compat-util.h"
 #include "convert.h"
-#include "environment.h"
-#include "repository.h"
+#include "setup/environment.h"
+#include "setup/repository.h"
 #include "odb/odb.h"
 #include "odb/source.h"
 #include "odb/streaming.h"
diff --git a/odb/tag.c b/odb/tag.c
index 36cb7732a8..7d74850db3 100644
--- a/odb/tag.c
+++ b/odb/tag.c
@@ -1,7 +1,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "odb/tag.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
@@ -12,7 +12,7 @@
 #include "gpg-interface.h"
 #include "hex.h"
 #include "pack/packfile.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 const char *tag_type = "tag";
 
diff --git a/odb/tmp-objdir.c b/odb/tmp-objdir.c
index 21219e8797..281a25bd6a 100644
--- a/odb/tmp-objdir.c
+++ b/odb/tmp-objdir.c
@@ -3,7 +3,7 @@
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "odb/object-file.h"
 #include "path.h"
 #include "string-list.h"
@@ -12,7 +12,7 @@
 #include "quote.h"
 #include "odb/odb.h"
 #include "odb/source.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 struct tmp_objdir {
 	struct repository *repo;
diff --git a/odb/tree-walk.c b/odb/tree-walk.c
index e3e22e1a32..270913835c 100644
--- a/odb/tree-walk.c
+++ b/odb/tree-walk.c
@@ -11,7 +11,7 @@
 #include "odb/tree.h"
 #include "index/pathspec.h"
 #include "json-writer.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "index/read-cache-ll.h"
 
 static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size, struct strbuf *err)
diff --git a/odb/tree.c b/odb/tree.c
index f1a9779d1a..3bcb9ef191 100644
--- a/odb/tree.c
+++ b/odb/tree.c
@@ -6,8 +6,8 @@
 #include "odb/commit.h"
 #include "odb/alloc.h"
 #include "odb/tree-walk.h"
-#include "repository.h"
-#include "environment.h"
+#include "setup/repository.h"
+#include "setup/environment.h"
 
 const char *tree_type = "tree";
 
diff --git a/organize/organize.c b/organize/organize.c
index f1f0aec6ea..ef4888aab7 100644
--- a/organize/organize.c
+++ b/organize/organize.c
@@ -3,12 +3,12 @@
 #include "gitorganize-format.h"
 #include "labeler-protocol.h"
 #include "organizer-protocol.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
 #include "index/pathspec.h"
 #include "quote.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index e0ef2ef871..bc14cb4304 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "pack/commit-graph.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
diff --git a/oss-fuzz/fuzz-config.c b/oss-fuzz/fuzz-config.c
index 94027f5b97..86048ef9d8 100644
--- a/oss-fuzz/fuzz-config.c
+++ b/oss-fuzz/fuzz-config.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 
 int LLVMFuzzerTestOneInput(const uint8_t *, size_t);
 static int config_parser_callback(const char *, const char *,
diff --git a/pack/bloom.c b/pack/bloom.c
index 3fdbbf3aba..c36ebbf9c5 100644
--- a/pack/bloom.c
+++ b/pack/bloom.c
@@ -10,8 +10,8 @@
 #include "odb/commit-slab.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
-#include "config.h"
-#include "repository.h"
+#include "setup/config.h"
+#include "setup/repository.h"
 
 define_commit_slab(bloom_filter_slab, struct bloom_filter);
 
diff --git a/pack/commit-graph.c b/pack/commit-graph.c
index d5537a9ee8..b060a5a16e 100644
--- a/pack/commit-graph.c
+++ b/pack/commit-graph.c
@@ -1,9 +1,9 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "csum-file.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/pack/delta-islands.c b/pack/delta-islands.c
index 7c48204384..e911354aa1 100644
--- a/pack/delta-islands.c
+++ b/pack/delta-islands.c
@@ -17,7 +17,7 @@
 #include "pack/pack-objects.h"
 #include "pack/delta-islands.h"
 #include "odb/oid-array.h"
-#include "config.h"
+#include "setup/config.h"
 
 KHASH_INIT(str, const char *, void *, 1, kh_str_hash_func, kh_str_hash_equal)
 
diff --git a/pack/midx-write.c b/pack/midx-write.c
index 1d5a6525a6..bd4a200b82 100644
--- a/pack/midx-write.c
+++ b/pack/midx-write.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "config.h"
+#include "setup/config.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "pack/packfile.h"
diff --git a/pack/midx.c b/pack/midx.c
index 76e77d0dd2..e3a67aa45a 100644
--- a/pack/midx.c
+++ b/pack/midx.c
@@ -1,7 +1,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
 #include "hex.h"
 #include "pack/packfile.h"
diff --git a/pack/pack-bitmap-write.c b/pack/pack-bitmap-write.c
index 3b7b41c5d7..1863ff2dd5 100644
--- a/pack/pack-bitmap-write.c
+++ b/pack/pack-bitmap-write.c
@@ -1,7 +1,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/odb.h"
@@ -21,7 +21,7 @@
 #include "odb/tree-walk.h"
 #include "pack/pseudo-merge.h"
 #include "odb/oid-array.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/alloc.h"
 #include "refs/refs.h"
 #include "strmap.h"
diff --git a/pack/pack-bitmap.c b/pack/pack-bitmap.c
index 7cd24a37f5..4851c0d074 100644
--- a/pack/pack-bitmap.c
+++ b/pack/pack-bitmap.c
@@ -15,12 +15,12 @@
 #include "pack/pack-revindex.h"
 #include "pack/pack-objects.h"
 #include "pack/packfile.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "trace2.h"
 #include "odb/odb.h"
 #include "revision/list-objects-filter-options.h"
 #include "pack/midx.h"
-#include "config.h"
+#include "setup/config.h"
 #include "pack/pseudo-merge.h"
 
 /*
diff --git a/pack/pack-check.c b/pack/pack-check.c
index e66ef8f1b7..9123d4da21 100644
--- a/pack/pack-check.c
+++ b/pack/pack-check.c
@@ -1,9 +1,9 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "hex.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "pack/pack.h"
 #include "progress.h"
 #include "pack/packfile.h"
diff --git a/pack/pack-objects.c b/pack/pack-objects.c
index aa1d5bb1c9..b3059f4865 100644
--- a/pack/pack-objects.c
+++ b/pack/pack-objects.c
@@ -4,7 +4,7 @@
 #include "pack/pack-objects.h"
 #include "pack/packfile.h"
 #include "parse.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 static uint32_t locate_object_entry_hash(struct packing_data *pdata,
 					 const struct object_id *oid,
diff --git a/pack/pack-revindex.c b/pack/pack-revindex.c
index 51cf1f82c6..637802f16b 100644
--- a/pack/pack-revindex.c
+++ b/pack/pack-revindex.c
@@ -6,7 +6,7 @@
 #include "strbuf.h"
 #include "trace2.h"
 #include "parse.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "pack/midx.h"
 #include "csum-file.h"
 
diff --git a/pack/pack-write.c b/pack/pack-write.c
index 3ced89d932..45066b9657 100644
--- a/pack/pack-write.c
+++ b/pack/pack-write.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "pack/pack.h"
@@ -11,7 +11,7 @@
 #include "pack/pack-objects.h"
 #include "pack/pack-revindex.h"
 #include "path.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strbuf.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
diff --git a/pack/packfile.c b/pack/packfile.c
index 77de6bb821..9509d6efcb 100644
--- a/pack/packfile.c
+++ b/pack/packfile.c
@@ -1,12 +1,12 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision/list.h"
 #include "pack/pack.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "index/dir.h"
 #include "pack/packfile.h"
 #include "pack/delta.h"
diff --git a/pack/packfile.h b/pack/packfile.h
index 1e6e69fb77..2640288e9b 100644
--- a/pack/packfile.h
+++ b/pack/packfile.h
@@ -8,7 +8,7 @@
 #include "odb/source-packed.h"
 #include "odb/oidset.h"
 #include "pack/packfile-list.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 /* in odb.h */
 struct object_info;
diff --git a/pack/prune-packed.c b/pack/prune-packed.c
index 52473c6bf9..f94fcfebec 100644
--- a/pack/prune-packed.c
+++ b/pack/prune-packed.c
@@ -6,7 +6,7 @@
 #include "pack/packfile.h"
 #include "progress.h"
 #include "pack/prune-packed.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 static struct progress *progress;
 
diff --git a/pack/pseudo-merge.c b/pack/pseudo-merge.c
index 07c6ebea05..a3a0e5b0e9 100644
--- a/pack/pseudo-merge.c
+++ b/pack/pseudo-merge.c
@@ -6,7 +6,7 @@
 #include "date.h"
 #include "odb/oid-array.h"
 #include "strbuf.h"
-#include "config.h"
+#include "setup/config.h"
 #include "string-list.h"
 #include "refs/refs.h"
 #include "pack/pack-bitmap.h"
diff --git a/pack/reachable.c b/pack/reachable.c
index 5b8a2a4f79..4c35f26119 100644
--- a/pack/reachable.c
+++ b/pack/reachable.c
@@ -17,7 +17,7 @@
 #include "odb/object-file.h"
 #include "pack/pack-bitmap.h"
 #include "pack/pack-mtimes.h"
-#include "config.h"
+#include "setup/config.h"
 #include "run-command.h"
 #include "sequencer.h"
 
diff --git a/pack/repack-cruft.c b/pack/repack-cruft.c
index 0f49a59ca7..fc05d13955 100644
--- a/pack/repack-cruft.c
+++ b/pack/repack-cruft.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "pack/repack.h"
 #include "pack/packfile.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "run-command.h"
 
 static void combine_small_cruft_packs(FILE *in, off_t combine_cruft_below_size,
diff --git a/pack/repack-filtered.c b/pack/repack-filtered.c
index 2a77018951..a590533bf5 100644
--- a/pack/repack-filtered.c
+++ b/pack/repack-filtered.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "pack/repack.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "run-command.h"
 #include "string-list.h"
 
diff --git a/pack/repack-geometry.c b/pack/repack-geometry.c
index 1ae2e8be9f..0771905997 100644
--- a/pack/repack-geometry.c
+++ b/pack/repack-geometry.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "pack/repack.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "hex.h"
 #include "pack/midx.h"
 #include "pack/packfile.h"
diff --git a/pack/repack-promisor.c b/pack/repack-promisor.c
index 628903244c..f1538a5365 100644
--- a/pack/repack-promisor.c
+++ b/pack/repack-promisor.c
@@ -4,7 +4,7 @@
 #include "pack/pack.h"
 #include "pack/packfile.h"
 #include "path.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "run-command.h"
 
 struct write_oid_context {
diff --git a/pack/repack.c b/pack/repack.c
index 52e7779a44..7c115c30fc 100644
--- a/pack/repack.c
+++ b/pack/repack.c
@@ -5,7 +5,7 @@
 #include "pack/packfile.h"
 #include "path.h"
 #include "pack/repack.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "run-command.h"
 #include "tempfile.h"
 
diff --git a/pack/server-info.c b/pack/server-info.c
index dbd86d6fd2..ecaaa25e9d 100644
--- a/pack/server-info.c
+++ b/pack/server-info.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "index/dir.h"
 #include "hex.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "refs/refs.h"
 #include "odb/object.h"
 #include "odb/commit.h"
diff --git a/pager.c b/pager.c
index 543ef12936..add45ef679 100644
--- a/pager.c
+++ b/pager.c
@@ -1,12 +1,12 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "editor.h"
 #include "pager.h"
 #include "run-command.h"
 #include "sigchain.h"
-#include "alias.h"
-#include "repository.h"
-#include "environment.h"
+#include "setup/alias.h"
+#include "setup/repository.h"
+#include "setup/environment.h"
 
 int pager_use_color = 1;
 
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 7826b8ad43..ba587028d7 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -6,10 +6,10 @@
 #include "odb/commit.h"
 #include "color.h"
 #include "date.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/object-name.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "odb/oid-array.h"
diff --git a/path-walk.c b/path-walk.c
index 00686d3dbf..e99e43f95a 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -16,7 +16,7 @@
 #include "odb/oid-array.h"
 #include "path.h"
 #include "prio-queue.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "revision/revision.h"
 #include "string-list.h"
 #include "strmap.h"
diff --git a/path.c b/path.c
index e4d489e10a..1ae08c384b 100644
--- a/path.c
+++ b/path.c
@@ -5,12 +5,12 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "gettext.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "index/dir.h"
 #include "refs/worktree.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "submodule-config.h"
 #include "path.h"
 #include "pack/packfile.h"
diff --git a/path.h b/path.h
index 7e7408dd05..36711c6647 100644
--- a/path.h
+++ b/path.h
@@ -294,7 +294,7 @@ void format_path(struct strbuf *dest, const char *path,
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
-#  include "repository.h"
+#  include "setup/repository.h"
 
 #define GIT_PATH_FUNC(func, filename) \
 	const char *func(void) \
diff --git a/progress.c b/progress.c
index 8315bdc3d4..3faea369df 100644
--- a/progress.c
+++ b/progress.c
@@ -14,7 +14,7 @@
 #include "git-compat-util.h"
 #include "pager.h"
 #include "progress.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strbuf.h"
 #include "trace.h"
 #include "trace2.h"
diff --git a/promisor-remote.c b/promisor-remote.c
index da6b1225dd..80caaeca99 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -5,15 +5,15 @@
 #include "hex.h"
 #include "odb/odb.h"
 #include "promisor-remote.h"
-#include "config.h"
+#include "setup/config.h"
 #include "trace2.h"
 #include "transport.h"
 #include "strvec.h"
 #include "pack/packfile.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "url.h"
 #include "urlmatch.h"
-#include "version.h"
+#include "setup/version.h"
 #include "wildmatch.h"
 
 struct promisor_remote_config {
diff --git a/promisor-remote.h b/promisor-remote.h
index 301f5ac5cb..9adca948f9 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -1,7 +1,7 @@
 #ifndef PROMISOR_REMOTE_H
 #define PROMISOR_REMOTE_H
 
-#include "repository.h"
+#include "setup/repository.h"
 
 struct object_id;
 
diff --git a/prompt.c b/prompt.c
index d8d74c7e37..36f24790f1 100644
--- a/prompt.c
+++ b/prompt.c
@@ -2,8 +2,8 @@
 
 #include "git-compat-util.h"
 #include "parse.h"
-#include "environment.h"
-#include "repository.h"
+#include "setup/environment.h"
+#include "setup/repository.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "prompt.h"
diff --git a/protocol-caps.c b/protocol-caps.c
index edac5dbd05..ffda7e11dd 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -6,7 +6,7 @@
 #include "odb/hash.h"
 #include "odb/object.h"
 #include "odb/odb.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "string-list.h"
 #include "strbuf.h"
 
diff --git a/protocol.c b/protocol.c
index a3e26a8dd3..7f19dbc04d 100644
--- a/protocol.c
+++ b/protocol.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "protocol.h"
 #include "trace2.h"
 
diff --git a/rebase-interactive.c b/rebase-interactive.c
index ee2ef8b535..f328910af4 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -3,14 +3,14 @@
 #include "git-compat-util.h"
 #include "odb/commit.h"
 #include "editor.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "sequencer.h"
 #include "rebase-interactive.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strbuf.h"
 #include "odb/commit-slab.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
 #include "odb/object-name.h"
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e6e07938a3..22aaa69a23 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2,26 +2,26 @@
 
 #include "../git-compat-util.h"
 #include "../abspath.h"
-#include "../config.h"
+#include "setup/config.h"
 #include "../copy.h"
-#include "../environment.h"
+#include "setup/environment.h"
 #include "../gettext.h"
 #include "odb/hash.h"
 #include "../hex.h"
 #include "odb/fsck.h"
 #include "refs/refs.h"
-#include "../repo-settings.h"
+#include "setup/repo-settings.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
 #include "packed-backend.h"
-#include "../ident.h"
+#include "setup/ident.h"
 #include "../iterator.h"
 #include "index/dir-iterator.h"
 #include "../lockfile.h"
 #include "../path.h"
 #include "index/dir.h"
 #include "../chdir-notify.h"
-#include "../setup.h"
+#include "setup/setup.h"
 #include "refs/worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
diff --git a/refs/ls-refs.c b/refs/ls-refs.c
index 75b9b5e620..03ab2720e9 100644
--- a/refs/ls-refs.c
+++ b/refs/ls-refs.c
@@ -1,16 +1,16 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "refs/refs.h"
 #include "strvec.h"
 #include "refs/ls-refs.h"
 #include "pkt-line.h"
-#include "config.h"
+#include "setup/config.h"
 #include "string-list.h"
 
 static enum {
diff --git a/refs/pack-refs.c b/refs/pack-refs.c
index d6c41d64f1..cf586ddf36 100644
--- a/refs/pack-refs.c
+++ b/refs/pack-refs.c
@@ -1,6 +1,6 @@
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "refs/pack-refs.h"
 #include "parse-options.h"
 #include "refs/refs.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 97f76c1d76..88fac2f868 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,7 +1,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "../git-compat-util.h"
-#include "../config.h"
+#include "setup/config.h"
 #include "index/dir.h"
 #include "odb/fsck.h"
 #include "../gettext.h"
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 3599199b8e..e06d56bce5 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -1,7 +1,7 @@
 #include "../git-compat-util.h"
 #include "odb/hash.h"
 #include "refs/refs.h"
-#include "../repository.h"
+#include "setup/repository.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
 #include "../iterator.h"
diff --git a/refs/ref-filter.c b/refs/ref-filter.c
index 32027789a8..9a426b6ce9 100644
--- a/refs/ref-filter.c
+++ b/refs/ref-filter.c
@@ -2,9 +2,9 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gpg-interface.h"
 #include "hex.h"
 #include "parse-options.h"
@@ -14,11 +14,11 @@
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "odb/oid-array.h"
-#include "repo-settings.h"
-#include "repository.h"
+#include "setup/repo-settings.h"
+#include "setup/repository.h"
 #include "odb/commit.h"
 #include "mailmap.h"
-#include "ident.h"
+#include "setup/ident.h"
 #include "remote.h"
 #include "color.h"
 #include "odb/tag.h"
diff --git a/refs/reflog-walk.c b/refs/reflog-walk.c
index 4c321fb3a8..8157b7fb0b 100644
--- a/refs/reflog-walk.c
+++ b/refs/reflog-walk.c
@@ -4,7 +4,7 @@
 #include "odb/commit.h"
 #include "refs/refs.h"
 #include "diff/diff.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "revision/revision.h"
 #include "string-list.h"
 #include "refs/reflog-walk.h"
diff --git a/refs/reflog.c b/refs/reflog.c
index 1050ae6301..cdd8bcf6fd 100644
--- a/refs/reflog.c
+++ b/refs/reflog.c
@@ -2,8 +2,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "odb/odb.h"
diff --git a/refs/refs.c b/refs/refs.c
index 2bc9c3cecd..2cafa50349 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -5,8 +5,8 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "strmap.h"
 #include "gettext.h"
 #include "hex.h"
@@ -14,7 +14,7 @@
 #include "iterator.h"
 #include "refs/refs.h"
 #include "refs/refs-internal.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "odb/object.h"
@@ -22,12 +22,12 @@
 #include "submodule.h"
 #include "refs/worktree.h"
 #include "strvec.h"
-#include "repo-settings.h"
-#include "setup.h"
+#include "setup/repo-settings.h"
+#include "setup/setup.h"
 #include "date.h"
 #include "odb/commit.h"
 #include "wildmatch.h"
-#include "ident.h"
+#include "setup/ident.h"
 #include "odb/fsck.h"
 
 /*
diff --git a/refs/refs.h b/refs/refs.h
index 1746d1035c..03d145deb7 100644
--- a/refs/refs.h
+++ b/refs/refs.h
@@ -3,8 +3,8 @@
 
 #include "odb/object-name.h"
 #include "odb/commit.h"
-#include "repository.h"
-#include "repo-settings.h"
+#include "setup/repository.h"
+#include "setup/repo-settings.h"
 
 struct fsck_options;
 struct object_id;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 0c02b2d287..932e91fe8a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1,14 +1,14 @@
 #include "../git-compat-util.h"
 #include "../abspath.h"
 #include "../chdir-notify.h"
-#include "../config.h"
+#include "setup/config.h"
 #include "index/dir.h"
-#include "../environment.h"
+#include "setup/environment.h"
 #include "odb/fsck.h"
 #include "../gettext.h"
 #include "odb/hash.h"
 #include "../hex.h"
-#include "../ident.h"
+#include "setup/ident.h"
 #include "../iterator.h"
 #include "../parse.h"
 #include "../path.h"
@@ -19,8 +19,8 @@
 #include "../reftable/reftable-iterator.h"
 #include "../reftable/reftable-record.h"
 #include "../reftable/reftable-stack.h"
-#include "../repo-settings.h"
-#include "../setup.h"
+#include "setup/repo-settings.h"
+#include "setup/setup.h"
 #include "../strmap.h"
 #include "../trace2.h"
 #include "refs/worktree.h"
diff --git a/refs/worktree.c b/refs/worktree.c
index 0f1fe6a7d2..63a7251c47 100644
--- a/refs/worktree.c
+++ b/refs/worktree.c
@@ -2,17 +2,17 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "path.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "refs/refs.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "refs/worktree.h"
 #include "index/dir.h"
 #include "index/wt-status.h"
-#include "config.h"
+#include "setup/config.h"
 
 void free_worktree(struct worktree *worktree)
 {
diff --git a/remote-curl.c b/remote-curl.c
index a6a145c046..d0aa42c974 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -3,8 +3,8 @@
 
 #include "git-compat-util.h"
 #include "git-curl-compat.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "remote.h"
@@ -19,7 +19,7 @@
 #include "credential.h"
 #include "odb/oid-array.h"
 #include "send-pack.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "protocol.h"
 #include "quote.h"
 #include "trace2.h"
diff --git a/remote.c b/remote.c
index 2b376893b3..ae77c5b1db 100644
--- a/remote.c
+++ b/remote.c
@@ -3,8 +3,8 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "remote.h"
@@ -19,7 +19,7 @@
 #include "diff/diff.h"
 #include "revision/revision.h"
 #include "index/dir.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "revision/commit-reach.h"
diff --git a/replay.c b/replay.c
index 6922a1f137..97ef099650 100644
--- a/replay.c
+++ b/replay.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "merge-ort.h"
 #include "odb/object-name.h"
diff --git a/rerere.c b/rerere.c
index df30ebbe93..bd6e452036 100644
--- a/rerere.c
+++ b/rerere.c
@@ -3,9 +3,9 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "config.h"
+#include "setup/config.h"
 #include "copy.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/reset.c b/reset.c
index 0eddc94d8c..8155336712 100644
--- a/reset.c
+++ b/reset.c
@@ -9,7 +9,7 @@
 #include "odb/tree-walk.h"
 #include "odb/tree.h"
 #include "index/unpack-trees.h"
-#include "hook.h"
+#include "setup/hook.h"
 
 static int update_refs(struct repository *repo,
 		       const struct reset_working_tree_options *opts,
diff --git a/reset.h b/reset.h
index 52055ad68d..09179ece6d 100644
--- a/reset.h
+++ b/reset.h
@@ -2,7 +2,7 @@
 #define RESET_H
 
 #include "odb/hash.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
 
diff --git a/revision/bisect.c b/revision/bisect.c
index 7805872c3e..7949d74e14 100644
--- a/revision/bisect.c
+++ b/revision/bisect.c
@@ -2,10 +2,10 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision/revision.h"
diff --git a/revision/blame.c b/revision/blame.c
index a75bf22193..11e3dd63ff 100644
--- a/revision/blame.c
+++ b/revision/blame.c
@@ -15,7 +15,7 @@
 #include "path.h"
 #include "index/read-cache.h"
 #include "revision/revision.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "odb/tag.h"
 #include "trace2.h"
 #include "revision/blame.h"
diff --git a/revision/graph.c b/revision/graph.c
index c6f10398a2..9524af5010 100644
--- a/revision/graph.c
+++ b/revision/graph.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/commit.h"
 #include "color.h"
 #include "revision/graph.h"
diff --git a/revision/line-log.c b/revision/line-log.c
index 3da7af2340..97fe28d3ef 100644
--- a/revision/line-log.c
+++ b/revision/line-log.c
@@ -9,12 +9,12 @@
 #include "diff/diff.h"
 #include "odb/commit.h"
 #include "revision/decorate.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "revision/revision.h"
 #include "diff/xdiff-interface.h"
 #include "strbuf.h"
 #include "revision/line-log.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strvec.h"
 #include "pack/bloom.h"
 #include "odb/tree-walk.h"
diff --git a/revision/list-objects-filter-options.c b/revision/list-objects-filter-options.c
index 6730808896..38604a580c 100644
--- a/revision/list-objects-filter-options.c
+++ b/revision/list-objects-filter-options.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
 #include "revision/list-objects-filter-options.h"
 #include "promisor-remote.h"
diff --git a/revision/list-objects.c b/revision/list-objects.c
index fdf98b629f..8544ff2a2a 100644
--- a/revision/list-objects.c
+++ b/revision/list-objects.c
@@ -16,7 +16,7 @@
 #include "pack/packfile.h"
 #include "odb/odb.h"
 #include "trace.h"
-#include "environment.h"
+#include "setup/environment.h"
 
 struct traversal_context {
 	struct rev_info *revs;
diff --git a/revision/log-tree.c b/revision/log-tree.c
index e555d07072..679dd21806 100644
--- a/revision/log-tree.c
+++ b/revision/log-tree.c
@@ -4,14 +4,14 @@
 #include "git-compat-util.h"
 #include "revision/commit-reach.h"
 #include "odb/commit-slab.h"
-#include "config.h"
+#include "setup/config.h"
 #include "diff/diff.h"
 #include "diff/diffcore.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "odb/object-name.h"
 #include "odb/object-file.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/tmp-objdir.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
diff --git a/revision/pretty.c b/revision/pretty.c
index cdf63ded49..7925bea766 100644
--- a/revision/pretty.c
+++ b/revision/pretty.c
@@ -2,9 +2,9 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/commit.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
diff --git a/revision/revision.c b/revision/revision.c
index 97c6fa6fef..7470333ae6 100644
--- a/revision/revision.c
+++ b/revision/revision.c
@@ -2,8 +2,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-name.h"
@@ -18,7 +18,7 @@
 #include "diff/diff-merges.h"
 #include "refs/refs.h"
 #include "revision/revision.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "revision/graph.h"
 #include "grep.h"
 #include "refs/reflog-walk.h"
@@ -35,7 +35,7 @@
 #include "refs/worktree.h"
 #include "path.h"
 #include "index/read-cache.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "index/sparse-index.h"
 #include "strvec.h"
 #include "trace2.h"
diff --git a/revision/revision.h b/revision/revision.h
index 9cb9419b22..5a894e27a4 100644
--- a/revision/revision.h
+++ b/revision/revision.h
@@ -10,7 +10,7 @@
 #include "diff/diff.h"
 #include "odb/commit-slab-decl.h"
 #include "revision/decorate.h"
-#include "ident.h"
+#include "setup/ident.h"
 #include "revision/list-objects-filter-options.h"
 #include "prio-queue.h"
 #include "strvec.h"
diff --git a/revision/shallow.c b/revision/shallow.c
index f4ce207278..a6e8a66c14 100644
--- a/revision/shallow.c
+++ b/revision/shallow.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "hex.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "tempfile.h"
 #include "lockfile.h"
 #include "odb/odb.h"
diff --git a/revision/shallow.h b/revision/shallow.h
index 0cb1d5ba70..60b283c9d5 100644
--- a/revision/shallow.h
+++ b/revision/shallow.h
@@ -4,7 +4,7 @@
 #include "odb/commit.h"
 #include "lockfile.h"
 #include "odb/object.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strbuf.h"
 
 struct oid_array;
diff --git a/run-command.c b/run-command.c
index 80382354dc..83702c99f1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "run-command.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "sigchain.h"
@@ -14,7 +14,7 @@
 #include "trace.h"
 #include "trace2.h"
 #include "quote.h"
-#include "config.h"
+#include "setup/config.h"
 #include "pack/packfile.h"
 #include "compat/nonblock.h"
 
diff --git a/scalar.c b/scalar.c
index d1e397ef50..17468d1332 100644
--- a/scalar.c
+++ b/scalar.c
@@ -8,7 +8,7 @@
 #include "abspath.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "config.h"
+#include "setup/config.h"
 #include "run-command.h"
 #include "simple-ipc.h"
 #include "index/fsmonitor-ipc.h"
@@ -17,7 +17,7 @@
 #include "index/dir.h"
 #include "pack/packfile.h"
 #include "help.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "trace2.h"
 #include "path.h"
 
diff --git a/send-pack.c b/send-pack.c
index f59686f971..546835b0aa 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/commit.h"
 #include "date.h"
 #include "gettext.h"
@@ -12,7 +12,7 @@
 #include "connect.h"
 #include "send-pack.h"
 #include "transport.h"
-#include "version.h"
+#include "setup/version.h"
 #include "odb/oid-array.h"
 #include "gpg-interface.h"
 #include "revision/shallow.h"
diff --git a/sequencer.c b/sequencer.c
index f4a0f77eaf..1dd0c6af95 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4,9 +4,9 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
-#include "config.h"
+#include "setup/config.h"
 #include "copy.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -19,7 +19,7 @@
 #include "odb/commit.h"
 #include "sequencer.h"
 #include "run-command.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "utf8.h"
 #include "index/cache-tree.h"
 #include "diff/diff.h"
@@ -43,7 +43,7 @@
 #include "odb/oidmap.h"
 #include "odb/oidset.h"
 #include "odb/commit-slab.h"
-#include "alias.h"
+#include "setup/alias.h"
 #include "revision/commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
diff --git a/serve.c b/serve.c
index df3086fb3a..4408187c47 100644
--- a/serve.c
+++ b/serve.c
@@ -1,9 +1,9 @@
 #include "git-compat-util.h"
-#include "repository.h"
-#include "config.h"
+#include "setup/repository.h"
+#include "setup/config.h"
 #include "odb/hash.h"
 #include "pkt-line.h"
-#include "version.h"
+#include "setup/version.h"
 #include "refs/ls-refs.h"
 #include "protocol-caps.h"
 #include "serve.h"
diff --git a/alias.c b/setup/alias.c
similarity index 98%
rename from alias.c
rename to setup/alias.c
index e737c49edd..c6939bd88e 100644
--- a/alias.c
+++ b/setup/alias.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "alias.h"
-#include "config.h"
+#include "setup/alias.h"
+#include "setup/config.h"
 #include "gettext.h"
 #include "strbuf.h"
 #include "string-list.h"
diff --git a/alias.h b/setup/alias.h
similarity index 100%
rename from alias.h
rename to setup/alias.h
diff --git a/config.c b/setup/config.c
similarity index 99%
rename from config.c
rename to setup/config.c
index 59c6029654..3f26a8beda 100644
--- a/config.c
+++ b/setup/config.c
@@ -11,14 +11,14 @@
 #include "advice.h"
 #include "date.h"
 #include "branch.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
 #include "parse.h"
 #include "convert.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "git-zlib.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
 #include "strbuf.h"
@@ -31,7 +31,7 @@
 #include "utf8.h"
 #include "color.h"
 #include "refs/refs.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strvec.h"
 #include "trace2.h"
 #include "wildmatch.h"
diff --git a/config.h b/setup/config.h
similarity index 99%
rename from config.h
rename to setup/config.h
index 31fe3e2961..44aba10ce1 100644
--- a/config.h
+++ b/setup/config.h
@@ -3,7 +3,7 @@
 
 #include "hashmap.h"
 #include "string-list.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "parse.h"
 
 /**
diff --git a/environment.c b/setup/environment.c
similarity index 99%
rename from environment.c
rename to setup/environment.c
index 6066417b62..0b135d4d8d 100644
--- a/environment.c
+++ b/setup/environment.c
@@ -17,15 +17,15 @@
 #include "branch.h"
 #include "color.h"
 #include "convert.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "git-zlib.h"
-#include "ident.h"
+#include "setup/ident.h"
 #include "lockfile.h"
 #include "mailmap.h"
 #include "odb/object-name.h"
-#include "repository.h"
-#include "config.h"
+#include "setup/repository.h"
+#include "setup/config.h"
 #include "refs/refs.h"
 #include "fmt-merge-msg.h"
 #include "odb/commit.h"
@@ -34,7 +34,7 @@
 #include "path.h"
 #include "quote.h"
 #include "chdir-notify.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "ws.h"
 #include "write-or-die.h"
 
diff --git a/environment.h b/setup/environment.h
similarity index 99%
rename from environment.h
rename to setup/environment.h
index e7ec5b0437..ba8004e179 100644
--- a/environment.h
+++ b/setup/environment.h
@@ -1,7 +1,7 @@
 #ifndef ENVIRONMENT_H
 #define ENVIRONMENT_H
 
-#include "repo-settings.h"
+#include "setup/repo-settings.h"
 #include "branch.h"
 
 /* Double-check local_repo_env below if you add to this list. */
diff --git a/hook.c b/setup/hook.c
similarity index 99%
rename from hook.c
rename to setup/hook.c
index d10eef4763..e4cfca5fa5 100644
--- a/hook.c
+++ b/setup/hook.c
@@ -1,15 +1,15 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "hook-list.h"
 #include "parse.h"
 #include "path.h"
 #include "run-command.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "strmap.h"
 #include "thread-utils.h"
diff --git a/hook.h b/setup/hook.h
similarity index 99%
rename from hook.h
rename to setup/hook.h
index 27bb1aeb2e..f5ca5364cc 100644
--- a/hook.h
+++ b/setup/hook.h
@@ -1,6 +1,6 @@
 #ifndef HOOK_H
 #define HOOK_H
-#include "config.h"
+#include "setup/config.h"
 #include "run-command.h"
 #include "string-list.h"
 #include "strmap.h"
diff --git a/ident.c b/setup/ident.c
similarity index 99%
rename from ident.c
rename to setup/ident.c
index 0b7aacecd7..27e620fdf4 100644
--- a/ident.c
+++ b/setup/ident.c
@@ -6,8 +6,8 @@
  * Copyright (C) 2005 Linus Torvalds
  */
 #include "git-compat-util.h"
-#include "ident.h"
-#include "config.h"
+#include "setup/ident.h"
+#include "setup/config.h"
 #include "date.h"
 #include "gettext.h"
 #include "mailmap.h"
diff --git a/ident.h b/setup/ident.h
similarity index 100%
rename from ident.h
rename to setup/ident.h
diff --git a/repo-settings.c b/setup/repo-settings.c
similarity index 98%
rename from repo-settings.c
rename to setup/repo-settings.c
index f40d1436a9..3c71eb6fc6 100644
--- a/repo-settings.c
+++ b/setup/repo-settings.c
@@ -1,10 +1,10 @@
 #include "git-compat-util.h"
-#include "config.h"
-#include "repo-settings.h"
-#include "repository.h"
+#include "setup/config.h"
+#include "setup/repo-settings.h"
+#include "setup/repository.h"
 #include "pack/midx.h"
 #include "pack/pack-objects.h"
-#include "setup.h"
+#include "setup/setup.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 			  int def)
diff --git a/repo-settings.h b/setup/repo-settings.h
similarity index 100%
rename from repo-settings.h
rename to setup/repo-settings.h
diff --git a/repository.c b/setup/repository.c
similarity index 99%
rename from repository.c
rename to setup/repository.c
index 8771145515..77be866c82 100644
--- a/repository.c
+++ b/setup/repository.c
@@ -1,17 +1,17 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "repository.h"
-#include "hook.h"
+#include "setup/repository.h"
+#include "setup/hook.h"
 #include "odb/odb.h"
 #include "odb/source.h"
-#include "config.h"
+#include "setup/config.h"
 #include "gettext.h"
 #include "odb/object.h"
 #include "lockfile.h"
 #include "path.h"
 #include "index/read-cache-ll.h"
 #include "remote.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "odb/loose.h"
 #include "submodule-config.h"
 #include "index/sparse-index.h"
diff --git a/repository.h b/setup/repository.h
similarity index 99%
rename from repository.h
rename to setup/repository.h
index 3b467a2513..3157f56e9c 100644
--- a/repository.h
+++ b/setup/repository.h
@@ -3,8 +3,8 @@
 
 #include "strmap.h"
 #include "string-list.h"
-#include "repo-settings.h"
-#include "environment.h"
+#include "setup/repo-settings.h"
+#include "setup/environment.h"
 
 struct config_set;
 struct git_hash_algo;
diff --git a/setup.c b/setup/setup.c
similarity index 99%
rename from setup.c
rename to setup/setup.c
index e4e9ca83fe..e71fa7b118 100644
--- a/setup.c
+++ b/setup/setup.c
@@ -3,17 +3,17 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "copy.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "refs/refs.h"
-#include "repository.h"
-#include "config.h"
+#include "setup/repository.h"
+#include "setup/config.h"
 #include "index/dir.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "revision/shallow.h"
 #include "string-list.h"
 #include "strvec.h"
diff --git a/setup.h b/setup/setup.h
similarity index 100%
rename from setup.h
rename to setup/setup.h
diff --git a/version.c b/setup/version.c
similarity index 98%
rename from version.c
rename to setup/version.c
index 21ec7c0fbe..c4a55edb5c 100644
--- a/version.c
+++ b/setup/version.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "version.h"
+#include "setup/version.h"
 #include "strbuf.h"
 #include "gettext.h"
 
diff --git a/version.h b/setup/version.h
similarity index 100%
rename from version.h
rename to setup/version.h
diff --git a/shell.c b/shell.c
index 76333c8068..4e7f8e43c0 100644
--- a/shell.c
+++ b/shell.c
@@ -3,7 +3,7 @@
 #include "exec-cmd.h"
 #include "strbuf.h"
 #include "run-command.h"
-#include "alias.h"
+#include "setup/alias.h"
 
 #define COMMAND_DIR "git-shell-commands"
 #define HELP_COMMAND COMMAND_DIR "/help"
diff --git a/sideband.c b/sideband.c
index 374187402e..b915fdf114 100644
--- a/sideband.c
+++ b/sideband.c
@@ -3,7 +3,7 @@
 
 #include "git-compat-util.h"
 #include "color.h"
-#include "config.h"
+#include "setup/config.h"
 #include "editor.h"
 #include "gettext.h"
 #include "sideband.h"
diff --git a/submodule-config.c b/submodule-config.c
index c8be0acbb1..334cfb54ee 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -3,12 +3,12 @@
 
 #include "git-compat-util.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "path.h"
-#include "repository.h"
-#include "config.h"
+#include "setup/repository.h"
+#include "setup/config.h"
 #include "submodule-config.h"
 #include "submodule.h"
 #include "strbuf.h"
diff --git a/submodule-config.h b/submodule-config.h
index 3f4f0bf454..b1d075a754 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -1,7 +1,7 @@
 #ifndef SUBMODULE_CONFIG_CACHE_H
 #define SUBMODULE_CONFIG_CACHE_H
 
-#include "config.h"
+#include "setup/config.h"
 #include "submodule.h"
 #include "odb/tree-walk.h"
 
diff --git a/submodule.c b/submodule.c
index e14b53d3c8..16b3ffbcc6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -3,14 +3,14 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "repository.h"
-#include "config.h"
+#include "setup/repository.h"
+#include "setup/config.h"
 #include "submodule-config.h"
 #include "submodule.h"
 #include "index/dir.h"
 #include "diff/diff.h"
 #include "odb/commit.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision/revision.h"
@@ -30,7 +30,7 @@
 #include "odb/odb.h"
 #include "revision/commit-reach.h"
 #include "index/read-cache-ll.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "advice.h"
 #include "url.h"
 
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index 8f9db2693e..1f4a67bb65 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -2,9 +2,9 @@
 
 #include "test-tool.h"
 #include "advice.h"
-#include "config.h"
-#include "environment.h"
-#include "setup.h"
+#include "setup/config.h"
+#include "setup/environment.h"
+#include "setup/setup.h"
 
 int cmd__advise_if_enabled(int argc, const char **argv)
 {
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 59beba76d2..40bf0c790f 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -6,7 +6,7 @@
 #include "odb/odb.h"
 #include "pack/pack-bitmap.h"
 #include "pack/pseudo-merge.h"
-#include "setup.h"
+#include "setup/setup.h"
 
 static int bitmap_list_commits(void)
 {
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 5c469af08d..0be36ac656 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -4,8 +4,8 @@
 #include "pack/bloom.h"
 #include "hex.h"
 #include "odb/commit.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 
 static struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index cf7e7efc5d..bbdedf44dd 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -8,8 +8,8 @@
 #include "index/cache-tree.h"
 #include "parse-options.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 
 static char const * const test_cache_tree_usage[] = {
 	N_("test-tool cache-tree <options> (control|prime|update)"),
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index cfb3f4b111..8d5a7af0b4 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -2,8 +2,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
-#include "config.h"
-#include "setup.h"
+#include "setup/config.h"
+#include "setup/setup.h"
 #include "string-list.h"
 
 /*
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 599b316ac1..251aea165d 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -6,8 +6,8 @@
 #include "odb/tree.h"
 #include "index/cache-tree.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 
 static void dump_one(struct cache_tree *it, const char *pfx, const char *x)
 {
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 1dbdb28fbf..adcb90bd3a 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -2,8 +2,8 @@
 
 #include "test-tool.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 
 int cmd__dump_fsmonitor(int ac UNUSED, const char **av UNUSED)
 {
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index 79c8628005..f3013bba91 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -3,8 +3,8 @@
 #include "test-tool.h"
 #include "hex.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 #include "index/split-index.h"
 #include "ewah/ewok.h"
 
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index c31d01f3b5..8fc213e26a 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -4,8 +4,8 @@
 #include "index/dir.h"
 #include "hex.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 
 static int compare_untracked(const void *a_, const void *b_)
 {
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index 216e7abb9a..def817ba1b 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -5,7 +5,7 @@
 #include "odb/odb.h"
 #include "pack/packfile.h"
 #include "parse-options.h"
-#include "setup.h"
+#include "setup/setup.h"
 
 /*
  * Display the path(s), one per line, of the packfile(s) containing
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index 845c1db493..35f313e568 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -9,8 +9,8 @@
 #include "parse-options.h"
 #include "index/fsmonitor-ipc.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 #include "thread-utils.h"
 #include "trace2.h"
 
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 6f16fcf7e8..328732f72a 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -1,12 +1,12 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "index/name-hash.h"
 #include "parse-options.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 #include "trace.h"
 
 static int single;
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index b6122af08f..65a56444c8 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -4,8 +4,8 @@
 #include "hex.h"
 #include "odb/match-trees.h"
 #include "odb/object-name.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 #include "odb/tree.h"
 
 int cmd__match_trees(int ac UNUSED, const char **av)
diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index a3117ca6fc..f86434bf93 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -9,7 +9,7 @@
 #include "pack/pack.h"
 #include "pack/pack-objects.h"
 #include "parse-options.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "string-list.h"
 
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index 4750a33140..a662bebb10 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -6,7 +6,7 @@
 #include "odb/odb.h"
 #include "pack/packfile.h"
 #include "pack/pack-mtimes.h"
-#include "setup.h"
+#include "setup/setup.h"
 
 static void dump_mtimes(struct packed_git *p)
 {
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index 76fc0329fc..db27488954 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -2,9 +2,9 @@
 
 #include "test-tool.h"
 #include "hex.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/odb.h"
-#include "setup.h"
+#include "setup/setup.h"
 
 /*
  * Prints the size of the object corresponding to the given hash in a specific
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index fd98a5bfd9..34ccd254e5 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -3,10 +3,10 @@
 
 #include "test-tool.h"
 #include "abspath.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "path.h"
 #include "index/read-cache-ll.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "string-list.h"
 #include "trace.h"
 #include "utf8.h"
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index f689ff3c53..8bf2ec3dc6 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -2,14 +2,14 @@
 
 #include "test-tool.h"
 #include "index/dir.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "revision/list-objects-filter-options.h"
 #include "odb/object-name.h"
 #include "odb/object.h"
 #include "revision/pretty.h"
 #include "revision/revision.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "parse-options.h"
 #include "strbuf.h"
 #include "path-walk.h"
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 1f75b7bd19..8146c56f08 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -24,7 +24,7 @@
 #include "test-tool.h"
 #include "parse-options.h"
 #include "progress.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strbuf.h"
 #include "string-list.h"
 
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 7f00cc7d9c..30bde7d2ee 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -7,7 +7,7 @@
 #include "hex.h"
 #include "odb/object-name.h"
 #include "refs/ref-filter.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "string-list.h"
 #include "odb/tag.h"
 
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index dad40b8ad7..ae2e1f19f4 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,11 +1,11 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 
 int cmd__read_cache(int argc, const char **argv)
 {
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index c80df07586..76f0833cc0 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -2,10 +2,10 @@
 
 #include "test-tool.h"
 #include "pack/commit-graph.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/odb.h"
 #include "pack/bloom.h"
-#include "setup.h"
+#include "setup/setup.h"
 
 static void dump_graph_info(struct commit_graph *graph)
 {
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 1e3db8cd81..ce8c10d4f1 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -3,11 +3,11 @@
 #include "test-tool.h"
 #include "hex.h"
 #include "pack/midx.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/odb.h"
 #include "pack/pack-bitmap.h"
 #include "pack/packfile.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "gettext.h"
 #include "pack/pack-revindex.h"
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 582e8b4d97..522520046e 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -3,11 +3,11 @@
 #include "test-tool.h"
 #include "hex.h"
 #include "refs/refs.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "refs/worktree.h"
 #include "odb/odb.h"
 #include "path.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strbuf.h"
 #include "revision/revision.h"
 
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 58f486a471..947aaf6b94 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -3,11 +3,11 @@
 #include "test-tool.h"
 #include "pack/commit-graph.h"
 #include "odb/commit.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "odb/object.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 #include "odb/tree.h"
 
 static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 57e0bcea63..264c96fc59 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -15,9 +15,9 @@
 #include "diff/diff.h"
 #include "revision/line-log.h"
 #include "odb/object-name.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "revision/revision.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "string-list.h"
 
 static void print_commit(struct commit *commit)
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 8e40a08436..0989f969da 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -3,8 +3,8 @@
 #include "test-tool.h"
 #include "lockfile.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 #include "odb/tree.h"
 #include "index/cache-tree.h"
 
diff --git a/t/helper/test-serve-v2.c b/t/helper/test-serve-v2.c
index 27f3ed8947..13452d4eab 100644
--- a/t/helper/test-serve-v2.c
+++ b/t/helper/test-serve-v2.c
@@ -3,9 +3,9 @@
 #include "test-tool.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "serve.h"
-#include "setup.h"
+#include "setup/setup.h"
 
 static char const * const serve_usage[] = {
 	N_("test-tool serve-v2 [<options>]"),
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 7a756d4f8d..e928d148f6 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -1,11 +1,11 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "config.h"
+#include "setup/config.h"
 #include "odb/hash.h"
 #include "odb/object-name.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 #include "submodule-config.h"
 #include "submodule.h"
 
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index 7e31d3fe47..a7078a0ef4 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 #include "submodule-config.h"
 
 static void die_usage(const char **argv, const char *msg)
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 3c5c4c4a09..7a82e1f0f9 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -4,8 +4,8 @@
 #include "test-tool-utils.h"
 #include "parse-options.h"
 #include "remote.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "submodule-config.h"
 #include "submodule.h"
diff --git a/t/helper/test-subprocess.c b/t/helper/test-subprocess.c
index a8194d24b3..b2b1d5494e 100644
--- a/t/helper/test-subprocess.c
+++ b/t/helper/test-subprocess.c
@@ -2,7 +2,7 @@
 
 #include "test-tool.h"
 #include "run-command.h"
-#include "setup.h"
+#include "setup/setup.h"
 
 int cmd__subprocess(int argc, const char **argv)
 {
diff --git a/t/helper/test-synthesize.c b/t/helper/test-synthesize.c
index 1997141691..df4a4c972c 100644
--- a/t/helper/test-synthesize.c
+++ b/t/helper/test-synthesize.c
@@ -10,8 +10,8 @@
 #include "pack/pack.h"
 #include "parse-options.h"
 #include "parse.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 #include "strbuf.h"
 #include "write-or-die.h"
 
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 3b12f4173e..ffd2bd99f1 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -5,8 +5,8 @@
 #include "strvec.h"
 #include "run-command.h"
 #include "exec-cmd.h"
-#include "config.h"
-#include "repository.h"
+#include "setup/config.h"
+#include "setup/repository.h"
 #include "trace2.h"
 
 typedef int(fn_unit_test)(int argc, const char **argv);
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
index ee829e0868..b01b8d5c84 100644
--- a/t/helper/test-userdiff.c
+++ b/t/helper/test-userdiff.c
@@ -1,9 +1,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "diff/userdiff.h"
-#include "config.h"
+#include "setup/config.h"
 
 static int driver_cb(struct userdiff_driver *driver,
 		     enum userdiff_driver_type type, void *priv)
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index ffe468b445..f5707e6248 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -3,8 +3,8 @@
 #include "test-tool.h"
 #include "lockfile.h"
 #include "index/read-cache-ll.h"
-#include "repository.h"
-#include "setup.h"
+#include "setup/repository.h"
+#include "setup/setup.h"
 
 int cmd__write_cache(int argc, const char **argv)
 {
diff --git a/t/unit-tests/u-example-decorate.c b/t/unit-tests/u-example-decorate.c
index 85d0277ee2..dde491a450 100644
--- a/t/unit-tests/u-example-decorate.c
+++ b/t/unit-tests/u-example-decorate.c
@@ -3,7 +3,7 @@
 #include "unit-test.h"
 #include "odb/object.h"
 #include "revision/decorate.h"
-#include "repository.h"
+#include "setup/repository.h"
 
 struct test_vars {
 	struct object *one, *two, *three;
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 4f923f7267..48e048aa14 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -4,7 +4,7 @@
 #include "odb/source-inmemory.h"
 #include "odb/streaming.h"
 #include "odb/oidset.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "strbuf.h"
 
 #define RANDOM_OID "da39a3ee5e6b4b0d3255bfef95601890afd80709"
diff --git a/trace.c b/trace.c
index 515b99e7f5..67ac945821 100644
--- a/trace.c
+++ b/trace.c
@@ -25,9 +25,9 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "quote.h"
-#include "setup.h"
+#include "setup/setup.h"
 #include "trace.h"
 
 struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
diff --git a/trace2.c b/trace2.c
index c23c0a227b..a8e23ff96f 100644
--- a/trace2.c
+++ b/trace2.c
@@ -1,8 +1,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "repository.h"
+#include "setup/config.h"
+#include "setup/repository.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "thread-utils.h"
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index bbcfeda60a..174252feaa 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "strbuf.h"
 #include "trace2.h"
 #include "trace2/tr2_cfg.h"
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index c63aebbec5..9da3946d5f 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -1,7 +1,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "index/dir.h"
 #include "tr2_sysenv.h"
 
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 5a0381791f..fa42082bc6 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -1,11 +1,11 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "json-writer.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "run-command.h"
-#include "version.h"
+#include "setup/version.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_sid.h"
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 924736ab36..0fc180b021 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -1,10 +1,10 @@
 #include "git-compat-util.h"
-#include "config.h"
-#include "repository.h"
+#include "setup/config.h"
+#include "setup/repository.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "quote.h"
-#include "version.h"
+#include "setup/version.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sysenv.h"
 #include "trace2/tr2_tbuf.h"
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 4eb9289f95..46e5c3d56c 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -1,11 +1,11 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "repository.h"
+#include "setup/config.h"
+#include "setup/repository.h"
 #include "run-command.h"
 #include "quote.h"
-#include "version.h"
+#include "setup/version.h"
 #include "json-writer.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
diff --git a/trailer.c b/trailer.c
index 7723c5cf52..bf02921cfa 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "string-list.h"
 #include "run-command.h"
diff --git a/transport-helper.c b/transport-helper.c
index 6721209d46..94d3d9ced8 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -5,11 +5,11 @@
 #include "quote.h"
 #include "run-command.h"
 #include "odb/commit.h"
-#include "environment.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-name.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "remote.h"
 #include "string-list.h"
 #include "thread-utils.h"
diff --git a/transport.c b/transport.c
index 38915e5466..18429b78f5 100644
--- a/transport.c
+++ b/transport.c
@@ -2,11 +2,11 @@
 
 #include "git-compat-util.h"
 #include "advice.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "hex.h"
 #include "transport.h"
-#include "hook.h"
+#include "setup/hook.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
 #include "fetch-object-info.h"
diff --git a/upload-pack.c b/upload-pack.c
index 09a986e486..23c0357496 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -2,14 +2,14 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "config.h"
-#include "environment.h"
+#include "setup/config.h"
+#include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs/refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/odb.h"
 #include "odb/oid-array.h"
 #include "odb/object.h"
@@ -20,7 +20,7 @@
 #include "run-command.h"
 #include "connect.h"
 #include "sigchain.h"
-#include "version.h"
+#include "setup/version.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "trace2.h"
diff --git a/urlmatch.h b/urlmatch.h
index db1a335e72..e3f1ce7477 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -2,7 +2,7 @@
 #define URL_MATCH_H
 
 #include "string-list.h"
-#include "config.h"
+#include "setup/config.h"
 
 struct url_info {
 	/* normalized url on success, must be freed, otherwise NULL */
diff --git a/versioncmp.c b/versioncmp.c
index 3a81b17bc1..cdf130cc28 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "setup/config.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "versioncmp.h"
diff --git a/walker.c b/walker.c
index 83f980c1f3..079dcd378c 100644
--- a/walker.c
+++ b/walker.c
@@ -4,7 +4,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "walker.h"
-#include "repository.h"
+#include "setup/repository.h"
 #include "odb/odb.h"
 #include "odb/commit.h"
 #include "strbuf.h"
-- 
2.54.0

