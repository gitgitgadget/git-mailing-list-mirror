Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEE471F453
	for <e@80x24.org>; Wed, 26 Sep 2018 23:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeI0Fg6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 01:36:58 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35833 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0Fg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 01:36:58 -0400
Received: by mail-yw1-f67.google.com with SMTP id y76-v6so326463ywd.2
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 16:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8MF6JlbhKiDEcauT6wmij7iYnOoLi7xyslJ73Ya6vJY=;
        b=adB//Sdy3JS92ing1Jk6Ol9Ixc5QiIzvpcm2AHuSOBzOAMjCsfo+pCZOgIWLOIek2w
         dItZy6a1GLGyg+h6rMLBIPW8vs7ozXOma2xy08whkRAauzJ9HD2c9sT87d0EnxS+0p//
         ZvKDfVlhyca2bcRh9fMj9adFPT10/rCQc3OiwkoVI8tvONxi5o7HVVSPOrMK7s4FCnm4
         EsHIsAslOeoM0a1bR1GdYOWl3yPpTAb0R+86RrOZvxws/A8G/5rW1D1aQgMP1EIZY2av
         itBaQBTq/AknZ5KOdwevjod5RnCc9g6dYRZmPVrenCo7f18qZyBy85obD318ijclJ3ot
         pLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8MF6JlbhKiDEcauT6wmij7iYnOoLi7xyslJ73Ya6vJY=;
        b=FE+WKo0J+6OD4VF8Pk/k58DvP5oM0xh2NIMrhge4qQmLnrBG45QiygBx3TzDnQh3Xp
         e+JoOd2BfaByvSt3i3X9inKIjEsTdrumaP/Gxm8NOLZ1RXSt47HVr2A0t/WruLqMif3u
         GqSYtO1Oohcz6/GZHxGEjJQ3DpPmiuKkTTxvHMfYC90aMrArfFi8illcmJcmNlJq6PTT
         7tw9nUZXVhLNZPRSo6/txpI40RP8Eq82jelhwieX/qXAmCppDY4eiPiHZmbd2jd1rIZZ
         mXCVfYgnW+Uiig6ODhgz5JdlCWQmv6Nqb88Negv/3YhAg9pcf2HoZqs/vQxtD9xydInT
         RXUQ==
X-Gm-Message-State: ABuFfoiLJSQhErj+rq1AtMau/5nSGqEpmcmNAP6cYJ2/4nUCj3zodcs3
        SF8Xzq+k0TmBhg9ok/zQHrVj0HBqskLI91dL0h86PQ==
X-Google-Smtp-Source: ACcGV61IKdqUk+/1kOvOFmyqfNXMpX26QZCTJuppcUXNqhhOJf4N0423j8z454W5hnxievjz7KguB5nJONDELxIzZQs=
X-Received: by 2002:a81:5710:: with SMTP id l16-v6mr4349649ywb.3.1538004099222;
 Wed, 26 Sep 2018 16:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com> <20180921223558.65055-2-sbeller@google.com>
 <87h8ihk7sl.fsf@evledraar.gmail.com> <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
 <20180926041517.GA2140@sigill.intra.peff.net> <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
 <87d0t0jghm.fsf@evledraar.gmail.com> <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
 <87a7o4je0t.fsf@evledraar.gmail.com> <20180926185812.GD30680@sigill.intra.peff.net>
 <878t3oj8em.fsf@evledraar.gmail.com>
In-Reply-To: <878t3oj8em.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Sep 2018 16:21:28 -0700
Message-ID: <CAGZ79kZOZL24Q=L-XkdrKRMjNg=dynQ+67qyD+iceg7GLru3yw@mail.gmail.com>
Subject: Re: On shipping more of our technical docs as manpages
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 1:44 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> > And if we were going to generate something external, would it make more
> > sense to write in a structured format like doxygen? I am not a big fan
> > of it myself, but at least from there you can generate a more richly
> > interconnected set of documentation.
>
> It's useful to have a single authoritative source for all documentation
> that's easy to search through.

If that is the case I would propose to keep it all in header files and
organize the headers.

> That includes stuff like perl585delta(1) which we'd stick in
> Documentation/RelNotes, and "Internals and C Language Interface". Most
> of what we'd put in Documentation/technical/api-* & headers is in
> perlapi(1).

This seems cool, but was also a recent introduction?
perl400delta seems to yield nothing for me (which may be because
I do not have an old version of perl installed?)

>
> Sometimes it's obvious where to look, but as someone who uses most of
> these APIs very occasionally (because I contribute less) I keep
> (re-)discovering various internal APIs.

Sometimes I have the same feeling. Maybe more structure in the
source files would help (e.g. datastructures/{strbuf, string-list}.h
and objects/{packfile.h, sha1*} ?

> Every perl installation also ships perlapi and a MB or so of obscure
> internal docs to everyone, which makes it easier to find via Google et
> al, which I find useful. So I guess I'm more on the side fence of
> dropping a hypothetical gitapi-oid-array into /usr/share/man than you
> are.
>

Personally I would not want to ship our internal docs everywhere
as it seems like overly wasteful. But then, only my early days
of childhood were guided by Internet that is not available anywhere
and everywhere. Today I would just take for granted that I can lookup
things in github/git/git when I am in not at my regular desk.

> ANYWAY
>
> This E-mail is much longer than I intended, sorry about that. I didn't
> just mean to bitch about how we ship docs, but I was wondering if there
> was a desire to move to something like what I've outlined above, or
> whether the status quo was mostly by design and intended.
>
> I just thought I'd write this rather lengthy E-Mails because this is one
> of the rare areas where you can fully describe an idea in E-Mail without
> writing any patches.
>
> If the consensus is that something like the exhaustive index "perldoc
> perl" provides wouldn't be useful for git I can just drop this, but if
> people are enthusiastic about having that it would be useful to work on
> it...

I agree with Junio, as that the discoverability is unrelated to where to st=
ore
the actual docs, Documentation/technical/* has the advantage that it
only has "good" stuff, i.e. some topic that someone cared enough to
write about and it is easy to guess if it is relevant to your need.
In *.h, we have a lot of false positives (xdiff-interface.h or cache.h
just pollute the searching space when looking for suitable storage
classes.)

So I wonder if we'd want to have a list (similar as in
command-list.txt) that describes the header files and gives
some classification of them, for example one class could be the
data structures (strbuf, stringlist, hashmap), algorithms
(diff, range-diff), OS specific stuff (run-command, trace, alloc)
or Git specific things (apply, fetch, submodule)
