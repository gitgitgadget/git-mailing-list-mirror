Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467229B0
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755466110; cv=none; b=T6Aup1/2kM1Fi2bR4aXqmz2sebtjlvX0oYa+cie1HnyuAI0vOrqM+RJ+2gD0D6GLbKDuNDEK9yRVLEyuOf2UDxa9BGE0yngVGdTaUrCddtpEEPSdAL2IzQM8TY6QPsGjYTrN9zzoCAz3ZdZq7a5hrPfwpm+4FmPT3tD1WZ+FMn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755466110; c=relaxed/simple;
	bh=ETYDRQggeU9kHimWrVINAGJ2RjilecGqZoZRt+3DSM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxEaqBXFMeXAJq1jbHumyFFCaXI6/UOmdIFZJV5f6QG7rC2tkwGSWdVraYhuPBPQwY4NS2+L0zMzIERFrz3H9MQJ2HhvNNv3V7+WuDbyrnpXTXdTkbUluJpHcrU397f7sDCtB4VktAjOIfJF12+ztiSZRmqpXw7orqIy8auj6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlF7QlcT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlF7QlcT"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b5b11b2so4380266a12.0
        for <git@vger.kernel.org>; Sun, 17 Aug 2025 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755466107; x=1756070907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efROf3aJTw05IpW6TgSdBbfZ8XLs/BaSvPFKdeLIZB0=;
        b=JlF7QlcT2jUug4Hqj+EZ0tXJO76fJ6XdrkZZzJOGZH8mbbMYLgJcQeiqtNXkcFGVfy
         8kvJDsm1fR0ktpNgWw/z4VerIoaMCT8qIgzioB1lHoeNDkXjbjUwJR84F0J4L4fsJNn3
         lkYq+zkfetgvmJ0/4SPQw7IxVbr6pkonIwMjGrRTKrhT1MYH91++2U3WAr1wT1b5XcBF
         XQ7x/2hZmELvCvJayALdMkqh+tV7qpCCLw7247m2GUc88V5sUxXJIrcmAqT/vyZjMf+H
         HTemTTjqdlBoykcdQ/P5OdBsO6ap1RDJPMYJKJfIlzlu9wYgwHFGQ473qBcONQ2Y0VXP
         g+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755466107; x=1756070907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efROf3aJTw05IpW6TgSdBbfZ8XLs/BaSvPFKdeLIZB0=;
        b=fo4FIBO1N7177w3i86nT+N0btbUvKFHNg29d+qWke2QwWlJaTYNOFCL4800wLzv1tE
         tGDYQp0H0hmwlGxYz+Euy6pVFa3nYdOOpKqd3GvH5iJd33AauMStBoBvYK6Nvb2gPxxw
         +yaYGmVEGF/VPatfetoR3dplasb4Awlv1viqWko8NcTHu688xciRgUMw0XER+vaA0p9o
         8nx3DE3ievqAXdZzxKyPpiZL3ljRJIrPtOjvBg2BepvcU3D5u3qgAepF0aBbFEXkSJyr
         57UvATJ/49UqkIrw6qGnTfIZTOrlkr2SS+IfNNUXZuAXhNyLkZCnbaQKIMiY1KrqlJJ9
         OOhw==
X-Forwarded-Encrypted: i=1; AJvYcCUBsat4B/N1++Nvaqjt+Hn2pFAE7f8SdZx0o7XiSh4BDydY4h5uzugWZggGgSJqMd/LHnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKwgw0qrBdgNU6qv+qIlG3c6qwYFS0iTm2sivw6jfzAj33qGaH
	3lKFNGjJMsZUN1EAAYBVeCTaekZjx2agENzgnh8a+PwdQmn7P+vcdEEfMAfj25X0sa6ocIbKNQZ
	2L0h9GEo++1GUVSgdWu3YeHpfmq333W3IfXYrnEs=
X-Gm-Gg: ASbGncser2QKM7mm8ALdLGQCtnHr28oeOTjzQ6+g9qctQlJkC0o66pZ509ZG0AKy6BR
	SZl19+YqYFhPh+PfgfsZ/Tz6UyzfWuEQ88MGVKIDpcK6ikHsBsD1JQ6KH0xqEaP7oB2vrYnRSTE
	ybU/up0zyj6/RCsWbTgHC+lUh3skyisJz8bhRHaQaiQ1rxyph/Z8ka8yuomK3iuy0TNKoE4o+PS
	2BhaRtIsVH2Jaz8YSJLSZ+Wc0OelHUEEq8yUx+Dxw==
X-Google-Smtp-Source: AGHT+IFeeKdQWRLn5f/fwmV8Af0aOgHh89yY26COf66OnwJ4JGa+NFDMOuq3/LLGgUhyO+tkuVZqhJgww7Z7FKCmD9s=
X-Received: by 2002:a17:906:c155:b0:af9:a4de:f092 with SMTP id
 a640c23a62f3a-afceae8f7e3mr665254566b.55.1755466106792; Sun, 17 Aug 2025
 14:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGW8g7mV6az3ybYf3uzHYQTGLDwc34eebZnha1EQ3Sb6B8E-fQ@mail.gmail.com>
 <67621563-9441-4ae9-a23b-51af7d3ce666@app.fastmail.com>
In-Reply-To: <67621563-9441-4ae9-a23b-51af7d3ce666@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 17 Aug 2025 17:28:15 -0400
X-Gm-Features: Ac12FXy_Eqvsfl8MnUea1MAMHOyPyUE2aYzQ4JK1C8RM_H1Mk0qFbWpdlWvAH04
Message-ID: <CALnO6CAkTt0brPbnKDu9rOAHeLRtk2hm3xJT5+HvZOfHSL-Szg@mail.gmail.com>
Subject: Re: [RFE] Add JSON output to git log commands
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Ron Ziroby Romero <ziroby@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 5:09=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sun, Aug 17, 2025, at 22:17, Ron Ziroby Romero wrote:
> > I would like to add JSON output to the git log command.
>
> Previously: https://lore.kernel.org/git/CAGW8g7=3D21pPAgCixjpayEvmw_ns-hc=
B4e59NP476TKtCRXHPXQ@mail.gmail.com/

In particular, I would guess that deciding how to handle "raw bytes"
(e.g., paths that are not necessarily UTF-8 strings) is important.
JSON uses Unicode characters:

     A string is a sequence of zero or more Unicode characters,
wrapped in double quotes, using backslash escapes. A character is
represented as a single character string. A string is very much like a
C or Java string.

https://www.json.org/json-en.html

(even though the railroad diagram says "codepoints"; I find the whole
thing a bit muddy=E2=80=94what exactly is representable in JSON strings?

    Excepting a few encoding details, that completely describes the languag=
e.

??? which details?)


--=20
D. Ben Knoble
