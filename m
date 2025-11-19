Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5432C30A
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542778; cv=none; b=SK5Xv1VjIBhGiFXfsJzxQBiRhtAhl7M/8246kbAfNxAM5DSVql4B1kQTWhiRkhJJyft4eAemRtnluKCPTr6VgIHTZwfWNvw0TJmvtn8oRO2GEaD9dDpM+rtGjkegc31jKCXmPE2D/+DyWeB+HTz236SxJistI31D+y02QuUnH4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542778; c=relaxed/simple;
	bh=lr6gej49qGKlZJLtdegY46EaUc8ElTpF4oQbPdKembU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zbh/s20aBt+v4IR7DyVJLIvU0XnZQFoK4hgoP8UOAauQF0WClcgtHZ2jst5xdZ+kY+dme/KkJB1aGFtuwp4T8JLXvyKc5uUZPWDvl6g+hjxuiifNHtfFFjgchD3vtT8ExZU+3toUmhZ+2wYGvhwo4DVFybisgpG/yfjsJD5cnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0DrJ+4N; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0DrJ+4N"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5e18598b9b1so1656274137.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 00:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763542775; x=1764147575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAaNb2yWz2YpS6Pvma8WxDc9rvktVv49/TmyvQvIhts=;
        b=b0DrJ+4N1SDFm82la/I5+mxrlrwDukCSBTIrnaFGwcEr96sy98+MT7hiI6Kd6EAyaU
         3S/0Z63F2NqGuoCbM3cvYUUdhgn2ea2ubmyj4g1KeEH5CZM4PNE8ZIpImCSrbI5gMA6n
         cfoueSro+xeGiwBdY31bOLqcoHD9EO1CDJFDNoqtSPqYva8NUvOBepthintZuJJgEDeC
         VYpUGbQg9MMBpZm8ah7EudNAT/+JnVKqX4VV/uJnfq1vnoK49zaOF37CVboOZeKRWm5P
         ITHhSHGCiCWxHvhSiy8pkuczkBgfPrD2ISB6SQnhvyU8glQOzMhAGN757Sql/6+KdUUU
         LdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763542775; x=1764147575;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAaNb2yWz2YpS6Pvma8WxDc9rvktVv49/TmyvQvIhts=;
        b=XCWAF9VVdFiQNZBX+jkyirfQH9/PeBFXtSu/pSMyWwj35q2Ex7gwHFeJhYtGI7+csI
         Au4FiJ+j/4i/Cg1Vol7FUa1tuAponewwPdQxN5WfWnHbelj5bG93o5VJYXcy5wa9EFDM
         vjdxE1U8kXYIV7rJ/CZ9USDa1s3o+FI3Wp5Us/22eID4pzpqedPvpn1A9C8B19yy/6Bq
         D4FLGbAMYvBMYiw3wUvbCF8UGRUzXzemAxtGwnZm9uFlH/p4T1J14ed/g4mTZJOVn7+D
         w599a73FlpfDxbpf9ZmeK1+pzEjrdzxl49hxOlkOTNbET0eCCWXPP0/1+aC/AqEKdWmY
         UGpA==
X-Gm-Message-State: AOJu0Yy1nhwWYp7UF2GMBWYP0hRIqi9+adtB8sy03qe/+dWphChfHFch
	hOFew7yqSWbGIha1wJGQX9vkkBen/10jRCZ4537xHWCP3BlnNBEQ/aOXJoPY8iJxZNf3olzL8N+
	BE8nF1cLxP9uCCzHNjXU5J54uU2oHHIk=
X-Gm-Gg: ASbGnct/9A3ILsyb0d6c+U7IpI2iilodpOC8kOozvo6qSOwfksQ3d36EMIHWn7okg9i
	MqY05k9YTVFGYdxCERnO+VfTcaoAyOxm+NmQFB7q1PKNOH85SYQ3qik5uD9Gjhamzzz5dfIuabW
	3yqBF6YBHhI6nPavTyZMfuG2F9NZElbobmSqOD663xuLnYqcDsuk9EioMOhsYDUHlbdPtdf3fo2
	TTewAQplAXEgoeYB7Ozzf4SYMtEjGEsH9ZEVWwkGi84RA5o4aVmItM7tclXdkiZUeufmj5AfRpZ
	mY5cvCIJ/ghum2LoA7pOWH5D6VA=
