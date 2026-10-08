Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9A43231F
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493655; cv=none; b=abt3x9ShOPRQk5D+5qaFsDR2ENBZ42FjN4SqM4IORWtLas+wHJjaAUaBL6s8uYX6PFgHl/oA833awgPColoC1rD05OOY5DgSWK97BdxiqxnXeVOB04WYw+qGmV2KlTtvCwtdU87KRRxMND+G2LrcckHsByJJJW35wgxn25lyqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493655; c=relaxed/simple;
	bh=WHQgWnbp9tGPCQVmNMljX7YNeXJ+aqsq6rc7yHuTVe0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=teQBn2l4xQFQ3oNIGvdP8seG6c2QbLEFVMm5kwGxiXuud9qhuCBMdBxd8wZ/SuyKdWAi/4ytZOcFIVMTdAKX893qOvlutC1ltcwU9NkeYkHkkBxsnIxbMC1Htj1FSdCi7DNNEKMBjc2intD9AjPuP40Ucz1WMPvbYrmMrRBkpvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exm88J0j; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exm88J0j"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8249ca723bcso2161881a34.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791493652; x=1792098452; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uKrBSC5gODoWCZgQiYfqIQQJR5vvy1S3G/dMwGHrBVw=;
        b=exm88J0jDK5mgIMMwl6ts2P1WvG7FPRdGbJNE89cRK3LCGg7sOoo6aTaM6GsXoztfl
         VEAPgCe8lzqNGMTUJPV5g/BvSekAq68pWNrwGw37GezDr4g4twm5CYvbqF1uoEw7U402
         kjgidu3RqAR5QhLMPhaJ4pFEbVRQLxAsnQvI8dKsHl2RtLL69/bB7HhlvYnzddnBAeqY
         8ACnoCUmDtruBKNlsBqv8UHt+lwNCN1gvP5CoZkgIgvKLcQhAZPM2rrP1/qsqSYJkvtD
         e9PeMWf73uZ1jCREJAJx9Ewt5YkUkIl4MrDQweFtvckW2xUWEPkDG7LTMsBmPLEO3ocK
         +LtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493652; x=1792098452;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKrBSC5gODoWCZgQiYfqIQQJR5vvy1S3G/dMwGHrBVw=;
        b=ndtOGbEwpymIuf3sWYagXuLnXg2QfolHIZ8GLXsE93k97pdO/flnjGHLcRBAfLdnfq
         9YlejCKfwlf0/DmHqHt4KVaCjRNfCFTR3rlHBDeW4pbLCQKb/KlWK0dgQPBvYH5gwfaY
         IgNZPAHlJFY0KsoK8iN+OhJ0u1sfwxtSSHWuTIF2eKi4Ir+ed2Aoc6xfoYttLUBq2vvn
         lk7V/TYkJ7Z1SnOen4fTNt20HMzhHR+CQLBp1l9ROsxtvbKGHH5NxEY25lvWavTdqlHk
         PYRZZ3duVdjnmHo4QuVXBDEEp+uxRVIsiUkkOMVYXgH/+RZ7UOBs/lirjAV7I4L8UOyH
         5Vdw==
X-Gm-Message-State: AFuF++kUTZXy1Wbny6xqnD3Rm9yDrbP1MSyxfmEsDj777U6tNgoxZH/v
	EfZGdJoz6158icACHE19R5f0+xqfmYy+0PU4HZr2v3tRPJPYE5O3jjBsGYNb267n
