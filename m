Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D43595C
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845710; cv=none; b=DjO5p1uwwVFp/mGgOd8Tz/xqI0mXe7dRtsli/mVJ4dCr5qAE2gfCyEiA2qKSXDYmccQMPRBCKmdOI3xSymyaqc0l0D2OMRuxPpXeWwdMj+JCQlp5d8KfGSiu8ANq5AkkSskgwx7qW77YsW526bhnq1xiMQlu/B0EDTDPsyockoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845710; c=relaxed/simple;
	bh=ougQ+Vj4nNxeZ4HiQg6SLrIAhGUvRwV0pbnvEvUKEPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgU5YqHn6EAX8bEQ7qYIjm15jMsv85cOL5DVOG2cv+FoKTzz4+S0xFc8DurElCjfXEzG3Axjx0dmNcNXCOsJbFkvZqJQtSpi3jE9bwGNI4cmf1wB73VkgeClscXu5QlI0Sbm/jA6QRrq5O2DavU5+YSjdhq/8X2JrdGFxmZz5w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEFKWe12; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEFKWe12"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so16969255e9.0
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752845706; x=1753450506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uS7eAeqI+6D7kj/GVExHf2AKvNAHc/KZjJtMHe/Hf/8=;
        b=gEFKWe12+Npz87ZzWEQFscToLGFG9251xjft36rMUNmucY6LMMnAZOfEIPsSvwdZTu
         HrTS0+WWtwIDSlzolp/WA/SU8xoBRedwM2R6SjGl4b+mdEIr1MrXwyEz+WHU//mBQhJp
         mBLfehwFIkGgYmkx/KLDWpRfVvXBRN83vgPqOlGuFvBtJIDpfB16ZYDhbx1oYtKzgWLd
         udRs9prWcLpkaIvs6epZHbhlmj+TJjgKRm5Ic/0SjgowW0UBGzgwE94M0TmEsJg2qebu
         GWuDLPt28H81I+PMpDDpBQd8hO6k4fTxUZGKMNYqHqgy06f5RseuE9PVjoszsighkl/q
         gXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752845706; x=1753450506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uS7eAeqI+6D7kj/GVExHf2AKvNAHc/KZjJtMHe/Hf/8=;
        b=WAcuALDJAe7aqn+tSTbg3QC+ASRgu+eC5z0u+d/HjDG6mb5aGHCAKhnUVjif0WscwR
         nrdi8QprWrJRiCZ4+CtlYLv1Ur/bYfXKBQiJdP1yAtJoDAdajZVxVWhpp7IyYCAM90C9
         CnFUedFt/OUJkHdiDogsKfkWiC2lBg717JoHc3FZtVKrjfore5pOy0cfXRBOysT5cDFH
         7guU5jgVjsgRQR1BzBEVOYg8yY+K/XGE+v8ULWzdmAexVK8nkTI0iR+WF5pk2+/0M+a+
         M9eGnqU9F4JWGl80GDDkIsdLk+6LMVWhPIFuIcrW31eejSFSKBFUeFvm05o/OP5mIFxG
         aRxA==
X-Forwarded-Encrypted: i=1; AJvYcCXdpi+C5PSqWqULQSzRT/dZX9huWbKAyU2sFh0IZT23CMc1jcVMQDFRjwlXwA9IRVOxMBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzd5LKxd7a//XqPuhYrRK0VCwjGuMLWVLZxMycdnjzR3+wayCj
	VbLo7zZz4D8CCvYixqLC6/AGeenLpDPsmaBaqe2pf9/sOldt3IjuRb0l
X-Gm-Gg: ASbGncvEd0Eb+hbusrJVT+/5HVbelXorTCDgc2/VH9TL8GyX0HRsqG+H7qvFC8jqfwZ
	dwu+bLu0qliArDdjZJKkhfHxs/mvb5Zz/PsA/jpI8LbXjghp431zjztnwqkwrQAG1DlB4nk0u6+
	KGTwYonRbZlWSmy4hvRuyGEM9SFaSgE5twpbYTztqEZF8n+iYW5Nj82liQIZiqqfPTpf6LKariS
	Uanc9YMLnay294BziN+OrYaRRRXm4f4hK1hVxSa943G1oTDdA/tMLrDEjcEG9L391rZZMBxPLcv
	O4GVOohJ2gOsYJmscbpZu8Bnmc1sYrpcX712ujAACgCSoTERQ96IgXj1u5xIFxrT7HhYV4ie0SQ
	iikbO3eaxgjeBdl24ioGICnj8RCi32U/F6qTO7jLAuqeT5HmGkwQwghvj3vUlzF/BLYqTnRUJkP
	74tIY++c8=
