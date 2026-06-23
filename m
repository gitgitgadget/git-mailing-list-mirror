Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ABD40D595
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 02:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782181568; cv=pass; b=vGM0dQ1m7mqHnUKlAV/2DtH3H9DeMW7JbNn81sHNRsJ2o3bibPU7WvkiwbleQEbjVht8RfyC3sIvo1DVBHBT/MrtCWhZJP3HYn10zgVwpDzKt3uygE9h6p8xUR0sqgs4fK30BVMqguRBRnrc7wAu8V9lhVpGspvS4rMVmpNkaL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782181568; c=relaxed/simple;
	bh=l6FSnqe9xGsFTu5WuTnvc1XBD9by3i7grdK59924EhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kd8NnixTzHAGRLElSptoKheMrKgMh6TBw4FpsZ1mtp17L3uXZzB46A132gjd3/1iYNjuzCOV94IUg9NqZAribeytmEmqMHk1r3CNHhdm+t9+4HJJckcTAeD96soPRILQXf3l9RynRqDXgSQHIWDSAt71m/LrU5DrbG7K8bjJ4g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgDmzlFT; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgDmzlFT"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a1009f6adeso1252498eaf.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 19:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782181566; cv=none;
        d=google.com; s=arc-20240605;
        b=fflHjDbkVz6NDg3uF7HIqODwPBmlpnyyu8zLrp49wyooVt4EwD1kIKgUu3M5PN4fTG
         514av+WeMAHRf9GNe6KIh0e27rFq9PoP9Dz3ariHsBoB6oXqika7NQVqXaYOHEFNFfoY
         TsFaBArKdG5PZM8/eoFEdUFauB+xnfQ5BBHi0T+t2uxv52zb7fsBOG2IU/XniZ5nqebi
         kYI6MuY2falD0/v+9Axc2ymqDyMlnT5DERIZU7uEgVdKkDZXxLgFPs71yz/tvs2Z7hkL
         gXTBVMlnq/XsgoBiZ5dazb94LGk8LXhhgm2wAIG4RHFUOFy9I1KEh6GhwLLFD+CBvmXG
         6QeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oYWxJt60tSCJPMIEcz3XuMzKAKFM5n7ohSuyCvKj3IU=;
        fh=LFPEfDoM+biK/1GzaNPnAAjcxueHjbHSowKsUYdn/w0=;
        b=K2bdYQmemMKY3Iuog/1CBJcm+EoonuEGjlwB2sYihc3V9tIyoiplNtNqSYXF5yxeFG
         jEc46Kmfk5qMn5Yl6d+oZVD1BLnwJ42TeE3fcUjHLbVNotEPqQa+FQhd0MB0tREZR/n6
         wJ/5d7NKdhC5BZ5KE6D0U5v2HeK7iMDBNOp8p3AXoL9ET8BA0RvmOxT2RdEBouotHB7Q
         D9LZYLNiS5C1F8djJefjYcm+x3VoErNzcV48h2bec4xlSVVG+d/9mrJG8fqazlEYzvfE
         YTluh8HyLhaCVNVc/48wg/EFRy+1CC4Ca+NRJq/oXARRfvp6gxSHA1JNn5XfCXocv1L6
         RX4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782181566; x=1782786366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYWxJt60tSCJPMIEcz3XuMzKAKFM5n7ohSuyCvKj3IU=;
        b=NgDmzlFTtqJ9nPPxduImCveyo/1e4sZmTtveskE0qjkv42HUNINVaVnE93sHIl5fY9
         SxDG88JgMg3ejEW+cE0Ses2qUG5fwKnaMDxvuWUx0eDtOHNHoePmOXFv/HZibWEySEo/
         sHSnjJC4bBarXuxRyxg3dW91JflyDGSpFoSXpT1kIJ1lglo5eTmNrlpgUSgms4/bBWFy
         2Ctg/0Lck9gXDyQX7cf4ic1yUhyeu5wdMUeX5EwPf38OFX4Izxx4nLQZNF9S2QSMvTPs
         t6wOQYwiu9XjjLTqy1Pe+iblGWnG4DsKqcpiQKiivcYC62x9dh3ywCkRnGmMfr/S9EQC
         RMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782181566; x=1782786366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYWxJt60tSCJPMIEcz3XuMzKAKFM5n7ohSuyCvKj3IU=;
        b=dw6ZGAIvLlGUnHGSCLzTtc0qt/CZCDMDfPzQ1XOAA++giqmOogy6V88u+iMrzjez/j
         9bhhMzErtdnG5wMa6BS0JcPbj+2R8ejB91sQWMOHFU4+6SJ7CpCobM6XfVLhIOHasSoT
         rxoibS6N/uOCiepQv8y7R0ae2RJj3ehGSR/whMuLRkgqVoX8CBi9PpSUnrCyX1LapDEP
         vIk1DGgk37SdSkYGxLlbFr02ZUnB45qsPlOidOzbJ13lo/lGeq2qV3/kSiynZeVfky/a
         Tz/a1U6PHdm9lCcHjrfRUy9s+MlaJxCs/HKDxrt60rgB66V5uvWrAsf61KAuMKjIN+hi
         j0cA==
