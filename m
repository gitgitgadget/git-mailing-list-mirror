Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6CB42AAF
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508637; cv=none; b=FVpvPtgzGPzQ41bR377eq/gkM8Vzdm3x/4UZ6NvXy4v0uBHtWQKfm8zMg/YpE/LLV1OQ3y9e0MZ3Z275zVHUhqGpGT+AH5B9V5HBXlIl79Gr0mw1ebY67Vo0uit8+1qJqOGvYr1J2PSdonWkD/F51GtlXz/QRX/NuggDrXNCnFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508637; c=relaxed/simple;
	bh=NBPEUmWMP/792TKLvaW43CuC+cWV0Y2LUf8kA7A1ve8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPTsbVKRriUekqZsGU1zeVfV+68g9sE/U0NuWb+bJH6j0J0n+SbraFvIdZBVg1i1+Jd/BITS180ensVKrgzCsP2noCjnEqZFCbbq/DxudTgvEsPGhQ/rEB2sHpfk234tZau9wPdZCuzBH/I92e1kt3azuoLA6qdLIo+QaRTLlPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTPlyzgD; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTPlyzgD"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e5d93dd26daso1327662276.0
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739508634; x=1740113434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kk3Y3JGc0w/ioMkbuwlsQiYnOKdThz8gGmcyNEMGnqI=;
        b=fTPlyzgDMZyMgPG9V0JEJNo+dIri3Q4lDM2K/ZhlPyQK/t/0jDjwBr5yenhbaL009T
         Lq1+XivZgKmIF/piE3jOkqCAbKZjfAWsKI1PKuWB/iX1ZPz2B17VnFbFItXOYbYE3qDj
         YoS2S4OWqQNVcpMcBls51I2l4T8v0nF6EvK+w477mRnIo95uMnexsgZi+whk4CCiK5jd
         dc39Ee+B/AuqnbMMWEY+eTkSaUYJb4MH21g7kAncSfR29U0sAG61JoSxsMj2r1hqyk+v
         bObSiU2SMNKwxUjhsDt5mKke1wHj0A2Sio+eV1w20MVKfmVBQoqoNIGEduiRfOe+LreI
         FEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508634; x=1740113434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kk3Y3JGc0w/ioMkbuwlsQiYnOKdThz8gGmcyNEMGnqI=;
        b=EIEgsAQWgJdeMcY6m/ctAtp3C9eJ+ATU+NpyD7hBOHVyQaEUID7pwnstF0rgSMBmy9
         X7Wz2gzE6acpPyLbdWw1zvVzzhmmfpK4xadj9B4kenBnJiQEG4GeCoLSB3XcZ06ppH25
         JmT1HeETjcN1r19LexZSh6M3pYjjWsRyvgDAUk0xS1CEmo8QQS1jqzZhxww4hYmftw/w
         jzEFbgzXbID/fuRsc904C7DVoyEdqujLjEGWDguPjkw1ChmZDe4bkN87f+dMTJYLvH9T
         aneelgbS9SGGpN8hLggMPlWvJXmeyJ/aYwvXVzX9mIzlNxLZ0XvCIh79YtHo4vpZ9L2K
         zQ8Q==
X-Gm-Message-State: AOJu0YzkpGnJMz0rgbeVLGRaG4/+gwkFDkjLYtrlzq+JuVm/210c7ZlT
	BsmVwjlDYqdpbabKfHW3yCToZDHyi0407YfeDe7OFspq1m7quhM9e09hrRS6
X-Gm-Gg: ASbGnctnyL5gcfkQCG09xDIpANc1LeWu50VXHwfxCLaj5eVoyMEWPeMxPuI+y3NyWw2
	7a8lz6MLDIPYHVEbGLVSNjYQcM45LiCLCD/FGTmSQyf6uuS/LTsOHrxXeSgRdVWz1LdF93AazqS
	poyCq2dr4ol1HcyCIebBaMOIBQxLheJXR+DV2AaBxtXycIdUQ8KQv1iMx4WAObTbpwKplkVj9HA
	GErOrOXrmZrVurMz/qEpnRKuyazZnJcXjXhJ7aHXidV0OmZX8Ut7n4YhPjvG9YdDfzYQQ==
X-Google-Smtp-Source: AGHT+IFapis9jAyT554E6fuQvmd1pQ8OYxKStYaDf0fgAY6EUMqsav3hxB1KLfcCsXOIHD3IhhcLNA==
X-Received: by 2002:a05:6902:144a:b0:e5b:21e4:d88e with SMTP id 3f1490d57ef6-e5da8167aa6mr6207648276.28.1739508633402;
        Thu, 13 Feb 2025 20:50:33 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e5dadead40asm803702276.18.2025.02.13.20.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:50:32 -0800 (PST)
Date: Fri, 14 Feb 2025 12:50:27 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 0/8] add more ref consistency checks
Message-ID: <Z67LkxAFIAeaYr0U@ArchLinux>
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

