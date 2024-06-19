Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15FB7603A
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782671; cv=none; b=NPJVOipJlMg0sCyggc7VPCTysJiGGdK9LNIOWae+fBmCLvrmcLE0bFdqZSYDI4/3ZzXJ1IqPEEAEO44n8jjx2gY8ZmObCDZVmHFezlNx09sdR7J72ZuiBRfr1vVnJ3xGyWVA+tN3QS2CZ/eXd8xVWsDDX+vFdSPTw2Cdoz6gxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782671; c=relaxed/simple;
	bh=FUBR8OIPLKbqQK6IE91ccl9MFjuXnrcFlhEO790tyGE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=chA6x56fRb6Q6lj6H/rcKaMTttWMb1hj9wTnz4VjnHxOmgiG4NVVtfi/wro4cN/yjvnL9EZmLf/p2cF9+2SJkjEm6Qm9MQvKyWj50bVJJPSx0Xwuhn7GQhujayx6o8Sz/sNJFeSBTKvJr0qzL08PJaoWdRrIU2SeMbflXHFi6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRUuozFx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRUuozFx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6a837e9a3so40298545ad.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 00:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718782668; x=1719387468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1A95brSisQRIN1NRBUXD3Oy80O3+ZC7LKxF3dRtzIXQ=;
        b=ZRUuozFx1ucibU/J23QciEV140oxDztFbFX9o4AHCchRztcvRQk95RxszbsxrWhW6f
         KPQXt5u5EUrvXW6JeacNwxiRSbBtxfv+zIKrvPTouk3CvLaDPyaeCIbitW/S3/ZvjpDm
         /dL86AI77im4lZOYq0xRjF2PSAJJuCJcxoAlLIendinYh/KmCJqyW8/tSNG6ALWpiOyx
         bXDXT9XBRZ0M+twQ4gPe2shWZdlY4EClj5hgSkuvfaFw1TgFanQbDHEf6PWSPiYVquAL
         D2KMpsuPwFbUHcHFOh+ldTMGDLcRS8cq/G6Ohoj3E7bSU/m0A2/101+SJyZEWgWAG1Ok
         9lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782668; x=1719387468;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1A95brSisQRIN1NRBUXD3Oy80O3+ZC7LKxF3dRtzIXQ=;
        b=kwP3qb4uISesSmqKGSpSlbIB58Ek4foXeQGEZJ8Tvd6SLzUV3LxAOHkrvhnLsuPv7P
         49A1xkUN3hgkzisIsiR3c8jDAdIhWQwHhSAHcGmw+I1+Baz32am9k0bJf9WqxntdYk4n
         I6lUIqSgV7NEbn4B/75QZn7EgJqszPEhrPcf9aYt5mAczoRey/YdC6HIzlWqQl6G4fwz
         LyrWM+RnoUp9GRdnIW+5zdPn6c6ivJN82CncH3TKlQAprQvPvgDHFgkmm+Omik9PYaOD
         EAH0KiB/rjTDmp7X/PpwM20/LL9ACxd+AAKy81E9FBDJX2nTtEns6rLsX3piM7rXXrqR
         IQ8w==
X-Gm-Message-State: AOJu0YwzeEoMNbHFLE+ORfU4ODLRgalZfvsswwhYmWHhS4/noMnsde6A
	2VF0t7j/VJSWqds8qwwy6VGcmmrhc9WEnF6ecUsdqajIU1foS8Rpd85I1Q==
X-Google-Smtp-Source: AGHT+IGamyq6ao2IT3YDOqaxNtwm9LWDIRF/4BTqkmarr6EcPRFcHoFJdv8thC0di5rHH0aAQVMKwg==
X-Received: by 2002:a17:902:e5c9:b0:1f5:e635:21fc with SMTP id d9443c01a7336-1f9aa3d3d54mr21347865ad.21.1718782668446;
        Wed, 19 Jun 2024 00:37:48 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e7f3fdsm109793055ad.112.2024.06.19.00.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:37:47 -0700 (PDT)
Date: Wed, 19 Jun 2024 15:37:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v4 0/7] ref consistency check infra setup
Message-ID: <ZnKKy52QFO2UhqM6@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>

Hi All:

This version mainly focuses on solving following reviews:

1. As Junio said, it's a bad idea to convert the "fsck_refs_options *"
to "fsck_options *" or convert the "fsck_options *" to
"fsck_refs_options *". So this version, I changed a lot for the first
patch. I refactor the "fsck_options *" which contains refs-specific,
objs-specific and common settings. This designs allows us to use
combination to make the code much more clean.
2. As Karthik said, I should enhance documents for "git refs verify".
This version does this.

And Junio found that the commit the previous series based on is strange.
In order to make our life easier, I change the based on commit. Now it
is based on the top master. And I will always keep the code align with
the master to avoid strange things.

  66ac6e4bcd (The fourteenth batch, 2024-06-17)

