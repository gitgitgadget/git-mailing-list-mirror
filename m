Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 762A520954
	for <e@80x24.org>; Mon, 27 Nov 2017 08:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbdK0IYu (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 03:24:50 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:35391 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdK0IYt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 03:24:49 -0500
Received: by mail-it0-f41.google.com with SMTP id x28so4739577ita.0
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 00:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZYqHxqFyObJOmsM74HYdFVqAXvvGagGzsJnlEFJAGZc=;
        b=YfDxiL0Edj2DhuT1cI8Mj4828Fcc3Q+fV22gww9JrcK2J+f+6jhz9SEaN7J+9eiO8S
         oluFf8F0ZjMydF0HP8g0RgoZr5LbTDw8vU8nrrjxDmGO7AG/hc5bT01y3VxfsqskcGgw
         2yhv+gUnWYbFc9e9r/EO61SogGIdhM7WSKxoNyxUafIcBBFso38fXgznuSJiuXNCBEtY
         5dp3MI8H4EZM+sTeX38dGEr+EL9zizgU21LUrsznQfomjgwJ5rFbEK+XdtlnglxWgiMV
         IARXX/4PSsbzcnY2T9fgX3qeDoj6XC5614eDDLq9TcIwvMRTQfbcdiOd2xNzTJmnKPum
         /uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZYqHxqFyObJOmsM74HYdFVqAXvvGagGzsJnlEFJAGZc=;
        b=qV6M9QVYtN09K1E17tZ6HWkCHZVTvcMcqlfPXmBfr+Gzrq2cbqc3I2htdujzIiw2qO
         FIuMI7GRoFceYuflF35MShHXq9hTrPrIYWD8OpToS3QEJukooLPuOVgekOeBY5no8vVN
         43YC0yNi2pKIun77ayGBo8pDcxGQ14eDudn4xasaHjnozheUPnMfDPjHhR9RlSIN+J+d
         h27H1Fiz1Z/h5Bda26Ag1OYhOTEAZ8pL0ufaswEV8tAuVTlCcK8J/f5jkb+T90egLoDb
         GDujnTayV9eS7q8zE1tVpXRIw3fnc2nNeFCsMQvvFtDGaC4Gr9L9FF5LRIoJgyADyfaP
         +TjA==
X-Gm-Message-State: AJaThX7avsp93t+s+lgiGt1XEUWPeyWcSjvlsUB6z6hqxnSSRBOiGGPS
        Vz3THmU8rnYO91Wvi5g1gI/AT85I6BMQS/pmB6UuQBKv
X-Google-Smtp-Source: AGs4zMam8mocUrxX2zrFGFV9JWsltLyNv7YLHfPdyZk8yCeWx5hSwYGMc9GTre1W+GUn7NpNV/6SvZ8hAUWGrVtNdpc=
X-Received: by 10.36.0.209 with SMTP id 200mr27233085ita.55.1511771088063;
 Mon, 27 Nov 2017 00:24:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Mon, 27 Nov 2017 00:24:47 -0800 (PST)
In-Reply-To: <20171127043502.GA5946@sigill>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
 <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
 <CAP8UFD0d9zM9F3tLrTMiLdfoJQsOPELtmudVB6e83DiLPN5DEA@mail.gmail.com>
 <20171126191510.GA1501@sigill> <xmqqy3msfrr1.fsf@gitster.mtv.corp.google.com>
 <xmqqshd0e41a.fsf@gitster.mtv.corp.google.com> <20171127043502.GA5946@sigill>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 27 Nov 2017 09:24:47 +0100
Message-ID: <CAP8UFD2tB_CpopP5OuqPSBfeeGzXfoC_Hz-UeT=eNW1fU6zyzA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 5:35 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 27, 2017 at 01:31:13PM +0900, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > Perhaps the "else" part of the above should become a bit more
>> > careful, something along the lines of...
>> >
>> >     else
>> >             MSGFMT ?= msgfmt
>> > -           ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $$?),0)
>> > -                   MSGFMT := $(TCL_PATH) po/po2msg.sh
>> > -           endif
>> > +           MSGFMT_DRYRUN = --tcl -l C -d . /dev/null 2>/dev/null
>> > +            ifneq ($(shell $(MSGFMT) $(MSGFMT_DRYRUN); echo $$?),0)
>> > +               ifneq ($(shell $(TCL_PATH) po/po2msg.sh $(MSGFMT_DRYRUN); echo $$?),0)
>> > +                    MSGFMT := $(TCL_PATH) po/po2msg.sh
>> > +               else
>> > +                   $(error "no usable msgfmt to build gitk; set NO_TCLTK perhaps?")
>> > +               endif
>> >             endif
>> >     endif
>>
>> Actually, at this point, I think the suggestion should primarily be
>> to install either msgfmt or tclsh; offering another choice to set
>> NO_TCLTK is OK, but it should be secondary, as the fact that the
>> make utility is running this recipe is a sign that the builder wants
>> to build gitk/git-gui.

