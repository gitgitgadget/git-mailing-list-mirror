Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37F1B12F6
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365862; cv=none; b=d19s/AzV0+79mcID0D2YfjSZo3TB+jW+m1PEdFG33EO//KEExbS1hoMf6t60wzTwzCERw7VY8gok43kyMs6HDcekwA4N+pHdN+nao0IX7BKX7pA47wlvJZorfz2AJe0EozZvYLd6HPB/jmm5h425h3pgwDQUxqqkoNC8YjqGNMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365862; c=relaxed/simple;
	bh=jqNtakLFL+XmgZBS0IXE+lVHCjv7sNAi6J+CLAZUgqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrvTdH/bw0VIdBnUSwQgnYSrCnMlph6wxzVej6BqElbN2hJOSoqJ9GDJ/AZVbW5kq8ywZLMbj/KZfmqQ9l7A0lM/kbV5RE5YrbBK84mHleJd7ywgGL7KO3dyFuYtf0MWaVI5o4VtsxOr/FAySjJXrWvTVzwxgqjIt+DUk6++iY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUUcS9pM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUUcS9pM"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2da4ea973bdso829453a91.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725365858; x=1725970658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSJuhERI3LMLcp6mfqynNFo9vCG7NCiRPfylor0drzs=;
        b=eUUcS9pMyJdDqP8ZsccHZzWuq5FqGkC4+pDiHc4+z796dSKTPifBNG/IuLQih0Qc1S
         2/4loVhe0aBl+orJKsFOROjI844UXnrQeb1g5CtqaAnF3ByckzXNxCeW8eJ2E2X1w0Rx
         mkKlREye4IiQMTbyt06pg33BRDNZ8MusDM0KqTPBs3+LpAire+0GQK8BOteWiIadeKIt
         +VQwv8JKVT5XM7gbhbvWSS9EyGIrKDC+m2dpMXMhXDbfAGSkVU4eXK3gq1vsTIXqRk3Y
         gYLU4gsPGlqoSGay8tXDNyqkwNfeKWheWs7dyvxmEMbvS3dIn+eU9InV3xDB2fvmPVyj
         qq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725365858; x=1725970658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSJuhERI3LMLcp6mfqynNFo9vCG7NCiRPfylor0drzs=;
        b=Ahs2pz8eeUDY4rwJQXCnCERhFZFHdEGCF+SyZBF7Mz6+PgPyKbii9Jr0MVBhmtFZrk
         YUDEB91p6SuUqrthaYvjY2nPXbhTftpQKDCZ6ZsWNw3v7oAithpEPHGx1AA7bhz98GTy
         PFdgKXYngsSVkxN575yJxxsKi9185JzoAYW53Te8UcSd7bmdU3bOCKvWtdMzLi4fv9em
         fJPHkQkt4EvcjzwzAqS8EvRerc+QhXNk8BT1/fl4rsLCtN6me00V+Mij0mpeGKqzBpmh
         FooMRWD7dGDMVGSd1477zm/Qf/Tq/otVyQqA/dd2LS7nP5/qHN04FzI7e5uQ0T5cdOEE
         aezg==
X-Gm-Message-State: AOJu0Yx4AMNvauhY5xj+LKKBIB4iGuTr03ZrlSvGEDOKjW88LByYOhkG
	8qroJYDhtSxjTfOlRNr9SgU32suZR7sJ7LEUf5hrppFc1s3+2mWSyxAfew==
X-Google-Smtp-Source: AGHT+IGLisAMuZaaa0rGJCr+qflcvbuHhiQlyTraURg3yO7x4WUfUGIZipour7JkUbhGTuw97H3CMw==
X-Received: by 2002:a17:90b:4b41:b0:2d8:b43b:6ecc with SMTP id 98e67ed59e1d1-2d8b43b72b1mr8951254a91.4.1725365857706;
        Tue, 03 Sep 2024 05:17:37 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8b967b401sm5175046a91.37.2024.09.03.05.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 05:17:36 -0700 (PDT)
Date: Tue, 3 Sep 2024 20:18:34 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/4] add ref content check for files backend
Message-ID: <Ztb-mgl50cwGVO8A@ArchLinux>
References: <Zs348uXMBdCuwF-2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs348uXMBdCuwF-2@ArchLinux>

Hi All:

This new version does the following things:

1. [PATCH v3 1/4]

    + the motivation of the previous commit message is too strong, this
    version improves this.

2. [PATCH v3 2/4]

    + Enhance the commit message to make things clearer.
    + Enhance the descriptions of the fsck message ids. Tell the user we
    may consider converting info to error later to let the user know
    this and report some feedback to us.
    + Use "goto" to avoid unnecessary indentation.
    + Use "test_commit" to create a single commit in the test file to
    avoid unnecessary setups.
    + Enhance the test cases by adding normal situation case test and
    add a new aggregation test to double verify the functionality.
    + Clean the "> $file" to ">$file" to make the code style correct.

3. [PATCH v3 3/4]

    + Enhance the commit message by better describing the motivation.
    + Change the fsck message name "badSymrefPointee" to
    "badSymrefTarget" to be align with the codebase. And talking more
    about what is the "bad" in the documentation.
    + Use idea from Junio to check the textual symref content.
    + Still keep the following code:

        if (lstat(referent->buf, &st))
            goto out;

        if (S_ISDIR(st.st_mode)) {
            ret = report(...);
            goto out;
        }

      This is because that we cannot know whether "refs/heads/a" is a
      regular ref or a directory by using "check_refname_format". So we
      have to add this check. It may seem we have done this when
      iterating the "refs" directory. However, we do report error for
      other NON-symlink and NON-regular file type but for directory, we
      omit. We cannot say oh this is not right. So we need to explicitly
      check here.

    + Like [PATCH v3 2/4], enhance the test code.

4. [PATCH v3 4/4]

    + Enhance the commit message
    + Introduce a new fsck info "symlinkRef" to warn the user that we
    will see this warning as an error when we drop the symlink ref
    support.
    + Squash the following two patches into this patch:
      https://lore.kernel.org/git/xmqqle0gzdyh.fsf_-_@gitster.g/
      https://lore.kernel.org/git/xmqqbk1cz69c.fsf@gitster.g/

Thanks,
Jialuo


shejialuo (4):
  ref: initialize "fsck_ref_report" with zero
  ref: add regular ref content check for files backend
  ref: add symref content check for files backend
  ref: add symlink ref content check for files backend

 Documentation/fsck-msgids.txt |  20 ++
 fsck.h                        |   5 +
 refs.c                        |   2 +-
 refs/files-backend.c          | 205 ++++++++++++++++++++-
 refs/refs-internal.h          |   2 +-
 t/t0602-reffiles-fsck.sh      | 334 ++++++++++++++++++++++++++++++++++
 6 files changed, 556 insertions(+), 12 deletions(-)

