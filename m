Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66A181F463
	for <e@80x24.org>; Mon, 23 Sep 2019 09:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406950AbfIWJkh (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 05:40:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37183 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406213AbfIWJkh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 05:40:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id f22so1351998wmc.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8LJnCrbXKiCTD4vYUHs87Q0xJ6LXpH6w/jwYWqJXY8U=;
        b=B2y/humt7bN+2B6fZln92BO+o33JFLyylmwAwkHLib4uLgM+RHbddiiD2SsCWqfzJI
         ED6IPRD5Elo0tJtjaXlHOOcGEmN7UmxaeTIdHGimhnN7metgLMm2xoIAz7d6RM9/plQh
         XVozrNK7IOwwSI3Z2MY4tTXNY/Nwj4ZJ1hJBwyLkxzUvtJayDwcz6q0jQU5FQH5no46j
         SObtSp/b36ZLiEfQH3xhorN67aA4lPxoVTApGaDs0NEfvWz8iNWMLhBsjwqgdh69hsOE
         hL52trW2xRvH7okEiBl19Zh0TtPGwY8jupMO7LERP559bjQT52y7z4iF+Tz6qVkgou0S
         xayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8LJnCrbXKiCTD4vYUHs87Q0xJ6LXpH6w/jwYWqJXY8U=;
        b=rv6Yl5rTg3xLtgJSTkf80xASFofZN3ZKCOBb0hf/Jhvy+Sis/2IC/TCKYqmSO9FWV9
         Td1X6c+RWFtc5sbSi1vSRYXfzR8Ig4/FHOkG5dgaD6+gG3b/aSbvyodf8bmW3sKUtmxZ
         oLfFEC8apS59UpQsKCH+8m/LVlO/3ck1PhQ3Cnvdf/hz/gP9TY/fEt1VHL0/n7O7Qpsv
         FXOT8jr78wOyuFQpavf7hVYA8CXDKBdx4CTjJTrQauX72w8YIh/lhLAuhV4xKZVYpFLR
         zlETJReZoEEL73x/kaZtrTzAhrV1xnPxpV+1qyDyeKDPhwvrkXsWzGaKmQDNENlGLq1o
         L+iQ==
X-Gm-Message-State: APjAAAWJmvb9fepfXy5OFGNlSZuojiVEj7wojiBZHgfmDvp5Uj2qcj+u
        KXsR9Wb4fji+7kG/u+8jI/KtxAIP
X-Google-Smtp-Source: APXvYqx7DZwd/UPiVOWX80YVFFzEtSlmO+LmvPR4qq2oSf82CS2XKYrInlIVGyNjK9NATDj2n9DfyQ==
X-Received: by 2002:a1c:1a45:: with SMTP id a66mr12854703wma.102.1569231632601;
        Mon, 23 Sep 2019 02:40:32 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-10-31.as13285.net. [92.22.10.31])
        by smtp.gmail.com with ESMTPSA id b12sm9781236wrt.21.2019.09.23.02.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 02:40:31 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] rebase: introduce --update-branches option
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Warren He <pickydaemon@gmail.com>, git@vger.kernel.org,
        wh109@yahoo.com
References: <nycvar.QRO.7.76.6.1909031345330.46@tvgsbejvaqbjf.bet>
 <20190907234413.1591-1-wh109@yahoo.com>
 <31a37eb1-8a75-40f7-7d1c-a8b7b9d75f92@gmail.com>
 <nycvar.QRO.7.76.6.1909091605540.5377@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6a440f3e-611e-c00d-9b4d-1f7e2fea853e@gmail.com>
