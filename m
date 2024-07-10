Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B0194081
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622633; cv=none; b=pFqfIvdafCJa96OjO+YB4IRF2wHQDHqkt4tN+g7nya7cTRy1a+28GxunTdkwpH4ISkOieTwl9YCEhiOagrOcvIej9Za9STNZ3ZBSgshPK0ugwAMpDH4BfuY/wrfUDxBDCSOA5U+sZmTiauGQy8ZAmZ2Yd/xjk8GQMg3h8B7FbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622633; c=relaxed/simple;
	bh=JBCzt8yHlj3jWSwzIjmxxcRE597G3dyPMk487utwSfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HetmXebnXOYa5TUchKmQ01i2NCJWaVSXMtPVhGsFyhD7AHv0zYMbYHbv+c66AfRXB968unW1hmdptKv5+RlIaohh1TB+P7sJuDPYRpnJc0MN0TnGEYhMUw2hczn5IxwCmQFXV3AKY9NTnSsXGXuDgswkpqbd1rWWQAm8NY7CDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPAQ26M0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPAQ26M0"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c98b22638bso674125a91.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720622630; x=1721227430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc7mRd1x/hAmcIbj0A85kwo0SCaTQ7O2fgSqBLiY5T8=;
        b=FPAQ26M0p7a1+7O2drAZs3Im2LdKXLdmYK/rb82iV/MUtIRptNfUoR2RhdRBYPZcEE
         vV4BmLutJm5slv4VPPYe6XmsXXDy+V641DPZPUMgs8RoyfZNgxLy4cCRBjEiFD9sPdfS
         /Gt432fgSjHHYIH2KCDTHAMwrizpos8cACKtltqnbEevEbgvvKAn2M+4fnI8sDwvLM0M
         z7mHG5YnXELys/h/Eyyg5TdbgZfgBx9GFvdAL/VWWGKIxpzjuHzAjHNpcO2V45stEx+M
         268dt8BntIpod03gfKg27ueaL5U3KzZFOKRqYXny/qzLR+cA07aZvCyOlzLNs777s4Gt
         v0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622630; x=1721227430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc7mRd1x/hAmcIbj0A85kwo0SCaTQ7O2fgSqBLiY5T8=;
        b=tOXHUiuEzPse6DDXSCrN1e+Fz9he9zlCTpZeDgNpYGN0MdbUheFpalN9b+ODmIfe1J
         F6DzSUQzn4javq3MqIZjZHJnMZuZdBZUz3Hdo41KMBoFOEvvuTWFjnDXQ6IA+CwU45sQ
         Nx1IF8cfkCQdPTYRevoBHca0sB0wsBf6gx9ZJ9lxCG+ZyjZJ+BS1in3grwvyX5q4xm2X
         C+lSbE+CiZSVr7b/uNI+n2oGlRi4ClioCZ7R7jIPE/vxJCDRMFEn/6Ue1nqDDyErCm0n
         Wn6l+kf0HEHIMPkXodV95xWBrjnpk6qvaa8hyd03ZgrGXM0EXUqFOx8NV5jQlda/5HRj
         RrEg==
X-Gm-Message-State: AOJu0YxC90ExRycGLa9OXCqXCcgeB/9fN3oj70rJAqyUAUgEgBZFdfgc
	aMLC8/jdojoTAsAZUyUfofzBkxi5SRE1Yidd29Wrn9crkm3Cc17qePs+2g==
X-Google-Smtp-Source: AGHT+IEl+kq/iJzLPORlO0Iq5jv8AjHBxvfZc6C9uTQVDGtHv8mUeYmjbEopD2XLrXzhyskG52Z+Mw==
X-Received: by 2002:a17:90b:3b87:b0:2c8:7ef4:f502 with SMTP id 98e67ed59e1d1-2ca3a7e8be9mr8640208a91.19.1720622630133;
        Wed, 10 Jul 2024 07:43:50 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca352c3fb1sm3841760a91.35.2024.07.10.07.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:43:49 -0700 (PDT)
Date: Wed, 10 Jul 2024 22:43:50 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v10 00/10] ref consistency check infra setup
Message-ID: <Zo6eJi8BePrQxTQV@ArchLinux>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0sQCBqyxX8dJ-f@ArchLinux>

Hi All:

This version handles the following problems:

