Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908E397338
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791580905; cv=pass; b=X1A3tFevVAEPUBJmUpJGSv2KhWeFW9A021EFTDxzwhjzD7wNQmwOai3ZpMYuTrJMMrV/MMTVElkJCxwd67PaPTvnH8vR3i2Pq9oCFin/8/BKkmLJwO+4J8GG+BAA8yW4VgdnJqPDRbSWi8nJTmUfFtQt6PxHKXD8UyJgA3QrEcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791580905; c=relaxed/simple;
	bh=zGi8sMRZa8obfmI2tG4A5LRG9Vn5ooLdfUmS5lwb8/4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XspTCiRGJAxf7Wg9VLsNg3rIdFuKV8btiUCxBtksNYeKzuYQi0AIK+Zdjm9S0vCOcgLQ70yp9/bBNfx4TGHGfhH2rd1QtIDkiHiVQsxPyTgXu6VkjdMx8s5tfLQjQu0NTzZ5R0QrO0vn6FRN0LbWFvkiQJMelvDQ4fXECSeWIcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB5mtkLc; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB5mtkLc"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-78fb1fb9508so2132342137.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 14:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791580902; cv=none;
        d=google.com; s=arc-20260327;
        b=ThNCoI2rDfoyt8IZaAlhh9gJbebqGoSvWfEx1MniPnwDgBLPlrKGxxSfvK6r0eLn64
         TEVl40h2RN+NrnZ0UIyeT305cmeb+xzza5HK+R4Vte3KWRIXMDIrKqB5tP1qI/zo4G2R
         k8KVZJdcB/u7azrQdflPlA9LrnoOdt2UX4Kjyv1RGCsM/d9o3IxNPTVynLI30T7ltPcB
         N/p4Y0ieFdOfQBqdRjhxvYeUtsDUny8xVtk0nlJotVbUjBvxDaWibC51tpiMUq8M8MaT
         T9YRmHKzXjTHQHTIqt6v0HMgRF2PGJtZ4CstNc1U9s4TLeJMQ2hjRy/aOuXig4CrnfZQ
         46IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Z3laEchAqdsgXaryPvRsQxjKlR8xvt9jV8zh8s+HZGc=;
        fh=p8dGKdGyZ7HpwKJJ55CVJP8Mc7CjSHTY4kMSeekFtHg=;
        b=h5kPkd5dQ23AJvhHsXwXvdBi6+p9sj1jaFQV/62A2iJLMPCpcncTTLkGEJjlSh1OCz
         gmb9lKrw8IEsa23qjha0K88dAzHWXHexfgl+RiLf8gA7dxWeOG5qnJJrFyO34ORgp45o
         OQdZ706iNtmYqBzaXUxIAwIrP7gAc1TDpEiu7wWXDOYAA0Ey9HC61zASzGVbx3yRZ+c0
         AdFpE/INYPxtyd1faHgn7pQ9hx2wlkiQjOsqDRkDhNpqE4jyqrbjNQkf72r8MTGICND9
         +gRFa+eI3eNNCRtkDNLCVNYXVfjVdYukvZIRJUERbvLtiqdHz7BY6YFaXIUsnFf4lwKF
         fAtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791580902; x=1792185702; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3laEchAqdsgXaryPvRsQxjKlR8xvt9jV8zh8s+HZGc=;
        b=FB5mtkLcNe5DhU+pI+KXrXY7KQ5Yb0ExfhKkH63jkUzgDXHITCCo7TIZLzIFI/2cZx
         MZuTj3LdPXesaVyJNK709rYp5+EHywydPgQMHud/uVFFU/ILQHGBtCmQc8kNh6hk0/Ns
         toMHvQ5V9HV5bbOBUuqWzoEs1GxJJfqIsP0kiQhXd6yuTb/iLJVciBEpHveKcBVXzoD+
         Dc9BFnfIK0iBWa2jnCwziZ44V4uHBG+R2oG1AyYk+pi8y0TKjb6B2tExCtIlC4K9YNz/
         xrjVHa6i7AIbL8UA/3bV0MdgZGiXNwvpDaLbFsiIz1xJ3D3uFdavmUZmFTFozzd3Up+/
         IUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791580902; x=1792185702;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z3laEchAqdsgXaryPvRsQxjKlR8xvt9jV8zh8s+HZGc=;
        b=r+JpLUXGODb0kj6Aq6k7Avry5AzmfLutjviXPMyvgap8LORsi/VEjayFLcn1Tq7/bZ
         nVUvXPoG2mIxGrVFsm+AebPk2qJEFyy14dZjeYKMMDy5SoeeVGIcESLyA2dusHU7KiZz
         qyuZ8PUmyCrUVWPAF4pOfZCInUFEzvvou+PdYLQzw2mBNH4//rKkulCcu5lfOszu7D8u
         IAMxW9WwNzN5f2+LoTLHCaEArs+bmoFoCeQFpIWFTkEugEyvhfZTQjskod+jWs2b8bJf
         bVeOYfzTDEuBYTE5TiiodBN6kqISomZXYis8N0tRUCWTlfOxhJN10ucGvElU1CuuLih4
         dWcg==
X-Forwarded-Encrypted: i=1; AKwUvBwI9L09qDa0aap9+5xzpGWtDIfdVRw1OcNLYJL3D4nYhhU+kLEuFAF8zHFZnt/JeBS5NAg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeFiba1Xg1RkXCYgIuQiynpBeJRo1fGp0JAHBJH/qi46Z6vVbC
	8DMgOlZIoySKROxOHvMGBKVLW3kAa+9h+R9j0A4ISQ7zTVCPMZEowDpSoVaapck3NN3YKRJtvJz
	1kGXin8U13+k6O8UxxCReLxCCJ5ceZBk=
