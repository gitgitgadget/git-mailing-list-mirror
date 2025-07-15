Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC9238C06
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572948; cv=none; b=Cvll9Pe+L3HplmCD8UWg2b7DXE2d/2fgPlSifftrjxW6yC9yBQgD0nTTmmyFmKYGeb33CIA/AZGQQvavErKVp6L93+f2/8qqwR8qdpXJmI/pA8sCkoQhECjGW3kFTEuRTObL/jLtdOIvXzOE0TISr/dIaxEKPJPo6+v75bJ32eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572948; c=relaxed/simple;
	bh=wRuayQfqT7o+zQ5lF6MUWiwvCoW6Lm5Qv32kb+GXIgI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtXNAC5y4Hvhobm0hyCdSIYgBiCraqFb5WCZO89GXFrLBcOdmXgKPN5PqD8KQChJZe+RaA1CZuKCkEGSe27h+fhXWLB7dIIY3fpSYMo5zjzIpsG7rdW2xk9DUaxRBbsjd4iSKZfpwKtMfuCZYskbVLj0ad0sSn8AhCFqfw1x9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ2S412U; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ2S412U"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-87f298f3508so1482702241.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 02:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752572945; x=1753177745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lo3P7cMU52PX633YJ7MYC7iOgz6hEY4fXM6xEhNXNgk=;
        b=UQ2S412Ua14wUIWLp7MH1bpWNVMBma893qG395EJwqxb7poWoL74lNZxLt4FdTMf7R
         SYJoDlhap6NPjQMjh402+MWkK+xqV0SnwXV/ZUNCNBn42XAaOOHhx4nIdTNU793WaOF1
         5jJ1OTzBGyPTfRsH2tbzmu4fIuZVi2TREtKHvFUXzglmKjbYG6+BGE7CFWAmD3bJlQSH
         JM10Qf0kzhtmmZ7ctspwjxcNBfxcxsAt5UsflabCyCVnIxzNXzxWHlq4MDtIu54o0CfU
         8WZofdr/FLCnPqnfIOdis+Fj0qZifcnpCl54NuTz/vzKI9XAoIkX9C20rpIGz3PZawB4
         TOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572945; x=1753177745;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lo3P7cMU52PX633YJ7MYC7iOgz6hEY4fXM6xEhNXNgk=;
        b=t+T9Xwz/dJNHpAZaBLDIy3pBZL+WfExq9Dh9y391KZz/KAcqNcLAc9ifDoCGslR7td
         cIdWZWvSsbJUDLsxuQfeaAQpoACiNyIgbZ8rahk7eOmNSoi9xGGYsBf+rqPTM+Di82NV
         0D2SdG9GsCZcCQKmXGsMZKEhEqcDGWoYRyumG3kxH/Lmo1rS1KHzEbNOayvlE0TRBdjl
         XQUb+TEnFaoCCdpbm4wULyZvcsfJSabdaZh9cOo1I8Xagr8fQqziMeQd/UjzAD/6Tscn
         JAEYitPTGEppOKVecmdgfO1T8WYK6uZ63ykvjSg3ccJ7I70k7sdxLStE0MtbQzagx18U
         lcVQ==
X-Gm-Message-State: AOJu0YyaoK8JXLwmfaJdsaBuij/pzdjiZXgd11kECP+BUBJ+jWoof0L1
	46hlgM7CeDZDlydoIloo7w7uIUjxnBBQkp/9B1NV78DSLRs8POMJ6c9D8UUFd30LxZe8NOQtbYF
	l/KAVKyttAcghQ+pcyyG+uFDTTQhmd4o=
X-Gm-Gg: ASbGnctGPRW4JKBQz+q9wk4MYuWajzDPBD2AkeW5CMZAjm1WgWF1LRt4CtJ0w8ejxe5
	01ZY9H7pZEz3Q9J5tUwCyh7kObEkV6XuY0qOoTifT4lwyr2bA5zO3W/pK0jGhBclHm94qaIizky
	QX4YNEMFJOs21BJKrTGhnl0KBbggsGMM77TuLLosd3J962e7NxaNjE0tNKAYmQs5ny/6GSMNLgI
	0bm6v6Zh+v6aYse47BkHbhhI7kGo9JgeeaciKml
X-Google-Smtp-Source: AGHT+IEr//kGTergJZ92eIP9zypVuEDbnqOaq56gyaQ58pnppaYasLL5LBzw6iXJyee4Qavm0UuZ0IUi+napL4E6iyE=
X-Received: by 2002:a05:6102:952:b0:4eb:3f3:bd17 with SMTP id
 ada2fe7eead31-4f641210b16mr10390366137.2.1752572945537; Tue, 15 Jul 2025
 02:49:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 18:49:03 +0900
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 18:49:03 +0900
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq8qkqvjnu.fsf@gitster.g>
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
 <20250708-306-git-for-each-ref-pagination-v3-3-8cfba1080be4@gmail.com>
 <aG9hMP9gEFLhVgJL@pks.im> <xmqq8qkqvjnu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Jul 2025 18:49:03 +0900
