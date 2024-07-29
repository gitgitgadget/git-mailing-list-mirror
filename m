Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E97149C4D
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259659; cv=none; b=eHvtsv0PlQ8mPK7PJU6WL1Bwx5DUYqe8oiQ2E31xF5T6hf31cUzk/NuaFymJnBMAE5Y4NKcOfY6dxQZmiKcuE3Qd1g5xj9aRdZiAaYVgzWXf6nFMRC7LwGqE5FuNqn8BJz2mH180y2bYUokgprEWpr6FflVMP0zTA8SGp5eVVQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259659; c=relaxed/simple;
	bh=jyPvgvaA8jeyvOtDSyeaijFCiHDttTYUBr9wFefrQqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SG54+fhfmoePRlfFBm6wR10SpaawrefAja6w4e6VyTtoxDWqjU67bVuvgQSBd9tcwDMhUIdBsCaT+eVfYeLouxsagPnjrKrR6ptYDsTkj5irxgnhUYPzo0kRhgWjNYLB/Dzyy4sjunvRGF23xnEOxNSktU3riwgJErol2tw/3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlpIQ8rd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlpIQ8rd"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so2179058b3a.2
        for <git@vger.kernel.org>; Mon, 29 Jul 2024 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259656; x=1722864456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wzl1qEPdfW2l9+UBkmeCflgAXmfNVUnA94Dlb5yCRws=;
        b=JlpIQ8rd77movObEXM4M2TJcWPA1H+XjWpKAKPActn5ESBZP8tCLZXQJgYa4TWkBnz
         Q6hT4XRJg2J7nVvKALLyr9MPFtnAkghKol52BGo56bnW5kDVF6TaiEGfRVeMImQXmsly
         K4L+YRfdcJ5VtqjlWtilysNxzbki08lFf7GtW3xCEMZQrdddYm2alcPGFLYrqis0WU57
         Jm/ut79TmuOmtEYv99obPH2SDvAOMWH6uc0j7PqvoE+7jxXDkFs4cmNB+3l3YzK19eN2
         v4QlTAB35+Rk/OZLwbEQ8GrawVy9cMCceLXs05Rdeg0wxEtJAGITWshGc9buWUSFkTx9
         zyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259656; x=1722864456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wzl1qEPdfW2l9+UBkmeCflgAXmfNVUnA94Dlb5yCRws=;
        b=NheiD2FJ/wOmZDIjv2Tn9IoGGkYONmt8Eahh8V8sP2ZYmO6sobIDrM4wT+CTnBcT2g
         fwAph6W4mk5eHXi7uLvwu/+4XIV4mpA0k6Lvbss0WA5t9dwDXLyepfDv4BKT7mvDWPOM
         H1EVgQ6/GO2HIi/alF4k+HmQMZuuyc3saETz+QcdpAsPz/I8vMttd5J+++Y+SewMGQUp
         CM2nuc+3F5CASU/Muk+FlKQU+MwPp7/oYwQhg+BpIt+b/lkiXBP5EBGeOxe1qxXqFTaK
         Etf0BRjPE7tt8Z9SwfPDGVjapUkUZj+NswO8S8eBNUZvL8eEURpLxsjODEy+B0ccYbaZ
         2piQ==
X-Gm-Message-State: AOJu0YzludKB8MSXnxZWyJNYk7eVu2XDykp1/DoV9iTzeZON2RrZNDcu
	kb+mtgsqVFgkUv/gY3o7HezFAGT7381HkXmSo+ZdaBajL6F4yRYT7FEJCQ==
X-Google-Smtp-Source: AGHT+IF2IO49UF5Mtm6Z5Oq5Wz0doprdBJ7J+pMpjriu1Ke7T2hGcQ9jz5qyYQw/RL3aQEEPqDFiPA==
X-Received: by 2002:a05:6a20:258e:b0:1c2:9784:1b42 with SMTP id adf61e73a8af0-1c4a129d455mr6103613637.16.1722259655802;
        Mon, 29 Jul 2024 06:27:35 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff072asm82398995ad.296.2024.07.29.06.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:27:34 -0700 (PDT)
