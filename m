Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7341E20248
	for <e@80x24.org>; Wed, 20 Mar 2019 12:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfCTMEk (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 08:04:40 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36811 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTMEj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 08:04:39 -0400
Received: by mail-it1-f195.google.com with SMTP id h9so9878667itl.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 05:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SdLvEWOW8FpVcEGUSjOtqfAgX16ZxmZCPmgXRPPqhr0=;
        b=q7fFBVNHqyJBBTwfJQ1UfnZRXLKm0KwWwznCwDJn3cq6BFcZ9vCoHtOfn8rgyBOtYb
         eD95UZcxmGGrY83LuKGNpa9esuzu0l+Fx1Q1dLjjjd87fV1oPtBZki8Ac2FGDw17Z91+
         SdX7DehKrnpKiuhTb8qAb2xwkToe7fu5KGWID8fzBvTVG3lAzHRRUTvfUGYbXGva35hu
         Uq0jTRElDs7jigK8cf9ARmmXNVrs1QtTj+vXeOPV/1dsUloa4FG7EhYMZW8soh8eQnUk
         Ir/2qmSD/s2RwQKlK9C0Nd+S5KZW0KNpFANsqhCz/fO4f22MvgMIFIxZuqXLmYFukQ8e
         ivmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SdLvEWOW8FpVcEGUSjOtqfAgX16ZxmZCPmgXRPPqhr0=;
        b=m1OhUx6UTny2nWR74W2hLI89kDV1Lt3c61q4+r6iWLlzdSS2xFHpgFFaWupd//QvGk
         UaX1a1awJgJh3qGhawAYS052co50YYoDLi/Rx107jrkQ8IJaURHXad79KL2HX7EixBCr
         IjUuqBA676GVor74H5aPsTh9zDSfLy28HMt4A4CvEKObRhky62b/vlHtikLW2U/dSPL3
         a6JOxmRoNsSMQDwLuZB7tJYz0jX9CWkRLWmvS1HtAVd1HNA8JYJKdwOc+Xz41io2KQIa
         FvATtpCDnKovhNrLxmK7B1+Rl/XfPO96CgKs85e/yDj0Pt5MyVCu09KGsfj0SiawTaU6
         j19Q==
X-Gm-Message-State: APjAAAVkWfjS2RYalNw18ga4DoMdb3qf2Y1c6Wmf4rdCswzB+iOvWKKY
        qabXVXqySI+0UB3a0tpQ5SrWG8bJD8PJHCXiBU8=
X-Google-Smtp-Source: APXvYqxbd0BDPB8Ws0FKfKbboQ2q7eUP5XXT92PqHlPJHGwtKVvPfNmtSq2ltiwqZV2nPelNJ5x//JyKxTEuQj5vbkM=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr4920978ita.10.1553083478575;
 Wed, 20 Mar 2019 05:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-1-pclouds@gmail.com> <20190308095752.8574-11-pclouds@gmail.com>
 <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com> <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com> <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
 <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com>
 <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
 <CAPig+cSe-v-GU=UG_PyUjf9itz_Ddqq4-Ni4h=2TtbLDXr5WJA@mail.gmail.com>
 <20190314091753.GA9852@ash> <CABPp-BF3_p3+fmQcWYEu2z3J4FfPmDmiMyFiBRXyz8TxKLL7jA@mail.gmail.com>
 <xmqqr2b56ir6.fsf@gitster-ct.c.googlers.com> <CABPp-BHHhQH9yb6h714vCAjnfyEbxtNUJoja1Ym1f5B88yfgWA@mail.gmail.com>
In-Reply-To: <CABPp-BHHhQH9yb6h714vCAjnfyEbxtNUJoja1Ym1f5B88yfgWA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Mar 2019 19:04:12 +0700
Message-ID: <CACsJy8CLpC1bdZRfbUzw3J+WBc0ZV5WTOfXczLfaQ7vRMqZUdA@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
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

On Tue, Mar 19, 2019 at 2:10 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Sun, Mar 17, 2019 at 7:03 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > I don't see why <start-point> even makes sense to use with --orphan;
> > > you should error if both are given, IMO.  The point of --orphan is to
> > > create some entirely new history.  So, I'd expect "git switch --orphan
> > > <new-branch>" to:
> > >   * not create refs/heads/<new-branch>
> > >   * set HEAD to refs/heads/<new-branch>
> > >   * empty all tracked files from the working tree.
> > >   * empty the index
> > >
> > > Alternatively, you could allow <start-point> to be passed with
> > > --orphan, adjusting the above steps so that both the index and the
> > > working tree are switched to match <start-point>, but ONLY if
> > > <start-point> defaults to the empty tree when --orphan is passed.
> >
> > Do you mean that it's like <start-point> is not really a start-point
> > but is an initial tree, i.e.
> >
> >         switch --orphan --initial-tree=<tree-ish> <new-branch>
> >
> > is a mere short-hand for
> >
> >         switch --orphan <new-branch> &&
> >         restore --from-tree=<tree-ish> .
>
> Yes.
>
> > I think that does make sense, but at the same time, I think a major
> > reason why people say "checkout does too many things depending on
> > the arguments and conext to be easily explained" is exactly due to
> > its many "if you give X, it is like writing this longer command
> > sequence" short hands, so...
>
> Yes, this is a concern for me too.  I would be happier if we made
> --orphan and <start-point> incompatible and avoided the need to
> explain how they worked together.  Besides, as you point out, the
> wording is bad and should instead be a separate option named
> --initial-tree=<tree-ish> which people will then start asking us to
> allow them to specify even in cases when --orphan isn't (e.g. `git
> switch --initial-tree=HEAD maint`), which is a weird/esoteric usecase
> that is probably better served by using separate commands.

OK let's reject '--orphan <new-branch> <initial-tree>' then. It's not
much work and when people come back complaining about it not working,
we'll know more and may reconsider then.
-- 
Duy
