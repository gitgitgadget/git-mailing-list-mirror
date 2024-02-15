Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16990482C7
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707990203; cv=none; b=XSUiQh7IsxBATK1ScKDsc/6TFNZrAL4TubYwGs5wOB1E9+6A5ZfSTwjU1fQQXDezkZ2kkR51GvjJOjeLJRVw5idDsifaFzGZqxY1EiAM+14S6BcVDbzdTuYPqkCsEUyxiAAuStbc4knmgXI5LVKEw58ZDYteL54uTw94UGmlvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707990203; c=relaxed/simple;
	bh=8kuqQ6RwIvV0z5Cp+eUbBPIkfh3iksXa+ugroPdnFG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fxutxKFrKeHxUrkG29Q7Z+r4kCBLJQ6aik5iSDwCOJCii/+2B+UXKsIWjejYbfdHlXXVRyrMw1L5O2jdXQd8QyPVMziuB3ZnyaXy07B8S4OPYqJnD1267GFXZG/soqpO7UQ0WexIeQIUVWNuirVKFZ50xmuCrIUIQhlhC4eyPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AG9HO8pA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG9HO8pA"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so843357a12.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 01:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707990180; x=1708594980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl4kvDRA04UP/PKPeSwK2vOIyZsbP0UkYEDVTNTSoxI=;
        b=AG9HO8pAh6ehu6+LgTyv4JHMJG2NDYNG+49/DRNwCKutviHGIX2Mrk0Ce7bi/jxvm4
         VnKEUzlKATNri2Ju1gzA5iB2AyWhCPvpC7cRYOvfBJY2Lv7MesfLi3lwKnTImAjbKOMW
         5Z/LJrQj+zjBFzD9ymtIXyp4xZYShJ0LX4XZRHa61wvmGTRD2LOKqhfj95rpxQMZQ64G
         sadXXJ0/8JbGwiqV3ZAHPUN1ZPYJaGfdwaIvRuzhjQt78eM/qYAepVWP5hacA1iaQYgx
         oqIZugg4JpIMi5W4nl+fyQfaZkU+UkzEnBmcm1/OZ62NxgweLZBZAC6Pynv7w0+nj2Yv
         ytOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707990180; x=1708594980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pl4kvDRA04UP/PKPeSwK2vOIyZsbP0UkYEDVTNTSoxI=;
        b=du7H2yHSAN7fiUWcGahx2Gq5+ZBDHd1qQpvDTZA0oZTRm4abo/pYqfjHiYROkYNYys
         seG94BPzPrJdi/en5zlk7Pejg8PU1e1p9wiwMhsRUfB7/xDh5r+Kh3OwjG5HTYqCKxL4
         nHJaWWUYY25MP59rZUVmVqb/cWJ5u3vKUQCsv2o1NtmXxBvRB+lrGHAOfcfaQwbYKiGu
         GKbNQ9xBC4HJHWDFQlYK+mUi/FfdQqJzOnyDgeaYfz1zjvuA+xPJXNXl9mzXzcV9P/j/
         PRV18VD82Wc4CN+K9AyO40jTGW961+wxn+Kq29iJ1MFXLzw1pYry8o2teLUX0llolWpG
         GDhg==
X-Gm-Message-State: AOJu0Yz6/Yz+zrOHq/Z4OO5jQF7NFOWO6JKUN9KkzT+jwj+5kxEEUFfX
	lb9HoTUOO+Rle+bGLy9NvCti5LlxeDIdvm+2XXWu3dFCRmv6ijZIVDkEA9kc
X-Google-Smtp-Source: AGHT+IH0iAgrN9u8RqbpHPkLjaXpZ3V09iU4WD8R0Lh26OC9FiB6Ef/Rw77PSw1c55NCVtcpazSH/g==
X-Received: by 2002:a17:906:71cc:b0:a3c:8f4c:b1d with SMTP id i12-20020a17090671cc00b00a3c8f4c0b1dmr875353ejk.63.1707990178128;
        Thu, 15 Feb 2024 01:42:58 -0800 (PST)
Received: from fedora39.example.com ([151.15.1.25])
        by smtp.gmail.com with ESMTPSA id p17-20020a1709060e9100b00a3d11feb32esm363684ejf.186.2024.02.15.01.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:42:56 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] use C99 declaration of variable in for() loop
Date: Thu, 15 Feb 2024 10:42:42 +0100
Message-ID: <20240215094243.147057-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.43.0.522.g2a540e432f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With the exception of cbtree.c, which would need initial
reworking to remove the usage of goto, it expands the
use of variable scope reduction in for loops as
permitted by the C99 standard, which was first introduced
in the git codebase with commit 44ba10d6.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
Based on top of next 049e64211f79bdc0639badd06a79810dd7b3b85c

 add-interactive.c                    | 29 ++++-----
 add-patch.c                          | 16 +++--
 advice.c                             | 11 ++--
 apply.c                              | 39 +++++-------
 archive-tar.c                        | 10 ++-
 archive.c                            | 11 +---
 attr.c                               | 24 +++----
 base85.c                             |  3 +-
 bisect.c                             | 23 +++----
 blame.c                              | 92 ++++++++++-----------------
 bloom.c                              | 17 ++---
 branch.c                             |  3 +-
 builtin/add.c                        | 15 +++--
 builtin/am.c                         |  3 +-
 builtin/annotate.c                   |  3 +-
 builtin/archive.c                    |  4 +-
 builtin/bisect.c                     |  7 +--
 builtin/blame.c                      | 14 ++---
 builtin/branch.c                     | 15 ++---
 builtin/bugreport.c                  |  4 +-
 builtin/cat-file.c                   |  8 +--
 builtin/check-attr.c                 |  3 +-
 builtin/check-ignore.c               |  4 +-
 builtin/check-mailmap.c              |  3 +-
 builtin/checkout--worker.c           |  4 +-
 builtin/checkout-index.c             |  7 +--
 builtin/checkout.c                   |  6 +-
 builtin/clean.c                      | 17 +++--
 builtin/clone.c                      | 17 ++---
 builtin/commit-tree.c                |  3 +-
 builtin/commit.c                     | 11 ++--
 builtin/config.c                     |  3 +-
 builtin/count-objects.c              |  3 +-
 builtin/credential-cache--daemon.c   |  8 +--
 builtin/describe.c                   |  4 +-
 builtin/diff-index.c                 |  3 +-
 builtin/diff.c                       |  7 +--
 builtin/fast-export.c                | 24 +++----
 builtin/fast-import.c                | 56 +++++++----------
 builtin/fetch-pack.c                 |  4 +-
 builtin/fetch.c                      | 39 ++++--------
 builtin/for-each-repo.c              |  7 +--
 builtin/fsck.c                       | 22 +++----
 builtin/fsmonitor--daemon.c          | 14 +----
 builtin/gc.c                         | 28 +++------
 builtin/grep.c                       | 24 +++----
 builtin/hash-object.c                |  3 +-
 builtin/help.c                       | 14 ++---
 builtin/hook.c                       |  3 +-
 builtin/index-pack.c                 | 13 ++--
 builtin/interpret-trailers.c         |  3 +-
 builtin/log.c                        | 17 ++---
 builtin/ls-files.c                   | 14 ++---
 builtin/ls-tree.c                    |  8 +--
 builtin/mailsplit.c                  |  6 +-
 builtin/merge-base.c                 | 20 +++---
 builtin/merge-index.c                |  3 +-
 builtin/merge-tree.c                 |  9 +--
 builtin/merge.c                      | 36 +++++------
 builtin/name-rev.c                   | 11 ++--
 builtin/notes.c                      |  4 +-
 builtin/pack-objects.c               | 49 +++++----------
 builtin/pack-redundant.c             |  3 +-
 builtin/pull.c                       |  6 +-
 builtin/push.c                       |  4 +-
 builtin/range-diff.c                 |  4 +-
 builtin/read-tree.c                  |  4 +-
 builtin/receive-pack.c               | 46 +++++---------
 builtin/reflog.c                     | 16 +++--
 builtin/remote.c                     | 37 +++++------
 builtin/repack.c                     | 24 +++----
 builtin/replace.c                    | 10 ++-
 builtin/replay.c                     |  4 +-
 builtin/rerere.c                     |  3 +-
 builtin/reset.c                      |  7 +--
 builtin/rev-list.c                   |  3 +-
 builtin/rm.c                         | 10 ++-
 builtin/send-pack.c                  |  3 +-
 builtin/shortlog.c                   |  4 +-
 builtin/show-branch.c                |  4 +-
 builtin/sparse-checkout.c            | 11 ++--
 builtin/stash.c                      | 27 +++-----
 builtin/submodule--helper.c          | 40 +++++-------
 builtin/tag.c                        |  3 +-
 builtin/unpack-objects.c             |  9 +--
 builtin/update-index.c               |  9 +--
 builtin/var.c                        |  6 +-
 builtin/verify-pack.c                |  3 +-
 builtin/worktree.c                   | 12 ++--
 bulk-checkin.c                       |  7 +--
 bundle-uri.c                         |  6 +-
 bundle.c                             | 21 +++----
 cache-tree.c                         | 21 +++----
 chunk-format.c                       |  4 +-
 color.c                              |  9 +--
 column.c                             | 22 +++----
 combine-diff.c                       | 18 +++---
 commit-graph.c                       | 52 ++++++----------
 commit-reach.c                       | 26 +++-----
 commit.c                             | 23 +++----
 compat/fsmonitor/fsm-health-win32.c  |  4 +-
 compat/fsmonitor/fsm-listen-darwin.c |  8 +--
 compat/mingw.c                       |  6 +-
 compat/simple-ipc/ipc-unix-socket.c  | 11 +---
 compat/simple-ipc/ipc-win32.c        |  3 +-
 compat/strcasestr.c                  |  7 +--
 compat/terminal.c                    |  7 +--
 compat/unsetenv.c                    |  4 +-
 config.c                             | 15 ++---
 connect.c                            | 15 ++---
 connected.c                          |  4 +-
 convert.c                            | 18 ++----
 credential.c                         | 12 +---
 daemon.c                             | 21 +++----
 date.c                               |  3 +-
 decorate.c                           |  6 +-
 delta-islands.c                      | 27 +++-----
 diagnose.c                           |  3 +-
 diff-delta.c                         |  6 +-
 diff-lib.c                           |  4 +-
 diff.c                               | 93 ++++++++++------------------
 diff.h                               |  4 +-
 diffcore-break.c                     |  7 +--
 diffcore-delta.c                     |  3 +-
 diffcore-order.c                     | 11 ++--
 diffcore-rename.c                    | 17 +++--
 dir.c                                | 57 +++++++----------
 entry.c                              |  4 +-
 environment.c                        |  4 +-
 ewah/bitmap.c                        | 21 +++----
 ewah/ewah_io.c                       |  3 +-
 fetch-pack.c                         | 40 ++++--------
 fmt-merge-msg.c                      | 14 ++---
 fsck.c                               | 19 ++----
 fsmonitor.c                          |  9 ++-
 git.c                                | 16 ++---
 gpg-interface.c                      | 20 +++---
 graph.c                              | 51 +++++----------
 grep.c                               | 21 +++----
 hash-lookup.c                        |  4 +-
 hashmap.c                            |  4 +-
 help.c                               | 34 ++++------
 hex.c                                |  9 +--
 http-backend.c                       | 10 ++-
 http-push.c                          | 10 +--
 http-walker.c                        |  3 +-
 http.c                               | 13 ++--
 ident.c                              | 12 +---
 imap-send.c                          |  4 +-
 json-writer.c                        | 15 ++---
 khash.h                              |  8 +--
 line-log.c                           | 43 +++++--------
 linear-assignment.c                  |  4 +-
 list-objects-filter-options.c        | 11 +---
 list-objects-filter.c                | 14 ++---
 list-objects.c                       | 17 ++---
 log-tree.c                           | 10 ++-
 ls-refs.c                            |  4 +-
 mailinfo.c                           | 25 +++-----
 mem-pool.c                           |  5 +-
 merge-ll.c                           | 10 ++-
 merge-ort.c                          | 62 +++++++------------
 merge-recursive.c                    | 27 +++-----
 merge.c                              |  8 +--
 midx.c                               | 62 ++++++-------------
 name-hash.c                          | 19 ++----
 negotiator/skipping.c                |  3 +-
 notes-merge.c                        | 11 ++--
 notes-utils.c                        |  6 +-
 notes.c                              | 30 +++------
 object-file.c                        | 40 ++++--------
 object-name.c                        | 55 +++++-----------
 object.c                             | 42 ++++---------
 oid-array.c                          | 14 ++---
 pack-bitmap-write.c                  | 25 +++-----
 pack-bitmap.c                        | 51 ++++++---------
 pack-objects.c                       | 12 ++--
 pack-revindex.c                      |  8 +--
 pack-write.c                         | 13 ++--
 packfile.c                           | 82 ++++++++----------------
 pager.c                              |  3 +-
 parallel-checkout.c                  |  7 +--
 parse-options.c                      |  8 +--
 path.c                               | 11 ++--
 pathspec.c                           | 26 ++++----
 pkt-line.c                           |  3 +-
 pretty.c                             | 25 +++-----
 prio-queue.c                         | 12 ++--
 promisor-remote.c                    |  6 +-
 quote.c                              | 11 +---
 reachable.c                          |  3 +-
 read-cache.c                         | 62 ++++++-------------
 ref-filter.c                         | 50 +++++----------
 reflog-walk.c                        | 15 ++---
 refs.c                               | 58 ++++++-----------
 refs/debug.c                         |  3 +-
 refs/files-backend.c                 | 15 ++---
 refs/packed-backend.c                |  9 +--
 refs/ref-cache.c                     | 16 +----
 refs/reftable-backend.c              |  7 +--
 refspec.c                            |  6 +-
 reftable/basics.c                    |  3 +-
 reftable/block.c                     |  3 +-
 reftable/merged_test.c               |  3 +-
 reftable/pq_test.c                   |  3 +-
 reftable/readwrite_test.c            | 16 ++---
 reftable/record.c                    |  4 +-
 reftable/record_test.c               |  4 +-
 reftable/refname_test.c              |  3 +-
 reftable/stack.c                     | 12 ++--
 reftable/stack_test.c                | 28 ++++-----
 remote-curl.c                        |  6 +-
 remote.c                             | 84 +++++++++----------------
 rerere.c                             | 17 ++---
 revision.c                           | 69 +++++++--------------
 run-command.c                        | 21 ++-----
 scalar.c                             |  7 +--
 send-pack.c                          | 10 ++-
 sequencer.c                          | 40 +++++-------
 serve.c                              |  7 +--
 server-info.c                        | 12 ++--
 setup.c                              | 11 +---
 shallow.c                            | 13 ++--
 shell.c                              |  3 +-
 sideband.c                           | 11 +---
 sparse-index.c                       | 10 +--
 split-index.c                        | 16 +----
 strbuf.c                             | 20 +++---
 string-list.c                        | 12 ++--
 strvec.c                             |  3 +-
 submodule.c                          | 28 +++------
 t/helper/test-bloom.c                |  7 +--
 t/helper/test-dump-cache-tree.c      |  3 +-
 t/helper/test-dump-fsmonitor.c       |  3 +-
 t/helper/test-dump-split-index.c     |  3 +-
 t/helper/test-example-decorate.c     |  4 +-
 t/helper/test-fake-ssh.c             |  3 +-
 t/helper/test-find-pack.c            |  3 +-
 t/helper/test-fsmonitor-client.c     |  3 +-
 t/helper/test-lazy-init-name-hash.c  |  4 +-
 t/helper/test-mergesort.c            | 25 +++-----
 t/helper/test-pack-mtimes.c          |  3 +-
 t/helper/test-parse-options.c        |  3 +-
 t/helper/test-parse-pathspec-file.c  |  4 +-
 t/helper/test-path-utils.c           | 12 ++--
 t/helper/test-pkt-line.c             |  3 +-
 t/helper/test-proc-receive.c         |  4 +-
 t/helper/test-reach.c                | 10 ++-
 t/helper/test-read-cache.c           |  4 +-
 t/helper/test-read-midx.c            |  3 +-
 t/helper/test-ref-store.c            |  3 +-
 t/helper/test-repository.c           |  3 +-
 t/helper/test-rot13-filter.c         | 10 ++-
 t/helper/test-run-command.c          |  4 +-
 t/helper/test-simple-ipc.c           | 18 ++----
 t/helper/test-string-list.c          |  3 +-
 t/helper/test-submodule.c            |  3 +-
 t/helper/test-tool.c                 |  7 +--
 t/helper/test-trace2.c               | 16 ++---
 t/helper/test-wildmatch.c            |  3 +-
 t/helper/test-write-cache.c          |  4 +-
 t/unit-tests/test-lib.c              |  4 +-
 tmp-objdir.c                         |  3 +-
 trace2/tr2_cfg.c                     |  6 +-
 trace2/tr2_ctr.c                     | 15 +----
 trace2/tr2_sid.c                     |  3 +-
 trace2/tr2_sysenv.c                  |  8 +--
 trace2/tr2_tmr.c                     | 15 +----
 trailer.c                            | 28 +++------
 transport-helper.c                   | 31 ++++------
 transport.c                          | 29 +++------
 tree-diff.c                          |  3 +-
 tree-walk.c                          | 11 ++--
 unpack-trees.c                       | 48 +++++---------
 upload-pack.c                        | 33 +++-------
 userdiff.c                           |  3 +-
 version.c                            |  3 +-
 versioncmp.c                         |  6 +-
 walker.c                             |  4 +-
 worktree.c                           |  8 +--
 wrapper.c                            |  4 +-
 ws.c                                 |  3 +-
 wt-status.c                          | 51 ++++++---------
 xdiff-interface.c                    |  6 +-
 xdiff/xdiffi.c                       | 19 ++----
 xdiff/xemit.c                        |  8 +--
 xdiff/xhistogram.c                   |  4 +-
 xdiff/xmerge.c                       |  3 +-
 xdiff/xpatience.c                    |  3 +-
 289 files changed, 1452 insertions(+), 2766 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 6bf87e7ae7..58ad10be10 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -233,7 +233,7 @@ struct list_options {
 static void list(struct add_i_state *s, struct string_list *list, int *selected,
 		 struct list_options *opts)
 {
-	int i, last_lf = 0;
+	int last_lf = 0;
 
 	if (!list->nr)
 		return;
@@ -242,7 +242,7 @@ static void list(struct add_i_state *s, struct string_list *list, int *selected,
 		color_fprintf_ln(stdout, s->header_color,
 				 "%s", opts->header);
 
-	for (i = 0; i < list->nr; i++) {
+	for (int i = 0; i < list->nr; i++) {
 		opts->print_item(i, selected ? selected[i] : 0, list->items + i,
 				 opts->print_item_data);
 
@@ -467,14 +467,13 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 {
 	struct collection_status *s = data;
 	struct diffstat_t stat = { 0 };
-	int i;
 
 	if (!q->nr)
 		return;
 
 	compute_diffstat(options, &stat, q);
 
-	for (i = 0; i < stat.nr; i++) {
+	for (int i = 0; i < stat.nr; i++) {
 		const char *name = stat.files[i]->name;
 		int hash = strhash(name);
 		struct pathname_entry *entry;
@@ -535,7 +534,6 @@ static int get_modified_files(struct repository *r,
 	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 					     &head_oid, NULL);
 	struct collection_status s = { 0 };
-	int i;
 
 	discard_index(r->index);
 	if (repo_read_index_preload(r, ps, 0) < 0)
@@ -545,7 +543,7 @@ static int get_modified_files(struct repository *r,
 	s.files = &files->items;
 	hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
 
-	for (i = 0; i < 2; i++) {
+	for (int i = 0; i < 2; i++) {
 		struct rev_info rev;
 		struct setup_revision_opt opt = { 0 };
 
@@ -678,7 +676,7 @@ static int run_update(struct add_i_state *s, const struct pathspec *ps,
 		      struct list_and_choose_options *opts)
 {
 	int res = 0, fd;
-	size_t count, i;
+	size_t count;
 	struct lock_file index_lock;
 
 	if (get_modified_files(s->r, WORKTREE_ONLY, files, ps, NULL, NULL) < 0)
@@ -702,7 +700,7 @@ static int run_update(struct add_i_state *s, const struct pathspec *ps,
 		return -1;
 	}
 
-	for (i = 0; i < files->items.nr; i++) {
+	for (size_t i = 0; i < files->items.nr; i++) {
 		const char *name = files->items.items[i].string;
 		struct stat st;
 
@@ -733,9 +731,9 @@ static int run_update(struct add_i_state *s, const struct pathspec *ps,
 static void revert_from_diff(struct diff_queue_struct *q,
 			     struct diff_options *opt, void *data UNUSED)
 {
-	int i, add_flags = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
+	int add_flags = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
 
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filespec *one = q->queue[i]->one;
 		struct cache_entry *ce;
 
@@ -758,7 +756,7 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
 		      struct list_and_choose_options *opts)
 {
 	int res = 0, fd;
-	size_t count, i, j;
+	size_t count, j;
 
 	struct object_id oid;
 	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
@@ -799,7 +797,7 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
 	}
 
 	ALLOC_ARRAY(paths, count + 1);
-	for (i = j = 0; i < files->items.nr; i++)
+	for (size_t i = j = 0; i < files->items.nr; i++)
 		if (files->selected[i])
 			paths[j++] = files->items.items[i].string;
 	paths[j] = NULL;
@@ -843,7 +841,6 @@ static int get_untracked_files(struct repository *r,
 			       const struct pathspec *ps)
 {
 	struct dir_struct dir = { 0 };
-	size_t i;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (repo_read_index(r) < 0)
@@ -854,7 +851,7 @@ static int get_untracked_files(struct repository *r,
 	add_pattern_list(&dir, EXC_CMDL, "--exclude option");
 	fill_directory(&dir, r->index, ps);
 
-	for (i = 0; i < dir.nr; i++) {
+	for (size_t i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 
 		if (index_name_is_other(r->index, ent->name, ent->len)) {
@@ -874,7 +871,7 @@ static int run_add_untracked(struct add_i_state *s, const struct pathspec *ps,
 {
 	struct print_file_item_data *d = opts->list_opts.print_item_data;
 	int res = 0, fd;
-	size_t count, i;
+	size_t count;
 	struct lock_file index_lock;
 
 	if (get_untracked_files(s->r, files, ps) < 0)
@@ -898,7 +895,7 @@ static int run_add_untracked(struct add_i_state *s, const struct pathspec *ps,
 		goto finish_add_untracked;
 	}
 
-	for (i = 0; i < files->items.nr; i++) {
+	for (size_t i = 0; i < files->items.nr; i++) {
 		const char *name = files->items.items[i].string;
 		if (files->selected[i] &&
 		    add_file_to_index(s->r->index, name, 0) < 0) {
diff --git a/add-patch.c b/add-patch.c
index 68f525b35c..219bcc9c9d 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -275,13 +275,11 @@ struct add_p_state {
 
 static void add_p_state_clear(struct add_p_state *s)
 {
-	size_t i;
-
 	strbuf_release(&s->answer);
 	strbuf_release(&s->buf);
 	strbuf_release(&s->plain);
 	strbuf_release(&s->colored);
-	for (i = 0; i < s->file_diff_nr; i++)
+	for (size_t i = 0; i < s->file_diff_nr; i++)
 		free(s->file_diff[i].hunk);
 	free(s->file_diff);
 	clear_add_i_state(&s->s);
@@ -407,7 +405,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
-	size_t file_diff_alloc = 0, i, color_arg_index;
+	size_t file_diff_alloc = 0, color_arg_index;
 	struct file_diff *file_diff = NULL;
 	struct hunk *hunk = NULL;
 	int res;
@@ -427,7 +425,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
 	strvec_pushl(&args, "--no-color", "--ignore-submodules=dirty", "-p",
 		     "--", NULL);
-	for (i = 0; i < ps->nr; i++)
+	for (size_t i = 0; i < ps->nr; i++)
 		strvec_push(&args, ps->items[i].original);
 
 	setup_child_process(s, &cp, NULL);
@@ -878,12 +876,12 @@ static void reassemble_patch(struct add_p_state *s,
 			     struct strbuf *out)
 {
 	struct hunk *hunk;
-	size_t save_len = s->plain.len, i;
+	size_t save_len = s->plain.len;
 	ssize_t delta = 0;
 
 	render_diff_header(s, file_diff, 0, out);
 
-	for (i = file_diff->mode_change; i < file_diff->hunk_nr; i++) {
+	for (size_t i = file_diff->mode_change; i < file_diff->hunk_nr; i++) {
 		struct hunk merged = { 0 };
 
 		hunk = file_diff->hunk + i;
@@ -1722,7 +1720,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	struct add_p_state s = {
 		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
-	size_t i, binary_count = 0;
+	size_t binary_count = 0;
 
 	init_add_i_state(&s.s, r);
 
@@ -1761,7 +1759,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		return -1;
 	}
 
-	for (i = 0; i < s.file_diff_nr; i++)
+	for (size_t i = 0; i < s.file_diff_nr; i++)
 		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
 			binary_count++;
 		else if (patch_update_file(&s, s.file_diff + i))
diff --git a/advice.c b/advice.c
index 6e9098ff08..e1606a0afd 100644
--- a/advice.c
+++ b/advice.c
@@ -93,14 +93,14 @@ static void vadvise(const char *advice, int display_instructions,
 		    const char *key, va_list params)
 {
 	struct strbuf buf = STRBUF_INIT;
-	const char *cp, *np;
+	const char *np;
 
 	strbuf_vaddf(&buf, advice, params);
 
 	if (display_instructions)
 		strbuf_addf(&buf, turn_off_instructions, key);
 
-	for (cp = buf.buf; *cp; cp = np) {
+	for (const char *cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
 		fprintf(stderr,	_("%shint: %.*s%s\n"),
 			advise_get_color(ADVICE_COLOR_HINT),
@@ -147,7 +147,6 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...)
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k, *slot_name;
-	int i;
 
 	if (!strcmp(var, "color.advice")) {
 		advice_use_color = git_config_colorbool(var, value);
@@ -166,7 +165,7 @@ int git_default_advice_config(const char *var, const char *value)
 	if (!skip_prefix(var, "advice.", &k))
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(advice_setting); i++) {
+	for (int i = 0; i < ARRAY_SIZE(advice_setting); i++) {
 		if (strcasecmp(k, advice_setting[i].key))
 			continue;
 		advice_setting[i].level = git_config_bool(var, value)
@@ -180,9 +179,7 @@ int git_default_advice_config(const char *var, const char *value)
 
 void list_config_advices(struct string_list *list, const char *prefix)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(advice_setting); i++)
+	for (int i = 0; i < ARRAY_SIZE(advice_setting); i++)
 		list_config_item(list, prefix, advice_setting[i].key);
 }
 
diff --git a/apply.c b/apply.c
index 355e2b0f2f..2b1582fa0e 100644
--- a/apply.c
+++ b/apply.c
@@ -504,7 +504,7 @@ static char *find_name_gnu(struct strbuf *root,
 
 static size_t sane_tz_len(const char *line, size_t len)
 {
-	const char *tz, *p;
+	const char *tz;
 
 	if (len < strlen(" +0500") || line[len-strlen(" +0500")] != ' ')
 		return 0;
@@ -513,7 +513,7 @@ static size_t sane_tz_len(const char *line, size_t len)
 	if (tz[1] != '+' && tz[1] != '-')
 		return 0;
 
-	for (p = tz + 2; p != line + len; p++)
+	for (const char *p = tz + 2; p != line + len; p++)
 		if (!isdigit(*p))
 			return 0;
 
@@ -801,13 +801,13 @@ static int has_epoch_timestamp(const char *nameline)
 		"^[0-2][0-9]:([0-5][0-9]):00(\\.0+)?"
 		" "
 		"([-+][0-2][0-9]:?[0-5][0-9])\n";
-	const char *timestamp = NULL, *cp, *colon;
+	const char *timestamp = NULL, *colon;
 	static regex_t *stamp;
 	regmatch_t m[10];
 	int zoneoffset, epoch_hour, hour, minute;
 	int status;
 
-	for (cp = nameline; *cp != '\n'; cp++) {
+	for (const char *cp = nameline; *cp != '\n'; cp++) {
 		if (*cp == '\t')
 			timestamp = cp + 1;
 	}
@@ -1144,13 +1144,12 @@ static const char *skip_tree_prefix(int p_value,
 				    int llen)
 {
 	int nslash;
-	int i;
 
 	if (!p_value)
 		return (llen && line[0] == '/') ? NULL : line;
 
 	nslash = p_value;
-	for (i = 0; i < llen; i++) {
+	for (int i = 0; i < llen; i++) {
 		int ch = line[i];
 		if (ch == '/' && --nslash <= 0)
 			return (i == 0) ? NULL : &line[i + 1];
@@ -1550,14 +1549,15 @@ static int find_header(struct apply_state *state,
 		       int *hdrsize,
 		       struct patch *patch)
 {
-	unsigned long offset, len;
+	unsigned long len;
 
 	patch->is_toplevel_relative = 0;
 	patch->is_rename = patch->is_copy = 0;
 	patch->is_new = patch->is_delete = -1;
 	patch->old_mode = patch->new_mode = 0;
 	patch->old_name = patch->new_name = NULL;
-	for (offset = 0; size > 0; offset += len, size -= len, line += len, state->linenr++) {
+	for (unsigned long offset = 0; size > 0; offset += len, size -= len,
+	     line += len, state->linenr++) {
 		unsigned long nextlen;
 
 		len = linelen(line, size);
@@ -2100,7 +2100,6 @@ static void add_name_limit(struct apply_state *state,
 static int use_patch(struct apply_state *state, struct patch *p)
 {
 	const char *pathname = p->new_name ? p->new_name : p->old_name;
-	int i;
 
 	/* Paths outside are not touched regardless of "--include" */
 	if (state->prefix && *state->prefix) {
@@ -2110,7 +2109,7 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	}
 
 	/* See if it matches any of exclude/include rule */
-	for (i = 0; i < state->limit_by_name.nr; i++) {
+	for (int i = 0; i < state->limit_by_name.nr; i++) {
 		struct string_list_item *it = &state->limit_by_name.items[i];
 		if (!wildmatch(it->string, pathname, 0))
 			return (it->util != NULL);
@@ -2186,8 +2185,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				"Files ",
 				NULL,
 			};
-			int i;
-			for (i = 0; binhdr[i]; i++) {
+			for (int i = 0; binhdr[i]; i++) {
 				int len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
@@ -4131,7 +4129,6 @@ static int preimage_oid_in_gitlink_patch(struct patch *p, struct object_id *oid)
 /* Build an index that contains just the files needed for a 3way merge */
 static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 {
-	struct patch *patch;
 	struct index_state result = INDEX_STATE_INIT(state->repo);
 	struct lock_file lock = LOCK_INIT;
 	int res;
@@ -4139,7 +4136,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 	/* Once we start supporting the reverse patch, it may be
 	 * worth showing the new sha1 prefix, but until then...
 	 */
-	for (patch = list; patch; patch = patch->next) {
+	for (struct patch *patch = list; patch; patch = patch->next) {
 		struct object_id oid;
 		struct cache_entry *ce;
 		const char *name;
@@ -4270,9 +4267,7 @@ static void show_rename_copy(struct patch *p)
 
 static void summary_patch_list(struct patch *patch)
 {
-	struct patch *p;
-
-	for (p = patch; p; p = p->next) {
+	for (struct patch *p = patch; p; p = p->next) {
 		if (p->is_new)
 			show_file_mode_name("create", p->new_mode, p->new_name);
 		else if (p->is_delete)
@@ -4524,7 +4519,7 @@ static int create_one_file(struct apply_state *state,
 static int add_conflicted_stages_file(struct apply_state *state,
 				       struct patch *patch)
 {
-	int stage, namelen;
+	int namelen;
 	unsigned mode;
 	struct cache_entry *ce;
 
@@ -4534,7 +4529,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
 
 	remove_file_from_index(state->repo->index, patch->new_name);
-	for (stage = 1; stage < 4; stage++) {
+	for (int stage = 1; stage < 4; stage++) {
 		if (is_null_oid(&patch->threeway_stage[stage - 1]))
 			continue;
 		ce = make_empty_cache_entry(state->repo->index, namelen);
@@ -4690,12 +4685,11 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
  */
 static int write_out_results(struct apply_state *state, struct patch *list)
 {
-	int phase;
 	int errs = 0;
 	struct patch *l;
 	struct string_list cpath = STRING_LIST_INIT_DUP;
 
-	for (phase = 0; phase < 2; phase++) {
+	for (int phase = 0; phase < 2; phase++) {
 		l = list;
 		while (l) {
 			if (l->rejected)
@@ -4967,12 +4961,11 @@ int apply_all_patches(struct apply_state *state,
 		      const char **argv,
 		      int options)
 {
-	int i;
 	int res;
 	int errs = 0;
 	int read_stdin = 1;
 
-	for (i = 0; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		char *to_free = NULL;
 		int fd;
diff --git a/archive-tar.c b/archive-tar.c
index 8ae30125f8..d5dcc342cd 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -157,11 +157,11 @@ static void strbuf_append_ext_header(struct strbuf *sb, const char *keyword,
 				     const char *value, size_t valuelen)
 {
 	size_t orig_len = sb->len;
-	size_t len, tmp;
+	size_t len;
 
 	/* "%u %s=%s\n" */
 	len = 1 + 1 + strlen(keyword) + 1 + valuelen + 1;
-	for (tmp = 1; len / 10 >= tmp; tmp *= 10)
+	for (size_t tmp = 1; len / 10 >= tmp; tmp *= 10)
 		len++;
 
 	strbuf_grow(sb, len);
@@ -362,8 +362,7 @@ static int alloc_tar_filters;
 
 static struct archiver *find_tar_filter(const char *name, size_t len)
 {
-	int i;
-	for (i = 0; i < nr_tar_filters; i++) {
+	for (int i = 0; i < nr_tar_filters; i++) {
 		struct archiver *ar = tar_filters[i];
 		if (!xstrncmpz(ar->name, name, len))
 			return ar;
@@ -531,7 +530,6 @@ static struct archiver tar_archiver = {
 
 void init_tar_archiver(void)
 {
-	int i;
 	register_archiver(&tar_archiver);
 
 	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
@@ -539,7 +537,7 @@ void init_tar_archiver(void)
 	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tar.gz.remote", "true", NULL);
 	git_config(git_tar_config, NULL);
-	for (i = 0; i < nr_tar_filters; i++) {
+	for (int i = 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
 		if (tar_filters[i]->filter_command)
 			register_archiver(tar_filters[i]);
diff --git a/archive.c b/archive.c
index a6730bebfa..ea30af9ffb 100644
--- a/archive.c
+++ b/archive.c
@@ -308,7 +308,6 @@ int write_archive_entries(struct archiver_args *args,
 	struct strbuf path_in_archive = STRBUF_INIT;
 	struct strbuf content = STRBUF_INIT;
 	struct object_id fake_oid;
-	int i;
 
 	oidcpy(&fake_oid, null_oid());
 
@@ -357,7 +356,7 @@ int write_archive_entries(struct archiver_args *args,
 		context.bottom = next;
 	}
 
-	for (i = 0; i < args->extra_files.nr; i++) {
+	for (int i = 0; i < args->extra_files.nr; i++) {
 		struct string_list_item *item = args->extra_files.items + i;
 		char *path = item->string;
 		struct extra_file_info *info = item->util;
@@ -396,12 +395,10 @@ int write_archive_entries(struct archiver_args *args,
 
 static const struct archiver *lookup_archiver(const char *name)
 {
-	int i;
-
 	if (!name)
 		return NULL;
 
-	for (i = 0; i < nr_archivers; i++) {
+	for (int i = 0; i < nr_archivers; i++) {
 		if (!strcmp(name, archivers[i]->name))
 			return archivers[i];
 	}
@@ -784,9 +781,7 @@ static int match_extension(const char *filename, const char *ext)
 
 const char *archive_format_from_filename(const char *filename)
 {
-	int i;
-
-	for (i = 0; i < nr_archivers; i++)
+	for (int i = 0; i < nr_archivers; i++)
 		if (match_extension(filename, archivers[i]->name))
 			return archivers[i]->name;
 	return NULL;
diff --git a/attr.c b/attr.c
index 679e42258c..af70c6a73f 100644
--- a/attr.c
+++ b/attr.c
@@ -142,7 +142,6 @@ struct all_attrs_item {
  */
 static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 {
-	int i;
 	unsigned int size;
 
 	hashmap_lock(map);
@@ -178,7 +177,7 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 	 * This re-initialization can live outside of the locked region since
 	 * the attribute dictionary is no longer being accessed.
 	 */
-	for (i = 0; i < check->all_attrs_nr; i++) {
+	for (int i = 0; i < check->all_attrs_nr; i++) {
 		check->all_attrs[i].value = ATTR__UNKNOWN;
 		check->all_attrs[i].macro = NULL;
 	}
@@ -471,9 +470,8 @@ struct attr_stack {
 
 static void attr_stack_free(struct attr_stack *e)
 {
-	unsigned i;
 	free(e->origin);
-	for (i = 0; i < e->num_matches; i++) {
+	for (unsigned i = 0; i < e->num_matches; i++) {
 		struct match_attr *a = e->attrs[i];
 		size_t j;
 
@@ -558,11 +556,9 @@ static void check_vector_remove(struct attr_check *check)
 /* Iterate through all attr_check instances and drop their stacks */
 static void drop_all_attr_stacks(void)
 {
-	int i;
-
 	vector_lock();
 
-	for (i = 0; i < check_vector.nr; i++) {
+	for (int i = 0; i < check_vector.nr; i++) {
 		drop_attr_stack(&check_vector.checks[i]->stack);
 	}
 
@@ -1102,9 +1098,7 @@ static int macroexpand_one(struct all_attrs_item *all_attrs, int nr, int rem);
 static int fill_one(struct all_attrs_item *all_attrs,
 		    const struct match_attr *a, int rem)
 {
-	size_t i;
-
-	for (i = a->num_attr; rem > 0 && i > 0; i--) {
+	for (size_t i = a->num_attr; rem > 0 && i > 0; i--) {
 		const struct git_attr *attr = a->state[i - 1].attr;
 		const char **n = &(all_attrs[attr->attr_nr].value);
 		const char *v = a->state[i - 1].setto;
@@ -1262,9 +1256,7 @@ static const char *interned_mode_string(unsigned int mode)
 		{ .val = 0120000 },
 		{ .val = 0160000 },
 	};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mode_string); i++) {
+	for (int i = 0; i < ARRAY_SIZE(mode_string); i++) {
 		if (mode_string[i].val != mode)
 			continue;
 		if (!*mode_string[i].str)
@@ -1333,12 +1325,11 @@ void git_check_attr(struct index_state *istate,
 		    const char *path,
 		    struct attr_check *check)
 {
-	int i;
 	const struct object_id *tree_oid = default_attr_source();
 
 	collect_some_attrs(istate, tree_oid, path, check);
 
-	for (i = 0; i < check->nr; i++) {
+	for (int i = 0; i < check->nr; i++) {
 		unsigned int n = check->items[i].attr->attr_nr;
 		const char *value = check->all_attrs[n].value;
 		if (value == ATTR__UNKNOWN)
@@ -1350,13 +1341,12 @@ void git_check_attr(struct index_state *istate,
 void git_all_attrs(struct index_state *istate,
 		   const char *path, struct attr_check *check)
 {
-	int i;
 	const struct object_id *tree_oid = default_attr_source();
 
 	attr_check_reset(check);
 	collect_some_attrs(istate, tree_oid, path, check);
 
-	for (i = 0; i < check->all_attrs_nr; i++) {
+	for (int i = 0; i < check->all_attrs_nr; i++) {
 		const char *name = check->all_attrs[i].attr->name;
 		const char *value = check->all_attrs[i].value;
 		struct attr_check_item *item;
diff --git a/base85.c b/base85.c
index bbacdca31b..0598e1c626 100644
--- a/base85.c
+++ b/base85.c
@@ -29,10 +29,9 @@ static const char en85[] = {
 static char de85[256];
 static void prep_base85(void)
 {
-	int i;
 	if (de85['Z'])
 		return;
-	for (i = 0; i < ARRAY_SIZE(en85); i++) {
+	for (int i = 0; i < ARRAY_SIZE(en85); i++) {
 		int ch = en85[i];
 		de85[ch] = i + 1;
 	}
diff --git a/bisect.c b/bisect.c
index f75e50c339..fe2d57c908 100644
--- a/bisect.c
+++ b/bisect.c
@@ -139,14 +139,12 @@ static inline int approx_halfway(struct commit_list *p, int nr)
 static void show_list(const char *debug, int counted, int nr,
 		      struct commit_list *list)
 {
-	struct commit_list *p;
-
 	if (!DEBUG_BISECT)
 		return;
 
 	fprintf(stderr, "%s (%d/%d)\n", debug, counted, nr);
 
-	for (p = list; p; p = p->next) {
+	for (struct commit_list *p = list; p; p = p->next) {
 		struct commit_list *pp;
 		struct commit *commit = p->item;
 		unsigned commit_flags = commit->object.flags;
@@ -183,11 +181,11 @@ static void show_list(const char *debug, int counted, int nr,
 
 static struct commit_list *best_bisection(struct commit_list *list, int nr)
 {
-	struct commit_list *p, *best;
+	struct commit_list *best;
 	int best_distance = -1;
 
 	best = list;
-	for (p = list; p; p = p->next) {
+	for (struct commit_list *p = list; p; p = p->next) {
 		int distance;
 		unsigned commit_flags = p->item->object.flags;
 
@@ -500,9 +498,7 @@ static void read_bisect_paths(struct strvec *array)
 static char *join_oid_array_hex(struct oid_array *array, char delim)
 {
 	struct strbuf joined_hexs = STRBUF_INIT;
-	int i;
-
-	for (i = 0; i < array->nr; i++) {
+	for (int i = 0; i < array->nr; i++) {
 		strbuf_addstr(&joined_hexs, oid_to_hex(array->oid + i));
 		if (i + 1 < array->nr)
 			strbuf_addch(&joined_hexs, delim);
@@ -611,7 +607,7 @@ static int sqrti(int val)
 static struct commit_list *skip_away(struct commit_list *list, int count)
 {
 	struct commit_list *cur, *previous;
-	int prn, index, i;
+	int prn, index;
 
 	prn = get_prn(count);
 	index = (count * prn / PRN_MODULO) * sqrti(prn) / sqrti(PRN_MODULO);
@@ -619,7 +615,7 @@ static struct commit_list *skip_away(struct commit_list *list, int count)
 	cur = list;
 	previous = NULL;
 
-	for (i = 0; cur; cur = cur->next, i++) {
+	for (int i = 0; cur; cur = cur->next, i++) {
 		if (i == index) {
 			if (!oideq(&cur->item->object.oid, current_bad_oid))
 				return cur;
@@ -660,7 +656,6 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 	struct setup_revision_opt opt = {
 		.free_removed_argv_elements = 1,
 	};
-	int i;
 
 	repo_init_revisions(r, revs, prefix);
 	revs->abbrev = 0;
@@ -669,7 +664,7 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 	/* rev_argv.argv[0] will be ignored by setup_revisions */
 	strvec_push(rev_argv, "bisect_rev_setup");
 	strvec_pushf(rev_argv, bad_format, oid_to_hex(current_bad_oid));
-	for (i = 0; i < good_revs.nr; i++)
+	for (int i = 0; i < good_revs.nr; i++)
 		strvec_pushf(rev_argv, good_format,
 			     oid_to_hex(good_revs.oid + i));
 	strvec_push(rev_argv, "--");
@@ -763,11 +758,11 @@ static struct commit **get_bad_and_good_commits(struct repository *r,
 						int *rev_nr)
 {
 	struct commit **rev;
-	int i, n = 0;
+	int n = 0;
 
 	ALLOC_ARRAY(rev, 1 + good_revs.nr);
 	rev[n++] = get_commit_reference(r, current_bad_oid);
-	for (i = 0; i < good_revs.nr; i++)
+	for (int i = 0; i < good_revs.nr; i++)
 		rev[n++] = get_commit_reference(r, good_revs.oid + i);
 	*rev_nr = n;
 
diff --git a/blame.c b/blame.c
index 1a16d4eb6a..c15162591e 100644
--- a/blame.c
+++ b/blame.c
@@ -41,12 +41,13 @@ static void set_blame_suspects(struct commit *commit, struct blame_origin *origi
 void blame_origin_decref(struct blame_origin *o)
 {
 	if (o && --o->refcnt <= 0) {
-		struct blame_origin *p, *l = NULL;
+		struct blame_origin *l = NULL;
 		if (o->previous)
 			blame_origin_decref(o->previous);
 		free(o->file.ptr);
 		/* Should be present exactly once in commit chain */
-		for (p = get_blame_suspects(o->commit); p; l = p, p = p->next) {
+		for (struct blame_origin *p = get_blame_suspects(o->commit); p; l = p,
+		     p = p->next) {
 			if (p == o) {
 				if (l)
 					l->next = p->next;
@@ -104,10 +105,9 @@ static struct blame_origin *get_origin(struct commit *commit, const char *path)
 static void verify_working_tree_path(struct repository *r,
 				     struct commit *work_tree, const char *path)
 {
-	struct commit_list *parents;
 	int pos;
 
-	for (parents = work_tree->parents; parents; parents = parents->next) {
+	for (struct commit_list *parents = work_tree->parents; parents; parents = parents->next) {
 		const struct object_id *commit_oid = &parents->item->object.oid;
 		struct object_id blob_oid;
 		unsigned short mode;
@@ -190,7 +190,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 {
 	struct commit *commit;
 	struct blame_origin *origin;
-	struct commit_list **parent_tail, *parent;
+	struct commit_list **parent_tail;
 	struct strbuf buf = STRBUF_INIT;
 	const char *ident;
 	time_t now;
@@ -219,7 +219,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 		ident = fmt_ident("Not Committed Yet", "not.committed.yet",
 				  WANT_BLANK_IDENT, NULL, 0);
 	strbuf_addstr(&msg, "tree 0000000000000000000000000000000000000000\n");
-	for (parent = commit->parents; parent; parent = parent->next)
+	for (struct commit_list *parent = commit->parents; parent; parent = parent->next)
 		strbuf_addf(&msg, "parent %s\n",
 			    oid_to_hex(&parent->item->object.oid));
 	strbuf_addf(&msg,
@@ -407,7 +407,6 @@ static void get_fingerprint(struct fingerprint *result,
 			    const char *line_end)
 {
 	unsigned int hash, c0 = 0, c1;
-	const char *p;
 	int max_map_entry_count = 1 + line_end - line_begin;
 	struct fingerprint_entry *entry = xcalloc(max_map_entry_count,
 		sizeof(struct fingerprint_entry));
@@ -415,7 +414,7 @@ static void get_fingerprint(struct fingerprint *result,
 
 	hashmap_init(&result->map, NULL, NULL, max_map_entry_count);
 	result->entries = entry;
-	for (p = line_begin; p <= line_end; ++p, c0 = c1) {
+	for (const char *p = line_begin; p <= line_end; ++p, c0 = c1) {
 		/* Always terminate the string with whitespace.
 		 * Normalise whitespace to 0, and normalise letters to
 		 * lower case. This won't work for multibyte characters but at
@@ -503,11 +502,10 @@ static void get_line_fingerprints(struct fingerprint *fingerprints,
 				  const char *content, const int *line_starts,
 				  long first_line, long line_count)
 {
-	int i;
 	const char *linestart, *lineend;
 
 	line_starts += first_line;
-	for (i = 0; i < line_count; ++i) {
+	for (int i = 0; i < line_count; ++i) {
 		linestart = content + line_starts[i];
 		lineend = content + line_starts[i + 1];
 		get_fingerprint(fingerprints + i, linestart, lineend);
@@ -517,9 +515,7 @@ static void get_line_fingerprints(struct fingerprint *fingerprints,
 static void free_line_fingerprints(struct fingerprint *fingerprints,
 				   int nr_fingerprints)
 {
-	int i;
-
-	for (i = 0; i < nr_fingerprints; i++)
+	for (int i = 0; i < nr_fingerprints; i++)
 		free_fingerprint(&fingerprints[i]);
 }
 
@@ -644,7 +640,7 @@ static void find_best_line_matches(
 	const struct line_number_mapping *map_line_number_in_b_to_a)
 {
 
-	int i, search_start, search_end, closest_local_line_a, *similarity,
+	int search_start, search_end, closest_local_line_a, *similarity,
 		best_similarity = 0, second_best_similarity = 0,
 		best_similarity_index = 0, second_best_similarity_index = 0;
 
@@ -663,7 +659,7 @@ static void find_best_line_matches(
 	if (search_end > length_a)
 		search_end = length_a;
 
-	for (i = search_start; i < search_end; ++i) {
+	for (int i = search_start; i < search_end; ++i) {
 		similarity = get_similarity(similarities,
 					    i, local_line_b,
 					    closest_local_line_a,
@@ -1158,9 +1154,7 @@ static int compare_commits_by_reverse_commit_date(const void *a,
 static void sanity_check_refcnt(struct blame_scoreboard *sb)
 {
 	int baa = 0;
-	struct blame_entry *ent;
-
-	for (ent = sb->ent; ent; ent = ent->next) {
+	for (struct blame_entry *ent = sb->ent; ent; ent = ent->next) {
 		/* Nobody should have zero or negative refcnt */
 		if (ent->suspect->refcnt <= 0) {
 			fprintf(stderr, "%s in %s has negative refcnt %d\n",
@@ -1181,9 +1175,9 @@ static void sanity_check_refcnt(struct blame_scoreboard *sb)
  */
 void blame_coalesce(struct blame_scoreboard *sb)
 {
-	struct blame_entry *ent, *next;
+	struct blame_entry *next;
 
-	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
+	for (struct blame_entry *ent = sb->ent; ent && (next = ent->next); ent = next) {
 		if (ent->suspect == next->suspect &&
 		    ent->s_lno + ent->num_lines == next->s_lno &&
 		    ent->lno + ent->num_lines == next->lno &&
@@ -1214,8 +1208,7 @@ static void queue_blames(struct blame_scoreboard *sb, struct blame_origin *porig
 	if (porigin->suspects)
 		porigin->suspects = blame_merge(porigin->suspects, sorted);
 	else {
-		struct blame_origin *o;
-		for (o = get_blame_suspects(porigin->commit); o; o = o->next) {
+		for (struct blame_origin *o = get_blame_suspects(porigin->commit); o; o = o->next) {
 			if (o->suspects) {
 				porigin->suspects = sorted;
 				return;
@@ -1269,7 +1262,6 @@ static int maybe_changed_path(struct repository *r,
 			      struct blame_origin *origin,
 			      struct blame_bloom_data *bd)
 {
-	int i;
 	struct bloom_filter *filter;
 
 	if (!bd)
@@ -1284,7 +1276,7 @@ static int maybe_changed_path(struct repository *r,
 		return 1;
 
 	bloom_count_queries++;
-	for (i = 0; i < bd->nr; i++) {
+	for (int i = 0; i < bd->nr; i++) {
 		if (bloom_filter_contains(filter,
 					  bd->keys[i],
 					  bd->settings))
@@ -1372,15 +1364,8 @@ static struct blame_origin *find_origin(struct repository *r,
 		oidcpy(&porigin->blob_oid, &origin->blob_oid);
 		porigin->mode = origin->mode;
 	} else {
-		/*
-		 * Since origin->path is a pathspec, if the parent
-		 * commit had it as a directory, we will see a whole
-		 * bunch of deletion of files in the directory that we
-		 * do not care about.
-		 */
-		int i;
 		struct diff_filepair *p = NULL;
-		for (i = 0; i < diff_queued_diff.nr; i++) {
+		for (int i = 0; i < diff_queued_diff.nr; i++) {
 			const char *name;
 			p = diff_queued_diff.queue[i];
 			name = p->one->path ? p->one->path : p->two->path;
@@ -1419,7 +1404,6 @@ static struct blame_origin *find_rename(struct repository *r,
 {
 	struct blame_origin *porigin = NULL;
 	struct diff_options diff_opts;
-	int i;
 
 	repo_diff_setup(r, &diff_opts);
 	diff_opts.flags.recursive = 1;
@@ -1436,7 +1420,7 @@ static struct blame_origin *find_rename(struct repository *r,
 			      "", &diff_opts);
 	diffcore_std(&diff_opts);
 
-	for (i = 0; i < diff_queued_diff.nr; i++) {
+	for (int i = 0; i < diff_queued_diff.nr; i++) {
 		struct diff_filepair *p = diff_queued_diff.queue[i];
 		if ((p->status == 'R' || p->status == 'C') &&
 		    !strcmp(p->two->path, origin->path)) {
@@ -1507,10 +1491,9 @@ static void split_overlap(struct blame_entry *split,
 			  struct blame_origin *parent)
 {
 	int chunk_end_lno;
-	int i;
 	memset(split, 0, sizeof(struct blame_entry [3]));
 
-	for (i = 0; i < 3; i++) {
+	for (int i = 0; i < 3; i++) {
 		split[i].ignored = e->ignored;
 		split[i].unblamable = e->unblamable;
 	}
@@ -1594,9 +1577,7 @@ static void split_blame(struct blame_entry ***blamed,
  */
 static void decref_split(struct blame_entry *split)
 {
-	int i;
-
-	for (i = 0; i < 3; i++)
+	for (int i = 0; i < 3; i++)
 		blame_origin_decref(split[i].suspect);
 }
 
@@ -1661,12 +1642,12 @@ static int scan_parent_range(struct fingerprint *p_fps,
 			     struct fingerprint *t_fps, int t_idx,
 			     int from, int nr_lines)
 {
-	int sim, p_idx;
+	int sim;
 	#define FINGERPRINT_FILE_THRESHOLD	10
 	int best_sim_val = FINGERPRINT_FILE_THRESHOLD;
 	int best_sim_idx = -1;
 
-	for (p_idx = from; p_idx < from + nr_lines; p_idx++) {
+	for (int p_idx = from; p_idx < from + nr_lines; p_idx++) {
 		sim = fingerprint_similarity(&t_fps[t_idx], &p_fps[p_idx]);
 		if (sim < best_sim_val)
 			continue;
@@ -1691,14 +1672,14 @@ static void guess_line_blames(struct blame_origin *parent,
 			      int tlno, int offset, int same, int parent_len,
 			      struct blame_line_tracker *line_blames)
 {
-	int i, best_idx, target_idx;
+	int best_idx, target_idx;
 	int parent_slno = tlno + offset;
 	int *fuzzy_matches;
 
 	fuzzy_matches = fuzzy_find_matching_lines(parent, target,
 						  tlno, parent_slno, same,
 						  parent_len);
-	for (i = 0; i < same - tlno; i++) {
+	for (int i = 0; i < same - tlno; i++) {
 		target_idx = tlno + i;
 		if (fuzzy_matches && fuzzy_matches[i] >= 0) {
 			best_idx = fuzzy_matches[i];
@@ -1735,7 +1716,7 @@ static void ignore_blame_entry(struct blame_entry *e,
 			       struct blame_entry **ignoredp,
 			       struct blame_line_tracker *line_blames)
 {
-	int entry_len, nr_lines, i;
+	int entry_len, nr_lines;
 
 	/*
 	 * We carve new entries off the front of e.  Each entry comes from a
@@ -1744,7 +1725,7 @@ static void ignore_blame_entry(struct blame_entry *e,
 	 */
 	entry_len = 1;
 	nr_lines = e->num_lines;	/* e changes in the loop */
-	for (i = 0; i < nr_lines; i++) {
+	for (int i = 0; i < nr_lines; i++) {
 		struct blame_entry *next = NULL;
 
 		/*
@@ -2012,8 +1993,6 @@ static void copy_split_if_better(struct blame_scoreboard *sb,
 				 struct blame_entry *best_so_far,
 				 struct blame_entry *potential)
 {
-	int i;
-
 	if (!potential[1].suspect)
 		return;
 	if (best_so_far[1].suspect) {
@@ -2022,7 +2001,7 @@ static void copy_split_if_better(struct blame_scoreboard *sb,
 			return;
 	}
 
-	for (i = 0; i < 3; i++)
+	for (int i = 0; i < 3; i++)
 		blame_origin_incref(potential[i].suspect);
 	decref_split(best_so_far);
 	memcpy(best_so_far, potential, sizeof(struct blame_entry[3]));
@@ -2335,7 +2314,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 static void pass_whole_blame(struct blame_scoreboard *sb,
 			     struct blame_origin *origin, struct blame_origin *porigin)
 {
-	struct blame_entry *e, *suspects;
+	struct blame_entry *suspects;
 
 	if (!porigin->file.ptr && origin->file.ptr) {
 		/* Steal its file */
@@ -2344,7 +2323,7 @@ static void pass_whole_blame(struct blame_scoreboard *sb,
 	}
 	suspects = origin->suspects;
 	origin->suspects = NULL;
-	for (e = suspects; e; e = e->next) {
+	for (struct blame_entry *e = suspects; e; e = e->next) {
 		blame_origin_incref(porigin);
 		blame_origin_decref(e->suspect);
 		e->suspect = porigin;
@@ -2409,7 +2388,7 @@ typedef struct blame_origin *(*blame_find_alg)(struct repository *,
 static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin, int opt)
 {
 	struct rev_info *revs = sb->revs;
-	int i, pass, num_sg;
+	int i, num_sg;
 	struct commit *commit = origin->commit;
 	struct commit_list *sg;
 	struct blame_origin *sg_buf[MAXSG];
@@ -2429,7 +2408,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	 * The first pass looks for unrenamed path to optimize for
 	 * common cases, then we look for renames in the second pass.
 	 */
-	for (pass = 0; pass < 2 - sb->no_whole_file_rename; pass++) {
+	for (int pass = 0; pass < 2 - sb->no_whole_file_rename; pass++) {
 		blame_find_alg find = pass ? find_rename : find_origin;
 
 		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
@@ -2656,11 +2635,10 @@ static int prepare_lines(struct blame_scoreboard *sb)
 static struct commit *find_single_final(struct rev_info *revs,
 					const char **name_p)
 {
-	int i;
 	struct commit *found = NULL;
 	const char *name = NULL;
 
-	for (i = 0; i < revs->pending.nr; i++) {
+	for (int i = 0; i < revs->pending.nr; i++) {
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags & UNINTERESTING)
 			continue;
@@ -2719,7 +2697,6 @@ static struct commit *dwim_reverse_initial(struct rev_info *revs,
 static struct commit *find_single_initial(struct rev_info *revs,
 					  const char **name_p)
 {
-	int i;
 	struct commit *found = NULL;
 	const char *name = NULL;
 
@@ -2727,7 +2704,7 @@ static struct commit *find_single_initial(struct rev_info *revs,
 	 * There must be one and only one negative commit, and it must be
 	 * the boundary.
 	 */
-	for (i = 0; i < revs->pending.nr; i++) {
+	for (int i = 0; i < revs->pending.nr; i++) {
 		struct object *obj = revs->pending.objects[i].item;
 		if (!(obj->flags & UNINTERESTING))
 			continue;
@@ -2929,8 +2906,7 @@ void setup_blame_bloom_data(struct blame_scoreboard *sb)
 void cleanup_scoreboard(struct blame_scoreboard *sb)
 {
 	if (sb->bloom_data) {
-		int i;
-		for (i = 0; i < sb->bloom_data->nr; i++) {
+		for (int i = 0; i < sb->bloom_data->nr; i++) {
 			free(sb->bloom_data->keys[i]->hashes);
 			free(sb->bloom_data->keys[i]);
 		}
diff --git a/bloom.c b/bloom.c
index e529f7605c..58bb79e62c 100644
--- a/bloom.c
+++ b/bloom.c
@@ -107,14 +107,13 @@ uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
 	const uint32_t r2 = 13;
 	const uint32_t m = 5;
 	const uint32_t n = 0xe6546b64;
-	int i;
 	uint32_t k1 = 0;
 	const char *tail;
 
 	int len4 = len / sizeof(uint32_t);
 
 	uint32_t k;
-	for (i = 0; i < len4; i++) {
+	for (int i = 0; i < len4; i++) {
 		uint32_t byte1 = (uint32_t)data[4*i];
 		uint32_t byte2 = ((uint32_t)data[4*i + 1]) << 8;
 		uint32_t byte3 = ((uint32_t)data[4*i + 2]) << 16;
@@ -161,14 +160,13 @@ void fill_bloom_key(const char *data,
 		    struct bloom_key *key,
 		    const struct bloom_filter_settings *settings)
 {
-	int i;
 	const uint32_t seed0 = 0x293ae76f;
 	const uint32_t seed1 = 0x7e646e2c;
 	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
 	const uint32_t hash1 = murmur3_seeded(seed1, data, len);
 
 	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
-	for (i = 0; i < settings->num_hashes; i++)
+	for (int i = 0; i < settings->num_hashes; i++)
 		key->hashes[i] = hash0 + i * hash1;
 }
 
@@ -181,10 +179,9 @@ void add_key_to_filter(const struct bloom_key *key,
 		       struct bloom_filter *filter,
 		       const struct bloom_filter_settings *settings)
 {
-	int i;
 	uint64_t mod = filter->len * BITS_PER_WORD;
 
-	for (i = 0; i < settings->num_hashes; i++) {
+	for (int i = 0; i < settings->num_hashes; i++) {
 		uint64_t hash_mod = key->hashes[i] % mod;
 		uint64_t block_pos = hash_mod / BITS_PER_WORD;
 
@@ -224,7 +221,6 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 enum bloom_filter_computed *computed)
 {
 	struct bloom_filter *filter;
-	int i;
 	struct diff_options diffopt;
 
 	if (computed)
@@ -267,7 +263,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 		struct pathmap_hash_entry *e;
 		struct hashmap_iter iter;
 
-		for (i = 0; i < diff_queued_diff.nr; i++) {
+		for (int i = 0; i < diff_queued_diff.nr; i++) {
 			const char *path = diff_queued_diff.queue[i]->two->path;
 
 			/*
@@ -323,7 +319,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	cleanup:
 		hashmap_clear_and_free(&pathmap, struct pathmap_hash_entry, entry);
 	} else {
-		for (i = 0; i < diff_queued_diff.nr; i++)
+		for (int i = 0; i < diff_queued_diff.nr; i++)
 			diff_free_filepair(diff_queued_diff.queue[i]);
 		init_truncated_large_filter(filter);
 
@@ -344,13 +340,12 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
 			  const struct bloom_filter_settings *settings)
 {
-	int i;
 	uint64_t mod = filter->len * BITS_PER_WORD;
 
 	if (!mod)
 		return -1;
 
-	for (i = 0; i < settings->num_hashes; i++) {
+	for (int i = 0; i < settings->num_hashes; i++) {
 		uint64_t hash_mod = key->hashes[i] % mod;
 		uint64_t block_pos = hash_mod / BITS_PER_WORD;
 		if (!(filter->data[block_pos] & get_bitmask(hash_mod)))
diff --git a/branch.c b/branch.c
index 6719a181bd..a2b56f701a 100644
--- a/branch.c
+++ b/branch.c
@@ -216,7 +216,6 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 {
 	const char *bare_ref;
 	struct branch *branch;
-	int i;
 
 	bare_ref = orig_ref;
 	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
@@ -235,7 +234,7 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 	}
 
 	tracking->remote = branch->remote_name;
-	for (i = 0; i < branch->merge_nr; i++)
+	for (int i = 0; i < branch->merge_nr; i++)
 		string_list_append(tracking->srcs, branch->merge_name[i]);
 	return 0;
 }
diff --git a/builtin/add.c b/builtin/add.c
index ada7719561..07052ef827 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -38,9 +38,9 @@ static const char *pathspec_from_file;
 
 static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 {
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < the_index.cache_nr; i++) {
+	for (int i = 0; i < the_index.cache_nr; i++) {
 		struct cache_entry *ce = the_index.cache[i];
 		int err;
 
@@ -66,9 +66,9 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 
 static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 {
-	int i, retval = 0;
+	int retval = 0;
 
-	for (i = 0; i < the_index.cache_nr; i++) {
+	for (int i = 0; i < the_index.cache_nr; i++) {
 		struct cache_entry *ce = the_index.cache[i];
 
 		if (!include_sparse &&
@@ -112,7 +112,7 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
 static int refresh(int verbose, const struct pathspec *pathspec)
 {
 	char *seen;
-	int i, ret = 0;
+	int ret = 0;
 	char *skip_worktree_seen = NULL;
 	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
 	int flags = REFRESH_IGNORE_SKIP_WORKTREE |
@@ -121,7 +121,7 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 	seen = xcalloc(pathspec->nr, 1);
 	refresh_index(&the_index, flags, pathspec, seen,
 		      _("Unstaged changes after refreshing the index:"));
-	for (i = 0; i < pathspec->nr; i++) {
+	for (int i = 0; i < pathspec->nr; i++) {
 		if (!seen[i]) {
 			const char *path = pathspec->items[i].original;
 
@@ -485,7 +485,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 
 	if (pathspec.nr) {
-		int i;
 		char *skip_worktree_seen = NULL;
 		struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
 
@@ -504,7 +503,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			       PATHSPEC_EXCLUDE |
 			       PATHSPEC_ATTR);
 
-		for (i = 0; i < pathspec.nr; i++) {
+		for (int i = 0; i < pathspec.nr; i++) {
 			const char *path = pathspec.items[i].match;
 
 			if (pathspec.items[i].magic & PATHSPEC_EXCLUDE)
diff --git a/builtin/am.c b/builtin/am.c
index d1990d7edc..512e2a150d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2445,7 +2445,6 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			am_append_signoff(&state);
 	} else {
 		struct strvec paths = STRVEC_INIT;
-		int i;
 
 		/*
 		 * Handle stray state directory in the independent-run case. In
@@ -2467,7 +2466,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		if (resume_mode)
 			die(_("Resolve operation not in progress, we are not resuming."));
 
-		for (i = 0; i < argc; i++) {
+		for (int i = 0; i < argc; i++) {
 			if (is_absolute_path(argv[i]) || !prefix)
 				strvec_push(&paths, argv[i]);
 			else
diff --git a/builtin/annotate.c b/builtin/annotate.c
index 58ff977a23..a940f50573 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -10,11 +10,10 @@
 int cmd_annotate(int argc, const char **argv, const char *prefix)
 {
 	struct strvec args = STRVEC_INIT;
-	int i;
 
 	strvec_pushl(&args, "annotate", "-c", NULL);
 
-	for (i = 1; i < argc; i++) {
+	for (int i = 1; i < argc; i++) {
 		strvec_push(&args, argv[i]);
 	}
 
diff --git a/builtin/archive.c b/builtin/archive.c
index 15ee1ec7bb..34db16787e 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -25,7 +25,7 @@ static int run_remote_archiver(int argc, const char **argv,
 			       const char *remote, const char *exec,
 			       const char *name_hint)
 {
-	int fd[2], i, rv;
+	int fd[2], rv;
 	struct transport *transport;
 	struct remote *_remote;
 	struct packet_reader reader;
@@ -47,7 +47,7 @@ static int run_remote_archiver(int argc, const char **argv,
 		if (format)
 			packet_write_fmt(fd[1], "argument --format=%s\n", format);
 	}
-	for (i = 1; i < argc; i++)
+	for (int i = 1; i < argc; i++)
 		packet_write_fmt(fd[1], "argument %s\n", argv[i]);
 	packet_flush(fd[1]);
 
diff --git a/builtin/bisect.c b/builtin/bisect.c
index f69c3f7e43..74a417f334 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -916,7 +916,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
 				      const char **argv)
 {
 	const char *state;
-	int i, verify_expected = 1;
+	int verify_expected = 1;
 	struct object_id oid, expected;
 	struct oid_array revs = OID_ARRAY_INIT;
 
@@ -975,7 +975,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
 	if (read_ref("BISECT_EXPECTED_REV", &expected))
 		verify_expected = 0; /* Ignore invalid file contents */
 
-	for (i = 0; i < revs.nr; i++) {
+	for (int i = 0; i < revs.nr; i++) {
 		if (bisect_write(state, oid_to_hex(&revs.oid[i]), terms, 0)) {
 			oid_array_clear(&revs);
 			return BISECT_FAILED;
@@ -1083,13 +1083,12 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc,
 				     const char **argv)
 {
-	int i;
 	enum bisect_error res;
 	struct strvec argv_state = STRVEC_INIT;
 
 	strvec_push(&argv_state, "skip");
 
-	for (i = 0; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		const char *dotdot = strstr(argv[i], "..");
 
 		if (dotdot) {
diff --git a/builtin/blame.c b/builtin/blame.c
index db1f56de61..b36e9bee72 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -313,7 +313,6 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 	}
 	else {
 		const char *time_str;
-		size_t time_width;
 		int tz;
 		tz = atoi(tz_str);
 		time_str = show_date(time, tz, &blame_date_mode);
@@ -322,9 +321,7 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 		 * Add space paddings to time_buf to display a fixed width
 		 * string, and use time_width for display width calibration.
 		 */
-		for (time_width = utf8_strwidth(time_str);
-		     time_width < blame_date_width;
-		     time_width++)
+		for (size_t time_width = utf8_strwidth(time_str); time_width < blame_date_width; time_width++)
 			strbuf_addch(&time_buf, ' ');
 	}
 	return time_buf.buf;
@@ -354,7 +351,6 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 			   int opt)
 {
 	int repeat = opt & OUTPUT_LINE_PORCELAIN;
-	int cnt;
 	const char *cp;
 	struct blame_origin *suspect = ent->suspect;
 	char hex[GIT_MAX_HEXSZ + 1];
@@ -368,7 +364,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 	emit_porcelain_details(suspect, repeat);
 
 	cp = blame_nth_line(sb, ent->lno);
-	for (cnt = 0; cnt < ent->num_lines; cnt++) {
+	for (int cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		if (cnt) {
 			printf("%s %d %d\n", hex,
@@ -447,7 +443,6 @@ static void determine_line_heat(struct commit_info *ci, const char **dest_color)
 
 static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int opt)
 {
-	int cnt;
 	const char *cp;
 	struct blame_origin *suspect = ent->suspect;
 	struct commit_info ci = COMMIT_INFO_INIT;
@@ -466,7 +461,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 		reset = GIT_COLOR_RESET;
 	}
 
-	for (cnt = 0; cnt < ent->num_lines; cnt++) {
+	for (int cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? the_hash_algo->hexsz : abbrev;
 
@@ -625,11 +620,10 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 	int longest_src_lines = 0;
 	int longest_dst_lines = 0;
 	unsigned largest_score = 0;
-	struct blame_entry *e;
 	int compute_auto_abbrev = (abbrev < 0);
 	int auto_abbrev = DEFAULT_ABBREV;
 
-	for (e = sb->ent; e; e = e->next) {
+	for (struct blame_entry *e = sb->ent; e; e = e->next) {
 		struct blame_origin *suspect = e->suspect;
 		int num;
 
diff --git a/builtin/branch.c b/builtin/branch.c
index cfb63cce5f..774e213461 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -216,7 +216,6 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	struct object_id oid;
 	char *name = NULL;
 	const char *fmt;
-	int i;
 	int ret = 0;
 	int remote_branch = 0;
 	struct strbuf bname = STRBUF_INIT;
@@ -247,7 +246,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	if (!force)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
-	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
+	for (int i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
 		int flags = 0;
 
@@ -339,8 +338,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 {
-	int i, max = 0;
-	for (i = 0; i < refs->nr; i++) {
+	int max = 0;
+	for (int i = 0; i < refs->nr; i++) {
 		struct ref_array_item *it = refs->items[i];
 		const char *desc = it->refname;
 		int w;
@@ -508,9 +507,7 @@ static void print_current_branch_name(void)
 static void reject_rebase_or_bisect_branch(struct worktree **worktrees,
 					   const char *target)
 {
-	int i;
-
-	for (i = 0; worktrees[i]; i++) {
+	for (int i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
 
 		if (!wt->is_detached)
@@ -536,9 +533,7 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
 					     const char *logmsg)
 {
 	int ret = 0;
-	int i;
-
-	for (i = 0; worktrees[i]; i++) {
+	for (int i = 0; worktrees[i]; i++) {
 		struct ref_store *refs;
 
 		if (worktrees[i]->is_detached)
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 3106e56a13..cff8e1624b 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -47,15 +47,13 @@ static void get_system_info(struct strbuf *sys_info)
 
 static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 {
-	const char **p;
-
 	if (nongit) {
 		strbuf_addstr(hook_info,
 			_("not run from a git repository - no hooks to show\n"));
 		return;
 	}
 
-	for (p = hook_name_list; *p; p++) {
+	for (const char **p = hook_name_list; *p; p++) {
 		const char *hook = *p;
 
 		if (hook_exists(hook))
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bbf851138e..82b6d4f2c0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -662,12 +662,10 @@ static void dispatch_calls(struct batch_options *opt,
 		struct queued_cmd *cmd,
 		int nr)
 {
-	int i;
-
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (i = 0; i < nr; i++)
+	for (int i = 0; i < nr; i++)
 		cmd[i].fn(opt, cmd[i].line, output, data);
 
 	fflush(stdout);
@@ -675,9 +673,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index c1da1d184e..1ea30c0670 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -35,10 +35,9 @@ static const struct option check_attr_options[] = {
 
 static void output_attr(struct attr_check *check, const char *file)
 {
-	int j;
 	int cnt = check->nr;
 
-	for (j = 0; j < cnt; j++) {
+	for (int j = 0; j < cnt; j++) {
 		const char *value = check->items[j].value;
 
 		if (ATTR_TRUE(value))
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 906cd96753..f146e3d254 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -75,7 +75,7 @@ static int check_ignore(struct dir_struct *dir,
 {
 	const char *full_path;
 	char *seen;
-	int num_ignored = 0, i;
+	int num_ignored = 0;
 	struct path_pattern *pattern;
 	struct pathspec pathspec;
 
@@ -104,7 +104,7 @@ static int check_ignore(struct dir_struct *dir,
 	 */
 	seen = find_pathspecs_matching_against_index(&pathspec, &the_index,
 						     PS_HEED_SKIP_WORKTREE);
-	for (i = 0; i < pathspec.nr; i++) {
+	for (int i = 0; i < pathspec.nr; i++) {
 		full_path = pathspec.items[i].match;
 		pattern = NULL;
 		if (!seen[i]) {
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index b8a05b8e07..294905528e 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -42,7 +42,6 @@ static void check_mailmap(struct string_list *mailmap, const char *contact)
 
 int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	struct string_list mailmap = STRING_LIST_INIT_NODUP;
 
 	git_config(git_default_config, NULL);
@@ -53,7 +52,7 @@ int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
 
 	read_mailmap(&mailmap);
 
-	for (i = 0; i < argc; ++i)
+	for (int i = 0; i < argc; ++i)
 		check_mailmap(&mailmap, argv[i]);
 	maybe_flush_or_die(stdout, "stdout");
 
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index 6b62b5375b..44264dbbe2 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -81,7 +81,7 @@ static void release_pc_item_data(struct parallel_checkout_item *pc_item)
 static void worker_loop(struct checkout *state)
 {
 	struct parallel_checkout_item *items = NULL;
-	size_t i, nr = 0, alloc = 0;
+	size_t nr = 0, alloc = 0;
 
 	while (1) {
 		int len = packet_read(0, packet_buffer, sizeof(packet_buffer),
@@ -96,7 +96,7 @@ static void worker_loop(struct checkout *state)
 		packet_to_pc_item(packet_buffer, len, &items[nr++]);
 	}
 
-	for (i = 0; i < nr; i++) {
+	for (size_t i = 0; i < nr; i++) {
 		struct parallel_checkout_item *pc_item = &items[i];
 		write_pc_item(pc_item, state);
 		report_result(pc_item);
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 2e086a204d..bb3ffc27ab 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -137,10 +137,10 @@ static int checkout_file(const char *name, const char *prefix)
 
 static int checkout_all(const char *prefix, int prefix_length)
 {
-	int i, errs = 0;
+	int errs = 0;
 	struct cache_entry *last_ce = NULL;
 
-	for (i = 0; i < the_index.cache_nr ; i++) {
+	for (int i = 0; i < the_index.cache_nr; i++) {
 		struct cache_entry *ce = the_index.cache[i];
 
 		if (S_ISSPARSEDIR(ce->ce_mode)) {
@@ -210,7 +210,6 @@ static int option_parse_stage(const struct option *opt,
 
 int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	struct lock_file lock_file = LOCK_INIT;
 	int all = 0;
 	int read_from_stdin = 0;
@@ -290,7 +289,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		init_parallel_checkout();
 
 	/* Check out named files first */
-	for (i = 0; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		char *p;
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 067c251933..1f5e2560a6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -382,7 +382,6 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	struct checkout state = CHECKOUT_INIT;
 	int nr_checkouts = 0, nr_unmerged = 0;
 	int errs = 0;
-	int pos;
 	int pc_workers, pc_threshold;
 	struct mem_pool ce_mem_pool;
 
@@ -401,7 +400,7 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	if (pc_workers > 1)
 		init_parallel_checkout();
 
-	for (pos = 0; pos < the_index.cache_nr; pos++) {
+	for (int pos = 0; pos < the_index.cache_nr; pos++) {
 		struct cache_entry *ce = the_index.cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce)) {
@@ -1290,7 +1289,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 	const char *arg;
 	int dash_dash_pos;
 	int has_dash_dash = 0;
-	int i;
 
 	/*
 	 * case 1: git checkout <ref> -- [<paths>]
@@ -1344,7 +1342,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 
 	arg = argv[0];
 	dash_dash_pos = -1;
-	for (i = 0; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		if (opts->accept_pathspec && !strcmp(argv[i], "--")) {
 			dash_dash_pos = i;
 			break;
diff --git a/builtin/clean.c b/builtin/clean.c
index d90766cad3..2e681f2e67 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -277,8 +277,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	}
 
 	if (!*dir_gone && !quiet) {
-		int i;
-		for (i = 0; i < dels.nr; i++)
+		for (int i = 0; i < dels.nr; i++)
 			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
 	}
 out:
@@ -408,7 +407,7 @@ static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
 {
 	struct menu_item *menu_item;
 	struct string_list_item *string_list_item;
-	int i, len, found = 0;
+	int len, found = 0;
 
 	len = strlen(choice);
 	switch (menu_stuff->type) {
@@ -417,7 +416,7 @@ static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
 	case MENU_STUFF_TYPE_MENU_ITEM:
 
 		menu_item = (struct menu_item *)menu_stuff->stuff;
-		for (i = 0; i < menu_stuff->nr; i++, menu_item++) {
+		for (int i = 0; i < menu_stuff->nr; i++, menu_item++) {
 			if (len == 1 && *choice == menu_item->hotkey) {
 				found = i + 1;
 				break;
@@ -439,7 +438,7 @@ static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
 		break;
 	case MENU_STUFF_TYPE_STRING_LIST:
 		string_list_item = ((struct string_list *)menu_stuff->stuff)->items;
-		for (i = 0; i < menu_stuff->nr; i++, string_list_item++) {
+		for (int i = 0; i < menu_stuff->nr; i++, string_list_item++) {
 			if (!strncasecmp(choice, string_list_item->string, len)) {
 				if (found) {
 					found = 0;
@@ -479,7 +478,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 			struct strbuf input,
 			int **chosen)
 {
-	struct strbuf **choice_list, **ptr;
+	struct strbuf **choice_list;
 	int nr = 0;
 	int i;
 
@@ -494,7 +493,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 		choice_list = strbuf_split_max(&input, ' ', 0);
 	}
 
-	for (ptr = choice_list; *ptr; ptr++) {
+	for (struct strbuf **ptr = choice_list; *ptr; ptr++) {
 		char *p;
 		int choose = 1;
 		int bottom = 0, top = 0;
@@ -886,9 +885,9 @@ static void interactive_main_loop(void)
 
 static void correct_untracked_entries(struct dir_struct *dir)
 {
-	int src, dst, ign;
+	int dst, ign;
 
-	for (src = dst = ign = 0; src < dir->nr; src++) {
+	for (int src = dst = ign = 0; src < dir->nr; src++) {
 		/* skip paths in ignored[] that cannot be inside entries[src] */
 		while (ign < dir->ignored_nr &&
 		       0 <= cmp_dir_entry(&dir->entries[src], &dir->ignored[ign]))
diff --git a/builtin/clone.c b/builtin/clone.c
index bad1b70ce8..a1abcbdf31 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -511,8 +511,7 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 			warning(_("Could not find remote branch %s to clone."),
 				option_branch);
 		else {
-			int i;
-			for (i = 0; i < refspec->nr; i++)
+			for (int i = 0; i < refspec->nr; i++)
 				get_fetch_map(remote_head, &refspec->items[i],
 					      &tail, 0);
 
@@ -521,8 +520,7 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 		}
 		free_refs(remote_head);
 	} else {
-		int i;
-		for (i = 0; i < refspec->nr; i++)
+		for (int i = 0; i < refspec->nr; i++)
 			get_fetch_map(refs, &refspec->items[i], &tail, 0);
 	}
 
@@ -534,8 +532,6 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 
 static void write_remote_refs(const struct ref *local_refs)
 {
-	const struct ref *r;
-
 	struct ref_transaction *t;
 	struct strbuf err = STRBUF_INIT;
 
@@ -543,7 +539,7 @@ static void write_remote_refs(const struct ref *local_refs)
 	if (!t)
 		die("%s", err.buf);
 
-	for (r = local_refs; r; r = r->next) {
+	for (const struct ref *r = local_refs; r; r = r->next) {
 		if (!r->peer_ref)
 			continue;
 		if (ref_transaction_create(t, r->peer_ref->name, &r->old_oid,
@@ -560,8 +556,7 @@ static void write_remote_refs(const struct ref *local_refs)
 
 static void write_followtags(const struct ref *refs, const char *msg)
 {
-	const struct ref *ref;
-	for (ref = refs; ref; ref = ref->next) {
+	for (const struct ref *ref = refs; ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
 		if (ends_with(ref->name, "^{}"))
@@ -826,9 +821,7 @@ static int write_one_config(const char *key, const char *value,
 
 static void write_config(struct string_list *config)
 {
-	int i;
-
-	for (i = 0; i < config->nr; i++) {
+	for (int i = 0; i < config->nr; i++) {
 		if (git_config_parse_parameter(config->items[i].string,
 					       write_one_config, NULL) < 0)
 			die(_("unable to write parameters to config file"));
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 1bb7819839..4dacdefa2f 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -25,8 +25,7 @@ static const char *sign_commit;
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
 	struct object_id *oid = &parent->object.oid;
-	struct commit_list *parents;
-	for (parents = *parents_p; parents; parents = parents->next) {
+	for (struct commit_list *parents = *parents_p; parents; parents = parents->next) {
 		if (parents->item == parent) {
 			error(_("duplicate parent %s ignored"), oid_to_hex(oid));
 			return;
diff --git a/builtin/commit.c b/builtin/commit.c
index 6d1fa71676..1782909eef 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -256,7 +256,7 @@ static int commit_index_files(void)
 static int list_paths(struct string_list *list, const char *with_tree,
 		      const struct pathspec *pattern)
 {
-	int i, ret;
+	int ret;
 	char *m;
 
 	if (!pattern->nr)
@@ -272,7 +272,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&the_index);
-	for (i = 0; i < the_index.cache_nr; i++) {
+	for (int i = 0; i < the_index.cache_nr; i++) {
 		const struct cache_entry *ce = the_index.cache[i];
 		struct string_list_item *item;
 
@@ -292,8 +292,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 
 static void add_remove_files(struct string_list *list)
 {
-	int i;
-	for (i = 0; i < list->nr; i++) {
+	for (int i = 0; i < list->nr; i++) {
 		struct stat st;
 		struct string_list_item *p = &(list->items[i]);
 
@@ -1001,11 +1000,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			parent = "HEAD^1";
 
 		if (repo_get_oid(the_repository, parent, &oid)) {
-			int i, ita_nr = 0;
+			int ita_nr = 0;
 
 			/* TODO: audit for interaction with sparse-index. */
 			ensure_full_index(&the_index);
-			for (i = 0; i < the_index.cache_nr; i++)
+			for (int i = 0; i < the_index.cache_nr; i++)
 				if (ce_intent_to_add(the_index.cache[i]))
 					ita_nr++;
 			committable = the_index.cache_nr - ita_nr > 0;
diff --git a/builtin/config.c b/builtin/config.c
index b55bfae7d6..10a181daec 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -333,7 +333,6 @@ static int get_value(const char *key_, const char *regex_, unsigned flags)
 {
 	int ret = CONFIG_GENERIC_ERROR;
 	struct strbuf_list values = {NULL};
-	int i;
 
 	if (use_key_regexp) {
 		char *tl;
@@ -402,7 +401,7 @@ static int get_value(const char *key_, const char *regex_, unsigned flags)
 
 	ret = !values.nr;
 
-	for (i = 0; i < values.nr; i++) {
+	for (int i = 0; i < values.nr; i++) {
 		struct strbuf *buf = values.items + i;
 		if (do_all || i == values.nr - 1)
 			fwrite(buf->buf, 1, buf->len, stdout);
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 2d4bb5e8d0..5e8731d3f4 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -120,14 +120,13 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 				      count_loose, count_cruft, NULL, NULL);
 
 	if (verbose) {
-		struct packed_git *p;
 		unsigned long num_pack = 0;
 		off_t size_pack = 0;
 		struct strbuf loose_buf = STRBUF_INIT;
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
 
-		for (p = get_all_packs(the_repository); p; p = p->next) {
+		for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
 			if (!p->pack_local)
 				continue;
 			if (open_pack_index(p))
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 3a6a750a8e..09a30ceafc 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -34,8 +34,7 @@ static void cache_credential(struct credential *c, int timeout)
 
 static struct credential_cache_entry *lookup_credential(const struct credential *c)
 {
-	int i;
-	for (i = 0; i < entries_nr; i++) {
+	for (int i = 0; i < entries_nr; i++) {
 		struct credential *e = &entries[i].item;
 		if (credential_match(c, e, 0))
 			return &entries[i];
@@ -45,10 +44,7 @@ static struct credential_cache_entry *lookup_credential(const struct credential
 
 static void remove_credential(const struct credential *c, int match_password)
 {
-	struct credential_cache_entry *e;
-
-	int i;
-	for (i = 0; i < entries_nr; i++) {
+	struct credential_cache_entry *e;for (int i = 0; i < entries_nr; i++) {
 		e = &entries[i];
 		if (credential_match(c, &e->item, match_password))
 			e->expiration = 0;
diff --git a/builtin/describe.c b/builtin/describe.c
index d6c77a714f..59b22e27c3 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -450,8 +450,8 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	if (debug) {
 		static int label_width = -1;
 		if (label_width < 0) {
-			int i, w;
-			for (i = 0; i < ARRAY_SIZE(prio_names); i++) {
+			int w;
+			for (int i = 0; i < ARRAY_SIZE(prio_names); i++) {
 				w = strlen(_(prio_names[i]));
 				if (label_width < w)
 					label_width = w;
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 3e05260ac0..2b47986df4 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -18,7 +18,6 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 	unsigned int option = 0;
-	int i;
 	int result;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -36,7 +35,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	diff_merges_suppress_m_parsing();
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
-	for (i = 1; i < argc; i++) {
+	for (int i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
 		if (!strcmp(arg, "--cached"))
diff --git a/builtin/diff.c b/builtin/diff.c
index 6e196e0c7d..f9779a4c8d 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -211,7 +211,6 @@ static void builtin_diff_combined(struct rev_info *revs,
 				  int ents, int first_non_parent)
 {
 	struct oid_array parents = OID_ARRAY_INIT;
-	int i;
 
 	if (argc > 1)
 		usage(builtin_diff_usage);
@@ -223,7 +222,7 @@ static void builtin_diff_combined(struct rev_info *revs,
 
 	diff_merges_set_dense_combined_if_unset(revs);
 
-	for (i = 0; i < ents; i++) {
+	for (int i = 0; i < ents; i++) {
 		if (i != first_non_parent)
 			oid_array_append(&parents, &ent[i].item->oid);
 	}
@@ -313,7 +312,7 @@ struct symdiff {
  */
 static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
 {
-	int i, is_symdiff = 0, basecount = 0, othercount = 0;
+	int is_symdiff = 0, basecount = 0, othercount = 0;
 	int lpos = -1, rpos = -1, basepos = -1;
 	struct bitmap *map = NULL;
 
@@ -332,7 +331,7 @@ static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
 	 * so we must check for SYMMETRIC_LEFT too.  The two arrays
 	 * rev->pending.objects and rev->cmdline.rev are parallel.
 	 */
-	for (i = 0; i < rev->cmdline.nr; i++) {
+	for (int i = 0; i < rev->cmdline.nr; i++) {
 		struct object *obj = rev->pending.objects[i].item;
 		switch (rev->cmdline.rev[i].whence) {
 		case REV_CMD_MERGE_BASE:
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 4693d18cc9..6cebf8f4ab 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -430,7 +430,6 @@ static const char *anonymize_oid(const char *oid_hex)
 static void show_filemodify(struct diff_queue_struct *q,
 			    struct diff_options *options UNUSED, void *data)
 {
-	int i;
 	struct string_list *changed = data;
 
 	/*
@@ -439,7 +438,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 	 */
 	QSORT(q->queue, q->nr, depth_first);
 
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filespec *ospec = q->queue[i]->one;
 		struct diff_filespec *spec = q->queue[i]->two;
 
@@ -543,10 +542,9 @@ static const char *anonymize_refname(const char *refname)
 	};
 	static struct hashmap refs;
 	static struct strbuf anon = STRBUF_INIT;
-	int i;
 
 	strbuf_reset(&anon);
-	for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
+	for (int i = 0; i < ARRAY_SIZE(prefixes); i++) {
 		if (skip_prefix(refname, prefixes[i], &refname)) {
 			strbuf_addstr(&anon, prefixes[i]);
 			break;
@@ -926,9 +924,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
 
 static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 {
-	int i;
-
-	for (i = 0; i < info->nr; i++) {
+	for (int i = 0; i < info->nr; i++) {
 		struct rev_cmdline_entry *e = info->rev + i;
 		struct object_id oid;
 		struct commit *commit;
@@ -988,9 +984,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 static void handle_tags_and_duplicates(struct string_list *extras)
 {
 	struct commit *commit;
-	int i;
-
-	for (i = extras->nr - 1; i >= 0; i--) {
+	for (int i = extras->nr - 1; i >= 0; i--) {
 		const char *name = extras->items[i].string;
 		struct object *object = extras->items[i].util;
 		int mark;
@@ -1050,7 +1044,6 @@ static void handle_tags_and_duplicates(struct string_list *extras)
 
 static void export_marks(char *file)
 {
-	unsigned int i;
 	uint32_t mark;
 	struct decoration_entry *deco = idnums.entries;
 	FILE *f;
@@ -1060,7 +1053,7 @@ static void export_marks(char *file)
 	if (!f)
 		die_errno("Unable to open marks file %s for writing.", file);
 
-	for (i = 0; i < idnums.size; i++) {
+	for (unsigned int i = 0; i < idnums.size; i++) {
 		if (deco->base && deco->base->type == 1) {
 			mark = ptr_to_mark(deco->decoration);
 			if (fprintf(f, ":%"PRIu32" %s\n", mark,
@@ -1135,8 +1128,7 @@ static void import_marks(char *input_file, int check_exists)
 
 static void handle_deletes(void)
 {
-	int i;
-	for (i = 0; i < refspecs.nr; i++) {
+	for (int i = 0; i < refspecs.nr; i++) {
 		struct refspec_item *refspec = &refspecs.items[i];
 		if (*refspec->src)
 			continue;
@@ -1247,9 +1239,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		die(_("the option '%s' requires '%s'"), "--anonymize-map", "--anonymize");
 
 	if (refspecs_list.nr) {
-		int i;
-
-		for (i = 0; i < refspecs_list.nr; i++)
+		for (int i = 0; i < refspecs_list.nr; i++)
 			refspec_append(&refspecs, refspecs_list.items[i].string);
 
 		string_list_clear(&refspecs_list, 1);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 92eda20683..4fd4b9284a 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -273,14 +273,13 @@ static void parse_ls(const char *p, struct branch *b);
 
 static void for_each_mark(struct mark_set *m, uintmax_t base, each_mark_fn_t callback, void *p)
 {
-	uintmax_t k;
 	if (m->shift) {
-		for (k = 0; k < 1024; k++) {
+		for (uintmax_t k = 0; k < 1024; k++) {
 			if (m->data.sets[k])
 				for_each_mark(m->data.sets[k], base + (k << m->shift), callback, p);
 		}
 	} else {
-		for (k = 0; k < 1024; k++) {
+		for (uintmax_t k = 0; k < 1024; k++) {
 			if (m->data.marked[k])
 				callback(base + k, m->data.marked[k], p);
 		}
@@ -328,7 +327,6 @@ static void write_crash_report(const char *err)
 	FILE *rpt = fopen(loc, "w");
 	struct branch *b;
 	unsigned long lu;
-	struct recent_command *rc;
 
 	if (!rpt) {
 		error_errno("can't write crash report %s", loc);
@@ -351,7 +349,7 @@ static void write_crash_report(const char *err)
 	fputc('\n', rpt);
 	fputs("Most Recent Commands Before Crash\n", rpt);
 	fputs("---------------------------------\n", rpt);
-	for (rc = cmd_hist.next; rc != &cmd_hist; rc = rc->next) {
+	for (struct recent_command *rc = cmd_hist.next; rc != &cmd_hist; rc = rc->next) {
 		if (rc->next == &cmd_hist)
 			fputs("* ", rpt);
 		else
@@ -382,11 +380,10 @@ static void write_crash_report(const char *err)
 	}
 
 	if (first_tag) {
-		struct tag *tg;
 		fputc('\n', rpt);
 		fputs("Annotated Tags\n", rpt);
 		fputs("--------------\n", rpt);
-		for (tg = first_tag; tg; tg = tg->next_tag) {
+		for (struct tag *tg = first_tag; tg; tg = tg->next_tag) {
 			fputs(oid_to_hex(&tg->oid), rpt);
 			fputc(' ', rpt);
 			fputs(tg->name, rpt);
@@ -511,8 +508,6 @@ static struct object_entry *insert_object(struct object_id *oid)
 
 static void invalidate_pack_id(unsigned int id)
 {
-	unsigned long lu;
-	struct tag *t;
 	struct hashmap_iter iter;
 	struct object_entry *e;
 
@@ -521,7 +516,7 @@ static void invalidate_pack_id(unsigned int id)
 			e->pack_id = MAX_PACK_ID;
 	}
 
-	for (lu = 0; lu < branch_table_sz; lu++) {
+	for (unsigned long lu = 0; lu < branch_table_sz; lu++) {
 		struct branch *b;
 
 		for (b = branch_table[lu]; b; b = b->table_next_branch)
@@ -529,7 +524,7 @@ static void invalidate_pack_id(unsigned int id)
 				b->pack_id = MAX_PACK_ID;
 	}
 
-	for (t = first_tag; t; t = t->next_tag)
+	for (struct tag *t = first_tag; t; t = t->next_tag)
 		if (t->pack_id == id)
 			t->pack_id = MAX_PACK_ID;
 }
@@ -606,9 +601,7 @@ static struct atom_str *to_atom(const char *s, unsigned short len)
 static struct branch *lookup_branch(const char *name)
 {
 	unsigned int hc = hc_str(name, strlen(name)) % branch_table_sz;
-	struct branch *b;
-
-	for (b = branch_table[hc]; b; b = b->table_next_branch)
+	for (struct branch *b = branch_table[hc]; b; b = b->table_next_branch)
 		if (!strcmp(name, b->name))
 			return b;
 	return NULL;
@@ -681,8 +674,7 @@ static void release_tree_content(struct tree_content *t)
 
 static void release_tree_content_recursive(struct tree_content *t)
 {
-	unsigned int i;
-	for (i = 0; i < t->entry_count; i++)
+	for (unsigned int i = 0; i < t->entry_count; i++)
 		release_tree_entry(t->entries[i]);
 	release_tree_content(t);
 }
@@ -732,12 +724,11 @@ static struct tree_content *dup_tree_content(struct tree_content *s)
 {
 	struct tree_content *d;
 	struct tree_entry *a, *b;
-	unsigned int i;
 
 	if (!s)
 		return NULL;
 	d = new_tree_content(s->entry_count);
-	for (i = 0; i < s->entry_count; i++) {
+	for (unsigned int i = 0; i < s->entry_count; i++) {
 		a = s->entries[i];
 		b = new_tree_entry();
 		memcpy(b, a, sizeof(*a));
@@ -780,12 +771,11 @@ static const char *create_index(void)
 	const char *tmpfile;
 	struct pack_idx_entry **idx, **c, **last;
 	struct object_entry *e;
-	struct object_entry_pool *o;
 
 	/* Build the table of object IDs. */
 	ALLOC_ARRAY(idx, object_count);
 	c = idx;
-	for (o = blocks; o; o = o->next_pool)
+	for (struct object_entry_pool *o = blocks; o; o = o->next_pool)
 		for (e = o->next_free; e-- != o->entries;)
 			if (pack_id == e->pack_id)
 				*c++ = &e->idx;
@@ -827,9 +817,7 @@ static char *keep_pack(const char *curr_index_name)
 static void unkeep_all_packs(void)
 {
 	struct strbuf name = STRBUF_INIT;
-	int k;
-
-	for (k = 0; k < pack_id; k++) {
+	for (int k = 0; k < pack_id; k++) {
 		struct packed_git *p = all_packs[k];
 		odb_pack_name(&name, p->hash, "keep");
 		unlink_or_warn(name.buf);
@@ -1416,7 +1404,7 @@ static int tree_content_set(
 {
 	struct tree_content *t;
 	const char *slash1;
-	unsigned int i, n;
+	unsigned int n;
 	struct tree_entry *e;
 
 	slash1 = strchrnul(p, '/');
@@ -1429,7 +1417,7 @@ static int tree_content_set(
 	if (!root->tree)
 		load_tree(root);
 	t = root->tree;
-	for (i = 0; i < t->entry_count; i++) {
+	for (unsigned int i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !fspathncmp(p, e->name->str_dat, n)) {
 			if (!*slash1) {
@@ -1504,7 +1492,7 @@ static int tree_content_remove(
 {
 	struct tree_content *t;
 	const char *slash1;
-	unsigned int i, n;
+	unsigned int n;
 	struct tree_entry *e;
 
 	slash1 = strchrnul(p, '/');
@@ -1519,7 +1507,7 @@ static int tree_content_remove(
 	}
 
 	t = root->tree;
-	for (i = 0; i < t->entry_count; i++) {
+	for (unsigned int i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !fspathncmp(p, e->name->str_dat, n)) {
 			if (*slash1 && !S_ISDIR(e->versions[1].mode))
@@ -1569,7 +1557,7 @@ static int tree_content_get(
 {
 	struct tree_content *t;
 	const char *slash1;
-	unsigned int i, n;
+	unsigned int n;
 	struct tree_entry *e;
 
 	slash1 = strchrnul(p, '/');
@@ -1586,7 +1574,7 @@ static int tree_content_get(
 	}
 
 	t = root->tree;
-	for (i = 0; i < t->entry_count; i++) {
+	for (unsigned int i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !fspathncmp(p, e->name->str_dat, n)) {
 			if (!*slash1)
@@ -1658,10 +1646,9 @@ static int update_branch(struct branch *b)
 
 static void dump_branches(void)
 {
-	unsigned int i;
 	struct branch *b;
 
-	for (i = 0; i < branch_table_sz; i++) {
+	for (unsigned int i = 0; i < branch_table_sz; i++) {
 		for (b = branch_table[i]; b; b = b->table_next_branch)
 			failure |= update_branch(b);
 	}
@@ -1670,7 +1657,6 @@ static void dump_branches(void)
 static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
-	struct tag *t;
 	struct strbuf ref_name = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction;
@@ -1680,7 +1666,7 @@ static void dump_tags(void)
 		failure |= error("%s", err.buf);
 		goto cleanup;
 	}
-	for (t = first_tag; t; t = t->next_tag) {
+	for (struct tag *t = first_tag; t; t = t->next_tag) {
 		strbuf_reset(&ref_name);
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
@@ -2105,7 +2091,7 @@ static uintmax_t do_change_note_fanout(
 {
 	struct tree_content *t;
 	struct tree_entry *e, leaf;
-	unsigned int i, tmp_hex_oid_len, tmp_fullpath_len;
+	unsigned int tmp_hex_oid_len, tmp_fullpath_len;
 	uintmax_t num_notes = 0;
 	struct object_id oid;
 	/* hex oid + '/' between each pair of hex digits + NUL */
@@ -2116,7 +2102,7 @@ static uintmax_t do_change_note_fanout(
 		load_tree(root);
 	t = root->tree;
 
-	for (i = 0; t && i < t->entry_count; i++) {
+	for (unsigned int i = 0; t && i < t->entry_count; i++) {
 		e = t->entries[i];
 		tmp_hex_oid_len = hex_oid_len + e->name->str_len;
 		tmp_fullpath_len = fullpath_len;
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 44c05ee86c..577d2d0db9 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -242,11 +242,9 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED)
 	ref = fetch_pack(&args, fd, ref, sought, nr_sought,
 			 &shallow, pack_lockfiles_ptr, version);
 	if (pack_lockfiles.nr) {
-		int i;
-
 		printf("lock %s\n", pack_lockfiles.items[0].string);
 		fflush(stdout);
-		for (i = 1; i < pack_lockfiles.nr; i++)
+		for (int i = 1; i < pack_lockfiles.nr; i++)
 			warning(_("Lockfile created but not reported: %s"),
 				pack_lockfiles.items[i].string);
 	}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3aedfd1bb6..08ebb55d0d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -210,9 +210,7 @@ static void add_merge_config(struct ref **head,
 		           struct branch *branch,
 		           struct ref ***tail)
 {
-	int i;
-
-	for (i = 0; i < branch->merge_nr; i++) {
+	for (int i = 0; i < branch->merge_nr; i++) {
 		struct ref *rm, **old_tail = *tail;
 		struct refspec_item refspec;
 
@@ -331,7 +329,6 @@ static void find_non_local_tags(const struct ref *refs,
 	struct oidset fetch_oids = OIDSET_INIT;
 	struct string_list remote_refs_list = STRING_LIST_INIT_NODUP;
 	struct string_list_item *remote_ref_item;
-	const struct ref *ref;
 	struct refname_hash_entry *item = NULL;
 	const int quick_flags = OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT;
 
@@ -350,7 +347,7 @@ static void find_non_local_tags(const struct ref *refs,
 						       add_already_queued_tags,
 						       &existing_refs);
 
-	for (ref = refs; ref; ref = ref->next) {
+	for (const struct ref *ref = refs; ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
 
@@ -434,12 +431,10 @@ static void find_non_local_tags(const struct ref *refs,
 
 static void filter_prefetch_refspec(struct refspec *rs)
 {
-	int i;
-
 	if (!prefetch)
 		return;
 
-	for (i = 0; i < rs->nr; i++) {
+	for (int i = 0; i < rs->nr; i++) {
 		struct strbuf new_dst = STRBUF_INIT;
 		char *old_dst;
 		const char *sub = NULL;
@@ -698,14 +693,13 @@ static int s_update_ref(const char *action,
 
 static int refcol_width(const struct ref *ref_map, int compact_format)
 {
-	const struct ref *ref;
 	int max, width = 10;
 
 	max = term_columns();
 	if (compact_format)
 		max = max * 2 / 3;
 
-	for (ref = ref_map; ref; ref = ref->next) {
+	for (const struct ref *ref = ref_map; ref; ref = ref->next) {
 		int rlen, llen = 0, len;
 
 		if (ref->status == REF_STATUS_REJECT_SHALLOW ||
@@ -1138,7 +1132,6 @@ static int store_updated_refs(struct display_state *display_state,
 	struct strbuf note = STRBUF_INIT;
 	const char *what, *kind;
 	struct ref *rm;
-	int want_status;
 	int summary_width = 0;
 
 	if (verbosity >= 0)
@@ -1161,9 +1154,7 @@ static int store_updated_refs(struct display_state *display_state,
 	 * merged entries are written before not-for-merge. That lets readers
 	 * use FETCH_HEAD as a refname to refer to the ref to be merged.
 	 */
-	for (want_status = FETCH_HEAD_MERGE;
-	     want_status <= FETCH_HEAD_IGNORE;
-	     want_status++) {
+	for (int want_status = FETCH_HEAD_MERGE; want_status <= FETCH_HEAD_IGNORE; want_status++) {
 		for (rm = ref_map; rm; rm = rm->next) {
 			struct ref *ref = NULL;
 
@@ -1294,7 +1285,6 @@ static int check_exist_and_connected(struct ref *ref_map)
 {
 	struct ref *rm = ref_map;
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
-	struct ref *r;
 
 	/*
 	 * If we are deepening a shallow clone we already have these
@@ -1318,7 +1308,7 @@ static int check_exist_and_connected(struct ref *ref_map)
 	 * check_connected() allows objects to merely be promised, but
 	 * we need all direct targets to exist.
 	 */
-	for (r = rm; r; r = r->next) {
+	for (struct ref *r = rm; r; r = r->next) {
 		if (!repo_has_object_file_with_flags(the_repository, &r->old_oid,
 						     OBJECT_INFO_SKIP_FETCH_OBJECT))
 			return -1;
@@ -1462,9 +1452,7 @@ static int add_oid(const char *refname UNUSED,
 static void add_negotiation_tips(struct git_transport_options *smart_options)
 {
 	struct oid_array *oids = xcalloc(1, sizeof(*oids));
-	int i;
-
-	for (i = 0; i < negotiation_tip.nr; i++) {
+	for (int i = 0; i < negotiation_tip.nr; i++) {
 		const char *s = negotiation_tip.items[i].string;
 		int old_nr;
 		if (!has_glob_specials(s)) {
@@ -1592,8 +1580,6 @@ static int do_fetch(struct transport *transport,
 	}
 
 	if (rs->nr) {
-		int i;
-
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 
 		/*
@@ -1601,7 +1587,7 @@ static int do_fetch(struct transport *transport,
 		 * OIDs
 		 */
 		must_list_refs = 0;
-		for (i = 0; i < rs->nr; i++) {
+		for (int i = 0; i < rs->nr; i++) {
 			if (!rs->items[i].exact_sha1) {
 				must_list_refs = 1;
 				break;
@@ -1615,8 +1601,7 @@ static int do_fetch(struct transport *transport,
 					     &transport_ls_refs_options.ref_prefixes);
 		if (branch_has_merge_config(branch) &&
 		    !strcmp(branch->remote_name, transport->remote->name)) {
-			int i;
-			for (i = 0; i < branch->merge_nr; i++) {
+			for (int i = 0; i < branch->merge_nr; i++) {
 				strvec_push(&transport_ls_refs_options.ref_prefixes,
 					    branch->merge[i]->src);
 			}
@@ -1725,7 +1710,6 @@ static int do_fetch(struct transport *transport,
 
 	if (set_upstream) {
 		struct branch *branch = branch_get("HEAD");
-		struct ref *rm;
 		struct ref *source_ref = NULL;
 
 		/*
@@ -1738,7 +1722,7 @@ static int do_fetch(struct transport *transport,
 		 * request ambiguous and err on the safe side by doing
 		 * nothing and just emit a warning.
 		 */
-		for (rm = ref_map; rm; rm = rm->next) {
+		for (struct ref *rm = ref_map; rm; rm = rm->next) {
 			if (!rm->peer_ref) {
 				if (source_ref) {
 					warning(_("multiple branches detected, incompatible with --set-upstream"));
@@ -2049,7 +2033,6 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 		     const struct fetch_config *config)
 {
 	struct refspec rs = REFSPEC_INIT_FETCH;
-	int i;
 	int exit_code;
 	int maybe_prune_tags;
 	int remote_via_config = remote_is_configured(remote, 0);
@@ -2087,7 +2070,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	if (maybe_prune_tags && (argc || !remote_via_config))
 		refspec_append(&rs, TAG_REFSPEC);
 
-	for (i = 0; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		if (!strcmp(argv[i], "tag")) {
 			i++;
 			if (i >= argc)
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 28186b30f5..4fc94e2b2c 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -14,14 +14,13 @@ static const char * const for_each_repo_usage[] = {
 
 static int run_command_on_repo(const char *path, int argc, const char ** argv)
 {
-	int i;
 	struct child_process child = CHILD_PROCESS_INIT;
 	char *abspath = interpolate_path(path, 0);
 
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "-C", abspath, NULL);
 
-	for (i = 0; i < argc; i++)
+	for (int i = 0; i < argc; i++)
 		strvec_push(&child.args, argv[i]);
 
 	free(abspath);
@@ -32,7 +31,7 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
 int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 {
 	static const char *config_key = NULL;
-	int i, result = 0;
+	int result = 0;
 	const struct string_list *values;
 	int err;
 
@@ -55,7 +54,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	else if (err)
 		return 0;
 
-	for (i = 0; !result && i < values->nr; i++)
+	for (int i = 0; !result && i < values->nr; i++)
 		result = run_command_on_repo(values->items[i].string, argc, argv);
 
 	return result;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index a7cf94f67e..52084409d6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -366,7 +366,7 @@ static void check_object(struct object *obj)
 
 static void check_connectivity(void)
 {
-	int i, max;
+	int max;
 
 	/* Traverse the pending reachable objects */
 	traverse_reachable();
@@ -396,7 +396,7 @@ static void check_connectivity(void)
 	if (verbose)
 		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);
 
-	for (i = 0; i < max; i++) {
+	for (int i = 0; i < max; i++) {
 		struct object *obj = get_indexed_object(i);
 
 		if (obj)
@@ -561,14 +561,14 @@ static int fsck_head_link(const char *head_ref_name,
 
 static void get_default_heads(void)
 {
-	struct worktree **worktrees, **p;
+	struct worktree **worktrees;
 	const char *head_points_at;
 	struct object_id head_oid;
 
 	for_each_rawref(fsck_handle_ref, NULL);
 
 	worktrees = get_worktrees();
-	for (p = worktrees; *p; p++) {
+	for (struct worktree **p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 		struct strbuf ref = STRBUF_INIT;
 
@@ -742,7 +742,6 @@ static int fsck_head_link(const char *head_ref_name,
 
 static int fsck_cache_tree(struct cache_tree *it, const char *index_path)
 {
-	int i;
 	int err = 0;
 
 	if (verbose)
@@ -762,7 +761,7 @@ static int fsck_cache_tree(struct cache_tree *it, const char *index_path)
 		if (obj->type != OBJ_TREE)
 			err |= objerror(obj, _("non-tree in cache-tree"));
 	}
-	for (i = 0; i < it->subtree_nr; i++)
+	for (int i = 0; i < it->subtree_nr; i++)
 		err |= fsck_cache_tree(it->down[i]->cache_tree, index_path);
 	return err;
 }
@@ -809,11 +808,9 @@ static int fsck_resolve_undo(struct index_state *istate,
 static void fsck_index(struct index_state *istate, const char *index_path,
 		       int is_current_worktree)
 {
-	unsigned int i;
-
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(istate);
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (unsigned int i = 0; i < istate->cache_nr; i++) {
 		unsigned int mode;
 		struct blob *blob;
 		struct object *obj;
@@ -921,7 +918,6 @@ static struct option fsck_opts[] = {
 
 int cmd_fsck(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	struct object_directory *odb;
 
 	/* fsck knows how to handle missing promisor objects */
@@ -994,7 +990,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			errors_found |= ERROR_OBJECT;
 	}
 
-	for (i = 0; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		struct object_id oid;
 		if (!repo_get_oid(the_repository, arg, &oid)) {
@@ -1030,13 +1026,13 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	if (keep_cache_objects) {
-		struct worktree **worktrees, **p;
+		struct worktree **worktrees;
 
 		verify_index_checksum = 1;
 		verify_ce_order = 1;
 
 		worktrees = get_worktrees();
-		for (p = worktrees; *p; p++) {
+		for (struct worktree **p = worktrees; *p; p++) {
 			struct worktree *wt = *p;
 			struct index_state istate =
 				INDEX_STATE_INIT(the_repository);
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 1593713f4c..054e79dd03 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -227,12 +227,9 @@ static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
 static void with_lock__mark_cookies_seen(struct fsmonitor_daemon_state *state,
 					 const struct string_list *cookie_names)
 {
-	/* assert current thread holding state->main_lock */
-
-	int k;
 	int nr_seen = 0;
 
-	for (k = 0; k < cookie_names->nr; k++) {
+	for (int k = 0; k < cookie_names->nr; k++) {
 		struct fsmonitor_cookie_item key;
 		struct fsmonitor_cookie_item *cookie;
 
@@ -468,13 +465,11 @@ void fsmonitor_batch__add_path(struct fsmonitor_batch *batch,
 static void fsmonitor_batch__combine(struct fsmonitor_batch *batch_dest,
 				     const struct fsmonitor_batch *batch_src)
 {
-	size_t k;
-
 	ALLOC_GROW(batch_dest->interned_paths,
 		   batch_dest->nr + batch_src->nr + 1,
 		   batch_dest->alloc);
 
-	for (k = 0; k < batch_src->nr; k++)
+	for (size_t k = 0; k < batch_src->nr; k++)
 		batch_dest->interned_paths[batch_dest->nr++] =
 			batch_src->interned_paths[k];
 }
@@ -512,9 +507,6 @@ static struct fsmonitor_batch *with_lock__truncate_old_batches(
 	struct fsmonitor_daemon_state *state,
 	const struct fsmonitor_batch *batch_marker)
 {
-	/* assert current thread holding state->main_lock */
-
-	const struct fsmonitor_batch *batch;
 	struct fsmonitor_batch *remainder;
 
 	if (!batch_marker)
@@ -524,7 +516,7 @@ static struct fsmonitor_batch *with_lock__truncate_old_batches(
 			 batch_marker->batch_seq_nr,
 			 (uint64_t)batch_marker->pinned_time);
 
-	for (batch = batch_marker; batch; batch = batch->next) {
+	for (const struct fsmonitor_batch *batch = batch_marker; batch; batch = batch->next) {
 		time_t t;
 
 		if (!batch->pinned_time) /* an overflow batch */
diff --git a/builtin/gc.c b/builtin/gc.c
index cb80ced6cb..1151f59d76 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -80,8 +80,7 @@ static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
 
 static void clean_pack_garbage(void)
 {
-	int i;
-	for (i = 0; i < pack_garbage.nr; i++)
+	for (int i = 0; i < pack_garbage.nr; i++)
 		unlink_or_warn(pack_garbage.items[i].string);
 	string_list_clear(&pack_garbage, 0);
 }
@@ -226,9 +225,9 @@ static int too_many_loose_objects(void)
 static struct packed_git *find_base_packs(struct string_list *packs,
 					  unsigned long limit)
 {
-	struct packed_git *p, *base = NULL;
+	struct packed_git *base = NULL;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
 		if (!p->pack_local || p->is_cruft)
 			continue;
 		if (limit) {
@@ -1100,7 +1099,6 @@ static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
 
 static int incremental_repack_auto_condition(void)
 {
-	struct packed_git *p;
 	int incremental_repack_auto_limit = 10;
 	int count = 0;
 
@@ -1116,9 +1114,7 @@ static int incremental_repack_auto_condition(void)
 	if (incremental_repack_auto_limit < 0)
 		return 1;
 
-	for (p = get_packed_git(the_repository);
-	     count < incremental_repack_auto_limit && p;
-	     p = p->next) {
+	for (struct packed_git *p = get_packed_git(the_repository); count < incremental_repack_auto_limit && p; p = p->next) {
 		if (!p->multi_pack_index)
 			count++;
 	}
@@ -1177,11 +1173,10 @@ static off_t get_auto_pack_size(void)
 	off_t max_size = 0;
 	off_t second_largest_size = 0;
 	off_t result_size;
-	struct packed_git *p;
 	struct repository *r = the_repository;
 
 	reprepare_packed_git(r);
-	for (p = get_all_packs(r); p; p = p->next) {
+	for (struct packed_git *p = get_all_packs(r); p; p = p->next) {
 		if (p->pack_size > max_size) {
 			second_largest_size = max_size;
 			max_size = p->pack_size;
@@ -1389,14 +1384,13 @@ static void initialize_maintenance_strategy(void)
 
 static void initialize_task_config(int schedule)
 {
-	int i;
 	struct strbuf config_name = STRBUF_INIT;
 	gc_config();
 
 	if (schedule)
 		initialize_maintenance_strategy();
 
-	for (i = 0; i < TASK__COUNT; i++) {
+	for (int i = 0; i < TASK__COUNT; i++) {
 		int config_value;
 		char *config_str;
 
@@ -1423,12 +1417,12 @@ static void initialize_task_config(int schedule)
 static int task_option_parse(const struct option *opt UNUSED,
 			     const char *arg, int unset)
 {
-	int i, num_selected = 0;
+	int num_selected = 0;
 	struct maintenance_task *task = NULL;
 
 	BUG_ON_OPT_NEG(unset);
 
-	for (i = 0; i < TASK__COUNT; i++) {
+	for (int i = 0; i < TASK__COUNT; i++) {
 		if (tasks[i].selected_order >= 0)
 			num_selected++;
 		if (!strcasecmp(tasks[i].name, arg)) {
@@ -1453,7 +1447,6 @@ static int task_option_parse(const struct option *opt UNUSED,
 
 static int maintenance_run(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	struct maintenance_run_opts opts;
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
@@ -1472,7 +1465,7 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 
 	opts.quiet = !isatty(2);
 
-	for (i = 0; i < TASK__COUNT; i++)
+	for (int i = 0; i < TASK__COUNT; i++)
 		tasks[i].selected_order = -1;
 
 	argc = parse_options(argc, argv, prefix,
@@ -2691,7 +2684,6 @@ static void validate_scheduler(enum scheduler scheduler)
 static int update_background_schedule(const struct maintenance_start_opts *opts,
 				      int enable)
 {
-	unsigned int i;
 	int result = 0;
 	struct lock_file lk;
 	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
@@ -2701,7 +2693,7 @@ static int update_background_schedule(const struct maintenance_start_opts *opts,
 		return error(_("another process is scheduling background maintenance"));
 	}
 
-	for (i = 1; i < ARRAY_SIZE(scheduler_fn); i++) {
+	for (unsigned int i = 1; i < ARRAY_SIZE(scheduler_fn); i++) {
 		if (enable && opts->scheduler == i)
 			continue;
 		if (!scheduler_fn[i].is_available())
diff --git a/builtin/grep.c b/builtin/grep.c
index 982bcfc4b1..ebb61eec1b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -179,9 +179,7 @@ static void work_done(struct work_item *w)
 
 static void free_repos(void)
 {
-	int i;
-
-	for (i = 0; i < repos_to_free_nr; i++) {
+	for (int i = 0; i < repos_to_free_nr; i++) {
 		repo_clear(repos_to_free[i]);
 		free(repos_to_free[i]);
 	}
@@ -250,7 +248,6 @@ static void start_threads(struct grep_opt *opt)
 static int wait_all(void)
 {
 	int hit = 0;
-	int i;
 
 	if (!HAVE_THREADS)
 		BUG("Never call this function unless you have started threads");
@@ -268,7 +265,7 @@ static int wait_all(void)
 	pthread_cond_broadcast(&cond_add);
 	grep_unlock();
 
-	for (i = 0; i < num_threads; i++) {
+	for (int i = 0; i < num_threads; i++) {
 		void *h;
 		pthread_join(threads[i], &h);
 		hit |= (int) (intptr_t) h;
@@ -418,9 +415,9 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 {
 	struct string_list *path_list = opt->output_priv;
 	struct child_process child = CHILD_PROCESS_INIT;
-	int i, status;
+	int status;
 
-	for (i = 0; i < path_list->nr; i++)
+	for (int i = 0; i < path_list->nr; i++)
 		strvec_push(&child.args, path_list->items[i].string);
 	child.dir = prefix;
 	child.use_shell = 1;
@@ -544,7 +541,6 @@ static int grep_cache(struct grep_opt *opt,
 {
 	struct repository *repo = opt->repo;
 	int hit = 0;
-	int nr;
 	struct strbuf name = STRBUF_INIT;
 	int name_base_len = 0;
 	if (repo->submodule_prefix) {
@@ -555,7 +551,7 @@ static int grep_cache(struct grep_opt *opt,
 	if (repo_read_index(repo) < 0)
 		die(_("index file corrupt"));
 
-	for (nr = 0; nr < repo->index->cache_nr; nr++) {
+	for (int nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
 		if (!cached && ce_skip_worktree(ce))
@@ -726,11 +722,10 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 			const struct object_array *list)
 {
-	unsigned int i;
 	int hit = 0;
 	const unsigned int nr = list->nr;
 
-	for (i = 0; i < nr; i++) {
+	for (unsigned int i = 0; i < nr; i++) {
 		struct object *real_obj;
 
 		obj_read_lock();
@@ -770,7 +765,7 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 			  int exc_std, int use_index)
 {
 	struct dir_struct dir = DIR_INIT;
-	int i, hit = 0;
+	int hit = 0;
 
 	if (!use_index)
 		dir.flags |= DIR_NO_GITLINKS;
@@ -778,7 +773,7 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 		setup_standard_excludes(&dir);
 
 	fill_directory(&dir, opt->repo->index, pathspec);
-	for (i = 0; i < dir.nr; i++) {
+	for (int i = 0; i < dir.nr; i++) {
 		hit |= grep_file(opt, dir.entries[i]->name);
 		if (hit && opt->status_only)
 			break;
@@ -1148,8 +1143,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	 * "do what I mean" case, we verify and complain when that isn't true.
 	 */
 	if (!seen_dashdash) {
-		int j;
-		for (j = i; j < argc; j++)
+		for (int j = i; j < argc; j++)
 			verify_filename(prefix, argv[j], j == i && allow_revs);
 	}
 
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 82ca6d2bfd..5cefac6ef8 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -112,7 +112,6 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
 		OPT_END()
 	};
-	int i;
 	const char *errstr = NULL;
 
 	argc = parse_options(argc, argv, prefix, hash_object_options,
@@ -153,7 +152,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	if (hashstdin)
 		hash_fd(0, type, vpath, flags, literally);
 
-	for (i = 0 ; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		char *to_free = NULL;
 
diff --git a/builtin/help.c b/builtin/help.c
index dc1fbe2b98..cea3415a17 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -122,14 +122,11 @@ static void list_config_help(enum show_config_type type)
 		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
 		{ NULL, NULL, NULL }
 	};
-	const char **p;
 	struct slot_expansion *e;
 	struct string_list keys = STRING_LIST_INIT_DUP;
 	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
-	int i;
-
-	for (p = config_name_list; *p; p++) {
+	for (const char **p = config_name_list; *p; p++) {
 		const char *var = *p;
 		struct strbuf sb = STRBUF_INIT;
 
@@ -154,7 +151,7 @@ static void list_config_help(enum show_config_type type)
 			    e->prefix, e->placeholder);
 
 	string_list_sort(&keys);
-	for (i = 0; i < keys.nr; i++) {
+	for (int i = 0; i < keys.nr; i++) {
 		const char *var = keys.items[i].string;
 		const char *wildcard, *tag, *cut;
 		const char *dot = NULL;
@@ -216,9 +213,7 @@ static enum help_format parse_help_format(const char *format)
 
 static const char *get_man_viewer_info(const char *name)
 {
-	struct man_viewer_info_list *viewer;
-
-	for (viewer = man_viewer_info_list; viewer; viewer = viewer->next)
+	for (struct man_viewer_info_list *viewer = man_viewer_info_list; viewer; viewer = viewer->next)
 	{
 		if (!strcasecmp(name, viewer->name))
 			return viewer->info;
@@ -489,11 +484,10 @@ static void exec_viewer(const char *name, const char *page)
 
 static void show_man_page(const char *page)
 {
-	struct man_viewer_list *viewer;
 	const char *fallback = getenv("GIT_MAN_VIEWER");
 
 	setup_man_path();
-	for (viewer = man_viewer_list; viewer; viewer = viewer->next)
+	for (struct man_viewer_list *viewer = man_viewer_list; viewer; viewer = viewer->next)
 	{
 		exec_viewer(viewer->name, page); /* will return when unable */
 	}
diff --git a/builtin/hook.c b/builtin/hook.c
index 5234693a94..9015f47532 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -20,7 +20,6 @@ static const char * const builtin_hook_run_usage[] = {
 
 static int run(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	int ignore_missing = 0;
 	const char *hook_name;
@@ -49,7 +48,7 @@ static int run(int argc, const char **argv, const char *prefix)
 		goto usage;
 
 	/* Add our arguments, start after -- */
-	for (i = 2 ; i < argc; i++)
+	for (int i = 2; i < argc; i++)
 		strvec_push(&opt.args, argv[i]);
 
 	/* Need to take into account core.hooksPath */
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a3a37bd215..f3489b51e7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -186,7 +186,6 @@ static inline void unlock_mutex(pthread_mutex_t *mutex)
  */
 static void init_thread(void)
 {
-	int i;
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
@@ -194,7 +193,7 @@ static void init_thread(void)
 		pthread_mutex_init(&deepest_delta_mutex, NULL);
 	pthread_key_create(&key, NULL);
 	CALLOC_ARRAY(thread_data, nr_threads);
-	for (i = 0; i < nr_threads; i++) {
+	for (int i = 0; i < nr_threads; i++) {
 		thread_data[i].pack_fd = xopen(curr_pack, O_RDONLY);
 	}
 
@@ -203,7 +202,6 @@ static void init_thread(void)
 
 static void cleanup_thread(void)
 {
-	int i;
 	if (!threads_active)
 		return;
 	threads_active = 0;
@@ -212,7 +210,7 @@ static void cleanup_thread(void)
 	pthread_mutex_destroy(&work_mutex);
 	if (show_stat)
 		pthread_mutex_destroy(&deepest_delta_mutex);
-	for (i = 0; i < nr_threads; i++)
+	for (int i = 0; i < nr_threads; i++)
 		close(thread_data[i].pack_fd);
 	pthread_key_delete(key);
 	free(thread_data);
@@ -261,14 +259,14 @@ static unsigned check_object(struct object *obj)
 
 static unsigned check_objects(void)
 {
-	unsigned i, max, foreign_nr = 0;
+	unsigned max, foreign_nr = 0;
 
 	max = get_max_object_index();
 
 	if (verbose)
 		progress = start_delayed_progress(_("Checking objects"), max);
 
-	for (i = 0; i < max; i++) {
+	for (unsigned i = 0; i < max; i++) {
 		foreign_nr += check_object(get_indexed_object(i));
 		display_progress(progress, i + 1);
 	}
@@ -1627,7 +1625,6 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
 				      struct pack_idx_option *opts)
 {
 	const uint32_t *idx1, *idx2;
-	uint32_t i;
 
 	/* The address of the 4-byte offset table */
 	idx1 = (((const uint32_t *)((const uint8_t *)p->index_data + p->crc_offset))
@@ -1637,7 +1634,7 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
 	/* The address of the 8-byte offset table */
 	idx2 = idx1 + p->num_objects;
 
-	for (i = 0; i < p->num_objects; i++) {
+	for (uint32_t i = 0; i < p->num_objects; i++) {
 		uint32_t off = ntohl(idx1[i]);
 		if (!(off & 0x80000000))
 			continue;
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 033bd1556c..cd6f32bbd5 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -130,8 +130,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 			options);
 
 	if (argc) {
-		int i;
-		for (i = 0; i < argc; i++)
+		for (int i = 0; i < argc; i++)
 			process_trailers(argv[i], &opts, &trailers);
 	} else {
 		if (opts.in_place)
diff --git a/builtin/log.c b/builtin/log.c
index db1808d7c1..eb3d9f7623 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -190,7 +190,6 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 
 static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
 {
-	int i;
 	char *value = NULL;
 	struct string_list *include = decoration_filter->include_ref_pattern;
 	const struct string_list *config_exclude;
@@ -224,7 +223,7 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 	 * No command-line or config options were given, so
 	 * populate with sensible defaults.
 	 */
-	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
+	for (int i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
 		if (!ref_namespace[i].decoration)
 			continue;
 
@@ -734,7 +733,6 @@ static void show_setup_revisions_tweak(struct rev_info *rev)
 int cmd_show(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	unsigned int i;
 	struct setup_revision_opt opt;
 	struct pathspec match_all;
 	int ret = 0;
@@ -765,7 +763,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 
 	rev.diffopt.no_free = 1;
-	for (i = 0; i < rev.pending.nr && !ret; i++) {
+	for (unsigned int i = 0; i < rev.pending.nr && !ret; i++) {
 		struct object *o = rev.pending.objects[i].item;
 		const char *name = rev.pending.objects[i].name;
 		switch (o->type) {
@@ -1211,13 +1209,13 @@ static void print_signature(FILE *file)
 
 static char *find_branch_name(struct rev_info *rev)
 {
-	int i, positive = -1;
+	int positive = -1;
 	struct object_id branch_oid;
 	const struct object_id *tip_oid;
 	const char *ref, *v;
 	char *full_ref, *branch = NULL;
 
-	for (i = 0; i < rev->cmdline.nr; i++) {
+	for (int i = 0; i < rev->cmdline.nr; i++) {
 		if (rev->cmdline.rev[i].flags & UNINTERESTING)
 			continue;
 		if (positive < 0)
@@ -1760,7 +1758,6 @@ static void prepare_bases(struct base_tree_info *bases,
 	struct rev_info revs;
 	struct diff_options diffopt;
 	struct commit_base commit_base;
-	int i;
 
 	if (!base)
 		return;
@@ -1775,7 +1772,7 @@ static void prepare_bases(struct base_tree_info *bases,
 	repo_init_revisions(the_repository, &revs, NULL);
 	revs.max_parents = 1;
 	revs.topo_order = 1;
-	for (i = 0; i < total; i++) {
+	for (int i = 0; i < total; i++) {
 		list[i]->object.flags &= ~UNINTERESTING;
 		add_pending_object(&revs, &list[i]->object, "rev_list");
 		*commit_base_at(&commit_base, list[i]) = 1;
@@ -1806,8 +1803,6 @@ static void prepare_bases(struct base_tree_info *bases,
 
 static void print_bases(struct base_tree_info *bases, FILE *file)
 {
-	int i;
-
 	/* Only do this once, either for the cover or for the first one */
 	if (is_null_oid(&bases->base_commit))
 		return;
@@ -1816,7 +1811,7 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
 	fprintf(file, "\nbase-commit: %s\n", oid_to_hex(&bases->base_commit));
 
 	/* Show the prerequisite patches */
-	for (i = bases->nr_patch_id - 1; i >= 0; i--)
+	for (int i = bases->nr_patch_id - 1; i >= 0; i--)
 		fprintf(file, "prerequisite-patch-id: %s\n", oid_to_hex(&bases->patch_id[i]));
 
 	free(bases->patch_id);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 92f94e65bf..e8ceb86599 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -163,9 +163,7 @@ static void show_dir_entry(struct index_state *istate,
 static void show_other_files(struct index_state *istate,
 			     const struct dir_struct *dir)
 {
-	int i;
-
-	for (i = 0; i < dir->nr; i++) {
+	for (int i = 0; i < dir->nr; i++) {
 		struct dir_entry *ent = dir->entries[i];
 		if (!index_name_is_other(istate, ent->name, ent->len))
 			continue;
@@ -176,8 +174,7 @@ static void show_other_files(struct index_state *istate,
 static void show_killed_files(struct index_state *istate,
 			      const struct dir_struct *dir)
 {
-	int i;
-	for (i = 0; i < dir->nr; i++) {
+	for (int i = 0; i < dir->nr; i++) {
 		struct dir_entry *ent = dir->entries[i];
 		char *cp, *sp;
 		int pos, len, killed = 0;
@@ -400,7 +397,6 @@ static void construct_fullname(struct strbuf *out, const struct repository *repo
 
 static void show_files(struct repository *repo, struct dir_struct *dir)
 {
-	int i;
 	struct strbuf fullname = STRBUF_INIT;
 
 	/* For cached/deleted files we don't need to even do the readdir */
@@ -420,7 +416,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 	if (!show_sparse_dirs)
 		ensure_full_index(repo->index);
 
-	for (i = 0; i < repo->index->cache_nr; i++) {
+	for (int i = 0; i < repo->index->cache_nr; i++) {
 		const struct cache_entry *ce = repo->index->cache[i];
 		struct stat st;
 		int stat_err;
@@ -571,7 +567,7 @@ static int option_parse_exclude_standard(const struct option *opt,
 
 int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
-	int require_work_tree = 0, show_tag = 0, i;
+	int require_work_tree = 0, show_tag = 0;
 	char *max_prefix;
 	struct dir_struct dir = DIR_INIT;
 	struct pattern_list *pl;
@@ -663,7 +659,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
-	for (i = 0; i < exclude_list.nr; i++) {
+	for (int i = 0; i < exclude_list.nr; i++) {
 		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
 	}
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index e4a891337c..24d21dbad6 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -55,15 +55,13 @@ struct ls_tree_options {
 static int show_recursive(struct ls_tree_options *options, const char *base,
 			  size_t baselen, const char *pathname)
 {
-	int i;
-
 	if (options->ls_options & LS_RECURSIVE)
 		return 1;
 
 	if (!options->pathspec.nr)
 		return 0;
 
-	for (i = 0; i < options->pathspec.nr; i++) {
+	for (int i = 0; i < options->pathspec.nr; i++) {
 		const char *spec = options->pathspec.items[i].match;
 		size_t len, speclen;
 
@@ -341,7 +339,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
 	struct object_id oid;
 	struct tree *tree;
-	int i, full_tree = 0;
+	int full_tree = 0;
 	int full_name = !prefix || !*prefix;
 	read_tree_fn_t fn = NULL;
 	enum ls_tree_cmdmode cmdmode = MODE_DEFAULT;
@@ -419,7 +417,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
-	for (i = 0; i < options.pathspec.nr; i++)
+	for (int i = 0; i < options.pathspec.nr; i++)
 		options.pathspec.items[i].nowildcard_len = options.pathspec.items[i].len;
 	options.pathspec.has_wildcard = 0;
 	tree = parse_tree_indirect(&oid);
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 3af9ddb8ae..ccb52fbc4b 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -114,10 +114,9 @@ static int populate_maildir_list(struct string_list *list, const char *path)
 	struct dirent *dent;
 	char *name = NULL;
 	char *subs[] = { "cur", "new", NULL };
-	char **sub;
 	int ret = -1;
 
-	for (sub = subs; *sub; ++sub) {
+	for (char **sub = subs; *sub; ++sub) {
 		free(name);
 		name = xstrfmt("%s/%s", path, *sub);
 		if (!(dir = opendir(name))) {
@@ -172,7 +171,6 @@ static int split_maildir(const char *maildir, const char *dir,
 	char *file = NULL;
 	FILE *f = NULL;
 	int ret = -1;
-	int i;
 	struct string_list list = STRING_LIST_INIT_DUP;
 
 	list.cmp = maildir_filename_cmp;
@@ -180,7 +178,7 @@ static int split_maildir(const char *maildir, const char *dir,
 	if (populate_maildir_list(&list, maildir) < 0)
 		goto out;
 
-	for (i = 0; i < list.nr; i++) {
+	for (int i = 0; i < list.nr; i++) {
 		char *name;
 
 		free(file);
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index d26e8fbf6f..2c66380e3b 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -10,7 +10,7 @@
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
-	struct commit_list *result, *r;
+	struct commit_list *result;
 
 	result = repo_get_merge_bases_many_dirty(the_repository, rev[0],
 						 rev_nr - 1, rev + 1);
@@ -18,7 +18,7 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 	if (!result)
 		return 1;
 
-	for (r = result; r; r = r->next) {
+	for (struct commit_list *r = result; r; r = r->next) {
 		printf("%s\n", oid_to_hex(&r->item->object.oid));
 		if (!show_all)
 			break;
@@ -53,10 +53,8 @@ static struct commit *get_commit_reference(const char *arg)
 
 static int handle_independent(int count, const char **args)
 {
-	struct commit_list *revs = NULL, *rev;
-	int i;
-
-	for (i = count - 1; i >= 0; i--)
+	struct commit_list *revs = NULL;
+	for (int i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
 	reduce_heads_replace(&revs);
@@ -64,7 +62,7 @@ static int handle_independent(int count, const char **args)
 	if (!revs)
 		return 1;
 
-	for (rev = revs; rev; rev = rev->next)
+	for (struct commit_list *rev = revs; rev; rev = rev->next)
 		printf("%s\n", oid_to_hex(&rev->item->object.oid));
 
 	free_commit_list(revs);
@@ -74,10 +72,8 @@ static int handle_independent(int count, const char **args)
 static int handle_octopus(int count, const char **args, int show_all)
 {
 	struct commit_list *revs = NULL;
-	struct commit_list *result, *rev;
-	int i;
-
-	for (i = count - 1; i >= 0; i--)
+	struct commit_list *result;
+	for (int i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
 	result = get_octopus_merge_bases(revs);
@@ -87,7 +83,7 @@ static int handle_octopus(int count, const char **args, int show_all)
 	if (!result)
 		return 1;
 
-	for (rev = result; rev; rev = rev->next) {
+	for (struct commit_list *rev = result; rev; rev = rev->next) {
 		printf("%s\n", oid_to_hex(&rev->item->object.oid));
 		if (!show_all)
 			break;
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 270d5f644a..39a0535d56 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -63,10 +63,9 @@ static void merge_one_path(const char *path)
 
 static void merge_all(void)
 {
-	int i;
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&the_index);
-	for (i = 0; i < the_index.cache_nr; i++) {
+	for (int i = 0; i < the_index.cache_nr; i++) {
 		const struct cache_entry *ce = the_index.cache[i];
 		if (!ce_stage(ce))
 			continue;
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index cbd8e15af6..72e0844ad1 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -109,8 +109,7 @@ static void *origin(struct merge_list *entry, unsigned long *size)
 
 static int show_outf(void *priv UNUSED, mmbuffer_t *mb, int nbuf)
 {
-	int i;
-	for (i = 0; i < nbuf; i++)
+	for (int i = 0; i < nbuf; i++)
 		printf("%.*s", (int) mb[i].size, mb[i].ptr);
 	return 0;
 }
@@ -267,10 +266,9 @@ static struct merge_list *link_entry(unsigned stage, const struct traverse_info
 static void unresolved(const struct traverse_info *info, struct name_entry n[3])
 {
 	struct merge_list *entry = NULL;
-	int i;
 	unsigned dirmask = 0, mask = 0;
 
-	for (i = 0; i < 3; i++) {
+	for (int i = 0; i < 3; i++) {
 		mask |= (1 << i);
 		/*
 		 * Treat missing entries as directories so that we return
@@ -490,10 +488,9 @@ static int real_merge(struct merge_tree_options *o,
 	if (!result.clean) {
 		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
 		const char *last = NULL;
-		int i;
 
 		merge_get_conflicted_files(&result, &conflicted_files);
-		for (i = 0; i < conflicted_files.nr; i++) {
+		for (int i = 0; i < conflicted_files.nr; i++) {
 			const char *name = conflicted_files.items[i].string;
 			struct stage_info *c = conflicted_files.items[i].util;
 			if (!o->name_only)
diff --git a/builtin/merge.c b/builtin/merge.c
index 935c8a57dd..df0650348d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -393,7 +393,6 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 {
 	struct rev_info rev;
 	struct strbuf out = STRBUF_INIT;
-	struct commit_list *j;
 	struct pretty_print_context ctx = {0};
 
 	printf(_("Squash commit -- not updating HEAD\n"));
@@ -405,7 +404,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 	commit->object.flags |= UNINTERESTING;
 	add_pending_object(&rev, &commit->object, NULL);
 
-	for (j = remoteheads; j; j = j->next)
+	for (struct commit_list *j = remoteheads; j; j = j->next)
 		add_pending_object(&rev, &j->item->object, NULL);
 
 	setup_revisions(0, NULL, &rev, NULL);
@@ -650,7 +649,7 @@ static int git_merge_config(const char *k, const char *v,
 static int read_tree_trivial(struct object_id *common, struct object_id *head,
 			     struct object_id *one)
 {
-	int i, nr_trees = 0;
+	int nr_trees = 0;
 	struct tree *trees[MAX_UNPACK_TREES];
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
@@ -675,7 +674,7 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 		return -1;
 	opts.fn = threeway_merge;
 	cache_tree_free(&the_index.cache_tree);
-	for (i = 0; i < nr_trees; i++) {
+	for (int i = 0; i < nr_trees; i++) {
 		parse_tree(trees[i]);
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
@@ -704,11 +703,10 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree") ||
 	    !strcmp(strategy, "ort")) {
 		struct lock_file lock = LOCK_INIT;
-		int clean, x;
+		int clean;
 		struct commit *result;
 		struct commit_list *reversed = NULL;
 		struct merge_options o;
-		struct commit_list *j;
 
 		if (remoteheads->next) {
 			error(_("Not handling anything other than two heads merge."));
@@ -722,14 +720,14 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		o.show_rename_progress =
 			show_progress == -1 ? isatty(2) : show_progress;
 
-		for (x = 0; x < xopts.nr; x++)
+		for (int x = 0; x < xopts.nr; x++)
 			if (parse_merge_opt(&o, xopts.v[x]))
 				die(_("unknown strategy option: -X%s"), xopts.v[x]);
 
 		o.branch1 = head_arg;
 		o.branch2 = merge_remote_util(remoteheads->item)->name;
 
-		for (j = common; j; j = j->next)
+		for (struct commit_list *j = common; j; j = j->next)
 			commit_list_insert(j->item, &reversed);
 
 		repo_hold_locked_index(the_repository, &lock,
@@ -765,9 +763,9 @@ static void count_diff_files(struct diff_queue_struct *q,
 
 static int count_unmerged_entries(void)
 {
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < the_index.cache_nr; i++)
+	for (int i = 0; i < the_index.cache_nr; i++)
 		if (ce_stage(the_index.cache[i]))
 			ret++;
 
@@ -776,8 +774,6 @@ static int count_unmerged_entries(void)
 
 static void add_strategies(const char *string, unsigned attr)
 {
-	int i;
-
 	if (string) {
 		struct string_list list = STRING_LIST_INIT_DUP;
 		struct string_list_item *item;
@@ -787,7 +783,7 @@ static void add_strategies(const char *string, unsigned attr)
 		string_list_clear(&list, 0);
 		return;
 	}
-	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
+	for (int i = 0; i < ARRAY_SIZE(all_strategy); i++)
 		if (all_strategy[i].attr & attr)
 			append_strategy(&all_strategy[i]);
 
@@ -1022,10 +1018,9 @@ static int setup_with_upstream(const char ***argv)
 
 static void write_merge_heads(struct commit_list *remoteheads)
 {
-	struct commit_list *j;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (j = remoteheads; j; j = j->next) {
+	for (struct commit_list *j = remoteheads; j; j = j->next) {
 		struct object_id *oid;
 		struct commit *c = j->item;
 		struct merge_remote_desc *desc;
@@ -1130,7 +1125,7 @@ static void prepare_merge_message(struct strbuf *merge_names, struct strbuf *mer
 static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge_names)
 {
 	const char *filename;
-	int fd, pos, npos;
+	int fd, npos;
 	struct strbuf fetch_head_file = STRBUF_INIT;
 	const unsigned hexsz = the_hash_algo->hexsz;
 
@@ -1145,7 +1140,7 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 	if (close(fd) < 0)
 		die_errno(_("could not close '%s'"), filename);
 
-	for (pos = 0; pos < merge_names->len; pos = npos) {
+	for (int pos = 0; pos < merge_names->len; pos = npos) {
 		struct object_id oid;
 		char *ptr;
 		struct commit *commit;
@@ -1209,8 +1204,7 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 		}
 		remoteheads = reduce_parents(head_commit, head_subsumed, remoteheads);
 		if (autogen) {
-			struct commit_list *p;
-			for (p = remoteheads; p; p = p->next)
+			for (struct commit_list *p = remoteheads; p; p = p->next)
 				merge_name(merge_remote_util(p->item)->name, autogen);
 		}
 	}
@@ -1623,9 +1617,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * to date.
 		 */
 		int up_to_date = 1;
-		struct commit_list *j;
-
-		for (j = remoteheads; j; j = j->next) {
+		for (struct commit_list *j = remoteheads; j; j = j->next) {
 			struct commit_list *common_one;
 			struct commit *common_item;
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 2dd1807c4e..3689e898f8 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -417,14 +417,12 @@ static int name_ref(const char *path, const struct object_id *oid,
 
 static void name_tips(void)
 {
-	int i;
-
 	/*
 	 * Try to set better names first, so that worse ones spread
 	 * less.
 	 */
 	QSORT(tip_table.table, tip_table.nr, cmp_by_tag_and_age);
-	for (i = 0; i < tip_table.nr; i++) {
+	for (int i = 0; i < tip_table.nr; i++) {
 		struct tip_table_entry *e = &tip_table.table[i];
 		if (e->commit) {
 			name_rev(e->commit, e->refname, e->taggerdate,
@@ -659,10 +657,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		}
 		strbuf_release(&sb);
 	} else if (all) {
-		int i, max;
+		int max;
 
 		max = get_max_object_index();
-		for (i = 0; i < max; i++) {
+		for (int i = 0; i < max; i++) {
 			struct object *obj = get_indexed_object(i);
 			if (!obj || obj->type != OBJ_COMMIT)
 				continue;
@@ -670,8 +668,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				  always, allow_undefined, data.name_only);
 		}
 	} else {
-		int i;
-		for (i = 0; i < revs.nr; i++)
+		for (int i = 0; i < revs.nr; i++)
 			show_name(revs.objects[i].item, revs.objects[i].name,
 				  always, allow_undefined, data.name_only);
 	}
diff --git a/builtin/notes.c b/builtin/notes.c
index caf20fd5bd..75c57e745c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -254,9 +254,7 @@ static void append_separator(struct strbuf *message)
 static void concat_messages(struct note_data *d)
 {
 	struct strbuf msg = STRBUF_INIT;
-	size_t i;
-
-	for (i = 0; i < d->msg_nr ; i++) {
+	for (size_t i = 0; i < d->msg_nr; i++) {
 		if (d->buf.len)
 			append_separator(&d->buf);
 		strbuf_add(&msg, d->messages[i]->buf.buf, d->messages[i]->buf.len);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 329aeac804..3e3150198b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1549,7 +1549,6 @@ static int want_object_in_pack(const struct object_id *oid,
 {
 	int want;
 	struct list_head *pos;
-	struct multi_pack_index *m;
 
 	if (!exclude && local && has_loose_object_nonlocal(oid))
 		return 0;
@@ -1568,7 +1567,7 @@ static int want_object_in_pack(const struct object_id *oid,
 		*found_offset = 0;
 	}
 
-	for (m = get_multi_pack_index(the_repository); m; m = m->next) {
+	for (struct multi_pack_index *m = get_multi_pack_index(the_repository); m; m = m->next) {
 		struct pack_entry e;
 		if (fill_midx_entry(the_repository, oid, &e, m)) {
 			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset);
@@ -1718,7 +1717,6 @@ static struct pbase_tree_cache *pbase_tree_get(const struct object_id *oid)
 	void *data;
 	unsigned long size;
 	enum object_type type;
-	int neigh;
 	int my_ix = pbase_tree_cache_ix(oid);
 	int available_ix = -1;
 
@@ -1726,7 +1724,7 @@ static struct pbase_tree_cache *pbase_tree_get(const struct object_id *oid)
 	 * your object will be found at your index or within a few
 	 * slots after that slot if it is cached.
 	 */
-	for (neigh = 0; neigh < 8; neigh++) {
+	for (int neigh = 0; neigh < 8; neigh++) {
 		ent = pbase_tree_cache[my_ix];
 		if (ent && oideq(&ent->oid, oid)) {
 			ent->ref++;
@@ -1872,7 +1870,6 @@ static int check_pbase_path(unsigned hash)
 
 static void add_preferred_base_object(const char *name)
 {
-	struct pbase_tree *it;
 	size_t cmplen;
 	unsigned hash = pack_name_hash(name);
 
@@ -1880,7 +1877,7 @@ static void add_preferred_base_object(const char *name)
 		return;
 
 	cmplen = name_cmp_len(name);
-	for (it = pbase_tree; it; it = it->next) {
+	for (struct pbase_tree *it = pbase_tree; it; it = it->next) {
 		if (cmplen == 0) {
 			add_object_entry(&it->pcache.oid, OBJ_TREE, NULL, 1);
 		}
@@ -1926,7 +1923,6 @@ static void add_preferred_base(struct object_id *oid)
 static void cleanup_preferred_base(void)
 {
 	struct pbase_tree *it;
-	unsigned i;
 
 	it = pbase_tree;
 	pbase_tree = NULL;
@@ -1937,7 +1933,7 @@ static void cleanup_preferred_base(void)
 		free(tmp);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(pbase_tree_cache); i++) {
+	for (unsigned i = 0; i < ARRAY_SIZE(pbase_tree_cache); i++) {
 		if (!pbase_tree_cache[i])
 			continue;
 		free(pbase_tree_cache[i]->tree_data);
@@ -1996,9 +1992,7 @@ static int can_reuse_delta(const struct object_id *base_oid,
 
 static void prefetch_to_pack(uint32_t object_index_start) {
 	struct oid_array to_fetch = OID_ARRAY_INIT;
-	uint32_t i;
-
-	for (i = object_index_start; i < to_pack.nr_objects; i++) {
+	for (uint32_t i = object_index_start; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = to_pack.objects + i;
 
 		if (!oid_object_info_extended(the_repository,
@@ -2727,7 +2721,7 @@ static unsigned long free_unpacked(struct unpacked *n)
 static void find_deltas(struct object_entry **list, unsigned *list_size,
 			int window, int depth, unsigned *processed)
 {
-	uint32_t i, idx = 0, count = 0;
+	uint32_t idx = 0, count = 0;
 	struct unpacked *array;
 	unsigned long mem_usage = 0;
 
@@ -2859,7 +2853,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 			idx = 0;
 	}
 
-	for (i = 0; i < window; ++i) {
+	for (uint32_t i = 0; i < window; ++i) {
 		free_delta_index(array[i].index);
 		free(array[i].data);
 	}
@@ -3130,7 +3124,7 @@ static int add_ref_tag(const char *tag UNUSED, const struct object_id *oid,
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
-	uint32_t i, nr_deltas;
+	uint32_t nr_deltas;
 	unsigned n;
 
 	if (use_delta_islands)
@@ -3154,7 +3148,7 @@ static void prepare_pack(int window, int depth)
 	ALLOC_ARRAY(delta_list, to_pack.nr_objects);
 	nr_deltas = n = 0;
 
-	for (i = 0; i < to_pack.nr_objects; i++) {
+	for (uint32_t i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = to_pack.objects + i;
 
 		if (DELTA(entry))
@@ -3630,7 +3624,6 @@ static void enumerate_cruft_objects(void)
 
 static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
 {
-	struct packed_git *p;
 	struct rev_info revs;
 	int ret;
 
@@ -3658,7 +3651,7 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 	 * Re-mark only the fresh packs as kept so that objects in
 	 * unknown packs do not halt the reachability traversal early.
 	 */
-	for (p = get_all_packs(the_repository); p; p = p->next)
+	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next)
 		p->pack_keep_in_core = 0;
 	mark_pack_kept_in_core(fresh_packs, 1);
 
@@ -3677,7 +3670,6 @@ static void read_cruft_objects(void)
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list discard_packs = STRING_LIST_INIT_DUP;
 	struct string_list fresh_packs = STRING_LIST_INIT_DUP;
-	struct packed_git *p;
 
 	ignore_packed_keep_in_core = 1;
 
@@ -3694,7 +3686,7 @@ static void read_cruft_objects(void)
 	string_list_sort(&discard_packs);
 	string_list_sort(&fresh_packs);
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
 		const char *pack_name = pack_basename(p);
 		struct string_list_item *item;
 
@@ -3781,13 +3773,12 @@ static void show_object(struct object *obj, const char *name,
 	add_object_entry(&obj->oid, obj->type, name, 0);
 
 	if (use_delta_islands) {
-		const char *p;
 		unsigned depth;
 		struct object_entry *ent;
 
 		/* the empty string is a root tree, which is depth 0 */
 		depth = *name ? 1 : 0;
-		for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
+		for (const char *p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
 			depth++;
 
 		ent = packlist_find(&to_pack, &obj->oid);
@@ -3981,12 +3972,11 @@ static int loosened_object_can_be_discarded(const struct object_id *oid,
 
 static void loosen_unused_packed_objects(void)
 {
-	struct packed_git *p;
 	uint32_t i;
 	uint32_t loosened_objects_nr = 0;
 	struct object_id oid;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
 		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
 
@@ -4183,12 +4173,10 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 
 static void add_extra_kept_packs(const struct string_list *names)
 {
-	struct packed_git *p;
-
 	if (!names->nr)
 		return;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
 		const char *name = basename(p->pack_name);
 		int i;
 
@@ -4545,14 +4533,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		if (!p) /* no keep-able packs found */
 			ignore_packed_keep_on_disk = 0;
 	}
-	if (local) {
-		/*
-		 * unlike ignore_packed_keep_on_disk above, we do not
-		 * want to unset "local" based on looking at packs, as
-		 * it also covers non-local objects
-		 */
-		struct packed_git *p;
-		for (p = get_all_packs(the_repository); p; p = p->next) {
+	if (local) {for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
 			if (!p->pack_local) {
 				have_non_local_packs = 1;
 				break;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 4c735ba069..0891a05692 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -368,7 +368,6 @@ static int cmp_remaining_objects(const void *a, const void *b)
 static void sort_pack_list(struct pack_list **pl)
 {
 	struct pack_list **ary, *p;
-	int i;
 	size_t n = pack_list_size(*pl);
 
 	if (n < 2)
@@ -382,7 +381,7 @@ static void sort_pack_list(struct pack_list **pl)
 	QSORT(ary, n, cmp_remaining_objects);
 
 	/* link them back again */
-	for (i = 0; i < n - 1; i++)
+	for (int i = 0; i < n - 1; i++)
 		ary[i]->next = ary[i + 1];
 	ary[n - 1]->next = NULL;
 	*pl = ary[0];
diff --git a/builtin/pull.c b/builtin/pull.c
index 73a68b75b0..ff5c73ed1f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -283,10 +283,9 @@ static void argv_push_force(struct strvec *arr)
  */
 static void set_reflog_message(int argc, const char **argv)
 {
-	int i;
 	struct strbuf msg = STRBUF_INIT;
 
-	for (i = 0; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		if (i)
 			strbuf_addch(&msg, ' ');
 		strbuf_addstr(&msg, argv[i]);
@@ -937,11 +936,10 @@ static int get_can_ff(struct object_id *orig_head,
 static int already_up_to_date(struct object_id *orig_head,
 			      struct oid_array *merge_heads)
 {
-	int i;
 	struct commit *ours;
 
 	ours = lookup_commit_reference(the_repository, orig_head);
-	for (i = 0; i < merge_heads->nr; i++) {
+	for (int i = 0; i < merge_heads->nr; i++) {
 		struct commit_list *list = NULL;
 		struct commit *theirs;
 		int ok;
diff --git a/builtin/push.c b/builtin/push.c
index 2fbb31c3ad..2d4e7e329c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -100,9 +100,7 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
 {
 	struct remote *remote = NULL;
 	struct ref *local_refs = NULL;
-	int i;
-
-	for (i = 0; i < nr; i++) {
+	for (int i = 0; i < nr; i++) {
 		const char *ref = refs[i];
 		if (!strcmp("tag", ref)) {
 			if (nr <= ++i)
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index f02cbac087..b75283f2f5 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -39,7 +39,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	struct option *options;
-	int i, dash_dash = -1, res = 0;
+	int dash_dash = -1, res = 0;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
 	struct object_id oid;
 	const char *three_dots = NULL;
@@ -58,7 +58,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	if (!simple_color)
 		diffopt.use_color = 1;
 
-	for (i = 0; i < argc; i++)
+	for (int i = 0; i < argc; i++)
 		if (!strcmp(argv[i], "--")) {
 			dash_dash = i;
 			break;
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 20e7db1973..196e87c0cd 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -88,11 +88,9 @@ static void debug_stage(const char *label, const struct cache_entry *ce,
 static int debug_merge(const struct cache_entry * const *stages,
 		       struct unpack_trees_options *o)
 {
-	int i;
-
 	printf("* %d-way merge\n", o->internal.merge_size);
 	debug_stage("index", stages[0], o);
-	for (i = 1; i <= o->internal.merge_size; i++) {
+	for (int i = 1; i <= o->internal.merge_size; i++) {
 		char buf[24];
 		xsnprintf(buf, sizeof(buf), "ent#%d", i);
 		debug_stage(buf, stages[i], o);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index db65607485..da1ee58688 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -413,12 +413,10 @@ static void proc_receive_ref_append(const char *prefix)
 
 static int proc_receive_ref_matches(struct command *cmd)
 {
-	struct proc_receive_ref *p;
-
 	if (!proc_receive_ref)
 		return 0;
 
-	for (p = proc_receive_ref; p; p = p->next) {
+	for (struct proc_receive_ref *p = proc_receive_ref; p; p = p->next) {
 		const char *match = p->ref_prefix;
 		const char *remains;
 
@@ -547,7 +545,6 @@ static void hmac_hash(unsigned char *out,
 	unsigned char key[GIT_MAX_BLKSZ];
 	unsigned char k_ipad[GIT_MAX_BLKSZ];
 	unsigned char k_opad[GIT_MAX_BLKSZ];
-	int i;
 	git_hash_ctx ctx;
 
 	/* RFC 2104 2. (1) */
@@ -561,7 +558,7 @@ static void hmac_hash(unsigned char *out,
 	}
 
 	/* RFC 2104 2. (2) & (5) */
-	for (i = 0; i < sizeof(key); i++) {
+	for (int i = 0; i < sizeof(key); i++) {
 		k_ipad[i] = key[i] ^ 0x36;
 		k_opad[i] = key[i] ^ 0x5c;
 	}
@@ -600,9 +597,7 @@ static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
 static int constant_memequal(const char *a, const char *b, size_t n)
 {
 	int res = 0;
-	size_t i;
-
-	for (i = 0; i < n; i++)
+	for (size_t i = 0; i < n; i++)
 		res |= a[i] ^ b[i];
 	return res;
 }
@@ -803,8 +798,7 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	proc.trace2_hook_name = hook_name;
 
 	if (feed_state->push_options) {
-		size_t i;
-		for (i = 0; i < feed_state->push_options->nr; i++)
+		for (size_t i = 0; i < feed_state->push_options->nr; i++)
 			strvec_pushf(&proc.env,
 				     "GIT_PUSH_OPTION_%"PRIuMAX"=%s",
 				     (uintmax_t)i,
@@ -958,7 +952,6 @@ static int read_proc_receive_report(struct packet_reader *reader,
 				    struct command *commands,
 				    struct strbuf *errmsg)
 {
-	struct command *cmd;
 	struct command *hint = NULL;
 	struct ref_push_report *report = NULL;
 	int new_report = 0;
@@ -1077,7 +1070,7 @@ static int read_proc_receive_report(struct packet_reader *reader,
 		new_report = 1;
 	}
 
-	for (cmd = commands; cmd; cmd = cmd->next)
+	for (struct command *cmd = commands; cmd; cmd = cmd->next)
 		if (cmd->run_proc_receive && !cmd->error_string &&
 		    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)) {
 		    cmd->error_string = "proc-receive failed to report status";
@@ -1608,7 +1601,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 static void run_update_post_hook(struct command *commands)
 {
-	struct command *cmd;
 	struct child_process proc = CHILD_PROCESS_INIT;
 	const char *hook;
 
@@ -1616,7 +1608,7 @@ static void run_update_post_hook(struct command *commands)
 	if (!hook)
 		return;
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
+	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
 		if (!proc.args.nr)
@@ -1728,9 +1720,7 @@ static const struct object_id *command_singleton_iterator(void *cb_data)
 static void set_connectivity_errors(struct command *commands,
 				    struct shallow_info *si)
 {
-	struct command *cmd;
-
-	for (cmd = commands; cmd; cmd = cmd->next) {
+	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
 		struct command *singleton = cmd;
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
@@ -1774,12 +1764,11 @@ static void reject_updates_to_hidden(struct command *commands)
 {
 	struct strbuf refname_full = STRBUF_INIT;
 	size_t prefix_len;
-	struct command *cmd;
 
 	strbuf_addstr(&refname_full, get_git_namespace());
 	prefix_len = refname_full.len;
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
+	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string)
 			continue;
 
@@ -1805,9 +1794,7 @@ static int should_process_cmd(struct command *cmd)
 static void BUG_if_skipped_connectivity_check(struct command *commands,
 					       struct shallow_info *si)
 {
-	struct command *cmd;
-
-	for (cmd = commands; cmd; cmd = cmd->next) {
+	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
 		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index])
 			bug("connectivity check has not been run on ref %s",
 			    cmd->ref_name);
@@ -1818,10 +1805,9 @@ static void BUG_if_skipped_connectivity_check(struct command *commands,
 static void execute_commands_non_atomic(struct command *commands,
 					struct shallow_info *si)
 {
-	struct command *cmd;
 	struct strbuf err = STRBUF_INIT;
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
+	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
 		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 			continue;
 
@@ -2392,12 +2378,11 @@ static void update_shallow_info(struct command *commands,
 
 static void report(struct command *commands, const char *unpack_status)
 {
-	struct command *cmd;
 	struct strbuf buf = STRBUF_INIT;
 
 	packet_buf_write(&buf, "unpack %s\n",
 			 unpack_status ? unpack_status : "ok");
-	for (cmd = commands; cmd; cmd = cmd->next) {
+	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string)
 			packet_buf_write(&buf, "ok %s\n",
 					 cmd->ref_name);
@@ -2416,13 +2401,12 @@ static void report(struct command *commands, const char *unpack_status)
 
 static void report_v2(struct command *commands, const char *unpack_status)
 {
-	struct command *cmd;
 	struct strbuf buf = STRBUF_INIT;
 	struct ref_push_report *report;
 
 	packet_buf_write(&buf, "unpack %s\n",
 			 unpack_status ? unpack_status : "ok");
-	for (cmd = commands; cmd; cmd = cmd->next) {
+	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
 		int count = 0;
 
 		if (cmd->error_string) {
@@ -2461,8 +2445,7 @@ static void report_v2(struct command *commands, const char *unpack_status)
 
 static int delete_only(struct command *commands)
 {
-	struct command *cmd;
-	for (cmd = commands; cmd; cmd = cmd->next) {
+	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
 		if (!is_null_oid(&cmd->new_oid))
 			return 0;
 	}
@@ -2551,8 +2534,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		if (use_push_options)
 			read_push_options(&reader, &push_options);
 		if (!check_cert_push_options(&push_options)) {
-			struct command *cmd;
-			for (cmd = commands; cmd; cmd = cmd->next)
+			for (struct command *cmd = commands; cmd; cmd = cmd->next)
 				cmd->error_string = "inconsistent push options";
 		}
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2c3369fca5..bee26f2998 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -160,12 +160,10 @@ static int reflog_expire_config(const char *var, const char *value,
 
 static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, const char *ref)
 {
-	struct reflog_expire_cfg *ent;
-
 	if (cb->explicit_expiry == (EXPIRE_TOTAL|EXPIRE_UNREACH))
 		return; /* both given explicitly -- nothing to tweak */
 
-	for (ent = reflog_expire_cfg; ent; ent = ent->next) {
+	for (struct reflog_expire_cfg *ent = reflog_expire_cfg; ent; ent = ent->next) {
 		if (!wildmatch(ent->pattern, ref, 0)) {
 			if (!(cb->explicit_expiry & EXPIRE_TOTAL))
 				cb->expire_total = ent->expire_total;
@@ -242,7 +240,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct cmd_reflog_expire_cb cmd = { 0 };
 	timestamp_t now = time(NULL);
-	int i, status, do_all, single_worktree = 0;
+	int status, do_all, single_worktree = 0;
 	unsigned int flags = 0;
 	int verbose = 0;
 	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
@@ -313,10 +311,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			.reflogs = STRING_LIST_INIT_DUP,
 		};
 		struct string_list_item *item;
-		struct worktree **worktrees, **p;
+		struct worktree **worktrees;
 
 		worktrees = get_worktrees();
-		for (p = worktrees; *p; p++) {
+		for (struct worktree **p = worktrees; *p; p++) {
 			if (single_worktree && !(*p)->is_current)
 				continue;
 			collected.worktree = *p;
@@ -341,7 +339,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		string_list_clear(&collected.reflogs, 0);
 	}
 
-	for (i = 0; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		char *ref;
 		struct expire_reflog_policy_cb cb = { .cmd = cmd };
 
@@ -362,7 +360,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 {
-	int i, status = 0;
+	int status = 0;
 	unsigned int flags = 0;
 	int verbose = 0;
 
@@ -384,7 +382,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	if (argc < 1)
 		return error(_("no reflog specified to delete"));
 
-	for (i = 0; i < argc; i++)
+	for (int i = 0; i < argc; i++)
 		status |= reflog_delete(argv[i], flags, verbose);
 
 	return status;
diff --git a/builtin/remote.c b/builtin/remote.c
index d91bbe728d..97a33ea644 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -366,9 +366,7 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 {
 	struct ref *fetch_map = NULL, **tail = &fetch_map;
 	struct ref *ref, *stale_refs;
-	int i;
-
-	for (i = 0; i < states->remote->fetch.nr; i++)
+	for (int i = 0; i < states->remote->fetch.nr; i++)
 		if (get_fetch_map(remote_refs, &states->remote->fetch.items[i], &tail, 1))
 			die(_("Could not get fetch map for refspec %s"),
 				states->remote->fetch.raw[i]);
@@ -415,7 +413,7 @@ static int get_push_ref_states(const struct ref *remote_refs,
 	struct ref_states *states)
 {
 	struct remote *remote = states->remote;
-	struct ref *ref, *local_refs, *push_map;
+	struct ref *local_refs, *push_map;
 	if (remote->mirror)
 		return 0;
 
@@ -424,7 +422,7 @@ static int get_push_ref_states(const struct ref *remote_refs,
 
 	match_push_refs(local_refs, &push_map, &remote->push, MATCH_REFS_NONE);
 
-	for (ref = push_map; ref; ref = ref->next) {
+	for (struct ref *ref = push_map; ref; ref = ref->next) {
 		struct string_list_item *item;
 		struct push_info *info;
 
@@ -458,7 +456,6 @@ static int get_push_ref_states(const struct ref *remote_refs,
 
 static int get_push_ref_states_noquery(struct ref_states *states)
 {
-	int i;
 	struct remote *remote = states->remote;
 	struct string_list_item *item;
 	struct push_info *info;
@@ -472,7 +469,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 		info->status = PUSH_STATUS_NOTQUERIED;
 		info->dest = xstrdup(item->string);
 	}
-	for (i = 0; i < remote->push.nr; i++) {
+	for (int i = 0; i < remote->push.nr; i++) {
 		const struct refspec_item *spec = &remote->push.items[i];
 		if (spec->matching)
 			item = string_list_append(&states->push, _("(matching)"));
@@ -491,7 +488,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 
 static int get_head_names(const struct ref *remote_refs, struct ref_states *states)
 {
-	struct ref *ref, *matches;
+	struct ref *matches;
 	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
 	struct refspec_item refspec;
 
@@ -502,7 +499,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
-	for (ref = matches; ref; ref = ref->next)
+	for (struct ref *ref = matches; ref; ref = ref->next)
 		string_list_append(&states->heads, abbrev_branch(ref->name));
 
 	free_refs(fetch_map);
@@ -548,7 +545,6 @@ static int add_branch_for_removal(const char *refname,
 {
 	struct branches_for_remote *branches = cb_data;
 	struct refspec_item refspec;
-	struct known_remote *kr;
 
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
@@ -556,7 +552,7 @@ static int add_branch_for_removal(const char *refname,
 		return 0;
 
 	/* don't delete a branch if another remote also uses it */
-	for (kr = branches->keep->list; kr; kr = kr->next) {
+	for (struct known_remote *kr = branches->keep->list; kr; kr = kr->next) {
 		memset(&refspec, 0, sizeof(refspec));
 		refspec.dst = (char *)refname;
 		if (!remote_find_tracking(kr->remote, &refspec))
@@ -1097,7 +1093,6 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 	struct branch_info *branch_info = item->util;
 	struct string_list *merge = &branch_info->merge;
 	int width = show_info->width + 4;
-	int i;
 
 	if (branch_info->rebase >= REBASE_TRUE && branch_info->merge.nr > 1) {
 		error(_("invalid branch.%s.merge; cannot rebase onto > 1 branch"),
@@ -1123,7 +1118,7 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 	} else {
 		printf_ln(_("merges with remote %s"), merge->items[0].string);
 	}
-	for (i = 1; i < merge->nr; i++)
+	for (int i = 1; i < merge->nr; i++)
 		printf(_("%-*s    and with remote %s\n"), width, "",
 		       merge->items[i].string);
 
@@ -1208,7 +1203,7 @@ static int get_one_entry(struct remote *remote, void *priv)
 	struct string_list *list = priv;
 	struct strbuf remote_info_buf = STRBUF_INIT;
 	const char **url;
-	int i, url_nr;
+	int url_nr;
 
 	if (remote->url_nr > 0) {
 		struct strbuf promisor_config = STRBUF_INIT;
@@ -1231,7 +1226,7 @@ static int get_one_entry(struct remote *remote, void *priv)
 		url = remote->url;
 		url_nr = remote->url_nr;
 	}
-	for (i = 0; i < url_nr; i++)
+	for (int i = 0; i < url_nr; i++)
 	{
 		strbuf_addf(&remote_info_buf, "%s (push)", url[i]);
 		string_list_append(list, remote->name)->util =
@@ -1249,10 +1244,8 @@ static int show_all(void)
 	result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
-		int i;
-
 		string_list_sort(&list);
-		for (i = 0; i < list.nr; i++) {
+		for (int i = 0; i < list.nr; i++) {
 			struct string_list_item *item = list.items + i;
 			if (verbose)
 				printf("%s\t%s\n", item->string,
@@ -1510,7 +1503,7 @@ static int get_remote_default(const char *key, const char *value UNUSED,
 
 static int update(int argc, const char **argv, const char *prefix)
 {
-	int i, prune = -1;
+	int prune = -1;
 	struct option options[] = {
 		OPT_BOOL('p', "prune", &prune,
 			 N_("prune remotes after fetching")),
@@ -1532,7 +1525,7 @@ static int update(int argc, const char **argv, const char *prefix)
 	strvec_push(&cmd.args, "--multiple");
 	if (argc < 2)
 		strvec_push(&cmd.args, "default");
-	for (i = 1; i < argc; i++)
+	for (int i = 1; i < argc; i++)
 		strvec_push(&cmd.args, argv[i]);
 
 	if (strcmp(cmd.args.v[cmd.args.nr-1], "default") == 0) {
@@ -1665,7 +1658,7 @@ static int get_url(int argc, const char **argv, const char *prefix)
 
 static int set_url(int argc, const char **argv, const char *prefix)
 {
-	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
+	int push_mode = 0, add_mode = 0, delete_mode = 0;
 	int matches = 0, negative_matches = 0;
 	const char *remotename = NULL;
 	const char *newurl = NULL;
@@ -1732,7 +1725,7 @@ static int set_url(int argc, const char **argv, const char *prefix)
 	if (regcomp(&old_regex, oldurl, REG_EXTENDED))
 		die(_("Invalid old URL pattern: %s"), oldurl);
 
-	for (i = 0; i < urlset_nr; i++)
+	for (int i = 0; i < urlset_nr; i++)
 		if (!regexec(&old_regex, urlset[i], 0, NULL, 0))
 			matches++;
 		else
diff --git a/builtin/repack.c b/builtin/repack.c
index ede36328a3..197af23c55 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -235,10 +235,9 @@ static void existing_packs_release(struct existing_packs *existing)
 static void collect_pack_filenames(struct existing_packs *existing,
 				   const struct string_list *extra_keep)
 {
-	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
 		int i;
 		const char *base;
 
@@ -340,9 +339,7 @@ static struct generated_pack_data *populate_pack_exts(const char *name)
 	struct stat statbuf;
 	struct strbuf path = STRBUF_INIT;
 	struct generated_pack_data *data = xcalloc(1, sizeof(*data));
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+	for (int i = 0; i < ARRAY_SIZE(exts); i++) {
 		strbuf_reset(&path);
 		strbuf_addf(&path, "%s-%s%s", packtmp, name, exts[i].name);
 
@@ -359,8 +356,7 @@ static struct generated_pack_data *populate_pack_exts(const char *name)
 static int has_pack_ext(const struct generated_pack_data *data,
 			const char *ext)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+	for (int i = 0; i < ARRAY_SIZE(exts); i++) {
 		if (strcmp(exts[i].name, ext))
 			continue;
 		return !!data->tempfiles[i];
@@ -460,10 +456,9 @@ static void init_pack_geometry(struct pack_geometry *geometry,
 			       struct existing_packs *existing,
 			       const struct pack_objects_args *args)
 {
-	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
 		if (args->local && !p->pack_local)
 			/*
 			 * When asked to only repack local packfiles we skip
@@ -592,8 +587,6 @@ static void split_pack_geometry(struct pack_geometry *geometry)
 
 static struct packed_git *get_preferred_pack(struct pack_geometry *geometry)
 {
-	uint32_t i;
-
 	if (!geometry) {
 		/*
 		 * No geometry means either an all-into-one repack (in which
@@ -614,7 +607,7 @@ static struct packed_git *get_preferred_pack(struct pack_geometry *geometry)
 	 * other words, it is the largest pack that does not get rolled up in
 	 * the geometric repack.
 	 */
-	for (i = geometry->pack_nr; i > geometry->split; i--)
+	for (uint32_t i = geometry->pack_nr; i > geometry->split; i--)
 		/*
 		 * A pack that is not local would never be included in a
 		 * multi-pack index. We thus skip over any non-local packs.
@@ -630,9 +623,7 @@ static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
 					    struct existing_packs *existing)
 {
 	struct strbuf buf = STRBUF_INIT;
-	uint32_t i;
-
-	for (i = 0; i < geometry->split; i++) {
+	for (uint32_t i = 0; i < geometry->split; i++) {
 		struct packed_git *p = geometry->pack[i];
 		if (string_list_has_string(names, hash_to_hex(p->hash)))
 			continue;
@@ -734,8 +725,7 @@ static void midx_included_packs(struct string_list *include,
 		string_list_insert(include, xstrfmt("pack-%s.idx", item->string));
 	if (geometry->split_factor) {
 		struct strbuf buf = STRBUF_INIT;
-		uint32_t i;
-		for (i = geometry->split; i < geometry->pack_nr; i++) {
+		for (uint32_t i = geometry->split; i < geometry->pack_nr; i++) {
 			struct packed_git *p = geometry->pack[i];
 
 			/*
diff --git a/builtin/replace.c b/builtin/replace.c
index da59600ad2..79f2c1c337 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -109,7 +109,7 @@ typedef int (*each_replace_name_fn)(const char *name, const char *ref,
 
 static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 {
-	const char **p, *full_hex;
+	const char *full_hex;
 	struct strbuf ref = STRBUF_INIT;
 	size_t base_len;
 	int had_error = 0;
@@ -119,7 +119,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 	strbuf_addstr(&ref, git_replace_ref_base);
 	base_len = ref.len;
 
-	for (p = argv; *p; p++) {
+	for (const char **p = argv; *p; p++) {
 		if (repo_get_oid(the_repository, *p, &oid)) {
 			error("failed to resolve '%s' as a valid ref", *p);
 			had_error = 1;
@@ -367,7 +367,6 @@ static int replace_parents(struct strbuf *buf, int argc, const char **argv)
 {
 	struct strbuf new_parents = STRBUF_INIT;
 	const char *parent_start, *parent_end;
-	int i;
 	const unsigned hexsz = the_hash_algo->hexsz;
 
 	/* find existing parents */
@@ -379,7 +378,7 @@ static int replace_parents(struct strbuf *buf, int argc, const char **argv)
 		parent_end += hexsz + 8; /* "parent " + "hex sha1" + "\n" */
 
 	/* prepare new parents */
-	for (i = 0; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		struct object_id oid;
 		struct commit *commit;
 
@@ -417,7 +416,6 @@ static int check_one_mergetag(struct commit *commit UNUSED,
 	const char *ref = mergetag_data->argv[0];
 	struct object_id tag_oid;
 	struct tag *tag;
-	int i;
 
 	hash_object_file(the_hash_algo, extra->value, extra->len,
 			 OBJ_TAG, &tag_oid);
@@ -428,7 +426,7 @@ static int check_one_mergetag(struct commit *commit UNUSED,
 		return error(_("malformed mergetag in commit '%s'"), ref);
 
 	/* iterate over new parents */
-	for (i = 1; i < mergetag_data->argc; i++) {
+	for (int i = 1; i < mergetag_data->argc; i++) {
 		struct object_id oid;
 		if (repo_get_oid(the_repository, mergetag_data->argv[i], &oid) < 0)
 			return error(_("not a valid object name: '%s'"),
diff --git a/builtin/replay.c b/builtin/replay.c
index 6bc4b47f09..624636cc6e 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -94,8 +94,6 @@ struct ref_info {
 static void get_ref_information(struct rev_cmdline_info *cmd_info,
 				struct ref_info *ref_info)
 {
-	int i;
-
 	ref_info->onto = NULL;
 	strset_init(&ref_info->positive_refs);
 	strset_init(&ref_info->negative_refs);
@@ -117,7 +115,7 @@ static void get_ref_information(struct rev_cmdline_info *cmd_info,
 	 * the second because they'd likely just be replaying commits on top
 	 * of the same commit and not making any difference.
 	 */
-	for (i = 0; i < cmd_info->nr; i++) {
+	for (int i = 0; i < cmd_info->nr; i++) {
 		struct rev_cmdline_entry *e = cmd_info->rev + i;
 		struct object_id oid;
 		const char *refexpr = e->name;
diff --git a/builtin/rerere.c b/builtin/rerere.c
index b2efc6f640..29cf9d17d2 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -16,8 +16,7 @@ static const char * const rerere_usage[] = {
 
 static int outf(void *dummy UNUSED, mmbuffer_t *ptr, int nbuf)
 {
-	int i;
-	for (i = 0; i < nbuf; i++)
+	for (int i = 0; i < nbuf; i++)
 		if (write_in_full(1, ptr[i].ptr, ptr[i].size) < 0)
 			return -1;
 	return 0;
diff --git a/builtin/reset.c b/builtin/reset.c
index f0bf29a478..b654c00511 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -58,7 +58,7 @@ static inline int is_merge(void)
 
 static int reset_index(const char *ref, const struct object_id *oid, int reset_type, int quiet)
 {
-	int i, nr = 0;
+	int nr = 0;
 	struct tree_desc desc[2];
 	struct tree *tree;
 	struct unpack_trees_options opts;
@@ -122,7 +122,7 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 	ret = 0;
 
 out:
-	for (i = 0; i < nr; i++)
+	for (int i = 0; i < nr; i++)
 		free((void *)desc[i].buffer);
 	return ret;
 }
@@ -145,10 +145,9 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 				   struct diff_options *opt UNUSED,
 				   void *data)
 {
-	int i;
 	int intent_to_add = *(int *)data;
 
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		int pos;
 		struct diff_filespec *one = q->queue[i]->one;
 		int is_in_reset_tree = one->mode && !is_null_oid(&one->oid);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index b3f4783858..0aa0320756 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -742,12 +742,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	}
 
 	if (filter_provided_objects) {
-		struct commit_list *c;
 		for (i = 0; i < revs.pending.nr; i++) {
 			struct object_array_entry *pending = revs.pending.objects + i;
 			pending->item->flags |= NOT_USER_GIVEN;
 		}
-		for (c = revs.commits; c; c = c->next)
+		for (struct commit_list *c = revs.commits; c; c = c->next)
 			c->item->object.flags |= NOT_USER_GIVEN;
 	}
 
diff --git a/builtin/rm.c b/builtin/rm.c
index fd130cea2d..fe2c0c5b7b 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -55,11 +55,10 @@ static void print_error_files(struct string_list *files_list,
 			      int *errs)
 {
 	if (files_list->nr) {
-		int i;
 		struct strbuf err_msg = STRBUF_INIT;
 
 		strbuf_addstr(&err_msg, main_msg);
-		for (i = 0; i < files_list->nr; i++)
+		for (int i = 0; i < files_list->nr; i++)
 			strbuf_addf(&err_msg,
 				    "\n    %s",
 				    files_list->items[i].string);
@@ -72,8 +71,7 @@ static void print_error_files(struct string_list *files_list,
 
 static void submodules_absorb_gitdir_if_needed(void)
 {
-	int i;
-	for (i = 0; i < list.nr; i++) {
+	for (int i = 0; i < list.nr; i++) {
 		const char *name = list.entry[i].name;
 		int pos;
 		const struct cache_entry *ce;
@@ -105,14 +103,14 @@ static int check_local_mod(struct object_id *head, int index_only)
 	 * lazy, and who cares if removal of files is a tad
 	 * slower than the theoretical maximum speed?
 	 */
-	int i, no_head;
+	int no_head;
 	int errs = 0;
 	struct string_list files_staged = STRING_LIST_INIT_NODUP;
 	struct string_list files_cached = STRING_LIST_INIT_NODUP;
 	struct string_list files_local = STRING_LIST_INIT_NODUP;
 
 	no_head = is_null_oid(head);
-	for (i = 0; i < list.nr; i++) {
+	for (int i = 0; i < list.nr; i++) {
 		struct stat st;
 		int pos;
 		const struct cache_entry *ce;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 3df9eaad09..30ea49318f 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -327,8 +327,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		transport_print_push_status(dest, remote_refs, args.verbose, 0, &reject_reasons);
 
 	if (!args.dry_run && remote) {
-		struct ref *ref;
-		for (ref = remote_refs; ref; ref = ref->next)
+		for (struct ref *ref = remote_refs; ref; ref = ref->next)
 			transport_update_tracking_ref(remote, ref, args.verbose);
 	}
 
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1307ed2b88..cf25851837 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -478,13 +478,13 @@ static void add_wrapped_shortlog_msg(struct strbuf *sb, const char *s,
 
 void shortlog_output(struct shortlog *log)
 {
-	size_t i, j;
+	size_t j;
 	struct strbuf sb = STRBUF_INIT;
 
 	if (log->sort_by_number)
 		STABLE_QSORT(log->list.items, log->list.nr,
 		      log->summary ? compare_by_counter : compare_by_list);
-	for (i = 0; i < log->list.nr; i++) {
+	for (size_t i = 0; i < log->list.nr; i++) {
 		const struct string_list_item *item = &log->list.items[i];
 		if (log->summary) {
 			fprintf(log->file, "%6d\t%s\n",
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index b01ec761d2..cd9ba4db63 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -523,9 +523,7 @@ static int show_independent(struct commit **rev,
 			    int num_rev,
 			    unsigned int *rev_mask)
 {
-	int i;
-
-	for (i = 0; i < num_rev; i++) {
+	for (int i = 0; i < num_rev; i++) {
 		struct commit *commit = rev[i];
 		unsigned int flag = rev_mask[i];
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 0f52e25249..15460f153f 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -26,9 +26,7 @@ static char const * const builtin_sparse_checkout_usage[] = {
 
 static void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
 {
-	int i;
-
-	for (i = 0; i < pl->nr; i++) {
+	for (int i = 0; i < pl->nr; i++) {
 		struct path_pattern *p = pl->patterns[i];
 
 		if (p->flags & PATTERN_FLAG_NEGATIVE)
@@ -79,7 +77,6 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
 	}
 
 	if (pl.use_cone_patterns) {
-		int i;
 		struct pattern_entry *pe;
 		struct hashmap_iter iter;
 		struct string_list sl = STRING_LIST_INIT_DUP;
@@ -91,7 +88,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
 
 		string_list_sort(&sl);
 
-		for (i = 0; i < sl.nr; i++) {
+		for (int i = 0; i < sl.nr; i++) {
 			quote_c_style(sl.items[i].string, NULL, stdout, 0);
 			printf("\n");
 		}
@@ -107,7 +104,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
 
 static void clean_tracked_sparse_directories(struct repository *r)
 {
-	int i, was_full = 0;
+	int was_full = 0;
 	struct strbuf path = STRBUF_INIT;
 	size_t pathlen;
 	struct string_list_item *item;
@@ -150,7 +147,7 @@ static void clean_tracked_sparse_directories(struct repository *r)
 	 * store the entries in a list before exploring, since that might
 	 * expand the sparse-index again.
 	 */
-	for (i = 0; i < r->index->cache_nr; i++) {
+	for (int i = 0; i < r->index->cache_nr; i++) {
 		struct cache_entry *ce = r->index->cache[i];
 
 		if (S_ISSPARSEDIR(ce->ce_mode) &&
diff --git a/builtin/stash.c b/builtin/stash.c
index 7fb355bff0..0bedbe485d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -179,10 +179,9 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	struct strbuf symbolic = STRBUF_INIT;
 
 	if (argc > 1) {
-		int i;
 		struct strbuf refs_msg = STRBUF_INIT;
 
-		for (i = 0; i < argc; i++)
+		for (int i = 0; i < argc; i++)
 			strbuf_addf(&refs_msg, " '%s'", argv[i]);
 
 		fprintf_ln(stderr, _("Too many revisions specified:%s"),
@@ -364,9 +363,7 @@ static void add_diff_to_buf(struct diff_queue_struct *q,
 			    struct diff_options *options UNUSED,
 			    void *data)
 {
-	int i;
-
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		if (is_path_a_directory(q->queue[i]->one->path))
 			continue;
 
@@ -424,7 +421,6 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 	struct checkout state = CHECKOUT_INIT;
 	struct diff_options diff_opts;
 	struct lock_file lock = LOCK_INIT;
-	int i;
 
 	/* If any entries have skip_worktree set, we'll have to check 'em out */
 	state.force = 1;
@@ -447,7 +443,7 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 	diffcore_std(&diff_opts);
 
 	/* Iterate over the paths that changed due to the merge... */
-	for (i = 0; i < diff_queued_diff.nr; i++) {
+	for (int i = 0; i < diff_queued_diff.nr; i++) {
 		struct diff_filepair *p;
 		struct cache_entry *ce;
 		int pos;
@@ -864,9 +860,7 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 	struct tree *tree[ARRAY_SIZE(oid)];
 	struct tree_desc tree_desc[ARRAY_SIZE(oid)];
 	struct unpack_trees_options unpack_tree_opt = { 0 };
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(oid); i++) {
+	for (int i = 0; i < ARRAY_SIZE(oid); i++) {
 		tree[i] = parse_tree_indirect(oid[i]);
 		if (parse_tree(tree[i]) < 0)
 			die(_("failed to parse tree"));
@@ -887,7 +881,6 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 
 static int show_stash(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	int ret = -1;
 	struct stash_info info = STASH_INFO_INIT;
 	struct rev_info rev;
@@ -918,7 +911,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	strvec_push(&revision_args, argv[0]);
-	for (i = 1; i < argc; i++) {
+	for (int i = 1; i < argc; i++) {
 		if (argv[i][0] != '-')
 			strvec_push(&stash_args, argv[i]);
 		else
@@ -1049,9 +1042,7 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 
 static void add_pathspecs(struct strvec *args,
 			  const struct pathspec *ps) {
-	int i;
-
-	for (i = 0; i < ps->nr; i++)
+	for (int i = 0; i < ps->nr; i++)
 		strvec_push(args, ps->items[i].original);
 }
 
@@ -1065,7 +1056,6 @@ static void add_pathspecs(struct strvec *args,
 static int get_untracked_files(const struct pathspec *ps, int include_untracked,
 			       struct strbuf *untracked_files)
 {
-	int i;
 	int found = 0;
 	struct dir_struct dir = DIR_INIT;
 
@@ -1073,7 +1063,7 @@ static int get_untracked_files(const struct pathspec *ps, int include_untracked,
 		setup_standard_excludes(&dir);
 
 	fill_directory(&dir, the_repository->index, ps);
-	for (i = 0; i < dir.nr; i++) {
+	for (int i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		found++;
 		strbuf_addstr(untracked_files, ent->name);
@@ -1535,12 +1525,11 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 	repo_read_index_preload(the_repository, NULL, 0);
 	if (!include_untracked && ps->nr) {
-		int i;
 		char *ps_matched = xcalloc(ps->nr, 1);
 
 		/* TODO: audit for interaction with sparse-index. */
 		ensure_full_index(&the_index);
-		for (i = 0; i < the_index.cache_nr; i++)
+		for (int i = 0; i < the_index.cache_nr; i++)
 			ce_path_match(&the_index, the_index.cache[i], ps,
 				      ps_matched);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fda50f2af1..711a184b62 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -143,7 +143,6 @@ static char *get_submodule_displaypath(const char *path, const char *prefix,
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char ***d;
 
 	static const char *describe_bare[] = { NULL };
 
@@ -157,7 +156,7 @@ static char *compute_rev_name(const char *sub_path, const char* object_id)
 						describe_contains,
 						describe_all_always, NULL };
 
-	for (d = describe_argv; *d; d++) {
+	for (const char ***d = describe_argv; *d; d++) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		prepare_submodule_repo_env(&cp.env);
 		cp.dir = sub_path;
@@ -194,7 +193,7 @@ static int module_list_compute(const char **argv,
 			       struct pathspec *pathspec,
 			       struct module_list *list)
 {
-	int i, result = 0;
+	int result = 0;
 	char *ps_matched = NULL;
 
 	parse_pathspec(pathspec, 0,
@@ -207,7 +206,7 @@ static int module_list_compute(const char **argv,
 	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
-	for (i = 0; i < the_index.cache_nr; i++) {
+	for (int i = 0; i < the_index.cache_nr; i++) {
 		const struct cache_entry *ce = the_index.cache[i];
 
 		if (!match_pathspec(&the_index, pathspec, ce->name, ce_namelen(ce),
@@ -236,10 +235,9 @@ static int module_list_compute(const char **argv,
 
 static void module_list_active(struct module_list *list)
 {
-	int i;
 	struct module_list active_modules = MODULE_LIST_INIT;
 
-	for (i = 0; i < list->nr; i++) {
+	for (int i = 0; i < list->nr; i++) {
 		const struct cache_entry *ce = list->entries[i];
 
 		if (!is_submodule_active(the_repository, ce->name))
@@ -257,10 +255,9 @@ static void module_list_active(struct module_list *list)
 
 static char *get_up_path(const char *path)
 {
-	int i;
 	struct strbuf sb = STRBUF_INIT;
 
-	for (i = count_slashes(path); i; i--)
+	for (int i = count_slashes(path); i; i--)
 		strbuf_addstr(&sb, "../");
 
 	/*
@@ -277,9 +274,7 @@ static char *get_up_path(const char *path)
 static void for_each_listed_submodule(const struct module_list *list,
 				      each_submodule_fn fn, void *cb_data)
 {
-	int i;
-
-	for (i = 0; i < list->nr; i++)
+	for (int i = 0; i < list->nr; i++)
 		fn(list->entries[i], cb_data);
 }
 
@@ -787,9 +782,7 @@ struct module_cb_list {
 
 static void module_cb_list_release(struct module_cb_list *mcbl)
 {
-	int i;
-
-	for (i = 0; i < mcbl->nr; i++) {
+	for (int i = 0; i < mcbl->nr; i++) {
 		struct module_cb *mcb = mcbl->entries[i];
 
 		module_cb_release(mcb);
@@ -1021,8 +1014,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 static void prepare_submodule_summary(struct summary_cb *info,
 				      struct module_cb_list *list)
 {
-	int i;
-	for (i = 0; i < list->nr; i++) {
+	for (int i = 0; i < list->nr; i++) {
 		const struct submodule *sub;
 		struct module_cb *p = list->entries[i];
 		struct strbuf sm_gitdir = STRBUF_INIT;
@@ -1063,9 +1055,8 @@ static void submodule_summary_callback(struct diff_queue_struct *q,
 				       struct diff_options *options UNUSED,
 				       void *data)
 {
-	int i;
 	struct module_cb_list *list = data;
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		struct module_cb *temp;
 
@@ -2592,7 +2583,7 @@ static int update_submodule(struct update_data *update_data)
 
 static int update_submodules(struct update_data *update_data)
 {
-	int i, ret = 0;
+	int ret = 0;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
 	const struct run_process_parallel_opts opts = {
 		.tr2_category = "submodule",
@@ -2622,7 +2613,7 @@ static int update_submodules(struct update_data *update_data)
 		goto cleanup;
 	}
 
-	for (i = 0; i < suc.update_clone_nr; i++) {
+	for (int i = 0; i < suc.update_clone_nr; i++) {
 		struct update_clone_data ucd = suc.update_clone[i];
 		int code;
 
@@ -2812,13 +2803,12 @@ static int push_check(int argc, const char **argv, const char *prefix UNUSED)
 
 	/* Check the refspec */
 	if (argc > 2) {
-		int i;
 		struct ref *local_refs = get_local_heads();
 		struct refspec refspec = REFSPEC_INIT_PUSH;
 
 		refspec_appendn(&refspec, argv + 2, argc - 2);
 
-		for (i = 0; i < refspec.nr; i++) {
+		for (int i = 0; i < refspec.nr; i++) {
 			const struct refspec_item *rs = &refspec.items[i];
 
 			if (rs->pattern || rs->matching)
@@ -2855,7 +2845,6 @@ static int push_check(int argc, const char **argv, const char *prefix UNUSED)
 
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	const char *super_prefix = NULL;
@@ -2875,7 +2864,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	if (module_list_compute(argv, prefix, &pathspec, &list) < 0)
 		goto cleanup;
 
-	for (i = 0; i < list.nr; i++)
+	for (int i = 0; i < list.nr; i++)
 		absorb_git_dir_into_superproject(list.entries[i]->name,
 						 super_prefix);
 
@@ -3239,7 +3228,6 @@ static void die_on_index_match(const char *path, int force)
 		die(_("index file corrupt"));
 
 	if (ps.nr) {
-		int i;
 		char *ps_matched = xcalloc(ps.nr, 1);
 
 		/* TODO: audit for interaction with sparse-index. */
@@ -3249,7 +3237,7 @@ static void die_on_index_match(const char *path, int force)
 		 * Since there is only one pathspec, we just need to
 		 * check ps_matched[0] to know if a cache entry matched.
 		 */
-		for (i = 0; i < the_index.cache_nr; i++) {
+		for (int i = 0; i < the_index.cache_nr; i++) {
 			ce_path_match(&the_index, the_index.cache[i], &ps,
 				      ps_matched);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 37473ac21f..2e2b315183 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -78,12 +78,11 @@ typedef int (*each_tag_name_fn)(const char *name, const char *ref,
 static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 			     void *cb_data)
 {
-	const char **p;
 	struct strbuf ref = STRBUF_INIT;
 	int had_error = 0;
 	struct object_id oid;
 
-	for (p = argv; *p; p++) {
+	for (const char **p = argv; *p; p++) {
 		strbuf_reset(&ref);
 		strbuf_addf(&ref, "refs/tags/%s", *p);
 		if (read_ref(ref.buf, &oid)) {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e0a701f2b3..0801d13b0e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -248,8 +248,7 @@ static int check_object(struct object *obj, enum object_type type,
 
 static void write_rest(void)
 {
-	unsigned i;
-	for (i = 0; i < nr_objects; i++) {
+	for (unsigned i = 0; i < nr_objects; i++) {
 		if (obj_list[i].obj)
 			check_object(obj_list[i].obj, OBJ_ANY, NULL, NULL);
 	}
@@ -574,7 +573,6 @@ static void unpack_one(unsigned nr)
 
 static void unpack_all(void)
 {
-	int i;
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
 
 	nr_objects = ntohl(hdr->hdr_entries);
@@ -590,7 +588,7 @@ static void unpack_all(void)
 		progress = start_progress(_("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
 	begin_odb_transaction();
-	for (i = 0; i < nr_objects; i++) {
+	for (int i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
 	}
@@ -603,7 +601,6 @@ static void unpack_all(void)
 
 int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 {
-	int i;
 	struct object_id oid;
 	git_hash_ctx tmp_ctx;
 
@@ -613,7 +610,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 
 	quiet = !isatty(2);
 
-	for (i = 1 ; i < argc; i++) {
+	for (int i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
 		if (*arg == '-') {
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7bcaa1476c..60e346960e 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -655,10 +655,9 @@ static int unresolve_one(const char *path)
 static int do_unresolve(int ac, const char **av,
 			const char *prefix, int prefix_length)
 {
-	int i;
 	int err = 0;
 
-	for (i = 1; i < ac; i++) {
+	for (int i = 1; i < ac; i++) {
 		const char *arg = av[i];
 		char *p = prefix_path(prefix, prefix_length, arg);
 		err |= unresolve_one(p);
@@ -670,10 +669,6 @@ static int do_unresolve(int ac, const char **av,
 static int do_reupdate(const char **paths,
 		       const char *prefix)
 {
-	/* Read HEAD and run update-index on paths that are
-	 * merged and already different between index and HEAD.
-	 */
-	int pos;
 	int has_head = 1;
 	struct pathspec pathspec;
 	struct object_id head_oid;
@@ -688,7 +683,7 @@ static int do_reupdate(const char **paths,
 		 */
 		has_head = 0;
  redo:
-	for (pos = 0; pos < the_index.cache_nr; pos++) {
+	for (int pos = 0; pos < the_index.cache_nr; pos++) {
 		const struct cache_entry *ce = the_index.cache[pos];
 		struct cache_entry *old = NULL;
 		int save_nr;
diff --git a/builtin/var.c b/builtin/var.c
index cf5567208a..3aa4e4d45b 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -168,10 +168,9 @@ static struct git_var git_vars[] = {
 
 static void list_vars(void)
 {
-	struct git_var *ptr;
 	char *val;
 
-	for (ptr = git_vars; ptr->read; ptr++)
+	for (struct git_var *ptr = git_vars; ptr->read; ptr++)
 		if ((val = ptr->read(0))) {
 			if (ptr->multivalued && *val) {
 				struct string_list list = STRING_LIST_INIT_DUP;
@@ -190,8 +189,7 @@ static void list_vars(void)
 
 static const struct git_var *get_git_var(const char *var)
 {
-	struct git_var *ptr;
-	for (ptr = git_vars; ptr->read; ptr++) {
+	for (struct git_var *ptr = git_vars; ptr->read; ptr++) {
 		if (strcmp(var, ptr->name) == 0) {
 			return ptr;
 		}
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 011dddd2dc..a342d5adf3 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -66,7 +66,6 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 	int err = 0;
 	unsigned int flags = 0;
 	const char *object_format = NULL;
-	int i;
 	const struct option verify_pack_options[] = {
 		OPT_BIT('v', "verbose", &flags, N_("verbose"),
 			VERIFY_PACK_VERBOSE),
@@ -82,7 +81,7 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 			     verify_pack_usage, 0);
 	if (argc < 1)
 		usage_with_options(verify_pack_usage, verify_pack_options);
-	for (i = 0; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		if (verify_one_pack(argv[i], flags, object_format))
 			err = 1;
 	}
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9c76b62b02..d4c5b6b7d3 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -191,10 +191,8 @@ static int prune_cmp(const void *a, const void *b)
 
 static void prune_dups(struct string_list *l)
 {
-	int i;
-
 	QSORT(l->items, l->nr, prune_cmp);
-	for (i = 1; i < l->nr; i++) {
+	for (int i = 1; i < l->nr; i++) {
 		if (!fspathcmp(l->items[i].string, l->items[i - 1].string))
 			prune_worktree(l->items[i].util, "duplicate entry");
 	}
@@ -999,9 +997,7 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 
 static void measure_widths(struct worktree **wt, int *abbrev, int *maxlen)
 {
-	int i;
-
-	for (i = 0; wt[i]; i++) {
+	for (int i = 0; wt[i]; i++) {
 		int sha1_len;
 		int path_len = strlen(wt[i]->path);
 
@@ -1055,7 +1051,7 @@ static int list(int ac, const char **av, const char *prefix)
 		die(_("the option '%s' requires '%s'"), "-z", "--porcelain");
 	else {
 		struct worktree **worktrees = get_worktrees();
-		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
+		int path_maxlen = 0, abbrev = DEFAULT_ABBREV;
 
 		/* sort worktrees by path but keep main worktree at top */
 		pathsort(worktrees + 1);
@@ -1063,7 +1059,7 @@ static int list(int ac, const char **av, const char *prefix)
 		if (!porcelain)
 			measure_widths(worktrees, &abbrev, &path_maxlen);
 
-		for (i = 0; worktrees[i]; i++) {
+		for (int i = 0; worktrees[i]; i++) {
 			if (porcelain)
 				show_worktree_porcelain(worktrees[i],
 							line_terminator);
diff --git a/bulk-checkin.c b/bulk-checkin.c
index eb46b88637..c00c4ad3a7 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -51,7 +51,6 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 {
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
-	int i;
 
 	if (!state->f)
 		return;
@@ -76,7 +75,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 	finish_tmp_packfile(&packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
 			    &state->pack_idx_opts, hash);
-	for (i = 0; i < state->nr_written; i++)
+	for (int i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
 
 clear_exit:
@@ -124,14 +123,12 @@ static void flush_batch_fsync(void)
 
 static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
 {
-	int i;
-
 	/* The object may already exist in the repository */
 	if (repo_has_object_file(the_repository, oid))
 		return 1;
 
 	/* Might want to keep the list sorted */
-	for (i = 0; i < state->nr_written; i++)
+	for (int i = 0; i < state->nr_written; i++)
 		if (oideq(&state->written[i]->oid, oid))
 			return 1;
 
diff --git a/bundle-uri.c b/bundle-uri.c
index ca32050a78..45d615a3db 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -114,8 +114,7 @@ void print_bundle_list(FILE *fp, struct bundle_list *list)
 	fprintf(fp, "\tmode = %s\n", mode);
 
 	if (list->heuristic) {
-		int i;
-		for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
+		for (int i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
 			if (heuristics[i].heuristic == list->heuristic) {
 				printf("\theuristic = %s\n",
 				       heuristics[list->heuristic].name);
@@ -167,8 +166,7 @@ static int bundle_list_update(const char *key, const char *value,
 		}
 
 		if (!strcmp(subkey, "heuristic")) {
-			int i;
-			for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
+			for (int i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
 				if (heuristics[i].heuristic &&
 				    heuristics[i].name &&
 				    !strcmp(value, heuristics[i].name)) {
diff --git a/bundle.c b/bundle.c
index a9744da255..419ba4cc45 100644
--- a/bundle.c
+++ b/bundle.c
@@ -60,9 +60,7 @@ static int parse_capability(struct bundle_header *header, const char *capability
 
 static int parse_bundle_signature(struct bundle_header *header, const char *line)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(bundle_sigs); i++) {
+	for (int i = 0; i < ARRAY_SIZE(bundle_sigs); i++) {
 		if (!strcmp(line, bundle_sigs[i].signature)) {
 			header->version = bundle_sigs[i].version;
 			return 0;
@@ -167,9 +165,7 @@ int is_bundle(const char *path, int quiet)
 
 static int list_refs(struct string_list *r, int argc, const char **argv)
 {
-	int i;
-
-	for (i = 0; i < r->nr; i++) {
+	for (int i = 0; i < r->nr; i++) {
 		struct object_id *oid;
 		const char *name;
 
@@ -216,7 +212,7 @@ int verify_bundle(struct repository *r,
 	 * to be verbose about the errors
 	 */
 	struct string_list *p = &header->prerequisites;
-	int i, ret = 0;
+	int ret = 0;
 	const char *message = _("Repository lacks these prerequisite commits:");
 	struct string_list_iterator iter = {
 		.list = p,
@@ -228,7 +224,7 @@ int verify_bundle(struct repository *r,
 	if (!r || !r->objects || !r->objects->odb)
 		return error(_("need a repository to verify a bundle"));
 
-	for (i = 0; i < p->nr; i++) {
+	for (int i = 0; i < p->nr; i++) {
 		struct string_list_item *e = p->items + i;
 		const char *name = e->string;
 		struct object_id *oid = e->util;
@@ -320,7 +316,6 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *pack_options)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
-	int i;
 
 	strvec_pushl(&pack_objects.args,
 		     "pack-objects",
@@ -350,7 +345,7 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
 	if (start_command(&pack_objects))
 		return error(_("Could not spawn pack-objects"));
 
-	for (i = 0; i < revs->pending.nr; i++) {
+	for (int i = 0; i < revs->pending.nr; i++) {
 		struct object *object = revs->pending.objects[i].item;
 		if (object->flags & UNINTERESTING)
 			write_or_die(pack_objects.in, "^", 1);
@@ -374,10 +369,9 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
  */
 static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 {
-	int i;
 	int ref_count = 0;
 
-	for (i = 0; i < revs->pending.nr; i++) {
+	for (int i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *e = revs->pending.objects + i;
 		struct object_id oid;
 		char *ref;
@@ -500,7 +494,6 @@ int create_bundle(struct repository *r, const char *path,
 	struct rev_info revs, revs_copy;
 	int min_version = 2;
 	struct bundle_prerequisites_info bpi;
-	int i;
 
 	/* init revs to list objects for pack-objects later */
 	save_commit_buffer = 0;
@@ -566,7 +559,7 @@ int create_bundle(struct repository *r, const char *path,
 	revs_copy.pending.nr = 0;
 	revs_copy.pending.alloc = 0;
 	revs_copy.pending.objects = NULL;
-	for (i = 0; i < revs.pending.nr; i++) {
+	for (int i = 0; i < revs.pending.nr; i++) {
 		struct object_array_entry *e = revs.pending.objects + i;
 		if (e)
 			add_object_array_with_path(e->item, e->name,
diff --git a/cache-tree.c b/cache-tree.c
index 64678fe199..1aa30bdd80 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -27,12 +27,11 @@ struct cache_tree *cache_tree(void)
 
 void cache_tree_free(struct cache_tree **it_p)
 {
-	int i;
 	struct cache_tree *it = *it_p;
 
 	if (!it)
 		return;
-	for (i = 0; i < it->subtree_nr; i++)
+	for (int i = 0; i < it->subtree_nr; i++)
 		if (it->down[i]) {
 			cache_tree_free(&it->down[i]->cache_tree);
 			free(it->down[i]);
@@ -216,8 +215,8 @@ static void discard_unused_subtrees(struct cache_tree *it)
 {
 	struct cache_tree_sub **down = it->down;
 	int nr = it->subtree_nr;
-	int dst, src;
-	for (dst = src = 0; src < nr; src++) {
+	int src;
+	for (int dst = src = 0; src < nr; src++) {
 		struct cache_tree_sub *s = down[src];
 		if (s->used)
 			down[dst++] = s;
@@ -231,12 +230,11 @@ static void discard_unused_subtrees(struct cache_tree *it)
 
 int cache_tree_fully_valid(struct cache_tree *it)
 {
-	int i;
 	if (!it)
 		return 0;
 	if (it->entry_count < 0 || !repo_has_object_file(the_repository, &it->oid))
 		return 0;
-	for (i = 0; i < it->subtree_nr; i++) {
+	for (int i = 0; i < it->subtree_nr; i++) {
 		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
 			return 0;
 	}
@@ -495,8 +493,6 @@ int cache_tree_update(struct index_state *istate, int flags)
 static void write_one(struct strbuf *buffer, struct cache_tree *it,
 		      const char *path, int pathlen)
 {
-	int i;
-
 	/* One "cache-tree" entry consists of the following:
 	 * path (NUL terminated)
 	 * entry_count, subtree_nr ("%d %d\n")
@@ -520,7 +516,7 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
 	if (0 <= it->entry_count) {
 		strbuf_add(buffer, it->oid.hash, the_hash_algo->rawsz);
 	}
-	for (i = 0; i < it->subtree_nr; i++) {
+	for (int i = 0; i < it->subtree_nr; i++) {
 		struct cache_tree_sub *down = it->down[i];
 		if (i) {
 			struct cache_tree_sub *prev = it->down[i-1];
@@ -546,7 +542,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	const char *cp;
 	char *ep;
 	struct cache_tree *it;
-	int i, subtree_nr;
+	int subtree_nr;
 	const unsigned rawsz = the_hash_algo->rawsz;
 
 	it = NULL;
@@ -600,7 +596,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	 */
 	it->subtree_alloc = subtree_nr + 2;
 	CALLOC_ARRAY(it->down, it->subtree_alloc);
-	for (i = 0; i < subtree_nr; i++) {
+	for (int i = 0; i < subtree_nr; i++) {
 		/* read each subtree */
 		struct cache_tree *sub;
 		struct cache_tree_sub *subtree;
@@ -699,9 +695,8 @@ struct tree* write_in_core_index_as_tree(struct repository *repo) {
 
 	ret = write_index_as_tree_internal(&o, index_state, was_valid, 0, NULL);
 	if (ret == WRITE_TREE_UNMERGED_INDEX) {
-		int i;
 		bug("there are unmerged index entries:");
-		for (i = 0; i < index_state->cache_nr; i++) {
+		for (int i = 0; i < index_state->cache_nr; i++) {
 			const struct cache_entry *ce = index_state->cache[i];
 			if (ce_stage(ce))
 				bug("%d %.*s", ce_stage(ce),
diff --git a/chunk-format.c b/chunk-format.c
index cdc7f39b70..6ecf1b5326 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -189,9 +189,7 @@ int read_chunk(struct chunkfile *cf,
 	       chunk_read_fn fn,
 	       void *data)
 {
-	int i;
-
-	for (i = 0; i < cf->chunks_nr; i++) {
+	for (int i = 0; i < cf->chunks_nr; i++) {
 		if (cf->chunks[i].id == chunk_id)
 			return fn(cf->chunks[i].start, cf->chunks[i].size, data);
 	}
diff --git a/color.c b/color.c
index f663c06ac4..26a6ecdaff 100644
--- a/color.c
+++ b/color.c
@@ -85,7 +85,6 @@ static int parse_ansi_color(struct color *out, const char *name, int len)
 		"black", "red", "green", "yellow",
 		"blue", "magenta", "cyan", "white"
 	};
-	int i;
 	int color_offset = COLOR_FOREGROUND_ANSI;
 
 	if (match_word(name, len, "default")) {
@@ -114,7 +113,7 @@ static int parse_ansi_color(struct color *out, const char *name, int len)
 		name += 6;
 		len -= 6;
 	}
-	for (i = 0; i < ARRAY_SIZE(color_names); i++) {
+	for (int i = 0; i < ARRAY_SIZE(color_names); i++) {
 		if (match_word(name, len, color_names[i])) {
 			out->type = COLOR_ANSI;
 			out->value = i + color_offset;
@@ -200,14 +199,13 @@ static int parse_attr(const char *name, size_t len)
 #undef ATTR
 	};
 	int negate = 0;
-	int i;
 
 	if (skip_prefix_mem(name, len, "no", &name, &len)) {
 		skip_prefix_mem(name, len, "-", &name, &len);
 		negate = 1;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(attrs); i++) {
+	for (int i = 0; i < ARRAY_SIZE(attrs); i++) {
 		if (attrs[i].len == len && !memcmp(attrs[i].name, name, len))
 			return negate ? attrs[i].neg : attrs[i].val;
 	}
@@ -324,7 +322,6 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 
 	if (has_reset || attr || !color_empty(&fg) || !color_empty(&bg)) {
 		int sep = 0;
-		int i;
 
 		OUT('\033');
 		OUT('[');
@@ -332,7 +329,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 		if (has_reset)
 			sep++;
 
-		for (i = 0; attr; i++) {
+		for (int i = 0; attr; i++) {
 			unsigned bit = (1 << i);
 			if (!(attr & bit))
 				continue;
diff --git a/column.c b/column.c
index 50bbccc92e..a2c0dae297 100644
--- a/column.c
+++ b/column.c
@@ -33,10 +33,8 @@ static int item_length(const char *s)
  */
 static void layout(struct column_data *data, int *width)
 {
-	int i;
-
 	*width = 0;
-	for (i = 0; i < data->list->nr; i++)
+	for (int i = 0; i < data->list->nr; i++)
 		if (*width < data->len[i])
 			*width = data->len[i];
 
@@ -51,8 +49,8 @@ static void layout(struct column_data *data, int *width)
 
 static void compute_column_width(struct column_data *data)
 {
-	int i, x, y;
-	for (x = 0; x < data->cols; x++) {
+	int i, y;
+	for (int x = 0; x < data->cols; x++) {
 		data->width[x] = XY2LINEAR(data, x, 0);
 		for (y = 0; y < data->rows; y++) {
 			i = XY2LINEAR(data, x, y);
@@ -102,9 +100,7 @@ static void shrink_columns(struct column_data *data)
 static void display_plain(const struct string_list *list,
 			  const char *indent, const char *nl)
 {
-	int i;
-
-	for (i = 0; i < list->nr; i++)
+	for (int i = 0; i < list->nr; i++)
 		printf("%s%s%s", indent, list->items[i].string, nl);
 }
 
@@ -147,7 +143,7 @@ static void display_table(const struct string_list *list,
 			  const struct column_options *opts)
 {
 	struct column_data data;
-	int x, y, i, initial_width;
+	int x, initial_width;
 	char *empty_cell;
 
 	memset(&data, 0, sizeof(data));
@@ -156,7 +152,7 @@ static void display_table(const struct string_list *list,
 	data.opts = *opts;
 
 	ALLOC_ARRAY(data.len, list->nr);
-	for (i = 0; i < list->nr; i++)
+	for (int i = 0; i < list->nr; i++)
 		data.len[i] = item_length(list->items[i].string);
 
 	layout(&data, &initial_width);
@@ -166,7 +162,7 @@ static void display_table(const struct string_list *list,
 
 	empty_cell = xmallocz(initial_width);
 	memset(empty_cell, ' ', initial_width);
-	for (y = 0; y < data.rows; y++) {
+	for (int y = 0; y < data.rows; y++) {
 		for (x = 0; x < data.cols; x++)
 			if (display_cell(&data, initial_width, empty_cell, x, y))
 				break;
@@ -243,9 +239,7 @@ static int parse_option(const char *arg, int len, unsigned int *colopts,
 		{ "row",    COL_ROW,      COL_LAYOUT_MASK },
 		{ "dense",  COL_DENSE,    0 },
 	};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(opts); i++) {
+	for (int i = 0; i < ARRAY_SIZE(opts); i++) {
 		int set = 1, arg_len = len, name_len;
 		const char *arg_str = arg;
 
diff --git a/combine-diff.c b/combine-diff.c
index d6d6fa1689..a1d58f9029 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -891,11 +891,11 @@ static void reuse_combine_diff(struct sline *sline, unsigned long cnt,
 	 * and parent j are the same, so reuse the combined result
 	 * of parent j for parent i.
 	 */
-	unsigned long lno, imask, jmask;
+	unsigned long imask, jmask;
 	imask = (1UL<<i);
 	jmask = (1UL<<j);
 
-	for (lno = 0; lno <= cnt; lno++) {
+	for (unsigned long lno = 0; lno <= cnt; lno++) {
 		struct lline *ll = sline->lost;
 		sline->p_lno[i] = sline->p_lno[j];
 		while (ll) {
@@ -1321,7 +1321,6 @@ static void free_combined_pair(struct diff_filepair *pair)
 static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 					   int num_parent)
 {
-	int i;
 	struct diff_filepair *pair;
 	struct diff_filespec *pool;
 
@@ -1330,7 +1329,7 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 	pair->one = pool + 1;
 	pair->two = pool;
 
-	for (i = 0; i < num_parent; i++) {
+	for (int i = 0; i < num_parent; i++) {
 		pair->one[i].path = p->path;
 		pair->one[i].mode = p->parent[i].mode;
 		oidcpy(&pair->one[i].oid, &p->parent[i].oid);
@@ -1389,7 +1388,7 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 	int combined_all_paths)
 {
 	struct combine_diff_path *paths = NULL;
-	int i, num_parent = parents->nr;
+	int num_parent = parents->nr;
 
 	int output_format = opt->output_format;
 	const char *orderfile = opt->orderfile;
@@ -1399,7 +1398,7 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 	opt->orderfile = NULL;
 
 	/* D(A,P1...Pn) = D(A,P1) ^ ... ^ D(A,Pn)  (wrt paths) */
-	for (i = 0; i < num_parent; i++) {
+	for (int i = 0; i < num_parent; i++) {
 		/*
 		 * show stat against the first parent even when doing
 		 * combined diff.
@@ -1437,13 +1436,13 @@ static struct combine_diff_path *find_paths_multitree(
 	const struct object_id *oid, const struct oid_array *parents,
 	struct diff_options *opt)
 {
-	int i, nparent = parents->nr;
+	int nparent = parents->nr;
 	const struct object_id **parents_oid;
 	struct combine_diff_path paths_head;
 	struct strbuf base;
 
 	ALLOC_ARRAY(parents_oid, nparent);
-	for (i = 0; i < nparent; i++)
+	for (int i = 0; i < nparent; i++)
 		parents_oid[i] = &parents->oid[i];
 
 	/* fake list head, so worker can assume it is non-NULL */
@@ -1461,10 +1460,9 @@ static int match_objfind(struct combine_diff_path *path,
 			 int num_parent,
 			 const struct oidset *set)
 {
-	int i;
 	if (oidset_contains(set, &path->oid))
 		return 1;
-	for (i = 0; i < num_parent; i++) {
+	for (int i = 0; i < num_parent; i++) {
 		if (oidset_contains(set, &path->parent[i].oid))
 			return 1;
 	}
diff --git a/commit-graph.c b/commit-graph.c
index 45417d7412..ab4b8d5300 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -139,7 +139,7 @@ static timestamp_t commit_graph_generation_from_graph(const struct commit *c)
 
 static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
 {
-	unsigned int i, nth_slab;
+	unsigned int nth_slab;
 	struct commit_graph_data *data =
 		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
 
@@ -156,7 +156,7 @@ static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
 	 * We avoid initializing generation with checking if graph position
 	 * is not COMMIT_NOT_FROM_GRAPH.
 	 */
-	for (i = 0; i < commit_graph_data_slab.slab_size; i++) {
+	for (unsigned int i = 0; i < commit_graph_data_slab.slab_size; i++) {
 		commit_graph_data_slab.slab[nth_slab][i].graph_pos =
 			COMMIT_NOT_FROM_GRAPH;
 	}
@@ -278,14 +278,13 @@ static int graph_read_oid_fanout(const unsigned char *chunk_start,
 				 size_t chunk_size, void *data)
 {
 	struct commit_graph *g = data;
-	int i;
 
 	if (chunk_size != 256 * sizeof(uint32_t))
 		return error(_("commit-graph oid fanout chunk is wrong size"));
 	g->chunk_oid_fanout = (const uint32_t *)chunk_start;
 	g->num_commits = ntohl(g->chunk_oid_fanout[255]);
 
-	for (i = 0; i < 255; i++) {
+	for (int i = 0; i < 255; i++) {
 		uint32_t oid_fanout1 = ntohl(g->chunk_oid_fanout[i]);
 		uint32_t oid_fanout2 = ntohl(g->chunk_oid_fanout[i + 1]);
 
@@ -722,8 +721,6 @@ static void prepare_commit_graph_one(struct repository *r,
  */
 static int prepare_commit_graph(struct repository *r)
 {
-	struct object_directory *odb;
-
 	/*
 	 * Early return if there is no git dir or if the commit graph is
 	 * disabled.
@@ -754,9 +751,7 @@ static int prepare_commit_graph(struct repository *r)
 		return 0;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb;
-	     !r->objects->commit_graph && odb;
-	     odb = odb->next)
+	for (struct object_directory *odb = r->objects->odb; !r->objects->commit_graph && odb; odb = odb->next)
 		prepare_commit_graph_one(r, odb);
 	return !!r->objects->commit_graph;
 }
@@ -1153,7 +1148,7 @@ static int write_graph_chunk_fanout(struct hashfile *f,
 				    void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int i, count = 0;
+	int count = 0;
 	struct commit **list = ctx->commits.list;
 
 	/*
@@ -1161,7 +1156,7 @@ static int write_graph_chunk_fanout(struct hashfile *f,
 	 * but we use a 256-entry lookup to be able to avoid
 	 * having to do eight extra binary search iterations).
 	 */
-	for (i = 0; i < 256; i++) {
+	for (int i = 0; i < 256; i++) {
 		while (count < ctx->commits.nr) {
 			if ((*list)->object.oid.hash[0] != i)
 				break;
@@ -1181,8 +1176,7 @@ static int write_graph_chunk_oids(struct hashfile *f,
 {
 	struct write_commit_graph_context *ctx = data;
 	struct commit **list = ctx->commits.list;
-	int count;
-	for (count = 0; count < ctx->commits.nr; count++, list++) {
+	for (int count = 0; count < ctx->commits.nr; count++, list++) {
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 		hashwrite(f, (*list)->object.oid.hash, the_hash_algo->rawsz);
 	}
@@ -1303,9 +1297,9 @@ static int write_graph_chunk_generation_data(struct hashfile *f,
 					     void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int i, num_generation_data_overflows = 0;
+	int num_generation_data_overflows = 0;
 
-	for (i = 0; i < ctx->commits.nr; i++) {
+	for (int i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
 		timestamp_t offset;
 		repo_parse_commit(ctx->r, c);
@@ -1327,8 +1321,7 @@ static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
 						      void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int i;
-	for (i = 0; i < ctx->commits.nr; i++) {
+	for (int i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
 		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -1487,8 +1480,7 @@ static int add_packed_commits(const struct object_id *oid,
 
 static void add_missing_parents(struct write_commit_graph_context *ctx, struct commit *commit)
 {
-	struct commit_list *parent;
-	for (parent = commit->parents; parent; parent = parent->next) {
+	for (struct commit_list *parent = commit->parents; parent; parent = parent->next) {
 		if (!(parent->item->object.flags & REACHABLE)) {
 			oid_array_append(&ctx->oids, &parent->item->object.oid);
 			parent->item->object.flags |= REACHABLE;
@@ -1589,10 +1581,9 @@ static void compute_reachable_generation_numbers(
 			struct compute_generation_info *info,
 			int generation_version)
 {
-	int i;
 	struct commit_list *list = NULL;
 
-	for (i = 0; i < info->commits->nr; i++) {
+	for (int i = 0; i < info->commits->nr; i++) {
 		struct commit *c = info->commits->list[i];
 		timestamp_t gen;
 		repo_parse_commit(info->r, c);
@@ -1758,7 +1749,6 @@ static void trace2_bloom_filter_write_statistics(struct write_commit_graph_conte
 
 static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
-	int i;
 	struct progress *progress = NULL;
 	struct commit **sorted_commits;
 	int max_new_filters;
@@ -1780,7 +1770,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	max_new_filters = ctx->opts && ctx->opts->max_new_filters >= 0 ?
 		ctx->opts->max_new_filters : ctx->commits.nr;
 
-	for (i = 0; i < ctx->commits.nr; i++) {
+	for (int i = 0; i < ctx->commits.nr; i++) {
 		enum bloom_filter_computed computed = 0;
 		struct commit *c = sorted_commits[i];
 		struct bloom_filter *filter = get_or_compute_bloom_filter(
@@ -1859,7 +1849,6 @@ int write_commit_graph_reachable(struct object_directory *odb,
 static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 				const struct string_list *pack_indexes)
 {
-	uint32_t i;
 	struct strbuf progress_title = STRBUF_INIT;
 	struct strbuf packname = STRBUF_INIT;
 	int dirlen;
@@ -1876,7 +1865,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 		ctx->progress = start_delayed_progress(progress_title.buf, 0);
 		ctx->progress_done = 0;
 	}
-	for (i = 0; i < pack_indexes->nr; i++) {
+	for (uint32_t i = 0; i < pack_indexes->nr; i++) {
 		struct packed_git *p;
 		strbuf_setlen(&packname, dirlen);
 		strbuf_addstr(&packname, pack_indexes->items[i].string);
@@ -1935,7 +1924,6 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 
 static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 {
-	uint32_t i;
 	enum commit_graph_split_flags flags = ctx->opts ?
 		ctx->opts->split_flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
 
@@ -1945,7 +1933,7 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 			_("Finding extra edges in commit graph"),
 			ctx->oids.nr);
 	oid_array_sort(&ctx->oids);
-	for (i = 0; i < ctx->oids.nr; i = oid_array_next_unique(&ctx->oids, i)) {
+	for (uint32_t i = 0; i < ctx->oids.nr; i = oid_array_next_unique(&ctx->oids, i)) {
 		unsigned int num_parents;
 
 		display_progress(ctx->progress, i + 1);
@@ -2276,7 +2264,6 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 static void merge_commit_graph(struct write_commit_graph_context *ctx,
 			       struct commit_graph *g)
 {
-	uint32_t i;
 	uint32_t offset = g->num_commits_in_base;
 
 	if (unsigned_add_overflows(ctx->commits.nr, g->num_commits))
@@ -2286,7 +2273,7 @@ static void merge_commit_graph(struct write_commit_graph_context *ctx,
 
 	ALLOC_GROW(ctx->commits.list, ctx->commits.nr + g->num_commits, ctx->commits.alloc);
 
-	for (i = 0; i < g->num_commits; i++) {
+	for (uint32_t i = 0; i < g->num_commits; i++) {
 		struct object_id oid;
 		struct commit *result;
 
@@ -2313,7 +2300,7 @@ static int commit_compare(const void *_a, const void *_b)
 
 static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 {
-	uint32_t i, dedup_i = 0;
+	uint32_t dedup_i = 0;
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
@@ -2323,7 +2310,7 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 	QSORT(ctx->commits.list, ctx->commits.nr, commit_compare);
 
 	ctx->num_extra_edges = 0;
-	for (i = 0; i < ctx->commits.nr; i++) {
+	for (uint32_t i = 0; i < ctx->commits.nr; i++) {
 		display_progress(ctx->progress, i + 1);
 
 		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
@@ -2382,10 +2369,9 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx)
 
 static void mark_commit_graphs(struct write_commit_graph_context *ctx)
 {
-	uint32_t i;
 	time_t now = time(NULL);
 
-	for (i = ctx->num_commit_graphs_after - 1; i < ctx->num_commit_graphs_before; i++) {
+	for (uint32_t i = ctx->num_commit_graphs_after - 1; i < ctx->num_commit_graphs_before; i++) {
 		struct stat st;
 		struct utimbuf updated_time;
 
diff --git a/commit-reach.c b/commit-reach.c
index ecc913fc99..a0a853abf8 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -39,8 +39,7 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 
 static int queue_has_nonstale(struct prio_queue *queue)
 {
-	int i;
-	for (i = 0; i < queue->nr; i++) {
+	for (int i = 0; i < queue->nr; i++) {
 		struct commit *commit = queue->array[i].data;
 		if (!(commit->object.flags & STALE))
 			return 1;
@@ -56,7 +55,6 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct commit_list *result = NULL;
-	int i;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 
 	if (!min_generation && !corrected_commit_dates_enabled(r))
@@ -69,7 +67,7 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 	}
 	prio_queue_put(&queue, one);
 
-	for (i = 0; i < n; i++) {
+	for (int i = 0; i < n; i++) {
 		twos[i]->object.flags |= PARENT2;
 		prio_queue_put(&queue, twos[i]);
 	}
@@ -151,14 +149,14 @@ static struct commit_list *merge_bases_many(struct repository *r,
 
 struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 {
-	struct commit_list *i, *j, *k, *ret = NULL;
+	struct commit_list *j, *k, *ret = NULL;
 
 	if (!in)
 		return ret;
 
 	commit_list_insert(in->item, &ret);
 
-	for (i = in->next; i; i = i->next) {
+	for (struct commit_list *i = in->next; i; i = i->next) {
 		struct commit_list *new_commits = NULL, *end = NULL;
 
 		for (j = ret; j; j = j->next) {
@@ -360,13 +358,7 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	 * that number.
 	 */
 	if (generation_numbers_enabled(r)) {
-		int i;
-
-		/*
-		 * If we have a single commit with finite generation
-		 * number, then the _with_gen algorithm is preferred.
-		 */
-		for (i = 0; i < cnt; i++) {
+		for (int i = 0; i < cnt; i++) {
 			if (commit_graph_generation(array[i]) < GENERATION_NUMBER_INFINITY)
 				return remove_redundant_with_gen(r, array, cnt);
 		}
@@ -477,12 +469,12 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 			     int nr_reference, struct commit **reference)
 {
 	struct commit_list *bases;
-	int ret = 0, i;
+	int ret = 0;
 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
 
 	if (repo_parse_commit(r, commit))
 		return ret;
-	for (i = 0; i < nr_reference; i++) {
+	for (int i = 0; i < nr_reference; i++) {
 		if (repo_parse_commit(r, reference[i]))
 			return ret;
 
@@ -664,9 +656,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 	struct contains_stack contains_stack = { 0, 0, NULL };
 	enum contains_result result;
 	timestamp_t cutoff = GENERATION_NUMBER_INFINITY;
-	const struct commit_list *p;
-
-	for (p = want; p; p = p->next) {
+	for (const struct commit_list *p = want; p; p = p->next) {
 		timestamp_t generation;
 		struct commit *c = p->item;
 		load_commit_graph_info(the_repository, c);
diff --git a/commit.c b/commit.c
index ef679a0b93..6fdab479b8 100644
--- a/commit.c
+++ b/commit.c
@@ -217,7 +217,7 @@ int register_commit_graft(struct repository *r, struct commit_graft *graft,
 struct commit_graft *read_graft_line(struct strbuf *line)
 {
 	/* The format is just "Commit Parent1 Parent2 ...\n" */
-	int i, phase;
+	int i;
 	const char *tail = NULL;
 	struct commit_graft *graft = NULL;
 	struct object_id dummy_oid, *oid;
@@ -229,7 +229,7 @@ struct commit_graft *read_graft_line(struct strbuf *line)
 	 * phase 0 verifies line, counts hashes in line and allocates graft
 	 * phase 1 fills graft
 	 */
-	for (phase = 0; phase < 2; phase++) {
+	for (int phase = 0; phase < 2; phase++) {
 		oid = graft ? &graft->oid : &dummy_oid;
 		if (parse_oid_hex(line->buf, oid, &tail))
 			goto bad_graft_data;
@@ -309,17 +309,15 @@ struct commit_graft *lookup_commit_graft(struct repository *r, const struct obje
 
 int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
 {
-	int i, ret;
-	for (i = ret = 0; i < the_repository->parsed_objects->grafts_nr && !ret; i++)
+	int ret;
+	for (int i = ret = 0; i < the_repository->parsed_objects->grafts_nr && !ret; i++)
 		ret = fn(the_repository->parsed_objects->grafts[i], cb_data);
 	return ret;
 }
 
 void reset_commit_grafts(struct repository *r)
 {
-	int i;
-
-	for (i = 0; i < r->parsed_objects->grafts_nr; i++) {
+	for (int i = 0; i < r->parsed_objects->grafts_nr; i++) {
 		unparse_commit(r, &r->parsed_objects->grafts[i]->oid);
 		free(r->parsed_objects->grafts[i]);
 	}
@@ -525,9 +523,8 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 		pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
 	if (graft) {
-		int i;
 		struct commit *new_parent;
-		for (i = 0; i < graft->nr_parent; i++) {
+		for (int i = 0; i < graft->nr_parent; i++) {
 			new_parent = lookup_commit(r,
 						   &graft->parent[i]);
 			if (!new_parent)
@@ -692,8 +689,8 @@ struct commit_list *copy_commit_list(struct commit_list *list)
 
 struct commit_list *reverse_commit_list(struct commit_list *list)
 {
-	struct commit_list *next = NULL, *current, *backup;
-	for (current = list; current; current = backup) {
+	struct commit_list *next = NULL, *backup;
+	for (struct commit_list *current = list; current; current = backup) {
 		backup = current->next;
 		current->next = next;
 		next = current;
@@ -1392,11 +1389,11 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 
 int for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data)
 {
-	struct commit_extra_header *extra, *to_free;
+	struct commit_extra_header *to_free;
 	int res = 0;
 
 	to_free = read_commit_extra_headers(commit, NULL);
-	for (extra = to_free; !res && extra; extra = extra->next) {
+	for (struct commit_extra_header *extra = to_free; !res && extra; extra = extra->next) {
 		if (strcmp(extra->key, "mergetag"))
 			continue; /* not a merge tag */
 		res = fn(commit, extra, data);
diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 2aa8c219ac..d3bf58908b 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -221,9 +221,7 @@ static interval_fn *table[] = {
 static int call_all(struct fsmonitor_daemon_state *state,
 		    enum interval_fn_ctx ctx)
 {
-	int k;
-
-	for (k = 0; table[k]; k++) {
+	for (int k = 0; table[k]; k++) {
 		int r = table[k](state, ctx);
 		if (r)
 			return r;
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 2fc67442eb..552c5d0ff7 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -208,13 +208,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef UNUSED,
 	const char *slash;
 	char *resolved = NULL;
 	struct strbuf tmp = STRBUF_INIT;
-	int k;
-
-	/*
-	 * Build a list of all filesystem changes into a private/local
-	 * list and without holding any locks.
-	 */
-	for (k = 0; k < num_of_events; k++) {
+	for (int k = 0; k < num_of_events; k++) {
 		/*
 		 * On Mac, we receive an array of absolute paths.
 		 */
diff --git a/compat/mingw.c b/compat/mingw.c
index 320fb99a90..ec8e204976 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -277,7 +277,6 @@ int mingw_core_config(const char *var, const char *value,
 /* Normalizes NT paths as returned by some low-level APIs. */
 static wchar_t *normalize_ntpath(wchar_t *wbuf)
 {
-	int i;
 	/* fix absolute path prefixes */
 	if (wbuf[0] == '\\') {
 		/* strip NT namespace prefixes */
@@ -293,7 +292,7 @@ static wchar_t *normalize_ntpath(wchar_t *wbuf)
 		}
 	}
 	/* convert backslashes to slashes */
-	for (i = 0; wbuf[i]; i++)
+	for (int i = 0; wbuf[i]; i++)
 		if (wbuf[i] == '\\')
 			wbuf[i] = '/';
 	return wbuf;
@@ -1740,11 +1739,10 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 		      GetVersion() >> 16 < 9200) &&
 		    !getenv("SUPPRESS_HANDLE_INHERITANCE_WARNING")) {
 			DWORD fl = 0;
-			int i;
 
 			setenv("SUPPRESS_HANDLE_INHERITANCE_WARNING", "1", 1);
 
-			for (i = 0; i < stdhandles_count; i++) {
+			for (int i = 0; i < stdhandles_count; i++) {
 				HANDLE h = stdhandles[i];
 				strbuf_addf(&buf, "handle #%d: %p (type %lx, "
 					    "handle info (%d) %lx\n", i, h,
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 9b3f2cdf8c..c3ab8fe528 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -48,9 +48,7 @@ enum ipc_active_state ipc_get_active_state(const char *path)
 	 */
 	{
 		static const int delay[] = { 1, 10, 20, 40, -1 };
-		int i;
-
-		for (i = 0; S_ISREG(st.st_mode) && delay[i] > 0; i++) {
+		for (int i = 0; S_ISREG(st.st_mode) && delay[i] > 0; i++) {
 			sleep_millisec(delay[i]);
 			if (lstat(path, &st) == -1)
 				return IPC_STATE__INVALID_PATH;
@@ -92,11 +90,9 @@ static enum ipc_active_state connect_to_server(
 	const struct ipc_client_connect_options *options,
 	int *pfd)
 {
-	int k;
-
 	*pfd = -1;
 
-	for (k = 0; k < timeout_ms; k += WAIT_STEP_MS) {
+	for (int k = 0; k < timeout_ms; k += WAIT_STEP_MS) {
 		int fd = unix_stream_connect(path, options->uds_disallow_chdir);
 
 		if (fd != -1) {
@@ -832,7 +828,6 @@ int ipc_server_run_async(struct ipc_server_data **returned_server_data,
 	struct unix_ss_socket *server_socket = NULL;
 	struct ipc_server_data *server_data;
 	int sv[2];
-	int k;
 	int ret;
 	int nr_threads = opts->nr_threads;
 
@@ -892,7 +887,7 @@ int ipc_server_run_async(struct ipc_server_data **returned_server_data,
 			   accept_thread_proc, server_data->accept_thread))
 		die_errno(_("could not start accept_thread '%s'"), path);
 
-	for (k = 0; k < nr_threads; k++) {
+	for (int k = 0; k < nr_threads; k++) {
 		struct ipc_worker_thread_data *wtd;
 
 		wtd = xcalloc(1, sizeof(*wtd));
diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 8bfe51248e..c3af6394a7 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -760,7 +760,6 @@ int ipc_server_run_async(struct ipc_server_data **returned_server_data,
 	struct ipc_server_data *server_data;
 	wchar_t wpath[MAX_PATH];
 	HANDLE hPipeFirst = INVALID_HANDLE_VALUE;
-	int k;
 	int ret = 0;
 	int nr_threads = opts->nr_threads;
 
@@ -790,7 +789,7 @@ int ipc_server_run_async(struct ipc_server_data **returned_server_data,
 	if (nr_threads < 1)
 		nr_threads = 1;
 
-	for (k = 0; k < nr_threads; k++) {
+	for (int k = 0; k < nr_threads; k++) {
 		struct ipc_server_thread_data *std;
 
 		std = xcalloc(1, sizeof(*std));
diff --git a/compat/strcasestr.c b/compat/strcasestr.c
index 26896deca6..128bb44281 100644
--- a/compat/strcasestr.c
+++ b/compat/strcasestr.c
@@ -4,11 +4,8 @@ char *gitstrcasestr(const char *haystack, const char *needle)
 {
 	int nlen = strlen(needle);
 	int hlen = strlen(haystack) - nlen + 1;
-	int i;
-
-	for (i = 0; i < hlen; i++) {
-		int j;
-		for (j = 0; j < nlen; j++) {
+	for (int i = 0; i < hlen; i++) {
+		for (int j = 0; j < nlen; j++) {
 			unsigned char c1 = haystack[i+j];
 			unsigned char c2 = needle[j];
 			if (toupper(c1) != toupper(c2))
diff --git a/compat/terminal.c b/compat/terminal.c
index 0afda730f2..548a2c64a0 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -259,14 +259,13 @@ static DWORD cmode_in, cmode_out;
 void restore_term(void)
 {
 	if (use_stty) {
-		int i;
 		struct child_process cp = CHILD_PROCESS_INIT;
 
 		if (stty_restore.nr == 0)
 			return;
 
 		strvec_push(&cp.args, "stty");
-		for (i = 0; i < stty_restore.nr; i++)
+		for (int i = 0; i < stty_restore.nr; i++)
 			strvec_push(&cp.args, stty_restore.items[i].string);
 		run_command(&cp);
 		string_list_clear(&stty_restore, 0);
@@ -497,7 +496,7 @@ static int is_known_escape_sequence(const char *sequence)
 	if (!initialized) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct strbuf buf = STRBUF_INIT;
-		char *p, *eol;
+		char *p;
 
 		hashmap_init(&sequences, sequence_entry_cmp, NULL, 0);
 
@@ -505,7 +504,7 @@ static int is_known_escape_sequence(const char *sequence)
 		if (pipe_command(&cp, NULL, 0, &buf, 0, NULL, 0))
 			strbuf_setlen(&buf, 0);
 
-		for (eol = p = buf.buf; *p; p = eol + 1) {
+		for (char *eol = p = buf.buf; *p; p = eol + 1) {
 			p = strchr(p, '=');
 			if (!p)
 				break;
diff --git a/compat/unsetenv.c b/compat/unsetenv.c
index b9d34af613..dbd9f1703d 100644
--- a/compat/unsetenv.c
+++ b/compat/unsetenv.c
@@ -5,12 +5,12 @@ int gitunsetenv(const char *name)
 #if !defined(__MINGW32__)
      extern char **environ;
 #endif
-     int src, dst;
+     int dst;
      size_t nmln;
 
      nmln = strlen(name);
 
-     for (src = dst = 0; environ[src]; ++src) {
+     for (int src = dst = 0; environ[src]; ++src) {
 	  size_t enln;
 	  enln = strlen(environ[src]);
 	  if (enln > nmln) {
diff --git a/config.c b/config.c
index 3cfeb3d8bd..5b01b16aca 100644
--- a/config.c
+++ b/config.c
@@ -540,7 +540,7 @@ static inline int iskeychar(int c)
  */
 int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 {
-	size_t i, baselen;
+	size_t baselen;
 	int dot;
 	const char *last_dot = strrchr(key, '.');
 
@@ -569,7 +569,7 @@ int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 	*store_key = xmallocz(strlen(key));
 
 	dot = 0;
-	for (i = 0; key[i]; i++) {
+	for (size_t i = 0; key[i]; i++) {
 		unsigned char c = key[i];
 		if (c == '.')
 			dot = 1;
@@ -724,7 +724,6 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	if (env) {
 		unsigned long count;
 		char *endp;
-		int i;
 
 		count = strtoul(env, &endp, 10);
 		if (*endp) {
@@ -736,7 +735,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 			goto out;
 		}
 
-		for (i = 0; i < count; i++) {
+		for (int i = 0; i < count; i++) {
 			const char *key, *value;
 
 			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
@@ -2138,13 +2137,13 @@ int config_with_options(config_fn_t fn, void *data,
 
 static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
 {
-	int i, value_index;
+	int value_index;
 	struct string_list *values;
 	struct config_set_element *entry;
 	struct configset_list *list = &set->list;
 	struct config_context ctx = CONFIG_CONTEXT_INIT;
 
-	for (i = 0; i < list->nr; i++) {
+	for (int i = 0; i < list->nr; i++) {
 		entry = list->items[i].e;
 		value_index = list->items[i].value_index;
 		values = &entry->value_list;
@@ -3815,9 +3814,7 @@ const char *config_scope_name(enum config_scope scope)
 
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
-	int i;
-
-	for (i = 0; i < nr_mapping; i++) {
+	for (int i = 0; i < nr_mapping; i++) {
 		const char *name = mapping[i];
 
 		if (name && !strcasecmp(var, name))
diff --git a/connect.c b/connect.c
index 0d77737a53..a65dfa4298 100644
--- a/connect.c
+++ b/connect.c
@@ -74,9 +74,7 @@ static NORETURN void die_initial_contact(int unexpected)
 /* Checks if the server supports the capability 'c' */
 int server_supports_v2(const char *c)
 {
-	int i;
-
-	for (i = 0; i < server_capabilities_v2.nr; i++) {
+	for (int i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
 		if (skip_prefix(server_capabilities_v2.v[i], c, &out) &&
 		    (!*out || *out == '='))
@@ -93,9 +91,7 @@ void ensure_server_supports_v2(const char *c)
 
 int server_feature_v2(const char *c, const char **v)
 {
-	int i;
-
-	for (i = 0; i < server_capabilities_v2.nr; i++) {
+	for (int i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
 		if (skip_prefix(server_capabilities_v2.v[i], c, &out) &&
 		    (*out == '=')) {
@@ -109,9 +105,7 @@ int server_feature_v2(const char *c, const char **v)
 int server_supports_feature(const char *c, const char *feature,
 			    int die_on_error)
 {
-	int i;
-
-	for (i = 0; i < server_capabilities_v2.nr; i++) {
+	for (int i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
 		if (skip_prefix(server_capabilities_v2.v[i], c, &out) &&
 		    (!*out || *(out++) == '=')) {
@@ -1447,7 +1441,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->trace2_child_class = "transport/git";
 	} else {
 		struct strbuf cmd = STRBUF_INIT;
-		const char *const *var;
 
 		conn = xmalloc(sizeof(*conn));
 		child_process_init(conn);
@@ -1460,7 +1453,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		sq_quote_buf(&cmd, path);
 
 		/* remove repo-local variables from the environment */
-		for (var = local_repo_env; *var; var++)
+		for (const char * const *var = local_repo_env; *var; var++)
 			strvec_push(&conn->env, *var);
 
 		conn->use_shell = 1;
diff --git a/connected.c b/connected.c
index 8f89376dbc..e0f3ec0ac7 100644
--- a/connected.c
+++ b/connected.c
@@ -71,9 +71,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		 */
 		reprepare_packed_git(the_repository);
 		do {
-			struct packed_git *p;
-
-			for (p = get_all_packs(the_repository); p; p = p->next) {
+			for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
 				if (!p->pack_promisor)
 					continue;
 				if (find_pack_entry_one(oid->hash, p))
diff --git a/convert.c b/convert.c
index 35b25eb3cb..9c3421041e 100644
--- a/convert.c
+++ b/convert.c
@@ -41,11 +41,9 @@ struct text_stat {
 
 static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
 {
-	unsigned long i;
-
 	memset(stats, 0, sizeof(*stats));
 
-	for (i = 0; i < size; i++) {
+	for (unsigned long i = 0; i < size; i++) {
 		unsigned char c = buf[i];
 		if (c == '\r') {
 			if (i+1 < size && buf[i+1] == '\n') {
@@ -320,10 +318,9 @@ static void trace_encoding(const char *context, const char *path,
 {
 	static struct trace_key coe = TRACE_KEY_INIT(WORKING_TREE_ENCODING);
 	struct strbuf trace = STRBUF_INIT;
-	int i;
 
 	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
-	for (i = 0; i < len && buf; ++i) {
+	for (int i = 0; i < len && buf; ++i) {
 		strbuf_addf(
 			&trace, "| \033[2m%2i:\033[0m %2x \033[2m%c\033[0m%c",
 			i,
@@ -1283,11 +1280,10 @@ static enum eol git_path_check_eol(struct attr_check_item *check)
 static struct convert_driver *git_path_check_convert(struct attr_check_item *check)
 {
 	const char *value = check->value;
-	struct convert_driver *drv;
 
 	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value))
 		return NULL;
-	for (drv = user_convert; drv; drv = drv->next)
+	for (struct convert_driver *drv = user_convert; drv; drv = drv->next)
 		if (!strcmp(value, drv->name))
 			return drv;
 	return NULL;
@@ -1349,13 +1345,13 @@ void convert_attrs(struct index_state *istate,
 
 void reset_parsed_attributes(void)
 {
-	struct convert_driver *drv, *next;
+	struct convert_driver *next;
 
 	attr_check_free(check);
 	check = NULL;
 	reset_merge_attributes();
 
-	for (drv = user_convert; drv; drv = next) {
+	for (struct convert_driver *drv = user_convert; drv; drv = next) {
 		next = drv->next;
 		free((void *)drv->name);
 		free(drv);
@@ -1822,11 +1818,9 @@ struct ident_filter {
 
 static int is_foreign_ident(const char *str)
 {
-	int i;
-
 	if (!skip_prefix(str, "$Id: ", &str))
 		return 0;
-	for (i = 0; str[i]; i++) {
+	for (int i = 0; str[i]; i++) {
 		if (isspace(str[i]) && str[i+1] != '$')
 			return 1;
 	}
diff --git a/credential.c b/credential.c
index 18098bd35e..8653873926 100644
--- a/credential.c
+++ b/credential.c
@@ -359,14 +359,12 @@ static int credential_do(struct credential *c, const char *helper,
 
 void credential_fill(struct credential *c)
 {
-	int i;
-
 	if (c->username && c->password)
 		return;
 
 	credential_apply_config(c);
 
-	for (i = 0; i < c->helpers.nr; i++) {
+	for (int i = 0; i < c->helpers.nr; i++) {
 		credential_do(c, c->helpers.items[i].string, "get");
 		if (c->password_expiry_utc < time(NULL)) {
 			/* Discard expired password */
@@ -388,8 +386,6 @@ void credential_fill(struct credential *c)
 
 void credential_approve(struct credential *c)
 {
-	int i;
-
 	if (c->approved)
 		return;
 	if (!c->username || !c->password || c->password_expiry_utc < time(NULL))
@@ -397,18 +393,16 @@ void credential_approve(struct credential *c)
 
 	credential_apply_config(c);
 
-	for (i = 0; i < c->helpers.nr; i++)
+	for (int i = 0; i < c->helpers.nr; i++)
 		credential_do(c, c->helpers.items[i].string, "store");
 	c->approved = 1;
 }
 
 void credential_reject(struct credential *c)
 {
-	int i;
-
 	credential_apply_config(c);
 
-	for (i = 0; i < c->helpers.nr; i++)
+	for (int i = 0; i < c->helpers.nr; i++)
 		credential_do(c, c->helpers.items[i].string, "erase");
 
 	FREE_AND_NULL(c->username);
diff --git a/daemon.c b/daemon.c
index 17d331b2f3..5cda62b3e0 100644
--- a/daemon.c
+++ b/daemon.c
@@ -255,7 +255,6 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 	}
 
 	if ( ok_paths && *ok_paths ) {
-		const char **pp;
 		int pathlen = strlen(path);
 
 		/* The validation is done on the paths after enter_repo
@@ -265,7 +264,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 		 * do not have to say /mnt/pub.
 		 * Do not say /pub/.
 		 */
-		for ( pp = ok_paths ; *pp ; pp++ ) {
+		for (const char **pp = ok_paths; *pp; pp++) {
 			int len = strlen(*pp);
 			if (len <= pathlen &&
 			    !memcmp(*pp, path, len) &&
@@ -499,8 +498,7 @@ static struct daemon_service daemon_service[] = {
 
 static void enable_service(const char *name, int ena)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
+	for (int i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		if (!strcmp(daemon_service[i].name, name)) {
 			daemon_service[i].enabled = ena;
 			return;
@@ -511,8 +509,7 @@ static void enable_service(const char *name, int ena)
 
 static void make_service_overridable(const char *name, int ena)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
+	for (int i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		if (!strcmp(daemon_service[i].name, name)) {
 			daemon_service[i].overridable = ena;
 			return;
@@ -733,7 +730,7 @@ static void set_keep_alive(int sockfd)
 static int execute(void)
 {
 	char *line = packet_buffer;
-	int pktlen, len, i;
+	int pktlen, len;
 	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
 	struct hostinfo hi = HOSTINFO_INIT;
 	struct strvec env = STRVEC_INIT;
@@ -754,7 +751,7 @@ static int execute(void)
 	if (len != pktlen)
 		parse_extra_args(&hi, &env, line + len + 1, pktlen - len - 1);
 
-	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
+	for (int i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
 		const char *arg;
 
@@ -965,7 +962,7 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 {
 	int socknum = 0;
 	char pbuf[NI_MAXSERV];
-	struct addrinfo hints, *ai0, *ai;
+	struct addrinfo hints, *ai0;
 	int gai;
 	long flags;
 
@@ -982,7 +979,7 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 		return 0;
 	}
 
-	for (ai = ai0; ai; ai = ai->ai_next) {
+	for (struct addrinfo *ai = ai0; ai; ai = ai->ai_next) {
 		int sockfd;
 
 		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
@@ -1104,8 +1101,8 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 	if (!listen_addr->nr)
 		setup_named_sock(NULL, listen_port, socklist);
 	else {
-		int i, socknum;
-		for (i = 0; i < listen_addr->nr; i++) {
+		int socknum;
+		for (int i = 0; i < listen_addr->nr; i++) {
 			socknum = setup_named_sock(listen_addr->items[i].string,
 						   listen_port, socklist);
 
diff --git a/date.c b/date.c
index 619ada5b20..995aeb2a1f 100644
--- a/date.c
+++ b/date.c
@@ -1211,7 +1211,6 @@ static const struct typelen {
 static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm *now, int *num, int *touched)
 {
 	const struct typelen *tl;
-	const struct special *s;
 	const char *end = date;
 	int i;
 
@@ -1227,7 +1226,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 		}
 	}
 
-	for (s = special; s->name; s++) {
+	for (const struct special *s = special; s->name; s++) {
 		int len = strlen(s->name);
 		if (match_string(date, s->name) == len) {
 			s->fn(tm, now, num);
diff --git a/decorate.c b/decorate.c
index 69aeb142b4..bf25f27169 100644
--- a/decorate.c
+++ b/decorate.c
@@ -34,7 +34,6 @@ static void *insert_decoration(struct decoration *n, const struct object *base,
 
 static void grow_decoration(struct decoration *n)
 {
-	int i;
 	int old_size = n->size;
 	struct decoration_entry *old_entries = n->entries;
 
@@ -42,7 +41,7 @@ static void grow_decoration(struct decoration *n)
 	CALLOC_ARRAY(n->entries, n->size);
 	n->nr = 0;
 
-	for (i = 0; i < old_size; i++) {
+	for (int i = 0; i < old_size; i++) {
 		const struct object *base = old_entries[i].base;
 		void *decoration = old_entries[i].decoration;
 
@@ -85,8 +84,7 @@ void *lookup_decoration(struct decoration *n, const struct object *obj)
 void clear_decoration(struct decoration *n, void (*free_cb)(void *))
 {
 	if (free_cb) {
-		unsigned int i;
-		for (i = 0; i < n->size; i++) {
+		for (unsigned int i = 0; i < n->size; i++) {
 			void *d = n->entries[i].decoration;
 			if (d)
 				free_cb(d);
diff --git a/delta-islands.c b/delta-islands.c
index ee2318d45a..de80a8786d 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -53,21 +53,17 @@ static struct island_bitmap *island_bitmap_new(const struct island_bitmap *old)
 
 static void island_bitmap_or(struct island_bitmap *a, const struct island_bitmap *b)
 {
-	uint32_t i;
-
-	for (i = 0; i < island_bitmap_size; ++i)
+	for (uint32_t i = 0; i < island_bitmap_size; ++i)
 		a->bits[i] |= b->bits[i];
 }
 
 static int island_bitmap_is_subset(struct island_bitmap *self,
 		struct island_bitmap *super)
 {
-	uint32_t i;
-
 	if (self == super)
 		return 1;
 
-	for (i = 0; i < island_bitmap_size; ++i) {
+	for (uint32_t i = 0; i < island_bitmap_size; ++i) {
 		if ((self->bits[i] & super->bits[i]) != self->bits[i])
 			return 0;
 	}
@@ -189,9 +185,7 @@ static void mark_remote_island_1(struct repository *r,
 				 struct remote_island *rl,
 				 int is_core_island)
 {
-	uint32_t i;
-
-	for (i = 0; i < rl->oids.nr; ++i) {
+	for (uint32_t i = 0; i < rl->oids.nr; ++i) {
 		struct island_bitmap *marks;
 		struct object *obj = parse_object(r, &rl->oids.oid[i]);
 
@@ -399,7 +393,7 @@ static int find_island_for_ref(const char *refname, const struct object_id *oid,
 	 * than we support.
 	 */
 	regmatch_t matches[16];
-	int i, m;
+	int i;
 	struct strbuf island_name = STRBUF_INIT;
 
 	/* walk backwards to get last-one-wins ordering */
@@ -417,7 +411,7 @@ static int find_island_for_ref(const char *refname, const struct object_id *oid,
 			  "too many capture groups (max=%d)"),
 			(int)ARRAY_SIZE(matches) - 2);
 
-	for (m = 1; m < ARRAY_SIZE(matches); m++) {
+	for (int m = 1; m < ARRAY_SIZE(matches); m++) {
 		regmatch_t *match = &matches[m];
 
 		if (match->rm_so == -1)
@@ -448,7 +442,7 @@ static struct remote_island *get_core_island(kh_str_t *remote_islands)
 static void deduplicate_islands(kh_str_t *remote_islands, struct repository *r)
 {
 	struct remote_island *island, *core = NULL, **list;
-	unsigned int island_count, dst, src, ref, i = 0;
+	unsigned int island_count, dst, src, i = 0;
 
 	island_count = kh_size(remote_islands);
 	ALLOC_ARRAY(list, island_count);
@@ -457,7 +451,7 @@ static void deduplicate_islands(kh_str_t *remote_islands, struct repository *r)
 		list[i++] = island;
 	});
 
-	for (ref = 0; ref + 1 < island_count; ref++) {
+	for (unsigned int ref = 0; ref + 1 < island_count; ref++) {
 		for (src = ref + 1, dst = src; src < island_count; src++) {
 			if (list[ref]->hash == list[src]->hash)
 				continue;
@@ -502,13 +496,12 @@ void propagate_island_marks(struct commit *commit)
 	khiter_t pos = kh_get_oid_map(island_marks, commit->object.oid);
 
 	if (pos < kh_end(island_marks)) {
-		struct commit_list *p;
 		struct island_bitmap *root_marks = kh_value(island_marks, pos);
 
 		repo_parse_commit(the_repository, commit);
 		set_island_marks(&repo_get_commit_tree(the_repository, commit)->object,
 				 root_marks);
-		for (p = commit->parents; p; p = p->next)
+		for (struct commit_list *p = commit->parents; p; p = p->next)
 			set_island_marks(&p->item->object, root_marks);
 	}
 }
@@ -531,12 +524,10 @@ void free_island_marks(void)
 
 int compute_pack_layers(struct packing_data *to_pack)
 {
-	uint32_t i;
-
 	if (!core_island_name || !island_marks)
 		return 1;
 
-	for (i = 0; i < to_pack->nr_objects; ++i) {
+	for (uint32_t i = 0; i < to_pack->nr_objects; ++i) {
 		struct object_entry *entry = &to_pack->objects[i];
 		khiter_t pos = kh_get_oid_map(island_marks, entry->idx.oid);
 
diff --git a/diagnose.c b/diagnose.c
index 4d096c857f..9c3159f26d 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -29,7 +29,6 @@ static struct diagnose_option diagnose_options[] = {
 
 int option_parse_diagnose(const struct option *opt, const char *arg, int unset)
 {
-	int i;
 	enum diagnose_mode *diagnose = opt->value;
 
 	if (!arg) {
@@ -37,7 +36,7 @@ int option_parse_diagnose(const struct option *opt, const char *arg, int unset)
 		return 0;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(diagnose_options); i++) {
+	for (int i = 0; i < ARRAY_SIZE(diagnose_options); i++) {
 		if (!strcmp(arg, diagnose_options[i].option_name)) {
 			*diagnose = diagnose_options[i].mode;
 			return 0;
diff --git a/diff-delta.c b/diff-delta.c
index 77fea08dfb..f14aedad5c 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -133,7 +133,7 @@ struct delta_index {
 struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 {
 	unsigned int i, hsize, hmask, entries, prev_val, *hash_count;
-	const unsigned char *data, *buffer = buf;
+	const unsigned char *buffer = buf;
 	struct delta_index *index;
 	struct unpacked_index_entry *entry, **hash;
 	struct index_entry *packed_entry, **packed_hash;
@@ -180,9 +180,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 
 	/* then populate the index */
 	prev_val = ~0;
-	for (data = buffer + entries * RABIN_WINDOW - RABIN_WINDOW;
-	     data >= buffer;
-	     data -= RABIN_WINDOW) {
+	for (const unsigned char *data = buffer + entries * RABIN_WINDOW - RABIN_WINDOW; data >= buffer; data -= RABIN_WINDOW) {
 		unsigned int val = 0;
 		for (i = 1; i <= RABIN_WINDOW; i++)
 			val = ((val << 8) | data[i]) ^ T[val >> RABIN_SHIFT];
diff --git a/diff-lib.c b/diff-lib.c
index 6c8df04273..bbbc8b131a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -103,7 +103,7 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 
 void run_diff_files(struct rev_info *revs, unsigned int option)
 {
-	int entries, i;
+	int entries;
 	int diff_unmerged_stage = revs->max_count;
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
@@ -117,7 +117,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
 	entries = istate->cache_nr;
-	for (i = 0; i < entries; i++) {
+	for (int i = 0; i < entries; i++) {
 		unsigned int oldmode, newmode;
 		struct cache_entry *ce = istate->cache[i];
 		int changed;
diff --git a/diff.c b/diff.c
index e50def4538..e65533bc97 100644
--- a/diff.c
+++ b/diff.c
@@ -136,11 +136,10 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 	char *params_copy = xstrdup(params_string);
 	struct string_list params = STRING_LIST_INIT_NODUP;
 	int ret = 0;
-	int i;
 
 	if (*params_copy)
 		string_list_split_in_place(&params, params_copy, ",", -1);
-	for (i = 0; i < params.nr; i++) {
+	for (int i = 0; i < params.nr; i++) {
 		const char *p = params.items[i].string;
 		if (!strcmp(p, "changes")) {
 			options->flags.dirstat_by_line = 0;
@@ -992,12 +991,11 @@ static struct moved_entry_list *add_lines_to_move_detection(struct diff_options
 	struct moved_entry_list *entry_list = NULL;
 	size_t entry_list_alloc = 0;
 	unsigned id = 0;
-	int n;
 
 	hashmap_init(&interned_map, interned_diff_symbol_cmp, o, 8096);
 	mem_pool_init(&interned_pool, 1024 * 1024);
 
-	for (n = 0; n < o->emitted_symbols->nr; n++) {
+	for (int n = 0; n < o->emitted_symbols->nr; n++) {
 		struct interned_diff_symbol key;
 		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
 		struct interned_diff_symbol *s;
@@ -1232,8 +1230,7 @@ static void mark_color_as_moved(struct diff_options *o,
 
 static void dim_moved_lines(struct diff_options *o)
 {
-	int n;
-	for (n = 0; n < o->emitted_symbols->nr; n++) {
+	for (int n = 0; n < o->emitted_symbols->nr; n++) {
 		struct emitted_diff_symbol *prev = (n != 0) ?
 				&o->emitted_symbols->buf[n - 1] : NULL;
 		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
@@ -1714,8 +1711,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 
 static struct diff_tempfile *claim_diff_tempfile(void)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(diff_temp); i++)
+	for (int i = 0; i < ARRAY_SIZE(diff_temp); i++)
 		if (!diff_temp[i].name)
 			return diff_temp + i;
 	BUG("diff is failing to clean up its tempfiles");
@@ -1723,8 +1719,7 @@ static struct diff_tempfile *claim_diff_tempfile(void)
 
 static void remove_tempfile(void)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(diff_temp); i++) {
+	for (int i = 0; i < ARRAY_SIZE(diff_temp); i++) {
 		if (is_tempfile_active(diff_temp[i].tempfile))
 			delete_tempfile(&diff_temp[i].tempfile);
 		diff_temp[i].name = NULL;
@@ -2083,7 +2078,7 @@ static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
 static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
 		regex_t *word_regex)
 {
-	int i, j;
+	int j;
 	long alloc = 0;
 
 	out->size = 0;
@@ -2094,7 +2089,7 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
 	buffer->orig[0].begin = buffer->orig[0].end = buffer->text.ptr;
 	buffer->orig_nr = 1;
 
-	for (i = 0; i < buffer->text.size; i++) {
+	for (int i = 0; i < buffer->text.size; i++) {
 		if (find_word_boundaries(&buffer->text, word_regex, &i, &j))
 			return;
 
@@ -2224,7 +2219,6 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 				 struct diff_filespec *one,
 				 struct diff_filespec *two)
 {
-	int i;
 	struct diff_options *o = xmalloc(sizeof(struct diff_options));
 	memcpy(o, orig_opts, sizeof(struct diff_options));
 
@@ -2250,7 +2244,7 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 			die("invalid regular expression: %s",
 			    o->word_regex);
 	}
-	for (i = 0; i < ARRAY_SIZE(diff_words_styles); i++) {
+	for (int i = 0; i < ARRAY_SIZE(diff_words_styles); i++) {
 		if (o->word_diff == diff_words_styles[i].type) {
 			ecbdata->diff_words->style =
 				&diff_words_styles[i];
@@ -2906,12 +2900,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 
 static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
 {
-	int i, adds = 0, dels = 0, total_files = data->nr;
+	int adds = 0, dels = 0, total_files = data->nr;
 
 	if (data->nr == 0)
 		return;
 
-	for (i = 0; i < data->nr; i++) {
+	for (int i = 0; i < data->nr; i++) {
 		int added = data->files[i]->added;
 		int deleted = data->files[i]->deleted;
 
@@ -2928,12 +2922,10 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 
 static void show_numstat(struct diffstat_t *data, struct diff_options *options)
 {
-	int i;
-
 	if (data->nr == 0)
 		return;
 
-	for (i = 0; i < data->nr; i++) {
+	for (int i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 
 		fprintf(options->file, "%s", diff_line_prefix(options));
@@ -3051,7 +3043,6 @@ static void conclude_dirstat(struct diff_options *options,
 
 static void show_dirstat(struct diff_options *options)
 {
-	int i;
 	unsigned long changed;
 	struct dirstat_dir dir;
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -3063,7 +3054,7 @@ static void show_dirstat(struct diff_options *options)
 	dir.cumulative = options->flags.dirstat_cumulative;
 
 	changed = 0;
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		const char *name;
 		unsigned long copied, added, damage;
@@ -3143,7 +3134,6 @@ static void show_dirstat(struct diff_options *options)
 
 static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *options)
 {
-	int i;
 	unsigned long changed;
 	struct dirstat_dir dir;
 
@@ -3157,7 +3147,7 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 	dir.cumulative = options->flags.dirstat_cumulative;
 
 	changed = 0;
-	for (i = 0; i < data->nr; i++) {
+	for (int i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 		unsigned long damage = file->added + file->deleted;
 		if (file->is_binary)
@@ -3189,8 +3179,7 @@ static void free_diffstat_file(struct diffstat_file *f)
 
 void free_diffstat_info(struct diffstat_t *diffstat)
 {
-	int i;
-	for (i = 0; i < diffstat->nr; i++)
+	for (int i = 0; i < diffstat->nr; i++)
 		free_diffstat_file(diffstat->files[i]);
 	free(diffstat->files);
 }
@@ -3453,9 +3442,9 @@ static void add_formatted_header(struct strbuf *msg,
 				  const char *meta,
 				  const char *reset)
 {
-	const char *next, *newline;
+	const char *newline;
 
-	for (next = header; *next; next = newline) {
+	for (const char *next = header; *next; next = newline) {
 		newline = strchrnul(next, '\n');
 		strbuf_addf(msg, "%s%s%.*s%s\n", line_prefix, meta,
 			    (int)(newline - next), next, reset);
@@ -3470,9 +3459,7 @@ static void add_formatted_headers(struct strbuf *msg,
 				  const char *meta,
 				  const char *reset)
 {
-	int i;
-
-	for (i = 0; i < more_headers->nr; i++)
+	for (int i = 0; i < more_headers->nr; i++)
 		add_formatted_header(msg, more_headers->items[i].string,
 				     line_prefix, meta, reset);
 }
@@ -5022,12 +5009,12 @@ static int diff_opt_diff_filter(const struct option *option,
 				const char *optarg, int unset)
 {
 	struct diff_options *opt = option->value;
-	int i, optch;
+	int optch;
 
 	BUG_ON_OPT_NEG(unset);
 	prepare_filter_bits();
 
-	for (i = 0; (optch = optarg[i]) != '\0'; i++) {
+	for (int i = 0; (optch = optarg[i]) != '\0'; i++) {
 		unsigned int bit;
 		int negate;
 
@@ -5387,7 +5374,6 @@ static int diff_opt_patience(const struct option *opt,
 			     const char *arg, int unset)
 {
 	struct diff_options *options = opt->value;
-	int i;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
@@ -5396,7 +5382,7 @@ static int diff_opt_patience(const struct option *opt,
 	 * internally, so remove any anchors previously
 	 * specified.
 	 */
-	for (i = 0; i < options->anchors_nr; i++)
+	for (int i = 0; i < options->anchors_nr; i++)
 		free(options->anchors[i]);
 	options->anchors_nr = 0;
 	options->ignore_driver_algorithm = 1;
@@ -6096,7 +6082,6 @@ static void diff_flush_checkdiff(struct diff_filepair *p,
 int diff_queue_is_empty(struct diff_options *o)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	int i;
 	int include_conflict_headers =
 	    (o->additional_path_headers &&
 	     strmap_get_size(o->additional_path_headers) &&
@@ -6106,7 +6091,7 @@ int diff_queue_is_empty(struct diff_options *o)
 	if (include_conflict_headers)
 		return 0;
 
-	for (i = 0; i < q->nr; i++)
+	for (int i = 0; i < q->nr; i++)
 		if (!diff_unmodified_pair(q->queue[i]))
 			return 0;
 	return 1;
@@ -6137,11 +6122,10 @@ void diff_debug_filepair(const struct diff_filepair *p, int i)
 
 void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
 {
-	int i;
 	if (msg)
 		fprintf(stderr, "%s\n", msg);
 	fprintf(stderr, "q->nr = %d\n", q->nr);
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		diff_debug_filepair(p, i);
 	}
@@ -6150,13 +6134,12 @@ void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
 
 static void diff_resolve_rename_copy(void)
 {
-	int i;
 	struct diff_filepair *p;
 	struct diff_queue_struct *q = &diff_queued_diff;
 
 	diff_debug_queue("resolve-rename-copy", q);
 
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		p = q->queue[i];
 		p->status = 0; /* undecided */
 		if (DIFF_PAIR_UNMERGED(p))
@@ -6326,11 +6309,10 @@ struct patch_id_t {
 
 static int remove_space(char *line, int len)
 {
-	int i;
 	char *dst = line;
 	unsigned char c;
 
-	for (i = 0; i < len; i++)
+	for (int i = 0; i < len; i++)
 		if (!isspace((c = line[i])))
 			*dst++ = c;
 
@@ -6341,12 +6323,11 @@ void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx)
 {
 	unsigned char hash[GIT_MAX_RAWSZ];
 	unsigned short carry = 0;
-	int i;
 
 	the_hash_algo->final_fn(hash, ctx);
 	the_hash_algo->init_fn(ctx);
 	/* 20-byte sum, with carry */
-	for (i = 0; i < the_hash_algo->rawsz; ++i) {
+	for (int i = 0; i < the_hash_algo->rawsz; ++i) {
 		carry += result->hash[i] + hash[i];
 		result->hash[i] = carry;
 		carry >>= 8;
@@ -6384,7 +6365,6 @@ static void patch_id_add_mode(git_hash_ctx *ctx, unsigned mode)
 static int diff_get_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	int i;
 	git_hash_ctx ctx;
 	struct patch_id_t data;
 
@@ -6393,7 +6373,7 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 	data.ctx = &ctx;
 	oidclr(oid);
 
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
 		mmfile_t mf1, mf2;
@@ -6492,9 +6472,7 @@ int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int
 
 static int is_summary_empty(const struct diff_queue_struct *q)
 {
-	int i;
-
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		const struct diff_filepair *p = q->queue[i];
 
 		switch (p->status) {
@@ -6544,7 +6522,6 @@ static void create_filepairs_for_header_only_notifications(struct diff_options *
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
-	int i;
 
 	strset_init_with_options(&present, /*pool*/ NULL, /*strdup*/ 0);
 
@@ -6552,7 +6529,7 @@ static void create_filepairs_for_header_only_notifications(struct diff_options *
 	 * Find out which paths exist in diff_queued_diff, preferring
 	 * one->path for any pair that has multiple paths.
 	 */
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		char *path = p->one->path ? p->one->path : p->two->path;
 
@@ -6642,9 +6619,7 @@ static void diff_free_file(struct diff_options *options)
 
 static void diff_free_ignore_regex(struct diff_options *options)
 {
-	int i;
-
-	for (i = 0; i < options->ignore_regex_nr; i++) {
+	for (int i = 0; i < options->ignore_regex_nr; i++) {
 		regfree(options->ignore_regex[i]);
 		free(options->ignore_regex[i]);
 	}
@@ -6878,12 +6853,11 @@ static int diff_filespec_check_stat_unmatch(struct repository *r,
 
 static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 {
-	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
 	DIFF_QUEUE_CLEAR(&outq);
 
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 
 		if (diff_filespec_check_stat_unmatch(diffopt->repo, p))
@@ -6934,11 +6908,10 @@ void diff_add_if_missing(struct repository *r,
 void diff_queued_diff_prefetch(void *repository)
 {
 	struct repository *repo = repository;
-	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		diff_add_if_missing(repo, &to_fetch, p->one);
 		diff_add_if_missing(repo, &to_fetch, p->two);
@@ -7058,10 +7031,8 @@ void compute_diffstat(struct diff_options *options,
 		      struct diffstat_t *diffstat,
 		      struct diff_queue_struct *q)
 {
-	int i;
-
 	memset(diffstat, 0, sizeof(struct diffstat_t));
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
 			diff_flush_stat(p, options, diffstat);
diff --git a/diff.h b/diff.h
index 66bd8aeb29..f842799298 100644
--- a/diff.h
+++ b/diff.h
@@ -205,9 +205,7 @@ static inline void diff_flags_or(struct diff_flags *a,
 {
 	char *tmp_a = (char *)a;
 	const char *tmp_b = (const char *)b;
-	int i;
-
-	for (i = 0; i < sizeof(struct diff_flags); i++)
+	for (int i = 0; i < sizeof(struct diff_flags); i++)
 		tmp_a[i] |= tmp_b[i];
 }
 
diff --git a/diffcore-break.c b/diffcore-break.c
index 49ba38aa7c..98e4089271 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -162,7 +162,6 @@ void diffcore_break(struct repository *r, int break_score)
 	 * together).
 	 */
 	int merge_score;
-	int i;
 
 	/* See comment on DEFAULT_BREAK_SCORE and
 	 * DEFAULT_MERGE_SCORE in diffcore.h
@@ -177,7 +176,7 @@ void diffcore_break(struct repository *r, int break_score)
 
 	DIFF_QUEUE_CLEAR(&outq);
 
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		int score;
 
@@ -273,11 +272,11 @@ void diffcore_merge_broken(void)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
-	int i, j;
+	int j;
 
 	DIFF_QUEUE_CLEAR(&outq);
 
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (!p)
 			/* we already merged this with its peer */
diff --git a/diffcore-delta.c b/diffcore-delta.c
index ba6cbee76b..59d2b858ba 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -48,7 +48,6 @@ struct spanhash_top {
 static struct spanhash_top *spanhash_rehash(struct spanhash_top *orig)
 {
 	struct spanhash_top *new_spanhash;
-	int i;
 	int osz = 1 << orig->alloc_log2;
 	int sz = osz << 1;
 
@@ -57,7 +56,7 @@ static struct spanhash_top *spanhash_rehash(struct spanhash_top *orig)
 	new_spanhash->alloc_log2 = orig->alloc_log2 + 1;
 	new_spanhash->free = INITIAL_FREE(new_spanhash->alloc_log2);
 	memset(new_spanhash->data, 0, sizeof(struct spanhash) * sz);
-	for (i = 0; i < osz; i++) {
+	for (int i = 0; i < osz; i++) {
 		struct spanhash *o = &(orig->data[i]);
 		int bucket;
 		if (!o->cnt)
diff --git a/diffcore-order.c b/diffcore-order.c
index e7d20ebd2d..4066f8063f 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -12,7 +12,7 @@ static int order_cnt;
 
 static void prepare_order(const char *orderfile)
 {
-	int cnt, pass;
+	int cnt;
 	struct strbuf sb = STRBUF_INIT;
 	void *map;
 	char *cp, *endp;
@@ -27,7 +27,7 @@ static void prepare_order(const char *orderfile)
 	map = strbuf_detach(&sb, NULL);
 	endp = (char *) map + sz;
 
-	for (pass = 0; pass < 2; pass++) {
+	for (int pass = 0; pass < 2; pass++) {
 		cnt = 0;
 		cp = map;
 		while (cp < endp) {
@@ -61,10 +61,9 @@ static void prepare_order(const char *orderfile)
 
 static int match_order(const char *path)
 {
-	int i;
 	static struct strbuf p = STRBUF_INIT;
 
-	for (i = 0; i < order_cnt; i++) {
+	for (int i = 0; i < order_cnt; i++) {
 		strbuf_reset(&p);
 		strbuf_addstr(&p, path);
 		while (p.buf[0]) {
@@ -93,13 +92,11 @@ static int compare_objs_order(const void *a_, const void *b_)
 void order_objects(const char *orderfile, obj_path_fn_t obj_path,
 		   struct obj_order *objs, int nr)
 {
-	int i;
-
 	if (!nr)
 		return;
 
 	prepare_order(orderfile);
-	for (i = 0; i < nr; i++) {
+	for (int i = 0; i < nr; i++) {
 		objs[i].orig_order = i;
 		objs[i].order = match_order(obj_path(objs[i].obj));
 	}
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 5a6e2bcac7..8082955c6e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -576,7 +576,6 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
-	int i;
 
 	if (!dirs_removed && !relevant_sources) {
 		info->setup = 0;
@@ -613,7 +612,7 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 	 * Loop setting up both info->idx_map, and doing setup of
 	 * info->dir_rename_count.
 	 */
-	for (i = 0; i < rename_dst_nr; ++i) {
+	for (int i = 0; i < rename_dst_nr; ++i) {
 		/*
 		 * For non-renamed files, make idx_map contain mapping of
 		 *   filename -> index (index within rename_dst, that is)
@@ -685,7 +684,6 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
 	struct string_list to_remove = STRING_LIST_INIT_NODUP;
-	int i;
 
 	if (!info->setup)
 		return;
@@ -731,7 +729,7 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 		if (strintmap_contains(counts, UNKNOWN_DIR))
 			strintmap_remove(counts, UNKNOWN_DIR);
 	}
-	for (i = 0; i < to_remove.nr; ++i)
+	for (int i = 0; i < to_remove.nr; ++i)
 		strmap_remove(info->dir_rename_count,
 			      to_remove.items[i].string, 1);
 	string_list_clear(&to_remove, 0);
@@ -840,7 +838,6 @@ static void basename_prefetch(void *prefetch_options)
 	struct strintmap *sources = options->sources;
 	struct strintmap *dests = options->dests;
 	struct dir_rename_info *info = options->info;
-	int i;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
 	/*
@@ -848,7 +845,7 @@ static void basename_prefetch(void *prefetch_options)
 	 * find_basename_matches(), though not quite exactly.  Maybe
 	 * abstract the iteration logic out somehow?
 	 */
-	for (i = 0; i < rename_src_nr; ++i) {
+	for (int i = 0; i < rename_src_nr; ++i) {
 		char *filename = rename_src[i].p->one->path;
 		const char *base = NULL;
 		intptr_t src_index;
@@ -1062,11 +1059,11 @@ static int find_basename_matches(struct diff_options *options,
 #define NUM_CANDIDATE_PER_DST 4
 static void record_if_better(struct diff_score m[], struct diff_score *o)
 {
-	int i, worst;
+	int worst;
 
 	/* find the worst one */
 	worst = 0;
-	for (i = 1; i < NUM_CANDIDATE_PER_DST; i++)
+	for (int i = 1; i < NUM_CANDIDATE_PER_DST; i++)
 		if (score_compare(&m[i], &m[worst]) > 0)
 			worst = i;
 
@@ -1132,9 +1129,9 @@ static int find_renames(struct diff_score *mx,
 			struct dir_rename_info *info,
 			struct strintmap *dirs_removed)
 {
-	int count = 0, i;
+	int count = 0;
 
-	for (i = 0; i < dst_cnt * NUM_CANDIDATE_PER_DST; i++) {
+	for (int i = 0; i < dst_cnt * NUM_CANDIDATE_PER_DST; i++) {
 		struct diff_rename_dst *dst;
 
 		if ((mx[i].dst < 0) ||
diff --git a/dir.c b/dir.c
index ac69954230..a2199be105 100644
--- a/dir.c
+++ b/dir.c
@@ -163,7 +163,6 @@ static int fnmatch_icase_mem(const char *pattern, int patternlen,
 
 static size_t common_prefix_len(const struct pathspec *pathspec)
 {
-	int n;
 	size_t max = 0;
 
 	/*
@@ -182,7 +181,7 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
 		       PATHSPEC_EXCLUDE |
 		       PATHSPEC_ATTR);
 
-	for (n = 0; n < pathspec->nr; n++) {
+	for (int n = 0; n < pathspec->nr; n++) {
 		size_t i = 0, len = 0, item_len;
 		if (pathspec->items[n].magic & PATHSPEC_EXCLUDE)
 			continue;
@@ -462,7 +461,7 @@ static int do_match_pathspec(struct index_state *istate,
 			     int prefix, char *seen,
 			     unsigned flags)
 {
-	int i, retval = 0, exclude = flags & DO_MATCH_EXCLUDE;
+	int retval = 0, exclude = flags & DO_MATCH_EXCLUDE;
 
 	GUARD_PATHSPEC(ps,
 		       PATHSPEC_FROMTOP |
@@ -488,7 +487,7 @@ static int do_match_pathspec(struct index_state *istate,
 	name += prefix;
 	namelen -= prefix;
 
-	for (i = ps->nr - 1; i >= 0; i--) {
+	for (int i = ps->nr - 1; i >= 0; i--) {
 		int how;
 
 		if ((!exclude &&   ps->items[i].magic & PATHSPEC_EXCLUDE) ||
@@ -575,8 +574,8 @@ int report_path_error(const char *ps_matched,
 	/*
 	 * Make sure all pathspec matched; otherwise it is an error.
 	 */
-	int num, errors = 0;
-	for (num = 0; num < pathspec->nr; num++) {
+	int errors = 0;
+	for (int num = 0; num < pathspec->nr; num++) {
 		int other, found_dup;
 
 		if (ps_matched[num])
@@ -938,9 +937,7 @@ static int read_skip_worktree_file_from_index(struct index_state *istate,
  */
 void clear_pattern_list(struct pattern_list *pl)
 {
-	int i;
-
-	for (i = 0; i < pl->nr; i++)
+	for (int i = 0; i < pl->nr; i++)
 		free(pl->patterns[i]);
 	free(pl->patterns);
 	free(pl->filebuf);
@@ -952,9 +949,9 @@ void clear_pattern_list(struct pattern_list *pl)
 
 static void trim_trailing_spaces(char *buf)
 {
-	char *p, *last_space = NULL;
+	char *last_space = NULL;
 
-	for (p = buf; *p; p++)
+	for (char *p = buf; *p; p++)
 		switch (*p) {
 		case ' ':
 			if (!last_space)
@@ -1020,10 +1017,9 @@ static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
 
 static void do_invalidate_gitignore(struct untracked_cache_dir *dir)
 {
-	int i;
 	dir->valid = 0;
 	dir->untracked_nr = 0;
-	for (i = 0; i < dir->dirs_nr; i++)
+	for (int i = 0; i < dir->dirs_nr; i++)
 		do_invalidate_gitignore(dir->dirs[i]);
 }
 
@@ -1037,8 +1033,6 @@ static void invalidate_gitignore(struct untracked_cache *uc,
 static void invalidate_directory(struct untracked_cache *uc,
 				 struct untracked_cache_dir *dir)
 {
-	int i;
-
 	/*
 	 * Invalidation increment here is just roughly correct. If
 	 * untracked_nr or any of dirs[].recurse is non-zero, we
@@ -1050,7 +1044,7 @@ static void invalidate_directory(struct untracked_cache *uc,
 
 	dir->valid = 0;
 	dir->untracked_nr = 0;
-	for (i = 0; i < dir->dirs_nr; i++)
+	for (int i = 0; i < dir->dirs_nr; i++)
 		dir->dirs[i]->recurse = 0;
 }
 
@@ -1144,7 +1138,7 @@ static int add_patterns_from_buffer(char *buf, size_t size,
 				    const char *base, int baselen,
 				    struct pattern_list *pl)
 {
-	int i, lineno = 1;
+	int lineno = 1;
 	char *entry;
 
 	hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
@@ -1157,7 +1151,7 @@ static int add_patterns_from_buffer(char *buf, size_t size,
 
 	entry = buf;
 
-	for (i = 0; i < size; i++) {
+	for (int i = 0; i < size; i++) {
 		if (buf[i] == '\n') {
 			if (entry != buf + i && entry[0] != '#') {
 				buf[i - (i && buf[i-1] == '\r')] = 0;
@@ -1331,12 +1325,11 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 						       struct index_state *istate)
 {
 	struct path_pattern *res = NULL; /* undecided */
-	int i;
 
 	if (!pl->nr)
 		return NULL;	/* undefined */
 
-	for (i = pl->nr - 1; 0 <= i; i--) {
+	for (int i = pl->nr - 1; 0 <= i; i--) {
 		struct path_pattern *pattern = pl->patterns[i];
 		const char *exclude = pattern->pattern;
 		int prefix = pattern->nowildcardlen;
@@ -1475,7 +1468,7 @@ static int path_in_sparse_checkout_1(const char *path,
 {
 	int dtype = DT_REG;
 	enum pattern_match_result match = UNDECIDED;
-	const char *end, *slash;
+	const char *slash;
 
 	/*
 	 * We default to accepting a path if the path is empty, there are no
@@ -1493,9 +1486,7 @@ static int path_in_sparse_checkout_1(const char *path,
 	 * never returns UNDECIDED, so we will execute only one iteration in
 	 * this case.
 	 */
-	for (end = path + strlen(path);
-	     end > path && match == UNDECIDED;
-	     end = slash) {
+	for (const char *end = path + strlen(path); end > path && match == UNDECIDED; end = slash) {
 
 		for (slash = end - 1; slash > path && *slash != '/'; slash--)
 			; /* do nothing */
@@ -1527,10 +1518,10 @@ static struct path_pattern *last_matching_pattern_from_lists(
 		const char *pathname, int pathlen,
 		const char *basename, int *dtype_p)
 {
-	int i, j;
+	int j;
 	struct exclude_list_group *group;
 	struct path_pattern *pattern;
-	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
+	for (int i = EXC_CMDL; i <= EXC_FILE; i++) {
 		group = &dir->internal.exclude_list_group[i];
 		for (j = group->nr - 1; j >= 0; j--) {
 			pattern = last_matching_pattern_from_list(
@@ -2101,8 +2092,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 */
 	if ((dir->flags & DIR_SHOW_IGNORED_TOO) &&
 	    !(dir->flags & DIR_KEEP_UNTRACKED_CONTENTS)) {
-		int i;
-		for (i = old_untracked_nr + 1; i<dir->nr; ++i)
+		for (int i = old_untracked_nr + 1; i < dir->nr; ++i)
 			FREE_AND_NULL(dir->entries[i]);
 		dir->nr = old_untracked_nr;
 	}
@@ -2126,8 +2116,6 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 static int simplify_away(const char *path, int pathlen,
 			 const struct pathspec *pathspec)
 {
-	int i;
-
 	if (!pathspec || !pathspec->nr)
 		return 0;
 
@@ -2140,7 +2128,7 @@ static int simplify_away(const char *path, int pathlen,
 		       PATHSPEC_EXCLUDE |
 		       PATHSPEC_ATTR);
 
-	for (i = 0; i < pathspec->nr; i++) {
+	for (int i = 0; i < pathspec->nr; i++) {
 		const struct pathspec_item *item = &pathspec->items[i];
 		int len = item->nowildcard_len;
 
@@ -2167,8 +2155,6 @@ static int simplify_away(const char *path, int pathlen,
 static int exclude_matches_pathspec(const char *path, int pathlen,
 				    const struct pathspec *pathspec)
 {
-	int i;
-
 	if (!pathspec || !pathspec->nr)
 		return 0;
 
@@ -2181,7 +2167,7 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
 		       PATHSPEC_EXCLUDE |
 		       PATHSPEC_ATTR);
 
-	for (i = 0; i < pathspec->nr; i++) {
+	for (int i = 0; i < pathspec->nr; i++) {
 		const struct pathspec_item *item = &pathspec->items[i];
 		int len = item->nowildcard_len;
 
@@ -3933,7 +3919,6 @@ void untracked_cache_add_to_index(struct index_state *istate,
 static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 					const char *sub_gitdir)
 {
-	int i;
 	struct repository subrepo;
 	struct strbuf sub_wt = STRBUF_INIT;
 	struct strbuf sub_gd = STRBUF_INIT;
@@ -3949,7 +3934,7 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(subrepo.index);
-	for (i = 0; i < subrepo.index->cache_nr; i++) {
+	for (int i = 0; i < subrepo.index->cache_nr; i++) {
 		const struct cache_entry *ce = subrepo.index->cache[i];
 
 		if (!S_ISGITLINK(ce->ce_mode))
diff --git a/entry.c b/entry.c
index f918a3a78e..22b8cf69ca 100644
--- a/entry.c
+++ b/entry.c
@@ -431,7 +431,7 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 static void mark_colliding_entries(const struct checkout *state,
 				   struct cache_entry *ce, struct stat *st)
 {
-	int i, trust_ino = check_stat;
+	int trust_ino = check_stat;
 
 #if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
 	trust_ino = 0;
@@ -441,7 +441,7 @@ static void mark_colliding_entries(const struct checkout *state,
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(state->istate);
-	for (i = 0; i < state->istate->cache_nr; i++) {
+	for (int i = 0; i < state->istate->cache_nr; i++) {
 		struct cache_entry *dup = state->istate->cache[i];
 
 		if (dup == ce) {
diff --git a/environment.c b/environment.c
index 90632a39bc..080dc2a661 100644
--- a/environment.c
+++ b/environment.c
@@ -146,7 +146,7 @@ const char * const local_repo_env[] = {
 static char *expand_namespace(const char *raw_namespace)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct strbuf **components, **c;
+	struct strbuf **components;
 
 	if (!raw_namespace || !*raw_namespace)
 		return xstrdup("");
@@ -154,7 +154,7 @@ static char *expand_namespace(const char *raw_namespace)
 	strbuf_addstr(&buf, raw_namespace);
 	components = strbuf_split(&buf, '/');
 	strbuf_reset(&buf);
-	for (c = components; *c; c++)
+	for (struct strbuf **c = components; *c; c++)
 		if (strcmp((*c)->buf, "/") != 0)
 			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
 	strbuf_list_free(components);
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index ac7e0af622..e6bc290e24 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -76,10 +76,10 @@ int bitmap_get(struct bitmap *self, size_t pos)
 struct ewah_bitmap *bitmap_to_ewah(struct bitmap *bitmap)
 {
 	struct ewah_bitmap *ewah = ewah_new();
-	size_t i, running_empty_words = 0;
+	size_t running_empty_words = 0;
 	eword_t last_word = 0;
 
-	for (i = 0; i < bitmap->word_alloc; ++i) {
+	for (size_t i = 0; i < bitmap->word_alloc; ++i) {
 		if (bitmap->words[i] == 0) {
 			running_empty_words++;
 			continue;
@@ -121,20 +121,14 @@ struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah)
 void bitmap_and_not(struct bitmap *self, struct bitmap *other)
 {
 	const size_t count = (self->word_alloc < other->word_alloc) ?
-		self->word_alloc : other->word_alloc;
-
-	size_t i;
-
-	for (i = 0; i < count; ++i)
+		self->word_alloc : other->word_alloc;for (size_t i = 0; i < count; ++i)
 		self->words[i] &= ~other->words[i];
 }
 
 void bitmap_or(struct bitmap *self, const struct bitmap *other)
 {
-	size_t i;
-
 	bitmap_grow(self, other->word_alloc);
-	for (i = 0; i < other->word_alloc; i++)
+	for (size_t i = 0; i < other->word_alloc; i++)
 		self->words[i] |= other->words[i];
 }
 
@@ -161,9 +155,9 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 
 size_t bitmap_popcount(struct bitmap *self)
 {
-	size_t i, count = 0;
+	size_t count = 0;
 
-	for (i = 0; i < self->word_alloc; ++i)
+	for (size_t i = 0; i < self->word_alloc; ++i)
 		count += ewah_bit_popcount64(self->words[i]);
 
 	return count;
@@ -171,8 +165,7 @@ size_t bitmap_popcount(struct bitmap *self)
 
 int bitmap_is_empty(struct bitmap *self)
 {
-	size_t i;
-	for (i = 0; i < self->word_alloc; i++)
+	for (size_t i = 0; i < self->word_alloc; i++)
 		if (self->words[i])
 			return 0;
 	return 1;
diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index 9035ee65ea..1a4f8f9557 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -90,7 +90,6 @@ ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
 {
 	const uint8_t *ptr = map;
 	size_t data_len;
-	size_t i;
 
 	if (len < sizeof(uint32_t))
 		return error("corrupt ewah bitmap: eof before bit size");
@@ -121,7 +120,7 @@ ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
 	ptr += data_len;
 	len -= data_len;
 
-	for (i = 0; i < self->buffer_size; ++i)
+	for (size_t i = 0; i < self->buffer_size; ++i)
 		self->buffer[i] = ntohll(self->buffer[i]);
 
 	if (len < sizeof(uint32_t))
diff --git a/fetch-pack.c b/fetch-pack.c
index 091f9a80a9..176944aeb4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -109,14 +109,13 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
 {
 	static int initialized;
 	static struct alternate_object_cache cache;
-	size_t i;
 
 	if (!initialized) {
 		for_each_alternate_ref(cache_one_alternate, &cache);
 		initialized = 1;
 	}
 
-	for (i = 0; i < cache.nr; i++)
+	for (size_t i = 0; i < cache.nr; i++)
 		cb(negotiator, cache.items[i]);
 }
 
@@ -287,14 +286,12 @@ static int next_flush(int stateless_rpc, int count)
 static void mark_tips(struct fetch_negotiator *negotiator,
 		      const struct oid_array *negotiation_tips)
 {
-	int i;
-
 	if (!negotiation_tips) {
 		for_each_rawref(rev_list_insert_ref_oid, negotiator);
 		return;
 	}
 
-	for (i = 0; i < negotiation_tips->nr; i++)
+	for (int i = 0; i < negotiation_tips->nr; i++)
 		rev_list_insert_ref(negotiator, &negotiation_tips->oid[i]);
 	return;
 }
@@ -414,8 +411,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 		packet_buf_write(&req_buf, "deepen-since %"PRItime, max_age);
 	}
 	if (args->deepen_not) {
-		int i;
-		for (i = 0; i < args->deepen_not->nr; i++) {
+		for (int i = 0; i < args->deepen_not->nr; i++) {
 			struct string_list_item *s = args->deepen_not->items + i;
 			packet_buf_write(&req_buf, "deepen-not %s", s->string);
 		}
@@ -1023,9 +1019,7 @@ static int get_pack(struct fetch_pack_args *args,
 	}
 
 	if (index_pack_args) {
-		int i;
-
-		for (i = 0; i < cmd.args.nr; i++)
+		for (int i = 0; i < cmd.args.nr; i++)
 			strvec_push(index_pack_args, cmd.args.v[i]);
 	}
 
@@ -1246,8 +1240,7 @@ static void add_shallow_requests(struct strbuf *req_buf,
 		packet_buf_write(req_buf, "deepen-since %"PRItime, max_age);
 	}
 	if (args->deepen_not) {
-		int i;
-		for (i = 0; i < args->deepen_not->nr; i++) {
+		for (int i = 0; i < args->deepen_not->nr; i++) {
 			struct string_list_item *s = args->deepen_not->items + i;
 			packet_buf_write(req_buf, "deepen-not %s", s->string);
 		}
@@ -1328,9 +1321,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	if (advertise_sid && server_supports_v2("session-id"))
 		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
 	if (server_options && server_options->nr) {
-		int i;
 		ensure_server_supports_v2("server-option");
-		for (i = 0; i < server_options->nr; i++)
+		for (int i = 0; i < server_options->nr; i++)
 			packet_buf_write(req_buf, "server-option=%s",
 					 server_options->items[i].string);
 	}
@@ -1382,10 +1374,9 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		    server_supports_feature("fetch", "filter", 0));
 
 	if (server_supports_feature("fetch", "packfile-uris", 0)) {
-		int i;
 		struct strbuf to_send = STRBUF_INIT;
 
-		for (i = 0; i < uri_protocols.nr; i++) {
+		for (int i = 0; i < uri_protocols.nr; i++) {
 			const char *s = uri_protocols.items[i].string;
 
 			if (!strcmp(s, "https") || !strcmp(s, "http")) {
@@ -1549,15 +1540,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 	    reader->status != PACKET_READ_DELIM)
 		die(_("error processing shallow info: %d"), reader->status);
 
-	if (args->deepen || unshallow_received) {
-		/*
-		 * Treat these as shallow lines caused by our depth settings.
-		 * In v0, these lines cannot cause refs to be rejected; do the
-		 * same.
-		 */
-		int i;
-
-		for (i = 0; i < shallows->nr; i++)
+	if (args->deepen || unshallow_received) {for (int i = 0; i < shallows->nr; i++)
 			register_shallow(the_repository, &shallows->oid[i]);
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
@@ -1661,7 +1644,6 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct object_id common_oid;
 	int received_ready = 0;
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
-	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
 
 	negotiator = &negotiator_alloc;
@@ -1794,7 +1776,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
-	for (i = 0; i < packfile_uris.nr; i++) {
+	for (int i = 0; i < packfile_uris.nr; i++) {
 		int j;
 		struct child_process cmd = CHILD_PROCESS_INIT;
 		char packname[GIT_MAX_HEXSZ + 1];
@@ -2225,9 +2207,9 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 
 int report_unmatched_refs(struct ref **sought, int nr_sought)
 {
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < nr_sought; i++) {
+	for (int i = 0; i < nr_sought; i++) {
 		if (!sought[i])
 			continue;
 		switch (sought[i]->match_status) {
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 66e47449a0..3872ba5de3 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -85,8 +85,7 @@ static struct merge_parent *find_merge_parent(struct merge_parents *table,
 					      struct object_id *given,
 					      struct object_id *commit)
 {
-	int i;
-	for (i = 0; i < table->nr; i++) {
+	for (int i = 0; i < table->nr; i++) {
 		if (given && !oideq(&table->item[i].given, given))
 			continue;
 		if (commit && !oideq(&table->item[i].commit, commit))
@@ -209,9 +208,8 @@ static void print_joined(const char *singular, const char *plural,
 	if (list->nr == 1) {
 		strbuf_addf(out, "%s%s", singular, list->items[0].string);
 	} else {
-		int i;
 		strbuf_addstr(out, plural);
-		for (i = 0; i < list->nr - 1; i++)
+		for (int i = 0; i < list->nr - 1; i++)
 			strbuf_addf(out, "%s%s", i > 0 ? ", " : "",
 				    list->items[i].string);
 		strbuf_addf(out, " and %s", list->items[list->nr - 1].string);
@@ -345,7 +343,7 @@ static void shortlog(const char *name,
 		     struct fmt_merge_msg_opts *opts,
 		     struct strbuf *out)
 {
-	int i, count = 0;
+	int count = 0;
 	struct commit *commit;
 	struct object *branch;
 	struct string_list subjects = STRING_LIST_INIT_DUP;
@@ -408,7 +406,7 @@ static void shortlog(const char *name,
 	if (origin_data->is_local_branch && use_branch_desc)
 		add_branch_desc(out, name);
 
-	for (i = 0; i < subjects.nr; i++)
+	for (int i = 0; i < subjects.nr; i++)
 		if (i >= limit)
 			strbuf_addstr(out, "  ...\n");
 		else
@@ -516,10 +514,10 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
 
 static void fmt_merge_msg_sigs(struct strbuf *out)
 {
-	int i, tag_number = 0, first_tag = 0;
+	int tag_number = 0, first_tag = 0;
 	struct strbuf tagbuf = STRBUF_INIT;
 
-	for (i = 0; i < origins.nr; i++) {
+	for (int i = 0; i < origins.nr; i++) {
 		struct object_id *oid = origins.items[i].util;
 		enum object_type type;
 		unsigned long size;
diff --git a/fsck.c b/fsck.c
index 8ded0a473a..f9697ca33b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -40,13 +40,11 @@ static struct {
 
 static void prepare_msg_ids(void)
 {
-	int i;
-
 	if (msg_id_info[0].downcased)
 		return;
 
 	/* convert id_string to lower case, without underscores. */
-	for (i = 0; i < FSCK_MSG_MAX; i++) {
+	for (int i = 0; i < FSCK_MSG_MAX; i++) {
 		const char *p = msg_id_info[i].id_string;
 		int len = strlen(p);
 		char *q = xmalloc(len);
@@ -77,11 +75,9 @@ static void prepare_msg_ids(void)
 
 static int parse_msg_id(const char *text)
 {
-	int i;
-
 	prepare_msg_ids();
 
-	for (i = 0; i < FSCK_MSG_MAX; i++)
+	for (int i = 0; i < FSCK_MSG_MAX; i++)
 		if (!strcmp(text, msg_id_info[i].downcased))
 			return i;
 
@@ -90,11 +86,9 @@ static int parse_msg_id(const char *text)
 
 void list_config_fsck_msg_ids(struct string_list *list, const char *prefix)
 {
-	int i;
-
 	prepare_msg_ids();
 
-	for (i = 0; i < FSCK_MSG_MAX; i++)
+	for (int i = 0; i < FSCK_MSG_MAX; i++)
 		list_config_item(list, prefix, msg_id_info[i].camelcased);
 }
 
@@ -139,10 +133,9 @@ void fsck_set_msg_type_from_ids(struct fsck_options *options,
 				enum fsck_msg_type msg_type)
 {
 	if (!options->msg_type) {
-		int i;
 		enum fsck_msg_type *severity;
 		ALLOC_ARRAY(severity, FSCK_MSG_MAX);
-		for (i = 0; i < FSCK_MSG_MAX; i++)
+		for (int i = 0; i < FSCK_MSG_MAX; i++)
 			severity[i] = fsck_msg_type(i, options);
 		options->msg_type = severity;
 	}
@@ -794,9 +787,7 @@ static int verify_headers(const void *data, unsigned long size,
 			  struct fsck_options *options)
 {
 	const char *buffer = (const char *)data;
-	unsigned long i;
-
-	for (i = 0; i < size; i++) {
+	for (unsigned long i = 0; i < size; i++) {
 		switch (buffer[i]) {
 		case '\0':
 			return report(options, oid, type,
diff --git a/fsmonitor.c b/fsmonitor.c
index f670c50937..7b491327c8 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -103,9 +103,9 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 
 void fill_fsmonitor_bitmap(struct index_state *istate)
 {
-	unsigned int i, skipped = 0;
+	unsigned int skipped = 0;
 	istate->fsmonitor_dirty = ewah_new();
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (unsigned int i = 0; i < istate->cache_nr; i++) {
 		if (istate->cache[i]->ce_flags & CE_REMOVE)
 			skipped++;
 		else if (!(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID))
@@ -304,7 +304,6 @@ void refresh_fsmonitor(struct index_state *istate)
 	uint64_t last_update;
 	struct strbuf last_update_token = STRBUF_INIT;
 	char *buf;
-	unsigned int i;
 	int is_trivial = 0;
 	struct repository *r = istate->repo;
 	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
@@ -458,7 +457,7 @@ void refresh_fsmonitor(struct index_state *istate)
 		int count = 0;
 
 		buf = query_result.buf;
-		for (i = bol; i < query_result.len; i++) {
+		for (unsigned int i = bol; i < query_result.len; i++) {
 			if (buf[i] != '\0')
 				continue;
 			fsmonitor_refresh_callback(istate, buf + bol);
@@ -491,7 +490,7 @@ void refresh_fsmonitor(struct index_state *istate)
 		 */
 		int is_cache_changed = 0;
 
-		for (i = 0; i < istate->cache_nr; i++) {
+		for (unsigned int i = 0; i < istate->cache_nr; i++) {
 			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) {
 				is_cache_changed = 1;
 				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
diff --git a/git.c b/git.c
index fd9b0e6a9e..3545427905 100644
--- a/git.c
+++ b/git.c
@@ -72,7 +72,6 @@ static int match_token(const char *spec, int len, const char *token)
 static int list_cmds(const char *spec)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
-	int i;
 	int nongit;
 
 	/*
@@ -110,7 +109,7 @@ static int list_cmds(const char *spec)
 		if (*spec == ',')
 			spec++;
 	}
-	for (i = 0; i < list.nr; i++)
+	for (int i = 0; i < list.nr; i++)
 		puts(list.items[i].string);
 	string_list_clear(&list, 0);
 	return 0;
@@ -640,8 +639,7 @@ static struct cmd_struct commands[] = {
 
 static struct cmd_struct *get_builtin(const char *s)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+	for (int i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands + i;
 		if (!strcmp(s, p->cmd))
 			return p;
@@ -656,8 +654,7 @@ int is_builtin(const char *s)
 
 static void list_builtins(struct string_list *out, unsigned int exclude_option)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+	for (int i = 0; i < ARRAY_SIZE(commands); i++) {
 		if (exclude_option &&
 		    (commands[i].option & exclude_option))
 			continue;
@@ -668,7 +665,6 @@ static void list_builtins(struct string_list *out, unsigned int exclude_option)
 void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
 {
 	const char *name;
-	int i;
 
 	/*
 	 * Callers can ask for a subset of the commands based on a certain
@@ -679,7 +675,7 @@ void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
 	if (!skip_prefix(prefix, "git-", &prefix))
 		BUG("prefix '%s' must start with 'git-'", prefix);
 
-	for (i = 0; i < ARRAY_SIZE(commands); i++)
+	for (int i = 0; i < ARRAY_SIZE(commands); i++)
 		if (skip_prefix(commands[i].cmd, prefix, &name))
 			add_cmdname(cmds, name, strlen(name));
 }
@@ -707,12 +703,10 @@ static void handle_builtin(int argc, const char **argv)
 
 	/* Turn "git cmd --help" into "git help --exclude-guides cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
-		int i;
-
 		argv[1] = argv[0];
 		argv[0] = cmd = "help";
 
-		for (i = 0; i < argc; i++) {
+		for (int i = 0; i < argc; i++) {
 			strvec_push(&args, argv[i]);
 			if (!i)
 				strvec_push(&args, "--exclude-guides");
diff --git a/gpg-interface.c b/gpg-interface.c
index 95e764acb1..cd3dd5b5b4 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -123,9 +123,7 @@ static struct gpg_format *use_format = &gpg_format[0];
 
 static struct gpg_format *get_format_by_name(const char *str)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(gpg_format); i++)
+	for (int i = 0; i < ARRAY_SIZE(gpg_format); i++)
 		if (!strcmp(gpg_format[i].name, str))
 			return gpg_format + i;
 	return NULL;
@@ -133,9 +131,9 @@ static struct gpg_format *get_format_by_name(const char *str)
 
 static struct gpg_format *get_format_by_sig(const char *sig)
 {
-	int i, j;
+	int j;
 
-	for (i = 0; i < ARRAY_SIZE(gpg_format); i++)
+	for (int i = 0; i < ARRAY_SIZE(gpg_format); i++)
 		for (j = 0; gpg_format[i].sigs[j]; j++)
 			if (starts_with(sig, gpg_format[i].sigs[j]))
 				return gpg_format + i;
@@ -208,9 +206,7 @@ static void replace_cstring(char **field, const char *line, const char *next)
 static int parse_gpg_trust_level(const char *level,
 				 enum signature_trust_level *res)
 {
-	size_t i;
-
-	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_trust_level); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(sigcheck_gpg_trust_level); i++) {
 		if (!strcmp(sigcheck_gpg_trust_level[i].key, level)) {
 			*res = sigcheck_gpg_trust_level[i].value;
 			return 0;
@@ -222,12 +218,12 @@ static int parse_gpg_trust_level(const char *level,
 static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
-	const char *line, *next;
+	const char *next;
 	int i, j;
 	int seen_exclusive_status = 0;
 
 	/* Iterate over all lines */
-	for (line = buf; *line; line = strchrnul(line+1, '\n')) {
+	for (const char *line = buf; *line; line = strchrnul(line + 1, '\n')) {
 		while (*line == '\n')
 			line++;
 		if (!*line)
@@ -952,9 +948,9 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
  */
 static void remove_cr_after(struct strbuf *buffer, size_t offset)
 {
-	size_t i, j;
+	size_t j;
 
-	for (i = j = offset; i < buffer->len; i++) {
+	for (size_t i = j = offset; i < buffer->len; i++) {
 		if (buffer->buf[i] != '\r') {
 			if (i != j)
 				buffer->buf[j] = buffer->buf[i];
diff --git a/graph.c b/graph.c
index 1ca34770ee..a22172b677 100644
--- a/graph.c
+++ b/graph.c
@@ -460,8 +460,6 @@ static int graph_is_interesting(struct git_graph *graph, struct commit *commit)
 static struct commit_list *next_interesting_parent(struct git_graph *graph,
 						   struct commit_list *orig)
 {
-	struct commit_list *list;
-
 	/*
 	 * If revs->first_parent_only is set, only the first
 	 * parent is interesting.  None of the others are.
@@ -472,7 +470,7 @@ static struct commit_list *next_interesting_parent(struct git_graph *graph,
 	/*
 	 * Return the next interesting commit after orig
 	 */
-	for (list = orig->next; list; list = list->next) {
+	for (struct commit_list *list = orig->next; list; list = list->next) {
 		if (graph_is_interesting(graph, list->item))
 			return list;
 	}
@@ -522,8 +520,7 @@ static void graph_increment_column_color(struct git_graph *graph)
 static unsigned short graph_find_commit_color(const struct git_graph *graph,
 					      const struct commit *commit)
 {
-	int i;
-	for (i = 0; i < graph->num_columns; i++) {
+	for (int i = 0; i < graph->num_columns; i++) {
 		if (graph->columns[i].commit == commit)
 			return graph->columns[i].color;
 	}
@@ -533,8 +530,7 @@ static unsigned short graph_find_commit_color(const struct git_graph *graph,
 static int graph_find_new_column_by_commit(struct git_graph *graph,
 					   struct commit *commit)
 {
-	int i;
-	for (i = 0; i < graph->num_new_columns; i++) {
+	for (int i = 0; i < graph->num_new_columns; i++) {
 		if (graph->new_columns[i].commit == commit)
 			return i;
 	}
@@ -736,8 +732,6 @@ static int graph_needs_pre_commit_line(struct git_graph *graph)
 
 void graph_update(struct git_graph *graph, struct commit *commit)
 {
-	struct commit_list *parent;
-
 	/*
 	 * Set the new commit
 	 */
@@ -747,9 +741,7 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 * Count how many interesting parents this commit has
 	 */
 	graph->num_parents = 0;
-	for (parent = first_interesting_parent(graph);
-	     parent;
-	     parent = next_interesting_parent(graph, parent))
+	for (struct commit_list *parent = first_interesting_parent(graph); parent; parent = next_interesting_parent(graph, parent))
 	{
 		graph->num_parents++;
 	}
@@ -797,15 +789,7 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 
 static int graph_is_mapping_correct(struct git_graph *graph)
 {
-	int i;
-
-	/*
-	 * The mapping is up to date if each entry is at its target,
-	 * or is 1 greater than its target.
-	 * (If it is 1 greater than the target, '/' will be printed, so it
-	 * will look correct on the next row.)
-	 */
-	for (i = 0; i < graph->mapping_size; i++) {
+	for (int i = 0; i < graph->mapping_size; i++) {
 		int target = graph->mapping[i];
 		if (target < 0)
 			continue;
@@ -833,12 +817,7 @@ static void graph_pad_horizontally(struct git_graph *graph, struct graph_line *l
 static void graph_output_padding_line(struct git_graph *graph,
 				      struct graph_line *line)
 {
-	int i;
-
-	/*
-	 * Output a padding row, that leaves all branch lines unchanged
-	 */
-	for (i = 0; i < graph->num_new_columns; i++) {
+	for (int i = 0; i < graph->num_new_columns; i++) {
 		graph_line_write_column(line, &graph->new_columns[i], '|');
 		graph_line_addch(line, ' ');
 	}
@@ -868,7 +847,7 @@ static void graph_output_skip_line(struct git_graph *graph, struct graph_line *l
 static void graph_output_pre_commit_line(struct git_graph *graph,
 					 struct graph_line *line)
 {
-	int i, seen_this;
+	int seen_this;
 
 	/*
 	 * This function formats a row that increases the space around a commit
@@ -890,7 +869,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 * Output the row
 	 */
 	seen_this = 0;
-	for (i = 0; i < graph->num_columns; i++) {
+	for (int i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		if (col->commit == graph->commit) {
 			seen_this = 1;
@@ -977,12 +956,12 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
 	 * the merge commit.
 	 */
 
-	int i, j;
+	int j;
 	struct column *col;
 
 	int dashed_parents = graph_num_dashed_parents(graph);
 
-	for (i = 0; i < dashed_parents; i++) {
+	for (int i = 0; i < dashed_parents; i++) {
 		j = graph->mapping[(graph->commit_index + i + 2) * 2];
 		col = &graph->new_columns[j];
 
@@ -996,7 +975,6 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
 static void graph_output_commit_line(struct git_graph *graph, struct graph_line *line)
 {
 	int seen_this = 0;
-	int i;
 
 	/*
 	 * Output the row containing this commit
@@ -1006,7 +984,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 	 * children that we have already processed.)
 	 */
 	seen_this = 0;
-	for (i = 0; i <= graph->num_columns; i++) {
+	for (int i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
@@ -1072,7 +1050,7 @@ static const char merge_chars[] = {'/', '|', '\\'};
 static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
 {
 	int seen_this = 0;
-	int i, j;
+	int j;
 
 	struct commit_list *first_parent = first_interesting_parent(graph);
 	struct column *parent_col = NULL;
@@ -1080,7 +1058,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 	/*
 	 * Output the post-merge row
 	 */
-	for (i = 0; i <= graph->num_columns; i++) {
+	for (int i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
@@ -1347,7 +1325,6 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 
 static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 {
-	int i;
 	struct graph_line line = { .buf = sb, .width = 0 };
 
 	if (graph->state != GRAPH_COMMIT) {
@@ -1362,7 +1339,7 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	 * columns.  (This happens when the current commit doesn't have any
 	 * children that we have already processed.)
 	 */
-	for (i = 0; i < graph->num_columns; i++) {
+	for (int i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 
 		graph_line_write_column(&line, col, '|');
diff --git a/grep.c b/grep.c
index 5f23d1a50c..fabb1b4d4e 100644
--- a/grep.c
+++ b/grep.c
@@ -195,14 +195,13 @@ void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen,
 
 struct grep_opt *grep_opt_dup(const struct grep_opt *opt)
 {
-	struct grep_pat *pat;
 	struct grep_opt *ret = xmalloc(sizeof(struct grep_opt));
 	*ret = *opt;
 
 	ret->pattern_list = NULL;
 	ret->pattern_tail = &ret->pattern_list;
 
-	for(pat = opt->pattern_list; pat != NULL; pat = pat->next)
+	for (struct grep_pat *pat = opt->pattern_list; pat != NULL; pat = pat->next)
 	{
 		if(pat->token == GREP_PATTERN_HEAD)
 			append_header_grep_pattern(ret, pat->field,
@@ -232,9 +231,7 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 
 static int is_fixed(const char *s, size_t len)
 {
-	size_t i;
-
-	for (i = 0; i < len; i++) {
+	for (size_t i = 0; i < len; i++) {
 		if (is_regex_special(s[i]))
 			return 0;
 	}
@@ -831,9 +828,9 @@ static void free_pattern_expr(struct grep_expr *x)
 
 static void free_grep_pat(struct grep_pat *pattern)
 {
-	struct grep_pat *p, *n;
+	struct grep_pat *n;
 
-	for (p = pattern; p; p = n) {
+	for (struct grep_pat *p = pattern; p; p = n) {
 		n = p->next;
 		switch (p->token) {
 		case GREP_PATTERN: /* atom */
@@ -1113,7 +1110,6 @@ static int match_line(struct grep_opt *opt,
 		      ssize_t *col, ssize_t *icol,
 		      enum grep_context ctx, int collect_hits)
 {
-	struct grep_pat *p;
 	int hit = 0;
 
 	if (opt->pattern_expression)
@@ -1121,7 +1117,7 @@ static int match_line(struct grep_opt *opt,
 				  collect_hits);
 
 	/* we do not call with collect_hits without being extended */
-	for (p = opt->pattern_list; p; p = p->next) {
+	for (struct grep_pat *p = opt->pattern_list; p; p = p->next) {
 		regmatch_t tmp;
 		if (match_one_pattern(p, bol, eol, ctx, &tmp, 0)) {
 			hit |= 1;
@@ -1432,13 +1428,11 @@ static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 
 static int should_lookahead(struct grep_opt *opt)
 {
-	struct grep_pat *p;
-
 	if (opt->pattern_expression)
 		return 0; /* punt for too complex stuff */
 	if (opt->invert)
 		return 0;
-	for (p = opt->pattern_list; p; p = p->next) {
+	for (struct grep_pat *p = opt->pattern_list; p; p = p->next) {
 		if (p->token != GREP_PATTERN)
 			return 0; /* punt for "header only" and stuff */
 	}
@@ -1452,11 +1446,10 @@ static int look_ahead(struct grep_opt *opt,
 {
 	unsigned lno = *lno_p;
 	const char *bol = *bol_p;
-	struct grep_pat *p;
 	const char *sp, *last_bol;
 	regoff_t earliest = -1;
 
-	for (p = opt->pattern_list; p; p = p->next) {
+	for (struct grep_pat *p = opt->pattern_list; p; p = p->next) {
 		int hit;
 		regmatch_t m;
 
diff --git a/hash-lookup.c b/hash-lookup.c
index 9f0f95e2b9..6c57c9e8ca 100644
--- a/hash-lookup.c
+++ b/hash-lookup.c
@@ -63,9 +63,9 @@ int oid_pos(const struct object_id *oid, const void *table, size_t nr,
 		return -1;
 
 	if (nr != 1) {
-		size_t lov, hiv, miv, ofs;
+		size_t lov, hiv, miv;
 
-		for (ofs = 0; ofs < the_hash_algo->rawsz - 2; ofs += 2) {
+		for (size_t ofs = 0; ofs < the_hash_algo->rawsz - 2; ofs += 2) {
 			lov = take2(fn(0, table), ofs);
 			hiv = take2(fn(nr - 1, table), ofs);
 			miv = take2(oid, ofs);
diff --git a/hashmap.c b/hashmap.c
index ee45ef0085..6aca26c9a6 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -115,11 +115,11 @@ int hashmap_bucket(const struct hashmap *map, unsigned int hash)
 static void rehash(struct hashmap *map, unsigned int newsize)
 {
 	/* map->table MUST NOT be NULL when this function is called */
-	unsigned int i, oldsize = map->tablesize;
+	unsigned int oldsize = map->tablesize;
 	struct hashmap_entry **oldtable = map->table;
 
 	alloc_table(map, newsize);
-	for (i = 0; i < oldsize; i++) {
+	for (unsigned int i = 0; i < oldsize; i++) {
 		struct hashmap_entry *e = oldtable[i];
 		while (e) {
 			struct hashmap_entry *next = e->next;
diff --git a/help.c b/help.c
index 2dbe57b413..0d642a9669 100644
--- a/help.c
+++ b/help.c
@@ -67,7 +67,7 @@ static const char *drop_prefix(const char *name, uint32_t category)
 
 static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
 {
-	int i, nr = 0;
+	int nr = 0;
 	struct cmdname_help *cmds;
 
 	if (ARRAY_SIZE(command_list) == 0)
@@ -75,7 +75,7 @@ static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
 
 	ALLOC_ARRAY(cmds, ARRAY_SIZE(command_list) + 1);
 
-	for (i = 0; i < ARRAY_SIZE(command_list); i++) {
+	for (int i = 0; i < ARRAY_SIZE(command_list); i++) {
 		const struct cmdname_help *cmd = command_list + i;
 
 		if (!(cmd->category & mask))
@@ -93,9 +93,7 @@ static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
 static void print_command_list(const struct cmdname_help *cmds,
 			       uint32_t mask, int longest)
 {
-	int i;
-
-	for (i = 0; cmds[i].name; i++) {
+	for (int i = 0; cmds[i].name; i++) {
 		if (cmds[i].category & mask) {
 			size_t len = strlen(cmds[i].name);
 			printf("   %s   ", cmds[i].name);
@@ -159,8 +157,7 @@ void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 
 static void clean_cmdnames(struct cmdnames *cmds)
 {
-	int i;
-	for (i = 0; i < cmds->cnt; ++i)
+	for (int i = 0; i < cmds->cnt; ++i)
 		free(cmds->names[i]);
 	free(cmds->names);
 	cmds->cnt = 0;
@@ -176,12 +173,12 @@ static int cmdname_compare(const void *a_, const void *b_)
 
 static void uniq(struct cmdnames *cmds)
 {
-	int i, j;
+	int j;
 
 	if (!cmds->cnt)
 		return;
 
-	for (i = j = 1; i < cmds->cnt; i++) {
+	for (int i = j = 1; i < cmds->cnt; i++) {
 		if (!strcmp(cmds->names[i]->name, cmds->names[j-1]->name))
 			free(cmds->names[i]);
 		else
@@ -218,9 +215,7 @@ static void pretty_print_cmdnames(struct cmdnames *cmds, unsigned int colopts)
 {
 	struct string_list list = STRING_LIST_INIT_NODUP;
 	struct column_options copts;
-	int i;
-
-	for (i = 0; i < cmds->cnt; i++)
+	for (int i = 0; i < cmds->cnt; i++)
 		string_list_append(&list, cmds->names[i]->name);
 	/*
 	 * always enable column display, we only consult column.*
@@ -350,13 +345,12 @@ void list_common_cmds_help(void)
 void list_all_main_cmds(struct string_list *list)
 {
 	struct cmdnames main_cmds, other_cmds;
-	int i;
 
 	memset(&main_cmds, 0, sizeof(main_cmds));
 	memset(&other_cmds, 0, sizeof(other_cmds));
 	load_command_list("git-", &main_cmds, &other_cmds);
 
-	for (i = 0; i < main_cmds.cnt; i++)
+	for (int i = 0; i < main_cmds.cnt; i++)
 		string_list_append(list, main_cmds.names[i]->name);
 
 	clean_cmdnames(&main_cmds);
@@ -366,13 +360,12 @@ void list_all_main_cmds(struct string_list *list)
 void list_all_other_cmds(struct string_list *list)
 {
 	struct cmdnames main_cmds, other_cmds;
-	int i;
 
 	memset(&main_cmds, 0, sizeof(main_cmds));
 	memset(&other_cmds, 0, sizeof(other_cmds));
 	load_command_list("git-", &main_cmds, &other_cmds);
 
-	for (i = 0; i < other_cmds.cnt; i++)
+	for (int i = 0; i < other_cmds.cnt; i++)
 		string_list_append(list, other_cmds.names[i]->name);
 
 	clean_cmdnames(&main_cmds);
@@ -476,12 +469,11 @@ static int get_alias(const char *var, const char *value,
 static void list_all_cmds_help_external_commands(void)
 {
 	struct string_list others = STRING_LIST_INIT_DUP;
-	int i;
 
 	list_all_other_cmds(&others);
 	if (others.nr)
 		printf("\n%s\n", _("External commands"));
-	for (i = 0; i < others.nr; i++)
+	for (int i = 0; i < others.nr; i++)
 		printf("   %s\n", others.items[i].string);
 	string_list_clear(&others, 0);
 }
@@ -532,8 +524,7 @@ void list_all_cmds_help(int show_external_commands, int show_aliases)
 
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
-	int i;
-	for (i = 0; i < c->cnt; i++)
+	for (int i = 0; i < c->cnt; i++)
 		if (!strcmp(s, c->names[i]->name))
 			return 1;
 	return 0;
@@ -585,10 +576,9 @@ static int levenshtein_compare(const void *p1, const void *p2)
 
 static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 {
-	int i;
 	ALLOC_GROW(cmds->names, cmds->cnt + old->cnt, cmds->alloc);
 
-	for (i = 0; i < old->cnt; i++)
+	for (int i = 0; i < old->cnt; i++)
 		cmds->names[cmds->cnt++] = old->names[i];
 	FREE_AND_NULL(old->names);
 	old->cnt = 0;
diff --git a/hex.c b/hex.c
index d42262bdca..0a322eaee6 100644
--- a/hex.c
+++ b/hex.c
@@ -5,8 +5,7 @@
 static int get_hash_hex_algop(const char *hex, unsigned char *hash,
 			      const struct git_hash_algo *algop)
 {
-	int i;
-	for (i = 0; i < algop->rawsz; i++) {
+	for (int i = 0; i < algop->rawsz; i++) {
 		int val = hex2chr(hex);
 		if (val < 0)
 			return -1;
@@ -36,8 +35,7 @@ int get_oid_hex_algop(const char *hex, struct object_id *oid,
  */
 int get_oid_hex_any(const char *hex, struct object_id *oid)
 {
-	int i;
-	for (i = GIT_HASH_NALGOS - 1; i > 0; i--) {
+	for (int i = GIT_HASH_NALGOS - 1; i > 0; i--) {
 		if (!get_oid_hex_algop(hex, oid, &hash_algos[i]))
 			return i;
 	}
@@ -77,7 +75,6 @@ char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
 {
 	static const char hex[] = "0123456789abcdef";
 	char *buf = buffer;
-	int i;
 
 	/*
 	 * Our struct object_id has been memset to 0, so default to printing
@@ -86,7 +83,7 @@ char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
 	if (algop == &hash_algos[0])
 		algop = the_hash_algo;
 
-	for (i = 0; i < algop->rawsz; i++) {
+	for (int i = 0; i < algop->rawsz; i++) {
 		unsigned int val = *hash++;
 		*buf++ = hex[val >> 4];
 		*buf++ = hex[val & 0xf];
diff --git a/http-backend.c b/http-backend.c
index 1ed1e29d07..592b1a3a6a 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -240,13 +240,13 @@ static void get_idx_file(struct strbuf *hdr, char *name)
 
 static void http_config(void)
 {
-	int i, value = 0;
+	int value = 0;
 	struct strbuf var = STRBUF_INIT;
 
 	git_config_get_bool("http.getanyfile", &getanyfile);
 	git_config_get_ulong("http.maxrequestbuffer", &max_request_buffer);
 
-	for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
+	for (int i = 0; i < ARRAY_SIZE(rpc_service); i++) {
 		struct rpc_service *svc = &rpc_service[i];
 		strbuf_addf(&var, "http.%s", svc->config_name);
 		if (!git_config_get_bool(var.buf, &value))
@@ -261,12 +261,11 @@ static struct rpc_service *select_service(struct strbuf *hdr, const char *name)
 {
 	const char *svc_name;
 	struct rpc_service *svc = NULL;
-	int i;
 
 	if (!skip_prefix(name, "git-", &svc_name))
 		forbidden(hdr, "Unsupported service: '%s'", name);
 
-	for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
+	for (int i = 0; i < ARRAY_SIZE(rpc_service); i++) {
 		struct rpc_service *s = &rpc_service[i];
 		if (!strcmp(s->name, svc_name)) {
 			svc = s;
@@ -755,7 +754,6 @@ int cmd_main(int argc UNUSED, const char **argv UNUSED)
 	char *dir;
 	struct service_cmd *cmd = NULL;
 	char *cmd_arg = NULL;
-	int i;
 	struct strbuf hdr = STRBUF_INIT;
 
 	set_die_routine(die_webcgi);
@@ -767,7 +765,7 @@ int cmd_main(int argc UNUSED, const char **argv UNUSED)
 		method = "GET";
 	dir = getdir();
 
-	for (i = 0; i < ARRAY_SIZE(services); i++) {
+	for (int i = 0; i < ARRAY_SIZE(services); i++) {
 		struct service_cmd *c = &services[i];
 		regex_t re;
 		regmatch_t out[1];
diff --git a/http-push.c b/http-push.c
index 12d1113741..2835b4b3b6 100644
--- a/http-push.c
+++ b/http-push.c
@@ -608,12 +608,10 @@ static void finish_request(struct transfer_request *request)
 static int is_running_queue;
 static int fill_active_slot(void *data UNUSED)
 {
-	struct transfer_request *request;
-
 	if (aborted || !is_running_queue)
 		return 0;
 
-	for (request = request_queue_head; request; request = request->next) {
+	for (struct transfer_request *request = request_queue_head; request; request = request->next) {
 		if (request->state == NEED_FETCH) {
 			start_fetch_loose(request);
 			return 1;
@@ -1330,7 +1328,6 @@ static struct object_list **process_tree(struct tree *tree,
 
 static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 {
-	int i;
 	struct commit *commit;
 	struct object_list **p = &objects;
 	int count = 0;
@@ -1343,7 +1340,7 @@ static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 			count += add_send_request(&commit->object, lock);
 	}
 
-	for (i = 0; i < revs->pending.nr; i++) {
+	for (int i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *entry = revs->pending.objects + i;
 		struct object *obj = entry->item;
 		const char *name = entry->name;
@@ -1587,7 +1584,6 @@ static int delete_remote_branch(const char *pattern, int force)
 	char *symref = NULL;
 	int match;
 	int patlen = strlen(pattern);
-	int i;
 	struct active_request_slot *slot;
 	struct slot_results results;
 	char *url;
@@ -1619,7 +1615,7 @@ static int delete_remote_branch(const char *pattern, int force)
 		return error("Remote HEAD is not a symref");
 
 	/* Remote branch must not be the remote HEAD */
-	for (i = 0; symref && i < MAXDEPTH; i++) {
+	for (int i = 0; symref && i < MAXDEPTH; i++) {
 		if (!strcmp(remote_ref->name, symref))
 			return error("Remote branch %s is the current HEAD",
 				     remote_ref->name);
diff --git a/http-walker.c b/http-walker.c
index b395ef1327..6b743966ed 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -591,13 +591,12 @@ static void cleanup(struct walker *walker)
 
 struct walker *get_http_walker(const char *url)
 {
-	char *s;
 	struct walker_data *data = xmalloc(sizeof(struct walker_data));
 	struct walker *walker = xmalloc(sizeof(struct walker));
 
 	data->alt = xmalloc(sizeof(*data->alt));
 	data->alt->base = xstrdup(url);
-	for (s = data->alt->base + strlen(data->alt->base) - 1; *s == '/'; --s)
+	for (char *s = data->alt->base + strlen(data->alt->base) - 1; *s == '/'; --s)
 		*s = 0;
 
 	data->alt->got_indices = 0;
diff --git a/http.c b/http.c
index e73b136e58..c87eeb78b7 100644
--- a/http.c
+++ b/http.c
@@ -783,7 +783,7 @@ static void redact_sensitive_info_header(struct strbuf *header)
 static void curl_dump_header(const char *text, unsigned char *ptr, size_t size, int hide_sensitive_header)
 {
 	struct strbuf out = STRBUF_INIT;
-	struct strbuf **headers, **header;
+	struct strbuf **headers;
 
 	strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
 		text, (long)size, (long)size);
@@ -792,7 +792,7 @@ static void curl_dump_header(const char *text, unsigned char *ptr, size_t size,
 	strbuf_add(&out, ptr, size);
 	headers = strbuf_split_max(&out, '\n', 0);
 
-	for (header = headers; *header; header++) {
+	for (struct strbuf **header = headers; *header; header++) {
 		if (hide_sensitive_header)
 			redact_sensitive_header(*header, 0);
 		strbuf_insertstr((*header), 0, text);
@@ -807,7 +807,6 @@ static void curl_dump_header(const char *text, unsigned char *ptr, size_t size,
 
 static void curl_dump_data(const char *text, unsigned char *ptr, size_t size)
 {
-	size_t i;
 	struct strbuf out = STRBUF_INIT;
 	unsigned int width = 60;
 
@@ -815,7 +814,7 @@ static void curl_dump_data(const char *text, unsigned char *ptr, size_t size)
 		text, (long)size, (long)size);
 	trace_strbuf(&trace_curl, &out);
 
-	for (i = 0; i < size; i += width) {
+	for (size_t i = 0; i < size; i += width) {
 		size_t w;
 
 		strbuf_reset(&out);
@@ -946,7 +945,6 @@ static long get_curl_allowed_protocols(int from_user, struct strbuf *list)
 #ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
 static int get_curl_http_version_opt(const char *version_string, long *opt)
 {
-	int i;
 	static struct {
 		const char *name;
 		long opt_token;
@@ -955,7 +953,7 @@ static int get_curl_http_version_opt(const char *version_string, long *opt)
 		{ "HTTP/2", CURL_HTTP_VERSION_2 }
 	};
 
-	for (i = 0; i < ARRAY_SIZE(choice); i++) {
+	for (int i = 0; i < ARRAY_SIZE(choice); i++) {
 		if (!strcmp(version_string, choice[i].name)) {
 			*opt = choice[i].opt_token;
 			return 0;
@@ -1674,12 +1672,11 @@ static inline int needs_quote(int ch)
 static char *quote_ref_url(const char *base, const char *ref)
 {
 	struct strbuf buf = STRBUF_INIT;
-	const char *cp;
 	int ch;
 
 	end_url_with_slash(&buf, base);
 
-	for (cp = ref; (ch = *cp) != 0; cp++)
+	for (const char *cp = ref; (ch = *cp) != 0; cp++)
 		if (needs_quote(ch))
 			strbuf_addf(&buf, "%%%02x", ch);
 		else
diff --git a/ident.c b/ident.c
index cc7afdbf81..be1685ad14 100644
--- a/ident.c
+++ b/ident.c
@@ -59,13 +59,7 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
 
 static void copy_gecos(const struct passwd *w, struct strbuf *name)
 {
-	char *src;
-
-	/* Traditionally GECOS field had office phone numbers etc, separated
-	 * with commas.  Also & stands for capitalized form of the login name.
-	 */
-
-	for (src = get_gecos(w); *src && *src != ','; src++) {
+	for (char *src = get_gecos(w); *src && *src != ','; src++) {
 		int ch = *src;
 		if (ch != '&')
 			strbuf_addch(name, ch);
@@ -228,7 +222,7 @@ static int has_non_crud(const char *str)
  */
 static void strbuf_addstr_without_crud(struct strbuf *sb, const char *src)
 {
-	size_t i, len;
+	size_t len;
 	unsigned char c;
 
 	/* Remove crud from the beginning.. */
@@ -254,7 +248,7 @@ static void strbuf_addstr_without_crud(struct strbuf *sb, const char *src)
 	 * so 'len' is our maximum.
 	 */
 	strbuf_grow(sb, len);
-	for (i = 0; i < len; i++) {
+	for (size_t i = 0; i < len; i++) {
 		c = *src++;
 		switch (c) {
 		case '\n': case '<': case '>':
diff --git a/imap-send.c b/imap-send.c
index f2e1947e63..018e1715eb 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -869,7 +869,7 @@ static char hexchar(unsigned int b)
 #define ENCODED_SIZE(n) (4 * DIV_ROUND_UP((n), 3))
 static char *cram(const char *challenge_64, const char *user, const char *pass)
 {
-	int i, resp_len, encoded_len, decoded_len;
+	int resp_len, encoded_len, decoded_len;
 	unsigned char hash[16];
 	char hex[33];
 	char *response, *response_64, *challenge;
@@ -888,7 +888,7 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 		die("HMAC error");
 
 	hex[32] = 0;
-	for (i = 0; i < 16; i++) {
+	for (int i = 0; i < 16; i++) {
 		hex[2 * i] = hexchar((hash[i] >> 4) & 0xf);
 		hex[2 * i + 1] = hexchar(hash[i] & 0xf);
 	}
diff --git a/json-writer.c b/json-writer.c
index 005c820aa4..538d095bf8 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -46,9 +46,7 @@ static void append_quoted_string(struct strbuf *out, const char *in)
 
 static void indent_pretty(struct json_writer *jw)
 {
-	int k;
-
-	for (k = 0; k < jw->open_stack.len; k++)
+	for (int k = 0; k < jw->open_stack.len; k++)
 		strbuf_addstr(&jw->json, "  ");
 }
 
@@ -204,10 +202,8 @@ static void increase_indent(struct strbuf *sb,
 			    const struct json_writer *jw,
 			    int indent)
 {
-	int k;
-
 	strbuf_reset(sb);
-	for (k = 0; k < jw->json.len; k++) {
+	for (int k = 0; k < jw->json.len; k++) {
 		char ch = jw->json.buf[k];
 		strbuf_addch(sb, ch);
 		if (ch == '\n')
@@ -218,11 +214,10 @@ static void increase_indent(struct strbuf *sb,
 static void kill_indent(struct strbuf *sb,
 			const struct json_writer *jw)
 {
-	int k;
 	int eat_it = 0;
 
 	strbuf_reset(sb);
-	for (k = 0; k < jw->json.len; k++) {
+	for (int k = 0; k < jw->json.len; k++) {
 		char ch = jw->json.buf[k];
 		if (eat_it && ch == ' ')
 			continue;
@@ -355,9 +350,7 @@ void jw_array_sub_jw(struct json_writer *jw, const struct json_writer *value)
 
 void jw_array_argc_argv(struct json_writer *jw, int argc, const char **argv)
 {
-	int k;
-
-	for (k = 0; k < argc; k++)
+	for (int k = 0; k < argc; k++)
 		jw_array_string(jw, argv[k]);
 }
 
diff --git a/khash.h b/khash.h
index ff88163177..d66c1eac90 100644
--- a/khash.h
+++ b/khash.h
@@ -298,8 +298,8 @@ static const double __ac_HASH_UPPER = 0.77;
   @param  vvar  Variable to which value will be assigned
   @param  code  Block of code to execute
  */
-#define kh_foreach(h, kvar, vvar, code) { khint_t __i;		\
-	for (__i = kh_begin(h); __i != kh_end(h); ++__i) {		\
+#define kh_foreach(h, kvar, vvar, code) { 		\
+	for (khint_t __i = kh_begin(h); __i != kh_end(h); ++__i) {		\
 		if (!kh_exist(h,__i)) continue;						\
 		(kvar) = kh_key(h,__i);								\
 		(vvar) = kh_val(h,__i);								\
@@ -312,8 +312,8 @@ static const double __ac_HASH_UPPER = 0.77;
   @param  vvar  Variable to which value will be assigned
   @param  code  Block of code to execute
  */
-#define kh_foreach_value(h, vvar, code) { khint_t __i;		\
-	for (__i = kh_begin(h); __i != kh_end(h); ++__i) {		\
+#define kh_foreach_value(h, vvar, code) { 		\
+	for (khint_t __i = kh_begin(h); __i != kh_end(h); ++__i) {		\
 		if (!kh_exist(h,__i)) continue;						\
 		(vvar) = kh_val(h,__i);								\
 		code;												\
diff --git a/line-log.c b/line-log.c
index 8ff6ccb772..262c944edf 100644
--- a/line-log.c
+++ b/line-log.c
@@ -92,15 +92,13 @@ static int range_cmp(const void *_r, const void *_s)
  */
 static void range_set_check_invariants(struct range_set *rs)
 {
-	unsigned int i;
-
 	if (!rs)
 		return;
 
 	if (rs->nr)
 		assert(rs->ranges[0].start < rs->ranges[0].end);
 
-	for (i = 1; i < rs->nr; i++) {
+	for (unsigned int i = 1; i < rs->nr; i++) {
 		assert(rs->ranges[i-1].end < rs->ranges[i].start);
 		assert(rs->ranges[i].start < rs->ranges[i].end);
 	}
@@ -112,12 +110,11 @@ static void range_set_check_invariants(struct range_set *rs)
  */
 void sort_and_merge_range_set(struct range_set *rs)
 {
-	unsigned int i;
 	unsigned int o = 0; /* output cursor */
 
 	QSORT(rs->ranges, rs->nr, range_cmp);
 
-	for (i = 0; i < rs->nr; i++) {
+	for (unsigned int i = 0; i < rs->nr; i++) {
 		if (rs->ranges[i].start == rs->ranges[i].end)
 			continue;
 		if (o > 0 && rs->ranges[i].start <= rs->ranges[o-1].end) {
@@ -188,8 +185,8 @@ static void range_set_union(struct range_set *out,
 static void range_set_difference(struct range_set *out,
 				  struct range_set *a, struct range_set *b)
 {
-	unsigned int i, j =  0;
-	for (i = 0; i < a->nr; i++) {
+	unsigned int j =  0;
+	for (unsigned int i = 0; i < a->nr; i++) {
 		long start = a->ranges[i].start;
 		long end = a->ranges[i].end;
 		while (start < end) {
@@ -399,11 +396,11 @@ static void diff_ranges_filter_touched(struct diff_ranges *out,
 				       struct diff_ranges *diff,
 				       struct range_set *rs)
 {
-	unsigned int i, j = 0;
+	unsigned int j = 0;
 
 	assert(out->target.nr == 0);
 
-	for (i = 0; i < diff->target.nr; i++) {
+	for (unsigned int i = 0; i < diff->target.nr; i++) {
 		while (diff->target.ranges[i].start > rs->ranges[j].end) {
 			j++;
 			if (j == rs->nr)
@@ -428,13 +425,13 @@ static void range_set_shift_diff(struct range_set *out,
 				 struct range_set *rs,
 				 struct diff_ranges *diff)
 {
-	unsigned int i, j = 0;
+	unsigned int j = 0;
 	long offset = 0;
 	struct range *src = rs->ranges;
 	struct range *target = diff->target.ranges;
 	struct range *parent = diff->parent.ranges;
 
-	for (i = 0; i < rs->nr; i++) {
+	for (unsigned int i = 0; i < rs->nr; i++) {
 		while (j < diff->target.nr && src[i].start >= target[j].start) {
 			offset += (parent[j].end-parent[j].start)
 				- (target[j].end-target[j].start);
@@ -475,9 +472,7 @@ static struct commit *check_single_commit(struct rev_info *revs)
 {
 	struct object *commit = NULL;
 	int found = -1;
-	int i;
-
-	for (i = 0; i < revs->pending.nr; i++) {
+	for (int i = 0; i < revs->pending.nr; i++) {
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags & UNINTERESTING)
 			continue;
@@ -729,11 +724,10 @@ static struct line_log_data *lookup_line_range(struct rev_info *revs,
 					       struct commit *commit)
 {
 	struct line_log_data *ret = NULL;
-	struct line_log_data *d;
 
 	ret = lookup_decoration(&revs->line_log_data, &commit->object);
 
-	for (d = ret; d; d = d->next)
+	for (struct line_log_data *d = ret; d; d = d->next)
 		range_set_check_invariants(&d->ranges);
 
 	return ret;
@@ -758,11 +752,10 @@ static int same_paths_in_pathspec_and_range(struct pathspec *pathspec,
 static void parse_pathspec_from_ranges(struct pathspec *pathspec,
 				       struct line_log_data *range)
 {
-	struct line_log_data *r;
 	struct strvec array = STRVEC_INIT;
 	const char **paths;
 
-	for (r = range; r; r = r->next)
+	for (struct line_log_data *r = range; r; r = r->next)
 		strvec_push(&array, r->path);
 	paths = strvec_detach(&array);
 
@@ -793,11 +786,10 @@ static void move_diff_queue(struct diff_queue_struct *dst,
 
 static void filter_diffs_for_paths(struct line_log_data *range, int keep_deletions)
 {
-	int i;
 	struct diff_queue_struct outq;
 	DIFF_QUEUE_CLEAR(&outq);
 
-	for (i = 0; i < diff_queued_diff.nr; i++) {
+	for (int i = 0; i < diff_queued_diff.nr; i++) {
 		struct diff_filepair *p = diff_queued_diff.queue[i];
 		struct line_log_data *rg = NULL;
 
@@ -823,8 +815,7 @@ static void filter_diffs_for_paths(struct line_log_data *range, int keep_deletio
 
 static inline int diff_might_be_rename(void)
 {
-	int i;
-	for (i = 0; i < diff_queued_diff.nr; i++)
+	for (int i = 0; i < diff_queued_diff.nr; i++)
 		if (!DIFF_FILE_VALID(diff_queued_diff.queue[i]->one)) {
 			/* fprintf(stderr, "diff_might_be_rename found creation of: %s\n", */
 			/* 	diff_queued_diff.queue[i]->two->path); */
@@ -911,7 +902,7 @@ static char *output_prefix(struct diff_options *opt)
 
 static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *range)
 {
-	unsigned int i, j = 0;
+	unsigned int j = 0;
 	long p_lines, t_lines;
 	unsigned long *p_ends = NULL, *t_ends = NULL;
 	struct diff_filepair *pair = range->pair;
@@ -939,7 +930,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 	       pair->one->oid_valid ? pair->one->path : "/dev/null",
 	       c_reset);
 	fprintf(opt->file, "%s%s+++ b/%s%s\n", prefix, c_meta, pair->two->path, c_reset);
-	for (i = 0; i < range->ranges.nr; i++) {
+	for (unsigned int i = 0; i < range->ranges.nr; i++) {
 		long p_start, p_end;
 		long t_start = range->ranges.ranges[i].start;
 		long t_end = range->ranges.ranges[i].end;
@@ -1100,11 +1091,11 @@ static int process_all_files(struct line_log_data **range_out,
 			     struct diff_queue_struct *queue,
 			     struct line_log_data *range)
 {
-	int i, changed = 0;
+	int changed = 0;
 
 	*range_out = line_log_data_copy(range);
 
-	for (i = 0; i < queue->nr; i++) {
+	for (int i = 0; i < queue->nr; i++) {
 		struct diff_ranges *pairdiff = NULL;
 		struct diff_filepair *pair = queue->queue[i];
 		if (process_diff_filepair(rev, pair, *range_out, &pairdiff)) {
diff --git a/linear-assignment.c b/linear-assignment.c
index 5416cbcf40..a8ccdfd84a 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -17,7 +17,7 @@ void compute_assignment(int column_count, int row_count, int *cost,
 {
 	int *v, *d;
 	int *free_row, free_count = 0, saved_free_count, *pred, *col;
-	int i, j, phase;
+	int i, j;
 
 	if (column_count < 2) {
 		memset(column2row, 0, sizeof(int) * column_count);
@@ -73,7 +73,7 @@ void compute_assignment(int column_count, int row_count, int *cost,
 	}
 
 	/* augmenting row reduction */
-	for (phase = 0; phase < 2; phase++) {
+	for (int phase = 0; phase < 2; phase++) {
 		int k = 0;
 
 		saved_free_count = free_count;
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c5f363ca6f..2f34279a37 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -158,7 +158,6 @@ static int parse_combine_filter(
 	struct strbuf *errbuf)
 {
 	struct strbuf **subspecs = strbuf_split_str(arg, '+', 0);
-	size_t sub;
 	int result = 0;
 
 	if (!subspecs[0]) {
@@ -167,7 +166,7 @@ static int parse_combine_filter(
 		goto cleanup;
 	}
 
-	for (sub = 0; subspecs[sub] && !result; sub++) {
+	for (size_t sub = 0; subspecs[sub] && !result; sub++) {
 		if (subspecs[sub + 1]) {
 			/*
 			 * This is not the last subspec. Remove trailing "+" so
@@ -317,13 +316,11 @@ const char *expand_list_objects_filter_spec(
 void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options)
 {
-	size_t sub;
-
 	if (!filter_options)
 		return;
 	strbuf_release(&filter_options->filter_spec);
 	free(filter_options->sparse_oid_name);
-	for (sub = 0; sub < filter_options->sub_nr; sub++)
+	for (size_t sub = 0; sub < filter_options->sub_nr; sub++)
 		list_objects_filter_release(&filter_options->sub[sub]);
 	free(filter_options->sub);
 	list_objects_filter_init(filter_options);
@@ -395,8 +392,6 @@ void list_objects_filter_copy(
 	struct list_objects_filter_options *dest,
 	const struct list_objects_filter_options *src)
 {
-	int i;
-
 	/* Copy everything. We will overwrite the pointers shortly. */
 	memcpy(dest, src, sizeof(struct list_objects_filter_options));
 
@@ -405,7 +400,7 @@ void list_objects_filter_copy(
 	dest->sparse_oid_name = xstrdup_or_null(src->sparse_oid_name);
 
 	ALLOC_ARRAY(dest->sub, dest->sub_alloc);
-	for (i = 0; i < src->sub_nr; i++)
+	for (int i = 0; i < src->sub_nr; i++)
 		list_objects_filter_copy(&dest->sub[i], &src->sub[i]);
 }
 
diff --git a/list-objects-filter.c b/list-objects-filter.c
index da287cc8e0..ff0563703a 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -680,9 +680,7 @@ static enum list_objects_filter_result filter_combine(
 	struct combine_filter_data *d = filter_data;
 	enum list_objects_filter_result combined_result =
 		LOFR_DO_SHOW | LOFR_MARK_SEEN | LOFR_SKIP_TREE;
-	size_t sub;
-
-	for (sub = 0; sub < d->nr; sub++) {
+	for (size_t sub = 0; sub < d->nr; sub++) {
 		enum list_objects_filter_result sub_result = process_subfilter(
 			r, filter_situation, obj, pathname, filename,
 			&d->sub[sub]);
@@ -700,8 +698,7 @@ static enum list_objects_filter_result filter_combine(
 static void filter_combine__free(void *filter_data)
 {
 	struct combine_filter_data *d = filter_data;
-	size_t sub;
-	for (sub = 0; sub < d->nr; sub++) {
+	for (size_t sub = 0; sub < d->nr; sub++) {
 		list_objects_filter__free(d->sub[sub].filter);
 		oidset_clear(&d->sub[sub].seen);
 		if (d->sub[sub].omits.set.size)
@@ -725,9 +722,7 @@ static void filter_combine__finalize_omits(
 	void *filter_data)
 {
 	struct combine_filter_data *d = filter_data;
-	size_t sub;
-
-	for (sub = 0; sub < d->nr; sub++) {
+	for (size_t sub = 0; sub < d->nr; sub++) {
 		add_all(omits, &d->sub[sub].omits);
 		oidset_clear(&d->sub[sub].omits);
 	}
@@ -738,11 +733,10 @@ static void filter_combine__init(
 	struct filter* filter)
 {
 	struct combine_filter_data *d = xcalloc(1, sizeof(*d));
-	size_t sub;
 
 	d->nr = filter_options->sub_nr;
 	CALLOC_ARRAY(d->sub, d->nr);
-	for (sub = 0; sub < d->nr; sub++)
+	for (size_t sub = 0; sub < d->nr; sub++)
 		d->sub[sub].filter = list_objects_filter__init(
 			filter->omits ? &d->sub[sub].omits : NULL,
 			&filter_options->sub[sub]);
diff --git a/list-objects.c b/list-objects.c
index f39b68faf5..2934a8e6ad 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -233,9 +233,7 @@ static void mark_edge_parents_uninteresting(struct commit *commit,
 					    struct rev_info *revs,
 					    show_edge_fn show_edge)
 {
-	struct commit_list *parents;
-
-	for (parents = commit->parents; parents; parents = parents->next) {
+	for (struct commit_list *parents = commit->parents; parents; parents = parents->next) {
 		struct commit *parent = parents->item;
 		if (!(parent->object.flags & UNINTERESTING))
 			continue;
@@ -253,9 +251,7 @@ static void add_edge_parents(struct commit *commit,
 			     show_edge_fn show_edge,
 			     struct oidset *set)
 {
-	struct commit_list *parents;
-
-	for (parents = commit->parents; parents; parents = parents->next) {
+	for (struct commit_list *parents = commit->parents; parents; parents = parents->next) {
 		struct commit *parent = parents->item;
 		struct tree *tree = repo_get_commit_tree(the_repository,
 							 parent);
@@ -280,14 +276,13 @@ void mark_edges_uninteresting(struct rev_info *revs,
 			      show_edge_fn show_edge,
 			      int sparse)
 {
-	struct commit_list *list;
 	int i;
 
 	if (sparse) {
 		struct oidset set;
 		oidset_init(&set, 16);
 
-		for (list = revs->commits; list; list = list->next) {
+		for (struct commit_list *list = revs->commits; list; list = list->next) {
 			struct commit *commit = list->item;
 			struct tree *tree = repo_get_commit_tree(the_repository,
 								 commit);
@@ -302,7 +297,7 @@ void mark_edges_uninteresting(struct rev_info *revs,
 		mark_trees_uninteresting_sparse(revs->repo, &set);
 		oidset_clear(&set);
 	} else {
-		for (list = revs->commits; list; list = list->next) {
+		for (struct commit_list *list = revs->commits; list; list = list->next) {
 			struct commit *commit = list->item;
 			if (commit->object.flags & UNINTERESTING) {
 				mark_tree_uninteresting(revs->repo,
@@ -341,11 +336,9 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 static void traverse_non_commits(struct traversal_context *ctx,
 				 struct strbuf *base)
 {
-	int i;
-
 	assert(base->len == 0);
 
-	for (i = 0; i < ctx->revs->pending.nr; i++) {
+	for (int i = 0; i < ctx->revs->pending.nr; i++) {
 		struct object_array_entry *pending = ctx->revs->pending.objects + i;
 		struct object *obj = pending->item;
 		const char *name = pending->name;
diff --git a/log-tree.c b/log-tree.c
index 337b9334cd..8b7468707d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -147,7 +147,6 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			      int flags UNUSED,
 			      void *cb_data)
 {
-	int i;
 	struct object *obj;
 	enum object_type objtype;
 	enum decoration_type deco_type = DECORATION_NONE;
@@ -177,7 +176,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 		return 0;
 	obj = lookup_object_by_type(the_repository, oid, objtype);
 
-	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
+	for (int i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
 		struct ref_namespace_info *info = &ref_namespace[i];
 
 		if (!info->decoration)
@@ -240,8 +239,7 @@ void load_ref_decorations(struct decoration_filter *filter, int flags)
 
 static void show_parents(struct commit *commit, int abbrev, FILE *file)
 {
-	struct commit_list *p;
-	for (p = commit->parents; p ; p = p->next) {
+	for (struct commit_list *p = commit->parents; p; p = p->next) {
 		struct commit *parent = p->item;
 		fprintf(file, " %s",
 			repo_find_unique_abbrev(the_repository, &parent->object.oid, abbrev));
@@ -487,10 +485,10 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->ref_message_ids && opt->ref_message_ids->nr > 0) {
-		int i, n;
+		int n;
 		n = opt->ref_message_ids->nr;
 		fprintf(opt->diffopt.file, "In-Reply-To: <%s>\n", opt->ref_message_ids->items[n-1].string);
-		for (i = 0; i < n; i++)
+		for (int i = 0; i < n; i++)
 			fprintf(opt->diffopt.file, "%s<%s>\n", (i > 0 ? "\t" : "References: "),
 			       opt->ref_message_ids->items[i].string);
 		graph_show_oneline(opt->graph);
diff --git a/ls-refs.c b/ls-refs.c
index 819cbefee3..35453a5f8b 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -51,12 +51,10 @@ static enum {
  */
 static int ref_match(const struct strvec *prefixes, const char *refname)
 {
-	int i;
-
 	if (!prefixes->nr)
 		return 1; /* no restriction */
 
-	for (i = 0; i < prefixes->nr; i++) {
+	for (int i = 0; i < prefixes->nr; i++) {
 		const char *prefix = prefixes->v[i];
 
 		if (starts_with(refname, prefix))
diff --git a/mailinfo.c b/mailinfo.c
index 94b9b0abf2..f37de63ecd 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -8,8 +8,8 @@
 
 static void cleanup_space(struct strbuf *sb)
 {
-	size_t pos, cnt;
-	for (pos = 0; pos < sb->len; pos++) {
+	size_t cnt;
+	for (size_t pos = 0; pos < sb->len; pos++) {
 		if (isspace(sb->buf[pos])) {
 			sb->buf[pos] = ' ';
 			for (cnt = 0; isspace(sb->buf[pos + cnt + 1]); cnt++);
@@ -579,11 +579,11 @@ static int check_header(struct mailinfo *mi,
 			const struct strbuf *line,
 			struct strbuf *hdr_data[], int overwrite)
 {
-	int i, ret = 0;
+	int ret = 0;
 	struct strbuf sb = STRBUF_INIT;
 
 	/* search for the interesting parts */
-	for (i = 0; header[i]; i++) {
+	for (int i = 0; header[i]; i++) {
 		if ((!hdr_data[i] || overwrite) &&
 		    parse_header(line, header[i], mi, &sb)) {
 			handle_header(&hdr_data[i], &sb);
@@ -623,9 +623,8 @@ static int check_header(struct mailinfo *mi,
 static int is_inbody_header(const struct mailinfo *mi,
 			    const struct strbuf *line)
 {
-	int i;
 	const char *val;
-	for (i = 0; header[i]; i++)
+	for (int i = 0; header[i]; i++)
 		if (!mi->s_hdr_data[i] && skip_header(line, header[i], &val))
 			return 1;
 	return 0;
@@ -690,12 +689,11 @@ static inline int patchbreak(const struct strbuf *line)
 
 static int is_scissors_line(const char *line)
 {
-	const char *c;
 	int scissors = 0, gap = 0;
 	const char *first_nonblank = NULL, *last_nonblank = NULL;
 	int visible, perforation = 0, in_perforation = 0;
 
-	for (c = line; *c; c++) {
+	for (const char *c = line; *c; c++) {
 		if (isspace(*c)) {
 			if (in_perforation) {
 				perforation++;
@@ -771,8 +769,7 @@ static int check_inbody_header(struct mailinfo *mi, const struct strbuf *line)
 	if (starts_with(line->buf, ">From") && isspace(line->buf[5]))
 		return is_format_patch_separator(line->buf + 1, line->len - 1);
 	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
-		int i;
-		for (i = 0; header[i]; i++)
+		for (int i = 0; header[i]; i++)
 			if (!strcmp("Subject", header[i])) {
 				handle_header(&mi->s_hdr_data[i], line);
 				return 1;
@@ -815,8 +812,6 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		return 0; /* mi->input_error already set */
 
 	if (mi->use_scissors && is_scissors_line(line->buf)) {
-		int i;
-
 		strbuf_setlen(&mi->log_message, 0);
 		mi->header_stage = 1;
 
@@ -824,7 +819,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		 * We may have already read "secondary headers"; purge
 		 * them to give ourselves a clean restart.
 		 */
-		for (i = 0; header[i]; i++) {
+		for (int i = 0; header[i]; i++) {
 			if (mi->s_hdr_data[i])
 				strbuf_release(mi->s_hdr_data[i]);
 			FREE_AND_NULL(mi->s_hdr_data[i]);
@@ -1153,9 +1148,7 @@ static void output_header_lines(FILE *fout, const char *hdr, const struct strbuf
 static void handle_info(struct mailinfo *mi)
 {
 	struct strbuf *hdr;
-	int i;
-
-	for (i = 0; header[i]; i++) {
+	for (int i = 0; header[i]; i++) {
 		/* only print inbody headers if we output a patch file */
 		if (mi->patch_lines && mi->s_hdr_data[i])
 			hdr = mi->s_hdr_data[i];
diff --git a/mem-pool.c b/mem-pool.c
index c7d6256020..24ba10f79e 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -135,10 +135,7 @@ char *mem_pool_strndup(struct mem_pool *pool, const char *str, size_t len)
 
 int mem_pool_contains(struct mem_pool *pool, void *mem)
 {
-	struct mp_block *p;
-
-	/* Check if memory is allocated in a block */
-	for (p = pool->mp_block; p; p = p->next_block)
+	for (struct mp_block *p = pool->mp_block; p; p = p->next_block)
 		if ((mem >= ((void *)p->space)) &&
 		    (mem < ((void *)p->end)))
 			return 1;
diff --git a/merge-ll.c b/merge-ll.c
index 61e0ae5398..09fca494a5 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -195,7 +195,7 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 	struct strbuf cmd = STRBUF_INIT;
 	const char *format = fn->cmdline;
 	struct child_process child = CHILD_PROCESS_INIT;
-	int status, fd, i;
+	int status, fd;
 	struct stat st;
 	enum ll_merge_result ret;
 	assert(opts);
@@ -249,7 +249,7 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
  close_bad:
 	close(fd);
  bad:
-	for (i = 0; i < 3; i++)
+	for (int i = 0; i < 3; i++)
 		unlink_or_warn(temp[i]);
 	strbuf_release(&cmd);
 	if (!status)
@@ -351,9 +351,7 @@ static void initialize_ll_merge(void)
 
 static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr)
 {
-	struct ll_merge_driver *fn;
 	const char *name;
-	int i;
 
 	initialize_ll_merge();
 
@@ -370,11 +368,11 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 	else
 		name = merge_attr;
 
-	for (fn = ll_user_merge; fn; fn = fn->next)
+	for (struct ll_merge_driver *fn = ll_user_merge; fn; fn = fn->next)
 		if (!strcmp(fn->name, name))
 			return fn;
 
-	for (i = 0; i < ARRAY_SIZE(ll_merge_drv); i++)
+	for (int i = 0; i < ARRAY_SIZE(ll_merge_drv); i++)
 		if (!strcmp(ll_merge_drv[i].name, name))
 			return &ll_merge_drv[i];
 
diff --git a/merge-ort.c b/merge-ort.c
index 8617babee4..c1dce9e196 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -937,7 +937,7 @@ static int traverse_trees_wrapper(struct index_state *istate,
 				  struct tree_desc *t,
 				  struct traverse_info *info)
 {
-	int ret, i, old_offset;
+	int ret, old_offset;
 	traverse_callback_t old_fn;
 	char *old_callback_data_traverse_path;
 	struct merge_options *opt = info->data;
@@ -957,7 +957,7 @@ static int traverse_trees_wrapper(struct index_state *istate,
 
 	info->traverse_path = renames->callback_data_traverse_path;
 	info->fn = old_fn;
-	for (i = old_offset; i < renames->callback_data_nr; ++i) {
+	for (int i = old_offset; i < renames->callback_data_nr; ++i) {
 		info->fn(n,
 			 renames->callback_data[i].mask,
 			 renames->callback_data[i].dirmask,
@@ -1003,11 +1003,10 @@ static void setup_path_info(struct merge_options *opt,
 		oidcpy(&mi->result.oid, &merged_version->oid);
 		mi->is_null = !!is_null;
 	} else {
-		int i;
 		struct conflict_info *ci;
 
 		ASSIGN_AND_VERIFY_CI(ci, mi);
-		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+		for (int i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
 			ci->pathnames[i] = fullpath;
 			ci->stages[i].mode = names[i].mode;
 			oidcpy(&ci->stages[i].oid, &names[i].oid);
@@ -1473,11 +1472,11 @@ static int handle_deferred_entries(struct merge_options *opt,
 	struct rename_info *renames = &opt->priv->renames;
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
-	int side, ret = 0;
+	int ret = 0;
 	int path_count_before, path_count_after = 0;
 
 	path_count_before = strmap_get_size(&opt->priv->paths);
-	for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
+	for (int side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
 		unsigned optimization_okay = 1;
 		struct strintmap copy;
 
@@ -1681,7 +1680,7 @@ static int find_first_merges(struct repository *repo,
 			     struct commit *b,
 			     struct object_array *result)
 {
-	int i, j;
+	int j;
 	struct object_array merges = OBJECT_ARRAY_INIT;
 	struct commit *commit;
 	int contains_another;
@@ -1717,7 +1716,7 @@ static int find_first_merges(struct repository *repo,
 	 * merges that contain another found merge and save them in
 	 * result.
 	 */
-	for (i = 0; i < merges.nr; i++) {
+	for (int i = 0; i < merges.nr; i++) {
 		struct commit *m1 = (struct commit *) merges.objects[i].item;
 
 		contains_another = 0;
@@ -1922,11 +1921,11 @@ static void initialize_attr_index(struct merge_options *opt)
 				ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 		get_stream_filter(attr_index, GITATTRIBUTES_FILE, &ce->oid);
 	} else {
-		int stage, len;
+		int len;
 		struct conflict_info *ci;
 
 		ASSIGN_AND_VERIFY_CI(ci, mi);
-		for (stage = 0; stage < 3; stage++) {
+		for (int stage = 0; stage < 3; stage++) {
 			unsigned stage_mask = (1 << stage);
 
 			if (!(ci->filemask & stage_mask))
@@ -2349,14 +2348,13 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
 	struct rename_info *renames = &opt->priv->renames;
 	struct strmap *side1_dir_renames = &renames->dir_renames[MERGE_SIDE1];
 	struct strmap *side2_dir_renames = &renames->dir_renames[MERGE_SIDE2];
-	int i;
 
 	strmap_for_each_entry(side1_dir_renames, &iter, entry) {
 		if (strmap_contains(side2_dir_renames, entry->key))
 			string_list_append(&duplicated, entry->key);
 	}
 
-	for (i = 0; i < duplicated.nr; i++) {
+	for (int i = 0; i < duplicated.nr; i++) {
 		strmap_remove(side1_dir_renames, duplicated.items[i].string, 0);
 		strmap_remove(side2_dir_renames, duplicated.items[i].string, 0);
 	}
@@ -2384,8 +2382,6 @@ static void compute_collisions(struct strmap *collisions,
 			       struct strmap *dir_renames,
 			       struct diff_queue_struct *pairs)
 {
-	int i;
-
 	strmap_init_with_options(collisions, NULL, 0);
 	if (strmap_empty(dir_renames))
 		return;
@@ -2406,7 +2402,7 @@ static void compute_collisions(struct strmap *collisions,
 	 *
 	 * See testcases 9e and all of section 5 from t6043 for examples.
 	 */
-	for (i = 0; i < pairs->nr; ++i) {
+	for (int i = 0; i < pairs->nr; ++i) {
 		struct strmap_entry *rename_info;
 		struct collision_info *collision_info;
 		char *new_path;
@@ -2733,9 +2729,9 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 static int process_renames(struct merge_options *opt,
 			   struct diff_queue_struct *renames)
 {
-	int clean_merge = 1, i;
+	int clean_merge = 1;
 
-	for (i = 0; i < renames->nr; ++i) {
+	for (int i = 0; i < renames->nr; ++i) {
 		const char *oldpath = NULL, *newpath;
 		struct diff_filepair *pair = renames->queue[i];
 		struct conflict_info *oldinfo = NULL, *newinfo = NULL;
@@ -3058,14 +3054,9 @@ static inline int possible_renames(struct rename_info *renames)
 
 static void resolve_diffpair_statuses(struct diff_queue_struct *q)
 {
-	/*
-	 * A simplified version of diff_resolve_rename_copy(); would probably
-	 * just use that function but it's static...
-	 */
-	int i;
 	struct diff_filepair *p;
 
-	for (i = 0; i < q->nr; ++i) {
+	for (int i = 0; i < q->nr; ++i) {
 		p = q->queue[i];
 		p->status = 0; /* undecided */
 		if (!DIFF_FILE_VALID(p->one))
@@ -3274,13 +3265,13 @@ static int collect_renames(struct merge_options *opt,
 			   struct strmap *dir_renames_for_side,
 			   struct strmap *rename_exclusions)
 {
-	int i, clean = 1;
+	int clean = 1;
 	struct diff_queue_struct *side_pairs;
 	struct rename_info *renames = &opt->priv->renames;
 
 	side_pairs = &renames->pairs[side_index];
 
-	for (i = 0; i < side_pairs->nr; ++i) {
+	for (int i = 0; i < side_pairs->nr; ++i) {
 		struct diff_filepair *p = side_pairs->queue[i];
 		char *new_path; /* non-NULL only with directory renames */
 
@@ -3342,11 +3333,11 @@ static int detect_and_process_renames(struct merge_options *opt)
 		renames->redo_after_renames = 0;
 	}
 	if (renames->redo_after_renames && detection_run) {
-		int i, side;
+		int i;
 		struct diff_filepair *p;
 
 		/* Cache the renames, we found */
-		for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
+		for (int side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
 			for (i = 0; i < renames->pairs[side].nr; ++i) {
 				p = renames->pairs[side].queue[i];
 				possibly_cache_new_pair(renames, p, side, NULL);
@@ -3852,8 +3843,6 @@ static int process_entry(struct merge_options *opt,
 	}
 
 	if (ci->df_conflict && ci->merged.result.mode == 0) {
-		int i;
-
 		/*
 		 * directory no longer in the way, but we do have a file we
 		 * need to place here so we need to clean away the "directory
@@ -3866,7 +3855,7 @@ static int process_entry(struct merge_options *opt,
 		/* and we want to zero out any directory-related entries */
 		ci->match_mask = (ci->match_mask & ~ci->dirmask);
 		ci->dirmask = 0;
-		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+		for (int i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
 			if (ci->filemask & (1 << i))
 				continue;
 			ci->stages[i].mode = 0;
@@ -3882,7 +3871,6 @@ static int process_entry(struct merge_options *opt,
 		struct conflict_info *new_ci;
 		const char *branch;
 		const char *old_path = path;
-		int i;
 
 		assert(ci->merged.result.mode == S_IFDIR);
 
@@ -3912,7 +3900,7 @@ static int process_entry(struct merge_options *opt,
 		memcpy(new_ci, ci, sizeof(*ci));
 		new_ci->match_mask = (new_ci->match_mask & ~new_ci->dirmask);
 		new_ci->dirmask = 0;
-		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+		for (int i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
 			if (new_ci->filemask & (1 << i))
 				continue;
 			/* zero out any entries related to directories */
@@ -4201,13 +4189,12 @@ static int process_entry(struct merge_options *opt,
 static void prefetch_for_content_merges(struct merge_options *opt,
 					struct string_list *plist)
 {
-	struct string_list_item *e;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
 	if (opt->repo != the_repository || !repo_has_promisor_remote(the_repository))
 		return;
 
-	for (e = &plist->items[plist->nr-1]; e >= plist->items; --e) {
+	for (struct string_list_item *e = &plist->items[plist->nr - 1]; e >= plist->items; --e) {
 		/* char *path = e->string; */
 		struct conflict_info *ci = e->util;
 		int i;
@@ -4252,7 +4239,6 @@ static int process_entries(struct merge_options *opt,
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
 	struct string_list plist = STRING_LIST_INIT_NODUP;
-	struct string_list_item *entry;
 	struct directory_versions dir_metadata = { STRING_LIST_INIT_NODUP,
 						   STRING_LIST_INIT_NODUP,
 						   NULL, 0 };
@@ -4294,7 +4280,7 @@ static int process_entries(struct merge_options *opt,
 	 */
 	trace2_region_enter("merge", "processing", opt->repo);
 	prefetch_for_content_merges(opt, &plist);
-	for (entry = &plist.items[plist.nr-1]; entry >= plist.items; --entry) {
+	for (struct string_list_item *entry = &plist.items[plist.nr - 1]; entry >= plist.items; --entry) {
 		char *path = entry->string;
 		/*
 		 * NOTE: mi may actually be a pointer to a conflict_info, but
@@ -5001,7 +4987,6 @@ static void merge_ort_internal(struct merge_options *opt,
 			       struct commit *h2,
 			       struct merge_result *result)
 {
-	struct commit *next;
 	struct commit *merged_merge_bases;
 	const char *ancestor_name;
 	struct strbuf merge_base_abbrev = STRBUF_INIT;
@@ -5030,8 +5015,7 @@ static void merge_ort_internal(struct merge_options *opt,
 		ancestor_name = merge_base_abbrev.buf;
 	}
 
-	for (next = pop_commit(&merge_bases); next;
-	     next = pop_commit(&merge_bases)) {
+	for (struct commit *next = pop_commit(&merge_bases); next; next = pop_commit(&merge_bases)) {
 		const char *saved_b1, *saved_b2;
 		struct commit *prev = merged_merge_bases;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index a0c3e7a2d9..0786d7e32a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -527,13 +527,12 @@ static struct stage_data *insert_stage_data(struct repository *r,
 static struct string_list *get_unmerged(struct index_state *istate)
 {
 	struct string_list *unmerged = xmalloc(sizeof(struct string_list));
-	int i;
 
 	string_list_init_dup(unmerged);
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(istate);
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct string_list_item *item;
 		struct stage_data *e;
 		const struct cache_entry *ce = istate->cache[i];
@@ -881,11 +880,11 @@ static int was_dirty(struct merge_options *opt, const char *path)
 
 static int make_room_for_path(struct merge_options *opt, const char *path)
 {
-	int status, i;
+	int status;
 	const char *msg = _("failed to create path '%s'%s");
 
 	/* Unlink any D/F conflict files that are in the way */
-	for (i = 0; i < opt->priv->df_conflict_file_set.nr; i++) {
+	for (int i = 0; i < opt->priv->df_conflict_file_set.nr; i++) {
 		const char *df_path = opt->priv->df_conflict_file_set.items[i].string;
 		size_t pathlen = strlen(path);
 		size_t df_pathlen = strlen(df_path);
@@ -1112,7 +1111,7 @@ static int find_first_merges(struct repository *repo,
 			     struct object_array *result, const char *path,
 			     struct commit *a, struct commit *b)
 {
-	int i, j;
+	int j;
 	struct object_array merges = OBJECT_ARRAY_INIT;
 	struct commit *commit;
 	int contains_another;
@@ -1148,7 +1147,7 @@ static int find_first_merges(struct repository *repo,
 	 * merges that contain another found merge and save them in
 	 * result.
 	 */
-	for (i = 0; i < merges.nr; i++) {
+	for (int i = 0; i < merges.nr; i++) {
 		struct commit *m1 = (struct commit *) merges.objects[i].item;
 
 		contains_another = 0;
@@ -2070,10 +2069,9 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 static void remove_hashmap_entries(struct hashmap *dir_renames,
 				   struct string_list *items_to_remove)
 {
-	int i;
 	struct dir_rename_entry *entry;
 
-	for (i = 0; i < items_to_remove->nr; i++) {
+	for (int i = 0; i < items_to_remove->nr; i++) {
 		entry = items_to_remove->items[i].util;
 		hashmap_remove(dir_renames, &entry->ent, NULL);
 	}
@@ -2386,8 +2384,6 @@ static void compute_collisions(struct hashmap *collisions,
 			       struct hashmap *dir_renames,
 			       struct diff_queue_struct *pairs)
 {
-	int i;
-
 	/*
 	 * Multiple files can be mapped to the same path due to directory
 	 * renames done by the other side of history.  Since that other
@@ -2406,7 +2402,7 @@ static void compute_collisions(struct hashmap *collisions,
 	 */
 	collision_init(collisions);
 
-	for (i = 0; i < pairs->nr; ++i) {
+	for (int i = 0; i < pairs->nr; ++i) {
 		struct dir_rename_entry *dir_rename_ent;
 		struct collision_entry *collision_ent;
 		char *new_path;
@@ -2627,7 +2623,6 @@ static struct string_list *get_renames(struct merge_options *opt,
 				       struct string_list *entries,
 				       int *clean_merge)
 {
-	int i;
 	struct hashmap collisions;
 	struct hashmap_iter iter;
 	struct collision_entry *e;
@@ -2636,7 +2631,7 @@ static struct string_list *get_renames(struct merge_options *opt,
 	compute_collisions(&collisions, dir_renames, pairs);
 	CALLOC_ARRAY(renames, 1);
 
-	for (i = 0; i < pairs->nr; ++i) {
+	for (int i = 0; i < pairs->nr; ++i) {
 		struct string_list_item *item;
 		struct rename *re;
 		struct diff_filepair *pair = pairs->queue[i];
@@ -3000,12 +2995,11 @@ static int detect_and_process_renames(struct merge_options *opt,
 static void final_cleanup_rename(struct string_list *rename)
 {
 	const struct rename *re;
-	int i;
 
 	if (!rename)
 		return;
 
-	for (i = 0; i < rename->nr; i++) {
+	for (int i = 0; i < rename->nr; i++) {
 		re = rename->items[i].util;
 		diff_free_filepair(re->pair);
 	}
@@ -3821,8 +3815,7 @@ int merge_recursive_generic(struct merge_options *opt,
 	struct commit_list *ca = NULL;
 
 	if (merge_bases) {
-		int i;
-		for (i = 0; i < num_merge_bases; ++i) {
+		for (int i = 0; i < num_merge_bases; ++i) {
 			struct commit *base;
 			if (!(base = get_ref(opt->repo, merge_bases[i],
 					     oid_to_hex(merge_bases[i]))))
diff --git a/merge.c b/merge.c
index ca89b312d1..d0a2f1b6ea 100644
--- a/merge.c
+++ b/merge.c
@@ -23,11 +23,11 @@ int try_merge_command(struct repository *r,
 		      const char *head_arg, struct commit_list *remotes)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	int i, ret;
+	int ret;
 	struct commit_list *j;
 
 	strvec_pushf(&cmd.args, "merge-%s", strategy);
-	for (i = 0; i < xopts_nr; i++)
+	for (int i = 0; i < xopts_nr; i++)
 		strvec_pushf(&cmd.args, "--%s", xopts[i]);
 	for (j = common; j; j = j->next)
 		strvec_push(&cmd.args, merge_argument(j->item));
@@ -55,7 +55,7 @@ int checkout_fast_forward(struct repository *r,
 	struct tree *trees[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
 	struct tree_desc t[MAX_UNPACK_TREES];
-	int i, nr_trees = 0;
+	int nr_trees = 0;
 	struct lock_file lock_file = LOCK_INIT;
 
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
@@ -76,7 +76,7 @@ int checkout_fast_forward(struct repository *r,
 		rollback_lock_file(&lock_file);
 		return -1;
 	}
-	for (i = 0; i < nr_trees; i++) {
+	for (int i = 0; i < nr_trees; i++) {
 		parse_tree(trees[i]);
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
diff --git a/midx.c b/midx.c
index 85e1c2cd12..ca979b2f0b 100644
--- a/midx.c
+++ b/midx.c
@@ -67,7 +67,6 @@ void get_midx_rev_filename(struct strbuf *out, struct multi_pack_index *m)
 static int midx_read_oid_fanout(const unsigned char *chunk_start,
 				size_t chunk_size, void *data)
 {
-	int i;
 	struct multi_pack_index *m = data;
 	m->chunk_oid_fanout = (uint32_t *)chunk_start;
 
@@ -75,7 +74,7 @@ static int midx_read_oid_fanout(const unsigned char *chunk_start,
 		error(_("multi-pack-index OID fanout is of the wrong size"));
 		return 1;
 	}
-	for (i = 0; i < 255; i++) {
+	for (int i = 0; i < 255; i++) {
 		uint32_t oid_fanout1 = ntohl(m->chunk_oid_fanout[i]);
 		uint32_t oid_fanout2 = ntohl(m->chunk_oid_fanout[i+1]);
 
@@ -124,7 +123,6 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	void *midx_map = NULL;
 	uint32_t hash_version;
 	struct strbuf midx_name = STRBUF_INIT;
-	uint32_t i;
 	const char *cur_pack_name;
 	struct chunkfile *cf = NULL;
 
@@ -210,7 +208,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	CALLOC_ARRAY(m->packs, m->num_packs);
 
 	cur_pack_name = (const char *)m->chunk_pack_names;
-	for (i = 0; i < m->num_packs; i++) {
+	for (uint32_t i = 0; i < m->num_packs; i++) {
 		const char *end;
 		size_t avail = m->chunk_pack_names_len -
 				(cur_pack_name - (const char *)m->chunk_pack_names);
@@ -247,8 +245,6 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 void close_midx(struct multi_pack_index *m)
 {
-	uint32_t i;
-
 	if (!m)
 		return;
 
@@ -256,7 +252,7 @@ void close_midx(struct multi_pack_index *m)
 
 	munmap((unsigned char *)m->data, m->data_len);
 
-	for (i = 0; i < m->num_packs; i++) {
+	for (uint32_t i = 0; i < m->num_packs; i++) {
 		if (m->packs[i])
 			m->packs[i]->multi_pack_index = 0;
 	}
@@ -483,13 +479,12 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local)
 {
 	struct multi_pack_index *m;
-	struct multi_pack_index *m_search;
 
 	prepare_repo_settings(r);
 	if (!r->settings.core_multi_pack_index)
 		return 0;
 
-	for (m_search = r->objects->multi_pack_index; m_search; m_search = m_search->next)
+	for (struct multi_pack_index *m_search = r->objects->multi_pack_index; m_search; m_search = m_search->next)
 		if (!strcmp(object_dir, m_search->object_dir))
 			return 1;
 
@@ -721,13 +716,12 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 					int preferred_pack)
 {
 	uint32_t start = 0, end;
-	uint32_t cur_object;
 
 	if (cur_fanout)
 		start = ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
 	end = ntohl(m->chunk_oid_fanout[cur_fanout]);
 
-	for (cur_object = start; cur_object < end; cur_object++) {
+	for (uint32_t cur_object = start; cur_object < end; cur_object++) {
 		if ((preferred_pack > -1) &&
 		    (preferred_pack == nth_midxed_pack_int_id(m, cur_object))) {
 			/*
@@ -754,13 +748,12 @@ static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
 {
 	struct packed_git *pack = info[cur_pack].p;
 	uint32_t start = 0, end;
-	uint32_t cur_object;
 
 	if (cur_fanout)
 		start = get_pack_fanout(pack, cur_fanout - 1);
 	end = get_pack_fanout(pack, cur_fanout);
 
-	for (cur_object = start; cur_object < end; cur_object++) {
+	for (uint32_t cur_object = start; cur_object < end; cur_object++) {
 		midx_fanout_grow(fanout, fanout->nr + 1);
 		fill_pack_entry(cur_pack,
 				info[cur_pack].p,
@@ -788,7 +781,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 						  size_t *nr_objects,
 						  int preferred_pack)
 {
-	uint32_t cur_fanout, cur_pack, cur_object;
+	uint32_t cur_pack, cur_object;
 	size_t alloc_objects, total_objects = 0;
 	struct midx_fanout fanout = { 0 };
 	struct pack_midx_entry *deduplicated_entries = NULL;
@@ -809,7 +802,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 	ALLOC_ARRAY(deduplicated_entries, alloc_objects);
 	*nr_objects = 0;
 
-	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
+	for (uint32_t cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		fanout.nr = 0;
 
 		if (m)
@@ -888,9 +881,7 @@ static int write_midx_pack_names(struct hashfile *f, void *data)
 static int write_midx_bitmapped_packs(struct hashfile *f, void *data)
 {
 	struct write_midx_context *ctx = data;
-	size_t i;
-
-	for (i = 0; i < ctx->nr; i++) {
+	for (size_t i = 0; i < ctx->nr; i++) {
 		struct pack_info *pack = &ctx->info[i];
 		if (pack->expired)
 			continue;
@@ -912,14 +903,7 @@ static int write_midx_oid_fanout(struct hashfile *f,
 	struct pack_midx_entry *list = ctx->entries;
 	struct pack_midx_entry *last = ctx->entries + ctx->entries_nr;
 	uint32_t count = 0;
-	uint32_t i;
-
-	/*
-	* Write the first-level table (the list is sorted,
-	* but we use a 256-entry lookup to be able to avoid
-	* having to do eight extra binary search iterations).
-	*/
-	for (i = 0; i < 256; i++) {
+	for (uint32_t i = 0; i < 256; i++) {
 		struct pack_midx_entry *next = list;
 
 		while (next < last && next->oid.hash[0] == i) {
@@ -940,9 +924,7 @@ static int write_midx_oid_lookup(struct hashfile *f,
 	struct write_midx_context *ctx = data;
 	unsigned char hash_len = the_hash_algo->rawsz;
 	struct pack_midx_entry *list = ctx->entries;
-	uint32_t i;
-
-	for (i = 0; i < ctx->entries_nr; i++) {
+	for (uint32_t i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *obj = list++;
 
 		if (i < ctx->entries_nr - 1) {
@@ -964,9 +946,9 @@ static int write_midx_object_offsets(struct hashfile *f,
 {
 	struct write_midx_context *ctx = data;
 	struct pack_midx_entry *list = ctx->entries;
-	uint32_t i, nr_large_offset = 0;
+	uint32_t nr_large_offset = 0;
 
-	for (i = 0; i < ctx->entries_nr; i++) {
+	for (uint32_t i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *obj = list++;
 
 		if (ctx->pack_perm[obj->pack_int_id] == PACK_EXPIRED)
@@ -1022,9 +1004,7 @@ static int write_midx_revindex(struct hashfile *f,
 			       void *data)
 {
 	struct write_midx_context *ctx = data;
-	uint32_t i;
-
-	for (i = 0; i < ctx->entries_nr; i++)
+	for (uint32_t i = 0; i < ctx->entries_nr; i++)
 		hashwrite_be32(f, ctx->pack_order[i]);
 
 	return 0;
@@ -1124,14 +1104,12 @@ static int midx_checksum_valid(struct multi_pack_index *m)
 static void prepare_midx_packing_data(struct packing_data *pdata,
 				      struct write_midx_context *ctx)
 {
-	uint32_t i;
-
 	trace2_region_enter("midx", "prepare_midx_packing_data", the_repository);
 
 	memset(pdata, 0, sizeof(struct packing_data));
 	prepare_packing_data(the_repository, pdata);
 
-	for (i = 0; i < ctx->entries_nr; i++) {
+	for (uint32_t i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *from = &ctx->entries[ctx->pack_order[i]];
 		struct object_entry *to = packlist_alloc(pdata, &from->oid);
 
@@ -1351,14 +1329,13 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 							const char *object_dir)
 {
 	struct multi_pack_index *result = NULL;
-	struct multi_pack_index *cur;
 	char *obj_dir_real = real_pathdup(object_dir, 1);
 	struct strbuf cur_path_real = STRBUF_INIT;
 
 	/* Ensure the given object_dir is local, or a known alternate. */
 	find_odb(r, obj_dir_real);
 
-	for (cur = get_multi_pack_index(r); cur; cur = cur->next) {
+	for (struct multi_pack_index *cur = get_multi_pack_index(r); cur; cur = cur->next) {
 		strbuf_realpath(&cur_path_real, cur->object_dir, 1);
 		if (!strcmp(obj_dir_real, cur_path_real.buf)) {
 			result = cur;
@@ -2070,12 +2047,12 @@ static int fill_included_packs_all(struct repository *r,
 				   struct multi_pack_index *m,
 				   unsigned char *include_pack)
 {
-	uint32_t i, count = 0;
+	uint32_t count = 0;
 	int pack_kept_objects = 0;
 
 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
 
-	for (i = 0; i < m->num_packs; i++) {
+	for (uint32_t i = 0; i < m->num_packs; i++) {
 		if (prepare_midx_pack(r, m, i))
 			continue;
 		if (!pack_kept_objects && m->packs[i]->pack_keep)
@@ -2159,7 +2136,6 @@ static int fill_included_packs_batch(struct repository *r,
 int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
 {
 	int result = 0;
-	uint32_t i;
 	unsigned char *include_pack;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *cmd_in;
@@ -2217,7 +2193,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 
 	cmd_in = xfdopen(cmd.in, "w");
 
-	for (i = 0; i < m->num_objects; i++) {
+	for (uint32_t i = 0; i < m->num_objects; i++) {
 		struct object_id oid;
 		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
 
diff --git a/name-hash.c b/name-hash.c
index 251f036eef..2652c7e4ed 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -233,19 +233,15 @@ static int lookup_lazy_params(struct index_state *istate)
  */
 static void init_dir_mutex(void)
 {
-	int j;
-
 	CALLOC_ARRAY(lazy_dir_mutex_array, LAZY_MAX_MUTEX);
 
-	for (j = 0; j < LAZY_MAX_MUTEX; j++)
+	for (int j = 0; j < LAZY_MAX_MUTEX; j++)
 		init_recursive_mutex(&lazy_dir_mutex_array[j]);
 }
 
 static void cleanup_dir_mutex(void)
 {
-	int j;
-
-	for (j = 0; j < LAZY_MAX_MUTEX; j++)
+	for (int j = 0; j < LAZY_MAX_MUTEX; j++)
 		pthread_mutex_destroy(&lazy_dir_mutex_array[j]);
 
 	free(lazy_dir_mutex_array);
@@ -483,9 +479,7 @@ struct lazy_name_thread_data {
 static void *lazy_name_thread_proc(void *_data)
 {
 	struct lazy_name_thread_data *d = _data;
-	int k;
-
-	for (k = 0; k < d->istate->cache_nr; k++) {
+	for (int k = 0; k < d->istate->cache_nr; k++) {
 		struct cache_entry *ce_k = d->istate->cache[k];
 		ce_k->ce_flags |= CE_HASHED;
 		hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
@@ -499,9 +493,7 @@ static inline void lazy_update_dir_ref_counts(
 	struct index_state *istate,
 	struct lazy_entry *lazy_entries)
 {
-	int k;
-
-	for (k = 0; k < istate->cache_nr; k++) {
+	for (int k = 0; k < istate->cache_nr; k++) {
 		if (lazy_entries[k].dir)
 			lazy_entries[k].dir->nr++;
 	}
@@ -603,8 +595,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 		threaded_lazy_init_name_hash(istate);
 		hashmap_enable_item_counting(&istate->dir_hash);
 	} else {
-		int nr;
-		for (nr = 0; nr < istate->cache_nr; nr++)
+		for (int nr = 0; nr < istate->cache_nr; nr++)
 			hash_index_entry(istate, istate->cache[nr]);
 	}
 
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 5b91520430..05006c6286 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -132,7 +132,6 @@ static int push_parent(struct data *data, struct entry *entry,
 	struct entry *parent_entry;
 
 	if (to_push->object.flags & SEEN) {
-		int i;
 		if (to_push->object.flags & POPPED)
 			/*
 			 * The entry for this commit has already been popped,
@@ -143,7 +142,7 @@ static int push_parent(struct data *data, struct entry *entry,
 		/*
 		 * Find the existing entry and use it.
 		 */
-		for (i = 0; i < data->rev_list.nr; i++) {
+		for (int i = 0; i < data->rev_list.nr; i++) {
 			parent_entry = data->rev_list.array[i].data;
 			if (parent_entry->commit == to_push)
 				goto parent_found;
diff --git a/notes-merge.c b/notes-merge.c
index 8799b522a5..580b5acbb5 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -132,7 +132,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 {
 	struct diff_options opt;
 	struct notes_merge_pair *changes;
-	int i, len = 0;
+	int len = 0;
 
 	trace_printf("\tdiff_tree_remote(base = %.7s, remote = %.7s)\n",
 	       oid_to_hex(base), oid_to_hex(remote));
@@ -146,7 +146,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 
 	CALLOC_ARRAY(changes, diff_queued_diff.nr);
 
-	for (i = 0; i < diff_queued_diff.nr; i++) {
+	for (int i = 0; i < diff_queued_diff.nr; i++) {
 		struct diff_filepair *p = diff_queued_diff.queue[i];
 		struct notes_merge_pair *mp;
 		int occupied;
@@ -194,7 +194,6 @@ static void diff_tree_local(struct notes_merge_options *o,
 			    const struct object_id *local)
 {
 	struct diff_options opt;
-	int i;
 
 	trace_printf("\tdiff_tree_local(len = %i, base = %.7s, local = %.7s)\n",
 	       len, oid_to_hex(base), oid_to_hex(local));
@@ -206,7 +205,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 	diff_tree_oid(base, local, "", &opt);
 	diffcore_std(&opt);
 
-	for (i = 0; i < diff_queued_diff.nr; i++) {
+	for (int i = 0; i < diff_queued_diff.nr; i++) {
 		struct diff_filepair *p = diff_queued_diff.queue[i];
 		struct notes_merge_pair *mp;
 		int match;
@@ -483,10 +482,10 @@ static int merge_changes(struct notes_merge_options *o,
 			 struct notes_merge_pair *changes, int *num_changes,
 			 struct notes_tree *t)
 {
-	int i, conflicts = 0;
+	int conflicts = 0;
 
 	trace_printf("\tmerge_changes(num_changes = %i)\n", *num_changes);
-	for (i = 0; i < *num_changes; i++) {
+	for (int i = 0; i < *num_changes; i++) {
 		struct notes_merge_pair *p = changes + i;
 		trace_printf("\t\t%.7s: %.7s -> %.7s/%.7s\n",
 		       oid_to_hex(&p->obj), oid_to_hex(&p->base),
diff --git a/notes-utils.c b/notes-utils.c
index 6197a5a455..0bd3557292 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -172,8 +172,7 @@ int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 			  const struct object_id *from_obj, const struct object_id *to_obj)
 {
 	int ret = 0;
-	int i;
-	for (i = 0; c->trees[i]; i++)
+	for (int i = 0; c->trees[i]; i++)
 		ret = copy_note(c->trees[i], from_obj, to_obj, 1, c->combine) || ret;
 	return ret;
 }
@@ -182,8 +181,7 @@ void finish_copy_notes_for_rewrite(struct repository *r,
 				   struct notes_rewrite_cfg *c,
 				   const char *msg)
 {
-	int i;
-	for (i = 0; c->trees[i]; i++) {
+	for (int i = 0; c->trees[i]; i++) {
 		commit_notes(r, c->trees[i], msg);
 		free_notes(c->trees[i]);
 	}
diff --git a/notes.c b/notes.c
index fed1eda80c..fd09f8597f 100644
--- a/notes.c
+++ b/notes.c
@@ -165,13 +165,12 @@ static struct leaf_node *note_tree_find(struct notes_tree *t,
 static int note_tree_consolidate(struct int_node *tree,
 	struct int_node *parent, unsigned char index)
 {
-	unsigned int i;
 	void *p = NULL;
 
 	assert(tree && parent);
 	assert(CLR_PTR_TYPE(parent->a[index]) == tree);
 
-	for (i = 0; i < 16; i++) {
+	for (unsigned int i = 0; i < 16; i++) {
 		if (GET_PTR_TYPE(tree->a[i]) != PTR_TYPE_NULL) {
 			if (p) /* more than one entry */
 				return -2;
@@ -325,8 +324,7 @@ static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
 /* Free the entire notes data contained in the given tree */
 static void note_tree_free(struct int_node *tree)
 {
-	unsigned int i;
-	for (i = 0; i < 16; i++) {
+	for (unsigned int i = 0; i < 16; i++) {
 		void *p = tree->a[i];
 		switch (GET_PTR_TYPE(p)) {
 		case PTR_TYPE_INTERNAL:
@@ -512,18 +510,9 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 static unsigned char determine_fanout(struct int_node *tree, unsigned char n,
 		unsigned char fanout)
 {
-	/*
-	 * The following is a simple heuristic that works well in practice:
-	 * For each even-numbered 16-tree level (remember that each on-disk
-	 * fanout level corresponds to _two_ 16-tree levels), peek at all 16
-	 * entries at that tree level. If all of them are either int_nodes or
-	 * subtree entries, then there are likely plenty of notes below this
-	 * level, so we return an incremented fanout.
-	 */
-	unsigned int i;
 	if ((n % 2) || (n > 2 * fanout))
 		return fanout;
-	for (i = 0; i < 16; i++) {
+	for (unsigned int i = 0; i < 16; i++) {
 		switch (GET_PTR_TYPE(tree->a[i])) {
 		case PTR_TYPE_SUBTREE:
 		case PTR_TYPE_INTERNAL:
@@ -557,14 +546,13 @@ static int for_each_note_helper(struct notes_tree *t, struct int_node *tree,
 		unsigned char n, unsigned char fanout, int flags,
 		each_note_fn fn, void *cb_data)
 {
-	unsigned int i;
 	void *p;
 	int ret = 0;
 	struct leaf_node *l;
 	static char path[FANOUT_PATH_MAX];
 
 	fanout = determine_fanout(tree, n, fanout);
-	for (i = 0; i < 16; i++) {
+	for (unsigned int i = 0; i < 16; i++) {
 redo:
 		p = tree->a[i];
 		switch (GET_PTR_TYPE(p)) {
@@ -960,12 +948,11 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 {
 	struct string_list split = STRING_LIST_INIT_NODUP;
 	char *globs_copy = xstrdup(globs);
-	int i;
 
 	string_list_split_in_place(&split, globs_copy, ":", -1);
 	string_list_remove_empty_items(&split, 0);
 
-	for (i = 0; i < split.nr; i++)
+	for (int i = 0; i < split.nr; i++)
 		string_list_add_refs_by_glob(list, split.items[i].string);
 
 	string_list_clear(&split, 0);
@@ -1257,7 +1244,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 {
 	static const char utf8[] = "utf-8";
 	const struct object_id *oid;
-	char *msg, *msg_p;
+	char *msg;
 	unsigned long linelen, msglen;
 	enum object_type type;
 
@@ -1300,7 +1287,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 		}
 	}
 
-	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
+	for (char *msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
 		linelen = strchrnul(msg_p, '\n') - msg_p;
 
 		if (!raw)
@@ -1315,9 +1302,8 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 void format_display_notes(const struct object_id *object_oid,
 			  struct strbuf *sb, const char *output_encoding, int raw)
 {
-	int i;
 	assert(display_notes_trees);
-	for (i = 0; display_notes_trees[i]; i++)
+	for (int i = 0; display_notes_trees[i]; i++)
 		format_note(display_notes_trees[i], object_oid, sb,
 			    output_encoding, raw);
 }
diff --git a/object-file.c b/object-file.c
index 619f039ebc..7bc32ce778 100644
--- a/object-file.c
+++ b/object-file.c
@@ -239,10 +239,9 @@ const char *empty_blob_oid_hex(void)
 
 int hash_algo_by_name(const char *name)
 {
-	int i;
 	if (!name)
 		return GIT_HASH_UNKNOWN;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
+	for (int i = 1; i < GIT_HASH_NALGOS; i++)
 		if (!strcmp(name, hash_algos[i].name))
 			return i;
 	return GIT_HASH_UNKNOWN;
@@ -250,8 +249,7 @@ int hash_algo_by_name(const char *name)
 
 int hash_algo_by_id(uint32_t format_id)
 {
-	int i;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
+	for (int i = 1; i < GIT_HASH_NALGOS; i++)
 		if (format_id == hash_algos[i].format_id)
 			return i;
 	return GIT_HASH_UNKNOWN;
@@ -259,8 +257,7 @@ int hash_algo_by_id(uint32_t format_id)
 
 int hash_algo_by_length(int len)
 {
-	int i;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
+	for (int i = 1; i < GIT_HASH_NALGOS; i++)
 		if (len == hash_algos[i].rawsz)
 			return i;
 	return GIT_HASH_UNKNOWN;
@@ -290,10 +287,9 @@ static struct cached_object empty_tree = {
 
 static struct cached_object *find_cached_object(const struct object_id *oid)
 {
-	int i;
 	struct cached_object *co = cached_objects;
 
-	for (i = 0; i < cached_object_nr; i++, co++) {
+	for (int i = 0; i < cached_object_nr; i++, co++) {
 		if (oideq(&co->oid, oid))
 			return co;
 	}
@@ -422,8 +418,7 @@ enum scld_error safe_create_leading_directories_const(const char *path)
 
 static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
 {
-	int i;
-	for (i = 0; i < the_hash_algo->rawsz; i++) {
+	for (int i = 0; i < the_hash_algo->rawsz; i++) {
 		static char hex[] = "0123456789abcdef";
 		unsigned int val = oid->hash[i];
 		strbuf_addch(buf, hex[val >> 4]);
@@ -922,11 +917,10 @@ void for_each_alternate_ref(alternate_ref_fn fn, void *data)
 
 int foreach_alt_odb(alt_odb_fn fn, void *cb)
 {
-	struct object_directory *ent;
 	int r = 0;
 
 	prepare_alt_odb(the_repository);
-	for (ent = the_repository->objects->odb->next; ent; ent = ent->next) {
+	for (struct object_directory *ent = the_repository->objects->odb->next; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
 			break;
@@ -989,10 +983,8 @@ static int check_and_freshen_local(const struct object_id *oid, int freshen)
 
 static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
 {
-	struct object_directory *odb;
-
 	prepare_alt_odb(the_repository);
-	for (odb = the_repository->objects->odb->next; odb; odb = odb->next) {
+	for (struct object_directory *odb = the_repository->objects->odb->next; odb; odb = odb->next) {
 		if (check_and_freshen_odb(odb, oid, freshen))
 			return 1;
 	}
@@ -1166,11 +1158,10 @@ int git_open_cloexec(const char *name, int flags)
 static int stat_loose_object(struct repository *r, const struct object_id *oid,
 			     struct stat *st, const char **path)
 {
-	struct object_directory *odb;
 	static struct strbuf buf = STRBUF_INIT;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
+	for (struct object_directory *odb = r->objects->odb; odb; odb = odb->next) {
 		*path = odb_loose_path(odb, &buf, oid);
 		if (!lstat(*path, st))
 			return 0;
@@ -1187,12 +1178,11 @@ static int open_loose_object(struct repository *r,
 			     const struct object_id *oid, const char **path)
 {
 	int fd;
-	struct object_directory *odb;
 	int most_interesting_errno = ENOENT;
 	static struct strbuf buf = STRBUF_INIT;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
+	for (struct object_directory *odb = r->objects->odb; odb; odb = odb->next) {
 		*path = odb_loose_path(odb, &buf, oid);
 		fd = git_open(*path);
 		if (fd >= 0)
@@ -1208,10 +1198,8 @@ static int open_loose_object(struct repository *r,
 static int quick_has_loose(struct repository *r,
 			   const struct object_id *oid)
 {
-	struct object_directory *odb;
-
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
+	for (struct object_directory *odb = r->objects->odb; odb; odb = odb->next) {
 		if (oidtree_contains(odb_loose_cache(odb, oid), oid))
 			return 1;
 	}
@@ -2603,9 +2591,7 @@ int for_each_loose_file_in_objdir_buf(struct strbuf *path,
 			    void *data)
 {
 	int r = 0;
-	int i;
-
-	for (i = 0; i < 256; i++) {
+	for (int i = 0; i < 256; i++) {
 		r = for_each_file_in_obj_subdir(i, path, obj_cb, cruft_cb,
 						subdir_cb, data);
 		if (r)
@@ -2635,10 +2621,8 @@ int for_each_loose_file_in_objdir(const char *path,
 int for_each_loose_object(each_loose_object_fn cb, void *data,
 			  enum for_each_object_flags flags)
 {
-	struct object_directory *odb;
-
 	prepare_alt_odb(the_repository);
-	for (odb = the_repository->objects->odb; odb; odb = odb->next) {
+	for (struct object_directory *odb = the_repository->objects->odb; odb; odb = odb->next) {
 		int r = for_each_loose_file_in_objdir(odb->path, cb, NULL,
 						      NULL, data);
 		if (r)
diff --git a/object-name.c b/object-name.c
index 3a2ef5d680..a8a29a8c8b 100644
--- a/object-name.c
+++ b/object-name.c
@@ -105,9 +105,7 @@ static enum cb_next match_prefix(const struct object_id *oid, void *arg)
 
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
-	struct object_directory *odb;
-
-	for (odb = ds->repo->objects->odb; odb && !ds->ambiguous; odb = odb->next)
+	for (struct object_directory *odb = ds->repo->objects->odb; odb && !ds->ambiguous; odb = odb->next)
 		oidtree_each(odb_loose_cache(odb, &ds->bin_pfx),
 				&ds->bin_pfx, ds->len, match_prefix, ds);
 }
@@ -130,7 +128,7 @@ static int match_hash(unsigned len, const unsigned char *a, const unsigned char
 static void unique_in_midx(struct multi_pack_index *m,
 			   struct disambiguate_state *ds)
 {
-	uint32_t num, i, first = 0;
+	uint32_t num, first = 0;
 	const struct object_id *current = NULL;
 	num = m->num_objects;
 
@@ -144,7 +142,7 @@ static void unique_in_midx(struct multi_pack_index *m,
 	 * with an object name that could match "bin_pfx".  See if we have
 	 * 0, 1 or more objects that actually match(es).
 	 */
-	for (i = first; i < num && !ds->ambiguous; i++) {
+	for (uint32_t i = first; i < num && !ds->ambiguous; i++) {
 		struct object_id oid;
 		current = nth_midxed_object_oid(&oid, m, i);
 		if (!match_hash(ds->len, ds->bin_pfx.hash, current->hash))
@@ -156,7 +154,7 @@ static void unique_in_midx(struct multi_pack_index *m,
 static void unique_in_pack(struct packed_git *p,
 			   struct disambiguate_state *ds)
 {
-	uint32_t num, i, first = 0;
+	uint32_t num, first = 0;
 
 	if (p->multi_pack_index)
 		return;
@@ -172,7 +170,7 @@ static void unique_in_pack(struct packed_git *p,
 	 * with an object name that could match "bin_pfx".  See if we have
 	 * 0, 1 or more objects that actually match(es).
 	 */
-	for (i = first; i < num && !ds->ambiguous; i++) {
+	for (uint32_t i = first; i < num && !ds->ambiguous; i++) {
 		struct object_id oid;
 		nth_packed_object_id(&oid, p, i);
 		if (!match_hash(ds->len, ds->bin_pfx.hash, oid.hash))
@@ -183,14 +181,9 @@ static void unique_in_pack(struct packed_git *p,
 
 static void find_short_packed_object(struct disambiguate_state *ds)
 {
-	struct multi_pack_index *m;
-	struct packed_git *p;
-
-	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
-	     m = m->next)
+	for (struct multi_pack_index *m = get_multi_pack_index(ds->repo); m && !ds->ambiguous; m = m->next)
 		unique_in_midx(m, ds);
-	for (p = get_packed_git(ds->repo); p && !ds->ambiguous;
-	     p = p->next)
+	for (struct packed_git *p = get_packed_git(ds->repo); p && !ds->ambiguous; p = p->next)
 		unique_in_pack(p, ds);
 }
 
@@ -307,12 +300,11 @@ int set_disambiguate_hint_config(const char *var, const char *value)
 		{ "treeish", disambiguate_treeish_only },
 		{ "blob", disambiguate_blob_only }
 	};
-	int i;
 
 	if (!value)
 		return config_error_nonbool(var);
 
-	for (i = 0; i < ARRAY_SIZE(hints); i++) {
+	for (int i = 0; i < ARRAY_SIZE(hints); i++) {
 		if (!strcasecmp(value, hints[i].name)) {
 			default_disambiguate_hint = hints[i].fn;
 			return 0;
@@ -326,14 +318,12 @@ static int init_object_disambiguation(struct repository *r,
 				      const char *name, int len,
 				      struct disambiguate_state *ds)
 {
-	int i;
-
 	if (len < MINIMUM_ABBREV || len > the_hash_algo->hexsz)
 		return -1;
 
 	memset(ds, 0, sizeof(*ds));
 
-	for (i = 0; i < len ;i++) {
+	for (int i = 0; i < len; i++) {
 		unsigned char c = name[i];
 		unsigned char val;
 		if (c >= '0' && c <= '9')
@@ -758,12 +748,9 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 
 static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 {
-	struct multi_pack_index *m;
-	struct packed_git *p;
-
-	for (m = get_multi_pack_index(mad->repo); m; m = m->next)
+	for (struct multi_pack_index *m = get_multi_pack_index(mad->repo); m; m = m->next)
 		find_abbrev_len_for_midx(m, mad);
-	for (p = get_packed_git(mad->repo); p; p = p->next)
+	for (struct packed_git *p = get_packed_git(mad->repo); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 
@@ -853,9 +840,7 @@ const char *repo_find_unique_abbrev(struct repository *r,
 static int ambiguous_path(const char *path, int len)
 {
 	int slash = 1;
-	int cnt;
-
-	for (cnt = 0; cnt < len; cnt++) {
+	for (int cnt = 0; cnt < len; cnt++) {
 		switch (*path++) {
 		case '\0':
 			break;
@@ -878,9 +863,7 @@ static int ambiguous_path(const char *path, int len)
 static inline int at_mark(const char *string, int len,
 			  const char **suffix, int nr)
 {
-	int i;
-
-	for (i = 0; i < nr; i++) {
+	for (int i = 0; i < nr; i++) {
 		int suffix_len = strlen(suffix[i]);
 		if (suffix_len <= len
 		    && !strncasecmp(string, suffix[i], suffix_len))
@@ -992,13 +975,13 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 		warning(warn_msg, len, str);
 
 	if (reflog_len) {
-		int nth, i;
+		int nth;
 		timestamp_t at_time;
 		timestamp_t co_time;
 		int co_tz, co_cnt;
 
 		/* Is it asking for N-th entry, or approxidate? */
-		for (i = nth = 0; 0 <= nth && i < reflog_len; i++) {
+		for (int i = nth = 0; 0 <= nth && i < reflog_len; i++) {
 			char ch = str[at+2+i];
 			if ('0' <= ch && ch <= '9')
 				nth = nth * 10 + ch - '0';
@@ -1229,10 +1212,9 @@ static int get_describe_name(struct repository *r,
 			     const char *name, int len,
 			     struct object_id *oid)
 {
-	const char *cp;
 	unsigned flags = GET_OID_QUIETLY | GET_OID_COMMIT;
 
-	for (cp = name + len - 1; name + 2 <= cp; cp--) {
+	for (const char *cp = name + len - 1; name + 2 <= cp; cp--) {
 		char ch = *cp;
 		if (!isxdigit(ch)) {
 			/* We must be looking at g in "SOMETHING-g"
@@ -1639,7 +1621,6 @@ int repo_interpret_branch_name(struct repository *r,
 			       const struct interpret_branch_name_options *options)
 {
 	char *at;
-	const char *start;
 	int len;
 
 	if (!namelen)
@@ -1658,9 +1639,7 @@ int repo_interpret_branch_name(struct repository *r,
 		}
 	}
 
-	for (start = name;
-	     (at = memchr(start, '@', namelen - (start - name)));
-	     start = at + 1) {
+	for (const char *start = name; (at = memchr(start, '@', namelen - (start - name))); start = at + 1) {
 
 		if (!options->allowed || (options->allowed & INTERPRET_BRANCH_HEAD)) {
 			len = interpret_empty_at(name, namelen, at - name, buf);
diff --git a/object.c b/object.c
index e6a1c4d905..90ebd3b111 100644
--- a/object.c
+++ b/object.c
@@ -41,12 +41,10 @@ const char *type_name(unsigned int type)
 
 int type_from_string_gently(const char *str, ssize_t len, int gentle)
 {
-	int i;
-
 	if (len < 0)
 		len = strlen(str);
 
-	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
+	for (int i = 1; i < ARRAY_SIZE(object_type_strings); i++)
 		if (!xstrncmpz(object_type_strings[i], str, len))
 			return i;
 
@@ -122,7 +120,6 @@ struct object *lookup_object(struct repository *r, const struct object_id *oid)
  */
 static void grow_object_hash(struct repository *r)
 {
-	int i;
 	/*
 	 * Note that this size must always be power-of-2 to match hash_obj
 	 * above.
@@ -131,7 +128,7 @@ static void grow_object_hash(struct repository *r)
 	struct object **new_hash;
 
 	CALLOC_ARRAY(new_hash, new_hash_size);
-	for (i = 0; i < r->parsed_objects->obj_hash_size; i++) {
+	for (int i = 0; i < r->parsed_objects->obj_hash_size; i++) {
 		struct object *obj = r->parsed_objects->obj_hash[i];
 
 		if (!obj)
@@ -426,10 +423,10 @@ struct object *object_array_pop(struct object_array *array)
 void object_array_filter(struct object_array *array,
 			 object_array_each_func_t want, void *cb_data)
 {
-	unsigned nr = array->nr, src, dst;
+	unsigned nr = array->nr, dst;
 	struct object_array_entry *objects = array->objects;
 
-	for (src = dst = 0; src < nr; src++) {
+	for (unsigned src = dst = 0; src < nr; src++) {
 		if (want(&objects[src], cb_data)) {
 			if (src != dst)
 				objects[dst] = objects[src];
@@ -443,8 +440,7 @@ void object_array_filter(struct object_array *array,
 
 void object_array_clear(struct object_array *array)
 {
-	int i;
-	for (i = 0; i < array->nr; i++)
+	for (int i = 0; i < array->nr; i++)
 		object_array_release_entry(&array->objects[i]);
 	FREE_AND_NULL(array->objects);
 	array->nr = array->alloc = 0;
@@ -456,10 +452,10 @@ void object_array_clear(struct object_array *array)
 static int contains_object(struct object_array *array,
 			   const struct object *item, const char *name)
 {
-	unsigned nr = array->nr, i;
+	unsigned nr = array->nr;
 	struct object_array_entry *object = array->objects;
 
-	for (i = 0; i < nr; i++, object++)
+	for (unsigned i = 0; i < nr; i++, object++)
 		if (item == object->item && !strcmp(object->name, name))
 			return 1;
 	return 0;
@@ -467,11 +463,11 @@ static int contains_object(struct object_array *array,
 
 void object_array_remove_duplicates(struct object_array *array)
 {
-	unsigned nr = array->nr, src;
+	unsigned nr = array->nr;
 	struct object_array_entry *objects = array->objects;
 
 	array->nr = 0;
-	for (src = 0; src < nr; src++) {
+	for (unsigned src = 0; src < nr; src++) {
 		if (!contains_object(array, objects[src].item,
 				     objects[src].name)) {
 			if (src != array->nr)
@@ -485,9 +481,7 @@ void object_array_remove_duplicates(struct object_array *array)
 
 void clear_object_flags(unsigned flags)
 {
-	int i;
-
-	for (i=0; i < the_repository->parsed_objects->obj_hash_size; i++) {
+	for (int i = 0; i < the_repository->parsed_objects->obj_hash_size; i++) {
 		struct object *obj = the_repository->parsed_objects->obj_hash[i];
 		if (obj)
 			obj->flags &= ~flags;
@@ -496,9 +490,7 @@ void clear_object_flags(unsigned flags)
 
 void repo_clear_commit_marks(struct repository *r, unsigned int flags)
 {
-	int i;
-
-	for (i = 0; i < r->parsed_objects->obj_hash_size; i++) {
+	for (int i = 0; i < r->parsed_objects->obj_hash_size; i++) {
 		struct object *obj = r->parsed_objects->obj_hash[i];
 		if (obj && obj->type == OBJ_COMMIT)
 			obj->flags &= ~flags;
@@ -579,17 +571,7 @@ void raw_object_store_clear(struct raw_object_store *o)
 }
 
 void parsed_object_pool_clear(struct parsed_object_pool *o)
-{
-	/*
-	 * As objects are allocated in slabs (see alloc.c), we do
-	 * not need to free each object, but each slab instead.
-	 *
-	 * Before doing so, we need to free any additional memory
-	 * the objects may hold.
-	 */
-	unsigned i;
-
-	for (i = 0; i < o->obj_hash_size; i++) {
+{for (unsigned i = 0; i < o->obj_hash_size; i++) {
 		struct object *obj = o->obj_hash[i];
 
 		if (!obj)
diff --git a/oid-array.c b/oid-array.c
index 8e4717746c..bda80c1e49 100644
--- a/oid-array.c
+++ b/oid-array.c
@@ -47,11 +47,7 @@ int oid_array_for_each(struct oid_array *array,
 		       for_each_oid_fn fn,
 		       void *data)
 {
-	size_t i;
-
-	/* No oid_array_sort() here! See oid-array.h */
-
-	for (i = 0; i < array->nr; i++) {
+	for (size_t i = 0; i < array->nr; i++) {
 		int ret = fn(array->oid + i, data);
 		if (ret)
 			return ret;
@@ -63,11 +59,9 @@ int oid_array_for_each_unique(struct oid_array *array,
 			      for_each_oid_fn fn,
 			      void *data)
 {
-	size_t i;
-
 	oid_array_sort(array);
 
-	for (i = 0; i < array->nr; i = oid_array_next_unique(array, i)) {
+	for (size_t i = 0; i < array->nr; i = oid_array_next_unique(array, i)) {
 		int ret = fn(array->oid + i, data);
 		if (ret)
 			return ret;
@@ -79,10 +73,10 @@ void oid_array_filter(struct oid_array *array,
 		      for_each_oid_fn want,
 		      void *cb_data)
 {
-	size_t nr = array->nr, src, dst;
+	size_t nr = array->nr, dst;
 	struct object_id *oids = array->oid;
 
-	for (src = dst = 0; src < nr; src++) {
+	for (size_t src = dst = 0; src < nr; src++) {
 		if (want(&oids[src], cb_data)) {
 			if (src != dst)
 				oidcpy(&oids[dst], &oids[src]);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 990a9498d7..795a6fd6ba 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -58,15 +58,13 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 				    struct pack_idx_entry **index,
 				    uint32_t index_nr)
 {
-	uint32_t i;
-
 	writer.commits = ewah_new();
 	writer.trees = ewah_new();
 	writer.blobs = ewah_new();
 	writer.tags = ewah_new();
 	ALLOC_ARRAY(to_pack->in_pack_pos, to_pack->nr_objects);
 
-	for (i = 0; i < index_nr; ++i) {
+	for (uint32_t i = 0; i < index_nr; ++i) {
 		struct object_entry *entry = (struct object_entry *)index[i];
 		enum object_type real_type;
 
@@ -217,8 +215,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 	struct rev_info revs;
 	struct commit *commit;
 	struct commit_list *reusable = NULL;
-	struct commit_list *r;
-	unsigned int i, num_maximal = 0;
+	unsigned int num_maximal = 0;
 
 	memset(bb, 0, sizeof(*bb));
 	init_bb_data(&bb->data);
@@ -228,7 +225,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 	revs.topo_order = 1;
 	revs.first_parent_only = 1;
 
-	for (i = 0; i < writer->selected_nr; i++) {
+	for (unsigned int i = 0; i < writer->selected_nr; i++) {
 		struct commit *c = writer->selected[i].commit;
 		struct bb_commit *ent = bb_data_at(&bb->data, c);
 
@@ -327,7 +324,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 		c_ent->commit_mask = NULL;
 	}
 
-	for (r = reusable; r; r = r->next) {
+	for (struct commit_list *r = reusable; r; r = r->next) {
 		ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
 		bb->commits[bb->commits_nr++] = r->item;
 	}
@@ -480,7 +477,6 @@ static void store_selected(struct bb_commit *ent, struct commit *commit)
 int bitmap_writer_build(struct packing_data *to_pack)
 {
 	struct bitmap_builder bb;
-	size_t i;
 	int nr_stored = 0; /* for progress */
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct prio_queue tree_queue = { NULL };
@@ -503,7 +499,7 @@ int bitmap_writer_build(struct packing_data *to_pack)
 		mapping = NULL;
 
 	bitmap_builder_init(&bb, &writer, old_bitmap);
-	for (i = bb.commits_nr; i > 0; i--) {
+	for (size_t i = bb.commits_nr; i > 0; i--) {
 		struct commit *commit = bb.commits[i-1];
 		struct bb_commit *ent = bb_data_at(&bb.data, commit);
 		struct commit *child;
@@ -674,9 +670,7 @@ static void write_selected_commits_v1(struct hashfile *f,
 				      uint32_t *commit_positions,
 				      off_t *offsets)
 {
-	int i;
-
-	for (i = 0; i < writer.selected_nr; ++i) {
+	for (int i = 0; i < writer.selected_nr; ++i) {
 		struct bitmapped_commit *stored = &writer.selected[i];
 
 		if (offsets)
@@ -767,9 +761,7 @@ static void write_hash_cache(struct hashfile *f,
 			     struct pack_idx_entry **index,
 			     uint32_t index_nr)
 {
-	uint32_t i;
-
-	for (i = 0; i < index_nr; ++i) {
+	for (uint32_t i = 0; i < index_nr; ++i) {
 		struct object_entry *entry = (struct object_entry *)index[i];
 		hashwrite_be32(f, entry->hash);
 	}
@@ -791,7 +783,6 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	struct hashfile *f;
 	uint32_t *commit_positions = NULL;
 	off_t *offsets = NULL;
-	uint32_t i;
 
 	struct bitmap_disk_header header;
 
@@ -816,7 +807,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 
 	ALLOC_ARRAY(commit_positions, writer.selected_nr);
 
-	for (i = 0; i < writer.selected_nr; i++) {
+	for (uint32_t i = 0; i < writer.selected_nr; i++) {
 		struct bitmapped_commit *stored = &writer.selected[i];
 		int commit_pos = oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2baeabacee..f1958d12c2 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -264,10 +264,9 @@ static int nth_bitmap_object_oid(struct bitmap_index *index,
 
 static int load_bitmap_entries_v1(struct bitmap_index *index)
 {
-	uint32_t i;
 	struct stored_bitmap *recent_bitmaps[MAX_XOR_OFFSET] = { NULL };
 
-	for (i = 0; i < index->entry_count; ++i) {
+	for (uint32_t i = 0; i < index->entry_count; ++i) {
 		int xor_offset, flags;
 		struct ewah_bitmap *bitmap = NULL;
 		struct stored_bitmap *xor_bitmap = NULL;
@@ -331,7 +330,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	struct stat st;
 	char *bitmap_name = midx_bitmap_filename(midx);
 	int fd = git_open(bitmap_name);
-	uint32_t i, preferred_pack;
+	uint32_t preferred_pack;
 	struct packed_git *preferred;
 
 	if (fd < 0) {
@@ -378,7 +377,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		goto cleanup;
 	}
 
-	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
+	for (uint32_t i = 0; i < bitmap_git->midx->num_packs; i++) {
 		if (prepare_midx_pack(the_repository, bitmap_git->midx, i)) {
 			warning(_("could not open pack %s"),
 				bitmap_git->midx->pack_names[i]);
@@ -467,7 +466,6 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_git)
 {
 	if (bitmap_is_midx(bitmap_git)) {
-		uint32_t i;
 		int ret;
 
 		/*
@@ -477,7 +475,7 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
 		 * But we still need to open the individual pack .rev files,
 		 * since we will need to make use of them in pack-objects.
 		 */
-		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
+		for (uint32_t i = 0; i < bitmap_git->midx->num_packs; i++) {
 			ret = load_pack_revindex(r, bitmap_git->midx->packs[i]);
 			if (ret)
 				return ret;
@@ -525,10 +523,9 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
 static int open_pack_bitmap(struct repository *r,
 			    struct bitmap_index *bitmap_git)
 {
-	struct packed_git *p;
 	int ret = -1;
 
-	for (p = get_all_packs(r); p; p = p->next) {
+	for (struct packed_git *p = get_all_packs(r); p; p = p->next) {
 		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
 			ret = 0;
 			/*
@@ -547,11 +544,10 @@ static int open_midx_bitmap(struct repository *r,
 			    struct bitmap_index *bitmap_git)
 {
 	int ret = -1;
-	struct multi_pack_index *midx;
 
 	assert(!bitmap_git->map);
 
-	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
+	for (struct multi_pack_index *midx = get_multi_pack_index(r); midx; midx = midx->next) {
 		if (!open_midx_bitmap_1(bitmap_git, midx))
 			ret = 0;
 	}
@@ -1111,8 +1107,6 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 					    struct object_list *roots)
 {
 	struct bitmap_boundary_cb cb;
-	struct object_list *root;
-	unsigned int i;
 	unsigned int tmp_blobs, tmp_trees, tmp_tags;
 	int any_missing = 0;
 
@@ -1126,7 +1120,7 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	 * OR in any existing reachability bitmaps among `roots` into
 	 * `cb.base`.
 	 */
-	for (root = roots; root; root = root->next) {
+	for (struct object_list *root = roots; root; root = root->next) {
 		struct object *object = root->item;
 		if (object->type != OBJ_COMMIT ||
 		    bitmap_walk_contains(bitmap_git, cb.base, &object->oid))
@@ -1179,7 +1173,7 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	 * Then add the boundary commit(s) as fill-in traversal tips.
 	 */
 	trace2_region_enter("pack-bitmap", "boundary-fill-in", the_repository);
-	for (i = 0; i < cb.boundary.nr; i++) {
+	for (unsigned int i = 0; i < cb.boundary.nr; i++) {
 		struct object *obj = cb.boundary.objects[i].item;
 		if (bitmap_walk_contains(bitmap_git, cb.base, &obj->oid))
 			obj->flags |= SEEN;
@@ -1289,9 +1283,7 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 {
 	struct bitmap *objects = bitmap_git->result;
 	struct eindex *eindex = &bitmap_git->ext_index;
-	uint32_t i;
-
-	for (i = 0; i < eindex->count; ++i) {
+	for (uint32_t i = 0; i < eindex->count; ++i) {
 		struct object *obj;
 
 		if (!bitmap_get(objects, st_add(bitmap_num_objects(bitmap_git), i)))
@@ -1418,9 +1410,7 @@ static struct bitmap *find_tip_objects(struct bitmap_index *bitmap_git,
 				       enum object_type type)
 {
 	struct bitmap *result = bitmap_new();
-	struct object_list *p;
-
-	for (p = tip_objects; p; p = p->next) {
+	for (struct object_list *p = tip_objects; p; p = p->next) {
 		int pos;
 
 		if (p->item->type != type)
@@ -1648,8 +1638,7 @@ static int filter_bitmap(struct bitmap_index *bitmap_git,
 	}
 
 	if (filter->choice == LOFC_COMBINE) {
-		int i;
-		for (i = 0; i < filter->sub_nr; i++) {
+		for (int i = 0; i < filter->sub_nr; i++) {
 			if (filter_bitmap(bitmap_git, tip_objects, to_filter,
 					  &filter->sub[i]) < 0)
 				return -1;
@@ -1693,7 +1682,6 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 int filter_provided_objects)
 {
-	unsigned int i;
 	int use_boundary_traversal;
 
 	struct object_list *wants = NULL;
@@ -1721,7 +1709,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	if (open_bitmap(revs->repo, bitmap_git) < 0)
 		goto cleanup;
 
-	for (i = 0; i < revs->pending.nr; ++i) {
+	for (unsigned int i = 0; i < revs->pending.nr; ++i) {
 		struct object *object = revs->pending.objects[i].item;
 
 		if (object->type == OBJ_NONE)
@@ -2374,12 +2362,12 @@ int test_bitmap_hashes(struct repository *r)
 {
 	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
 	struct object_id oid;
-	uint32_t i, index_pos;
+	uint32_t index_pos;
 
 	if (!bitmap_git || !bitmap_git->hashes)
 		goto cleanup;
 
-	for (i = 0; i < bitmap_num_objects(bitmap_git); i++) {
+	for (uint32_t i = 0; i < bitmap_num_objects(bitmap_git); i++) {
 		if (bitmap_is_midx(bitmap_git))
 			index_pos = pack_pos_to_midx(bitmap_git->midx, i);
 		else
@@ -2432,7 +2420,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 				struct packing_data *mapping)
 {
 	struct repository *r = the_repository;
-	uint32_t i, num_objects;
+	uint32_t num_objects;
 	uint32_t *reposition;
 
 	if (!bitmap_is_midx(bitmap_git))
@@ -2444,7 +2432,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 	num_objects = bitmap_num_objects(bitmap_git);
 	CALLOC_ARRAY(reposition, num_objects);
 
-	for (i = 0; i < num_objects; ++i) {
+	for (uint32_t i = 0; i < num_objects; ++i) {
 		struct object_id oid;
 		struct object_entry *oe;
 		uint32_t index_pos;
@@ -2520,11 +2508,9 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 	off_t total = 0;
 	struct ewah_iterator it;
 	eword_t filter;
-	size_t i;
 
 	init_type_iterator(&it, bitmap_git, object_type);
-	for (i = 0; i < result->word_alloc &&
-			ewah_iterator_next(&filter, &it); i++) {
+	for (size_t i = 0; i < result->word_alloc && ewah_iterator_next(&filter, &it); i++) {
 		eword_t word = result->words[i] & filter;
 		size_t base = (i * BITS_IN_EWORD);
 		unsigned offset;
@@ -2575,11 +2561,10 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 	off_t total = 0;
 	struct object_info oi = OBJECT_INFO_INIT;
 	off_t object_size;
-	size_t i;
 
 	oi.disk_sizep = &object_size;
 
-	for (i = 0; i < eindex->count; i++) {
+	for (size_t i = 0; i < eindex->count; i++) {
 		struct object *obj = eindex->objects[i];
 
 		if (!bitmap_get(result,
diff --git a/pack-objects.c b/pack-objects.c
index a9d9855063..2984b4b16c 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -41,7 +41,6 @@ static inline uint32_t closest_pow2(uint32_t v)
 
 static void rehash_objects(struct packing_data *pdata)
 {
-	uint32_t i;
 	struct object_entry *entry;
 
 	pdata->index_size = closest_pow2(pdata->nr_objects * 3);
@@ -53,7 +52,7 @@ static void rehash_objects(struct packing_data *pdata)
 
 	entry = pdata->objects;
 
-	for (i = 0; i < pdata->nr_objects; i++) {
+	for (uint32_t i = 0; i < pdata->nr_objects; i++) {
 		int found;
 		uint32_t ix = locate_object_entry_hash(pdata,
 						       &entry->idx.oid,
@@ -86,7 +85,7 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 
 static void prepare_in_pack_by_idx(struct packing_data *pdata)
 {
-	struct packed_git **mapping, *p;
+	struct packed_git **mapping;
 	int cnt = 0, nr = 1U << OE_IN_PACK_BITS;
 
 	ALLOC_ARRAY(mapping, nr);
@@ -95,7 +94,8 @@ static void prepare_in_pack_by_idx(struct packing_data *pdata)
 	 * (i.e. in_pack_idx also zero) should return NULL.
 	 */
 	mapping[cnt++] = NULL;
-	for (p = get_all_packs(pdata->repo); p; p = p->next, cnt++) {
+	for (struct packed_git *p = get_all_packs(pdata->repo); p; p = p->next,
+	     cnt++) {
 		if (cnt == nr) {
 			free(mapping);
 			return;
@@ -117,14 +117,12 @@ static void prepare_in_pack_by_idx(struct packing_data *pdata)
  */
 void oe_map_new_pack(struct packing_data *pack)
 {
-	uint32_t i;
-
 	if (pack->in_pack)
 		BUG("packing_data has already been converted to pack array");
 
 	ALLOC_ARRAY(pack->in_pack, pack->nr_alloc);
 
-	for (i = 0; i < pack->nr_objects; i++)
+	for (uint32_t i = 0; i < pack->nr_objects; i++)
 		pack->in_pack[i] = oe_in_pack(pack, pack->objects + i);
 
 	FREE_AND_NULL(pack->in_pack_by_idx);
diff --git a/pack-revindex.c b/pack-revindex.c
index a7624d8be8..d9b10fc012 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -59,7 +59,6 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
 	 * to "to".
 	 */
 	struct revindex_entry *tmp, *from, *to;
-	int bits;
 	unsigned *pos;
 
 	ALLOC_ARRAY(pos, BUCKETS);
@@ -72,7 +71,7 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
 	 * on (and any higher) will be zero for all entries, and our loop will
 	 * be a no-op, as everybody lands in the same zero-th bucket.
 	 */
-	for (bits = 0; max >> bits; bits += DIGIT_SIZE) {
+	for (int bits = 0; max >> bits; bits += DIGIT_SIZE) {
 		unsigned i;
 
 		memset(pos, 0, BUCKETS * sizeof(*pos));
@@ -133,7 +132,6 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
 static void create_pack_revindex(struct packed_git *p)
 {
 	const unsigned num_ent = p->num_objects;
-	unsigned i;
 	const char *index = p->index_data;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
@@ -144,7 +142,7 @@ static void create_pack_revindex(struct packed_git *p)
 		const uint32_t *off_32 =
 			(uint32_t *)(index + 8 + (size_t)p->num_objects * (hashsz + 4));
 		const uint32_t *off_64 = off_32 + p->num_objects;
-		for (i = 0; i < num_ent; i++) {
+		for (unsigned i = 0; i < num_ent; i++) {
 			const uint32_t off = ntohl(*off_32++);
 			if (!(off & 0x80000000)) {
 				p->revindex[i].offset = off;
@@ -155,7 +153,7 @@ static void create_pack_revindex(struct packed_git *p)
 			p->revindex[i].nr = i;
 		}
 	} else {
-		for (i = 0; i < num_ent; i++) {
+		for (unsigned i = 0; i < num_ent; i++) {
 			const uint32_t hl = *((uint32_t *)(index + (hashsz + 4) * i));
 			p->revindex[i].offset = ntohl(hl);
 			p->revindex[i].nr = i;
diff --git a/pack-write.c b/pack-write.c
index 80ecfa544c..3395ac3296 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -199,8 +199,7 @@ static void write_rev_index_positions(struct hashfile *f,
 				      uint32_t *pack_order,
 				      uint32_t nr_objects)
 {
-	uint32_t i;
-	for (i = 0; i < nr_objects; i++)
+	for (uint32_t i = 0; i < nr_objects; i++)
 		hashwrite_be32(f, pack_order[i]);
 }
 
@@ -216,14 +215,13 @@ const char *write_rev_file(const char *rev_name,
 			   unsigned flags)
 {
 	uint32_t *pack_order;
-	uint32_t i;
 	const char *ret;
 
 	if (!(flags & WRITE_REV) && !(flags & WRITE_REV_VERIFY))
 		return NULL;
 
 	ALLOC_ARRAY(pack_order, nr_objects);
-	for (i = 0; i < nr_objects; i++)
+	for (uint32_t i = 0; i < nr_objects; i++)
 		pack_order[i] = i;
 	QSORT_S(pack_order, nr_objects, pack_order_cmp, objects);
 
@@ -302,8 +300,7 @@ static void write_mtimes_objects(struct hashfile *f,
 				 struct pack_idx_entry **objects,
 				 uint32_t nr_objects)
 {
-	uint32_t i;
-	for (i = 0; i < nr_objects; i++) {
+	for (uint32_t i = 0; i < nr_objects; i++) {
 		struct object_entry *e = (struct object_entry*)objects[i];
 		hashwrite_be32(f, oe_cruft_mtime(to_pack, e));
 	}
@@ -577,10 +574,10 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
 {
-	int i, err;
+	int err;
 	FILE *output = xfopen(promisor_name, "w");
 
-	for (i = 0; i < nr_sought; i++)
+	for (int i = 0; i < nr_sought; i++)
 		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
 			sought[i]->name);
 
diff --git a/packfile.c b/packfile.c
index 84a005674d..3060b505db 100644
--- a/packfile.c
+++ b/packfile.c
@@ -117,7 +117,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	     size_t idx_size, struct packed_git *p)
 {
 	struct pack_idx_header *hdr = idx_map;
-	uint32_t version, nr, i, *index;
+	uint32_t version, nr, *index;
 
 	if (idx_size < 4 * 256 + hashsz + hashsz)
 		return error("index file %s is too small", path);
@@ -138,7 +138,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	index = idx_map;
 	if (version > 1)
 		index += 2;  /* skip index header */
-	for (i = 0; i < 256; i++) {
+	for (uint32_t i = 0; i < 256; i++) {
 		uint32_t n = ntohl(index[i]);
 		if (n < nr)
 			return error("non-monotonic index %s", path);
@@ -272,12 +272,12 @@ static void scan_windows(struct packed_git *p,
 
 static int unuse_one_window(struct packed_git *current)
 {
-	struct packed_git *p, *lru_p = NULL;
+	struct packed_git *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
 	if (current)
 		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (p = the_repository->objects->packed_git; p; p = p->next)
+	for (struct packed_git *p = the_repository->objects->packed_git; p; p = p->next)
 		scan_windows(p, &lru_p, &lru_w, &lru_l);
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
@@ -360,9 +360,7 @@ void close_pack(struct packed_git *p)
 
 void close_object_store(struct raw_object_store *o)
 {
-	struct packed_git *p;
-
-	for (p = o->packed_git; p; p = p->next)
+	for (struct packed_git *p = o->packed_git; p; p = p->next)
 		if (p->do_not_close)
 			BUG("want to close pack marked 'do-not-close'");
 		else
@@ -379,7 +377,6 @@ void close_object_store(struct raw_object_store *o)
 void unlink_pack_path(const char *pack_name, int force_delete)
 {
 	static const char *exts[] = {".idx", ".pack", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};
-	int i;
 	struct strbuf buf = STRBUF_INIT;
 	size_t plen;
 
@@ -395,7 +392,7 @@ void unlink_pack_path(const char *pack_name, int force_delete)
 		}
 	}
 
-	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+	for (int i = 0; i < ARRAY_SIZE(exts); i++) {
 		strbuf_setlen(&buf, plen);
 		strbuf_addstr(&buf, exts[i]);
 		unlink(buf.buf);
@@ -410,7 +407,7 @@ void unlink_pack_path(const char *pack_name, int force_delete)
  */
 static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struct pack_window **mru_w, int *accept_windows_inuse)
 {
-	struct pack_window *w, *this_mru_w;
+	struct pack_window *this_mru_w;
 	int has_windows_inuse = 0;
 
 	/*
@@ -421,7 +418,7 @@ static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
 	if (*lru_p && !*mru_w && (p->windows || p->mtime > (*lru_p)->mtime))
 		return;
 
-	for (w = this_mru_w = p->windows; w; w = w->next) {
+	for (struct pack_window *w = this_mru_w = p->windows; w; w = w->next) {
 		/*
 		 * Reject this pack if any of its windows are in use,
 		 * but the previously selected pack did not have any
@@ -461,11 +458,11 @@ static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
 
 static int close_one_pack(void)
 {
-	struct packed_git *p, *lru_p = NULL;
+	struct packed_git *lru_p = NULL;
 	struct pack_window *mru_w = NULL;
 	int accept_windows_inuse = 1;
 
-	for (p = the_repository->objects->packed_git; p; p = p->next) {
+	for (struct packed_git *p = the_repository->objects->packed_git; p; p = p->next) {
 		if (p->pack_fd == -1)
 			continue;
 		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
@@ -781,14 +778,14 @@ static void report_helper(const struct string_list *list,
 
 static void report_pack_garbage(struct string_list *list)
 {
-	int i, baselen = -1, first = 0, seen_bits = 0;
+	int baselen = -1, first = 0, seen_bits = 0;
 
 	if (!report_garbage)
 		return;
 
 	string_list_sort(list);
 
-	for (i = 0; i < list->nr; i++) {
+	for (int i = 0; i < list->nr; i++) {
 		const char *path = list->items[i].string;
 		if (baselen != -1 &&
 		    strncmp(path, list->items[first].string, baselen)) {
@@ -928,14 +925,12 @@ unsigned long repo_approximate_object_count(struct repository *r)
 {
 	if (!r->objects->approximate_object_count_valid) {
 		unsigned long count;
-		struct multi_pack_index *m;
-		struct packed_git *p;
 
 		prepare_packed_git(r);
 		count = 0;
-		for (m = get_multi_pack_index(r); m; m = m->next)
+		for (struct multi_pack_index *m = get_multi_pack_index(r); m; m = m->next)
 			count += m->num_objects;
-		for (p = r->objects->packed_git; p; p = p->next) {
+		for (struct packed_git *p = r->objects->packed_git; p; p = p->next) {
 			if (open_pack_index(p))
 				continue;
 			count += p->num_objects;
@@ -981,23 +976,19 @@ static void rearrange_packed_git(struct repository *r)
 
 static void prepare_packed_git_mru(struct repository *r)
 {
-	struct packed_git *p;
-
 	INIT_LIST_HEAD(&r->objects->packed_git_mru);
 
-	for (p = r->objects->packed_git; p; p = p->next)
+	for (struct packed_git *p = r->objects->packed_git; p; p = p->next)
 		list_add_tail(&p->mru, &r->objects->packed_git_mru);
 }
 
 static void prepare_packed_git(struct repository *r)
 {
-	struct object_directory *odb;
-
 	if (r->objects->packed_git_initialized)
 		return;
 
 	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
+	for (struct object_directory *odb = r->objects->odb; odb; odb = odb->next) {
 		int local = (odb == r->objects->odb);
 		prepare_multi_pack_index_one(r, odb->path, local);
 		prepare_packed_git_one(r, odb->path, local);
@@ -1010,8 +1001,6 @@ static void prepare_packed_git(struct repository *r)
 
 void reprepare_packed_git(struct repository *r)
 {
-	struct object_directory *odb;
-
 	obj_read_lock();
 
 	/*
@@ -1023,7 +1012,7 @@ void reprepare_packed_git(struct repository *r)
 	r->objects->loaded_alternates = 0;
 	prepare_alt_odb(r);
 
-	for (odb = r->objects->odb; odb; odb = odb->next)
+	for (struct object_directory *odb = r->objects->odb; odb; odb = odb->next)
 		odb_clear_loose_cache(odb);
 
 	r->objects->approximate_object_count_valid = 0;
@@ -1057,10 +1046,8 @@ struct multi_pack_index *get_local_multi_pack_index(struct repository *r)
 
 struct packed_git *get_all_packs(struct repository *r)
 {
-	struct multi_pack_index *m;
-
 	prepare_packed_git(r);
-	for (m = r->objects->multi_pack_index; m; m = m->next) {
+	for (struct multi_pack_index *m = r->objects->multi_pack_index; m; m = m->next) {
 		uint32_t i;
 		for (i = 0; i < m->num_packs; i++)
 			prepare_midx_pack(r, m, i);
@@ -1189,9 +1176,7 @@ void mark_bad_packed_object(struct packed_git *p, const struct object_id *oid)
 const struct packed_git *has_packed_and_bad(struct repository *r,
 					    const struct object_id *oid)
 {
-	struct packed_git *p;
-
-	for (p = r->objects->packed_git; p; p = p->next)
+	for (struct packed_git *p = r->objects->packed_git; p; p = p->next)
 		if (oidset_contains(&p->bad_objects, oid))
 			return p;
 	return NULL;
@@ -2001,9 +1986,7 @@ int is_pack_valid(struct packed_git *p)
 struct packed_git *find_sha1_pack(const unsigned char *sha1,
 				  struct packed_git *packs)
 {
-	struct packed_git *p;
-
-	for (p = packs; p; p = p->next) {
+	for (struct packed_git *p = packs; p; p = p->next) {
 		if (find_pack_entry_one(sha1, p))
 			return p;
 	}
@@ -2042,13 +2025,12 @@ static int fill_pack_entry(const struct object_id *oid,
 int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
 {
 	struct list_head *pos;
-	struct multi_pack_index *m;
 
 	prepare_packed_git(r);
 	if (!r->objects->packed_git && !r->objects->multi_pack_index)
 		return 0;
 
-	for (m = r->objects->multi_pack_index; m; m = m->next) {
+	for (struct multi_pack_index *m = r->objects->multi_pack_index; m; m = m->next) {
 		if (fill_midx_entry(r, oid, e, m))
 			return 1;
 	}
@@ -2081,17 +2063,7 @@ static struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
 	if (!r->objects->kept_pack_cache.packs) {
 		struct packed_git **packs = NULL;
 		size_t nr = 0, alloc = 0;
-		struct packed_git *p;
-
-		/*
-		 * We want "all" packs here, because we need to cover ones that
-		 * are used by a midx, as well. We need to look in every one of
-		 * them (instead of the midx itself) to cover duplicates. It's
-		 * possible that an object is found in two packs that the midx
-		 * covers, one kept and one not kept, but the midx returns only
-		 * the non-kept version.
-		 */
-		for (p = get_all_packs(r); p; p = p->next) {
+		for (struct packed_git *p = get_all_packs(r); p; p = p->next) {
 			if ((p->pack_keep && (flags & ON_DISK_KEEP_PACKS)) ||
 			    (p->pack_keep_in_core && (flags & IN_CORE_KEEP_PACKS))) {
 				ALLOC_GROW(packs, nr + 1, alloc);
@@ -2113,9 +2085,7 @@ int find_kept_pack_entry(struct repository *r,
 			 unsigned flags,
 			 struct pack_entry *e)
 {
-	struct packed_git **cache;
-
-	for (cache = kept_pack_cache(r, flags); *cache; cache++) {
+	for (struct packed_git **cache = kept_pack_cache(r, flags); *cache; cache++) {
 		struct packed_git *p = *cache;
 		if (fill_pack_entry(oid, e, p))
 			return 1;
@@ -2148,7 +2118,6 @@ int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn cb, void *data,
 			    enum for_each_object_flags flags)
 {
-	uint32_t i;
 	int r = 0;
 
 	if (flags & FOR_EACH_OBJECT_PACK_ORDER) {
@@ -2156,7 +2125,7 @@ int for_each_object_in_pack(struct packed_git *p,
 			return -1;
 	}
 
-	for (i = 0; i < p->num_objects; i++) {
+	for (uint32_t i = 0; i < p->num_objects; i++) {
 		uint32_t index_pos;
 		struct object_id oid;
 
@@ -2191,12 +2160,11 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(each_packed_object_fn cb, void *data,
 			   enum for_each_object_flags flags)
 {
-	struct packed_git *p;
 	int r = 0;
 	int pack_errors = 0;
 
 	prepare_packed_git(the_repository);
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
 		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
diff --git a/pager.c b/pager.c
index b8822a9381..b5288cb880 100644
--- a/pager.c
+++ b/pager.c
@@ -77,7 +77,6 @@ const char *git_pager(int stdout_is_tty)
 static void setup_pager_env(struct strvec *env)
 {
 	const char **argv;
-	int i;
 	char *pager_env = xstrdup(PAGER_ENV);
 	int n = split_cmdline(pager_env, &argv);
 
@@ -85,7 +84,7 @@ static void setup_pager_env(struct strvec *env)
 		die("malformed build-time PAGER_ENV: %s",
 			split_cmdline_strerror(n));
 
-	for (i = 0; i < n; i++) {
+	for (int i = 0; i < n; i++) {
 		char *cp = strchr(argv[i], '=');
 
 		if (!cp)
diff --git a/parallel-checkout.c b/parallel-checkout.c
index b5a714c711..f6c21985e8 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -451,9 +451,8 @@ static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
 
 static void send_batch(int fd, size_t start, size_t nr)
 {
-	size_t i;
 	sigchain_push(SIGPIPE, SIG_IGN);
-	for (i = 0; i < nr; i++)
+	for (size_t i = 0; i < nr; i++)
 		send_one_item(fd, &parallel_checkout.items[start + i]);
 	packet_flush(fd);
 	sigchain_pop(SIGPIPE);
@@ -640,9 +639,7 @@ static void gather_results_from_workers(struct pc_worker *workers,
 
 static void write_items_sequentially(struct checkout *state)
 {
-	size_t i;
-
-	for (i = 0; i < parallel_checkout.nr; i++) {
+	for (size_t i = 0; i < parallel_checkout.nr; i++) {
 		struct parallel_checkout_item *pc_item = &parallel_checkout.items[i];
 		write_pc_item(pc_item, state);
 		if (pc_item->status != PC_ITEM_COLLIDED)
diff --git a/parse-options.c b/parse-options.c
index 63a99dea6e..4f76dd618f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -333,15 +333,13 @@ static int is_alias(struct parse_opt_ctx_t *ctx,
 		    const struct option *one_opt,
 		    const struct option *another_opt)
 {
-	const char **group;
-
 	if (!ctx->alias_groups)
 		return 0;
 
 	if (!one_opt->long_name || !another_opt->long_name)
 		return 0;
 
-	for (group = ctx->alias_groups; *group; group += 3) {
+	for (const char **group = ctx->alias_groups; *group; group += 3) {
 		/* it and other are from the same family? */
 		if (has_string(one_opt->long_name, group) &&
 		    has_string(another_opt->long_name, group))
@@ -797,12 +795,10 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 
 static void free_preprocessed_options(struct option *options)
 {
-	int i;
-
 	if (!options)
 		return;
 
-	for (i = 0; options[i].type != OPTION_END; i++) {
+	for (int i = 0; options[i].type != OPTION_END; i++) {
 		if (options[i].flags & PARSE_OPT_FROM_ALIAS)
 			free((void *)options[i].help);
 	}
diff --git a/path.c b/path.c
index 8bb223c92c..fbdb78d17c 100644
--- a/path.c
+++ b/path.c
@@ -337,12 +337,10 @@ static int common_trie_done_setup;
 
 static void init_common_trie(void)
 {
-	struct common_dir *p;
-
 	if (common_trie_done_setup)
 		return;
 
-	for (p = common_list; p->path; p++)
+	for (struct common_dir *p = common_list; p->path; p++)
 		add_to_trie(&common_trie, p->path, p);
 
 	common_trie_done_setup = 1;
@@ -383,14 +381,13 @@ static void update_common_dir(struct strbuf *buf, int git_dir_len,
 void report_linked_checkout_garbage(void)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const struct common_dir *p;
 	int len;
 
 	if (!the_repository->different_commondir)
 		return;
 	strbuf_addf(&sb, "%s/", get_git_dir());
 	len = sb.len;
-	for (p = common_list; p->path; p++) {
+	for (const struct common_dir *p = common_list; p->path; p++) {
 		const char *path = p->path;
 		if (p->ignore_garbage)
 			continue;
@@ -1248,12 +1245,12 @@ int strbuf_normalize_path(struct strbuf *src)
  */
 int longest_ancestor_length(const char *path, struct string_list *prefixes)
 {
-	int i, max_len = -1;
+	int max_len = -1;
 
 	if (!strcmp(path, "/"))
 		return -1;
 
-	for (i = 0; i < prefixes->nr; i++) {
+	for (int i = 0; i < prefixes->nr; i++) {
 		const char *ceil = prefixes->items[i].string;
 		int len = strlen(ceil);
 
diff --git a/pathspec.c b/pathspec.c
index 2133b9fe60..bc92b4d572 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -75,9 +75,7 @@ char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
 {
 	struct index_state *istate = the_repository->index;
 	char *seen = xcalloc(pathspec->nr, 1);
-	int i;
-
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		if (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate))
 		    ce_path_match(istate, ce, pathspec, seen);
@@ -561,8 +559,7 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
 
 void pathspec_magic_names(unsigned magic, struct strbuf *out)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+	for (int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 		const struct pathspec_magic *m = pathspec_magic + i;
 		if (!(magic & m->bit))
 			continue;
@@ -597,7 +594,7 @@ void parse_pathspec(struct pathspec *pathspec,
 {
 	struct pathspec_item *item;
 	const char *entry = argv ? *argv : NULL;
-	int i, n, prefixlen, nr_exclude = 0;
+	int n, prefixlen, nr_exclude = 0;
 
 	memset(pathspec, 0, sizeof(*pathspec));
 
@@ -642,7 +639,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	item = pathspec->items;
 	prefixlen = prefix ? strlen(prefix) : 0;
 
-	for (i = 0; i < n; i++) {
+	for (int i = 0; i < n; i++) {
 		entry = argv[i];
 
 		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
@@ -717,12 +714,12 @@ void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
 
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
-	int i, j;
+	int j;
 
 	*dst = *src;
 	DUP_ARRAY(dst->items, src->items, dst->nr);
 
-	for (i = 0; i < dst->nr; i++) {
+	for (int i = 0; i < dst->nr; i++) {
 		struct pathspec_item *d = &dst->items[i];
 		struct pathspec_item *s = &src->items[i];
 
@@ -741,9 +738,9 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 
 void clear_pathspec(struct pathspec *pathspec)
 {
-	int i, j;
+	int j;
 
-	for (i = 0; i < pathspec->nr; i++) {
+	for (int i = 0; i < pathspec->nr; i++) {
 		free(pathspec->items[i].match);
 		free(pathspec->items[i].original);
 
@@ -763,7 +760,6 @@ int match_pathspec_attrs(struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item)
 {
-	int i;
 	char *to_free = NULL;
 
 	if (name[namelen])
@@ -773,7 +769,7 @@ int match_pathspec_attrs(struct index_state *istate,
 
 	free(to_free);
 
-	for (i = 0; i < item->attr_match_nr; i++) {
+	for (int i = 0; i < item->attr_match_nr; i++) {
 		const char *value;
 		int matched;
 		enum attr_match_mode match_mode;
@@ -800,7 +796,7 @@ int match_pathspec_attrs(struct index_state *istate,
 int pathspec_needs_expanded_index(struct index_state *istate,
 				  const struct pathspec *pathspec)
 {
-	unsigned int i, pos;
+	unsigned int pos;
 	int res = 0;
 	char *skip_worktree_seen = NULL;
 
@@ -817,7 +813,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
 	if (pathspec->magic)
 		return 1;
 
-	for (i = 0; i < pathspec->nr; i++) {
+	for (unsigned int i = 0; i < pathspec->nr; i++) {
 		struct pathspec_item item = pathspec->items[i];
 
 		/*
diff --git a/pkt-line.c b/pkt-line.c
index 24479eae4d..0157789bf2 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -39,7 +39,6 @@ static int packet_trace_pack(const char *buf, unsigned int len, int sideband)
 
 static void packet_trace(const char *buf, unsigned int len, int write)
 {
-	int i;
 	struct strbuf out;
 	static int in_pack, sideband;
 
@@ -72,7 +71,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 		    get_trace_prefix(), write ? '>' : '<');
 
 	/* XXX we should really handle printable utf8 */
-	for (i = 0; i < len; i++) {
+	for (int i = 0; i < len; i++) {
 		/* suppress newlines */
 		if (buf[i] == '\n')
 			continue;
diff --git a/pretty.c b/pretty.c
index cf964b060c..223f5f71ba 100644
--- a/pretty.c
+++ b/pretty.c
@@ -137,14 +137,13 @@ static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
 {
 	struct cmt_fmt_map *found = NULL;
 	size_t found_match_len = 0;
-	int i;
 
 	if (num_redirections >= commit_formats_len)
 		die("invalid --pretty format: "
 		    "'%s' references an alias which points to itself",
 		    original);
 
-	for (i = 0; i < commit_formats_len; i++) {
+	for (int i = 0; i < commit_formats_len; i++) {
 		size_t match_len;
 
 		if (!starts_with(commit_formats[i].name, sought))
@@ -268,8 +267,7 @@ static int is_rfc822_special(char ch)
 
 static int needs_rfc822_quoting(const char *s, int len)
 {
-	int i;
-	for (i = 0; i < len; i++)
+	for (int i = 0; i < len; i++)
 		if (is_rfc822_special(s[i]))
 			return 1;
 	return 0;
@@ -288,13 +286,11 @@ static int last_line_length(struct strbuf *sb)
 
 static void add_rfc822_quoted(struct strbuf *out, const char *s, int len)
 {
-	int i;
-
 	/* just a guess, we may have to also backslash-quote */
 	strbuf_grow(out, len + 2);
 
 	strbuf_addch(out, '"');
-	for (i = 0; i < len; i++) {
+	for (int i = 0; i < len; i++) {
 		switch (s[i]) {
 		case '"':
 		case '\\':
@@ -366,9 +362,7 @@ static int is_rfc2047_special(char ch, enum rfc2047_type type)
 
 static int needs_rfc2047_encoding(const char *line, int len)
 {
-	int i;
-
-	for (i = 0; i < len; i++) {
+	for (int i = 0; i < len; i++) {
 		int ch = line[i];
 		if (non_ascii(ch) || ch == '\n')
 			return 1;
@@ -937,9 +931,7 @@ void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len)
 	size_t trimlen;
 	size_t start_len = sb->len;
 	int space = 2;
-	int i;
-
-	for (i = 0; i < len; i++) {
+	for (int i = 0; i < len; i++) {
 		if (istitlechar(msg[i])) {
 			if (space == 1)
 				strbuf_addch(sb, '-');
@@ -2131,8 +2123,7 @@ void pp_title_line(struct pretty_print_context *pp,
 	}
 
 	if (pp->in_body_headers.nr) {
-		int i;
-		for (i = 0; i < pp->in_body_headers.nr; i++) {
+		for (int i = 0; i < pp->in_body_headers.nr; i++) {
 			strbuf_addstr(sb, pp->in_body_headers.items[i].string);
 			free(pp->in_body_headers.items[i].string);
 		}
@@ -2301,9 +2292,9 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	 * as 8-bit if we haven't done so.
 	 */
 	if (cmit_fmt_is_mail(pp->fmt) && need_8bit_cte == 0) {
-		int i, ch, in_body;
+		int i, ch;
 
-		for (in_body = i = 0; (ch = msg[i]); i++) {
+		for (int in_body = i = 0; (ch = msg[i]); i++) {
 			if (!in_body) {
 				/* author could be non 7-bit ASCII but
 				 * the log may be so; skip over the
diff --git a/prio-queue.c b/prio-queue.c
index 450775a374..5f3eee8746 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -17,11 +17,11 @@ static inline void swap(struct prio_queue *queue, int i, int j)
 
 void prio_queue_reverse(struct prio_queue *queue)
 {
-	int i, j;
+	int j;
 
 	if (queue->compare)
 		BUG("prio_queue_reverse() on non-LIFO queue");
-	for (i = 0; i < (j = (queue->nr - 1) - i); i++)
+	for (int i = 0; i < (j = (queue->nr - 1) - i); i++)
 		swap(queue, i, j);
 }
 
@@ -35,7 +35,7 @@ void clear_prio_queue(struct prio_queue *queue)
 
 void prio_queue_put(struct prio_queue *queue, void *thing)
 {
-	int ix, parent;
+	int parent;
 
 	/* Append at the end */
 	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
@@ -46,7 +46,7 @@ void prio_queue_put(struct prio_queue *queue, void *thing)
 		return; /* LIFO */
 
 	/* Bubble up the new one */
-	for (ix = queue->nr - 1; ix; ix = parent) {
+	for (int ix = queue->nr - 1; ix; ix = parent) {
 		parent = (ix - 1) / 2;
 		if (compare(queue, parent, ix) <= 0)
 			break;
@@ -58,7 +58,7 @@ void prio_queue_put(struct prio_queue *queue, void *thing)
 void *prio_queue_get(struct prio_queue *queue)
 {
 	void *result;
-	int ix, child;
+	int child;
 
 	if (!queue->nr)
 		return NULL;
@@ -72,7 +72,7 @@ void *prio_queue_get(struct prio_queue *queue)
 	queue->array[0] = queue->array[queue->nr];
 
 	/* Push down the one at the root */
-	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
+	for (int ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
 		child = ix * 2 + 1; /* left */
 		if (child + 1 < queue->nr &&
 		    compare(queue, child, child + 1) >= 0)
diff --git a/promisor-remote.c b/promisor-remote.c
index ac3aa1e365..b4a0fae209 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -20,7 +20,6 @@ static int fetch_objects(struct repository *repo,
 			 int oid_nr)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
-	int i;
 	FILE *child_in;
 
 	child.git_cmd = 1;
@@ -37,7 +36,7 @@ static int fetch_objects(struct repository *repo,
 
 	trace2_data_intmax("promisor", repo, "fetch_count", oid_nr);
 
-	for (i = 0; i < oid_nr; i++) {
+	for (int i = 0; i < oid_nr; i++) {
 		if (fputs(oid_to_hex(&oids[i]), child_in) < 0)
 			die_errno(_("promisor-remote: could not write to fetch subprocess"));
 		if (fputc('\n', child_in) < 0)
@@ -240,7 +239,6 @@ void promisor_remote_get_direct(struct repository *repo,
 				const struct object_id *oids,
 				int oid_nr)
 {
-	struct promisor_remote *r;
 	struct object_id *remaining_oids = (struct object_id *)oids;
 	int remaining_nr = oid_nr;
 	int to_free = 0;
@@ -251,7 +249,7 @@ void promisor_remote_get_direct(struct repository *repo,
 
 	promisor_remote_init(repo);
 
-	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
+	for (struct promisor_remote *r = repo->promisor_remote_config->promisors; r; r = r->next) {
 		if (fetch_objects(repo, r->name, remaining_oids, remaining_nr) < 0) {
 			if (remaining_nr == 1)
 				continue;
diff --git a/quote.c b/quote.c
index 3c05194496..cf07a8a0d3 100644
--- a/quote.c
+++ b/quote.c
@@ -48,7 +48,6 @@ void sq_quote_buf(struct strbuf *dst, const char *src)
 void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
 {
 	static const char ok_punct[] = "+,-./:=@_^";
-	const char *p;
 
 	/* Avoid losing a zero-length string by adding '' */
 	if (!*src) {
@@ -56,7 +55,7 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
 		return;
 	}
 
-	for (p = src; *p; p++) {
+	for (const char *p = src; *p; p++) {
 		if (!isalnum(*p) && !strchr(ok_punct, *p)) {
 			sq_quote_buf(dst, src);
 			return;
@@ -82,11 +81,9 @@ void sq_quotef(struct strbuf *dst, const char *fmt, ...)
 
 void sq_quote_argv(struct strbuf *dst, const char **argv)
 {
-	int i;
-
 	/* Copy into destination buffer. */
 	strbuf_grow(dst, 255);
-	for (i = 0; argv[i]; ++i) {
+	for (int i = 0; argv[i]; ++i) {
 		strbuf_addch(dst, ' ');
 		sq_quote_buf(dst, argv[i]);
 	}
@@ -109,9 +106,7 @@ void sq_quote_argv_pretty(struct strbuf *dst, const char **argv)
  */
 void sq_append_quote_argv_pretty(struct strbuf *dst, const char **argv)
 {
-	int i;
-
-	for (i = 0; argv[i]; i++) {
+	for (int i = 0; argv[i]; i++) {
 		if (i > 0)
 			strbuf_addch(dst, ' ');
 		sq_quote_buf_pretty(dst, argv[i]);
diff --git a/reachable.c b/reachable.c
index 3b85add243..b8819ff685 100644
--- a/reachable.c
+++ b/reachable.c
@@ -160,14 +160,13 @@ static void load_gc_recent_objects(struct recent_data *data)
 {
 	const struct string_list *programs;
 	int ret = 0;
-	size_t i;
 
 	data->extra_recent_oids_loaded = 1;
 
 	if (git_config_get_string_multi("gc.recentobjectshook", &programs))
 		return;
 
-	for (i = 0; i < programs->nr; i++) {
+	for (size_t i = 0; i < programs->nr; i++) {
 		ret = run_one_gc_recent_objects_hook(&data->extra_recent_oids,
 						       programs->items[i].string);
 		if (ret)
diff --git a/read-cache.c b/read-cache.c
index f546cf7875..811bbce3d3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -584,9 +584,9 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 void remove_marked_cache_entries(struct index_state *istate, int invalidate)
 {
 	struct cache_entry **ce_array = istate->cache;
-	unsigned int i, j;
+	unsigned int j;
 
-	for (i = j = 0; i < istate->cache_nr; i++) {
+	for (unsigned int i = j = 0; i < istate->cache_nr; i++) {
 		if (ce_array[i]->ce_flags & CE_REMOVE) {
 			if (invalidate) {
 				cache_tree_invalidate_path(istate,
@@ -1528,7 +1528,6 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		  const struct pathspec *pathspec,
 		  char *seen, const char *header_msg)
 {
-	int i;
 	int has_errors = 0;
 	int really = (flags & REFRESH_REALLY) != 0;
 	int allow_unmerged = (flags & REFRESH_UNMERGED) != 0;
@@ -1568,7 +1567,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	preload_index(istate, pathspec, 0);
 	trace2_region_enter("index", "refresh", NULL);
 
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
 		int changed = 0;
@@ -1925,12 +1924,10 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 
 static void check_ce_order(struct index_state *istate)
 {
-	unsigned int i;
-
 	if (!verify_ce_order)
 		return;
 
-	for (i = 1; i < istate->cache_nr; i++) {
+	for (unsigned int i = 1; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i - 1];
 		struct cache_entry *next_ce = istate->cache[i];
 		int name_compare = strcmp(ce->name, next_ce->name);
@@ -2074,10 +2071,9 @@ static unsigned long load_cache_entry_block(struct index_state *istate,
 			struct mem_pool *ce_mem_pool, int offset, int nr, const char *mmap,
 			unsigned long start_offset, const struct cache_entry *previous_ce)
 {
-	int i;
 	unsigned long src_offset = start_offset;
 
-	for (i = offset; i < offset + nr; i++) {
+	for (int i = offset; i < offset + nr; i++) {
 		struct cache_entry *ce;
 		unsigned long consumed;
 
@@ -2140,10 +2136,7 @@ struct load_cache_entries_thread_data
 static void *load_cache_entries_thread(void *_data)
 {
 	struct load_cache_entries_thread_data *p = _data;
-	int i;
-
-	/* iterate across all ieot blocks assigned to this thread */
-	for (i = p->ieot_start; i < p->ieot_start + p->ieot_blocks; i++) {
+	for (int i = p->ieot_start; i < p->ieot_start + p->ieot_blocks; i++) {
 		p->consumed += load_cache_entry_block(p->istate, p->ce_mem_pool,
 			p->offset, p->ieot->entries[i].nr, p->mmap, p->ieot->entries[i].offset, NULL);
 		p->offset += p->ieot->entries[i].nr;
@@ -2517,12 +2510,10 @@ void discard_index(struct index_state *istate)
  */
 void validate_cache_entries(const struct index_state *istate)
 {
-	int i;
-
 	if (!should_validate_cache_entries() ||!istate || !istate->initialized)
 		return;
 
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		if (!istate) {
 			BUG("cache entry is not allocated from expected memory pool");
 		} else if (!istate->ce_mem_pool ||
@@ -2542,8 +2533,7 @@ void validate_cache_entries(const struct index_state *istate)
 
 int unmerged_index(const struct index_state *istate)
 {
-	int i;
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		if (ce_stage(istate->cache[i]))
 			return 1;
 	}
@@ -2556,7 +2546,6 @@ int repo_index_has_changes(struct repository *repo,
 {
 	struct index_state *istate = repo->index;
 	struct object_id cmp;
-	int i;
 
 	if (tree)
 		cmp = tree->object.oid;
@@ -2570,7 +2559,7 @@ int repo_index_has_changes(struct repository *repo,
 		diff_setup_done(&opt);
 		do_diff_cache(&cmp, &opt);
 		diffcore_std(&opt);
-		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
+		for (int i = 0; sb && i < diff_queued_diff.nr; i++) {
 			if (i)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, diff_queued_diff.queue[i]->two->path);
@@ -2580,7 +2569,7 @@ int repo_index_has_changes(struct repository *repo,
 	} else {
 		/* TODO: audit for interaction with sparse-index. */
 		ensure_full_index(istate);
-		for (i = 0; sb && i < istate->cache_nr; i++) {
+		for (int i = 0; sb && i < istate->cache_nr; i++) {
 			if (i)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, istate->cache[i]->name);
@@ -2782,9 +2771,7 @@ static int repo_verify_index(struct repository *repo)
 int has_racy_timestamp(struct index_state *istate)
 {
 	int entries = istate->cache_nr;
-	int i;
-
-	for (i = 0; i < entries; i++) {
+	for (int i = 0; i < entries; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		if (is_racy_timestamp(istate, ce))
 			return 1;
@@ -3421,12 +3408,11 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 int repo_read_index_unmerged(struct repository *repo)
 {
 	struct index_state *istate;
-	int i;
 	int unmerged = 0;
 
 	repo_read_index(repo);
 	istate = repo->index;
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct cache_entry *new_ce;
 		int len;
@@ -3485,16 +3471,7 @@ void *read_blob_data_from_index(struct index_state *istate,
 
 	len = strlen(path);
 	pos = index_name_pos(istate, path, len);
-	if (pos < 0) {
-		/*
-		 * We might be in the middle of a merge, in which
-		 * case we would read stage #2 (ours).
-		 */
-		int i;
-		for (i = -pos - 1;
-		     (pos < 0 && i < istate->cache_nr &&
-		      !strcmp(istate->cache[i]->name, path));
-		     i++)
+	if (pos < 0) {for (int i = -pos - 1; (pos < 0 && i < istate->cache_nr && !strcmp(istate->cache[i]->name, path)); i++)
 			if (ce_stage(istate->cache[i]) == 2)
 				pos = i;
 	}
@@ -3667,7 +3644,7 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
 	const char *index = NULL;
 	uint32_t extsize, ext_version;
 	struct index_entry_offset_table *ieot;
-	int i, nr;
+	int nr;
 
 	/* find the IEOT extension */
 	if (!offset)
@@ -3701,7 +3678,7 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
 	ieot = xmalloc(sizeof(struct index_entry_offset_table)
 		       + (nr * sizeof(struct index_entry_offset)));
 	ieot->nr = nr;
-	for (i = 0; i < nr; i++) {
+	for (int i = 0; i < nr; i++) {
 		ieot->entries[i].offset = get_be32(index);
 		index += sizeof(uint32_t);
 		ieot->entries[i].nr = get_be32(index);
@@ -3714,14 +3691,13 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
 static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot)
 {
 	uint32_t buffer;
-	int i;
 
 	/* version */
 	put_be32(&buffer, IEOT_VERSION);
 	strbuf_add(sb, &buffer, sizeof(uint32_t));
 
 	/* ieot */
-	for (i = 0; i < ieot->nr; i++) {
+	for (int i = 0; i < ieot->nr; i++) {
 
 		/* offset */
 		put_be32(&buffer, ieot->entries[i].offset);
@@ -3736,10 +3712,9 @@ static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_ta
 void prefetch_cache_entries(const struct index_state *istate,
 			    must_prefetch_predicate must_prefetch)
 {
-	int i;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 
 		if (S_ISGITLINK(ce->ce_mode) || !must_prefetch(ce))
@@ -3923,10 +3898,9 @@ static int fix_unmerged_status(struct diff_filepair *p,
 static void update_callback(struct diff_queue_struct *q,
 			    struct diff_options *opt UNUSED, void *cbdata)
 {
-	int i;
 	struct update_callback_data *data = cbdata;
 
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
 
diff --git a/ref-filter.c b/ref-filter.c
index be14b56e32..39bbee303f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -413,7 +413,6 @@ static int remote_ref_atom_parser(struct ref_format *format UNUSED,
 				  const char *arg, struct strbuf *err)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
-	int i;
 
 	if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:"))
 		atom->u.remote_ref.push = 1;
@@ -427,7 +426,7 @@ static int remote_ref_atom_parser(struct ref_format *format UNUSED,
 	atom->u.remote_ref.nobracket = 0;
 	string_list_split(&params, arg, ',', -1);
 
-	for (i = 0; i < params.nr; i++) {
+	for (int i = 0; i < params.nr; i++) {
 		const char *s = params.items[i].string;
 
 		if (!strcmp(s, "track"))
@@ -800,7 +799,6 @@ static int align_atom_parser(struct ref_format *format UNUSED,
 {
 	struct align *align = &atom->u.align;
 	struct string_list params = STRING_LIST_INIT_DUP;
-	int i;
 	unsigned int width = ~0U;
 
 	if (!arg)
@@ -809,7 +807,7 @@ static int align_atom_parser(struct ref_format *format UNUSED,
 	align->position = ALIGN_LEFT;
 
 	string_list_split(&params, arg, ',', -1);
-	for (i = 0; i < params.nr; i++) {
+	for (int i = 0; i < params.nr; i++) {
 		const char *s = params.items[i].string;
 		int position;
 
@@ -1408,9 +1406,7 @@ static int grab_oid(const char *name, const char *field, const struct object_id
 /* See grab_values */
 static void grab_common_values(struct atom_value *val, int deref, struct expand_data *oi)
 {
-	int i;
-
-	for (i = 0; i < used_atom_cnt; i++) {
+	for (int i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i].name;
 		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
@@ -1438,10 +1434,9 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 /* See grab_values */
 static void grab_tag_values(struct atom_value *val, int deref, struct object *obj)
 {
-	int i;
 	struct tag *tag = (struct tag *) obj;
 
-	for (i = 0; i < used_atom_cnt; i++) {
+	for (int i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i].name;
 		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
@@ -1461,10 +1456,9 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 /* See grab_values */
 static void grab_commit_values(struct atom_value *val, int deref, struct object *obj)
 {
-	int i;
 	struct commit *commit = (struct commit *) obj;
 
-	for (i = 0; i < used_atom_cnt; i++) {
+	for (int i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i].name;
 		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
@@ -1519,8 +1513,7 @@ static const char *copy_line(const char *buf)
 
 static const char *copy_name(const char *buf)
 {
-	const char *cp;
-	for (cp = buf; *cp && *cp != '\n'; cp++) {
+	for (const char *cp = buf; *cp && *cp != '\n'; cp++) {
 		if (starts_with(cp, " <"))
 			return xmemdupz(buf, cp - buf);
 	}
@@ -1578,9 +1571,7 @@ static const char *copy_email(const char *buf, struct used_atom *atom)
 static char *copy_subject(const char *buf, unsigned long len)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int i;
-
-	for (i = 0; i < len; i++) {
+	for (int i = 0; i < len; i++) {
 		if (buf[i] == '\r' && i + 1 < len && buf[i + 1] == '\n')
 			continue; /* ignore CR in CRLF */
 
@@ -1720,12 +1711,11 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 
 static void grab_signature(struct atom_value *val, int deref, struct object *obj)
 {
-	int i;
 	struct commit *commit = (struct commit *) obj;
 	struct signature_check sigc = { 0 };
 	int signature_checked = 0;
 
-	for (i = 0; i < used_atom_cnt; i++) {
+	for (int i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
 		const char *name = atom->name;
 		struct atom_value *v = &val[i];
@@ -1864,13 +1854,12 @@ static void find_subpos(const char *buf,
  */
 static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
 {
-	int i;
 	const char *sp, *eol;
 	size_t len;
 
 	sp = buf;
 
-	for (i = 0; i < lines && sp < buf + size; i++) {
+	for (int i = 0; i < lines && sp < buf + size; i++) {
 		if (i)
 			strbuf_addstr(out, "\n    ");
 		eol = memchr(sp, '\n', size - (sp - buf));
@@ -1886,9 +1875,7 @@ static void grab_describe_values(struct atom_value *val, int deref,
 				 struct object *obj)
 {
 	struct commit *commit = (struct commit *)obj;
-	int i;
-
-	for (i = 0; i < used_atom_cnt; i++) {
+	for (int i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
 		enum atom_type type = atom->atom_type;
 		const char *name = atom->name;
@@ -1923,12 +1910,11 @@ static void grab_describe_values(struct atom_value *val, int deref,
 /* See grab_values */
 static void grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data)
 {
-	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
 	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 	void *buf = data->content;
 
-	for (i = 0; i < used_atom_cnt; i++) {
+	for (int i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
 		const char *name = atom->name;
 		struct atom_value *v = &val[i];
@@ -2007,8 +1993,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
  */
 static void fill_missing_values(struct atom_value *val)
 {
-	int i;
-	for (i = 0; i < used_atom_cnt; i++) {
+	for (int i = 0; i < used_atom_cnt; i++) {
 		struct atom_value *v = &val[i];
 		if (!v->s)
 			v->s = xstrdup("");
@@ -2282,9 +2267,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 
 static void populate_worktree_map(struct hashmap *map, struct worktree **worktrees)
 {
-	int i;
-
-	for (i = 0; worktrees[i]; i++) {
+	for (int i = 0; worktrees[i]; i++) {
 		if (worktrees[i]->head_ref) {
 			struct ref_to_worktree_entry *entry;
 			entry = xmalloc(sizeof(*entry));
@@ -2731,8 +2714,6 @@ struct ref_array_item *ref_array_push(struct ref_array *array,
 
 static int ref_kind_from_refname(const char *refname)
 {
-	unsigned int i;
-
 	static struct {
 		const char *prefix;
 		unsigned int kind;
@@ -2745,7 +2726,7 @@ static int ref_kind_from_refname(const char *refname)
 	if (!strcmp(refname, "HEAD"))
 		return FILTER_REFS_DETACHED_HEAD;
 
-	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
+	for (unsigned int i = 0; i < ARRAY_SIZE(ref_kind); i++) {
 		if (starts_with(refname, ref_kind[i].prefix))
 			return ref_kind[i].kind;
 	}
@@ -2852,8 +2833,7 @@ static void free_array_item(struct ref_array_item *item)
 {
 	free((char *)item->symref);
 	if (item->value) {
-		int i;
-		for (i = 0; i < used_atom_cnt; i++)
+		for (int i = 0; i < used_atom_cnt; i++)
 			free((char *)item->value[i].s);
 		free(item->value);
 	}
diff --git a/reflog-walk.c b/reflog-walk.c
index d216f6f966..ae25b5bbb4 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -41,12 +41,10 @@ static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
 
 static void free_complete_reflog(struct complete_reflogs *array)
 {
-	int i;
-
 	if (!array)
 		return;
 
-	for (i = 0; i < array->nr; i++) {
+	for (int i = 0; i < array->nr; i++) {
 		free(array->items[i].email);
 		free(array->items[i].message);
 	}
@@ -94,8 +92,7 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 static int get_reflog_recno_by_time(struct complete_reflogs *array,
 	timestamp_t timestamp)
 {
-	int i;
-	for (i = array->nr - 1; i >= 0; i--)
+	for (int i = array->nr - 1; i >= 0; i--)
 		if (timestamp >= array->items[i].timestamp)
 			return i;
 	return -1;
@@ -126,12 +123,10 @@ void init_reflog_walk(struct reflog_walk_info **info)
 
 void reflog_walk_info_release(struct reflog_walk_info *info)
 {
-	size_t i;
-
 	if (!info)
 		return;
 
-	for (i = 0; i < info->nr; i++)
+	for (size_t i = 0; i < info->nr; i++)
 		free(info->logs[i]);
 	string_list_clear_func(&info->complete_reflogs,
 			       complete_reflogs_clear);
@@ -345,9 +340,7 @@ struct commit *next_reflog_entry(struct reflog_walk_info *walk)
 {
 	struct commit_reflog *best = NULL;
 	struct commit *best_commit = NULL;
-	size_t i;
-
-	for (i = 0; i < walk->nr; i++) {
+	for (size_t i = 0; i < walk->nr; i++) {
 		struct commit_reflog *log = walk->logs[i];
 		struct commit *commit = next_reflog_commit(log);
 
diff --git a/refs.c b/refs.c
index fff343c256..a8c7a86e4c 100644
--- a/refs.c
+++ b/refs.c
@@ -648,11 +648,10 @@ static const char *ref_rev_parse_rules[] = {
  */
 int refname_match(const char *abbrev_name, const char *full_name)
 {
-	const char **p;
 	const int abbrev_name_len = strlen(abbrev_name);
 	const int num_rules = NUM_REV_PARSE_RULES;
 
-	for (p = ref_rev_parse_rules; *p; p++)
+	for (const char **p = ref_rev_parse_rules; *p; p++)
 		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name)))
 			return &ref_rev_parse_rules[num_rules] - p;
 
@@ -665,10 +664,9 @@ int refname_match(const char *abbrev_name, const char *full_name)
  */
 void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
 {
-	const char **p;
 	int len = strlen(prefix);
 
-	for (p = ref_rev_parse_rules; *p; p++)
+	for (const char **p = ref_rev_parse_rules; *p; p++)
 		strvec_pushf(prefixes, *p, len, prefix);
 }
 
@@ -759,12 +757,12 @@ int repo_dwim_ref(struct repository *r, const char *str, int len,
 int expand_ref(struct repository *repo, const char *str, int len,
 	       struct object_id *oid, char **ref)
 {
-	const char **p, *r;
+	const char *r;
 	int refs_found = 0;
 	struct strbuf fullref = STRBUF_INIT;
 
 	*ref = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
+	for (const char **p = ref_rev_parse_rules; *p; p++) {
 		struct object_id oid_from_ref;
 		struct object_id *this_result;
 		int flag;
@@ -796,12 +794,11 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 {
 	struct ref_store *refs = get_main_ref_store(r);
 	char *last_branch = substitute_branch_name(r, &str, &len, 0);
-	const char **p;
 	int logs_found = 0;
 	struct strbuf path = STRBUF_INIT;
 
 	*log = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
+	for (const char **p = ref_rev_parse_rules; *p; p++) {
 		struct object_id hash;
 		const char *ref, *it;
 
@@ -846,9 +843,7 @@ int is_per_worktree_ref(const char *refname)
 
 static int is_pseudoref_syntax(const char *refname)
 {
-	const char *c;
-
-	for (c = refname; *c; c++) {
+	for (const char *c = refname; *c; c++) {
 		if (!isupper(*c) && *c != '-' && *c != '_')
 			return 0;
 	}
@@ -1161,8 +1156,6 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 
 void ref_transaction_free(struct ref_transaction *transaction)
 {
-	size_t i;
-
 	if (!transaction)
 		return;
 
@@ -1179,7 +1172,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		break;
 	}
 
-	for (i = 0; i < transaction->nr; i++) {
+	for (size_t i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
 		free(transaction->updates[i]);
 	}
@@ -1377,11 +1370,10 @@ static const char *match_parse_rule(const char *refname, const char *rule,
 char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 				   const char *refname, int strict)
 {
-	int i;
 	struct strbuf resolved_buf = STRBUF_INIT;
 
 	/* skip first rule, it will always match */
-	for (i = NUM_REV_PARSE_RULES - 1; i > 0 ; --i) {
+	for (int i = NUM_REV_PARSE_RULES - 1; i > 0; --i) {
 		int j;
 		int rules_to_fail = i;
 		const char *short_name;
@@ -1468,9 +1460,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 int ref_is_hidden(const char *refname, const char *refname_full,
 		  const struct strvec *hide_refs)
 {
-	int i;
-
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
+	for (int i = hide_refs->nr - 1; i >= 0; i--) {
 		const char *match = hide_refs->v[i];
 		const char *subject;
 		int neg = 0;
@@ -1499,8 +1489,7 @@ int ref_is_hidden(const char *refname, const char *refname_full,
 
 const char **hidden_refs_to_excludes(const struct strvec *hide_refs)
 {
-	const char **pattern;
-	for (pattern = hide_refs->v; *pattern; pattern++) {
+	for (const char **pattern = hide_refs->v; *pattern; pattern++) {
 		/*
 		 * We can't feed any excludes from hidden refs config
 		 * sections, since later rules may override previous
@@ -1525,8 +1514,6 @@ const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
 {
-	int pos;
-
 	if (!extras)
 		return NULL;
 
@@ -1536,8 +1523,7 @@ const char *find_descendant_ref(const char *dirname,
 	 * with dirname (remember, dirname includes the trailing
 	 * slash) and is not in skip, then we have a conflict.
 	 */
-	for (pos = string_list_find_insert_index(extras, dirname, 0);
-	     pos < extras->nr; pos++) {
+	for (int pos = string_list_find_insert_index(extras, dirname, 0); pos < extras->nr; pos++) {
 		const char *extra_refname = extras->items[pos].string;
 
 		if (!starts_with(extra_refname, dirname))
@@ -1859,9 +1845,7 @@ static int is_special_ref(const char *refname)
 		"FETCH_HEAD",
 		"MERGE_HEAD",
 	};
-	size_t i;
-
-	for (i = 0; i < ARRAY_SIZE(special_refs); i++)
+	for (size_t i = 0; i < ARRAY_SIZE(special_refs); i++)
 		if (!strcmp(refname, special_refs[i]))
 			return 1;
 
@@ -1896,7 +1880,6 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct object_id unused_oid;
 	int unused_flags;
-	int symref_count;
 
 	if (!oid)
 		oid = &unused_oid;
@@ -1921,7 +1904,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		*flags |= REF_BAD_NAME;
 	}
 
-	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
+	for (int symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 		int failure_errno;
 
@@ -2252,11 +2235,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int ref_update_reject_duplicates(struct string_list *refnames,
 				 struct strbuf *err)
 {
-	size_t i, n = refnames->nr;
+	size_t n = refnames->nr;
 
 	assert(err);
 
-	for (i = 1; i < n; i++) {
+	for (size_t i = 1; i < n; i++) {
 		int cmp = strcmp(refnames->items[i - 1].string,
 				 refnames->items[i].string);
 
@@ -2278,7 +2261,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	const char *hook;
-	int ret = 0, i;
+	int ret = 0;
 
 	hook = find_hook("reference-transaction");
 	if (!hook)
@@ -2295,7 +2278,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	for (i = 0; i < transaction->nr; i++) {
+	for (int i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
 		strbuf_reset(&buf);
@@ -2425,7 +2408,6 @@ int refs_verify_refname_available(struct ref_store *refs,
 				  const struct string_list *skip,
 				  struct strbuf *err)
 {
-	const char *slash;
 	const char *extra_refname;
 	struct strbuf dirname = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
@@ -2443,7 +2425,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 	assert(err);
 
 	strbuf_grow(&dirname, strlen(refname) + 1);
-	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
+	for (const char *slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
 		/*
 		 * Just saying "Is a directory" when we e.g. can't
 		 * lock some multi-level ref isn't very informative,
@@ -2631,9 +2613,7 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
 					    ref_transaction_for_each_queued_update_fn cb,
 					    void *cb_data)
 {
-	int i;
-
-	for (i = 0; i < transaction->nr; i++) {
+	for (int i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
 		cb(update->refname,
diff --git a/refs/debug.c b/refs/debug.c
index 634681ca44..a3e028d7c6 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -76,9 +76,8 @@ static void print_update(int i, const char *refname,
 
 static void print_transaction(struct ref_transaction *transaction)
 {
-	int i;
 	trace_printf_key(&trace_refs, "transaction {\n");
-	for (i = 0; i < transaction->nr; i++) {
+	for (int i = 0; i < transaction->nr; i++) {
 		struct ref_update *u = transaction->updates[i];
 		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
 			     u->type, u->msg);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 75dcc21ecb..be97d40422 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -210,12 +210,11 @@ static void files_ref_path(struct files_ref_store *refs,
 static void add_per_worktree_entries_to_dir(struct ref_dir *dir, const char *dirname)
 {
 	const char *prefixes[] = { "refs/bisect/", "refs/worktree/", "refs/rewritten/" };
-	int ip;
 
 	if (strcmp(dirname, "refs/"))
 		return;
 
-	for (ip = 0; ip < ARRAY_SIZE(prefixes); ip++) {
+	for (int ip = 0; ip < ARRAY_SIZE(prefixes); ip++) {
 		const char *prefix = prefixes[ip];
 		int prefix_len = strlen(prefix);
 		struct ref_entry *child_entry;
@@ -1089,11 +1088,10 @@ static void try_remove_empty_parents(struct files_ref_store *refs,
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	char *p, *q;
-	int i;
 
 	strbuf_addstr(&buf, refname);
 	p = buf.buf;
-	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
+	for (int i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
 		while (*p && *p != '/')
 			p++;
 		/* tolerate duplicate slashes; see check_refname_format() */
@@ -2515,8 +2513,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 				goto out;
 		}
 	} else {
-		struct ref_update *parent_update;
-
 		if (check_old_oid(update, &lock->old_oid, err)) {
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
@@ -2527,9 +2523,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		 * symref update, record the old OID in the parent
 		 * update:
 		 */
-		for (parent_update = update->parent_update;
-		     parent_update;
-		     parent_update = parent_update->parent_update) {
+		for (struct ref_update *parent_update = update->parent_update; parent_update; parent_update = parent_update->parent_update) {
 			struct ref_lock *parent_lock = parent_update->backend_data;
 			oidcpy(&parent_lock->old_oid, &lock->old_oid);
 		}
@@ -2596,12 +2590,11 @@ struct files_transaction_backend_data {
 static void files_transaction_cleanup(struct files_ref_store *refs,
 				      struct ref_transaction *transaction)
 {
-	size_t i;
 	struct files_transaction_backend_data *backend_data =
 		transaction->backend_data;
 	struct strbuf err = STRBUF_INIT;
 
-	for (i = 0; i < transaction->nr; i++) {
+	for (size_t i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 		struct ref_lock *lock = update->backend_data;
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a499a91c7e..96286e239c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -990,8 +990,7 @@ static int jump_list_entry_cmp(const void *va, const void *vb)
 
 static int has_glob_special(const char *str)
 {
-	const char *p;
-	for (p = str; *p; p++) {
+	for (const char *p = str; *p; p++) {
 		if (is_glob_special(*p))
 			return 1;
 	}
@@ -1003,13 +1002,12 @@ static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
 					const char **excluded_patterns)
 {
 	size_t i, j;
-	const char **pattern;
 	struct jump_list_entry *last_disjoint;
 
 	if (!excluded_patterns)
 		return;
 
-	for (pattern = excluded_patterns; *pattern; pattern++) {
+	for (const char **pattern = excluded_patterns; *pattern; pattern++) {
 		struct jump_list_entry *e;
 		const char *start, *end;
 
@@ -1589,7 +1587,6 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
 			"ref_transaction_prepare");
 	struct packed_transaction_backend_data *data;
-	size_t i;
 	int ret = TRANSACTION_GENERIC_ERROR;
 
 	/*
@@ -1610,7 +1607,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 	 * Stick the updates in a string list by refname so that we
 	 * can sort them:
 	 */
-	for (i = 0; i < transaction->nr; i++) {
+	for (size_t i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 		struct string_list_item *item =
 			string_list_append(&data->updates, update->refname);
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index a372a00941..2dd2b70204 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -80,8 +80,7 @@ void free_ref_cache(struct ref_cache *cache)
  */
 static void clear_ref_dir(struct ref_dir *dir)
 {
-	int i;
-	for (i = 0; i < dir->nr; i++)
+	for (int i = 0; i < dir->nr; i++)
 		free_ref_entry(dir->entries[i]);
 	FREE_AND_NULL(dir->entries);
 	dir->sorted = dir->nr = dir->alloc = 0;
@@ -172,8 +171,7 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 					   const char *refname)
 {
-	const char *slash;
-	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
+	for (const char *slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
 		size_t dirnamelen = slash - refname + 1;
 		struct ref_dir *subdir;
 		subdir = search_for_subdir(dir, refname, dirnamelen);
@@ -289,15 +287,7 @@ static enum prefix_state overlaps_prefix(const char *dirname,
  * `prefix` is NULL, prime unconditionally.
  */
 static void prime_ref_dir(struct ref_dir *dir, const char *prefix)
-{
-	/*
-	 * The hard work of loading loose refs is done by get_ref_dir(), so we
-	 * just need to recurse through all of the sub-directories. We do not
-	 * even need to care about sorting, as traversal order does not matter
-	 * to us.
-	 */
-	int i;
-	for (i = 0; i < dir->nr; i++) {
+{for (int i = 0; i < dir->nr; i++) {
 		struct ref_entry *entry = dir->entries[i];
 		if (!(entry->flag & REF_DIR)) {
 			/* Not a directory; no need to recurse. */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index a14f2ad7f4..43c81c60da 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -687,14 +687,13 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 {
 	struct reftable_stack *stack = stack_for(refs, update->refname, NULL);
 	struct write_transaction_table_arg *arg = NULL;
-	size_t i;
 	int ret;
 
 	/*
 	 * Search for a preexisting stack update. If there is one then we add
 	 * the update to it, otherwise we set up a new stack update.
 	 */
-	for (i = 0; !arg && i < tx_data->args_nr; i++)
+	for (size_t i = 0; !arg && i < tx_data->args_nr; i++)
 		if (tx_data->args[i].stack == stack)
 			arg = &tx_data->args[i];
 
@@ -1380,7 +1379,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	struct reftable_iterator it = {0};
 	struct string_list skip = STRING_LIST_INIT_NODUP;
 	struct strbuf errbuf = STRBUF_INIT;
-	size_t logs_nr = 0, logs_alloc = 0, i;
+	size_t logs_nr = 0, logs_alloc = 0;
 	int ret;
 
 	if (reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref)) {
@@ -1553,7 +1552,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	reftable_iterator_destroy(&it);
 	string_list_clear(&skip, 0);
 	strbuf_release(&errbuf);
-	for (i = 0; i < logs_nr; i++) {
+	for (size_t i = 0; i < logs_nr; i++) {
 		if (!strcmp(logs[i].refname, "HEAD"))
 			continue;
 		if (logs[i].value.update.old_hash == old_ref.value.val1)
diff --git a/refspec.c b/refspec.c
index d60932f4de..3c7b08158f 100644
--- a/refspec.c
+++ b/refspec.c
@@ -219,8 +219,7 @@ void refspec_appendf(struct refspec *rs, const char *fmt, ...)
 
 void refspec_appendn(struct refspec *rs, const char **refspecs, int nr)
 {
-	int i;
-	for (i = 0; i < nr; i++)
+	for (int i = 0; i < nr; i++)
 		refspec_append(rs, refspecs[i]);
 }
 
@@ -265,8 +264,7 @@ int valid_remote_name(const char *name)
 void refspec_ref_prefixes(const struct refspec *rs,
 			  struct strvec *ref_prefixes)
 {
-	int i;
-	for (i = 0; i < rs->nr; i++) {
+	for (int i = 0; i < rs->nr; i++) {
 		const struct refspec_item *item = &rs->items[i];
 		const char *prefix = NULL;
 
diff --git a/reftable/basics.c b/reftable/basics.c
index 0785aff941..fd6205ceb6 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -54,11 +54,10 @@ int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
 
 void free_names(char **a)
 {
-	char **p;
 	if (!a) {
 		return;
 	}
-	for (p = a; *p; p++) {
+	for (char **p = a; *p; p++) {
 		reftable_free(*p);
 	}
 	reftable_free(a);
diff --git a/reftable/block.c b/reftable/block.c
index 72eb73b380..c7363ab951 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -129,8 +129,7 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 
 int block_writer_finish(struct block_writer *w)
 {
-	int i;
-	for (i = 0; i < w->restart_len; i++) {
+	for (int i = 0; i < w->restart_len; i++) {
 		put_be24(w->buf + w->next, w->restarts[i]);
 		w->next += 3;
 	}
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index d0f77a3b8f..095c6d68cb 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -142,7 +142,6 @@ static void test_merged_between(void)
 	struct reftable_reader **readers = NULL;
 	struct reftable_merged_table *mt =
 		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
-	int i;
 	struct reftable_ref_record ref = { NULL };
 	struct reftable_iterator it = { NULL };
 	int err = reftable_merged_table_seek_ref(mt, &it, "a");
@@ -155,7 +154,7 @@ static void test_merged_between(void)
 	reftable_iterator_destroy(&it);
 	readers_destroy(readers, 2);
 	reftable_merged_table_free(mt);
-	for (i = 0; i < ARRAY_SIZE(bufs); i++) {
+	for (int i = 0; i < ARRAY_SIZE(bufs); i++) {
 		strbuf_release(&bufs[i]);
 	}
 	reftable_free(bs);
diff --git a/reftable/pq_test.c b/reftable/pq_test.c
index c202eff848..15efd7ba96 100644
--- a/reftable/pq_test.c
+++ b/reftable/pq_test.c
@@ -17,8 +17,7 @@ license that can be found in the LICENSE file or at
 
 void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
 {
-	int i;
-	for (i = 1; i < pq.len; i++) {
+	for (int i = 1; i < pq.len; i++) {
 		int parent = (i - 1) / 2;
 
 		EXPECT(pq_less(&pq.heap[parent], &pq.heap[i]));
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 363fe0f998..2aa24a8ba9 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -119,7 +119,6 @@ static void test_log_buffer_size(void)
 		.block_size = 4096,
 	};
 	int err;
-	int i;
 	struct reftable_log_record
 		log = { .refname = "refs/heads/master",
 			.update_index = 0xa,
@@ -138,7 +137,7 @@ static void test_log_buffer_size(void)
 	   hash, to ensure that the compressed part is larger than the original.
 	*/
 	uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
-	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
+	for (int i = 0; i < GIT_SHA1_RAWSZ; i++) {
 		hash1[i] = (uint8_t)(git_rand() % 256);
 		hash2[i] = (uint8_t)(git_rand() % 256);
 	}
@@ -301,7 +300,7 @@ static void test_log_zlib_corruption(void)
 	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
 	uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };
 	char message[100] = { 0 };
-	int err, i, n;
+	int err, n;
 
 	struct reftable_log_record log = {
 		.refname = "refname",
@@ -317,7 +316,7 @@ static void test_log_zlib_corruption(void)
 		},
 	};
 
-	for (i = 0; i < sizeof(message) - 1; i++)
+	for (int i = 0; i < sizeof(message) - 1; i++)
 		message[i] = (uint8_t)(git_rand() % 64 + ' ');
 
 	reftable_writer_set_limits(w, 1, 1);
@@ -412,7 +411,6 @@ static void test_table_read_api(void)
 	struct reftable_reader rd = { NULL };
 	struct reftable_block_source source = { NULL };
 	int err;
-	int i;
 	struct reftable_log_record log = { NULL };
 	struct reftable_iterator it = { NULL };
 
@@ -430,7 +428,7 @@ static void test_table_read_api(void)
 	EXPECT(err == REFTABLE_API_ERROR);
 
 	strbuf_release(&buf);
-	for (i = 0; i < N; i++) {
+	for (int i = 0; i < N; i++) {
 		reftable_free(names[i]);
 	}
 	reftable_iterator_destroy(&it);
@@ -675,13 +673,12 @@ static void test_write_object_id_min_length(void)
 		.value.val1 = {42},
 	};
 	int err;
-	int i;
 
 	reftable_writer_set_limits(w, 1, 1);
 
 	/* Write the same hash in many refs. If there is only 1 hash, the
 	 * disambiguating prefix is length 0 */
-	for (i = 0; i < 256; i++) {
+	for (int i = 0; i < 256; i++) {
 		char name[256];
 		snprintf(name, sizeof(name), "ref%05d", i);
 		ref.refname = name;
@@ -710,13 +707,12 @@ static void test_write_object_id_length(void)
 		.value.val1 = {42},
 	};
 	int err;
-	int i;
 
 	reftable_writer_set_limits(w, 1, 1);
 
 	/* Write the same hash in many refs. If there is only 1 hash, the
 	 * disambiguating prefix is length 0 */
-	for (i = 0; i < 256; i++) {
+	for (int i = 0; i < 256; i++) {
 		char name[256];
 		snprintf(name, sizeof(name), "ref%05d", i);
 		ref.refname = name;
diff --git a/reftable/record.c b/reftable/record.c
index d6bb42e887..2428746585 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -487,9 +487,7 @@ static void reftable_obj_record_print(const void *rec, int hash_size)
 	const struct reftable_obj_record *obj = rec;
 	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
 	struct strbuf offset_str = STRBUF_INIT;
-	int i;
-
-	for (i = 0; i < obj->offset_len; i++)
+	for (int i = 0; i < obj->offset_len; i++)
 		strbuf_addf(&offset_str, "%" PRIu64 " ", obj->offsets[i]);
 	hex_format(hex, obj->hash_prefix, obj->hash_prefix_len);
 	printf("prefix %s (len %d), offsets [%s]\n",
diff --git a/reftable/record_test.c b/reftable/record_test.c
index a86cff5526..238a53bdc4 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -174,8 +174,6 @@ static void test_reftable_log_record_equal(void)
 
 static void test_reftable_log_record_roundtrip(void)
 {
-	int i;
-
 	struct reftable_log_record in[] = {
 		{
 			.refname = xstrdup("refs/heads/master"),
@@ -215,7 +213,7 @@ static void test_reftable_log_record_roundtrip(void)
 	set_test_hash(in[0].value.update.old_hash, 2);
 	set_test_hash(in[2].value.update.new_hash, 3);
 	set_test_hash(in[2].value.update.old_hash, 4);
-	for (i = 0; i < ARRAY_SIZE(in); i++) {
+	for (int i = 0; i < ARRAY_SIZE(in); i++) {
 		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
 		struct strbuf key = STRBUF_INIT;
 		uint8_t buffer[1024] = { 0 };
diff --git a/reftable/refname_test.c b/reftable/refname_test.c
index b9cc62554e..f00ad7684b 100644
--- a/reftable/refname_test.c
+++ b/reftable/refname_test.c
@@ -39,7 +39,6 @@ static void test_conflict(void)
 		.update_index = 1,
 	};
 	int err;
-	int i;
 	struct reftable_block_source source = { NULL };
 	struct reftable_reader *rd = NULL;
 	struct reftable_table tab = { NULL };
@@ -72,7 +71,7 @@ static void test_conflict(void)
 
 	reftable_table_from_reader(&tab, rd);
 
-	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+	for (int i = 0; i < ARRAY_SIZE(cases); i++) {
 		struct modification mod = {
 			.tab = tab,
 		};
diff --git a/reftable/stack.c b/reftable/stack.c
index b64e55648a..76c3f5f508 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -608,9 +608,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 static void reftable_addition_close(struct reftable_addition *add)
 {
 	struct strbuf nm = STRBUF_INIT;
-	size_t i;
-
-	for (i = 0; i < add->new_tables_len; i++) {
+	for (size_t i = 0; i < add->new_tables_len; i++) {
 		stack_filename(&nm, add->stack, add->new_tables[i]);
 		unlink(nm.buf);
 		reftable_free(add->new_tables[i]);
@@ -1229,13 +1227,13 @@ struct segment *sizes_to_segments(size_t *seglen, uint64_t *sizes, size_t n)
 {
 	struct segment *segs = reftable_calloc(n, sizeof(*segs));
 	struct segment cur = { 0 };
-	size_t next = 0, i;
+	size_t next = 0;
 
 	if (n == 0) {
 		*seglen = 0;
 		return segs;
 	}
-	for (i = 0; i < n; i++) {
+	for (size_t i = 0; i < n; i++) {
 		int log = fastlog2(sizes[i]);
 		if (cur.log != log && cur.bytes > 0) {
 			struct segment fresh = {
@@ -1261,10 +1259,10 @@ struct segment suggest_compaction_segment(uint64_t *sizes, size_t n)
 		.log = 64,
 	};
 	struct segment *segs;
-	size_t seglen = 0, i;
+	size_t seglen = 0;
 
 	segs = sizes_to_segments(&seglen, sizes, n);
-	for (i = 0; i < seglen; i++) {
+	for (size_t i = 0; i < seglen; i++) {
 		if (segment_size(&segs[i]) == 1)
 			continue;
 
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 509f486623..ca4258ce2d 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -294,12 +294,12 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
 	struct reftable_write_options cfg = {0};
 	struct reftable_addition *add = NULL;
 	struct reftable_stack *st = NULL;
-	int i, n = 20, err;
+	int n = 20, err;
 
 	err = reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
 
-	for (i = 0; i <= n; i++) {
+	for (int i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
 			.update_index = reftable_stack_next_update_index(st),
 			.value_type = REFTABLE_REF_SYMREF,
@@ -349,8 +349,6 @@ static void test_reftable_stack_validate_refname(void)
 	struct reftable_stack *st = NULL;
 	int err;
 	char *dir = get_tmp_dir(__LINE__);
-
-	int i;
 	struct reftable_ref_record ref = {
 		.refname = "a/b",
 		.update_index = 1,
@@ -365,7 +363,7 @@ static void test_reftable_stack_validate_refname(void)
 	err = reftable_stack_add(st, &write_test_ref, &ref);
 	EXPECT_ERR(err);
 
-	for (i = 0; i < ARRAY_SIZE(additions); i++) {
+	for (int i = 0; i < ARRAY_SIZE(additions); i++) {
 		struct reftable_ref_record ref = {
 			.refname = additions[i],
 			.update_index = 1,
@@ -424,11 +422,11 @@ static void test_reftable_stack_lock_failure(void)
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
-	int err, i;
+	int err;
 
 	err = reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
-	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
+	for (int i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
 		err = reftable_stack_add(st, &write_error, &i);
 		EXPECT(err == i);
 	}
@@ -890,14 +888,14 @@ static void test_reftable_stack_auto_compaction(void)
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 
-	int err, i;
+	int err;
 	int N = 100;
 
 	err = reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
 
 	st->disable_auto_compact = 1; /* call manually below for coverage. */
-	for (i = 0; i < N; i++) {
+	for (int i = 0; i < N; i++) {
 		char name[100];
 		struct reftable_ref_record ref = {
 			.refname = name,
@@ -928,12 +926,12 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 	struct reftable_stack *st = NULL;
 	struct strbuf refname = STRBUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
-	int err, i, n = 20;
+	int err, n = 20;
 
 	err = reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
 
-	for (i = 0; i <= n; i++) {
+	for (int i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
 			.update_index = reftable_stack_next_update_index(st),
 			.value_type = REFTABLE_REF_SYMREF,
@@ -976,13 +974,13 @@ static void test_reftable_stack_compaction_concurrent(void)
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 
-	int err, i;
+	int err;
 	int N = 3;
 
 	err = reftable_new_stack(&st1, dir, cfg);
 	EXPECT_ERR(err);
 
-	for (i = 0; i < N; i++) {
+	for (int i = 0; i < N; i++) {
 		char name[100];
 		struct reftable_ref_record ref = {
 			.refname = name,
@@ -1026,13 +1024,13 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 
-	int err, i;
+	int err;
 	int N = 3;
 
 	err = reftable_new_stack(&st1, dir, cfg);
 	EXPECT_ERR(err);
 
-	for (i = 0; i < N; i++) {
+	for (int i = 0; i < N; i++) {
 		char name[100];
 		struct reftable_ref_record ref = {
 			.refname = name,
diff --git a/remote-curl.c b/remote-curl.c
index 1161dc7fed..07239e6759 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -563,13 +563,12 @@ static struct ref *get_refs(int for_push)
 
 static void output_refs(struct ref *refs)
 {
-	struct ref *posn;
 	if (options.object_format && options.hash_algo) {
 		printf(":object-format %s\n", options.hash_algo->name);
 		repo_set_hash_algo(the_repository,
 				hash_algo_by_ptr(options.hash_algo));
 	}
-	for (posn = refs; posn; posn = posn->next) {
+	for (struct ref *posn = refs; posn; posn = posn->next) {
 		if (posn->symref)
 			printf("@%s %s\n", posn->symref, posn->name);
 		else
@@ -1317,7 +1316,6 @@ static void parse_get(const char *arg)
 static int push_dav(int nr_spec, const char **specs)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
-	size_t i;
 
 	child.git_cmd = 1;
 	strvec_push(&child.args, "http-push");
@@ -1327,7 +1325,7 @@ static int push_dav(int nr_spec, const char **specs)
 	if (options.verbosity > 1)
 		strvec_push(&child.args, "--verbose");
 	strvec_push(&child.args, url.buf);
-	for (i = 0; i < nr_spec; i++)
+	for (size_t i = 0; i < nr_spec; i++)
 		strvec_push(&child.args, specs[i]);
 
 	if (run_command(&child))
diff --git a/remote.c b/remote.c
index 9090632e96..1ad993e397 100644
--- a/remote.c
+++ b/remote.c
@@ -37,13 +37,13 @@ static int valid_remote(const struct remote *remote)
 
 static const char *alias_url(const char *url, struct rewrites *r)
 {
-	int i, j;
+	int j;
 	struct counted_string *longest;
 	int longest_i;
 
 	longest = NULL;
 	longest_i = -1;
-	for (i = 0; i < r->rewrite_nr; i++) {
+	for (int i = 0; i < r->rewrite_nr; i++) {
 		if (!r->rewrite[i])
 			continue;
 		for (j = 0; j < r->rewrite[i]->instead_of_nr; j++) {
@@ -244,9 +244,7 @@ static struct rewrite *make_rewrite(struct rewrites *r,
 				    const char *base, size_t len)
 {
 	struct rewrite *ret;
-	int i;
-
-	for (i = 0; i < r->rewrite_nr; i++) {
+	for (int i = 0; i < r->rewrite_nr; i++) {
 		if (len == r->rewrite[i]->baselen &&
 		    !strncmp(base, r->rewrite[i]->base, len))
 			return r->rewrite[i];
@@ -484,8 +482,8 @@ static int handle_config(const char *key, const char *value,
 
 static void alias_all_urls(struct remote_state *remote_state)
 {
-	int i, j;
-	for (i = 0; i < remote_state->remotes_nr; i++) {
+	int j;
+	for (int i = 0; i < remote_state->remotes_nr; i++) {
 		int add_pushurl_aliases;
 		if (!remote_state->remotes[i])
 			continue;
@@ -625,7 +623,6 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push)
 
 static void validate_remote_url(struct remote *remote)
 {
-	int i;
 	const char *value;
 	struct strbuf redacted = STRBUF_INIT;
 	int warn_not_die;
@@ -642,7 +639,7 @@ static void validate_remote_url(struct remote *remote)
 	else
 		die(_("unrecognized value transfer.credentialsInUrl: '%s'"), value);
 
-	for (i = 0; i < remote->url_nr; i++) {
+	for (int i = 0; i < remote->url_nr; i++) {
 		struct url_info url_info = { 0 };
 
 		if (!url_normalize(remote->url[i], &url_info) ||
@@ -741,10 +738,9 @@ int remote_is_configured(struct remote *remote, int in_repo)
 
 int for_each_remote(each_remote_fn fn, void *priv)
 {
-	int i, result = 0;
+	int result = 0;
 	read_config(the_repository, 0);
-	for (i = 0; i < the_repository->remote_state->remotes_nr && !result;
-	     i++) {
+	for (int i = 0; i < the_repository->remote_state->remotes_nr && !result; i++) {
 		struct remote *remote =
 			the_repository->remote_state->remotes[i];
 		if (!remote)
@@ -818,8 +814,7 @@ struct ref *ref_remove_duplicates(struct ref *ref_map)
 
 int remote_has_url(struct remote *remote, const char *url)
 {
-	int i;
-	for (i = 0; i < remote->url_nr; i++) {
+	for (int i = 0; i < remote->url_nr; i++) {
 		if (!strcmp(remote->url[i], url))
 			return 1;
 	}
@@ -865,9 +860,7 @@ static int refspec_match(const struct refspec_item *refspec,
 
 int omit_name_by_refspec(const char *name, struct refspec *rs)
 {
-	int i;
-
-	for (i = 0; i < rs->nr; i++) {
+	for (int i = 0; i < rs->nr; i++) {
 		if (rs->items[i].negative && refspec_match(&rs->items[i], name))
 			return 1;
 	}
@@ -953,7 +946,6 @@ static void query_refspecs_multiple(struct refspec *rs,
 				    struct refspec_item *query,
 				    struct string_list *results)
 {
-	int i;
 	int find_src = !query->src;
 
 	if (find_src && !query->dst)
@@ -962,7 +954,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 	if (query_matches_negative_refspec(rs, query))
 		return;
 
-	for (i = 0; i < rs->nr; i++) {
+	for (int i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
@@ -982,7 +974,6 @@ static void query_refspecs_multiple(struct refspec *rs,
 
 int query_refspecs(struct refspec *rs, struct refspec_item *query)
 {
-	int i;
 	int find_src = !query->src;
 	const char *needle = find_src ? query->dst : query->src;
 	char **result = find_src ? &query->src : &query->dst;
@@ -993,7 +984,7 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 	if (query_matches_negative_refspec(rs, query))
 		return -1;
 
-	for (i = 0; i < rs->nr; i++) {
+	for (int i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
@@ -1366,8 +1357,8 @@ static int match_explicit(struct ref *src, struct ref *dst,
 static int match_explicit_refs(struct ref *src, struct ref *dst,
 			       struct ref ***dst_tail, struct refspec *rs)
 {
-	int i, errs;
-	for (i = errs = 0; i < rs->nr; i++)
+	int errs;
+	for (int i = errs = 0; i < rs->nr; i++)
 		errs += match_explicit(src, dst, dst_tail, &rs->items[i]);
 	return errs;
 }
@@ -1378,9 +1369,8 @@ static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
 {
 	const struct refspec_item *pat;
 	char *name;
-	int i;
 	int matching_refs = -1;
-	for (i = 0; i < rs->nr; i++) {
+	for (int i = 0; i < rs->nr; i++) {
 		const struct refspec_item *item = &rs->items[i];
 
 		if (item->negative)
@@ -1586,9 +1576,7 @@ static void prepare_ref_index(struct string_list *ref_index, struct ref *ref)
 int check_push_refs(struct ref *src, struct refspec *rs)
 {
 	int ret = 0;
-	int i;
-
-	for (i = 0; i < rs->nr; i++) {
+	for (int i = 0; i < rs->nr; i++) {
 		struct refspec_item *item = &rs->items[i];
 
 		if (item->pattern || item->matching || item->negative)
@@ -1703,9 +1691,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			     int force_update)
 {
-	struct ref *ref;
-
-	for (ref = remote_refs; ref; ref = ref->next) {
+	for (struct ref *ref = remote_refs; ref; ref = ref->next) {
 		int force_ref_update = ref->force || force_update;
 		int reject_reason = 0;
 
@@ -1798,7 +1784,6 @@ static void set_merge(struct remote_state *remote_state, struct branch *ret)
 	struct remote *remote;
 	char *ref;
 	struct object_id oid;
-	int i;
 
 	if (!ret)
 		return; /* no branch */
@@ -1816,7 +1801,7 @@ static void set_merge(struct remote_state *remote_state, struct branch *ret)
 	remote = remotes_remote_get(remote_state, ret->remote_name);
 
 	CALLOC_ARRAY(ret->merge, ret->merge_nr);
-	for (i = 0; i < ret->merge_nr; i++) {
+	for (int i = 0; i < ret->merge_nr; i++) {
 		ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
 		ret->merge[i]->src = xstrdup(ret->merge_name[i]);
 		if (!remote_find_tracking(remote, ret->merge[i]) ||
@@ -2005,11 +1990,10 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 				    const struct refspec_item *refspec)
 {
 	struct strbuf scratch = STRBUF_INIT;
-	const struct ref *ref;
 	struct ref *ret = NULL;
 	struct ref **tail = &ret;
 
-	for (ref = remote_refs; ref; ref = ref->next) {
+	for (const struct ref *ref = remote_refs; ref; ref = ref->next) {
 		char *expn_name = NULL;
 
 		strbuf_reset(&scratch);
@@ -2036,11 +2020,10 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 
 static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const char *name)
 {
-	const struct ref *ref;
 	const struct ref *best_match = NULL;
 	int best_score = 0;
 
-	for (ref = refs; ref; ref = ref->next) {
+	for (const struct ref *ref = refs; ref; ref = ref->next) {
 		int score = refname_match(name, ref->name);
 
 		if (best_score < score) {
@@ -2424,7 +2407,7 @@ static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
 	struct stale_heads_info *info = cb_data;
 	struct string_list matches = STRING_LIST_INIT_DUP;
 	struct refspec_item query;
-	int i, stale = 1;
+	int stale = 1;
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.dst = (char *)refname;
 
@@ -2442,7 +2425,7 @@ static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
 	if (flags & REF_ISSYMREF)
 		goto clean_exit;
 
-	for (i = 0; stale && i < matches.nr; i++)
+	for (int i = 0; stale && i < matches.nr; i++)
 		if (string_list_has_string(info->ref_names, matches.items[i].string))
 			stale = 0;
 
@@ -2458,14 +2441,14 @@ static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
 
 struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map)
 {
-	struct ref *ref, *stale_refs = NULL;
+	struct ref *stale_refs = NULL;
 	struct string_list ref_names = STRING_LIST_INIT_NODUP;
 	struct stale_heads_info info;
 
 	info.ref_names = &ref_names;
 	info.stale_refs_tail = &stale_refs;
 	info.rs = rs;
-	for (ref = fetch_map; ref; ref = ref->next)
+	for (struct ref *ref = fetch_map; ref; ref = ref->next)
 		string_list_append(&ref_names, ref->name);
 	string_list_sort(&ref_names);
 	for_each_ref(get_stale_heads_cb, &info);
@@ -2478,9 +2461,7 @@ struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map)
  */
 static void clear_cas_option(struct push_cas_option *cas)
 {
-	int i;
-
-	for (i = 0; i < cas->nr; i++)
+	for (int i = 0; i < cas->nr; i++)
 		free(cas->entry[i].refname);
 	free(cas->entry);
 	memset(cas, 0, sizeof(*cas));
@@ -2645,7 +2626,6 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 {
 	timestamp_t date;
 	struct commit *commit;
-	struct commit **chunk;
 	struct check_and_collect_until_cb_data cb;
 	struct reflog_commit_array arr = REFLOG_COMMIT_ARRAY_INIT;
 	size_t size = 0;
@@ -2674,7 +2654,7 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 	 * Check if the remote commit is reachable from any
 	 * of the commits in the collected array, in batches.
 	 */
-	for (chunk = arr.item; chunk < arr.item + arr.nr; chunk += size) {
+	for (struct commit **chunk = arr.item; chunk < arr.item + arr.nr; chunk += size) {
 		size = arr.item + arr.nr - chunk;
 		if (MERGE_BASES_BATCH_SIZE < size)
 			size = MERGE_BASES_BATCH_SIZE;
@@ -2706,10 +2686,7 @@ static void apply_cas(struct push_cas_option *cas,
 		      struct remote *remote,
 		      struct ref *ref)
 {
-	int i;
-
-	/* Find an explicit --<option>=<name>[:<value>] entry */
-	for (i = 0; i < cas->nr; i++) {
+	for (int i = 0; i < cas->nr; i++) {
 		struct push_cas *entry = &cas->entry[i];
 		if (!refname_match(entry->refname, ref->name))
 			continue;
@@ -2742,8 +2719,7 @@ void apply_push_cas(struct push_cas_option *cas,
 		    struct remote *remote,
 		    struct ref *remote_refs)
 {
-	struct ref *ref;
-	for (ref = remote_refs; ref; ref = ref->next) {
+	for (struct ref *ref = remote_refs; ref; ref = ref->next) {
 		apply_cas(cas, remote, ref);
 
 		/*
@@ -2769,9 +2745,7 @@ struct remote_state *remote_state_new(void)
 
 void remote_state_clear(struct remote_state *remote_state)
 {
-	int i;
-
-	for (i = 0; i < remote_state->remotes_nr; i++)
+	for (int i = 0; i < remote_state->remotes_nr; i++)
 		remote_clear(remote_state->remotes[i]);
 	FREE_AND_NULL(remote_state->remotes);
 	remote_state->remotes_alloc = 0;
diff --git a/rerere.c b/rerere.c
index 13c94ded03..9819d76698 100644
--- a/rerere.c
+++ b/rerere.c
@@ -229,8 +229,7 @@ static struct lock_file write_lock;
 
 static int write_rr(struct string_list *rr, int out_fd)
 {
-	int i;
-	for (i = 0; i < rr->nr; i++) {
+	for (int i = 0; i < rr->nr; i++) {
 		struct strbuf buf = STRBUF_INIT;
 		struct rerere_id *id;
 
@@ -693,11 +692,10 @@ static int merge(struct index_state *istate, const struct rerere_id *id, const c
 static void update_paths(struct repository *r, struct string_list *update)
 {
 	struct lock_file index_lock = LOCK_INIT;
-	int i;
 
 	repo_hold_locked_index(r, &index_lock, LOCK_DIE_ON_ERROR);
 
-	for (i = 0; i < update->nr; i++) {
+	for (int i = 0; i < update->nr; i++) {
 		struct string_list_item *item = &update->items[i];
 		if (add_file_to_index(r->index, item->string, 0))
 			exit(128);
@@ -1097,7 +1095,7 @@ static int rerere_forget_one_path(struct index_state *istate,
 
 int rerere_forget(struct repository *r, struct pathspec *pathspec)
 {
-	int i, fd;
+	int fd;
 	struct string_list conflict = STRING_LIST_INIT_DUP;
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
@@ -1115,7 +1113,7 @@ int rerere_forget(struct repository *r, struct pathspec *pathspec)
 	 */
 	unmerge_index(r->index, pathspec, 0);
 	find_conflict(r, &conflict);
-	for (i = 0; i < conflict.nr; i++) {
+	for (int i = 0; i < conflict.nr; i++) {
 		struct string_list_item *it = &conflict.items[i];
 		if (!match_pathspec(r->index, pathspec, it->string,
 				    strlen(it->string), 0, NULL, 0))
@@ -1185,7 +1183,6 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
 	DIR *dir;
 	struct dirent *e;
-	int i;
 	timestamp_t now = time(NULL);
 	timestamp_t cutoff_noresolve = now - 15 * 86400;
 	timestamp_t cutoff_resolve = now - 60 * 86400;
@@ -1224,7 +1221,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	closedir(dir);
 
 	/* ... and then remove the empty directories */
-	for (i = 0; i < to_remove.nr; i++)
+	for (int i = 0; i < to_remove.nr; i++)
 		rmdir(git_path("rr-cache/%s", to_remove.items[i].string));
 	string_list_clear(&to_remove, 0);
 	rollback_lock_file(&write_lock);
@@ -1239,12 +1236,10 @@ void rerere_gc(struct repository *r, struct string_list *rr)
  */
 void rerere_clear(struct repository *r, struct string_list *merge_rr)
 {
-	int i;
-
 	if (setup_rerere(r, merge_rr, 0) < 0)
 		return;
 
-	for (i = 0; i < merge_rr->nr; i++) {
+	for (int i = 0; i < merge_rr->nr; i++) {
 		struct rerere_id *id = merge_rr->items[i].util;
 		if (!has_rerere_resolution(id)) {
 			unlink_rr_item(id);
diff --git a/revision.c b/revision.c
index 2424c9bd67..5b1522cf3e 100644
--- a/revision.c
+++ b/revision.c
@@ -282,8 +282,6 @@ static void commit_stack_clear(struct commit_stack *stack)
 static void mark_one_parent_uninteresting(struct rev_info *revs, struct commit *commit,
 					  struct commit_stack *pending)
 {
-	struct commit_list *l;
-
 	if (commit->object.flags & UNINTERESTING)
 		return;
 	commit->object.flags |= UNINTERESTING;
@@ -296,7 +294,7 @@ static void mark_one_parent_uninteresting(struct rev_info *revs, struct commit *
 	 * wasn't uninteresting), in which case we need
 	 * to mark its parents recursively too..
 	 */
-	for (l = commit->parents; l; l = l->next) {
+	for (struct commit_list *l = commit->parents; l; l = l->next) {
 		commit_stack_push(pending, l->item);
 		if (revs && revs->exclude_first_parent_only)
 			break;
@@ -306,9 +304,7 @@ static void mark_one_parent_uninteresting(struct rev_info *revs, struct commit *
 void mark_parents_uninteresting(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_stack pending = COMMIT_STACK_INIT;
-	struct commit_list *l;
-
-	for (l = commit->parents; l; l = l->next) {
+	for (struct commit_list *l = commit->parents; l; l = l->next) {
 		mark_one_parent_uninteresting(revs, l->item, &pending);
 		if (revs && revs->exclude_first_parent_only)
 			break;
@@ -756,7 +752,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 						 struct commit *commit)
 {
 	struct bloom_filter *filter;
-	int result = 1, j;
+	int result = 1;
 
 	if (!revs->repo->objects->commit_graph)
 		return -1;
@@ -771,7 +767,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 		return -1;
 	}
 
-	for (j = 0; result && j < revs->bloom_keys_nr; j++) {
+	for (int j = 0; result && j < revs->bloom_keys_nr; j++) {
 		result = bloom_filter_contains(filter,
 					       &revs->bloom_keys[j],
 					       revs->bloom_filter_settings);
@@ -1406,8 +1402,7 @@ static void limit_to_ancestry(struct commit_list *bottoms, struct commit_list *l
 static void collect_bottom_commits(struct commit_list *list,
 				   struct commit_list **bottom)
 {
-	struct commit_list *elem;
-	for (elem = list; elem; elem = elem->next)
+	for (struct commit_list *elem = list; elem; elem = elem->next)
 		if (elem->item->object.flags & BOTTOM)
 			commit_list_insert(elem->item, bottom);
 }
@@ -1415,9 +1410,7 @@ static void collect_bottom_commits(struct commit_list *list,
 /* Assumes either left_only or right_only is set */
 static void limit_left_right(struct commit_list *list, struct rev_info *revs)
 {
-	struct commit_list *p;
-
-	for (p = list; p; p = p->next) {
+	for (struct commit_list *p = list; p; p = p->next) {
 		struct commit *commit = p->item;
 
 		if (revs->right_only) {
@@ -1705,10 +1698,10 @@ static int handle_one_reflog(const char *refname_in_wt,
 
 static void add_other_reflogs_to_pending(struct all_refs_cb *cb)
 {
-	struct worktree **worktrees, **p;
+	struct worktree **worktrees;
 
 	worktrees = get_worktrees();
-	for (p = worktrees; *p; p++) {
+	for (struct worktree **p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 
 		if (wt->is_current)
@@ -1739,7 +1732,6 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 			   struct strbuf *path, unsigned int flags)
 {
 	size_t baselen = path->len;
-	int i;
 
 	if (it->entry_count >= 0) {
 		struct tree *tree = lookup_tree(revs->repo, &it->oid);
@@ -1748,7 +1740,7 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 					     040000, path->buf);
 	}
 
-	for (i = 0; i < it->subtree_nr; i++) {
+	for (int i = 0; i < it->subtree_nr; i++) {
 		struct cache_tree_sub *sub = it->down[i];
 		strbuf_addf(path, "%s%s", baselen ? "/" : "", sub->name);
 		add_cache_tree(sub->cache_tree, revs, path, flags);
@@ -1794,11 +1786,9 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 					    struct index_state *istate,
 					    unsigned int flags)
 {
-	int i;
-
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(istate);
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct blob *blob;
 
@@ -1824,7 +1814,7 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 
 void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 {
-	struct worktree **worktrees, **p;
+	struct worktree **worktrees;
 
 	repo_read_index(revs->repo);
 	do_add_index_objects_to_pending(revs, revs->repo->index, flags);
@@ -1833,7 +1823,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 		return;
 
 	worktrees = get_worktrees();
-	for (p = worktrees; *p; p++) {
+	for (struct worktree **p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 		struct index_state istate = INDEX_STATE_INIT(revs->repo);
 
@@ -1967,7 +1957,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	struct commit *head, *other;
 	struct object_id oid;
 	const char **prune = NULL;
-	int i, prune_num = 1; /* counting terminating NULL */
+	int prune_num = 1; /* counting terminating NULL */
 	struct index_state *istate = revs->repo->index;
 
 	if (repo_get_oid(the_repository, "HEAD", &oid))
@@ -1986,7 +1976,7 @@ static void prepare_show_merge(struct rev_info *revs)
 
 	if (!istate->cache_nr)
 		repo_read_index(revs->repo);
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
 			continue;
@@ -2962,7 +2952,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 
 		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
-			int j;
 			if (seen_dashdash || *arg == '^')
 				die("bad revision '%s'", arg);
 
@@ -2972,7 +2961,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			 *     as a valid filename.
 			 * but the latter we have checked in the main loop.
 			 */
-			for (j = i; j < argc; j++)
+			for (int j = i; j < argc; j++)
 				verify_filename(revs->prefix, argv[j], j == i);
 
 			strvec_pushv(&prune_data, argv + i);
@@ -3095,9 +3084,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 static void release_revisions_cmdline(struct rev_cmdline_info *cmdline)
 {
-	unsigned int i;
-
-	for (i = 0; i < cmdline->nr; i++)
+	for (unsigned int i = 0; i < cmdline->nr; i++)
 		free((char *)cmdline->rev[i].name);
 	free(cmdline->rev);
 }
@@ -3232,10 +3219,9 @@ static int mark_redundant_parents(struct commit *commit)
 
 static int mark_treesame_root_parents(struct commit *commit)
 {
-	struct commit_list *p;
 	int marked = 0;
 
-	for (p = commit->parents; p; p = p->next) {
+	for (struct commit_list *p = commit->parents; p; p = p->next) {
 		struct commit *parent = p->item;
 		if (!parent->parents && (parent->object.flags & TREESAME)) {
 			parent->object.flags |= TMP_MARK;
@@ -3499,8 +3485,7 @@ static void simplify_merges(struct rev_info *revs)
 
 static void set_children(struct rev_info *revs)
 {
-	struct commit_list *l;
-	for (l = revs->commits; l; l = l->next) {
+	for (struct commit_list *l = revs->commits; l; l = l->next) {
 		struct commit *commit = l->item;
 		struct commit_list *p;
 
@@ -3569,7 +3554,6 @@ static inline void test_flag_and_insert(struct prio_queue *q, struct commit *c,
 static void explore_walk_step(struct rev_info *revs)
 {
 	struct topo_walk_info *info = revs->topo_walk_info;
-	struct commit_list *p;
 	struct commit *c = prio_queue_get(&info->explore_queue);
 
 	if (!c)
@@ -3592,7 +3576,7 @@ static void explore_walk_step(struct rev_info *revs)
 	if (c->object.flags & UNINTERESTING)
 		mark_parents_uninteresting(revs, c);
 
-	for (p = c->parents; p; p = p->next)
+	for (struct commit_list *p = c->parents; p; p = p->next)
 		test_flag_and_insert(&info->explore_queue, p->item, TOPO_WALK_EXPLORED);
 }
 
@@ -3608,7 +3592,6 @@ static void explore_to_depth(struct rev_info *revs,
 
 static void indegree_walk_step(struct rev_info *revs)
 {
-	struct commit_list *p;
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c = prio_queue_get(&info->indegree_queue);
 
@@ -3622,7 +3605,7 @@ static void indegree_walk_step(struct rev_info *revs)
 
 	explore_to_depth(revs, commit_graph_generation(c));
 
-	for (p = c->parents; p; p = p->next) {
+	for (struct commit_list *p = c->parents; p; p = p->next) {
 		struct commit *parent = p->item;
 		int *pi = indegree_slab_at(&info->indegree, parent);
 
@@ -3760,7 +3743,6 @@ static struct commit *next_topo_commit(struct rev_info *revs)
 
 static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 {
-	struct commit_list *p;
 	struct topo_walk_info *info = revs->topo_walk_info;
 	if (process_parents(revs, commit, NULL, NULL) < 0) {
 		if (!revs->ignore_missing_links)
@@ -3770,7 +3752,7 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 
 	count_topo_walked++;
 
-	for (p = commit->parents; p; p = p->next) {
+	for (struct commit_list *p = commit->parents; p; p = p->next) {
 		struct commit *parent = p->item;
 		int *pi;
 		timestamp_t generation;
@@ -3800,7 +3782,6 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 
 int prepare_revision_walk(struct rev_info *revs)
 {
-	int i;
 	struct object_array old_pending;
 	struct commit_list **next = &revs->commits;
 
@@ -3808,7 +3789,7 @@ int prepare_revision_walk(struct rev_info *revs)
 	revs->pending.nr = 0;
 	revs->pending.alloc = 0;
 	revs->pending.objects = NULL;
-	for (i = 0; i < old_pending.nr; i++) {
+	for (int i = 0; i < old_pending.nr; i++) {
 		struct object_array_entry *e = old_pending.objects + i;
 		struct commit *commit = handle_commit(revs, e);
 		if (commit) {
@@ -4253,7 +4234,6 @@ static void gc_boundary(struct object_array *array)
 
 static void create_boundary_commit_list(struct rev_info *revs)
 {
-	unsigned i;
 	struct commit *c;
 	struct object_array *array = &revs->boundary_commits;
 	struct object_array_entry *objects = array->objects;
@@ -4271,7 +4251,7 @@ static void create_boundary_commit_list(struct rev_info *revs)
 	 * Put all of the actual boundary commits from revs->boundary_commits
 	 * into revs->commits
 	 */
-	for (i = 0; i < array->nr; i++) {
+	for (unsigned i = 0; i < array->nr; i++) {
 		c = (struct commit *)(objects[i].item);
 		if (!c)
 			continue;
@@ -4293,7 +4273,6 @@ static void create_boundary_commit_list(struct rev_info *revs)
 static struct commit *get_revision_internal(struct rev_info *revs)
 {
 	struct commit *c = NULL;
-	struct commit_list *l;
 
 	if (revs->boundary == 2) {
 		/*
@@ -4363,7 +4342,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	 * 'c', we need to mark its parents that they could be boundaries.
 	 */
 
-	for (l = c->parents; l; l = l->next) {
+	for (struct commit_list *l = c->parents; l; l = l->next) {
 		struct object *p;
 		p = &(l->item->object);
 		if (p->flags & (CHILD_SHOWN | SHOWN))
diff --git a/run-command.c b/run-command.c
index 0e7435718a..1834012723 100644
--- a/run-command.c
+++ b/run-command.c
@@ -107,9 +107,7 @@ static void mark_child_for_cleanup(pid_t pid, struct child_process *process)
 
 static void clear_child_for_cleanup(pid_t pid)
 {
-	struct child_to_clean **pp;
-
-	for (pp = &children_to_clean; *pp; pp = &(*pp)->next) {
+	for (struct child_to_clean **pp = &children_to_clean; *pp; pp = &(*pp)->next) {
 		struct child_to_clean *clean_me = *pp;
 
 		if (clean_me->pid == pid) {
@@ -445,7 +443,6 @@ static char **prep_childenv(const char *const *deltaenv)
 	struct string_list env = STRING_LIST_INIT_DUP;
 	struct strbuf key = STRBUF_INIT;
 	const char *const *p;
-	int i;
 
 	/* Construct a sorted string list consisting of the current environ */
 	for (p = (const char *const *) environ; p && *p; p++) {
@@ -478,7 +475,7 @@ static char **prep_childenv(const char *const *deltaenv)
 
 	/* Create an array of 'char *' to be used as the childenv */
 	ALLOC_ARRAY(childenv, env.nr + 1);
-	for (i = 0; i < env.nr; i++)
+	for (int i = 0; i < env.nr; i++)
 		childenv[i] = env.items[i].util;
 	childenv[env.nr] = NULL;
 
@@ -582,12 +579,11 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
 {
 	struct string_list envs = STRING_LIST_INIT_DUP;
-	const char *const *e;
 	int i;
 	int printed_unset = 0;
 
 	/* Last one wins, see run-command.c:prep_childenv() for context */
-	for (e = deltaenv; e && *e; e++) {
+	for (const char * const *e = deltaenv; e && *e; e++) {
 		struct strbuf key = STRBUF_INIT;
 		char *equals = strchr(*e, '=');
 
@@ -769,7 +765,6 @@ int start_command(struct child_process *cmd)
 	cmd->pid = fork();
 	failed_errno = errno;
 	if (!cmd->pid) {
-		int sig;
 		/*
 		 * Ensure the default die/error/warn routines do not get
 		 * called, they can take stdio locks and malloc.
@@ -821,7 +816,7 @@ int start_command(struct child_process *cmd)
 		 * restore default signal handlers here, in case
 		 * we catch a signal right before execve below
 		 */
-		for (sig = 1; sig < NSIG; sig++) {
+		for (int sig = 1; sig < NSIG; sig++) {
 			/* ignored signals get reset to SIG_DFL on execve */
 			if (signal(sig, SIG_DFL) == SIG_IGN)
 				signal(sig, SIG_IGN);
@@ -1077,9 +1072,7 @@ static int git_atexit_installed;
 
 static void git_atexit_dispatch(void)
 {
-	size_t i;
-
-	for (i=git_atexit_hdlrs.nr ; i ; i--)
+	for (size_t i = git_atexit_hdlrs.nr; i; i--)
 		git_atexit_hdlrs.handlers[i-1]();
 }
 
@@ -1812,9 +1805,7 @@ int run_auto_maintenance(int quiet)
 
 void prepare_other_repo_env(struct strvec *env, const char *new_git_dir)
 {
-	const char * const *var;
-
-	for (var = local_repo_env; *var; var++) {
+	for (const char * const *var = local_repo_env; *var; var++) {
 		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
 		    strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
 			strvec_push(env, *var);
diff --git a/scalar.c b/scalar.c
index fb2940c2a0..c2b7ec58ef 100644
--- a/scalar.c
+++ b/scalar.c
@@ -169,10 +169,9 @@ static int set_recommended_config(int reconfigure)
 		{ "fetch.showForcedUpdates", "false" },
 		{ NULL, NULL },
 	};
-	int i;
 	char *value;
 
-	for (i = 0; config[i].key; i++) {
+	for (int i = 0; config[i].key; i++) {
 		if (set_scalar_config(config + i, reconfigure))
 			return error(_("could not configure %s=%s"),
 				     config[i].key, config[i].value);
@@ -644,7 +643,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 		NULL
 	};
 	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
-	int i, res = 0;
+	int res = 0;
 	struct repository r = { NULL };
 	struct strbuf commondir = STRBUF_INIT, gitdir = STRBUF_INIT;
 
@@ -663,7 +662,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 
 	git_config(get_scalar_repos, &scalar_repos);
 
-	for (i = 0; i < scalar_repos.nr; i++) {
+	for (int i = 0; i < scalar_repos.nr; i++) {
 		int succeeded = 0;
 		const char *dir = scalar_repos.items[i].string;
 
diff --git a/send-pack.c b/send-pack.c
index 37f59d4f66..f743fe84b5 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -344,10 +344,9 @@ static int generate_push_cert(struct strbuf *req_buf,
 			      const char *cap_string,
 			      const char *push_cert_nonce)
 {
-	const struct ref *ref;
 	struct string_list_item *item;
 	char *signing_key_id = xstrdup(get_signing_key_id());
-	const char *cp, *np;
+	const char *np;
 	struct strbuf cert = STRBUF_INIT;
 	int update_seen = 0;
 
@@ -367,7 +366,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 			strbuf_addf(&cert, "push-option %s\n", item->string);
 	strbuf_addstr(&cert, "\n");
 
-	for (ref = remote_refs; ref; ref = ref->next) {
+	for (const struct ref *ref = remote_refs; ref; ref = ref->next) {
 		if (check_to_send_update(ref, args) < 0)
 			continue;
 		update_seen = 1;
@@ -383,7 +382,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 		die(_("failed to sign the push certificate"));
 
 	packet_buf_write(req_buf, "push-cert%c%s", 0, cap_string);
-	for (cp = cert.buf; cp < cert.buf + cert.len; cp = np) {
+	for (const char *cp = cert.buf; cp < cert.buf + cert.len; cp = np) {
 		np = next_line(cp, cert.buf + cert.len - cp);
 		packet_buf_write(req_buf,
 				 "%.*s", (int)(np - cp), cp);
@@ -423,14 +422,13 @@ static void get_commons_through_negotiation(const char *url,
 					    struct oid_array *commons)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
-	const struct ref *ref;
 	int len = the_hash_algo->hexsz + 1; /* hash + NL */
 
 	child.git_cmd = 1;
 	child.no_stdin = 1;
 	child.out = -1;
 	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
-	for (ref = remote_refs; ref; ref = ref->next) {
+	for (const struct ref *ref = remote_refs; ref; ref = ref->next) {
 		if (!is_null_oid(&ref->new_oid))
 			strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
 	}
diff --git a/sequencer.c b/sequencer.c
index f49a871ac0..5f5c92c3a2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -321,7 +321,6 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 	struct trailer_info info;
-	size_t i;
 	int found_sob = 0, found_sob_last = 0;
 	char saved_char;
 
@@ -340,7 +339,7 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	if (info.trailer_block_start == info.trailer_block_end)
 		return 0;
 
-	for (i = 0; i < info.trailer_nr; i++)
+	for (size_t i = 0; i < info.trailer_nr; i++)
 		if (sob && !strncmp(info.trailers[i], sob->buf, sob->len)) {
 			found_sob = 1;
 			if (i == info.trailer_nr - 1)
@@ -690,7 +689,6 @@ static int do_recursive_merge(struct repository *r,
 	struct merge_result result;
 	struct tree *next_tree, *base_tree, *head_tree;
 	int clean, show_output;
-	int i;
 	struct lock_file index_lock = LOCK_INIT;
 
 	if (repo_hold_locked_index(r, &index_lock, LOCK_REPORT_ON_ERROR) < 0)
@@ -710,7 +708,7 @@ static int do_recursive_merge(struct repository *r,
 	next_tree = next ? repo_get_commit_tree(r, next) : empty_tree(r);
 	base_tree = base ? repo_get_commit_tree(r, base) : empty_tree(r);
 
-	for (i = 0; i < opts->xopts.nr; i++)
+	for (int i = 0; i < opts->xopts.nr; i++)
 		parse_merge_opt(&o, opts->xopts.v[i]);
 
 	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
@@ -895,7 +893,7 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list kv = STRING_LIST_INIT_DUP;
 	int retval = -1; /* assume failure */
-	int i, name_i = -2, email_i = -2, date_i = -2, err = 0;
+	int name_i = -2, email_i = -2, date_i = -2, err = 0;
 
 	if (strbuf_read_file(&buf, path, 256) <= 0) {
 		strbuf_release(&buf);
@@ -909,7 +907,7 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 	if (parse_key_value_squoted(buf.buf, &kv))
 		goto finish;
 
-	for (i = 0; i < kv.nr; i++) {
+	for (int i = 0; i < kv.nr; i++) {
 		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
 			if (name_i != -2)
 				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
@@ -985,10 +983,9 @@ static char *get_author(const char *message)
 
 static const char *author_date_from_env(const struct strvec *env)
 {
-	int i;
 	const char *date;
 
-	for (i = 0; i < env->nr; i++)
+	for (int i = 0; i < env->nr; i++)
 		if (skip_prefix(env->v[i],
 				"GIT_AUTHOR_DATE=", &date))
 			return date;
@@ -1120,11 +1117,11 @@ static int run_git_commit(const char *defmsg,
 
 static int rest_is_empty(const struct strbuf *sb, int start)
 {
-	int i, eol;
+	int eol;
 	const char *nl;
 
 	/* Check if the rest is just whitespace and Signed-off-by's. */
-	for (i = start; i < sb->len; i++) {
+	for (int i = start; i < sb->len; i++) {
 		nl = memchr(sb->buf + i, '\n', sb->len - i);
 		if (nl)
 			eol = nl - sb->buf;
@@ -2690,11 +2687,11 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 {
 	struct todo_item *item;
 	char *p = buf, *next_p;
-	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
+	int res = 0, fixup_okay = file_exists(rebase_path_done());
 
 	todo_list->current = todo_list->nr = todo_list->total_nr = 0;
 
-	for (i = 1; *p; i++, p = next_p) {
+	for (int i = 1; *p; i++, p = next_p) {
 		char *eol = strchrnul(p, '\n');
 
 		next_p = *eol ? eol + 1 /* skip LF */ : eol;
@@ -2730,9 +2727,9 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 
 static int count_commands(struct todo_list *todo_list)
 {
-	int count = 0, i;
+	int count = 0;
 
-	for (i = 0; i < todo_list->nr; i++)
+	for (int i = 0; i < todo_list->nr; i++)
 		if (todo_list->items[i].command != TODO_COMMENT)
 			count++;
 
@@ -2867,9 +2864,7 @@ static int read_populate_todo(struct repository *r,
 	if (!is_rebase_i(opts)) {
 		enum todo_command valid =
 			opts->action == REPLAY_PICK ? TODO_PICK : TODO_REVERT;
-		int i;
-
-		for (i = 0; i < todo_list->nr; i++)
+		for (int i = 0; i < todo_list->nr; i++)
 			if (valid == todo_list->items[i].command)
 				continue;
 			else if (valid == TODO_PICK)
@@ -2961,7 +2956,6 @@ static int populate_opts_cb(const char *key, const char *value,
 
 static void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
 {
-	int i;
 	int count;
 	const char **argv;
 	char *strategy_opts_string = raw_opts;
@@ -2973,7 +2967,7 @@ static void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
 	if (count < 0)
 		BUG("could not split '%s': %s", strategy_opts_string,
 			    split_cmdline_strerror(count));
-	for (i = 0; i < count; i++) {
+	for (int i = 0; i < count; i++) {
 		const char *arg = argv[i];
 
 		skip_prefix(arg, "--", &arg);
@@ -4455,9 +4449,7 @@ static int is_final_fixup(struct todo_list *todo_list)
 
 static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 {
-	int i;
-
-	for (i = todo_list->current + offset; i < todo_list->nr; i++)
+	for (int i = todo_list->current + offset; i < todo_list->nr; i++)
 		if (!is_noop(todo_list->items[i].command))
 			return todo_list->items[i].command;
 
@@ -5283,13 +5275,13 @@ int sequencer_pick_revisions(struct repository *r,
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct object_id oid;
-	int i, res;
+	int res;
 
 	assert(opts->revs);
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
-	for (i = 0; i < opts->revs->pending.nr; i++) {
+	for (int i = 0; i < opts->revs->pending.nr; i++) {
 		struct object_id oid;
 		const char *name = opts->revs->pending.objects[i].name;
 
diff --git a/serve.c b/serve.c
index a1d71134d4..7cd8f410a6 100644
--- a/serve.c
+++ b/serve.c
@@ -149,12 +149,11 @@ void protocol_v2_advertise_capabilities(void)
 {
 	struct strbuf capability = STRBUF_INIT;
 	struct strbuf value = STRBUF_INIT;
-	int i;
 
 	/* serve by default supports v2 */
 	packet_write_fmt(1, "version 2\n");
 
-	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
+	for (int i = 0; i < ARRAY_SIZE(capabilities); i++) {
 		struct protocol_capability *c = &capabilities[i];
 
 		if (c->advertise(the_repository, &value)) {
@@ -180,12 +179,10 @@ void protocol_v2_advertise_capabilities(void)
 
 static struct protocol_capability *get_capability(const char *key, const char **value)
 {
-	int i;
-
 	if (!key)
 		return NULL;
 
-	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
+	for (int i = 0; i < ARRAY_SIZE(capabilities); i++) {
 		struct protocol_capability *c = &capabilities[i];
 		const char *out;
 		if (!skip_prefix(key, c->name, &out))
diff --git a/server-info.c b/server-info.c
index e2fe0f9143..2ea99f0db9 100644
--- a/server-info.c
+++ b/server-info.c
@@ -196,8 +196,7 @@ static int num_pack;
 
 static struct pack_info *find_pack_by_name(const char *name)
 {
-	int i;
-	for (i = 0; i < num_pack; i++) {
+	for (int i = 0; i < num_pack; i++) {
 		struct packed_git *p = info[i]->p;
 		if (!strcmp(pack_basename(p), name))
 			return info[i];
@@ -289,12 +288,11 @@ static int compare_info(const void *a_, const void *b_)
 
 static void init_pack_info(const char *infofile, int force)
 {
-	struct packed_git *p;
 	int stale;
 	int i;
 	size_t alloc = 0;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
 		 */
@@ -325,16 +323,14 @@ static void init_pack_info(const char *infofile, int force)
 
 static void free_pack_info(void)
 {
-	int i;
-	for (i = 0; i < num_pack; i++)
+	for (int i = 0; i < num_pack; i++)
 		free(info[i]);
 	free(info);
 }
 
 static int write_pack_info_file(struct update_info_ctx *uic)
 {
-	int i;
-	for (i = 0; i < num_pack; i++) {
+	for (int i = 0; i < num_pack; i++) {
 		if (uic_printf(uic, "P %s\n", pack_basename(info[i]->p)) < 0)
 			return -1;
 	}
diff --git a/setup.c b/setup.c
index b69b1cbc2a..d732ae072c 100644
--- a/setup.c
+++ b/setup.c
@@ -224,7 +224,6 @@ static void NORETURN die_verify_filename(struct repository *r,
  */
 static int looks_like_pathspec(const char *arg)
 {
-	const char *p;
 	int escaped = 0;
 
 	/*
@@ -234,7 +233,7 @@ static int looks_like_pathspec(const char *arg)
 	 * cause any increase in the match. Likewise ignore backslash-escaped
 	 * wildcard characters.
 	 */
-	for (p = arg; *p; p++) {
+	for (const char *p = arg; *p; p++) {
 		if (escaped) {
 			escaped = 0;
 		} else if (is_glob_special(*p)) {
@@ -775,27 +774,23 @@ int verify_repository_format(const struct repository_format *format,
 	}
 
 	if (format->version >= 1 && format->unknown_extensions.nr) {
-		int i;
-
 		strbuf_addstr(err, Q_("unknown repository extension found:",
 				      "unknown repository extensions found:",
 				      format->unknown_extensions.nr));
 
-		for (i = 0; i < format->unknown_extensions.nr; i++)
+		for (int i = 0; i < format->unknown_extensions.nr; i++)
 			strbuf_addf(err, "\n\t%s",
 				    format->unknown_extensions.items[i].string);
 		return -1;
 	}
 
 	if (format->version == 0 && format->v1_only_extensions.nr) {
-		int i;
-
 		strbuf_addstr(err,
 			      Q_("repo version is 0, but v1-only extension found:",
 				 "repo version is 0, but v1-only extensions found:",
 				 format->v1_only_extensions.nr));
 
-		for (i = 0; i < format->v1_only_extensions.nr; i++)
+		for (int i = 0; i < format->v1_only_extensions.nr; i++)
 			strbuf_addf(err, "\n\t%s",
 				    format->v1_only_extensions.items[i].string);
 		return -1;
diff --git a/shallow.c b/shallow.c
index 7711798127..fd3860ec84 100644
--- a/shallow.c
+++ b/shallow.c
@@ -332,7 +332,6 @@ static int write_shallow_commits_1(struct strbuf *out, int use_pack_protocol,
 				   unsigned flags)
 {
 	struct write_shallow_data data;
-	int i;
 	data.out = out;
 	data.use_pack_protocol = use_pack_protocol;
 	data.count = 0;
@@ -340,7 +339,7 @@ static int write_shallow_commits_1(struct strbuf *out, int use_pack_protocol,
 	for_each_commit_graft(write_one_shallow, &data);
 	if (!extra)
 		return data.count;
-	for (i = 0; i < extra->nr; i++) {
+	for (int i = 0; i < extra->nr; i++) {
 		strbuf_addstr(out, oid_to_hex(extra->oid + i));
 		strbuf_addch(out, '\n');
 		data.count++;
@@ -462,7 +461,6 @@ struct trace_key trace_shallow = TRACE_KEY_INIT(SHALLOW);
  */
 void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 {
-	int i;
 	trace_printf_key(&trace_shallow, "shallow: prepare_shallow_info\n");
 	memset(info, 0, sizeof(*info));
 	info->shallow = sa;
@@ -470,7 +468,7 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 		return;
 	ALLOC_ARRAY(info->ours, sa->nr);
 	ALLOC_ARRAY(info->theirs, sa->nr);
-	for (i = 0; i < sa->nr; i++) {
+	for (int i = 0; i < sa->nr; i++) {
 		if (repo_has_object_file(the_repository, sa->oid + i)) {
 			struct commit_graft *graft;
 			graft = lookup_commit_graft(the_repository,
@@ -494,9 +492,9 @@ void clear_shallow_info(struct shallow_info *info)
 void remove_nonexistent_theirs_shallow(struct shallow_info *info)
 {
 	struct object_id *oid = info->shallow->oid;
-	int i, dst;
+	int dst;
 	trace_printf_key(&trace_shallow, "shallow: remove_nonexistent_theirs_shallow\n");
-	for (i = dst = 0; i < info->nr_theirs; i++) {
+	for (int i = dst = 0; i < info->nr_theirs; i++) {
 		if (i != dst)
 			info->theirs[dst] = info->theirs[i];
 		if (repo_has_object_file(the_repository, oid + info->theirs[i]))
@@ -738,10 +736,9 @@ static int add_ref(const char *refname UNUSED,
 
 static void update_refstatus(int *ref_status, int nr, uint32_t *bitmap)
 {
-	unsigned int i;
 	if (!ref_status)
 		return;
-	for (i = 0; i < nr; i++)
+	for (unsigned int i = 0; i < nr; i++)
 		if (bitmap[i / 32] & (1U << (i % 32)))
 			ref_status[i]++;
 }
diff --git a/shell.c b/shell.c
index 2ece8b16e2..12ad887390 100644
--- a/shell.c
+++ b/shell.c
@@ -161,7 +161,6 @@ int cmd_main(int argc, const char **argv)
 {
 	char *prog;
 	const char **user_argv;
-	struct commands *cmd;
 	int count;
 
 	/*
@@ -193,7 +192,7 @@ int cmd_main(int argc, const char **argv)
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
 
-	for (cmd = cmd_list ; cmd->name ; cmd++) {
+	for (struct commands *cmd = cmd_list; cmd->name; cmd++) {
 		int len = strlen(cmd->name);
 		char *arg;
 		if (strncmp(cmd->name, prog, len))
diff --git a/sideband.c b/sideband.c
index 266a67342b..ffd5d508ee 100644
--- a/sideband.c
+++ b/sideband.c
@@ -31,7 +31,6 @@ static int use_sideband_colors(void)
 	const char *key = "color.remote";
 	struct strbuf sb = STRBUF_INIT;
 	char *value;
-	int i;
 
 	if (use_sideband_colors_cached >= 0)
 		return use_sideband_colors_cached;
@@ -44,7 +43,7 @@ static int use_sideband_colors(void)
 		use_sideband_colors_cached = GIT_COLOR_AUTO;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
+	for (int i = 0; i < ARRAY_SIZE(keywords); i++) {
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
 		if (git_config_get_string(sb.buf, &value))
@@ -58,9 +57,7 @@ static int use_sideband_colors(void)
 
 void list_config_color_sideband_slots(struct string_list *list, const char *prefix)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(keywords); i++)
+	for (int i = 0; i < ARRAY_SIZE(keywords); i++)
 		list_config_item(list, prefix, keywords[i].keyword);
 }
 
@@ -76,8 +73,6 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
  */
 static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 {
-	int i;
-
 	if (!want_color_stderr(use_sideband_colors())) {
 		strbuf_add(dest, src, n);
 		return;
@@ -89,7 +84,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		n--;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
+	for (int i = 0; i < ARRAY_SIZE(keywords); i++) {
 		struct keyword_entry *p = keywords + i;
 		int len = strlen(p->keyword);
 
diff --git a/sparse-index.c b/sparse-index.c
index e48e40cae7..5017264a18 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -118,8 +118,7 @@ int set_sparse_index_config(struct repository *repo, int enable)
 
 static int index_has_unmerged_entries(struct index_state *istate)
 {
-	int i;
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		if (ce_stage(istate->cache[i]))
 			return 1;
 	}
@@ -290,7 +289,6 @@ static int add_path_to_index(const struct object_id *oid,
 
 void expand_index(struct index_state *istate, struct pattern_list *pl)
 {
-	int i;
 	struct index_state *full;
 	struct strbuf base = STRBUF_INIT;
 	const char *tr_region;
@@ -356,7 +354,7 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 	ctx.write = full;
 	ctx.pl = pl;
 
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct tree *tree;
 		struct pathspec ps;
@@ -491,8 +489,6 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 	const char *last_dirname = NULL;
 	size_t dir_len = 0;
 	int dir_found = 1;
-
-	int i;
 	int path_count[2] = {0, 0};
 	int restarted = 0;
 
@@ -503,7 +499,7 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 	trace2_region_enter("index", "clear_skip_worktree_from_present_files",
 			    istate->repo);
 restart:
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 
 		if (ce_skip_worktree(ce)) {
diff --git a/split-index.c b/split-index.c
index 8c38687c04..2c33e8fcf6 100644
--- a/split-index.c
+++ b/split-index.c
@@ -63,22 +63,13 @@ int write_link_extension(struct strbuf *sb,
 
 static void mark_base_index_entries(struct index_state *base)
 {
-	int i;
-	/*
-	 * To keep track of the shared entries between
-	 * istate->base->cache[] and istate->cache[], base entry
-	 * position is stored in each base entry. All positions start
-	 * from 1 instead of 0, which is reserved to say "this is a new
-	 * entry".
-	 */
-	for (i = 0; i < base->cache_nr; i++)
+	for (int i = 0; i < base->cache_nr; i++)
 		base->cache[i]->index = i + 1;
 }
 
 void move_cache_to_base_index(struct index_state *istate)
 {
 	struct split_index *si = istate->split_index;
-	int i;
 
 	/*
 	 * If there was a previous base index, then transfer ownership of allocated
@@ -111,7 +102,7 @@ void move_cache_to_base_index(struct index_state *istate)
 
 	COPY_ARRAY(si->base->cache, istate->cache, istate->cache_nr);
 	mark_base_index_entries(si->base);
-	for (i = 0; i < si->base->cache_nr; i++)
+	for (int i = 0; i < si->base->cache_nr; i++)
 		si->base->cache[i]->ce_flags &= ~CE_UPDATE_IN_BASE;
 }
 
@@ -156,7 +147,6 @@ static void replace_entry(size_t pos, void *data)
 void merge_base_index(struct index_state *istate)
 {
 	struct split_index *si = istate->split_index;
-	unsigned int i;
 
 	mark_base_index_entries(si->base);
 
@@ -175,7 +165,7 @@ void merge_base_index(struct index_state *istate)
 	if (si->nr_deletions)
 		remove_marked_cache_entries(istate, 0);
 
-	for (i = si->nr_replacements; i < si->saved_cache_nr; i++) {
+	for (unsigned int i = si->nr_replacements; i < si->saved_cache_nr; i++) {
 		if (!ce_namelen(si->saved_cache[i]))
 			die("corrupt link extension, entry %d should "
 			    "have non-zero length name", i);
diff --git a/strbuf.c b/strbuf.c
index 7827178d8e..9463f54e4e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -444,9 +444,9 @@ size_t strbuf_expand_literal(struct strbuf *sb, const char *placeholder)
 
 void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src)
 {
-	size_t i, len = src->len;
+	size_t len = src->len;
 
-	for (i = 0; i < len; i++) {
+	for (size_t i = 0; i < len; i++) {
 		if (src->buf[i] == '%')
 			strbuf_addch(dst, '%');
 		strbuf_addch(dst, src->buf[i]);
@@ -457,9 +457,9 @@ void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src)
 
 void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags)
 {
-	size_t i, len = strlen(src);
+	size_t len = strlen(src);
 
-	for (i = 0; i < len; i++) {
+	for (size_t i = 0; i < len; i++) {
 		unsigned char ch = src[i];
 		if (ch <= 0x1F || ch >= 0x7F ||
 		    (ch == '/' && (flags & STRBUF_ENCODE_SLASH)) ||
@@ -876,11 +876,11 @@ int fprintf_ln(FILE *fp, const char *fmt, ...)
 char *xstrdup_tolower(const char *string)
 {
 	char *result;
-	size_t len, i;
+	size_t len;
 
 	len = strlen(string);
 	result = xmallocz(len);
-	for (i = 0; i < len; i++)
+	for (size_t i = 0; i < len; i++)
 		result[i] = tolower(string[i]);
 	return result;
 }
@@ -888,11 +888,11 @@ char *xstrdup_tolower(const char *string)
 char *xstrdup_toupper(const char *string)
 {
 	char *result;
-	size_t len, i;
+	size_t len;
 
 	len = strlen(string);
 	result = xmallocz(len);
-	for (i = 0; i < len; i++)
+	for (size_t i = 0; i < len; i++)
 		result[i] = toupper(string[i]);
 	return result;
 }
@@ -1011,13 +1011,13 @@ static size_t cleanup(char *line, size_t len)
 void strbuf_stripspace(struct strbuf *sb, char comment_line_char)
 {
 	size_t empties = 0;
-	size_t i, j, len, newlen;
+	size_t j, len, newlen;
 	char *eol;
 
 	/* We may have to add a newline. */
 	strbuf_grow(sb, 1);
 
-	for (i = j = 0; i < sb->len; i += len, j += newlen) {
+	for (size_t i = j = 0; i < sb->len; i += len, j += newlen) {
 		eol = memchr(sb->buf + i, '\n', sb->len - i);
 		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
 
diff --git a/string-list.c b/string-list.c
index 954569f381..8a2c020e81 100644
--- a/string-list.c
+++ b/string-list.c
@@ -114,9 +114,9 @@ struct string_list_item *string_list_lookup(struct string_list *list, const char
 void string_list_remove_duplicates(struct string_list *list, int free_util)
 {
 	if (list->nr > 1) {
-		int src, dst;
+		int dst;
 		compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
-		for (src = dst = 1; src < list->nr; src++) {
+		for (int src = dst = 1; src < list->nr; src++) {
 			if (!cmp(list->items[dst - 1].string, list->items[src].string)) {
 				if (list->strdup_strings)
 					free(list->items[src].string);
@@ -132,8 +132,8 @@ void string_list_remove_duplicates(struct string_list *list, int free_util)
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t fn, void *cb_data)
 {
-	int i, ret = 0;
-	for (i = 0; i < list->nr; i++)
+	int ret = 0;
+	for (int i = 0; i < list->nr; i++)
 		if ((ret = fn(&list->items[i], cb_data)))
 			break;
 	return ret;
@@ -142,8 +142,8 @@ int for_each_string_list(struct string_list *list,
 void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t want, void *cb_data)
 {
-	int src, dst = 0;
-	for (src = 0; src < list->nr; src++) {
+	int dst = 0;
+	for (int src = 0; src < list->nr; src++) {
 		if (want(&list->items[src], cb_data)) {
 			list->items[dst++] = list->items[src];
 		} else {
diff --git a/strvec.c b/strvec.c
index 178f4f3748..44daaa4243 100644
--- a/strvec.c
+++ b/strvec.c
@@ -88,8 +88,7 @@ void strvec_split(struct strvec *array, const char *to_split)
 void strvec_clear(struct strvec *array)
 {
 	if (array->v != empty_strvec) {
-		int i;
-		for (i = 0; i < array->nr; i++)
+		for (int i = 0; i < array->nr; i++)
 			free((char *)array->v[i]);
 		free(array->v);
 	}
diff --git a/submodule.c b/submodule.c
index 213da79f66..1151d98f01 100644
--- a/submodule.c
+++ b/submodule.c
@@ -181,10 +181,9 @@ void add_submodule_odb_by_path(const char *path)
 
 int register_all_submodule_odb_as_alternates(void)
 {
-	int i;
 	int ret = added_submodule_odb_paths.nr;
 
-	for (i = 0; i < added_submodule_odb_paths.nr; i++)
+	for (int i = 0; i < added_submodule_odb_paths.nr; i++)
 		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
 	if (ret) {
 		string_list_clear(&added_submodule_odb_paths, 0);
@@ -329,14 +328,14 @@ int is_submodule_populated_gently(const char *path, int *return_error_code)
 void die_in_unpopulated_submodule(struct index_state *istate,
 				  const char *prefix)
 {
-	int i, prefixlen;
+	int prefixlen;
 
 	if (!prefix)
 		return;
 
 	prefixlen = strlen(prefix);
 
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		int ce_len = ce_namelen(ce);
 
@@ -359,9 +358,9 @@ void die_in_unpopulated_submodule(struct index_state *istate,
 void die_path_inside_submodule(struct index_state *istate,
 			       const struct pathspec *ps)
 {
-	int i, j;
+	int j;
 
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		int ce_len = ce_namelen(ce);
 
@@ -467,8 +466,6 @@ static int prepare_submodule_diff_summary(struct repository *r, struct rev_info
 					  struct commit *left, struct commit *right,
 					  struct commit_list *merge_bases)
 {
-	struct commit_list *list;
-
 	repo_init_revisions(r, rev, NULL);
 	setup_revisions(0, NULL, rev, NULL);
 	rev->left_right = 1;
@@ -476,7 +473,7 @@ static int prepare_submodule_diff_summary(struct repository *r, struct rev_info
 	left->object.flags |= SYMMETRIC_LEFT;
 	add_pending_object(rev, &left->object, path);
 	add_pending_object(rev, &right->object, path);
-	for (list = merge_bases; list; list = list->next) {
+	for (struct commit_list *list = merge_bases; list; list = list->next) {
 		list->item->object.flags |= UNINTERESTING;
 		add_pending_object(rev, &list->item->object,
 			oid_to_hex(&list->item->object.oid));
@@ -843,9 +840,7 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 	struct collect_changed_submodules_cb_data *me = data;
 	struct string_list *changed = me->changed;
 	const struct object_id *commit_oid = me->commit_oid;
-	int i;
-
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		const struct submodule *submodule;
 		const char *name;
@@ -1152,9 +1147,8 @@ static int push_submodule(const char *path,
 		}
 
 		if (remote->origin != REMOTE_UNCONFIGURED) {
-			int i;
 			strvec_push(&cp.args, remote->name);
-			for (i = 0; i < rs->raw_nr; i++)
+			for (int i = 0; i < rs->raw_nr; i++)
 				strvec_push(&cp.args, rs->raw[i]);
 		}
 
@@ -1179,14 +1173,13 @@ static void submodule_push_check(const char *path, const char *head,
 				 const struct refspec *rs)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-	int i;
 
 	strvec_push(&cp.args, "submodule--helper");
 	strvec_push(&cp.args, "push-check");
 	strvec_push(&cp.args, head);
 	strvec_push(&cp.args, remote->name);
 
-	for (i = 0; i < rs->raw_nr; i++)
+	for (int i = 0; i < rs->raw_nr; i++)
 		strvec_push(&cp.args, rs->raw[i]);
 
 	prepare_submodule_repo_env(&cp.env);
@@ -1828,7 +1821,6 @@ int fetch_submodules(struct repository *r,
 		     int default_option,
 		     int quiet, int max_parallel_jobs)
 {
-	int i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
 	const struct run_process_parallel_opts opts = {
 		.tr2_category = "submodule",
@@ -1855,7 +1847,7 @@ int fetch_submodules(struct repository *r,
 		die(_("index file corrupt"));
 
 	strvec_push(&spf.args, "fetch");
-	for (i = 0; i < options->nr; i++)
+	for (int i = 0; i < options->nr; i++)
 		strvec_push(&spf.args, options->v[i]);
 	strvec_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 1281e66876..5292463421 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -9,11 +9,10 @@ static struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 static void add_string_to_filter(const char *data, struct bloom_filter *filter) {
 		struct bloom_key key;
-		int i;
 
 		fill_bloom_key(data, strlen(data), &key, &settings);
 		printf("Hashes:");
-		for (i = 0; i < settings.num_hashes; i++){
+		for (int i = 0; i < settings.num_hashes; i++){
 			printf("0x%08x|", key.hashes[i]);
 		}
 		printf("\n");
@@ -22,15 +21,13 @@ static void add_string_to_filter(const char *data, struct bloom_filter *filter)
 }
 
 static void print_bloom_filter(struct bloom_filter *filter) {
-	int i;
-
 	if (!filter) {
 		printf("No filter.\n");
 		return;
 	}
 	printf("Filter_Length:%d\n", (int)filter->len);
 	printf("Filter_Data:");
-	for (i = 0; i < filter->len; i++) {
+	for (int i = 0; i < filter->len; i++) {
 		printf("%02x|", filter->data[i]);
 	}
 	printf("\n");
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index c38f546e4f..2e7ea4ae0a 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -23,7 +23,6 @@ static int dump_cache_tree(struct cache_tree *it,
 			   struct cache_tree *ref,
 			   const char *pfx)
 {
-	int i;
 	int errs = 0;
 
 	if (!it || !ref)
@@ -46,7 +45,7 @@ static int dump_cache_tree(struct cache_tree *it,
 		}
 	}
 
-	for (i = 0; i < it->subtree_nr; i++) {
+	for (int i = 0; i < it->subtree_nr; i++) {
 		char path[PATH_MAX];
 		struct cache_tree_sub *down = it->down[i];
 		struct cache_tree_sub *rdwn;
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 4f215fea02..5aebfafccb 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -6,7 +6,6 @@
 int cmd__dump_fsmonitor(int ac UNUSED, const char **av UNUSED)
 {
 	struct index_state *istate = the_repository->index;
-	int i;
 
 	setup_git_directory();
 	if (do_read_index(istate, the_repository->index_file, 0) < 0)
@@ -17,7 +16,7 @@ int cmd__dump_fsmonitor(int ac UNUSED, const char **av UNUSED)
 	}
 	printf("fsmonitor last update %s\n", istate->fsmonitor_last_update);
 
-	for (i = 0; i < istate->cache_nr; i++)
+	for (int i = 0; i < istate->cache_nr; i++)
 		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-");
 
 	return 0;
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index f29d18ef94..4b9d493a18 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -15,7 +15,6 @@ static void show_bit(size_t pos, void *data UNUSED)
 int cmd__dump_split_index(int ac UNUSED, const char **av)
 {
 	struct split_index *si;
-	int i;
 
 	setup_git_directory();
 
@@ -27,7 +26,7 @@ int cmd__dump_split_index(int ac UNUSED, const char **av)
 		return 0;
 	}
 	printf("base %s\n", oid_to_hex(&si->base_oid));
-	for (i = 0; i < the_index.cache_nr; i++) {
+	for (int i = 0; i < the_index.cache_nr; i++) {
 		struct cache_entry *ce = the_index.cache[i];
 		printf("%06o %s %d\t%s\n", ce->ce_mode,
 		       oid_to_hex(&ce->oid), ce_stage(ce), ce->name);
diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
index 8f59f6be4c..7eaca18690 100644
--- a/t/helper/test-example-decorate.c
+++ b/t/helper/test-example-decorate.c
@@ -16,7 +16,7 @@ int cmd__example_decorate(int argc UNUSED, const char **argv UNUSED)
 
 	void *ret;
 
-	int i, objects_noticed = 0;
+	int objects_noticed = 0;
 
 	/*
 	 * The struct must be zero-initialized.
@@ -65,7 +65,7 @@ int cmd__example_decorate(int argc UNUSED, const char **argv UNUSED)
 	/*
 	 * The user can also loop through all entries.
 	 */
-	for (i = 0; i < n.size; i++) {
+	for (int i = 0; i < n.size; i++) {
 		if (n.entries[i].base)
 			objects_noticed++;
 	}
diff --git a/t/helper/test-fake-ssh.c b/t/helper/test-fake-ssh.c
index 27323cb367..4487407d5e 100644
--- a/t/helper/test-fake-ssh.c
+++ b/t/helper/test-fake-ssh.c
@@ -7,7 +7,6 @@ int cmd_main(int argc, const char **argv)
 	const char *trash_directory = getenv("TRASH_DIRECTORY");
 	struct strbuf buf = STRBUF_INIT;
 	FILE *f;
-	int i;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	/* First, print all parameters into $TRASH_DIRECTORY/ssh-output */
@@ -18,7 +17,7 @@ int cmd_main(int argc, const char **argv)
 	if (!f)
 		die("Could not write to %s", buf.buf);
 	strbuf_release(&buf);
-	for (i = 0; i < argc; i++)
+	for (int i = 0; i < argc; i++)
 		fprintf(f, "%s%s", i > 0 ? " " : "", i > 0 ? argv[i] : "ssh:");
 	fprintf(f, "\n");
 	fclose(f);
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index e8bd793e58..d270b20b1f 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -21,7 +21,6 @@ static const char *find_pack_usage[] = {
 int cmd__find_pack(int argc, const char **argv)
 {
 	struct object_id oid;
-	struct packed_git *p;
 	int count = -1, actual_count = 0;
 	const char *prefix = setup_git_directory();
 
@@ -37,7 +36,7 @@ int cmd__find_pack(int argc, const char **argv)
 	if (repo_get_oid(the_repository, argv[0], &oid))
 		die("cannot parse %s as an object name", argv[0]);
 
-	for (p = get_all_packs(the_repository); p; p = p->next)
+	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next)
 		if (find_pack_entry_one(oid.hash, p)) {
 			printf("%s\n", p->pack_name);
 			actual_count++;
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index 8280984d08..4bb7e275f3 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -99,12 +99,11 @@ static void *hammer_thread_proc(void *_hammer_thread_data)
 {
 	struct hammer_thread_data *data = _hammer_thread_data;
 	struct strbuf answer = STRBUF_INIT;
-	int k;
 	int ret;
 
 	trace2_thread_start("hammer");
 
-	for (k = 0; k < data->nr_requests; k++) {
+	for (int k = 0; k < data->nr_requests; k++) {
 		strbuf_reset(&answer);
 
 		ret = fsmonitor_ipc__send_query(data->token, &answer);
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 187a115d57..051cb3f18c 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -68,9 +68,7 @@ static uint64_t time_runs(int try_threaded)
 	uint64_t sum = 0;
 	uint64_t avg;
 	int nr_threads_used;
-	int i;
-
-	for (i = 0; i < count; i++) {
+	for (int i = 0; i < count; i++) {
 		t0 = getnanotime();
 		repo_read_index(the_repository);
 		t1 = getnanotime();
diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 42ccc87051..a41ae530d8 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -64,30 +64,26 @@ static int sort_stdin(void)
 
 static void dist_sawtooth(int *arr, int n, int m)
 {
-	int i;
-	for (i = 0; i < n; i++)
+	for (int i = 0; i < n; i++)
 		arr[i] = i % m;
 }
 
 static void dist_rand(int *arr, int n, int m)
 {
-	int i;
 	uint32_t seed = 1;
-	for (i = 0; i < n; i++)
+	for (int i = 0; i < n; i++)
 		arr[i] = minstd_rand(&seed) % m;
 }
 
 static void dist_stagger(int *arr, int n, int m)
 {
-	int i;
-	for (i = 0; i < n; i++)
+	for (int i = 0; i < n; i++)
 		arr[i] = (i * m + i) % n;
 }
 
 static void dist_plateau(int *arr, int n, int m)
 {
-	int i;
-	for (i = 0; i < n; i++)
+	for (int i = 0; i < n; i++)
 		arr[i] = (i < m) ? i : m;
 }
 
@@ -114,8 +110,7 @@ static struct dist {
 
 static const struct dist *get_dist_by_name(const char *name)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(dist); i++) {
+	for (int i = 0; i < ARRAY_SIZE(dist); i++) {
 	       if (!strcmp(dist[i].name, name))
 		       return &dist[i];
 	}
@@ -159,8 +154,7 @@ static void mode_sort(int *arr, int n)
 
 static void mode_dither(int *arr, int n)
 {
-	int i;
-	for (i = 0; i < n; i++)
+	for (int i = 0; i < n; i++)
 		arr[i] += i % 5;
 }
 
@@ -237,8 +231,7 @@ static struct mode {
 
 static const struct mode *get_mode_by_name(const char *name)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(mode); i++) {
+	for (int i = 0; i < ARRAY_SIZE(mode); i++) {
 	       if (!strcmp(mode[i].name, name))
 		       return &mode[i];
 	}
@@ -249,7 +242,7 @@ static int generate(int argc, const char **argv)
 {
 	const struct dist *dist = NULL;
 	const struct mode *mode = NULL;
-	int i, n, m, *arr;
+	int n, m, *arr;
 
 	if (argc != 4)
 		return 1;
@@ -264,7 +257,7 @@ static int generate(int argc, const char **argv)
 	ALLOC_ARRAY(arr, n);
 	dist->fn(arr, n, m);
 	mode->fn(arr, n);
-	for (i = 0; i < n; i++)
+	for (int i = 0; i < n; i++)
 		printf("%08x\n", arr[i]);
 	free(arr);
 	return 0;
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index 67a964ef90..16c9134cf1 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -8,11 +8,10 @@
 
 static void dump_mtimes(struct packed_git *p)
 {
-	uint32_t i;
 	if (load_pack_mtimes(p) < 0)
 		die("could not load pack .mtimes");
 
-	for (i = 0; i < p->num_objects; i++) {
+	for (uint32_t i = 0; i < p->num_objects; i++) {
 		struct object_id oid;
 		if (nth_packed_object_id(&oid, p, i) < 0)
 			die("could not load object id at position %"PRIu32, i);
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index ded8116cc5..c11a4ba222 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -213,8 +213,7 @@ int cmd__parse_options(int argc, const char **argv)
 
 static void print_args(int argc, const char **argv)
 {
-	int i;
-	for (i = 0; i < argc; i++)
+	for (int i = 0; i < argc; i++)
 		printf("arg %02d: %s\n", i, argv[i]);
 }
 
diff --git a/t/helper/test-parse-pathspec-file.c b/t/helper/test-parse-pathspec-file.c
index 89ecefd1cd..59af46b00f 100644
--- a/t/helper/test-parse-pathspec-file.c
+++ b/t/helper/test-parse-pathspec-file.c
@@ -6,7 +6,7 @@ int cmd__parse_pathspec_file(int argc, const char **argv)
 {
 	struct pathspec pathspec;
 	char *pathspec_from_file = NULL;
-	int pathspec_file_nul = 0, i;
+	int pathspec_file_nul = 0;
 
 	static const char *const usage[] = {
 		"test-tool parse-pathspec-file --pathspec-from-file [--pathspec-file-nul]",
@@ -24,7 +24,7 @@ int cmd__parse_pathspec_file(int argc, const char **argv)
 	parse_pathspec_file(&pathspec, 0, 0, NULL, pathspec_from_file,
 			    pathspec_file_nul);
 
-	for (i = 0; i < pathspec.nr; i++)
+	for (int i = 0; i < pathspec.nr; i++)
 		printf("%s\n", pathspec.items[i].original);
 
 	clear_pathspec(&pathspec);
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 70396fa384..4f3d8dda84 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -63,11 +63,11 @@ static char *posix_dirname(char *path)
 static int test_function(struct test_data *data, char *(*func)(char *input),
 	const char *funcname)
 {
-	int failed = 0, i;
+	int failed = 0;
 	char buffer[1024];
 	char *to;
 
-	for (i = 0; data[i].to; i++) {
+	for (int i = 0; data[i].to; i++) {
 		if (!data[i].from)
 			to = func(NULL);
 		else {
@@ -425,10 +425,10 @@ int cmd__path_utils(int argc, const char **argv)
 	}
 
 	if (argc > 2 && !strcmp(argv[1], "file-size")) {
-		int res = 0, i;
+		int res = 0;
 		struct stat st;
 
-		for (i = 2; i < argc; i++)
+		for (int i = 2; i < argc; i++)
 			if (stat(argv[i], &st))
 				res = error_errno("Cannot stat '%s'", argv[i]);
 			else
@@ -484,9 +484,9 @@ int cmd__path_utils(int argc, const char **argv)
 		return !!protect_ntfs_hfs_benchmark(argc - 1, argv + 1);
 
 	if (argc > 1 && !strcmp(argv[1], "is_valid_path")) {
-		int res = 0, expect = 1, i;
+		int res = 0, expect = 1;
 
-		for (i = 2; i < argc; i++)
+		for (int i = 2; i < argc; i++)
 			if (!strcmp("--not", argv[i]))
 				expect = 0;
 			else if (expect != is_valid_path(argv[i]))
diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 4daa82f00f..7d5dc5d804 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -18,8 +18,7 @@ static void pack_line(const char *line)
 static void pack(int argc, const char **argv)
 {
 	if (argc) { /* read from argv */
-		int i;
-		for (i = 0; i < argc; i++)
+		for (int i = 0; i < argc; i++)
 			pack_line(argv[i]);
 	} else { /* read from stdin */
 		char line[LARGE_PACKET_MAX];
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index f30022d222..b04220cdd5 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -169,14 +169,12 @@ int cmd__proc_receive(int argc, const char **argv)
 	proc_receive_read_push_options(&reader, &push_options);
 
 	if (verbose) {
-		struct command *cmd;
-
 		if (use_push_options || use_atomic)
 			fprintf(stderr, "proc-receive:%s%s\n",
 				use_atomic? " atomic": "",
 				use_push_options ? " push_options": "");
 
-		for (cmd = commands; cmd; cmd = cmd->next)
+		for (struct command *cmd = commands; cmd; cmd = cmd->next)
 			fprintf(stderr, "proc-receive< %s %s %s\n",
 				oid_to_hex(&cmd->old_oid),
 				oid_to_hex(&cmd->new_oid),
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 1e159a754d..85f895af42 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -11,7 +11,6 @@
 
 static void print_sorted_commit_ids(struct commit_list *list)
 {
-	int i;
 	struct string_list s = STRING_LIST_INIT_DUP;
 
 	while (list) {
@@ -21,7 +20,7 @@ static void print_sorted_commit_ids(struct commit_list *list)
 
 	string_list_sort(&s);
 
-	for (i = 0; i < s.nr; i++)
+	for (int i = 0; i < s.nr; i++)
 		printf("%s\n", s.items[i].string);
 
 	string_list_clear(&s, 0);
@@ -148,19 +147,18 @@ int cmd__reach(int ac, const char **av)
 		printf("%s(_,A,X,_):%d\n", av[1], commit_contains(&filter, A, X, &cache));
 	} else if (!strcmp(av[1], "get_reachable_subset")) {
 		const int reachable_flag = 1;
-		int i, count = 0;
-		struct commit_list *current;
+		int count = 0;
 		struct commit_list *list = get_reachable_subset(X_array, X_nr,
 								Y_array, Y_nr,
 								reachable_flag);
 		printf("get_reachable_subset(X,Y)\n");
-		for (current = list; current; current = current->next) {
+		for (struct commit_list *current = list; current; current = current->next) {
 			if (!(list->item->object.flags & reachable_flag))
 				die(_("commit %s is not marked reachable"),
 				    oid_to_hex(&list->item->object.oid));
 			count++;
 		}
-		for (i = 0; i < Y_nr; i++) {
+		for (int i = 0; i < Y_nr; i++) {
 			if (Y_array[i]->object.flags & reachable_flag)
 				count--;
 		}
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 1acd362346..5ace22d38a 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -7,7 +7,7 @@
 
 int cmd__read_cache(int argc, const char **argv)
 {
-	int i, cnt = 1;
+	int cnt = 1;
 	const char *name = NULL;
 
 	initialize_the_repository();
@@ -22,7 +22,7 @@ int cmd__read_cache(int argc, const char **argv)
 	setup_git_directory();
 	git_config(git_default_config, NULL);
 
-	for (i = 0; i < cnt; i++) {
+	for (int i = 0; i < cnt; i++) {
 		repo_read_index(the_repository);
 		if (name) {
 			int pos;
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 4acae41bb9..48d751ba87 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -101,7 +101,6 @@ static int read_midx_bitmapped_packs(const char *object_dir)
 {
 	struct multi_pack_index *midx = NULL;
 	struct bitmapped_pack pack;
-	uint32_t i;
 
 	setup_git_directory();
 
@@ -109,7 +108,7 @@ static int read_midx_bitmapped_packs(const char *object_dir)
 	if (!midx)
 		return 1;
 
-	for (i = 0; i < midx->num_packs; i++) {
+	for (uint32_t i = 0; i < midx->num_packs; i++) {
 		if (nth_bitmapped_pack(the_repository, midx, &pack, i) < 0)
 			return 1;
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 702ec1f128..3a4099decf 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -346,7 +346,6 @@ int cmd__ref_store(int argc UNUSED, const char **argv)
 {
 	struct ref_store *refs;
 	const char *func;
-	struct command *cmd;
 
 	setup_git_directory();
 
@@ -355,7 +354,7 @@ int cmd__ref_store(int argc UNUSED, const char **argv)
 	func = *argv++;
 	if (!func)
 		die("ref function required");
-	for (cmd = commands; cmd->name; cmd++) {
+	for (struct command *cmd = commands; cmd->name; cmd++) {
 		if (!strcmp(func, cmd->name))
 			return cmd->func(refs, argv);
 	}
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 0c7c5aa4dd..c6049eda11 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -13,7 +13,6 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 {
 	struct repository r;
 	struct commit *c;
-	struct commit_list *parent;
 
 	setup_git_env(gitdir);
 
@@ -30,7 +29,7 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 		die("Couldn't parse commit");
 
 	printf("%"PRItime, c->date);
-	for (parent = c->parents; parent; parent = parent->next)
+	for (struct commit_list *parent = c->parents; parent; parent = parent->next)
 		printf(" %s", oid_to_hex(&parent->item->object.oid));
 	printf("\n");
 
diff --git a/t/helper/test-rot13-filter.c b/t/helper/test-rot13-filter.c
index f8d564c622..1461bb6fac 100644
--- a/t/helper/test-rot13-filter.c
+++ b/t/helper/test-rot13-filter.c
@@ -53,8 +53,7 @@ static inline const char *str_or_null(const char *str)
 
 static char *rot13(char *str)
 {
-	char *c;
-	for (c = str; *c; c++)
+	for (char *c = str; *c; c++)
 		if (isalpha(*c))
 			*c += tolower(*c) < 'n' ? 13 : -13;
 	return str;
@@ -108,8 +107,7 @@ static void read_capabilities(struct strset *remote_caps)
 static void check_and_write_capabilities(struct strset *remote_caps,
 					 const char **caps, int nr_caps)
 {
-	int i;
-	for (i = 0; i < nr_caps; i++) {
+	for (int i = 0; i < nr_caps; i++) {
 		if (!strset_contains(remote_caps, caps[i]))
 			die("our capability '%s' is not available from remote",
 			    caps[i]);
@@ -330,7 +328,7 @@ static const char *rot13_usage[] = {
 
 int cmd__rot13_filter(int argc, const char **argv)
 {
-	int i, nr_caps;
+	int nr_caps;
 	struct strset remote_caps = STRSET_INIT;
 	const char *log_path = NULL;
 
@@ -351,7 +349,7 @@ int cmd__rot13_filter(int argc, const char **argv)
 	if (!logfile)
 		die_errno("failed to open log file");
 
-	for (i = 0; i < nr_caps; i++) {
+	for (int i = 0; i < nr_caps; i++) {
 		if (!strcmp(argv[i], "smudge"))
 			has_smudge_cap = 1;
 		if (!strcmp(argv[i], "clean"))
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index c0ed8722c8..e8d854de2e 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -230,7 +230,7 @@ static int quote_stress_test(int argc, const char **argv)
 	 * were passed in.
 	 */
 	char special[] = ".?*\\^_\"'`{}()[]<>@~&+:;$%"; // \t\r\n\a";
-	int i, j, k, trials = 100, skip = 0, msys2 = 0;
+	int j, k, trials = 100, skip = 0, msys2 = 0;
 	struct strbuf out = STRBUF_INIT;
 	struct strvec args = STRVEC_INIT;
 	struct option options[] = {
@@ -248,7 +248,7 @@ static int quote_stress_test(int argc, const char **argv)
 
 	setenv("MSYS_NO_PATHCONV", "1", 0);
 
-	for (i = 0; i < trials; i++) {
+	for (int i = 0; i < trials; i++) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		size_t arg_count, arg_offset;
 		int ret = 0;
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index fb5927775d..022c022ae0 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -49,10 +49,9 @@ static int app__big_command(ipc_server_reply_cb *reply_cb,
 			    struct ipc_server_reply_data *reply_data)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int row;
 	int ret;
 
-	for (row = 0; row < BIG_ROWS; row++)
+	for (int row = 0; row < BIG_ROWS; row++)
 		strbuf_addf(&buf, "big: %.75d\n", row);
 
 	ret = reply_cb(reply_data, buf.buf, buf.len);
@@ -70,10 +69,9 @@ static int app__chunk_command(ipc_server_reply_cb *reply_cb,
 			      struct ipc_server_reply_data *reply_data)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int row;
 	int ret;
 
-	for (row = 0; row < CHUNK_ROWS; row++) {
+	for (int row = 0; row < CHUNK_ROWS; row++) {
 		strbuf_setlen(&buf, 0);
 		strbuf_addf(&buf, "big: %.75d\n", row);
 		ret = reply_cb(reply_data, buf.buf, buf.len);
@@ -95,10 +93,9 @@ static int app__slow_command(ipc_server_reply_cb *reply_cb,
 			     struct ipc_server_reply_data *reply_data)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int row;
 	int ret;
 
-	for (row = 0; row < SLOW_ROWS; row++) {
+	for (int row = 0; row < SLOW_ROWS; row++) {
 		strbuf_setlen(&buf, 0);
 		strbuf_addf(&buf, "big: %.75d\n", row);
 		ret = reply_cb(reply_data, buf.buf, buf.len);
@@ -120,7 +117,6 @@ static int app__sendbytes_command(const char *received, size_t received_len,
 	struct strbuf buf_resp = STRBUF_INIT;
 	const char *p = "?";
 	int len_ballast = 0;
-	int k;
 	int errs = 0;
 	int ret;
 
@@ -138,7 +134,7 @@ static int app__sendbytes_command(const char *received, size_t received_len,
 	 * Verify that the ballast is n copies of a single letter.
 	 * And that the multi-threaded IO layer didn't cross the streams.
 	 */
-	for (k = 1; k < len_ballast; k++)
+	for (int k = 1; k < len_ballast; k++)
 		if (p[k] != p[0])
 			errs++;
 
@@ -500,7 +496,6 @@ struct multiple_thread_data {
 static void *multiple_thread_proc(void *_multiple_thread_data)
 {
 	struct multiple_thread_data *d = _multiple_thread_data;
-	int k;
 	struct ipc_client_connect_options options
 		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
 
@@ -515,7 +510,7 @@ static void *multiple_thread_proc(void *_multiple_thread_data)
 
 	trace2_thread_start("multiple");
 
-	for (k = 0; k < d->batchsize; k++) {
+	for (int k = 0; k < d->batchsize; k++) {
 		if (do_sendbytes(d->bytecount + k, d->letter, d->path, &options))
 			d->sum_errors++;
 		else
@@ -533,12 +528,11 @@ static void *multiple_thread_proc(void *_multiple_thread_data)
 static int client__multiple(void)
 {
 	struct multiple_thread_data *list = NULL;
-	int k;
 	int sum_join_errors = 0;
 	int sum_thread_errors = 0;
 	int sum_good = 0;
 
-	for (k = 0; k < cl_args.nr_threads; k++) {
+	for (int k = 0; k < cl_args.nr_threads; k++) {
 		struct multiple_thread_data *d = xcalloc(1, sizeof(*d));
 		d->next = list;
 		d->path = cl_args.path;
diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index e2aad611d1..4f465d399f 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -18,8 +18,7 @@ static void parse_string_list(struct string_list *list, const char *arg)
 
 static void write_list(const struct string_list *list)
 {
-	int i;
-	for (i = 0; i < list->nr; i++)
+	for (int i = 0; i < list->nr; i++)
 		printf("[%d]: \"%s\"\n", i, list->items[i].string);
 }
 
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 7197969a08..773aec81ec 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -224,14 +224,13 @@ int cmd__submodule(int argc, const char **argv)
 	struct option options[] = {
 		OPT_END()
 	};
-	size_t i;
 
 	argc = parse_options(argc, argv, "test-tools", options, submodule_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	if (argc < 1)
 		usage_with_options(submodule_usage, options);
 
-	for (i = 0; i < ARRAY_SIZE(cmds); i++)
+	for (size_t i = 0; i < ARRAY_SIZE(cmds); i++)
 		if (!strcmp(cmds[i].name, argv[0]))
 			return cmds[i].fn(argc, argv);
 
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 482a1e58a4..fb4749d1cf 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -96,17 +96,14 @@ static struct test_cmd cmds[] = {
 
 static NORETURN void die_usage(void)
 {
-	size_t i;
-
 	fprintf(stderr, "usage: test-tool <toolname> [args]\n");
-	for (i = 0; i < ARRAY_SIZE(cmds); i++)
+	for (size_t i = 0; i < ARRAY_SIZE(cmds); i++)
 		fprintf(stderr, "  %s\n", cmds[i].name);
 	exit(128);
 }
 
 int cmd_main(int argc, const char **argv)
 {
-	int i;
 	const char *working_directory = NULL;
 	struct option options[] = {
 		OPT_STRING('C', NULL, &working_directory, "directory",
@@ -125,7 +122,7 @@ int cmd_main(int argc, const char **argv)
 	if (working_directory && chdir(working_directory) < 0)
 		die("Could not cd to '%s'", working_directory);
 
-	for (i = 0; i < ARRAY_SIZE(cmds); i++) {
+	for (int i = 0; i < ARRAY_SIZE(cmds); i++) {
 		if (!strcmp(cmds[i].name, argv[1])) {
 			argv++;
 			argc--;
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 1adac29a57..74e3c13e2c 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -87,12 +87,10 @@ static int ut_002exit(int argc UNUSED, const char **argv)
  */
 static int ut_003error(int argc, const char **argv)
 {
-	int k;
-
 	if (!argv[0] || !*argv[0])
 		die("expect <error_message>");
 
-	for (k = 0; k < argc; k++)
+	for (int k = 0; k < argc; k++)
 		error("%s", argv[k]);
 
 	return 0;
@@ -244,7 +242,6 @@ static int ut_100timer(int argc, const char **argv)
 
 	int count = 0;
 	int delay = 0;
-	int k;
 
 	if (argc != 2)
 		die("%s", usage_error);
@@ -253,7 +250,7 @@ static int ut_100timer(int argc, const char **argv)
 	if (get_i(&delay, argv[1]))
 		die("%s", usage_error);
 
-	for (k = 0; k < count; k++) {
+	for (int k = 0; k < count; k++) {
 		trace2_timer_start(TRACE2_TIMER_ID_TEST1);
 		sleep_millisec(delay);
 		trace2_timer_stop(TRACE2_TIMER_ID_TEST1);
@@ -270,11 +267,10 @@ struct ut_101_data {
 static void *ut_101timer_thread_proc(void *_ut_101_data)
 {
 	struct ut_101_data *data = _ut_101_data;
-	int k;
 
 	trace2_thread_start("ut_101");
 
-	for (k = 0; k < data->count; k++) {
+	for (int k = 0; k < data->count; k++) {
 		trace2_timer_start(TRACE2_TIMER_ID_TEST2);
 		sleep_millisec(data->delay);
 		trace2_timer_stop(TRACE2_TIMER_ID_TEST2);
@@ -336,12 +332,11 @@ static int ut_200counter(int argc, const char **argv)
 	const char *usage_error =
 		"expect <v1> [<v2> [...]]";
 	int value;
-	int k;
 
 	if (argc < 1)
 		die("%s", usage_error);
 
-	for (k = 0; k < argc; k++) {
+	for (int k = 0; k < argc; k++) {
 		if (get_i(&value, argv[k]))
 			die("invalid value[%s] -- %s",
 			    argv[k], usage_error);
@@ -425,12 +420,11 @@ static int ut_300redact_start(int argc, const char **argv)
 static int ut_301redact_child_start(int argc, const char **argv)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	int k;
 
 	if (!argc)
 		die("expect <argv...>");
 
-	for (k = 0; argv[k]; k++)
+	for (int k = 0; argv[k]; k++)
 		strvec_push(&cmd.args, argv[k]);
 
 	trace2_child_start(&cmd);
diff --git a/t/helper/test-wildmatch.c b/t/helper/test-wildmatch.c
index b4ff5f986a..81935ff3fb 100644
--- a/t/helper/test-wildmatch.c
+++ b/t/helper/test-wildmatch.c
@@ -3,8 +3,7 @@
 
 int cmd__wildmatch(int argc, const char **argv)
 {
-	int i;
-	for (i = 2; i < argc; i++) {
+	for (int i = 2; i < argc; i++) {
 		if (argv[i][0] == '/')
 			die("Forward slash is not allowed at the beginning of the\n"
 			    "pattern because Windows does not like it. Use `XXX/' instead.");
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index f084034d38..b585358253 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -8,12 +8,12 @@
 int cmd__write_cache(int argc, const char **argv)
 {
 	struct lock_file index_lock = LOCK_INIT;
-	int i, cnt = 1;
+	int cnt = 1;
 	if (argc == 2)
 		cnt = strtol(argv[1], NULL, 0);
 	setup_git_directory();
 	repo_read_index(the_repository);
-	for (i = 0; i < cnt; i++) {
+	for (int i = 0; i < cnt; i++) {
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 66d6980ffb..484a6e9fe9 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -31,7 +31,7 @@ static struct {
 
 static const char *make_relative(const char *location)
 {
-	static char prefix[] = __FILE__, buf[PATH_MAX], *p;
+	static char prefix[] = __FILE__, buf[PATH_MAX];
 	static size_t prefix_len;
 	static int need_bs_to_fs = -1;
 
@@ -88,7 +88,7 @@ static const char *make_relative(const char *location)
 
 	/* convert backslashes to forward slashes */
 	strlcpy(buf, location + prefix_len, sizeof(buf));
-	for (p = buf; *p; p++)
+	for (char *p = buf; *p; p++)
 		if (*p == '\\')
 			*p = '/';
 	return buf;
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 3509258be5..4ac96bf16e 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -225,7 +225,6 @@ static int migrate_paths(struct strbuf *src, struct strbuf *dst)
 {
 	size_t src_len = src->len, dst_len = dst->len;
 	struct string_list paths = STRING_LIST_INIT_DUP;
-	int i;
 	int ret = 0;
 
 	if (read_dir_paths(&paths, src->buf) < 0)
@@ -233,7 +232,7 @@ static int migrate_paths(struct strbuf *src, struct strbuf *dst)
 	paths.cmp = pack_copy_cmp;
 	string_list_sort(&paths);
 
-	for (i = 0; i < paths.nr; i++) {
+	for (int i = 0; i < paths.nr; i++) {
 		const char *name = paths.items[i].string;
 
 		strbuf_addf(src, "/%s", name);
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index d96d908bb9..634f499d5a 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -103,10 +103,9 @@ struct tr2_cfg_data {
 static int tr2_cfg_cb(const char *key, const char *value,
 		      const struct config_context *ctx, void *d)
 {
-	struct strbuf **s;
 	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
 
-	for (s = tr2_cfg_patterns; *s; s++) {
+	for (struct strbuf **s = tr2_cfg_patterns; *s; s++) {
 		struct strbuf *buf = *s;
 		int wm = wildmatch(buf->buf, key, WM_CASEFOLD);
 		if (wm == WM_MATCH) {
@@ -130,13 +129,12 @@ void tr2_cfg_list_config_fl(const char *file, int line)
 void tr2_list_env_vars_fl(const char *file, int line)
 {
 	struct key_value_info kvi = KVI_INIT;
-	struct strbuf **s;
 
 	kvi_from_param(&kvi);
 	if (tr2_load_env_vars() <= 0)
 		return;
 
-	for (s = tr2_cfg_env_vars; *s; s++) {
+	for (struct strbuf **s = tr2_cfg_env_vars; *s; s++) {
 		struct strbuf *buf = *s;
 		const char *val = getenv(buf->buf);
 		if (val && *val)
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index d3a33715c1..1e742ed912 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -60,7 +60,6 @@ void tr2_counter_increment(enum trace2_counter_id cid, uint64_t value)
 void tr2_update_final_counters(void)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	enum trace2_counter_id cid;
 
 	if (!ctx->used_any_counter)
 		return;
@@ -70,7 +69,7 @@ void tr2_update_final_counters(void)
 	 * We assume that our caller is holding the lock.
 	 */
 
-	for (cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++) {
+	for (enum trace2_counter_id cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++) {
 		struct tr2_counter *c_final = &final_counter_block.counter[cid];
 		const struct tr2_counter *c = &ctx->counter_block.counter[cid];
 
@@ -81,7 +80,6 @@ void tr2_update_final_counters(void)
 void tr2_emit_per_thread_counters(tr2_tgt_evt_counter_t *fn_apply)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	enum trace2_counter_id cid;
 
 	if (!ctx->used_any_per_thread_counter)
 		return;
@@ -90,7 +88,7 @@ void tr2_emit_per_thread_counters(tr2_tgt_evt_counter_t *fn_apply)
 	 * For each counter, if the counter wants per-thread events
 	 * and this thread used it (the value is non-zero), emit it.
 	 */
-	for (cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++)
+	for (enum trace2_counter_id cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++)
 		if (tr2_counter_metadata[cid].want_per_thread_events &&
 		    ctx->counter_block.counter[cid].value)
 			fn_apply(&tr2_counter_metadata[cid],
@@ -100,14 +98,7 @@ void tr2_emit_per_thread_counters(tr2_tgt_evt_counter_t *fn_apply)
 
 void tr2_emit_final_counters(tr2_tgt_evt_counter_t *fn_apply)
 {
-	enum trace2_counter_id cid;
-
-	/*
-	 * Access `final_counter_block` requires holding `tr2tls_mutex`.
-	 * We assume that our caller is holding the lock.
-	 */
-
-	for (cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++)
+	for (enum trace2_counter_id cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++)
 		if (final_counter_block.counter[cid].value)
 			fn_apply(&tr2_counter_metadata[cid],
 				 &final_counter_block.counter[cid],
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index 09c4ef0d17..fc878833a2 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -77,8 +77,7 @@ static void tr2_sid_compute(void)
 
 	parent_sid = getenv(TR2_ENVVAR_PARENT_SID);
 	if (parent_sid && *parent_sid) {
-		const char *p;
-		for (p = parent_sid; *p; p++)
+		for (const char *p = parent_sid; *p; p++)
 			if (*p == '/')
 				tr2sid_nr_git_parents++;
 
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index 048cdd5438..61737950cd 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -61,12 +61,10 @@ static int tr2_sysenv_cb(const char *key, const char *value,
 			 const struct config_context *ctx UNUSED,
 			 void *d UNUSED)
 {
-	int k;
-
 	if (!starts_with(key, "trace2."))
 		return 0;
 
-	for (k = 0; k < ARRAY_SIZE(tr2_sysenv_settings); k++) {
+	for (int k = 0; k < ARRAY_SIZE(tr2_sysenv_settings); k++) {
 		if (!strcmp(key, tr2_sysenv_settings[k].git_config_name)) {
 			if (!value)
 				return config_error_nonbool(key);
@@ -129,8 +127,6 @@ const char *tr2_sysenv_display_name(enum tr2_sysenv_variable var)
 
 void tr2_sysenv_release(void)
 {
-	int k;
-
-	for (k = 0; k < ARRAY_SIZE(tr2_sysenv_settings); k++)
+	for (int k = 0; k < ARRAY_SIZE(tr2_sysenv_settings); k++)
 		free(tr2_sysenv_settings[k].value);
 }
diff --git a/trace2/tr2_tmr.c b/trace2/tr2_tmr.c
index 51f564b07a..1665525b89 100644
--- a/trace2/tr2_tmr.c
+++ b/trace2/tr2_tmr.c
@@ -88,7 +88,6 @@ void tr2_stop_timer(enum trace2_timer_id tid)
 void tr2_update_final_timers(void)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	enum trace2_timer_id tid;
 
 	if (!ctx->used_any_timer)
 		return;
@@ -98,7 +97,7 @@ void tr2_update_final_timers(void)
 	 * We assume that our caller is holding the lock.
 	 */
 
-	for (tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++) {
+	for (enum trace2_timer_id tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++) {
 		struct tr2_timer *t_final = &final_timer_block.timer[tid];
 		struct tr2_timer *t = &ctx->timer_block.timer[tid];
 
@@ -148,7 +147,6 @@ void tr2_update_final_timers(void)
 void tr2_emit_per_thread_timers(tr2_tgt_evt_timer_t *fn_apply)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	enum trace2_timer_id tid;
 
 	if (!ctx->used_any_per_thread_timer)
 		return;
@@ -157,7 +155,7 @@ void tr2_emit_per_thread_timers(tr2_tgt_evt_timer_t *fn_apply)
 	 * For each timer, if the timer wants per-thread events and
 	 * this thread used it, emit it.
 	 */
-	for (tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++)
+	for (enum trace2_timer_id tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++)
 		if (tr2_timer_metadata[tid].want_per_thread_events &&
 		    ctx->timer_block.timer[tid].interval_count)
 			fn_apply(&tr2_timer_metadata[tid],
@@ -167,14 +165,7 @@ void tr2_emit_per_thread_timers(tr2_tgt_evt_timer_t *fn_apply)
 
 void tr2_emit_final_timers(tr2_tgt_evt_timer_t *fn_apply)
 {
-	enum trace2_timer_id tid;
-
-	/*
-	 * Accessing `final_timer_block` requires holding `tr2tls_mutex`.
-	 * We assume that our caller is holding the lock.
-	 */
-
-	for (tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++)
+	for (enum trace2_timer_id tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++)
 		if (final_timer_block.timer[tid].interval_count)
 			fn_apply(&tr2_timer_metadata[tid],
 				 &final_timer_block.timer[tid],
diff --git a/trailer.c b/trailer.c
index 3a0710a458..6eb1134826 100644
--- a/trailer.c
+++ b/trailer.c
@@ -138,8 +138,7 @@ static void free_arg_item(struct arg_item *item)
 
 static char last_non_space_char(const char *s)
 {
-	int i;
-	for (i = strlen(s) - 1; i >= 0; i--)
+	for (int i = strlen(s) - 1; i >= 0; i--)
 		if (!isspace(s[i]))
 			return s[i];
 	return '\0';
@@ -633,8 +632,7 @@ static int token_matches_item(const char *tok, struct arg_item *item, size_t tok
 static ssize_t find_separator(const char *line, const char *separators)
 {
 	int whitespace_found = 0;
-	const char *c;
-	for (c = line; *c; c++) {
+	for (const char *c = line; *c; c++) {
 		if (strchr(separators, *c))
 			return c - line;
 		if (!whitespace_found && (isalnum(*c) || *c == '-'))
@@ -840,7 +838,6 @@ static ssize_t last_line(const char *buf, size_t len)
 static size_t find_end_of_log_message(const char *input, int no_divider)
 {
 	size_t end;
-	const char *s;
 
 	/* Assume the naive end of the input is already what we want. */
 	end = strlen(input);
@@ -849,7 +846,7 @@ static size_t find_end_of_log_message(const char *input, int no_divider)
 		return end;
 
 	/* Optionally skip over any patch part ("---" line and below). */
-	for (s = input; *s; s = next_line(s)) {
+	for (const char *s = input; *s; s = next_line(s)) {
 		const char *v;
 
 		if (skip_prefix(s, "---", &v) && isspace(*v)) {
@@ -869,7 +866,7 @@ static size_t find_end_of_log_message(const char *input, int no_divider)
 static size_t find_trailer_block_start(const char *buf, size_t len)
 {
 	const char *s;
-	ssize_t end_of_title, l;
+	ssize_t end_of_title;
 	int only_spaces = 1;
 	int recognized_prefix = 0, trailer_lines = 0, non_trailer_lines = 0;
 	/*
@@ -896,9 +893,7 @@ static size_t find_trailer_block_start(const char *buf, size_t len)
 	 * trailers, or (ii) contains at least one Git-generated trailer and
 	 * consists of at least 25% trailers.
 	 */
-	for (l = last_line(buf, len);
-	     l >= end_of_title;
-	     l = last_line(buf, l)) {
+	for (ssize_t l = last_line(buf, len); l >= end_of_title; l = last_line(buf, l)) {
 		const char *bol = buf + l;
 		const char **p;
 		ssize_t separator_pos;
@@ -1007,11 +1002,10 @@ static void parse_trailers(struct trailer_info *info,
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
-	size_t i;
 
 	trailer_info_get(info, str, opts);
 
-	for (i = 0; i < info->trailer_nr; i++) {
+	for (size_t i = 0; i < info->trailer_nr; i++) {
 		int separator_pos;
 		char *trailer = info->trailers[i];
 		if (trailer[0] == comment_line_char)
@@ -1130,7 +1124,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts)
 {
 	size_t end_of_log_message = 0, trailer_block_start = 0;
-	struct strbuf **trailer_lines, **ptr;
+	struct strbuf **trailer_lines;
 	char **trailer_strings = NULL;
 	size_t nr = 0, alloc = 0;
 	char **last = NULL;
@@ -1144,7 +1138,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 					 end_of_log_message - trailer_block_start,
 					 '\n',
 					 0);
-	for (ptr = trailer_lines; *ptr; ptr++) {
+	for (struct strbuf **ptr = trailer_lines; *ptr; ptr++) {
 		if (last && isspace((*ptr)->buf[0])) {
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
@@ -1171,8 +1165,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 
 void trailer_info_release(struct trailer_info *info)
 {
-	size_t i;
-	for (i = 0; i < info->trailer_nr; i++)
+	for (size_t i = 0; i < info->trailer_nr; i++)
 		free(info->trailers[i]);
 	free(info->trailers);
 }
@@ -1183,7 +1176,6 @@ static void format_trailer_info(struct strbuf *out,
 				const struct process_trailer_options *opts)
 {
 	size_t origlen = out->len;
-	size_t i;
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
@@ -1194,7 +1186,7 @@ static void format_trailer_info(struct strbuf *out,
 		return;
 	}
 
-	for (i = 0; i < info->trailer_nr; i++) {
+	for (size_t i = 0; i < info->trailer_nr; i++) {
 		char *trailer = info->trailers[i];
 		ssize_t separator_pos = find_separator(trailer, separators);
 
diff --git a/transport-helper.c b/transport-helper.c
index dd6002b393..2e68c0369b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -299,9 +299,9 @@ static int string_list_set_helper_option(struct helper_data *data,
 					 struct string_list *list)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < list->nr; i++) {
+	for (int i = 0; i < list->nr; i++) {
 		strbuf_addf(&buf, "option %s ", name);
 		quote_c_style(list->items[i].string, &buf, NULL, 0);
 		strbuf_addch(&buf, '\n');
@@ -394,10 +394,9 @@ static int fetch_with_fetch(struct transport *transport,
 			    int nr_heads, struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
-	int i;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (i = 0; i < nr_heads; i++) {
+	for (int i = 0; i < nr_heads; i++) {
 		const struct ref *posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
 			continue;
@@ -465,7 +464,6 @@ static int get_exporter(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 	struct child_process *helper = get_helper(transport);
-	int i;
 
 	child_process_init(fastexport);
 
@@ -481,7 +479,7 @@ static int get_exporter(struct transport *transport,
 	if (data->import_marks)
 		strvec_pushf(&fastexport->args, "--import-marks=%s", data->import_marks);
 
-	for (i = 0; i < revlist_args->nr; i++)
+	for (int i = 0; i < revlist_args->nr; i++)
 		strvec_push(&fastexport->args, revlist_args->items[i].string);
 
 	fastexport->git_cmd = 1;
@@ -686,7 +684,7 @@ static int fetch_refs(struct transport *transport,
 		      int nr_heads, struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
-	int i, count;
+	int count;
 
 	get_helper(transport);
 
@@ -707,7 +705,7 @@ static int fetch_refs(struct transport *transport,
 		get_refs_list_using_list(transport, 0);
 
 	count = 0;
-	for (i = 0; i < nr_heads; i++)
+	for (int i = 0; i < nr_heads; i++)
 		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
 			count++;
 
@@ -893,7 +891,6 @@ static int push_update_refs_status(struct helper_data *data,
 				    struct ref *remote_refs,
 				    int flags)
 {
-	struct ref *ref;
 	struct ref_push_report *report;
 	struct strbuf buf = STRBUF_INIT;
 	struct push_update_ref_state state = { remote_refs, NULL, 0 };
@@ -913,7 +910,7 @@ static int push_update_refs_status(struct helper_data *data,
 		return 0;
 
 	/* propagate back the update to the remote namespace */
-	for (ref = remote_refs; ref; ref = ref->next) {
+	for (struct ref *ref = remote_refs; ref; ref = ref->next) {
 		char *private;
 
 		if (ref->status != REF_STATUS_OK)
@@ -985,7 +982,6 @@ static int push_refs_with_push(struct transport *transport,
 	int atomic = flags & TRANSPORT_PUSH_ATOMIC;
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
-	struct ref *ref;
 	struct string_list cas_options = STRING_LIST_INIT_DUP;
 	struct string_list_item *cas_option;
 
@@ -993,7 +989,7 @@ static int push_refs_with_push(struct transport *transport,
 	if (!data->push)
 		return 1;
 
-	for (ref = remote_refs; ref; ref = ref->next) {
+	for (struct ref *ref = remote_refs; ref; ref = ref->next) {
 		if (!ref->peer_ref && !mirror)
 			continue;
 
@@ -1066,7 +1062,6 @@ static int push_refs_with_push(struct transport *transport,
 static int push_refs_with_export(struct transport *transport,
 		struct ref *remote_refs, int flags)
 {
-	struct ref *ref;
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
 	struct string_list revlist_args = STRING_LIST_INIT_DUP;
@@ -1085,7 +1080,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	write_constant(helper->in, "export\n");
 
-	for (ref = remote_refs; ref; ref = ref->next) {
+	for (struct ref *ref = remote_refs; ref; ref = ref->next) {
 		char *private;
 		struct object_id oid;
 
@@ -1204,7 +1199,6 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 	struct child_process *helper;
 	struct ref *ret = NULL;
 	struct ref **tail = &ret;
-	struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
 
 	data->get_refs_list_called = 1;
@@ -1266,7 +1260,7 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 		fprintf(stderr, "Debug: Read ref listing.\n");
 	strbuf_release(&buf);
 
-	for (posn = ret; posn; posn = posn->next)
+	for (struct ref *posn = ret; posn; posn = posn->next)
 		resolve_remote_symref(posn, ret);
 
 	return ret;
@@ -1629,10 +1623,7 @@ int bidirectional_transfer_loop(int input, int output)
 
 void reject_atomic_push(struct ref *remote_refs, int mirror_mode)
 {
-	struct ref *ref;
-
-	/* Mark other refs as failed */
-	for (ref = remote_refs; ref; ref = ref->next) {
+	for (struct ref *ref = remote_refs; ref; ref = ref->next) {
 		if (!ref->peer_ref && !mirror_mode)
 			continue;
 
diff --git a/transport.c b/transport.c
index df518ead70..878917ae63 100644
--- a/transport.c
+++ b/transport.c
@@ -45,7 +45,6 @@ static int transport_color_config(void)
 		"color.transport.rejected"
 	}, *key = "color.transport";
 	char *value;
-	int i;
 	static int initialized;
 
 	if (initialized)
@@ -58,7 +57,7 @@ static int transport_color_config(void)
 	if (!want_color_stderr(transport_use_color))
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(keys); i++)
+	for (int i = 0; i < ARRAY_SIZE(keys); i++)
 		if (!git_config_get_string(keys[i], &value)) {
 			if (!value)
 				return config_error_nonbool(keys[i]);
@@ -79,8 +78,7 @@ static const char *transport_get_color(enum color_transport ix)
 static void set_upstreams(struct transport *transport, struct ref *refs,
 	int pretend)
 {
-	struct ref *ref;
-	for (ref = refs; ref; ref = ref->next) {
+	for (struct ref *ref = refs; ref; ref = ref->next) {
 		const char *localname;
 		const char *tmp;
 		const char *remotename;
@@ -150,14 +148,13 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
-	int i;
 
 	if (for_push)
 		return NULL;
 
 	get_refs_from_bundle_inner(transport);
 
-	for (i = 0; i < data->header.references.nr; i++) {
+	for (int i = 0; i < data->header.references.nr; i++) {
 		struct string_list_item *e = data->header.references.items + i;
 		const char *name = e->string;
 		struct ref *ref = alloc_ref(name);
@@ -437,9 +434,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
 
 	if (!data->finished_handshake) {
-		int i;
 		int must_list_refs = 0;
-		for (i = 0; i < nr_heads; i++) {
+		for (int i = 0; i < nr_heads; i++) {
 			if (!to_fetch[i]->exact_oid) {
 				must_list_refs = 1;
 				break;
@@ -768,14 +764,13 @@ static int print_one_push_report(struct ref *ref, const char *dest, int count,
 static int print_one_push_status(struct ref *ref, const char *dest, int count,
 				 int porcelain, int summary_width)
 {
-	struct ref_push_report *report;
 	int n = 0;
 
 	if (!ref->report)
 		return print_one_push_report(ref, dest, count,
 					     NULL, porcelain, summary_width);
 
-	for (report = ref->report; report; report = report->next)
+	for (struct ref_push_report *report = ref->report; report; report = report->next)
 		print_one_push_report(ref, dest, count + n++,
 				      report, porcelain, summary_width);
 	return n;
@@ -1242,11 +1237,9 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 
 static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 {
-	int i;
-
 	fprintf(stderr, _("The following submodule paths contain changes that can\n"
 			"not be found on any remote:\n"));
-	for (i = 0; i < needs_pushing->nr; i++)
+	for (int i = 0; i < needs_pushing->nr; i++)
 		fprintf(stderr, "  %s\n", needs_pushing->items[i].string);
 	fprintf(stderr, _("\nPlease try\n\n"
 			  "	git push --recurse-submodules=on-demand\n\n"
@@ -1263,7 +1256,6 @@ static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
 	int ret = 0, x;
-	struct ref *r;
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf;
 	const char *hook_path = find_hook("pre-push");
@@ -1287,7 +1279,7 @@ static int run_pre_push_hook(struct transport *transport,
 
 	strbuf_init(&buf, 256);
 
-	for (r = remote_refs; r; r = r->next) {
+	for (struct ref *r = remote_refs; r; r = r->next) {
 		if (!r->peer_ref) continue;
 		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
 		if (r->status == REF_STATUS_REJECT_STALE) continue;
@@ -1459,8 +1451,7 @@ int transport_push(struct repository *r,
 
 	if (!(flags & (TRANSPORT_PUSH_DRY_RUN |
 		       TRANSPORT_RECURSE_SUBMODULES_ONLY))) {
-		struct ref *ref;
-		for (ref = remote_refs; ref; ref = ref->next)
+		for (struct ref *ref = remote_refs; ref; ref = ref->next)
 			transport_update_tracking_ref(transport->remote, ref, verbose);
 	}
 
@@ -1562,9 +1553,7 @@ int transport_get_remote_bundle_uri(struct transport *transport)
 void transport_unlock_pack(struct transport *transport, unsigned int flags)
 {
 	int in_signal_handler = !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER);
-	int i;
-
-	for (i = 0; i < transport->pack_lockfiles.nr; i++)
+	for (int i = 0; i < transport->pack_lockfiles.nr; i++)
 		if (in_signal_handler)
 			unlink(transport->pack_lockfiles.items[i].string);
 		else
diff --git a/tree-diff.c b/tree-diff.c
index 46107772d1..2d73c5383f 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -417,8 +417,7 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
 /* ∀ pi=p[imin]  pi↓ */
 static inline void update_tp_entries(struct tree_desc *tp, int nparent)
 {
-	int i;
-	for (i = 0; i < nparent; ++i)
+	for (int i = 0; i < nparent; ++i)
 		if (!(tp[i].entry.mode & S_IFXMIN_NEQ))
 			update_tree_entry(&tp[i]);
 }
diff --git a/tree-walk.c b/tree-walk.c
index b517792ba2..0909a95bce 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -416,9 +416,9 @@ static void update_extended_entry(struct tree_desc_x *t, struct name_entry *a)
 
 static void free_extended_entry(struct tree_desc_x *t)
 {
-	struct tree_desc_skip *p, *s;
+	struct tree_desc_skip *p;
 
-	for (s = t->skip; s; s = p) {
+	for (struct tree_desc_skip *s = t->skip; s; s = p) {
 		p = s->prev;
 		free(s);
 	}
@@ -670,7 +670,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 	int retval = MISSING_OBJECT;
 	struct dir_state *parents = NULL;
 	size_t parents_alloc = 0;
-	size_t i, parents_nr = 0;
+	size_t parents_nr = 0;
 	struct object_id current_tree_oid;
 	struct strbuf namebuf = STRBUF_INIT;
 	struct tree_desc t;
@@ -835,7 +835,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 		}
 	}
 done:
-	for (i = 0; i < parents_nr; i++)
+	for (size_t i = 0; i < parents_nr; i++)
 		free(parents[i].tree);
 	free(parents);
 
@@ -1030,7 +1030,6 @@ static enum interesting do_match(struct index_state *istate,
 				 const struct pathspec *ps,
 				 int exclude)
 {
-	int i;
 	int pathlen, baselen = base->len;
 	enum interesting never_interesting = ps->has_wildcard ?
 		entry_not_interesting : all_entries_not_interesting;
@@ -1057,7 +1056,7 @@ static enum interesting do_match(struct index_state *istate,
 
 	pathlen = tree_entry_len(entry);
 
-	for (i = ps->nr - 1; i >= 0; i--) {
+	for (int i = ps->nr - 1; i >= 0; i--) {
 		const struct pathspec_item *item = ps->items+i;
 		const char *match = item->match;
 		const char *base_str = base->buf;
diff --git a/unpack-trees.c b/unpack-trees.c
index c2b20b80d5..dc9fab595a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -94,8 +94,7 @@ static const char *super_prefixed(const char *path, const char *super_prefix)
 		if (!super_prefix) {
 			super_prefix_len = 0;
 		} else {
-			int i;
-			for (i = 0; i < ARRAY_SIZE(buf); i++)
+			for (int i = 0; i < ARRAY_SIZE(buf); i++)
 				strbuf_addstr(&buf[i], super_prefix);
 			super_prefix_len = buf[0].len;
 		}
@@ -116,7 +115,6 @@ static const char *super_prefixed(const char *path, const char *super_prefix)
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd)
 {
-	int i;
 	const char **msgs = opts->internal.msgs;
 	const char *msg;
 
@@ -200,7 +198,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 
 	opts->internal.show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
-	for (i = 0; i < ARRAY_SIZE(opts->internal.unpack_rejects); i++)
+	for (int i = 0; i < ARRAY_SIZE(opts->internal.unpack_rejects); i++)
 		opts->internal.unpack_rejects[i].strdup_strings = 1;
 }
 
@@ -259,9 +257,8 @@ static int add_rejected_path(struct unpack_trees_options *o,
  */
 static void display_error_msgs(struct unpack_trees_options *o)
 {
-	int e;
 	unsigned error_displayed = 0;
-	for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
+	for (int e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
 		struct string_list *rejects = &o->internal.unpack_rejects[e];
 
 		if (rejects->nr > 0) {
@@ -286,10 +283,8 @@ static void display_error_msgs(struct unpack_trees_options *o)
  */
 static void display_warning_msgs(struct unpack_trees_options *o)
 {
-	int e;
 	unsigned warning_displayed = 0;
-	for (e = NB_UNPACK_TREES_ERROR_TYPES + 1;
-	     e < NB_UNPACK_TREES_WARNING_TYPES; e++) {
+	for (int e = NB_UNPACK_TREES_ERROR_TYPES + 1; e < NB_UNPACK_TREES_WARNING_TYPES; e++) {
 		struct string_list *rejects = &o->internal.unpack_rejects[e];
 
 		if (rejects->nr > 0) {
@@ -374,10 +369,8 @@ static struct progress *get_progress(struct unpack_trees_options *o,
 static void setup_collided_checkout_detection(struct checkout *state,
 					      struct index_state *index)
 {
-	int i;
-
 	state->clone = 1;
-	for (i = 0; i < index->cache_nr; i++)
+	for (int i = 0; i < index->cache_nr; i++)
 		index->cache[i]->ce_flags &= ~CE_MATCHED;
 }
 
@@ -622,8 +615,7 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
 
 static void mark_all_ce_unused(struct index_state *index)
 {
-	int i;
-	for (i = 0; i < index->cache_nr; i++)
+	for (int i = 0; i < index->cache_nr; i++)
 		index->cache[i]->ce_flags &= ~(CE_UNPACKED | CE_ADDED | CE_NEW_SKIP_WORKTREE);
 }
 
@@ -648,9 +640,7 @@ static void mark_ce_used_same_name(struct cache_entry *ce,
 {
 	struct index_state *index = o->src_index;
 	int len = ce_namelen(ce);
-	int pos;
-
-	for (pos = locate_in_src_index(ce, o); pos < index->cache_nr; pos++) {
+	for (int pos = locate_in_src_index(ce, o); pos < index->cache_nr; pos++) {
 		struct cache_entry *next = index->cache[pos];
 		if (len != ce_namelen(next) ||
 		    memcmp(ce->name, next->name, len))
@@ -751,12 +741,11 @@ static int all_trees_same_as_cache_tree(int n, unsigned long dirmask,
 					struct traverse_info *info)
 {
 	struct unpack_trees_options *o = info->data;
-	int i;
 
 	if (!o->merge || dirmask != ((1 << n) - 1))
 		return 0;
 
-	for (i = 1; i < n; i++)
+	for (int i = 1; i < n; i++)
 		if (!are_same_oid(names, names + i))
 			return 0;
 
@@ -801,7 +790,7 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 	struct unpack_trees_options *o = info->data;
 	struct cache_entry *tree_ce = NULL;
 	int ce_len = 0;
-	int i, d;
+	int d;
 
 	if (!o->merge)
 		BUG("We need cache-tree to do this optimization");
@@ -814,7 +803,7 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 	 * because cache-tree would be invalidated and we would never
 	 * get here in the first place.
 	 */
-	for (i = 0; i < nr_entries; i++) {
+	for (int i = 0; i < nr_entries; i++) {
 		int new_ce_len, len, rc;
 
 		src[0] = o->src_index->cache[pos + i];
@@ -1270,12 +1259,11 @@ static int unpack_failed(struct unpack_trees_options *o, const char *message)
 static int find_cache_pos(struct traverse_info *info,
 			  const char *p, size_t p_len)
 {
-	int pos;
 	struct unpack_trees_options *o = info->data;
 	struct index_state *index = o->src_index;
 	int pfxlen = info->pathlen;
 
-	for (pos = o->internal.cache_bottom; pos < index->cache_nr; pos++) {
+	for (int pos = o->internal.cache_bottom; pos < index->cache_nr; pos++) {
 		const struct cache_entry *ce = index->cache[pos];
 		const char *ce_name, *ce_slash;
 		int cmp, ce_len;
@@ -1426,12 +1414,11 @@ static void debug_unpack_callback(int n,
 				  struct name_entry *names,
 				  struct traverse_info *info)
 {
-	int i;
 	printf("* unpack mask %lu, dirmask %lu, cnt %d ",
 	       mask, dirmask, n);
 	debug_path(info);
 	putchar('\n');
-	for (i = 0; i < n; i++)
+	for (int i = 0; i < n; i++)
 		debug_name_entry(i, names + i);
 }
 
@@ -1793,13 +1780,7 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
 				   int select_flag, int skip_wt_flag,
 				   int show_progress)
 {
-	int i;
-
-	/*
-	 * 1. Pretend the narrowest worktree: only unmerged entries
-	 * are checked out
-	 */
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 
 		if (select_flag && !(ce->ce_flags & select_flag))
@@ -2116,7 +2097,6 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
 					    struct pattern_list *pl)
 {
 	enum update_sparsity_result ret = UPDATE_SPARSITY_SUCCESS;
-	int i;
 	unsigned old_show_all_errors;
 	int free_pattern_list = 0;
 
@@ -2150,7 +2130,7 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
 
 	/* Then loop over entries and update/remove as needed */
 	ret = UPDATE_SPARSITY_SUCCESS;
-	for (i = 0; i < o->src_index->cache_nr; i++) {
+	for (int i = 0; i < o->src_index->cache_nr; i++) {
 		struct cache_entry *ce = o->src_index->cache[i];
 
 
diff --git a/upload-pack.c b/upload-pack.c
index 2537affa90..74f9005a4a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -476,7 +476,6 @@ static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid
 	if (!o)
 		die("oops (%s)", oid_to_hex(oid));
 	if (o->type == OBJ_COMMIT) {
-		struct commit_list *parents;
 		struct commit *commit = (struct commit *)o;
 		if (o->flags & THEY_HAVE)
 			we_knew_they_have = 1;
@@ -484,9 +483,7 @@ static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid
 			o->flags |= THEY_HAVE;
 		if (!data->oldest_have || (commit->date < data->oldest_have))
 			data->oldest_have = commit->date;
-		for (parents = commit->parents;
-		     parents;
-		     parents = parents->next)
+		for (struct commit_list *parents = commit->parents; parents; parents = parents->next)
 			parents->item->object.flags |= THEY_HAVE;
 	}
 	if (!we_knew_they_have) {
@@ -778,8 +775,6 @@ static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
 
 static void check_non_tip(struct upload_pack_data *data)
 {
-	int i;
-
 	/*
 	 * In the normal in-process case without
 	 * uploadpack.allowReachableSHA1InWant,
@@ -793,7 +788,7 @@ static void check_non_tip(struct upload_pack_data *data)
 
 error:
 	/* Pick one of them (we know there at least is one) */
-	for (i = 0; i < data->want_obj.nr; i++) {
+	for (int i = 0; i < data->want_obj.nr; i++) {
 		struct object *o = data->want_obj.objects[i].item;
 		if (!is_our_ref(o, data->allow_uor)) {
 			error("git upload-pack: not our ref %s",
@@ -823,9 +818,7 @@ static void send_shallow(struct upload_pack_data *data,
 
 static void send_unshallow(struct upload_pack_data *data)
 {
-	int i;
-
-	for (i = 0; i < data->shallows.nr; i++) {
+	for (int i = 0; i < data->shallows.nr; i++) {
 		struct object *object = data->shallows.objects[i].item;
 		if (object->flags & NOT_SHALLOW) {
 			struct commit_list *parents;
@@ -860,9 +853,7 @@ static int check_ref(const char *refname_full, const struct object_id *oid,
 static void deepen(struct upload_pack_data *data, int depth)
 {
 	if (depth == INFINITE_DEPTH && !is_repository_shallow(the_repository)) {
-		int i;
-
-		for (i = 0; i < data->shallows.nr; i++) {
+		for (int i = 0; i < data->shallows.nr; i++) {
 			struct object *object = data->shallows.objects[i].item;
 			object->flags |= NOT_SHALLOW;
 		}
@@ -943,8 +934,7 @@ static int send_shallow_list(struct upload_pack_data *data)
 		ret = 1;
 	} else {
 		if (data->shallows.nr > 0) {
-			int i;
-			for (i = 0; i < data->shallows.nr; i++)
+			for (int i = 0; i < data->shallows.nr; i++)
 				register_shallow(the_repository,
 						 &data->shallows.objects[i].item->oid);
 		}
@@ -1065,13 +1055,11 @@ static void check_one_filter(struct upload_pack_data *data,
 static void check_filter_recurse(struct upload_pack_data *data,
 				 struct list_objects_filter_options *opts)
 {
-	size_t i;
-
 	check_one_filter(data, opts);
 	if (opts->choice != LOFC_COMBINE)
 		return;
 
-	for (i = 0; i < opts->sub_nr; i++)
+	for (size_t i = 0; i < opts->sub_nr; i++)
 		check_filter_recurse(data, &opts->sub[i]);
 }
 
@@ -1666,10 +1654,7 @@ static void process_args(struct packet_reader *request,
 
 static int process_haves(struct upload_pack_data *data, struct oid_array *common)
 {
-	int i;
-
-	/* Process haves */
-	for (i = 0; i < data->haves.nr; i++) {
+	for (int i = 0; i < data->haves.nr; i++) {
 		const struct object_id *oid = &data->haves.oid[i];
 
 		if (!repo_has_object_file_with_flags(the_repository, oid,
@@ -1686,15 +1671,13 @@ static int process_haves(struct upload_pack_data *data, struct oid_array *common
 
 static int send_acks(struct upload_pack_data *data, struct oid_array *acks)
 {
-	int i;
-
 	packet_writer_write(&data->writer, "acknowledgments\n");
 
 	/* Send Acks */
 	if (!acks->nr)
 		packet_writer_write(&data->writer, "NAK\n");
 
-	for (i = 0; i < acks->nr; i++) {
+	for (int i = 0; i < acks->nr; i++) {
 		packet_writer_write(&data->writer, "ACK %s\n",
 				    oid_to_hex(&acks->oid[i]));
 	}
diff --git a/userdiff.c b/userdiff.c
index 2b1dab2649..c4d4dee259 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -477,9 +477,8 @@ static int for_each_userdiff_driver_list(each_userdiff_driver_fn fn,
 					 struct userdiff_driver *drv,
 					 int drv_size)
 {
-	int i;
 	int ret;
-	for (i = 0; i < drv_size; i++) {
+	for (int i = 0; i < drv_size; i++) {
 		struct userdiff_driver *item = drv + i;
 		if ((ret = fn(item, type, cb_data)))
 			return ret;
diff --git a/version.c b/version.c
index 41b718c29e..985c825e5d 100644
--- a/version.c
+++ b/version.c
@@ -24,11 +24,10 @@ const char *git_user_agent_sanitized(void)
 
 	if (!agent) {
 		struct strbuf buf = STRBUF_INIT;
-		int i;
 
 		strbuf_addstr(&buf, git_user_agent());
 		strbuf_trim(&buf);
-		for (i = 0; i < buf.len; i++) {
+		for (int i = 0; i < buf.len; i++) {
 			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
 				buf.buf[i] = '.';
 		}
diff --git a/versioncmp.c b/versioncmp.c
index 45e676cbca..fa93d8577e 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -42,8 +42,7 @@ static void find_better_matching_suffix(const char *tagname, const char *suffix,
 	 * but is longer.
 	 */
 	int end = match->len < suffix_len ? match->start : match->start-1;
-	int i;
-	for (i = start; i <= end; i++)
+	for (int i = start; i <= end; i++)
 		if (starts_with(tagname + i, suffix)) {
 			match->conf_pos = conf_pos;
 			match->start = i;
@@ -75,11 +74,10 @@ static int swap_prereleases(const char *s1,
 			    int off,
 			    int *diff)
 {
-	int i;
 	struct suffix_match match1 = { -1, off, -1 };
 	struct suffix_match match2 = { -1, off, -1 };
 
-	for (i = 0; i < prereleases->nr; i++) {
+	for (int i = 0; i < prereleases->nr; i++) {
 		const char *suffix = prereleases->items[i].string;
 		int start, suffix_len = strlen(suffix);
 		if (suffix_len < off)
diff --git a/walker.c b/walker.c
index 65002a7220..de966a49d5 100644
--- a/walker.c
+++ b/walker.c
@@ -80,8 +80,6 @@ static struct commit_list *complete = NULL;
 
 static int process_commit(struct walker *walker, struct commit *commit)
 {
-	struct commit_list *parents;
-
 	if (repo_parse_commit(the_repository, commit))
 		return -1;
 
@@ -99,7 +97,7 @@ static int process_commit(struct walker *walker, struct commit *commit)
 	if (process(walker, &repo_get_commit_tree(the_repository, commit)->object))
 		return -1;
 
-	for (parents = commit->parents; parents; parents = parents->next) {
+	for (struct commit_list *parents = commit->parents; parents; parents = parents->next) {
 		if (process(walker, &parents->item->object))
 			return -1;
 	}
diff --git a/worktree.c b/worktree.c
index b02a05a74a..fca5b3efd7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -112,9 +112,7 @@ struct worktree *get_linked_worktree(const char *id,
 static void mark_current_worktree(struct worktree **worktrees)
 {
 	char *git_dir = absolute_pathdup(get_git_dir());
-	int i;
-
-	for (i = 0; worktrees[i]; i++) {
+	for (int i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
 		const char *wt_git_dir = get_worktree_git_dir(wt);
 
@@ -530,12 +528,12 @@ void strbuf_worktree_ref(const struct worktree *wt,
 
 int other_head_refs(each_ref_fn fn, void *cb_data)
 {
-	struct worktree **worktrees, **p;
+	struct worktree **worktrees;
 	struct strbuf refname = STRBUF_INIT;
 	int ret = 0;
 
 	worktrees = get_worktrees();
-	for (p = worktrees; *p; p++) {
+	for (struct worktree **p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 		struct object_id oid;
 		int flag;
diff --git a/wrapper.c b/wrapper.c
index eeac3741cf..e940a6a132 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -454,7 +454,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	static const int num_x = ARRAY_SIZE(x_pattern) - 1;
 	char *filename_template;
 	size_t len;
-	int fd, count;
+	int fd;
 
 	len = strlen(pattern);
 
@@ -473,7 +473,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	 * Try TMP_MAX different filenames.
 	 */
 	filename_template = &pattern[len - num_x - suffix_len];
-	for (count = 0; count < TMP_MAX; ++count) {
+	for (int count = 0; count < TMP_MAX; ++count) {
 		int i;
 		uint64_t v;
 		if (csprng_bytes(&v, sizeof(v)) < 0)
diff --git a/ws.c b/ws.c
index 9456e2fdbe..f1efe3c9d5 100644
--- a/ws.c
+++ b/ws.c
@@ -88,8 +88,7 @@ unsigned whitespace_rule(struct index_state *istate, const char *pathname)
 	if (ATTR_TRUE(value)) {
 		/* true (whitespace) */
 		unsigned all_rule = ws_tab_width(whitespace_rule_cfg);
-		int i;
-		for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++)
+		for (int i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++)
 			if (!whitespace_rule_names[i].loosens_error &&
 			    !whitespace_rule_names[i].exclude_default)
 				all_rule |= whitespace_rule_names[i].rule_bits;
diff --git a/wt-status.c b/wt-status.c
index b5a29083df..e308a3e06e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -65,7 +65,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf linebuf = STRBUF_INIT;
-	const char *line, *eol;
+	const char *eol;
 
 	strbuf_vaddf(&sb, fmt, ap);
 	if (!sb.len) {
@@ -80,7 +80,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 		strbuf_release(&sb);
 		return;
 	}
-	for (line = sb.buf; *line; line = eol + 1) {
+	for (const char *line = sb.buf; *line; line = eol + 1) {
 		eol = strchr(line, '\n');
 
 		strbuf_reset(&linebuf);
@@ -163,7 +163,6 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
 
 static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 {
-	int i;
 	int del_mod_conflict = 0;
 	int both_deleted = 0;
 	int not_deleted = 0;
@@ -171,7 +170,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 
 	status_printf_ln(s, c, _("Unmerged paths:"));
 
-	for (i = 0; i < s->change.nr; i++) {
+	for (int i = 0; i < s->change.nr; i++) {
 		struct string_list_item *it = &(s->change.items[i]);
 		struct wt_status_change_data *d = it->util;
 
@@ -321,9 +320,9 @@ static const char *wt_status_diff_status_string(int status)
 
 static int maxwidth(const char *(*label)(int), int minval, int maxval)
 {
-	int result = 0, i;
+	int result = 0;
 
-	for (i = minval; i <= maxval; i++) {
+	for (int i = minval; i <= maxval; i++) {
 		const char *s = label(i);
 		int len = s ? utf8_strwidth(s) : 0;
 		if (len > result)
@@ -456,12 +455,11 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 					 void *data)
 {
 	struct wt_status *s = data;
-	int i;
 
 	if (!q->nr)
 		return;
 	s->workdir_dirty = 1;
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p;
 		struct string_list_item *it;
 		struct wt_status_change_data *d;
@@ -543,9 +541,7 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 					 void *data)
 {
 	struct wt_status *s = data;
-	int i;
-
-	for (i = 0; i < q->nr; i++) {
+	for (int i = 0; i < q->nr; i++) {
 		struct diff_filepair *p;
 		struct string_list_item *it;
 		struct wt_status_change_data *d;
@@ -712,9 +708,7 @@ static int add_file_to_list(const struct object_id *oid,
 static void wt_status_collect_changes_initial(struct wt_status *s)
 {
 	struct index_state *istate = s->repo->index;
-	int i;
-
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct string_list_item *it;
 		struct wt_status_change_data *d;
 		const struct cache_entry *ce = istate->cache[i];
@@ -815,9 +809,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 static int has_unmerged(struct wt_status *s)
 {
-	int i;
-
-	for (i = 0; i < s->change.nr; i++) {
+	for (int i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		d = s->change.items[i].util;
 		if (d->stagemask)
@@ -867,9 +859,7 @@ void wt_status_state_free_buffers(struct wt_status_state *state)
 static void wt_longstatus_print_unmerged(struct wt_status *s)
 {
 	int shown_header = 0;
-	int i;
-
-	for (i = 0; i < s->change.nr; i++) {
+	for (int i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		struct string_list_item *it;
 		it = &(s->change.items[i]);
@@ -890,9 +880,7 @@ static void wt_longstatus_print_unmerged(struct wt_status *s)
 static void wt_longstatus_print_updated(struct wt_status *s)
 {
 	int shown_header = 0;
-	int i;
-
-	for (i = 0; i < s->change.nr; i++) {
+	for (int i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		struct string_list_item *it;
 		it = &(s->change.items[i]);
@@ -918,12 +906,11 @@ static void wt_longstatus_print_updated(struct wt_status *s)
 static int wt_status_check_worktree_changes(struct wt_status *s,
 					     int *dirty_submodules)
 {
-	int i;
 	int changes = 0;
 
 	*dirty_submodules = 0;
 
-	for (i = 0; i < s->change.nr; i++) {
+	for (int i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		d = s->change.items[i].util;
 		if (!d->worktree_status ||
@@ -941,7 +928,7 @@ static int wt_status_check_worktree_changes(struct wt_status *s,
 
 static void wt_longstatus_print_changed(struct wt_status *s)
 {
-	int i, dirty_submodules;
+	int dirty_submodules;
 	int worktree_changes = wt_status_check_worktree_changes(s, &dirty_submodules);
 
 	if (!worktree_changes)
@@ -949,7 +936,7 @@ static void wt_longstatus_print_changed(struct wt_status *s)
 
 	wt_longstatus_print_dirty_header(s, worktree_changes < 0, dirty_submodules);
 
-	for (i = 0; i < s->change.nr; i++) {
+	for (int i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		struct string_list_item *it;
 		it = &(s->change.items[i]);
@@ -1041,7 +1028,6 @@ static void wt_longstatus_print_other(struct wt_status *s,
 				      const char *what,
 				      const char *how)
 {
-	int i;
 	struct strbuf buf = STRBUF_INIT;
 	static struct string_list output = STRING_LIST_INIT_DUP;
 	struct column_options copts;
@@ -1051,7 +1037,7 @@ static void wt_longstatus_print_other(struct wt_status *s,
 
 	wt_longstatus_print_other_header(s, what, how);
 
-	for (i = 0; i < l->nr; i++) {
+	for (int i = 0; i < l->nr; i++) {
 		struct string_list_item *it;
 		const char *path;
 		it = &(l->items[i]);
@@ -1174,7 +1160,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 static void wt_longstatus_print_tracking(struct wt_status *s)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char *cp, *ep, *branch_name;
+	const char *ep, *branch_name;
 	struct branch *branch;
 	char comment_line_string[3];
 	int i;
@@ -1209,7 +1195,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	}
 	comment_line_string[i] = '\0';
 
-	for (cp = sb.buf; (ep = strchr(cp, '\n')) != NULL; cp = ep + 1)
+	for (const char *cp = sb.buf; (ep = strchr(cp, '\n')) != NULL; cp = ep + 1)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s),
 				 "%s%.*s", comment_line_string,
 				 (int)(ep - cp), cp);
@@ -1750,7 +1736,6 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 					    struct wt_status_state *state)
 {
 	int skip_worktree = 0;
-	int i;
 
 	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
 		/*
@@ -1766,7 +1751,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 		return;
 	}
 
-	for (i = 0; i < r->index->cache_nr; i++) {
+	for (int i = 0; i < r->index->cache_nr; i++) {
 		struct cache_entry *ce = r->index->cache[i];
 		if (ce_skip_worktree(ce))
 			skip_worktree++;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 3162f51743..9a81750817 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -53,13 +53,12 @@ static int consume_one(void *priv_, char *s, unsigned long size)
 static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 {
 	struct xdiff_emit_state *priv = priv_;
-	int i;
 	int stop = 0;
 
 	if (!priv->line_fn)
 		return 0;
 
-	for (i = 0; i < nbuf; i++) {
+	for (int i = 0; i < nbuf; i++) {
 		if (stop)
 			return 1;
 		if (mb[i].ptr[mb[i].size-1] != '\n') {
@@ -282,10 +281,9 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value, int cflags)
 void xdiff_clear_find_func(xdemitconf_t *xecfg)
 {
 	if (xecfg->find_func) {
-		int i;
 		struct ff_regs *regs = xecfg->find_func_priv;
 
-		for (i = 0; i < regs->nr; i++)
+		for (int i = 0; i < regs->nr; i++)
 			regfree(&regs->array[i].re);
 		free(regs->array);
 		free(regs);
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 344c2dfc3e..4e554f62ce 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -411,10 +411,9 @@ static int recs_match(xrecord_t *rec1, xrecord_t *rec2)
  */
 static int get_indent(xrecord_t *rec)
 {
-	long i;
 	int ret = 0;
 
-	for (i = 0; i < rec->size; i++) {
+	for (long i = 0; i < rec->size; i++) {
 		char c = rec->ptr[i];
 
 		if (!XDL_ISSPACE(c))
@@ -976,9 +975,9 @@ void xdl_free_script(xdchange_t *xscr) {
 static int xdl_call_hunk_func(xdfenv_t *xe UNUSED, xdchange_t *xscr, xdemitcb_t *ecb,
 			      xdemitconf_t const *xecfg)
 {
-	xdchange_t *xch, *xche;
+	xdchange_t *xche;
 
-	for (xch = xscr; xch; xch = xche->next) {
+	for (xdchange_t *xch = xscr; xch; xch = xche->next) {
 		xche = xdl_get_hunk(&xch, xecfg);
 		if (!xch)
 			break;
@@ -992,9 +991,7 @@ static int xdl_call_hunk_func(xdfenv_t *xe UNUSED, xdchange_t *xscr, xdemitcb_t
 
 static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 {
-	xdchange_t *xch;
-
-	for (xch = xscr; xch; xch = xch->next) {
+	for (xdchange_t *xch = xscr; xch; xch = xch->next) {
 		int ignore = 1;
 		xrecord_t **rec;
 		long i;
@@ -1013,9 +1010,7 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 
 static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
 	regmatch_t regmatch;
-	int i;
-
-	for (i = 0; i < xpp->ignore_regex_nr; i++)
+	for (int i = 0; i < xpp->ignore_regex_nr; i++)
 		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
 				 &regmatch, 0))
 			return 1;
@@ -1026,9 +1021,7 @@ static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
 static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
 				     xpparam_t const *xpp)
 {
-	xdchange_t *xch;
-
-	for (xch = xscr; xch; xch = xch->next) {
+	for (xdchange_t *xch = xscr; xch; xch = xch->next) {
 		xrecord_t **rec;
 		int ignore = 1;
 		long i;
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 75f0fe4986..5611b1b85a 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -135,13 +135,13 @@ struct func_line {
 static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 			  struct func_line *func_line, long start, long limit)
 {
-	long l, size, step = (start > limit) ? -1 : 1;
+	long size, step = (start > limit) ? -1 : 1;
 	char *buf, dummy[1];
 
 	buf = func_line ? func_line->buf : dummy;
 	size = func_line ? sizeof(func_line->buf) : sizeof(dummy);
 
-	for (l = start; l != limit && 0 <= l && l < xe->xdf1.nrec; l += step) {
+	for (long l = start; l != limit && 0 <= l && l < xe->xdf1.nrec; l += step) {
 		long len = match_func_rec(&xe->xdf1, xecfg, l, buf, size);
 		if (len >= 0) {
 			if (func_line)
@@ -167,11 +167,11 @@ static int is_empty_rec(xdfile_t *xdf, long ri)
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg) {
 	long s1, s2, e1, e2, lctx;
-	xdchange_t *xch, *xche;
+	xdchange_t *xche;
 	long funclineprev = -1;
 	struct func_line func_line = { 0 };
 
-	for (xch = xscr; xch; xch = xche->next) {
+	for (xdchange_t *xch = xscr; xch; xch = xche->next) {
 		xdchange_t *xchp = xch;
 		xche = xdl_get_hunk(&xch, xecfg);
 		if (!xch)
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 16a8fe2f3f..682f97a033 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -102,11 +102,11 @@ static int cmp_recs(xrecord_t *r1, xrecord_t *r2)
 
 static int scanA(struct histindex *index, int line1, int count1)
 {
-	unsigned int ptr, tbl_idx;
+	unsigned int tbl_idx;
 	unsigned int chain_len;
 	struct record **rec_chain, *rec;
 
-	for (ptr = LINE_END(1); line1 <= ptr; ptr--) {
+	for (unsigned int ptr = LINE_END(1); line1 <= ptr; ptr--) {
 		tbl_idx = TABLE_HASH(index, 1, ptr);
 		rec_chain = index->records + tbl_idx;
 		rec = *rec_chain;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index af40c88a5b..becac51e3a 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -96,11 +96,10 @@ static int xdl_cleanup_merge(xdmerge_t *c)
 static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 		int line_count, long flags)
 {
-	int i;
 	xrecord_t **rec1 = xe1->xdf2.recs + i1;
 	xrecord_t **rec2 = xe2->xdf2.recs + i2;
 
-	for (i = 0; i < line_count; i++) {
+	for (int i = 0; i < line_count; i++) {
 		int result = xdl_recmatch(rec1[i]->ptr, rec1[i]->size,
 			rec2[i]->ptr, rec2[i]->size, flags);
 		if (!result)
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index a2d8955537..cf2d432a54 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -75,8 +75,7 @@ struct hashmap {
 
 static int is_anchor(xpparam_t const *xpp, const char *line)
 {
-	int i;
-	for (i = 0; i < xpp->anchors_nr; i++) {
+	for (int i = 0; i < xpp->anchors_nr; i++) {
 		if (!strncmp(line, xpp->anchors[i], strlen(xpp->anchors[i])))
 			return 1;
 	}
-- 
2.43.0.522.g2a540e432f

