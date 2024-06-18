Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941516BFB5
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698448; cv=none; b=TF9xeGBEFIMWzE7mezvil1dJNxu7cv+dJ4n0OEcADMKu6LZAikfrQGVAsRzk/olqBxNZ5VGsrQBShl8mHHTHdofeyx6cXSrjyrb7jIqxvcszRepVPUaPddTDAelTFiT7mFLvE2PlsRgWXlSKKjY4DW/hfgWQLtnLof6tqHZSsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698448; c=relaxed/simple;
	bh=ILRj15qg8klagnZLDAbs92aCmXkuNF+wfwmTAi9V+zw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ad/QH35rScXRNzoClkET6ZLbxD3ZI+qFm3snjMQAUXjeufJuZiHgrh/4I5+whVbzNKuYs1qd1pKc1u1JgvPsmFL//j/xeZ9bGuL/l8rrKaUBKySFIbzflAGiK6STUe+ZTixZ9DY3rntAbxA+PLr5WmT++9l1tNA5pvy/yEsVSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAo1sHnT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAo1sHnT"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7042a8ad9f5so4031151b3a.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718698445; x=1719303245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQBvFkxWc8tYgLVr5bakH2975igmGu4xphRAHYMQzmg=;
        b=VAo1sHnTf5db1LsidNWUvBowkYwQ2MrM10IUGJaW3OAZTQdieNzkez7iltemmWCImT
         OWdAHMmy6/WkmdOZfrjq5pxVubGYln6fvgyTGBdmwEHuaBL4z4/BH9K3KdAyAqgaYku1
         YNrXwSE2EEjqS7Nn08/1G5HcICtFQ6GqpyeP+vwdcZoeacLAOFl87BO+z7aehG3RQAjl
         Z4Dt5TrROXH2uggvQlyLRYwo8IpV31KvkjHzMi1koinKuxf/vg+nBv2witNjZQXwkAu2
         VRYoKkhEJE7fQATNkfb2iOtB+oyJT3gGPWTCT+bCB8dOhcgRr9HADMPSgFq936iOuWCa
         +kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698445; x=1719303245;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQBvFkxWc8tYgLVr5bakH2975igmGu4xphRAHYMQzmg=;
        b=IHgcda4X/+nY7nDK/c/eR777Fepq7zFbUVfVKjAhrbumKw5WHePY+Q0sWzSnM0IFnI
         wu5u753PFbi2iWs+usjrruX7C/rtE38PyCN+NiKPgQWU1Zr21pgKw9N/tAhdzPQQbAvM
         2R3+2oP4nEwqk/udHaKeQ5TExndEdAG4O/swm4xV/+zSA0QNgg/4DpCMAadSES4YefUo
         sN7w7Mw60S0LBHq+cN0aZhHLWqqw5sxv75rx+hNxqgWuznKqvpE4KnxJtOA+XCnIqTqA
         IWL3aKaUaw7r76nTi3UY71YoDIeknfCEpgwTeUDaGlvAVn86IM2wKnw0KlbQ6zi4mOVO
         NXrQ==
X-Gm-Message-State: AOJu0YybXfRZrI5eZeAgPugCWSkDclpPBFQajkePsMc7LGjtxvLXAfz+
	H0S35jUyTPGSkJopLjYEvBkgv0P5JJRazb4L5t8xy9WgF68Or0h0voguWA==
X-Google-Smtp-Source: AGHT+IHNC5r4sDbS99M135KDVPuqeWPx4LPlIlTyKsoHAZca1P0M56lxmDRKo/34cAoAXMoZaguiqw==
X-Received: by 2002:a05:6a21:62f:b0:1b5:d07a:57b2 with SMTP id adf61e73a8af0-1bcab0257cdmr2216522637.12.1718698444040;
        Tue, 18 Jun 2024 01:14:04 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fede53d188sm6456651a12.36.2024.06.18.01.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:14:03 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:14:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v3 0/7] ref consistency check infra setup
