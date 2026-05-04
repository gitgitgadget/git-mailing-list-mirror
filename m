Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FFF33ADA8
	for <git@vger.kernel.org>; Mon,  4 May 2026 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928419; cv=pass; b=Uy4OBHFQbapPaehsRU8sHuqf8NNWodLimTACKHAcww60Mpk77/2eEiBNorq23XNa6wKZxSG6AIB9/bknr3uIjK0uilEnSsRPrITcAKxP4G5SL4oLfC1Nd1Z67uj1uA2wCC5ZVs0MS7BFSJvHnojb0W07rRdARpYMooYT6cNcegs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928419; c=relaxed/simple;
	bh=2ihiopl+B+V35y5QSSHLta+fkgvSqs61d349pWCI9WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7ejuGofzfRfAJDe6ArMieLZkQUVbXxkArxywW03U9Rn1NG3odRgxyCnResi0HHAeb7iU98Ky1MyIO1hVir/fRcXF8mH0BlrVqstNnfYgrPPCSeiSd4W1p0c+87LN8iqYOdv4yY/3hD6h3u/swhP5BhH9kAWLqhtSU4b1XBWZKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jre/sDg4; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jre/sDg4"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a016799d2cso49238306d6.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 14:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777928417; cv=none;
        d=google.com; s=arc-20240605;
        b=WLas//524belKDNBOIqfBB8PIdst8zXNBYYz1EkzMCeTSkI82CVsu0ewBiRJP6ohBt
         ib56A9nLqYvVjjW5EwshxMC4QuuVv5J3QzuxyKAYU/7zFrciOvyRVAkFux62aSarR/m+
         eABzP7P6p+bmYwMyhd24d7+8hIGhbCizmQfS+orHJS3JtULT+gRWMmx2g13k+zNHy02Y
         SGEAl0NTo7nqJiaoP1S/6KeERCdSkwPpFmfGnr3uKL47/yK7HmpnNXgIsfJPIKRxXxv/
         V95HBJmUj+AgvaoRy8SzRjAAFAE5JlJqu0dq89hDRNa/CW1A/HYudvNvLy+3VM/WRNzb
         wnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BUmF29nanXdPaCmttXk5RUoDOvrs+woOXNCNAxOuN7Y=;
        fh=EHvOgDoo4BTgKlf4s0fC3udO+Ig8fiMLUux1RABGpqI=;
        b=haM3XMLp6TTdQL/6ah8ab1+spIMIE7+pdEX0a89Lh7I/SJrN4hgPxycyIanc06WXt0
         GrlN7OMSuT/XJ0kI2Q8F8tt1vH8EETh+hqhfI4SnV1pymACbDyxma0vXkiHrwDIFCJY2
         M5qD5++mBV6MTmI7Y2fEPU1XuGGcWjZhpi43S2zi5+BTXMmrJn0YQukyuLbp8wqc3ccx
         ON0/apZN5ZW4r6ie7fpVm4i0KbRMilTR6AStpTV1fbeeoOR2bhp5PvKskkwvrcxHbKD3
         OOmHmbqIA27CurAiwbZ0DbEpRxiERd2I1dZoey4qRKl0Vpd869pN4ARVZjmHVimLMl1y
         /glA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777928417; x=1778533217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUmF29nanXdPaCmttXk5RUoDOvrs+woOXNCNAxOuN7Y=;
        b=Jre/sDg47T2MLEIqpv77m6fXVp+qam4GXaezjwkdtqNRdfHnRjtWlxmQ8RNl2xim7I
         L2UWgR62bXFHAFDDrb1CrjKF4abJgAeVeWH6qUnDYXHA+KrhnOZO9IDqmD7T3qLv37tQ
         53YklJCdubejwaTlwHJflFQV4ZMKTWETRa7YlPUAmG0LYtaQLxe7bOHhza14B+004LWD
         aeJW3fQfC+avaH5tKIiy+MX5UnfRwMgzmjnOnloDqf0gEb0FjaXn3fkz2gBnKFMrgOvt
         vWiJsAh7rXfI0CF0fFmsk0vgx8tggj2YJHnEKCCVphMUDfZcv1GRsJefmHZSB9fEhFeL
         BCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928417; x=1778533217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BUmF29nanXdPaCmttXk5RUoDOvrs+woOXNCNAxOuN7Y=;
        b=OfAiPhDje9T1rAY99frGdG1oq9NJSEOK+gNqr7UFXLMsbc1q31MqU9fLATBshTJPQn
         UYiNNrt1SRfnKKth/MEbjoDQj9u5QKju5vajWQRkU/mkfcYtG5Ni6Xa4Xpl79OPuk7bh
         CCzJFC02bJtw9EnhHFqQf43xc+7tO7dXsjEMX/gQIMR/mnONAN/6nhU6XOGJawlVDI8p
         WNaBceScS4oZDEDSB+CUxtAv/QqikUn7FpA7BpdIPYuasPg5+y5Xt6KDvXjOKK7Nv4Av
         JZ6rez/FqyaRHZy+4MKxcvYMtyoTEJw047sUgQIKtkJHOL+ZCPB1y6Ger+8npe1xiWNv
         w/yA==
