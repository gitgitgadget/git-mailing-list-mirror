Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B83176ED
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616209; cv=none; b=BodUhexIETEAXXz/LNFxvi9434GjlFE+cJX8Nr3boIOGy/T5N0BInxVG6Qxc78cW9XIur9AYiPZhORX4ahW9ZRqKVISvKMUTgR7PxtmiRpV2v1M8l/Nj2DW94F69JEy8tnn+0yP7mpAn1dtRurzUf7lsf0pGbPAwg+yHSOTfIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616209; c=relaxed/simple;
	bh=uWREBi/9PXxSNBkLZo0uLhze3Q7bn0ws/W292pXDC9U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJGCMznXimTm2EXHjfEvjCy+YSyBjFhX5gdGz10zyZlcFSwfr1O3P49cx7cVGkWDQJPRj3yxi/0C2HOynSvQlw5cV4640dImA9hZM3K6o1LipG6ONaAspAChCK6qzYPO2wx+J79N3LWet0/OoC6PS3zNXPSaAeBsYg2Hfy2QmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlQ9/MSi; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlQ9/MSi"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54c0a10990fso226049e0c.2
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 05:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760616206; x=1761221006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9sZQAQyyDZQCxzxQshOBRNr4BpiY6T5htEnW5k7b88=;
        b=VlQ9/MSibw7viS75fs/ZwV+NJgDB+dnLQ8A6Y6pKHfGQGBkYqHK1KDVSQ22R580SNK
         B4JZMniIp+5+j2V8X+ZJC8rungoieYwltfpkoyfnVbjcMM64kqsBIx6ZlJBlkFeQ6b10
         NPzQhftOtY4uj2SgT5oB8ueWJJWguMgnuagCHE0BeOFJdsA7KKWch0r1GBs7+DOK0smy
         s/r9w0UAdt07sD84233nozb2IVo5OdNezYP3ctgSCjrcUBkSdpwYiA3dB6PN9UMQD7Ia
         ZV8sXYoOsQOH4y5zKMiRgaGvVQbXrSng7bE6Cu1Hv8Az0SLz9TfCuFad8YjxKkpzxowN
         slhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760616206; x=1761221006;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9sZQAQyyDZQCxzxQshOBRNr4BpiY6T5htEnW5k7b88=;
        b=KdzD6l0p66ju2G9ksWmaCHGFa3Zo3NPV7/kSg45Nf6EIOUoIQlOW27O6iO7hzQS1z3
         QgbHkMWOQNO4xYA/yZa6eztrpGaKeNq4QvI5CPp0zsVN+E6e6zHvcKY4M+eWUIHx5zQF
         XufE8KPDsoM0g7wA5GkNLaDNCZ+zThhBYH5fppsg3AFomYpPmKOXdsSBgfdo8grQsbBQ
         zvnFBpRT4VL93H9p5Z1xp8tbbFiEYYUv7YFYSShBVXcZditWwiNen7Qmy8+Fr+7/TOcm
         k80Nk7jCtx0k2TKUCICig8BuluhrzykBTXdmeBxnHNDG+0r1ttRqIJeIZ9USyr2Ln0e/
         65mQ==
X-Gm-Message-State: AOJu0Yzp9U8jUxIj/8F17tH61ziWUTftjbczkp+BpETXwRye1me+6AdD
	aPRwPUTA/T7ZGoq540xXeoO/818kOPSV3IkesmGkGNUBn3MlEbfMQYz0av2FYYZEAL1d3gb0v9o
	8H2Ab9fhL1GpLjV3sKsEkvQ4MQ7rbA6I=
X-Gm-Gg: ASbGncvtCRM4gOi8C1TFPM0gXKE0r5zKBa1oidCKHiH6rzGxxG+eBe35QOcCG9WMkSN
	zjkJkimXibJ+uRUpxBVg5lMlHHft1AKqH6YyWNTOF+btbju5Bl9krp752/DZIDscMGbXHd+0g+s
	X4kMKqbNLKn5liZ6WFN5PWbup9+QQt2gxhItt86OIbM+WHhHbbKzk6u1OTYZp+FDhr09ChYWx0m
	s0aQLzOn5N4cplxwOEP06yjerQAsoc1xrlwV71tD9OaLUAGNWHqsxnvXjjMqqNN3MsUfhvGts7N
	9/6aPke4uaApCjf5+bU=
X-Google-Smtp-Source: AGHT+IEjEz+9CqCUMxslA6OvrDoDW48DUvjHmla/d/8viyOpgjb19m3/IwsLS+lC8si39kcIwWhorFWp1b5KnKzU9+0=
X-Received: by 2002:a05:6122:2004:b0:544:4cd3:4bfb with SMTP id
 71dfb90a1353d-554b8c30246mr10802893e0c.15.1760616206428; Thu, 16 Oct 2025
 05:03:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Oct 2025 07:03:25 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Oct 2025 07:03:25 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <zah4lafziwkqty2qw6erkbq3wfilfneom5vm6vcfqk5b644iff@rcebhmsrgmmd>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
 <20251015-refs-code-cleanup-v1-1-550fdd8a3b41@gmail.com> <zah4lafziwkqty2qw6erkbq3wfilfneom5vm6vcfqk5b644iff@rcebhmsrgmmd>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Oct 2025 07:03:25 -0500
X-Gm-Features: AS18NWA8FZcCJZ9SSNBxkpsQXCz6jRNewrleDX6-64iOLQH_fvgh98l-QcRQpjc
Message-ID: <CAOLa=ZQ-Ri7_SgPttqphRNNB7-AryNcSbcRsjWF_ua9jQxM92g@mail.gmail.com>
Subject: Re: [PATCH 1/4] refs: move to using the '.optimize' functions
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000009222c206414567d2"

