Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD1E571
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771228512; cv=pass; b=kT2Rz45zSvkvYGm0kjDAgYEUHh7UoO6EaMPJvlzmgJnZtet3YDHrbmQfyPuY/AJHjqTvz5Uyyl15bS3dECYjVEcKD6KPW4RCJNhtW/NDt2cSf5nzmJuG/VzjfNigkXHIsSSrLIMY6YBO5W9FwHrBi/iJp/9Phn9y86hv3UiQ/xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771228512; c=relaxed/simple;
	bh=gMVOA32OeGyBrXYjl/UFFloU2jXssjX8sPvaftm3erg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOgpyzh6sXNf4vBHPy/imp1X+VpSBc3UsVJT1wmQajPDoMgdkdVOSHHcqbsvUcJf0FgcbJxLWwzWWunPmIK6AzjkxGZes16NCn3mB7LwhZgXHwPeSmKFHt/1Z/otPZ4QNNe5C0Ra/P2iYTq9o5Z1T1qfuqLmNVWmtayx+NVCIiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KukE/+xx; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KukE/+xx"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3871017fea2so35410331fa.0
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 23:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771228509; cv=none;
        d=google.com; s=arc-20240605;
        b=HJYNd8jwgQpWmRWo2pTxHUKYx01tej7dCUnnM4vdSM9mIQHF2zNfR/rFGt0wmMNMBr
         QGKxwG73rLT+7eXrWtLQabmn4GwCn0oEeoqOo4FqRingtLHDSDHW7IYSeC9XDQifixk1
         rzYF6dPLiN+reoMT3KBTdOiIHe4eUbgqDSd4xS8JR3tpMRqzx9mbFa1u9QEhj1r1AavW
         Uw8HQCVPUCu2cPiNL6PnJqNRReZ1ldgfAAdfF52kZB0itv72omoyT5cHyqNN1iNxJ1qr
         sLK3F3Ji7JIh+SrkK0nbsNsGA5zJ4f4NKJH8FW8CcpRMw74KBtQnga7Uu6rmCfHhf6CJ
         J8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t4LDs++S/NtEUGEKdOEzGC1b6ucLjhX1HuLXrLBJSc0=;
        fh=lHgJOfPjyunQtBD465hhOC+yrhKR5YfusrAnOoqGLxY=;
        b=BnJFbHTiais6+OtRKcs4e2yzj/EtFeuEKeWVgkTO+RI/K13HEDTympx9yRazoBuem3
         hruFxrKky5eoHEGwWqgcU8up5qAzBjNULJmks/QK6Vj90pjA88upY9xpwMcuIluV8lRL
         +H+63tr+3ZVaWUJQVkehnKNehjBRb+BxeI9MuTZTvMPogzB7tbtY2F5MXZYam+2bzEnB
         s50lyaOur1j0kIST5WUhupOXXUtv6Gf+1Hqft+igdmAclT7HYntUbHp/Z0rXLf7Ra9l1
         IXxHh9Vb2/mqoh34pnqH1LocggcxQkwdDBYHrzoySoeZ/xPu5CFiqSnU8dLfgUq+9pZ6
         5CLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771228509; x=1771833309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4LDs++S/NtEUGEKdOEzGC1b6ucLjhX1HuLXrLBJSc0=;
        b=KukE/+xxP+vvnGn0Xv4nYtZi1vr56MM87gqCTv/AM/uKM5h1Go8iMQKi8Mcj8Eybtk
         ciuHcNIBLK+6FN2LgoYQ016riQ1DP+JUXm2KHtr/7viLBg0CUp2nfe3Gv1FPS7VXwh4y
         r8W4hmnwPFR0gTXTguyPQWbMbhnnBFzMC0UHP8coExM/KudFydQeAGRiExF+mPSDhWHq
         Zs5udb2yy2BYtoCpKLFUc0rKhdYjDpUxquMLgdNwuwBjZkIEwncGKLj6ySrMpzpAV+fZ
         MtOlKJLxxSZyVAQSICcdv672zJeRsUzPLwjxuYJFXdKQkl3qjLh0CX0a0xk4cLGtbIVb
         GLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771228509; x=1771833309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4LDs++S/NtEUGEKdOEzGC1b6ucLjhX1HuLXrLBJSc0=;
        b=O4v4MUYkQy0jEaFrVoiO1HaiTQwdkcFnIOzO2Z6fQv982v7sl7A/7rrjtqws8jAzGW
         IXKhIKb5b2S2LSLgLKb0Qi+4hoMa0wLCi97iTKc5LPDvTUMOtxsxvpK3xXC9Rv91N81W
         6tc4XPwJYQBOmwsotLZ8p8kyV7RSxLdmGU9RGPmy29MQcczQkZ+LGXcdyNnhC9vo76gC
         +CkVOzt598SnNCfjJaUco03a5ISpDTx27pMTkM1sgg0X3aNOAX9TTYCvP/2Qrctro7Uq
         0TdpUKGethd9jJ1sfGQ66TxoP+u3OoFVpaH61AnukghSNB6OBl9mpGEBaFb6vij5yWng
         oTpA==
