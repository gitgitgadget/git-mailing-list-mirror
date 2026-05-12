Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7980372051
	for <git@vger.kernel.org>; Tue, 12 May 2026 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618210; cv=pass; b=b91i1yeRuG9RO8H61Jowjf8nqsoXG2Y08FnaX0HvxX6bl9pwb+YG9ULRXzhut19o/jLaKSOKylAthA/7IvZv6M+xxFNp8e0XdJWoZ8XkUYtd3emo3uLbsJOp9cHrMst99l3msaSvaPc/evs1sq2078TNPOI9bIHQ3wP9TzeBGwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618210; c=relaxed/simple;
	bh=4rCcPWkvuZChx68nO3pDcSxA+p8tKMgBoq1oMzjUSbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xx223MrHfVhrjFnEOChyZ8CLprQNvOfMG810QTmCz2nBmTFj4fMo9DqLiS7EtcF9YxnVESw1ffJigSLcCgHwYkHasbx8C6/mtQpNnksOph621pKZKrs3+8DlKhDmAi6OkBoBcsYcMoxMdkbcjLVhiUjiVjSv84WaRCHzQHcn0Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzm6Eh9+; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzm6Eh9+"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so3137223b3a.1
        for <git@vger.kernel.org>; Tue, 12 May 2026 13:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778618209; cv=none;
        d=google.com; s=arc-20240605;
        b=VfchyY4+Yp3Y0nQ78WqaxqBw3SVsl+t5QN1wHjIS64YGFInCzKVFu+O3oDB7RyJIWo
         q0/mFO1lQugC5CxTsMSLptydiWIaZpRCtJn+02Z/aOh9MWP3nVyjUnKQJvB4DZGcj9gS
         YDYuMuMrQ/J61laO4/u7GzjnqRexwyZ+9FHX8C2+bU2pv1s5K07Gav9KzrTZah+NF6WU
         bF+AROa6zWUNcVtQpxr0fm0NPh1MmI1DGtxmqfg/qCaH1yv0WaWvtFXlJvFUeq0fhCy9
         crzJ69gay5EH6BNjOw3L4n4R4Mujopj+aRMxiniofGoiQn0w0UX74vkxIBib+fVPglVq
         rxhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fh9+DL3AOXtZNH8qHUDu77GCdv/QhmWRx2b0ZSw2m9I=;
        fh=N+zv5KuCV2j2/z6wEcFkrCIIhwWBBv/L0cyr3XhRxkQ=;
        b=C1pa85oDcXtm/fCoxl9ECcN9I2QpWWvW2rDND8qnyc3xQXxmWhLm9KGYB9IhNENrZc
         RAuVfkhrZokOfMTgcpWCpeecksL8YxSz8OKpRczw9UOumWtSa4oFbAG4s6wfeJIh7rjD
         8PklAjLkU7ugmG4QtIm0UTkDT7jwiQKLTOPGacnFTS0Ap2hESgvXJnasREsl+PYBKO+0
         2ItZPp5qPnoEMRWlEmreBXkpbtMIXkGu79ldqyBhs8ymQFLLDWDQ+L0/9tjgXpog7LnQ
         c8HawTzNXL3DU0S2WDL7NptImVnG7y6BlfCZBLY3M54YCmWEgfT96kuJVqx6OSJXLTwd
         gAnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778618209; x=1779223009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh9+DL3AOXtZNH8qHUDu77GCdv/QhmWRx2b0ZSw2m9I=;
        b=kzm6Eh9+y3fQA8x3AwTlc/oKNSM3uVAKdqRxXdvYedImJI+F+EZSLIijOqWnSBdrvz
         0iipgEWqkzySL8x6vxX/+bXdQmX5tmXKpiYILdLg3Mfp1c7j6h8aOocZFLS09f18zmBX
         ymEgxlwQ8jljdFVBu/4u+xLqSP6TGZz/VRGl8PWy1GZYKyMm4F24VCHo90k5eohKqd1G
         i2HuxwGzcV67aCBsKVnm5WpoWpCi6AEWRMbR0CbcXgcokb1PDqopmA3nau9hNa5eEPXi
         5iu9tUQAVhaAjqw6CcDjr1GrTNmqOGrHpzQ9il2nSwtFzJ3RGLp3T/0neP7LI50mcAtL
         vhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618209; x=1779223009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fh9+DL3AOXtZNH8qHUDu77GCdv/QhmWRx2b0ZSw2m9I=;
        b=ahSFYp9Z/EkbL/ZFmjPBWWZxQL2hPI2paLZjEr0nT5XC9Q4nxIzI4sHHhw33m+J5pq
         u5mK/LEfhP/8CjUxjBajVqfdfW04d7mK7CwkHL/y9PtCw+8aupioulneCw6ayPHhmTFb
         oakyk6+o+yr4+1gAHSd++5dHRGa6HTBmbcwq2kYE2Y8cldUtl3QZWHtSDHyRbDZVdsBb
         n2hHQqBKEUN7FarEW2kv5r7RF4RnVkFus8+5ZLK9HQ/BzcNjrpS9xEbNWsFqyO9iCba3
         vsS5WdBXIjaTwpKwfAnDahW/eiZ/gxRsRJqGRXjNh5waDl3gTnIfEhApQbFf5WxEKguX
         b1xg==
