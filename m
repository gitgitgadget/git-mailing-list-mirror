Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFA84A2B
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577850; cv=none; b=E4cKvhYJIYyx+FD14vfUtS6JENU7CVquoo9apM91rqHJl5Ih00vVWrDuW7yxZmHTi6Jj40MTpnyWtDBVPuyKVCkwSqgRfrcQ1OxudeBMgEbmWCvJWtQpDjS79nDBPMG0YYBhtRxWdI+flnCU5pE28jYqNvM7KO8upnHZggx6bgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577850; c=relaxed/simple;
	bh=2M1tOKXfHyc6p05BE2V4dhMhNPEp/XSabKzBqMC5KKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD587qpKwy2wk4qJyn48btEqyJjxA5NPOKUWAWxUhm13Sju2noAwTR3STiEzZcGbEbli6cDA7vtuRgIdOckbzlzMyAWPwpOFq3Nk7NTLngBf2GeV7tQEffRFcevIeLizbJn01zc1v66HRkiagMSTOxm8t+fj1M+Pcbk63Hgibio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWuIwURp; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWuIwURp"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fe848040b1so1257169a91.3
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 05:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740577848; x=1741182648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+BFKf6n8p7GWH69K7+nNjovE64N3rwTNW29Xdnf3gtg=;
        b=DWuIwURpcKhixCZa/qHEpGRms8Cc/01oA0/hFjnfm8VABXa9IHxwzyKpaGu4BJzKvU
         QZw+wwvet7vlJpPgTH4DnGn4kPEmhZcc2iVjOWkzvr6sFY/baIFmIIoJdnaXqiucqSo+
         bdLRVJ6UJg8Zu1qrC1Q57scXdF0X4d1AWChU3was3gGMYYWjx1T5Z1feKJtSB6zet3Zi
         nAZaNb9wq4hPye3yf1lsInMS/xC03FZnAll7M4KopDZp8PPsbWmi2HGIk/uA6MqUHu6w
         S/PYIWkKnHBmJXnVG9cD53v4rUAaekzlZad+4efaEx/U/W1v+hZWWgOmli0EeLQHFn34
         E/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577848; x=1741182648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BFKf6n8p7GWH69K7+nNjovE64N3rwTNW29Xdnf3gtg=;
        b=iZljeN+3Lpjz9MbJu1QSkk404LOP5mG1tyU9TJ7b3F3+3l4ea4S7sLPFrJDBQKHqJb
         biF801n6ZHHC3jkAsQbV6+XSQdxzhmfhWdyPi5B8uNXZm2nWrD07YEjQvqUeWhd1e+c/
         CaQsH1oJ0tMINiXYlyGiWgGPfyGFG9ebkMcAeeck4npT61tpOL1RzkBpZAjfmWEul/mp
         XdnHC0oa3NIuHDZL0FWzkw/ZiNjHSnb4UYyk89Sjd1cf027orwDimhhc6HBWoEVicjJ0
         Ax7RxFSB5stNYbZSOIO9I2tkemiA4RHd91vkekVcIWotIJT3EQ9f0XOuPujRiQSQFGDY
         mzaw==
X-Gm-Message-State: AOJu0Yy/vol0T+7zpky73C+Os0xkrVX8l9IqaDSgmJjrubqfAnc/4zd0
	cUEfCSYE+PQjk1de0GGwGWSgKUrRfiFp1cotymZg7hiPe4cHIXNocOouQw==
X-Gm-Gg: ASbGncu9QUnWbbqGZY3Ur24D1sX15bkPzNaK6waki8IaUWZ8inNwUZ4bAwFm+rk+Q/+
	vqMafiG6Jwwa+LAp0D/vgcI987+IVRxMObU6RcXKkq/M0uGi+ZmMV8Yhbl3+84LRt0TwgPobKLq
	hpvKJTMPzKeF3jcpUZ4YiVqTB9YQC9tMZIosjew/WlLfpX/1HuuR//1v4qL56TkzIG/I+WqMZP8
	Ku1XjGV5+ez4Uy3VIbp/xNfy+GKn6eXOTSXiKtJ7XyqqkbNyuWAMEGxer3Drtr5TH5Gs/w2v4vX
	iFFKI8vAoZ+zIIBUvwU2wQ==
X-Google-Smtp-Source: AGHT+IGiYtwvvHdL62mL8aBnwHY867kwB9GTa3W4FxySk//Lb9oZJHTNDGFEzfqmeKjEuaq4AJZXvw==
X-Received: by 2002:a17:90b:2d87:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-2fce8740f48mr37701523a91.33.1740577847577;
        Wed, 26 Feb 2025 05:50:47 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe825d7d7csm1517262a91.30.2025.02.26.05.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:50:46 -0800 (PST)
Date: Wed, 26 Feb 2025 21:50:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 8/9] packed-backend: check whether the "packed-refs" is
 sorted
Message-ID: <Z78cQEM0xkeJ5b2X@ArchLinux>
References: <Z78bmBSrDR20GY6g@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78bmBSrDR20GY6g@ArchLinux>

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
 refs/packed-backend.c          | 116 ++++++++++++++++++++++++++++-----
 t/t0602-reffiles-fsck.sh       |  87 +++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 16 deletions(-)

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
index 8c410fca77..a1710d7c2a 100644
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
@@ -1957,6 +2037,7 @@ static int packed_fsck(struct ref_store *ref_store,
 	struct packed_ref_store *refs = packed_downcast(ref_store,
 							REF_STORE_READ, "fsck");
 	struct strbuf packed_ref_content = STRBUF_INIT;
+	unsigned int sorted = 0;
 	struct stat st;
 	int ret = 0;
 	int fd;
@@ -2004,8 +2085,11 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	ret = packed_fsck_ref_content(o, ref_store, packed_ref_content.buf,
+	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
 				      packed_ref_content.buf + packed_ref_content.len);
+	if (!ret && sorted)
+		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
+					     packed_ref_content.buf + packed_ref_content.len);
 
 cleanup:
 	if (fd >= 0)
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index a88c792ce1..767e2bd4a0 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -743,4 +743,91 @@ test_expect_success 'packed-refs content should be checked' '
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

