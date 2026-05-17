Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E57E3C37A5
	for <git@vger.kernel.org>; Sun, 17 May 2026 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038443; cv=pass; b=FQ9hWZCiOwL8LWiocb3575sg5ZQUZcpGEV9KS9nte+spIU0lG00/9+zm4b/2VnQzqZjFjAG6bNrCRj9kwXSxye+Ivr0VZ7uGLTz6ZBH414rf8B4q1Ey/7GczNfIfTJeTWCkq4knOw/9VeU19uS4ETR7J9mQbUVmNa/g3LVZTRBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038443; c=relaxed/simple;
	bh=MDAT01eRfp251UAusryvzehbRCgN9X2trp6K4werLz4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCnI3vrlcwrNBl083nFqDi+Yj5xuKWY0Tm9/tnDC2dRHmTpsrAuTlxLFge3Yo7aEHdcCNJcLRXc3rgIpgnhyEJVo0cwmJXpixRxjuaIFGw2gd20lfxC72VwzP9XXvRXF47ZSGQH0VjkhBXFGSIPT+C5iObeq5pA5JxDd/N2JFec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBc4lnOb; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBc4lnOb"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-628086439b6so1370855137.2
        for <git@vger.kernel.org>; Sun, 17 May 2026 10:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779038438; cv=none;
        d=google.com; s=arc-20240605;
        b=GkBdimnmpwpF2Mc6cR52nRHddvYfXH81V+4TTq1UaQEQZ3mFRz0WWcW0j94z38rciE
         yIMhT8ZM8l3529407/KSyXgHnY5yttoQq5uflZaXw/HJQyqms3TDztHBgHQycXa/vA4J
         N2NxVARjDN4skMpTYaTFm8RwFKyEbOuiALub98m/VWxVad4JcGlXBO6tQmgvM+Ed8T5j
         CinjgMdlpdk4uSjmJICMoBOqX8W+uLCs1Kxof7bsQh/ZqyZvPxpHRhRBPy9tTs3ABBl2
         CRfjkF4bk9NnNWvnRt0Nt1c1auUWptrg1CuhvZFV85BICeelKgR/Rq1e4aKxSjb7zYus
         ZFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=MDAT01eRfp251UAusryvzehbRCgN9X2trp6K4werLz4=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=dEys/+vsoahhKwvNfvPESbAljlOmJXv+z70RiEjX80VmgTg51o68re8JNxmrshTT0r
         tGyLd84BZcXYdAlZVVF53y45bog0NRKNXmYB7/ruy9zLNCGP2czCcMdKpylxdjP0m00T
         kyEjtIoeHA9BaKiseQZifLOuDtzWkJkW/sAZqfMLj2c9Y9AOKTTSfUbqQ65Xw8xEdxoe
         R+1hrbbV1QjKKYvOJH+kxsc9xER9Zg4q0cnDUEQYAV1kDYoQc6Q5PwrScM9fssLX9ONA
         xhNjyhji4gbqxeNLAhSVX19OGStN8vYuUwcaN6ab4UAG4jj9H76F8mT8RLA5LLdrPpHq
         9SEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779038438; x=1779643238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MDAT01eRfp251UAusryvzehbRCgN9X2trp6K4werLz4=;
        b=SBc4lnObzSO6r7jG6vYGh/hJLnnvEYcYgNmAwJqP/5zXw6m2nvQVIBsLhVqZC5tBdD
         43uEmz52tUe8vS/vdQmMuJVcMqDyw3R4cCyaZ3qaM0DyEpnkJzy0v2KjriCjECLA4RNM
         WqYwXV4pUVTJgAaFj08tVQJGk2QVQ/p2sFsqdz3Od8OpVhD0VgDgT59y1S3yAydmoyxh
         3z3uzzyh6v63CXFGDhfq8Sn6pOlY03YOvyiL2ZuS58CDEb7EkiGQAAjkcZGaMwhFqdHB
         m6IBCCALZCsHhseGUhFqzgiAuQAnVKzYtun99mxe91tkxeiie8oCrG4Pw2pCtk9aXLTW
         iVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779038438; x=1779643238;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDAT01eRfp251UAusryvzehbRCgN9X2trp6K4werLz4=;
        b=LBD//idppWZfvPgQr6V+S/nTEO3T90dXQe8RXEzUr5G9lY7T4IWqYvrPjEmqEBI/WS
         nF57GEvaFaoL1XTaT2wJkW4hpWpEsAFSVGfLDMQpaPePVUCI1dOh95BcKC3HYExB3E/7
         B2wWqbNW4PM+v/92rjNfkP8y3wjv2tC0SW6nNNY97FR5rjP1fzoDB+3s4j/VV1sumZr6
         fimz7j0wPLP6aTRWG6vjbaH9LSddD2MkJLoG04GvEjiXEF5MBamahdsv/nGzLN5PM5rT
         2ToapqLeP9EvlI7xt0NtmKcfxqCPI8Pwx78U/S6dZd0PBdL45M3XC9M9RK+r6EVuKF4z
         ioTw==
