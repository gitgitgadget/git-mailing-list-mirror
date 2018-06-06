Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A05D1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 08:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932466AbeFFIN2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 04:13:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33566 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbeFFIN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 04:13:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so20862126wma.0
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WmpB2APppQI2R7wnfjqjMdzvgUliwnfYK1uSLHWi4rs=;
        b=gDJyiMFTVdxZHg62af/gOpf+EYcywEehkzK8iw40SY02JPoOlEnXOlCu4/Jeru63IZ
         AYBoY04KSKc0WQn2PBElvayOismCD0YbMhb6ckDzmFy1v8at4UIasJCD0PQG3Jwrugc9
         aY2cwOE/eyyJDoEZYvMxObwQz6lyB8cCXLurfEI1axxks/tjFOrXxap83Vid43rQzUy/
         EutboJ1zgOlfVqr+duu8l38/nUdTdnEz+//vam/5Fx1Fxw1T+r1AP2MXEnoLqhvakJfg
         HFJZWu8jM93vXdnPucNKiRd/sXQZJ881JTBMNkYhnRz0C1xMESY2sRZiDL0cIlDVT1si
         glZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WmpB2APppQI2R7wnfjqjMdzvgUliwnfYK1uSLHWi4rs=;
        b=p85JUgxSLLWRJzaC+/oIxIqmapSTjaayRn8SRab+yWZxZf/pv3IvlmdgGlYbCFzB3I
         Hc+BBaMu40SBhLhWN0GW0IQhiSom+O6gzjs9TNLT//uRs/wt+rjPlJiT84ge1kg5Bp9/
         8zjvbnkXLQmJ7ZqyFbOjUviSVqUZviO527IAqFuzIBrncA69B8ICJtwHQuqDqbcdeB2X
         q+BvF4AK5FJ2zisnb6CjWzG+GYG8sJBLY/NWRyNxxgM7HrRxt0LsIMsOHq1M6okJ4zF4
         Pj17yAMz27gxo3NdOjsw2sqykgzYwjQoYCwvdzm1B5ILMd4c8VVgQCoUjbtKNF1E5cZX
         P4bQ==
X-Gm-Message-State: APt69E3gdz+6YY1osbwitIYnumQ6FBJyP4l8lhPXBULd1JUBnNw0ruaK
        g26rfOInwQR6NzF4bfLyhU4IiwhS
X-Google-Smtp-Source: ADUXVKL7NvwoiIwaY4ZBsgXmj41frXFeQfqIjrJb3O2Xge2fQR4eZvZdHeU0xDj5Hf/q36aeoqW/NA==
X-Received: by 2002:a50:8bfa:: with SMTP id n55-v6mr2607710edn.216.1528272804478;
        Wed, 06 Jun 2018 01:13:24 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id w1-v6sm30143796edk.7.2018.06.06.01.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 01:13:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, johannes.schindelin@gmx.de,
        jrnieder@gmail.com
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
References: <20180107181459.222909-1-dstolee@microsoft.com> <87k1wtb8a4.fsf@evledraar.gmail.com> <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
Date:   Wed, 06 Jun 2018 10:13:22 +0200
Message-ID: <87lgbsz61p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 08 2018, Derrick Stolee wrote:

