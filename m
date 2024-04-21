Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596EFF4F5
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713715077; cv=none; b=oXhUAKTDcKTeYuq3sozjtik6KAjQiXI2xZ83QBjPopJwjabQzdZQy79aRRUlDTuPuZYFR1tMW97nuvJad8EvKpgiq7UjNfLLVaeASyCTuiDBc/dwCVzmMdcnTnhDt2hzHJ2wSrrP5AXJSZaRRw2QagcNzgQLAmN58tl3QKn5Hg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713715077; c=relaxed/simple;
	bh=HXlk1nf0+/BPz1Tky5Gf+ml1hd1H2R3MU/EDLhiPNMU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLbBV0nT2Uhsx8gWdSalsxMzXfh3Q8K4W/ceP6XwXNizRmfHnkyh4GhhfOv5wTRHSvLdJqM+Cv+M9bDY0jVFo9WW3Nj/GLh39UOvGXsEyQshh2NXiej4GuEk6i5ARnppW8J/YM4/Hvcp6YwhGKLlEFBQlS1/xrziTWgCzRbivvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyHrJTSx; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyHrJTSx"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa2a4dd0ffso1699543eaf.0
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713715075; x=1714319875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvEdc+o7F7LWrbj6VY7gx46skmKC2a8dNVw0oIMUvcc=;
        b=NyHrJTSxSrSUBVYKOzOcG4XyHUWwaqzbZnoAispVsIOwZRmZLDSH+9RUJbIt7eQPqv
         fFuMROWEY+W5S6HWApYMNEDgb4ggZIeme0EU2x+DZBxopXJkv1IB0oloXRF353gNjLKU
         6VF0rXYuKd7sFmTycJ+g6QBpIya3b5/cAzMxSplSZ/tPPIASde3aFMh6hUVyy20N3NJr
         2jYzjWSxU2q8vKSNY3hX+BYppS+MFBKSX/9WKKMjBujAAbOnzK3THDwuHZ0wPe2pwJbs
         AVRcA6X1QNN5nVOlste2Q3I6+u2hGBqldGB5vI2QCldP8d8KYVuqlRp3csvu6uCq39ZC
         BJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713715075; x=1714319875;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvEdc+o7F7LWrbj6VY7gx46skmKC2a8dNVw0oIMUvcc=;
        b=Q5+rOor2HeK1dlO/1R0f00DZHlYwn60M94T8aZaRwHZFqR1Vi4vu2dKKGcsBCT6Acg
         J2sSdZlk6jAd6CHKP0vR6TuoetyLKYgFUtDMb+Q6OnNlrtyhn3JjESIxsRoYqX53Fqeq
         xBWIvEV8pqQ2OpI5AuD2wxPzf/t9xLH26UXj2GoodFb5yuCJ428iDZgMxD8aa3obfkbC
         AO5FE5QjS+QdHY+vyX8EFyrf2IQrSijFADz6LlEpKiVd/3PcjNuZ5cSZ5jvw+7RkVYLG
         3RrUX/wS3ZdPaof/kSccEnwQkrdXBvfAozvukxufBxjfLZ8SRdCTELiRxD/bniNbsKMJ
         zRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZrbiRNPOWjexVFdRihw39i5Ju+66Usptj2LeWrwIavM5HPb12fScAr8YrMUskX1KHl8OW/ltkmij8kqBXvY2Q8M1
X-Gm-Message-State: AOJu0YzThIeh6F7dk2qZMEFgsxGBXowz1ur+nD0IpmZjh7iAsvR3ELKN
	5U6ArnrLFydKhPDfdpXi9MQpc2PWR6xwTfCH48smByb3/i+uyn5dLZAIJKqVEnBo6WpmPSzUNJ5
	pQa44d+aSuBoNdXzQk3wEVyjK47s=
X-Google-Smtp-Source: AGHT+IGtASezusOURhwmXkFORj/dfEd1pybxbYqzUfAIgHJJ6KPqGSrNYl/bN/U74Ni0w+7CygNJ1B9kUnu9xSFzXK8=
X-Received: by 2002:a05:6870:51b:b0:222:8961:43fa with SMTP id
 j27-20020a056870051b00b00222896143famr3233687oao.15.1713715075182; Sun, 21
 Apr 2024 08:57:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 21 Apr 2024 11:57:54 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZSvx4bOmJY+P5j3fJTqfjY37teMHQhOYDjTM4oJtnv_qw@mail.gmail.com>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-6-knayak@gitlab.com> <ZiI8GaGupNzbLqnE@tanuki> <CAOLa=ZSvx4bOmJY+P5j3fJTqfjY37teMHQhOYDjTM4oJtnv_qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Apr 2024 11:57:54 -0400
Message-ID: <CAOLa=ZRcXteRGQa82aw+WxfxsufrU2R-6hr7XYu9-SqjtbaS6Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] update-ref: add support for symref-create
To: Patrick Steinhardt <ps@pks.im>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000004d9b8806169d62b0"

--0000000000004d9b8806169d62b0
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.

[snip]
>>> +				/* for dangling symrefs we gracefully set the oid to zero */
>>> +				if (!refs_resolve_ref_unsafe(&refs->base, update->new_ref,
>>> +							     RESOLVE_REF_READING, &update->new_oid, NULL)) {
>>> +					update->new_oid = *null_oid();
>>> +				}
>>
>> Can this actually happenn right now? I thought that the `read_ref()`
>> further up forbids this case.
>>
>> Patrick
>
> With update-ref, it won't happen anymore, because as you mentioned, we
> use `read_ref()`. I thought it was still worthwhile to have. But I guess
> its cleaner to remove this.

Well, just realized that this needs to stay because we also want the
resolved OID for the reflogs. Will modify the comment though.

--0000000000004d9b8806169d62b0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9b77b54d5c6d83a7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZbE40QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meFN0REFDaHZBTllOdzRYNE5wblhHS3dLcFd4VE5RcgpwS2lRdy9EcTcr
bEdSbmZGZ3ZIRGdqU2dRcEZ2RmZqWGE1aGJyZjRKeE9MWi9XRmdwR01wMDFzM0t5UG1zNGN6CmpB
ZEwvSENheVhoTXdPQmRBZlBNa3VKZFhhK1l1QlhpY21BTWxFQlJTY254RzFNKzMwcWJtdkJNb2g0
T0drRzgKNXh4L1JKcExFR1pZdlZUSGptdXhqSDAzWTRMN3JWcU1vQmRqM1NFV0ZkL0xOSm0zRjRU
R3dyU2xaOEdEUlNuRgppUE0zc0VFS2lKam93a0xGdGg2L3dGdEZKbmN0RXZBak81MzQzV3JTaWJH
WG0vNzJKbHdEb25wZDBONUw1dXBaCm9vNXNOUGtWQUY0ZldKWkRHbzZxK09sZUtNa3B6N01TeERL
TkxHUlQwdnIzeGNDWkxkRGdBL2swWGZFRkFEcEcKUjNoQWxMeHBrVUFjbXJnKzFKZjdZc2F2bjRH
eVhTY1ppeUZtU25pck5QbUNtc2ZnTzJKUXI5dFR2M3ZjcWJaMApqWnVLMXAwaGFEZ1Y1RmVWRWdW
eFBHcW8wQXlQQkZ0V0NrVSt2aTNadzNqMGMzVjJXV0pEWVh5THhwdnRvdng4CnIwQktqbExOckIv
Um5UNVVndjAwNWhqR2RKWnArSkE2UWpscFRlND0KPVE5ZFoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004d9b8806169d62b0--
