Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F1820D0A
	for <e@80x24.org>; Mon, 29 May 2017 12:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751014AbdE2Mub (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 08:50:31 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36586 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdE2Mua (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 08:50:30 -0400
Received: by mail-it0-f65.google.com with SMTP id i206so7035179ita.3
        for <git@vger.kernel.org>; Mon, 29 May 2017 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u4SvO9IgCj4dT3JqDSuy0REJyUf2Shz5ghEqFTfiEZw=;
        b=rXDudLpu53jDDEU5K3QTlyA/7FGrqTz19+ATzlrqZtvA5Li7gF85SI007E0UIs+kWb
         gcy7QxH4DD5ND/O551HK8o+VTkLWyl8qH6XuctOuqSQd0HvkrL/zHY2IGKJN2+NbrVfQ
         qvFDh0jQWGjcl2pbIL4+CJdx8z2vb8oIvhMOlnpuyu6uuQW/TQY4tnYYMLkHDle676mx
         EzN7bfDUv0QwRwC9Wupm4H63SmcKHN2DKTs8QywF9E1qzRLoW8I9hQWA+dadQSwRg1Sn
         +kdgTiOsmhDvXAMPBXdbXb+phGGaMj81O1M23Q+7vv7mkFBLuCGHp80ec9SDJYMQbalu
         XYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u4SvO9IgCj4dT3JqDSuy0REJyUf2Shz5ghEqFTfiEZw=;
        b=J+/ZZP2bObwm8WFi+EuLiUFzUOGmC0TBc8cVDI96kT87VHd3ZC+q9UeatbhK3Hpikt
         41hPK4EkvOFYVF0OtbhdEgB2iAZ5jnftHpWjgsxId0sdXHTzct2GA8bIATeYMotln1LS
         vKFu8AtEA2kau3y/xl6m/CNvKCtwp2gHyBOuJ98ajze46YNdT8ktuWFiQN4eCi8+pU+8
         QiuA6QFlnOmBcIk2ba/1eyLmg/1OM6WK+F3eXXvKwajdiZ4McQeweEc8oHcxDYX2gmW0
         CV+L+kTS6axo6m5ef6mqj5Xcrzi/AUEoktIiVTnG0mMLEFWnrwyKVit1sErjF0A7qjRD
         5KdA==
X-Gm-Message-State: AODbwcDVxeCCN225DhC2Dn+cCMdpY1IH0FRR8ADPtnFstxwZX/0WwQm/
        Cew/Tp7SQH6T/BRcWu3g00T4GNACEGG0pBA=
X-Received: by 10.36.53.79 with SMTP id k76mr13540228ita.71.1496062229713;
 Mon, 29 May 2017 05:50:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 29 May 2017 05:50:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705291247000.3610@virtualbox>
References: <cover.1493414945.git.johannes.schindelin@gmx.de>
 <20170526031508.24838-1-liambeguin@gmail.com> <6f0e176b-e638-c13c-6a6d-aa5b62297879@web.de>
 <alpine.DEB.2.21.1.1705291247000.3610@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 29 May 2017 14:50:08 +0200
Message-ID: <CACBZZX4avOKJjWVSBSewNFMWyRj3FzHC2Onw3aWLf1F_MYi+Gg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] The final building block for a faster rebase -i
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 12:51 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Ren=C3=A9,
>
> On Sat, 27 May 2017, Ren=C3=A9 Scharfe wrote:
>
>> Am 26.05.2017 um 05:15 schrieb Liam Beguin:
>> > I tried to time the execution on an interactive rebase (on Linux) but
>> > I did not notice a significant change in speed.
>> > Do we have a way to measure performance / speed changes between versio=
n?
>>
>> Well, there's performance test script p3404-rebase-interactive.sh.  You
>> could run it e.g. like this:
>>
>>       $ (cd t/perf && ./run origin/master HEAD ./p3404*.sh)
>>
>> This would compare the performance of master with the current branch
>> you're on.  The results of p3404 are quite noisy for me on master,
>> though (saw 15% difference between runs without any code changes), so
>> take them with a bag of salt.
>
> Indeed. Our performance tests are simply not very meaningful.
>
> Part of it is the use of shell scripting (which defeats performance
> testing pretty well),

Don't the performance tests take long enough that the shellscripting
overhead gets lost in the noise? E.g. on Windows what do you get when
you run this in t/perf:

    $ GIT_PERF_REPEAT_COUNT=3D3 GIT_PERF_MAKE_OPTS=3D"-j6 NO_OPENSSL=3DY
BLK_SHA1=3DY CFLAGS=3D-O3" ./run v2.10.0 v2.12.0 v2.13.0 p3400-rebase.sh

I get split-index performance improving by 28% in 2.12 and 58% in
2.13, small error bars even with just 3 runs. This is on Linux, but my
sense of fork overhead on Windows is that it isn't so bad as to matter
here.

I'd also be interested to see what sort of results you get for my
"grep: add support for the PCRE v1 JIT API" patch which is in pu now,
assuming you have a PCRE newer than 8.32 or so.

> another part is that we have no performance testing
> experts among us, and failed to attract any, so not only is the repeat
> count ridiculously small, we also have no graphing worth speaking of (and
> therefore it is impossible to even see trends, which is a rather importan=
t
> visual way to verify sound performance testing).
>
> Frankly, I have no illusion about this getting fixed, ever.

I have a project on my TODO that I've been meaning to get to which
would address this. I'd be interested to know what people think about
the design:

* Run the perf tests in some more where the raw runtimes are saved away
* Have some way to dump a static html page from that with graphs over
time (with gnuplot svg?)
* Supply some config file to drive this, so you can e.g. run each
tests N times against your repo X for the last 10 versions of git.
* Since it's static HTML it would be trivial for anyone to share such
results, and e.g. setup running them in cron to regularly publish to
github pages.

> So yes, in the meantime we need to use those numbers with a considerable
> amount of skepticism.

...however, while the presentation could be improved, I've seen no
reason to think that the underlying numbers are suspect, or that the
perf framework needs to be rewritten as opposed to improved upon. If
you don't think so I'd like to know why.
