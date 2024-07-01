Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3672116F0E4
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846847; cv=none; b=onObFRSW+d+tgCM9PAaaS+iCE8rrhAPRHDZ8iPbVSRb66xgioDN5Rd6gUh33nJJohOh3ngbDhBSzHgBJ5LY1mSHMyuaNhkDAYZQyYcN2QBkUqYReuTi4jbWHDj6nucUP54St/0cLTc/FgXw95wpdVods0Y1IU2qwacn+61iOqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846847; c=relaxed/simple;
	bh=7ubLbWTGl2orJ5eoJ2X7j9O5Y8VF6fXNkDLkQONYE9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBskogUdoA63pEEZnLbD4Gg2cxqB7RMMKGFf1b2F5TyXrF3bMzHI9At6AZDWIn3mHrBRBtkUx2hS/HwVLr0CESIkLc54kMyYZ0H8TaroxrNqfqhHDs9mEuOO3wz7UdKv+Iz9rsYbH44MRIkmd8dszgrG8wgYOhgHiocwZLFUgBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF03oN9y; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF03oN9y"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fa07e4f44eso20188395ad.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719846843; x=1720451643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ws4hzTLqlmT2e0bQk4la+9TBffy1WJmIb6Fhh3tgfl4=;
        b=JF03oN9yLzyTYod2eYoeuq2SvQr5Q4AqhGjHtqY9Eq4Ky8EBwQiTuO0V+DmDpzBWvQ
         lB1Y/K/fytKTwYvapWuDtIG/EnPiB3tRmMXvNLE+KyOLU23NVjW8UhhP8uQd8iocKFV6
         czHIrX4DKksSEDjBqYp2R3SI/Q4sOruBcbVv4id25tGmLhrrUJ7Pl4rJ5a2v64Yv00U3
         5PJkPmEsQijmS9uiICWPlMxZcG3zkBnyiBe4OaK3kzPXCFcnlgdhintAphoX1qlenxce
         GSc3URuUfBenXa5eZJZElDpW66Ex+XXxYDgz/TlmNYWu+WI8GfAPMhkph4K1bLXIDICu
         SBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719846843; x=1720451643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws4hzTLqlmT2e0bQk4la+9TBffy1WJmIb6Fhh3tgfl4=;
        b=ngIM8Kr6TRIoP34WBXY/vBV3aZEF54TMIb8AQYbe8hspHPfjcZFvgPRo+keN+F+290
         /smjs/I/gZAjU1ZTC/6euFfm+XQZfbJ6XCYv+Z5YE8Mb/Y4rl4blls3Gri9cRuYDCBfo
         dsVHT3Wyf3tgbO82/RNh+3hKtpr/IzNb7go+zPAgzT0VGUKM4isxKCyXD0glKy3vOTq3
         fYg2qAoRjD/WbTN2WT9in4E/H9NLHIIYwpGvgOQBIgvGaAAs/0Yinv9gWVTVGJvjvUFm
         PjE8jZJHdDzPORUyNuf3Te91NOTnfq+OdU89f8yt8vxpO3NPny9Z2PFVEoCGlNxMNObK
         bqtg==
X-Gm-Message-State: AOJu0YzFw5BDiukZhVBqrpspU/gDuslpooJ2OThqBXN3s5YDSWCKhXrj
	ql975uPM65gZaE46Tb3MpTdNphG3C/E7pDOb5ODJfIITC792xcRDWVVNFQ==
X-Google-Smtp-Source: AGHT+IGeuj2OJd7rK56t/OJ+RNaVwdy4WwCQfTTg0XFUxtdFLSsHNyeKbxGkV7y6Mn6I+8vsGMxo5Q==
X-Received: by 2002:a17:902:ce8e:b0:1f6:81f9:cf34 with SMTP id d9443c01a7336-1fadbca338fmr49274095ad.34.1719846841874;
        Mon, 01 Jul 2024 08:14:01 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1569f83sm65702915ad.204.2024.07.01.08.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:14:01 -0700 (PDT)
Date: Mon, 1 Jul 2024 23:13:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v6 00/11] ref consistency check infra setup
Message-ID: <ZoLHtmOKTfxMSxvw@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn2Ah3WDhtOmzrzn@ArchLinux>

Hi All:

This version follows the Junio's advice. Instead of creating the
following data structure:

	struct fsck_options {
		enum fsck_type {
			FSCK_OBJECTS,
			FSCK_REFS,
			...
		} t;
		union {
			struct fsck_objects_options objects;
			struct fsck_refs_options refs;
		} u;
	};

I simply use the combination idea where "fsck_options" will incorporate
"fsck_objects_options" and "fsck_refs_options". Karthik has told me that
I should balance the job I should does and the extensibility for future.
So I use the most clear way to do this. Also Junio has said:

