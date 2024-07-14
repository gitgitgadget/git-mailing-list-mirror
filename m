Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC41FDD
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960363; cv=none; b=GSGPO4pprht9T0/BuPoERWHLXtkpruZ78lzv1kRxlvoDmXdSfFNPVNuQZFvDJKKix3SKxW3ENqmx7i5E5Ta2z90Bls537BslFkSedkAJdtKqPqEAwT4ah2c8tLP8G5eZ8CBeE1D1uemVUN2uT3DUixB/gU/IivPE+WDSWrMjI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960363; c=relaxed/simple;
	bh=0hi3YqelWSb0d+8YkYQcLVR8wMKbq6TOlT1x8/bsdtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faO5cmMmdRfDiUKujj+dDe7+C5gPOqiLUm7QrK7/vs1IAyVgP2estd/8vcM9mGWEFf5+H36cikhPLohBSvepUgTfGqVMGq6xyHSoT4C2lwr+aHx6nVzOMD9P4uCkVWaPLhXOyJiC9gQp7PBioodDc9RDcv3p6Ff3UKW2LTa8ZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ/9QKAL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ/9QKAL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb3cf78fcaso23830275ad.1
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 05:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960360; x=1721565160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2WNNZ+Xn73vAD0rgi99OqnjlURsq9GOq4YBmHNkCkZ0=;
        b=YZ/9QKALY5R/gZCxF4YlkakRYqV/FeWALJks4O+tfOw1dPsBv5qkKvesO01cs83CdO
         oMEIgw1k2WAxfZxtlXyLWI0a2HFjd7AZWAe1/OuwvMRVS5Ekw6OjeXijFXQ/8k9FfTuW
         QMn3HEASVJCyRyJDErWkjRJDM1XLwPd+GKyhPORosF52ocJpzvU9pUBzgOJ6mn338a6h
         j21lR3fEDND0nov2TGbAkIR34tkj1Mr135A2V5HM7pvmceHkCYvUZ1R90IrZtoffWUKW
         rpFR5iuxx62Kpbij1Twy5yKtm4TWuX+tBKeDprPpqONY8Y//RVV8Ruu08JSgV4Wui5xy
         /ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960360; x=1721565160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WNNZ+Xn73vAD0rgi99OqnjlURsq9GOq4YBmHNkCkZ0=;
        b=b4x83dgvcW+2fNaNTcQM/H05Pqdrztvu9/rHA3pMhKIt9F9tvdjzjpTePcbWY4qWLb
         tjVJtT3j22dxTDlD/438SYH0Icr7QIYMGAj4zCoh44YwRM7TSylZNLWSk+pHT59z7DQv
         T6GcSSOpI7q5qh2y59MXSdHEoaaU623BPHFhGoj2ZtYPn1OuLlZxum4yrWhkmYeG4XR/
         GGuMXqIFcNRtgzQ3BqoV7nCgq0H1uDNUS2dYoq2TLMeCRjptZ71U8CkW54X637kYK8iQ
         k4/lK35htPnR658bpRZw/evPiEycYAzNEHHMUuA550D5oXTjl5cstpmiCdcSRyY++6Up
         vFBg==
X-Gm-Message-State: AOJu0YzY2/SfZXEvs+m8ZwHoiDGC0V5UAjn5JqvXoNGSXM0kxv/FSgUG
	UBvkiKmB046vUvLnyVz6PQ0yzN7XXr//Wcj9dE/RBmxIBGGUR0A+hvYppA==
X-Google-Smtp-Source: AGHT+IFrDCosTGt9S6lnD+hB9E7AduAZFKUsXhqx3mZ/B7zMtfK7K32MKbYMLGuo4mmuQeMCN8WYuQ==
X-Received: by 2002:a17:902:ea07:b0:1fb:75b6:a43d with SMTP id d9443c01a7336-1fbb6d4c958mr169299935ad.32.1720960360426;
        Sun, 14 Jul 2024 05:32:40 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc46bfasm23067095ad.245.2024.07.14.05.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:32:39 -0700 (PDT)
Date: Sun, 14 Jul 2024 20:32:45 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v11 10/10] fsck: add ref content check for files backend
Message-ID: <ZpPFbYOqDVWKz0ic@ArchLinux>
References: <ZpPEdmUN1Z5tqbK3@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpPEdmUN1Z5tqbK3@ArchLinux>

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
index dab4012246..b1630a478b 100644
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
 
@@ -167,6 +173,9 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`trailingRefContent`::
+	(WARN) A ref content has trailing contents.
+
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
diff --git a/fsck.h b/fsck.h
index 2a2441e147..e92a5844ae 100644
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
index d20e149214..42d2f676b9 100644
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
 
@@ -3438,6 +3443,141 @@ static int files_fsck_refs_name(struct fsck_options *o,
 	return ret;
 }
 
+/*
+ * Check the symref "pointee_name" and "pointee_path". The caller should
+ * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
+ * would be the content after "refs:". For symblic link, "pointee_name" would
+ * be the relative path agaignst "gitdir".
+ */
+static int files_fsck_symref_target(struct fsck_options *o,
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
+		ret = fsck_refs_report(o, NULL, refname, NULL,
+				       FSCK_MSG_BAD_SYMREF_POINTEE,
+				       "point to target out of refs hierarchy");
+		goto out;
+	}
+
+	if (check_refname_format(pointee_name, 0)) {
+		ret = fsck_refs_report(o, NULL, refname, NULL,
+				       FSCK_MSG_BAD_SYMREF_POINTEE,
+				       "point to invalid refname");
+	}
+
+	if (lstat(pointee_path, &st) < 0)
+		goto out;
+
+	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
+		ret = fsck_refs_report(o, NULL, refname, NULL,
+				       FSCK_MSG_BAD_SYMREF_POINTEE,
+				       "point to invalid target");
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
+			ret = fsck_refs_report(o, NULL, refname.buf, NULL,
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
+		ret = fsck_refs_report(o, NULL, refname.buf, NULL,
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
+			ret = fsck_refs_report(o, NULL, refname.buf, NULL,
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
@@ -3490,6 +3630,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 	int ret;
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

