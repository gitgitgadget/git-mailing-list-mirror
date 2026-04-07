Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD333BBCF
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598192; cv=none; b=pzinVAI36QuWzbBtTHmYKXtm/wdS6L8U6Q2IIh+NM26QmhagKmK6lr0LYYrTetVTWbUXfUUNt0OIlcx+GfHL9rKDDdYJyw471ZIW+sE1nAqYy60hfRVnxCn8XnG0+Zn3N8by5uyATDLm719TFZYNHaGzl6E5tsL9afCUU7t+vzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598192; c=relaxed/simple;
	bh=klatDXn3kTGF3/ygV+C4iQk5ipxFYe9auFP4yM88Kmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSLhf3eOMHFOOOt2+PqdYb1TMO5UchU0Kyfqu56fiXo1RzH0eBDw+cxesAu8yfePZwYp0+ggpDCsNsrNzDM7KkvccUGaEVt1Gu7VctmytEQIfK9UthoF64lXkwyVT6DKUDJNYXXM5xMvLN1t/XehHpqtQAzo91AnzLmlIBybUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsmOgE74; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsmOgE74"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d7eb85fb81so5327349a34.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775598190; x=1776202990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iFJM3Nj4cbiOdcZ/Gvt8Kz5M/7W1HlTnkhtygU6vhpU=;
        b=LsmOgE74Zjn93yFx1mBKFSzr6bn4e2J2IPtiLODPqjvSMo6gVJOwsnqbPqqqs/MMOB
         9cfGORl7TJsGQ2bGRs+dBrFRGMoeaOygDDhaoEnPqFtvzzCa5T/HDxgEsukzxC+iPX+V
         NWp80d07a0Z7ktvsIGzf7aGXpBf19/6BBij8a7YPdgqOmgTkPzJ922+ewGcjICdEJpM6
         hUTDOZYhNjPIGExHdmIZSCAKVOOXjzMJqP3rLl7pCWOlR01Zj8qam2A7fYEiKwDaHPPF
         Id2zk3jRO18GGFJnndDef0JD6s/vJoB9bi8i9jQxOEFtUkDt0iY1kCpf5+Z1kI+VJx+S
         GyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775598190; x=1776202990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFJM3Nj4cbiOdcZ/Gvt8Kz5M/7W1HlTnkhtygU6vhpU=;
        b=GnyEGvQJN40Qdy+OvtQ2rFr2EqvRtULTCvJOYDGPg1z9cEcklwEmAIK510uhAazR3u
         2Fz+SDRrtYbAV5lGfxkmZRqt+fjXM+7MjkEIoyWeuChclg1MfNhSLzexP3e8KOdIlBE9
         59SADOhnNuCG+bQFGFkqdQ9/MmU8ry1IzdK9XmXDdbWZTesy8CT/wJjQqTipIGMkiWo/
         tJGpQRXB6iwmug4UovTKwcn62G8yzKDhtxIxYZ6pMRDrIJ54lqnfQEYqbf4kNSUwHj5K
         ImZMpzwymTVhdr1y+Ws554LA2L9UoE+V/E4X7COUL+1WQJyBRtpwpmHeiRfRByEVtEO7
         sMgQ==
X-Gm-Message-State: AOJu0YzXV+WWWtu/gez+JyZplcTfwGd85p2q+qiKwGAGeXNiriyMcRob
	f9qfN42wNFyajON8UJZmSvYXyLP4pRUoVXs62q330OUHqZboOL8dSTxJ
X-Gm-Gg: AeBDietb9qNnQeBOF5VJHpwOdcclp8l/KsX8d8c/EHOHy9XrsUXNmaLkfPekHVw8FLR
	did7coEnDRxj7RKRCdRupxosMxgD8lXLVL8xZ1HnGcnWrcb4GIupRZPu9Jy+//9D4OjzdaBtMu4
	s7JL6JGTLiltooRqXwUq5odEKwYZZgJgn1qLlRsfLjbQ9D1razo+Xj/0a3SUdMvY7S4RmmwV0XO
	L5de9VakiRRkqg5YVH3CM1F31lQ1F4P6Ww1pipbG/+gCXEOck25ccE51jXIydgo4trwv5tkPUAb
	Wwn7pmW/lYmDIAM/9xH9oBzx6n4uaCNBvLMeoMROaGZg4boHbdPeDqYz+T60njExlCEN1aR09KR
	zsZzuiN27LFXxJsoTz+UELoX07PuPw97lqa7/SjGuR6X85x10lUqBF+hoCL2Q1EqPeEPrmSDTyt
	5mVfEZ3psDY6npEhvIWPwjyemIq3o=
X-Received: by 2002:a05:6830:67ee:b0:7d7:e045:b489 with SMTP id 46e09a7af769-7dbb73dd4b2mr12837710a34.12.1775598189821;
        Tue, 07 Apr 2026 14:43:09 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbf928f085sm2241498a34.1.2026.04.07.14.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:43:09 -0700 (PDT)
Date: Tue, 7 Apr 2026 16:43:08 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, peff@peff.net, 
	luca.stefani.ge1@gmail.com
Subject: Re: [PATCH] object-file: avoid ODB transaction when not writing
 objects
