Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B294D32B107
	for <git@vger.kernel.org>; Mon, 25 May 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779705186; cv=pass; b=mTwx/teeUt7SBMDgL9va0cQ8YsJ+BK6cgIXJPLzhpecOeL0SYuSZByeLlBKRYSoaQAK2z+H3mdBFNEjpOMTL1DYMn53dZ5ERjBLcp3RC3M6ccc8btMEslKHrqWTGzaEyIoJ4k3UNVtsWT1iyE/lJCC41pgCUHa75P5+S7/UaWwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779705186; c=relaxed/simple;
	bh=UtYncPBvg1kLS4erOQwQw4+YkE4UZ3AWG0Wr5kq4c6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itgDfKtaEHD4haQ9txH64XZ7NxwMh6Ee6M8NhnEsNveHGm9r2ckVpPFBcd497SrKIhr/O0WpGNi+BDOGadBc8LS+oIiZy4AjRgWZQJxYHop/mR4UHUiB+nS7n+3yLMCsNQPMNdZX7Zpr8umdci75pPp13Z6tqfOC1FpfE/NJVMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3wwJ96j; arc=pass smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3wwJ96j"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7e62b6163c8so397837a34.2
        for <git@vger.kernel.org>; Mon, 25 May 2026 03:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779705183; cv=none;
        d=google.com; s=arc-20240605;
        b=E3raT5NAXAfffAIS/ipEsC7H3JDFGnPCqikQAKps3dJYe+phNeWawbzncZOIFKpC5E
         snokPw+2R8Wqzy39Lm6X5WJRlHZU1MDB+TxfND+Ak3tInzH4smBuDw5T5TqIBS7/pNBZ
         lZ0/lSl3yq2Gn88TinA+5Lib0p8CHOC9YSvCQ+kvC1nxzmJS7iSr6fo8TEs28nyzLCwl
         XG/TmEUk6zybm0oZtbkTarTVeI0tw2uP/zSXauMorfXUVDXvNDKM+LtLLpWQoqcr2d62
         aHZSA29AlD31Hklq93uVd9V1AaEeAbPSZr1G3rYhI5bkUXgLHYbFuz29dW07bgpg3elu
         UlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U4FPBM4AIZj64BDNM2ak/hWsAGlV82xBqth2ARxwFUM=;
        fh=cOFkAClWdRs8zIOgCfeP+8Ar8eDwf47NIxAuXWLkNIs=;
        b=KzXmI/qui+ZaEtevGZTm1BodJqqmP+lpbilz+y+1r0vlEE0opyJ/aTIb8oiiO37Vq6
         oeon7CpgBOQavlu4r+cl3g8Uo/8dXKkanPflMgCVRjEQsjy2CZPoEHSbbCBOqcmfyyU5
         7doGCVplhVw6kxWsUON1fz8rhLYF4f2VBQ46JVgyBPKdVni06DiVWqAlBKFy4uWTZHRs
         qhxdkeFrK6syHkPdRHH2Q4Mse/fNXJdFWMjkb5L7Q8fNbRIV5iJIfZuVVfHQGy0mCFzC
         VqwlX7rkMRFuD+vZa/33UXIqhmxUXz4NIWFzHfCUCgv0etIjHx9/w1qI/KOU1oHBtjvI
         p1+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779705183; x=1780309983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4FPBM4AIZj64BDNM2ak/hWsAGlV82xBqth2ARxwFUM=;
        b=K3wwJ96jYtkj5wnv+/IQIzck8NKL+ugIOErPkemYQxsCFBDIH5KibdaLZToYYaRNOE
         pLZZKb/EmJX51gtXUv9D3CC7YZYHdIdKW9PUwzG5Hmysh8YYh2SX30UwQn3FQ5s2ksK5
         pZcdpP2LFLVkPu6BC7DPnYMtP84qEfXaNtmVk7qJhogZukRVKYD7tZmOFcCBdgsp3z6G
         PZaAnsXK1zmu91kr2ocFMKI9AGoVFAYAl2LljPhbgME/lmFtAbfYFTTtuS3Az1o7Z3vI
         UfRvZblXMkZhy32rA/pbeq9hRYHngA+JDWSIRNAmpXgAbt3ZY/PC+66ugw6B9ucwZxA0
         sP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779705183; x=1780309983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4FPBM4AIZj64BDNM2ak/hWsAGlV82xBqth2ARxwFUM=;
        b=ALv2UJUa7Zwul5Ifj4l+XTJFR6opvMVZm/9hsNC/sEYM3pDYz2aU6pvTRNY5Z+xZ24
         LNOIixB5mB8i5fY/e44g2GI4Z0JF/U3DxR9XB4bNYQAWZcA/DJITGkxnWvAmhA2eYMeD
         L6rPnE2RvP+tew+65VPEH8xLCnkpGqCwioM9m1ym527l+9rVeB0nb7IVeINakdj0bmfi
         TErxrWo7DemmmQXATYilTJrBeBCN28KGEWAQ8If30ojBSJZi1vJCsarzcRHvhRHOsc64
         yxehlf6Ktd5oyYSVLhHZLp8xi2ifwao6d/K/3YFcvd1eUO+aHrjzBTGshjkQ5iga3k5G
         vpfQ==
