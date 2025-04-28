Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212E1D8DE1
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869707; cv=none; b=YOkjf7fuq5184FegSPmmX7+cRAn0WIOrRzex2H/K9CLU2oScVsWfyji3+Hh/23KLhpTpQIGHi8i5hdRYboPYQMEOwOx1TomatmyROcd/4aeo9AV1G8ZknZKpAXpk4mXib+MifgK4DjKmi2XR76AasLAcsUpzy9FBTxjbB2mNRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869707; c=relaxed/simple;
	bh=UbdToYBzCaIjzmJuisVuRCQLucvjLYP9k6xq+jra2SM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njgX1Ava7UfqSgCh/+GrQ/JJPamK1Qe3OQYXYEPfoZ8zVvu33gwQBYysFY6dWcXL8GK8WKQGUs8TKq/hQ7I9AEriVkEmqKrYBCtiXVxKJzZnhThELOrw+H1Bs9hyB0w/ZminCf1oa0f/PB0AjgaRmVwQFETK3/IM1oGFUEOdTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4mkdauu; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4mkdauu"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523f721bc63so6396685e0c.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745869704; x=1746474504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LaPFrPgdrBHr87mIo5Nlm99WIvj5W7MiiyXGrAvtK2k=;
        b=Y4mkdauuPw16kDzRxQ/EA6hIhJBJ5GQp2Cwh6/mCgS8t9GbzzCYM6RQ8Sq0fpFjQZC
         lSQytP4hpVAZQDC6oIZ5MRu+t6l35ohmdCfifsnEDOi7f8mdrkO9sq+5ukXTBsgIfqaZ
         o5T0P/wn428JPMsCdEHpOgiWxsvpCDeHVnAeFf7Pou4P1paeoMymgnvHwgZBfzfLkaFU
         yBKz35+FwIP9E75MZFAXHiaM96sHmp7vgXwX3OH46boKnaAdyRNQWvAuevyCRHA/8QlX
         l5ESmYgAFMGuju13P62nU447Y3fVqr5yIPVqNpZ6/XLNiKWuifmD+IzB4/P5HjZtcyF1
         AJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745869704; x=1746474504;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LaPFrPgdrBHr87mIo5Nlm99WIvj5W7MiiyXGrAvtK2k=;
        b=hNSaLTUOXQwY2x+6uv8fxNc6cHAoE2IVXpDIBs4mr1g3nQefroAyZYfEG2HauUFp0V
         HvfskOx7MY1CCV6aQsMxpI/GjM+YcH/4GFajc0W6AdySQ7LyDo+x6YspnW2D8ulV4zuG
         narrlteipg3L6cnOrZBSlXoDYzC8GEQQcxx06Q9M01PfuGu9LHlwpKR69YtbmEChlla+
         mGloa6VzleeZDX+Ly+0w6cEn7rRudzD7lF/jYPnk3+n5LF0GLA62PWLMdShm25NtSeqU
         mXVxL/bvi3ngfAoW6uYaGjSKGYrgvkVoBv2Bzj+A6Es9CtTtu1v8Y5+jcKrxQpuID4NN
         64gw==
X-Gm-Message-State: AOJu0Yz39P5gLqufcacOXdn0aphT1FxpVD+9FUeNcQ/ZtJtLND1kuiCw
	A2BNjnej6Qj0PPUqFQnZCrgTxmJ6dHrNleZGWjdhoYHiQ/37qSJGjZobneQsCSJOeIlX/uU45ru
	IG2LtACZgh2pi0IfWUOieHzH0z2w=
X-Gm-Gg: ASbGncuEw2LNUPD/183giJtHC7SCnZcxEBK9c+ZwZWJ6rJKx7jWCbh62tn9PeJsJlAJ
	TV3TjgjWmwtwmf59IWghF9LVwl9KhhqICr9RYIZlkE1Y3f5wYsQmRisjVafnMlt5wwowID6YPxU
	etD2VcWYAueWUJ+U/bT2g/QHonjg62q0TWtpbO7pjg3xJrYAwfSfJFODrU
X-Google-Smtp-Source: AGHT+IFoqls4zpN3+s0TmP/5Gjlfm1dnJPW5E+N51Ik6Sq+IlgPs5+7cN4R9QjJQXwuUuxDrLjFpK38jqfDJjYLaF1U=
X-Received: by 2002:a05:6122:884:b0:523:771e:8b81 with SMTP id
 71dfb90a1353d-52abf80f793mr407113e0c.7.1745869704395; Mon, 28 Apr 2025
 12:48:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 19:48:23 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 19:48:23 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aAs0F58Hlpn6WI6b@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
 <20250423-pks-object-store-cleanups-v1-7-81f8411a5d08@pks.im>
 <CAOLa=ZQh+agLJYEGWU2O2=iRnJy94y9Cud3XRVaGVHC4YdbBZw@mail.gmail.com> <aAs0F58Hlpn6WI6b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Apr 2025 19:48:23 +0000