X-Gm-Features: Ac12FXwCwkLTIVvdg4CVONTyrLyt7fm17s3VfJNXUctabeUsu4Tt5wLOUb-ngVc
Message-ID: <CAOLa=ZS6ASf1+nbUnCTeeH1Di=kgmhQUEQ5UXPZu051rfqx9Pw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] refs: selectively set prefix in the seek functions
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, schwab@linux-m68k.org, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000dcb7570639f4af20"

--000000000000dcb7570639f4af20
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> + * When the REF_ITERATOR_SEEK_SET_PREFIX flag is set, the iterator's prefix is
>>> + * updated to match the seek string, affecting all subsequent iterations. If
>>> + * not, the iterator seeks to the specified reference and clears any previously
>>> + * set prefix.
>>>   *
>>>   * Returns 0 on success, a negative error code otherwise.
>>>   */
>>> -int ref_iterator_seek(struct ref_iterator *ref_iterator,
>>> -		      const char *prefix);
>>> +int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *seek,
>>> +		      unsigned int flags);
>>
>> Another tiny nit: instead of calling the variable `seek` we can just
>> call it `refname`. That might give a bit more of a hint what you're
>> actually seeking for.
>>
>> But other than that I'm happy with the new behaviour, where we are now
>> consistently either setting or resetting the prefix depending on whether
>> or not the caller set the flag.
>
> I am not sure.  The way the "prefix" is used, if I understand correctly, is
>
>  - it is set by iterator-begin, typically to the area to iterate
>    over (e.g. "refs/heads/" for iterating over branches) in the
>    for_each_ref_*() family of helpers, and internally we seek to
>    that area (skipping anything that come strictly before
>    "refs/heads/" for example).
>
>  - iterator-advance looks at it and decides we are done when the
>    iterator points beyond that prefix
>

That's right.

> So if you are iterating inside "refs/heads/" hierarchy and seek to
> "refs/heads/m", don't you still want to stop when you step outside
> "refs/heads/" by keeping the original prefix, instead of unsetting
> the prefix to empty?  A postimage of this patch for packed backend
> (picked at random) reads like this:
>
>         static int packed_ref_iterator_seek(struct ref_iterator *ref_iterator,
>                                             const char *seek, unsigned int flags)
>         {
>                 struct packed_ref_iterator *iter =
>                         (struct packed_ref_iterator *)ref_iterator;
>                 const char *start;
>
>                 if (seek && *seek)
>                         start = find_reference_location(iter->snapshot, seek, 0);
>                 else
>                         start = iter->snapshot->start;
>
>                 /* Unset any previously set prefix */
>                 FREE_AND_NULL(iter->prefix);
>
>                 if (flags & REF_ITERATOR_SEEK_SET_PREFIX)
>                         iter->prefix = xstrdup_or_null(seek);
>
> so after (true) seeking that does not have the SET_PREFIX flag on,
> wouldn't our iterator-advance run through the end since it no longer
> is aware of where to stop?
>

That's also right and that is indeed the intention. We're trying to make
the actions more intentional.

So if a user sets a 'prefix' for the iterator, all previous state of the
iterator is reset. So, the same function for seeking an iterator should
also have the same side-effect of resetting the previous state.

There could be a usecase where we add support for keeping the prefix,
while also seeking the iterator. That would be an explicit change
(perhaps with a corresponding flag?) that we'd have to build, add tests
for and call out. Until then, we explicitly reset the state whenever a
user calls 'ref_iterator_seek()', they can be sure that any previous
state is reset.

> Thanks.

--000000000000dcb7570639f4af20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 740024c094565a0c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oMkpBMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2hwQy8wZHR3bzk1dkJrcGhMOTJqbzVJaGZTdk5XOQpvZlZjU3ZCS2ZT
eEM5TXhYb09yTGZwdmFENTJXUzNZeHFFSTVxaGVqN2NJOWRVdzkvbDI2T0t6b3pDWEVFbnZwCndL
SndRdGZDZmo1Mko3M0pmd0pXNmx4cGVwYmZ3Y3lkeTUra014d0FaaFFtRHcydDlWY0JMQnFpalVx
dWdtTzUKWjZId2RtU1Q2Q3Axc3htaWFvYnV2RGlienJsK1JWZG1adkFYZjBiQ0FJRFhPS1RZWkFq
UFphTmFZOEs1UEMyeApBU3Y1TXBrVGM5aExsREUzeUVBVU1sY3BoU2tqN3Z6Z3JZMGlpaVNyOEFM
YTZrMlRSTjIyZnJxRlRiSTdIT0hpCnl4SnVyZ3FtNW9SMk1hMEJ1UDBxL0hvaDZ5blk4bnR4QUo4
bXlSbjlZMkJRWHZ5bEpLT2t3TzZPc3lvRlllWVgKRzVCS3piQ1lrM2xoQWpJalpJeWRZZ0FVSFhn
Z3JMdVpvQTZreVFJWTBzQjJzVGQ5YTRBd2tzWnhZMGFiaXdoVwpZbndRazdqMGZianFsSUF3VXZO
Y3VPUU9taTYrdVdZUTlTTkpoS2ZPM2llNVQrWG1HaEIzTytucFMrTndnSGNUCnVtSlFWdUJtTEp6
dmc0ZFd5c0ZsV0FKdHdBR1QvSlMyTEVDWVBHND0KPVVUSEsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dcb7570639f4af20--