Date: Mon, 29 Jul 2024 21:27:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v13 10/10] fsck: add ref content check for files backend
Message-ID: <ZqeY3Dhj-Fo-bZ2k@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqeXrPROpEg_pRS2@ArchLinux>

Enhance the git-fsck(1) command by adding a check for reference content
in the files backend. The new functionality ensures that symrefs, real
symbolic link and regular refs are validated correctly.

In order to check the trailing content of the regular refs, add a new
parameter `trailing` to `parse_loose_ref_contents`.

For symrefs, `parse_loose_ref_contents` will set the "referent".
However, symbolic link could be either absolute or relative. Use
"strbuf_add_real_path" to read the symbolic link and convert the
relative path to absolute path. Then use "skip_prefix" to make it align
with symref "referent".

Thus, the symrefs and symbolic links could share the same interface. Add
a new function "files_fsck_symref_target" which aims at checking the
following things:

1. whether the pointee is under the `refs/` directory.
2. whether the pointee name is correct.
3. whether the pointee path is a wrong type in filesystem.

Last, add the following FSCK MESSAGEs:

1. "badRefContent(ERROR)": A ref has a bad content
2. "badSymrefPointee(ERROR)": The pointee of a symref is bad.
3. "trailingRefContent(WARN)": A ref content has trailing contents.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   9 +++
 fsck.h                        |   3 +
 refs.c                        |   2 +-
 refs/files-backend.c          | 144 +++++++++++++++++++++++++++++++++-
 refs/refs-internal.h          |   5 +-
 t/t0602-reffiles-fsck.sh      | 110 ++++++++++++++++++++++++++
 6 files changed, 268 insertions(+), 5 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index d8e437a043..8fe24a960e 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -19,9 +19,15 @@
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
+`badRefContent`::
+	(ERROR) A ref has a bad content.
+
 `badRefName`::
 	(ERROR) A ref has an invalid format.
 
+`badSymrefPointee`::
+	(ERROR) The pointee of a symref is bad.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
@@ -167,6 +173,9 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`trailingRefContent`::
+	(WARN) A ref content has trailing contents.
+
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
diff --git a/fsck.h b/fsck.h
index ce56ce4bef..710b3513d0 100644
--- a/fsck.h
+++ b/fsck.h
@@ -32,6 +32,8 @@ enum fsck_msg_type {
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
+	FUNC(BAD_REF_CONTENT, ERROR) \
+	FUNC(BAD_SYMREF_POINTEE, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
@@ -72,6 +74,7 @@ enum fsck_msg_type {
 	FUNC(HAS_DOTDOT, WARN) \
 	FUNC(HAS_DOTGIT, WARN) \
 	FUNC(NULL_SHA1, WARN) \
+	FUNC(TRAILING_REF_CONTENT, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
 	FUNC(LARGE_PATHNAME, WARN) \
diff --git a/refs.c b/refs.c
index 410919246b..eb82fb7d4e 100644
--- a/refs.c
+++ b/refs.c
@@ -1760,7 +1760,7 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	}
 
 	result = parse_loose_ref_contents(content.buf, oid, referent, type,
-					  failure_errno);
+					  failure_errno, NULL);
 
 done:
 	strbuf_release(&full_path);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0d4fc27768..131eec7307 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "../git-compat-util.h"
+#include "../abspath.h"
 #include "../copy.h"
 #include "../environment.h"
 #include "../gettext.h"
@@ -553,7 +554,7 @@ static int read_ref_internal(struct ref_store *ref_store, const char *refname,
 	strbuf_rtrim(&sb_contents);
 	buf = sb_contents.buf;
 
-	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr);
+	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr, NULL);
 
 out:
 	if (ret && !myerr)
@@ -589,7 +590,7 @@ static int files_read_symbolic_ref(struct ref_store *ref_store, const char *refn
 
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno)
+			     int *failure_errno, const char **trailing)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -611,6 +612,10 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 		*failure_errno = EINVAL;
 		return -1;
 	}
