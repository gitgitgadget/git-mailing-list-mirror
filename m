Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1352244687
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867190; cv=pass; b=bNzRszV+tj65Xn6W5b1W2rNEBbVOETNGjV1ETFSUMqimT4Zan4Uc3dRtenvc3J8dJrGCLm8k/4W81QiLSziKberUYa4iR2/8mel692jBXltr65xL23I0JNemVWMxRbxoMRkInx4r03DojKrY5HATE4oX8IiqVhi2JUE8jld8wnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867190; c=relaxed/simple;
	bh=2L2ouMaMJZql8ZCdOSzacClyJnwN+3/gdnyxElSe4Nw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijYFygIwJJvlgPdjbp+fUYeflGxF2/jWjL5mw6Ziq3csJ/SWBwSmputBfhmFIE3alo53lMt4PPDWcEtoNk/NR/GvXhcoTqrp0q91cHT60X6GwYSMzQEd2kglwSJypDr6wDyVQoYXPb/dh0QkNfT/ZtWPYZxi8HODqTSZAeJb3M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2eza6CP; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2eza6CP"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-953c5738c03so3012161241.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 07:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776867188; cv=none;
        d=google.com; s=arc-20240605;
        b=G17v1OwEInRcI3oE/+EHUbFBiQB3u1VbiyhQNhGJZDdX4SCl3/jWL+Fx9zx7iiktF+
         SRwfBN9500KYvjHa0lnNjkVtb21DuMLIxCMpONvpNtlyHeizyDIun46ucHsTxGsdPsEG
         zRDGUvhHucoE8dglrjOjfLp3Vi2LEhCmUEQNI/ilRu8qWxeIH7f6vJW9Z4AqMoxoDTvR
         a3KjxR69KcrN/KB5g6mqmcAEHjueCkcCylMBz26oIZjOBR4LdQBZt2Whqs05jChMTqda
         svLEVTrGC27cJWsTEJnUg6okTadRXMxlV+pPlkFu4TWs63cgtfnSp1yqPbRtp8p+chbP
         1Esw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=RtUsu2T3gztGD1awmV4q4V6eOJF8i3Q6kNaMvvS4rBE=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=dnSumAWir4LUJTE5LRmsYLnfV6UlOqid9k1fGAMz9Ozms6md1oBE0DO6d72R/ueA55
         n4rbdIy1ZtFxhnC9Nn64mk+L+tfsRSqwgUbHsvphH+88poFZrvzOyxJxXgpqe7mryhES
         x82UhEEj5K6svY8B8GCO4te1IZe/ngDEg/cdE0XQ7+J2IqnZR+MjB2LeX4Pq7Dgk0DRK
         BWxliqDEnGncEhnYr3MuINrF5DbwRQH+lp0yZBBvn7UHvCE1giY+8SekjZzslujCJKh4
         LdAUBO98crX57iR7Qr8dKujNSdL2gEzRWczyruw8ZoPBKYYVocjZ5CF0eef5MI980C3F
         QB8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776867188; x=1777471988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RtUsu2T3gztGD1awmV4q4V6eOJF8i3Q6kNaMvvS4rBE=;
        b=N2eza6CPbUYYALptz7qZ4erjHcTObBPgbrXT9JwXyxnpHzXfgQNnx18uHL1LYy4Ep1
         AKbXOl3QCS9QhSvoyFCFZR3r4kJLm/sWpGwOTYsvNp6ddgJH2dQrciju4xkts+u6D2nO
         vsPshxFRwWOLpcuRdVwaM4lAQ/e6IS+dHs/K5amzT8/Kritw5Z/7rcNT6dVTLbKHFX3S
         PYV03wC3wb2DYreol6/SMowIVWQChMHhThHVXeu8T55VF8ieaWFG9EX8AzbggPCQuN/J
         mU2VjAKA/NsuQtFnnMbToDC8x42JY7wj4c1JzWpxaywPlJ4IPaff1nHHOtF9OsOQ3D9v
         JwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776867188; x=1777471988;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtUsu2T3gztGD1awmV4q4V6eOJF8i3Q6kNaMvvS4rBE=;
        b=Cu/W9+QjgNlh8sop+UYf7P5r5ofi5PCWo8CaVCj5GuhSTXfpUG3/p5HRyuTJ24d2X+
         u1hTanX1ztAi+vujxc+5YZGuDWUueGiwjM2yBxgwAYtXYH1bn2dI0ut0HvgGAWlaVWAr
         DRoeIV2t0kD1U4T/zWlY9mt2Q0BmofNcZr3YBeCiCqCZlt52tG8lktwq6M4e6lfEXg74
         VW4cy6vi5Fxf+S/jxE1c0w70qIYrGLPevAY3zwaXec5PqCgzzv/AdUA/aHztMFfysT/M
         CGpTrKr2MwQHqssl1guV3knwmKDXKjffEvqhD/nOgDlbW3XkyP9kY56X9kjkjFNxxu1r
         Sf2g==
