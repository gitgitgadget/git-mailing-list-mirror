Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680A13C80E
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821496; cv=none; b=ieTqHDGwxTK5JoRYWjrd0B76lF0L0InptTSyhoyjTlWwVDVoLboWDYSMuXWNjsFSvQrUqGLDSMfE/AjxyMMhm7MArMpfesKianGd8v+xVIfjHZ/P6Byr1SXP/ml5DXMfTSp9GzG4u+88ChwD/mutT6D6B4eOzZ/anMLOb/hjzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821496; c=relaxed/simple;
	bh=VFERlilAa6J7pmVgmfD72zYCNVFXnmyRuQHMKGutrpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilYCKVaVkIj8d/arxpSuC8DK6byVaJdQjkw6DKtgqzS/SQ/wwwsGhnyFcmFgzGrtz+WzkDPM+h3qWN0KAnW6Ll8waD7q/2tySg0dcD5qZ8WP9s8/TyZGQ5dOi7n5HSSxC2OHchIBh0sHBeI80JA2pYn8L+c9SioMl78+cjSZw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THXXTHsI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THXXTHsI"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2163dc5155fso10383505ad.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 21:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738821494; x=1739426294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0H/TpLiBfAlzOPKc+ELuD6P7WRl6QS/owcRlTdjQ5qI=;
        b=THXXTHsImytyjMXyNlBxHwKElYFjjUGnmhTzdnMKFH4IIzc7CzOOyY8ShPWVKXmEjM
         U5u0HpaGhbrND1xxCbw8ytmbdJM6OfgiNvGVhaLOZfQeqvhthh3MYEcCTjCC3Q3hsCub
         EiGYSnaVbx3ygcaiRGwiIhhs/4XvkH4g83rJnVZyQMk2TtZry1PjZt2reTi0umeh720n
         KjDzjkLqLwlMdvbmYzD0oZc8o8wAbhCbWwmCo5+FT9G/E0izm4W4yKeasNVUQWHh9c1t
         E6yhc62/ZIl6ns3w1PtGIR3l+C7Hz+yIcD8+8ASQy/FnrfVxu9SnS/FhXzeEwZ7F2qff
         OJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821494; x=1739426294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0H/TpLiBfAlzOPKc+ELuD6P7WRl6QS/owcRlTdjQ5qI=;
        b=bXdB3KRNVu6c3VJ5Jqxr3gGL2MZkG49sDEkavybuJRlZzFtHwQztXPbC8TiWeDNRF1
         RqReinObE5+B4F1zu20zgMR87Kf0Mf/QfnzL9Hl1FmjSWTv3OdmIWNjO5yzb8o2ick0i
         RNGQtJjtB8UnhhLSBdHKYS579rOAJ9ikVz8sxazLPXzr8pTb7LVSSomZFGvAe3FP7nBT
         z6rCxGuIq5s13QYPT08ySqBVNQwOpZ4JjxbPImOiW3xeLOy6FbcYP5oA+cn+5NWsXKAu
         tmHMrvZsFg/lB5kNs5mYg11Ht0FzfSBiNskDfwpd2w5IhJmXPIfUZobGbYxlElrGRl9W
         +NmA==
X-Gm-Message-State: AOJu0YxlQdMXCj2nJm0ME7RPDdwmnMMCvlaothIJHb7Rzr5WP38E4bm4
	r0x26unrzo68zJPz5g40FXT0YPGe65k/kMcgtlPiPeW06fbviOMZbYH8qA==
X-Gm-Gg: ASbGnctTSky2ysbgjLDBZIycVIfx72z0eIa44ypCIt1qfLIBs99S87lY+BoeQiKuOee
	irwfC7JvXaIQ8RRwQNyhGVZCdrNJmwODsudrsHcS/t1xcrwOZvk71i0T9UrdRmeASv9PGqlCdmw
	gVZyqCRxKCvUngmDwUup3yrXGmEvWYZ3Z14f0guUk/Z7YDapkeMauBqOGFMHA3zD2sXJmivisRR
	G6zQ9oPOIJLMppBMIsjxGgHAwtZdX6qTgtMda7WUAChfb3sr6KCDfx9ona8FFGdRZZQBQ==
