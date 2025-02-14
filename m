Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177D19005D
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508772; cv=none; b=Y3UGzQg2q0JrPXDXJ1QYKXZeZuxdqKYYnkkC75oxxvVVhCmgizl7bB4nxNHFg5erq4AXydu60oygBZWYkZXEHxQZts/9jvMKrlHTgEPm19tjTMk0uc2rADAXSnfsEcKWYW1YfgDenFnqLOLnEMU9B6LdAxvN+bLnyCZULvYL1ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508772; c=relaxed/simple;
	bh=XgglGyyHVjOukLc+yaEc2H0wQABeyPTLor2XoYMAWBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8AvwTounpFsMq2F7R2l7f7638Pzo2XOs1Fly23gbc6+dUIH7/60aA4z1l8uRj54RwLLtFq5tVHOnBxxk4C3ptH15vdUckTY+R4uBQrd+KQdGBlydu8gjpG6P/gHQJtIlmD4plIIbCAGzJUwy9J3kTSQsyi4Bf37bM6hFPnRcB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaPDGs29; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaPDGs29"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f4b266d333so12704377b3.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739508769; x=1740113569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rH1PScBOe9CxDRnikGkIPQKor90GpTZhqHywp/brHlY=;
        b=EaPDGs29v/tVWe3EE5sAtytCICC9tDK7ejLvLa2S1I/4iQ61Jtf6Zsvso5VZh7lTgf
         +H0kX+jccsCzgWzHLMiX+AXhHPH8/A5lNbOzDbtRgf99nl/ivqxXA1k93QW2R70Rk0NI
         zpR6avYCSgu8nIDGu1JZeBnIXn20mY699JFd9aOMkiuzEqVI1KZXT6m1n3xa5OfFG1su
         35GG3dm8ciETTI6fo/cZMVOYsumJ4i7qGzPt/yudb26J1Jw7vqkbwL4TLcEuWutjFZ4V
         srXfr4za6b1e18itwXphLmh5BBIc+IGWhlduMahTMRP6GBJuUMzQWb/ZJP2Kp6RCJYDS
         YxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508769; x=1740113569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rH1PScBOe9CxDRnikGkIPQKor90GpTZhqHywp/brHlY=;
        b=dmgRAdxP3nKxZu4k7qcYliY+zhrUrUxaZEOo7+HpC6m/kMQOfoEHllFq/l0DR+FFEU
         6UWREs9zQ2lLxLGL0HMuKahc/LrOQKBbPD7SDQaGSbeYIU16hAgbMZeFlVTXmw6isb7u
         JqJjMfm6g+c2ZcFzAdW0WKxn4g/re5oIQOuuiXWkjvAMItMY+K8BT4ffExP6q9NPy1RF
         IJRTPv61BLW2C9TpiFOxyKB1B4jN5vqZM5Tm6WyiL8A9KObncGOn0y0T2kCKOVzDoOB4
         gf2Mg9KAAwa0Rc24423MflQMKmLCEkOZcCfzievXib9SN8cNMlExessuQxDCDqQfp4iQ
         +zYw==
X-Gm-Message-State: AOJu0YzBWH+RgmVkYTah2nHH2SBmgiLevFMSChOeAdQU/wrPmpw3M4Dx
	vCSxDSs6L1WoXLdok2/ZomTiovJSZKYW1HnR3QrtRy6ks20Di3JrpY4pB9Jg
X-Gm-Gg: ASbGncssD+rhGCDz1t1f+j2EkU+MlwGB4EPUhtiTBOA4dBsGP250pMT7LfC4csw0R7U
	KtVz4dGtTWXtohU7E7Fn3+njqfz6Adm514eKmz3zwcxkGKnYU55k7/3rK7WBGcQ0sVY7KVzUftH
	+Ey69tybcHclkhjUVhwckX3hXnnYqd5WNBetwGORsTofsu/J2KNMrBLj/mLIzbRyU7x832Fg1Dl
	L7pL9cJmNsbD49xh1vtiIADw/1QWxozuN0tBrAicZ1mgimwwdqIK3LxFXwa3aLa+cOuBg==
X-Google-Smtp-Source: AGHT+IHPReLrzwMo8e6q7a44PXc7W0vg1xMyzJDPeoermgPq7xOLUvWVeM+lDC/9OumHZEN7bAZktg==
X-Received: by 2002:a05:690c:6f0c:b0:6f9:43d4:44ee with SMTP id 00721157ae682-6fb1f683367mr115652447b3.30.1739508769008;
        Thu, 13 Feb 2025 20:52:49 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fb361db9e8sm6189027b3.125.2025.02.13.20.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:52:47 -0800 (PST)
Date: Fri, 14 Feb 2025 12:52:43 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 4/8] packed-backend: add "packed-refs" header consistency
 check
Message-ID: <Z67MG8utrQfUrakz@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z67LkxAFIAeaYr0U@ArchLinux>

