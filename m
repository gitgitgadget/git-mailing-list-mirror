Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AC013A272
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698832; cv=none; b=KZ8YJhNpOuYumYUgRlOzk0Pe/IyOprwNG3iiToZE9hG6zhox1Lq3QYz5r05wQT3rszyIai1vlA/jV7fQbMFdO1u3bFOSKkMmRA8wxmTjvOrFSJH94abzTZr1ojUEhBeUkU+XRkcy7lH2e5ZCD1YumMkpc2HgnLOp2F782URaQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698832; c=relaxed/simple;
	bh=S+QtzMOtBvqroU265i8edo5RBqfradIz4T4aE2OBZOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m5DmqSBQTXgiR8X9fZ9mwuu/kRrvepUsraPEhr6uACw3I2EX6NWNUmwv7wr15a+/m2D07u1pdlCGOKL4WnR1eHOHi87Bbu+FW+rveyRf26x++ybwLsWWjH9wDpLQ7T9SC69Db88z9iHODxrnMT3LUAIY3AdT65DDU8XLIBoLTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJyNmrgw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJyNmrgw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f480624d0fso37608045ad.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718698829; x=1719303629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SGlOTMVzPp95hG9CnOe5i77LyiBl2gjATDIcFsgeATo=;
        b=BJyNmrgwz7nsYrGAvJMJVWUX0OGS7oDT8inZEVEw1W07+6VpwNF2lskU5DF0UN4mhm
         sqN4cjTM8y9hmB9H6ZZpX5w4M873+egE82ozksuPkgcXeC6sBRndYuHWpvPOOvsNBj35
         Cwd0Oyz/Ej0NcbP4gXdiaUUA7E2OGi/QRpnpSvQmSsSWTVhjDLEO0Nsp3fIrwySaX1ih
         NLrmAfNi7gIPFBKWUiGlb2dHcYyM53xnfF+v0QWNqKbVEOu2lY49OBRg8kJ6D+E0X26G
         DhqIg7XXI2nnIo38BTER18yUUJs8ae+DospN+M/kFp9a4eLi/hDVNFNxc606fGTFajkO
         C3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698829; x=1719303629;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGlOTMVzPp95hG9CnOe5i77LyiBl2gjATDIcFsgeATo=;
        b=ZVNajpboBciYC9U9wfZMHaC1jt5pfRoDxtyeq1cEMkcAqe9lhk7BLSQL62MVZB4JTJ
         Gb7DVLEkZ67MDeISKFXDJO42zzKbfZDCkqpajoSOdhh9A+U4ViO2wjWzpdFO64sNf9+C
         oFD838uJEvGlBUBuTGjJl+WXCkCeo1N9sArR4MZiVexYQFffZjG2fQFkWLW7h2fB8hM/
         oXK72e20FgbdRUMUe/ZygCYuTrCPBJquwjEeNkpTJTbUsFgiaS00zJFLx2pR31UAmbFC
         0wywFVjKjd38SxnYxVf0QBWhLXfYehyXKs4lA0uPiDmHg76M9PM2pfhsv5nRwxVe9TFL
         2hfg==
X-Gm-Message-State: AOJu0YxjuhBfhArjRalgf1UxXEsasmHWLIPgutDeY0QZ4bEqnfCwGCwF
	bTMEzgSvLIHdM3hL0svRYkzX7XU2KOiV4ZlNywD142yO2kTsm5zdWMzHEQ==
X-Google-Smtp-Source: AGHT+IFoPhSxdZxWs2QcJZoQDP5CMnD71Ev1sfV+ESF6nCTURn/4MZRB9tbswI66YdNLiEIGJq2S8w==
X-Received: by 2002:a17:902:c94b:b0:1f6:e8ee:54a6 with SMTP id d9443c01a7336-1f862a0679cmr134629565ad.59.1718698828990;
        Tue, 18 Jun 2024 01:20:28 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee805asm91516085ad.128.2024.06.18.01.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:20:28 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:20:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 7/7] fsck: add ref content check for files backend
Message-ID: <ZnFDSohT0_374NGS@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>

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
 refs/files-backend.c          | 145 +++++++++++++++++++++++++++++++++-
 refs/refs-internal.h          |   5 +-
 t/t0602-reffiles-fsck.sh      | 110 ++++++++++++++++++++++++++
 6 files changed, 269 insertions(+), 5 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index cc85c897cc..ebe2de2bdc 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -19,9 +19,15 @@
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
+`badRefContent`::
+	(ERROR) A ref has a bad content.
+
 `badRefName`::
 	(ERROR) A ref has a bad name.
 
+`badSymrefPointee`::
+	(ERROR) The pointee of a symref is bad.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
@@ -179,6 +185,9 @@
 `symlinkTargetMissing`::
 	(ERROR) Unable to read symbolic link target's blob.
 
