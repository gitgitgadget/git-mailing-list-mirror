Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15DA2C3257
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890011; cv=none; b=jQjjy2gj2JkaqRUYONvDk/nm/bsKnCn++qOcqxzAgX8p0iuJbMjy6/iPMeGluOYKiaK/ig2zZarpFP3aP4x8DK/hnkfSSzqr6r9LFR+9k/R59Csk4sNaUfWSm8atwqdjdnoAiJA3PSKPBc0DUDzG+6bkH3equmXn2mMvzD/xjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890011; c=relaxed/simple;
	bh=XFemddJOsBJH72SDeGcE6I3dh4d4uJR797Kk3FpOuA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmtwy9A0P395iIdsUXb0sawyph9AluKTpdkAQu9YFlVZVk3DiMg85IgF8lsP5Iv/kMoSqPRa2rtr2anehNni3ddsBI4F91ua3DYMynCU835036GnFCFQg5i+fqzS4e60jE6xuqpvYN3kTHO1HWvc6C7IiN3v2rz2wnxRPZQ1k20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmjYvuRB; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmjYvuRB"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4360056a2adso1266222b6e.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755890009; x=1756494809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AI2zrPpA3uvquOian/lrKe+bgKv3R7pEZgLZtd6ayQ8=;
        b=mmjYvuRBFgR6dBcZxEUv5tLRAJNFcDOo4G/aFuC6Vqs3y1NBCfeMBRNCkicUnkNUiQ
         /c1T7skUrdJX19h4FxKvB4mFoz0jjSjNK8mIhdD9RQQR47WF7+m/1Zvi6EqxMCusLCLx
         HBZHaEOjHfn0N53KA2mtYcr09Bcm+qpHF1PsEnv0sGclhmI2mMCD9E6FBbnvukXs9bhk
         7wwUrQbV+j+evdx0D46zZ6m3h7Va0wJgYKZkY3I+XRS+na3yC9FUu5dI8h3ybaoM/Zx8
         0OftcSg9hp8jUEMPZK3oLKCmezfVmZqIzpunz39aOR1Ba1ocY/EESfcVCjmsMjJbvdf9
         lQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890009; x=1756494809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AI2zrPpA3uvquOian/lrKe+bgKv3R7pEZgLZtd6ayQ8=;
        b=BNId/rgykC8ZbXfgQIS357w1Tqagx7rK/DIRFWyqp/moIq2uesLfE8HEWE4XhBSpHG
         buDPpghvhaJokLCBomhOIaZE1YPa1XX17dEwdgqKtEjy+MkzMF7iaRpqKavHKLAew+nQ
         wjz8Jg9EvluX4Z0s4A7i+sUsAM5LrD+WWd0xHwLld+lcoatZezlmHxWwZAUaruZGktO5
         15I1KgTUwnIRtL31Y6UR90Jdu5BQJGCObJdMAMVNuK8ngy0aulZhMZZrvhulywuuVy3C
         3mo5oUi33wNrQDIk84lhoK6BEd+2CpEodzVzTHiSLnMHZXy7D3k/KNcPcBaKJLZaGpME
         wbiQ==
X-Gm-Message-State: AOJu0YyZaxSQ27M+ob1C9s/zwOnBUopOBgFcQEAa9bxZCkXvnWUBCGOG
	+BHM1JRX/B0xx6Wt/9F9mkh22rG7GLLzaomu9dNvWdKbWNFYZkC/DFGJ
X-Gm-Gg: ASbGncuJXEM3M3dq4lhqTrJtwcQvqhB2j3Lza8OL08G81w+SiL944qHd8+s2yUOGgYP
	1v9flPdtpQ4Tu9Y/7LHJ2XVnhMj+/wHd17GPhm7gx0HPHfymVfwjvxlQr4QHHJvJcmSHV/yPuQh
	ImnlDjxpNQ1XVHqLUxXhQ8+6DWLRP0yquHxjXXviZdfboZU0Y8UJwarfAtlXUGf6hgV1InMZdlm
	6a8cjI6qZ+HRJUbZmKxDvpiCeTKAalEZdQqcxuJgpK8iU57dvGOFUiDnblTyd6f4xwvqcLkQCZk
	q7A5cyl5vU36WQQRUKnfdGUEDAXmzm7iIxXllIamA6xDpab+7BeuVbR8RtX8iixwX8Hisfb4M9I
	uJct5Xr+WMasqP7yg
