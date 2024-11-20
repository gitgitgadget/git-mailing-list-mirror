Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD351AB521
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103504; cv=none; b=drlyQxl0Oj9czrFq5kPFgvGWNeZrBIKb0iMMcvHG8+SHTx3acuVkEpNOQGVvVD67fw+6xhZLqAx+EMuWs5wJVK191IeQhWDm0kVrW0HuogOk7LTJqRvKNDyVDq/4/RFYymfAs6UhIDsYWyraEchBdi8ZdSMl84ZBssUh9q75fGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103504; c=relaxed/simple;
	bh=VXTNCjMxU7IGFnOUdKV1X6Jyr1LU3pXvCgj4Tar9PsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWBM/ERpiPFR7QhyRVmTGzPsOwmZE1mKH4S3k16ESuf1cf81KBy1FSTStwPXKk3m8gF1NSg8/7jHcm8ev2foBo7vxGzHDe0NhHEWwS6kBsSZKYDMbQjhkb6JaY4DG065fNNtWd08KNl9raYsoWopQ5trF1MR2VZFnLhCU/px0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4TTtYwm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4TTtYwm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-211fcadd960so31314645ad.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 03:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103501; x=1732708301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pLLMOHnIlwhlDAu2xCp95eCTzbt38epAoYjaE0zY0yo=;
        b=L4TTtYwmcmJPkzBVbQ30+fSzA8FBx8rbQqXBmtF01+rimMddwK4UGAGy3/cbMpTRLL
         NJEoZ/P955o5h+bJsgV+PKmuUJBsNIr54J4QjLVho5ctdf+qGWY2JAwBQZ3+JDvf+x/i
         EOq2VIc5pBXmXfW6055WCHecqvjKmrX2O/7cO0TcWopXo62cVlfzDvy59cBZyERXgukY
         IaBrlnW0wrgK8Z4bGdbF+zDCSdn9HnGJ4W66QeEGNKxnxzKL+jFdl5dAMpPMwy2izwjV
         QE56JRwt85c4OcSt3SsCSni9YTrGLf68NW+6z3+z185vCDzEif4QCQj0poajQBUbRQ6z
         u+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103501; x=1732708301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLLMOHnIlwhlDAu2xCp95eCTzbt38epAoYjaE0zY0yo=;
        b=UKoG6tSYWqLmslYMLoTbRwOgeyzsxv4Z7Gac+blRISx4ymqc337ma4syVgCctdK3Ev
         tI0wnrrNmU/wVm4iE5Vmwzn4tuj6fpcdJxrtO3fG1qHrX7VQEKsVOZd4jj9FlXeN4I8t
         FTO6qWtEtISaNvwNNS5DeZuIkkpNN0/WBw2g/RjsgX5YxtC4qmYBJYALHKrPZaIGQZCz
         T04GqRqjQR/3s2qpysaSBw/O1kPDaoNFbW6Yezlsb1J4me9mvVxuyFMG5ssSsBOWmKcD
         ttYEPyenqcloxjntwJuEapGs+Ij6F6sjN2Ils6W6cptkxPi7n21kzzt5qzhzsOB6fEHJ
         +Tnw==
X-Gm-Message-State: AOJu0YwVJxVqN+pz0dKY1aQ2Cl6WdnceCnPn/srselZhhuPyrFqiF5pO
	gkgleXKi4SnkGjbu9PwObDSBP7MzGAwbBpOIYc7IFd3G69R/lhssMtLknw==
X-Google-Smtp-Source: AGHT+IGLAueBmaecIl7OyrqN+kPPPVakEkjU1eYgZHBTEDJbAT+r5CNpY+Z1qBsSX19Wsp2Wx6Y4cQ==
X-Received: by 2002:a17:902:da8b:b0:211:e9c0:31ca with SMTP id d9443c01a7336-2126c965d15mr32072545ad.36.1732103501469;
        Wed, 20 Nov 2024 03:51:41 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e9d0c389sm76904665ad.161.2024.11.20.03.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:51:40 -0800 (PST)
Date: Wed, 20 Nov 2024 19:51:49 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v9 6/9] ref: add more strict checks for regular refs
Message-ID: <Zz3NVRoP4JTQxTve@ArchLinux>
References: <Zz3MON9_9DGD6nsy@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz3MON9_9DGD6nsy@ArchLinux>

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
 Documentation/fsck-msgids.txt | 14 +++++++++
 fsck.h                        |  2 ++
 refs.c                        |  2 +-
 refs/files-backend.c          | 26 ++++++++++++++--
 refs/refs-internal.h          |  2 +-
 t/t0602-reffiles-fsck.sh      | 57 +++++++++++++++++++++++++++++++++--
 6 files changed, 96 insertions(+), 7 deletions(-)

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
index 9f300a7d3c..3d4d612420 100644
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
@@ -3537,7 +3542,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 
 	if (parse_loose_ref_contents(ref_store->repo->hash_algo,
 				     ref_content.buf, &oid, &referent,
-				     &type, &failure_errno)) {
+				     &type, &trailing, &failure_errno)) {
 		strbuf_rtrim(&ref_content);
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_CONTENT,
@@ -3545,6 +3550,21 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
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
index 162370077b..33e7a390ad 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -189,7 +189,48 @@ test_expect_success 'regular ref content should be checked (individual)' '
 		EOF
 		rm $branch_dir_prefix/a/b/branch-bad &&
 		test_cmp expect err || return 1
-	done
+	done &&
+
+	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
+	EOF
+	rm $branch_dir_prefix/branch-no-newline &&
+	test_cmp expect err &&
+
+	for trailing_content in " garbage" "    more garbage"
+	do
+		printf "%s" "$(git rev-parse main)$trailing_content" >$branch_dir_prefix/branch-garbage &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
+		EOF
+		rm $branch_dir_prefix/branch-garbage &&
+		test_cmp expect err || return 1
+	done &&
+
+	printf "%s\n\n\n" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
+
+
+	'\''
+	EOF
+	rm $branch_dir_prefix/branch-garbage-special &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
+
+
+	  garbage'\''
+	EOF
+	rm $branch_dir_prefix/branch-garbage-special &&
+	test_cmp expect err
 '
 
 test_expect_success 'regular ref content should be checked (aggregate)' '
@@ -207,12 +248,16 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
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
@@ -260,7 +305,15 @@ test_expect_success 'ref content checks should work with worktrees' '
 		EOF
 		rm $worktree2_refdir_prefix/bad-branch-2 &&
 		test_cmp expect err || return 1
-	done
+	done &&
+
+	printf "%s" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: worktrees/worktree-1/refs/worktree/branch-no-newline: refMissingNewline: misses LF at the end
+	EOF
+	rm $worktree1_refdir_prefix/branch-no-newline &&
+	test_cmp expect err
 '
 
 test_done
-- 
2.47.0