> I would have expected that adding ref-related new members that
> object consistency checkers has no interest in to the fsck_options
> structure would be sufficient for the purpose of this series.

So this patch makes the design simple here.

Thanks for every reviewer.

Jialuo.

shejialuo (11):
  fsck: add "fsck_objects_options" to hold objects-related options
  fsck: rename "skiplist" to "oid_skiplist"
  fsck: add "fsck_refs_options" into "fsck_options"
  fsck: add a unified interface for reporting fsck messages
  fsck: add "fsck_refs_options" initialization macros
  refs: set up ref consistency check infrastructure
  builtin/refs: add verify subcommand
  builtin/fsck: add `git-refs verify` child process
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend
  fsck: add ref content check for files backend

 Documentation/fsck-msgids.txt |  12 ++
 Documentation/git-refs.txt    |  13 ++
 builtin/fsck.c                |  44 ++++--
 builtin/index-pack.c          |   4 +-
 builtin/mktag.c               |   3 +-
 builtin/refs.c                |  44 ++++++
 builtin/unpack-objects.c      |   4 +-
 fetch-pack.c                  |  10 +-
 fsck.c                        | 158 +++++++++++++++------
 fsck.h                        | 115 ++++++++++-----
 object-file.c                 |  13 +-
 refs.c                        |   7 +-
 refs.h                        |   8 ++
 refs/debug.c                  |  11 ++
 refs/files-backend.c          | 255 +++++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 ++
 refs/refs-internal.h          |  11 +-
 refs/reftable-backend.c       |   8 ++
 t/t0602-reffiles-fsck.sh      | 211 ++++++++++++++++++++++++++++
 19 files changed, 824 insertions(+), 115 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Range-diff against v5:
 1:  d83b5797cb <  -:  ---------- fsck: rename "fsck_options" to "fsck_objects_options"
 2:  88000b092a <  -:  ---------- fsck: use "fsck_configs" to set up configs
 3:  65093bae64 <  -:  ---------- fsck: abstract common options for reusing
 4:  403750da30 <  -:  ---------- fsck: add "fsck_refs_options" struct
 5:  8dea5654d5 <  -:  ---------- fsck: add a unified interface for reporting fsck messages
 -:  ---------- >  1:  d32ae41a4d fsck: add "fsck_objects_options" to hold objects-related options
 -:  ---------- >  2:  589a7a6fac fsck: rename "skiplist" to "oid_skiplist"
 -:  ---------- >  3:  bab97d7c82 fsck: add "fsck_refs_options" into "fsck_options"
 -:  ---------- >  4:  276da52a6b fsck: add a unified interface for reporting fsck messages
 6:  8fb62b54c6 !  5:  e93940c50c fsck: add "fsck_refs_options" initialization macros
    @@ Commit message
         fsck: add "fsck_refs_options" initialization macros
     
         Add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT" macros to
    -    create the "fsck_refs_options" easily. Add refs-specific "error_func"
    -    callback "fsck_refs_error_function".
    +    create the refs options easily. Add refs-specific "error_func" callback
    +    "fsck_refs_error_function".
     
         "fsck_refs_error_function" will use the "oid" parameter. When the caller
         passed the oid, it will use "oid_to_hex" to get the corresponding hex
    @@ Commit message
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
      ## fsck.c ##
    -@@ fsck.c: int fsck_error_function(struct fsck_objects_options *objects_options,
    +@@ fsck.c: int fsck_objects_error_function(struct fsck_options *o,
      	return 1;
      }
      
    -+int fsck_refs_error_function(struct fsck_objects_options *objects_options UNUSED,
    -+			     struct fsck_refs_options *refs_options,
    ++int fsck_refs_error_function(struct fsck_options *options UNUSED,
     +			     const struct object_id *oid,
     +			     enum object_type object_type UNUSED,
     +			     const char *checked_ref_name,
    @@ fsck.c: int fsck_error_function(struct fsck_objects_options *objects_options,
     +
      static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
      		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
    - 		      struct fsck_objects_options *options,
    + 		      struct fsck_options *options, const char *blob_type)
     
      ## fsck.h ##
    -@@ fsck.h: int fsck_error_cb_print_missing_gitmodules(struct fsck_objects_options *objects_
    - 					   enum fsck_msg_type msg_type,
    - 					   enum fsck_msg_id msg_id,
    - 					   const char *message);
    -+int fsck_refs_error_function(struct fsck_objects_options *objects_options,
    -+			     struct fsck_refs_options *refs_options,
    +@@ fsck.h: int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
    + 						   enum fsck_msg_type msg_type,
    + 						   enum fsck_msg_id msg_id,
    + 						   const char *message);
    ++int fsck_refs_error_function(struct fsck_options *options,
     +			     const struct object_id *oid,
     +			     enum object_type object_type,
     +			     const char *checked_ref_name,
    @@ fsck.h: int fsck_error_cb_print_missing_gitmodules(struct fsck_objects_options *
     +			     enum fsck_msg_id msg_id,
     +			     const char *message);
      
    - struct fsck_options {
    - 	fsck_error error_func;
    -@@ fsck.h: struct fsck_options {
      struct fsck_refs_options {
    - 	struct fsck_options fsck_options;
    - };
    + 	unsigned verbose:1;
    +@@ fsck.h: struct fsck_options {
    + 		.gitattributes_done = OIDSET_INIT, \
    + 	} \
    + }
     +#define FSCK_REFS_OPTIONS_DEFAULT { \
    -+	.fsck_options = { \
    -+		.error_func = fsck_refs_error_function, \
    -+	}, \
    ++	.error_func = fsck_refs_error_function, \
     +}
     +#define FSCK_REFS_OPTIONS_STRICT { \
    -+	.fsck_options = { \
    -+		.error_func = fsck_refs_error_function, \
    -+		.strict = 1, \
    -+	}, \
    ++	.strict = 1, \
    ++	.error_func = fsck_refs_error_function, \
     +}
      
    - struct fsck_objects_options {
    - 	struct fsck_options fsck_options;
    + /* descend in all linked child objects
    +  * the return value is:
 7:  2ecd1f5407 !  6:  85aa953f6d refs: set up ref consistency check infrastructure
    @@ refs.c: int check_refname_format(const char *refname, int flags)
      	return check_or_sanitize_refname(refname, flags, NULL);
      }
      
    -+int refs_fsck(struct ref_store *refs, struct fsck_refs_options *o)
    ++int refs_fsck(struct ref_store *refs, struct fsck_options *o)
     +{
     +	return refs->be->fsck(refs, o);
     +}
    @@ refs.h
      
      #include "commit.h"
      
    -+struct fsck_refs_options;
    ++struct fsck_options;
      struct object_id;
      struct ref_store;
      struct repository;
    @@ refs.h: int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void
     + * reflogs are consistent, and non-zero otherwise. The errors will be
     + * written to stderr.
     + */
    -+int refs_fsck(struct ref_store *refs, struct fsck_refs_options *o);
    ++int refs_fsck(struct ref_store *refs, struct fsck_options *o);
     +
      /*
       * Apply the rules from check_refname_format, but mutate the result until it
    @@ refs/debug.c: static int debug_reflog_expire(struct ref_store *ref_store, const
      }
      
     +static int debug_fsck(struct ref_store *ref_store,
    -+		      struct fsck_refs_options *o)
    ++		      struct fsck_options *o)
     +{
     +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
     +	int res = drefs->refs->be->fsck(drefs->refs, o);
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
      }
      
     +static int files_fsck(struct ref_store *ref_store,
    -+		      struct fsck_refs_options *o)
    ++		      struct fsck_options *o)
     +{
     +	int ret;
     +	struct files_ref_store *refs =
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
      }
      
     +static int packed_fsck(struct ref_store *ref_store,
    -+		       struct fsck_refs_options *o)
    ++		       struct fsck_options *o)
     +{
     +	return 0;
     +}
    @@ refs/refs-internal.h: typedef int read_raw_ref_fn(struct ref_store *ref_store, c
      				 struct strbuf *referent);
      
     +typedef int fsck_fn(struct ref_store *ref_store,
    -+		    struct fsck_refs_options *o);
    ++		    struct fsck_options *o);
     +
      struct ref_storage_be {
      	const char *name;
    @@ refs/reftable-backend.c: static int reftable_be_reflog_expire(struct ref_store *
      }
      
     +static int reftable_be_fsck(struct ref_store *ref_store,
    -+			    struct fsck_refs_options *o)
    ++			    struct fsck_options *o)
     +{
     +	return 0;
     +}
 8:  534a3d00af !  7:  ce7adc7372 builtin/refs: add verify subcommand
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
      
     +static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
     +{
    -+	struct fsck_refs_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
    ++	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
     +	const char * const verify_usage[] = {
     +		REFS_VERIFY_USAGE,
     +		NULL,
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
     +		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
     +		OPT_END(),
     +	};
    ++	int ret = 0;
     +
     +	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
     +	if (argc)
     +		usage(_("too many arguments"));
     +
     +	if (verbose)
    -+		fsck_refs_options.fsck_options.verbose = 1;
    ++		fsck_refs_options.refs_options.verbose = 1;
     +	if (strict)
    -+		fsck_refs_options.fsck_options.strict = 1;
    ++		fsck_refs_options.strict = 1;
     +
    -+	git_config(git_fsck_config, &fsck_refs_options.fsck_options);
    ++	git_config(git_fsck_config, &fsck_refs_options);
     +	prepare_repo_settings(the_repository);
     +
    -+	return refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
    ++	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
    ++
    ++	/*
    ++	 * Explicitly free the allocated array and "oid_skiplist"
    ++	 */
    ++	free(fsck_refs_options.msg_type);
    ++	oidset_clear(&fsck_refs_options.oid_skiplist);
    ++	return ret;
     +}
     +
      int cmd_refs(int argc, const char **argv, const char *prefix)
 9:  054c8cea89 =  8:  035eafe10b builtin/fsck: add `git-refs verify` child process
10:  7f87c6a26e !  9:  9398bf3f0d files-backend: add unified interface for refs scanning
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     + * the whole directory. This function is used as the callback for each
     + * regular file or symlink in the directory.
     + */
    -+typedef int (*files_fsck_refs_fn)(struct fsck_refs_options *o,
    ++typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
     +				  const char *gitdir,
     +				  const char *refs_check_dir,
     +				  struct dir_iterator *iter);
     +
     +static int files_fsck_refs_dir(struct ref_store *ref_store,
    -+			       struct fsck_refs_options *o,
    ++			       struct fsck_options *o,
     +			       const char *refs_check_dir,
     +			       files_fsck_refs_fn *fsck_refs_fns)
     +{
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +			continue;
     +		} else if (S_ISREG(iter->st.st_mode) ||
     +			   S_ISLNK(iter->st.st_mode)) {
    -+			if (o->fsck_options.verbose)
    ++			if (o->refs_options.verbose)
     +				fprintf_ln(stderr, "Checking %s/%s",
     +					   refs_check_dir, iter->relative_path);
     +			for (size_t i = 0; fsck_refs_fns[i]; i++) {
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +}
     +
     +static int files_fsck_refs(struct ref_store *ref_store,
    -+			   struct fsck_refs_options *o)
    ++			   struct fsck_options *o)
     +{
     +	int ret;
     +	files_fsck_refs_fn fsck_refs_fns[]= {
     +		NULL
     +	};
     +
    -+	if (o->fsck_options.verbose)
    ++	if (o->refs_options.verbose)
     +		fprintf_ln(stderr, "Checking references consistency");
     +
     +	ret = files_fsck_refs_dir(ref_store, o, "refs", fsck_refs_fns);
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +}
     +
      static int files_fsck(struct ref_store *ref_store,
    - 		      struct fsck_refs_options *o)
    + 		      struct fsck_options *o)
      {
     @@ refs/files-backend.c: static int files_fsck(struct ref_store *ref_store,
      	struct files_ref_store *refs =
11:  7d78014e5f ! 10:  046773e35c fsck: add ref name check for files backend
    @@ fsck.h: enum fsck_msg_type {
      	FUNC(BAD_TREE_SHA1, ERROR) \
     
      ## refs/files-backend.c ##
    -@@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct fsck_refs_options *o,
    +@@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
      				  const char *refs_check_dir,
      				  struct dir_iterator *iter);
      
    -+static int files_fsck_refs_name(struct fsck_refs_options *o,
    ++static int files_fsck_refs_name(struct fsck_options *o,
     +				const char *gitdir UNUSED,
     +				const char *refs_check_dir,
     +				struct dir_iterator *iter)
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct fsck_refs_options
     +}
     +
      static int files_fsck_refs_dir(struct ref_store *ref_store,
    - 			       struct fsck_refs_options *o,
    + 			       struct fsck_options *o,
      			       const char *refs_check_dir,
     @@ refs/files-backend.c: static int files_fsck_refs(struct ref_store *ref_store,
      {
12:  16209a73ed ! 11:  c9b9599589 fsck: add ref content check for files backend
    @@ refs/files-backend.c: int parse_loose_ref_contents(const char *buf, struct objec
      	return 0;
      }
      
    -@@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_refs_options *o,
    +@@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
      	return ret;
      }
      
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_refs_options *
     + * would be the content after "refs:". For symblic link, "pointee_name" would
     + * be the relative path agaignst "gitdir".
     + */
    -+static int files_fsck_symref_target(struct fsck_refs_options *o,
    ++static int files_fsck_symref_target(struct fsck_options *o,
     +				    const char *refname,
     +				    const char *pointee_name,
     +				    const char *pointee_path)
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_refs_options *
     +	return ret;
     +}
     +
    -+static int files_fsck_refs_content(struct fsck_refs_options *o,
    ++static int files_fsck_refs_content(struct fsck_options *o,
     +				   const char *gitdir,
     +				   const char *refs_check_dir,
     +				   struct dir_iterator *iter)
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_refs_options *
     +}
     +
      static int files_fsck_refs_dir(struct ref_store *ref_store,
    - 			       struct fsck_refs_options *o,
    + 			       struct fsck_options *o,
      			       const char *refs_check_dir,
     @@ refs/files-backend.c: static int files_fsck_refs(struct ref_store *ref_store,
      	int ret;
-- 
2.45.2

