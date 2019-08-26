Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A49A1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfHZOvD (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:51:03 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40307 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbfHZOvD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:51:03 -0400
Received: by mail-oi1-f179.google.com with SMTP id h21so12293289oie.7
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faJRAGYKlv7a5O/UvwLkUaEAzfHPj1XzVrpPmnG76q4=;
        b=bjtA/1MLYK+LqEj6xEP/59sYAILOiKov/nZKyDKP/E8CIlyd0qwsfDnQaZYZdBW1wt
         UBYBBZpMIfNjON2vt2JgN21qlrj/Dde6VNobks5dGLJMMAwozbSjUKuneO5m1U07IAGb
         nuBckHf6QnX5JwEM+bkr/93JpJGrO/tG5JN6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faJRAGYKlv7a5O/UvwLkUaEAzfHPj1XzVrpPmnG76q4=;
        b=gvjPa7fxYenezcZAfZMiDeCzLI2zQ+b4GxyKy4RYkkgc8QCuKPMIrzuyRCxojtFWjV
         dNAeK4PTHeeZtAGIQjcKpwj38a8uHtC1D4lxlgT95xbTYihRLnCqg2Db1CUUpLLDZ4j1
         eQo73xG8z8LSZbMvPPxk6T8oIAgaBd/n6caZykSnGkkf5wZWPoY6uIACbsK2e9luzw2p
         dILGN62Fcpmi+4Dj5chNiupWFwtPoS2/8scQii26AVeH6Gfu41OiEHGyVkg6esoypA5F
         +rCQzbEdppoO/M3eOY3/tXwhk5xqFFYC2WXsS1+COc89VqYaRw+A0aow4kbCWkJHwsoy
         tJ4g==
X-Gm-Message-State: APjAAAWYBdxmOuGUvwTy2911U1WaZKZIKaoN+8pjHIADwUB1gn+KbZNr
        jQriICbyY4tq11Qho6C+MIC5IQkyTvlEcIhRtuNnHg==
X-Google-Smtp-Source: APXvYqwbBvoWh1linCj5AxhPaw5cHoTgLnkxKn3c/jCrhrd0FOk+Xbv404/WRtXJIEH52jGPAwNcmzVcduGNvJkIDG4=
X-Received: by 2002:aca:d8c3:: with SMTP id p186mr10276038oig.56.1566831061987;
 Mon, 26 Aug 2019 07:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnyXxScGO6Eex_AEbgH=YFQ2yzY1hnXavyNMkiXbrccVUA=Ug@mail.gmail.com>
 <nycvar.QRO.7.76.6.1908261615440.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1908261615440.46@tvgsbejvaqbjf.bet>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Mon, 26 Aug 2019 10:50:50 -0400
Message-ID: <CAHnyXxQ46TC8hhjwLS-OtXzEDHaKxvCxj9HZMrs-ksnXFTxj_Q@mail.gmail.com>
Subject: Re: [RFC] Add config option corresponding to --rebase-merges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I am not quite sure about the "cousins" thing. If at all, I would make
> that a global option, I think. But then, maybe you have a use case in
> mind where it would make sense to rebase cousins in some, but not in
> other cases, cases that can be discerned via branch names?

I wasn't sure about that either (in fact I don't think I knew it existed before
looking in to this), but I included it here in an attempt to be "symmetrical"
with the --rebase-merges flag functionality.

Both pull.rebase and branch.<name>.rebase support the value "merges", so I
think a rebase.merges config boolean is at least a no-brainer. In this case,
though, it concerns me that you can set these to either "interactive" or
"merges", so there's no way to have both. That's why I also suggest adding a
".rebaseMerges" option to these (to allow .rebase=interactive).

I could imagine that there exists some workflows where
--rebase-merges=rebase-cousins might be desired either globally or for certain
branches, though I don't think it's something I'd use myself. I really need to
play around with it in a test repo to better understand its implications.

This is the kind of feedback I was hoping for, though. I'd be amenable to
adding only the simple option (if there's any kind of consensus on that) since
that's the one I really want to use myself.

Thanks!

Dakota

On Mon, Aug 26, 2019 at 10:19 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Dakota,
>
> On Fri, 23 Aug 2019, Dakota Hawkins wrote:
>
> > I'd like to work on a patch to add config options that correspond to
> > rebase's --rebase-merges flag.
> >
> > In my workflow, while it's uncommon to encounter merge commits during
> > a rebase operation, when they are encountered I pretty much always
> > want this behavior. Since it's rare, I pretty much always forget to
> > ask for it, with interesting and confusing consequences.
> >
> > If nobody has any opposition to the concept, the following are the
> > specific options and values that I think makes sense and covers the
> > existing functionality.
>
> I am in favor of this, as indicated at
> https://github.com/gitgitgadget/git/issues/318
>
> > # New rebase.merges config that takes effect if set to true or cousins
> > + rebase.merges=
> > +   true
> > +   cousins
> >
> > # New cousins value for pull.rebase
> > pull.rebase=
> > +   cousins
> >
> > # New pull.rebaseMerges config that takes effect if set to true or
> > # cousins. Intended to allow pull.rebase to be set to interactive.
> > + pull.rebaseMerges=
> > +   true
> > +   cousins
> >
> > # Corresponding additions for branch.<name> config
> > branch.<name>.rebase=
> > +   cousins
> > branch.<name>.rebaseMerges=
> > +   true
> > +   cousins
> >
> > I'd like to get feedback on the idea and specific options proposed,
> > if only to avoid having to tweak them once they've been added.
>
> I am not quite sure about the "cousins" thing. If at all, I would make
> that a global option, I think. But then, maybe you have a use case in
> mind where it would make sense to rebase cousins in some, but not in
> other cases, cases that can be discerned via branch names?
>
> Ciao,
> Johannes
