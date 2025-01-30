Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C32D2FB
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 04:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738210003; cv=none; b=a7cRSZfcEaIojYoCaHr4GwLLhkrl+7vgncA/ZmJNvEhSVQCaL8/LCazngOhWBo7woLBtAtcBj4MpbjScVox9loZMU+9NyAFaq0P1cT4gkBiMfz/Pxgj9lXTA5637kexUNQ23p5jZPjv9G5XF9+ErA3a0pXmF9uw6gt2ux84Jwqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738210003; c=relaxed/simple;
	bh=sAKnlHBdLelImtDnBDP9BsThId+kuih74mMDRTxHNk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSdMb6o3y0qkmxd2ztSeMVWkrpsMMUeNqsOcWLDDbVOInOs0uV1V/85tk36HRUZaYA4jd4Gc7Q51qLfmaOPnflE4MBGNkzTU+iGJjWbA0rE6Jah5sSnXwih8XkMh32v/xf1iM0b2pw/ZW8eyis2KAcBCtpAUKl+w0JoKrTdH09c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meH55qRA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meH55qRA"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2161eb95317so5253135ad.1
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738209999; x=1738814799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UGuWiZCus3MjSIoarHcnV3lfcGvXX/ukSiQ2APL+o58=;
        b=meH55qRAjqpRqnF6em3FV7R9qVc9YPdQq7CuCQqTR1tjclPWBFePLNaSLIiFcx8ld9
         5yG61rOmooXooXOe1ZDSoDStaOjYmnYtvEv9sQhJhhunHgTADGdH09KKBb9dQkB2+eKi
         rlbXHDTh0BBBmCEHtpooqy7ZAGOcE55uea76vceABexkjWBj7ZbEJDFogh2mj8gfXqFs
         RonPMbULzuT9xKzGJVMdjof4Fnh3iiBPCCB0JUG/cGcW0PFQmncDwOfjvls0C8O78k9h
         Rd8jydYsxt/gwIckhrse+DqjWnRoXacIluRxGOMZ1h1ilNOekZ1QBmt4UfW6lv11F9/h
         LlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738209999; x=1738814799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGuWiZCus3MjSIoarHcnV3lfcGvXX/ukSiQ2APL+o58=;
        b=BDhDSCKD4du1WxMHGGgNDEYmjUK1M1zaSVQWBov156EK7j7KSsFLqOgc8IJZpPuUcj
         an9OrK0NhcZnyzwVys46GJx9ElynBpw+ia8KeqCgb0lOSyo0yKMitOprh9WMK4N4qFkO
         IeB8XyX26I26yFtDDrmvpVgNL3Uo+RgnhgvR8pvP7+9kOPl7CBJg2moLABIwaS4Zf+eK
         1gor+2pd88u4x3hpnXP8atKwyBEJ52mohh5RWKll8b/qEtTt6/8sjHm2s2mmhd4xeIX+
         rN5p817G4hQP8Nojp9oy1b7ZVWD1uJdsWJ5e0Q2ac0HrnZ60YwCS0TZKWCbVCceFWO3i
         +cew==
X-Gm-Message-State: AOJu0YwBPrU/fu4iqG5tnLajMSA2j4H4ZEqPZdV1vam0Kuh470qvZQCH
	Xgz79ZRzPVajNMgyWIJr/c+UAHF4+pOpw3/hLex4AFvmwEuy0/JOzFQNI8h6
X-Gm-Gg: ASbGncvaiFzZIZeFgRj8FwZWRJOdfj2eIjqXZu2ycephcs/ouRo1eODa+cAxiLBNY0s
	gM3nTLt5WppHb5b0rT0i/amkLSAUUNmWiOrCdnyQZnVJH7U3qwWuXZvPkYk21qOZ3uQgalRBjl5
	UCY+5HdXu0jQu8LFsDDocxyiKBFPD26JTPi+5I/6ERuC9/lEyRnl5/N3yqvdBN65Q+l5zAWo+3g
	vCLygUj3vlksQwHW8X3MFel0eeyxfLxdaaWfWvmEe4u6g+/4/dMfKuE8Pg4Qu0a1kGFQw==
X-Google-Smtp-Source: AGHT+IHa+TF8J7uCbqdMUk+fElELcUp+OrZ0JhViEHCNqn6lXX2MpdaWrHjNOQ21nl+Y//KMkfT4RQ==
X-Received: by 2002:a17:902:e541:b0:216:282d:c697 with SMTP id d9443c01a7336-21dd7da3eb0mr89659005ad.27.1738209999380;
        Wed, 29 Jan 2025 20:06:39 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de31ee352sm4102315ad.4.2025.01.29.20.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 20:06:38 -0800 (PST)
