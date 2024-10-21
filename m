Received: from srv1.79p.de (srv1.79p.de [213.239.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9081EB9FD
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531244; cv=none; b=sxP/Nrt/0JU+iNbDZOHYwn/bd8JrpobOGBy2cZ6dimQ0pt4fl7UXjg+409mZF3BFmF9kf+So+jGfYbBVvoMe0YmDG0gox33gqIA2IZ1uzsAHWQL3999mC/59jKtTbnfD91A8B6XLqRpQS1Ha5/meBchX+EZK3JXknWDqwOUlzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531244; c=relaxed/simple;
	bh=l96LCMomFzkdcrFTJG1kaxOA9UbXa5Q/E0Pbr0agUyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgemY2+M5Z5tecltqMIvbe5DNTKwWX+Cu5dvL+9fApCSRgd6tt14kpGgDmonX6WtrvRsORncRvn+kHJLfzXljG5kKhAFFcTebcfOsaAOtxmHVvBC0IJlEtR+Zt1NohAaeG4MFHFl9j3aezuwdz55k1UhpR4F+9nF5p8qVNDF6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs-ware.de; spf=pass smtp.mailfrom=cs-ware.de; dkim=pass (2048-bit key) header.d=cs-ware.de header.i=@cs-ware.de header.b=VfJjftfm; arc=none smtp.client-ip=213.239.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs-ware.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-ware.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-ware.de header.i=@cs-ware.de header.b="VfJjftfm"
Received: from srv1.79p.de (localhost [127.0.0.1])
	by srv1.79p.de (Postfix) with ESMTP id 125106000A0;
	Mon, 21 Oct 2024 19:20:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: by srv1.79p.de (Postfix, from userid 1000)
	id 79CF16000A1; Mon, 21 Oct 2024 19:20:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2024; t=1729531232;
	bh=l96LCMomFzkdcrFTJG1kaxOA9UbXa5Q/E0Pbr0agUyw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VfJjftfmuSfH5hb8KfKut1TbBANNYwnNLffHaxGuhJ7Wytx0DbdtMsQz7iZNQeLHC
	 vCYketL2fSIPcZqxFSMiePpm0Ay3mDniuHXEgUtyiE/AEcVAERdrLUlPERBc8/vAfW
	 7A9t5xYlvNxcS6R5UI9l8Fh7AqVHrD9CqwVkf5TxtQO0ffr8G74fcy0qOFoa/dK3u4
	 1S7ZcYHaWeZFCvqKX96pMl/L68xZB0rd8R1rXSfP0t/ngnloXwmVyJzuahV3XaOFZB
	 gfaSGk16phJKNK3yY8kvW9h5qntFTnI0RNveUCywlin68DR6PoVclcPS8L5lUR/B5d
	 hvRrs01FAjF4A==
Message-ID: <6ce47185-690d-415e-95c9-06a3b828be29e@cs-ware.de>
Date: Mon, 21 Oct 2024 17:12:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] global: Fix duplicate word typos
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>
Cc: Sven Strickroth <email@cs-ware.de>, git@vger.kernel.org
References: <b50f9706-bb45-4bf0-8d32-59149615301b@mrtux-pc.local>
 <e1ee980d-d8d2-4c9c-9a73-ba6af9009ba2@app.fastmail.com>
 <ZxYjISSiV-vlE96W@pks.im>
 <89ee8fab-ac1e-4e9b-98b7-f2ad25e8f0d0@app.fastmail.com>
From: Sven Strickroth <email@cs-ware.de>
In-Reply-To: <89ee8fab-ac1e-4e9b-98b7-f2ad25e8f0d0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8

Used regex to find these typos:

    (?<!struct )(?<=\s)([a-z]{1,}) \1(?=\s)

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
