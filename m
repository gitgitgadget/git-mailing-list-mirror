Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4B831F462
	for <e@80x24.org>; Fri, 26 Apr 2019 12:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfDZMGL (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 08:06:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41142 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfDZMGL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 08:06:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so1622626pfd.8
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ybur98gM39SUafyZXFxnQTtietkum9F4SR+eDoUUrxM=;
        b=DkcTFdQM4taBtRxuiMNJf+yueoEpR0VehuscdgtWUxVkxbxQgU8kzeiko6CrbF6WC+
         t2ynhIGDWjFh8va2QRjnRGBmAfB/UIfWk5ZKhQWJiMSrdMR2CeieGb0Ss8w8Bpsw7VQL
         GGE/P5s4H826WQMl0dwtMpTkcTcH/K6oLuCmzDXD3RCHbbhYxKoUdRxt32MNIQFtIKsC
         3ltqjPQS8JUgeXNAVMMQQmq9pl5wJvr70tHQp83mQ1AJFP1irFMkGuGWWr+LubzJbz+w
         3ymKK0aR2ouFg0vhzUHDzfAXJCmfyuXwoLebzdCDA6d9PTTu6BRdMGS4YLGyGvZUwXXh
         kvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ybur98gM39SUafyZXFxnQTtietkum9F4SR+eDoUUrxM=;
        b=dYxAwTCIUj0P3FNyzGs6BSbFCvvKim98cAjH1zXcL2G3J/Sbyz8D7KGcfBxpmkzQ6e
         sFxyUWfgJiT+LVzzipTJiUT98Qth67caqL8GXCEpLNAUGFLUjhKM3XM+tGmZzcT2uD9d
         Xdm6DXwUmFty8MV9LJKKLKmvFi7i/Hgufoy+1sawukAoQHZwC5fdCC7WA9Rv+YnFtaPx
         pnyivsvISYXfRA75SS4zbp1UoPuW/2L+e7WTD2+MFAQ5X+XYXIIQIcWtZQb0nNR5Z7Lc
         ZutS7O8hn5EO2mhynZIHUpiv4EL87rp2J+aLp5pP2qIbWCn93ihowce9Ozpo4DcigX5T
         PvWQ==
X-Gm-Message-State: APjAAAWftDxBOUZpjoeaiTKaLc6mQvNC+Yag2FZwdHl7TS1hu8vmem6H
        Pqva4hYLpJnF/1biNSJPzfQ=
X-Google-Smtp-Source: APXvYqyixP5R5v9UrxWJkOXkmlzyCMS+njJ2DTy3+sfTj2ZeMnL08UXPSxJ0CCaTcRoYBDc12L3sRQ==
X-Received: by 2002:a62:292:: with SMTP id 140mr47719209pfc.206.1556280369612;
        Fri, 26 Apr 2019 05:06:09 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:d554:f398:c65:a8b7? ([2001:4898:8010:1:95ea:f398:c65:a8b7])
        by smtp.gmail.com with ESMTPSA id 9sm13631124pgv.5.2019.04.26.05.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 05:06:08 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Create commit-graph file format v2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        Jeff King <peff@peff.net>
References: <pull.112.git.gitgitgadget@gmail.com>
 <pull.112.v2.git.gitgitgadget@gmail.com> <87a7gdspo4.fsf@evledraar.gmail.com>
 <xmqqef5pwldc.fsf@gitster-ct.c.googlers.com>
 <878svxrwsh.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0a8fb6ec-d35c-45d7-3442-0e8298efca4b@gmail.com>
Date:   Fri, 26 Apr 2019 08:06:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <878svxrwsh.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2019 4:33 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Apr 26 2019, Junio C Hamano wrote:
>>
>> Thanks always for your careful review and thoughtful comments, by
>> the way.

I agree that these comments are extremely helpful.

>>> Now as noted in my series we now on 'master' downgrade that to a warning
>>> (along with the rest of the errors):
>>>
>>>     $ ~/g/git/git --exec-path=$PWD status
>>>     error: commit-graph version 2 does not match version 1
>>>     On branch master
>>>     [...]
>>>
>>> ...and this series sets the default version for all new graphs to v2.>>>> The phrasing seems odd.  It is unclear, even to me who is vaguely
>> familiar with the word "commit-graph" and is aware of the fact that
>> the file format is being updated, what
>>
>>     "commit-graph version 2 does not match version 1"
> 
> Yeah it should really say:
> 
>     "commit-graph is of version 2, our maximum supported version is 1"

I agree this phrasing is better. Please see the patch I just submitted [1]
to try and improve these messages.

[1] https://public-inbox.org/git/pull.181.git.gitgitgadget@gmail.com/
 
> Hindsight is 20/20, but more generally I wonder if we should have these
> format versions match that of the git version (unlikely to change it
> twice in the same release...) which would allow us to say things like:
> 
>     "commit-graph needs v2.22.0 or later, we have the version written by v2.18.0..v2.21.0"
> 
> But of course dealing with those larger integers in the code/gaps is
> also messy :)

