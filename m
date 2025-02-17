Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4EC22257C
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806099; cv=none; b=bsZE2bFgl4zyyogkCfCXFVbAcs5H/eaVikAq8L417gQ7zN05c/nxZY34edcxaW2FYdlafAC4TKGyb2hhjHo10A2XTCqUzHWaIpxfU44vcb9Ed8OpNJo4hg/lwiuKb41e6tDQ/JmyJNnwuuzBPcHcyVoNqIDmnZqWu6cgV+lZU/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806099; c=relaxed/simple;
	bh=7dNOLxWCb8ykdgtaCtHWRsjQeO5dzLOXQrOmsXRx8dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmdoNQ4Ta0AWrqk7szeW4DaDpaJJeVOqgN7hi5gtPlWec3AbncrjoK758RPG2DLkRR5+QYAwk2Px+OFN+69jz7UuDmyXgs+qLgzs1QvMHyY/SP4oy8bE+KdbtoBHb716TziTt7Oe+m/foD3gdcTBXSkjb/pQ4WQrf0IepLENqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwTWUJZX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwTWUJZX"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc042c9290so6814574a91.0
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 07:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739806095; x=1740410895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/IUPvICLCebyLENmuE1P9QnApzO632nHgtszA1BhbE=;
        b=YwTWUJZX5uCuEDn2CJlpo2eCYuihFS8+IIUBMoPiEclMd3JPg4qg+5gIaHWOSsOVov
         QUdDBwFir4d5YZCISxeG/NpTzCsPB50oiRlEpYUPxzK0jWKUklF+SSRSZacWCcn/yD5Q
         mSVrDTS4oIKYunI7f/YGK2jQ7uS5lk6s/eitXA0SZf9jOACGa9LOmgY5pGkhl+rxWmaK
         AoYQkzvyaseehwj7ytmV9Q3twA3mGubv3WxbXQOnZoU7qmRUp5nTbsJVPPrh5FUWwri4
         b1N7Ou7PyxpmeFMoIWRqp5yLnHwEQtnCmKxKODKih15ikRmBCkhe5AhxzEzSI5mT2Mw5
         Gv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739806095; x=1740410895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/IUPvICLCebyLENmuE1P9QnApzO632nHgtszA1BhbE=;
        b=XXK2JQNaLWXuphTIrHssmFYclGldg2/JGehLqRNgYPyz+FpQnz77QqarAGjg7p1X5p
         SIV+IHpeKg7F8atHEL37fD+W4REeyTVyKumaNyxYdZC/mvbXYx5Y7wPgY/GOaJu2LCtG
         om0gKM/b3UiRwxB7y+T9Nre1DLf4OYlfhRtvIwca+OYvoXNIg5ByPFZ0YHMZRUGSW+tL
         Oz3SUxyHwKIUCO8slL7fFzrZH2k6p8Ssc65dVqV8sJ32R+cBXUklqgyZ34uHhsAAz4NH
         L7FM6TmLenN9URtVqYgFLcyPA0AO2zcm4gCdsCfZo5PhyTJ2eTC7r8pV8eMF0lVxF9Kg
         6NEg==
X-Gm-Message-State: AOJu0Yyp9hyb4mEFcWtxDgntIFYhOoJfr15Sjn+ZNyD4sZXqPGjCre0k
	Dx4q2BY6ov+naZNby90LawglLiRMiRQPS6Kfm9D59hDehwtfnnvQnCj+6Q==
X-Gm-Gg: ASbGncvjlLdF/L/nftzPHR3wLryzq4yIh0owXXvP6c/3mRSiKUGkHK2hP16OAOOMddw
	+P6cuKB9CZr2ICOAHxNBmeFNqbNPF7DWDwt8PuIdYk5KsGtEdsxmECxnDuEFOVj1+QNVFkaw8M9
	cFwgNJ+CWu+rOCQGHDJyDxTpy1+ruXcIxRBSyZAYY8veoyj00eJQJetj5RsZIEMrT5lZjmghxwR
	JwoZZqSR2PMaduZS+Y5hSBbt2aPjTG98eCdCqSTWMvZq9yqyG3hlPPRrWCOsM3xwyPa7tDGBiwe
	JZ3pU7z3lMo=
