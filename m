Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9FF1F453
	for <e@80x24.org>; Wed,  1 May 2019 09:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEAJyL (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 05:54:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38154 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAJyL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 05:54:11 -0400
Received: by mail-io1-f67.google.com with SMTP id y6so14455100ior.5
        for <git@vger.kernel.org>; Wed, 01 May 2019 02:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n30ZYNrv0V4Hxaf4UAVVsP2kItRCMIYLFWzXSJGVGQw=;
        b=KmXYaQtQwMkx5B/hcIyZgikGOsiIb0/Tu2RYr3BZovW08yMLZjqn68ck53KmbgOaK5
         h27jfum1hyzk+Q21vvUyrG45AWItjhHaD7rea91na6tS5CsI9+zbAsio6aDTAs4ZS2jg
         XK0QIK405nUn0chgd3V11lv77HurdGTVucuoaJgfXOJAeRGa3e10Bcj+RFDTyq+o4sUA
         +OOfH+6amWDvxvYe67l1p0FRCHoJn0WUliGw+8ORX3QdklY0I1iKfehn0In7OhBLS2DY
         3q5Rmg0u72xk0144I3UirZZLugxShK515FWniJy3MjNNVFsFrsArqKtn3bTbkEavdBkc
         Ae9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n30ZYNrv0V4Hxaf4UAVVsP2kItRCMIYLFWzXSJGVGQw=;
        b=gMs5RWJZjV2mhROZENP+MRDFZ5uJF++847K0/rCueE1vXVajtpiXdeZE96mdd5p0Q5
         mLUrUkZ3s6N8Soj/sVjH6nTrNWmJTF5DRC+O5tpmCg5VWjqiGYIsNowKY8ICD5qVAE1s
         4decaBI/j8PLscUFzUOe3aQ1+CEshtfDbhp8Zo0hrEc0I9MFKxdU51I/w74EftKYwQMe
         dN2rwXfqIi+Z/nbJOi+yDSSZNq6YaYco4ZmAcsMur9NPMjt9izzsXpQYU3/m/NqrVNtC
         hhhFLf092WuaeYK0+P+FztPjkngqLxmu6jWT1QhTMPvhi6+lSalWj0zUTdwrqORYSHf5
         Mr4g==
X-Gm-Message-State: APjAAAUw9A90LMN0E22BFELc2y7Wxv4g+jZeayENKskLUMRsVPVns2KW
        jSsb5zJLLx+p88u0voSgnmflAKxuxQNbahV/qI8=
X-Google-Smtp-Source: APXvYqxAuUmtljEbbRRqPh8gwUfswr3/Lfse8JxeWEUUnCH8+7fjDCul4QG25WpXmSp1+RXgso6INtKWjPuzIANWZAQ=
X-Received: by 2002:a5e:d702:: with SMTP id v2mr7778384iom.236.1556704450341;
 Wed, 01 May 2019 02:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190320114703.18659-1-pclouds@gmail.com> <20190324082014.2041-1-pclouds@gmail.com>
 <20190324082014.2041-20-pclouds@gmail.com> <nycvar.QRO.7.76.6.1904292055300.45@tvgsbejvaqbjf.bet>
 <CACsJy8CUNVWqWff05Lg2xjnOj3L2T7RvVbZh+RZPjvFokvT_-A@mail.gmail.com> <nycvar.QRO.7.76.6.1904301811110.45@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1904301811110.45@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 May 2019 16:53:44 +0700
Message-ID: <CACsJy8AGf81=_BTd6+idnBcHPB2AAj=dciJn6r_rCB8TJ1hvug@mail.gmail.com>
Subject: Re: [PATCH v2 19/20] diff --no-index: use parse_options() instead of diff_opt_parse()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 1, 2019 at 5:12 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:>
> Hi Duy,
>
> On Tue, 30 Apr 2019, Duy Nguyen wrote:
>
> > On Tue, Apr 30, 2019 at 8:02 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > Hi Duy,
> > >
> > > On Sun, 24 Mar 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > >
> > > > While at there, move exit() back to the caller. It's easier to see =
the
> > > > flow that way than burying it in diff-no-index.c
> > >
> > > I just noticed that this commit message is missing more than just a
> > > trailing period. It does not explain the change of behavior: previous=
ly,
> > > `GIT_EXTERNAL_DIFF=3Dheya git diff --no-index a b` would silently ign=
ore the
> > > external diff, it would have required an explicit `--ext-diff` to pic=
k it
> > > up.
> >
> > Because I was not aware of the behavior change.
>
> Well, your patch removes an early return in favor of a later return that
> allows plenty of diff options to be configured in a different way than
> before.

No (and I was terse because I did not have time to look more into it).
The code flow is the same, the number of option parsing is the same.
Even post option processing is the same.

Bisecting points to 287ab28bfa (diff: reuse diff setup for --no-index
case, 2019-02-16). From the description (i.e. "miss out some settings
like --ext-diff...") the behavior change seems delibrate. Adding Jeff
for clarification/

> So while it is obvious

I probably have problem understanding. The "commit message is missing"
seems to imply I knew about this but chose not to mention it.

> (and understandable) that you were not aware of
> this behavior change, the real question is what we should do about this,
> now that this patch is already in `master` and on its way into v2.22.0.
>
> Ciao,
> Johannes



--=20
Duy
