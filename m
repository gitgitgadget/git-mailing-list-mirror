Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383532D94B3
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589588; cv=none; b=VTmVK8p8S5UgEgUpFicDuprxf7dOalY/t/mVoRX8RUNdSNfQdWQfQGVRMeAnh6h8cnLCDLekwZEFYc4a4oWH7sX/l8F2PkZ/V8e5NiX5tCRMo/qlBl3YJM0jRQJSBz3c9gyc+446g66PWtWQx8Ms+GoOe4zWCTfeZJ9jQPhQjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589588; c=relaxed/simple;
	bh=907pZpwLpP14nakIFwiUQJpN0U/TKL9H8orcG5oOrAc=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=fkWEW2GkB+UnhmNgj3/+K+HYVbCg48/HG75NA1E9uWX3jp8EpFAooCsP8vaO49rWyNXHX8xdyUnJzZC04COZ/VpTLIisnEJQEzWOYsaPKnj0xMABWPQIjzqiMIBe4JCnJJfcG4FaO3ZTTKP8/BwQtQNVx0UapqIRyJHmYywTNuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km2Uq8Tz; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km2Uq8Tz"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430d4cf258fso19038435ab.0
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761589584; x=1762194384; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zJwbvKXT+g7JXir3j/+Y29PfbjgK/l1cZwWD88oAfCk=;
        b=Km2Uq8TzpBI8BOY8yd0RP0bpdbRHYqqdJxmvHG2Syx939hT51+5KbNFTmKfDLKwF0d
         i61BYiQeUHEvFQgACtP998Cc+Vu5BboQJwJfWxgACBzMgirgDU63HBhGFlfBzJk4qAbg
         Tp1VvDgYSYZmnd3esXA8mFNUuYx+wnIFCd/jun/kjXQAOl0ek+r1m2ZElqmqNZpk4RAV
         3kO6JCcUSpHNpr3PRbJajKU7CmTrERy5LAuj+6DA8bVsa29NlHzk4wva4gEyPlOOrogn
         W6q870lTanoyfdhr9a5RNysG0ClqowDwJP5du1mzzhdyZb4yvYokXhwtBta8B0Pd0Edl
         EuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761589584; x=1762194384;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJwbvKXT+g7JXir3j/+Y29PfbjgK/l1cZwWD88oAfCk=;
        b=osBPKxgbSZT23iKOMT6WU+f0hnlPUov5o34OVYVOqdkYdQuXllNs9A1spGzCwsaTs6
         KjvNzZaWuAWc420gJB907Newk1qK9AR74Eo4IC/KnrtWVHcPI4y4TAi5PK4DNP36qEb5
         AKLLM/nFX9p5/vffg3+hO2qs7cTMLDtUCkzhAO05Js5yVIllmMNlBFs0AuCyiOZ9CEAh
         nQ2Zn2eKKhBFBxkd9ujbfmoacEFsBRUvFP5f1TKT3qbojaPXup+TfgW+2q2oAo+p62rq
         prE9dqkge5ZhWONSdgmh3TB8abY2qMefW5rx9V0T+viVFszGsfej4YpH/04oev03UimS
         0gjQ==
X-Gm-Message-State: AOJu0YzQGbWi7MlXJbynVVmOt5AJNPuUW0J7HvA0yMgphz3h8X1JTNIC
	fJCKNrWU/DlWda8d3AKbVAqpBxsjBUVEbdKJML9ft6bes5zQ6BFEvwiopc1bLQ==
X-Gm-Gg: ASbGncu+3ziahLiy/BIYrWGxnaU0KguXYyYg3EpsTuovjsvFBl9/vVdz/k84cvaEDYX
	dY8zaG8TCMMAkKMa7MBEAJUNX5kM/ZERY1H3DUxDdQWTxS336KzN6rSxonJ7znFWSDY8nsCTZ5Y
	QEWJ3A2zVL16hsi+EsX0Jxt5LnZizMDukzZsbdGhzkTe5vrSXWAolEcYgVDrXd8qzDNw5f6Nbg2
	z0LGIXdm26QpRQu1VtjIL1dTWeL288x6qxybJ/nTFT6pfZSJSZY/1fZIaOwHRqFqCl/IJ4sFu9c
	NlgaANkFO1Moq4PtJ5A/xSDXV+ihjTHHY5t377MRbHIKddayYSgX2Vpbd3RswlLGS6knGF2vtLj
	zazVlXTDDUY0bjCPNd691si3n+IT9AcDLB2A7Nybddz9/DgI+RjKXd8Eepi8r9zpzCkHUWigDLk
	J7VmTafatQGBWg/g==
X-Google-Smtp-Source: AGHT+IEK3uiqN9yH5pr3uBIdlFeaD1zRUHfkzto1mXpcFdud2eU8vN/I8icDi3h9By6PGWEoU33U+Q==
X-Received: by 2002:a05:6e02:1807:b0:430:b3e2:a96e with SMTP id e9e14a558f8ab-4320f8600c7mr12674415ab.28.1761589583005;
        Mon, 27 Oct 2025 11:26:23 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.176.234])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359f11c22sm266432439f.15.2025.10.27.11.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:26:21 -0700 (PDT)
Message-Id: <pull.2077.git.git.1761589580028.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 Oct 2025 18:26:20 +0000
Subject: [PATCH] refs: support migration with worktrees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Sam Bostock <sam.bostock@shopify.com>,
    Sam Bostock <sam.bostock@shopify.com>

From: Sam Bostock <sam.bostock@shopify.com>

Remove the worktree limitation from `git refs migrate` by implementing
migration support for repositories with linked worktrees.

Previously, attempting to migrate a repository with worktrees would fail
with "migrating repositories with worktrees is not supported yet". This
limitation existed because each worktree has its own ref storage that
needed to be migrated separately.

Migration now uses a multi-phase approach to safely handle multiple
worktrees:

1. Phase 1: Iterate through all worktrees and create temporary new ref
   storage for each in a staging directory.

2. Phase 2: For each worktree, backup the existing ref storage, then
   move the new storage into place.

3. Phase 3: Update the repository format config, clear cached ref stores,
   and delete all backups. On failure, restore from backups and report
   where the migrated refs can be found for manual recovery.

This approach ensures that if migration fails partway through, the
repository can be restored to its original state.

Key implementation details:

- For files backend: Create a commondir file in temp directories for
  linked worktrees so the files backend knows where the common git
  directory is located.

- For linked worktrees: Use non-INITIAL transactions to avoid creating
  packed-refs files (linked worktrees should never have packed-refs).

