Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C94E1A0BFA
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734694278; cv=none; b=jC4v4LDdDCujGibQ1QygXSJV+wKEfd4ruORSVBZFQwRAzdgO18Wfc8OD3D+g2I2jCeGS0heYZbG9vd2/+cv1GW5oWIouZ/YD7xvWK6y4AHz1F7dy3JsQm7t/GMmbWIpBafWgBnB8ZxZyJVw54DXR0PJyyL7KQ5xISGGiZYy3JGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734694278; c=relaxed/simple;
	bh=RgxlNj7USlRfjt1oDbGI1iueccrHw+6ZUYKpl15qLtg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaX4GNRBceF7fHG7ucuDIqBRXLJPpYY0NAaZReNdrDZzId3fwZc448NKBK2MbDwcVRIDSSNCE5+Mv6LBCC81YLvaPru7Woct8oox+EESm+Zh0CxOEiGjRTQpDu3pm47H8+CFHB0dtuX6sAL21+1ebovHKy5dl6ToM5k0ownqkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKjW0NWL; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKjW0NWL"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-85c559ed230so401411241.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 03:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734694276; x=1735299076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RgxlNj7USlRfjt1oDbGI1iueccrHw+6ZUYKpl15qLtg=;
        b=aKjW0NWLYsMAtGKpgR+H1SVdNsGK1RvgF5dVlYcM2KyyMXO/ctCkAdl97pD1PFBz2r
         F0gKnPAj02f8SVD4L40nLVS1Ldprlg35avgB27qGpvJwsBuD8BoM/AEQZZTJTAPvOOTQ
         rjw9V3Tv6YymKssxubxnj4nmsPxuyICSHxXyNCVwU5UTLlKgC6DT5umOLF1HQisJTaku
         kGVNKMu9jVtjQR8I80D0WJGtdvTJ93lX1XrYsr4lPyH++EVCdZWtnzMtwm2FTPG8Evqd
         JX8pVJBbAJYjUNKHKtqSvgj32rfSgWcI3ciNYimq7wf0xsQ4hdLk/DZ95oQlEeQcyyGb
         +0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734694276; x=1735299076;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgxlNj7USlRfjt1oDbGI1iueccrHw+6ZUYKpl15qLtg=;
        b=WEOOTQz67si1OokeXliOVdsodMbKoWsL6xSTx4ECFyCIS4JSPX8U7W8GHM72Hg0I59
         ROb9H01I/GCPhnP5iYQCuAAwVl/YBMleWhjsHhsrSnjksE2wrfbEzhIW62YeBvSGsqVw
         i6EJjVwRagEkXZHkSThn+joe1GYHRDpuhSNX39MDc+34G1JxKayR1WurMC0vWwW1woZz
         hft9DJOfl8jyjCdOTyLpfI7qXfpIifAmmEejwHybQac8MUFS769Ej+pdKaeouBymV2pu
         urwbKMsIwEbcXHcBNngC2O3uCZEmi79ieKfyUB1CKq1WbdIho+XrUsJvKf6todYTBxwl
         3McQ==
X-Gm-Message-State: AOJu0YwwzrdXZWCiuL6o2BS3Io5ufgUONSgFDKJoa273amoQG0cwZIWs
	ItPoZFiOUdpSrQcEKUGBqdUHcVv2Heb4YLX3F6wg+6TYBs8sLgggxnObgkTdTX51JCgieGuhowb
	Ic/ey+biLv/ypg465XQeTC5SJdUs=
X-Gm-Gg: ASbGncsUwKlp/i+2cj2qIkMyMqlyygrQLCvdUTWIcR5DKNAtEvaBJ2qebA1G3OvQ1jk
	bm2zSE48mJGoh37kj6qQ9F0962F6hznwK5Fao
X-Google-Smtp-Source: AGHT+IHqHAErGfx1JUQPFGPLMO8bFuy7+Mn2qwnP5TuAtKLamhD9zolF6/tWP2HmJaw/LJP23LU79c7NPgSyKKfaky0=
X-Received: by 2002:a05:6102:3709:b0:4af:fc14:f138 with SMTP id
 ada2fe7eead31-4b2cc35f97bmr2419547137.7.1734694275934; Fri, 20 Dec 2024
 03:31:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 06:31:15 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <875xnfh3kx.fsf@iotcl.com>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
 <20241213-320-git-refs-migrate-reflogs-v2-5-f28312cdb6c0@gmail.com>
 <Z1wnbCoidG-lC7ui@pks.im> <CAOLa=ZT9KDNaz84DLoRBzY_yaZ3kZ2FUWADohZhM4EcrJgmS+A@mail.gmail.com>
 <875xnfh3kx.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Dec 2024 06:31:15 -0500
