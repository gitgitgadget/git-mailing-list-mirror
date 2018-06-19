Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8011F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966930AbeFSQMa (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:12:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41758 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967044AbeFSQMT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:12:19 -0400
Received: by mail-oi0-f66.google.com with SMTP id a141-v6so217508oii.8
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 09:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBx3AjO2mADeZzkF0MRfkpimI0yMv3Ve7jSxZd6Wdq0=;
        b=eCE0KMyiwPmokq2ARjUt1y/EKzTDVJblnJ2FhJjss6MgN7ZlpxaY469NrWcAHYQ5vi
         GgupW4QIupXhj7wMq8920yf8bQAGX1n6Lnc2lXRAxZjEMU2goCB+2iRFsPAvdCdrDWWk
         nYlh4bmZi/DwfuNUp5APJ905OZC9ZQ7hMSTu4VvFM0b3C6rhkN9UdamBVl/ntYPtVEhZ
         JCWUPHYGFuyFy+BbSt7gb8FkM8fk2DftgWvQFHBGjm4pKoM+ZQJMmBWsXATzUyP3rqIR
         0wpf/9Nc3Omv4CqP8pjEVAo0sDTjQXTJBk8N6RB69As/wg49ZrsQyOV3GIneIKywG8X5
         eqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBx3AjO2mADeZzkF0MRfkpimI0yMv3Ve7jSxZd6Wdq0=;
        b=ECd+avvK1pub2asL/DW25cB7uBtP5aM1sMDxtLBQyDmNzLSKltIychkvbBnB525FTq
         0nNtR050WkD6FLq71FIqOPwtONiT4oOeFIM/0zOEY5A8gbBtAXOhgEbSSz1XaubSrBHX
         J27coS9oH0wiTfU/XrAqfFlha7mE2Ze7UdeP+TakjXH2IWAPMjFLUghfj1z5L46zemir
         /egWSiP6I9QscbqVlWV5FVQiys2g9ghsjhgWbGY38rG7nu9AKaXToVcLNKhZsULWnNYf
         U2nikjNoq6TNmYPtsOf+MkVHi1iISXXgerbqzPS4ZZOytaf4jDBnMPjg6srW1807HIfj
         PkTA==
X-Gm-Message-State: APt69E39kqyVo6WV8lYA9YVvsF1aCuYBmmX/fqBkr86nhggdedKeGdDP
        lRfQ9eMX8rhx9u51Gn4JdQQGWa+0FlPzXl1cETk=
X-Google-Smtp-Source: ADUXVKIfxtJuAaMbDFFk2QoN3El1d45c8Us3L/jVhiU3UK3Sye702DbURB6zx6t06MVTWvrOJSsYfbwEEqXtPfcprL8=
X-Received: by 2002:aca:fcc8:: with SMTP id a191-v6mr10323891oii.34.1529424739251;
 Tue, 19 Jun 2018 09:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180618111919.GA10085@book.hvoigt.net> <CACsJy8CJGditaq4CZfJctVAe9QCdapWQW=W--AumH-4RWWd=vA@mail.gmail.com>
 <20180618181215.GB73085@google.com> <20180619103632.GC10085@book.hvoigt.net>
 <CACsJy8DQ-GGEDiV0iA2kTgNgHcT1sSX2Oqb7VZcjyK1nBOFv+A@mail.gmail.com> <xmqqmuvqwz07.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuvqwz07.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 19 Jun 2018 18:11:53 +0200
Message-ID: <CACsJy8CVUzFDU+4xf+bZW63F=hX5EmAbW+LvqW737AGTLbUj7g@mail.gmail.com>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 5:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Tue, Jun 19, 2018 at 12:36 PM Heiko Voigt <hvoigt@hvoigt.net> wrote:
> >>
> >> On Mon, Jun 18, 2018 at 11:12:15AM -0700, Brandon Williams wrote:
> >> > On 06/18, Duy Nguyen wrote:
> >> > > This sounds like the submodule specific code in pathspec.c, which has
> >> > > been replaced with something else in bw/pathspec-sans-the-index. If
> >> > > you have time, try a version without those changes (e.g. v2.13 or
> >> > > before) to see if it's a possible culprit.
> >> >
> >> > I just tested this with v2.13 and saw the same issue.  I don't actually
> >> > think this ever worked in the way you want it to Heiko.  Maybe git add
> >> > needs to be taught to be more intelligent when trying to add a submodule
> >> > which doesn't exist in the index.
> >>
> >> That was also my guess, since my feeling is that this is a quite rare
> >> use case. Adding submodules alone is not a daily thing, let alone
> >> selecting different changes after 'git submodule add'.
> >>
> >> I also think git could be more intelligent here.
> >
> > Ah.. the "submodule not registered in index" case. I think I remember
> > this (because I remember complaining about it once or two times).
> > Definitely agreed that git-add should do the right thing here.
>
> I am not sure if this even needs to be implemented as "look for the
> submodule in the index".  Even before submodule was added, we knew
> that "git add foo/bar" should reject the request if we find foo is a
> symbolic link, and we should do the same when foo/ is a directory
> that is the top of a working tree under control of another
> repository, no?

Exactly. I started with the intention to do something related to the
index only to slowly realize that it was not the right place. We
traverse directories and stop looking inside a symlink, we can do the
same if we realize it's a submodule.
-- 
Duy
