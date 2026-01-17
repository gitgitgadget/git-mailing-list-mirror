Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5921198E91
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768665508; cv=none; b=MHbHz8mvpE/eVx48p6bmwH7Ui6yhs4UacBSQfuVLtXTKTzCa1C9mSmh8QZAr+1CzrC6v06Be/RU1lVrtDrOj3ujCbm+xUg/8B6TWBMk4A7r3Pl1ZdkmQogsDaWQwAkU3CJ3C3O4OckOgbTGVZ+n2auWkC4gjrjVua07jcF24b8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768665508; c=relaxed/simple;
	bh=88t96p/wUpw2vncbmMuIciBKv+yK6DXMGamWlylEq7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHOmKEjM8mxnTybivaq7ze8iZptA3qZzXE5TzkMqTpMzW/xKZ0DqjjsKFC8SU+OE5osWDcWJ413GQCHGTy300AuSySxVRqYAToKkmP5atRA1PVf6yNBKF/qGl2E5ExLTV7UduyKCNXTkaOnS9oe2u0x0S7p3MLpAk54wqY/FaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J51aYgnn; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J51aYgnn"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso4978143e87.1
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 07:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768665505; x=1769270305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SqVGgXrH/a0JbNcQg7gIjJi1e3wf2ooxWfukQvqGVc=;
        b=J51aYgnntThQ93krXm2MuHbwxDiA4gwZMOIM6OIasQisG1nemfE+EMnU5vXcNHdBCO
         ZwoetuUQ3CoUZacNosYjJBMaszuIxqAd65LdFQfE+eXGYJK+oE9+lkHuh2gUd/BLgzE7
         Tk0rOzh0pIqDT6uXZHHkuTriytfAj+ski9dDgtIrkgmW477NWfpwmbYdb5VIC4ukRSLs
         Hhj7kILf+N2gYUELpEVWSihgvDC3vCMTtMfTNm1H6/wmG7FJDWZ5bEpKzqwLmnX9DtHk
         tyaz9BMOvncEXitmUPDE3BrNwL0w/A8yI3/OY648oY0FFBBgOLgjw80cbn+50RGKNblX
         SLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768665505; x=1769270305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6SqVGgXrH/a0JbNcQg7gIjJi1e3wf2ooxWfukQvqGVc=;
        b=Nfz5MNkRhXvBYmpj0r7ZPPNu+ngWk8ofOKHuCPpDtIuy/KuavxySzTci849bYoMb5q
         BWdPRqzPjI4xfifGaYAwPPEvxoTuVLrWVTeuWiaPRYUMd3/QcrRBHzSTCvY+KPFShidz
         xG3uopwKZE0edBeSXTLHIpPP+NXOxXONSEGnBECKXTNcUeIRoTDtPje0jainGmNz83f5
         M8TFJva5LX+50FgD6pNnKzuAuAHLw2YnenzzpgIKxoFrQkatsTsZnHxEOKuUS1vrySf+
         xjSITNncK6a5xh6/4U6ezGPZrHBf5jGUSDfWpksxWkTqaVUhGphCdZYaGD+B4CBR8fbv
         x2DA==
X-Forwarded-Encrypted: i=1; AJvYcCU0z/7VqEyB0n2sSzebswdyBLbhXQIsccugUAh4sho1R2kzaLaiEGsJ+UrfWLaF49yZtz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzWyWh9QlWTQqzpmz/JDWe03qaaPhiULiEFA9uln9A48OUaFX
	inbTo7Bvb5fPdChI3RtKSmQ+41kkMM7hESLub3MmrvQptdfIqWUKcnUMJ4En2k4cRxm2ttGruaz
	F6RX+lc8UzhJSzwuxe/BKSc6K5bNalwlljUA/
X-Gm-Gg: AY/fxX4bc34K//AX01fV/bdJW9JjJ55/nWrcQsSqSIHTc7y+lEwnVZgF+uYTMUCTM8I
	KGODWUlJwZzVMssSaWZmYCXjZD2FW1lqV4iuTXwTu8PDx7WhW7s0ZUkXGwmOBBhunXAeXVwC+Y3
	ow4x9Ql2/Xw9iSeJf861cVlhtHpMnCiEwcfbHV7rWIgHJsNgRjvvmLZ6NHWZd37HYeBeMMA4V22
	PvaFny/LtN/BHKHyhws2KaKwoJ80KkosWTo+ytwGtn6MkzMCCVq3nsCjdK4p7x9hMJ+6e4=
