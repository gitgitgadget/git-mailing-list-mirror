Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFB31D371
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827639; cv=none; b=dLMBEZfEyN9cGaYX/xnhUxasbxvFv4yxuliE70RFJpL0kHEV45fLjost7q1gv6NA/Tanwn3jxZx4d4jh81ZGLDjkHkvxmoq+HJrStrkLWuQ575prv0wXrdVS6nKEyz/DLiZppun3FBLsae9aEeN/Kv2OiXZheA9XSFu0kJmXoFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827639; c=relaxed/simple;
	bh=LmRH2fiEv8mG+mDhn9vz3KzuR0FGUnV5rjVL/o4Jp7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ff7SAER7F8Is56x5yHhhdC9LzCoGvxgpu91SR0Yc8jj1vrSup2POglEnuhPFvK6y5/QO5v6bVzCYF2tNNGycjsnfEFKObHcN+SKa43VdzIbalayMSnHOmeSeYUxXsWt6t7WscAjZgc+eIheHnnRUakg5lQxj7buD8Pt9qplDPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/zCS0ep; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/zCS0ep"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so812620f8f.0
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761827634; x=1762432434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrGyw0zbmBY2FyJ5Bo29kE64SUOdhdCj5J6kU3ijsKk=;
        b=c/zCS0ep3/lFG4IvB3sxXhtGbnJ3AosZ5dfKJplO7VPRBya9K6NroxUtkLatc6h//2
         aNXqI7Lq5lzm3RSzg+XLRmnso4bgn4T2+TksoltCWMfxFOC28RHHIfqjCSy42Ph9/ExV
         /Rct/uSr2aclSepqN1r0dhR2yfD9N2ZBKykxeT3zv1T330SYhfQgKyrSknKIPmVL0Cxe
         Rm4VvLRuA9Fvank2DdT6INhRDJW1jXHhtqj1wW3jBfjhPyuBKeakocwvj2ic8pXt36gi
         jYV93d5NsSLoFgU9Xs6NOTSwDA8gAYQLa//PRt1Hr1n19szCdfveT6OwGt/AYLT/PzPy
         WfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827634; x=1762432434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrGyw0zbmBY2FyJ5Bo29kE64SUOdhdCj5J6kU3ijsKk=;
        b=ucya/fZhu/gvieTNF/5LcfisVw2F7+JatnwhrYbIdKDiQm31t76llQ2270Vxe6VtBe
         ghI3CqbLvhVClXOfGWeLKuITrBpgLcJ3WzCbY82Hiwj2oJODVGvJeKjvgHzOC5tKtRNI
         sVn+knbr+voVsIwWpNVHt16Qv+622/Dkfr0EXlOXIy7WC73Vosc9QKw0pT2P61DNiC6R
         l2Mmqw26J8kEUmThoLUMb1ZLSFLFbKId20yLVJd+MJ9RggOCMn96eA/fbz92CATvGbyp
         OvdW7Hr/hs4NthOkc/MT2sfJfn/hO0hG35cn3tCcNgiwtuidCN1Ux9Fj4migw0dBkjrn
         qLKw==
X-Gm-Message-State: AOJu0YxEGPUIrJQ2DZ15mAbUwKGpj5V07kxn2c3v3meigVmiH35AqCTq
	i3AV9CtL7ONCCkcLjbBFkb//OwClf+iTpsDEylbMhuZfuxiKP9ACMc6osemIcg==
X-Gm-Gg: ASbGncvCM/38QZcvEHIWofN2hZnzcYv3mMswJ0dFO0AfyaOmHFLDGkW3tLB52Lnyzli
	PvZObUkA4gvPIM7KYR7duOFHxquCDLdWyx3trHD8yrZKrOGwMnR0ToRuL5Da3m7Rm9u8myqg2G9
	wZQgaSVyRfX3AfxAK5DanGsJNMYiXf+58aT5aBR5T0U/t3bKW2y71cOTgOxPEX4/wma/HoGvcDm
	1U7USQ7BFW88uK9zlfjqw/Ltj7gSLVpdRivgEDrIyWbjI0AYvu3zBeZznlYk7kaxiqwaOtfEKej
	a/eCsqVNKeF33llaZiZV7/CfUaDISPEol6oN2Jgbubyj5IH6P+VbK4arLFaLkOPE1Uw/VlEZssh
	Ru8UW23uEyv5Hi83Zlc2DLA1GicM0PZ45+Hs10NtJ7+rg+ynBHjknOXwCFOcbW8xXtF0SJ0kto5
	d02kve7/InCEdqLn/g7oH5wSAnG39M+FVX42mFxqKu4YV+Y3k=
X-Google-Smtp-Source: AGHT+IG7R08UeODhTN2N0MCoDHZAItdBN38Affv1FqwEYgDsdROQpnNz4s771JEL8H61W59D58MOSA==
X-Received: by 2002:a05:6000:2212:b0:3ee:1461:1654 with SMTP id ffacd0b85a97d-429aeff11f1mr5073179f8f.50.1761827633354;
        Thu, 30 Oct 2025 05:33:53 -0700 (PDT)
Received: from christian--20230123--2G7D3.lan ([2001:861:2074:39a0:8aa2:a86f:99be:b78d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ba3574a2sm2364595f8f.44.2025.10.30.05.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:33:51 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/5] fast-import: mark strings for translation
Date: Thu, 30 Oct 2025 13:33:31 +0100
Message-ID: <20251030123332.3337684-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.2.617.g2aaa867cd1
In-Reply-To: <20251030123332.3337684-1-christian.couder@gmail.com>
References: <20251028081232.3068147-1-christian.couder@gmail.com>
 <20251030123332.3337684-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some error or warning messages in "builtin/fast-import.c" are marked
for translation, but many are not.

To be more consistent and provide a better experience to people using a
translated version, let's mark all the remaining error or warning
messages for translation.

While at it, let's make the following small changes:

  - replace "GIT" or "git" in a few error messages to just "Git",
  - replace "Expected from command, got %s" to "expected 'from'
    command, got '%s'", which makes it clearer that "from" is a command
    and should not be translated,
  - downcase error and warning messages that start with an uppercase,
  - fix test cases in "t9300-fast-import.sh" that broke because an
    error or warning message was downcased,
  - split error and warning messages that are too long,
  - adjust the indentation of some arguments of the error functions.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-import.c  | 280 ++++++++++++++++++++---------------------
 t/t9300-fast-import.sh |  20 +--
 2 files changed, 150 insertions(+), 150 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 8714edfc65..22d5deae9a 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -339,12 +339,12 @@ static void write_crash_report(const char *err)
 	struct recent_command *rc;
 
 	if (!rpt) {
-		error_errno("can't write crash report %s", loc);
+		error_errno(_("can't write crash report %s"), loc);
 		free(loc);
 		return;
 	}
 
-	fprintf(stderr, "fast-import: dumping crash report to %s\n", loc);
+	fprintf(stderr, _("fast-import: dumping crash report to %s\n"), loc);
 
 	fprintf(rpt, "fast-import crash report:\n");
 	fprintf(rpt, "    fast-import process: %"PRIuMAX"\n", (uintmax_t) getpid());
@@ -588,7 +588,7 @@ static void *find_mark(struct mark_set *s, uintmax_t idnum)
 			oe = s->data.marked[idnum];
 	}
 	if (!oe)
