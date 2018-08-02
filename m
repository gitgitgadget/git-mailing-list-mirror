Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D776C1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 21:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbeHBXir (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 19:38:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35061 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbeHBXir (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 19:38:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so1460941edr.2
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 14:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6XP7/HzrOFQeRMnPh2zqeiFywYERLpayt9axmNt8BXE=;
        b=FLQSyEzvkjis4hUad831Nrb5QhGpUAFoNw4WIExBGsmBskUUHZB3YSZfCOLAiDGdPI
         7kasq/BeYyGD1WYsDDFAS2b/SgdBRLPBx2aeYO9KvzgHLbCYnnAsaseO3EcbTn6Llb8S
         8JlCgTE+Ykzpw8w4vTsVOYdR3MshsTkF0iubx+c4uktsut4IM1wtoR5q/OybYLODtM6D
         JIcubgm5fd6yDwJfDbQ5dWfNeN/Spal3PK+CxxO71mXIPgszIfYlPefN2ZQ7/AdFWe9u
         A5QV4bFjei3Vgz0bdk9HLnBOedpPIfyan/qwJeu4fsnziC/M2v3PfrId5Bj7zoA6FJZI
         2rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6XP7/HzrOFQeRMnPh2zqeiFywYERLpayt9axmNt8BXE=;
        b=m3i5ycG8SVsS82jnGir9lbnvhQWQ1aJ727qUDU7jmRsMrrHoaOzfcZ3ew2/iYoQmLG
         5VMv0QrLGW1s1TayhgstPxHkK63BmW5d6UzlY03V1ii7qT+CaKgH22rXIa1jIsdQaw1j
         qD6C5T7V+V1Pp47pGIm9SSpNrBry4zGtLwBU7zImQu90Z9X2j9FnafptXEJyrRdtOzg1
         OFupPaywzndEsfxU7lCxpKqnS4x/kmTUlVtpOhZe1k4cVxUhK9waSIPJ1pad5mXHYmN4
         j2jVZoODr/LnI31WBoVkyWyQ/mkjN9EEncGronIsBR7B8oFcyLm2QF91YfNnK3OQIIHe
         ya4Q==
X-Gm-Message-State: AOUpUlFm/0qdXq7Ybi0G2QmuciF8I28ZpH2u9G2AGZBqFawdwavCljXe
        Yzi/eM75DKiJN58qRfqbG+SmTrWveTg=
X-Google-Smtp-Source: AAOMgpfjFdPcTIa1QqOWmGYiKIxNFiG7Qa9HfHFNibzMCp/bO9FguWIHbuHFjtJfntozeoRMj4HeyA==
X-Received: by 2002:a50:8d19:: with SMTP id s25-v6mr4855537eds.238.1533246343791;
        Thu, 02 Aug 2018 14:45:43 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id c34-v6sm3421482edc.71.2018.08.02.14.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 14:45:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nicolas Palix <npalix@diku.dk>,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more fine-grained
References: <20180723135100.24288-1-szeder.dev@gmail.com> <20180802115522.16107-1-szeder.dev@gmail.com> <20180802180155.GD15984@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180802180155.GD15984@sigill.intra.peff.net>
Date:   Thu, 02 Aug 2018 23:45:42 +0200
Message-ID: <87bmaktpbt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 02 2018, Jeff King wrote:

> On Thu, Aug 02, 2018 at 01:55:22PM +0200, SZEDER Gábor wrote:
>
>> Let's add a bit of Makefile metaprogramming to generate finer-grained
>> make targets applying one semantic patch to only a single source file,
>> and specify these as dependencies of the targets applying one semantic
>> patch to all source files.  This way that shell loop can be avoided,
>> semantic patches will only be applied to changed source files, and the
>> same semantic patch can be applied in parallel to multiple source
>> files.  The only remaining sequential part is aggregating the
>> suggested transformations from the individual targets into a single
>> patch file, which is comparatively cheap (especially since ideally
>> there aren't any suggestions).
>>
>> This change brings spectacular speedup in the scenario described in
>> point (1) above.  When the results of a previous 'make coccicheck' are
>> there, the time needed to run
>>
>>   touch apply.c ; time make -j4 coccicheck
>>
>> went from 3m42s to 1.848s, which is just over 99% speedup, yay!, and
>> 'apply.c' is the second longest source file in our codebase.  In the
>> scenario in point (2), running
>>
>>   touch contrib/coccinelle/array.cocci ; time make -j4 coccicheck
>>
>> went from 56.364s to 35.883s, which is ~36% speedup.
>
> I really like this direction. The slowness of coccicheck is one of the
> things that has prevented me from running it more frequently. And I'm a
> big fan of breaking steps down as much as possible into make targets. It
> lets make do its job (avoiding repeated work and parallelizing).

Yeah, this is great. Also, CC-ing some of the recent contributors to
linux.git's coccinelle, perhaps they're interested / have comments.

>> All the above timings are best-of-five on a machine with 2 physical
>> and 2 logical cores.  I don't have the hardware to bring any numbers
>> for point (3).  The time needed to run 'make -j4 coccicheck' in a
>> clean state didn't change, it's ~3m42s both with and without this
>> patch.
>
> On a 40-core (20+20) machine, doing "make -j40 coccicheck" from scratch
> went from:
>
>   real	1m25.520s
>   user	5m41.492s
>   sys	0m26.776s
>
> to:
>
>   real	0m24.300s
>   user	14m35.084s
>   sys	0m50.108s
>
> I was surprised by the jump in CPU times. Doing "make -j1 coccicheck"
> with your patch results in:
>
>   real	5m34.887s
>   user	5m5.620s
>   sys	0m19.908s
>
> so it's really the parallelizing that seems to be to blame (possibly
> because this CPU boosts from 2.3Ghz to 3.0Ghz, and we're only using 8
> threads in the first example).
>
>>   - [RFC]
>>     With this patch 'make coccicheck's output will look like this
>>     ('make' apparently doesn't iterate over semantic patches in
>>     lexicographical order):
>>
>>       SPATCH commit.cocci              abspath.c
>>       SPATCH commit.cocci              advice.c
>>       <... lots of lines ...>
>>       SPATCH array.cocci               http-walker.c
>>       SPATCH array.cocci               remote-curl.c
>>
>>     which means that the number of lines in the output grows from
>>     "Nr-of-semantic-patches" to "Nr-of-semantic-patches *
>>     Nr-of-source-files".
>
> IMHO this is not really that big a deal. We are doing useful work for
> each line, so to me it's just more eye candy (and it's really satisfying
> to watch it zip by on the 40-core machine ;) ).

