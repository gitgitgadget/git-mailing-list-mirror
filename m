Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A9E2E8E07
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934521; cv=none; b=klU0BTOO6CcJGwv8iFVLvGlHrRZue8KigWQK34oa0utba3ft14oybErA+WvhJlu9eTrj3tKqzuT/a/SnKFGoLqUY+BdYtM2gI5xS2p0Ig1RVMU8HieBjgaBCA2mHoA9LcHe/WbRDxamOu3Tb6t1JgfxlGlVo401jBu9r8yHLics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934521; c=relaxed/simple;
	bh=mJAba1olcjzKpnPtYlmnasIvWXA7Qw4WmCUYYCpjfB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvrB5dzuW/6zIICvd39nAioStzgpSHJgJcOYRIT049spbrHiLIqkvndLbopilFLalyNgApB9DzIqiVY8ZEYELHtaCW9al8HZwkokgZxima9STNzEQu7jw/ljEBxPTJlcj6b3VfR2VOId7OMNy08T+jDb9Xz2KHNly5j9v05aHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-726721d76a7so122466d6.1
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 14:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756934519; x=1757539319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNc95vt3rMaw3+6yTLYE2vTtTzDjHp+HtSVuZT4tkmE=;
        b=Cc6k5l33edAVuQeYT+5TmLascXuBSMpE8FG6+OHEeLrz8D/vopYFt9a7i0sV/Girxe
         yko9AN+sfRsGAJtsgP1wBf2kuo8xWid855/efiS0GRxCK+ZCYYsKCwz8w39KGTjR2Mhd
         76XL2HWFBaYDUrKGyHlqNCINDRDUn9fc4MwNVYkdXfs9UpdcIUbtzOThbYMxNul7D2A/
         jktmJXsTgNQrDVrD6tUGHnuAhdZuo7CAWk6cpwJfcpvr6mNaOltZ2vUQ4WVc6R7mpCP6
         dOPeFpbZpqzKxfJjQ/6xgmPOeKoFr2NIeVZC25LRepXEFsqF+TA75AXjIi/HLIzaXzoB
         +zsg==
X-Forwarded-Encrypted: i=1; AJvYcCVOuQc7C5FeoupKBcNXS0dPv7AaJQA7IaA9PV+hD2HiedzeHUd7Ueo9EDpzDcvJBGspZA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZBF3u2edAN9fZ/0EDfPG9rcTxeesgygprTchkUgeyeKj+bNq
	3yhPAxvJk7xOXCSUzVU43J0niFTkmA39r0tjmeOYsGV6S41yDmaQUQqaGVuFTIB44rFa3/cSi9s
	0HlkNZHqzbul6ZPv5q3C+y5ChRxCMToA=
X-Gm-Gg: ASbGncvuFAhzRel5U0cNQr1PCwlDOMrMtZi0+7+bTbcF776W9fLbnaAJGJSzdVlj7y/
	to6lFxLcTU6XMhrfSzH3NTwrNgjy9IOXWuoL4z31GdT36UEnsKtRncdiOJFe8llIis1K6EXku5I
	B045EiVxwoIX+rRSTguTaXeETV3U5YO/xjMfMeWLkyvLFSmaF17zy3rp+RyBhZpd6ADg3QhGa6S
	eInyg==
X-Google-Smtp-Source: AGHT+IGdd3uMQtHWAXAVBoy1vmQcPpA09k0bVEdHE9NCw0/CDdBibwZ79Qtlgj3km1AdljbJehogsIt+3L7KlLQ1wOE=
X-Received: by 2002:a05:6214:21eb:b0:70d:f55b:e940 with SMTP id
 6a1803df08f44-70fa1b87094mr146215196d6.0.1756934518706; Wed, 03 Sep 2025
 14:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756311355.git.code@khaugsbakk.name> <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
 <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com> <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
 <xmqq349czcl8.fsf@gitster.g> <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
 <CAPig+cSL=-gD5+WomF7-hYjVJ_PH0m+0i8g3F=E_U3k=QNHr8Q@mail.gmail.com> <15bb8d07-675b-4ccd-8345-ab5861319faf@app.fastmail.com>
In-Reply-To: <15bb8d07-675b-4ccd-8345-ab5861319faf@app.fastmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 3 Sep 2025 17:21:47 -0400
X-Gm-Features: Ac12FXz71EWlJY1vLg5Z1lcLM4aoevQ-7jaxiNbWUI4-pOLofj86BDm1IeQ_auI
Message-ID: <CAPig+cQdwr-a_B++=2+q4mV8oZ7VLTYEQ9wnVP84jFYkTHFtHw@mail.gmail.com>
Subject: Re: [PATCH 1/4] usage: help the user help themselves
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:54=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
> On Wed, Sep 3, 2025, at 18:50, Eric Sunshine wrote:
> > I realize that the changes made by this series are not in any released
> > version yet, but from reading the emails still arriving which argue
> > for retaining the command for reasons of muscle memory or because of
> > its (strong) mnemonic value, I suspect that the hint(s) this series
> > adds may not be complete enough. In particular, the advice this series
> > adds (use `git log --raw --no-merges`) seems to be primarily aimed at
> > scripted use of the command. But the muscle memory and mnemonic
> > arguments suggest that advice should be given for interactive use, as
> > well, such as proposing that the user can create an alias.
>
> Good point. I would suggest discussing it in the
> breaking changes doc under a new "For Users"
> section. I would like to avoid expanding the error
> message too much due to the already mentioned
> fear of overwhelming folks.

I have doubts that users will consult a document when presented with
the message.

> I've seen  "troubleshooting" questions from git users
> who got one of those long and well-described Hints
> like e.g. detached head and default git init branch
> when either the msg already spelled eveything out
> or the msg was purely informational.

I didn't spell it out above, but what I had in mind was something very
simple... not at all ong and detailed; for instance:

   For interactive use, define a Git alias `git whatchanged`
   which runs `git log --raw --no-merges`.
