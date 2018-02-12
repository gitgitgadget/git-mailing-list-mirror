Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFF5A1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 10:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933791AbeBLKVZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 05:21:25 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37517 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933035AbeBLKVX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 05:21:23 -0500
Received: by mail-ot0-f195.google.com with SMTP id e64so13536553ote.4
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 02:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kEzn/FfrClUuLbQu9nM5RL4FkXptLRhA/FgePwAqg38=;
        b=kWNm2DbyKyyYgezMi54dJB8aGsdGGSDbkOXagWJpAk+wHYfWDid1pctdKUJRbzuUrE
         wGuyx77ynxaHjUBFyrR7x/XSTfw4cVn+f1zsdcZhdceiiPS/depPBTnBzfKuXZCsMh8D
         PgHWAwTP1E8LA4vLACTO9mKGMFOFPp9tfTgAcWgfIewr31Tuf7YUfgynqawuWKWl5Rv4
         LAJMwo/JjPRO2y/NkeBadsOU/8YRLdKrMWXKBeNBoMTyjDaITB/M8q1IxU7fdFKy0vDj
         1h+ogmPUoKeoWsNm/y989HrQt9sONG2f/dpIosZFJ++Rg7BnbOGAN84NTPPg/hAV8VHa
         h6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kEzn/FfrClUuLbQu9nM5RL4FkXptLRhA/FgePwAqg38=;
        b=qnhF5K2BdOAH44j+A+68GrhSgyjq8DEDMJu98AvxhTjI4LHnRbx3lB9WluUd1QXrqj
         oUYnIrlEU3eRPqk6QLoJr8BAbg4LC74q963Y8yRZ/AEtEYUmtH6VQfGCqyPybluatAWj
         mGSt7gU41fnnd4IqkERKYWBpCPztiwbXwh3dQPGUoeEkF+Owu3ICviBSQROsIcNhNYYl
         vdHnHdfQgufhlxVOkBNs+OTbxKDPzzGY0kYO5Jo7bEUD/IrSfmn460nAAFqUmafiPLcq
         OtZHlThehunNa7JhiOQUktdX0Ef3ifDmn4MRVXPcFeBqdI8zPhxGKbBta6vYjosaqH6R
         EJhw==
X-Gm-Message-State: APf1xPBUAzi9PwrXI9lRorS0xOOAPsCFafzSlWFBN9h9RbjjN+txZHoM
        S3gwU/kGqPU3CY+HpH5L/jbdDbqUiWjTIEPjflw=
X-Google-Smtp-Source: AH8x227Q9RnWJHuNu539l9NuLRfuAzi9w/CTA9HQrdDOSXkGUTqFIWIE7mYioX3u5praXtU15nEWVlSg22OLwePfFfU=
X-Received: by 10.157.53.5 with SMTP id o5mr8087056otc.181.1518430882473; Mon,
 12 Feb 2018 02:21:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 12 Feb 2018 02:20:52 -0800 (PST)
In-Reply-To: <0039c71c-cefd-4950-aa7c-ffbb7cf66e49@gmail.com>
References: <20180205195619.31064-1-benpeart@microsoft.com>
 <20180205215805.GA90084@google.com> <6fb43664-7546-7865-0488-8ed6292d77a6@gmail.com>
 <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com> <0039c71c-cefd-4950-aa7c-ffbb7cf66e49@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 12 Feb 2018 17:20:52 +0700
Message-ID: <CACsJy8A2=tWpiBOBxmTLHXm6bvjGCdoDEuJEy7PewvnzEQi2Qg@mail.gmail.com>
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
To:     Ben Peart <peartben@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 9:13 PM, Ben Peart <peartben@gmail.com> wrote:
>
>
> On 2/6/2018 7:27 AM, Duy Nguyen wrote:
>>
>>
>> This is another thing that bugs me. I know you're talking about huge
>> index files, but at what size should we start this sort of
>> optimization? Writing down a few MBs on linux is cheap enough that I
>> won't bother optimizing (and I get my UNTR extension repaired all the
>> time, so reduced lstat calls and stuff). This "typically" only comes
>> at certain size, what size?
>>
>
> It's important to identify what we're trading off here.  With the proposed
> optimization, we'll end up doing less writes of the index but potentially
> more lstat calls.  Even with a small index, writing the index is much more
> expensive than calling lstat on a file.  Exactly how much more expensive
> depends on a lot of variables but even with a SSD its still orders of
> magnitude difference.

Keep in mind it's not just about lstat() calls. Processing ignore
patterns also takes a big chunk of CPU, especially when you have more
than a couple ignore rules.

I'm not convinced that writing index files is that expensive for small
files. I don't know about Windows, with Linux it seems fast to me.
Actually, for small scale repos, performance probably does not differ
much either.

> That means we could potentially lstat hundreds or thousands of files and
> still come out ahead.  Given the untracked cache works at the directory
> level, the lstat cost actually scales with the number of directories that
> have had changes (ie changing a 2nd file in the same directory doesn't add
> any additional cost).  In "typical" workflows, developers don't often change
> hundreds of files across different directories so we'd "typically" still
> come out ahead.

I agree. But we must deal with the bad case when someone
"accidentally" does that. We should not wait until them yell up "it's
too slow now" and tell them to disable/enable untracked cache again.

Another case that could touches a lot of directories over time is
switch trees (e.g. "git checkout master" then "checkout next" or worse
"checkout v1.0").

> We have internal performance tests based on common developer sequences of
> commands (status, edit a file, status, add, status, commit, log, push, etc)
> that show that having the untracked cache turned on actually makes these
> sequences slower.  At the time, we didn't have time to investigate why so we
> just turned off the untracked cache.
>
> When writing the fsmonitor patch series which can utilize the untracked
> cache, I did some investigation into why the untracked cache was slowing
> things down in these tests and discovered the cause was the additional index
> writes.  That is what led to this patch.
>
> I've been sitting on it for months now because I didn't have the time to
> write some performance tests for the git perf framework to demonstrate the
> problem and how this helps solve it.  With the discussion about the
> fsmonitor extension, I thought this might be a good time to send it out
> there.

Hopefully you have time to get some of those numbers :) A patch is
more convincing when it's backed by numbers. And I'm still not
convinced that never ever letting untracked cache be written to the
index again is a right thing to do [1].

> If you have the cycles, time a typical series of commands with and without
> the untracked cache (ie don't just call status over and over in a loop) and
> you should see the same results.  Given my limited time right now, I'm OK
> putting this on the back burner again until a git perf test can be written
> to ensure it actually speeds things up as advertised.

[1] Another case that we must _sometimes_ let untracked cache be
written down is to correct its data. My last invalidation bug, for
example, could leave the untracked cache in a bad state, when you run
with new git then it should be able to correct the data and write
down. But if you don't allow writing down, the new 'git' will keep
seeing the old errors and keep complaining.
-- 
Duy
