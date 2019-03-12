Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C9320248
	for <e@80x24.org>; Tue, 12 Mar 2019 18:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfCLSYu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 14:24:50 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37217 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfCLSYu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 14:24:50 -0400
Received: by mail-vs1-f68.google.com with SMTP id y19so2220035vsc.4
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StkD33izGddnQ8yd5+eEnDC+cvfEzR0cEZ6VR8i6JFc=;
        b=WiRM2zaTc5f5zB8mj6GkQ2Dwg4MLNbagxKwb9u1GR7mJNBglgoHO5Iv43WgpBJZ/s7
         AF8I6ZluFZrErrXvV8M3YUYWlx2ZpWRMp7TP5IQYP4ThFwLp2fAOn9gtZbP0kXsgz+YE
         9LWzEvHjqCl7izS/6W56rO67VHcCDoaRexWnAVAQFw1bGu4A/xoawMOFp/DDqP/mVoDD
         K3sNT4Z8MvmnIZywpSLFlzLe/pjFYXGDLc3zshVVGcy3kjet0QxYD5qr2D8DsPK6RoZq
         I/98Cf/9iNr3LoanVJQFKxlGZedTPnbXc9OqJV51jjlRxeEjNYybVqfZwt6jGpuoRbwp
         4Erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StkD33izGddnQ8yd5+eEnDC+cvfEzR0cEZ6VR8i6JFc=;
        b=Dmw0kARDERxDv+4px5lhARFow31ccyJu+o9JcZmSK6cGlA81JzQ1+dL9E7LESYrCiE
         Mt+6qjEQdY8G5J9EOKutqsP01RTF3TvehGhUCG1W+cg2n+OD57Gb8xFaiLgugr/25/HA
         jnDCxpbzzyEqDpnnUn2FJNKYHJJ27ajPT2qiYIIP1hJ+5y2DevJXoLE6GZQ5R/9jAogF
         UKYah0ox1pxGA7XHgJF0P7TbVLfxUEsnIBczUNaDc4CLNhzWWyxlNjLUuYRwFquLJGt7
         pD3kSjQ0ELMB1Tjj+WgyZU7/dX8uDp3eSVYpn/7fwMKKoCL8wdymE1KOCpI/rF9eUYGI
         KHOg==
X-Gm-Message-State: APjAAAWQStX1t4JqIOhZjD16f4nYNcNFpRy/V+doiPN4e6XA8zKAZN4I
        eG1jv/eTt64GoQMV1d4YdeAZNnnGI2dC4TqYaTlFxQ==
X-Google-Smtp-Source: APXvYqwCcSZYlzitvRn0HXnRY10HwixAgOq6tz0eiOa/6qUJGnUCagDQ6uiA2jPGI3v6jRvOgM3c9OeuIY0UAamSzhc=
X-Received: by 2002:a67:fa46:: with SMTP id j6mr21025389vsq.117.1552415089253;
 Tue, 12 Mar 2019 11:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1903121317020.16391@localhost.localdomain>
 <20190312181428.GA6993@alpha> <alpine.LFD.2.21.1903121419070.18042@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1903121419070.18042@localhost.localdomain>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 Mar 2019 11:24:38 -0700
Message-ID: <CABPp-BHV9+7+3si8NOA0ouYZ_Zyo5yMqMbSggwoYmRLK-kB_dA@mail.gmail.com>
Subject: Re: why does "git revert" commit even if i try to bail with ":q!"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Kevin Daudt <me@ikke.info>, Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 11:21 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> On Tue, 12 Mar 2019, Kevin Daudt wrote:
>
> ... snip ...
>
> > The only reason why `:q!` works just for comitting is because there
> > is no default message, so the final message ends up empty.
> >
> > When you do things like git revert or git commit --amend, there is
> > already a commit message, which you are then editing. When you quit
> > without saving, the existing message remains and git uses that.
> >
> > vim has a command to let it exit with an error return code: `:cq`.
> > This makes git something went wrong with editing the message,
> > causing git to abort the commit.
>
>   ah, i'm starting to get it. predictably, i think this needs to be
> mentioned in a man page. :-) thanks muchly for clearing that up.

If you do fix up some manpage, note that this affects e.g. commit
--amend too as pointed out by Kevin (and maybe also the 'reword'
option of git-rebase?) -- anything that starts with .git/COMMIT_MSG
being non-empty.
