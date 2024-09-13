Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8891EEE0
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247815; cv=none; b=Kr9tfFw+XfyUagwflEgUJORKRq/DTofHVWvv6PxnGtmzEdygyBopqgU047k3c20Imk2lEW4Ov2KdL6X/My1ZEhba9sm/uGBa0dt42WDoltSNX4j4AmCzbVjXJGLORGnqwLPReH8IRs951oSBi1mgLZs06meJ8tRYoW6UdHn2bIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247815; c=relaxed/simple;
	bh=E9jY84sbocNDJchM+TlVsU9d3CaNQafrcMnFzAvnN6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKFIzwVoMC0GbY+frFwjKqKSo6IjQ5qw7l3FSFZlMhIaga1leni2fObYbMDLo91hj+BgcqGPq2MqByjkQ+ojS4+diT9Evr5RX5tf7FfgKh7yePNccwoagfWfYfn/eAV2l1o4xnV7M/SKMPg/wl/1iKchAzCa6tZq7XdxZR9jhMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQy16weX; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQy16weX"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d3872e542so8569615ab.2
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726247812; x=1726852612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qeNtttAKEFqx3YaDUdcBobQcT7FZtYK6d0vlfRb1qQ8=;
        b=RQy16weX05Lq+NVEkZYsYLV0BpSC8hmm+dcbyoGd6zM6VU30MOgiUc1osmxlcabzyt
         nl1iQWT/TidgOgCGg1Eaz5WbrguceG22XXCptQ6N35iPBNexjkLX5LbaeiGGsQ99UCjU
         g6Zy3z1lZM0KAGKj9BJ+A/9WoF/C0sFN11Hh/UzvwBjXC+i+BjG9DwmBdbQji0Ph308F
         vmoWWhJzuHWfYo92zkPRrbKz4/KBt319RhGpyRJQc1zepzddPy0+dC2rr4+gSa9TEzoM
         2zPdORZax1bQcI4T8EEQH9NImm/KtljsnCTi4etvJ0Pty4rd57JqAnfEjICejORsFcBd
         dFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726247812; x=1726852612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeNtttAKEFqx3YaDUdcBobQcT7FZtYK6d0vlfRb1qQ8=;
        b=RuW7ofMYJqh5jjfdg0NMHjD+gpoCHTVVrJnao7u3mTX1JmWeveW0NWfIyFIJMlTalv
         q5HEkk+uYXwgIr4UIs/GpzpTGaQqPAFCubPSFqasDJS1ljfDKXeWydnaZR32uoYyMArS
         2VrMG4Qca9aSL/qs+KlK+u3Med0nm/7ZSIRdJyFh/SPD3psFJ4alrrIJZop1cGaAiP76
         t6rqwB32TQoSDx/u9/KfPafuj5qcfxV5V9t79k1G0LN1AoOf0VcDE6xjKAIrduPj+nKX
         kRJ0aEyVe0Q9dJvxUf++f3/H216yObqrEQliDQXrPQfvuKTmEIx9SmtwKj5q+XNoHfyw
         vUaw==
X-Gm-Message-State: AOJu0Yy/4lzBNnAGNznl/MI5cLKS+EsC/X35pe3m5RbhXsndJ4+flHOb
	r2gguEKyiMsIR/B/UTC4IrwIuGoHpWCjKlExlFBLv02dfMGPA1Sr01vnCA==
X-Google-Smtp-Source: AGHT+IGL9PSdDLKK6cFTzKmgYi5B2Ex67UbZASSbr14zbjWJV22djRxASiWSaPMrqXC/V3St9GUjwQ==
X-Received: by 2002:a05:6e02:2168:b0:39d:4ef6:b36d with SMTP id e9e14a558f8ab-3a0848c9f58mr74556535ab.7.1726247811741;
        Fri, 13 Sep 2024 10:16:51 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbc76cesm3665487a12.54.2024.09.13.10.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 10:16:51 -0700 (PDT)
Date: Sat, 14 Sep 2024 01:17:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/5] ref: add more strict checks for regular refs
Message-ID: <ZuRzxyjAI3tp4uLK@ArchLinux>
References: <ZuRzCyjQFilGhj8j@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuRzCyjQFilGhj8j@ArchLinux>

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
may break the repository. So we add the following two fsck infos to
represent the situation where the ref content ends without newline or
has trailing garbages:

1. refMissingNewline(INFO): A ref does not end with newline. This will
   be considered an error in the future.
2. trailingRefContent(INFO): A ref has trailing content. This will be
   considered an error in the future.

