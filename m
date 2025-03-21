Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBDB2AF1B
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591290; cv=none; b=X9nj96D3ouR35sMfn/mnFk2JCKnvTxNDfEVQlNv1kE88oDnwCbbc0pUTcOTmoAUWBnkJ/1QuV0j3cObzNJIF7FzhuXrxsBcRWWVHE3OUQDpqlXOXVLX3l58CNIL2sfvchP7NcJLqELNSXZq1jy9KLticHhrzw9pcc2SbzjNXr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591290; c=relaxed/simple;
	bh=UO5QoE96EaJVCP5G36ERKlPwY740fpBNIEy4I5bR+vQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=WXgupNTTowrfuEri+R8usf2jZmKE0jfsCUw7Y4ziaajcKS1JmgoO0Zew8Yu0NV6XXr7McP1rdeDb5wuVDEO6dvYCKIye5XETz9RwBJA32Puue2JJm1KHMdUry51Vo3wKrV69gjSPaR2h3FPpNBS8/iWpHB+RWgvhjcgCXS/Kk00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBGC6icj; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBGC6icj"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86d42f08219so1020544241.0
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742591287; x=1743196087; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8UXuoFlC4OYsU3mZfLAvxQxnZatPS5Bl7GtEg6uGJ3Q=;
        b=PBGC6icj+ohCiSlzhidMG/GHJ9zarVmPbPwEu5nXtmhyiG+WM5gpc6NjgoiUM6MxZT
         jp18c5tIjKhQJFEmiWc/fH/DZUPIP0JfvSNY88zu1CCTu8w8TY6l7GBWKPnPjyKBLFgK
         Gy6aSfSLjc0GURZFQADFrLftJHn72wu/rhRR7/ohGBDIxm08KJdH1U3xT3J085ow02Cr
         uCjYCs25qau9Kw9N4za+SQj4YSwbY+Vmm1FRcp1CA2IsRGcTFabSa9CDtAcCeM5bTZHo
         N+SP8wQnzqnqS2ZCxUSjnFX4NkSFWCr7H3HRgZP2CrwSM56ch6UyxSaF0nFrkQcp2VFr
         J7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591287; x=1743196087;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UXuoFlC4OYsU3mZfLAvxQxnZatPS5Bl7GtEg6uGJ3Q=;
        b=A4IuVOzwtLdP/ubgcEsdvnRG2gmN60jmi0mgFKxRxGh4GpEi5KWhQw3cDIR+3poCzO
         Nd2RbC6Trhsl/3H3FKa6DK5nvNk9fOwxF7ioRg3jSEMPCSaamfDWutgomdlNKmYwP9YU
         Da+x9GEQV9BDmmDi8rH6RqefUrbIVU7IT4HdcvJmJF4/KLowB5ewM7nGsM020VxHoVl/
         ktRKztUJFiMHBy41c7YKGgWsCLR6HBFpukl5Zd9MiK0r3dRCIKhLPXG+qGTIuks6GzZO
         Q84VpQvP3aRlgIwrtnJJER/QL2CH2/tFHxOtj1VMeMedXW7qKx8Eb+Mn5lMJbG4WQNQL
         fm6w==
X-Forwarded-Encrypted: i=1; AJvYcCV39MsW1RzHZ6PnRYNR/fCuImcKUNI2Qs04MoHFazqt3Ue6MMJs+4nVSkD4FR2IQpzRQPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCLiSjeio2OZVJGGWYbiiISqD2tKQDfpXpCHXry/AIT8KbHzV
	6/qpOUbMDkK5e3AQl0iOVh6Bw27cIiL2lnunq6yBhY9JKwbyhkXwcPM0VbaJ7iI+ef9AZ6mIbGH
	2azcGsA7O2eVT9ozek3HBCarEty3yCJ0l
X-Gm-Gg: ASbGncuNz+aUjE2Khegjnz7JHmfKSs7+5Pw1TL67IzRqSbehBwTMLu0WwqlfmBZtogf
	mJfbyixlDPb5CaPiJBn7+BHzkVe8XPXs9/o2rOrZ9x6vN7AxtFXy8q3HNHx2WPm2GJ9abtAHgQJ
	oiaWNUbbvolFqDx30oy1NcCdfKqPX1wLkw5orvBVwJyQzjbpP428RjxZ43ZWd2
X-Google-Smtp-Source: AGHT+IHfbzNdTxVxc+4jbTNeUu8e+msNkHPwW3/CpcFkMgJTZ8MPUf49f+RvvF5kLmFrXkssBTbNXsEZiJLGNyAGP2c=
X-Received: by 2002:a05:6102:2ad5:b0:4c4:e42c:38ba with SMTP id
 ada2fe7eead31-4c50d4fa2a8mr4202722137.13.1742591287356; Fri, 21 Mar 2025
 14:08:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Mar 2025 17:08:06 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250321200715.3338-1-taahol@utu.fi>
