Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D23876DE
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315998; cv=pass; b=TQYMXN9UsizHNPgnA2Oabx0csjsmCPVy7rjgzylmuxUaaYQyGrxiuPkgbmcus3wcH/w89f9WDRAk2RY0I/NAB5kQDDOK/dEU4RupQAo7ek8zM1v7V2T3mlnXOgmFBSwMEPIxVV5LLLXb1W0CCx5Qwzgs+Cl8VFcUOBUMsWNtq70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315998; c=relaxed/simple;
	bh=KG7KvwDyTyU2VFcMkLejK7q8tdcrWnu7ke4T8cWU558=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4jnlFyFtMzunUkHq3h5rSTLGXhfX0f5M0sbPhKqZqPhiLJi+Opkt86T9sRey21LVQ1WcKBPJQyj/OfdXu0zHuhLEOnlzRAzh0WRyLKj8r5G0NNggOX6ByLIIRz/p95zml7JFJzG3jPnpEu/9t1hX+xA1I8OebLtWTsniA2kqWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrqWF0dz; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrqWF0dz"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-97c61a96a70so490495241.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 05:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787315996; cv=none;
        d=google.com; s=arc-20260327;
        b=Skth50h8gmT3yt9q5E36t/yBexHJE41abHZeKRxOQyWL9+ir7IQU78y05Gofwv3oz3
         ABwHL1zaCVvRmuCy0qE2BoZTtwFnXKuQZM6kbbeGsPCWkfR4jsbsQDSKJ0Y0gRSajMxp
         +SbVFZYJUi+eKQNWIz2IwsnC2gfGeR3eZ0zIkTxBM58f6Se4OYM/Sdfa1cNFpCXp8zqT
         3wo5MHvlshFQG8DMcLhJ4S0gLsEC1V31kdQzTPYWNiXSb3Z7YIH9+B2jkjPGrelpVlCv
         9nlNGrKQK1ufVXw9ihjAZ3zsfEikP5rJ7jqW/3vFaYr3SFGBF8PQSlj/xrOfJ7x/zeXo
         qDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=1lOvFxhuvbLWOd/TYxHuZ2dTNZgolzwRK/Ze2diYwfg=;
        fh=4ryOG4wBbIqKixWzeKd5dc717SQGdNJth+KYU2DAukY=;
        b=riO6ad9lG+YoXFwuHONAJgzWq4ilC3GJoGQk3gaNllKZhHf5ojGsfGvv1ZWi2Ij6D5
         kox0YzoFODDD3OMLkxLeGE7DhhDheiYdm3jgnv3MYm62A/tR/mSmrIWoTAUMEzqj4nqI
         ZUnfRg/oUeTDogF0AJ8WIVE7fcWFgMs5x0ZNKzj6e2guPy6hf5+mUx3klXvsziwDmwy2
         sAdUqX/ZyQUxVHNXD3/ub2Mlyi2BDxql57q2eAH8LOzBPOxmg/AVzVgOiTni0WSR1Mqk
         LoDFIuFJfFLjLv+ER6bqzmKo1GxFQsz1LEk11+92tg/UWH8ZXt5P4rt/Df8RjPAT6mb0
         8sng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315996; x=1787920796; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1lOvFxhuvbLWOd/TYxHuZ2dTNZgolzwRK/Ze2diYwfg=;
        b=WrqWF0dzN/IhgFIm7+KI7m77WFd7Z3gNWLEcV8D8JcX/Z7PmV2jUhXAAsKU+ZtIk5U
         Qck4IURE2DFPMcDOWYII3ul8VKdwohso7j7yM0cOI2QId12xOIjac/xOU0l5EcLjXNVM
         wgjidGViR5NuyEgVHlF/alBDfBm5VzV7oaQEwS7kOuvTn6PEQeo5GN1GRUrR1v01J7GA
         y1z2P9GNvrjgLMlWEx9Mt5VXN2tumfJSs35+5O56i1i3qeDIo7/f4okIh3W876Q+MjXe
         i4LOXxQHuqigoxfsA50ZRQZ7S1yD/g2a/15qls4oBCwzqQt2ByZgLY7rm1afP1+2jJaW
         tJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315996; x=1787920796;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1lOvFxhuvbLWOd/TYxHuZ2dTNZgolzwRK/Ze2diYwfg=;
        b=S/jDnUkLKl4lbgxznbj/3pdZPBxGz1e65c/542XxzYqnrlSYdPr86kTo2xeUY/5ntO
         nyGWUbuamzskPP0+S0KMObI0sOq0+AeeqqsVmvpfQyV+gphB7B30nNIuLIzcVGt2Lbo/
         CNIEyGpNVThvibsLfx6LGLgXIKitRvKN0RitbgfmcHq6Dv+6tPxKprq5VLY52tTC7MbL
         yCyOTJRp3ZM30yzezOHy6bJvDmp4897ZK1KrKiNI/Ny+IyOsV6aIt8XCfFHyF1syAqw0
         9UlsKa9DKVhOQHtS4qJfnDVSzriFmLP+6LL5xvB85XzoXXkL9XMpoUd9Wth3HhzvbBEd
         +yMQ==
X-Gm-Message-State: AFuF++nuCFdYNX+FnQAgQBkSPllatp4cXZYB9CCn2rw829R8Ad7mOQ2g
	4jPFpE9o+wMWliZ7Yx87XrovgcHB4ZFFYfNRIUY88ZKYhSKs1IIYmnbgtqyxgNyNLZbP1R/TW5o
	4w3NcQdbakq7vGMhQoFHur5URtZ99cwo=