X-Google-Smtp-Source: AGHT+IG5htFtblxoyqhfmxB9bWMH0zPIhNEhwPJ5rV9xt481vxCumNSX4/ZcxPCzq7/aq7MDfPctzg==
X-Received: by 2002:a05:600c:5246:b0:456:189e:223a with SMTP id 5b1f17b1804b1-456347b5ccfmr76370565e9.10.1752845706233;
        Fri, 18 Jul 2025 06:35:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:41df:4602:3bdd:d83b? ([2a0a:ef40:7a5:4701:41df:4602:3bdd:d83b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1849556f8f.54.2025.07.18.06.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 06:35:05 -0700 (PDT)
Message-ID: <91f6352f-abc4-4e99-938b-6a56aba2faed@gmail.com>
Date: Fri, 18 Jul 2025 14:35:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Ezekiel Newren
 <ezekielnewren@gmail.com>, "brian m. carlson"
 <sandals@crustytoothpaste.net>, Taylor Blau <me@ttaylorr.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 17/07/2025 21:32, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> A few commits ago, we added definitions for Rust primitive types,
> to facilitate interoperability between C and Rust. Switch a
> few variables to use these types. Which, for now, will
> require adding some casts.

How necessary is it to change char' to 'u8' so long as the rust and C 
sides both use a type that is the same size? Also what's the advantage 
of using these typedefs rather than the normal C types like unit8_t ?

> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 5a96e36dfbea..3b364c61f671 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -418,7 +418,7 @@ static int get_indent(xrecord_t *rec)
>   	long i;
>   	int ret = 0;
>   
> -	for (i = 0; i < rec->size; i++) {
> +	for (i = 0; i < (long) rec->size; i++) {

i is a loop counter and array index so we can lose this cast by 
changeing i to size_t

Thanks

Phillip

>   		char c = rec->ptr[i];
>   
>   		if (!XDL_ISSPACE(c))
> @@ -1005,11 +1005,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
>   
>   		rec = &xe->xdf1.recs[xch->i1];
>   		for (i = 0; i < xch->chg1 && ignore; i++)
> -			ignore = xdl_blankline(rec[i]->ptr, rec[i]->size, flags);
> +			ignore = xdl_blankline((const char*) rec[i]->ptr, rec[i]->size, flags);
>   
>   		rec = &xe->xdf2.recs[xch->i2];
>   		for (i = 0; i < xch->chg2 && ignore; i++)
> -			ignore = xdl_blankline(rec[i]->ptr, rec[i]->size, flags);
> +			ignore = xdl_blankline((const char*)rec[i]->ptr, rec[i]->size, flags);
>   
>   		xch->ignore = ignore;
>   	}
> @@ -1020,7 +1020,7 @@ static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
>   	size_t i;
>   
>   	for (i = 0; i < xpp->ignore_regex_nr; i++)
> -		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
> +		if (!regexec_buf(xpp->ignore_regex[i], (const char*) rec->ptr, rec->size, 1,
>   				 &regmatch, 0))
>   			return 1;
>   
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index 1d40c9cb4076..bbf7b7f8c862 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -24,7 +24,7 @@
>   
>   static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
>   
> -	*rec = xdf->recs[ri]->ptr;
> +	*rec = (char const*) xdf->recs[ri]->ptr;
>   
>   	return xdf->recs[ri]->size;
>   }
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index af40c88a5b36..6fa6ea61a208 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -101,8 +101,8 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
>   	xrecord_t **rec2 = xe2->xdf2.recs + i2;
>   
>   	for (i = 0; i < line_count; i++) {
> -		int result = xdl_recmatch(rec1[i]->ptr, rec1[i]->size,
> -			rec2[i]->ptr, rec2[i]->size, flags);
> +		int result = xdl_recmatch((const char*) rec1[i]->ptr, rec1[i]->size,
> +			(const char*) rec2[i]->ptr, rec2[i]->size, flags);
>   		if (!result)
>   			return -1;
>   	}
> @@ -324,8 +324,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
>   
>   static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
>   {
> -	return xdl_recmatch(rec1->ptr, rec1->size,
> -			    rec2->ptr, rec2->size, flags);
> +	return xdl_recmatch((char const*) rec1->ptr, rec1->size,
> +			    (char const*) rec2->ptr, rec2->size, flags);
>   }
>   
>   /*
> @@ -383,10 +383,10 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
>   		 */
>   		t1.ptr = (char *)xe1->xdf2.recs[m->i1]->ptr;
>   		t1.size = xe1->xdf2.recs[m->i1 + m->chg1 - 1]->ptr
> -			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1]->size - t1.ptr;
> +			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1]->size - (u8 const*) t1.ptr;
>   		t2.ptr = (char *)xe2->xdf2.recs[m->i2]->ptr;
>   		t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1]->ptr
> -			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1]->size - t2.ptr;
> +			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1]->size - (u8 const*) t2.ptr;
>   		if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
>   			return -1;
>   		if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
> @@ -440,7 +440,7 @@ static int line_contains_alnum(const char *ptr, long size)
>   static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
>   {
>   	for (; chg; chg--, i++)
> -		if (line_contains_alnum(xe->xdf2.recs[i]->ptr,
> +		if (line_contains_alnum((char const*) xe->xdf2.recs[i]->ptr,
>   				xe->xdf2.recs[i]->size))
>   			return 1;
>   	return 0;
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index 77dc411d1937..986a3a3f749a 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -121,7 +121,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
>   		return;
>   	map->entries[index].line1 = line;
>   	map->entries[index].hash = record->ha;
> -	map->entries[index].anchor = is_anchor(xpp, map->env->xdf1.recs[line - 1]->ptr);
> +	map->entries[index].anchor = is_anchor(xpp, (const char*) map->env->xdf1.recs[line - 1]->ptr);
>   	if (!map->first)
>   		map->first = map->entries + index;
>   	if (map->last) {
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index ad356281f939..747268e4fdf7 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -96,12 +96,12 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
>   	char const *line;
>   	xdlclass_t *rcrec;
>   
> -	line = rec->ptr;
> +	line = (char const*) rec->ptr;
>   	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
>   	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
>   		if (rcrec->ha == rec->ha &&
>   				xdl_recmatch(rcrec->line, rcrec->size,
> -					rec->ptr, rec->size, cf->flags))
> +					(const char*) rec->ptr, rec->size, cf->flags))
>   			break;
>   
>   	if (!rcrec) {
> @@ -159,7 +159,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   				goto abort;
>   			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
>   				goto abort;
> -			crec->ptr = prev;
> +			crec->ptr = (u8 const*) prev;
>   			crec->size = (long) (cur - prev);
>   			crec->ha = hav;
>   			recs[nrec++] = crec;
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index 8b8467360ecf..6e5f67ebf380 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -39,9 +39,9 @@ typedef struct s_chastore {
>   } chastore_t;
>   
>   typedef struct s_xrecord {
> -	char const *ptr;
> -	long size;
> -	unsigned long ha;
> +	u8 const* ptr;
> +	usize size;
> +	u64 ha;
>   } xrecord_t;
>   
>   typedef struct s_xdfile {
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 444a108f87c0..10e4f20b7c31 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -418,10 +418,10 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
>   
>   	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1]->ptr;
>   	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2]->ptr +
> -		diff_env->xdf1.recs[line1 + count1 - 2]->size - subfile1.ptr;
> +		diff_env->xdf1.recs[line1 + count1 - 2]->size - (u8 const*) subfile1.ptr;
>   	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1]->ptr;
>   	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2]->ptr +
> -		diff_env->xdf2.recs[line2 + count2 - 2]->size - subfile2.ptr;
> +		diff_env->xdf2.recs[line2 + count2 - 2]->size - (u8 const*) subfile2.ptr;
>   	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
>   		return -1;
>   

