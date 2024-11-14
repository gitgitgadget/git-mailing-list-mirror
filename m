Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628818D655
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603307; cv=none; b=ulxgInbdhhiOBM5A5BFNzVdEnPenc5ecSzMm2ACD+eKLMMeO25na64axr25ObKP4xDhRhoBVJpHzJEnVQ3tjFlGw1Ze9CJ30h4SXe11qEDIly1INwS0LL9UBXDJ7x9xU/aargnPMm9sbGbfyPWT7p+kN5GB0tJmglJ/5OZJUfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603307; c=relaxed/simple;
	bh=13D5jG/o+uPsRNzxO3dtap6QCVThXdWrc+LaXYdOjGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcSzDrfkkxn4SmfkwidiT5E9KksnM//pmHyaDKXV56SHKn049ksN38Ij8FL0MjvkskSXl1pTM7vAFJkwiPVDt3NG5Grvu6fkgrn+lrxAdM127OrrRN3biWyHBdSaINukjQF7pEnR0iS53WexR2CndLH/XxrpXMCZI5P3TlMjXSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOb2SOAC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOb2SOAC"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2113da91b53so6884575ad.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731603302; x=1732208102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkLeIpLTWn3acvMtN0I/VIzfCtB9KqRuRIm4NEBIh38=;
        b=UOb2SOACUIylJBUaT7sBAQqR82kylBpb8ykncw+wPGmpcwawNbfDJ6IgevNzOTzqpp
         EzGKqcNhrUvfIEeDLONYJNEZsbsnx8r10k6ctN0OKIwav0bgEarQPekzapUx29Pg9tbp
         lxjPfNdexDSTQm0Vg+qD9N8dTbJQgvH5yOdPnqG5ZdZt2PZGLUgHIDDUkzdgibgbNE0N
         WUC8uAGIqTCrenmnqejQ5lNGWNZ5wsGqh6/jtTvchmtfY5VIWCENg9qg91O1WadUDD9a
         Gyw2RB+h0yW0jw1y2wiGJhBGY5YwtGIG4tM/ay0wpNHivdIaIHLwz1ekEu6SW68u8dSl
         S0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731603302; x=1732208102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkLeIpLTWn3acvMtN0I/VIzfCtB9KqRuRIm4NEBIh38=;
        b=EZfhVXtEAWIDlKR8U5Rcd1nE9qZ0URkIBOcFPTKhZOuCKOLcWYpNHWyWMheDjPnccS
         ug0EAguOI9J+GAj81OIMalMKRnckBBOXD0nyCMw1GcqFBdJFZvWduEHUfEfZOlTTLDNP
         4DHu81D3xx1fdc4LDJrjcSmN6T2s/Xc2SlSDSZafbEDiuO3N/bR5IBy/BankHPmmG6UC
         qmS1sH+P6piBbzoDtsqKAyvFx1X7XJ/FGFupLGaDTEjEEJTRBF7XeY5oPouIY25af+Gl
         q3CAXjeBYdofVgF9TQPxZDkrP/66Onwkpt2OiKMNLR40d0J6kl14x7vNClOeO9cz4k0l
         6zdA==
X-Gm-Message-State: AOJu0YwDuw3rA7VPmseyfKMwSL6t/SBp6vjXpeIqounJjuO58kugWe5I
	PQJenNNWTlu2egyUfIYOYz1aHFiXbMSMewenhvIDqYbQu4i7KF6+N6zv0w==
X-Google-Smtp-Source: AGHT+IE7zENokNuvAkJjENpCtN20xxJSnHIFEc6neiIqXLIxUHwGoxcAD4PvhHgWS4H7RgZjJXiOTQ==
X-Received: by 2002:a17:902:cf10:b0:211:9316:da12 with SMTP id d9443c01a7336-2119316da85mr296198975ad.22.1731603301903;
        Thu, 14 Nov 2024 08:55:01 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d2a001sm12951195ad.249.2024.11.14.08.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:55:01 -0800 (PST)
Date: Fri, 15 Nov 2024 00:55:04 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v8 9/9] ref: add symlink ref content check for files backend
Message-ID: <ZzYraA3_4STrj3Jm@ArchLinux>
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
 Documentation/fsck-msgids.txt |   6 ++
 fsck.h                        |   1 +
 refs/files-backend.c          |  38 ++++++++-
 t/t0602-reffiles-fsck.sh      | 141 ++++++++++++++++++++++++++++++++++
 4 files changed, 182 insertions(+), 4 deletions(-)

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
index edf73d6cce..c715e411f3 100644
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
+		const char *relative_referent_path = NULL;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_SYMLINK_REF,
+				      "use deprecated symbolic link for symref");
+
+		strbuf_add_absolute_path(&abs_gitdir, ref_store->repo->gitdir);
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
 
 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0 ) {
 		/*
@@ -3612,13 +3641,14 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
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
index 692b30727a..f8f27cfc6c 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -395,6 +395,147 @@ test_expect_success 'the target of the textual symref should be checked' '
 	done
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
+test_expect_success SYMLINKS 'symlink symref content should be checked (worktree)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cd repo &&
+	test_commit default &&
+	git branch branch-1 &&
+	git branch branch-2 &&
+	git branch branch-3 &&
+	git worktree add ./worktree-1 branch-2 &&
+	git worktree add ./worktree-2 branch-3 &&
+	main_worktree_refdir_prefix=.git/refs/heads &&
+	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
+
+	(
+		cd worktree-1 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-1
+	) &&
+	(
+		cd worktree-2 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-1
+	) &&
+
+	ln -sf ../../../../refs/heads/good-branch $worktree1_refdir_prefix/branch-symbolic-good &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: worktrees/worktree-1/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+	EOF
+	rm $worktree1_refdir_prefix/branch-symbolic-good &&
+	test_cmp expect err &&
+
+	ln -sf ../../../../worktrees/worktree-1/good-branch $worktree2_refdir_prefix/branch-symbolic-good &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: worktrees/worktree-2/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+	EOF
+	rm $worktree2_refdir_prefix/branch-symbolic-good &&
+	test_cmp expect err &&
+
+	ln -sf ../../worktrees/worktree-2/good-branch $main_worktree_refdir_prefix/branch-symbolic-good &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+	EOF
+	rm $main_worktree_refdir_prefix/branch-symbolic-good &&
+	test_cmp expect err &&
+
+	ln -sf ../../../../logs/branch-escape $worktree1_refdir_prefix/branch-symbolic &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
+	warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
+	EOF
+	rm $worktree1_refdir_prefix/branch-symbolic &&
+	test_cmp expect err &&
+
+	for bad_referent_name in ".tag" "branch   "
+	do
+		ln -sf ./"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+		error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-1/refs/worktree/$bad_referent_name'\''
+		EOF
+		rm $worktree1_refdir_prefix/bad-symbolic &&
+		test_cmp expect err &&
+
+		ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+		error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
+		EOF
+		rm $worktree1_refdir_prefix/bad-symbolic &&
+		test_cmp expect err &&
+
+		ln -sf ./"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+		error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-2/refs/worktree/$bad_referent_name'\''
+		EOF
+		rm $worktree2_refdir_prefix/bad-symbolic &&
+		test_cmp expect err &&
+
+		ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+		error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
+		EOF
+		rm $worktree2_refdir_prefix/bad-symbolic &&
+		test_cmp expect err || return 1
+	done
+'
+
 test_expect_success 'ref content checks should work with worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.47.0

