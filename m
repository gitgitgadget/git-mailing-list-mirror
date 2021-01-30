Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6F1C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 19:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CAA64E15
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 19:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhA3THu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 14:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhA3THr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 14:07:47 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4661AC061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 11:07:07 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id v1so12126858ott.10
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 11:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5eSu6ERTZ0L3eZ/XVB7DCdoohSx3adxoFkeFhHWAMg=;
        b=H8D1hOu3pxefWhqDBUeEo2i+/FyA19jliNSceXhPEn6SsvRZTd8QgYUWkTtem3LOuj
         rjaJmNc8z8rpjYPJx0zH8+2DJkGdjISNoHBnXYUhGoMqeSWhlHawgdE2n7RYjJ8rl3g4
         FkgHIpHp9SLdU8Syl3y9c12GqNJlKXZDH4xzznlN2bP/plCDkjcjHA9P2eigdde5kYBU
         R73sLI7SafgCDrGKF9jAaRRWfSvvO3/jPLbJkdBFHu4A7fj3kCuyhz9/mUGUFgA2j2kz
         sl4L5Rki3QEzQnBK9+XPrHh1/1Mk/LkEbGNQD7vh2h3g1Dm8bsp7EXpbpny8J0tTx+OO
         i6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5eSu6ERTZ0L3eZ/XVB7DCdoohSx3adxoFkeFhHWAMg=;
        b=o4Jg41fD46ZMvyo4m9jtMx2yI7ZNkaLjVNfXlHSQ+e+gvXTpBZYHUJPip+2pxln+3S
         I+SiTKH0+/GHr8F80hMCpYKtGCllHweGl+JhwqAwsMY3XgTJNKGqUE6smYkgvJE8L7Lp
         aVBRyjf4YInH8MsEsemHcltghNHJARc17Tg1fDF5+Is4iKLh7YEwOPhEgtD8edXVuZZt
         5GA5CpPaIzTHKYedDFNhf3H7sQCND2D4WDuCYu29+DNhVdfYNIhh0Bd99D+8+waYOmef
         V13N7IuwEdS086qrU9ocmUnTIc7yYYUug/WekywngLW6OwyPPchhHuUPl9b7Aa97bnno
         +G9Q==
X-Gm-Message-State: AOAM533NgsgwEv6nfuzjQ1DpWv7hZtgXLzQ7lFmoe1PVNjbp5trCV+I8
        Nsm7VhDRbYvGImoOc1FFxEVICKB8qt8J40T1EUw=
X-Google-Smtp-Source: ABdhPJzc5jImytaxVYbHl8wTppfWXaLi9IS1dLngM6nMcq4iVN+c+NBsVhFmNLQypOc0cvcarYzbwicyDbB3S7OWFT8=
X-Received: by 2002:a05:6830:543:: with SMTP id l3mr6946496otb.241.1612033626547;
 Sat, 30 Jan 2021 11:07:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
 <pull.726.v2.git.1611954543.gitgitgadget@gmail.com> <245e48eb6835cae4e61f65af780b766d990d4b5f.1611954543.git.gitgitgadget@gmail.com>
 <xmqqo8h7qoci.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8h7qoci.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sun, 31 Jan 2021 00:36:55 +0530
Message-ID: <CA+CkUQ_tyJMsxwopU=g-8keyK=Y1nzE1wgXnohQy3h8h_px4Nw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pretty.c: capture invalid trailer argument
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Jan 30, 2021 at 5:37 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >               } else if (!match_placeholder_bool_arg(*arg, "only", arg, &opts->only_trailers) &&
> >                          !match_placeholder_bool_arg(*arg, "unfold", arg, &opts->unfold) &&
> >                          !match_placeholder_bool_arg(*arg, "keyonly", arg, &opts->key_only) &&
> > -                        !match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only))
> > -                     break;
> > +                        !match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only)) {
> > +                     size_t invalid_arg_len = strcspn(*arg, ",)");
> > +                     *invalid_arg = xstrndup(*arg, invalid_arg_len);
> > +                     return 1;
> > +             }
> >       }
> >       return 0;
> >  }
>
> Would the existing caller be OK with this change?

Yes, I made sure of that.

> It used to be that this parsing code simply _ignored_ unrecognised
> trailer keyword because the very original just did a "break" and
> fell though, but now because this returns non-zero, it causes the
> caller rewritten in the patch [v2 1/3] to "goto trailer_out".
>
> It is not clear from your proposed log message if this would result
> in behaviour change, and if so if that behaviour change was intended.
>
> I suspect that the behaviour change the code implements may be OK,
> but the log message needs to discuss why it is OK.

I should have included that change in behaviour in the commit message.
Will change that too.

Thanks,
Hariom Verma