+`trailingRefContent`::
+	(WARN) A ref content has trailing contents.
+
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
diff --git a/fsck.h b/fsck.h
index 6b3e68b873..215b1466d2 100644
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
@@ -74,6 +76,7 @@ enum fsck_msg_type {
 	FUNC(HAS_DOTDOT, WARN) \
 	FUNC(HAS_DOTGIT, WARN) \
 	FUNC(NULL_SHA1, WARN) \
+	FUNC(TRAILING_REF_CONTENT, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
 	FUNC(LARGE_PATHNAME, WARN) \
diff --git a/refs.c b/refs.c
index 0922439275..1325f83269 100644
--- a/refs.c
+++ b/refs.c
@@ -1744,7 +1744,7 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	}
 
 	result = parse_loose_ref_contents(content.buf, oid, referent, type,
-					  failure_errno);
+					  failure_errno, NULL);
 
 done:
 	strbuf_release(&full_path);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3f0b565a13..56a64cb97c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "../abspath.h"
 #include "../copy.h"
 #include "../environment.h"
 #include "../gettext.h"
@@ -549,7 +550,7 @@ static int read_ref_internal(struct ref_store *ref_store, const char *refname,
 	strbuf_rtrim(&sb_contents);
 	buf = sb_contents.buf;
 
-	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr);
+	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr, NULL);
 
 out:
 	if (ret && !myerr)
@@ -585,7 +586,7 @@ static int files_read_symbolic_ref(struct ref_store *ref_store, const char *refn
 
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno)
+			     int *failure_errno, const char **trailing)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -607,6 +608,10 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 		*failure_errno = EINVAL;
 		return -1;
 	}
+
+	if (trailing)
+		*trailing = p;
+
 	return 0;
 }
 
@@ -3432,6 +3437,141 @@ static int files_fsck_refs_name(struct fsck_refs_options *o,
 	return ret;
 }
 
+/*
+ * Check the symref "pointee_name" and "pointee_path". The caller should
+ * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
+ * would be the content after "refs:". For symblic link, "pointee_name" would
+ * be the relative path agaignst "gitdir".
+ */
+static int files_fsck_symref_target(struct fsck_refs_options *o,
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
+		ret = fsck_refs_report(o, refname,
+				       FSCK_MSG_BAD_SYMREF_POINTEE,
+				       "point to target out of refs hierarchy");
+		goto out;
+	}
+
+	if (check_refname_format(pointee_name, 0)) {
+		ret = fsck_refs_report(o, refname,
+				       FSCK_MSG_BAD_SYMREF_POINTEE,
+				       "point to invalid refname");
+	}
+
+	if (lstat(pointee_path, &st) < 0)
+		goto out;
+
+	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
+		ret = fsck_refs_report(o, refname,
+				       FSCK_MSG_BAD_SYMREF_POINTEE,
+				       "point to invalid target");
+		goto out;
+	}
+out:
+	return ret;
+}
+
+static int files_fsck_refs_content(struct fsck_refs_options *o,
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
+	int failure_errno = 0;
+	unsigned int type = 0;
+	struct object_id oid;
+	int ret = 0;
+
+	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
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
+			ret = fsck_refs_report(o, refname.buf,
+					       FSCK_MSG_BAD_SYMREF_POINTEE,
+					       "point to target outside gitdir");
+			goto clean;
+		}
+
+		ret = files_fsck_symref_target(o, refname.buf, pointee_name,
+					       pointee_path.buf);
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
+		ret = fsck_refs_report(o, refname.buf,
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
+		ret = files_fsck_symref_target(o, refname.buf, referent.buf,
+					       pointee_path.buf);
+		goto clean;
+	} else {
+		/*
+		 * Only regular refs could have a trailing garbage. Should
+		 * be reported as a warning.
+		 */
+		if (trailing && (*trailing != '\0' && *trailing != '\n')) {
+			ret = fsck_refs_report(o, refname.buf,
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
 			       struct fsck_refs_options *o,
 			       const char *refs_check_dir,
@@ -3484,6 +3624,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 	int ret;
 	files_fsck_refs_fn fsck_refs_fns[]= {
 		files_fsck_refs_name,
+		files_fsck_refs_content,
 		NULL
 	};
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8f42f21e77..72f0945ada 100644
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
index b2db58d2c6..35bf40ee64 100755
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
+		error: refs/heads/branch-2-bad: badSymrefPointee: point to invalid refname
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "ref: refs/heads" > $branch_dir_prefix/branch-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-2-bad: badSymrefPointee: point to invalid target
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "ref: logs/maint-v2.45" > $branch_dir_prefix/branch-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-2-bad: badSymrefPointee: point to target out of refs hierarchy
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	)
+'
+
 test_done
-- 
2.45.2