Message-ID: <ZnFByMI1lWUDSxLd@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>

This is the third version. Mainly focuses on the following problems:

1. Add "escape" check for symrefs and symbolic links.
2. Resolve the reviews.
3. Fix some errors in version 2.

shejialuo (7):
  fsck: add refs check interfaces to interface with fsck error levels
  refs: set up ref consistency check infrastructure
  builtin/refs: add verify subcommand
  builtin/fsck: add `git-refs verify` child process
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend
  fsck: add ref content check for files backend

 Documentation/fsck-msgids.txt |  12 ++
 Documentation/git-refs.txt    |  13 ++
 builtin/fsck.c                |  17 +++
 builtin/refs.c                |  45 ++++++
 fsck.c                        |  69 +++++++++
 fsck.h                        |  49 ++++++-
 refs.c                        |   7 +-
 refs.h                        |   8 ++
 refs/debug.c                  |  11 ++
 refs/files-backend.c          | 255 +++++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 ++
 refs/refs-internal.h          |  11 +-
 refs/reftable-backend.c       |   8 ++
 t/t0602-reffiles-fsck.sh      | 211 ++++++++++++++++++++++++++++
 14 files changed, 716 insertions(+), 8 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Range-diff against v2:
1:  a65de15dc7 ! 1:  b8d20c4be9 fsck: add refs check interfaces to interface with fsck error levels
    @@ fsck.h: int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
     +struct fsck_refs_options {
     +	enum fsck_msg_type *msg_type;
     +	unsigned strict:1;
    ++
     +	fsck_refs_error error_func;
     +	unsigned verbose:1;
     +};
    @@ fsck.h: int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
     +}
     +
      struct fsck_options {
    ++	/*
    ++	 * Reorder the fields to allow `fsck_ref_options` to use
    ++	 * the interfaces using `struct fsck_options`.
    ++	 */
     +	enum fsck_msg_type *msg_type;
     +	unsigned strict:1;
    ++
      	fsck_walk_func walk;
      	fsck_error error_func;
     -	unsigned strict:1;
2:  a87149069a ! 2:  c7ed95d6b4 refs: set up ref consistency check infrastructure
    @@ refs/debug.c: static int debug_reflog_expire(struct ref_store *ref_store, const
     +static int debug_fsck(struct ref_store *ref_store,
     +		      struct fsck_refs_options *o)
     +{
    -+	trace_printf_key(&trace_refs, "fsck\n");
    -+	return 0;
    ++	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
    ++	int res = drefs->refs->be->fsck(drefs->refs, o);
    ++	trace_printf_key(&trace_refs, "fsck: %d\n", res);
    ++	return res;
     +}
     +
      struct ref_storage_be refs_be_debug = {
3:  e1f1b77527 ! 3:  373f470fdc builtin/refs: add verify subcommand
    @@ Documentation/git-refs.txt: include::ref-storage-format.txt[]
      	can be used to double check that the migration works as expected before
      	performing the actual migration.
      
    ++The following options are specific to 'git refs verify':
    ++
     +--strict::
     +	Enable more strict checking, every WARN severity for the `Fsck Messages`
     +	be seen as ERROR.
4:  2b0ee79e78 = 4:  4f8ebea573 builtin/fsck: add `git-refs verify` child process
5:  6d23eaa1d1 ! 5:  6062b3b453 files-backend: add unified interface for refs scanning
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
      		      struct fsck_refs_options *o)
      {
     @@ refs/files-backend.c: static int files_fsck(struct ref_store *ref_store,
    + 	struct files_ref_store *refs =
      		files_downcast(ref_store, REF_STORE_READ, "fsck");
      
    - 	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
    -+	ret = files_fsck_refs(ref_store, o);
    +-	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
    ++	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o)
    ++	    | files_fsck_refs(ref_store, o);
     +
      	return ret;
      }
6:  8c55ecdd88 = 6:  87a22f4c7f fsck: add ref name check for files backend
7:  aba5f50940 ! 7:  b945f61ef1 fsck: add ref content check for files backend
    @@ Commit message
         in the files backend. The new functionality ensures that symrefs, real
         symbolic link and regular refs are validated correctly.
     
    -    Add a new function "files_fsck_symref" to check whether the symrefs and
    -    symbolic link points to a valid object and a new function
    -    "files_fsck_refs_content" handles both regular refs and symbolic refs.
    +    In order to check the trailing content of the regular refs, add a new
    +    parameter `trailing` to `parse_loose_ref_contents`.
     
    -    In order to check the trailing content, add a new parameter
    -    "trailing" to "parse_loose_ref_contents" function.
    +    For symrefs, `parse_loose_ref_contents` will set the "referent".
    +    However, symbolic link could be either absolute or relative. Use
    +    "strbuf_add_real_path" to read the symbolic link and convert the
    +    relative path to absolute path. Then use "skip_prefix" to make it align
    +    with symref "referent".
    +
    +    Thus, the symrefs and symbolic links could share the same interface. Add
    +    a new function "files_fsck_symref_target" which aims at checking the
    +    following things:
    +
    +    1. whether the pointee is under the `refs/` directory.
    +    2. whether the pointee name is correct.
    +    3. whether the pointee path is a wrong type in filesystem.
     
         Last, add the following FSCK MESSAGEs:
     
    -    1. "badRefSha(ERROR)": A ref has a bad sha.
    -    2. "danglingSymre(WARN)": Found a dangling symref.
    +    1. "badRefContent(ERROR)": A ref has a bad content
    +    2. "badSymrefPointee(ERROR)": The pointee of a symref is bad.
         3. "trailingRefContent(WARN)": A ref content has trailing contents.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
    @@ Commit message
     
      ## Documentation/fsck-msgids.txt ##
     @@
    + `badParentSha1`::
    + 	(ERROR) A commit object has a bad parent sha1.
    + 
    ++`badRefContent`::
    ++	(ERROR) A ref has a bad content.
    ++
      `badRefName`::
      	(ERROR) A ref has a bad name.
      
    -+`badRefSha`::
    -+	(ERROR) A ref has a bad sha.
    ++`badSymrefPointee`::
    ++	(ERROR) The pointee of a symref is bad.
     +
      `badTagName`::
      	(INFO) A tag has an invalid format.
      
    -@@
    - `badType`::
    - 	(ERROR) Found an invalid object type.
    - 
    -+`danglingSymref`::
    -+	(WARN) Found a dangling symref.
    -+
    - `duplicateEntries`::
    - 	(ERROR) A tree contains duplicate file entries.
    - 
     @@
      `symlinkTargetMissing`::
      	(ERROR) Unable to read symbolic link target's blob.
    @@ fsck.h: enum fsck_msg_type {
      	FUNC(BAD_OBJECT_SHA1, ERROR) \
      	FUNC(BAD_PARENT_SHA1, ERROR) \
      	FUNC(BAD_REF_NAME, ERROR) \
    -+	FUNC(BAD_REF_SHA, ERROR) \
    ++	FUNC(BAD_REF_CONTENT, ERROR) \
    ++	FUNC(BAD_SYMREF_POINTEE, ERROR) \
      	FUNC(BAD_TIMEZONE, ERROR) \
      	FUNC(BAD_TREE, ERROR) \
      	FUNC(BAD_TREE_SHA1, ERROR) \
     @@ fsck.h: enum fsck_msg_type {
    - 	FUNC(SYMLINK_TARGET_BLOB, ERROR) \
    - 	/* warnings */ \
    - 	FUNC(EMPTY_NAME, WARN) \
    -+	FUNC(DANGLING_SYMREF, WARN) \
    - 	FUNC(FULL_PATHNAME, WARN) \
    - 	FUNC(HAS_DOT, WARN) \
      	FUNC(HAS_DOTDOT, WARN) \
      	FUNC(HAS_DOTGIT, WARN) \
      	FUNC(NULL_SHA1, WARN) \
    @@ refs.c: static int refs_read_special_head(struct ref_store *ref_store,
      	strbuf_release(&full_path);
     
      ## refs/files-backend.c ##
    +@@
    + #include "../git-compat-util.h"
    ++#include "../abspath.h"
    + #include "../copy.h"
    + #include "../environment.h"
    + #include "../gettext.h"
     @@ refs/files-backend.c: static int read_ref_internal(struct ref_store *ref_store, const char *refname,
      	strbuf_rtrim(&sb_contents);
      	buf = sb_contents.buf;
    @@ refs/files-backend.c: static int files_read_symbolic_ref(struct ref_store *ref_s
      int parse_loose_ref_contents(const char *buf, struct object_id *oid,
      			     struct strbuf *referent, unsigned int *type,
     -			     int *failure_errno)
    -+			     int *failure_errno, unsigned int *trailing)
    ++			     int *failure_errno, const char **trailing)
      {
      	const char *p;
      	if (skip_prefix(buf, "ref:", &buf)) {
    @@ refs/files-backend.c: int parse_loose_ref_contents(const char *buf, struct objec
      		return -1;
      	}
     +
    -+	if (trailing && (*p != '\0' && *p != '\n'))
    -+		*trailing = 1;
    ++	if (trailing)
    ++		*trailing = p;
     +
      	return 0;
      }
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_refs_options *
      	return ret;
      }
      
    -+static int files_fsck_symref(struct fsck_refs_options *o,
    -+			     struct strbuf *refname,
    -+			     struct strbuf *path)
    ++/*
    ++ * Check the symref "pointee_name" and "pointee_path". The caller should
    ++ * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
    ++ * would be the content after "refs:". For symblic link, "pointee_name" would
    ++ * be the relative path agaignst "gitdir".
    ++ */
    ++static int files_fsck_symref_target(struct fsck_refs_options *o,
    ++				    const char *refname,
    ++				    const char *pointee_name,
    ++				    const char *pointee_path)
     +{
    ++	const char *p = NULL;
     +	struct stat st;
     +	int ret = 0;
     +
    -+	if (lstat(path->buf, &st) < 0) {
    -+		ret = fsck_refs_report(o, refname->buf,
    -+				       FSCK_MSG_DANGLING_SYMREF,
    -+				       "point to non-existent ref");
    ++	if (!skip_prefix(pointee_name, "refs/", &p)) {
    ++
    ++		ret = fsck_refs_report(o, refname,
    ++				       FSCK_MSG_BAD_SYMREF_POINTEE,
    ++				       "point to target out of refs hierarchy");
     +		goto out;
     +	}
     +
    ++	if (check_refname_format(pointee_name, 0)) {
    ++		ret = fsck_refs_report(o, refname,
    ++				       FSCK_MSG_BAD_SYMREF_POINTEE,
    ++				       "point to invalid refname");
    ++	}
    ++
    ++	if (lstat(pointee_path, &st) < 0)
    ++		goto out;
    ++
     +	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
    -+		ret = fsck_refs_report(o, refname->buf,
    -+				       FSCK_MSG_DANGLING_SYMREF,
    -+				       "point to invalid object");
    ++		ret = fsck_refs_report(o, refname,
    ++				       FSCK_MSG_BAD_SYMREF_POINTEE,
    ++				       "point to invalid target");
     +		goto out;
     +	}
     +out:
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_refs_options *
     +				   const char *refs_check_dir,
     +				   struct dir_iterator *iter)
     +{
    -+	struct strbuf path = STRBUF_INIT,
    -+		      refname = STRBUF_INIT,
    ++	struct strbuf pointee_path = STRBUF_INIT,
     +		      ref_content = STRBUF_INIT,
    -+		      referent = STRBUF_INIT;
    -+	unsigned int trailing = 0;
    ++		      abs_gitdir = STRBUF_INIT,
    ++		      referent = STRBUF_INIT,
    ++		      refname = STRBUF_INIT;
    ++	const char *trailing = NULL;
     +	int failure_errno = 0;
     +	unsigned int type = 0;
     +	struct object_id oid;
     +	int ret = 0;
     +
    -+	strbuf_addbuf(&path, &iter->path);
     +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
     +
     +	/*
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_refs_options *
     +	 * of the destination object.
     +	 */
     +	if (S_ISLNK(iter->st.st_mode)) {
    -+		strbuf_strip_file_from_path(&path);
    -+		ret = strbuf_readlink(&ref_content,
    -+				      iter->path.buf, iter->st.st_size);
    -+		if (ret < 0) {
    -+			ret = error_errno(_("could not read link '%s'"),
    -+					  iter->path.buf);
    ++		const char *pointee_name = NULL;
    ++
    ++		strbuf_add_real_path(&pointee_path, iter->path.buf);
    ++
    ++		strbuf_add_absolute_path(&abs_gitdir, gitdir);
    ++		strbuf_normalize_path(&abs_gitdir);
    ++		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
    ++			strbuf_addch(&abs_gitdir, '/');
    ++
    ++		if (!skip_prefix(pointee_path.buf,
    ++				 abs_gitdir.buf, &pointee_name)) {
    ++			ret = fsck_refs_report(o, refname.buf,
    ++					       FSCK_MSG_BAD_SYMREF_POINTEE,
    ++					       "point to target outside gitdir");
     +			goto clean;
     +		}
    -+		strbuf_addbuf(&path, &ref_content);
    -+		strbuf_reset(&ref_content);
     +
    -+		ret = files_fsck_symref(o, &refname, &path);
    ++		ret = files_fsck_symref_target(o, refname.buf, pointee_name,
    ++					       pointee_path.buf);
     +		goto clean;
     +	}
     +
    -+	if (strbuf_read_file(&ref_content, path.buf, 0) < 0) {
    ++	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
     +		ret = error_errno(_("%s/%s: unable to read the ref"),
     +				  refs_check_dir, iter->relative_path);
     +		goto clean;
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_refs_options *
     +				     &referent, &type,
     +				     &failure_errno, &trailing)) {
     +		ret = fsck_refs_report(o, refname.buf,
    -+				       FSCK_MSG_BAD_REF_SHA,
    ++				       FSCK_MSG_BAD_REF_CONTENT,
     +				       "invalid ref content");
     +		goto clean;
     +	}
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_refs_options *
     +	 * connectivity.
     +	 */
     +	if (referent.len && (type & REF_ISSYMREF)) {
    -+		strbuf_reset(&path);
    -+		strbuf_addf(&path, "%s/%s", gitdir, referent.buf);
    -+
    -+		if (check_refname_format(referent.buf, 0)) {
    -+			ret = fsck_refs_report(o, refname.buf,
    -+					       FSCK_MSG_DANGLING_SYMREF,
    -+					       "point to invalid refname");
    -+			goto clean;
    -+		}
    ++		strbuf_addf(&pointee_path, "%s/%s", gitdir, referent.buf);
    ++		strbuf_rtrim(&referent);
     +
    -+		ret = files_fsck_symref(o, &refname, &path);
    ++		ret = files_fsck_symref_target(o, refname.buf, referent.buf,
    ++					       pointee_path.buf);
     +		goto clean;
     +	} else {
     +		/*
     +		 * Only regular refs could have a trailing garbage. Should
     +		 * be reported as a warning.
     +		 */
    -+		if (trailing) {
    ++		if (trailing && (*trailing != '\0' && *trailing != '\n')) {
     +			ret = fsck_refs_report(o, refname.buf,
     +					       FSCK_MSG_TRAILING_REF_CONTENT,
     +					       "trailing garbage in ref");
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_refs_options *
     +	}
     +
     +clean:
    -+	strbuf_release(&path);
    ++	strbuf_release(&abs_gitdir);
    ++	strbuf_release(&pointee_path);
     +	strbuf_release(&refname);
     +	strbuf_release(&ref_content);
     +	strbuf_release(&referent);
    @@ refs/refs-internal.h: struct ref_store {
      /*
       * Parse contents of a loose ref file. *failure_errno maybe be set to EINVAL for
     - * invalid contents.
    -+ * invalid contents. Also trailing is set to 1 when there is any bytes after the
    -+ * hex.
    ++ * invalid contents. Also *trailing is set to the first character after the
    ++ * refname or NULL if the referent is not empty.
       */
      int parse_loose_ref_contents(const char *buf, struct object_id *oid,
      			     struct strbuf *referent, unsigned int *type,
     -			     int *failure_errno);
    -+			     int *failure_errno, unsigned int *trailing);
    ++			     int *failure_errno, const char **trailing);
      
      /*
       * Fill in the generic part of refs and add it to our collection of
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should be adapted
     +		printf "xfsazqfxcadas" > $tag_dir_prefix/tag-2-bad &&
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		error: refs/tags/tag-2-bad: badRefSha: invalid ref content
    ++		error: refs/tags/tag-2-bad: badRefContent: invalid ref content
     +		EOF
     +		rm $tag_dir_prefix/tag-2-bad &&
     +		test_cmp expect err
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should be adapted
     +		printf "xfsazqfxcadas" > $branch_dir_prefix/a/b/branch-2-bad &&
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		error: refs/heads/a/b/branch-2-bad: badRefSha: invalid ref content
    ++		error: refs/heads/a/b/branch-2-bad: badRefContent: invalid ref content
     +		EOF
     +		rm $branch_dir_prefix/a/b/branch-2-bad &&
     +		test_cmp expect err
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should be adapted
     +	) &&
     +	(
     +		cd repo &&
    -+		printf "ref: refs/heads/branch-3" > $branch_dir_prefix/branch-2-bad &&
    -+		git refs verify 2>err &&
    ++		printf "ref: refs/heads/.branch" > $branch_dir_prefix/branch-2-bad &&
    ++		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		warning: refs/heads/branch-2-bad: danglingSymref: point to non-existent ref
    ++		error: refs/heads/branch-2-bad: badSymrefPointee: point to invalid refname
     +		EOF
     +		rm $branch_dir_prefix/branch-2-bad &&
     +		test_cmp expect err
     +	) &&
     +	(
     +		cd repo &&
    -+		printf "ref: refs/heads/.branch" > $branch_dir_prefix/branch-2-bad &&
    -+		git refs verify 2>err &&
    ++		printf "ref: refs/heads" > $branch_dir_prefix/branch-2-bad &&
    ++		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		warning: refs/heads/branch-2-bad: danglingSymref: point to invalid refname
    ++		error: refs/heads/branch-2-bad: badSymrefPointee: point to invalid target
     +		EOF
     +		rm $branch_dir_prefix/branch-2-bad &&
     +		test_cmp expect err
     +	) &&
     +	(
     +		cd repo &&
    -+		printf "ref: refs/heads" > $branch_dir_prefix/branch-2-bad &&
    -+		git refs verify 2>err &&
    ++		printf "ref: logs/maint-v2.45" > $branch_dir_prefix/branch-2-bad &&
    ++		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		warning: refs/heads/branch-2-bad: danglingSymref: point to invalid object
    ++		error: refs/heads/branch-2-bad: badSymrefPointee: point to target out of refs hierarchy
     +		EOF
     +		rm $branch_dir_prefix/branch-2-bad &&
     +		test_cmp expect err
-- 
2.45.2

