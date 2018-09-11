Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74A941F404
	for <e@80x24.org>; Tue, 11 Sep 2018 18:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeIKXac (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 19:30:32 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:34478 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIKXab (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 19:30:31 -0400
Received: by mail-it0-f47.google.com with SMTP id x79-v6so9625733ita.1
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFlzNVZyT5EW9gitXuVo/RMJMqX7Fpi/VcoagddeEFE=;
        b=TZrHZxUQB7gXwDwgT9pyoT+fQdmK9avkeyebTsrB9YEQHuLitoUj+GKGOU6Lm+Ue6/
         OZNTdt2a7viEVOJYYj//zRdSMdqLtAFV1S+WQ1pAjZrv6sk3w521XWp9dnP4DzbUd/Xp
         Yupzr8zYqOtVSOpFiE7bvtvYj2/03MR2zrLo3+Q/CEDLCTtipCXtyrdnKy1oHNjzYfg4
         yLeK8YdrWknNAo3Z9qfOfeMCQm8dzVIsZ3bp58IMblPaxxUPOcPcJYrman2qeizfwVdt
         pIt3o1uxOr72uixdGHgkb/lK+CCNiq0HC6oEKgEEJe1pfWTg2Dyxbcjaj4TIlHMsYNaF
         prRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFlzNVZyT5EW9gitXuVo/RMJMqX7Fpi/VcoagddeEFE=;
        b=XveEERhKwvos35n+dQhvw9SpKGY9v6Hl3qgQcRPA3qGqo6aq45IFhb0cUPKbjaNB+8
         TDEvxciVzTIkksVbUgU7YeYqEPCU7hq2pOY4uTrKbtYja0fpdbQwL431NC0VcJItz243
         QpHUmQk78zbgJ1yf4U6tLpHKHLMRdST7QitZIFLUmcJl6jB1lpqnaHUIPggDQNVTTZ8p
         5A9MgF5MHCIvQGjXThkErskIyxZ9sF5Pp7d0/69149AlLs77Q+tn8JmxE6fLYnx0Xru/
         iiKxtB6yYHxwSG1YZmWZP1TGladCGtQ2co2ZAFTeayVW0YrRvu9PRPPI4rHHF06IDA3A
         OzEw==
X-Gm-Message-State: APzg51B2rZ+X1bFsq5/tFwTKGyGAF/hh0915hpUC0ib4wuyV4DeuBwzD
        eUXC77zqNiYyV8b3v739MruFgfugf8xFfIrjnHhWSVWf
X-Google-Smtp-Source: ANB0VdbqynnoKS8HvVWF4qV0EEBB3auB35jSfhGLBa4GgBJToD47dgW/nvgx+YNFCK4iJ9QPZR1f1kpnd2uo0YRz6OI=
X-Received: by 2002:a24:7c4a:: with SMTP id a71-v6mr2743582itd.69.1536690569475;
 Tue, 11 Sep 2018 11:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAFXrp_fLwL5=K3B5rWjY+imoqtskT8LG-UH8ec3CPwM0iiSzFg@mail.gmail.com>
 <CAGZ79kYK7ish4_DaZN2bCfZz7LNAjxogQH1k6T=hFcxxkXzJQw@mail.gmail.com>
 <CAGf8dgKLz14ijnXwV0Y=M48Rij-scA19E_uXk3pBc0T02oE_0Q@mail.gmail.com> <xmqqo9d4orji.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9d4orji.fsf@gitster-ct.c.googlers.com>
From:   Ciro Santilli <ciro.santilli@gmail.com>
Date:   Tue, 11 Sep 2018 19:29:18 +0100
Message-ID: <CAFXrp_emK=k7by5pM5=GpsixJVeeJhT89-Cgq3JYbn5yg14CpQ@mail.gmail.com>
Subject: Re: Is it possible to git clone --filter= without any objects?
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, sbeller@google.com, matvore@google.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 6:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> > By "without any objects" in your email subject, do you mean "without
> > blob and tree objects"? If yes, there is some code in the
> > md/filter-trees branch that can do that with a "--filter=tree:0"
> > option.
>
> I too was wondering what the "without any objects" thing meant
> myself.
>

Thanks for all replies, as you correctly deduced, I meant "without
fetching any objects".

The mentioned --filter=tree:0 would basically do what I want it seems,
good to hear!. I wonder why not call it tree:none though to match
blob:none.

> What would it take on top of the following sequence to create such
> an ultra-lazy clone?
>
>         $ mkdir very-sparse && cd very-sparse
>         $ git init
>         $ git remote add origin $URL
>

Yes, this would be a good CLI API since the since the clone
--no-checkout --filter --filter gets a bit long.

Or maybe:

git clone --lazy URL repo_local
cd repo_local
git checkout commit -- path/within/repo

Or maybe even:

git clene --lazy URL repo_local COMMITISH path/within/repo

to do both in one go.

People are also interested in commit-less directory / file "clones"
BTW: https://stackoverflow.com/questions/2466735/how-to-checkout-only-one-file-from-git-repository-sparse-checkout

> At this point, the repository does not have any object, but it
> already knows whom to talk to to get the objects in the project.
> The remote must be configured so that it is willing to feed you any
> object you name, but would it be just some "git config" magic after
> the above three steps to make it as if it was prepared with "git
> clone --filter="?  If so, what does that magic look like?
>
> Thanks.
