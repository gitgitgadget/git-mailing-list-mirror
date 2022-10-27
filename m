Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B4FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 16:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiJ0QRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 12:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiJ0QRI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 12:17:08 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81977AC29F
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 09:16:08 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oo5Y3-000BRW-EK;
        Thu, 27 Oct 2022 17:16:07 +0100
Message-ID: <2ed22fa1-4d9d-e50a-18cf-048007272729@iee.email>
Date:   Thu, 27 Oct 2022 17:16:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Git add documentation error
Content-Language: en-GB
To:     Angelo Borsotti <angelo.borsotti@gmail.com>
References: <CAB9Jk9Ay2PPEYKve3DXVmG__yZjO1mgh1MxaKA+wfsF0ZvKRqA@mail.gmail.com>
 <b0008377-2cb5-72ff-e94b-8182065b3436@iee.email>
 <CAB9Jk9BBddd5d0wKFB0eJw1OMMAQj88J9Bn1Yn1rbK_F1mEs1A@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAB9Jk9BBddd5d0wKFB0eJw1OMMAQj88J9Bn1Yn1rbK_F1mEs1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Angelo, please use 'reply all' so others can participate.
Also, in-line replies are preferred.

On 27/10/2022 16:28, Angelo Borsotti wrote:
> Hi,
>
> I have tested this in the following way: I have two files: C1.java and C2.java
>
>     > git status
>     On branch master
>     nothing added to commit
>     > ... edit C2.java
>     > git status
>     On branch master
>     Changes not staged for commit:
>     (use "git add <file>..." to update what will be committed)
>     (use "git restore <file>..." to discard changes in working directory)
>         modified:   C2.java
>      > git add C1.java
>      > git add C2.java
>      > git commit -m "commit2"
>      D:\gittest>git commit -m "commit1"
>      [master 91ef45d] commit1
>      1 file changed, 1 insertion(+), 1 deletion(-)
>
> In commit1 there is only one file, which is C2.java.

It does say "1 file changed", which is true.
What it fails to mention is all the other files that are included within
the commit, but are unchanged.

Maybe have a look at
https://git-scm.com/docs/git-ls-tree#Documentation/git-ls-tree.txt---name-status,
probably with the -r option (check the command's description)

What Git version & OS are you on?
> This is a useful feature: one can stage all its files without
> bothering to remember
> which one had been changed, and then make a commit, and place the commands
> to do it in a script to be used each time a new commit is needed.
>
> -Angelo
>     ...
>
> On Thu, 27 Oct 2022 at 17:10, Philip Oakley <philipoakley@iee.email> wrote:
>> Hi,
>> On 27/10/2022 12:53, Angelo Borsotti wrote:
>>> Hello,
>>>
>>> the reference manual for the "git add" command does not
>>> specify what that command does when applied to an
>>> unmodified file.
>> I presume that this file is already tracked..
>>> By testing this, I have seen that it does not add the file
>>> to the index,
>> How was this tested?
>>
>> If you have no changes, thaen the status diff will have no mention of
>> that file.
>> Perhaps change the tracked mode bits to see if that is noticed (note
>> though, not all mode bits are tracked..)
>>> and consequently it does not add it when a
>>> subsequent commit is done.
>> I suspect this is a subtle mental model misunderstanding about the
>> distinction between a commit as a snapshot, and a commit being reported
>> as the diff relative to its parent (and here, there is none, if the file
>> is unmodified)
>>> I think that this should be documented.
>> A test script with sample output would help here.
>> --
>> Philip
>>
>>