X-Forwarded-Encrypted: i=1; AFNElJ848cIXEWFXR/3MdiF/nW69yVoj7dUgj4SiSJma0SLEYsv7QK/t48PVuLK1I9cMnUj6OYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz93hARrE/Ppj0dWC2KxQLDdfkSntIdBJVGVsnbUpYeXEXPXToi
	0YTFggQknEnYH5aerVgL0qBfqR9R/SSbblwCtDQLqjxYkDI+daJ93yPWkSxHsrPJMcC8PKcF22Z
	onv7AkU/s+WVLtuU9pyB6X7WEe7io9pY=
X-Gm-Gg: AeBDievJQkkudmnJ++72oihVfaozjquiI/DCt7vqeqyEg0rSRqTlxpnRyw7y1CWotQV
	lMm4uSaT2fL0G1VE/Tnpj5v+LvqgO30lDSbkFqaIQPVdImHefTzi2ebbcIMsDr7JhGL07sKC90R
	WTZmQhmMtL8kbJifVwXBjjX7LCYxWQWM+OV+R+1PIcQee0Za9VrgiJtUaqAm+oONsFGpTwLIkBV
	3mm+vGGJxgYqHMcBxifpnEWelk+FS1Nr0baYTri/0DO9Jz5HX1AaqLSmKLyWIrW/PcJU1tzD6Nc
	WqVG7QCxBI90ChStZb2Nik5l+xsa
X-Received: by 2002:a05:6214:3212:b0:8ac:aaac:4034 with SMTP id
 6a1803df08f44-8b667e6dea2mr198145536d6.29.1777928416984; Mon, 04 May 2026
 14:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2284.git.git.1777578903593.gitgitgadget@gmail.com> <xmqqmryfpxpg.fsf@gitster.g>
In-Reply-To: <xmqqmryfpxpg.fsf@gitster.g>
From: Andrey Zarubin <zarandr@gmail.com>
Date: Tue, 5 May 2026 00:00:06 +0300
X-Gm-Features: AVHnY4L7DQRuO18xIbbgADzAfG0YwjNwKvenpotpt6ooXngdH2Uxe9cIvzR5rzA
Message-ID: <CAHGMpHAeSQ7xfm5AcfPNAEkuFwhfbwbU9dNgX1vk5qhC++1eFA@mail.gmail.com>
Subject: Re: [PATCH] pretty: add diff-stat log placeholders
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrey Zarubin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 8:09=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Andrey Zarubin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Andrey Zarubin <zarandr@gmail.com>
> >
> > Currently, users who want per-commit line/file change counts in
> > a custom log format must post-process `git log --shortstat`
> > output because the pretty formatter exposes no equivalent
> > placeholders.
> >
> > Introduce `%(diff-stat:files)`, `%(diff-stat:insertions)`,
> > `%(diff-stat:deletions)`, and `%(diff-stat:lines)`, computed
> > from the same diffstat machinery as `--shortstat` and cached
> > once per commit during format expansion.
> >
> > Short aliases are provided as `%aF`, `%aA`, and `%aR`. The
> > requested `%aI` and `%aD` forms are unavailable because those
> > names already expand to author dates, so use additions/removals
> > mnemonics instead.
> >
> > When log output is already walking a diff, the formatter reuses
> > the current diff queue. Otherwise it computes a private summary
> > lazily, so formats without these placeholders still pay no diff
> > cost.
> >
> > Signed-off-by: Andrey Zarubin <zarandr@gmail.com>
> > ---
> >     pretty: add diff-stat log placeholders
>
> Personally I find this a bit on the other side of the line between
> sensible and insanity.  Will we next be adding a new placeholder to
> show the summary (i.e. list of created, deleted, and renamed paths)
> and another placeholder to show the entire patch text?

I see the concern, and I agree that placeholders for `--summary` or
full patch text would cross that line.

The distinction I had in mind is that these are bounded scalar values,
not diff output. They are the same three counters already produced by
`--shortstat`, and the main use case is one-line structured log output
where today callers have to run `git log --shortstat` and parse/correlate
the human-oriented output after the fact.

Path summaries and patch text are qualitatively different: they are
multi-line, formatting-heavy, affected by quoting/color/output choices,
and would effectively embed diff output inside the pretty formatter. I
would not want this change to imply support for that direction.

If the short aliases make this feel too much like expanding the kitchen
sink, I can drop them and keep only the explicit
`%(diff-stat:<field>)` forms. I think the long forms make the intended
scope clearer: numeric shortstat counters only.