1. Following the Justin's advice. Add a new commit to rename the
objects-related fsck error functions to make the series more clean.
2. Add a simple documentation for "fsck_refs_report".
3. The previous implementation of "fsck_refs_error_function" used
"static struct strbuf", as Eric said, it's a bad idea to use "static"
because of infrequent usage of "fsck_refs_error_function". And it will
make the code arder to "libify". I didn't consider this. So In this
version, use "struct strbuf" instead and add the corresponding
memory-free operation.
4. I should not add "verbose_refs" option in "fsck: add refs-related
error report function" commit. I add this option in "builtin/refs" to
make no confusion.
5. Enchance the commit message for "refs: set up ref consistency check
infrastructure" to mention that we have added placeholder functions.
6. Change the "oid_skiplist" from comments which are ignored by the
previous version.

Thanks for every reviwer.

CI: https://github.com/shejialuo/git/pull/8

Thanks,
Jialuo

shejialuo (10):
  fsck: rename "skiplist" to "skip_oids"
  fsck: rename objects-related fsck error functions
  fsck: add a unified interface for reporting fsck messages
  fsck: add refs-related error report function
  refs: set up ref consistency check infrastructure
  builtin/refs: add verify subcommand and verbose_refs for
    "fsck_options"
  builtin/fsck: add `git-refs verify` child process
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend
  fsck: add ref content check for files backend

 Documentation/fsck-msgids.txt |  12 ++
 Documentation/git-refs.txt    |  13 ++
 builtin/fsck.c                |  32 ++++-
 builtin/mktag.c               |   1 +
 builtin/refs.c                |  44 ++++++
 fsck.c                        | 109 ++++++++++++---
 fsck.h                        |  66 ++++++---
 object-file.c                 |  11 +-
 refs.c                        |   7 +-
 refs.h                        |   8 ++
 refs/debug.c                  |  11 ++
 refs/files-backend.c          | 255 +++++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 ++
 refs/refs-internal.h          |  11 +-
 refs/reftable-backend.c       |   8 ++
 t/t0602-reffiles-fsck.sh      | 211 ++++++++++++++++++++++++++++
 16 files changed, 750 insertions(+), 57 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Range-diff against v9:
 1:  e044f933de =  1:  e044f933de fsck: rename "skiplist" to "skip_oids"
 -:  ---------- >  2:  73a7c53a23 fsck: rename objects-related fsck error functions
 2:  daaf3d0ffe !  3:  df4837e960 fsck: add a unified interface for reporting fsck messages
    @@ Commit message
     
      ## builtin/fsck.c ##
     @@ builtin/fsck.c: static int objerror(struct object *obj, const char *err)
    - 	return -1;
    - }
    - 
    --static int fsck_error_func(struct fsck_options *o UNUSED,
    --			   const struct object_id *oid,
    --			   enum object_type object_type,
    --			   enum fsck_msg_type msg_type,
    --			   enum fsck_msg_id msg_id UNUSED,
    --			   const char *message)
    -+static int fsck_objects_error_func(struct fsck_options *o UNUSED,
    -+				   const struct object_id *oid,
    -+				   enum object_type object_type,
    + static int fsck_objects_error_func(struct fsck_options *o UNUSED,
    + 				   const struct object_id *oid,
    + 				   enum object_type object_type,
     +				   const char *checked_ref_name UNUSED,
    -+				   enum fsck_msg_type msg_type,
    -+				   enum fsck_msg_id msg_id UNUSED,
    -+				   const char *message)
    - {
    - 	switch (msg_type) {
    - 	case FSCK_WARN:
    -@@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const char *prefix)
    - 
    - 	fsck_walk_options.walk = mark_object;
    - 	fsck_obj_options.walk = mark_used;
    --	fsck_obj_options.error_func = fsck_error_func;
    -+	fsck_obj_options.error_func = fsck_objects_error_func;
    - 	if (check_strict)
    - 		fsck_obj_options.strict = 1;
    - 
    + 				   enum fsck_msg_type msg_type,
    + 				   enum fsck_msg_id msg_id UNUSED,
    + 				   const char *message)
     
      ## builtin/mktag.c ##
     @@ builtin/mktag.c: static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
    @@ fsck.c: static int report(struct fsck_options *options,
      {
      	if (!options->object_names)
     @@ fsck.c: int fsck_buffer(const struct object_id *oid, enum object_type type,
    - 		      type);
    - }
    - 
    --int fsck_error_function(struct fsck_options *o,
    --			const struct object_id *oid,
    --			enum object_type object_type UNUSED,
    --			enum fsck_msg_type msg_type,
    --			enum fsck_msg_id msg_id UNUSED,
    --			const char *message)
    -+int fsck_objects_error_function(struct fsck_options *o,
    -+				const struct object_id *oid,
    -+				enum object_type object_type UNUSED,
    + int fsck_objects_error_function(struct fsck_options *o,
    + 				const struct object_id *oid,
    + 				enum object_type object_type UNUSED,
     +				const char *checked_ref_name UNUSED,
    -+				enum fsck_msg_type msg_type,
    -+				enum fsck_msg_id msg_id UNUSED,
    -+				const char *message)
    - {
    - 	if (msg_type == FSCK_WARN) {
    - 		warning("object %s: %s", fsck_describe_object(o, oid), message);
    + 				enum fsck_msg_type msg_type,
    + 				enum fsck_msg_id msg_id UNUSED,
    + 				const char *message)
     @@ fsck.c: int git_fsck_config(const char *var, const char *value,
    -  * Custom error callbacks that are used in more than one place.
    -  */
    - 
    --int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
    --					   const struct object_id *oid,
    --					   enum object_type object_type,
    --					   enum fsck_msg_type msg_type,
    --					   enum fsck_msg_id msg_id,
    --					   const char *message)
    -+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
    -+						   const struct object_id *oid,
    -+						   enum object_type object_type,
    + int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
    + 						   const struct object_id *oid,
    + 						   enum object_type object_type,
     +						   const char *checked_ref_name,
    -+						   enum fsck_msg_type msg_type,
    -+						   enum fsck_msg_id msg_id,
    -+						   const char *message)
    - {
    - 	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
    + 						   enum fsck_msg_type msg_type,
    + 						   enum fsck_msg_id msg_id,
    + 						   const char *message)
    +@@ fsck.c: int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
      		puts(oid_to_hex(oid));
      		return 0;
      	}
    --	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
    +-	return fsck_objects_error_function(o, oid, object_type,
     +	return fsck_objects_error_function(o, oid, object_type, checked_ref_name,
    -+					   msg_type, msg_id, message);
    + 					   msg_type, msg_id, message);
      }
     
      ## fsck.h ##
    @@ fsck.h: int is_valid_msg_type(const char *msg_id, const char *msg_type);
      			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
      			  const char *message);
      
    --int fsck_error_function(struct fsck_options *o,
    --			const struct object_id *oid, enum object_type object_type,
    --			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
    --			const char *message);
    --int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
    --					   const struct object_id *oid,
    --					   enum object_type object_type,
    --					   enum fsck_msg_type msg_type,
    --					   enum fsck_msg_id msg_id,
    --					   const char *message);
    -+int fsck_objects_error_function(struct fsck_options *o,
    -+				const struct object_id *oid, enum object_type object_type,
    + int fsck_objects_error_function(struct fsck_options *o,
    + 				const struct object_id *oid, enum object_type object_type,
     +				const char *checked_ref_name,
    -+				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
    -+				const char *message);
    -+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
    -+						   const struct object_id *oid,
    -+						   enum object_type object_type,
    + 				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
    + 				const char *message);
    + int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
    + 						   const struct object_id *oid,
    + 						   enum object_type object_type,
     +						   const char *checked_ref_name,
    -+						   enum fsck_msg_type msg_type,
    -+						   enum fsck_msg_id msg_id,
    -+						   const char *message);
    - 
    - struct fsck_options {
    - 	fsck_walk_func walk;
    -@@ fsck.h: struct fsck_options {
    - 	.gitmodules_done = OIDSET_INIT, \
    - 	.gitattributes_found = OIDSET_INIT, \
    - 	.gitattributes_done = OIDSET_INIT, \
    --	.error_func = fsck_error_function \
    -+	.error_func = fsck_objects_error_function \
    - }
    - #define FSCK_OPTIONS_STRICT { \
    - 	.strict = 1, \
    -@@ fsck.h: struct fsck_options {
    - 	.gitmodules_done = OIDSET_INIT, \
    - 	.gitattributes_found = OIDSET_INIT, \
    - 	.gitattributes_done = OIDSET_INIT, \
    --	.error_func = fsck_error_function, \
    -+	.error_func = fsck_objects_error_function, \
    - }
    - #define FSCK_OPTIONS_MISSING_GITMODULES { \
    - 	.strict = 1, \
    -@@ fsck.h: struct fsck_options {
    - 	.gitmodules_done = OIDSET_INIT, \
    - 	.gitattributes_found = OIDSET_INIT, \
    - 	.gitattributes_done = OIDSET_INIT, \
    --	.error_func = fsck_error_cb_print_missing_gitmodules, \
    -+	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
    - }
    - 
    - /* descend in all linked child objects
    + 						   enum fsck_msg_type msg_type,
    + 						   enum fsck_msg_id msg_id,
    + 						   const char *message);
     @@ fsck.h: int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
       */
      int fsck_finish(struct fsck_options *options);
      
    ++/*
    ++ * Report an error or warning for refs.
    ++ */
     +__attribute__((format (printf, 5, 6)))
     +int fsck_refs_report(struct fsck_options *options,
     +		     const struct object_id *oid,
 3:  40da85ae30 !  4:  c8eb01c987 fsck: add refs-related options and error report function
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    fsck: add refs-related options and error report function
    +    fsck: add refs-related error report function
     
         Add refs-related options to the "fsck_options", create refs-specific
         "error_func" callback "fsck_refs_error_function".
    @@ fsck.c: int fsck_objects_error_function(struct fsck_options *o,
     +			     enum fsck_msg_id msg_id UNUSED,
     +			     const char *message)
     +{
    -+	static struct strbuf sb = STRBUF_INIT;
    ++	struct strbuf sb = STRBUF_INIT;
    ++	int ret = 0;
     +
    -+	strbuf_reset(&sb);
     +	strbuf_addstr(&sb, checked_ref_name);
     +	if (oid)
     +		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
     +
    -+	if (msg_type == FSCK_WARN) {
    ++	if (msg_type == FSCK_WARN)
     +		warning("%s: %s", sb.buf, message);
    -+		return 0;
    -+	}
    -+	error("%s: %s", sb.buf, message);
    -+	return 1;
    ++	else
    ++		ret = error("%s: %s", sb.buf, message);
    ++
    ++	strbuf_release(&sb);
    ++	return ret;
     +}
     +
      static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
    @@ fsck.h: int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *
      
      struct fsck_options {
      	fsck_walk_func walk;
    - 	fsck_error error_func;
    - 	unsigned strict:1;
    -+	unsigned verbose_refs:1;
    - 	enum fsck_msg_type *msg_type;
    - 	struct oidset skip_oids;
    - 	struct oidset gitmodules_found;
     @@ fsck.h: struct fsck_options {
      	.gitattributes_done = OIDSET_INIT, \
      	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 4:  a38ea1b117 !  5:  e4085df496 refs: set up ref consistency check infrastructure
    @@ Commit message
         grouped into any above five categories. Explicitly add blank line to
         make it different from others.
     
    +    Last, implement placeholder functions for each ref backends.
    +
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: shejialuo <shejialuo@gmail.com>
 5:  8320f56e0b !  6:  497f224bed builtin/refs: add verify subcommand
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    builtin/refs: add verify subcommand
    +    builtin/refs: add verify subcommand and verbose_refs for "fsck_options"
     
         Introduce a new subcommand "verify" in git-refs(1) to allow the user to
    -    check the reference database consistency.
    +    check the reference database consistency and also this subcommand will
    +    be used as the entry point of checking refs for "git-fsck(1)". Last, add
    +    "verbose_refs" field into "fsck_options" to indicate whether we should
    +    print verbose messages when checking refs consistency.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
     +		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
     +		OPT_END(),
     +	};
    -+	int ret = 0;
    ++	int ret;
     +
     +	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
     +	if (argc)
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
     +	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
     +
     +	/*
    -+	 * Explicitly free the allocated array and "oid_skiplist"
    ++	 * Explicitly free the allocated array and "skip_oids" set
     +	 */
     +	free(fsck_refs_options.msg_type);
     +	oidset_clear(&fsck_refs_options.skip_oids);
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
      		OPT_END(),
      	};
      
    +
    + ## fsck.h ##
    +@@ fsck.h: struct fsck_options {
    + 	fsck_walk_func walk;
    + 	fsck_error error_func;
    + 	unsigned strict:1;
    ++	unsigned verbose_refs:1;
    + 	enum fsck_msg_type *msg_type;
    + 	struct oidset skip_oids;
    + 	struct oidset gitmodules_found;
 6:  6614a06ef5 =  7:  86a14c7b43 builtin/fsck: add `git-refs verify` child process
 7:  928cc96396 =  8:  daedb80b47 files-backend: add unified interface for refs scanning
 8:  4d50d4932f =  9:  c36d588e4f fsck: add ref name check for files backend
 9:  7edb810819 = 10:  521e0d9ca3 fsck: add ref content check for files backend
-- 
2.45.2

