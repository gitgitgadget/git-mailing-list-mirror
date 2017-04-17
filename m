Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F3820A04
	for <e@80x24.org>; Mon, 17 Apr 2017 16:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754153AbdDQQEI (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 12:04:08 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:47026 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbdDQQEH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 12:04:07 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 098Hdgt0Y0Kuv098HdchmG; Mon, 17 Apr 2017 17:04:05 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=Lp9zg0nTe4OWUZIKHbYA:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <5EBADDE444D141918F6873BE8456E026@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Christoph Michelbach" <michelbach94@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <1492287435.14812.2.camel@gmail.com>                         <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>                 <1492347718.19687.14.camel@gmail.com>                 <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>         <1492368692.22852.9.camel@gmail.com>         <DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley> <1492380399.19991.13.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout <tree-ish> clearer
Date:   Mon, 17 Apr 2017 17:04:05 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfPGysSkumGH7bwuvhfXPhWZznXoFkmJ2MfPbtCMpMU91E3m5C1b/41Hm28GW94SRKO/hDy19MWoLfYrA01oZRtBqBdBnBWlIhj58xQVojYo6aoAIZ1Uu
 xHE+tmXBiT/VQBaP04dcJH2fVgzeOQBnAkY0OT/IQGSkD1CEz137W6g7X7owMqMjud+1TLbGAv4CaSTqio1sRan5w/5youIBsHA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Christoph Michelbach" <michelbach94@gmail.com>
> On Sun, 2017-04-16 at 22:25 +0100, Philip Oakley wrote:
>> From: "Christoph Michelbach" <michelbach94@gmail.com>
>> > It's: git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...
>> The one I quoted is direct from the Synopsis, which does indicate
>> there are
>> potentially more aspects to resolve, such as the influence of using
>> the
>> [-p|--patch] options.
>
> Oh, you are right. I didn't even notice the one in the synopsis doesn't
> match the one further down. The one in the synopsis is wrong because
> after removing the optional parameters, it's the same as the first one
> in the synopsis, yet we expect very different behavior from them.
>
>
>> It maybe that the paragraph / sentence that needs adjusting is;
>>
>> 'git checkout' with <paths> or `--patch` is used to restore modified
>> or
>> deleted paths to their original contents from the index or replace
>> paths
>> with the contents from a named <tree-ish> (most often a commit-ish).
>>
>> and split it at the "or replace paths" option to pick out your
>> specific
>> case.
>
> This one is confusing, too: Paths can lead to folders, yet folders whose
> contents have been modified are not restored to their original contents
> when executing that command. Only files are.
>
> After reading the documentation and having never used the command
> before, one would expect
>
>    #!/bin/bash
>    rm -Rf repo
>    mkdir repo
>    cd repo
>    git init &> /dev/null
>    mkdir folder
>    echo a > folder/a
>    git add -A
>    git commit -m "Commit 1." &> /dev/null
>    echo b > folder/b
>    git add -A
>    git commit -m "Commit 2." &> /dev/null
>    echo c > folder/c
>    git add -A
>    git commit -m "Commit 3." &> /dev/null
>    git checkout `git log --pretty=format:%H | tail -1` folder
>    ls folder
>
> to print `a`. However, it prints `a b c` because all of the files inside
> `folder` which have been modified or deleted since (here: none) are
> reset to their original state after the first commit, but `folder`
> itself isn't. Yet, the only path which was passed to the command in
> question is `folder`.
>
> In my opinion, this command needs improved documentation (and the
> synopsis needs to be fixed).
>

I think this example is of a different kind of misunderstanding.

We are at commit 3, with a b c in the working directory and index, and then 
we ask to checkout certain specific files from the first commit 1, which 
contains the file a. That old file is extracted and replaces the file from 
commit 3.

As the file a is identical there is no change and we still have the original 
b and c files from commit c.

I'd guess that the misunderstanding is that you maybe thought that the whole 
directory would be reset to it's old state and the files b and c deleted, 
rather than just the named files present in that old commit being extracted. 
If we'd created and added a file d just before the checkout, what should 
have happened to d, and why?

>

Comming back to the mental model issue with the implicit staging of checked 
out paths, I suspect this is a because we have both a snapshot and a diff 
based mental model. Normally the distinction is natural. We have the 
snapshot from the last commit (or branch checkout) in the index, and then we 
have the two steps for additional changes we personally made, and then added 
added, that determine the diff(s).

However in this (git checkout <treeish> -- <paths>) case we don't get that 
two step option. There is IIUC no 'git copyout <treeish> -- <paths>' which 
simply copies older files into the current worktree without adding it to the 
index/staging area.

The confounding of the, both optional, [--patch] and [<paths>] in the same 
description doesn't make it any easier. Splitting their synopses and 
descriptions may be the way forward.

I also haven't used the --patch option directly so there may be more issues 
beneath the surface.

> --
> Christoph
>
>
--
Philip 

