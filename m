Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1F24C676
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179791; cv=pass; b=KVdGEZoI5UjvJDdAC/9DoySG8RePhzMcKdBt6YLvExM07zuh9HzSKvJZmKjT/nHK9kmp/2uO1v2a0BiQ1o78JiouV02J3sPdCFFGOEHdsTnJpdt+QyBenvmG5Som/ABSG2BnkM6nYwQpIODhSJ6KfjPmX9Hsg0wkaf83f0WgZkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179791; c=relaxed/simple;
	bh=c6AjoEKnrghhEmVj84i6AsLZpaLiGL01iY8zefXaHI4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eb7SGmM/O8x04LDELFEpwdcs9I3fuH99MWjarlbHA0P/hIJm5JYO2kYPyubINlLchFkcW96kfDEmLBJPQX89uTlKlBXS1/hu4LAI3pGvC/llQOxhoOYYBjYnRAH/tx35LBWCV1mB8XJDVU8vp5W68x0BY+II9K3lrm2qXQWfq9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnjSqNEG; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnjSqNEG"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9480078b2fbso2290378241.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 06:49:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769179788; cv=none;
        d=google.com; s=arc-20240605;
        b=X9vmte9j50lkYQHPRI5qCKdu4D5ExUvpctT4g+fx+7PL6enCZK8edREeKNrjBjBjOE
         63ao8s5GSmDFWyPNgyw7bewBhRjS4hV3TjraZiSNf69RKdRSoIz4XtyiWO6IV4Dv3aMT
         QraV1WxYQOvS2TvDIoiAt6dnDXSCySacoM0n0uhTgye1oiDqg6fHImKl6DASfhw70wyg
         RTBViZhwiYDtOCk9d9I4Rfui675Oa6IZyMrwo9UO2zy1ox2c6kFfTB4isVi5djRVkZno
         SfXixaTgLq9/q835zgYjdURSFY3bdcoyDRoz31z4qaBjhIxrCCxdNtoDPTiTJ0wbSQjW
         BjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=qDmddaS7YI0FLs8w7bPSM4EF+f2gT+OamcDSPM7zk0g=;
        fh=LrV0gm1y5AUAMOc6gVEyY+U3tdxxtrFOSNFgmZR9U/M=;
        b=KTYPjZ19CysfrPdJzjzAbM9RrwJtvLm1jSBdCOvBYpWUg1jl2k4DqCmrrE0joT9C/F
         KwV/MQVXQKvlBRL9EGBg3rE5vUSnca40o0voIqEkJTp3HrKBGmJxYNloZKbvcg+Cvj66
         pPE+CtMpR+3O1xA43gv//+btMxB/BoQRCVGwQbYVUYWoL7qryZaCalXaXPVQ44/zuqTx
         qCCwoehPL5T9Zb5RpuDlZc1QKTuv11FFiAmJghP9W8GpnzInlI33wzMjTZXTomfzmCEF
         ajFXV2fF2NcFhZUNcTB/59q22Xv7ML2Sc39EhIdpGMZOOoFjLhcnnWHgPWj1fxHwFBH0
         /W7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769179788; x=1769784588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qDmddaS7YI0FLs8w7bPSM4EF+f2gT+OamcDSPM7zk0g=;
        b=bnjSqNEGk6hMTvLlaJvkGlMNfaJx9jD6zAr15WH8eRNV2W1qN3iIrlgezqYet8eVWg
         IEEPuTKJ5TmUI7bMTRvdxoHWJ5A9Sm1yZqFvulxABmikLpLYEylWxxzPwIyLXP+E2cNN
         iv5sjWsOIPE8B6f8sYmIPbzwTNIIaMS9PUCC8GAKPNutlFlpX02Vu2d1ZIYznVf2W7e1
         +YdxO1kCZKmXMwb08AJFv5Soj1cNtbLzYAl/OnIKh3NJdYpncfBl/b4sbas+28iR7Rps
         3agJIZOLTgBUs63/AUnbKK/Y0UfUuXSCpodpBjavwyXWJ9bFhddVQHkWHKdoC6k7OSyX
         nUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769179788; x=1769784588;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDmddaS7YI0FLs8w7bPSM4EF+f2gT+OamcDSPM7zk0g=;
        b=KeQu2dTgoRsOYyUGSdBgP61ZZNQCauV4QiU3Zt6sbtG5knYKNAQNSd7DG4rzvZkdXr
         0kmCS2Q5cXTcRyUl2po6R3GmTQGJYxoXhYM+KG0QAMW9aMpEl9CMQ1hTnPVtGQykaqI4
         2ze8N2hs+Srrr44tU7nwvrquqxcuC0dVn0XYUc3yOSeqbCPGU5RWcCJxzO57sgbyTfOF
         pE5BBbx0/DGGilvvem5HnncAQHCSNdU5W3aDygNAgiZTCJQNDz5/j+t5TJa5SdgUq2x1
         gWoG4OVl3uOJajJTrwhqMb7P6V3OMajMaqQ/q3EhNZ0Xo0r3/Z8QSbvWwI7K6iy0CPN7
         JUAQ==