X-Google-Smtp-Source: AGHT+IEvgj8JGcOg0xuzPgqCJaDaO5O0r0/lZ0zuYRqTT8I2ytqDN9c7ny25cFY58AKBU07jvSSyYA==
X-Received: by 2002:a17:90a:d604:b0:2f2:a664:df19 with SMTP id 98e67ed59e1d1-2fc40d13ed9mr17466224a91.7.1739806095038;
        Mon, 17 Feb 2025 07:28:15 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fc13b913easm7916397a91.39.2025.02.17.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:28:14 -0800 (PST)
Date: Mon, 17 Feb 2025 23:28:12 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 7/8] packed-backend: check whether the "packed-refs" is
 sorted
Message-ID: <Z7NVjOW0dodrj2Bo@ArchLinux>
References: <Z7NU5fZfc8vfSvZ0@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NU5fZfc8vfSvZ0@ArchLinux>

When there is a "sorted" trait in the header of the "packed-refs" file,
it means that each entry is sorted increasingly by comparing the
refname. We should add checks to verify whether the "packed-refs" is
sorted in this case.

Update the "packed_fsck_ref_header" to know whether there is a "sorted"
trail in the header. It may seem that we could record all refnames
during the parsing process and then compare later. However, this is not
a good design due to the following reasons:

1. Because we need to store the state across the whole checking
   lifetime, we would consume a lot of memory if there are many entries
   in the "packed-refs" file.
2. We cannot reuse the existing compare function "cmp_packed_ref_records"
   which cause repetition.

Because "cmp_packed_ref_records" needs an extra parameter "struct
snaphost", extract the common part into a new function
"cmp_packed_ref_records" to reuse this function to compare.

Then, create a new function "packed_fsck_ref_sorted" to parse the file
again and user the new fsck message "packedRefUnsorted(ERROR)" to report
to the user if the file is not sorted.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.adoc |   3 +
 fsck.h                         |   1 +
 refs/packed-backend.c          | 118 ++++++++++++++++++++++++++++-----
 t/t0602-reffiles-fsck.sh       |  87 ++++++++++++++++++++++++
 4 files changed, 192 insertions(+), 17 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 02a7bf0503..9601fff228 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -187,6 +187,9 @@
 	(ERROR) The "packed-refs" file contains an entry that is
 	not terminated by a newline.
 
+`packedRefUnsorted`::
+	(ERROR) The "packed-refs" file is not sorted.
+
 `refMissingNewline`::
 	(INFO) A loose ref that does not end with newline(LF). As
 	valid implementations of Git never created such a loose ref
