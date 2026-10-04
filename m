Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93903F65EA
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139844; cv=pass; b=Iuczztr/2TkNNcjAEUZsykxRN2ccmFXvWxvpJ3W20d8I8rm9tcIAErJCkLjh+uIvv+n6LG6dsFUEW8113TkShU06qBQ1Wiwd/hjJOQyP4JRK8ug8a9XonPb3HqN/EQqWIu09QtJqZ/yyT8JZgoCQNJLcUByXC5iTAYswiE+QTs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139844; c=relaxed/simple;
	bh=raw3DaA0H+Vfb6MC7dwlIDcrTffLalnaqSTo2sKKklc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZPNXuQDQsvC3mnQzPQS+/i44MpKXkbLG1y3E8LN0XhXU8Qbu5mnYiRntfsFwTUDxZjj1KhckEkB0OEQUX04o27bf99rJp8XIy7UUg+7ckZqbX1DoS5dlsW2NY3pOwDRqpmIlr59GxxkE6HGr/RE4qAZ8QewQ3WBLbRBsjaOMfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMYSvptR; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMYSvptR"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb8b78d6cso1460039a12.2
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 11:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791139841; cv=none;
        d=google.com; s=arc-20260327;
        b=KkXSpyCTjLzDCtlpxnboRzAswBoXXVLbTQU5oepz5D2OyLBAD6yrhESpmggYutxG6Z
         bWjb4OjxdCa6POMR8lqGnLAgvWXj4rbJ1enoTFewiw/kFny1uUUBwFmC6QIFSBImMS/M
         siOi8kZnKf0MBS2CZVCLoU12UQDHyxBeCdwmKiD0D/ehIvUFZp4x9ooNmQBY5M21LYmR
         G01Wj3nIjUOzVlwvu8eylfSsOtU7I5ZTAOdp+7A9G+kVBEr4xfWI6Iueyp44BivAFWGY
         dq+WbbNax5P8BFM5TRt7rlcocpgwFQy4+ZeFNF4zx/TT0Iuc5+FXBwLSRMnUjbX1O7Xe
         5w3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+IY+L8UCihgfAgAowZCOgGPeS40eQFZO6najDcVRIME=;
        fh=C8TL4Rw+TQkaiBQexLIOVJYcHayK0SGyNbvL40Kn6g4=;
        b=H828u9AMnqkzQagoI+pkhK3DEQlWRK1iot0D1yKBtM6wK1wfONBKCyNg2x9/qce4S9
         y0NgiVSTCRcbWOrft6EqSJ8cqq4LClO2OEwj9Uc69Su+YH9a9aqaJyCd8dCL2kSUiXjz
         J3fV3/61dsS8rNTTNsdCmAcfxXqxsc8HkgMEgWABR8aEGS5PN/LMDr1VlT1nfdOeyx3h
         0ysTC8lEINTVzq8tnE0XUELSzII3y07CyX46LscbeR/xA+pvMyjrIPMVZDfmF4sfAWUG
         D3OISXYO6KIhW2Q9R30AM2kezTCoFqjagvvva4tCTK8wVvGEE1OSF/OpfHDg4q0s5Xky
         CJNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791139841; x=1791744641; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+IY+L8UCihgfAgAowZCOgGPeS40eQFZO6najDcVRIME=;
        b=FMYSvptRSb/IaDORS+QLCpY2sMnCNS55Q7t/0Xf+Ld8Xsp9VJ+ckseOgntUcDfepJ1
         1o6aCrpOaB3RBOL3JW3qLjko7j+zQk5XWJx1bmLUyxUBI3IENPyQUUHAaTOUFhThQKXx
         K8whrrcoURYUownVK2xTy496t55uDlIW5gL7Ua4JuLKNg4d4Uq7uZ4O3ZQENQt/gtbjx
         YJ/jkN8p4/A+wofA5UD7VTAWXjLntSrCU/1UHzi6/O8y/rGYqh1RHhF1/zw05clYBK4k
         2HMjHvUxd8xYLUSLM5DN7vol+8hgAQJZdOPZRKBKpI8qf1I5bK/1gy9V9evep2hiUIqS
         x+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139841; x=1791744641;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+IY+L8UCihgfAgAowZCOgGPeS40eQFZO6najDcVRIME=;
        b=ntleO0OvVlb2NjCaXAc9xtqfHEN2sLDjlJ1krdVehuJ9Q6ilF058rrwPvI4BZAhgFI
         fpGRQPsB6fzN053aJMOdr3uLVdmrq04vJBCVKGad1l30Vlbq+j1j7cfS+RW9hl8t6N44
         v7k/kRs5VlCoEYTwOI9EX3r8jt4tlwdz31ICJODshZ3OKhi+7+6Njiozf20yxqLs1ADh
         Vp2c2pKGi9nELuQeW3+i15D2GZNG68QA1CTGKWWCyg2lOJz2HW0Cg481bLUk4BvwdGm9
         6H+CV6GaoyuxKIynU2gKkYDMRl+GT33RGRj7uK+29S6vGjbbSYU7ngL7GGLg41hWWEKp
         hMJg==
