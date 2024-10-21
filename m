Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F51F893D
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517718; cv=none; b=WjITsbPtRR44WkPiSq82B1jGgPaMJO4B/b03xoT2/vvQ79KkndD+cxYe1LnhNYou2RLo5wPq146RZOfCy2Y15c04c9hTNrz/81qionOO6s3B/RyivbdG/pxUCpz7z/sbMrl0iHhtwMGqpU4gBxCW4vVhA7hKU527E0wVQk5R93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517718; c=relaxed/simple;
	bh=LJdMvWyOACkIxE8jNxh0L6t2P0rmY02pmnxrwSUgRpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jih+Z12p0raKpquV3lWQjvDpWDi5QAEgFUOsnV+von7nRwWdqfYXTAdBrXD8vuD4JyJlsA/uo1qr/ijphbIiQbZpwO96LovJn3J5cPWIrZseGkK4F8oCL3YZcikAre36P+76T1vXBTB6VzotFufzzZGrFO4JoyWQm6aSZQe73/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV7hwYuL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV7hwYuL"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e30fb8cb07so3262632a91.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517715; x=1730122515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrCJXlXENvmHEw7QE3vGYpjN6R05VoZ4y6A3f5c73vo=;
        b=LV7hwYuLugU9hYRfCfw49gmfDhGedcglcKpIYxjlsZlT8vASG6tlaiyG7VdF3UHz9c
         erpc7aZOKBNhgtukwWhY4XUdDulrKKyklo/STp+KLR2U6q5A9/0fdTuCnC5pTHIAiPXW
         Y7Z/c5SUGfXrFzw+AZiJeOYXiDvHk4hjKwXYy1v8+bxyUx18R3xGLhHGUVxj++7pgTa6
         tt+Uo7N0ngZG/SuLhBkcLPoFSBjm/XfsocL5+Dgd7+GsyT2NfH5NNnXdORXXI8k4VjH0
         fFF2Cl0HTkF100r4INs1HKBpX/k99EaNeENNaQywD+3izUdrTvTM5Lrz3EignyUBWPVV
         KeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517715; x=1730122515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrCJXlXENvmHEw7QE3vGYpjN6R05VoZ4y6A3f5c73vo=;
        b=X2gpdok5wsirxCyZsPSZo09I7ZxixjL2HFOS2PasdLsTEhxoCb3fDxwQupjm0VUvLp
         BJW7XphA0/6dgjmshPYwz5kB5ol0BM2PpRKCYd8Jl6mkb207Sc0lhu4xI0s7vsiSdIgn
         p5ZFsUGsba0dUsYTYrffDH9BwP/ykHH8fJunPqLgm2kacsyXfk9CVLlye/+HumZd6nOd
         oYL/ErLuddYcKdzDrrgbB4boIkaLNTa1eBKNVQZn/tJvgC82/ZKFoOS/r9lwMrj5Yxbo
         JXrd29V2hmOrQSVjZcIybxZdpEuCxJCk4i6M5aCAKLuSP8Cthd/5/vPlgIYrCi7CiA3R
         c0cg==
X-Gm-Message-State: AOJu0YxL6C1oD6a5Dl6urUssnPkfuU/3i7J9azUNL9z4xBudo8qej2Wc
	13Vp/zHMtJG37olg1OkwJhYCW+7hkC5RPhCAmzjYfzQ5XnJ5Hkl7FCesTLub
X-Google-Smtp-Source: AGHT+IFj3f8oq7xeriYzO19auWFTK53OJ6MEk8ME2O/6LWXp2bLQ0O1G0JTRG8iYdhJ1hnV/17NUVQ==
X-Received: by 2002:a17:90a:f6d7:b0:2e3:171e:3b8c with SMTP id 98e67ed59e1d1-2e561901f11mr12624922a91.25.1729517715289;
        Mon, 21 Oct 2024 06:35:15 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad388297sm3750947a91.30.2024.10.21.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:35:14 -0700 (PDT)
Date: Mon, 21 Oct 2024 21:35:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 9/9] ref: add symlink ref content check for files backend
Message-ID: <ZxZYlsHBSEhTcsHG@ArchLinux>
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

Besides the textual symref, we also allow symbolic links as the symref.
So, we should also provide the consistency check as what we have done
for textual symref. And also we consider deprecating writing the
symbolic links. We first need to access whether symbolic links still
be used. So, add a new fsck message "symlinkRef(INFO)" to tell the
user be aware of this information.

We have already introduced "files_fsck_symref_target". We should reuse
this function to handle the symrefs which use legacy symbolic links. We
should not check the trailing garbage for symbolic refs. Add a new
parameter "symbolic_link" to disable some checks which should only be
executed for textual symrefs.

And we need to also generate the "referent" parameter for reusing
"files_fsck_symref_target" by the following steps:

1. Use "strbuf_add_real_path" to resolve the symlink and get the
   absolute path "ref_content" which the symlink ref points to.
2. Generate the absolute path "abs_gitdir" of "gitdir" and combine
   "ref_content" and "abs_gitdir" to extract the relative path
   "relative_referent_path".
