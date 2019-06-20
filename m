Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2FEE1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 10:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfFTK1B (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 06:27:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35972 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfFTK1B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 06:27:01 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so678703ioh.3
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yEDtmQg/PB1xFoSkN19Gx/57sNWM+PWYF9dQqgWXuWY=;
        b=Itdgm/6rwOg6Qm29rk7lgTExQhnnpExBUZGAA1uSytTbALGIAZSSHLRNHbekM3PD2B
         YxK89ZN2Z3nyvaLF5YPzgenFSrsqCvdkJpHv6XhbYoTlvtPkYi6WbCsGkteMTfSXvwfN
         hreV4gyCiz9sz17Pj14ySPTTEPwaP1dK60TCX/ZZyoppHsEuw5b13M9RXObC3n7bS1P7
         4Ri73Lsxd+R1FJRWLcpGvSldeyPjOrSEeF2gtEJAtPltvHTxef/AJVGQwKUAJNmnf0XU
         rx+LzUA1ugLIYm1ZXUwLjhTNZmz1bPyxVX3VAQkbtX/VtFuG5/0RXoBmbmGSVh4DkiTW
         JXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yEDtmQg/PB1xFoSkN19Gx/57sNWM+PWYF9dQqgWXuWY=;
        b=hD18xKz39n20OcWxB/J8kwSfG+uO0KwV3HCRe7qJFuIHsoGYaCU7vb383hjPtI2yOn
         3IkxYqjf6EfdXTiL1TMfD5OJbFXCFRfnl1Be5Ml9xsV506MBaMu5lxr6NqKkm1xo3/iy
         kOEp+ITNy3rfaBOGhh4Jj9oAjLxFtTMdVvVQfjT8GC4/7+N5K9JTokTOgEUnZNtzE0uC
         Bse7k2aVlMIe5rq7a5E7UwHiVEwEB0wKhJiwVYmIZ82viKxAw5aq/uOZEwr+cQfHasQ2
         /jcyXioMVqSs0ka8blwgt/KmdC4+yFSd3dbWBEC5BPvyBiQ9eSWK/X1sark4f8Exa8f+
         9KxA==
X-Gm-Message-State: APjAAAV9bVt5b0iHaYQCs4iaXOt4XvB9tegLirJuJg8QgEh/5QIYY3pA
        kwKIGyLMJJkLXq52nhuvH0OB3sFHsSO8ScjA9HQ=
X-Google-Smtp-Source: APXvYqzKiNux33bkiYXqCxpqcBc8VkR7uS7MHSkFQlLn6dh4WiGJWHnd+6/mvIo8aMvFPvhHA5P70BvfpsTY92Lig9k=
X-Received: by 2002:a5d:8890:: with SMTP id d16mr1136033ioo.274.1561026420815;
 Thu, 20 Jun 2019 03:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190619094630.32557-1-pclouds@gmail.com> <20190619102601.24913-1-avarab@gmail.com>
 <CACsJy8AqA3TmNP62ko4c5Et39jsADYf9nKQByz28y-YQjNyKag@mail.gmail.com>
 <87k1dh8ne4.fsf@evledraar.gmail.com> <20190619191037.GE28145@sigill.intra.peff.net>
 <87imt18a2r.fsf@evledraar.gmail.com>
In-Reply-To: <87imt18a2r.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 20 Jun 2019 17:26:34 +0700
Message-ID: <CACsJy8AjXXOpcKrSV4z6kEM=eyFDWSyf==tJZzvDyEN591XdGw@mail.gmail.com>
Subject: Re: [RFC/PATCH] gc: run more pre-detach operations under lock
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 5:49 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Jun 19 2019, Jeff King wrote:
>
> > On Wed, Jun 19, 2019 at 08:01:55PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> >
> >> > You could sort of avoid the problem here too with
> >> >
> >> > parallel 'git fetch --no-auto-gc {}' ::: $(git remote)
> >> > git gc --auto
> >> >
> >> > It's definitely simpler, but of course we have to manually add
> >> > --no-auto-gc in everywhere we need, so not quite as elegant.
> >> >
> >> > Actually you could already do that with 'git -c gc.auto=3Dfalse fetc=
h', I guess.
> >>
> >> The point of the 'parallel' example is to show disconnected git
> >> commands, think trying to run 'git' in a terminal while your editor
> >> asynchronously runs a polling 'fetch', or a server with multiple
> >> concurrent clients running 'gc --auto'.
> >>
> >> That's the question my RFC patch raises. As far as I can tell the
> >> approach in your patch is only needed because our locking for gc is
> >> buggy, rather than introduce the caveat that an fetch(N) operation won=
't
> >> do "gc" until it's finished (we may have hundreds, thousands of remote=
s,
> >> I use that for some more obscure use-cases) shouldn't we just fix the
> >> locking?
> >
> > I think there may be room for both approaches. Yours fixes the repeated
> > message in the more general case, but Duy's suggestion is the most
> > efficient thing.
> >
> > I agree that the "thousands of remotes" case means we might want to gc
> > in the interim. But we probably ought to do that deterministically
> > rather than hoping that the pattern of lock contention makes sense.
>
> We do it deterministically, when gc.auto thresholds et al are exceeded
> we kick one off without waiting for other stuff, if we can get the lock.
>
> I don't think this desire to just wait a bit until all the fetches are
> complete makes sense as a special-case.
>
> If, as you noted in <20190619190845.GD28145@sigill.intra.peff.net>, the
> desire is to reduce GC CPU use then you're better off just tweaking the
> limits upwards. Then you get that with everything, like when you run
> "commit" in a for-loop, not just this one special case of "fetch".
>
> We have existing potentially long-running operations like "fetch",
> "rebase" and "git svn fetch" that run "gc --auto" for their incremental
> steps, and that's a feature.

gc --auto is added at arbitrary points to help garbage collection. I
don't think it's ever intended to "do gc at this and that exact
moment", just "hey this command has taken a lot of time already (i.e.
no instant response needed) and it may have added a bit more garbage,
let's just check real quick".

> It keeps "gc --auto" dumb enough to avoid a pathological case where
> we'll have a ballooning objects dir because we figure we can run
> something "at the end", when "the end" could be hours away, and we're
> adding a new pack or hundreds of loose objects every second.

Are we optimizing for a rare (large scale) case? Such setup requires
tuning regardless to me.

> So I don't think Duy's patch is a good way to go.

This reminds me of being perfect is the enemy of the good. A normal
user has a couple remotes at most, finishing fast (enough) and in such
case it's a good idea to wait until everything is in before running
gc.

Of course making git-gc more robust wrt. parallel access is great, but
it's hard work. Dealing with locks is always tricky, especially when
new locks can come up any time.

Having said that, I don't mind if my patch gets dropped. It was just a
"hey that multiple gc output looks strange, hah the fix is quite
simple" moment for me.
--=20
Duy
