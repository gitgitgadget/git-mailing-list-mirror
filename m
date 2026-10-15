Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237C747D933
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060299; cv=pass; b=jLTzNgWVofDunxCyFfOk/xjBhWKIORfh7FJBDf961NreIrwcvFtb1XAXHzzlCfDVGAvKwL+QXOKkq/AEPb+EcmevCOCo/pw8a8BVnXXho632wXFDsyX8C25MU2SAGITcbdQ1A2uvRgAgyBZmEjsXqFsyGCzLn1aPmQ5Eprclprw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060299; c=relaxed/simple;
	bh=V/aKiWYcC+YsWf0dwnbvOVqsxGel74PlhrKp9khZldE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sA2y+eDRsT0X1B7s9hf+peH5TMAv05h67FMnhTuNyE5nTK4CZEfBKTK9DnCpwi66z5+3vTUhv2JBscZ26F+auQwNOmCLpBhqCUWNnZ0kFVSD3iwHiOgvneIIxvG9X9/Zck+EMKvqs/845blbzQJOZyAVdAEottBqtmoFTRTK3S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1h0TuRw; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1h0TuRw"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7a6e560f580so880898137.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 03:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792060297; cv=none;
        d=google.com; s=arc-20260327;
        b=ju7CrvlcuA3tCuc8X1uMfy8+tvZ2wz7IPTOk2UtXbUcokXYe8ijjmwRCt+7SdcW3MN
         0jjopBk+aXnVHMkEtbJinNEAIYVTb/Z+0jUmnjX+1hJfDIoUYA04SaQLgqNdBHC+8heK
         BFvcP3v6F4xAlKjHvLgKgZJqGHfBvE299rgX7Q9D+7DTxcLMX22glbET/nTIrYNgY0e2
         qV5lfEGB+G68L4uBTZtzQfsP7s72MGXWKkDFlze2A2Ki15FRsnwHxHhG48fEhdf8E14H
         J7+GtTJs+8TZ3Zfs+nla+ZpTmKNZ8+yWGOwfGoWmFcQfef2Xnr8ZtRAi+dYrw9fVZ/xb
         VTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Q98FNU7gCT3hjeOfKaVxOhFzZdq7yq49fSjTxBD3QOM=;
        fh=BFdCRI/ROET9g0ZAiwXhRoGcGbphKtUwT/ZKBOuiEgI=;
        b=ZGWAcGre7xjbFZVS5qW/0Np084a5Q4t4+c9HokJm8XOCvKi6EUBYVU8AAfW7o7wt/X
         4dxKjapuXGHROUIzOnCLuH6AC6MVKjVhAf0zyu0MnC3JlzcUO9SRTOGiPJ+5W3YcwSl6
         CZfzYUrJKy5phR1JSemsckvGITCpQOHVJnH3E8PMePZBydEvhJGjEeQET9iww7VQB9X/
         rgG3eO9hSbfQ+SUOqPyckisW/U6zrMIthrVfNDgJjJsxY/xX1Mp4ePOrGY3U0phPouVU
         T2t+7pZHGGgLvOKORzfjKDEhhETv3EQnpkeBA3Jka4BvbCT8NYdqBBap89dzLxv9IMeR
         zU+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792060297; x=1792665097; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q98FNU7gCT3hjeOfKaVxOhFzZdq7yq49fSjTxBD3QOM=;
        b=k1h0TuRw3eEbjBsPrnCJFW4xajAHXMcyKjj9SkxU3ESo5EkRo1wDCxPdTnXKRGqlCZ
         fjMP7O5ii8j8zeftj1Z22PrGwje7DNAH87ycTu4op1DXOeMxAES3QaQOX6Rhq6j2I/Ho
         tsMYn/TC/OBcWHRrQWOdngNr2DIgpj5mUkMOTYaHBNS3Dws4g8+zbS5TFIVwRgGoOzmt
         jfLtkNfVgXua9rcVgPOwqhbJxSq7Nr4X+uRJnXydV2wte3cWZGG7mTfzgTEJcm9B4SFp
         XBozUpllfm0risNSJoXDJdM58q8YOL3MQiX9TaSfZgxUmpbWL4eiF3qWpepni8Ytjz24
         8L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792060297; x=1792665097;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q98FNU7gCT3hjeOfKaVxOhFzZdq7yq49fSjTxBD3QOM=;
        b=ZVlO061uBbq56soiK1RwesFCcGuAzTDKFYyUQ8+Ol5HRxVMCqSir6f9Ue/KCknvj2M
         Dt/vQ6PI7+RYjMmyLT0CbFRT8qLb5CnIUaqSVw8Sef4TXMP0q7WkNWeTzCUqW/HXiWAd
         19ba5Vh4S6Udq9w4PO2D+9hvuqY3WRh2h6kAgCLERPiqc2cl4mZo2hQb4Ko5aMoZap+P
         h3LHHCtjQ/IPzjoz2AyR41OdO0OvkCL4MYtcNTM5QIptA1/yscTg3/UUDpgCRoXISieO
         2DQYLh/P59fA2jAo0/aoaIzwqX8MW2/1UQmpxEmBOLLp62cHHEWoey4TMhiGDGOHVPUX
         yaTg==
