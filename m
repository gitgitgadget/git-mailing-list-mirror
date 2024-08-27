Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F91BFE00
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774831; cv=none; b=He+PLlplbLyulr3rUnghCaDVkLjhyF+QGxR1CdRNd+SxBLWbUbHaEn0sWKC67xsY46Z2wR0TO3q+3rEJBGWJvCcaUJSrfmi0g1fcg5YZ7fALWohovzULtJMzq5eiZXlnKTOZCnUPqsADbsqBzp0wMnq1DIWkjIH4POQlPDjTjJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774831; c=relaxed/simple;
	bh=TDvfFTLf3vQWEaPKHpXQqc2VPvyqeFVL9HqH0H0Qjqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu15PL84Yuiv8mW9NnKMQG1T2mrrrYYXM2p2WEa/Sgpf1Ui5u4ihU2Ax7VjLOyihxp9r0aat5/iMWqeuSZwyhM7TE3BseYClmZuVXmGp3lVAlZWVLYhmReNmAxbnIk3EiFHqKprRl0VQtX6/Ib5eTpRAPDs4HCZp50xSfQreYsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcic3GR/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcic3GR/"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so3956863b3a.1
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724774829; x=1725379629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L4GVbGUDr/SIkIAzGDiiG/B9lqyJg1hN0ces4Q/fxqk=;
        b=bcic3GR/+4Pa5h5UEvipOxXdsTYpJCO74dr5ohuej9Ry80ATIq5A9zaF79nxLGESO7
         058S4EZW/TCgnni5yTnYUfSmvTT1Iti8ifiJM8q7m04pn/4m87OxRBBucw9ltxfo0IyB
         t7i4/sOeHQwvNvPi8ovytwlZAzz5gDJQNKFP3Z3bCbJOdUlGNLrAS37t7sYU3+ixT422
         WautNryMaKBC6X7aDs5WLkBnvrgkuDCP1VO0dU08SgVnd3lp+RKZsOh4u+MlnXkloLNU
         8pNlFEgWX1IrtnBYenGGeKf52NtVHYkYZ632nBUlbSFKIw705mPzwAcWD5K0UWUy9tZs
         dUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724774829; x=1725379629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4GVbGUDr/SIkIAzGDiiG/B9lqyJg1hN0ces4Q/fxqk=;
        b=XBFsojYT41k/LIREqOcAsue2KDU/837CbOfPMy4Cuba118XN6otJT0a0gwmcZ6TYJ9
         52xEqOcJ1r74F4NnwgQlBL8zZCnUf/JZ+x1LZoDT4AY57Cz2VTI3IBLfYouVk5XSfd02
         6uf4uz1pZIcHHJiojlGSmBfHQxl90nL/stO5PxlymVMyHE78qC0fQ+n1l8AY6Rz4NQKt
         xzL6TFgzpVv0lboBvcOKxJU9sPM7gFvUM158Rsjncgd8oLnFBolDyUpfKJ8uuCx5vAQW
         f3gnxrv9F4DWgrLZSupdaQ+TEe+R7wou6jphUWCYpx59lebGGw5w2d3co9WyjLMI3LFZ
         wfGg==
X-Gm-Message-State: AOJu0YxEsshTnXdnkmDkb/lt4lfNQwDkh2PzisoXlBB3d5s+LP+LqKQQ
	Cx6w54eZ1COPxvDP6eVDT3dnp1gHVmvXwzy9IcNyWS3SuJuZX4L4mZeYDw==
X-Google-Smtp-Source: AGHT+IFYBiGogy3OftT1Ob40M4zbzXjZ2h+YtpSQJF6/Q/3ffkqMuJa3K0LP4gQs5fTjB4Pk0xjL2A==
X-Received: by 2002:a05:6a21:1191:b0:1c0:f5fa:cbe6 with SMTP id adf61e73a8af0-1cc89d7dca6mr15296150637.22.1724774828441;
        Tue, 27 Aug 2024 09:07:08 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ecd6sm8768819b3a.31.2024.08.27.09.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:07:08 -0700 (PDT)
Date: Wed, 28 Aug 2024 00:07:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] ref: add regular ref content check for files backend
Message-ID: <Zs353oLDaw2SbNQs@ArchLinux>
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

