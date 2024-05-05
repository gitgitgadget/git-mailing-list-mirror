Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB97E112
	for <git@vger.kernel.org>; Sun,  5 May 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714925389; cv=none; b=qPBWsDmlHSEd2h4FhVZR3cXSSxoDIo8f1JSd9zEA+FKqieRTNTkqCXp1JNygosvQFVdWZry0++hgNZaxdXwP2wMmVesdyfQVsipXVm+NN8//Znqzlk2qd89geAv3ZU96sw8YnJafde3flImhhEEigLtNq9Lh73dpP6iqExqKZ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714925389; c=relaxed/simple;
	bh=SgRgFkB33FzABCd+H5iMw2DE8sh3vHcbRB2PZoHZRf0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1N2X3LXbhccLh3B1MHOuRredHO9vVI5WabzgLXJE67rWX3L3g/RWg6ZZ9qrkcctvvAij96rtlCIZni5Tluit7druTy/8Vl+ImFpcuhbAuaFNy+wS6k28xdQBUKtsnCh1yw//USiGWUk5fQLYibq0OZ/Pfig/jWqdAY8m/KhUrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5ySa2qP; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5ySa2qP"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23f0d54c5ffso634077fac.1
        for <git@vger.kernel.org>; Sun, 05 May 2024 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714925387; x=1715530187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3KgRAHxDTw4JeXHTGIitdA+6LHa1tBGUPIx+w2WvVFU=;
        b=C5ySa2qPwMWNIeeHqxqoJVdpHZs3sJf7enCblIMcOVnM6HRb+EbmL+MbYPEzufRbI6
         /DydZlPWy8pP/Mx/t8m9N8a2DXH8btaAeOSXAMg72338p8gTvdduNplX5qAE748fXQpq
         ZMcvXy2P2NWh5Zszo8IWMcaOO+Bml6WRq1F+AEuId12cuLJV9wmJGexxi/1aQpOif9J3
         ZaSN/K/eqHYbqdmbmtQVelRlRRqSo55wl7PHKKxe23i0yzbjlEZkBLy3NTww0BqrNOdN
         /WoBkrz8W80jk6+wVrgMz0aYH06WuhwtXZYSl+/Bw/S9vixfPcFm3f62Y0yloc+Orkw1
         PK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714925387; x=1715530187;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KgRAHxDTw4JeXHTGIitdA+6LHa1tBGUPIx+w2WvVFU=;
        b=wdGPU3Ye78SJx20v+B9FXOR1GoMkbduBYP071H15LG+qgXx8q/Bl8nGCG5Mhm5yWMC
         gpDxSNc0PisIuH5nHsfIC0PFEujiWlIQv8CwfgLHgffm/EpKzVVF0KpPaPmRpeVnhU59
         ImE6eF4GcHj03TVSCKL+yY+TcAnfsum8XDqYjFhnh7bXIQV+c0Y9TFA5/zo9jsxZWzfm
         XsWfsUOLpWbAFTVDLsoVN3gjTfeKoJ6SsrAvNoI9UOx9KQlwas1wSyn/4rZv3qTAB1el
         u2Rv8R7U1PDp7OAaWkCIEpUbKnXbuGu8vR6bo3wa44TQbzo58kP81ITk553QhV7fD8rI
         Lpcw==
X-Forwarded-Encrypted: i=1; AJvYcCUjfCHERUGPELwS2nxprptTGe2i9+/aOVQhl/ZJ6DIaxCcgyccEbo42NJq2qCVc2LHJhrRMQGLwKXM0zp001jEooX5B
X-Gm-Message-State: AOJu0YzvvVQMIU0TmlNfixEN3ke5tud7w5DrQlfwqLzr027f/muoW9Sn
	brnP+a9r2+RY6r1vB9CpOfCqYb5EUSHtyMJQiwpT6j9ahpV9hRLAqThXMhZUH1oy+yaHa9kWIbM
	2618b/RtKIaf+wf+jvdrHBj6qRIE=
X-Google-Smtp-Source: AGHT+IFI5p+SYwpykaeI20nkl/fiLvYmwzs79VKRzy2X8/PjTbQu2GLuhDdNPqi3HNNENJyCYBwtbjogSD7sT/+90fQ=
X-Received: by 2002:a05:6870:d38e:b0:23f:59fc:e509 with SMTP id
 k14-20020a056870d38e00b0023f59fce509mr1976998oag.4.1714925386939; Sun, 05 May
 2024 09:09:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 5 May 2024 09:09:45 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <17c71b18-20b4-4bbd-b52c-c29ef8d3860e@gmail.com>