X-Gm-Message-State: AFq9FYJjBWszJdRCQTpj1DbWcyg9QRxR2sFAFxEFIjJUTEGVygTvNOiM
	xjmy+cKCKFPWHfO87evnRy4U6dqkN/pPaATwytezFhuX5mI0Ob8ynig8r2gdOMfC1+vnagvHDMz
	DKb65BX4tkp/zydCX6YtbxwIUfWRQ14g=
X-Gm-Gg: AYBFou0d2Sjh1lR13hI4aJc822NhUPyLeayqXDjM7Oayoi6dMvQ8SR8Mhj7VM82Hc/l
	ON9ZMx/XsD/Jl2atiwKoUWXToD6AYJSIVuSjF3q7apM3PKuV7i00e5I7cpnvDQWhHQ6yOO9mmzv
	Fj42XZZeh26mRm9RdEKm4wDNyEYv6KNGdObqMYO4vgSCu5Kf+DOpwMc8UGkh+xUMev/Kcvk3W7p
	bK9mGDVfArHkrC6X0plhJNYaZ8oXcVOLGKn/7ntRKB692pYM0bYEyaywMbqadZ77AEraKLVpegw
	i3+63zv4BrmHSBSHrCYV4lU25PszSEIR4ePSf5CITZt7+gWW2/kOjcMk6Lgr9mya9DnMb3ycWem
	PINsINC4Lnks4G+YxG8lvsP9qMDxVXGiH92ZUgZ73HtulnaGC3fyHBK0IOw==
X-Received: by 2002:a05:6102:26d3:b0:7a2:2068:6e37 with SMTP id
 ada2fe7eead31-7cb3729b319mr6562337137.15.1792060296971; Thu, 15 Oct 2026
 03:31:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 03:31:35 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 03:31:35 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq4ieq66e8.fsf@gitster.g>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261012-799-shallow-fetch-with-tags-v2-1-4211e9a13d3c@gmail.com> <xmqq4ieq66e8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Oct 2026 03:31:35 -0700
X-Gm-Features: AclHuK_FFdShOQDS2nNLisD7fK9VdB0byyctniXO3rN9qsz4HZx9p3BJK_5ttmo
Message-ID: <CAOLa=ZTX16P9=Sbp3z5LpYoTzgZDb8hdk4x5xaSBbCh+dBvh4w@mail.gmail.com>
Subject: Re: [PATCH v2] fetch: commit references fetched before backfilling tags
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
	Patrick Steinhardt <ps@pks.im>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000006af176065dde8dc6"

--0000000000006af176065dde8dc6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> When using batched updates, the references aren't yet committed to disk
>> when we start backfilling tags. This means in situations such as shallow
>> fetching the negotiation during backfilling tags, the client doesn't
>> have any references to report in the 'have' section. Since backfilling
>> doesn't use a depth limit, this can cause the server to send all the
>> objects present in the repository.
>
> Ouch.
>

Indeed.

