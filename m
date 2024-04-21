Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD201205E18
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713703812; cv=none; b=t7Z06VD6slnKjHOkpZT0WbswCJTeM0y9ITR4jVHn/35kfugFVHyCa1Z7f4MgQE6Eu6Phq+4u72LDG6HKTm7GWeFPQEUVEO8g0UiVynhBO4jBe52W6cEeCnrz6zQkAYNLEhZOJD0ma+3b0BfyrO5maA8SGDJewKJ6VcmbsiupFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713703812; c=relaxed/simple;
	bh=f3wH91v9d8Up22Fh1CWnMuxv6BCnWUKgZ7Kfzj73hEU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOR86Ct/C6btJ03nsZO5Zuqo/ae2LRHyeN9hQMrEU+AP550EiBfHsZUvB+8jZA5GsXYIZpeDtrg/J0Z4shiDSnQ18Wklh43FJ8HPBTQR3bA7asuH2J2NUX4ccFa0AkI6qJycwFMbtdBPHRssfbHgRsGbx6JfOeMJdKltnSUA9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5KEYpLl; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5KEYpLl"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-238fd648224so1908702fac.2
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713703809; x=1714308609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YLST9sx+wYnk4FFr+lQDOb8dsFcYQc3Wo9JqAtR08Rw=;
        b=T5KEYpLlw04jUvtjzoBGNuAjuLnze9OFQiMUAuDb5dWJEo35/mF2PnOIBiuo7N4/zb
         omC0t50IrjAo6VGRc/5k61LBgOadtONkP6sjDQlqviBz3aMYol9ADgTeDiHUXfrveBbM
         RWjV5TGm81mbUiu7iwGU1tmSELR9cPdx0etU2fVXWX9N1BsHc/aEqAh1dkwFNPa2hnPG
         nnXCKQvghvBziwrf7r/Fpm8+3t8MUjkR3ycmMJMOx/Fw8XQ3wshFK9PMmdPxrKqx66jj
         JJvjLauvd5mbRbKU6LWbPaXJNJLVlwK4NWHYhThSCCnXW5PPfh7QnUqoiNUnmxgm0vnk
         x7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713703809; x=1714308609;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLST9sx+wYnk4FFr+lQDOb8dsFcYQc3Wo9JqAtR08Rw=;
        b=jUnqkuTc1nfX40Tec8zvU7mO/4yxHgAbLqcsvR9fU0PbQeRmRXDBekeZxOgqwjP0S8
         WiaCPOmABMkHuVszbVNmcrAk/0c3MdpiniEmv5ThnFQRDK2/EotbHYQmCEOVIZRyyw6h
         O5XrdgTdim8Qkk/1X/dPu9dDY1qQu7uB6nsbL4P/CZ30s6lXhHEDfGEAI0H21hfHCc2K
         hmWtmqODY7fAvgfZJvABU6fmIFXZSiqLLptKgrcHO2c4UqPFzvi1M6QamQUPI5decJ9A
         a1HzZShXpsG6X0E4NUYbTHi9/KNnP5Jxz7+S3hbwINVSxUhsXIPKC6Q9ggTwv/gMhU5x
         g6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4VHt8XoGBk7FlCSPOyyCMrjYgk+C2EqqZRIBrLzjBEh1w//nrRaohUP9pQiVl99oXVgEzq3+1MCVyAAKAQUj3SLsq
X-Gm-Message-State: AOJu0Yz/lSKNAEm9+Rlak95y5iXlMDjB5Q0OQ80R9Dd7ZKjINYZz3V73
	vdfzlrV/L48NzrxANjJQqYTVmPaJjxcGZrrfsKVFa+3qOx6xw146tL0s+l6tDUIwgHkSFVBZmYr
	8fhOdpolSKAkW1Ns5u2j0NgLzZgU=
X-Google-Smtp-Source: AGHT+IGnB9JPcc8PBaVhIA//fQtRhTmgfj0Ceiw8cqHpZCr8XDHAuXlNHBCd8NARW1TVnZxMNfIk87E48IdPv4D2wZw=
X-Received: by 2002:a05:6870:718b:b0:229:6841:3278 with SMTP id
 d11-20020a056870718b00b0022968413278mr9050271oah.59.1713703808646; Sun, 21
 Apr 2024 05:50:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 21 Apr 2024 08:50:07 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZiI8GaGupNzbLqnE@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-6-knayak@gitlab.com> <ZiI8GaGupNzbLqnE@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Apr 2024 08:50:07 -0400
