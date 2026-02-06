Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03972D5923
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770409359; cv=pass; b=tM7uBekpPUz536MuWQ8A16gIohswtX1hiA2AcPzzx3jXGmCtwURLyvDq/8l1Wifc9PDnz3R7M7Zk0JVCRvT7HwpbOciJ++zKZWhqQF4aIEPxmpSMNr3tYLxZ2fXx7UdfsdJcwCWpMWCDfrQXVzqsGNKWpkL+5xKIib/M59EX9qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770409359; c=relaxed/simple;
	bh=KYhDeHJBnmBsFX1e+j8p6uIgswCnPbDsdcZjVvuvU7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5HCNK/Gryv/HIsChwIhMiASNEPbf2IUIK2TEWp3ESc6fuajEgfBaKwA+nCSHeelL/ooxFDTYz8vlp6sLggkAu9E3KF8eiMe+f8Br4lOLL78m4WrUGWj5NnGO9TogG85VLLM+g7v1Qjajv5fWSc8eWbBNeYoJHR9T84dHMCctlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSXmy+7H; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSXmy+7H"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-563497c549cso1493308e0c.3
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 12:22:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770409358; cv=none;
        d=google.com; s=arc-20240605;
        b=kUkSuf9gDDCq1biHGybzaWa6i4wLKTnET/ftreAaaq93ybhYcVWWL84RmTUWrZCZaw
         lSnnBVOmiMb614FKl5cgqs/bYuz3aeg1AlecPsyC8vTwc8AZkOb7YQQlnvyrGd9ts1IH
         OCFyf//Rm/jlAdvDAyd1SpdiPBzmQ+3MaWMNRdeVqHNH8gkTF0ZDofuoKkVmJUbivHK+
         Fn35yMyoGTo4DweyqDzPaF/ofK5kadEiSBXN85cXB+u5tI7mAasTfRlCOH/Voc9dmIYR
         Y52F6eFNu/qsHFsPubGcmTbK7LxA0kdva6wtrwQ3WxturD8IKrzIA9llSA7C+cu9ltvC
         wmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o1Csg7kioB4/pXm9dMJOMV2X2uSouc1zxcqIt5SlcF0=;
        fh=392ryK1TiLXjQymH8YuTlaSLgmX4+VbMxfQfkGuHyGc=;
        b=fNJ4Z5pdNNigcrfajX6dW83b8g08iw3nbCJm2p2pqkmRwmaH9HS9qDaMwH+EZ8md23
         VPYPcDppl7hlQNxatAbo/nfkBzKFbouaskTUqZUZVtgeiUgXKp7laPwUkJqy5445nad6
         MRh3+BkNfc4fFd8wqlEWj7RQkMbb91TRarlc3lR8ywdC2FBKISZsONXS6KIK+h5FE2oy
         Amfj57+wW78pWB63ejQB+awR3yKnMsPI9aGgezl5AwS3229l5CuuhGwKG1jvOwXxRbna
         cwyp31uf15A5+YJ5a0lVxxCqWFdPTvwxj+QrN0ys7DaemXkS82jLLneGAa1IwSY/nioO
         D43w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770409358; x=1771014158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1Csg7kioB4/pXm9dMJOMV2X2uSouc1zxcqIt5SlcF0=;
        b=kSXmy+7HlmnlCzws5HTx4+2IJPDm71kombO1CToN2G7ijT+wGQUB8zKLk9D1ETpo7T
         Hz7cWC97K/hUEYNhk8BTHnCGwj7RVwyT8LeR4oyj5fmvxZ4LOVCLImG3EKvbQc3jIC3W
         h1wwWV+oVPB0vg/PmGsiD/6BKE6PpJLWWm0UrO/DjkIMClgHnfTri3TUz+ecG2ehS8rv
         TBn7n5qPvn4gfctO7Dui8Z1El70t7mxLC/IuffjVsz2uJOjBZQ8l+QmCvT19RkLFIUxY
         iBLvwMT0O666UL1ekPnGoYelbNnNC08n/7ew6QMov15p0F/efjEjHEZj9FQJnv/CTOnt
         zvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770409358; x=1771014158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o1Csg7kioB4/pXm9dMJOMV2X2uSouc1zxcqIt5SlcF0=;
        b=Qd2BceEeRF5yuERhWf+igTHoJQE4pYwidY0Yglk/gtw8Jgc/nADBqXY8CiNhU4OB0x
         ajgZmNeP7Q+nKnUJUBL7J7rHQsE0x5cyvTfpFr2r6cgc/Ku7gnFyXALiy2yICLzKTFT6
         c9IquoXzvGO7yAxpoX4aKyA7LaUUdMQBsFeiqsZ973gyH0ZXzSZ836YiDGeJTCx8zjx+
         YOtQhOSZxgoXvZZRxa/l4836nelSE0LsnsqlPb1HNii3BUWlQkAlyCiesD3P55G0JNq/
         hfRa8PQQHUizvcQ5pfyIoKD1PimiyA9/obupLRjTC/pVLmksx4yBXHEQ0sbLv4wWMs/4
         wR6g==