>> Fix this by committing the previous batched update and initiating a new
>> one for backfilling tags. Also add a test which captures this regression.
>
>> @@ -2076,6 +2076,27 @@ static int do_fetch(struct transport *transport,
>>  		struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
>>
>>  		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
>> +
>> +		/*
>> +		 * Backfilling tags has no depth limit. If we don't commit
>> +		 * the fetched references, the backfill will report no refs
>> +		 * in the 'have' section of the negotiation. This can cause
>> +		 * the server to send all objects.
>> +		 */
>
> Does this problem only happen when the main fetch updated some ref,
> or can backfilling make such a huge negotiation even when the main
> fetch transaction is empty?
>

Only when the main fetch updates the on-disk state. If there are no refs
updated in the main transaction, then there is nothing that we could've
used in the negotiation anyway.

I will modify the comment a bit, as the 'will report no refs' is a bit
inaccurate, since it will only not report the refs we didn't yet commit.

>> +		if (tags_ref_map && !atomic_fetch) {
>> +			retcode |= commit_ref_transaction(&transaction, false,
>> +							  transport->remote->name,
>> +							  &rejected_refs, &err);
>
> This block is entered only when "--atomic" is not in effect, because
> we want to update all refs or nothing, and these "all refs"
> presumably includes the followed tags, but does it mean those who
> want atomic fetch should be prepared to see their fetch degenerate
> down to a full clone?
>

Yes, '--atomic' always had this issue. There's not much we can do there
to fix it. I will add it to my commit message though.

>> +
>> +			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
>> +								  REF_TRANSACTION_ALLOW_FAILURE, &err);
>> +			if (!transaction) {
>> +				free_refs(tags_ref_map);
>> +				retcode = -1;
>> +				goto cleanup;
>
> Is this jumping a bit too far?  If our primary fetch have finished
> successfully, and opening the next transaction only for tag backfill
> task has failed, there are tons of processing happening we skip with
> this new "goto" that we would have normally performed, starting with
> computing summary_width used for later reporting, writing out
> FETCH_HEAD, and setting upstream for the current branch, all of
> which we should be able to do as long as the primary fetch
> successfully finishes, no?
>
>> +			}
>> +		}
>

Hmm. Yeah, you have a point. I think we'll have to differentiate between
`retcode` and a new `backfill_retcode`. Will add that in.

[snip]

While testing more with regards to your comments, I realized the new
test doesn't really catch the issue, since we only transfer objects we
already had, so checking for root_oid will fail with/without the fix.
Will revert the test to the older version.

--0000000000006af176065dde8dc6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 689d120384ad183c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yUXE0VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM3JxQy80cmFDeXdzUXVtVUdaQi9HSXJ4RFU2R05XNwpCS2tKR2dzVmM4
OGxzb2thWUpINWdmNFFLQ00zNGRnaXNleVR5eDVJN0twMnlieGREWWU3dVN1bmNvVDJZaTV1CnlR
OHk4a2pkRHpmdnZsQ1FJWHVmT1puQVpRaGpvUlBNeVRVQnRIYnRpUUhMSkxXUFB3eHhYV3Rqa2JK
RGNuL3oKR2pXdkdDSmRMbDQvSzBzbVU1eGoxdUVSNkdMaHZBS0gzYmM3Q0oxK0JqbHFHQmJWMXZK
UG5UYlVjU21pV3VIRwpRV1VLY0wvZ2xYZC8rTzRMTlk0Yk44Q2RYeUtlL1hhQ3JGTHEzRkJXRFA1
K2J5cWFzQjBFdGd0ZndtbXNBazJRCjdZaFNhUmhXTncrRkpHZll6ZUkvRThqM3lOV2tkOWNla0lv
cmN0aHVXTlNmZWRQbnVodEVEVHhTUmlMbXBTam8KOWZVaFBQWlVySnBOOEVDMnZWdFNLU05uSkR1
YzZ0d2VKVHpKVE5JUEdHSm9wNkNCeTFHbTMybFZvaFduVlU1NQpIaWpiMkNrVEVvcHg3eFpla1NK
Wi9MRVRXTWlrbkxYdi9EVWJ3MXp1VUZUc3lFY29UZDlpWjI1VnAwSEMzd2FxCmxzTW9WMkNEdXZF
MGdCejFRQXJTMjBYcFNxQTd6V25kTWFBWEF1dz0KPXNkcHEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006af176065dde8dc6--