X-Gm-Message-State: AOJu0YzSP55ngGC/xHDZJv0X3ni0VjCABdZg/GAiXS3ZbWipMAroOfjw
	mwhIaoSqtDhn/ec4kRTCgPT3sfGjWBlmvPwYmZKW6FdwfngRxCAB1ZCFc6xma5utsUAgV2CoFCK
	E+ptKNwDJ89D2YGNVWMMDm1ITGgw9TVg=
X-Gm-Gg: AZuq6aJNvEn53ExTOKeoukObxRz7D6uma5a+2I7fcE8rUA73xrKZn18sObo9qrZvHfc
	HQLiTizxmFXRC8M5uc4oGooui+jw4Px4Mf9g9TZGL4bhvWwMMAmPvAfl8FnshMdiriEn2btn0X0
	DIp1Fyd1/eNFDLf5WQqJcFvlu6f/QeJYAkgBXVUia4zyiHue6eC41x3rcAycFDkvCNi5XzXLCMH
	icZZu/SA00EWGHTJ1ov5z6xWAeSnWtlobxcuSHlykOu0VdGCYGhfI6xXWfKxZfb8xT79AV7orXJ
	q8s0wt/fterhao53w4GNhPSIrzyoi9SsU5wR3j/o
X-Received: by 2002:a05:6102:5108:b0:5f5:2954:d1e0 with SMTP id
 ada2fe7eead31-5f54cbd741emr1058225137.22.1769179787868; Fri, 23 Jan 2026
 06:49:47 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jan 2026 09:49:46 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jan 2026 09:49:46 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqldhpmmrw.fsf@gitster.g>
References: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
 <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-6-2ddba0832440@gmail.com>
 <xmqqldhpmmrw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Jan 2026 09:49:46 -0500
X-Gm-Features: AZwV_Qi-gyNVrU7Sla_hB8f5I1yRWkEg0lTk2jh-wcyTLhHRFO9JjoK05q_rLEk
Message-ID: <CAOLa=ZSLPasvFrCgKzVOq7mDXiqX9SxoOf0MZdzBXOLn73okMQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] fetch: delay user information post committing of transaction
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net, newren@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000ccdd8f06490f4413"

