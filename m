Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608AC2BEFED
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250515; cv=pass; b=irkKFP3bdPc1M5fiLtc25AFCD157HigUca7CSoPOJqa7HXmiFcCB8tppD264J6XMQi/cX/0dlqWtF5nYOM+S5ToihB+Aa3bvwkfbkMGzrWl3mBq+LxWHQmJJWASVqtqkoArJWxVD3LfWt9fXzUotdyEShhx482Nei779bxR1siU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250515; c=relaxed/simple;
	bh=ubNtk9mqdflwxDC0LUAlnZRq8Ci7EzPvnevG/+TIR8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2wjKqGPzZUxdtShorKCOuDOWLTGdsT7RJJXcPrseXUNjraPG1PMxpzW31SqhLGc6jdnP4YH8ec7sLFXTPqHVKbWuVRlyedbvjtffhWUEgwuhc4mDcXBth+fwra6Xz7VDdqTR5YHAh6DGDrsdVcJkOi2jXQY43PQOGFeoi9l3so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gacETzYR; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gacETzYR"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-463f00cda04so100285b6e.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773250513; cv=none;
        d=google.com; s=arc-20240605;
        b=gIZ19IeS5X4f2ViiXi7L1TuRoJ2eanyAOaOZMOqrQYsSNPk68KeOEBlAUYQqPeloaG
         rYHkrts2BpNn3nUHzS/wEEP0ATafCDCDastNWdiSScA9r254iAlxkBdKHnbFJojQWe8q
         3xIvVfZ4idXqNRCCLXbEl782zVl2c+l3leL0teAuO4BCqWpyiGBrZA7IYmfPQtt2kVpA
         lgu6zke980iGbZM7qJPJXICiQ2BEOYdozHwSTngVj8Rn8dUHuXFlEVVr4mvgXLAttTiw
         p6mk+MwkIJvPeAuzr6MbHAbL8IrsaQPj2w2xW4+l4pn0V4td8GntWUlNx/If+wy/sOkC
         OSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ya2v3CHwXZBOwucuCMyU2oOAt1jKv1/zlwc9T/VmyK8=;
        fh=I7kSREOKccExaJIk4LHZTI4NDp0TCFfrn+5qiZPtFGM=;
        b=ALk34A/fOVMQpdEJqEmgQo1jJk4e1aqCl0UJwXwmJOFYN/TjXSobnhwid1kriJCXQu
         HmpVNwC6DSw+ikfyiwaF7yzuEG1ekoGuJ6MXls/mmLWA1B9NpY7eIysniraZBFnG2O2o
         ADACspw/Qmg+eBSBPZlFBChSAxavOLbMFZ6xfG2PisJiKogV5JpJHXs3sWjfqcNuoock
         Jc1FAEWT+FtSNt2HN5y5Nl9OvoobdbS1nF+BdDx/qk5l+onoRd2GFezx6fWfJT5fQ8tu
         EeJRnpVM3CnBF65VlYmvwzTjEv8dmjFlT1vpwrKlkVyu9muQfGsUq/HkKHS9AjCsQRMZ
         yeCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773250513; x=1773855313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya2v3CHwXZBOwucuCMyU2oOAt1jKv1/zlwc9T/VmyK8=;
        b=gacETzYRyMIND2EpIxoUJitEWzCd876lzoZTTK0617Im125hj7qoQ7/vB4zLulLzqc
         UoFMUaJcHBEgGx3iDPQyfgUjoQCFn23DfjtzbErSPjrndS+jPJ/MKBpArglFgQCjDmZr
         rFbefPWu2H0/mFcABJ/BuQeew9fQ4kv319qTUuc4z1wZ43DwvJu7DzmStyxGGPUaxzLb
         34wH1zn4wFMLPfntFLmK+wJhrDfy14xRRlWr7ANVj7At+prvfblu/bAnI8VwOUDxfc6x
         l/dqX6ZfczR9kd4H/dXgsgxQeZ7oOalEMuKbLNf+6cNhzCPKJWGLKC/KLrNY3w1ZJrha
         lMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773250513; x=1773855313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ya2v3CHwXZBOwucuCMyU2oOAt1jKv1/zlwc9T/VmyK8=;
        b=T5KMqolMOz4ZnoCfIWBN7WUQ3gSO8Ids6uYhe5ixV/SB6Ra5zbxGchsU7EgfRol43I
         nJ3wBe9gMuaAZEaMhLKV16XKdEvQAAL9asWH1/m+DFE8EOjf7VvdK7OMCJkF8YQNyigo
         FkhOATPkxZ5zudwMETa0+dQxaXJ+96fHxqnc+tYsLL0EUy/lNXG4Gkmxd/EK7XjK68u8
         Yz+Jv78jua+ZoTkqe0rEvrxnSj9vEE1AjwlpJJKF9Ao+ik6FkgWD3rgqRpIU830PFO5m
         PMEAgWQnTobkkkAUsSKfCuMcwM4ror55nMrJJGmfwVsSW2FgjTKm5YGsxT535evkg5zr
         /brg==