We implicitly rely on "git-fsck(1)" to check the consistency of regular
refs. However, when parsing the regular refs for files backend by using
"files-backend.c::parse_loose_ref_contents", we allow the ref content to
be end with no newline or contain some garbages.

It may seem that we should report an error or warn fsck message to the
user about above situations. However, there may be some third-party
tools customizing the content of refs. We should not report an error
fsck message.

And we cannot either report a warn fsck message to the user. This is
because if the caller set the "strict" field in "fsck_options" to
to upgrade the fsck warnings to errors.

We should not allow the user to upgrade the fsck warnings to errors. It
might cause compatibility issue which will break the legacy repository.
So we add the following two fsck infos to represent the situation where
the ref content ends without newline or has garbages:

1. "refMissingNewline(INFO)": A valid ref does not end with newline.
2. "trailingRefContent(INFO)": A ref has trailing contents.

In "fsck.c::fsck_vreport", we will convert "FSCK_INFO" to "FSCK_WARN",
and we can still warn the user about these situations when using
"git-refs verify" without introducing compatibility issue.

In current "git-fsck(1)", it will report an error when the ref content
is bad, so we should following this to report an error to the user when
"parse_loose_ref_contents" fails. And we add a new fsck error message
called "badRefContent(ERROR)" to represent that a ref has a bad content.

In order to tell whether the ref has trailing content, add a new
parameter "trailing" to "parse_loose_ref_contents". Then introduce a new
function "files_fsck_refs_content" to check the regular refs to enhance
the "git-refs verify".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  9 ++++
 fsck.h                        |  3 ++
 refs.c                        |  2 +-
 refs/files-backend.c          | 68 ++++++++++++++++++++++++++-
 refs/refs-internal.h          |  2 +-
 t/t0602-reffiles-fsck.sh      | 87 +++++++++++++++++++++++++++++++++++
 6 files changed, 167 insertions(+), 4 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 68a2801f15..fc074fc571 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -19,6 +19,9 @@
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
+`badRefContent`::
+	(ERROR) A ref has a bad content.
+
 `badRefFiletype`::
 	(ERROR) A ref has a bad file type.
 
@@ -170,6 +173,12 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`refMissingNewline`::
+	(INFO) A valid ref does not end with newline.
+
+`trailingRefContent`::
+	(INFO) A ref has trailing contents.
+
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
diff --git a/fsck.h b/fsck.h
index 500b4c04d2..b85072df57 100644
--- a/fsck.h
+++ b/fsck.h
@@ -31,6 +31,7 @@ enum fsck_msg_type {
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
@@ -84,6 +85,8 @@ enum fsck_msg_type {
 	FUNC(MAILMAP_SYMLINK, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
+	FUNC(REF_MISSING_NEWLINE, INFO) \
+	FUNC(TRAILING_REF_CONTENT, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
 
diff --git a/refs.c b/refs.c
index 74de3d3009..5e74881945 100644
--- a/refs.c
+++ b/refs.c
@@ -1758,7 +1758,7 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	}
 
 	result = parse_loose_ref_contents(ref_store->repo->hash_algo, content.buf,
-					  oid, referent, type, failure_errno);
+					  oid, referent, type, NULL, failure_errno);
 
 done:
 	strbuf_release(&full_path);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d6fc3bd67c..69c00073eb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -560,7 +560,7 @@ static int read_ref_internal(struct ref_store *ref_store, const char *refname,
 	buf = sb_contents.buf;
 
 	ret = parse_loose_ref_contents(ref_store->repo->hash_algo, buf,
-				       oid, referent, type, &myerr);
+				       oid, referent, type, NULL, &myerr);
 
 out:
 	if (ret && !myerr)
@@ -597,7 +597,7 @@ static int files_read_symbolic_ref(struct ref_store *ref_store, const char *refn
 int parse_loose_ref_contents(const struct git_hash_algo *algop,
 			     const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno)
+			     const char **trailing, int *failure_errno)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -619,6 +619,10 @@ int parse_loose_ref_contents(const struct git_hash_algo *algop,
 		*failure_errno = EINVAL;
 		return -1;
 	}
+
+	if (trailing)
+		*trailing = p;
+
 	return 0;
 }
 
@@ -3430,6 +3434,65 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+static int files_fsck_refs_content(struct ref_store *ref_store,
+				   struct fsck_options *o,
+				   const char *refs_check_dir,
+				   struct dir_iterator *iter)
+{
+	struct strbuf ref_content = STRBUF_INIT;
+	struct strbuf referent = STRBUF_INIT;
+	struct strbuf refname = STRBUF_INIT;
+	struct fsck_ref_report report = {0};
+	const char *trailing = NULL;
+	unsigned int type = 0;
+	int failure_errno = 0;
+	struct object_id oid;
+	int ret = 0;
+
+	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
+	report.path = refname.buf;
+
+	if (S_ISREG(iter->st.st_mode)) {
+		if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
+			ret = error_errno(_("%s/%s: unable to read the ref"),
+					  refs_check_dir, iter->relative_path);
+			goto cleanup;
+		}
+
+		if (parse_loose_ref_contents(ref_store->repo->hash_algo,
+					     ref_content.buf, &oid, &referent,
+					     &type, &trailing, &failure_errno)) {
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_BAD_REF_CONTENT,
+					      "invalid ref content");
+			goto cleanup;
+		}
+
+		if (!(type & REF_ISSYMREF)) {
+			if (*trailing == '\0') {
+				ret = fsck_report_ref(o, &report,
+						      FSCK_MSG_REF_MISSING_NEWLINE,
+						      "missing newline");
+				goto cleanup;
+			}
+
+			if (*trailing != '\n' || (*(trailing + 1) != '\0')) {
+				ret = fsck_report_ref(o, &report,
+						      FSCK_MSG_TRAILING_REF_CONTENT,
+						      "trailing garbage in ref");
+				goto cleanup;
+			}
+		}
+		goto cleanup;
+	}
+
+cleanup:
+	strbuf_release(&refname);
+	strbuf_release(&ref_content);
+	strbuf_release(&referent);
+	return ret;
+}
+
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
 				const char *refs_check_dir,
