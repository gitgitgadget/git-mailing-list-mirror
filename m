Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7C389DE6
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123084; cv=pass; b=EamrsLoircBQNUpJlPA1rMGmeqy2U53IzxZYxPi15zJ8l0K7+NTUgTYS85SpB4Dtqhws4IJ+2uAmrzKx5ulBnfUsIIAy7wIdSEiPN7+hk4kSFZuTRBM0YOuQw3Yea9FQmGXgHCq6YM917aerv0JsKZrndOQZrtQlAfFaru4CXTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123084; c=relaxed/simple;
	bh=vsTmZoAqpM0SCnhr2YgeOAoS3HnZOLhpFIFN3NbTNDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W60CSL7xAVRXhe1EJjAL6+ufJsgOOuIunBaHzF96F/ihyaOq7DFztP6TEJ53lokzM/7Jbp44I1Cs4q17LuNHymAqKrcniAQkGly5zft6zfZyrB7pTwYxQHaNZf38qCElHOvrqoeiS3kcc3D56YJhtN719rH6TdW3lgWBbnw/GXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8kpO++i; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8kpO++i"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1271195d2a7so1437017c88.0
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 08:24:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772123082; cv=none;
        d=google.com; s=arc-20240605;
        b=TG9FukkpsakeZWLqWubgQELbGK7QMZNyx3uDraMPFYieJ6baceCOQItnXwpAMgZk2S
         bQD4J7mRtrKidfamq25lY2S2BkN2n1sxZ8zDF+gno9uVCd6MJ7YRS/+Jbr4OWm5cBpdB
         lrmFp61yaEOh1HbLMnhkibhfG0CMf3sVlyG01rHIT2mJBkpSy/IiBvPLTLgBVrbBr3Yo
         PiUiEIFDEhL3Uk8GlrimrpXuUjy9FzMswonsewZJLm+KxLEZoMDHstjDV+PAXIyidfm4
         OCqFD/DxZq+W1MTiJDb7M5Q8fyWI7JVYt1x43F/13Xi6+XPgOjeyLyWEq+fTpmNB3Hv9
         3QQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/vKHkjuWIv5c3jceNoFr+mZdA8m9vySxz2hVgd6Vmw=;
        fh=NwfNtOtU2KQYU7fqF/FMpSt6w8Y2GP+xDflSKw3gN/E=;
        b=NbV1WLSmoKfukqLsHKEGw3X1CZULkIbBM4Awh47yc3XmHu1tAklZH8SUJ+iFM6aZp2
         0uofUba4COdMoqO1iOB30McwEcRLFgT1xWHBb5/+CQJAKtkOAh0KYDH4/DaAhJwgdB+B
         HBJM9g68i8UCXUp6lHQ5IFnJul/bdt2tCIy20BnrtvY6eDUQzB39VpBeYxOR3o5sWoYf
         t8W8rC0qMrkr4KuNKEub6zGirSRu5BubvAc+lCAEX//SyE/xZZynkB1aixVJ3Iz6wlKk
         7eUMsDn1J7bbGkzgUdgGhXv8noIlCOB+g7roO3iLUuaKEwcvAjr3Bgx09+SMkU50pse1
         uUpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772123082; x=1772727882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/vKHkjuWIv5c3jceNoFr+mZdA8m9vySxz2hVgd6Vmw=;
        b=J8kpO++iRNqm7iuGDktt28sMaNU4PvsqOScdUUHNgaHNePSXnlVVTB2lORUw0WLi/6
         FkBMj0Hff92nFBNnp1PCa9MHogtZly8U30ypfgukPvWZtlJifTn9dtvMtoKHdELI/zz1
         b5vBAx3UBXK1tkI17b9Rz4iXxQ38fVKtyCBcznFI3lBXlk8KDZI93nzvm/CLh43NEgCm
         5YnlgsCfJkLAYuo8Xf4rRupmaipTNgvSHI3YU0Sp91ShtXRmJThM6adsMW6ipX0tP+Rf
         JK7lTjwv3PZkdbWga3vbFymZOiUiZR7giWhiUSCptp86p3IXLDC9kyol+nuk8DqLiz2a
         6zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772123082; x=1772727882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/vKHkjuWIv5c3jceNoFr+mZdA8m9vySxz2hVgd6Vmw=;
        b=mrqom/d/hLyNGFTnrc5pbeLzPVzHePXPN/NjftpS/WXhfCTynjCAUhKL1w4t7oRygS
         clPf6HIqf71Zqus+QSOxfU6tcXMNRrOs3iyAJDAg0bCJww89z9XheUU26YZsGodXAkZU
         6862wCO3cfxDWCqIM4dWrupqCmq6eP3jlQ2rR8KzZQzQnsISd6HWtE8Q1GCU889YviMp
         qo2TgQS86/0MiVNiMTWoCQy9Uew2Ou9gLbSz+iVSmuPy/3k2cVBDLduKXSKDqd0V68M3
         Hvs+hBihwV0eQJxFWlvEtpxO8rswnuwvGzmWJD7LglSVvEKbsXXPqPH2O2xEFBEAmXGk
         gq8g==
