Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10EF2AE77
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603294; cv=none; b=TfhPP82CC+KJBqydq7gVL6oG9JNQRRU4wJGiI/0Lp6fDAoktlVbzTfEqm6gLC9Pwur+g9yZXqHXP/po7faSVZBYEl9OOwAAnCWnTrwX1j7hUEFOFyFwRv55Hx8BzjRUvNswmvgdEpu87d5A8KeoQqNdz3aSSYLClG2zs/q84ZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603294; c=relaxed/simple;
	bh=JLq2Y3OBs0WZNcgMwgxzr29NojqSbZpGEf011cXBD7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnkL0uk/o9Vs/kXZ5LIrIJrGdTyJX3+N0JgB/KxvIFA73Zup2OOI/w8SG0sn8FEuFQZdtE1FkUM3yoB2mnqZpfx5kVi0zMEmFpHzHmwqTFRfJ8tggYCv7z0YNjflWREvitnqEWLo9/rZTjLNiTMY8/0Xc4gjSNO4fouYD/u5wzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Byh/rJ+G; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byh/rJ+G"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso776824a91.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731603292; x=1732208092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaujNNIFynb0YO+A+DH6JkVyJyGzo0pXrn+Uc6d5Yqs=;
        b=Byh/rJ+GRG8hmMA1319FpaxMXFcrfMPQMsjnKItV/vxVx5OW3aV6hma39uBhXrukUn
         sucmWXUCp8ELGp0BzeSfoU9pQD7DTU4zXGdoUpByK+r0OmRVJ0evPcJmDOqBCoN0ilRq
         WaZZkolYss5TbUSusHgZXsW3md+iiGPJRz5GWIbLJpdh6tOGrKOEt0gAEVsMtMKFI9Ub
         TsKrV8Mncs9IvKrVc5KzXrS2wqHYbNg3XEJXZNyCaBf+1d9Js/TL3KReJqK0zpvXjBRn
         6obFMNhTXzjRkrS+N2EhSmdggSEFmdA5ZmfD/xutvSvPLsxR5z25f8IxicYZ1F1Vc6KJ
         RG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731603292; x=1732208092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaujNNIFynb0YO+A+DH6JkVyJyGzo0pXrn+Uc6d5Yqs=;
        b=sGfITjQf4fUb/qCxAx/aI3SNz4JMpcIYHhcoD+iwSxaqUPgARcbvvR2TtMmSacpXTP
         nGtOlQmB6DbDGzFsneu1Fhj5raOv9zkkvr4fHyxBA8lgEOgW/gZoNyCcqeHwKxkxv3sP
         bFDzmZSE0P54YCh++xdvk1qY6XTC9QzAwohA87zjTH/W/ZzahAniX9ui71SaeqgUjujY
         tQ5RKE/r/At0OLXQmVZHzsXhYSM1zhV0qgvH3ygDR6Qn/LBVk9Eo5VByXV5lzqrcect8
         OyT2EHBa9PeExkDL8xLx9iZJWxWXxakgceOskoT6rD7XAnhkZeUnWeOy3kCHbnzx2yMJ
         3tMA==
X-Gm-Message-State: AOJu0YxNHuxxjrXCCZkZkoRZHtaI9+HZPYtj2CRAAfsxBLO0Fgw0G1L5
	Xfwtzqir1iuuhJZZAQVtcG9LuGs+qU2tlMo/v7MEBpGEJqVHjsfyH2cURQ==
X-Google-Smtp-Source: AGHT+IEY5TE1QYIPUmpLEJa6u4h9t9j/9ozf4ktDpIIy/C54sxJe3TEMHgtET969Bg9tei+clw+6bQ==
X-Received: by 2002:a17:90b:1c8d:b0:2e2:cd65:de55 with SMTP id 98e67ed59e1d1-2e9b17413b9mr32407116a91.20.1731603291545;
        Thu, 14 Nov 2024 08:54:51 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f1e24ce4sm3388934a91.0.2024.11.14.08.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:54:51 -0800 (PST)
Date: Fri, 15 Nov 2024 00:54:53 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v8 8/9] ref: check whether the target of the symref is a ref
Message-ID: <ZzYrXZWGadkGzrv4@ArchLinux>
References: <ZzYqoai8X_Wdtbmt@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYqoai8X_Wdtbmt@ArchLinux>