Thanks

shejialuo (7):
  fsck: add refs check interfaces to interact with fsck error levels
  refs: set up ref consistency check infrastructure
  builtin/refs: add verify subcommand
  builtin/fsck: add `git-refs verify` child process
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend
  fsck: add ref content check for files backend

 Documentation/fsck-msgids.txt |  12 ++
 Documentation/git-refs.txt    |  13 ++
 builtin/fsck.c                |  25 +++-
 builtin/index-pack.c          |   2 +-
 builtin/mktag.c               |   5 +-
 builtin/refs.c                |  45 ++++++
 builtin/unpack-objects.c      |   2 +-
 fetch-pack.c                  |   8 +-
 fsck.c                        | 113 +++++++++++----
 fsck.h                        |  83 ++++++++---
 object-file.c                 |   2 +-
 refs.c                        |   7 +-
 refs.h                        |   8 ++
 refs/debug.c                  |  11 ++
 refs/files-backend.c          | 255 +++++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 ++
 refs/refs-internal.h          |  11 +-
 refs/reftable-backend.c       |   8 ++
 t/t0602-reffiles-fsck.sh      | 211 ++++++++++++++++++++++++++++
 19 files changed, 765 insertions(+), 64 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Range-diff against v3:
1:  b8d20c4be9 < -:  ---------- fsck: add refs check interfaces to interface with fsck error levels
-:  ---------- > 1:  2d2c1f2cd3 fsck: add refs check interfaces to interact with fsck error levels
2:  c7ed95d6b4 ! 2:  4bacffe44e refs: set up ref consistency check infrastructure
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
    @@ refs/refs-internal.h
      #include "refs.h"
      #include "iterator.h"
      
    -+struct fsck_refs_options;
    ++struct fsck_options;
      struct ref_transaction;
      
      /*
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
3:  373f470fdc ! 3:  f00acab4d1 builtin/refs: add verify subcommand
    @@ Documentation/git-refs.txt: include::ref-storage-format.txt[]
     +
     +--strict::
     +	Enable more strict checking, every WARN severity for the `Fsck Messages`
    -+	be seen as ERROR.
    ++	be seen as ERROR. See linkgit:git-fsck[1].
     +
     +--verbose::
     +	When verifying the reference database consistency, be chatty.
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
     +	};
     +	int ret = 0;
     +	unsigned int verbose = 0, strict = 0;
    -+	struct fsck_refs_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
    ++	struct fsck_options fsck_options = FSCK_OPTIONS_DEFAULT;
     +	struct option options[] = {
     +		OPT__VERBOSE(&verbose, N_("be verbose")),
     +		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
     +		usage(_("too many arguments"));
     +
     +	if (verbose)
    -+		fsck_refs_options.verbose = 1;
    ++		fsck_options.verbose = 1;
     +	if (strict)
    -+		fsck_refs_options.strict = 1;
    ++		fsck_options.strict = 1;
     +
    -+	git_config(git_fsck_refs_config, &fsck_refs_options);
    ++	git_config(git_fsck_config, &fsck_options);
     +	prepare_repo_settings(the_repository);
     +
    -+	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
    ++	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_options);
     +
     +	/*
    -+	 * Explicitly free the allocated array. This is necessary because
    -+	 * this program is executed as child process of git-fsck(1) and the
    -+	 * allocated array may not freed when git-fsck(1) aborts somewhere.
    ++	 * Explicitly free the allocated array and object skiplist set. Because
    ++	 * we reuse `git_fsck_config` here. It will still set the skiplist.
     +	 */
    -+	free(fsck_refs_options.msg_type);
    ++	free(fsck_options.msg_type);
    ++	oidset_clear(&fsck_options.objs_options.skiplist);
     +	return ret;
     +}
     +
4:  4f8ebea573 = 4:  6494f5b0c2 builtin/fsck: add `git-refs verify` child process
5:  6062b3b453 ! 5:  2c064f4f71 files-backend: add unified interface for refs scanning
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
     +}
     +
     +static int files_fsck_refs(struct ref_store *ref_store,
    -+			   struct fsck_refs_options *o)
    ++			   struct fsck_options *o)
     +{
     +	int ret;
     +	files_fsck_refs_fn fsck_refs_fns[]= {
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +}
     +
      static int files_fsck(struct ref_store *ref_store,
    - 		      struct fsck_refs_options *o)
    + 		      struct fsck_options *o)
      {
     @@ refs/files-backend.c: static int files_fsck(struct ref_store *ref_store,
      	struct files_ref_store *refs =
6:  87a22f4c7f ! 6:  88b54b9e1a fsck: add ref name check for files backend
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
7:  b945f61ef1 ! 7:  8309a4746a fsck: add ref content check for files backend
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

