Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A818C014
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603285; cv=none; b=dakS+ChnxpLvw/RZdx8mBi+tCrHgv3cKTBdEcE2xiiD7KQxZ9NvGURgstJi94yr3XGFfgfIbvUcFTCpNFXBUvI2gRAbegOPB9dyrkAlO0lGHxPLuyJSBlw/WVGXZ8bgVVrvvos8MlJnMrN9EzbermTDQ3glcaUGj7CdQ3W6nga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603285; c=relaxed/simple;
	bh=KP7zLmvL4WCb0FwFHXnLksrHy46xrQU50fd8UpICRKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vy917vLEJ/4ldtXkrMEvKomoG+17kmMx28LuozKuPeWC45q3aMecI7UvO8eWsiscHP8Vi4pxplten2kYS5WCPmjeUJNFmMPSs8jOxjBOYH7bKgOb/YvcDsQVJfIK6MFwpqskaEdLf2V2/0InPLKycV/IrtYP9lWHaU9OQeI15ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNqE/owp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNqE/owp"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-211a4682fcaso6642015ad.2
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731603282; x=1732208082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEzocaeG9RkX415G8X6vWBCudzN4Zft684u9n/co4Gc=;
        b=KNqE/owplC5EZRzCeLJw4YB9Q6VPl2NPOk4b1s3KvJjpOUvNb41Dfi+Xu10sjCtlYs
         IuX9oNioZ3lGS+1A4f8KGVyga51vZqa4LrZv62Yj2g5PQ9s4OpK/EzWsipx8QnPmIF8X
         Kiw6s7visJ0Bam/roauJ5tuo2RcX/ylFMAsXN/VGN5Q1mpnU5d3CnnvmvqKjjJeAZbrl
         qixbBMRosS6g0ay4QZ/lgd+EdDjzOqSbBOvgkXjnaQGltxSabq1RpvN0oOH+6laTCbUb
         gqEj2dbnwlT2yVMdd0u5OVl4fnmGVEHGGknQ73INHq2hv6jFjFCghO35X0EJuQ3btyio
         mlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731603282; x=1732208082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEzocaeG9RkX415G8X6vWBCudzN4Zft684u9n/co4Gc=;
        b=XWYPK1aFA0pyPrJ8CcTwlKl0Uk1yP1Iti8541tJ/+wtJ7yu5blAEvKLOZbDKNo/wSX
         uBytYW4e0LsF1W2Y3FOPXwnADEFEeK96nBWOOzOLUokwnrhXHHeuTPpfi3IBRLxaSTtk
         /JPzMbOwN3WEx9uzd+xYDCn5S3sIKVbJ5xHOhMIwpJc10XesZgyydVYKHBTWcoA/XDIV
         LGQyUpZXgdH2fipIo5Rn/hufjV/cth/lckStusyhzaGpNIDU+5WW4qaCDAHqva8a2Pr1
         nCi1fzLXgFx/qL9SRZgODvft45936Zb0G85uMlm5pmQcsglojOmvqM6U0jEMnoofb6BF
         N/Vg==
X-Gm-Message-State: AOJu0YyJLeXDBgvCno11IZq5BQEqY0JlchhHr+WHOwQzVJ5gswusdPAI
	ghIWrOMSmfIOUQFptNXdxvQQDrf1CYt6+Mnbh1P9m5lOgtl0OJgCo+Y0Sg==
X-Google-Smtp-Source: AGHT+IEH4fZEnEBC+ft1pnnyog+1G0NMXJPojgjjBqgQ7kN4YddATs9bH0sDu6BCo0s+5dfO8jqtwA==
X-Received: by 2002:a17:903:41c4:b0:20b:b39d:9735 with SMTP id d9443c01a7336-211835cf279mr325678255ad.54.1731603282008;
        Thu, 14 Nov 2024 08:54:42 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c52711sm12862825ad.103.2024.11.14.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:54:41 -0800 (PST)
Date: Fri, 15 Nov 2024 00:54:44 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v8 7/9] ref: add basic symref content check for files backend
Message-ID: <ZzYrVO-a5vQS9CGv@ArchLinux>
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
index a325b102b8..c496006db1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3509,6 +3509,43 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *refname,
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
@@ -3564,6 +3601,9 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 					      "has trailing garbage: '%s'", trailing);
 			goto cleanup;
 		}
+	} else {
+		ret = files_fsck_symref_target(o, &report, &referent);
+		goto cleanup;
 	}
 
 cleanup:
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 33e7a390ad..ee1e5f2864 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -263,6 +263,109 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	test_cmp expect sorted_err
 '
 
+test_expect_success 'textual symref content should be checked (individual)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	for good_referent in "refs/heads/branch" "HEAD"
+	do
+		printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
+		git refs verify 2>err &&
+		rm $branch_dir_prefix/branch-good &&
+		test_must_be_empty err || return 1
+	done &&
+
+	for bad_referent in "refs/heads/.branch" "refs/heads/~branch" "refs/heads/?branch"
+	do
+		printf "ref: %s\n" $bad_referent >$branch_dir_prefix/branch-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-bad: badReferentName: points to invalid refname '\''$bad_referent'\''
+		EOF
+		rm $branch_dir_prefix/branch-bad &&
+		test_cmp expect err || return 1
+	done &&
+
+	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
+	EOF
+	rm $branch_dir_prefix/branch-no-newline &&
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
@@ -313,6 +416,14 @@ test_expect_success 'ref content checks should work with worktrees' '
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

