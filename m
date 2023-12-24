Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD9A3C
	for <git@vger.kernel.org>; Sun, 24 Dec 2023 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGB3+63M"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e77169686so324128e87.2
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703379782; x=1703984582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWFI+MDgTsIPjfp+8k37Vs4hVMZ5lPEddTdHFsZ9tBQ=;
        b=NGB3+63MTaRvkMMBFek2Rl/sLeU9v3sSqnkKwfvGCWpVpiXHlIzfdAN69YSCSbz4ir
         xQetYNKk+gD+cGJZwsc8RzuJU0SHNJUFO1XIbS3OR0nbuZ884RMPSw1QBMLaiXeA19hn
         XrzXcezepfB8x+PDSJnLQ/b+zxMmWZ1UKn+CMK19nMl4mW/Lnjw7A8MxTS5aLVTQ1OFT
         GsK4SkX4vPLjHxMrcCofoTb5lrFVG9v2jen86hEKy4ijpXLqX9QyeQYcqgB8PpLMT9Rd
         5v5+vuVfEKCvmNLLp9hFCDDp9fqQCGIC54ZLO4X1hdzhgOSbEDHctPWw3+K2oQ5U158M
         +kYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703379782; x=1703984582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWFI+MDgTsIPjfp+8k37Vs4hVMZ5lPEddTdHFsZ9tBQ=;
        b=bBgsLp5NaGIzlnLCkZvRBeiPXpyMTNtzwg95NU/8L903hYnUMLEChFLyPVEMQLLA6F
         hC9hBamhnJtB2isUpYWQ/bM/A+zoXNopcT3RY77ABoFOgDm//L2oe+Rhgh/SOQRK/paI
         Hlx9BeS6gVUM540RdiV8rx6tflNv0RQtgQDt1dQumWf+EmFKbIVx7ST+GdT1MmAppspQ
         GZRopGMwAzOzLXd/RM4FFf3RFGBjx7GjrIv/B+TLD1fmU/sPGLGlbxdHEoUy7YugWHL5
         l3hFctYKUGcTZJSnqf/1zpTRqKlOucUw4ceH4TwdwIvpf91BhedYjnZkMXGrlfO9It7j
         WAFA==
X-Gm-Message-State: AOJu0YwNrNOA0aaNbm8ZckWihoBqfjSwOse0BLiXXp8OFKJ7ysGpLgt/
	EtZM1affCASSzOi5DbEwn9YhhFIiwk5GCISzHno=
X-Google-Smtp-Source: AGHT+IGCnZ4PqlvB7LUji8hbpSxgf8/1cd79Zu1keo+L3HkeAMbtH8+PSuSIK0vwOkPP1X/vCgYj4NwGKvjlFOLzcYg=
X-Received: by 2002:a05:6512:3592:b0:50e:6a07:5c02 with SMTP id
 m18-20020a056512359200b0050e6a075c02mr1332872lfr.15.1703379782274; Sat, 23
 Dec 2023 17:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqbkakqx6s.fsf@gitster.g> <ZYN-5H-2NNoRRpf-@google.com>
 <xmqqplz0p90k.fsf@gitster.g> <20231221084011.GB545870@coredump.intra.peff.net>
 <xmqqsf3vmqug.fsf@gitster.g> <20231221214550.GD1446091@coredump.intra.peff.net>
 <xmqqle9njjp3.fsf@gitster.g> <20231223100229.GA2016274@coredump.intra.peff.net>
 <CABPp-BF9XZeESHdxdcZ91Vsn5tKqQ6_3tC11e7t9vTFp=uufbg@mail.gmail.com>
In-Reply-To: <CABPp-BF9XZeESHdxdcZ91Vsn5tKqQ6_3tC11e7t9vTFp=uufbg@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 23 Dec 2023 17:02:49 -0800
Message-ID: <CABPp-BG640jNdAdJic0wqmYXwz1HyzcBB6-W9Ef70AHqtPSECA@mail.gmail.com>
Subject: Re: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in set/add
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 2:45=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> Hi,
>
> On Sat, Dec 23, 2023 at 2:02=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> >
> > On Thu, Dec 21, 2023 at 02:04:56PM -0800, Junio C Hamano wrote:
> >
> > > Jeff King <peff@peff.net> writes:
> > >
> > > > Right, that is the "gotcha" I mentioned in my other email. Though t=
hat
> > > > is the way it has behaved historically, my argument is that users a=
re
> > > > unreasonable to expect it to work:
> > > >
> > > >   1. It is not consistent with the rest of Git commands.
> > > >
> > > >   2. It is inconsistent with respect to existing options (and is an
> > > >      accident waiting to happen when new options are added).
> > > >
> > > > So I'd consider it a bug-fix.
> > >
> > > So the counter-proposal here is just to drop KEEP_UNKNOWN_OPT and
> > > deliberately break them^W^W^Wrealign their expectations?
> >
> > Yes. :) But keep in mind we are un-breaking other people, like those wh=
o
> > typo:
> >
> >   git sparse-checkout --sikp-checks
> >
> > and don't see an error (instead, we make a garbage entry in the sparse
> > checkout file).
>
> I think you mean
>      git sparse-checkout set --sikp-checks
> or
>      git sparse-checkout add --sikp-checks
> (i.e. with either 'set' or 'add' in there)
>
> Neither of these are currently an error, but I agree both definitely
> ought to be.  (Without the 'set' or 'add', you currently do get an
> error, as we'd expect.)
>
> > > I do not have much stake in sparse-checkout, so I am fine with that
> > > direction.  But I suspect other folks on the list would have users
> > > of their own who would rather loudly complain to them if we broke
> > > them ;-)
> >
> > Likewise, I have never used sparse-checkout myself, and I don't care
> > _that_ much. My interest is mostly in having various Git commands behav=
e
> > consistently. This whole discussion started because the centralized
> > --end-of-options fix interacted badly with this unusual behavior.
>
> Well, I care quite a bit about sparse-checkout, and I would rather see
> Peff's proposed fix, even if some users might have to tweak their
> commands a little.

And I wrote it up as a patch over at
https://lore.kernel.org/git/pull.1625.git.git.1703379611749.gitgitgadget@gm=
ail.com/
