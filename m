Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414D1F60A
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821316; cv=none; b=uaxBURZjMX/kFxYxIDB7FYwuvV4SnA90jl1N+fbE/3rhGteER32xU1lkjh72GtedB1sRGUM0LAnVZC0cnx8FGzayLpZk6HIWXu4XPvnE4vWtzdSKGyBM4FomZdvNhzGyAjdDQhcDOEygvjdhAC8yyBEwoogF46YgkWxr52+2rmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821316; c=relaxed/simple;
	bh=Dkp9Y4yJgBDDOOAih4Z+ONm+qdwvbdyEhbbQzplohFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxmc6J3CwQ4pfl3vik124EFbUe2PPtG36Okycu2JNY8b52qpdNDgSF+eUQFTT8MvxIPKYKGuGyMmFxVZofmucikJo4RBdmwb0MiUfw5DiTORwRt41E04TZeLXhGK1JHyMXUkUFsJmL4g95RCfMmiRuKt5cqOeg4g/2qot9rbWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBnY9lgQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBnY9lgQ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f01fe1ce8so6865165ad.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 21:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738821312; x=1739426112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vqKwVFcJ8BGiD+WmdQmHTWGsVVKY5yDMhrjjJ6F0t0A=;
        b=lBnY9lgQCpXpThrEDsLwHMqH8BEY3syorsSxOHdNsOIfjlPkze8QjOYd1+7ix3dq7o
         JrRlrmIAKe6ptYG7KqPvj2Ny2s+VI+n/1SJvvymzfM+DR6524lq4fAhmZe3bj8mITlb2
         juCVLhQrmdFd0c/XG0nbEd9wa8S0p9w9fpr6Q51nliuDgg5I0cL+3b1D7nBv5FjMMdap
         6BIGzNpTD3kFGjJ4AmLAO6EC+wvXIck62guPHasl4y3zw2JYZYMjpGl5hpn4GsXVF7Mk
         KBU5M8+w7SD6UPOgYOGa53Ja6dzNd+X/p+Z4OTi87FEK2YE6irYtfiUewuw+6Tj3XnIC
         j/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821312; x=1739426112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqKwVFcJ8BGiD+WmdQmHTWGsVVKY5yDMhrjjJ6F0t0A=;
        b=Iu8jgPIDFlHxKyj4VG+io3cPKb+LG9vK7T6nbT1zoLPrEoPXzFMMK7LFxW4MGf+OI4
         bpn1yH6NFIFdzLl8J2SgAXIkvKckuw7fPaSrMIJ7sul0Eu6eLl09jqr4tc0HCSL7AB2M
         cT/6T9MBlO0JJQzzI9h/sAuTBYx2CHa34T10zKjdr5tXGl//GiwcoNyV5dZDskgehlDm
         dO586XeDoVdE+DWifmMblvaDa9L1QrEM1f6hoZ0ffFCOdBd+MeelzAt+d3qVftfVrd0V
         xjFJssMcIm6e6PWu27pCztmRKxeVJzk888aaK+t6InBXoCKbnHGjk5moADh+WO/680qi
         Clyw==
X-Gm-Message-State: AOJu0YzFwNakkse2ZNSMcq26tGeUe5/+YQjzK8kH2MT6JvN9r14rV7TV
	ob/r+/DQhO8k1qC+ntYRLuq9gvi5V9hTDi1+8Ug2f3Ei5+NNKcwz3+Ferg==
X-Gm-Gg: ASbGncvW7EW9wmGy18QckJWfsjOuS0RfO2meISJLOcv9M2E/ihbYoYXCByL5II6O4wC
	HiaT21xDBEvmcDLin1OEBPDaq2p2D0noaghorm/GfY66oF/HS3MBbHZvwsp5l1O1axYKRk2ko1l
	iTfTaHmLJYxlLyYE+A9orHKwNoYLrLCkiTmuetj4hoGm3x288KYgBJzAnXQDqSPWd3MzXCV4iXK
	6QTwLkb1mBmZn4XZnL76dcNDpCFvkKllOXCKrYVxZmB4f8gnfD+afDJuRzwYslTFMvflQ==
X-Google-Smtp-Source: AGHT+IGZYamoopq0axb/qkqIDQcyqpJgLmYEWw9PT7kmdx//iBEXISUtVu21TVx8Y8bF/8cKYGeYSg==
X-Received: by 2002:a05:6a00:ad07:b0:72f:5950:13ad with SMTP id d2e1a72fcca58-7303521c7a8mr10578813b3a.20.1738821311823;
        Wed, 05 Feb 2025 21:55:11 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73048ad2917sm456292b3a.48.2025.02.05.21.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:55:11 -0800 (PST)