X-Gm-Gg: AYBFou0dophwLNliwtSfV7q4NiCIZLce+AAXcC2/q7pqlF7cxlQcI+KKVRTc4fIViEW
	wW+LE8ioYtF2oqLFKLqj8e9cpzQXPGjQlRyeuYetzb7HhgvIE9wq8p8tSbyLxeBqCGyhw4z9MMq
	cuI7v2SfMWzYXcJ8/UPymRZNJ01Ic6oNMlmJvZhhIT7He2x/Pikit3ojUqPv58DWbW+3eaeCHJl
	txoKasTlPSSKX6xmLjmx4RogZk7lRk4SkaW9U2czhbwtER27jQjb2bloklJs9c69ieEy3vyPFOd
	WsdtxnD3Ok8g1caUlaEtO8gOWw6hZYTGSQQDo58gyGwXMoFDewjglzzq9nMe9r479Gb7099Sltc
	nmf9+2N/r/CUA/GyhfAsC5qCwlNyKIEfqWAeBOKGqw7g6isbQWzeZugodivCruis2HxWVbVCjpZ
	0jRz6LpiaNTQgDAXwkVkKLSa+6DDrkd2Z9KB5R+ftfQ3XXub5TeeSaEtL4iBZYArIxcXB0uSWl0
	OkaJ7D6wgYc
X-Received: by 2002:a05:6808:2385:b0:4f3:2f34:fc51 with SMTP id 5614622812f47-50b4d72d92emr387359b6e.8.1791493651535;
        Thu, 08 Oct 2026 14:07:31 -0700 (PDT)
