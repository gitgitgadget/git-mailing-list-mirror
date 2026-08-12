Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B377A7404E
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563969; cv=pass; b=KP71LBMEiDVJbldgMtuaXhWHnigcFrf94+MDCM3bk8u0lFiucuT53jmTdeJkp6GbVwVM8l5SUSWzCxYhnLQm6RBIzAFExv9rTVxdDYpYarkLUIBW5M1cRnDZRNxpVmYoIzEO8sQG+vlijVPt1RRB5mEwu4Mb00dFPRsqQzLIkJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563969; c=relaxed/simple;
	bh=2wvBbLeGDZ4Vm9sjyYw02Axu/zYV5+loFbydKCErA7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjduR8wZXjiXHbhFeMqFVA6YC0l1WEBLa740PtkHNKG1LmsxVJm4+wNc903qU7JEgs14ApfnN+0Y0mfuC36VFKTgfKdjCG80mwXg1syBYY98+/pd66O5ACqwW9ofXXeyQDvGbxK0vk7bMQoaKFK3sX6FHlA6KYoaQAJDVvINlpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Y36OON; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Y36OON"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84847482584so231593b3a.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 12:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786563968; cv=none;
        d=google.com; s=arc-20260327;
        b=IME9e2KCHB0m8QyKLXqBB3CuJiML8ndVhN4uHX2LDiRI6lSyG25JFFSRA8jRhWdzfw
         DXgyUO7TJphLoNWYfAiUqtlafcTUgHx11s/6FUoQWPyMBL7CfuZoBcd4RVIWDcLSDX67
         coPwR4HsjWar5BGyQ8Watc0TT0ljk/31njb/fOGK5ItkzNsq2efyZP8uL8Hf98XoBugQ
         eJ6VALvoERlDkcR8tbZgLfxpsb+xEcF8/NgQlZcX1J+oM8zoxATL7gjDe754fDTwUGBB
         65gA5ByNW0lRSZmcEDsfqZhveIlS6cvlXGdAVaL0TQXQTF399yfJBqwZZn9wkM8z1oxb
         VoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8cDUPDa/vmq6ohK7cdytJS7/NKCxupnH2OR799cZjtY=;
        fh=0NBmgmGV5gJiFi5dDhg9k8OYNW299nWQxMWbNj01jYo=;
        b=WJCCTaU3BiVAti4iDv1oXDsJ313jb+z6dZ3WufhkIQRJTprqYO0c9g3kJW3y+zzdsJ
         KIfILi/Pj0VZplL4SOn0f3asPzTDP67BoePAE7tRWQvJpVNlW0T4IJegYiWmFTWf2emY
         TydBmxyuCIAw5idtiVOULnXYIfKvdpo46dpj9YkxAbUXJgYp/e6U2BFOraBSXgRhqY3s
         66R5hWOPxo2a2WyhVjW2M8PrGDaqzKA49GsK3+9T9EDk1Ne0kIWZTgqOP8HAVonp0b3J
         xTUwicOgwRrl9yD1tRhsY0A9ks53J0UPE8DyWfyuDrdWv0pgnhZJZ/w9+oN3R3DKqFyW
         zwzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786563968; x=1787168768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8cDUPDa/vmq6ohK7cdytJS7/NKCxupnH2OR799cZjtY=;
        b=g2Y36OONdx3ArtM9d6/Kf7q4iwTDRlETD/OJ3dc8CoJkRZlzy1/uor5BFqnsOIo0xZ
         UObVCYiRwbW7ffOUEITeSDMP5YQhJox8UU8hSVMXgNnLLbakoqgda/6Ckp3t2WvlTMSX
         PrNa9ks/Gi0tyNyi8JF6gXjTn1Zm/SfgvQZRepy2iDs32HR5PfEgbCW+KgBdgJefkjnB
         FpulBIc/EUtrQ3myxJ/4suOQicU+uRPU2Aie1/uCPXJB2FYk3CsRvwX7+VRtnrIofl/7
         +kUcZpZhowzoBV0Kek2ya/69RG+bEM4sUjjhxflq5A8UcX9LSyGsYjMcdt4x7Jwwdxle
         f7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563968; x=1787168768;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8cDUPDa/vmq6ohK7cdytJS7/NKCxupnH2OR799cZjtY=;
        b=XUUfg8LfKGegvcTwrPuSig1Qqf7fx5CDtW1aKfY4ogC8jJS4zz87zp9pPWpsKJygFd
         wNeSy3Vxna9HbxmtiuFyEApQecBQszzLF8g2wejXP9zGvofndzr16IcS3OogMiZA7rJX
         mX/EUptelN8ZI3j3x01UMlgAy7OubNDA9bJuzqP29xICwNsVDqxzid3edPm0uHq1XT6E
         3CjdKpMNK02jvaJRKy7LbGLDgYjFIWU0vxu3yt6/h2MVGGcRg460JTMgjBNbRQpqXVRw
         Xe+Eiymnjvs1U0u2gs036AcxNCnN1a4KC07Yga6qBr+n2nRd1SaSHmdg+gEBpUrJtU8b
         EiXA==
