Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9DF40847
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467517; cv=none; b=sNP0xMGXGBgJPoMuiU/5sqEwmgvUH2gV6QADzcPUUd8HK+UBz5hQwcBff6O/mpGLOzaUYiDFcKsP15MtG1/IroFjZ2In28DJtqemvQbMPLjCcgmoW+r1ffCv6BokjZChqQuevKGZ0zW3nDDTI6rlGPLdrC/pMSMT0Evd9I8vbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467517; c=relaxed/simple;
	bh=Rw019N3GXKjxKaBgkIYn7bEuUIFHxNk8clgmdX3ZwE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJuHqNpZI5VOUpucdno8Qg5CtVpHfkzf0emeK0IN431bQN9dn+v4Y8oV5PG+cLgExZwlsCRt3iVnkYQN/9mgNXOvvAuRgWrLnIrOTPJdj7uaY/nAcrEtHM4PDInYlCewAQ/T9ELOuw3b8dugG7a7g+GbIa9NlagKhgckJCOWNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfNsnRjS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfNsnRjS"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb50bcabd1so1454297a91.2
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721467514; x=1722072314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+YInEpwAnxqj0A3Ehw95x8k2fcOLNI18qiHU//alHM=;
        b=LfNsnRjSA4dw9tmxaWu6Uzm6CprxuQeVoBBaUigscLBhAcg+tbv/1AIRy4bVODdrLk
         6WyxbTbPD1QbLBuYAqUMCifmglmnOX6vJdM5OMX/durjWE0JfEajm2eJDawdsf36YV6B
         glLJtwxwLCg0V1PqoKk5YbR51oL/1r5AyAwBTj6SnZfF5G8+8A7LMMZdm1Omsc313zwF
         fkI8fNKiNEeTghxpgCWLkBmJI7gtVkm1h647lrhlCiXeY/FncZKpSwRSctwjzRlSCqCI
         gdH4EOZbW1IoqtYRLmcvm0y1VZzsi+SMVMxLOwkxrwhcXxFbzDOGd/dhfBbarM9Ee2P8
         gWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721467514; x=1722072314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+YInEpwAnxqj0A3Ehw95x8k2fcOLNI18qiHU//alHM=;
        b=ZBReV8dsaWT0sfqK9aDpTAyisdll/3hgdGK3XRzpi10txScWuZmx9CEa1uqz3TV1Ew
         CI1dlINXs206bnJYHjvl2stFB1xZzFD+xfsiujUsPmPKScFbE7ASPn1OEzzT/M+wpd/A
         pe5c+krDXuOt0MOgSGnyH02UDe2Vw7Bj4Lj7HlUpw/WfAWoMogUIr0FXr9Wps0fgcDhH
         uSJkWAd8f2ccqk/4e7xaT0ZiAjkx5ido3xzfFzZ0ntkkjpUIyicuSGWrcPEL572xIgyI
         PbUCX8T9XX7YPWCDppPVM/GFkIN/EbjgpSteu4kL1fNtIQ7oRIBso/yMf+1MK7aPEw+Y
         lFKg==
X-Gm-Message-State: AOJu0Yy5nLa99KYL+RrcGx9lTC6697LjOpreigPzxx8dThsf+uKGK2Rn
	L8UgAJYG6mzqqckUE1CDxybAIKttmldUfICXY5FOQE5QtS/PUVsZZp6wxA==
X-Google-Smtp-Source: AGHT+IFEuJtJBTCzoz+R+S1f68bzttP4k9cJuVLpv+6cXNxykM6gg29nvv5m7l4GoA0cJAKjpyqFzQ==
X-Received: by 2002:a17:90a:2dc7:b0:2cc:f2c1:88fb with SMTP id 98e67ed59e1d1-2cd2740d630mr529991a91.16.1721467513580;
        Sat, 20 Jul 2024 02:25:13 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b2d0f6sm3096825a91.1.2024.07.20.02.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 02:25:13 -0700 (PDT)
Date: Sat, 20 Jul 2024 17:25:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v12 00/10] ref consistency check infra setup
Message-ID: <ZpuCg1GL1YE_sJBP@ArchLinux>
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

Hi All:

This version handles the following problem:

In order to provide more extensibility, I follow the Karthik's advice
using the following data structure:

  struct fsck_refs_info {
    char *ref_checkee;
    union {
      struct {
        char *sub_ref_checkee;
      } files;
    };
  };

Because we use a `struct` here, we could add more fields when we want to
implement morec checks without changing the existing functions. And I
move this structure into the "fsck_options". Thus there is no need for
us to change the "error_func" prototype which makes this series more
clearer.

