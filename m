Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5DB544898
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922940; cv=none; b=u2cD37M1i+yENKqOtZfR2/93RKQzgkTti/hSbtEw2aN83JjusBhiV4b7cIkQPTqNAoulnIaUpXF6vyR+Au7SRYPeHa8FHvGu6rPhtA4UampoH7/ClYh3uJ8r6bkMlZkJArpqEsqCvesoe0tMem30qhQ1j7BgjulXxIDF0IEWG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922940; c=relaxed/simple;
	bh=4YTdK8wUfnAPIFu6lWwiFa25NNMsANoLUFh/oXpgzj0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uWG2HKAzRU/ErXtzMGPHWeo6j6R2vZHImm6wZojLUb4qSQFKMhHmYADqJIUuON8wEjhaj4KFdc+6oGidVtc6ZDYLDS/b+8/VSvgnfurkl33qIT6qiXKLOuPQiXbStHEhcnH5v1cbdNQ18S3LMx2DmNNomMLaxFfUxDRNjm/NQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fV3Hcglc; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fV3Hcglc"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4f55a53898cso1775566b6e.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922936; x=1792527736; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gKyymBSd15HHkXpb59Ymm9smj7ODwzIn/fM29CUwpFk=;
        b=fV3HcglcZjyHegvH/mLiqiiL/KU7UbfsiRrqXvwysgXryxuFxuwJ1bXBlKkoeMikAo
         9Y0H75nonogu6lLvCOlgSWRhoKw1NIl6cSzsQHIJdaRgYGHPljvTlk2BwZmG++7ce00t
         xbu6iMbHtayfPTjin/uyAO/d5XRN8v9Xm9f7moUm+gMbLp46/fmFNXzMaWMgo9K9Ljb4
         R4fFJYfI2F+ajYUCeHFUIOslWeOrDjZ9ovd0oGRpwEuHQtBtHoVB7awjJhb/8QdIPrNI
         9FftVScGw6l+/nfhmBw1VXTf3Yqvajt7aEGjzNdFJJN0CUW/tN3+ShPsmAGJAkSirLz9
         jjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922936; x=1792527736;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKyymBSd15HHkXpb59Ymm9smj7ODwzIn/fM29CUwpFk=;
        b=ryeNqTPV5YicZdXV6kNFvUO4+DKMNE58LjefbsEsioQ0Qlwu1BzvByJrorLigWXCj6
         mHzxioTCSEdRVc632KVdFtyoa0gqfbqrtoNyVPKwfunupKfG68sAPDCykCZ0E/ztCOub
         QsP0QETOIaZpQBMKaFZDnARJ6RYvH7Gm6XeZCKg9GWY+j5C2168uUS3OD8g/73o8pI14
         4NW1PwB0uiAJSP8W2PRlQNbTDrsxM4TJOLw/xWRysKGc/IGBrbK4Jb5nsVjQkgbK3OJ6
         PY/cwlhdxxAJnoM7t6Lbt8t8iCvR7LR4UUNehI2sczoh4YqeMQIes+mbi2RQUZRQHptz
         jZSg==
X-Gm-Message-State: AFq9FYI16EJkJ4WKGIrbrHiKuL3UztInkZc4cLiQvIcn23e49Q3RVAYh
	9n672SLsfNjvMLEoMQAYIgzPf2ln1a5IFP/NWnrpIHF4zwMAhhhY+Tj5tQqeIQ==
X-Gm-Gg: AYBFou0WzPUThu4At8BtRl1n1UwT3rYLwCPimcLro4v07EzXmDMJpJXMKF8fWLhCp9P
	Ud9hq2PVu+O1sR/ZKbHOovuFT9S6XUh5jaOEzrqbRonju8UajZznUp9/crVEGF1hBX2uQhyCpRa
	CmhsY370r5hdSOkn8c5zyKYFhU1EEOAyl63R0MG6nWbFW2IF5SfYIXTugvkwvr+Co7NI/pgTRKn
	AASai6u39wJkrvpN3Ih5PTt0aRTxBXddca2n9MVcBAnJ3ikS5CPkgxfSvcgVEzBylcqebwwZIUw
	zuTFvg3oUB2XBj6cLMnfsca1ghh8Miym7HDPTe09ojkEx2hrzALKmzfKaJndR1sF1AZcKEOzy2/
	2MN04PS+IJ1/6jFhp6QcLj5qGi9x9P4f5tyTZoKxvtJf1tdnUC1aLH74VTAyq+fbeMWKyj6yjZs
	wpTtNS81hkv+2f+sHMgSA0XPNQtL2uKlLOrd0gLKVFkyCaf73SQ3j3xOG/XqpnPqFoZJol7ISsw
	yl3UmUXdq0j
