Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8B2FFF90
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151737; cv=pass; b=tBFv/O57G9cYCSrGYoMR9CbOumMa8D5zjkT0nUJjDN4ebTsot1yaECj5hNv0AuHUAVGZ0EMS8Ra1pODRliR+/mrn4b+22/A44nmRd5ckSOackKOtvGBXjeY74/g8f8+ICEjh9/njb5ME7q39hO7AcZZlGBwblmku0XBH4QQypxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151737; c=relaxed/simple;
	bh=tl6W93/AeMf/OA/LlEX5Aa6gV8EZX7Id60jjQUeDrfY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6mKyKTcwtf0yrPD2iXqWZ5HJnlDFG4XPqsaTgiW4NuDyJli/UWfW7WskBDBwR2TsWEWU1sZRwJVWVw58G3idDL/uerH/SKGFmqKMPVgsExCTYWvAmA4OAfaT4/0x4yPvdkB/Sswvcs25lKZZPj3wlC9/1vVOZQ3Q7iPo5dp3bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/A3RmIN; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/A3RmIN"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5fff77ff719so1582188137.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 07:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773151735; cv=none;
        d=google.com; s=arc-20240605;
        b=bOB8UyRiOkqf3P1NxoMgGKTWvfNcdhhRS0R/b8kvJjLsxMenH3kN3c30gyxGs/TK82
         5jFjQ5ssK7UA/QfbyfZDog7+L4Xt5c9XnWAfFvaQd50fBYK52cTMFP38XNMAnyM2efnZ
         PeWOXqlzR2KjoeHSwl8y3btTLyhglSjgT1G3MpPhW3zE+sZZ5rmFS9lDzR0sn8br8Yia
         VQkhHfaK/yRX+VmnA497fdxsmbC9DtSUjie7SKJunYxW1mA0Jz7pLf7e27l5iCHHk43F
         fjygNqqEPFIVbnjtnB4pZEnyqd28KjeKP/RLs6257GEJ77SZhMkenASstXZIXuSEkQtV
         5iGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=tl6W93/AeMf/OA/LlEX5Aa6gV8EZX7Id60jjQUeDrfY=;
        fh=ZS2eS4/uNHb0S7h15I3RJ9Cw0DyV0H6s0ImHdvnX5kg=;
        b=S7nu1LRcyTvL4vLWtaa7ksTKEuE6qToC++3HFcZrsNiz8RZm2SntXYVEpZKF8Eamh+
         KgaAFcHbBK+/pHITMdm3lIuPLpHG/245GleOR1iSK+MGG1lNELB0Fa3G5/51Bjlip+n2
         s5Stp2Gj8TWxJxpvX8veSw22MpwY1FkjS6OSANBdcEqH8eYIja2drKEXSvH8iFQk9RMN
         eS7EL6dnruOdS6ASO7IkwbOwc3/WoH6InEw51p6i4n6FOoJFRoAlaZUcYQ5kuqLEPOTk
         QZaxLbIsWHpAbXZ2V2v+cHoFAxJyjbQR9aseGf/177NVomBQvJ4doHVX3fwwwbY+JCgc
         65Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773151735; x=1773756535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tl6W93/AeMf/OA/LlEX5Aa6gV8EZX7Id60jjQUeDrfY=;
        b=O/A3RmIN6ygMveF7lZHBxJYXbdfZIBECqVKiMdt812Hjd5hO/jGPlSnpcQvhS/rpa/
         v3MtO/FhK0mPYiCyhU1GfHxzfnFjqvWOC/CbvtG5e1QQnotFtS8yPjO8nz6V2+WqCmYd
         qGsShiRQMhqQuBOi6i30FuEX4WAIIewvSZIXLaJZ8T4ddFU+xkX4CsQwVUMfK/5VesqV
         xyHsb1ddwSQ9boC7XMmEJ13sjzhqzLJgnyff4xjtqTpTk5FGSzE5VgwDELQSv7RaMA2u
         jZd9dqGrH3bS1VWeyGFW2croxtrK+7wTtFHeBl1g5gVAjwwNj8o7Ze3eYLOH5FcFPBCm
         WxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151735; x=1773756535;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tl6W93/AeMf/OA/LlEX5Aa6gV8EZX7Id60jjQUeDrfY=;
        b=b7O64dt1b9kyKr/R6OxZGmOJZhODMA12dLD+nX9g342JBm5nDUjoieUIc54gSa1Cva
         VLAxOZeD9VSAWQ/cR8+QuxKd0zi6j55nJJUPIzxxmcf63v1uBBPRK218wkZjabNQ8JPq
         ZJyb526MEwImGu2+TVkPCtByKcf2QBizoJeeFvizZQfLLZJ23IYF2PztkhobADcb5/yk
         0e+LFEGzzDRPY2Y0sYY1I+yGOjKIBWEBbQ6ce2YipIFqe6yJu8+Cv8HMTfQi/Wyt8P0x
         fTDl1CloDqT3GX3abKyZWazRqqs5UX4AjkkNwGaguzqW0c1xep6uM+6mOUFQZOt8MXqk
         SwJw==
