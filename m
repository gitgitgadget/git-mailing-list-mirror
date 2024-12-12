Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A92135BE
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014877; cv=none; b=QcD6CTCPhkNvfNba8ACoiG1Pmnt9w9L78DPWZQ7Jewq26KWphsofiPR8PNON2W+FVi67SjgvaOGi5nGM7iVtoEn186pTjcIb1dK1+BF0sbUcwsOSLBetEXmqqjmxs6o5GDUfTe18nUQcwRp0dUcYOZs2c0h6f3BUn3F1ITnz1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014877; c=relaxed/simple;
	bh=oTvnHjHXiRoWb74cmOFYExCsEWzRn5eq83rujIx8WyM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zbd0Me6bjsDvGufFEEg2USmum4oGritZr5xpuzem/NKzjiTpLzSalLzW0WFi5yACpHiqvXmCMjYunUvAWxvE/8FO0ucFIvRs5+YTcoY3rcT07W7c1wxoL+vcGE3+/OZTrECKGxxLL4uP2qxPUf+ftM2a9/+p2Un4WvNbfXMzd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu0vwqUj; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu0vwqUj"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-518957b0533so190754e0c.1
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 06:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734014875; x=1734619675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cr2mMo7ax90pwwD4SuzgFSCJMfs1VPYILe8d7zhQS70=;
        b=Uu0vwqUjLxvkKeCrfTeBM89aHnveC6uD9GGVU2xxKyo0oluMCbH1sP654jQdWImemG
         /yG052l786PT+g0pbbPCKi5IL88PPSw2rxVm+vtnG8f1JC19+FOGCoya5EcVkcOpNbs+
         hLs9/vTmBdy614CbO9eaXdxZUxChETeRzexyBGrioug66u3J3fN9RQa0JxsvmBwpn59V
         q7gCe37WQv4dRZrxoKtThVmYfVcIpIThp92iBWIHtcs3uEVbwnsoCYrZPpX4fssGaUj/
         qQ5L6SPEDRDNnUEfzUlMKwemyn8qapaalX95XRhtwKYxfADeV9xhSMvCLGdUOwKkaLd4
         W0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734014875; x=1734619675;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cr2mMo7ax90pwwD4SuzgFSCJMfs1VPYILe8d7zhQS70=;
        b=fwE+qgku7GmrgF11e5bTS5aE4GZE1eT1kMSA5mxE0TxfLd1EUM1hmspQX/oAQ8uqsY
         Fhr2EvXotOkbfYPLOATbPojX+2xWWjErOk/qouB4fAevv3NDqjf/MOn9uNDAzZy31/eR
         mZux9xtdPSmR6uoW/IqhCFiI5Hi9SAlziDHM7rtKfGQNiRX/JqjR7rE23tZoz221kXKW
         79L3grtQ0ldv4iuwwHLKQe1TEaamE+9DkboaTfrzcg+PzQWOX6Tdka5kdCk8FwnRsfGA
         k1hLanNPTt8ds9bdkqO+8YbEPEQlO+QrurWoOd/ZWDdQOdU+P2yH7hCu4a0Omte3F/jG
         x4Hg==
X-Gm-Message-State: AOJu0Yzl65Kz+ZUxHHuxQUvs7DsKvBNI6TYkDz3ihoP1TNH1bvetj6Tn
	veWpiQhPH5D2UQLbonvamzrVUnjiHpL0hJnD2vND1Fm8hdCw3CdfZ952zCDsYmm6hwLw+W1XynJ
	BMEqGI9rhHZqWhP7QKIuB7lICgBU=
X-Gm-Gg: ASbGncsl6WkQhsrgmoZVL04EeSvFAa6t0YstAbmGZhkpCl+UTpmP9SoXZ5gylBdMf+p
	MB12uRb+HFEC4OO4JyjwCrD1SpaZO2EIC5AOl
X-Google-Smtp-Source: AGHT+IGRh+oQralQGS2JyEv6PFD4dBK0bdU4FlssjgcJm+ssaC1FlUiXF8Hf/6GJQW0pYxv9wjx7W5HSw8eHrsnIHmQ=
X-Received: by 2002:a05:6102:f94:b0:4af:ba38:d04a with SMTP id
 ada2fe7eead31-4b25808e3eemr922839137.21.1734014874703; Thu, 12 Dec 2024
 06:47:54 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Dec 2024 06:47:54 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Z1mhEsu8DBsCsYuA@pks.im>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-6-d4bc37ee860f@gmail.com> <Z1mhEsu8DBsCsYuA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Dec 2024 06:47:54 -0800
Message-ID: <CAOLa=ZQqQTEquJ0e5rG168-CVADR8K-uYma7Z8yiDCptyPgBQg@mail.gmail.com>
Subject: Re: [PATCH 6/7] refs: allow multiple reflog entries for the same refname
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000a47904062913cc31"

--000000000000a47904062913cc31
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Dec 09, 2024 at 12:07:20PM +0100, Karthik Nayak wrote:
>> The reference transaction only allows a update for a given reference to
>> avoid conflicts. This, however, isn't an issue for reflogs. There are no
>> conflicts to be resolved in reflogs and when migrating reflogs between
>> backends we'd have multiple reflog entries for the same refname.
>>
>> So allow multiple reflog updates within a single transaction. Also the
>> reflog creation logic isn't exposed to the end user. While this might
>> change in the future, currently, this reduces the scope of issues to
>> think about.
>>
>> This is required to add reflog migration support to `git refs migrate`
>> which currently doesn't support it.
>
> Nit: the second half of this sentence starting with "which currently..."
> feels rather pointless, as it's implicit in the first half. I'd just
> drop it.
>

