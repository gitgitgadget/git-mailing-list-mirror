Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E12989B5
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768471339; cv=none; b=J4omkx84XD7X6hDnj3iSjnTy00bKcGQN+clqsxrMLoNdfy1obW8guRvFgsSU+Nrt+RCsjyubI49X8Spt28n0FIELW6wtLScdiKnZIctnRyN36ZTG7Uj1grGRiwaG+SRIh9lgsOk4PYvQ7cRiry0HQF6NaIGyvj4ciSGLTlPEMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768471339; c=relaxed/simple;
	bh=xyRj8TQGkWa2ZfRSPIK0HkDFpYW7GYtvhgKWOpYEU3o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFUuyf4ES6yJPSvel6JRZd2CNJJDgqIgBkKc3X2RsWT4c9JfTVRKcf+4fGERcEDxPuJpqz2kJw2gtJPJ00midaZN9DjWlmegajpWLYiRdS5Fp7Tfa5S6DfX77T3h+uHIi9AraeVqzkW+1GjUzO+5Ps4mSoLOmNFHKilNldsVxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2xIb6eP; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2xIb6eP"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93f5910b06cso448706241.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 02:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768471337; x=1769076137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYk6SDTJpbRU/o7w1AHDDcnPd41tvKBFKzeRt9QIubw=;
        b=j2xIb6ePP4ur0FVuSusuZ2OANNvGnzan9XNkKGAxcaTEYapyZDC7896CWW+TiGwUDq
         XrAvZpFtVP/19LD7yMTNc3Benxg8zydJ4H4KGsZAm7Lo7GT5S2KJVYe0gYcQMVp/5+N8
         4Vkq31uWsiM+3RDU9vn5I6s7moLr6wj8hj2+rKo+nbAWsJ0+LTZovgGfUADGHtB6TWiE
         H+KBEHxUGhFCrCwlxFvaKlTS05c30oVW6VVg71T+VQ6IswsKBxw7bnnhkMT5py+Sxoab
         XvrLyQUqaXwdm6GbsNIEuWybKQRpfZzEo+W1sJXqJOGU6NjmQTIngZoP4fUwGfppfjSu
         wVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768471337; x=1769076137;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYk6SDTJpbRU/o7w1AHDDcnPd41tvKBFKzeRt9QIubw=;
        b=GSZVD0HYCVmdK/NrCOm9k5Z9t+omKAd/gCQd+0r6xyjmg1HDnyETRhurdpQ1ZkiIqr
         fAWdDY8sdeUkpHvTx9KpAvUxCgYPdLaTO0MkM0t4Ye+nDpdzi7VNueeB4JSXHXjpHuay
         b1Bc5qrxavj9jOsurIfPT76ffxAzggIXW/EoXUYazKOp9OmhPXj0qzg97aF4qieRddN8
         75bRUrRdHkf0HHtYP9vLn34yzDqM7nFm1wW512I6dqQXhA286A6hP8z/OvfMuKFQZpg9
         VXizFUiRDE+zdMdrN01fejOOJm9oxO4sy4NT+YdmQbATQLb3iEVuwAwPoiCBqSXkpckn
         rd3g==
X-Gm-Message-State: AOJu0YwtTUZds3vyDP8F95mJUxJCKb6ce6tlEvkHrjopaU1kNtkxt22q
	UKv8228YRD5ceXy4NGomRB4lXsuYBrsROZeejBOmz9t2WJJns5wa2kcAoGJY7z3kAVJ8Z9nCizI
	oGBdNKOHkxwG9jcbw4XH5XKQwVbA/eTI=
X-Gm-Gg: AY/fxX4k4hN25J5nH7d9CeK+NOGqiN31BebBd8f8CfyThsqY8AMEoXDhVALzab5/sOc
	+3ETqVXsg0r5si4UI41XAJsBcjofQwjbtGGF6fuJnBWAEo5sMRQ9t2HSp/A0tC9COVeiclJQvyo
	kq7V7S3OSGw5l5oD5BkUgbo3mMOV1R1ttgZQo4ur7azY6cnDJu4iYx5UOkEwmkJjaqmJnJAYMLC
	yUxjPT8O/IiDG6QDCsh3YW/S+wgBVAvHTRYxl/mH3qKoQ5PCk6Zrn9JHOyTpNJdivfF9g==
X-Received: by 2002:a05:6102:3f09:b0:5ea:666f:2bc4 with SMTP id
 ada2fe7eead31-5f1923f7475mr1292678137.4.1768471336781; Thu, 15 Jan 2026
 02:02:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 02:02:15 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 02:02:15 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260114174338.GE885771@coredump.intra.peff.net>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-2-f5f8b173c501@gmail.com>
 <20260114174338.GE885771@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 02:02:15 -0800
X-Gm-Features: AZwV_QiYznZdAMpjoQecVF_8wIzeM7DmeGHD7ZQ0QUuRC54Z-wCi_hhsMEUPLZE
Message-ID: <CAOLa=ZSyfkb8oe=ZtkOcsGo9Dk44GZSFiaye3Vw2kDs_XqS8=Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] refs: attach rejection details to updates
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, newren@gmail.com
Content-Type: multipart/mixed; boundary="000000000000d31dcf06486a513d"

