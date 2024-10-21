Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D21EF94D
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517696; cv=none; b=OPdp7AR7v4tfWmh7s7rUg2enAsYaOmdhQtFdyDnlOzhYpaeN/5n4Od5dIxpCo4gTEQ5/3Cw16HWHvpKnwiSruWaJk+wmVzzIiSidCVepRPBr9oWD2OU9vIoaSoW482WNjYwUw9w8RH033SFZ1fx6KrLEvlehXUqHu/a3FdkN6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517696; c=relaxed/simple;
	bh=bRHjAi8ugNjBRHYo8qv0a1+pH8OtcCSLKLA/ovD4mzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIttXYtpYBj14FmCPY1CXj3bFZNmkuMDXgD61Dh6iYWiGEiI3m7Zs+5GRo00JIyKLqyCUl2VzvKr24f0jE0kYUl0KsxN7zJTPFJd0Cvy2DpwS18HWueYJ2JA2kKFBXs0Qxl4osoQZPbqsXIdOwS0FyTLyhCs1eJrBue7eQfKx+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAvQwMZ5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAvQwMZ5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cb7139d9dso39916735ad.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517693; x=1730122493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=675DPDPoM4nQq+UGQICE+895pF3EK7hKdTsEyM4S+Vg=;
        b=jAvQwMZ53R+rVw9m23+iHktTIyj3IcIEFYeotICsx4duMwzZDEm0aZpJ9zzgylTCa+
         gpc+4uvw3yx19HgGAFeP8xFH7eL5BUI3MAkDIwMFG4I9w8ldbsm3/6KWIsxvtRIuMry3
         VodvlIqbW4+TCyVXiuKe/rk122bix5+3eAWKc1EyfDsmtIj8A4FUApjLE6HSZHT0M/tA
         ZEB7tQoMsZlqQ6jo1JC9SrlvrUpIEgJbNndlmEYcA1VwtUOuyj93mpbygGtTJvPSTm01
         xaj2e1xlJYFSjqsg2ftlO0nDLvk1C+XsgMEX2LP2nWtLBIYMLj5FUpaXHB26nZYCCPHX
         RByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517693; x=1730122493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=675DPDPoM4nQq+UGQICE+895pF3EK7hKdTsEyM4S+Vg=;
        b=wM65gWWC1e6XMV+cnyrNtcgz20b+K4gK2ALBH6hNLnjHfV41xMCrgs0m3U673RH6Af
         r9CvzAXj99eDtJA4qwZt574RuyFN1AHg/HgxrgNzwvx9G24j4/gXCZmFXhQm7AT51gSG
         f0Hy5Gw9uJLroMjjOhlSN5qf6pnY+VS1+8jmCSuy8ev2U+wwg9rQE4ja+OwXObEItsSQ
         kZFeDn4Ojk+ivFMNxxHMvkz1begdEDoFiBamDnDdKH6HGlg5hepSnFsa6wQ6zKq3uHMu
         qHtKTX/aVyOdZnOHMJ0RuXqnw6K3nVmMEhLuUq6T2y5uyeHi++uOhU1fUHabH7ti7kyc
         5tsQ==
X-Gm-Message-State: AOJu0Yx0S0Ilx396jb5mc3eyAwnUeN8Gm8Wp57Zo1VmeFwfuz2NK7vcI
	UdRaqOiBCX9E0jhvdoQwIxywg7vH7NrwfVWWCTe88Imju4mSoSblflbPTvBQ
X-Google-Smtp-Source: AGHT+IG3y0Z57j05JKo/m8fhx0GowbjmGe4bxakfuUfEjuLnOe7Pr4KiWgDCRG2qRp4wCjLlzlVvZw==
X-Received: by 2002:a17:903:184:b0:20c:7181:51c7 with SMTP id d9443c01a7336-20e5a923bdfmr156756465ad.52.1729517692584;
        Mon, 21 Oct 2024 06:34:52 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef08d1dsm25769515ad.89.2024.10.21.06.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:34:52 -0700 (PDT)