-		die("mark :%" PRIuMAX " not declared", orig_idnum);
+		die(_("mark :%" PRIuMAX " not declared"), orig_idnum);
 	return oe;
 }
 
@@ -628,9 +628,9 @@ static struct branch *new_branch(const char *name)
 	struct branch *b = lookup_branch(name);
 
 	if (b)
-		die("Invalid attempt to create duplicate branch: %s", name);
+		die(_("invalid attempt to create duplicate branch: %s"), name);
 	if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL))
-		die("Branch name doesn't conform to GIT standards: %s", name);
+		die(_("branch name doesn't conform to Git standards: %s"), name);
 
 	b = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct branch));
 	b->name = mem_pool_strdup(&fi_mem_pool, name);
@@ -801,7 +801,7 @@ static const char *create_index(void)
 				*c++ = &e->idx;
 	last = idx + object_count;
 	if (c != last)
-		die("internal consistency error creating the index");
+		die(_("internal consistency error creating the index"));
 
 	tmpfile = write_idx_file(the_repository, NULL, idx, object_count,
 				 &pack_idx_opts, pack_data->hash);
@@ -819,18 +819,18 @@ static char *keep_pack(const char *curr_index_name)
 	keep_fd = safe_create_file_with_leading_directories(pack_data->repo,
 							    name.buf);
 	if (keep_fd < 0)
-		die_errno("cannot create keep file");
+		die_errno(_("cannot create keep file"));
 	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
 	if (close(keep_fd))
-		die_errno("failed to write keep file");
+		die_errno(_("failed to write keep file"));
 
 	odb_pack_name(pack_data->repo, &name, pack_data->hash, "pack");
 	if (finalize_object_file(pack_data->repo, pack_data->pack_name, name.buf))
-		die("cannot store pack file");
+		die(_("cannot store pack file"));
 
 	odb_pack_name(pack_data->repo, &name, pack_data->hash, "idx");
 	if (finalize_object_file(pack_data->repo, curr_index_name, name.buf))
-		die("cannot store index file");
+		die(_("cannot store index file"));
 	free((void *)curr_index_name);
 	return strbuf_detach(&name, NULL);
 }
@@ -853,7 +853,7 @@ static int loosen_small_pack(const struct packed_git *p)
 	struct child_process unpack = CHILD_PROCESS_INIT;
 
 	if (lseek(p->pack_fd, 0, SEEK_SET) < 0)
-		die_errno("Failed seeking to start of '%s'", p->pack_name);
+		die_errno(_("failed seeking to start of '%s'"), p->pack_name);
 
 	unpack.in = p->pack_fd;
 	unpack.git_cmd = 1;
@@ -903,7 +903,7 @@ static void end_packfile(void)
 		new_p = packfile_store_load_pack(pack_data->repo->objects->packfiles,
 						 idx_name, 1);
 		if (!new_p)
-			die("core git rejected index %s", idx_name);
+			die(_("core Git rejected index %s"), idx_name);
 		all_packs[pack_id] = new_p;
 		free(idx_name);
 
@@ -1090,7 +1090,7 @@ static int store_object(
 static void truncate_pack(struct hashfile_checkpoint *checkpoint)
 {
 	if (hashfile_truncate(pack_file, checkpoint))
-		die_errno("cannot truncate pack to skip duplicate");
+		die_errno(_("cannot truncate pack to skip duplicate"));
 	pack_size = checkpoint->offset;
 }
 
@@ -1138,7 +1138,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 			size_t cnt = in_sz < len ? in_sz : (size_t)len;
 			size_t n = fread(in_buf, 1, cnt, stdin);
 			if (!n && feof(stdin))
-				die("EOF in data (%" PRIuMAX " bytes remaining)", len);
+				die(_("EOF in data (%" PRIuMAX " bytes remaining)"), len);
 
 			git_hash_update(&c, in_buf, n);
 			s.next_in = in_buf;
@@ -1162,7 +1162,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		case Z_STREAM_END:
 			continue;
 		default:
-			die("unexpected deflate failure: %d", status);
+			die(_("unexpected deflate failure: %d"), status);
 		}
 	}
 	git_deflate_end(&s);
@@ -1264,16 +1264,16 @@ static void load_tree(struct tree_entry *root)
 	myoe = find_object(oid);
 	if (myoe && myoe->pack_id != MAX_PACK_ID) {
 		if (myoe->type != OBJ_TREE)
-			die("Not a tree: %s", oid_to_hex(oid));
+			die(_("not a tree: %s"), oid_to_hex(oid));
 		t->delta_depth = myoe->depth;
 		buf = gfi_unpack_entry(myoe, &size);
 		if (!buf)
-			die("Can't load tree %s", oid_to_hex(oid));
+			die(_("can't load tree %s"), oid_to_hex(oid));
 	} else {
 		enum object_type type;
 		buf = odb_read_object(the_repository->objects, oid, &type, &size);
 		if (!buf || type != OBJ_TREE)
-			die("Can't load tree %s", oid_to_hex(oid));
+			die(_("can't load tree %s"), oid_to_hex(oid));
 	}
 
 	c = buf;
@@ -1287,7 +1287,7 @@ static void load_tree(struct tree_entry *root)
 		e->tree = NULL;
 		c = parse_mode(c, &e->versions[1].mode);
 		if (!c)
-			die("Corrupt mode in %s", oid_to_hex(oid));
+			die(_("corrupt mode in %s"), oid_to_hex(oid));
 		e->versions[0].mode = e->versions[1].mode;
 		e->name = to_atom(c, strlen(c));
 		c += e->name->str_len + 1;
