Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E141613AD08
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550183; cv=none; b=JINJ73lp7KRI91Vgod8XY8S4AXpC3kO+ZWT/+nDJ4FMN1x1N9i7vu0m89baNCzsDF/N6t+6d63SC+Elwk7NXhbBjPNnLmKY0VQdW0FnztRO9z9bCPVIHDRNlUH8l+opuX3ZOXVEauQDeHFCeybLHXu0esdFAWgOR+AX6WLF3UMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550183; c=relaxed/simple;
	bh=TQGubufMW0vYBcIOVxsFuz3YM4QIeLw2kx31l+5t7ns=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJNio2RjTxRVnIMTNMnMBarbS9foB2+0wE/WiUvK+dcmwZ3tTd5cJDwYT4Yl6CHv3ALYNe+ehL13EgIqPZ4zVbHRb8P6iEmhNjf5kJmNV0An1rH6Orfh/rMOWumKSmK3XgGSWAii0lih1f4p8kXG7Veslos27o2Kq8TEE40cC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1WAIxc+; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1WAIxc+"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23935d89261so722518fac.1
        for <git@vger.kernel.org>; Fri, 19 Apr 2024 11:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713550181; x=1714154981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TpDMgU7GJn2CpKb4M3rapGUD6ILTQ5bdvzWf8W6hnCI=;
        b=l1WAIxc+WlJRqtbLT/zvF1plT6aJTGbA/MZsWPXxp1kRv1TZhVOrJ2Zp/IgqS+M2y6
         OAh4ZMrOa1dBjopJGufD1Pc2CzPGVSiGYmL5f78gnD4tjc4YTCYsMCyvFvwvdbT+l1mr
         zPXJyjKqnD7BRgRaRt1YcjV3Knxe88sSY4gmbnJHAO0TItm+w4ZA90XVWC4FJusA8/Ol
         rkavpA8NltJ/OviUADcit8a79x4dYWMqsoAMLF9wWv+tOw8Tmp7YpuB7tb7WkKOXM7X6
         cKRo8LBAw6n6u1D/rLEesuItHM3BBuktjFuB0MwXLaW0AhPmw/hytcC2esYCotHbc3R2
         gY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550181; x=1714154981;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpDMgU7GJn2CpKb4M3rapGUD6ILTQ5bdvzWf8W6hnCI=;
        b=nH65lKi+1fxVinYYp+JrzGmufd4w3yo8ZHEdN/ETBcMziHdt7ZOAuUCNAL4Qn4NYOr
         vNJAXNamdiHLL/x9EzBHyBLRYMXMgFI0seIHcfBv773AfFxVOKmr78cMRlh7gQR5sn74
         VLPDOLa5m6mg+/z9te3VsUx6aEk1RS/UuGMvZm4ArhZDxEX6y1UVSbQxDc/otWu9+wRa
         pKlZ5mYIKq+dzcpe4p2lqiirOjbd85FzwzD0leBVZYQmZMLdQFENyoIKoBEi4QiWZ4qk
         oCc8PGJBeZs+UwSiXLk9gYb4u+wPGM8BtDjhIT9s9/INolbvylTjKJO8aYcDrVKL3Z3M
         liaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnLA7OlDAJ2pJGPVn5rSFMMp9w/Wpz1FfwwA6Iy6dCEdLAm7eSE3VosT/i0moLMhOLKkem43xX/docm70a1dylLPU2
X-Gm-Message-State: AOJu0YyINoOAdJpKpWdM0zyJCW0BOUjuA0qiq6WwYsVyOAKwzkZDQB23
	crhbvjX52Pl/tf+WhB0K+hMlHm0KNdYJvQnQ4Ijkml8jG16bqUEgutbg0xQ3kENrbPL4jk8YZjF
	0vezDXQDgYOJeF8/x+lHkF6XO0RA=
X-Google-Smtp-Source: AGHT+IE3WyFVy5EOdZmRBMypIYq3SdVKdDyWimRI/zlJWAuQynx1VRE9TJ38uHYOEFEZ/GtGMCHuqRJK43wFoKEdKdc=
X-Received: by 2002:a05:6870:2012:b0:233:ac4c:43a5 with SMTP id
 o18-20020a056870201200b00233ac4c43a5mr3415623oab.22.1713550180847; Fri, 19
 Apr 2024 11:09:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Apr 2024 13:09:39 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZiI8AfkJL4O3K7Xk@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-2-knayak@gitlab.com> <ZiI8AfkJL4O3K7Xk@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Apr 2024 13:09:39 -0500