It might appear that we can't provide the user with any warnings by
using FSCK_INFO. However, in "fsck.c::fsck_vreport", we will convert
FSCK_INFO to FSCK_WARN and we can still warn the user about these
situations when using "git refs verify" without introducing
compatibility issues.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  8 +++++
 fsck.h                        |  2 ++
 refs.c                        |  2 +-
 refs/files-backend.c          | 27 ++++++++++++++--
 refs/refs-internal.h          |  2 +-
 t/t0602-reffiles-fsck.sh      | 60 +++++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 22c385ea22..8827137ef0 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -173,6 +173,14 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`refMissingNewline`::
+	(INFO) A ref does not end with newline. This will be
+	considered an error in the future.
+
+`trailingRefContent`::
+	(INFO) A ref has trailing content. This will be
+	considered an error in the future.
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
index b1ed2e5c04..df4ce270ae 100644
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
 
@@ -3439,6 +3443,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	struct strbuf referent = STRBUF_INIT;
 	struct strbuf refname = STRBUF_INIT;
 	struct fsck_ref_report report = {0};
+	const char *trailing = NULL;
 	unsigned int type = 0;
 	int failure_errno = 0;
 	struct object_id oid;
@@ -3458,13 +3463,29 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 
 	if (parse_loose_ref_contents(ref_store->repo->hash_algo,
 				     ref_content.buf, &oid, &referent,
-				     &type, &failure_errno)) {
+				     &type, &trailing, &failure_errno)) {
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_CONTENT,
 				      "invalid ref content");
 		goto cleanup;
 	}
 
+	if (!(type & REF_ISSYMREF)) {
+		if (!*trailing) {
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_REF_MISSING_NEWLINE,
+					      "missing newline");
+			goto cleanup;
+		}
+
+		if (*trailing != '\n' || *(trailing + 1)) {
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_TRAILING_REF_CONTENT,
+					      "trailing garbage in ref");
+			goto cleanup;
+		}
+	}
+
 cleanup:
 	strbuf_release(&refname);
 	strbuf_release(&ref_content);
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
index a1205b3a3b..a06ad044f2 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -101,6 +101,54 @@ test_expect_success 'regular ref content should be checked (individual)' '
 	git refs verify 2>err &&
 	test_must_be_empty err &&
 
+	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-no-newline: refMissingNewline: missing newline
+	EOF
+	rm $branch_dir_prefix/branch-no-newline &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-garbage: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $branch_dir_prefix/branch-garbage &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-garbage-1: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-garbage-1 &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-2 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-garbage-2: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-garbage-2 &&
+	test_cmp expect err &&
+
+	printf "%s    garbage\n\na" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-3 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-garbage-3: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-garbage-3 &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-4 &&
+	test_must_fail git -c fsck.trailingRefContent=error refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-garbage-4: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-garbage-4 &&
+	test_cmp expect err &&
+
 	printf "%sx" "$(git rev-parse main)" >$tag_dir_prefix/tag-bad-1 &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
@@ -135,6 +183,12 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	test_commit default &&
 	mkdir -p "$branch_dir_prefix/a/b" &&
 
+	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
+	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
+	printf "%s\n\n\n" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-1 &&
+	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-2 &&
+	printf "%s    garbage\n\na" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-3 &&
+	printf "%s garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-4 &&
 	printf "%sx" "$(git rev-parse main)" >$tag_dir_prefix/tag-bad-1 &&
 	printf "xfsazqfxcadas" >$tag_dir_prefix/tag-bad-2 &&
 	printf "xfsazqfxcadas" >$branch_dir_prefix/a/b/branch-bad &&
@@ -144,6 +198,12 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	error: refs/heads/a/b/branch-bad: badRefContent: invalid ref content
 	error: refs/tags/tag-bad-1: badRefContent: invalid ref content
 	error: refs/tags/tag-bad-2: badRefContent: invalid ref content
+	warning: refs/heads/branch-garbage: trailingRefContent: trailing garbage in ref
+	warning: refs/heads/branch-no-newline: refMissingNewline: missing newline
+	warning: refs/tags/tag-garbage-1: trailingRefContent: trailing garbage in ref
+	warning: refs/tags/tag-garbage-2: trailingRefContent: trailing garbage in ref
+	warning: refs/tags/tag-garbage-3: trailingRefContent: trailing garbage in ref
+	warning: refs/tags/tag-garbage-4: trailingRefContent: trailing garbage in ref
 	EOF
 	sort err >sorted_err &&
 	test_cmp expect sorted_err
-- 
2.46.0