What if the user actually don't care about internationalization?

The problem is that inside git-gui, the option to disable msgfmt is
NO_MSGFMT, while in the git repo it is NO_GETTEXT, so if we make this
change in git-gui, we should suggest using NO_MSGFMT to disable
msgfmt. But then the user building git and setting NO_MSGFMT will get
another msgfmt related error later in the git build (as NO_MSGFMT will
have no effect in the git build) and will not understand at all why
there is still a msgfmt error despite setting NO_MSGFMT as the build
suggested.

> I think that's the rub, though. We hit this code path by default, so
> it's _not_ a sign that the builder cares about gitk.

Yeah, I agree. That's why I think it is a good idea if Tcl/Tk is not
installed to ask for either setting NO_TCLTK or installing Tcl/Tk or
setting BYPASS_TCLTK_CHECK.

> I do agree that outlining "install one of these or disable tcl" as the
> options is a good idea, though.

The problem is that we should suggest disabling msgfmt as it is a
valid solution, but as explained above there is an issue related to
NO_MSGFMT in git-gui vs NO_GETTEXT in git.

That's also one of the reason why I don't want to mix the Tcl/Tk issue
and the msgfmt issue. In the end I think we should fix both, but if it
is not possible to fix the simpler Tcl/Tk issue first, it's not even
worth spending time to take a deep look at the msgfmt issue.

>> Whether the builder wants to run the result on the same box is a
>> separate and irrelevant matter.  Once built and installed, a box
>> without "wish" may not be able to run the result, but installing it
>> after the fact will fix it without need to rebuild anything.

Yeah, people have not complained about that and it is not a really bad
situation, but I don't think this is the best practice nor the best we
can do, and I think the situation in this regard is better after my
patch.

For example if someone builds a box that should be used afterwards in
an internal network where this no way to install Tcl/Tk, then users
will be screwed when they will try to run gitk or git-gui. The same
thing can happen if someone installs git just before a long plane trip
with no Internet access. Also the person using git-gui or gitk may not
be the same person as the person installing the box, so the user might
just not have the rights to actually install things.

As I wrote in a previous email, in general it is best to try to fix
issues as soon possible, so it is better to invite people to decide if
they want to install Tcl/Tk at build time rather than at run time.
Yeah, I know that it is not best for packagers and maybe a few other
special cases, but I think setting BYPASS_TCLTK_CHECK should be a good
enough workaround in those cases.

> Yeah, this side-steps the "other half" of the issue that Christian's
> patch addresses, which seems like the more controversial part (I don't
> have a strong opinion myself, though).

I don't think any part of my patch should be controversial. I
repeatedly wrote very long messages to show all the possible cases, so
that it is easy to see that we are not worse in any case. And all the
competing suggestions, even the above from Junio either have
significant problems or address a different problem.