Will do.

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs/files-backend.c    | 15 +++++++++++----
>>  refs/reftable-backend.c | 16 +++++++++++++---
>>  2 files changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 32975e0fd7a03ab8ddf99c0a68af99921d3f5090..10fba1e97b967fbc04c62a0a6d7d9648ce1c51fb 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2612,6 +2612,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>>
>>  	update->backend_data = lock;
>>
>> +	if (update->flags & REF_LOG_ONLY)
>> +		goto out;
>> +
>>  	if (update->type & REF_ISSYMREF) {
>>  		if (update->flags & REF_NO_DEREF) {
>>  			/*
>
> Hm. Does this mean that we don't lock at all for REF_LOG_ONLY updates?
> Reflogs themselves have no lockfile, so isn't it mandatory that we lock
> the corresponding ref like we used to do? Otherwise I cannot see how we
> avoid two concurrent writers to the same reflog.
>

No it doesn't, this is after the lock is obtained. We simply exit early
since for reflog only updates, there is nothing further to do.

>> @@ -3036,8 +3042,9 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>>
>>  	/* Fail if a refname appears more than once in the transaction: */
>>  	for (i = 0; i < transaction->nr; i++)
>> -		string_list_append(&affected_refnames,
>> -				   transaction->updates[i]->refname);
>> +		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
>> +			string_list_append(&affected_refnames,
>> +					   transaction->updates[i]->refname);
>>  	string_list_sort(&affected_refnames);
>>  	if (ref_update_reject_duplicates(&affected_refnames, err)) {
>>  		ret = TRANSACTION_GENERIC_ERROR;
>
> This on the other hand is sensible -- having multiple REF_LOG_ONLY
> transactions queued is fine.
>
>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index b2e3ba877de9e59fea5a4d066eb13e60ef22a32b..d9d2e28122a00ddd7f835c35a5851e390761885b 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -1405,7 +1410,11 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>>  				}
>>
>>  				fill_reftable_log_record(log, &c);
>> -				log->update_index = ts;
>> +
>> +				update_index = strintmap_get(&logs_ts, u->refname);
>> +				log->update_index = update_index;
>> +				strintmap_set(&logs_ts, u->refname, update_index+1);
>
> So we're now tracking update indices via another map in order to ensure
> that the update index will be increased if we have multiple reflog
> entries for the same refname. Can we avoid that overhead by instead just
> having a global update index counter that increases for every single
> reflog entry, regardless of whether we have multiple ones queued up for
> the same reference?
>
> I guess the result would be kind of weird as a single transaction with
> multiple ref updates would now always contain N different update
> indices. Maybe there's an alternative that allows us to reduce the cost,
> like only doing this for REF_LOG_ONLY updates?
>
> I'm mostly being careful because this here is the hot loop of writing
> refs, so I don't want to regress performance.

Thanks for bringing this up. I was thinking hard about this for a while.
I also did some local benchmarking, for 10000 atomic writes, I couldn't
find a note-worthy regression.

But I really like the point you made about how this could probably use a
counter. I think we can use `u->index`. The index field was added to
ensure that the logs stay in order when we sort inside
`write_transaction_table()`. But we can use the same here. We can simply
do

    log->update_index = ts + u->index;

This would increment the update_index as needed and also only kick in
when the `index` itself is set. Which would be only for reflog migration
between backends.

I think this would work well.

Karthik

--000000000000a47904062913cc31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9f29b07ddfe1cfe2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kYTk1a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHFSQy85SklUUE9BaGsyVlhVMmdFN1FwZWt6dHVSRApLWk5RSnFnNjVz
bjE1SWdvQWlpVTVHQmkvL3B3QVF0TFRLVzZUZzVGcWhOQVBDTWJTQ2FycnQzK1ZpcVoxUk5qClVj
MEtJa1RmaC9sNExqUTJCSnA3TXEzTTluc2YvVDRzMlo1Y3cyOHVIRE9ROWdKUVpCMmRicVNPQXJE
QTVwQ28KYW9rNmZGU1BUT1IzdFJLaG44QzhKR0xkRERNeHpVeEk5ZTFOSTVTbGJQYk40Nk5ZQU04
VE16djczdHdsVFFHawpPS3ZsUm1ielNScGwrSW9OTnhFbHVpendNNnlxRnBaN1VFbG1HQ1FtWkxU
RUdmTHZLZ1huNzJtY2sxemo2VXRoCnNYc3RxdFZLbVM0Y0M3cnliUVdqMTZBa0w0Nks5U2JGTFB4
WStPMnFRazJaVUVOQ3pUWXV2S0dEdnpWZkJUTlMKaWk4eFpOdHpGYitKZjNUNUVyU3JiZEh1cGM0
T1NJUVJ4Sy9FMFVsV0QrU2FndHU4OGJ4aHRKS0Z2d29zY0U4TwpZVTdNaVFzOTdXazJIM3dBakFr
TWU4ZGljNTZmeDhWQkoxUUplK0hGTkErZXc1a09YNjlLTEcwb05DVjB4eXMwCjdYK1RuSzBHMUcz
U0daYmczbUdzZmRocENhbW9YbFA3S3MwSFVjVT0KPTNpR0cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a47904062913cc31--
