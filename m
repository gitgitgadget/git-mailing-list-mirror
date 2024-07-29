Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E1A147C60
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259356; cv=none; b=Jgw14/Qd1wUwfMC60fuu47Exy1oiMT64VA6oKJWV85bO7Re2j9r+KwnZhjERFt0XrVD6tpcd4cPSNWVQyjetrTY/j7ZI5E1LRpkMXGrtihzTMnbzCwEg3RqYB5zFu5K8YmChu0qp0vtRJFZX22OjBY6DivRajPo95PmOIAS861M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259356; c=relaxed/simple;
	bh=UMg9ZnosJdevVN4Yx+U5EkgCKrd73CddgZOhomc3Ia8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAlTBgzucgSlZw+zbtIA5zYuwu/dgLSPihhcKbMbiNdTaxAeoFjkJwS5eFUf4sk3irzQ6wx2j6iaN3hKg2hqsvLJ/TP9tpTHJ9v9gh+AuCsBV3PmIdFYXE7GM2/Mc7Mi/T7sbxN8CKM5g6mOIffzRhKOE28K5U39ydMV8s+KXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0saWh0s; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0saWh0s"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc49c0aaffso17928515ad.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2024 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259353; x=1722864153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iiQt8oOfNlyRKs3uMsRxB93HwK4CUMFdmevR+b+BgwQ=;
        b=C0saWh0smRCaENGhZ6psZ9lz6PIPuSI8avz2zCSTOo52xzz0gb2e+X08h+maHRL5eC
         Onit4vmsaUEJ01w7eO2iTbN2q9pfeFn4HBNIb+VdQecMe8xHhSdn0AgW7OW0BoDUSf+A
         eK3Y7Uv3GitulpWCNuUZK4gcTgqdZYUAjGK9Ps4ImjfKEmGQIYMBhXpQdQHsQaKX6pwG
         b4RLif7WGWxKvqclE3VfAcu9bSDrNeIvzxen20dZqk6Xty3vOnrfNIhp2vwjOPYwBPGp
         64TX00SGv9AIn4sqAMftCwwnN1Yy6kMCc7MS5d6QPnIxXZPRPPShk7Tsni58fzZvR1ZJ
         rIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259353; x=1722864153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiQt8oOfNlyRKs3uMsRxB93HwK4CUMFdmevR+b+BgwQ=;
        b=auNyux8eVY8nzht4glAkSS7Ag6vE4WQCXtcX+yhAXDBADYarNtcWKQewJmrj3cakkB
         /HQdh7Mbi9jZtlX/kunHoID8FoXDQIFJwxmdnGm0izKXpxQlXcFLBdmjKPaALXbNlatD
         2RA1B0ZZgZvJ6ihEfEgnponHc92ZPs5vy0xKg9oOdNR6espQyLFUz9abQiGW6gL1pgPH
         qd9KyZkagtRWvVLF5LwTvFRxnWaDydKFH8tvgBjhrclWQwvH8dpvuv1WuvvwmiKHwgYD
         FiY9aOFke5P5artAg2/GerQm1lbt7qzJpboOjwNoyHkDiW3okthv9M/3ShuYj49yH+k/
         h2vw==
X-Gm-Message-State: AOJu0YxAWeTY7Oc8aOflaK98H/K9ADz9n1xOCr/8SLaGarkE16cHKY1R
	6MNfqcHQDFcmVz+ZdXo3xm5JMEN6Ol/SHCqZXb7VrkoOoYjStsaQu3DA0A==
X-Google-Smtp-Source: AGHT+IGNd9rXpVbdGGsZ6Su4BDOXp/j/9b58YiTY0qP0xihniZBYO1dkR30ZSSsFYGNE2dcK8nVO9g==
X-Received: by 2002:a17:90a:d146:b0:2ca:1c9e:e012 with SMTP id 98e67ed59e1d1-2cf7e09cda9mr5564035a91.6.1722259352947;
        Mon, 29 Jul 2024 06:22:32 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb760e6absm10491235a91.55.2024.07.29.06.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:22:32 -0700 (PDT)