Message-ID: <CAOLa=ZT8=1qDbsHhk2gnVfgcGOLv11+WgvyB_DtuB7=hPL+jyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] refs: accept symref values in `ref_transaction[_add]_update`
To: Patrick Steinhardt <ps@pks.im>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000d5a9ec061676fd1f"

--000000000000d5a9ec061676fd1f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Apr 12, 2024 at 11:59:02AM +0200, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The `ref_transaction[_add]_update` functions obtain ref information and
>> flags to create a `ref_update` and add it to the transaction at hand.
>>
>> To extend symref support in transactions, we need to also accept the
>> old and new ref values and process it. In this commit, let's add the
>> required paramaters to the function and modify all call sites.
>>
>> The two paramaters added are `new_ref` and `old_ref`. The `new_ref` is
>
> Would `new_target` and `old_target` be easier to understand? `new_ref`
> and `old_ref` to me sound as if they might also apply to the ref itself,
> for example when doing a rename.
>

I guess that makes sense, I'll add it.

> [snip]
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index 56641aa57a..4c5fe02687 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -124,6 +124,19 @@ struct ref_update {
>>  	 */
>>  	struct object_id old_oid;
>>
>> +	/*
>> +	 * If (flags & REF_SYMREF_UPDATE), set the reference to this
>> +	 * value (or delete it, if `new_ref` is an empty string).
>> +	 */
>> +	const char *new_ref;
>> +
>> +	/*
>> +	 * If (type & REF_SYMREF_UPDATE), check that the reference
>> +	 * previously had this value (or didn't previously exist,
>> +	 * if `old_ref` is an empty string).
>> +	 */
>> +	const char *old_ref;
>
> I think one important bit of information here would be how to handle the
> update from a plain ref to a symref or vice versa. Would I set both
> `REF_SYMREF_UPDATE` and `REF_HAVE_NEW`/`REF_HAVE_OLD`?

I'll now remove `REF_SYMREF_UPDATE` and add documentation around the
usage on `new_target` and `old_target`, where if either of them are set,
they take precedence over `old_oid` and `new_oid`. The `new_target` will
ensure that the ref is now a symbolic ref which points to the
`new_target` value. While the `old_target` will treat the ref as a
symbolic ref and check its old value.

`REF_HAVE_NEW`/`REF_HAVE_OLD` should however never be set by users of
ref.c, this is set internally. See REF_TRANSACTION_UPDATE_ALLOWED_FLAGS.

--000000000000d5a9ec061676fd1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 88f22e8d0697321f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZaXMyRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNS9rQy80MHVzRUhxcm5EZ1Ztckovb010TlRpTmJXTwpncUFnVHBYSHhS
bG15Nnd0akUyTmhqSDlkU0ZnYjcwVk80eTVhTUVBRjlXOTJjakllLysyQnlGcEY4L0F0cDlICmJS
VzNrWUFUTGRWL0tsbHZpU0p5ZGVReUlTb29lbnJ4d1orK2VzUlZ5QTJQR29iUm9TWVpTcTlLOGVj
dXYyOS8KZlJIVHZLSlhNTjlTRXJWaUZXVGZldTE4MFlvZGZnc0dvVXBDL25BWWI0bVRKbXBwczE1
Ly8vWjAzQjgwOVdSMgpTWFVvZU4yc1hsV3VzWXljOTZrdDY1Vk1SQXNjRWxmaTJzMzNUazc1NTR1
ZE44dFJlSXZ3czRwcFg2eXJZRVk5CkNrSGRvd3R6RHVJNjFlZzYrVEZ4Zy8vUWVBdWpyeFZmWUpW
SFRKNVM5ZmI1MjdjbzRYUWVpdVNBKzBtZlliUXYKY2hhbXBKc0FhQnJiNnNqYVVCeUZxN3crSnBv
Q3NFUWl2VnFsYjBUbmJ4L2tGR0YxTnMwS0wwYk1zT2pTcHBwTgoxY3lBSFFNbFlCa2YzeVJ0MVB2
ckxmQkx5YlFaU2RtRTZ2WFZwcUwwV2gySjhXdGs2UU12bTFsUkhkdlF4eXF1CkpCU3Jub3NBL2RO
dWJLRVNSNmF6YmRmMUFVMXgyMmNxS1lXdHc1ST0KPVpmckYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d5a9ec061676fd1f--