Message-ID: <CAOLa=ZTx3T=md4VQ6tRb5U41nOHsbhTB5d6VsmyUHFxHgQQ88g@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] refs: add `committer_info` to `ref_transaction_add_update()`
To: Toon Claes <toon@iotcl.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000001c92800629b1fca7"

--0000000000001c92800629b1fca7
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> karthik nayak <karthik.188@gmail.com> writes:
>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>> On Fri, Dec 13, 2024 at 11:36:50AM +0100, Karthik Nayak wrote:
>>>> The `ref_transaction_add_update()` creates the `ref_update` struct. To
>>>> facilitate addition of reflogs in the next commit, the function needs to
>>>> accommodate setting the `committer_info` field in the struct. So modify
>>>> the function to also take `committer_info` as an argument and set it
>>>> accordingly.
>>>
>>> I was wondering a bit whether we could instead pull out a
>>> `add_update_internal()` function so that we don't need to modify all
>>> callers of `ref_transaction_add_update()`. Because ultimately, we don't
>>> use the field anywhere except from `ref_transaction_add_reflog_update()`
>>> as far as I can see.
>>>
>>> This is more of a thought than a strong opinion, so feel free to ignore.
>>>
>>
>> Yes, that is a possible change, but the number of code changes are
>> relatively low and I didn't think it made so much difference. Also
>> because we'd now have one more function. But I don't mind doing it
>> either, if anyone feels strongly about it, I'll happily make that
>> change.
>
> Yes, I agree the number of callsites isn't that large, but on the other
> hand, I see various calls to this function having four `NULL`s in a row
> as arguments. Personally, I think that starts to smell a bit.
>

I agree with your reasoning here..

> Now, before you change anything. I'm not sure what Patrick was
> suggesting? Would it mean we basically rename
> `ref_transaction_add_update()` to `add_update_internal()` and create a
> new wrapper function `ref_transaction_add_update()` that simply calls
> `add_update_internal(<ARGS>..., NULL, msg)`? I don't think that's a
> great solution either.
>

Yes, agreed with this too.

> Alternively, because ref_transaction_add_update() returns the `struct
> ref_update`, why not add a function `ref_update_set_committer` and call
> that where we need to set the committer? I see this also will help in a
> future commit where you call ref_transaction_add_update() differently
> depending on reflog updates.
>

I think this seems like a nice way to go about it. Currently all the
logic pertaining to creating an `ref_update` struct is contained within
`ref_transaction_add_update()`. So having individual functions would
make sense, but the con here is that this doesn't enforce fields to be
set. But for `committer_info` it does make sense. I'm going to leave it
for now since the series is merged to `next`. Maybe something to do in
the future as part of #leftoverbits.

> --
> Toon

--0000000000001c92800629b1fca7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7526469404a7a30d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kbFZZRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3liQy9vRDRkamdQeTdIWmQ3anRWS0JhR3JpRHo4SwoxelQrNkhGanIy
cVh0bkdDVzRQVWowYnVRZ3BTUm1QWFVBaEJiWmV3UC9INjViL1ZMWmhrRUVtMmMyME5sMVdPCkN1
UFVrM1MrOFlzTWJyRHZ6eTVKQ3VHVlZaTzZWY3FEMzc0Y3ZtdnZDeFdVZzhuRXNyenU5cTc0UGVL
Z3M1SEkKcXE1bHQreXNLWXBoQzFUY2ErWjdDOHduQkZEaFRrdTFSVHBaV2wveXJNWVBNMHRFalFS
ZzRlSG4vMy9HTGZPZgpaS09FK3hxQnVsTHZKWjVYVUdnRk9GQ0JGTFE5TmpvK3A3ekszMDdRQVZn
cWc3SjZCUFJLcXhHaHdNZEFFcEU1ClNNYmFpUStid0ZwODhXeWpFZ250c21Rd0VDaXlpZ0NQUWNT
eGFCckpyaDRaa1p4MHFFU1l1TjNVaWFWUUcyOWcKRUxGbUJkd0h2V1pUUEZmc3pNQnlHSS8yV1g0
RTNJaGsxSk1Cb0RyNmo1STE2QlVHZ0k1UGJVVVpidGFhWXFSQQpHSFNraHVUZ0tNNk1JeklSZEhV
ZXJqSDY2SzZJOGg1N3drKzZ0N2U4ajZGaVFjZm03d3J4R2VVemNjazNWbEl5CmpsUGRTVUs1NUl3
UWdWZGtUTEhRMHRkdExtc1Y2OEFrMzFGVm5QQT0KPWZHT2kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001c92800629b1fca7--