FWIW on the 8-cpu box I usually test on this went from 2m30s to 1m50s,
so not a huge improvement in time, but nice to have the per-file
progress.

> What if we inverted the current loop? That is, right now we iterate over
> the cocci patches at the Makefile level, and then for each target we
> iterate over the giant list of source files. Instead, we could teach the
> Makefile to iterate over the source files, with a target for each, and
> then hit each cocci patch inside there.
>
> That would give roughly the same output as a normal build. But moreover,
> I wonder if we could make things faster by actually combining the cocci
> files into a single set of rules to be applied to each source file. That
> would mean invoking spatch 1/8 as much. It does give fewer opportunities
> for "make" to reuse work, but that only matters when the cocci files
> change (which is much less frequent than source files changing).
>
> Doing:
>
>   cat contrib/coccinelle/*.cocci >mega.cocci
>   make -j40 coccicheck COCCI_SEM_PATCHES=mega.cocci
>
> gives me:
>
>   real	0m17.573s
>   user	10m56.724s
>   sys	0m11.548s
>
> And that should show an improvement on more normal-sized systems, too,
> because we really are eliminating some of the startup overhead.
>
> The other obvious downside is that you don't get individual patches for
> each class of transformation. Do we care? Certainly for a routine "make
> coccicheck" I primarily want to know:
>
>   - is there something that needs fixing?
>
>   - give me the patch for all fixes
>
> So I wonder if we'd want to have that be the default, and then perhaps
> optionally give some targets to let people run single scripts (or not;
> they could probably just run spatch themselves).
>
>>   - [RFC]
>>     The overhead of applying a semantic patch to all source files
>>     became larger.  'make coccicheck' currently runs only one shell
>>     process and creates two output files for each semantic patch.
>>     With this patch it will run approx.  "Nr-of-semantic-patches *
>>     Nr-of-source-files" shell processes and create twice as many
>>     output files.
>
> Doing the "one big .cocci" would help with this, too (and again puts us
> in the same ballpark as a compile).
>
>>   - [RFC]
>>     This approach uses $(eval), which we haven't used in any of our
>>     Makefiles yet.  I wonder whether it's portable enough.  And it's
>>     ugly and complicated.
>
> I looked into this a long time ago for another set of Makefile patches I
> was considering. $(eval) was added to GNU make in 3.80, released in
> 2002. Which is probably fine by now.
>
> If it isn't, one more exotic option would be to push the coccicheck
> stuff into its own Makefile, and just run it via recursive make. Then
> anybody doing a vanilla build can do so even with an antique make, but
> you could only "make coccicheck" with something from the last 16 years
> (but good luck getting ocaml running there).
>
> I suspect if we go with the one-spatch-per-source route, though, that we
> could do this just with regular make rules.
>
> -Peff
