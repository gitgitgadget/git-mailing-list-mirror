Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE833C53D
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715941; cv=pass; b=Gtfkpqx5py5Qbx0/7rG8l5i3sqWO95A2gwxJENN1+ytRacTHAg9evByAuL/cZJ+FseFGYCONAK/X9gUK+lFgImIz2vYttox59Xy5ptAHOOEGiCsjJ4sBm9e/m3+B2u8kTeo5skQjVbEJtUt/WiMVXUZ5yZY4k93PyPj1puu7Pf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715941; c=relaxed/simple;
	bh=vHimGL1SkmSS814MexRELIsKeDHJoh8VfghzkiQ2Sy0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=F3jMUHkFL1iB57kIzd8/DHrENYuzKmPEvyWm2A/npHF64jBjX/JZSMPvDZfNbBPOB5YRcvFlTj2ND+vj7g+uDuckFYVY+2SkufLo7eW64iubGJzLY9EiEyBM0e8mba8bj4fQ1sSHa9KWL7IcYaa6IGUwSsV2aBfw/Fgi0ze0NGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F96GFzfJ; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F96GFzfJ"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5eeaae0289bso326923137.2
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 01:32:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770715939; cv=none;
        d=google.com; s=arc-20240605;
        b=fSw41ip+XO2EzePBUlVNrR4UrZ9qUf2e4ITKsTTalvM5l6Wx8zs7pDhxv+0Zb1ordx
         Rz6b0uwIGyZRioDE35wloUXuG9o7d2gyHj2ZSnh44IhE38PKU0n403aEro6UwucF6XJs
         qxs0dqEG2gc8X1iNnyJ5UPDSBzM82flZ+oRUevq3z6/sWxNzYe0pSAD0gAmMvNQCG6uF
         II3I1d+A5wC0otDhB1KkkQU69/12P823VPmUrFea0ugJoJUFQ4cEQ4OZ5FWgMkG7vk49
         WX8C7lhGL4vYVMHQsYU2PXOHI0/EKkYm3XSZGCuWDwL+tULqYrHXYvXIVQHvlK4PL1G0
         5TMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=2AJ+s/4kc25A7YM8FEVfZAavDKtN0XUadGt75CZ+S2E=;
        fh=i71nkRFqKM1Je/mEAgFgCEItjNpafBsvAuVu4P9R2B8=;
        b=JldIOeUXm/4Up9WXmY7AO1l6G1gCNl0hQIebRNKSrEFP3CkTls4IUvOW0vAGWyqpDU
         nlyHev0Yop/WSTlDmNNPBO9C2yTfGfrzOmIqqjjOnVdqTJ/EiOA64B081FwSYJklW6MW
         QBfCKrWDvE+jy9msKYbQCww+p6wJpizMUcTyKmsiJ6Grd3hgR/GZhLN1CONsvlca1spM
         qfpLv2T/23u+lhxZmCCugG2jDuwRUH6TAbDx546a/VzUZgUcifXLHvjQJ6EIeraNeoKX
         HMXjijIN5TwYLb0LjQXo6cAvP3w1CEb3mdh+dZXAg1QsjOZr8WUCvzAlXxOocXATM/Jx
         kegQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770715939; x=1771320739; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2AJ+s/4kc25A7YM8FEVfZAavDKtN0XUadGt75CZ+S2E=;
        b=F96GFzfJ4hKTyPexspPweVLbE6PDc6eqqreajfvmAbZACNJwBQnhkq9uc/nYZHVm+Z
         k7BGPP9xh/eC0uggobomPwNYsiinvfodgalgT1V20AAkCjsm1I55tWG3pn9aAB1g0Gad
         bobfqxzbn2+F3dEoPH1jRB9F2+UHjtRhn2QMnJyZd7GOkqQAHQLCO13jiFyn4FQIxRfZ
         RI6vB0AqKxJPumFtNFd34rmKEOl1VCokLt12zY0ZXQEXd2pOVu6vZ40UOk9pe5OwdWIN
         VEQpmJvwThBXF2+A8b8mRy2gDQlGpQRd9XKhH4b9albU8nrEJz1uS0LY8krVnCIo1Or6
         V5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770715939; x=1771320739;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AJ+s/4kc25A7YM8FEVfZAavDKtN0XUadGt75CZ+S2E=;
        b=bXb6suFuHXHeQFLz3VEJc6fDYakO6t7iK1jiC9z1YtlwYTWVuM8a9opmaN5J0wdR9a
         MGV2gA9ZchFN7UgrJx4iTCreM4KXlbNFzgjGpSYUVepH/Mykeg6rNJ1kGJImKN2NazPc
         ysugvS52+2zRmaN5Z0g3/9sGqf3IVdDm8/PNSKG3trwrqwJPisci2ljALtPHsWa98a77
         x3mDPc5TBmEF0EJlKzxl3lV4y+p+ZpWJzn86dFqSMQIxlha2MBdx+idx+IIgyVx/5Okq
         MIeRPq7zdFtz+/zRr5TCUwy49Cyn9w+szgRhzSSNNT7ZPcbJu6kknWX1AQyBRvFwx+0u
         S9xw==