Received: from [127.0.0.1] ([40.80.213.169])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50b516f1cb1sm362276b6e.5.2026.10.08.14.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:07:31 -0700 (PDT)
Message-Id: <35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.v2.git.1791493644.gitgitgadget@gmail.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v2.git.1791493644.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 21:07:24 +0000
Subject: [PATCH v2 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
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
    Ravi Mistry <rmistry@google.com>,
    Ravi Mistry <rmistry@google.com>

From: Ravi Mistry <rmistry@google.com>

git-blame(1) can ignore a list of commits specified via
--ignore-revs-file or the blame.ignoreRevsFile configuration option.
This is useful for skipping uninteresting revisions such as tree-wide
formatting changes, large-scale refactors, and code modernizations that
would otherwise obscure genuine historical authorship.

When revision-ignoring was introduced in commit ae3f36dea1 ("blame: add
blame.ignoreRevsFile config option", 2019-10-18), it intentionally
avoided adopting a default ignore file. At the time, the capability was
new and unproven, so avoiding unrequested filesystem I/O or unexpected
attribution shifts took priority over a project-wide default.
Requiring explicit opt-in per clone was therefore the prudent design.

Since then, maintaining a .git-blame-ignore-revs file in the repository
root has become the de facto standard across the Git ecosystem, adopted
by major hosting platforms (GitHub, GitLab, Gerrit) and prominent open
source projects (such as Chromium and LLVM). As a consequence,
developers frequently encounter a jarring mismatch: web interfaces
seamlessly ignore formatting commits, but local git-blame(1) and
git-annotate(1) runs do not, unless each user manually configures
blame.ignoreRevsFile for every local checkout.

Teach git-blame(1) and git-annotate(1) to automatically add the
HEAD:.git-blame-ignore-revs blob, if it exists, as the initial element
in the list of ignore-revs files in both bare and non-bare
repositories. Reading the committed blob from HEAD rather than the
working tree ensures that local runs match hosting platforms even when
an untracked .git-blame-ignore-revs file is present or a tracked one
has uncommitted local changes.

To ensure consistent precedence and override semantics:
- The default HEAD:.git-blame-ignore-revs entry is added before reading
  configuration and CLI options, preserving user and repository config
  overrides.
- In git_blame_config(), blame.ignoreRevsFile entries are appended via
  string_list_append() rather than inserted in sorted order via
  string_list_insert() so that configuration entries preserve their
  order relative to the initial default entry.
- The HEAD:.git-blame-ignore-revs tree entry is resolved quietly via
  get_oid_with_context(). Its mode is checked with S_ISREG() before
  reading the object so that non-regular tree entries (such as a
  committed symbolic link whose blob stores a target path rather than
  revision IDs, a subdirectory, or a gitlink) are skipped instead of
  being read and rejected as malformed object names. The blob is parsed
  in memory via a new oidset_parse_buffer_carefully() helper in
  oidset.c that shares line parsing with oidset_parse_file_carefully().
- In build_ignorelist(), ignore-revs entries are processed starting
  after the last empty string entry. This ensures setting
  blame.ignoreRevsFile to "" or passing --ignore-revs-file "" or
  --no-ignore-revs-file cleanly discards the default blob without
  attempting to read or parse it, allowing users to bypass a malformed
  default blob.

Update documentation in blame-options.adoc and config/blame.adoc, and
add comprehensive test coverage in t8013 for the default blob lookup,
subdirectory invocations, bare repositories, uncommitted and untracked
working-tree files, CLI and config overrides, committed symlink
entries, and comments and whitespace handling.

Based-on-patch-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
Helped-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 Documentation/blame-options.adoc |   8 +-
 Documentation/config/blame.adoc  |   9 +-
 builtin/blame.c                  |  45 +++++++-
 oidset.c                         |  84 +++++++++-----
 oidset.h                         |   9 ++
 t/t8013-blame-ignore-revs.sh     | 182 +++++++++++++++++++++++++++++++
 6 files changed, 301 insertions(+), 36 deletions(-)

diff --git a/Documentation/blame-options.adoc b/Documentation/blame-options.adoc
index 1ae1222b6b..8d59dcc8f3 100644
--- a/Documentation/blame-options.adoc
+++ b/Documentation/blame-options.adoc
@@ -132,9 +132,11 @@ take effect.
 `--ignore-revs-file <file>`::
 	Ignore revisions listed in _<file>_, which must be in the same format as an
 	`fsck.skipList`.  This option may be repeated, and these files will be
-	processed after any files specified with the `blame.ignoreRevsFile` config
-	option.  An empty file name, `""`, will clear the list of revs from
-	previously processed files.
+	processed after the default `HEAD:.git-blame-ignore-revs` blob (if it
+	exists) and any files specified with the `blame.ignoreRevsFile` config
+	option.  An empty file name, `""`, or `--no-ignore-revs-file` will clear
+	the list of revs from previously processed files, including the default
+	`HEAD:.git-blame-ignore-revs` blob.
 
 `--color-lines`::
 	Color line annotations in the default format differently if they come from
diff --git a/Documentation/config/blame.adoc b/Documentation/config/blame.adoc
index 4d047c1790..153d4ab524 100644
--- a/Documentation/config/blame.adoc
+++ b/Documentation/config/blame.adoc
@@ -23,9 +23,12 @@ blame.showRoot::
 blame.ignoreRevsFile::
 	Ignore revisions listed in the file, one unabbreviated object name per
 	line, in linkgit:git-blame[1].  Whitespace and comments beginning with
-	`#` are ignored.  This option may be repeated multiple times.  Empty
-	file names will reset the list of ignored revisions.  This option will
-	be handled before the command line option `--ignore-revs-file`.
+	`#` are ignored.  If the `HEAD:.git-blame-ignore-revs` blob exists, it
+	is added as the initial element in the list of ignore-revs files.
+	Other files listed in the configuration are also used, but an empty
+	element makes all elements that appeared before in the list forgotten.
+	This option will be handled before the command line option
+	`--ignore-revs-file`.
 
 blame.markUnblamableLines::
 	Mark lines that were changed by an ignored revision that we could not
diff --git a/builtin/blame.c b/builtin/blame.c
index 6741a7b9df..a730ee87ea 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -769,7 +769,7 @@ static int git_blame_config(const char *var, const char *value,
 		if (ret)
 			return ret;
 		if (str)
-			string_list_insert(&ignore_revs_file_list, str);
+			string_list_append(&ignore_revs_file_list, str);
 		free(str);
 		return 0;
 	}
@@ -946,17 +946,52 @@ static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
 	}
 }
 
