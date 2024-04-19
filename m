Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389178276
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522535; cv=none; b=gqP1OttJOlhW3RLr3BXMwCcp4aBZI1QssUv5YlgUGhjOFUziyi6bRco8APvPzL1natd6KBuLbTZagECzkqzhtWgbkPLcYFVnUpjg8h6ARRJS9gOITb1ENWn0ukv64jHd6r12ttzFvMay0nZbXWRE7yswd0nseSVopiAlnyFixrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522535; c=relaxed/simple;
	bh=Tb+PjDagMav5XIihhAHogLp5hNGEPt3xpwumlDRuCFc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCjn4d2vWc4e1XB3pfOMLGTMv0lqAE/I2WoNeTfxtxDCaRKcW/rPNx8+rPFQaMljRs5Af/5+5LBX/GCO9UVS+rwYY+DwqDf91ptIMemr2lqQh0FDS03coGYO0hqZUpPJF1uBL05C2zK0WUdXDseDQBdu3DPbl4auYRfEAFOr3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpONV5eM; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpONV5eM"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ea1a55b0c0so893419a34.3
        for <git@vger.kernel.org>; Fri, 19 Apr 2024 03:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713522533; x=1714127333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5IFiO8Hanj1TWbXLg6foWycm9XP1o7G/ZeQhuECsJ3U=;
        b=PpONV5eMz1OykoMWEe/fj+68FJdBSlY+Ph8rWvjSkAfXcGm5cdiwbASWPRqcOGKBa2
         AThvZ0LdAEWf/sVco7DKEjZsxyzZWZhLrPABhU0ILCfzwxyaPrCRmDeVbpbn4UxIIddM
         dm/3isNWELyFuO2i2KR/Z/nE7d/cKv+KwDf0um7YDWhbIwPXGHz6QK6H2Vla1pkd+KMg
         NWr1D3RJRBIJpuaDE4NXDXOingY/ZglgYaTNwRYpFuEwLqrcoQwHFeiQnSjrHa5aHh+5
         LESmPBzfEN3gQ+blKhoEcYfraTQ7lcVOqL6a8ZL0FDC0TMt38l8qBqGieDgapc868irn
         Y+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713522533; x=1714127333;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IFiO8Hanj1TWbXLg6foWycm9XP1o7G/ZeQhuECsJ3U=;
        b=XNx8A7Erq2MGSHHh/4X1mz/qHcokcHELJ69hRdT3OvkfDNzyC+rAvjd1TY6GFJ1kUU
         jWxk5oK/nhHOSnzcGbMoy9CciP6U6GXEi5o5lw6hC1dZvReRAXxgTp4oMf+qPPlu5+PH
         PefEaMVhQdNbpEDRoNGOaxwxv6Z6Ov8HFsB0+V2Rn3q1AMHmGvI1kfzUOjy9e0udk3la
         tzCF+mEb/N/aKhCMLt6QTCqFIMnXeumK0kFngdqSyMQVkVk12i0LE2JOLZlndG3xwii6
         R0bcPmTwalnVIq2K4TROMDbKpFH/dvUxbfagxdIJ+tCXXZ4HMY7swBaz5iaC0hjYb8wo
         t+NA==
X-Forwarded-Encrypted: i=1; AJvYcCXlfxOsR+QwiCL08tLztqb4NiBLu8mdJVxOwDBUU4suEr6nCgatbYOVvnjJFkTVL9+kExA+ON3Xoo9BfM2qQ492XZMe
X-Gm-Message-State: AOJu0YyiSJPMK2udDY+NMuXf8bF//X/vhVTGkHbYOaBjxhNHPyVRhcUb
	R15nbm55smMQPF962KDGmFt9yHQAuzq1/VuV3gRl6Uj6INPxbexbIhgu7cpMsNOATc8CIFfPVTn
	s0sXu+veBnF8mn0ccyZT0NVPZwmc=
X-Google-Smtp-Source: AGHT+IG8SecOjw5j+5mA/uIjc4/ZAec6+sSGNbhV1jtb9Qp66PwUyCBr9dgs+H2/DQxl3UlZbgJeYcEPG9LJJFgPpSY=
X-Received: by 2002:a05:6870:230d:b0:22e:b3c6:96cf with SMTP id
 w13-20020a056870230d00b0022eb3c696cfmr1893575oao.49.1713522533016; Fri, 19
 Apr 2024 03:28:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Apr 2024 03:28:51 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD2s5GZBbZ_oKk6hFCQ+jtjRjx1QgRvLz+1hrBfkWKVCbw@mail.gmail.com>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-2-knayak@gitlab.com> <CAP8UFD2s5GZBbZ_oKk6hFCQ+jtjRjx1QgRvLz+1hrBfkWKVCbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Apr 2024 03:28:51 -0700
Message-ID: <CAOLa=ZQfk+uMNjiSSB9o2SiFT+Cjm10W2bbCBy2nCQ-zwc5nHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] refs: accept symref values in `ref_transaction[_add]_update`
To: Christian Couder <christian.couder@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000e545ff0616708dd4"

--000000000000e545ff0616708dd4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Apr 12, 2024 at 11:59=E2=80=AFAM Karthik Nayak <karthik.188@gmail=
.com> wrote:
>>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The `ref_transaction[_add]_update` functions obtain ref information and
>> flags to create a `ref_update` and add it to the transaction at hand.
>>
>> To extend symref support in transactions, we need to also accept the
>> old and new ref values and process it. In this commit, let's add the
>> required paramaters to the function and modify all call sites.
>
> s/paramaters/parameters/
>
>> The two paramaters added are `new_ref` and `old_ref`. The `new_ref` is
>
> s/paramaters/parameters/
>

Thanks, will fix both.

