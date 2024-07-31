Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7556016D304
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463073; cv=none; b=Psa4w1szqgBaPY0JWu16ACza96rwqEWas86Xa1b0LPk6JCvXK1gJ1LkpDNoJBwm3Ns+vbl8/PaKl2wcNJiB3hYUCMn9Fn1mTXZzvVSfuiw+cLupKM2bL+r66NFTyoWvtVguE+V9t3IhkI+BbiGxzDLJBv2Ob5Tw8i12qr3xrNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463073; c=relaxed/simple;
	bh=XZMtLE0pOrvSlJ0inaUwMtgKIzWkPXM1aA/EZ170ars=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nx2QbyqhNB78RDnXmBRLwOcwd4HH/UaqKMLP5wNoPJ41GyiwtUVfNs+r+4heQcil32rup8Vnp+K5v9KtOlq+56/YWVMEQweR/ayKFiZaxWMBi3mZEqRbUMYj89tqZN1Pg68fWlZmeBmZ1bC5JW88vwsT0zxwuPAKq+dCDVku0U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbJAjDse; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbJAjDse"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d59e491fefso2778028eaf.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722463070; x=1723067870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWQl38r0Ot+MWSz2bDt4qNS/xj1n54xSfwp1/fuyO7E=;
        b=PbJAjDse9ePs2YlUDojg7b/fyFcpL92uYLOsIDre5oU3jyIVV4MSTKh4F2M8jbVnQk
         V5GuJ4YHDcmv/tFAQr6qF1HVisAJnCGUxnY8x6ALI4054uWAjf9YD84qaQNyces30MGE
         oP2Icoue01j/Tef07kOLYCxLpoonoOlxGP7DilrXyO7+7C97U6M0lyDg6ot1B31gwz7r
         k2qp+7WUrx7HEGJzQGmSiO6ifxFtSwF0XQviRkdnwealvtkGhaFudFrluMZmONkLDiPf
         VW0VJhan6JUfyqNVkVL4vgr3DPHHuDISM8yZFqpeAYfhWn9FyDRodLgEGWtYQxqW1rLQ
         FoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722463070; x=1723067870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWQl38r0Ot+MWSz2bDt4qNS/xj1n54xSfwp1/fuyO7E=;
        b=qCUkEze1ciiuVdr/8hOcOkZN2IouDLv8/lGwRjsqeHzpd9oPiIATqTTQhYp3Q5lnl5
         PJoFRnnDrZ211PGO6hJ7TKQFqtd5BsEvWlxV+wtMVvfO5slW5oM0crYmS9N8IqBVsNot
         lx3jDtIFinkTcDr2F9+kbZusbPvYHVWzWXWprmCCaHr0MTMVR5BaRQQe/Gbgfc1VhRIt
         1epxlZW80BtBR54ZixlJR5Hr9gnHKLmqczp8y0Z54UHpljZS+HT5RMXqa1PZ9v5spUxh
         YL+9VUFRolD3mSiAsxTJNDJSW7xd6jDzkT/B65plDUPP7JBQ4S3mL7VusMIxu46DuUUC
         HelQ==
X-Gm-Message-State: AOJu0YwxUd+vd9ITFFx9/FNQyRtRWxTQh9O461+gFmCcy/Xcyfgunid6
	cPiHNK8AiSyD+emPZbNt5/U3usQu+PvhwCtSooKnaZXLjgi37BdR
X-Google-Smtp-Source: AGHT+IF1NMHRFLEXiR910+jXbaYKo8vnmN7Zmo1+FSgvj68aSvVVQno9I0R3piMAspiDbPCMe/90fg==
X-Received: by 2002:a05:6820:1b91:b0:5d6:c77:fb8f with SMTP id 006d021491bc7-5d61e3e2b67mr1180662eaf.0.1722463070308;
        Wed, 31 Jul 2024 14:57:50 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d5b3677e4bsm1539550eaf.34.2024.07.31.14.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:57:50 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:57:05 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/8] reftable/stack: simplify tracking of table locks
