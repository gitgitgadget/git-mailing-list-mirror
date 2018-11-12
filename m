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
	by dcvr.yhbt.net (Postfix) with ESMTP id A5AAE1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 09:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeKLTJ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 14:09:58 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:55662 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeKLTJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 14:09:57 -0500
Received: by mail-wm1-f48.google.com with SMTP id i73-v6so2352412wmd.5
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 01:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=u6sv42x+QIdXn3n4HMXKPrg49//YISMtNR1F2QpgXvs=;
        b=jvFtP3p4ZfkJRttFFb3Cc5TBIbvncR0RtryHFxdyauBDBM4sPPa/sWE6efLGn3jJzQ
         c/pMfHNpWEh7g11vdKwt4B+wQrAD0DRMAb7hgWvC42AvjZ8ZIx68eKkeB85HAhgdv5NO
         moMKoRhaBOxaVALk8YqqZiyOnPH2u5kd0HPv4Sy/qr8s1rbae4zyMJbuaqUWQJNW5nKr
         wAEc+YC02v8mqgp90q2rf3udY+KSO4qusKb2rqLMqdYPtRKm3T2GZ/LEomDBk0+/kzWT
         Kf5JHzNZdGFRaMOp52adQpOJJxzKLOB82aBUZ2Ogoa7Ug3s65WbDj2YCjcGbmikUwUWt
         cmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=u6sv42x+QIdXn3n4HMXKPrg49//YISMtNR1F2QpgXvs=;
        b=goFa2kZbSqMnzjTroJBh20ZKPaFEerddorjElgp1/jfozMkkmI8H+YaPY16OT7StPs
         3dukcSo7uyiPh2bAT3i/8gZX0fqTWdy+DWLsWH59eX4phbKorfpEEAcNOwg2SPlzIwMh
         YpgygiuX4Ie3nIBgff1RRSIr85exgewYk1BuBvVZIQETWVCBg81bkTJ2EqFXl0kZMP41
         EL+a06DZCHVuUmxplmMSgDfKMVTtcaR+7HmfZJ6VYzodML79vbvRH6ZAxCuvHWYTFCtb
         CgrfX+mYjsBg0IisCUvLuuRUveLnoIdsqp5n0yYP//XTz+rIGWjtXGL979X7NxQXQP8E
         DNkQ==
X-Gm-Message-State: AGRZ1gJ43bBU+4prc/cvIxEAYj3SVNcus3KD91jnplj/XWMHOk68aBT/
        k7y2qO/bs1lp9Oan/n3wOVWmXxPS
X-Google-Smtp-Source: AJdET5cKP/VA4G6lZrPUpp5Gg2+US0R36op6ytW5/zCL+bPWeJXRdP5wRe3etDEsFJLjOTOZOfhoHQ==
X-Received: by 2002:a1c:b60a:: with SMTP id g10-v6mr7414468wmf.138.1542014256822;
        Mon, 12 Nov 2018 01:17:36 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id p7-v6sm13379478wrs.23.2018.11.12.01.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 01:17:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Import/Export as a fast way to purge files from Git?
References: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
        <CABPp-BGL-3_nhZSpt0Bz0EVY-6-mcbgZMmx4YcXEfA_ZrTqFUw@mail.gmail.com>
        <91771D9B-166D-403F-BB20-7E574444BB3B@gmail.com>
        <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
Date:   Mon, 12 Nov 2018 10:17:34 +0100
Message-ID: <87r2fq3b9t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 01 2018, Elijah Newren wrote:

> On Wed, Oct 31, 2018 at 12:16 PM Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> > On Sep 24, 2018, at 7:24 PM, Elijah Newren <newren@gmail.com> wrote:
>> > On Sun, Sep 23, 2018 at 6:08 AM Lars Schneider <larsxschneider@gmail.com> wrote:
>> >>
>> >> Hi,
>> >>
>> >> I recently had to purge files from large Git repos (many files, many commits).
>> >> The usual recommendation is to use `git filter-branch --index-filter` to purge
>> >> files. However, this is *very* slow for large repos (e.g. it takes 45min to
>> >> remove the `builtin` directory from git core). I realized that I can remove
>> >> files *way* faster by exporting the repo, removing the file references,
>> >> and then importing the repo (see Perl script below, it takes ~30sec to remove
>> >> the `builtin` directory from git core). Do you see any problem with this
>> >> approach?
>> >
>> > It looks like others have pointed you at other tools, and you're
>> > already shifting to that route.  But I think it's a useful question to
>> > answer more generally, so for those that are really curious...
>> >
>> >
>> > The basic approach is fine, though if you try to extend it much you
>> > can run into a few possible edge/corner cases (more on that below).
>> > I've been using this basic approach for years and even created a
>> > mini-python library[1] designed specifically to allow people to create
>> > "fast-filters", used as
>> >   git fast-export <options> | your-fast-filter | git fast-import <options>
>> >
>> > But that library didn't really take off; even I have rarely used it,
>> > often opting for filter-branch despite its horrible performance or a
>> > simple fast-export | long-sed-command | fast-import (with some extra
>> > pre-checking to make sure the sed wouldn't unintentionally munge other
>> > data).  BFG is great, as long as you're only interested in removing a
>> > few big items, but otherwise doesn't seem very useful (to be fair,
>> > it's very upfront about only wanting to solve that problem).
>> > Recently, due to continuing questions on filter-branch and folks still
>> > getting confused with it, I looked at existing tools, decided I didn't
>> > think any quite fit, and started looking into converting
>> > git_fast_filter into a filter-branch-like tool instead of just a
>> > libary.  Found some bugs and missing features in fast-export along the
>> > way (and have some patches I still need to send in).  But I kind of
>> > got stuck -- if the tool is in python, will that limit adoption too
>> > much?  It'd be kind of nice to have this tool in core git.  But I kind
>> > of like leaving open the possibility of using it as a tool _or_ as a
>> > library, the latter for the special cases where case-specific
>> > programmatic filtering is needed.  But a developer-convenience library
>> > makes almost no sense unless in a higher level language, such as
>> > python.  I'm still trying to make up my mind about what I want (and
>> > what others might want), and have been kind of blocking on that.  (If
>> > others have opinions, I'm all ears.)
>>
>> That library sounds like a very interesting idea. Unfortunately, the
>> referenced repo seems not to be available anymore:
>>     git://gitorious.org/git_fast_filter/mainline.git
>
> Yeah, gitorious went down at a time when I was busy with enough other
> things that I never bothered moving my repos to a new hosting site.
> Sorry about that.
>
> I've got a copy locally, but I've been editing it heavily, without the
> testing I should have in place, so I hesitate to point you at it right
> now.  (Also, the old version failed to handle things like --no-data
> output, which is important.)  I'll post an updated copy soon; feel
> free to ping me in a week if you haven't heard anything yet.
>
>> I very much like Python. However, more recently I started to
>> write Git tools in Perl as they work out of the box on every
>> machine with Git installed ... and I think Perl can be quite
>> readable if no shortcuts are used :-).
>
> Yeah, when portability matters, perl makes sense.  I thought about
> switching it over, but I'm not sure I want to rewrite 1-2k lines of
> code.  Especially since repo-filtering tools are kind of one-shot by
> nature, and only need to be done by one person of a team, on one
> specific machine, and won't affect daily development thereafter.
> (Also, since I don't depend on any libraries and use only stuff from
> the default python library, it ought to be relatively portable
> anyway.)

FWIW I'd be very happy to have this tool itself included in git.git
if/when it's stable / useful enough, and as you point out the language
doesn't really matter as much as what features it exposes.
