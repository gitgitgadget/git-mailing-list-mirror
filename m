Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C5525A67
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986887; cv=pass; b=M12LYNEsGLqIpYp7LJ8t3CZ5Pmf6k0R/EHkgpIJNW3+60Z8uQ3BnW8C0jHsMnHQSrHFgQDdkthtfaaiZc11b4Lylj6rive1LXnv9nGg3oBAndPe8HVXQ6wQ0Ti3AKt/PEIFCUMKBzX86h9Wxuco0MTQtyopR7dxZoAr69MMpb0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986887; c=relaxed/simple;
	bh=xZ2ChW1fX2N/wmq+kB23dhWgQNxR0+0ILGYHkDN9gGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iapHT3D25bobpp1Bxekm45ik5WIRdjEuFXDDkgkwuEdEuHy1aY2UNr9sdIJkObD4grdPVpH9sbn1mYAw3l5FHjk6iHD0vMmsdf0u7o78g7YcP9XlSFFQa++IyldiQBm8irFPrUgZq+Oyistr1T/WPO5bqa1tKWQh1nd+WXwfIKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F09FY2tk; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F09FY2tk"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9905d61449cso174966241.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791986885; cv=none;
        d=google.com; s=arc-20260327;
        b=Y0UuD6LNZvMnF3aZRCTUjsS25kROHNz5v7UkxGu1P/Mqy8LrHXVJdJsdmyTnQjndQ7
         PXE1xUEQcPp0kPj94D9A9XVlcH7tG+BgtlD6a4UYVKDeCPtuu+yErxYkW3i8JoWa+HPz
         IWZmdi8SduZhKfqDZ/UUQI2gtuGIl7wX/ttENZZqOh35F68qHOkIfbGLxe5ec6TlAbt5
         ZQcWMjj9ev0jSIBX3eoe/QxTdYno65Nbg6LFqRV3Ll2dMTEt9fnZ6RWHShNIU8Lu4nFz
         qb5GYgJ2/Voweg2Yg7rDHB8T9tXZewQLiQ45gygF9WelGFMgUPPttoFnGlRcbWrPruMj
         zkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xZ2ChW1fX2N/wmq+kB23dhWgQNxR0+0ILGYHkDN9gGg=;
        fh=gljMF9Lcaf5hBXxqJ+BgXfMXpcA4bSzNbChqntXZp+A=;
        b=h9rhDgq85MPWj9EU7VHgOEIZbAt7RuNRi5EBpFa/2fdFnDoegy0dnKkde/m7a8aNSO
         3FkSG2nh9YKirZLDqeGzkszbm6Gw6Z+T4PbWFVvxges5sHkAKlEVYtw7RHxRLuTFNl5J
         LsFjL1Ng6HjYBjcmHg7fh7QXHtF0+EdFo5Zg6okxAKuEaOdtyFW/RnqS8wy3yESzcSVF
         QP5TC5SoiS0ASEhwRC2yj0kU4YLNR5zK2WYy91FvhRPAqP/iDDWwHxggxveHvMxNvyzk
         YZp4p+LxbEcqFFf6F4QHh+ge/1Fu5J8Fy+j6x/rZdJNvlFahs0dBoSBTt8B5cnKJOPnm
         b/Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791986885; x=1792591685; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xZ2ChW1fX2N/wmq+kB23dhWgQNxR0+0ILGYHkDN9gGg=;
        b=F09FY2tkcEbnGHrz/AUjHxUD7nFm1exlIki525jGNXscsLvGYdfgot8aG21qli+FZA
         gyEY6nIWpVuEVyou4PMuB56RtqJtPkkdF+cK60MW8oLcyYbcyAkIpRkBpmQBysh2h/Y3
         limqufaJWmAX0ll7d3e1LKf6q+QNBcceteg3qMkwjzPMxcKrw9tckM/8GLDuUtyGKMTV
         Kn3zsUhCQ3mwy900pwoO5U4YFC2Q1nU1j+H8OIDXr/dXcy2VyqtPonnyeITsBMEvM2mZ
         LixmeuwVHHEJjO9paybEexVdqlSsytbOjo3odE7x+h0Pi+XU0DwftbCNMTlku41GvrQM
         Aedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986885; x=1792591685;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZ2ChW1fX2N/wmq+kB23dhWgQNxR0+0ILGYHkDN9gGg=;
        b=d0WONENxjTyIRnCcyqlnjPkrziehHGIHrz0tL08rfDV/A+1B6KMj7EAIWURefkBU2U
         CRDEbOUXhb3mIFBFkcKu3gQuea8KOscr3pp4MqAzH8iNnYm03YloPtCucrOl3TmyrkEK
         Qsid4Qf89gw+wMhoDeA/6Xy+9ODXWvfMSxq2+RqI6CyzRzHJD/ldNCkD8uO+NPiL/Yci
         JWI9431JJDKqKRR+7mtSdYR45xEk1kwbiM8djsPZ81I97wJwuBbLFdIwLV1nO+7jV8gg
         RgXYV7FsmiZnm6m4DrmUiROJcz54+eepTpUmC8ScXAJ2uCDHN1jQhbE5RgkcQRKQgjFR
         R1WQ==