X-Google-Smtp-Source: AGHT+IG9GMEJjTBtG2VFg5HqplRxWPpUk5quzY6OTH6POm6cxAyPnKfUmrQoj7pYNA8MmsvZTvEhww==
X-Received: by 2002:a05:6808:1a0d:b0:434:1019:89cb with SMTP id 5614622812f47-43785163391mr1841118b6e.2.1755890008787;
        Fri, 22 Aug 2025 12:13:28 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-437967be721sm64878b6e.1.2025.08.22.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:13:28 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:13:27 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 3/4] bulk-checkin: require transaction for
 index_blob_bulk_checkin()
Message-ID: <p6bdiflg2fe7kgw47ntg46csjhmp63gkovtf4inlc42f4dga77@5oieqa4bydne>
References: <20250820225531.1212935-1-jltobler@gmail.com>
 <20250821232249.319427-1-jltobler@gmail.com>
 <20250821232249.319427-4-jltobler@gmail.com>
 <xmqqqzx3xpwc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzx3xpwc.fsf@gitster.g>

On 25/08/22 09:49AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> >  /*
> > - * This creates one packfile per large blob unless bulk-checkin
> > - * machinery is "plugged".
> > + * This writes the specified object to a packfile. Objects written here
> > + * during the same transaction are written to the same packfile. The
> > + * packfile is not flushed until the transaction is flushed. The caller
> > + * is expected to ensure a valid transaction is setup for objects to be
> > + * recorded to.
> >   *
> >   * This also bypasses the usual "convert-to-git" dance, and that is on
> >   * purpose. We could write a streaming version of the converting
> > diff --git a/object-file.c b/object-file.c
> > index 1740aa2b2e3..bc15af42450 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1253,19 +1253,26 @@ int index_fd(struct index_state *istate, struct object_id *oid,
> >  	 * Call xsize_t() only when needed to avoid potentially unnecessary
> >  	 * die() for large files.
> >  	 */
> > -	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path))
> > +	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path)) {
> >  		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
> > -	else if (!S_ISREG(st->st_mode))
> > +	} else if (!S_ISREG(st->st_mode)) {
> >  		ret = index_pipe(istate, oid, fd, type, path, flags);
> > -	else if ((st->st_size >= 0 && (size_t) st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
> > -		 type != OBJ_BLOB ||
> > -		 (path && would_convert_to_git(istate, path)))
> > +	} else if ((st->st_size >= 0 &&
> > +		    (size_t)st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
> > +		   type != OBJ_BLOB ||
> > +		   (path && would_convert_to_git(istate, path))) {
> >  		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
> >  				 type, path, flags);
> > -	else
> > -		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
> > +	} else {
> > +		struct odb_transaction *transaction;
> > +
> > +		transaction = begin_odb_transaction(the_repository->objects);
> > +		ret = index_blob_bulk_checkin(transaction,
> >  					      oid, fd, xsize_t(st->st_size),
> >  					      path, flags);
> > +		end_odb_transaction(transaction);
> > +	}
> 
> Interesting.  If the caller does the odb transaction management
> itself by calling begin/end before calling this function and fed two
> or more large objects, the original code did the right thing with
> .nesting set to 1.  In the new code, it still does the right thing
> even during the call to index_blob_bulk_checkin we raise .nesting by
> one, because the all non-zero .nesting values mean the same thing to
> the machinery, thanks to lazy initialization of the .objdir.

In the original code, if no transaction was setup prior to invoking
index_blob_bulk_checkin() (i.e. nesting == 0), the object would be
written to its own packfile and flushed immediately. If a transaction
had been started further upstream (i.e nesting > 0), the object would be
written to a packfile, but not flushed. This allowed for subseqent calls
to index_blob_bulk_checkin() to write objects to the same packfile. Only
when transaction ended would the packfile be flushed.

With this change, index_blob_bulk_checkin() must be provided a
transaction so it can write the object to the packfile. As there is now
always a transaction involved, there is no longer any automatic packfile
flushing. The caller is required to ensure a transaction handling as
appropriate.

> So, isn't the comment above the function now less accurate than
> before?  The caller of this function does not have to do anything
> and we do not expect the caller to "ensure a valid transaction" at
> all, no?

I'm not quite sure I follow. index_blob_bulk_checkin() now expects a
transaction to be setup even if we intend to only write a single object.
Thus the call site in index_fd() is adjusted to ensure there is a
transaction via invoking begin_odb_transaction() and
end_odb_transaction() before/after the function respectively.

Just to clarify, are we talking about the comment above
index_blob_bulk_checkin()?

-Justin