X-Gm-Message-State: AOJu0YzgXZei2OtiSFDRquQzceIC48HrgM8rdnFi19nM+WMT5uVT+nzT
	0JMAqqgV6rzw4Pvy75tKIkubqnyU7l86SVlZMV0Eo9SJ6ywA5Rrls44o5ekbZcrIcyIhkvtErhX
	mM8OGpt13MKDMomJmq+en7p8Ga8mU+Px77Q==
X-Gm-Gg: Acq92OGWczM/N9/x2cgNLBP4iH/f++fVFl/czGZUiwVVUOLTxJIVJYWdQnrNm6w8DcE
	F9eiwkPw+igiBB//MGckCPwBpYWc8JFUEdy7rc0YPucW2Akv020NPAQxXkFl3mcMJxzGrEnc4yA
	WtR8YTanizYiQoBPhBHVmH9XizDCGU3LhKoWYP2cI1NzVMCD5LVgUBejs7IU5QcOzDfYjFE191Z
	oQLjsHgPRsmr8O8hW9btUTm3zyryxDCSLQJZIyl9bik1H8VamxoMQ6DTAihyqQZFSmGzLqQx2tN
	gnEFzs9E6pMcmi7hHCftDZ1jc4kH1MHun+YNreXY26ErOxD0vtpEAF0BoOfyTG7OR+TVw6xolQ=
	=
X-Received: by 2002:a67:e104:0:b0:62a:1bba:64ee with SMTP id
 ada2fe7eead31-63a3c8016a5mr5942429137.6.1779038438145; Sun, 17 May 2026
 10:20:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 10:20:37 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 10:20:37 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqv7cod2lo.fsf@gitster.g>
References: <xmqqik8tm16n.fsf@gitster.g> <CAOLa=ZS8a2R79+8hD-r1JpJmHUatHo4VEC=ybjf02jLEHWsRoQ@mail.gmail.com>
 <xmqqv7cod2lo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 17 May 2026 10:20:37 -0700
X-Gm-Features: AVHnY4JkmFhOEEOADZ8vraJSFbKRyAT86nSFqJg4auCmS89LvMhabCyAMUisdGM
Message-ID: <CAOLa=ZRMApwja_WoG1rUXwrmEUVqkCcgT-o5VAqWUPVGdG+fqg@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2026, #03)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000025e01d065206aa49"

--00000000000025e01d065206aa49
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Hello Junio,
>>
>> I've not been active on the list past few weeks, did we reach a
>> consensus about
>> 20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com ? Or was
>> it missed, I thought it was in a ready state, but happy to reiterate as
>> needed.
>>
>> Lore: https://lore.kernel.org/git/20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com/#t
>
> I've not been active on the list past few weeks, either, so please
> don't expect me to know anything that happened during my 3-week
> absense ;-)
>

I didn't know that :)

> My understanding of the status of that thread is that after
>
> https://lore.kernel.org/git/CAOLa=ZT1zE+MLeaYE_5jWmNzSvtTTBw3ZAopai+2Ei27kmYm2g@mail.gmail.com/
>
> that said you "Will add ... locally", we are all waiting for you to
> say either "after waiting for sufficient amount of time, there
> wasn't any other major change necessary, so I won't add it locally
> after all" or "we have waited for sufficient amount of time, so here
> is the hopefully final edition that includes what I added locally
> following Patrick's review".

I did mention that I would avoid re-rolling since the changes suggested
were not big enough to warrant a re-roll. But makes sense, I'll send in
a new version. Thanks

--00000000000025e01d065206aa49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4e29a26afda5f78b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vSitPQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2VwREFDTVBQdkxMQnRiTWZJeVZ5UUY1YUxiNG4vcQowOTBZQXRMNVdv
R3YxVldhdTBwK28ybXdMSG12MDQxVkw2bU5EZUkvaThWaDRxQkJ3S3hyeTBDeVJiaEI3L2cvCitX
SXhJSVMyWUNGazluMFEvM3NSMWVTUXBUK3JLM3pPK3VHWGw0RyttMlFaVGFIUWQ3OTQ3aVJnSmVi
eWFxeVkKbVI3bytlaGs1Tk16MTl6T2VPNWRjZGVDcTdkdmtCbkN2WkM4dUVSOWVqeTVjMXBRWGtw
dFdVVmwwMTNGNnJHbwp3VlZGWW8vYmlGUVpIalc5YzdLL0JpdXYrZVVSNFhqdDVCVUYvTGlQVFFn
STdIR2loN1FGZ3U4MEpGY09rV2FDClAwOXBsQzZURnVtbHJScjVNS0tPdGNFRDZnUEdQY1RZY1gy
cmxVNXdTdHlxSk40NzZUM0EzN1Y3UXBOVTJmWFEKVnBlbW1kL1pqb1lQaUU2YnNVZnUwbXloNVdT
MGZZM1J3aEJVSlFORGdtRXM2UkxlaGhnTjY2THA1ZDNqOVY5YwpPcHlIYXl5aDNaVmhpZ0d4ZVRM
MGpWaFFXcHN6Wkx6bWpGNXdMYUNKSms2M2xZWXhDNWthUUZjMTZtVkhOWjN0Ck1GaVNWR09aS01j
aGh4VXJGdmkvOTlwTjNQbmo1Yjczdlorb0VCWT0KPUk2NzcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000025e01d065206aa49--