X-Forwarded-Encrypted: i=1; AJvYcCUX756nBu9jDIULbi+pddchiDsEMU5amSnfmK8I2SXBqUTlCskLLY8QZ1ZuSlByFzkBFbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YweBFDtR9w7VsJugboZ+B0NQzOQ5+nOGK7TXaoCeSlcG2N7RT2E
	U30qkTq0MsRTIPjAX4WyEBu9TLAcP0YaqDEL6nzgIDCQbP+hh5MQw83OeWYnGaaTdKupTZ3/Lyz
	dIA2ORclovSy/SRAtsf8j/ztDicBAh9o=
X-Gm-Gg: ATEYQzyYpcJ5JnKy5m7eJyA3O1qlsUPwkVMZ/9sQoeQXFmiSgEEmFlyNrvBjbUrwt+b
	LUUE9BCshWB7aBP445MOfOwof1qp30Nkpnzj0suTKz5D9tyCLvBVU06DlyjQ9GrFWjiGNOWi4K/
	5EGVHIAyo6E99tOe3moMPhPxrQiwLD1hjp5LrRKPP87xfUJK7dWrRLoRdWnOeZb0DgT0xrV/AP8
	iYnqOGiHxChXNetJFoO8sTEx/EDPh0JgpdMpoPLmVNpZpHhsBGSB+INbIlJ8Dp+SLmFzXqvSznI
	jVTKA7q+7K0=
X-Received: by 2002:a05:7022:628b:b0:11b:b882:3ed5 with SMTP id
 a92af1059eb24-127869a1cdamr2388327c88.37.1772123081913; Thu, 26 Feb 2026
 08:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771258573.git.belkid98@gmail.com> <7d33f1ef0f8182893d63d49b350984025ab757d4.1771258573.git.belkid98@gmail.com>
 <CAP8UFD1c5JgpQwMuTPE-VWS=7-1Lw7mWVaGGXCPwaG5=VYhk2A@mail.gmail.com> <xmqqikbj5y0y.fsf@gitster.g>
In-Reply-To: <xmqqikbj5y0y.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 26 Feb 2026 17:24:41 +0100
X-Gm-Features: AaiRm53WCmOPeN8zMEYtVU7Vsz4GLJpKczcN1ZcI3ioycB6j5T6baiIY3G_1JRc
Message-ID: <CAD=f0L-_zq5ACD1mbfyBn3bTSu_X2emeMjv+Cfu5B5zyH8=DFw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v7 2/3] environment: stop using
 core.sparseCheckout globally
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, toon@iotcl.com, 
	phillip.wood123@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Feb 2026 at 16:23, Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Mon, Feb 16, 2026 at 5:39=E2=80=AFPM Olamide Caleb Bello <belkid98@g=
mail.com> wrote:
> >
> >> @@ -670,7 +672,8 @@ static void clear_skip_worktree_from_present_files=
_full(struct index_state *ista
> >>
> >>  void clear_skip_worktree_from_present_files(struct index_state *istat=
e)
> >>  {
> >> -       if (!core_apply_sparse_checkout ||
> >> +       struct repo_config_values *cfg =3D repo_config_values(the_repo=
sitory);
> >
> > Nit: it would be better with a blank line here.
> >
> >> +       if (!cfg->apply_sparse_checkout ||
> >>             sparse_expect_files_outside_of_patterns)
> >>                 return;
>
> OK.  Agreed and locally amended.
>
> Let's merge the topic down to 'next'.

Thank you very much for all your assistance.
