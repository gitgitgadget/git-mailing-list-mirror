Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A1420248
	for <e@80x24.org>; Mon, 18 Mar 2019 19:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfCRTKQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 15:10:16 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46815 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCRTKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 15:10:16 -0400
Received: by mail-ua1-f66.google.com with SMTP id j8so5654712uae.13
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aY53h7u79OPWw4mmd+V5SUrxtHZQC7bXqvY5WPpaCPU=;
        b=Oo3mTxLjI2dbo/MDqdlLS6cXeeUwax+eq2vI4xjxC5XH13PWOA60xNbCvOqWYYCnRh
         G2SgKyLpdE2L4S/RLQKJxw1AU7BKwPPalWwxw+r3cQYG7bTgFoPh+yxXY0PvD7hPz8Cl
         AiLceZrjxclA1JVxs/VZ34YNuuG7v19ekB3bQ+e7Qb1IDfLpEltk/sTNM5uj/58+WbqU
         B/2UcHdVPbMuK5NyS8KB7tB4cYESZK0MguCTot6Me9FwifQWFfgjjUMl2BHWKygWbjUk
         PBY7SCzr3nEJNdhaYlhuNGUrEeHp5bFuP5ssMSYLLh1G1eVrVuuLOTNUFlZzvlospX/8
         aVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aY53h7u79OPWw4mmd+V5SUrxtHZQC7bXqvY5WPpaCPU=;
        b=E3+q1PPxz7c+Y7/5ol7SO9YPloI79i7b9eLzAcYLuT9MvNWEptTuaoNl32WbBnBxTk
         iMb7npMCrZbMtd/ZMjdQ7uuEGMvOgSP+IHoV5uoouJq2s1dE1MkvhCQnIWzKzt0Z3nyF
         N4u6nCaqmFFFOSKRTOpvh3pfB7RHOq9L//RDtC31gNNS44D+5uNUoz/JwQasm0Y3TZ1i
         MYNTtXmBFn1xT5pVoAuoD5FW7PbWpd+5sNqdbAvTX+oHIQIM2z03qe/5ZUbSPaY1rl/X
         TFoTCivOHmh/jldoNW28OFCYOZJftePNatozNId6vvRDlxl/PV8PzOwrOwo5t4mh/mFY
         3Kaw==
X-Gm-Message-State: APjAAAXT4Yy1XjoSNOcNpifE7+Yjuiiw1irdUSxPyuOAF5ZvVotEufh/
        vZukBCFu0HAYsHMzTUU0z1ejM4CRiW2IhcPH1C94z18Q
X-Google-Smtp-Source: APXvYqz+N3IW/6Yj9xBHFVHfSq5cSRvlr3KB7Pd3b9ejmye8Oq7T+2UwtSLJu9VwuCBqs0qVVYBpqH94zkWK3Nxgb1U=
X-Received: by 2002:ab0:2712:: with SMTP id s18mr6646460uao.114.1552936214476;
 Mon, 18 Mar 2019 12:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-1-pclouds@gmail.com> <20190308095752.8574-11-pclouds@gmail.com>
 <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com> <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com> <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
 <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com>
 <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
 <CAPig+cSe-v-GU=UG_PyUjf9itz_Ddqq4-Ni4h=2TtbLDXr5WJA@mail.gmail.com>
 <20190314091753.GA9852@ash> <CABPp-BF3_p3+fmQcWYEu2z3J4FfPmDmiMyFiBRXyz8TxKLL7jA@mail.gmail.com>
 <xmqqr2b56ir6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2b56ir6.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Mar 2019 12:10:02 -0700
Message-ID: <CABPp-BHHhQH9yb6h714vCAjnfyEbxtNUJoja1Ym1f5B88yfgWA@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 17, 2019 at 7:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I don't see why <start-point> even makes sense to use with --orphan;
> > you should error if both are given, IMO.  The point of --orphan is to
> > create some entirely new history.  So, I'd expect "git switch --orphan
> > <new-branch>" to:
> >   * not create refs/heads/<new-branch>
> >   * set HEAD to refs/heads/<new-branch>
> >   * empty all tracked files from the working tree.
> >   * empty the index
> >
> > Alternatively, you could allow <start-point> to be passed with
> > --orphan, adjusting the above steps so that both the index and the
> > working tree are switched to match <start-point>, but ONLY if
> > <start-point> defaults to the empty tree when --orphan is passed.
>
> Do you mean that it's like <start-point> is not really a start-point
> but is an initial tree, i.e.
>
>         switch --orphan --initial-tree=<tree-ish> <new-branch>
>
> is a mere short-hand for
>
>         switch --orphan <new-branch> &&
>         restore --from-tree=<tree-ish> .

Yes.

> I think that does make sense, but at the same time, I think a major
> reason why people say "checkout does too many things depending on
> the arguments and conext to be easily explained" is exactly due to
> its many "if you give X, it is like writing this longer command
> sequence" short hands, so...

Yes, this is a concern for me too.  I would be happier if we made
--orphan and <start-point> incompatible and avoided the need to
explain how they worked together.  Besides, as you point out, the
wording is bad and should instead be a separate option named
--initial-tree=<tree-ish> which people will then start asking us to
allow them to specify even in cases when --orphan isn't (e.g. `git
switch --initial-tree=HEAD maint`), which is a weird/esoteric usecase
that is probably better served by using separate commands.

> > How about:
> >
> > """
> > Switching and creating branches always involves knowing the
> > <start-point> to begin the new branch from.  Sometimes, people want to
> > create a new branch that does not have any commits yet; --orphan is a
> > flag to allow that.  --orphan overrides the default of HEAD for
> > <start-point> instead causing us to start from an empty history.  The
> > use of --orphan is incompatible with specifying a <start-point>.
> > """
>
> With or without the short-hand to say which initial tree to populate
> the index from, the above description makes sense to me.

Yeah, perhaps "...an empty history with all tracked files removed from
the index and working tree.  The use of..."
