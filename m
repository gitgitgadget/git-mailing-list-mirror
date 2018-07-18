Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8621F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbeGRQvu (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45122 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731853AbeGRQvt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id q5-v6so4578608ljh.12
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iiC8oUeLEF+qDdQc0k9/bDtaZA4FKvUP1Z6j3cD+0p0=;
        b=gv6qIRFYxm0XdetUjqgigTT2LXpWsZCLJmQEQx5AjMuS+hM5jQ7S7mxgDRgmzOQcIV
         Cah0zZwK3NvKcizVIAo2dFZtsqwt6SDviY1EBczRYW7Oci96BldMiKqtNe3PdmYhJaxk
         IGLBtFRfyhgxF4VGUE73Y7ans+8pF5RoXzWLUVM15qgkHTwidNoxV3AfM4dHWUg5Tjrq
         8BvzY5iF3VZsiI6S6+7iilG3xVYOb7EKRaTqtSZ1tmI+EYJ+leTE/vi32mwml5ncDj/4
         IVia0C5mMjfkssfV8G8Nd8sC6yJaWv8+NWJxRpGzXFmhLCoRqZjcsbrH9n1TEft9Rq8t
         KiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iiC8oUeLEF+qDdQc0k9/bDtaZA4FKvUP1Z6j3cD+0p0=;
        b=rpXXHZKOJMtudVCzR9nXPQtfH/Y4RPSxUFNKSUrpcka42lJPxy4d6TxYO/ToBM6Q1y
         Fg4ujuwdgWMjvafNZHTYc73rPtbTDL8KUB32OE8kusvznI1LNsYZ0Py1yYMD/OCVhPO9
         nTZrb9jlkH6hNe9Ci9IPoyItV7hTOyIFs1eCjKJHc1wcwM8xA0jFcfTQ0ZBy/hNvK8S0
         pLAYlM875JZWrqbPyLzWBN2gcAG0ZtmKxK2am7JMNOfxkWsLUQrCPRtDsfOeJywjCDVN
         erMl5WFRNPJoXDeq10/HpJFhnpg3mNddUVDIASDQlxB/6JP5ggXvT0pIni5k36UzEy4A
         N1ZA==
X-Gm-Message-State: AOUpUlEX/rLuKTsjWysqXrlBqVYFZlmPIRDnPfxyyHzlJEa1q4s4xPPY
        avGdLhaXhxaNkGI0yhfmLUvLRw==
X-Google-Smtp-Source: AAOMgpfXPTGSdXUWKoQq6VRwjq1xzJKQRpuDarKMfzFQotPAIXFFxP6+/LlxooLrytlf/BpA9Vr1HQ==
X-Received: by 2002:a2e:118f:: with SMTP id 15-v6mr5096379ljr.38.1531930391387;
        Wed, 18 Jul 2018 09:13:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:13:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 21/23] sha1-file.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:59 +0200
