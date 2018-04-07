Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1B71F424
	for <e@80x24.org>; Sat,  7 Apr 2018 08:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeDGIZC (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 04:25:02 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35286 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeDGIZB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 04:25:01 -0400
Received: by mail-qk0-f193.google.com with SMTP id c188so3778110qkg.2
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 01:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZZCJoxoO3MfM7hI2Ua9UXsKcWaCiKWFsMg7zOh+CWlc=;
        b=kJTNhQ09b0uzBCk98ACMaSDPn5C/QPKooi0ZY8fwLhUzRKytTl8elcxAO/n81Rm2LX
         w99IVxXwAkCkLX9clggQPj4TSIPrb9gw0VZ7gGoOJnwTph9VqqxilzfVOEBt8giBIpff
         1ReiUnJA067ORWSTV8UQukrlNKfNhiST28Bn2fFSN0LTCmSU1RqGHbwOUUsx1a2pGSC+
         tFu6rCTepufx9G83Wg+NJWC+J/Q0ta4n5BuHsta4q5MaT3dIqpUNYNUhMlPAqdvjjrch
         7HuBWaEfAdiYiUgE7Me798aqwkFeaakQFczZdFV1QoAG27zmUupZqAgRpFCrQxC03LHC
         ChQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZZCJoxoO3MfM7hI2Ua9UXsKcWaCiKWFsMg7zOh+CWlc=;
        b=P3wNAvZLPmMEVjf3mlL/RyBiGCGvla3bDXa5YyCAfXGYdUS4UqwdCHhb/TBmxH9R7H
         mCVZVf2ph5eN7k8/cnEFrwTn3PGX9KW2VOdqguvcG0C//U7T2SmgV+y9dX7vEHFS2bIn
         jeVEp4P3mdZUHP3nsUXlBodLIPGK6Cl4nN5wQfdOYd1gb5KM6dQoBsQXVBrtfk3GqwDU
         /AJdXlzzV5dAMz+mQkUT21gs6qImuzQiI/EgymyaSWxLCeI15Wpzl6XXufvxyDNAGVDl
         pDDrmRKSi98qw+viW6aKnksrpR8tfCQe61FoZ4rxjL2ep+8+2cMbXCjNoN14rWoaHeGm
         aKyg==
X-Gm-Message-State: ALQs6tAbGv+1XSy/77QMCVl/M0W5sZcEQltSehe3cjLWM6XQAtNGazee
        vyfwTG74jHKsNrsm5MkESUb6BKUJ9x/V4zx3JMo=
X-Google-Smtp-Source: AIpwx4+yWu6bSITyHN4esL7gTtK/TaEIk7WYaaMmtjjEoRgE8tkJd4XO3CZSQhitIzUch6LW66lxy0wK5hTsEeicLoY=
X-Received: by 10.55.198.217 with SMTP id s86mr39402379qkl.153.1523089500846;
 Sat, 07 Apr 2018 01:25:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 7 Apr 2018 01:25:00 -0700 (PDT)
In-Reply-To: <20180407003912.GA78042@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com> <cover.1522996619.git.me@ttaylorr.com>
 <20180406063915.GC2908@syl.local> <CAPig+cQPB+74T3YenoZ_oVFGh2c38AbcFdc+yjw6f32Ojestwg@mail.gmail.com>
 <20180407003912.GA78042@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 7 Apr 2018 04:25:00 -0400
X-Google-Sender-Auth: bOuGMztv69_klctWWstb0js8oJ0
Message-ID: <CAPig+cQXJuLWpxfwhQ98a23wfAAzKZpkOvqWBdXaKKHLiW-7Uw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 8:39 PM, Taylor Blau <me@ttaylorr.com> wrote:
> On Fri, Apr 06, 2018 at 03:04:53AM -0400, Eric Sunshine wrote:
>> Sorry for being such a stickler, but this is still too mushy. The
>> first two sentences are saying effectively the same thing. One or the
>> other should be dropped or they should somehow be combined in a way
>> that says everything that needs to be said without repetition.
>
> How do you feel about?
>
>   The `--type=<type>` option instructs 'git config' to ensure that
>   incoming and outgoing values are canonicalize-able under the given
>   <type>.  If no `--type=<type>` is given, no canonicalization will be
>   performed. Callers may unset the existing `--type` specifier with
>   `--no-type`.

This sounds fine. (Maybe s/the existing/an existing/)

> I think documenting that `--no-type` unsets any pre-existing `--type`
> specifier is worthwhile. That said, I also think that there's a way to
> combine the last two sentences, but it might be clearer as two smaller
> pieces rather than one big one.

Smaller, simpler, more easily digested sentences are a win.

>> If necessary, iterate over updates of this paragraph here in the email
>> thread until a polished version is reached rather than re-rolling the
>> entire series every few minutes.
>
> Thanks, and will do :-). I am quite new to this and was unaware of the
> situations when re-rolling is and isn't desirable. I am going to wait to
> re-roll this series until it has gathered more feedback, or at least
> consensus,

Just as it's a burden for you to repeatedly re-roll, it's also a
burden on reviewers to repeatedly re-read the series. Ideally, we'd
like fewer, rather than more, re-rolls, so it's good to nail down
questionable or ambiguous issues via normal email discussion before
going for a re-roll, and some reviewers try to assist with deciding if
a re-roll is needed by saying whether or not a review comment warrants
one.

Allowing time for others to review and possibly comment on a series
before re-rolling is indeed a good idea.

Another useful tactic is to include, in the cover letter, an interdiff
between the previous and new versions, which gives reviewers a way to
quickly examine the changed parts of the series without necessarily
having to re-review each patch in entirety (an often time-consuming
task).

> after which I think it will be ready for queueing as-is.

Famous last words ;-)
