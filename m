Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72423AA4FA
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781557116; cv=pass; b=TV9e8UpLxdREJ56YiIOrcr+JJkjzIz6nZq1WBJR1bEaXOF7Y5BJQ/NaWs6s3sw4MjATVMjJyuWFb8G3OmTzpKNWPZfexG/AEUQQWzbwR+5ffzzeldJ0WEIvm5C3ZqLlOUenl02xMEDaawUE1JFiMF/dl80kgfVA7vyWmHyhQPws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781557116; c=relaxed/simple;
	bh=7f3WLkaA0SBKcrRGZCnvwznJzEF/tmAv4bcKuycZvSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uB4ksWPMlLXaW/13eLw8WcpXTyd5t0Jam9oAvxc0F0p8Oiq3p/52SgsHB4Xrbdec2rGvwhHlekuiYo0xsU4IWtvinqVB7e0xjzPx/63FvlDeQyIMBt0Ty8v9YDkCyCS9+zhyPi4tFwdzxGqUALNq6kMLut/XSWHFgZQiHF9JOno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=AXBalETL; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="AXBalETL"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66058b880e9so3734438d50.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781557114; cv=none;
        d=google.com; s=arc-20240605;
        b=lidNWa150BPaX4EHrp9GYvUiop7QHyW4xX5fUhMn8EBOdNej55ohKzq51cvSCMM6gY
         cs2HbqJFxLPJgzCEC10bylEC1gT3Bgx24AJvA6bLevO9fcKoK8vGlGDeReaYlgike/fs
         srVCvYXb7uVyOvCXNa6fclXpAZmRkpCJxGnalhOoJJckAwPURcfVjEd0fFveYZA17x02
         bP9drZZc5rJoeQWuSOv5zKLqzle2gaPfLnlZyfkT62hbHzvmcVZUzV/Eyn95ZDl0dEd0
         e69B7RQ434sZ9Q+jZVg4HTklAsMzhFZ4oAYU2aMWkvzYU9dDizyhmg/D9v2EjP7adIhw
         O2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7f3WLkaA0SBKcrRGZCnvwznJzEF/tmAv4bcKuycZvSo=;
        fh=x3yJ6RQ8ItFvGGTsmMj5TdRGFa+m2qBkw3TdrtuKeQM=;
        b=hWDWX40Xy1HYolyJ33Jusb/i07bsGahHHOhnMsvA5NEVWnt1kDy3b2qLc7/z8QucAr
         hnT62AlmOPWJVuiGDTgQ2HULSwW3Rz7LvCIiWjDJ8t/CIUapyIAcPHDe5YytMD2DokGD
         WiyNIwDw5tpbFT3n9PAv6ThgNrYoa9XhKwtnD4IZi8l+c9CJzp3fojVNNmpU/56ZebEa
         HfZHCCMhwU2zguvwJZriBijmrowVoob+W9VdodyniD7wlJgcX2yCAbOfX8uPNPX3lmpp
         6BzttbY1SghjXZfHPQFRbjRc7QCq6+f/u3PNYLOEO+xgv3PTJJMSWX5xxGar7Wy47n9g
         2X8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1781557114; x=1782161914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7f3WLkaA0SBKcrRGZCnvwznJzEF/tmAv4bcKuycZvSo=;
        b=AXBalETLHaFUrUtRYXKLASexp5ZDuOUvyOgWpdpx8n006AXi+gL64/WRIVfGRcmQYx
         fXjYxcr09X+ScJJO85utY+3JAigZAh/1KDUeMsL4+w9yjw5xO68SaTeY5CaEF6cdvgdI
         w1L1NqxGVQaMLYagdR/IBoIupqjJujAG0+SPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781557114; x=1782161914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7f3WLkaA0SBKcrRGZCnvwznJzEF/tmAv4bcKuycZvSo=;
        b=alieZ43zHyTKn6GU3f+v6xPPbVJ+MWIfx+CGl7J4iGhEE1Zn46+nhCPdJGv3apifpJ
         8Xm7Fr/57x4WCyVgfcfRAf5BeEwu9erXAi2MLQ91QstpJMgKeMYA5ddJxY0kC7cN7lpE
         l5POQe8NMWeTZ9JeYup7F6pVP5ZfJu4Gv6UNiZ7ptZTX0Hgy0saWRwETqt78YSO8C5+n
         lBifxxdzeaYAHs91PHvcxLTOm818ZYB3LlMqK0unq97AacbDgVS8qC8W0Muv4JvtTAwW
         PbD2MsHeaiAXgm04qFWBx6Dda6Q3ki1IR933Z3uiB+PW82z48gj9tZT5mhjSYp0DeII8
         yQVw==