Message-ID: <CAOLa=ZSvx4bOmJY+P5j3fJTqfjY37teMHQhOYDjTM4oJtnv_qw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] update-ref: add support for symref-create
To: Patrick Steinhardt <ps@pks.im>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000c3e52006169ac214"

--000000000000c3e52006169ac214
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Apr 12, 2024 at 11:59:06AM +0200, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
> [snip]
>> @@ -268,6 +268,39 @@ static void parse_cmd_create(struct ref_transaction *transaction,
>>  	strbuf_release(&err);
>>  }
>>
>> +static void parse_cmd_symref_create(struct ref_transaction *transaction,
>> +				    const char *next, const char *end)
>> +{
>> +	struct strbuf err = STRBUF_INIT;
>> +	char *refname, *new_ref;
>> +
>> +	if (!(update_flags & REF_NO_DEREF))
>> +                die("symref-create: cannot operate with deref mode");
>> +
>> +	refname = parse_refname(&next);
>> +	if (!refname)
>> +		die("symref-create: missing <ref>");
>> +
>> +	new_ref = parse_next_refname(&next);
>> +	if (!new_ref)
>> +		die("symref-create %s: missing <new-ref>", refname);
>> +	if (read_ref(new_ref, NULL))
>> +		die("symref-create %s: invalid <new-ref>", refname);
>
> This restricts the creation of dangling symrefs, right? I think we might
> want to lift this restriction, in which case we can eventually get rid
> of the `create_symref` callback in ref backends completely.
>

Yes it does. I thought it'd be more consistent with what update-ref does
with regular ref updates. We verify that the object exists. Also this
could be an added option 'allow-dangling'.

I'm not sure I understand what you mean 'the `create_symref` callback in
ref backends completely.'.

>> +	if (*next != line_termination)
>> +		die("symref-create %s: extra input: %s", refname, next);
>> +
>> +	if (ref_transaction_create(transaction, refname, NULL, new_ref,
>> +				   update_flags | create_reflog_flag |
>> +				   REF_SYMREF_UPDATE, msg, &err))
>> +		die("%s", err.buf);
>> +
>> +	update_flags = default_flags;
>> +	free(refname);
>> +	free(new_ref);
>> +	strbuf_release(&err);
>> +}
>> +
>>  static void parse_cmd_delete(struct ref_transaction *transaction,
>>  			     const char *next, const char *end)
>>  {
>> @@ -476,6 +509,7 @@ static const struct parse_cmd {
>>  	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
>>  	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
>>  	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
>> +	{ "symref-create", parse_cmd_symref_create, 2, UPDATE_REFS_OPEN },
>>  	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
>>  	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
>>  	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
>> diff --git a/refs.c b/refs.c
>> index 6d98d9652d..e62c0f4aca 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1305,15 +1305,20 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>  int ref_transaction_create(struct ref_transaction *transaction,
>>  			   const char *refname,
>>  			   const struct object_id *new_oid,
>> +			   const char *new_ref,
>>  			   unsigned int flags, const char *msg,
>>  			   struct strbuf *err)
>>  {
>> -	if (!new_oid || is_null_oid(new_oid)) {
>> +	if ((flags & REF_SYMREF_UPDATE) && !new_ref) {
>> +		strbuf_addf(err, "'%s' has a no new ref", refname);
>> +		return 1;
>> +	}
>> +	if (!(flags & REF_SYMREF_UPDATE) && (!new_oid || is_null_oid(new_oid))) {
>>  		strbuf_addf(err, "'%s' has a null OID", refname);
>>  		return 1;
>>  	}
>>  	return ref_transaction_update(transaction, refname, new_oid,
>> -				      null_oid(), NULL, NULL, flags,
>> +				      null_oid(), new_ref, NULL, flags,
>>  				      msg, err);
>>  }
>>
>> diff --git a/refs.h b/refs.h
>> index 60e6a21a31..c01a517e40 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -744,6 +744,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>  int ref_transaction_create(struct ref_transaction *transaction,
>>  			   const char *refname,
>>  			   const struct object_id *new_oid,
>> +			   const char *new_ref,
>>  			   unsigned int flags, const char *msg,
>>  			   struct strbuf *err);
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 7c894ebe65..59d438878a 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2609,6 +2609,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>>  		}
>>  	}
>>
>> +	if (update->flags & REF_SYMREF_UPDATE && update->new_ref) {
>
> Let's add braces around `(updaet->flags & REF_SYMREF_UPDATE)` to make
> this easier to read.
>

This should now be cleaned up as we removed the flag entirely.

>> +		if (create_symref_lock(refs, lock, update->refname, update->new_ref)) {
>> +			ret = TRANSACTION_GENERIC_ERROR;
>> +			goto out;
>> +		}
>> +
>> +		if (close_ref_gently(lock)) {
>> +			strbuf_addf(err, "couldn't close '%s.lock'",
>> +				    update->refname);
>> +			ret = TRANSACTION_GENERIC_ERROR;
>> +			goto out;
>> +		}
>> +
>> +		/*
>> +		 * Once we have created the symref lock, the commit
>> +		 * phase of the transaction only needs to commit the lock.
>> +		 */
>> +		update->flags |= REF_NEEDS_COMMIT;
>> +	}
>> +
>> +
>>  	if ((update->flags & REF_HAVE_NEW) &&
>>  	    !(update->flags & REF_DELETING) &&
>>  	    !(update->flags & REF_LOG_ONLY)) {
>> @@ -2904,6 +2925,14 @@ static int files_transaction_finish(struct ref_store *ref_store,
>>
>>  		if (update->flags & REF_NEEDS_COMMIT ||
>>  		    update->flags & REF_LOG_ONLY) {
>> +			if (update->flags & REF_SYMREF_UPDATE && update->new_ref) {
>
> Here, as well.
>

Same here.

>> +				/* for dangling symrefs we gracefully set the oid to zero */
>> +				if (!refs_resolve_ref_unsafe(&refs->base, update->new_ref,
>> +							     RESOLVE_REF_READING, &update->new_oid, NULL)) {
>> +					update->new_oid = *null_oid();
>> +				}
>
> Can this actually happenn right now? I thought that the `read_ref()`
> further up forbids this case.
>
> Patrick

With update-ref, it won't happen anymore, because as you mentioned, we
use `read_ref()`. I thought it was still worthwhile to have. But I guess
its cleaner to remove this.

--000000000000c3e52006169ac214
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1171a5cd7fbee77c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZbEMzMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmswQy80NHB5YklGaEdxanRhQmd4Y2xpLzBjNktlbQp3RzQwRkRUY0lM
VFdNblVadFY2aVFCS3hKTWpnMXB6QmRxNjBBbGIzMWc5aXhKaFJqcC84YlJRR29yc3Q0TXdPCjVn
citmWUpWUDNGdnRRT3hyNzNWdkRXRGI0cWVhT0pnelFQWmtxRG9aVDRIUTVmQWNvUWZ3bEZXRDc3
VExYUzYKTzIyTm1CMjBsa1RRRlBXZFJLQ0JudVpaOWczUmhSVzZXRUpWS2hLc244b0FRN2NZWmtK
d2xyejRGSk5tZ2hTUQpoTWFwNlhnVDloeFJDQTlQVmw5cHkxeXQvdjMwY1pmU3d5VW12blRZeTlT
dVpTZzBYMVlBRnppYUlLSFl4eVk5Ci9lSkRwaThyakYvMU0rZlhPRVFxQ0tYdWNLRHJtZXpBWVVp
R3FQOEsvZWRPOHFNVGlDdXE0d2xGZldBOXBzc3MKejlZMGlpVkp6RlVEVThVMGlNa3FEMTFhNStF
R3dzNkNZS3N6SDYrVmE1WFdDQUNxR1NZRDl1ZUNIUHBGcjhYagpUaStzUG5XRS9nWktTT3dXMnR0
U1VpOG1lSThpQ0FSY0MwREF0NnVjd0x0VW1hTzRJNG5IWUZLVEVscHFlUGpZCkxtYkJkdzJhQXZT
TUdGZE5LTUtIZlRydWVucnBjQUJqbHJYN1Vyaz0KPXdTMVgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c3e52006169ac214--
