Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541FC3D9024
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453479; cv=pass; b=TL0zlMgLdnrh5mKpt8Dxu5jHA2PMhyQMAAG9NR1fPQXDgBiy/aa+1ufVZ79HWGrF3xpmvOgmFL4sI27rAgmUtd6v/fgbCU+gccTiWra1PfuFEO3ZRre3gMIsvzlyiufebGu8hRlaoD2Ma0EKVEyjfY+9ddOEyLekCp9ulUoRX+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453479; c=relaxed/simple;
	bh=/IgzxZ1PVB9QM7So4rbdcm1vpCQfDrBTrfe/8BpV86o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmEWBytfosb6rRTxMBsuqQfZBMC7DVDD/2PxgYHaNHM93E0WzncUnMgIfTCt0PtJA6NwAciW9RKYnF1m/Dn+s0d4gRS1Nr1Nob0RBMB6Cz4RUEoX7RyuHY7Nf3WAGDLcM46djYm03LPPdd7gp2IyrXZBtIbbskufAeoQ6o4gNqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIx1tlHJ; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIx1tlHJ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82a7539851fso8128b3a.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 08:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774453478; cv=none;
        d=google.com; s=arc-20240605;
        b=lXzP3nfEHVB3ksd8MA4D0JPmZdb/OwiFZ2OxAe6E46Up0H0P6gaVZ5iLstlvplNHVE
         5JlECHEIoAkrgvvSJbslVPQ9HaMSVuLUkJSV/EvUiNr8XXBmfLXi9d+SRm5PvL6dFzDX
         GquUQNRNizcOcfuHxMe34ocbLq+w31oxd3iWfUD7AhTuV1j1bc/Sd+HaVjGVxsSrr2XS
         aR8tF2bdDAcrYJ2HsosnnBy3IfT9srK92n+yhkgyEmBN0UTDWnlKMlktLNXk547yB3WU
         OY3yexRA7yFbT1//mW7lg6INO/vkjlWPrxpN1USHm8lP3TU1+RCcThErbHVJYA1Qcxd2
         Jr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/IgzxZ1PVB9QM7So4rbdcm1vpCQfDrBTrfe/8BpV86o=;
        fh=bo5yI0LSq1KdRlgM7QvxVoRAuaO1W8lVB+kobQRX1Vk=;
        b=f4GbQs3iWBkp2y0qOalanhDoka2a8M7MVfNAO22+ccKkQXyHmHwa6kq/FwfZOBO8T4
         OFROWoB4Xiqx65FZuqgQpCgpKLfOfyeQJrqph50gU04lYjT75EdIUAd8ocvzXPnCUZxC
         HMiLU/NnP4How1BYrQl8qWBX6xauS2UeSw2u0HgMeVjc+SSk6/7AxtsfY0rwtG9Y/D8u
         ZFJCVspX4ahxkisKYHYrxDQWxlKKDJHvN29PlmY3JM8MyYV9Xvhl17CweIcuO3DX8UZX
         pM7pcbp9fwueC73HA+vPfUa7dQMcjyCmydy6WOwJjHpi5ok5iyZtRjCCxOeCr+GIF8ly
         v4Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774453478; x=1775058278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IgzxZ1PVB9QM7So4rbdcm1vpCQfDrBTrfe/8BpV86o=;
        b=fIx1tlHJh4riAvVnahJmV1DOgNnG0MzGVwR2AtadbkbReVpdSz1lPULQot62E8C8cY
         /WLkotO6WudvI4YNhIld5AiOC0hX1lhiJ7HQKfCOD/S2P/pzeylC/CWAtqqiv6/AAcft
         9wKUyrruDrZGiDCrF+tMjZVd2rux6bIjnRRwvRRCpgz7eWdmPoj60rH/hmeMmOzTFo4K
         bkII5jF3jIRC0rXbhwd5eqSfdEtES1HAwRrwXT+cTZIZ6ijUzKunQnQu+kiyrcOx9jOC
         myg7g3xmFpWgg4ClTgGYY6idWUrwDzeM0eqPTF0FQCXaJgW5/BVRnNM2u4OT5HbXF6X6
         dt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453478; x=1775058278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/IgzxZ1PVB9QM7So4rbdcm1vpCQfDrBTrfe/8BpV86o=;
        b=eXAP/EfF0R/tKkK8dWyaAJF3TXHDHFoTFLZLXy2w/6IDW243rpDb/o0HXQXincuqty
         3zgR2nN5qRR5Uz1U02BPsOy8jzkKwa9P/ujRLrnJ9PQl5dCjlSUNDSVTFRXEoLOn1e1p
         Kficy0P7aHh/wjY9nJr9mcMWoKRlIyBq5CXmdmSINZUcp9r7aM6BoscuYcwt+h2omP/L
         EvJDnzyHEsPZmZRsaNKBLwQDQrKBftyA8qBGUiougy0E7lLpin59xURVt3Ojzs2btqBT
         UrWw3fRj3YiHRpmLPm/ODViOBbNN29I5N2LaXleHmraHEGd+pAE+vJR2Js7EV740a5oi
         bpcA==