@@ -3512,6 +3575,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 {
 	files_fsck_refs_fn fsck_refs_fn[]= {
 		files_fsck_refs_name,
+		files_fsck_refs_content,
 		NULL,
 	};
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2313c830d8..73b05f971b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -715,7 +715,7 @@ struct ref_store {
 int parse_loose_ref_contents(const struct git_hash_algo *algop,
 			     const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno);
+			     const char **trailing, int *failure_errno);
 
 /*
  * Fill in the generic part of refs and add it to our collection of
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 71a4d1a5ae..7c1910d784 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -89,4 +89,91 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_must_be_empty err
 '
 
+test_expect_success 'regular ref content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	git commit --allow-empty -m initial &&
+	git checkout -b branch-1 &&
+	git tag tag-1 &&
+	git commit --allow-empty -m second &&
+	git checkout -b branch-2 &&
+	git tag tag-2 &&
+	git checkout -b a/b/tag-2 &&
+
+	printf "%s" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-1-no-newline: refMissingNewline: missing newline
+	EOF
+	rm $branch_dir_prefix/branch-1-no-newline &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-1-garbage: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $branch_dir_prefix/branch-1-garbage &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-1-garbage &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n  garbage" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-1-garbage &&
+	test_cmp expect err &&
+
+	printf "%s    garbage\n\na" "$(git rev-parse tag-2)" > $tag_dir_prefix/tag-2-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-2-garbage: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-2-garbage &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
+	test_must_fail git -c fsck.trailingRefContent=error refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-1-garbage &&
+	test_cmp expect err &&
+
+	printf "%sx" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-1-bad: badRefContent: invalid ref content
+	EOF
+	rm $tag_dir_prefix/tag-1-bad &&
+	test_cmp expect err &&
+
+	printf "xfsazqfxcadas" > $tag_dir_prefix/tag-2-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-2-bad: badRefContent: invalid ref content
+	EOF
+	rm $tag_dir_prefix/tag-2-bad &&
+	test_cmp expect err &&
+
+	printf "xfsazqfxcadas" > $branch_dir_prefix/a/b/branch-2-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/a/b/branch-2-bad: badRefContent: invalid ref content
+	EOF
+	rm $branch_dir_prefix/a/b/branch-2-bad &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.46.0