X-Gm-Features: ATxdqUHpLZoDVLmMicADuakrzWawe_lUZTQ86iKeOgUp44yOBqlxcTpf_746J4U
Message-ID: <CAOLa=ZQy=OrWkqUTS+t_fAYj2w--1Fy=n7=gdJTHFhebNAZCnA@mail.gmail.com>
Subject: Re: [PATCH 07/13] builtin/index-pack: don't fetch promised objects
 for collision check
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008e1e120633dbf78e"

--0000000000008e1e120633dbf78e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Apr 23, 2025 at 10:08:05AM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > Any packed objects indexed via git-index-pack(1) are subject to a
>> > collision check. This collision check has the intent to determine
>> > whether we already have an object with the same object ID, but different
>> > contents in the repository.
>> >
>> > The check whether the collision check is really needed is performed via
>> > `repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK)`. \
>> >
>>
>> Nit: this was a little confusing at first, until I saw the code. So what
>> this means is that the collision check is only performed, iff
>> `repo_has_object_file_with_flags(...)` returns true.
>>
>> I think the confusing part was 'is performed via', perhaps:
>>
>>   The collision check is only performed, if
>>   repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK) returns a
>>   truthy value.
>>
>> But it is okay as is too!
>
> Will rephrase.
>
>> > But unless
>> > explicitly told otherwise via `OBJECT_INFO_SKIP_FETCH_OBJECT`, this
>> > function will also cause us to fetch the object ID in case it is part of
>> > a promisor pack. As such, we may end up fetching the object only to
>> > check whether the fetched object and the object that we're indexing have
>> > the same content.
>> >
>>
>> So us fetching the object is pointless, since we only care about the
>> 'does it exist' part and not really what it contains. In that case,
>> shouldn't this be s/same content/same oid/?
>
> No, it really checks for the same content. It basically verifies that
> any pair of objects that:
>
>   - Exist in the packfile that we're currently indexing.
>   - And preexists in the local repository.
>
> Actually have the same content.
>

Okay this makes sense, if they do have the same content, this is not
a collision. It is simply a duplicate.

> The weird part is that we also do this for objects that don't yet exist
> in the repository, but which are promised to us. This causes us to fetch
> them first only to verify that the fetched promised object has the same
> content as the packfile. And given that git-index-pack(1) would usually
> run after a fetch, we end up verifying that the fetched object obtained
> from the promisor is the same as the fetched object obtained from the
> packfile. Which ultimately seems rather dubious to me.
>

To clarify, the flow currently (simplified) is:

1. We check if a collision test is required, by checking if the new OID
already exists in the repository.
2. If collision test is required.
   a. Fetch and check the object type.
   b. Read the old object data.
   c. Compare the new object data and the old object data.
   d. Collision detected if there is a mismatch.

Currently, we fetch for promisor objects in #1, which is unnecessary
because we simply want to know if the object exists in the repository.
The actual check in #2.b would still fetch the promisor object (if that
flow is taken).

> Patrick

--0000000000008e1e120633dbf78e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e9be0dc3351c8329_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nUDI0WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkppQy80K1E0OHd0b2cxWnRDRVhCS2Jib3huNDl4Rwo2bWo5aWRuRnpK
cHlTVnpPM0JuRkxOejgvUyt4cTg1eTJqTXRwY01raWZwRWFPNW82T3dnbGxQczhnNUh2OUFtCm9Y
MnY0dGtlZm0vNHVaS3NmVzZ2WTF0TlBTK0RrcWttaTNWVGRzbC9KcFVEbCtWTTJGQ0JZZHNIWjdZ
aEJ5WlQKc3d1SkZIM3NRVzdQOTBnVGxac3p5cDMzQTlOd3lEd2t6dWdDYlBlLzJEU2xlYVcyaWta
WDhhYlcyYzhuVmo3KwpwOVlYWjNVbFFNZGNCaWIxbE1zS2ZzNzZDNmFRK0ZxRUNBc2lSaFp0MG1L
Y1V2d01vZHJXTDhSQmZKenJTSkQrClBGdFE5Rm5IUk9vYkt0ckFoeENkYThTVXRwZHJYdmhVdVZu
QXBseCsraTZwY054TU1wcnBTa0lJNTVia3JRVzUKY25FdGlPenlVamJ4c1RnTlp2VHE2K3RIMFI5
YmxwZG9YVlFkbk41ZHdrMVYzcDJSaG85Mm1BbmxxRkUyVnJzeApnUkZ2VDB1TG94cFNMTnVLbTRB
ZjMwOXJLWktNWjd3cWNOL2ladXUvcXZYTFdqUUxEemJZTmNVaXZJUjJPSWNLClpHbCs3ZUY4Z2pN
SVpEZzZDemFoTUV6d1hZT3F3Y3laOTBjMEp5az0KPUJqQWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008e1e120633dbf78e--
