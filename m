Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95751F453
	for <e@80x24.org>; Mon, 11 Feb 2019 16:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbfBKQAw (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 11:00:52 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:42219 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731068AbfBKQAo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 11:00:44 -0500
Received: by mail-ua1-f44.google.com with SMTP id d21so3565515uap.9
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 08:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+6M8BjGqjPveAG7mctCBKbbpP/lzRKxVewNylPRIjgA=;
        b=fgRf6wnflzJSTrmX+9k67Qj3BOjhnhhMYX4wieigRypT2dLE993J2jSKCoNJdHhbjt
         GnWv07x7GaiJqPkwh8JSPM50o2ktsN9j38yFlz7JCOI+Iz1Ck75LRBV9Q+8QC8QYf2/0
         /XUwGt/bP/jh5HEjV3Kz488u2buuvvYNBKxD7J9/mRb/YszCpofKS6jS1+zMMbezML83
         4CAhnc0hjqO4emF7XEfScmjow7tQXNs9nKLqOuwLeXE6tS4CWELwrH8UYjNXg0w/WBO/
         zOVgHTi6Y9+PdCOeZ8FrvIYQgYeQ5/nLwmS6cdozNX65mQHubjHuqt+Oq9gmTVUV7SEP
         WTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+6M8BjGqjPveAG7mctCBKbbpP/lzRKxVewNylPRIjgA=;
        b=j7lck5fb1Dwh9qOzYKYI9vwbCYW3WR1xZibOjk/Sv7O0LcRaUL2Jq5aIFY+xtcdKUQ
         KYFQSCPoaI8Rz7JJnhY3ErITuICVsArBdbeSX3VhvFn3llzB3i/ZeR5rJzMtJeqoQlfx
         wKsKidJih+9Hh1TK2aa3skbx45kjY92d7ohpwmpJO3JJCzh4iMHmBzX57B8F4h1hB2vE
         S2SFSMM0EzeP4RtVohDKwI9frD2EQ+CutRRTVx3lpgltbeMCvSQPvbBZrOi0QjrF6HQi
         T/OgiT23YDeUTaX/NmYiZoM1HRVXJTGDPh4EekZoHWSLOiqzqouG4Isp1sgpAxqSvgby
         s9tQ==
X-Gm-Message-State: AHQUAub1PhLa3jWVg870sKvR2EkwxOIZkOAJZYvpOgwEyPdI/VAzSOkM
        5jbLkk9OW+yzeFPX48sChn2A107VxlFL6F1qfblbkSP7
X-Google-Smtp-Source: AHgI3IbhNSTCvMevuuR+qu5+6oVBc1cDvpdCiIutPmnmQIYSpY4Bwh/dwnPclCL6xkKysKA5YgleRZA2txvbMP9v5wg=
X-Received: by 2002:ab0:60da:: with SMTP id g26mr14045462uam.104.1549900842463;
 Mon, 11 Feb 2019 08:00:42 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
 <875ztukt77.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1902082111320.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1902082111320.41@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Feb 2019 08:00:30 -0800
Message-ID: <CABPp-BEhjkP4kUgT9unhbM5kzykEwcP1bnrhFKQ+N9Ci9ZY=eg@mail.gmail.com>
Subject: Re: New command/tool: git filter-repo
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Fri, Feb 8, 2019 at 12:13 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi =C3=86var,
>
> On Fri, 8 Feb 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > [...]
> >
> >   But perhaps there's ways we can in advance deal with a potential
> >   future breaking API change. E.g. some Pythonic way of versioning the
> >   API, or just prominently documenting whatever (low?) stability
> >   guarantees we're making.
>
> Another thing to keep in mind: it being in Python prevents it from being
> distributed with Git for Windows. The Git for Windows installer already
> weighs way more than it used to (it used to be under 30MB, now it is
> 44MB), and I am simply not willing to increase the footprint dramatically
> just for one rarely used command.

That would be unfortunate, though understandable.  I am curious,
though: do you include and does anyone use filter-branch on windows?
You mentioned elsewhere in this thread that you weren't even willing
to attempt to run filter-branch there.  If people aren't using
filter-branch on windows, then there's nothing for me to save them
from anyway.  If they are, I'm curious to hear more about the usecases
and motivations, even if the cost of my tool is too high for you to
include.

Also, since filter-branch and filter-repo are meant mostly as one-shot
migration tools, it is already not uncommon for people to do it on a
different machine (perhaps one with more RAM, or faster disks), and at
most one person on the team needs to run it (sometimes folks even look
to an "expert" outside the team to run the migration for them).  Once
migrated, they push the results back and are done with the tool.

> If only it were written as a built-in...

A built-in would be great, IF it could provide all the same
capabilities and with at least the same speed.  However, making it a
built-in would fundamentally remove a significant chunk of its power
and flexibility, which was part of the driving force for creating this
tool.

Elijah
