Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418E155336
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079525; cv=none; b=LXkE33bcOF29xin+xsiqieJah+i8e4tS6sWSD27QX15dcfgWgo0ZhsuR5VGPC7N1pRZWmSbdXkekRJrRZB4aRsEfCClhEwDgl0N6KUgYcjKeLR6BzFed9AJHtQcwQrFCjw4pV2FX8sLrKaaRU/6nR4en6r+Xq5d71mBkrrxw+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079525; c=relaxed/simple;
	bh=Uln7z+lpeqyXe2RX9+c90zv2oYUVBZeFrg27OLpiZuk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ou+9/Y5tr6hUjwK1NHIzEDjaVR25TfeLG+3tOyFNq4ZQonHzhuzmj1BVoNRj2LuiZwkv5egWf+4S7AZAqyaxjoF4eRBglp8yFrcZehYvL87oZtFbz5wLFHtllKpjzX8gqrbH7sUkpmmMn4+4Gaeij4NoUwk1XrDdOTx6//GgiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY+Zrt2P; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY+Zrt2P"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ea1a55b0c0so795613a34.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714079522; x=1714684322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXnoNcl8Y42QNOc8eYqJ8lOJqBKI4HOfrLwoJG6rZsc=;
        b=aY+Zrt2PMhn6bJJzJqQUp2k0tOyloZaWe7xtkutX/Ixm/h90W26XLkPxO6lXlc9RGU
         BIS94RGe5huSjMny2heoDMkPp75+G4Hl1LzDdb0zoejHN3mKVPWI7fEgNMCDhIMJz97Z
         5ipB2PB/rGjCh1SWnqEIhjpvzaBIXfI/6BOoXrisjedcW+GMOkwNocW+pCmnceLd2w6w
         vpr4m+7dmGRsi+poXtygt4sNmvJ0DvO+8mXrOBE+EUusTQCRploLgmi862aNLFYhQL63
         Xkr+hXoBQVNYfV9elJr56c/BqZChk13caGnXOyD9ELs5Qi14EQncVb1Caw9/+YR05tYy
         fQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714079522; x=1714684322;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXnoNcl8Y42QNOc8eYqJ8lOJqBKI4HOfrLwoJG6rZsc=;
        b=fPefqg35+iSqJmk93HvxION4fQUzbRjQ6/yhL4waRUMaLTZcQ8TsivdGPwjMXffDPJ
         A3qJOF6+YgjfyJWJGKefL5jP8QnbfPDTyurWmycTamfuezfiJHsTNtwIdoqltlV7uYix
         K/NIalx0YJOBur4EJHCf2p806eNA5NEk+M4xjCSm3PTZQ4eJGBZXsztKholTydE6Ol9I
         2rLEjcYc6YXyx6ZoawEpnkUum4iTjomLTNV5aIKlNW1v4R7mqAvdByBlDx1sPkRjA8TO
         ley8pKjWLPTZIeeEi9DpeQz652x3NxiVU2Llf7rtHhFIWIuBXzBaANynNCs8hmZ9mLb2
         gypQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZJlI2zMUV4l1Y2jHFb2JTEGfRPKj4vry6xZS4fzYFyAvvXd5yjydbAIj13K4wnhLpRumRSMHlot9JAwKTGXEJ5EuE
X-Gm-Message-State: AOJu0Yw5ABNOCO5uczqt3fxDqzTiIyd2VLAfrns8p4bTUPEer/kQhByX
	wgilBGgUkEm2JpGUGcOSfCYBP6Q1zS4wYdeRkbLfZTgNM62Zgrp7ZEH3ZYXZeVs87egSEZSVu9W
	D/woFoGrU+3EZf0MxuDrIjtfzPNo=
X-Google-Smtp-Source: AGHT+IFscFWlDozPPCHPybnry1reh+x7DCr3Mwqu7vwzaZ7dwu3mBJXYCkJlZfMt20JhTEwmKKK6yQxv2EjGl2eTktI=
X-Received: by 2002:a05:6870:b296:b0:229:f50b:d5a5 with SMTP id
 c22-20020a056870b29600b00229f50bd5a5mr756907oao.5.1714079522616; Thu, 25 Apr
 2024 14:12:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Apr 2024 14:12:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Zin67FKk6XXOotQh@tanuki>