Date: Thu, 6 Feb 2025 13:56:52 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/8] add more ref consistency checks
Message-ID: <Z6RPJI10-2QkwyqH@ArchLinux>
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

Hi All:

This new version handles the following problem:

1. [PACTH v3 2/8]: enhance the commit message.
2. [PACTH v3 3/8]: delete some paragraph in the commit message to make
   it more clear.
3. [PATCH v3 4/8]: remove unneeded checks for header and related tests
   and update the commit message.
4. [PATCH v3 5/8]: enhance the code suggested by Patrick.
5. [PATCH v3 6/8]: enhance the commit message and add a comment to
   explain why we need to execute `start++` for peeled line.
6. [PATCH v3 7/8]: parse the header to get whether there is a "sorted"
   trait. If so, we need to check whether it is sorted and update the
   test to exercise.
7. [PATCH v3 8/8]: use 1 literal instead of creating a new variable. And
   add options "--[no-]references" to allow the user disable checking
   the ref database. Then, update the related documentation and commit
   message.

Thanks,
Jialuo

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
 Documentation/git-fsck.txt    |    6 +-
 builtin/fsck.c                |   33 +-
 builtin/refs.c                |    2 +-
 fsck.h                        |    4 +
 refs/packed-backend.c         |  338 +++++++++-
 t/t0602-reffiles-fsck.sh      | 1111 +++++++++++++++++++--------------
 worktree.c                    |    5 +
 worktree.h                    |    6 +
 9 files changed, 1036 insertions(+), 483 deletions(-)

Range-diff against v2:
1:  20889b7b18 = 1:  20889b7b18 t0602: use subshell to ensure working directory unchanged
2:  97688c8700 ! 2:  9d7780e953 builtin/refs: get worktrees without reading head info
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    builtin/refs: get worktrees without reading head info
    +    builtin/refs: get worktrees without reading head information
     
         In "packed-backend.c", there are some functions such as "create_snapshot"
         and "next_record" which would check the correctness of the content of
    @@ Commit message
     
         Although this behavior has no harm for the program, it will
         short-circuit the program. When the users execute "git refs verify" or
    -    "git fsck", we don't want to simply die the program but rather show the
    -    warnings or errors as many as possible to info the users. So, we should
    -    avoid reading the head info.
    +    "git fsck", we should avoid reading the head information, which may
    +    execute the read operation in packed backend with stricter checks to die
    +    the program. Instead, we should continue to check other parts of the
    +    "packed-refs" file completely.
     
         Fortunately, in 465a22b338 (worktree: skip reading HEAD when repairing
         worktrees, 2023-12-29), we have introduced a function
         "get_worktrees_internal" which allows us to get worktrees without
    -    reading head info.
    +    reading head information.
     
         Create a new exposed function "get_worktrees_without_reading_head", then
         replace the "get_worktrees" in "builtin/refs" with the new created
3:  122ad3be02 ! 3:  44d26f6440 packed-backend: check whether the "packed-refs" is regular
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    packed-backend: check whether the "packed-refs" is regular
    +    packed-backend: check whether the "packed-refs" is regular file
     
         Although "git-fsck(1)" and "packed-backend.c" will check some
         consistency and correctness of "packed-refs" file, they never check the
         filetype of the "packed-refs". The user should always use "git
    -    packed-refs" command to create the raw regular "packed-refs" file, so we
    +    pack-refs" command to create the raw regular "packed-refs" file, so we
         need to explicitly check this in "git refs verify".
     
    -    We could use the following two ways to check whether the "packed-refs"
    -    is regular:
    -
    -    1. We could use "lstat" system call to check the file mode.
    -    2. We could use "open_nofollow" wrapper to open the raw "packed-refs" file
    -       If the returned fd value is less than 0, we could check whether the
    -       "errno" is "ELOOP" to report an error to the user.
    -
    -    It might seems that the method one is much easier than method two.
    -    However, method one has a significant drawback. When we have checked the
    -    file mode using "lstat", we will need to read the file content, there is
    -    a possibility that when finishing reading the file content to the
    -    memory, the file could be changed into a symlink and we cannot notice.
    -
    -    With method two, we could get the "fd" firstly. Even if the file is
    -    changed into a symlink, we could still operate the "fd" in the memory
    -    which is consistent across the checking which avoids race condition.
    +    We could use "open_nofollow" wrapper to open the raw "packed-refs" file.
    +    If the returned "fd" value is less than 0, we could check whether the
    +    "errno" is "ELOOP" to report an error to the user.
     
         Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
         the user if "packed-refs" is not a regular file.