And Karthik asked me why I does not handle the trailing garbage for
symbolic refs. And I cited my understanding here:

> The "parse_loose_ref_contents" will return the referent. In this function,
> it will skip the prefix "ref:" to get the pointee. If there are some trailing
> garbage, it will be reported by the "files_fsck_symref_target".

> "files_fsck_symref_target" will use "check_refname_format" function
> to check the pointee. For example, if the content is "ref: refs/heads/
> master garbage". The "refs/heads/master garbage" is a bad name.

> However, in my design, the trailing spaces or newline will be ignored,
> I thought we may not report this problem. And I use "strbuf_rtrim" here
> to ignore spaces and newlines.

We should not report this even with warning in my perspecitve.

CI: https://github.com/shejialuo/git/pull/10

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
 builtin/fsck.c                |  31 ++++-
 builtin/refs.c                |  44 ++++++
 fsck.c                        | 106 +++++++++++---
 fsck.h                        |  74 +++++++---
 refs.c                        |   7 +-
 refs.h                        |   8 ++
 refs/debug.c                  |  11 ++
 refs/files-backend.c          | 253 +++++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 ++
 refs/refs-internal.h          |  11 +-
 refs/reftable-backend.c       |   8 ++
 t/t0602-reffiles-fsck.sh      | 211 ++++++++++++++++++++++++++++
 14 files changed, 746 insertions(+), 51 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Range-diff against v11:
 1:  a69705b777 =  1:  a69705b777 fsck: rename "skiplist" to "skip_oids"
 2:  1ef1036348 <  -:  ---------- fsck: add a unified interface for reporting fsck messages
 -:  ---------- >  2:  a4bfccd938 fsck: add a unified interface for reporting fsck messages
 3:  d17cf6166e !  3:  9bc8892761 fsck: rename objects-related fsck error functions
    @@ builtin/fsck.c: static int objerror(struct object *obj, const char *err)
     -static int fsck_error_func(struct fsck_options *o UNUSED,
     -			   const struct object_id *oid,
     -			   enum object_type object_type,
    --			   const char *ref_checkee UNUSED,
    --			   const char *sub_ref_checkee UNUSED,
     -			   enum fsck_msg_type msg_type,
     -			   enum fsck_msg_id msg_id UNUSED,
     -			   const char *message)
     +static int fsck_objects_error_func(struct fsck_options *o UNUSED,
     +				   const struct object_id *oid,
     +				   enum object_type object_type,
    -+				   const char *ref_checkee UNUSED,
    -+				   const char *sub_ref_checkee UNUSED,
     +				   enum fsck_msg_type msg_type,
     +				   enum fsck_msg_id msg_id UNUSED,
     +				   const char *message)
    @@ fsck.c: int fsck_buffer(const struct object_id *oid, enum object_type type,
     -int fsck_error_function(struct fsck_options *o,
     -			const struct object_id *oid,
     -			enum object_type object_type UNUSED,
    --			const char *ref_checkee UNUSED,
    --			const char *sub_ref_checkee UNUSED,
     -			enum fsck_msg_type msg_type,
     -			enum fsck_msg_id msg_id UNUSED,
     -			const char *message)
     +int fsck_objects_error_function(struct fsck_options *o,
     +				const struct object_id *oid,
     +				enum object_type object_type UNUSED,
    -+				const char *ref_checkee UNUSED,
    -+				const char *sub_ref_checkee UNUSED,
     +				enum fsck_msg_type msg_type,
     +				enum fsck_msg_id msg_id UNUSED,
     +				const char *message)
    @@ fsck.c: int git_fsck_config(const char *var, const char *value,
     -int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
     -					   const struct object_id *oid,
     -					   enum object_type object_type,
    --					   const char *ref_checkee,
    --					   const char *sub_ref_checkee,
     -					   enum fsck_msg_type msg_type,
     -					   enum fsck_msg_id msg_id,
     -					   const char *message)
     +int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
     +						   const struct object_id *oid,
     +						   enum object_type object_type,
    -+						   const char *ref_checkee,
    -+						   const char *sub_ref_checkee,
     +						   enum fsck_msg_type msg_type,
     +						   enum fsck_msg_id msg_id,
     +						   const char *message)
    @@ fsck.c: int git_fsck_config(const char *var, const char *value,
      		puts(oid_to_hex(oid));
      		return 0;
      	}
    --	return fsck_error_function(o, oid, object_type, ref_checkee,
    --				   sub_ref_checkee, msg_type, msg_id, message);
    -+	return fsck_objects_error_function(o, oid, object_type, ref_checkee,
    -+					   sub_ref_checkee, msg_type, msg_id,
    -+					   message);
    +-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
    ++	return fsck_objects_error_function(o, oid, object_type,
    ++					   msg_type, msg_id, message);
      }
     
      ## fsck.h ##
    @@ fsck.h: typedef int (*fsck_error)(struct fsck_options *o,
      
     -int fsck_error_function(struct fsck_options *o,
     -			const struct object_id *oid, enum object_type object_type,
    --			const char *ref_checkee, const char *sub_ref_checkee,
     -			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
     -			const char *message);
     -int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
     -					   const struct object_id *oid,
     -					   enum object_type object_type,
    --					   const char *ref_checkee,
    --					   const char *sub_ref_checkee,
     -					   enum fsck_msg_type msg_type,
     -					   enum fsck_msg_id msg_id,
     -					   const char *message);
     +int fsck_objects_error_function(struct fsck_options *o,
     +				const struct object_id *oid, enum object_type object_type,
    -+				const char *ref_checkee, const char *sub_ref_checkee,
     +				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
     +				const char *message);
     +int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
     +						   const struct object_id *oid,
     +						   enum object_type object_type,
    -+						   const char *ref_checkee,
    -+						   const char *sub_ref_checkee,
     +						   enum fsck_msg_type msg_type,
     +						   enum fsck_msg_id msg_id,
     +						   const char *message);
      
    - struct fsck_options {
    - 	fsck_walk_func walk;
    + /*
    +  * The information for reporting refs-related error message
     @@ fsck.h: struct fsck_options {
      	.gitmodules_done = OIDSET_INIT, \
      	.gitattributes_found = OIDSET_INIT, \
 4:  19e049ee15 !  4:  82296dc2b9 fsck: add refs-related error report function
    @@ Commit message
         fsck: add refs-related error report function
     
         Create refs-specific "error_func" callback "fsck_refs_error_function"
    -    which could provide the following report messages.
    +    which could provide the following report messages for files backend
     
         1. "ref_checkee": "fsck error name": "user message".
         2. "ref_checkee.sub_ref_checkee": "fsck error name": "user message".
    @@ Commit message
            message".
     
         "fsck_refs_error_function" uses the "ref_checkee" and "sub_ref_checkee"
    -    parameters to indicate the information of the checked refs. For loose
    -    ref and reflog, it only uses the "ref_checkee" parameter. For packed
    +    in the "fsck_refs_info" to indicate the information of the checked refs.
    +    For loose ref and reflog, it only uses the "ref_checkee". For packed
         refs and reftable refs, when checking the consistency of the file
    -    itself, it still only uses "ref_checkee" parameter. However, when
    -    checking the consistency of the ref or reflog contained in the file, it
    -    will use "sub_ref_checkee" parameter to indicate that we are not
    -    checking the file but the incorporated ref or reflog.
    +    itself, it still only uses "ref_checkee". However, when checking the
    +    consistency of the ref or reflog contained in the file ,it will use the
    +    "sub_ref_checkee" to indicate that we are not checking the file but the
    +    incorporated ref or reflog.
     
         "fsck_refs_error_function" will use the "oid" parameter if the caller
         passes the oid, it will use "oid_to_hex" to get the corresponding hex
    @@ fsck.c: int fsck_objects_error_function(struct fsck_options *o,
      	return 1;
      }
      
    -+int fsck_refs_error_function(struct fsck_options *options UNUSED,
    ++int fsck_refs_error_function(struct fsck_options *options,
     +			     const struct object_id *oid,
     +			     enum object_type object_type UNUSED,
    -+			     const char *ref_checkee,
    -+			     const char *sub_ref_checkee,
     +			     enum fsck_msg_type msg_type,
     +			     enum fsck_msg_id msg_id UNUSED,
     +			     const char *message)
     +{
     +	struct strbuf sb = STRBUF_INIT;
    ++	struct fsck_refs_info *refs_info = &options->refs_info;
     +	int ret = 0;
     +
    -+	if (sub_ref_checkee)
    -+		strbuf_addf(&sb, "%s.%s", ref_checkee, sub_ref_checkee);
    -+	else
    -+		strbuf_addstr(&sb, ref_checkee);
    ++	if (the_repository->ref_storage_format == REF_STORAGE_FORMAT_FILES) {
    ++		strbuf_addstr(&sb, refs_info->ref_checkee);
    ++		if (refs_info->u.files.sub_ref_checkee)
    ++			strbuf_addf(&sb, ".%s", refs_info->u.files.sub_ref_checkee);
     +
    -+	if (oid)
    -+		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
    ++		if (oid)
    ++			strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
    ++	}
     +
     +	if (msg_type == FSCK_WARN)
     +		warning("%s: %s", sb.buf, message);
    @@ fsck.h: int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *
     +int fsck_refs_error_function(struct fsck_options *options,
     +			     const struct object_id *oid,
     +			     enum object_type object_type,
    -+			     const char *ref_checkee,
    -+			     const char *sub_ref_checkee,
     +			     enum fsck_msg_type msg_type,
     +			     enum fsck_msg_id msg_id,
     +			     const char *message);
      
    - struct fsck_options {
    - 	fsck_walk_func walk;
    + /*
    +  * The information for reporting refs-related error message
     @@ fsck.h: struct fsck_options {
      	.gitattributes_done = OIDSET_INIT, \
      	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 5:  f175afc37c =  5:  c5cac2e318 refs: set up ref consistency check infrastructure
 6:  e177157faa !  6:  84d840506e git refs: add verify subcommand
    @@ fsck.h: struct fsck_options {
      	unsigned strict:1;
     +	unsigned verbose:1;
      	enum fsck_msg_type *msg_type;
    + 	struct fsck_refs_info refs_info;
      	struct oidset skip_oids;
    - 	struct oidset gitmodules_found;
 7:  ee0e322f2b =  7:  3fc77ec329 builtin/fsck: add `git-refs verify` child process
 8:  6a04fb0170 =  8:  44a75141fa files-backend: add unified interface for refs scanning
 9:  7d11836deb !  9:  4a0d58b07d fsck: add ref name check for files backend
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
     +
     +	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
     +		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
    -+		ret = fsck_refs_report(o, NULL, sb.buf, NULL,
    ++		o->refs_info.ref_checkee = sb.buf;
    ++		ret = fsck_refs_report(o, NULL,
     +				       FSCK_MSG_BAD_REF_NAME,
     +				       "invalid refname format");
     +	}
10:  ad696852ba ! 10:  c529670e54 fsck: add ref content check for files backend
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +
     +	if (!skip_prefix(pointee_name, "refs/", &p)) {
     +
    -+		ret = fsck_refs_report(o, NULL, refname, NULL,
    ++		ret = fsck_refs_report(o, NULL,
     +				       FSCK_MSG_BAD_SYMREF_POINTEE,
     +				       "point to target out of refs hierarchy");
     +		goto out;
     +	}
     +
     +	if (check_refname_format(pointee_name, 0)) {
    -+		ret = fsck_refs_report(o, NULL, refname, NULL,
    ++		ret = fsck_refs_report(o, NULL,
     +				       FSCK_MSG_BAD_SYMREF_POINTEE,
     +				       "point to invalid refname");
     +	}
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +		goto out;
     +
     +	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
    -+		ret = fsck_refs_report(o, NULL, refname, NULL,
    ++		ret = fsck_refs_report(o, NULL,
     +				       FSCK_MSG_BAD_SYMREF_POINTEE,
     +				       "point to invalid target");
     +		goto out;
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +	int ret = 0;
     +
     +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
    ++	o->refs_info.ref_checkee = refname.buf;
     +
     +	/*
     +	 * If the file is a symlink, we need to only check the connectivity
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +
     +		if (!skip_prefix(pointee_path.buf,
     +				 abs_gitdir.buf, &pointee_name)) {
    -+			ret = fsck_refs_report(o, NULL, refname.buf, NULL,
    ++			ret = fsck_refs_report(o, NULL,
     +					       FSCK_MSG_BAD_SYMREF_POINTEE,
     +					       "point to target outside gitdir");
     +			goto clean;
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +	if (parse_loose_ref_contents(ref_content.buf, &oid,
     +				     &referent, &type,
     +				     &failure_errno, &trailing)) {
    -+		ret = fsck_refs_report(o, NULL, refname.buf, NULL,
    ++		ret = fsck_refs_report(o, NULL,
     +				       FSCK_MSG_BAD_REF_CONTENT,
     +				       "invalid ref content");
     +		goto clean;
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +					       pointee_path.buf);
     +		goto clean;
     +	} else {
    -+		/*
    -+		 * Only regular refs could have a trailing garbage. Should
    -+		 * be reported as a warning.
    -+		 */
     +		if (trailing && (*trailing != '\0' && *trailing != '\n')) {
    -+			ret = fsck_refs_report(o, NULL, refname.buf, NULL,
    ++			ret = fsck_refs_report(o, NULL,
     +					       FSCK_MSG_TRAILING_REF_CONTENT,
     +					       "trailing garbage in ref");
     +			goto clean;
-- 
2.45.2

