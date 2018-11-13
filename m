Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA931F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 23:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbeKNJ0B (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 04:26:01 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:38110 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeKNJ0A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 04:26:00 -0500
Received: by mail-vk1-f193.google.com with SMTP id w72so3228373vkd.5
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 15:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZQslhqNPHc/FyYVO8IoMD34CljMerTvl+2XKK+gcyo=;
        b=VCzPtW9EeHIAY9C+rEoWiN0iCatrLyX3aL+d5yAuJ21kwGJrwPONaIWI7CuXt88cDI
         2KOJU3Q40j+km5j/okvzhg0YoyFe7JD4KiD2LcDCUCBayk56fk2Ds1FtRRbK4iMUnTJD
         Mckk5I44/Dxlu/q+U7ia/YX16DWn1PtGJmwLDOMBkWDIJpRVgDlZORiZMsw18mXSewKp
         Fga67bivy3CmqQQ76blSHrMlNepk1WsQNLzghI6YqUDqXmmP8VSyPIUv4QqN4hhHe0Qw
         fZE+otBdc55o0pUmHykZexihj6xSxC/4mKwUM+tazpuivV92NfdBIEcwv37IWTeXyTTH
         qJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZQslhqNPHc/FyYVO8IoMD34CljMerTvl+2XKK+gcyo=;
        b=k5wZ8qXBIAzHFsdXnX/UTFbIc680Yv8aPVtmB3CbkvQ3613+08/YD3/X2tC953N4bY
         eUeBRfoSSb5CiSXwReUhDddavEqQWAC8tji6D/dyEXkMTDELFNd1Calh5qHUPEBN0UC2
         N9gXN23DeWe55Z4bk1xflIi2fCaZCMRkEKi8BcWOP7/xKQ76CnTUyEGsdI78KFLR9BfS
         yt/GKJa17QWS8qXx7yw7mpRO06s7NsXW+pFcMNlKIjF3ENbkU9MrefqaNGKGRc7IXLvk
         BckcI64Lqgoys8/hs63/bBpApVHa6Pqpuy0UweFtW9beUlEfytPl3moJXl4JzRlN23Ri
         gyIA==
X-Gm-Message-State: AGRZ1gKiu5H1PU2IXCcSm876aWISBJcxoh/+y4Z0NrgrHpfYTou1QgIM
        pHnDpEGwinzhsvPrnZPbr4b3C5p6/rlS/sXI4pw=
X-Google-Smtp-Source: AJdET5dWfUjvOFr6DFvE+pcSzORzx59T2woIUQhciVJxjZ+9t7pRYAEA+BWT+KI3vg6jP9ORJt6AbLXP3s8+OPu7PrA=
X-Received: by 2002:a1f:97d1:: with SMTP id z200mr3244690vkd.15.1542151526919;
 Tue, 13 Nov 2018 15:25:26 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-3-newren@gmail.com>
 <20181111063601.GB30850@sigill.intra.peff.net> <CABPp-BHwg2U=b+UGK2SufB7uZPmmiPVKXoTpYt+LuHnLwmwuZQ@mail.gmail.com>
In-Reply-To: <CABPp-BHwg2U=b+UGK2SufB7uZPmmiPVKXoTpYt+LuHnLwmwuZQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Nov 2018 15:25:14 -0800
Message-ID: <CABPp-BFo=UvwbqV06R9PVEJ6JyEsvUCr4pe+3eQw8D2W96D96w@mail.gmail.com>
Subject: Re: [PATCH 02/10] git-fast-export.txt: clarify misleading
 documentation about rev-list args
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 11:17 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Sat, Nov 10, 2018 at 10:36 PM Jeff King <peff@peff.net> wrote:
> >
> > On Sat, Nov 10, 2018 at 10:23:04PM -0800, Elijah Newren wrote:
> >
> > > Signed-off-by: Elijah Newren <newren@gmail.com>
> > > ---
> > >  Documentation/git-fast-export.txt | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> > > index ce954be532..677510b7f7 100644
> > > --- a/Documentation/git-fast-export.txt
> > > +++ b/Documentation/git-fast-export.txt
> > > @@ -119,7 +119,8 @@ marks the same across runs.
> > >       'git rev-list', that specifies the specific objects and references
> > >       to export.  For example, `master~10..master` causes the
> > >       current master reference to be exported along with all objects
> > > -     added since its 10th ancestor commit.
> > > +     added since its 10th ancestor commit and all files common to
> > > +     master\~9 and master~10.
> >
> > Do you need to backslash the second tilde?  Maybe `master~9` and
> > `master~10` instead of escaping?
>
> Oops, yeah, that needs to be consistent.

Actually, no, it actually needs to be inconsistent.

Different Input Choices (neither backslashed, both backslashed, then just one):
  master~9 and master~10
  master\~9 and master\~10
  master\~9 and master~10

What the outputs look like:
  master9 and master10
  master~9 and master\~10
  master~9 and master~10

I have no idea why asciidoc behaves this way, but it appears my
backslash escaping of just one of the two was necessary.
