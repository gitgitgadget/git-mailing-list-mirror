Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A416DEAE
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182472; cv=none; b=ojXE0+SKve6fFYumWwEzF/saZgPO5U4ywvtiUAI6jD0sy9cMjzg4801ki7qrQeaCzeKcZ8W1gVgb1BSn7n7eOoW7f80SV4+Yr6QEzwvJ+EyXpaMfT1f1NHCxt9UCD7ZKvMVxX4dyfWvKe2xXFbyjIzNzqqSsBEbniB25FsvHul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182472; c=relaxed/simple;
	bh=Sfljw8qVp+sFJpceszddLstawDDr8lwdaz/DoSaz9uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBR+4jkmWK243CvdLeoFJYs0wFpqsyTdt1LQObKw5IkDZtPgdru0F5/j3jYqrhN35TNwikb26subMGxh0KpTU9es7z1OvRxx18UM+O7wZ1qAuLq0cK9OoJq6o/6T9TlagZ82kUNG59nbawsphD/uvvRbTprjZ2Xa5AzLh5JTlpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUp1ARoj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUp1ARoj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f4a0050b9aso54997415ad.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718182469; x=1718787269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTp+QBI2qGOD2VscbMVPvEzZOtNTzzonbmg9kNIsKXU=;
        b=VUp1ARojKlCIqdTppMPA6GfXX+YxywqF08cf4oML2uLrXtZTpDbNUtZOHkNh1Q18KU
         JSYl1gMmWoFJFjZA/q7VP+tHhhckA2pNUfip3rQI7cONY8bw79p5xYPfKC88DgH0HC9b
         VBYgj8HBZf3FfYMzFDIyp4VWiMXQ2WQHK/sbDehC3i1SbYN/rW++RJoigEnP74wvTEOw
         ZFv5TkJKSyVoqkG1obzin7DxHojrfaQbVCWmCdGq7GaeRVYGvi/M5zptpZc3E5SNabl6
         cIRppjXpqqbWdNYAc3216l+kFGsZFEEi2glpMXVUQIhsCOO5z3BNs6M3tHf0Hb9PXsmj
         38Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182469; x=1718787269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTp+QBI2qGOD2VscbMVPvEzZOtNTzzonbmg9kNIsKXU=;
        b=Kp3fZdzTFJjXHiFcfkXJhgAQkEx82D5An6tpKcR+TjN4Vaiajt/MA/8iF5FgJfVxV1
         QsICiwNE449q+CGZlRuniCihjW6VGSBWRKuyGwi5anibE4M2IR3DmBVSQXh0xprHNvT6
         8tAwGHVnfOCP4IVAJAUJ659VIVaMj9nZop5MoU9Q2OlV3gW5n85JOJWhq1Smgl4RxsqB
         MuXgaXqeVaIxLY0WFZMB99AF32pn5PT8GZ7Cclks5dmGBQX9gjLLFZfeoIkiyDthHyEE
         TDEsA5cIprZbA7JumuwFX6syZ4LeTJWhgrLi85DWDPyuRqy5psu3Igyx2lkyYFYwFnT9
         /PlA==
X-Gm-Message-State: AOJu0YzqinxUVZlTW8ZMDWFDc0XDsS4I/YtP7jyADzZrya5SBzg9nEFK
	ZStaSshdkuvtIqXy64Bi1nlUHDsjtP7yvhMbJFvQyMGn/M0gweX0eKabmsmx
X-Google-Smtp-Source: AGHT+IEpX74RcUIzRKtKKEsGRUxCCIrGln5fqqNa0dR3+xZQwJpTUJQeyyQMdY66E2cgGZf8Xw+EOg==
X-Received: by 2002:a17:902:d4c1:b0:1f3:b55:e247 with SMTP id d9443c01a7336-1f83b703055mr10794635ad.55.1718182469336;
        Wed, 12 Jun 2024 01:54:29 -0700 (PDT)
Received: from ArchLinux.localdomain ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6eccc0bd0sm84066855ad.105.2024.06.12.01.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:54:28 -0700 (PDT)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [GSoC][PATCH v2 7/7] fsck: add ref content check for files backend
Date: Wed, 12 Jun 2024 16:53:49 +0800
Message-ID: <20240612085349.710785-8-shejialuo@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240612085349.710785-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance the git-fsck(1) command by adding a check for reference content
in the files backend. The new functionality ensures that symrefs, real
symbolic link and regular refs are validated correctly.