Date: Thu, 30 Jan 2025 12:08:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 7/8] packed-backend: check whether the "packed-refs" is
 sorted
Message-ID: <Z5r7KvL1bvSO4UQY@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5r6ZnLH3Ee8IQnN@ArchLinux>

We will always try to sort the "packed-refs" increasingly by comparing
the refname. So, we should add checks to verify whether the "packed-refs"
is sorted.

We already have code to parse the content. Let's create a new structure
"fsck_packed_ref_entry" to store the state during the parsing process
for every entry. It may seem that we could just add a new "struct strbuf
refname" into the "struct fsck_packed_ref_entry" and during the parsing
process, we could store the refname into this structure and we could
compare later. However, this is not a good design due to the following
reasons:

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
 refs/packed-backend.c         | 100 +++++++++++++++++++++++++++++++---
 t/t0602-reffiles-fsck.sh      |  38 +++++++++++++
 4 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 2a7ec7592e..7a11d35c5e 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -190,6 +190,9 @@
 `packedRefMissingHeader`::
 	(INFO) The "packed-refs" file does not contain the header.
 
+`packedRefUnsorted`::
+	(ERROR) The "packed-refs" file is not sorted.
+
 `refMissingNewline`::
 	(INFO) A loose ref that does not end with newline(LF). As
 	valid implementations of Git never created such a loose ref
diff --git a/fsck.h b/fsck.h
index 40126242a4..0d3d1045ae 100644
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
index 271c740728..b250f987b2 100644
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
@@ -1768,6 +1774,28 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
+struct fsck_packed_ref_entry {
+	int line_number;
+
+	struct snapshot_record record;
+};
+
+static struct fsck_packed_ref_entry *create_fsck_packed_ref_entry(int line_number,
+								  const char *start)
+{
+	struct fsck_packed_ref_entry *entry = xcalloc(1, sizeof(*entry));
+	entry->line_number = line_number;
+	entry->record.start = start;
+	return entry;
+}
+
+static void free_fsck_packed_ref_entries(struct fsck_packed_ref_entry **entries, int nr)
+{
+	for (int i = 0; i < nr; i++)
+		free(entries[i]);
+	free(entries);
+}
+
 static int packed_fsck_ref_next_line(struct fsck_options *o,
 				     struct strbuf *packed_entry, const char *start,
 				     const char *eof, const char **eol)
@@ -1893,13 +1921,60 @@ static int packed_fsck_ref_main_line(struct fsck_options *o,
 	return 0;
 }
 
+static int packed_fsck_ref_sorted(struct fsck_options *o,
+				  struct ref_store *ref_store,
+				  struct fsck_packed_ref_entry **entries,
+				  int nr)
+{
+	size_t hexsz = ref_store->repo->hash_algo->hexsz;
+	struct strbuf packed_entry = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	struct strbuf refname1 = STRBUF_INIT;
+	struct strbuf refname2 = STRBUF_INIT;
+	int ret = 0;
+
+	for (int i = 1; i < nr; i++) {
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
+			strbuf_addf(&packed_entry, "packed-refs line %d",
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
+	int entry_alloc = 20;
 	int line_number = 1;
+	int entry_nr = 0;
 	const char *eol;
 	int ret = 0;
 
@@ -1919,7 +1994,13 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 				       "missing header line");
 	}
 
+	ALLOC_ARRAY(entries, entry_alloc);
 	while (start < eof) {
+		struct fsck_packed_ref_entry *entry
+			= create_fsck_packed_ref_entry(line_number, start);
+
+		ALLOC_GROW(entries, entry_nr + 1, entry_alloc);
+		entries[entry_nr++] = entry;
 		strbuf_reset(&packed_entry);
 		strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
 		ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
@@ -1935,11 +2016,16 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 			start = eol + 1;
 			line_number++;
 		}
+		entry->record.len = start - entry->record.start;
 	}
 
+	if (!ret)
+		ret |= packed_fsck_ref_sorted(o, ref_store, entries, entry_nr);
+
 	strbuf_release(&packed_entry);
 	strbuf_release(&refname);
 	strbuf_release(&packed_entry);
+	free_fsck_packed_ref_entries(entries, entry_nr);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index e4b4a58684..9d802d71a9 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -727,4 +727,42 @@ test_expect_success 'packed-refs content should be checked' '
 	)
 '
 
+test_expect_success 'packed-ref sorted should be checked' '
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
 test_done
-- 
2.48.1

