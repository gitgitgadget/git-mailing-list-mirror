Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F32D9EDC
	for <git@vger.kernel.org>; Sat, 22 Aug 2026 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359862; cv=pass; b=fBWPgkbpVyivm+tYz509bUcyv1tNPw5WI0+Oz1BO3NefFlQjdlFQlvpX2HHpxaC9yLd4e48erI/+VJmjEIY+8Kl/EAn4akW1ji5L3iRNtEWJ0mw/ta5C71DIz/hS6ZgEFgx9i1QHr3EBc9K2x0khJGq6k3l0bcl2/jJBCtNJodE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359862; c=relaxed/simple;
	bh=Qmxef2UvSHWpCj5qPdwVebPtpNq9ATchK+YXEAo+IHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFSmI9JI4HMhvaCLbf2DZQ8oaYSm55LMo0to8Bv2pOBnVAYIu312iHKxf+C/fMKy4NcU32v7JcZmUxu3quZMRwP/SJoguav9s/CEMkVeSCehHsAimwu4sQmXrXMSq9vMC+ygaDCAUDXkV4BjKZMKQF2aH3JYPb9hEOAUgPvYrEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wo8F2Ywl; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo8F2Ywl"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c0cea8883so13025631cf.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 17:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787359860; cv=none;
        d=google.com; s=arc-20260327;
        b=PE1zEZESY79LcRo8gjSSm1ZiUbrsRbVbpLF2cLrT0mvH098yZElKb1/NCoJBtjyw9S
         Bo3EdbWYzYcLwxleC5feIXUlIoBiPvUjttg+PdplB9+NmbiM/9J/0Ov2zu6syWMNxsat
         s7txoLRW3e96tj/yKxXh4qj3QXz6aVJ9G484o95OEGHzataaYD/kOP+PKvZbPiTdKLYk
         xO6oYARbx8ZMwUbD/FcPwXuBUhhk2zgUfSlDh2wxm2jRNTaYY1Ig7qcwckmR25U17TfV
         4tqswrMGrqW/YznRZhk7WfSsrGd+I4m6AKm1sb00SgmBPefDRXN3uuhw9qSthTuaWjSm
         08Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qmxef2UvSHWpCj5qPdwVebPtpNq9ATchK+YXEAo+IHg=;
        fh=bGs+3XgFFAjFpHCQpVOrzjbG9YNE2sgEVYL8LMFT+OY=;
        b=JnO+pN0P60MD6XhsIFjAuQfp1AepXlbaErewrAqxGzEp3yWowZlSKt8dIUDI135Ca3
         sWHA/iXWB5vrARTbFuslZY7thZU/ltqxzI+sEWEotqipQ7PsH3I6UAVOxKiOhEk5w18q
         lN+UeZPOFymC3PtjTJWAzWUR30hrvhR9pYoFZ2K2l41J0OS2SMAtia8LUZpkF5x1z1yg
         P5l4VDZr/KkK1jxJoVuAHFnlZtIrMnasGA1n1IpHKznilQefzLdpN2RFKD7k7oAWeT6V
         dUtdl69IVxzy+yFrjRyqhraP0qZtg4DtWzm6QxB5RTaspHYK03e7dtDnr2WXszZstRjG
         4Q+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787359860; x=1787964660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qmxef2UvSHWpCj5qPdwVebPtpNq9ATchK+YXEAo+IHg=;
        b=Wo8F2YwlOz6QpaUu1MQUMDx2iTEwW1p74lpTLdMcD8kQv5G/DdTWtgPE+6PgZWkDSP
         YqawNtWKi7o+I4PQ3ql5Wfi8BAbjMe9wihgMDxDHew6ejT8KApZEJIHLEX3SnNAXmndR
         s3NUVLe2Ct1FF3J1u5QOGoZln6lO+A34EljeD5zKG9D3kj+bRvs5bQzH2zAVIVNKcOuC
         ig2ej/fpObWcCoTEao0YDUkSUIHBCuRT/kaemcHNgO1LQ02a7qWdE+pADsd9YiSaXghI
         v+5tJHNmPDY1Lb/EYXCBV2ZNZMCvU6V/VKoD1+P+//s7SRzkbPFIt/69tq3osqGOD7kZ
         SwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787359860; x=1787964660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qmxef2UvSHWpCj5qPdwVebPtpNq9ATchK+YXEAo+IHg=;
        b=Eg+H4l5jFR4ba+Y3cQxVd38D2ZCz/bUui9WmfXz47q1TCZQ1CT4ssE8grLCkHsyp+s
         yPvZz7LHrfrNW+N/neoC5gspSIQF4vIcTB93XidOsbRh0NPeZBRv9x3K4A1+S07XnF2G
         qRxh5YjgJR8MGDrbxHiKavzqZFx9JRKVDGwHSOVmtnxRwe32qSHOKFbvXB7VuM7DODXv
         1xu6ZA/ZxgJdg0V4Kr0fiMruwX9NjNvCXdFoEsIblOP5wIRpDog/yCDMX8YzTpVML0+g
         Xo+Z4EysdIoDP4vXjQC71OK2yLluEV3ckYt5V0w3vBa7U3u6XNoWGmQxpBWQTjDC9y1a
         YLMw==