X-Forwarded-Encrypted: i=1; AJvYcCV0UFem8yNlX38l/GMY6Pvmov/wpKbD/niZx3KUhAsm0yjLmxxNtqJoIf21gJ2BfoXKHhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTFQcl46A2rtSEgULD9H+1yjJOg/doMgVi6WSv5Mb06RkaLkLF
	rQW5KYOSmOTLt8m8bEP0OTwESFGIrJ+uIikCfMXiSwGrsBqQ9SjdGkY20NydNvvGz2i1V8NZYrW
	zgGbJuY7A60G+NOfHgY36FaB082J756sfCv1Z
X-Gm-Gg: ATEYQzyghCL6teO9jzGz3orCEBuXl68PqXk0lNo5StFbr8d6/yJDq3wG0oVUR2crWTJ
	aaZF7/f8rGR8vVDlqA1LhZnaBc8hBp5/OWMzv3X6HTn8n7IXz9YPIMM7qBmCFh89ZAgW6SdR/7u
	HXba2BHe4UspG2iUcJO7sR/68iDjXpO7HaHxAqFaODBm8H88kvxZ4WFW6B8wbkm/1bd904X7xew
	770BGhNDYjdCxx0D2whLYHJpmeNV09JkMdAIRBAO8X2tzfJeY9MG8x7GP3slvZ2XF25rwqxjjOz
	bs7NUAuFB6L6WRP9sNUsuFhTzA0BiVfpLCmZPW2KycFC2dAeT0c=
X-Received: by 2002:a05:6102:6483:20b0:5ff:f198:d240 with SMTP id
 ada2fe7eead31-5fff19941d9mr4588085137.31.1773151734015; Tue, 10 Mar 2026
 07:08:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 07:08:52 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 07:08:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <SY0P300MB080176719022D3D7C2C5D70FCE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080176719022D3D7C2C5D70FCE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 07:08:52 -0700
X-Gm-Features: AaiRm53u8UGpCnow12S_vCfBGCr9U3TVV8d637xz-0Z75w6CUsSxHZIC_khpEG4
Message-ID: <CAOLa=ZTBFXZuzxm750w-xsT4e7C3+q6r+hcgyODRVZWjtCtbQA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] autocorrect: rename AUTOCORRECT_SHOW to AUTOCORRECT_HINTONLY
To: Jiamu Sun <39@barroit.sh>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000003d524d064cac0f9f"

--0000000000003d524d064cac0f9f
Content-Type: text/plain; charset="UTF-8"

Jiamu Sun <39@barroit.sh> writes:

> AUTOCORRECT_SHOW is ambiguous. Its purpose is to show commands similar
> to the unknown one and take no other action. Rename it to fit the
> semantics.
>

I'm not sure if AUTOCORRECT_HINTONLY is any better than
AUTOCORRECT_SHOW. The latter indicates that we show the user something.
Doesn't the former also mean the same?

If we do decide to go forward with AUTOCORRECT_HINTONLY, can we rename
it to AUTOCORRECT_HINT_ONLY? It's easier to read that way.

[snip]

--0000000000003d524d064cac0f9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 76855e06e195ef73_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1td0pmSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNllZREFDZ3hOV2lqTjZkS2dCTzZCTTVnTDVUL3dnSQprL2tMVGNjUExN
U0NiQi9NZkZSK0xJL0x5ZU5VeHJnUjlubmduS0luQnFJUmR2T3hRTXNMMEYzTVFDQlJKM25tCjNC
dmpueEdSUVBZODQreUZpS2JVTzBXRThxT2VTdGZLZHFTWjJOSDN0b3Z6aER4QWh6UFhmV1pMdnhp
UUp2QlgKU1o1aWx1UVVyNkd5amtQOG5BaFBwSmp0TUEyWnJObThqc2dtT1hUNW1IM1c2cm14V2ph
N1h0UkxiZkVrZTFFYQpnSFJERnY3TnR4RCttSVNGR09RWnd6ZEZzUlQ3dVZrNmxLdEtRQzREeFFM
R055c1hSZyt4a1ovQ0Iva2RJZDlpClM1UjBuUDluUzUyV3FkYk91eUs4c01xUVdaNjJpcGZSZk9E
Wjg5QndJUTh5MkFDM2FkYndTYjlIN1NjOWtvWVcKUWNJekhjckR4Nkh5NmMrNGVYWGh4YVNycE5p
RU56WTJLRHFMcDNjOE5hbS92WTdwakRrNXlqbHR0WWhHUFJ0SgpjR2laSTVTZk8rQnpaZElXTUQ3
SS9XWVB4TXZxRHpMWllMckJJYXZsbGxFcFhBWVdlYkgzWTJFNlFWZ1BFT2RnClNWd3h0UmdaemVH
b0F5d0M3SjU4NFc0YU5TZWQ4R25uelQwbFNZQT0KPTFkMlkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003d524d064cac0f9f--
