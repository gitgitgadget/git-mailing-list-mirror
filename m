Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9A7420484
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828307; cv=pass; b=MBm6/GVvzPipgNRM3v+6xrXSVEpiFil97j+55sGzSwXIuEAV/IDmtviGum6TRQbZfiwvar8OOAoJvu9axcnfyCPqEy/ymF8yQPMa3M5qxCGN7fxUinBTR6Aml0a/V+XLLrRv3pMxtXcieI11ivMLvmz8nB5U3npzP3MZ1NujkGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828307; c=relaxed/simple;
	bh=dCwB/WQC0+MAUMhnz0jLuwV/hKohfL2w62Z0rBf4fS0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=J+nsYl254BGuhVcQqvdxI8rxs2nTve0oPVmcfdZjwUdstmB6qZFpVxG8SPJZGq5B7SnERU/gArxDQWd7WbwARPAodX6kv2uOAlDjvruko07t7xoEpw+hyFnM3vObCM5nO5/NrBURLiHSwF42Z3RUziHggGByQe6ebzmS1+8DvQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiDLLx46; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiDLLx46"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso141698137.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 03:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787828304; cv=none;
        d=google.com; s=arc-20260327;
        b=AcCTfTD29ljQ/hEpak4B9dJ7zgA+U92uQMZVXT1MOZJYxVjhCCsOhpM1mvfnyTwhHN
         JlY2N69M9uAsA9Z/sRkNcTO0uoKcRvSNB3BhK/1toTmS753FBoOHCYihiEy6aumf9cy8
         FC1Y9T5a+Hl1w+ldKr8wW4ioY8dAvMv5b0QgCbhMEF+RiqCCOR74X+t4/fm2q7tUQefx
         UZ2mAvHkB4YvkHm8D74FCnlVtGDNA+TGHAZ9EPVUGHctB3NxcYQDpX8IVL5F9bYJriiy
         KHY6LQ+L2qzQNLFsipuGxK5uZrSsoqfa6AUS3C7dd03oLRbj+vRkvVttgjQ9NJH5GB6F
         MJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=82KqTGlus9I58w6u4zz+HAazOe2BeY5jtCHUWVjRZXg=;
        fh=VcIWOZxoILg7lf40wA/G9jVGBVNFPy/R4nSzpWxwQU8=;
        b=o5ScQDWgCwHAYqnWtgy/57oqBI8DM29KG+B4MHmXVTg3koRnnqqn7ZCwQDzVmPuXGr
         W8aW0obVKP6RyR6dix8W46qRXjlJEnYE3+TD5/PF/9jt6Cfwc0wUxvVluHUs2Et6w198
         ajugBtC1+5oYfi5jOPG927Ig0DbUbnt5nYDwR0rKjZExfyiPB/C80K/HYEkGcbsrlcD8
         gx2fFzMDkESF7hYdgKKlP4NgfKOPTcJJVvqt/yyfBsTIHX5bQgSF5YuKzC+a4/B3uONi
         lJ4Svr5IA/MQwpZoncOWzvSGHVuUUt6/1Adrd3oW0jSUD0xkcsOikeWCVYIJrgLw2qAJ
         x8PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787828304; x=1788433104; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=82KqTGlus9I58w6u4zz+HAazOe2BeY5jtCHUWVjRZXg=;
        b=YiDLLx46DYVruBTqVG0DgWeo4Kn15rjSzcGBUkokPYtwmQccNSIB/D+4DcBgt9Pk1z
         I6dMwUZUGXch1ItDliqCT3FQlwqAxO+DSFndQOD1MWsI30u8HPGxY2e+vQhMsImuEvht
         T6YejQWhG6bn4rly3/oKjOdSfHztk/N1yGtphs//ncUV5apXsbggSv9pjfOSxVlQyuyb
         JwGz73dK4LbOJjMnx0dJB3aaCBwQ0xiCPznfa5INiOQG2/GG3dGKV9rJSVxKlP3OGxZJ
         yFyVOddVkVBFcqBX2SNM36Cd4Id+peMuP/dx6lfLtSjbBXOORWg/kb60i2ekXHF2RHev
         GiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787828304; x=1788433104;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=82KqTGlus9I58w6u4zz+HAazOe2BeY5jtCHUWVjRZXg=;
        b=VqA8KrNKHet1Uqooq/NMHtjiyXyEpC79E+IueUR3GKpmdxGZm44hG6+5+2mxRonGyU
         18yd8870gCKnPnPQ3PID2KWFRAPtzdkTXEnN7kmg2DWsJWQNjVnAMq4c08DwnHI4Xn6O
         pqGzFGJ2x/226UBkt7ajwKEyfRrSovwJek7lI/z9QZXWgA6KrhKdTOYM4pwtLkSOenVj
         mkXTuYngJISSdZ0ykfViydqwKDw2P61NVSFVLJ0WDacOrkwS0xdz4v96QfEx2aWrSB7V
         OV85uDhoGUgtY7k317/8Jo69rjIPaJw7hsDnNq9ofqm6WBow8Kbx3n3tBtAG9V/JzWrq
         iZnA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2Qh98lw/dXy12srSk7XLGLTNGOHmYMvMtAjsq1OpkWS85jLYUrGadAsuzl8X39YNhEJU=@vger.kernel.org