Date: Mon, 29 Jul 2024 21:22:52 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v13 00/10] ref consistency check infra setup
Message-ID: <ZqeXrPROpEg_pRS2@ArchLinux>
References: <ZpuCg1GL1YE_sJBP@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpuCg1GL1YE_sJBP@ArchLinux>

Hi All:

This version mainly focuses on the problem about how should we provide
extensibility for reporting the problem of refs. In patch v10, Junio
asked a question here:

> The error reporting function for refs consistency check was still
> about reporting a problem for a single ref.  I am wondering how
> consistency violations that are not about a single ref should be
> handled.  For example, if refs/packed-backend.c:packed_fsck() finds
> that the file is not sorted properly or has some unparseable garbage
> in it, it is not something you can report as "refs/heads/main is
> broken", but those who are interested in seeing the "reference
> database consistency" verified, it is very much what they want the
> tool to notice.  How would detection of such a breakage that is not
> attributed to a single ref fit in this "ref consistency check
> infrastructure" that was introduced by [05/10]?

Actually, I think that the original parameter "checked_ref_name" is a
bad name which makes the reader think that "we only handle refs". And
this is my fault for this design. However, I misunderstood the Junio's
word and made things complicated.

The patch v11 and v12 wants to solve a problem that we should provide
extensibility for reporting refs problem. However, these two versions
still made things complicated. After an offline meeting with Patrick and
Karthik, we design the following simple flat data structure:

  struct fsck_refs_info {
      const char *path;
  };

It is simple and provides extensibility.

Thanks,
Jialuo