+static void parse_default_ignore_revs_blob(struct blame_scoreboard *sb,
+					   const char *name)
+{
+	struct object_context oc;
+	struct object_id oid;
+	enum object_type type;
+	size_t size;
+	char *buf;
+
+	if (get_oid_with_context(the_repository, name, GET_OID_QUIETLY,
+				 &oid, &oc))
+		goto out;
+	if (!S_ISREG(oc.mode))
+		goto out;
+
+	buf = odb_read_object(the_repository->objects, &oid, &type, &size);
+	if (!buf)
+		goto out;
+	if (type == OBJ_BLOB)
+		oidset_parse_buffer_carefully(&sb->ignore_list, buf, size,
+					      the_repository->hash_algo,
+					      peel_to_commit_oid, sb);
+	free(buf);
+
+out:
+	object_context_release(&oc);
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
+			parse_default_ignore_revs_blob(sb, i->string);
 		else
 			oidset_parse_file_carefully(&sb->ignore_list, i->string,
 						    the_repository->hash_algo,
@@ -1036,6 +1071,8 @@ int cmd_blame(int argc,
 	const char *const *opt_usage = cmd_is_annotate ? annotate_opt_usage : blame_opt_usage;
 
 	setup_default_color_by_age();
+	string_list_append(&ignore_revs_file_list,
+			   "HEAD:.git-blame-ignore-revs")->util = &sb;
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
index 70fe509a64..3e1b5291aa 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -365,4 +365,186 @@ test_expect_success 'ignore-revs-file peels chained tags and skips missing tag t
 	test_cmp expect actual
 '
 
+# Tests for default HEAD:.git-blame-ignore-revs blob
+test_expect_success 'setup default HEAD:.git-blame-ignore-revs' '
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
+	git add .git-blame-ignore-revs &&
+	test_tick &&
+	git commit -m "add .git-blame-ignore-revs"
+'
+
+test_expect_success 'default HEAD:.git-blame-ignore-revs is used by default' '
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default HEAD:.git-blame-ignore-revs respected by git annotate' '
+	git rev-parse --short DEF_A >expect_sha &&
+	git annotate def-file >actual &&
+	test_grep "^$(cat expect_sha)" actual
+'
+
+test_expect_success 'default HEAD:.git-blame-ignore-revs works from subdirectory' '
+	mkdir -p sub &&
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
+	test_cmp expect actual
+'
+
+test_expect_success 'uncommitted .git-blame-ignore-revs changes in working tree are ignored' '
+	test_when_finished "git checkout -- .git-blame-ignore-revs" &&
+	echo "invalid-oid-value" >.git-blame-ignore-revs &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'disable default HEAD:.git-blame-ignore-revs with --no-ignore-revs-file' '
+	git blame --line-porcelain --no-ignore-revs-file def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'disable default HEAD:.git-blame-ignore-revs with --ignore-revs-file ""' '
+	git blame --line-porcelain --ignore-revs-file "" def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'disable default HEAD:.git-blame-ignore-revs with blame.ignoreRevsFile=""' '
+	test_config blame.ignoreRevsFile "" &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default HEAD:.git-blame-ignore-revs handles comments and whitespace' '
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
+test_expect_success 'empty default HEAD:.git-blame-ignore-revs is harmless' '
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
+test_expect_success 'committed symlink .git-blame-ignore-revs in HEAD is ignored' '
+	git rm -f .git-blame-ignore-revs &&
+	git rev-parse DEF_B >target_file &&
+	test_ln_s_add target_file .git-blame-ignore-revs &&
+	test_tick &&
+	git commit -m "symlink .git-blame-ignore-revs" &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'malformed default HEAD:.git-blame-ignore-revs fails but can be bypassed' '
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
+test_expect_success 'default HEAD:.git-blame-ignore-revs combined with config blame.ignoreRevsFile' '
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
+test_expect_success 'blame works when HEAD:.git-blame-ignore-revs does not exist and ignores untracked file' '
+	git rm -f .git-blame-ignore-revs &&
+	test_tick &&
+	git commit -m "remove .git-blame-ignore-revs" &&
+	git rev-parse DEF_B >.git-blame-ignore-revs &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