Hi All:

This patch enhances the following things:

1. [PATCH v4 4/8]: update the tests to verify that we don't report any
   errors to the user in some cases. Also, suggested by Junio, make sure
   that we check whether there is a trailing space after "# packed-refs
   with:".
2. [PATCH v4 6/8]: instead of greedily calculating the name of the line,
   lazily compute when there is any errors. And use the HERE docs to
   improve the test script.
3. [PATCH v4 7/8]: instead of storing the states, we parse the file
   again to check whether the file is sorted to avoid allocating too
   much memory. And use the HERE docs to improve the test script.
4. [PATCH v4 8/8]: update the documentation to emphasis the default. And
   add tests to exercise the code.

shejialuo (8):
  t0602: use subshell to ensure working directory unchanged
  builtin/refs: get worktrees without reading head information
  packed-backend: check whether the "packed-refs" is regular file
  packed-backend: add "packed-refs" header consistency check
  packed-backend: check whether the refname contains NUL characters
  packed-backend: add "packed-refs" entry consistency check
  packed-backend: check whether the "packed-refs" is sorted
  builtin/fsck: add `git refs verify` child process

 Documentation/fsck-msgids.txt |   14 +
 Documentation/git-fsck.txt    |    7 +-
 builtin/fsck.c                |   33 +-
 builtin/refs.c                |    2 +-
 fsck.h                        |    4 +
 refs/packed-backend.c         |  349 +++++++++-
 t/t0602-reffiles-fsck.sh      | 1205 ++++++++++++++++++++-------------
 worktree.c                    |    5 +
 worktree.h                    |    6 +
 9 files changed, 1140 insertions(+), 485 deletions(-)