There are a couple issues with using the version numbers, from my
perspective:

1. We don't do that anywhere else, like the index file.

2. The microsoft/git fork takes certain performance changes faster
   than core git, and frequently ships versions between major version
   updates. Our 2.17 had the commit-graph, for instance. It's also
   possible that we'd take commit-graph v2 earlier than the core Git
   major release.
 
>> wants to say.  Do I have version #2 on disk and the running binary
>> only understands version #1?  Or do I have version #1 on disk and
>> the binary expected version #2?  How would I get out of this
>> situation?  Is it sufficient to do "rm -f .git/info/commit-graph*"
>> and is it safe?
> 
> Yeah. An rm of .git/info/commit-graph is safe, so is "-c
> core.commitGraph=false" as a workaround.

That is true. I'm not sure the error message is the right place to
describe the workaround.

> I'd say "let's improve the error", but that ship has sailed, and we can
> do better than an error here, no matter how it's phrased...
> 
>>> I think this is *way* too aggressive of an upgrade path. If these
>>> patches go into v2.22.0 then git clients on all older versions that grok
>>> the commit graph (IIRC v2.18 and above) will have their git completely
>>> broken if they're in a mixed-git-version environmen.>
> I should note that "all older versions..." here is those that have
> core.commitGraph=true set. More details in 43d3561805 ("commit-graph
> write: don't die if the existing graph is corrupt", 2019-03-25).
> 
>>> Is it really so important to move to v2 right away that we need to risk
>>> those breakages? I think even with my ab/commit-graph-fixes it's still
>>> too annoying (I was mostly trying to fix other stuff...). If only we
>>> could detect "we should make a new graph now" ....
>>
>> True.

You are right, this is too aggressive and I should have known better. I'll
update in the next version to keep a default to v1. Not only do we have this
downgrade risk, there is no actual benefit in this series alone. This only
sets up the ability for other features.
 
> Having slept on my earlier
> https://public-inbox.org/git/87a7gdspo4.fsf@evledraar.gmail.com/ I think
> I see a better way to deal with this than my earlier suggestion that we
> perform some version flip-flop dance on the single "commit-graph" file:
> 
> How about just writing .git/objects/info/commit-graph-v2, and for the
> upcoming plan when where they'll be split have some dir/prefix there
> where we include the version?
> 
> That means that:
> 
>  1. If there's an existing v1 "commit-graph" file we don't write a v2 at
>     that path in v2.22, although we might have some "write v1 (as well
>     as v2?) for old client compat" config where we opt-in to do that.
> 
>  2. By default in v2.22 we read/write a "commit-graph-v2" file,
>     preferring it over the v1 "commit-graph", falling back on earlier
>     versions if it's not there (until gc --auto kicks in on v2.22 and
>     makes a v2 graph).
> 
>  3. If you have concurrent v2.21 and v2.22 clients accessing the repo
>     you might end up generating one commit-graph or the other depending
>     on who happens to trigger "gc --auto".
> 
>     Hopefully that's a non-issue since an out-of-date graph isn't
>     usually a big deal, and client versions mostly march forward. But
>     v2.22 could also learn some "incremental gc" where it says "my v2 is
>     older, v1 client must have refreshed it, I'll refresh mine/both".
> 
>  4. v2.22 and newer versions will have some code in git-gc where we'll
>     eventually readdir() .git/objects/info and remove graphs that are
>     too old per some new config (say
>     "gc.pruneOlderCommitGraphVersions=180 days").
> 
> This means that:
> 
>  A. GOOD: Now and going forward we can fearlessly create new versions of
>     the graph without worrying/testing how older clients deal with it.
> 
>  B. BAD: We are going to eat ~2x the disk space for commit-graphs while
>     such transitions are underway. I think that's fine. They're
>     relatively small compared to .git/objects, and we'll eventually "gc"
>     the old ones.

We could also write 'commit-graph-v2' and delete 'commit-graph' and if
someone downgrades they would just have a performance issue, not a failure.

>  C. BAD: Different versions of git might perform wildly differently (new
>     version slower) since their respective preferred graph versions
>     might have a very different/up-to-date number of commits v.s. what's
>     in the packs.
> 
> I think "A" outweighs "B" && "C" in this case. It's "just" a caching
> data structure, and git works without it. So we can be a lot looser than
> say updating the index/pack format.
> 
> Worst case things slow down but still work, and as noted in #3 above if
> we care it can be mitigated (but I don't, I think we can safely assume
> "client versions march forward").

While I agree that this downgrade path can be a problem, I don't like the
idea of adding a version in the filename. The whole point of having a versioned
file format is so we can make these changes without changing the filename.

Is it sufficient to remove the auto-upgrade path, at least for a few major
versions? And I can learn from past mistakes and change the response to
the other version information in the v2 file (reach index version, hash version,
unused value in 8th byte) and instead make them non-fatal warnings.

Thanks,
-Stolee
