Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EF52F3E
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846183; cv=none; b=dKYGyRjujZiuTqmJlp/jIk5DtyBns0CjhPoRPUv55iI0TqtfHf8aelOGKZAxb0yGVxjJAuD+pdISp2DUT5ggkuutt//apLGTdTJT5E31Ak/7NyCagi8ZZYD2pBhBFD7Y+w3y/zAqa3QKQNL82WrXVmH9rIBq7GfL0ZcHSNKO/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846183; c=relaxed/simple;
	bh=kJ9D7l8Apw9lD7rZT0QwqlUQww2shn+PDm8X7OgmwcY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5+crHIQOOxTlnvisKrk8owVhKdZNsdD0NBmlfrNyx1ChlSsKedye4izkB54ZyTAGl7guL+RQLqxoG+LCFkscKgUMjKg/hW0WbsmXUGk4t05E+xST3Y+A2zEtMVh0nbRYZ+hwYirUtp0dNLNTjGM/swX0s3CeBZUctKcUyCoc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhUKI5EC; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhUKI5EC"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5240a432462so4562659e0c.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 12:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742846180; x=1743450980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fF0IuRgsP95b3nsyEkwq8kVgCsnfhcySFeczpILCvIs=;
        b=RhUKI5ECpoAKB4wV2PmYjnsApLkr5zR2PAmjdKREhXv/222Db3dHt2XyNh2wRQcByt
         A1mWZU2RNgBnOLzHlTpiD7BV0QZSS5yaM9WpcNNRChzxaqR/xfzwYu5V+LNF9qt4dcTP
         DpOP7T3FF4GIoWaTLelPPXrC+cCst6nwl+46IRjw4eZqvPadNnj32UyfZIvYFsyN9R+V
         wXiIA2g5hqD+AZib+9TcdbZfFxaUT7WS7Ab7xnOstZZ63DvtBXAf+K9s91VntBbWXGCj
         JNJNZ9fvtFAmpjjvsnPPrxa/qIAsG6R6Bl73Zwd3wVp+y9OxuLJfsOq/NzGtinWxVi+z
         EULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742846180; x=1743450980;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fF0IuRgsP95b3nsyEkwq8kVgCsnfhcySFeczpILCvIs=;
        b=Q/Zwy6f+PlNUdtAqRdwIQ6g+TEkBwciG7Ak8Ug05cXBfijT5ioKyWJJwBy8TQ9sTdG
         olmLJXwXbaPg9y1f0a7XC9j3mHqco14cKzCmV6nN2M6g/2r8KCHc366VVEp2pwqXQMQ4
         7xaef54kTz/9Q5x9R3tIroFpR4jyRnxkaIvs1ylOoNPpcQh45NbdC7CUS6ntSBpVSCm9
         217VGj94VYXb3HW5xfeIIgT7C2a82LemxzebOO6clgjJS1ehmJNsYO5wXBx1S4jsJqAV
         e7w+TyjWwvK4gYp/yDispB6mQb3BS3R0H7NSin7e567vXSeimaw7Cwj7iYFziOnEy0Fy
         xN9g==
X-Gm-Message-State: AOJu0YxnyAq83k1TGpi4lqJ/iMJ8dPnI07pICFWIJZN1UK/PAl0ULirl
	NQ8VLbcY3ACZvI701JU9NvD6apbAGnsxMSMuDaw0nxASVaFBpB06ftLEoTeE+RH7PeS+h9Rwgpr
	UXF74VUkBpWyzAILH4Tyd9/K6Mvo=
X-Gm-Gg: ASbGncsnnhEgHdNrtX/I9GppexDL9qKU/OEJieDhHrlZNECUXNfKCthbytvr6eKxOGJ
	2DX4lEM8zRHNtzsPH6O+3xutjeUXl4oJAgOHL8Oxxg0ZIqV6h3CePLJxF2JBVou8UUyFw1E4Ff1
	0hSejgVCBPwAzyXUVq5OzDv0MpimO5FuYA9nWeSETe/dRL1Vfpcyc8Q1AuNKQ=
X-Google-Smtp-Source: AGHT+IHxB71ZO/oKUahZlfqhqBp0Z4XkKW+nf4Tk5EtrFfCXjCAKPYraPmhkmB4x3Bf8XtEfRaII/7uZUE3phfhrPtM=
X-Received: by 2002:a05:6122:1d50:b0:523:6eef:af62 with SMTP id
 71dfb90a1353d-52595e5b272mr12572821e0c.4.1742846180329; Mon, 24 Mar 2025
 12:56:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Mar 2025 15:56:19 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqzfhbrb78.fsf@gitster.g>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <xmqqzfhbrb78.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 15:56:19 -0400
