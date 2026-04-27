Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98253A0E85
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279657; cv=pass; b=KlAMSiObfLHXkoetCcFyBey6mNFJ+fR0T/2noeVVxMnRG8kHMZwjL+IKrlxXSNnkWH4f0GTGIGp621aKKer4QFq68n3uYBbmQ8Rouz+WrC6tn1V8M0NMCxPaSokyUg5LV85N4D/iyg7sDtSxGEfU7mKnd+gICu1+r7sUTF9qhvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279657; c=relaxed/simple;
	bh=cylUstsfRhgoO0ydAAzUk8i0APE2FLtimD92f2dtXv4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfzgBpZuzD3QzqsTngit7dcbsAIx1Ev7DTxOcad+g9kMMTm3BFNfhNfdGtHVRUDrAkzKZSKc3H7y113c+1wkCoyb9nykqWL1/dn6zFwe1TSaEvFXVXLsS9PoA98g3VDRHroItXY85GRvAYqqxUpyYT3JvVPikcdS4ZPr4s/8OCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi/jnrkK; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi/jnrkK"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56739adfa1aso6798006e0c.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 01:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777279655; cv=none;
        d=google.com; s=arc-20240605;
        b=JWZwtMffku0YqwRp6PW7j5SmH0uKPJUfVvVoD1gCtoRpHg06tbIoPcSBel1gZUICVQ
         nt8nVEQgc9ynH8t4misB3N+Rd70NBJHbSiwY+tOjCQicDNKv40cy3+ArEl5zz27TRBpO
         aPnKcagxdQPjG5AQuBiPdJM4sc2/bwTOOWfIQImTv7zNPVpNjyJ7jfOknoI+iiLLOw+p
         YkLTjqO2co6Qv/GseLWV/6J4QnK4MfiEkUkQ9hGVBprMMNVrVKdaJs8uerzAVuGbSfpw
         TQviXEpuIHO5ln90fCz9bDKnK+ukzAe3tXmjcR9nwlKvXrztd7V4tbJo8dC7cdwTmn0T
         bkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=o0VQ149AAWQ0oH8spXrlTIK3j+tHZkQX59ZQygcdBZs=;
        fh=DVFb8m6ORuobNbEcTTblwArPF8US584fkPgJCb6mh6A=;
        b=DnNn3IIB/gq8izRdxPVrDdUhWJG/qWaNbftZt2ax2Z2j+5iHfTCyYHapR7fO9kqCWE
         fcBrOjSQOX7qHxn6EgLRHFNk5T8UlNVGBk1CUdmLyxXi81sPdPFOMzuv0L6w+53m1xzu
         bB0LZytrIbf/9VvrUhjg2siH8gxDds7PZqwZOahE90Z0IIGBt+VtotjRopHOrerm6fns
         USGBElJ/NCyiges2/AisnDz2AdGqpYSEiJG5hXJ0cNwgdwjfGoCMGJ1YO2+775vODnHk
         DcCxQ+BrmoWM7RLQn9ASNaKcTUxv8cjolciuN0/EK+JzUDalo0upad3QiNsGvzVz4T9H
         sLoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777279655; x=1777884455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0VQ149AAWQ0oH8spXrlTIK3j+tHZkQX59ZQygcdBZs=;
        b=Bi/jnrkKRCa/wbz6HNgMpdht9GfPVbL6iN2qElm6H8krWuu29n+badS9N25k5v1Kwb
         TvZz8PpUArqLU4LrtRm6PxGYcw0r8AuAkJmyB8+8CBPt743xJ5lUu3U6bmpPyFmAaWsj
         N+3OqeWD0NUbfxhLa1v0LcHaygcaXiUIf68THCYAF6WnpMc02Jz96Y6dhqURYd+7XDnC
         rAL2+hc0ulFBNiu3B5RG+UDdne1xK3FJCizByrXkUzBzgMlCuhV+IMYSBt6dHD2PF9Of
         jtkpGQ89X8vE+PNNCUuZBxzG1brXC7xpnKhl8PNxSBFHBvl0MK45L+oWhqExGZiyYnVT
         NX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777279655; x=1777884455;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0VQ149AAWQ0oH8spXrlTIK3j+tHZkQX59ZQygcdBZs=;
        b=GBPSFyINX5V3YF8nTdX2I2b9g8ziyN3hwKo/x/SJMiQAaHKZ1ohusQyNdCpA7g0GZ4
         xk1ysAh0eOMNkIj2aBnXTweXit909EuzBnAiVefb9PaQYxxQQjb1yiEifrgJbfCHpL7v
         PafbYTB5kIGny7Xdppkuk2QgZBuSSLqlu9/IhtDzJ3fTqURFKkIl1gb04bfzjYy7yXcb
         veT9e7lHku1lrtkD2pIXrktgprWYzhh3gBYmTq00x7YDDDiTqBJNzIUKgVyZS363v/y6
         +Pnu5lEMkyPHg7IHhP2ZdhU7VqJBpq5lBPwozLHiSV2weX32s1LR0AcachKT+suC6o7d
         HwzA==
