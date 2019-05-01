Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623A51F453
	for <e@80x24.org>; Wed,  1 May 2019 12:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfEAMcs (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 08:32:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38248 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfEAMcr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 08:32:47 -0400
Received: by mail-io1-f66.google.com with SMTP id y6so14695035ior.5
        for <git@vger.kernel.org>; Wed, 01 May 2019 05:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kO+nAkOpgNnDZWsJzIbcqL8N4m3feYMO7+JJTrU01xs=;
        b=Hb6rRUIZdAT0eXdUn/bgpTf8vPBCiy739PaEsx8XQZBI4vrSH2GKTFoZhgJBpKlIus
         DqdqvJxtJ+fsTtwladxK67k8A5yg+bHyMnPseFuhVP3Xh4673pRjWyFhQ/PLGHEK2exc
         cTkvgcp/0GWVHCWF4RvzjDLMh1ArYxWXCWjnBD1lXwbIfwTPLVr0QfDDfqxJdtbP67aO
         2XeubPdyD8vNQuxaKxKnNw1r7l6R0UuorUyENdPkmGLA6mZurAf61n0JHdd1iO9FwKjb
         tkq3IGKxwXOhAA/SEhGFgUEFQhFwwem/tgJdA40YVsecDiGe2XLRERwCXn0ZQ6yjuhCS
         MZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kO+nAkOpgNnDZWsJzIbcqL8N4m3feYMO7+JJTrU01xs=;
        b=Nrq7brd3FzfZwXfaHSD5f49252L/QqvVP6Fc/EXqHg7e0i8Wzj4V4OaZbjEpSX8aM+
         fWCSKRpuHH/D4M5Ry6bTbCGY2A4FFkr543h8ZwjBSsHr4R0LZUKZIme4Xg1WIebT0Je0
         j8z/Hk43nESK5zhk5Koqj0Ntq00u2xRlG07pFssQN6WIkAlkjElm5KqbnwSN+HskSYlE
         rPmllS7hFM/3jkOWwfmg9Fjs6yaEK6x9VsPzcjnVFpm5yPrE9uBdkEQnJY/Se7JUIE+P
         n1CLUPkaTKdJSa/PtHT2PFoPOQ5NsuaWjWCgGBgqcrWUxq6/0vg/MtuiUw9E+sKxZ87O
         CPiA==
X-Gm-Message-State: APjAAAVEvP30/EQqXUwctIJkkK6IP7IPdZ79qzVsOLux2cfPKwbw1uAd
        2sxPwb3UGnCPRbPHnHVLa842DX+yr/JEztq+jvQ=
X-Google-Smtp-Source: APXvYqzgiPLzSLSuJjFUGsgXAn8EOuhQ7q881M/r7wIsdnlwO4Y9TItFcL25xGR9f1eUde+2J5tn+YkqNc3XGC3nQG4=
X-Received: by 2002:a05:6602:58:: with SMTP id z24mr2685823ioz.118.1556713967069;
 Wed, 01 May 2019 05:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424023438.GE98980@google.com> <20190424230744.GL6316@genre.crustytoothpaste.net>
 <87k1fis8gq.fsf@evledraar.gmail.com> <20190425143614.GA91608@google.com>
 <CACsJy8B5j2K=RU7N+h-i9HszuYuYd+fNmAftVDW-4nJ_o5z8Sw@mail.gmail.com>
 <20190430211415.GB16290@sigill.intra.peff.net> <CACsJy8B+hDqKnu+0tkPC42w+_6RhzYac1BxYtdyxctcARG=VCg@mail.gmail.com>
 <87r29iqsf9.fsf@evledraar.gmail.com>
In-Reply-To: <87r29iqsf9.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 May 2019 19:32:20 +0700
Message-ID: <CACsJy8CSPBbxrJm1sh4a+f_B03MFXxDXSrOvb6yFCRa4Qa2wMQ@mail.gmail.com>
Subject: Re: How to undo previously set configuration? (again)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 1, 2019 at 7:18 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Wed, May 01 2019, Duy Nguyen wrote:
>
> > On Wed, May 1, 2019 at 4:14 AM Jeff King <peff@peff.net> wrote:
> >> It's definitely not implemented universally; each consumer of the conf=
ig
> >> option must decide on it (and it will probably always be that way to
> >> some degree, since we don't know the semantics of each options; recall
> >> that we may be holding config keys for other non-core programs, too).
> >> And we just haven't retro-fitted a lot of those older options because
> >> nobody has been bothered by it.
> >>
> >> That said, I am a proponent of having some kind of clearing mechanism
> >> (and I was the one who added credential.helper's mechanism, which has
> >> been mentioned in this thread).  I think it makes things a lot less
> >> difficult if we don't have to change the syntax of the config files to
> >> do it. With that constraint, that pretty much leaves:
> >>
> >>   1. Some sentinel value like the empty string. That one _probably_
> >>      works in most cases, but there may be lists which want to represe=
nt
> >>      the empty value. There could be other sentinel values (e.g.,
> >>      "CLEAR") which are simply unlikely to be used as real values.
> >>
> >>   2. The boolean syntax (i.e., "[foo]bar" with no equals) is almost
> >>      always bogus for a list. So that can work as a sentinel that is
> >>      OK syntactically.
> >
> > Another question about the universal clearing mechanism, how does "git
> > config" fit into this? It would be great if the user can actually see
> > the same thing a git command sees to troubleshoot. Option 1 leaves the
> > interpretation/guessing to the user, "git config" simply gives the raw
> > input list before "clear" is processed. Option 2, "git config"
> > probably can be taught to optionally clear when it sees the boolean
> > syntax.
>
> We can make it fancier, but we already deal with this, e.g. if you do
> "git config -l" we'll show "include{,if}" directives at the same "level"
> as other "normal" keys.
>
> We also provide no way in "git config" to properly interpret a
> value. E.g. does a "user.email" showing up twice for me mean I have two
> E-Mails at the same time, or does the last one win?

Actually --get knows this. Single-valued options can be handled
correctly quite easily. It's --get-all (or rather, the future
--get-multi because we can't change --get-all's behavior) which can't
interpret values because there's no standardized way of doing it.

> We both know the
> answer, but git-config itself doesn't, and that information lives in
> docs/code outside of it.
>
> Similarly we'd just print a sequence of:
>
>     user.name=3Dfoo
>     user.email=3Dbar
>     exclude.key=3Duser.*
>     user.name=3Dbaz
>
> And it would be up to some "smarter" reader of the config data to
> realize that the end result is one where we have no "user.email" set,
> and "user.name=3Dbaz".
>
> But yeah, optionally having some new --list-normalized or
> --list-after-excludes or whatever would be great, and presumably not
> hard if we had some central "excludes" mechanism...
--=20
Duy