X-Gm-Message-State: AOJu0YzhjxADImmEp5T7KDuDUhtxxVv8INLSkwUWY4Krh+DzLxtHEkK6
	IJfrk+gOr8Na7KSRGBj5usClVhPh3yuf2gUOdkKHvbrBmkUpZAdq7BCgUyU3/wSLsWjymFGsnQp
	88MvX6rSYs0FFSi2k7xzxs3lGX0VjFiZZqQ==
X-Gm-Gg: AeBDievOWQOHlCmQ/aFhD//MSnJtah/Gm6o2wql1A78U9vVxp2bp1BCdLSIF/IEnTFd
	WEGC9fcWsypFNdyVpvNHNwCUq8GVDbt5CZygYVf9MAmmy68N/XBEc6q6Gf9YMkk+AMSXL2caqq6
	5v8l9CAKhwt5yzu/fIoV1U2nztogwxpogOVv0YfHYEZCPHLjUOaz6ZHrFajLcwZkctjmYYhOvSs
	Wp9y4Q9ejV+YhNBgU4+nOyi06HNs7RVtrcOxe1aTJlXTR9YsmaTF2jmvpa4u4TtP2/fWLDTMI+j
	j6lZF95d+Zy/12d8HVU5LMPyLC7RT79AkXpjunercjpMC8tht6Wtov/XQJ+1R+U=
X-Received: by 2002:a67:e716:0:b0:602:9977:a4fe with SMTP id
 ada2fe7eead31-616f67c8685mr11389528137.19.1776867187587; Wed, 22 Apr 2026
 07:13:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 16:13:05 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 16:13:05 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aeit6Ic4fUa3Xx1Z@pks.im>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
 <20260420-refs-move-to-generic-layer-v1-5-513e354f376b@gmail.com> <aeit6Ic4fUa3Xx1Z@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Apr 2026 16:13:05 +0200
X-Gm-Features: AQROBzDDRHLzrlEvRoMof03aejjDm6w-gPRsdQ5J6ME2s9PpRbk5RZGsyvQYs9g
Message-ID: <CAOLa=ZT+JL5pbvKx44fkOMqx07TcZxbC--xCTAsUThf9a7RCjQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] update-ref: handle rejections while adding updates
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000087a2bd06500d2153"

--00000000000087a2bd06500d2153
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 20, 2026 at 12:12:03PM +0200, Karthik Nayak wrote:
>> When using git-update-ref(1) with the '--batch-updates' flag, updates
>> rejected by the reference backend are displayed to the user while other
>> updates are applied. This only applies during the committing of the
>
> Nit: s/committing/commit phase/
>

Will do.

>> transaction.
>>
>> In the following commits, we'll also extend `ref_transaction_update()`
>> to reject updates before even a transaction is prepared/committed. In
>
> The "even" reads like it's at the wrong position.
>

Yeah seems like a filler, will remove.

>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index 5259cc7226..d1980c60c4 100644
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -268,11 +277,13 @@ static void print_rejected_refs(const char *refname,
>>   */
>>
>>  static void parse_cmd_update(struct ref_transaction *transaction,
>> -			     const char *next, const char *end)
>> +			     const char *next, const char *end,
>> +			     struct command_options *opts)
>
> Here you follow my earlier suggestion of using `_options` for the struct
> name, but `opts` for the variable :)
>

Haha, indeed, seems like I learn very quickly.