References: <20250321200715.3338-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Mar 2025 17:08:06 -0400
X-Gm-Features: AQ5f1JqW2ZOFw0_IRfP-u-qvvOScSB5IrXS2vouu1Wipm8mIUhi0xl2psbN_itw
Message-ID: <CAOLa=ZRN5m0bccMdabUYwNJLg4HX6jcOe3PN-aBTHXBOuM71hw@mail.gmail.com>
Subject: Re: [PATCH] bulk-checkin: fix sign compare warnings
To: Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ac0a550630e0a654"

--000000000000ac0a550630e0a654
Content-Type: text/plain; charset="UTF-8"

Tuomas Ahola <taahol@utu.fi> writes:

> In file bulk-checkin.c, three warnings are emitted by
> "-Wsign-compare", two of which are caused by trivial loop iterator
> type mismatches.  The third one is also an uncomplicated case for
> which a simple cast is a sufficient remedy.
>

Nit: it would be nice if you expanded on why 'a simple cast is a
sufficient remedy' and more importantly how that casting is safe.

> Fix issues accordingly, and enable sign compare warnings for the file.
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  bulk-checkin.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 20f2da67b9..0133427132 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -3,7 +3,6 @@
>   */
>
>  #define USE_THE_REPOSITORY_VARIABLE
> -#define DISABLE_SIGN_COMPARE_WARNINGS
>
>  #include "git-compat-util.h"
>  #include "bulk-checkin.h"
> @@ -56,7 +55,6 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
>  {
>  	unsigned char hash[GIT_MAX_RAWSZ];
>  	struct strbuf packname = STRBUF_INIT;
> -	int i;
>
>  	if (!state->f)
>  		return;
> @@ -82,7 +80,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
>  	finish_tmp_packfile(&packname, state->pack_tmp_name,
>  			    state->written, state->nr_written,
>  			    &state->pack_idx_opts, hash);
> -	for (i = 0; i < state->nr_written; i++)
> +	for (uint32_t i = 0; i < state->nr_written; i++)
>  		free(state->written[i]);
>
>  clear_exit:
> @@ -131,14 +129,12 @@ static void flush_batch_fsync(void)
>
>  static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
>  {
> -	int i;
> -
>  	/* The object may already exist in the repository */
>  	if (repo_has_object_file(the_repository, oid))
>  		return 1;
>
>  	/* Might want to keep the list sorted */
> -	for (i = 0; i < state->nr_written; i++)
> +	for (uint32_t i = 0; i < state->nr_written; i++)
>  		if (oideq(&state->written[i]->oid, oid))
>  			return 1;
>
> @@ -192,7 +188,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
>  			offset += rsize;
>  			if (*already_hashed_to < offset) {
>  				size_t hsize = offset - *already_hashed_to;
> -				if (rsize < hsize)
> +				if ((size_t)rsize < hsize)

Something I found peculiar here is that `rsize` is of type ssize_t'.
But it only seems to store a positive value.

>  					hsize = rsize;
>  				if (hsize)
>  					git_hash_update(ctx, ibuf, hsize);
>
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> --
> 2.30.2

--000000000000ac0a550630e0a654
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 52eed25dccbdfa1a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mZDFUVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0lrQy85Z3pod2x4UXJKNm5BMzkrNHVYdDJhc1FURgpkc3Bkc3c3SEcr
Nms5WFY5QSt5MlV0ekYzQVhXbWFpcEEyUlhqM3o4aDAwaU9qZ0hEOGxuWUErUTJPOW5OZXJ6CkI4
NVd6ejNZSzJSZU1jRzFtaHJxV2lLTThsY3lzV0NlU201VUUyUmpQbHl4a1BIQ2lwaGIrTGQvbXBC
eVlLVjcKSTI5UWZNL29jQ2UyVCtMK0xpNDlxLzl0WUpnQ2FwL0E3cHpHWWhZMVpGRUpZYjZQY0NN
UEttQkhWZnhmR1FONgpNSGtUb2J0OWNJbEJxc29rZ3lhUjFYdGtPb2ZxMEx3VnB6Zk9IOGF2bVJX
dFQ4QllMZFM1eHNRelFwSHNySG5HCmNna1FoSDVNVUJoSW4vdTNKaHNaRFVINHh0LzBDNVlwY1BD
QlZJQ0VWajFxUm9QTDFoMTVaaklhQlJZamNWY3YKM0V6U0RwcE9wSm5lbkhLdmlGRlN4c0QxNGIr
emVzQjZyVzhHTXV5Z1g4dnRhYlVTd0NhRlZEUmVQeWVZQVpPSAozS2JXeVg4Vm1lamphWjRyeWd1
Rlhnck1ZeXZGNGNOMFNhNS9PWHFRTklyYi9KQjVwSGt5bmUzdGpMOHpBVVAyCndCd2JUTng2ZXNu
cHpMUEVBZzZGLzhlTzQwekhZOC9HVnBFMmZIYz0KPWwrc0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ac0a550630e0a654--