--000000000000d31dcf06486a513d
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Wed, Jan 14, 2026 at 04:40:43PM +0100, Karthik Nayak wrote:
>
>> @@ -1262,6 +1264,8 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
>>  			   transaction->updates[update_idx]->refname, 0);
>>
>>  	transaction->updates[update_idx]->rejection_err = err;
>> +	if (details)
>> +		transaction->updates[update_idx]->rejection_details = xstrdup(details);
>
> I guess this could use xstrdup_or_null(), but probably doesn't matter
> much either way. I do wonder if anybody actually passes a NULL value. I
> think in my hacky patch there were some spots that did, but here you're
> always setting the "err" buf (which is good, as we'll always have
> details then).

That's correct, I did ensure that there were no NULLs passed through, we
could definitely drop the check. But I was being defensive. I think
`xstrdup_or_null()` is the better option here.

>> @@ -2657,30 +2661,35 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>>  			if (!initial_transaction &&
>>  			    (strset_contains(&conflicting_dirnames, dirname.buf) ||
>>  			     !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
>> -						       &type, &ignore_errno))) {
>> +						&type, &ignore_errno))) {
>> +
>> +				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
>> +					    dirname.buf, refname);
>> +
>>  				if (transaction && ref_transaction_maybe_set_rejected(
>>  					    transaction, *update_idx,
>> -					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
>> +					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err->buf)) {
>>  					strset_remove(&dirnames, dirname.buf);
>>  					strset_add(&conflicting_dirnames, dirname.buf);
>> -					continue;
>> +					strbuf_reset(err);
>> +					goto next;
>>  				}
>>
>> -				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
>> -					    dirname.buf, refname);
>>  				goto cleanup;
>>  			}
>
> OK, so this is a case where we re-ordered the "err" handling so that
> it's available for the non-atomic case. Makes sense. We end up
> formatting into err, then copying it via xstrdup(), and then resetting
> the buffer, which is an extra copy. I think you could probably get
> around that by passing in the strbuf to set_rejected() and using
> strbuf_detach() to pull the value out. It's probably not worth worrying
> about optimizing out the copy for an error path like this, but I wonder
> if it would be more ergonomic (the caller does not have to remember to
> strbuf_reset() then).

That's a great idea, let me do that instead.

>
> I notice that you "goto next" now instead of "continue". So I was
> curious what happens in "next" now, but...
>
>> +next:;
>>  	}
>
> ...the answer is nothing. ;) I guess maybe you were going to
> strbuf_reset() down here at one point? If the 'next' label remains
> empty, I think I'd prefer to keep these as 'continue'. But maybe you use
> it later in the series. I'll read on.
>

I should have explained this, there are two loops here in play. An outer
loop going through refnames to check availability for. An inner loop to
breakdown the path of each refname to check for path conflicts.

With continue, we'd skip the inner loop, but would still perform other
checks for the refname, this can lead to error details being overridden.
So while we could replace s/goto next/continue for the code in the outer
loop, it would still be needed for the inner loop.

>> [...]
>
> The rest of the conversions all looked sensible to me. And you fixed my
> memory leak, which is good. ;)
>
> -Peff

--000000000000d31dcf06486a513d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a86266ae02bc0bdc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sb3V5WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVloQy80Z1ZJQ3F0aVd6TXBIWENsZCtML1lPM3NGRApBRFFBbE1abU5a
WTF4Z3BrdlVWcFIwUU9ZNUxVZlJRQzlOTzFQQW5lR3V5OVkyWnZOcG5WalJGUnJaNDdWR0gwCjli
eTl4OWpHN0UwM0JyeldRME9NMjBpd1hTRnczTXh1RGErdzZQNGhGWnBqUWFVMi9wNkVWWTloNmpG
RGdOYXIKYkMrVGpIMWpvUlNZM3FrVVgrak5xTjRJdEVDcFpCWVFrdG05TUtPM0ttMnc5Tzh3NWYr
cWc1dk03aTNaVTB0dApuaWRLeHI3Uy9DMmY0Ym1QM3UwNFpTd1RtdnM5MVFDVU5HQzVMNS9pVjZ2
NkZFYWJFTWZ6TzFYKytTVlBJc1k4CjZ6c09RUGdhb1h1Q1NmQmJ2UlBCYlJBNGZGeTZ4dDljaklS
Z3gwRkRNL0l4bUlPQmlDM1c4aTlNTk9vdnBaMjgKZUtvNTJVNklGZTNyaWFZaEpkcnMrNjd5QWMw
b2IwdnNvZk1iN3lNRExXeFJWbXpiMmhtLytaVmROcWp2NmZ5bAp0VkFydzdtWGhVVkZKVTlSajBK
djBCUzFpYm84STNRMVBmeXNRTUJ4ZDR0eWdhNktIYTUyQzRjMGpwUWVqNFBTCkFkQzZYTjdHN2gr
VHlRaFdTYXF4bG5VUFBjRVp3RXQ1OWxyUDJEYz0KPXp5Qk4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d31dcf06486a513d--