X-Forwarded-Encrypted: i=1; AHgh+Rp85H6EIlpQZTZTNacieHS4GKMXoyifLvuJ8zxSbDiBFrFIayoI2P2gdG0mqbSRvyRQDUU=@vger.kernel.org
X-Gm-Message-State: AFuF++lGHCi+engMnDO5dxLgK9HIUCzQJElHj3L4DponTQWim1aKWWxy
	Tb5Kl8LOhqgAsJiTatnk4+7a477gr9zgVOw6fWUUoU7fiD+UJl6iSV2Evpv4asflENnEFW3MuBB
	9tWI3Q8qxAC6FxpuKeQK5WU4qMhS+7s8=
X-Gm-Gg: AR+sD11TRo/xswwCqXSR+g60aYuBkORP69fSyOpyF43JN1L0XrQK4YHb7QCvetKZYY1
	YO9pLyY5Q9S6i4AmS9SvindsPGucyUv5RVWlk2uEXhmdS0hBlFsyc0j62WFpwwj0Lzs/xDCvL8q
	LNeN3JNWInDevsjw0S6D5+Jb5H8v4GJg/SD8x4YJ4RlKLnEHPbFBdzUBRIBXl9wFucWTiCRuyDg
	P55TgPf+mAKPNz6/aV+y6OVYyMJ4pvLb1TwdSkdNEu+JBRykwuC61Bpe1pnYBQcusxOnY8p96MI
	NwtDxlqMZTgs99F+8pszwjQ55QSh6th1e0if35o4FgKWI93FieY2PTh9ltnmI2df6BR9XN/QK8k
	mnp5rWm42/wSPQHxKVQlBCwpPoh9z42Ck
X-Received: by 2002:a05:622a:290:b0:516:35fe:5524 with SMTP id
 d75a77b69052e-52de2f01122mr171852331cf.5.1787359859932; Fri, 21 Aug 2026
 17:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
 <pull.2197.v6.git.1787259838.gitgitgadget@gmail.com> <dcb84a69a6a65085d468a0a212cea0281605c5d0.1787259838.git.gitgitgadget@gmail.com>
 <xmqqa4qgruvj.fsf@gitster.g> <CAF5D8-vDzp9xhu96Tu0ScmWRHvVyi74MD0NhPMnQ9ayoy6h+wQ@mail.gmail.com>
 <xmqqzeyfxcdu.fsf@gitster.g>
In-Reply-To: <xmqqzeyfxcdu.fsf@gitster.g>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Sat, 22 Aug 2026 09:50:48 +0900
X-Gm-Features: AcwNN1XZdqQNR28dYuf87eYwMgQuFmrQTPypHtG6hzRZcIBT5kVtVFjcHxsXINg
Message-ID: <CAF5D8-trxeMd8HYzy6kD4myf+bynkxOvxKDQrMdmqnvcdpdkEA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] worktree add: improve message for ambiguous remote
 branch name
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 8:49=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Yoichi Nakayama <yoichi.nakayama@gmail.com> writes:
>
> > My initial patch included a warning and advice here,
> > but now I don't think they are necessary.
> >
> > Even if multiple remotes match here, the command completes
> > successfully. This could well be the intended behavior
> > (just as when there is no match). In that case, a warning
> > or advice might be superfluous.
>
> In other words, there is no point in calling dwim_branch() from that
> code path, as the end result is exactly the same whether no remotes
> match, exactly one remote matches, or two or more remotes match?
> Would it then make sense to leave a note there to consider later if
> the dwim_branch() call can be removed?

No. The exit codes of the command 'git worktree add ../topic-branch'
are the same (=3D=3D 0). but the results are different.

If there is a unique match found in dwim_branch(), it creates a local
branch named topic-branch which tracks <remote>/topic-branch.
In case of no match or multiple matches, it creates a local branch
named topic-branch from HEAD.

Since Git treats both cases as successful, either can be considered
the intended behavior.
(Although, if there are multiple matches, there is a fair chance the
result might not be what was intended.)

I am confident that it is appropriate to provide a hint when a command
fails, but it is difficult to decide what to do when a command succeeds.

Thanks,
--=20
Yoichi NAKAYAMA