- Filter refs during iteration: Linked worktrees only migrate their
  per-worktree refs (refs/bisect/*, refs/rewritten/*, refs/worktree/*).
  Shared refs are migrated once in the main worktree.

- Write per-worktree refs as loose files: The files backend's
  transaction_finish_initial() optimization writes most refs to
  packed-refs, but per-worktree refs must be stored as loose files
  to maintain proper worktree isolation.

- Backup root refs: During Phase 2, backup all root refs (HEAD,
  ORIG_HEAD, etc.) by iterating files in the git directory and using
  is_root_ref() to identify them. This ensures safe rollback if
  migration fails.

Tests are updated to expect migration with worktrees to succeed, and
new tests verify:
- Basic worktree migration in both directions (files ↔ reftable)
- Migration with multiple worktrees
- Dry-run mode with worktrees
- Physical separation of per-worktree refs
- Bare repository with worktrees

Documentation is updated to reflect the worktree support and note that
migration must be run from the main worktree.

As the author's familiarity with git internals and C is limited, this
change was made with the assistance of Claude Code. However, the author
has carefully reviewed and iterated on the work to ensure quality to the
best of their ability.

Signed-off-by: Sam Bostock <sam.bostock@shopify.com>
Co-Authored-By: Claude <noreply@anthropic.com>
---
    Teach git refs migrate to support worktrees

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2077%2Fsambostock%2Frefs-migrate-worktree-support-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2077/sambostock/refs-migrate-worktree-support-v1
Pull-Request: https://github.com/git/git/pull/2077

 Documentation/git-refs.adoc |   5 +-
 refs.c                      | 726 ++++++++++++++++++++++++++++--------
 refs/files-backend.c        |   6 +-
 t/t1460-refs-migrate.sh     | 446 +++++++++++++++++++++-
 4 files changed, 1023 insertions(+), 160 deletions(-)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index fa33680cc7..f6a3bf4f03 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -30,7 +30,8 @@ COMMANDS
 --------
 
 `migrate`::
-	Migrate ref store between different formats.
+	Migrate ref store between different formats. Supports repositories
+	with worktrees; migration must be run from the main worktree.
 
 `verify`::
 	Verify reference database consistency.
@@ -95,7 +96,7 @@ KNOWN LIMITATIONS
 
 The ref format migration has several known limitations in its current form:
 
-* It is not possible to migrate repositories that have worktrees.
+* Migration must be run from the main worktree.
 
 * There is no way to block concurrent writes to the repository during an
   ongoing migration. Concurrent writes can lead to an inconsistent migrated
diff --git a/refs.c b/refs.c
index 965381367e..0834329e5a 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "advice.h"
 #include "config.h"
 #include "environment.h"
@@ -28,6 +29,7 @@
 #include "setup.h"
 #include "sigchain.h"
 #include "date.h"
+#include "dir.h"
 #include "commit.h"
 #include "wildmatch.h"
 #include "ident.h"
@@ -2974,8 +2976,296 @@ struct migration_data {
 	struct strbuf *errbuf;
 	struct strbuf sb, name, mail;
 	uint64_t index;
+	int is_main_worktree;
 };
 
+/*
+ * Holds the state for migrating a single worktree's ref storage.
+ */
+struct worktree_migration_data {
+	struct worktree *worktree;
+	struct ref_store *old_refs;
+	struct ref_store *new_refs;
+	struct strbuf new_dir;
+	struct strbuf backup_dir;
+	int is_main;
+};
+
+static void worktree_migration_data_release(struct worktree_migration_data *wt_data)
+{
+	if (wt_data->new_refs) {
+		ref_store_release(wt_data->new_refs);
+		FREE_AND_NULL(wt_data->new_refs);
+	}
+	strbuf_release(&wt_data->new_dir);
+	strbuf_release(&wt_data->backup_dir);
+}
+
+static void worktree_migration_data_array_release(struct worktree_migration_data *wt_data,
+						   size_t nr)
+{
+	for (size_t i = 0; i < nr; i++)
+		worktree_migration_data_release(&wt_data[i]);
+	free(wt_data);
+}
+
+/*
+ * Create a commondir file in the temporary migration directory for a linked
+ * worktree. The files backend needs this to locate the common git directory.
+ * Returns 0 on success, -1 on failure.
+ */
+static int create_commondir_file(const char *new_dir, const char *worktree_path,
+				  struct strbuf *errbuf)
+{
+	struct strbuf commondir_path = STRBUF_INIT;
+	struct strbuf commondir_content = STRBUF_INIT;
+	int fd = -1;
+	int ret = 0;
+
+	strbuf_addf(&commondir_path, "%s/commondir", new_dir);
+	strbuf_addstr(&commondir_content, "../..\n");
+
+	fd = open(commondir_path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (fd < 0) {
+		strbuf_addf(errbuf, _("cannot create commondir file for worktree '%s': %s"),
+			    worktree_path, strerror(errno));
+		ret = -1;
+		goto done;
+	}
+
+	if (write_in_full(fd, commondir_content.buf, commondir_content.len) < 0) {
+		strbuf_addf(errbuf, _("cannot write commondir file for worktree '%s': %s"),
+			    worktree_path, strerror(errno));
+		ret = -1;
+		goto done;
+	}
+
+done:
+	if (fd >= 0)
+		close(fd);
+	strbuf_release(&commondir_path);
+	strbuf_release(&commondir_content);
+	return ret;
+}
+
+/*
+ * Returns the list of ref storage items to backup/restore for a worktree.
+ * Main worktrees include packed-refs, linked worktrees do not.
+ */
+static const char **get_ref_storage_items(int is_main_worktree)
+{
+	static const char *main_items[] = {"refs", "logs", "reftable", "packed-refs", NULL};
+	static const char *linked_items[] = {"refs", "logs", "reftable", NULL};
+
+	return is_main_worktree ? main_items : linked_items;
+}
+
+/*
+ * Move root ref files from one directory to another. Root refs are individual
+ * files in the git directory like HEAD, ORIG_HEAD, etc. If remove_dest is set,
+ * unlink the destination file before moving.
+ *
+ * Returns -1 on fatal error (cannot open source directory), 0 on success,
+ * or positive count of files that failed to move. Detailed error messages
+ * are appended to errbuf if provided.
+ */
+static int move_root_refs(const char *from_dir, const char *to_dir,
+			  int remove_dest, struct strbuf *errbuf)
+{
+	struct strbuf from = STRBUF_INIT, to = STRBUF_INIT;
+	DIR *dir = opendir(from_dir);
+	struct dirent *e;
+	int ret = 0;
+	int failed_moves = 0;
+
+	if (!dir) {
+		ret = -1;
+		goto done;
+	}
+
+	while ((e = readdir(dir))) {
+		struct stat st;
+
+		if (!strcmp(e->d_name, ".") || !strcmp(e->d_name, ".."))
+			continue;
+
+		/* Only process files that are root refs */
+		if (!is_root_ref(e->d_name))
+			continue;
+
+		strbuf_reset(&from);
+		strbuf_addf(&from, "%s/%s", from_dir, e->d_name);
+
+		if (stat(from.buf, &st) < 0) {
+			if (errno != ENOENT && errbuf) {
+				strbuf_addf(errbuf, _("could not stat '%s': %s; "),
+					    from.buf, strerror(errno));
+				failed_moves++;
+			}
+			continue;
+		}
+
+		if (!S_ISREG(st.st_mode))
+			continue; /* skip non-files */
+
+		strbuf_reset(&to);
+		strbuf_addf(&to, "%s/%s", to_dir, e->d_name);
+
+		if (remove_dest) {
+			if (unlink(to.buf) < 0 && errno != ENOENT && errbuf) {
+				strbuf_addf(errbuf, _("could not unlink '%s': %s; "),
+					    to.buf, strerror(errno));
+				failed_moves++;
+				continue;
+			}
+		}
+
+		if (rename(from.buf, to.buf) < 0) {
+			if (errbuf) {
+				strbuf_addf(errbuf, _("could not move '%s' to '%s': %s; "),
+					    from.buf, to.buf, strerror(errno));
+				failed_moves++;
+			}
+		}
+	}
+	closedir(dir);
+	ret = failed_moves;
+
+done:
+	strbuf_release(&from);
+	strbuf_release(&to);
+	return ret;
+}
+
+/*
+ * Backup ref storage by moving ref-related files/directories to a backup
+ * location. Returns 0 on success, -1 on failure.
+ */
+static int backup_ref_storage(const char *gitdir, const char *backup_dir,
+			       int is_main_worktree, struct strbuf *errbuf)
+{
+	struct strbuf from = STRBUF_INIT, to = STRBUF_INIT;
+	const char **items = get_ref_storage_items(is_main_worktree);
+	size_t i;
+	int ret = 0;
+
+	/*
+	 * Move ref-related files and directories. Not all will exist depending
+	 * on the backend, which is fine.
+	 */
+	for (i = 0; items[i]; i++) {
+		const char *item;
+		struct stat st;
+
+		item = items[i];
+		strbuf_reset(&from);
+		strbuf_addf(&from, "%s/%s", gitdir, item);
+
+		if (stat(from.buf, &st) < 0) {
+			if (errno == ENOENT)
+				continue; /* doesn't exist, skip */
+			strbuf_addf(errbuf, _("could not stat '%s': %s"),
+				    from.buf, strerror(errno));
+			ret = -1;
+			goto done;
+		}
+
+		strbuf_reset(&to);
+		strbuf_addf(&to, "%s/%s", backup_dir, item);
+
+		if (rename(from.buf, to.buf) < 0) {
+			strbuf_addf(errbuf, _("could not move '%s' to '%s': %s"),
+				    from.buf, to.buf, strerror(errno));
+			ret = -1;
+			goto done;
+		}
+	}
+
+	/* Backup root refs (HEAD, ORIG_HEAD, etc.) */
+	ret = move_root_refs(gitdir, backup_dir, 0, errbuf);
+	if (ret < 0) {
+		strbuf_addf(errbuf, _("could not open directory '%s' to backup root refs: %s"),
+			    gitdir, strerror(errno));
+		ret = -1;
+		goto done;
+	} else if (ret > 0) {
+		/* Some root refs failed to backup - this is fatal */
+		strbuf_addstr(errbuf, _("failed to backup some root refs"));
+		ret = -1;
+		goto done;
+	}
+	ret = 0;
+
+done:
+	strbuf_release(&from);
+	strbuf_release(&to);
+	return ret;
+}
+
+/*
+ * Restore ref storage from backup by moving files back.
+ */
+static void restore_ref_storage_from_backup(const char *gitdir,
+					     const char *backup_dir,
+					     int is_main_worktree)
+{
+	struct strbuf from = STRBUF_INIT, to = STRBUF_INIT;
+	const char **items = get_ref_storage_items(is_main_worktree);
+	size_t i;
+
+	for (i = 0; items[i]; i++) {
+		const char *item;
+		struct stat st;
+
+		item = items[i];
+		strbuf_reset(&from);
+		strbuf_addf(&from, "%s/%s", backup_dir, item);
+
+		if (stat(from.buf, &st) < 0)
+			continue; /* doesn't exist in backup */
+
+		strbuf_reset(&to);
+		strbuf_addf(&to, "%s/%s", gitdir, item);
+
+		/* Remove what's currently there (new storage that failed) */
+		if (stat(to.buf, &st) == 0) {
+			if (S_ISDIR(st.st_mode))
+				remove_dir_recursively(&to, 0);
+			else
+				unlink(to.buf);
+		}
+
+		rename(from.buf, to.buf);
+	}
+
+	/* Restore root refs from backup */
+	{
+		struct strbuf restore_err = STRBUF_INIT;
+		int restore_ret = move_root_refs(backup_dir, gitdir, 1, &restore_err);
+		if (restore_ret < 0) {
+			warning_errno(_("could not open directory '%s' to restore root refs"), backup_dir);
+		} else if (restore_ret > 0) {
+			warning(_("failed to restore some root refs: %s"), restore_err.buf);
+		}
+		strbuf_release(&restore_err);
+	}
+
+	strbuf_release(&from);
+	strbuf_release(&to);
+}
+
+/*
+ * Delete backup directory and its contents.
+ */
+static void delete_backup(const char *backup_dir)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_addstr(&path, backup_dir);
+	remove_dir_recursively(&path, 0);
+	strbuf_release(&path);
+}
+
 static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			   int flags, void *cb_data)
 {
@@ -2983,6 +3273,16 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
 	struct strbuf symref_target = STRBUF_INIT;
 	int ret;
 
+	/*
+	 * For linked worktrees, only migrate per-worktree refs. Shared refs
+	 * are migrated once in the main worktree.
+	 */
+	if (!data->is_main_worktree) {
+		enum ref_worktree_type type = parse_worktree_ref(refname, NULL, NULL, NULL);
+		if (type != REF_WORKTREE_CURRENT)
+			return 0;
+	}
+
 	if (flags & REF_ISSYMREF) {
 		ret = refs_read_symbolic_ref(data->old_refs, refname, &symref_target);
 		if (ret < 0)
@@ -3052,7 +3352,7 @@ static int move_files(const char *from_path, const char *to_path, struct strbuf
 
 	from_dir = opendir(from_path);
 	if (!from_dir) {
-		strbuf_addf(errbuf, "could not open source directory '%s': %s",
+		strbuf_addf(errbuf, _("could not open source directory '%s': %s"),
 			    from_path, strerror(errno));
 		ret = -1;
 		goto done;
@@ -3086,14 +3386,14 @@ static int move_files(const char *from_path, const char *to_path, struct strbuf
 
 		ret = rename(from_buf.buf, to_buf.buf);
 		if (ret < 0) {
-			strbuf_addf(errbuf, "could not link file '%s' to '%s': %s",
+			strbuf_addf(errbuf, _("could not link file '%s' to '%s': %s"),
 				    from_buf.buf, to_buf.buf, strerror(errno));
 			goto done;
 		}
 	}
 
 	if (errno) {
-		strbuf_addf(errbuf, "could not read entry from directory '%s': %s",
+		strbuf_addf(errbuf, _("could not read entry from directory '%s': %s"),
 			    from_path, strerror(errno));
 		ret = -1;
 		goto done;
@@ -3109,211 +3409,339 @@ done:
 	return ret;
 }
 
-static int has_worktrees(void)
-{
-	struct worktree **worktrees = get_worktrees();
-	int ret = 0;
-	size_t i;
-
-	for (i = 0; worktrees[i]; i++) {
-		if (is_main_worktree(worktrees[i]))
-			continue;
-		ret = 1;
-	}
-
-	free_worktrees(worktrees);
-	return ret;
-}
-
 int repo_migrate_ref_storage_format(struct repository *repo,
 				    enum ref_storage_format format,
 				    unsigned int flags,
 				    struct strbuf *errbuf)
 {
-	struct ref_store *old_refs = NULL, *new_refs = NULL;
-	struct ref_transaction *transaction = NULL;
-	struct strbuf new_gitdir = STRBUF_INIT;
-	struct migration_data data = {
-		.sb = STRBUF_INIT,
-		.name = STRBUF_INIT,
-		.mail = STRBUF_INIT,
-	};
-	int did_migrate_refs = 0;
+	struct worktree **worktrees = NULL;
+	struct worktree_migration_data *wt_migrations = NULL;
+	size_t nr_worktrees = 0;
 	int ret;
 
 	if (repo->ref_storage_format == format) {
-		strbuf_addstr(errbuf, "current and new ref storage format are equal");
+		strbuf_addstr(errbuf, _("current and new ref storage format are equal"));
 		ret = -1;
 		goto done;
 	}
 
-	old_refs = get_main_ref_store(repo);
+	/*
+	 * Enumerate all worktrees. We use the variant that doesn't try to read
+	 * HEAD both because we don't need it (we'll migrate all refs including
+	 * HEAD anyway) and to avoid failures if the ref storage is already
+	 * inconsistent (e.g., from a previous interrupted migration or corruption).
+	 */
+	worktrees = get_worktrees_without_reading_head();
+	for (nr_worktrees = 0; worktrees[nr_worktrees]; nr_worktrees++)
+		; /* count worktrees */
 
 	/*
-	 * Worktrees complicate the migration because every worktree has a
-	 * separate ref storage. While it should be feasible to implement, this
-	 * is pushed out to a future iteration.
-	 *
-	 * TODO: we should really be passing the caller-provided repository to
-	 * `has_worktrees()`, but our worktree subsystem doesn't yet support
-	 * that.
+	 * Migration must be run from the main worktree. When running from a
+	 * linked worktree, the_repository context points to the worktree's
+	 * gitdir, causing the migration logic to operate on the wrong
+	 * directory structure.
 	 */
-	if (has_worktrees()) {
-		strbuf_addstr(errbuf, "migrating repositories with worktrees is not supported yet");
-		ret = -1;
-		goto done;
+	for (size_t i = 0; i < nr_worktrees; i++) {
+		if (worktrees[i]->is_current && !is_main_worktree(worktrees[i])) {
+			strbuf_addf(errbuf, _("migration must be run from the main worktree at %s"),
+				    worktrees[0]->path);
+			ret = -1;
+			goto done;
+		}
 	}
 
+	CALLOC_ARRAY(wt_migrations, nr_worktrees);
+
 	/*
 	 * The overall logic looks like this:
 	 *
-	 *   1. Set up a new temporary directory and initialize it with the new
-	 *      format. This is where all refs will be migrated into.
+	 *   1. For each worktree, set up a new temporary directory and
+	 *      initialize it with the new format. This is where all refs for
+	 *      that worktree will be migrated into.
 	 *
-	 *   2. Enumerate all refs and write them into the new ref storage.
-	 *      This operation is safe as we do not yet modify the main
-	 *      repository.
+	 *   2. For each worktree, enumerate all refs and write them into the
+	 *      new ref storage. This operation is safe as we do not yet modify
+	 *      the main repository.
 	 *
-	 *   3. Enumerate all reflogs and write them into the new ref storage.
-	 *      This operation is safe as we do not yet modify the main
-	 *      repository.
+	 *   3. For each worktree, enumerate all reflogs and write them into
+	 *      the new ref storage. This operation is safe as we do not yet
+	 *      modify the main repository.
 	 *
 	 *   4. If we're in dry-run mode then we are done and can hand over the
-	 *      directory to the caller for inspection. If not, we now start
+	 *      directories to the caller for inspection. If not, we now start
 	 *      with the destructive part.
 	 *
-	 *   5. Delete the old ref storage from disk. As we have a copy of refs
-	 *      in the new ref storage it's okay(ish) if we now get interrupted
-	 *      as there is an equivalent copy of all refs available.
+	 *   5. For each worktree, create a backup of the old ref storage by
+	 *      moving it to a backup location.
+	 *
+	 *   6. For each worktree, move the new ref storage files into place.
+	 *      As we have a backup it's okay if we now get interrupted as the
+	 *      repository can be restored to its original state.
 	 *
-	 *   6. Move the new ref storage files into place.
+	 *   7. Change the repository format to the new ref format. Clear any
+	 *      cached ref stores so they get reloaded with the new format.
 	 *
-	 *  7. Change the repository format to the new ref format.
+	 *   8. Delete the backup directories.
+	 *
+	 * All worktrees are processed sequentially. Parallelization would add
+	 * complexity for minimal benefit since most repos have few worktrees
+	 * and migration is a one-time operation.
 	 */
-	strbuf_addf(&new_gitdir, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
-	if (!mkdtemp(new_gitdir.buf)) {
-		strbuf_addf(errbuf, "cannot create migration directory: %s",
-			    strerror(errno));
-		ret = -1;
-		goto done;
-	}
+	for (size_t i = 0; i < nr_worktrees; i++) {
+		struct worktree_migration_data *wt_data = &wt_migrations[i];
+		struct ref_transaction *transaction = NULL;
+		struct migration_data data = {
+			.sb = STRBUF_INIT,
+			.name = STRBUF_INIT,
+			.mail = STRBUF_INIT,
+		};
+		int create_flags = 0;
+
+		wt_data->worktree = worktrees[i];
+		wt_data->is_main = is_main_worktree(worktrees[i]);
+		wt_data->old_refs = get_worktree_ref_store(worktrees[i]);
+		strbuf_init(&wt_data->new_dir, 0);
+		strbuf_init(&wt_data->backup_dir, 0);
+
+		/* Create temporary directory for new ref storage */
+		strbuf_addf(&wt_data->new_dir, "%s/ref_migration.XXXXXX",
+			    wt_data->old_refs->gitdir);
+
+		if (!mkdtemp(wt_data->new_dir.buf)) {
+			strbuf_addf(errbuf, _("cannot create migration directory for worktree '%s': %s"),
+				    worktrees[i]->path, strerror(errno));
+			ret = -1;
+			goto done;
+		}
 
-	new_refs = ref_store_init(repo, format, new_gitdir.buf,
-				  REF_STORE_ALL_CAPS);
-	ret = ref_store_create_on_disk(new_refs, 0, errbuf);
-	if (ret < 0)
-		goto done;
+		/*
+		 * For linked worktrees migrating to files format, create a commondir
+		 * file in the temp directory so the files backend knows where the
+		 * common git directory is. Reftable doesn't use commondir files.
+		 */
+		if (!wt_data->is_main && format == REF_STORAGE_FORMAT_FILES) {
+			if (create_commondir_file(wt_data->new_dir.buf,
+						  worktrees[i]->path, errbuf) < 0) {
+				ret = -1;
+				goto done;
+			}
+		}
 
-	transaction = ref_store_transaction_begin(new_refs, REF_TRANSACTION_FLAG_INITIAL,
-						  errbuf);
-	if (!transaction)
-		goto done;
+		/* Initialize new ref store */
+		wt_data->new_refs = ref_store_init(repo, format, wt_data->new_dir.buf,
+						   REF_STORE_ALL_CAPS);
 
-	data.old_refs = old_refs;
-	data.transaction = transaction;
-	data.errbuf = errbuf;
+		/* For linked worktrees, we only need to create the worktree-specific structure */
+		if (!wt_data->is_main)
+			create_flags = REF_STORE_CREATE_ON_DISK_IS_WORKTREE;
 
-	/*
-	 * We need to use the internal `do_for_each_ref()` here so that we can
-	 * also include broken refs and symrefs. These would otherwise be
-	 * skipped silently.
-	 *
-	 * Ideally, we would do this call while locking the old ref storage
-	 * such that there cannot be any concurrent modifications. We do not
-	 * have the infra for that though, and the "files" backend does not
-	 * allow for a central lock due to its design. It's thus on the user to
-	 * ensure that there are no concurrent writes.
-	 */
-	ret = do_for_each_ref(old_refs, "", NULL, migrate_one_ref, 0,
-			      DO_FOR_EACH_INCLUDE_ROOT_REFS | DO_FOR_EACH_INCLUDE_BROKEN,
-			      &data);
-	if (ret < 0)
-		goto done;
+		ret = ref_store_create_on_disk(wt_data->new_refs, create_flags, errbuf);
+		if (ret < 0)
+			goto done;
+
+		/*
+		 * Begin transaction for migrating refs. For linked worktrees,
+		 * we don't use REF_TRANSACTION_FLAG_INITIAL because that flag
+		 * causes refs to be written to packed-refs, which should not
+		 * exist in linked worktree directories.
+		 */
+		transaction = ref_store_transaction_begin(wt_data->new_refs,
+							  wt_data->is_main ? REF_TRANSACTION_FLAG_INITIAL : 0,
+							  errbuf);
+		if (!transaction) {
+			ret = -1;
+			goto done;
+		}
+
+		data.old_refs = wt_data->old_refs;
+		data.transaction = transaction;
+		data.errbuf = errbuf;
+		data.is_main_worktree = wt_data->is_main;
+
+		/*
+		 * We need to use the internal `do_for_each_ref()` here so that
+		 * we can also include broken refs and symrefs. These would
+		 * otherwise be skipped silently.
+		 *
+		 * Ideally, we would do this call while locking the old ref
+		 * storage such that there cannot be any concurrent modifications.
+		 * We do not have the infra for that though, and the "files"
+		 * backend does not allow for a central lock due to its design.
+		 * It's thus on the user to ensure that there are no concurrent
+		 * writes.
+		 */
+		ret = do_for_each_ref(wt_data->old_refs, "", NULL, migrate_one_ref, 0,
+				      DO_FOR_EACH_INCLUDE_ROOT_REFS | DO_FOR_EACH_INCLUDE_BROKEN,
+				      &data);
+		if (ret < 0) {
+			ref_transaction_free(transaction);
+			strbuf_release(&data.sb);
+			strbuf_release(&data.name);
+			strbuf_release(&data.mail);
+			goto done;
+		}
+
+		if (!(flags & REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG)) {
+			ret = refs_for_each_reflog(wt_data->old_refs, migrate_one_reflog, &data);
+			if (ret < 0) {
+				ref_transaction_free(transaction);
+				strbuf_release(&data.sb);
+				strbuf_release(&data.name);
+				strbuf_release(&data.mail);
+				goto done;
+			}
+		}
+
+		ret = ref_transaction_commit(transaction, errbuf);
+		ref_transaction_free(transaction);
+		strbuf_release(&data.sb);
+		strbuf_release(&data.name);
+		strbuf_release(&data.mail);
 
-	if (!(flags & REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG)) {
-		ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
 		if (ret < 0)
 			goto done;
-	}
 
-	ret = ref_transaction_commit(transaction, errbuf);
-	if (ret < 0)
-		goto done;
-	did_migrate_refs = 1;
+		/*
+		 * Linked worktrees should not have a packed-refs file. If one
+		 * was created during the transaction, remove it before moving
+		 * files into place.
+		 */
+		if (!wt_data->is_main) {
+			struct strbuf packed_refs = STRBUF_INIT;
+			strbuf_addf(&packed_refs, "%s/packed-refs", wt_data->new_dir.buf);
+			if (unlink(packed_refs.buf) < 0 && errno != ENOENT)
+				warning_errno(_("could not remove packed-refs from linked worktree at '%s'"),
+					      packed_refs.buf);
+			strbuf_release(&packed_refs);
+		}
+
+		/*
+		 * Release the new ref store to close any open files. This is
+		 * required for platforms like Cygwin where renaming an open
+		 * file results in EPERM.
+		 */
+		ref_store_release(wt_data->new_refs);
+		FREE_AND_NULL(wt_data->new_refs);
+	}
 
 	if (flags & REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN) {
-		printf(_("Finished dry-run migration of refs, "
-			 "the result can be found at '%s'\n"), new_gitdir.buf);
+		printf(_("Finished dry-run migration of refs for %"PRIuMAX" worktree(s)\n"),
+		       (uintmax_t)nr_worktrees);
+		for (size_t i = 0; i < nr_worktrees; i++) {
+			const char *path = wt_migrations[i].new_dir.buf;
+
+			/* Show absolute paths consistently for both main and linked worktrees */
+			if (!is_absolute_path(path))
+				path = absolute_path(path);
+
+			printf(_("  Worktree '%s': %s\n"),
+			       worktrees[i]->path,
+			       path);
+		}
 		ret = 0;
 		goto done;
 	}
 
-	/*
-	 * Release the new ref store such that any potentially-open files will
-	 * be closed. This is required for platforms like Cygwin, where
-	 * renaming an open file results in EPERM.
-	 */
-	ref_store_release(new_refs);
-	FREE_AND_NULL(new_refs);
+	for (size_t i = 0; i < nr_worktrees; i++) {
+		struct worktree_migration_data *wt_data = &wt_migrations[i];
 
-	/*
-	 * Until now we were in the non-destructive phase, where we only
-	 * populated the new ref store. From hereon though we are about
-	 * to get hands by deleting the old ref store and then moving
-	 * the new one into place.
-	 *
-	 * Assuming that there were no concurrent writes, the new ref
-	 * store should have all information. So if we fail from hereon
-	 * we may be in an in-between state, but it would still be able
-	 * to recover by manually moving remaining files from the
-	 * temporary migration directory into place.
-	 */
-	ret = ref_store_remove_on_disk(old_refs, errbuf);
-	if (ret < 0)
-		goto done;
+		/* Create backup directory */
+		strbuf_addf(&wt_data->backup_dir, "%s/ref_migration_backup.XXXXXX",
+			    wt_data->old_refs->gitdir);
+		if (!mkdtemp(wt_data->backup_dir.buf)) {
+			strbuf_addf(errbuf, _("cannot create backup directory for worktree '%s': %s"),
+				    worktrees[i]->path, strerror(errno));
+			ret = -1;
+			goto done;
+		}
 
-	ret = move_files(new_gitdir.buf, old_refs->gitdir, errbuf);
-	if (ret < 0)
-		goto done;
+		/* Backup old ref storage by moving it to backup directory */
+		ret = backup_ref_storage(wt_data->old_refs->gitdir,
+					 wt_data->backup_dir.buf,
+					 wt_data->is_main, errbuf);
+		if (ret < 0) {
+			strbuf_addf(errbuf, _(" (worktree: %s)"), worktrees[i]->path);
+			goto done;
+		}
 
-	if (rmdir(new_gitdir.buf) < 0)
-		warning_errno(_("could not remove temporary migration directory '%s'"),
-			      new_gitdir.buf);
+		/* Move new ref storage into place */
+		ret = move_files(wt_data->new_dir.buf, wt_data->old_refs->gitdir, errbuf);
+		if (ret < 0) {
+			strbuf_addf(errbuf, _(" (worktree: %s)"), worktrees[i]->path);
+			goto done;
+		}
+
+		/* Remove temporary migration directory */
+		if (rmdir(wt_data->new_dir.buf) < 0)
+			warning_errno(_("could not remove temporary migration directory '%s'"),
+				      wt_data->new_dir.buf);
+	}
 
 	/*
-	 * We have migrated the repository, so we now need to adjust the
-	 * repository format so that clients will use the new ref store.
-	 * We also need to swap out the repository's main ref store.
+	 * Update the repository format so that clients will use the new ref
+	 * store.
 	 */
 	initialize_repository_version(hash_algo_by_ptr(repo->hash_algo), format, 1);
 
 	/*
-	 * Unset the old ref store and release it. `get_main_ref_store()` will
-	 * make sure to lazily re-initialize the repository's ref store with
-	 * the new format.
+	 * Reinitialize all worktree ref stores with the new format. We release
+	 * the old ones and clear cached pointers so they get lazily
+	 * reinitialized with the new format.
 	 */
-	ref_store_release(old_refs);
-	FREE_AND_NULL(old_refs);
-	repo->refs_private = NULL;
+	for (size_t i = 0; i < nr_worktrees; i++) {
+		if (wt_migrations[i].is_main) {
+			/* Main worktree: clear the cached main ref store */
+			if (repo->refs_private) {
+				ref_store_release(repo->refs_private);
+				FREE_AND_NULL(repo->refs_private);
+			}
+		}
+		/* Worktree ref stores will be lazily reinitialized on next access */
+	}
+
+	/* Delete backup directories since migration succeeded */
+	for (size_t i = 0; i < nr_worktrees; i++) {
+		if (wt_migrations[i].backup_dir.len)
+			delete_backup(wt_migrations[i].backup_dir.buf);
+	}
 
 	ret = 0;
 
 done:
-	if (ret && did_migrate_refs) {
-		strbuf_complete(errbuf, '\n');
-		strbuf_addf(errbuf, _("migrated refs can be found at '%s'"),
-			    new_gitdir.buf);
-	}
+	if (ret) {
+		/*
+		 * Migration failed. Attempt to restore from backups if we made
+		 * it to Phase 2.
+		 */
+		for (size_t i = 0; wt_migrations && i < nr_worktrees; i++) {
+			if (wt_migrations[i].backup_dir.len) {
+				restore_ref_storage_from_backup(
+					wt_migrations[i].old_refs->gitdir,
+					wt_migrations[i].backup_dir.buf,
+					wt_migrations[i].is_main);
+				delete_backup(wt_migrations[i].backup_dir.buf);
+			}
+		}
 
-	if (new_refs) {
-		ref_store_release(new_refs);
-		free(new_refs);
+		/*
+		 * Report where migrated refs can be found for manual recovery.
+		 * We keep these directories as insurance - if the restore failed,
+		 * they may be the only way to recover the migrated refs.
+		 */
+		for (size_t i = 0; wt_migrations && i < nr_worktrees; i++) {
+			if (wt_migrations[i].new_dir.len) {
+				strbuf_complete(errbuf, '\n');
+				strbuf_addf(errbuf, _("migrated refs for worktree '%s' can be found at '%s'"),
+					    worktrees[i]->path, wt_migrations[i].new_dir.buf);
+			}
+		}
 	}
-	ref_transaction_free(transaction);
-	strbuf_release(&new_gitdir);
-	strbuf_release(&data.sb);
-	strbuf_release(&data.name);
-	strbuf_release(&data.mail);
+
+	if (wt_migrations)
+		worktree_migration_data_array_release(wt_migrations, nr_worktrees);
+	if (worktrees)
+		free_worktrees(worktrees);
+
 	return ret;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8d7007f4aa..6be56274d3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3210,11 +3210,13 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		string_list_append(&refnames_to_check, update->refname);
 
 		/*
-		 * packed-refs don't support symbolic refs, root refs and reflogs,
-		 * so we have to queue these references via the loose transaction.
+		 * packed-refs don't support symbolic refs, root refs, per-worktree
+		 * refs, and reflogs, so we have to queue these references via the
+		 * loose transaction.
 		 */
 		if (update->new_target ||
 		    is_root_ref(update->refname) ||
+		    is_per_worktree_ref(update->refname) ||
 		    (update->flags & REF_LOG_ONLY)) {
 			if (!loose_transaction) {
 				loose_transaction = ref_store_transaction_begin(&refs->base, 0, err);
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 0e1116a319..2ea8d31361 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -114,16 +114,40 @@ do
 			test_cmp expect err
 		'
 
-		test_expect_success "$from_format -> $to_format: migration with worktree fails" '
+		test_expect_success "$from_format -> $to_format: migration with worktree" '
 			test_when_finished "rm -rf repo" &&
 			git init --ref-format=$from_format repo &&
+			test_commit -C repo initial &&
 			git -C repo worktree add wt &&
-			test_must_fail git -C repo refs migrate \
-				--ref-format=$to_format 2>err &&
-			cat >expect <<-EOF &&
-			error: migrating repositories with worktrees is not supported yet
-			EOF
-			test_cmp expect err
+
+			# Create some refs and reflogs in both worktrees
+			test_commit -C repo second &&
+			git -C repo update-ref refs/heads/from-main HEAD &&
+			git -C repo/wt checkout -b wt-branch &&
+			test_commit -C repo/wt wt-commit &&
+			git -C repo/wt update-ref refs/bisect/wt-ref HEAD &&
+
+			# Capture refs from both worktrees before migration
+			git -C repo for-each-ref --include-root-refs \
+				--format="%(refname) %(objectname) %(symref)" >expect-main &&
+			git -C repo/wt for-each-ref --include-root-refs \
+				--format="%(refname) %(objectname) %(symref)" >expect-wt &&
+
+			# Perform migration
+			git -C repo refs migrate --ref-format=$to_format &&
+
+			# Verify refs in both worktrees after migration
+			git -C repo for-each-ref --include-root-refs \
+				--format="%(refname) %(objectname) %(symref)" >actual-main &&
+			git -C repo/wt for-each-ref --include-root-refs \
+				--format="%(refname) %(objectname) %(symref)" >actual-wt &&
+			test_cmp expect-main actual-main &&
+			test_cmp expect-wt actual-wt &&
+
+			# Verify repository format changed
+			git -C repo rev-parse --show-ref-format >actual &&
+			echo "$to_format" >expect &&
+			test_cmp expect actual
 		'
 
 		test_expect_success "$from_format -> $to_format: unborn HEAD" '
@@ -325,4 +349,412 @@ test_expect_success 'migrating from reftable format deletes backend files' '
 	test_path_is_file repo/.git/packed-refs
 '
 
+test_expect_success 'files -> reftable: migration with multiple worktrees' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	test_commit -C repo initial &&
+	git -C repo worktree add wt1 &&
+	git -C repo worktree add wt2 &&
+
+	# Create unique refs in each worktree
+	test_commit -C repo main-commit &&
+	test_commit -C repo/wt1 wt1-commit &&
+	test_commit -C repo/wt2 wt2-commit &&
+	git -C repo update-ref refs/bisect/main-bisect HEAD &&
+	git -C repo/wt1 update-ref refs/bisect/wt1-bisect HEAD &&
+	git -C repo/wt2 update-ref refs/bisect/wt2-bisect HEAD &&
+
+	# Capture state before migration
+	git -C repo for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >expect-main &&
+	git -C repo/wt1 for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >expect-wt1 &&
+	git -C repo/wt2 for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >expect-wt2 &&
+
+	# Migrate
+	git -C repo refs migrate --ref-format=reftable &&
+
+	# Verify all worktrees still work
+	git -C repo for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >actual-main &&
+	git -C repo/wt1 for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >actual-wt1 &&
+	git -C repo/wt2 for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >actual-wt2 &&
+	test_cmp expect-main actual-main &&
+	test_cmp expect-wt1 actual-wt1 &&
+	test_cmp expect-wt2 actual-wt2 &&
+
+	# Verify format changed
+	git -C repo rev-parse --show-ref-format >actual &&
+	echo "reftable" >expect &&
+	test_cmp expect actual &&
+
+	# Verify operations still work in all worktrees
+	test_commit -C repo post-migrate-main &&
+	test_commit -C repo/wt1 post-migrate-wt1 &&
+	test_commit -C repo/wt2 post-migrate-wt2
+'
+
+test_expect_success 'files -> reftable: dry-run with worktrees' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	test_commit -C repo initial &&
+	git -C repo worktree add wt &&
+
+	git -C repo refs migrate --ref-format=reftable --dry-run >output &&
+	grep "Finished dry-run migration" output &&
+	grep "2 worktree" output &&
+
+	# Format should not have changed
+	git -C repo rev-parse --show-ref-format >actual &&
+	echo "files" >expect &&
+	test_cmp expect actual &&
+
+	# Files backend should still be present
+	test_path_is_file repo/.git/refs/heads/main
+'
+
+test_expect_success 'reftable -> files: migration with worktrees and per-worktree refs' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=reftable repo &&
+	test_commit -C repo initial &&
+	git -C repo worktree add wt &&
+
+	# Create various types of per-worktree refs
+	test_commit -C repo main-work &&
+	git -C repo update-ref refs/bisect/bad HEAD &&
+	git -C repo update-ref refs/rewritten/main HEAD &&
+	git -C repo update-ref refs/worktree/custom HEAD &&
+
+	test_commit -C repo/wt wt-work &&
+	git -C repo/wt update-ref refs/bisect/good HEAD &&
+	git -C repo/wt update-ref refs/rewritten/wt HEAD &&
+	git -C repo/wt update-ref refs/worktree/wt-custom HEAD &&
+
+	# Capture all refs including per-worktree ones
+	git -C repo for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >expect-main &&
+	git -C repo/wt for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >expect-wt &&
+
+	# Migrate back to files
+	git -C repo refs migrate --ref-format=files &&
+
+	# Verify per-worktree refs are still separate
+	git -C repo for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >actual-main &&
+	git -C repo/wt for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >actual-wt &&
+	test_cmp expect-main actual-main &&
+	test_cmp expect-wt actual-wt &&
+
+	# Verify physical separation of per-worktree refs
+	test_path_is_file repo/.git/refs/bisect/bad &&
+	test_path_is_file repo/.git/worktrees/wt/refs/bisect/good &&
+	test_path_is_missing repo/.git/refs/bisect/good &&
+	test_path_is_missing repo/.git/worktrees/wt/refs/bisect/bad
+'
+
+test_expect_success 'bare repository with worktrees: bidirectional migration' '
+	test_when_finished "rm -rf bare-repo worktrees" &&
+
+	# Create a bare repository
+	git init --bare --ref-format=files bare-repo &&
+
+	# Add worktrees to the bare repository
+	mkdir worktrees &&
+	git -C bare-repo worktree add ../worktrees/main &&
+	git -C bare-repo worktree add ../worktrees/feature &&
+
+	# Create initial commits and refs in main worktree
+	test_commit -C worktrees/main initial &&
+	git -C worktrees/main update-ref refs/heads/main HEAD &&
+	git -C worktrees/main update-ref refs/bisect/main-bad HEAD &&
+	git -C worktrees/main update-ref refs/worktree/main-custom HEAD &&
+
+	# Create commits and refs in feature worktree
+	test_commit -C worktrees/feature feature-work &&
+	git -C worktrees/feature update-ref refs/bisect/feature-bad HEAD &&
+	git -C worktrees/feature update-ref refs/worktree/feature-custom HEAD &&
+
+	# Capture all refs before migration
+	git -C worktrees/main for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >expect-main &&
+	git -C worktrees/feature for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >expect-feature &&
+
+	# Migrate bare repo to reftable
+	git -C bare-repo refs migrate --ref-format=reftable &&
+
+	# Verify format changed
+	git -C bare-repo rev-parse --show-ref-format >actual &&
+	echo "reftable" >expect-format &&
+	test_cmp expect-format actual &&
+
+	# Verify all refs still exist and are correct
+	git -C worktrees/main for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >actual-main &&
+	git -C worktrees/feature for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >actual-feature &&
+	test_cmp expect-main actual-main &&
+	test_cmp expect-feature actual-feature &&
+
+	# Migrate back to files
+	git -C bare-repo refs migrate --ref-format=files &&
+
+	# Verify format changed back
+	git -C bare-repo rev-parse --show-ref-format >actual &&
+	echo "files" >expect-format &&
+	test_cmp expect-format actual &&
+
+	# Verify all refs still exist and are correct after round-trip
+	git -C worktrees/main for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >actual-main &&
+	git -C worktrees/feature for-each-ref --include-root-refs \
+		--format="%(refname) %(objectname)" | sort >actual-feature &&
+	test_cmp expect-main actual-main &&
+	test_cmp expect-feature actual-feature &&
+
+	# Verify physical separation of per-worktree refs
+	test_path_is_file bare-repo/worktrees/main/refs/bisect/main-bad &&
+	test_path_is_file bare-repo/worktrees/feature/refs/bisect/feature-bad &&
+	test_path_is_missing bare-repo/worktrees/main/refs/bisect/feature-bad &&
+	test_path_is_missing bare-repo/worktrees/feature/refs/bisect/main-bad
+'
+
+test_expect_success SANITY 'files -> reftable: migration fails with read-only .git' '
+	test_when_finished "chmod -R u+w read-only-git" &&
+	git init --ref-format=files read-only-git &&
+	test_commit -C read-only-git initial &&
+	chmod -R a-w read-only-git/.git &&
+	test_must_fail git -C read-only-git refs migrate --ref-format=reftable 2>err &&
+	grep -i "permission denied\|read-only" err
+'
+
+test_expect_success SANITY 'files -> reftable: read-only refs directory prevents backup' '
+	test_when_finished "chmod -R u+w read-only-refs" &&
+	git init --ref-format=files read-only-refs &&
+	test_commit -C read-only-refs initial &&
+	chmod a-w read-only-refs/.git/refs &&
+	test_must_fail git -C read-only-refs refs migrate --ref-format=reftable 2>err &&
+	chmod u+w read-only-refs/.git/refs &&
+	grep -i "could not\|permission denied" err
+'
+
+test_expect_success 'files -> reftable: git status works in all worktrees after migration' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	test_commit -C repo initial &&
+	git -C repo worktree add wt1 &&
+	git -C repo worktree add wt2 &&
+
+	# Make some commits in each worktree
+	test_commit -C repo main-work &&
+	test_commit -C repo/wt1 wt1-work &&
+	test_commit -C repo/wt2 wt2-work &&
+
+	# Verify status works before migration using -C
+	git -C repo status &&
+	git -C repo/wt1 status &&
+	git -C repo/wt2 status &&
+
+	# Verify status works before migration by cd-ing into worktree
+	(cd repo && git status) &&
+	(cd repo/wt1 && git status) &&
+	(cd repo/wt2 && git status) &&
+
+	# Migrate to reftable
+	git -C repo refs migrate --ref-format=reftable &&
+
+	# Verify status still works after migration using -C
+	git -C repo status &&
+	git -C repo/wt1 status &&
+	git -C repo/wt2 status &&
+
+	# Verify status works after migration by cd-ing into worktree
+	(cd repo && git status) &&
+	(cd repo/wt1 && git status) &&
+	(cd repo/wt2 && git status) &&
+
+	# Verify other common commands work in all worktrees
+	git -C repo log --oneline &&
+	git -C repo/wt1 log --oneline &&
+	git -C repo/wt2 log --oneline &&
+
+	git -C repo branch &&
+	git -C repo/wt1 branch &&
+	git -C repo/wt2 branch &&
+
+	# Migrate back to files
+	git -C repo refs migrate --ref-format=files &&
+
+	# Verify status still works after migrating back
+	git -C repo status &&
+	git -C repo/wt1 status &&
+	git -C repo/wt2 status &&
+
+	(cd repo && git status) &&
+	(cd repo/wt1 && git status) &&
+	(cd repo/wt2 && git status)
+'
+
+test_expect_success 'files -> reftable: migration fails from inside linked worktree' '
+	test_when_finished "rm -rf from-wt-bare.git from-wt-trees" &&
+
+	# Create a bare repo with worktrees
+	git init --bare --ref-format=files from-wt-bare.git &&
+
+	# Add two worktrees
+	mkdir from-wt-trees &&
+	git -C from-wt-bare.git worktree add ../from-wt-trees/wt1 &&
+	git -C from-wt-bare.git worktree add ../from-wt-trees/wt2 &&
+
+	# Create commits in first worktree
+	test_commit -C from-wt-trees/wt1 initial &&
+	test_commit -C from-wt-trees/wt1 second &&
+
+	# Migration from inside a linked worktree should fail with helpful error
+	(
+		cd from-wt-trees/wt1 &&
+		test_must_fail git refs migrate --ref-format=reftable 2>err
+	) &&
+	grep "migration must be run from the main worktree" from-wt-trees/wt1/err &&
+
+	# Verify repository is not corrupted - refs format should still be files
+	git -C from-wt-bare.git rev-parse --show-ref-format >actual-format &&
+	echo "files" >expect-format &&
+	test_cmp expect-format actual-format &&
+
+	# Verify git status still works in the worktree
+	git -C from-wt-trees/wt1 status &&
+	(cd from-wt-trees/wt1 && git status) &&
+
+	# Verify migration succeeds when run from the main repository
+	git -C from-wt-bare.git refs migrate --ref-format=reftable &&
+
+	# Verify migration actually happened
+	git -C from-wt-bare.git rev-parse --show-ref-format >actual-format-after &&
+	echo "reftable" >expect-format-after &&
+	test_cmp expect-format-after actual-format-after &&
+
+	# Verify worktree still works after successful migration
+	git -C from-wt-trees/wt1 status &&
+	(cd from-wt-trees/wt1 && git status)
+'
+
+test_expect_success 'files -> reftable: migration with uncommitted changes in worktrees' '
+	test_when_finished "rm -rf dirty-wt-repo dirty-wt" &&
+
+	# Create repo with initial commit
+	git init --ref-format=files dirty-wt-repo &&
+	test_commit -C dirty-wt-repo initial &&
+
+	# Create worktree and make a commit there so it has tracked files
+	git -C dirty-wt-repo worktree add ../dirty-wt &&
+	test_commit -C dirty-wt base &&
+
+	# Create uncommitted changes in worktree:
+	# 1. Untracked file
+	echo "untracked content" >dirty-wt/untracked.txt &&
+
+	# 2. Modified tracked file (not staged)
+	echo "modified" >>dirty-wt/base.t &&
+
+	# 3. Staged new file
+	echo "staged new content" >dirty-wt/staged-new.txt &&
+	git -C dirty-wt add staged-new.txt &&
+
+	# 4. Staged modification to tracked file
+	echo "staged modification" >>dirty-wt/initial.t &&
+	git -C dirty-wt add initial.t &&
+
+	# 5. File with both staged AND unstaged changes
+	echo "staged change" >dirty-wt/both.txt &&
+	git -C dirty-wt add both.txt &&
+	echo "unstaged change" >>dirty-wt/both.txt &&
+
+	# Record status before migration
+	git -C dirty-wt status --porcelain >status-before &&
+
+	# Verify status works before migration
+	git -C dirty-wt status &&
+	(cd dirty-wt && git status) &&
+
+	# Migrate from main worktree
+	git -C dirty-wt-repo refs migrate --ref-format=reftable &&
+
+	# Verify migration succeeded
+	git -C dirty-wt-repo rev-parse --show-ref-format >actual &&
+	echo "reftable" >expect &&
+	test_cmp expect actual &&
+
+	# Verify status still works after migration
+	git -C dirty-wt status &&
+	(cd dirty-wt && git status) &&
+
+	# Verify all uncommitted changes are preserved exactly
+	git -C dirty-wt status --porcelain >status-after &&
+	test_cmp status-before status-after &&
+
+	# Verify file contents are preserved
+	test "$(cat dirty-wt/untracked.txt)" = "untracked content" &&
+	grep "modified" dirty-wt/base.t &&
+	test "$(cat dirty-wt/staged-new.txt)" = "staged new content" &&
+	grep "staged modification" dirty-wt/initial.t &&
+	test "$(cat dirty-wt/both.txt)" = "staged change
+unstaged change" &&
+
+	# Verify all 5 types of changes are still present in status
+	test_line_count = 5 status-after
+'
+
+test_expect_success 'files -> reftable: migration with prunable worktree' '
+	test_when_finished "rm -rf prunable-repo" &&
+
+	# Create repo with worktree, then delete the worktree directory
+	git init --ref-format=files prunable-repo &&
+	test_commit -C prunable-repo initial &&
+	git -C prunable-repo worktree add ../prunable-wt &&
+	rm -rf ../prunable-wt &&
+
+	# Migration should still succeed
+	git -C prunable-repo refs migrate --ref-format=reftable &&
+
+	# Verify migration succeeded
+	git -C prunable-repo rev-parse --show-ref-format >actual &&
+	echo "reftable" >expect &&
+	test_cmp expect actual &&
+
+	# Verify worktree is marked as prunable but metadata exists
+	git -C prunable-repo worktree list --porcelain >list &&
+	grep "prunable" list
+'
+
+test_expect_success 'files -> reftable: migration works from main worktree .git directory' '
+	test_when_finished "rm -rf from-gitdir-repo" &&
+
+	git init --ref-format=files from-gitdir-repo &&
+	test_commit -C from-gitdir-repo initial &&
+
+	# Verify status works before migration
+	(cd from-gitdir-repo && git status) &&
+
+	# Run migration from inside .git directory
+	(
+		cd from-gitdir-repo/.git &&
+		git refs migrate --ref-format=reftable
+	) &&
+
+	# Verify migration succeeded
+	git -C from-gitdir-repo rev-parse --show-ref-format >actual &&
+	echo "reftable" >expect &&
+	test_cmp expect actual &&
+
+	# Verify repo still works
+	git -C from-gitdir-repo status &&
+	(cd from-gitdir-repo && git status)
+'
+
 test_done

base-commit: 419c72cb8ada252b260efc38ff91fe201de7c8c3
-- 
gitgitgadget
