Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0BB661
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541672; cv=none; b=Arq51L63izwTXtSliNRjJNzfAaKKYkBoVFjweJTVnHcSF5eBTLCiF4jbDLwVUcXmvj5hqyiXAKGMSUgcb5J/N0nQHJ7jjQeO4u51pjmk6hH0BTufnGz3zp5XxfHNfXDjidT630/S9dQ7rM+9kp10TlZ1s0UzZ8aZAiV/dFeEYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541672; c=relaxed/simple;
	bh=PajAhkrjJLz84M+B9aXlI4hQgX2LZMEQeM/tXQOxMvY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsIK4ie2gRxenE2LFQuUM3u/LEisvjtLL2GeD0EcX81A0ezC4wxk9ebueQCAO5+ksGoRL5UWhZ58PM97GFemPzWlTqREPvrQT6vbKSQaNg7k+5qEpbdZhKcc/Ujk+A4R/2R87vLJhPiw8UEUAloxO1IQ+WdGTrcr/6KrxPdH084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsmJ9EwP; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsmJ9EwP"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23319017c4cso1459089fac.2
        for <git@vger.kernel.org>; Fri, 19 Apr 2024 08:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713541669; x=1714146469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=18Dn2NzJ8GfokYfPkQOmz6a428nSkvNECgPtD0z7iNo=;
        b=TsmJ9EwPuyey7D9rAD1S7HlAaVnf+dBk8EvbodpQHAJCW1JjEtHd5uojNJ53MbQ8L4
         dCSpX1N/YjOI2oqeOZPy7z5VsT5TrluGZ7GUw0inmf/Sn03W54TS+o42oHfdeIstjN5u
         +bqqXX3CyInk/8YK0MfG6Xm41+01FdNfLbc7DEbLVtuRM5Y7ZyYqtuU/OUI4ZZSr2w0w
         mIBA+Jnoa1K6rTS/x7nUrX7XOVce5VHtZxSoaU/u5GUHM+HMK8xZq18kbVi2xcHCUc7w
         OEMPQR1F9ylGvFOtTylnTDfS6DyZ9YNtlGeE7925rwXgpodOwsMU0c8pUcDOouwhUCIX
         u4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713541669; x=1714146469;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18Dn2NzJ8GfokYfPkQOmz6a428nSkvNECgPtD0z7iNo=;
        b=COQDc6KSTTsVSCdzm9KpK2nI7BH0cHDB+6efdQM5FpqhNh+nEaK8LcIdoGPFOnULqp
         657rUGLvPpPqOgx8NKf5Wtsec/0E67QfRjFQydg4eP42Ho5UZP5hRGxef4VvgpGYIvrM
         e3hHouHJUyUDsdrnFnyzhq64hDNBOERbtBx7YHkWU0ZmBAotEE1ZKlacOFMLu9+XYM8D
         lMDnR4ee2aO29I0TFwfuO9u23aKSTBpqKliVE6ublcB7mylJk8TGHvlvV9rg/1sFxHE5
         h2dlJThoz400VFKtW/25fOzp+3GhqVScz2gxqZpl9B3b7JNXp49gMPoKUyKXQ+GGkzWt
         x06A==
X-Forwarded-Encrypted: i=1; AJvYcCUm7+037EFqEmV/k5nh9aXRw0DQOc7CFLZpv6mHEKd1Fg/CaOAh7ZJCcmqoKymfsWjRTbCMjBLqcc7n5WIqg+e6YyKw
X-Gm-Message-State: AOJu0Yx1husNonDPrGo9scDweHNhORLGu4+XTjRGPMWtXaHkq7TOXdS1
	2ygMzXqsEc4/TrL6ejHARZIQGaaI7kGOzFGeG81ThftiiBvjFzA7MVklyKF2vXUngCuDGhVc7R+
	8CVG2aajXDCe4pZ/t3IZEQf7CFu1M1Q==
X-Google-Smtp-Source: AGHT+IGscgWmQYmp2e0B3Vrue8wz4fEpwN+NO/liYs3hcgJjuH5l1RgD+J0gjm6GvIklP67FV77Y3V1LgUXsOnv2lOw=
X-Received: by 2002:a05:6871:2b1f:b0:22e:96a0:201c with SMTP id
 dr31-20020a0568712b1f00b0022e96a0201cmr2759855oac.35.1713541669510; Fri, 19
 Apr 2024 08:47:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Apr 2024 08:47:48 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <c182c68c-77f6-422a-81ed-f6199c6b8a6b@gmail.com>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-2-knayak@gitlab.com> <c182c68c-77f6-422a-81ed-f6199c6b8a6b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Apr 2024 08:47:48 -0700
Message-ID: <CAOLa=ZSwtOQXwbgregzKMtVA30wUCH8R=8D7u1+KGnsGEDD1oA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] refs: accept symref values in `ref_transaction[_add]_update`
To: phillip.wood@dunelm.org.uk
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000008516b5061675027e"

--0000000000008516b5061675027e
Content-Type: text/plain; charset="UTF-8"