X-Google-Smtp-Source: AGHT+IGZbPzV76X6xufK8hpMQTaQiodEbzfYbBhN5EmgdwGAE6Oo/56K5inU+oRZNGnT6UczgrgtwWC1e67cAN0Ftrs=
X-Received: by 2002:a05:6102:cd0:b0:5df:b4ef:3ada with SMTP id
 ada2fe7eead31-5dfc5bcd55dmr7683550137.36.1763542775453; Wed, 19 Nov 2025
 00:59:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 00:59:34 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 00:59:34 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqv7j7dxqy.fsf@gitster.g>
References: <20251118-fix-tags-not-fetching-v6-0-2a2f15fc137e@gmail.com>
 <20251118-fix-tags-not-fetching-v6-3-2a2f15fc137e@gmail.com> <xmqqv7j7dxqy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Nov 2025 00:59:34 -0800
X-Gm-Features: AWmQ_bmHr8kEn11jrHgDffxyuV9XNprm6kH9znRpOrTiYywPSwc_DpRSnAkRmIc
Message-ID: <CAOLa=ZQW56JVxa+tahrhk00eOmY2d8b1Lch_XFk4tNkummVPeg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] fetch: fix failed batched updates skipping operations
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000ad7d860643eecc1e"

--000000000000ad7d860643eecc1e
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Fix a regression introduced with batched updates in 0e358de64a (fetch:
>> use batched reference updates, 2025-05-19) when fetching references. In
>> the `do_fetch()` function, we jump to cleanup if committing the
>> transaction fails, regardless of whether using batched or atomic
>> updates. This skips three subsequent operations:
>>
>>   - Update 'FETCH_HEAD' as part of `commit_fetch_head()`.
>>
>>   - Add upstream tracking information via `set_upstream()`.
>>
>>   - Setting remote 'HEAD' values when `do_set_head` is true.
>>
>> For atomic updates, this is expected behavior. For batched updates,
>> we want to continue with these operations even if some refs fail to
>> update.
>>
>> Skipping `commit_fetch_head()` isn't actually a regression because
>> 'FETCH_HEAD' is already updated via `append_fetch_head()` when not
>> using '--atomic'. However, we add a test to validate this behavior.
>>
>> Skipping the other two operations (upstream tracking and remote HEAD)
>> is a regression. Fix this by only jumping to cleanup when using
>> '--atomic', allowing batched updates to continue with post-fetch
>> operations. Add tests to prevent future regressions.
>
> Other than the usual "unless you care about timestamps, do not use
> 'touch' only to create a file" applies, but other than that the
> added tests look quite sensible.
>

Oops, will change that.

> About the second new test piece, it is a bit surprising that we
> didn't have test for --set-upstream on successful fetch.  It does
> not need REFFILES prerequisite, does it?

I was surprised too, that we don't have a test covering that flag.
You're right it doesn't. The test for the conflict does, but the happy
path doesn't. Will change.

>
> Thanks.
>

Thanks for the review.

--000000000000ad7d860643eecc1e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e669d22a549b1966_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rZGh2UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNE9JQy80MFJ3NXlRTDBmK01Ka0Rjb2R0Wk5PWXQrbQpFVVV0RHE2dGcr
RDJWeWpYTms0YlAvY3V1RDNIWE0zMjFNQ2hwUTZla3UvMmdGVCtEM3FrSEgwaHBSMmhZMlBnCjNM
ajE4blpJYXNQWmFMOWRlakRvc0laczYwdnpMQkNlMHJJczRyVEZVVlJ4dDg4TlA3VEFRMEdBbE5q
MlNoTHMKT1I1dW1MbUVaRFlud016WmZCM3RjZUYwaTZWZUtDbXlPY1lkcndKbm42WmVXQkZOaWxh
RFByWnNKRy9mMWhEYwpSZ3BUZnh4Zkg5S2MvdEtKN3haVDZNZ3pFNGF0S1BzNXlCckg4Vjc5T2hs
dW1UWkRYa3docTFuNytHNG44TXliCnVjRFdObEVvYmtwRXU0T1hKMEZDRjdIc21hVVpDU3Rud2Vy
bXExZFFXOUNzMGk1VGZpUHp0K1ZkelB3NjNoS3YKUDQyWHFHbmx6Smx2NTVQTzdZK1VWOTJQYzNP
R1BQdTJuVUpubktxZmQ1OEhSUXNDNnJWMFNwclJvNTdmTkZOcApLQzVOaUFuSEQvY1dxNi92RWhv
VjR2UWwvQ1RLMGVHVks2NGxZUDJxZGxvcFlENVo1bzEybllGTjR6L0I1WURzCmpwZ3NOSkhkWDJW
UHpzTit2YW5ydURZdVRpVTNDaFZkdHNGSks4Zz0KPUk4dlQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ad7d860643eecc1e--