Date: Mon, 21 Oct 2024 21:34:55 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 6/9] ref: add more strict checks for regular refs
Message-ID: <ZxZYf-_M4GvzrFpO@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZX5HDdq_R0C77b@ArchLinux>

We have already used "parse_loose_ref_contents" function to check
whether the ref content is valid in files backend. However, by
using "parse_loose_ref_contents", we allow the ref's content to end with
garbage or without a newline.

Even though we never create such loose refs ourselves, we have accepted
such loose refs. So, it is entirely possible that some third-party tools
may rely on such loose refs being valid. We should not report an error
fsck message at current. We should notify the users about such
"curiously formatted" loose refs so that adequate care is taken before
we decide to tighten the rules in the future.

And it's not suitable either to report a warn fsck message to the user.
We don't yet want the "--strict" flag that controls this bit to end up
generating errors for such weirdly-formatted reference contents, as we
first want to assess whether this retroactive tightening will cause
issues for any tools out there. It may cause compatibility issues which
may break the repository. So, we add the following two fsck infos to
represent the situation where the ref content ends without newline or
has trailing garbages:

1. refMissingNewline(INFO): A loose ref that does not end with
   newline(LF).
2. trailingRefContent(INFO): A loose ref has trailing content.

It might appear that we can't provide the user with any warnings by
using FSCK_INFO. However, in "fsck.c::fsck_vreport", we will convert
FSCK_INFO to FSCK_WARN and we can still warn the user about these
situations when using "git refs verify" without introducing
compatibility issues.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt | 14 ++++++++
 fsck.h                        |  2 ++
 refs.c                        |  2 +-
 refs/files-backend.c          | 26 ++++++++++++--
 refs/refs-internal.h          |  2 +-
 t/t0602-reffiles-fsck.sh      | 67 +++++++++++++++++++++++++++++++++++
 6 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 22c385ea22..6db0eaa84a 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -173,6 +173,20 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`refMissingNewline`::
+	(INFO) A loose ref that does not end with newline(LF). As
+	valid implementations of Git never created such a loose ref
+	file, it may become an error in the future. Report to the
+	git@vger.kernel.org mailing list if you see this error, as
+	we need to know what tools created such a file.
+
+`trailingRefContent`::
+	(INFO) A loose ref has trailing content. As valid implementations
+	of Git never created such a loose ref file, it may become an
+	error in the future. Report to the git@vger.kernel.org mailing
+	list if you see this error, as we need to know what tools
+	created such a file.
+
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
diff --git a/fsck.h b/fsck.h
index 0d99a87911..b85072df57 100644
--- a/fsck.h
+++ b/fsck.h
@@ -85,6 +85,8 @@ enum fsck_msg_type {
 	FUNC(MAILMAP_SYMLINK, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
+	FUNC(REF_MISSING_NEWLINE, INFO) \
+	FUNC(TRAILING_REF_CONTENT, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
 
diff --git a/refs.c b/refs.c
index 395a17273c..f88b32a633 100644
--- a/refs.c
+++ b/refs.c
@@ -1789,7 +1789,7 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	}
 
 	result = parse_loose_ref_contents(ref_store->repo->hash_algo, content.buf,
-					  oid, referent, type, failure_errno);
+					  oid, referent, type, NULL, failure_errno);
 
 done:
 	strbuf_release(&full_path);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2861980bdd..b1fba92e5f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -569,7 +569,7 @@ static int read_ref_internal(struct ref_store *ref_store, const char *refname,
 	buf = sb_contents.buf;
 
 	ret = parse_loose_ref_contents(ref_store->repo->hash_algo, buf,
-				       oid, referent, type, &myerr);
+				       oid, referent, type, NULL, &myerr);
 
 out:
 	if (ret && !myerr)
@@ -606,7 +606,7 @@ static int files_read_symbolic_ref(struct ref_store *ref_store, const char *refn
 int parse_loose_ref_contents(const struct git_hash_algo *algop,
 			     const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno)
+			     const char **trailing, int *failure_errno)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -628,6 +628,10 @@ int parse_loose_ref_contents(const struct git_hash_algo *algop,
 		*failure_errno = EINVAL;
 		return -1;
 	}
+
+	if (trailing)
+		*trailing = p;
+
 	return 0;
 }
 