+
+	if (trailing)
+		*trailing = p;
+
 	return 0;
 }
 
@@ -3440,6 +3445,140 @@ static int files_fsck_refs_name(struct fsck_options *o,
 	return ret;
 }
 
+/*
+ * Check the symref "pointee_name" and "pointee_path". The caller should
+ * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
+ * would be the content after "refs:". For symblic link, "pointee_name" would
+ * be the relative path agaignst "gitdir".
+ */
+static int files_fsck_symref_target(struct fsck_options *o,
+				    struct fsck_refs_info *info,
+				    const char *refname,
+				    const char *pointee_name,
+				    const char *pointee_path)
+{
+	const char *p = NULL;
+	struct stat st;
+	int ret = 0;
+
+	if (!skip_prefix(pointee_name, "refs/", &p)) {
+
+		ret = fsck_refs_report(o, NULL, info,
+				       FSCK_MSG_BAD_SYMREF_POINTEE,
+				       "points to ref outside the refs directory");
+		goto out;
+	}
+
+	if (check_refname_format(pointee_name, 0)) {
+		ret = fsck_refs_report(o, NULL, info,
+				       FSCK_MSG_BAD_SYMREF_POINTEE,
+				       "points to refname with invalid format");
+	}
+
+	if (lstat(pointee_path, &st) < 0)
+		goto out;
+
+	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
+		ret = fsck_refs_report(o, NULL, info,
+				       FSCK_MSG_BAD_SYMREF_POINTEE,
+				       "points to an invalid file type");
+		goto out;
+	}
+out:
+	return ret;
+}
+
+static int files_fsck_refs_content(struct fsck_options *o,
+				   const char *gitdir,
+				   const char *refs_check_dir,
+				   struct dir_iterator *iter)
+{
+	struct strbuf pointee_path = STRBUF_INIT,
+		      ref_content = STRBUF_INIT,
+		      abs_gitdir = STRBUF_INIT,
+		      referent = STRBUF_INIT,
+		      refname = STRBUF_INIT;
+	const char *trailing = NULL;
+	struct fsck_refs_info info;
+	int failure_errno = 0;
+	unsigned int type = 0;
+	struct object_id oid;
+	int ret = 0;
+
+	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
+	info.path = refname.buf;
+
+	/*
+	 * If the file is a symlink, we need to only check the connectivity
+	 * of the destination object.
+	 */
+	if (S_ISLNK(iter->st.st_mode)) {
+		const char *pointee_name = NULL;
+
+		strbuf_add_real_path(&pointee_path, iter->path.buf);
+
+		strbuf_add_absolute_path(&abs_gitdir, gitdir);
+		strbuf_normalize_path(&abs_gitdir);
+		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
+			strbuf_addch(&abs_gitdir, '/');
+
+		if (!skip_prefix(pointee_path.buf,
+				 abs_gitdir.buf, &pointee_name)) {
+			ret = fsck_refs_report(o, NULL, &info,
+					       FSCK_MSG_BAD_SYMREF_POINTEE,
+					       "point to target outside gitdir");
+			goto clean;
+		}
+
+		ret = files_fsck_symref_target(o, &info, refname.buf,
+					       pointee_name, pointee_path.buf);
+		goto clean;
+	}
+
+	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
+		ret = error_errno(_("%s/%s: unable to read the ref"),
+				  refs_check_dir, iter->relative_path);
+		goto clean;
+	}
+
+	if (parse_loose_ref_contents(ref_content.buf, &oid,
+				     &referent, &type,
+				     &failure_errno, &trailing)) {
+		ret = fsck_refs_report(o, NULL, &info,
+				       FSCK_MSG_BAD_REF_CONTENT,
+				       "invalid ref content");
+		goto clean;
+	}
+
+	/*
+	 * If the ref is a symref, we need to check the destination name and
+	 * connectivity.
+	 */
+	if (referent.len && (type & REF_ISSYMREF)) {
+		strbuf_addf(&pointee_path, "%s/%s", gitdir, referent.buf);
+		strbuf_rtrim(&referent);
+
+		ret = files_fsck_symref_target(o, &info, refname.buf,
+					       referent.buf, pointee_path.buf);
+		goto clean;
+	} else {
+		if (trailing && (*trailing != '\0' && *trailing != '\n')) {
+			ret = fsck_refs_report(o, NULL, &info,
+					       FSCK_MSG_TRAILING_REF_CONTENT,
+					       "trailing garbage in ref");
+			goto clean;
+		}
+	}
+
+clean:
+	strbuf_release(&abs_gitdir);
+	strbuf_release(&pointee_path);
+	strbuf_release(&refname);
+	strbuf_release(&ref_content);
+	strbuf_release(&referent);
+	return ret;
+}
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       const char *refs_check_dir,
@@ -3491,6 +3630,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 {
 	files_fsck_refs_fn fsck_refs_fns[]= {
 		files_fsck_refs_name,
+		files_fsck_refs_content,
 		NULL
 	};
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index a905e187cd..2fabf41d14 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -709,11 +709,12 @@ struct ref_store {
 
 /*
  * Parse contents of a loose ref file. *failure_errno maybe be set to EINVAL for
- * invalid contents.
+ * invalid contents. Also *trailing is set to the first character after the
+ * refname or NULL if the referent is not empty.
  */
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno);
+			     int *failure_errno, const char **trailing);
 
 /*
  * Fill in the generic part of refs and add it to our collection of
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index b2db58d2c6..29cd824224 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -98,4 +98,114 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	)
 '
 
+test_expect_success 'regular ref content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1 &&
+		git commit --allow-empty -m second &&
+		git checkout -b branch-2 &&
+		git tag tag-2 &&
+		git checkout -b a/b/tag-2
+	) &&
+	(
+		cd repo &&
+		printf "%s garbage" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-garbage &&
+		git fsck 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-1-garbage: trailingRefContent: trailing garbage in ref
+		EOF
+		rm $branch_dir_prefix/branch-1-garbage &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "%s garbage" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
+		test_must_fail git -c fsck.trailingRefContent=error fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
+		EOF
+		rm $tag_dir_prefix/tag-1-garbage &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "%s    " "$(git rev-parse tag-2)" > $tag_dir_prefix/tag-2-garbage &&
+		git fsck 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/tags/tag-2-garbage: trailingRefContent: trailing garbage in ref
+		EOF
+		rm $tag_dir_prefix/tag-2-garbage &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "xfsazqfxcadas" > $tag_dir_prefix/tag-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/tag-2-bad: badRefContent: invalid ref content
+		EOF
+		rm $tag_dir_prefix/tag-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "xfsazqfxcadas" > $branch_dir_prefix/a/b/branch-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/a/b/branch-2-bad: badRefContent: invalid ref content
+		EOF
+		rm $branch_dir_prefix/a/b/branch-2-bad &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'symbolic ref content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1
+	) &&
+	(
+		cd repo &&
+		printf "ref: refs/heads/.branch" > $branch_dir_prefix/branch-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-2-bad: badSymrefPointee: points to refname with invalid format
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "ref: refs/heads" > $branch_dir_prefix/branch-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-2-bad: badSymrefPointee: points to an invalid file type
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "ref: logs/maint-v2.45" > $branch_dir_prefix/branch-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-2-bad: badSymrefPointee: points to ref outside the refs directory
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	)
+'
+
 test_done
-- 
2.45.2

