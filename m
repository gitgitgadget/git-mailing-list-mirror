Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B354433DF
	for <git@vger.kernel.org>; Fri, 31 May 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171226; cv=none; b=meauFeZephW2X4rEUh+9tOI5iDcJtkOLbeLUZF1myca+nbeKWnC3/D7+BjGKE40bv2aFpXyA7XfaMe3eFYGeTlZ/cd9q6b2Brx/iXzSVyrOOIlmoOwI9qG8MdHGBsK4urcbYt4USd+MiGh4WHqaKh6Rnc12MPjFfIGrL+hHHGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171226; c=relaxed/simple;
	bh=HuZ4TC+UKjDOryoeE1Y/3KeMiBXTDz9omKspNTrMf+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCTfZD+GdwDHYD67cXJCZ0q1Je/I/h0CxbZZDyncCgJSnt8JASnOIXAo1zSSBDUXf7kpgtGbCTAocALrCgRBaEH/q+KtgFt5eWFS4yclmmR9TFbgaM2bm4QtQPF2d/cIlw/nOQr1Yj9QDHivWM+G3dmrWWTshm/QSJFvHsSHz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBfqOVLS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBfqOVLS"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-702502098c8so338263b3a.0
        for <git@vger.kernel.org>; Fri, 31 May 2024 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717171224; x=1717776024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hb3qhcDtNI78B8PhdkQ3ZKBNL8DdCACBbQDxuAiv0Z4=;
        b=kBfqOVLSR7K4IBGf3VbEnitl2BYico4zWydL++YQC3Ry+zTSpsZcV8ikrJMFL7n81O
         xFIKm2ShexavVzp7dchmfsVRrY7UMQH9RX3GltIkhmcOjoE4gsH38zaiHYjGr5qbip+T
         FgmECTwWBKqvaYLISy0Dn/jJ50M0zNVtGfx3HiuL1xXIn6XEibIiBdQP4V2qmhS5eq+S
         0DBvkkMl8gxIujaQMqHal8gHKeyzVS2unELrDRNrMHkxkVV0/m6B1RbevvFXVbV7kI1V
         jwBJwzsHjSXD34m5ZK5dRXMnTSJPQCTD7Q0euNgQPjidPDZF02TdThZZkvdmEdCgFanc
         NCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717171224; x=1717776024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb3qhcDtNI78B8PhdkQ3ZKBNL8DdCACBbQDxuAiv0Z4=;
        b=mRGbMFBX3T6PQVVJAK8IWCm9n/anNH48wtbNcUMXc8pA1qNO7vJR1N/48eoFykHOdf
         Ub6jCyPRDnpe2zF2xswHjEGZAGNeUX+3/hWEOSBv6DshXSqSWpwA+1GQAbxJIzMnSLI1
         JP7M0l5an8P0v56b9fnJ3xqQrg3jtfSyIb8a2wflPsDBZQWOl+qyvxpKOzbw+wIv/GZR
         ZatlrkfRR9L0HNtQ6CAEJ+BMFyuBtj6/H8KVo9G05Fv1XP0u2VhpjxiFnxYCsV6nXNb3
         LkJZT09c6WIF0LcXGOd7UybxSwdEUZlTJsK1tz1DJcmhbcnteB748vYxYrqvZskdzkb7
         A7BQ==
X-Gm-Message-State: AOJu0YzOIfSyt0EhLrmgwEzHwSjdW8jYyXZY0oxHaQIDGxXunmLS7m3k
	4AgKz5+QHbvy8IJCJ8DY9pCyXOr4p5MFhEBegAjVqD+fgaW2VTPYdANqfWF5
X-Google-Smtp-Source: AGHT+IHPnhLjXHCtBETVptW1bBP0TSxGYyG1g/NE/GiU5TTZp8J4ErHCLriI0CoKvv5B3N6mNh83FQ==
X-Received: by 2002:a05:6a20:394d:b0:1a7:7358:f108 with SMTP id adf61e73a8af0-1b26f146c01mr2674018637.24.1717171222307;
        Fri, 31 May 2024 09:00:22 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702425d8a5fsm1543581b3a.76.2024.05.31.09.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 09:00:21 -0700 (PDT)
Date: Sat, 1 Jun 2024 00:00:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC][PATCH 2/2] refs: add name and content check for file
 backend