X-Gm-Message-State: AFuF++m+C5y8t1Tx5T3GKgMpdMDIxgKL8dQv9p5xdqd4t9gTRrpR8pMf
	LdNrcASNrUbLID11JK1Ist2TSoUw22h+qQHtz2Slo5CvojbCR3dqEt2+S6KQCsLg6FvJChxYZnX
	P2W971t0+18rQIWoNvuIX9WFhgcFTpTK2YS2e
X-Gm-Gg: AR+sD10HrS+2XrPgvq5JMPK4+RJy0XCTmNJ24eC5dMi10H4xaxgByueaNdaXHbyHauA
	lfb+bgb7q2UBLiLT98wRqAPLnbmcXyPJIDhJiWRYg/ysofT0tFhEF/Fpn0qj3PnBJhkeljH0VS5
	MCKKLxT5Ejv+XpvO2PmcHQgMs3BwRJpYqoBfGxvQIPEWRIxQNlZ+bYZpbqVckqbeQ0I9flvNjzR
	TyoByVpEGvYWwyhv7o2YOh2+7Zi80a0gRsg3oOl6Re0LsuYspS1mTR+Ujib2xjspPpaZMY1obom
	HbDSWQhPGKdjsuJ1iQ6LNcoiglvxhV/mLncpyUKzPAQsZeGAuHxZd2O3rC9+56HS7pN0bGrkzVI
	YssT0K3bVOUkVbGjhjYK0LWbhE5YRp9daqmG8T8gLTGoIvg==
X-Received: by 2002:a05:6102:5486:b0:785:35cb:e64a with SMTP id
 ada2fe7eead31-78535cc0ff1mr14899137.3.1787828304335; Thu, 27 Aug 2026
 03:58:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 06:58:23 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 06:58:23 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 06:58:23 -0400
X-Gm-Features: AcwNN1VNQVfEVzUIFWk2ST188nhNJEPtqN5P8oC-U07oOL5O6gpwKP0fHe2o-xY
Message-ID: <CAOLa=ZRYSje476JJDr5b8hHozwa5=4bw4E30i3AfLX176=12ZA@mail.gmail.com>
Subject: Re: [PATCH 00/10] odb: make consistency checks pluggable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fff6ad065a0536ad"

--000000000000fff6ad065a0536ad
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series makes object database consistency checks pluggable.
>
> This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
> with the following two dependencsie merged into it:
>
>   - ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
>     `alternates_db` field, 2026-08-17)
>
>   - ps/odb-pluggable-pack-generation at 5176dd3d05 (bundle: generate
>     packfiles via the object database, 2026-08-21)
>
> Thanks!
>
> Patrick
>

Hi,

I reviewed the series and only have some small nits/questions. Rest
looks good :)

--000000000000fff6ad065a0536ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1f251e5e6c8e3d11_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xUUdFMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXNIREFDR0E5c2hpblNZL25FdlIvYTBmZFp1TVk1eAozN2E3NDhQRktn
Y2cwa3dKS3VyWUh1bUtGbWZrbERNYUlTQ2lab1FIejk5QzEzQ2JOVmZpWklLSWEwNUdlR0VJCk1P
ZUJrUFVNQWlhczMrSk9Reit1enJ0SzV0QzV0TkZXZE9ISFhlMVVHTnV1QW4ybFdHV3RXeEdtNlla
OFBZSnAKVW1aTG4zdUJ5Wnc5OG1wdlcraWpacnhNRkdlY2pJbWR3Z3VwU3lXYVZzTnF1NllTR05J
WTRZc0FZTTlURkZWRwowSy9CWmJRN01FdSt1N1lHdmRMUHl0WTgza25PSWRTT2sraXlBTUk2LzNu
WFRtQ1J5c1M5RkgzUnF2U0E3dWE0CkZKSEczREU5WDUxQ2wreXJZdTFIVi9EejEvcGp0QWZWQjha
ejZwSURqUzhPWDRzcXNMcHFxYmFkMEQzbnRIU2wKN3d3MUNhQkVSQ1dCOEZZVGhjWm4wR2J5QVUr
alBsS2E1dmh0aUo4SlpHenVQZGJZSnlKbVhBZGYzdjdzRzE4cwozZGpWTzFEaDhHQXFzUlVmSE02
K2FKTnhLVVRVakhESXRGV2VCVkJuTXpFejA4T0Z4Z0tIU2tyRHZHVzljaVdOCmxaOXdObzlxb2pX
MnhuYjN1WG9hVTVLY3lRUHhRVzhOY2ZtQjh1OD0KPWcrVmIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fff6ad065a0536ad--