Message-ID: <xypzh23sibadweiyhkbg5tsij3k6zs5u5pwqouiah3aez25gqm@rnmfa2ir6jzb>
References: <cover.1722435214.git.ps@pks.im>
 <40d9f75cf20d4b76adb1683709e054e264d4e06f.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d9f75cf20d4b76adb1683709e054e264d4e06f.1722435214.git.ps@pks.im>

On 24/07/31 04:15PM, Patrick Steinhardt wrote:
> When compacting tables, we store the locks of all tables we are about to
> compact in the `table_locks` array. As we currently only ever compact
> all tables in the user-provided range or none, we simply track those
> locks via the indices of the respective tables in the merged stack.
> 
> This is about to change though, as we will introduce a mode where auto
> compaction gracefully handles the case of already-locked files. In this
> case, it may happen that we only compact a subset of the user-supplied
> range of tables. In this case, the indices will not necessarily match
> the lock indices anymore.
> 
> Refactor the code such that we track the number of locks via a separate
> variable. The resulting code is expected to perform the same, but will
> make it easier to perform the described change.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index e5959d2c76..07e7ffc6b9 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1016,7 +1016,7 @@ static int stack_compact_range(struct reftable_stack *st,
>  	struct lock_file *table_locks = NULL;
>  	struct tempfile *new_table = NULL;
>  	int is_empty_table = 0, err = 0;
> -	size_t i;
> +	size_t i, nlocks = 0;
>  
>  	if (first > last || (!expiry && first == last)) {
>  		err = 0;
> @@ -1051,7 +1051,7 @@ static int stack_compact_range(struct reftable_stack *st,
>  	for (i = first; i <= last; i++) {
>  		stack_filename(&table_name, st, reader_name(st->readers[i]));
>  
> -		err = hold_lock_file_for_update(&table_locks[i - first],
> +		err = hold_lock_file_for_update(&table_locks[nlocks],

Tables in the list are locked in reverse order. Previously, the locks
were also added to `table_locks` in reverse order. This could leave some
elements empty at the beginning if only a subset of tables are locked.
Now each table lock is added starting from index 0. This means the
contents of `table_locks` are now in a reversed order.

Ultimately, this makes no difference though because all the usages also
have updated `table_locks` accesses meaning the same order is maintained
in practice.

So far makes sense :)

>  						table_name.buf, LOCK_NO_DEREF);
>  		if (err < 0) {
>  			if (errno == EEXIST)
> @@ -1066,7 +1066,7 @@ static int stack_compact_range(struct reftable_stack *st,
>  		 * run into file descriptor exhaustion when we compress a lot
>  		 * of tables.
>  		 */
> -		err = close_lock_file_gently(&table_locks[i - first]);
> +		err = close_lock_file_gently(&table_locks[nlocks++]);
>  		if (err < 0) {
>  			err = REFTABLE_IO_ERROR;
>  			goto done;
> @@ -1183,8 +1183,8 @@ static int stack_compact_range(struct reftable_stack *st,
>  	 * Delete the old tables. They may still be in use by concurrent
>  	 * readers, so it is expected that unlinking tables may fail.
>  	 */
> -	for (i = first; i <= last; i++) {
> -		struct lock_file *table_lock = &table_locks[i - first];
> +	for (i = 0; i < nlocks; i++) {
> +		struct lock_file *table_lock = &table_locks[i];
>  		char *table_path = get_locked_file_path(table_lock);
>  		unlink(table_path);
>  		free(table_path);
> @@ -1192,8 +1192,8 @@ static int stack_compact_range(struct reftable_stack *st,
>  
>  done:
>  	rollback_lock_file(&tables_list_lock);
> -	for (i = first; table_locks && i <= last; i++)
> -		rollback_lock_file(&table_locks[i - first]);
> +	for (i = 0; table_locks && i < nlocks; i++)
> +		rollback_lock_file(&table_locks[i]);
>  	reftable_free(table_locks);
>  
>  	delete_tempfile(&new_table);
> -- 
> 2.46.0.dirty
> 


