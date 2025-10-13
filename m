Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76881A23A9
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348797; cv=none; b=sPiLBE2drRyVk+dKP8Hk7oisqc6aaYML6VOvi/HDWm+fRRLRTS+nveaeckTn3WKfQumaDOTo9wI4WyUJAL7VzuUq25BLNeXDGhaiBm8tMj0yjSbzPQKEk2eA0KEipv/iSqqxSaL7KPOWuM6NQbikEhV7vCgK+gajUslr6JNhayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348797; c=relaxed/simple;
	bh=bIClDnPV0KGeRKWtIDKO4y8iFoSgYuN8/RZMlPtHpOA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgCA3nPoK5TGUP7BKEHkTI2Pp2/nQuq+QTAUtnZVNI5JsIOW/KhKtwzE/PM4zGoD+OOm/A+sabc1XqZBm/bLlMddlf89zPK7nmOLOxt64PCzmFPN0fEpL4ny9ShG99Mz9QQq36Ep0adaIEpXvGAQ4eHJORB6wzCVufq1+asRR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6slVyNj; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6slVyNj"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54c0bac7d6bso1841434e0c.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760348794; x=1760953594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=10D1bhE76NzKzlT0mdJdaiqwJcpgTIiUBvfLYzFZGl4=;
        b=I6slVyNj0KQbCoAtet8qDxKJEj+npeqn3g20wgGpKgaT8DORG3RTcCb0LY56dmg8zJ
         1geUgsfaO0SpuM+Wr1/lUjHaX7blGWeD38ctppYECnHL7JieEBN8Wp9fJWYxvDtA7rTo
         9OKUKhF5Ub5ApndhfGnwUsGUoB1PWYa+Nwet0BoV+Vfz/KWEH4Lt7efEuffDGtiD1I1u
         e/zIVleU/Y4k9hruP6n/BCiRYrRfaEaxOTPzvaKt/Gxhn9fsFqJlcbBi6DIFvxfrb4ga
         hAiqnE6kLz+1Kk89hQAlEslmEB41S/0F7u0wFZp/tcTvwmvHzfjkjXZR/rEnP308kZIx
         1nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348794; x=1760953594;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10D1bhE76NzKzlT0mdJdaiqwJcpgTIiUBvfLYzFZGl4=;
        b=J2BWkwJm12A7+4eDiThUvdU9pbqhYjGRbwpK1SBKWcJQHXphpyl+vViysbWSNtd198
         h85Gykg6Z56Z7TZuB4dhH0tObZomvdbDIgdgHHbkEybOsJNgfkmo3qtvldOWrGgsm7+C
         aK3CbrEC0qhOw85B0+vS3qinhZBwub59zTbkiBQ4BTVGDU4OiZcCt55Zn/ibuJZBuNYl
         ZheCg87hT0/VafTXX3V0fAqtiH8griF7REbqYVHQdixuW0pDvAFCkUNxNcnR2cxiRy6d
         Q+fYs0xOy/YLSVXT5SZ3n64dXRZGaNaMWpXI92HZpMVjAbOLTwbYTp2bkwbyxIwyuPUP
         R3Ew==
X-Gm-Message-State: AOJu0Yzzd5OcF47TKM0nVLgTBRg4etjBgq0A83cATy9wVEmccMZ/sKff
	MKKT2e7GOxaTPA+VV6YQIOBrkxEdYx4A8sz8KXpPEiTBKYRdH9N2IkNy7S4O5H5Ist4tySnwEZs
	L/NiXtYZWXxZtjjJwB2yWM2LH6qQMGD3XrA+F
X-Gm-Gg: ASbGncshFTt40n+VvpZL3LUb013QOIkSw2sJaLoi/0hHLt9ExhG9Ioojbmi6v5B8mYU
	AS8gPuYsM4Pymh4l+JiZkVUiCQt/J43icP/kEDQ0jS1/4w5U1BPS0VvOEK/m7bP9xX7x44f7XcS
	ly1kfCeuMGTsz4QFNoR/f5t6e6tTozgKGkCuMdMHj/+6jOXlx0Su0q4KZhw2V117bd/jykrVbHr
	iu+Gmvm0Jy4px9/qdbmbdXAlQ7Q22GeW4OSCYI0UrQ6C1pJUy7YiT/NlfRq9BulG2x1YDE=
X-Google-Smtp-Source: AGHT+IFTatugoXqeg0Xm00C4Ota7dzfeSA8bGdkTZux8R8kB818hd/EcoKqC+/fVWUUJGhHC1o2tytJW0mAjd+MIQnw=
X-Received: by 2002:a05:6122:3c8e:b0:542:d782:2522 with SMTP id
 71dfb90a1353d-554b8bf23b7mr8580278e0c.14.1760348794519; Mon, 13 Oct 2025
 02:46:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 02:46:33 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 02:46:33 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aOjsh4102DYctgQE@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-8-c7962be584fa@gmail.com>
 <aOjsh4102DYctgQE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Oct 2025 02:46:33 -0700
X-Gm-Features: AS18NWCcoC9quAUMvCuE7o8ZIXNmBauAwCmEYgUZf8sZ3IH0bFtcMGLU5FIuIOY
Message-ID: <CAOLa=ZTQWj7BUDNx5iuoYJ6YR5JqhFVK9O2vWiKqL5CNExpsUw@mail.gmail.com>
Subject: Re: [PATCH 8/9] refs: add a `optimize_required` field to `struct ref_storage_be`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009413fd0641072407"