4:  c3d32993c5 ! 4:  a9ab7af16a packed-backend: add "packed-refs" header consistency check
    @@ Commit message
         pack-refs with:". As we are going to implement the header consistency
         check, we should port this check into "packed_fsck".
     
    -    However, the above check is not enough, this is because "git pack-refs"
    -    will always write "PACKED_REFS_HEADER" which is a constant string to the
    -    "packed-refs" file. So, we should check the following things for the
    -    header.
    +    However, we need to consider other situations and discuss whether we
    +    need to add checks.
     
    -    1. If the header does not exist, we may report an error to the user
    -       because it should exist, but we do allow no header in "packed-refs"
    -       file. So, create a new fsck message "packedRefMissingHeader(INFO)" to
    -       warn the user and also keep compatibility.
    +    1. If the header does not exist, we should not report an error to the
    +       user. This is because in older Git version, we never write header in
    +       the "packed-refs" file. Also, we do allow no header in "packed-refs"
    +       in runtime.
         2. If the header content does not start with "# packed-ref with:", we
            should report an error just like what "create_snapshot" does. So,
            create a new fsck message "badPackedRefHeader(ERROR)" for this.
         3. If the header content is not the same as the constant string
    -       "PACKED_REFS_HEADER", ideally, we should report an error to the user.
    -       However, we allow other contents as long as the header content starts
    -       with "# packed-ref with:". To keep compatibility, create a new fsck
    -       message "unknownPackedRefHeader(INFO)" to warn about this. We may
    -       tighten this rule in the future.
    +       "PACKED_REFS_HEADER". This is expected because we make it extensible
    +       intentionally. So, there is no need to report.
     
    -    In order to achieve above checks, read the "packed-refs" file via
    -    "strbuf_read". Like what "create_snapshot" and other functions do, we
    -    could split the line by finding the next newline in the buffer. When we
    -    cannot find a newline, we could report an error.
    +    As we have analyzed, we only need to check the case 2 in the above. In
    +    order to do this, read the "packed-refs" file via "strbuf_read". Like
    +    what "create_snapshot" and other functions do, we could split the line
    +    by finding the next newline in the buffer. When we cannot find a
    +    newline, we could report an error.
     
         So, create a function "packed_fsck_ref_next_line" to find the next
         newline and if there is no such newline, use
         "packedRefEntryNotTerminated(ERROR)" to report an error to the user.
     
    -    Then, parse the first line to apply the above three checks. Update the
    -    test to excise the code.
    +    Then, parse the first line to apply the checks. Update the test to
    +    exercise the code.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ Documentation/fsck-msgids.txt
     +`packedRefEntryNotTerminated`::
     +	(ERROR) The "packed-refs" file contains an entry that is
     +	not terminated by a newline.
    -+
    -+`packedRefMissingHeader`::
    -+	(INFO) The "packed-refs" file does not contain the header.
     +
      `refMissingNewline`::
      	(INFO) A loose ref that does not end with newline(LF). As
      	valid implementations of Git never created such a loose ref
    -@@
    - `treeNotSorted`::
    - 	(ERROR) A tree is not properly sorted.
    - 
    -+`unknownPackedRefHeader`::
    -+	(INFO) The "packed-refs" header starts with "# pack-refs with:"
    -+	but the remaining content is not the same as what `git pack-refs`
    -+	would write.
    -+
    - `unknownType`::
    - 	(ERROR) Found an unknown object type.
    - 
     
      ## fsck.h ##
     @@ fsck.h: enum fsck_msg_type {
    @@ fsck.h: enum fsck_msg_type {
      	FUNC(TREE_NOT_SORTED, ERROR) \
      	FUNC(UNKNOWN_TYPE, ERROR) \
      	FUNC(ZERO_PADDED_DATE, ERROR) \
    -@@ fsck.h: enum fsck_msg_type {
    - 	FUNC(REF_MISSING_NEWLINE, INFO) \
    - 	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO) \
    - 	FUNC(TRAILING_REF_CONTENT, INFO) \
    -+	FUNC(UNKNOWN_PACKED_REF_HEADER, INFO) \
    -+	FUNC(PACKED_REF_MISSING_HEADER, INFO) \
    - 	/* ignored (elevated when requested) */ \
    - 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
    - 
     
      ## refs/packed-backend.c ##
     @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +	return ret;
     +}
     +
    -+static int packed_fsck_ref_header(struct fsck_options *o, const char *start, const char *eol)
    ++static int packed_fsck_ref_header(struct fsck_options *o,
    ++				  const char *start, const char *eol)
     +{
    -+	const char *err_fmt = NULL;
    -+	int fsck_msg_id = -1;
    -+
     +	if (!starts_with(start, "# pack-refs with:")) {
    -+		err_fmt = "'%.*s' does not start with '# pack-refs with:'";
    -+		fsck_msg_id = FSCK_MSG_BAD_PACKED_REF_HEADER;
    -+	} else if (strncmp(start, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER))) {
    -+		err_fmt = "'%.*s' is an unknown packed-refs header";
    -+		fsck_msg_id = FSCK_MSG_UNKNOWN_PACKED_REF_HEADER;
    -+	}
    -+
    -+	if (err_fmt && fsck_msg_id >= 0) {
     +		struct fsck_ref_report report = { 0 };
     +		report.path = "packed-refs.header";
     +
    -+		return fsck_report_ref(o, &report, fsck_msg_id, err_fmt,
    ++		return fsck_report_ref(o, &report,
    ++				       FSCK_MSG_BAD_PACKED_REF_HEADER,
    ++				       "'%.*s' does not start with '# pack-refs with:'",
     +				       (int)(eol - start), start);
    -+
     +	}
     +
     +	return 0;
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +				   const char *start, const char *eof)
     +{
     +	struct strbuf packed_entry = STRBUF_INIT;
    -+	int line_number = 1;
    ++	unsigned long line_number = 1;
     +	const char *eol;
     +	int ret = 0;
     +
    -+	strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
    ++	strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
     +	ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
     +	if (*start == '#') {
     +		ret |= packed_fsck_ref_header(o, start, eol);
     +
     +		start = eol + 1;
     +		line_number++;
    -+	} else {
    -+		struct fsck_ref_report report = { 0 };
    -+		report.path = "packed-refs";
    -+
    -+		ret |= fsck_report_ref(o, &report,
    -+				       FSCK_MSG_PACKED_REF_MISSING_HEADER,
    -+				       "missing header line");
     +	}
     +
     +	strbuf_release(&packed_entry);
    @@ t/t0602-reffiles-fsck.sh: test_expect_success SYMLINKS 'the filetype of packed-r
     +		git refs verify 2>err &&
     +		test_must_be_empty err &&
     +
    -+		printf "$(git rev-parse main) refs/heads/main\n" >.git/packed-refs &&
    -+		git refs verify 2>err &&
    -+		cat >expect <<-EOF &&
    -+		warning: packed-refs: packedRefMissingHeader: missing header line
    -+		EOF
    -+		rm .git/packed-refs &&
    -+		test_cmp expect err &&
    -+
     +		for bad_header in "# pack-refs wit: peeled fully-peeled sorted " \
    -+				"# pack-refs with traits: peeled fully-peeled sorted " \
    -+				"# pack-refs with a: peeled fully-peeled"
    ++				  "# pack-refs with traits: peeled fully-peeled sorted " \
    ++				  "# pack-refs with a: peeled fully-peeled"
     +		do
     +			printf "%s\n" "$bad_header" >.git/packed-refs &&
     +			test_must_fail git refs verify 2>err &&
    @@ t/t0602-reffiles-fsck.sh: test_expect_success SYMLINKS 'the filetype of packed-r
     +			EOF
     +			rm .git/packed-refs &&
     +			test_cmp expect err || return 1
    -+		done &&
    -+
    -+		for unknown_header in "# pack-refs with: peeled fully-peeled sorted garbage" \
    -+				"# pack-refs with: peeled" \
    -+				"# pack-refs with: peeled peeled-fully sort"
    -+		do
    -+			printf "%s\n" "$unknown_header" >.git/packed-refs &&
    -+			git refs verify 2>err &&
    -+			cat >expect <<-EOF &&
    -+			warning: packed-refs.header: unknownPackedRefHeader: '\''$unknown_header'\'' is an unknown packed-refs header
    -+			EOF
    -+			rm .git/packed-refs &&
    -+			test_cmp expect err || return 1
     +		done
     +	)
     +'
5:  c545a61107 ! 5:  9b075434a1 packed-backend: check whether the refname contains NUL characters
    @@ Metadata
      ## Commit message ##
         packed-backend: check whether the refname contains NUL characters
     
    -    We have already implemented the header consistency check for the raw
    -    "packed-refs" file. Before we implement the consistency check for each
    -    ref entry, let's analysis [1] which reports that "git fsck" cannot
    -    detect some NUL characters.
    -
         "packed-backend.c::next_record" will use "check_refname_format" to check
         the consistency of the refname. If it is not OK, the program will die.
    -    So, we already have the code path and we must miss out something.
    +    However, it is reported in [1], we cannot catch some corruption. But we
    +    already have the code path and we must miss out something.
     
         We use the following code to get the refname:
     
    @@ refs/packed-backend.c: static void verify_buffer_safe(struct snapshot *snapshot)
     + */
     +static int refname_contains_nul(struct strbuf *refname)
     +{
    -+	const char *pos = memchr(refname->buf, '\0', refname->len + 1);
    -+	return pos < refname->buf + refname->len;
    ++	return !!memchr(refname->buf, '\0', refname->len);
     +}
     +
      #define SMALL_FILE_SIZE (32*1024)
6:  a480e2bf49 ! 6:  a976508319 packed-backend: add "packed-refs" entry consistency check
    @@ Commit message
         "packed-backend.c::next_record" will parse the ref entry to check the
         consistency. This function has already checked the following things:
     
    -    1. Parse the main line of the ref entry, if the oid is not correct. It
    -       will die the program. And then it will check whether the next
    -       character of the oid is space. Then it will check whether the refname
    -       is correct.
    -    2. If the next line starts with '^', it will continue to parse the oid
    -       of the peeled oid content and check whether the last character is
    -       '\n'.
    +    1. Parse the main line of the ref entry to inspect whether the oid is
    +       not correct. Then, check whether the next character is oid. Then
    +       check the refname.
    +    2. If the next line starts with '^', it would continue to parse the
    +       peeled oid and check whether the last character is '\n'.
     
    -    We can iterate each line by using the "packed_fsck_ref_next_line"
    -    function. Then, create a new fsck message "badPackedRefEntry(ERROR)" to
    -    report to the user when something is wrong.
    -
    -    Create two new functions "packed_fsck_ref_main_line" and
    -    "packed_fsck_ref_peeled_line" for case 1 and case 2 respectively. Last,
    -    update the unit test to exercise the code.
    +    As we decide to implement the ref consistency check for "packed-refs",
    +    let's port these two checks and update the test to exercise the code.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ fsck.h: enum fsck_msg_type {
      	FUNC(BAD_REF_CONTENT, ERROR) \
     
      ## refs/packed-backend.c ##
    -@@ refs/packed-backend.c: static int packed_fsck_ref_header(struct fsck_options *o, const char *start, con
    +@@ refs/packed-backend.c: static int packed_fsck_ref_header(struct fsck_options *o,
      	return 0;
      }
      
    @@ refs/packed-backend.c: static int packed_fsck_ref_header(struct fsck_options *o,
     +
     +	report.path = packed_entry->buf;
     +
    ++	/*
    ++	 * Skip the '^' and parse the peeled oid.
    ++	 */
     +	start++;
    -+	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo)) {
    ++	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo))
     +		return fsck_report_ref(o, &report,
     +				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
     +				       "'%.*s' has invalid peeled oid",
     +				       (int)(eol - start), start);
    -+	}
     +
    -+	if (p != eol) {
    ++	if (p != eol)
     +		return fsck_report_ref(o, &report,
     +				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
     +				       "has trailing garbage after peeled oid '%.*s'",
     +				       (int)(eol - p), p);
    -+	}
     +
     +	return 0;
     +}
    @@ refs/packed-backend.c: static int packed_fsck_ref_header(struct fsck_options *o,
     +
     +	report.path = packed_entry->buf;
     +
    -+	if (parse_oid_hex_algop(start, &oid, &p, ref_store->repo->hash_algo)) {
    ++	if (parse_oid_hex_algop(start, &oid, &p, ref_store->repo->hash_algo))
     +		return fsck_report_ref(o, &report,
     +				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
     +				       "'%.*s' has invalid oid",
     +				       (int)(eol - start), start);
    -+	}
     +
    -+	if (p == eol || !isspace(*p)) {
    ++	if (p == eol || !isspace(*p))
     +		return fsck_report_ref(o, &report,
     +				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
     +				       "has no space after oid '%s' but with '%.*s'",
     +				       oid_to_hex(&oid), (int)(eol - p), p);
    -+	}
     +
     +	p++;
     +	strbuf_reset(refname);
     +	strbuf_add(refname, p, eol - p);
    -+	if (refname_contains_nul(refname)) {
    ++	if (refname_contains_nul(refname))
     +		return fsck_report_ref(o, &report,
     +				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
     +				       "refname '%s' contains NULL binaries",
     +				       refname->buf);
    -+	}
     +
    -+	if (check_refname_format(refname->buf, 0)) {
    ++	if (check_refname_format(refname->buf, 0))
     +		return fsck_report_ref(o, &report,
     +				       FSCK_MSG_BAD_REF_NAME,
     +				       "has bad refname '%s'", refname->buf);
    -+	}
     +
     +	return 0;
     +}
    @@ refs/packed-backend.c: static int packed_fsck_ref_header(struct fsck_options *o,
      {
      	struct strbuf packed_entry = STRBUF_INIT;
     +	struct strbuf refname = STRBUF_INIT;
    - 	int line_number = 1;
    + 	unsigned long line_number = 1;
      	const char *eol;
      	int ret = 0;
     @@ refs/packed-backend.c: static int packed_fsck_ref_content(struct fsck_options *o,
    - 				       "missing header line");
    + 		line_number++;
      	}
      
     +	while (start < eof) {
     +		strbuf_reset(&packed_entry);
    -+		strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
    ++		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
     +		ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
     +		ret |= packed_fsck_ref_main_line(o, ref_store, &packed_entry, &refname, start, eol);
     +		start = eol + 1;
     +		line_number++;
     +		if (start < eof && *start == '^') {
     +			strbuf_reset(&packed_entry);
    -+			strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
    ++			strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
     +			ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
     +			ret |= packed_fsck_ref_peeled_line(o, ref_store, &packed_entry,
     +							   start, eol);
7:  199965dfb7 ! 7:  707e3e2151 packed-backend: check whether the "packed-refs" is sorted
    @@ Metadata
      ## Commit message ##
         packed-backend: check whether the "packed-refs" is sorted
     
    -    We will always try to sort the "packed-refs" increasingly by comparing
    -    the refname. So, we should add checks to verify whether the "packed-refs"
    -    is sorted.
    +    When there is a "sorted" trait in the header of the "packed-refs" file,
    +    it means that each entry is sorted increasingly by comparing the
    +    refname. We should add checks to verify whether the "packed-refs" is
    +    sorted in this case.
     
    -    We already have code to parse the content. Let's create a new structure
    -    "fsck_packed_ref_entry" to store the state during the parsing process
    -    for every entry. It may seem that we could just add a new "struct strbuf
    -    refname" into the "struct fsck_packed_ref_entry" and during the parsing
    -    process, we could store the refname into this structure and we could
    -    compare later. However, this is not a good design due to the following
    -    reasons:
    +    Update the "packed_fsck_ref_header" to know whether there is a "sorted"
    +    trail in the header. Then, create a new structure "fsck_packed_ref_entry"
    +    to store the state during the parsing process for every entry. It may
    +    seem that we could just add a new "struct strbuf refname" into the
    +    "struct fsck_packed_ref_entry" and during the parsing process, we could
    +    store the refname into this structure and thus we could compare later.
    +    However, this is not a good design due to the following reasons:
     
         1. Because we need to store the state across the whole checking
            lifetime, we would consume a lot of memory if there are many entries
    @@ Commit message
     
      ## Documentation/fsck-msgids.txt ##
     @@
    - `packedRefMissingHeader`::
    - 	(INFO) The "packed-refs" file does not contain the header.
    + 	(ERROR) The "packed-refs" file contains an entry that is
    + 	not terminated by a newline.
      
     +`packedRefUnsorted`::
     +	(ERROR) The "packed-refs" file is not sorted.
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
      }
      
     +struct fsck_packed_ref_entry {
    -+	int line_number;
    ++	unsigned long line_number;
     +
     +	struct snapshot_record record;
     +};
     +
    -+static struct fsck_packed_ref_entry *create_fsck_packed_ref_entry(int line_number,
    ++static struct fsck_packed_ref_entry *create_fsck_packed_ref_entry(unsigned long line_number,
     +								  const char *start)
     +{
     +	struct fsck_packed_ref_entry *entry = xcalloc(1, sizeof(*entry));
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +	return entry;
     +}
     +
    -+static void free_fsck_packed_ref_entries(struct fsck_packed_ref_entry **entries, int nr)
    ++static void free_fsck_packed_ref_entries(struct fsck_packed_ref_entry **entries, size_t nr)
     +{
    -+	for (int i = 0; i < nr; i++)
    ++	for (size_t i = 0; i < nr; i++)
     +		free(entries[i]);
     +	free(entries);
     +}
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
      static int packed_fsck_ref_next_line(struct fsck_options *o,
      				     struct strbuf *packed_entry, const char *start,
      				     const char *eof, const char **eol)
    +@@ refs/packed-backend.c: static int packed_fsck_ref_next_line(struct fsck_options *o,
    + }
    + 
    + static int packed_fsck_ref_header(struct fsck_options *o,
    +-				  const char *start, const char *eol)
    ++				  const char *start, const char *eol,
    ++				  unsigned int *sorted)
    + {
    +-	if (!starts_with(start, "# pack-refs with:")) {
    ++	struct string_list traits = STRING_LIST_INIT_NODUP;
    ++	char *tmp_line;
    ++	int ret = 0;
    ++	char *p;
    ++
    ++	tmp_line = xmemdupz(start, eol - start);
    ++	if (!skip_prefix(tmp_line, "# pack-refs with:", (const char **)&p)) {
    + 		struct fsck_ref_report report = { 0 };
    + 		report.path = "packed-refs.header";
    + 
    +-		return fsck_report_ref(o, &report,
    +-				       FSCK_MSG_BAD_PACKED_REF_HEADER,
    +-				       "'%.*s' does not start with '# pack-refs with:'",
    +-				       (int)(eol - start), start);
    ++		ret = fsck_report_ref(o, &report,
    ++				      FSCK_MSG_BAD_PACKED_REF_HEADER,
    ++				      "'%.*s' does not start with '# pack-refs with:'",
    ++				      (int)(eol - start), start);
    ++		goto cleanup;
    + 	}
    + 
    +-	return 0;
    ++	string_list_split_in_place(&traits, p, " ", -1);
    ++	*sorted = unsorted_string_list_has_string(&traits, "sorted");
    ++
    ++cleanup:
    ++	free(tmp_line);
    ++	string_list_clear(&traits, 0);
    ++	return ret;
    + }
    + 
    + static int packed_fsck_ref_peeled_line(struct fsck_options *o,
     @@ refs/packed-backend.c: static int packed_fsck_ref_main_line(struct fsck_options *o,
      	return 0;
      }
    @@ refs/packed-backend.c: static int packed_fsck_ref_main_line(struct fsck_options
     +static int packed_fsck_ref_sorted(struct fsck_options *o,
     +				  struct ref_store *ref_store,
     +				  struct fsck_packed_ref_entry **entries,
    -+				  int nr)
    ++				  size_t nr)
     +{
     +	size_t hexsz = ref_store->repo->hash_algo->hexsz;
     +	struct strbuf packed_entry = STRBUF_INIT;
    @@ refs/packed-backend.c: static int packed_fsck_ref_main_line(struct fsck_options
     +	struct strbuf refname2 = STRBUF_INIT;
     +	int ret = 0;
     +
    -+	for (int i = 1; i < nr; i++) {
    ++	for (size_t i = 1; i < nr; i++) {
     +		const char *r1 = entries[i - 1]->record.start + hexsz + 1;
     +		const char *r2 = entries[i]->record.start + hexsz + 1;
     +
    @@ refs/packed-backend.c: static int packed_fsck_ref_main_line(struct fsck_options
     +				     entries[i]->record.len);
     +			strbuf_add(&refname2, r2, eol - r2);
     +
    -+			strbuf_addf(&packed_entry, "packed-refs line %d",
    ++			strbuf_addf(&packed_entry, "packed-refs line %lu",
     +				    entries[i - 1]->line_number);
     +			report.path = packed_entry.buf;
     +			ret = fsck_report_ref(o, &report,
    @@ refs/packed-backend.c: static int packed_fsck_ref_main_line(struct fsck_options
      	struct strbuf packed_entry = STRBUF_INIT;
     +	struct fsck_packed_ref_entry **entries;
      	struct strbuf refname = STRBUF_INIT;
    -+	int entry_alloc = 20;
    - 	int line_number = 1;
    -+	int entry_nr = 0;
    + 	unsigned long line_number = 1;
    ++	unsigned int sorted = 0;
    ++	size_t entry_alloc = 20;
    ++	size_t entry_nr = 0;
      	const char *eol;
      	int ret = 0;
      
    -@@ refs/packed-backend.c: static int packed_fsck_ref_content(struct fsck_options *o,
    - 				       "missing header line");
    + 	strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
    + 	ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
    + 	if (*start == '#') {
    +-		ret |= packed_fsck_ref_header(o, start, eol);
    ++		ret |= packed_fsck_ref_header(o, start, eol, &sorted);
    + 
    + 		start = eol + 1;
    + 		line_number++;
      	}
      
     +	ALLOC_ARRAY(entries, entry_alloc);
    @@ refs/packed-backend.c: static int packed_fsck_ref_content(struct fsck_options *o
     +		ALLOC_GROW(entries, entry_nr + 1, entry_alloc);
     +		entries[entry_nr++] = entry;
      		strbuf_reset(&packed_entry);
    - 		strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
    + 		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
      		ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
     @@ refs/packed-backend.c: static int packed_fsck_ref_content(struct fsck_options *o,
      			start = eol + 1;
    @@ refs/packed-backend.c: static int packed_fsck_ref_content(struct fsck_options *o
     +		entry->record.len = start - entry->record.start;
      	}
      
    -+	if (!ret)
    ++	if (!ret && sorted)
     +		ret |= packed_fsck_ref_sorted(o, ref_store, entries, entry_nr);
     +
      	strbuf_release(&packed_entry);
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'packed-refs content should be che
      	)
      '
      
    -+test_expect_success 'packed-ref sorted should be checked' '
    ++test_expect_success 'packed-ref with sorted trait should be checked' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'packed-refs content should be che
     +		EOF
     +		rm .git/packed-refs &&
     +		test_cmp expect err &&
    ++
     +		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
     +		printf "%s %s\n" "$tag_1_oid" "$refname3" >>.git/packed-refs &&
     +		printf "^%s\n" "$tag_1_peeled_oid" >>.git/packed-refs &&
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'packed-refs content should be che
     +		test_cmp expect err
     +	)
     +'
    ++
    ++test_expect_success 'packed-ref without sorted trait should not be checked' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit default &&
    ++		git branch branch-1 &&
    ++		git branch branch-2 &&
    ++		git tag -a annotated-tag-1 -m tag-1 &&
    ++		branch_1_oid=$(git rev-parse branch-1) &&
    ++		branch_2_oid=$(git rev-parse branch-2) &&
    ++		tag_1_oid=$(git rev-parse annotated-tag-1) &&
    ++		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
    ++		refname1="refs/heads/main" &&
    ++		refname2="refs/heads/foo" &&
    ++		refname3="refs/tags/foo" &&
    ++		printf "# pack-refs with: peeled fully-peeled \n"  >.git/packed-refs &&
    ++		printf "%s %s\n" "$branch_2_oid" "$refname1" >>.git/packed-refs &&
    ++		printf "%s %s\n" "$branch_1_oid" "$refname2" >>.git/packed-refs &&
    ++		git refs verify 2>err &&
    ++		test_must_be_empty err
    ++	)
    ++'
     +
      test_done
8:  81a2164c04 ! 8:  4f2170aa7c builtin/fsck: add `git refs verify` child process
    @@ Commit message
         It's hard to know how many loose refs we will check now. We might
         improve this later.
     
    -    And we run this function in the first execution sequence of
    -    "git-fsck(1)" because we don't want the existing code of "git-fsck(1)"
    -    which implicitly checks the consistency of refs to die the program.
    +    Then, introduce the option to allow the user to disable checking ref
    +    database consistency. Put this function in the very first execution
    +    sequence of "git-fsck(1)" due to that we don't want the existing code of
    +    "git-fsck(1)" which would implicitly check the consistency of refs to
    +    die the program.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
    + ## Documentation/git-fsck.txt ##
    +@@ Documentation/git-fsck.txt: SYNOPSIS
    + 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
    + 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
    + 	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
    +-	 [--[no-]name-objects] [<object>...]
    ++	 [--[no-]name-objects] [--[no-]references] [<object>...]
    + 
    + DESCRIPTION
    + -----------
    +@@ Documentation/git-fsck.txt: care about this output and want to speed it up further.
    + 	progress status even if the standard error stream is not
    + 	directed to a terminal.
    + 
    ++--[no-]references::
    ++	Control whether to check the references database consistency
    ++	via 'git refs verify'. See linkgit:git-refs[1] for details.
    ++
    + CONFIGURATION
    + -------------
    + 
    +
      ## builtin/fsck.c ##
    +@@ builtin/fsck.c: static int verbose;
    + static int show_progress = -1;
    + static int show_dangling = 1;
    + static int name_objects;
    ++static int check_references = 1;
    + #define ERROR_OBJECT 01
    + #define ERROR_REACHABLE 02
    + #define ERROR_PACK 04
     @@ builtin/fsck.c: static int check_pack_rev_indexes(struct repository *r, int show_progress)
      	return res;
      }
    @@ builtin/fsck.c: static int check_pack_rev_indexes(struct repository *r, int show
     +{
     +	struct child_process refs_verify = CHILD_PROCESS_INIT;
     +	struct progress *progress = NULL;
    -+	uint64_t progress_num = 1;
     +
     +	if (show_progress)
    -+		progress = start_progress(r, _("Checking ref database"),
    -+					  progress_num);
    ++		progress = start_progress(r, _("Checking ref database"), 1);
     +
     +	if (verbose)
     +		fprintf_ln(stderr, _("Checking ref database"));
    @@ builtin/fsck.c: static int check_pack_rev_indexes(struct repository *r, int show
      static char const * const fsck_usage[] = {
      	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
      	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
    + 	   "         [--[no-]dangling] [--[no-]progress] [--connectivity-only]\n"
    +-	   "         [--[no-]name-objects] [<object>...]"),
    ++	   "         [--[no-]name-objects] [--[no-]references] [<object>...]"),
    + 	NULL
    + };
    + 
    +@@ builtin/fsck.c: static struct option fsck_opts[] = {
    + 				N_("write dangling objects in .git/lost-found")),
    + 	OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
    + 	OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for reachable objects")),
    ++	OPT_BOOL(0, "references", &check_references, N_("check reference database consistency")),
    + 	OPT_END(),
    + };
    + 
     @@ builtin/fsck.c: int cmd_fsck(int argc,
      	git_config(git_fsck_config, &fsck_obj_options);
      	prepare_repo_settings(the_repository);
      
    -+	fsck_refs(the_repository);
    ++	if (check_references)
    ++		fsck_refs(the_repository);
     +
      	if (connectivity_only) {
      		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
-- 
2.48.1