References: <20240501202229.2695774-1-knayak@gitlab.com> <20240503124115.252413-1-knayak@gitlab.com>
 <20240503124115.252413-5-knayak@gitlab.com> <17c71b18-20b4-4bbd-b52c-c29ef8d3860e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 5 May 2024 09:09:45 -0700
Message-ID: <CAOLa=ZR5a0Tj1abM4z4SAVm5cw5+EA0qyoOMs8QH8MoS6eJGiQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] refs: add support for transactional symref updates
To: phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com, 
	ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000008163780617b72e3e"

--0000000000008163780617b72e3e
Content-Type: text/plain; charset="UTF-8"

Hello Phillip,


Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> I've left a few comments below - the most important one is about the
> error messages in the reftable backend, non of the others are worth
> re-rolling for on their own.
>
> On 03/05/2024 13:41, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The reference backends currently support transactional reference
>> updates. While this is exposed to users via 'git-update-ref' and its
>> '--stdin' mode, it is also used internally within various commands.
>>
>> However, we never supported transactional updates of symrefs. Let's adds
>
> s/we never supported/we do not support/
>
> s/Let's/This commit/
>
>> support for symrefs in both the 'files' and the 'reftable' backend.
>
> s/backend/backends/
>
>> Here, we add and use `ref_update_has_null_new_value()`, a helper
>> function which is used to check if there is a new_value in a reference
>> update. The new value could either be a symref target `new_target` or a
>> OID `new_oid`.
>>
>> With this, now transactional updates (verify, create, delete, update)
>
> s/With this, //
>

Thanks, will make the above changes.

>> can be used for:
>> - regular refs
>> - symbolic refs
>> - conversion of regular to symbolic refs and vice versa
>
> Excellent
>
>> This also allows us to expose this to users via new commands in
>> 'git-update-ref' in the future.
>
> I'm slightly concerned that splitting out the update-ref changes means
> we don't have any test coverage of the new code beyond the part that is
> used by refs_create_symref()
>

This is definitely true. But I also caught a bunch of edge cases this
way because the tests which indirectly use 'refs_create_symref()' are
quite intensive.