@@ -1399,7 +1399,7 @@ static void tree_content_replace(
 	struct tree_content *newtree)
 {
 	if (!S_ISDIR(mode))
-		die("Root cannot be a non-directory");
+		die(_("root cannot be a non-directory"));
 	oidclr(&root->versions[0].oid, the_repository->hash_algo);
 	oidcpy(&root->versions[1].oid, oid);
 	if (root->tree)
@@ -1422,9 +1422,9 @@ static int tree_content_set(
 	slash1 = strchrnul(p, '/');
 	n = slash1 - p;
 	if (!n)
-		die("Empty path component found in input");
+		die(_("empty path component found in input"));
 	if (!*slash1 && !S_ISDIR(mode) && subtree)
-		die("Non-directories cannot have subtrees");
+		die(_("non-directories cannot have subtrees"));
 
 	if (!root->tree)
 		load_tree(root);
@@ -1576,7 +1576,7 @@ static int tree_content_get(
 	slash1 = strchrnul(p, '/');
 	n = slash1 - p;
 	if (!n && !allow_root)
-		die("Empty path component found in input");
+		die(_("empty path component found in input"));
 
 	if (!root->tree)
 		load_tree(root);
@@ -1622,8 +1622,8 @@ static int update_branch(struct branch *b)
 	    !strcmp(b->name + strlen(replace_prefix),
 		    oid_to_hex(&b->oid))) {
 		if (!quiet)
-			warning("Dropping %s since it would point to "
-				"itself (i.e. to %s)",
+			warning(_("dropping %s since it would point to "
+				  "itself (i.e. to %s)"),
 				b->name, oid_to_hex(&b->oid));
 		refs_delete_ref(get_main_ref_store(the_repository),
 				NULL, b->name, NULL, 0);
@@ -1646,14 +1646,14 @@ static int update_branch(struct branch *b)
 		new_cmit = lookup_commit_reference_gently(the_repository,
 							  &b->oid, 0);
 		if (!old_cmit || !new_cmit)
-			return error("Branch %s is missing commits.", b->name);
+			return error(_("branch %s is missing commits."), b->name);
 
 		ret = repo_in_merge_bases(the_repository, old_cmit, new_cmit);
 		if (ret < 0)
 			exit(128);
 		if (!ret) {
-			warning("Not updating %s"
-				" (new tip %s does not contain %s)",
+			warning(_("not updating %s"
+				  " (new tip %s does not contain %s)"),
 				b->name, oid_to_hex(&b->oid),
 				oid_to_hex(&old_oid));
 			return -1;
@@ -1729,13 +1729,13 @@ static void dump_marks(void)
 		return;
 
 	if (safe_create_leading_directories_const(the_repository, export_marks_file)) {
-		failure |= error_errno("unable to create leading directories of %s",
+		failure |= error_errno(_("unable to create leading directories of %s"),
 				       export_marks_file);
 		return;
 	}
 
 	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0) < 0) {
-		failure |= error_errno("Unable to write marks file %s",
+		failure |= error_errno(_("unable to write marks file %s"),
 				       export_marks_file);
 		return;
 	}
@@ -1744,14 +1744,14 @@ static void dump_marks(void)
 	if (!f) {
 		int saved_errno = errno;
 		rollback_lock_file(&mark_lock);
-		failure |= error("Unable to write marks file %s: %s",
+		failure |= error(_("unable to write marks file %s: %s"),
 			export_marks_file, strerror(saved_errno));
 		return;
 	}
 
 	for_each_mark(marks, 0, dump_marks_fn, f);
 	if (commit_lock_file(&mark_lock)) {
-		failure |= error_errno("Unable to write file %s",
+		failure |= error_errno(_("unable to write file %s"),
 				       export_marks_file);
 		return;
 	}
@@ -1765,7 +1765,7 @@ static void insert_object_entry(struct mark_set **s, struct object_id *oid, uint
 		enum object_type type = odb_read_object_info(the_repository->objects,
 							     oid, NULL);
 		if (type < 0)
-			die("object not found: %s", oid_to_hex(oid));
+			die(_("object not found: %s"), oid_to_hex(oid));
 		e = insert_object(oid);
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
@@ -1792,13 +1792,13 @@ static void read_mark_file(struct mark_set **s, FILE *f, mark_set_inserter_t ins
 
 		end = strchr(line, '\n');
 		if (line[0] != ':' || !end)
-			die("corrupt mark line: %s", line);
+			die(_("corrupt mark line: %s"), line);
 		*end = 0;
 		mark = strtoumax(line + 1, &end, 10);
 		if (!mark || end == line + 1
 			|| *end != ' '
 			|| get_oid_hex_any(end + 1, &oid) == GIT_HASH_UNKNOWN)
-			die("corrupt mark line: %s", line);
+			die(_("corrupt mark line: %s"), line);
 		inserter(s, &oid, mark);
 	}
 }
@@ -1811,7 +1811,7 @@ static void read_marks(void)
 	else if (import_marks_file_ignore_missing && errno == ENOENT)
 		goto done; /* Marks file does not exist */
 	else
-		die_errno("cannot read '%s'", import_marks_file);
+		die_errno(_("cannot read '%s'"), import_marks_file);
 	read_mark_file(&marks, f, insert_object_entry);
 	fclose(f);
 done:
@@ -1897,7 +1897,7 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 	strbuf_reset(sb);
 
 	if (!skip_prefix(command_buf.buf, "data ", &data))
-		die("Expected 'data n' command, found: %s", command_buf.buf);
+		die(_("expected 'data n' command, found: %s"), command_buf.buf);
 
 	if (skip_prefix(data, "<<", &data)) {
 		char *term = xstrdup(data);
@@ -1905,7 +1905,7 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 
 		for (;;) {
 			if (strbuf_getline_lf(&command_buf, stdin) == EOF)
-				die("EOF in data (terminator '%s' not found)", term);
+				die(_("EOF in data (terminator '%s' not found)"), term);
 			if (term_len == command_buf.len
 				&& !strcmp(term, command_buf.buf))
 				break;
@@ -1923,12 +1923,12 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 			return 0;
 		}
 		if (length < len)
-			die("data is too large to use in this context");
+			die(_("data is too large to use in this context"));
 
 		while (n < length) {
 			size_t s = strbuf_fread(sb, length - n, stdin);
 			if (!s && feof(stdin))
-				die("EOF in data (%lu bytes remaining)",
+				die(_("EOF in data (%lu bytes remaining)"),
 					(unsigned long)(length - n));
 			n += s;
 		}
@@ -1985,15 +1985,15 @@ static char *parse_ident(const char *buf)
 
 	ltgt = buf + strcspn(buf, "<>");
 	if (*ltgt != '<')
-		die("Missing < in ident string: %s", buf);
+		die(_("missing < in ident string: %s"), buf);
 	if (ltgt != buf && ltgt[-1] != ' ')
-		die("Missing space before < in ident string: %s", buf);
+		die(_("missing space before < in ident string: %s"), buf);
 	ltgt = ltgt + 1 + strcspn(ltgt + 1, "<>");
 	if (*ltgt != '>')
-		die("Missing > in ident string: %s", buf);
+		die(_("missing > in ident string: %s"), buf);
 	ltgt++;
 	if (*ltgt != ' ')
-		die("Missing space after > in ident string: %s", buf);
+		die(_("missing space after > in ident string: %s"), buf);
 	ltgt++;
 	name_len = ltgt - buf;
 	strbuf_add(&ident, buf, name_len);
@@ -2001,19 +2001,19 @@ static char *parse_ident(const char *buf)
 	switch (whenspec) {
 	case WHENSPEC_RAW:
 		if (validate_raw_date(ltgt, &ident, 1) < 0)
-			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
+			die(_("invalid raw date \"%s\" in ident: %s"), ltgt, buf);
 		break;
 	case WHENSPEC_RAW_PERMISSIVE:
 		if (validate_raw_date(ltgt, &ident, 0) < 0)
-			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
+			die(_("invalid raw date \"%s\" in ident: %s"), ltgt, buf);
 		break;
 	case WHENSPEC_RFC2822:
 		if (parse_date(ltgt, &ident) < 0)
-			die("Invalid rfc2822 date \"%s\" in ident: %s", ltgt, buf);
+			die(_("invalid rfc2822 date \"%s\" in ident: %s"), ltgt, buf);
 		break;
 	case WHENSPEC_NOW:
 		if (strcmp("now", ltgt))
-			die("Date in ident must be 'now': %s", buf);
+			die(_("date in ident must be 'now': %s"), buf);
 		datestamp(&ident);
 		break;
 	}
@@ -2107,7 +2107,7 @@ static void construct_path_with_fanout(const char *hex_sha1,
 {
 	unsigned int i = 0, j = 0;
 	if (fanout >= the_hash_algo->rawsz)
-		die("Too large fanout (%u)", fanout);
+		die(_("too large fanout (%u)"), fanout);
 	while (fanout) {
 		path[i++] = hex_sha1[j++];
 		path[i++] = hex_sha1[j++];
@@ -2181,7 +2181,7 @@ static uintmax_t do_change_note_fanout(
 
 			/* Rename fullpath to realpath */
 			if (!tree_content_remove(orig_root, fullpath, &leaf, 0))
-				die("Failed to remove path %s", fullpath);
+				die(_("failed to remove path %s"), fullpath);
 			tree_content_set(orig_root, realpath,
 				&leaf.versions[1].oid,
 				leaf.versions[1].mode,
@@ -2254,7 +2254,7 @@ static uintmax_t parse_mark_ref(const char *p, char **endptr)
 	p++;
 	mark = strtoumax(p, endptr, 10);
 	if (*endptr == p)
-		die("No value after ':' in mark: %s", command_buf.buf);
+		die(_("no value after ':' in mark: %s"), command_buf.buf);
 	return mark;
 }
 
@@ -2269,7 +2269,7 @@ static uintmax_t parse_mark_ref_eol(const char *p)
 
 	mark = parse_mark_ref(p, &end);
 	if (*end != '\0')
-		die("Garbage after mark: %s", command_buf.buf);
+		die(_("garbage after mark: %s"), command_buf.buf);
 	return mark;
 }
 
@@ -2284,7 +2284,7 @@ static uintmax_t parse_mark_ref_space(const char **p)
 
 	mark = parse_mark_ref(*p, &end);
 	if (*end++ != ' ')
-		die("Missing space after mark: %s", command_buf.buf);
+		die(_("missing space after mark: %s"), command_buf.buf);
 	*p = end;
 	return mark;
 }
@@ -2300,9 +2300,9 @@ static void parse_path(struct strbuf *sb, const char *p, const char **endp,
 {
 	if (*p == '"') {
 		if (unquote_c_style(sb, p, endp))
-			die("Invalid %s: %s", field, command_buf.buf);
+			die(_("invalid %s: %s"), field, command_buf.buf);
 		if (strlen(sb->buf) != sb->len)
-			die("NUL in %s: %s", field, command_buf.buf);
+			die(_("NUL in %s: %s"), field, command_buf.buf);
 	} else {
 		/*
 		 * Unless we are parsing the last field of a line,
@@ -2325,7 +2325,7 @@ static void parse_path_eol(struct strbuf *sb, const char *p, const char *field)
 
 	parse_path(sb, p, &end, 1, field);
 	if (*end)
-		die("Garbage after %s: %s", field, command_buf.buf);
+		die(_("garbage after %s: %s"), field, command_buf.buf);
 }
 
 /*
@@ -2338,7 +2338,7 @@ static void parse_path_space(struct strbuf *sb, const char *p,
 {
 	parse_path(sb, p, endp, 0, field);
 	if (**endp != ' ')
-		die("Missing space after %s: %s", field, command_buf.buf);
+		die(_("missing space after %s: %s"), field, command_buf.buf);
 	(*endp)++;
 }
 
@@ -2351,7 +2351,7 @@ static void file_change_m(const char *p, struct branch *b)
 
 	p = parse_mode(p, &mode);
 	if (!p)
-		die("Corrupt mode: %s", command_buf.buf);
+		die(_("corrupt mode: %s"), command_buf.buf);
 	switch (mode) {
 	case 0644:
 	case 0755:
@@ -2364,7 +2364,7 @@ static void file_change_m(const char *p, struct branch *b)
 		/* ok */
 		break;
 	default:
-		die("Corrupt mode: %s", command_buf.buf);
+		die(_("corrupt mode: %s"), command_buf.buf);
 	}
 
 	if (*p == ':') {
@@ -2375,10 +2375,10 @@ static void file_change_m(const char *p, struct branch *b)
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
 	} else {
 		if (parse_mapped_oid_hex(p, &oid, &p))
-			die("Invalid dataref: %s", command_buf.buf);
+			die(_("invalid dataref: %s"), command_buf.buf);
 		oe = find_object(&oid);
 		if (*p++ != ' ')
-			die("Missing space after SHA1: %s", command_buf.buf);
+			die(_("missing space after SHA1: %s"), command_buf.buf);
 	}
 
 	strbuf_reset(&path);
@@ -2394,11 +2394,11 @@ static void file_change_m(const char *p, struct branch *b)
 
 	if (S_ISGITLINK(mode)) {
 		if (inline_data)
-			die("Git links cannot be specified 'inline': %s",
+			die(_("Git links cannot be specified 'inline': %s"),
 				command_buf.buf);
 		else if (oe) {
 			if (oe->type != OBJ_COMMIT)
-				die("Not a commit (actually a %s): %s",
+				die(_("not a commit (actually a %s): %s"),
 					type_name(oe->type), command_buf.buf);
 		}
 		/*
@@ -2407,7 +2407,7 @@ static void file_change_m(const char *p, struct branch *b)
 		 */
 	} else if (inline_data) {
 		if (S_ISDIR(mode))
-			die("Directories cannot be specified 'inline': %s",
+			die(_("directories cannot be specified 'inline': %s"),
 				command_buf.buf);
 		while (read_next_command() != EOF) {
 			const char *v;
@@ -2425,11 +2425,11 @@ static void file_change_m(const char *p, struct branch *b)
 					odb_read_object_info(the_repository->objects,
 							     &oid, NULL);
 		if (type < 0)
-			die("%s not found: %s",
-					S_ISDIR(mode) ?  "Tree" : "Blob",
-					command_buf.buf);
+			die(_("%s not found: %s"),
+			    S_ISDIR(mode) ?  _("tree") : _("blob"),
+			    command_buf.buf);
 		if (type != expected)
-			die("Not a %s (actually a %s): %s",
+			die(_("not a %s (actually a %s): %s"),
 				type_name(expected), type_name(type),
 				command_buf.buf);
 	}
@@ -2440,7 +2440,7 @@ static void file_change_m(const char *p, struct branch *b)
 	}
 
 	if (!verify_path(path.buf, mode))
-		die("invalid path '%s'", path.buf);
+		die(_("invalid path '%s'"), path.buf);
 	tree_content_set(&b->branch_tree, path.buf, &oid, mode, NULL);
 }
 
@@ -2470,7 +2470,7 @@ static void file_change_cr(const char *p, struct branch *b, int rename)
 	else
 		tree_content_get(&b->branch_tree, source.buf, &leaf, 1);
 	if (!leaf.versions[1].mode)
-		die("Path %s not in branch", source.buf);
+		die(_("path %s not in branch"), source.buf);
 	if (!*dest.buf) {	/* C "path/to/subdir" "" */
 		tree_content_replace(&b->branch_tree,
 			&leaf.versions[1].oid,
@@ -2479,7 +2479,7 @@ static void file_change_cr(const char *p, struct branch *b, int rename)
 		return;
 	}
 	if (!verify_path(dest.buf, leaf.versions[1].mode))
-		die("invalid path '%s'", dest.buf);
+		die(_("invalid path '%s'"), dest.buf);
 	tree_content_set(&b->branch_tree, dest.buf,
 		&leaf.versions[1].oid,
 		leaf.versions[1].mode,
@@ -2521,23 +2521,23 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
 	} else {
 		if (parse_mapped_oid_hex(p, &oid, &p))
-			die("Invalid dataref: %s", command_buf.buf);
+			die(_("invalid dataref: %s"), command_buf.buf);
 		oe = find_object(&oid);
 		if (*p++ != ' ')
-			die("Missing space after SHA1: %s", command_buf.buf);
+			die(_("missing space after SHA1: %s"), command_buf.buf);
 	}
 
 	/* <commit-ish> */
 	s = lookup_branch(p);
 	if (s) {
 		if (is_null_oid(&s->oid))
-			die("Can't add a note on empty branch.");
+			die(_("can't add a note on empty branch."));
 		oidcpy(&commit_oid, &s->oid);
 	} else if (*p == ':') {
 		uintmax_t commit_mark = parse_mark_ref_eol(p);
 		struct object_entry *commit_oe = find_mark(marks, commit_mark);
 		if (commit_oe->type != OBJ_COMMIT)
-			die("Mark :%" PRIuMAX " not a commit", commit_mark);
+			die(_("mark :%" PRIuMAX " not a commit"), commit_mark);
 		oidcpy(&commit_oid, &commit_oe->idx.oid);
 	} else if (!repo_get_oid(the_repository, p, &commit_oid)) {
 		unsigned long size;
@@ -2545,25 +2545,25 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 						   &commit_oid, OBJ_COMMIT, &size,
 						   &commit_oid);
 		if (!buf || size < the_hash_algo->hexsz + 6)
-			die("Not a valid commit: %s", p);
+			die(_("not a valid commit: %s"), p);
 		free(buf);
 	} else
-		die("Invalid ref name or SHA1 expression: %s", p);
+		die(_("invalid ref name or SHA1 expression: %s"), p);
 
 	if (inline_data) {
 		read_next_command();
 		parse_and_store_blob(&last_blob, &oid, 0);
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
-			die("Not a blob (actually a %s): %s",
+			die(_("not a blob (actually a %s): %s"),
 				type_name(oe->type), command_buf.buf);
 	} else if (!is_null_oid(&oid)) {
 		enum object_type type = odb_read_object_info(the_repository->objects, &oid,
 							NULL);
 		if (type < 0)
-			die("Blob not found: %s", command_buf.buf);
+			die(_("blob not found: %s"), command_buf.buf);
 		if (type != OBJ_BLOB)
-			die("Not a blob (actually a %s): %s",
+			die(_("not a blob (actually a %s): %s"),
 			    type_name(type), command_buf.buf);
 	}
 
@@ -2592,10 +2592,10 @@ static void file_change_deleteall(struct branch *b)
 static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
 {
 	if (!buf || size < the_hash_algo->hexsz + 6)
-		die("Not a valid commit: %s", oid_to_hex(&b->oid));
+		die(_("not a valid commit: %s"), oid_to_hex(&b->oid));
 	if (memcmp("tree ", buf, 5)
 		|| get_oid_hex(buf + 5, &b->branch_tree.versions[1].oid))
-		die("The commit %s is corrupt", oid_to_hex(&b->oid));
+		die(_("the commit %s is corrupt"), oid_to_hex(&b->oid));
 	oidcpy(&b->branch_tree.versions[0].oid,
 	       &b->branch_tree.versions[1].oid);
 }
@@ -2625,7 +2625,7 @@ static int parse_objectish(struct branch *b, const char *objectish)
 
 	s = lookup_branch(objectish);
 	if (b == s)
-		die("Can't create a branch from itself: %s", b->name);
+		die(_("can't create a branch from itself: %s"), b->name);
 	else if (s) {
 		struct object_id *t = &s->branch_tree.versions[1].oid;
 		oidcpy(&b->oid, &s->oid);
@@ -2635,7 +2635,7 @@ static int parse_objectish(struct branch *b, const char *objectish)
 		uintmax_t idnum = parse_mark_ref_eol(objectish);
 		struct object_entry *oe = find_mark(marks, idnum);
 		if (oe->type != OBJ_COMMIT)
-			die("Mark :%" PRIuMAX " not a commit", idnum);
+			die(_("mark :%" PRIuMAX " not a commit"), idnum);
 		if (!oideq(&b->oid, &oe->idx.oid)) {
 			oidcpy(&b->oid, &oe->idx.oid);
 			if (oe->pack_id != MAX_PACK_ID) {
@@ -2652,7 +2652,7 @@ static int parse_objectish(struct branch *b, const char *objectish)
 			b->delete = 1;
 	}
 	else
-		die("Invalid ref name or SHA1 expression: %s", objectish);
+		die(_("invalid ref name or SHA1 expression: %s"), objectish);
 
 	if (b->branch_tree.tree && !oideq(&oid, &b->branch_tree.versions[1].oid)) {
 		release_tree_content_recursive(b->branch_tree.tree);
@@ -2699,7 +2699,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 			uintmax_t idnum = parse_mark_ref_eol(from);
 			struct object_entry *oe = find_mark(marks, idnum);
 			if (oe->type != OBJ_COMMIT)
-				die("Mark :%" PRIuMAX " not a commit", idnum);
+				die(_("mark :%" PRIuMAX " not a commit"), idnum);
 			oidcpy(&n->oid, &oe->idx.oid);
 		} else if (!repo_get_oid(the_repository, from, &n->oid)) {
 			unsigned long size;
@@ -2707,10 +2707,10 @@ static struct hash_list *parse_merge(unsigned int *count)
 							   &n->oid, OBJ_COMMIT,
 							   &size, &n->oid);
 			if (!buf || size < the_hash_algo->hexsz + 6)
-				die("Not a valid commit: %s", from);
+				die(_("not a valid commit: %s"), from);
 			free(buf);
 		} else
-			die("Invalid ref name or SHA1 expression: %s", from);
+			die(_("invalid ref name or SHA1 expression: %s"), from);
 
 		n->next = NULL;
 		*tail = n;
@@ -2734,8 +2734,8 @@ static void parse_one_signature(struct signature_data *sig, const char *v)
 	char *space = strchr(args, ' ');
 
 	if (!space)
-		die("Expected gpgsig format: 'gpgsig <hash-algo> <signature-format>', "
-		    "got 'gpgsig %s'", args);
+		die(_("expected gpgsig format: 'gpgsig <hash-algo> <signature-format>', "
+		      "got 'gpgsig %s'"), args);
 	*space = '\0';
 
 	sig->hash_algo = args;
@@ -2744,13 +2744,13 @@ static void parse_one_signature(struct signature_data *sig, const char *v)
 	/* Validate hash algorithm */
 	if (strcmp(sig->hash_algo, "sha1") &&
 	    strcmp(sig->hash_algo, "sha256"))
-		die("Unknown git hash algorithm in gpgsig: '%s'", sig->hash_algo);
+		die(_("unknown git hash algorithm in gpgsig: '%s'"), sig->hash_algo);
 
 	/* Validate signature format */
 	if (!valid_signature_format(sig->sig_format))
-		die("Invalid signature format in gpgsig: '%s'", sig->sig_format);
+		die(_("invalid signature format in gpgsig: '%s'"), sig->sig_format);
 	if (!strcmp(sig->sig_format, "unknown"))
-		warning("'unknown' signature format in gpgsig");
+		warning(_("'unknown' signature format in gpgsig"));
 
 	/* Read signature data */
 	read_next_command();
@@ -2789,8 +2789,8 @@ static void store_signature(struct signature_data *stored_sig,
 			    const char *hash_type)
 {
 	if (stored_sig->hash_algo) {
-		warning("multiple %s signatures found, "
-			"ignoring additional signature",
+		warning(_("multiple %s signatures found, "
+			  "ignoring additional signature"),
 			hash_type);
 		strbuf_release(&new_sig->data);
 		free(new_sig->hash_algo);
@@ -2845,15 +2845,15 @@ static void parse_new_commit(const char *arg)
 		read_next_command();
 	}
 	if (!committer)
-		die("Expected committer but didn't get one");
+		die(_("expected committer but didn't get one"));
 
 	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
 		switch (signed_commit_mode) {
 
 		/* First, modes that don't need the signature to be parsed */
 		case SIGN_ABORT:
-			die("encountered signed commit; use "
-			    "--signed-commits=<mode> to handle it");
+			die(_("encountered signed commit; use "
+			      "--signed-commits=<mode> to handle it"));
 		case SIGN_WARN_STRIP:
 			warning(_("stripping a commit signature"));
 			/* fallthru */
@@ -3025,11 +3025,11 @@ static void parse_new_tag(const char *arg)
 
 	/* from ... */
 	if (!skip_prefix(command_buf.buf, "from ", &from))
-		die("Expected from command, got %s", command_buf.buf);
+		die(_("expected 'from' command, got '%s'"), command_buf.buf);
 	s = lookup_branch(from);
 	if (s) {
 		if (is_null_oid(&s->oid))
-			die("Can't tag an empty branch.");
+			die(_("can't tag an empty branch."));
 		oidcpy(&oid, &s->oid);
 		type = OBJ_COMMIT;
 	} else if (*from == ':') {
@@ -3044,11 +3044,11 @@ static void parse_new_tag(const char *arg)
 			type = odb_read_object_info(the_repository->objects,
 						    &oid, NULL);
 			if (type < 0)
-				die("Not a valid object: %s", from);
+				die(_("not a valid object: %s"), from);
 		} else
 			type = oe->type;
 	} else
-		die("Invalid ref name or SHA1 expression: %s", from);
+		die(_("invalid ref name or SHA1 expression: %s"), from);
 	read_next_command();
 
 	/* original-oid ... */
@@ -3139,7 +3139,7 @@ static void parse_reset_branch(const char *arg)
 static void cat_blob_write(const char *buf, unsigned long size)
 {
 	if (write_in_full(cat_blob_fd, buf, size) < 0)
-		die_errno("Write to frontend failed");
+		die_errno(_("write to frontend failed"));
 }
 
 static void cat_blob(struct object_entry *oe, struct object_id *oid)
@@ -3168,9 +3168,9 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 		return;
 	}
 	if (!buf)
-		die("Can't read object %s", oid_to_hex(oid));
+		die(_("can't read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB)
-		die("Object %s is a %s but a blob was expected.",
+		die(_("object %s is a %s but a blob was expected."),
 		    oid_to_hex(oid), type_name(type));
 	strbuf_reset(&line);
 	strbuf_addf(&line, "%s %s %"PRIuMAX"\n", oid_to_hex(oid),
@@ -3194,11 +3194,11 @@ static void parse_get_mark(const char *p)
 
 	/* get-mark SP <object> LF */
 	if (*p != ':')
-		die("Not a mark: %s", p);
+		die(_("not a mark: %s"), p);
 
 	oe = find_mark(marks, parse_mark_ref_eol(p));
 	if (!oe)
-		die("Unknown mark: %s", command_buf.buf);
+		die(_("unknown mark: %s"), command_buf.buf);
 
 	xsnprintf(output, sizeof(output), "%s\n", oid_to_hex(&oe->idx.oid));
 	cat_blob_write(output, the_hash_algo->hexsz + 1);
@@ -3213,13 +3213,13 @@ static void parse_cat_blob(const char *p)
 	if (*p == ':') {
 		oe = find_mark(marks, parse_mark_ref_eol(p));
 		if (!oe)
-			die("Unknown mark: %s", command_buf.buf);
+			die(_("unknown mark: %s"), command_buf.buf);
 		oidcpy(&oid, &oe->idx.oid);
 	} else {
 		if (parse_mapped_oid_hex(p, &oid, &p))
-			die("Invalid dataref: %s", command_buf.buf);
+			die(_("invalid dataref: %s"), command_buf.buf);
 		if (*p)
-			die("Garbage after SHA1: %s", command_buf.buf);
+			die(_("garbage after SHA1: %s"), command_buf.buf);
 		oe = find_object(&oid);
 	}
 
@@ -3237,7 +3237,7 @@ static struct object_entry *dereference(struct object_entry *oe,
 		enum object_type type = odb_read_object_info(the_repository->objects,
 							     oid, NULL);
 		if (type < 0)
-			die("object not found: %s", oid_to_hex(oid));
+			die(_("object not found: %s"), oid_to_hex(oid));
 		/* cache it! */
 		oe = insert_object(oid);
 		oe->type = type;
@@ -3251,7 +3251,7 @@ static struct object_entry *dereference(struct object_entry *oe,
 	case OBJ_TAG:
 		break;
 	default:
-		die("Not a tree-ish: %s", command_buf.buf);
+		die(_("not a tree-ish: %s"), command_buf.buf);
 	}
 
 	if (oe->pack_id != MAX_PACK_ID) {	/* in a pack being written */
@@ -3262,19 +3262,19 @@ static struct object_entry *dereference(struct object_entry *oe,
 				      &unused, &size);
 	}
 	if (!buf)
-		die("Can't load object %s", oid_to_hex(oid));
+		die(_("can't load object %s"), oid_to_hex(oid));
 
 	/* Peel one layer. */
 	switch (oe->type) {
 	case OBJ_TAG:
 		if (size < hexsz + strlen("object ") ||
 		    get_oid_hex(buf + strlen("object "), oid))
-			die("Invalid SHA1 in tag: %s", command_buf.buf);
+			die(_("invalid SHA1 in tag: %s"), command_buf.buf);
 		break;
 	case OBJ_COMMIT:
 		if (size < hexsz + strlen("tree ") ||
 		    get_oid_hex(buf + strlen("tree "), oid))
-			die("Invalid SHA1 in commit: %s", command_buf.buf);
+			die(_("invalid SHA1 in commit: %s"), command_buf.buf);
 	}
 
 	free(buf);
@@ -3309,9 +3309,9 @@ static void build_mark_map(struct string_list *from, struct string_list *to)
 	for_each_string_list_item(fromp, from) {
 		top = string_list_lookup(to, fromp->string);
 		if (!fromp->util) {
-			die(_("Missing from marks for submodule '%s'"), fromp->string);
+			die(_("missing from marks for submodule '%s'"), fromp->string);
 		} else if (!top || !top->util) {
-			die(_("Missing to marks for submodule '%s'"), fromp->string);
+			die(_("missing to marks for submodule '%s'"), fromp->string);
 		}
 		build_mark_map_one(fromp->util, top->util);
 	}
@@ -3325,14 +3325,14 @@ static struct object_entry *parse_treeish_dataref(const char **p)
 	if (**p == ':') {	/* <mark> */
 		e = find_mark(marks, parse_mark_ref_space(p));
 		if (!e)
-			die("Unknown mark: %s", command_buf.buf);
+			die(_("unknown mark: %s"), command_buf.buf);
 		oidcpy(&oid, &e->idx.oid);
 	} else {	/* <sha1> */
 		if (parse_mapped_oid_hex(*p, &oid, p))
-			die("Invalid dataref: %s", command_buf.buf);
+			die(_("invalid dataref: %s"), command_buf.buf);
 		e = find_object(&oid);
 		if (*(*p)++ != ' ')
-			die("Missing space after tree-ish: %s", command_buf.buf);
+			die(_("missing space after tree-ish: %s"), command_buf.buf);
 	}
 
 	while (!e || e->type != OBJ_TREE)
@@ -3376,7 +3376,7 @@ static void parse_ls(const char *p, struct branch *b)
 	/* ls SP (<tree-ish> SP)? <path> */
 	if (*p == '"') {
 		if (!b)
-			die("Not in a commit: %s", command_buf.buf);
+			die(_("not in a commit: %s"), command_buf.buf);
 		root = &b->branch_tree;
 	} else {
 		struct object_entry *e = parse_treeish_dataref(&p);
@@ -3439,12 +3439,12 @@ static void parse_alias(void)
 	/* mark ... */
 	parse_mark();
 	if (!next_mark)
-		die(_("Expected 'mark' command, got %s"), command_buf.buf);
+		die(_("expected 'mark' command, got %s"), command_buf.buf);
 
 	/* to ... */
 	memset(&b, 0, sizeof(b));
 	if (!parse_objectish_with_prefix(&b, "to "))
-		die(_("Expected 'to' command, got %s"), command_buf.buf);
+		die(_("expected 'to' command, got %s"), command_buf.buf);
 	e = find_object(&b.oid);
 	assert(e);
 	insert_mark(&marks, next_mark, e);
@@ -3462,7 +3462,7 @@ static void option_import_marks(const char *marks,
 {
 	if (import_marks_file) {
 		if (from_stream)
-			die("Only one import-marks command allowed per stream");
+			die(_("only one import-marks command allowed per stream"));
 
 		/* read previous mark file */
 		if(!import_marks_file_from_stream)
@@ -3486,7 +3486,7 @@ static void option_date_format(const char *fmt)
 	else if (!strcmp(fmt, "now"))
 		whenspec = WHENSPEC_NOW;
 	else
-		die("unknown --date-format argument %s", fmt);
+		die(_("unknown --date-format argument %s"), fmt);
 }
 
 static unsigned long ulong_arg(const char *option, const char *arg)
@@ -3494,7 +3494,7 @@ static unsigned long ulong_arg(const char *option, const char *arg)
 	char *endptr;
 	unsigned long rv = strtoul(arg, &endptr, 0);
 	if (strchr(arg, '-') || endptr == arg || *endptr)
-		die("%s: argument must be a non-negative integer", option);
+		die(_("%s: argument must be a non-negative integer"), option);
 	return rv;
 }
 
@@ -3502,7 +3502,7 @@ static void option_depth(const char *depth)
 {
 	max_depth = ulong_arg("--depth", depth);
 	if (max_depth > MAX_DEPTH)
-		die("--depth cannot exceed %u", MAX_DEPTH);
+		die(_("--depth cannot exceed %u"), MAX_DEPTH);
 }
 
 static void option_active_branches(const char *branches)
@@ -3520,7 +3520,7 @@ static void option_cat_blob_fd(const char *fd)
 {
 	unsigned long n = ulong_arg("--cat-blob-fd", fd);
 	if (n > (unsigned long) INT_MAX)
-		die("--cat-blob-fd cannot exceed %d", INT_MAX);
+		die(_("--cat-blob-fd cannot exceed %d"), INT_MAX);
 	cat_blob_fd = (int) n;
 }
 
@@ -3540,7 +3540,7 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	char *s = xstrdup(arg);
 	char *f = strchr(s, ':');
 	if (!f)
-		die(_("Expected format name:filename for submodule rewrite option"));
+		die(_("expected format name:filename for submodule rewrite option"));
 	*f = '\0';
 	f++;
 	CALLOC_ARRAY(ms, 1);
@@ -3548,7 +3548,7 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	f = prefix_filename(global_prefix, f);
 	fp = fopen(f, "r");
 	if (!fp)
-		die_errno("cannot read '%s'", f);
+		die_errno(_("cannot read '%s'"), f);
 	read_mark_file(&ms, fp, insert_oid_entry);
 	fclose(fp);
 	free(f);
@@ -3565,10 +3565,10 @@ static int parse_one_option(const char *option)
 		if (!git_parse_ulong(option, &v))
 			return 0;
 		if (v < 8192) {
-			warning("max-pack-size is now in bytes, assuming --max-pack-size=%lum", v);
+			warning(_("max-pack-size is now in bytes, assuming --max-pack-size=%lum"), v);
 			v *= 1024 * 1024;
 		} else if (v < 1024 * 1024) {
-			warning("minimum max-pack-size is 1 MiB");
+			warning(_("minimum max-pack-size is 1 MiB"));
 			v = 1024 * 1024;
 		}
 		max_packsize = v;
@@ -3655,23 +3655,23 @@ static int parse_one_feature(const char *feature, int from_stream)
 static void parse_feature(const char *feature)
 {
 	if (seen_data_command)
-		die("Got feature command '%s' after data command", feature);
+		die(_("got feature command '%s' after data command"), feature);
 
 	if (parse_one_feature(feature, 1))
 		return;
 
-	die("This version of fast-import does not support feature %s.", feature);
+	die(_("this version of fast-import does not support feature %s."), feature);
 }
 
 static void parse_option(const char *option)
 {
 	if (seen_data_command)
-		die("Got option command '%s' after data command", option);
+		die(_("got option command '%s' after data command"), option);
 
 	if (parse_one_option(option))
 		return;
 
-	die("This version of fast-import does not support option: %s", option);
+	die(_("this version of fast-import does not support option: %s"), option);
 }
 
 static void git_pack_config(void)
@@ -3715,7 +3715,7 @@ static void parse_argv(void)
 			break;
 
 		if (!skip_prefix(a, "--", &a))
-			die("unknown option %s", a);
+			die(_("unknown option %s"), a);
 
 		if (parse_one_option(a))
 			continue;
@@ -3728,7 +3728,7 @@ static void parse_argv(void)
 			continue;
 		}
 
-		die("unknown option --%s", a);
+		die(_("unknown option --%s"), a);
 	}
 	if (i != global_argc)
 		usage(fast_import_usage);
@@ -3817,7 +3817,7 @@ int cmd_fast_import(int argc,
 		else if (starts_with(command_buf.buf, "option "))
 			/* ignore non-git options*/;
 		else
-			die("Unsupported command: %s", command_buf.buf);
+			die(_("unsupported command: %s"), command_buf.buf);
 
 		if (checkpoint_requested)
 			checkpoint();
@@ -3828,7 +3828,7 @@ int cmd_fast_import(int argc,
 		parse_argv();
 
 	if (require_explicit_termination && feof(stdin))
-		die("stream ends early");
+		die(_("stream ends early"));
 
 	end_packfile();
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 4dc3d645bf..5685cce6fe 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2927,16 +2927,16 @@ test_expect_success 'R: blob appears only once' '
 # The error message when a space is missing not at the
 # end of the line is:
 #
-#   Missing space after ..
+#   missing space after ..
 #
 # or when extra characters come after the mark at the end
 # of the line:
 #
-#   Garbage after ..
+#   garbage after ..
 #
 # or when the dataref is neither "inline " or a known SHA1,
 #
-#   Invalid dataref ..
+#   invalid dataref ..
 #
 test_expect_success 'S: initialize for S tests' '
 	test_tick &&
@@ -3405,15 +3405,15 @@ test_path_fail () {
 
 test_path_base_fail () {
 	local change="$1" prefix="$2" field="$3" suffix="$4"
-	test_path_fail "$change" 'unclosed " in '"$field"          "$prefix" '"hello.c'    "$suffix" "Invalid $field"
-	test_path_fail "$change" "invalid escape in quoted $field" "$prefix" '"hello\xff"' "$suffix" "Invalid $field"
+	test_path_fail "$change" 'unclosed " in '"$field"          "$prefix" '"hello.c'    "$suffix" "invalid $field"
+	test_path_fail "$change" "invalid escape in quoted $field" "$prefix" '"hello\xff"' "$suffix" "invalid $field"
 	test_path_fail "$change" "escaped NUL in quoted $field"    "$prefix" '"hello\000"' "$suffix" "NUL in $field"
 }
 test_path_eol_quoted_fail () {
 	local change="$1" prefix="$2" field="$3"
 	test_path_base_fail "$change" "$prefix" "$field" ''
-	test_path_fail "$change" "garbage after quoted $field" "$prefix" '"hello.c"' 'x' "Garbage after $field"
-	test_path_fail "$change" "space after quoted $field"   "$prefix" '"hello.c"' ' ' "Garbage after $field"
+	test_path_fail "$change" "garbage after quoted $field" "$prefix" '"hello.c"' 'x' "garbage after $field"
+	test_path_fail "$change" "space after quoted $field"   "$prefix" '"hello.c"' ' ' "garbage after $field"
 }
 test_path_eol_fail () {
 	local change="$1" prefix="$2" field="$3"
@@ -3422,8 +3422,8 @@ test_path_eol_fail () {
 test_path_space_fail () {
 	local change="$1" prefix="$2" field="$3"
 	test_path_base_fail "$change" "$prefix" "$field" ' world.c'
-	test_path_fail "$change" "missing space after quoted $field"   "$prefix" '"hello.c"' 'x world.c' "Missing space after $field"
-	test_path_fail "$change" "missing space after unquoted $field" "$prefix" 'hello.c'   ''          "Missing space after $field"
+	test_path_fail "$change" "missing space after quoted $field"   "$prefix" '"hello.c"' 'x world.c' "missing space after $field"
+	test_path_fail "$change" "missing space after unquoted $field" "$prefix" 'hello.c'   ''          "missing space after $field"
 }
 
 test_path_eol_fail   filemodify       'M 100644 :1 ' path
@@ -3820,7 +3820,7 @@ test_expect_success 'X: replace ref that becomes useless is removed' '
 		sed -e s/othername/somename/ tmp >tmp2 &&
 		git fast-import --force <tmp2 2>msgs &&
 
-		grep "Dropping.*since it would point to itself" msgs &&
+		grep "dropping.*since it would point to itself" msgs &&
 		git show-ref >refs &&
 		! grep refs/replace refs
 	)
-- 
2.51.2.617.g2aaa867cd1

