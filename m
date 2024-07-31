Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87A101EE
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722467009; cv=none; b=Pdm/6XME/UkzDh50/H4rOYpXYIh4OEuH8hKY/GHb6Iz+Z3uAwCk2HwsAxc8vFevjjYG5jSe3dDDjkvWea5Z7tFe5YSKFZClHDIMztXPhHbZhUxlwIBk6edmmxjy0Eot4gyltqGf1gQ9LX71E9lJYkm+MSQMdjr+gi5VZGgiy1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722467009; c=relaxed/simple;
	bh=E133tAZDcbE5DcEM44m8PSubglpDYl6/RV3+zO2gqO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/SFn1UCBqjsYQz+JFVH2WH8yetTAh3HEcAPyq/6kVEEpTpFitmatJO5QH/+82V392xyXkPn2bdZAei9yRTDj9+r/MDoU9oPYaXiHV9B5hwTgboTKsjHcFWfQPszqOD63VTRyTbb5MBsOvSCeSU+3CcuYnShOzAkLIuKi1FF0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G42mJ6fn; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G42mJ6fn"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-260e3e295a7so3759801fac.3
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722467007; x=1723071807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9Wb5isNYubSyjXn35BDbSdYzmx0Pn2pFJBEHfUprXE=;
        b=G42mJ6fnxdTT9xe32UYAp22M3pR/2K2hgPC2xFH1FSD68AjBZlpbovTCV/Vdam/Boh
         Q4iCuNBMQEKun/abewz/F5WJvadPUSBWp1+KKvNxtJ5Ti5PU05gsgXEgzR8qV7+O48Xh
         qce00NRePqEGXcTeiPAImdLkPVjRGChXriKD1WteSOyVr7SPBBQqS0V6R+7sFMcpF9ie
         prILbgAMRN63lIOoTinAlgv4XCL0XmmF4S1/zHS60LTzuqKXfcDSVcyP6TF4mAPMueu4
         wpXj68FBb4tpI3IUNMjVGN9bnQLVD13fKqYa+ktaoNpZkhchTeVMr8zUJAVdvjGRfT3N
         8Uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722467007; x=1723071807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9Wb5isNYubSyjXn35BDbSdYzmx0Pn2pFJBEHfUprXE=;
        b=FrK9Sc5qeeizx7llQndlSYsFQY3toIQLZPv4sICT9eZ6E68Hjp5bcnatx7tn2nRzbx
         Mm/1nky0DVen9P97+wqCxY1YOi+cAgrbJ0kpoiLFLocZB7QGP3BC9Chon1/wn27GbMiW
         XS5ES5ZCujmlMN3J+mtkKYyE+J7SPxep3IC83rza5DY3sSM+B+WzVshrC0b/pYW8QEqG
         JEZEMiFWxLlNwTFAh80bLyxGqB9EVjqZu6lfr/d87JiHrh2Kte0ez7gqMze4WhFXqzXR
         VUNNaWWlqWrIv86dIInwpCrR0aW2nrCvqYT270QLj6yPlo1yj9zxeOD5LSiq5yof0NTZ
         c3NA==
X-Gm-Message-State: AOJu0Yz2nDESZit9wehPcJ46Q9vofNYUgjY4yy/my01EYC69/I9rCCe1
	94NM7pdungqT/X96MeDOAXpDlnuUJCvqsk3/uEzLDkqVwKSYveBj
X-Google-Smtp-Source: AGHT+IHwpo0zXS1Bs6dHrz9JAmjdAC8VYunOzGuLBlzs5dbsk2MLiFgAo+TIwORqjzrQgnwbfdRLhg==
X-Received: by 2002:a05:6871:7249:b0:260:dec5:11cc with SMTP id 586e51a60fabf-2687a4eca59mr673307fac.20.1722467006724;
        Wed, 31 Jul 2024 16:03:26 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-265771e4907sm2857438fac.35.2024.07.31.16.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 16:03:26 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:02:41 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] reftable/stack: use lock_file when adding table to
 "tables.list"
