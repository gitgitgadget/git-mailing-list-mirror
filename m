Received: from srv1.79p.de (srv1.79p.de [213.239.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B10D1CCB38
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729331068; cv=none; b=oH87eqUtW5I+f0WTz1QUD5xAv7bzt3Qsr8Bpar68HQUJbzeoPvCq25ZJpy08pqdReLyHHoatm/Yy5GJDdKEGyzfwN6AdxssI0X2ZkEJN0aC3quxNkaGDkTJitYqwD9q8tpReasqSzorv9KLNOW1wERkuXV//dzS19Dl8BHwip4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729331068; c=relaxed/simple;
	bh=eiIA4awy57Xnnj/AG0J9dZ9D77szucqhD6Kk/9hq/uc=;
	h=Date:From:CC:To:Subject:Message-ID:MIME-Version:Content-Type; b=O0UfkPuRpkHQ8zOk2nGQvQMpkw+RylK03tKWmamK4JdPErbBA5huaQXDz5JJnzZcgHA9hMZNQlvTygBBt7jNElYP0XO7cd64F4jqUoXuwdkdjbXaXEDxi5pwVskw8djk0KPc4+kSP4CfEmf4tziJhdy+TOq+wgfFaZ7OBWzZB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs-ware.de; spf=pass smtp.mailfrom=cs-ware.de; dkim=pass (2048-bit key) header.d=cs-ware.de header.i=@cs-ware.de header.b=jrF/y0KV; arc=none smtp.client-ip=213.239.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs-ware.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-ware.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-ware.de header.i=@cs-ware.de header.b="jrF/y0KV"
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from mrtux-pc.local (i5C75E01B.versanet.de [92.117.224.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with SMTP id 64C506000A6;
	Sat, 19 Oct 2024 11:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2024; t=1729330681;
	bh=eiIA4awy57Xnnj/AG0J9dZ9D77szucqhD6Kk/9hq/uc=;
	h=Date:From:CC:To:Subject:From;
	b=jrF/y0KVRDCDgsJSjwRCpFbPOsvIqwyf9N/w9scwr2hhOPf0ZqQvCYtaFf5v0R503
	 9wscrO8XJXmOUklCwdq58sIFOkBNaQvcWHTOxkkRQ26HQhUdpPUEUyENBrSzjQBEV9
	 7nWrv+yrBXYeOMc1KJmDtP8Jn9QsY744stn6PbEQ7r9OLaRewEBEBapIwiSNxyrpl3
	 OEEmXiSUbqd4xUScD+Q6Futp9QWxXKSJmqWgOEcdS+jZ2e/ee6oniPQ3V6Y79E9BOr
	 MngbpyCuTZXPx+5JfUIrL2S3U8lgk7lwwOKAqALZz2RAYcVBqCJnfLY6ZKnrTAEKkP
	 MTWm/GEVY7PbQ==
Date: Sat, 19 Oct 2024 11:37:58 +0100
From: Sven Strickroth <email@cs-ware.de>
CC: email@cs-ware.de
Sender: Sven Strickroth <email@cs-ware.de>
To: git@vger.kernel.org
Subject: [PATCH] Fix duplicate word typos
Message-ID: <b50f9706-bb45-4bf0-8d32-59149615301b@mrtux-pc.local>
X-Mailer: TortoiseGit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Used regex to find these typos: "(?<!struct )(?<=\s)([a-z]{1,}) \1(?=\s)"

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 Documentation/RelNotes/2.45.0.txt                      | 2 +-
 Documentation/RelNotes/2.46.0.txt                      | 2 +-
 Documentation/git-format-patch.txt                     | 2 +-
 Documentation/gitprotocol-v2.txt                       | 2 +-
 Documentation/howto/keep-canonical-history-correct.txt | 2 +-
 builtin/difftool.c                                     | 2 +-
 ci/lib.sh                                              | 2 +-
 fsmonitor.c                                            | 2 +-
 oidtree.c                                              | 2 +-
 read-cache-ll.h                                        | 2 +-
 refs/reftable-backend.c                                | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/RelNotes/2.45.0.txt b/Documentation/RelNotes/2.45.0.txt
index fec193679f..aa0315259b 100644
--- a/Documentation/RelNotes/2.45.0.txt
+++ b/Documentation/RelNotes/2.45.0.txt
@@ -9,7 +9,7 @@ UI, Workflows & Features
    With "git init --ref-format=reftable", hopefully it would be a lot
    more efficient to manage a repository with many references.
 
- * "git checkout -p" and friends learned that that "@" is a synonym
+ * "git checkout -p" and friends learned that "@" is a synonym
    for "HEAD".
 
  * Variants of vimdiff learned to honor mergetool.<variant>.layout
diff --git a/Documentation/RelNotes/2.46.0.txt b/Documentation/RelNotes/2.46.0.txt
index b25475918a..c06a04a91b 100644
--- a/Documentation/RelNotes/2.46.0.txt
+++ b/Documentation/RelNotes/2.46.0.txt
@@ -78,7 +78,7 @@ UI, Workflows & Features
    turn on cover letters automatically (unless told never to enable
    cover letter with "--no-cover-letter" and such).
 
- * The "--heads" option of "ls-remote" and "show-ref" has been been
+ * The "--heads" option of "ls-remote" and "show-ref" has been
    deprecated; "--branches" replaces "--heads".
 
  * For over a year, setting add.interactive.useBuiltin configuration
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 8708b31593..5dc7bb4cfc 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -250,7 +250,7 @@ is not complete yet ("WIP" stands for "Work In Progress").
 +
 If the convention of the receiving community for a particular extra
 string is to have it _after_ the subject prefix, the string _<rfc>_
-can be prefixed with a dash ("`-`") to signal that the the rest of
+can be prefixed with a dash ("`-`") to signal that the rest of
 the _<rfc>_ string should be appended to the subject prefix instead,
 e.g., `--rfc='-(WIP)'` results in "PATCH (WIP)".
 
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index ca83b2ecc5..1652fef3ae 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -776,7 +776,7 @@ This would allow for optimizing the common case of servers who'd like
 to provide one "big bundle" containing only their "main" branch,
 and/or incremental updates thereof.
 +
-A client receiving such a a response MAY assume that they can skip
+A client receiving such a response MAY assume that they can skip
 retrieving the header from a bundle at the indicated URI, and thus
 save themselves and the server(s) the request(s) needed to inspect the
 headers of that bundle or bundles.
diff --git a/Documentation/howto/keep-canonical-history-correct.txt b/Documentation/howto/keep-canonical-history-correct.txt
index 5f800fd85a..e98f03275e 100644
--- a/Documentation/howto/keep-canonical-history-correct.txt
+++ b/Documentation/howto/keep-canonical-history-correct.txt
@@ -13,7 +13,7 @@ that appears to be "backwards" from what other project developers
 expect. This howto presents a suggested integration workflow for
 maintaining a central repository.
 
-Suppose that that central repository has this history:
+Suppose that the central repository has this history:
 
 ------------
     ---o---o---A
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 5772e82106..ca1b089065 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -340,7 +340,7 @@ static void write_file_in_directory(struct strbuf *dir, size_t dir_len,
 /* Write the file contents for the left and right sides of the difftool
  * dir-diff representation for submodules and symlinks. Symlinks and submodules
  * are written as regular text files so that external diff tools can diff them
- * as text files, resulting in behavior that is analogous to to what "git diff"
+ * as text files, resulting in behavior that is analogous to what "git diff"
  * displays for symlink and submodule diffs.
  */
 static void write_standin_files(struct pair_entry *entry,
diff --git a/ci/lib.sh b/ci/lib.sh
index 74b430be23..bfa1fe370b 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -62,7 +62,7 @@ trap "end_group 'CI setup'" EXIT
 # something went wrong.
 #
 # We already enabled tracing executed commands earlier. This helps by showing
-# how # environment variables are set and and dependencies are installed.
+# how # environment variables are set and dependencies are installed.
 set -e
 
 skip_branch_tip_with_tag () {
diff --git a/fsmonitor.c b/fsmonitor.c
index 237ca59d00..309a2541cb 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -247,7 +247,7 @@ static size_t handle_using_name_hash_icase(
 	 * technically this is a tracked file or a sparse-directory.
 	 * It should not have any entries in the untracked-cache, so
 	 * we should not need to use the case-corrected spelling to
-	 * invalidate the the untracked-cache.  So we may not need to
+	 * invalidate the untracked-cache.  So we may not need to
 	 * do this.  For now, I'm going to be conservative and always
 	 * do it; we can revisit this later.
 	 */
diff --git a/oidtree.c b/oidtree.c
index 92d03b52db..151568f74f 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -47,7 +47,7 @@ void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
 
 	/*
 	 * n.b. Current callers won't get us duplicates, here.  If a
-	 * future caller causes duplicates, there'll be a a small leak
+	 * future caller causes duplicates, there'll be a small leak
 	 * that won't be freed until oidtree_clear.  Currently it's not
 	 * worth maintaining a free list
 	 */
diff --git a/read-cache-ll.h b/read-cache-ll.h
index b5d11d07a8..71b49d9af4 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -196,7 +196,7 @@ struct index_state {
  *
  * If the variable won't be used again, use release_index() to free()
  * its resources. If it needs to be used again use discard_index(),
- * which does the same thing, but will use use index_state_init() at
+ * which does the same thing, but will use index_state_init() at
  * the end. The discard_index() will use its own "istate->repo" as the
  * "r" argument to index_state_init() in that case.
  */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 3c6107c7ce..38eb14d591 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2131,7 +2131,7 @@ static int write_reflog_existence_table(struct reftable_writer *writer,
 	reftable_writer_set_limits(writer, ts, ts);
 
 	/*
-	 * The existence entry has both old and new object ID set to the the
+	 * The existence entry has both old and new object ID set to the
 	 * null object ID. Our iterators are aware of this and will not present
 	 * them to their callers.
 	 */
-- 
2.47.0.windows.1


