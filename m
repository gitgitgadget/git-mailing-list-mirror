Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7E158D6A
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528380; cv=none; b=MLCg3ak93SXCOYAKfEi6V8pPtCfyT/qxd7XNi6H814reczybnhd+NQFPrR7PqxxeZayMlRvExyQpSxDrrPYyhTcVYLZk0LQaUmjUSHNoTswT69yoHZQU5F4OD3Q6wKuAR2pT//GoOHOhbZ72gyZfUYQVl8aCr3CBBHqQU23OrCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528380; c=relaxed/simple;
	bh=u82PFHRr4hhjhFBNA8PhR2Y2ic2oPhrbyiW7BmE+qHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAFamczZ/5V41DNreTkae6FQFloX/jt1SNnyCSFMwZyn6boJpM0ytkE6C3rs/CcL7nnhIeiIDZBfItKJjxgARZ/g+2c9esQPEpLQ2qfWi926m20sfYlNh+ZLUi27FLmB+Z4SbQjZFYJB0Eo5resKAMxdpPdm4a0YAlAI28t64y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afb4KN7p; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afb4KN7p"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb4a332622so18826455ad.2
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720528377; x=1721133177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMIlbLHRmFhXBhcpSJCe4CCsiI11OcTXqHgyKEZUY3c=;
        b=afb4KN7pFgfjVMWLHPtS3zr0zOhZrayaDnIwhj/qVjBcaammq5wOr4A95ol9Aolcn7
         jVjRXu7ApTG5xRUAwtccGoXYUE+bnJ5A1rrAaFBGItdfx41tHR+UFvWDtpCzj7Jmc9ds
         FNFP1LQFUDBfh5dWOpEIuPxPhFoytLRK+LMDoX1zFdJHJWLGQkov624nlK2WdupO24bQ
         EQ8zobJqORsCwGZN3R3fyJa20FP8T0CTtMTwsGeMWRdX0t1BR2FOHiFh7yLETPDJm5Ta
         OpiZg2dLb+Owqq/YY9yXy1IBY2v40twqORaTsx+C/uV0yX+teaTmK+KYYiswYKeKAPxk
         mTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720528377; x=1721133177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMIlbLHRmFhXBhcpSJCe4CCsiI11OcTXqHgyKEZUY3c=;
        b=IznQaABw1Yx5BiTzRviTLFG41uyEL/xAm6EL452A1xYA3G67TjYhQOXl2YlobFqJP0
         SVA0upkC1PmxbGAew+zjhonldeISiwuF92tbZwA2QMhb22bNRj18Dniu3OchlckRZWHR
         0bu+K3XLuKqiS0OXfVNHiPRbieob73khKZD22Q1yeaUVlFkmltS8K1nTEqOmvGU07017
         ZYKiFIN5RpJ5hMXSXLQDODHDE7HPYZE99HIAkMAaRk7/d+A2y1BW2yWXcRXa1hBFyPJs
         /ouwYakECQj1WvasjleQsOUD43DsFLzrN7skYg2932FMqWmGgJd+bW4xlv0fbQscVOrN
         jryw==
X-Gm-Message-State: AOJu0YyWLzQ38T2rX9xDjmsK/GWX0WpvtCKXfcuyGGNeuf/cJbFLk0fy
	c4HjVlVLJNiRaDXFcNqSvc05IoIcfAzLCgvhKlg5N1MPKvxXj3oVM+j5eVrX
X-Google-Smtp-Source: AGHT+IFFejJ2scjuSai2XJoe3rtTo/YdBS2S5oBe+4WoyyrIbaocBW8yeiTihtPH2mEI9KxWcEyuVg==
X-Received: by 2002:a17:903:11d1:b0:1fa:2760:c3f3 with SMTP id d9443c01a7336-1fbb6d252a9mr18173245ad.13.1720528376729;
        Tue, 09 Jul 2024 05:32:56 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7faasm15070235ad.136.2024.07.09.05.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:32:56 -0700 (PDT)
Date: Tue, 9 Jul 2024 20:32:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v9 0/9] ref consistency check infra setup
Message-ID: <Zo0sQCBqyxX8dJ-f@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVX6sn2C9VIeZ38@ArchLinux>

Hi All:

This version changes the following things:

1. Instead of using "oid_skiplist", use "skip_oids".
2. In "fsck_refs_error_function", I define a static struct strbuf here,
the reason why I define it to be `static` is that we may call this
function many times. It's a bad idea to allocate memory too frequently.
And we should never free its memory. I made a mistake here, I should
call `strbuf_reset` function every time. So this version, add
"strbuf_reset" to make the behavior correct.