X-Forwarded-Encrypted: i=1; AJvYcCXL86awbcJGM4qUsxzyWGm16FNoJfHxL3yjU+8FY2BY+0dF9dZY7nSTnwRNvhg7tS3SQ6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YydGFDLkRIu/f+ZJefKVpKtEpPG/fXatg8B48wRDu2tQqgXfGIq
	rhCnAipY9+tvCqz4+sU9Xumh/ruXfAgGWc1xp8ThFJncoQtqjQGgayVppCozSu4W4IDPpEX2YXZ
	G/8j4Pl4Al/750UvtK3iuHelp/Pd8E3bc/B7k
X-Gm-Gg: AZuq6aLcKKgxSMKwdrRuZHFlOTlsj8JbpHDbrZbSXTIaBYe66pr+6/QFx3T1own32gT
	140n7LLP4fOmr4J2gG5mQ/R+9yfedrl+P5SFn3jscHtC9ClsmQO3aJBJVgla8FQuq14KkHtCEan
	tswIA+aXOIYJcAcs4rXxZDLCnAW+bTA2X/kFnr1BaT1vWwagsUNWjpcngw+5rLxqit1K+C0b9Uu
	Uwe3TkeTPmqLYTQ0rvOTqZsYHHgvolcZWxHD09ycBO0Cop/g50bSH66yX8HKwAYIa8qTwPkLkhn
	3H5+TSqX6IBLVNx+EHznZP4E3eAm7iYPYOzjQlsmt2BBeEh23adk
X-Received: by 2002:a05:6102:3a0f:b0:5f9:39e7:29d with SMTP id
 ada2fe7eead31-5fae8a256b3mr4229210137.8.1770715939231; Tue, 10 Feb 2026
 01:32:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Feb 2026 01:32:18 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Feb 2026 01:32:18 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZQeDTFkVjJcmY8VOeR_F1E8c6dcc+fcMbUdcWcw2DPcGQ@mail.gmail.com>
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
 <20260126-b4-pks-read-object-info-flags-v1-1-e682a003b17c@pks.im> <CAOLa=ZQeDTFkVjJcmY8VOeR_F1E8c6dcc+fcMbUdcWcw2DPcGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Feb 2026 01:32:18 -0800