X-Gm-Gg: AYBFou0DwUI+f1s3LZwm3WN7J5WPbQPfpYk3TY1TIYGb/Z8xkoNa4puIYYB1lb9XmAS
	2ITB81aZ1sdMB77RxHeyQOgTkOegWJvz+QJNatF5QJtxv+3RhE2sIIAQSbAtYp+9DE2QlJo1Z/O
	L7JR7GahB8LOIrFWmznh0Ly4OeRkLLqnY9EUQXc4iUk7f2VjUv2VICVQdNmlfsrvKxlgHXR/sl4
	yyU5fClW/xPg4gdNKhmiXUK1wpubByKK++5XvUdyKeQvjarmDB8qTqWyswCSYX7aO27k0Ekf8RU
	I+He0i4N7jjMynM4vAVisU/eKqhMYYHGyNXA7xAtggoathneUv1oBXtRxsywx8h4wY0CKD6UOfC
	ZlM0r7XcfniINizbZkbRLtmV4K86r8LKVilF85BIjqcA+sA==
X-Received: by 2002:a05:6102:b11:b0:7b5:8fd9:27e9 with SMTP id
 ada2fe7eead31-7cb42386482mr711462137.2.1791580902569; Fri, 09 Oct 2026
 14:21:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Oct 2026 17:21:40 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Oct 2026 17:21:40 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqece02no9.fsf@gitster.g>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <cover.1791452597.git.maciej.ciemborowicz@gmail.com> <asdsIjNEUOpaAnX5@pks.im>
 <xmqqece02no9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 9 Oct 2026 17:21:40 -0400
X-Gm-Features: AclHuK_jYkcM8jcu7AWTQx8GVKIV9eKeoNBpgnmHXmvQe-_qOz4mV3rKdM5xMbU
Message-ID: <CAOLa=ZTtLcSPop-A3y-kOv5h-0D-Kq2P+QUpKTEcmU5z77eJYg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] refs: run copy and rename through transactions
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000048d84c065d6eef29"

--00000000000048d84c065d6eef29
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Thu, Oct 08, 2026 at 11:44:15AM +0200, Maciej Ciemborowicz wrote:
>>> Changes since v3:
>>>
>>> * Rebase onto 6de20f6092 (The 4th batch, 2026-10-06), the master commit
>>>   used in Junio's report.
>>> * Preserve the packed preparation error in patch 2 as described above.
>>> * Register t1425 and t1424 in t/meson.build in the commits adding them.
>>
>> Please engage with the reviewers. Just posting new versions without
>> replying to them at all will very likely not get you anywhere. This kind
>> of behaviour is nowadays a red flag and often hints at contributors who
>> are basically just a meat proxy. And as a consequence, reviewers are
>> very likely to disengage and stop reviewing your patch series
>> altogether, which is frustrating to everyone involved.
>
> Thanks for bringing this up.
>
> A response to reviews on the N-th round must come long before
> sending the v(N+1) round of patches.  Some contributors send them
> after v(N+1), or immediately before, but the proper time to respond
> is soon after receiving the reviews on vN and having had enough time
> to understand the comments, before starting work on v(N+1).  Only
> after that work is complete would you send the new patches.  Hence,
> we expect the time between vN and v(N+1) from real contributors to
> be measured in days, not hours.  Whenever I see vN responses arrive
> after or immediately before the v(N+1) patches, or worse, no
> response at all but just the new patches, it smells fishy.

This is kinda why I stopped reviewing the other patches [1] from the
author, my reviews were simply met with N+1 version of the series. At
some point I felt it would've been faster if I used a LLM locally for
the same task and reviewed its code instead.

[1]: https://lore.kernel.org/git/CACQ=SRGTTdQ+dHXhN6F52dBv5KxZBRfk_Em2fvmEmGJDoB6oTg@mail.gmail.com/

--00000000000048d84c065d6eef29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: be6da53d082c3563_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ySld1SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXJ6Qy8wVVBzUTUvTUh1Mm56Z0pFZ1UrSElQRzRMdAp2a1J1N3FvQkFO
b2dSZ3ZpRUhzN2tEeFlaNEdjV0YyaWw4SWJaZW9FNnlhOHZmL09SNmc3NXB2RlNjSzNicTlnClhU
YXlkYzQwNEZIaHJOOFczQ3dDR0wzZXZHVk5VdkM2UGFWN2FCMVlHSG91bDZsQjBZWlFVZ2ZaSFYv
bUVDeW0KMFgwRlA0RkNrTmJQRnhPbWxzcndRQ2lhV1pLTkYyV1dnZCsxL24zQlVjZmMvMkVmRFIw
QTZmM2pvNUxsQ2hsRwphM1FjSHhYUExZL0srcWRhdTJPQjJJVlVzdVljbXlWSk1sMzJiYkFtUGFv
ZjNHQmxDQUh2bzRQTVV6bGQzYkpXClRndG9NOFFHeElXUWowKzZRTHZ3dUVPbnRUUUloU1pTdzJV
T3BDV0FEbmdvTStMNXZSOGQ5V2xkOWtPUmNKNmgKMG8rS09Zd2phWnc1V1lQV29WTGEvS2dzNFUr
RGpXZHFIemJ0YjN4R2Z1VlBwV2FpRXREMDdKQ045eWZtOEQ1cwovRGxtWndVNTJTbnBzdC9mVWoy
Vm9ZNW1PYnA2dGRxaCtaWjF1Z1ZyVzI0S0FWQzZuU1c0NjNoVVBtZ2tkZnE1CnA0YzExRCsySGpw
eXJDWUphck53TTkrcHdXdE56UnE1NUN1WEtzRT0KPU9la1AKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000048d84c065d6eef29--
