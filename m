Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D718DF6D
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119931; cv=none; b=iMaLi5XC1VPfW+nzqqPZY0LwEiUlnKT+ZbVqiXqYTTBuzU2InGVsKpIOGdCDvVEybl1XO55q8Q+9UUkq44rc4UMHm2fOSTE6TwAMykYX9aVUu+6iDy58Tt3VpDta6M4g8W/s3YFrxfbRkQVz/HsaUoSu1kylBo0NElHm5y45wRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119931; c=relaxed/simple;
	bh=6v/SmNZAmKHY7w3uanRv2ANSTcxLgxRuWDHSXmkuQoo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuqF3LLcn6GvQQ734YQnTNkPiP8/9B9xKyNUImOgjQ7cYpuysUPlBTYHHQVrsWbEdnt3E5BYHJvJc6ZwduaCF/4o+IfOcaefaB76xGkeZ5gBJNjGh3AseRJkRX5wELAjE/UgYqBHQbs0fm0fcDkfnScQu4vytFlXbpwnsuiTdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQUNaKtt; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQUNaKtt"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-264545214efso481577fac.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 05:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723119929; x=1723724729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6pm7Yq1q20tsdgW0EOETxBVnzMsnUzC5uhtz0UzNK60=;
        b=FQUNaKttFOGVvZorz2psAd3Yoq6WET8U8LQmsB0D9aTiVW5GfwAKBKlyoRSnj8+Xpp
         Hqog7hNIdWkXalQs7rpcpWdq//6PAdIJ2OoK8qfjtPy8Ix0ximJetSKh0o0GtWcFKyJb
         sPT+uqpjkQhgFs3pD0W43vJy9GTNZMT44c0bhYA5Zysa98Bjc+yqjc04onFKpDxGwilz
         Kwv0nz1J83e89+yhXD7nO/V4YfwAOFk6+Dk8/KtFT5sPOJIMRfaGXMXfMOeDeWo/XA/j
         AaQoucfQEJnS9qYiVV8+QP2cPsiBJN0EiyVdV4kTieOV4aquNtM/IIFLoUjcQQ5moJO3
         2cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119929; x=1723724729;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pm7Yq1q20tsdgW0EOETxBVnzMsnUzC5uhtz0UzNK60=;
        b=E/BquzFo6q7w0aYLy6FeFvtcCc8eVYRVfwf8AQJd5BtxFVbRaJGEp9cjynKsT3Ci7G
         CL4mubRtegPtVSInGETtikVnCe+qWuUonlkLs+iFjGmLWzXMPf9uWU7939GDMZPiEJj5
         Vo3EcmENvnS20bJv6qNdCDwhrPp8HM32lbAE6nKxCayIF5Jw0L2Ny0Rwtp6gzeMzhVOl
         XJcb2d2dPZnNVBUdcDE7kMPTd/pBHde/El9UVLlEuAy4gU97QWAdvUgM4gSwN0NBd3fL
         5lfCa878ZuPxBXVcW+ASNXKOR4Zoyex+dOVyUSLZzVCMt0Ne9bVYWFCyYHt9c77ywK5w
         bXng==
X-Forwarded-Encrypted: i=1; AJvYcCWr743Sq0JcYBvCuqZrd0SM/tcSRPsyIJy8Wl+SpT12ezgE584vzHak30BqnynLF84YP4RkqeKQ82uG+NYjP2FtajYz
X-Gm-Message-State: AOJu0YwxELRP8UeM4N+D9M9P8n5ZJtwMPGpG/9mnu+By/B4s/FaXTSnJ
	eqMLQlatSuDULpPXgibkvRwzVD9fVSUtlj6JOKMYM/G6CIczmuodVK7U7G2SOgvi1m2Lv0Ge6MT
	mLkQMe5TOhJRxneUojxTbR3fcIf8=
X-Google-Smtp-Source: AGHT+IFJqKWK9cpPmS/nMmYIYBek9NhDIBR/Ix49umc3kcEm382Wr9GKLIFCrC/NBxeZ8rGMM3SHyOQlHap8v9NxyZ0=
X-Received: by 2002:a05:6870:d284:b0:25d:fc34:ba6a with SMTP id
 586e51a60fabf-2692b6a1e56mr1854186fac.26.1723119928918; Thu, 08 Aug 2024
 05:25:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Aug 2024 05:25:27 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <1ef560feb1906c160ad7c81a30e9bd4fc92d2eca.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im> <cover.1722862822.git.ps@pks.im> <1ef560feb1906c160ad7c81a30e9bd4fc92d2eca.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 8 Aug 2024 05:25:27 -0700
Message-ID: <CAOLa=ZSJXdH-C6VcWoFbPV6z7Rb1_TFx-6N=nseeNP320xubzA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] reftable/stack: handle locked tables during auto-compaction
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000044ed22061f2b1f33"

