Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311C51F453
	for <e@80x24.org>; Mon, 29 Oct 2018 05:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeJ2Ocr (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 10:32:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32906 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbeJ2Ocr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 10:32:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id i15-v6so7930950qtr.0
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 22:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9mXFx4k4uIt4GtfJwBQw2iw5vUwe7xNtaNkQx8BzdEA=;
        b=DzGcmABULzkkZs29m3gPc97JCDZW/AJ9i5zqvzSNd/BisJb3Bj+Oai6OYueb0Ob5d3
         AUoV9y3DztXmNhis2WMIZsgCDuC+Kbd2ni9R658NF+7WsAUEr17HZQf4v1gWYKuwbEDJ
         WmBdUnSGKWpICgpnTOZ4U1Eup5ilDyDLAWW/vs/y8hvd13/tm22d7Ah943zbJqDlKD5m
         DhpYyIqGXbzc2CXUKF/0tN3XP61Wr9thP602fqFh8lJ1Ks1H006k7HmSZQIToW6HJIGH
         36rBZ9Er5AYkDePsuFGenhnWIQHb/0hkK3nB3XEwNqFEmZBqJ76gP4c4HSXLGWDG/TuA
         DASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9mXFx4k4uIt4GtfJwBQw2iw5vUwe7xNtaNkQx8BzdEA=;
        b=hL9yS5TqXsjw0DhPS7J+4/K7VafMQEn3CO8UWaZ5v/rIzOxIO82JhE4lEMkskk5WV4
         dPLhQtARQSmdQU0c0MOkqcXl55QSIYaeC52J84nfHupqDUhcCMvpL2PXJYW6D/xtZpWD
         Mp+HDNEPf92hIkYBZ2d4qs0psObu+fcZkvOXRf7aVNH+IUD4u+j+G9nTC55uq/TzJ1Pk
         Xj0YrtigK0PPy2rVQaxWzAMHIWoRnGuPqW1wlNR0DCxe740qJ47Rqzd6ELPitJWFwE0D
         NYaas8zD3rnuWK94dmRw3Njae0x0AMcLgDpKjRqiuLQESFAlL3f+0Ipc9fMcPPdidAQ+
         NM4Q==
X-Gm-Message-State: AGRZ1gLwYKmBji5NU95NsHWVcca05OdHbXu9B7gQMH6w4W/YrfXeKloo
        WBCY/xGha7JNEfSNin3v8aDpOvan5uA3epKAsp8=
X-Google-Smtp-Source: AJdET5fahjAZjRV8Xpw5Fz9PPvhogtlqmKmzlUyJslWJwAisuN7JplWVksFpBzIuwDuAXP/9u5bbavt8bjSmWTquk1w=
X-Received: by 2002:a0c:ef03:: with SMTP id t3mr2343189qvr.148.1540791938401;
 Sun, 28 Oct 2018 22:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
 <20181025055142.38077-1-nbelakovski@gmail.com> <xmqq4ldajz05.fsf@gitster-ct.c.googlers.com>
 <CAC05386cSUhBm4TLD5NUeb5Ut9GT5=h-1MvqDnFpuc+UdZFmwg@mail.gmail.com>
 <CAPig+cT1XYt60PsRGJ0FUa_qCn1vPjdXHygsWzYZYg2Ey=yqkg@mail.gmail.com>
 <CAC05387mfDhJ5_=LyzxZZX09MoY1hsmSB1gseNeLCmMOUx2O4A@mail.gmail.com> <CAPig+cTTsbz1pygq6G281V+fR2VVMuchvy1Q1H-KEvJpjJ9ejg@mail.gmail.com>
In-Reply-To: <CAPig+cTTsbz1pygq6G281V+fR2VVMuchvy1Q1H-KEvJpjJ9ejg@mail.gmail.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Sun, 28 Oct 2018 22:45:12 -0700
Message-ID: <CAC05387rFq0yJ3nUVkb0jUyQy=EmZiCnBW9L53A6GS5=U0qUDg@mail.gmail.com>
Subject: Re: [PATCH] worktree: refactor lock_reason_valid and lock_reason to
 be more sensible
To:     sunshine@sunshineco.com
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 28, 2018 at 9:01 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Oct 28, 2018 at 9:11 PM Nickolai Belakovski
> <nbelakovski@gmail.com> wrote:
> > I would also suggest renaming is_worktree_locked to
> > worktree_lock_reason, the former makes me think the function is
> > returning a boolean, whereas the latter more clearly conveys that a
> > more detailed piece of information is being returned.
>
> I think the "boolean"-sounding name was intentional since most
> (current) callers only care about that; so, the following reads very
> naturally for such callers:
>
>     if (is_worktree_locked(wt))
>         die(_("worktree locked; aborting"));
>
> That said, I wouldn't necessarily oppose renaming the function, but I
> also don't think it's particularly important to do so.

Actually it's 3:2 in the current code for callers getting the reason
out of the function vs callers checking the value of the pointer for
null/not null. This leads to some rather unnatural looking code in the
current repo like

reason = is_worktree_locked(wt);

I think it would look a lot more natural if it were "reason =
worktree_lock_reason(wt)". The resulting if-statement wouldn't be too
bad, IMO

if (worktree_lock_reason(wt))
    die(_("worktree locked; aborting"));

To me, I would just go lookup the signature of worktree_lock_reason
and see that it returns a pointer and I'd be satisfied with that. I
could also infer that from looking at the code if I'm just skimming
through. But if I see code like "reason = is_worktree_locked(wt)" I'm
like hold on, what's going on here?! :P
