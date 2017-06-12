Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C2D71F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 19:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbdFLTCz (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 15:02:55 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34970 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdFLTCy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 15:02:54 -0400
Received: by mail-io0-f171.google.com with SMTP id k93so60394849ioi.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=52XtLPIE66zNVKDzLCxN+wr/nBVjZaJLf/6XcPf8yJU=;
        b=YAeQrvbozHt+taZ5qjbNe5ivnp7inhDNknlC/Du64oyrzOOlOaEqHBjPOLB3PHUBCd
         sT3s73cBvIs80fYxf3TtvaO949lFJjD7etZ26wSLJ6lMZjktKyrXJ7XeI0vB9RVpo4Lv
         5FG6CvgFXkco5s/gCjjjUDMJoQafz+nrCcAh5qUs3hYDzHGuFLqHcM++dXr5LczCzGx1
         OwdRafzVgZfUZDF7uj49sEpDDaKlpVkcYtf6h3u1YdwdpHQID6mwIpICXz6qXyukEwSq
         5F3rP8QMQev02pybESv/vnTGNbYEsy0OFhZrv0jD28kF3cJt2l7jlrWH4dZ97gkTO+VE
         A0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=52XtLPIE66zNVKDzLCxN+wr/nBVjZaJLf/6XcPf8yJU=;
        b=isHzRkUyiIxmAPZAuI1h2SDtDJCJC4UTKzPkZTDw8aXqA/QfVni+FMNZ5HIHbDkamx
         jX32G1qTjQ6xM7YPfeD/p1BnaIBW2HXBhbGz6i3K8DWBRVAX2Nx3JCUTBhrZNoydrzBk
         Sbt62Dc6dqkQlZv/Ybi/A2yFbHwBl4TNF2NYselKeFqUzfbjUbs98r/M48h3UFHhCVlY
         xzN4TT11TaBFFSWDbNdhDDAsFkVw7+ISq7Y7plY/ChdXThc6yIScvtF9nDfmGM/O0LGD
         v9iMMSMJi/kZ2vU7vdPFgDkgSBSfAo2ijIFWUxWIdi/j0pP4iwY6pCGukFiNkT/s3GRx
         GSJA==
X-Gm-Message-State: AODbwcBvkx136HLMWc6u7BBSg//DJZ/lmtFEPXip2ojZfTB6lgWr5FVg
        oBBMbeOw5l1rpJDDm093fxLGaCjzrQ==
X-Received: by 10.107.173.18 with SMTP id w18mr32305854ioe.80.1497294173445;
 Mon, 12 Jun 2017 12:02:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Mon, 12 Jun 2017 12:02:32 -0700 (PDT)
In-Reply-To: <20170612182045.z4d37ph5uqqhwmas@sigill.intra.peff.net>
References: <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de> <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de> <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
 <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de> <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
 <22846.51138.555606.729612@a1i15.kph.uni-mainz.de> <CACBZZX6AH2nEGPHMq6XOLDxr4SH9v-zT_YGovLXN_ZQ+fB345g@mail.gmail.com>
 <20170612182045.z4d37ph5uqqhwmas@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 12 Jun 2017 21:02:32 +0200
Message-ID: <CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
To:     Jeff King <peff@peff.net>
Cc:     Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 8:20 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 12, 2017 at 07:53:21PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >> Of course we can never know if you were in Tokyo or Seul from the inf=
o
>> >> in the commit object, but we don't need to, it's enough that we just
>> >> emit JST for +0900 and anyone reading the output has at least some
>> >> idea what +0900 maps to.
>> >
>> > Please don't. Outputting invented information for something that
>> > really isn't in the data is worse than outputting no information at
>> > all.
>>
>> It's not invented information. %z being +0900 is the same thing as %Z
>> being JST since +0900 =3D=3D JST, just because some other things are als=
o
>> =3D=3D +0900 that doesn't mean that JST is invalid or less useful than
>> +0900 or "" for the purposes of human-readable output.
>
> I think the main problem is that the mapping isn't just "JST->+0900".
> It's a set of rules that depend on the specific time being converted. So
> it's true that at some time t, +0900 may mean JST or KST or whatever.
> But at a different time, those time zones will map to a different
> offset.

To the extent that it doesn't map correctly (e.g. due to summer time)
that's already a bug/understood limitation in the fuzzy TZ parser in
date.c, isn't it (dating back to Linus's "In my world, it's always
summer" comment in 89967023da).

> So I think at best this is semantically confusing (the author was not in
> JST, but just happened to be in a time zone that maps to the same thing
> at that moment, and any attempt to extrapolate their zone at another
> time is going to be wrong). And at worst the output of "git log" is
> going to show the same user flip-flopping between zones as their commits
> move around with respect to the (politically determined) zone changes.
> For instance in my time zone I'd shift between EST and CST twice per
> year due to DST. My real time zone is EST5EDT, or better still,
> America/New_York (I don't live there, but the Olson database carves up
> regions based on the most populous city in the zone).

I think everyone in this thread disagrees with what I think makes
sense for %Z, and I'm not going to argue the point, I just thought I'd
chime in because it seemed to me that the discussion had missed the
mapping we had in the timezone_names variable.

But FWIW and just to (I think fairly) summarize, here's where we differ.

You (and others) think that unless we can actually show the user's
time zone as it appeared on their machine %Z shouldn't show anything
at all, since it would be confusing. Fair enough.

I only ever use the time offset info to quickly make a mental note of
"oh +0200, this guy's in Europe", or "oh -0400 America East". Having
any info at all for %Z would allow me to easily replace that already
buggy mapping that exists in my head right now with something that's
at least a bit more accurate, e.g. I remember that +0900 is Japan, but
I can't now offhand recall what timezones India is at.

Now, obviously we can't know whether to translate e.g. -0400 to New
York or Santiago, but for the purposes of human readable output I
thought it would be more useful to guess than show nothing at all. So
for that purpose the most useful output of %Z *for me* would be just
showing a string with the 3 most notable cities/areas, weighted for
showing locations on different continents, e.g.:

  +0000 =3D Iceland, West Africa, Ittoqqortoormiit
  +0100 =3D London, Lisbon, Kinshasa
  ...
  +0900 =3D Tokyo, Seul, Manokwari
  ....
  -0900 =3D San Francisco, Vancouver, Tijuana
  ....
  -0600 =3D Denver, Managua, Calgary

Then I could run:

    git log --date=3Dformat-local:"%Y[...](%Z)"

And get output like:

    commit 826c06412e (HEAD -> master, origin/master, origin/HEAD)
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Fri Jun 2 15:07:36 2017 +0900 (San Francisco, Vancouver,
Tijuana etc.)

    Fifth batch for 2.14
    [...]
    commit 30d005c020
    Author: Jeff King <peff@peff.net>
    Date:   Fri May 19 08:59:34 2017 -0400 (New York, Havana, Santiago etc.=
)

        diff: use blob path for blob/file diffs

Which gives me a pretty good idea of where the people who are making
my colleges / collaborators who are making commits all over the world
are located, for the purposes of reinforcing the abstract numeric
mapping with a best-guess at what the location might be, or at least
something that's close to the actual location.

I'd definitely use a feature like that, and could hack it up on top of
the current patches if there wasn't vehement opposition to it. Maybe
the above examples change someone's mind, I can't think of a case
where someone's relying on %Z now for date-local, or at least cases
where something like the above wouldn't be more useful in practice
than just an empty string, but if nobody agrees so be it :)