Add a new function "files_fsck_symref" to check whether the symrefs and
symbolic link points to a valid object and a new function
"files_fsck_refs_content" handles both regular refs and symbolic refs.

In order to check the trailing content, add a new parameter
"trailing" to "parse_loose_ref_contents" function.

Last, add the following FSCK MESSAGEs:

1. "badRefSha(ERROR)": A ref has a bad sha.
2. "danglingSymre(WARN)": Found a dangling symref.
3. "trailingRefContent(WARN)": A ref content has trailing contents.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   9 +++
 fsck.h                        |   3 +
 refs.c                        |   2 +-
 refs/files-backend.c          | 124 +++++++++++++++++++++++++++++++++-
 refs/refs-internal.h          |   5 +-
 t/t0602-reffiles-fsck.sh      | 110 ++++++++++++++++++++++++++++++
 6 files changed, 248 insertions(+), 5 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index cc85c897cc..69f86c5345 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -22,6 +22,9 @@
 `badRefName`::
 	(ERROR) A ref has a bad name.
 
+`badRefSha`::
+	(ERROR) A ref has a bad sha.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
@@ -37,6 +40,9 @@
 `badType`::
 	(ERROR) Found an invalid object type.
 
+`danglingSymref`::
+	(WARN) Found a dangling symref.
+
 `duplicateEntries`::
 	(ERROR) A tree contains duplicate file entries.
 
@@ -179,6 +185,9 @@
 `symlinkTargetMissing`::
 	(ERROR) Unable to read symbolic link target's blob.
 
+`trailingRefContent`::
+	(WARN) A ref content has trailing contents.
+
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
diff --git a/fsck.h b/fsck.h
index 1423a5e428..5a55a567b0 100644
--- a/fsck.h
+++ b/fsck.h
@@ -32,6 +32,7 @@ enum fsck_msg_type {
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
+	FUNC(BAD_REF_SHA, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
@@ -69,11 +70,13 @@ enum fsck_msg_type {
 	FUNC(SYMLINK_TARGET_BLOB, ERROR) \
 	/* warnings */ \
 	FUNC(EMPTY_NAME, WARN) \
+	FUNC(DANGLING_SYMREF, WARN) \
 	FUNC(FULL_PATHNAME, WARN) \
 	FUNC(HAS_DOT, WARN) \
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
index 266f1ffe8a..17d3e433f1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -549,7 +549,7 @@ static int read_ref_internal(struct ref_store *ref_store, const char *refname,
 	strbuf_rtrim(&sb_contents);
 	buf = sb_contents.buf;
 
-	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr);
+	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr, NULL);
 
 out:
 	if (ret && !myerr)
@@ -585,7 +585,7 @@ static int files_read_symbolic_ref(struct ref_store *ref_store, const char *refn
 
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno)
+			     int *failure_errno, unsigned int *trailing)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -607,6 +607,10 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 		*failure_errno = EINVAL;
 		return -1;
 	}
+
+	if (trailing && (*p != '\0' && *p != '\n'))
+		*trailing = 1;
+
 	return 0;
 }
 
@@ -3432,6 +3436,121 @@ static int files_fsck_refs_name(struct fsck_refs_options *o,
 	return ret;
 }
 