>> used to denote what the reference should point to when the transaction
>> is applied. Some functions allow this parameter to be NULL, meaning that
>> the reference is not changed, or `""`, meaning that the reference should
>> be deleted.
>
>> The `old_ref` denotes the value of that the reference must have before
>
> s/the value of that the reference/the value the reference/
>

Will change.

>> the update. Some functions allow this parameter to be NULL, meaning that
>> the old value of the reference is not checked, or `""`, meaning that the
>> reference must not exist before the update. A copy of this value is made
>> in the transaction.
>>
>> The handling logic of these parameters will be added in consequent
>> commits as we implement symref-{create, update, delete, verify}.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
>> diff --git a/refs.h b/refs.h
>> index d278775e08..645fe9fdb8 100644
>> --- a/refs.h
>> +++ b/refs.h
>
> There is the following big comment in this file:
>
> /*
>  * Reference transaction updates
>  *
>  * The following four functions add a reference check or update to a
>  * ref_transaction.  They have some common similar parameters:
>  *
>  *     transaction -- a pointer to an open ref_transaction, obtained
>  *         from ref_transaction_begin().
>  *
>  *     refname -- the name of the reference to be affected.
>  *
>  *     new_oid -- the object ID that should be set to be the new value
>  *         of the reference. Some functions allow this parameter to be
>  *         NULL, meaning that the reference is not changed, or
>  *         null_oid, meaning that the reference should be deleted. A
>  *         copy of this value is made in the transaction.
>  *
>  *     old_oid -- the object ID that the reference must have before
>  *         the update. Some functions allow this parameter to be NULL,
>  *         meaning that the old value of the reference is not checked,
>  *         or null_oid, meaning that the reference must not exist
>  *         before the update. A copy of this value is made in the
>  *         transaction.
>  *
>  *     flags -- flags affecting the update, passed to
>  *         update_ref_lock(). Possible flags: REF_NO_DEREF,
>  *         REF_FORCE_CREATE_REFLOG. See those constants for more
>  *         information.
>  *
>  *     msg -- a message describing the change (for the reflog).
>  *
>  *     err -- a strbuf for receiving a description of any error that
>  *         might have occurred.
>  *
>  * The functions make internal copies of refname and msg, so the
>  * caller retains ownership of these parameters.
>  *
>  * The functions return 0 on success and non-zero on failure. A
>  * failure means that the transaction as a whole has failed and needs
>  * to be rolled back.
>  */
>
> I would expect the patch to update this comment.
>

Since this patch doesn't use this value, I think its best to modify
this in each patch as we start using it, I'll do that.

>> @@ -722,6 +728,7 @@ int ref_transaction_update(struct ref_transaction *t=
ransaction,
>>                            const char *refname,
>>                            const struct object_id *new_oid,
>>                            const struct object_id *old_oid,
>> +                          const char *new_ref, const char *old_ref,
>>                            unsigned int flags, const char *msg,
>>                            struct strbuf *err);
>
> The patch might also want to update the comment just above the
> ref_transaction_update() declaration as it is changing what the
> function can (or will be able to) do.
>

Agreed, same as above, will modify in each patch. Also will add a
comment in the commit.

>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index 56641aa57a..4c5fe02687 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -124,6 +124,19 @@ struct ref_update {
>>          */
>>         struct object_id old_oid;
>>
>> +       /*
>> +        * If (flags & REF_SYMREF_UPDATE), set the reference to this
>> +        * value (or delete it, if `new_ref` is an empty string).
>
> What if this value is NULL?
>
>> +        */
>> +       const char *new_ref;
>> +
>> +       /*
>> +        * If (type & REF_SYMREF_UPDATE), check that the reference
>> +        * previously had this value (or didn't previously exist,
>> +        * if `old_ref` is an empty string).
>
> What if this value is NULL?
>

Well we ignore NULL values, but I see that the documentation is lacking,
will update.

--000000000000e545ff0616708dd4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e609be86ce0ee5a7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZaVIyRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHVvQy85UFZrSk9pVDhHckVKalJzUCtadUw4eWNpeQpTSEd2TXZWbXlB
RTJra0JhZE1uV1hLbHQ5blUzWVY5R2VzRU5yeWNHUG13R0JNakFYY3hYaWwrQnNSZUd5SnU1Cjlx
Mk4vMm83REJQeTJyRDBEdHFXOHlqSEZreUF6TWtRUllDSTVIQmJVNmVac1hLWEZJVHMrK0xqYXVP
R09aeUoKRmRNbVVoRWR6a3hKbWpKZEhPR2h1U1pjOVlkc0VuWkY5bzN0YnN0blRKQ0R4bG5uano4
dDNWVVh0Rnc5SkFZcQpGd3FMWURpYzcydnhpYU5BckVDUlNDM1QxWHh3MzBYWUtleWNvVFNPQ1Q1
OFJxODRjOGdkUkdlRVhjeEU2d3lmCkd5aS80V3Qwd1lXS1ZwZnlEUU1sRFRrSWxXem5DNXd3TFNZ
TXM0WmhUbTFWaW9RUGVQbm1JckFtNW8rZUVTLy8KSXBmUTZGVFUwVStsQjFXbFduSXJpWVpZYUVH
YjQ4VUJrODFTczZONFNkQkFVM1NuSzUvZ0QvSzVKMk9VejlFRgpOTCszVXVuSUZBRXA3OGx5VFI0
bjJaOGhMdmlXQTdQSHFSblJSVzZFeTJhQkh4bjV5VDd1NDZ6YkhuUERoK0JzCmlWQis3VUx4MHUr
R1Nyb3hPOW1JalN2b0N4ZlZJeU43cnN0YTVtND0KPUFhSVAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e545ff0616708dd4--
