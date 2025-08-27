Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB711DA21
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756328562; cv=none; b=GMQyjPkTOWagNYFofa+n93ius5LNy7niCMMMUsBn8qcoflEV+UPRcQ25nyqbTdCoI75cFOZqEXb3IldsrDptKWb6Gn3084gaYTgDkuBxN/HuNBpANzIAu9Q6MVjXUKStDZZfEecnk53ERS5HLTPtf78Z9L7ddlGsTg4pkdYYjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756328562; c=relaxed/simple;
	bh=rdgJj5jPLzPMdVLfJat7vs0h2T0Kc4p3FYN2vVjfDtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7nWRyB83M9FGLj+uLwc+kfM2a8Tb9GXeoiLttC9RruvOoQNbY1s3dnQUyPdmyUqYE5gWHFk+lqt1vK7ppF5Oqpi4eNmtQP4+ko4XbCA6V9ShaahquEt5aeEmTx9bDfyvPtHwLUI3ser3bIKUG8nUWDuz69Nf5sSxAXcsxW+bqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70a88db2cefso243546d6.0
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 14:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756328559; x=1756933359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r43GCxADzCyNX+VvU6VXFJ5iGLEw1mS03Xq6a1mcZl0=;
        b=O0qyzPbcE2AZihfEn3Q4/c2L1/Jrdkl54YdO9afVDA0b4czhfO9310Z6hM57ffA7wX
         VYdqF4DprFafgEK7GMuDUaFZMmgOKQEQDffqr5D0wvUH6bH6Qq/tcH8VIV1CzTYjoSlz
         YdqqjaoPilj2TIouB6yO6AWJna8uJRqfi6leWKG1u0uXwF1fj+FADY1HXqEFhv3EVPwn
         ImS2ZTjjWhCwNsqnrT+8B0ilnKaOu9V8OCww0agdF8GDU64eWv5bpV1x5V04imuqBsI2
         cCHeZrntEXY058JatiFZCoaQdCHETzLhkEgvl7TkXM/1PMd4Md5sT3/BBqVfGkUR66he
         GFxA==
X-Forwarded-Encrypted: i=1; AJvYcCV21bBb1fiWbGA7Bqe+ujnnM8+4xGL+Yp3orxV7in178sVnXmAGdZ7Ltj1WdjCVYYePJZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4QxhnoX/4doSvRhPbXlVuBT/kuRu8/2+bMycUcXCG4W9t5O9
	qCm9Z+rjlEgjQo312fgOJxbH0+mZTs+PejZ3RHWwe0CGUz8JKSzfwoBcQNyxormn9/5RbmJUaIP
	S8EOgi/tXBILOS/lUtExt7eoGzxzbVTUIDA==
X-Gm-Gg: ASbGncvumWOjzBacPl7yYIeaiSAlkQh/8QJ5tPs5ZaCg49R/zyo7pbCufJvkmQ5pHOr
	1keJ9OKNbvPy+67xUkCbFMOuhrMCZrbZ/5Lf7B92T5QBll4Vc4jsyvrg/dpk/x2eVxNYRjdEIig
	ru4Y/4CLbSMjXeZRMREr9wMh8gi3cKAaSd7FcFl1wE2B+WFDu0wvHhKrur/t5Q2Yf/NaunT18/n
	6xS4U225xqYILFEcxrnBUshiBXZ7CYP+0WMHrKjyJIzwar5Km9J2Kofy/O75g==
X-Google-Smtp-Source: AGHT+IGTdQdj3Gj6ZdV4ci81cmdys2KTxXT5TNds8ZZSnNDWXvdg9AaBUi5G6AJv2KqgL2zDT5i0b7z2ioXfABAfyjU=
X-Received: by 2002:a05:6214:1c0a:b0:709:5007:9f80 with SMTP id
 6a1803df08f44-70d96d1c20bmr157224686d6.0.1756328559067; Wed, 27 Aug 2025
 14:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756311355.git.code@khaugsbakk.name> <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
 <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
In-Reply-To: <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 27 Aug 2025 17:02:28 -0400
X-Gm-Features: Ac12FXwmjGdSQXiEk2cVDYkvjrY2DJFSY14bO_-Bs656OIX4UG_rCdp5ATPzhbY
Message-ID: <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
Subject: Re: [PATCH 1/4] usage: help the user help themselves
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 4:36=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
> On Wed, Aug 27, 2025, at 18:29, kristofferhaugsbakk@fastmail.com wrote:
> >       fprintf(stderr,
> >               _("'%s' is nominated for removal.\n"
> > +               "If you still use this command, here's what you can do:=
\n"
> > +               "\n"
> > +               "- read https://git-scm.com/docs/BreakingChanges.html\n=
"
> > +               "- check if anyone has discussed this on the mailing\n"
> > +               "  list and if they came up with something that can\n"
> > +               "  help you: https://lore.kernel.org/git/?q=3D%s\n"
> > +               "- send an email to <git@vger.kernel.org>\n"
>
> Maybe (thinking out loud) this should retain some part of the =E2=80=9Cle=
t us
> know you still use this=E2=80=9D spirit:
>
>     - send an email to <git@vger.kernel.org> and let us know
>       that you still use this command

That's still inviting unnecessary emails, isn't it? It would probably
be better add the qualification that people should send the email only
if they were unable to find any workable replacement. Perhaps:

    - send an email to <git@...> to let us know
      that you still use this command and were unable
      to determine a suitable replacement
