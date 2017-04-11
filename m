Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F231420970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbdDKUVW (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:21:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35247 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752847AbdDKUVU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:21:20 -0400
Received: by mail-io0-f195.google.com with SMTP id d203so349839iof.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fDXEGtRZlfFKtatgOdTvssh0ehmtOtw6/sumKf0BfCc=;
        b=eNZx4bWHFipXjRbrDHeWmREFxOv9Bx00RhRX9JgfCapJRGiC3YP3OO0HN4Rtb2yDAX
         GcMt23IHOIP1Gg5Q/8UVrttSQ6vJ0yMh9SAzxR43goVRDvd9mk1U99pB3Rqkh7vqlKgQ
         PoJP8j50mGnH5ArA5wEoiR/q1jzUplWLZArTexIS+ETEOYzYmLnmTHJNKOakQuadLKRm
         5cvx35sg25zevsOpQmJNQezAXxllmy+NQ8WgWY8fMBCpy1ufjt/HH0TD+qDRDdLRi8Sd
         OcKIIJzqimbqOdyMCNyRDVOdSwd3T9bCKfvzXXXV7DqblyjTWN1B5xWubIpaqjJ53qtE
         m66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fDXEGtRZlfFKtatgOdTvssh0ehmtOtw6/sumKf0BfCc=;
        b=k04KTFE6M3bO04LK5vSKFsHiEmzAr411PXGjDXucebrubYdEBJ1hDjNIpJyhnr7dk/
         kE3J4mOeLpY5vb6BDfoiFJenZznf6/bAEUj0GrB5KVa+mTQzHkyrj3dU0zphykhbanpR
         XegoLSNOb8LZxOzSatfYGjIn2c2sQaOuVCYrfEkqYXZ88ReokmGxstJgBU4SF6+HoMSy
         JoV9L7bTL6qrXsfr9wDGqO07C11/QUYx5BOG/m5idqqWw1z7Jf2zobyccUSk6XxgGfwn
         IU+irMbrwOgfXpppBQOsxd/qWENWAuaV/tJhzlmpDsX3V52Hpc08t6wzcK2/X1V+uiF/
         0WYg==
X-Gm-Message-State: AFeK/H28AAjEdYzqduCt20cmW8mTIxHZfz/ZQMSYeqirKWDuHddJ81ysuv/WmSobdDBw1FK27pYDFiocfno3hA==
X-Received: by 10.107.46.229 with SMTP id u98mr46686789iou.147.1491942079891;
 Tue, 11 Apr 2017 13:21:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 11 Apr 2017 13:20:59 -0700 (PDT)
In-Reply-To: <20170411100656.5bptxdaptc4zznan@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com> <20170408132506.5415-2-avarab@gmail.com>
 <20170411100656.5bptxdaptc4zznan@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 22:20:59 +0200
Message-ID: <CACBZZX7vEQ5jUzX3GsD6JXe50TnRUtGmSVi7zBxwOmAQGABQ4Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] grep: add ability to disable threading with
 --threads=0 or grep.threads=0
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Rast <trast@student.ethz.ch>,
        Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 12:06 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 08, 2017 at 01:24:55PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Add the ability to entirely disable threading by having grep.threads=3D0
>> in the config or --threads=3D0 on the command-line.
>
> In pack-objects and index-pack, --threads=3D0 means "auto-detect". It
> seems like we should try to keep this consistent.
>
> Wouldn't --threads=3D1 be a better way to disable threading? Pack-objects
> is smart enough to just use the non-threaded code path entirely in that
> case (rather than wasting time spawning a single worker thread). Grep
> should probably do the same.

I'm struggling to find a use-case where threading makes sense at all.
The example in the initial introduction in 5b594f457a is always slower
with >0 for me, and since then in 0579f91dd7 it got disabled entirely
for non-worktree cases.

But assuming it works for someone out there, then 0 threads is clearly
not the same as 1. On linux.git with pcre2 grepping for [q]werty for
example[1]

        Rate P_12  P_8  P_4  P_1  P_2  P_0
P_12 0.861/s   --  -7% -22% -27% -30% -43%
P_8  0.924/s   7%   -- -16% -22% -25% -39%
P_4   1.10/s  28%  19%   --  -7% -10% -27%
P_1   1.19/s  38%  29%   8%   --  -3% -21%
P_2   1.23/s  43%  33%  12%   4%   -- -18%
P_0   1.51/s  75%  63%  37%  27%  22%   --

And for [a]var on git.git:

       Rate P_12  P_8  P_4  P_2  P_1  P_0
P_12 15.6/s   --  -5% -15% -17% -21% -42%
P_8  16.4/s   5%   -- -11% -12% -17% -39%
P_4  18.4/s  18%  13%   --  -1%  -7% -32%
P_2  18.7/s  20%  14%   1%   --  -6% -31%
P_1  19.8/s  27%  21%   8%   6%   -- -27%
P_0  27.0/s  73%  65%  46%  44%  36%   --

Tthere's a >20% performance difference between 0 and 1 threads. The
more threads I add the slower it gets, but if there's some case where
we have the inverse of that and you have e.g. 2 cores, then presumably
you really want 1 thread, and not 0, or 2.

>> +static int thread_callback(const struct option *opt,
>> +                        const char *arg, int unset)
>> +{
>> +     int *threads =3D (int*)opt->value;
>> +     char *end;
>> +
>> +     if (unset) {
>> +             *threads =3D GREP_NUM_THREADS_DEFAULT;
>> +             return 0;
>> +     }
>
> This means that "--no-threads" will use 8 threads. Which _kind of_ makes
> sense in that it cancels any previous "--threads", but I wonder if it
> should be the same as "--threads=3D1".

Dear lazyweb, how do you distinguish --no-foo from no --foo=3DX being
provided in this API?

> This isn't really a change in behavior from the existing code, though
> (OPT_INTEGER will set it to 0 in that case, too, and we'd later pick up
> the default value).

1. =3D~/g/git/ perl -MBenchmark=3Dcmpthese -wE 'cmpthese(10, { map { my $t
=3D $_; +("P_$t" =3D> sub { system "$ENV{PF}git -c grep.patternType=3Dpcre2
grep --threads=3D$t [q]werty >/dev/null" }) } 0,1,2,4,8,12 })'