Range-diff against v2:
1:  c49a216b70 ! 1:  9fdab751c1 ref: initialize "fsck_ref_report" with zero
    @@ Commit message
         NULL instead of letting them point to anywhere when creating a new
         "fsck_ref_report" structure.
     
    -    The original code explicitly specifies the ".path" field to initialize
    -    the "fsck_ref_report" structure. However, it introduces confusion how we
    -    initialize the other fields. In order to avoid this, initialize the
    -    "fsck_ref_report" with zero to make clear that everything in
    -    "fsck_ref_report" is zero initialized.
    +    The original code explicitly initializes the "path" member in the
    +    "struct fsck_ref_report" to NULL (which implicitly 0-initializes other
    +    members in the struct). It is more customary to use " {0} " to express
    +    that we are 0-initializing everything. In order to be align with the the
    +    codebase, initialize "fsck_ref_report" with zero.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct ref_store *ref_stor
      
      	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
     -		struct fsck_ref_report report = { .path = NULL };
    -+		struct fsck_ref_report report = {0};
    ++		struct fsck_ref_report report = { 0 };
      
      		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
      		report.path = sb.buf;
2:  99e37b0304 ! 2:  4640b6e345 ref: add regular ref content check for files backend
    @@ Commit message
         We implicitly rely on "git-fsck(1)" to check the consistency of regular
         refs. However, when parsing the regular refs for files backend by using
         "files-backend.c::parse_loose_ref_contents", we allow the ref content to
    -    be end with no newline or contain some garbages.
    +    end with no newline or to contain some garbages.
     
    -    It may seem that we should report an error or warn fsck message to the
    -    user about above situations. However, there may be some third-party
    -    tools customizing the content of refs. We should not report an error
    -    fsck message.
    +    Even though we never create such loose refs ourselves, we have accepted
    +    such loose refs. So, it is entirely possible that some third-party tools
    +    may rely on such loose refs being valid. We should not report an error
    +    fsck message at current. But let's notice such a "curiously formatted"
    +    loose refs being valid and tell the user our findings, so we can access
    +    the possible extent of damage when we tighten the parsing rules in the
    +    future.
     
    -    And we cannot either report a warn fsck message to the user. This is
    -    because if the caller set the "strict" field in "fsck_options" to
    -    to upgrade the fsck warnings to errors.
    +    And it's not suitable to either report a warn fsck message to the user.
    +    This is because if the caller set the "strict" field in "fsck_options",
    +    fsck warns will be automatically upgraded to errors. We should not allow
    +    user to specify the "--strict" flag to upgrade the fsck warnings to
    +    errors at current. It might cause compatibility issue which may break
    +    the legacy repository. So we add the following two fsck infos to
    +    represent the situation where the ref content ends without newline or has
    +    garbages:
     
    -    We should not allow the user to upgrade the fsck warnings to errors. It
    -    might cause compatibility issue which will break the legacy repository.
    -    So we add the following two fsck infos to represent the situation where
    -    the ref content ends without newline or has garbages:
    +    1. "refMissingNewline(INFO)": A ref does not end with newline. This kind
    +       of ref may be considered ERROR in the future.
    +    2. "trailingRefContent(INFO)": A ref has trailing contents. This kind of
    +       ref may be considered ERROR in the future.
     
    -    1. "refMissingNewline(INFO)": A valid ref does not end with newline.
    -    2. "trailingRefContent(INFO)": A ref has trailing contents.
    -
    -    In "fsck.c::fsck_vreport", we will convert "FSCK_INFO" to "FSCK_WARN",
    -    and we can still warn the user about these situations when using
    -    "git-refs verify" without introducing compatibility issue.
    +    It may seem that we could not give the user any warnings by creating
    +    fsck infos. However, in "fsck.c::fsck_vreport", we will convert
    +    "FSCK_INFO" to "FSCK_WARN" and we can still warn the user about these
    +    situations when using "git-refs verify" without introducing
    +    compatibility issue.
     
         In current "git-fsck(1)", it will report an error when the ref content
         is bad, so we should following this to report an error to the user when
    @@ Documentation/fsck-msgids.txt
      	(WARN) Tree contains entries pointing to a null sha1.
      
     +`refMissingNewline`::
    -+	(INFO) A valid ref does not end with newline.
    ++	(INFO) A ref does not end with newline. This kind of ref may
    ++	be considered ERROR in the future.
     +
     +`trailingRefContent`::
    -+	(INFO) A ref has trailing contents.
    ++	(INFO) A ref has trailing contents. This kind of ref may be
    ++	considered ERROR in the future.
     +
      `treeNotSorted`::
      	(ERROR) A tree is not properly sorted.
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
     +	report.path = refname.buf;
     +
    -+	if (S_ISREG(iter->st.st_mode)) {
    -+		if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
    -+			ret = error_errno(_("%s/%s: unable to read the ref"),
    -+					  refs_check_dir, iter->relative_path);
    -+			goto cleanup;
    -+		}
    ++	if (S_ISLNK(iter->st.st_mode))
    ++		goto cleanup;
    ++
    ++	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
    ++		ret = error_errno(_("%s/%s: unable to read the ref"),
    ++				  refs_check_dir, iter->relative_path);
    ++		goto cleanup;
    ++	}
     +
    -+		if (parse_loose_ref_contents(ref_store->repo->hash_algo,
    -+					     ref_content.buf, &oid, &referent,
    -+					     &type, &trailing, &failure_errno)) {
    ++	if (parse_loose_ref_contents(ref_store->repo->hash_algo,
    ++				     ref_content.buf, &oid, &referent,
    ++				     &type, &trailing, &failure_errno)) {
    ++		ret = fsck_report_ref(o, &report,
    ++				      FSCK_MSG_BAD_REF_CONTENT,
    ++				      "invalid ref content");
    ++		goto cleanup;
    ++	}
    ++
    ++	if (!(type & REF_ISSYMREF)) {
    ++		if (*trailing == '\0') {
     +			ret = fsck_report_ref(o, &report,
    -+					      FSCK_MSG_BAD_REF_CONTENT,
    -+					      "invalid ref content");
    ++					      FSCK_MSG_REF_MISSING_NEWLINE,
    ++					      "missing newline");
     +			goto cleanup;
     +		}
     +
    -+		if (!(type & REF_ISSYMREF)) {
    -+			if (*trailing == '\0') {
    -+				ret = fsck_report_ref(o, &report,
    -+						      FSCK_MSG_REF_MISSING_NEWLINE,
    -+						      "missing newline");
    -+				goto cleanup;
    -+			}
    -+
    -+			if (*trailing != '\n' || (*(trailing + 1) != '\0')) {
    -+				ret = fsck_report_ref(o, &report,
    -+						      FSCK_MSG_TRAILING_REF_CONTENT,
    -+						      "trailing garbage in ref");
    -+				goto cleanup;
    -+			}
    ++		if (*trailing != '\n' || (*(trailing + 1) != '\0')) {
    ++			ret = fsck_report_ref(o, &report,
    ++					      FSCK_MSG_TRAILING_REF_CONTENT,
    ++					      "trailing garbage in ref");
    ++			goto cleanup;
     +		}
    -+		goto cleanup;
     +	}
     +
     +cleanup:
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should be adapted
      	test_must_be_empty err
      '
      
    -+test_expect_success 'regular ref content should be checked' '
    ++test_expect_success 'regular ref content should be checked (individual)' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	branch_dir_prefix=.git/refs/heads &&
     +	tag_dir_prefix=.git/refs/tags &&
     +	cd repo &&
    -+	git commit --allow-empty -m initial &&
    -+	git checkout -b branch-1 &&
    -+	git tag tag-1 &&
    -+	git commit --allow-empty -m second &&
    -+	git checkout -b branch-2 &&
    -+	git tag tag-2 &&
    -+	git checkout -b a/b/tag-2 &&
    ++	test_commit default &&
    ++	mkdir -p "$branch_dir_prefix/a/b" &&
     +
    -+	printf "%s" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-no-newline &&
    ++	git refs verify 2>err &&
    ++	test_must_be_empty err &&
    ++
    ++	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	warning: refs/heads/branch-1-no-newline: refMissingNewline: missing newline
    ++	warning: refs/heads/branch-no-newline: refMissingNewline: missing newline
     +	EOF
    -+	rm $branch_dir_prefix/branch-1-no-newline &&
    ++	rm $branch_dir_prefix/branch-no-newline &&
     +	test_cmp expect err &&
     +
    -+	printf "%s garbage" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-garbage &&
    ++	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	warning: refs/heads/branch-1-garbage: trailingRefContent: trailing garbage in ref
    ++	warning: refs/heads/branch-garbage: trailingRefContent: trailing garbage in ref
     +	EOF
    -+	rm $branch_dir_prefix/branch-1-garbage &&
    ++	rm $branch_dir_prefix/branch-garbage &&
     +	test_cmp expect err &&
     +
    -+	printf "%s\n\n\n" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
    ++	printf "%s\n\n\n" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-1 &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	warning: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
    ++	warning: refs/tags/tag-garbage-1: trailingRefContent: trailing garbage in ref
     +	EOF
    -+	rm $tag_dir_prefix/tag-1-garbage &&
    ++	rm $tag_dir_prefix/tag-garbage-1 &&
     +	test_cmp expect err &&
     +
    -+	printf "%s\n\n\n  garbage" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
    ++	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-2 &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	warning: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
    ++	warning: refs/tags/tag-garbage-2: trailingRefContent: trailing garbage in ref
     +	EOF
    -+	rm $tag_dir_prefix/tag-1-garbage &&
    ++	rm $tag_dir_prefix/tag-garbage-2 &&
     +	test_cmp expect err &&
     +
    -+	printf "%s    garbage\n\na" "$(git rev-parse tag-2)" > $tag_dir_prefix/tag-2-garbage &&
    ++	printf "%s    garbage\n\na" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-3 &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	warning: refs/tags/tag-2-garbage: trailingRefContent: trailing garbage in ref
    ++	warning: refs/tags/tag-garbage-3: trailingRefContent: trailing garbage in ref
     +	EOF
    -+	rm $tag_dir_prefix/tag-2-garbage &&
    ++	rm $tag_dir_prefix/tag-garbage-3 &&
     +	test_cmp expect err &&
     +
    -+	printf "%s garbage" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
    ++	printf "%s garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-4 &&
     +	test_must_fail git -c fsck.trailingRefContent=error refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	error: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
    ++	error: refs/tags/tag-garbage-4: trailingRefContent: trailing garbage in ref
     +	EOF
    -+	rm $tag_dir_prefix/tag-1-garbage &&
    ++	rm $tag_dir_prefix/tag-garbage-4 &&
     +	test_cmp expect err &&
     +
    -+	printf "%sx" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-bad &&
    ++	printf "%sx" "$(git rev-parse main)" >$tag_dir_prefix/tag-bad-1 &&
     +	test_must_fail git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	error: refs/tags/tag-1-bad: badRefContent: invalid ref content
    ++	error: refs/tags/tag-bad-1: badRefContent: invalid ref content
     +	EOF
    -+	rm $tag_dir_prefix/tag-1-bad &&
    ++	rm $tag_dir_prefix/tag-bad-1 &&
     +	test_cmp expect err &&
     +
    -+	printf "xfsazqfxcadas" > $tag_dir_prefix/tag-2-bad &&
    ++	printf "xfsazqfxcadas" >$tag_dir_prefix/tag-bad-2 &&
     +	test_must_fail git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	error: refs/tags/tag-2-bad: badRefContent: invalid ref content
    ++	error: refs/tags/tag-bad-2: badRefContent: invalid ref content
     +	EOF
    -+	rm $tag_dir_prefix/tag-2-bad &&
    ++	rm $tag_dir_prefix/tag-bad-2 &&
     +	test_cmp expect err &&
     +
    -+	printf "xfsazqfxcadas" > $branch_dir_prefix/a/b/branch-2-bad &&
    ++	printf "xfsazqfxcadas" >$branch_dir_prefix/a/b/branch-bad &&
     +	test_must_fail git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	error: refs/heads/a/b/branch-2-bad: badRefContent: invalid ref content
    ++	error: refs/heads/a/b/branch-bad: badRefContent: invalid ref content
     +	EOF
    -+	rm $branch_dir_prefix/a/b/branch-2-bad &&
    ++	rm $branch_dir_prefix/a/b/branch-bad &&
     +	test_cmp expect err
     +'
    ++
    ++test_expect_success 'regular ref content should be checked (aggregate)' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	branch_dir_prefix=.git/refs/heads &&
    ++	tag_dir_prefix=.git/refs/tags &&
    ++	cd repo &&
    ++	test_commit default &&
    ++	mkdir -p "$branch_dir_prefix/a/b" &&
    ++
    ++	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
    ++	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
    ++	printf "%s\n\n\n" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-1 &&
    ++	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-2 &&
    ++	printf "%s    garbage\n\na" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-3 &&
    ++	printf "%s garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-4 &&
    ++	printf "%sx" "$(git rev-parse main)" >$tag_dir_prefix/tag-bad-1 &&
    ++	printf "xfsazqfxcadas" >$tag_dir_prefix/tag-bad-2 &&
    ++	printf "xfsazqfxcadas" >$branch_dir_prefix/a/b/branch-bad &&
    ++
    ++	test_must_fail git refs verify 2>err &&
    ++	cat >expect <<-EOF &&
    ++	error: refs/heads/a/b/branch-bad: badRefContent: invalid ref content
    ++	error: refs/tags/tag-bad-1: badRefContent: invalid ref content
    ++	error: refs/tags/tag-bad-2: badRefContent: invalid ref content
    ++	warning: refs/heads/branch-garbage: trailingRefContent: trailing garbage in ref
    ++	warning: refs/heads/branch-no-newline: refMissingNewline: missing newline
    ++	warning: refs/tags/tag-garbage-1: trailingRefContent: trailing garbage in ref
    ++	warning: refs/tags/tag-garbage-2: trailingRefContent: trailing garbage in ref
    ++	warning: refs/tags/tag-garbage-3: trailingRefContent: trailing garbage in ref
    ++	warning: refs/tags/tag-garbage-4: trailingRefContent: trailing garbage in ref
    ++	EOF
    ++	sort err >sorted_err &&
    ++	test_cmp expect sorted_err
    ++'
     +
      test_done
3:  76dcf6bf58 ! 3:  0691e2960d ref: add symbolic ref content check for files backend
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    ref: add symbolic ref content check for files backend
    +    ref: add symref content check for files backend
     
         We have already introduced the checks for regular refs. There is no need
    -    to check the consistency of the target which the symbolic ref points to.
    -    Instead, we just check the content of the symbolic ref itself.
    +    to check the consistency of the target which the symref points to.
    +    Instead, we just need to check the content of teh symref itself.
     
    -    In order to check the content of the symbolic ref, create a function
    -    "files_fsck_symref_target". It will first check whether the "pointee" is
    -    under the "refs/" directory and then we will check the "pointee" itself.
    +    In order to check the content of the symref, create a function
    +    "files_fsck_symref_target". It will first check whether the "referent"
    +    is under the "refs/" directory and then we will check the symref
    +    contents.
     
    -    There is no specification about the content of the symbolic ref.
    -    Although we do write "ref: %s\n" to create a symbolic ref by using
    -    "git-symbolic-ref(1)" command. However, this is not mandatory. We still
    -    accept symbolic refs with null trailing garbage. Put it more specific,
    -    the following are correct:
    +    A regular file is accepted as a textual symref if it begins with
    +    "ref:", followed by zero or more whitespaces, followed by the full
    +    refname, followed only by whitespace characters. We always write
    +    a single SP after "ref:" and a single LF after the refname, but
    +    third-party reimplementations of Git may have taken advantage of the
    +    looser syntax. Put it more specific, we accept the following contents
    +    of the symref:
     
         1. "ref: refs/heads/master   "
         2. "ref: refs/heads/master   \n  \n"
         3. "ref: refs/heads/master\n\n"
     
    -    But we do not allow any non-null trailing garbage. The following are bad
    -    symbolic contents which will be reported as fsck error by "git-fsck(1)".
    +    But we do not allow any other trailing garbage. The followings are bad
    +    symref contents which will be reported as fsck error by "git-fsck(1)".
     
         1. "ref: refs/heads/master garbage\n"
         2. "ref: refs/heads/master \n\n\n garbage  "
     
    -    In order to provide above checks, we will use "strrchr" to check whether
    -    we have newline in the ref content. Then we will check the name of the
    -    "pointee" is correct by using "check_refname_format". If the function
    -    fails, we need to trim the "pointee" to see whether the null-garbage
    -    causes the function fails. If so, we need to report that there is
    -    null-garbage in the symref content. Otherwise, we should report the user
    -    the "pointee" is bad.
    +    In order to provide above checks, we will first check whether the symref
    +    content misses the newline by peeking the last byte of the "referent" to
    +    see whether it is '\n'.
    +
    +    And we will remember the untrimmed length of the "referent" and call
    +    "strbuf_rtrim()" on "referent". Then, we will call "check_refname_format"
    +    to chceck whether the trimmed referent format is valid. If not, we will
    +    report to the user that the symref points to referent which has invalid
    +    format. If it is valid, we will compare the untrimmed length and trimmed
    +    length, if they are not the same, we need to warn the user there is some
    +    trailing garbage in the symref content.
    +
    +    At last, we need to check whether the referent is the directory. We
    +    cannot distinguish whether the "refs/heads/a" is a directory or not by
    +    using "check_refname_format". We have already checked bad file type when
    +    iterating the "refs/" directory but we ignore the directory. Thus, we
    +    need to explicitly add check here.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ Documentation/fsck-msgids.txt
      `badRefName`::
      	(ERROR) A ref has an invalid format.
      
    -+`badSymrefPointee`::
    -+	(ERROR) The pointee of a symref is bad.
    ++`badSymrefTarget`::
    ++	(ERROR) The symref target points outside the ref directory or
    ++	the name of the symref target is invalid.
     +
      `badTagName`::
      	(INFO) A tag has an invalid format.
    @@ fsck.h: enum fsck_msg_type {
      	FUNC(BAD_REF_CONTENT, ERROR) \
      	FUNC(BAD_REF_FILETYPE, ERROR) \
      	FUNC(BAD_REF_NAME, ERROR) \
    -+	FUNC(BAD_SYMREF_POINTEE, ERROR) \
    ++	FUNC(BAD_SYMREF_TARGET, ERROR) \
      	FUNC(BAD_TIMEZONE, ERROR) \
      	FUNC(BAD_TREE, ERROR) \
      	FUNC(BAD_TREE_SHA1, ERROR) \
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
      				  struct dir_iterator *iter);
      
     +/*
    -+ * Check the symref "pointee_name" and "pointee_path". The caller should
    -+ * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
    -+ * would be the content after "refs:".
    ++ * Check the symref "referent" and "referent_path". For textual symref,
    ++ * "referent" would be the content after "refs:".
     + */
     +static int files_fsck_symref_target(struct fsck_options *o,
     +				    struct fsck_ref_report *report,
    -+				    const char *refname,
    -+				    struct strbuf *pointee_name,
    -+				    struct strbuf *pointee_path)
    ++				    struct strbuf *referent,
    ++				    struct strbuf *referent_path)
     +{
    -+	const char *newline_pos = NULL;
    ++	size_t len = referent->len - 1;
     +	const char *p = NULL;
     +	struct stat st;
     +	int ret = 0;
     +
    -+	if (!skip_prefix(pointee_name->buf, "refs/", &p)) {
    ++	if (!skip_prefix(referent->buf, "refs/", &p)) {
     +
     +		ret = fsck_report_ref(o, report,
    -+				      FSCK_MSG_BAD_SYMREF_POINTEE,
    ++				      FSCK_MSG_BAD_SYMREF_TARGET,
     +				      "points to ref outside the refs directory");
     +		goto out;
     +	}
     +
    -+	newline_pos = strrchr(p, '\n');
    -+	if (!newline_pos || *(newline_pos + 1)) {
    ++	if (referent->buf[referent->len - 1] != '\n') {
     +		ret = fsck_report_ref(o, report,
     +				      FSCK_MSG_REF_MISSING_NEWLINE,
     +				      "missing newline");
    ++		len++;
     +	}
     +
    -+	if (check_refname_format(pointee_name->buf, 0)) {
    -+		/*
    -+		 * When containing null-garbage, "check_refname_format" will
    -+		 * fail, we should trim the "pointee" to check again.
    -+		 */
    -+		strbuf_rtrim(pointee_name);
    -+		if (!check_refname_format(pointee_name->buf, 0)) {
    -+			ret = fsck_report_ref(o, report,
    -+					      FSCK_MSG_TRAILING_REF_CONTENT,
    -+					      "trailing null-garbage");
    -+			goto out;
    -+		}
    -+
    ++	strbuf_rtrim(referent);
    ++	if (check_refname_format(referent->buf, 0)) {
     +		ret = fsck_report_ref(o, report,
    -+				      FSCK_MSG_BAD_SYMREF_POINTEE,
    ++				      FSCK_MSG_BAD_SYMREF_TARGET,
     +				      "points to refname with invalid format");
    ++		goto out;
    ++	}
    ++
    ++	if (len != referent->len) {
    ++		ret = fsck_report_ref(o, report,
    ++				      FSCK_MSG_TRAILING_REF_CONTENT,
    ++				      "trailing garbage in ref");
     +	}
     +
     +	/*
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +	 * ref that does not exist yet. If the target ref does not exist, just
     +	 * skip the check for the file type.
     +	 */
    -+	if (lstat(pointee_path->buf, &st) < 0)
    ++	if (lstat(referent_path->buf, &st))
     +		goto out;
     +
    -+	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
    ++	/*
    ++	 * We cannot distinguish whether "refs/heads/a" is directory or nots by
    ++	 * using "check_refname_format(referent->buf, 0)". Instead, we need to
    ++	 * check the file type of the target.
    ++	 */
    ++	if (S_ISDIR(st.st_mode)) {
     +		ret = fsck_report_ref(o, report,
    -+				      FSCK_MSG_BAD_SYMREF_POINTEE,
    -+				      "points to an invalid file type");
    ++				      FSCK_MSG_BAD_SYMREF_TARGET,
    ++				      "points to the directory");
     +		goto out;
     +	}
     +
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
      				   const char *refs_check_dir,
      				   struct dir_iterator *iter)
      {
    -+	struct strbuf pointee_path = STRBUF_INIT;
    ++	struct strbuf referent_path = STRBUF_INIT;
      	struct strbuf ref_content = STRBUF_INIT;
      	struct strbuf referent = STRBUF_INIT;
      	struct strbuf refname = STRBUF_INIT;
     @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_store,
    - 						      "trailing garbage in ref");
    - 				goto cleanup;
    - 			}
    -+		} else {
    -+			strbuf_addf(&pointee_path, "%s/%s",
    -+				    ref_store->gitdir, referent.buf);
    -+			ret = files_fsck_symref_target(o, &report, refname.buf,
    -+						       &referent,
    -+						       &pointee_path);
    + 					      "trailing garbage in ref");
    + 			goto cleanup;
      		}
    - 		goto cleanup;
    ++	} else {
    ++		strbuf_addf(&referent_path, "%s/%s",
    ++			    ref_store->gitdir, referent.buf);
    ++		/*
    ++		 * the referent may contain the spaces and the newline, need to
    ++		 * trim for path.
    ++		 */
    ++		strbuf_rtrim(&referent_path);
    ++		ret = files_fsck_symref_target(o, &report,
    ++					       &referent,
    ++					       &referent_path);
      	}
    -@@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_store,
    + 
    + cleanup:
      	strbuf_release(&refname);
      	strbuf_release(&ref_content);
      	strbuf_release(&referent);
    -+	strbuf_release(&pointee_path);
    ++	strbuf_release(&referent_path);
      	return ret;
      }
      
     
      ## t/t0602-reffiles-fsck.sh ##
    -@@ t/t0602-reffiles-fsck.sh: test_expect_success 'regular ref content should be checked' '
    - 	test_cmp expect err
    +@@ t/t0602-reffiles-fsck.sh: test_expect_success 'regular ref content should be checked (aggregate)' '
    + 	test_cmp expect sorted_err
      '
      
    -+test_expect_success 'symbolic ref content should be checked' '
    ++test_expect_success 'textual symref content should be checked (individual)' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	branch_dir_prefix=.git/refs/heads &&
     +	tag_dir_prefix=.git/refs/tags &&
     +	cd repo &&
    -+	git commit --allow-empty -m initial &&
    -+	git checkout -b branch-1 &&
    -+	git tag tag-1 &&
    -+	git checkout -b a/b/branch-2 &&
    ++	test_commit default &&
    ++	mkdir -p "$branch_dir_prefix/a/b" &&
    ++
    ++	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
    ++	git refs verify 2>err &&
    ++	rm $branch_dir_prefix/branch-good &&
    ++	test_must_be_empty err &&
    ++
    ++	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
    ++	git refs verify 2>err &&
    ++	cat >expect <<-EOF &&
    ++	warning: refs/heads/branch-no-newline-1: refMissingNewline: missing newline
    ++	EOF
    ++	rm $branch_dir_prefix/branch-no-newline-1 &&
    ++	test_cmp expect err &&
     +
    -+	printf "ref: refs/heads/branch" > $branch_dir_prefix/branch-1-no-newline &&
    ++	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	warning: refs/heads/branch-1-no-newline: refMissingNewline: missing newline
    ++	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: missing newline
    ++	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: trailing garbage in ref
     +	EOF
    -+	rm $branch_dir_prefix/branch-1-no-newline &&
    ++	rm $branch_dir_prefix/a/b/branch-trailing-1 &&
     +	test_cmp expect err &&
     +
    -+	printf "ref: refs/heads/branch     " > $branch_dir_prefix/a/b/branch-trailing &&
    ++	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	warning: refs/heads/a/b/branch-trailing: refMissingNewline: missing newline
    -+	warning: refs/heads/a/b/branch-trailing: trailingRefContent: trailing null-garbage
    ++	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: trailing garbage in ref
     +	EOF
    -+	rm $branch_dir_prefix/a/b/branch-trailing &&
    ++	rm $branch_dir_prefix/a/b/branch-trailing-2 &&
     +	test_cmp expect err &&
     +
    -+	printf "ref: refs/heads/branch\n\n" > $branch_dir_prefix/a/b/branch-trailing &&
    ++	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	warning: refs/heads/a/b/branch-trailing: trailingRefContent: trailing null-garbage
    ++	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: trailing garbage in ref
     +	EOF
    -+	rm $branch_dir_prefix/a/b/branch-trailing &&
    ++	rm $branch_dir_prefix/a/b/branch-trailing-3 &&
     +	test_cmp expect err &&
     +
    -+	printf "ref: refs/heads/branch \n\n " > $branch_dir_prefix/a/b/branch-trailing &&
    ++	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	warning: refs/heads/a/b/branch-trailing: refMissingNewline: missing newline
    -+	warning: refs/heads/a/b/branch-trailing: trailingRefContent: trailing null-garbage
    ++	warning: refs/heads/a/b/branch-complicated: refMissingNewline: missing newline
    ++	warning: refs/heads/a/b/branch-complicated: trailingRefContent: trailing garbage in ref
     +	EOF
    -+	rm $branch_dir_prefix/a/b/branch-trailing &&
    ++	rm $branch_dir_prefix/a/b/branch-complicated &&
     +	test_cmp expect err &&
     +
    -+	printf "ref: refs/heads/.branch\n" > $branch_dir_prefix/branch-2-bad &&
    ++	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
     +	test_must_fail git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	error: refs/heads/branch-2-bad: badSymrefPointee: points to refname with invalid format
    ++	error: refs/heads/branch-bad-1: badSymrefTarget: points to refname with invalid format
     +	EOF
    -+	rm $branch_dir_prefix/branch-2-bad &&
    ++	rm $branch_dir_prefix/branch-bad-1 &&
    ++	test_cmp expect err &&
    ++
    ++	printf "ref: reflogs/heads/main\n" >$branch_dir_prefix/branch-bad-2 &&
    ++	test_must_fail git refs verify 2>err &&
    ++	cat >expect <<-EOF &&
    ++	error: refs/heads/branch-bad-2: badSymrefTarget: points to ref outside the refs directory
    ++	EOF
    ++	rm $branch_dir_prefix/branch-bad-2 &&
    ++	test_cmp expect err &&
    ++
    ++	printf "ref: refs/heads/a\n" >$branch_dir_prefix/branch-bad-3 &&
    ++	test_must_fail git refs verify 2>err &&
    ++	cat >expect <<-EOF &&
    ++	error: refs/heads/branch-bad-3: badSymrefTarget: points to the directory
    ++	EOF
    ++	rm $branch_dir_prefix/branch-bad-3 &&
     +	test_cmp expect err
     +'
    ++
    ++test_expect_success 'textual symref content should be checked (aggregate)' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	branch_dir_prefix=.git/refs/heads &&
    ++	tag_dir_prefix=.git/refs/tags &&
    ++	cd repo &&
    ++	test_commit default &&
    ++	mkdir -p "$branch_dir_prefix/a/b" &&
    ++
    ++	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
    ++	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
    ++	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
    ++	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
    ++	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
    ++	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
    ++	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
    ++	printf "ref: reflogs/heads/main\n" >$branch_dir_prefix/branch-bad-2 &&
    ++	printf "ref: refs/heads/a\n" >$branch_dir_prefix/branch-bad-3 &&
    ++
    ++	test_must_fail git refs verify 2>err &&
    ++	cat >expect <<-EOF &&
    ++	error: refs/heads/branch-bad-1: badSymrefTarget: points to refname with invalid format
    ++	error: refs/heads/branch-bad-2: badSymrefTarget: points to ref outside the refs directory
    ++	error: refs/heads/branch-bad-3: badSymrefTarget: points to the directory
    ++	warning: refs/heads/a/b/branch-complicated: refMissingNewline: missing newline
    ++	warning: refs/heads/a/b/branch-complicated: trailingRefContent: trailing garbage in ref
    ++	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: missing newline
    ++	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: trailing garbage in ref
    ++	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: trailing garbage in ref
    ++	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: trailing garbage in ref
    ++	warning: refs/heads/branch-no-newline-1: refMissingNewline: missing newline
    ++	EOF
    ++	sort err >sorted_err &&
    ++	test_cmp expect sorted_err
    ++'
     +
      test_done