Message-Id: <20180718161101.19765-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-file.c | 104 ++++++++++++++++++++++++++--------------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index ed7ac73fa9..92c27583db 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -378,8 +378,8 @@ static int alt_odb_usable(struct raw_object_store *o,
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path->buf)) {
-		error("object directory %s does not exist; "
-		      "check .git/objects/info/alternates",
+		error(_("object directory %s does not exist; "
+			"check .git/objects/info/alternates"),
 		      path->buf);
 		return 0;
 	}
@@ -429,7 +429,7 @@ static int link_alt_odb_entry(struct repository *r, const char *entry,
 	strbuf_addstr(&pathbuf, entry);
 
 	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
-		error("unable to normalize alternate object path: %s",
+		error(_("unable to normalize alternate object path: %s"),
 		      pathbuf.buf);
 		strbuf_release(&pathbuf);
 		return -1;
@@ -500,14 +500,14 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		return;
 
 	if (depth > 5) {
-		error("%s: ignoring alternate object stores, nesting too deep.",
+		error(_("%s: ignoring alternate object stores, nesting too deep"),
 				relative_base);
 		return;
 	}
 
 	strbuf_add_absolute_path(&objdirbuf, r->objects->objectdir);
 	if (strbuf_normalize_path(&objdirbuf) < 0)
-		die("unable to normalize object directory: %s",
+		die(_("unable to normalize object directory: %s"),
 		    objdirbuf.buf);
 
 	while (*alt) {
@@ -562,7 +562,7 @@ void add_to_alternates_file(const char *reference)
 	hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR);
 	out = fdopen_lock_file(&lock, "w");
 	if (!out)
-		die_errno("unable to fdopen alternates lockfile");
+		die_errno(_("unable to fdopen alternates lockfile"));
 
 	in = fopen(alts, "r");
 	if (in) {
@@ -580,14 +580,14 @@ void add_to_alternates_file(const char *reference)
 		fclose(in);
 	}
 	else if (errno != ENOENT)
-		die_errno("unable to read alternates file");
+		die_errno(_("unable to read alternates file"));
 
 	if (found) {
 		rollback_lock_file(&lock);
 	} else {
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(&lock))
-			die_errno("unable to move new alternates file into place");
+			die_errno(_("unable to move new alternates file into place"));
 		if (the_repository->objects->alt_odb_tail)
 			link_alt_odb_entries(the_repository, reference,
 					     '\n', NULL, 0);
@@ -778,7 +778,7 @@ static void mmap_limit_check(size_t length)
 			limit = SIZE_MAX;
 	}
 	if (length > limit)
-		die("attempting to mmap %"PRIuMAX" over limit %"PRIuMAX,
+		die(_("attempting to mmap %"PRIuMAX" over limit %"PRIuMAX),
 		    (uintmax_t)length, (uintmax_t)limit);
 }
 
@@ -803,7 +803,7 @@ void *xmmap(void *start, size_t length,
 {
 	void *ret = xmmap_gently(start, length, prot, flags, fd, offset);
 	if (ret == MAP_FAILED)
-		die_errno("mmap failed");
+		die_errno(_("mmap failed"));
 	return ret;
 }
 
@@ -970,7 +970,7 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 			*size = xsize_t(st.st_size);
 			if (!*size) {
 				/* mmap() is forbidden on empty files */
-				error("object file %s is empty", path);
+				error(_("object file %s is empty"), path);
 				return NULL;
 			}
 			map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -1090,9 +1090,9 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
 	}
 
 	if (status < 0)
-		error("corrupt loose object '%s'", sha1_to_hex(sha1));
+		error(_("corrupt loose object '%s'"), sha1_to_hex(sha1));
 	else if (stream->avail_in)
-		error("garbage at end of loose object '%s'",
+		error(_("garbage at end of loose object '%s'"),
 		      sha1_to_hex(sha1));
 	free(buf);
 	return NULL;
@@ -1134,7 +1134,7 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE) && (type < 0))
 		type = 0;
 	else if (type < 0)
-		die("invalid object type");
+		die(_("invalid object type"));
 	if (oi->typep)
 		*oi->typep = type;
 
@@ -1216,19 +1216,19 @@ static int sha1_loose_object_info(struct repository *r,
 		*oi->disk_sizep = mapsize;
 	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
 		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
-			status = error("unable to unpack %s header with --allow-unknown-type",
+			status = error(_("unable to unpack %s header with --allow-unknown-type"),
 				       sha1_to_hex(sha1));
 	} else if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
-		status = error("unable to unpack %s header",
+		status = error(_("unable to unpack %s header"),
 			       sha1_to_hex(sha1));
 	if (status < 0)
 		; /* Do nothing */
 	else if (hdrbuf.len) {
 		if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
-			status = error("unable to parse %s header with --allow-unknown-type",
+			status = error(_("unable to parse %s header with --allow-unknown-type"),
 				       sha1_to_hex(sha1));
 	} else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
-		status = error("unable to parse %s header", sha1_to_hex(sha1));
+		status = error(_("unable to parse %s header"), sha1_to_hex(sha1));
 
 	if (status >= 0 && oi->contentp) {
 		*oi->contentp = unpack_sha1_rest(&stream, hdr,
@@ -1419,19 +1419,19 @@ void *read_object_file_extended(const struct object_id *oid,
 		return data;
 
 	if (errno && errno != ENOENT)
-		die_errno("failed to read object %s", oid_to_hex(oid));
+		die_errno(_("failed to read object %s"), oid_to_hex(oid));
 
 	/* die if we replaced an object with one that does not exist */
 	if (repl != oid)
-		die("replacement %s not found for %s",
+		die(_("replacement %s not found for %s"),
 		    oid_to_hex(repl), oid_to_hex(oid));
 
 	if (!stat_sha1_file(the_repository, repl->hash, &st, &path))
-		die("loose object %s (stored in %s) is corrupt",
+		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), path);
 
 	if ((p = has_packed_and_bad(repl->hash)) != NULL)
-		die("packed object %s (stored in %s) is corrupt",
+		die(_("packed object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), p->pack_name);
 
 	return NULL;
@@ -1533,21 +1533,21 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 	unlink_or_warn(tmpfile);
 	if (ret) {
 		if (ret != EEXIST) {
-			return error_errno("unable to write sha1 filename %s", filename);
+			return error_errno(_("unable to write sha1 filename %s"), filename);
 		}
 		/* FIXME!!! Collision check here ? */
 	}
 
 out:
 	if (adjust_shared_perm(filename))
-		return error("unable to set permission to '%s'", filename);
+		return error(_("unable to set permission to '%s'"), filename);
 	return 0;
 }
 
 static int write_buffer(int fd, const void *buf, size_t len)
 {
 	if (write_in_full(fd, buf, len) < 0)
-		return error_errno("file write error");
+		return error_errno(_("file write error"));
 	return 0;
 }
 
@@ -1566,7 +1566,7 @@ static void close_sha1_file(int fd)
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
 	if (close(fd) != 0)
-		die_errno("error when closing sha1 file");
+		die_errno(_("error when closing sha1 file"));
 }
 
 /* Size of directory component, including the ending '/' */
@@ -1632,9 +1632,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
 		if (errno == EACCES)
-			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
+			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
 		else
-			return error_errno("unable to create temporary file");
+			return error_errno(_("unable to create temporary file"));
 	}
 
 	/* Set it up */
@@ -1658,21 +1658,21 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		ret = git_deflate(&stream, Z_FINISH);
 		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
-			die("unable to write sha1 file");
+			die(_("unable to write sha1 file"));
 		stream.next_out = compressed;
 		stream.avail_out = sizeof(compressed);
 	} while (ret == Z_OK);
 
 	if (ret != Z_STREAM_END)
-		die("unable to deflate new object %s (%d)", oid_to_hex(oid),
+		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
 		    ret);
 	ret = git_deflate_end_gently(&stream);
 	if (ret != Z_OK)
-		die("deflateEnd on object %s failed (%d)", oid_to_hex(oid),
+		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
 	the_hash_algo->final_fn(parano_oid.hash, &c);
 	if (oidcmp(oid, &parano_oid) != 0)
-		die("confused by unstable object source data for %s",
+		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
 	close_sha1_file(fd);
@@ -1682,7 +1682,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		utb.actime = mtime;
 		utb.modtime = mtime;
 		if (utime(tmp_file.buf, &utb) < 0)
-			warning_errno("failed utime() on %s", tmp_file.buf);
+			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
 	return finalize_object_file(tmp_file.buf, filename.buf);
@@ -1757,7 +1757,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 		return 0;
 	buf = read_object(oid->hash, &type, &len);
 	if (!buf)
-		return error("cannot read sha1_file for %s", oid_to_hex(oid));
+		return error(_("cannot read sha1_file for %s"), oid_to_hex(oid));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), len) + 1;
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime);
 	free(buf);
@@ -1802,7 +1802,7 @@ static void check_commit(const void *buf, size_t size)
 	struct commit c;
 	memset(&c, 0, sizeof(c));
 	if (parse_commit_buffer(&c, buf, size, 0))
-		die("corrupt commit");
+		die(_("corrupt commit"));
 }
 
 static void check_tag(const void *buf, size_t size)
@@ -1810,7 +1810,7 @@ static void check_tag(const void *buf, size_t size)
 	struct tag t;
 	memset(&t, 0, sizeof(t));
 	if (parse_tag_buffer(&t, buf, size))
-		die("corrupt tag");
+		die(_("corrupt tag"));
 }
 
 static int index_mem(struct object_id *oid, void *buf, size_t size,
@@ -1903,10 +1903,10 @@ static int index_core(struct object_id *oid, int fd, size_t size,
 		char *buf = xmalloc(size);
 		ssize_t read_result = read_in_full(fd, buf, size);
 		if (read_result < 0)
-			ret = error_errno("read error while indexing %s",
+			ret = error_errno(_("read error while indexing %s"),
 					  path ? path : "<unknown>");
 		else if (read_result != size)
-			ret = error("short read while indexing %s",
+			ret = error(_("short read while indexing %s"),
 				    path ? path : "<unknown>");
 		else
 			ret = index_mem(oid, buf, size, type, path, flags);
@@ -1977,7 +1977,7 @@ int index_path(struct object_id *oid, const char *path, struct stat *st, unsigne
 		if (fd < 0)
 			return error_errno("open(\"%s\")", path);
 		if (index_fd(oid, fd, st, OBJ_BLOB, path, flags) < 0)
-			return error("%s: failed to insert into database",
+			return error(_("%s: failed to insert into database"),
 				     path);
 		break;
 	case S_IFLNK:
@@ -1986,13 +1986,13 @@ int index_path(struct object_id *oid, const char *path, struct stat *st, unsigne
 		if (!(flags & HASH_WRITE_OBJECT))
 			hash_object_file(sb.buf, sb.len, blob_type, oid);
 		else if (write_object_file(sb.buf, sb.len, blob_type, oid))
-			rc = error("%s: failed to insert into database", path);
+			rc = error(_("%s: failed to insert into database"), path);
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
 		return resolve_gitlink_ref(path, "HEAD", oid);
 	default:
-		return error("%s: unsupported file type", path);
+		return error(_("%s: unsupported file type"), path);
 	}
 	return rc;
 }
@@ -2016,9 +2016,9 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect)
 {
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
 	if (type < 0)
-		die("%s is not a valid object", oid_to_hex(oid));
+		die(_("%s is not a valid object"), oid_to_hex(oid));
 	if (type != expect)
-		die("%s is not a valid '%s' object", oid_to_hex(oid),
+		die(_("%s is not a valid '%s' object"), oid_to_hex(oid),
 		    type_name(expect));
 }
 
@@ -2045,7 +2045,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	dir = opendir(path->buf);
 	if (!dir) {
 		if (errno != ENOENT)
-			r = error_errno("unable to open %s", path->buf);
+			r = error_errno(_("unable to open %s"), path->buf);
 		strbuf_setlen(path, origlen);
 		return r;
 	}
@@ -2202,18 +2202,18 @@ static int check_stream_sha1(git_zstream *stream,
 	git_inflate_end(stream);
 
 	if (status != Z_STREAM_END) {
-		error("corrupt loose object '%s'", sha1_to_hex(expected_sha1));
+		error(_("corrupt loose object '%s'"), sha1_to_hex(expected_sha1));
 		return -1;
 	}
 	if (stream->avail_in) {
-		error("garbage at end of loose object '%s'",
+		error(_("garbage at end of loose object '%s'"),
 		      sha1_to_hex(expected_sha1));
 		return -1;
 	}
 
 	the_hash_algo->final_fn(real_sha1, &c);
 	if (hashcmp(expected_sha1, real_sha1)) {
-		error("sha1 mismatch for %s (expected %s)", path,
+		error(_("sha1 mismatch for %s (expected %s)"), path,
 		      sha1_to_hex(expected_sha1));
 		return -1;
 	}
@@ -2237,18 +2237,18 @@ int read_loose_object(const char *path,
 
 	map = map_sha1_file_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
-		error_errno("unable to mmap %s", path);
+		error_errno(_("unable to mmap %s"), path);
 		goto out;
 	}
 
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
-		error("unable to unpack header of %s", path);
+		error(_("unable to unpack header of %s"), path);
 		goto out;
 	}
 
 	*type = parse_sha1_header(hdr, size);
 	if (*type < 0) {
-		error("unable to parse header of %s", path);
+		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
 		goto out;
 	}
@@ -2259,13 +2259,13 @@ int read_loose_object(const char *path,
 	} else {
 		*contents = unpack_sha1_rest(&stream, hdr, *size, expected_oid->hash);
 		if (!*contents) {
-			error("unable to unpack contents of %s", path);
+			error(_("unable to unpack contents of %s"), path);
 			git_inflate_end(&stream);
 			goto out;
 		}
 		if (check_object_signature(expected_oid, *contents,
 					 *size, type_name(*type))) {
-			error("sha1 mismatch for %s (expected %s)", path,
+			error(_("sha1 mismatch for %s (expected %s)"), path,
 			      oid_to_hex(expected_oid));
 			free(*contents);
 			goto out;
-- 
2.18.0.rc2.476.g39500d3211

