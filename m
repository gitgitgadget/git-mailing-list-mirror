Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93814A4C1
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736084985; cv=none; b=nu334GjrfYRi2GJwmkdrSkDqAFnlPIMm6fTicg51iPN76Xup5wz7vXhWZbtgNAG38Iy/+9p6+Q4eXiJ4EZRcdSt1s6HjJljNSC7gUOLtdatbrWzxVWYjWacdX/C7aWkoEtQYJZMC2rhOGRzXMNXBuRrZh7k1qR4+XB5qHFO3fIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736084985; c=relaxed/simple;
	bh=+7c9w+GpS6mhDuVvUP51QNBmQvWqADOTvknjLXvUIac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REV+U+gm+pVu11IZxgKXPWM0wg249RTL5H5zwmv2WfwTrbcYHg0aYIAqs9L1bBBtoSnPIEpMio+iGOAS0A9xYhE6evWia35/hS40mQ3QwB+uU7R5JWX9W25fmVUESMozY7fU4m805iv+7SxF2UONgu3wEjkFY5Mz/Spg2wWpv8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYfYVbEV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYfYVbEV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2162c0f6a39so199659845ad.0
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 05:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736084982; x=1736689782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qd9PdyPvUdMAp9AL6bTD/L6KHWZAvmW2XCBtNzWrwZw=;
        b=cYfYVbEVf2thGCU+QxHkhX6haxg9MKnUEUSKNDFerbmcdcfPI/VreJB8bcOvTY8+/w
         KkunVh2IvXW/RUT4PF+bZXZkjtxRYeaRgveZMc/707IE8UVTVpfIJEpGmnTS85bf4g9P
         hDDjUCcFCxNe37CSJFFJQFfIC3vkCek45kpaPawFVexapjMTpCHtotM2nkz2JT9Rkd8s
         UqM3y76Zlm1Ntn4pZMQ4opek2sw3No39u34IyCZpH3klCbS/Zq13CPwx9Qzwk8Q0bkVc
         gn6liKhOXNxXk5DnbZIGYcqGsItJwmVWj1v/ACsKSoXjTnrraumyEu4xFGRugKe2h+Qq
         rJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736084982; x=1736689782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd9PdyPvUdMAp9AL6bTD/L6KHWZAvmW2XCBtNzWrwZw=;
        b=cDXkVm0dFN3IpB1NB6I3xjMulpnPaIFUY3xARoivJzHx9eM2wOs4j4dt6+xiMSUxTO
         L5ijNfnU/JeWHxpAEHqFNa3iWLNKr5Dl+86gQ7ydolgkE3NHkqb6uoNfwdu/giQthJ8d
         ShZvFhXqmvk4QjBc53rM9BjwQI7zchYkMNPnrFr1jCSY932LI7X2Y23cM1VPq3DvIwm3
         ME89Rq5KOANfMdMeY15hjD/4D+/dzzRwGTYLyaFhvQ02040jqkzmifuJwE160OmXOv3f
         nD3DVK+LlyrkecAU2gdtxAJIel7dMm+gPySAKXm3MZiUU6BbYGQwXBD47QPbuxbd+Yx2
         6Hhw==
X-Gm-Message-State: AOJu0YxjeMyZlhEMku61m9Js/79+VBexxdIeTYVfjbtIvV3x2SaPW9Qj
	p0ykTE8EGzf/uUDrJUnBd2sSxcBf8GEXSU2b8eFhfTt7j7gOZ0WfpNgQww==
X-Gm-Gg: ASbGnctplDQeuQnGzg4qGLL9DKjik3dh0NvxldLkqL22YUHti/GOaPzO6eQjjCFJD8/
	2b8ARawrEF1n54wdpYa7D2H7cxKD9JH5TTbarxAwyhYozQHrVUqM0r8g0xSdEpeWKC1/d4tfPf9
	qGqmS4Lt50bpWGh1/aoSUACYh2Up2OKlbs0XN2Ml1G2aYqRHtU71a0YirzFrzrieTFvcUoY1u7K
	L6vCoLwRu8GNnkYJ6AWbb5HPOwITNJ1k8g=
