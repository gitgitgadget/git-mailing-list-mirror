Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D83F99FD
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966220; cv=none; b=PY3+yfeGYE8xKt/63rPyYowP82aGzhAfhkly1K6t/lF8NBzCBN5h+0eZaHptBitozbUNuwhe8bnv4Jdtmlmh/jHJUhUs89FTO/1JnUNNGOwbSNIv2vZ7liXm5sMD5x2pnr0+yGjAVGmar1cS0PvuIl+mpPT/lhGrfLXHiMFllEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966220; c=relaxed/simple;
	bh=yF08bZuFG4xKGTJHoz0b28DPUkRv4pouUWOa7ALEIPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNxOupxwHZ1TNBKuBBn5BOYqdyjPOZEoZKOm6rmyP4Qm50fG4q5VCswQcUVP+4jgEl+peTIg79bKf+FTJF+He6L7p7VDtNPwbAp6gOw5/2rZsChk7UTSBgvhMthuceG0Ui12p4868lHAwgcDoVGYBnjw4Grf5x5/n2muwfGVOoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNO9raxf; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNO9raxf"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d743cd9e5bso3768688a34.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774966216; x=1775571016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1jwdii3I3PSqZSZUWKa8CvWuLtBU6uBZUbMH1UVx3Y=;
        b=lNO9raxfW/jp3zzl/fcBOyV++Tpzm9CKTR9NCHX/WCWz6hOt+46CTmYdBOhN6a22U1
         ZY6B1NS6fvNZbzsK2XVESdE+OgnROKtQnqvKuMVQ2LNSxkYpePbSqcAYEv4ppXLc4sim
         9olFLF8Ott6nvJrPhU/XqUrj1C3NQjnKqo8a0o1GLuWvdVqt8W2u5Hfi+Pse2iWwJaTA
         KZPi/jWdfTs99/3jCogk+6rO5VvyBzODtm0PcGgVc1keabkftfq7zpAlPk7cEpmSIqlL
         OCvw0PJWpN/iws43vafo6WiEh5brGlDa12A7EfKsyGkpQKc95F4ywVfIDcPfZGccoFZ5
         wejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774966216; x=1775571016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1jwdii3I3PSqZSZUWKa8CvWuLtBU6uBZUbMH1UVx3Y=;
        b=r4UWBYdaXS7ZNhI4McmjiVoJSsRga87L89w1uRDywGPHucDtNkV444kKEqEMtC2szb
         5M489pYXQ1hoqecqPsYAcN1MPK34Yp29u0jcaBgmIyf1ZXuDykg8ib+cQtVEtKa3HVAE
         aTExrWPCe48DYVr4tFOrHzuQAWig7QBB4fMsUEC4ns7er1xw0i16D+7eMiWTn4czlFkv
         DYxZ2WexNCvpwpRBpgqHvwYjB+oF6N1qAFKC6QHRuUQ7U1oKmCYTYjk1ZqX0vZR6poHf
         39SVRsXssWi+M/1wuEjAUu0vHWs65KOLsjN/VwpuoIKHz7eOaD9+ncqfDlxALl2/rTtF
         Qq+A==
X-Gm-Message-State: AOJu0YyBfR+WQ1JiDvFo5CQc4kCG4HAtnWv5qmBBM6Ng3b4Fa/H+SPmk
	1K8yWvxqWiZ7OKYwj5qjsXVm/DKCVJGyAbPuT69mT/z51hw+XVysngLNVJD8tw==
X-Gm-Gg: ATEYQzwlyP+PKhzsibbQAhUkh+5lXXWkFfXOOp4J6TAIyqkOS95RCg1mPKj6rxRHYGH
	bO5yDQjdeKrQ6UdpcU6fo66C6vMjSY6iRBYmDqeQvHxUkPrVgcRDTlvttk+1ulVV1njDv7g+aUl
	QZ8SEpfZ5lsvVwwdhFC9IidXNr2+94W3FZNXfkt3Rzb23W3KtQFsN6guZ6VlzqLd7Wc3apGwA9p
	onyprcS/4sooRD2qvNGEzt+kf1BgrvGDNjWisU87lhMrixCHZWLRInbmG5YztCbkSWNA+E21mjE
	4aaefw5X4AePDSpkNr4eVJhrYXLG1TfNYprYasAyeB3GsHm3x/+T8uvDl3tSXIsfrBQbxcTFM3E
	7nqsBDtvlhAPvXuc8vt+GRUjlb3fCEODUwzQ2fanXqOv/wR7Rf+a2tNQJJ9uDYnDdifR7dupQ/3
	yo2rSeYjMZnxm88tF2
X-Received: by 2002:a05:6830:6a89:b0:7d7:d15a:ce8e with SMTP id 46e09a7af769-7d9fafafb09mr9962280a34.32.1774966216346;
        Tue, 31 Mar 2026 07:10:16 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da3356d8c5sm2658130a34.14.2026.03.31.07.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:10:15 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:10:13 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] object-file: remove flags from transaction packfile
 writes
