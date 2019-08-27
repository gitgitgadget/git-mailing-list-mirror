Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D40A1F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 22:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfH0WSc (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 18:18:32 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45412 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfH0WSc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 18:18:32 -0400
Received: by mail-ua1-f65.google.com with SMTP id j6so149775uae.12
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oq2BR6sZrLFqxiZgcN7EPziwCpi7Xh/CHenOnmp3uVo=;
        b=WlgWQdevFceVKNzp42uwm0FvuZYQQmg9iiruCAKyZUeIwH3o9bMqIe060z7N5IaAma
         8pxmH0apHrXw9ud3+ViQa2eVV6F0MHCve/LtpChmWTl74YlgoqoYrAh00bbktzmz5mCK
         LE/R87enENztpmcuGalWtP1aW/LuXI/vOptLXzD1FBtHEygoikGD7xYk/YzvufCzGiOl
         m4G5GmOtfRnSfvwkyfnFneXe6Zr888+8yMshIL9+9sv9TVS5oELO9t7fU+9XE0PcO8RT
         tfCUAZoOvRUcdqUjBjcStCinG8FhL0QhyjwXhVusKQnPn1k0iHJPZw/7BMgVwDtq1cod
         n8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oq2BR6sZrLFqxiZgcN7EPziwCpi7Xh/CHenOnmp3uVo=;
        b=tu/3BchU6kgExnp05ybYSroF6R8mIRdaQnIqlqh6s6Mq5ZHBr+vZZ3elpUNasPB3RJ
         mQb9yJANDbmHlFO2NpOpi/nP6+xcixqSs37TXaKJvvCxNMp2p/IQKmwvEX/UuqqwrUNz
         84hryeg0snlgQ7eH/ubpkKIi+PhL/IzvkuJyKypwHu3mbeqqg89FAUazwWqbr0KpBIYM
         oUd/py26rNbI7w0iA7K9Rsd7XErl66nAFTSfIg5WzTd1SCRwEh1cSDyyXjVu/ib9dmtH
         VCF6EKzxWv50axg2a6n6KYGvKVpQexYWWgOUQeT67/x19vs8+qk/CiOO1+FxSujDdfpx
         y2Aw==
X-Gm-Message-State: APjAAAWNtCVyKEymHAIOGWNRpOc1hxuw+d15wBRgUaPHKH4reDVZkV3s
        rnQM/ccnoRRJFSnpeS0jxgCOZBl/pONacLCgw8g=
X-Google-Smtp-Source: APXvYqy5q2YI2sRtkOBrIF+dyHck9cYNdSxlq9r2/fayF7kluDC9LI8Ba4GAfps1CjnoNWdKe5alAYUiOGyIauxk7PE=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr315075uar.81.1566944310845;
 Tue, 27 Aug 2019 15:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com> <20190826235226.15386-1-newren@gmail.com>
 <20190827070324.7l2cpc3dlnithbm6@whir> <87v9ujc827.fsf@osv.gnss.ru>
In-Reply-To: <87v9ujc827.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 27 Aug 2019 15:18:19 -0700
Message-ID: <CABPp-BGfoRX-ob986kd-vvBo3meg-MpJ8Jo85G_2GgARY=cxxg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Remove git-filter-branch from git.git; host it elsewhere
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 1:43 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Eric Wong <e@80x24.org> writes:
>
>
> [...]
>
> > AFAIK, filter-branch is not causing support headaches for any
> > git developers today.  With so many commands in git, it's
> > unlikely newbies will ever get around to discover it :)
> > So I think think we should be in any rush to remove it.
>
> Nah, discovering it is simple. Just Google for "git change author". That
> eventually leads to a script that uses "git filter-branch --env-filter"
> to get the job done, and I'm afraid it is spread all over the world.
>
> See, e.g.:
>
> https://help.github.com/en/articles/changing-author-info

Side note: Is the goal to "fix names and email addresses in this
repository"?  If so, this guide fails: it doesn't update tagger names
or email addresses.  Indeed, filter-branch doesn't provide a way to do
that.  (Not to mention other problems like not updating references to
commit hashes in commit messages when it busy rewriting everything.)

> > But I agree that filter-branch isn't useful and certainly
> > shouldn't be encouraged/promoted.
>
> Well, is there more suitable way to change author for a (large) set of
> commits then?

I would say yes, use git filter-repo (note that this thread started
with me proposing filter-repo for inclusion in git.git -- and getting
suggestions that we should remove stuff instead of adding more stuff).
I'm biased, but I think it's much better at this particular job as
well:


You can create a mailmap file and pass it to the --mailmap option to
git-filter-repo.

Or, if you prefer (perhaps you don't like git's mailmap format as used
by shortlog and now log, or perhaps you really want to be able to do
regex replacement or something), you can use the --name-callback or
--email-callback to work on those fields more directly.

Or, if you prefer (e.g. you want to handle author vs. committer vs.
tagger differently), you can use the --commit-callback and
--tag-callback filters.


As an added bonus, filter-repo will also perform the rewrite far
faster than filter-branch (and rewrite commit hashes in commit
messages as alluded to above).

> > Yet there's probably still users which ARE happy with it, that
> > will never hit the edge cases and problems it poses; and will
> > never read release notes.  And said users are probably getting
> > git from a slow-moving distro, so it'd be a disservice to them
> > if they lost a tool they depend on without any warning.
>
> Personally, I'm far from happy with it, but I have no clue how to
> substitute it in the job above. Anybody?

The start of this thread where I proposed git filter-repo for
inclusion in git[1] had links to documentation and comparisons to
other tools and such.  You may find those links helpful; if not, let
me know what needs to be fixed in the documentation.

Elijah

[1] https://public-inbox.org/git/CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_9skA@mail.gmail.com/