X-Gm-Message-State: AOJu0YwD0stcKPpOcMHttJx1dPxJrYzjtLfROpFLO5ZVPMamtRVOc8ZS
	vjd6p9hIQcMjrfA8MnrJgslqOpZlafcevFsuJsllItiR7/8Nxa3Xf0LrM+7lZjNVS8W8HOmZhEB
	8ZObm/cwfqi5u7itaZmwa6nsOoFVkYGw=
X-Gm-Gg: AZuq6aJSnH1dwz0D7WzMWY5P7FRxvc9mVlvUqVxgxrC0nDTQDbhIsVLk8+4p0ZgLkAb
	FSqU03J7LOpWps5CKEkJlEfOeqKmivDiXI9Lo7rjqGNLgLB42XkAy8TMpdYDn+fsLiPACeYq3+w
	AKsAUERoyFSUctg1Suddm0s063/heKT3a9ze9mC0Tf+ZPoRZQClUQvdH5ydEVqyoRAWvlWAEwpA
	Sxu9QvdTo17w0oKWFOvO15cFlUhlvCkdL9IPqMLoUZR/qg0nXLvdgkS2aIKj24nVD79SP1+mBE=
X-Received: by 2002:a05:6122:3c54:b0:566:3d03:8e1d with SMTP id
 71dfb90a1353d-56705febb0fmr1283774e0c.17.1770409357800; Fri, 06 Feb 2026
 12:22:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
 <24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
 <xmqq4intg1o7.fsf@gitster.g>
In-Reply-To: <xmqq4intg1o7.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Fri, 6 Feb 2026 21:22:35 +0100
X-Gm-Features: AZwV_Qj-7MkWLMY9FxMqY3YI-8EpkesZnLGBMlAZTrW22aetxto8ZUUaf0xl3bo
Message-ID: <CADYq+fazKnt5KGZdHo+FJODRE2mfXsa1_R13w-zMgcW7Dpi8Gg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] add-patch: Allow interfile navigation when
 selecting hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 7:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > -             } else if (s->answer.buf[0] =3D=3D 'K') {
> > +             } else if (s->s.no_auto_advance && s->answer.buf[0] =3D=
=3D '>') {
> > +                     if (permitted & ALLOW_GOTO_NEXT_FILE) {
> > +                             ret =3D NEXT_FILE;
> > +...
> > +                             continue;
> > +                     }
> > +             }
> > +             else if (s->answer.buf[0] =3D=3D 'K') {
>
> This funny-looking diff is a sign that the coding guideline was
> followed in the preimage but not in the postimage, by splitting
> the "} else if (condition) {" into two lines for 'K'.

Sorry, I will fix it