Message-ID: <fpli326ssfh66sojj4bqn2ztaks3lceqce7nwb4jzrducpvfxz@uoeabcbebaez>
References: <cover.1722435214.git.ps@pks.im>
 <9703246156152e1c8c92b4237c8dc3a9ef59901a.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9703246156152e1c8c92b4237c8dc3a9ef59901a.1722435214.git.ps@pks.im>

On 24/07/31 04:15PM, Patrick Steinhardt wrote:
> When modifying "tables.list", we need to lock the list before updating
> it to ensure that no concurrent writers modify the list at the same
> point in time. While we do this via the `lock_file` subsystem when
> compacting the stack, we manually handle the lock when adding a new
> table to it. While not wrong, it is at least inconsistent.

Indeed, much more consistent to use the lockfile API here. :)
> 
> Refactor the code to consistenly lock "tables.list" via the `lock_file`

s/consistenly/consistently/

> subsytem.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 9ca549294f..9cc91a262c 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -567,7 +567,7 @@ static void format_name(struct strbuf *dest, uint64_t min, uint64_t max)
>  }
>  
>  struct reftable_addition {
> -	struct tempfile *lock_file;
> +	struct lock_file tables_list_lock;
>  	struct reftable_stack *stack;
>  
>  	char **new_tables;
> @@ -581,13 +581,13 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
>  					struct reftable_stack *st)
>  {
>  	struct strbuf lock_file_name = STRBUF_INIT;
> -	int err = 0;
> -	add->stack = st;
> +	int err;
>  
> -	strbuf_addf(&lock_file_name, "%s.lock", st->list_file);
> +	add->stack = st;
>  
> -	add->lock_file = create_tempfile(lock_file_name.buf);
> -	if (!add->lock_file) {
> +	err = hold_lock_file_for_update(&add->tables_list_lock, st->list_file,
> +					LOCK_NO_DEREF);
> +	if (err < 0) {
>  		if (errno == EEXIST) {
>  			err = REFTABLE_LOCK_ERROR;
>  		} else {
> @@ -596,7 +596,8 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
>  		goto done;
>  	}
>  	if (st->opts.default_permissions) {
> -		if (chmod(add->lock_file->filename.buf, st->opts.default_permissions) < 0) {
> +		if (chmod(get_lock_file_path(&add->tables_list_lock),
> +			  st->opts.default_permissions) < 0) {
>  			err = REFTABLE_IO_ERROR;
>  			goto done;
>  		}
> @@ -635,7 +636,7 @@ static void reftable_addition_close(struct reftable_addition *add)
>  	add->new_tables_len = 0;
>  	add->new_tables_cap = 0;
>  
> -	delete_tempfile(&add->lock_file);
> +	rollback_lock_file(&add->tables_list_lock);
>  	strbuf_release(&nm);
>  }
>  
> @@ -651,7 +652,7 @@ void reftable_addition_destroy(struct reftable_addition *add)
>  int reftable_addition_commit(struct reftable_addition *add)
>  {
>  	struct strbuf table_list = STRBUF_INIT;
> -	int lock_file_fd = get_tempfile_fd(add->lock_file);
> +	int lock_file_fd = get_lock_file_fd(&add->tables_list_lock);
>  	int err = 0;
>  	size_t i;
>  
> @@ -674,13 +675,14 @@ int reftable_addition_commit(struct reftable_addition *add)
>  		goto done;
>  	}
>  
> -	err = fsync_component(FSYNC_COMPONENT_REFERENCE, lock_file_fd);
> +	err = fsync_component(FSYNC_COMPONENT_REFERENCE,
> +			      get_lock_file_fd(&add->tables_list_lock));

I might be missing something, but is there a reason we have to get the
lock file fd again instead of just using `lock_file_fd`?

>  	if (err < 0) {
>  		err = REFTABLE_IO_ERROR;
>  		goto done;
>  	}
>  
> -	err = rename_tempfile(&add->lock_file, add->stack->list_file);
> +	err = commit_lock_file(&add->tables_list_lock);
>  	if (err < 0) {
>  		err = REFTABLE_IO_ERROR;
>  		goto done;
> -- 
> 2.46.0.dirty
> 