X-Gm-Gg: AR+sD10N+JsRBtZ5+UK0FJ6qrcqkQIDQpZJ0/MUigiO8xxVD5XKAkL9oLYoY54vcA86
	kw9eAJsaofrxrS5/Lg5qvMAAXDD2TWcbPfBckx87d3eEqgOX9MzcD3seX4i6a9IYuWDEbrS9Se2
	hZ2+4dFA0f1YNmmERU6o6zIE1B0melbv7a45SPaZdyVZjMT6oEMBjOxvwwWS4o2eI3WWa4cJ72b
	JMANpq93JZ3vO3Qo7eB6xoaQtqTTXsozVyoXPG6uBguNOAsrZfH+hEeaeOE5Og+/nhvqKKbLiAA
	ESOabOhuGGqZ0QimM/uANfYEFQU/tJG8uA1XXm9iBZQtmzECBMl6eHeX9IdAzZgwAa41OIQSQWU
	ihQ==
X-Received: by 2002:a05:6102:e0a:b0:778:f8b1:ba8f with SMTP id
 ada2fe7eead31-77a8468093amr1102577137.1.1787315995807; Fri, 21 Aug 2026
 05:39:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Aug 2026 05:39:54 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Aug 2026 05:39:54 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aofl8e4P6BqJaQEm@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
 <20260819-pks-odb-generic-corrupt-objects-v2-3-a984e3a0ad6f@pks.im>
 <CAOLa=ZSSzR+qKh4Do-F7xZQMO-pE+t4N8qM5hsbfM4Uh7i3d1A@mail.gmail.com>
 <aocNsR60-8W2A-fy@pks.im> <CAOLa=ZSs-9VU2eKT8DUJ7FzZCAkgRzZ6_XQZBP=x7avxpFp7qw@mail.gmail.com>
 <aofl8e4P6BqJaQEm@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Aug 2026 05:39:54 -0700
X-Gm-Features: AcwNN1XoR_beSCcMIqp6gOUevDCFgU_yb5HLAbW_eN2cPDxh0fH5e2RM1BOrVJM
Message-ID: <CAOLa=ZRPudL38f9wTZoRNXLPeEpX5OSC_kaQyG1xgyNNriruMQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] odb/source: let callers discern missing and
 corrupt objects
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000000837c306598defd0"

--0000000000000837c306598defd0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 20, 2026 at 05:09:51PM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > On Thu, Aug 20, 2026 at 08:56:50AM -0400, Karthik Nayak wrote:
>> Oops. Thanks for the detailed response.
>>
>> I think I made my case in reverse, but my original argument still
>> holds.
>>
>> ret_packed   ret_loose    ret_packed != NOT_FOUND ?   returned
>> -----------  -----------  ---------------------------  -----------------
>> NOT_FOUND    NOT_FOUND    false                        ret_loose (NOT_FOUND)
>> NOT_FOUND    ERROR        false                        ret_loose  (ERROR)
>> ERROR        NOT_FOUND    true                         ret_packed (ERROR)
>> ERROR        ERROR        true                         ret_packed (ERROR)
>>
>> So since we return ret_loose as many times as ret_packed. The comment:
>>
>> > and prefer the error of the packed source in case both reads have
>> > failed.
>>
>> isn't true entirely. So isn't it better modified to something like
>> "prefer other errors over not found errors" or something. I hope that
>> makes sense?
>
> But we don't. As your above table shows, we return errors twice from the
> packed backend and only once from the loose backend. And in case both
> sources returned an error, we prefer the packed one.
>
> I think where we're talking past one another is that I distinguish
> between errors (-1) and NOT_FOUND.
>
> Patrick

Yeah I figured, plus this isn't significant. Thanks for humoring me :)

--0000000000000837c306598defd0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b49ce952b476056a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xSVJ4Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2hjREFDZ2cxdWJSSnNBUUwvSHBzdW1wTThEYmVhcQpwOW4wRG0zai9X
V092MkNtT3NWYkpTWHNDcDZNYkNSVXBMY0lkVEczZ0FEV2NIVWFEUnZNM3VBVUVWU085a1U3CmVo
STZqbDJSY2E4dTR3Y0Uzb0ZVUm4rMmFDVTljVi81V3I4M0FZL0Jtb1lGb0F2OTB3eXRid0lyTlBx
S2dDME0KK2RiZG1QdVVHNFpVOVluc2wrL3FvTHRaMURFMjNvUGdLMnFrZ3pBVi9tTklEa1p4Nk1G
NUtIeVEzWU5YMjAvegpiR2FpWkpIQVFiYlJmZW9NS1RJV0swMG93Wk1paWtjaGc4d1M0N296bU5G
MHQ1ZlIyZEVJZ3Rabnl1bjdSMXBRClJtV0QvSWVQL3d3bjRCc25pazA2UkVZNG5ITlBYWWtzZkha
UForaVVSNk5lSmhLclVoVXBLR0Z4aGNFNmFJa1AKMDdzWVUwQzlTcnNqa1dHRHcwMjN1aHdud2Jj
ak5GaUlaNEF3QkdHd0dHVFFqbHFpWllsZExac01GL3d3a0NoSgpxcE13VTRDZHZ0U0s1ZE1KMzZF
b21IajdNSmNtZEVZMmJlUmo3SWkyNVJhLzlGWFBWUHpFMm1xeU1sckorNDBMCjYyOWZ3dU9YNms0
MDR1LzRSNSsvZ1dUWkg1Wkg0VWEzUER1Q2ovUT0KPWdmYkMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000837c306598defd0--