X-Received: by 2002:ac2:4983:0:b0:59b:7292:cbc5 with SMTP id
 2adb3069b0e04-59ba719c72amr2719883e87.21.1768665504554; Sat, 17 Jan 2026
 07:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0a306227-5db8-4d12-865c-fa0efe5c6beb@web.de>
In-Reply-To: <0a306227-5db8-4d12-865c-fa0efe5c6beb@web.de>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 17 Jan 2026 08:58:13 -0700
X-Gm-Features: AZwV_QjIBL0K_1eQFl2wt8WVqyxf5idXMvdlL5uD3d5NdlKok1fjVSI9_JqIlYc
Message-ID: <CAH=ZcbB=Yf=wn2O273adrvpUpE0bJGKwrAjOAjmB8AgJrjz5Bg@mail.gmail.com>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 1:19=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> On 1/2/26 7:52 PM, Ezekiel Newren via GitGitGadget wrote:
> > diff --git a/compat/ivec.c b/compat/ivec.c
> > new file mode 100644
> > index 0000000000..0a777e78dc
> > --- /dev/null
> > +++ b/compat/ivec.c
> > @@ -0,0 +1,113 @@
> > +#include "ivec.h"
> > +
> > +struct IVec_c_void {
> > +     void *ptr;
> > +     size_t length;
> > +     size_t capacity;
> > +     size_t element_size;
> > +};
> > +
> > +static void _set_capacity(void *self_, size_t new_capacity)
> > +{
> > +     struct IVec_c_void *self =3D self_;
> > +
> > +     if (new_capacity =3D=3D self->capacity) {
> > +             return;
> > +     }
> > +     if (new_capacity =3D=3D 0) {
> > +             free(self->ptr);
> > +             self->ptr =3D NULL;
> > +     } else {
> > +             self->ptr =3D realloc(self->ptr, new_capacity * self->ele=
ment_size);
> > +     }
> > +     self->capacity =3D new_capacity;
> > +}
> > +
> > +
> > +void ivec_init(void *self_, size_t element_size)
> > +{
> > +     struct IVec_c_void *self =3D self_;
> > +
> > +     self->ptr =3D NULL;
> > +     self->length =3D 0;
> > +     self->capacity =3D 0;
> > +     self->element_size =3D element_size;
> > +}
> > +
> > +void ivec_zero(void *self_, size_t capacity)
> > +{
> > +     struct IVec_c_void *self =3D self_;
> > +
> > +     self->ptr =3D calloc(capacity, self->element_size);
> > +     self->length =3D capacity;
> > +     self->capacity =3D capacity;
> > +     // DO NOT MODIFY element_size!!!
> > +}
> > +
> > +void ivec_reserve_exact(void *self_, size_t additional)
> > +{
> > +     struct IVec_c_void *self =3D self_;
> > +
> > +     _set_capacity(self, self->capacity + additional);
> > +}
> > +
> > +void ivec_reserve(void *self_, size_t additional)
> > +{
> > +     struct IVec_c_void *self =3D self_;
> > +
> > +     size_t growby =3D 128;
> > +     if (self->capacity > growby)
> > +             growby =3D self->capacity;
> > +     if (additional > growby)
> > +             growby =3D additional;
> > +
> > +     _set_capacity(self, self->capacity + growby);
> > +}
>
> Constant growth steps like these cause linear growth and quadratic
> complexity.  ALLOC_GROW does exponential growth with factor 1.5 to
> get linear complexity.  Here's an old plea to do the same:
> https://blog.mozilla.org/nnethercote/2014/11/04/please-grow-your-buffers-=
exponentially/
>
> Ren=C3=A9

It _is_ exponential. ivec_reserve(&vec, 1) means grow by _at least_ 1.
I'm not using typical memory management as defined in
git-compat-util.h because I'm trying to get ivec to behave very
similarly to Rust's Vec so that when Rust is introduced into the code,
C programmers will already be familiar with how Vec operates _and_ so
that converting from IVec to Vec is as simple as refactoring IVec
declarations to Vec.

Since C does not support generics there is no _proper_ solution. What
I have come up with on the C side for ivec is my best effort
compromise.
