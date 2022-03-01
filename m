Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AEFC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 14:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiCAOT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiCAOTz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 09:19:55 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C2045048
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 06:19:11 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id x193so16401650oix.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 06:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MCSK3JUo6MyduBsJxJbycWz2yO3idb7felqZxGmR08Q=;
        b=Q2CcfH4cxpyyraLmPs3o5Uq8p8REkRmxyUEKdS9aHnzFU+5fJECL5Dov+rtyzf+gHh
         g2JJhlE/GnCp4UppQ3MSPwA/WuDkjY9PBzMULM9NjNeKxARwzsQJ5dED1LQHEvtSVv5V
         TFpHuJ1s1a6Wl+64g2tfgtVU51KZscZ8AMVKkOsGQ3Y/q38xBeYIHHMSMbDZQAcloUph
         GsNa1hhqLRRozLXUVuT0W7xCHbYRLvBP4ZgGsPygxq1PQytyPUOxj8OTtpB7ex5X+l4S
         p6JnhDSBtXnkky1d9G4kEsYYAkM0u1rGaVM01dg66ruZMd8zMIcwsel+ydNiB1wxAUsQ
         XRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MCSK3JUo6MyduBsJxJbycWz2yO3idb7felqZxGmR08Q=;
        b=65KI3O1OsXmtPRZwxwZQjeP4Lu99wuX2gq/hth2i83AJXwdeLtjGCT88r2RFLzMUnm
         1pgkZd6PP5FNniststbs8dd75wLlkOXXhwoUjKlyjEEpfdEz/E5rgU0hQSrBxEn1Jdhq
         Zsl732grUh4imVeyRb7E/Y2yI2ebmfy4XnyCxo7vWddpL3bUqjTULQIkO+bDti0dZLOa
         BD4liLayB9GV2ASOaMp19p5hBzgQRkvyXj3dIwTh718xKaJFG6ynoq9JYqIobFPvUgy+
         QdNu29elyVooiC18VQGBWRzmRkZmur5Pon472fJ5kZ7/rO2WLnDNyYdNkrBJfky34wnr
         E0Cw==
X-Gm-Message-State: AOAM530JnlPeYrZhi/gmdYhyGP0VoPNIbz5FwOdjAmw55rMf0xBg4H4o
        4mXyffYzqpLOUcmXmNGLf3sR
X-Google-Smtp-Source: ABdhPJyCIiOf11ANyEWowZCH3V9kXDEPxwxixmVo1t2gT/lBWHt2NKwbbklD4y2u+c4diMDL9Cem5A==
X-Received: by 2002:a05:6808:19a8:b0:2d5:1d0f:95e3 with SMTP id bj40-20020a05680819a800b002d51d0f95e3mr12873168oib.61.1646144347824;
        Tue, 01 Mar 2022 06:19:07 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bx11-20020a0568081b0b00b002d721fa20f2sm8099573oib.17.2022.03.01.06.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 06:19:07 -0800 (PST)
Message-ID: <9b52fdd3-64fc-34b1-d4ee-660b4fb73f39@github.com>
Date:   Tue, 1 Mar 2022 09:19:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 5/7] commit-graph: document file format v2
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <7f9b65bd22551fd7fd5d2f0bf18aee8c25f1db99.1645735117.git.gitgitgadget@gmail.com>
 <220225.86a6ee7eid.gmgdl@evledraar.gmail.com>
 <d19f5ee8-af92-805f-7ea2-8285862c1123@github.com>
 <220228.86pmn73toq.gmgdl@evledraar.gmail.com>
 <e74d72bc-b6f5-2e1c-63d1-d3a580f3dc11@github.com>
 <220228.86ilsy3a8b.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220228.86ilsy3a8b.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/28/2022 4:14 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Feb 28 2022, Derrick Stolee wrote:
