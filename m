Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E43DDAE4
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791321122; cv=pass; b=VUPz863OgXLYU6M/zX+J+2lDhb9PXHSWJEf//xLmjweofG+PlRwI239z6oTggQ3nGXgZwqeewHBUdMazaTWPgJyAewxvOljJCWOfNEs5ANHtW6XX8R+HpM1Kq4ySMO9gk/V1ozS6qT9UCJcQaOMcUg2ZltzYX4xXmTM4sVE0unM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791321122; c=relaxed/simple;
	bh=AsF96pOrjEhi0gXfH+M/6Z4CXRkDQOrl6v2q/khSoD0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/a5jWqXgSUa4uyL/5NuJn3FO9DSFdaLN1+cnTnV2uEwJWdJ+HYIaPFFdnvKOoBBoLngcaIV4Z588e+wnDK7e//AInbu8Vx4sedfWFa7jpXjSpwDjMAErajp6FJhdKC0RzUyKcBhpvUe363Ia6snYJ6whO4WJ1qgBmTGHeg/vVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi7NIp2T; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi7NIp2T"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-988d2fdcdc4so2047946241.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 14:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791321119; cv=none;
        d=google.com; s=arc-20260327;
        b=NjSfj8cNquui+h4r86GxfP4A6eZ3t2dvc2wOUB9KWKZpF6M9jihq2DAdxAVSXW1Tyg
         bvWIOHdUYE4a4spjN77ajLNskjlH6tj8aUDPfpOt5uWPlCP2xqC1Xz+Sza87darGoArG
         wHiwf4a9B/D1vxdisiODZDkTyvSStckVgBIa4uZnM27aj9pFar7VqJO0q2BaviHveotQ
         GIBumKJP1R5KwRUBUzR3PfLkfoNGZHeiiATHv0feoHas7AYd0baLFPxCgSY5ivzS+W8D
         lvVTqPYtJK+hyVSam46Sz0HKuBDGYIGcNlB1w0poDf7mVKGoODgjmyEVfTXvRBqJZAuh
         FEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=qqxdhwE6rYGOym1eoYB4X2Ootdgy9iZnKctJtNewIes=;
        fh=Uv3BoY/4RM9pxrqM1sEzEr9JvpUQwCc0FATUaMK8DqE=;
        b=APxd0NXkOCUgBsY87xp6HOB7dPN/AsGKEYcD7Uou2n9cIHGwD1iQqsIAKJdO0XKdZU
         v4uE1HLJSJkb0qH3TQdIo5D5GOidIPCiC0x/UdFhHbm18R1JV6Pgr7v8jXB5xRVBLuFS
         qKUBcOY6GTJZbrS0KU9rNBXqIx0e2Ggr0CsMIJ4CxuRqZhwgF8RJwPaZFlpoFLEqLlkb
         K+hm39/vNry8QEZEzN4ehYMx+pl3sWGmfR2TrzEwJjQ0z8+X5guzIgzr6elIc5JRTiOm
         tucQc9+1glbPS6goXzlPqsPEe9Z+cljJqp/vBspRgrvicC5uOd2ZU79hDoGl5DLMelMp
         peWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791321119; x=1791925919; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqxdhwE6rYGOym1eoYB4X2Ootdgy9iZnKctJtNewIes=;
        b=Qi7NIp2TtFrLRJTWUa/f5c8Vd3Lo44KxIpSPabnh6FRZw3iIG/WziciOETmr9HfZxW
         wKdmF0z9p93PpdqNd4yLJ0iEkaBGdwwmw4CjGBGlhzigyrQ9ozz5J3nuyN07/c/PbCrD
         STCVPx54jEs24SwAxBEtE3maEcwS7jLIoBkYaK1G7pIF9fv32RrHShjrw1h3RhlRaHHL
         uk3cxv4RzqVTgOFQPGhs3CrO+cWV2X6/dOf9AIoPCOX8/ClVQ0u2hpJrxM1O8Y/GjGFU
         BYKpeME42qKAKfhDf73KqzYj3AmLm3fWeH+gmxUi5tytCkT1n741eSrWvIvwmjr4SL/0
         pW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791321119; x=1791925919;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qqxdhwE6rYGOym1eoYB4X2Ootdgy9iZnKctJtNewIes=;
        b=hGP+E8UUmA6xFIwflxV4XQEtbk1e4eJ8heN7C+3jUnWA/Hl93THPV8V3DFAkhYCDb4
         bSx4udpL9xTq/TiVGtT1yIP2F78M/FpvL6NYRD2oDAliy7VzrgcM/FwPwmUYgDR5apkr
         0r233uPpoiH4n9jacrdKCjXD16lSnPDw2yjcsc2bfCyS4kQsrotimTi2KcKhGvQjQ1mL
         tQZFh8i+IIqxTK7RO/lhmeqVdn5Cm1B6uJiVrVSxMUPl0tMcY6iPCNaBnOb49zrw82s8
         FVy0M4NKKLNMj93kRsev4NBmaP4jMGQ4HIWQomZwwDiFYlKiivRohvIudef1jOAJ85NE
         VUWA==