X-Forwarded-Encrypted: i=1; AFNElJ+0UM1yFfhi2IcKxLhehY0J13pCIEBBVAlnLt3STffGWbzVpU1cPuKzEPo5k71UpPVAQbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQhlTiWh0BRCranLYha+0vCR5K06otJ5/qGdwkxsDRU3vw35q
	vFKRmB5oFoToDjD8BpAmsItwFVmuegWmjl6D7Fi4zCQNY6QAeH52RlI0xU/RKtvNHGvW7pq8kL1
	z3KPzgQvXdx36zrDY9RxREI7JLQVj6YgwYoG0
X-Gm-Gg: Acq92OFn8Uesy8Kx0baev4HNeyAqRgOX3FYPaigqSEl+VeePRKU+MIqf3TU4sY1xlao
	uzq71ERoDzDJxbGfzUPS1gkBZJEBMyirKBlcyVbu3RG9w8rUwVTBd11Me9Tv2NJHZqU8jNXiIq2
	QQgrGX0KAauaVH5iQ+0dLWNNb+waHxU3tD2p6HlRI3YoTZQXClu3wF5Q68T1lujMBQmWwsLuBwV
	pFAcnVxrqdTlTZxYaD4ZhDc2U481vmXf0cNr0ClPbnKoa0IjG1pm69a95ax1r73zqYq5XKK0rYS
	vMofQIMrj+/IyC1NZVs4yR3BqXPOBj+SV1VNxTGX9kjWMKEm4baRDVvG3pynrmQX0Z71zbmGFQc
	H96FSpx5ewfZXwjM=
X-Received: by 2002:a05:6a00:3308:b0:835:51fd:b7e9 with SMTP id
 d2e1a72fcca58-83ee83ab8e5mr5042805b3a.20.1778618208783; Tue, 12 May 2026
 13:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
 <487628C4-596C-4870-A652-E1670C700AD7@gmail.com> <xmqqa4u5nnxq.fsf@gitster.g>
In-Reply-To: <xmqqa4u5nnxq.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 12 May 2026 16:36:36 -0400
X-Gm-Features: AVHnY4LLJCvE-zhLmN6PXUwEgf9KSF-7lkBxspQkQUA6h2CUNTBhIPnRNOwnQf8
Message-ID: <CALnO6CBOY6xk_sWeqtwWJXp9UPbY0Opd8Af1xk-j3QbdAtbOOw@mail.gmail.com>
Subject: Re: [PATCH v15 00/13] fsmonitor: implement filesystem change listener
 for Linux
To: Junio C Hamano <gitster@pobox.com>
Cc: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Paul Tarjan <paul@paultarjan.com>, =?UTF-8?Q?G=C3=A1bor_SZEDER?= <szeder.dev@gmail.com>, 
	Jeff King <peff@peff.net>, Paul Tarjan <github@paulisageek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:26=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ben Knoble <ben.knoble@gmail.com> writes:
>
> >> Le 15 avr. 2026 =C3=A0 09:27, Paul Tarjan via GitGitGadget <gitgitgadg=
et@gmail.com> a =C3=A9crit :
> >>
> >> =EF=BB=BFThis series implements the built-in fsmonitor daemon for Linu=
x using the
> >> inotify API, bringing it to feature parity with the existing Windows a=
nd
> >> macOS implementations. It also fixes two memory leaks in the
> >> platform-independent daemon code and deduplicates the IPC and settings=
 logic
> >> that is now shared between macOS and Linux.
> >
> > Troubleshooting a Gentoo build failure of next has me pretty
> > convinced this topic is in there already. Junio should probably
> > check my math, but I think that means we want to see fixes on top
> > of that base now (unless we are reverting this topic from next and
> > queuing a new version?).
> >
> > (The failure is a Gentoo-ism; we carry a patch that stops applying
> > with this series. Not anything this project needs to worry about.)
>
> So is there a verdict already, which this project may not need to
> worry about?  This has been kept out of 'next' after getting
> reverted but if the breakage was due to Gentoo-ism whose workaround
> does not need to get upstreamed, and if there are no other reasons to
> block the topic, I am inclined to mark the topic for 'next'.
>
> Thanks.

I think Gentoo folks know what needs done (which I will try to spend
some time on soon) to adjust the patches we carry. (That will not need
to get upstreamed, no.)

I would certainly not keep this out of the tree only on behalf of
Gentoo, unless there are other issues.

--=20
D. Ben Knoble