> 
>> On 2/28/2022 9:27 AM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Mon, Feb 28 2022, Derrick Stolee wrote:
>>>
>>>> On 2/25/2022 5:31 PM, Ævar Arnfjörð Bjarmason wrote:
>>
>>>>> Or maybe they won't. I just found it surprising when reviewing this to
>>>>> not find an answer to why that approach wasn't
>>>>> considered.
>>>>
>>>> The point is to create a new format that can be chosen when deployed
>>>> in an environment where older Git versions will not exist (such as
>>>> a Git server). The new version is not chosen by default and instead
>>>> is opt-in through the commitGraph.generationVersion config option.
>>>>
>>>> Perhaps in a year or two we would consider making this the new
>>>> default, but there is no rush to do so.
>>>
>>> Looking into this a bit more I think that in either case this is less of
>>> a big deal after my 43d35618055 (commit-graph write: don't die if the
>>> existing graph is corrupt, 2019-03-25), which came out of some of those
>>> discussions at the time of [1].
>>>
>>> I.e. now a client that only understands version N-1 will warn when
>>> loading it, wheras it's only if a pre-v2.22.0 client (which has that
>>> commit) reads the repository that we'd hard die on it, correct?
>>>
>>> But speaking of hyper-focus. I think that arguably applies to you in
>>> this case when considering the trade-offs of these sorts of format
>>> changes :)
>>>
>>> I.e. you're primarily considering cases of say a git server (presumably
>>> running on GitHub) or another such deployment where it's easy to have
>>> full control over all of your versions "in the wild".
>>
>> I'm thinking of servers, yes, but also 99% of clients who only upgrade
>> (or _maybe_ downgrade to a recent, previous version occasionally).
> 
> *nod*
> 
>>> And thus a three-phase rollout of something like a format change can be
>>> done in a timely and predictable manner.
>>>
>>> But git is used by *a lot* of people in a bunch of different
>>> scenarios. E.g.:
>>>
>>>  * A shared (hopefully read-only) NFS mounted by remote "unmanaged" clients.
>>>  * A tarred-up directory including a .git, which may be transferred to
>>>    a machine with a pre-v2.22.0 version.
>>>
>>> Or even softer cases of failure, such as:
>>>
>>>  * A cronjob causes an alert/incident somewhere because the server 
>>>    operator started writing a new version, but forgot about a set
>>>    of machines that are still on the old version.
>>
>> It is important to continue supporting these cases, and this change does
>> not cause any issues for them.
> 
> The issues in those cases will range from warnings on older versions
> when loading the graph to errors if it's pre-v2.22.0, with the
> performance benefits v3 placing them out of range of v2-only clients.
> 
> I think arguable that's OK/worth it, but it's "not [any] issues", no?

What I mean is that this change does not enable the new graph version
by default, so these users do not have any issues unless someone opts
in to the feature while in this mixed scenario.

>> However, this handful of corner cases should not block progress in the
>> main cases.
> 
> What progress would be blocked?
> 
> I'm only talking about whether we choose to consider a "new graph" to be an:
> 
>     <existing version number>
>     <existing chunk name (old content, possibly empty)>
>     <new chunk name (new content)>
> 
> v.s.:
> 
>     <old/new version number>
>     <existing chunk name old/new (incompatible) content>
> 
> I.e. the "progress" this series is about is in getting the data locality
> with smaller data with the new content.
> 
> But that's also possible to get with a very low amount of fixed-overhead.
> 
> Per the referenced E-Mail an "empty" commit-graph file was ~1k bytes in
> 2019, I haven't re-checked. In terms of wasted space it's miniscule &
> <1/4 of one FS page on Linux.

If you're talking "empty" data, then you need to have an empty Commit
Data chunk _and_ and empty OID Lookup chunk in order to not have
breakage. So you'd need duplicate versions of these chunks for the
new "Commit Data 2" chunk. Then we need special-casing for all of this
during parsing that is unnecessary complexity.

Finally, the end result becomes "older versions get slower without
any warning" instead of "older versions get a message about not
understanding the commit-graph file".
 
