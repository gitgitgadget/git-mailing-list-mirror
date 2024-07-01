Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D416DEDD
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852252; cv=none; b=ZY3Dm2CbV/VIdP2KPkS+LHVZZpGMSHquc4uCIkKaYCBavsXjvtrdns+iTI8em+vf8Kn9T4vg1tqHOlJGVeu54Vn2MrnMn+2f3J8/difcevDfcwvUPdv3F4uSYpFyvd2H4TH4aLl5T743T9hoMm2Md/HUirzHLCejEnR9QVuCR6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852252; c=relaxed/simple;
	bh=ROOH1KfGVI99KJry/JhrBAFYvX21onZH74U8phMkQ2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/xgEgNRLFsw+Eyemu0G8L0pDhWbbpf/4Z7LdUDiKZKZbVbFk2CSKjYF/QSm8BnxN8YzIjO8txCtCLh6AnSFtBkr8FFekdp//+7Vqq5Bgxi7ufxH+66zhxq2NWgkUuArRKcmiYOIElwhYnthdjwCiR7a2uRCh+8FErt8MzMe/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6TCXWpG; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6TCXWpG"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-48f5295f81cso1078553137.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719852249; x=1720457049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GXAZZGMnvLOjaI8os8X0/6blGVtfdGBfd08W3MU1Lk=;
        b=k6TCXWpG3F4ND493eJyklS9eGmZWVf6RnvwbozwSJEvmhbJAemNLx3XP8YALB+tftp
         wUQuukc18Z03OPA9AFjyr85xEGrh4STgAXOtAzb81sAewfrPkZrHzYL6buq+90NI74Em
         f+xMLOMtRa7dRbykeeZhjaVmBB0O6+1YcbRY7CE+8ZsKi0T32/Cof5MetvD759ocEUYh
         dIn2LAqvgGzq+9tHoMiYnVT0OXDuEllyfQ4Ua44Wz3l59b1Hem+0UUUg1xN8+qyh4i2p
         D7F5sxcPPO6st6XJF3B0mvmHp6JFgj5pkNROtfnVLaSqJ9rCUfNIpCwlCKuC7aN0AgFi
         YpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719852249; x=1720457049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GXAZZGMnvLOjaI8os8X0/6blGVtfdGBfd08W3MU1Lk=;
        b=R+T9yGejT5DYVhLijEPxTwWNu5I2a3yqs3/CvpA/yGyZ/qB5HN8VMisDLxMJPJ6cQW
         rohAoWfdU3WxAn1bh3zjXfH0gUA9Oo9ETpkVcTwyNkspxephMhDtl13UsHDeYaPNsv6H
         GPRKPCj9FtoVHQETPXIEbVCTG98kEhQ12qJUDTv+VmULmP2vwqSHMaCqJ4qbeoiosaOA
         SiBoE+8zv/wYWkE7nqAGtYCqTdOffMbUmte+7wTW3kEZ/Ru6B8TBHi7GBMLYczzW5g56
         ShfNUAH4rQkFL4tfR/d/xjpZ0adURt2LKw0/kecf1LmKJIC7NTc4eilzEfUNqiS5mzX7
         oc5A==
X-Forwarded-Encrypted: i=1; AJvYcCXRTj69o4BctlRFstNAUs9DyPVADW0040yrGlpqeJX8965TeOjEDooDD4zIayYVv7AtR6vDPpC4jWKCNb0ktwTaNMnd
X-Gm-Message-State: AOJu0Yykji/Mdrm5JyjuRqfXlYqzUeC06HvLOHqSAFu7x9pWfznxVMap
	qL3hqTK4xVbS26tEJrEYbixIf7XQ0QOiGoSYFVMmO8ntJbKmuoqzp8FSrgoB9RAAPZ+PLUSrcKh
	bJDCwdKISWr38uxZrmgkEwX3MeKdnY4j4y7E=
X-Google-Smtp-Source: AGHT+IEUkoAl4C0ruUotKqhAq45l0YM8TcTtQbwfuvml3N8c1bUWFfXvgOcG2fPvVMdTP08w2GnNkkzEiZVHl2jZTB4=
X-Received: by 2002:a67:c40b:0:b0:48f:8b56:6c12 with SMTP id
 ada2fe7eead31-48faf08f75amr7385666137.13.1719852248701; Mon, 01 Jul 2024
 09:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>
 <CANiSa6hVbrCpPtBCL_W8+43uWGL0LFJkFhSJYGtfFgxX75zE8w@mail.gmail.com>
 <CANiSa6g9L8PM8wLhrH_3TYFBh7FwgGXXAk9qVpFkSM3zdcKqKw@mail.gmail.com> <CABPp-BG2p=0US9t-3DzPn8oCbPUXAg6HPciona8x8NNVyyowbw@mail.gmail.com>
In-Reply-To: <CABPp-BG2p=0US9t-3DzPn8oCbPUXAg6HPciona8x8NNVyyowbw@mail.gmail.com>
From: Pavel Rappo <pavel.rappo@gmail.com>
Date: Mon, 1 Jul 2024 17:43:57 +0100
Message-ID: <CAChcVu=5z2-Q=80zzzwY9eCV68=g-+uEy5u3Y94vb4-STKkRwQ@mail.gmail.com>
Subject: Re: Determining if a merge was produced automatically
To: Elijah Newren <newren@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 4:11=E2=80=AFPM Elijah Newren <newren@gmail.com> wro=
te:

> However, this wording was not intended to detract from the main point
> that "empty output means clean merge and non-empty output means
> conflicted merge" (it never even occurred to me that someone might
> read that part of the documentation and assume that it presents a
> problem for checking-if-diff-is-empty).  I use it for the same
> purpose, and that's absolutely a guarantee we want to provide.  If you
> want to guarantee output format beyond that, though, then I object.
>

That's good to know; thanks! Back to Jonathan's suggestion: I don't
know how to express that in documentation. I cannot suggest any good
wording at this time.
