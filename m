Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4C31F42D
	for <e@80x24.org>; Sun, 27 May 2018 16:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032754AbeE0QID (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 12:08:03 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:48681 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032736AbeE0QIC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 12:08:02 -0400
Received: from [192.168.2.240] ([92.22.19.205])
        by smtp.talktalk.net with SMTP
        id MyD9feoTPpXFjMyD9fvunA; Sun, 27 May 2018 17:08:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1527437280;
        bh=oCn3dh31thiXiBlBrI00oLYN5A5beGiT1+GjLXDz9l8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j4rvAsiiUFHE2xyp0KPzNwih8/j3Tb2YClKZoNaYdL1S7SyaWwQwr1d/ezzN8S8lK
         sBW07rd65yHOlNZQwMMVN3Ibk78RcHqqaBGYgIBnhd8vB7HOC31MzIZEn3+7Pby+tN
         HyNchK1wcQH2MTx/cS6iw0KpnMKycBSO+CFZWgcw=
X-Originating-IP: [92.22.19.205]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=GrkxPNsFMMDsGvZg/+sIFg==:117
 a=GrkxPNsFMMDsGvZg/+sIFg==:17 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8
 a=pGLkceISAAAA:8 a=GVIDC26iTaZGrORYYkAA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rebase -i --exec and changing directory
To:     =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org
References: <CAAUqJDu_3DTyd1cFKaNRKOzo3AHosfxP1jjWpa=HGtyAyitTeA@mail.gmail.com>
 <CAAUqJDvsRBJWZh5_A2e2x-CqgXi5gLSjo6-P2sYxsKz3qfidSw@mail.gmail.com>
 <1EAAF778D73B4AA689ADB5AE2EE9D1DD@PhilipOakley>
 <CAAUqJDvCgXPubhtSKzMLqTU5au320U15UQ8Lst7+JeZYBp8wTA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <3465c994-3917-cd45-bb8e-d1121f60bfb4@talktalk.net>
Date:   Sun, 27 May 2018 17:07:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAAUqJDvCgXPubhtSKzMLqTU5au320U15UQ8Lst7+JeZYBp8wTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfG7dnJLmm7+ciQOdJqYBy8u55aL6ObbmtpQFWNfAacgrgbK86IdIFGgB6qKMRHjVURhdzgZPMEJYyH/cpG1KnuNhTQlmW0uSjvoLkP3iQAnakiJCXUB3
 D0HSQZip61O94bPk8RNk7v2QO9vq8XgNbzaNNcx8jVRviOEICBg+uypuftWaA5OacuJ1vDbQ43QgreylLjCHtmHmSOhcj/IrZhYUq1OBTaHBovEJkh0wcrd4
 5NzrR2qbxjNc5JFYQDToTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ondrej

On 27/05/18 13:53, Ondrej Mosnáček wrote:
> 
> Hi Philip,
> 
> 2018-05-27 14:28 GMT+02:00 Philip Oakley <philipoakley@iee.org>:
>> You may need to give a bit more background of things that seem obvious to
>> you.
>> So where is the src directory you are cd'ing to relative to the
>> directory/repository you are creating?
> 
> It is located in the top-level directory of the working tree (in the
> same directory that .git is in).
> 
>  From git-rebase(1):
> 
>      The "exec" command launches the command in a shell (the one
>      specified in $SHELL, or the default shell if $SHELL is not set), so
>      you can use shell features (like "cd", ">", ";" ...). The command is
>      run from the root of the working tree.
> 
> So I need to run 'cd src' if I want to run a command in there
> (regardless of the working directory of the git rebase command
> itself).
> 
>> What is [the name of] the directory you are currently in, etc. ?
> 
> I don't think that is relevant here. FWIW, when verifying the problem
> I ran the reproducer from my original message in a directory whose
> path did not contain any spaces or special characters.
> 
> Did you try to run the reproducing commands I posted? Did you get a
> different result? You should see the following in the output of 'cd
> dir && git status':

I tried your recipe and got the same result as you. However I think it 
could be a problem with 'git status' rather than 'git rebase --exec'. If 
I run your recipe in /tmp/a and do

cd dir
GIT_DIR=/tmp/a/.git git status

I get the same result as when running 'git status' from 'git rebase 
--exec' So I think the problem might have something to do with GIT_DIR 
being set in the environment when 'git status' is run

Best Wishes

Phillip

> 
> [...]
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
> 
>         deleted:    a
>         deleted:    b
>         deleted:    dir/x
>         deleted:    reproduce.sh
> 
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 
>         x
> [...]
> 
> When I drop the 'cd dir && ' from before 'git status', the output is
> as expected:
> 
> You are currently editing a commit while rebasing branch 'master' on '19765db'.
>   (use "git commit --amend" to amend the current commit)
>   (use "git rebase --continue" once you are satisfied with your changes)
> 
> nothing to commit, working tree clean
> 
>>
>> Philip
>> --
>>
>> From: "Ondrej Mosnáček" <omosnacek@gmail.com>
>> Bump? Has anyone had time to look at this?
>>
>> 2018-05-19 18:38 GMT+02:00 Ondrej Mosnáček <omosnacek@gmail.com>:
>>>
>>> Hello,
>>>
>>> I am trying to run a script to edit multiple commits using 'git rebase
>>> -i --exec ...' and I ran into a strange behavior when I run 'cd'
>>> inside the --exec command and subsequently run a git command. For
>>> example, if the command is 'cd src && git status', then git status
>>> reports as if all files in the repository are deleted.
>>>
>>> Example command sequence to reproduce the problem:
>>>
>>>      # Setup:
>>>      touch a
>>>      mkdir dir
>>>      touch dir/x
>>>
>>>      git init .
>>>      git add --all
>>>      git commit -m commit1
>>>      git tag base
>>>      touch b
>>>      git add --all
>>>      git commit -m commit2
>>>
>>>      # Here we go:
>>>      git rebase -i --exec 'cd dir && git status' base
>>>
>>>      # Spawning a sub-shell doesn't help:
>>>      git rebase -i --exec '(cd dir && git status)' base
>>>
>>> Is this expected behavior or did I found a bug? Is there any
>>> workaround, other than cd'ing to the toplevel directory every time I
>>> want to run a git command when I am inside a subdirectory?
>>>
>>> $ git --version
>>> git version 2.17.0
>>>
>>> Thanks,
>>>
>>> Ondrej Mosnacek
>>
>>