X-Gm-Message-State: AFq9FYLaAFun56Jl8Lvcren8Bw8rbRQQxouGEQ957GS3LXhsz5jlaldB
	GCiXTuoHhrFkLOGV66a2MlHCbkAF87ngURilNvabuwdySmq+C4KzyXdy3q6UD2kC+D4Ig1w3q7H
	Mg+m37RBKCkCbpjY14RUiHmEyXPp8Tdk=
X-Gm-Gg: AYBFou2mdMTbfRenLjNSKdeocJgmysRbs4JRqn9ybVMgAGa0mc4NTNBSqGAfbjrZ4Wm
	smo5l595wiXA45zET0DZEmhbj05Db1v9FY7tQJOUQX7DYuUbCyfFWwJA7TKeuovLCJwNm7KXnev
	3R0s1UVW7OVeX8V0n9IyqVIWbufVh7ssDTnEtza5d6+apVynIy53iE4SI9Jy4OlWcw9QLSBWaob
	2aHAU+ShslM8VYJGwAJqTID30/MEv+Yfzh5Lrg/cnveXFvR/QdHFXbTjtfiqxpMccJiPApk/rX2
	l4YhpfMSUjgDVlkm2k9B/ORDFV+Whm9ez7UpAELj8S1QzAxhzN1hH9dPUHrFtkIv3YV7tpM+ge2
	rM3K8odJTF1T8LQ1UGi43kx1WMICHDzLnaxNehrQcYzws/qd5pw/pWU3rLpd6LJTO5L/2eQ==
X-Received: by 2002:a05:6102:5088:b0:7c2:8d98:c3 with SMTP id
 ada2fe7eead31-7cb37281aacmr3922249137.7.1791986884840; Wed, 14 Oct 2026
 07:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+ew3JuatNJ_bQkormLgm2O1DVQ4ZBTXnXnJPjOMcfcKZZ+Ang@mail.gmail.com>
 <CAFpMFfAanhfXo62tF_jm15CWo5Pdi8-B_vEZi5NXztb8uppPKQ@mail.gmail.com>
In-Reply-To: <CAFpMFfAanhfXo62tF_jm15CWo5Pdi8-B_vEZi5NXztb8uppPKQ@mail.gmail.com>
From: Wasswa Edson <edsonwasswa54@gmail.com>
Date: Wed, 14 Oct 2026 17:07:51 +0300
X-Gm-Features: AclHuK-_8qmr5pLfO9Ro0vQp1ZHAF9_PMcB401IiiHSeA-fC8d_TPt3Yd7-2qU4
Message-ID: <CA+ew3JuQ4_xhgTC_rW1AOUzErjmDbsE90L=5wFFPqN52dsV_mg@mail.gmail.com>
Subject: Re: : Interested in "Implementing promisor remote fetch ordering" as
 Outreachy Internship
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot.

On Wed, 14 Oct 2026 at 16:35, Okhuomon Ajayi <okhuomonajayi54@gmail.com> wr=
ote:
>
> On Wed, Oct 14, 2026 at 1:26=E2=80=AFPM Wasswa Edson <edsonwasswa54@gmail=
.com> wrote:
> > I will be glad if I am added or invited to the communication channel
> > for introduction and Open questions.
>
>
> Hi Edson,
> Welcome to the Git community! You are already in the communication channe=
l
> You can pick a micro project and get started.
>
> Okhuomon
