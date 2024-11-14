Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49911F8915
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586163; cv=none; b=g2NIfqycxIc7klcKLPnFVSqJd/ilZ0aiaAYi7mbaFzvmZteb/WW7PfoRy17Uv5VBPsQn07UZaZwjXLl+grc3BjjrZlEvxJeBMnJvkOKmf/pqa5qc+87zOuT9heSOvPOmr0X9HOj+ygBkZaioB2LTwe+wPWpm5L+00JSqmdS1lEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586163; c=relaxed/simple;
	bh=+JNvZzboeOCKH9ekqJci7wIDZv+rMvuJiUiA4ob8wB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDYdb8QEXj76eYdBdlnrD6Gfby0TAEMOXH7qxuiZOrHx8F8jYrLXyxvkz/zYVH+UOi5nwCHOE9Xm/L5PsAmVk/jkwEizFdTPMPnz1oyvo8e5OnpGDTZrHdVElaA73wCUz4kXHuD5sVpPnquBS6pSdXGxRmesxsQHjUBjTFKaJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Um8yFb9M; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um8yFb9M"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso289203a12.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 04:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731586160; x=1732190960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HcsjAJ/4kyHoM0e+BFzEn1ZZFmH1fcYhHrxi4xCFOE0=;
        b=Um8yFb9MzI8FslMOpUmjYmokaawshzeh6UerKUkOvhZq/kZLzBh0vXPLnBehdisyUk
         330RuQZDKv0Xe8LQxZwBJS9OJtuaPznv/C6JTRaB3bMHX23HHWyutZGCSAzKJGN6UldM
         18HV8uyvXhn2utCZw0r9NLG4YR0z/3XRmtz+wMnDyAU71w0lZE5jSSd225k0M1TY9YQS
         Gdu88u8tpMofySOQyGWpjcliFGXIBhm7dYnYHsEkFDeS0ro2YAu+FUu9oj0TmWQ89jYo
         4Kt7I+71Alos2w6zhqClQakdV65mIth31bhaxKiW/W73Pk90/iF8b7R95t7/8W/HMxJs
         L1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731586160; x=1732190960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcsjAJ/4kyHoM0e+BFzEn1ZZFmH1fcYhHrxi4xCFOE0=;
        b=VE2FHL5v9ilkEvivLXQLwv2ANo9uUScsdxIz+rlhOpDgFDRcFxRlFvccSLzsMd1F8m
         5WitcEHr2sFRkg16UKUQZHfODOvVoWJ8ohaC/BWb0e7fdHSmaVZOBRlkNxfPt5r4zi16
         T6i1IKDOE+hxdbFJlneAk3SmGpzn2pJAmYehWpqRr7U/+d2UlxzQklq1D3WwjRYGQkBO
         Tz9Ee27oOp31ZZjXezyA+YrJWwao49V7Rwyar4WsxnT7dWu0xxohfGELqvt9czmhQTNa
         SIEvtbILd9UrgtEL0vCxqESJQ7avH3xJ3aKGRWCvicwIP5N0V5tiSpK0966qVppZyqDC
         9FnA==
X-Gm-Message-State: AOJu0Yygr9KTI3LiYdfF4ZFzJAPAi5RsNu4Fri32qwT9P8IhkeQzixDs
	4QNT1OqUUGg+tFhWRzkCdvS7QAHzRmpWq3H7E+1l+l/plvKu50RkXn4NZQ==
X-Google-Smtp-Source: AGHT+IFo6wZVD9WU+jjPWFUaKcphyk7y5A61VFPBb8+kw46q7D4StSgb61jATjstiLq/cvZSKvyPVQ==
X-Received: by 2002:a05:6a20:9188:b0:1db:ff5a:23e5 with SMTP id adf61e73a8af0-1dc70338f2amr8873062637.4.1731586160115;
        Thu, 14 Nov 2024 04:09:20 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8b3974bb2sm956555a12.64.2024.11.14.04.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 04:09:19 -0800 (PST)
Date: Thu, 14 Nov 2024 20:09:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 5/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <ZzXocdnqigGYFXQ_@ArchLinux>
References: <ZzCiCGxL4Adnd_eq@ArchLinux>
 <ZzCij4ilPLhlKXS6@ArchLinux>
 <ZzRW7E2Z0ZYQ7i20@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzRW7E2Z0ZYQ7i20@pks.im>

On Wed, Nov 13, 2024 at 08:36:12AM +0100, Patrick Steinhardt wrote:
> On Sun, Nov 10, 2024 at 08:09:51PM +0800, shejialuo wrote:
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 8bfdce64bc..2d126ecbbe 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -3505,6 +3505,48 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
> >  				  const char *refname,
> >  				  struct dir_iterator *iter);
> >  
> > +static int files_fsck_refs_content(struct ref_store *ref_store,
> > +				   struct fsck_options *o,
> > +				   const char *target_name,
> > +				   struct dir_iterator *iter)
> > +{
> > +	struct strbuf ref_content = STRBUF_INIT;
> > +	struct strbuf referent = STRBUF_INIT;
> > +	struct fsck_ref_report report = { 0 };
> > +	unsigned int type = 0;
> > +	int failure_errno = 0;
> > +	struct object_id oid;
> > +	int ret = 0;
> > +
> > +	report.path = target_name;
> > +
> > +	if (S_ISLNK(iter->st.st_mode))
> > +		goto cleanup;
> > +
> > +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> > +		ret = fsck_report_ref(o, &report,
> > +				      FSCK_MSG_BAD_REF_CONTENT,
> > +				      "cannot read ref file '%s': %s",
> > +				      iter->path.buf, strerror(errno));
> > +		goto cleanup;
> > +	}
> 
> I didn't catch this in previous rounds, but it's a little dubious
> whether we should report this as an actual fsck error. I can expect
> multiple situations:
> 
>   - The file has weird permissions and thus cannot be read, failing with
>     EPERM, which doesn't match well with BAD_REF_CONTENT.
> 
>   - The file does not exist anymore because we were racing with a
>     concurrent writer, failing with ENOENT. This is benign and expected
>     to happen in busy repos, so generating an error here feels wrong.
> 
>   - The file cannot be read at all due to an I/O error. This may be
>     reported with BAD_REF_CONTENT, but conflating this with the case
>     where we have actually bad content may not be the best idea.
> 
> So maybe we should ignore ENOENT, report bad permissions and otherwise
> return an actual error to the caller?
> 

So, I think we should just use "error_errno" method to report the actual
error to the caller. And we also need to add some comments.

Thanks for this wonderful suggestion.


> Patrick
