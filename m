Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766AD1F42D
	for <e@80x24.org>; Sun, 27 May 2018 17:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032837AbeE0RZN (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 13:25:13 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:26592 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032826AbeE0RZM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 13:25:12 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id MzPkfaGB5bZX5MzPofQXhW; Sun, 27 May 2018 18:25:11 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=xtxXYLxNAAAA:8 a=pGLkceISAAAA:8 a=pn_g1Qv9Q6IsabN1H3gA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <D18E1FF6FF904372AB0343830C751094@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CAAUqJDu_3DTyd1cFKaNRKOzo3AHosfxP1jjWpa=HGtyAyitTeA@mail.gmail.com> <CAAUqJDvsRBJWZh5_A2e2x-CqgXi5gLSjo6-P2sYxsKz3qfidSw@mail.gmail.com> <1EAAF778D73B4AA689ADB5AE2EE9D1DD@PhilipOakley> <CAAUqJDvCgXPubhtSKzMLqTU5au320U15UQ8Lst7+JeZYBp8wTA@mail.gmail.com> <3465c994-3917-cd45-bb8e-d1121f60bfb4@talktalk.net>
Subject: Re: git rebase -i --exec and changing directory
Date:   Sun, 27 May 2018 18:25:03 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=response
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180527-2, 27/05/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfLGqaU3ef5iSUFFKyfxuzk1gHiM1OH8nwJ26Rfv6Y67KWOFqsbqu0tU6ZuEqCuVy7i7lPmyGnF1utUhpFHqe/oNPP/h/gffaRYpOaQWa4mkwg8Et4LqG
 1uvQ4Z9MAw9RUToF7nK4SJelrkwhdsBiZvmujmx1p1iuQGB+SPuX/w+ZKtORzB4IPFAtHARCm2Eq2Z5oQy9ibnYz+ljphBvTyTThwaebOk/Utvrjjo4eph1a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ondrej, Phillip,

From: "Phillip Wood" <phillip.wood@talktalk.net>
> Hi Ondrej
>
> On 27/05/18 13:53, Ondrej Mosnáček wrote:
>>
>> Hi Philip,
>>
>> 2018-05-27 14:28 GMT+02:00 Philip Oakley <philipoakley@iee.org>:
>>> You may need to give a bit more background of things that seem obvious 
>>> to
>>> you.
>>> So where is the src directory you are cd'ing to relative to the
>>> directory/repository you are creating?
>>
>> It is located in the top-level directory of the working tree (in the
>> same directory that .git is in).
>>
>>  From git-rebase(1):
>>
>>      The "exec" command launches the command in a shell (the one
>>      specified in $SHELL, or the default shell if $SHELL is not set), so
>>      you can use shell features (like "cd", ">", ";" ...). The command is
>>      run from the root of the working tree.
>>
>> So I need to run 'cd src' if I want to run a command in there
>> (regardless of the working directory of the git rebase command
>> itself).
>>
>>> What is [the name of] the directory you are currently in, etc. ?
>>
>> I don't think that is relevant here. FWIW, when verifying the problem
>> I ran the reproducer from my original message in a directory whose
>> path did not contain any spaces or special characters.
>>
>> Did you try to run the reproducing commands I posted? Did you get a
>> different result? You should see the following in the output of 'cd
>> dir && git status':

At the time, I hadn't run the command. I was more interested in 
understanding the problem setup, as understanding often brings 
enlightenment.

I was jsut starting to do my own setup and swaw Phillip had responsed which 
prompted me to think it could be that there was no tty attached to the exec, 
so output wasn't being seen (or something like that).

>
> I tried your recipe and got the same result as you. However I think it 
> could be a problem with 'git status' rather than 'git rebase --exec'. If I 
> run your recipe in /tmp/a and do
>
> cd dir
> GIT_DIR=/tmp/a/.git git status
>
> I get the same result as when running 'git status' from 'git 
> rebase --exec' So I think the problem might have something to do with 
> GIT_DIR being set in the environment when 'git status' is run
>

I too got the same same results.
I also tried duplicating the exec line and placing it before the pick line, 
just to check it wasn't an issue about termination. Same result.

> Best Wishes
>
> Phillip
>
>>
>> [...]
>> Changes not staged for commit:
>>   (use "git add/rm <file>..." to update what will be committed)
>>   (use "git checkout -- <file>..." to discard changes in working 
>> directory)
>>
>>         deleted:    a
>>         deleted:    b
>>         deleted:    dir/x
>>         deleted:    reproduce.sh
>>
>> Untracked files:
>>   (use "git add <file>..." to include in what will be committed)
>>
>>         x
>> [...]
>>
>> When I drop the 'cd dir && ' from before 'git status', the output is
>> as expected:
>>
>> You are currently editing a commit while rebasing branch 'master' on 
>> '19765db'.
>>   (use "git commit --amend" to amend the current commit)
>>   (use "git rebase --continue" once you are satisfied with your changes)
>>
>> nothing to commit, working tree clean

So I extended the command to be exec'd to `cd dir && ls && git status`, 
again with duplication of the exec, which then gives a bit more..

finally I extended the status to pipe it's output to a file, again 
duplicated.
--
Philip@PhilipOakley MINGW32 /usr/src/mosnacek (master)

$ git rebase -i --exec 'cd dir && ls && git status >stat.txt' base

Executing: cd dir && ls && git status >stat0.txt

x

Executing: cd dir && ls && git status >stat.txt

stat0.txt x

Successfully rebased and updated refs/heads/master.

--
the stat0, stat files can then be investigated.

Summary: status is, I think, being clever and dropping the verbiage when not 
directly attached to the terminal. (or it is being intelligent and adding a 
lot more status details just because it _is_ within the rebase..)

>>
>>>
>>> Philip
>>> --
>>>
>>> From: "Ondrej Mosnáček" <omosnacek@gmail.com>
>>> Bump? Has anyone had time to look at this?
>>>
>>> 2018-05-19 18:38 GMT+02:00 Ondrej Mosnáček <omosnacek@gmail.com>:
>>>>
>>>> Hello,
>>>>
>>>> I am trying to run a script to edit multiple commits using 'git rebase
>>>> -i --exec ...' and I ran into a strange behavior when I run 'cd'
>>>> inside the --exec command and subsequently run a git command. For
>>>> example, if the command is 'cd src && git status', then git status
>>>> reports as if all files in the repository are deleted.

What does that particular report look like? I see no special report of 
deletions, or additions.


>>>>
>>>> Example command sequence to reproduce the problem:
>>>>
>>>>      # Setup:
>>>>      touch a
>>>>      mkdir dir
>>>>      touch dir/x
>>>>
>>>>      git init .
>>>>      git add --all
>>>>      git commit -m commit1
>>>>      git tag base
>>>>      touch b
>>>>      git add --all
>>>>      git commit -m commit2
>>>>
>>>>      # Here we go:
>>>>      git rebase -i --exec 'cd dir && git status' base
>>>>
>>>>      # Spawning a sub-shell doesn't help:
>>>>      git rebase -i --exec '(cd dir && git status)' base
>>>>
>>>> Is this expected behavior or did I found a bug? Is there any
>>>> workaround, other than cd'ing to the toplevel directory every time I
>>>> want to run a git command when I am inside a subdirectory?

Normally the exec capability is used to run compilation tests and then 
explicitly report errors, rather than be another user interaction. Use 'e' 
edit for that.

>>>>
>>>> $ git --version
>>>> git version 2.17.0
>>>>
--
Philip 