Message-ID: <adV44IS5iPwdjKAe@denethor>
References: <20260407201730.2526914-1-jltobler@gmail.com>
 <xmqqo6ju31wx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6ju31wx.fsf@gitster.g>

On 26/04/07 02:18PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> I'd appreciate it if you can give your eyeballs to the attached to
> see if that is how you would fixed the bug in the original context
> of v2.52 track.  If everything looks OK, then there is no need to
> spend time backporting on your side.  We have everything necessary.

The amended patch below looks correct to me. Peff had some comments
regarding the test that I will work on addressing.

Thanks,
-Justin

> 
> --- >8 ---
> From: Justin Tobler <jltobler@gmail.com>
> Date: Tue, 7 Apr 2026 15:17:30 -0500
> Subject: [PATCH] object-file: avoid ODB transaction when not writing objects
> 
> In ce1661f9da (odb: add transaction interface, 2025-09-16), existing
> ODB transaction logic is adapted to create a transaction interface
> at the ODB layer. The intent here is for the ODB transaction
> interface to eventually provide an object source agnostic means to
> manage transactions.
> 
> An unintended consequence of this change though is that
> `object-file.c:index_fd()` may enter the ODB transaction path even
> when no object write is requested. In non-repository contexts, this
> can result in a NULL dereference and segfault. One such case occurs
> when running git-diff(1) outside of a repository with
> "core.bigFileThreshold" forcing the streaming path in `index_fd()`:
> 
>         $ echo foo >foo
>         $ echo bar >bar
>         $ git -c core.bigFileThreshold=1 diff -- foo bar
> 
> In this scenario, the caller only needs to compute the object ID. Object
> hashing does not require an ODB, so starting a transaction is both
> unnecessary and invalid.
> 
> Fix the bug by avoiding the use of ODB transactions in `index_fd()` when
> callers are only interested in computing the object hash.
> 
> Reported-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> [jc: adjusted to fd13909e (Merge branch 'jt/odb-transaction', 2025-10-02)]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  object-file.c           | 49 ++++++++++++++++++++++++++++++++++-------
>  t/t1517-outside-repo.sh |  8 +++++++
>  2 files changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/object-file.c b/object-file.c
> index 17a236d2fe..0969e27f3d 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1599,6 +1599,34 @@ static int index_blob_packfile_transaction(struct odb_transaction *transaction,
>  	return 0;
>  }
>  
> +static int hash_blob_stream(const struct git_hash_algo *hash_algo,
> +			    struct object_id *result_oid, int fd, size_t size)
> +{
> +	unsigned char buf[16384];
> +	struct git_hash_ctx ctx;
> +	unsigned header_len;
> +
> +	header_len = format_object_header((char *)buf, sizeof(buf),
> +					  OBJ_BLOB, size);
> +	hash_algo->init_fn(&ctx);
> +	git_hash_update(&ctx, buf, header_len);
> +
> +	while (size) {
> +		size_t rsize = size < sizeof(buf) ? size : sizeof(buf);
> +		ssize_t read_result = read_in_full(fd, buf, rsize);
> +
> +		if ((read_result < 0) || ((size_t)read_result != rsize))
> +			return -1;
> +
> +		git_hash_update(&ctx, buf, rsize);
> +		size -= read_result;
> +	}
> +
> +	git_hash_final_oid(result_oid, &ctx);
> +
> +	return 0;
> +}
> +
>  int index_fd(struct index_state *istate, struct object_id *oid,
>  	     int fd, struct stat *st,
>  	     enum object_type type, const char *path, unsigned flags)
> @@ -1620,14 +1648,19 @@ int index_fd(struct index_state *istate, struct object_id *oid,
>  		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
>  				 type, path, flags);
>  	} else {
> -		struct odb_transaction *transaction;
> -
> -		transaction = odb_transaction_begin(the_repository->objects);
> -		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
> -						      oid, fd,
> -						      xsize_t(st->st_size),
> -						      path, flags);
> -		odb_transaction_commit(transaction);
> +		if (flags & INDEX_WRITE_OBJECT) {
> +			struct odb_transaction *transaction;
> +
> +			transaction = odb_transaction_begin(the_repository->objects);
> +			ret = index_blob_packfile_transaction(the_repository->objects->transaction,
> +							      oid, fd,
> +							      xsize_t(st->st_size),
> +							      path, flags);
> +			odb_transaction_commit(transaction);
> +		} else {
> +			ret = hash_blob_stream(the_repository->hash_algo, oid,
> +					       fd, xsize_t(st->st_size));
> +		}
>  	}
>  
>  	close(fd);
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index c824c1a25c..c1dbc6359a 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -93,6 +93,14 @@ test_expect_success 'diff outside repository' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'diff files exceeding bigFileThreshold outside repository' '
> +	cd non-repo &&
> +	echo foo >foo &&
> +	echo bar >bar &&
> +	test_must_fail git -c core.bigFileThreshold=1 diff -- foo bar >actual &&
> +	test_grep "diff --git a/foo b/bar" actual
> +'
> +
>  test_expect_success 'stripspace outside repository' '
>  	nongit git stripspace -s </dev/null
>  '
> -- 
> 2.54.0-rc0-282-gaf2821fd49
> 