X-Forwarded-Encrypted: i=1; AFNElJ+KXwEkotY1YQmMW4HMkzW7D/5kmIhpJFgSygGUci5pSsiLxowb+Nv220HtDW2r8PIu+k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGirTv37OxNqHr9qUufbmtfG7hbw9jwVOgUCPa0gZsYYn3/6C7
	zoQeqIvbvNJxv4oLOgySBT+1PmHHM5rXs7eGPVk9cAJ+0wMT+6Ms+u/pnnNT5cZQAZ0w67Ark+h
	HVwu0LJdBuWshBoBNB/frApR8bRk6P0w=
X-Gm-Gg: AeBDievVJM2SfvB+52SZmsLbTZIOltui25avFE1ClNkXW3MyjTx2wAaX8VSFzcD9zMf
	7s8bwIy0sm/JCuJSmmqeXZkLDizUb5r3K39R1awfoWT8T+h/oVl19UgtipZyPnvwJebbO7pCKw+
	qCI6IAh1vR1QEvuo7xGh/6eYOkLDj05kT3ECv2SRxKSXDhHz7zoG1rMyA9y7puUp/bDT/kyHhiM
	FiEhhoakN4VriiUK38whc1TlJ4f/HwbB56G7txCjatVlvZlFlDLqMOJ41HgkuhKwgMiYBxWHgdN
	oZdIKWK/LChgNfglkx6dWxZU04/krAfPmN36yMybbpGklTt+X/A8/2+nF+9m6cA=
X-Received: by 2002:a05:6122:2204:b0:56d:8ded:796c with SMTP id
 71dfb90a1353d-56fa58583cfmr21177132e0c.4.1777279654709; Mon, 27 Apr 2026
 01:47:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 08:47:33 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 08:47:33 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87340keh6h.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
 <20260423-refs-move-to-generic-layer-v2-6-ae5a4f146d7d@gmail.com> <87340keh6h.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 27 Apr 2026 08:47:33 +0000
X-Gm-Features: AVHnY4I74z44c9zHA_jyd0QvJceHVQTIABrmIRiWk85tvecT_S-EqndnAgEVH9M
Message-ID: <CAOLa=ZShiWmaTrdK+ReoBO-kgsrmB6ykQ7DDrTG2qj8P=tkFwg@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] update-ref: handle rejections while adding updates
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000007c7a3d06506d2a4e"