X-Gm-Message-State: AFq9FYIb5fyisYqykO2CtWdMuWoVbhYIiRiYxA+6H26v+RwC3KYbS8uB
	Nv2xLVQ21N5KVkaueeF/pRAecUpTA4GSZ2em4fzKKJ7b+94RFAqjW4BfOyHAJDPnEAWtj/NL1PE
	1FrtUMkwUgPP1PRIM4QVV4EI/0gGR51Y=
X-Gm-Gg: AYBFou09LOV2yF7vboRtK6O/LDSX+tUf6zffDqEji0TsM/fisDppz19ODxfiVHT8YPS
	mI0+3R9BFEvSFaYADqULUy2gPOgs9WQqzYPHFwvQ1iHMerT6MQ/YRCcq6GY68UdgdBoDG6ntgRR
	O/FzcSIzdJ5eXYWQsVxEXpRiT3+D6avZ5wsIfhyLUK4C7IYdPgW+QuGUAitc6iTM8VS47d27Mzt
	n0nbNQt3Dcn3myNAgpPRzhXd8+u/2CF9r0eLO8/VQcrnw6l6Hou3pdeeorFEMmCTHFzps1wVD8L
	RzAdO0OBJZv8vdiPEJJNaDkbrDwIAHtON3skOPYM4VofmfEdxgCxGEiTUPU6LMlkAvKJxEqHgR4
	4zGyR75lBWzlf1WWvEpppYOjWaQVkZCTNbDFXDy/bLeoTG/g=
X-Received: by 2002:a67:e714:0:b0:7a6:c647:cf50 with SMTP id
 ada2fe7eead31-7ca386f371cmr17444137.8.1791321119454; Tue, 06 Oct 2026
 14:11:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 17:11:57 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 17:11:57 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <asTqPcCl3RdS8YN4@pks.im>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
 <20261006-kn-speedup-packed-refs-v3-1-a1c76b1df9e0@gmail.com> <asTqPcCl3RdS8YN4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Oct 2026 17:11:57 -0400
X-Gm-Features: AclHuK_etyMjOJ18PpposOxTRDbx0mfAQTUOu3qPfdBZLU34TxBdvIj72nUU1ps
Message-ID: <CAOLa=ZSbT6AHfU178khN7n9rHAmNE5HEM1acr96HXqXpRcSzmg@mail.gmail.com>
Subject: Re: [PATCH v3] packed-refs: use `fwrite()` when passing refs verbatim
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, toon@iotcl.com
Content-Type: multipart/mixed; boundary="000000000000011679065d3273f3"

--000000000000011679065d3273f3
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 06, 2026 at 11:18:40AM +0200, Karthik Nayak wrote:
>> The `write_with_updates()` function uses a `struct ref_iterator` to
>> iterate over all refs to write to the temporary packed-refs file. It
>> receives the iterator from `packed_ref_iterator_begin()` which takes a
>> snapshot of the 'packed-refs' file.
>>
>> While writing to the new packed-refs file, writes are routed via
>> `write_packed_entry()` which uses `fprintf()`. Even for references which
>> haven't changed, we use the same mechanism. Instead, let's track the
>> position of unchanged references in the snapshot iterator and directly
>> use `fwrite()`.
>
> Nit, not worth a reroll on its own: you state the status quo and then
> jump to the solution right away without stating what the problem is with
> the status quo.
>

Fair, let me amend.

>> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
>> index a73fc6aca7..43ad674cf4 100644
>> --- a/refs/packed-backend.c
>> +++ b/refs/packed-backend.c
>> @@ -879,6 +879,12 @@ struct packed_ref_iterator {
>>  	/* The current position in the snapshot's buffer: */
>>  	const char *pos;
>>
>> +	/*
>> +	 * Start of the current record, set when advancing `pos`. Used to
>> +	 * pass records verbatim to `fwrite()`.
>> +	 */
>> +	const char *record_start;
>
> The way this is written makes you think that `pos == record_start`, and
> thus one wonders why we even need this separate variable in the first
> place. So I assume that we modify `pos` in some cases without modifying
> the new variable at the same point in time. But if so, the above comment
> is not true anymore.
>

Hmm. I only state that this is 'set _when_ advancing `pos`', Why do you
think that this would mean `pos == record_start`?

>> @@ -1233,6 +1240,19 @@ static int write_packed_entry(FILE *fh, const char *refname,
>>  	return 0;
>>  }
>>
>> +/*
>> + * Write an entry to the packed-refs file skip any formatting and directly
>> + * write to  the file using `fwrite()`. e.g. when deleting references and
>> + * remaining refs need to be written verbatim.
>> + */
>> +static int write_packed_entry_raw(FILE *fh, const char *entry, size_t len)
>> +{
>> +	if (fwrite(entry, len, 1, fh) != 1)
>> +		return -1;
>> +
>> +	return 0;
>> +}
>
> Nit: this function is somewhat ponitless as it's a trivial wrapper
> around fwrite(3).

Yeah fair, we can simply inline this.

>> @@ -1530,9 +1550,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
>>  		}
>>
>>  		if (cmp < 0) {
>> -			/* Pass the old reference through. */
>> -			if (write_packed_entry(out, iter->ref.name,
>> -					       iter->ref.oid, iter->ref.peeled_oid))
>> +			const struct packed_ref_iterator *packed_iter =
>> +				(const struct packed_ref_iterator *)iter;
>> +			size_t len = packed_iter->pos - packed_iter->record_start;
>
> Alright, so `pos` and `record_start` do get advanced independent from
> one another. So the comment that you have for `record_start` is
> inaccurate indeed.
>
>> +			if (write_packed_entry_raw(out,
>> +						   packed_iter->record_start,
>> +						   len))
>>  				goto write_error;
>
> Other than those nits though I'm quite happy about this change. A 20%
> win is nothing to scoff at, doubly so because reference deletions are
> extremely expensive once your repository reaches a certain number of
> refs.
>
> Thanks!
>
> Patrick

Yeah I agree, I'm quite happy to see the 20% drop too :)

Thanks for the review. Will send in a new version once we sort out the
comment on the field.

--000000000000011679065d3273f3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f68a62c66c143bef_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRlpCc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNk9tQy8wWFNFdDVYN1ZPZWhXVWZYYzZ0S3BxOHNZVAptdTVlaUhHOXZx
aHQvQlY5ZXB1cEZHTlJtdTRLcXhxeUZ5ZmhIQjliUU9vQ3RHRU04VDYxUW1XWVFVbWNBWmp4ClhW
WStMdmtzbkF0RU11dTd5M0k5dzdRR1JVRFB4M24zV1BvWGwwUUdnVzhXczlZRFlhV24xWG5vSWtv
YzdJMWIKSWhzUzh0eWROMXRXd3g1YlNIUnllTlVJb29WREY1S21LbUozNld0WHhpeS9saGdvcmo4
UEJGanA5VjhLWlRBUgowM3l5ODF2RkVlLytQOHhhMm1JWHYrUmZOMnZJRmM5NVNGcjd2eDA5WnA0
ODZsZ2htTkVzdmZXUG0xYTY0d1g5Cko4YkhaY3hhVXM3MHhhK1JPZ3dtK3RtODcyWHJTbGMwUVJr
dkhzL01wZHlpWk9qSTdaRFk3Y0FjS2VXVnl5MXEKQjgxNFdOb2xteUx1WkVDUExUNzVLUUhlZFpW
clJIbCszR3VkQ0dnV0NROHlLVUtWKzcxc1IvLzc3ZkdKdnFjSwpiaDh4VktVYzdNNjhoVnhYR2pL
ZWVpb3V5ZTUrRU5XVE15bXRyWm9yWUI1UlUvV2ZMRlgwNDRTU3F2U3c2NGh5Cm1BZTBWOXE2UnBH
SnhMdUtpaWNhNjBFKzlUenZORDBaUnJ4VU1aWT0KPXBMUjgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000011679065d3273f3--