X-Gm-Features: AQ5f1JqV_vCxD2T4LEy4kCQONAgPj3Qt8CW9nxmxweKwfUmR68jzHhjq400317M
Message-ID: <CAOLa=ZR9f=TiZ7ezNWOMwTqbkjiBYa_4B_zjiA8jBQ4nkEgqqQ@mail.gmail.com>
Subject: Re: [PATCH] blame: fix unblamable and ignored lines in porcelain mode
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000007a389406311bffed"

--0000000000007a389406311bffed
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> However, this option was never extended to the porcelain mode of
>> 'git-blame(1)'. Since the documentation does not indicate this
>> exclusion, it is a bug.
>
> I agree it is a bug when people added ignore or unblamable support
> that they did not _consider_ what to do with their new pieces of
> information to help porcelain writers.  It is not a bug in the code
> per-se, but it is a bug in the brain of these people ;-)
>
> But prefixing random garbage to the commit object name line in the
> porcelain mode output does not sound like the right solution to the
> bug, either.
>
> When enhancing an existing output format, make sure that your
> changes will have minimum empact to existing parsers that do not
> know about your extension.  It is reasonably expected that existing
> Porcelain scripts reading from --porcelain mode output works by
>
>  - Recognizing a line that match "^[0-9a-f]{40} \d+ \d+ \d+$" and
>    take it as the beginning of a new record;
>
>  - Collect all info lines before the payload line.  Lines that
>    describe per-commit information are not repeated if it is already
>    shown, so remember them when you see the commit for the first
>    time, and recall them when you recognize the commit you already
>    saw.
>
>  - A payload line is indented with HT and terminates the record.
>
> If you start to add unrecognizable garbage to the line with very
> well known fixed format that is used as record delimiter, you would
> break the existing parsers, which is not a very nice thing to do.
> Are there other and better ways you can think of to add new pieces
> of information like this in a way with less severe damage?

Fair enough, I was having this argument and convinced myself because the
option is an explicit setting. So users who have
'blame.markIgnoredLines' or/and 'blame.markUnblamableLines' set and are
using one of the 'ignore-rev' options would be expecting either an '?'
or a '*' as mentioned in the documentation.

Let's me figure if there is a more backward-compatible way of doing
this.

--0000000000007a389406311bffed
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6c228a793c7781a6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1maHVPSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHV0Qy80Z3A1Y3d1M3VaZ0VaWmZxcmNQYTE0dm5lUQpjYWh6U3c3MlRP
U2R2VzJuSTcrWER3cmlmVEIvODhOK2RLblc5U2RleTdKY0poYUhoMURROFlmOTFUVVV4QWpMCmkx
NitHdDlPMksxMC9WTTc4VHpXcVl3ay9uWUdzME1KVGR3QVdKbUdUbndiN0pkekdXTlZHblQyTHhs
aFVvR1kKeC9Bek5NazA1K1ovVUxhdmNDUHpNTHFucXVrNStLTkdQcVMwQ1FYRlk1cVNxWU9MQXhK
LzlUdFV2MVNrRUg3TQptN2lBVVQxYml2TWZXMUs2bG5WVVhwOGlUb2xoOUZrTGIxNnBTT1R6YXRL
aVlHOTRPRG9CVzI3VEJFd0QvQkhZCnR4cW03NnJ0QW9taTZLaTMzMTNxVzR6U2hzTm16S3VlbDAz
dFAxSUZOZ2l5VHU4QTFJN2FzRGhwV0ZwVGsxNUEKODVGK2NvcWJCSnBtRGpaV0F4aFlLWll4NUNn
MER2YnFhUEgxR2FNY3Vucmt2dVZIZG1DbUJPcmorTXl1Q21GRApHcDNnUnBVZWt0K0FhTVFNazF4
WkpnOU5Yd0ljQVprTC9XU2QzemRqZHBhbnBKWDU1cTA3KzYyWmlndGE0ZXdYCmt3N3ZzandUTW1i
b0lsK1lkSGVWNGpVR01ZRTMwUi9RTEVwZTRzND0KPXZ1dTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007a389406311bffed--
