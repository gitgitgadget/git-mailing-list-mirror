Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A2AD55
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720459637; cv=none; b=tG23IL35Maegq8YV/kYBCJtavOGZ013mxWeIIDnRl6gHwHoHdZnufvMIPsc91fFX5/KY/7kzwjxrclDYrx+3C2JLJRpDg/2mlIFNv9WIG4fisQlLaDnpg7CPaWxOxm4Y0OMZsrdPEDClP2QgL09WQItu1FIiL+WjH5lzKtYKmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720459637; c=relaxed/simple;
	bh=wIYqrwAkVwqjCnUgUds9+m9inZvIMmRulymivpi1gek=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDi4auUbvtKEJiNssLmkRLy6/KP3mPdOSVNVaQVjD34I1L1odv6OHNX3HjbMn6Kdrh9+7938zXcTibc9fXPtF0h+B03WGCKIceyvwkgDEiKU1BvCBti3ud0/hrwoWElHNrz3qAVfPqSyxQw0jVPTS7/JB7fxoPObZpeaEW79vaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa910W07; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa910W07"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee910d6a9dso38834781fa.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720459634; x=1721064434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wIYqrwAkVwqjCnUgUds9+m9inZvIMmRulymivpi1gek=;
        b=Sa910W07ld/EqdFtrtxXLQiEoUUo7ljTbYsa3G7v1Plyb91sh+FkIpszbTAT+De0qh
         u4r/mHzlx3d5CpaDEnWC9sm9bT9LiZdIOFQDJPLkxAVlTUvCAIV5yUXGpNwAoUAdyYRH
         XsC/hpe/rGH77FpyEmY1NpJsvgExuW/IjzUJbQ3qdHokaWOn2oHBCEQmc5fbhPe5snGO
         PyyalVutIeQiAY3Nyn7f8Qq2smL4zacsp2dwxgmCQmgUm7u0/9KpQdb7S+OnOBmckUZv
         Vm3/3AND9iwT9amOCjiWA4BukUb/4MCWYv1r0BPLhTeXTb9AQXJiiB+S1ld3X5Rpt4fb
         JIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720459634; x=1721064434;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIYqrwAkVwqjCnUgUds9+m9inZvIMmRulymivpi1gek=;
        b=UCnSm+o4wRJJ6y1atW0QUJJoUoM+eU6aDXTY+/6zbX8j2HFcrXymSyk6B5BNxJ/ITs
         moMkH/XwXZaonJ83IzVUkKggMfVSC0qYPqLD9TWIRV3Zgqso/gpiSW2cR+oOPdLHB2eX
         4d9NweniIJcnn1lWawEM3FaAu+RhQDsqVTjr4fii92dE/ELy3mA7jt0O5wHES91NwV5G
         OeebCo42M0j7wbIW0u6AP5+RLmE7XeD3bsNZ/M7/+i4TBWDr3pWG2JicVppmaW96VX/+
         IV8rocf6IoewnkkMzM1SX4g3sH0Sze2fbJJhZHMv4LAGJrMpSx8FumXj0g3QzFag13Fg
         dzaA==
X-Gm-Message-State: AOJu0Yztyx6dAJ+2oWIXvi6l6XApJ8DYrrQcpeioVambtZ9Ws2BVaT1y
	/MXrqvJvUbwSVW4zJ2//RU7aKrYGAJhLQWxU+rk1p3AcECxZ/TFR0VXFTK8AuVI+9AJPuO3wCyo
	/TxFdQ5SuxgNpDM7CdgkIItXMDJY=
X-Google-Smtp-Source: AGHT+IF474w5iATS2lI2eVsEYQ7AaU7150lU/QusZnE78Xrh35gGXDy8t+u7+1e2Qm65XSGQAPRUIIRsR3u42xAloQU=
X-Received: by 2002:a05:651c:509:b0:2ec:5c94:3d99 with SMTP id
 38308e7fff4ca-2eeb30ba291mr3466641fa.2.1720459633550; Mon, 08 Jul 2024
 10:27:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 10:27:12 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <saa7uz2ovecdwg4ruhnusgebmexocq3qinlp5x5oz5sb2a3vqp@v4iupsp2ovwh>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-7-karthik.188@gmail.com> <saa7uz2ovecdwg4ruhnusgebmexocq3qinlp5x5oz5sb2a3vqp@v4iupsp2ovwh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jul 2024 10:27:12 -0700
Message-ID: <CAOLa=ZQa7NgTZrMMM8eEEy3Q7E0TohLbHPA=bDwUN0-3u9qLkA@mail.gmail.com>
Subject: Re: [PATCH 6/8] clang-format: formalize some of the spacing rules
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="0000000000004f022e061cbfb967"

--0000000000004f022e061cbfb967
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 24/07/08 11:23AM, Karthik Nayak wrote:
>> There are some spacing rules that we follow in the project and it makes
>> sen to formalize them:
>> * Ensure there is no space inserted after the logical not '!' operator.
>> * Ensure there is no space before the case statement's color.
>
> s/color/colon
>

Thanks, will fix in the next version!

>> * Ensure there is no space before the first bracket '[' of an array.
>> * Ensure there is no space in empty blocks.

--0000000000004f022e061cbfb967
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4d1700dd07a30b8f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTUlXNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlIrQy80c3FORDlYVmZoU1lNbUkvVjdHUERyQ0Z3cApURURMU0VZQ3M3
MUQxWENnK241TUN6bjhJRjk2bTVnQ2lVOGFlVkhGeTROY0VXOG0yeE5MQjBTenl1RVpuV1BKCmdn
cW9EeVkzWDExSHJZOHdHekowQ21GK1BUNTNoREtSU0VBTmRGVVdjOGFmaGQwUFIwR3RMYjBmWStv
MGZOWWkKRlhtZktJR3BkLzIveXQyYkJEMWI2UnNWZzd5RGY5NHZvWThOL3NkQWNKZXg4ZERPRTRG
SnQ3eW9YSi9XRWQ1OQpLbk5ER1NxNzZVdE9ycmJvQkpXVzRkNXRMbmNqbkpTSXdJUnUyMkVEelhS
em1adFJnRllTVlAvRncyaVA2SkVZClVXbGdmSXF3emxQai9JTDJGN0dwNXcvZVBqS0lNTm5Oa0lr
SlZ2NGY1djRaV3huWWh1RnVSYUlaMmdxUkFlVEwKUDkzNEpUa054TktrZE5hbVl1L1h2YmN0MmVT
VHgyUFh3ZzlaamJ6d1FaWHBMYW9LYkJ2dk9NSmJNVURHK1ZvRwoxVHMrS0MyenJBVXVRRTlBcnBw
QlM3RTVsSXVWbFBLMDBYdkJIamY3bisvWjdBMCtWTHM2T3FTeUpPS3crZUkwCkZ6UUpyVml0aDV5
dDA2OUdNYi9lTlRUYmc2WFdOdzR4YnpYYnFFND0KPTZuQ04KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004f022e061cbfb967--