X-Received: by 2002:a05:6808:1a1b:b0:4e5:a74e:d6c0 with SMTP id 5614622812f47-50c5d06d9fbmr13050337b6e.64.1791922936005;
        Tue, 13 Oct 2026 13:22:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.15.229.147])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c0c5fe916sm15681293b6e.1.2026.10.13.13.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:22:14 -0700 (PDT)
Message-Id: <6039d4bc2d8b22254406b9dec79c7fdb1a4c499c.1791922928.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.v6.git.1791922928.gitgitgadget@gmail.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v6.git.1791922928.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Oct 2026 20:22:08 +0000
Subject: [PATCH v6 2/2] blame: ignore revs in .git-blame-ignore-revs by
 default
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Abhijeetsingh Meena <abhijeet040403@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ravi Mistry <rmistry@google.com>,
    Ravi Mistry <rmistry@google.com>

From: Ravi Mistry <rmistry@google.com>

git-blame(1) can ignore a list of commits specified via
--ignore-revs-file or the blame.ignoreRevsFile configuration variable.
This is useful for skipping uninteresting revisions such as tree-wide
formatting changes, large-scale refactors, and code modernizations that
would otherwise obscure genuine historical authorship.

When revision-ignoring was introduced in commit ae3f36dea1 ("blame: add
blame.ignoreRevsFile config option", 2019-10-18), it intentionally
avoided adopting a default ignore file. At the time, the capability was
new and unproven, so avoiding unrequested filesystem I/O or unexpected
attribution shifts took priority over a project-wide default.
Requiring explicit opt-in per clone was therefore the prudent design.

Since then, maintaining a .git-blame-ignore-revs file at the top level
of the repository has become the standard convention across the Git
ecosystem, adopted by many open source projects (such as Chromium and
LLVM) as well as hosting platforms (GitHub, GitLab, Gerrit). However,
git-blame(1) and git-annotate(1) still ignore this file unless each
user remembers to manually configure blame.ignoreRevsFile in every
local clone.

Teach git-blame(1) and git-annotate(1) to automatically add
.git-blame-ignore-revs, if it exists, as the initial element in the
list of ignore-revs files. Similar to how read_mailmap() handles
.mailmap, consult .git-blame-ignore-revs at the root of the working
tree when a working tree is available, and otherwise consult the
HEAD:.git-blame-ignore-revs blob in bare repositories. Reading only
from the working tree in non-bare repositories makes it ergonomic to
prepare a new .git-blame-ignore-revs file, edit an existing one, or
remove a committed one and immediately test the effect with
git-blame(1) before committing, while consulting
HEAD:.git-blame-ignore-revs in bare repositories allows them to
respect the committed ignore list as well.

To ensure consistent precedence, override semantics, and safety when
reading upstream-controlled content:
- The default .git-blame-ignore-revs entry is added before reading
  configuration and CLI options, preserving user and repository config
  overrides.
- In git_blame_config(), blame.ignoreRevsFile entries are appended via
  string_list_append() rather than inserted in sorted order via
  string_list_insert() so that configuration entries preserve their
  order relative to the initial default entry.
- When a working tree is present, the working-tree
  .git-blame-ignore-revs path is checked with lstat() and S_ISREG(),
  opened with open_nofollow(), and verified with fstat() and S_ISREG()
  so symbolic links and non-regular files are silently skipped. In bare
  repositories, HEAD:.git-blame-ignore-revs is resolved quietly via
  get_oid_with_context() and its tree entry mode is checked with
  S_ISREG() before checking the object.
- In both modes, the file or blob size is capped at
  IGNORE_REVS_MAX_FILE_SIZE (100MB, matching ATTR_MAX_FILE_SIZE from
  3c50032ff5 ("attr: ignore overly large gitattributes files",
  2022-12-01)) before reading its contents, skipping an oversized file
  or blob with a warning without loading it into memory. The contents
  are parsed via a new oidset_parse_buffer_carefully() helper in
  oidset.c that shares line parsing with oidset_parse_file_carefully().
- In build_ignorelist(), ignore-revs entries are processed starting
  after the last empty string entry. This ensures setting
  blame.ignoreRevsFile to "" or passing --ignore-revs-file "" or
  --no-ignore-revs-file cleanly discards the default entry without
  attempting to read or parse it, allowing users to bypass a malformed
  default ignore-revs file.

Update documentation in blame-options.adoc and config/blame.adoc, and
add test coverage in t8013 for the default working-tree lookup,
uncommitted and untracked .git-blame-ignore-revs files, subdirectory
invocations, bare repositories, CLI and config overrides, symbolic
links, overly large files and blobs, and comments and whitespace
handling.

Based-on-patch-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
Helped-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 Documentation/blame-options.adoc |   9 +-
 Documentation/config/blame.adoc  |  10 +-
 builtin/blame.c                  | 102 +++++++++++++-
 oidset.c                         |  84 +++++++----
 oidset.h                         |   9 ++
 t/t8013-blame-ignore-revs.sh     | 233 +++++++++++++++++++++++++++++++
 6 files changed, 411 insertions(+), 36 deletions(-)

diff --git a/Documentation/blame-options.adoc b/Documentation/blame-options.adoc
index 1ae1222b6b..7e910373bd 100644
--- a/Documentation/blame-options.adoc
+++ b/Documentation/blame-options.adoc
@@ -132,9 +132,12 @@ take effect.
 `--ignore-revs-file <file>`::
 	Ignore revisions listed in _<file>_, which must be in the same format as an
 	`fsck.skipList`.  This option may be repeated, and these files will be
-	processed after any files specified with the `blame.ignoreRevsFile` config
-	option.  An empty file name, `""`, will clear the list of revs from
-	previously processed files.
+	processed after the default `.git-blame-ignore-revs` file at the root of
+	the working tree (or `HEAD:.git-blame-ignore-revs` in a bare repository),
+	if it exists, and any files specified with the `blame.ignoreRevsFile`
+	configuration variable.  An empty file name, `""`, or
+	`--no-ignore-revs-file` will clear the list of revs from previously
+	processed files, including the default ignore-revs file.
 
 `--color-lines`::
 	Color line annotations in the default format differently if they come from
diff --git a/Documentation/config/blame.adoc b/Documentation/config/blame.adoc
index 4d047c1790..a46aea8d98 100644
--- a/Documentation/config/blame.adoc
+++ b/Documentation/config/blame.adoc
@@ -23,9 +23,13 @@ blame.showRoot::
 blame.ignoreRevsFile::
 	Ignore revisions listed in the file, one unabbreviated object name per
 	line, in linkgit:git-blame[1].  Whitespace and comments beginning with
-	`#` are ignored.  This option may be repeated multiple times.  Empty
-	file names will reset the list of ignored revisions.  This option will
-	be handled before the command line option `--ignore-revs-file`.
+	`#` are ignored.  If `.git-blame-ignore-revs` exists at the root of the
+	working tree (or `HEAD:.git-blame-ignore-revs` in a bare repository), it
+	is added as the initial element in the list of ignore-revs files.
+	Other files listed in the configuration are also used, but an empty
+	element makes all elements that appeared before in the list forgotten.
+	This option will be handled before the command line option
+	`--ignore-revs-file`.
 
 blame.markUnblamableLines::
 	Mark lines that were changed by an ignored revision that we could not
diff --git a/builtin/blame.c b/builtin/blame.c
index 6741a7b9df..1e753a0b60 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -29,6 +29,7 @@
 #include "object-name.h"
 #include "odb.h"
 #include "pager.h"
+#include "path.h"
 #include "blame.h"
 #include "refs.h"
 #include "setup.h"
@@ -769,7 +770,7 @@ static int git_blame_config(const char *var, const char *value,
 		if (ret)
 			return ret;
 		if (str)
-			string_list_insert(&ignore_revs_file_list, str);
+			string_list_append(&ignore_revs_file_list, str);
 		free(str);
 		return 0;
 	}
@@ -946,17 +947,104 @@ static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
 	}
 }
 