shejialuo (9):
  fsck: rename "skiplist" to "skip_oids"
  fsck: add a unified interface for reporting fsck messages
  fsck: add refs-related options and error report function
  refs: set up ref consistency check infrastructure
  builtin/refs: add verify subcommand
  builtin/fsck: add `git-refs verify` child process
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend
  fsck: add ref content check for files backend

 Documentation/fsck-msgids.txt |  12 ++
 Documentation/git-refs.txt    |  13 ++
 builtin/fsck.c                |  32 ++++-
 builtin/mktag.c               |   1 +
 builtin/refs.c                |  44 ++++++
 fsck.c                        | 108 +++++++++++---
 fsck.h                        |  63 ++++++---
 object-file.c                 |  11 +-
 refs.c                        |   7 +-
 refs.h                        |   8 ++
 refs/debug.c                  |  11 ++
 refs/files-backend.c          | 255 +++++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 ++
 refs/refs-internal.h          |  11 +-
 refs/reftable-backend.c       |   8 ++
 t/t0602-reffiles-fsck.sh      | 211 ++++++++++++++++++++++++++++
 16 files changed, 746 insertions(+), 57 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Range-diff against v8:
 1:  61e475840f !  1:  e044f933de fsck: rename "skiplist" to "oid_skiplist"
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    fsck: rename "skiplist" to "oid_skiplist"
    +    fsck: rename "skiplist" to "skip_oids"
     
         The "skiplist" field in "fsck_options" is related to objects. Because we
         are going to introduce ref consistency check, the "skiplist" name is too
    @@ Commit message
         "skiplist" here. However, the type for "skiplist" is `struct oidset`
         which is totally unsuitable for refs.
     
    -    To avoid above ambiguity, rename "skiplist" to "oid_skiplist".
    +    To avoid above ambiguity, rename "skiplist" to "skip_oids".
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ fsck.c: void fsck_set_msg_types(struct fsck_options *options, const char *values
      			if (equal == len)
      				die("skiplist requires a path");
     -			oidset_parse_file(&options->skiplist, buf + equal + 1,
    -+			oidset_parse_file(&options->oid_skiplist, buf + equal + 1,
    ++			oidset_parse_file(&options->skip_oids, buf + equal + 1,
      					  the_repository->hash_algo);
      			buf += len + 1;
      			continue;
    @@ fsck.c: void fsck_set_msg_types(struct fsck_options *options, const char *values
      			      const struct object_id *oid)
      {
     -	return opts && oid && oidset_contains(&opts->skiplist, oid);
    -+	return opts && oid && oidset_contains(&opts->oid_skiplist, oid);
    ++	return opts && oid && oidset_contains(&opts->skip_oids, oid);
      }
      
      __attribute__((format (printf, 5, 6)))
    @@ fsck.h: struct fsck_options {
      	unsigned strict:1;
      	enum fsck_msg_type *msg_type;
     -	struct oidset skiplist;
    -+	struct oidset oid_skiplist;
    ++	struct oidset skip_oids;
      	struct oidset gitmodules_found;
      	struct oidset gitmodules_done;
      	struct oidset gitattributes_found;
    +@@ fsck.h: struct fsck_options {
    + };
    + 
    + #define FSCK_OPTIONS_DEFAULT { \
    +-	.skiplist = OIDSET_INIT, \
    ++	.skip_oids = OIDSET_INIT, \
    + 	.gitmodules_found = OIDSET_INIT, \
    + 	.gitmodules_done = OIDSET_INIT, \
    + 	.gitattributes_found = OIDSET_INIT, \
 2:  f2576d88a9 !  2:  daaf3d0ffe fsck: add a unified interface for reporting fsck messages
    @@ builtin/mktag.c: static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
     
      ## fsck.c ##
     @@ fsck.c: static int object_on_skiplist(struct fsck_options *opts,
    - 	return opts && oid && oidset_contains(&opts->oid_skiplist, oid);
    + 	return opts && oid && oidset_contains(&opts->skip_oids, oid);
      }
      
     -__attribute__((format (printf, 5, 6)))
    @@ fsck.h: int is_valid_msg_type(const char *msg_id, const char *msg_type);
      struct fsck_options {
      	fsck_walk_func walk;
     @@ fsck.h: struct fsck_options {
    - };
    - 
    - #define FSCK_OPTIONS_DEFAULT { \
    --	.skiplist = OIDSET_INIT, \
    -+	.oid_skiplist = OIDSET_INIT, \
    - 	.gitmodules_found = OIDSET_INIT, \
      	.gitmodules_done = OIDSET_INIT, \
      	.gitattributes_found = OIDSET_INIT, \
      	.gitattributes_done = OIDSET_INIT, \
 3:  c3c2dda50c !  3:  40da85ae30 fsck: add refs-related options and error report function
    @@ fsck.c: int fsck_objects_error_function(struct fsck_options *o,
     +{
     +	static struct strbuf sb = STRBUF_INIT;
     +
    ++	strbuf_reset(&sb);
     +	strbuf_addstr(&sb, checked_ref_name);
     +	if (oid)
     +		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
    @@ fsck.h: int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *
      	unsigned strict:1;
     +	unsigned verbose_refs:1;
      	enum fsck_msg_type *msg_type;
    - 	struct oidset oid_skiplist;
    + 	struct oidset skip_oids;
      	struct oidset gitmodules_found;
     @@ fsck.h: struct fsck_options {
      	.gitattributes_done = OIDSET_INIT, \
 4:  e826dc17ec =  4:  a38ea1b117 refs: set up ref consistency check infrastructure
 5:  33cac4882b !  5:  8320f56e0b builtin/refs: add verify subcommand
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
     +	 * Explicitly free the allocated array and "oid_skiplist"
     +	 */
     +	free(fsck_refs_options.msg_type);
    -+	oidset_clear(&fsck_refs_options.oid_skiplist);
    ++	oidset_clear(&fsck_refs_options.skip_oids);
     +	return ret;
     +}
     +
 6:  32668e3543 =  6:  6614a06ef5 builtin/fsck: add `git-refs verify` child process
 7:  df83b2a990 =  7:  928cc96396 files-backend: add unified interface for refs scanning
 8:  c696c15651 =  8:  4d50d4932f fsck: add ref name check for files backend
 9:  8b0f3aeb9c =  9:  7edb810819 fsck: add ref content check for files backend
-- 
2.45.2