--00000000000044ed22061f2b1f33
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When compacting tables, it may happen that we want to compact a set of
> tables which are already locked by a concurrent process that compacts
> them. In the case where we wanted to perform a full compaction of all
> tables it is sensible to bail out in this case, as we cannot fulfill the
> requested action.
>
> But when performing auto-compaction it isn't necessarily in our best
> interest of us to abort the whole operation. For example, due to the
> geometric compacting schema that we use, it may be that process A takes
> a lot of time to compact the bulk of all tables whereas process B
> appends a bunch of new tables to the stack. B would in this case also
> notice that it has to compact the tables that process A is compacting
> already and thus also try to compact the same range, probably including
> the new tables it has appended. But because those tables are locked
> already, it will fail and thus abort the complete auto-compaction. The
> consequence is that the stack will grow longer and longer while A isn't
> yet done with compaction, which will lead to a growing performance
> impact.
>
> Instead of aborting auto-compaction altogether, let's gracefully handle
> this situation by instead compacting tables which aren't locked. To do
> so, instead of locking from the beginning of the slice-to-be-compacted,
> we start locking tables from the end of the slice. Once we hit the first
> table that is locked already, we abort. If we succeded to lock two or

s/succeded/succeeded

> more tables, then we simply reduce the slice of tables that we're about
> to compact to those which we managed to lock.
>
> This ensures that we can at least make some progress for compaction in
> said scenario. It also helps in other scenarios, like for example when a
> process died and left a stale lockfile behind. In such a case we can at
> least ensure some compaction on a best-effort basis.
>

Right. This is really well written.

[snip]

> @@ -1052,19 +1062,47 @@ static int stack_compact_range(struct reftable_stack *st,
>  	/*
>  	 * Lock all tables in the user-provided range. This is the slice of our
>  	 * stack which we'll compact.
> +	 *
> +	 * Note that we lock tables in reverse order from last to first. The
> +	 * intent behind this is to allow a newer process to perform best
> +	 * effort compaction of tables that it has added in the case where an
> +	 * older process is still busy compacting tables which are preexisting
> +	 * from the point of view of the newer process.
>  	 */
>  	REFTABLE_CALLOC_ARRAY(table_locks, last - first + 1);
> -	for (i = first; i <= last; i++) {
> -		stack_filename(&table_name, st, reader_name(st->readers[i]));
> +	for (i = last + 1; i > first; i--) {
> +		stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
>
>  		err = hold_lock_file_for_update(&table_locks[nlocks],
>  						table_name.buf, LOCK_NO_DEREF);
>  		if (err < 0) {
> -			if (errno == EEXIST)
> +			/*
> +			 * When the table is locked already we may do a
> +			 * best-effort compaction and compact only the tables
> +			 * that we have managed to lock so far. This of course
> +			 * requires that we have been able to lock at least two
> +			 * tables, otherwise there would be nothing to compact.
> +			 * In that case, we return a lock error to our caller.
> +			 */
> +			if (errno == EEXIST && last - (i - 1) >= 2 &&
> +			    flags & STACK_COMPACT_RANGE_BEST_EFFORT) {
> +				err = 0;
> +				/*
> +				 * The subtraction is to offset the index, the
> +				 * addition is to only compact up to the table
> +				 * of the preceding iteration. They obviously
> +				 * cancel each other out, but that may be
> +				 * non-obvious when it was omitted.
> +				 */
> +				first = (i - 1) + 1;

I remember thinking about this and how to fix it, I'm happy how you've
done it. It's simple and sufficient. Kudos.

[snip]

Overall this patch looked great. I have nothing to add, I really like it
that we use a flag and this means this would only come into play for
auto-compaction.

--00000000000044ed22061f2b1f33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 35ba60b75977df07_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hMHVUWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGxmQy80MXBmc1lscWJVWGVsVmtwWUtqbXdLTXdEeApTUHJIYU50NTRN
d3QxOGFMMkkzV1NVTkVwZlNoRnV0d05KT0JZUTB3YjgxczhNVjRRR2VQRWdnWFBJNE1xQzNyCk43
blNXZ0hta1VnNjFPWE9TSUgzNWttVWNEeTBKd3FJWDByQkYzd1JkT05PNDRVVFhnbE5IWnVpTDY0
czFhck8KcWNDVEl6aUlJbG1hZ25xZ1BCekFVTXpJQjNxL1FIbFp4S3RJNVhwT1hRTEF1dUpNRjFU
NlY1Q20yWVBDaHRXSgpsZFZsSGlFUmxYamQ5M2tPbE93eUkvaUUzVU9ieFhKeXBCZXM0VVhGVlZJ
U3AwT293Z3JQbU9LOTd5K0NERWFXCllUSDNvUC9PUzN6K3ZhNHNQY3g3eFNMMXJveEtNSWJGUHFB
b1pLa0xsZjdlbi9wK09aZzBMQzJPSGJFTm1mdTQKemdTMmFqcFV5Uk14WDlnNTZ0RHFkRWV6cW1G
MkM3RXN0UEsvb1U5UHRZT0s4bStFWTJEd3dzZWxSTEZaYU04OQpqK3pnSFdvWURTSnRha2RMVFYy
eG82aG1Oc3pxSXYxaFZJdU9TSzgzaWZaS2pGMHFYSEwxWFBJWXNIdkVyNUNQCkdTSGY5QzV2ck1p
Rlp2a25taHRyWG5Ob1RjKzBOYy9uS1Jhb1BrOD0KPTdDTVgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000044ed22061f2b1f33--
