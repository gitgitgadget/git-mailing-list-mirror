Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE3D1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 22:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfJKWYw (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 18:24:52 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37468 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfJKWYw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 18:24:52 -0400
Received: by mail-vs1-f65.google.com with SMTP id p13so7238319vsr.4
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtdjQTO6j13icQI0cYDFp5NsH4Uf15rdPP4sYUbLJBk=;
        b=lxh83dFWlLa5iYATqqgLV2YWzSaMMlslnNiVV1yvdQx2+oqrPFpEP8ltr7UN3Hb5T7
         lz8PVO8QrYO3UYykovjkuQVrl33oVfj7hjQFxH9v6C2KX/5Qcq/NznYbp+VqCKmLEXNk
         2bz96l7TrhGsedrE/ztEo/c5QlBYNJ0COWFoPYTvuPsvRolh95zP3lqmvrvohh3Qtp9J
         TxaWCobBqIg4caecqTb0Wdot4B8OUadFGvg0/P5OM+5sbSKNjH9xfCN79RdaoJmsM2BH
         Zjiboi8HsFFz6LOO2zBWsZtCxvwIT9iMXN9W9roPKMeyyr1agXP/AMlTJ5MwWRrz7jEu
         p88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtdjQTO6j13icQI0cYDFp5NsH4Uf15rdPP4sYUbLJBk=;
        b=qUBr5Mmmm+qCx4mhfsGHyUCbKeJYne0SpCueZ7YXne+VqYNjAuG33vIVUbuloucNul
         Tgp0XQoIGlrupkpqgKLa4i4bt0SdCW4jcPH2D94OsqeNWaI+93BaimnuaFuH6Pra9arn
         o5if+88Fqgd93GpisUpnouvrHGvY4t6/UyCBbHk9KDu705b1ygkjFQpC5sf/oeP3N/oN
         +/UgPhMObmmKxDPwEgXSe3lHzWe7PpBIjiQve6da4l8djZmUNiOKVCEoGGH2FaMz47ba
         fHGeAzamoMh48Uq/mCBI61vtGRg3L3Z9ETmP2x8Ds8djosQxReGfC45pxCEE75C/Gw5f
         T9MA==
X-Gm-Message-State: APjAAAV1oR66UbRSnO9ynvWsTBuCZXHaPjxfuCgyt7qzqs0sXbQ9BNFT
        Nv/JQqlIezB40flH0nIGLYmvN9AV6S1+cWUhpbo=
X-Google-Smtp-Source: APXvYqx+E6ekMziHq4UgxHFIlK41zSDkXw1bkwMa6i5GFiVokZwnOu/ay2tO2pz8IJ11g/o/SMavoNrfXjhj0/PBv/o=
X-Received: by 2002:a67:f799:: with SMTP id j25mr10809006vso.116.1570832690824;
 Fri, 11 Oct 2019 15:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <pull.316.v2.git.gitgitgadget@gmail.com>
 <9a78f9ea0fe8d1988654f52a86a01031607621fe.1568904188.git.gitgitgadget@gmail.com>
 <CABPp-BHB0UM1G2tHQ7igRX7Sn1O9ujW6mq_e-UGanGMONHxiag@mail.gmail.com>
 <CABPp-BGcZT2-m=D_X4d7zE9pzuWTKCnmURruahdQndpp=+-_WA@mail.gmail.com> <0c3e34ab-1eee-fe29-f584-d21047fd1457@gmail.com>
In-Reply-To: <0c3e34ab-1eee-fe29-f584-d21047fd1457@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Oct 2019 15:24:39 -0700
Message-ID: <CABPp-BHTa1Bk=_pkaBk8FOLcHsTP-z3V=ETLeSu79KPgpzdD4A@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] sparse-checkout: 'set' subcommand
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 11:26 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/5/2019 8:30 PM, Elijah Newren wrote:
> > On Sat, Oct 5, 2019 at 3:44 PM Elijah Newren <newren@gmail.com> wrote:
> >>
> >> On Thu, Sep 19, 2019 at 3:07 PM Derrick Stolee via GitGitGadget
> >> <gitgitgadget@gmail.com> wrote:
> >>> +static int write_patterns_and_update(struct pattern_list *pl)
> >>> +{
> >>> +       char *sparse_filename;
> >>> +       FILE *fp;
> >>> +
> >>> +       sparse_filename = get_sparse_checkout_filename();
> >>> +       fp = fopen(sparse_filename, "w");
> >>> +       write_patterns_to_file(fp, pl);
> >>> +       fclose(fp);
> >>> +       free(sparse_filename);
> >>> +
> >>> +       clear_pattern_list(pl);
> >>
> >> It seems slightly odd that pl is passed in but cleared in this
> >> function rather than in the caller that created pl.  Should this be
> >> moved to the caller, or, alternatively, a comment added to explain
> >> this side-effect for future callers of the function?
> >>
> >> The rest of the patch looked good to me.
> >
> > Actually, thought of something else.  What if the user calls 'git
> > sparse-checkout set ...' without first calling 'git sparse-checkout
> > init'?  Should that report an error to the user, a suggestion to
> > follow it up with 'sparse-checkout init', or should it just call
> > sc_set_config() behind the scenes and allow bypassing the init
> > subcommand?
>
> Maybe a warning would suffice. I still think the workflow of the
> following is most correct, and not difficult to recommend:
>
> * "git sparse-checkout init [--cone]" -OR- "git clone --sparse"
> * git sparse-checkout set [stuff]
> * git sparse-checkout disable

Recommending the right thing is easy, but users will call things out
of order despite documentation.  If they call disable before init, I
see no problems that will lead to confusion.  If they call set without
calling init, I can see them being surprised...so I commented on it
and asked if we want a warning or whatever.