References: <20240412095908.1134387-1-knayak@gitlab.com> <20240423212818.574123-1-knayak@gitlab.com>
 <20240423220308.GC1172807@coredump.intra.peff.net> <CAOLa=ZRk8QR4qkbkRm6AirapdrAqz6bG-tXfY3zRQU_9XkJM1Q@mail.gmail.com>
 <Zin67FKk6XXOotQh@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Apr 2024 14:12:01 -0700
Message-ID: <CAOLa=ZStA8tyA=COVM+7Cvr6W5BmPaesgMk6NSHpr5w+Ve08BQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] refs: add symref support to 'git-update-ref'
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, chris.torek@gmail.com, git@vger.kernel.org, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000001015ca0616f23da8"

--0000000000001015ca0616f23da8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Apr 24, 2024 at 09:25:27AM -0700, Karthik Nayak wrote:
>> Jeff King <peff@peff.net> writes:
>> > On Tue, Apr 23, 2024 at 11:28:10PM +0200, Karthik Nayak wrote:
> [snip]
>> Also on a sidenote, it's worth considering that with the direction of
>> [2], we could also extrapolate to introduce {verify, update, create,
>> delete} v2, which support both symrefs and regular refs. But require
>> explicit types from the user:
>>
>>     update-v2 SP <ref> NUL (oid <new-oid> | ref <new-target>) NUL
>> [(oid <old-oid> | ref <old-target>)] NUL
>> 	create-v2 SP <ref> NUL (oid <new-oid> | ref <new-target>) NUL
>> 	delete-v2 SP <ref> NUL [(oid <old-oid> | ref <old-target>)] NUL
>> 	verify-v2 SP <ref> NUL [(oid <old-oid> | ref <old-target>)] NUL
>>
>> This is similar to the v3 patches I've currently sent out, in that it
>> would also allow cross operations between regular refs and symrefs.
>
> One could put this new syntax behind a feature flag to avoid the "-v2"
> suffixes, e.g. `git update-ref --with-symrefs`. But I'm not sure whether
> this would be beneficial.
>

Yeah, me neither. I mean it doesn't provide any new functionality. The
only usecase we're missing currently (with old + symref-* commands), is
that we have no way to convert a symref to a regular ref while checking
the old_value. This could however simply be solved by introducing a new
`symref-convert` command.

--0000000000001015ca0616f23da8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 465c6b6393d569b3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZcXh4OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1FFQy80bzBXZGxYQUVPR29KUVk5QWhlMVBnZ2Z3eQpFWFo5Z2Y1akpT
QU4zY3ZxdVFZYVFRSlBxUXd1MzNRSWNmN0gvdS9UVHhnNGVPTkR0Z1F2enNiaExDQ3VFWUE2CkdC
ZWkyYnVsejNjVVpTQTZKUXZtTU0rUE14ZlJqU0lOdGNHLzJmTldTZUJKWnl6T1NjaEhnUVJJUmVk
RTFjbSsKZ1EyL2EwOWZiV3J0QnF6bXNabmQ2VWRuc3dmNnZSdWl2Y1ArYzNkcGRNZ21ZSVh0T3VG
MTBUdDFWM3ZZMW5PRwpYUWZVWVFTcytBNHZxSmVoVFFlWXhEQS9IZjJTZ295WmpYT0p0cGpPS1JW
c0JxNXNJbnFISE03dUhNQVIzcDVIClphODZBV3g4Y1VoZlhha1pWcXR3NllheDZJSEpaWDFxRGVU
cG92WlVLSm1TTUZrbnQvR3NwSUx2Mk43WkF2K1cKMFIwSHBtYmorWHJzRHJqUFRZNGlzQWZMaCsv
QmhpRWo2L2lCSndRczV6QTY5MG9SZ0pUV3ZFaUVEa0Z4MzBURApxWjU4NVQrNzk1MjF5Y2daUXF4
WDQ2RG55YnBaZFo2dzZyc2ZhR2lwWDZOWjVQaDBuR3dMMUwzYjIyMXZsWWFyCnRFdks3aWM0Qllo
Zm8zWHloU0NSK3ZuY3IrN0NNZyt0NzFWT09OST0KPUg3NWQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001015ca0616f23da8--
