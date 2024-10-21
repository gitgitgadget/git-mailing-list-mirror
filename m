Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24A1EF94D
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517703; cv=none; b=NyL/FA+Cbf+hJ+KcBXf75hyaMfmHaRaFa0csQGFjUIJCq4pssCzlhmq5BeRmWIB9KqBPWfWVhRVRVlkuA9xcavIvLKZ+jYbpIg5cNP82ory0KqBNg7t/YjoK+EV3+cE27EfQmB8LDRrQb6RBKjK/Sx3zjsdEvvMTED6KIm09rR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517703; c=relaxed/simple;
	bh=QfuNUTRrs2Gx5SkVlvy0Ldy5NTJ6EMqkydhLbZ8cHAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzdLvdo1wvVvvdGm+ZJIVcnRdtfPLxmwnBrXHkycZWYVdaRPYrqIGZ8sTcHVM5srZ5uCDsL9wl092BbMmqwLk0vxhhW/MKNMv3mt5pXrVNf0bcKQaN2nFBBfxgacZvd1Tp32qes6HOL2Pg3xPhvYmN6sFwaz3KSntv8JphLg0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgSgAEx9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgSgAEx9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso3819438b3a.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517700; x=1730122500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tT/lz67lU/kANzw4Uj/P1Cw9w9C2nNdBC8V4J4bhMQ=;
        b=RgSgAEx9bqqxv5gAAEuJXd/LwkdidJ/KV5Kt6lg0Bm5L9Y8xjPjbcNGuZjbxTf0CKK
         t9Y+b8jV1TiMtfOypny0ykPD/81l1oAZ4JYCRpP4arp1d6Gs9T6UMn1gt0FEZTFV9954
         8F8Sk2X1v8IPut5tnFSF7J8eC5Uov176iMoCH5+wCb7TWLELhfMoDG+muXcsjJED62RA
         5rzkP3qi2q8ME+hDUMdKcIDceMrtDQWGh9PNuMWjEWqe1s8UKIZ8dEWmkklOOZVk1zaU
         Yu0U6W+pEAjTqG9merkiperYHTLcCigJeetFhgB+ge7KBz+svH29bsG8i3LVy/IgxABQ
         yx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517700; x=1730122500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tT/lz67lU/kANzw4Uj/P1Cw9w9C2nNdBC8V4J4bhMQ=;
        b=Gcn/gfPEPoHmLEIOBd5CBvUMCurdUNg2P1WUAgXjwpL6CQ07zF1nDGXONBhKvIRRL+
         b1af2CIeEQ0i204u4VZ0F3P7ChAvvRyROC5eCE5pVRFVGFp3xYkmVSnawhUHm7l+P+rk
         IiWmXuT3+Aw5pQNFLMwo9QwVNYRo6RpdgPZ1xYEWruM12suXQwPxQwMvG9I0LPN0WuHz
         ucD1BYhJZAeNzhK+EdQ4EnKF+e6E23tDtfYgvySNjKbFP+faLUInhDnBLIn2Jre6WVPQ
         nSNhz+IrgfXKA1DZmYtp8szldvrs/IgK+xg7HNJnVwut6CoaaJOc4BayugRVQXZX8Dph
         zDBQ==
X-Gm-Message-State: AOJu0YxeQCA6tF4Rx2Vjk+vMCwLLS/guhHcF0drbuR5pxS05QNLE/6r3
	lPrqT/zFIOlj7SKkvuvoNsHi8+wZ4VQL8U8pf+3QI+yYB5/ORBA6hXfZb5Or
X-Google-Smtp-Source: AGHT+IGL1383zQf5dofiRGJ/g+O8rMYtk58I7cp69R890OJfWFR7ivRSMO2b+50Pl+t/v5qW4bEiiw==
X-Received: by 2002:a05:6a00:180f:b0:71e:6fcb:7693 with SMTP id d2e1a72fcca58-71ea4297ce7mr15114319b3a.12.1729517700021;
        Mon, 21 Oct 2024 06:35:00 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13eb2c0sm2935162b3a.142.2024.10.21.06.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:34:59 -0700 (PDT)
Date: Mon, 21 Oct 2024 21:35:03 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 7/9] ref: add basic symref content check for files backend
Message-ID: <ZxZYh1D3rLGrDZjN@ArchLinux>
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

We have code that checks regular ref contents, but we do not yet check
the contents of symbolic refs. By using "parse_loose_ref_content" for
symbolic refs, we will get the information of the "referent".

We do not need to check the "referent" by opening the file. This is
because if "referent" exists in the file system, we will eventually
check its correctness by inspecting every file in the "refs" directory.
If the "referent" does not exist in the filesystem, this is OK as it is
seen as the dangling symref.

So we just need to check the "referent" string content. A regular ref
could be accepted as a textual symref if it begins with "ref:", followed
by zero or more whitespaces, followed by the full refname, followed only
by whitespace characters. However, we always write a single SP after
"ref:" and a single LF after the refname. It may seem that we should
report a fsck error message when the "referent" does not apply above
rules and we should not be so aggressive because third-party
reimplementations of Git may have taken advantage of the looser syntax.
Put it more specific, we accept the following contents:

1. "ref: refs/heads/master   "
2. "ref: refs/heads/master   \n  \n"
3. "ref: refs/heads/master\n\n"

When introducing the regular ref content checks, we created two fsck
infos "refMissingNewline" and "trailingRefContent" which exactly
represents above situations. So we will reuse these two fsck messages to
write checks to info the user about these situations.

But we do not allow any other trailing garbage. The followings are bad
symref contents which will be reported as fsck error by "git-fsck(1)".