diff --git a/fsck.h b/fsck.h
index 14d70f6653..19f3cb2773 100644
--- a/fsck.h
+++ b/fsck.h
@@ -56,6 +56,7 @@ enum fsck_msg_type {
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
 	FUNC(MULTIPLE_AUTHORS, ERROR) \
 	FUNC(PACKED_REF_ENTRY_NOT_TERMINATED, ERROR) \
+	FUNC(PACKED_REF_UNSORTED, ERROR) \
 	FUNC(TREE_NOT_SORTED, ERROR) \
 	FUNC(UNKNOWN_TYPE, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c7138aefff..ae04d8ae80 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -300,14 +300,9 @@ struct snapshot_record {
 	size_t len;
 };
 
-static int cmp_packed_ref_records(const void *v1, const void *v2,
-				  void *cb_data)
-{
-	const struct snapshot *snapshot = cb_data;
-	const struct snapshot_record *e1 = v1, *e2 = v2;
-	const char *r1 = e1->start + snapshot_hexsz(snapshot) + 1;
-	const char *r2 = e2->start + snapshot_hexsz(snapshot) + 1;
 
+static int cmp_packed_refname(const char *r1, const char *r2)
+{
 	while (1) {
 		if (*r1 == '\n')
 			return *r2 == '\n' ? 0 : -1;
@@ -322,6 +317,17 @@ static int cmp_packed_ref_records(const void *v1, const void *v2,
 	}
 }
 
+static int cmp_packed_ref_records(const void *v1, const void *v2,
+				  void *cb_data)
+{
+	const struct snapshot *snapshot = cb_data;
+	const struct snapshot_record *e1 = v1, *e2 = v2;
+	const char *r1 = e1->start + snapshot_hexsz(snapshot) + 1;
+	const char *r2 = e2->start + snapshot_hexsz(snapshot) + 1;
+
+	return cmp_packed_refname(r1, r2);
+}
+
 /*
  * Compare a snapshot record at `rec` to the specified NUL-terminated
  * refname.
@@ -1797,19 +1803,33 @@ static int packed_fsck_ref_next_line(struct fsck_options *o,
 }
 
 static int packed_fsck_ref_header(struct fsck_options *o,
-				  const char *start, const char *eol)
+				  const char *start, const char *eol,
+				  unsigned int *sorted)
 {
-	if (!starts_with(start, "# pack-refs with: ")) {
+	struct string_list traits = STRING_LIST_INIT_NODUP;
+	char *tmp_line;
+	int ret = 0;
+	char *p;
+
+	tmp_line = xmemdupz(start, eol - start);
+	if (!skip_prefix(tmp_line, "# pack-refs with: ", (const char **)&p)) {
 		struct fsck_ref_report report = { 0 };
 		report.path = "packed-refs.header";
 
-		return fsck_report_ref(o, &report,
-				       FSCK_MSG_BAD_PACKED_REF_HEADER,
-				       "'%.*s' does not start with '# pack-refs with: '",
-				       (int)(eol - start), start);
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_HEADER,
+				      "'%.*s' does not start with '# pack-refs with: '",
+				      (int)(eol - start), start);
+		goto cleanup;
 	}
 
-	return 0;
+	string_list_split_in_place(&traits, p, " ", -1);
+	*sorted = unsorted_string_list_has_string(&traits, "sorted");
+
+cleanup:
+	free(tmp_line);
+	string_list_clear(&traits, 0);
+	return ret;
 }
 
 static int packed_fsck_ref_peeled_line(struct fsck_options *o,
@@ -1915,8 +1935,68 @@ static int packed_fsck_ref_main_line(struct fsck_options *o,
 	return ret;
 }
 
+static int packed_fsck_ref_sorted(struct fsck_options *o,
+				  struct ref_store *ref_store,
+				  const char *start, const char *eof)
+{
+	size_t hexsz = ref_store->repo->hash_algo->hexsz;
+	struct strbuf packed_entry = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	struct strbuf refname1 = STRBUF_INIT;
+	struct strbuf refname2 = STRBUF_INIT;
+	unsigned long line_number = 1;
+	const char *former = NULL;
+	const char *current;
+	const char *eol;
+	int ret = 0;
+
+	if (*start == '#') {
+		eol = memchr(start, '\n', eof - start);
+		start = eol + 1;
+		line_number++;
+	}
+
+	for (; start < eof; line_number++, start = eol + 1) {
+		eol = memchr(start, '\n', eof - start);
+
+		if (*start == '^')
+			continue;
+
+		if (!former) {
+			former = start + hexsz + 1;
+			continue;
+		}
+
+		current = start + hexsz + 1;
+		if (cmp_packed_refname(former, current) >= 0) {
+			const char *err_fmt =
+				"refname '%s' is less than previous refname '%s'";
+
+			eol = memchr(former, '\n', eof - former);
+			strbuf_add(&refname1, former, eol - former);
+			eol = memchr(current, '\n', eof - current);
+			strbuf_add(&refname2, current, eol - current);
+
+			strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+			report.path = packed_entry.buf;
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_PACKED_REF_UNSORTED,
+					      err_fmt, refname2.buf, refname1.buf);
+			goto cleanup;
+		}
+		former = current;
+	}
+
+cleanup:
+	strbuf_release(&packed_entry);
+	strbuf_release(&refname1);
+	strbuf_release(&refname2);
+	return ret;
+}
+
 static int packed_fsck_ref_content(struct fsck_options *o,
 				   struct ref_store *ref_store,
+				   unsigned int *sorted,
 				   const char *start, const char *eof)
 {
 	struct strbuf refname = STRBUF_INIT;
@@ -1926,7 +2006,7 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 
 	ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
 	if (*start == '#') {
-		ret |= packed_fsck_ref_header(o, start, eol);
+		ret |= packed_fsck_ref_header(o, start, eol, sorted);
 
 		start = eol + 1;
 		line_number++;
@@ -1957,9 +2037,10 @@ static int packed_fsck(struct ref_store *ref_store,
 	struct packed_ref_store *refs = packed_downcast(ref_store,
 							REF_STORE_READ, "fsck");
 	struct strbuf packed_ref_content = STRBUF_INIT;
+	unsigned int sorted = 0;
 	struct stat st;
-	int fd;
 	int ret = 0;
+	int fd;
 
 	if (!is_main_worktree(wt))
 		goto cleanup;
@@ -2012,8 +2093,11 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	ret = packed_fsck_ref_content(o, ref_store, packed_ref_content.buf,
+	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
 				      packed_ref_content.buf + packed_ref_content.len);
+	if (!ret && sorted)
+		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
+					     packed_ref_content.buf + packed_ref_content.len);
 
 cleanup:
 	strbuf_release(&packed_ref_content);
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 7421cc1e7f..28dc8dcddc 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -735,4 +735,91 @@ test_expect_success 'packed-refs content should be checked' '
 	)
 '
 
+test_expect_success 'packed-ref with sorted trait should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+		git branch branch-1 &&
+		git branch branch-2 &&
+		git tag -a annotated-tag-1 -m tag-1 &&
+		branch_1_oid=$(git rev-parse branch-1) &&
+		branch_2_oid=$(git rev-parse branch-2) &&
+		tag_1_oid=$(git rev-parse annotated-tag-1) &&
+		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
+		refname1="refs/heads/main" &&
+		refname2="refs/heads/foo" &&
+		refname3="refs/tags/foo" &&
+
+		cat >.git/packed-refs <<-EOF &&
+		# pack-refs with: peeled fully-peeled sorted
+		EOF
+		git refs verify 2>err &&
+		rm .git/packed-refs &&
+		test_must_be_empty err &&
+
+		cat >.git/packed-refs <<-EOF &&
+		# pack-refs with: peeled fully-peeled sorted
+		$branch_2_oid $refname1
+		EOF
+		git refs verify 2>err &&
+		rm .git/packed-refs &&
+		test_must_be_empty err &&
+
+		cat >.git/packed-refs <<-EOF &&
+		# pack-refs with: peeled fully-peeled sorted
+		$branch_2_oid $refname1
+		$branch_1_oid $refname2
+		$tag_1_oid $refname3
+		EOF
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs line 3: packedRefUnsorted: refname '\''$refname2'\'' is less than previous refname '\''$refname1'\''
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err &&
+
+		cat >.git/packed-refs <<-EOF &&
+		# pack-refs with: peeled fully-peeled sorted
+		$tag_1_oid $refname3
+		^$tag_1_peeled_oid
+		$branch_2_oid $refname2
+		EOF
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs line 4: packedRefUnsorted: refname '\''$refname2'\'' is less than previous refname '\''$refname3'\''
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'packed-ref without sorted trait should not be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+		git branch branch-1 &&
+		git branch branch-2 &&
+		git tag -a annotated-tag-1 -m tag-1 &&
+		branch_1_oid=$(git rev-parse branch-1) &&
+		branch_2_oid=$(git rev-parse branch-2) &&
+		tag_1_oid=$(git rev-parse annotated-tag-1) &&
+		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
+		refname1="refs/heads/main" &&
+		refname2="refs/heads/foo" &&
+		refname3="refs/tags/foo" &&
+
+		cat >.git/packed-refs <<-EOF &&
+		# pack-refs with: peeled fully-peeled
+		$branch_2_oid $refname1
+		$branch_1_oid $refname2
+		EOF
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
 test_done
-- 
2.48.1