> I'm not just trying to rehash the same points, I *think* the version
> bump is just an aesthetic choice & we're not getting any performance
> difference out of that.
> 
> But I'm not sure from the "block progress" etc., so maybe I'm still
> missing something...

The fact that we have a Generation Data chunk instead of already
bumping the file format version number is already a concession to
this concern about backwards compatibility.

With the point above about empty Commit Data Chunks, the only way
to properly conserve backwards compatibility is to have a full
Commit Data Chunk as well as a second copy that contains the new
offsets instead of topological levels. This is wasteful.

>>> I think that even if it's less conceptually clean it's worth considering
>>> being over backwards to be kinder to such use-cases, unless it's really
>>> required for other reasons to break such in-the-wild use-cases.
>>>
>>> Or in this case, if it's thought to be worth it to help reviewers decide
>>> by separating the performance improvement aspect from the changed
>>> interaction between new graphs and older clients.
>>>
>>> As a further nit on the proposed end-state here: Do I understand it
>>> correctly that commitGraph.generationVersion=[1|2] (i.e. on current
>>> "master") will always result in a file that's compatible with older
>>> versions, since the only thing "v2" there controls now is to write the
>>> optional GDAT and GDOV chunks?
>>>
>>> Whereas going from commitGraph.generationVersion=2 to
>>> commitGraph.generationVersion=3 in this series will impact older clients
>>> as noted above, since we're bumping the version (of the file, to 2 if
>>> the config is 3, which as Junio noted is a bit confusing).
>>>
>>> I think if you're set on going down the path of bumping the top-level
>>> version that deserves to be made much clearer in the added
>>> documentation. Right now the only hint to that is a passing mention that
>>> for v3:
>>>
>>>     [it] will be incompatible with some old versions of Git
>>>
>>> Which if we're opting for breaking format changes really should note
>>> some of the caveats above, that pre-v2.22.0 hard-dies, and probably
>>> describe "some old versions of Git" a bit more clearly.
>>>
>>> It actually means once this gets released "the git version that was the
>>> latest one you could download yesterday". Which a reader of the docs
>>> probably won't expect when starting to play with this in mixed-version
>>> environment.
>>>
>>> 1. https://lore.kernel.org/git/87h8acivkh.fsf@evledraar.gmail.com/
>>
>> This documentation could be altered to be specific about versions,
>> but such a specific change makes assumptions of the version that will
>> include it. As of now, the generation number v2 fixes will _probably_
>> get in for 2.36 and the format change would have enough time to cook
>> for 2.37, so I'll update the docs to refer to that version explicitly.
> 
> ...
> 
>> The pre-2.22.0 change might be helpful to mention, but it could also be
>> noise to the reader. We can revisit this when these patches are
>> submitted again in another thread. There's also concern about third-
>> party tools like libgit2. I'd rather draw the line as "tread carefully
>> here" than "here is so much information that a reader might think it
>> is all they need to know".
> 
> In terms of concern about libgit2 or any other implementation (which I
> haven't looked at) isn't "tread carefully" to do it with new chunks if
> possible, which we've done before with BIDX/BDAT, v.s. a version bump we
> haven't done?

New chunks adding new information is part of the design. Changing
the location of existing data is new here.

> I'd think it wouldn't be an issue either way for any reader of the
> format, and libgit2 is more specialized & won't have someone on RHEL6 or
> whatever trying to inspect a random repo.
> 
> It just seems like a win-win to have a performance improvement with
> smooth backwards compatibility v.s. without, if that's possible.

You are right that it is _possible_, but I don't think that the
side-effects are worth it. Those being:

* "Empty CDAT Chunk": Silently slowing down older clients.
* "Duplicate CDAT Chunk": Wasted data.

Finally, I want to reiterate that by making this opt-in, users make
the call about whether or not they are in a scenario where this
compatibility issue is appropriate for them. This includes waiting
to see if third-party tools like libgit2 are updated to understand
this version.

Thanks,
-Stolee