X-Forwarded-Encrypted: i=1; AKwUvBzHe8zfBWgcLeGu36SUqeEiHZ9BResyl6rjxS87eDJzjMHsVOGfDFCGnAiheMkI4R/KHa4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBkj8MSXG16xzHihgwgUo6ivoR+Kxa226brpiqZxBCk9+MSkkp
	xYSvLqH2iYyUqW7T1Pt4cpJp4WeNmdOwjdmo5WCk0M4qWO5aWeXOgXAWZIW2eo+twJMMfdHz8RD
	dUQ0E68Ff4OlrjOirXTXKaD3HTps0WRQDTQ==
X-Gm-Gg: AYBFou1JtQLqnkIYSsyUGPqoJkYyAG17ZlyMLIKbISQHlPJYZHZWQaRctZNDKAVHZlF
	j4fnRa/Mz+A2JMUFF8wdzdmweJsQERj+ecRmYhtzjXRL4k4z1MITUYN8dWTPa55Gd8pdYZoHpy5
	B1kkI02S5H/KLxSkbRLV1rRzyDaWWJ+56zYavovgY9kY7DbgpmpXIOkeGZx2LXSJQie+wS7ZQU/
	SNOqiukfRVSdCMAQZRCNlWto1D+u0zgUf17vWB23FEiBzVRK6kD8TWJclH7c27IdFN1XjrLOqiW
	x7CekqxqNwXP9xFRDVEMpdUBjVfjWzuTUVJU4E9oLE48JEYUlFRWJSu+5Epd5BGqLA==
X-Received: by 2002:a05:6402:4556:b0:6a3:ee60:b13f with SMTP id
 4fb4d7f45d1cf-6af9e2d4a6emr4746352a12.14.1791139840982; Sun, 04 Oct 2026
 11:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2428.git.git.1790960147943.gitgitgadget@gmail.com>
 <ae47baff-daaa-4b78-97e9-94faebb8e694@gmail.com> <CAHwyqnXN=DZ_EzfTfxZ_==8HS7zX25NKoQw58Ou6HZELP_n+Qg@mail.gmail.com>
 <79a242b0-ea1a-40d0-b1d2-8ef029fb0521@gmail.com>
In-Reply-To: <79a242b0-ea1a-40d0-b1d2-8ef029fb0521@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 4 Oct 2026 20:50:03 +0200
X-Gm-Features: AclHuK_h1MrReLkDLxJbN6ZCvWtCKfYauTtjRxSsU4PN-KFK-_V_ZJK_u-EvWLc
Message-ID: <CAHwyqnXuXWYWZ_c364-CpY8tmXjeTwGgYY=X8TtGs+2XbLbWHg@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged default to every upstream
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >> With hindsight maybe
> >>
> >>          git branch --delete-merged [<upstream>...] -- [<branch>...]
> >>
> >> and
> >>
> >>          git branch --forked [<upstream>...] -- [<branch>...]
> >>
> >> would have been a better design. That's the sort of design mistake that
> >> is much more likely to happen when a contributor sends an endless stream
> >> of patches because they're eager to get something merged, rather than
> >> engaging in a thoughtful discussion with the reviewer.
> >
> > I appreciate all the help here, but it's not necessary to throw blame
> > either way. It sours the collaboration.
>
> I'm sorry if it sounded like I was blaming you. Getting a patch series
> merged is a collaborative effort and any issues we discover later are
> the collective responsibility of all those involved. I do though think
> it is helpful to think about what we can do to try and avoid design
> mistakes and feel that spending a bit more time discussing things and a
> bit less time re-rolling patches would help. I also think that would
> likely end up with things getting merged sooner as, if we've had a
> reasonably detailed discussion about the design and implementation,
> we're likely to have ironed out a lot of potential problems earlier in
> the evolution of the patch series.

That is fair. And you should know I am very thankful for the help and
the sometimes harsh feedback.


Harald
