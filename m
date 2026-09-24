Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DBA44E052
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279038; cv=pass; b=HLwIcpElO7HbeFfrCwPwswfl2TCxqKd4Mie1c8UyOEeyFwVM4CwWmSlHn6mT/eF13ZicHhFWKq2U84fF+poLXCB0WR2KLlr4yeQrb5jw0F1DdxKZ+VGacoEmH5+hLQn2NuUDnURkMD8sWNfFej26qEjJLJNgMaI8AyHDCi66728=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279038; c=relaxed/simple;
	bh=r1YuAf4cOrzmQm64blGrQAnI37YISbmlG3z/7JSbqe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogTZd4UDGFxaNYV+JtiqTD9v6k20Fkn3o37m/SvaQQi5w3dRef0jmet+DKNzb/quNWEp3CTzRB13gkhYeDGHlvxMwLkx5lq+TSgumAzAG5U8Zqj721s3RweBePS+bJxngrVi8+HVTQQBRAwML0Qo9f56pkE/2Yt3F/8SUWgNVo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ru5M9VOt; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru5M9VOt"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a49bc59559so815211fa.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 12:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790279034; cv=none;
        d=google.com; s=arc-20260327;
        b=N61mLamhuKjUY5vptkb+xZ9hLxPqcd7+NyIL218UyJeb5nDKkYJNs5rV5YsoiUEUj3
         SLasvF87H9bVbeO1P+4MvMqENqE6zJX1aK/TmFxCHpYVNF39VT72LYm7jCl+vQ4i0hJ+
         pYR/98PSShILcj53MGkXWneDMvMeaHHpkZ2SQciI7gxV3QUBEZDlkqcM+2F+XYw9YYw9
         iosSyGTYWyxmIOxHfscOy6WezAvBAsnw23cMrmjBuOsPsbMMvMoLymaLsf00Ji/nsuSo
         wzZ2NHQ2HLXa2mgVpkSrrUR2QHyu2g8asAuBpTa5OuEB8OgKjysgjQSuMgiQqv9sE8TU
         pCQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r1YuAf4cOrzmQm64blGrQAnI37YISbmlG3z/7JSbqe4=;
        fh=Z7dcLEAaNB5WfDOIiuJHhuN2t/+UV8Jr3gL7ZRfiE5k=;
        b=MYmsuTrzDMl1771+OsNuC1KvxxzoCBDLlq4f+pS9sQ0RqWIYEjuOHlN3N6qmroj17r
         XSzmRd/830KaLhjG509i/0Vz3ODUAd5S0ZKJOzKoUmNFATMTkHd7S8nNLI7qrUApBDxa
         6FINtM9TkZxeU5UoO4LagNBKxjoq73+fBSDKkj+sZDTT/sr0tIWNlGQV5o95gty84nXx
         FPFrFITIGJwLwAPdxblgNeW4GHYfAlRenQgBDEp2uQL+kNurkohW3xQ2PxIqlwjxy8vr
         kRDVqolEH4Hih1QZw2TyD+Yiztn9HQ6nc7YFdkrIPvVj/by9xpop0ldNibjtzXtGt59n
         meZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790279034; x=1790883834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r1YuAf4cOrzmQm64blGrQAnI37YISbmlG3z/7JSbqe4=;
        b=ru5M9VOtFUYy1eLkDiu1LRI6rRFZ0cJMMqcFrelAf8Is5sobHcNICXcdnTwH0JwnDY
         PoJgKPVmxNkCKBkZK/CDlJU+s9p5WbQBamLaEPlks+rKiN5kFLdiT2mOJy5ByoLfRhN9
         c7X498hyAzbfL6aGf9Cm0cpLl1SUwUTBHGsjJAkvAFpQN4lq3FWBvJR89oA6WUP6l2yZ
         jQ7rxOFFDd/ZXxQHMygrt8uInqsnFcuBwFQ8eSPPhifRKT1MU1Q1D+8kMcmFIIilCdtA
         X2QF8yoHDaZo8hVPw+df/G3M6qjt3pRjKYlQLC7+bCqRxMZndcT1OQz2Dqq/TksGEyzq
         OICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790279034; x=1790883834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1YuAf4cOrzmQm64blGrQAnI37YISbmlG3z/7JSbqe4=;
        b=DoRXq7PLrFLWNDBHsrUo6UB8R0eGu4o4RO9JzPz/DlLhZCUtyz3saDfJKeJqn1Takt
         25mJHNfRXn76Rz1sJhufwn5lj0xdmeWgtzoYXRVDlyrirdPR8u6G0efTLlEKS8uOscDQ
         Kl7N6LYwpPlA3yv15UK8qEVGWh3UCbn04LjiraiyTS87u6T/DsGjvH1jM7cvtaw7wGIW
         V33VCP6fc7etiGo0CheSfxY4W9TcmfWYf0CQNmXZXU8FrJeHvahh4I0HGOSHjtU1mTxB
         gUbKWapLf72IzC+VvznjE1q6bSsyD1CSjKrL6RTUBPcRIblwDOLO6CNbIPem8wEGVqfG
         ji5A==
