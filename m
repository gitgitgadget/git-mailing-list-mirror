Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA911F488
	for <e@80x24.org>; Wed,  8 May 2019 16:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfEHQOC (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 12:14:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40299 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEHQOC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 12:14:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so8698394wre.7
        for <git@vger.kernel.org>; Wed, 08 May 2019 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=csNgXy6y//H7PYCxq2yFGnq5i7bkr720RII7TMGdtyo=;
        b=XEX7vjFxrFI4pqQJ7CrgqBd3ZgAN/G4AMxeK0+tnL1AM4RRsguJyKWMui0foOj7qy3
         Khc7k5+V2lVkvMmxQLJ9HetAQpHM5R9YKtTS/qBvTN8hk8pk9iZv0wI8I7vHJzq/7Pjc
         ppFWBeTHHnThMZkCcfHw7yC1O12CoLk5R7WKZ1GYQYuWsdkRlDpsSsh/I9pHWGYCMPc/
         jdDrHAklRNct0dtoBbrAAUzf32cRuPIGgA5scavrHSIxmSvc5h4tK5Vb0J8GpGfNSRrf
         wPYh2crnu6eN7n5c4Z8HrAIfv94As+gUGky0wTxmSfixZGa5pulQisu8H08rCDbLTIdP
         guFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=csNgXy6y//H7PYCxq2yFGnq5i7bkr720RII7TMGdtyo=;
        b=obl00vIJ/h/dxl3jSf5ADtmXWDa/QtSO2azx5s9HMQJnZbq9+GMQKSSkFzmMfhBTA3
         uh4tLoJQDTw1OLgcsgWAiY8W4ELfvv2+65FwDODTT5aNET4riA/J6l3VspOJWRcldfbt
         apWE7JoOEeX6obeW9M1szXZDJ6I28qgWIF9Sh9oUENGwEUg00sTC9KWsA6z+QMazTQ1c
         /fE4brOByBPN1c6SAsW8VyJqPt6MzPXvxdmslmt0cOplcXSsHNZEz9/aGGPDjb9AehFa
         r95bD4N1+tEbP6k37Lcwf3Kv75OR3m9iWHtovE353ciCKbCd8n5C42h+I0ky4ZqFXSI9
         o6Dw==
X-Gm-Message-State: APjAAAUWeTJcmk3WcGcHyVRj3PtCrZab3ryNH9jg0x/ZKGeWmNLNtnq9
        h0DwMgrutnl0/MCy1iB/Bl2z5hgCzZc=
X-Google-Smtp-Source: APXvYqw+vyvY3YL7dOtQHjij16sDM+W+Qsw4OVilLsXGc4V7BNq2WKcoAaTCekk9E/JtOPu+dxZSHw==
X-Received: by 2002:adf:e3c3:: with SMTP id k3mr21236521wrm.20.1557332040054;
        Wed, 08 May 2019 09:14:00 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id q24sm3216957wmc.18.2019.05.08.09.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 09:13:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
References: <20190313015133.n7f7lyujnlwfytre@dcvr> <20190313145417.GA24101@sigill.intra.peff.net> <20190314091254.nescpfp3n6mbjpmh@dcvr> <87zhoz8b9o.fsf@evledraar.gmail.com> <20190410225721.GA32262@sigill.intra.peff.net> <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com> <20190504013713.GC17551@sigill.intra.peff.net> <87a7g2iuem.fsf@evledraar.gmail.com> <20190507074506.GF28060@sigill.intra.peff.net> <8736lqisyx.fsf@evledraar.gmail.com> <20190508071105.GA14043@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190508071105.GA14043@sigill.intra.peff.net>
Date:   Wed, 08 May 2019 18:13:58 +0200
Message-ID: <87sgtohqk9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 08 2019, Jeff King wrote:

> On Tue, May 07, 2019 at 10:12:06AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I think we'd want a way to tell the bitmap code to update our progress
>> > meter as it traverses (both single objects, but also taking into accou=
nt
>> > when it finds a bitmap and then suddenly bumps the value by a large
>> > amount).
>>
>> Not splitting it will fix the progress bar stalling, so it fixes the
>> problem that the user is wondering if the command is entirely hanging.
>>
>> But I was hoping to give the user an idea of roughly where we're
>> spending our time, e.g. so you can see how much the pack.useSparse
>> setting is helping (or not).
>
> Yeah, I think that's a bigger and more complicated problem. I admit that
> my main annoyance is just the stall while we fill in the bitmaps (and
> it's easy because the bitmap traversal is the same unit of work as a
> regular traversal).
>
>> So something where we report sub-progress as we go along, and perhaps
>> print some brief summary at the end if it took long enough, e.g.:
>>
>>     Enumerating Objects (X^1%) =3D> Marking trees (Y^1%)
>>     Enumerating Objects (X^2%) =3D> Calculating bitmaps (Y^2%)
>>
>> And at the end:
>>
>>     Enumerating Objects (100%) in ~2m30s -- (~10s marking trees, ~2m10s =
bitmaps, ~10s other)
>>
>> I.e. bringing the whole "nested" trace2 regions full circle with the
>> progress bar where we could elect to trace/show some of that info, and
>> then you could turn on some trace2 mode/verbose progress to see more.
>
> I do wonder if this really needs to be part of the progress bar. The
> goal of the progress bar is to give the user a sense that work is
> happening, and (if possible, but not for "enumerating") an idea of when
> it might finish. If the trace code can already do detailed timings, then
> shouldn't we just be encouraging people to use that?

To just show work happening we could save ourselves some horizontal
space and the debates over counting v.s. enumerating with:

     diff --git a/progress.c b/progress.c
     index 0318bdd41b..83336ca391 100644
     --- a/progress.c
     +++ b/progress.c
     @@ -226,3 +226,3 @@ static struct progress *start_progress_delay(const=
 char *title, uint64_t total,
             struct progress *progress =3D xmalloc(sizeof(*progress));
     -       progress->title =3D title;
     +       progress->title =3D "Reticulating splines";
             progress->total =3D total;

:)

Obviously that's silly, but the point is we do show some user messaging
with these now, and e.g. the other day here on-list (can't be bothered
to find the msgid) someone was lamenting that the N progressbars we show
on "push" were too verbose.

So by coalescing some of the existing bars that do one logical operation
(push) in N steps we could be less verbose without losing the "stuff's
happening" part of it, and would see if something odd was going on,
e.g. the "I/O write" part being proportionally slower on this box than
the other, or when they upgrade bitmaps suddenly showing up as >95% of
the time.

The bit I find interesting about tying it into trace2 is that once you
do that the trace logs can contain e.g. min/max/avg/median/percentile
time for doing some operation we can break into N steps same/similar
steps, which might be interesting for performance analysis.