X-Gm-Message-State: AOJu0Ywih5e3JVVEEctEYecsIVUGuGJnqUfZYiHtETdWP4NaE3/uBaSY
	w+hLSkrXh8W+4pfrVFopeIFOrfaHBuAvJFpo1YgKEnVZiapcGWVQMauo8iHCUYjVCDXM/9fxddg
	IJPu4WZyZQpRQEMcFUyKX+LM74N+bzbM=
X-Gm-Gg: ATEYQzyQa7IN5BDp/5giyjeBiRIncE10Gr+VT9CtDhhYw2kFjc+taXuLevUF248NnSU
	SBXF04brE8XkBj16R4q3ck4KoVlC3hs9piqK15eUbYJRVofXCaoaWNog3w8l20kHJSwhlgv0Lk0
	Yhih+zdiZUjqQkgYGSLxcHwvjG0K67uDFXUBfuZ+2qbXwCN5ilcW5OwNfprcCWnqMDmSRsd6E+8
	TjT3XAypqMyWBXzhK+7jU17yYRyXWCgBRQwB/St6rMD1GJd/+N+sdh4Ln9vSdD2cxPLNAFufPVT
	zL0VrqnjywigGsbSVlBLgSDJfogWqKgt3XgvaCKvG56kojoFpIJbcD0FNmnUs7nZHUTLDPaBFW8
	LAgUq
X-Received: by 2002:a05:6a00:4147:b0:829:8139:d5cc with SMTP id
 d2e1a72fcca58-82c6e120e91mr4186524b3a.62.1774453477579; Wed, 25 Mar 2026
 08:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325075055.354709-1-luizedc1@gmail.com> <20260325075055.354709-2-luizedc1@gmail.com>
In-Reply-To: <20260325075055.354709-2-luizedc1@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 25 Mar 2026 11:44:26 -0400
X-Gm-Features: AaiRm53tii8Na2qJGJJCelXFPUeMnG__aUEP-oVqeUQ_ZxQ82LLOY0VeBFp90Vk
Message-ID: <CALnO6CD15Tcs+Sr7XDO0eB3KSC7RT2oawTiSpUGdrQkfbPJQtg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] add -p: support discarding hunks with 'x'
To: Luiz Campos <luizedc1@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net, sagotsky@gmail.com, 
	Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 3:53=E2=80=AFAM Luiz Campos <luizedc1@gmail.com> wr=
ote:
>
> When using `git add -p`, users can stage or skip hunks,
> but cannot discard unwanted changes from the working tree.
>
> Introduce a new 'x' action to discard the current hunk by
> reverse-applying it.
>
> This idea was suggested in a previous mailing list discussion:
> https://lore.kernel.org/git/X%2FiFCo0bXLR%2BLZXs@coredump.intra.peff.net/=
t/#m0576e6f3c6375e11cc4693b9dca3c1fc57baadd0
>
> Feedback is very welcome.
>
> Signed-off-by: Luiz Campos <luizedc1@gmail.com>

One feature the Fugitive Git client for Vim supports is to discard
hunks; when it does so, it also prints a message explaining how to
recover the hunk if you need it.

I think it writes the file as a blob to Git's database before
restoring from the index.

I'm not suggesting Git copy this necessarily, but we might want to
consider how to help folks when they lose a hunk they didn't mean to.
If it's never been in the index, it can be impossible to recover!

PS How different is this from "git restore -p" ?


--
D. Ben Knoble
