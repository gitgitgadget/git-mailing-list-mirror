Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A218A956
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119259; cv=none; b=ZKOmtMl7LN5kHs5V6hLH2HJrYQFuQ50X2J6qe49WNBfPq2dMbunLz4Huh56uO8WGevxXG8Ex1q6PiJnvFpwSzHJ02Z/iysxV5maa6UxQ48VrBA9Nx6zcwUBQ/wA0CidiKswtkAfokZsSMcs+irrkqnm5fmNtSachhFUPhVmk+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119259; c=relaxed/simple;
	bh=laFXlzDr5yU4EO42TjmRtxv+Xdds8iV/L0VQJCkF+98=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIkNI1ei5ecL/e1rcmy0hJ7mAsbYEUa2/aCzmxZJth5GGgEBTpjtBghyF4YU+9LG3nd9eocP+0sHL7lwgCM0t/4aU6n1bvr5lHqqEDhMdrrp97UF4vFiIX8clXzluZ1hd6ooKi8iWjdMKu1nWjmfOEKp6MDulXWEhou3o0kqF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYFEzwHU; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYFEzwHU"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5c7f23f22so460308eaf.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723119256; x=1723724056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KdX+CzrbNAoCE+Om4qS+XuWzOc+Tq3TlUo+xe5Cabms=;
        b=lYFEzwHUSYQZvWnImkDhvJAnfzZv3N0Dio9LmquA+Q+LoPfL/tHLo+YzF++9mBKUbm
         SxsWRMJ4n67Q5Vg5XH/sDteWpUtiNQxkvY6YvjOoUJ7zJRUw5nv1CQaO1E3kDbsY9pPb
         apQd5xx9bwcwJvdL/uBhWFaL7GtIqQpDs3i2gecizzSrbx+tpaxBmb2Rbv5/zBUTR4ey
         9nj041wgiI7+ucYe0O0AQitwza1qyEIsc25x0STbWvj8SoTU4/7oY5tGaPGplNP1SbG1
         y+t1B6YS2rDt6iIMOlDg83x+h4BEkTI8sKY96eri9B5hacOzyTmn76W7smetQlIV9VFZ
         LA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119256; x=1723724056;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdX+CzrbNAoCE+Om4qS+XuWzOc+Tq3TlUo+xe5Cabms=;
        b=pKy6isjg6wBzV+4wlZO1p94DV/ApLCOsLk5rNA3tP58E+aseGJfj71BSDM11Z3syQM
         fnH++x8kIFzEvffwPlSOuSezO/qatVm3vZncnAfc5YwS1hulvog12jIWSDKza4eTPIBC
         8GdwLtf1KxaLk/XlajlBY0nPCpWSkFCg0VQcRw2bGAMngXnoKRJrLyCoBQDi5OytaQ/z
         p1clZlnhPtPcav4QGbSt1G2ZQb/Id3Pd/h1Lf1JRmyc6o3FAL682bzyvdsOsaqv4Xx0X
         IpGcZVEURY2LPio5ActV67+tBC6vXQPncJV+JTJ8N2q0hF0e4Xg4uev3BKzalHYf5g7V
         QE5A==
X-Forwarded-Encrypted: i=1; AJvYcCXE09j7ps6CBA9e7XnlhTty+fX3B474LJuKfQSTi488Ncs35vmPHxYsGfnyi30HZk1b9YE21H4xcPWhBZtmvxxNcZLD
X-Gm-Message-State: AOJu0Yxe7s866kmQIvxPLnRgiRMaerGP2g/VSfoBV9N5hDM/CM6o7S6m
	ZLOXtIdemjyv12ZoTmO5jv7Kl1LcLosckBl/CM3xXE/emmF1AlpXaRo5E0XdkA8q8R7N6/ViylY
	Rwes74JaK+1SRHBIgvwYp/HKxFWM=
X-Google-Smtp-Source: AGHT+IEXKoFTG8keBXjYBxJdF93CF8YUyJ4vcVtzhhZVkibpbi5FoSIlq6OfSWh7OWkk1zK+KzYi/D6zbu2z8fWLWSQ=
X-Received: by 2002:a05:6820:270a:b0:5d6:10e1:9523 with SMTP id
 006d021491bc7-5d855bc9b6emr1524944eaf.3.1723119256200; Thu, 08 Aug 2024
 05:14:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Aug 2024 07:14:15 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ff17414d261065d9eff01335040f5aca3a048059.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im> <cover.1722862822.git.ps@pks.im> <ff17414d261065d9eff01335040f5aca3a048059.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 8 Aug 2024 07:14:15 -0500
Message-ID: <CAOLa=ZSF_8axZ2EP6q5ac6oQiYzcQTuscLfQj=p82k=9KuyTgg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] reftable/stack: fix corruption on concurrent compaction
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000002c0bc6061f2af716"

--0000000000002c0bc6061f2af716
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The locking employed by compaction uses the following schema:
>
>   1. Lock "tables.list" and verify that it matches the version we have
>      loaded in core.
>
>   2. Lock each of the tables in the user-supplied range of tables that
>      we are supposed to compact. These locks prohibit any concurrent
>      process to compact those tables while we are doing that.
>
>   3. Unlock "tables.list". This enables concurrent processes to add new
>      tables to the stack, but also allows them to compact tables outside
>      of the range of tables that we have locked.
>
>   4. Perform the compaction.
>
>   5. Lock "tables.list" again.
>
>   6. Move the compacted table into place.
>
>   7. Write the new order of tables, including the compacted table, into
>      the lockfile.
>
>   8. Commit the lockfile into place.
>