X-Forwarded-Encrypted: i=1; AFNElJ//M8AcsiCiw3yNhmiwsh4VuAfsK9ja0NytTT4p3AbXy0UCWNURcjBH1ICIACr1ReUh9pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzatTmW+I2fmcekuYE0l1ykaPfHI7+omPmQc52f7vZiz6crvyA4
	H8BcfXnCFp2U1cqARU8q3vrNLlVjkHYznU0+9nfnMzdoVB4NZlD8/VNI8TDWn88A6oBmj960eGY
	H1TpR5QNeLs2Sy7hw3Eui+pQgPs10TbM=
X-Gm-Gg: Acq92OEI3EkVOb8r12/X7XLPXsjTjRzjgIP4TgIB3RRFae3LE96SXjQ4xkKI02PdYnx
	Siw6SCeZGivTGafl7nM3+XoqoBteXAPL+eSVcJrJZLu4X+ROHDLmKw70fQ9jlU9cs+W7tFniYzW
	63lax7dvLbso/YMqnU9M8zny2b0aZIc1ES4HYs67fdV50b4PjqqznuL903HlK52Erg530fut/AD
	OnN/UhFqZ2PAEkJ/CgLK/uON2+Yok+XlzprURdKpuxVorSKCW5GhcVdWVu23/HIW28edsqgAdyf
	gLmn6MAVCm5NFjOj1w==
X-Received: by 2002:a05:6830:6d45:b0:7dc:dd58:50b8 with SMTP id
 46e09a7af769-7e5feecc905mr8993134a34.13.1779705183625; Mon, 25 May 2026
 03:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2115.git.1779433093971.gitgitgadget@gmail.com> <xmqq8q9bu8vf.fsf@gitster.g>
In-Reply-To: <xmqq8q9bu8vf.fsf@gitster.g>
From: =?UTF-8?B?0JjQstCw0L0g0JHQsNC70YPRgtCw?= <ivanbaluta.dev@gmail.com>
Date: Mon, 25 May 2026 17:32:52 +0700
X-Gm-Features: AVHnY4KQ6LEgylDTNRRWUCPrtMY8nfaMjpz5DAVeK6GHwz5PUZKO81fZuv5idwM
Message-ID: <CANvyLnr3+tTYb9zxCL03oaDGiyzNCW-+==y_avcMfAwYCkY9yg@mail.gmail.com>
Subject: Re: [PATCH] doc: clarify push.default=simple in triangular workflows
To: Junio C Hamano <gitster@pobox.com>
Cc: Ivan Baluta via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 3:49=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Ivan Baluta via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ivanbaluta <ivanbaluta.dev@gmail.com>
>
> Just noticing, but don't you want to spell your name just like you
> spell it in your e-mails?  I.e.,
>
>     From: Ivan Baluta <ivanbaluta.dev@gmail.com>
>
> Use the same name for your sign-off below.
>
> > The documentation for 'simple' push mode currently focuses on the
> > centralized workflow. However, the implementation in builtin/push.c
> > falls back to 'current' behavior when pushing to a remote different
> > from the upstream (a triangular workflow).
>
> It is not just implementation, but that is how it was designed to
> do.
>
> Whether centralized or triangular, "simple" works as a restricted
> form as "current", with the same restriction.  That is, both
> "current" and "simple" push out only the current branch to a single
> destination that is configured, and "simple" insists that the
> destination has the same name as the local branch.
>
> So I am not sure if this three-line patch adds much value.
>
> I agree that it _is_ confusing that the current text singles out the
> centralized workflow when describing "simple".  But the remedy may
> not be to add "what happens in triangular, then?", but it may be to
> clarify that the need to configure the push destination whether your
> push destination is the same as or different from your upstream, no?
>
> Something along this line, perhaps?
>
>     `simple`;;
>     push the current branch with the same name on the remote.
>     +
>     This mode requires that the remote repository to be pushed to is
>     known.  When pushing back to the same remote you pull from, the
>     current branch must also have an upstream tracking branch with the
>     same name.
>     +
>     This mode is the default since Git 2.0, and is the safest option
>     suited for beginners.
>
> That way, the description would be more self standing and the
> readers hopefully do not have to refer to another mode (`current`)
> to understand what happens, no?


Thanks, I have corrected my name formatting.

I completely agree with your feedback. Your suggested phrasing is indeed
much clearer and prevents the reader from having to cross-reference the
"current" mode to understand "simple".

I will submit v2 shortly with your suggested text.