X-Forwarded-Encrypted: i=1; AFNElJ954inKUUymp0qnb0K+/x5yQvpz0O+ny0/ULChey+OwTaaBZZSu/ECO3jz5i+BNk38uxnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSedxk4FjyLD2n9BqXj6OwgH2iyyz+Qxw20I3n7IY/Ha2C09eC
	Dnp04qLMxHGjapZbM8bZ+yAO+73J1x/iD27vU5e46cIKEHgNMLNxR2JV+VVB5yjFN9nmYVnhJMx
	pu/9O1lkcsE4RNKp9rWspujpwCXU9NDA=
X-Gm-Gg: AfdE7cnEfs9pGh0662QMhXNtZmV++wpxah8ecNhiiSopGwZ9s1xTjNKLDY1htQK+oUD
	OV6NEGIsp1/NdbtZ8OTn9OPl3XxmgAm6Mj20bDyut8df3yXfW5+Krro9df86ZNqA2L7dcHYWkh8
	uCjs6uv9/pUktXTA4Vunzv791QysGX1XPJmKGpXeSmvMSqOtHXubF4v1wwSlLk3CZi2s2hrFu7X
	xo/GQP0XMIjwUuTGbPH9q+1vXifgMtO6NnarAePfuaCg5ExFNzFCOOdwYyS58VRIMxMWpgGnkZ8
	rC3K52bSdYhdILCXp2gBoxJiLdxoefOtOxuYRlL9WIVPlWojo46wdQxA08IOZSYlg5q9Kvj5uug
	rSLg1Nd7jwLWRCYQ=
X-Received: by 2002:a05:6820:88f:b0:696:17a6:c06f with SMTP id
 006d021491bc7-6a0d8d94badmr13539481eaf.12.1782181565941; Mon, 22 Jun 2026
 19:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
 <a70d861d27a13459bab34f6681b3ccfe2f20d0d8.1781806593.git.gitgitgadget@gmail.com>
 <xmqq8q8bpl03.fsf@gitster.g>
In-Reply-To: <xmqq8q8bpl03.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Mon, 22 Jun 2026 19:25:54 -0700
X-Gm-Features: AVVi8CdGWllVMSdjspLvndyx-S37alKlw4NMsn1U3KXFoNLB83-jyUsS8OC_IBk
Message-ID: <CAC2QwmKEHb+LL4ZkQwq+Rw8eyDXzdBp_nxa_d+Ecx0K1icNqQA@mail.gmail.com>
Subject: Re: [PATCH 5/7] line-log: support diff stat formats with -L
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 3:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> If "range-scoped" is a widely known term (as opposed to a new word
> invented only during the introduction of this topic), the above
> reads well with a nice rhythm, but otherwise it may be easier to
> read, i.e., something like
>
>         The stat formats counts only lines within the tracked range.
>
> without having readers learn yet another new term that is only used
> here.
>

It was something I invented for the topic, but I agree it is better to
avoid coining a new term, especially since it ends up being spelled
out anyway in the blurb that follows. Will replace the term.

> > diff --git a/diff.c b/diff.c
> > index 6233a96bf0..026fafeb90 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -4289,7 +4289,18 @@ static void builtin_diffstat(const char *name_a,=
 const char *name_b,
> >               xecfg.ctxlen =3D o->context;
> >               xecfg.interhunkctxlen =3D o->interhunkcontext;
> >               xecfg.flags =3D XDL_EMIT_NO_HUNK_HDR;
> > -             if (xdi_diff_outf(&mf1, &mf2, NULL,
> > +
> > +             if (p->line_ranges) {
> > +                     struct line_range_filter lr_filter;
> > +
> > +                     line_range_filter_init(&lr_filter, p->line_ranges=
,
> > +                                            diffstat_consume, diffstat=
);
> > +
> > +                     if (line_range_filter_diff(&lr_filter, &mf1, &mf2=
,
> > +                                                &xpp, &xecfg))
> > +                             die("unable to generate diffstat for %s",
> > +                                 one->path);
> > +             } else if (xdi_diff_outf(&mf1, &mf2, NULL,
> >                                 diffstat_consume, diffstat, &xpp, &xecf=
g))
> >                       die("unable to generate diffstat for %s", one->pa=
th);
>
> It is pleasing to see that this can be done with such a surprisingly
> small change.
>

Agreed! I didn't initially plan it out that way during the first series,
but things fell into place nicely by the end.
