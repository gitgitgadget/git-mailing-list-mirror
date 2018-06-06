Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5CDE1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeFFLYR (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:24:17 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39751 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbeFFLYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:24:16 -0400
Received: by mail-qk0-f195.google.com with SMTP id g14-v6so3647972qkm.6
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pwLUrUy2y3tYGDoQ28gFnjr7LOq3S66pt5cLyfa4GWw=;
        b=JCRlwCbzNut74nBSm2ZcwY8EqCug8cNq2Lto0Vxcm6tuRZ2RwxaJqz0fFQLTiGLvST
         GEtIT8um+WBpRo+7RsETwBXcK7tjyTYkxWSeKevF+El7mcjf8ZPWq0jIH3vh5JOZDK61
         wbhezA0oviJ5ClnbevMnq1jEJ5SwNR8LINku1I7z4xf9F+JikiC4B9JCL0CAz5b20fhS
         gorH77XN9eSVqb17eTtd6q/+4xBIdzDltVMGf9okDj9IYtILllp4siAgCb6eADkK+SoN
         aWy9f1Zu3NJhzuXigQlrmbif4kDfb0phT1u4CVRnkLb87VPy6ItAlz0DFJAQYW4vQCQ5
         +eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pwLUrUy2y3tYGDoQ28gFnjr7LOq3S66pt5cLyfa4GWw=;
        b=kbL+rQPrA2wDDPilFdU2qlDKM8jZ7zMZ9QybbckFhxz9ApWHUqp9chbu/L+Oz23CFK
         B1k0nGN9PY40qbvLxWVnKWqzc3Q8OQeTuF6VTwe6xVpQVoL3jMZE2TrSD0c5tcy0z1vJ
         XbzZGKV8feILod30CiAEdCfx3WRb9ioAwla69MGcAlWfdjuFWaWTlP8xrje5ZAJyu1B9
         VZJqd4tb3lVERgwB/LHqZZDfDT9h86lUvsA0HKAtD2Mkqz5lbg9c7rjVWh0FpPxaSzVc
         QKwwx9ov0vFswe5pNozXKiDUne68MBxrDxBm0uhBOS49EWEwIniQEcdBeonlHYS8lgu8
         zzRg==
X-Gm-Message-State: APt69E3Bh2KyNd38plpFQLUQ105k/LytItaPrGDah8aoiO9PkD2xadJm
        YbQYgF0vHf+4aQf3fxKdk3AUx9bWAXw=
X-Google-Smtp-Source: ADUXVKKNXOff/eMyJUbj11CZXWYqn3K6fGc5ECtC/UM4BSvNNgDeAE6al8ij0mWb83pYZMuTDusH1Q==
X-Received: by 2002:ae9:dec4:: with SMTP id s187-v6mr470212qkf.103.1528284254999;
        Wed, 06 Jun 2018 04:24:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3049:497a:f2dd:f3b2? ([2001:4898:8010:0:197f:497a:f2dd:f3b2])
        by smtp.gmail.com with ESMTPSA id f3-v6sm37327513qtb.51.2018.06.06.04.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 04:24:14 -0700 (PDT)
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, johannes.schindelin@gmx.de,
        jrnieder@gmail.com
References: <20180107181459.222909-1-dstolee@microsoft.com>
 <87k1wtb8a4.fsf@evledraar.gmail.com>
 <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
 <87lgbsz61p.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e8cc9269-39b0-119d-80d6-dc62807fda67@gmail.com>
Date:   Wed, 6 Jun 2018 07:24:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87lgbsz61p.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2018 4:13 AM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Jan 08 2018, Derrick Stolee wrote:
>
>> On 1/7/2018 5:42 PM, Ævar Arnfjörð Bjarmason wrote:
>>> On Sun, Jan 07 2018, Derrick Stolee jotted:
>>>
>>>>       git log --oneline --raw --parents
>>>>
>>>> Num Packs | Before MIDX | After MIDX |  Rel % | 1 pack %
>>>> ----------+-------------+------------+--------+----------
>>>>           1 |     35.64 s |    35.28 s |  -1.0% |   -1.0%
>>>>          24 |     90.81 s |    40.06 s | -55.9% |  +12.4%
>>>>         127 |    257.97 s |    42.25 s | -83.6% |  +18.6%
>>>>
>>>> The last column is the relative difference between the MIDX-enabled repo
>>>> and the single-pack repo. The goal of the MIDX feature is to present the
>>>> ODB as if it was fully repacked, so there is still room for improvement.
>>>>
>>>> Changing the command to
>>>>
>>>>       git log --oneline --raw --parents --abbrev=40
>>>>
>>>> has no observable difference (sub 1% change in all cases). This is likely
>>>> due to the repack I used putting commits and trees in a small number of
>>>> packfiles so the MRU cache workes very well. On more naturally-created
>>>> lists of packfiles, there can be up to 20% improvement on this command.
>>>>
>>>> We are using a version of this patch with an upcoming release of GVFS.
>>>> This feature is particularly important in that space since GVFS performs
>>>> a "prefetch" step that downloads a pack of commits and trees on a daily
>>>> basis. These packfiles are placed in an alternate that is shared by all
>>>> enlistments. Some users have 150+ packfiles and the MRU misses and
>>>> abbreviation computations are significant. Now, GVFS manages the MIDX file
>>>> after adding new prefetch packfiles using the following command:
>>>>
>>>>       git midx --write --update-head --delete-expired --pack-dir=<alt>
>>> (Not a critique of this, just a (stupid) question)
>>>
>>> What's the practical use-case for this feature? Since it doesn't help
>>> with --abbrev=40 the speedup is all in the part that ensures we don't
>>> show an ambiguous SHA-1.
>> The point of including the --abbrev=40 is to point out that object
>> lookups do not get slower with the MIDX feature. Using these "git log"
>> options is a good way to balance object lookups and abbreviations with
>> object parsing and diff machinery.[...]
> [snip]
>
>> [...]And while the public data shape I shared did not show a
>> difference, our private testing of the Windows repository did show a
>> valuable improvement when isolating to object lookups and ignoring
>> abbreviation calculations.
> Replying to this old thread since I see you're prepearing the MIDX for
> submission again and this seemed like the best venue.

You're really good at tracking new commits in my GitHub page ;)

>
> Your WIP branch (github.com/git/derrickstolee/midx/upstream) still only
> references the speedups in abbreviation calculations, but here you
> allude to other improvements. It would be very nice to have some summary
> of that in docs / commit messages when you submit this.

The new version is essentially a complete rewrite of the feature, since 
we learned a lot about how to add a new data store from the commit-graph 
series. The design document [1] refers to some of the immediate benefits 
and future benefits. Some of these future benefits were discussed at the 
contributor's summit [2].

[1] 
https://github.com/derrickstolee/git/blob/midx/upstream/Documentation/technical/midx.txt

[2] 
https://public-inbox.org/git/alpine.DEB.2.20.1803091557510.23109@alexmv-linux/
     Git Merge 2018 Contributor's summit notes (includes discussion of MIDX)

>
> I've been meaning to get around to submitting something like I mentioned
> in https://public-inbox.org/git/87efn0bkls.fsf@evledraar.gmail.com/
> i.e. a way to expand the abbrev mode to not check disambiguations, which
> would look something like:
>
>      core.abbrev = 20
>      core.validateAbbrev = false
>
> Or:
>
>      core.abbrev = +2
>      core.validateAbbrev = false
>
> So, using the example from the above referenced E-Mail +2 would make
> linux.git emit hashes of 14 characters, without any abbreviation
> checking (just trusting in statistics to work in your favor).
>
> As noted by JS in this thread that wouldn't be acceptable for your
> use-case, but there's plenty of people (including me) who'd appreciate
> the speedup without being a 100% sure we're emitting unambiguous hashes,
> since that trade-off is better than time spent generating another index
> on-disk. So I see it as a complimentary & orthogonal feature.
>
> But with that implemented I wouldn't get any benefit from things that
> use the MIDX that aren't abbreviations, so what are those?

The MIDX is built for handling many packfiles. As opposed to the 
commit-graph feature, your repo needs to be _really_big_ to need the 
MIDX. Most just repack into one packfile on a regular basis.

One case for vanilla Git: we've heard from lots of customers disabling 
gc.auto in their build machines because they didn't want to wait for a 
repack/gc after a fetch and before a build. Then, they end up in a 
many-pack situation because they never scheduled time for that repack/gc.

For GVFS, we virtualize the repo, so objects can be downloaded from the 
server on-demand. Since round-trips to the server are expensive, we have 
the notion of a "prefetch pack". Our cache servers precompute packfiles 
containing all of the commits and trees introduced to the server that 
day. On a 'git fetch' command, GVFS intercepts via a hook and downloads 
the list of daily prefetch packs since the last prefetch. These are 
placed in an alternate (the "shared object cache"), so multiple 
enlistments can point to the same, fixed list of packs. The cache 
servers fold these packs together after 30 days, so users on a fresh 
clone start with 31 packs and users who go on vacation for a month get 
at most 31 packs in a single download.

The performance gains from the MIDX for abbrevations are the easiest to 
demonstrate. It's not hard to see why the single binary search to find 
the two closest OIDs is better than iterating through all of the 
packfiles and running a binary search on each.

The other thing that the MIDX does right now is be a single source for 
object lookups. This is harder to demonstrate the benefit in Git on its 
own, because using `git repack -adfF --max-pack-size=128m` repacks in a 
"good" way. This repack actually makes the MRU packfile list really 
effective.

One reason the MIDX is important for object lookups in the GVFS case is 
two-fold:

1. The time-based organization of the prefetch packs makes the trees 
necessary for a 'checkout' spread across many packfiles. Even with the 
working directory virtualization, every 'checkout' needs to recompute 
the .git/index, and that requires walking lots of trees.

2. When we are looking for a blob that is not in the local cache, we 
need to check that the blob is on-disk before requesting it from the 
server. In a many-pack scenario, those object misses are as expensive as 
the abbreviation case. This may affect partial clone, so I'll talk with 
Jeff H about that situation.

I expect to send my v1 today. I'm just trying to create a synthetic 
environment that demonstrates this benefit to object lookups using the 
Linux repository.

Thanks,
-Stolee