>> Note that a dangling symref update does not record a new reflog entry,
>> which is unchanged before and after this commit.
>>
>> +/*
>> + * Check whether the old_target values stored in update are consistent
>> + * with current_target, which is the symbolic reference's current value.
>> + * If everything is OK, return 0; otherwise, write an error message to
>> + * err and return -1.
>> + */
>> +static int check_old_target(struct ref_update *update,
>> +			    const char *current_target,
>> +			    struct strbuf *err)
>> +{
>> +	if (!update->old_target)
>> +		BUG("called without old_target set");
>> +
>> +	if (!strcmp(update->old_target, current_target))
>> +		return 0;
>> +
>> +	if (!strcmp(current_target, ""))
>> +		strbuf_addf(err, "cannot lock ref '%s': "
>> +			    "reference is missing but expected %s",
>> +			    original_update_refname(update),
>> +			    update->old_target);
>> +	else
>> +		strbuf_addf(err, "cannot lock ref '%s': "
>> +			    "is at %s but expected %s",
>> +			    original_update_refname(update),
>> +			    current_target, update->old_target);
>> +
>> +	return -1;
>> +}
>> @@ -2576,9 +2623,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>>   		}
>>   	}
>>
>> -	if ((update->flags & REF_HAVE_NEW) &&
>> -	    !(update->flags & REF_DELETING) &&
>> -	    !(update->flags & REF_LOG_ONLY)) {
>> +	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
>> +		if (create_symref_lock(refs, lock, update->refname, update->new_target, err)) {
>
> This line looks quite long
>

Somehow I find it much easier to read these longer lines, unless there
is a logical operator, but I'll split the line mid way with the
arguments.

>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -938,7 +940,22 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>>   		 * individual refs. But the error messages match what the files
>>   		 * backend returns, which keeps our tests happy.
>>   		 */
>> -		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
>> +		if (u->old_target) {
>> +			if (strcmp(referent.buf, u->old_target)) {
>> +				if (!strcmp(referent.buf, ""))
>> +					strbuf_addf(err, "verifying symref target: '%s': "
>> +						    "reference is missing but expected %s",
>> +						    original_update_refname(u),
>> +						    u->old_target);
>> +				else
>> +					strbuf_addf(err, "verifying symref target: '%s': "
>> +						    "is at %s but expected %s",
>> +						    original_update_refname(u),
>> +						    referent.buf, u->old_target);
>
> The messages in this function differ from the equivalent messages in
> check_old_target() from the files backend above. This is potentially
> confusing to users, creates more work for translators and makes it hard
> to write tests that are independent of the backend. Can we export
> check_old_target() so it can be reused here. If not we should reword
> these messages to match the other messages all of which talk about not
> being able to lock the ref.
>

This is very intentional, the way the backends work at this point are
quite different and while in the files backend, we talk about locking a
particular ref. In the reftable backend we do not lock single refs. We
lock tables. So keeping it consistent doesn't make sense here.

However, we could make the files backend similar to this one, I would be
okay doing that.

>> +				ret = -1;
>> +				goto done;
>> +			}
>> +		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
>>   			if (is_null_oid(&u->old_oid))
>>   				strbuf_addf(err, _("cannot lock ref '%s': "
>>   					    "reference already exists"),
>> @@ -1043,7 +1060,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>>   		 * - `core.logAllRefUpdates` tells us to create the reflog for
>>   		 *   the given ref.
>>   		 */
>> -		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
>> +		if ((u->flags & REF_HAVE_NEW) && !(u->type & REF_ISSYMREF) && ref_update_has_null_new_value(u)) {
>
> The old line was already quite long and the new one is even longer -
> perhaps we could break it after the second "&&"
>

I will break it both the && I think that is easier on the eyes.

>> +			if (create_reflog) {
>> +				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
>> +				log = &logs[logs_nr++];
>> +				memset(log, 0, sizeof(*log));
>> +
>> +				fill_reftable_log_record(log);
>> +				log->update_index = ts;
>> +				log->refname = xstrdup(u->refname);
>> +				memcpy(log->value.update.new_hash, u->new_oid.hash, GIT_MAX_RAWSZ);
>> +				memcpy(log->value.update.old_hash, tx_update->current_oid.hash, GIT_MAX_RAWSZ);
>
> Both these lines would benefit from being folded
>
> Best Wishes
>
> Phillip


Thanks for the review.

Karthik

--0000000000008163780617b72e3e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 146e1b7903e6f4e7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZM3IwY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHRlQy8wYVFaRWlTT2YxK2ZUK3dhZittQlF5NlF5NQp5VDZzbVRzcnFZ
VG9iWTFvTnJPSXUvaWhrNXQwSi9MTHl1ZlM3aTZtNElzTlZGZGp2dFA3bEs1WVcxYURTRzU1ClQ5
K21ueWcwWWR3UktHbTB1RHlvK3oxOXZBck5DS2hJSmZaaEZwMWJXbWRzWFpZSmZLdDFzRy9hajhT
a2g2L3AKYmpNVzh5SmYxZk9jZUxod2xCSVJtQWpHenNha09iWHllK21vY0pFNWFFRkdaZndaeWl3
ck9FSVZjc0VGR1ZYbwp5N2NyVGR3dlZ0bFRvbCtjMzlGbmw2cFJWNmk4bmxlelRPeGFhdE1EUzhW
Zis1YWtsQUZIUXVtdWJZbEIyS3dECnBKOW1DejdLYStPY0tPdDFrbERNSjh2WTdhMjJ5MnNrVkJj
UnZ2NlM5QnBjdzdxSzBtOFZDOVlQSmNhQjVNYXIKdGIyRVJCT254WVVBQTA5alh5SlovekM2emt6
MUFTdTNCNXBaQjZuWCs3ZWpiNEp6OVdxckh1NnR1Ym9NNnBRNwpHVUhuZlpaRU1YZ0FYVnNZTFAy
Ymk1LzVMaHBWR0xVNUVDNTRPL1BHcU1GT21SbGRIQis4YkFieXphNXBLTDBBCktwejBrNEtLampo
cW85SVdaVmJsRy8vZTlUVU5UMStjUnltS1E4VT0KPTljdzUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008163780617b72e3e--