Message-ID: <Zln0ErSydQMZSMhN@ArchLinux>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240530122753.1114818-3-shejialuo@gmail.com>
 <xmqqa5k6jc0s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa5k6jc0s.fsf@gitster.g>

On Fri, May 31, 2024 at 07:23:31AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > +static int files_fsck_refs_content(const char *refs_check_dir,
> > +				struct dir_iterator *iter)
> > +{
> > +	struct strbuf ref_content = STRBUF_INIT;
> 
> The caller makes sure that this gets called only on a regular file,
> so ...
> 
> > +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> 
> ... the use of strbuf_read_file() is fine (i.e. we do not have to
> worry about the iter->path to be pointing at a symbolic link) here.
> 
> > +		error(_("%s/%s: unable to read the ref"), refs_check_dir, iter->basename);
> > +		goto clean;
> > +	}
> > +
> > +	/*
> > +	 * Case 1: check if the ref content length is valid and the last
> > +	 * character is a newline.
> > +	 */
> > +	if (ref_content.len != the_hash_algo->hexsz + 1 ||
> > +			ref_content.buf[ref_content.len - 1] != '\n') {
> 
> Funny indentation.
> 
> 	if (ref_content.len != the_hash_algo->hexsz + 1 ||
> 	    ref_content.buf[ref_content.len - 1] != '\n') {
> 
> Also, we do not want {braces} around a single statement block.
> 

I will clean the code. I am used to applying one extra HT.

> In any case, the two checks are good ONLY for regular refs and not
> for symbolic refs.  The users are free to create symbolic refs next
> to their branches, e.g. here is a way to say, "among the maintenance
> tracks maint-2.30, maint-2.31, ... maint-2.44, maint-2.45, what I
> consider the primary maintenance track is currently maint-2.45":
> 
>     $ git symbolic-ref refs/heads/maint
>     refs/heads/maint-2.45
> 
> and if your directory walk encounters such a symbolic ref, your
> strbuf_read_file() will read something like:
> 
>     $ cat .git/refs/heads/maint
>     ref: refs/heads/maint-2.45
> 

Yes, currently I intentionally ignore the symbolic ref. My original idea
was to make this patch as small as possible to set up the infrastructure
of the ref consistence check.

So this is why I only choose "refs/heads" and "refs/tags" at current.
The "refs/remote" will contain "HEAD" which is a symbolic ref. So I
ignore "refs/remote".

I just thought git would ONLY have one symbolic ref "HEAD". I will add
more patches in the next version to support the symbolic ref checks.

> Also, the caller also needs to be prepared to find a real symbolic
> link that is used as a symbolic ref, but for them you'd need to do a
> readlink() and the expected contents would not have "ref: " prefix,
> so the code to implement actual check would have to be different.
> The way how refs/files-backend.c:read_ref_internal() handles S_ISLNK
> would be illuminating.
> 

I will handle this in the next version. However, I am a little curious
about the reason why people use a real symbolic in git. git has
provided the symbolic ref which should be more consistent and generic
against the OS.

> > +		goto failure;
> > +	}
> > +	/*
> > +	 * Case 2: the content should be range of [0-9a-f].
> > +	 */
> > +	for (size_t i = 0; i < the_hash_algo->hexsz; i++) {
> > +		if (!isdigit(ref_content.buf[i]) &&
> > +				(ref_content.buf[i] < 'a' || ref_content.buf[i] > 'f')) {
> > +			goto failure;
> 
> I do not think it is a good idea to suddenly redefine what a valid
> way to write object names in a loose ref file after ~20 years.
> Given the popularity of Git, I would not be surprised at all if a
> third-party tool or two have been writing their own refs with
> uppercase hexadecimal and we have been happily using them as
> everybody expects.  It is a good idea to be strict when you are a
> producer, and we do write object names always in lowercase hex, but
> we are lenient when consuming what is possibly written by others.
> As long as the hexadecimal string names an existing object
> (otherwise we have a dangling ref which would be another kind of
> error, I presume), it should be at most FSCK_WARN when it does not
> look like what _we_ wrote (e.g., if it uses uppercase hex, or if it
> has extra bytes after the 40-hex (or 64-hex) other than the final
> LF).  If it is shorter, of course that is an outright FSCK_ERROR.
> 

Yes, actually I have done some experiments using git-fsck. I am really
surprised by the fact that the few bytes will cause FSCK_ERROR. But the
situation with extra bytes are OK. I don't know this design is
intentional.

> How well does this interact with the fsck error levels (aka
> fsck_msg_type), by the way?  It should be made to work well if the
> current design does not.
> 

Unfortunately, I totally ignored this. I will try to implement the fsck
error levels in the next version.

> > +		}
> > +	}
> > +
> > +	strbuf_release(&ref_content);
> > +	return 0;
> > +
> > +failure:
> > +	error(_("%s/%s: invalid ref content"), refs_check_dir, iter->basename);
> 
> In addition, when we honor fsck error levels, such an unconditional
> call to "error" may become an issue.  If the user says a certain
> kind of anomaly is tolerated by setting a specific finding to
> FSCK_IGNORE, we should be silent about our finding.
> 

Yes, I will add the code to support this.

> > +clean:
> > +	strbuf_release(&ref_content);
> > +	return -1;
> > +}
> > +
> > +static int files_fsck_refs(struct ref_store *ref_store,
> > +				const char* refs_check_dir,
> > +				files_fsck_refs_fn *fsck_refs_fns)
> > +{
> > +	struct dir_iterator *iter;
> > +	struct strbuf sb = STRBUF_INIT;
> > +	int ret = 0;
> > +	int iter_status;
> > +
> > +	strbuf_addf(&sb, "%s/%s", ref_store->gitdir, refs_check_dir);
> > +
> > +	iter = dir_iterator_begin(sb.buf, 0);
> > +
> > +	/*
> > +	 * The current implementation does not care about the worktree, the worktree
> > +	 * may have no refs/heads or refs/tags directory. Simply return 0 now.
> > +	*/
> > +	if (!iter) {
> > +		return 0;
> > +	}
> > +
> > +	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
> > +		if (S_ISDIR(iter->st.st_mode)) {
> > +			continue;
> > +		} else if (S_ISREG(iter->st.st_mode)) {
> > +			for (files_fsck_refs_fn *fsck_refs_fn = fsck_refs_fns;
> > +					*fsck_refs_fn; fsck_refs_fn++) {
> 
> Funny indentation (again---the patch 2/2 has funny "two extra HT"
> indentation style all over the place).  Write it like so:
> 
> 			for (files_fsck_refs_fn *fn = fsck_refs_fns;
> 			     fn;
>                              fn++)
> 
> > +				ret |= (*fsck_refs_fn)(refs_check_dir, iter);
> 
> A pointer to a function does not need to be dereferenced explicitly
> like so.  Also, writing
> 
> 				if (fn(refs_check_dir, iter))
> 					ret = -1;
> 
> would be more consistent with the rest of the code around here,
> which does not OR int ret but explicitly set it to -1 when any
> helper function detects an error.
> 

I will handle this in the next version.

> > +			}
> > +		} else {
> > +			error(_("unexpected file type for '%s'"), iter->basename);
> > +			ret = -1;
> 
> This is wrong.  A symbolic link is a valid symbolic ref, even though
> we no longer create such a symbolic ref by default.
> 

As above said, I have thought git should not handle this situation. I
will implement support for real symbolic file.

> > +		}
> > +	}
> > +
> > +	if (iter_status != ITER_DONE) {
> > +		ret = -1;
> > +		error(_("failed to iterate over '%s'"), sb.buf);
> > +	}
> > +
> > +	strbuf_release(&sb);
> > +
> > +	return ret;
> > +}
> > +
> > +static int files_fsck(struct ref_store *ref_store)
> > +{
> > +	int ret = 0;
> > +
> > +	files_fsck_refs_fn fsck_refs_fns[] = {
> > +		files_fsck_refs_name,
> > +		files_fsck_refs_content,
> > +		NULL
> > +	};
> > +
> > +	ret = files_fsck_refs(ref_store, "refs/heads",fsck_refs_fns)
> 
> Missing SP after a comma.
> 

I will fix it in the next version.

> > +	    | files_fsck_refs(ref_store, "refs/tags", fsck_refs_fns);
> 
> Why only these two hierarchies?  Shouldn't it also be checking the
> remote tracking branches and notes?
> 

I have explained above, because I intentionally ignored the symbolic ref
in this patch, so I don't handle "refs/remote" and notes. I guess I will
handle these situations in the next patch.

> > +	return ret;
> > +}
> > +
> >  struct ref_storage_be refs_be_files = {
> >  	.name = "files",
> >  	.init = files_ref_store_create,

Thanks for your dedicated reviews. I have a more clean direction to
setup the consistence check for file backend.

Thanks,
Jialuo