Range-diff against v3:
1:  20889b7b18 = 1:  20889b7b18 t0602: use subshell to ensure working directory unchanged
2:  9d7780e953 = 2:  9d7780e953 builtin/refs: get worktrees without reading head information
3:  44d26f6440 = 3:  44d26f6440 packed-backend: check whether the "packed-refs" is regular file
4:  a9ab7af16a ! 4:  976c5baba0 packed-backend: add "packed-refs" header consistency check
    @@ Commit message
     
         In "packed-backend.c::create_snapshot", if there is a header (the line
         which starts with '#'), we will check whether the line starts with "#
    -    pack-refs with:". As we are going to implement the header consistency
    -    check, we should port this check into "packed_fsck".
    +    pack-refs with:". Before we port this check into "packed_fsck", let's
    +    fix "create_snapshot" to check the prefix "# packed-ref with: " instead
    +    of "# packed-ref with:" due to that we will always write a single
    +    trailing space after the colon.
     
         However, we need to consider other situations and discuss whether we
         need to add checks.
    @@ Commit message
            user. This is because in older Git version, we never write header in
            the "packed-refs" file. Also, we do allow no header in "packed-refs"
            in runtime.
    -    2. If the header content does not start with "# packed-ref with:", we
    +    2. If the header content does not start with "# packed-ref with: ", we
            should report an error just like what "create_snapshot" does. So,
            create a new fsck message "badPackedRefHeader(ERROR)" for this.
         3. If the header content is not the same as the constant string
    @@ fsck.h: enum fsck_msg_type {
      	FUNC(ZERO_PADDED_DATE, ERROR) \
     
      ## refs/packed-backend.c ##
    +@@ refs/packed-backend.c: static struct snapshot *create_snapshot(struct packed_ref_store *refs)
    + 
    + 		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
    + 
    +-		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
    ++		if (!skip_prefix(tmp, "# pack-refs with: ", (const char **)&p))
    + 			die_invalid_line(refs->path,
    + 					 snapshot->buf,
    + 					 snapshot->eof - snapshot->buf);
     @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
      	return empty_ref_iterator_begin();
      }
      
     +static int packed_fsck_ref_next_line(struct fsck_options *o,
    -+				     struct strbuf *packed_entry, const char *start,
    ++				     unsigned long line_number, const char *start,
     +				     const char *eof, const char **eol)
     +{
     +	int ret = 0;
     +
     +	*eol = memchr(start, '\n', eof - start);
     +	if (!*eol) {
    ++		struct strbuf packed_entry = STRBUF_INIT;
     +		struct fsck_ref_report report = { 0 };
     +
    -+		report.path = packed_entry->buf;
    ++		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    ++		report.path = packed_entry.buf;
     +		ret = fsck_report_ref(o, &report,
     +				      FSCK_MSG_PACKED_REF_ENTRY_NOT_TERMINATED,
     +				      "'%.*s' is not terminated with a newline",
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +		 * the buffer.
     +		 */
     +		*eol = eof;
    ++		strbuf_release(&packed_entry);
     +	}
     +
     +	return ret;
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +static int packed_fsck_ref_header(struct fsck_options *o,
     +				  const char *start, const char *eol)
     +{
    -+	if (!starts_with(start, "# pack-refs with:")) {
    ++	if (!starts_with(start, "# pack-refs with: ")) {
     +		struct fsck_ref_report report = { 0 };
     +		report.path = "packed-refs.header";
     +
     +		return fsck_report_ref(o, &report,
     +				       FSCK_MSG_BAD_PACKED_REF_HEADER,
    -+				       "'%.*s' does not start with '# pack-refs with:'",
    ++				       "'%.*s' does not start with '# pack-refs with: '",
     +				       (int)(eol - start), start);
     +	}
     +
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +static int packed_fsck_ref_content(struct fsck_options *o,
     +				   const char *start, const char *eof)
     +{
    -+	struct strbuf packed_entry = STRBUF_INIT;
     +	unsigned long line_number = 1;
     +	const char *eol;
     +	int ret = 0;
     +
    -+	strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    -+	ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
    ++	ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
     +	if (*start == '#') {
     +		ret |= packed_fsck_ref_header(o, start, eol);
     +
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +		line_number++;
     +	}
     +
    -+	strbuf_release(&packed_entry);
     +	return ret;
     +}
     +
    @@ t/t0602-reffiles-fsck.sh: test_expect_success SYMLINKS 'the filetype of packed-r
     +
     +		for bad_header in "# pack-refs wit: peeled fully-peeled sorted " \
     +				  "# pack-refs with traits: peeled fully-peeled sorted " \
    -+				  "# pack-refs with a: peeled fully-peeled"
    ++				  "# pack-refs with a: peeled fully-peeled" \
    ++				  "# pack-refs with:peeled fully-peeled sorted"
     +		do
     +			printf "%s\n" "$bad_header" >.git/packed-refs &&
     +			test_must_fail git refs verify 2>err &&
     +			cat >expect <<-EOF &&
    -+			error: packed-refs.header: badPackedRefHeader: '\''$bad_header'\'' does not start with '\''# pack-refs with:'\''
    ++			error: packed-refs.header: badPackedRefHeader: '\''$bad_header'\'' does not start with '\''# pack-refs with: '\''
     +			EOF
     +			rm .git/packed-refs &&
     +			test_cmp expect err || return 1
     +		done
     +	)
     +'
    ++
    ++test_expect_success 'packed-refs missing header should not be reported' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit default &&
    ++
    ++		printf "$(git rev-parse HEAD) refs/heads/main\n" >.git/packed-refs &&
    ++		git refs verify 2>err &&
    ++		test_must_be_empty err
    ++	)
    ++'
    ++
    ++test_expect_success 'packed-refs unknown traits should not be reported' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit default &&
    ++
    ++		printf "# pack-refs with: peeled fully-peeled sorted foo\n" >.git/packed-refs &&
    ++		git refs verify 2>err &&
    ++		test_must_be_empty err
    ++	)
    ++'
     +
      test_done
5:  9b075434a1 = 5:  b66f142d7f packed-backend: check whether the refname contains NUL characters
6:  a976508319 ! 6:  f68028e171 packed-backend: add "packed-refs" entry consistency check
    @@ refs/packed-backend.c: static int packed_fsck_ref_header(struct fsck_options *o,
      
     +static int packed_fsck_ref_peeled_line(struct fsck_options *o,
     +				       struct ref_store *ref_store,
    -+				       struct strbuf *packed_entry,
    ++				       unsigned long line_number,
     +				       const char *start, const char *eol)
     +{
    ++	struct strbuf packed_entry = STRBUF_INIT;
     +	struct fsck_ref_report report = { 0 };
     +	struct object_id peeled;
     +	const char *p;
    -+
    -+	report.path = packed_entry->buf;
    ++	int ret = 0;
     +
     +	/*
     +	 * Skip the '^' and parse the peeled oid.
     +	 */
     +	start++;
    -+	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo))
    -+		return fsck_report_ref(o, &report,
    -+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
    -+				       "'%.*s' has invalid peeled oid",
    -+				       (int)(eol - start), start);
    -+
    -+	if (p != eol)
    -+		return fsck_report_ref(o, &report,
    -+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
    -+				       "has trailing garbage after peeled oid '%.*s'",
    -+				       (int)(eol - p), p);
    -+
    -+	return 0;
    ++	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo)) {
    ++		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    ++		report.path = packed_entry.buf;
    ++
    ++		ret = fsck_report_ref(o, &report,
    ++				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
    ++				      "'%.*s' has invalid peeled oid",
    ++				      (int)(eol - start), start);
    ++		goto cleanup;
    ++	}
    ++
    ++	if (p != eol) {
    ++		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    ++		report.path = packed_entry.buf;
    ++
    ++		ret = fsck_report_ref(o, &report,
    ++				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
    ++				      "has trailing garbage after peeled oid '%.*s'",
    ++				      (int)(eol - p), p);
    ++		goto cleanup;
    ++	}
    ++cleanup:
    ++	strbuf_release(&packed_entry);
    ++	return ret;
     +}
     +
     +static int packed_fsck_ref_main_line(struct fsck_options *o,
     +				     struct ref_store *ref_store,
    -+				     struct strbuf *packed_entry,
    ++				     unsigned long line_number,
     +				     struct strbuf *refname,
     +				     const char *start, const char *eol)
     +{
    ++	struct strbuf packed_entry = STRBUF_INIT;
     +	struct fsck_ref_report report = { 0 };
     +	struct object_id oid;
     +	const char *p;
    ++	int ret = 0;
     +
    -+	report.path = packed_entry->buf;
    ++	if (parse_oid_hex_algop(start, &oid, &p, ref_store->repo->hash_algo)) {
    ++		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    ++		report.path = packed_entry.buf;
     +
    -+	if (parse_oid_hex_algop(start, &oid, &p, ref_store->repo->hash_algo))
    -+		return fsck_report_ref(o, &report,
    -+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
    -+				       "'%.*s' has invalid oid",
    -+				       (int)(eol - start), start);
    ++		ret = fsck_report_ref(o, &report,
    ++				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
    ++				      "'%.*s' has invalid oid",
    ++				      (int)(eol - start), start);
    ++		goto cleanup;
    ++	}
     +
    -+	if (p == eol || !isspace(*p))
    -+		return fsck_report_ref(o, &report,
    -+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
    -+				       "has no space after oid '%s' but with '%.*s'",
    -+				       oid_to_hex(&oid), (int)(eol - p), p);
    ++	if (p == eol || !isspace(*p)) {
    ++		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    ++		report.path = packed_entry.buf;
    ++
    ++		ret = fsck_report_ref(o, &report,
    ++				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
    ++				      "has no space after oid '%s' but with '%.*s'",
    ++				      oid_to_hex(&oid), (int)(eol - p), p);
    ++		goto cleanup;
    ++	}
     +
     +	p++;
     +	strbuf_reset(refname);
     +	strbuf_add(refname, p, eol - p);
    -+	if (refname_contains_nul(refname))
    -+		return fsck_report_ref(o, &report,
    -+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
    -+				       "refname '%s' contains NULL binaries",
    -+				       refname->buf);
    -+
    -+	if (check_refname_format(refname->buf, 0))
    -+		return fsck_report_ref(o, &report,
    -+				       FSCK_MSG_BAD_REF_NAME,
    -+				       "has bad refname '%s'", refname->buf);
    -+
    -+	return 0;
    ++	if (refname_contains_nul(refname)) {
    ++		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    ++		report.path = packed_entry.buf;
    ++
    ++		ret = fsck_report_ref(o, &report,
    ++				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
    ++				      "refname '%s' contains NULL binaries",
    ++				      refname->buf);
    ++	}
    ++
    ++	if (check_refname_format(refname->buf, 0)) {
    ++		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    ++		report.path = packed_entry.buf;
    ++
    ++		ret = fsck_report_ref(o, &report,
    ++				      FSCK_MSG_BAD_REF_NAME,
    ++				      "has bad refname '%s'", refname->buf);
    ++	}
    ++
    ++cleanup:
    ++	strbuf_release(&packed_entry);
    ++	return ret;
     +}
     +
      static int packed_fsck_ref_content(struct fsck_options *o,
     +				   struct ref_store *ref_store,
      				   const char *start, const char *eof)
      {
    - 	struct strbuf packed_entry = STRBUF_INIT;
     +	struct strbuf refname = STRBUF_INIT;
      	unsigned long line_number = 1;
      	const char *eol;
    @@ refs/packed-backend.c: static int packed_fsck_ref_content(struct fsck_options *o
      	}
      
     +	while (start < eof) {
    -+		strbuf_reset(&packed_entry);
    -+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    -+		ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
    -+		ret |= packed_fsck_ref_main_line(o, ref_store, &packed_entry, &refname, start, eol);
    ++		ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
    ++		ret |= packed_fsck_ref_main_line(o, ref_store, line_number, &refname, start, eol);
     +		start = eol + 1;
     +		line_number++;
     +		if (start < eof && *start == '^') {
    -+			strbuf_reset(&packed_entry);
    -+			strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    -+			ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
    -+			ret |= packed_fsck_ref_peeled_line(o, ref_store, &packed_entry,
    ++			ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
    ++			ret |= packed_fsck_ref_peeled_line(o, ref_store, line_number,
     +							   start, eol);
     +			start = eol + 1;
     +			line_number++;
     +		}
     +	}
     +
    -+	strbuf_release(&packed_entry);
     +	strbuf_release(&refname);
    - 	strbuf_release(&packed_entry);
      	return ret;
      }
    + 
     @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      		goto cleanup;
      	}
    @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      cleanup:
     
      ## t/t0602-reffiles-fsck.sh ##
    -@@ t/t0602-reffiles-fsck.sh: test_expect_success 'packed-refs header should be checked' '
    +@@ t/t0602-reffiles-fsck.sh: test_expect_success 'packed-refs unknown traits should not be reported' '
      	)
      '
      
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'packed-refs header should be chec
     +		tag_2_peeled_oid=$(git rev-parse annotated-tag-2^{}) &&
     +		short_oid=$(printf "%s" $tag_1_peeled_oid | cut -c 1-4) &&
     +
    -+		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
    -+		printf "%s\n" "$short_oid refs/heads/branch-1" >>.git/packed-refs &&
    -+		printf "%sx\n" "$branch_1_oid" >>.git/packed-refs &&
    -+		printf "%s   refs/heads/bad-branch\n" "$branch_2_oid" >>.git/packed-refs &&
    -+		printf "%s refs/heads/branch.\n" "$branch_2_oid" >>.git/packed-refs &&
    -+		printf "%s refs/tags/annotated-tag-3\n" "$tag_1_oid" >>.git/packed-refs &&
    -+		printf "^%s\n" "$short_oid" >>.git/packed-refs &&
    -+		printf "%s refs/tags/annotated-tag-4.\n" "$tag_2_oid" >>.git/packed-refs &&
    -+		printf "^%s garbage\n" "$tag_2_peeled_oid" >>.git/packed-refs &&
    ++		cat >.git/packed-refs <<-EOF &&
    ++		# pack-refs with: peeled fully-peeled sorted
    ++		$short_oid refs/heads/branch-1
    ++		${branch_1_oid}x
    ++		$branch_2_oid   refs/heads/bad-branch
    ++		$branch_2_oid refs/heads/branch.
    ++		$tag_1_oid refs/tags/annotated-tag-3
    ++		^$short_oid
    ++		$tag_2_oid refs/tags/annotated-tag-4.
    ++		^$tag_2_peeled_oid garbage
    ++		EOF
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
     +		error: packed-refs line 2: badPackedRefEntry: '\''$short_oid refs/heads/branch-1'\'' has invalid oid