X-Google-Smtp-Source: AGHT+IEaFFwKvI8dV4/MHTQ6s1TDcNHzuJOY3fpODXbS9+LEibas61M2I7Aq6cuiscR8ctoo1M3snw==
X-Received: by 2002:a17:902:e803:b0:216:725c:a137 with SMTP id d9443c01a7336-21f17e26d6amr108438575ad.28.1738821493909;
        Wed, 05 Feb 2025 21:58:13 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f368a25casm3901125ad.218.2025.02.05.21.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:58:13 -0800 (PST)
Date: Thu, 6 Feb 2025 13:59:55 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 7/8] packed-backend: check whether the "packed-refs" is
 sorted
Message-ID: <Z6RP2_wL1gjsWpkR@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6RPJI10-2QkwyqH@ArchLinux>

When there is a "sorted" trait in the header of the "packed-refs" file,
it means that each entry is sorted increasingly by comparing the
refname. We should add checks to verify whether the "packed-refs" is
sorted in this case.

Update the "packed_fsck_ref_header" to know whether there is a "sorted"
trail in the header. Then, create a new structure "fsck_packed_ref_entry"
to store the state during the parsing process for every entry. It may
seem that we could just add a new "struct strbuf refname" into the
"struct fsck_packed_ref_entry" and during the parsing process, we could
store the refname into this structure and thus we could compare later.
However, this is not a good design due to the following reasons:

1. Because we need to store the state across the whole checking
   lifetime, we would consume a lot of memory if there are many entries
   in the "packed-refs" file.
2. The most important thing is that we cannot reuse the existing compare
   functions which cause repetition.

So, instead of storing the "struct strbuf", let's use the existing
structure "struct snaphost_record". And thus we could use the existing
function "cmp_packed_ref_records".

However, this function need an extra parameter for "struct snaphost".
Extract the common part into a new function "cmp_packed_ref_records" to
reuse this function to compare.

Then, create a new function "packed_fsck_ref_sorted" to use the new fsck
message "packedRefUnsorted(ERROR)" to report to the user.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   3 +
 fsck.h                        |   1 +
 refs/packed-backend.c         | 131 ++++++++++++++++++++++++++++++----
 t/t0602-reffiles-fsck.sh      |  63 ++++++++++++++++
 4 files changed, 183 insertions(+), 15 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 02a7bf0503..9601fff228 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
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
index 658f6bc7da..0fbdc5c3fa 100644
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
@@ -1767,6 +1773,28 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
+struct fsck_packed_ref_entry {
+	unsigned long line_number;
+
+	struct snapshot_record record;
+};
+
+static struct fsck_packed_ref_entry *create_fsck_packed_ref_entry(unsigned long line_number,
+								  const char *start)
+{
+	struct fsck_packed_ref_entry *entry = xcalloc(1, sizeof(*entry));
+	entry->line_number = line_number;
+	entry->record.start = start;
+	return entry;
+}
+
+static void free_fsck_packed_ref_entries(struct fsck_packed_ref_entry **entries, size_t nr)
+{
+	for (size_t i = 0; i < nr; i++)
+		free(entries[i]);
+	free(entries);
+}
+
 static int packed_fsck_ref_next_line(struct fsck_options *o,
 				     struct strbuf *packed_entry, const char *start,
 				     const char *eof, const char **eol)
