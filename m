Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CE433B3
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581406; cv=none; b=RHHdL+Ip0SjgZiWK3Xy9ArmTPFpbUXaOWj88greZnRbCQmqTNonMQVoRct1r79fwTGCk3OfkQ2UUHaUNHNksHkiOvtYS0hEj9w9U2dBEijk6ckFLbQhmkaWt9okVyXiZRngnYY5uwZYK+GSwbkbxdW8mtJiNOA+MGxaYM6vrbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581406; c=relaxed/simple;
	bh=bmYru1L1UKv+iy6iwuRbPJXWPWACYnNyEnbtr9btYkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rk7Rj7Z2R2heESMjuiDjP1KZ5COyFXKwN77v0omJy/aV5Ydwh4c281uIFRMfG7XyQsV4AQ/Mv6BPUmBqxEyBdKJM7/WJgiHTVaIKAp+yr+RirE4xPoGyzkT4imGNSVf87pdp3cNgdh99lAvrNgonTYkZuPXOu2TGqr9arhOJfpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e8935059cdso3023821cf.2
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 09:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581404; x=1762186204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7p0o8HWqCGiugvomLfWTBDcTW8sX3N+jUccCzImuAm0=;
        b=nuuTxfwqlXva8WcnVpQscpP5shzs4MhJRC8/UcWx4pRPDPoBovVBoZOIk9dZMLh/q5
         LCRFfRT0wsv1UC2yXbPPhPG0DlvIdmud6atPT8x8uJPMoeyGewUCsHWzZove/WC5yya7
         FGn2vCDDkPQQaKtjBdzahiWv2Zlb28kbj+e8ccoe9gfoCMaFzpI3vEpvmrTNznmDMiQN
         XNzfXYkkNWJ8gIwNgcmeDRCGUCkCwQ/bUr560ha5VIzCrhd90yBCeUPPA/AAvfk9Utjn
         kuXWtzWnYwa1B3LyN77bedy/lbzs6zkQsDoqJiPN89tv5SCgCpMURwj9CWYBjPKqcTAo
         Tw3w==
X-Forwarded-Encrypted: i=1; AJvYcCVYCTmVgBpAxobOHODdh69VqxXowUluH5tKun27sYmu19T7QtDu+Z0vN17c93xQDM60c5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+sNDJk3aK35Jt+5C3eVqMIFLDgrkH2TYWcWezhr+OIeeJ4uW
	ILWst4KqpzNpMoZf8f+zoxA3FVEZnxszuD+cbgR3hvU7hzOLcAz9vm9UNv6O34XGnSgCsvV6kae
	5ueuL83RsjX6OXF+gBIw3La8iSm236Qc=
X-Gm-Gg: ASbGncufadzxQUQoMXLUAYJbUJQqT+Uth+sPX/0JH7/eBB2jYVrqQK0semXK5PYOKTs
	v9jgR+Vjr8Byu8u39z5qHFerGbcS+hHPN03HorNP+smR2J284LECUJ1QmjIdhZTyLwZxk0CjhhJ
	vtEQIDdGaqMYVjJiq48jA5U3wr0g5RV2PglZ5RJoBT4zItfCgKgSwqBRMT/gUI8/8DCHuimBJPE
	RbK+nsBhIwuOccBCy/t5ZAAMNRkgbEVghF1xxXdEC5ryDssdS6YzxWLtd0PKONAr+wQDn1IgNPf
	bsGgrD3+TWn7ogPXuT6PkL0Imfx4
X-Google-Smtp-Source: AGHT+IFuC27izRqpAM4n14gRZoke0kFt9enFrXzA7yA35aDTA5gDDcG1Pz7mB5M0McrliyUF/EPbK5vasn9wER49On4=
X-Received: by 2002:a05:6214:2602:b0:87c:2360:d41f with SMTP id
 6a1803df08f44-87ffb0bf00emr1262706d6.3.1761581403457; Mon, 27 Oct 2025
 09:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251026225409.46647-1-lucasseikioshiro@gmail.com> <20251026225409.46647-2-lucasseikioshiro@gmail.com>
 <CAPig+cQO4_T8K-8wFBDQN-n+rasBF7LR+vJ6ez8swfmDz1ossg@mail.gmail.com>
 <CAPig+cRHKySZ+JPs3G0HowdCEJmE9fP=tCFB=DV-KMPknKTZkQ@mail.gmail.com> <xmqqwm4gl7fg.fsf@gitster.g>
In-Reply-To: <xmqqwm4gl7fg.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 27 Oct 2025 12:09:50 -0400
X-Gm-Features: AWmQ_bnW5N3kv-WmrGnZqQU4OPL5gi9RO29rD0tUxgIbIynr1UWMADGU0t4Xutc
Message-ID: <CAPig+cThZd3urbiPJ6WiToLcdmaj6AqRpj-edEjiD54Lt_r-1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] repo: factor out field printing to dedicated function
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:56=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Or, even better, scope the strbuf just to the `case` branch which needs=
 it:
> >
> >     case FORMAT_KEYVALUE: {
> >         struct strbuf buf =3D STRBUF_INIT;
> >         quote_c_style(value, buf, NULL, 0);
> >         printf("%s=3D%s\n", key, buf->buf);
> >         strbuf_release(&buf);
> >         break;
> >      }
>
> For something simple like this, quote_c_style() can take "FILE *"
> instead of struct "strbuf *" so that you do not have to allocate;
> especially without any need for i18n, perhaps
>
>     printf("%s=3D", key);
>     quote_c_style(value, NULL, stdout, 0);

Thanks, that's even better. Nice and clean and easy to read.

(I didn't have the Git source code at hand, so didn't know that
`quote_c_style` could take `FILE *`.)