7:  707e3e2151 ! 7:  4a7adf293f packed-backend: check whether the "packed-refs" is sorted
    @@ Commit message
         sorted in this case.
     
         Update the "packed_fsck_ref_header" to know whether there is a "sorted"
    -    trail in the header. Then, create a new structure "fsck_packed_ref_entry"
    -    to store the state during the parsing process for every entry. It may
    -    seem that we could just add a new "struct strbuf refname" into the
    -    "struct fsck_packed_ref_entry" and during the parsing process, we could
    -    store the refname into this structure and thus we could compare later.
    -    However, this is not a good design due to the following reasons:
    +    trail in the header. It may seem that we could record all refnames
    +    during the parsing process and then compare later. However, this is not
    +    a good design due to the following reasons:
     
         1. Because we need to store the state across the whole checking
            lifetime, we would consume a lot of memory if there are many entries
            in the "packed-refs" file.
    -    2. The most important thing is that we cannot reuse the existing compare
    -       functions which cause repetition.
    +    2. We cannot reuse the existing compare function "cmp_packed_ref_records"
    +       which cause repetition.
     
    -    So, instead of storing the "struct strbuf", let's use the existing
    -    structure "struct snaphost_record". And thus we could use the existing
    -    function "cmp_packed_ref_records".
    +    Because "cmp_packed_ref_records" needs an extra parameter "struct
    +    snaphost", extract the common part into a new function
    +    "cmp_packed_ref_records" to reuse this function to compare.
     
    -    However, this function need an extra parameter for "struct snaphost".
    -    Extract the common part into a new function "cmp_packed_ref_records" to
    -    reuse this function to compare.
    -
    -    Then, create a new function "packed_fsck_ref_sorted" to use the new fsck
    -    message "packedRefUnsorted(ERROR)" to report to the user.
    +    Then, create a new function "packed_fsck_ref_sorted" to parse the file
    +    again and user the new fsck message "packedRefUnsorted(ERROR)" to report
    +    to the user if the file is not sorted.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ refs/packed-backend.c: static int cmp_packed_ref_records(const void *v1, const v
      /*
       * Compare a snapshot record at `rec` to the specified NUL-terminated
       * refname.
    -@@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
    - 	return empty_ref_iterator_begin();
    - }
    - 
    -+struct fsck_packed_ref_entry {
    -+	unsigned long line_number;
    -+
    -+	struct snapshot_record record;
    -+};
    -+
    -+static struct fsck_packed_ref_entry *create_fsck_packed_ref_entry(unsigned long line_number,
    -+								  const char *start)
    -+{
    -+	struct fsck_packed_ref_entry *entry = xcalloc(1, sizeof(*entry));
    -+	entry->line_number = line_number;
    -+	entry->record.start = start;
    -+	return entry;
    -+}
    -+
    -+static void free_fsck_packed_ref_entries(struct fsck_packed_ref_entry **entries, size_t nr)
    -+{
    -+	for (size_t i = 0; i < nr; i++)
    -+		free(entries[i]);
    -+	free(entries);
    -+}
    -+
    - static int packed_fsck_ref_next_line(struct fsck_options *o,
    - 				     struct strbuf *packed_entry, const char *start,
    - 				     const char *eof, const char **eol)
     @@ refs/packed-backend.c: static int packed_fsck_ref_next_line(struct fsck_options *o,
      }
      
    @@ refs/packed-backend.c: static int packed_fsck_ref_next_line(struct fsck_options
     +				  const char *start, const char *eol,
     +				  unsigned int *sorted)
      {
    --	if (!starts_with(start, "# pack-refs with:")) {
    +-	if (!starts_with(start, "# pack-refs with: ")) {
     +	struct string_list traits = STRING_LIST_INIT_NODUP;
     +	char *tmp_line;
     +	int ret = 0;
     +	char *p;
     +
     +	tmp_line = xmemdupz(start, eol - start);
    -+	if (!skip_prefix(tmp_line, "# pack-refs with:", (const char **)&p)) {
    ++	if (!skip_prefix(tmp_line, "# pack-refs with: ", (const char **)&p)) {
      		struct fsck_ref_report report = { 0 };
      		report.path = "packed-refs.header";
      
     -		return fsck_report_ref(o, &report,
     -				       FSCK_MSG_BAD_PACKED_REF_HEADER,
    --				       "'%.*s' does not start with '# pack-refs with:'",
    +-				       "'%.*s' does not start with '# pack-refs with: '",
     -				       (int)(eol - start), start);
     +		ret = fsck_report_ref(o, &report,
     +				      FSCK_MSG_BAD_PACKED_REF_HEADER,
    -+				      "'%.*s' does not start with '# pack-refs with:'",
    ++				      "'%.*s' does not start with '# pack-refs with: '",
     +				      (int)(eol - start), start);
     +		goto cleanup;
      	}
    @@ refs/packed-backend.c: static int packed_fsck_ref_next_line(struct fsck_options
      
      static int packed_fsck_ref_peeled_line(struct fsck_options *o,
     @@ refs/packed-backend.c: static int packed_fsck_ref_main_line(struct fsck_options *o,
    - 	return 0;
    + 	return ret;
      }
      
     +static int packed_fsck_ref_sorted(struct fsck_options *o,
     +				  struct ref_store *ref_store,
    -+				  struct fsck_packed_ref_entry **entries,
    -+				  size_t nr)
    ++				  const char *start, const char *eof)
     +{
     +	size_t hexsz = ref_store->repo->hash_algo->hexsz;
     +	struct strbuf packed_entry = STRBUF_INIT;
     +	struct fsck_ref_report report = { 0 };
     +	struct strbuf refname1 = STRBUF_INIT;
     +	struct strbuf refname2 = STRBUF_INIT;
    ++	unsigned long line_number = 1;
    ++	const char *former = NULL;
    ++	const char *current;
    ++	const char *eol;
     +	int ret = 0;
     +
    -+	for (size_t i = 1; i < nr; i++) {
    -+		const char *r1 = entries[i - 1]->record.start + hexsz + 1;
    -+		const char *r2 = entries[i]->record.start + hexsz + 1;
    ++	if (*start == '#') {
    ++		eol = memchr(start, '\n', eof - start);
    ++		start = eol + 1;
    ++		line_number++;
    ++	}
    ++
    ++	for (; start < eof; line_number++, start = eol + 1) {
    ++		eol = memchr(start, '\n', eof - start);
    ++
    ++		if (*start == '^')
    ++			continue;
    ++
    ++		if (!former) {
    ++			former = start + hexsz + 1;
    ++			continue;
    ++		}
     +
    -+		if (cmp_packed_refname(r1, r2) >= 0) {
    ++		current = start + hexsz + 1;
    ++		if (cmp_packed_refname(former, current) >= 0) {
     +			const char *err_fmt =
    -+				"refname '%s' is not less than next refname '%s'";
    -+			const char *eol;
    -+			eol = memchr(entries[i - 1]->record.start, '\n',
    -+				     entries[i - 1]->record.len);
    -+			strbuf_add(&refname1, r1, eol - r1);
    -+			eol = memchr(entries[i]->record.start, '\n',
    -+				     entries[i]->record.len);
    -+			strbuf_add(&refname2, r2, eol - r2);
    ++				"refname '%s' is less than previous refname '%s'";
    ++
    ++			eol = memchr(former, '\n', eof - former);
    ++			strbuf_add(&refname1, former, eol - former);
    ++			eol = memchr(current, '\n', eof - current);
    ++			strbuf_add(&refname2, current, eol - current);
     +
    -+			strbuf_addf(&packed_entry, "packed-refs line %lu",
    -+				    entries[i - 1]->line_number);
    ++			strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
     +			report.path = packed_entry.buf;
     +			ret = fsck_report_ref(o, &report,
     +					      FSCK_MSG_PACKED_REF_UNSORTED,
    -+					      err_fmt, refname1.buf, refname2.buf);
    ++					      err_fmt, refname2.buf, refname1.buf);
     +			goto cleanup;
     +		}
    ++		former = current;
     +	}
     +
     +cleanup:
    @@ refs/packed-backend.c: static int packed_fsck_ref_main_line(struct fsck_options
     +
      static int packed_fsck_ref_content(struct fsck_options *o,
      				   struct ref_store *ref_store,
    ++				   unsigned int *sorted,
      				   const char *start, const char *eof)
      {
    - 	struct strbuf packed_entry = STRBUF_INIT;
    -+	struct fsck_packed_ref_entry **entries;
      	struct strbuf refname = STRBUF_INIT;
    - 	unsigned long line_number = 1;
    -+	unsigned int sorted = 0;
    -+	size_t entry_alloc = 20;
    -+	size_t entry_nr = 0;
    - 	const char *eol;
    - 	int ret = 0;
    +@@ refs/packed-backend.c: static int packed_fsck_ref_content(struct fsck_options *o,
      
    - 	strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    - 	ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
    + 	ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
      	if (*start == '#') {
     -		ret |= packed_fsck_ref_header(o, start, eol);
    -+		ret |= packed_fsck_ref_header(o, start, eol, &sorted);
    ++		ret |= packed_fsck_ref_header(o, start, eol, sorted);
      
      		start = eol + 1;
      		line_number++;
    - 	}
    +@@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
    + 	struct packed_ref_store *refs = packed_downcast(ref_store,
    + 							REF_STORE_READ, "fsck");
    + 	struct strbuf packed_ref_content = STRBUF_INIT;
    ++	unsigned int sorted = 0;
    + 	int ret = 0;
    + 	int fd;
      
    -+	ALLOC_ARRAY(entries, entry_alloc);
    - 	while (start < eof) {
    -+		struct fsck_packed_ref_entry *entry
    -+			= create_fsck_packed_ref_entry(line_number, start);
    -+
    -+		ALLOC_GROW(entries, entry_nr + 1, entry_alloc);
    -+		entries[entry_nr++] = entry;
    - 		strbuf_reset(&packed_entry);
    - 		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    - 		ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
    -@@ refs/packed-backend.c: static int packed_fsck_ref_content(struct fsck_options *o,
    - 			start = eol + 1;
    - 			line_number++;
    - 		}
    -+		entry->record.len = start - entry->record.start;
    +@@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
    + 		goto cleanup;
      	}
      
    +-	ret = packed_fsck_ref_content(o, ref_store, packed_ref_content.buf,
    ++	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
    + 				      packed_ref_content.buf + packed_ref_content.len);
     +	if (!ret && sorted)
    -+		ret |= packed_fsck_ref_sorted(o, ref_store, entries, entry_nr);
    -+
    - 	strbuf_release(&packed_entry);
    - 	strbuf_release(&refname);
    - 	strbuf_release(&packed_entry);
    -+	free_fsck_packed_ref_entries(entries, entry_nr);
    - 	return ret;
    - }
    ++		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
    ++					     packed_ref_content.buf + packed_ref_content.len);
      
    + cleanup:
    + 	strbuf_release(&packed_ref_content);
     
      ## t/t0602-reffiles-fsck.sh ##
     @@ t/t0602-reffiles-fsck.sh: test_expect_success 'packed-refs content should be checked' '
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'packed-refs content should be che
     +		refname1="refs/heads/main" &&
     +		refname2="refs/heads/foo" &&
     +		refname3="refs/tags/foo" &&
    -+		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
    -+		printf "%s %s\n" "$branch_2_oid" "$refname1" >>.git/packed-refs &&
    -+		printf "%s %s\n" "$branch_1_oid" "$refname2" >>.git/packed-refs &&
    ++
    ++		cat >.git/packed-refs <<-EOF &&
    ++		# pack-refs with: peeled fully-peeled sorted
    ++		EOF
    ++		git refs verify 2>err &&
    ++		rm .git/packed-refs &&
    ++		test_must_be_empty err &&
    ++
    ++		cat >.git/packed-refs <<-EOF &&
    ++		# pack-refs with: peeled fully-peeled sorted
    ++		$branch_2_oid $refname1
    ++		EOF
    ++		git refs verify 2>err &&
    ++		rm .git/packed-refs &&
    ++		test_must_be_empty err &&
    ++
    ++		cat >.git/packed-refs <<-EOF &&
    ++		# pack-refs with: peeled fully-peeled sorted
    ++		$branch_2_oid $refname1
    ++		$branch_1_oid $refname2
    ++		$tag_1_oid $refname3
    ++		EOF
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		error: packed-refs line 2: packedRefUnsorted: refname '\''$refname1'\'' is not less than next refname '\''$refname2'\''
    ++		error: packed-refs line 3: packedRefUnsorted: refname '\''$refname2'\'' is less than previous refname '\''$refname1'\''
     +		EOF
     +		rm .git/packed-refs &&
     +		test_cmp expect err &&
     +
    -+		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
    -+		printf "%s %s\n" "$tag_1_oid" "$refname3" >>.git/packed-refs &&
    -+		printf "^%s\n" "$tag_1_peeled_oid" >>.git/packed-refs &&
    -+		printf "%s %s\n" "$branch_2_oid" "$refname2" >>.git/packed-refs &&
    ++		cat >.git/packed-refs <<-EOF &&
    ++		# pack-refs with: peeled fully-peeled sorted
    ++		$tag_1_oid $refname3
    ++		^$tag_1_peeled_oid
    ++		$branch_2_oid $refname2
    ++		EOF
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		error: packed-refs line 2: packedRefUnsorted: refname '\''$refname3'\'' is not less than next refname '\''$refname2'\''
    ++		error: packed-refs line 4: packedRefUnsorted: refname '\''$refname2'\'' is less than previous refname '\''$refname3'\''
     +		EOF
     +		rm .git/packed-refs &&
     +		test_cmp expect err
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'packed-refs content should be che
     +		refname1="refs/heads/main" &&
     +		refname2="refs/heads/foo" &&
     +		refname3="refs/tags/foo" &&
    -+		printf "# pack-refs with: peeled fully-peeled \n"  >.git/packed-refs &&
    -+		printf "%s %s\n" "$branch_2_oid" "$refname1" >>.git/packed-refs &&
    -+		printf "%s %s\n" "$branch_1_oid" "$refname2" >>.git/packed-refs &&
    ++
    ++		cat >.git/packed-refs <<-EOF &&
    ++		# pack-refs with: peeled fully-peeled
    ++		$branch_2_oid $refname1
    ++		$branch_1_oid $refname2
    ++		EOF
     +		git refs verify 2>err &&
     +		test_must_be_empty err
     +	)
8:  4f2170aa7c ! 8:  2dd3437478 builtin/fsck: add `git refs verify` child process
    @@ Commit message
         "git-fsck(1)" which would implicitly check the consistency of refs to
         die the program.
     
    +    Last, update the test to exercise the code.
    +
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: shejialuo <shejialuo@gmail.com>
    @@ Documentation/git-fsck.txt: care about this output and want to speed it up furth
     +--[no-]references::
     +	Control whether to check the references database consistency
     +	via 'git refs verify'. See linkgit:git-refs[1] for details.
    ++	The default is to check the references database.
     +
      CONFIGURATION
      -------------
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      	if (connectivity_only) {
      		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
      		for_each_packed_object(the_repository,
    +
    + ## t/t0602-reffiles-fsck.sh ##
    +@@ t/t0602-reffiles-fsck.sh: test_expect_success 'packed-ref without sorted trait should not be checked' '
    + 	)
    + '
    + 
    ++test_expect_success '--[no-]references option should apply to fsck' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	branch_dir_prefix=.git/refs/heads &&
    ++	(
    ++		cd repo &&
    ++		test_commit default &&
    ++		for trailing_content in " garbage" "    more garbage"
    ++		do
    ++			printf "%s" "$(git rev-parse HEAD)$trailing_content" >$branch_dir_prefix/branch-garbage &&
    ++			git fsck 2>err &&
    ++			cat >expect <<-EOF &&
    ++			warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
    ++			EOF
    ++			rm $branch_dir_prefix/branch-garbage &&
    ++			test_cmp expect err || return 1
    ++		done &&
    ++
    ++		for trailing_content in " garbage" "    more garbage"
    ++		do
    ++			printf "%s" "$(git rev-parse HEAD)$trailing_content" >$branch_dir_prefix/branch-garbage &&
    ++			git fsck --references 2>err &&
    ++			cat >expect <<-EOF &&
    ++			warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
    ++			EOF
    ++			rm $branch_dir_prefix/branch-garbage &&
    ++			test_cmp expect err || return 1
    ++		done &&
    ++
    ++		for trailing_content in " garbage" "    more garbage"
    ++		do
    ++			printf "%s" "$(git rev-parse HEAD)$trailing_content" >$branch_dir_prefix/branch-garbage &&
    ++			git fsck --no-references 2>err &&
    ++			rm $branch_dir_prefix/branch-garbage &&
    ++			test_must_be_empty err || return 1
    ++		done
    ++	)
    ++'
    ++
    + test_done
-- 
2.48.1