--0000000000009222c206414567d2
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 25/10/15 11:25PM, Karthik Nayak wrote:
>> The `struct ref_store` variable, exposes two ways to optimize a reftable
>
> s/variable,/variable/
>

Will fix.

>> diff --git a/refs/debug.c b/refs/debug.c
>> index 01499b9033..40cd1d9c15 100644
>> --- a/refs/debug.c
>> +++ b/refs/debug.c
>> @@ -116,11 +116,11 @@ static int debug_transaction_abort(struct ref_store *refs,
>>  	return res;
>>  }
>>
>> -static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *opts)
>> +static int debug_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
>>  {
>>  	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
>> -	int res = drefs->refs->be->pack_refs(drefs->refs, opts);
>> -	trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
>> +	int res = drefs->refs->be->optimize(drefs->refs, opts);
>> +	trace_printf_key(&trace_refs, "optimize: %d\n", res);
>>  	return res;
>>  }
>>
>> @@ -430,7 +430,7 @@ struct ref_storage_be refs_be_debug = {
>>  	.transaction_finish = debug_transaction_finish,
>>  	.transaction_abort = debug_transaction_abort,
>>
>> -	.pack_refs = debug_pack_refs,
>> +	.optimize = debug_optimize,
>
> question: Was the debug backend not using either of these callbacks?
> From the commit message, it sounds like all the backends were using the
> optimize callback.
>

Since there are no users of `refs_pack_refs()` which uses the
'.pack_refs' field, there are no users of 'debug_pack_refs()'.

But if tracing is enabled then the debug backend would wrap around the
other backends and any calls to `refs_optimize()` would call
`debug_optimize()`.

>>  	.rename_ref = debug_rename_ref,
>>  	.copy_ref = debug_copy_ref,
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index ed8a1729d6..92d90fc508 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -1444,8 +1444,8 @@ static int should_pack_refs(struct files_ref_store *refs,
>>  	return 0;
>>  }
>>
>> -static int files_pack_refs(struct ref_store *ref_store,
>> -			   struct pack_refs_opts *opts)
>> +static int files_optimize(struct ref_store *ref_store,
>> +			  struct pack_refs_opts *opts)
>>  {
>>  	struct files_ref_store *refs =
>>  		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
>> @@ -1512,15 +1512,6 @@ static int files_pack_refs(struct ref_store *ref_store,
>>  	return 0;
>>  }
>>
>> -static int files_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
>> -{
>> -	/*
>> -	 * For the "files" backend, "optimizing" is the same as "packing".
>> -	 * So, we just call the existing worker function for packing.
>> -	 */
>> -	return files_pack_refs(ref_store, opts);
>> -}
>> -
>>  /*
>>   * People using contrib's git-new-workdir have .git/logs/refs ->
>>   * /some/other/path/.git/logs/refs, and that may live on another device.
>> @@ -3969,7 +3960,6 @@ struct ref_storage_be refs_be_files = {
>>  	.transaction_finish = files_transaction_finish,
>>  	.transaction_abort = files_transaction_abort,
>>
>> -	.pack_refs = files_pack_refs,
>>  	.optimize = files_optimize,
>
> Ok, we are removing the "pack_refs" callback and its implementations
> from all the backends in favor of using the just using the more generic
> "optimize" callback. Make sense.
>
> It does look like we still have `refs_pack_refs()` which references the
> "optimize" callback. It looks like there are no users, but should we
> also remove it as part of this patch?
>
> -Justin

It's done in the next commit, let me just squash that in to make it
easier.

--0000000000009222c206414567d2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 784467e21d65a8be_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdzN3d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzkzQy8wVmlkWncrdFlIUVB4TTkxcEUzNVpCOGV1bAozZWkzYmJKQ3pH
MTFnd2xkT0tVVktyMVdoY0V0VHR5Wm1sNkhNYlZyL0ltenUvbTV2SHVLck1NTmdRMFZTWVE4CnNa
VWxaNThJWSttZGtpU2Q5Y0FDejZickxiWVdhd1VDVXZYRDJ4VFJWamZIZzViS3VPVklEeE8xWThh
dWt1NG0KbXUxcmZ6SHR4VlQrVmpqcGlMVTJVRExIdmw1OEQxZC9Oa1hQYkdwRWF5b1VyNXlSTE9h
Yk1HYXljZjc0RnBDNwprTERkRmJTQS9nNVFvT2wvZU1yOHZzZEFkVlQxZWdjaUwzOTBsV1pjTmNN
c2NiMi93MW00NG10WGxLcG02UGhkCmhQd3laZ29ObE9QbGRqOUxTaTB6Z2Y2VXZNWTc3Z0gvVElI
ZVNVUFZHd2pJa3I4SGUyLzYzMTlDaWdNN3liVzUKeTRuanBJWjdaWmp1c29iZUF3TGgwelJmSVVJ
T1hwUlRTOTJBUVgwQkMxWUowT1pndUJpREVROE91SDYxRmNqQwovS2hrWENFbkFhSzNZTVNCMFV1
L0Y4ZjBYN3M3ZHY2bGZiQ0g0OFUzbVBiYTBGa0c1UlFGcDdLa2FVSnhpTGJHCmdDVTdzOFpkMkxq
WUZNNjFhcUladFdKQjk0cVl6SjA1MlFTejQ3RT0KPUpSeFEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009222c206414567d2--