+#define IGNORE_REVS_MAX_FILE_SIZE (100 * 1024 * 1024)
+
+static void parse_default_ignore_revs_blob(struct blame_scoreboard *sb,
+					   const char *path)
+{
+	char *name = xstrfmt("HEAD:%s", path);
+	struct object_context oc;
+	struct object_id oid;
+	enum object_type type;
+	size_t size;
+	char *buf;
+
+	if (get_oid_with_context(sb->repo, name, GET_OID_QUIETLY,
+				 &oid, &oc))
+		goto out;
+	if (!S_ISREG(oc.mode))
+		goto out;
+
+	if (odb_read_object_info(sb->repo->objects, &oid, &size) != OBJ_BLOB)
+		goto out;
+	if (size >= IGNORE_REVS_MAX_FILE_SIZE) {
+		warning(_("ignoring overly large ignore-revs blob '%s'"), name);
+		goto out;
+	}
+
+	buf = odb_read_object(sb->repo->objects, &oid, &type, &size);
+	if (!buf)
+		goto out;
+	if (type == OBJ_BLOB)
+		oidset_parse_buffer_carefully(&sb->ignore_list, buf, size,
+					      sb->repo->hash_algo,
+					      peel_to_commit_oid, sb);
+	free(buf);
+
+out:
+	object_context_release(&oc);
+	free(name);
+}
+
+static void parse_default_ignore_revs_file(struct blame_scoreboard *sb,
+					   const char *name)
+{
+	char *path = repo_worktree_path(sb->repo, "%s", name);
+	struct stat st;
+	int fd = -1;
+	size_t size;
+	char *buf = NULL;
+
+	if (lstat(path, &st) || !S_ISREG(st.st_mode))
+		goto out;
+	fd = open_nofollow(path, O_RDONLY);
+	if (fd < 0 || fstat(fd, &st) || !S_ISREG(st.st_mode))
+		goto out;
+	if (st.st_size >= IGNORE_REVS_MAX_FILE_SIZE) {
+		warning(_("ignoring overly large ignore-revs file '%s'"), name);
+		goto out;
+	}
+	size = xsize_t(st.st_size);
+	buf = xmalloc(size);
+	if (read_in_full(fd, buf, size) == (ssize_t)size)
+		oidset_parse_buffer_carefully(&sb->ignore_list, buf, size,
+					      sb->repo->hash_algo,
+					      peel_to_commit_oid, sb);
+
+out:
+	if (fd >= 0)
+		close(fd);
+	free(buf);
+	free(path);
+}
+
+static void parse_default_ignore_revs(struct blame_scoreboard *sb,
+				      const char *name)
+{
+	if (repo_get_work_tree(sb->repo))
+		parse_default_ignore_revs_file(sb, name);
+	else
+		parse_default_ignore_revs_blob(sb, name);
+}
+
 static void build_ignorelist(struct blame_scoreboard *sb,
 			     struct string_list *ignore_revs_file_list,
 			     struct string_list *ignore_rev_list)
 {
 	struct string_list_item *i;
 	struct object_id oid;
+	size_t start_idx = 0, idx;
+
+	for (idx = 0; idx < ignore_revs_file_list->nr; idx++) {
+		if (!*ignore_revs_file_list->items[idx].string)
+			start_idx = idx + 1;
+	}
 
 	oidset_init(&sb->ignore_list, 0);
-	for_each_string_list_item(i, ignore_revs_file_list) {
-		if (!strcmp(i->string, ""))
-			oidset_clear(&sb->ignore_list);
+	for (idx = start_idx; idx < ignore_revs_file_list->nr; idx++) {
+		i = &ignore_revs_file_list->items[idx];
+		if (i->util)
+			parse_default_ignore_revs(sb, i->string);
 		else
 			oidset_parse_file_carefully(&sb->ignore_list, i->string,
 						    the_repository->hash_algo,
@@ -1036,6 +1124,12 @@ int cmd_blame(int argc,
 	const char *const *opt_usage = cmd_is_annotate ? annotate_opt_usage : blame_opt_usage;
 
 	setup_default_color_by_age();
+	/*
+	 * An entry with a non-NULL .util member names the default
+	 * ignore-revs file at the project root; see build_ignorelist().
+	 */
+	string_list_append(&ignore_revs_file_list,
+			   ".git-blame-ignore-revs")->util = (void *)1;
 	repo_config(the_repository, git_blame_config, &output_option);
 	repo_init_revisions(the_repository, &revs, NULL);
 	revs.date_mode = blame_date_mode;
diff --git a/oidset.c b/oidset.c
index 90d39204d3..8469d03b9b 100644
--- a/oidset.c
+++ b/oidset.c
@@ -70,44 +70,76 @@ void oidset_parse_file(struct oidset *set, const char *path,
 	oidset_parse_file_carefully(set, path, algop, NULL, NULL);
 }
 
+static void parse_oidset_line(struct oidset *set, struct strbuf *sb,
+			      const struct git_hash_algo *algop,
+			      oidset_parse_tweak_fn fn, void *cbdata)
+{
+	const char *p;
+	const char *name;
+	struct object_id oid;
+
+	if (memchr(sb->buf, '\0', sb->len))
+		die("invalid object name: %s", sb->buf);
+
+	/*
+	 * Allow trailing comments, leading whitespace
+	 * (including before commits), and empty or whitespace
+	 * only lines.
+	 */
+	name = strchr(sb->buf, '#');
+	if (name)
+		strbuf_setlen(sb, name - sb->buf);
+	strbuf_trim(sb);
+	if (!sb->len)
+		return;
+
+	if (parse_oid_hex_algop(sb->buf, &oid, &p, algop) || *p != '\0')
+		die("invalid object name: %s", sb->buf);
+	if (fn && fn(&oid, cbdata))
+		return;
+	oidset_insert(set, &oid);
+}
+
 void oidset_parse_file_carefully(struct oidset *set, const char *path,
 				 const struct git_hash_algo *algop,
 				 oidset_parse_tweak_fn fn, void *cbdata)
 {
 	FILE *fp;
 	struct strbuf sb = STRBUF_INIT;
-	struct object_id oid;
 
 	fp = fopen(path, "r");
 	if (!fp)
 		die("could not open object name list: %s", path);
-	while (!strbuf_getline(&sb, fp)) {
-		const char *p;
-		const char *name;
-
-		if (memchr(sb.buf, '\0', sb.len))
-			die("invalid object name: %s", sb.buf);
-
-		/*
-		 * Allow trailing comments, leading whitespace
-		 * (including before commits), and empty or whitespace
-		 * only lines.
-		 */
-		name = strchr(sb.buf, '#');
-		if (name)
-			strbuf_setlen(&sb, name - sb.buf);
-		strbuf_trim(&sb);
-		if (!sb.len)
-			continue;
-
-		if (parse_oid_hex_algop(sb.buf, &oid, &p, algop) || *p != '\0')
-			die("invalid object name: %s", sb.buf);
-		if (fn && fn(&oid, cbdata))
-			continue;
-		oidset_insert(set, &oid);
-	}
+	while (!strbuf_getline(&sb, fp))
+		parse_oidset_line(set, &sb, algop, fn, cbdata);
 	if (ferror(fp))
 		die_errno("Could not read '%s'", path);
 	fclose(fp);
 	strbuf_release(&sb);
 }
+
+void oidset_parse_buffer_carefully(struct oidset *set, const char *buf,
+				   size_t size,
+				   const struct git_hash_algo *algop,
+				   oidset_parse_tweak_fn fn, void *cbdata)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *p = buf, *end;
+
+	if (!size)
+		return;
+	end = buf + size;
+
+	while (p < end) {
+		const char *nl = memchr(p, '\n', end - p);
+		size_t len = (nl ? nl : end) - p;
+
+		strbuf_reset(&sb);
+		if (len && p[len - 1] == '\r')
+			len--;
+		strbuf_add(&sb, p, len);
+		parse_oidset_line(set, &sb, algop, fn, cbdata);
+		p = nl ? nl + 1 : end;
+	}
+	strbuf_release(&sb);
+}
diff --git a/oidset.h b/oidset.h
index e0f1a6ff4f..667c390842 100644
--- a/oidset.h
+++ b/oidset.h
@@ -98,6 +98,15 @@ void oidset_parse_file_carefully(struct oidset *set, const char *path,
 				 const struct git_hash_algo *algop,
 				 oidset_parse_tweak_fn fn, void *cbdata);
 
+/*
+ * Similar to oidset_parse_file_carefully(), but parses lines from an
+ * in-memory buffer of 'size' bytes.
+ */
+void oidset_parse_buffer_carefully(struct oidset *set, const char *buf,
+				   size_t size,
+				   const struct git_hash_algo *algop,
+				   oidset_parse_tweak_fn fn, void *cbdata);
+
 struct oidset_iter {
 	const kh_oid_set_t *set;
 	khiter_t iter;
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index 70fe509a64..92d8296c7b 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -365,4 +365,237 @@ test_expect_success 'ignore-revs-file peels chained tags and skips missing tag t
 	test_cmp expect actual
 '
 
+# Tests for default .git-blame-ignore-revs
+test_expect_success 'setup default .git-blame-ignore-revs' '
+	git checkout -b default-file-branch &&
+	test_write_lines line1 line2 >def-file &&
+	git add def-file &&
+	test_tick &&
+	git commit -m "default base" &&
+	git tag DEF_A &&
+
+	test_write_lines line1-modified line2-modified >def-file &&
+	git add def-file &&
+	test_tick &&
+	git commit -m "default mod" &&
+	git tag DEF_B &&
+
+	git rev-parse DEF_B >.git-blame-ignore-revs &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual &&
+
+	git add .git-blame-ignore-revs &&
+	test_tick &&
+	git commit -m "add .git-blame-ignore-revs"
+'
+
+test_expect_success 'default .git-blame-ignore-revs is used by default' '
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default .git-blame-ignore-revs respected by git annotate' '
+	git rev-parse --short DEF_A >expect_sha &&
+	git annotate def-file >actual &&
+	test_grep "^$(cat expect_sha)" actual
+'
+
+test_expect_success 'default .git-blame-ignore-revs works from subdirectory' '
+	test_when_finished "rm -rf sub" &&
+	mkdir -p sub &&
+	echo "invalid-oid-value" >sub/.git-blame-ignore-revs &&
+	(
+		cd sub &&
+		git blame --line-porcelain ../def-file >blame_raw &&
+		sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+		git rev-parse DEF_A >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'default HEAD:.git-blame-ignore-revs respected in bare repo' '
+	test_when_finished "rm -rf bare.git" &&
+	git clone --bare . bare.git &&
+	git -C bare.git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual &&
+
+	git -C .git blame --line-porcelain HEAD -- def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'uncommitted .git-blame-ignore-revs changes in working tree are respected' '
+	test_when_finished "git checkout -- .git-blame-ignore-revs" &&
+	: >.git-blame-ignore-revs &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual &&
+
+	rm .git-blame-ignore-revs &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual &&
+
+	echo "invalid-oid-value" >.git-blame-ignore-revs &&
+	test_must_fail git blame def-file
+'
+
+test_expect_success 'disable default .git-blame-ignore-revs with --no-ignore-revs-file' '
+	git blame --line-porcelain --no-ignore-revs-file def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'disable default .git-blame-ignore-revs with --ignore-revs-file ""' '
+	git blame --line-porcelain --ignore-revs-file "" def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'disable default .git-blame-ignore-revs with blame.ignoreRevsFile=""' '
+	test_config blame.ignoreRevsFile "" &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default .git-blame-ignore-revs handles comments and whitespace' '
+	rev_def_b=$(git rev-parse DEF_B) &&
+	{
+		echo "# Leading comment" &&
+		echo "" &&
+		echo "   $rev_def_b   # inline comment" &&
+		echo "# Trailing comment"
+	} >.git-blame-ignore-revs &&
+	git add .git-blame-ignore-revs &&
+	test_tick &&
+	git commit -m "comments and whitespace in .git-blame-ignore-revs" &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'empty default .git-blame-ignore-revs is harmless' '
+	: >.git-blame-ignore-revs &&
+	git add .git-blame-ignore-revs &&
+	test_tick &&
+	git commit -m "empty .git-blame-ignore-revs" &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success SYMLINKS 'symlink .git-blame-ignore-revs in working tree is ignored' '
+	test_when_finished "git checkout -- .git-blame-ignore-revs && rm -f target_file" &&
+	git rev-parse DEF_B >target_file &&
+	rm -f .git-blame-ignore-revs &&
+	ln -s target_file .git-blame-ignore-revs &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'committed symlink .git-blame-ignore-revs in bare repo HEAD is ignored' '
+	test_when_finished "git reset --hard HEAD~ && rm -rf bare-symlink.git" &&
+	blob=$(printf "%s" "target_file" | git hash-object -w --stdin) &&
+	git update-index --replace --cacheinfo 120000,$blob,.git-blame-ignore-revs &&
+	test_tick &&
+	git commit -m "symlink .git-blame-ignore-revs" &&
+	git clone --bare . bare-symlink.git &&
+	git -C bare-symlink.git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'malformed default .git-blame-ignore-revs fails but can be bypassed' '
+	git rm -f .git-blame-ignore-revs &&
+	echo "invalid-oid-value" >.git-blame-ignore-revs &&
+	git add .git-blame-ignore-revs &&
+	test_tick &&
+	git commit -m "malformed .git-blame-ignore-revs" &&
+	test_must_fail git blame def-file &&
+	git blame --no-ignore-revs-file def-file &&
+	git blame --ignore-revs-file "" def-file &&
+	git -c blame.ignoreRevsFile="" blame def-file &&
+
+	rev_def_b=$(git rev-parse DEF_B) &&
+	printf "%sQgarbage\n" "$rev_def_b" | q_to_nul >.git-blame-ignore-revs &&
+	git add .git-blame-ignore-revs &&
+	test_tick &&
+	git commit -m "NUL in .git-blame-ignore-revs" &&
+	test_must_fail git blame def-file 2>err &&
+	test_grep "invalid object name:" err
+'
+
+test_expect_success 'default .git-blame-ignore-revs combined with config blame.ignoreRevsFile' '
+	git rev-parse DEF_B >.git-blame-ignore-revs &&
+	test_write_lines line1-modified line2-c >def-file &&
+	git add .git-blame-ignore-revs def-file &&
+	test_tick &&
+	git commit -m C &&
+	git tag DEF_C &&
+	git rev-parse DEF_C >custom_ignore &&
+	test_config blame.ignoreRevsFile custom_ignore &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'blame works when .git-blame-ignore-revs does not exist' '
+	git rm -f .git-blame-ignore-revs &&
+	test_tick &&
+	git commit -m "remove .git-blame-ignore-revs" &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success EXPENSIVE 'overly large default .git-blame-ignore-revs is ignored' '
+	test_when_finished "rm -f .git-blame-ignore-revs" &&
+	dd if=/dev/zero of=.git-blame-ignore-revs bs=1048576 count=101 2>/dev/null &&
+	git blame --line-porcelain def-file >blame_raw 2>err &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual &&
+	test_grep "warning: ignoring overly large ignore-revs file '\''.git-blame-ignore-revs'\''" err &&
+
+	blob=$(git hash-object -w .git-blame-ignore-revs) &&
+	rm -f .git-blame-ignore-revs &&
+	git update-index --add --cacheinfo 100644,$blob,.git-blame-ignore-revs &&
+	test_tick &&
+	git commit -m "overly large .git-blame-ignore-revs" &&
+	test_when_finished "git reset --hard HEAD~" &&
+	git -C .git blame --line-porcelain HEAD -- def-file >blame_raw 2>err &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual &&
+	test_grep "warning: ignoring overly large ignore-revs blob '\''HEAD:.git-blame-ignore-revs'\''" err
+'
+
 test_done
-- 
gitgitgadget