> On 1/7/2018 5:42 PM, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Sun, Jan 07 2018, Derrick Stolee jotted:
>>
>>>      git log --oneline --raw --parents
>>>
>>> Num Packs | Before MIDX | After MIDX |  Rel % | 1 pack %
>>> ----------+-------------+------------+--------+----------
>>>          1 |     35.64 s |    35.28 s |  -1.0% |   -1.0%
>>>         24 |     90.81 s |    40.06 s | -55.9% |  +12.4%
>>>        127 |    257.97 s |    42.25 s | -83.6% |  +18.6%
>>>
>>> The last column is the relative difference between the MIDX-enabled repo
>>> and the single-pack repo. The goal of the MIDX feature is to present the
>>> ODB as if it was fully repacked, so there is still room for improvement.
>>>
>>> Changing the command to
>>>
>>>      git log --oneline --raw --parents --abbrev=40
>>>
>>> has no observable difference (sub 1% change in all cases). This is likely
>>> due to the repack I used putting commits and trees in a small number of
>>> packfiles so the MRU cache workes very well. On more naturally-created
>>> lists of packfiles, there can be up to 20% improvement on this command.
>>>
>>> We are using a version of this patch with an upcoming release of GVFS.
>>> This feature is particularly important in that space since GVFS performs
>>> a "prefetch" step that downloads a pack of commits and trees on a daily
>>> basis. These packfiles are placed in an alternate that is shared by all
>>> enlistments. Some users have 150+ packfiles and the MRU misses and
>>> abbreviation computations are significant. Now, GVFS manages the MIDX file
>>> after adding new prefetch packfiles using the following command:
>>>
>>>      git midx --write --update-head --delete-expired --pack-dir=<alt>
>>
>> (Not a critique of this, just a (stupid) question)
>>
>> What's the practical use-case for this feature? Since it doesn't help
>> with --abbrev=40 the speedup is all in the part that ensures we don't
>> show an ambiguous SHA-1.
>
> The point of including the --abbrev=40 is to point out that object
> lookups do not get slower with the MIDX feature. Using these "git log"
> options is a good way to balance object lookups and abbreviations with
> object parsing and diff machinery.[...]

[snip]

> [...]And while the public data shape I shared did not show a
> difference, our private testing of the Windows repository did show a
> valuable improvement when isolating to object lookups and ignoring
> abbreviation calculations.

Replying to this old thread since I see you're prepearing the MIDX for
submission again and this seemed like the best venue.

Your WIP branch (github.com/git/derrickstolee/midx/upstream) still only
references the speedups in abbreviation calculations, but here you
allude to other improvements. It would be very nice to have some summary
of that in docs / commit messages when you submit this.

I've been meaning to get around to submitting something like I mentioned
in https://public-inbox.org/git/87efn0bkls.fsf@evledraar.gmail.com/
i.e. a way to expand the abbrev mode to not check disambiguations, which
would look something like:

    core.abbrev = 20
    core.validateAbbrev = false

Or:

    core.abbrev = +2
    core.validateAbbrev = false

So, using the example from the above referenced E-Mail +2 would make
linux.git emit hashes of 14 characters, without any abbreviation
checking (just trusting in statistics to work in your favor).

As noted by JS in this thread that wouldn't be acceptable for your
use-case, but there's plenty of people (including me) who'd appreciate
the speedup without being a 100% sure we're emitting unambiguous hashes,
since that trade-off is better than time spent generating another index
on-disk. So I see it as a complimentary & orthogonal feature.

But with that implemented I wouldn't get any benefit from things that
use the MIDX that aren't abbreviations, so what are those?

>> The reason we do that at all is because it makes for a prettier UI.
>
> We tried setting core.abbrev=40 on GVFS enlistments to speed up
> performance and the users rebelled against the hideous output. They
> would rather have slower speeds than long hashes.
>
>> Are there things that both want the pretty SHA-1 and also care about the
>> throughput? I'd have expected machine parsing to just use
>> --no-abbrev-commit.
>
> The --raw flag outputs blob hashes, so the --abbrev=40 covers all hashes.
>
>> If something cares about both throughput and e.g. is saving the
>> abbreviated SHA-1s isn't it better off picking some arbitrary size
>> (e.g. --abbrev=20), after all the default abbreviation is going to show
>> something as small as possible, which may soon become ambigous after the
>> next commit.
>
> Unfortunately, with the way the abbreviation algorithms work, using
> --abbrev=20 will have similar performance problems because you still
> need to inspect all packfiles to ensure there isn't a collision in the
> first 20 hex characters.
>
> Thanks,
> -Stolee
