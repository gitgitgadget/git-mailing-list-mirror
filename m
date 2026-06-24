Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1D2FB97B
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 03:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272962; cv=pass; b=oOS8vNfn0PABODQYj2/pM3XmrB83PEq23NrAUn6Z7daSmCfjXJngjb/MexN5mdtKE7etkn0vp0UZmQI15mtqaCkBNKmAlTZj4xwjiAw7dEJiGv4ds15AX3crb7Yr6Tl5AplBmBpdieXNrbHqEw5JawPytXIJgWlgAR+E2BYROp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272962; c=relaxed/simple;
	bh=UX3b4sBHtCfbBo31UMAx8bBHs0Kwint5Ed/Jg+WpAPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZplQH+ttVBLtjAvbFC449GMGt0sNEpPuZfHAU/bY5EB1zM9B2pcxqBLSX6AGuFMIadJg3GP+0uL2lcMtxVeOsA17kU6Tj8idtMZYsGSVlxaZpF5qO214MjaSrOY91FkqiXESG4JR55Zpl0AklasMqy7jHSD/Fwl/bS+Q5SCDBh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6GI0cVM; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6GI0cVM"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5ad53c8d4dfso623104e87.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 20:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782272960; cv=none;
        d=google.com; s=arc-20240605;
        b=NfMZAxYq2eQ8ILT2ATCmx2hmbmftNmUh8GlpvAYg2PWXyKL6QsAVcwMM1beOe2okzH
         NwlHtBOwzLAxByRrpVL0Nu6z34K1qWD7UFv9Vfn45qoycCTa+VH5HigcurWObAaucJwE
         3MLkjptbCMEgxtoM+KdEMN4v1CYg0NNzi7YWDPAmBwIhhapH+s9UFBg6XDGR9MvxZ9zn
         xlC/CznLPiebsbhBMZfMdN1ntSUEhnrRr32BaZX6U4EYUkTYgk2JFmbHTfx2ZM1B0Hmr
         8yrM4VfcKh9+derWN78VBTmYHy+eCgdBbbAIBRN+9zPnwhjXED1dS4tME7YVB6u5MaEW
         0fAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UX3b4sBHtCfbBo31UMAx8bBHs0Kwint5Ed/Jg+WpAPk=;
        fh=in1xd+juMApTOaLd+WBlK8qY5YRYxyrJKFEqJwwUO54=;
        b=CWujXafLhdSBe8iKuyR0SLvfJz/mjUrjSxVbOu9eVI9TtD4ktYNxP9VQAREzOciQ+s
         6DDFKWhlaewEltq78FBIXFBIy+nNWI7PLo/+cb+TIyHIacFsUXBnkMa03Jl9OTWWpvsN
         D5S76iP4IFbswYfbQgHcrPU7VDQzuvgAx4bzv5/jqbzfhBwtZM5wn1fplSktIfhL/LBs
         aewaa5XYgMpiOzCJIVaqGrcl/i8H9ldCxXnnwhzls2IdRQICg6I/J5rnfDab1iGOftKZ
         UES/2qhP+a/SKuNbsyWIMEplmjQU3rim6lFXkOwsapjVjenja66TOxUDwreWMnKBoeRo
         tZLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782272960; x=1782877760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX3b4sBHtCfbBo31UMAx8bBHs0Kwint5Ed/Jg+WpAPk=;
        b=K6GI0cVMPvgUWxRMIjoNsD1AyOO9aiPVnSPYaMrQNQjM+LMM6DIAh8CrKTdFADR7LL
         RQkD4dBip1y+Lq5H7nPZNYMC0wV7MtoAsNpqEVK7mRpcyG9QpbwaJSHFNA7hX2C3P6gW
         ht9XylVYI11VxODUFar07C+NdYGdganm9ac3hOscvUZRfqgxXapJNQkVUv6bFmiLGvWY
         PSzYowDrr/Xioo6bvrykSlYEbqPSmDPj6kGj29cfTwZ5NCrIq0pvVsdTXMuGEFvjah9R
         3Wi9tQK3OAba2O/BnGrsz8Ap/6/IbVbP9EHjaU9X5RFo9KWBMpzPh8YYsngm+vdPXGOY
         l1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782272960; x=1782877760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UX3b4sBHtCfbBo31UMAx8bBHs0Kwint5Ed/Jg+WpAPk=;
        b=QzN+vqomp9Ys9kFsIWxfBmEq10odwbguAdOo5cYqBD0b8PZvf7rbhf6APHmlaRTRxK
         waxXmriQc1mu5CsqCi2/BqVsMmD50j6x5t3zEVlBz1auhCcYAq5+h+3IVbuL5fNMURU2
         XxBcy9wo0YNtQUqm6SxIH7Fv5boYc2BIHTzYiq1WZFRFhQN+Qor39e+LqnXNe/2Z7fKY
         Ew8/fisA+ScF6jOWPcdx+r+n6AtiaDLE17yBFfD9aWq7e1WS4SBjrNuBNkPzGq8blams
         7dBclkKejk3Ad4126DbvYfaiJgYlVe7siv7J/blte2UtffoW3yjp2Adj6Jd83w9wyWbn
         tq/w==
