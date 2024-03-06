Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D08565B
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742925; cv=none; b=RIR7DAwX/Ud1JxQqfVcLjS82WvkbiKEmOwopkaLQTW8umxshkWt+ALKMvflRZqcdaHmKFcMu7JayzNYBGiZi7CgwQmee5x8yIBT2p3w3nZfVSTlJ0VX/htd718b5YIOtS7iHoyj7Br9+FbkzLREZCvfddL8h3+09lYkoDRpH+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742925; c=relaxed/simple;
	bh=oxQ+KW5G1jQ+5jdna90K9mNj/pwxXoIlpBNwn4ymOKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4C4kFbBKsZJjNauhI8YchmoHpS1KN9BuT3M27oZMxqaQPucjLo/sOXQoZEdJr4IiAnje4KWfGwwGo4nNJ7rfcxo1Dgn/EmfStzb/fkUJl8EjcIzoRT0rngT0+4xL3DOTokNYC8rzQj+U/Q0xdsKa9b71gLFKJm6KUWXjhPFoXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXKRNpVQ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXKRNpVQ"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1a2f7e302so3896020b6e.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709742922; x=1710347722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgPlHqiB/1yyRsAut8LsgM7ElijUWSkKLdDSSG6h4rE=;
        b=UXKRNpVQOABCJNIJwvH9Gf5Zt2YZaSHJ/cxEvm/0fOBj8Y3W8nUtFJdDrl78bbxyqc
         AHYcJ1ykv5M+fIgSYweUCXeiZKbDvkAPcll/ELF1kAIQ9UKnQoh6D9WFWTMfqDG1sUkI
         ftARvWSTVawHRgYxCEwfV1HpaphfsKtHKZPH8cOj0QdMPD6AFI8v4/qZlej3EWXsL5Cv
         GIbcGQKAf9ghevxuS0GBXviGvQQXF0gsED/ddLVM8v4+SH/B0VuFSaqZ9LOBmtfzXK3B
         W1CVuMiQnYF3e6M7WTIM/4dpxLspQxsosgp4t7wd3rdVra+87K9D35O7QnAFulZxiM9K
         cFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709742922; x=1710347722;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgPlHqiB/1yyRsAut8LsgM7ElijUWSkKLdDSSG6h4rE=;
        b=Ia7Aj5Y0rmfzH3Hpqh+XFZgoiGAcMQDsLnHgTttIE0VZlUZC7fTVLGYYD8Q4qxsuyh
         AAyIwuSv8JHLDQjwY/iOmIINzrOjUHTtpMDbwblgFUB/Qb0ylxCLsiw2DUJiXW5jgJ9n
         LtSQPT/V8CyWWQbcVkfaz75hrk4sXj+VBDdkAwf5Ccmk0AHb1BrfsmOak0eLebCFlbkC
         wTNEiPOegfbsi34DUGBunufbf7T4jx3whDUP6EGrdTYNtElccwAc1mIXn1pkJTtr/b1O
         vnJODVgSVdzXIDe2+/cQ+zRzscMAVOK3Kfx3QXXvTUQU34OUryLklTX0gR0421BXTrmI
         dpSw==
X-Gm-Message-State: AOJu0YwSVt7W9kBzvtZGdaW+NhkSoTgjcM3OJG7nDObqIQJaNc5OtyYs
	OoRIcCuOH9D8FG0cHHkDac5lLhg6UIQHrErItYoU15rVvT+N/cWH9Y9MCBWr
X-Google-Smtp-Source: AGHT+IEtWmzG+6ru9TUh8vfIZOQ5XvHrm6tKhEzDctMDoETOqmFsM9UfEPw51sRswLsyshWTOgW8UQ==
X-Received: by 2002:a05:6808:2184:b0:3c1:9371:dccc with SMTP id be4-20020a056808218400b003c19371dcccmr6627654oib.53.1709742922406;
        Wed, 06 Mar 2024 08:35:22 -0800 (PST)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id a3-20020aca1a03000000b003c1ea0c6636sm1093919oia.54.2024.03.06.08.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 08:35:21 -0800 (PST)
Date: Wed, 6 Mar 2024 10:34:39 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] reftable/stack: register new tables as tempfiles
Message-ID: <wz2wdic24l6ssynni2vhdhbhgaljxhdk2afe2ooi42hj5bw4pi@yfxlsa4excu5>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1709549619.git.ps@pks.im>
 <02bf41d419efd00e510a89a405e1b046b166ba20.1709549619.git.ps@pks.im>
 <6cw6d3ubo2kbogzdbniyoznij2zfoh5t3htwb4oaghaltcgeqg@kkrw4g6atr2k>
 <Zehav4V_8GGZG94Q@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zehav4V_8GGZG94Q@tanuki>

On 24/03/06 12:59PM, Patrick Steinhardt wrote:
> On Tue, Mar 05, 2024 at 04:30:18PM -0600, Justin Tobler wrote:
> > On 24/03/04 12:10PM, Patrick Steinhardt wrote:
> > > We do not register new tables which we're about to add to the stack with
> > > the tempfile API. Those tables will thus not be deleted in case Git gets
> > > killed.
> > > 
> > > Refactor the code to register tables as tempfiles.
> > > 
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > >  reftable/stack.c | 29 ++++++++++++-----------------
> > >  1 file changed, 12 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/reftable/stack.c b/reftable/stack.c
> > > index b64e55648a..81544fbfa0 100644
> > > --- a/reftable/stack.c
> > > +++ b/reftable/stack.c
> > > @@ -737,8 +737,9 @@ int reftable_addition_add(struct reftable_addition *add,
> > >  	struct strbuf tab_file_name = STRBUF_INIT;
> > >  	struct strbuf next_name = STRBUF_INIT;
> > >  	struct reftable_writer *wr = NULL;
> > > +	struct tempfile *tab_file = NULL;
> > >  	int err = 0;
> > > -	int tab_fd = 0;
> > > +	int tab_fd;
> > >  
> > >  	strbuf_reset(&next_name);
> > >  	format_name(&next_name, add->next_update_index, add->next_update_index);
> > > @@ -746,17 +747,20 @@ int reftable_addition_add(struct reftable_addition *add,
> > >  	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
> > >  	strbuf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
> > >  
> > > -	tab_fd = mkstemp(temp_tab_file_name.buf);
> > > -	if (tab_fd < 0) {
> > > +	tab_file = mks_tempfile(temp_tab_file_name.buf);
> > > +	if (!tab_file) {
> > >  		err = REFTABLE_IO_ERROR;
> > >  		goto done;
> > >  	}
> > >  	if (add->stack->config.default_permissions) {
> > > -		if (chmod(temp_tab_file_name.buf, add->stack->config.default_permissions)) {
> > > +		if (chmod(get_tempfile_path(tab_file),
> > > +			  add->stack->config.default_permissions)) {
> > >  			err = REFTABLE_IO_ERROR;
> > >  			goto done;
> > >  		}
> > >  	}
> > 
> > Since the tempfile is now being created through the tempfile API, I
> > think the file mode can be set directly through `mks_tempfile_m()`
> > instead of creating the tempfile and then using chmod. Just something I
> > thought to mention.
> 
> Unfortunately not. The problem is that `mks_tempfile_m()` will munge
> passed-in permissions via "core.sharedRepository", but we already pre
> calculated the target mode in `config.default_permissions`. Thus, the
> result would have wrong permissions if we used `mks_tempfile_m()`.

Ah that makes sense. Thanks for the explanation!

-Justin