+static int files_fsck_symref(struct fsck_refs_options *o,
+			     struct strbuf *refname,
+			     struct strbuf *path)
+{
+	struct stat st;
+	int ret = 0;
+
+	if (lstat(path->buf, &st) < 0) {
+		ret = fsck_refs_report(o, refname->buf,
+				       FSCK_MSG_DANGLING_SYMREF,
+				       "point to non-existent ref");
+		goto out;
+	}
+
+	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
+		ret = fsck_refs_report(o, refname->buf,
+				       FSCK_MSG_DANGLING_SYMREF,
+				       "point to invalid object");
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
+	struct strbuf path = STRBUF_INIT,
+		      refname = STRBUF_INIT,
+		      ref_content = STRBUF_INIT,
+		      referent = STRBUF_INIT;
+	unsigned int trailing = 0;
+	int failure_errno = 0;
+	unsigned int type = 0;
+	struct object_id oid;
+	int ret = 0;
+
+	strbuf_addbuf(&path, &iter->path);
+	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
+
+	/*
+	 * If the file is a symlink, we need to only check the connectivity
+	 * of the destination object.
+	 */
+	if (S_ISLNK(iter->st.st_mode)) {
+		strbuf_strip_file_from_path(&path);
+		ret = strbuf_readlink(&ref_content,
+				      iter->path.buf, iter->st.st_size);
+		if (ret < 0) {
+			ret = error_errno(_("could not read link '%s'"),
+					  iter->path.buf);
+			goto clean;
+		}
+		strbuf_addbuf(&path, &ref_content);
+		strbuf_reset(&ref_content);
+
+		ret = files_fsck_symref(o, &refname, &path);
+		goto clean;
+	}
+
+	if (strbuf_read_file(&ref_content, path.buf, 0) < 0) {
+		ret = error_errno(_("%s/%s: unable to read the ref"),
+				  refs_check_dir, iter->relative_path);
+		goto clean;
+	}
+
+	if (parse_loose_ref_contents(ref_content.buf, &oid,
+				     &referent, &type,
+				     &failure_errno, &trailing)) {
+		ret = fsck_refs_report(o, refname.buf,
+				       FSCK_MSG_BAD_REF_SHA,
+				       "invalid ref content");
+		goto clean;
+	}
+
+	/*
+	 * If the ref is a symref, we need to check the destination name and
+	 * connectivity.
+	 */
+	if (referent.len && (type & REF_ISSYMREF)) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/%s", gitdir, referent.buf);
+
+		if (check_refname_format(referent.buf, 0)) {
+			ret = fsck_refs_report(o, refname.buf,
+					       FSCK_MSG_DANGLING_SYMREF,
+					       "point to invalid refname");
+			goto clean;
+		}
+
+		ret = files_fsck_symref(o, &refname, &path);
+		goto clean;
+	} else {
+		/*
+		 * Only regular refs could have a trailing garbage. Should
+		 * be reported as a warning.
+		 */
+		if (trailing) {
+			ret = fsck_refs_report(o, refname.buf,
+					       FSCK_MSG_TRAILING_REF_CONTENT,
+					       "trailing garbage in ref");
+			goto clean;
+		}
+	}
+
+clean:
+	strbuf_release(&path);
+	strbuf_release(&refname);
+	strbuf_release(&ref_content);
+	strbuf_release(&referent);
+	return ret;
+}
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_refs_options *o,
 			       const char *refs_check_dir,
@@ -3484,6 +3603,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 	int ret;
 	files_fsck_refs_fn fsck_refs_fns[]= {
 		files_fsck_refs_name,
+		files_fsck_refs_content,
 		NULL
 	};
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8f42f21e77..eb3a7cdcc1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -709,11 +709,12 @@ struct ref_store {
 
 /*
  * Parse contents of a loose ref file. *failure_errno maybe be set to EINVAL for
- * invalid contents.
+ * invalid contents. Also trailing is set to 1 when there is any bytes after the
+ * hex.
  */
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno);
+			     int *failure_errno, unsigned int *trailing);
 
 /*
  * Fill in the generic part of refs and add it to our collection of
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index b2db58d2c6..94cb93bf92 100755
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
+		error: refs/tags/tag-2-bad: badRefSha: invalid ref content
+		EOF
+		rm $tag_dir_prefix/tag-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "xfsazqfxcadas" > $branch_dir_prefix/a/b/branch-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/a/b/branch-2-bad: badRefSha: invalid ref content
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
+		printf "ref: refs/heads/branch-3" > $branch_dir_prefix/branch-2-bad &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-2-bad: danglingSymref: point to non-existent ref
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "ref: refs/heads/.branch" > $branch_dir_prefix/branch-2-bad &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-2-bad: danglingSymref: point to invalid refname
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "ref: refs/heads" > $branch_dir_prefix/branch-2-bad &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-2-bad: danglingSymref: point to invalid object
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	)
+'
+
 test_done
-- 
2.45.2