Date:   Mon, 23 Sep 2019 10:40:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1909091605540.5377@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On 09/09/2019 15:13, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 9 Sep 2019, Phillip Wood wrote:
> 
>> On 08/09/2019 00:44, Warren He wrote:
>>> Everyone in this thread, thanks for your support and encouragement.
>>> [...]
>>>> It should not really imply `--interactive`, but `--rebase-merges`.
>>>
>>> `imply_interactive` doesn't fully switch on `--interactive`, i.e., causing
>>> the
>>> editor to open. It only selects the backend, which I think we're saying is
>>> the
>>> right thing. I've dropped the `-i` from the test description.
>>>
>>> And we don't really have to imply --rebase-merges, in case someone would
>>> prefer
>>> to linearize things, which who knows? Running that non-rebase-merges command
>>> in
>>> the example scenario from my original post should give something like this:
>>
>> I think it would probably be less confusing to default to preserving merges
> 
> s/preserving/rebasing/?
> 
>> and having an option to turn that off - people are going to be surprised if
>> their history is linearized.
> 
> I don't think it makes any sense to linearize the history while updating
> branches, as the commits will be all jumbled up. Imagine this history:
> 
> 	- A - B - C - D -
> 	    \       /
> 	      E - F
> 
> Typically, it does not elicit any "bug" reports, but this can easily be
> linearized to
> 
> 	- A' - B' - E' - C' - F' -
> 
> In my mind, it makes no sense to update any local branches that pointed
> to C and F to point to C' and F', respectively.
> 

I agree

>> [...]
>>> * * *
>>>
>>> And then there's the discussion about using `exec git branch -f`. To
>>> summarize
>>> the issues collected from the entire thread:
>>>
>>> 1. the changes aren't atomically applied at the end of the rebase
>>> 2. it fails when the branch is checked out in a worktree
>>> 3. it clobbers the branch if anything else updates it during the rebase
>>> 4. the way we prepare the unprefixed branch doesn't work right some exotic
>>> cases
>>> 5. the reflog message it leaves is uninformative
>>>
>>> For #4, I think we've lucked out actually. The `load_ref_decorations`
>>> routine we
>>> use determines that a ref is `DECORATION_REF_LOCAL` under the condition
>>> `starts_with(refname, "refs/heads/")` (log-tree.c:114, add_ref_decoration),
>>> so
>>> `prettify_refname` will find the prefix and skip it. But that's an invariant
>>> maintained by two pieces of code pretty far away from each other.
>>>
>>> For #5, for the convenience of readers, the reflog entry it leaves looks
>>> like this:
>>>
>>> ```
>>> 00873f2 feat-e@{0}: branch: Reset to HEAD
>>> ```
>>>
>>> Not great.
>>>
>>> I haven't made any changes to this yet, but I've thought about what I want.
>>> My
>>> favorite so far is to add a new todo command that just does everything
>>> right. It
>>> would make a temparary ref `refs/rewritten-heads/xxx` (or something), and
>>> update
>>> `refs/heads/xxx` at the end.
>>
>> I think that's the best way to do it. If we had a command like 'branch
>> <branch-name>' that creates a ref to remember the current HEAD and saves the
>> current branch head. Then at the end rebase can update the branches to point
>> to the saved commits if the branch is unchanged. If the rebase is aborted then
>> we don't end up with some branches updated and others not.
> 
> I'd avoid cluttering the space with more commands. For `branch`, for
> example, the natural short command would be `b`, but that already means
> `break`.

We could just not have a short name, after all --update-branch is hardly 
a short alternative

> 
> In contrast, I would think that
> 
> 	label --update-branch my-side-track
> 
> would make for a nicer read than
> 
> 	label my-side-track
> 	branch my-side-track

I agree it would be nice to do both on a single line, my argument was 
mainly against using 'exec branch ...' so that we can defer the branch 
updates until the very end of the rebase. The branch command could set a 
label as well or we could add an option to label I'm not that bothered 
either way at the moment. Another possibility which we probably don't 
want is to have labels starting refs/ imply --update-branch

> Of course, it would be a lot harder to bring back the safety of `git
> update-ref`'s `<old-revision>` safe-guard, in either forms.

Is it that difficult to write the current branch HEAD to a file when we 
label it and then read those back at the end when we update the refs? or 
are you thinking of calling 'git branch' instead of 
ref_transaction_update()? I'm not sure what the advantage of 'git 
branch' is though.

Best Wishes

Phillip

> 
> And of course, the first form would _require_ the logic to be moved to
> `make_script_with_merges()` because we could not otherwise guarantee
> that the labels corresponding to local branch names aren't already in
> use, for different commits.
> 
>> Side Note
>>    I'd avoid creating another worktree local ref refs/rewritten-heads/.
>>    Either store them under refs/rewritten/ or refs/worktree/
> 
> Yep.
> 
> Ciao,
> Dscho
> 
