Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D051F404
	for <e@80x24.org>; Tue, 20 Mar 2018 01:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750945AbeCTBcn (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 21:32:43 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35624 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeCTBcl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 21:32:41 -0400
Received: by mail-qt0-f170.google.com with SMTP id s2so23675qti.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 18:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ets9vCNtu3I68BrpzxSqfc3/HLC3OsMGTr3bw90KzW4=;
        b=Mn08i6xAMU/CR8yXkLox16W/AbxCV0n//U5JIKZMwS0WINjWgIPUWqSuONIt52WbqN
         IRhigAex2K0Xs26a+PR1rIc2+saZDd8pYl2T6qf/CQIXIS2TyIXSl/EPl7+DoFsM0pyr
         pa7Oh0scDMuQUwkMxIGQsScR8DvithFryhx+l6SIrclnOjEwHvwoS5SK22XJargIzwIt
         JTFXp4VU9SEQDPGaTZmiJMKu6orJ0RaJWJvlXpiltcyvNtjx9CI/IPX0L/d+OmkkcBpI
         YE5BiSQcXVNttJi4iPB6LxzJfUTZSrrZPCaTCluaDJnzlLOda39ifzFqrqPeTfkLsMZI
         RvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ets9vCNtu3I68BrpzxSqfc3/HLC3OsMGTr3bw90KzW4=;
        b=awosoFfmKbdSE2GRW/BAcjA9RbrzHa5AtyzQY9ozVm9Bxxoxo6kbptmj2jDhzY2xCc
         o0m6fFCESdM/KZA/z3NjzSpOSLTwz6x6jwm9ekUa422HED0vZS4tgQIlYu95sBY9kD0U
         NhDXcBqmJgYUrRZeN1h6la284HyzyGoSCsDFIgCpmmsByhnrK+GP3+mszreaG9FcfPls
         ElpRemEqilHaP8dhV2sKje0VAjESS2SIg4Kkqsn+nkY/BqKg+zNcUtd7yyPtn7nWIK7g
         6yGBqPWQ2hHsEF9HCSE+Mn19k7lcXR0bzL6xGeRUhtRgBtuA6Wi+4WmfpUCCuGqk/brZ
         c+1g==
X-Gm-Message-State: AElRT7GgG8vH53SJktIvzhpT5SS727kSWV2flgbXEyqojpisv83tf7ax
        Iw4qg6NexuH536PhYNBliF4RSNNYAVA=
X-Google-Smtp-Source: AG47ELuS19MzYgIfrUsLkP7j2IENqkvCr7GZEFeG0zMJQtH8LHRiK1nzixP1FsT0f2BProakSfJ7Iw==
X-Received: by 10.200.23.152 with SMTP id o24mr21982510qtj.255.1521509560819;
        Mon, 19 Mar 2018 18:32:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id h129sm933336qke.31.2018.03.19.18.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 18:32:37 -0700 (PDT)
Subject: Re: How to debug a "git merge"?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <7895279B-9FB6-471B-A8BA-53315B265A51@gmail.com>
 <ddde09e9-0524-23f8-3585-ac00c2ec7f45@gmail.com>
 <77D50EDA-6262-4288-B6E7-87BE63EFB54F@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b852dc0d-f601-f36a-c996-b3395a3cb3fd@gmail.com>
Date:   Mon, 19 Mar 2018 21:32:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <77D50EDA-6262-4288-B6E7-87BE63EFB54F@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2018 4:53 PM, Lars Schneider wrote:
>> On 14 Mar 2018, at 18:02, Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 3/14/2018 12:56 PM, Lars Schneider wrote:
>>> Hi,
>>>
>>> I am investigating a Git merge (a86dd40fe) in which an older version of
>>> a file won over the newer version. I try to understand why this is the
>>> case. I can reproduce the merge with the following commands:
>>> $ git checkout -b test a02fa3303
>>> $ GIT_MERGE_VERBOSITY=5 git merge --verbose c1b82995c
>>>
>>> The merge actually generates a merge conflict but not for my
>>> problematic file. The common ancestor of the two parents (merge base)
>>> is b91161554.
>>>
>>> The merge graph is not pretty (the committers don't have a clean
>>> branching scheme) but I cannot spot a problem between the merge commit
>>> and the common ancestor:
>>> $ git log --graph --oneline a86dd40fe
>> Have you tried `git log --graph --oneline --simplify-merges -- path` to see what changes and merges involved the file? I find that view to be very helpful (while the default history simplification can hide things). In particular, if there was a change that was reverted in one side and not another, we could find out.
> Thanks for this tip! Unfortunately, this only confirms my current view:
>
> ### First parent
> $ git log --graph --oneline --simplify-merges a02fa3303 -- path/to/problem
> * 4e47a10c7 <-- old version
> * 01f01f61c
>
> ### Second parent
> $ git log --graph --oneline --simplify-merges c1b82995c -- path/to/problem
> * 590e52ed1 <-- new version
> * 8e598828d
> * ad4e9034b
> * 4e47a10c7
> * 01f01f61c
>
> ### Merge
> $ git log --graph --oneline --simplify-merges a86dd40fe -- path/to/problem
> *   a86dd40fe <-- old version ?!?! That's the problem!
> |\
> | * 590e52ed1 <-- new version
> | * 8e598828d
> | * ad4e9034b
> |/
> * 4e47a10c7 <-- old version
> * 01f01f61c
>
>
>> You could also use the "A...B" to check your two commits for merging, and maybe add "--boundary".
> $ git diff --boundary a02fa3303...c1b82995c -- path/to/problem
>
> This looks like the correct diff. The "new version" is mark as +/add/green in the diff.
>
> Does this make any sense to you?
>
> Thank you,
> Lars

I'm sorry for the delay on this, but in my experience in helping 
customers saying "why doesn't my commit/change appear in the history of 
a file?" is because someone resolved merge conflicts by just taking one 
side instead of doing a real merge (such as using -Xours). The only 
solution is to re-apply the original change again and talk to the user 
who incorrectly merged, to prevent future occurrences. These things 
rarely happen to teams who use pull requests that require review, since 
the diff would be problematic. There are still a lot of teams that push 
directly to master, though.

Thanks,
-Stolee
