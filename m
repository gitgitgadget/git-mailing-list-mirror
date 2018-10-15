Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 796A11F453
	for <e@80x24.org>; Mon, 15 Oct 2018 11:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeJOSsu (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 14:48:50 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43114 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOSsu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 14:48:50 -0400
Received: by mail-oi1-f193.google.com with SMTP id s69-v6so14689748oie.10
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBcwSgrUAAoepLPRv4jJmzeO0RwwTkFJ2UyHrnp7wlc=;
        b=PBrwj1UQLSq9BYomMBhMeO3yrvVeEituO39J04i8dqdyvRUd7MEOWB9oAZCiFSiO6F
         XbtBxRK/HiCaiNnSdHDzd+Y9f/ua4XuRY5f+0oi6e/e4mTTpSdDJHT0+2/+kXZM2ECgE
         WZkSmb+kkVY84zAi5lGLtkVqk/4fdU68q4l7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBcwSgrUAAoepLPRv4jJmzeO0RwwTkFJ2UyHrnp7wlc=;
        b=DfmnxkxL6ZDjDIKBRGM6e4ICsgxsO05B57y284o4dlbZbwVdhrWtLjbq/PHw+C5RQk
         7Isml3JNbA2vNDIE5I4kOmH8kmEfJrZwOWV0JmmIMvhbb5V/ukYfg61bHLoBlj2mY1h/
         mEHyPdjrdm9BfTWQ7ezfFZjR2Xoz9J3qyEz1wMluNlFL0ObsQSya+eYKtZsHAJ3Ih3Au
         3wShRYspuV2xVJdE/FTfMtBURcQB0GZlN2OfGKJIqlihaOpReL/IjAMjft6/CWc0tKKr
         LW7VxGSHdUJ2XCEeoa9G+Glw3QdUQGM3vyHfG23qgtO28kzblsC7JSULpJgP/gC0mBXX
         sqWw==
X-Gm-Message-State: ABuFfojwWES8jGBNZ3/fiYH0isv0QNZtaG3Atf7xUJF40PZN9pBE4dOY
        FBEqWyIEkYQDWOxigG5tXfhPgAAHFIMEZFvdNO4cOQ==
X-Google-Smtp-Source: ACcGV627nWkyXfwe+wEsqI4RMdEtAWeRVlpu8fkBuBFoq5USekuGhmCimWfmIHYT5cTcJ64CW3t2VrQycpacAxkhcXM=
X-Received: by 2002:aca:2d90:: with SMTP id t138-v6mr8326584oit.217.1539601444226;
 Mon, 15 Oct 2018 04:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181012052833.6945-1-luke@diamand.org> <20181012052833.6945-3-luke@diamand.org>
 <xmqq7einb7ob.fsf@gitster-ct.c.googlers.com> <CAE5ih7_sT8aP7n6h0moEj=6JjRAGJ+AXUCDkTFoJmnbE_Nh1mA@mail.gmail.com>
In-Reply-To: <CAE5ih7_sT8aP7n6h0moEj=6JjRAGJ+AXUCDkTFoJmnbE_Nh1mA@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 15 Oct 2018 12:03:52 +0100
Message-ID: <CAE5ih78u7n_A+cYXQO+Pt6K48_WaNnrxwHMK0JeHNG6pp3f8Xw@mail.gmail.com>
Subject: Re: [PATCHv1 2/3] git-p4: unshelve into refs/remotes/p4-unshelved,
 not refs/remotes/p4/unshelved
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Merland Romain <merlorom@yahoo.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 12 Oct 2018 at 19:19, Luke Diamand <luke@diamand.org> wrote:
>
> On Fri, 12 Oct 2018 at 14:45, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Luke Diamand <luke@diamand.org> writes:
> >
> > > The branch detection code looks for branches under refs/remotes/p4/...
> > > and can end up getting confused if there are unshelved changes in
> > > there as well. This happens in the function p4BranchesInGit().
> > >
> > > Instead, put the unshelved changes into refs/remotes/p4-unshelved/<N>.
> >
> > I am not a p4 user (and not a git-p4 user), so it is a bit hard for
> > me to assess if this is a backward incompatibile change and if so
> > how serious potential breakage to existing users would be.
>
> I don't think it's a particularly serious breakage - it reports the
> branch it unshelves to, so it should be fairly obvious.
>
> However, maybe it would make sense to pull this into a separate commit
> to make it more obvious? I should have thought of that before
> submitting.
>
> >
> > >
> > > -If the target branch in refs/remotes/p4/unshelved already exists, the old one will
> > > +If the target branch in refs/remotes/p4-unshelved already exists, the old one will
> > >  be renamed.
> > >
> > >  ----
> > >  $ git p4 sync
> > >  $ git p4 unshelve 12345
> > > -$ git show refs/remotes/p4/unshelved/12345
> > > +$ git show p4/unshelved/12345
> >
> > Isn't this "p4-unshelved/12345" now?
>
> Yes, I think another reason to pull into a separate commit.

D'oh. It's already in a separate commit.
I'll re-roll fixing that documentation.

I think it will be fine to change the branch that the unshelving
happens into - I think it's very unlikely anyone is basing some
automated scripts on this, because of the way that unshelving is used
anyway.

Luke