X-Gm-Message-State: AOJu0YxebxAOTvSYk5h8dV1NccoisZl/Igo/HsAXlOi00gFTs7VslbeP
	Ah/oFc95yIiu+YC5qz7SaN92NdH/I/xDAOg0Ijk79u/efMnz9mwNr0kjRZJLWAJzGSKaJ/ZwNHE
	D4/E/DQQM3fvThHW11WCy3BcbWHGjt3/TQH4wr3y4ww==
X-Gm-Gg: AZuq6aIhjsz474CrwrQxYe/eg2dFADn4v4EYqg1HVS6v/kKYjCNdZmsq4r1k7dlZw+5
	QPuwTqOeJD5ruX7Lv80coBnRFM7uKDL1t4Yl58gYicRXrrQOiKkUXoomER+19bimdOrT6u70FhV
	YVscLmSjDJdLGWfHgJkXPAA4Y/eTKA06fZPWkThOwCfvtufuFS1h2ouaQFml92ZK8LnkV67w5B/
	CNyNR9ETC4v16s3XzHzpuOc5yCQjfLcqo82rs1gYKmIa+6MuxC0keY0c0TYZ0kbHuQa/wWaN34S
	AmIMkVw1p8UkJ5covHyPlf2R6vuinuKR3kJRVYI=
X-Received: by 2002:a05:6512:304c:b0:59e:1930:d932 with SMTP id
 2adb3069b0e04-59f6cfe8fc3mr2304726e87.13.1771228509013; Sun, 15 Feb 2026
 23:55:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205080853.2034-1-kumarayushjha123@gmail.com> <CA+J6zkRtjxa2BUoa9SMXVET7w4O6=b8iYMLPPpb4REROPGGQNA@mail.gmail.com>
In-Reply-To: <CA+J6zkRtjxa2BUoa9SMXVET7w4O6=b8iYMLPPpb4REROPGGQNA@mail.gmail.com>
From: Ayush Jha <kumarayushjha123@gmail.com>
Date: Mon, 16 Feb 2026 13:24:57 +0530
X-Gm-Features: AaiRm50Snunb8gdlk6TEcTrQD1SemFuPwJdl8ZGgTv2deWSt4UFYz9TaxbOGnjI
Message-ID: <CAFNBzOfy6Gcx=jcDDBGzwELskTAAjKbNiDNGwh=QNLz8T+-O2g@mail.gmail.com>
Subject: Re: [GSoC PATCH] doc: fix typo in tree-walk.h comment
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chandra,

Thank you for pointing that out. You=E2=80=99re absolutely right =E2=80=94 =
the subject
line should use =E2=80=9Ctree-walk.h:=E2=80=9D instead of =E2=80=9Cdoc:=E2=
=80=9D since the change is
in the header file and not in Documentation.

Would you prefer that I resend the patch with the corrected subject prefix?

Thanks again for the review and guidance.

Best regards,
Ayush

On Fri, Feb 6, 2026 at 10:27=E2=80=AFPM Chandra Pratap
<chandrapratap3519@gmail.com> wrote:
>
> On Thu, 5 Feb 2026 at 13:39, Ayush Jha <kumarayushjha123@gmail.com> wrote=
:
> >
> > Fix a duplicated word in a comment describing the return value.
> >
> > No code or behavior change.
> >
> > Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
> > ---
> >  tree-walk.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tree-walk.h b/tree-walk.h
> > index 29a55328bd..9646c47ac5 100644
> > --- a/tree-walk.h
> > +++ b/tree-walk.h
> > @@ -177,7 +177,7 @@ struct traverse_info {
> >
> >  /**
> >   * Walk trees starting with "tree_oid" to find the entry for "name", a=
nd
> > - * return the the object name and the mode of the found entry via the
> > + * return the object name and the mode of the found entry via the
> >   * "oid" and "mode" parameters.  Return 0 if the entry is found, and -=
1
> >   * otherwise.
> >   */
> > --
> > 2.53.0.windows.1
>
> Nit: The subject line should preferably use 'tree-walk.h: ' instead of 'd=
oc: '
> since it is a change to the `tree-walk.h` file and not 'Documentation'.
>
> Other than that, the change looks good to me. Thanks for your interest
> in contributing to Git!
>
> Thanks,
> Chandra.