Hey Phillip,

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> I agree with Christian's comments on this patch, I've got a couple of
> additional comments below
>
> On 12/04/2024 10:59, Karthik Nayak wrote:
>> diff --git a/refs.c b/refs.c
>> index 55d2e0b2cb..967c81167e 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1228,6 +1228,7 @@ struct ref_update *ref_transaction_add_update(
>>   		const char *refname, unsigned int flags,
>>   		const struct object_id *new_oid,
>>   		const struct object_id *old_oid,
>> +		const char *new_ref, const char *old_ref,
>>   		const char *msg)
>>   {
>>   	struct ref_update *update;
>> @@ -1253,6 +1254,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>   			   const char *refname,
>>   			   const struct object_id *new_oid,
>>   			   const struct object_id *old_oid,
>> +			   const char *new_ref, const char *old_ref,
>>   			   unsigned int flags, const char *msg,
>>   			   struct strbuf *err)
>>   {
>
> Adding these two new parameters is quite disruptive as all the existing
> callers have to be updated. It makes it easy for callers to misuse this
> function for example by providing old_oid and old_ref (I'm assuming that
> is an error but it is hard to know for sure without any documentation).



> It also makes the calling code harder to read because there are so many
> parameters it is hard to keep track of exactly what is being passed. An
> alternative strategy would be to add a new function that takes a struct
> instead of lots of individual parameters. That would make the calling
> code more readable as it would be clear which struct members are being
> set (see reset.h for an example of this). The approach of adding a
> struct is still prone to setting the wrong combination of options so

We do already have refs-internal.h:ref_update and this struct would be
the best candidate for what you're saying. I even thought of exposing
this struct and using it. I think I realized that it's a lot more work
to do this, because there are checks and cleanups which are built around
this struct. So exposing and using it would mean we refactor a bunch of
that code. Which while necessary I believe should be out of this series.
I'd actually be happy to do it right after we can agree that this is a
good direction.

> either way it would be helpful to add some assertions to detect mistakes
>
> 	if (old_oid && old_ref)
> 		BUG("Only one of old_oid and old_ref should be non NULL");
> 	if (new_oid && new_ref)
> 		BUG("Only one of new_oid and new_ref should be non NULL");
>

I have slightly modified it to:

 	if (old_oid && !is_null_oid(old_oid) && old_ref)
 		BUG("Only one of old_oid and old_ref should be non NULL");
 	if (new_oid && !is_null_oid(new_oid) && new_ref)
 		BUG("Only one of new_oid and new_ref should be non NULL");

But I agree, this is needed and have added it.

>> diff --git a/refs.h b/refs.h
>> index d278775e08..645fe9fdb8 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -696,13 +696,19 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>>    */
>>   #define REF_SKIP_REFNAME_VERIFICATION (1 << 11)
>>
>> +/*
>> + * The reference update is considered to be done on a symbolic reference. This
>> + * ensures that we verify, delete, create and update the ref correspondingly.
>> + */
>> +#define REF_SYMREF_UPDATE (1 << 12)
>
> I'm confused as to why we need this as I assumed that we could use the
> presence of old_ref/new_ref to determine that the caller wants to update
> symbolic ref. Having this flag means that there are more possibilities
> to misuse the new API setting this flag but providing NULL for old_ref
> and new_ref.
>

I think I started with this flag but as the direction of the series
changed and I moved using zero_oid values for deletion or for using the
verify command, this is not really needed anymore. I just tried removing
all the code around the flags and fixing up things and all the tests
still pass. Thanks for brining this up.

Patrick Steinhardt <ps@pks.im> writes:
>> I'm confused as to why we need this as I assumed that we could use the
>> presence of old_ref/new_ref to determine that the caller wants to update
>> symbolic ref. Having this flag means that there are more possibilities to
>> misuse the new API setting this flag but providing NULL for old_ref and
>> new_ref.
>
> In my opinion the same comment applies to `REF_HAVE_NEW` and
> `REF_HAVE_OLD`, which I found to be redundant, as well. Those may make
> sense in the internals when the object IDs are stored as non-pointers,
> but queueing ref updates only accepts pointers anyway.
>

Yeah like you mentioned, since we're dealing with pointers, checking the
if its set is enough indication, which doesn't work with the static OID
values.

--0000000000008516b5061675027e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e627f12da518c386_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZaWtpSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2lFQy85N213K3A0MUtZU3owV3Y5bWNYbTUzVnNjOQpUOEM3RFh3WXpK
YVcvNXVmMjFnNWxZM0x5cFV4M3dXa1NOL3M2UEt3akxxclZ4L1RZYUh5VmZkMmI2QXlmamNTCkNn
Y2M4a1k5TnM0QkdHSXlQbEpTREFYcHgrcFNzLzZMdXhZK1ZjMUpUS3VCdGtsMEl5WXAxZEoyS043
MHY2NkkKMHFJRS9CUmE5dU9vTjM3L1ZoVDJyeTUydytpV3ZJWXViajN1ZUZwaXZubk1HTjhQVUFn
N3ZJbnlmWlM3cERYbApiQmJuVGlOZVNIR29UeGtTTWJQWW1NRGJTaHhoa24vMkNESXBERUgxRnZs
bVJMVi9PNDNXY1BSSEUrYWR0RDZZCjVNYWhsdlJvM0E3S05Va2xnM2w1eG5iV3UzTkFvTnR1TStP
N09HMVlUSk9KcTlrZVFzR1F1U29Ecm1RbFNDYVQKSWZJU0E4S29RRFNuNS84WWdYYzk0bkxoY3dq
M01mUjkvVDRpMTlmTVR5ZXNVSFY3YjFqdmlJM1lXbFJ2cFlRZwpzRWE1dkp6eFRXbXVpbFk4NXpk
WEIyRmN1VDdQbW1BK2xpN3E0d2l5cjNja08zZnBSbmQ0cU9lUTFKVzYzeW9VClVhTFBlWmY1ZTlr
Y1NFVjhKN3JlRlVwR25yZVpCRm5uZVk4d2tzWT0KPW5vT3AKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008516b5061675027e--