X-Gm-Message-State: AFuF++lJxGfDVLhqaRyD9YDL/Ei4IErKoIt/jRpn+J8EJp4lCYCD0qEQ
	xKlvKx1awn7QWoTzPpBGxc6uR3Mx2Sg9jbdnP18cjA7QlozS96s3zXyEhponmnooiRsel6hbxeT
	HYN19QhmT6qWq4NRUvOZyPDVsyMaGpkU=
X-Gm-Gg: AYBFou0FoTUvZ2gpQco/GafDG/OxW9N4K92QyPgp0ow3A4cZXnZzFXVYSnSzhY+Ys4B
	luOBPGriihNodNZT6rU8WWbDYlp1+R+tog6oMvSZ7rLgQxY8kOVFEGGfrIDi9g3WMOyXe1RJzPe
	CT8AkK9Crdsg1tGU5McDl+mlRiFuNZ2KKhbw/lLFNsIGkSjA2BpPGToie0EAUND08JRFLxmZ10a
	x/3zKWWELOOKcCYHhVMlVm66msjpFYgBUgScgP3Ln8vdVU6uYuvlcFm8/wDYrxdPNApsSdOLi+w
	ka896VgFT0Dahz2nWoPiq7nsZ8l9/icL8rcXojY+ugNUooGjuOGr37knRruc7eFz1QaOZjkqyaj
	TdlH15JZXzJvgK2dOEiYVXw3tpvIu2tyNnnBfKM/Mlp5oOWv5weYOfOxyGDA1H3rn2H9BGBJOq9
	8JPKaW
X-Received: by 2002:a05:651c:a202:10b0:3a5:e541:4236 with SMTP id
 38308e7fff4ca-3a64c7a8f68mr15731fa.13.1790279033824; Thu, 24 Sep 2026
 12:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
 <cover.1790196627.git.maciej.ciemborowicz@gmail.com> <9b76cc2c40a2b1fe727677a9400e3b26ec1ab437.1790196627.git.maciej.ciemborowicz@gmail.com>
 <CAOLa=ZTWq6eiqCwUyUhCffTn1=f9pdAip7nsYJMnaPPUuccB8g@mail.gmail.com>
In-Reply-To: <CAOLa=ZTWq6eiqCwUyUhCffTn1=f9pdAip7nsYJMnaPPUuccB8g@mail.gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 24 Sep 2026 21:43:42 +0200
X-Gm-Features: AclHuK9DJpl0Zd-K6GV4E_FMLbraxvCp8OGPAihXFeETHQ0TFM3WrS68mWyq2Vw
Message-ID: <CACQ=SRH2ZRgy9RY=kXcJFwBwkHdoqCHuCturg4B1XqRWCSD_eg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] refs: allow callers to supply old OIDs for batch deletion
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Phil Hord <phil.hord@gmail.com>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:05=E2=80=AFPM Karthik Nayak <karthik.188@gmail.c=
om> wrote:

> This also completes the conversion that was missed when
> batched transaction failure support was introduced.

Agreed, that sentence is unclear. I will try to remove the batch deletion
API changes, along with this sentence and the caller-specific approach.

> This change is totally different from the rest of the commit, I think it
> should be a precursor with adequate explanation regarding why this is
> done and why that's okay.
>
> I'm also still of the opinion that this shouldn't be done.

I will try to leave ref_transaction_delete() and its null_oid
BUG() unchanged. Instead, store the value observed for the
hook in separate fields that do not set REF_HAVE_OLD and therefore do not
constrain the transaction.

> I'm assuming failures is to count the number of refs which failed,
> wouldn't failed_refs->nr give us the same result?

failed_refs is optional, which is why a separate counter is needed. If I
move the solution into the common transaction layer, both the failed_refs
parameter and the counter should no longer be needed.

> Nit: we could inline the size_t here.

I will fix this in the next version.

Thanks for the review.
- Maciej Ciemborowicz