This summary helps a lot, thanks!

[snip]

> @@ -1123,6 +1125,100 @@ static int stack_compact_range(struct reftable_stack *st,
>  		}
>  	}
>
> +	/*
> +	 * As we have unlocked the stack while compacting our slice of tables
> +	 * it may have happened that a concurrently running process has updated
> +	 * the stack while we were compacting. In that case, we need to check
> +	 * whether the tables that we have just compacted still exist in the
> +	 * stack in the exact same order as we have compacted them.
> +	 *

But as per the current implementation, the tables we compacted would
always exist in tables.list, since we've obtained a lock on them.

Looking at the code below, wouldn't it be more ideal to talk about how
there are two scenarios we need to handle?
1. Stack is upto date, there we simply overwrite the stack with our
modified version.
2. Stack is not upto date, in this scenario, we need to amend the stack
without loosing out information. An extra check here is that we also see
that the tables we compact are still existing. (I don't really get, why
they wouldn't be though).

> +	 * If they do exist, then it is fine to continue and replace those
> +	 * tables with our compacted version. If they don't, then we need to
> +	 * abort.
> +	 */
> +	err = stack_uptodate(st);
> +	if (err < 0)
> +		goto done;
> +	if (err > 0) {

So this is the scenario where the stack is no longer upto date.

> +		ssize_t new_offset = -1;
> +		int fd;
> +
> +		fd = open(st->list_file, O_RDONLY);
> +		if (fd < 0) {
> +			err = REFTABLE_IO_ERROR;
> +			goto done;
> +		}
> +
> +		err = fd_read_lines(fd, &names);
> +		close(fd);
> +		if (err < 0)
> +			goto done;
> +
> +		/*
> +		 * Search for the offset of the first table that we have
> +		 * compacted in the updated "tables.list" file.
> +		 */
> +		for (size_t i = 0; names[i]; i++) {
> +			if (strcmp(names[i], st->readers[first]->name))
> +				continue;
> +
> +			/*
> +			 * We have found the first entry. Verify that all the
> +			 * subsequent tables we have compacted still exist in
> +			 * the modified stack in the exact same order as we
> +			 * have compacted them.
> +			 */
> +			for (size_t j = 1; j < last - first + 1; j++) {
> +				const char *old = first + j < st->merged->stack_len ?
> +					st->readers[first + j]->name : NULL;
> +				const char *new = names[i + j];
> +
> +				/*
> +				 * If some entries are missing or in case the tables
> +				 * have changed then we need to bail out. Again, this
> +				 * shouldn't ever happen because we have locked the
> +				 * tables we are compacting.
> +				 */

Okay, this is exactly what I was saying above. It still does makes sense
to keep this check to ensure future versions don't break it.

> +				if (!old || !new || strcmp(old, new)) {
> +					err = REFTABLE_OUTDATED_ERROR;
> +					goto done;
> +				}
> +			}
> +
> +			new_offset = i;
> +			break;
> +		}
> +
> +		/*
> +		 * In case we didn't find our compacted tables in the stack we
> +		 * need to bail out. In theory, this should have never happened
> +		 * because we locked the tables we are compacting.
> +		 */
> +		if (new_offset < 0) {
> +			err = REFTABLE_OUTDATED_ERROR;
> +			goto done;
> +		}
> +
> +		/*
> +		 * We have found the new range that we want to replace, so
> +		 * let's update the range of tables that we want to replace.
> +		 */
> +		last_to_replace = last + (new_offset - first);
> +		first_to_replace = new_offset;

Nit: might be easier to read as

  first_to_replace = new_offset;
  last_to_replace = first_to_replace + (last - first);

[snip]

--0000000000002c0bc6061f2af716
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9088dd18bc62a3f7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hMHRwVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1JUREFDT1hYTVlEUlJNNENWaVljNmhDTWNHaUNMcwo2OWFpM205MWRR
SmdhaEFhZHp6R3U0VTVoWlhsbDM5dFkwaUxhei9FZFdTQisyUFhiQVl1elp0UWg3Ym9vRVVtCllF
TGxRbUVxdUF2V01QSDVveEE0SHFNQi94SzRkSHRkVzJTdy9ZTlR2NGxQRHllVS8wT2FobGdCcjhC
ZzB1ZkYKSEhVL2hGYzFJdGRVb1l5UHlGUysrclBuUXg1eHMzUjJ2cHErdlIwdkdLRFJLaUl0TzZy
VDB5SGJGbDU4MG4zRwp3Q0duSVRENzJQVXFFVFdGaHpiV3BBQUZ5S1FodW85eldFYkJFNFVyK3kw
cnVWdFJudFgrVVN5c2Q3V2NuYnRFCitJKzZpdHN6MzJ2dWp6Ymw4UW5uZ3lJbWtNZzhFMTB5L0lO
L3M4RithSStjK0Jsb0VQU2pVVDMyaVErOFB2YVAKTlNIYVUrUkZhRE5nVkpIb1F1M1ZIa3dZZ2Y5
VlFscHZCWVpLbkttTXBKSGJRVFJsSWV1YVRmTkNkOE5UUHNwNgpPS0RKU3lHcUVyQXJyZjhrWXo5
ZmpNZ3BDbFlYN0g3a2gyK1B6cTlZeS92cXBwVCt3eGdMR2g2SHZhcU5hQkhpCm1sOFRJNmFaVzJs
UzJZc2Zzb25nc0lRemtCaytFbGd3ZldJdmFiOD0KPXlpMmUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002c0bc6061f2af716--