4:  2008f8635c ! 4:  4105bfa1e3 ref: add symlink ref check for files backend
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    ref: add symlink ref check for files backend
    +    ref: add symlink ref content check for files backend
     
         We have already introduced "files_fsck_symref_target". We should reuse
    -    this function to handle the symrefs which are legacy symbolic links. We
    -    should not check the trailing garbage for symbolic links. Add a new
    +    this function to handle the symrefs which use legacy symbolic links. We
    +    should not check the trailing garbage for symbolic refs. Add a new
         parameter "symbolic_link" to disable some checks which should only be
    -    used for symbolic ref.
    +    executed for textual symrefs.
     
    -    We firstly use the "strbuf_add_real_path" to resolve the symlinks and
    -    get the absolute path "pointee_path" which the symlink ref points to.
    -    Then we can get the absolute path "abs_gitdir" of the "gitdir". By
    -    combining "pointee_path" and "abs_gitdir", we can extract the
    +    We firstly use the "strbuf_add_real_path" to resolve the symlink and
    +    get the absolute path "referent_path" which the symlink ref points
    +    to. Then we can get the absolute path "abs_gitdir" of the "gitdir".
    +    By combining "referent_path" and "abs_gitdir", we can extract the
         "referent". Thus, we can reuse "files_fsck_symref_target" function to
         seamlessly check the symlink refs.
     
    +    Because we are going to drop support for "core.prefersymlinkrefs", add a
    +    new fsck message "symlinkRef" to let the user be aware of this
    +    information.
    +
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
    + ## Documentation/fsck-msgids.txt ##
    +@@
    + 	(INFO) A ref does not end with newline. This kind of ref may
    + 	be considered ERROR in the future.
    + 
    ++`symlinkRef`::
    ++	(INFO) A symref uses the symbolic link. This kind of symref may
    ++	be considered ERROR in the future when totally dropping the
    ++	symlink support.
    ++
    + `trailingRefContent`::
    + 	(INFO) A ref has trailing contents. This kind of ref may be
    + 	considered ERROR in the future.
    +
    + ## fsck.h ##
    +@@ fsck.h: enum fsck_msg_type {
    + 	FUNC(BAD_TAG_NAME, INFO) \
    + 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
    + 	FUNC(REF_MISSING_NEWLINE, INFO) \
    ++	FUNC(SYMLINK_REF, INFO) \
    + 	FUNC(TRAILING_REF_CONTENT, INFO) \
    + 	/* ignored (elevated when requested) */ \
    + 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
    +
      ## refs/files-backend.c ##
     @@
      #include "../git-compat-util.h"
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
      			goto out;
      		}
     @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
    + 
      /*
    -  * Check the symref "pointee_name" and "pointee_path". The caller should
    -  * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
    -- * would be the content after "refs:".
    -+ * would be the content after "refs:". For symblic link, "pointee_name" would
    -+ * be the relative path agaignst "gitdir".
    +  * Check the symref "referent" and "referent_path". For textual symref,
    +- * "referent" would be the content after "refs:".
    ++ * "referent" would be the content after "refs:". For symlink ref,
    ++ * "referent" would be the relative path agaignst "gitdir" which should
    ++ * be the same as the textual symref literally.
       */
      static int files_fsck_symref_target(struct fsck_options *o,
      				    struct fsck_ref_report *report,
    --				    const char *refname,
    - 				    struct strbuf *pointee_name,
    --				    struct strbuf *pointee_path)
    -+				    struct strbuf *pointee_path,
    + 				    struct strbuf *referent,
    +-				    struct strbuf *referent_path)
    ++				    struct strbuf *referent_path,
     +				    unsigned int symbolic_link)
      {
    - 	const char *newline_pos = NULL;
    + 	size_t len = referent->len - 1;
      	const char *p = NULL;
     @@ refs/files-backend.c: static int files_fsck_symref_target(struct fsck_options *o,
      		goto out;
      	}
      
    --	newline_pos = strrchr(p, '\n');
    --	if (!newline_pos || *(newline_pos + 1)) {
    --		ret = fsck_report_ref(o, report,
    --				      FSCK_MSG_REF_MISSING_NEWLINE,
    --				      "missing newline");
    -+	if (!symbolic_link) {
    -+		newline_pos = strrchr(p, '\n');
    -+		if (!newline_pos || *(newline_pos + 1)) {
    -+			ret = fsck_report_ref(o, report,
    -+					      FSCK_MSG_REF_MISSING_NEWLINE,
    -+					      "missing newline");
    -+		}
    +-	if (referent->buf[referent->len - 1] != '\n') {
    ++	if (!symbolic_link && referent->buf[referent->len - 1] != '\n') {
    + 		ret = fsck_report_ref(o, report,
    + 				      FSCK_MSG_REF_MISSING_NEWLINE,
    + 				      "missing newline");
    + 		len++;
      	}
      
    - 	if (check_refname_format(pointee_name->buf, 0)) {
    --		/*
    --		 * When containing null-garbage, "check_refname_format" will
    --		 * fail, we should trim the "pointee" to check again.
    --		 */
    --		strbuf_rtrim(pointee_name);
    --		if (!check_refname_format(pointee_name->buf, 0)) {
    --			ret = fsck_report_ref(o, report,
    --					      FSCK_MSG_TRAILING_REF_CONTENT,
    --					      "trailing null-garbage");
    --			goto out;
    -+		if (!symbolic_link) {
    -+			/*
    -+			* When containing null-garbage, "check_refname_format" will
    -+			* fail, we should trim the "pointee" to check again.
    -+			*/
    -+			strbuf_rtrim(pointee_name);
    -+			if (!check_refname_format(pointee_name->buf, 0)) {
    -+				ret = fsck_report_ref(o, report,
    -+						      FSCK_MSG_TRAILING_REF_CONTENT,
    -+						      "trailing null-garbage");
    -+				goto out;
    -+			}
    - 		}
    +-	strbuf_rtrim(referent);
    ++	if (!symbolic_link)
    ++		strbuf_rtrim(referent);
    ++
    + 	if (check_refname_format(referent->buf, 0)) {
    + 		ret = fsck_report_ref(o, report,
    + 				      FSCK_MSG_BAD_SYMREF_TARGET,
    +@@ refs/files-backend.c: static int files_fsck_symref_target(struct fsck_options *o,
    + 		goto out;
    + 	}
      
    +-	if (len != referent->len) {
    ++	if (!symbolic_link && len != referent->len) {
      		ret = fsck_report_ref(o, report,
    + 				      FSCK_MSG_TRAILING_REF_CONTENT,
    + 				      "trailing garbage in ref");
     @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_store,
      {
    - 	struct strbuf pointee_path = STRBUF_INIT;
    + 	struct strbuf referent_path = STRBUF_INIT;
      	struct strbuf ref_content = STRBUF_INIT;
     +	struct strbuf abs_gitdir = STRBUF_INIT;
      	struct strbuf referent = STRBUF_INIT;
      	struct strbuf refname = STRBUF_INIT;
      	struct fsck_ref_report report = {0};
    -+	const char *pointee_name = NULL;
     +	unsigned int symbolic_link = 0;
      	const char *trailing = NULL;
      	unsigned int type = 0;
      	int failure_errno = 0;
     @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_store,
    - 		} else {
    - 			strbuf_addf(&pointee_path, "%s/%s",
    - 				    ref_store->gitdir, referent.buf);
    --			ret = files_fsck_symref_target(o, &report, refname.buf,
    -+			ret = files_fsck_symref_target(o, &report,
    - 						       &referent,
    --						       &pointee_path);
    -+						       &pointee_path,
    -+						       symbolic_link);
    - 		}
    - 		goto cleanup;
    - 	}
    + 	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
    + 	report.path = refname.buf;
      
    -+	symbolic_link = 1;
    -+
    -+	strbuf_add_real_path(&pointee_path, iter->path.buf);
    -+	strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
    -+	strbuf_normalize_path(&abs_gitdir);
    -+	if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
    -+		strbuf_addch(&abs_gitdir, '/');
    +-	if (S_ISLNK(iter->st.st_mode))
    ++	if (S_ISLNK(iter->st.st_mode)) {
    ++		const char* relative_referent_path;
     +
    -+	if (!skip_prefix(pointee_path.buf, abs_gitdir.buf, &pointee_name)) {
    ++		symbolic_link = 1;
     +		ret = fsck_report_ref(o, &report,
    -+				      FSCK_MSG_BAD_SYMREF_POINTEE,
    -+				      "point to target outside gitdir");
    -+		goto cleanup;
    -+	}
    ++				      FSCK_MSG_SYMLINK_REF,
    ++				      "use deprecated symbolic link for symref");
     +
    -+	strbuf_addstr(&referent, pointee_name);
    -+	ret = files_fsck_symref_target(o, &report,
    -+				       &referent, &pointee_path,
    -+				       symbolic_link);
    ++		strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
    ++		strbuf_normalize_path(&abs_gitdir);
    ++		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
    ++			strbuf_addch(&abs_gitdir, '/');
     +
    ++		strbuf_add_real_path(&referent_path, iter->path.buf);
    ++
    ++		if (!skip_prefix(referent_path.buf,
    ++				 abs_gitdir.buf,
    ++				 &relative_referent_path)) {
    ++			ret = fsck_report_ref(o, &report,
    ++					      FSCK_MSG_BAD_SYMREF_TARGET,
    ++					      "point to target outside gitdir");
    ++			goto cleanup;
    ++		}
    ++
    ++		strbuf_addstr(&referent, relative_referent_path);
    ++		ret = files_fsck_symref_target(o, &report,
    ++					       &referent, &referent_path,
    ++					       symbolic_link);
    ++
    + 		goto cleanup;
    ++	}
    + 
    + 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
    + 		ret = error_errno(_("%s/%s: unable to read the ref"),
    +@@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_store,
    + 		strbuf_rtrim(&referent_path);
    + 		ret = files_fsck_symref_target(o, &report,
    + 					       &referent,
    +-					       &referent_path);
    ++					       &referent_path,
    ++					       symbolic_link);
    + 	}
    + 
      cleanup:
    - 	strbuf_release(&refname);
    +@@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_store,
      	strbuf_release(&ref_content);
      	strbuf_release(&referent);
    - 	strbuf_release(&pointee_path);
    + 	strbuf_release(&referent_path);
     +	strbuf_release(&abs_gitdir);
      	return ret;
      }
      
     
      ## t/t0602-reffiles-fsck.sh ##
    -@@ t/t0602-reffiles-fsck.sh: test_expect_success 'symbolic ref content should be checked' '
    - 	test_cmp expect err
    +@@ t/t0602-reffiles-fsck.sh: test_expect_success 'textual symref content should be checked (aggregate)' '
    + 	test_cmp expect sorted_err
      '
      
    -+test_expect_success SYMLINKS 'symbolic ref (symbolic link) content should be checked' '
    ++test_expect_success SYMLINKS 'symlink symref content should be checked (individual)' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	branch_dir_prefix=.git/refs/heads &&
     +	tag_dir_prefix=.git/refs/tags &&
     +	cd repo &&
    -+	git commit --allow-empty -m initial &&
    -+	git checkout -b branch-1 &&
    -+	git tag tag-1 &&
    -+	git checkout -b a/b/branch-2 &&
    ++	test_commit default &&
    ++	mkdir -p "$branch_dir_prefix/a/b" &&
    ++
    ++	ln -sf ./main $branch_dir_prefix/branch-symbolic-good &&
    ++	git refs verify 2>err &&
    ++	cat >expect <<-EOF &&
    ++	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
    ++	EOF
    ++	rm $branch_dir_prefix/branch-symbolic-good &&
    ++	test_cmp expect err &&
    ++
    ++	ln -sf ../../../../branch $branch_dir_prefix/branch-symbolic-1 &&
    ++	test_must_fail git refs verify 2>err &&
    ++	cat >expect <<-EOF &&
    ++	warning: refs/heads/branch-symbolic-1: symlinkRef: use deprecated symbolic link for symref
    ++	error: refs/heads/branch-symbolic-1: badSymrefTarget: point to target outside gitdir
    ++	EOF
    ++	rm $branch_dir_prefix/branch-symbolic-1 &&
    ++	test_cmp expect err &&
     +
    -+	ln -sf ../../../../branch $branch_dir_prefix/branch-symbolic &&
    ++	ln -sf ../../logs/branch-bad $branch_dir_prefix/branch-symbolic-2 &&
     +	test_must_fail git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	error: refs/heads/branch-symbolic: badSymrefPointee: point to target outside gitdir
    ++	warning: refs/heads/branch-symbolic-2: symlinkRef: use deprecated symbolic link for symref
    ++	error: refs/heads/branch-symbolic-2: badSymrefTarget: points to ref outside the refs directory
     +	EOF
    -+	rm $branch_dir_prefix/branch-symbolic &&
    ++	rm $branch_dir_prefix/branch-symbolic-2 &&
     +	test_cmp expect err &&
     +
    -+	ln -sf ../../logs/branch-bad $branch_dir_prefix/branch-symbolic &&
    ++	ln -sf ./"branch   space" $branch_dir_prefix/branch-symbolic-3 &&
     +	test_must_fail git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	error: refs/heads/branch-symbolic: badSymrefPointee: points to ref outside the refs directory
    ++	warning: refs/heads/branch-symbolic-3: symlinkRef: use deprecated symbolic link for symref
    ++	error: refs/heads/branch-symbolic-3: badSymrefTarget: points to refname with invalid format
     +	EOF
    -+	rm $branch_dir_prefix/branch-symbolic &&
    ++	rm $branch_dir_prefix/branch-symbolic-3 &&
     +	test_cmp expect err &&
     +
    -+	ln -sf ./"branch   space" $branch_dir_prefix/branch-symbolic &&
    ++	ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
     +	test_must_fail git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	error: refs/heads/branch-symbolic: badSymrefPointee: points to refname with invalid format
    ++	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
    ++	error: refs/tags/tag-symbolic-1: badSymrefTarget: points to refname with invalid format
     +	EOF
    -+	rm $branch_dir_prefix/branch-symbolic &&
    ++	rm $tag_dir_prefix/tag-symbolic-1 &&
     +	test_cmp expect err &&
     +
    -+	ln -sf ./".branch" $branch_dir_prefix/branch-symbolic &&
    ++	ln -sf ./ $tag_dir_prefix/tag-symbolic-2 &&
     +	test_must_fail git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	error: refs/heads/branch-symbolic: badSymrefPointee: points to refname with invalid format
    ++	warning: refs/tags/tag-symbolic-2: symlinkRef: use deprecated symbolic link for symref
    ++	error: refs/tags/tag-symbolic-2: badSymrefTarget: points to the directory
     +	EOF
    -+	rm $branch_dir_prefix/branch-symbolic &&
    ++	rm $tag_dir_prefix/tag-symbolic-2 &&
     +	test_cmp expect err
     +'
    ++
    ++test_expect_success SYMLINKS 'symlink symref content should be checked (aggregate)' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	branch_dir_prefix=.git/refs/heads &&
    ++	tag_dir_prefix=.git/refs/tags &&
    ++	cd repo &&
    ++	test_commit default &&
    ++	mkdir -p "$branch_dir_prefix/a/b" &&
    ++
    ++	ln -sf ./main $branch_dir_prefix/branch-symbolic-good &&
    ++	ln -sf ../../../../branch $branch_dir_prefix/branch-symbolic-1 &&
    ++	ln -sf ../../logs/branch-bad $branch_dir_prefix/branch-symbolic-2 &&
    ++	ln -sf ./"branch   space" $branch_dir_prefix/branch-symbolic-3 &&
    ++	ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
    ++	ln -sf ./ $tag_dir_prefix/tag-symbolic-2 &&
    ++
    ++	test_must_fail git refs verify 2>err &&
    ++	cat >expect <<-EOF &&
    ++	error: refs/heads/branch-symbolic-1: badSymrefTarget: point to target outside gitdir
    ++	error: refs/heads/branch-symbolic-2: badSymrefTarget: points to ref outside the refs directory
    ++	error: refs/heads/branch-symbolic-3: badSymrefTarget: points to refname with invalid format
    ++	error: refs/tags/tag-symbolic-1: badSymrefTarget: points to refname with invalid format
    ++	error: refs/tags/tag-symbolic-2: badSymrefTarget: points to the directory
    ++	warning: refs/heads/branch-symbolic-1: symlinkRef: use deprecated symbolic link for symref
    ++	warning: refs/heads/branch-symbolic-2: symlinkRef: use deprecated symbolic link for symref
    ++	warning: refs/heads/branch-symbolic-3: symlinkRef: use deprecated symbolic link for symref
    ++	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
    ++	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
    ++	warning: refs/tags/tag-symbolic-2: symlinkRef: use deprecated symbolic link for symref
    ++	EOF
    ++	sort err >sorted_err &&
    ++	test_cmp expect sorted_err
    ++'
     +
      test_done
-- 
2.46.0