shejialuo (10):
  fsck: rename "skiplist" to "skip_oids"
  fsck: add a unified interface for reporting fsck messages
  fsck: rename objects-related fsck error functions
  fsck: add refs-related error report function
  refs: set up ref consistency check infrastructure
  git refs: add verify subcommand
  builtin/fsck: add `git-refs verify` child process
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend
  fsck: add ref content check for files backend

 Documentation/fsck-msgids.txt |  12 ++
 Documentation/git-refs.txt    |  13 ++
 builtin/fsck.c                |  32 ++++-
 builtin/mktag.c               |   1 +
 builtin/refs.c                |  44 ++++++
 fsck.c                        | 109 +++++++++++----
 fsck.h                        |  74 +++++++---
 object-file.c                 |  11 +-
 refs.c                        |   7 +-
 refs.h                        |   8 ++
 refs/debug.c                  |  11 ++
 refs/files-backend.c          | 251 +++++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 ++
 refs/refs-internal.h          |  11 +-
 refs/reftable-backend.c       |   8 ++
 t/t0602-reffiles-fsck.sh      | 211 ++++++++++++++++++++++++++++
 16 files changed, 754 insertions(+), 57 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Range-diff against v12:
 1:  a69705b777 =  1:  a69705b777 fsck: rename "skiplist" to "skip_oids"
 2:  a4bfccd938 <  -:  ---------- fsck: add a unified interface for reporting fsck messages
 -:  ---------- >  2:  178329d085 fsck: add a unified interface for reporting fsck messages
 3:  9bc8892761 !  3:  341cb841bf fsck: rename objects-related fsck error functions
    @@ builtin/fsck.c: static int objerror(struct object *obj, const char *err)
     -static int fsck_error_func(struct fsck_options *o UNUSED,
     -			   const struct object_id *oid,
     -			   enum object_type object_type,
    +-			   const struct fsck_refs_info *refs_info UNUSED,
     -			   enum fsck_msg_type msg_type,
     -			   enum fsck_msg_id msg_id UNUSED,
     -			   const char *message)
     +static int fsck_objects_error_func(struct fsck_options *o UNUSED,
     +				   const struct object_id *oid,
     +				   enum object_type object_type,
    ++				   const struct fsck_refs_info *refs_info UNUSED,
     +				   enum fsck_msg_type msg_type,
     +				   enum fsck_msg_id msg_id UNUSED,
     +				   const char *message)
    @@ fsck.c: int fsck_buffer(const struct object_id *oid, enum object_type type,
     -int fsck_error_function(struct fsck_options *o,
     -			const struct object_id *oid,
     -			enum object_type object_type UNUSED,
    +-			const struct fsck_refs_info *refs_info UNUSED,
     -			enum fsck_msg_type msg_type,
     -			enum fsck_msg_id msg_id UNUSED,
     -			const char *message)
     +int fsck_objects_error_function(struct fsck_options *o,
     +				const struct object_id *oid,
     +				enum object_type object_type UNUSED,
    ++				const struct fsck_refs_info *refs_info UNUSED,
     +				enum fsck_msg_type msg_type,
     +				enum fsck_msg_id msg_id UNUSED,
     +				const char *message)
    @@ fsck.c: int git_fsck_config(const char *var, const char *value,
     -int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
     -					   const struct object_id *oid,
     -					   enum object_type object_type,
    +-					   const struct fsck_refs_info *refs_info,
     -					   enum fsck_msg_type msg_type,
     -					   enum fsck_msg_id msg_id,
     -					   const char *message)
     +int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
     +						   const struct object_id *oid,
     +						   enum object_type object_type,
    ++						   const struct fsck_refs_info *refs_info,
     +						   enum fsck_msg_type msg_type,
     +						   enum fsck_msg_id msg_id,
     +						   const char *message)
    @@ fsck.c: int git_fsck_config(const char *var, const char *value,
      		puts(oid_to_hex(oid));
      		return 0;
      	}
    --	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
    -+	return fsck_objects_error_function(o, oid, object_type,
    +-	return fsck_error_function(o, oid, object_type, refs_info,
    +-				   msg_type, msg_id, message);
    ++	return fsck_objects_error_function(o, oid, object_type, refs_info,
     +					   msg_type, msg_id, message);
      }
     
    @@ fsck.h: typedef int (*fsck_error)(struct fsck_options *o,
      
     -int fsck_error_function(struct fsck_options *o,
     -			const struct object_id *oid, enum object_type object_type,
    +-			const struct fsck_refs_info *refs_info,
     -			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
     -			const char *message);
     -int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
     -					   const struct object_id *oid,
     -					   enum object_type object_type,
    +-					   const struct fsck_refs_info *refs_info,
     -					   enum fsck_msg_type msg_type,
     -					   enum fsck_msg_id msg_id,
     -					   const char *message);
     +int fsck_objects_error_function(struct fsck_options *o,
     +				const struct object_id *oid, enum object_type object_type,
    ++				const struct fsck_refs_info *refs_info,
     +				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
     +				const char *message);
     +int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
     +						   const struct object_id *oid,
     +						   enum object_type object_type,
    ++						   const struct fsck_refs_info *refs_info,
     +						   enum fsck_msg_type msg_type,
     +						   enum fsck_msg_id msg_id,
     +						   const char *message);
 4:  82296dc2b9 !  4:  b328f3b218 fsck: add refs-related error report function
    @@ Metadata
      ## Commit message ##
         fsck: add refs-related error report function
     
    -    Create refs-specific "error_func" callback "fsck_refs_error_function"
    -    which could provide the following report messages for files backend
    +    Add refs-related options to the "fsck_options", create refs-specific
    +    "error_func" callback "fsck_refs_error_function".
     
    -    1. "ref_checkee": "fsck error name": "user message".
    -    2. "ref_checkee.sub_ref_checkee": "fsck error name": "user message".
    -    3. "ref_checkee -> (oid hex)": "fsck error name": "user message".
    -    4. "ref_checkee.sub_ref_checkee -> (oid hex)": "fsck error name": "user
    -       message".
    -
    -    "fsck_refs_error_function" uses the "ref_checkee" and "sub_ref_checkee"
    -    in the "fsck_refs_info" to indicate the information of the checked refs.
    -    For loose ref and reflog, it only uses the "ref_checkee". For packed
    -    refs and reftable refs, when checking the consistency of the file
    -    itself, it still only uses "ref_checkee". However, when checking the
    -    consistency of the ref or reflog contained in the file ,it will use the
    -    "sub_ref_checkee" to indicate that we are not checking the file but the
    -    incorporated ref or reflog.
    -
    -    "fsck_refs_error_function" will use the "oid" parameter if the caller
    +    "fsck_refs_error_function" will use the "oid" parameter. When the caller
         passes the oid, it will use "oid_to_hex" to get the corresponding hex
         value to report to the caller.
     
    @@ fsck.c: int fsck_objects_error_function(struct fsck_options *o,
     +int fsck_refs_error_function(struct fsck_options *options,
     +			     const struct object_id *oid,
     +			     enum object_type object_type UNUSED,
    ++			     const struct fsck_refs_info *refs_info,
     +			     enum fsck_msg_type msg_type,
     +			     enum fsck_msg_id msg_id UNUSED,
     +			     const char *message)
     +{
     +	struct strbuf sb = STRBUF_INIT;
    -+	struct fsck_refs_info *refs_info = &options->refs_info;
     +	int ret = 0;
     +
    -+	if (the_repository->ref_storage_format == REF_STORAGE_FORMAT_FILES) {
    -+		strbuf_addstr(&sb, refs_info->ref_checkee);
    -+		if (refs_info->u.files.sub_ref_checkee)
    -+			strbuf_addf(&sb, ".%s", refs_info->u.files.sub_ref_checkee);
    ++	strbuf_addstr(&sb, refs_info->path);
     +
    -+		if (oid)
    -+			strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
    -+	}
    ++	if (oid)
    ++		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
     +
     +	if (msg_type == FSCK_WARN)
     +		warning("%s: %s", sb.buf, message);
    @@ fsck.h: int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *
     +int fsck_refs_error_function(struct fsck_options *options,
     +			     const struct object_id *oid,
     +			     enum object_type object_type,
    ++			     const struct fsck_refs_info *refs_info,
     +			     enum fsck_msg_type msg_type,
     +			     enum fsck_msg_id msg_id,
     +			     const char *message);
 5:  c5cac2e318 !  5:  481bffac6e refs: set up ref consistency check infrastructure
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +static int files_fsck(struct ref_store *ref_store,
     +		      struct fsck_options *o)
     +{
    -+	int ret;
     +	struct files_ref_store *refs =
     +		files_downcast(ref_store, REF_STORE_READ, "fsck");
     +
    -+	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
    -+	return ret;
    ++	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
     +}
     +
      struct ref_storage_be refs_be_files = {
 6:  84d840506e !  6:  cea8908338 git refs: add verify subcommand
    @@ fsck.h: struct fsck_options {
      	unsigned strict:1;
     +	unsigned verbose:1;
      	enum fsck_msg_type *msg_type;
    - 	struct fsck_refs_info refs_info;
      	struct oidset skip_oids;
    + 	struct oidset gitmodules_found;
 7:  3fc77ec329 =  7:  2200167bf6 builtin/fsck: add `git-refs verify` child process
 8:  44a75141fa !  8:  c69883be9a files-backend: add unified interface for refs scanning
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +static int files_fsck_refs(struct ref_store *ref_store,
     +			   struct fsck_options *o)
     +{
    -+	int ret;
     +	files_fsck_refs_fn fsck_refs_fns[]= {
     +		NULL
     +	};
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +	if (o->verbose)
     +		fprintf_ln(stderr, "Checking references consistency");
     +
    -+	ret = files_fsck_refs_dir(ref_store, o, "refs", fsck_refs_fns);
    ++	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fns);
     +
    -+	return ret;
     +}
     +
      static int files_fsck(struct ref_store *ref_store,
      		      struct fsck_options *o)
      {
    -@@ refs/files-backend.c: static int files_fsck(struct ref_store *ref_store,
      	struct files_ref_store *refs =
      		files_downcast(ref_store, REF_STORE_READ, "fsck");
      
    --	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
    -+	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o)
    -+	    | files_fsck_refs(ref_store, o);
    -+
    - 	return ret;
    +-	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
    ++	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o) |
    ++	       files_fsck_refs(ref_store, o);
      }
      
    + struct ref_storage_be refs_be_files = {
 9:  4a0d58b07d !  9:  5ce0e7367e fsck: add ref name check for files backend
    @@ Documentation/fsck-msgids.txt
      	(ERROR) A commit object has a bad parent sha1.
      
     +`badRefName`::
    -+	(ERROR) A ref has a bad name.
    ++	(ERROR) A ref has an invalid format.
     +
      `badTagName`::
      	(INFO) A tag has an invalid format.
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
     +				struct dir_iterator *iter)
     +{
     +	struct strbuf sb = STRBUF_INIT;
    ++	struct fsck_refs_info info;
     +	int ret = 0;
     +
     +	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
     +		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
    -+		o->refs_info.ref_checkee = sb.buf;
    -+		ret = fsck_refs_report(o, NULL,
    ++		info.path = sb.buf;
    ++		ret = fsck_refs_report(o, NULL, &info,
     +				       FSCK_MSG_BAD_REF_NAME,
     +				       "invalid refname format");
     +	}
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
      			       struct fsck_options *o,
      			       const char *refs_check_dir,
     @@ refs/files-backend.c: static int files_fsck_refs(struct ref_store *ref_store,
    + 			   struct fsck_options *o)
      {
    - 	int ret;
      	files_fsck_refs_fn fsck_refs_fns[]= {
     +		files_fsck_refs_name,
      		NULL
10:  c529670e54 ! 10:  f77ca18c68 fsck: add ref content check for files backend
    @@ Documentation/fsck-msgids.txt
     +	(ERROR) A ref has a bad content.
     +
      `badRefName`::
    - 	(ERROR) A ref has a bad name.
    + 	(ERROR) A ref has an invalid format.
      
     +`badSymrefPointee`::
     +	(ERROR) The pointee of a symref is bad.
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     + * be the relative path agaignst "gitdir".
     + */
     +static int files_fsck_symref_target(struct fsck_options *o,
    ++				    struct fsck_refs_info *info,
     +				    const char *refname,
     +				    const char *pointee_name,
     +				    const char *pointee_path)
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +
     +	if (!skip_prefix(pointee_name, "refs/", &p)) {
     +
    -+		ret = fsck_refs_report(o, NULL,
    ++		ret = fsck_refs_report(o, NULL, info,
     +				       FSCK_MSG_BAD_SYMREF_POINTEE,
    -+				       "point to target out of refs hierarchy");
    ++				       "points to ref outside the refs directory");
     +		goto out;
     +	}
     +
     +	if (check_refname_format(pointee_name, 0)) {
    -+		ret = fsck_refs_report(o, NULL,
    ++		ret = fsck_refs_report(o, NULL, info,
     +				       FSCK_MSG_BAD_SYMREF_POINTEE,
    -+				       "point to invalid refname");
    ++				       "points to refname with invalid format");
     +	}
     +
     +	if (lstat(pointee_path, &st) < 0)
     +		goto out;
     +
     +	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
    -+		ret = fsck_refs_report(o, NULL,
    ++		ret = fsck_refs_report(o, NULL, info,
     +				       FSCK_MSG_BAD_SYMREF_POINTEE,
    -+				       "point to invalid target");
    ++				       "points to an invalid file type");
     +		goto out;
     +	}
     +out:
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +		      referent = STRBUF_INIT,
     +		      refname = STRBUF_INIT;
     +	const char *trailing = NULL;
    ++	struct fsck_refs_info info;
     +	int failure_errno = 0;
     +	unsigned int type = 0;
     +	struct object_id oid;
     +	int ret = 0;
     +
     +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
    -+	o->refs_info.ref_checkee = refname.buf;
    ++	info.path = refname.buf;
     +
     +	/*
     +	 * If the file is a symlink, we need to only check the connectivity
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +
     +		if (!skip_prefix(pointee_path.buf,
     +				 abs_gitdir.buf, &pointee_name)) {
    -+			ret = fsck_refs_report(o, NULL,
    ++			ret = fsck_refs_report(o, NULL, &info,
     +					       FSCK_MSG_BAD_SYMREF_POINTEE,
     +					       "point to target outside gitdir");
     +			goto clean;
     +		}
     +
    -+		ret = files_fsck_symref_target(o, refname.buf, pointee_name,
    -+					       pointee_path.buf);
    ++		ret = files_fsck_symref_target(o, &info, refname.buf,
    ++					       pointee_name, pointee_path.buf);
     +		goto clean;
     +	}
     +
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +	if (parse_loose_ref_contents(ref_content.buf, &oid,
     +				     &referent, &type,
     +				     &failure_errno, &trailing)) {
    -+		ret = fsck_refs_report(o, NULL,
    ++		ret = fsck_refs_report(o, NULL, &info,
     +				       FSCK_MSG_BAD_REF_CONTENT,
     +				       "invalid ref content");
     +		goto clean;
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +		strbuf_addf(&pointee_path, "%s/%s", gitdir, referent.buf);
     +		strbuf_rtrim(&referent);
     +
    -+		ret = files_fsck_symref_target(o, refname.buf, referent.buf,
    -+					       pointee_path.buf);
    ++		ret = files_fsck_symref_target(o, &info, refname.buf,
    ++					       referent.buf, pointee_path.buf);
     +		goto clean;
     +	} else {
     +		if (trailing && (*trailing != '\0' && *trailing != '\n')) {
    -+			ret = fsck_refs_report(o, NULL,
    ++			ret = fsck_refs_report(o, NULL, &info,
     +					       FSCK_MSG_TRAILING_REF_CONTENT,
     +					       "trailing garbage in ref");
     +			goto clean;
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
      			       struct fsck_options *o,
      			       const char *refs_check_dir,
     @@ refs/files-backend.c: static int files_fsck_refs(struct ref_store *ref_store,
    - 	int ret;
    + {
      	files_fsck_refs_fn fsck_refs_fns[]= {
      		files_fsck_refs_name,
     +		files_fsck_refs_content,
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should be adapted
     +		printf "ref: refs/heads/.branch" > $branch_dir_prefix/branch-2-bad &&
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		error: refs/heads/branch-2-bad: badSymrefPointee: point to invalid refname
    ++		error: refs/heads/branch-2-bad: badSymrefPointee: points to refname with invalid format
     +		EOF
     +		rm $branch_dir_prefix/branch-2-bad &&
     +		test_cmp expect err
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should be adapted
     +		printf "ref: refs/heads" > $branch_dir_prefix/branch-2-bad &&
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		error: refs/heads/branch-2-bad: badSymrefPointee: point to invalid target
    ++		error: refs/heads/branch-2-bad: badSymrefPointee: points to an invalid file type
     +		EOF
     +		rm $branch_dir_prefix/branch-2-bad &&
     +		test_cmp expect err
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should be adapted
     +		printf "ref: logs/maint-v2.45" > $branch_dir_prefix/branch-2-bad &&
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		error: refs/heads/branch-2-bad: badSymrefPointee: point to target out of refs hierarchy
    ++		error: refs/heads/branch-2-bad: badSymrefPointee: points to ref outside the refs directory
     +		EOF
     +		rm $branch_dir_prefix/branch-2-bad &&
     +		test_cmp expect err
-- 
2.45.2