Message-ID: <acvS74ee-N9zSYDN@denethor>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-4-jltobler@gmail.com>
 <act8VlnYzyTGOY7Y@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <act8VlnYzyTGOY7Y@pks.im>

On 26/03/31 09:48AM, Patrick Steinhardt wrote:
> On Mon, Mar 30, 2026 at 10:38:32PM -0500, Justin Tobler wrote:
> > diff --git a/object-file.c b/object-file.c
> > index bfbb632cf8..493173eaf4 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1405,6 +1404,34 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
> >  		die_errno("unable to write pack header");
> >  }
> >  
> > +static int hash_blob_stream(const struct git_hash_algo *hash_algo,
> > +			    struct object_id *result_oid, int fd, size_t size)
> 
> We could of course change the interface while at it to also receive the
> object type. I'll leave it to you though whether you want to go there,
> we don't have any use case for it right now anyway.

Hmmm, this particular helper is always reads the object from an fd. We
could of course also update this interface to use a `struct
odb_writes_stream` to provide the object instead. For now though, since
we don't have a use case, I may just leave it as-is.

> > +{
> > +	unsigned char buf[16384];
> > +	struct git_hash_ctx ctx;
> > +	unsigned header_len;
> > +
> > +	header_len = format_object_header((char *)buf, sizeof(buf),
> > +					  OBJ_BLOB, size);
> > +	hash_algo->init_fn(&ctx);
> > +	git_hash_update(&ctx, buf, header_len);
> > +
> > +	while (size) {
> > +		size_t rsize = size < sizeof(buf) ? size : sizeof(buf);
> > +		ssize_t read_result = read_in_full(fd, buf, rsize);
> > +
> > +		if ((size_t)read_result != rsize)
> > +			return -1;
> 
> It would be a bit cleaner to first check whether `read_result < 0`
> before casting.
> 
>     if (read_result < 0 || (size_t) read_result != rsize)
>         return -1;
> 
> Doesn't make a difference in practice though.

That's fair, I can update in the next version to this.

> > +		git_hash_update(&ctx, buf, rsize);
> > +		size -= read_result;
> > +	}
> > +
> > +	git_hash_final_oid(result_oid, &ctx);
> > +
> > +	return 0;
> > +}
> 
> Overall, this function really is simple enough to pull out, even if it
> duplicates a tiny amount of logic. Also, it has the benefit that we can
> easily skip deflating the data, which we used to do even if we didn't
> ultimately write the data to disk, so it was just pointless busywork.
> 
> > @@ -1642,7 +1655,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
> >  	     int fd, struct stat *st,
> >  	     enum object_type type, const char *path, unsigned flags)
> >  {
> > -	int ret;
> > +	int ret = 0;
> >  
> >  	/*
> >  	 * Call xsize_t() only when needed to avoid potentially unnecessary
> 
> In practice this doesn't have to be zero-initialized

Ah, yes. An earlier iteration of this didn't have `hash_blob_stream()`
returning error codes. Will update accordingly. Thanks.

> > @@ -1659,18 +1672,23 @@ int index_fd(struct index_state *istate, struct object_id *oid,
> >  		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
> >  				 type, path, flags);
> >  	} else {
> > -		struct object_database *odb = the_repository->objects;
> > -		struct odb_transaction_files *files_transaction;
> > -		struct odb_transaction *transaction;
> > -
> > -		transaction = odb_transaction_begin(odb);
> > -		files_transaction = container_of(odb->transaction,
> > -						 struct odb_transaction_files,
> > -						 base);
> > -		ret = index_blob_packfile_transaction(files_transaction, oid, fd,
> > -						      xsize_t(st->st_size),
> > -						      path, flags);
> > -		odb_transaction_commit(transaction);
> > +		if (flags & INDEX_WRITE_OBJECT) {
> > +			struct object_database *odb = the_repository->objects;
> > +			struct odb_transaction_files *files_transaction;
> > +			struct odb_transaction *transaction;
> > +
> > +			transaction = odb_transaction_begin(odb);
> > +			files_transaction = container_of(odb->transaction,
> > +							 struct odb_transaction_files,
> > +							 base);
> > +			ret = index_blob_packfile_transaction(files_transaction, oid, fd,
> > +						      xsize_t(st->st_size), path);
> > +			odb_transaction_commit(transaction);
> 
> Okay. It's a bit sad that we have to reach into the files backend here,
> but we already did beforehand, and maybe a subsequent commit will fix
> this? Reading on.

Yes. :)

> On another note, it's somewhat curious that the commit doesn't return an
> error code. Probably something we should fix eventually.

Ya, the error handling for the ODB transaction functions really should
bubble up any errors instead of just "die()"ing. I plan to improve this
in a future series.

Thanks,
-Justin