--000000000000ccdd8f06490f4413
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +struct ref_update_display_info {
>> +	bool failed;
>> +	char success_code;
>> +	char fail_code;
>> +	const char *summary;
>> +	const char *fail_detail;
>> +	const char *success_detail;
>> +	const char *ref;
>> +	const char *remote;
>> +	struct object_id old_oid;
>> +	struct object_id new_oid;
>> +};
>> +
>> +struct ref_update_display_info_array {
>> +	struct ref_update_display_info *info;
>> +	size_t alloc, nr;
>> +};
>
> OK.  The ref_update_display_info structure is full of pointers.
> They are of "const char *" type, hinting that they are borrowed
> pieces of memory, and there is nothing to clean inside, other than
> the .info member itself?
>
>> +static struct ref_update_display_info *ref_update_display_info_append(
>> +					   struct ref_update_display_info_array *array,
>> +					   char success_code,
>> +					   char fail_code,
>> +					   const char *summary,
>> +					   const char *success_detail,
>> +					   const char *fail_detail,
>> +					   const char *ref,
>> +					   const char *remote,
>> +					   const struct object_id *old_oid,
>> +					   const struct object_id *new_oid)
>> +{
>
> This helper that consumes the structure is used throughout the
> patch, and relative to the previous round it got easier to read.
>
>> +static void ref_update_display_info_free(struct ref_update_display_info *info)
>> +{
>> +	free((char *)info->summary);
>> +	free((char *)info->success_detail);
>> +	free((char *)info->fail_detail);
>> +	free((char *)info->remote);
>> +	free((char *)info->ref);
>> +}
>
> This answers "no" to my previous question.  These are not borrowed,
> but are owned by this structure.
>

Yup, cannot be borrowed, since those go out of scope much earlier.

>> @@ -1965,7 +2090,17 @@ static int do_fetch(struct transport *transport,
>>  	 */
>>  	if (retcode && !atomic_fetch && transaction)
>>  		commit_ref_transaction(&transaction, false,
>> -				       transport->remote->name, &err);
>> +				       transport->remote->name,
>> +				       &rejected_refs, &err);
>> +
>> +	for (size_t i = 0; i < display_array.nr; i++) {
>> +		struct ref_update_display_info *info = &display_array.info[i];
>> +
>> +		if (!info->failed && strmap_contains(&rejected_refs, info->ref))
>> +			ref_update_display_info_set_failed(info);
>> +		ref_update_display_info_display(info, &display_state, summary_width);
>> +		ref_update_display_info_free(info);
>> +	}
>
> And after a fetch finishes and we consume the display_info, we call
> _free() to release the resource held there, plus ...
>
>>  	if (retcode) {
>>  		if (err.len) {
>> @@ -1980,6 +2115,9 @@ static int do_fetch(struct transport *transport,
>>
>>  	if (transaction)
>>  		ref_transaction_free(transaction);
>> +
>> +	free(display_array.info);
>
> ... of course the array itself, which makes sense.

Yeah, the CI also didn't show any leaks, so we should be good.

--000000000000ccdd8f06490f4413
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ec4b5796b44b003b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1semlvZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meCtzQy85UjFKRHlWelpqWGtxWldweExOeS9YdkEwdwo4czBLbGJGTURC
aCtxZmY5U2FWalFwSjFReHRSYjQ4SFFHM0xxaU1CR3R4OTZkMUgrc1lzUjZ5Slp1NlBLT2luCmdu
eTFOWVlMN1IwSlNCNmM2bjhCa1Q2WnpmMFM1WU9OY2xVd1c3MXRHdFB5M1JpN3JUeFdJU29aaFVV
bi9oRHMKdUh1NzRlamxHYVhOREtNcHV2SVpEVENodXQ5RXNVTEZuVVpkVzhRSjlaRndnQjhsNlFC
NkljY3lsUy91aWZrdgpQbnpYQzd4ajQxU0F6RFJhOUpoNmR3ZkNmV2FkZHFCNHJkVWdRZGZGYi8x
VkNaUUNNV1Z1QmZCbDdsQkVSMkNHCkxqVnhnNVBxdnFzWk01TnNWTFdFcko5ZkxObVg5YmdVd21K
WUVVejlnMmdnYUxOckhMcVVlbWVQUkZSeDF1eXcKaFpKNjJoN2FoQUhKMHppM3ZjK0k4VStwaVZk
dHVIdDh6ak1EaXN1QlZ2YVJ3Q2xMRUFzMmhocXlDUFFQTmtQSwpZK21kR3RyS1VZeEFxQ0Y1UXlD
ZFNGQUd5VWlscVdSaEZqVVRXYW5DZHJMQnhBMjUybExPenk1b1M1TmdvbTF2CkVaV3RJem5VSnVS
WTZpVmI0V3ZjOExaTVl5dUVUbW1wYWxQcGZsST0KPW13eFAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ccdd8f06490f4413--
