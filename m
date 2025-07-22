Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461FC28BAAB
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171652; cv=none; b=NETyETrH/MdVdscKaTr2LIBI9lSBVGGHdGiCxETf7ol/aeoBq92ZRWXGFQuZDt/KjF0cK1AQh/f5TzxQASF6Ycjw0INEy4KoJCcvDSK7b9l2cZATgTXTWDBm9CWZs4Ld+pzXEThEPIbpVVN7egoZg68oKTheIK59cwb6b92spuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171652; c=relaxed/simple;
	bh=R8HpCUO0Tij9PNzTYH2xFLjvLQ2ZUZD1C6fFgx0IBgs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWLgr+5TZyrj3rBax9LL8v6rYg3eT+L+ox43SBYX8dqrOfGTzF7FwIA1zm9TM/7QtnB1z7EZZ0EHR/5N6iahXFCsmQ/SBF60vqI/BW3R0ympGLLWdYhw1NlxfltO4EjI5omQ2BrzwGSWiOPqiZvygAYni6ZbS3LB1mqPJ1kbyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqjtagnU; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqjtagnU"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-531a1fad7faso1349366e0c.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 01:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753171649; x=1753776449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pntoLp+fcco9zCEK3dUkMjx6Y5sO2j+XOH94Dq7JO/c=;
        b=RqjtagnUEp/SE7dLtFzjmWlRrUSJ8NAQgaUqPwecxFYn2svjwO/ntTq/EUYxAE6axT
         50Z8SxbU7IH4LfQ8Umh43XZPp+u1YRoW39OIiiePFhixWDxS2w98V3nau6Gw68fXoAtB
         HqSwoLUbsxwC8iGHUlVc56bpq1cudLek0fO4cU7RE/WkTQ+IaAtsi1FbKLokkHle3Qng
         cw7PFxdgnQzU6TRvLh9kGpydyOgKfmsC5OycBx8VnWJdGiaQT7o+GOg8kG177sp80FSh
         PZgcaGOL1M0mbg3iky8rRZvnFSp4kVvnFr6nRvajVRE8Q21MhveUIrb/DAZOOUQTBZWO
         l1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171649; x=1753776449;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pntoLp+fcco9zCEK3dUkMjx6Y5sO2j+XOH94Dq7JO/c=;
        b=BrojP3yU/OMDFidiuP0MiQnkbOr0dTx5hjbui8kPAvd3qMb9I5yDlXKrEIAvoP4IJV
         n5XBrn8eh1/J85bTcnJ2OWLpavDpBsnKbCDIwBbVQOY1jkF5vDYBC+MV029KR4JpVIia
         cZCbKziuGmE0mlSC8wO/+FZ8vOEjyV0OJvFHgDgrPLwyW4PS6noUrjbT5UfR1Yg6GX+X
         ydigz7d4jmh8plc8bRGqRS/YtW67AMl63G4/frzAgAoos/pgYsX/lQQm43cfgS7Fgaeh
         gRDg18Tue0IRbTkVl/dMiJR28BD0Z416AJKCCOuSv9q22+9Rh2ZVoKwAFhYAckpuOxzy
         DVpg==
X-Gm-Message-State: AOJu0Yy99dzLby50cQp8ljLtZpfkxbcyl5EO1VsDtfW2N7PhDwod+H/4
	kLrumM7z2f8wpcSyGl2znyMX+xNICUFan1YJDqHVUsJph9DDEavSv5jyrM5DFNQp1Vy40frq1eK
	R7z+T9hmIjxXmg5FU70XzXGVTf4AiuHc=
X-Gm-Gg: ASbGncvGA9KAQHfz54GP/9N3NdY7R9dFX2FWNq3wFHsp7pAr8lIMVt3dWp9ThWCob4r
	sQ6vrfQw//gDHZGI58oGSj2AOo2utWI5Av+6wqFxM6X6oGRGL4kWh+n1GAiVVgiANFN9bcb3Ssv
	YmZJYKzRdBkfdijax4FUKNnvU2OxdtdFD4kMF8SI6Jd9aHLsXCX/8zT5lbPOHUdhVK0+2hOI9df
	BXUCQ==