>> @@ -289,11 +300,18 @@ static void parse_cmd_update(struct ref_transaction *transaction,
>>  	if (*next != line_termination)
>>  		die("update %s: extra input: %s", refname, next);
>>
>> -	if (ref_transaction_update(transaction, refname,
>> -				   &new_oid, have_old ? &old_oid : NULL,
>> -				   NULL, NULL,
>> -				   update_flags | create_reflog_flag,
>> -				   msg, &err))
>> +	tx_err = ref_transaction_update(transaction, refname,
>> +					&new_oid, have_old ? &old_oid : NULL,
>> +					NULL, NULL,
>> +					update_flags | create_reflog_flag,
>> +					msg, &err);
>> +
>> +	if (tx_err && tx_err != REF_TRANSACTION_ERROR_GENERIC &&
>> +	    opts->allow_update_failures)
>> +		print_rejected_refs(refname, have_old ? &old_oid : NULL,
>> +				    &new_oid, NULL, NULL, tx_err, err.buf,
>> +				    NULL);
>> +	else if (tx_err)
>>  		die("%s", err.buf);
>>
>>  	update_flags = default_flags;
>
> I think this could use some curly braces to become easier to read, even
> if it's only single-line statements.

That's fair.


> Does this change have an impact on the ordering the user sees for
> printed errors? If so, it might make sense to point that out in the
> commit message.
>

I didn't consider that, it will be different since we already output to
the user before the transaction is prepared/committed.

Will add.

>> @@ -341,12 +361,19 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
>>  	if (*next != line_termination)
>>  		die("symref-update %s: extra input: %s", refname, next);
>>
>> -	if (ref_transaction_update(transaction, refname, NULL,
>> -				   have_old_oid ? &old_oid : NULL,
>> -				   new_target,
>> -				   have_old_oid ? NULL : old_target,
>> -				   update_flags | create_reflog_flag,
>> -				   msg, &err))
>> +	tx_err = ref_transaction_update(transaction, refname, NULL,
>> +					have_old_oid ? &old_oid : NULL,
>> +					new_target,
>> +					have_old_oid ? NULL : old_target,
>> +					update_flags | create_reflog_flag,
>> +					msg, &err);
>> +
>> +	if (tx_err && tx_err != REF_TRANSACTION_ERROR_GENERIC &&
>> +	    opts->allow_update_failures)
>> +		print_rejected_refs(refname, have_old_oid ? &old_oid : NULL,
>> +				    NULL, have_old_oid ? NULL : old_target,
>> +				    new_target, tx_err, err.buf, NULL);
>> +	else if (tx_err)
>>  		die("%s", err.buf);
>>
>>  	update_flags = default_flags;
>
> Same here, curly braces might help readability.
>

Will do.

>> @@ -644,6 +680,10 @@ static void update_refs_stdin(unsigned int flags)
>>  	struct ref_transaction *transaction;
>>  	int i, j;
>>
>> +	struct command_options opts = {
>> +		.allow_update_failures = flags & REF_TRANSACTION_ALLOW_FAILURE,
>> +	};
>> +
>>  	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
>>  						  flags, &err);
>>  	if (!transaction)
>
> Suggestion, please feel free to ignore: we could also pass the flags
> directly instead.
>
> Patrick

Yeah we could, I deliberately avoided it to make the easily extensible
in the future. If you feel strongly, happy to make the change.

--00000000000087a2bd06500d2153
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 471fa9177c4726e2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ubzEzQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlpuQy93TlMyVFJIVGx6VGR0ZFpVWDgrL1Z0SlNlcgoyVTZjOHo2a3Ry
dS8xVjVKTmNSZWxBNmZtbTh5R0hKbUhoNGI2aVU4eStESzFMbitxTytERldHc3U3NTQ4bENHCmZs
d1l1U0xuaCtaeVNjcTAySHlvUDhuZ1VaWlBkbnBFOVp2R29rMitZdldtZVM5c2dmblFHUE1XSjB4
SHg0NXUKWlM5NDV5ek53Sy9vTTNUR2pkZG5Jd0JFNzJkQStML0FwK3MxcFNXQ05oUndzdmx1Ykk1
Q2hsT3k4WEVxVHc4VgpqUkd0QmZXQi9Kd2c4cUpFcTFraXdOYU11MUVYZzN4MERFYTlIYmZURjk1
dHlZdkhhdTF1YWhUYjVsMGVaOTBnCjBFNGJ5NjVzYjFGZFh4TGtXN3l3a3V0cUhzVU9qMWRLaFBi
cUJTamJZM1h3cW1zdm1GbzF1L1BMQzhQUEc1ZlkKc1lWaS9qYjB3ZmFTWXJPQ3puSjJlaFJaQmk1
d21qcFN2ZlZGMUE1TXh3cFUrSFpaU3J0N1EzTkUzOWQ5Qy9GSAovQUp3RU56MitOZG03RVdFbUpW
R3BKclRZa3pEMlVmQWZ4RWIzR2dFS0pwU1locVhTci8zVDR2WGE3Q1Z6U3dKCkFROUtCRS9lYUF6
N3cvQi9idlUzN201OUFGaFhIYWRoYUtZNzVLUT0KPTJjWXMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000087a2bd06500d2153--