X-Gm-Features: AZwV_Qg8NhwnmxOZvnNP5EfEvN-yWQln-WBeFTLXk-JYzZlhINcvX9aKldLq274
Message-ID: <CAOLa=ZQR4FryFF0NvX5TYZMWFDw_h8SL+aesv5S2Li=jgVEBew@mail.gmail.com>
Subject: Re: [PATCH 1/3] builtin/backfill: fix flags passed to `odb_has_object()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008e86ca064a74ee4c"

--0000000000008e86ca064a74ee4c
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> The function `fill_missing_blobs()` receives an array of object IDs and
>> verifies for each of them whether the corresponding object exists. If it
>> doesn't exist, we add it to a set of objects and then batch-fetch all of
>> the objects at once.
>>
>> The check for whether or not we already have the object is broken
>> though: we pass `OBJECT_INFO_FOR_PREFETCH`, but `odb_has_object()`
>> expects us to pass `HAS_OBJECT_*` flags. The flag expands to:
>>
>>   - `OBJECT_INFO_QUICK`, which asks the object database to not reprepare
>>     in case the object wasn't found. This makes sense, as we'd otherwise
>>     reprepare the object database as many times as we have missing
>>     objects.
>>
>>   - `OBJECT_INFO_SKIP_FETCH_OBJECT`, which asks the object database to
>>     not fetch the object in case it's missing. Again, this makes sense,
>>     as we want to batch-fetch the objects.
>>
>> This shows that we indeed want the equivalent of this flag, but of
>> course represented as `HAS_OBJECT_*` flags.
>>
>> Luckily, the code is already working correctly. The `OBJECT_INFO` flag
>> expands to `(1 << 3) | (1 << 4)`, none of which are valid `HAS_OBJECT`
>> flags. And if no flags are passed, `odb_has_object()` ends up calling
>> `odb_read_object_info_extended()` with exactly the above two flags that
>> we wanted to set in the first place.
>>
>> Of course, this is pure luck, and this can break any moment. So let's
>> fix this and correct the code to not pass any flags at all.
>>
>
> We do pass the same equivalent, no? I mean `OBJECT_INFO_FOR_PREFETCH`
> does resolve to `OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK` and
> calling `odb_has_object(... , 0)` would also eventually set the same
> flags.
>
> I understand the issue, `odb_has_object()` should only take in
> `HAS_OBJECT_*` flags, even though internally it converts them to
> `OBJECT_INFO_*` flags.
>
> Wouldn't it also be nicer to convert the enum for `HAS_OBJECT_*` to no
> longer be anonymous and use that in `odb_has_object()`?
>
> The patch itself looks good!
>
> - Karthik

Just noticed that there is a similar discussion on the other patch in
this series. So will drop the discussion here.

--0000000000008e86ca064a74ee4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f1bc1f2175d499f7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tSyt5QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3pRQy85a1VOM2ZNQ0w3MDFhVFczbVJRS3VVVk4yNQpNMzNuS09LWnFK
K0JBdTNNUGVTOHNzeXM3b0E5TEJCWWZJaHVyZm5oTHRBMXZCanR0aUZ4bU5xSVZObllTZWU4CnZy
UHhmR2hpcHFBbnVpZ2srWHFrMTVvY0ZHendxbjFaQ0VDVkxuMEdFSTRUVU9MZ3RXK3NvVVlWZnVO
aW0rQmgKOFFJTVowM1lTUnF0RThkNFIrOFVSTmNvZU5MMW5jK3haRHE4VXZnU0JxWXVTUHBzdklM
ZkNWL09BZ0VPK2l6WApBODRtQmk1TjcvUTI3MXd3eXBXVlM3ZHRvMytBUXdkMjFyemZEdEJPcXY1
SVp2SjFWQmluRVNJekg1L0hCWWtkCm5TV0o5RkNQLzlCd1M0ZnVHUitNY1pmQlhjZkg4ZHVFWTdY
WEpsaHhpZXR1dHFkS09EWldocCt5NlFKb2toSHAKWVh4NEozM1Z3SUd3OXVKVWl3Z0srcnVFRlR5
L3VjcFFXZWppSnNOWmRiUVB0VG5sc0pad3BNaUJKU05LNFY0VQpHUjhITm5rOHdTZ3Y3dUVTaVdM
Qk5Hc2Z5czRLeENmQ0QrWFE0cW5LcUpGb3VNWjV1WkZvVEpBYWM1aC9mQWtzCjF0YVhYVW1XN1Mr
aWtESUx5TExpVW5KbjdoUEMvWTgxNWxIUjdxdz0KPXNSU2MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008e86ca064a74ee4c--
