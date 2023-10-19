Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000A2FE0F
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNEmZmTv"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FC812A
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:26:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b10c488cso127871267b3.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697743580; x=1698348380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ON/8n7cVv0+npYHJrKPy5udOpeo1VSKQo+RLUfJtNl8=;
        b=uNEmZmTvFTyU6jraBW1++ehITZlmvcoxZqlYCnJ8EG3M4bqq8RcS9fxIzBwRG3W0DD
         ND7VHbcFIynN1FgO8Amx/wANzmh1PTX6/0cy57GicLbCIkmok+0nY7Yz0l1bCPQyxhhg
         B4QNgiSuimSIINo+9EHcGBuWhB6RIlIBrNPeIqbTNYF1fLHOdtXixDMMOmscF20hu2kC
         1jDFBl5L2aoThVkcPcY993aS564f0rvinu81aVXjTEJyPnd3htYWXeSM+QHJ4a+V1xd0
         SkozgZF7YNEgU3ddvTJewIRaMLzjRtD8/8rV4JQ/utHKAXwj8FSh6N2YqO9/pOr0NlJV
         9Qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697743580; x=1698348380;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ON/8n7cVv0+npYHJrKPy5udOpeo1VSKQo+RLUfJtNl8=;
        b=iBxUi4Gd1kR/L9ByWjJAhTKyJ4fOgYvcdjAvf0pH/PaJKN22S87D4PK2kTyWwlL8HQ
         MXhhV4YSC06b17t5NlCvZFoDAyHesxPS0aGJCS5TNFWmfAqXmFYF9oPArvKSiPP4T5zb
         FYOGGs/WPBaepveDSzAsczWcAV/stVpyhisxIOq4KLfrFNG/7Hm58GUAwosnyGN21CDY
         Hzv0DQwjiffEFusR82kyh5PCYU30g8GX73EOI+UJljgKy4tDCo+2OTelC4/5+LTOYSQ1
         ppYO30Telzu3lCa9j3UTOqLnswa9LZVpEu/ScypQtfND5ItKrE4UJzHNMtyn5ZqGH/Mg
         y9Fg==
X-Gm-Message-State: AOJu0YzfGmyreJ52QOrNTHAvpFXshCpDMVZuUmS44/TxGW0mqDKWQacB
	/HVNmKvsFG3eOmVlUZx2Yyih6m7CeMM=
X-Google-Smtp-Source: AGHT+IFoOvkzFikHBlTFxQdmuzn3eNOyM6i/Fs820VjMPakdhuNji0qh61HVVtXo7szmp5+zfm6yVpVZ9/o=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:e245:0:b0:5a7:db29:40e3 with SMTP id
 l66-20020a0de245000000b005a7db2940e3mr69855ywe.7.1697743580088; Thu, 19 Oct
 2023 12:26:20 -0700 (PDT)
Date: Thu, 19 Oct 2023 12:26:17 -0700
In-Reply-To: <CAP8UFD3f94NnBgkzkezcALJxamsz+-oPfqKe8XGNMuJ+g--z6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-12-christian.couder@gmail.com>
 <owlyo7icl1g3.fsf@fine.c.googlers.com> <CAP8UFD3f94NnBgkzkezcALJxamsz+-oPfqKe8XGNMuJ+g--z6g@mail.gmail.com>
Message-ID: <owlysf66ququ.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 11/15] replay: use standard revision ranges
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Elijah Newren <newren@gmail.com>, 
	John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Calvin Wan <calvinwan@google.com>, 
	Toon Claes <toon@iotcl.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Sep 9, 2023 at 12:55=E2=80=AFAM Linus Arver <linusa@google.com> w=
rote:
>>
>> Hi Christian,
>>
>> I am only reviewing the docs. To assume the mindset of a Git user
>> unfamiliar with this command, I purposely did not read the cover letter
>> until after this review was done.
>
> Ok, thanks!
>
> [...]
>> > +     Starting point at which to create the new commits.  May be any
>> > +     valid commit, and not just an existing branch name.
>>
>> Add "See linkgit:gitrevisions[7]." at the end?
>
> I don't think it's worth it to mention "linkgit:gitrevisions[7]"
> everywhere we can pass a revision. I think it makes the doc heavier
> than it should be, especially here where the command is a plumbing one
> for now and users should be quite experienced with Git already.

I agree that plumbing commands assume that users are more
experienced with Git already, so SGTM.

>> I ask because I'm interested in informing
>> the readers of our docs about any potential pitfalls from abusing this
>> command by mistake.
>
> I appreciate your desire to give high quality docs to our users, but I
> don't think it's a big pitfall and I think that this command is still
> very much "in the works" and is also designed for experienced users
> for now, so I am not sure it's the right time to spend too much time
> on this.

Also sounds reasonable to me. Thank you for considering my suggestions,
much appreciated!