X-Gm-Message-State: AOJu0YwlmuongaIKqFz2kNRzvMqVWvrwbdPJVw+Qv3yIuPFJPkaYWLIw
	8rp2BjNRlNGl2cXo1kEl3TetQDBmZzYj9J2s27LHWcixC7ypIGLAGem8HWkAy1HVa4NvZ/VmB5S
	hR5RRil1qc7x20cPXbW+/Ix2mKR5s4Lw=
X-Gm-Gg: AR+sD13IR2EjFCVzi9vZeHgGbbRqzu+3TP9+FVTtOs6M8LEgww+2EwyJzfKUHdM3qgN
	9TQ32EJSUAmWttXEcL7pawZIKGMzal0wvZYkUb/eXGPDH5icYm9E3Yy4lYLuyxpnHxPMjsAFmLB
	2aJa7KpG4h3p0a9HG2+LDouOKT+7IurxtkTlWU0jVdkXWSgK+HZrHVKF3BEkzuzMpDQS1/3c0Qu
	jAbI+w3U2l9xqD/idUU3vTf+bsbt5CA8PlcVMUVtTxYYfBzBlwCpqNqVVr+fX47P0QP6AI11KGa
	y4E5jG4T1KPYA/N1G3AM8H6bAd7GLrq8kErYYw8+Ecr4ttz8CodsXlR/VEMDeZ6TO1W4ZTeSCfk
	i8K8B/XSxmyYp8nADN/VDkSy3RK7mA0mMNLGGVT7+Xwz9AsQGZhMWbU6g5h0xbv/s
X-Received: by 2002:a05:6a00:3a0b:b0:848:7bcf:9a9a with SMTP id
 d2e1a72fcca58-84fc803daa6mr27521b3a.1.1786563967894; Wed, 12 Aug 2026
 12:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com> <20260810174047.6524-7-r.siddharth.shrimali@gmail.com>
 <CAP8UFD2ii8C77jWpyHRYG=H7y4t-PFtR5FQB3on4bmB5FQyG4A@mail.gmail.com>
In-Reply-To: <CAP8UFD2ii8C77jWpyHRYG=H7y4t-PFtR5FQB3on4bmB5FQyG4A@mail.gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Thu, 13 Aug 2026 01:15:30 +0530
X-Gm-Features: AUfX_mz35G1avMZGTayptEhkl0rwn1o5SaYe0DgYw2WENATluTuWla4xeu1EyMg
Message-ID: <CAGWgyh8Azg1SKyPGtjai-FLbV5Ngn+dC3kxZgU+0FYFdDoOEVw@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 6/7] builtin/repack: add guards for --drop-filtered
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, siddharthasthana31@gmail.com, 
	ttaylorr@openai.com, ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Christian,
On Wed, 12 Aug 2026 at 23:11, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Aug 10, 2026 at 7:41=E2=80=AFPM Siddharth Shrimali
> <r.siddharth.shrimali@gmail.com> wrote:
> > +                               die(_("--drop-filtered cannot be used w=
hile another operation is in progress"));
>
> Nit: I wonder if something like die_if_some_operation_in_progress()
> from builtin/checkout.c could be used to improve on the error message.

die_if_some_operation_in_progress() does check the set of in-progress state=
s,
so it is a good fit conceptually, but it is currently "static" in
builtin/checkout.c
and uses the_repository, whereas the repack guard works on an explicit
"repo".
If we want to use it, we could extract it to a shared location(wt-status.c)=
,
make it non-static, and take a "struct repository *", which does not feel
like a part of this series.

So for v5, I will keep the explicit repo-based check but improve the error
message, and we could do the extraction as a separate follow-up by first
creating a new patch, and then use it with the othr future changes, if
that sounds
good :)

Thanks,
Siddharth Shrimali