@@ -3513,6 +3517,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	struct strbuf ref_content = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct fsck_ref_report report = { 0 };
+	const char *trailing = NULL;
 	unsigned int type = 0;
 	int failure_errno = 0;
 	struct object_id oid;
@@ -3533,7 +3538,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 
 	if (parse_loose_ref_contents(ref_store->repo->hash_algo,
 				     ref_content.buf, &oid, &referent,
-				     &type, &failure_errno)) {
+				     &type, &trailing, &failure_errno)) {
 		strbuf_rtrim(&ref_content);
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_CONTENT,
@@ -3541,6 +3546,21 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
+	if (!(type & REF_ISSYMREF)) {
+		if (!*trailing) {
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_REF_MISSING_NEWLINE,
+					      "misses LF at the end");
+			goto cleanup;
+		}
+		if (*trailing != '\n' || *(trailing + 1)) {
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_TRAILING_REF_CONTENT,
+					      "has trailing garbage: '%s'", trailing);
+			goto cleanup;
+		}
+	}
+
 cleanup:
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 037d7991cd..125f1fe735 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -716,7 +716,7 @@ struct ref_store {
 int parse_loose_ref_contents(const struct git_hash_algo *algop,
 			     const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno);
+			     const char **trailing, int *failure_errno);
 
 /*
  * Fill in the generic part of refs and add it to our collection of
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 29bdd3fc01..0418d79c4f 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -201,6 +201,61 @@ test_expect_success 'regular ref content should be checked (individual)' '
 	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content
 	EOF
 	rm $branch_dir_prefix/a/b/branch-bad &&
+	test_cmp expect err &&
+
+	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
+	EOF
+	rm $branch_dir_prefix/branch-no-newline &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
+	EOF
+	rm $branch_dir_prefix/branch-garbage &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-garbage-1: trailingRefContent: has trailing garbage: '\''
+
+
+	'\''
+	EOF
+	rm $tag_dir_prefix/tag-garbage-1 &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-2 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-garbage-2: trailingRefContent: has trailing garbage: '\''
+
+
+	  garbage'\''
+	EOF
+	rm $tag_dir_prefix/tag-garbage-2 &&
+	test_cmp expect err &&
+
+	printf "%s    garbage\na" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-3 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-garbage-3: trailingRefContent: has trailing garbage: '\''    garbage
+	a'\''
+	EOF
+	rm $tag_dir_prefix/tag-garbage-3 &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-4 &&
+	test_must_fail git -c fsck.trailingRefContent=error refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-garbage-4: trailingRefContent: has trailing garbage: '\'' garbage'\''
+	EOF
+	rm $tag_dir_prefix/tag-garbage-4 &&
 	test_cmp expect err
 '
 
@@ -219,12 +274,16 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	printf "%s" $bad_content_1 >$tag_dir_prefix/tag-bad-1 &&
 	printf "%s" $bad_content_2 >$tag_dir_prefix/tag-bad-2 &&
 	printf "%s" $bad_content_3 >$branch_dir_prefix/a/b/branch-bad &&
+	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
+	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
 
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content_3
 	error: refs/tags/tag-bad-1: badRefContent: $bad_content_1
 	error: refs/tags/tag-bad-2: badRefContent: $bad_content_2
+	warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
+	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
 	EOF
 	sort err >sorted_err &&
 	test_cmp expect sorted_err
@@ -278,6 +337,14 @@ test_expect_success 'ref content checks should work with worktrees' '
 	error: worktrees/worktree-1/refs/worktree/bad-branch-3: badRefContent: $bad_content_3
 	EOF
 	rm $worktree1_refdir_prefix/bad-branch-3 &&
+	test_cmp expect err &&
+
+	printf "%s" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: worktrees/worktree-1/refs/worktree/branch-no-newline: refMissingNewline: misses LF at the end
+	EOF
+	rm $worktree1_refdir_prefix/branch-no-newline &&
 	test_cmp expect err
 '
 
-- 
2.47.0