X-Google-Smtp-Source: AGHT+IGdaz95OlT7fcb90XbrMqZDLXp2XplI00a+IdpNjFORVzGX8a6+0sIrrnFLsYv67kW2nGly9Q==
X-Received: by 2002:a05:6a00:8009:b0:728:f266:cb09 with SMTP id d2e1a72fcca58-72aa9b03a0bmr95426399b3a.13.1736084981818;
        Sun, 05 Jan 2025 05:49:41 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90e439sm29650168b3a.178.2025.01.05.05.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 05:49:41 -0800 (PST)
Date: Sun, 5 Jan 2025 21:49:37 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/10] packed-backend: add "packed-refs" header consistency
 check
Message-ID: <Z3qN8U2VbZBnUSWj@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qNUizvHJLgMx1y@ArchLinux>

In "packed-backend.c::create_snapshot", if there is a header (the line
which starts with '#'), we will check whether the line starts with "#
pack-refs with:". As we are going to implement the header consistency
check, we should port this check into "packed_fsck".

However, the above check is not enough, this is because "git pack-refs"
will always write "PACKED_REFS_HEADER" which is a constant string to the
"packed-refs" file. So, we should check the following things for the
header.

1. If the header does not exist, we may report an error to the user
   because it should exist, but we do allow no header in "packed-refs"
   file. So, create a new fsck message "packedRefMissingHeader(INFO)" to
   warn the user and also keep compatibility.
2. If the header content does not start with "# packed-ref with:", we
   should report an error just like what "create_snapshot" does. So,
   create a new fsck message "badPackedRefHeader(ERROR)" for this.
3. If the header content is not the same as the constant string
   "PACKED_REFS_HEADER", ideally, we should report an error to the user.
   However, we allow other contents as long as the header content starts
   with "# packed-ref with:". To keep compatibility, create a new fsck
   message "unknownPackedRefHeader(INFO)" to warn about this. We may
   tighten this rule in the future.

In order to achieve above checks, read the "packed-refs" file via
"strbuf_read_file". Like what "create_snapshot" and other functions do,
we could split the line by finding the next newline in the buf. If we
cannot find a newline, this is an error.

So, create a function "packed_fsck_ref_next_line" to find the next
newline and if there is no such newline, use
"packedRefEntryNotTerminated(INFO)" to report an error to the user.

Then, parse the first line to apply the above three checks. Update the
test to excise the code.

However, when adding the new test for a bad header, the program will
still die in the "create_snapshot" method. This is because we have
checked the files-backend firstly and we use "parse_object" to check
whether the object exists and whether the type is correct. This function
will eventually call "create_snapshot" and "next_record" method, if
there is something wrong with packed-backend, the program just dies.

It's bad to just die the program because we want to report the problems
as many as possible. We should avoid checking object and its type when
packed-backend is broken. So, we should first check the consistency of
the packed-backend then for files-backend.

Add a new flag "safe_object_check" in "fsck_options", when there is
anything wrong with the parsing process, set this flag to 0 to avoid
checking objects in the later checks.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  16 ++++++
 fsck.h                        |   6 ++
 refs/files-backend.c          |   6 +-
 refs/packed-backend.c         | 105 ++++++++++++++++++++++++++++++++++
 t/t0602-reffiles-fsck.sh      |  44 ++++++++++++++
 5 files changed, 174 insertions(+), 3 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index b14bc44ca4..34375a3143 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -16,6 +16,10 @@
 `badObjectSha1`::
 	(ERROR) An object has a bad sha1.
 
+`badPackedRefHeader`::
+	(ERROR) The "packed-refs" file contains an invalid
+	header.
+
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
@@ -176,6 +180,13 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`packedRefEntryNotTerminated`::
+	(ERROR) The "packed-refs" file contains an entry that is
+	not terminated by a newline.
+
+`packedRefMissingHeader`::
+	(INFO) The "packed-refs" file does not contain the header.
+
 `refMissingNewline`::
 	(INFO) A loose ref that does not end with newline(LF). As
 	valid implementations of Git never created such a loose ref