1. "ref: refs/heads/master garbage\n"
2. "ref: refs/heads/master \n\n\n garbage  "

And we introduce a new "badReferentName(ERROR)" fsck message to report
above errors by using "is_root_ref" and "check_refname_format" to check
the "referent". Since both "is_root_ref" and "check_refname_format"
don't work with whitespaces, we use the trimmed version of "referent"
with these functions.

In order to add checks, we will do the following things:

1. Record the untrimmed length "orig_len" and untrimmed last byte
   "orig_last_byte".
2. Use "strbuf_rtrim" to trim the whitespaces or newlines to make sure
   "is_root_ref" and "check_refname_format" won't be failed by them.
3. Use "orig_len" and "orig_last_byte" to check whether the "referent"
   misses '\n' at the end or it has trailing whitespaces or newlines.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   3 +
 fsck.h                        |   1 +
 refs/files-backend.c          |  40 ++++++++++++
 t/t0602-reffiles-fsck.sh      | 111 ++++++++++++++++++++++++++++++++++
 4 files changed, 155 insertions(+)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 6db0eaa84a..dcea05edfc 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -28,6 +28,9 @@
 `badRefName`::
 	(ERROR) A ref has an invalid format.
 
+`badReferentName`::
+	(ERROR) The referent name of a symref is invalid.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index b85072df57..5227dfdef2 100644
--- a/fsck.h
+++ b/fsck.h
@@ -34,6 +34,7 @@ enum fsck_msg_type {
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
+	FUNC(BAD_REFERENT_NAME, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b1fba92e5f..1a267547f2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3509,6 +3509,43 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *target_name,
 				  struct dir_iterator *iter);
 
+static int files_fsck_symref_target(struct fsck_options *o,
+				    struct fsck_ref_report *report,
+				    struct strbuf *referent)
+{
+	char orig_last_byte;
+	size_t orig_len;
+	int ret = 0;
+
+	orig_len = referent->len;
+	orig_last_byte = referent->buf[orig_len - 1];
+	strbuf_rtrim(referent);
+
+	if (!is_root_ref(referent->buf) &&
+	    check_refname_format(referent->buf, 0)) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_BAD_REFERENT_NAME,
+				      "points to invalid refname '%s'", referent->buf);
+		goto out;
+	}
+
+	if (referent->len == orig_len ||
+	    (referent->len < orig_len && orig_last_byte != '\n')) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_REF_MISSING_NEWLINE,
+				      "misses LF at the end");
+	}
+
+	if (referent->len != orig_len && referent->len != orig_len - 1) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_TRAILING_REF_CONTENT,
+				      "has trailing whitespaces or newlines");
+	}
+
+out:
+	return ret;
+}
+
 static int files_fsck_refs_content(struct ref_store *ref_store,
 				   struct fsck_options *o,
 				   const char *target_name,
@@ -3559,6 +3596,9 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 					      "has trailing garbage: '%s'", trailing);
 			goto cleanup;
 		}
+	} else {
+		ret = files_fsck_symref_target(o, &report, &referent);
+		goto cleanup;
 	}
 
 cleanup:
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 0418d79c4f..f475966d7b 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -289,6 +289,109 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	test_cmp expect sorted_err
 '
 
+test_expect_success 'textual symref content should be checked (individual)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
+	git refs verify 2>err &&
+	rm $branch_dir_prefix/branch-good &&
+	test_must_be_empty err &&
+
+	printf "ref: HEAD\n" >$branch_dir_prefix/branch-head &&
+	git refs verify 2>err &&
+	rm $branch_dir_prefix/branch-head &&
+	test_must_be_empty err &&
+
+	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-no-newline-1: refMissingNewline: misses LF at the end
+	EOF
+	rm $branch_dir_prefix/branch-no-newline-1 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: misses LF at the end
+	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: has trailing whitespaces or newlines
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing-1 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: has trailing whitespaces or newlines
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing-2 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: has trailing whitespaces or newlines
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing-3 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-complicated: refMissingNewline: misses LF at the end
+	warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
+	EOF
+	rm $branch_dir_prefix/a/b/branch-complicated &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-bad-1: badReferentName: points to invalid refname '\''refs/heads/.branch'\''
+	EOF
+	rm $branch_dir_prefix/branch-bad-1 &&
+	test_cmp expect err
+'
+
+test_expect_success 'textual symref content should be checked (aggregate)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
+	printf "ref: HEAD\n" >$branch_dir_prefix/branch-head &&
+	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
+	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
+	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
+	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
+	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
+	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
+
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-bad-1: badReferentName: points to invalid refname '\''refs/heads/.branch'\''
+	warning: refs/heads/a/b/branch-complicated: refMissingNewline: misses LF at the end
+	warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: misses LF at the end
+	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: has trailing whitespaces or newlines
+	warning: refs/heads/branch-no-newline-1: refMissingNewline: misses LF at the end
+	EOF
+	sort err >sorted_err &&
+	test_cmp expect sorted_err
+'
+
 test_expect_success 'ref content checks should work with worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -345,6 +448,14 @@ test_expect_success 'ref content checks should work with worktrees' '
 	warning: worktrees/worktree-1/refs/worktree/branch-no-newline: refMissingNewline: misses LF at the end
 	EOF
 	rm $worktree1_refdir_prefix/branch-no-newline &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: worktrees/worktree-1/refs/worktree/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
+	EOF
+	rm $worktree1_refdir_prefix/branch-garbage &&
 	test_cmp expect err
 '
 
-- 
2.47.0