X-Google-Smtp-Source: AGHT+IEem23VIn0G0oe5XDGCAqTQi7vyVVgGA1qov32aasyKRYJJrtfbOcSZR1SddgzPj7O9e79JDI77JB5B0WCr/9o=
X-Received: by 2002:a05:6122:2a52:b0:531:19f4:ec19 with SMTP id
 71dfb90a1353d-5373fc9a650mr10673128e0c.9.1753171648925; Tue, 22 Jul 2025
 01:07:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jul 2025 04:07:27 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jul 2025 04:07:27 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqikjq7s16.fsf@gitster.g>
References: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-5-852d5a2f56e1@gmail.com> <xmqqikjq7s16.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Jul 2025 04:07:27 -0400
X-Gm-Features: Ac12FXwb7hcPHCajFfdpIrS6OGas2SVrGKHikmkZgndzt4EY6SEx1biUnOkJBCE
Message-ID: <CAOLa=ZTPJCZSphi4fV9+NmJt60rMZBxx0YRdpeLE+ab114aF1Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] for-each-ref: introduce a '--start-after' option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000005d6f51063a8015d6"

--0000000000005d6f51063a8015d6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The `git-for-each-ref(1)` command is used to iterate over references
>> present in a repository. In large repositories with millions of
>> references, it would be optimal to paginate this output such that we
>> can start iteration from a given reference. This would avoid having to
>> iterate over all references from the beginning each time when paginating
>> through results.
>>
>> The previous commit added 'seek' functionality to the reference
>> backends. Utilize this and expose a '--start-after' option in
>> 'git-for-each-ref(1)'. When used, the reference iteration seeks to the
>> lexicographically next reference and iterates from there onward.
>>
>> This enables efficient pagination workflows, where the calling script
>> can remember the last provided reference and use that as the starting
>> point for the next set of references:
>>     git for-each-ref --count=100
>>     git for-each-ref --count=100 --start-after=refs/heads/branch-100
>>     git for-each-ref --count=100 --start-after=refs/heads/branch-200
>>
>> Since the reference iterators only allow seeking to a specified marker
>> via the `ref_iterator_seek()`, we introduce a helper function
>> `start_ref_iterator_after()`, which seeks to next reference by simply
>> adding (char) 1 to the marker.
>>
>> We must note that pagination always continues from the provided marker,
>> as such any concurrent reference updates lexicographically behind the
>> marker will not be output. Document the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git-for-each-ref.adoc |  10 +-
>>  builtin/for-each-ref.c              |   8 ++
>>  ref-filter.c                        |  78 +++++++++++----
>>  ref-filter.h                        |   1 +
>>  t/t6302-for-each-ref-filter.sh      | 194 ++++++++++++++++++++++++++++++++++++
>>  5 files changed, 272 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
>> index 5ef89fc0fe..ae61ba642a 100644
>> --- a/Documentation/git-for-each-ref.adoc
>> +++ b/Documentation/git-for-each-ref.adoc
>> @@ -14,7 +14,7 @@ SYNOPSIS
>>  		   [--points-at=<object>]
>>  		   [--merged[=<object>]] [--no-merged[=<object>]]
>>  		   [--contains[=<object>]] [--no-contains[=<object>]]
>> -		   [--exclude=<pattern> ...]
>> +		   [--exclude=<pattern> ...] [--start-after=<marker>]
>
> Not a problem this patch introduces, but as I noticed it, let me
> leave a #leftoverbits comment here (it is OK to have a preliminary
> clean-up patch).
>
>  * "--exclude=<pattern>" should be enclosed inside a pair of
>    (parentheses), just like the way how [(--sort=<key>)...] is
>    shown.
>
>  * [--stdin | <pattern>...] should be moved to the end.  There is no
>    reason to require "--stdin" to be the end of dashed options, but
>    the <pattern>... must be, as they are positional, not dashed.
>

I'm sending in a series of these small fixes, so I'll add this in.

