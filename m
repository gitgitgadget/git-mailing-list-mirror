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
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3C71F461
	for <e@80x24.org>; Sat,  7 Sep 2019 14:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390240AbfIGOHB (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 10:07:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45274 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388372AbfIGOHA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 10:07:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id 4so5134042pgm.12
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 07:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y8ux2A8rWHBZVHysVV4tDS7/82UbYiqqAXEMj4hg10Y=;
        b=tNb2dXrkmn5cHZoZZ+lSQdLsZ3txjQs8a9fuB24rtergx0ge8k+y+0PMppiuxan5QV
         AFPYGIErw0ERjwoajgLO4pfz90mpVlfqcsyGAgjmACZINXUm03HiCJUf6jqdDtd/4twL
         eFKo4DZd5W5tK0/uFZ5zpD+bk7ViMdrQD+hSGU9ATYMcL+HN7U4S65ycwAhJ8XDdP4u8
         jOxbBbariJwE6Q+8zAUQ2gDwQ99F9OVfm6y6b5N6WhU0pwJWV5txdNF4eyzr24BpqatX
         YpG7e/FjqzhR0sFsFvhEC0P9qkA8IjnRsanwuugN8b93oXpor0s8UTZRoX/fJZXD5V3R
         kErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y8ux2A8rWHBZVHysVV4tDS7/82UbYiqqAXEMj4hg10Y=;
        b=bpuumzrKrfEzDdC2vzhZZKO0n2Yn/K/5MODTfdylgKlv5U5n4F23naWprEpxB3fSwv
         UEj54T9VK4DLAZYERwk1VEJ2Zu3l161mcgZFRm4IVipaQYDQEKcKXum+3m/v+A/Z3olL
         hH0gfqDjlQJfb+qOJlMESe4uq9oCkskdKok2HSQsdeHOsJGSnmwXTHxlqLm2Jds59ovk
         tdSGeHIvRP2fTHew2ol9KeIQPtqYuD65euQI9sMmGHtt0U3wXoq/KNdWthYsQA0kYv/F
         kuZAy5coPA6iJ03on01w1gKaYx+Ip04kC824ngGrohEw96tdsRfNisPgXrMSVwDNDRxO
         s2iA==
X-Gm-Message-State: APjAAAUNN6++drQXDzetzpsRTmOxULiLoncQbgD9QaLnjxYNhCYqMn4H
        AIxsnHP5SyWSfB0vMm5YJtMuO9gUOIXrvmu7uzc=
X-Google-Smtp-Source: APXvYqwg2UZ6c4AdAXskjMAfQkqrm+JjzrzmHtQRfCkEh32wBYj0pEIOraxsvbZT5290NX/oTuY5HJ9lJW+gzS/PKvk=
X-Received: by 2002:a17:90a:2ecb:: with SMTP id h11mr14984570pjs.108.1567865220030;
 Sat, 07 Sep 2019 07:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAN0heSr2zCQMM6wOM0UnD28qj_VygQ5CQHGHhMR9+H23snpt5Q@mail.gmail.com>
 <cover.1567534373.git.martin.agren@gmail.com> <20190904032609.GD28836@sigill.intra.peff.net>
 <CAN0heSpbRvNG9okz5pqkHqDMB2BM5T+FzAbaK3sVwzGC6fjpPA@mail.gmail.com> <20190907064508.GC28860@sigill.intra.peff.net>
In-Reply-To: <20190907064508.GC28860@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 7 Sep 2019 16:06:48 +0200
Message-ID: <CAN0heSoOcpiPiRcYwLxxByC49Q-yXipFzBGm=XKW-AZk4n=8Jg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] asciidoctor-extensions: provide `<refmiscinfo/>`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 7 Sep 2019 at 08:45, Jeff King <peff@peff.net> wrote:
>
> On Thu, Sep 05, 2019 at 09:35:10PM +0200, Martin =C3=85gren wrote:
>
> > > Yeah, I do still like that as an endgame, but I like what you have he=
re
> > > as an intermediate step in the right direction.
> >
> > Hmm, so this sounds like once I am happy with replacing AsciiDoc with
> > Asciidoctor 1(.5.5), I should rather not propose a series "let's defaul=
t
> > to Asciidoctor!!!" but instead a slightly more careful "go with
> > Asciidoctor, but document that we work badly with v2 and that the 2nd
> > choice after Asciidoctor 1 should be AsciiDoc". Or do you see it
> > differently? (I wonder which Asciidoctor-version Junio would be on..)
>
> Yeah, that seems reasonable.
>
> TBH, if making things in the middle step work turns out to be too hard,
> I'm not entirely opposed to a hard switch.
>
> The "does not work with 2.0" thing has to be a temporary step, though, I
> think, since using the older versions will get harder and harder as time
> goes on. I think it's OK to take such a temporary step as long as we
> understand where it leads (and presumably its to directly generating the
> roff with asciidoctor). The middle step of having asciidoctor+xmlto
> helps us understand and isolate which changes are responsible for which
> parts of the output.

So of these steps:

  0. Get Asciidoctor (v1) in shape.

  1. Switch the default to Asciidoctor (v1).

  2. Drop AsciiDoc to have faster Asciidoctor-processing, avoid xmlto
     and support Asciidoctor 2. And to avoid the Python 2 EOL, too.

Step 0 is not far away, so step 1 could be done fairly soon IMHO. Step 2
would "hopefully" happen soon after -- maybe even in the same release
cycle as step 1, and if not the same then the one just after. But I
might be the wrong person to trust on that one. I currently don't even
try to build with Asciidoctor 2. I might perhaps look into installing
it, but it could also be that I'll only start using it when it happens
to arrive through my distro.

So as long as I'm not looking into Asciidoctor 2, maybe I shouldn't be
the one to impose "default to asciidoctor" on the world. Dunno. In any
case, I should be able to bring the asciidoc/tor1 differences to a state
where we trust asciidoctor 1 to be in a good shape, so that "someone
else" could pick up the ball and work on asciidoctor 2 vs 1, knowing
that it's ok if they regress AsciiDoc support or even drop it entirely
in the process.

Martin
