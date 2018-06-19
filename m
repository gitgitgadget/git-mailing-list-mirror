Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B58A1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 15:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937538AbeFSPQp (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 11:16:45 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41347 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966330AbeFSPQo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 11:16:44 -0400
Received: by mail-ot0-f194.google.com with SMTP id d19-v6so50347oti.8
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cd9dZc94SGbfUhMNAgC3+j79ybtJYfs1lDGPMVDNW0Y=;
        b=vcx+riBtBxvqsd2l88HCQfRJR38V71ELNptBZKmkja0PAl/4yVO8n/38FCk23j5Wfz
         q4GaqStqi1RnrMkwHsab14c8S1tbfqbvcSzF3mYkeqjlytdzr+dNLATCmPf3m1o2bwFZ
         68PX/2SBrRKtrZORfxJfj7InAWhTMwLMq6veR80CjfIBXkvapnlsGOCNQ9FebYHGvi90
         ppj0UqOakmp4Uaxbg3a8cyyZjXhe3xEpm/BZAxnRNse/n93cV29T1QzgT1mroSwonMLo
         VfK6uIEuX3CEmULYbwvh+j2dw3rEJpukRG1l/aS+iVKSAmHvYvowgsblN4NNdrRjGJSf
         6aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cd9dZc94SGbfUhMNAgC3+j79ybtJYfs1lDGPMVDNW0Y=;
        b=FP/4f4s2MT7CF3XpP0aC5JL3MXbYl1V47UBmKjfc/4Fj4djkRyWv0lzR0TAJD3PLx/
         4UgAJ80FUcjP1v112pCnce2kOk+CSmegqROeTIdUh0Hgj5bNSKJEOEh0SaeJb1M+DHvk
         CW1H4ZSf0xJY4GcZqcQblgqqxvl/DNkGcVl3HdSbGKZu5SbIVswAI5bowp3rz3N+PdXD
         Xg7wOK+HGZYXuqKNDI/ROo3NdJvOJlSHL9Zjq09YVSVjoFAdsE9mioMFUfhLnH2F4Ipr
         VMLzVKyzSbFh62XwSXGzcTywJqJAoHm8PFu85yoxpiRcYgcfuvTw8UAgzHuJKZUCQ2/r
         kcvg==
X-Gm-Message-State: APt69E0Njx/GCzWMjnVcFQyha68xwTFXQaXqPbPpejNMi34VLzrelYkt
        CgH2XmHK0kbE86DrsZdRIXq+rrohxNjMixpLK5I=
X-Google-Smtp-Source: ADUXVKLNcIM/84PXAvvFn2Ip9JZVjcGhTUe/fb0YW8FotJewRxsa4Dbpiz5FjNKfqzBuqEaUqFZJEZw4zFiI6dnRum0=
X-Received: by 2002:a9d:2c94:: with SMTP id p20-v6mr11460262otb.14.1529421404056;
 Tue, 19 Jun 2018 08:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180618111919.GA10085@book.hvoigt.net> <CACsJy8CJGditaq4CZfJctVAe9QCdapWQW=W--AumH-4RWWd=vA@mail.gmail.com>
 <20180618181215.GB73085@google.com> <20180619103632.GC10085@book.hvoigt.net>
In-Reply-To: <20180619103632.GC10085@book.hvoigt.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 19 Jun 2018 17:16:17 +0200
Message-ID: <CACsJy8DQ-GGEDiV0iA2kTgNgHcT1sSX2Oqb7VZcjyK1nBOFv+A@mail.gmail.com>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 12:36 PM Heiko Voigt <hvoigt@hvoigt.net> wrote:
>
> On Mon, Jun 18, 2018 at 11:12:15AM -0700, Brandon Williams wrote:
> > On 06/18, Duy Nguyen wrote:
> > > This sounds like the submodule specific code in pathspec.c, which has
> > > been replaced with something else in bw/pathspec-sans-the-index. If
> > > you have time, try a version without those changes (e.g. v2.13 or
> > > before) to see if it's a possible culprit.
> >
> > I just tested this with v2.13 and saw the same issue.  I don't actually
> > think this ever worked in the way you want it to Heiko.  Maybe git add
> > needs to be taught to be more intelligent when trying to add a submodule
> > which doesn't exist in the index.
>
> That was also my guess, since my feeling is that this is a quite rare
> use case. Adding submodules alone is not a daily thing, let alone
> selecting different changes after 'git submodule add'.
>
> I also think git could be more intelligent here.

Ah.. the "submodule not registered in index" case. I think I remember
this (because I remember complaining about it once or two times).
Definitely agreed that git-add should do the right thing here.

Brandon already moved the submodule check outside pathspec code
(wonderful!) so adding more checks based on worktree state should not
be a big work. I think the only concern here is catching submodule
locations so we don't check submodule at the same location multiple
times.

No actually, we could do better. Let me see if I can come up with a
patch or something...
-- 
Duy