>> +--start-after=<marker>::
>> +    Allows paginating the output by skipping references up to and including the
>> +    specified marker. When paging, it should be noted that references may be
>> +    deleted, modified or added between invocations. Output will only yield those
>> +    references which follow the marker lexicographically. Output begins from the
>> +    first reference that would come after the marker alphabetically. Cannot be
>> +    used with general pattern matching or custom sort options.
>
> It is unclear what "general" in "general pattern matching" refers
> to.
>
>     Cannot be used with `--sort=<key>` or `--stdin` options, or
>     the _<pattern>_ argument(s) to limit the refs.
>

This does read much better. I'll also add this.

> or something, perhaps?  It is curious how `--exclude=<pattern>`
> interacts with the feature.  Presumably the exclusion is done so
> late in the output phase that it does not have any effect?  It does
> not have to be mentioned in this documentation if that is the case
> as it is a mere implementation detail.

That is correct indeed, while this doesn't have to be documented, I
think we can merit from a test. So I'll add that in.

>
>     Side note.  The limitation that sorting and name_patterns cannot
>     be used with the feature also comes from implementation
>     (i.e. the name_patterns optimization will compete with this
>     feature to take advantage of the "prefix" thing in an
>     incompatible way), so while the reason does not have to be
>     stated in the end-user facing documentation, the effect needs
>     documenting.
>
>> @@ -3189,6 +3221,7 @@ void filter_is_base(struct repository *r,
>>
>>  static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref_fn fn, void *cb_data)
>>  {
>> +	const char *prefix = NULL;
>> ...
>> +
>> +	if (prefix) {
>> +		struct ref_iterator *iter;
>> +
>> +		iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
>> +					       "", NULL, 0, 0);
>> +
>> +		if (filter->start_after)
>
> The start_after of the filter comes from "--start-after=<mark>".
> Can it be true with non-NULL prefix at this point?  Unless you add
> support for the option to "git branch/tag", it would not happen, I
> guess.
>
> More importantly, when you do add support to "git branch/tag", the
> code need to be updated to keep the original prefix while seeking
> the cursor to the specified <mark>, instead of clearing it.
>

Exactly, if we do add '<pattern>' and '--start-after' compatibility,
we'll have to make that change.

>> +			ret = start_ref_iterator_after(iter, filter->start_after);
>> +		else if (prefix)
>> +			ret = ref_iterator_seek(iter, prefix, 1);
>
> We have "REF_ITERATOR_SEEK_SET_PREFIX" for that "1"?

Yup, also the 'if (prefix)' can be dropped too.

--0000000000005d6f51063a8015d6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8ddc65867d53eb30_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oL1JyMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0xsREFDZWlLbityM2oveXBwRWo5YVZteitIUytaQQplMklEN3RiSmd1
WDV3SVpQOUNtdUI5WmhHMzdESkx3RjBtZm54dGVObFA3c2gxSzJhanJoYVJVRTZCYnVaZVFzCndh
YnFqODg1bVkxTGlBbjlUc2VmUXdmQWg3a0Q1MmtwYXlhOEo4U3U4NkVTL2YxY2hteUt1S2owWDJl
cS96dEcKMjJ4Z3FKWUtlWGdCMERWU2xMdHcycit5c29uYzF5blNHYnNMRFVwL285QTVkajNMNUJ5
ck9oNFlhZDZEVFl1YgpmdzlRblFmSFRCbjhUVXN3b2hqR01BdVZ2aWFMTVJUZGhWaGJHblZEaU85
Q1owK2lwOWMyV3hkTllnaWdFc29mCktTZVZqQkxFS1EyMkxZY1IrQkxvckx5Y3NJVzM0dS8wS3lD
eGFsUjdvNkxrcGM2cjhLS04vS09ENXVmamFJZUUKUDV5WHpNZnFOajZwWW8yWnpvM1h0NktWOFNo
ZFB3R0ZlWkJDbE1yWFJCLzBLZWw0Z0t2K1hsTHdHYjZtN1dSRQpFMjV0aTM1bU5BZ05KUzNQTVRq
NitNcUVCVklpTW5nNElLVUNFeFNHZzgrN1NQV2YyaFFiZ29EU2hQTXg0R1YwCnRHNGNFN21XbXVu
K2d4S0NyemhRcjZRcTdLY1VNZjBFZTE4Q2xXbz0KPU9DcjgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005d6f51063a8015d6--