X-Forwarded-Encrypted: i=1; AFNElJ9gRprLlYdOsP/77DXLBdsC0UG7eVU95yiMnbjRxvrz3+9PMUAqC/I7ozitYsOKCK9VGTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhCJHFtebw6TOXFV3BD4BZ+9jTf9tVg4bmLuaNyd/BOSW/T4MD
	op7IOvkVQwBiIQDJ8N/Te2/RcGCDDtFiVxXIgzf2XpyT5E0KYJ0sG0kJL4P4n8+Ux67b+kSKy3s
	SlGYqrtEAjgyf2s1ai36YzQzCHKQ6pHfJO7lQ8Zb+mQ==
X-Gm-Gg: Acq92OHev0wa8JZcw9SC+dFCeYbLjxqLPxtg8o627uNXygU4u0vVvPqRzWBDMlMHc1s
	C9/OnWW1cCJwhxtJE7UT4tPotj4ov9HWzd0uPLoLgXcLfDx5GDMBHlUOzKPsTpX6jWhJJ11BDaq
	1iRdFCGCIvV6GzHx8asWtHSPUvehIVz/B3HnV9qteyF9PYT694x1zHU+by9UcHcpm1hx4tqSlNP
	FKJ6SdDDyjnrf0vhCr6qbhkSm341lgJngZ6PrEzzpXT06nWelpk0bYQ3woFuIHfEmKVWGYmNmCb
	XH9H+g==
X-Received: by 2002:a05:690e:1301:b0:650:3bbc:5375 with SMTP id
 956f58d0204a3-66284f86d75mr10574535d50.17.1781557113569; Mon, 15 Jun 2026
 13:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
 <pull.2144.v2.git.1781178567862.gitgitgadget@gmail.com> <ffaf26b1-c55e-43c7-84b6-f810a54f7717@gmail.com>
 <xmqq7bo5nf31.fsf@gitster.g>
In-Reply-To: <xmqq7bo5nf31.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 15 Jun 2026 22:58:22 +0200
X-Gm-Features: AVVi8CdH2PLrS1KS2PMYGjiLcsK7MMMIQuzuRFzEEVrWB5-IWp-tVc7DfjHjeag
Message-ID: <CAL71e4P3Oq08xVPZ+dxQ8L5PKekPJN0RsL4pTicom1og7-1D=A@mail.gmail.com>
Subject: Re: [PATCH v2] commit-reach: remove get_reachable_subset()
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I think we should park or abandon this patch for now; I initially thought
it would be a somewhat cheap win in code reduction but the risk of
introducing performance regressions for repos without commit graphs
means it's not really worth the time investment and I don't want to
add more maintainer burden for tracking it.

Thanks for looking at it though, I appreciate it!
Kristofer

On Thu, 11 Jun 2026 at 19:48, Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <stolee@gmail.com> writes:
>
> > Finally, a commentary: You seem to have a habit of responding to
> > review feedback only through new patch versions, but I'd rather see
> > some thoughts in the discussion thread as direct replies to the review,
> > especially if you think you will change direction like this. Saying
> > something like "Maybe I should update the method to have two walk modes"
> > in a reply would have given me an opportunity to respond and perhaps
> > avoided a new version that went in this direction.
>
> Thanks for saying this.
>
> I haven't (yet) found it in my exchange with Kristofer, but I did
> find similar irritations during review sessions with other
> contributors.
>
> I wonder if we should talk about it in the SubmittingPatches and/or
> MyFirstContribution document?