--0000000000009413fd0641072407
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 10, 2025 at 12:27:12PM +0200, Karthik Nayak wrote:
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 1c37899006..c262ae1a7b 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -1513,6 +1513,16 @@ static int files_optimize(struct ref_store *ref_store,
>>  	return 0;
>>  }
>>
>> +static int files_optimize_required(struct ref_store *ref_store,
>> +				   struct optimize_refs_opts *opts,
>> +				   bool *required)
>> +{
>> +	struct files_ref_store *refs = files_downcast(ref_store, REF_STORE_READ,
>> +						      "optimize_required");
>> +	*required = should_pack_refs(refs, opts);
>> +	return 0;
>> +}
>
> Okay, this is nice and straight-forward. One might argue that we could
> also have the following (uncompiled, so pseudo-code-y) implementation:
>
> 	static int files_optimize_required(struct ref_store *ref_store,
> 					   struct optimize_refs_opts *opts,
> 					   bool *required)
> 	{
> 		struct files_ref_store *refs = files_downcast(ref_store, REF_STORE_READ,
> 							      "optimize_required");
> 		*required = should_pack_refs(refs, opts) ||
> 			refs_optimize_required(refs->packed_refs, opts);
> 		return 0;
> 	}
>
> But on the other hand we know that they aren't ever repacked, so it's
> probably dumb.
>

I also think that individually the packed-backend shouldn't care about
the files backend. So it shouldn't be calling `should_pack_refs()`. In
short, the packed backend knows that it is always optimized and it
should simply state that.

>> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
>> index acaa5a6e57..c94948f618 100644
>> --- a/refs/packed-backend.c
>> +++ b/refs/packed-backend.c
>> @@ -1784,6 +1784,17 @@ static int packed_optimize(struct ref_store *ref_store UNUSED,
>>  	return 0;
>>  }
>>
>> +static int packed_optimize_required(struct ref_store *ref_store UNUSED,
>> +				    struct optimize_refs_opts *opts UNUSED,
>> +				    bool *required)
>> +{
>> +	/*
>> +	 * Packed refs are already optimized.
>> +	 */
>> +	*required = false;
>> +	return 0;
>> +}
>
> Yup.
>
>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index d77714366a..df39fe9b38 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -1732,6 +1732,29 @@ static int reftable_be_optimize(struct ref_store *ref_store,
>>  	return ret;
>>  }
>>
>> +static int reftable_be_optimize_required(struct ref_store *ref_store,
>> +					 struct optimize_refs_opts *opts,
>> +					 bool *required)
>> +{
>> +	struct reftable_ref_store *refs = reftable_be_downcast(ref_store, REF_STORE_READ,
>> +							       "optimize_refs_required");
>> +	struct reftable_stack *stack;
>> +
>> +	if (refs->err)
>> +		return refs->err;
>> +
>> +	stack = refs->worktree_backend.stack;
>> +	if (!stack)
>> +		stack = refs->main_backend.stack;
>> +
>> +	if (opts->flags & OPTIMIZE_REFS_AUTO)
>> +		return reftable_stack_compaction_required(stack, required);
>> +	else
>> +		*required = true;
>
> This doesn't make much sense. We should only indicate that we require
> repacking when there are at least two tables in the stack.
>
> Patrick

Fair enough, I was thinking that when users say 'git refs optimize'
without any options. We always call `reftable_stack_compact_all()`. So
it would always make sense to say required = true.

But `reftable_stack_compact_all()` does make that check. So I'll add it
to `reftable_stack_compaction_required()` and call that with a
`use_heuristics` parameter.

Thanks

--0000000000009413fd0641072407
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: edbf231033e5c644_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qc3luZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menFBQy85TFJNVkpzNXFyZmRzWFhmRU5WVkZMWExLWQpKVWgrelo3ZTFz
QkZjd3BNUmZ3TE9lKzU3L2ZYVG1NdGJyUDZKVUY0NmlTbjRUa08ybnpGOFdRTS9QK3hDcnJTCmFK
a3l4RGFuT09rTWRRdlRPUzNsWFk2dndKNloyRXlYenR3dHppenkvRngrWWlIQ3M1aUV5R1dZK2to
Tlk5Z0sKTGdOUkNCU3NvWkp1MWQzTEhuemViZFFZMVQzL01EdGFWTnZicnJGOFdVbnZSMC9wYVd5
VjFZS004QVd6blh6awo3eTFuUGNxZnRPRVdqQW8wR0Rjakk0VEFCa0FwYWE4T3JKMGFRKzYrVXRx
UW5ETkowWlJlQ2JQNHl5N1Qra3FFCnlpR0tGMEJXdWpIVHlkUHJrU1VEaFZMSVh1ZDJlMXplSVVX
VW1iQmExeFNCbktxcGlmb2hvSU5CdmY3UmNZTWIKeHQzTmVMWWdzOTlGMG5rTUd1aklpbnJwOFRL
a0RML09RcDUrdmdCcnJ4Y0h1c01HRlNTZmxlVk9lTFVwcUVYTQo2UlJHZVhUK3NwZkpZNDZYZjVX
RUJNTkRZeFBzSXBwdGd5dlhEOENoZWpsNWdvREZHSWtBSi9GcGJyZGVKdGltCmc5VVUweHZ0WWdC
ZUhURHFPVVVONEVuVmY4ZEZNcnJ3QklxSCtvcz0KPXkrWXgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009413fd0641072407--