@@ -1794,19 +1822,33 @@ static int packed_fsck_ref_next_line(struct fsck_options *o,
 }
 
 static int packed_fsck_ref_header(struct fsck_options *o,
-				  const char *start, const char *eol)
+				  const char *start, const char *eol,
+				  unsigned int *sorted)
 {
-	if (!starts_with(start, "# pack-refs with:")) {
+	struct string_list traits = STRING_LIST_INIT_NODUP;
+	char *tmp_line;
+	int ret = 0;
+	char *p;
+
+	tmp_line = xmemdupz(start, eol - start);
+	if (!skip_prefix(tmp_line, "# pack-refs with:", (const char **)&p)) {
 		struct fsck_ref_report report = { 0 };
 		report.path = "packed-refs.header";
 
-		return fsck_report_ref(o, &report,
-				       FSCK_MSG_BAD_PACKED_REF_HEADER,
-				       "'%.*s' does not start with '# pack-refs with:'",
-				       (int)(eol - start), start);
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_HEADER,
+				      "'%.*s' does not start with '# pack-refs with:'",
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
@@ -1880,26 +1922,80 @@ static int packed_fsck_ref_main_line(struct fsck_options *o,
 	return 0;
 }
 
+static int packed_fsck_ref_sorted(struct fsck_options *o,
+				  struct ref_store *ref_store,
+				  struct fsck_packed_ref_entry **entries,
+				  size_t nr)
+{
+	size_t hexsz = ref_store->repo->hash_algo->hexsz;
+	struct strbuf packed_entry = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	struct strbuf refname1 = STRBUF_INIT;
+	struct strbuf refname2 = STRBUF_INIT;
+	int ret = 0;
+
+	for (size_t i = 1; i < nr; i++) {
+		const char *r1 = entries[i - 1]->record.start + hexsz + 1;
+		const char *r2 = entries[i]->record.start + hexsz + 1;
+
+		if (cmp_packed_refname(r1, r2) >= 0) {
+			const char *err_fmt =
+				"refname '%s' is not less than next refname '%s'";
+			const char *eol;
+			eol = memchr(entries[i - 1]->record.start, '\n',
+				     entries[i - 1]->record.len);
+			strbuf_add(&refname1, r1, eol - r1);
+			eol = memchr(entries[i]->record.start, '\n',
+				     entries[i]->record.len);
+			strbuf_add(&refname2, r2, eol - r2);
+
+			strbuf_addf(&packed_entry, "packed-refs line %lu",
+				    entries[i - 1]->line_number);
+			report.path = packed_entry.buf;
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_PACKED_REF_UNSORTED,
+					      err_fmt, refname1.buf, refname2.buf);
+			goto cleanup;
+		}
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
 				   const char *start, const char *eof)
 {
 	struct strbuf packed_entry = STRBUF_INIT;
+	struct fsck_packed_ref_entry **entries;
 	struct strbuf refname = STRBUF_INIT;
 	unsigned long line_number = 1;
+	unsigned int sorted = 0;
+	size_t entry_alloc = 20;
+	size_t entry_nr = 0;
 	const char *eol;
 	int ret = 0;
 
 	strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
 	ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
 	if (*start == '#') {
-		ret |= packed_fsck_ref_header(o, start, eol);
+		ret |= packed_fsck_ref_header(o, start, eol, &sorted);
 
 		start = eol + 1;
 		line_number++;
 	}
 
+	ALLOC_ARRAY(entries, entry_alloc);
 	while (start < eof) {
+		struct fsck_packed_ref_entry *entry
+			= create_fsck_packed_ref_entry(line_number, start);
+
+		ALLOC_GROW(entries, entry_nr + 1, entry_alloc);
+		entries[entry_nr++] = entry;
 		strbuf_reset(&packed_entry);
 		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
 		ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
@@ -1915,11 +2011,16 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 			start = eol + 1;
 			line_number++;
 		}
+		entry->record.len = start - entry->record.start;
 	}
 
+	if (!ret && sorted)
+		ret |= packed_fsck_ref_sorted(o, ref_store, entries, entry_nr);
+
 	strbuf_release(&packed_entry);
 	strbuf_release(&refname);
 	strbuf_release(&packed_entry);
+	free_fsck_packed_ref_entries(entries, entry_nr);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 3ab6b5bba5..adcb5c1bda 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -706,4 +706,67 @@ test_expect_success 'packed-refs content should be checked' '
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
+		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
+		printf "%s %s\n" "$branch_2_oid" "$refname1" >>.git/packed-refs &&
+		printf "%s %s\n" "$branch_1_oid" "$refname2" >>.git/packed-refs &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs line 2: packedRefUnsorted: refname '\''$refname1'\'' is not less than next refname '\''$refname2'\''
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err &&
+
+		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
+		printf "%s %s\n" "$tag_1_oid" "$refname3" >>.git/packed-refs &&
+		printf "^%s\n" "$tag_1_peeled_oid" >>.git/packed-refs &&
+		printf "%s %s\n" "$branch_2_oid" "$refname2" >>.git/packed-refs &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs line 2: packedRefUnsorted: refname '\''$refname3'\'' is not less than next refname '\''$refname2'\''
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
+		printf "# pack-refs with: peeled fully-peeled \n"  >.git/packed-refs &&
+		printf "%s %s\n" "$branch_2_oid" "$refname1" >>.git/packed-refs &&
+		printf "%s %s\n" "$branch_1_oid" "$refname2" >>.git/packed-refs &&
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
 test_done
-- 
2.48.1