In "packed-backend.c::create_snapshot", if there is a header (the line
which starts with '#'), we will check whether the line starts with "#
pack-refs with:". Before we port this check into "packed_fsck", let's
fix "create_snapshot" to check the prefix "# packed-ref with: " instead
of "# packed-ref with:" due to that we will always write a single
trailing space after the colon.

However, we need to consider other situations and discuss whether we
need to add checks.

1. If the header does not exist, we should not report an error to the
   user. This is because in older Git version, we never write header in
   the "packed-refs" file. Also, we do allow no header in "packed-refs"
   in runtime.
2. If the header content does not start with "# packed-ref with: ", we
   should report an error just like what "create_snapshot" does. So,
   create a new fsck message "badPackedRefHeader(ERROR)" for this.
3. If the header content is not the same as the constant string
   "PACKED_REFS_HEADER". This is expected because we make it extensible
   intentionally. So, there is no need to report.

As we have analyzed, we only need to check the case 2 in the above. In
order to do this, read the "packed-refs" file via "strbuf_read". Like
what "create_snapshot" and other functions do, we could split the line
by finding the next newline in the buffer. When we cannot find a
newline, we could report an error.

So, create a function "packed_fsck_ref_next_line" to find the next
newline and if there is no such newline, use
"packedRefEntryNotTerminated(ERROR)" to report an error to the user.

Then, parse the first line to apply the checks. Update the test to
exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  8 ++++
 fsck.h                        |  2 +
 refs/packed-backend.c         | 75 ++++++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh      | 52 ++++++++++++++++++++++++
 4 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index b14bc44ca4..11906f90fd 100644
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
 
@@ -176,6 +180,10 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`packedRefEntryNotTerminated`::
+	(ERROR) The "packed-refs" file contains an entry that is
+	not terminated by a newline.
+
 `refMissingNewline`::
 	(INFO) A loose ref that does not end with newline(LF). As
 	valid implementations of Git never created such a loose ref
diff --git a/fsck.h b/fsck.h
index a44c231a5f..67e3c97bc0 100644
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
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6401cecd5f..ff74ab915e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -694,7 +694,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 
 		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
 
-		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
+		if (!skip_prefix(tmp, "# pack-refs with: ", (const char **)&p))
 			die_invalid_line(refs->path,
 					 snapshot->buf,
 					 snapshot->eof - snapshot->buf);
@@ -1749,12 +1749,76 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
+static int packed_fsck_ref_next_line(struct fsck_options *o,
+				     unsigned long line_number, const char *start,
+				     const char *eof, const char **eol)
+{
+	int ret = 0;
+
+	*eol = memchr(start, '\n', eof - start);
+	if (!*eol) {
+		struct strbuf packed_entry = STRBUF_INIT;
+		struct fsck_ref_report report = { 0 };
+
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
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
+static int packed_fsck_ref_header(struct fsck_options *o,
+				  const char *start, const char *eol)
+{
+	if (!starts_with(start, "# pack-refs with: ")) {
+		struct fsck_ref_report report = { 0 };
+		report.path = "packed-refs.header";
+
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_HEADER,
+				       "'%.*s' does not start with '# pack-refs with: '",
+				       (int)(eol - start), start);
+	}
+
+	return 0;
+}
+
+static int packed_fsck_ref_content(struct fsck_options *o,
+				   const char *start, const char *eof)
+{
+	unsigned long line_number = 1;
+	const char *eol;
+	int ret = 0;
+
+	ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
+	if (*start == '#') {
+		ret |= packed_fsck_ref_header(o, start, eol);
+
+		start = eol + 1;
+		line_number++;
+	}
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
 	int ret = 0;
 	int fd;
 
@@ -1786,7 +1850,16 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
+	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
+		ret = error_errno(_("unable to read %s"), refs->path);
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
index 42c8d4ca1e..30be1982df 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -639,4 +639,56 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
 	)
 '
 
+test_expect_success 'packed-refs header should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		for bad_header in "# pack-refs wit: peeled fully-peeled sorted " \
+				  "# pack-refs with traits: peeled fully-peeled sorted " \
+				  "# pack-refs with a: peeled fully-peeled" \
+				  "# pack-refs with:peeled fully-peeled sorted"
+		do
+			printf "%s\n" "$bad_header" >.git/packed-refs &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: packed-refs.header: badPackedRefHeader: '\''$bad_header'\'' does not start with '\''# pack-refs with: '\''
+			EOF
+			rm .git/packed-refs &&
+			test_cmp expect err || return 1
+		done
+	)
+'
+
+test_expect_success 'packed-refs missing header should not be reported' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		printf "$(git rev-parse HEAD) refs/heads/main\n" >.git/packed-refs &&
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success 'packed-refs unknown traits should not be reported' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		printf "# pack-refs with: peeled fully-peeled sorted foo\n" >.git/packed-refs &&
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
 test_done
-- 
2.48.1

