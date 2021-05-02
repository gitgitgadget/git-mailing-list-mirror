Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABDFC433B4
	for <git@archiver.kernel.org>; Sun,  2 May 2021 02:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E8061446
	for <git@archiver.kernel.org>; Sun,  2 May 2021 02:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhEBCQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 22:16:21 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45978 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhEBCQU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 22:16:20 -0400
Received: by mail-ed1-f41.google.com with SMTP id d14so2401131edc.12
        for <git@vger.kernel.org>; Sat, 01 May 2021 19:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCE0dTzmQZ3WLrQRj92UYz+acqtjsFQAhQLVFtHrog8=;
        b=H6cmpei43sObQIrdTxwdz1zQ3Li4YX4RXD29GMyVBNfcPojpn/AizbqiyDMdSe/Ac1
         EJqxT5+bkdPnGHi5iQh9gvt4bskiCzj9vlMSedkDdCJm1DWOktVfUzTeIM//E1oLJx/A
         9/qnFrilNERBl5Wp5HmXyfGVSmZ8v7A+zjZZYx2Us0UkJhiqDqQgc/4ZFR/3F2UFmbvx
         ic6e8UWL4u7bYRJoTfVd8hFEhy/pzGO2DJfzzWV+FF5xasaSQs1LNhr8Y1faYvUxaSzF
         BxM2YN1jATGSRlivGT4rl9EgE7ADUWdrXhoqFCsT0jHXWj8kFEJ7tSfcKMvMbHZ+2u6H
         Dovg==
X-Gm-Message-State: AOAM530p/GZjz0lWthWKkoBY5iPsjDHpn7e+i9UfDBvxOVUR0o+dxQvW
        n5AxTJGJyGsGb5rc1QDUjcUkKazHo0T+xqiM/99Asm7RxMTxOA==
X-Google-Smtp-Source: ABdhPJxcQkgMbem5Mx9PAZMAlK2Pa6pbioaVCUkQRu37CsVmQLoNLzTYAt9vapy1bbGjw751GjmkOsApLBBjPlgalGI=
X-Received: by 2002:a05:6402:447:: with SMTP id p7mr13636669edw.89.1619921729382;
 Sat, 01 May 2021 19:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com>
 <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com> <xmqqbl9zcawf.fsf@gitster.g>
 <xmqqk0ol7cka.fsf@gitster.g> <CACZqfqCXrhUtsC3TLYaw6u7D0VohsBcz10aVxpe-1u8gg77qxQ@mail.gmail.com>
In-Reply-To: <CACZqfqCXrhUtsC3TLYaw6u7D0VohsBcz10aVxpe-1u8gg77qxQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 1 May 2021 22:15:18 -0400
Message-ID: <CAPig+cR0Z=sUPHW8kuMG0sOv4bb309MV=WTR1nMGOoYB+1yfVg@mail.gmail.com>
Subject: Re: [PATCH v3] git-merge: rewrite already up to date message
To:     Josh Soref <jsoref@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 1, 2021 at 9:51 PM Josh Soref <jsoref@gmail.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > I am not sure why this is Co-au, and not the more usual "Helped-by".
>
> If you look at the thread, you'll see that the code in question was
> written by Eric [1]. The only change from it was the addition of
> `void` to the function prototype by me.

Oops, I suppose I've been doing too much Go and C++ lately and am
forgetting `void`.

I don't have a strong opinion between Co-authored-by: and Helped-by:
in this case. Here's my sign-off if you want to retain Co-authored-by:

    Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

> Junio C Hamano <gitster@pobox.com> wrote:
> > Actually, not so fast.  The end-users do not care really where the
> > message originates.
> >
> > $ git grep -e 'Already up[- ]to' \*.c
> > maint:builtin/merge.c:          finish_up_to_date(_("Already up to date."));
> > maint:builtin/merge.c:                  finish_up_to_date(_("Already up to date. Yeeah!"));
> > maint:merge-ort-wrappers.c:             printf(_("Already up to date!"));
> > maint:merge-recursive.c:                output(opt, 0, _("Already up to date!"));
> > maint:notes-merge.c:                    printf("Already up to date!\n");
> >
> > It probably makes sense to replace the exclamation point with a full
> > stop for others, no?
>
> Maybe. I'm not sure what they mean.
>
> I generally try not to do that when I initially approach a project, I
> prefer to get more comfortable w/ it and let it get more comfortable
> w/ me before I make significant change proposals.

Indeed. While it might be nice to settle upon a single punctuation
style for these messages, I don't see this as a requirement of the
patch in question. It could, of course, be re-rolled as a two-patch
series in which the second patch addresses the exclamation points, but
fixing the punctuation could also be done later as a follow-up patch
by someone (it doesn't need to be you). So, I don't see a good reason
to hold up the current patch which stands nicely on its own.