3. If "ref_content" is outside of "gitdir", we just set "referent" with
   "ref_content". Instead, we set "referent" with
   "relative_referent_path".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  6 +++++
 fsck.h                        |  1 +
 refs/files-backend.c          | 38 +++++++++++++++++++++++++----
 t/t0602-reffiles-fsck.sh      | 45 +++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index f82ebc58e8..b14bc44ca4 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -183,6 +183,12 @@
 	git@vger.kernel.org mailing list if you see this error, as
 	we need to know what tools created such a file.
 
+`symlinkRef`::
+	(INFO) A symbolic link is used as a symref. Report to the
+	git@vger.kernel.org mailing list if you see this error, as we
+	are assessing the feasibility of dropping the support to drop
+	creating symbolic links as symrefs.
+
 `symrefTargetIsNotARef`::
 	(INFO) The target of a symbolic reference points neither to
 	a root reference nor to a reference starting with "refs/".
diff --git a/fsck.h b/fsck.h
index 53a47612e6..a44c231a5f 100644
--- a/fsck.h
+++ b/fsck.h
@@ -86,6 +86,7 @@ enum fsck_msg_type {
 	FUNC(MAILMAP_SYMLINK, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
+	FUNC(SYMLINK_REF, INFO) \
 	FUNC(REF_MISSING_NEWLINE, INFO) \
 	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO) \
 	FUNC(TRAILING_REF_CONTENT, INFO) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b4912af3b5..180f8e28b7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "../git-compat-util.h"
+#include "../abspath.h"
 #include "../config.h"
 #include "../copy.h"
 #include "../environment.h"
@@ -3511,7 +3512,8 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 
 static int files_fsck_symref_target(struct fsck_options *o,
 				    struct fsck_ref_report *report,
-				    struct strbuf *referent)
+				    struct strbuf *referent,
+				    unsigned int symbolic_link)
 {
 	int is_referent_root;
 	char orig_last_byte;
@@ -3520,7 +3522,8 @@ static int files_fsck_symref_target(struct fsck_options *o,
 
 	orig_len = referent->len;
 	orig_last_byte = referent->buf[orig_len - 1];
-	strbuf_rtrim(referent);
+	if (!symbolic_link)
+		strbuf_rtrim(referent);
 
 	is_referent_root = is_root_ref(referent->buf);
 	if (!is_referent_root &&
@@ -3539,6 +3542,9 @@ static int files_fsck_symref_target(struct fsck_options *o,
 		goto out;
 	}
 
+	if (symbolic_link)
+		goto out;
+
 	if (referent->len == orig_len ||
 	    (referent->len < orig_len && orig_last_byte != '\n')) {
 		ret = fsck_report_ref(o, report,
@@ -3562,6 +3568,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 				   struct dir_iterator *iter)
 {
 	struct strbuf ref_content = STRBUF_INIT;
+	struct strbuf abs_gitdir = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct fsck_ref_report report = { 0 };
 	const char *trailing = NULL;
@@ -3572,8 +3579,30 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 
 	report.path = target_name;
 
-	if (S_ISLNK(iter->st.st_mode))
+	if (S_ISLNK(iter->st.st_mode)) {
+		const char* relative_referent_path = NULL;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_SYMLINK_REF,
+				      "use deprecated symbolic link for symref");
+
+		strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
+		strbuf_normalize_path(&abs_gitdir);
+		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
+			strbuf_addch(&abs_gitdir, '/');
+
+		strbuf_add_real_path(&ref_content, iter->path.buf);
+		skip_prefix(ref_content.buf, abs_gitdir.buf,
+			    &relative_referent_path);
+
+		if (relative_referent_path)
+			strbuf_addstr(&referent, relative_referent_path);
+		else
+			strbuf_addbuf(&referent, &ref_content);
+
+		ret |= files_fsck_symref_target(o, &report, &referent, 1);
 		goto cleanup;
+	}
 
 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
 		ret = fsck_report_ref(o, &report,
@@ -3607,13 +3636,14 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 			goto cleanup;
 		}
 	} else {
-		ret = files_fsck_symref_target(o, &report, &referent);
+		ret = files_fsck_symref_target(o, &report, &referent, 0);
 		goto cleanup;
 	}
 
 cleanup:
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
+	strbuf_release(&abs_gitdir);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index c6d40ce9a1..aee7e04b82 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -420,6 +420,51 @@ test_expect_success 'the target of the textual symref should be checked' '
 	test_cmp expect err
 '
 
+test_expect_success SYMLINKS 'symlink symref content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	ln -sf ./main $branch_dir_prefix/branch-symbolic-good &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-good &&
+	test_cmp expect err &&
+
+	ln -sf ../../logs/branch-escape $branch_dir_prefix/branch-symbolic &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
+	warning: refs/heads/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
+	EOF
+	rm $branch_dir_prefix/branch-symbolic &&
+	test_cmp expect err &&
+
+	ln -sf ./"branch   " $branch_dir_prefix/branch-symbolic-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-bad: symlinkRef: use deprecated symbolic link for symref
+	error: refs/heads/branch-symbolic-bad: badReferentName: points to invalid refname '\''refs/heads/branch   '\''
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-bad &&
+	test_cmp expect err &&
+
+	ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
+	error: refs/tags/tag-symbolic-1: badReferentName: points to invalid refname '\''refs/tags/.tag'\''
+	EOF
+	rm $tag_dir_prefix/tag-symbolic-1 &&
+	test_cmp expect err
+'
+
 test_expect_success 'ref content checks should work with worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.47.0