@@ -208,6 +219,11 @@
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
+`unknownPackedRefHeader`::
+	(INFO) The "packed-refs" header starts with "# pack-refs with:"
+	but the remaining content is not the same as what `git pack-refs`
+	would write.
+
 `unknownType`::
 	(ERROR) Found an unknown object type.
 
diff --git a/fsck.h b/fsck.h
index a44c231a5f..026ad1d537 100644
--- a/fsck.h
+++ b/fsck.h
@@ -30,6 +30,7 @@ enum fsck_msg_type {
 	FUNC(BAD_EMAIL, ERROR) \
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
+	FUNC(BAD_PACKED_REF_HEADER, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
@@ -53,6 +54,7 @@ enum fsck_msg_type {
 	FUNC(MISSING_TYPE, ERROR) \
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
 	FUNC(MULTIPLE_AUTHORS, ERROR) \
+	FUNC(PACKED_REF_ENTRY_NOT_TERMINATED, ERROR) \
 	FUNC(TREE_NOT_SORTED, ERROR) \
 	FUNC(UNKNOWN_TYPE, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
@@ -90,6 +92,8 @@ enum fsck_msg_type {
 	FUNC(REF_MISSING_NEWLINE, INFO) \
 	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO) \
 	FUNC(TRAILING_REF_CONTENT, INFO) \
+	FUNC(UNKNOWN_PACKED_REF_HEADER, INFO) \
+	FUNC(PACKED_REF_MISSING_HEADER, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
 
@@ -163,6 +167,7 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict;
 	unsigned verbose;
+	int safe_object_check;
 	enum fsck_msg_type *msg_type;
 	struct oidset skip_oids;
 	struct oidset gitmodules_found;
@@ -198,6 +203,7 @@ struct fsck_options {
 }
 #define FSCK_REFS_OPTIONS_DEFAULT { \
 	.error_func = fsck_refs_error_function, \
+	.safe_object_check = 1, \
 }
 
 /* descend in all linked child objects
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0a4912c009..66eae36184 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3599,7 +3599,7 @@ static int files_fsck_refs_oid(struct fsck_options *o,
 	struct object *obj;
 	int ret = 0;
 
-	if (is_promisor_object(ref_store->repo, oid))
+	if (!o->safe_object_check || is_promisor_object(ref_store->repo, oid))
 		return 0;
 
 	obj = parse_object(ref_store->repo, oid);
@@ -3819,8 +3819,8 @@ static int files_fsck(struct ref_store *ref_store,
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
 
-	return files_fsck_refs(ref_store, o, wt) |
-	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt);
+	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt) |
+	       files_fsck_refs(ref_store, o, wt);
 }
 
 struct ref_storage_be refs_be_files = {
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index d9eb2f8b71..3b11abe5f8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1748,12 +1748,100 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
+static int packed_fsck_ref_next_line(struct fsck_options *o,
+				     int line_number, const char *start,
+				     const char *eof, const char **eol)
+{
+	int ret = 0;
+
+	*eol = memchr(start, '\n', eof - start);
+	if (!*eol) {
+		struct strbuf packed_entry = STRBUF_INIT;
+		struct fsck_ref_report report = { 0 };
+
+		strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
+		report.path = packed_entry.buf;
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_PACKED_REF_ENTRY_NOT_TERMINATED,
+				      "'%.*s' is not terminated with a newline",
+				      (int)(eof - start), start);
+
+		/*
+		 * There is no newline but we still want to parse it to the end of
+		 * the buffer.
+		 */
+		*eol = eof;
+		strbuf_release(&packed_entry);
+	}
+
+	return ret;
+}
+
+static int packed_fsck_ref_header(struct fsck_options *o, const char *start, const char *eol)
+{
+	const char *err_fmt = NULL;
+	int fsck_msg_id = -1;
+
+	if (!starts_with(start, "# pack-refs with:")) {
+		err_fmt = "'%.*s' does not start with '# pack-refs with:'";
+		fsck_msg_id = FSCK_MSG_BAD_PACKED_REF_HEADER;
+	} else if (strncmp(start, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER))) {
+		err_fmt = "'%.*s' is not the official packed-refs header";
+		fsck_msg_id = FSCK_MSG_UNKNOWN_PACKED_REF_HEADER;
+	}
+
+	if (err_fmt && fsck_msg_id >= 0) {
+		struct fsck_ref_report report = { 0 };
+		report.path = "packed-refs.header";
+
+		return fsck_report_ref(o, &report, fsck_msg_id, err_fmt,
+				       (int)(eol - start), start);
+
+	}
+
+	return 0;
+}
+
+static int packed_fsck_ref_content(struct fsck_options *o,
+				   const char *start, const char *eof)
+{
+	int line_number = 1;
+	const char *eol;
+	int ret = 0;
+
+	ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
+	if (*start == '#') {
+		ret |= packed_fsck_ref_header(o, start, eol);
+
+		start = eol + 1;
+		line_number++;
+	} else {
+		struct fsck_ref_report report = { 0 };
+		report.path = "packed-refs";
+
+		ret |= fsck_report_ref(o, &report,
+				       FSCK_MSG_PACKED_REF_MISSING_HEADER,
+				       "missing header line");
+	}
+
+	/*
+	 * If there is anything wrong during the parsing of the "packed-refs"
+	 * file, we should not check the object of the refs.
+	 */
+	if (ret)
+		o->safe_object_check = 0;
+
+
+	return ret;
+}
+
 static int packed_fsck(struct ref_store *ref_store,
 		       struct fsck_options *o,
 		       struct worktree *wt)
 {
 	struct packed_ref_store *refs = packed_downcast(ref_store,
 							REF_STORE_READ, "fsck");
+	struct strbuf packed_ref_content = STRBUF_INIT;
 	struct stat st;
 	int ret = 0;
 
@@ -1779,7 +1867,24 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
+	if (strbuf_read_file(&packed_ref_content, refs->path, 0) < 0) {
+		/*
+		 * Although we have checked that the file exists, there is a possibility
+		 * that it has been removed between the lstat() and the read attempt by
+		 * another process. In that case, we should not report an error.
+		 */
+		if (errno == ENOENT)
+			goto cleanup;
+
+		ret = error_errno("could not read %s", refs->path);
+		goto cleanup;
+	}
+
+	ret = packed_fsck_ref_content(o, packed_ref_content.buf,
+				      packed_ref_content.buf + packed_ref_content.len);
+
 cleanup:
+	strbuf_release(&packed_ref_content);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 307f94a3ca..6c729e749a 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -646,4 +646,48 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
 	test_cmp expect err
 '
 
+test_expect_success 'packed-refs header should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cd repo &&
+	test_commit default &&
+
+	git refs verify 2>err &&
+	test_must_be_empty err &&
+
+	printf "$(git rev-parse main) refs/heads/main\n" >.git/packed-refs &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: packed-refs: packedRefMissingHeader: missing header line
+	EOF
+	rm .git/packed-refs &&
+	test_cmp expect err &&
+
+	for bad_header in "# pack-refs wit: peeled fully-peeled sorted " \
+			  "# pack-refs with traits: peeled fully-peeled sorted " \
+			  "# pack-refs with a: peeled fully-peeled"
+	do
+		printf "%s\n" "$bad_header" >.git/packed-refs &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs.header: badPackedRefHeader: '\''$bad_header'\'' does not start with '\''# pack-refs with:'\''
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err || return 1
+	done &&
+
+	for unknown_header in "# pack-refs with: peeled fully-peeled sorted garbage" \
+			      "# pack-refs with: peeled" \
+			      "# pack-refs with: peeled peeled-fully sort"
+	do
+		printf "%s\n" "$unknown_header" >.git/packed-refs &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: packed-refs.header: unknownPackedRefHeader: '\''$unknown_header'\'' is not the official packed-refs header
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err || return 1
+	done
+'
+
 test_done
-- 
2.47.1