Ideally, we want to the users use "git symbolic-ref" to create symrefs
instead of writing raw contents into the filesystem. However, "git
symbolic-ref" is strict with the refname but not strict with the
referent. For example, we can make the "referent" located at the
"$(gitdir)/logs/aaa" and manually write the content into this where we
can still successfully parse this symref by using "git rev-parse".

  $ git init repo && cd repo && git commit --allow-empty -mx
  $ git symbolic-ref refs/heads/test logs/aaa
  $ echo $(git rev-parse HEAD) > .git/logs/aaa
  $ git rev-parse test

We may need to add some restrictions for "referent" parameter when using
"git symbolic-ref" to create symrefs because ideally all the
nonpseudo-refs should be located under the "refs" directory and we may
tighten this in the future.

In order to tell the user we may tighten the above situation, create
a new fsck message "symrefTargetIsNotARef" to notify the user that this
may become an error in the future.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  9 +++++++++
 fsck.h                        |  1 +
 refs/files-backend.c          | 14 ++++++++++++--
 t/t0602-reffiles-fsck.sh      | 29 +++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index dcea05edfc..f82ebc58e8 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -183,6 +183,15 @@
 	git@vger.kernel.org mailing list if you see this error, as
 	we need to know what tools created such a file.
 
+`symrefTargetIsNotARef`::
+	(INFO) The target of a symbolic reference points neither to
+	a root reference nor to a reference starting with "refs/".
+	Although we allow create a symref pointing to the referent which
+	is outside the "ref" by using `git symbolic-ref`, we may tighten
+	the rule in the future. Report to the git@vger.kernel.org
+	mailing list if you see this error, as we need to know what tools
+	created such a file.
+
 `trailingRefContent`::
 	(INFO) A loose ref has trailing content. As valid implementations
 	of Git never created such a loose ref file, it may become an
diff --git a/fsck.h b/fsck.h
index 5227dfdef2..53a47612e6 100644
--- a/fsck.h
+++ b/fsck.h
@@ -87,6 +87,7 @@ enum fsck_msg_type {
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
 	FUNC(REF_MISSING_NEWLINE, INFO) \
+	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO) \
 	FUNC(TRAILING_REF_CONTENT, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c496006db1..edf73d6cce 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3513,6 +3513,7 @@ static int files_fsck_symref_target(struct fsck_options *o,
 				    struct fsck_ref_report *report,
 				    struct strbuf *referent)
 {
+	int is_referent_root;
 	char orig_last_byte;
 	size_t orig_len;
 	int ret = 0;
@@ -3521,8 +3522,17 @@ static int files_fsck_symref_target(struct fsck_options *o,
 	orig_last_byte = referent->buf[orig_len - 1];
 	strbuf_rtrim(referent);
 
-	if (!is_root_ref(referent->buf) &&
-	    check_refname_format(referent->buf, 0)) {
+	is_referent_root = is_root_ref(referent->buf);
+	if (!is_referent_root &&
+	    !starts_with(referent->buf, "refs/") &&
+	    !starts_with(referent->buf, "worktrees/")) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
+				      "points to non-ref target '%s'", referent->buf);
+
+	}
+
+	if (!is_referent_root && check_refname_format(referent->buf, 0)) {
 		ret = fsck_report_ref(o, report,
 				      FSCK_MSG_BAD_REFERENT_NAME,
 				      "points to invalid refname '%s'", referent->buf);
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index ee1e5f2864..692b30727a 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -366,6 +366,35 @@ test_expect_success 'textual symref content should be checked (aggregate)' '
 	test_cmp expect sorted_err
 '
 
+test_expect_success 'the target of the textual symref should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	for good_referent in "refs/heads/branch" "HEAD" "refs/tags/tag"
+	do
+		printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
+		git refs verify 2>err &&
+		rm $branch_dir_prefix/branch-good &&
+		test_must_be_empty err || return 1
+	done &&
+
+	for nonref_referent in "refs-back/heads/branch" "refs-back/tags/tag" "reflogs/refs/heads/branch"
+	do
+		printf "ref: %s\n" $nonref_referent >$branch_dir_prefix/branch-bad-1 &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-bad-1: symrefTargetIsNotARef: points to non-ref target '\''$nonref_referent'\''
+		EOF
+		rm $branch_dir_prefix/branch-bad-1 &&
+		test_cmp expect err || return 1
+	done
+'
+
 test_expect_success 'ref content checks should work with worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.47.0