--0000000000007c7a3d06506d2a4e
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> When using git-update-ref(1) with the '--batch-updates' flag, updates
>> rejected by the reference backend are displayed to the user while other
>> updates are applied. This only applies during the commit phase of the
>> transaction.
>>
>> In the following commits, we'll also extend `ref_transaction_update()`
>> to reject updates before a transaction is prepared/committed. In
>> preparation, modify the code in update-ref to also handle non-generic
>> rejections from `ref_transaction_update()`. This involves propagating
>> information to each of the commands on whether updates are allowed to be
>> rejected, and also checking for rejections and only dying for generic
>> failures.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  builtin/update-ref.c | 100 ++++++++++++++++++++++++++++++++++++---------------
>>  1 file changed, 71 insertions(+), 29 deletions(-)
>>
>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index 5259cc7226..99deaac6db 100644
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -25,6 +25,15 @@ static unsigned int default_flags;
>>  static unsigned create_reflog_flag;
>>  static const char *msg;
>>
>> +struct command_options {
>> +	/*
>> +	 * Individual updates are allowed to fail without causing
>> +	 * update-ref to exit. This is set when using the
>> +	 * '--batch-updates' flag.
>> +	 */
>> +	bool allow_update_failures;
>> +};
>> +
>>  /*
>>   * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
>>   * and append the result to arg.  Return a pointer to the terminator.
>> @@ -268,11 +277,13 @@ static void print_rejected_refs(const char *refname,
>>   */
>>
>>  static void parse_cmd_update(struct ref_transaction *transaction,
>> -			     const char *next, const char *end)
>> +			     const char *next, const char *end,
>> +			     struct command_options *opts)
>>  {
>>  	struct strbuf err = STRBUF_INIT;
>>  	char *refname;
>>  	struct object_id new_oid, old_oid;
>> +	enum ref_transaction_error tx_err;
>>  	int have_old;
>>
>>  	refname = parse_refname(&next);
>> @@ -289,12 +300,20 @@ static void parse_cmd_update(struct ref_transaction *transaction,
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
>> +	    opts->allow_update_failures) {
>> +		print_rejected_refs(refname, have_old ? &old_oid : NULL,
>> +				    &new_oid, NULL, NULL, tx_err, err.buf,
>> +				    NULL);
>> +	} else if (tx_err) {
>>  		die("%s", err.buf);
>
> Why die() only on an ERROR_GENERIC? Is GENERIC the only error that stops
> processing of other refs? Why? Would there be more errors in the future
> that could be added to the pile of "fatal" errors like GENERIC?
>
> I would rather see something that gives a more clear indication this
> current ref is rejected. Maybe have a range in the enum:
>
> enum ref_transaction_error {
> 	/* Default error code */
> 	REF_TRANSACTION_ERROR_GENERIC = -1,
>
>         /* Ref rejected error range start */
> 	REF_TRANSACTION_REF_REJECTED = -100,
>
> 	/* Ref name conflict like A vs A/B */
> 	REF_TRANSACTION_ERROR_NAME_CONFLICT = -101,
> 	/* Ref to be created already exists */
> 	REF_TRANSACTION_ERROR_CREATE_EXISTS = -102,
> 	/* ref expected but doesn't exist */
> 	REF_TRANSACTION_ERROR_NONEXISTENT_REF = -103,
> 	/* Provided old_oid or old_target of reference doesn't match actual */
> 	REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE = -104,
> 	/* Provided new_oid or new_target is invalid */
> 	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -105,
> 	/* Expected ref to be symref, but is a regular ref */
> 	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -106,
> 	/* Cannot create ref due to case-insensitive filesystem */
> 	REF_TRANSACTION_ERROR_CASE_CONFLICT = -107,
> };
>
> statis inline bool ref_rejected(enum ref_transaction_error err)
> {
> 	return err < REF_TRANSACTION_REF_REJECTED;
> }
>
> The thing is, now you have this checking on GENERIC in two places, I'm
> worried one or the other might be forgotten in the future.

But it's the same no? We moved from using the error to using a function
which checks the same error. This function will now be used in two
places and one of them could be forgotten.

Anyways, the GENERIC error is the default error code, this is to state
that this isn't a specific recoverable error type.

>
> Now maybe this is a bit of an overkill, so feel free to reject that
> suggestion. But if you want to keep looking at GENERIC, how do you feel
> about this version:
>
> 	if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
> 		die("%s", err.buf);
>
> 	if (tx_err && opts->allow_update_failures)
> 		print_rejected_refs(refname, have_old ? &old_oid : NULL,
> 				    &new_oid, NULL, NULL, tx_err, err.buf,
> 				    NULL);
>
> And a little line of comment saying why to die() on GENERIC wouldn't
> hurt I think.
>

This is nicer, I can modify to this :)

>> @@ -341,13 +362,21 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
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
>> +	    opts->allow_update_failures) {
>> +		print_rejected_refs(refname, have_old_oid ? &old_oid : NULL,
>> +				    NULL, have_old_oid ? NULL : old_target,
>> +				    new_target, tx_err, err.buf, NULL);
>> +	} else if (tx_err) {
>>  		die("%s", err.buf);
>> +	}
>
> Obviously the same suggestion could be applied here.
>
> --
> Cheers,
> Toon

--0000000000007c7a3d06506d2a4e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7094e8cf0460976b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1udklxTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFlPQy80alQrUk5hVkRwMUx3YzUwcldGaDhWQ05DZApRU0hWM05aVys4
c0ZUTVFnM3FELy9zYlVaaGxrdkRDdkpIajl5dEVqWnRXZHViTkpjNnVlTnJWOWxlTkdzaWNuCmdY
cUkxN3RUcHo2eWk3T2RUYjk5NncxQjc0dER1UlFWZUdSOS9WdkY3M0ViSDhxcEs0eGxpOFFqQkIr
eG1TU3gKYXVoYTV6QnRUanJFekc2WjQ2cG5xcWhkcVR5UCtvOEZTcEk1VURsTXJYREp6T3BIeXhE
REw1TlNaY2ZrYnI2agpwN1FmY01aK1ppUWVISTRxS1I2dEw3elZJZ0dld1ljRlVFSU5GWE05TDVN
MitVNXJCQTVyYWxBNGd6eEpqMnlsCmdJcHpSdUVqMEorUVVNbDYyV0tqMVBzUVE2dU8rMi9PWlBl
SHpMRkR4RUhMT0Y4MHJYOWtHN0JDWDgxZUM4TjEKNS8vOW15Y2pNU3dTT3FQSHdBR1BMZTg1eDVo
djRKaXl5OGJRYmFDd0JhOHI4MU5EZW9md3N5djlUTEFUWXk1NwpmQTU2TVB0QnhTYTJQbVRKNllK
MFV5WVA1K1lHeW43V0daVGV6NEpvTi90YmlsVnQyUDh3N1FvYkljZUViZ0c4CkFIaVJka2duekFW
Mm9WbUlMd2sxTlRFTXVjWHZ1ZVpKZUxDL1dKdz0KPThFcFUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007c7a3d06506d2a4e--