X-Gm-Message-State: AOJu0YwZTb4HbVVGbaHppQmOymzhFNZs7NImI+VXEqYPmm7FL2Xwddz2
	MG+DfOH9Qtv62ICRdOxeTbc4pbcfRMGFCMEvB0LCpU4MILolRFv+iwOMinMUjibZbPcS5KG7wPI
	IBa9liFmzjHD1h9kv9vXFyfhLQ29x1ezWkg==
X-Gm-Gg: ATEYQzz7IRm572KPJ0h9Kc8E7wWMpAey8TJ5gDgPKKx8diCa0X5DVNvhKc6WYGGxAHJ
	Q+zVJYv8hea2JrKgP7pCQYZlIwyZaJQqtuMd3hUHyf0/cuqbtsTsQfg29WdSwViLHU6yc0kVAAJ
	f7UHA7gp5RXpMm5KDTGtze0dI6Ts2NZ0nSkh9LMbdYlYFXdE8ty0bMk6DLWGc0Sy+tYLh/WOAZx
	fAhGZ8qkZpsRys6tvmpRxRzMWUulYwyiAEgdeQeXS+hC8uajlmEyzDei/NIJdkbXOxxpk0qjz+S
	U5XXjJoeDSFde0l10jb7O+29Hq59BHFO4H1cfSow6A==
X-Received: by 2002:a05:6808:191b:b0:467:1ad3:7ee with SMTP id
 5614622812f47-46733546206mr1865844b6e.40.1773250513215; Wed, 11 Mar 2026
 10:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
 <0d3e84a088ec53368a748684268db89064632871.1772845338.git.gitgitgadget@gmail.com>
 <e551ce17-8118-4b3b-ad8c-bdfe1a854c0b@app.fastmail.com>
In-Reply-To: <e551ce17-8118-4b3b-ad8c-bdfe1a854c0b@app.fastmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 11 Mar 2026 10:35:01 -0700
X-Gm-Features: AaiRm53-luanBbbjIx7R5_pzeM5aW9UdqIeL9AHc5FlF4VBmZ_lJRhtcEgq1sfo
Message-ID: <CAC2QwmJTqYj5b531itc=8ZM3vXsg5oG3BLCHiEuoB7d0d4U=TQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] doc: note that -L supports patch formatting and
 pickaxe options
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 1:41=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sat, Mar 7, 2026, at 02:02, Michael Montalbo via GitGitGadget wrote:
> > From: Michael Montalbo <mmontalbo@gmail.com>
> >
> > Now that -L output flows through the standard diff pipeline,
> > document that patch formatting options like --word-diff,
> > --color-moved, --no-prefix, whitespace handling (-w, -b),
> > and pickaxe options (-S, -G) are supported.
> >
> > Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> > ---
> >  Documentation/line-range-options.adoc | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/line-range-options.adoc
> > b/Documentation/line-range-options.adoc
> > index c44ba05320..aa236281b3 100644
> > --- a/Documentation/line-range-options.adoc
> > +++ b/Documentation/line-range-options.adoc
> > @@ -11,5 +11,9 @@
> >       Patch output can be suppressed using `--no-patch`, but other diff
> > formats
> >       (namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summ=
ary`,
> >       `--name-only`, `--name-status`, `--check`) are not currently
> > implemented.
> > ++
> > +     Patch formatting options such as `--word-diff`, `--color-moved`,
> > +     `--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
> > +     as are pickaxe options (`-S`, `-G`).
>
> You shouldn=E2=80=99t use indentation here. This is a code block now.
>
> Just a line continuation and flush to the left.
>

Good catch, thank you. Will update in followup.

> >  +
> >  include::line-range-format.adoc[]
> > --
> > gitgitgadget