X-Forwarded-Encrypted: i=1; AFNElJ+PNE7JzAMI4rK9piQDinlOsBF4SUBgqTuGnnQImaCaoiPsXS06+kS50TXW3zRl0wRgMdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4V9vdWZOwabnruGFcnb19uKlLoQfyZwwjuEMvkfha7fM4jGmA
	y1zaJlhiiW5hgSNK6bEEYgK1IVp7rYDUgPWv7VhxFmRoDD1AJ0dTfjZOjXU7fneAM0BvjhIdC9V
	xdmfTUsGqVnBOMHWD4KEPgnXR2ctloL0=
X-Gm-Gg: AfdE7cn1/hP1UWPWmrC1qp5oIHN64kdrVyglckact/Ehg/06srvwN8btu+VmhTLszXU
	ap+eo2TSbesHKckiA/nZdfJe+P9D5JqKCUc54H7Yw/a/3LIBn6MZZeAn3k5pNIu/n5QQWAiUAF9
	uqP/5aO02EUA+5FJzCNmTHF6xo+lRBo/qcCYRytoYgbSWOjdlFo5ulObkh2gQQM6ZFh0wyRtGjC
	fqOSFa2IY7UUJfn7ZGATPS4na5Vp5i+KPzt4IFoRXHJ6ADVCDEYsBh9l7CbG2CfhEFuZl2nshcd
	tf8A2dh5Lj3oTbIPfEXCE2LTCwn6TInOnd7D1bl+zu+3C1n866P32a17k3gmcfFxNQBMUGYvI0H
	n/zoEGkA65uR/HilItWRTa3eSZw==
X-Received: by 2002:a05:6512:3055:b0:5ad:4a8d:cf29 with SMTP id
 2adb3069b0e04-5ad69590286mr1482602e87.12.1782272959566; Tue, 23 Jun 2026
 20:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260621055534.46798-1-jayatheerthkulkarni2005@gmail.com>
 <20260621055534.46798-2-jayatheerthkulkarni2005@gmail.com> <084ad4d0-d872-4c7f-94a8-ec2383c7a8ca@gmail.com>
In-Reply-To: <084ad4d0-d872-4c7f-94a8-ec2383c7a8ca@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 24 Jun 2026 09:19:07 +0530
X-Gm-Features: AVVi8CdO5wHT5vtRw25naXpAtAI9mTRR5wwAyVDwRkFRhYQvHKPn3EuVwE3i2Z0
Message-ID: <CA+rGoLd4MLp5RuLMCJ3R+UDNtpY0UdKnxokz=z=QCz6mpCE0Ag@mail.gmail.com>
Subject: Re: [GSoC Patch v7 1/3] path: extract append_formatted_path() and use
 in rev-parse
To: phillip.wood@dunelm.org.uk
Cc: a3205153416@gmail.com, git@vger.kernel.org, gitster@pobox.com, 
	jltobler@gmail.com, kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com, 
	sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Phillip,

On Tue, Jun 23, 2026 at 9:27=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 21/06/2026 06:55, K Jayatheerth wrote:
> > Path formatting logic in builtin/rev-parse.c writes directly to
> > stdout. Other builtins cannot reuse it.
> >
> > Extract this logic into append_formatted_path() in path.c and expose
> > a path_format enum in path.h.
> >
> > Convert rev-parse to use the new helper in the same step to validate
> > the API against existing tests and avoid introducing dead code.
>
> The new API looks good now, and so does the conversion of the existing
> code. I'm very happy with this version and don't have anything to add to
> Junio's comments
>
> Thanks
>
> Phillip
>

I have sent a v8 with Junio's feedback addressed.
I wouldn't have a problem with either of the versions getting merged.

Both of them are good in their own ways.

Thank you,
- K Jayatheerth
